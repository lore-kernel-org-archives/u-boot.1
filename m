Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A0FCD37AF
	for <u-boot@archiver.kernel.org>; Sun, 10 May 2026 01:41:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BFB38485D;
	Sun, 10 May 2026 03:41:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="GqKAsdwG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A02AE84CF2; Sat,  9 May 2026 19:22:47 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazolkn19010000.outbound.protection.outlook.com [52.103.33.0])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1106845C8
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 19:22:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=txxlPZ0jBcSUVkaf++tAZl/ny9OaXaCF4kc6IVBjXq40VWYubWtQygge/rC468VZx2dDCEciwl6z6mVVcHoLgX6kg+vy554letAYuv3rEHNPSXviIYY701ducDSq9RJiwmnQxRXvvsBYA63ly9nV/uU6Ov4oh4R5QN1DVhSxV6RTpsDd6Tg3WJrwUm7N17PIY3cnkRHDoYsBuIg6ollWKvpMNsirKDUJlWV4G9pWOHZ0jr5Bnv6C528SjjwVattRcXjPtJVooO0pVN5+Wwyu+MsfvyAl34N/6anKozH6fRaucG75VJqg/MxlfRS2ICbWwxm4MlI6bqpL0CevRhmJzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYAi+4JeU7fRCaBH0f/xr5Ca1AGA3nQc7IOmkrel+iA=;
 b=lhjERbt/vbAYxBeh9ljqD7HC3RInb5iUbdniD4eMFGfDxDwFdnwTMdxFJ4dgKaWCT9dGb/pgbArtl5fwWL79Y7olq21vRDTMLVMNi+99M+t74/ypoc8KttqyMVsm/gWZ5tZttu0IxbuOA0l5NEBdqs2jSL+QHYJHJuizMBC7HFF77U66ZXhXT2SQAXStliRSsH6OEU2jgbMwLHitpgO+XQ+kujsPd7usY2BdFesmy6rs9EJWtmprwXMdA+T25sYaEcHheVxb53RyRX91KNdf5cOw0vuSmqNWDMSzT64tqtehK0Try/Ai50KlwEsZBEZGzxSS4VS/0QAPf+SkCFOyLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYAi+4JeU7fRCaBH0f/xr5Ca1AGA3nQc7IOmkrel+iA=;
 b=GqKAsdwGrtlmdg2uROk5X1Q0aupDqHluQHktSsuPwWk80z0Ap/7cC/3qoHM5Tbe9U3H7qnyJedFu6/ezCiDJNjhXRZ+PPmcahEMZcz8CFCr1jNnqs5LIW1cneZmqI1vZ52bA2Sq0DatQULoT56Gb3TwFvmgjYnD2uu7s+Cymz00K5QOVryr+xjSMMtd0uIx/N/k3DWGTvXzUgOsUyarBz8paN36vIfHam5bbYaEnuZivYyzi3IUYw3Ftw7UzeT+i7sDisNuc3SmoB5UnjUWxcdRuwWjkjjZLpU8G0tTbHf2+6Epi2MqnkO/nobDXQKBTFIfgq7QF0HIICe48yGpGlQ==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 GV1P194MB1905.EURP194.PROD.OUTLOOK.COM (2603:10a6:150:59::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.21; Sat, 9 May 2026 17:22:44 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90%3]) with mapi id 15.20.9891.019; Sat, 9 May 2026
 17:22:44 +0000
Message-ID: <BESP194MB2805271AD5DBE47B322F8DC3DA3A2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Sat, 9 May 2026 19:22:41 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>
From: Francois Berder <fberder@outlook.fr>
Subject: [PATCH v2] usb: gadget: f_acm: Fix memory leak in acm_add
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0362.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:37c::28) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <634d72e5-8435-4be1-a418-734efd62889b@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|GV1P194MB1905:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cfa4e6f-47e9-406f-2596-08deadef94fa
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|51005399006|24021099003|37011999003|41001999006|5062599005|6090799003|19110799012|15080799012|5072599009|23021999003|8060799015|40105399003|3412199025|440099028|12091999003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZlZYelNvUzl2bTFuK045cmVJdkkrSGRtVjluSDdWZXgyVlpJQWtyZ1JwT3Jo?=
 =?utf-8?B?U2piT3htaExnazdBKzFBRHF5VFgvQ09sd2Q4c05aQ252OUlqd2NYQ29VWUIx?=
 =?utf-8?B?WlJOODllQldNa2YrRjk5Q3h2WWttcnloR1UvNEE3L2FLSEUzNUhqak8xb01Q?=
 =?utf-8?B?MVZkNnVNVUQxdXlaSjM0UnNIWnBNeko4S0dCb0NYdU5wazZ4dVNZRG9XYTdS?=
 =?utf-8?B?NDEwMDlNWExXU3FuZ09jeml3VW1USTlUNlVMM245dnpnRXBwY2R5TXluMklI?=
 =?utf-8?B?aVVjcEdvYmtNTWVsTmQzbThIMFFIMVFlTDVpSE5VK0V6MTFYS1dpTUFLaWJ4?=
 =?utf-8?B?NTRPeFdEZEhucEovQkMrMVhaS2JNSmw4Vjd4TVREa3BUQ01xTmIwd2JWNE5F?=
 =?utf-8?B?YW84VXVQMUZhT1lobDVhZmsvaUVuMTJoMTM3Zzl3R25jQkY1ZHJNNUpDTEVJ?=
 =?utf-8?B?TkhtWUdVM1djRUtnVDJvT2o5UklLSXVXUEZCb1hWbi9zUzNEZ1F0NDR1Qmli?=
 =?utf-8?B?OHlKK3BBWnJOMWx5cXI4MEJHNElkKytta0pkQllSY1EwSGl4K2R6ZEx5MHln?=
 =?utf-8?B?eEVNYWo0MVlFcG05K2w1a2NXQTBZak91Y1VtL0NtcXNHbUtGL1czL0pOMmR2?=
 =?utf-8?B?azRvNHVZazRXOHY2RVU1dzIvcmlaa2NlNXFhUUpEM2hUYWh0c2dhcDk0cXZP?=
 =?utf-8?B?SEQ1NGpCVjl6elJlY1Y4clYySTdBNU96NCtNOVczRFNLZzVFalFPSk9vaUx4?=
 =?utf-8?B?SEdURVBXSktwaWpLZGZPZllRNWhMQXZNbmowREVBaStXWEFvaUpMMXIvTnNV?=
 =?utf-8?B?R2c0OGdEdGIyT3lHVDFneUNWMUJ3ZlVFTkVWbXllWG9HSHd0bGF0bS85ZUZG?=
 =?utf-8?B?Yys1eHVYVHIyTmt5ZjBxVlJ2TjN4M2h0YjhLRHY0aHprd3lrZHVOZlJacFNs?=
 =?utf-8?B?THpJdjdCL2hrTTk0OU5ONDVYNEJiL1hyb29UYlRFNnp3OXVtTmRma0lrcE5w?=
 =?utf-8?B?d1FNdEs5TEdhYytXN1RhcHlSZlhCMDV2V3dhQ0FnVXhib0g2MmN6VjlWVFZM?=
 =?utf-8?B?SCtVbnA2Z0VmbXN4MjNQVUhYR09HMlJwMmNZeEFlWWZPVlRIMWV2UnAwNEV4?=
 =?utf-8?B?OTRQN3ZPbVJkSEQzWjFGRWl5Z3JiZERwQStSdW9JQ1VzN3NLTzBGOWRuck84?=
 =?utf-8?B?S0VyQ1RkMzFpczNrWjlsRE1LNFcvb1JzbG0rRTJUL09iRmZWQW9RTHBVYzln?=
 =?utf-8?B?TEFSVnZJWFhadDk2elVTN0RsUm53MEhYRHJqZmNuRUplL3FKV2RiWG1QZXB2?=
 =?utf-8?B?bk13MWNodEtmWXl0bWc4eVIyMnhDcm9ObzlmdlBZNDhMZnd3Z3hLempSQ2c1?=
 =?utf-8?B?b3VBU2tQdmswUUJBOWR2NWRBL1BqVEd1WFhEblhvMGhTM1hIMmY5b1F6M1ZV?=
 =?utf-8?B?enVKS0xLYlpsUmRFUVZMYy9sSWE1SVpuTWduUFl3PT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3BIOG14WXdqcjVqRjNhblloSGRKcXFWSUpVTVBDZ2NMaHYwZHYxMWJBV0NY?=
 =?utf-8?B?V3RlQWo1SGEzWXVueHRPL3hGVHhPcDkvd2dURmcxV0cvbXRFbkdTZjR0VHIz?=
 =?utf-8?B?Q0hSaFZuQk5La09iSlhWMk12TmIrTmtIRFJaYy84VTVJV1krRUhlc0xJTXE1?=
 =?utf-8?B?Q0V5ZllFaSt6NHBYZTBNUFAvVnJKNnhkSUdkR3VxNk96RzhrQzNZQmJVUXZO?=
 =?utf-8?B?MVR1NlJlbjN1Y2w5d2xHTFZ5SFEwU05UV0FubUtscmJzbmwwNzBheWZjS3Rx?=
 =?utf-8?B?bjdpMFU5K2p1enBaYm93U0hJaEdjbVUyTFpxeUVRT0pJa3VxVWpRWmV1ZmpM?=
 =?utf-8?B?Tll5ZTFzMmhjeHFFNENXRHJvZ1JpYldxMjkyM0lWQWl4aVFhT3RNV05BUTBG?=
 =?utf-8?B?dFZiVGNNN3NIa3BrWkxrc1NpVWlpcEE1aGlFWlRLbVZxenZydTNhSlBrMDNZ?=
 =?utf-8?B?SXFnRXVLckdaMWgyTGpYZElQckhucFVpZC9kNEJ5RURHdzJ0d2tkby9JOXpa?=
 =?utf-8?B?VlNQeDdDbG4xZlJMR0YwQ0ZTZHh0VDdNU29idHo0OUR3ZzV2Ykx2Y2NOOC93?=
 =?utf-8?B?ZCtpNndweWFFMWEyV0sxeWpaMkZBSVREM0RYRUxPSGovWUNhOXdYdDBScXBC?=
 =?utf-8?B?TEZNZ3NhU3BMc2dvdThhYnExd3ZXYksrQmJRT2dsQkdqc3czL0R2QVF3d0ZJ?=
 =?utf-8?B?SFlNN3ZXQUhRRUJ3VzlGc0JaSFdhYXpZeWdCYWtiY3Z3MEV3WVJFd2NNQUJI?=
 =?utf-8?B?aFY3anRqNTVEbUkxS3hKdFpDOWNWL0t2WW1oODUwVE8xM0lmZ0diZ1QyRVpY?=
 =?utf-8?B?UTUwanFGUXJBc3JtRG9WaTBoUk53RmJGNm9rbE0wM2RTUFVSRVQvM2ZFZ2sv?=
 =?utf-8?B?RDROVE44SDNVbHdHNFVaeVJQTUdYcXRIM3NHZlQxbmhiai9NRGpEb0lwcjJi?=
 =?utf-8?B?b1YvNGNRVWRUWDNHV0VicnJLclVWSEVnNVh0VkYvZmxMK0o1Uks0a093cXd3?=
 =?utf-8?B?TmRPZ24rVzJKcmF5cjNOSzd2WUNlWDNmb0loR3FCL0hMZEVWdGI0azRKWHhn?=
 =?utf-8?B?UE9SWnlFbDEvMm4yQTdhSUcxbDlIZ0FGZEFlOEpTNVRLZk1MRk5aVVFOMVox?=
 =?utf-8?B?Y2tzb2VQQlpMV3orbkZpeWRFMmhOd2lncmFTLy8wZUJodThLMGNldVVLMStC?=
 =?utf-8?B?aDdMNDVEMVAyUHlFZER5dEZHTTNrWXlPanMwVDQ3ckdFdkVIcmk2dFEydENv?=
 =?utf-8?B?Y2ZIU0NPMkJwQ3JERUYzUmN6R1R5bTduQXkxUVVGNUloNHZ6TjFzdE44TmR0?=
 =?utf-8?B?VVRWVVFvY0dLZmVhUnhSTnpPNGRmQmhsdi9lTFBrWTR0NzRjM204RzNYZnJZ?=
 =?utf-8?B?Z2N1ZEFjTXJhY0l5Z0NBekkvcW9LSDVkV1phVlhOT0JyNzRSNENxODZnQTFV?=
 =?utf-8?B?eVFYMmFxS0YzVVFmQVo0YmJ5TWV2UWlYem0wRTNwSUh3b3cyMXIva05Rc2N2?=
 =?utf-8?B?UTZxVHl2Qi9ONTYrUGIvNkZxR3AwTlFyQWIrRWYvcmtjV21kWVZSL2w4b2tk?=
 =?utf-8?B?aGh5bWdmck9vV1lpSFpUdlpBZjM4WUpEaWFjV3FvaTFPd1o4clV0WU5VME85?=
 =?utf-8?B?Zm41dlhOaWZZUUpSOGVHRFQ1OGZKTjZsUUtHaU93NnNzcmRFNTJrbCszRXd4?=
 =?utf-8?B?TGZjZDkrdjRyTEFrZUd1NHVoaE5KeEpyVk1qY1g2ZVhNUjRYdUp6SmJnMlp1?=
 =?utf-8?B?UHB2dzlZVk8yZU9VcmJ1Z2RIVkFzRkhIU0JHa0xQVjNYTEo1ZmQ1OXVzSkVR?=
 =?utf-8?B?dFI4Vjg3OGg1cXZKRzVpQUZVbi94Yythb2FCTlR2R2l6VzlndHNBdUxVZ3F0?=
 =?utf-8?Q?GwwcehKQnpZdI?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3927c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cfa4e6f-47e9-406f-2596-08deadef94fa
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2026 17:22:44.2943 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P194MB1905
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

If udc_device_get_by_index fails, the f_acm struct was not released.
Free it before returning the error.

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 drivers/usb/gadget/f_acm.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/f_acm.c b/drivers/usb/gadget/f_acm.c
index 8f7256069f5..b6c11d97a62 100644
--- a/drivers/usb/gadget/f_acm.c
+++ b/drivers/usb/gadget/f_acm.c
@@ -548,13 +548,11 @@ static int acm_add(struct usb_configuration *c)
 
 	status = udc_device_get_by_index(0, &f_acm->udc);
 	if (status)
-		return status;
+		goto err;
 
 	status = usb_add_function(c, &f_acm->usb_function);
-	if (status) {
-		free(f_acm);
-		return status;
-	}
+	if (status)
+		goto err;
 
 	buf_init(&f_acm->rx_buf, 2048);
 	buf_init(&f_acm->tx_buf, 2048);
@@ -562,6 +560,10 @@ static int acm_add(struct usb_configuration *c)
 	if (!default_acm_function)
 		default_acm_function = f_acm;
 
+	return 0;
+
+err:
+	free(f_acm);
 	return status;
 }
 
-- 
2.43.0
