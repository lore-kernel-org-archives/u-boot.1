Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C88CA0EDC
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 12:23:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C6BE838C7;
	Thu, 14 Aug 2025 14:23:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SvXkH/YT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 418DA838F4; Thu, 14 Aug 2025 14:23:12 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A86783835
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 14:23:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-333f8ef8483so6712261fa.1
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 05:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755174189; x=1755778989; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=42PRj3HIptgrQ5E1SSVdq9Gz1vhtgbfl+0aTy40FcUQ=;
 b=SvXkH/YTgKABxUVXE49aW1z1DZdb50i2ZjhLEX25KQ9/zL6QzZth23SfpY1H7wZmPu
 MTwffLqtSJ5SjY02ckt8pcVlIvO7Ew8LxyM2Ayf4ghTwa89qsFGiWawu01rclsEfR66H
 5+xKDfX1wUPdg8kWHS+rTEoJ5MdYP/JgtaPavwuQvInkMCbwkNhnifCJdfsIBjIZNqjY
 ywBjHat6leWuPnCbxzBaNvo2EHrrS4C5iXawHpgErwQomiAPFEqgq8efxtnEedQYMEWz
 rCTIG7vKMO9Q/weSCsCqyo5nCs3C5ZM/BW5rtV+ovXVb2v0CEqrfEgLgq4mHE5jkhU3O
 duhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755174189; x=1755778989;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=42PRj3HIptgrQ5E1SSVdq9Gz1vhtgbfl+0aTy40FcUQ=;
 b=T/PlLk4LJaKpxNX5M4PgACcEsFsBkVaRvhNvs8bYVUUcq79vBoprqTg8QLYGu0F0gi
 HBVIwckT7+EyVkXsqjWP2CeuU8xyFILUoM73PEkQv5JtUxzS6d2fGjGA6oT+cHAaPlia
 DW5nqtm0i8sC8zawV8O8xgvqMrWH2WLeN2AWx+3bVT7A0MntS2lR0CP0Q/r+rPtJdvC6
 FWuUQqFHHufcSDibda2UT9CWgVoUYtZ+9hRniTAqiBF5gPBtjmo1KWgoELhwFPbNuvck
 H59GmQLgcqZKoaT1/8nvTS+9x4oeZQk4ZtmrtD/y+R8IM0dyjRgB+R5+7M+rh7rMh5tP
 zxRw==
X-Gm-Message-State: AOJu0Yyp4ASdcUV3Uxn8L3X2cZ8cJZoyyZaK+MWkp4gBgDkecZDtjPS3
 FtxTFei+QEj37AvUXFkFgea8xgm374jQGrCmv/Q5Qq2UW0WHTESej0S5F4Io8wFvEtgMZyZXeHo
 NMyMKUSWcoMdtJ2mu1jaD3LAkftRCIJymji94
X-Gm-Gg: ASbGncu22aYHVxsJ555/QiqIKN8T7ELxSJLzU1mAamxMiOwiWAMzNJooJvVYBVO1sTb
 oM7iC4EjYOY65WIQpHKqUHZ+eVl4rV5mEfcQxL/LPLjjqWNnCTBRJUNDUYzBIDXwMlceKB9KKTd
 vyGNsoVN2/ogCGVTDawVpH5pPyS7owuH83UL/S59ewZpuRvcwvyopP25CHjKEVwXC5/G7hfIIaM
 XiPa1q/tSu/KINcGsqCw8822aGK3nF22cBFxw==
X-Google-Smtp-Source: AGHT+IG39u03j6cl5qh5pbGhbRNx9VvWmdAKZSYOOkghCUFAYoDkNoJ6QyaaD/rpejiSz3USpOBkPWa+aNh4bZbfL2A=
X-Received: by 2002:a2e:8a82:0:b0:32b:8778:6f0a with SMTP id
 38308e7fff4ca-333fa8a76fcmr5628251fa.27.1755174188955; Thu, 14 Aug 2025
 05:23:08 -0700 (PDT)
MIME-Version: 1.0
References: <cdfbaad3-e9ed-4678-9a65-c3561537d600@siemens.com>
In-Reply-To: <cdfbaad3-e9ed-4678-9a65-c3561537d600@siemens.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 14 Aug 2025 09:22:57 -0300
X-Gm-Features: Ac12FXw-ahfvrvydoT8p2geqDmQAY8wMkJGqi4IYxeN7GrlGz31k2lpTx3CuRQw
Message-ID: <CAOMZO5D+1v-721g5nE3NFQ4igrBHvF0rWs6Jkvm-Jo+R0QXKwA@mail.gmail.com>
Subject: Re: CONFIG_SYS_EARLY_PCI_INIT for PCI-attached eMMC
To: Jan Kiszka <jan.kiszka@siemens.com>, Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Thu, Aug 14, 2025 at 6:11=E2=80=AFAM Jan Kiszka <jan.kiszka@siemens.com>=
 wrote:
>
> Hi all,
>
> I'm currently playing with eMMC emulation for qemu-system-aarch64 -M
> virt and will likely propose upstream to allow user-instantiate emmc
> devices (-> -device sdhci-pci -device emmc).
>
> To make U-Boot recognize such a setup, I currently need this:
>
> diff --git a/include/configs/qemu-arm.h b/include/configs/qemu-arm.h
> index e296f398798..4e22aa36fa6 100644
> --- a/include/configs/qemu-arm.h
> +++ b/include/configs/qemu-arm.h
> @@ -11,4 +11,6 @@
>
>  /* For timer, QEMU emulates an ARMv7/ARMv8 architected timer */
>
> +#define CONFIG_SYS_EARLY_PCI_INIT      1
> +
>  #endif /* __CONFIG_H */
>
> Is this the right way to achieve? Then a patch for U-Boot would follow
> as well.

CONFIG_SYS_EARLY_PCI_INIT is not defined anywhere as a Kconfig symbol.

I'm wondering if we should change it like this instead:

diff --git a/common/board_r.c b/common/board_r.c
index 143d51d06330..3da749b05fcc 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -685,7 +685,7 @@ static void initcall_run_r(void)
        INITCALL(post_output_backlog);
 #endif
        WATCHDOG_RESET();
-#if CONFIG_IS_ENABLED(PCI_INIT_R) && CONFIG_IS_ENABLED(SYS_EARLY_PCI_INIT)
+#if CONFIG_IS_ENABLED(PCI_INIT_R)
        /*
         * Do early PCI configuration _before_ the flash gets initialised,
         * because PCU resources are crucial for flash access on some board=
s.
