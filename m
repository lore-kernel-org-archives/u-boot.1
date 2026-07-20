Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F88C44527
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 10:44:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD9D9844F6;
	Mon, 20 Jul 2026 12:44:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="yopzpB7O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1F6F84659; Mon, 20 Jul 2026 12:44:18 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3FF3838D7
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 12:44:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.chung@riscstar.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5b01910b499so3193211e87.0
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 03:44:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784544256; cv=none;
 d=google.com; s=arc-20260327;
 b=Z70neKMTBoHWeOiE3eFV6V3vJdoOoqnZHY9ARPKhRh3XapLgpFz7Ku0NjbxsIViMGB
 ovgG4v8cJtvySNwb1wV2EtS4VBvLDSaTc8KyvTES/nuSmvSQShNq9jGr3l4bzq667ibA
 +49BRC/boPPEON15Mus6QXOyDLXeW8MHPtAglBWssoyF2cvC6jMlb55QoYDqRLAtoEqd
 /297+vt8xhgxyVYg2jhSEfThc39iKe/KRLCZYAEMG0MVO3CHE4eWP3V6Z//RZNSP9ckq
 vLf643zCpY1Voh3rRFw1EV/kfTapZDSqi+yyH6wZThSkW+KVoQdQUmQc+p9cQfRRywB5
 3brA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=N+ZLnDP5WqGl2cqsLdng/JfPCAO4xw5XxXnkCcSE09c=;
 fh=KSgdnvVfSCqgAqFKlBHioI7nYKRFx9oB1SsvMtPwYLs=;
 b=c3DJYaT23GCBhhP/EN99cKU+LiEhRibx6Y1T3KHuETIEBb7Qi7m1krlFqgKVqY2KKl
 VDZdt2M/QxoT42xgDV1B/dmnSGzYDk3/5nmUfDf2wf6mdH48qxEFK6B4Y0RXuaKVOZgU
 KbT+lxtPp4Yt9Y3FDX2A+ouLV4wM/xJeb/kUxcDTe27P97BIen8Deyu4P4cORoqPVEfz
 qjTG0GIDiilMH+5aGtLul+E3orC/5UGc6x1N0dGRtTtUU3gNHHs9hsrDazxGtIIkkhSp
 hf1t2t0dseJMF88uNsaSqi1aFLmNviTVUVhs8u0nh1TG2M39PUjI//eGgNRaTebzwLfL
 YA8g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1784544256; x=1785149056;
 darn=lists.denx.de; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=N+ZLnDP5WqGl2cqsLdng/JfPCAO4xw5XxXnkCcSE09c=;
 b=yopzpB7OQbQAMzOeOoOD/u84Y36KWL9wjAei41JT1vwaXfWXiydlhn8tkqE4Zc2vMy
 SIreiQJ86YwzO15QVALFIsZrFRvcrHleushAgg1tdG7viYwnxUtWSGYu5kZmxYWgEmmv
 mFwOxeERBtQZk6q2vG2Db7Pa5yZUFhJP25ymS+7QV4iB6IAdrQIiDGU3y9C92GMxoEE0
 ix3rQmq/D6UGrWUml47dyvGzcImNb7kCVPeYJDIWgkdgT8zT3wCtQYua8P07zi64Be4z
 FCei86xlt558fJVT0a+0nunWXALFkiVAQK1hA6gYP40CYNLCmsCwaLBd4fJ8OQ+l6/tH
 wgww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784544256; x=1785149056;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=N+ZLnDP5WqGl2cqsLdng/JfPCAO4xw5XxXnkCcSE09c=;
 b=c9E8LdhVP2ZoNt4Z7tDrgDyZM9xBSMx5j2T7j0lJkIZm0caRCg6Hx7YQiJDy7JsdBU
 hO4hYJTQic1z0+s/Y7x4vBbM6R30POwyFORa3tVOZIETXIOpwd3Dh3F3cWGAzldF9rc1
 /E5/qgBBS3HelufOlaMICBzI75PHWH/hVcSQwV0/qKHEuJU0B+UvM4u63clZCvIkfT9Y
 IDiZQJ4jnPX/sbkkX4CW4l+SxCeQIrrS8ax/hSWztThP7CWVgCLu+DHn8jfekjHJx5t6
 3SeT+gSIH9drj4UuBcoFEcVTwTSbGITBEY9UMiw6I7EIdjb8bg2+bWBLbv8Lt2jwf5+c
 SOjw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpce1yzK07SVNBocAC6H41QKPAvUZLE6O1uDCjizDpZNGGFjWxsnqaxr1AMs4Zd5FpYGZb+RS4=@lists.denx.de
X-Gm-Message-State: AOJu0Yz4bgd4f6jdia9EsbyRWW8qJUY9UpfJjbnSQKh7zGEuYwtrf3Yf
 I7zvnaKnw3cvI3jfRucUUax/x/VjtOnpQ1o2r2jgGmwhC0ZVG9+3heoSpfRRTdgvrJrwgB7E/pV
 /rm94LrVuEGtGDyiUWtV/Qt7nDhR2pV9roERGJgqdCg==
X-Gm-Gg: AfdE7cm4WtyOSZ9GSDro/z4WPTcZxOiAF106REu0Gfm1Ahmt9qO8RpUb+Jq1idD3GaH
 nKIWckUadhFe6eM/9RNUN5r8p+ds8OM88EV0dLQbSHRyclGHGVeh9KUPhW6bzWpDut9+JD8XkZZ
 IavDx72NW6nRlG22Gxw/lFhiCIPY7VYkNWJnlp5F0+flIAhyYAd32gZUprq7J3sNlfHhxNfnCN9
 C4yXjzhWEr9dhXVJdk1giZbwgF+JTfUNBSVlPMpTdkrdGG6qBkm/DOHTpTRFv4a3tj/P/y7otMP
 6y6PbY/bQvRjbkehPExagIhwfNT3WT4BIWAfl8L7gP+go1fSMiQ2io0legzkdXtUUipO9w1p7E3
 86QLESZ9PrKfK/XdFXvlCGDcqyAZAIQ==
X-Received: by 2002:a05:6512:39ce:b0:5b1:5f9a:96bf with SMTP id
 2adb3069b0e04-5b28ff7c3e9mr2529660e87.8.1784544256192; Mon, 20 Jul 2026
 03:44:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260707-m4-v4-0-dbd01185f911@riscstar.com>
 <20260707-m4-v4-3-dbd01185f911@riscstar.com> <al0Fk8JyfYhu5b9y@pie>
 <CAH22mJyDMK1-TyaZierfaF88NtgVvKF2Ac3yARBVcgobGQO0-w@mail.gmail.com>
In-Reply-To: <CAH22mJyDMK1-TyaZierfaF88NtgVvKF2Ac3yARBVcgobGQO0-w@mail.gmail.com>
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 20 Jul 2026 18:44:04 +0800
X-Gm-Features: AUfX_myiQ6sVdpOYE_Uv3O1DsyIe63tc11lns7IabqtS063oNuKPIutfK_VIqOY
Message-ID: <CAH22mJx2f1V3JE0Lt4SJY4qh-T9i2i1jGFs3CK1Sbc7H3SxP3g@mail.gmail.com>
Subject: Re: [PATCH v4 03/10] mmc: enable CMD23 for multi-block transfers
To: Yao Zi <me@ziyao.cc>
Cc: u-boot-spacemit@groups.io, u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Han Xu <han.xu@nxp.com>, Yanir Levin <yanir.levin@tandemg.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>,
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>, 
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Angelo Dureghello <angelo@kernel-space.org>, 
 Johan Jonker <jbx6244@gmail.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Guodong Xu <guodong.xu@riscstar.com>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>
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

On Mon, Jul 20, 2026 at 6:42=E2=80=AFPM Eric Chung <eric.chung@riscstar.com=
> wrote:
>
> On Mon, Jul 20, 2026 at 1:13=E2=80=AFAM Yao Zi <me@ziyao.cc> wrote:
> >
> > On Tue, Jul 07, 2026 at 11:21:44PM +0800, Eric Chung wrote:
> > > Enable the support for the CMD23 (SET_BLOCK_COUNT) command to
> > > manage multi-block read/write operations. This allows the MMC
> > > core to use CMD23 in preference to the legacy CMD18/CMD25 plus
> > > CMD12 sequence, reducing command overhead and improving I/O
> > > performance on multi-block transfers.
> >
> > From the description, it seems CMD23 support isn't essential for MMC
> > support on SpacemiT K1? If so, it might be helpful to separate MMC
> > core changes into another series, and focus on basic support only. A
> > smaller series is easier to track and review.
> >
> Actually CMD23 is necessary for Spacemit K1. So I can't split it from
> this series.
>
If I use ADMA mode, CMD23 is required. If I'm using PIO mode, CMD23 isn't
required. So I prefer it go through this series.

If the reason isn't solid, I can split it into another patch set.

Best Regards
Eric
