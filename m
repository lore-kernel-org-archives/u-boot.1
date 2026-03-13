Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A437105F7B8
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 15:22:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A56FA8419D;
	Fri, 13 Mar 2026 16:22:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FHFXqbJT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9C3184370; Fri, 13 Mar 2026 16:22:46 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D996783E16
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 16:22:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b93698bb57aso446892166b.0
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 08:22:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773415364; cv=none;
 d=google.com; s=arc-20240605;
 b=Zag/gR3Rz0E1KOfY7mrv7xcM+ODSNLsFB66GBefMo/K4OLT9jSnwZcxi1WQ9yQTdDw
 CnaZ3Fllvd2HJkMXKlCUugeqmq15NECTny4e+P30i5V2vAo5+QLUdjeK5Sxtsb2w9WhB
 oAOPzQ4qfXg77F9CfOrMIPL6I2TOHdLXmSOKEMZV8t9fjOQEZBLc0AfnOHdKPI2EN3LP
 HS8CS3wVTIRem8PYfH+44pAchCgn2e7dpmMBRipj2Lvm+JlW2RPBSeURpOQTh7vfBeHp
 pwNB/As1m6c83NPHKJTlP/FtAi9wBmnqiqUgnaIhu/L88UCPFS2oJm1Ku0oUikglFTNg
 +f+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fwhvccjLSK4evg3B+d5gG9Wnrg+wbI++gidBx4qXw1c=;
 fh=diyR7YQwRtLrUnWjdh+koJCxSSqH6C/9AL+xdQUdFBg=;
 b=fmby8NljMrAcbTSOJIB0bp4ZJQyL1wcjwoBF3fcSpmjAraAMtehnPoDD6NIaWOgDc0
 zKtDAvLZSNiYG9/yUFDmDlizzP+aulo88L1fip3oYcS7xn8queAEByv9e6y7eG1UeofI
 3QyzUn3F6M1BK1rc47ZXlLOdPJz3GQGFxY0lQ3MP68hUM6cCOoAupOCpG+x913dZkKTg
 zehQzHHV1ljhdL3+ysmlHjBlhcR/fv4uO5SLja9nfyGEKyktlm/Ud9BCe38QgAmrJNGM
 HTiJky9ZbmDNdYGIFVIT1EW6s2O2ROLyXSVM/8DbdCVLctBIBIg3CqdIDseHjhmZ5qI5
 Uitg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773415364; x=1774020164;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fwhvccjLSK4evg3B+d5gG9Wnrg+wbI++gidBx4qXw1c=;
 b=FHFXqbJTuwc9oVL98R2DsOh/F3+D4iHRecGtKx44m4Ia/GQ7Km4+jfUUKsR+p2dHwK
 W89Q7Ci1bowrxTSsqG1h5MADWQNXcHbFmK0OtIJilR2ONF5+GPYCpe/2fUkl1GK42pxm
 RfyqsYuQY93uqdt3YpYuiTxkduUOxOOYkuIRCg7kc5Zpit7+8IU4KshXhzq6TJKdPRbp
 gKKt1i3q7+n2ZQIEPIBXhl6i613T4qFH13B0+EPX98os0F3cGFU5M76ciXe7w9tKeueY
 jgXykGX3oFRi2hREJjGzGCByET+ZaRhowvP9iXwhgUFX6RP3hKztXyZ1fzF+DkXyCymi
 LHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773415364; x=1774020164;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fwhvccjLSK4evg3B+d5gG9Wnrg+wbI++gidBx4qXw1c=;
 b=kFwT/3RVffMBAiNpsUFDlv6QM+Tw6nyNmi55efEmXEgm7o7mxv0PFYdZ+zONGn7fVK
 hQ+nQoDYiCc3RoxTm8WW4ptBeRhvKrq+OZEzNQDQhvD098hU4XTJnn3TPUdqcVyVa4zn
 Rl11C2/BgXVUqm7XpWzcX+NITFwVFCmZRTFv7NK//dGrywT7UXkYzJk99xe9Adu7Eplr
 a+h7RQrbIXwoBOw8qZ4kClp/ThVoTFzLxePngV4HuDTzNA75YyrZtCExQK4Y/spDtiwV
 plUUJqG9ZnigEZSh18XHWFe1LaaXw8nrXnnMloDg09fuT/+8N8BxkqasC0/Vw04YGA+q
 4Diw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjnMaOCyKtNBDzTEQEb0lWN1CLQdi4mqYLaG2mClyVt+94kfIhDhlIkBoK8FzGGNLtBJbQyXc=@lists.denx.de
X-Gm-Message-State: AOJu0Yyt0LRybi462MVfiYPiVyJY2uUWV5+ukyg0VrTN7DjzTWIRtfkh
 KOyPgneqSvXKC1JQE2UOw4zETj05O1WbvqXzSUZwDLbSOkmifC43QH3SnBsoo68FaKr3uupHwlK
 dgFH2gs+F/n30wpJzhyqOY446AXIIEp1fHk0c5IFcFA==
X-Gm-Gg: ATEYQzybc04r1dTeULP8mRqfmWYc6DhCYWoCg/PSugcUy+pH09OXkoD9eKRV6dwx5mO
 xnflewp4MtMOphMDiG9EW1Zye/9hb9W+I2c7IDdgKyy0bfPb9olHj8lzmfB0p/e5pejRe10aK0a
 147/TguLMPlpHtuzBNiAvUZn+EaBueABEw0DsY9mmHr200K9XMe6uvDIWAdCK7bdf5xfF7N/Ds1
 P34immfsKiK8ug0WebVIs2YSCC5tc/8llX7dveP3zQHcKQ+aeOaIXkmMKi/YLXl25rMsHk4JyMe
 f/y91rmDYkzVmjRFDnqvG2FY1IrEizOVlFIdPgj2ipTg9IMuiPty/JudwbLmmWS9W3mqEXXqHpq
 H4QCYrdzktnWGNJRWufR+52Ch6A==
X-Received: by 2002:a17:906:fa14:b0:b93:5ef5:904f with SMTP id
 a640c23a62f3a-b9763a2a5c1mr178225466b.26.1773415364344; Fri, 13 Mar 2026
 08:22:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260310-clk-mtk-parent-cleanup-v1-0-66175ca8f637@baylibre.com>
 <20260310-clk-mtk-parent-cleanup-v1-1-66175ca8f637@baylibre.com>
 <CAEHHSvak-Ebscv7u7STNYOp05o33sUbGsB6bSbhyVrwFu13o+w@mail.gmail.com>
 <e90dde67-8881-4b0e-97a7-e0ec01c502dc@baylibre.com>
In-Reply-To: <e90dde67-8881-4b0e-97a7-e0ec01c502dc@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 13 Mar 2026 16:22:37 +0100
X-Gm-Features: AaiRm50tk90taKnaFvlju-oLuN4XZF4C9_h4bX4Y66hVVzZ2KX8ZgqD3LklZsEg
Message-ID: <CAEHHSvba4zYMjCQw3tYurTFV6MBPoybVLQmPsnaD9UCO7GJ-YA@mail.gmail.com>
Subject: Re: [PATCH 01/16] clk: mediatek: replace xtal2_rate with struct
 mtk_parent
To: David Lechner <dlechner@baylibre.com>
Cc: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Le ven. 13 mars 2026 =C3=A0 16:20, David Lechner <dlechner@baylibre.com> a =
=C3=A9crit :
>
> On 3/13/26 9:49 AM, Julien Stephan wrote:
> > Le mar. 10 mars 2026 =C3=A0 16:34, David Lechner <dlechner@baylibre.com=
> a =C3=A9crit :
> >>
> >> Replace the hard-coded xtal rate for PLL parents with struct mtk_paren=
t.
> >>
> >> This avoids declaring the same clock rate in multiple places and will
> >> allow future drivers to use an arbitrary clock.
> >>
> >> The variable is renamed to something that better indicate what the fie=
ld
> >> is actually used for.
> >>
>
> ...
>
> >> +enum {
> >> +       CLK_PAD_CLK26M,
> >> +};
> >> +
> >
> > Can we define these enum values in a common header?
> > For example, CLK_PAD_CLK26M is defined in various different soc
> > specific drivers.
>
> I would rather not, they depend on which external clocks are available
> on a specific MCU. So they will rarely be the same. As you will see
> in the later patches, more are added and they aren't always the same.
> And the values need to be sequential for the lookup array, so we can't
> have one enum that works for all SoCs.
>
> > Also clk-mt8189.c uses defines instead of enum, so maybe we should
> > stay consistent.
>
> Hmm... I did that one first before I established the pattern. The values
> are arbitrary, which is why I went with the enum here. I can clean that
> up when I apply the patches.
>

Fair enough. In that case, for the whole series

Reviewed-by: Julien Stephan <jstephan@baylibre.com>

> >
> >> +static const ulong ext_clock_rates[] =3D {
> >> +       [CLK_PAD_CLK26M] =3D 26 * MHZ,
> >> +};
> >> +
