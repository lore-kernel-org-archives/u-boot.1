Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EBF9CD98DE
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 05:31:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C100847C3;
	Thu, 18 Jun 2026 07:31:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="uEJaozOC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B33D7847EF; Thu, 18 Jun 2026 07:31:47 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F5408460E
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 07:31:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ft9xikQmlTS1aDaO4EBp+zIuu1U4KgelV/l/IZ/vRsAZ5g683WRjLQ6GMfQOOa3fnkeuBZaTb2tzEGNBs666Asqx9K7DmXf81SWq7Ru9uFMqfg5LRG7/Vvo8rQk+6F2C0LmSGlpoSkbUKImJd9plMAJ4x2a9MqHmOE+fM4gr/g5DEw7Y2OCMUT4ktMsGE8SVgeHyavdA1/kXPWsmwSXmQI3mQD7rbf9AR0i9NaSMb/vIf9ARaq+miongdAM6l/noqu0ZXli4dz3CEbPFIcLBEPghR6nvpTJFt5xzb+I2VblPBzZhnm8HjKm7fTOFv+Wzk9jctx9L9e65dZJJb3hVHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCypz+dhxzTFOOMByge25jeblSAxSUj+bxmcUnportI=;
 b=vx+ltX/HRIyFx81ldaDWO455lzuAutKkXWDZ2497F8z5QF0+7FZrag75+q7i+rW/wMX/16Zghr/09jUF43ZM78+zZhEGQr86vKLUr1Bf7fjCLKpMsKCGiALyRitcUTK1++vQhr3ctwXru8SxWLtPBwyQu4Z6yLHjOCb+XGn6WyxAB4dipLbHXFVE8GkLJ0oi+KH5WTyafBZnFWS4If2Z2Vp2GTFGTj2MwdwE85hy3wgI31awLiP8jBt5aM+JSl3H2NyqLveSMzITI5f3BHkAPLwoxHVAA2aAVJBHYCEkBYgzAx14geJTUPITH6nfVJMLUCKGzxmvcsxwyzpMVq3hqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCypz+dhxzTFOOMByge25jeblSAxSUj+bxmcUnportI=;
 b=uEJaozOCvLvkFpn6OeTv6GkEdemCQGl0FKt8zF9GH2jG4wtwo9Fg5lqTvY37iqpPK06hSI5YpCT30ca+2JY14M9Jz76kgWATBH0y2m1wy42U8Zq7ls2fszhKGJbHYpP5OhUBU2SEwacypDPwr3mX6zoFDRnVuaaTJCOVJds18kZSuumtvb/eZHzw+5BODLHgjdW9RbzCMaoEhWOUI6CYKRb4fwTk2Pg/WhjDZDSKpEeAyeEHwHTFOd101E9S7SdghSdwkv6r6lCVwjd8ilqLsFpi3DKFPPgKWxJlYI3DNtmUw9yrbxs7tbXK16kZryQImtWhbEkBLGINpFqQ8rcdWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PA2PR04MB10421.eurprd04.prod.outlook.com (2603:10a6:102:41a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Thu, 18 Jun
 2026 05:31:44 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 05:31:43 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 18 Jun 2026 14:48:48 +0800
Subject: [PATCH v2] usb: tcpm: fix inverted poll condition in
 tcpm_pd_transmit()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-tcpm-fix-v2-1-57d16534b04f@nxp.com>
X-B4-Tracking: v=1; b=H4sIANCUM2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIzMDM0ML3ZLkglzdtMwK3cRkc8MUcxNTI+O0VCWg8oKiVKAw2KjoWAi/uDQ
 pKzW5BKRfqbYWAOQeaz1sAAAA
X-Change-ID: 20260618-tcpm-fix-ac71d74523fe
To: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Wang Jie <dave.wang@rock-chips.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: MA5PR01CA0211.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b0::12) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PA2PR04MB10421:EE_
X-MS-Office365-Filtering-Correlation-Id: 57c8833e-eee9-40b5-19b2-08deccfae1f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|366016|23010399003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: Il2wYyhRyvVewbCNCYj7/hMgUb+4NxjEv/fxi1GpaUTPQHMlhjCMQoKYa2xZSMv6R4MvWJIC/XwwejzPetYrqAq5Poq5g1p/ZE2P3xGL7ZTgRhmmAWPSPt8XkGop9oEgrZysmnQgQSZTycIo2CYMtghOV+Pl8m5GOfeF49a1WABtOu2yE9jMReGKeBWCxO9sHHVCjtniXGK89kzACr296H+y74n5bifvOKgixL8kn6IYP2bpgXII5aybw8XNOtxv4zs7CL6inMkgQlmZraNIIEfjqm3XetJLArfETiU3JtpGzkWCdbY5ycGOi7iO+XdHo/GTfsx/AYdCD8t/ZV9rfNyXyhmMFHA/ak76zldPeDZQOE63tqVBA6UGPMKjUNODzIcx1E+J1AHQU36L3SZfBp9zR5UI2AMeNHvftsYLWGZ9Gc7cQvD8RlL5njN5N/JDFTd1U41Cd7Yg+NPqJmcPRiqXDb7Qsp+JxjeEIQaySf8JmX+67RHzSzHlcyb29UAv0mFbPDIWJR+n7yne1npxH0PsfxhJfjlFSVP24N5DMy162YnrH5aHe2iUVvPMcPtULeAfszgneM8ts1DjjxRRy5mQKPoZv1C9OL4/n6rFy3Neukqknn1Ar+bxV+n6yLvKo36tvRawBonFt43hRiUt/nEQMuFK8kKA0nrYoI/bg1W8XcUpxqjiHPk9pBgi2Ahr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(376014)(366016)(23010399003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXFkRmRWV1lhS2s2MENEVSs2UDBkUForVXpHWkM2SktMTU1nNmtHb1JyL0pX?=
 =?utf-8?B?bzJ5QitHQ1FTQTlvUi9Hai92dG5BdldpR2ZRWW43N0lQOS9yektBTVFGMnBr?=
 =?utf-8?B?OENpcW9EcEx0SlFIREFadEJOSjg4Q0Z5N3ZDNkpLdkJWbmJIRkpORWFJcDhv?=
 =?utf-8?B?ckMyc3E1UmVpbktaRnRZNW04ZmRYTncwYUtLV0F4STVnUXcvSGFFWnFTUGJF?=
 =?utf-8?B?TDdqUW9kcHZCbi9JWTE0K2VqME42R2FVY3g0dG1jV3RoNENoTkJXMGdGeTFY?=
 =?utf-8?B?NSs0NTZGK0U2UXByZzdBajdyOHFubnlHUXZNVU9vUGQxZGtPVkc2Ylk3anZa?=
 =?utf-8?B?VUNHWTFDMU1yUjBlbWlRTC9nV3h1cERiWmVCcnhsSlZzOXZKL2krQmFwOU9F?=
 =?utf-8?B?cVVoVm1ORXRGeVJxeVo3RGZia3hHcnZabG15NjNXOFhnaGVzUFVGRVArOFRr?=
 =?utf-8?B?Ym93YldsZERQVWc4eEpjVEVPcTc2aWlkU3luNWVjVWlyalVQc21QTFBIc0RC?=
 =?utf-8?B?U0NGMVRBY2VuOVB5WWdoRWR0NFVVUUdVcjd4UElzcXBuN3lxU21OSHUrZVVQ?=
 =?utf-8?B?TWMxQlYxU2I4Nkd0UFhjNHhLN3lhMVEyQTlVcyt2Q1pIbnM1MmRjcHdwR01k?=
 =?utf-8?B?QTF0aTNIcWlrdTQwdlBOcktpQjg3YUlYZUtKcGZXb2lCYTJkY2tKcldTZHRW?=
 =?utf-8?B?Z3hpL2o5L0hVellCbDFlZWNubXo1Vk94VkcvMGl1aVNESWsvNU1PSDA4UVBP?=
 =?utf-8?B?Q0J3S0ZmTmJaTUk1Ui9lZHdQVzl1d2NqYW85WnBKQk5sN2FiY3FNWEhjelZ5?=
 =?utf-8?B?MXJWN0ZDYmNPZDFLdVhLZUY5RU41OHNCRm44eWRTL1BPQ2RTRWZ3ZG9pdkFF?=
 =?utf-8?B?UTBqVGdLU2tDWUFWeVA1dmk4UGE4YWdxNHdkRzdMTktjbGFBcXVtTmJwNU9L?=
 =?utf-8?B?NmI5WUVXWVpTZG1mUDJFVXVGbnhWV0UrSk1wbnUxNnJMRUZ4M0puNGFKYkQ0?=
 =?utf-8?B?N3ZhRVk5bGx1cmdlc3FSREhlT0VBVmlRZEJHNk9ENmVLd2lDS2h0NXdMSkpm?=
 =?utf-8?B?MW5NNU5UeS9SUGVYVHpldTNGek1OUG1DSHZLaXYvUk1nak9vQXZyZmNJbUZs?=
 =?utf-8?B?MnU4VTZyRE0xb1JaMVU2WFRYTzNTYXkyYUppYVJveDFzUXJ4Wk9RVjBnclY2?=
 =?utf-8?B?UmhvZUVaVnFmTFhXK2krRzFWWGR1cHNnTjBYMGltVDNnT2NnWkJLUE83aDlW?=
 =?utf-8?B?cW1CYTgwQkMwYkV3NnJNNkVQdGxZditHK25nanJBTlBvTU9IOGdNTXRvL1l5?=
 =?utf-8?B?bzYzRiswRlEzSVREU0xhNjFCQ2VMQ29maU5oUm1DQkN1cEdBZUpZaEx2cHZE?=
 =?utf-8?B?bFhrY3JibEVWNm5lM2Z4Nkk4alZmdG94dVFuaSt0RDF6RzRqeEZocFNjczg4?=
 =?utf-8?B?c091by9CR241WEJaUk1rbEJHZUhYRVplMXFLd3ZmYUc1ZHE3TmFSenVVd2dH?=
 =?utf-8?B?eGxJeXNIUlZvNEhNU0RNZEZweCtUTVJqSmNpVkVEeGY1TVY5QXBvY1ptUGlD?=
 =?utf-8?B?Rjc2a1pvTUE0YmQzZ2QvTWJUZUlITHVWT1UyNTVGNFVlaE8xZExEWkE0RWJU?=
 =?utf-8?B?bDR3Q01qYzNDNkhvQ2xRR0pVWlNvK1hBYjg4cGhSOHRrOGJUU1NOaWVJMzE1?=
 =?utf-8?B?UXZDMy9IR2c5MVBSdjhaRlNzMHNPUm9FZGx6NEg1WjgrK0E3ejJiaWJsdlFi?=
 =?utf-8?B?WkVsdnkzT3BITHVBcGpyYWhMOUdDUjMwN3pzOFI2UU9XdUNDTklYczR1SW05?=
 =?utf-8?B?akdQTzR1eU5DNSswUFdxNWdrVWlFSlI3VTZkOVVSWFA1Y1d0TlpXdEZkWUxP?=
 =?utf-8?B?Y0ZRRmJweCtjNTZxeWlyQ3p5MTZ4emJrSlprdElHNk90NlEySnZ2bTFWL2RM?=
 =?utf-8?B?bzhpcWcwTTV5dFpqSklvaFA4WkZobWhhZHQzNW9VcVZEaFBXVHd6UGQ2bHlx?=
 =?utf-8?B?SnZWbkhKT2tNNjdDbTVaOTgxRHpreFdBbi85Y3IyRURteFZjRHdCQ2RzclNr?=
 =?utf-8?B?SjhQS2tuYWk0cE9tSUJyOVlUc3ZiM1lkYjBkNjgxSVkzMmkxYjV6b2NEOXdH?=
 =?utf-8?B?WjlYWm05UEErNjl6ajhDVnBSQkVqZlVNbXA4MlhxMjZLeGZuUU5ldldWOVpK?=
 =?utf-8?B?bTV4L2JySFdVUjB2MGY3QmNMNHorM09ScWdSSStYbWpCbFZzZi9yY01lL25s?=
 =?utf-8?B?U0c2TTdNb0JId0I3Z1RqUy9WV2N6TWJXMkZnRnFZTEY2MDRPRCtrdnNqOTJ1?=
 =?utf-8?B?V1BlRkZJQUFvSHdqRlp2WnIxU2Y0YzlwOGZVMDVNajlyanVlbFRESEsxaWxu?=
 =?utf-8?Q?Gzu0qJ3SYp/LIdTkrad9hPExQL0bCuktVzc6Z?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c8833e-eee9-40b5-19b2-08deccfae1f3
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 05:31:43.8980 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8XhLfXuPWC5u6fzR79LN9z7vEUruhS4xxhEMgOQ+GsTWr766l32PobvDQ4/bJgfUMYrcUt5XgSE2b5YpJa9oN1XM2VBMS6vLh7cIykY25c8LmwQ9jhh661CwiJfenxxl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10421
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

From: Peng Fan <peng.fan@nxp.com>

The read_poll_timeout() macro breaks out of its loop when the condition
evaluates to true. The current code uses "!tx_complete" as the
condition, which means it exits immediately when tx_complete is false
(i.e., transmission has NOT completed yet), rather than waiting for
completion.

Fix the condition to "tx_complete" so that the poll loop waits until
the TCPC signals transmission success/failure/discard before
proceeding.

Without this fix, tcpm_pd_transmit() returns before the TCPC has
finished transmitting, causing the PD state machine to proceed with
stale tx_status values.

Fixes: 1db4c0ac77e3 ("usb: tcpm: add core framework")
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in V2:
 Add R-b
 Separate the patch from patchset:
 https://lore.kernel.org/u-boot/20260617-tcpci-dwc3-v1-0-b824fe1e9299@nxp.com/
---
 drivers/usb/tcpm/tcpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/tcpm/tcpm.c b/drivers/usb/tcpm/tcpm.c
index 3061b466d7c..d6c0be82333 100644
--- a/drivers/usb/tcpm/tcpm.c
+++ b/drivers/usb/tcpm/tcpm.c
@@ -207,7 +207,7 @@ static int tcpm_pd_transmit(struct udevice *dev,
 	 */
 	timeout_us *= 5;
 	ret = read_poll_timeout(tcpm_transmit_helper, tx_complete,
-				!tx_complete, false, timeout_us, dev);
+				tx_complete, false, timeout_us, dev);
 	if (ret < 0) {
 		dev_err(dev, "TCPM: PD transmit data failed: %d\n", ret);
 		return ret;

---
base-commit: a0a1e9f2f1dffed04ee52723ce957c07bb905c25
change-id: 20260618-tcpm-fix-ac71d74523fe

Best regards,
--  
Peng Fan <peng.fan@nxp.com>

