Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A7ECCFA1A
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 13:10:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16B1E83FAF;
	Tue, 11 Nov 2025 14:08:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="GHLrpVXr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5186183F5B; Tue, 11 Nov 2025 11:30:25 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazolkn190110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A59A83968
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 11:30:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hj95skEmq/a2nUaJhdi4/P3Qx5yjbTx1nvPHaowwDSp1eifPlaeZ9k3ya2xH/SsM+BUfiy9L8D616U7692kCSyxorhEJwMWI2FCg1lSrM4/CumwwFh4QyGYtkjsp1L6H8Rspohy9s7uBBqUU6vbHttJOV9g0pDRgTUiCO7ud2jBUzgBQtZyyXxRk4AqsUP9Nm0MvtQzdMOgggMw0zBd5CJ0VFvGgTZSJ57HvbZNBM+spfqemJEJsR+6RY2liDIF+Cd03AQB5LuM8P8o1FIyShXCI6i5l3i39RXbNGgnJaw64Ae+oiOYhEtN9hCAAm2xPHeH3304PqLu5DO/TE8gEBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zj802AVIGKmK45ttIK7JcDIpqrZvwAQTNaBfjq8qpg=;
 b=QlSgB9YLwelPbzw515IWm2RXvnYQQayOfWPNONjWymXhxczmvATox94rLThcE/Iz6C4uxvPHwvTkCe7VbWV2sAlGXnFyrEKCJc+OXqGqaeHmYUE9uuBYOdHS+4u8WKeeqJHs+IwcXSCH0FEcgYU3AJ94Tq0KTE5B74+FnASvA5i8pYyrSPFgdESiCv2+ce668F90noc9uOZwyQYb5oxuSZWQYkVxNFg7l4eDAxMzPti5YnHTwpoPlzaCEAMwC07EMYm6Pe/OXz3Ix38b7PzZWnp299ZL+WVopR2PdocKQUDMgHKTjtau6YgBNPYT22Z8Ost9DXAFwEgZPihrYu33Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zj802AVIGKmK45ttIK7JcDIpqrZvwAQTNaBfjq8qpg=;
 b=GHLrpVXrxWjPE8bZD8XG3JKE2HAfXXrWarGOqN6qYnIEI3DpAm3ir9gAaET18omsTPv7vXihNFfXyd0IiM2lWL1liMkEYOsKPCUHyPqCmmMbApou3df1Zek4QqC9fqvdkiyYCVR5Al4CPT68QklU5LpwAPBA4Q/LsbORSWdZxY6D7oMxo4ne/LPD5a6s86Sp9QZz2ST5bnVF0KGnemKYQzSxlz1ZKB4rtV/H2XKGA267S0nppeptei9DyZGmBrTNlAKUVINr28oGWkuGmqJcZpCMhAYO6Fq5eFZP3x8ueoj/7Ql3NphlgaBvN18YGp1jIPF1FlLW+MTAdmAQw9ryPg==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 DU2P194MB2125.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:495::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.16; Tue, 11 Nov 2025 10:30:21 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::116c:6a13:5362:4f58]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::116c:6a13:5362:4f58%6]) with mapi id 15.20.9320.013; Tue, 11 Nov 2025
 10:30:21 +0000
Message-ID: <BESP194MB280527E186AFA71E91BF5295DACFA@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Tue, 11 Nov 2025 11:30:19 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Francois Berder <fberder@outlook.fr>
Subject: [PATCH v2] firmware: ti_sci: Fix memory leaks in
 devm_ti_sci_get_of_resource
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0085.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:349::11) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <35157710-074b-4990-a85c-aa9c370d5110@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|DU2P194MB2125:EE_
X-MS-Office365-Filtering-Correlation-Id: ddb20de1-dd2e-4375-175c-08de210d512a
X-MS-Exchange-SLBlob-MailProps: KW6s2gPZH1dHR8f6FiypatTHlPVRnNRVDonZCnw1iXYmT+ufY8JltJGHBPhJ4bGkzxudYFrozH8PjMI8DKMr4oOsQeEyITvyuHDoEF/7WmgVqP0DCBcUWtqTOJYQinKkTnlqdB6X+ixGuig5/LlEohOw3IlJ5/sWDylUDUujs3phtYOpYkEugQZH9CxSvCqz2axZ2caBRbt6bRJXujkwFfGhNBsfmxipBNPKDpjT4Aaepdqyl4Q6X6somVD+oN/BLppUeX4Yb/YDj2ck1Bcm18yx47sg5GmDxW3lxlCUEsg5v0Z97cToTvPjVngUeqlWk9O7ZlntyKvUKgu7dJUfuJVlRdqxoBLPgMT+AZgvmI8PbZJe1BCLeiq4b4NgacsuLzbbqFiiAUbktwMUuE24ffZdM9upG94V1WPYh8lAa4/yD0g1DCzFno1B/xocPrtNhbQJiH8T5gqRWh+Y0IhtkSzwWp7zBaidra7XtRhdSu/iqoVaNcE1zL8cdM/lddyW+VERxOFSU8NTBtpa4YQsP/6rCNAcU8frJla0t3PysuMg6PblfKXmjSpZDQZvIgjkVFMnnejPubg9uWYUBMRtz+Zduvpch+6ROn3vLINxAVWh81c8Gpq/sXE9Z+bkMF7VjNFPVZ+He9Z4bL0In0b8Lar4Mj1/lVt7EBgb03rGBgRNp2qimwNXEE6y7MsuKiTVZE2BNUFuujwMIldyjo2+RfWTyOHxJyPgMD4B2iOiYFk=
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|5072599009|5062599005|6090799003|461199028|8060799015|41001999006|19110799012|23021999003|51005399006|15080799012|3412199025|440099028|40105399003|12091999003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZERmc3o4L1JTcHFpbTc5RUMvaTJCdlE5b1IyeUNqa3UzcUc3WW8rM05zeHhw?=
 =?utf-8?B?emN4eFl4N3hUK0w1VThZdjhuTDdtUnhxWFJEUnN3SnJOSXpmQ3FRK0lmbTh1?=
 =?utf-8?B?VWlFanVtNlFITHBid2k3MGdnTWdDTE5vSitFc01TK0tidERKcWk4c1FFUDFT?=
 =?utf-8?B?UDlmdFBiUUV5OW50c3QzR2hXY2tFVkJWeURlQWgyTlJBMzJzODJ4SHRxY213?=
 =?utf-8?B?Y0JVZVdxTkh4UGxpcjRLbURZS1BUaTV1eFduN1BhaU1lUjZsRjBMbmp3N2pN?=
 =?utf-8?B?bExpNm5uVXBkaXN1TS9pK20vT25meDk0dWV2TGNQUzgzYU1pcUFLT2Izc1hs?=
 =?utf-8?B?elpoMWtKTmdybU9JUzYwSUdRekRnNTZHM0RtdWlzZTQxQnVCQW9heHNqczdS?=
 =?utf-8?B?dDhDaG43ZXAvaGgwZm1IWEhmTTdtRnNRRkp3MG9RaXA1b1h0aGN1blArSDlS?=
 =?utf-8?B?UFlhbmtWZ0FkK2VTTTUzbVdHWjdEZzhoZkJnNy9pRkc2cjR6MlM5c09aRk1K?=
 =?utf-8?B?MHBzK0JjUllZRjloU3lMUlY5MFlVcC9KL3d4SUpGS2JCTDMyRFJEeWEvdk9T?=
 =?utf-8?B?TXBHK0RSTnZMNGJTeEdBRjhOYndna1ZBYzhHanhyYlkxMmxMaURVdW5kQlEy?=
 =?utf-8?B?elYvM2RmMFBuVW5lY2tFbWRCYkJhaG5FZnZXbDVrVy9DdE9vUVZDN244VGVL?=
 =?utf-8?B?bDBCN0gxbDZYVTF0MER3Ti9TNGpkdUFGSXZWaEhZcE5YMTBRc2hmM0d5ekUz?=
 =?utf-8?B?T2xkcGxjY2R2ZUZsNWNNUXpReXhXcHYvV2d2M3pBRTRZOU1pdG82aytqWlZR?=
 =?utf-8?B?K1RzWDNaUHNzUTlWelVjL0p5Z25OZUhFMDR3Uit3STZCVHlPVDR0dHFsd0s0?=
 =?utf-8?B?SnBsSjVaOG5WY042R1VmS0w5UFlaNDQrYkt1dFpkWkxGelUxc0YwcWhDRllj?=
 =?utf-8?B?OXVKU1R4K3U1MHJBdkhBNFF1YTNCRk5VRWVKc3BmNGpsL2Y3bzZHSDhwQTFQ?=
 =?utf-8?B?dDlveE81Mm5qdjJPditwRzNBMTlMd3U4NnRrL1hhMEcyVlh4UEhGR2N0Y2V3?=
 =?utf-8?B?RHFtZmVaM1RPM294L2lpejVmWkhUMEs3ZUJkUW05QXROK0kxalRnOHQrUitX?=
 =?utf-8?B?dytCb2tJQWpYUkNWYzl1dmpPMldOSnA2TWZ2VUpMSE9lL3VTOTA5ODFOZSs4?=
 =?utf-8?B?WmlzYVhjMGhIMnFicmp4SnVqSVhGcHMyS2EybUczdnFEUVRDMmtvZlFBRGhS?=
 =?utf-8?B?dEpZMCtJajY3WjRIMVkxM3MybEloV2IrL0JLUHBUK0xDTFd4YzlpNTJlb1VC?=
 =?utf-8?B?aktYTEFxVGF2SWh2NmxpOElsKzZ6ZjUvQ2FNQXV1Q2hGL0ZDRzQ1Y1c4UjFw?=
 =?utf-8?B?TmpmVDZPUS9oYlphVWtuZzg2S1dRNk9FeXZIYTlOT1ArTm1mTzF0MnlWSjBZ?=
 =?utf-8?B?bU43NWZhZzI0YTFWc1o3UVpJOC9BN1Q3RGZ2K2p5cWJidzFUTDFQTVNRelNH?=
 =?utf-8?B?Z3JFMjVWUGRtMzlaNnZCWkM5N0wvODlET29tVDdtM3lGdG4zeEp4aUhTVS80?=
 =?utf-8?B?WDFBOUVSNEhKZHM4SzJVYnZQL09jYTdvOG1qUkgvN0xBYWRWRkYyeVVpZkxN?=
 =?utf-8?B?bHA1aEdJM0I4SU5SdllkamJWak0yTDFXMkpWTlZGVTI3SlhIZmRpOXp3SkZy?=
 =?utf-8?B?UktxdVZxL3dTVjNJZjB5VTFPT3RLSWsrZVhObEwxRE56cFBGYjd0ZTc3L0wx?=
 =?utf-8?Q?QFYcIVwjj15kcl74ZI=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1dsNGdUNXdwWTVuL01wWnhyTG9EdC9WVzcwTi83Q3NqaTdYUHJYRU9MNUpC?=
 =?utf-8?B?UjJJRSt6OVJjRzJDeWZrbERMYzRBemhYSWNVQU1ZakxYdXNmSEtHcU5OSWY5?=
 =?utf-8?B?aE9CZnlMeTlPQ2FGWjNaZVR6eWFzUWFhdDViSGdTK1pkZmtVZWN2anJJTkps?=
 =?utf-8?B?YjdLRDhCRG9Dc29uV1YwbWcrTnFhMlVXcmx1NU5uVHlqK0t0VVFvcHdZTXIw?=
 =?utf-8?B?bG5sR0FmMktqVUEzME5XV1VtakcyMHJTbm1HaHJ3NWs0dzBqcjVGbm85Y1d3?=
 =?utf-8?B?ajd2cmI1NXBzZG1oeERPaHRoMjQ2WVBiemlWTnhTczhrWm42bEx1T25iZU5J?=
 =?utf-8?B?SjF2bVR2Q0g4dVlUQ1pjSEdETmdPUVRLMjRZdS9QM1lmNjZxUWliaThxNStq?=
 =?utf-8?B?ekhkNmJYOUpIa3k3cDFEdzdNUFVmN25xMVJTdTdsUEdHTlpHM005OFplUjhx?=
 =?utf-8?B?Nld2Z1dRWmMxUXY2UGdDSk1jT3RFSXVBUjA2SENyNGFWcHMwdEc3ei80K0Rm?=
 =?utf-8?B?cW40alNmOGFUWXlySHMySzRsWjY2ZEdOUVE2OUExNmxQYlZRQ0RneWppQjY1?=
 =?utf-8?B?Y3F3Ym55MUhxT1lkNUp3OFdDVGZJQ3BJWHk4UVNXcTF4bjlrcHFJVktJTjMy?=
 =?utf-8?B?bVVYN0haRnZpbWg3TldMeTJjQ250dS9Ja0pDeWdrcS9IcHVwWXViYUIxVCts?=
 =?utf-8?B?ZTBndmtMd0ZlZ1JRNzN5elhDQ29jRGdNMGs1OFhnR0t2Mm40eFpBaEp2c2xG?=
 =?utf-8?B?ZFpUdUYzamdvSVpVQksvaFBoKzdhRGRkUjYrMmY1QWdGanhNOG04Z25iSDZI?=
 =?utf-8?B?YitBaVlJbkxkcElzc0pUc2w5akZGVVZhSGwxRCt0UzNFWEpqdjZqQ1d4WnNY?=
 =?utf-8?B?OXo1UjFZTHpXVisrRHJoUm1PK0xpSnRKQ2pseDd3R2ZLcUpqN3oyMjNmT2Vp?=
 =?utf-8?B?WlBoTUNJdUVHWkZkNjY0MCs1QWFVa09hcXEzN3VPcmJaTDM0Qm9rMzV0OUs2?=
 =?utf-8?B?U3Y3MjN0VHJFZ0xRZWQwLzhEcC9OYW50c1RUWFY5L3dZRVlFaWthZ2F3RDJ3?=
 =?utf-8?B?cm8yd2RlNS8zZndZbjhoTVJGMWdrdURSSHpab2F1RVFUdHlrWjVyQkdsRUlD?=
 =?utf-8?B?cWpxOGpVak1FYWhxZENXK3RMQTNUUWZrNUw2VmpUOHU1SllZOHZRRHVSKzBq?=
 =?utf-8?B?dlVxeXJlemZzdVBqQ1EzTUg3dEUyVDRYVUJha3RwOUxiZGlxZjdSNFgzMzVC?=
 =?utf-8?B?a2NsbWgwaGtxbzY1WXBJT1hLcDFHQk1XVG1na2M5SFlobjJxdjhHWTRmN2dX?=
 =?utf-8?B?MDZlT0hjbW9JMmJObW83ZkxLVzlCcHcvNmtGTjJRT1ZLSHFZQ1Zvb2s1SUE1?=
 =?utf-8?B?V0twRnN5UEY5T2w0MUw2VzZDVlRuaUgrbnIzWXRrZk1DakVDMU1mQmU0amZV?=
 =?utf-8?B?ZGVhR2h0N3c0RTUvYjg5dVppdkRlS1htZTJ2Vm9RdUNoNDRYcTdqMFpVOGx5?=
 =?utf-8?B?QVdZaHlmVHNONlRxa290eGd5YmtLZU0vUjJ1UlJiNmIyRHpST055NGhhaTBS?=
 =?utf-8?B?bHpUcGRVeUxSOURTVkNkVjZTSmNKVVhBY0JYeHRYaW9zUkt2eWJYWUdpZ3ZW?=
 =?utf-8?Q?OwdWyz+iroONvTQMB+KvuDj5H6X8jl23hskA2Ed43nmM=3D?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-9bdce.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb20de1-dd2e-4375-175c-08de210d512a
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 10:30:21.5984 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2P194MB2125
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

  - Fix temp memory leak
  - Free memory during error handling

v2: rebased on top of 365a7079fb918643da0f0709660a7d8ea76dd6f3

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 drivers/firmware/ti_sci.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 6f57dcfe8de..0f5e180e9e9 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -3083,23 +3083,33 @@ devm_ti_sci_get_of_resource(const struct ti_sci_handle *handle,
 	sets = dev_read_size(dev, of_prop);
 	if (sets < 0) {
 		dev_err(dev, "%s resource type ids not available\n", of_prop);
+		devm_kfree(dev, res);
 		return ERR_PTR(sets);
 	}
 	temp = devm_kmalloc(dev, sets, GFP_KERNEL);
-	if (!temp)
+	if (!temp) {
+		devm_kfree(dev, res);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	sets /= sizeof(u32);
 	res->sets = sets;
 
 	res->desc = devm_kcalloc(dev, res->sets, sizeof(*res->desc),
 				 GFP_KERNEL);
-	if (!res->desc)
+	if (!res->desc) {
+		devm_kfree(dev, temp);
+		devm_kfree(dev, res);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	ret = dev_read_u32_array(dev, of_prop, temp, res->sets);
-	if (ret)
+	if (ret) {
+		devm_kfree(dev, temp);
+		devm_kfree(dev, res->desc);
+		devm_kfree(dev, res);
 		return ERR_PTR(-EINVAL);
+	}
 
 	for (i = 0; i < res->sets; i++) {
 		resource_subtype = temp[i];
@@ -3124,14 +3134,30 @@ devm_ti_sci_get_of_resource(const struct ti_sci_handle *handle,
 		res->desc[i].res_map =
 			devm_kzalloc(dev, BITS_TO_LONGS(res->desc[i].num) *
 				     sizeof(*res->desc[i].res_map), GFP_KERNEL);
-		if (!res->desc[i].res_map)
+		if (!res->desc[i].res_map) {
+			int j;
+
+			devm_kfree(dev, temp);
+
+			for (j = 0; j < i; j++)
+				devm_kfree(dev, res->desc[j].res_map);
+
+			devm_kfree(dev, res->desc);
+			devm_kfree(dev, res);
 			return ERR_PTR(-ENOMEM);
+		}
 	}
 
 	devm_kfree(dev, temp);
 	if (valid_set)
 		return res;
 
+	for (i = 0; i < res->sets; i++)
+		devm_kfree(dev, res->desc[i].res_map);
+
+	devm_kfree(dev, res->desc);
+	devm_kfree(dev, res);
+
 	return ERR_PTR(-EINVAL);
 }
 
-- 
2.43.0


