Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17648CD3445
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 00:43:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3272484E53;
	Sat,  9 May 2026 02:40:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="cjPW55UQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A418184D02; Fri,  8 May 2026 22:11:41 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazolkn190130003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0A9583A41
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 22:11:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=or2fq9K2a/MQ0bN0rP5Trt5cFKaLO1bX3QyPV2GvojU6EXwaxewws8HSHkIJHDHCBG724eZ3xt+PtYRo/i8tgSXlL+6RxQua22LRiT+EHnYINS/ieiqHn8MLBXB2uokS9BUvOzroo4N1vwvkj5AJiYJtMhXNst30DzZIFMGMufVllEjiORv08rOA8eIzGraTL2V/le+vfiWZNed2Ao+8hfFBO8DRTGX7GG1MuBjaXcnMOr+/g4Uu3eyTM6Hx84ZkrIurk3GOp8Tn8d++7jMFhIJ99DJwxA9cH5m2osAb/w9Ns1/eRK/xo048oVjv1d/xZ+2ncLZS69PX4BZ5jmlX1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnE0Jqj+CgmA4RfVs+6UPq6VKBgyuxpSYjO9hv6JG6U=;
 b=nIrKU+rH1BOZOM1DPmPGiKyrtIC+KjwRnRcLRBXan17sOZnGF7RSoDpQFeMVScNnugY9hbP+3ahM7ji3NcR8xaPdhYTNcq8D3gNjsdEQLpJ3bePrfYqvu0ULl9kUYzWlzaRZwCxKoImp8UahRM2bhpYvSOCwiu3veIsqlWF+BM6M/SsNmnHarR/3iuM4F2bIvAIREnOpWtcn+c3GkG94oB0++1Xsh7yAAMkPn0ylDgx9F2Yc+Lq8UtyMZ4+OLTaElKDTKPU3Z1SoUNzhlyOAp1sP5ve7BwFfy6z/v44KNivbOjnMNBIBpw1KSNDByhjVMmUePMmKLd5fI2TywyljIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnE0Jqj+CgmA4RfVs+6UPq6VKBgyuxpSYjO9hv6JG6U=;
 b=cjPW55UQNR4dK2AKSZiRZDwhoD4D5WjgzjThkLZHHfyAi11DraSv3LaKwvQ78/5FnHxwBcg/GAu08MJAuIfe3K4TKIAOvUKSl3DWlLFpqyd/+kpPrEqIRcRPDcdBG3qlbpeXWui7EsfldReFdNO6+73CtWC0klW0bu4bigqExaSHi38F8ZSdKOmWpC07IaN8wavKo/EbuR42Mu9y1x+FMf6dDK+tVV6ysxjpfGtustsusF75NE+DkewZNhB9wLpgem5374jcK3/geuo+MOd8teySE77d8akds9E33Voi3XPAEkBqv63R5iQNJLY6SWctlHivqgNHE9/9fEaxDuTvxA==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 DB9P194MB1338.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:269::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.19; Fri, 8 May 2026 20:11:38 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90%3]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 20:11:38 +0000
Message-ID: <BESP194MB28053780A7CD5E47FA0FDA72DA3D2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Fri, 8 May 2026 22:11:35 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
From: Francois Berder <fberder@outlook.fr>
Subject: [PATCH] power: regulator: pfuze100: Fix unchecked pmic_reg_read,
 return value
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0202.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36d::15) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <6977f1db-b427-48d3-b3fc-c9ef18438bf4@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|DB9P194MB1338:EE_
X-MS-Office365-Filtering-Correlation-Id: aca2bf01-53f0-4d85-da62-08dead3e02f6
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|12121999013|41001999006|37011999003|15080799012|19110799012|23021999003|8060799015|5062599005|6090799003|5072599009|24021099003|3412199025|440099028|52005399003|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SDQ1MlZxRHV4RC9GRDZtQXVBaUFQOEFqamVQRTMzdHFqN2gwWmhLUmNuUGxl?=
 =?utf-8?B?cFc4aVpTNGlkRlFnMDJ2MWpWVExHRWJsa25HVmQxRldwRFpDbkZJNXZVU1I0?=
 =?utf-8?B?b0d3TGNBUm9BQzB0c1BKS2RmUHMwTlJxL3UwNm5HQkZFMWdqeHBCUnZkRWk0?=
 =?utf-8?B?MnVndDlhZVJ5WDV4WkNKK0ZUM2NzQklpeW9vdUxYaE5MbnBYaElEUHlkekFW?=
 =?utf-8?B?ZHR0MGhHYWxtSlE0dEdYb1A0aTlJblZQUlk3YVVJTG1oL1FMeUhtV2l1ZjZF?=
 =?utf-8?B?VTdZR0xtUkcyem5HNVI1UVYvNlV6RkhybklQdkJFVkVtY09BODNmTG0ydUxj?=
 =?utf-8?B?UDlPOGNjSmUwRy91MEZNekNVbDloLy9pQXhBMjFWUUs4MFVBckdJYTQvMTNv?=
 =?utf-8?B?b0MvaDl5TTgzWUxYTkI1dmVTRU93eEZmYWIzOXBlLzkzcmVZdUlISmlnRXVx?=
 =?utf-8?B?SXVYc2FqZ3hyNVBReHQ4WURTVVVtNXNtRnQwTnB4K3drWmtJMlJDdmU0MG5n?=
 =?utf-8?B?S042YXpvaTBzTEQyQzlualhoWGlzS0xxaHJXb1FlMkFJTSt5N2tEZDF6bHN0?=
 =?utf-8?B?YUxZTmN2VDBHc0wwczVoa2NPdTcyZXBoczBKaU9pZyt3MTA5aGdQZVBrRTd5?=
 =?utf-8?B?cm9xWVV5TFliblJabndMT1E5ZGZJYzF5Vkp5NjNDNytydWFMU0l6dkVCd3hY?=
 =?utf-8?B?bzBJL2pheHVCTHRHWmdaKy9LUzgrV1E0dlZTbGZNYTUzNUxoZC84ZHdTajFW?=
 =?utf-8?B?OUZuU1FVRTFqZmtiUTZneEVndVBoek5OWWIwL1k2ckRrQWVUTHVtRXU0dHVN?=
 =?utf-8?B?T0hvQTlMaGoybHRuSUtXNS9iUTIxL0M0SktESXQ2enFVZ3lZeFZSOFo1S2Er?=
 =?utf-8?B?b2pQeUVBd3d0SjBWUlR6R0VNajNYSStGQXVqSVJrNkNSbVJYUGZISlVXdnVr?=
 =?utf-8?B?QnJjQTVRb1g2SXR2TnE3alRKcUdnR1ZDNnJDbDh2L2FXZVhZaHI5a0xMejI5?=
 =?utf-8?B?Y25YQkIrbmFmR3ByUituRHRtalVZU3l0emNIZHJWOGUxcVdGK2NMWTN1TDgy?=
 =?utf-8?B?cWV0TS9Zbi93ZFBtTXN6K04xbzg3c1hNQzZGdkZVUnM2ZWdRN090aGVoWG84?=
 =?utf-8?B?TVQxZmhmek5Ia0ZpMnFORHFhdXVwNE9ub2xzcGdWWjhDbUpnSEg5YVBxQzBX?=
 =?utf-8?B?djlBaHZYQkNjNFo2T21PVWlmUDhpYWUwNy8xb0NjMXMrZUE4YWNPYjZjRDQr?=
 =?utf-8?B?d0R6ODlJRGIvSTVxd3lqN3IrUFoxdlVHdjhLOG5LbXI4d1J1dGpncnRiNTN1?=
 =?utf-8?B?Yi9CWlNubXNHVG9oSHlaT0YrdFdqdVNrMVhaV3hVaWFvcC9SaFJuWWh6WTIr?=
 =?utf-8?B?RUUvNGlKV2ZLK29tMm4wMldsbnE0eUFPRDlGWjdBSGExc1Aza2JNOUJNaC9m?=
 =?utf-8?B?KzFkOC9QeXhQOXNTYnRtTFQ2TWNJSGxXNmdyVWNnPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qmk0V0wvQ3Z3WHRBbTQwbSthMFdTeWhiaDhIWDBQbjNGNnVTbnFmRkhYL1pD?=
 =?utf-8?B?bGg1Q1JiUUwwTlJIbVhxNkRvbzhlaE5UcVZjYmZaY3V2QUVYNVpHc1lNeFRa?=
 =?utf-8?B?d1VONXR0U2Z3VGxBMjgrSXc3cEhwa1NFcWwxSk9GTG5qRVBrQWwzNXlSN0NB?=
 =?utf-8?B?Mm9PNEI3Q2NqOFo1VnpCS0NpQlBjcTBPS3ZDUkpnMmlXaEZSdHJXS2VwMUxV?=
 =?utf-8?B?L1JMbXJXWGovVXFQZnI3NXVIMWJiaCtwWkIvc2dmMlNGRVhIOVJ4S0NxWExD?=
 =?utf-8?B?cXpXVEgwMC94b21MZmhNNklWSXljZXhJaTBTUHlzMEFtU3BaaDNwaDNyNmFB?=
 =?utf-8?B?eHoyQmxPRWl2NGhjZmNaSzR1MWc5VHN6SnpNN1A4QmU1U1Q2U0V1TnJHVW5N?=
 =?utf-8?B?UmdwcTcrNWowS2R2SC9WT25TbE9Ucy9xNy9DRHBQSW9ZaW5OV3l2KytpT3Zj?=
 =?utf-8?B?bUlwRHI5RVRkOHM2cHpEbHhTTEpSWTI0TDZWWGQrZkViVmd1aUxFVGZxZ1RD?=
 =?utf-8?B?c3pkL2pYK1ZSck5mRDNrQVVNVlZjVG5qbTFSdE5VY2FCMjlCQjdKbjNlM0lE?=
 =?utf-8?B?TEVraVFHMUJqK2ovRCtnR3JTRC9pNm94Wk5xby9tQ3M5RHBEVm9VVDI1Zyt0?=
 =?utf-8?B?dm5mUGZFNndQdzJQalpQUUgwaGpOdDVOeFh6bVZIZkJ5Q0paV2lWT1luSmpT?=
 =?utf-8?B?WkVxRWIvUnEzdGsyT3NpS3lqaWhDZC9welV0cGJyN1JqTzBkN3RLalhIaTZq?=
 =?utf-8?B?U1JOSFpxei8vQ2h6dlNvNkFSSUVaVjBzeStRUlJ6VkFrdC8wVGtTZ01KanN6?=
 =?utf-8?B?eWdvUWhJclhBY0FnRlZHY1hpdWtnbEoyTlNjTVVTc2IvUEJhN0Y5Wmw3b2hD?=
 =?utf-8?B?K0FjTWtnNkpnT21raDBZNUtCckc0YSszQjk2UEtic0JBdnpMMXVyMDFPcERW?=
 =?utf-8?B?UWE3eWNUbnRUQ1RBTEVHMWFHc0xyYUlsbUZaRlJGT1Bsd2RlQkhkcngxQU93?=
 =?utf-8?B?eWxINEI2RmZkSTZEdVdtbHdGdVBtZVFtYUdHRmtsRWEvOWZlbEZ3NVVTZDhL?=
 =?utf-8?B?OTEwUzA2NFhRejYvMW1PVGYvaC96UjdQYTNXSUgzR2NQdWN1RGIrRCszaUJv?=
 =?utf-8?B?eHZvZ3VrSU5GdWNLMGYycTF1dERVUSt3OU50bzR0M3JodytqOEZDVlAwMTNG?=
 =?utf-8?B?c2dLRDVJZWc0NDZUT3BwMWpKMnpTR1hsUDFtQ1p2b2d5RmlLS1c1Q2hrcDZJ?=
 =?utf-8?B?WHRrNkxXamY2NU1yRE5YbVh4T29YQkh1amFIdXpaM0NQOS9JQ1BoMWUySU9q?=
 =?utf-8?B?aUlZRDNUREJFNGhHcUpkc1BnR2NoR2NneUovZWI5ck5EbWJ4Q0JHQ1BhTmVq?=
 =?utf-8?B?VWpKN2M4K25wSXR2K21BY1NnbjlhN0xlSjUwM3Nxa0c0N1FUeEdVeFR4OFVL?=
 =?utf-8?B?UFVyQk83MkdnTGhuamJiYXdtWjlEN1dqMjN2dzJEN3E3ZXNsYTJDVzBIMEVX?=
 =?utf-8?B?eC9GK3pLeElaL2w1U2V2MnRPMGFrajIrdzV4aHMzRkZUQ3BPMCtWQ1RPN0to?=
 =?utf-8?B?ZkhzOTd5ZDlKM1ArTTVnOEtHbUxMRFdLckh3UXFBMHFkcmxJYVdNdUZOeFJi?=
 =?utf-8?B?NkhWN1hxQ29CV0VBTWVzU0VGQ2hWcGUwc1ZiQjdxclQ0WGpsbHhWT24wRU8y?=
 =?utf-8?B?bTFYUUkvK01DcFFFQW9kdzZjNDI1VDZBVkk4ckRDL0JsQWxkeWdUZDZkbXRZ?=
 =?utf-8?B?SXkzaU1DQ0NVUnNrU1dOMW9sSWE1SlZUN0lvQjBHNGFwVzl0K1V2K1U5Vi9W?=
 =?utf-8?B?Y2g0dUtyb0V4TzdhNEdFWmFUek5lNkRlcFZQNld5citmdlgvTUVjTXFMQVFv?=
 =?utf-8?Q?lAb1ES6I1rI1K?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3927c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: aca2bf01-53f0-4d85-da62-08dead3e02f6
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 20:11:38.5901 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P194MB1338
X-Mailman-Approved-At: Sat, 09 May 2026 02:40:31 +0200
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

pmic_reg_read returns a negative value if an error occurs. This
commit adds a missing check after calling pmic_reg_read.

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 drivers/power/regulator/pfuze100.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/regulator/pfuze100.c b/drivers/power/regulator/pfuze100.c
index 77c82a00b65..57af16cfbb9 100644
--- a/drivers/power/regulator/pfuze100.c
+++ b/drivers/power/regulator/pfuze100.c
@@ -550,6 +550,8 @@ static int pfuze100_regulator_val(struct udevice *dev, int op, int *uV)
 			return -EINVAL;
 		}
 		val = pmic_reg_read(dev->parent, desc->vsel_reg);
+		if (val < 0)
+			return val;
 		if (desc->high_volt_mask && (val & desc->high_volt_mask)) {
 			min_uV = desc->high_volt_desc->min_uV;
 			uV_step = desc->high_volt_desc->uV_step;
-- 
2.43.0
