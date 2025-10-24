Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7730BCCF9E0
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 14:53:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62D7083857;
	Fri, 24 Oct 2025 16:53:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F1F88362A; Fri, 24 Oct 2025 10:59:51 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2072b.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::72b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40A37836A3
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 10:59:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/F9jhEf4+QiGxUXPprIweGDFKjIFq4Umbo3TyTLSWEmri/+Jf94+2WIqcnhpoCos7SS9qVaOMkqj34SpqvASgQbl80cc/o7uHpXrfXdCH9yj3cHMft217gM2qI8bgbcKCJsDPM3Fe6wHgHD397urGjez/wsLyGzJ5ohQ3FyhWS9z7aGG+LXSj3eOxxijcjmXvaOodPh+B9bRKpGTnEkL02nRblKosdTq/Ckrz8hAXy+yYgO3ECYHHY213Z1t10p1wewYWxMFVCOlX2etnxY25S6J3ihz86LqkSCVCOWLOYP7v5x4KriSbddwjk894ocNp8b3285M3eRTrpdZyYE0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=foK2Dfy6nsK/2E7fVwhqemRDQJzFyMo8JJpmVjLhdNk=;
 b=SgGeZDC2hRvUkOVSr1JwT1gFruhyxfLb713nYPume7LSMaZ4tl19XVWTka2532hYr+v+RCMdj+VZUO40Kl6lXlgo3pch8Z110NsVZf7oFsZ9XJTfIglmyq/Ww/gjXwlOuYYB2DcWxzdRvs0cwLLp1g3z9Ax5DQJ6+WDggE5kJ+SQBZWSTv0K7ra3/M0BDSqUhy5BGlTSJyYkxGI+3TvFCTQUXnFqEcJhaQ27C4Bd1UBTN7c0HaqjLZH4M3SgGGeGqN2iK9f8Hyq067O8keS/LDyq3RJRqhHbgeaoLwblPvD0lmt2DCQXuMbM9rd5GUyz+R9F+jCHlHmXCnevH2B8Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1228.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.18; Fri, 24 Oct
 2025 08:59:43 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9228.016; Fri, 24 Oct 2025
 08:59:43 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Rick Chen <rick@andestech.com>, Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 E Shattow <e@freeshell.de>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1 5/9] eeprom: starfive: Support eeprom data format v3
Date: Fri, 24 Oct 2025 16:59:28 +0800
Message-ID: <20251024085932.83596-6-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20251024085932.83596-1-hal.feng@starfivetech.com>
References: <20251024085932.83596-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0069.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::36) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1228:EE_
X-MS-Office365-Filtering-Correlation-Id: df4d3017-78cc-4497-c5ca-08de12dbac79
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|41320700013|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: xcUJ5uWZ3N7K73M+IjE8RsDnqarLoX/hJ4onMIW+bwU8g5HqfMmKXNH4Bma0mqNJllnHzeYQEvwQAFp8pC9cJtyFmXiGGI7uuexhYcc+LAMQwzRdThCfwPC6PTHTV3CX+UIBZgAVuHCmMz53ZN4CP9RhcBkdISj1wyt8Cmj/SXNFVB/u5NAo5FzoPl3lTcaDRFq/jZFViL5nFVQwiymgIOu7b6Dg/fIB97KfN2vWNjODL/wE95Pw/XSZdVIKyFfauvC5dYTY7LnLaj9jjXya2hwqS90yWlkAr8vCnB2wC0BAxfoTCndLoilMf3BILr0xxEZvhNKKqV5yjlng0749KUWyCag2Rsh+hNc/MNH40Fr/zTmibNA/wsJQ8ZHCXX3UW/rE0sUEVFdpTjKIXoxmgnS32RJrmKdkt7RCUnQOnitmqHNuAFnMAZwK/NbSgtw7ldVZ3dLy8Vejv5ucrHfr/1yIsDETvFJ7llUNjeflF7X/MIiYl4+22bmjpf0ba/BONVoldlglHcVyclY+MFnK4+drtSJpdnGYc32fJRfsS78DGCVNiVOujBxQB1h4u3RQClnsSMYYIDu6cn1aIQdIe0GDMX5RW0MiMIloIuyh63M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(52116014)(41320700013)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iGV5eDjcTGeedoUah1pJq7UL48kRCfRWjsp82n7zTQwbk80mM5Jb8i9NZlY/?=
 =?us-ascii?Q?k/LU7xpClrE905Eq0AxwtkuNGAPWpGLyi1ENDM+CyblllkW9ldN7nOL2s4Xj?=
 =?us-ascii?Q?geeAIWeaCdF+Y0SZQo1E1DZdYXVm8rdnj0I2nOKGgH+F6A4HOGoIPwzkfbA2?=
 =?us-ascii?Q?sOEWZF5VV+xTfM0JTMCCWeXRzLTDQxF+WtvaYV+ShdjKEs5pcIoFVcjhbeqY?=
 =?us-ascii?Q?Ge9CZcGQCNT9KOyh0zIvEBPb08d150zLy2N4AqO5UBWmrPr5KRyN7asNAsf3?=
 =?us-ascii?Q?BEHCoSK533BeFhigSpIkOx6U8kEDAYT21y3qsbg6wzB3DW+pFDZCB1kCl7aP?=
 =?us-ascii?Q?6OClXjFWp9f8VsKUsMRlrNTJaqcm9h6XMml1F7Z8TI6S2cwzkQBAbQ5c5UtN?=
 =?us-ascii?Q?eHGzP03Dou4DqhZG8fg2+Uhm+MVe/+wBoMvSc+aDmTCXLromKSldltSR3ONn?=
 =?us-ascii?Q?HFG6g+wl323dcOmetEDwclwcVKfRVRvx+7NhllwFPujEORcmxSfKWY+8TUe/?=
 =?us-ascii?Q?JKIjeEaMLsKNW3ihSGKPyAUIIVZNFREbnHgYnLlt3qzpMxVO7ijowT2xo9ZT?=
 =?us-ascii?Q?C6gTpEWebWLIoCv0puLfg3e9akgztDSnthSKRBfGIiAYFrPGM0sv616sIFPG?=
 =?us-ascii?Q?NctNo88ZvWpTUez1IutxFUKAvQ6zzMd6pZ/3hLaNqVlOlb8RdOsrbojlxXM0?=
 =?us-ascii?Q?j230w0IY/queAakqMfSEhtC/HdcDimJMgMMp3FuSe3icUBWA3u1ECzZhsJff?=
 =?us-ascii?Q?e6V18u5QBKvCAOdr1l7mvkL0KNXGH3V456e18kTybVnBVWcNkx380etecgX2?=
 =?us-ascii?Q?QuTpfXucsAxjD96Rh3EslbFVfQWduK4jtWd4bGwZeOWt93CuyxRmAXnATx8m?=
 =?us-ascii?Q?jNDtqzk9iGf08mWyGAR9XJzdPJ4O1sstxO2F9cpaQebSdLmSQ1I1O0nC+aUW?=
 =?us-ascii?Q?hkQ6a0+G9h0dkmqzin1qFYda+5QINZOvDHDqRVU0Y5qktHQ8JfY4rXYGcZ4v?=
 =?us-ascii?Q?+Q7ZvAqePf/UO9T8NYjiPEDJTuFWq89dhNUnltHMm2uz+rcqayyAr1B9gfDn?=
 =?us-ascii?Q?AhnlcF04EI0nwtRUoad7zRANzGGXR9LSNcfLcPsPiKjD/CrF9yLdZQO9geiR?=
 =?us-ascii?Q?3K0Q5twOyUxeMXeitmoVAFu/WrXY4xleJQcrRRfqqeneeKVg1YyR/wOV3sq1?=
 =?us-ascii?Q?yZniK/9OzjvEOfw48bST18uYvB+af+CSAKYwIehTgTrVOg/1dRyZ3pTqyPo4?=
 =?us-ascii?Q?y7iyxzX4qC9cWTBootDrS7T2bceJgn9kl0cwKdpaYS607I61ZzrXItIuROVZ?=
 =?us-ascii?Q?4iwuupgNz+R9wY2oVHl+r9tMIK2UEl4ZawNaT8ieMNKiFiuS1QQI7EtmaxK6?=
 =?us-ascii?Q?jaO2fFkk0L6yLFOJVrdCiSzlEGg6bL2CCyuF1gSd4/FRqpqJZsDgL8e2OlUw?=
 =?us-ascii?Q?fXTjpw81D5JRpt9UdxK0S5l4eEmBF1VVe+R0QVhkkiqOFUtZQBpgMPjWv4dp?=
 =?us-ascii?Q?sZStv36CxNaV5q0iwj5KcydWcPdKqfy2qVVwPUVC3iJ0aw8YXmPSgj01C8sq?=
 =?us-ascii?Q?HIX+5dkiWTHGVDM6USrnCMYGodYyJ4wsFUpnreD6f0BweXOKmdNin9IVlCKT?=
 =?us-ascii?Q?gw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df4d3017-78cc-4497-c5ca-08de12dbac79
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 08:59:43.5053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 18FkhG4pyE8tkxHj4Iloal+G3sfGfeEB4Bj443/vXU+8ArxodEkTKFdXw11Qtu5O01HerTmV1idqzGJ457PY5afRMP0vcu3A6xajjp/BAOk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1228
X-Mailman-Approved-At: Fri, 24 Oct 2025 16:52:55 +0200
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

Add eeprom data format v3 support. Add onboard_module field in
ATOM4 and add "mac onboard_module <?>" command to modify it.

The onboard module field marks the additional modules compared
with VisionFive 2 board. Now we define

bit7-1: reserved, bit0: WIFI/BT

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 .../visionfive2/visionfive2-i2c-eeprom.c      | 36 +++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
index 986dcc94992..b9197cdd34f 100644
--- a/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
+++ b/board/starfive/visionfive2/visionfive2-i2c-eeprom.c
@@ -105,7 +105,8 @@ struct eeprom_atom4_data {
 	u8 bom_revision;		/* BOM version */
 	u8 mac0_addr[MAC_ADDR_BYTES];	/* Ethernet0 MAC */
 	u8 mac1_addr[MAC_ADDR_BYTES];	/* Ethernet1 MAC */
-	u8 reserved[2];
+	u8 onboard_module;	/* Onboard module flag: bit7-1: reserved, bit0: WIFI/BT */
+	u8 reserved;
 };
 
 struct starfive_eeprom_atom4 {
@@ -176,7 +177,7 @@ static void show_eeprom(void)
 	printf("Vendor : %s\n", pbuf.eeprom.atom1.data.vstr);
 	printf("Product full SN: %s\n", pbuf.eeprom.atom1.data.pstr);
 	printf("data version: 0x%x\n", pbuf.eeprom.atom4.data.version);
-	if (pbuf.eeprom.atom4.data.version == 2) {
+	if (pbuf.eeprom.atom4.data.version == 2 || pbuf.eeprom.atom4.data.version == 3) {
 		printf("PCB revision: 0x%x\n", pbuf.eeprom.atom4.data.pcb_revision);
 		printf("BOM revision: %c\n", pbuf.eeprom.atom4.data.bom_revision);
 		printf("Ethernet MAC0 address: %02x:%02x:%02x:%02x:%02x:%02x\n",
@@ -187,6 +188,14 @@ static void show_eeprom(void)
 		       pbuf.eeprom.atom4.data.mac1_addr[0], pbuf.eeprom.atom4.data.mac1_addr[1],
 		       pbuf.eeprom.atom4.data.mac1_addr[2], pbuf.eeprom.atom4.data.mac1_addr[3],
 		       pbuf.eeprom.atom4.data.mac1_addr[4], pbuf.eeprom.atom4.data.mac1_addr[5]);
+		if (pbuf.eeprom.atom4.data.version == 3) {
+			char str[25] = "Onboard module: ";
+
+			if (pbuf.eeprom.atom4.data.onboard_module & BIT(0))
+				strcat(str, "WIFI/BT");
+
+			printf("%s\n", str);
+		}
 	} else {
 		printf("Custom data v%d is not Supported\n", pbuf.eeprom.atom4.data.version);
 		dump_raw_eeprom();
@@ -260,6 +269,7 @@ static void init_local_copy(void)
 	pbuf.eeprom.atom4.data.bom_revision = BOM_VERSION;
 	set_mac_address(STARFIVE_DEFAULT_MAC0, 0);
 	set_mac_address(STARFIVE_DEFAULT_MAC1, 1);
+	pbuf.eeprom.atom4.data.onboard_module = 0;
 }
 
 /**
@@ -385,6 +395,23 @@ static void set_bom_revision(char *string)
 	update_crc();
 }
 
+/**
+ * set_onboard_module() - stores a StarFive onboard module flag into the local EEPROM copy
+ *
+ * Takes a pointer to a string representing the numeric onboard module flag in
+ * Hexadecimal ("0" - "FF"), stores it in the onboard_module field of the
+ * EEPROM local copy, and updates the CRC of the local copy.
+ */
+static void set_onboard_module(char *string)
+{
+	u8 onboard_module;
+
+	onboard_module = simple_strtoul(string, &string, 16);
+	pbuf.eeprom.atom4.data.onboard_module = onboard_module;
+
+	update_crc();
+}
+
 /**
  * set_product_id() - stores a StarFive product ID into the local EEPROM copy
  *
@@ -478,6 +505,9 @@ int do_mac(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	} else if (!strcmp(cmd, "bom_revision")) {
 		set_bom_revision(argv[2]);
 		return 0;
+	} else if (!strcmp(cmd, "onboard_module")) {
+		set_onboard_module(argv[2]);
+		return 0;
 	} else if (!strcmp(cmd, "product_id")) {
 		set_product_id(argv[2]);
 		return 0;
@@ -585,6 +615,8 @@ U_BOOT_LONGHELP(mac,
 	"    - stores a StarFive PCB revision into the local EEPROM copy\n"
 	"mac bom_revision <A>\n"
 	"    - stores a StarFive BOM revision into the local EEPROM copy\n"
+	"mac onboard_module <?>\n"
+	"    - stores a StarFive onboard module flag into the local EEPROM copy\n"
 	"mac product_id <VF7110A1-2228-D008E000-xxxxxxxx>\n"
 	"    - stores a StarFive product ID into the local EEPROM copy\n"
 	"mac vendor <Vendor Name>\n"
-- 
2.43.2

