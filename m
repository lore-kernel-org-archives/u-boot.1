Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30297C4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 04:21:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 783598831B;
	Fri,  3 May 2024 06:21:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="eheeNJvz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5855988317; Fri,  3 May 2024 06:21:25 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94D4788313
 for <u-boot@lists.denx.de>; Fri,  3 May 2024 06:21:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=broadcom.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=william.zhang@broadcom.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3c861a87d6dso3531765b6e.0
 for <u-boot@lists.denx.de>; Thu, 02 May 2024 21:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1714710080; x=1715314880; darn=lists.denx.de;
 h=in-reply-to:mime-version:user-agent:date:message-id:from:references
 :cc:to:subject:from:to:cc:subject:date:message-id:reply-to;
 bh=MlBVff34S4jH5LN5pJQFlpPdIZm8OH4C5hI8/N8zbLY=;
 b=eheeNJvz9rWSv7sItcZEimsPXV87hvIxmyzO1yvW83dYHg39ImYAlgFYQIIb2olglw
 NN6J56qmxkiObpT/MAwoS6lhO8VqJCfITNF2o6kSPCoiIFHBw1FmA4+6ORq3MGOAELDb
 O6/zyMfkDdEQmfPdz/FpskIY05ZsQOmBHPso8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714710080; x=1715314880;
 h=in-reply-to:mime-version:user-agent:date:message-id:from:references
 :cc:to:subject:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MlBVff34S4jH5LN5pJQFlpPdIZm8OH4C5hI8/N8zbLY=;
 b=Dl1yzLFAXSooHJtrUd0+9Nkf3ykQRGWcrLrPASs8Cl4qNV7H7ItuBvK+qRvtFHlAkv
 AA/JFRyjxDv1PLE3FwMe6LJHYSai44KVIuUszKRtuCdxPca22yKsOIEUKl1KEoqXr7rl
 uVHsQi/EQznijOg9tCCMw4eQ67QoF9kv8v4grS5qGEwRaQxy+RSi6ZujSMppjPx6woLU
 xFNJC3bxYvP93u3nGwcoNrV/csBOuyqpU2R78I0U52WajuTn47+evZAPrO20W2IIOaSH
 aB7dQhF03ht8u15BE7sAfwcOCJofPafJFAeGpQPBGjxYExsZR1j4VveqD8+qZSOi4miu
 PRYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGz67/gexSXX2LbYheq3SvJZDBqeJM12BpQXlD4eRexO/65ExQb1nrYej3aJ/BktV6JNwh84mCa1W3obIgvmNtd/7oPg==
X-Gm-Message-State: AOJu0Yw3PvB/kvQere+UJFLBX2i9BTb5oRv5HyEdPGSW14PyOEG8/OEj
 k74BWG00yjDaImngvOiFDru3v/I/f7rV+pfBeMROALm+IFmVUcqRkPlUKmh2hQ==
X-Google-Smtp-Source: AGHT+IH2RfQYp+KerILwBFEfngR+AiKMfM0nfjeumzci99OCPrAW2V0HD5koXckp0S501zBcg4sfCw==
X-Received: by 2002:a05:6870:cb95:b0:22e:935e:7637 with SMTP id
 ov21-20020a056870cb9500b0022e935e7637mr2152144oab.0.1714710080141; 
 Thu, 02 May 2024 21:21:20 -0700 (PDT)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
 by smtp.gmail.com with ESMTPSA id
 62-20020a630241000000b005f3d2a9a91bsm2123020pgc.89.2024.05.02.21.21.17
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 02 May 2024 21:21:18 -0700 (PDT)
Subject: Re: [PATCH 43/81] mtd: Remove <common.h> and add needed includes
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Anand Gore <anand.gore@broadcom.com>, Kursad Oney
 <kursad.oney@broadcom.com>, Joel Peshkin <joel.peshkin@broadcom.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Alex Nemirovsky <alex.nemirovsky@cortina-access.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Michal Simek <michal.simek@amd.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>,
 Nishanth Menon <nm@ti.com>, Sean Anderson <seanga2@gmail.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
 <20240502013138.2383421-43-trini@konsulko.com>
From: William Zhang <william.zhang@broadcom.com>
Message-ID: <295d9986-22aa-9ef0-8bb8-891e6d1d5cdf@broadcom.com>
Date: Thu, 2 May 2024 21:21:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20240502013138.2383421-43-trini@konsulko.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="0000000000003f2adb0617850d5d"
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

--0000000000003f2adb0617850d5d
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 05/01/2024 06:31 PM, Tom Rini wrote:
> Remove <common.h> from this driver directory and when needed
> add missing include files directly.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Stefan Roese <sr@denx.de>
> Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Cc: Michael Trimarchi <michael@amarulasolutions.com>
> Cc: Anand Gore <anand.gore@broadcom.com>
> Cc: William Zhang <william.zhang@broadcom.com>
> Cc: Kursad Oney <kursad.oney@broadcom.com>
> Cc: Joel Peshkin <joel.peshkin@broadcom.com>
> Cc: Philippe Reynes <philippe.reynes@softathome.com>
> Cc: Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Frieder Schrempf <frieder.schrempf@kontron.de>
> Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Jagan Teki <jagan@amarulasolutions.com>
> Cc: Vignesh R <vigneshr@ti.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Sean Anderson <seanga2@gmail.com>
> ---
>   drivers/mtd/altera_qspi.c                       | 1 -
>   drivers/mtd/cfi_flash.c                         | 3 ++-
>   drivers/mtd/cfi_mtd.c                           | 1 -
>   drivers/mtd/hbmc-am654.c                        | 1 -
>   drivers/mtd/jedec_flash.c                       | 1 -
>   drivers/mtd/mtd-uclass.c                        | 1 -
>   drivers/mtd/mtd_uboot.c                         | 1 -
>   drivers/mtd/mtdpart.c                           | 1 -
>   drivers/mtd/nand/bbt.c                          | 1 -
>   drivers/mtd/nand/core.c                         | 1 -
>   drivers/mtd/nand/raw/am335x_spl_bch.c           | 2 +-
>   drivers/mtd/nand/raw/arasan_nfc.c               | 1 -
>   drivers/mtd/nand/raw/atmel_nand.c               | 2 +-
>   drivers/mtd/nand/raw/brcmnand/bcm63158_nand.c   | 1 -
>   drivers/mtd/nand/raw/brcmnand/bcm6368_nand.c    | 1 -
>   drivers/mtd/nand/raw/brcmnand/bcm6753_nand.c    | 1 -
>   drivers/mtd/nand/raw/brcmnand/bcm68360_nand.c   | 1 -
>   drivers/mtd/nand/raw/brcmnand/bcm6838_nand.c    | 1 -
>   drivers/mtd/nand/raw/brcmnand/bcm6858_nand.c    | 1 -
>   drivers/mtd/nand/raw/brcmnand/brcmnand.c        | 1 -
>   drivers/mtd/nand/raw/brcmnand/brcmnand_compat.c | 1 -
>   drivers/mtd/nand/raw/brcmnand/iproc_nand.c      | 1 -
>   drivers/mtd/nand/raw/cortina_nand.c             | 1 -
>   drivers/mtd/nand/raw/davinci_nand.c             | 2 +-
>   drivers/mtd/nand/raw/denali.c                   | 1 -
>   drivers/mtd/nand/raw/denali_spl.c               | 2 +-
>   drivers/mtd/nand/raw/fsl_elbc_nand.c            | 2 +-
>   drivers/mtd/nand/raw/fsl_elbc_spl.c             | 2 +-
>   drivers/mtd/nand/raw/fsl_ifc_nand.c             | 2 +-
>   drivers/mtd/nand/raw/fsl_ifc_spl.c              | 2 +-
>   drivers/mtd/nand/raw/kirkwood_nand.c            | 1 -
>   drivers/mtd/nand/raw/kmeter1_nand.c             | 2 +-
>   drivers/mtd/nand/raw/lpc32xx_nand_mlc.c         | 2 +-
>   drivers/mtd/nand/raw/lpc32xx_nand_slc.c         | 2 +-
>   drivers/mtd/nand/raw/mxc_nand.c                 | 2 +-
>   drivers/mtd/nand/raw/mxc_nand_spl.c             | 2 +-
>   drivers/mtd/nand/raw/mxic_nand.c                | 1 -
>   drivers/mtd/nand/raw/mxs_nand.c                 | 1 -
>   drivers/mtd/nand/raw/mxs_nand_spl.c             | 1 -
>   drivers/mtd/nand/raw/nand.c                     | 2 +-
>   drivers/mtd/nand/raw/nand_base.c                | 1 -
>   drivers/mtd/nand/raw/nand_bbt.c                 | 1 -
>   drivers/mtd/nand/raw/nand_bch.c                 | 1 -
>   drivers/mtd/nand/raw/nand_ecc.c                 | 1 -
>   drivers/mtd/nand/raw/nand_ids.c                 | 1 -
>   drivers/mtd/nand/raw/nand_spl_load.c            | 2 +-
>   drivers/mtd/nand/raw/nand_spl_simple.c          | 2 +-
>   drivers/mtd/nand/raw/nand_timings.c             | 1 -
>   drivers/mtd/nand/raw/nand_util.c                | 1 -
>   drivers/mtd/nand/raw/omap_elm.c                 | 1 -
>   drivers/mtd/nand/raw/omap_gpmc.c                | 2 +-
>   drivers/mtd/nand/raw/pxa3xx_nand.c              | 1 -
>   drivers/mtd/nand/raw/rockchip_nfc.c             | 1 -
>   drivers/mtd/nand/raw/stm32_fmc2_nand.c          | 1 -
>   drivers/mtd/nand/raw/sunxi_nand.c               | 1 -
>   drivers/mtd/nand/raw/sunxi_nand_spl.c           | 1 -
>   drivers/mtd/nand/raw/tegra_nand.c               | 1 -
>   drivers/mtd/nand/raw/vf610_nfc.c                | 2 +-
>   drivers/mtd/nand/raw/zynq_nand.c                | 1 -
>   drivers/mtd/nand/spi/core.c                     | 1 -
>   drivers/mtd/nvmxip/nvmxip-uclass.c              | 1 -
>   drivers/mtd/nvmxip/nvmxip.c                     | 1 -
>   drivers/mtd/nvmxip/nvmxip_qspi.c                | 1 -
>   drivers/mtd/onenand/onenand_base.c              | 1 -
>   drivers/mtd/onenand/onenand_bbt.c               | 1 -
>   drivers/mtd/onenand/onenand_spl.c               | 3 ++-
>   drivers/mtd/onenand/onenand_uboot.c             | 2 +-
>   drivers/mtd/onenand/samsung.c                   | 1 -
>   drivers/mtd/renesas_rpc_hf.c                    | 1 -
>   drivers/mtd/spi/fsl_espi_spl.c                  | 2 +-
>   drivers/mtd/spi/sandbox.c                       | 1 -
>   drivers/mtd/spi/sf-uclass.c                     | 1 -
>   drivers/mtd/spi/sf_bootdev.c                    | 1 -
>   drivers/mtd/spi/sf_dataflash.c                  | 1 -
>   drivers/mtd/spi/sf_mtd.c                        | 1 -
>   drivers/mtd/spi/sf_probe.c                      | 1 -
>   drivers/mtd/spi/spi-nor-core.c                  | 1 -
>   drivers/mtd/spi/spi-nor-ids.c                   | 1 -
>   drivers/mtd/spi/spi-nor-tiny.c                  | 1 -
>   drivers/mtd/stm32_flash.c                       | 2 +-
>   drivers/mtd/ubispl/ubispl.c                     | 1 -
>   81 files changed, 25 insertions(+), 81 deletions(-)
> 

For drivers/mtd/nand/raw/brcmnand/*,
Reviewed-by: William Zhang <william.zhang@broadcom.com>


--0000000000003f2adb0617850d5d
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
YDZuuBJwnyCzevMoPtVYPharioL5H3BRnQi8YoTXH7/uRo33dewYFm474yFjwwnt82TFtveVZkVq
6h4WIQ4wTcwFfET8zMkELnGzS5SHCl8sPD+lNxxJ1JDZYwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRp3aWxsaWFtLnpoYW5nQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUq65GzwZxydFHjjYEU/9h
xHhPWlwwDQYJKoZIhvcNAQELBQADggEBAA2hGG3JPAdGPH0ZdohGUCIVjKz+U+EFuIDbS6A/5jqX
VhYAxZlzj7tSjUIM7G7IhyfqPC46GKJ/4x+Amz1Z6YxNGy71L68kYD6hIbBcA5AM42QBUufly6Oa
/ppSz3WoflVyFFQ5YXniZ+eU+2/cdnYZg4aVUnFjimOF5o3NfMLzOkhQNxbaDjFUfUYD8hKmU6v4
0vUBj8KZ9Gi1LIagLKUREn8jku0lcLsRbnJ5Ey5ScajC/FESPyYWasOW8j8/1EoJksmhbYGKNS6C
urb/KlmDGfVrIRYDbL0ckhGQIP5c6L+kSQZ2sHnQK0e0WgIaZYxaPYeY5u0GLCOze+3vyRMxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwxuh2XG3FXRL1W
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIHxYJZDagAyTQfpOriOjMSfsvWnq
mnxXQrCKWYXBeGB8MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0
MDUwMzA0MjEyMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQDCcsihLZ6kmnsirPor3tb8R1XeAOU5oilYs7sIX/vPUTsY
wmKEZ48sQqb7QyNLTVr/tHWIzXCG8DOc6S0tizGAVSqNqNtwjX8KYeJaLQu8Ug/P/qlDll7xIUrQ
SLQ6ye3II6h4WGSpRFttIrpfSarVTiP+ADLdy2zMdlgkCc17hW5NST7XM7x1ZHcNSdGiPlV08sbY
q+aP5AWaOd/xsAgxyN4DVKQEfVqv9wKMtkNjc1yp1mvRye/QH1HegRz4cuZvTEUIqRHWYPK+y2a9
SV91jcaLfsoH92CsnBVT9dRkKRIMAbWkkW6ma6sakLZvo/z0wQtq1+gww3APrBChhrXK
--0000000000003f2adb0617850d5d--
