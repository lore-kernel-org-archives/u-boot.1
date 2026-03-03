Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44537EB364A
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 02:30:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A5A283F4C;
	Tue,  3 Mar 2026 03:30:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="e9BD8R1O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC86F83F53; Tue,  3 Mar 2026 03:30:36 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CA0C83F2D
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 03:30:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bG7BmUIlEoQuxL9ZyeLH+ZP32+V0lUPQYt9hsjy1xr7YhJlFgv/Th37A1Yxfvfec+e8hp7CXW0+CxeaHE4lM37+zvzmrxoZ9UuzveFlVL2JqAUUU8HpfZ8dUI4hvdL8rrPFOZU3X8yqN/b3Aq/DdBUZwo3Bi7WTNdhQJHQ0WUL7V02IZQ3R1l3LVrUDYzgUw/EbSo4Z12yBBbznbtCVK8RQK5SxJ0TuYtnzNgywXXspVSvnFWJMJipUHGUIGYMtnQbZ+FWf7BJdA9VxZTbkOmjt4BA6aWsdgvxnc5SuHveoP+uw5sq6lV7BzPu2vflIIbZmn2VY8TbSpx9CXckFJJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLFLVIZw6ZEnDh7MzPfZoX4PVZCsh1I8y+qWc1XELeM=;
 b=LAwHxSVjkhp1KAilC6VB0qt0LEacA5HymzOT4KLTbWA6XtE735ubiswFvzzEO1pV1J4PKIhDR+Qpk9NB0FgCfJgNIQCzlR1XTXEVDVuP5dQDiVZuRH/za4uVkDdQuT9eeaeSfkWyhfNUghMAduZzLgvp2HUUO3nizCoViOex/v7QsetLY7KU4nwxwiEo8fTBMgcHi0DDjE7IgJ2mAUpHuolpTOoNJeIwS7qAhY3YG7T+XHkaKynzCZo6DFMDFIU1UYl40q7ot60dx562cOLmEZOHaSIg/yPDD9NJIMBHXzzuEYcxMEh9NbECM/gR8/3F/G0MMdICpuL+d1VRtN3mug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLFLVIZw6ZEnDh7MzPfZoX4PVZCsh1I8y+qWc1XELeM=;
 b=e9BD8R1OD0boBixhAp28c1RYA6pM4P8NtJBd7b9olRBEHzFgQNaD6GfqVHpTpRH0kgs3BZ3y23vR3uVBuyPtEWf8cyx+eWisovAr+2KDa0ItzrAiGIsBzJiwoiIrPWVt95lkH6T/saxWmImiDGOIPL9qa02QeSnnfZbosxSulQxFy5jiD8ZLLioYFNNCUxJxo35BH9a4ccaxaL5mI2vNjc9Qg7dyf1ez5psi95hgT+yySpTnuHpxiwVkvT30ZyaXQ0M5FS3mmu5c6BanyXTcXjexT14vUwo2nASJiA0gIeKXRJQ3cqT1T1xfbQr0L1pg6Le3WB8litzLTLqANiHVbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS4PR04MB9409.eurprd04.prod.outlook.com (2603:10a6:20b:4e8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Tue, 3 Mar
 2026 02:30:31 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9654.020; Tue, 3 Mar 2026
 02:30:31 +0000
From: alice.guo@oss.nxp.com
Subject: [PATCH v3 0/4] Enable XSPI1 on i.MX943 EVK board
Date: Tue, 03 Mar 2026 09:10:25 +0800
Message-Id: <20260303-xspi-v1-0-8383ba6fdda8@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAE1pmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYwNj3YrigkzdJFNLc4u0lKTkNAtDJaDSgqLUtMwKsDHRSmXGSrG1tQC
 sf+QfWgAAAA==
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Greg Malysa <malysagreg@gmail.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, Peng Fan <peng.fan@nxp.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>, 
 Boon Khai Ng <boon.khai.ng@altera.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Ian Roberts <ian.roberts@timesys.com>, Ye Li <ye.li@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2P153CA0034.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::17) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS4PR04MB9409:EE_
X-MS-Office365-Filtering-Correlation-Id: fc47d48c-90c7-484b-530e-08de78ccd6de
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|7416014|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: yNCuPzH/c3k/2NLTfZJevF7JJtjfD0KhX6b7ui6pKh61BwKATqSmvmCoJ7NZZWlaHezyD3NqUTN928MIcl4NfwnRaLJJqAZzDyIh44QVBx8Tgoel70MoXVWh5mH5yI1bkgg5fYtLyzpUZErjM7vUgwjXNNdSr4Kw9hgMVP7sYxceu3YVStNcOPZ5cwDmWokiwrDubSq+twx8Zb2kcmmdnf1SyzEhQ3m/kyMiP8J8M9MU3nYiAAeVANcYqeKeS2GO5rj4qLsVr38/0DOXsVOZf2v025pIKHfE91wiGHqRm1RB973cjTJWvVGcoa9Cgc/Qwax6Jy6Dwx9ZXX/K2Q4f/L/WqX/zJBHNYmUTWEyu4SSg7/XpDKKu8vJPZu3mzHcIW8N6FlFNZmWlsGeTtlcugYqNrxYfDCfUaQdZcMzGl3bCnmIcqzFTgxYILHNcCmOKa1iLxWAmxaIdzhD0ImOSIZWG+VQ0AbXFZGjCLBPCj0vNc+5Bcwke1y6NSql65u5QR6rT3xXJ9ZhiuUJDYoGEgp1RxyL7muH5+NlyPEvqPUvOPQo9WLNe0h2DmY3zECmY9zOGqqGCu8VmPIPHGBvMNKtpavP1XZAKbbacQpo9zCso8qcfEaFXd40Ew0X0CFpEw0ah9qxNa8dw0PtDYFXEWTQZc3Z2iqo0gG2oX33tT8FeXFWTytuCIfsp9fqfw1zMtemAMuO7RpBqofhPC0S7paZySpK17y62ym3lvXbuTty4+/80/atHpeeL2xzIejIuWKL53zB8LxD2tK6KOsAoIW9t1I7PqiNQj+1iUj434jkm3tH5JJPQtv0MR/9XqoMX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(7416014)(1800799024)(52116014)(376014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzY2VUgwRDBtV0VEVWdLTVlxZkR2MVo4anovamlwV3h0WWpOSUo0Q0FlUzFk?=
 =?utf-8?B?WTB1dzBqREZ6WWVmaDNvWEQyYTEvUGxjc0FKM0pPMTV6a2FmRDRRT1dFL3pW?=
 =?utf-8?B?Z05nUkVSZ1JTejNJL3hFTG15Y3VWT09EZTNxVTJZam8weEhMbExGUmtub3Az?=
 =?utf-8?B?SWJPZzBhMEQ0dmk5RnNnQTJTcmZmQlFjcHp5VWJhQVVXcGprOXVsakRYbnp6?=
 =?utf-8?B?V1FvN1gwb1ZSMXdoN01VcGZyZ0pkRy9LRXZlKzdsb1RHS0hJOEE5ZmpzbFU1?=
 =?utf-8?B?VWN4T0VVc29RbnIwZTQ1ekw4ZWk1b0RucGdqMUEzdlFvS0pZYTFuRzRvb0hJ?=
 =?utf-8?B?L2t0eFdXYkx4bzB5UG80VmJFNUdlRE5KanpRUDNnRytqYktoUkxTRG9LOXhG?=
 =?utf-8?B?NDErREVuQXNYbDFkNFRFQ1lHYXBWckl6VmtacW5DVDJuOUJISDdXRldGNmll?=
 =?utf-8?B?bHVCVVd1cHZ4Vnc5TitDanAwTVc1dDhEVm1vemV2KzhmWmNFaE1rdGR3ZG5Y?=
 =?utf-8?B?L2YrMDRsZVJUVWFQZVhkaU1HamFXMGF1S1M4UEhaak1MazZvSkR1UGxMS3pX?=
 =?utf-8?B?VUt1ZnBsTkwzRXBkMFBHSTdqN05Vc2tsN0hadFdXMVgzeldZYnFsR3Y5Yk1F?=
 =?utf-8?B?d0VLQ0lTOU1pTDRLUUoyY3RnN3ZFSGJNaXBTYmdrbTluTzVpRk9SSnBJUFdq?=
 =?utf-8?B?SGhBNDZvWk1XU1lnREdSZHBTenN1NGNxS1cyeHJNMFRHY0VhVVh3bHQ5SzJr?=
 =?utf-8?B?WkkvYzZnOG4rN0ttbWVRZFJvUkdXV3hqdWt0TVA1dExGcURackFtNWdIUDVz?=
 =?utf-8?B?KzZxWTVWamdzTkxnMzNWU2UzU202UjlqOVlXaFFCaHpNOEcvanYzZ2s4amYw?=
 =?utf-8?B?bUtIcUZVMkZZMUFldEJ1bUkvUDZyb01UanozVnljczZNSVMzYlI1UmVRMWhr?=
 =?utf-8?B?bHlpRkVGckpVcUFTWnJFbzFNUDl6cDhVZ0l3Yk5oUHcyQ2FDOVNTNlNlMm02?=
 =?utf-8?B?UFVmMjd6MEs5aC9rc0d3SlFYUE1GU0xqZ3N6QXNMSG9lVXRzSDVrcTVvNU1n?=
 =?utf-8?B?c1pMbUFLZGR5ck5XSDVJNG12bzRsVXZXVjhjTkI2ckJoTHRxcWxFNnlnUStB?=
 =?utf-8?B?YnFHdEd0V3pjSXpoUnJXZUNHOHEwWVNRM2tqMHoyZmprZnI2am9iS0V2dnBZ?=
 =?utf-8?B?dWhkNjQwdGZGdDJlNjYzQnBpdFM3bEdwb0dzTFJHeStOMGw1SGQ5NnpQd2c5?=
 =?utf-8?B?TXVSd21NNVBCYWxNUSs3eU5HK2hxVFdCbTNxODcvaXY1bEU4YUxZb2Fzc2Nv?=
 =?utf-8?B?Rk1wTitTcGpxY00zakpJOGRQOFNySFFwQWdSWXNPZjhZN3dudHRmMXpCU2xG?=
 =?utf-8?B?TjF2b1FVeE5uQnNCbzNnZzVVTkkxRjdkTUJFM29oWjdodE8wQmo0MlRNVGYr?=
 =?utf-8?B?SW05cE4vWEgyT294MnU2ZXR4M3JPSTdXem91OWhLbUJwdHFETHZFa3J2cmRp?=
 =?utf-8?B?RTMyUU92bWhkS09GVlFIdXE3RVVZKzNLZDJ5UWVkKzVZbUJ1ejVSQTcxK0RJ?=
 =?utf-8?B?ekozYjVxb2k0T1JaVFI1c3NiT0R0OGpPRUgrcmt2U2liTlhySjdhMll4SktU?=
 =?utf-8?B?NGYzYlcrQ0xyYjVHd1cyejgvckppR243emtIVXAzdnQ1eHh4R2VmMnhnbnZ4?=
 =?utf-8?B?S0IyaWlmZVJ5Q0hMWGUyZklUUXJ2Zyt4VGkwbUlzcUI3WGhsS2wxaEtKT1NX?=
 =?utf-8?B?dVJSdFZiRTZUaFZjUFh1WXJsWHk0b1FqOERjYVErSDIzcWJFNWordXpTQXgy?=
 =?utf-8?B?R1NqTkY4elQxVHJYcnQyVTR5QjRqR1BFMmRkL3FXbnB4NVBCU0piNi9ZUWZM?=
 =?utf-8?B?MnltSmdPSGNib2lCdUJHNmxtUUpvQVI4SzMzMmp1WTJ0SGlSTk5sbUs5YXcz?=
 =?utf-8?B?UDZQeW5SRFVIdjFjU0pJTi9kQVFsMFBlQTVGdkhPbWxBYW9xVEN6alFOdFVi?=
 =?utf-8?B?ZG9BMUJ4UVRGNldYQ3kvYllFTnZjZHV1Z3JRWm5VWGtoSHpBdFdndGlwTEEv?=
 =?utf-8?B?STh0OUtSUU5SRTNhNUhucWxVMEltcURqamloOEpzSWdzS2Y0M3NTb2g4WSs4?=
 =?utf-8?B?dld5OEptV1ZBUVVpUk9wNmNUdUZYTWh5bkZyTVoxMW5FV3BVNlVBL0FuQU90?=
 =?utf-8?B?RUZNbUkxd1VQQjhwRWhQbmREalVwNVkzNlVaY3FFZEtoUE1oQjg0bXc4RXdw?=
 =?utf-8?B?N2VmTElvdXNEZHQveWpENjRvV0dZRGFRQ0JaMWNvWVkxWXdBNkhXUG91Ny93?=
 =?utf-8?B?a2o0eDlRUFc4TSsxTmpUSkdQbjVjNjdhNmsxUUU2eGNKTit4L3hxUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc47d48c-90c7-484b-530e-08de78ccd6de
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 02:30:30.8654 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rWnV+tBF/cEf3dzkzdnXDlj66jE+bKBd76+LV6aeSrCqeKjJoXdIYvxpNOSC+lpwkAARTVZ4Rd0XwuS+Y5o2+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9409
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

Changes for v1:
- Add support for XSPI1 on i.MX943 EVK board
 
Changes for v2:
- Remove the big-endian related code
- Change compatible to "nxp,imx94-xspi"

Changes for v3:
- Add "depends on ARCH_IMX9" to the NXP_XSPI Kconfig entry to prevent
  this driver from being enabled on unsupported platforms like sandbox.

CI: https://github.com/u-boot/u-boot/pull/880/checks
link to the upstream submission:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/spi/spi-cadence-xspi.c?h=next-20251219

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (2):
      spi: nxp_xspi: Add new driver for NXP XSPI controller
      imx943_evk: Enable XSPI1

Ye Li (2):
      misc: ele_api: Add support for XSPI SET GMID command
      imx94_evk: Get ownership of XSPI control registers protected by GMID in SPL

 MAINTAINERS                             |   1 +
 arch/arm/dts/imx943-evk-u-boot.dtsi     |  34 ++
 arch/arm/dts/imx943-u-boot.dtsi         |  16 +
 arch/arm/include/asm/mach-imx/ele_api.h |   2 +
 board/nxp/imx94_evk/spl.c               |  12 +
 configs/imx943_evk_defconfig            |   9 +
 drivers/misc/imx_ele/ele_api.c          |  28 +
 drivers/spi/Kconfig                     |   8 +
 drivers/spi/Makefile                    |   1 +
 drivers/spi/nxp_xspi.c                  | 881 ++++++++++++++++++++++++++++++++
 drivers/spi/nxp_xspi.h                  | 705 +++++++++++++++++++++++++
 11 files changed, 1697 insertions(+)
---
base-commit: 8d24789abed0822fbe41a2f9d72cf19650159dc6
change-id: 20260303-xspi-b5978fdbcf81

Best regards,
-- 
Alice Guo <alice.guo@nxp.com>

