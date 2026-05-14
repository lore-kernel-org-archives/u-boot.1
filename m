Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CCF4CD4851
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 07:29:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4BF780F0E;
	Thu, 14 May 2026 09:29:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pJFGJzAV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2D0B8341A; Thu, 14 May 2026 09:29:26 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A2028056B
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 09:29:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-67b6da5a618so11105224a12.2
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 00:29:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778743764; cv=none;
 d=google.com; s=arc-20240605;
 b=UfxhEdsgYaDcaDQl29fWxCsuB/8pMp7gME/y3dbepA+reWSb3w5L8ufZgMMkHDkKaY
 EmZxF2CYf/tRJv25uhbjasrhr2HJcSQWH48FUpH5sAPef/gshI2vCvkC0ySLUj841aPU
 rkg0gNg1BB+b3sBtRPJJ33fHzcNTXsJ32wp8I+Y4sYUZv52cQ2vOejrbUC7mWL7IxDqs
 SIk7bt6bKetMiZdcs2QjrsrrijxaeHb6JM+twdsj3f5pBfIF4p/JN+iIO3GZoQ+llcBX
 E69/ISOiOHfNOzw+H1qbbbmOLVnN9GbQz+MP2IbhH3xVeigjIwobfS1p4Z4CpW/BWymr
 fpcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BYYuX7/fdEP9SU+WtKa5a7lYCgTt+w9EtUGlsgCAv6E=;
 fh=c6xrNUM6L6GajdbrrUxUJaaKoGC6eMG1IQcN1JB3Q9w=;
 b=WO5RELs+lY+0bt6T+tBYUXMeWu1lpio7my0ko2dG3oBOHlRyA60R+khYaPxUogNH4l
 GSCACkOn3nF6uhcAYTUICcUT/v727Rn1A61TrPoW4HocmHhWgpYDBUU1QvEFl9wuwaVi
 g0cDngNHHOJyazS6p1KHdbrAnJellgHO6P47Ob+MFI83q9SQ4Xsb0n+xdVfJmmcfUM/W
 yvu6VGyhqtbI1yvcPP86Hu4QkEK/MmI03kQL8u1zqrLgowIvHSctD9LTDfQ8gPLxSqF3
 t3AsPI0pXSkfm6WLm5AVyjwUHi+tHlvg9Ikef3liDrR5AUl/aOJZcMjeaioMhhpT0Cya
 pUjw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778743764; x=1779348564; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BYYuX7/fdEP9SU+WtKa5a7lYCgTt+w9EtUGlsgCAv6E=;
 b=pJFGJzAVBtU/bXbqAZsjs1WaEc92R8UcphA9IR2JXNVc0pNU2a0Cg4xrPSr++gPPtn
 2dMHwY8V5D/pxbUzl+Wg1XP8bugXFLg2Hm1L+1Q6j86q3jFVOUVr8M6eiJjb5cXoofpE
 QIkDU8ovWS3FMTrnOAyaIAtT+0ecMMo/4ilPP9smIMKMebsthlTo0G0xsqB561uVrKKG
 VmVwhv8tW/NsjXElI5QYbCnJhNuvETAvkERw4CzD3Lgmnw/SFMltXtuxB6Xyje7Gyr6c
 3YTU5CrgB+reRto2Bvyv/J6dYBrbItsF3K3R0tB1VKW2bviLzjyNUSKaWrZBbFBG3zbL
 nEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778743764; x=1779348564;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BYYuX7/fdEP9SU+WtKa5a7lYCgTt+w9EtUGlsgCAv6E=;
 b=H+UlH20CqCYZy6bGlOI2bqrfxoCFYOJXG+CYI1xowN6rUd6P5Q8M+M/jB1ro5NytkP
 zSkiSlxjWXHsId2e3CHt2c+EpDmgCP44QHQDABQqurHbSyrXhAEZwhgXLA8eZA268coj
 VIfFG1Wer2ik6ZsQ4u+Mo94vwzosqCIoq5sfm08UkJv9ADgYtNGQMaKOYWVx37RgKXYb
 sI+NISXr+dXVjDwPPH6MzBAFcyMnTVpRG6IirjO8Cv5BSX4cuGUU8zi95ZlcJB+rabl5
 I8AAbH0sMwz6TvzEUiVlKCb9aB1qjhy032PJAwD5Kpfsyh1cH0JxQ6n38FtX3/uULVQT
 vpOg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9941TklvrUvp148KF/ca+CPTcM0/Uyik/GzieZO7aDLGFjg6phCcGDq5eFCEDd4qK3mLgOufw=@lists.denx.de
X-Gm-Message-State: AOJu0Yxe2he5Bs2GZqqoJYuikmG503x/sYtMERMMcJlrQsIihVAmJ3Uc
 PiA9qKRc1QC0Z0aUBT3/yQC/TAJ0zxVYL2ZDedw6rIayjtyNrfYYyQZAoJ1Iim+9DtRLDqYC7/U
 dP1OVwbqtU5GE9JTS+6DlUeBxsdEhapk=
X-Gm-Gg: Acq92OFHhwldeukLG4p9b6o80dfdsRCamns2mckrdQr0maHDX+VrinV6kWsw8x4V7UN
 J/SvnKe7t9DfG17RjzUSMmLoHNx27paLNvDemdlDHcdGldzM7rTYtixwgHEtEyHur2J0RU5z/mQ
 7Eh7NadABbJU9Lysn96NnPHotRgi8g7JwU0ga/2TKqB5aIld6jWkNtosLtBvuu4cGUblKoTfvVu
 5CKtvJhnHi/3HyzcRqQxtMzkEjVLLbdExytX4v8St0axf/TmnSItGOgSl+T5MT9KubCy4JlgXSI
 P5bpxI09uSCAyfL1irx791/prTVnbEPhkFxpJF4lsiemY4dNorfCl29QscCxw/kLbvFQ3dPGfov
 60lip+niBxEl61gOZFE3tMzZpqUriSwv8sYgRiH30u8Zq1nhi9UF9KhSkw/KHtOAfJbEX2YdIsp
 eA5JEfQAxh/QQ=
X-Received: by 2002:aa7:d9d7:0:b0:67c:5a2e:18b8 with SMTP id
 4fb4d7f45d1cf-68256e5f8e5mr2603619a12.18.1778743763703; Thu, 14 May 2026
 00:29:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAN7C2SCYCwE=BRoeCedqQYjv-Gf6x6ETOdKeeDBE=CG=-rSk9w@mail.gmail.com>
In-Reply-To: <CAN7C2SCYCwE=BRoeCedqQYjv-Gf6x6ETOdKeeDBE=CG=-rSk9w@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 14 May 2026 08:29:10 +0100
X-Gm-Features: AVHnY4LyKs1oitCj-1VYqSECgjyfT_bMTaUjHzswuH_5lZiBZHZcgMbdrgSyVRQ
Message-ID: <CALeDE9PU0-fW_+erR9QHK1ST8fcStx0FWWk_0M8ELjtADugd7Q@mail.gmail.com>
Subject: Re: U-Boot patch submit standard and requirement
To: Sune Brian <briansune@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi Brian,

Can you provide more context?

Peter

On Thu, 14 May 2026 at 03:02, Sune Brian <briansune@gmail.com> wrote:
>
> Hi Tom,
>
> Sorry to bother you.
>
> I am curious that for me myself I had no issue to follow
> the requirements [1] as long as all patches that are
> passing the review stage do follow the rules in [1].
> However based on most recent commits and reviews
> most of those are not even close to what [1] mentioned.
>
> So at the end, reviewers in U-Boot just made their own
> standard and requested contributors to follow?
>
> Rather the U-Boot itself should all follow the docs rules?
>
> [1] https://docs.u-boot.org/en/latest/develop/sending_patches.html#sending-updated-patch-versions
>
> Thanks,
> Brian
