Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD10C43458
	for <u-boot@archiver.kernel.org>; Sun, 12 Jul 2026 13:09:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D39684A48;
	Sun, 12 Jul 2026 15:09:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="R1vrF05q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFDBB84940; Sun, 12 Jul 2026 15:09:14 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C68F84A48
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 15:09:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HRghXrlDkSbFessQp1DJp8QiLyQksjJ8TFEDFHeAthrvMXf1K5EEO1hUul/9dj6WaM4DfDa3tlx0y/hUtfv5q79+S9qeorFTf/j2ECpRpCuwrHbIGq0gQxXlRBH/xjskPL9qOolhZCfqSFCvtYQT+5FPIJM6RzVfGPziLFS1OiD2XIdUBdJ0gl2dmnT19Pd2i3xUvz2UMMzu60vVqWrC9Me5cmLwxgVBTup3e6w1xehXMAJSjLGpUzro9JfLO7AMexdje90nfMHnTdCUwOvDLIYcv20NRb/SIm2Vvk3l1+xR60H+1k/z0IDuqqWPBF/SjkLxiBLLGRnF6JEZ0YezQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wi/WfUUPUtzpwbMuymT8EcllOqwk8iRk8wDSMAyBhdM=;
 b=ZeYHd4s0WQyiD0FdCCQ9ow1wiYQma2hqOt7XT6EF22UUhjp/yCAn7uw1RsiLR8tkl6XCBPH8h4Ttl+0La4vq5EizUK8nJ4mIqhFwKIAi80WwbeKOIONTJ8NvZ9QuYHEY4ukBowk+rGexGi8UfOlokgHmfzcH0UGZ85FaredUTmAMJHOFZgc/3/6kslt4LsKSsQM5csnizIRwpp6CMHVvrvw0xv1SYETdIMYc7dE2Zx42pwteAAd0j5/55YilqNjrlXR0oVZ0FiFV2Xv0I3WXG25A6rnTLQ+WoMugZoatYQKZL+napLD4PjzuJ2nKLktasyEc8o+Zixn3D/rConvjkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wi/WfUUPUtzpwbMuymT8EcllOqwk8iRk8wDSMAyBhdM=;
 b=R1vrF05qsz79tNRtPkK9/FdjFm03MzRouv+g8hEewuzwGs+GJXKcZ3drK0c/IXuAWPGBlO97uuEHtRV+MHKU0jdwTowi5E/UgmJqzuEQoZCUf1sBQmFAhFtoqZAgTzar2tez9Um9bJcRIMiXnayF9WxWr3gVRVXeRdIRNy4Dvbr6o7iF3u7coT+NBNrfUZbYIgPFdUgKHttQSQCuS79sIJXcRaaUUOkmX7XoTcj0lsGRceMOcvS4K2ekunig6RWYdbqv1MBlv22HYyKNwk7iTAT+XitmCeHKV4xchuIv/EfdWoUA11N8H5X/+cZub/ALw/uhGxm+uJsELyR1npxDqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by GVXPR04MB10945.eurprd04.prod.outlook.com (2603:10a6:150:21e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.19; Sun, 12 Jul
 2026 13:09:09 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0181.019; Sun, 12 Jul 2026
 13:09:09 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 12 Jul 2026 21:07:29 +0800
Subject: [PATCH 2/5] mmc: rpmb: fix tautological condition in
 RPMB_REQ_READ_DATA validation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260712-mmc-fix-v1-2-99a1136bbe54@nxp.com>
References: <20260712-mmc-fix-v1-0-99a1136bbe54@nxp.com>
In-Reply-To: <20260712-mmc-fix-v1-0-99a1136bbe54@nxp.com>
To: u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Jens Wiklander <jenswi@kernel.org>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Yanir Levin <yanir.levin@tandemg.com>, 
 Eran Moshe <emoshe@gsitechnology.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Tanmay Kathpalia <tanmay.kathpalia@gmail.com>, 
 Jimmy Durand Wesolowski <jimmy.wesolowski@mobileye.com>, 
 Iulian Banaga <iulianeugen.banaga@mobileye.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI3PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:295::11) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|GVXPR04MB10945:EE_
X-MS-Office365-Filtering-Correlation-Id: 1adfc988-f5d0-440d-945f-08dee016c28f
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|1800799024|376014|366016|7416014|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: bwo/0FfU4voeeciDOut8oHQaWlu5hvRlS3DwWg2KKgKPDLfA1qOPCmCLfE4jzrHSt8pYeZzZHKgOiTCZadRpGDTRCo5cFSu4E3FVIjbs5ZVDhA21E96Y3u6sYxNQWzyvTHRGY6gCawUqjIvOosjycl7HHFbHpvC/CtsKblUpPp8ZuJgbupCa0cEbLObkB+jib4za2k1YrC6I7LR8yOZ90Cgoa/tfT74RhA9x4NOLmPrvGVxwK6mAUY9nJy2hfE2GCv2r7OSJzcz4VFcATcdxuI4+3QB1IEw7wkP79fquoJLN++L1I6Ea7Ay21xI07JJE9x0lCMM857HdT2pz9B/uOOSCejHgx7/z8idcaoDY7TWfTEXVspieYuGH9hncM9kgmcNFoGyosLxSwtyQ1EFcn4w9z3l/0AlbyaUmPYNJrKFZHF2dwks8BjzPt0VRtsnDKjQiP/8QPTqiMkFSqqOpiw2mlOucY39pyDesMgWCOS7/w62XNMkQowfVT4vO9GGz5NTx2m47X9FwQK6TSQALYLOJ1VGpi5qpcp3iCxcCFZJk+7Fbr7Rv67gWRS/LINNFPngCFptrvRomfYBAqfcemf8RBo1+2k1khL9dl7gbYzeT5jd49CGJRxtrFv1WMkg8R6EX4rY/xjud2o/6BXJbkxekyo5dOwUdcd4NDrNlFqo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(1800799024)(376014)(366016)(7416014)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGxoc2VZeFBpMlhNL0t1QTdVWnJ5eFpnaHVYZU5ndmt0NUNTcUw5bEZ2UGE0?=
 =?utf-8?B?Um9ZRjNmSW45SWNiNUFSZFMzVjVoYnFwN1FSeFNQNkxPTjY4Y3ZFS1N3RXdz?=
 =?utf-8?B?SlNLZzIwTllYWXluWEtXb1pqK3NTSUxFRGVuL0xLdHR0akRPbkFyeHhNWDhr?=
 =?utf-8?B?cEZ0aUFiV2dFek9xSG1Sb1RsQXUwYVBqQUxpbVprUlZSM3hqQ1FtenJCWEJK?=
 =?utf-8?B?bDBKQVBtQXRmbU9peTlvejNnVVBqcG5CWGs2VXVEcDUzOEZyTE9iK3lRajJF?=
 =?utf-8?B?MnQ4M1VvR3VRaklUMXc3OGtuS01qdnpUeFhlRCtndXUxcitwdEZtYW9mcVFK?=
 =?utf-8?B?Q2h0ZjJnb0VHU0t5UjhQZzdFdFpFblNuVW9iVnE4NjZ1Nng4d2JUdW5KeTZt?=
 =?utf-8?B?SEN4b1NaYk9yL25VRlNwU0ZxSWs5S2h1a2ZSb1lLK2VxbXNOZVhRMlR2SDBN?=
 =?utf-8?B?Z29wcXRYZG9PdndSSUxheUZCVC9qVG9jTG1BMElvc2NGSkpSbVQ0allSaFkv?=
 =?utf-8?B?elRRYmQzZGEwbldzQWh6WTEwTG5ySGhDdzZRcmlUampjeHA4MGlqK2RxVFUx?=
 =?utf-8?B?T1d3bzFqakpyWFFuV2ZnR2JmcmZtNEtkSk4wczFTM2Y2WWtYMXlickszb3VQ?=
 =?utf-8?B?azY0NEpaVDkrbXd4R1pIbS9wSU1DdGUyN0lmYmRCR1FMeHFCRGU3TmFnRjNN?=
 =?utf-8?B?dGlqT1RDNmY1dFpsdFZIaFhJVFBCRnJidlh4aXBvQ054S0Fod2dLQ3BQWHRY?=
 =?utf-8?B?VHNWOWFzK1ZWbmNZWllMbUtwWjBHYzFWaGExUXpmbnZaZVhpQ2g1b05UOW1i?=
 =?utf-8?B?SURiWE5wWWtWRWF2dER1R1JXU3hqaVAwQUcxbWhmbThGMUZobndQaWllVVVR?=
 =?utf-8?B?Z1JnZmVpNGZRUzJiWXZ6M3FsQXd5OU16bkkwRk45YUF2YndJZ3BzS29tUmtw?=
 =?utf-8?B?ay9BRHRIMGwrVjFqVDd6Q0N5MFZtZjdGMzQrTHk3SWM3TlYyVm9vRXJOaC9D?=
 =?utf-8?B?VUlMQkhtNUtMRkU4YjQ0SzlnRktCN3J4ZG9xVjl4OEtyTGdiZHg2aVp1Z2hY?=
 =?utf-8?B?bHpoT0xqQ25YN3N0VUJQN0lHRDhxNDg1ZGc3K2FONVZ3TThxUm8zYUcxcmRE?=
 =?utf-8?B?Q0tueFNhd3V6YkR3RWdnVWJtb2NZS1hmV1hhQysrRzZDNE5IN090L0tPRFZK?=
 =?utf-8?B?MkxtNWhSVUJpU0U0N0xrQXN2ZUNVTE5YajFIUzk5M0Z5S2crSFBPa2xqOFJt?=
 =?utf-8?B?L1hCZTRjNFA4aVNWU3BLRjVCZHpmTDAxWThYVFR1UmErL2N0bkJ1Mzgyc1FO?=
 =?utf-8?B?a2tjNFNPbHE4OTQ0SmJqMlBhS0Fna2UrRDcvS0N6VWpTbGphKzdONkVRaVQr?=
 =?utf-8?B?aTJuVlZaelVqTHo4bFhKdmM3SHpYbFRIS0tPajQzVTFlejVHanFSNDFoTnNi?=
 =?utf-8?B?UDlOYnp5VkF2QTU3T0NjOUlnSXhSSFloWmxrUTB4ZnliY2dlZGFWWnJFNXhD?=
 =?utf-8?B?WHA1WTNUZHZIUGhaMHU0U2h0KzBrK0RIT3VLWk9oY1JJbkg4YUJRbjNEd1Nm?=
 =?utf-8?B?SEZJQ0VvRXlIR2ZrOHJlMVZmbmZjT1FmSXo0OTdOVVl5QzJJMkJtejVzalNk?=
 =?utf-8?B?UmFHK0s3RnZpVGFSbmdWek9BRGZDTkl1VnhVZi8xdUpNSmoxYzZaaFVNckwy?=
 =?utf-8?B?akNwWmxDOGVkZ3NQTGY2RDFWYmptZ2FGNHcraVpsT3ZMcEZEU2JVZDF0eEJr?=
 =?utf-8?B?NmVsVmI4NnZBVlA4NnFUakROUzFqN0QvUG9lVWRCRzI3b0U2SlZWcFQvaXEx?=
 =?utf-8?B?MDBlZ2EweFlXL0NQb2JMdkJQUmxWdGhIUFBKRml3bnpYdnNxMVhBNUF2SzJH?=
 =?utf-8?B?UkN0TDJlQ05JaXJaeUN6VkY1Wk54NHVNNkhZQ2hUWjJxaWd3blI0cjhlYzZB?=
 =?utf-8?B?Z3p0dEhCMHNjbng2WWorRmpxVnd6VDlVMk9WMVYzOHFtL3dZa2x2UzRlMWVo?=
 =?utf-8?B?eER5bFdqQnJld1JqMWFXcGxoOHhWbklwSTFrUmRPRklLOVpkalQxQi9Rc0Ju?=
 =?utf-8?B?N0cxWVVHQVd4SVZYYzE1cmtpYVZiUnQwbU00VnBtaFNHbjJOWHZ3N2c1M3Jr?=
 =?utf-8?B?b2dFV0tSVytRUENkcUJTcHVuYnZpNXQ3V3pGUitteFVOZ21xZjJoejc2VTAv?=
 =?utf-8?B?Qmx0Mi95VldvTEk5YTFCWGczRDBWenB0ZzNRMExNdnVobit0UFNpTmpsYitL?=
 =?utf-8?B?VjVNS3gvSEdwSmZGNnRkMkhnSXpFNSt5ZnlPM20zemJnT2dscWpQUHJhcTRp?=
 =?utf-8?B?SS9Sei9ob0t1MEp2UzdUTUtlQk4rUmdzYXlxQXdtbm9iOGFOUFdibmhDS200?=
 =?utf-8?Q?c8HTwR472DAdOSJ8NvGEAumnC2u8KFtS/qNSx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1adfc988-f5d0-440d-945f-08dee016c28f
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2026 13:09:09.2836 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nkXsBUzLaPU9awGYIggM5kkH+3ev7bF9OWU3jZDLvD/5mD0LGzPehjSnBU9R7Uv7MjlK92o+qqKluj/c0x09mXm3uS9tf+tITiPs/L+tP/AvpeyuMD8JSr2CutiJxG73
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10945
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

In rpmb_route_frames(), the RPMB_REQ_READ_DATA case checks
"req_cnt != 1 || !req_cnt" which is tautological -- !req_cnt (req_cnt
== 0) is always a subset of req_cnt != 1. The second operand is dead
code.

Based on the pattern of all other cases in the switch (RPMB_REQ_KEY,
RPMB_REQ_WRITE_DATA, RPMB_REQ_WCOUNTER) which validate rsp_cnt, this
was meant to be "req_cnt != 1 || !rsp_cnt". Without this fix, a caller
could pass rsp_cnt=0 for a read request without validation.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mmc/rpmb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/rpmb.c b/drivers/mmc/rpmb.c
index 8bfdffd56f5..26d2262ef45 100644
--- a/drivers/mmc/rpmb.c
+++ b/drivers/mmc/rpmb.c
@@ -452,7 +452,7 @@ static int rpmb_route_frames(struct mmc *mmc, struct s_rpmb *req,
 		return rpmb_route_read_req(mmc, req, req_cnt, rsp, rsp_cnt);
 
 	case RPMB_REQ_READ_DATA:
-		if (req_cnt != 1 || !req_cnt)
+		if (req_cnt != 1 || !rsp_cnt)
 			return -EINVAL;
 		return rpmb_route_read_req(mmc, req, req_cnt, rsp, rsp_cnt);
 

-- 
2.51.0

