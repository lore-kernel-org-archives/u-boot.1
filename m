Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED986606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 07:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qxI+JJ1T;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=M4LVh0PL
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6B245606B1;
	Sat,  7 Nov 2026 07:03:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oWB2TGsKUn9t; Sat,  7 Nov 2026 07:03:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4703A60616
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794034986;
	b=tPRmfdX/BE7EmAY90G1RyPL/C4b37lcSzsoN4MPn2HaJoovArkmIM0TzVZSs7TFg9tWi
	 s6jfn+HCBfrSAlhaRN9pooctc+5kuntdbeLP2pRpFe/T3LtsMirMxjModqjtMCezzr2zC
	 jiOkk29RG7n5A6ykkXj5R/35dlzAW3I4WFQ0CCybvaC9i118fQc1sA0UQPGfuPbzAc1Fb
	 xTSitLYb707bSDFcvl1bVYQ0EubBYDJNlWjWItyneerFvsoUYbQBcTA+OltN3QQ0AWPXh
	 zaqMbppXi7L+HEBA40D+znTq2RwewXoznyzaX+1Ixo+QzOW3Ro1aeEGktO9WnkVNv3g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794034986;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Date:From:To:CC:Subject:
	 User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:UI-OutboundReport:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3HY0DS4YIhA8glQRgSwbcwqVmzGF4/tY8sOJoCU6Z+Q=;
	b=gv8A1Sj1Kxaf+qNW+wBhVXGBieuUtSnebTIAQoG5nYEmB8Si4ENMc07jrpz117RUfT57
	 +/ji1d8F8Mm0KSjT526glzoLK6UV4CZE0opX9VkoaaWIA8o7shSw0bZyWc39nsfXrjpLy
	 FLxoiXXOGgYAc0eIhUPx2IlC8Q+qt2HYDM7IuSrKywsCUJIq4lVrMusBdcLHFQEpioOXY
	 cxUnAkZwkjp5Zmlm5qApYrPDmzJf6Kq37w8zV70d/PxO3VUP8jqP888IPEI7AunKM632g
	 baFp1jqsgcPtKnHzcZE/gZIG1jYyF2UgtFvZ5efUpC2I5iPhfsDkpA9FkaqeeEsPzYQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794034986;
	bh=3HY0DS4YIhA8glQRgSwbcwqVmzGF4/tY8sOJoCU6Z+Q=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qxI+JJ1TyzteahZ+8Th3FdIghAfyzE9O9KYlU4Tk8J7l6P1Sr8taKKYPGwRIUG9J7
	 FzciocSflw63shyrFxLa+Rvf6tbIibwJkSjKuOxNBCYUNq1H+qFVQMYjd28GqgwyyO
	 bwbA7Wnpy6Jp+t8wPnIDI9vheA5Cg8vNPdw0JMDKu/0Bf+UemC8f7+skRGQFk5Jr7F
	 qp2o3R8YEGaTTenqg89+WfmDvPk7IxuXDpryFWenIhF9Myq72oCla7uVZLt5cmqSGx
	 1QKuL8Q8yBQp5Q8ied0Y87R0kUkCGv1kSfaVq+kC114DO9rPA1oNA6PGbec9DaQcRe
	 /Z3XM5D4g4asQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4703A60616;
	Sat,  7 Nov 2026 07:03:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E3B72AC
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:03:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7B33F81287
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:03:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wBv1aqVZy_af for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 07:03:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7EC8481281
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=212.227.15.19
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.19;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de
 header.a=rsa-sha256 header.s=s31663417 header.b=M4LVh0PL
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7EC8481281
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 07:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1794034972; x=1794639772; i=xypron.glpk@gmx.de;
 bh=3HY0DS4YIhA8glQRgSwbcwqVmzGF4/tY8sOJoCU6Z+Q=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=M4LVh0PLoGvCyRaffxGrCMWZNYUooWXU8nrWEV/jilb/4oJHb9ZGA7mcRro2cSTK
 RHdnWo6roBnAHn+7vg72t30x0uCaGo8l8Nm+Sts4KQxkWDD5xlT177+jyGfJ28O0B
 sws03GJ1gR4ekp44xNAciBaDEPhWFU7hegF15OJpwEXyBn24gJRge6MFIcYRhWDRI
 1pShHDWQM14iq/S51i28mveof+Z1hJVAMnAKOLEodro8JWFmRTaLKmcQQsmtg1gD6
 PAPd0usWPQ0Wy95buCZpba/h2sxKJ4+oBumTaIo8bPLFrou3yy3mf7MxNXHnBnbgE
 oJUR0qvjemMDIlX49w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbzuH-1wmfKN1seF-00dTCt; Sat, 07
 Nov 2026 08:02:52 +0100
Date: Sat, 07 Nov 2026 08:02:50 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Tomas Paukrt <tomaspaukrt@email.cz>, u-boot@lists.u-boot-project.org
CC: Stefan Bosch <stefan_b@posteo.net>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH] Kconfig: Imply MD5 and SHA1 instead of selecting them
User-Agent: Thunderbird for Android
In-Reply-To: <x6.ZqL8.6lacd1LQ7Dn.1gxhk0@seznam.cz>
References: <x6.ZqL8.6lacd1LQ7Dn.1gxhk0@seznam.cz>
Message-ID: <C3623664-3DBA-4A82-8814-D20F387D3319@gmx.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MSMUDHaJoY3QMsVelCokWw8HHphN2BtiHA93Tqn2iAcAPHyuXYB
 f8wOSZriMGKdUsFLvmxcIu8Luf6dlQ8FYoj7qh0WkIgNQwMlbjtWVV3XZTdYGmhZ2DIYdbR
 lSCqqBOv/sdy4GpKXFaJSWz8p8rw2oNKKTqxYrJXCxq4vpsZcz7BHGugwBkYS6NHxRXyzsc
 0AFnCUY83C/C8swj1Nisg==
UI-OutboundReport: notjunk:1;M01:P0:Rl1Bm3tqIHE=;GQS6R7O43qQPL4k1KeVmRzNqu8s
 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
 GBiAOgA6MPuI6CLXoBQ==
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 7=2E November 2026 06:47:44 MEZ schrieb Tomas Paukrt <tomaspaukrt@email=
=2Ecz>:
>MD5 and SHA1 are no longer considered secure, but they cannot be
>disabled on boards using FIT, image signature helpers or UUIDs,
>because FIT, IMAGE_SIGN_INFO, SPL_IMAGE_SIGN_INFO, VPL_IMAGE_SIGN_INFO
>and LIB_UUID select them=2E The code behind these options does not
>require them, as the supported algorithms are looked up at runtime
>and unsupported ones are rejected=2E
>
>Imply MD5 and SHA1 instead, so they stay enabled by default but can
>be disabled by the user=2E This does not change the resulting
>configuration of any defconfig=2E
>
>Select MD5 or SHA1 explicitly only for the code which calls them
>directly and relied on the options above until now:
>- bubt on Armada 3700 (sha1_*() for the TIM image header)
>- zynq rsa command (md5_wd() for the boot image partitions)
>- NanoPi2 board (md5_wd() for the MAC address generation)
>- EFI capsule firmware (gen_v5_guid() for the dynamic image GUIDs)

Thank you for raising the issue=2E

NIST diallowed the usage of SHA1 for digital signatures in 2013=2E

We need a plan to move away from insecure algorithms for security relevant=
 code=2E

E=2Eg=2E support for insecure algorithms for FIT should have a separate Kc=
onfig symbol and the build should show a warning text=2E (We once had such =
warnings during the migration to DM=2E)

CONFIG_FIT should neither select nor imply support of insecure algorithms =
for FIT verification=2E Instead make this a decision on defconfig level=2E

The same for support in signing EFI images or capsules=2E

We should consider NIST IR 8547=20
(https://csrc=2Enist=2Egov/pubs/ir/8547/final) which has deprecation dates=
 for further algorithms=2E

Best regards

Heinrich

>
>Signed-off-by: Tomas Paukrt <tomaspaukrt@email=2Ecz>
>---
> arch/arm/mach-nexell/Kconfig | 1 +
> board/xilinx/zynq/Kconfig    | 1 +
> boot/Kconfig                 | 4 ++--
> cmd/mvebu/Kconfig            | 1 +
> common/Kconfig               | 6 +++---
> lib/Kconfig                  | 2 +-
> lib/efi_loader/Kconfig       | 1 +
> 7 files changed, 10 insertions(+), 6 deletions(-)
>
>diff --git a/arch/arm/mach-nexell/Kconfig b/arch/arm/mach-nexell/Kconfig
>index b43dd5a5c25=2E=2E67f7f10362d 100644
>--- a/arch/arm/mach-nexell/Kconfig
>+++ b/arch/arm/mach-nexell/Kconfig
>@@ -27,6 +27,7 @@ choice
> config TARGET_NANOPI2
> 	bool "FriendlyARM NanoPi2 / NanoPC-T2 Board"
> 	select ARCH_S5P4418
>+	select MD5
> 	help
> 	  Enable support for FriendlyARM NanoPi2 and NanoPC-T2 Boards=2E
>
>diff --git a/board/xilinx/zynq/Kconfig b/board/xilinx/zynq/Kconfig
>index d6f40631cca=2E=2E1a2411f50bc 100644
>--- a/board/xilinx/zynq/Kconfig
>+++ b/board/xilinx/zynq/Kconfig
>@@ -23,6 +23,7 @@ config CMD_ZYNQ_RSA
> 	default y
> 	depends on CMD_ZYNQ
> 	depends on CMD_ZYNQ_AES
>+	select MD5
> 	help
> 	  Enabling this will support zynq secure image verification=2E
> 	  The secure image is a xilinx specific BOOT=2EBIN with
>diff --git a/boot/Kconfig b/boot/Kconfig
>index 8fcdc36c931=2E=2E59dac3cdea4 100644
>--- a/boot/Kconfig
>+++ b/boot/Kconfig
>@@ -69,8 +69,8 @@ config BUTTON_CMD
> menuconfig FIT
> 	bool "Flattened Image Tree (FIT)"
> 	select HASH
>-	select MD5
>-	select SHA1
>+	imply MD5
>+	imply SHA1
> 	imply SHA256
> 	help
> 	  This option allows you to boot the new uImage structure,
>diff --git a/cmd/mvebu/Kconfig b/cmd/mvebu/Kconfig
>index e83a9829491=2E=2E8381a374d6d 100644
>--- a/cmd/mvebu/Kconfig
>+++ b/cmd/mvebu/Kconfig
>@@ -4,6 +4,7 @@ depends on ARCH_MVEBU
> config CMD_MVEBU_BUBT
> 	bool "bubt"
> 	default y
>+	select SHA1 if ARMADA_3700
> 	select SHA256 if ARMADA_3700
> 	select SHA512 if ARMADA_3700
> 	select DOS_PARTITION if ARMADA_3700
>diff --git a/common/Kconfig b/common/Kconfig
>index 92bf31f038b=2E=2Eae0b699a906 100644
>--- a/common/Kconfig
>+++ b/common/Kconfig
>@@ -1300,7 +1300,7 @@ source "common/spl/Kconfig"
>
> config IMAGE_SIGN_INFO
> 	bool
>-	select SHA1
>+	imply SHA1
> 	select SHA256
> 	help
> 	  Enable image_sign_info helper functions=2E
>@@ -1309,14 +1309,14 @@ if IMAGE_SIGN_INFO
>
> config SPL_IMAGE_SIGN_INFO
> 	bool
>-	select SHA1
>+	imply SHA1
> 	select SHA256
> 	help
> 	  Enable image_sign_info helper functions in SPL=2E
>
> config VPL_IMAGE_SIGN_INFO
> 	bool
>-	select SHA1
>+	imply SHA1
> 	select SHA256
> 	help
> 	  Enable image_sign_info helper functions in SPL=2E
>diff --git a/lib/Kconfig b/lib/Kconfig
>index 38e37bdc56a=2E=2E45b8e1fd54e 100644
>--- a/lib/Kconfig
>+++ b/lib/Kconfig
>@@ -94,7 +94,7 @@ config HAVE_PRIVATE_LIBGCC
>
> config LIB_UUID
> 	bool
>-	select SHA1
>+	imply SHA1
>
> config RANDOM_UUID
> 	bool "GPT Random UUID generation"
>diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
>index c4b0c2137b8=2E=2Ed9667fbd724 100644
>--- a/lib/efi_loader/Kconfig
>+++ b/lib/efi_loader/Kconfig
>@@ -336,6 +336,7 @@ config EFI_CAPSULE_NAMESPACE_GUID
>
> config EFI_CAPSULE_FIRMWARE
> 	bool
>+	select SHA1
>
> config EFI_CAPSULE_FIRMWARE_MANAGEMENT
> 	bool "Capsule: Firmware Management Protocol"
>--
>2=2E43=2E0

