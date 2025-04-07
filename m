Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F60C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 12:50:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36C1082E38;
	Mon,  7 Apr 2025 14:50:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DsR49Seh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D8C782E40; Mon,  7 Apr 2025 14:50:35 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 503D582CFD
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 14:50:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christopher.obbard@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso28535605e9.0
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 05:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744030233; x=1744635033; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PwWpHQkKrr/AZ9hYoTcH7cPlscAUYIHjFcfUWQk6nVg=;
 b=DsR49Sehzh9M0czQmBYIqQYr3cuh3ugqUvuwhsGOaYz/OgqZ+Z/ZXo7x2T9myATj3S
 Zqib3p588Jow6WHpoU3M1TKrdmQuFfaQD+ySh8+v4d78GMpH9yWd2/NnqJWDzO2UARYE
 5wfEsyDsiPO28VQCCLsLtj4Vs70FpbayGlcpX/qydVDFKY8vfWBI77wFgjRKAmkUpwRV
 9uorjXQSOJCPSiJfgGb1SsVoqz/ulAnxIZTXinemJFs4XoyonshwbgyxiDUoN88GjngO
 faorWQVlmdaxWRux3LIfbq/EPBambir+3vBEYV4n/zipshENH/drON7WCRHXjREISpbO
 Y82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744030233; x=1744635033;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PwWpHQkKrr/AZ9hYoTcH7cPlscAUYIHjFcfUWQk6nVg=;
 b=tXVP+i5xqZq+d5yenxTrldo3fWy3pmwoCXTCg5PH+kNtrZ2FKqZF36d3aIXr/MQ/iC
 GkB9lc+3Qp7O695uiB+spJ2q2pU/Y4REmJRVirDgVp3eu13BMObOV4Nj5zQx7xPm8dhL
 30XAodEwSbkdRqm8f/xyA7NP7vmlTZKjybFzkrZdjeJmrLGuS8iydgllbb4AURE7bcws
 8PcY9ijQvISQThwsM4AqdbrQv16MWbPdP0Bqf5GySBQHAjByr8XYvCMV830zluugcY0w
 xSsHFI9fEKqQhttFfMByJsK94Lb3KrKaCHTqODzdOrfg97rwCOEUC5fuUmJaHIfhH8To
 u/yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhaDsvfJ082uSGMY/P1sbNHAIOJMxvYwW9rpbuhkPNCyLAVvYA/NIzgTGfnB90+8XI8y5KCpQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxFnq5BIMdL2fkMuf46tnS4WeyGAzykRHNfdYld/y1pm/qLgWG1
 1+H2LPGzhhz9jTRqkp8+nb3d0f1QzQopiyrMYf+5+afiMyZ3q8/N0A0CBhTq+YkAElKKXK0rbv6
 grI7//Ye4E7+xbtnYhjhdtd4AJWJcuWJgkfP6Ag==
X-Gm-Gg: ASbGncuwjsvH26ZT94GApShCNslfsfxnuivOplJArMLgv6GvVfofxfeMZJU2Vwt25Tm
 bJjsHp50ifb5ekbku2xnlVcNo9cTFqxsOjyFiqFSw2ucp8jHEblr6NQ0loWJF4dcTAufXnW0qXL
 3/NniU9hagIBwoAVl0/eyR06pd6py2+/e9qLWioimaBO17bDeks5hApLMJ9svOzYn6B7NdjA==
X-Google-Smtp-Source: AGHT+IEG4BbXiYsCIRivKbRJT2ob3OciHEYguMuhgO3tmQAPPhxRDenLeJnvC7gIzL9pt6Uj697szbXbok+nt+1MNvc=
X-Received: by 2002:a05:600c:c8a:b0:43c:f597:d584 with SMTP id
 5b1f17b1804b1-43ecfa0704amr114163955e9.29.1744030232576; Mon, 07 Apr 2025
 05:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250407120536.236003-1-jorge.ramirez@oss.qualcomm.com>
In-Reply-To: <20250407120536.236003-1-jorge.ramirez@oss.qualcomm.com>
From: Christopher Obbard <christopher.obbard@linaro.org>
Date: Mon, 7 Apr 2025 13:50:21 +0100
X-Gm-Features: ATxdqUFvrYHxWlL4XtzESqLSnhYSjoev7K0etRbsXgajT4W59FIPhHoLRQ-sNug
Message-ID: <CACr-zFDncaexKRP0JouAo5BDozZEZd+_cT-i8088qxOb-JDRjA@mail.gmail.com>
Subject: Re: [PATCH 1/5] board: qualcomm: dragonboard820c: udpate readme
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Cc: neil.armstrong@linaro.org, caleb.connolly@linaro.org, 
 sumit.garg@kernel.org, u-boot-qcom@groups.io, u-boot@lists.denx.de
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

Hi Jorge,

Long time no speak.

On Mon, 7 Apr 2025 at 13:05, Jorge Ramirez-Ortiz
<jorge.ramirez@oss.qualcomm.com> wrote:
>
> Update build instructions.
>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Your patch subject has a typo in "udpate" -> "update.

With that fixed:
Reviewed-by: Christopher Obbard <christopher.obbard@linaro.org>

> ---
>  board/qualcomm/dragonboard820c/readme.txt | 47 ++++++++++-------------
>  1 file changed, 21 insertions(+), 26 deletions(-)
>
> diff --git a/board/qualcomm/dragonboard820c/readme.txt b/board/qualcomm/d=
ragonboard820c/readme.txt
> index 966e9520e85..a01d24122cb 100644
> --- a/board/qualcomm/dragonboard820c/readme.txt
> +++ b/board/qualcomm/dragonboard820c/readme.txt
> @@ -16,10 +16,7 @@
>                       Build & Run instructions
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>
> -1) Install mkbootimg and dtbTool from Codeaurora:
> -
> -   git://codeaurora.org/quic/kernel/skales
> -   commit 8492547e404e969262d9070dee9bdd15668bb70f worked for me.
> +1) Install mkbootimg
>
>  2) Setup CROSS_COMPILE to aarch64 compiler or if you use ccache just do
>     CROSS_COMPILE=3D"ccache aarch64-linux-gnu-"
> @@ -33,15 +30,15 @@
>
>     $ touch rd
>
> -5) Generate qualcomm device tree table with dtbTool
> +5) Append the dtb to the u-boot binary discarding the internal dtb.
>
> -   $ dtbTool -o dt.img arch/arm/dts
> +   $ gzip u-boot-nodtb.bin
> +   $ cat u-boot.dtb >> u-boot-nodtb.bin.gz
>
>  6) Generate Android boot image with mkbootimg:
>
> -   $ mkbootimg --kernel=3Du-boot-dtb.bin             \
> +   $ mkbootimg --kernel=3Du-boot-nodtb.bin.gz          \
>                 --output=3Du-boot.img                 \
> -               --dt=3Ddt.img                         \
>                 --pagesize 4096                     \
>                 --base 0x80000000                   \
>                 --ramdisk=3Drd                        \
> @@ -251,44 +248,42 @@ Wait for 5 seconds before proceeding
>  [5300] booting linux @ 0x80080000, ramdisk @ 0x82200000 (0), tags/device=
 tree @ 0x82000000
>  [5310] Jumping to kernel via monitor
>
> -U-Boot 2017.11-00145-ge895117 (Nov 29 2017 - 10:04:06 +0100)
> +U-Boot 2025.04-rc5-00020-g40a61ca0e7eb-dirty (Apr 07 2025 - 09:37:03 +02=
00)
>  Qualcomm-DragonBoard 820C
>
> -DRAM:  3 GiB
> -PSCI:  v1.0
> -MMC:   sdhci@74a4900: 0
> +DRAM:  3.5 GiB (effective 3 GiB)
> +Core:  136 devices, 18 uclasses, devicetree: board
> +MMC:   Bulk clocks not available (-19), trying core clock
> +mmc@74a4900: 0
> +Loading Environment from EXT4... OK
>  In:    serial@75b0000
>  Out:   serial@75b0000
>  Err:   serial@75b0000
> -Net:   Net Initialization Skipped
> -No ethernet found.
> +Net:   No ethernet found.
>  Hit any key to stop autoboot:  0
>  switch to partitions #0, OK
>  mmc0 is current device
>  Scanning mmc 0:1...
>  Found /extlinux/extlinux.conf
>  Retrieving file: /extlinux/extlinux.conf
> -433 bytes read in 71 ms (5.9 KiB/s)
>  1:      nfs root
> -
> +Enter choice: 1:        nfs root
>  Retrieving file: /uImage
> -19397184 bytes read in 2024 ms (9.1 MiB/s)
> -append: root=3D/dev/nfs rw nfsroot=3D192.168.1.2:/db820c/rootfs,v3,tcp r=
ootwait ip=3Ddhcp consoleblank=3D0 console=3Dtty0 console=3DttyMSM0,115200n=
8 earlyprintk earlycon=3Dmsm_serial_dm,0x75b0000 androidboot.bootdevice=3D6=
24000.ufshc androidboot.verifiedbootstate=3Dorange androidboot.ver0
> -
> +append: root=3D/dev/nfs rw nfsroot=3D192.168.1.6:/home/jramirez/Src/qual=
comm-lt/db820c/rootfs,v3,tcp rootwait ip=3Ddhcp consoleblank=3D0 console=3D=
tty0 console=3DttyMSM0,115200n8 earlyprintk earlyco0
>  Retrieving file: /apq8096-db820c.dtb
> -38134 bytes read in 37 ms (1005.9 KiB/s)
> -
> -## Booting kernel from Legacy Image at 95000000 ...
> +## Booting kernel from Legacy Image at 155000000 ...
>     Image Name:   Dragonboard820c
>     Image Type:   AArch64 Linux Kernel Image (uncompressed)
>     Data Size:    19397120 Bytes =3D 18.5 MiB
>     Load Address: 80080000
>     Entry Point:  80080000
>     Verifying Checksum ... OK
> -## Flattened Device Tree blob at 93000000
> -   Booting using the fdt blob at 0x93000000
> -   Loading Kernel Image ... OK
> -   Using Device Tree in place at 0000000093000000, end 000000009300c4f5
> +## Flattened Device Tree blob at 148600000
> +   Booting using the fdt blob at 0x148600000
> +Working FDT set to 148600000
> +   Loading Kernel Image to 80080000
> +   Using Device Tree in place at 0000000148600000, end 000000014860c4f5
> +Working FDT set to 148600000
>
>  Starting kernel ...
>
> --
> 2.34.1
>
