Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AED8D7830D
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 11:06:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E13CC8914C;
	Mon,  2 Dec 2024 12:06:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bPGU/U+m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DB6C89145; Mon,  2 Dec 2024 12:06:39 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC54789049
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 12:06:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2ffc357ea33so41960571fa.0
 for <u-boot@lists.denx.de>; Mon, 02 Dec 2024 03:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733137596; x=1733742396; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BmV44aXiIOVawj/hjTon6V4hDjKT/8+tke1JdttvLmY=;
 b=bPGU/U+m97QvPmkOwVvUgELQLoNC25GiEZGNfuZWk/xAhm6dpEhql5LISYeE7i1U3G
 XLUAQq1AIMFMZ3jENkJ3YV6fUTpdm1I0Q4k0UIwjlDwG3nahMuyKMgRjBA6/lQSB7Wd7
 Wrua2NBOJsaqs+r1fbKOGaWcmCSlMoO/jz63eF2scvnBL/XQZzOc5xXPapzUKUPX4Icm
 yKX19dqw6iwk5/vngPxXpGp/XQOOtqW4gDjC3oB0kvBvplPeJw/Z5rMe64eRoQ5w67jk
 RqXIBmTj0oK86Nrd7hWDmqfsDGsu1f2izv9d1zKEa+DX2g5J88WNeunAunlHSPyboJ57
 BRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733137596; x=1733742396;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BmV44aXiIOVawj/hjTon6V4hDjKT/8+tke1JdttvLmY=;
 b=doSTXxTiDMuMpiQGkrLVCf/LWlbpnmeXaY7d62Vl28ErKay+5jf6Xb076dxlDlaLrD
 wacgJygJtZPm5XTsjcLSW5UYiJFKa5hjLD0kfU+ckQe/f0yHugcb8nzLleP1ha+9vWR/
 T4nzZGG3sHoTohVHmbX7R7geuQgWQ78izte2CySVpn54BW7PU8YjmQU8xV5rTdPLFrZC
 OO16JtvyN3tOyU3LE55so03/VKWeqPBDSYNYC2gIShb7JTKUztbLAYYI9dYwgcRLDTyc
 wxheFB3svHRpo3pvOg7DWadFdlwPEZKiRuHjNJxm+4zY2OJqUmpv9wa0wCQnrSl2NWZb
 pFkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNJeyNbLLNygKg//rC08wO4j7tBFEzqx1+wwd0e4vTlRd2nAu7XGcitADE2/lX17felG2S9g8=@lists.denx.de
X-Gm-Message-State: AOJu0YyhONayhZH8Qq2KPRIUvP8mtf2jOyp+mn/AoySe9fNP4052OmvD
 oR31tNFJWMqNA1pAE5XGrJV62MpEWRqs0yCsum7pwMGgpLUHaIymvY//rxrRPaSSB8EwCaJEDET
 0/xv4/Hbb7b5LKWq5+jVcEAvJSvN9o85L
X-Gm-Gg: ASbGncuddBcezHaqYKfl4okciH5qAdRtQG7QGCDNoV5rbJLdzze/IsZBaweD8qy58Rt
 ZnugAGHgLP6ugYCVlw/kSV1sY1RGvTSHIPGl1Fx4gD93NApPlEDcxcxTmJHxeM0wfyg==
X-Google-Smtp-Source: AGHT+IF8pC6Yuab2/ujqNXTL47R4qZOgupgluC/s/DEpJT7uV9XvNVNwE45Erpe59ClZsgv1qEvhmo3GU0Y4gXcJUd8=
X-Received: by 2002:a05:651c:1b05:b0:2ef:2490:46fb with SMTP id
 38308e7fff4ca-2ffd60dc647mr104608591fa.37.1733137595720; Mon, 02 Dec 2024
 03:06:35 -0800 (PST)
MIME-Version: 1.0
References: <mvm8qtnv310.fsf@suse.de>
 <8d4e3685-8082-4b74-828f-05ccee5ac8e0@canonical.com>
 <mvmfrnko8tk.fsf@suse.de> <7610b940-63ae-4b52-a71e-555b2d2db35e@canonical.com>
 <mvmplmaml1p.fsf@suse.de>
In-Reply-To: <mvmplmaml1p.fsf@suse.de>
From: E Shattow <lucent@gmail.com>
Date: Mon, 2 Dec 2024 03:06:24 -0800
Message-ID: <CANV2PTMtnjf_Q+5Rw8oVUFmr=0w2ZEDaFQsAzL_cvOC0C-LAng@mail.gmail.com>
Subject: Re: 2025.01-rc2 fails to boot on VisionFive2
To: Andreas Schwab <schwab@suse.de>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 u-boot@lists.denx.de, Minda Chen <minda.chen@starfivetech.com>
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

On Mon, Dec 2, 2024 at 2:33=E2=80=AFAM Andreas Schwab <schwab@suse.de> wrot=
e:
>
> On Nov 21 2024, Heinrich Schuchardt wrote:
>
> > That ls works does not mean that the file system is not corrupted.
>
> This obviously has nothing to do with the file system:
>
> StarFive # load mmc 1 0x40200000 efi/boot/bootriscv64.efi
> 167936 bytes read in 14 ms (11.4 MiB/s)
> StarFive # load mmc 1 0x100000000 efi/boot/bootriscv64.efi
> mmc fail to send stop cmd
> Error reading cluster
> Failed to load 'efi/boot/bootriscv64.efi'
> StarFive # load mmc 1 0x40200000 efi/boot/bootriscv64.efi
>  ** fs_devread read error - block
>  ** fs_devread read error - block
> Can't set block device
>
> Only a reset can revive the MMC interface.
>
> --
> Andreas Schwab, SUSE Labs, schwab@suse.de
> GPG Key fingerprint =3D 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D=
7
> "And now for something completely different."

Thank you for confirming this Andreas. Can you please test and review
the patch today from Sughosh?:

https://lore.kernel.org/u-boot/20241202070624.1295497-1-sughosh.ganu@linaro=
.org/
( Patchwork for same:
https://patchwork.ozlabs.org/project/uboot/list/?series=3D434841 )

It can be applied on v2025.01-rc3 and with
CONFIG_EFI_LOADER_BOUNCE_BUFFER=3Dn
CONFIG_BOUNCE_BUFFER=3Dn

I have been testing with
CONFIG_BOOTSTD=3Dn

There should be now a success on 4GB+ DRAM VisionFive2 board loading
some < 1GB data file from mmc to U-Boot address > 4GB.

Please test and reply to Sughosh patch with remarks. Thank you!

-E
