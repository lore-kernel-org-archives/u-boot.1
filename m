Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B653E9A742
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 09:15:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FC8383A91;
	Tue, 24 Mar 2026 10:15:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lVEJcs/f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCF9380087; Tue, 24 Mar 2026 10:15:07 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E86383981
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 10:15:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/r+cIFIhu1HQ62l9ekY1EDBFIaRuTFTVUiQY24QzjBDvoMpUyKQov6zP+f2mA3nDpDQ8ewS2bkPN05XWYgjo8Am9PnsH9iIJ468PajCB7FE1JXz9z53BvNhjF92ZSXUyz6s9j6uVEaQP9DinbVPmlAjt1hBFQTW1Pe5DnaHAlozHnun+rMSMqteps+65IkMl3hN1Lu+z6A59fsjYRr9lWVGII7uHmSrBhKGDMm4SvjF3hZXrQqRcp/sOeIzu8gCAaGugQD/8t4YRFCb98YiPfyIqklnzhjbtJ1O7ooWj1LU4ygLHddOXWFowo+h/ZT7Ub84mNHpiS/4Pibf8vxHKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=igIV8fNlTMgr7eIvAA+3JJkAHS+TmUpLr/6MCAF9woM=;
 b=ju6zbRk21s0QtqA02EHqFvN+3BIAgYTt2mupemv4dQUMIyEM60typ6Ao53PsqYVCyds7jzckrDxwnqWs/dau4Ahu28q14HfLuXzyO51CRJV8Q1HubiykuKltcYpJG4ES+5Hlt9ppHjW3Vt1kzbwirZgTOPu0hAG6Wpgo/1pKO1GiUc5lngxpJQRbwe1f1EFdbdmkcAqEYJ5sxdQPAdfs2l7iauAFxkl60iVU1SQP4zNZV7VG6wSLDSVCPVxh5dJFcAywMgm/4RWH2wJ4ZPcQDTUj43PpDjYbSiDOJySF6TyzdA8HL+PYJlPxBr82rItmh22kJCb737XdusaRKN3YWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igIV8fNlTMgr7eIvAA+3JJkAHS+TmUpLr/6MCAF9woM=;
 b=lVEJcs/fyWBgDqdCZOSl8XA9KxnL87vxgt8akIDsDRgDbkDhKcG5ZFXXLOzse8FOrb/Q5Y4QV6A/JIpwLjU4h8S8ux3e6VQYFqMYY3JfSbEzdAk6p469CF4zEoRh3Cs8c1ATuvhDfXjDZaJxiKiKJ4lLkVPOt+PQeu+kL4VvolyPUSlZy0kQxQj5gihjoL8g1F0/QzsBtCEQampprG75ONhHxdaznfn3mjIzj+ShUC3+L18ACwLN88wPrOIsrDFZsS5mdwrmTzrgYW87cESGs6jhEEX9vblVrJ2tITjUOaewnv4AXRId0heugbSaHs1tn0HDdn0qch6ohUqBwhK00w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB11042.eurprd04.prod.outlook.com (2603:10a6:150:21f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 09:14:34 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 09:14:42 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 24 Mar 2026 18:30:33 +0800
Subject: [PATCH 3/4] imx8mp: libra-fpsc: Convert to DM_PMIC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-power-legacy-v1-3-ed432367817c@nxp.com>
References: <20260324-power-legacy-v1-0-ed432367817c@nxp.com>
In-Reply-To: <20260324-power-legacy-v1-0-ed432367817c@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, upstream@lists.phytec.de, 
 u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: Teresa Remmet <t.remmet@phytec.de>, Benjamin Hahn <B.Hahn@phytec.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Leonard Anderweit <l.anderweit@phytec.de>, Yannic Moog <y.moog@phytec.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>, 
 Matteo Lisi <matteo.lisi@engicam.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SG2PR06CA0250.apcprd06.prod.outlook.com
 (2603:1096:4:ac::34) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB11042:EE_
X-MS-Office365-Filtering-Correlation-Id: 18960b2a-df3c-48ae-32b0-08de8985c82f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|52116014|19092799006|38350700014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: h60wkZYkYl3eIiV3r2o1O5ENg/S1oR38akllQcTOs1B75sarwNzVRjdcgmSJdTLpN5+cxVBDrHZjHXWQA6iuLPxI+t0vLwgslcg9m+CsTm98MyaKlLg/vd78XyNGwSqLZBtHw67EMwXVtddYApQpw15rdntw4dpJUStiHSXvG8pq78sybPA1ZusTLuOSMu++u63hvQCiA8HQuF9bgS3FrUfVCrAUNhtrjhrIhrGzhNzEs/UjfN0QN4X+ZD/tu1aJGYB/r5GfzexA1fdD1uTjJ1+j3eyzPsU0TYE10bUkLJ7cC08sPSANjk7hc0rtvpbk9JvnshQMG80s6MoqVlW5r+X+NqoVr3jjH5ods3N7p0Jj9WrRAsxAsDNXWE2UR3jbUMGnQP2bg6VOq9IzE7+nzuiytfDxFVWNruj+M9WIo2cwIBnVvDL193Be/SJHdUjBDGvaszBE2kJGRzRNspwIo/wTccuutdGEyuyWYO7RPeyyPQvsCDTWOSvKd+6tYAwpYf98cve3SoICM/bk/2R3Ir4aj/oRPICc7e2YnFx9m6TLo+PksuK0Q/ur0qdn9PjYcPMtf9tf5fW7GCR7YNVOt0jZmdYOmf3fYTnDEEHkgl5Mj4BgJVbIKEDvwPH3lZOxySu4BAtJZ/FHQ3aL6lBObWacDJ6mtb0vJ7OFXoYeby7ItHYPlwtNNgEC/vUjy2bQIO21pNMEsONyGZjKC8iikrZy8ObPvW3J7M+uaqpkLQivMFqXdJtiuQluFzWErgRo5S8vUYsSPKfxl+4QwYTeXAs4fXGFMVIyYzX1mdvaZTo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(19092799006)(38350700014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEFJNjB5Ym1PKzYxRDVxNUFjWUI5V1I5VXU5cUpFd2JJZVJmZ2MrOVo1K2F2?=
 =?utf-8?B?QjNMSkhVSE92UUpjSTQ1dDRYa3M4clZUT2xzNnFKK3prSzZ4d0J1d0RuS2FV?=
 =?utf-8?B?T2t0ZHJUb2I4SEJxNUtxRHBzQWEzRTJVNVBvUHMyVktIYXFCNjRxb2w5YmNq?=
 =?utf-8?B?UldROGFyN3lrVUljYlFMYmJBT3g2VGtCU3RzeWRCaWd2NWpoejdXZjBHQWwx?=
 =?utf-8?B?ekxiekQvSnRGOTNYcHJYM2xXNjdaVDB5V1JpTFlOL2hRTUdwOEF1Rm9LRWYr?=
 =?utf-8?B?eGpxRGxDTmJ3Y0NDVE9JUC9JSTQwT2IwNnIydWZlcWtvNlZZQlJScE94bHBG?=
 =?utf-8?B?RXVwM096TlZBVXY2QmxOUTNWRndMeEZMNFFsY0EvZzFweWZweDUzSXpqUXVm?=
 =?utf-8?B?TXhhdjFQUm9vVEQzVCtTNnU2OGtLZXVLa3UwaDBidmUyMW1PUWcrYmJxVVhv?=
 =?utf-8?B?OFJoOWcwRFJQVmNqUEpNM0IreHF5dGljNDZ1NC8vVnlUS3RHR1l2MEpNeHBG?=
 =?utf-8?B?dmZyY0xFN0dlYWNpVHRqeWQrandpZ3EzUkhXRHh2TVc1cjhHUTZxMjRCa01o?=
 =?utf-8?B?ZUlTQ2M1Y2FIcjlnRTFWb20rZzhINERRWitnYWdYa2RRRkhpSUlQZDhVdDNa?=
 =?utf-8?B?eUg3Z3pJUDhqcTVOUzZJdGhnMHNEUFBhcnU0SW9Cak51VWNyemNUUk5vU0Nt?=
 =?utf-8?B?Mmo5QVA3bE1lYXF1cU50aUllMVZkc1czWEFoMXAwMmttdHI4c1FJVEtTTlNY?=
 =?utf-8?B?TDNMZ2ZIdExGVXpwNm1ITnJtaHlDamQ4dGpkMkVycHhwRWlVS0F5cURLeFlt?=
 =?utf-8?B?VkRKajJQcEsxY0xoZTF5czI4WFBpY1ZyeHJReFBjV0VCYnVRTmJwNWdybnFR?=
 =?utf-8?B?UG5XeC9weC9hM25wQy9CVCtPWnJyZ0puanBhL0VCSHhOMFJYbkJ4Z0krdGFK?=
 =?utf-8?B?K2Z2SFVjRFIzenVkMGxtTjh6YU5CUklYZ2lKdGc0U2NvZDdCanF0N3ZGUWRW?=
 =?utf-8?B?YmIvZ0sxSVREemFqQ0tDR0RxUDJUb1dHN0RITDR6dHJHOTJ5YWQ5RXdUb2Vj?=
 =?utf-8?B?ajVtb08xaW1HN1VmTjFCZjN3aGtyTjZlWlFiSnk4c2RQVkk2cHp1bUdGaGQy?=
 =?utf-8?B?ejRadGpxRStwNTQwSkZnQzRWblo1WkdLdFkySE54VnpLc1dFcks2THhQcHQr?=
 =?utf-8?B?clFPWEh6WTlnZlV1MFZCbW9ESjdVb0RaWmtETjZLOUZrcktXdmIwWmc2d1k5?=
 =?utf-8?B?YXRFZlRrWGRDSnkyK1FyVHQ5dU52RzVaSjlkU0p0VXRNQ0ZyclNnelNOeG5U?=
 =?utf-8?B?WmcweE04QmtoR0tNU3ZQcFFtQXNKdU5mZWVHWGl0WVE4VWtyNkNJeStMVHNO?=
 =?utf-8?B?UFNMQ0hnU0ZRRnMyZnNuS21ITzg5V1lsM0sxdGZ0ZDhpdDRJM2J4R0kyb1Ir?=
 =?utf-8?B?T2RCRTdJL2FiSzdwUGEwT3laRlZaVHI2N25aR0NpckM4RkVlM2JQVmR4dXVB?=
 =?utf-8?B?eGhUUGtaR0d5aGgxbDlDQjcxZnNRcUxHNHZXVVJBdlZ4YUdnTkpkU2tkNTVy?=
 =?utf-8?B?YXYxMk8wUmdWSlhjbDg2Sm1RalphcElydC9IK3hMbU5LZnpmWWp0TWNTREdY?=
 =?utf-8?B?ZTRac0V3WWFycjlRSmNTbjJnNXpSSnM2b1d5ZW1lNnh2K3l0SWNQM3c3WEZ5?=
 =?utf-8?B?K1RsV1lmMkszb3F4OUlWdTdEUHk3UmVmZzQ0ZWxpV1orejBuUlNFcEp1U2pu?=
 =?utf-8?B?UkkyTnYvRE5mV0Z2WkxKTTRPMWowZGVVUXpvWXdYZXRCRXZrUzVXM2VZUy8x?=
 =?utf-8?B?T25yUlE4ZG1PZU8raUNYcDR1eHM5TUl4WWNBMGJMZkV5bUg3eFJzMU1BVnNK?=
 =?utf-8?B?Uk03Z2xpZGM5T2dORzZyWDd4bU4xeUN5Wkh1RkF1bmE0YjdBSXV1UWtLcHJ3?=
 =?utf-8?B?WDgxWCtZUUFDWXZoRHhBQmNueHEwNFV5U1c3QTc2T21kR1NBRmpjUFhXdXdB?=
 =?utf-8?B?RUp5bmNod0JiL1FMZ0RreWhpSXlteGRnUnRRYWloYWRkNlV5UDJnVnRnRUJz?=
 =?utf-8?B?MnczclhGcU1JckVMMUhHakdoNzVaWTVuazNNeWFubWkxaWZkRTlUZStoNXZO?=
 =?utf-8?B?elZLc0twYVNqbHFsSFhYcDlGSnNYbnJvbncxVlgyQTZYMXZqa2F2RlBmRGR6?=
 =?utf-8?B?TTFObjkxVEJrM3VwcUwrdTZyRWFvQjBTNkJ5ZG1DYVdJOW5xcWFrcFhHUTJC?=
 =?utf-8?B?OC8wb01Ea1JDNTlQa0l2R0g4Q2ExcXdsTGJrbUNlb013Uy8wRUhIc21xcHc2?=
 =?utf-8?B?Q2tzcmVGanpST21mTTlTbzlyOVU2dXFvNko2SUtNQmM1NXowRXVNQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18960b2a-df3c-48ae-32b0-08de8985c82f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 09:14:42.1023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 868eFwwvr3rVW7aoCs86H3H7I0Wot7C54Z8XEbooQODBn4W9LRzBw9gJy9DM6fz0vj6uuSlzuQhqGzrpb2QF5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11042
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

From: Peng Fan <peng.fan@nxp.com>

Convert the board to use DM_PMIC instead of the legacy SPL I2C/PMIC
handling.

Changes include:
- Enable DM_PMIC, DM_PMIC_PCA9450, and SPL_DM_PMIC_PCA9450 in defconfig.
- Drop legacy SPL I2C and PMIC options.
- Remove manual I2C1 pad setup and legacy power_pca9450_init() usage.
- Use DM-based pmic_get() with the DT node "pmic@25".
- Update PMIC register programming to use struct udevice API.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/imx8mp-libra-rdk-fpsc-u-boot.dtsi | 16 +++++++--
 board/phytec/imx8mp-libra-fpsc/spl.c           | 46 ++++++++------------------
 configs/imx8mp-libra-fpsc_defconfig            | 10 +++---
 3 files changed, 32 insertions(+), 40 deletions(-)

diff --git a/arch/arm/dts/imx8mp-libra-rdk-fpsc-u-boot.dtsi b/arch/arm/dts/imx8mp-libra-rdk-fpsc-u-boot.dtsi
index 1320f1540ed..661e5d0ad5f 100644
--- a/arch/arm/dts/imx8mp-libra-rdk-fpsc-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-libra-rdk-fpsc-u-boot.dtsi
@@ -33,6 +33,18 @@
 	};
 };
 
+&pinctrl_i2c1 {
+	bootph-all;
+};
+
+&pinctrl_pmic {
+	bootph-all;
+};
+
+&{/soc@0/bus@30800000/i2c@30a20000/pmic@25/regulators} {
+	bootph-all;
+};
+
 &reg_usdhc2_vmmc {
 	bootph-pre-ram;
 };
@@ -78,11 +90,11 @@
 };
 
 &i2c1 {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 &pmic {
-	bootph-pre-ram;
+	bootph-all;
 };
 
 /* USB1 Type-C */
diff --git a/board/phytec/imx8mp-libra-fpsc/spl.c b/board/phytec/imx8mp-libra-fpsc/spl.c
index 08111641aa6..aa22ad0030c 100644
--- a/board/phytec/imx8mp-libra-fpsc/spl.c
+++ b/board/phytec/imx8mp-libra-fpsc/spl.c
@@ -9,9 +9,6 @@
 #include <asm/arch/imx8mp_pins.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/mach-imx/boot_mode.h>
-#include <asm/mach-imx/gpio.h>
-#include <asm/mach-imx/mxc_i2c.h>
-#include <asm/mach-imx/iomux-v3.h>
 #include <hang.h>
 #include <init.h>
 #include <log.h>
@@ -46,45 +43,32 @@ void spl_dram_init(void)
 	ddr_init(&dram_timing);
 }
 
-#define I2C_PAD_CTRL (PAD_CTL_DSE6 | PAD_CTL_HYS | PAD_CTL_PUE | PAD_CTL_PE)
-#define PC MUX_PAD_CTRL(I2C_PAD_CTRL)
-struct i2c_pads_info i2c_pad_info1 = {
-	.scl = {
-		.i2c_mode = MX8MP_PAD_I2C1_SCL__I2C1_SCL | PC,
-		.gpio_mode = MX8MP_PAD_I2C1_SCL__GPIO5_IO14 | PC,
-		.gp = IMX_GPIO_NR(5, 14),
-	},
-	.sda = {
-		.i2c_mode = MX8MP_PAD_I2C1_SDA__I2C1_SDA | PC,
-		.gpio_mode = MX8MP_PAD_I2C1_SDA__GPIO5_IO15 | PC,
-		.gp = IMX_GPIO_NR(5, 15),
-	},
-};
-
 int power_init_board(void)
 {
-	struct pmic *p;
+	struct udevice *dev;
 	int ret;
 
-	ret = power_pca9450_init(0, 0x25);
-	if (ret)
-		printf("power init failed");
-	p = pmic_get("PCA9450");
-	pmic_probe(p);
+	ret = pmic_get("pmic@25", &dev);
+	if (ret == -ENODEV) {
+		puts("No pmic@25\n");
+		return 0;
+	}
+	if (ret < 0)
+		return ret;
 
 	/* BUCKxOUT_DVS0/1 control BUCK123 output */
-	pmic_reg_write(p, PCA9450_BUCK123_DVS, 0x29);
+	pmic_reg_write(dev, PCA9450_BUCK123_DVS, 0x29);
 
 	/* Increase VDD_SOC and VDD_ARM to OD voltage 0.95V */
-	pmic_reg_write(p, PCA9450_BUCK1OUT_DVS0, 0x1C);
-	pmic_reg_write(p, PCA9450_BUCK2OUT_DVS0, 0x1C);
+	pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS0, 0x1C);
+	pmic_reg_write(dev, PCA9450_BUCK2OUT_DVS0, 0x1C);
 
 	/* Set BUCK1 DVS1 to suspend controlled through PMIC_STBY_REQ */
-	pmic_reg_write(p, PCA9450_BUCK1OUT_DVS1, 0x14);
-	pmic_reg_write(p, PCA9450_BUCK1CTRL, 0x59);
+	pmic_reg_write(dev, PCA9450_BUCK1OUT_DVS1, 0x14);
+	pmic_reg_write(dev, PCA9450_BUCK1CTRL, 0x59);
 
 	/* Set WDOG_B_CFG to cold reset */
-	pmic_reg_write(p, PCA9450_RESET_CTRL, 0xA1);
+	pmic_reg_write(dev, PCA9450_RESET_CTRL, 0xA1);
 
 	return 0;
 }
@@ -120,8 +104,6 @@ void board_init_f(ulong dummy)
 
 	enable_tzc380();
 
-	setup_i2c(0, CONFIG_SYS_I2C_SPEED, 0x7f, &i2c_pad_info1);
-
 	power_init_board();
 
 	/* DDR initialization */
diff --git a/configs/imx8mp-libra-fpsc_defconfig b/configs/imx8mp-libra-fpsc_defconfig
index a23e604425d..4a8938d3e43 100644
--- a/configs/imx8mp-libra-fpsc_defconfig
+++ b/configs/imx8mp-libra-fpsc_defconfig
@@ -9,7 +9,6 @@ CONFIG_SF_DEFAULT_SPEED=80000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x3C0000
 CONFIG_ENV_SECT_SIZE=0x10000
-CONFIG_SYS_I2C_MXC_I2C1=y
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="freescale/imx8mp-libra-rdk-fpsc"
 CONFIG_IMX8M_OPTEE_LOAD_ADDR=0x7e000000
@@ -105,8 +104,6 @@ CONFIG_FASTBOOT_MMC_USER_SUPPORT=y
 CONFIG_FASTBOOT_MMC_USER_NAME="mmc2"
 CONFIG_MXC_GPIO=y
 CONFIG_DM_I2C=y
-# CONFIG_SPL_DM_I2C is not set
-CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_I2C_EEPROM=y
 CONFIG_SYS_I2C_EEPROM_ADDR=0x51
 CONFIG_SUPPORT_EMMC_BOOT=y
@@ -138,15 +135,16 @@ CONFIG_PHY_IMX8MQ_USB=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
-CONFIG_SPL_POWER_LEGACY=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_IMX8M_POWER_DOMAIN=y
 CONFIG_IMX8MP_HSIOMIX_BLKCTRL=y
-CONFIG_POWER_PCA9450=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_PCA9450=y
+CONFIG_SPL_DM_PMIC_PCA9450=y
 CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_PCA9450=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
-CONFIG_SPL_POWER_I2C=y
 CONFIG_DM_RNG=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y

-- 
2.51.0

