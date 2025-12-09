Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F6EDD3B7EA
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 09:28:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B18E83C62;
	Tue,  9 Dec 2025 10:26:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="QYC7tYNk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1745C83AEE; Tue,  9 Dec 2025 09:59:28 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazolkn190110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d207::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D713783885
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 09:59:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZvb/jFK4whjlQzS1fBHjiZgnhfct2e6XsK1CNvW9bUbs7JKq+YEaSq5eoalM8tOstUCMpm/9EezD202uWzfIckWF6kHVE7W3+sWqVkg3tx/zsxuQM4EVNaePLvIFr3jVz14aLpfAZTSAJy+OvU+VQAhASvx+xrmeA8yTWjpAd7j239GrS4+hqM7gSnlYhrPxiv3maTTLGepRx/X23wVk7WpleEwKdYZ5i+DjxL2r1H91tsQOsjJxqb89fQjFBBC4mUo2RMRcyCBmCnUUXAuDmvt4i/H7cb6/ENKUKBD65BBXQriXNXfzEnFDz5KMyFvDvI3zITiovwQzA20dDohDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itxSyoHM7H6+fYDQhSbR61z3P+iSPmt5Z8q7tCg2s2Y=;
 b=cgnuef8gpOjR2sH2f9VimO/kFDD7DUwjnnTjZmjouRz74Tl3xDWygZCTsycO5R0bPeldvfJTqgEiQ+Ia1+hPvgXTT99yQ1rkYjaF1KrVr8cIpD4Ih/e8+H1ThQoelx6O3Onzj1oJKYTi33z4mjZfdWnaHeaoLxAIlziKE6ijO0b+2NkDN3vL1ABrt8WneDXdEQviCOgczuxb5o6KZeCgSvh7+U074dXzwxtYxAHjf8D/ouEW9qkL+RPAVEomwZl2OI0T+0g7ymwhuJdh1X1IO2s5qIG6NFramOOSe5kVIiXTkva8GRHCAgrQAo/mBZxLweNWZAydwJG1E95+4/XbDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itxSyoHM7H6+fYDQhSbR61z3P+iSPmt5Z8q7tCg2s2Y=;
 b=QYC7tYNkAaHPNzdzI+wMaDmPCFCaq1qBB8uM6YSnEpuYG3NyY3mIqXRLb7E9UsZSbBYXLGcFYnmMMAyXdJpXpFZ9mlQaAKfcXmxlJrZKNJDwSuH/k+oiPrFzAdZ6pb+xIjHavgYWLE3rs4rEnp8+QFC2tLqkH88Auk1bUGdTSzbrf6b1EuHuN7chyRQP1DeS68VHYjLy65GTRaZSwhSDj30I+UQW4zsXO7gIy+gE6L58M0WRDpk7B264ZJppzIjjhkAwnbgAZi86utE84tmNDsTRgyfeV/QmCGZo0zl2bWUrvoQf+I5DYBOk95rhkwNQllfeJuH7uBnlhxOJMgMjWw==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 AS8P194MB2113.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:635::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.12; Tue, 9 Dec 2025 08:59:24 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::116c:6a13:5362:4f58]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::116c:6a13:5362:4f58%6]) with mapi id 15.20.9388.003; Tue, 9 Dec 2025
 08:59:24 +0000
Message-ID: <BESP194MB28057B9D4D4DD62897778E7BDAA3A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Tue, 9 Dec 2025 09:59:22 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Francois Berder <fberder@outlook.fr>
Subject: [PATCH] fs: ext4fs: Free memory while handling errors
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P189CA0053.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:53::28) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <ffd1e611-8ae2-4acf-a0bf-b1dbb15cec05@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|AS8P194MB2113:EE_
X-MS-Office365-Filtering-Correlation-Id: bb7faef5-40a4-4671-aba9-08de37013fe6
X-MS-Exchange-SLBlob-MailProps: WaIXnCbdHrPy8Gg0T1tV+ubdyTLMpos/fBlIkDsrJDpDt9LwjutqRuWy8rBn2WaWQdi0Mgt0h/emOWWi6oAdi+8RNWF7QVWzwVMLLi3UxzwzLnOhBFXums8zRJDaHAMNHkeOJgdzrslmog6XSfDbHD6aI61f/etz+b+/CYmDTGxrUJrW7dB3Mo6jp0IYvpJUB+PPBD0W7CMKKLKTBINtcFcDsFlfe98snHalQn9TljiRBV/Vckudgkm3My7SSFghwGLIotfbf6j9NebaYdLxwZ1JEgkWm3pGQBZKRFkYF5gKUw706nM5A2bo62+JTaZA0yq+FDkRQawQVskjSJDgKLn6Ti/Ox1U9GiFgoDCDfwwScztBHb2RXVMRacbbPzw1wKXMSp/75NE78RIuud1mjrsiFWRhMCAhNHh/B7vPiva8m7I+5kwcN4Z/p3FOVdawOChbocnXRpMCuyKbLgYtCS4hgID5E92cChbxrDapqpyQ+eHK+LKzvC/EA6T5M9lZCtGKHhOhkknSBLrCPo/dQOD3SQr0KNxpuChC/zKSoLeU8JzU+arvxoCuKxaiqS36t8fpaTuv+IPHjMNkU1fYGkldd1dyL0fBqtkwAh1+2Z/mm8mT4wX9uCQmeeS6GmxCvriVRAjckKsY/BV8l68Y7+pin7irY/HIoQN1hoJDJna8bQ6h8DTNrGXbZ8+cSUC3dB36x9sTAaPFZhD8+L+/S8UmN0R8MaKQtk+8WMeHiBc8znlUVzr34oRlGEQQQ6Az9rHA5hB4h70=
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|51005399006|6090799003|5062599005|5072599009|461199028|15080799012|23021999003|41001999006|8060799015|19110799012|440099028|3412199025|40105399003|19111999003|11031999003|12091999003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0lNM3Fha25UTlpwWi91azBrK3g1dUEyS1pxN3RrT3RSbUlML1R6UHFVS1VL?=
 =?utf-8?B?UGFSV25abHBaejRpVUFnL1hva2w1RERzYzFuVkpSVmVmK1NwWXFwZDAzK3RN?=
 =?utf-8?B?b293a0tGdGR2NGgyYnhXS2tFa3hUNlpRWkg0U1NXT1lubVI3Y0dJUFdPT1lU?=
 =?utf-8?B?bkZPT21RZjhiNmZYRUJBclJ1RnZFdHcvY0x3Q0xmVU1wN2xQWnNOQ2pkWjk0?=
 =?utf-8?B?c2V0b2xwdFFNclQyMjhCZ1lTYzhPd3BHZkd5dUZXalE0RVZtcGpqUFRZUTBT?=
 =?utf-8?B?aGU1aDZuK1pyNGZuZExkQkhMZGhLWWMzOW03ait0aktkd2hJVllFbU5oOVNH?=
 =?utf-8?B?N0xZUkF3UDFFL1FKdWEwcytlMmdKNmQvNTNXME1UUXNicFFBQm9ZbmJLM3kv?=
 =?utf-8?B?SVBYaXU3dHZoRzRQdjNhRk9qbWtMZGg2L2JacTFDWXZpZVlRSUJ5V2duQ2lW?=
 =?utf-8?B?ZHFIZnphUFEyb21NdkVtQlRlQTRLbE1xMFpnWm0zbjZKUzFCdEx0MXo0MEZT?=
 =?utf-8?B?S2VOSXRpdCszcXozOFRuaGdEeVI2UzNTeXBaTlRJWGovVHNBUGxPZDBBOWlm?=
 =?utf-8?B?NU5HMno5NDFaeEJ0bVIxVWplNUJmUzFONEc1QnVOM2RLVW45dW9TQUVwelRa?=
 =?utf-8?B?SHF2dzhLQkt1OHhKV2RKRzZrSFNaRzUwU0ZXSHFBczZjdGt6bW82S1NDeU1v?=
 =?utf-8?B?OXY2c2xjV3hRYUE2ZGN2VE95KzQvanJQSTlSTEdZb1pzTDVMbVZDRHR1YXZy?=
 =?utf-8?B?TGdCNU1nVm9oWXZZYXU5cGZXVVhsZ0tvSXBwZWo3RmtlNGhPWlJFVHdJZTdQ?=
 =?utf-8?B?c0RlcndhditLeDRNVzNCQTM0WUNVSUMvdlNZcnpMN0FyOHo5MVA2S1RIQzli?=
 =?utf-8?B?aGRCMUlrTzZyS3k1K0lXa0RHWEluVTdhY1pBelZxMzRNeTI2d3QzSU9QN01v?=
 =?utf-8?B?WnVvZEFrMVBFbW5DdjBGNGlkdWlsK3dYYVVpOUEvTjlFdXMrNFRZYXJCd3cw?=
 =?utf-8?B?UUM2TGlEZVJrTlVMVXBlNWQxVGFvaGkzaXdoTHd3TVc5eWZHQjdhbFBBYVpK?=
 =?utf-8?B?Y3pFR1NKR2hvdllFdzAvOUdoVU9YVGNZWUQ1UEJxeTRLeXZVbloyclZ3dFd4?=
 =?utf-8?B?bTZoNzFQczdTVnJGL1hFYi9EcGNQNm9VQ3o3a2YzM0x5eFpZdW1MNmFBN3R0?=
 =?utf-8?B?UDJlU25MVjFhem1Hdk4vTGhLalNGZ3lzSUlZS1FJNGZibXFqQUgxNnVvRktS?=
 =?utf-8?B?WHF5VWpTWVI2Y29wV0c3cTVVbG9jWGU0K0NpcGxFZ2wyVkhOMjNGamF4SURF?=
 =?utf-8?B?WVpWaVZrWWFWWDhSNVp1MSt3eUVDZ2hodkxFT1g1YWJXZTRwdkxmNHkrMnYw?=
 =?utf-8?B?TEVmazFnU2pkYTQ5UXA1WDlrNHFGa3Z6bGcrb01nYllreVd6QUVDMUVZSEc5?=
 =?utf-8?B?MEVFeFh5TEdqRlVkeXlqZUxWNG1teEdNdTU3bmVWRjlld0xnZWt0QnRBNzBR?=
 =?utf-8?B?QkRPaXViNGhZWmNWcDJWNzA4Z3FEWGg2V043aU8zNVhPTW52VGhuSHhENEJQ?=
 =?utf-8?B?b0JRMkg2RmhyUlppNDNnb0EzRG1jakxKcGRlbXFiSnppRWdON2tYTVBMODdN?=
 =?utf-8?B?ZFZxM1NLWGRHbmNGK2JNUjdFSUNUOVR0eEovckxuek1nKzNHVS9DTGlYOWRH?=
 =?utf-8?B?Y01UOGJXd0w2cFBoSnJCb1oxMGp0MVUzTEcrMzlMNWpMUDlMTS9iamVwNkNp?=
 =?utf-8?B?R1l6SDNMaUFuYVBtL2VYR25ibzBIMm1CckMxNkhDTGc3QzNrdXZGNzR3ci9y?=
 =?utf-8?Q?ZZ0x+D1HiK8xnJF2XQc+qfOW6mZSNqobNW1Nc=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTJwV3JQNGVhemh2R29oaTFsRGFIdkZ6K0lmY3V0NUxEOHQ5TzNXOUhvR3ow?=
 =?utf-8?B?TTFkQnFnSit1Znl1ZS9iS2xXNVVuL3JMcVl0TisvQ2c0TWVPemptM1NnaG1z?=
 =?utf-8?B?OXlJY2l2RkxRMnNPME16MHo4SURTMi9GaTArNVNIT21CRm0yaytINGt5c3Jt?=
 =?utf-8?B?QXVLdVdXN2JzRTFqd0p4bEhEV1Q3TFovWGdGcFR2dWRRajFuSlZJcUVIUzJJ?=
 =?utf-8?B?Uk56K3Q0dHh6UHpDWllXanNYT3ZpKzlseEYzWWppeStESHg1N3R3Z21sTCtk?=
 =?utf-8?B?a1A1eTNOZGZya1NzcWRMb3Zia2JxcjJWQ1p1NVdvWjJKMFFua1ZjY3BuSEFv?=
 =?utf-8?B?djl4TmRRdTFJRUd5RUUwWXgxVkhUek9aaVpLOUw2cHozVjIvZ25UMkcrNUNX?=
 =?utf-8?B?MU5BVmVsU2F5RnpQWVZieHk5YjErTEpoUWhJQnF6VEZaTVRqdnlXajhJSzY4?=
 =?utf-8?B?VTF5SHFsd0RjcG1ZZ0QveTVndER6TWFuMjQ0NXR5UnBTY2tJb2QyRVBpdFY5?=
 =?utf-8?B?eGpqbTVIWFA3R3U5WkhyVWtKK3crUzFSVS95VnVWQnkrbE5wd1VPdStyL3la?=
 =?utf-8?B?bUZWSGluVmIxNkJFcDZzcDIwT1k4QndHRURxenF5Ry91YjFveUNWSkhOUXoz?=
 =?utf-8?B?VkgrVW1NY3kyQUJ4dTBWVmNNZUVYcTZYSVhIMWl3MGF3d3YxdGF6blRJQ2xF?=
 =?utf-8?B?UXVjdTFTangyRGxXbEZiSUVRemtBM0VCNEV4aDhxQkNBKzhFdjVqK2tNK3Jn?=
 =?utf-8?B?MmN1MEgrUjZSRXZRY1ltMWZPcGdrTk8vSXhPSy9lbkhQczNlNlhmN0xwUlph?=
 =?utf-8?B?akVBbjlHL05yVXozbXNybzd2c29MUFhaS1FTUTJ2NFJ2VmVPcVdxc1o0NjU2?=
 =?utf-8?B?VWZaK3FVRU1FOWxNaVRwaXZYWGlxd1IzbXQyTER1SkkyZmRwQ29rMFJ6ZGwy?=
 =?utf-8?B?Q1NLUmE3MXdmYjFGMFVDVzYydk5XUDZ4dDFZMzlsdnlRUUZvbDhodDhDeGty?=
 =?utf-8?B?R21IS2k4T0h1Nk4rc2tRNmhNMkFCK0gvd1hBVytncDIydDN0WVdEUGNLMWlZ?=
 =?utf-8?B?VE12ZDNBb28wUlhNdGhQalVIL1RsYUtPNDVuTktmVGZtRGEyNWFHVC9SdEFM?=
 =?utf-8?B?am44WHhmekplVXNzcnBQa1d5a2JzSXN5MHY3ZzFtMDYvek5FamUwdHduaXlV?=
 =?utf-8?B?anZLQlRmYzZNTzJDK0QvSTVrZEE2anZjL2V3K1V2a1prUFNkczFFWktpb1hz?=
 =?utf-8?B?QU9XMlJyWWlLamo5eUtmN3NDdGhpb3drcVVIcW9oNmY3MWpRUHhKVFFTbnh5?=
 =?utf-8?B?K1d5NnZhbk1mdjBWTlpkNFVCYjBXYmU1Q2lpeDdRcTVWK3VkenNqYkd5ZHBi?=
 =?utf-8?B?SVJjeU9YNDJ5SktoMlVRKzZicllXaEpzT00wNmJOWG82TGNRRXFaSDcrY1hT?=
 =?utf-8?B?VGlDdTZtQXJYVytGYVppRW5DVml5bEJsMlMxclhPa2N0WlozQ2NqbTdxMGdr?=
 =?utf-8?B?aFZnNVhodDlRTjBHQzhOTnZ1citOZlQvcDhKdzZzZS9KaS8zR3hxUnBhRTZE?=
 =?utf-8?B?MzR3U0FlZllpS2grNHg5T0ttbEVBd3FYZXAwR2daYS8xdVYvUk1COE1jVCsy?=
 =?utf-8?Q?fOw5w7WV9kQzDHEktrlr5p79itHMwj1a5ZbdqQOCgcUA=3D?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-9bdce.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: bb7faef5-40a4-4671-aba9-08de37013fe6
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 08:59:24.2649 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P194MB2113
X-Mailman-Approved-At: Tue, 09 Dec 2025 10:26:50 +0100
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

If zalloc fails, one needs to free memory previously
allocated in the function. This commit makes sure that
we do not leak any memory.

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 fs/ext4/ext4_common.c  | 8 +++++++-
 fs/ext4/ext4_journal.c | 4 +++-
 fs/ext4/ext4_write.c   | 2 ++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ext4_common.c b/fs/ext4/ext4_common.c
index 8e6531fa3f0..f48a8ca48d3 100644
--- a/fs/ext4/ext4_common.c
+++ b/fs/ext4/ext4_common.c
@@ -727,8 +727,14 @@ static int parse_path(char **arr, char *dirname)
 	/* add each path entry after root */
 	while (token != NULL) {
 		arr[i] = zalloc(strlen(token) + 1);
-		if (!arr[i])
+		if (!arr[i]) {
+			int j;
+
+			for (j = 0; j < i; j++)
+				free(arr[j]);
+
 			return -ENOMEM;
+		}
 		memcpy(arr[i++], token, strlen(token));
 		token = strtok(NULL, "/");
 	}
diff --git a/fs/ext4/ext4_journal.c b/fs/ext4/ext4_journal.c
index 868a2c1804a..3a2e9f30c12 100644
--- a/fs/ext4/ext4_journal.c
+++ b/fs/ext4/ext4_journal.c
@@ -256,8 +256,10 @@ void ext4fs_push_revoke_blk(char *buffer)
 	}
 
 	node->content = zalloc(fs->blksz);
-	if (node->content == NULL)
+	if (!node->content) {
+		free(node);
 		return;
+	}
 	memcpy(node->content, buffer, fs->blksz);
 
 	if (first_node == true) {
diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
index 5b290f0d80d..20d4e47fd38 100644
--- a/fs/ext4/ext4_write.c
+++ b/fs/ext4/ext4_write.c
@@ -204,6 +204,7 @@ static void delete_double_indirect_block(struct ext2_inode *inode)
 	if (inode->b.blocks.double_indir_block != 0) {
 		di_buffer = zalloc(fs->blksz);
 		if (!di_buffer) {
+			free(journal_buffer);
 			printf("No memory\n");
 			return;
 		}
@@ -303,6 +304,7 @@ static void delete_triple_indirect_block(struct ext2_inode *inode)
 	if (inode->b.blocks.triple_indir_block != 0) {
 		tigp_buffer = zalloc(fs->blksz);
 		if (!tigp_buffer) {
+			free(journal_buffer);
 			printf("No memory\n");
 			return;
 		}
-- 
2.43.0

