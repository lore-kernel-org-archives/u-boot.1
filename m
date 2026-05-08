Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0966ACD37AC
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 00:43:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4D8284E0E;
	Sat,  9 May 2026 02:40:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="t+tTvOk8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4712F84DEC; Fri,  8 May 2026 21:46:31 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazolkn19010001.outbound.protection.outlook.com [52.103.33.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71BA084C33
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 21:46:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RlhQBG++zO2E6FkYS9AqpQcA35cYhrcMqAEq2yWH4ffpkg8Ofmx5AfP1UvzaicXUNv1p6LVQqfB9KRIWcxr7OQwODyfKeNpxE0rzlGtmlqPsAt0G4gPolP6fE6iN9vADaTbA9UJ5PWBANVg0aQvKrX7JMIve6L1HPpB7PfTqzPVbvSSQP4PdRN6hfVYVTPkk0x+6f8dADT0yNmNra93qGedPhZnazWYYf++5hJU3dGWXCQf/QT/IXWfydhxu9xHxdhg9FUDvROzqAB1YnDN4uxp7nl2V3mHHuZbqbfUsPa7Z3mW7PigRVvQiNCYlkcAM85E3IQm0yOF8U3CGvGn22Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2NhJ097GEeSEKt06iC8X7ffy3Mh2lvLUJygbdHEL1A8=;
 b=VggAiyRE00YV0IW0A/KxSOllRthZ5RdNBDzNkE+FVJSSJslEgoHMqaaCk66G+uaGjkGzFznjp9Pnfe3cMB0jbijfKWmz/XI0qGUkrF3mC9XL6SW4FmNqvbZnDXXurpG/y26Fr01eESSOBnN7tCJAIJcWOej+WOkmeROVHQ7Q2WfbKCY+MG3wsVRB+krPCPllkZGZMk6c7kjkQ3Rqxm37EkHVZsl+csP8m3SgUoUpKWcYdtuvK2bi4aLkKnPbUrSEiNIxjHx574q62ePq+D4wnMBXPpfbps/oG6Nh11FB7CgJ0Gk1tPQBPuVwSQKpcz73AN8MZqMX90syLvJx/dYmYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2NhJ097GEeSEKt06iC8X7ffy3Mh2lvLUJygbdHEL1A8=;
 b=t+tTvOk8Un2mhNM47729JyVZwRb5hG17cOA6h4Qe3bfROkxwbMNvA7z4VPx6qplInswfvNbOAYaJ/4UZc2M+YXE/omZHHGIl+d0UOASJAfFcO8bdYL8gXd/tC1+LHFN6bEbyNSvV+J9p3BJiBSbvvDKVLZL2QmOkC0B5GQjA6MiPu6xmJVFAofNuXdKdfKedoi1bXK2KG/yCK87uGivMlzvu/V2+6luDKqUisCJkGwO1R1iVH68eOnVn2OcGnHFaBEjINr8xqdqZ0BAugdMrpB2p2Gkxnl5v8PBWJ5v2D49alLa6cf2NJJqIIJJJVgAQYPIPOYLsIPb2SuSBEYTssQ==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 AM8P194MB1717.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:324::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.20; Fri, 8 May 2026 19:46:27 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90%3]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 19:46:27 +0000
Message-ID: <BESP194MB28057EE4305A2535D0607448DA3D2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Fri, 8 May 2026 21:46:22 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>
From: Francois Berder <fberder@outlook.fr>
Subject: [PATCH] usb: gadget: f_acm: Fix memory leak in acm_add
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0110.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cf::16) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <d7089c19-d3da-44ba-af88-99fdcf4d0ceb@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|AM8P194MB1717:EE_
X-MS-Office365-Filtering-Correlation-Id: f7969c7e-744a-4d74-1a72-08dead3a7d6c
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|19110799012|8060799015|41001999006|15080799012|23021999003|5062599005|6090799003|5072599009|8022599003|24021099003|37011999003|3412199025|440099028|12091999003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YjZIU3V2ZXM1eUhUVFJUc1hRREJjK0NCMVFjdTVWYWRVVmlEanh0UUIzMGRV?=
 =?utf-8?B?QUswbkEvTklHYk9TRlZjWXNqSEcwWjV0dW90K1lLS3hkdFhiNTNIN0gzQ1Nh?=
 =?utf-8?B?MkcvT1QrbUIyL1pLdVhHelYvMEtxSHdLTnFWVjB1c0NndFlYUk1MSGZKK3du?=
 =?utf-8?B?aVVmM2lwb1JFMWR2Sjk0UElCSFEyWjlpS2FoNUYxSzVobVVQZHdoQ3diejU4?=
 =?utf-8?B?Vmd4M0Y4cGNlWmozaDh4cFM4c0hHNDZFNmN3QXJxMHJpWHlsNStxR0txZzR4?=
 =?utf-8?B?N2c1Y3VCemJuMWdSQWVhVzE5STVaR2NBNGV5MkpxWHAxa3IzdS92OWpTcXdO?=
 =?utf-8?B?ck0yUE5MSnZzZ2ZYS09aZkNrVE1wL1FINDkvR0Rpdmp5TzNYaTRnZXY5RkRw?=
 =?utf-8?B?a2I0eWtFbXVCa09CbVBoMDJqNVdzUEU5bGcrRWFjV2p6ZjBpTXhYZCtseW01?=
 =?utf-8?B?K25QWUdPRElPWk1vQXJEcWFGYVZrTFF0ZWRMWmd5Q1RQOFB4bkIvVWMzNmVR?=
 =?utf-8?B?MXRNSWlQQjhHekdJT0NwUGZRdHlkUzlPWkVqRUlTcFYxWjFMeG9pZ0s2dG1L?=
 =?utf-8?B?SkVCZHBPYlF6N0E3ZGZsT0dtRi9SQ0ZzMXQvblA5L1VTM1o3MWJ1TzZmZHZm?=
 =?utf-8?B?RTVIL0Z6RkE3VkxFcjNGd2xSeGZ5T2xBeWNLb1J3M3pkYXhPcUdwQXhHUmlB?=
 =?utf-8?B?N2lhWHB6VWRqRkpvMSswNFJtaE94dzA5aVVPK3UraDdORzh6a1ZxbnRjYVRG?=
 =?utf-8?B?NWozRFhLNm1JVTNPVU5IYVpLaFVDbjFweGgxRExoUVV4bi9PZUpNenBQekFV?=
 =?utf-8?B?d0ZwSzZ4dUpKUGZ2RUJFQS9kcWJHTHpCaEc0WGN4d0FnQXNhbUhyV3dRaE1R?=
 =?utf-8?B?UXg1OVNHaGFrdmFlMzhFcHJyZnoxWkFuemNESVpMaUhiWGZzNG5HMmRjLzdI?=
 =?utf-8?B?TE05M2c5ak5kTVNITFZmQmpLblo2UDlvRzJnaGRDZ3lpa1NQWFVsZHR2V3Y0?=
 =?utf-8?B?ZldqZGc4bE9FaW9KRUcxTjdHMHFoTEpiQkhNQ1F0V2J0SVlKSHRLY1dUMjR3?=
 =?utf-8?B?ektFV01aaHh4M1YvQ3BuNURPbENHckQ3UExVZm9HOGxtZG8zRUpGWHZiTkhh?=
 =?utf-8?B?S1U1MWo3eE12S3FQcThGWHZZYTU4Mm9QemJubzRIeVRac3NWZGNaZ2RobUo1?=
 =?utf-8?B?d2dEZzkvWG8ycm14UEZqSjRxSXp6OFUvVERQbVMvOVNSbkxPOUk3QzFFZU1x?=
 =?utf-8?B?R3JWK2xHb3VGYmJ3Q08wOUVkMU5HdHUzVGtKNGhjYXZ4V3VtN29FK2lkeGNz?=
 =?utf-8?B?VGUrdkdIWE42U2s1QWdnVHBtZHFtM2NPakhXTXVaMzhuZXZxd2JoL1YvdGlr?=
 =?utf-8?B?cmJZNlJjL2tuNW1pRzFzWi9Lc2lXK1hJdHV6NW1hKzR0ZmozWDFQVnhPaXBa?=
 =?utf-8?Q?O9fWkbZt?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVpFSmpKRUhhUlc4cFI0SnkwSjVuTHBOVEYxTUxuR09ZcWR5S0FhN2NLTTVi?=
 =?utf-8?B?bkRJSmMvMmNuSyt6S01seEQvRFZrUkpySDdxMklMRm8wK3lkVTc1ZS92OEww?=
 =?utf-8?B?Y3Q3OU5FSTdtTkRKMWFTZGNHQVpVczc2b0hkMjg5Tjloc1doYlUzMCs0cjVR?=
 =?utf-8?B?Z3hqL1htNjAzOW5rLy9HaGRiMXFhd1plaTJHZnl4ZUZIZW9idFptMndFRTNC?=
 =?utf-8?B?SWNvUGk0a2xxK2doWlJaMWNKS3dxVmdmQnFMMDA4dnFPendEdWgxeG1LajRy?=
 =?utf-8?B?LzhOdXZmUU5STWQyNlhWUTVKNk96U1kwTCtqOFQzdDB6NFdmWm1rY1dEQ1pj?=
 =?utf-8?B?dEVSaHlzTllDUzNRMkpVbFNhYlF5ZmttdEFOQ0d6TFNKeDJUdklVdTJaL2ZO?=
 =?utf-8?B?bXhPTkJwbFZrSXBEbExzY3pUaUQvT29HSnFuVG40U2hzaFZFV1JMOThIZERh?=
 =?utf-8?B?Q3IxTTUzOEUvNkxNM3JENHJIYTFFQkN6NlZIWGl1RERoTk16cE1tNndKMmg3?=
 =?utf-8?B?cC96aTNvRG5HN1Z4UTdWenFVZmh6anA1dW9QNXlQTUhKOUZGL01Fc3MyMmEr?=
 =?utf-8?B?WkRlV0xnWkZuSS82MStRWFcrakg2cHJNcmkxdzhXdy85R0ZxKy9DSGk3VmJU?=
 =?utf-8?B?N0dyKzRhRERHd29FR0J1cnltcmVuM2ppMFFUaDlVdGY5VU5PbHY0bUhTSDMw?=
 =?utf-8?B?VTFNOTNPbStGU3JiVTlMZWF6dkZ3U1kyUWpoak8vUTdOejFJYVV4K29XVGEr?=
 =?utf-8?B?RFpuVkFZbzNSWnhRcGYyZzUvc0ZzNDRmQ2NYUUtLNXkvS3FPT3BXK3lDYXBt?=
 =?utf-8?B?YUFQdklwWlROSGhOK296Nmh5Wm1la28yZ1V1YkpsbU9vbzNCYUJNUzJzZEl5?=
 =?utf-8?B?QjZnaEN1SURteTg0K2puRHFpU0tncnBMSW1pUXVEaUZPYnlQMFF6VG9pdlAz?=
 =?utf-8?B?L01iK293Y2QvZ3YvWGdBTFFYcUcxSXF2MDRkSjJwUEJwS2xTdk56U2pQQThG?=
 =?utf-8?B?S0F2UldSOXQ4MVFoSlpKOGZ0L0RwUzkxSm9lNm0zNnhlR3RyMGs0Z2t2SEx0?=
 =?utf-8?B?ZTVMVCtob3d5cVZMeEdsSVRXQ0pmTFAydmVqUkFPRDFFMVY0WjIzV0JoYkdT?=
 =?utf-8?B?ZkJHdy9MVEVNY3drbXljT2g3Y1IxRFZVQTNSVGhxNEFrb2paekhhUVJ6ZW91?=
 =?utf-8?B?Y2swWktTeCtndHRkRmJXQjR5THoyanVPYklsMlh2bmhyekUrTEpNeHVvVEpG?=
 =?utf-8?B?VEZZSWtLSFZqcERzV3JQdXRXY3hjeU5aNEJML1pKbDF5ejl6OFFDVmJrbDNa?=
 =?utf-8?B?OWl5ajhhUEdHakFuK2ViMTQrM0MvcStUZktYcG9rQnQ2cDFMUkdTTVpMQ3Bn?=
 =?utf-8?B?dUZheEJERWdxNS9aK2NkeEI0bTc2dUR1ejNaazRudnhTWlFqdzFJOXhPL1RX?=
 =?utf-8?B?eGlXQ1c5NTVkUDJOcnUrUnpURVV4UzZSQjlpbVNKUXNzZG1yVHZxMWE2Sk1o?=
 =?utf-8?B?cUpBR3RmZTQ1UnIwZTlOaWNGdzVEa01YcGxidzNEaWRzN3FuUHpwdXZEMnha?=
 =?utf-8?B?WDlPSlFxUlViOTJhZllXQy9qTkwyYkNuMDRCdUpEaUlrV1VVKzFyZjBObnc4?=
 =?utf-8?B?S3VMMmxYdk1NS1RLMTh1ZDNCNXR0dEJiM0hrbVhXMy9GMTVsZ1I4RFlYeitx?=
 =?utf-8?B?enZmM1NjUkM0U3REdlg4NjRlbTJyWWY0c2hVYmx1djhBRjV4aVQ3QVVySzFo?=
 =?utf-8?B?cS9JaE5OQWxPaHFicTVxK3JpMkdaU2FQSVFNc2V2V05PU0pCQm5rbnk4MTRN?=
 =?utf-8?B?Z0NjWFVZMXRmZjZNZWlFVHlmNTdsM1hZdXNTZTV5aVlHcytJS2RQa0JWU1hk?=
 =?utf-8?Q?MPnobrzoBcR0J?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3927c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f7969c7e-744a-4d74-1a72-08dead3a7d6c
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 19:46:27.1727 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P194MB1717
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

If udc_device_get_by_index fails, the f_acm struct was not released.
Free it before returning the error.

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 drivers/usb/gadget/f_acm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/f_acm.c b/drivers/usb/gadget/f_acm.c
index 8f7256069f5..0d8a3183330 100644
--- a/drivers/usb/gadget/f_acm.c
+++ b/drivers/usb/gadget/f_acm.c
@@ -547,8 +547,10 @@ static int acm_add(struct usb_configuration *c)
 	f_acm->usb_function.setup = acm_setup;
 
 	status = udc_device_get_by_index(0, &f_acm->udc);
-	if (status)
+	if (status) {
+		free(f_acm);
 		return status;
+	}
 
 	status = usb_add_function(c, &f_acm->usb_function);
 	if (status) {
-- 
2.43.0
