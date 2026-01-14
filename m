Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9C0D31A2E
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 09:18:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56EBA83655;
	Wed, 14 Jan 2026 10:17:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="IPvrNcu+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AF42830E4; Wed, 14 Jan 2026 10:15:02 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazolkn190130003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d20a::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50CD980081
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 10:15:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dGWWYdGVAaZLubLKgU6xJIWZkBo6lK23P3XkTxOZqroIbJnY3Lpu5ScuV/9DIqMMe04NTeG9UPTESWUu5fb23iDAACfeBYZJN7q3WfmVUIYdI0U4sD1Ks0Baodv6KWBCpTyhDzImuqMNHW8bE/x4QHt8cQrbSPoLC9o/NGZkuaBSOMyaiZzVo9K/QOsR3CQYrrgFVJRcuBfVmzvFJ67Td/K+65AJp9VEQyjeNx00te8P1C66mB4zkPJPtux7rguP312y6Qjy59nFlTvgbNSKKiBLZvLvVGfxlMyvdfQ+PMhk5gzyEezPHwyvf7R0vCsVCkiY5v5c2UlIYfY8EOJObw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3kTcnmltLNRPdCmq3DMH0lzossRRLDnBCIw9tLfAcTQ=;
 b=a6Hz7nYXfphp/HCqD4xITDzBdIMb+kL+2qF7p5SypEBw/rZlozdIHktYrk+YxT3uTgqFPW8orkGxRZfc15Cr3oOkNPWW5bhFoPlGZeKdljNSYiFgfOpDOYITNgnK6q5921a5IwnZJbVA5l0fuK6dv4E/KSKol2q37ztCHgJlXgcRdk+edYf5xvxfRh62ZoCfuywMepwDC/1wyXmvZCb7CkHu9ttzBwXm0lqTsSEgAB69ahG2TEPq54+Er89tRPddEKlRseGtsJuODYZ0gREWgR16Yt1GPuwWjzrJLeaxqPNkI4HhqSXvnVhsTe7oImS9nP4BFHkOJyR4Rv58BYRykQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kTcnmltLNRPdCmq3DMH0lzossRRLDnBCIw9tLfAcTQ=;
 b=IPvrNcu+mldEfp7m5iB6cgmPP08qKnNAWUPvSaN7Ov9FMuW6HW/6Z7MPh7qkxTBmBfM1iwX95zscsteAjK906lGP55K7ECwUVbp+8shaNPGuyE0s9vZp0WMUTLYCWExNYtkUlTavvD6FlEp9QJRMMIm+J3hS+xiWDzepH/4yJrpQB5smNg+CWfUxQHN/ZZZYEpAb/ZhzR8I8DsEPgt66JLwgPX1ckw2gteuMteKdl1IkHzMhQb6t+Fbeg5foUlLcgm2rAME1hNdnNk13ZXsmZOWhwicX6UtaKA4W0+F2MeTYQp355h89SKTdygBIa5bYbkibOas3hRCnYMOF6XuRrA==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 DB8P194MB0791.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:160::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.5; Wed, 14 Jan 2026 09:14:59 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::116c:6a13:5362:4f58]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::116c:6a13:5362:4f58%6]) with mapi id 15.20.9499.002; Wed, 14 Jan 2026
 09:14:58 +0000
Message-ID: <BESP194MB28052734FD0361EA602F6360DA8FA@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Wed, 14 Jan 2026 10:14:55 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Francois Berder <fberder@outlook.fr>
Subject: [PATCH] bootstd: android: Add missing free in android_read_bootflow
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0330.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:39a::24) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <717972db-8930-4fc3-a55a-1dbe4ceb1cdf@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|DB8P194MB0791:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b2964b2-3857-4599-540e-08de534d6380
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|21061999006|23021999003|41001999006|15080799012|461199028|5062599005|5072599009|51005399006|6090799003|8060799015|19110799012|3412199025|440099028|40105399003|11031999003|12091999003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RG5hYXk5dm1OemFxZlVibkFRaDN0Y0ZUZlJDRnJTRzd0OGdXV0dXTGVYMEJO?=
 =?utf-8?B?b1NKYjYyS0FBTFFqL0x4ek1lVGs3ekIvaDF2STlNM3FnLzFReEtFY05KTmRK?=
 =?utf-8?B?TXJUNmF0eGNwM3BVVFYvcEtUd0owd1FxazVVcmpRMHExNzdlcytiQ1NSTHAv?=
 =?utf-8?B?YnpneGszZ0VpNnlzUGlidFBTMEVudXp0WXljRkZqMVJvZUhvSjZ0a3RaTDln?=
 =?utf-8?B?NXJDYW9QUFRhdzNFTzE4R2tzK0lWOHlzMHZNdmNvN2swVm1ETndBMXd3aklL?=
 =?utf-8?B?RUdPWmE1N1JSb255NWI5NDIydTMzR01YTkxlL1VsKzdrbUJPSGcyTGVGcmRI?=
 =?utf-8?B?SEo0bFNOVW9iMmdINXBqdGxKY2RveVd0c2tvZWFUaEdheDdZVXg5TDhVNjA3?=
 =?utf-8?B?NkpNOGJiNjJ2bWJuYjBJckhJdzFlcU9lRDQvSE5lZkltRDJ2VTJhbGZHczhl?=
 =?utf-8?B?MDlVYkZBVjRyQXRWdnpUbkg4VXZQSjEwMlRIRHMzbCs5bHF6VmRwUnRGNjhi?=
 =?utf-8?B?SDVkK0FINkFTa0R2c1lNc0tJOUNjY00wcFJmaUdhQ1RQRTIrZFRneVhNQlZD?=
 =?utf-8?B?UkwwWFJrczhXS2FOcFJ6VXdNOEgvTFdyN3lEMXJCL1o1OVEwd0ZqeHZnN1Na?=
 =?utf-8?B?OWRDaHVhMjhTbEFiT0ZwTlhWamY1bUVQVCt2d3A2cENmM2IyTFhrd2U1dDFs?=
 =?utf-8?B?VUlkdUNoN3hJTkNXZnVLb0x2YWdQWGRwR0RrQ3liZFowTmNFV2IwT1N6a21j?=
 =?utf-8?B?bVdPUDFSRWNaZWcxWnZRYmxkWDZ5c1loQ0dXQU5aOVJiaG9ueTlQNktTTys0?=
 =?utf-8?B?dGlJSVptTXI0bktZOStmMXlTWkNqdTliNG9vSXVBK3NvRXFMSklaYlg1VklF?=
 =?utf-8?B?aEN1N21RQ2QxVHVyR3NiNXYyR0lqOE9pTUM4b1E0bk50TnJQYkExMWpUYlph?=
 =?utf-8?B?dTJzODRpM1FnQjY2MytOa1FkRUtBd1J3anEvRWVZMHAvbllkRFdSTGdvR2sx?=
 =?utf-8?B?VTVjUzhnakhVQXJhVEJrS1I1Q0xacEM5L2RkVkNhamtPOE1HMkF3YVFzUjM0?=
 =?utf-8?B?QXNKdzFYN0lVTDI3VU8xYS9FUnVGcTk1UmxSYUExVGVKK0FNOGdyMFcxcUZG?=
 =?utf-8?B?Q2NyYTAxSnBNMTMraXgyUzRLbGFLNzl3Q085Rm9GYXhwRVRiSHJTMXZSMzNu?=
 =?utf-8?B?eUMrUmtKWmR2UFZZNkRjZGJDQkdkTVdMUWs4a2RLT2Y0ZXdZK2JHeVovdHp0?=
 =?utf-8?B?ZXJ4Ym93NWprQVk0bTR3MlAxUUh0YXdMWDFyN3JBVjRIWkRnYmQwem91QkQ3?=
 =?utf-8?B?M3FQb2hwVHc1ZXBkd08xL3duaE9zT0VkR0VCVlNRSXZTWTRuZ04rU1A3TnhK?=
 =?utf-8?B?aXpMVjdPVEErck9vd00xRjFmTnd2Vm1oZVlEb0VINFc0dFE0dklUVXpYMDBq?=
 =?utf-8?B?bU1XWEVFUStTMjA3QUI2L3h3RjBiako2SHc4VG5zZnllV0NPelRBVDNBcWR3?=
 =?utf-8?B?eEhKRVNPRG5ORXBXU2xYMWFTZWI3c0owSlgwUUZKZ3Vta1VYejJIN04xSEI5?=
 =?utf-8?B?UUwxSWsxenFlSzFLTjEyUjZrRmd5QVQzWVkwcjcyeWE1U1FzTFFyZUIyT3A3?=
 =?utf-8?B?QnlsaDZ4NCtPTUpDZU53U0toYTFEQkxIUTc4cDRLUkpPVHhOM2wyNytpQWJ1?=
 =?utf-8?B?N2t2VU5NM2lsTTBrTFNIOERkNXZSeUY3dDZGaERZS0JiOXpmR3J3dUxReERN?=
 =?utf-8?B?WjZmSXFlaG5xa1dOYWJ1Sy81WHFSWm1pT1lSZjRxQzVYVE1RSkNZWmhXdGhK?=
 =?utf-8?Q?MRzGC9+ZoPIIZwSyW5lyAPhUsZOljs0bxWMgI=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnE4b251aWYwd0MxRzRqQXdCeWFKT3JOSFZjUUV6NmQrZlI4ODlUUlhKaHk2?=
 =?utf-8?B?czdUVEhSYXFhRVVrWjNvZHRkWDNyY2puUk5WdXUvMS9XazdINm1RTU5LclZx?=
 =?utf-8?B?ZklxcTZUcW9WM1pDSXdrd1dRc1k3QzVLMnFCRHNlZml4bFlEbnU5UloveU9w?=
 =?utf-8?B?c0JQV2pEOWN5bUU3bnQ5SDRGU3lBN0NoeC9xUk9LRndhL2kxNCs3bW1TSXRl?=
 =?utf-8?B?K3Y0eWxtVVdrUVQzZ2ZmRXRXaTRNZzFHSWpKZFFtN2l4b25ZWDdzbU1PeXV2?=
 =?utf-8?B?U2w1Ymk5VVRBUmQyU1lYWGJVVU1Ra3FRRm9Ob0ZhbC9mQ0VhYThrOVdlcHdW?=
 =?utf-8?B?QUlaSDByMCtrSUJvRFVyWU4vR1VKOHFuaDZnYjF1a3MxT2podTRKVnpPV0xG?=
 =?utf-8?B?SWlkYnNwTEw1T1BEQ2xocDZyMC9lVUlocWdWcFpMNXB6WHBVckpmUVJhUlVn?=
 =?utf-8?B?WFhwOFNEcjdsYlV3QzU5Y1hKcU9kNS9pdVZkbHVFUlpXK2Q0aUR4ekpEUnhl?=
 =?utf-8?B?NGtGNVNzbmNPU293MnBrMzZOcTBMQ2lCa0NiejdXSmZsUUZRdzRoZHRZa0hs?=
 =?utf-8?B?ZTZnY3JpNHh4QURRdGo5dTc4aHRMQ05SeW5abnRUeUZNdVkzRHMvaGhqTUhx?=
 =?utf-8?B?UWVQRzNFcGxxdVFOaFlSMlhUQ3g5TVJyZ1gvNWpEbWU4d2MwZE9PWTcxVUlj?=
 =?utf-8?B?RndQWE9HTlROWTVpN2VUNnVkZEtBTVU1ckZ6YnJFS3Q0QjM5OU42R04wNkdS?=
 =?utf-8?B?VTdEeDNKVWpuZU5oWmgrOFc3VDR2K1F0emlXeS9ybjJ0K3J5WlNzZGp1MDl4?=
 =?utf-8?B?MnVwUkNDZ1JUNk1YajllRWQ4UHc3dlNpTitoS1lla3M0WDhoZURRRUp1Ui9B?=
 =?utf-8?B?QjdlWlpuR3ZncEpySGFIMU90elZYcGRHUHFDbkJHZ2JZanU5bVFVQmtJbG5w?=
 =?utf-8?B?Y255MjkreEtWaE04ODlFNFFlUkFoWGErM3BvcTBXeTZMdDlXYmpFbzVGTVVT?=
 =?utf-8?B?WU42d0ticXI5TUNlc3ZBMFlEaTN2WWcrcysxZjhTczMxaEZvQTdLRjM4eGh4?=
 =?utf-8?B?aUFQQnNGL3ZjZFYwQ0tGcE5ZcmpEbW1ROSsyVmxBVm9jUHhlYXJ5bWNuWS95?=
 =?utf-8?B?b1htV3o0bEpJYUtPc1pWL2N0bnREWUN1aUVWdS9Na3dhbWY4ckVKZXNDdC9Z?=
 =?utf-8?B?L1B4SnNQQTNKYXU0SFlSeHExL2x1SGJsWGNWTDNwTFhYQzkvcnBaSVdGa2pM?=
 =?utf-8?B?L1V3RXNzVVl1TEdrQ1RPQjFSMUVjaC9iV256dW1uRTVmU2RUY1JvV1U1Z2Zr?=
 =?utf-8?B?ZHdSNDJjQi9pU2Z1UTZVa1Q5TGh6c0dGTngzQlZGTGhFTmYxWVVwOTRiSG9z?=
 =?utf-8?B?TUdpY2FBejJvNlV0WE5hM2t4ZHJOVEhQakl2YWlUazV4bkhraERUWGV0R3ph?=
 =?utf-8?B?UVBTOHovbGgwb3dKcGdnOGVqOWdBKytqY1dFS3RYR0pOU1BoZExyQm5yMVBU?=
 =?utf-8?B?YVd5Q20rSkxPeXVmMHErSFhSc05sUFJaaEFBQS9Uc3g4a2N3Y2RDSm1FYmFW?=
 =?utf-8?B?cjl2ays5eWdCSlBwSFByNUpoVWg4TlRqUHpSSzFobWxXNzNvVlpCbHVwbTdK?=
 =?utf-8?B?V04xejdjMEYxNHp0N3RaN1BCaGJBbmVVTGgra29NajFmZk1qcGQ2WlV0bzBh?=
 =?utf-8?B?OEhlOWt5TEdqeXk3bDR0eHZhRGlhOVNVNTlkRFlJNE1ubEdhb2hYL3BPMEU2?=
 =?utf-8?B?T3FyMU1UVU9RMGFPYk5aZEdERTNWQXBYM3RNVE0xSDRBU0I0cGlINVRsa2pM?=
 =?utf-8?B?am5BOXNNSHB2WXRzRFh4dFV6WVhHK1Btb3pZdEUrMlRLajczbjZyR09JOVJU?=
 =?utf-8?Q?IdaJ527/xcX0R?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-e7640.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b2964b2-3857-4599-540e-08de534d6380
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 09:14:58.5531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P194MB0791
X-Mailman-Approved-At: Wed, 14 Jan 2026 10:17:43 +0100
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

If strdup call fails, one needs to free priv variable.

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 boot/bootmeth_android.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
index 1374551dbeb..1d70e8d5c05 100644
--- a/boot/bootmeth_android.c
+++ b/boot/bootmeth_android.c
@@ -252,8 +252,10 @@ static int android_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 		priv->boot_mode = ANDROID_BOOT_MODE_NORMAL;
 		bflow->os_name = strdup("Android");
 	}
-	if (!bflow->os_name)
+	if (!bflow->os_name) {
+		free(priv);
 		return log_msg_ret("os", -ENOMEM);
+	}
 
 	if (priv->boot_mode == ANDROID_BOOT_MODE_BOOTLOADER) {
 		/* Clear BCB */
-- 
2.43.0

