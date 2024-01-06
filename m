Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AAB1C46CD2
	for <u-boot@archiver.kernel.org>; Sat,  6 Jan 2024 12:39:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9FEC86D82;
	Sat,  6 Jan 2024 13:39:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="qv83FK7l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65D1887687; Sat,  6 Jan 2024 13:39:18 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B452786784
 for <u-boot@lists.denx.de>; Sat,  6 Jan 2024 13:39:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYyVqv1LuyP1HOJSDtmjUZp+BW3athPJ6PVtv11Tm4hH851GEv9TDVovUVuvAzHtYt8CsiWVj2dqT1NSA8iH6qiw2KOIiEqlQEXRcpyQEDvN7Jf4L30ZbxRnbmDgMo72edCEce188PQNghJ9bc/pxZD91iFGnLjhIV8d8iborCmmhREc4zHM7UEcqUHr3oxTGCnkY77MMTwzNecCchisu1AeApo9de9xsfQ7vmjSSrb9h/0gZCnZXkrjN24pqXTB3yJoy2S5AUkVXbXqVxjVHZ2GHvflVDS/DXqUi5LfWDDqGa/gGf/uMqNajEtp+eitJPY8p3sDB1vG0sB901X6Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHtB4Q/G4HtBicrh9G5y57FxfEYibQxilFAu4DkbVts=;
 b=fuBFE0jqxZwxrQvF9e2wohQZambA8cPk8tOR8guLUSWLddCbjpFeMUsfCCv6YuCgppkJc1iMzR+VPv9v6TPPK2GeVbteYI+pJ3sKfJxy4fcRmTGlSRc6jUPyY9Hd8vJmpmxYzFc2r5Nfu3ott2Z5//ySzb1+pA/S7zYg1aHZTwGHW+ASrAN2Mu6Dj8Dn7U1g4HNAzrLjzANgtYs7UVwF2Eg6TZBKwXtJx3XPjNfdh2wb8KymYLsplRQVRlmkDbclnEtYT9Yv1Xno+7BugYtbah9yZWcUO8ggXRA/JWgO2Tf/mZWp112zlSXRlWvgqGSjsQmAtuouVKdxYtPurNt+ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHtB4Q/G4HtBicrh9G5y57FxfEYibQxilFAu4DkbVts=;
 b=qv83FK7lFa9pR1hj9SGuJJwjSmJqtKSWHeqNV6R20NGjdr8K2GVhbbEdQkPaBdikchXQ4DCSD+2uaz4Evg73ZRA6uKg8gbk1SKXYHa+nBBjGjPrg2a3ywK3R6ZF/iAfy+Z71af/7MP6+isWxZxywEeH/zO9vaMEUIFya2WpSmuUGja5ORo7K8KcKMx2waLTZ7a27rcAGXP+wVJ9a9hizcAfWlfgq+SFT2BJgGGcletm3CnLx/HMxCWWjhfs77B2BjuS1WAnJfrGZIs6DmcNwRvCwiwgdh0+E5Wg+ncgylN2lVsPquw93jD9ETMHFTyJU/9uQeA2/eh/DXUlorJiJBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7114.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:318::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.17; Sat, 6 Jan
 2024 12:39:10 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7159.018; Sat, 6 Jan 2024
 12:39:09 +0000
Message-ID: <94c3b346-f131-4648-bc1f-f8ce46449f07@siemens.com>
Date: Sat, 6 Jan 2024 13:39:07 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] arm: dts: iot2050: Fix by syncing from Linux
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: UBoot Mailing List <u-boot@lists.denx.de>,
 Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Simon Glass
 <sjg@chromium.org>, Bryan Brattlof <bb@ti.com>,
 "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0111.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: 15c0f752-b565-499f-3cac-08dc0eb47ad6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4zQpIQDZGix8Z7wb/qIN8IfwcgWAV7z8uIagJl5GVqwRnKH4p9yekZcguFZBURb/E1jd+t6GSJnT5BV2sYephCzWcofwR+pxozChkXZ8LA6L+DSI4FLQhTWGf1yHTMeOfBeg0cbDnMMoHvvi7zpqs04A91D3Y34wxD1bvn0uyFQLMxusXgHwMusJvEDs8MoEy7zPIZYrCt5q5y5c34Nq34gCFQjRkCNZ7wJ0BpkQc3F+f4yg5tFKwTEEEUQ3oIK500DoGEP6VPxRGouveAi4uxatJuRWWFL/Df78A+Tm1X/NDksrWxvDTgQ4tR02PglCVtWh9r+vH08q1N9fGd81eFYK9Is2m57YmhdHqTe34ZdYTYK7sBG6HIsztyntyxK8+IBgL0lwK5eI0mbs5aZ5a/BsgtAAw00xI6AOKvc0sNloL0uOBxeCu6RbMaCtCkFEvsozDP7WrVN1e8TyqCahYIy8FJ7rnpUGez18iIvTLwmR5JDA+w4KyHZ5qQpVFRAW9B0tZtZyueupgD1SAxTNiyEAGVnE65JcpP2jDFUSyW2wglAqRPGUjuFOrKDlK+Oo6YZ50fsYsHqGbqA0K9gubW/+T0424sGCc9F5zPsO3LO+y9irA9QmvKjDdnMsb2SzcIU0eQlHHEYHjYHzhfKHWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(376002)(366004)(136003)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(26005)(2616005)(478600001)(6486002)(6506007)(6512007)(83380400001)(107886003)(30864003)(5660300002)(2906002)(41300700001)(7416002)(66476007)(66556008)(54906003)(316002)(8676002)(8936002)(44832011)(4326008)(66946007)(6916009)(38100700002)(36756003)(86362001)(31696002)(82960400001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2dGRG5uU0krQlM1bmMxUkU2OTJ5bVFRSjBScUNDYW1va2tZSFo5VWlTLzRW?=
 =?utf-8?B?TEJHVEprTVU3UWtFeExLTHhlUTJqK0JFM1BOb0lhaml3a1dyRWxpSnVEd3Fq?=
 =?utf-8?B?RGRYNk5TSmlMOWtDa0lnV2RVaUEyUUhaNU5MTWxtajJ4Y25SckZKRDM4eE92?=
 =?utf-8?B?L3dLajc3M1A5UnNYR1l0REJKV1hLSXNsU09HU1BydFZIL3dnZGZQOW1CeHEy?=
 =?utf-8?B?cUNHMXRaM1FVMGVDUlVWWkpEVUFrWFV1aFBhMmIyZmUyUURJRmY2MkZYOEEx?=
 =?utf-8?B?NUFOdUtsWGNvb2VOT2dQNkMyTnJacFp1MVFVd3lZTWdsNEVPU05KdGhrZGRj?=
 =?utf-8?B?Y3dpTm9HdWJEMHlSYzgrU3cwTlhEdFlpZW5FNWVXVHU1TXBDOWZKWmlmazQ0?=
 =?utf-8?B?a2dxNGxTbUxCc2h2QWRBK1dwMXBQdGZoYldMcVBXVUl1K05MS1FkZm8xUzBJ?=
 =?utf-8?B?cFVnbTFDRHVIYTVkRDF4UW5UWHpRWWJteEk5cEVPdTFHbnVNdFYyOXRNcW1k?=
 =?utf-8?B?a1cremlZWVovUEViUmowVlphTHlWemJqNzZkMVpvMmZtVnpCV3h5a1k5M1Rx?=
 =?utf-8?B?aEtoTlhsZXNlOUhnWVpvckMwblVCV3h2ODZmNnZyS2pvOFJ3RU44ZXZpcnpT?=
 =?utf-8?B?RVQycWwzY2szTUNDWWJCaVBGSWZPTG5zTE5VRHJPM2pBbGNweUM0ZHRJWlk3?=
 =?utf-8?B?UVU2aFlGaElRck56K1NxbWlCd3RYSkViWllxMy9IbDFmSEJPWFBsbU1uTGRr?=
 =?utf-8?B?R3IvTVJhU0Y2S0pyMUE1dUlrK1Y3YTRDQWRYanpsSDRZbUpydHZCMnlOWnUr?=
 =?utf-8?B?OEF2QUo2SlFSdWVmOEthS3J0eUpXUWpMeGI0cjc3dVEvT1JHZU9ua2ZBUnF2?=
 =?utf-8?B?RDRmalNvcXBFMjNoUXNzbDNvTEFtYXpNUzc2c0pOWVVnWFUzRjZFaHhaRlE3?=
 =?utf-8?B?bmhxNW01dTBNS3pITHZTWDBvZnZSVVQyNjdZWC9JcFJjdEFUdWdPMlluengr?=
 =?utf-8?B?R2c4MHlyYmpKRVR3LzdsNllSYmNVMDgzWWljQ0xHanVyL0UyOENGcyt6cUxB?=
 =?utf-8?B?ckpicm5zbnhrRVY0bmJNUTNQMkhnYTJoenFlMHNSRmZKSjdPdktUSlVETDg5?=
 =?utf-8?B?c2JvemJHa0ZEOHl3QzZKSFd3RFNwV1hwRUxIeGIxOGh5VHQwWGNMZGpzREZr?=
 =?utf-8?B?VDFUdXByN1I3SW81VkFSYUhyV1dqd3IwaWx4NUMzMGtxZHNVdFJJdUlvSkdS?=
 =?utf-8?B?amVLU0FZeWMrMWp5UFpMUktEenhzSjlrS2xMd0QwVVhxaDRUNjlPdXVuemtq?=
 =?utf-8?B?OGVMQlR1dGt1OVE1a3dCbkpkS3BQeCtlSWttTnBmenBXMlkxSVpsVmlnMnpI?=
 =?utf-8?B?bSt1dFc1VGkyaFlERHZaMko2ZHFmUVhyZkVJckRKZnhRMi9qNzZGNjJ4bVE2?=
 =?utf-8?B?ejJmNk44T3ltYVN6bmF6UVBqUVBQYUUvUnF5WklhdzUrVUx2aFhyTXkzS2dv?=
 =?utf-8?B?VENIL3dQWm5TcXFoNlVOSDZsdmdGU0pOQm0yYTYwS0hJcjVyMGtrNVBwbEJ0?=
 =?utf-8?B?bThVakdIaU9rM2dhQ0hzZ09LQnFZZzd1MGJNdWJRR3kzdjVMZzJjbDEwbUxy?=
 =?utf-8?B?SkNybG9obENNN3FWbkJSZ0poRjZhaWNGZGpvSUdlWDRodFhOczFhWkxjK0xV?=
 =?utf-8?B?bUdIWWFmUG1VVkw5eXJVbmxqakllRG92STNVNnRzd3pmZVZZQU5pQmhOWmNR?=
 =?utf-8?B?YWFTNXpoZXNLMDJSaGx6M2lqSUhHZHg1N3FGM2ZFVVRObGc2S2hmeVI5WjBI?=
 =?utf-8?B?R2tad0tNOWg1RVVIOUhUTmU2Y2ZIRGRLQ05iN3R3ekl0SVFLK1pmZ2piYXZs?=
 =?utf-8?B?SmtjTVF3ZGlmVUhlTWFKdThVN2FMV2FqZ3owT1NzOTh4YjJPMXVKU0JuY3NF?=
 =?utf-8?B?b0xsZWIvTzNNZWszbWN5YlpqSkgvYWZxMWFqdXFEUGh5NGw3cnV1QU53MzVx?=
 =?utf-8?B?ZkpCcDB0YXpqVmxmLytYeldrUytlVG01aUcvd21jcjE3Rm1NUERMc2s4ZFhr?=
 =?utf-8?B?OTFIS1BkRzlTYURSbkIwRnA0M0c3NUUwNVRnLzkzV1EyZzFzSGJiTDBaNGhL?=
 =?utf-8?B?WlU3WFVoYkFhbjJYYVhUS3pmQW5JS01wNFBYcHZNbWFlbUtxa2w5SjhXd2t5?=
 =?utf-8?B?MUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c0f752-b565-499f-3cac-08dc0eb47ad6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2024 12:39:09.8655 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lEITuw6v79bqhpBd4wMCzmUmWfCWjGj4PJXxOGfJT1EjqOhtSuzbNUtHAbaQ6CpaaquAPVmCuLi/MdkBLKuR+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7114
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

From: Jan Kiszka <jan.kiszka@siemens.com>

This restores support for IOT2050 by widely synchronizing its DT files
with the Linux kernel. We additionally need to add the alias restoration
that is still waiting for its upstream merge and the not-yet-upstreamed
bits needed for watchdog reboot detection.

Fixes: 4dbdc84754ea ("arm: dts: k3-am654: pull in dtb update from Linux")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Bryan, please don't do partial DT syncing in future anymore!

 arch/arm/dts/k3-am65-iot2050-common-pg2.dtsi  |   2 +-
 arch/arm/dts/k3-am65-iot2050-common.dtsi      | 218 +++++++++---------
 .../dts/k3-am6528-iot2050-basic-common.dtsi   |   3 +-
 .../k3-am6548-iot2050-advanced-common.dtsi    |   6 +-
 .../arm/dts/k3-am6548-iot2050-advanced-m2.dts |  28 ++-
 5 files changed, 123 insertions(+), 134 deletions(-)

diff --git a/arch/arm/dts/k3-am65-iot2050-common-pg2.dtsi b/arch/arm/dts/k3-am65-iot2050-common-pg2.dtsi
index e73458ca690..e9419c4fe60 100644
--- a/arch/arm/dts/k3-am65-iot2050-common-pg2.dtsi
+++ b/arch/arm/dts/k3-am65-iot2050-common-pg2.dtsi
@@ -10,7 +10,7 @@
  */
 
 &main_pmx0 {
-	cp2102n_reset_pin_default: cp2102n-reset-pin-default {
+	cp2102n_reset_pin_default: cp2102n-reset-default-pins {
 		pinctrl-single,pins = <
 			/* (AF12) GPIO1_24, used as cp2102 reset */
 			AM65X_IOPAD(0x01e0, PIN_OUTPUT, 7)
diff --git a/arch/arm/dts/k3-am65-iot2050-common.dtsi b/arch/arm/dts/k3-am65-iot2050-common.dtsi
index b6135b849f1..fa7178144b8 100644
--- a/arch/arm/dts/k3-am65-iot2050-common.dtsi
+++ b/arch/arm/dts/k3-am65-iot2050-common.dtsi
@@ -14,6 +14,16 @@
 
 / {
 	aliases {
+		serial0 = &wkup_uart0;
+		serial1 = &mcu_uart0;
+		serial2 = &main_uart0;
+		serial3 = &main_uart1;
+		i2c0 = &wkup_i2c0;
+		i2c1 = &mcu_i2c0;
+		i2c2 = &main_i2c0;
+		i2c3 = &main_i2c1;
+		i2c4 = &main_i2c2;
+		i2c5 = &main_i2c3;
 		spi0 = &mcu_spi0;
 		mmc0 = &sdhci1;
 		mmc1 = &sdhci0;
@@ -21,7 +31,6 @@
 
 	chosen {
 		stdout-path = "serial3:115200n8";
-		bootargs = "earlycon=ns16550a,mmio32,0x02810000";
 	};
 
 	reserved-memory {
@@ -111,7 +120,7 @@
 };
 
 &wkup_pmx0 {
-	wkup_i2c0_pins_default: wkup-i2c0-pins-default {
+	wkup_i2c0_pins_default: wkup-i2c0-default-pins {
 		pinctrl-single,pins = <
 			/* (AC7) WKUP_I2C0_SCL */
 			AM65X_WKUP_IOPAD(0x00e0, PIN_INPUT,  0)
@@ -120,7 +129,7 @@
 		>;
 	};
 
-	mcu_i2c0_pins_default: mcu-i2c0-pins-default {
+	mcu_i2c0_pins_default: mcu-i2c0-default-pins {
 		pinctrl-single,pins = <
 			/* (AD8) MCU_I2C0_SCL */
 			AM65X_WKUP_IOPAD(0x00e8, PIN_INPUT,  0)
@@ -129,21 +138,21 @@
 		>;
 	};
 
-	arduino_i2c_aio_switch_pins_default: arduino-i2c-aio-switch-pins-default {
+	arduino_i2c_aio_switch_pins_default: arduino-i2c-aio-switch-default-pins {
 		pinctrl-single,pins = <
 			/* (R2) WKUP_GPIO0_21 */
 			AM65X_WKUP_IOPAD(0x0024, PIN_OUTPUT, 7)
 		>;
 	};
 
-	push_button_pins_default: push-button-pins-default {
+	push_button_pins_default: push-button-default-pins {
 		pinctrl-single,pins = <
 			/* (T1) MCU_OSPI1_CLK.WKUP_GPIO0_25 */
 			AM65X_WKUP_IOPAD(0x0034, PIN_INPUT,  7)
 		>;
 	};
 
-	arduino_uart_pins_default: arduino-uart-pins-default {
+	arduino_uart_pins_default: arduino-uart-default-pins {
 		pinctrl-single,pins = <
 			/* (P4) MCU_UART0_RXD */
 			AM65X_WKUP_IOPAD(0x0044, PIN_INPUT,  4)
@@ -152,7 +161,7 @@
 		>;
 	};
 
-	arduino_io_d2_to_d3_pins_default: arduino-io-d2-to-d3-pins-default {
+	arduino_io_d2_to_d3_pins_default: arduino-io-d2-to-d3-default-pins {
 		pinctrl-single,pins = <
 			/* (P1) WKUP_GPIO0_31 */
 			AM65X_WKUP_IOPAD(0x004C, PIN_OUTPUT, 7)
@@ -161,7 +170,7 @@
 		>;
 	};
 
-	arduino_io_oe_pins_default: arduino-io-oe-pins-default {
+	arduino_io_oe_pins_default: arduino-io-oe-default-pins {
 		pinctrl-single,pins = <
 			/* (N4) WKUP_GPIO0_34 */
 			AM65X_WKUP_IOPAD(0x0058, PIN_OUTPUT, 7)
@@ -176,7 +185,7 @@
 		>;
 	};
 
-	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-pins-default {
+	mcu_fss0_ospi0_pins_default: mcu-fss0-ospi0-default-pins {
 		pinctrl-single,pins = <
 			/* (V1) MCU_OSPI0_CLK */
 			AM65X_WKUP_IOPAD(0x0000, PIN_OUTPUT, 0)
@@ -191,7 +200,7 @@
 		>;
 	};
 
-	db9_com_mode_pins_default: db9-com-mode-pins-default {
+	db9_com_mode_pins_default: db9-com-mode-default-pins {
 		pinctrl-single,pins = <
 			/* (AD3) WKUP_GPIO0_5, used as uart0 mode 0 */
 			AM65X_WKUP_IOPAD(0x00c4, PIN_OUTPUT, 7)
@@ -204,7 +213,7 @@
 		>;
 	};
 
-	leds_pins_default: leds-pins-default {
+	leds_pins_default: leds-default-pins {
 		pinctrl-single,pins = <
 			/* (T2) WKUP_GPIO0_17, used as user led1 red */
 			AM65X_WKUP_IOPAD(0x0014, PIN_OUTPUT, 7)
@@ -217,7 +226,7 @@
 		>;
 	};
 
-	mcu_spi0_pins_default: mcu-spi0-pins-default {
+	mcu_spi0_pins_default: mcu-spi0-default-pins {
 		pinctrl-single,pins = <
 			/* (Y1) MCU_SPI0_CLK */
 			AM65X_WKUP_IOPAD(0x0090, PIN_INPUT,  0)
@@ -230,7 +239,7 @@
 		>;
 	};
 
-	minipcie_pins_default: minipcie-pins-default {
+	minipcie_pins_default: minipcie-default-pins {
 		pinctrl-single,pins = <
 			/* (P2) MCU_OSPI1_DQS.WKUP_GPIO0_27 */
 			AM65X_WKUP_IOPAD(0x003C, PIN_OUTPUT, 7)
@@ -239,7 +248,7 @@
 };
 
 &main_pmx0 {
-	main_uart1_pins_default: main-uart1-pins-default {
+	main_uart1_pins_default: main-uart1-default-pins {
 		pinctrl-single,pins = <
 			AM65X_IOPAD(0x0174, PIN_INPUT,  6)  /* (AE23) UART1_RXD */
 			AM65X_IOPAD(0x014c, PIN_OUTPUT, 6)  /* (AD23) UART1_TXD */
@@ -248,14 +257,14 @@
 		>;
 	};
 
-	main_i2c3_pins_default: main-i2c3-pins-default {
+	main_i2c3_pins_default: main-i2c3-default-pins {
 		pinctrl-single,pins = <
 			AM65X_IOPAD(0x01c0, PIN_INPUT,  2)  /* (AF13) I2C3_SCL */
 			AM65X_IOPAD(0x01d4, PIN_INPUT,  2)  /* (AG12) I2C3_SDA */
 		>;
 	};
 
-	main_mmc1_pins_default: main-mmc1-pins-default {
+	main_mmc1_pins_default: main-mmc1-default-pins {
 		pinctrl-single,pins = <
 			AM65X_IOPAD(0x02d4, PIN_INPUT_PULLDOWN, 0)  /* (C27) MMC1_CLK */
 			AM65X_IOPAD(0x02d8, PIN_INPUT_PULLUP,   0)  /* (C28) MMC1_CMD */
@@ -268,19 +277,19 @@
 		>;
 	};
 
-	usb0_pins_default: usb0-pins-default {
+	usb0_pins_default: usb0-default-pins {
 		pinctrl-single,pins = <
 			AM65X_IOPAD(0x02bc, PIN_OUTPUT, 0)  /* (AD9) USB0_DRVVBUS */
 		>;
 	};
 
-	usb1_pins_default: usb1-pins-default {
+	usb1_pins_default: usb1-default-pins {
 		pinctrl-single,pins = <
 			AM65X_IOPAD(0x02c0, PIN_OUTPUT, 0)  /* (AC8) USB1_DRVVBUS */
 		>;
 	};
 
-	arduino_io_d4_to_d9_pins_default: arduino-io-d4-to-d9-pins-default {
+	arduino_io_d4_to_d9_pins_default: arduino-io-d4-to-d9-default-pins {
 		pinctrl-single,pins = <
 			AM65X_IOPAD(0x0084, PIN_OUTPUT, 7)  /* (AG18) GPIO0_33 */
 			AM65X_IOPAD(0x008C, PIN_OUTPUT, 7)  /* (AF17) GPIO0_35 */
@@ -291,7 +300,7 @@
 		>;
 	};
 
-	dss_vout1_pins_default: dss-vout1-pins-default {
+	dss_vout1_pins_default: dss-vout1-default-pins {
 		pinctrl-single,pins = <
 			AM65X_IOPAD(0x0000, PIN_OUTPUT, 1)  /* VOUT1_DATA0 */
 			AM65X_IOPAD(0x0004, PIN_OUTPUT, 1)  /* VOUT1_DATA1 */
@@ -324,13 +333,13 @@
 		>;
 	};
 
-	dp_pins_default: dp-pins-default {
+	dp_pins_default: dp-default-pins {
 		pinctrl-single,pins = <
 			AM65X_IOPAD(0x0078, PIN_OUTPUT, 7)  /* (AF18) DP rst_n */
 		>;
 	};
 
-	main_i2c2_pins_default: main-i2c2-pins-default {
+	main_i2c2_pins_default: main-i2c2-default-pins {
 		pinctrl-single,pins = <
 			AM65X_IOPAD(0x0074, PIN_INPUT,  5)  /* (T27) I2C2_SCL */
 			AM65X_IOPAD(0x0070, PIN_INPUT,  5)  /* (R25) I2C2_SDA */
@@ -339,21 +348,21 @@
 };
 
 &main_pmx1 {
-	main_i2c0_pins_default: main-i2c0-pins-default {
+	main_i2c0_pins_default: main-i2c0-default-pins {
 		pinctrl-single,pins = <
 			AM65X_IOPAD(0x0000, PIN_INPUT,  0)  /* (D20) I2C0_SCL */
 			AM65X_IOPAD(0x0004, PIN_INPUT,  0)  /* (C21) I2C0_SDA */
 		>;
 	};
 
-	main_i2c1_pins_default: main-i2c1-pins-default {
+	main_i2c1_pins_default: main-i2c1-default-pins {
 		pinctrl-single,pins = <
 			AM65X_IOPAD(0x0008, PIN_INPUT,  0)  /* (B21) I2C1_SCL */
 			AM65X_IOPAD(0x000c, PIN_INPUT,  0)  /* (E21) I2C1_SDA */
 		>;
 	};
 
-	ecap0_pins_default: ecap0-pins-default {
+	ecap0_pins_default: ecap0-default-pins {
 		pinctrl-single,pins = <
 			AM65X_IOPAD(0x0010, PIN_INPUT,  0)  /* (D21) ECAP0_IN_APWM_OUT */
 		>;
@@ -366,15 +375,13 @@
 };
 
 &main_uart1 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart1_pins_default>;
 };
 
-&main_uart2 {
-	status = "disabled";
-};
-
 &mcu_uart0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&arduino_uart_pins_default>;
 };
@@ -393,13 +400,12 @@
 
 &wkup_gpio0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <
-		&arduino_io_d2_to_d3_pins_default
-		&arduino_i2c_aio_switch_pins_default
-		&arduino_io_oe_pins_default
-		&push_button_pins_default
-		&db9_com_mode_pins_default
-	>;
+	pinctrl-0 =
+		<&arduino_io_d2_to_d3_pins_default>,
+		<&arduino_i2c_aio_switch_pins_default>,
+		<&arduino_io_oe_pins_default>,
+		<&push_button_pins_default>,
+		<&db9_com_mode_pins_default>;
 	gpio-line-names =
 		/* 0..9 */
 		"wkup_gpio0-base", "", "", "", "UART0-mode1", "UART0-mode0",
@@ -419,19 +425,21 @@
 };
 
 &wkup_i2c0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&wkup_i2c0_pins_default>;
 	clock-frequency = <400000>;
 };
 
 &mcu_i2c0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_i2c0_pins_default>;
 	clock-frequency = <400000>;
 
 	psu: regulator@60 {
 		compatible = "ti,tps62363";
-		reg =  <0x60>;
+		reg = <0x60>;
 		regulator-name = "tps62363-vout";
 		regulator-min-microvolt = <500000>;
 		regulator-max-microvolt = <1500000>;
@@ -484,11 +492,12 @@
 };
 
 &main_i2c0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c0_pins_default>;
 	clock-frequency = <400000>;
 
-	rtc: rtc8564@51 {
+	rtc: rtc@51 {
 		compatible = "nxp,pcf8563";
 		reg = <0x51>;
 	};
@@ -501,18 +510,21 @@
 };
 
 &main_i2c1 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c1_pins_default>;
 	clock-frequency = <400000>;
 };
 
 &main_i2c2 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c2_pins_default>;
 	clock-frequency = <400000>;
 };
 
 &main_i2c3 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c3_pins_default>;
 	clock-frequency = <400000>;
@@ -552,6 +564,7 @@
 };
 
 &ecap0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&ecap0_pins_default>;
 };
@@ -576,25 +589,24 @@
 };
 
 &mcu_spi0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_spi0_pins_default>;
 
 	#address-cells = <1>;
-	#size-cells= <0>;
+	#size-cells = <0>;
 	ti,pindir-d0-out-d1-in;
 };
 
-&tscadc0 {
-	status = "disabled";
-};
-
 &tscadc1 {
+	status = "okay";
 	adc {
 		ti,adc-channels = <0 1 2 3 4 5>;
 	};
 };
 
 &ospi0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
 
@@ -609,8 +621,52 @@
 		cdns,tchsh-ns = <60>;
 		cdns,tslch-ns = <60>;
 		cdns,read-delay = <2>;
-		#address-cells = <1>;
-		#size-cells = <1>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			seboot@0 {
+				label = "seboot";
+				reg = <0x0 0x180000>; /* 1.5M */
+			};
+
+			tispl@180000 {
+				label = "tispl";
+				reg = <0x180000 0x200000>; /* 2M */
+			};
+
+			u-boot@380000 {
+				label = "u-boot";
+				reg = <0x380000 0x300000>; /* 3M */
+			};
+
+			env@680000 {
+				label = "env";
+				reg = <0x680000 0x20000>; /* 128K */
+			};
+
+			env-backup@6a0000 {
+				label = "env.backup";
+				reg = <0x6a0000 0x20000>; /* 128K */
+			};
+
+			otpcmd@6c0000 {
+				label = "otpcmd";
+				reg = <0x6c0000 0x10000>; /* 64K */
+			};
+
+			unused@6d0000 {
+				label = "unused";
+				reg = <0x6d0000 0x7b0000>; /* 7872K */
+			};
+
+			seboot-backup@e80000 {
+				label = "seboot.backup";
+				reg = <0xe80000 0x180000>; /* 1.5M */
+			};
+		};
 	};
 };
 
@@ -634,15 +690,8 @@
 	};
 };
 
-&pcie0_rc {
-	status = "disabled";
-};
-
-&pcie0_ep {
-	status = "disabled";
-};
-
 &pcie1_rc {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&minipcie_pins_default>;
 
@@ -652,11 +701,8 @@
 	reset-gpios = <&wkup_gpio0 27 GPIO_ACTIVE_HIGH>;
 };
 
-&pcie1_ep {
-	status = "disabled";
-};
-
 &mailbox0_cluster0 {
+	status = "okay";
 	interrupts = <436>;
 
 	mbox_mcu_r5fss0_core0: mbox-mcu-r5fss0-core0 {
@@ -666,6 +712,7 @@
 };
 
 &mailbox0_cluster1 {
+	status = "okay";
 	interrupts = <432>;
 
 	mbox_mcu_r5fss0_core1: mbox-mcu-r5fss0-core1 {
@@ -674,71 +721,18 @@
 	};
 };
 
-&mailbox0_cluster2 {
-	status = "disabled";
-};
-
-&mailbox0_cluster3 {
-	status = "disabled";
-};
-
-&mailbox0_cluster4 {
-	status = "disabled";
-};
-
-&mailbox0_cluster5 {
-	status = "disabled";
-};
-
-&mailbox0_cluster6 {
-	status = "disabled";
-};
-
-&mailbox0_cluster7 {
-	status = "disabled";
-};
-
-&mailbox0_cluster8 {
-	status = "disabled";
-};
-
-&mailbox0_cluster9 {
-	status = "disabled";
-};
-
-&mailbox0_cluster10 {
-	status = "disabled";
-};
-
-&mailbox0_cluster11 {
-	status = "disabled";
-};
-
 &mcu_r5fss0_core0 {
 	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
 			<&mcu_r5fss0_core0_memory_region>;
-	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core0>;
+	mboxes = <&mailbox0_cluster0>, <&mbox_mcu_r5fss0_core0>;
 };
 
 &mcu_r5fss0_core1 {
 	memory-region = <&mcu_r5fss0_core1_dma_memory_region>,
 			<&mcu_r5fss0_core1_memory_region>;
-	mboxes = <&mailbox0_cluster1 &mbox_mcu_r5fss0_core1>;
+	mboxes = <&mailbox0_cluster1>, <&mbox_mcu_r5fss0_core1>;
 };
 
 &mcu_rti1 {
 	memory-region = <&wdt_reset_memory_region>;
-
-};
-
-&icssg0_mdio {
-	status = "disabled";
-};
-
-&icssg1_mdio {
-	status = "disabled";
-};
-
-&icssg2_mdio {
-	status = "disabled";
 };
diff --git a/arch/arm/dts/k3-am6528-iot2050-basic-common.dtsi b/arch/arm/dts/k3-am6528-iot2050-basic-common.dtsi
index 4a9bf7d7c07..5ab434c02ab 100644
--- a/arch/arm/dts/k3-am6528-iot2050-basic-common.dtsi
+++ b/arch/arm/dts/k3-am6528-iot2050-basic-common.dtsi
@@ -35,7 +35,7 @@
 };
 
 &main_pmx0 {
-	main_uart0_pins_default: main-uart0-pins-default {
+	main_uart0_pins_default: main-uart0-default-pins {
 		pinctrl-single,pins = <
 			AM65X_IOPAD(0x01e4, PIN_INPUT,  0)  /* (AF11) UART0_RXD */
 			AM65X_IOPAD(0x01e8, PIN_OUTPUT, 0)  /* (AE11) UART0_TXD */
@@ -50,6 +50,7 @@
 };
 
 &main_uart0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart0_pins_default>;
 };
diff --git a/arch/arm/dts/k3-am6548-iot2050-advanced-common.dtsi b/arch/arm/dts/k3-am6548-iot2050-advanced-common.dtsi
index d25e8b26187..be55494b1f3 100644
--- a/arch/arm/dts/k3-am6548-iot2050-advanced-common.dtsi
+++ b/arch/arm/dts/k3-am6548-iot2050-advanced-common.dtsi
@@ -22,7 +22,7 @@
 };
 
 &main_pmx0 {
-	main_mmc0_pins_default: main-mmc0-pins-default {
+	main_mmc0_pins_default: main-mmc0-default-pins {
 		pinctrl-single,pins = <
 			AM65X_IOPAD(0x01a8, PIN_INPUT_PULLDOWN, 0)  /* (B25) MMC0_CLK */
 			AM65X_IOPAD(0x01ac, PIN_INPUT_PULLUP,   0)  /* (B27) MMC0_CMD */
@@ -50,7 +50,3 @@
 	ti,driver-strength-ohm = <50>;
 	disable-wp;
 };
-
-&main_uart0 {
-	status = "disabled";
-};
diff --git a/arch/arm/dts/k3-am6548-iot2050-advanced-m2.dts b/arch/arm/dts/k3-am6548-iot2050-advanced-m2.dts
index 9400e35882a..774eb14ac90 100644
--- a/arch/arm/dts/k3-am6548-iot2050-advanced-m2.dts
+++ b/arch/arm/dts/k3-am6548-iot2050-advanced-m2.dts
@@ -27,26 +27,26 @@
 };
 
 &main_pmx0 {
-	main_m2_enable_pins_default: main-m2-enable-pins-default {
+	main_m2_enable_pins_default: main-m2-enable-default-pins {
 		pinctrl-single,pins = <
 			AM65X_IOPAD(0x01c4, PIN_INPUT_PULLUP, 7)  /* (AH13) GPIO1_17 */
 		>;
 	};
 
-	main_bkey_pcie_reset: main-bkey-pcie-reset {
+	main_bkey_pcie_reset: main-bkey-pcie-reset-default-pins {
 		pinctrl-single,pins = <
 			AM65X_IOPAD(0x01bc, PIN_OUTPUT_PULLUP, 7)  /* (AG13) GPIO1_15 */
 		>;
 	};
 
-	main_pmx0_m2_config_pins_default: main-pmx0-m2-config-pins-default {
+	main_pmx0_m2_config_pins_default: main-pmx0-m2-config-default-pins {
 		pinctrl-single,pins = <
 			AM65X_IOPAD(0x01c8, PIN_INPUT_PULLUP, 7)  /* (AE13) GPIO1_18 */
 			AM65X_IOPAD(0x01cc, PIN_INPUT_PULLUP, 7)  /* (AD13) GPIO1_19 */
 		>;
 	};
 
-	main_m2_pcie_mux_control: main-m2-pcie-mux-control {
+	main_m2_pcie_mux_control: main-m2-pcie-mux-control-default-pins {
 		pinctrl-single,pins = <
 			AM65X_IOPAD(0x0148, PIN_INPUT_PULLUP, 7)  /* (AG22) GPIO0_82 */
 			AM65X_IOPAD(0x0160, PIN_INPUT_PULLUP, 7)  /* (AE20) GPIO0_88 */
@@ -56,7 +56,7 @@
 };
 
 &main_pmx1 {
-	main_pmx1_m2_config_pins_default: main-pmx1-m2-config-pins-default {
+	main_pmx1_m2_config_pins_default: main-pmx1-m2-config-default-pins {
 		pinctrl-single,pins = <
 			AM65X_IOPAD(0x0018, PIN_INPUT_PULLUP, 7)  /* (B22) GPIO1_88 */
 			AM65X_IOPAD(0x001c, PIN_INPUT_PULLUP, 7)  /* (C23) GPIO1_89 */
@@ -66,20 +66,18 @@
 
 &main_gpio0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <
-		&main_m2_pcie_mux_control
-		&arduino_io_d4_to_d9_pins_default
-	>;
+	pinctrl-0 =
+		<&main_m2_pcie_mux_control>,
+		<&arduino_io_d4_to_d9_pins_default>;
 };
 
 &main_gpio1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <
-		&main_m2_enable_pins_default
-		&main_pmx0_m2_config_pins_default
-		&main_pmx1_m2_config_pins_default
-		&cp2102n_reset_pin_default
-	>;
+	pinctrl-0 =
+		<&main_m2_enable_pins_default>,
+		<&main_pmx0_m2_config_pins_default>,
+		<&main_pmx1_m2_config_pins_default>,
+		<&cp2102n_reset_pin_default>;
 };
 
 /*
-- 
2.35.3
