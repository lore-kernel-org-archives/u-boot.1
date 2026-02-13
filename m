Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91606EF48CC
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 06:37:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C2C882BF2;
	Fri, 13 Feb 2026 07:37:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bHyNH2Yu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5469683015; Fri, 13 Feb 2026 07:37:29 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32BB080FA1
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 07:37:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-7945838691aso38282097b3.0
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 22:37:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770964644; cv=none;
 d=google.com; s=arc-20240605;
 b=VRLLfMlOKaauKLUvSUzITsJeCPALjOPop1rMzYMS7lq8adTlvgVHLa4GLX2/K+eFis
 2SiMy5GnGldJ182VsBCXE2ixk5GweZ2zMRhi9XOfA42+f23voFQvhs27z6XyNHd/IHHi
 VYzf1FPP2irDrNHwm5Cykz7KOGLXNg7IYvC9QoIqPQ7Xg22wcK8d907wSNrRfxTJVbiV
 vtev7tqYCpp20HdahouzFk4VjLXzYGtBniUlH6X9I3TJPRSAQ7pSGZ2N/eFp0ep4i9h7
 7T6hSqyUvQMLHQxit1aKVehGd+AeYnuZGBP50zQsIKMtpkiZv2qanaHfHqP8NYQvyXgv
 SIgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FZ1wIKxyJTniBxs3z1aLW1tvWGk9dSHKuusqAA2oNSI=;
 fh=1vO0KDczFVLLoeYq5+BSJ/G3iDWzBy4/WCpdY4yt+ks=;
 b=O/8uWoxrOmLYiJsRWi+F+u41F41mTKcdpBKKNMIwR9zdDBaeZUWoM+R5QC5SIo4gcS
 E05ofgq/Kc0kbzIpVO2gB/ln2BHO2sB/JhOMOqX9DfhfAcDymu7RYPbIWfJQTthhKvy8
 Ax04FOxNtoAFumRGeULqY1ZSFpMrBRCEG+UjeT0DoGGGqAnuIkp26ln10EG15Y8+NjYk
 h7x4yZ0ZwkXzrKnFj9z/lcEypZQvufULa+SDtJrUXYrUa4KxC0JefOHBqfoP6dJIlzAA
 xsK/EW80I8TIUDUBdcjgE+vj/yv2LoRw1fzEUfbQgpJ16Tbi4UkKMXNrVS0wPsMJRdlw
 BRxw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770964644; x=1771569444; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FZ1wIKxyJTniBxs3z1aLW1tvWGk9dSHKuusqAA2oNSI=;
 b=bHyNH2YuQBPD+Swj8YnQ2uNd9Q3g4w+pf/4bbV2zH/NT+SA0DAdF1SkbweTbLI6S0h
 +pILt4TZPT4dbdiUxA5BoQphHlSm7+y2wpE/2teSfPfy7v4W9jmcMpDwMHJnYzPhNUDD
 hF09aLhIwc1guVDH2hb0nZ90B+aqQVpPyc68VgcVqdgy5otkZ3onCYAU4mEe1Vcy7dJp
 3nxlgYOzqlVtfmhmI3igoDQ6qsaNbyIgbUESHi8QTL8+CIceuLk0syxNsThjk0Q6es53
 +W+wGCFcsywREJc1Ecpc/y2Rii6FZPYBQ5EjUsEC2Icfay4Is2a/gVdqipEwUkLggfJL
 3D1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770964644; x=1771569444;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FZ1wIKxyJTniBxs3z1aLW1tvWGk9dSHKuusqAA2oNSI=;
 b=oyIt7gIYCQiywoTkMJ/5mYUht3+/M8c1lGSqug7MIWrEBQrcbNUdD2qipiwTxnZ3HC
 Lbcmk12TVIFwP5cFZ3tdYr1YT/SUXm5O60exPIBo6/Stbn8gslkGLxtNBR6J25NYID4i
 t0X0DdCbW7lNmjra7T0WakdabGPECoVyGwHv+/8uTe1MbA5bZNrIsPw+75ugXLGBJzAd
 lGQuVnUclfX4PKn2bA8whNhDnNrXc7u/InhhWPui5IGzb4U/ZctGDaMMrGbA3/EttN/j
 9FeToBU/slWYMSELBiTWKq0FDugPcXiPWsXS5KwHwB0TsmXrUlmChwy8V47ZU8lMdHcY
 kvvA==
X-Gm-Message-State: AOJu0YxybDX4V3h3qrq32BmgkIjT5SkAVY1wZNMaGS3rI/FqNSMOn2B3
 Jn+/6bzgs8EO6qrtEu6aHrQcRg/GIMtOb5iqeLps/sP7X5K6TSxIY4QvIKO1N3S0Hil2K0lDU7u
 IOh+Ea8ULRXsh/9/UY3CURRxNaUwgIWYT/PItjiSemGnKYbxobbbrbqOfBQ==
X-Gm-Gg: AZuq6aL5RziYSe1BTLyXz6aW9388lUylgPi6fndZ/mO6HEykeujK9ux/6Co62EcD/sb
 HYZGIWuZZ8MbUbRYdspx8u1ljhc9AYK0FMy5X3Csw+k6DwUCQ0WMEfd/4ExL1zzmltiHKksQUSw
 StwEirZk91/4EZvN65CnKcl9W8a1yEABiCgYYrNyjEcJtFbHw4ficI6CBYhblMtPSfnVY9/85Fl
 v4LlEujfv8mxzwZPgLLvIdEZG9QHE/TJD8XoE4elAg09lb+piPHFhcbXZYf57eMM9lzziHNcksb
 oIffpnnS3Gs/MiwI8dAR4CDvxi4ieBt9AuR4Qnave1b8YYu4impb1ENLyOC6rqQD5rzvSR5idBF
 YYZCA5P1kdAzwetVdjiF3RZEUBPpn+2jg/Bv2szGvrVvjhvFIrqG0GYrHphKf38xE/I2koCYk0B
 aEtfHmhXgDiclxauUG6fIkOrUgImPkAAlQ20+xQTR1ydupCmK3ZHIQmmJGV9l4Wb6vu5/k5mRo9
 9fngYWrZ3xwLCq2qpdulf0rGMAfUWv1jrTfOOUfOdD5oZWcVTsc2StFkZiCwCtVJmLTNGi/xw0M
 svcKUJV0sGNDsuY5Urqu8qRKGSF+jZdCR9fi7cKsG0G7
X-Received: by 2002:a05:690c:4882:b0:794:c263:bead with SMTP id
 00721157ae682-797a0c8de8bmr5121357b3.24.1770964643891; Thu, 12 Feb 2026
 22:37:23 -0800 (PST)
MIME-Version: 1.0
References: <20260211124314.3406952-1-vincent.stehle@arm.com>
In-Reply-To: <20260211124314.3406952-1-vincent.stehle@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 13 Feb 2026 08:36:48 +0200
X-Gm-Features: AZwV_QhAy8INgmhtwHfUyA4oX8Yxs9FrHOfWbErE8ji9z3p0CPI-NSuBtGJAlKs
Message-ID: <CAC_iWjL5O4k4HrxKk_MfiwYutXVe0LY+kN-c-=_zwFp44Nbm6Q@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: add missing EFI_CALL around tcg2 read_blocks
 calls
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>
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

Merci Vincent

On Wed, 11 Feb 2026 at 14:43, Vincent Stehl=C3=A9 <vincent.stehle@arm.com> =
wrote:
>
> The read_blocks() function from the Block IO protocol is a UEFI function;
> make sure to call it from within U-Boot using the EFI_CALL() macro.
>
> To demonstrate the issue on an AArch64 machine, define the DEBUG macro in
> include/efi_loader.h and build u-boot with sandbox_defconfig, then downlo=
ad
> and uncompress the ACS-DT image [1], and finally execute the following
> command:
>
>   $ ./u-boot -T -c " \
>       host bind 0 systemready-dt_acs_live_image.wic; \
>       setenv loadaddr 0x10000; \
>       load host 0 \${loadaddr} EFI/BOOT/Shell.efi; \
>       bootefi \${loadaddr} \${fdtcontroladdr}"
>
> The following assertion should fail:
>
>   lib/efi_loader/efi_net.c:858: efi_network_timer_notify: Assertion `__ef=
i_entry_check()' failed.
>
> This happens due to the following EFIAPI functions call chain:
>
>   efi_start_image()
>     efi_disk_read_blocks()
>       (due to the missing EFI_CALL, entry_count =3D=3D 2)
>       efi_network_timer_notify()
>
> Link: https://github.com/ARM-software/arm-systemready/releases/download/v=
25.12_DT_3.1.1/systemready-dt_acs_live_image.wic.xz [1]
> Fixes: ce3dbc5d080d ("efi_loader: add UEFI GPT measurement")
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Masahisa Kojima <kojima.masahisa@socionext.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  lib/efi_loader/efi_tcg2.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
> index bdf78897d47..1860dc50238 100644
> --- a/lib/efi_loader/efi_tcg2.c
> +++ b/lib/efi_loader/efi_tcg2.c
> @@ -1213,8 +1213,10 @@ tcg2_measure_gpt_data(struct udevice *dev,
>                 goto out2;
>         }
>
> -       ret =3D block_io->read_blocks(block_io, block_io->media->media_id=
, 1,
> -                                   block_io->media->block_size, gpt_h);
> +       ret =3D EFI_CALL(block_io->read_blocks(block_io,
> +                                            block_io->media->media_id, 1=
,
> +                                            block_io->media->block_size,
> +                                            gpt_h));
>         if (ret !=3D EFI_SUCCESS)
>                 goto out2;
>
> @@ -1227,9 +1229,10 @@ tcg2_measure_gpt_data(struct udevice *dev,
>                 goto out2;
>         }
>
> -       ret =3D block_io->read_blocks(block_io, block_io->media->media_id=
,
> -                                   gpt_h->partition_entry_lba,
> -                                   total_gpt_entry_size, entry);
> +       ret =3D EFI_CALL(block_io->read_blocks(block_io,
> +                                            block_io->media->media_id,
> +                                            gpt_h->partition_entry_lba,
> +                                            total_gpt_entry_size, entry)=
);
>         if (ret !=3D EFI_SUCCESS)
>                 goto out2;
>
> --
> 2.51.0
>
