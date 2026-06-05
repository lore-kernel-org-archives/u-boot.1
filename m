Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 017FBCD6E5D
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 05:21:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51D9E84715;
	Fri,  5 Jun 2026 07:21:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YJQlUwMN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0DEB8484F; Fri,  5 Jun 2026 07:21:19 +0200 (CEST)
Received: from mail-yx1-xb136.google.com (mail-yx1-xb136.google.com
 [IPv6:2607:f8b0:4864:20::b136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C601844CF
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 07:21:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-66056b248abso1478950d50.1
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 22:21:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780636875; cv=none;
 d=google.com; s=arc-20240605;
 b=GFa0Nu4Nuor+poUTpAu8WYurjT3xPv0WbbP2anO1MOZLU6wVgy8oyE6jNBlzsZFLBy
 R0eEJA+W/B5QdEj5hhllJxsBCp0wam69JqizflZ4+6yKpHM4Igo5ZOyOMpPGa3cvgnwx
 QbDo/G3SCmhLabUuMuoipV+kPP3Ogitg4MrehnYxyoEartVCcmjcrv5fSA7pYabiO/DN
 f7/IhBRkpouoNxVoR1eJtu6Ly/B/twbIWs+5Ej9fkI64NtYbHYcykdzvUJxMJJhg/kbr
 Rxo+0UXwW0m41kyU3yi+mf9C/87CDjHDIOHBPhZaj+HmdmOo1i8R1g37AUhOYDAH7sU/
 pVkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PdjWV50fJcHUthKByA+7AQxOm4btCc4wVU2NDLiZzd8=;
 fh=lZvpxe62JBHdAB4DGCz/cFUs2hSdjJ4AvYwC0uK9oOQ=;
 b=XSzxqqS0eO7xsSkAJJhR2HDfxf1qp7BJFS4NtN3Yn9K3hD+8lViVvg9/a2DlN7Iekd
 lABvzNH1GIYK2T/Gd9WRwP+KR990mfBc4i+PIk44Fmv3xIoa1lxCpuFiAwLDp65Xrku2
 c6PQ247YmGAuNjOTQ37sOU1M2TGFmJGIYoiTJ3y7vixki+vjDB6s3s6EKiV/XznnFvUw
 IHBZY9xJ2unfORuvQX6YT6hUg2n0HAXWUVZdRnbSTLbVsUr9BbePgFa5j7tFuFwpvIq5
 SB6lCNRhcUUktS3nscOZDg7FOVzCTVz3wAAX3PI0TW3kLyORkfAlI558MQw0oMl25e0l
 qO5Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780636875; x=1781241675; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PdjWV50fJcHUthKByA+7AQxOm4btCc4wVU2NDLiZzd8=;
 b=YJQlUwMNjlG0aIZLYC8bNFoKQWH2O25eU85ToKmUIt9yUvYCWAdzRhc2cWMAv3g/HN
 XfWG/0SZtswkJhZtWldAPr5GWLVJJ7Ccex2FN+lYcwvKeiy5InpFDYpDYlP/r921vnil
 mQ+aqgFan7xh+10q701bsWFDkVaW2WvTBJZBgLbnM0pLJFnK6TbWuAxsypV6G/wZBBtf
 yHmjB7609qH/JjkSdKlRurtJTxqU1LWy0jhSgScG+AfgJB5JAFKoxKLABvp3At5HinFX
 hW2V2M1/3lha/jlI4WlF0jaJnx/O0GdjKFJAMNvIFX7vqZG4ODIZrPz1rHTC2tBGnJq6
 ZSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780636875; x=1781241675;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PdjWV50fJcHUthKByA+7AQxOm4btCc4wVU2NDLiZzd8=;
 b=MZNMVqUfrAiJU/TVmDISI2q2/d8EI5+43caAAOeUGBz0OEoA4IydusZrs1ITp2VnkF
 LJoCETgYpaIV86OdptWeysufeOZgRN0AtYYVbWFZcE/mZ7J7qU0gNJQuIdC12uzaX84U
 0itMWpmSX196m7iiSGWlJNMCwEDhJK9Iy1tnMHN2q4TSzS5yhkDO2LhvQ2G/8YnlhRuq
 wirVgZ3xCK+46lj4oQnT/RMp5PanLRysImvqVlso+v00AfmOaYmbbxL0O6ehM2eozs6+
 p9EHYs0+0XOsLFAXaFMA3jRthaksoDXrzqZ2VpBs7EbyNTQuNApfd39fHZTmZGdjh2c0
 tXpQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9idYykXNWUl4AcFw9NiknezBHABPYJ4vGqZ2lxdVE5xalXjFVe49DIC6m6VgtBSFRfEjvAVBo=@lists.denx.de
X-Gm-Message-State: AOJu0YwJ7MVF3BpTUpFXSWV9nb4pZPFf0iTZT8PjJ2S9Kq9TMzMZ2/Yq
 UPIXAlH+6mbqMrrDlKJDM8OQABiqTijVwf0aoS3NAobIMDtJAC7iN49JUd5VdfLDUrsIprtgMWP
 5Nnm1PfUpxtM67gRfpn4W124qVzJk7BWtH0tiN6jcRw==
X-Gm-Gg: Acq92OFYgst4b0t3xMJWdwa610bbM+mHCA8r0IXNttEBwlWoFEkTZcf8/LbmU0Dm5Up
 7Q0eeAppaX59ITGp4JWZ+nhfsRrfPQY0AQviVzsH1y+Q9hkRCyaypjLZfjBkWLrK+yYPSGLnn0C
 iD3qV/EE7UV+zPBTI1FZybuN0GVfH5GeUcBL9+A1eRkLSfJ5uJW2+i9riuXIbXPq6BVTHxpeODz
 knHGKakSXZM1lSKA1dy5cOPwsnwhUb4H1pmcDAt+d01jTR+fTTjxlmuGVrABs0XXH8OEpL7y/sV
 l4nOhOR9q5/eikdj550LBcMZjDDYk0IkIdPem/S0GRaScM8MOAIrXS4Kbk8UNcuCRwsD+Iv7ild
 ujS91WslYlgJ+qbProoQfWnaQb8GBa7cuZPkqqjIyJvNaQa+gBabEYb6Hqr65TV91aXH/l+6v+s
 LryyiUqqPYPrNhcXEn+WYbFVoFitnMU6KzqwOLTJbsaFhatVwOgL2UOFJOe/zmJe3QDeHUD2/Ux
 gcD5jGUuxSyadVqyeOgXkmsGgg0/pLeN2Hsx52FHvrqD2YXmxao6PA5HaTfhHlO+YAzvf7zXEmi
 PppU5tJCOqcRRWtUz8d1pqF0hbhlfDOt9TEaCg+978bVKkKXquHu0K4TNEbFsjZQRCeD58abtmX
 W8x8bCL9i1vVDnF93
X-Received: by 2002:a53:cb4e:0:b0:65e:4b1d:c67d with SMTP id
 956f58d0204a3-6610707496fmr1572995d50.53.1780636874960; Thu, 04 Jun 2026
 22:21:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260604073719.48723-1-ilias.apalodimas@linaro.org>
 <20260604073719.48723-2-ilias.apalodimas@linaro.org>
 <89b2f624-796b-48b9-92b9-4739cc64a497@mailbox.org>
In-Reply-To: <89b2f624-796b-48b9-92b9-4739cc64a497@mailbox.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 5 Jun 2026 08:20:38 +0300
X-Gm-Features: AVHnY4JJSFDqF6jTuNP15P-Z2sxsvlAqNv834V8ULzpCIw3G7AaXNuTgU64I6_c
Message-ID: <CAC_iWjKthnMcmaG00yOBvJ+kpYqL+yB7uppYvs2z+XDpMWEUdg@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] treewide: move bi_dram[] from bd to gd
To: Marek Vasut <marek.vasut@mailbox.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, 
 anshuld@ti.com, sjg@chromium.org, Michal Simek <michal.simek@amd.com>, 
 u-boot@lists.denx.de
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

Hi Marek,

On Fri, 5 Jun 2026 at 01:34, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 6/4/26 9:37 AM, Ilias Apalodimas wrote:
> > Currently, the bi_dram[] information is stored in the board info
> > structure (bd). Because bd is only valid after reserve_board(),
> > dram_init_banksize() must be called late in the initialization process.
> > This limitation is problematic, as it forces us to rely on a variety of
> > bespoke functions to determine board RAM, bank memory sizes, and other
> > early setup requirements.
> >
> > By moving bi_dram[] into the global data (gd), we can run it earlier.
> > This is particularly convenient since boards define their own
> > dram_init_banksize() routines, which do not always rely on parsing
> > Device Tree (DT) memory nodes.
> >
> > Additionally, U-Boot defaults to relocating to the top of the first memory
> > bank. While boards currently use custom functions to override this
> > behavior, having the DRAM bank information available earlier in gd makes
> > relocating to a different bank trivial and standardizes the process.
> Regarding the BD, this is likely really old, but it seems BD might be
> passed from U-Boot to Linux somehow ? See [1] and U-Boot
> include/asm-generic/u-boot.h :
>
>   8  * NOTE: This header file defines an interface to U-Boot. Including
>   9  * this (unmodified) header file in another file is considered normal
> 10  * use of U-Boot, and does *not* fall under the heading of "derived
> 11  * work".
>
> Are we certain we are not breaking ABI here ?

That's a good point and I did look at U-Boot briefly when I changed
the location. However, I didn't look at the kernel...

Unfortunately, I don't have a platform I can test. Let's see if Tom's CC helps.

Thanks
/Ilias
>
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/boot/ppcboot.h
>
