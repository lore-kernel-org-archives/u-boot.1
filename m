Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E081CD4F3C
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 18:13:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C6C5847E8;
	Fri, 15 May 2026 20:12:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="qfJ20I2r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A34D2847EF; Fri, 15 May 2026 18:53:39 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazolkn19010007.outbound.protection.outlook.com [52.103.33.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BF428481F
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 18:53:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZBWY1/n/wE91spiXOi7m/9QSAb7n0dh4hbnLsV8xHavxOi/hsxVocJvih7WUwS2ITCkBG8hiyeFZz0v1a3iqwj/F6DONEHTfQlwVDbw1upnm1lL8wSYZGt8Wt8JnPXuryh0M7ggou9TJkkpCJQ5Qqi+KZk6b/9TcaDbgSZAvQFAiepXdVc5W/toGrP9rUw5JxZoe6RildaPrMDa8d3BvUStWVUx4KPdAFTK5aF0442U19+F1zLxhPeu9uiJWLIXo/2DBg140zcK9GnGiUwgiNcqVBush+l8NC1GkYbL03x6Y62zbFLOsLcaOedJgr2p4ekc2Iywsnl8+79qfyiv99w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0cPwI9TDYtYBgrCXFnlBUnCzGGqkRaqTqd1Q5nOMbI=;
 b=hHNDlFtYk9I+Qvehmu3wDwSUcQPqmmVHGKQgXcv3nvcHTISQLo2CVV3kOXaLRTmczAATmvyRfXCuDyRHuHXy5p5f8NA9Y416L8o9NcyK9Q3K1fZlxF1Fi0RfZuRTvB5VtoOGzcAwXWmX/LhoV/8YKauJIdDUs7lRaKIpO4L2rPPDGFIs94C7S7caEGCZ9Po87nJssgBMGZ1p+pqXBJL6G4ej53dSdG8qC4DXdlQvvOnLO34xz+2T1t3vldu1Q4TCL4qMJh/0heIJlFix5WsO/4KOIrli5qCg6hvZlDgCze41Hta7wOU47o1atmGqfIZFYy/tklfJQhJtYNUCQZwyag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0cPwI9TDYtYBgrCXFnlBUnCzGGqkRaqTqd1Q5nOMbI=;
 b=qfJ20I2rZ+/U1ctnugWM541uuNkB1QZbPdTaChrrAF5JcYluSDMLBmsF9Ie/Gs8RXd0vgpEG6zD6wlc86FGVC1WZYu4CHtphr2nDhDqVm8Gnn5jecyCfFwPnpNqKdjkl0Y1StvMglje5NAE4g67jtATP6CZg0bKjOgWNiHWCOSMiq29I6tIKIqfATh89xwwa3qO5pZriKWHmMMf0KqjYWS5DZuDLWwbrsaDaDIsAX7gDpSyBGZ9EOzl6H1DjO3wARekd20yxAqywBSyO4MeuSsqXPshk3FuAxHnv9M9c86ACLBmdXO+qExb8cbQJRhDV/rHS6y5teFED4nwPSW2x/g==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 DU2PPF52311D3AB.EURP194.PROD.OUTLOOK.COM (2603:10a6:18:3::950) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.12; Fri, 15 May 2026 16:53:34 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::5ae3:1158:9ce8:90%3]) with mapi id 15.20.9913.009; Fri, 15 May 2026
 16:53:34 +0000
Message-ID: <BESP194MB28053D6BAD2F0C937D848461DA042@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Fri, 15 May 2026 18:53:32 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>
From: Francois Berder <fberder@outlook.fr>
Subject: [PATCH] net: dhcpv6: Prevent out-of-bounds reads while parsing options
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0203.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36d::13) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <a55f8606-7017-4a6c-9833-7ba126bd3491@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|DU2PPF52311D3AB:EE_
X-MS-Office365-Filtering-Correlation-Id: ee47bd55-74b7-4617-afe2-08deb2a28098
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|6090799003|55001999006|37011999003|5072599009|5062599005|12121999013|23021999003|15080799012|24021099003|19110799012|8060799015|51005399006|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmJlRlVLUDA1VWp6NnVodm9keEdJK3FVc2VGSWc1YWpFWHBtOGpDdC93Rk9R?=
 =?utf-8?B?WEFEVTBYdEg1Y2NFYWx3cUtWMkUvZk51czNWTjJ1TDF4V2hMbHNwM3RKU0Ex?=
 =?utf-8?B?WjFETFBYd3NINHlJbndjcjJGbXFDa0hXS0dSdXpEUHNxc0tSaGVaSnVMVWl5?=
 =?utf-8?B?T0NxVzdWMndaTWpzV0NDdkNMd0NMTkhjd2I3V2RFKzRzWjc1YjFzeXdYMkNL?=
 =?utf-8?B?aUo5VFVpUXVweUFQb1V6emZWV3g1V21nTlZsdTRodmZZdzV3YWZBKzZxV1JN?=
 =?utf-8?B?TFJnSDZHSU15UzRlaytJUStId3RxR0M5clNSUm0yL0t5bWtVRDlSRGplcTRI?=
 =?utf-8?B?SklhRGI0UmE1VDgrSEF3NWRPNE1EcVBBS3RDbUxOb3BGbUpJd2lSdGlwb3B1?=
 =?utf-8?B?eDBJVnJ6dnBkdWk5dVRYeVhENzE1M1RNSlJLaWxzeVdkTGxDWXFXRGIzcUNZ?=
 =?utf-8?B?Wm5vTTBmVFJUeUl2Ykw5LzVnUUNaYnF1bHNwZ3ZON21NUEZIaDU3OTdCQkpN?=
 =?utf-8?B?dEN2Q0Rzd0ZrdXFpbmR1NVlLWFJ1TXFMc0pRbDAwcWRSOFlldlJ5Z3g2bm5v?=
 =?utf-8?B?MjRvL3FMRG9sZmtselk5anl1bkxTZWdrd2VhVXoyZG9VR0tKYThNRER0Q2pn?=
 =?utf-8?B?bHlHUjlMSStmRzRkK2ttNkx5Nld0REo3eVZuSnFIcmhxeHRHVEwvK2tQZDE1?=
 =?utf-8?B?WVgraUU0Wkl2U1hQZDRIOXhJdG1hbit0aFYvQ0NPVk5zdEhyUzkvdEVYMS96?=
 =?utf-8?B?Q05BSm52RUlpQzVQQTMyQUR1RjBXanZtd29iMWNLK1Q4bldZWDZLQlpsdSts?=
 =?utf-8?B?RkdMRFdZUnBydUtVeWlYY05ISFNOWUkxaUVUOVdFWGt5R1pRZVM0ZzdKNkhR?=
 =?utf-8?B?Vkd1cEpMZElMc1ZOSkFLVmFHZ1BHRWx2ZVEvb2l6dG1ZMkJCVUxUVmFyd3ll?=
 =?utf-8?B?QU56NGdmbzRnalRMWEhjbWx3cHI1dHZ2K1JJc0RITGcyKzd4M3A1SHhoRk1K?=
 =?utf-8?B?Q1dRcG9LYkFCa2E0V1E5ak1OS2VRdzVZRkIrZEkwa3ZObC9yQy9ZdEd2bnk3?=
 =?utf-8?B?WlhJVmhBZXB3MDJCbjh1b2QvMFdNSksydHNWSG5sNlVpa3JXTUd5cG8yYnUz?=
 =?utf-8?B?MHVaSi9pQWdCSGc5ZzZNOEx6ZklqUlFYYjY5WWZHaGc2TW9DaHYrUzlMNHNK?=
 =?utf-8?B?ZEM2QktZNmp5SUpSU1pmcDJMdVFGTkw2Z1NqRTJPQjhjNVVaUlppZFBWV0xu?=
 =?utf-8?B?cm96NHhpVUptZDBIMTJXREttb0IwTFJ4aGIzUHNFV25BRVJYMXNDOFZ1bnd3?=
 =?utf-8?B?VnlxeHp3S05McTZZaDZVaUp5V21abWszMExTdFpOZVNuMnl6NkFLZGdTSFcz?=
 =?utf-8?B?UEdtRzVzM3NLMzBPTjBscjFYeVBtSnpvWWlrdFdERDZ3Y1FybytyWmdMZTNM?=
 =?utf-8?B?ZDluT1VPUFhGYWNLd1VUOHJITHdXdU1VeDdaVGZBPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmJCS3YvZnZCMExJek16cFVNbGwrNWd3ZXNUcE1sWUJMM0tRUCtrYUhnQWVW?=
 =?utf-8?B?UGhwZThCZzZtMTVNVlRMc1FxOExCdk1pUzFsTU04Y0dHTTZDMkt5L3djN0Vn?=
 =?utf-8?B?dWRMVnp1MWdIRnZpTGRRTm9QSDhQVE9xSUNacSs4STcyWXA1V3gwWThCRCtX?=
 =?utf-8?B?cXhrK000L3RUWDQ0WTlMQnN1RGFTaTllZkdnVzlaSWkwYVdvMkZhVHZwZ3Nk?=
 =?utf-8?B?RXI5ekhpTE90ekFjVWk4akg1V0tDSVMybVRWcWR5Y0xsRkwycUdnZmdZU2pY?=
 =?utf-8?B?MVZnTFNITTZTSDQxRk1iNjZvR3ZrSTcwOXhRcGRZcW5TU0xGWWt3ZVgvamlj?=
 =?utf-8?B?ZG8vRXEzSUtUdGM0MDRyMmdoY29Ub08xa2xiYmdaM1J2eHBjR2t5R296MUlI?=
 =?utf-8?B?Wm1jUzc2VWtuYU5JZk9CeThqVmFCWDE2ZUhYZk1iUVIzOUtqL0NCREVrNnFS?=
 =?utf-8?B?MFZqU3o3UXp2dC80VENtOUNsV3FadExYM21wV0paNVVyNzRZNG5BM0MwRFU1?=
 =?utf-8?B?WUlLdkpzT3hsV3MwSFJpUGVnbzVHNW9jOVYyRmM5TnlFVlkwa1F5bEJ1ZGtt?=
 =?utf-8?B?N1dTb1hJZ2EzNmNTaTlSdUVwWSs1NE56bFFlSk4wOG90NWZzMlVjL1B0RHY4?=
 =?utf-8?B?YWt6TUUvZE12dDhBdTBIZVZLcWszNHNQYWw2citQWmpDUU5MYWlVMXlHVElk?=
 =?utf-8?B?Y0l0bVJBVktkZnlmRmNXczBmQjk5Zld5WGx0cWRxTHI5U1hwMUFsMnhCeGwv?=
 =?utf-8?B?STZ3RXBQR3FJZTU1VExkRkFKMTM3cUVhSXhzMkl3NllrdnNvdjI5Y2VYL1Nk?=
 =?utf-8?B?ZVdHT1I4eUR0VTVJOEk3cDQ5YXYyMHUzYnh0eHBLMjR1aERyejZwK1B6YnJJ?=
 =?utf-8?B?QjliQmhjZlY5YldRRTg2TkZoZjVUdkY0ckV3KzZJVnR4OFhHRG1DUmxkYzZT?=
 =?utf-8?B?MnZpZHpZWWpCamVOSDFrK0xwTmZjR0Z5UkJvUHNwcWZFdU5ta2huNm8rUGtv?=
 =?utf-8?B?NEw0QWdHRk5MVjRycE1nank0ZzgwWlprdUpyVU1BSWpxa0VDRHpYS2NjWUwr?=
 =?utf-8?B?MTh1YW92bUpVZWhsRVhKaVlOcG1wM3R0bjU3Q2dQQ1lqVE5FTjJHWjljRkl0?=
 =?utf-8?B?Qk5jSjRFVi9MSzBaamRjUzR3OU1rK0tYL0tEaTRGbWUrQnFTUnFHcGkwKzdP?=
 =?utf-8?B?THNMNG52Z3pUemVhckNTTE5Nd0U5Rlkyb3ZFeTluSHlFL3FJdUl1SW5DeHJD?=
 =?utf-8?B?enA0L0RobnBhNnhBQTFQWFpJU28xclBLM2I5Z3hrRnJtZitJdFFvcmZTTi9y?=
 =?utf-8?B?bkUxOTVvRHYxQVJkTkRRcHgzWGsvNEc5L1cvL2pUWkh5QWNSc014Uk5BekpT?=
 =?utf-8?B?QzUwOVd4eVc1dDE2VDUxTi91eGhONGtZcXM5SEVybzRPQjE0S0NSNnNYckZu?=
 =?utf-8?B?TWV2NHJkQmhWUzVzQm1JZGY0TFVNNytIMW0rTWxzRk9jY1Mvc2NQNG14eWpj?=
 =?utf-8?B?N3o3K29BNnNHeUMyaFI5RTdERWFuMGNCR1ZqaXFQa0xsSngvSWlPYlFmRUs3?=
 =?utf-8?B?dTJ4M29PakplbzFUZjNjdVUwMWRTNmJtbXQyRHRYV3hDbUN6ajByUFp1bVRG?=
 =?utf-8?B?YjRBNjhRaVBqQ296RnZUMmp3L2hqWE4wOGR1TU9oZEtiOWFZdC9RZmVEaFNT?=
 =?utf-8?B?dSt0ZDZCeHRScTFkZkt2R0xxQzdpc3IwZ1lSNnB5czBHSnNDeTFuQktOY29Z?=
 =?utf-8?B?aHVpUkhmcUFZSkt5dURyTitlK1pqa1VaYkhXR0F0dWlkZzd2bjV4RkpmZFhp?=
 =?utf-8?B?b1htZGVmZDN6WmIrNFZtdm5MWEdTVHBTcVk0ZlMyZ3doanNkSklVR0h4WUN4?=
 =?utf-8?Q?b/8ma7+98jBLK?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3927c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ee47bd55-74b7-4617-afe2-08deb2a28098
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2026 16:53:34.8478 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PPF52311D3AB
X-Mailman-Approved-At: Fri, 15 May 2026 20:12:56 +0200
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

dhcp6_parse_options() verifies that an option's declared data fits
within the packet, but does not check that option_len is large
enough for the fixed-size read each case performs. A malicious
DHCP server can send an ADVERTISE with a zero-length IA_NA,
STATUS_CODE, SOL_MAX_RT, or BOOTFILE_PARAM option, causing the
parser to read 2-4 bytes past the option's declared data.

Check option_len value before each dereference of option_ptr.

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 net/dhcpv6.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/net/dhcpv6.c b/net/dhcpv6.c
index 51f44979f8e..640f089a2e1 100644
--- a/net/dhcpv6.c
+++ b/net/dhcpv6.c
@@ -339,6 +339,11 @@ static void dhcp6_parse_options(uchar *rx_pkt, unsigned int len)
 			break;
 		case DHCP6_OPTION_IA_TA:
 		case DHCP6_OPTION_IA_NA:
+			if (option_len < sizeof(u32)) {
+				debug("Invalid IA_NA/IA_TA option length\n");
+				break;
+			}
+
 			/* check the IA_ID */
 			if (*((u32 *)option_ptr) !=  htonl(sm_params.ia_id)) {
 				debug("IA_ID mismatch 0x%08x 0x%08x\n",
@@ -347,6 +352,10 @@ static void dhcp6_parse_options(uchar *rx_pkt, unsigned int len)
 			}
 
 			if (ntohs(option_hdr->option_id) == DHCP6_OPTION_IA_NA) {
+				if (option_len < 3 * sizeof(u32)) {
+					debug("Invalid IA_NA option length\n");
+					break;
+				}
 				/* skip past IA_ID/T1/T2 */
 				option_ptr += 3 * sizeof(u32);
 			} else if (ntohs(option_hdr->option_id) == DHCP6_OPTION_IA_TA) {
@@ -358,12 +367,20 @@ static void dhcp6_parse_options(uchar *rx_pkt, unsigned int len)
 			break;
 		case DHCP6_OPTION_STATUS_CODE:
 			debug("DHCP6_OPTION_STATUS_CODE FOUND\n");
+			if (option_len < sizeof(u16)) {
+				debug("Invalid status code option length\n");
+				break;
+			}
 			sm_params.rx_status.status_code = ntohs(*((u16 *)option_ptr));
 			debug("DHCP6 top-level status code %d\n", sm_params.rx_status.status_code);
 			debug("DHCP6 status message: %.*s\n", len, option_ptr + 2);
 			break;
 		case DHCP6_OPTION_SOL_MAX_RT:
 			debug("DHCP6_OPTION_SOL_MAX_RT FOUND\n");
+			if (option_len != sizeof(u32)) {
+				debug("Invalid SOL_MAX_RT option length\n");
+				break;
+			}
 			sol_max_rt_sec = ntohl(*((u32 *)option_ptr));
 
 			/* A DHCP client MUST ignore any SOL_MAX_RT option values that are less
@@ -394,6 +411,12 @@ static void dhcp6_parse_options(uchar *rx_pkt, unsigned int len)
 		case DHCP6_OPTION_OPT_BOOTFILE_PARAM:
 			if (IS_ENABLED(CONFIG_DHCP6_PXE_DHCP_OPTION)) {
 				debug("DHCP6_OPTION_OPT_BOOTFILE_PARAM FOUND\n");
+
+				if (option_len < sizeof(u16)) {
+					debug("Invalid BOOTFILE_PARAM option length\n");
+					break;
+				}
+
 				/* if CONFIG_DHCP6_PXE_DHCP_OPTION is set the PXE config file path
 				 * is contained in the first OPT_BOOTFILE_PARAM argument
 				 */
@@ -419,6 +442,10 @@ static void dhcp6_parse_options(uchar *rx_pkt, unsigned int len)
 			break;
 		case DHCP6_OPTION_PREFERENCE:
 			debug("DHCP6_OPTION_PREFERENCE FOUND\n");
+			if (option_len != 1) {
+				debug("Invalid preference option length\n");
+				break;
+			}
 			sm_params.rx_status.preference = *option_ptr;
 			break;
 		default:
-- 
2.43.0

