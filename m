Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22001CD68F4
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 06:51:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45CB585DE0;
	Tue, 10 Oct 2023 08:51:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="b/eImMWD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC0B6831BE; Tue, 10 Oct 2023 08:51:34 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DB34831BE
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 08:51:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1696920679; x=1697525479; i=xypron.glpk@gmx.de;
 bh=0AJvUKeD3cdZQHImZWIbgtp6k8olrgEi7ftOZpd7jvI=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References;
 b=b/eImMWDd/H7mMTLZFjFZgVE+tVCeRkjuGEdEVKbf4KVSXKQFAPD7pOXJ9WtM56ZNV6djHxRskR
 xOHVbNFDhYBVHkTzKdv3K/YtBiM6oxxJUdtG2EajhWq/cbO05gMEdBwUgvhZRf1Zcztf3eiUnbUoJ
 FJe1ppCnL4lBgl5SGuEa/JzPODAaBHXJ6j1egWysTFliScL2O7UgdFDdO+siZu0sJG4QNIRmoGvhW
 Et2f6soBA7FuoaOvEkaGgfw/qSdI0lMTOORIxyRTdBv+4thnPU+hMAnCHZjhnvWUrbDAjIvPHgOoq
 q5cnHMqsYWcXh22EKBQ6g66ZwIngvaBXN5FA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M42nY-1qq6aN1BSK-00026P; Tue, 10
 Oct 2023 08:51:19 +0200
Date: Tue, 10 Oct 2023 08:51:15 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
CC: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Ramon Fried <rfried.dev@gmail.com>,
 Roger Knecht <rknecht@pm.me>, Sean Edmond <seanedmond@microsoft.com>,
 Simon Glass <sjg@chromium.org>, Tobias Waldekranz <tobias@waldekranz.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_cmd=3A_mmc=3A_Add_mmc_reg_re?=
 =?US-ASCII?Q?ad_command_for_reading_card_registers?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20231009231458.354400-1-marex@denx.de>
References: <20231009231458.354400-1-marex@denx.de>
Message-ID: <0881AE45-0209-40C8-B7A8-E9B3B3F22D74@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LHKewAgufyHLFPmIAJBgowct1lBJKd5xXW9jlr7GSlAOJ1Bf3as
 jbCIhrEZb2osCSdjUx3/ig2pNASpwoTkRLlnMEG0ZnwZmLoRz+roQ4ImvzWjyA6tNQGs6eo
 E9ByXPcfeNRG6YAoQTcVzrts5PDGB80OVlflfk+DMP8r6eLyHkmH1J5GOqdFcFP7sE6uaxG
 aloIok+1G94uEr4x0Fp3g==
UI-OutboundReport: notjunk:1;M01:P0:hTMeutb1d5E=;jWFZ92/huyEEPOOmjiNl9hT0Iye
 BcUIt9Dh/A0bzIgP5bC6+Kxq5aHceaudw/407q6EzpA+43/1RlvPn+FrxOtEt08YU9K4SfE6j
 l6euZbRr5NhGkyOrhySWlWsO8KscYvkaqXGx6+W8iy0/Lez77De8/TczXQAXjeTiT9mAmjDtk
 8i/IAylUvC5ZIjc374A2+MUPz7QQR8peUcB2ne/88nzQ3BqJ7lODH0XQ+Lv+Pgul4C/1RK2RU
 r42qvWvizI5wm7POgRMp74teakZSwqkuX6awp7WyRkWpkTe8RDCbEBce4od/+NZBc3AHwlhCu
 57sLqmK4KehIWyrFRMRQ7zV0GEy+wwE8GGiV0S6muXlHA+kb836ZOQAiJyNSiPPLpa3V/Y3cg
 3yBfEMF9M/Qnjx9gcpMwbVgzSzkm4RHpD79sA76fFd1EO5Uh2w+U+6xaPRaWjZEl3yqtEOMDs
 09ep5FduF9hQjPStmhK0zYQUBSIrMM0zY762GBBVa5v1Na2hQCLWseI8JkPHdBkpwq0zrXV1H
 KeGETdGNJ0DcYggpKJ+pts2yHcXeYHypea5Omz4Wgpn+XSg56ruTw8EPHGIaoSEggSNgXuVdf
 bLsqOoRjzq9elNR9PN26oBfF9tkw4ZDgQ+DaYH1PFM3muLOXJKIUbtEc5xKNw/mj9EVX0rG1T
 BVkCE1o44kQl7D/66A9zd0gxwB3xATzPa3AynSvvjrhTTYSr+m+qyeY+uy2O/NDwkzyjYAfMI
 u/XDGmu9I3d/hIJlzUWLVZ47qlms2MQGlpBRY6+MpT2BmoUyRfu3W3u6L6AwvWJal0VdnlBwn
 s6+BjXVMAxUZEdb7JZC/HS350FjNxz01JlLA+GficoHJjZZkWrAVBgy8vnuGyPu/yISNMz3MS
 zBq/UfvV+oZX+YM2T2H+xcrGJON8zhtKZBXe0bTVdPSti3X1j+bQ+nA27oKKxTvhkyrUf8Z/o
 wxM88A==
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



Am 10=2E Oktober 2023 01:14:58 MESZ schrieb Marek Vasut <marex@denx=2Ede>:
>Add extension to the 'mmc' command to read out the card registers=2E
>Currently, only the eMMC OCR/CID/CSD/EXTCSD/RCA/DSR register are
>supported=2E A register value can either be displayed or read into
>an environment variable=2E

Hello Marek,

could you, please, update doc/usage/cmd/mmc=2Erst=2E

Best regards

Heinrich

>
>Signed-off-by: Marek Vasut <marex@denx=2Ede>
>---
>Cc: Abdellatif El Khlifi <abdellatif=2Eelkhlifi@arm=2Ecom>
>Cc: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>
>Cc: Ilias Apalodimas <ilias=2Eapalodimas@linaro=2Eorg>
>Cc: Jaehoon Chung <jh80=2Echung@samsung=2Ecom>
>Cc: Ramon Fried <rfried=2Edev@gmail=2Ecom>
>Cc: Roger Knecht <rknecht@pm=2Eme>
>Cc: Sean Edmond <seanedmond@microsoft=2Ecom>
>Cc: Simon Glass <sjg@chromium=2Eorg>
>Cc: Tobias Waldekranz <tobias@waldekranz=2Ecom>
>---
> cmd/Kconfig |  8 +++++
> cmd/mmc=2Ec   | 96 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 104 insertions(+)
>
>diff --git a/cmd/Kconfig b/cmd/Kconfig
>index 6470b138d2f=2E=2Edcd99757a1e 100644
>--- a/cmd/Kconfig
>+++ b/cmd/Kconfig
>@@ -1307,6 +1307,14 @@ config CMD_BKOPS_ENABLE
> 	  on a eMMC device=2E The feature is optionally available on eMMC devic=
es
> 	  conforming to standard >=3D 4=2E41=2E
>=20
>+config CMD_MMC_REG
>+	bool "Enable support for reading card registers in the mmc command"
>+	depends on CMD_MMC
>+	default n
>+	help
>+	  Enable the commands for reading card registers=2E This is useful
>+	  mostly for debugging or extracting details from the card=2E
>+
> config CMD_MMC_RPMB
> 	bool "Enable support for RPMB in the mmc command"
> 	depends on SUPPORT_EMMC_RPMB
>diff --git a/cmd/mmc=2Ec b/cmd/mmc=2Ec
>index c6bd81cebbc=2E=2Ec29f44b7a18 100644
>--- a/cmd/mmc=2Ec
>+++ b/cmd/mmc=2Ec
>@@ -1110,6 +1110,93 @@ static int do_mmc_boot_wp(struct cmd_tbl *cmdtp, i=
nt flag,
> 	return CMD_RET_SUCCESS;
> }
>=20
>+#if CONFIG_IS_ENABLED(CMD_MMC_REG)
>+static int do_mmc_reg(struct cmd_tbl *cmdtp, int flag,
>+		      int argc, char *const argv[])
>+{
>+	ALLOC_CACHE_ALIGN_BUFFER(u8, ext_csd, MMC_MAX_BLOCK_LEN);
>+	struct mmc *mmc;
>+	int i, ret;
>+	u32 off;
>+
>+	if (argc < 3 || argc > 5)
>+		return CMD_RET_USAGE;
>+
>+	mmc =3D find_mmc_device(curr_device);
>+	if (!mmc) {
>+		printf("no mmc device at slot %x\n", curr_device);
>+		return CMD_RET_FAILURE;
>+	}
>+
>+	if (IS_SD(mmc)) {
>+		printf("SD registers are not supported\n");
>+		return CMD_RET_FAILURE;
>+	}
>+
>+	off =3D simple_strtoul(argv[3], NULL, 10);
>+	if (!strcmp(argv[2], "cid")) {
>+		if (off > 3)
>+			return CMD_RET_USAGE;
>+		printf("CID[%i]: 0x%08x\n", off, mmc->cid[off]);
>+		if (argv[4])
>+			env_set_hex(argv[4], mmc->cid[off]);
>+		return CMD_RET_SUCCESS;
>+	}
>+	if (!strcmp(argv[2], "csd")) {
>+		if (off > 3)
>+			return CMD_RET_USAGE;
>+		printf("CSD[%i]: 0x%08x\n", off, mmc->csd[off]);
>+		if (argv[4])
>+			env_set_hex(argv[4], mmc->csd[off]);
>+		return CMD_RET_SUCCESS;
>+	}
>+	if (!strcmp(argv[2], "dsr")) {
>+		printf("DSR: 0x%08x\n", mmc->dsr);
>+		if (argv[4])
>+			env_set_hex(argv[4], mmc->dsr);
>+		return CMD_RET_SUCCESS;
>+	}
>+	if (!strcmp(argv[2], "ocr")) {
>+		printf("OCR: 0x%08x\n", mmc->ocr);
>+		if (argv[4])
>+			env_set_hex(argv[4], mmc->ocr);
>+		return CMD_RET_SUCCESS;
>+	}
>+	if (!strcmp(argv[2], "rca")) {
>+		printf("RCA: 0x%08x\n", mmc->rca);
>+		if (argv[4])
>+			env_set_hex(argv[4], mmc->rca);
>+		return CMD_RET_SUCCESS;
>+	}
>+	if (!strcmp(argv[2], "extcsd") &&
>+	    mmc->version >=3D MMC_VERSION_4_41) {
>+		ret =3D mmc_send_ext_csd(mmc, ext_csd);
>+		if (ret)
>+			return ret;
>+		if (!strcmp(argv[3], "all")) {
>+			/* Dump the entire register */
>+			printf("EXT_CSD:");
>+			for (i =3D 0; i < MMC_MAX_BLOCK_LEN; i++) {
>+				if (!(i % 10))
>+					printf("\n%03i: ", i);
>+				printf(" %02x", ext_csd[i]);
>+			}
>+			printf("\n");
>+			return CMD_RET_SUCCESS;
>+		}
>+		off =3D simple_strtoul(argv[3], NULL, 10);
>+		if (off > 512)
>+			return CMD_RET_USAGE;
>+		printf("EXT_CSD[%i]: 0x%02x\n", off, ext_csd[off]);
>+		if (argv[4])
>+			env_set_hex(argv[4], ext_csd[off]);
>+		return CMD_RET_SUCCESS;
>+	}
>+
>+	return CMD_RET_FAILURE;
>+}
>+#endif
>+
> static struct cmd_tbl cmd_mmc[] =3D {
> 	U_BOOT_CMD_MKENT(info, 1, 0, do_mmcinfo, "", ""),
> 	U_BOOT_CMD_MKENT(read, 4, 1, do_mmc_read, "", ""),
>@@ -1142,6 +1229,9 @@ static struct cmd_tbl cmd_mmc[] =3D {
> 	U_BOOT_CMD_MKENT(bkops-enable, 2, 0, do_mmc_bkops_enable, "", ""),
> 	U_BOOT_CMD_MKENT(bkops, 4, 0, do_mmc_bkops, "", ""),
> #endif
>+#if CONFIG_IS_ENABLED(CMD_MMC_REG)
>+	U_BOOT_CMD_MKENT(reg, 5, 0, do_mmc_reg, "", ""),
>+#endif
> };
>=20
> static int do_mmcops(struct cmd_tbl *cmdtp, int flag, int argc,
>@@ -1229,6 +1319,12 @@ U_BOOT_CMD(
> 	"   WARNING: This is a write-once setting=2E\n"
> 	"mmc bkops <dev> [auto|manual] [enable|disable]\n"
> 	" - configure background operations handshake on device\n"
>+#endif
>+#if CONFIG_IS_ENABLED(CMD_MMC_REG)
>+	"mmc reg read <reg> <offset> [env] - read card register <reg> offset <o=
ffset>\n"
>+	"                                    (optionally into [env] variable)\n=
"
>+	" - reg: cid/csd/dsr/ocr/rca/extcsd\n"
>+	" - offset: for cid/csd [0=2E=2E3], for extcsd [0=2E=2E511,all]\n"
> #endif
> 	);
>=20
