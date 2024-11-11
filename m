Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EAC2D12D60
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 02:25:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15E6489372;
	Mon, 11 Nov 2024 03:23:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90425892E5; Mon, 11 Nov 2024 03:09:48 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20730.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::730])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E9438911A
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 03:09:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQBLh29bnWg8uhdRzfD3qB6BQb4cFBGnB66TfALRg7YJ689s5CfpScmvl+w7gz95nxqLJ12GGdvbEaiXv7s5qsGUFUCaGeqPnbtu1yorq6Pi7Epla6WQyfFHeK96JIEFPh26U/G32aPNQ5oTed4FKkFkzuiBIxSH8SHWqxpskLfxodGDSRMqGmRMZgciKU8g9vFTpcjIk8dOz48Ohci9D6PrlhaaPCjJBO+swPwPVvUD1x2s82qoM3g9I8388euQt1Z+QuppoSc9Ieh3D/wADN6Kn9xI45aYJ92Gzzhu4iJuDwBfkWZeNdfdYUaUIyIgZkf0/qeccoaUuBC7Ncl9eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwyfpC8mTdXKuZQPMIHmFlqu0h07/IaaLTmLu/2Yms4=;
 b=aYUovFJbZavdsONAUkET9nRrXNGjrn14Vsfb83HFdI6+VgnoRV4aSW5uHUqKDKp4sBSJ9WF78HDYa0kCcS70mDUXESRDJcEeC1JlCB5fWNRPE6S8WPFjHTqPdtEJI34PWfw/VKomBO4JBXHCrd82xKqbX2MKXgjMOiEOFo9sl1nITkFx+gdrj9i5+JrPaBPmHzIZJurCbsUPVVYdAh4jeoaZKSj9twdLBCoJRvRlL65TX6wU7FMQlxq3azWlIBYDpJ5j0tt7YUuc66rrRkei0jhw8HGUoro7eDKC/Rt9HTTT8KoPLEOU8Gsp35hvrjvuV857zY42opim2GS7nbAu0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1178.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.36; Mon, 11 Nov
 2024 02:09:52 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8114.035; Mon, 11 Nov 2024
 02:09:52 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v4 11/13] riscv: dts: jh7110: Support multiple DTBs in a Fit
 image
Date: Mon, 11 Nov 2024 10:08:06 +0800
Message-ID: <20241111020808.38974-12-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20241111020808.38974-1-hal.feng@starfivetech.com>
References: <20241111020808.38974-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0004.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::16) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1178:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c3ce2be-3aeb-43f7-684e-08dd01f5edee
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|41320700013|1800799024|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info: Nq5GHdTKKu/Qk1WCD38eA4iFvZ+BCcfDByRUXLlgKodKfK0NWJ51ZgSNa1h8nNioMcsVZQIvO1hVsJ+NghranikgH7zuzvJhZhd5NlfH1LM+zDEIRFBErVww6FD3GK0E5LtcKZ2anY25hGoScb8l6DFKl9DhxCaJTyuRW07H097GUQMKO/bG0dVY8ZIkcVBIvP5RzaEMgTL+dJGjddz0B2iNcFhIOEmzWjjHdSaOWIxFMm4F4afdRnB9PR3kYff/snJuHd27aoWQqYcJOT19u7GmYTbh62m/XOqWI0vVyeb6Xh80sFpJg0agXcMd5snct2Vvpm5TDTM7K76UKDejyrxfwXusZ5JdaBGqMNLILWqPefhxXRYichiB1IjJODPLpSW8lHBD1TytGEUQYNP0M0mRrXBIy1Kp7ldTQVwFVriUuViCb8cR6GAXs7ASvvw2RurL+qhiDlhmlkXd7ZH1fP3tcPV9MTWnY5RwTn6JgXruSGyzGU5TXddJqSR52rZcOrcQRasnCLfzo1P2j14U1e4ou4oXyekeJJIM1TgyglGofvE7hd768Cq/lGiZMTasXo3ErOBtUpLU1l54L9zwQbmpQOxQu+ByXOBoXv9IaVE7GLUAabKvGMRhGQy8DWYnO5U48k9xS7Q9hvw0iGdUKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(41320700013)(1800799024)(52116014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iTu0OmC0bE4fSeWacVSzr/u9Z37EU4ZLpYVoV/Kd+BUtsocywUKaEOOWFXl9?=
 =?us-ascii?Q?9pi9VHj6f667rAAKrMuTCcS0gNjx+YE4JZBLUMZLiccCHjUxLHbTti2oVV+N?=
 =?us-ascii?Q?jIRkB6f/XBvNezFGlCNMmv9bdpnZ4XCSE7M3jo2WXynGTVLF3K7ugrpTXHWi?=
 =?us-ascii?Q?uzagElH5y7xfekB2uC96SunpTFehSnEc+9uwRraSLbpO3DlfYuQhNUqjCTqs?=
 =?us-ascii?Q?me1GejqD+EJoVz4KY3NqrWWutrv9hqpTGG2RgqZwDxWRBipq9iwhplBrXSbz?=
 =?us-ascii?Q?CL78rvpH6tQQ4o9iAbsCjAwtTOEArakHxIqHGVLiAMjpunmCIvwyabSvYuEN?=
 =?us-ascii?Q?8S0+OT47XozuDd7kCrlGNaPoh/VZNNr4iiMd006wnd4hW4A5SuYgPHb8icW5?=
 =?us-ascii?Q?bCQPsXnughlDcfqSQx/pcwGgQjTl3Um+AFxG0TuAIApZZOMJG+ZsO5VCEvep?=
 =?us-ascii?Q?7b8Dl6cma028KqVFX7kUjsfYm/lILy3CNoIQHV3bHAbywjRrE76vqfyCTYBp?=
 =?us-ascii?Q?gAbI8AySu0fRZ7llj25t3oXfyNGQsk5RYBrvD7qT1xO9iDuxJsBza7ZylQcm?=
 =?us-ascii?Q?9owWYPnp/Ei4Lvtu2fVOuXcde5PRkvCsYE2pYw6YK+y38b2JQMryJD9PTGXC?=
 =?us-ascii?Q?rdasJ/TZCBc+QvAv1AYDWPK3PXKGlqLKCIeIYjqWyAvGK8U8OQ9vFKiXBfjl?=
 =?us-ascii?Q?IJ8DsL5TbnxQ5wuP6AOrrNKCcYKBeKt9fqMwy/Fm9pH6eUStfoMmoO4/W21x?=
 =?us-ascii?Q?WZCvwiEudUChrw80qwSgjqIsbFy9kZF4Vdz1Gn+B+G4HNE6zOvDYIYHGChyy?=
 =?us-ascii?Q?BDFcmX2PVxkGMcoowjWHq4BFdcqL7EKvSgjcteYyRJw0xCpY9Qikxgb2F9As?=
 =?us-ascii?Q?/rCoE7nWxDkAwF/uYPRyDS1HS4syf67Ycez8MWoCVnvw7hmn+ujbLu0on266?=
 =?us-ascii?Q?mtAQvnQAoPaCmIWL2jphr+2diS8osJfujAi1aIg+HN5PPb36lxYWis/SxG6s?=
 =?us-ascii?Q?VLHB6IvtUwyNpL+t1qiDUjobaFa0AFd0mrb5+pe19yxSQI6kvL54udZvAHGn?=
 =?us-ascii?Q?N7xS7Q9nxdHtqSYBiHrHzXZjMIx9UwT8KfaAegaRCqMU066etCS2Xb6DoigV?=
 =?us-ascii?Q?sPKC9+2ynFPd4EwNgFK+uTARXrYMgDCwqzW9/hLEsshFlx0Fe+TelKE5tBTm?=
 =?us-ascii?Q?wwDRVlUHrIIv/+/grmJ1+jij3VuQXHOy3WODvIELGhVDqDkWi0Vrj8C7fYHN?=
 =?us-ascii?Q?J54q6BCOaNxBvmRBWcSJVczogOAEKLWFt/XcQhaypT6B8vrq1fdUSjaMzNRy?=
 =?us-ascii?Q?OJqMfljXCHuINVrZbSyqJadVfwVUP6CUCqG0Ec0O1Y+OBv6fn4C1+8fUUJLT?=
 =?us-ascii?Q?6xXwd7mfM2Y2EPJiX0KmARe+c73K4imL86mxC0Y46W1Pq0Rw1wXN3X7LWy6k?=
 =?us-ascii?Q?UycgX6+gHgo65QIJtZhwpyzLvvWcsGQ4zrkNE4UwxDmiqZgs+jimSogx3K/2?=
 =?us-ascii?Q?+yhB9J+ih3JkYvpmHmwmbF8+vkAnRXNluu911MuZ4oro2Er9QfbwCe5hBPv4?=
 =?us-ascii?Q?nUeqh35cUIPxDNM4wV2WrZ5+hnGKNasuUwPk7rsHNV1Dh64pengtCoGjNdc8?=
 =?us-ascii?Q?XA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3ce2be-3aeb-43f7-684e-08dd01f5edee
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 02:09:52.7804 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zb9H+g5Q1Uq/WiY8na2tav+HBnxzRcxjRWKIgjPAQhv2tBy/9lc6WPUk1Cms1ZJX8Q530kM8YntKGmENs/foN1K4Q42LSRUefF1jvUJl2Wk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1178
X-Mailman-Approved-At: Mon, 11 Nov 2024 03:23:18 +0100
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

Support multiple DTBs for JH7110 based boards, so they can
select the correct DT at runtime.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 arch/riscv/dts/jh7110-common-u-boot.dtsi | 60 ++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/dts/jh7110-common-u-boot.dtsi b/arch/riscv/dts/jh7110-common-u-boot.dtsi
index cfd3c04aec..995a4f667b 100644
--- a/arch/riscv/dts/jh7110-common-u-boot.dtsi
+++ b/arch/riscv/dts/jh7110-common-u-boot.dtsi
@@ -119,20 +119,74 @@
 		fit {
 			images {
 				fdt-1 {
-					description = "NAME";
+					description = "jh7110-starfive-visionfive-2-v1.3b";
 					load = <0x40400000>;
 					compression = "none";
 
-					uboot_fdt_blob: blob-ext {
-						filename = "u-boot.dtb";
+					blob-ext {
+						filename = "dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2-v1.3b.dtb";
+					};
+				};
+
+				fdt-2 {
+					description = "jh7110-starfive-visionfive-2-v1.2a";
+					load = <0x40400000>;
+					compression = "none";
+
+					blob-ext {
+						filename = "dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2-v1.2a.dtb";
+					};
+				};
+
+				fdt-3 {
+					description = "jh7110-milkv-mars";
+					load = <0x40400000>;
+					compression = "none";
+
+					blob-ext {
+						filename = "dts/upstream/src/riscv/starfive/jh7110-milkv-mars.dtb";
+					};
+				};
+
+				fdt-4 {
+					description = "jh7110-pine64-star64";
+					load = <0x40400000>;
+					compression = "none";
+
+					blob-ext {
+						filename = "dts/upstream/src/riscv/starfive/jh7110-pine64-star64.dtb";
 					};
 				};
 			};
 
 			configurations {
 				conf-1 {
+					description = "jh7110-starfive-visionfive-2-v1.3b";
+					firmware = "opensbi";
+					loadables = "uboot";
 					fdt = "fdt-1";
 				};
+
+				conf-2 {
+					description = "jh7110-starfive-visionfive-2-v1.2a";
+					firmware = "opensbi";
+					loadables = "uboot";
+					fdt = "fdt-2";
+				};
+
+				conf-3 {
+					description = "jh7110-milkv-mars";
+					firmware = "opensbi";
+					loadables = "uboot";
+					fdt = "fdt-3";
+				};
+
+				conf-4 {
+					description = "jh7110-pine64-star64";
+					firmware = "opensbi";
+					loadables = "uboot";
+					fdt = "fdt-4";
+				};
 			};
 		};
 	};
-- 
2.43.2

