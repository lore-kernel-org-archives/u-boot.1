Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C865FC369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 10:01:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AD5F82D05;
	Wed, 16 Apr 2025 12:01:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="GvUzvlcS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED54082D05; Wed, 16 Apr 2025 12:01:43 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAB0D82C96
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 12:01:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1744797677; x=1745402477; i=xypron.glpk@gmx.de;
 bh=vRQUoAGANqS54ABKysEK3jvOXcVKnI3+WH9rwmHGx0g=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=GvUzvlcSjYE01n8iKPCc+YmSZu1SoMEMOvhUoUdM0rIQ9xENxkhEHK1/VK6/o1YC
 9rA58yVt/qaElvfbWHQ3lPMpULfJIpu9geHdg95X53/6iMpXHJXlg/gIIeEGokZtw
 2IFj14TCnHTY3utj6DOXkvqeFNlwnwp/boCjnOzwSZKtC+yoa8Wy9at/2IRuckuCV
 zNR8TAY5jr54UvyWbe/ye3wjWJsKB36BpP6pfJe9WNIUG3h1SunsKLX3Eq1KMuelr
 knwgTDPywrH5g0rFM2utSyUNjVxEhnn9Qr4VTJ2soA3rka7x+Sp559obkl8W7f1qh
 AMrhV1xRJUBjyGvixA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmULx-1tMozU1BlR-00m8WU; Wed, 16
 Apr 2025 12:01:17 +0200
Date: Wed, 16 Apr 2025 12:01:14 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Jerome Forissier <jerome.forissier@linaro.org>,
 U-Boot mailing list <u-boot@lists.denx.de>
CC: Adriano Cordova <adrianox@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 =?ISO-8859-1?Q?Vincent_Stehl=E9?= <vincent.stehle@arm.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_1/2=5D_lib/uuid=2Ec=3A_use_u?=
 =?US-ASCII?Q?nique_name_for_PARTITION=5FSYSTEM=5FGUID?=
User-Agent: Thunderbird for Android
In-Reply-To: <20250416074839.1267396-2-jerome.forissier@linaro.org>
References: <20250416074839.1267396-1-jerome.forissier@linaro.org>
 <20250416074839.1267396-2-jerome.forissier@linaro.org>
Message-ID: <3EE4BEBE-2D89-4068-AD44-450DC7DFF03E@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9xxAYxa0C+qxl41lO2QXnzHeqTIk9+6QQg+3wpqEfwGeJbp3j/K
 c7q7gGJ7XjJ6K6kifaKAIvmqJEtSAyjGDmlO/d/tIwNOq835/LB2wV3E/zXxlvgiOfCbDlv
 pQQhlbGTe7lIe71p88NR6kVHf+ZXkAWLEzWPchI9YBnlPeoq56iBa44hUdPNon8IKM4FNme
 EBkqSZwmcAHMbxLR6pfNw==
UI-OutboundReport: notjunk:1;M01:P0:p2kIgcpb8q4=;ZKGiridPIz2EUjdImr+LhnrlwbZ
 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
 MNFF+Q4igHLKrt0jVJUv3Q=
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

Am 16=2E April 2025 09:48:20 MESZ schrieb Jerome Forissier <jerome=2Eforiss=
ier@linaro=2Eorg>:
>The name defined for PARTITION_SYSTEM_GUID in list_guid[] depends on
>configuration options=2E It is "system" if CONFIG_PARTITION_TYPE_GUID is
>enabled or "System Partition" if CONFIG_CMD_EFIDEBUG or CONFIG_EFI are
>enabled=2E In addition, the unit test in test/common/print=2Ec is incorre=
ct
>because it expects only "system" (or a hex GUID)=2E
>
>Make things more consistent by using a clear and unique name: "EFI
>System Partition" whatever the configuration, and update the unit test
>accordingly=2E
>
>Signed-off-by: Jerome Forissier <jerome=2Eforissier@linaro=2Eorg>
>Suggested-by: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>

LGTM

Reviewed-by: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>


>---
>
>Changes in v3:
>- Use a single entry in list_guid for PARTITION_SYSTEM_GUID
>
>Changes in v2:
>- Remove useless braces in if expression
>- Change partition name and make it the same for all configs=2E Update th=
e
>  commit subject=2E
>
> lib/uuid=2Ec          | 9 ++++-----
> test/common/print=2Ec | 8 ++++----
> 2 files changed, 8 insertions(+), 9 deletions(-)
>
>diff --git a/lib/uuid=2Ec b/lib/uuid=2Ec
>index 75658778044=2E=2E6abbcf27b1f 100644
>--- a/lib/uuid=2Ec
>+++ b/lib/uuid=2Ec
>@@ -67,8 +67,11 @@ static const struct {
> 	efi_guid_t guid;
> } list_guid[] =3D {
> #ifndef USE_HOSTCC
>+#if defined(CONFIG_PARTITION_TYPE_GUID) || defined(CONFIG_CMD_EFIDEBUG) =
|| \
>+	defined(CONFIG_EFI)
>+	{"EFI System Partition", PARTITION_SYSTEM_GUID},
>+#endif
> #ifdef CONFIG_PARTITION_TYPE_GUID
>-	{"system",	PARTITION_SYSTEM_GUID},
> 	{"mbr",		LEGACY_MBR_PARTITION_GUID},
> 	{"msft",	PARTITION_MSFT_RESERVED_GUID},
> 	{"data",	PARTITION_BASIC_DATA_GUID},
>@@ -182,10 +185,6 @@ static const struct {
> 	{
> 		"TCG2",
> 		EFI_TCG2_PROTOCOL_GUID,
>-		},
>-	{
>-		"System Partition",
>-		PARTITION_SYSTEM_GUID
> 	},
> 	{
> 		"Firmware Management",
>diff --git a/test/common/print=2Ec b/test/common/print=2Ec
>index e3711b10809=2E=2Ec48efc2783f 100644
>--- a/test/common/print=2Ec
>+++ b/test/common/print=2Ec
>@@ -45,11 +45,11 @@ static int print_guid(struct unit_test_state *uts)
> 	sprintf(str, "%pUL", guid);
> 	ut_asserteq_str("04030201-0605-0807-090A-0B0C0D0E0F10", str);
> 	sprintf(str, "%pUs", guid_esp);
>-	if (IS_ENABLED(CONFIG_PARTITION_TYPE_GUID)) { /* brace needed */
>-		ut_asserteq_str("system", str);
>-	} else {
>+	if (IS_ENABLED(CONFIG_PARTITION_TYPE_GUID) ||
>+	    IS_ENABLED(CONFIG_CMD_EFIDEBUG) || IS_ENABLED(CONFIG_EFI))
>+		ut_asserteq_str("EFI System Partition", str);
>+	else
> 		ut_asserteq_str("c12a7328-f81f-11d2-ba4b-00a0c93ec93b", str);
>-	}
> 	ret =3D snprintf(str, 4, "%pUL", guid);
> 	ut_asserteq(0, str[3]);
> 	ut_asserteq(36, ret);

