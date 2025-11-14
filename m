Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B56CCE7AEE
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 11:24:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B912183EF5;
	Fri, 14 Nov 2025 12:24:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PS0MLcYS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA39E84064; Fri, 14 Nov 2025 12:24:01 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7E8083EAF
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 12:23:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-74526ca79beso1437206a34.0
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 03:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763119438; x=1763724238; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iBw5MWbZVysIL9Aq0fCl5np1woQkyzXVJDbwvtRLelg=;
 b=PS0MLcYSGOO0je3M71AwshHKPxE8HjlHne+3VHp6dItuGhSeL33T7LW212kN8f1RiV
 bJzh2N7/T11PupDltWMxYbfT/0i5kiPGFifzkj/Ziy1TFohAmfm/uZ550qZyZaR7L6kf
 EyQGjm5TRqgbkp1Hzn3oDg47pPwugwcJsfJTeRnqOjDQDhAIP6mpo52IKU7cxLHUz2ro
 fF1n50y4usx0iJ98DyHEyUzOfB0oe+wXqw1N9iPO/9CXvPf7wRKPr5M3f5igU+q2wGYO
 4VQ2ZJXfM51EvhESgaNk3U84+3fLz7AwFULKqAFkt8ZOH96k9V6cN9mwrys47bAIr8In
 wqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763119438; x=1763724238;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iBw5MWbZVysIL9Aq0fCl5np1woQkyzXVJDbwvtRLelg=;
 b=OB+a2KWM72K/zin/BkV71R4qXPgP5QvZx4uG6bYfa+hkQBl4GrTHcuFENxDvRighdF
 I8Ifvx5YUA5hUTJcaSEB1x4z60CXHkV8XLOYpUVMXo+kpWnqNPoGpbnpNDx9arCfHEmR
 GTeO8d8pScppwdwY6bWrzfToUVSgcagayyoMaQJkhYkkRYoBrZKUBIXNEuVzePN22NYE
 yKRLck7Rvf3L8fQFUYwbJrFwJNzognL5p25SZ3mXvvY23Sp1lSg3IgPpLURoYlfBZz11
 KA7tfFrjVbiIB9yW2kbOxQlqlEt1D8bVPX5Fzv3Dsf9GF9wCzyQZFvAfdbtF1HRxXF2h
 YNtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXe7NXw3zxZa01ubSsUbx+k14pUh/5Uvl4WSuShZj0vc3pgn11+crE2nOtMdL+ujnEuMTZgJ6Y=@lists.denx.de
X-Gm-Message-State: AOJu0YwVi2p934GmuuoWCqKhG/yEARl1p2hOWjuftGscoruCUNvnShqz
 HFbcofuX8fIxk9W+FV30v5/tmyAwgRIFiMNOUOni6u3rcHvnI6QaXCRZ3rsETZmkv84AnjBaBM0
 N4hF7RIQgoLrkU9+i9pO5o4LmroUC3ys=
X-Gm-Gg: ASbGncteRR5CokQ5rjsjLUmRi3NwHg/oiXWtgmcoQUSvY32Gy3Dt5SU3Nng5Dae0c6/
 CxKJHEeqM1WFD5/aqc9/MD2wVE59OPIJ8o0tx9qUkFREqxs9LhoMUoIEcg2ynBajIdPXHfzJiiE
 6MFk/PNbUc1Z8mA3hXCH8PAJo91w3fqjqYQ47AGoJfN2++y9rptYWXpdLe24OQq8uVNAVYb5Pnl
 RUSZFBv4Z8A9vS3o50AjbNZmvO4cch+kovDv7g2Diu1nMd5bFUTQZz0uXHojmyuxUhu/f4cON7q
 395gSvk=
X-Google-Smtp-Source: AGHT+IEgBM4tGTpHILy5KtcB22NTuK958nGillb68lg0nMqM+1tBF4p927P9qpRzYsOr/p8ndRgvGBfTQj5uuXr34Bg=
X-Received: by 2002:a05:6830:3487:b0:741:a5f0:bc82 with SMTP id
 46e09a7af769-7c74453d788mr1940774a34.17.1763119438295; Fri, 14 Nov 2025
 03:23:58 -0800 (PST)
MIME-Version: 1.0
References: <20251020133455.1870-1-briansune@gmail.com>
 <adaf5081-3b9b-4cdc-b7d3-ec9756f60ead@altera.com>
In-Reply-To: <adaf5081-3b9b-4cdc-b7d3-ec9756f60ead@altera.com>
From: Sune Brian <briansune@gmail.com>
Date: Fri, 14 Nov 2025 19:23:46 +0800
X-Gm-Features: AWmQ_blEuOrQxX5FXNlyrqFZ-MCq-WRRyljuiEpsHh2pf1VdWg7pA1PkToGyIp4
Message-ID: <CAN7C2SDVD+bpF=CGDPXDqLE3U9cMm2YqxnwXScvxiFh3OypP=A@mail.gmail.com>
Subject: Re: [PATCH v4] Altera SoCFpga Boot Stall Fix
To: "Chee, Tien Fong" <tienfong.chee@altera.com>
Cc: Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

All the below comment are all just talking about new SoCFPGA.
You break the SD boot by for Cyclone V and Arria V and possible
Arria 10 as well.
You can do a build and board test on SD boot.
Just consider newer SoCFPGA is not a proper way to remove things.

If I am mistaken point out why and what is the reason.
There are nothing to do with new family, this patch is pointing
out the old SoCFPGA is break by such.

Brian

> Hi,
>
> On 20/10/2025 9:34 pm, Brian Sune wrote:
>
> Since U-Boot 2025.07 pure SD Card
> boot no longer works. Now Altera released 2025.07
> shows the different on the u-boot files.
> After testing, the major root case is
> get_managers_addr. And this patch fix the
> SD boot stall via pulling from offical.
>
> Signed-off-by: Brian Sune <briansune@gmail.com>
> ---
>  arch/arm/mach-socfpga/misc.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-socfpga/misc.c b/arch/arm/mach-socfpga/misc.c
> index 76747c2196a..c54f5e32454 100644
> --- a/arch/arm/mach-socfpga/misc.c
> +++ b/arch/arm/mach-socfpga/misc.c
> @@ -178,7 +178,10 @@ int arch_cpu_init(void)
>   * timeout value is still active which might too short for Linux
>   * booting.
>   */
> +#if !(IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5_SIMICS) || \
> + IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5_EMU))
>   hw_watchdog_init();
> +#endif
>
>
> This is intended for internal use and should be removed.
>
>
>  #else
>   /*
>   * If the HW watchdog is NOT enabled, make sure it is not running,
> @@ -223,8 +226,16 @@ static int do_bridge(struct cmd_tbl *cmdtp, int flag=
, int argc,
>
>  U_BOOT_CMD(bridge, 3, 1, do_bridge,
>     "SoCFPGA HPS FPGA bridge control",
> -   "enable [mask] - Enable HPS-to-FPGA (Bit 0), LWHPS-to-FPGA (Bit 1), F=
PGA-to-HPS (Bit 2) bridges\n"
> -   "bridge disable [mask] - Disable HPS-to-FPGA (Bit 0), LWHPS-to-FPGA (=
Bit 1), FPGA-to-HPS (Bit 2) bridges\n"
> +   "enable [mask] - Enable HPS-to-FPGA (Bit 0), LWHPS-to-FPGA (Bit 1), F=
PGA-to-HPS (Bit 2), F2SDRAM0 (Bit 3), F2SDRAM1 (Bit 4), F2SDRAM2 (Bit 5) br=
idges\n"
> +   "bridge disable [mask] - Disable HPS-to-FPGA (Bit 0), LWHPS-to-FPGA (=
Bit 1), FPGA-to-HPS (Bit 2), F2SDRAM0 (Bit 3), F2SDRAM1 (Bit 4), F2SDRAM2 (=
Bit 5) bridges\n"
> +   "Bit 3, Bit 4 and Bit 5 bridges only available in Stratix 10\n"
> +   "For example:\n"
> +   "1) To enable and disable all bridges (command without mask):\n"
> +   " a) bridge enable\n"
> +   " b) bridge disable\n"
> +   "2) To enable and disable HPS-to-FPGA and LWHPS-to-FPGA bridges (comm=
and with mask):\n"
> +   " a) bridge enable 0x3\n"
> +   " b) bridge disable 0x3\n"
>     ""
>  );
>
> @@ -261,6 +272,17 @@ void socfpga_get_managers_addr(void)
>   if (ret)
>   hang();
>
> + if (!IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)) {
>
>
> if (!IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX) &&
>         !IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX7M) &&
>         !IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)) {
>
>
> The condition for non-Agilex5 platforms should be rewritten because sys-m=
gr has already moved to the driver model for these platforms.
>
>
> + ret =3D socfpga_get_base_addr("altr,sys-mgr",
> +    &socfpga_sysmgr_base);
> + if (ret)
> + hang();
> + }
> +
> + if (IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX) ||
> +    IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX7M))
> + ret =3D socfpga_get_base_addr("intel,agilex-clkmgr",
> +    &socfpga_clkmgr_base);
>
>
> Similarly, the section for Agilex and Agilex7M using clkmgr can be remove=
d, as both now use the driver model.
>
>
>   else if (IS_ENABLED(CONFIG_TARGET_SOCFPGA_N5X))
>
>
> The N5X section should be updated as:  "if (IS_ENABLED(CONFIG_TARGET_SOCF=
PGA_N5X))"
>
> The remaining part of the function can remain intact.
>
>
>   ret =3D socfpga_get_base_addr("intel,n5x-clkmgr",
>      &socfpga_clkmgr_base);
>
>
> We=E2=80=99ve already tested the above changes and they work as expected.
>
>
> Thanks.
>
> Tien Fong
