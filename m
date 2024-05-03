Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C952C4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 04:34:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04E8988BB9;
	Fri,  3 May 2024 06:34:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="Wm+eJIhf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20EB388AC0; Fri,  3 May 2024 06:25:45 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B7EC8831B
 for <u-boot@lists.denx.de>; Fri,  3 May 2024 06:25:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=broadcom.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=william.zhang@broadcom.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-78ef9ce897bso604591685a.0
 for <u-boot@lists.denx.de>; Thu, 02 May 2024 21:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1714710341; x=1715315141; darn=lists.denx.de;
 h=in-reply-to:mime-version:user-agent:date:message-id:from:references
 :cc:to:subject:from:to:cc:subject:date:message-id:reply-to;
 bh=G4rX5gzTaND45dSQv/lIlABxYCVUUsz0t/aHB39NjQ8=;
 b=Wm+eJIhfJMqea0SQFOVxZKnnkZSOREUQfSlm0x2FXM4kG5m4Ze1fE9Tq3jrMsI7qVS
 S7aJSC7+paeaTmV2fhNiMhjhkOFDA/dIym8uzleCzH6zeL3LHwt34c1Mt/akfzzNLV23
 Q1L0+J89Wr+aOI500fEHeOLYfJ/Q8JifZoOFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714710341; x=1715315141;
 h=in-reply-to:mime-version:user-agent:date:message-id:from:references
 :cc:to:subject:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G4rX5gzTaND45dSQv/lIlABxYCVUUsz0t/aHB39NjQ8=;
 b=wNFxp6F9SxNDjiBTdpB6UEVp2p0BkRwAtElMe+rydGrsPTyhxiq6qfLdPHkJSeEVXf
 b3vIRJlKkzsLj/De/pGHh8lvGem9VhfqIlwkhpVrt74k5Qsa9wglxHyhIxgWuFxnjdcQ
 bQN/ct3WIM+anUJxA+2N9ZGVV3g51uH5oLX4n4KG5K9t/0krtaXcSR8YLakAJAZmwPCZ
 FixvQxfDb+/roeYAh+dOCPKcwyYU8zMYnqz8DBflZq47iV5M84OvUyiSuAawa7g3nm+q
 Ci6m2uzQuMirrE6LPfkhy+89FmD3BzTArzSLxqQtAB4nrMF/rlOqIGb2JCtCYRax4YWv
 +ONg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpN3wpn1YhGbFbyUoLMb/J0XIKwo7Ytaxl+Zo7md5DIXG+M+Vel6S1TFRJ3Ek1GlQKt/qnaiVwq5+cFYURNI1bkE0UVw==
X-Gm-Message-State: AOJu0YwDQCXpXtrGINaR03baTDr0XngjHMhjDi6Bk2fOSBrMKOpqFqcS
 tHdpSHlNGqHsjWPaYVmOaYL7myBIXZoHow0y1qmbatztmAsbDdGMkclINT5QHA==
X-Google-Smtp-Source: AGHT+IGtTsAxXm4Z1zF1ALePbW6iK1CaAVOWhLxhaHAbTuinsWfgX1Nk9OUfq2A45nie+xTdga8lfw==
X-Received: by 2002:a05:6214:27e4:b0:6a0:af07:1089 with SMTP id
 jt4-20020a05621427e400b006a0af071089mr1643698qvb.55.1714710341137; 
 Thu, 02 May 2024 21:25:41 -0700 (PDT)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
 by smtp.gmail.com with ESMTPSA id
 u4-20020a0cee84000000b006a0f4777dd5sm893819qvr.13.2024.05.02.21.25.37
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 02 May 2024 21:25:40 -0700 (PDT)
Subject: Re: [PATCH 65/81] spi: Remove <common.h> and add needed includes
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Anand Gore <anand.gore@broadcom.com>, Kursad Oney
 <kursad.oney@broadcom.com>, Philippe Reynes
 <philippe.reynes@softathome.com>,
 Alex Nemirovsky <alex.nemirovsky@cortina-access.com>,
 Michal Simek <michal.simek@amd.com>, Stefan Roese <sr@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Lars Povlsen <lars.povlsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass
 <sjg@chromium.org>, Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Robert Marko <robert.marko@sartura.hr>,
 Luka Kovacic <luka.kovacic@sartura.hr>, Luka Perkov
 <luka.perkov@sartura.hr>, Masahisa Kojima <kojima.masahisa@socionext.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Dai Okamura <okamura.dai@socionext.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
 <20240502013138.2383421-65-trini@konsulko.com>
From: William Zhang <william.zhang@broadcom.com>
Message-ID: <c96d27d4-6077-b6b7-3e7b-7219e6a2ee7c@broadcom.com>
Date: Thu, 2 May 2024 21:25:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20240502013138.2383421-65-trini@konsulko.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="000000000000ccef870617851c81"
X-Mailman-Approved-At: Fri, 03 May 2024 06:34:38 +0200
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

--000000000000ccef870617851c81
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit



On 05/01/2024 06:31 PM, Tom Rini wrote:
> Remove <common.h> from this driver directory and when needed
> add missing include files directly.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Jagan Teki <jagan@amarulasolutions.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Anand Gore <anand.gore@broadcom.com>
> Cc: William Zhang <william.zhang@broadcom.com>
> Cc: Kursad Oney <kursad.oney@broadcom.com>
> Cc: Joel Peshkin <joel.peshkin@broadcom.com>
> Cc: Philippe Reynes <philippe.reynes@softathome.com>
> Cc: Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Stefan Roese <sr@denx.de>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Gregory CLEMENT <gregory.clement@bootlin.com>
> Cc: Lars Povlsen <lars.povlsen@microchip.com>
> Cc: Horatiu Vultur <horatiu.vultur@microchip.com>
> Cc: Ryder Lee <ryder.lee@mediatek.com>
> Cc: Weijie Gao <weijie.gao@mediatek.com>
> Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> Cc: "Cédric Le Goater" <clg@kaod.org>
> Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>
> Cc: Ryan Chen <ryan_chen@aspeedtech.com>
> Cc: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Robert Marko <robert.marko@sartura.hr>
> Cc: Luka Kovacic <luka.kovacic@sartura.hr>
> Cc: Luka Perkov <luka.perkov@sartura.hr>
> Cc: Masahisa Kojima <kojima.masahisa@socionext.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Cc: Dai Okamura <okamura.dai@socionext.com>
> ---
>   drivers/spi/altera_spi.c          | 1 -
>   drivers/spi/apple_spi.c           | 1 -
>   drivers/spi/atcspi200_spi.c       | 1 -
>   drivers/spi/ath79_spi.c           | 1 -
>   drivers/spi/atmel-quadspi.c       | 1 -
>   drivers/spi/atmel_spi.c           | 1 -
>   drivers/spi/bcm63xx_hsspi.c       | 1 -
>   drivers/spi/bcm63xx_spi.c         | 1 -
>   drivers/spi/bcmbca_hsspi.c        | 1 -
>   drivers/spi/ca_sflash.c           | 1 -
>   drivers/spi/cadence_ospi_versal.c | 1 -
>   drivers/spi/cadence_qspi.c        | 1 -
>   drivers/spi/cadence_qspi_apb.c    | 1 -
>   drivers/spi/cf_spi.c              | 1 -
>   drivers/spi/davinci_spi.c         | 2 +-
>   drivers/spi/designware_spi.c      | 1 -
>   drivers/spi/exynos_spi.c          | 1 -
>   drivers/spi/fsl_dspi.c            | 1 -
>   drivers/spi/fsl_espi.c            | 2 +-
>   drivers/spi/fsl_qspi.c            | 1 -
>   drivers/spi/ich.c                 | 1 -
>   drivers/spi/iproc_qspi.c          | 1 -
>   drivers/spi/kirkwood_spi.c        | 2 +-
>   drivers/spi/meson_spifc.c         | 1 -
>   drivers/spi/microchip_coreqspi.c  | 1 -
>   drivers/spi/mpc8xx_spi.c          | 1 -
>   drivers/spi/mpc8xxx_spi.c         | 1 -
>   drivers/spi/mscc_bb_spi.c         | 1 -
>   drivers/spi/mt7621_spi.c          | 1 -
>   drivers/spi/mtk_snfi_spi.c        | 1 -
>   drivers/spi/mtk_snor.c            | 1 -
>   drivers/spi/mvebu_a3700_spi.c     | 1 -
>   drivers/spi/mxc_spi.c             | 2 +-
>   drivers/spi/mxs_spi.c             | 1 -
>   drivers/spi/npcm_pspi.c           | 1 -
>   drivers/spi/nxp_fspi.c            | 1 -
>   drivers/spi/omap3_spi.c           | 2 +-
>   drivers/spi/pic32_spi.c           | 1 -
>   drivers/spi/pl022_spi.c           | 1 -
>   drivers/spi/renesas_rpc_spi.c     | 1 -
>   drivers/spi/rk_spi.c              | 1 -
>   drivers/spi/sandbox_spi.c         | 1 -
>   drivers/spi/sh_qspi.c             | 1 -
>   drivers/spi/soft_spi.c            | 1 -
>   drivers/spi/spi-aspeed-smc.c      | 1 -
>   drivers/spi/spi-emul-uclass.c     | 1 -
>   drivers/spi/spi-mem.c             | 1 -
>   drivers/spi/spi-mxic.c            | 1 -
>   drivers/spi/spi-qup.c             | 1 -
>   drivers/spi/spi-sifive.c          | 1 -
>   drivers/spi/spi-sn-f-ospi.c       | 1 -
>   drivers/spi/spi-sunxi.c           | 1 -
>   drivers/spi/spi-synquacer.c       | 1 -
>   drivers/spi/spi-uclass.c          | 1 -
>   drivers/spi/spi.c                 | 1 -
>   drivers/spi/stm32_qspi.c          | 1 -
>   drivers/spi/stm32_spi.c           | 1 -
>   drivers/spi/tegra114_spi.c        | 1 -
>   drivers/spi/tegra20_sflash.c      | 1 -
>   drivers/spi/tegra20_slink.c       | 1 -
>   drivers/spi/tegra210_qspi.c       | 1 -
>   drivers/spi/ti_qspi.c             | 1 -
>   drivers/spi/uniphier_spi.c        | 1 -
>   drivers/spi/xilinx_spi.c          | 1 -
>   drivers/spi/zynq_qspi.c           | 1 -
>   drivers/spi/zynq_spi.c            | 1 -
>   drivers/spi/zynqmp_gqspi.c        | 1 -
>   67 files changed, 5 insertions(+), 67 deletions(-)
> 

For drivers/spi/bcm63xx_hsspi.c and drivers/spi/bcmbca_hsspi.c
Reviewed-by: William Zhang <william.zhang@broadcom.com>

--000000000000ccef870617851c81
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
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIBeF2EISvS0wUn46BCmSe6FLqXfX
paEcaBb0zm9tmL4zMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0
MDUwMzA0MjU0MVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQBnD6yyDyjF0pvuVRR/1Ca6vKd5XZfvGYoJl+zihfwY2m/h
THzttZBM10sjs+AixXJONUjgxEDNTl07vPITgdJ2iWoUqzzZshiXPgujKLc/SxgYFhaMuPS9R9CM
ChUSpcRSrPsv3d3UqKUiEwEgrOxBZRl1GxO1wS1+9wdAGCjXSZWSJKjCWHHyspWaGVx+TCzfxh8B
YyBlEzXPEE49DB92Wr7Ch+XQ0TyWqlRkNlGkN45wlncJ13ZXGxT4bkCQS30aMju2JESldmPVhGkd
sC2DNfsl2K8mY5qIejVQ2IGRYlcAhb/qmoBdRRvuQUXcPucV6s6WqZsuraN8FP2ltOU3
--000000000000ccef870617851c81--
