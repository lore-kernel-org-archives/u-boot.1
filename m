Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C43C88E53
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 08:45:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 66BA1605D7;
	Tue, 15 Sep 2026 08:45:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KPqSUNn8HsC1; Tue, 15 Sep 2026 08:45:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 54F0A60721
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789461939;
	b=qmQw5bRUExsWSo4u1by7Oj2agv/ZWRFEnZk2GtWrZfHmOMRBLIc22XzXtfsC2NKj3NDI
	 /w8D0ZshVvzIEKCYHexT/hU7PgYGpV1UBd6sIz4EMAJv9GQ5iCSHBON+bu+fQLVknw3iy
	 lBQOlC/O8orJTVAS1haXMQ53IrkuCf8hdSIlE8wE87fSW0157E/EDNdE9Fuu6f4RCwubL
	 szvNF7Jc2qOwogWPXhsxt4Fh+xd3aASOeN3nahWAXx4IzD390Nc0+j+NlciDOvu7MZ57K
	 UjXzjM7HcgE9zM5zAyJVS2vuVijqZEnX2XG5Uy0s7l7QI6acwzV8nh1eQC3NgmOLjLw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789461939;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=T47/6UB2NkuISe+ocYsKwtjI4i0NS+ZcM3/PzkAGBWE=;
	b=YJZnKXGhoTjxIye4RpIF761SB9CioLLJDFnM+T9Xb7sTo8HocMoE/fQZVF8gUEpdCIsQ
	 ECbRaw6dje0j18XQ6DXAtmLB1qFc5e0k6b5kWjXQN9HBA+OgK8HNInZRWS/v6M7qlmtbh
	 Xab04r93yfj0N/mGigCj/0NkayUoeP38g02J1rYfVkGyKwrrfVC0vXENc4Wk7J6ffSAN+
	 4DGy1qbNhJJTwTD9WOHBxgqt3XGNS/Lo1XM+Q4oafMvhBPBQzoPrMv3ngSoCPPDyRG2hJ
	 f70RNV509+yn29ijRLVWfaNhPqLLA4nEUDvvIeeVBso1GEvIO7D9KfSHA+4p44Uj3QQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="P4/yDoUI";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789461939;
	bh=T47/6UB2NkuISe+ocYsKwtjI4i0NS+ZcM3/PzkAGBWE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xdWzAr7gVJMQj9GwHmXO9ZFmw7BHIbLNRm6EbqJgWVHhGZwJqr/qg005DZsUzGafU
	 djLCPFgxsOvuIL1R8CTpsXU97EFU5eWKeJwSVek+qeP1iRCmugYWZ/lXtzZKx/OjMg
	 1xkbDM4zZ3DpkYQ71vH79CRc42STEaOjB3Kh4hcGNawbgg0xQ/whHIE2H4k95csUXt
	 TQ0LBC6JTxfiNqcdrENswTuoIRNujDnQYJDMM6fenaY7fSRTWl4YwviDJcrMjmklJH
	 HMq2wW455X30hKkKXKzF8590W37ZjRVdDigV1M0O8FuEI24E+kpHznDCPOAQ/09CTy
	 TimLtXGCuvUoQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 54F0A60721;
	Tue, 15 Sep 2026 08:45:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8CD8529B
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 08:45:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 692526072A
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 08:45:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oCfWGgjo0nXa for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 08:45:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4C8D860721
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789461937;
 b=Xf0/KHZwtfkn5R/dBk0WKAbXhSuWofcPH4L8VrFG/C0qZW69DsqQPVAN8jIR+XNaYQO3
 7grLN5fwg6EIcY3GtP7dEttRHqXGnJBemHPEwq8r1ZpBLDjKKYVdKrSSBul8jc3mBbHnI
 fRpK1tC8Tc+s9W5/U3jvNjFuQhQoYJn7jfYbt81XyosEBbTt3Cwco3zaRulE/eMlyz5qY
 AwsTlfWCC5w/bd86kKukLJKBisJ/swC6pftf4f50ua4wk94+APS4IPuQrm6t1HVeI2Y1L
 QN/39EXd0SVTytDVG23QhswKhCbHPRfFPHUpSkO74ainRLAW7rLDvTjFNeHXfYyifqQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789461937;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=T47/6UB2NkuISe+ocYsKwtjI4i0NS+ZcM3/PzkAGBWE=;
 b=FKsR9AtasAg69vPMxtvtK4S3sz/SsS2CAockIpHyZxaX06aQUdhr31EYso55jkLsnAFr
 JjUrkkLkSgal7TRU4LhlLmiisDkznAvEZ1JYLf4DQWX/2Y60J1/sDmz6x4fILJxdxpnF3
 GZcloApc7wF8ZY523KEXMFk2nXc1d8gGrExZQr1F9qAvoekwS5D+aWB0TcUHuceN0YyJD
 5bNLT15RsSQoESuS5vNk+EvKB7dFQkE6egQORGYbghPDAq0TFr7Va7KY1jDieUht2a13i
 WWcyflTXi9OlVw300j6O4h3zmendT/Y2SJDjRGA5I7q8I5jt6M2erR7EwLs3O7OggiQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="P4/yDoUI"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::10; helo=mail-yx2-x10.google.com;
 envelope-from=0xiviel@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=P4/yDoUI
Received: from mail-yx2-x10.google.com (mail-yx2-x10.google.com
 [IPv6:2607:f8b0:4864:41::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4C8D860721
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 08:45:36 +0000 (UTC)
Received: by mail-yx2-x10.google.com with SMTP id
 00721157ae682-85d4ddd17a0so24076027b3.0
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 01:45:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789461936; cv=none;
 d=google.com; s=arc-20260327;
 b=DKcB7bm97g+UiNovD1xQ2HBnhOfWH6XPh/PCJOxOiAVi1l4AB7zHvtawaE/9Q5FmNd
 VMI9Z1M77RYc0SPdXUZz0127VDeBwrTB17hgpM84atQUPX87r0xXDiHKYKsNTKJJl2ON
 t668jL5R0Do705GYuld8hG9RFcvdLwBHZ7fMIRc6xKLfprqU7m/XRhesQqZYgxJmPzb5
 JU2+OOFOtlCciQxRBu/p8zqdaHAkcwvToK3shq4RQ9KEfNod6zUtWrKDgp24FRuVXXt9
 0Q23Bb+XOPWyoNzRLUsWaC0cbYDpJqjG9J10c7mHgjDSlAxCI/whP3kzBF0V+qFJAHD6
 +ihw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=T47/6UB2NkuISe+ocYsKwtjI4i0NS+ZcM3/PzkAGBWE=;
 fh=RyU5V+B+Z/CoJrQup3jxgp2sqkD5yy+Ixn2OEZqM+T0=;
 b=hHl7biNpWY/5JMqSuvEGIRytRJRO5wEUHNmDHwDnBF2TNJ0juaSBXMs8x2h9lh6n2z
 JSf4le0Y/3ra0hkZhBk5hRFJURQ/Jo+WISlawhuh7ETeuJk918IqayUfBqNfpfTGJqTT
 OmmBlKfmom/HdGfVu5RaB9CTuZHJ55mK8YeFTEC/KA6/pbGTU42tIaOtYAf58Lb5WCvq
 8g+7swey33kVeF0zsuswKH18DuRk2rWj6zT5PWgBZFsg7IvDz15U8qCpSjr7ouUkmrjZ
 4yArc2eZybdd13zVHatN/EaxalOZyt0gJy62E2hwSeMfam98wGNUOa1C3/ye0JyeXn2P
 RN5A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789461936; x=1790066736;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=T47/6UB2NkuISe+ocYsKwtjI4i0NS+ZcM3/PzkAGBWE=;
 b=P4/yDoUIzMmJR8VoJaAmLu+1ovJdxMnCkRyHlE1DLYKhVsEdbC2ftBhwRKr9p1mfwy
 BuU0wM/5GpIWrNR5Vca8ummvqztm++n2tdqD842Xmrql2/9AiodlEnoTM5u4odH/ypit
 mGCN+0bXa7ocoRKNA49HB+FG/DqSfOhNqmnHj6C6SRSN5zEDttihBCViSoJZi/WX4Udh
 SwhEsaN4e7OVPab3HP9q19AI6ns+x0Neb3ekNoFiVBJhn3gQPpmEYdUgMnzPH5ECnIzn
 83iZug23U31bUpXo8T50IXjQYaj5+YTwBwyTH7GHq2yKhz1ufBqw4H2+Fl9FMcOUVl3D
 G6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789461936; x=1790066736;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T47/6UB2NkuISe+ocYsKwtjI4i0NS+ZcM3/PzkAGBWE=;
 b=K6hYR0JBwcf7j/1fOCT8BvGbhwwch7bwm3PPYCD5/WAQqA/E7hSkiwIR6wjzwF7Ek2
 ioJsbBJhjqn60yVyxsp76CFlFnc9LHYJBHuU4qAq0xGNZGyfz/rnHWr0vUHkNpSfKJhT
 E/U/QpveWr2rXwblSbMGbfMH4I4ZPnCm+vzcxARlPq+WK5SYueuAPR1SpH0IAkKh3iIx
 wahznitHf2cZ8dIHAj06hMr5QMhHSlKmAQvZJxxrfc9l1F9u+bMbrzDnE2JrU2ZRi4L8
 /dLbBnYwuTuXKWAfAf/7jYHa4D5TkIuoh00KzQcgS0kOEhc5mYZVmR0zPTRlcABKjT/c
 QrHg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzRWEybLQ2drXktIbhOTG9BEB31Pw2uBqFpDVed7zauNjxSazmOVBxgwxm+7BB/W0oR1u1V6rs=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nfGgKeFw9d0olIPHcxXDDq+xyknjGTOZE4l+45oMQ4a/emrnvK
 UFLiI9O7NUlvw0Ag6RSMYp4UwVj/sxq52u2h7i+tvoOtbc0oRGwi3OcVtuWBLZFc6AZlseo7/yI
 5M+BohL4t7fI/qDvL9qNQB4jBhGV13qI=
X-Gm-Gg: AYBFou2fTe/EW2jC5LXm1TWTU30CTxSGqMPteUpuiL2+y1R+5OebZoP2XW5EKIztCgI
 2MCU3fbv5G2fOgnal/s1xIJ6+7j47IFl6SZUht3ka+lAD6ER0KJpny6wNGNxZJk1tMJcOZHgP9N
 ObBmvEda6OZj+CyJZuZgInDCoaaGGdAUTMoOiFErzk5G3Gry5lgSQT9hGrq3q0g2z/AOlU/a4m1
 SdsKbHkPPUWMy8EMj5U02POdAG67fsAHuBhttiCmv17k0Bs1wCdk9pUhgnD4g417JzSlpyX5EcO
 9q9ed7ag+DWxV7NBnDWq/hvTrUzPLhu7az1aXif673JdBX+NcBPSht5NwwRr8gEBgWgh6xiimN3
 mAE91crg6/oWlp36rCy0urENCstY8KF58il/Uncnx6I4xaS/WzZsws6kcAXbkb0cOrBLX7Oe+
X-Received: by 2002:a05:690c:e204:10b0:859:14d0:281d with SMTP id
 00721157ae682-88d227fb6aamr19502917b3.17.1789461935605; Tue, 15 Sep 2026
 01:45:35 -0700 (PDT)
MIME-Version: 1.0
References: <CA+pz=k+hAU5dqbO4GOLJ0fRMRdyrq=kTSnwUc0OcR3r9PotUgg@mail.gmail.com>
 <20260914173412.GD1764417@bill-the-cat>
 <1f194a25-f27f-459f-9b2b-8277457d56a8@siemens.com>
In-Reply-To: <1f194a25-f27f-459f-9b2b-8277457d56a8@siemens.com>
From: Eva Crystal <0xiviel@gmail.com>
Date: Tue, 15 Sep 2026 20:45:23 +1200
X-Gm-Features: AcwNN1Vrda7vwGugeE1EZMUNPYYkQEC9YKPqBRzDTOVh9gzxKpXcyizVO4uL190
Message-ID: <CA+pz=k+SnTLkKyj3uYy4L=wM93tSOD7q=Z_sFmdLQ9xScsGK9Q@mail.gmail.com>
Subject: Re: [SECURITY] FIT signature enforcement fails open when the control
 DTB has no /signature node
To: Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Thanks Ludwig - I hadn't referenced your series in my cover letter,
and I should have.

v8 4/8 does close the configuration side: fit_config_verify_required_keys()
gains FIT_REQUIRE_CONFIG_SIGS and fails closed when no keys with
required=3D'conf' are present.

The case I reported is the other gate. fit_image_verify_required_sigs()
looks up the /signature node in the control DTB and, when it is missing,
sets *no_sigsp =3D 1 and returns 0 with only a debug() message. Every calle=
r
then treats the image as not requiring signatures, so nothing downstream
can fail. As far as I can see from your v8 hunks that path is unchanged.

Two things follow:

- I picked FIT_REQUIRE_CONFIG_SIGS for my Kconfig symbol, which collides
  with yours. I'll rename mine to FIT_REQUIRE_IMAGE_SIGS (plus the SPL
  variant), default off, since the two gates have different blast radius.

- Jonas raised on 4/8 that Rockchip uses FIT_SIGNATURE for image integrity
  only, not signed configurations. An image-side required-signature gate
  hits that setup directly, which is the other reason to keep it a separate
  symbol that is off by default.

I'll rebase on top of your series and resend once v8 lands, rather than
adding a patch to a series that already carries review tags.

Tom, shout if you'd rather see it folded in instead.

Eva

On Tue, Sep 15, 2026 at 8:23=E2=80=AFPM Ludwig Nussel <ludwig.nussel@siemen=
s.com> wrote:
>
> On 9/14/26 19:34, Tom Rini wrote:
> > On Tue, Sep 08, 2026 at 09:27:03AM +1200, Eva Crystal wrote:
> >>
> >> Reporting a fail-open condition in FIT signature enforcement.
> > [...]
> > Hello. Yes, please follow
> > https://docs.u-boot-project.org/en/latest/develop/sending_patches.html
> > and provide a fix and test for this issue, thanks!
>
> https://patchwork.ozlabs.org/project/uboot/patch/20260813080943.v8.4.6d1d=
5d14140677a76a7cd7bb99a9088d8c8f480c@changeid/
>
> cu
> Ludwig
>
> --
> Ludwig Nussel
> Siemens AG
> www.siemens.com
>
