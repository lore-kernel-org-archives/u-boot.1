Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BBF7D12663
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 18:45:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC51A83EC9;
	Tue,  2 Dec 2025 19:45:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="P9uoxIa/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6ACCF83EF9; Tue,  2 Dec 2025 19:39:46 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazolkn190110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B84383EE4
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 19:39:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1/Wop1GacP4d66nsWHqRN9GcoOYudSWAvu71xVgCaMT7jwgleSb1IthEW5y9cddU2vNJtviuhw9fPOjV/sfRxvMsT9sfEdTw4fYcTXSzkCFuQwY0sdGQLDHP24hXfl2/9DSn5UWh+McY+Idc/TdqHmDMbQua7nySweLZKohb0BcU7GMo9n4Bf0WsOfMziciotq4Ok9pQeMB3TpKLu9ORyXQLziKdUawzFzeDNGsflVr+3nQIHiqFLvqsWyA1PyHbuhrYHy0KP64ofbDZ56kDbEqub1vf0+2gDzYGdGeGZGizFlXrn+s/+gJ8BpRAThtvDqQRGWB83vi9uhrOV8eBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LImE1bu9NYc8nC7Bb5rgxuOlWola0InJ8nPmVs2UsZY=;
 b=BLy3ZZCE1RUEEd5jKmhgFPxQm0GZlsGvlwEe8akcuKQxXy+06+uLxFm2wsqCFJ2QdEmLAwE9CAfvLPRDhXWOvFtIHDgiBI3q1Bls4dfvUIxOvQ4SiT9qCVA/IV1HDdAILwIRrWYbMROji31FhZG+8XykIxFmpMBQkwzTlWWOiyXX3ctHKC+G7Duo40Bf3oO8eRD29N17iac3fcp5qBKC/GPLfmIGvqWWyB/9FB5ZqIuIDAMMOjxeZwFZlEcRh1veX+NqGDlEEc7bzdv+yjrOWMJLKCLbuJcQ9WcF+KaS8jfAHWLCqfCWz+YfLnkRbmO5ANhi1Trs4hQ/YUMYwwqlFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LImE1bu9NYc8nC7Bb5rgxuOlWola0InJ8nPmVs2UsZY=;
 b=P9uoxIa/HlYR9V+2vK34wHw/NSmOdGrGd2o5J334N8NN7DXJsGghQrRbRsB7ySRpoJST6y75TvUTtBZnCovQLxSzq1lKNLwJ89LOWK1bfxYdgVRC2+l8Rl+XIoTTYOJT9+ZuGtsoTuiYb7pkzhlVBv2hfgPkzdK3p/7cMSxWHQVMno70KypKk9+NDJvjXpyQTwR8WNabzgxleTyxtlcHgZ6xk8Dg5ON3Sk4sanglLpxhbFbI487HgaczECL/GPyG8XFx6RYoiRaQ5Q1KWMdoI3yhwSVU+D+gFO2kxuMLSPTE4wBKUV0INbR/cAaxPDuockZCPSOvas261Rp+k1KIvg==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 AM0P194MB0561.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:162::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.17; Tue, 2 Dec 2025 18:39:43 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::116c:6a13:5362:4f58]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::116c:6a13:5362:4f58%6]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 18:39:43 +0000
Message-ID: <BESP194MB2805A2491EFE4D94C777F9C5DAD8A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Tue, 2 Dec 2025 19:39:39 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Francois Berder <fberder@outlook.fr>
Subject: [PATCH] pinctrl: single: Add missing free in single_allocate_function
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0150.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:346::9) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <1cf1ae8c-3877-4f35-a221-41a5d573d5b1@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|AM0P194MB0561:EE_
X-MS-Office365-Filtering-Correlation-Id: 1728ab0e-4785-4d9f-363d-08de31d2289e
X-MS-Exchange-SLBlob-MailProps: WaIXnCbdHrPmpEA5mD8NxFXtQzGzX9gU1qa63Nd6j3poMo1n4VghXP1D0OweKDXscgRZu6PgFk15RV3iaUngRxGw8ciQ0+HTp5Xl7b2LZKMEVPJnRl68fSTH6HDOPatteIWEiMn9LyvWOpkW5s7PfkBE7HgSQ9v8D62bnbG2TA/AzJsvgIop2Lh+kY4gayWV8ioJsuNxSQ/atoErlAWTa796szLxY+JzsU6ojknKbRZhfOp2ovjQgZBzlwdkITk1NEl7eyw+E2yRpMbNMuGU9mSVejD+YrOmhOKcTmsJYpnH2xyjK82646M6hLCQVM7t1Q3Yzm/ro4spp9aF+Qn2QmqSa6bmhTObaCo9DNAp1qRhE0nO0VpUtRm6NZ9Ppk34xDL91TT2hvsEBA70e8v7LojsC8zAQ4YjNIPWXdRySrmCLDnr4rU9I4+VWuWHr5F7iqEoEjGZpN7ckPlnD0ViaFEIaycVFvmYk5vyO6+T+jAepe4QEu4ihGDu2znbxvxuAvsax/YhQ3FnCXJSQwLj/HuKK/KFNKOApndJJe+x0zhs3A/Fu6S/KsJ3Ac3CAv65bscDXa4Zi5ij30uZ+9DBL9apUyOba/0WKjAe0Ui+D45ZNU7FfPIZv3cm5SvlRTQXm5m4u77dlINlAwuv+xRoq4inlfh9ZSTiAepcuY2K890LAK7XvrilCSytGe2bUxYQ3S2LD59e46OsE6SYAuwK3h868bt9GjjKFIcuoBqrvhIt1gGFnfDMHlYTnAQQF52SHw4Sp+ktVzQ=
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|51005399006|19110799012|41001999006|21061999006|23021999003|8060799015|461199028|6090799003|5072599009|15080799012|5062599005|40105399003|3412199025|440099028|11031999003|12091999003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEFxcThEdkwvNi90WUtTVjN4aEFmVDdraERBWmRvZ2VsU1Y3U2cvR0RDVUxD?=
 =?utf-8?B?UkVvUUxJMzRreVc1a0EwZEdISko3MFFEcmlLb3hNa1FsZVRHd3FQb0xvN09t?=
 =?utf-8?B?V0dBc0ZGWDJjMXdZMGxWRVEzUTdsb2ltTXB1WVZiMk5BK3JwR0J0WjhGMEdG?=
 =?utf-8?B?bWRReEFKdG53eHNweDlHR0UrK2xkSVRyK3BqcGIzd2JWNTk2eFM4VEtSU0Uv?=
 =?utf-8?B?NVRhK1VVTEFESnZkNVJDUitQTVhIRlB1L283dk1qTDZlODlkbTdlUlBleVF3?=
 =?utf-8?B?aUs0WEFsTjRyQVlDWE80clM5S2xSaU4rU3F2TitWcXBSUWVOOFh0N1QvTGZS?=
 =?utf-8?B?NkVkOWJDUHJVMjlERkszS05pQUFtTWgvMGU1blc3aGc0Uk5uY0k0Vlp1T21q?=
 =?utf-8?B?OUpncEdlV1NIUmh3QlRhckpKTE93YndIUDVleUhQdS9reHBLUGs0bW4vOW9k?=
 =?utf-8?B?ZjhjTzhiTDQ4bEJYRitzV2czV3RycndGdVZIZXA5NDhiWGZUbjdxTHh3Tkpk?=
 =?utf-8?B?dzJxY0czR0R0Z25LYi81SkVPV2JQT1RSeFBWalE4eWRqMGhQTUs2bEZVdkJ3?=
 =?utf-8?B?UEl6eElsZk8zOXB1NE16SXJpdU0xU3o1QUZWVjhDSTYrVDZ4ODc5N0NaOFR6?=
 =?utf-8?B?czVmeXphdHV4SUNFdVNsek9naDZEekZpQ2R0eS83TmhuOUZMN3N3UWRYSi9l?=
 =?utf-8?B?eWFQcXpxemFiaGVXVG5mcW00azlFdWxvR0VRRW90SjMzS0lxWW1adm9WSTd2?=
 =?utf-8?B?UUFFZjcwRUcvWVBSVFFqZnpBbkZRb1ZScmpWRHA2V3lZQjF6cElZajRyK3Vs?=
 =?utf-8?B?SHdlM0wrL1J5SHBmL3RHZE9MZmNTanF0a09jOWU0ais3aXp6Z1EzOXZKbElw?=
 =?utf-8?B?ZHRCa3g0YTVyNFg4S053eTI2ZmJBOG42N0ZER3JmQ1Bab3JGQnRnNUxXcnNy?=
 =?utf-8?B?bTdYWEdmU3FCUDNwSU8rR1BET2JTZW9paEVQTWd2SUIvdjl2bUFsVGJsV0xG?=
 =?utf-8?B?a2dNVzRoUkhOMUM5cFg3dGJIU2lpaXBBRmFOMmpDQUZTSEY0TDVTNi91WVU1?=
 =?utf-8?B?VzFQSXZnZksvcysyWGhpWEs2OUZtUU9ubW9aWXhPS3lnM1dzU1VjV0J4K2w1?=
 =?utf-8?B?S1lpVGl2TGY2SWpHaFY2cHpnS1dwRktQMkJsdjl0MDZIZytMZjI3NGtHTzBC?=
 =?utf-8?B?NWZwa3g0V25jaE93c2c3SVo0M05mZ0pWVE8wOVhhbE0wdHNHM2Myc1ZjMCsv?=
 =?utf-8?B?eUNvYllLWGxXNUV2NllITlFqRlF6MWthUUNURFpQM1RwR3Z4S0hpZUlQTjZU?=
 =?utf-8?B?bzRwc2FNYVN3T1NtWVRMMnZtVmYxUUtNZXo0RnUrZGpXNkxxcG5tTkFhekJO?=
 =?utf-8?B?WU5EN2RwUE5XcHJZYjF3ZXQvUk02VjltdlNVaTJaRU9MU1IreHJKS2hvTENp?=
 =?utf-8?B?ekpRR2k4QUpSc3I1WnFwTWhjeHRSVjVhMDB5b3V2b3Jzc1E4QlRLM0x4WlJM?=
 =?utf-8?B?MnY5cjBOVUtkaGsvUEZkSG94RXpoQVFMMTBPWk9MRlowUy9HUFNBRUpaaGEx?=
 =?utf-8?B?RXplUEk4U05ZMW13dXFlbk1xSUFiUjJEV1VkS0RZdDBHVHRtbGRTYkFvdWxx?=
 =?utf-8?B?a0ZkaFJWcXdTWEVnOFFFL2NVaHhnc0t4TUxrT1EzWFZDTkhiZHQvczBQUDhT?=
 =?utf-8?B?NWFhU2NxNXJHajBkQWs1NVAzSlYvK0lLZHFYZHdReTUxL1lwWUFSaHNUVUNz?=
 =?utf-8?B?Q3ViRkxaS093TWFuZzRTS3NFOStrYlJpMzZUYkdXKzV4aG5EdTZTay9TdVh4?=
 =?utf-8?Q?XuO6ag3SkrCg0bMyCSfpj2lAoKhbrtxKv5WN8=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFYyaGQzWUI4ZVZVd25wN25QQkVpejEzUjJoMkt2YUtXNjhLc0NLVjJFVVRL?=
 =?utf-8?B?RmVGanRTQm1wd09zTVJhd0dRV1N3N0gyVXN3Wm8xY2JOd0FUcmwrdjNIb2Fo?=
 =?utf-8?B?ckJ2S3c1ZUl3dnBEd1R6M0I5ZSt1K21wS0lqVTB5djNMcU5vWUN1Y0szVmk1?=
 =?utf-8?B?V3NIKzB2RnVoQW1UUDVNYkN6dzcxRW9RUyt3RXplUUhUR29lUGZwNnFWSFg2?=
 =?utf-8?B?bjZDWEIwYU1ObWV2VGRRa1Jyc0xQZnBZWWNqU0FCanFtMEZjejNLK3lwM0p4?=
 =?utf-8?B?K3lrZTFPeW9tOVU3Q01iRXRVazdJZWo2MVZLUGNIVTNzNVZmWXJ4dzB0Vitk?=
 =?utf-8?B?bkNESFdTSHptZnovdW1PZDJQQkltbGV5aUZ4c1N5Y2dQZVp5enozbFNDak9R?=
 =?utf-8?B?Ry9obmRUbnFHaHVrTG1PNkx4RUp2N2RlUk42UTJ0LzlYMElRMFdNb3lMWGV4?=
 =?utf-8?B?c1RYcVRSNWFHNU1oblNSNUhQU24wNUFzSEdZdEMrdk50VDFWNDdYS2FLVG5I?=
 =?utf-8?B?dS9iL2J2VUpaeWFMbkRtenpjQUhld3BKY2t6U2NvVmFEeTdLY0ppME1sMG0x?=
 =?utf-8?B?Z1BmcUhxNzcrRWxwZUd1Sjl5bDJoeEpUQ2dnaS81ZnlGZmtHNWdnNmFmVW9M?=
 =?utf-8?B?dGlsS2Vpc2Zqeit0L0xRcitEbnFzbENDdHloZkhtbENtQm1SdmRJQmpIWS96?=
 =?utf-8?B?KzU3OFdXUkowdFdvU1Q4RTVXYzV6U3Z2MXY4d2hWRGhEc0g5M2J3Ukg4YW54?=
 =?utf-8?B?aVlUU1c5R3Y4UThXbmZJVEZtSGtjYXlKMTY2eVZxYnZNOE5DYjNwdWQ5cXZ6?=
 =?utf-8?B?TFk2M3lpN2Y4VHFDd2tNUEsxcUtieHFFa2VweG0rc0RhMjhtUVNOZ3JqdFRO?=
 =?utf-8?B?c2dXM2hjVUwvaU0rTFhIYmJ3UnVEbUc5M1c3NVR1YWl3bUovWjMrWnJkLzB3?=
 =?utf-8?B?Vy9pZGQ1dXBQQkJqUTlScVppbU9TdzdNWVlzR0tUSUFIUy94OUdINTV0R1Vi?=
 =?utf-8?B?MEpKemtGZHJEWjBreU8zUnhOWmVqbkJaV1JtMU1GR21LMmxnb2tPNWdGUFg1?=
 =?utf-8?B?c2k3Y3NHL3EyS2w1TVhhc1g1TThVREtPc0hiMXF3c3g3T091UzQySlR2eHRy?=
 =?utf-8?B?OE94ZkdHTDVXMmNZbldqOGFiNC9iS3h5S2t2eEF0dUd6SGtiZGdVSE02K1U1?=
 =?utf-8?B?VGV5VTZJcERuVzFmZEpSV0RRTW0yVy9qcDloQWQ5amhVcFl3WjBPbXBlNC9v?=
 =?utf-8?B?dExxL29hNnc2a25yQ3IxYS9VaUZGcTR4YXBXWlpiem5NNGZBNGd2OTA4OVpv?=
 =?utf-8?B?ZXhNbloxdHJaYVA3QXcyVitRbWxZaEJmeHZDQy9TVWNDS2lIVGo2RzJYS2Ru?=
 =?utf-8?B?NERLWG5uUXFBbVIzWlNTQWJiZm1iUTF3U0xiSUlrVTlPZDVWSDdLSnZlbWlw?=
 =?utf-8?B?WXlPNy9nUzVzbXVuRm5TM2hoQ2hTMTJSOGRHZHhVQU5jTERvbGlsLzVLR0xz?=
 =?utf-8?B?YnliN2hpWnlCSFYrQVNkbzBWM0ZvajRNOThUek4wc0dGWmpXUEFaTlVzbUk0?=
 =?utf-8?B?QW93SUlMdVpWWGZFeFJjb1FIWFQ0RmlrTzBiWGJxUFgrOFpZMGpDSGFuMytS?=
 =?utf-8?Q?+Ae/LmTYEVIWQK0v3U7IDs2Q/xePeieFR4l7mcNN6qEU=3D?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-9bdce.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1728ab0e-4785-4d9f-363d-08de31d2289e
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 18:39:43.0585 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P194MB0561
X-Mailman-Approved-At: Tue, 02 Dec 2025 19:45:34 +0100
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

If func->pins could not be allocated, one must also free
func variable that was allocated previously.

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 drivers/pinctrl/pinctrl-single.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index c96b293aadf..42980e097e0 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -282,8 +282,10 @@ static struct single_func *single_allocate_function(struct udevice *dev,
 
 	func->pins = devm_kmalloc(dev, sizeof(unsigned int) * group_pins,
 				  GFP_KERNEL);
-	if (!func->pins)
+	if (!func->pins) {
+		devm_kfree(dev, func);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	return func;
 }
-- 
2.43.0


