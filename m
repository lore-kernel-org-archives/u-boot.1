Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE914606A330
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 14:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=N+P7Gbns;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=mC+75DPs
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8078160907;
	Tue, 10 Nov 2026 14:43:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6b_-5TN3ANSA; Tue, 10 Nov 2026 14:43:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B9529608FF
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794321812;
	b=IbS7/WhFJUurm58pBofad/zyfIZGWklwlKEx9dMDayUyq/+zLxw+ptZicqgJYPER+agf
	 boYOX3pyE0knGhmB9yjJwx6jcMMPFISMyZOfwTMyiyT31Ni+/Kg8EkzQgnc/DTgclvTMv
	 p5oKCKptOIQs9KpyYbVxeI849DmWHCumibC9kJ0b8N2IUznxfnHlsWipGlUewygtByj55
	 PE6kjDCafNnFsi0kTMUYNTXo1IvjOHtN1I+jFIBuEKTKjRK9WO8d1OdCvFEG+Pe37DH8T
	 KSapMDHg8MDzsGy22obW2mqPH2Qt/llxCBnoAkTvwfXnHetP8zDMtgcwafAdVYlh7+w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794321812;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
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
	bh=fizfb6Qtchx1T8O7HXpoXfZtPPFJQ9hJC1sDJB+jJ1g=;
	b=gpDgcSt/jK7mOvBa0OSG9EbxLdN5B+hYDm7Up8iLPqNQzLbD/gKOxK1mPobuZIa2sCt1
	 We1ON0bEmC5zjIw2ckNoI245RLo64vOOstjCr7G9lNilau/SO85ZaoCItklQOD2teRdXG
	 21+MoAR0cWCPPRvSJweWuRPDiZemPCU2qkDVY7YzVr5Oo2BuL3Sf1oqgOeIY4+L+16lBG
	 NHXhTsshA2sTAMX04GkHArlZ9vJLmK9GwU38LaOXmEsjgEzkLODGPUb2zPXSLE2bNXFA6
	 G//8Yk8aiTWopsQii+/8tkNQW3UULgf78jjCDRFjkhAqbyUN+5ZotUaoBVDzuAsGsog==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=mC+75DPs;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794321812;
	bh=fizfb6Qtchx1T8O7HXpoXfZtPPFJQ9hJC1sDJB+jJ1g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N+P7GbnsdBcgCki9m7iOnq/JRCIsJeFjH+0t4Bp5xrR9OT1oUd7T3cYVMJkEByCT3
	 +gSu7ME/KAiqdhafazFhBXLZyHHDCVxrXkTg64CmBPwB4H9cIpCI7DLBmPyjdmf5wk
	 YXCMtEPTMRR+ecfhKCa/JXtIo1dR4gPOgZ4jkZlZzBJdohnSd6gzopLNaze/EB4AF3
	 fc70oowiaMGOeKueFpeTrvxGuqXAsu7v9FLKcvUhQYfZpkEuxyYVAukF4spZ5BwPHe
	 5dqyefcd5Haanm0ahXeozcbpwmYziZAttCY/xHMmq793kAhrQMaIzO1tGlinQIYiiM
	 h1t5+cErcVgMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B9529608FF;
	Tue, 10 Nov 2026 14:43:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DFE449D1
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 14:43:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C64B5608DD
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 14:43:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qqaWQcpadZKA for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 14:43:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CF948608FD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=mC+75DPs
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CF948608FD
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 14:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fizfb6Qtchx1T8O7HXpoXfZtPPFJQ9hJC1sDJB+jJ1g=;
 b=mC+75DPspncNtgFlBenASEwAyFRtb2ZRgRl+S76YFhV3MQAM00/UVEM21YIorJAlphX+qIuFiAp258rbnd8gdNiQu1HBL+0CNCZnHGwq12nDT3QJ+Z33vF8mRmLPBZfM/5AywrrOZy/d9jODmFewnwoRuTvlhMf+fsSzRHtKA0A=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AS8PR04MB7493.eurprd04.prod.outlook.com (2603:10a6:20b:293::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 14:43:24 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 14:43:24 +0000
Message-ID: <b6246d02-b4eb-44ca-ac8a-e4772860533d@cherry.de>
Date: Tue, 10 Nov 2026 15:43:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/12] test: Do not set DTC environment variable
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 u-boot@lists.u-boot-project.org, Kory Maincent <kory.maincent@bootlin.com>,
 Linus Walleij <linusw@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini
 <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>,
 Alexey Charkov <alchark@flipper.net>, Francesco Valla <francesco@valla.it>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Carlo Caione <ccaione@baylibre.com>, Yao Zi <me@ziyao.cc>,
 Michal Simek <michal.simek@amd.com>
References: <20261110-qcheck_fix-v2-0-1c76e0b68f29@linaro.org>
 <20261110-qcheck_fix-v2-3-1c76e0b68f29@linaro.org>
 <a714c089-680c-4698-bc8b-4cc0366f68ef@cherry.de>
 <906a1084-fa5d-43ea-b0f0-6a3edbd60cc1@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <906a1084-fa5d-43ea-b0f0-6a3edbd60cc1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0092.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::21) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AS8PR04MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: eee7780f-1a04-46d1-254a-08df3f38f97b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|23010399003|10067099003|11063799006|56012099006|261021123027099003|261021121427099003|261021135927099003|261026140227099003|261022075727099003|261022105027099003|261026121527099003|4143699003|261102130727099003|261102123227099003|261028144727099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: KfEAYgP1MUqqY87eF+KV07VrAr7xFcw9Dw+nhYKCIytgB3NGOdmYDhksE+RcnkbnOh4iV72EwtcYNXTYwxcsVJnD4uAstZPNVcTBTwMRCej/vSC/M274rgKNSoYkhTiIT6ZXEYH0ygScs+LIT6tFfyhBhg+G4puEUFDEHsLa7XpajygiX+CXM9F73M7tgRNJFeoR+w3uf/ii60n7dTJ7Oivp19k0oSTDcwE+HF6M92GGK5opCMQhiZAMdKh+Opu4MdhXlCLHBjSFapxcmyMm6pXTwZpJ+CTDzPJDamQo8RcWNQhR0pJyPB7w3gkv9E30xy+JN69V0m2BUcKRSvnJBGqi/kNRmvf6D3cv2vxJ5R8dkeciOshZTy8QTxf5UByVISbezILK9wjaQ4VpddRBMV6gEzu5cMD3/vY+aXQeMvO9bXIWi1D/f2ud5VbUnKSRZ+2hwfQmTQZjONLRSXGl0ZWDsyyxIEeknvJjTqjg6eZEHSnEXrtL2r7Zk4ktmTSFPzhGfW/8sXLuVgUNdJSZOcSzuYXLrjgBBEaSt9DER5v05tXH9FeOkoUqMale+XFKPi5ANTJdXxugJ+/apl3Lv2MeDwEpgukTW94YPdtwtz8u69YABQe41qDV/VCDZV+JEZjTC0L7TmqbXLEAYpUmKKjAROPmln9jTNBTupH/Q8A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(10067099003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261021135927099003)(261026140227099003)(261022075727099003)(261022105027099003)(261026121527099003)(4143699003)(261102130727099003)(261102123227099003)(261028144727099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGcwWHFKNFhhZW5QNkM0MnV1WW1TWWpuZ0MrNG5kaXdzRlc5c21leEROc1ha?=
 =?utf-8?B?cHdnTEdXaFZsVThLRGpkSlJKWGovVWNEYXE4bWp1cVZ1VE1lTk13TWV1OHNX?=
 =?utf-8?B?a2xvcWVHRDNHYVFEMlZlaHEvcjBvV2hjdWY0blVFMGRQa3lhL1JOanJPS1ds?=
 =?utf-8?B?NlIyd0o1ZVM3WTBTK1NuS25qKzdNQ2xCM0h2cElROHdoUzVqTHNQdnQzTWc5?=
 =?utf-8?B?RnkvQkdhcXRGbnJNOW9KWkhGcFVVUUVVeVlQWjlqcTlucEJFaFRxRy83d3FY?=
 =?utf-8?B?RGtHY1VNbXMrbDhPOXNmdEtlTTFtZnBjejdaaDkyYkZQTitBL1dxY1JaNEM4?=
 =?utf-8?B?aVVGbG5FTUlUMlpUTXIxL0VmZlF1VFk2ZnpsQ0RzektqMUtaM3Q5OEdIQjZB?=
 =?utf-8?B?OUVmOGVUMTBnK1dUa2ZDeEpNMmRIZStBNlk3NlNlMldZQjZkNGp5dDR0VEt2?=
 =?utf-8?B?c29MV251eExvRXF1NlB4UWptalo3QW5QZ1ZUZHc5eEowRU1kSlBNOUs2cG9n?=
 =?utf-8?B?cE52ZE9xT0htY0NFaTNDODhaMkpUM3p4UXdmcHREV0x6OUxCemhmQmlKR21N?=
 =?utf-8?B?aUNqSS9waElmaDgzVnJMcWJwUG9FeG1EQlhuek93YW1nakl1S0h6MWhxVHpu?=
 =?utf-8?B?Zm5nWWJJeTJ5ZnppOUZmazU4NmlucnBpekpJeU9hYUhPdG1pTmdQbVJCYkk0?=
 =?utf-8?B?ckJPa2NCNWs2T2kwMjZmTVdxU0pzK3dDdXR6YXVuT1piaXp5bkxuNnJNZURs?=
 =?utf-8?B?dHc0NVNScjJDSkg0T1k3UkJVUlpTVW8yQ3BhcGlkZFdkL09qVmorL3V1ZlpX?=
 =?utf-8?B?cTZaQ2cyemkyUHZPRElWRWQyeGdxTTNLSDBkTHhXNDJVemxlZ253NFJFT0hJ?=
 =?utf-8?B?T3dRWjdaakc0dG1tbE5sVDd3cE9vVkQxU1E4SGFRRi9haEN2dGdjWGI1Z21G?=
 =?utf-8?B?ZGJxZDdkWXhYdHRWSG4vV3BkS2x2T2hOblJmTEYwMkpYWjNkQ2VzZmY4akFq?=
 =?utf-8?B?R2JBQklhak0xaUM1YTlScWk5dlNZR3V0ZjZtOGxaZWFLdXIzR1BpRGNhMXM1?=
 =?utf-8?B?UjFpbG9WaHRWQmxUeWp2TXE2OUU1TlZCa3ZmdHl4alUzVEpVTzNtY0RVMnd3?=
 =?utf-8?B?VDF3YlZWQmM5V3hCMVVuMXJSSjJHV1BKQlZWZVBXTDVVYkhoZGZKSTRjbHB2?=
 =?utf-8?B?MzJ3cHRSN0c1aWdaSDh6dU9lVjN1U1hUZHRzVG55Qi9udFZra1FtSmJ1REl5?=
 =?utf-8?B?d1d5WmJGd3gyM2k0N2pKL2lRRkd0TU5VajZ2SGpsOVhWODNmS0FKL1NoOGlI?=
 =?utf-8?B?Q0t6S0p6N3FwWFpQQUMvclVmY28xakJCUCttMjZRNHpoOC9LK3EwejhYTFdQ?=
 =?utf-8?B?dmkwWGNJcktvT0wzUVkyanRMRUtLWDFMUldDTDN4V2RSQ0FFdnp5MlVuRzZH?=
 =?utf-8?B?cTlBUjdtOHN3UjQ2WUpYemgvd2plWGFaS3NXREFRMnZkNGFnQklHWkVhME1z?=
 =?utf-8?B?RWN6ak45eXZWZklRVVJpYytuYlhzbUVYblpUUmxDNWtpVWRKc1lqNkxmL3Za?=
 =?utf-8?B?QlluY3FwbEZKaXBPZjdTcDQvV2V2ckxCaVppa0hiTVZ0UVJ3a2cxVnFqZC9N?=
 =?utf-8?B?ZXlsZFVFOVorZS9nV3JHNjBGQmlHczhZUE9XWlZOaG9UNEY2aXlGd3hQZ2NT?=
 =?utf-8?B?aVJnOUlVVW1ycHB3eXdKK0pxVHZubWRRSWovTnRFMTYrR3MxYVRFL0VXbVNC?=
 =?utf-8?B?NjNYSi9IMkg0WWtKcGlEeG44QWFyUkx2UlJ6MU9GaWNDRXRVQXE0U0RoMzNC?=
 =?utf-8?B?TjVIU1VtZVJlZVFWSEhVZnA2SGFjVkNnYm0wV0xRemU3MnBneEt0bDNWUVFm?=
 =?utf-8?B?RTZ4VVdTZlJrYmNSN016RkVUaGdJSkVsSFVJNnNESS9vbWsweHBCWGZLR3BJ?=
 =?utf-8?B?U1hGbmlvenpPMTc3eE5qTm5PNk82UHNkUTlKRGR1ekZsOUJGOG15eFVMdk1R?=
 =?utf-8?B?RHpLUTkvMCtlenNmVE1sZUJCWFFTekJJbGxwOHh6b1JLQUZBZkp4VEsyVFdV?=
 =?utf-8?B?OTJsdndvMHV2dEhqQXZWRWNFNnZjODBNTVNoamJBT0hRY0o2UzFFZmNnWHVB?=
 =?utf-8?B?Q1laeG1MSjB1elhQOU1IZnJuTktndUtlUEdoU1ZoSjYvUEFiM2twRUZGMFVX?=
 =?utf-8?B?a3oyYUNuSEpLSk9BNFhIZm9LcDh5OG5US1FVYUp5MmxaYUVhRk5RS2VSOWsw?=
 =?utf-8?B?R2pqek13Z05SeGVpWHdMTndvRHI5U3d6Y2tXVW9wSVlTWTZpL3VTZ1BJR2dy?=
 =?utf-8?B?dnovaTJXeGorWllvc0YvTzFURHFtbGpLZkVGZHFnSnlPSGtCaWZBZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: eee7780f-1a04-46d1-254a-08df3f38f97b
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 14:43:24.7665 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZxAoMJtdp43k5Ka+KTmAR9flcdma1Ry5WN3QxTlWFW5UaGbtfhZmYj2iz5zzVnSuefU+x6O/2k6Q2Ss5GbhRGuVwBoqf2jMCjqqrsccTgXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7493
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/10/26 3:30 PM, Andrew Goodbody wrote:
> On 10/11/2026 13:30, Quentin Schulz wrote:
>> Hi Andrew,
>>
>> On 11/10/26 1:24 PM, Andrew Goodbody wrote:
>>> The presence of the DTC environment variable breaks a binman test that
>>> attempts to execute dtc from a temporary directory using the value of
>>> DTC but that is a relative directory path based on the source tree not
>>> this temporary directory and so it fails.
>>> It also breaks a buildman test that checks the environment and asserts
>>> that DTC is not present.
>>> Remove the setting of DTC as it is not needed.
>>>
>>
>> What happens if you have DTC exported in your current environment 
>> before the tests are run? It'd be nice to mention which tests exactly 
>> fail for future reference.
> 
> It will fail if DTC is already set in the environment. I will add the 
> failing test names to the commit message.
> 
>> I'm thinking this is not enough and we should also fix the binman and 
>> buildman tests to run with an environment where the DTC variable is 
>> removed/absent/set to the correct path so we don't depend on a 
>> "correct" external environment.
> 
> I was hoping that assuming a 'clean' environment would be acceptable but 
> I can look at what needs to be done to make the test work no matter what 
> the DTC variable is set to on entry.
> 

Mock the environment with with unittest.mock.patch.dict('os.environ', 
environ) for example, see tools/binman/ftest.py for examples. If you 
want to only remove some variables, you can duplicate the environment, 
delete the key from the dict and use that as mock value.

Cheers,
Quentin
