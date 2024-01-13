Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF8D6C4706C
	for <u-boot@archiver.kernel.org>; Sat, 13 Jan 2024 16:37:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1FD687967;
	Sat, 13 Jan 2024 17:37:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="hbr0VGxv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0DDA87883; Sat, 13 Jan 2024 17:37:17 +0100 (CET)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0e::60b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24CA78793C
 for <u-boot@lists.denx.de>; Sat, 13 Jan 2024 17:37:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josua@solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROGOPC2EHWXnBJ5soPkFhULfKjCSq5Fk+Z9AX2GwXNYQJpkSKM3AKt3boot+sQ+SB5F7+udFyBlDRVrF/E5Oob676ttRQ0J1vZaXrRzt39G/jnnG30UpsJstmpwydc21ajKoDybLkQ8HZpuEVAF2ALqDg5Ws3b3vmV+QB5UJL5J+Vkjg74TzJymy/mmKO2d/wMYzi+Yc0RpTqqNNgXgrKl7EUyLJmbZqAKtQT5u1qW6ekUJ/XrTzllWKUJmM30f0YHysFeMf0GcQn6ls4iC8oFQqyzHwzQ87abiidyZ9RpybDr6n3mEhpMGl8TH1xoJvRhyk2g5w/tFb/jKyx4HY8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DEa3ELJjHk2h63etfGlbFgYbQIIldpN/gwesw5DzgEc=;
 b=VKL6w/q2sczgl8T89qb5o0e1C83nxRUnwdiygkJ6zaJQ+E55QxqeI/JkxDBfFmk15Bg+fDKTLMh+ymW3AEpglnCvs2k7WxO2z2holYmV4I6pGQDFRpo8y330u4jLf1+zMZ4QhSEW91yGjHdrTtUWuQ0+bvdFB5q0t7TdfkXX3XA12Q3PE/z7q5prcTTL4KqNEt8pgaotl3YSYSgUelgcTXbhTxttroSRarGvT3gedfgq5rlP+izHh6+kXn181FADIUzNTEMuyHvXaK5vsAs3iSXMD2UN8v4q8IYHRIqGFoGEB3oRlxSjmfdgnieIs154ZUIaIHIjdAlH+sth2HyQ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEa3ELJjHk2h63etfGlbFgYbQIIldpN/gwesw5DzgEc=;
 b=hbr0VGxvLYAUcVqYOCMyFmDQFpUfsw5wigL5DOVnE2u9cSPJBY8ZTRJQYkxLdF7E/Bx4FIkMbnY9mm5KU8XE99+QPTjkUKnZswExM90+G0Lq6/yLzlpsVBEj6HvrFk2SFnjzlLUH34njiugrWZpivKKgvsXE20cP4P2i/7+eT4s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by PA4PR04MB7567.eurprd04.prod.outlook.com (2603:10a6:102:e5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Sat, 13 Jan
 2024 16:37:14 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d%7]) with mapi id 15.20.7181.020; Sat, 13 Jan 2024
 16:37:14 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sat, 13 Jan 2024 17:36:56 +0100
Subject: [PATCH 2/3] arm: mvebu: helios4_defconfig: enable setexpr command
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240113-helios4-spi-v1-2-2a5663a10e6a@solid-run.com>
References: <20240113-helios4-spi-v1-0-2a5663a10e6a@solid-run.com>
In-Reply-To: <20240113-helios4-spi-v1-0-2a5663a10e6a@solid-run.com>
To: Dennis Gilmore <dgilmore@redhat.com>
Cc: u-boot@lists.denx.de, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR3P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::10) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|PA4PR04MB7567:EE_
X-MS-Office365-Filtering-Correlation-Id: 713a2d8b-8fe2-4a43-91a1-08dc1455e592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PtYaUpv7yAJak1E5Vg/MTvye6/IltTi0pTYGTvZ+vba5c1lD6apA9ghVAdrG2XOPo5e6GtTB5Q1jWM+srRV6KSF3f4spK92HFO1yWLZQGvxOGAMGBoXkG4Mv0Dpk8zvuwued+EQmSVM7bo4eWZuJoDC7DSj+dfIyEHI4BM0M5rBc9s2W0AVO2WQqDJHJ5hXDM36xt1h34ECrUwvcBBZ6RELmnWUyah13j6uLCvJDNqtUAxZQTQU+EaabUund25sc5dGaf5++VbTNd86QCDZBPV+JJ3qEtVSYcMxQmAQj6XmBb3NUAB72lP1B28r4vbJqrJw8NUXRpFmQBdP+qrZ5RcSjGZV+YFGQ0/WYwdO/hhEMFHDBqNODDE2dAXhjx30k7etNBPjUP/HUlwGODpGTc00wo/GpTqVXBtOxxHnvO0OXSKoP/tvnclJ05me0madSaPHWv+tXrmgyUN+Ev65z+PlCtA3diLdxacZX0b+jpiMY/AyeRCor2F/2RoRx49Gru9DDi6NuKItFXX1ObUz68Aw4XplT6JfqFWTGR9zFgPFhlW6KTVsLQN6bcJlohSLECgTn17WbBBej5dicv60E21DAxHhrYY2SnxY+9gf25YTAwjK8cJOdp1QqHjPaq0wQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8963.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39830400003)(366004)(376002)(396003)(136003)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(4744005)(2906002)(5660300002)(52116002)(4326008)(8676002)(8936002)(66476007)(6916009)(316002)(6512007)(41300700001)(38100700002)(6506007)(6486002)(66556008)(66946007)(6666004)(2616005)(36756003)(86362001)(83380400001)(107886003)(26005)(478600001)(38350700005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NU1rdXJXQnIwVHJKcTh1RW5xUm00ZG1BRUhPZWo3cmZwVG45NzBjbTVyaVlr?=
 =?utf-8?B?YURXTEVRTWN6eXpSR0lEN1MvLzF3STBVQThBckdld2t3a29rQ1JTc3h2K2o1?=
 =?utf-8?B?VXJqRjdxNkNadkZSVk1IY3RnRWpkenc5Z1RzKzROazJIQTQ2V2JGaUhZS09R?=
 =?utf-8?B?OFNnMXg3STBiMjRjWnZBVmhkUjduQ1BudmR0aEFScjdNaU9CcHpITmxoblhx?=
 =?utf-8?B?blNKZitsRXJjM2Vxa3ppZ0thSlpqZUw4NndPcmYyRE42R2tlY0JzRzZ5bzZT?=
 =?utf-8?B?UGJDTVVOU2UwbXdrNVVUMFBMMy9EaTdtYXRpYnZzd2QxOXJ6c0laRzFuL2Rl?=
 =?utf-8?B?bE9MZk5POXhIcnVQRitsaks2cUNqQllxRSt3YVUrOVBIb080WmE2N3dyc2RK?=
 =?utf-8?B?cTFWZFJ6cUJwNnA1S01xYXhiYmM0aWQxYkpnd1Fqb1BtaWhhYkVidm5zK2ZI?=
 =?utf-8?B?RlpqaFJzU0hhMUVtcHZ3R1o5Sm43QjhFTUw5Ty9RRGVyUVZPbFN4TktlTG5L?=
 =?utf-8?B?WGM1WmdJSWVXN0MzclhuUGUwWGdPMGphZ0NiR25SY2lFQndmWlBCMzdPZG5V?=
 =?utf-8?B?SVVscFoxYlZIQXRvWkd4R1gxRVRsZWFSL1orSHZ6Vmx0T0l6SWFZMU5zQ0Fz?=
 =?utf-8?B?VDF0d3E2UHNxb2VqRnozS0hOb1Y3RjFqM0F2YlBPYm4rTXpveTJvRVZnNktL?=
 =?utf-8?B?ZTNVZ0tlWGo2VzYyb005cGlqNU9aZ043NCt6RytlL3FEME9JQTlYcStqeU1t?=
 =?utf-8?B?RVd5U2hlM2g3TVcxYWRsdlNlOXpRWkN3VG4xV0YrY0lwOXU3QTNHbGJSaXJK?=
 =?utf-8?B?K2h1cE9wUzlTZ2pvWGJXZTY5V21vbkNYMnhZaWhvS0I3cWZXbkhqcEZLYUgz?=
 =?utf-8?B?emVYdTUyS3BKOGxEK2p1SGhZQjl4Z1ZZb0VlM2dGQXBMSVRLRkNaTWVrZTgz?=
 =?utf-8?B?R3B2TEJNNTdycE9EQXdZaGVzWmVQZHl2U0dNZVVPME5PVHBLUFBMNUJiSjBB?=
 =?utf-8?B?eDFBNDdVdEI1TVNQWVd3ei9jUkl3cGNCVjNCYXZhY0UvcDMwdDFzMXp6RXhv?=
 =?utf-8?B?Z0dWbXoycUJhWkoxMzFxcmo1dTZlaE9BUDgrdlB5N3VSNWFLNXVoKzFjVmNu?=
 =?utf-8?B?S2toREE1RVB4NGxpNG5mZmJxVXRHZTR0WEVpcURjdDlOVzRBaTE2THNaTUZm?=
 =?utf-8?B?bU4xV1E3REVmaFc0UjRmcmZTcFpJMmJYSDdXR1NDWURJQWkvemU3Tzl0TVRv?=
 =?utf-8?B?TEp2dXpaaldLc3gvSTlkd1JhSElva2VPVFBQZ0JWbFYvRkF0bk5NVmFqaXAr?=
 =?utf-8?B?SjJBdFg0SzNVQnl3UDZ1SmRhMDNmb2VYcWhsYzRvY1paV0FPZ0V0Qmg5S2lS?=
 =?utf-8?B?R3h3SllKUkFST1JQdCtZWitSMXlDSmN0ZXBLRFRWdGhnalMzbHBoQkpTZ25U?=
 =?utf-8?B?M1p6bU5Db3o4SGxjSnZlZEN0WDV3WjgrM0E4VjZiRm9nSmlDL1RzdWdiVWZv?=
 =?utf-8?B?ZjBhYjVFWGQrY1UwMEJPeG9PMWFoUmROOWwzMWhLWDVxWkVrZ2F3RWloQVBr?=
 =?utf-8?B?Qk11RXhROXo5alk3YTlMYTNMMDE2SXFnRDR0bk9wUjI2SHVuVjlUeWJDaE42?=
 =?utf-8?B?aU93VUFOblBsVUtFK003SmV6VTNGTnhPa3ZzcHpBL0NBeGpPTkc5UTBDdjNo?=
 =?utf-8?B?TERpWnB6S3d2Y2NIbVZ4QjBkUERPUDk5UFpBeFBibktBSVY4TVFyQjhTWjlJ?=
 =?utf-8?B?eGVPM21EMnBGV2tzdlF6NHFEOThqeFpPZEdyVFJKaDlSL2VLcVdPRm9mbDVF?=
 =?utf-8?B?WHo2VGpBR3JNelc3cTVoaVhpSkl1WkovLzl4SVZSMERIK09WbDAxN1JabFNS?=
 =?utf-8?B?cElpQmQxR1dMOGM0bzNpOWJwZ0VzMmtLSEhiN2k1cXpEOXJCZUcwSnR4Tmd4?=
 =?utf-8?B?TEtzazQ3S293NXFjQ1djSzBFNlBscWJocDc2cm9uazFhSHl4a0pVWXZKaWNM?=
 =?utf-8?B?bkQ3UjlXVDVPZnlNTTVUUmoyMVd1Wk9iS2M5RG1nVG52VmtHY0RqMXlaNVVm?=
 =?utf-8?B?VnB6TTJBRVR2RHVEZXJVY3RUUW1TbSt3eWlTSkttalpXV1pXSFV5UWtoL1Zp?=
 =?utf-8?Q?mPwgioq32F2oKJjn5Gu6fGzi6?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 713a2d8b-8fe2-4a43-91a1-08dc1455e592
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2024 16:37:13.7031 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IEpTEHDUolLwiswxsbUJ0jZfKxsu1q1s8nomSM0hsWfoGV/aWvc2H+Kjtfg8Eq2sVFTCFWUm9DKKR4AjOGiWHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7567
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

Update the helios4 defconfig to enable the 'setexpr' command, which is a
default and useful for various complex boot-scripts.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 configs/helios4_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/helios4_defconfig b/configs/helios4_defconfig
index 1d8d374fe2..5f568d1695 100644
--- a/configs/helios4_defconfig
+++ b/configs/helios4_defconfig
@@ -44,7 +44,6 @@ CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
-# CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TFTPPUT=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIME=y

-- 
2.35.3

