Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A97ECC2BA12
	for <u-boot@archiver.kernel.org>; Sat, 16 Sep 2023 19:37:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27F3C85DFA;
	Sat, 16 Sep 2023 21:37:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="gFYiFKlq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A15385DEA; Sat, 16 Sep 2023 21:37:08 +0200 (CEST)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (mail-tycjpn01acsn20808.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:7010::808])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 701AD847C3
 for <u-boot@lists.denx.de>; Sat, 16 Sep 2023 21:37:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wiagn233@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6BvXU111MyfShazVd+DsZJYcoNnat6FFypd3o5HhAaS7anPp70MTOGkEtPgct7WBjp9/LR0OvZZKGYcIQ3EvcxcxMnHC9Bko/9q0/K6fYscs6/61esKSjRQmFKo6uZiRJX8WyU0OwzTE4U0ynEcS0fWTbvOwc1Iwv5HMYHpVfzFflrooh3MJdb7l4O+0KWdKPzKJqFLrGz8FY6TpaspXYu0RJtduJObwmAGv2L9hg0dqjddShugSzSq/7w1+t9CSxiIgSvA1dJ/hl3CxXNlSkWYCxZkJZ44dqHjRAQu7nJdJ6ZkVA+E0jmyRBZg2V9e4jsdZ2ygf1NxieafrYB+pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHt812mqa8qLrkLcgwhrPtfgZQAvgqvmjtjYHKrz4Rg=;
 b=DBVEfSmruRwT2gbnqYvHzXrW6XTwbIo92TJFa2zkzPex6nOoT8wzg1/ag/umDaWdsqNZ2i/17nGB9mgYOR8Y7GuG5k5wC4tklEJOVR+XV3BzeJ4EMYcJv7JlC2VdqBGo5RZQqu7d9Te5fC7tJFC9fiLrOzPw3Pb4jlp1Qf42SlMwRzaO+mbLAZ37KARhE3DdsmDnyQaMKOhaJHV2W+EBaKNioHUdM+TxzgG6wszbR8nhno8g3p1xk4iC+KQTdF4W1wzzKGlACeMSMUaTW3aLLrSGUfQuMfJlFvdm6d4ofAMXCs7Nnl8+GboWu12URE5OR5HgthraUJCd9jHYn54e0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHt812mqa8qLrkLcgwhrPtfgZQAvgqvmjtjYHKrz4Rg=;
 b=gFYiFKlq+JLim8/gavwjQXShYMa7KaaBgDH4nY+atq/97IxBQGREN+c059BIxbO2l+Oezy0fN4y10pV7QVOKhVDMfC0lpQ3BG4/Esk+9qLvj91NiYL48qNZDLajerLQD2yNWlHHHCdzENAfcCJ5/suJ13e73S9Chk9WSRtcevdL7vIXMCi1cCgRobvQFMHDCyuZzsQGFVfJKhzKPTuvmuQSMudiMUV6IZ3BHnlEcx+xdHndyRLao+uGSKGO7DYR6WAZ7OQUJehKVcZNcOrcSTla75zBl2ORyy7V2MxTj070f0JfI7Epq9MBdV5kGorZZSD1ERo2iVrm2w5HuokJ/RQ==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by TYCP286MB3132.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:293::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.13; Sat, 16 Sep
 2023 19:37:02 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bfaf:cb8:24b7:f67b]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::bfaf:cb8:24b7:f67b%7]) with mapi id 15.20.6813.013; Sat, 16 Sep 2023
 19:37:02 +0000
From: Shengyu Qu <wiagn233@outlook.com>
To: rick@andestech.com, ycliang@andestech.com, yanhong.wang@starfivetech.com,
 u-boot@lists.denx.de, jamipkettunen@gmail.com
Cc: mps@arvanta.net,
	Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v1 2/2] board: visionfive2: Fixup memory size passed to kernel
Date: Sun, 17 Sep 2023 03:36:33 +0800
Message-ID: <TY3P286MB2611B6FF6D407C87B7D661E898F5A@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230916193633.3928-1-wiagn233@outlook.com>
References: <20230916193633.3928-1-wiagn233@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TMN: [plvLMyJdPY562jXOuTCFAok5WXBjMZpy]
X-ClientProxiedBy: PS2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:300:41::19) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID: <20230916193633.3928-3-wiagn233@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYCP286MB3132:EE_
X-MS-Office365-Filtering-Correlation-Id: fe3bd457-9f55-43cb-8a40-08dbb6ec4cc4
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9XmoFiihN0bLfIuxrIYm/gcvOuYNEpLLPU/Q5vl8BVUw2MjoufFqK5DXsMRSdNPpq81Ycns+IRxZbW8XHuc32pKNBr5l6ShgVwciXR9xbjTctA+RkRUiAGK0SKAQUQKO75PH2NFbnDmoxvgeH1UxITS05h0RWxP2WQHTZ+95FSWmHCB4QcOvDHV9IUwmxgurb0FthtvW4FqVdbIf+Oa5kJXqE8B/Ew6YIys0JCKToZAqIVR0wkVwvi445qiSxk1bshVZZ+FFpeClbJ0YTMWRLA/imRHi8PajkKGLh4eQYjOtK7M5QYFpsymhq/WE64gdWiKEeT8abfl+vLeOEYNChDrNcutQxuqh7+gWnvrnGPnMl+SFAVmLlhPPEFdmvb0WvJnIqQO6QN3B05CFdAS9DWgSitGCtBwRbuoGWETdjyAN4WH0zlpbHkVVYpPB/2wcYb+GxturibMPFDVLPxdTlgiD1jg+g44d9bSjQs8twJYEqUtnYkvQ2Ts6yttEv6MrBhDGzpdh8XgyhWnZ6ePxyIF2pxerulLA97UgI1GGg5Uvttk1qyFkhLA7WWWNwntyxAtaY+CohpqKfxQR5zrOi//HvsJaPMj3+JAiaxrQdxmpJpWJ9aGImm/dcdgZfko0f/XQJv3eKNwx5BOP0PJPyGGz8xTLnKgCYof2tgExBXZUrS2LKbnhKIaMhb8x+6OjZLlU6djYnMdtRXb41ch5WG+fFwzRkL+LPQ73bXDBWJusfKq8iVrBSJIP3Kndvi+M9ubs=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ol4ybOMdFYOOHiyZ4+k4IefbGlenQF9FEG47TLbFvSdLFwraKrB6yNHgArgwPV7ilGBKm0SF07QqmBnZtIp4G+2K1DLC4AzSNeqBrvglvvec8f0DhqBweu21LCtAsPjjFw8usvc1OxuYdt6nzLqZdKCZFV7NS8keJSEoHdLq2QKpx3zU/UHxgubMcZW8VtSEJPbxVBCNG6zchqyicC5GiitVLqCd4mPADnGDfQYho+fYssRY+NR1ghGkBv3cODWxXtVxWZ5psQFuZBcZqAadVHqGXMUBxQkT4a8IeZ6yy0WT+x3eAjvaSV8iB4xSFN+Hgq/FLiZfAB8XG7FtZ+Ak+RlDuxLkxATKf3ilWfH0uI2ZtCVgQNS/49mQlpbWS0Wr59hP8S/piqezUg7HssFI153PoJ0V7a20HbZ4nlx73IrHln/ZRHXh+SZqME0fkxx3J17bVgS0MIkz9MP5WyY4Xb+WZTRNPs0h94TvCenqpBcm2S6f8Fw4IwRZGCKxo6aZRZtoMRMewpacdss/+qtYTOMVbhyq8Rqv8SwsdRPT3BF2FrLpl20w9tFRPizFBRwR+7KGuXhzUBPFk1onKoOQ0MV84AHutW8v9akitapmBzy+vi1cfEdZ1WHpPp6g5lsB
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHVWQ0dXdFlCQWZucTFuL3k0dWlmQUVwNXZvSk5IZmtQdzcxWEREVnFTQzZT?=
 =?utf-8?B?bm9jcmRTQXZUSmdidzJkM0tRM3V0emFCVW5TbmVsRFN2eG5lWDNjcDVnQnJF?=
 =?utf-8?B?UC9FMnFGUWpqdjB6akI4azRpYUZ6cjNoa0Yxd2R6eHl2dy92eC80RDlTKzU4?=
 =?utf-8?B?bWM5MEdPelBJMmY4T0VoaXUrOC9GU0FNL1IrUU4yT1VieWtudU53Y2NMUU8x?=
 =?utf-8?B?VjVPTDlEWDlTOTlCdjZTakJYVE9VZ1pDMFNnUkhuUTIzaWMxaE5hN0lLZEFU?=
 =?utf-8?B?RTRQUkgwMXJqZmlMZDZQaWZQc0RINnY0N2JGUUdrUUJXUDZhVjFBbzBydlJQ?=
 =?utf-8?B?TDE2RndqNG8xQTRhZHpFSUdTUVNKOFFGR3dMNUFSNWJab2dIVDZkMHpMTlJG?=
 =?utf-8?B?eFNFOS9mdmI4ZTBtL2dlTHRIR01pd2ZSRVBCOTd5OVAwd21tV080Q1F2SUdI?=
 =?utf-8?B?akw0R0tPb09jQ3FEUFlPZVRRYmREV2JSSnd6TzhSNStQYVBFRVFSWGZVR2lz?=
 =?utf-8?B?K1pScjhRM0Evazk5TzRXaDEzb0x6cDJoQUFQWG1MQTdDRDVJU0VlQjBIcVpx?=
 =?utf-8?B?YWE1MXFYTU5FSzdyQURGbEs0WE1JMTM3dUpHQnhCMXNqd3ltVFdndXVyWnk4?=
 =?utf-8?B?NDlXTGhXZHQxenJ0azl4aWNwcXMwbkVxSklTSnZXekJtVVBJL2pHZXZCSE9C?=
 =?utf-8?B?eVZOYmhvZEtnWEJmTWR5SkZTLzBqN21mQVNCekJNT0ZGK3RuMEE5MEpzM3o1?=
 =?utf-8?B?L3hWbFQ3Yk9kb1FPV2d3SmFCZlduRHdJVklBQUJZSGtXbHpNUlFyY3hpZ004?=
 =?utf-8?B?bnM5OTdXZ0ZWWHVQYWsxUTRNa3UvL1Vmd1U1UlZMTWJhOWoxWGh4U0k3RnVI?=
 =?utf-8?B?dUtwQ3lockM3WmthMkVMY29CN3JvRnE3RGJYWWZUMVlhc1hBRGNjQlNCMWhv?=
 =?utf-8?B?Zkh2QmlRTXhtMVo5amN3U3BnY2MvcTFsNm9WbHV5UTdqMys0UkJXMG8rOExs?=
 =?utf-8?B?V1VQREJUZkFKQW5HU0dhRVd3aUJxNGNZOFZjVW16b2dWYUx1L0diZFBCYzVm?=
 =?utf-8?B?dDdMbUR4aENvNlN5YlVnU1dVdmdyckg3dkJkSGlRVEk2SWI2WG5iNWpBZld0?=
 =?utf-8?B?WnNBWDQ1TStwclBCSFJvbmluMFFBMDNTY0psNGtzMGE2aWZXNzhZWFc4VWcr?=
 =?utf-8?B?cnk1aFl4azFPMEJwZm5JV2hyUHFqUXU3M1BhWktMT2ZqR3B5WU5DWHZqcGE4?=
 =?utf-8?B?SzdsNmNRNk1XUnFURHJSS0Yra0RqbmdIZXpKY0pUU25DeG5DTFk5aGsxUit2?=
 =?utf-8?B?T2VyUnJCRDBwbkQwUi9naUExTExSLzdwRkpjU3YrajdhakRRYjk0bk53K2Ni?=
 =?utf-8?B?OEMrSHpJTmo0Q2lCd3NYRHhoR01Nd3F1dGVpdzVSZEczem5JVFhka3hQdWhG?=
 =?utf-8?B?MGl5c3MzYTNGUjVUVG1jMzRMRjlWZWVOWGZzWVBITGhYdlJybUVvTVI0cTR3?=
 =?utf-8?B?Zzd6eHljaGJMeDJwWmZGME1wckFuSFBVa3dHS1VhNGpoc2EzU1RBbThScWVl?=
 =?utf-8?B?bFdmbkpiVXNvT25lYzdiTW9jbVYvNlRRZXV0aC90SW02VnlYclNGQWZrckNQ?=
 =?utf-8?B?ZGNOZlVUOGZHTVY0SzFnOXVraGkzUVE9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe3bd457-9f55-43cb-8a40-08dbb6ec4cc4
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2023 19:37:02.2815 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3132
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

Use fdt_fixup_memory to make the memory size data from dtb match
the actual size.

Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
Tested-by: Milan P. Stanić <mps@arvanta.net>
---
 board/starfive/visionfive2/starfive_visionfive2.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/starfive/visionfive2/starfive_visionfive2.c
index 9847e0efdb..700b60ac74 100644
--- a/board/starfive/visionfive2/starfive_visionfive2.c
+++ b/board/starfive/visionfive2/starfive_visionfive2.c
@@ -12,7 +12,9 @@
 #include <linux/bitops.h>
 #include <asm/arch-jh7110/eeprom.h>
 #include <env.h>
+#include <fdt_support.h>
 
+DECLARE_GLOBAL_DATA_PTR;
 #define JH7110_L2_PREFETCHER_BASE_ADDR		0x2030000
 #define JH7110_L2_PREFETCHER_HART_OFFSET	0x2000
 
@@ -76,3 +78,8 @@ void *board_fdt_blob_setup(int *err)
 
 	return (ulong *)&_end;
 }
+
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	return fdt_fixup_memory(blob, 0x40000000, gd->ram_size);
+}
-- 
2.42.0

