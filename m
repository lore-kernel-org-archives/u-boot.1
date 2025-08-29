Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D40CA0FF0
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 14:31:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0B1E83775;
	Fri, 29 Aug 2025 16:29:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B45183487; Fri, 29 Aug 2025 08:10:17 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20728.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::728])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF3888354B
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 08:10:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4hgYToC3j1IiAKqpsNkwTYOFmvo9fDqRuR0Y3bLveSMuFBlwthdKRZ9Q7cCAg05S09Fi7uerguPLFofKBFcPO/gPW+OscEi6NaFtT1gzHXPrvl97KKucVH+bV5Pa4cYUhMi64hVGQiWN/wD7S44PAoueCyM8t8P9MUp7ZHVP6Sl2exRMhgfF4QCyenEjqMln6I7lbLNjp/zN1Yp4GiF5J1QcQuNs0ag6perdBBqVD/09CPICXJr71VPsiVvhf5nRbjNrAum+HAXaBdczUu7GmAGjqpIFZqBiqoo5yZwm0fQFylvie/E1aoM0X2FPiX4zg7po+q9iyVc9yrbQd36kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ma2nhW1CDN9OHFOTDYWo/X6TbGAmvh13CNw/nWHWeQI=;
 b=BH0dta7hkL6IN/A+gMgQbQToJf7HwsC/z5JEr8wAipsvMfnkHi8l4VHdxs7Pi3gGk8hS/aCkSVpyV3uoogkDT1fbn5JNDIUJ4eD/nYvOWzeGb5YaNGvY5UKDZuQH0T/WT9Ydzt79zFUgEWXrPwcNGaSCx9An5sjz9rFoGnVF7EtBJKSILIqMO1gwFpCL21BNaSSem2XFGxzbMBHJxSEXvQ1Esj1wL2fmJrkBaIMhweWcmXA2EmjTf6KGzSpQzUKa+wyU5liwbaGmvWz/3CqaUet8Ypx3C3P2XgFAEjBdUtNobMddaGdLONBhPlg7BWqkh1dIg7DV6kmWvb4V6IjCZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1258.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.25; Fri, 29 Aug
 2025 06:10:11 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9052.024; Fri, 29 Aug 2025
 06:10:11 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Rick Chen <rick@andestech.com>, Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 E Shattow <e@freeshell.de>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	u-boot@lists.denx.de
Subject: [RFC 05/10] eeprom: starfive: Update eeprom data format version to 3
Date: Fri, 29 Aug 2025 14:09:26 +0800
Message-ID: <20250829060931.79940-6-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20250829060931.79940-1-hal.feng@starfivetech.com>
References: <20250829060931.79940-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::27) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1258:EE_
X-MS-Office365-Filtering-Correlation-Id: df870da5-21bc-4b70-292f-08dde6c2b615
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|41320700013|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: OyV0M/fSqBdlgDFsz9WOnPDdBpt3xnJwaUNYtRpm2ckPYWtxIJ8unWh11LSL9Tapcyw8s/PzBwvT/9vf4S72CXWWfdczEkDyw37brWvRYgzbc6u0AJWReS9X386zqgybzDv9Ky3bP9ov34/vYo+QbjwqpWzARSiKSsPIUnj6elcK8tUhQf/dOzZvNRkCC4oPl8o7TEGCWUrJlgOJS/tOGF4Z2cstbiGmVLN/8fEZ02OBrbYknB4vteSQt9xPocioZxTAOKNQvnd3QCa7P4ILkhFFJ+ioD3RubeFHssJethm7UOQxt3Glex96UQpfpNGOTPytEijBngOscUpdQEb+3udVvvVGyaBGKANrNksIrZzmwjYADtmU6vMFPCxnIbMOdWUTklujqowv80o0Zj3k4l5af+Ni2O1MPCjsgGZE+NUJEnwrwewz6T1oXrUZLiW9j7T1JqYJhCLWpSxumI94GHyXJd7h/ZruNM8CW+r0QaFq8dXfbptazm2h0Sn+b5H4h2YxnpRzhEjk0LdZQtaA3/shGyPnW4/UjeS8mP5rEaIMGj8ElHOjBXNATiKkJUAF3PX4fzdmoyIzR91aksN6Bg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(41320700013)(366016)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D6p1Nxxvhk7+0yxPiP9f0WPS0REdJJbTwg50jYQ3LALK3kiXUhL3tiQvzMPB?=
 =?us-ascii?Q?Kx79FSNpKNfhisDbZtybP7pbqSISm3UOAINz5aKfnSKMbeK8wtSo9WS/n8jl?=
 =?us-ascii?Q?NalYA0N++pF3C+zAB5AQXqWkCc7W4TpowNaKtgUTiHZ1rRECWSVr6A+P9RZE?=
 =?us-ascii?Q?YdNd2QQ+QWfBu6iM4nQPaUsKFzSMybxJwGUMLFzQNXhJ3GRdc/7D6aTfYxV2?=
 =?us-ascii?Q?T0MgQWAe0XtQwShdhp3sJbwyLv1o5BJX8N/xK+x+YwZLmOcp4YOd7skurJhA?=
 =?us-ascii?Q?PkZwNQj5kLJNXPdacz+KB2qFM1D/Rlsy7t7C1+Q5H2AgMqyd1/HhdYdj50HJ?=
 =?us-ascii?Q?AGHMf/+zyvcWrpc7mc9FW1EezqduH9XhIGzmqx2SsIsIkPPXUnXUR/qbrU3Z?=
 =?us-ascii?Q?0QtTybgwjVUrrQOerhMoriEzULh21m50rTnD9SsTXzJ/hrn/wW3YbqBkf7OO?=
 =?us-ascii?Q?0zb5aTAvG0YFrwllxtpLOhL3lUMVtBxdEJkVaK2gHF/5N6HeDOiVBfACkbQC?=
 =?us-ascii?Q?+40Lf2k5fhNVyHlTBWnNfV13XZkEGBmdCydulqAGvcGAqolIQDopaA27no+D?=
 =?us-ascii?Q?HGxvjBCuZxu3fLZpmqN6uOPhHXghom0Ipqed39f7HqNaZq1zCqreFTi3M7Rn?=
 =?us-ascii?Q?B51g1GL1CbFVB6/aMj9YIrxErzK3WlJrTIyVClgKeZGnZiVi4SadpH/+PWBx?=
 =?us-ascii?Q?frJxNafVgThDAxue6PlUIbWHTSmmUzzcJhdyyhc28j3BXfMTwCZZBu+0Qk7W?=
 =?us-ascii?Q?wqtJXUjrNoqUPKgxP55bgCckZ11u1T0lRGP3SobGLTBN07brtee2MV/7h4Pl?=
 =?us-ascii?Q?UEgh9UzQCFK/Cw4/RssA+Pdg/ijw52MNAzS51tSH4YTPXwP6pbYn/wvIflTL?=
 =?us-ascii?Q?Dlj5iiM2iRtHg073soK0urJAYZpWTuhcPzT5EcY6NuO52EqYEkx+dMrQ+ax/?=
 =?us-ascii?Q?mn1u2tC/gey4RG3FmcS56sHa8DbE9/ytG7LrY7Dc21tG7SBY5QBeyuokme5S?=
 =?us-ascii?Q?2MH0pKUKQ7j4HOVi2HKdqV1QSe29dQdxb7G24p9gQLwQrMqx2nGJ4J/A9oa8?=
 =?us-ascii?Q?K40gdwWLSrAeWIr1K/jtH3oDpEJoZfy6BEdTW60J4k2IthM5qqqlVUGIYYup?=
 =?us-ascii?Q?0fu4iVMED0nu/3Iv8z479Zgb18I8Wp3BonZZpN+qglCWfL6jDSSu0uH1+Bnb?=
 =?us-ascii?Q?saZOmjq7NldE3TKg+MRr+QjJTt2dtOv79BmSTU+IowP4gQkxLRhcvSa9qSYK?=
 =?us-ascii?Q?GKwCRjxxnE7FH9RDIWDjQTZgnNCHVWLt3lOqoz3PTKmypfB8XTh7fzgaoocB?=
 =?us-ascii?Q?k4zfTmXXO0fdFhrFjb1JGIUNr6dgqHD28EW4yO8eXCwPUDNnjYUancidaYI0?=
 =?us-ascii?Q?bFbhUi7aqBbHIHQ2fx7v7PfhJsCb2w9pHbtGizNBJvVH0rgCHTmQps7Ji31L?=
 =?us-ascii?Q?6rRQgP7+620+C0lk8xcculiZ9AIuIHRpe7gv+QS4J+AsceP0QY/h989HpGaB?=
 =?us-ascii?Q?0Atf+11dHjMXTsKFQpDoOs8J6jMQ9BUbSMQTjQPsW1ZdB6OAAFdtA5X2dtPd?=
 =?us-ascii?Q?3N2J6LK9dJkOBv/MW5YvU2idnI9tqQYIgrRwHBX1bgiGQFI7cAZyVXmFbU/T?=
 =?us-ascii?Q?EA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df870da5-21bc-4b70-292f-08dde6c2b615
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 06:10:11.0236 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AKvOGDQhqH2m/mfkfgK60Wg+CLvpLuNYa/gvaQxL19F8OupKmymbnNBUN/NdA+TbVFD+ISwDXqOQyoRmNM4mYMelZUpzX9OYb1mECEp4lx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1258
X-Mailman-Approved-At: Fri, 29 Aug 2025 16:29:12 +0200
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

Add eeprom data format v3 support.
Add wifi_bt field in ATOM4 and add "mac wifi_bt <?>" command to modify it.
Set or show eth0/1 MAC address only if the board has eth0/1.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 .../visionfive2/visionfive2-i2c-eeprom.c      | 91 ++++++++++++++++---
 1 file changed, 78 insertions(+), 13 deletions(-)

diff --git a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
index 43b8af4fc59..7352252c475 100644
--- a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
+++ b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
@@ -11,7 +11,7 @@
 #include <u-boot/crc.h>
 #include <linux/delay.h>
 
-#define FORMAT_VERSION		0x2
+#define FORMAT_VERSION		0x3
 #define PCB_VERSION		0xB1
 #define BOM_VERSION		'A'
 /*
@@ -105,7 +105,8 @@ struct eeprom_atom4_data {
 	u8 bom_revision;		/* BOM version */
 	u8 mac0_addr[MAC_ADDR_BYTES];	/* Ethernet0 MAC */
 	u8 mac1_addr[MAC_ADDR_BYTES];	/* Ethernet1 MAC */
-	u8 reserved[2];
+	u8 wifi_bt;			/* WIFI/BT support flag */
+	u8 reserved;
 };
 
 struct starfive_eeprom_atom4 {
@@ -128,6 +129,35 @@ static union {
 /* Set to 1 if we've read EEPROM into memory */
 static int has_been_read __section(".data");
 
+static const char * const board_no_eth0_list[] = {
+	"FML13V01",
+};
+
+static const char * const board_no_eth1_list[] = {
+	"FML13V01",
+	"MARS",
+	"VF7110SL",
+};
+
+static bool board_have_eth(u8 eth)
+{
+	int i;
+
+	if (eth == 0) {
+		for (i = 0 ; i < ARRAY_SIZE(board_no_eth0_list); i++)
+			if (!strncmp(pbuf.eeprom.atom1.data.pstr, board_no_eth0_list[i],
+				     strlen(board_no_eth0_list[i])))
+				return false;
+	} else {
+		for (i = 0 ; i < ARRAY_SIZE(board_no_eth1_list); i++)
+			if (!strncmp(pbuf.eeprom.atom1.data.pstr, board_no_eth1_list[i],
+				     strlen(board_no_eth1_list[i])))
+				return false;
+	}
+
+	return true;
+}
+
 static inline int is_match_magic(void)
 {
 	return strncmp(pbuf.eeprom.header.signature, STARFIVE_EEPROM_HATS_SIG,
@@ -176,17 +206,22 @@ static void show_eeprom(void)
 	printf("Vendor : %s\n", pbuf.eeprom.atom1.data.vstr);
 	printf("Product full SN: %s\n", pbuf.eeprom.atom1.data.pstr);
 	printf("data version: 0x%x\n", pbuf.eeprom.atom4.data.version);
-	if (pbuf.eeprom.atom4.data.version == 2) {
+	if (pbuf.eeprom.atom4.data.version >= 2 && pbuf.eeprom.atom4.data.version <= 3) {
 		printf("PCB revision: 0x%x\n", pbuf.eeprom.atom4.data.pcb_revision);
 		printf("BOM revision: %c\n", pbuf.eeprom.atom4.data.bom_revision);
-		printf("Ethernet MAC0 address: %02x:%02x:%02x:%02x:%02x:%02x\n",
-		       pbuf.eeprom.atom4.data.mac0_addr[0], pbuf.eeprom.atom4.data.mac0_addr[1],
-		       pbuf.eeprom.atom4.data.mac0_addr[2], pbuf.eeprom.atom4.data.mac0_addr[3],
-		       pbuf.eeprom.atom4.data.mac0_addr[4], pbuf.eeprom.atom4.data.mac0_addr[5]);
-		printf("Ethernet MAC1 address: %02x:%02x:%02x:%02x:%02x:%02x\n",
-		       pbuf.eeprom.atom4.data.mac1_addr[0], pbuf.eeprom.atom4.data.mac1_addr[1],
-		       pbuf.eeprom.atom4.data.mac1_addr[2], pbuf.eeprom.atom4.data.mac1_addr[3],
-		       pbuf.eeprom.atom4.data.mac1_addr[4], pbuf.eeprom.atom4.data.mac1_addr[5]);
+		if (board_have_eth(0))
+			printf("Ethernet MAC0 address: %02x:%02x:%02x:%02x:%02x:%02x\n",
+			pbuf.eeprom.atom4.data.mac0_addr[0], pbuf.eeprom.atom4.data.mac0_addr[1],
+			pbuf.eeprom.atom4.data.mac0_addr[2], pbuf.eeprom.atom4.data.mac0_addr[3],
+			pbuf.eeprom.atom4.data.mac0_addr[4], pbuf.eeprom.atom4.data.mac0_addr[5]);
+
+		if (board_have_eth(1))
+			printf("Ethernet MAC1 address: %02x:%02x:%02x:%02x:%02x:%02x\n",
+			pbuf.eeprom.atom4.data.mac1_addr[0], pbuf.eeprom.atom4.data.mac1_addr[1],
+			pbuf.eeprom.atom4.data.mac1_addr[2], pbuf.eeprom.atom4.data.mac1_addr[3],
+			pbuf.eeprom.atom4.data.mac1_addr[4], pbuf.eeprom.atom4.data.mac1_addr[5]);
+		if (pbuf.eeprom.atom4.data.version >= 3)
+			printf("WIFI/BT support: %x\n", pbuf.eeprom.atom4.data.wifi_bt);
 	} else {
 		printf("Custom data v%d is not Supported\n", pbuf.eeprom.atom4.data.version);
 		dump_raw_eeprom();
@@ -260,6 +295,7 @@ static void init_local_copy(void)
 	pbuf.eeprom.atom4.data.bom_revision = BOM_VERSION;
 	set_mac_address(STARFIVE_DEFAULT_MAC0, 0);
 	set_mac_address(STARFIVE_DEFAULT_MAC1, 1);
+	pbuf.eeprom.atom4.data.wifi_bt = 0;
 }
 
 /**
@@ -385,6 +421,28 @@ static void set_bom_revision(char *string)
 	update_crc();
 }
 
+/**
+ * set_wifi_bt() - stores a StarFive WIFI/BT support flag into the local EEPROM copy
+ *
+ * Takes a pointer to a string representing the numeric WIFI/BT support flag in
+ * decimal ("0" or "1"), stores it in the wifi_bt field of the
+ * EEPROM local copy, and updates the CRC of the local copy.
+ */
+static void set_wifi_bt(char *string)
+{
+	u8 wifi_bt;
+
+	wifi_bt = simple_strtoul(string, &string, 16);
+	if (wifi_bt > 1) {
+		printf("WIFI/BT support flag must not be greater than 1");
+		return;
+	}
+
+	pbuf.eeprom.atom4.data.wifi_bt = wifi_bt;
+
+	update_crc();
+}
+
 /**
  * set_product_id() - stores a StarFive product ID into the local EEPROM copy
  *
@@ -478,6 +536,9 @@ int do_mac(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	} else if (!strcmp(cmd, "bom_revision")) {
 		set_bom_revision(argv[2]);
 		return 0;
+	} else if (!strcmp(cmd, "wifi_bt")) {
+		set_wifi_bt(argv[2]);
+		return 0;
 	} else if (!strcmp(cmd, "product_id")) {
 		set_product_id(argv[2]);
 		return 0;
@@ -513,8 +574,10 @@ int mac_read_from_eeprom(void)
 	}
 
 	// 1, setup ethaddr env
-	eth_env_set_enetaddr("ethaddr", pbuf.eeprom.atom4.data.mac0_addr);
-	eth_env_set_enetaddr("eth1addr", pbuf.eeprom.atom4.data.mac1_addr);
+	if (board_have_eth(0))
+		eth_env_set_enetaddr("ethaddr", pbuf.eeprom.atom4.data.mac0_addr);
+	if (board_have_eth(1))
+		eth_env_set_enetaddr("eth1addr", pbuf.eeprom.atom4.data.mac1_addr);
 
 	/**
 	 * 2, setup serial# env, reference to hifive-platform-i2c-eeprom.c,
@@ -585,6 +648,8 @@ U_BOOT_LONGHELP(mac,
 	"    - stores a StarFive PCB revision into the local EEPROM copy\n"
 	"mac bom_revision <A>\n"
 	"    - stores a StarFive BOM revision into the local EEPROM copy\n"
+	"mac wifi_bt <?>\n"
+	"    - stores a StarFive WIFI/BT support flag into the local EEPROM copy\n"
 	"mac product_id <VF7110A1-2228-D008E000-xxxxxxxx>\n"
 	"    - stores a StarFive product ID into the local EEPROM copy\n"
 	"mac vendor <Vendor Name>\n"
-- 
2.43.2

