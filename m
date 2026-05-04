Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B5B5FF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 13:42:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEE6C846AE;
	Mon,  4 May 2026 15:42:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CCE284686; Mon,  4 May 2026 15:41:59 +0200 (CEST)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20720.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::720])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E5E28469D
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 15:41:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSKTK4WUkCjc4MhI/AmP6SlT9eVrLsUHDriEbZakE/T32bNrCPJQ92YkW/sasv0tSpJ42/dbZqatcnIzMyOr42qKw6B9QNq2596QEqB9bPbs1pMI4x1HWI/lTDmfGB3wBXdC56srmyHTNrRS9CGZgVEIK2SLAZRunwhqto5pGZv8MQCeCLRlF18yCMrQdItBnEs5fvUTfhrQ7RfkKgFoHcN5ZJdUp0sZcIFS/w/O1YurhlHbgvP3k3zmgcY85YVNKw65vdvu9LwyPyCDXDPG2m3Idh0UbLv7k7zoc6t1wjTp2qydRFZwAsF/csIJiAK6mfp8oNQGfRBW0Uk9E59Www==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDkiPPOUBpLAcBjMUVGcvRTOqwqfuXSe5wqBYWIxe0U=;
 b=bLIXqC+QLpStcrXWpzRpRd41mTReoAKD3kVUDYbL6PZK7JmKDWd/vV/j5MpUxyXSEE0HQPKq8P1bIdnxQO1QKKATO/HTnFhH4VBA9Zm9GiFKQk+jaA8e0wqGPaw3EGKl+D02LM03ZksoiZvNi5ljU+8O/kHB7u8h3Rw/D65txTDRHoeol35QJJnOF5Xe4bOozjz4HvATegrywPAaHMt3aKNRYNrmR72V6gIom3kw48rLdyk/PxI0DarLus5e8odydNJVxgAGnzWjzYP0xAq8s/rcDcm79EvH6XI07f40ZGwIviHk9PZbW1c+wxbrsaZbexQ6zU1xk35d8yVBx491wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1227.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 13:41:44 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::4386:5cc4:3bc4:4795]) by
 ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn ([fe80::4386:5cc4:3bc4:4795%4])
 with mapi id 15.20.9870.023; Mon, 4 May 2026 13:41:44 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo Yu-Chi Liang <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Rick Chen <rick@andestech.com>, Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, E Shattow <e@freeshell.de>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2 2/2] board: starfive: visionfive2: Support VisionFive 2
 Lite eMMC
Date: Mon,  4 May 2026 21:41:35 +0800
Message-ID: <20260504134135.4542-3-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20260504134135.4542-1-hal.feng@starfivetech.com>
References: <20260504134135.4542-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0017.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::29) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1227:EE_
X-MS-Office365-Filtering-Correlation-Id: e9472657-c73b-4e47-06f8-08dea9e2e19a
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|52116014|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 7DSCHGdZxLF3ThK0MFnuWHsc9Tj9M2VLLGJ6qUi8LjNKupyB91mMTewprEND6LWlfYBVj5h2CDjWJdbUgVBPb5OoifZRc+WoYBjO6Aj8tgRsZYvVaHZM6TBvf/4s9VM9n338dVM+PudLhGWl3HQ8v8b6Ue1kAD4sV5ixBM5ovsxlSA4Ghzjkiu6dMEk8ThkeziQ6/06wlXhfDnCqxhSBpIRElT2GIM3Xvh6sK5yJUXFVykinYZ934EMMSc3hd3DOINrHlhmXR1bDTnP2vVIBeB4SJAUMqHCGSbqS8teluxIH/trPLnJlpUdplGDyZKjE4U9sW7DUEiVxzo4eLu4ICzWiRjPGQu8fyVvVr7g5OlyPyLN6RTZ6uhXoQKBXnUS18C+zLKmj3B9a+xJ+3PDU4M4m37irRTbQV0xA3Z0Tma1kYBPRDb9J4/uLXvtqfxPgnHv77WvRZGVyj2tMaerOhz5BdNh2jud7/Sb9zjTkGVedSUDqE1acOCZ46Jgw6LlVfwvO56mXdX3grnRHuVBnEmqD4PT3mIHuWRMPZlinZ5btaLjk/MyjdIFrY6or2GAp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5ZAMHlEVnwA9VZVrt36B5e0SeTq7S7vMk9JAARYsOvuPZEFhHNzyp8qCu6yP?=
 =?us-ascii?Q?FCFHv5V0kYLSrkQYr2jRehb/i+SAckADHIrKTYWHywcwJNY3O7bOHBVxLbSe?=
 =?us-ascii?Q?eDWDVPB/LUoaxQvXPqV0EupTC2i5/gSQSB9muZCGJ9K5Na6ALFX8PpGs0iod?=
 =?us-ascii?Q?3xc6snl6nRquweY2fSVvkgXVzjQ4DHW1F34b1epKBJWb+lIhnWCx1CgmzKEU?=
 =?us-ascii?Q?UqS0PVhzBBf4veNqq0SSXVsgyGvA3PmIRAXn/YEybAtXim8KxOCtC0lR2gFc?=
 =?us-ascii?Q?cVAa/gbNhcw390cOiAOS+kjRJWSkSi7JjLA7ZTF27QFSeEWrgq3yFyohqgxe?=
 =?us-ascii?Q?f3UicKaWx/A0y+qH56xTPcf0edasy/Z8s4Td1Gw3rM/YKGUAfe9rigsqLptC?=
 =?us-ascii?Q?4EfxeROb4EIgemUQQEoF6Nl7w5MnE8kbkREywV927Pxn6SvkFR3JfRvj44V6?=
 =?us-ascii?Q?xxyEh4gXupJ0dHAlyIv4l8y9lYWmL2FyRQzWU6kwmIN8zn3tv+UlO9sGHW31?=
 =?us-ascii?Q?ZkyYVIReAgMWiKfBCUXRVhWvlSOKitFPZUxrr0K0Frzu3Pfv8ZUpSHUT470p?=
 =?us-ascii?Q?0RvbxEJrCSrzc0sGalqXGNMA7XzkU3GOT6pbaIq7WhOv2FI13aqSlO+gENHs?=
 =?us-ascii?Q?m+3Blg/2o2Ywn9Jsi4TsXEVUR0IMQAfc/fpmkzziSsWsBkWaXLS0581e3jyH?=
 =?us-ascii?Q?1Qzlb21Ai04ChDA+o4qXmrWPSiNEtzc4JJ7nLXtpILVw/VRdSSL+obd593La?=
 =?us-ascii?Q?l9LNZ7VSaII/FhTtk7AUHfrJTh397itIp6XNv3eV8KKJOIUpkG18yo4KNaCa?=
 =?us-ascii?Q?tOnjLf2OfrEAHiwiDT9pnwXt/i+/7UYNb8ogWqKzQODrada08rvO/NlRslvm?=
 =?us-ascii?Q?i1zg+5ODSIC7mUbk4tiueWCsrlVGbJtu6MOv6jc95do/07FI31KohaAFNBwJ?=
 =?us-ascii?Q?PID322KkWymAOSGa/G0BcKairM3MWoW4hXjw+97jVHYqulOituGF5ynHIyBY?=
 =?us-ascii?Q?di93aRpyK4km0b2NpB1La1NrCKNTF5UN9n1msgw0iT+g7V+psAgUvlAplhYT?=
 =?us-ascii?Q?apKBUCvPf0pHHjjL9uVU2LPT6YdHzFikmuIScgWjt/aZ2j7+rgOZa9lLlNhR?=
 =?us-ascii?Q?5on/Z/t013WSr70zW8QmQb/nzNu6F1Re+sczNaoFH0z91vD+iDPvefIgsHl6?=
 =?us-ascii?Q?cNt1TfpowwCFp0JSnS0jRDo9N7qg/3oALsleJ+OtJpocVWbyzFQOZwX2LtXh?=
 =?us-ascii?Q?OXGlKPV5xIp5+8Gfyvaryd2gH66c+bwWhy/Jc9kS+uPWsQdKmOUwSWtDZE49?=
 =?us-ascii?Q?16HF80rOe7dHyo6Mnwc3UChMl9NQkqC/i1BlKe8KslQh5AVlG5K2KOoymtZb?=
 =?us-ascii?Q?LwPq2GfG/O4tu013EI1AA3pkXCwqch7uwu1I1bJHAMCa6kAgRKnsb2d9ttq2?=
 =?us-ascii?Q?yLVEs/mmFwm4r0Iu3vkVZDRqe3MjbAJcAUGDcxbOFqFoEM2nomBiTy1ywjzp?=
 =?us-ascii?Q?Bd6bb3svxhujdGt/0Wq87T1FKUr96WKftRDzagtj0j//HqjZEvDJ94d3/hat?=
 =?us-ascii?Q?rO/Xj7dKI5wKLLKahkTj6fF9i2nrQ5sqvs+O9/B5Xlr37Cprwb7yxv4YGPWa?=
 =?us-ascii?Q?CjRyjcDfx+wagicuriHmx58YkupGDEDDzKx41Cmo+RlbEhz7EuGCxxEFYa/w?=
 =?us-ascii?Q?viU++jDDgbHTCQqADILQpGQdnA5MIZqATTu8Y9kz5MIeaW3XPh2WshfxF82P?=
 =?us-ascii?Q?vf4F5Zh6rWPLPmOYJBH6ZidNO3ozqwU=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9472657-c73b-4e47-06f8-08dea9e2e19a
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 13:41:44.7131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: idBc3Ejm9JPWQlRZRXSAuJgwqA6OP3Z9A2zLXlfXy/owVp0c/CZuL6YON+D2Z0J1CRtbRDP+Aw4ZbHYQbi+B1B9TjT5NCrHH+KGyBYXi/1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1227
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

Add emmc detection to VisionFive 2 Lite DT selection and
fdtfile environment variable setting.

Reviewed-by: E Shattow <e@freeshell.de>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 board/starfive/visionfive2/spl.c                  | 7 ++++++-
 board/starfive/visionfive2/starfive_visionfive2.c | 6 +++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index e231467f2a1..1b4d623d002 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -144,7 +144,12 @@ int board_fit_config_name_match(const char *name)
 		    !strncmp(get_product_id_from_eeprom(), "VF7110B", 7)) {
 		return 0;
 	} else if (!strcmp(name, "starfive/jh7110-starfive-visionfive-2-lite") &&
-		    !strncmp(get_product_id_from_eeprom(), "VF7110SL", 8)) {
+		    !strncmp(get_product_id_from_eeprom(), "VF7110SL", 8) &&
+		    !get_mmc_size_from_eeprom()) {
+		return 0;
+	} else if (!strcmp(name, "starfive/jh7110-starfive-visionfive-2-lite-emmc") &&
+		    !strncmp(get_product_id_from_eeprom(), "VF7110SL", 8) &&
+		    get_mmc_size_from_eeprom()) {
 		return 0;
 	}
 
diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/starfive/visionfive2/starfive_visionfive2.c
index 1a76f745ec8..97f40715f8f 100644
--- a/board/starfive/visionfive2/starfive_visionfive2.c
+++ b/board/starfive/visionfive2/starfive_visionfive2.c
@@ -72,7 +72,11 @@ static void set_fdtfile(void)
 	} else if (!strncmp(get_product_id_from_eeprom(), "VF7110B", 7)) {
 		fdtfile = "starfive/jh7110-starfive-visionfive-2-v1.3b.dtb";
 	} else if (!strncmp(get_product_id_from_eeprom(), "VF7110SL", 8)) {
-		fdtfile = "starfive/jh7110-starfive-visionfive-2-lite.dtb";
+		if (get_mmc_size_from_eeprom()) {
+			fdtfile = "starfive/jh7110-starfive-visionfive-2-lite-emmc.dtb";
+		} else {
+			fdtfile = "starfive/jh7110-starfive-visionfive-2-lite.dtb";
+		}
 	} else {
 		log_err("Unknown product\n");
 		return;
-- 
2.43.2

