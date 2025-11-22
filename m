Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDADCFD30D
	for <u-boot@archiver.kernel.org>; Sat, 22 Nov 2025 23:34:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 139BD83ABA;
	Sun, 23 Nov 2025 00:34:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="kEJnG5lU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E657B83B32; Sat, 22 Nov 2025 21:45:08 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazolkn190100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d200::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD97B83AB8
 for <u-boot@lists.denx.de>; Sat, 22 Nov 2025 21:45:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OUffCrqLdPBAlZLrcQmEefGmuazmyQ4r4cAkRth1S0W38bjXB9Yx+B50+vm9V6Xv5gCczZm5OaCH+Ruvs1MXLEItW4hzNH37xjfn4v0lvbmPhWSDZd+LFi5xKDrju9hQfwi8uq8vXI6Zmb3SIXwol6HMBg+qtjq72xqpkIj5uO/DjTjagK9qaZBC1aJ8lrtJFuAI1MQyApKDuiZQJKYQQ/aPBj70Ts8vsNU+TjKpSykOe2guO/G4BDnSnvCjevBKMaGftuXdIsKshy6eMEe3G4R0WvGlkfaN40aWPV/ev7WZzNNcwvMotLpKPulm+pOx21elwFLYIxkmDORWz+B56w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DlYuhbrBLUFK4F4gNVM7JwLDtI8QnwDmKdkfnnR+yaE=;
 b=RGhM1Vs6pRFp5dOj4ITGDWzr7sggJGJPnsaEvft/bbOOwqCgwJHe6hiNkmeS4KlsDu5vKRcHYvK/KzIXQD/vFqtOOvVLN5/4yXlE0lLXLiZjNTc6VJIgXDZK0wPxDT6A75srsm1Hm0VTA8VsJpRKvyKU4ZgASTobBdO/olsiqPSYK18/V9qAO/Y7hZ0FR+5VNPIM9F/sgLAWrM3XTqRwOJf2k1uHjPQnJA7yOwLXI0/+Cq/4RGFBUo/MEjSEndv2K7A5uIqyS/twCswUneU+lezwE9BrACnCvEtyjxyME2vJ7PNRqiFqaJYR5cUaFFGR98NWVEW81LZ0vNuCtCszRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlYuhbrBLUFK4F4gNVM7JwLDtI8QnwDmKdkfnnR+yaE=;
 b=kEJnG5lU9cBBTsfQxlENREdaw+PWmGMxns/M1ULucfuJNxIOiICpLOOh4BY+cXsDfjbfKLojoxeDp1lzF+a1y/c4bL8HHFqPmYR+TNGKGVbGGvdfs0pKKfthZxRIjyuK5FDX8JvefqZz7O0H5WFBVzuANi4q1uWfzF3lv5WDqe4ODvAHhPJ+yrRnF7a7NCIMKwnrnRFoS4BubakZYW5CCJdnq2P5MXa+GXfqiMwxdMpBL3kSFM83ZcwvBU1Bf/PFvD3wWfIruHGVBteJeqZBD/1zQOQS80eejppmYJyfrhq/90rJzOpz3Qt4ZAaI7RO1HeVQJMhsJ8o9RvDqdj/GOA==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 GV2P194MB2448.EURP194.PROD.OUTLOOK.COM (2603:10a6:150:26e::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.15; Sat, 22 Nov 2025 20:45:05 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::116c:6a13:5362:4f58]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::116c:6a13:5362:4f58%6]) with mapi id 15.20.9343.011; Sat, 22 Nov 2025
 20:45:05 +0000
Message-ID: <BESP194MB2805F70B5836B5CE97A190F6DAD2A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Sat, 22 Nov 2025 21:45:02 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Francois Berder <fberder@outlook.fr>
Subject: [PATCH] examples: Fix checking id parameter in thread_start
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P195CA0025.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:b6::30) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <82c4cca6-09b7-475b-a790-3c46d0a092fc@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|GV2P194MB2448:EE_
X-MS-Office365-Filtering-Correlation-Id: 17f1db0f-6c95-452b-d28d-08de2a080441
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|8060799015|23021999003|15080799012|461199028|41001999006|51005399006|19110799012|6090799003|5072599009|5062599005|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K0lzbzZwQll0VVhNeXhCOE5ENms2VnVvOWoyU3pPUG1SZGFROGJmVGVFeU5J?=
 =?utf-8?B?aEVjZ2lzeVl5eFpQMDBBeXZWd2UrT3lOaFJ0ZkhwN0RFZzViWTJsckt4MVQz?=
 =?utf-8?B?bnFuM0lhZTc5SkdscEFMT3pqbXQxbUVmNDFIVGVDbUJUc3ZjWFEwN0JpYktv?=
 =?utf-8?B?T282V1ZhSlJZaTJPdmZUWEhiR2lMWCtZK3ozQjRPTmQyOFA0MTBRWHNNcWVv?=
 =?utf-8?B?Skw3UzBnL0R1MlRaZmlWeHFxN09lNCsyR1VpQndTdzhOQmNqV2lPcVlCQ3ox?=
 =?utf-8?B?NE9idlduYit3eit3OFh5dmoxS3dkWld3dDJ2ZzRsTjMwTHFhMlFxYmV6V0Iy?=
 =?utf-8?B?ZmZDZWZadmJocXpybGFMRTFiZVdjaHk2Q2twSEN4YkJ0M3QzVlBqaGZpK1Zo?=
 =?utf-8?B?akQ4UWY4OStKTkJjTlVvTWN6aWhFNEhOMW1TYmhVTjIreHpnN0NYZHI2M0Z2?=
 =?utf-8?B?NzhWbG8zc1RYckpuWEc3U3VzMnNGY0ZWRG9PZ09aS0dRTElrMXZkQkFVWFZs?=
 =?utf-8?B?aXlWSTh1L0NkSjFJVGwvbU00dHZoNHhQVnZaekZmNllHcmZlclpoWnFkQk40?=
 =?utf-8?B?ZGFXL1NhSUR0clJheFpPb0U5cnVyYmYyOFMrQTlxT3VwMEhvR25uWUsyVDl2?=
 =?utf-8?B?L0JtYUE1NHRYcU1YL3pJbklXRVhRVjdqaFFUZmdIWVlHNmV3L0FHRCtFaUZL?=
 =?utf-8?B?dE5iQzYzTlNWdVVScmVzQzU5QXpZYUJCWncvTXpPSzhFalpLMkZsTFRZc0hs?=
 =?utf-8?B?UVp3NDk5V0dTaXpIUkJacHF3U21ZMmFkSkV1ejdnMHRGbjVmK1hmTnV5azhV?=
 =?utf-8?B?THRCeC9IeGlkSmRjQlNJcE0yZXY3akRrcnByK1RaZUZpRVJVdDAzdU9MVWxw?=
 =?utf-8?B?MzRXbVNLR3hINktMVjR3Tk1pdmg1TmtOQUY1RGgxZEFtMGdSTDVsL0lJaURP?=
 =?utf-8?B?OHRhNTJZNWxxSU1CMkl5Zmx3dU1qbkJZOGhFL1VwTWpibW5HYnBOQ2l4UFFE?=
 =?utf-8?B?L2tuazBtczc2QXlqM05sQ0wrdkdYTnZiNy9nWEVyc0o3NlVBUVVGeTRpb3Ix?=
 =?utf-8?B?TWc0VzZKcDFYWEF2NUNVL1RaQVdCYnlmbllqaUZOMDVnMXhQRmVJdFhHZ0hP?=
 =?utf-8?B?Mnlrd09FeU9NZGZOcE4vcjFnbkl4WFpJdUxjTjVMZUtNOEdsYmJYRWRac1pT?=
 =?utf-8?B?THdTNURUVC9jOGFyU0RZTjJlL2tSandtM3d1bjBUWFFJd2IwU3ByMUgwVVRi?=
 =?utf-8?B?N09XTEwwYkhCUmhMbXo0WUY2YmQzdE1YYXVFZUJ0MHduZThzWjFJNEZwQmkx?=
 =?utf-8?B?OHY4Zm9UUks0SmVTLzBYdnN5NnYxQU5McEYwaDg5Nnd6elh6WGFVNjJ6aWJo?=
 =?utf-8?B?VTFqMmdBcDl4SlYxeE4yWExMTmdPUEpRZ3RITTYvMUZHUTZ0aXBoUUFkdGZu?=
 =?utf-8?B?TzRWV1NYVzJxbEpFaG9yZlhwQUxnd29IYzlvS3p2SFNqS2tUUjNYTm1BMHFN?=
 =?utf-8?B?S29TeTVzeTdYWTEvRHk0cEtycmdERHR0anNmSUduVDROTGsvY2ZKakJSVlFy?=
 =?utf-8?B?SjR0U0V1dEJFQ2VNdWU4Q25xUVRNZmNYTWptOW02Vm9xZzZub0t4cFNZL0FE?=
 =?utf-8?B?SnMzdmJNQTlEWXNhVEgrTURXMlBMc1JOcmpWV1JSeFFWUUFLMWJOM1dxWHo2?=
 =?utf-8?B?TDBGaEM2dUFEc29sbFNRdXl5djlYbENKOTg2bENYNDcwNXVQMkdCTHp3PT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3NMc3hhUk80NnA0UEpPS3F0SEdpVjhjUjZBSk5CY2pMd1doWDFZSG1OOVM1?=
 =?utf-8?B?ZTZRd0NiM3ZyZE8rZVVZcWFscWN1WEYrUWtmcVdrcFNsQzVrKy9VaGlQV3BG?=
 =?utf-8?B?ZUZNNVJNbmszRk9TSzRMZ3FweGZscTNYRWQvcGxueVF5dEpsMDBYZ3JMRWN0?=
 =?utf-8?B?ODFMZUI0b3U1REppRnFQanMxeEk5UHc5NzlTTkRMYlFabVdDWU9FZDhsVVJK?=
 =?utf-8?B?RHMzL2pMYnBxb3M1SnJhUDhuRGRDckliOWRvekpoaHFkOElrWkJxN25FanNr?=
 =?utf-8?B?NFdBU3JCanZxenJFYVV2VlJ0a0R1YjYxV2hBSGRkZGZXRUhIU1ppMFhtWnM0?=
 =?utf-8?B?dFRLbGxIdU1NME4yamFXaUZrOFRsQmhKVG1aVU52N01xd2M2V2VXWGRXVEJs?=
 =?utf-8?B?QzBpcHROQnlWOWMxaXVpMmFxQ2toUWhLNzJVcGt2OEFBa3hzZFZxNWdUNWll?=
 =?utf-8?B?TmhRV2Y1MGo3L2NtVXJOSWdUclJhKy9QSEMvTEgrTkdJTUZKRk5TSXd4Q0FR?=
 =?utf-8?B?aS9zVGIrUVRNaGcyNEVTcWhTdDVMbS9RWDc1R0d4MGV5SWRpSytjbUE5Mkdm?=
 =?utf-8?B?WkdFMWNFYjZQTVZOYndGaGxrTXo3dURBVFhxaGlNY25SUkZuNUpIazZBS0d4?=
 =?utf-8?B?QWpwME1aTHQvOE9vcEZtdjJtVDR5eTlSTkVHRWpjMUFYdUtHYXdtckhFYVFC?=
 =?utf-8?B?QWRKa2RwMG9aaU9JR2hzTG44ZW5DWFl2ZWgzT3VKdUVJdmZOTFRUYjdRKzZy?=
 =?utf-8?B?WkMxY0NLVjhoaWZSN09SUUhSUGNyVGdpcGFJMXJiSDZzMTdOMTNId3hEMjFC?=
 =?utf-8?B?N1h5U1Bhby96T2F1SnQ0K0VSK2pwT09mVUhLaENJNGkwRXh6dFpRVXlrTi9s?=
 =?utf-8?B?bEk4c0VoM3AxTEdFOHFkTDl0L2tQN0pTZFZNUlFoN1M5ZlhWMFllSnJyVG1F?=
 =?utf-8?B?SjJCaHNmRkxBUU1jam13Qk5PNTZMUDF4SUp6Y2RWSkJOOTdYMTlOTFZJbTFz?=
 =?utf-8?B?NmhLemNYOHBKYlFPWmVaTHhQeXBKdFFkOTBxU2hpRmt6S0g4a0VQRWp6ZXk2?=
 =?utf-8?B?Nnl3eG5hUWgzSGtCN25ONGFYeVFqSmJlQ2QzNml4VDIydU5qVVlGSDArTzE0?=
 =?utf-8?B?OGpXWkFGejBrRzZZN3pSS2pZTlMrdjBGOUdLTUdyRUhNZXJVNVRmRlBESHdk?=
 =?utf-8?B?S2I2M29SY1BPeGhhQ21TTXdCakhsanpnL09mbU1jOXdmK05FS3FFOHRiREJp?=
 =?utf-8?B?Y3VMZE41UHN2OW5VZHVmWCs0Z2dSdXdibEQvK3N4VVpKSjR3WWEzSnk4eHJH?=
 =?utf-8?B?NmtpcXo3dk4wRk1RU2ZGN2JQQUFtVmx0aDdraHpjUy9GVWtSR09YQkhXb0hx?=
 =?utf-8?B?cElocFBLazdhZU9ZZG5LZVhwV2d4VkxaWExqbVZsU2pudDlHcHY2SUtWZVpl?=
 =?utf-8?B?ZXdPQW1EcTQ5cFpvTDZMeUJBNzRCdjVZVDBuWG0zM1U2Nld3eVYzOUFuRjZm?=
 =?utf-8?B?dzZiVXVLR0lBMHBLaTd1VitaYmd5cWUzSUlxRWF1ZUFQemhtaDh4UWhHWFE1?=
 =?utf-8?B?OWo2R3JCMi94L25jbDVSNUdieks0Q3A4WEN5MXEvVEdtblpsWmVlWktYRXlx?=
 =?utf-8?Q?4jq7FBgd8PkBYsbFrbcaIB+K5Gz53UnbkeN6BWSBdg3A=3D?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-9bdce.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f1db0f-6c95-452b-d28d-08de2a080441
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2025 20:45:05.5154 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2P194MB2448
X-Mailman-Approved-At: Sun, 23 Nov 2025 00:34:52 +0100
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

lthreads is of size MAX_THREADS, hence id must be lower than
MAX_THREADS to avoid any potential buffer overflow in
thread_start function.

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 examples/standalone/sched.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/examples/standalone/sched.c b/examples/standalone/sched.c
index 57ae67e1a5b..64518c6890f 100644
--- a/examples/standalone/sched.c
+++ b/examples/standalone/sched.c
@@ -261,9 +261,8 @@ static void thread_launcher (void)
 static int thread_start (int id)
 {
 	PDEBUG ("thread_start: id=%d", id);
-	if (id <= MASTER_THREAD || id > MAX_THREADS) {
+	if (id <= MASTER_THREAD || id >= MAX_THREADS)
 		return RC_FAILURE;
-	}
 
 	if (lthreads[id].state != STATE_STOPPED)
 		return RC_FAILURE;
-- 
2.43.0


