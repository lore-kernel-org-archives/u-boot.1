Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 731E3CCF9F8
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 22:17:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFE8A838E7;
	Mon,  3 Nov 2025 23:17:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=OUTLOOK.FR header.i=@OUTLOOK.FR header.b="N7mFY3qr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61AC2838CE; Mon,  3 Nov 2025 20:33:12 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazolkn190130003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d202::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4012F8331F
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 20:33:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fberder@outlook.fr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r/3EjwJqOWBg1BbZagilA19Jv7s+nym0WPwbb8ZpIyWxzRlADyRGAcBcXX9Gpd54y1H5kql5MBzMgWkt5I04Wb+l+OwyScGEYnESgy0+uVJv2H6YPbjzaQaMxp8SffxjnbptSaZbKetWp/8RlCA36UfXcTYfCfX4PjgXTeSwfLv3EHQuOczWpS6qLEDOVS19TzuStOSQfDWISvN9DHtAI+RDf8z8EePdLIooAIFgLfoscHBPp/1bf6ggYwApwBuDpj4+1uriMf+1gms3c0HWAemzCoDWHq2H0NgrAlColuvoIqosNfGsXOjoWC2/d7AHHNjUXLBsIc00b/Me08//hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8i9bJ9sf7kyPWLnSRckmQLbzto5LwgDBhFuWS/MOTJc=;
 b=lM+lEmc2uC7LMlLX7EtIwXiMbSf6XJs1gHnGIv9Bn0W7E/TlLL5N0SX3YaLXbc3E+gcxC5b4jqWJa2NhRjLyHEopjxG5yJ/2j4veBT0Tt/2q1ohbKdZSVKs8vNzzOq6oOYR1oVzj68rujy4I/vCK935jYrtc/BbdtXByZiRQLyP9jYY7fCc8Fzkb2QDHJctMUxRJhJSVIfZWEgCk7u4WG7pZMRbcTUaYPux7wByG9uvEDuI6UX3R/l8WgWAS/UqNXXkTFm5gk/oBHb5A9z5TJRLNaOl0Z7JFvc+a2DaWOqMfr3wdzwb2q9c6FqJxHm7Wn/ie4Rt4vp3QbwsXu+3lWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.FR;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8i9bJ9sf7kyPWLnSRckmQLbzto5LwgDBhFuWS/MOTJc=;
 b=N7mFY3qrOfMBvjLcg4NQCr58IWeu7Fo8pM3+9v313P6xwamNwJPAWYghBAVE0QXd9pgR6OT/0rV34B4QivaU0RinnddVpKXsA3It/4jJFuXSnpOZlZfltc/CjQBAwQ/XoPXpGnlj6HHgtgUFeiXBLMg3oSfn+MJ7FbE2xcvtW5PFsCdF1NIEdbFHewSGwAxe5IjIDFQQJwU9HKZDr/jtJNoO+Mc234pGTVbpnFQJDEhM99tVDMpSokxT4UFUBdVz/mQF5yXEmtZAxHV7DWfyyHP57MWpgGXwqgzovgRd88lkx9zTgzBdtFzylzPXDevovxR74xPlCfX5BHahTrIG3A==
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM (2603:10a6:b10:e8::5) by
 PR3P194MB0635.EURP194.PROD.OUTLOOK.COM (2603:10a6:102:3d::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.16; Mon, 3 Nov 2025 19:33:09 +0000
Received: from BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::116c:6a13:5362:4f58]) by BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 ([fe80::116c:6a13:5362:4f58%6]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 19:33:09 +0000
Message-ID: <BESP194MB2805FED6670F01FBCA510E18DAC7A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Mon, 3 Nov 2025 20:33:06 +0100
User-Agent: Mozilla Thunderbird
From: Francois Berder <fberder@outlook.fr>
Subject: [PATCH] firmware: ti_sci: Fix memory leaks in
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0052.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2ca::9) To BESP194MB2805.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:b10:e8::5)
X-Microsoft-Original-Message-ID: <3cfb56d7-1568-4ad1-a773-35924b066899@outlook.fr>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP194MB2805:EE_|PR3P194MB0635:EE_
X-MS-Office365-Filtering-Correlation-Id: be2f7658-e671-45a8-629a-08de1b0fd188
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|461199028|6090799003|5072599009|5062599005|8060799015|15080799012|19110799012|41001999006|23021999003|3412199025|440099028|51005399003|39105399003|40105399003|12091999003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N0dINGc4MXorNTBSTlQ5RXp4eWYydGtvWjJ2WWkrbHJJWEhqRWUyTkF0aGww?=
 =?utf-8?B?T25MQzR4S2M4N1ZrNGQwL3RUbVlkTFJPWmZPRXRBdDZ0NklYS251Y2QwZHJM?=
 =?utf-8?B?ZzlpZ2dxdFJXRzZoK2Mwa1RQcmNzb1JYYndHODlqc1MxTjFDclpUT2dhVHhT?=
 =?utf-8?B?T0ZJR3VKc05PTTA1ZUpVcjFHSlBIc1hLMU9ZTTBXVGhLOVJHWmlPQXd2ZlVD?=
 =?utf-8?B?SW1idnRwU2pPdW8xL2d2MlZFQjRQSWttcXZjV0w0bmhROExma2dtQVk4WmRC?=
 =?utf-8?B?ZDFrNXBaejN5d0sxTnduRTFVUkhQVk5GbjlJblBiV0o3eWVIc0pka2tiaTJZ?=
 =?utf-8?B?b0IwMmd0eGwzaUxmanlMQURvV0RkdVFwaFZJejQvOTBZZWkxbEZvcy96aUk0?=
 =?utf-8?B?YU8vbHE0WTBJaE9MdzZ5cU4yT0lSSEVVbFdHRDVHUDhWcStIRm5YUzBmZW5G?=
 =?utf-8?B?MU5DK3hPQjlBR1M0UTdRZG1TNVNkK0w5YWIrT1h2UDFHbHBtc25aQk1JYi9T?=
 =?utf-8?B?NHZZY1NrNk9mZ1VCZjVqM3NKNFBxRmJuU29ZUVlFR0JKMzJSMVJmOE9WK2Jq?=
 =?utf-8?B?V0JNNzZiVEFpTTN4bUVxMmpYaVdWbTF3dWtEZFhRRllmSWF4V0hTT3YxdUZK?=
 =?utf-8?B?K1lzK3VoNFpia3JFcWdqTmtZZndqa3FjNSsxeU9vcU9uNHZXL2hjVW10U29X?=
 =?utf-8?B?T3J4V205QURxTDBLMXpSQUJ0MHdRNHB6MytJTE9CNGlob2xna3A5OWRoTTJo?=
 =?utf-8?B?ZVh6Q1pBamVXYmZRRDlQMkkzUE8zcFdtb09hNFdkVm5xbndOMlVXSzJYZXh6?=
 =?utf-8?B?ejVQVjZiZG5XUXdSOUl1dzh2TmtNYWw1dmZOVXZLU0VRUEpMRUtUazIvUkhQ?=
 =?utf-8?B?cUlHNmxML0w0WHVrVHhSRGlHdWhWNWoydW4vLzhIS1piVnA5cnV2UUcxOEJF?=
 =?utf-8?B?UDljdzE4VGY4a0xmc1RDM29aSTZpeFg4eXA5UFg2cW1rTDFqTjRtdU9vVDlQ?=
 =?utf-8?B?bHFMcDJ5VXJvSCtNZTQybzk2WWk2K3VNY0xHZ0NWeC83Q2wxeVdpT2ltSm1T?=
 =?utf-8?B?RlFLZVloanlTQlcrUUpCRGFPbjd2RzNNUU5XMjI5RVJnZEdGYytLMmZVWlNO?=
 =?utf-8?B?Z1VxTG9PMkVkYnpIRGFZbTFBc1hRMkJhMEhtbXJwMk1BM2k3TUI3dGFSYVV6?=
 =?utf-8?B?U0JVaFF6bnVPUkdEV2h1cHVENkZnamxyOWtwS0ROMXlqbGMrOEJURTFXeG1G?=
 =?utf-8?B?RmxnK28wdEZjOFVWU1hzdGNlc3daZHRRbGV2d3RBMmRibkd0QmMvK2tKdEwx?=
 =?utf-8?B?TzVNWnZLR3N3OEdWS0hESzJTallReXd6UEZuZS9xTFowcTdmREJnYzYrVm9m?=
 =?utf-8?B?U2lLL0RMSjBxM0tJUDVwUTl4VVNQUzFrQ3Zqa0lFQW1tMHNxcFNFUlUwS3BM?=
 =?utf-8?B?Si9MaDRwTzlleTlqZktjc29BWnJlMmZtTUY1N25DdHpBVUFJRGMvYmhPRjU0?=
 =?utf-8?B?eE1vdXRlVWtrTXhDaDM2MGcxSTQ5NlQ3QVRoVm9VMSt2SCttMEwzVVNpMHc2?=
 =?utf-8?B?REV5ZTVuWGNVVklQTjdFa2dqOWJNWEhpWHB4LzdOOE1xZWpvdzBGc2FiNkpa?=
 =?utf-8?B?b3puMmY5dUZhQVF4YkU1bmFpeXpZNllmbFZubjExZ09tNHRiSEh2a1Y2S1NW?=
 =?utf-8?B?Z2l4U1B0elQ1a0xESGZvQWlqM0Z3ODJTZjV4bHRlQ3RqWHVzY3BZTEs4L3Vq?=
 =?utf-8?B?MUZrcm1UcjErUjc4dUpYZkpGZ2R5M1YybUFtWXZxSVpCZlZ2dzdBcy9rc29D?=
 =?utf-8?B?SXlGYml6ZGlnZm1pa1VBUT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjVuOHFmbzNrbWJ0dWY0QWpocjUzTFpvU0p4WWZWckgxM0cvdHA4UlUzMzhY?=
 =?utf-8?B?dzkxUjU5MkYrRlExZ0JuWlJUQWU2aDFVdzJtT3diRlBtdi9RWDB3a1VtelhX?=
 =?utf-8?B?THc4L1NSQ3JwVW1aT28zbTYxRitGUlRYOHNRUENGNkJka1VGVithcnlaSDNS?=
 =?utf-8?B?c0N5MjFMSGpNSzYzb1Q2bjBvczZLclEydWoxVTdRYU1MSlhlSmpHK3FZRGJX?=
 =?utf-8?B?L0piaDNsdWRZMWE5WGtlTWdrMTkzUnZrR2xIUmhsZTRPcks4MWZvcTVaYlk0?=
 =?utf-8?B?Tmlmb2JlRWhzTmVqUEduS2NIYldlaC9TNmdOL0NCTitFMnNyZmdzQllPVE5P?=
 =?utf-8?B?VnV3ZWdJYXJQeGdLdnhjYmszdXNpQzZSWGEwdU0wU1NpeTRwbDVQcCtpaUVP?=
 =?utf-8?B?OFI0ejYxWVVyM1AxRHFtYWhwU01WMCtJU2dnZ01CekQrdDN2VGRnZTlvMWNy?=
 =?utf-8?B?NnltMVdkelBWckpBUGZSTU41bytGM1dBanJKWEh1bDFULzM5clFSQ3FqREN5?=
 =?utf-8?B?UFkrRzk3WTBkQWFUbk9SaW9uMy9RRzh3bU1DWUN6M0lNZjVXNVFjVllFRmdj?=
 =?utf-8?B?SmtaaXozZnAwTTV6TmkvaUFRRVRqcU1uTGo0SmhacWFnR1RCVkhYWW03RXYx?=
 =?utf-8?B?VU9qZTJsaktDVTBsM1VEcTFRWEdIYVdUeDR3WStuc1lFcjhhRGo4N2xLQU1O?=
 =?utf-8?B?cjRObWdlMTBRNGdkUWlhcFY1Uk04RU9ITFRUcDMxSFRLTDNVMDY5ZGhlOFJl?=
 =?utf-8?B?RWFueXVNMVZCMThia3V4WnEveTVDSFJlcFFwRXNkN0w1cDFmekpIVkRUY25S?=
 =?utf-8?B?MkdGNG44OXZNVWNFb2pJMEw2Tnlnc0xUUlk5cEFFbXp6bkZhL2YyR1NYcCto?=
 =?utf-8?B?eWoyTUFOZEdLVDlxei9mb201VzlKS1BzRkRjdG1WMmdYSjZlSVVGNG1lUkNa?=
 =?utf-8?B?VjlJU3FnQkJPaGJLTlBQTVlleVM2WWpMNzdHWXorVmRHNmE5T0Y1NFhpN01P?=
 =?utf-8?B?ZkswbkxucGQ5RFduOTRhaDJrYk5YaVpKT1hsbTFTdmMyM05weE16WmNpTEtQ?=
 =?utf-8?B?MWtvZG1PQkVhTC9xV3NhejlaT2szWDZwTm9TM3pvOFJrMXZnTmxjSDVIQ0Vk?=
 =?utf-8?B?djdudEtEN1RDV2tQUERrWUdvSGpTUTQyTVhRNDQrYUh2M29vQmVpQzJxMGR6?=
 =?utf-8?B?bG5idnE1blQxWFpabGQwS1NGV2dES21TK2pxQkYyTGVheUNwb21iRWhFaDYy?=
 =?utf-8?B?SXRRd3B0ZTdwVzUrLzVRbnBlOVNicnV5WVZ0a2dWWGRVQVZtNW5zVG5ia3VL?=
 =?utf-8?B?QmYyeDBnL1d3ZXZJek5lTVcxckRNTU9JeE1QeE5aK0VwMW5USW1zOEZ1T3E0?=
 =?utf-8?B?RXpSeXlTcFJkSG1KanFCdWNXZ3lPblNOR0dSWS9BTkN1VHp0NnpWU0JLRGxl?=
 =?utf-8?B?M09mK1NTdjkvRDhiU0RwY0xTb1BTYjZhZER4MGFlSFVtdU9nVnR5a01BanM3?=
 =?utf-8?B?QU9EaXhueTZHQVNRVjcwbVBXR2h4alZZc2kwZnoxN2RWeHNTV01kTkhIeDQx?=
 =?utf-8?B?dHJDOUtHeXVTRGdPUVRzaXgwN1did2dBWERTT0F2TFJiOTNNNVpFTGpHanpG?=
 =?utf-8?Q?KRDfTC/ipVNykFCbZyaHE85qpEkP3cgtuCJ9qntADhK8=3D?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-9bdce.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: be2f7658-e671-45a8-629a-08de1b0fd188
X-MS-Exchange-CrossTenant-AuthSource: BESP194MB2805.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 19:33:08.9105 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P194MB0635
X-Mailman-Approved-At: Mon, 03 Nov 2025 23:17:38 +0100
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

Signed-off-by: Francois Berder <fberder@outlook.fr>
---
 drivers/firmware/ti_sci.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 8013afef304..2b62c99e79c 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -3081,20 +3081,32 @@ devm_ti_sci_get_of_resource(const struct ti_sci_handle *handle,
 	sets = dev_read_size(dev, of_prop);
 	if (sets < 0) {
 		dev_err(dev, "%s resource type ids not available\n", of_prop);
+		devm_kfree(dev, res);
 		return ERR_PTR(sets);
 	}
 	temp = malloc(sets);
+	if (!temp) {
+		devm_kfree(dev, res);
+		return ERR_PTR(-ENOMEM);
+	}
 	sets /= sizeof(u32);
 	res->sets = sets;
 
 	res->desc = devm_kcalloc(dev, res->sets, sizeof(*res->desc),
 				 GFP_KERNEL);
-	if (!res->desc)
+	if (!res->desc) {
+		free(temp);
+		devm_kfree(dev, res);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	ret = dev_read_u32_array(dev, of_prop, temp, res->sets);
-	if (ret)
+	if (ret) {
+		free(temp);
+		devm_kfree(dev, res->desc);
+		devm_kfree(dev, res);
 		return ERR_PTR(-EINVAL);
+	}
 
 	for (i = 0; i < res->sets; i++) {
 		resource_subtype = temp[i];
@@ -3119,13 +3131,31 @@ devm_ti_sci_get_of_resource(const struct ti_sci_handle *handle,
 		res->desc[i].res_map =
 			devm_kzalloc(dev, BITS_TO_LONGS(res->desc[i].num) *
 				     sizeof(*res->desc[i].res_map), GFP_KERNEL);
-		if (!res->desc[i].res_map)
+		if (!res->desc[i].res_map) {
+			int j;
+
+			free(temp);
+
+			for (j = 0; j < i; j++)
+				devm_kfree(dev, res->desc[j].res_map);
+
+			devm_kfree(dev, res->desc);
+			devm_kfree(dev, res);
 			return ERR_PTR(-ENOMEM);
+		}
 	}
 
+	free(temp);
+
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

