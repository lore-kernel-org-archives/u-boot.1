Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E5C2E7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 08:18:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE44B80141;
	Fri, 13 Dec 2024 09:18:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="IjpAjaDB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD7BB8018E; Fri, 13 Dec 2024 09:18:27 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30E0D8012C
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 09:18:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1734077887; x=1734682687; i=xypron.glpk@gmx.de;
 bh=WiQI/n4cRHCNEHaxjfIWTvNYyGy1xnzwVeXjLsjkpUE=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=IjpAjaDBG45ckph4CegyKtPVIHJJEJRIPFeTkPezHK/+ky161hQoJbB5DfrwsMwx
 XIomPA/O2cDda1kr7aVuE55S/2B8o4z8AisRkaGnbWxnP3BMZK2fa27svi+22O+qe
 DPApEO3JOJISA1rSQNzt1aiz1VLNG0QIi6GvTMQ6g5jnI7dgAspMP/WFl01QImMjQ
 TXVWg17hLUhfblsEiG3OqPwd0zbdppOOPum9IVD6Ri2bSfsvcQkY/aMkXiUogdPI8
 Q+s+clOydqEXI/yOJcZGOAJA1E/bW55RwRseSmRvZrYO7bGYVhliCdSOePig4tcW6
 /+dG7naarBnHBEjYvw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.110.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6Daq-1tFQE31tPs-0084R7; Fri, 13
 Dec 2024 09:18:07 +0100
Date: Fri, 13 Dec 2024 09:18:05 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
CC: michal.simek@amd.com, trini@konsulko.com, sjg@chromium.org,
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org,
 jerome.forissier@linaro.org, mkorpershoek@baylibre.com,
 akashi.tkhro@gmail.com, francis.laniel@amarulasolutions.com,
 ddrokosov@salutedevices.com, git@amd.com
Subject: Re: [PATCH] cmd: Add support for optee hello world ta command
User-Agent: Thunderbird for Android
In-Reply-To: <20241213070149.1089009-1-venkatesh.abbarapu@amd.com>
References: <20241213070149.1089009-1-venkatesh.abbarapu@amd.com>
Message-ID: <2A80F209-C9F9-4CF0-944C-AFA860554BE8@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rQ37SKb6gCn4g/xziBHVmwmuidJT6BMmzYF/v5iVfaUY1JENVMA
 apXtE7g+vsG7d28tnOLBc7BAAlbKfhTLfW+mg2uw8wgdsIMr5OQMFof/58mrMIWMoRws46a
 0OBqi2Y8ypC3kPLswr14HdsNdvYI2u+v4YdhivbDnAhkk6oPfOvXLi248s5MpubsNtR26iR
 vLAbLgdgBP4t2b0ayB5uw==
UI-OutboundReport: notjunk:1;M01:P0:rd9RPU7YT68=;D7PncSM7N3zjmmLgx5XiKrPyWLY
 XRaK0K3QcNtnihtkgRB7WCvf7tJAcwROvfJdXD1nkXmzKOEuMtzgToB2iSauZqdp4D6igQhw+
 DrWTOkvmBv53QJjK2sbMsPmfDQvuNawXne8kK98V6DfPOjqDh6abwffDo21xNRHOLgQFWTuO/
 SqADGMnBCOpWGB+PyyijZ+vfIUyOUh6B2DGEibEClxItr43NiKq2FZ/QABX3K73ZgzB+CDU++
 NuBcLRTIfSZJiilRT+P8dc9J+Cf204/UCLO884HQbmCM/63Eb3PR4HaUeZqsDKdhGpQ64u/cZ
 YAUidanAyCcR2bxyuIpK1pCI6JNIuxsJkFxpzQKpgGDf25hQfg3ujQtox56qxpZnYPM1l3B7U
 hpGrMsxD7VyWyGBQZgszsaD1qNmDNntpnZ0YipMrWAKQWzma3T6vnsxaSDp7oxStMKj10OHud
 vbN7GukEhyqjE2nIJnDtDAiYTY5mcdwMdCv1BP9yYmRIUlCvAgR9eQPqr++WtXicESk6eebft
 cpqK7oYPOFnABlC+767BejRfULoe4upJYD9MjhEl+7FRx8+0fCyVxHSZPa5DOhVnqMAmwN678
 +fj0oDtS4186+cgDrNFYO6oPKY7PIK09DQWjiTUmVjIYjmeCEy1p+SpfUWvuy1rU3k7eTM54y
 o6vnhByIC+f30HK+zgUbdRfOqgD/MGVtq9YOvoK7XMfGmUTyZngqsk+kju2r+wNnki27jOoOB
 Wb0sjRqvoDw5jF3BGyAK43SCQ5NED8bZVuY6zRRzg+ETmQ+HOFaf5JsDzhionxIsfFOFJPy5X
 yGnKRIDZB9pSL1HeRXKmhd1PAVdmg2MieYAPAeXdkgK1JpJp8AlaBAXMTifaGGwhcM9C4lno6
 gMc4V0C8RkyJukYPoJzuAy0y6eEYjmMl+L+N/WmDGb8lFvxhBluaxE5KYbmVYNT6Eg407GoWF
 Bf5c60aPHpDxfe8fP88qSRz0M8nJC6wwspccRUwddJcVKGBdXJlV+u8jYujWIyk8bCsRij4hd
 uo2+8VD1DNvVb5TZNYVMiwy/W0nB4waOJeSAR/BQhEeNv+WgnfpW+Bw7pnhsXUg12NbMa1AXW
 xwHia+HcR4q4d9On+4G6F4pysA+whZ
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

Am 13=2E Dezember 2024 08:01:49 MEZ schrieb Venkatesh Yadav Abbarapu <venka=
tesh=2Eabbarapu@amd=2Ecom>:
>Enable "hello_world_ta" command which increments the value passed=2E
>This provides easy test for establishing a session with OPTEE
>TA and verify=2E
>
>It includes following subcommands:
>hello_world_ta write_value value: value to increment via OPTEE HELLO
>WORLD TA=2E
>
>To enable the OPTEE side HELLO WORLD example please refer
>https://optee=2Ereadthedocs=2Eio/en/latest/building/gits/optee_examples/o=
ptee_examples=2Ehtml
>
>Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh=2Eabbarapu@amd=2Ecom>
>---
> cmd/Kconfig                |  8 ++++
> cmd/Makefile               |  1 +
> cmd/optee_hello_world_ta=2Ec | 98 ++++++++++++++++++++++++++++++++++++++

Each CLI command should be documented=2E Please, provide a man-page in doc=
/usage/cmd/


> 3 files changed, 107 insertions(+)
> create mode 100644 cmd/optee_hello_world_ta=2Ec
>
>diff --git a/cmd/Kconfig b/cmd/Kconfig
>index 1d7ddb4ed36=2E=2Ef1f8d1b9571 100644
>--- a/cmd/Kconfig
>+++ b/cmd/Kconfig
>@@ -1446,6 +1446,14 @@ config CMD_OPTEE_RPMB
> 	  in the Replay Protection Memory Block partition in eMMC by
> 	  using Persistent Objects in OPTEE
>=20
>+config CMD_OPTEE_HELLO_WORLD
>+	bool "Enable Hello world TA"
>+	depends on OPTEE
>+	default y
>+	help
>+	 Enable the hello world ta command to test the OPTEE by passing
>+	 a "value" which should increment by OPTEE TA example=2E
>+
> config CMD_MTD
> 	bool "mtd"
> 	depends on MTD
>diff --git a/cmd/Makefile b/cmd/Makefile
>index d1f369deec0=2E=2E049147a1442 100644
>--- a/cmd/Makefile
>+++ b/cmd/Makefile
>@@ -118,6 +118,7 @@ obj-$(CONFIG_CMD_PAUSE) +=3D pause=2Eo
> obj-$(CONFIG_CMD_SLEEP) +=3D sleep=2Eo
> obj-$(CONFIG_CMD_MMC) +=3D mmc=2Eo
> obj-$(CONFIG_CMD_OPTEE_RPMB) +=3D optee_rpmb=2Eo
>+obj-$(CONFIG_CMD_OPTEE_HELLO_WORLD) +=3D optee_hello_world_ta=2Eo
> obj-$(CONFIG_CMD_MP) +=3D mp=2Eo
> obj-$(CONFIG_CMD_MTD) +=3D mtd=2Eo
> obj-$(CONFIG_CMD_MTDPARTS) +=3D mtdparts=2Eo
>diff --git a/cmd/optee_hello_world_ta=2Ec b/cmd/optee_hello_world_ta=2Ec
>new file mode 100644
>index 00000000000=2E=2E54342b90812
>--- /dev/null
>+++ b/cmd/optee_hello_world_ta=2Ec
>@@ -0,0 +1,98 @@
>+// SPDX-License-Identifier: GPL-2=2E0
>+/*
>+ * (C) Copyright 2024, Advanced Micro Devices, Inc=2E
>+ */
>+#include <command=2Eh>
>+#include <errno=2Eh>
>+#include <tee=2Eh>
>+#include <vsprintf=2Eh>
>+
>+static struct udevice *tee;
>+static u32 session;
>+
>+#define TA_HELLO_WORLD_CMD_INC_VALUE 0
>+/* This needs to match the UUID of the Hello World TA=2E */
>+#define TA_HELLO_WORLD_UUID \
>+	{ 0x8aaaf200, 0x2450, 0x11e4, \
>+	{ 0xab, 0xe2, 0x00, 0x02, 0xa5, 0xd5, 0xc5, 0x1b} }
>+
>+static int hello_world_ta_open_session(void)
>+{
>+	const struct tee_optee_ta_uuid uuid =3D TA_HELLO_WORLD_UUID;
>+	struct tee_open_session_arg arg;
>+	int rc;
>+
>+	tee =3D tee_find_device(tee, NULL, NULL, NULL);
>+	if (!tee)
>+		return -ENODEV;
>+
>+	memset(&arg, 0, sizeof(arg));
>+	tee_optee_ta_uuid_to_octets(arg=2Euuid, &uuid);
>+	rc =3D tee_open_session(tee, &arg, 0, NULL);
>+	if (!rc)
>+		session =3D arg=2Esession;
>+
>+	return 0;
>+}
>+
>+static int hello_world_ta(unsigned int value)
>+{
>+	struct tee_param param[2];
>+	struct tee_invoke_arg arg;
>+	int status =3D -EACCES;
>+
>+	printf("The Hello World TA is going to be called\n");
>+
>+	status =3D hello_world_ta_open_session();
>+	if (status) {
>+		printf("HellWorldTA: OpenSession FAILED!\n");
>+		return status;
>+	}
>+
>+	arg=2Efunc =3D TA_HELLO_WORLD_CMD_INC_VALUE;
>+	arg=2Esession =3D session;
>+
>+	param[0]=2Eattr =3D TEE_PARAM_ATTR_TYPE_VALUE_INOUT;
>+	param[0]=2Eu=2Evalue=2Ea =3D value;
>+
>+	printf("TA value: %d\n", (int)param[0]=2Eu=2Evalue=2Ea);
>+
>+	tee_invoke_func(tee, &arg, 1, param);
>+
>+	printf("TA value: %d\n", (int)param[0]=2Eu=2Evalue=2Ea);
>+
>+	tee_invoke_func(tee, &arg, 1, param);
>+
>+	printf("TA value: %d\n", (int)param[0]=2Eu=2Evalue=2Ea);
>+
>+	status =3D tee_close_session(tee, session);
>+
>+	return status;
>+}
>+
>+static int do_optee_hello_world_ta(struct cmd_tbl *cmdtp, int flag, int =
argc,
>+				   char * const argv[])
>+{
>+	int ret;
>+	int value;
>+
>+	if (argc !=3D cmdtp->maxargs) {
>+		debug("hello_world_ta: incorrect parameters passed\n");
>+		return CMD_RET_USAGE;
>+	}
>+
>+	value =3D dectoul(argv[1], NULL);
>+	ret =3D hello_world_ta(value);
>+	if (ret)
>+		return CMD_RET_FAILURE;
>+
>+	return CMD_RET_SUCCESS;
>+}
>+
>+U_BOOT_LONGHELP(optee_hello_world_ta,
>+		"write_value value - Write value to increment\n"
>+		"Command for testing Hello World OPTEE TA\n"
>+		"pass the 'value' which needs to increment from OPTEE world\n");
>+
>+U_BOOT_CMD_WITH_SUBCMDS(hello_world_ta, "OPTEE hello world TA", optee_he=
llo_world_ta_help_text,
>+			U_BOOT_SUBCMD_MKENT(write_value, 2, 1, do_optee_hello_world_ta));

I am sure we we will come up with more ideas on how to query OP-TEE in fut=
ure=2E

Hence I would suggest to have one 'optee' command and making 'hello' a sub=
 command=2E

Best regards

Heinrich


