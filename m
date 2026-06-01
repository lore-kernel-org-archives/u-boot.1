Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE2EC5DF71
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 03:54:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68C5584898;
	Tue,  2 Jun 2026 05:54:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="fs5NrO20";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A85158488B; Mon,  1 Jun 2026 15:02:31 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazolkn190130003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEBF5848D8
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 15:02:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bh88SoBz/gsuJPlAk3jtl5Ug3lx9DWd5tdRAq47K0IGMCtn39Y7RDFQG+919lslYdxWC7NXceY8GVNWGKqNN4ATIkQ/ogH8uAntCvU800Zj0yfb1aBCGdbEwoM4PUqMJsJBKpI40ND82LwFOJA6uvIw/MZTDGjA+n+21DCejhCUK2ulUN1J6R7XcKSCKa85PMUZwCiMcJhdnoYUoW3iilycNuvrO0qrTnKRUF7pSlhMihC9IVnKetYXYvuD6NDOsvwt5precrTN3GPJa9sBFnmh2n1+1p/gw8wteFBQmN0jTSVBFfisDTXIiOblt9EgSwDi91t2FCFECzRPp67nwZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5kYk7CTcKUey6lNBvYpSWrMeP0MLFhxELCAFAkRLqA=;
 b=Cb8wPb/XSrLZPT8gUnN6glOzy8QsztHX2KbiP8FHugp8W0ZRuF1mgHpJyd45Jc5Gm1oLv0+WSmYMz+fi9Et7SjfDnnVygd8PBwz7TI4iCgdSHTeTXe4CUxwfUBiAjSncHz6/RneGI0oSoMboqtgT5GlbaVFritoZnvQq9UJ3CUIeyIWgeUvEYwiGPWsQOZAxBDQjNVIH7YnD/mSRPwbYHq5zMTOe/NTcFsa6raeDz3VbOCljRzG8LxkY9raoFUG0XPGt6Br8EoLT7VOc3nSOI+04IfCd+s+Wh0NjqXM195yUQ0kJUW5LsUxvOaPM1rYHQAa95pv/Dgz/00dUZf8gQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5kYk7CTcKUey6lNBvYpSWrMeP0MLFhxELCAFAkRLqA=;
 b=fs5NrO208UAOm43Yh5w7AK5URT2ZFP9I2qmMPkRZKYLBry1DqBPx3WMNV4vZST5z/2HaXlIOWW8wbrQrfaKvPr/uj8rYGckYovsBrt1/IZbypRIdDQG+S+eYjz6pLGj37UzMy4A23qsen74ng34H3IdrkmE7EDGFM17VqLjj3ehbezp0y3K9IEhnc2La0YxGUibaCWtTgAICVG3ah3+w1KaLiXfFh1kXhxyu09j3IOzUdrDl5Q7lmXa+f9E2cl0lynZtmgERzkucRwQ1V+1AijDh21xQVE5I8A9Qltz6IQAYv0zwBs30H4NjVsEqr7CTzoIhpKuDK7AQRYCql/Pmtw==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 VE1P194MB0845.EURP194.PROD.OUTLOOK.COM (2603:10a6:800:16a::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.16; Mon, 1 Jun 2026 13:02:25 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90%3]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 13:02:25 +0000
Message-ID: <BESP194MB28050E57D668A48645AE60CFDA152@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Mon, 1 Jun 2026 15:02:23 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>
From: Francois Berder <fberder@outlook.fr>
Subject: [PATCH] xilinx: versal: Fix snprintf invalid size argument
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0182.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:344::8) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <34a67d98-429c-4c2f-accc-b057f56b48cc@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|VE1P194MB0845:EE_
X-MS-Office365-Filtering-Correlation-Id: 87cc03ed-8c60-46db-64e0-08debfde06dd
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|23021999003|8060799015|15080799012|19110799012|6090799003|5062599005|5072599009|51005399006|24021099003|37011999003|55001999006|3412199025|440099028|30101999006|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WnBZbE5QbCtBd2E3L0ZZR0VVTEJBM3pyL21WdWx1WlhPSStRNy90V2dMdkdB?=
 =?utf-8?B?NjBLRVNTSHBXQWxpTXYxUXZtK1RkM0RiLzBmNTJOQTJlRnZJQklweG9NeTh6?=
 =?utf-8?B?Qy82Qm9zS25FY3AwTUp2eGRnenpES0dOek9paGE1ZXhRTSsvU2ExQXRDZ2JX?=
 =?utf-8?B?bk9seEhQckdQL2JqK2pzazZHbHFrTUdKb1hTSTZ0cHVYTUhYaW1CdzlNai9j?=
 =?utf-8?B?MzZqSm1Land5b3hkSTdadE12SlllUVlrS05YVnZjb1ZRR3VsTThYaEwxQWVK?=
 =?utf-8?B?Y0daZjVuVnlRTEdaRlh1aksvQlpZdlNMMDhubGlkcXczcFBPcTQ0enVPKzda?=
 =?utf-8?B?RHBobFBHQWJqMHhKZGZMbUwwSm5udUp0QUZEMnNCQlBndlF0aUlscWsyOW9H?=
 =?utf-8?B?SDZCVVJ6NGJqUHlaRDR3UFQvd2lLOCtwOURXSkcrdm81OVdyNkE5WURKdStZ?=
 =?utf-8?B?M2FHWU5jNUc5MnV1Q01OMXVxWVQ0NFJKY0RCRzBzenY2RS9oYXhVR1BmQ1VC?=
 =?utf-8?B?Q0lrRXE0U2ZEaThnMCttSVNCVU9NMXJWSFdJQlF6SXVmZkZLYU1tcTRyRGFt?=
 =?utf-8?B?cWJkZFpkNEpleU12eFZuMHNMV2JUVDV6dlB0Y3IyanVFWDNzYXNTR0xNOGV6?=
 =?utf-8?B?VWREeE9yOCtHd3Brc3d3UCtjS3JyUUhEV0Ezc3poQ0lJeG1RQzdDejk5K3dt?=
 =?utf-8?B?eWJKZ0Z0WUNjakdnNjFRUG9qMXQ4b0ZpcDJrUFZzcC9GSFFybEdnZVpsSFQ5?=
 =?utf-8?B?aVovY0NveEYvaHNvZWxES0w3Nmw2RkdZaGJCWlJpMkFZT1FqNlRISDdWb3lC?=
 =?utf-8?B?Qlp3a0JPa3k4UUxIZWw2NWF6ZVZvUXdzakFERWh3VkVjRkhCQXNJVHR3QUtK?=
 =?utf-8?B?Qm02bDh6Vm9SanJuWlFFaTFobjYxS1Z5UjNrY0ZKaXloRFFiNEFSaVZQZ2w3?=
 =?utf-8?B?Mnk0VC9HckpYTUM5RktnMERhTUJ5dDhqWmNCRHp6a2JpYUtYWjNPbnJnK2wz?=
 =?utf-8?B?SHR3TllqOExnbThCNjNoWW0wNWJaZy9rNFhxVUlaVVJ4R2VPa3ErM2cvMmhK?=
 =?utf-8?B?WDdZMVE4K0tyK01meW5hcFF4MDd6aDRGaXhNOGFrcHdaTkdrU3BTWDNxSy8x?=
 =?utf-8?B?WkxoWmtYYUJLVlpaTG9Dc0lkbkkyZVVtdWZ3VXEzeHNtRDU2T2FqMkw4dXgy?=
 =?utf-8?B?dlNzK0tFRzZaVFJwenRLMjBrcFhSZzFFeEp5QnhBRkhzbzBpQ01ENm9OU3pn?=
 =?utf-8?B?SjlZdnN5ZHRDazZsQWVibkdFUEYzbWthUzVjamR0NEhacUNSQUlzZ1pvTGpH?=
 =?utf-8?B?NjFrNmRITmExaTlKT3k5T0VzZTZIbEdHK1MzTE5kZ21IMlBoVEdGS0hTT1BO?=
 =?utf-8?B?eXV6a3k4NmR0dVc0eVNHTC9lZWt2c2pZU2lrYkc2eU4xUUIvdVlWeWt0Rmxh?=
 =?utf-8?B?NHB3Uk9VMnpXN2pFSVk3NWNVdGJzNzdhRm1nbmVBPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1YwUUJIN2YxQ3Z2akhJNE1BY0RhUFlIL09POHhGM29nL0J2OEtpODNtK0I2?=
 =?utf-8?B?SmFpOG53SkZNUVBna3dvOG5ubWdyZXFjMmdhUUFYTkRHK3c3VW1kUXMxRlFU?=
 =?utf-8?B?ZFp0NWtDN0VBbjc0YjBpRlloZDhJQ1R5OXk0QVZ1cVo2bDdjdmFKcWFPSWVa?=
 =?utf-8?B?dTJKRmkzQVkyM0dtOGJXTDgzdmp2eFBCcktaVGFJS2Y5TWRJblhBUXhDcDFh?=
 =?utf-8?B?bUpidTdCRlZEdXlxdDc5Zm5ZQzdLMElSZ1AvNEVyK3Y0b3NkazU1QjdCbXRP?=
 =?utf-8?B?bjNrbW5DMW50MmF1L0ZmZ3VZcnJVeDUxdTFGRm1lWFRiaS9WTnBab1V5Y0x0?=
 =?utf-8?B?NmN3NGlWSVluQS9wL3c0RjlzbGViakFlRnZPbnFWQ3JGUHNveFNORko1aUxz?=
 =?utf-8?B?S0JGR0l0VEFtMzl1OWhodi9uWlllbUJtTWsxU2oySDd4bnVKVnVEQ05DVW9v?=
 =?utf-8?B?bjZTaHBzVVd0YVVNL3hSMEhPZ25HLzFEaVZkVkMxRmhNU2xITnM3NnBZaGxt?=
 =?utf-8?B?aElJME9uTWZNWHBIZ3dYQ3RpcHZJYisrNElKVjVzcE9sdXR1Q2thZTRTL1hJ?=
 =?utf-8?B?V3FaWGpMZWVOTzNWZGtsajhpbmpJbFE2TkNvVlZhTkVmM0ZGcDJLeW9ieGNz?=
 =?utf-8?B?dmVQZUFFbDE1aHRzZ1VlS1VyeXhxQ3AycGErNStiVFFkemVLaWxURnF5dEVm?=
 =?utf-8?B?SnNBb0Z5OFdPb1VoeWtBQzhlRHJKdWlkdGI3NHJ2UHNQd0lhMkVpTjk5cjdC?=
 =?utf-8?B?ZlVLVUErWEFvQmpuV0UxcVlhWkdWZlJib2NIRXByVVhBdXdHWmtPZDJMay9U?=
 =?utf-8?B?aXo3cEt2SDQ3VUVZSTNyak1kenp3QjNJNzBVdm1DUW85ZlVPMXRJN1JqbTBu?=
 =?utf-8?B?U0paS1V6L1hzMVM4TkYvdmRpRDlBV0c5c1RVYWFxcWpuYTlPSU80bGQwUzhI?=
 =?utf-8?B?aGNjQ1MrNXdxejQrY2pnWVFtdXRhNjEvUWZYNXF4N0x5U3A4VDhCRlBLMXQw?=
 =?utf-8?B?VjNnWEtvQ1pra05ZL0pmL3o0VkU1LzdaaGFPSFVKRkN4aThGTGErT3NHQUJk?=
 =?utf-8?B?TC8wWXhVREpESlZMK0JnSEdhb09kUkd0eHJtOW1VeXBHMG83UXZMQTZhUE05?=
 =?utf-8?B?K25SaERNSVhxekM4UlZLRmZUN3BiYjhVK3V0VGZvVk1qUUxpUnV2akJScm1t?=
 =?utf-8?B?R1ArZlV3RkFyL2NJWUdhdmFMaW1CV1lLdkF4bUI2dlhzOEZmZmhTY3hHSW0v?=
 =?utf-8?B?eGNQMWF5QnZSSnRaUU96NENveWVCUjFZUkxFanFudlBpdTZmVmVIMXljMGtV?=
 =?utf-8?B?NytPWWJsOVZYWnFtQ05IR2MwMjFrQzl2bUpoU0ZMQ1JaL1VlZWQxdVRxV0Q4?=
 =?utf-8?B?d2wwenhqdkZZdktlWW9tcDd1UFlxenFub2FYVCtEeGVVSlJWRzExTVRPUWlY?=
 =?utf-8?B?UXVHZzV1S2NzTk4xWFEybXd5L21nWHJlMXBFMDFBVWEvS2tSZXZQcVpQdHNz?=
 =?utf-8?B?RXBoOEMycXhoL3JSdTR4K2R3bC94UkN2RTJYZVJaWmJvSmk3cWpNaU9xN0FK?=
 =?utf-8?B?b1NTaW1tb2thS1RjMTF1OFZaY1BySGxoUUNMYXNSUkNkWjM3b3lldlIzTnJB?=
 =?utf-8?B?RUJqb0d6TGNrNzBudDN0b1pYeWJxM3JLTUhORjdhUXM3Ym9hTzE4a3BWeGpv?=
 =?utf-8?B?SUgxeGJoUmwrSHpzQU1lTXUrVWJDcjc0ZUgwcVc0VlVpNStUcjN1YnFGQXBC?=
 =?utf-8?B?RDRVYkhXTk4xNFNZa0tGRStqT3hGUHgzbndDN1RoU1ZZWFpmOS82ampDeTR5?=
 =?utf-8?B?Z0M5T3BIbWZPSGJHRVZnRjh2T3pWeS9yNStBcFQzVTJFdnlTTGJiZE4zNUp6?=
 =?utf-8?Q?IhOxKPz1MXikN?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3927c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 87cc03ed-8c60-46db-64e0-08debfde06dd
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 13:02:25.4555 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P194MB0845
X-Mailman-Approved-At: Tue, 02 Jun 2026 05:54:32 +0200
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

buf is an array of size DFU_ALT_BUF_LEN bytes.
It is gradually filled with data using snprintf but the
size argument to snprintf is kept at DFU_ALT_BUF_LEN,
making it possible to overflow the buffer.
Fix this bug using the correct buffer size:
DFU_ALT_BUF_LEN - len.

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 board/xilinx/versal/board.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
index 9371c30ea27..978909840b9 100644
--- a/board/xilinx/versal/board.c
+++ b/board/xilinx/versal/board.c
@@ -418,14 +418,14 @@ void configure_capsule_updates(void)
 	case SD_MODE1:
 		bootseq = mmc_get_env_dev();
 
-		len += snprintf(buf + len, DFU_ALT_BUF_LEN, "mmc %d=boot",
+		len += snprintf(buf + len, DFU_ALT_BUF_LEN - len, "mmc %d=boot",
 			       bootseq);
 
 		if (multiboot)
-			len += snprintf(buf + len, DFU_ALT_BUF_LEN,
+			len += snprintf(buf + len, DFU_ALT_BUF_LEN - len,
 					"%04d", multiboot);
 
-		len += snprintf(buf + len, DFU_ALT_BUF_LEN, ".bin fat %d 1",
+		len += snprintf(buf + len, DFU_ALT_BUF_LEN - len, ".bin fat %d 1",
 			       bootseq);
 		break;
 	case QSPI_MODE_24BIT:
@@ -438,7 +438,7 @@ void configure_capsule_updates(void)
 
 			mtd_found_part(&base, &limit);
 
-			len += snprintf(buf + len, DFU_ALT_BUF_LEN,
+			len += snprintf(buf + len, DFU_ALT_BUF_LEN - len,
 					"sf 0:0=boot.bin raw 0x%x 0x%x",
 					base, limit);
 		}
-- 
2.43.0
