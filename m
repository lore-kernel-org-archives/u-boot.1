Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4114FF5A8BB
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 20:34:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61FFB8445A;
	Mon, 20 Apr 2026 22:34:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="aGVeh7qA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6DAA84347; Mon, 20 Apr 2026 21:15:32 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazolkn190110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d207::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D64584319
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 21:15:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=blDPfh/PO152kJb/AQZXBH1c2xxW8sMAWfNOUeFzci951lt3soCtakDP+lO9ma0T5ap/bkulu6LwalOrvCNuBi7AY3YCRE4bsWmDGNRpLpdRdqwTHLswEqKGsfNJe7OaTnymM2CT/vGOtXU5Y2zOntxi8yCQHzqg8JgfIHxCCogWUZ4pa4FBjAJWT/rgrlbvK/n3ItLyC5t5x7T8n9A9C0VENSISByoHoRwwnD8mqNYp2QdUFZt/VO+JF0eN0EUbdv9fBku0o0wAVwYSe8RURISUkmXNsvZaCz1DEjquz+Wp7XaKThgaNm6WLOpe+9fUmGtVc9TZEZQqfXYFowfYPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRT2wh4tKFKLr549tZCcbU1lLX5lPtwh5mR2YoTO/tM=;
 b=L2Wh3nTO2CERwuMMna5M2QyZoc/YWkaTQUWWabMGsDJVdyevwNJK9K4HjEna6UutrkYnrBScUixTfPVxd3uV7MHyRzHSE6Xe+dQEcC0LrZvvCrZLzDWUlNUyZlF17k7dCOrenKLpTcTIY5MHoyoLAJp+rLI6dAb9KEt3OgjoQB4/UXQBI+XGv4JuqIXFeK63mBcAko7BI7AZH9VjsXGTMiP2cWnPecmQKzrUNRHcYIbnUh2axB3Xrqv3D6QiFckwjQ098QjJsqpCCiXBt6T2aLTNQsT2d9jFy9AcE2n0/MMNcLAtuhUVbzlli0xsyM7XAMOo1FFQ+cgF9SVJkqszdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRT2wh4tKFKLr549tZCcbU1lLX5lPtwh5mR2YoTO/tM=;
 b=aGVeh7qAglOkFh/Kq5w2kkLLbWHR0iWlk5MEb1rUyKGbrTFW1uvuKwyvBIBoRWxpxrYXd5VTWA4pY+09RaCZ6ioO7kcJDeDM5FR+kWMIYO91lHG2Se7mot0sI5hQDWyicln+Jnp/lpWWl+xlop2QetfRV1z4yE8iDrp5tVLb004O5PLLu0E2p9haH3E+ytTiywMxRzt/PHr6VeHGOwttvO515TcLtCRaTHadoWz1T6z7tegVUyqR1lj5pxsdJgp6jZNN4/37g2skY+I5QRdiWHBSsJQDY/881NuSW/yYvnEubb3Ble3vR42Yupz75na6JPDmfK5qIMRsxrgKf9GH7g==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 AM0P194MB0497.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:169::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.32; Mon, 20 Apr 2026 19:15:28 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90%6]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 19:15:28 +0000
Message-ID: <BESP194MB2805334513D25E51B925F959DA2F2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Mon, 20 Apr 2026 21:15:24 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.denx.de
Cc: Anastasiia Lukianenko <vicooodin@gmail.com>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 Tom Rini <trini@konsulko.com>
From: Francois Berder <fberder@outlook.fr>
Subject: [PATCH] xen: Handle malloc failure in errmsg function
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0345.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:39a::13) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <3854f3e4-7e29-49fb-b5a4-144d25232d39@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|AM0P194MB0497:EE_
X-MS-Office365-Filtering-Correlation-Id: d5cc8c71-e692-43c5-dae4-08de9f112ec0
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|41001999006|23021999003|8060799015|15080799012|19110799012|6090799003|5072599009|37011999003|461199028|5062599005|40105399003|52005399003|440099028|3412199025|12091999003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YStTYnFPN2ZCN0NKZjZISDFOMlpvMkU2NCtmYURXS0kxRHl4K3pzcDFONlRw?=
 =?utf-8?B?ZUVNK1UzdVZFQXVvZFBGR1BpRm9aTjhTYjJ1OCtIRG40Vk5EZWpldk5TV1RR?=
 =?utf-8?B?NitnRkY2R1FIN3BUVDNSQjI2blhXMWYrNEJScU9NOFJReU9BVjJPNjdFZVM0?=
 =?utf-8?B?VmxWOW5vQ2NUTTRYNHB3MUR5RUlETXJURzkyMW9DZE9kRDhrdytZODZMRFY5?=
 =?utf-8?B?ekttOXRrYXp0ZzNNTDdPd0w3NnJpODZTUmhqaVh3MFJ4R1JQdC9oRmRVQWZZ?=
 =?utf-8?B?UUQwMng3dUtUaEdjKzJPa0tmYnJhUWx6ZlIrR0ZJMFYvblZDVjBIS1liY1k4?=
 =?utf-8?B?bmZubjJMZXRDYmdETHNGZktlWmFtd082d1VuUFZna2dFMmVQcUpBRU1YdHlk?=
 =?utf-8?B?VTJZVVE2K1BQL3BBdFpWM2c5dEpoOWU3a2lrVjhoN1NkQmJreG11dC9LR2ky?=
 =?utf-8?B?Z05aMDBFa2JGcnBya3ZWOFVJTytubDI5T05wZ2xBbjhsc2xaN09yUTVXTGQ5?=
 =?utf-8?B?RlZObG1aMHlYRWFrQjhEMU1XeHdHNVh3VVA5alVQTFkzQWVFcTJTNVdoamxw?=
 =?utf-8?B?c0sySjFjeGNleitiUm5kczlFUXpOa2EzUUo2Q3YvOXZzSThrd0FWT1F3MC9B?=
 =?utf-8?B?eXNpT3B0NGtsUUJzTjlJR2wxTi90WkVqa21ESEdvdDE3VjRUZkQ5QXNpQlY1?=
 =?utf-8?B?dTFiNlhYSC9wamE4QnJPamFGYlBJWUhtRTFzc1NrcUtyb3dWQzl2VlcrMUZm?=
 =?utf-8?B?UWE4WDA5eFNhNHV0ZDRvQnhOMlgxU2U4TXRwQkNDM1JzTnJ4dWV4Y01WUTZq?=
 =?utf-8?B?VzczSFNBOTlhOXEvenA3NlgwakFRNEhJOUVjRnZxUEpsWG9rRDJJclpLQ2w4?=
 =?utf-8?B?TjQwRGhJQlN1YXRUcm5ZS3daVGJDOHRyTzAzS1lIb2VsUWJ2UUVOVm1jWTBI?=
 =?utf-8?B?dDNxejhOUGdNOVBhRjdHQlYyVXpGRFJYZDNIMlZad3pvUVpDaHk1MXN5SUNh?=
 =?utf-8?B?YTVJSjNscVU2NEFibnQ1azVHbWpwQ0VhOWFtakswczJITys4VXl3WDEvWmE4?=
 =?utf-8?B?MW51N3MyMXgxY2Ruc1ZSUnQxWUJYcmlRRVZsdXRWdks2b01PWDk5M09HblFP?=
 =?utf-8?B?amhKUEFUdGM0WlowV1ZuaVhRVzJkU2lENWkydXpWcGJIYVJ4dnZGaTQxYjZQ?=
 =?utf-8?B?UW5hTEtaTEdzMGZQQkFQT3dDbjZWdHRFRVJKQjlEMTFtQis0V2tjaW40OUpo?=
 =?utf-8?B?STlBUTMyZTBjMVdHZytZWTduQUpqazRjZ0VudFhlYVJLZExsa2lDd3J6dStV?=
 =?utf-8?B?RFlNRUhEeUt2VmtOSzVieWJIYU9sNCtpY3dGdS9ndFUwdGJEcmZxdnoxTGxa?=
 =?utf-8?B?NmZBY09jOHRJMUg2VWNYVUhTUjBMNGZyWUNXSlhVTVNiaFZXMXpaN0pZRWJM?=
 =?utf-8?Q?jIuv6jDv?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UCtSaG8veE1NN0xESWlUaHNpeDVCWTJmUUdTdWszM2ZjTmtobmtmNTdieitO?=
 =?utf-8?B?ekJvdkNZMWMzczd6dzRuTEdHUkhmaG4xamxXVnllQVduU2svWGJyeDc2MVNY?=
 =?utf-8?B?WXlmSElYbS82ZEwyaERTYTNDWUNNSVhEVUpVeHUxVW5XamYyU1VyQjJWL2Ew?=
 =?utf-8?B?ZVBndnpnODFvc0lCSWNrSFlZaHVrRDhLQmRqV1dqdzdxbGR2c1lHQ3oreEM1?=
 =?utf-8?B?Z0Y4L09HK1ozaVU0emxIamFKMFo3Nmg2RzFWWW0wdzRicERKenJrc3FFYmVZ?=
 =?utf-8?B?WEFGOVA5ZHBrWFZnQ1BsaGtYUEtrVlhpZ3NFVThXSzJPU01YZ2JzYmFQSEJj?=
 =?utf-8?B?UEQ5MWdCQk5RUi80aHZTdFBCUDFpRDRSdmZSNjZlNFZPWkYzSVB4blVNRTB0?=
 =?utf-8?B?MnZRM0hMY203L0dSMStQNlFySGRHMm54NHMrNTAwTGRpL0kzWUdNZVllVWdC?=
 =?utf-8?B?TlNtNHVKS1lMYVo5dHlZUHFrMkNVb01xeE1JZFk2UHVSOURMZGFZemlGQWxH?=
 =?utf-8?B?d21CUXRhU2tSQ0ZwZkNadHlnb1l4MlI4YmVrUzNxT3BITXBBa2E5TGxYZHRz?=
 =?utf-8?B?UlAvZVpxT3o3OXBMbDFDSXZIbzlHYU5aM0ZNaFBkSGtXUnI0RzFQSlJJVmZp?=
 =?utf-8?B?b3NNdHBZRTVYM2JaZnlBM1Uyak4wWEdWNUw0NjNONFJuem5JTHh3emdEdVdr?=
 =?utf-8?B?dmdIaXlIOXNDNjBhMkN6TXRSNlVVdW05aGpDZ0tmdWVHME13dlhxSzVocENL?=
 =?utf-8?B?VGJGMTdjYk1TYW5QWkZyN3EwTE40V0NtZEtveDh5dlQwSko0L0RuS285TlRj?=
 =?utf-8?B?QmJ0VFd2Y2FsakNkNlR0ejlvcHlHSmJLbzlFVmo2Q0tZcGpIMnJvNnpSYzF2?=
 =?utf-8?B?ODEyaGZpQVZUMmwzVCtzVjFjRE1iR20wY05sUUViMWZNNGxJQWRzUlNIOXpQ?=
 =?utf-8?B?ai9wQW1mWUczVUZIOTczYlB3NWdJUWlVK2hHUjZWTlhxVEJCRnU1Nkdzek5H?=
 =?utf-8?B?VG5DcnZjRFRTTFpZVisxNVNDMmY3cFVEZXQvRGY3d2pkckZVNDZ4aExiUEU4?=
 =?utf-8?B?L3lyMnhIdE15b2cwTDk1b0VTbFZORWo1UzNLNUVmeDhMTi83MGkvK0ErczFB?=
 =?utf-8?B?bEhYUWZUMHdHTG5zZDh1cTBHRk9pUmFrU1BLMmFkZzJSUS9lOTlXdWRJYXVq?=
 =?utf-8?B?bjkwcGJlREdmR0xsanFlVy9ObDMrQjZFK3FPSWdWTC9KRW85eUhBbDhIVmIr?=
 =?utf-8?B?R0NqbWx5eXcrOGdMZDR1TzJ2cVFoWTFic0F5OGVWQkNQazV0L0txUGo5Vmkv?=
 =?utf-8?B?bFNjZGdDNVZmU091RzcrakZ1SGdYVmR2ek4xY3dpcnZWczhmQlN0YTFrMDZM?=
 =?utf-8?B?NWJ1NnNlYmxLS2NKbmd5dWtOamUyY3g4TGtKeWZLenJVQ1MrMUtRb1l6d1RM?=
 =?utf-8?B?RmV5OWhZOEdZUHpHUFJndEtCbmZSSEF2Rzg3SnloVXpoMFVkbDhXcGxpUkZB?=
 =?utf-8?B?YjR3TEFWSFBiRVpjTURxMVQvNCtWMGdwRnJ5TVdUZHoxVTZXUTJuNDRRRUcz?=
 =?utf-8?B?UHZUMWxPQUdmeVNYcW5FdVVFVFNTdHcwa0IySWo0Q2FqTTZIY1BOb3MvdTVx?=
 =?utf-8?B?dzdnWGFBQzlRKzgvRzNkUDBVcmE3UUJLS3NOazVxUGtESVZyR3JoSG9EZDZo?=
 =?utf-8?B?Zzl6L3BnN0VGWEIvWXA3U0NoZGxmc1NkMlF6YlppQjFCYzc0bE5Ia1RpcE1S?=
 =?utf-8?B?aFRPWUZKNnRlZVNBRm1PVGFBdGp2YW9aQ3dXd3VDRTBnTGhXVUxjc1M3S0da?=
 =?utf-8?B?OXpTS01CYXdyRUtlQ2Z4NUdCRm9jUTZyRGUyc1V4aDRhR3d2RlZpU0N0VUVI?=
 =?utf-8?Q?79bSeM+Wy9Kym?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3927c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d5cc8c71-e692-43c5-dae4-08de9f112ec0
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 19:15:28.3306 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P194MB0497
X-Mailman-Approved-At: Mon, 20 Apr 2026 22:33:40 +0200
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

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 drivers/xen/xenbus.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/xenbus.c b/drivers/xen/xenbus.c
index 36de5255099..92991e2b8f3 100644
--- a/drivers/xen/xenbus.c
+++ b/drivers/xen/xenbus.c
@@ -280,12 +280,18 @@ static char *errmsg(struct xsd_sockmsg *rep)
 	if (!rep) {
 		char msg[] = "No reply";
 		size_t len = strlen(msg) + 1;
-
-		return memcpy(malloc(len), msg, len);
+		res = malloc(len);
+		if (!res)
+			return NULL;
+		return memcpy(res, msg, len);
 	}
 	if (rep->type != XS_ERROR)
 		return NULL;
 	res = malloc(rep->len + 1);
+	if (!res) {
+		free(rep);
+		return NULL;
+	}
 	memcpy(res, rep + 1, rep->len);
 	res[rep->len] = 0;
 	free(rep);
-- 
2.43.0
