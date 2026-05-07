Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84BB1CD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 22:25:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1320784BF6;
	Fri,  8 May 2026 00:25:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="slGmWxTW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C15E584C06; Fri,  8 May 2026 00:25:43 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF629849E0
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 00:25:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1778192740; x=1778797540; i=xypron.glpk@gmx.de;
 bh=QTP4qy56oEJtRazZ7fBUuwbCMXGYm/gjk0GbR25/ftA=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=slGmWxTWIP4Ugw/Bf92gDtwNPd3ub6XJR3ur9vF1E02usPnDzko+4DhnXwDtroZq
 CpZNgAEsetYqoBVjcJ0PkDy9F2hwkHguToNNCDnVy7DxHedIGODLifVB7PxyOj/P7
 0Q99c1RqymIPHhDaaKW3+ZTb0vOydBn7lZhNrx1dNiX1ZkI2Y1JZ2J12d2XQOSdKe
 FaU5bIWzfk7KPGmFVMoz+0twxEitXIqSvir+FtS4QBHdtk16Wb2h4PXKwH8Y3Yx+f
 m8YSnbV+69PVD33lrpfezAU8tuXl2b8pQ7MKV4yn0Ub7zhcN1k+JrjouVFaBb0m1I
 PQeg0x95Y4xVhFiSAg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7zBb-1vHcP92lPv-00uV63; Fri, 08
 May 2026 00:25:40 +0200
Date: Fri, 08 May 2026 00:25:37 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Ludwig Nussel <ludwig.nussel@siemens.com>, u-boot@lists.denx.de
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Raymond Mao <raymondmaoca@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: Re: [PATCH v3 1/4] qemu: overlay signature nodes
User-Agent: Thunderbird for Android
In-Reply-To: <20260507140624.v3.1.5f8ce2dc2b00328d29e64be2684b10d9f52c6a7b@changeid>
References: <20260507120735.310325-1-ludwig.nussel@siemens.com>
 <20260507140624.v3.1.5f8ce2dc2b00328d29e64be2684b10d9f52c6a7b@changeid>
Message-ID: <7A22E5F0-DE10-4FFC-BBCF-52592F4E4CD1@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uowRQzXxGlc0vjaFCdoJxDG29vVMB73bJjckQX6QMdKFbXKuxt6
 4UuXA6m4yfRexVR/jMgcpDZeU/yP6agmSjCTWK5gBk1CtZQ+LAg8+aeGTBDfzl+ephXIDSy
 ieGD6piefsigmb+077QCoNov8p0pbrKKNGm0bVz4guIL8p5X69qMoYJc2+gfwBXKwiZFYj/
 lWp1g40xtT/r+GxCmXvFA==
UI-OutboundReport: notjunk:1;M01:P0:Wzghw0pCpEU=;iDwLjyrRb7FBd6WjdVG0RKivSfR
 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
 w7Hu1NQ5vStgNXGlKOY4D1AZiaT5Ipxe9Ucs=
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

Am 7=2E Mai 2026 14:06:22 MESZ schrieb Ludwig Nussel <ludwig=2Enussel@sieme=
ns=2Ecom>:
>The keys trusted for FIT signature verification are supposed to be
>embedded in the device tree built into u-boot=2E When running in Qemu it'=
s
>convenient to use the device tree provided by the VM which doesn't know
>about signatures though=2E So merge both device trees at startup=2E

This patch only addreses a single architecture=2E But neither the title, n=
or the commit mentions this=2E Please, correct both=2E

Did you already start work on the missing architectures?

Best regards

Heinrich=20

>
>Signed-off-by: Ludwig Nussel <ludwig=2Enussel@siemens=2Ecom>
>
>---
>
>Changes in v3:
>- enable CONFIG_OF_OMIT_DTB=3Dn in defconfig
>- add error returns
>- document decission about dt merging direction
>
> board/emulation/qemu-arm/qemu-arm=2Ec | 50 +++++++++++++++++++++++++++--
> configs/qemu_arm64_defconfig        |  1 +
> 2 files changed, 48 insertions(+), 3 deletions(-)
>
>diff --git a/board/emulation/qemu-arm/qemu-arm=2Ec b/board/emulation/qemu=
-arm/qemu-arm=2Ec
>index 38f0ec5f2fb=2E=2Ef82bc81f4d5 100644
>--- a/board/emulation/qemu-arm/qemu-arm=2Ec
>+++ b/board/emulation/qemu-arm/qemu-arm=2Ec
>@@ -144,12 +144,56 @@ int dram_init_banksize(void)
> 	return 0;
> }
>=20
>+/* QEMU loads a generated DTB for us at the start of RAM=2E
>+ * When using signatures we may have a built-in FDT that contains our kn=
own
>+ * public keys nevertheless=2E So merge those nodes into QEMU's FDT=2E
>+ * We cannot merge the other way around (eg in fdtdec_board_setup()
>+ * or board_fix_fdt() at this stage as U-Boot might be started from
>+ * a ROM location=2E
>+ * At the same time U-Boot needs QEMU's FDT to initialize serial
>+ * devices even before relocation=2E
>+ */
> int board_fdt_blob_setup(void **fdtp)
> {
>-	/* QEMU loads a generated DTB for us at the start of RAM=2E */
>-	*fdtp =3D (void *)CFG_SYS_SDRAM_BASE;
>+	void *qemu_fdt =3D (void *)CFG_SYS_SDRAM_BASE;
>+	int ret =3D -EINVAL;
>=20
>-	return 0;
>+	if (fdt_check_header(qemu_fdt) !=3D 0) {
>+		log_err("Invalid QEMU FDT at %p\n", qemu_fdt);
>+		goto out;
>+	}
>+
>+	if (fdt_check_header(*fdtp) !=3D 0) {
>+		/* this was a perfectly normal condition before
>+		 * (CONFIG_OF_OMIT_DTB was set for qemu)=2E So to avoid
>+		 * breaking existing configs don't error out=2E This
>+		 * might mean that we don't have keys in case
>+		 * FIT_SIGNATURE is on=2E We can't know though as
>+		 * existing setups might have injected them into
>+		 * QEMUS's FDT already=2E
>+		 */
>+		ret =3D 0;
>+		goto out;
>+	}
>+
>+	log_debug("Found built-in FDT at %p=2E Merging into %p=2E=2E=2E\n", *fd=
tp, qemu_fdt);
>+
>+	ret =3D fdt_increase_size(qemu_fdt, 1024 + fdt_totalsize(*fdtp));
>+	if (ret) {
>+		log_err("Failed to resize FDT overlay: %s", fdt_strerror(ret));
>+		goto out;
>+	}
>+
>+	ret =3D fdt_overlay_apply_node(qemu_fdt, 0, (void *)*fdtp, 0);
>+	if (ret) {
>+		log_err("Failed to apply FDT overlay: %s\n", fdt_strerror(ret));
>+		goto out;
>+	}
>+
>+out:
>+	*fdtp =3D qemu_fdt;
>+
>+	return ret;
> }
>=20
> void enable_caches(void)
>diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
>index 68b80e28746=2E=2E0edf80b7aaa 100644
>--- a/configs/qemu_arm64_defconfig
>+++ b/configs/qemu_arm64_defconfig
>@@ -7,6 +7,7 @@ CONFIG_ENV_SIZE=3D0x40000
> CONFIG_ENV_SECT_SIZE=3D0x40000
> CONFIG_DEFAULT_DEVICE_TREE=3D"qemu-arm64"
> CONFIG_OF_LIBFDT_OVERLAY=3Dy
>+CONFIG_OF_OMIT_DTB=3Dn
> CONFIG_SYS_LOAD_ADDR=3D0x40200000
> CONFIG_DEBUG_UART_BASE=3D0x9000000
> CONFIG_DEBUG_UART_CLOCK=3D0

