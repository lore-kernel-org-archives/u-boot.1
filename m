Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EDA4CCFA18
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 13:10:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 949F483F6A;
	Tue, 11 Nov 2025 14:08:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="DMDiF9T+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FDA383B82; Tue, 11 Nov 2025 13:49:36 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazolkn190130003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54D9C83B4E
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 13:49:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fcMh8LPbmXta8puniU8jq0AU8PL9Eknxqjhi3s8ejRW2DrtFIIlEvYqNEbifLxH0tjyjuGVjbH5TV9/Uw3LZTZsZhqRvQnximx1d7TQ6sN8BhoNl95l9uCgc8wBDxrFeb5oCmJduKHe06+hWX1P+3DTT2FW2VqmxQOjeXsmgXfgtK91rKUWb7MGo21RN4wDxth1Yh+iqxuwnNu65JuB1veikwVfBRaHnXNLxD3n5PAzxVlNVOjDYPHgjBXqrUULsK9a3GyAEc16x8a7t9n2rE1D01V/e1qLlY7WFUbl3MSMrxU9KYvWGZb6CFW3SsBBwba+ARyIaH3iLVU4gb6b6GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBm3PoEU/t8g+FEhngFo/17rJ3zznMY/bOJBjZlbTQQ=;
 b=bCPz/yB0pbH+DUkPzs7dWsXd5BkUXSaczImDXg6KuLPLVOUj+EeP9aQcrwtlDZQFl4geQxDEJ0A1msEMpImDdHaY1YJq6y/Y1cqjoB6he96h0YQ6xR+66b6PHd5Q9dqpeKcDDyWtv6twQaV1km2IuaPdfzrc8QK/51rXStnidkVHYzAnsjQufl+KnQUrlhWFKr1K8+xZ56WZiPiuq77n4tYcjwzobZJ4ZrYdqqmwoGUA1YgDDzpbOXI3MzC43h1s/W6i0G0hdiELieF1DU7oxmme5oRpQGabEruoHTkaH4zm15xlykY1BCikJ5tJfDF5KUBZQih46xK1E5b96dhcaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBm3PoEU/t8g+FEhngFo/17rJ3zznMY/bOJBjZlbTQQ=;
 b=DMDiF9T+WYodQs5NiGdboFvIBHaCfHV797fcR9FzTgNL+rLd3e8sthG6+EPclc88IYTmUbKjiCLeRgeZ6Y4JLwpk/H5Q4qxYwucEV0tygHgJg4PBnGpY57h+605RPczKQb0bdnJjPgbQtqkf3dT9rbcxupVnHLybRgmRb+1YBg2rpIcHfAy/MZELYeHyBO7DFzg4ggj+CvYzBem4SJSb4mgT8TdGjwlc0UrYJk3alm9/8/Rjt/UG3MwG4ciAPykZykbuKBSHPyzTELCLhesLqXKSzTQWjUn+iIH6wtbbI9XiDHL9KHisUW6++K7tc0h/l1+qa8DzdWH6mwyj5+uM7A==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 DB8P194MB0760.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:16d::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.7; Tue, 11 Nov 2025 12:49:33 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::116c:6a13:5362:4f58]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::116c:6a13:5362:4f58%6]) with mapi id 15.20.9320.013; Tue, 11 Nov 2025
 12:49:33 +0000
Message-ID: <BESP194MB2805A8A998129AB7ABA1B929DACFA@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Tue, 11 Nov 2025 13:49:30 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Francois Berder <fberder@outlook.fr>
Subject: [PATCH] fs/erofs: Fix realloc error handling
To: u-boot@lists.denx.de
Cc: Huang Jianan <jnhuang95@gmail.com>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0097.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cf::12) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <4622cd5e-7fa6-4049-ad68-cbb0b427b411@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|DB8P194MB0760:EE_
X-MS-Office365-Filtering-Correlation-Id: e75cc1fe-4110-4501-8010-08de2120c314
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|15080799012|461199028|23021999003|19110799012|6090799003|5072599009|8060799015|5062599005|40105399003|52005399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWVDYk9pdDFPUU56YzhKZC8rMjZYMHk0dVVtZ214TE9aWEZCL3BmUklvL2xB?=
 =?utf-8?B?RDM3c1R1emFDWGFCbjA4eE1Cb2dWOXVxSjFBcy9pM25veTVOTjBrNDlQQUNr?=
 =?utf-8?B?K2EyYmd0eVdnTXQxcERMUm1LWnF5bDlSWDY4Z200UzlSa05sR05JT2F4aXpw?=
 =?utf-8?B?WVI2VTR6OVZhU0o4UVpmNjNuT3RXdGZNTCtDVEJjZnVxUDdzc2VrdFlTOTg2?=
 =?utf-8?B?bHhOMHhzWmNOK0FVcFNDWHBIYTQzdUtpOHE0K0JCVklGTExkZWpaV1RLWXlt?=
 =?utf-8?B?Z0V2UVA0K3p3Ry80SWhJVDV1d2RPUUFpcDJNT09xOVBHQVkxRThlVmxKNm1B?=
 =?utf-8?B?ZlVtckFtTVpVeXR4a2wxMTdTKzc4RFAySmpmaDFXamREcmoxQkNaejJpZHh1?=
 =?utf-8?B?TERTNG5hSDdYQ2hxUklqVEhCTkJMcTdBQVQ4ZVk4VHJieUZlMXBwRUJQTjVi?=
 =?utf-8?B?cTN6VDZ2VDV1dWNyUUJMVmoyUTJYcmRQOGNIcUx0RUZYMVlpTlpESUoxem8w?=
 =?utf-8?B?c1lvc0MraVk2Z2ozclgvdXZCOVhtS1U5RnhybTNnWVpmajd1QVQwazJjMDVE?=
 =?utf-8?B?MVdTYnl2S0FMOVFFZ1NKRTdBb1QyYlNzRVBBTjl5ckJJVjB3dEUvS2NBMTg4?=
 =?utf-8?B?c3N6SjZ3b2JlNU1TR08rSkhVc0srQ0pQdGJFVHlWS1E5MHRYbVZkcGhtYklW?=
 =?utf-8?B?Qk04QXhmRjNNczd5V2dpN1ZUNkIvQjdJa1RZc3hRRkNCRzIxZHBnTldhMTlU?=
 =?utf-8?B?NFRCK2w1MmpYb0RqVHdYZWlFWTVrUnZiSjhkSDRqdWNEaTB4V0UxQkNoc0Vi?=
 =?utf-8?B?YkN0eTRsRjJTSmEwOWhzQ0FXcXZoZUduM2tHVnVQSVJMYTJyd0ErNVh5UUd3?=
 =?utf-8?B?R2kzQVE1RHFwNzVCRDhQUmwwOVcyaklOeU1UU1huYlg1ZEtGVTIrclB3YmI5?=
 =?utf-8?B?YUl2YVdmczV0d210alhaQnB5OS9KRmJBeUNhNTlSMUtIOWExVUxrK3N4ejNz?=
 =?utf-8?B?ZDRhZS9lY3Z1Nnk3UW9DdjlPTWR5cko3c0dzOUJjWEtYQW81c2wxYnNBaG9O?=
 =?utf-8?B?K09BVm96eURueDFodldOZjN0VUF2SFVJbStpem5Dc1p5eldxbzIvWkdHMHM2?=
 =?utf-8?B?QzhEVVRTVVZ2dWRBOGZhaWZ4K1lCc3pUKzNpRW1DZXBvMzlpalFsMG1YNERk?=
 =?utf-8?B?eExmMllzZjlpbTQ1ditBem9jeXpoMVp1V2dFNFpzNURGMDVsUHJTbmFBclA5?=
 =?utf-8?B?cDVhbUJ1Wk5XcnlSWGNza0I4RlF6enJkR3VabHRHczBQRjFzOEkzVE9vTDJM?=
 =?utf-8?B?VXZvZmt1VkhLdmFTL1RQNTF1UTdjVndPZnY1L0lnVmVzdjBOVGZGL3NpZ2RG?=
 =?utf-8?B?c2ptOCtkN3VDRnJtVXFyMXEwWWdvVHR3ZDRVanJiMWRHYkY3dmZ1SEI2UVlH?=
 =?utf-8?B?S3NjYVlhOTJ1YWFoOXRpMElVNkJyYStyUmtmSjI4WmNVREVzTEtWWVpMVnJD?=
 =?utf-8?B?WDNvbWpPUWpHRys0OTlHd1JxUGxnZkZvaGxEam9BbTVlQVJmOEw5ZlkyY3F2?=
 =?utf-8?B?andvQVlVMC9yR1Ewd29xMkhpS05YLzNGY3NoRUd2cUJRVTlyUUhzNXJ5eUVx?=
 =?utf-8?Q?pgxCxRZgdWm9AMdbzpofti48ZyyVexVHJdQANpS8evlo=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWlJVnJzd1Y3aHFYbEd5NVBveFcxMEc0VWhlbFFHelQ5emtBaFZ3UVVHTkhY?=
 =?utf-8?B?bFY0T056bFlWc3A2SDk2WG9iU0EwOEtBSDJFcE93aDRDeVh1UXMvcThwMjgw?=
 =?utf-8?B?VEdDdDNNS0Q5U000anRVcUZ4WDN5VHl1M3U5V01xZXBDR3FUNFl0cThOaHN4?=
 =?utf-8?B?V2xlaWNEWjEyb0pRaVdoS21ZeTFaaDdOaFlPWlJuVzhhb0orMGhjRWptTU51?=
 =?utf-8?B?UVR1N0ZaUld1YnhrV0RNL01YektITmtGek5VbEhUMEhxdTBzYXhNcVdzQkZl?=
 =?utf-8?B?czZScUEvZEZKYm9JOUtOVFRJTldVME93UVRLditmSmcxa0pTcnplbm52UEdI?=
 =?utf-8?B?aDFjMEphQ045UlIrVWUzSHd1bDNqUEw5VnZ0VzBhVm5Jb1A0cmlHdmJ1bjJK?=
 =?utf-8?B?T0svMDZ4QmRaK1dFd1MyeENJKzVnZ0JOZHBaVUJsV2ZONXdFTVFneW9kRmtR?=
 =?utf-8?B?UGd4TUdWNXlkb1JrOWZhdmhUSDkwQjdDQXpzOGppS1lyQVowT1dvcnRQTzM4?=
 =?utf-8?B?WDFXZXEyRXZXekxSTUhxbGZ3dk1tWW56YUtRWXJJSVdldXlWZnZNaGJCR1pv?=
 =?utf-8?B?MnhjK3FyUzhqNVhhdHRrVS8yTTZiWUdzWmI4RGJ3VVNqL2RoWmFnY1YvMkQ1?=
 =?utf-8?B?SUxLeE9mNDhvY1IrN2Rxb1JES1dvcnFJaU1Dai9VZlBmMmoydTJyd0FKUFVP?=
 =?utf-8?B?RG1XeTFrNWVZTDlWNDFSNldzc2Y5ejNIMElQaWVMMEw1ZlB1b3ZCcGl3cUxH?=
 =?utf-8?B?QVFNS05HTW92WDc0QmdiOUI0UTZ1eGkvK3Y5ekY4NEpsWGhaU1ZRNW50YlpZ?=
 =?utf-8?B?VHcrdkVMTnc5WUErWHVDR3RoZ0hFRDRMSmlsSFcwL3VNNnNVYTc3Z2w1UzV6?=
 =?utf-8?B?SjNwZEdyRlRPZlFhVzhqOEtOa2dXS1UvSm9qVVc0Z3F5NURJdjY5aU82Y1Nj?=
 =?utf-8?B?MGhRN0kzdUd5cmMxVjhpeGdhcDNsM3R6Z3d2MEhnUWRkN2lyTUZNODBYUHVL?=
 =?utf-8?B?NWJiNE1oaWZyWDNUN0xacmxCZFVCMFVUVlFnOFhRbjFoenNnOG5IN0VVcWd2?=
 =?utf-8?B?a3JEWEQ4N1F2STB3VlJRTUJES0U5ZHZzWkJOZC92bEJRdkVmdVFOWTJhNmxn?=
 =?utf-8?B?Y2p3WU5kZGR3U2JVVHV6RVZCRFI2VTBiVUNKSzg3WVkva25za2ZXRFlJWmVI?=
 =?utf-8?B?Q2hFcnlVSGNtbUZGZEduOVN0dEl3NlhVSmwvSjlSV0dCNk9kZW42MEtDdmZW?=
 =?utf-8?B?YXlzL2x1aDl1WlY2RWppRE1iTzVrUkNsL2VrM2pOeXBhcTlMMVZnTG9WZnJT?=
 =?utf-8?B?b1Y0VDVSeW41TWIwNFFiUXhMR1p4eDEycUE2UkJ6WXY1anhNTlJGdk1xVStP?=
 =?utf-8?B?bm1GL3BNak9KVm9aYVNSUHExUDdwRlZFbHlkREtVSHlGQ3ZyU2JoNUo0Yy93?=
 =?utf-8?B?OUh5QU9xVVA5bWpSMXUyR3Z3NjdvMVA0dXlkT2tYMUVuNlJ1SnArb3dWRTNw?=
 =?utf-8?B?Ym9Kblk4dkhkTXRpV0VUeHgyY1FtREYya01MUExCZHJTRHU4YW5kYVlyejB6?=
 =?utf-8?B?UTBoZTJlRS9tcjEyWjVIVlNoRmd2eXFtZ2RnR3Vsei9GcERnTWYrY0xMV1FI?=
 =?utf-8?Q?AEfaCQ9pIQjlGXPh4CkciVBB7lOZRXUAZuHKRgrcAVFA=3D?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-9bdce.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e75cc1fe-4110-4501-8010-08de2120c314
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 12:49:33.1393 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P194MB0760
X-Mailman-Approved-At: Tue, 11 Nov 2025 14:08:29 +0100
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

If realloc failed, raw was not freed and thus memory
was leaked.

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 fs/erofs/data.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 95b609d8ea8..b58ec6fcc66 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -319,12 +319,15 @@ static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
 		}
 
 		if (map.m_plen > bufsize) {
+			char *tmp;
+
 			bufsize = map.m_plen;
-			raw = realloc(raw, bufsize);
-			if (!raw) {
+			tmp = realloc(raw, bufsize);
+			if (!tmp) {
 				ret = -ENOMEM;
 				break;
 			}
+			raw = tmp;
 		}
 
 		ret = z_erofs_read_one_data(inode, &map, raw,
-- 
2.43.0


