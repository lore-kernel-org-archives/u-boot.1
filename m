Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F923CD37AF
	for <u-boot@archiver.kernel.org>; Sun, 10 May 2026 01:42:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5234684A66;
	Sun, 10 May 2026 03:41:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="b+CFwOiQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C17284B04; Sat,  9 May 2026 21:24:22 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazolkn190100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d200::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9226B84AFD
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 21:24:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v6FLi+mqLJK8XxVaRV7UK4UuagiPMnZI2jeanVEvRxvdylmwX8ppHqsdx7CfIW89ZQ0gYv6kf/dovoyI7oapumZRr9ncuzZ7DbLqfsRdx5bEp7AJ81X8MhOA82YL+3/7TfP7gyejLU/unPHwCT1iAAbwryjYGDTxZXpVSDZFinJfnx7RFXMaznu8xmAi7D6Mgu8RVmS+B1TnUqgmN7y4QfJVM5fw56PREvqjoPhIqLXTftlQRg5XsP/WYuEkofLfb9QhakHXWqBtalAMkfAScoCxsfqRNsDD+xb7eB7RPlfbFYm5AzvUqyzCi78/Hhd7Jdrmhx4C2AQsGdEuUp7rkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fslPS35MDOd4/y+yRH+9kZcEzeZ5uLDp3II8BNzqCsU=;
 b=A/oFn8+xi8AeOcg1VGkwV6qs2AVkouzxtBlDSTB2Yt60bkPXgVC6C09N8LvRhsSvjHnddWP8N3J9hJBXQde9C5t1W3Kw1IgMDDX0Ao1snhYfz6uWBqmAtcXQpXMnxMNwqT7ZRMaluQ4cMLRb/YFv0fkW4A4vSNYTYjVNjuYT/A3cw/gLZM9qI7xQlzdg/oQz+CDE9LtqaihUorPOtcV0UIJJ+rdhgkh7jYeGlN4n7tIn2kMHbsjgnsWzSs3duqgONMwQddu+JSsXx4qUh9JG+FQ0JBuYMnUIzvZCvSzIs89RGW17qv3v32ByDkw2l7yyQXlDAayly6SNgck6ABDDTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fslPS35MDOd4/y+yRH+9kZcEzeZ5uLDp3II8BNzqCsU=;
 b=b+CFwOiQrOuPMm04trAAdXg+WU5x3LojG8jhngZJSFf9TmbLH/Yn23iaIun6SbWQeO20LyEmUd+9lOt/Wzev0zpBK3lZOg+aQ3m3VwASX3puZbJk3Gmv2nVVCalVX3iyGodNTR86om0at36MVRF2E9TayvoKC95qk7lO3PxuUcj6G4+M0qyQEm3JOvHaqOwmFyfqY2KfV7IkQwve38JjmA5HsTd8i34X44srpnkqsVOJU+ygAt54E8/pbqDptWIMHjLB6knihgokrNkiLFp6zpS7j7tyjpPESlwaQYCNh7nF9Uf1cAueb3ClLG+jSq1lO5Qxay6NTeA8/VTQo2M2Lg==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 AS2P194MB1981.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:558::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.21; Sat, 9 May 2026 19:24:19 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90%3]) with mapi id 15.20.9891.019; Sat, 9 May 2026
 19:24:19 +0000
Message-ID: <BESP194MB280537DE60D839E3AF9E31B0DA3A2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Sat, 9 May 2026 21:24:17 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.denx.de
Cc: Mathew McBride <matt@traverse.com.au>, Tom Rini <trini@konsulko.com>
From: Francois Berder <fberder@outlook.fr>
Subject: [PATCH] board: ten64: Fix OOB read in ft_board_setup
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0202.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36d::15) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <50df0c8a-267f-450e-84d1-92861fc8e386@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|AS2P194MB1981:EE_
X-MS-Office365-Filtering-Correlation-Id: 0969bc31-b96b-41c6-641f-08deae009134
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|19110799012|37011999003|23021999003|8060799015|55001999006|24021099003|15080799012|5062599005|5072599009|6090799003|40105399003|52005399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cEJkd1duL0xoaUNNdUU4dVR3M2JwV2VYcW5OS3A3M05xT1FTYmpFNytNZzZD?=
 =?utf-8?B?eE4rQ2t2VWZ3eTBBaVRRSFlFN3BWSGNkR1FhT0M1NEZhemhRUzVQTE40WDhk?=
 =?utf-8?B?S25vZjB3L3BuQ1BFNW0wNmxPdXNJY3c2WWt5dlF0ajlrRFhTN1dNeXRkdHU2?=
 =?utf-8?B?ZlpHdWFhOWV0YUlPcmgwdlZVek9DNkVUL2E3QjBOYnA0SFcyRnJlOHV3RkZS?=
 =?utf-8?B?bXNpb1BHNzdZc0xGR3pBcGZ5VTZyeG92YmxubTcrK1hmalVJSTl1YStOMnFJ?=
 =?utf-8?B?b3VnUytzZTdlakhvOEFXd2NxVURFbjBmcFVQbjZRSi9yMEwzT1dObU9LOWJM?=
 =?utf-8?B?TE1hR21tSjhpdlFFaWQ5ZUwyc2hGWEVySHVsYURjTzhhMmFxS21rYXZzazlo?=
 =?utf-8?B?YmxqU3dDREI1TDhLL3JzVEpwMng2S2pTMzFTdFd0aUJtZEZsdzZ6SmpWTGgy?=
 =?utf-8?B?RjBlaDVLV25ycHM5dEZCbkd2SmxIRHNHRG9zSER2SlZnVTFFT3NYQnpJT3N0?=
 =?utf-8?B?OEduajNaYVNTSjFUanc2RjB0QWdDeE90d21VWFZ2cVVUZlN6cExETHZ2RUQ4?=
 =?utf-8?B?eGR5M0ZLVlZ0QlBzYksvSGtYS3J3VExUVUJEY29QWU1ySWd5L21vSWhFbUdU?=
 =?utf-8?B?WEF1dTVyUFM1R1VHdjVpQnhubXVJejh4Rk5ReEN6UTdMQ0xGTUVnUjV3ZnRm?=
 =?utf-8?B?WXBSMFcza1BDeDQ2T2o5TEQ0ZVJEbysrMzdVUmQ0akNUVVpnK1B5RmZCbVpF?=
 =?utf-8?B?TW1uNTJUVzJ0YW9IS0k3alFGSG0xQmM3bEtySy9ZNmx3ZjY1c0J3d0sxVmdh?=
 =?utf-8?B?MDN4eXpRNVp5WmZNcTVPVDRQYlM0THRybXVSVzFIN0F1QmNGRG1KZEljUmpp?=
 =?utf-8?B?WG5pK3kyZllRN1hmUCtqQm50Q3VPcTlicVV2eUdJNEJPa1M2cjBKdDFJMU5H?=
 =?utf-8?B?VmwzSW9mSk5UVEs5UFE1RmtGNnNGY0prcGEwZHd2ZXdDcmpkYW9vOFkvcWt3?=
 =?utf-8?B?M1Y3d09mZGR6R2NuRXZmb0ZOMm5uaTFESklyc1ZuOG0zTUZnV2Q2Uk83Z3dw?=
 =?utf-8?B?REt4bExoVzBKSUxzSnN4dEtMbTA5Zk1aQXhRelNZZnkxSVJ3aVlzWDRicUhi?=
 =?utf-8?B?Z0pJSnBUYjBOMG00NzQ3aFhUcXJzci9TZzRBVnAxNy9Ob3NBK3FwSW4xQjhx?=
 =?utf-8?B?czVBMzFuTW9udGFxbDdvMWdwb3JOOWd2OEkrVFFjOTNnTzlmQVlvMW1aZkIz?=
 =?utf-8?B?ZWlzeVN2RnBjeXlLUStHNTRVeTVsRUJXSzZicEM5RnRpNk4vVk8yd1NzbGZp?=
 =?utf-8?B?bVBGeUZhdE8rWW1GSnBaaU1SdEh4M0VnMVF0cy81K1JYVUVVMFpRMGlscS92?=
 =?utf-8?B?eW1hQml2UVJ4T2Y3V2doR2EwdkxIZmZ1dEtqSWdFM05pWXVod09pcThtNXJ2?=
 =?utf-8?Q?UhlNHTvX?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlBrWkhLdW9JOENZdkdKWFk4M1F3NEY4Wkt0V0pkdG5xcjhNN0l5eHZ0R0FR?=
 =?utf-8?B?WWN0SW4wUWZBeEVweEs0TDk2MHhZb3FNNEFqNk4yU3lZWGNoVUM0am44Nk9s?=
 =?utf-8?B?ZEJZakU5c3owUGxham1xUWJYSXErbjhRYVN2emRieGF2WkhrdlUwSkV0K2s5?=
 =?utf-8?B?YnZQMDF5cTlaKzlWK1ZCenNuQ3VIOXBMc2Zpc3JFbVJVdVFxTC9uejJtbkpk?=
 =?utf-8?B?TGNkSmkwOWlSY2xXNndjYjliRkdLTVVab3lsWDlpS3BYNlY1SnNuZS9ORkVH?=
 =?utf-8?B?VmdDVXJSQlNaUksybmlVcE10a1FEaDNGQmcxSkR3T3g3UTcwTVIwZHNYUURG?=
 =?utf-8?B?Vld2USsxbFlpOTJGVk12K3ArcC9XWjE2UHJreFZlTForWWZTY21PYXZZVG9u?=
 =?utf-8?B?dTZzRXFoUExVdGloM0p5My9TeE1QZUdvM083bG8vNCtRL05sdnZhelZUK0pT?=
 =?utf-8?B?VThzK3grZnh5SXpNWlkweEhRMUYvL3N3YnVlRTg4STVTOEVKWkl0U0taUVBz?=
 =?utf-8?B?TzJ2bEd6NnpCNGZhdmNsK0duajdIUjdEcUY5NWRPWXBHMjU1QUJxUWFGTHNI?=
 =?utf-8?B?bzBESG1hZDVuekZ6aXNubTRhaEpCVG9NWnlnb2hHYXZ2cHBmbkE0SXF6OUxY?=
 =?utf-8?B?MjFXRkhFYlRObWhrd25lTHVUWDJJWVFhZXltSDFTWDJySXJoYTB5eE1PS05Y?=
 =?utf-8?B?TWZIdTBmS1BkVU9SRTFsMGJoNllDRFlHQWk2RUJmYUh3MzBsOUhsbzFnM0Yr?=
 =?utf-8?B?dk1YM0NXaGk1Zm5Xc3lJbEdRbXRtVnNPS04wQzdLdHRwSnJXSngwVlJlK21t?=
 =?utf-8?B?VEZYcU5sbVdpWnRTUGZ2Qk9YNEMrZXpIZ3ZyN01lWkxKb3lnSFN4TllLNHZt?=
 =?utf-8?B?aVNacmYvS01kV3U4UXo0R01KcTVaMStaUXFHMFdBRmNrSkF6c3FjTHdUOFpw?=
 =?utf-8?B?MmdvUUhab3NIZzJiTndBRFlHN1E4VHJkajZaQ0ZMQTlsY1pSeDRJOGt2VVB3?=
 =?utf-8?B?NU1kQng0QzhKaFFIeDd4QXRPR3BYeVRUVDNMUU12QlRkNExiL1RtU0dRUlVr?=
 =?utf-8?B?TzNIbnJPT3lJbzdLb24wK3BKZS9lWWJzYS9TVkQ2R0RRcUltdFVaUEtMMjh5?=
 =?utf-8?B?Rko0TGxaZGRnb2tHdDA1QVNxcWhSMVBMdzZIWkpEaVV4M2svWTk5WjhCWWVW?=
 =?utf-8?B?ZWJtdHpjTkFWdVh0RGpNTlkxZCtKSVFEdjU2VnFYOVYwajVOTUZ6dXRRNk1N?=
 =?utf-8?B?NGJSM3dWUjVBem5qVzgrbnVNenZGNXhrT3owQjZHaVlDeGVXVFBzVmFLbXdj?=
 =?utf-8?B?SFJBOG1kRU1MdWFES2tLbUo2QzkybmcvVEJzWkdQTVlQN3BjS0J4cEFESk1j?=
 =?utf-8?B?UjJJaGpJRXFTK1JJQks3VGkyYkx2RlhkdUQzTWlzSmNQdWV6SWZnUGg2S3ox?=
 =?utf-8?B?WlIyVkRuTHpBUzlJRUozWUIzMVFRU2lhOUhXZGVOQXE4N2FqSkh3d0pZVDRC?=
 =?utf-8?B?M0JpczVZN3NVVVdqM0pLSGtnc21PclhoLzJidEl5ZE1zQjFHeTBLZU54b1Vv?=
 =?utf-8?B?Q3VxNGRUS1pTdlh5elZYTGZRbnFBSTcwSHJsOGxmMld1U3kyYWxFdEdXQUJ3?=
 =?utf-8?B?cnlrbGozWlJDbjlHeVE2NDg0ZE55RXlITkdENXJNeURlRnJEV3BmV2pqUlhF?=
 =?utf-8?B?L3dMUVJmL25hQnZCZlRRYWxRNUV1V2M2SE5pUGtJSkJNb0hGVDZNMGdCS3J0?=
 =?utf-8?B?SUpycVRReTVKSUxUTDBBZThBdkJpWERmd01mTGJ5dVVNN1c0WktUdzRKS0NB?=
 =?utf-8?B?ZkhjT2t5VThUZ2szVkhzQ1pMWk5QL3FRdTNiTXVNOTgybkVTSWt4TVNWc2I5?=
 =?utf-8?Q?dPCJeiAMe3Pmx?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3927c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0969bc31-b96b-41c6-641f-08deae009134
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 19:24:19.4147 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P194MB1981
X-Mailman-Approved-At: Sun, 10 May 2026 03:41:44 +0200
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

base and size arrays can both contain up to total_memory_banks
elements.
This commit fixes the for loop condition to ensure that it does
not attempt to read past the end of both arrays.

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 board/traverse/ten64/ten64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/traverse/ten64/ten64.c b/board/traverse/ten64/ten64.c
index 5941ed11a60..ac8c9a9a81a 100644
--- a/board/traverse/ten64/ten64.c
+++ b/board/traverse/ten64/ten64.c
@@ -285,7 +285,7 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	}
 
 	if (mc_memory_base != 0) {
-		for (i = 0; i <= total_memory_banks; i++) {
+		for (i = 0; i < total_memory_banks; i++) {
 			if (base[i] == 0 && size[i] == 0) {
 				base[i] = mc_memory_base;
 				size[i] = mc_memory_size;
-- 
2.43.0
