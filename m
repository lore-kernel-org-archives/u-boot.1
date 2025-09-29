Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B52CCAC5B5
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 08:50:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F392C83071;
	Mon, 29 Sep 2025 10:50:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="YHsGVaCw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA8A383189; Mon, 29 Sep 2025 10:50:31 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDB4F808AF
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 10:50:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1759135816; x=1759740616; i=xypron.glpk@gmx.de;
 bh=p6ToyX9mzpniIwMxZZE1xAn72s3KG4i41mC7UvjUbvc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=YHsGVaCwlkxZ88U2LfDTijdg2ICpznILpgdmAjddE487852NWb6LCrKmrS0b5dfc
 fRuQ55mxc5vLMyln9O6iU0XymEB/1sgRzgFDCqCPZcTY4VgRQ8Qw/sBEgv9KUSZaa
 TOEfCAjZLb+p/GJinhsCuZE3Wby+sqvbxEQwU75ddfFDca/ptcI8rofMhy87Qof22
 XEL+BgCpA9CgrGarV9I4E03QNKJlM3kImsCZkUycAqJvgfVJYh7TnpEIB2BsYSSs3
 PHtA2weMv54V5j2nP0SXqRf1WeCx7GtgEPNiyl1mGHld8OTo019G2WfQ7B9TGRBH/
 N6ILxyjfwgZqUwI2rA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.116] ([5.147.80.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N9Mta-1uHyvT35Sm-010yxJ; Mon, 29
 Sep 2025 10:50:15 +0200
Message-ID: <1dedd6e9-16da-49b4-aeba-3b5ae478b8ac@gmx.de>
Date: Mon, 29 Sep 2025 10:50:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: Enable sntp command
To: Michal Simek <michal.simek@amd.com>
Cc: Anshul Dalal <anshuld@ti.com>, Fabio Estevam <festevam@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Herren <sputnik@on-the-web.ch>,
 Padmarao Begari <padmarao.begari@amd.com>, Peng Fan <peng.fan@nxp.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 T Karthik Reddy <t.karthik.reddy@xilinx.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de,
 git@amd.com
References: <8259ca2496dd8f6a25df566c43f16be019d75cb9.1759127081.git.michal.simek@amd.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <8259ca2496dd8f6a25df566c43f16be019d75cb9.1759127081.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/nXqID3/5t4F2KqR2Xra/PMlTxWuvaP+cYwxdRvQJpLm0xj7nBU
 SsYxwxrrQA2hbrxV+e2b4LE4/YvtmA92vFIXhh+oo8OK1DOhLPEjm5g0KozEkAB6uT8kY03
 honwO88oE9jazF2elHHo4UfbpVJGFcWTiei5DbtGCrPhK0rIa/TplEjSSIlZFE0e2HH13AO
 QIK0zrSp7g5kH96dvwDdg==
UI-OutboundReport: notjunk:1;M01:P0:fomADTeurVU=;CkjobACEf+rlaM92KSskiNysTyI
 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
 CF6yv+P0DJ6S03OmWzIRQw/o8cA4at36250=
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

On 9/29/25 08:24, Michal Simek wrote:
> Enable SNTP commands on all Xilinx boards.

Would it make sense to enable CONFIG_RTC_EMULATION on those boards that=20
don't have an RTC like amd_versal2_virt_defconfig? For instance FAT=20
write uses the date from the RTC.

For boards that have an RTC (emulated or not) CONFIG_CMD_DATE may be=20
helpful.

Best regard

Heinrich

>=20
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>=20
>   configs/amd_versal2_virt_defconfig       | 1 +
>   configs/microblaze-generic_defconfig     | 1 +
>   configs/xilinx_mbv32_defconfig           | 1 +
>   configs/xilinx_mbv32_smode_defconfig     | 1 +
>   configs/xilinx_mbv64_defconfig           | 1 +
>   configs/xilinx_mbv64_smode_defconfig     | 1 +
>   configs/xilinx_versal_net_virt_defconfig | 1 +
>   configs/xilinx_versal_virt_defconfig     | 1 +
>   configs/xilinx_zynq_virt_defconfig       | 2 +-
>   configs/xilinx_zynqmp_kria_defconfig     | 1 +
>   configs/xilinx_zynqmp_virt_defconfig     | 1 +
>   11 files changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_vi=
rt_defconfig
> index 5791f0415c95..4a7bc1951451 100644
> --- a/configs/amd_versal2_virt_defconfig
> +++ b/configs/amd_versal2_virt_defconfig
> @@ -48,6 +48,7 @@ CONFIG_CMD_SF_TEST=3Dy
>   CONFIG_CMD_SPI=3Dy
>   CONFIG_CMD_UFS=3Dy
>   CONFIG_CMD_USB=3Dy
> +CONFIG_CMD_SNTP=3Dy
>   CONFIG_WGET_HTTPS=3Dy
>   CONFIG_CMD_CACHE=3Dy
>   CONFIG_CMD_EFIDEBUG=3Dy
> diff --git a/configs/microblaze-generic_defconfig b/configs/microblaze-g=
eneric_defconfig
> index 07612ef5e932..e26613ce9099 100644
> --- a/configs/microblaze-generic_defconfig
> +++ b/configs/microblaze-generic_defconfig
> @@ -49,6 +49,7 @@ CONFIG_CMD_GPIO=3Dy
>   CONFIG_CMD_SAVES=3Dy
>   CONFIG_BOOTP_BOOTFILESIZE=3Dy
>   CONFIG_CMD_TFTPPUT=3Dy
> +CONFIG_CMD_SNTP=3Dy
>   CONFIG_CMD_CACHE=3Dy
>   CONFIG_SPL_OF_CONTROL=3Dy
>   CONFIG_OF_EMBED=3Dy
> diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defco=
nfig
> index e3341179a682..2bf1f33585ec 100644
> --- a/configs/xilinx_mbv32_defconfig
> +++ b/configs/xilinx_mbv32_defconfig
> @@ -32,6 +32,7 @@ CONFIG_SPL_MAX_SIZE=3D0x40000
>   CONFIG_SPL_HAVE_INIT_STACK=3Dy
>   CONFIG_SPL_SYS_MALLOC=3Dy
>   # CONFIG_CMD_MII is not set
> +CONFIG_CMD_SNTP=3Dy
>   CONFIG_CMD_TIMER=3Dy
>   CONFIG_ENV_RELOC_GD_ENV_ADDR=3Dy
>   CONFIG_SPL_DM_SEQ_ALIAS=3Dy
> diff --git a/configs/xilinx_mbv32_smode_defconfig b/configs/xilinx_mbv32=
_smode_defconfig
> index c95b44973952..b9263940041e 100644
> --- a/configs/xilinx_mbv32_smode_defconfig
> +++ b/configs/xilinx_mbv32_smode_defconfig
> @@ -34,6 +34,7 @@ CONFIG_SPL_HAVE_INIT_STACK=3Dy
>   CONFIG_SPL_SYS_MALLOC=3Dy
>   CONFIG_SPL_OPENSBI_SCRATCH_OPTIONS=3D0x2
>   # CONFIG_CMD_MII is not set
> +CONFIG_CMD_SNTP=3Dy
>   CONFIG_CMD_TIMER=3Dy
>   CONFIG_ENV_RELOC_GD_ENV_ADDR=3Dy
>   CONFIG_SPL_DM_SEQ_ALIAS=3Dy
> diff --git a/configs/xilinx_mbv64_defconfig b/configs/xilinx_mbv64_defco=
nfig
> index a3cc1a5669e5..6216ba855b34 100644
> --- a/configs/xilinx_mbv64_defconfig
> +++ b/configs/xilinx_mbv64_defconfig
> @@ -33,6 +33,7 @@ CONFIG_SPL_MAX_SIZE=3D0x40000
>   CONFIG_SPL_HAVE_INIT_STACK=3Dy
>   CONFIG_SPL_SYS_MALLOC=3Dy
>   # CONFIG_CMD_MII is not set
> +CONFIG_CMD_SNTP=3Dy
>   CONFIG_CMD_TIMER=3Dy
>   CONFIG_ENV_RELOC_GD_ENV_ADDR=3Dy
>   CONFIG_SPL_DM_SEQ_ALIAS=3Dy
> diff --git a/configs/xilinx_mbv64_smode_defconfig b/configs/xilinx_mbv64=
_smode_defconfig
> index 3d49670c60c4..a3ea779076d6 100644
> --- a/configs/xilinx_mbv64_smode_defconfig
> +++ b/configs/xilinx_mbv64_smode_defconfig
> @@ -35,6 +35,7 @@ CONFIG_SPL_HAVE_INIT_STACK=3Dy
>   CONFIG_SPL_SYS_MALLOC=3Dy
>   CONFIG_SPL_OPENSBI_SCRATCH_OPTIONS=3D0x2
>   # CONFIG_CMD_MII is not set
> +CONFIG_CMD_SNTP=3Dy
>   CONFIG_CMD_TIMER=3Dy
>   CONFIG_ENV_RELOC_GD_ENV_ADDR=3Dy
>   CONFIG_SPL_DM_SEQ_ALIAS=3Dy
> diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_v=
ersal_net_virt_defconfig
> index 13d89c473392..770bd0643c19 100644
> --- a/configs/xilinx_versal_net_virt_defconfig
> +++ b/configs/xilinx_versal_net_virt_defconfig
> @@ -46,6 +46,7 @@ CONFIG_MMC_SPEED_MODE_SET=3Dy
>   CONFIG_CMD_MTD=3Dy
>   CONFIG_CMD_SF_TEST=3Dy
>   CONFIG_CMD_USB=3Dy
> +CONFIG_CMD_SNTP=3Dy
>   CONFIG_WGET_HTTPS=3Dy
>   CONFIG_CMD_CACHE=3Dy
>   CONFIG_CMD_EFIDEBUG=3Dy
> diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versa=
l_virt_defconfig
> index 52142bcc7b2c..ac78dea587cd 100644
> --- a/configs/xilinx_versal_virt_defconfig
> +++ b/configs/xilinx_versal_virt_defconfig
> @@ -52,6 +52,7 @@ CONFIG_MMC_SPEED_MODE_SET=3Dy
>   CONFIG_CMD_MTD=3Dy
>   CONFIG_CMD_SF_TEST=3Dy
>   CONFIG_CMD_USB=3Dy
> +CONFIG_CMD_SNTP=3Dy
>   CONFIG_WGET_HTTPS=3Dy
>   CONFIG_CMD_CACHE=3Dy
>   CONFIG_CMD_EFIDEBUG=3Dy
> diff --git a/configs/xilinx_zynq_virt_defconfig b/configs/xilinx_zynq_vi=
rt_defconfig
> index 4412f52bbd2e..c4f9df16a0fe 100644
> --- a/configs/xilinx_zynq_virt_defconfig
> +++ b/configs/xilinx_zynq_virt_defconfig
> @@ -33,7 +33,6 @@ CONFIG_FIT_VERBOSE=3Dy
>   CONFIG_SPL_FIT_PRINT=3Dy
>   CONFIG_SPL_LOAD_FIT=3Dy
>   CONFIG_SPL_LOAD_FIT_ADDRESS=3D0x10000000
> -CONFIG_LEGACY_IMAGE_FORMAT=3Dy
>   CONFIG_DISTRO_DEFAULTS=3Dy
>   # CONFIG_ARCH_FIXUP_FDT_MEMORY is not set
>   CONFIG_USE_PREBOOT=3Dy
> @@ -71,6 +70,7 @@ CONFIG_CMD_MTD=3Dy
>   CONFIG_CMD_NAND_LOCK_UNLOCK=3Dy
>   CONFIG_CMD_SF_TEST=3Dy
>   CONFIG_CMD_USB=3Dy
> +CONFIG_CMD_SNTP=3Dy
>   CONFIG_CMD_CACHE=3Dy
>   CONFIG_CMD_EFIDEBUG=3Dy
>   CONFIG_CMD_TIME=3Dy
> diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqm=
p_kria_defconfig
> index a99462864106..1e0728fa4f3f 100644
> --- a/configs/xilinx_zynqmp_kria_defconfig
> +++ b/configs/xilinx_zynqmp_kria_defconfig
> @@ -82,6 +82,7 @@ CONFIG_CMD_SDRAM=3Dy
>   CONFIG_CMD_SF_TEST=3Dy
>   CONFIG_CMD_SPI=3Dy
>   CONFIG_CMD_USB=3Dy
> +CONFIG_CMD_SNTP=3Dy
>   CONFIG_WGET_HTTPS=3Dy
>   CONFIG_CMD_BMP=3Dy
>   CONFIG_CMD_CACHE=3Dy
> diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqm=
p_virt_defconfig
> index b45ac8063fc3..6e4ba7269f85 100644
> --- a/configs/xilinx_zynqmp_virt_defconfig
> +++ b/configs/xilinx_zynqmp_virt_defconfig
> @@ -81,6 +81,7 @@ CONFIG_CMD_SDRAM=3Dy
>   CONFIG_CMD_SF_TEST=3Dy
>   CONFIG_CMD_SPI=3Dy
>   CONFIG_CMD_USB=3Dy
> +CONFIG_CMD_SNTP=3Dy
>   CONFIG_WGET_HTTPS=3Dy
>   CONFIG_CMD_BMP=3Dy
>   CONFIG_CMD_CACHE=3Dy

