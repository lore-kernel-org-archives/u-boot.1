Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62895606A323
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 13:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SSAx8FnA;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=Sqi3PiSf
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 34C5060A3F;
	Fri, 13 Nov 2026 13:42:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5j0papnKJ9HZ; Fri, 13 Nov 2026 13:42:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0615D606F6
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794577343;
	b=grtFc/zBZqDQSseI+Pt2G1Ia44Dv8iueKzKtlxSfZhZsD7hqp6ModaWsKb7sQBR/4MP2
	 PbPg/xtoeOHWq/lsRgCjA1RcrCqv7KFIMkwYhgHxbrh6xe/izYoyy1T/HB/SqVg30WToG
	 NdYF70IMICeiVXUEvf/gOR7c0/b/7bqSqWydmKVms90uYQ2Yau21M9VVnXas9omVrVowa
	 jOhPh4b4B2D6Xoh0WzUX6mu0jjms63v0rejuxalGyn4VNi76JSCvvpfC1E10eVUl1aMyi
	 a4c1rqXHpkykJHheqSwfp+O6np4Y/11UHsn+3+pHCutI9xdGfJGp+PNzgEMTiJRSHIg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794577343;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=K40TMT5M/dJLK103gHOLuNcNHSc2TI4/w+NZVYKNlM8=;
	b=pJKgS6+3W2M+HHWum7Cg8fse86bNospV9UqcT87QrkLQrTx+ry40/vuyh0iqddRXRPDC
	 Bi7SXOkCFXy3OXsLd7TXKYDwbFCDVv/vIb8nL4HW2i5KFHOY5gFjVjbdvrX3dGh3IIk1t
	 pIvu/WJcVbvvJA6mK7gAd/CR/XyGs7CvjXM5+WxkpsxPJ/9eR+eRPm13kfdk8sfFa8FAA
	 L6k+uHZ6Nx+lNdFUi0vDIfhGKP/TTnIuUmag2lvZZ07+FAF/RMtknDqIzfPDX8bVeTui/
	 69idjfX8tpABBe2xu2I+CcRf7OlumXqNHA91Enghu4kHiLnO4owwEGLmH7WiEF1G8zw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=Sqi3PiSf;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794577343;
	bh=K40TMT5M/dJLK103gHOLuNcNHSc2TI4/w+NZVYKNlM8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SSAx8FnAiUFoOusnpSApySlPQ5e0ptdiCXfs0FGtFQL/TEj97zRDIuLeXBwxix9J3
	 zvEEu/p3qTHfRaeUec/wyEKH7Fip1dMbX1ZesrdUtEV7bwpqIzBmCa/UsQiSlXFqQX
	 P3T6FXQm74btHburFTzdR4dQHaOYxe9jEiezJrKaXo5dYz5GSbmGMw7ZUC9QC0uU/9
	 3eyhkrt89O1DSruhHjVJMcthw9t8AbwH1Tu2Tfq5Lnw8LzgWe4fGIYKWG7GkRnO5l7
	 KxZ5bwzrKjjmXy6YJ6v0u0PfYQHiH42tzjkQDzik20fD/BSPxOoM2Lz8+QHW693kpD
	 WGbj4MGbh6dBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0615D606F6;
	Fri, 13 Nov 2026 13:42:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C588A2FE
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 13:42:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A843B606D3
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 13:42:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y-toGypmehup for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 13:42:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6BDC7606F6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=Sqi3PiSf
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6BDC7606F6
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 13:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K40TMT5M/dJLK103gHOLuNcNHSc2TI4/w+NZVYKNlM8=;
 b=Sqi3PiSf5fXXNeyfrOhLaySENWF85oaBqsjyLw1hrbX2+AQt/fioXp7n7uiNEx1lopelVdjyajGgegg54uANwFpcAC/zuSXNAsVqFoDohEBDhRs7q8AGUXGp6uTGk7blxVBhef+84L2VJ0ndLYdi+UsBX2jSkJzUjIv7w8J1oT4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AS4PR04MB9242.eurprd04.prod.outlook.com (2603:10a6:20b:4ca::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 13:42:11 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 13:42:10 +0000
Message-ID: <a2622b4f-0f43-4ada-9345-1cd4b2249a32@cherry.de>
Date: Fri, 13 Nov 2026 14:42:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] doc: develop/sending_patches: add tips for series
To: E Shattow <e@freeshell.de>, Ralph Siemsen <ralph.siemsen@linaro.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>
References: <20261112-doc-sending-patches-v4-0-d6f4b7e3eeba@linaro.org>
 <20261112-doc-sending-patches-v4-1-d6f4b7e3eeba@linaro.org>
 <33c70db1-226a-4108-b690-ad07cecf7752@freeshell.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <33c70db1-226a-4108-b690-ad07cecf7752@freeshell.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR4P281CA0301.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::13) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AS4PR04MB9242:EE_
X-MS-Office365-Filtering-Correlation-Id: a2e2ca9e-0352-420b-df67-08df418bea5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|6133799003|4133799003|4143699003|261026130827099003|10067099003|11063799006|5023799004|56012099006|261026121527099003|261026140227099003|261102123227099003|261028144727099003|261021130227099003|261021123027099003|261021133027099003|261021135927099003|261021121427099003|261022075727099003|261022113327099003|261022105027099003|261022115727099003|261026135527099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: YeiZ5Hcy89u915MLSTHcwpUtWoWtuePlVaeh6OBSIR6m2PROyZP8ullZWjebS8b0U6EbzbmVVuqGjcU0xtRRkVg1mFaj017ZDKKKm1gQlT/x1FiyRUZrzfzDDlM6pfgLmz8Cphrq6Zc5X5FbUXKz6b56snWy+3GmHX/tp7SXaqnQXHs+FfxYEHJW5RLO1Yq0naEXsOUdFzU/2JTP2l9NouM9wK6yA5sFecswfAVFpHWrVbcmb16/bz5PsV7Xxvp9bIHt3z7CvHAS0q5J7YcFv/Bm74AioczucS1xUjoUrM2hjN93sDDEYlQRsErW0OB7oTXAmZry/AYAxWg3kM/Or17OBhylqcry5m3Ge8ef5zLEjKYISFUHRp8WF8TQ6/9QQi6pcGwYh59zUgduaxhrGFIO1vuEfqnfyV8UnDD8Bhof8L3agdtQQGPJ9wxSJ9fKJfvrffZuR/fiqULy4uRcTtqd54ewuR5mTKFBLn9qgUKM2bmrarpEydkLsxYqgAiBpyLe3k86jb8m6nUaKxCrDResEKtpHMPoXCyL0Lv9sZkVxh9z3WBPypgZdVCvEolGEt6C8LUtwpnTwtDnoXbIoZAPv/SO6TeF6huSIJ3OzczfOUiMKPJ3YJ6cxyLMe/g1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(6133799003)(4133799003)(4143699003)(261026130827099003)(10067099003)(11063799006)(5023799004)(56012099006)(261026121527099003)(261026140227099003)(261102123227099003)(261028144727099003)(261021130227099003)(261021123027099003)(261021133027099003)(261021135927099003)(261021121427099003)(261022075727099003)(261022113327099003)(261022105027099003)(261022115727099003)(261026135527099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXhITmFUTEtoTFNZYlpUZjNsRlNKVmU4TWVIZ1ZSQkh6czdLS05KclRGWHpI?=
 =?utf-8?B?TmlMaTJKbW9XeFZNRFZjM0hFUHFRd1Era3JVcHorZDE0enRLc251bEh1V3FF?=
 =?utf-8?B?a0xUWWRWbXFFb2dSZmxvSjV5MzJBdWo2SUkxQjlNY0pTTnl1ZVJDSTlxazdj?=
 =?utf-8?B?c205b0hYdjdxdko3L1ZUMjdGMmt6Mk9DZ1AyU1FNSmZxUmxEbSs5b0JGYjda?=
 =?utf-8?B?Z0hzQ0JZcTVGVXFaZTVCajB6WkRSdkQwandsU2d6Wk12cEg0Z2xKNkJFTDJH?=
 =?utf-8?B?UVQyNm1yb0pSbEJxTEo1L2FkcG9SYzU5dDJsa1pudHFLOUFiRndSV0dlOU42?=
 =?utf-8?B?cGxydmhLTkZrcWFZTENkaUJKVnVpdWV0VXBQeklKT0lGbXBaU05iREtsN3Nn?=
 =?utf-8?B?NmZXQWpnbnp5dDJzK3k2NURLRERwVHFWZzRUbVNXTC82Y3BpWmtmYUJmcnlP?=
 =?utf-8?B?Q3ZjdWYyUzhTSXdBbE1nUWxDY0RJZzBQdnFkZTdTbTIyeXdIN3A2Mk4wVnV3?=
 =?utf-8?B?aTFxVjJrQnc1Tnp1RWZKNjhMczNuNzNITDQ2TWF6WHZJNGhGSkZWN1F1N0FQ?=
 =?utf-8?B?amVFaEdlYk1mVDBJSkVmYVIzQk5pRjRVT0Ntd1BjTWVFYzlhUXBRZWptNU9M?=
 =?utf-8?B?cWQ3ZEZkaHVjNElYWXZua2JKNWhHY2QrTUtvYkdhaTNReVZiS0h6VWZDSnV5?=
 =?utf-8?B?dGxTSHR0RlRlZkFaT1Q2Q3BzeXpnNlNwdVp5bC82QjFWYm5iWTdtK0svZ0Ra?=
 =?utf-8?B?QzQ3NTNkQ3dFL1VjZG1UaTh5b2EydmJkS0p6TlExYzgxZXR1Q3RXNzF3TlBr?=
 =?utf-8?B?L0FDL2hKaUxiZlZsYzNwR2hsWXNEVE9OUjEzSytQdEp0a0FpUk9yc0VXdkxZ?=
 =?utf-8?B?ZUZBZmF6Y0lyVnBiMllTc1VMWDJ5ZDJ0NWlndjZGMmtoclJ5eUJ2NHZmMFRB?=
 =?utf-8?B?aWZDTW10YTdMdm9iZ2ptWlgyWEJjVXJTUDY4OElmc1puTzVPaVhhMXR6K3Bn?=
 =?utf-8?B?dkJFMmxsN3UxSGRxaXY2RmdpNEFjZDN1NVJsUml6RnJST3Vja3pLYVo4dzhj?=
 =?utf-8?B?cXdGNndBOWwyR0ZOd0dUZmhqYTJGaVkxdzZWUTJjaFo5UnowUTJZT3VoWTQx?=
 =?utf-8?B?OHdhTE9tN1VtUmxxZDBnTHFCUGZBNkxJSllmMkRDSkYzbjNyVUJxREJJTXpI?=
 =?utf-8?B?OWsyVVY0NFpUU1RSNkZBVkEvcGZydFpydGJxRFlPSTJqM0VUc09zVHVzWjRu?=
 =?utf-8?B?d3MwRk80NTVBcVZCenJxS0ZFMGRWWXFybXlpY3VVU0tsT3dDYVFjbE4yaW5U?=
 =?utf-8?B?d1RZbk1ueXBtVE96d0hRS25TVWRrSXQ1TVU2UEJtL1RSTjBaT0RYYUFZYlo2?=
 =?utf-8?B?UjFnNmFTbHpsT3hFSWVZVC83WHNPVnUveHRoMFhINGd2aCtqTGJXNGdzRmV1?=
 =?utf-8?B?ZC9wOTR0YWx0Vi9pTlB4Nk54WFFuNmxXdDNIZkVIeTh3RS9GUkpWR2MzMWJx?=
 =?utf-8?B?TXZDalNaUkVxN1pXcVJzZ2s3KzdGMlNTWkRmWUZTK3pyWlYyNU1UUWRQLy9U?=
 =?utf-8?B?VjdhaHNBdmhGZlhXelZCV0VMS2NEbE1pek80TjJxSlNVSGVvdytCRDBVYVp4?=
 =?utf-8?B?MU4zZTZ2cmNZWENPc3MySXRJMUdqRWN0a1JJZDN6ckJzN2RmdFVWZVZtTEhI?=
 =?utf-8?B?bXN2d2QrREx3dFFOWnROREhMNzdMSVZ2QmN5V3laMjNvZGJTQWFrb0tQWU8v?=
 =?utf-8?B?dkhST3VYR21telJ2dUhkU2tOS2ZiNjk5NDd2TngySVhDNW1nRldGcS94WnVv?=
 =?utf-8?B?ZG1RdFkyVjJwT2xmWk1TYXVxb1dlc3d2clF4SXZUbXpyQTdRTTh1aEUvR2Rk?=
 =?utf-8?B?NEVRSVRGazVkcHZDbVRiZ2Y4NU5VNlF2alZ2bllTVGEwUG9WcVdpUWhKQ0No?=
 =?utf-8?B?djluOGV4M3BVR0RKVHQ4ekNlYjJTM01JTWtiRjFSdHNNeFRsek4vcmx2VllW?=
 =?utf-8?B?UUI2RWthcWZrQ25lY0pCNDR2S3J4dTJxbG94K3R0OC9nNXJ5Zm1NY3hNa0p5?=
 =?utf-8?B?UXBZNHNnaldrNDh5dDFDT3NzOFRCV05qdWNuRTFHNkRHaDJZdXlrSWpVNmo2?=
 =?utf-8?B?K3RFVFdyK3M5ZlEzeUtldjFFa0loZzY4UUtXRGRJWXZLRnBxaDE1NkVyajZa?=
 =?utf-8?B?YTRLRDRTZE14ekRwTmRITUlaQ1Bzb1p2djc2ZHZRaklJUGRnU3FIdmpMckc2?=
 =?utf-8?B?dFZWdTFDbHBGT2FwbjkvQUJMMDhEanZpY2pMc2o3Q1Y0NWNPK2Q3WFMyVjZV?=
 =?utf-8?B?cE9va2Z5bVNPQmYxRjBqSUpDSmpXZmtUeFVmdEo3Y1hHWU82MC9Hdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a2e2ca9e-0352-420b-df67-08df418bea5b
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 13:42:10.0022 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tnxQ9g7sKvbp8Ynmw8FvL9ORUQnkd7ew0UOPIyVGTY1FLrRd+oa6SV3ExCdw+bc/S2k6oZa4dnd5c//HgbS8UikaFIDDWp/exTw09e4b1z0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9242
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi E, Ralph,

On 11/13/26 12:19 AM, E Shattow wrote:
> 
> 
> On 11/12/26 13:55, Ralph Siemsen wrote:
>> Related patches can be grouped into a "patch series". Add some tips on
>> how to decide how much belongs into a "patch series".
>>
>> Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
>> Reviewed-by: E Shattow <e@freeshell.de>
>> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>> --
>> Changes for v4:
>> - spelling fixes
>> - add R-b
>> - Line to v3: https://patch.msgid.link/20261106-doc-sending-patches-v3-1-86fa7d158cc2@linaro.org
>>
>> Changes for v3:
>> - explicitly mention keeping bug fixes separate from other changes
>> - focus on "keep it small" rather than the exceptions to that rule
>> - Link to v2: https://patch.msgid.link/20261104-doc-sending-patches-v2-1-c0a90ff6c049@linaro.org
>>
>> Changes for v2:
>> - small wording changes to help non-native English speakers
>> - add R-b
>>
>> Link to v1:
>> https://patch.msgid.link/20261028-doc-sending-patches-v1-1-66b0f1b276de@linaro.org
>> ---
>>   doc/develop/sending_patches.rst | 25 +++++++++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>>
>> diff --git a/doc/develop/sending_patches.rst b/doc/develop/sending_patches.rst
>> index 99581dc0ba0..dd06d4a8968 100644
>> --- a/doc/develop/sending_patches.rst
>> +++ b/doc/develop/sending_patches.rst
>> @@ -184,6 +184,31 @@ General Patch Submission Rules
>>     cases, you did something wrong if your patch exceeds this limit. Think again
>>     if you should not split it into separate logical parts.
>>   
>> +Tips for creating patch series
>> +------------------------------
>> +
>> +A series of related patches can be sent as a "patch series", as described
>> +above. Individual patches should be small and self-contained. Likewise,
>> +this also applies to each "patch series". Keep the following in mind:
>> +
>> +* large series are harder to review. Maintainers are busy and may postpone
> 
> This reads a bit awkwardly. Maybe "A large series is harder to review"
> or "large series patches are harder to review", depending on what the
> meaning is you are wanting to convey.
> 

Did you mean to ask for clarification on whether the "large" part 
applies to the series itself (the number of patches in it) or to the 
individual patches in the series (multiple large patches in a singular 
series)? I think it applies to both.

> Either seems to me like injecting your opinion about what is easy or
> difficult to review which does not align with my view of this that the

OK, what about

s/are harder to review/typically take longer to review/

Would this be better wording?

> difficulty in reviewing a patch series is proportional to the discipline
> in focus the author has for presenting their idea and developing it to a
> meaningful change with the assistance of code review;  if it will

How does one know their discipline is up to (y)our standards?

The point is not to give a recipe for patch series you have to 
absolutely follow, because no such thing exists. Here we're attempting 
to give something that is at least quantifiable as that's much easier 
for people to gauge than quality. Is it perfect? No, but I think it's 
still some improvement over what we have today.

People do reviews differently, custodians have different (often implied, 
sometimes not consistent over time) rules for code under their 
custodianship, we won't find a "rule" that makes everybody happy.

> require a great deal of involvement then don't expect to just dump your
> code off on the list and have it be merged because you gave this "gift"
> of 100+ small patches in a series, or even a single patch large-or-small
> that is several disjointed ideas or bug fixes.
> 

Single large patch is covered by:

"""
Individual patches should be small
"""

Single small-with-disjointed-ideas patch is covered by:

"""
and self-contained.
"""

As well as

"""
Patches should always contain exactly one complete logical change
"""

in the General Patch Submission Rules section just above the one Ralph 
is adding here.

The 100+ small patches in a series is covered by the second sentence in:

"""
Individual patches should be small and self-contained. Likewise, this 
also applies to each "patch series".
"""

What are you suggesting as changes to make this clearer?

>> +  large reviews, whereas smaller reviews are more easily accommodated.
>> +
>> +* bug fixes should not be part of a larger series, so that the fixes can
>> +  get reviewed and merged quickly.
> 
> Nothing happens "quickly". The point of bug fixes being independent is
> so they can be reviewed and verified independently from unrelated
> changes. Quickness is not the driver of getting merged or not merged, or
> it should not be.
> 

Fixes should have higher importance than adding features. Fixes can 
(with some exceptions) be merged at any time in the development cycle, 
whereas new features, new drivers, etc..., can only be merged during the 
merge window, 3-week-long every quarter.

Contributors care about their thing being merged quickly so they don't 
have to send new versions or make sure it didn't get forgotten.

>> +
>> +* tools like ``b4`` and ``patman`` send the entire patch series to all
> 
> Do correct me if I am mistaken: for consistency I think we are
> recommending people use b4 and patman, and not tools similar to these.
> 

You can use git-send-email, or whatever else tool you want to use. Send 
us patches we can apply with git am and that aren't attached to the 
mail, the rest we don't care. We recommend b4 because it's much more 
accessible to new (and long-time, I use it for every contribution) 
contributors. We recommend(ed?) patman because this is what some 
contributors/custodians are (were?) using before b4 came to life a few 
years back.

>> +  reviewers, even though individual reviews may only care about some parts.
>> +  Filtering out the relevant parts takes time away from actual reviews.
>> +
> 
> What is an "actual review" ? That sounds so strange.
> 

I think the point was that merely looking at a series could count as 
reviewing, while looking at individual patches in depth also are, but to 
a different degree. I think what Ralph meant to say is that the second 
part is an "actual" review in the sense that that's what the contributor 
will see once they receive feedback on it whereas the filtering isn't 
something visible to external people. But I don't think it brings much 
to the sentence, so if Ralph agrees we can just remove it and avoid 
confusion.

Cheers,
Quentin
