Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6592A10F9300
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 21:10:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7FF584020;
	Tue, 31 Mar 2026 23:10:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="vz1IroeF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48BD883F5B; Tue, 31 Mar 2026 21:19:07 +0200 (CEST)
Received: from LO2P265CU024.outbound.protection.outlook.com
 (mail-uksouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c205::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37C9883AA9
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 21:19:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=gary@garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3+sY0U4MTttV0Lgb/oaXVSyc3A6bI15z+7DOpFZmwK2ExDgNOU8gv6xKQC5N9h/UmgfbKrSZ+/FmuqOtZTwfTvpeoDtySLN0bMZademPBcyjp5rWK7JbLh7vsStIOLIUSzDBeMDGGKtZ3BtPhOTOKu/XdcZNDFfKbSc5kZuJ1NoYPqiQlJI8R9TaFpOwbj2tnnShiccVENFwy0aH2dmGSSEVwZJAjMilhe81ragNQagLKCZlLfYYfOQd/zKPDMVo2UAMLc94kPSguIrdr89yzZ8gaBMd7xo+rV1icVlVGb3/S2msg+jYNrpWyQ2plKeTBnh71K/htx+8083fl2kCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49SYE5aS3m+IKqFZ2yxqfx0bBw+TigmNtmQXm7GokKw=;
 b=R9Abm5iVI0siX+FJEbcI6Rq9rwb0dTWxpdbYgZPVwpkYPesNXuc60KNKYJ1DGoV707WJKC+h00KzLDmO6gQ3rcKG2/u4s4F4fNEgRwAolpK1s0avIDcixiRgf62jZQPHOAnQDwdYxrHXowVra9EMT9bdHl7cFA2xbwxS2eK67pWHFWag4jHlubkOJ6e3Ih/8ind23aATC9IkKJAP+4OWhTdGsmuQfFjz3Ay+Xyvt+5cFxrUruz1MBl3PiZR9fng5nF21Deb2eXZKI5KKraCbu07v5Kt3dLE6IyeN9UFO0YH5R0p59E64j7PdKdhS2bRbrLr4l10hZd1xJlLK04MfHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49SYE5aS3m+IKqFZ2yxqfx0bBw+TigmNtmQXm7GokKw=;
 b=vz1IroeFUPzLF1Hn4XvhQNrYpuOQ+AKFX4ZPwSMlt9l2xbR3lweeI22uC8Tcxxp91n8dgyIJj0fYSBz2dTF9EZvuAaYWfMf6LbmIZkuNzUYfs2lmg4//ns1wjWJT8bIJawjuDwEo3B2xV03+00EuRUDkNETM7pQjJVr98X0QZcE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB3609.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:1b5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 19:19:02 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 19:19:02 +0000
From: Gary Guo <gary@garyguo.net>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 David Zang <davidzangcs@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Gary Guo <gary@garyguo.net>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Simon Glass <sjg@chromium.org>,
 Javier Tia <javier.tia@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH] efi_loader: support EFI_OS_INDICATIONS_BOOT_TO_FW_UI
Date: Tue, 31 Mar 2026 20:18:51 +0100
Message-ID: <20260331191853.44549-1-gary@garyguo.net>
X-Mailer: git-send-email 2.51.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DUZPR01CA0083.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::19) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB3609:EE_
X-MS-Office365-Filtering-Correlation-Id: c5fd4b94-108d-4416-1fa6-08de8f5a5e50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|18002099003|56012099003|921020; 
X-Microsoft-Antispam-Message-Info: YRjvAug7GflenV/2bvlt9455jeOk+fsGgbGB/33Xj9zele6+OvSi/spM/NgiybufmX2gCtDJYfpNGCopv3+/sZAhR7aN6gFq13c6nb1I3C6KQkLciZca6e7gOSd47/VhxOWQVGCYLBXE1aUsxtyVJ2GyDYbLQRd4xXLJ8trTr/0cBwAErw879Q2HPw4kmjV9MczTIxsAOvLx28ZfzTYS1k+oolrBsTxGqnx2Stkz9vAQDMWDfes49ubrm9MC3lx50pOPq4qFlH9fG2O5uSxPnWprBQDF9wcI87h1z0qSkVbyTnBvw4dB2BukxYcqtR7/xa/uy1ukUs6uZFddFG2As1SQTaQSsRF9DC3QQzvZG1bq3cpw5K+w4/LvJSpultH1pxC//bkYnTGUBxZQvD3aMGlIkNBe2cXP5V5FXhBjJZN2ZKlUqxO0pUpE7hdv3hLQ7OzLdnFtwxOIxUZxnDik9yIz72BYreqj/5aUE4dcVN11kuqJSov2HjATSABgaMg/ev+ewJHhe0DvAvKP5iY45GOQMrg+Q5zH/bFNGTRzAf61vDFFn/Uh8M7w3Gfp4hsLXLXhcPsH+VFO907VBaa7YfitcuobopNjg9IN85GaxXG/+XXCFJdd0EGs8aKkdCPQdR+XqYXEP7CuyJJlBtWsN+fcfpPpJQVQcwfq1zxCX3rqKGCpnyZ2AEuXTsRiUXq0Gqpxu0LYd0Xa0oB2XJGOWLH3K9PZfNSskzirlYyqlQCxstZc9NuGFj19p7Wh83LbXpBhVsZ8OmB/AKWnBvsZBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(56012099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yQA2Vw5hkbGbkbUFKt7Yme/xpTfPEBFUPBnAZmlSMM/P6jFPmn0UybWv4hrh?=
 =?us-ascii?Q?/bJrQyNLueTzXmVkkSVEOpB765sJcgVvC8NQROsw3Y2T8nxh2GX+YunhTgXI?=
 =?us-ascii?Q?3HW6UjOj4Pu7HT5CxEJA2L9msRjihWOy+s7UiGqguCsKc50uCnWIYY1gG5bM?=
 =?us-ascii?Q?bhJ4aOuZinxVmnEcpjXj0tQ+tiEIe3bfFBNJmSTAg7yI0Z9c794rrtZaIOxB?=
 =?us-ascii?Q?ypCaziuKNzkcgEfB2LVKnHReF/H2C0Z65WvtY0GkUMrVuuC3634tH3DDM865?=
 =?us-ascii?Q?BIsKOLPDp/z2GQNkzLI+TqL5xLutIXAY5X4sIz9mrfnoccJ03W1hHB44pbo5?=
 =?us-ascii?Q?YbyDy9/AZu8LHb5iKlx5god/xgOsCS0HCZYC6d4NPQ2PD93sUGYgEhmnnpAp?=
 =?us-ascii?Q?gdi5nFXjyghVNcYQXgh6KNNMWOaDN/0Cbgoepv4mTGdg6PbXOSXrNR4LS+qt?=
 =?us-ascii?Q?Grgg0Oxm8oLkEE9AadmxzzjCKzItwGcwSs6rHLHyo5x4VO2fOS8jdQmROJfG?=
 =?us-ascii?Q?EwoCkwBu38yl53VqqdkSqSt+XGBTxopiLz5ZrKS1+lMAQYIiyzxxGPOGzXFf?=
 =?us-ascii?Q?cDDhsnE7UbiuJvHs/dYMv+Mb8VBO7CQOUQRtWy+TbYOtEGnZwmVDxPKpewbB?=
 =?us-ascii?Q?OPJr/tuZcvYW+AZaSQP62uoz0fO0W636t4YB0+4oElRSLHz3p/iCKohzT7Wu?=
 =?us-ascii?Q?RB/FAuRi68Q3fJAgQZFX4KXNocsbHk1HSIT0fWktXgRHJe2mrfHIda78Sxlj?=
 =?us-ascii?Q?vmVh3lFR0c9NbirKKRPt0u2NFITf2ToeEmsWs6wnodarZJVP3ng+utM4HIM8?=
 =?us-ascii?Q?BlZherZFVo4nvd7nww5heifqGL+29tqFwbI337WExtIiAWmIhhpOriWA3Hp9?=
 =?us-ascii?Q?/AdcsJLmyE0dPUD61IbKi+Gz8XAAMzil5R6AdLBWnlHevGUe+8qXdwfAlK0N?=
 =?us-ascii?Q?aFOTpIxypF/QeIyM+VtYdLQSjunvR8j35oXlUbuEBBoorvbS8ZZW8+7IcOOd?=
 =?us-ascii?Q?BBrHtrP5zgaVE7uKFMUNngtem4RYN/mLKgCu3M1kvSXlfhLI8us1HVW+G/oh?=
 =?us-ascii?Q?E9AdSu+dmzfHnfBkUN7ukUFoUAudMbKii+i5RH2OhzN8hy2e2vGqxEDry0E6?=
 =?us-ascii?Q?RaIjdx+m4OC6Y4nZbfCUNCkxKVRwyP0ETQJR+7Au3OjJfjIllXXG9/xDW6a1?=
 =?us-ascii?Q?hHLlwWwQZCzUtyQNgBYqbfzeX3mTMxjUyrthMf45SEl1Cs08OIIW9Ax5vJjl?=
 =?us-ascii?Q?4cqNFJ1hiziF2qKLdA+c9KR4QV8j7tDdx46ddqeZt1/SfCa0JJQCADOQ+aks?=
 =?us-ascii?Q?Yxsgahr64kZ3u9u8KVqrNxr3fUXpdI+ZFDn9+yi5i5YYN/wQNSOiq1K5+IQg?=
 =?us-ascii?Q?shPNeKvCblXi4yCHVMGQCNz/ERRcM0YLrnMoeDFHY6Z2C7nDjERlNyieBwdg?=
 =?us-ascii?Q?peMj2iZByY2jpNfy2hs6XRSVidJUWb2m7qpNPthA4HDjxk5k2XRD7HERVDE/?=
 =?us-ascii?Q?OofkrvgcyNnEc6Q94wskKcDELz9d1i52zsNbOwMtkxGiup9cjKylbimnbtqa?=
 =?us-ascii?Q?e4rvnYtX/gJyaszIly0BUUXsNAYQC2CRvn1VtHeq4W7S+/E1tul5XTjkrSa+?=
 =?us-ascii?Q?L73GXL15NXxtoqRu878lmEK8AtAyKxku7vCA8eCPPuP4MxEORWqRG9coS/t1?=
 =?us-ascii?Q?U5X0aEfJ9pbHze/KAaKeJ/5IaU/4N3MGIGDP8L21cUmCrSFu?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c5fd4b94-108d-4416-1fa6-08de8f5a5e50
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 19:19:02.6535 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s9gGadWOiqh+iLMmiKmurmPDb2sTtZSptujQxtPhBDXF+F1x/gZjTmeRy5brqiqOVTLf6XEpQqcXwvEe2VOEHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3609
X-Mailman-Approved-At: Tue, 31 Mar 2026 23:10:31 +0200
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

EFI variable OsIndications have a bit EFI_OS_INDICATIONS_BOOT_TO_FW_UI
indicating that the OS (or next stage bootloader) requests booting into
firmware UI instead of continuing autoboot process.

Support it by having autoboot.c asking EFI bootmgr if boot should continue,
which checks and clear the bit (so the next boot continue as normal).

With this change, systemd-boot will show a "Reboot Into Firmware Interface"
option which will be able to drop back to u-boot. This can be useful if
bootdelay is configured to be -2.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 common/autoboot.c            |  4 +++-
 include/efi_loader.h         |  2 ++
 lib/efi_loader/efi_bootmgr.c | 45 ++++++++++++++++++++++++++++++++++++
 lib/efi_loader/efi_setup.c   |  4 ++++
 4 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/common/autoboot.c b/common/autoboot.c
index 1783ef92c94c..b889407612dc 100644
--- a/common/autoboot.c
+++ b/common/autoboot.c
@@ -11,6 +11,7 @@
 #include <cli.h>
 #include <command.h>
 #include <console.h>
+#include <efi_loader.h>
 #include <env.h>
 #include <errno.h>
 #include <fdtdec.h>
@@ -503,7 +504,8 @@ void autoboot_command(const char *s)
 {
 	debug("### main_loop: bootcmd=\"%s\"\n", s ? s : "<UNDEFINED>");
 
-	if (s && (stored_bootdelay == -2 ||
+	if (s && !(IS_ENABLED(CONFIG_EFI_BOOTMGR) && efi_should_abort_autoboot()) &&
+	    (stored_bootdelay == -2 ||
 		 (stored_bootdelay != -1 && !abortboot(stored_bootdelay)))) {
 		bool lock;
 		int prev;
diff --git a/include/efi_loader.h b/include/efi_loader.h
index 3e70ac070550..449697ad13b3 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -583,6 +583,8 @@ efi_status_t efi_bootmgr_get_unused_bootoption(u16 *buf,
 efi_status_t efi_bootmgr_update_media_device_boot_option(void);
 /* Delete selected boot option */
 efi_status_t efi_bootmgr_delete_boot_option(u16 boot_index);
+/* Check if autoboot should be aborted based on EFI vars */
+bool efi_should_abort_autoboot(void);
 /* Invoke EFI boot manager */
 efi_status_t efi_bootmgr_run(void *fdt);
 /* search the boot option index in BootOrder */
diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index a687f4d8e85c..39f255ac9de4 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -1290,6 +1290,51 @@ out:
 	return ret;
 }
 
+/**
+ * efi_should_abort_autoboot() - check if autoboot should be aborted per EFI vars
+ *
+ * Return:	true if autoboot should abort
+ */
+bool efi_should_abort_autoboot(void)
+{
+	efi_status_t ret;
+	u64 os_indications = 0x0;
+	efi_uintn_t size;
+	efi_status_t r;
+
+	/* Initialize EFI drivers */
+	ret = efi_init_obj_list();
+	if (ret != EFI_SUCCESS) {
+		log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
+			ret & ~EFI_ERROR_MASK);
+		return false;
+	}
+
+	size = sizeof(os_indications);
+	r = efi_get_variable_int(u"OsIndications", &efi_global_variable_guid,
+				 NULL, &size, &os_indications, NULL);
+	if (r != EFI_SUCCESS || size != sizeof(os_indications))
+		return false;
+
+	if (!(os_indications & EFI_OS_INDICATIONS_BOOT_TO_FW_UI))
+		return false;
+
+	/* Clear the BOOT_TO_FW_UI so next boot returns to normal */
+	os_indications &= ~EFI_OS_INDICATIONS_BOOT_TO_FW_UI;
+	r = efi_set_variable_int(u"OsIndications",
+				 &efi_global_variable_guid,
+				 EFI_VARIABLE_NON_VOLATILE |
+				 EFI_VARIABLE_BOOTSERVICE_ACCESS |
+				 EFI_VARIABLE_RUNTIME_ACCESS,
+				 sizeof(os_indications),
+				 &os_indications, false);
+
+	if (r != EFI_SUCCESS)
+		log_err("Setting %ls failed\n", L"OsIndications");
+
+	return true;
+}
+
 /**
  * efi_bootmgr_run() - execute EFI boot manager
  * @fdt:	Flat device tree
diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
index f06cf49e4435..0ad02e9fe0dd 100644
--- a/lib/efi_loader/efi_setup.c
+++ b/lib/efi_loader/efi_setup.c
@@ -156,6 +156,10 @@ static efi_status_t efi_init_os_indications(void)
 {
 	u64 os_indications_supported = 0;
 
+	if (IS_ENABLED(CONFIG_EFI_BOOTMGR))
+		os_indications_supported |=
+			EFI_OS_INDICATIONS_BOOT_TO_FW_UI;
+
 	if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
 		os_indications_supported |=
 			EFI_OS_INDICATIONS_CAPSULE_RESULT_VAR_SUPPORTED;
-- 
2.51.2

