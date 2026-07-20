Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 174D5C44529
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:17:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A3B1D60766;
	Mon, 20 Jul 2026 18:17:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gPMv10vG2nO4; Mon, 20 Jul 2026 18:17:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7011E60711
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784571431;
	bh=k5+UNlVOV8cfVeGeNeutDV6vCSP8OqeELkP5kp39+Lc=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=BLQ9ovSnr9maMZ+ME86nSZOvgC9Q6hBeFEvAuFLP72DZ0SZ721lpn5YeotvrIkI7Q
	 p2JaODwyLfg3ovfjpCrkdcfW8wPnx1diBAVF7si2myvK1ta6sSg0Idw5AHQQG+zQgw
	 Jv9JHHVALN2yAwzxXiFOUeflyMKWVRAV2u1Q9gDiS+Xpz1fiISiZbhX3G59x7r+I3Q
	 kWHJNQ2simMXHyw4Y/M2BvJvlMEQxJHN/IFdISZZnfzhmEEvNZmK4Ip7kSc8g0T1ng
	 BYuaa/QrCcz13yEdyB945N7hFLMYRvZJQmb7v+P+wY5DaRUyWO+39wJALT5c9OwGrR
	 f2wksCjRaxzew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7011E60711;
	Mon, 20 Jul 2026 18:17:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 12D1B224
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:17:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ED5F3406F1
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:17:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U89iefdd7m7b for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 18:17:06 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 249C3406E2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 249C3406E2
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 249C3406E2
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:17:05 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EE89846A5; Mon, 20 Jul 2026 20:17:03 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 757C280433
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 20:16:57 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w57c6HbF0nPimwku8crrN8BZs3E/WexFyFEmrzqKk6En8quMej4KKdfAFjFM9eRcl1VbGDUrY2qEvLrY0kkchouvE3U5Ix7e6fhwH7EJrzC4FG2b50VNYObPCQTa1/uV20XShEKCKiq1ouj6pktz2Nlvv0oSNGuIXEQCLmmPNpJDpfKXbEl9WWwlJuWVyi+/JcotztMkcTi2fZOqIKninB1fNWVOYyC/VscP7Okt5/19CyFI5WMhxNY3TQjtwBk1uk0F17OizHExO9NmMfbVQvEZAEdHLx39M/RLCa3o0jKtfZucRwKVi7mr6d624fOl5RJ2ZwTWTkT3OS4faADCgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5+UNlVOV8cfVeGeNeutDV6vCSP8OqeELkP5kp39+Lc=;
 b=lW+oLe6inUt+6uZ6A0DhxuevCaO2YVwN8CzlRMsvHihPGaMgebpSWUQMgtnxIWM/0sACIZGhphJPNJy4uYav1UoT9STAsJ6R1ihuRc418YdVk9nFmEcTXP1meROL9pgfqHHFDA/H8/i8xe2bhVbpKLMoKSlvptAiMW7X9xjgbKLsMGW4WJ5kA0IfNv6bub7G9Nwa1JPI+KfEaPYgsZCAiwJLcc1nh0Zx6nG4sAse/t8+S4wCiVHdXwzoWq9HLbeJPk0wiCnHlGp1xHsEUHWouSS1zZt6g7q2BrlGij3qRtHJp6nLfu4F1mpgO9Zb1nDeVhhAOoxm+RcPV0ecgWYwZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AS8PR04MB8836.eurprd04.prod.outlook.com (2603:10a6:20b:42f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 18:16:54 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0223.012; Mon, 20 Jul 2026
 18:16:54 +0000
Message-ID: <de216e13-1c93-45e1-ae48-548d3effcfa5@cherry.de>
Date: Mon, 20 Jul 2026 20:16:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] roc-pc-plus-rk3399: Enable USB Mass Storage support
To: Fabio Estevam <festevam@gmail.com>, kever.yang@rock-chips.com
Cc: djw@t-chip.com.cn, u-boot@lists.denx.de,
 Fabio Estevam <festevam@nabladev.com>
References: <20260701175800.40141-1-festevam@gmail.com>
 <20260701175800.40141-5-festevam@gmail.com>
Content-Language: en-US
In-Reply-To: <20260701175800.40141-5-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0010.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::12) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AS8PR04MB8836:EE_
X-MS-Office365-Filtering-Correlation-Id: 16eb69a6-c49b-4158-d649-08dee68b13d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|6133799003|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 3i8hqkLzq1FQAF2B6SdULxwcmGpkixLJqPCdYSzl4NSpvNwbuYBtYt+1BJ/aCG/I0J6lefw0/2dxYLn+q/di1GZl5NoQ6DNUDfnofcVS+G/pVrwu2NBWUz8hUlYa/qJZzSKr7qPXCQutYdiLVApz1YcsgafFDBg5tSqZuTQFwzfVzLECrzXG57ZFNgFf2TcmVG2fu45y4TTdP3ZJP9M48yb6SoOtKQLAmElCpC5cAMFZf5Y/fQpyW0q9CqUmsgJ5e3w/dpPJq/64qBiEK0wbxqtV49bJ/4kJDO4irhY8XEDVO5dcIjidyamo4cfarOOXZSG/dx1IAhaOTEMzhnalcFt2OKSzO/K+rdEawIJYY/TrgwU2j+WWmftKe7ltxmWJm6KvVQH5aKDUZ++s7OoFGfuWxvSTxCKTJHShMGPpy7j2MVVBzAJxHhORowWT9CMNc4Sg+fqsQKV6tIKF969eRVjFBj4Xw64oL1uscC+sf6K+jdLoMydF0M2gg26hcksolDxVJKurgQgMCXBkm9A1+I3p3KbPbq+4DP9eKPdIA3ELFo1L6UMBl/UWuI1PHiDAxO2i6SazQWcvw+jRFS2v9afwniuKwKamRA1pOMwKN5vNYSKIyl0vOIT4nCA/bSdodHkpOp40GKih8uxnXxGb+krIuvUUj05k/StIs/L0Ckg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(6133799003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDhmU2krbXlCMmFKZ2hnQ3A1NHEvUVE1WFcrWUN1ZytoM2xHY2drSFlyMEFI?=
 =?utf-8?B?QUg0SFFwa0NuZ0xCeENheWtwRFJjRzF2Wm9wNFpYYzZLYkpZdS96S3VJS0Zz?=
 =?utf-8?B?cGpvM3VvMmJTRDhtR01HUTRvcnNyZXI0UmsyNjh5Y0tBSTFyblpPZlhVSEF1?=
 =?utf-8?B?azhXUWJaVFlaS1doY0JYWjRRaktNYjUyRjVFUmRDbUplTkJBbGN6WVpSNGdq?=
 =?utf-8?B?OUVENUg0K2tiTkVmQ0dNTzJGL1JrMUhVbjdtb2tadG5sY2NRV2hFQ2UxZDFP?=
 =?utf-8?B?NEw3SnREYjZLWXR3ZG5ZT1BCQ211bktBcDBqTXJQMXh5S1U4VXptaFdQOTFT?=
 =?utf-8?B?QzN3VDVXNXIwSWZtZjBGN1VLcjQrdVpHcVhZcmJjalVlVGo3MTRnN2Joalc2?=
 =?utf-8?B?aEhkL3RYajZ1NG4xREV6dHpQTUxwT244VXpJZm1raUg1MUJOdHFtVlFhVVFv?=
 =?utf-8?B?TGN2dk1waGFsbVp6bmNtNEQ5L1MzNDJGOWRYc0dXZG9OMzFqVE9MUFVJNEQ3?=
 =?utf-8?B?WjUyemQ3aU9aVWZTQks1dlFBeGVMSzdyYVdreU1TWGFhZ1ZoTEl5S1dlcktv?=
 =?utf-8?B?NDltcGdwdEZvRjB5N3FkSWxuOXlHSzdLTDB1UG10WnBINGoxY0ZLNUowUHcy?=
 =?utf-8?B?WVI3TkJMcUhPbE44MTdkK2JwM2xTNk1UeU9kMlZ3UnFUR1FWRFB6Q2lHWXVK?=
 =?utf-8?B?dE1McXR1WWZ2Y1dqRVNTNmQ0dVBvUHlZUTRKc2ErRVlLbUNZVWp0VitxMWlh?=
 =?utf-8?B?MEl3Tm9QdWFUY0VYS3J2RjFQSy9GcmVOMW5qYllZMVJFZlZmT2Z0VDgzdmVh?=
 =?utf-8?B?QTh2NkMwRWZaZVhlRWRDaHJXS1Iya2Y4QWZFa21zaHVVMWJCQ2tyZHJjN20y?=
 =?utf-8?B?R05ZRFpOV2o1WWxPUGFjbzhTblVXSkFyNzBsTGpRQ1YxdmIzcU4wZUN3enlP?=
 =?utf-8?B?ajJjL1RXc3VTbDFiRmtxdTlmUXhLb3hCWWRScmJYb2NpTThXczNES2ZCRHZk?=
 =?utf-8?B?OHRwYVhFcDhvSVJmNzRyV0JiQWwwM0J0UHRYNWZkcjlWMTVZazNDd2dyT254?=
 =?utf-8?B?eUxuZ0wrc0dYYVZHa1hiTFlNTmJMQmNGZmRWdHIzanVJQWlHL2FuLzNqeVRj?=
 =?utf-8?B?ZU42K1N2Sk5Dd2dWcVg0ZVRFcFU0bTBvcXlRdEx4bzVxcEJGNEI2bWJpMWl3?=
 =?utf-8?B?WXF6U2RkZTlmRXJwQThaWWdPcjlRRFdka3JrZFk4dmZGZ216di9CeE4zTWpn?=
 =?utf-8?B?QStQSkVacjRuUlJBTy90dEFvaEZERm9WVEhMUzh4SUtmOTZ6VlB6UUs3THIx?=
 =?utf-8?B?bU13TVlGdGY1a3VmaVhqeWhaU2xVbU5ReW8yWEtHZnY5S2NVNnlxSTFaNTJr?=
 =?utf-8?B?bjBSNVVGbmFJNDZMMFc1RGtUeWxxbDBESXlVdEpuSGtrNFozY3lRN1FGbERQ?=
 =?utf-8?B?Q0NjTkJOZlowcUthNHFhMXRaK2ZHb1BsOUV6ZzkvYzhYK3FsaXYxK2FzbHBz?=
 =?utf-8?B?UlgyR1ZhNFBkVGp3V2VHUVBmUkJzbklhaXZWQS9qeXBySXBkTTJ6Q2hLeUhh?=
 =?utf-8?B?LzNrM0JKRklicXhwbHpCQzlpSEZONVE0QXJscVNCSDQxWTlYeHdSUVRoU3JO?=
 =?utf-8?B?RnZjajQ2cWRiSWMzVUczeFdlakR0ZXJNSDBicnVkeWZ1bHFwSkNGc1BLL0l4?=
 =?utf-8?B?ZHdRUlNETkpVcDZqdUI2RGtqYWZKYW5uSjhvdnZ3Y1lnb2lDQTZBam9wYTF1?=
 =?utf-8?B?bTVnQnFLQ3lKYlcrL2FTNUh5Z3NEMmpoaVAvbmV4VS9JL0NPQWFjZWVsZGs4?=
 =?utf-8?B?VkNEMVZ1S1FUcG5rQ2tZQVJ1bmo2M0NIRjJQd29YZkdzYUlscFlaOTBIc3Fv?=
 =?utf-8?B?dHJpTGRxZ0tzY2VoQWxDcGU2Wmdtb291em5Lb0lrekRRZFlQaTdJTTVWY1pE?=
 =?utf-8?B?WExCalhBYlhoSUU3cGI0Q3hqY2ZZYy8xS2t5Qk16R3RiT3J1VGVGUEthdWtV?=
 =?utf-8?B?amlIWndwOGd2b1VhUHhoZEdidTB5dmVUZUlGRU9xSk82ME5CU241cGx1WjVx?=
 =?utf-8?B?cnovVDNqUGJOeU9jVUFxZDlLV2xOSEltK29kcU1tWVJaS1RCUVVLd0FFTlQr?=
 =?utf-8?B?cGdOSDR3NjIxQ2cxY2lUMHhLanBUT0EzYXBEdGZIODkzTzI4QXRHSUx2SnBo?=
 =?utf-8?B?Q0lDN3FxL3pRc240QmJWSm1DSllxOGZuTGVIaXZ3TnUyR0Q0ZW9vbE5OVGJF?=
 =?utf-8?B?c3R3OHZ1aUdBWUlUSlUrM3cyc2pxRG5XZzcyRUptZUZYbkRpRUg4c3dEcEVL?=
 =?utf-8?B?UHN1K0FsSDd3ajRxZVdxbzcrb2lKTWZ3RElwdTdHWXBjWUhjaEE5Zz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 16eb69a6-c49b-4158-d649-08dee68b13d8
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 18:16:54.2169 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PiQqM3IR25gov5NnvYCrCN75pvv1OPXoIEfNQwdmKraSZja2HSXQ9ulwOvlGMewyczmHMDjFIfl8MsH8aUSoXSz76SW7U7JB6KGlmUd1l3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8836
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5+UNlVOV8cfVeGeNeutDV6vCSP8OqeELkP5kp39+Lc=;
 b=Aesi6uPkbuoWGDQOm5gRS1f9s7RDDvB+YW2QoFYBoayOodpGwtTNssK/KTUUsTVtnUPvI9XSLZFyi80EstSgLXheDx0/OxCaD3bqp/YD0R8fu9xKBFZQC3yv61kQloiH74jnsXbMET1IHGYrK0a7m7JD3ZBEx5xThZjDgjB358A=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=Aesi6uPk
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=cherry.de header.i=@cherry.de header.b="Aesi6uPk"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <quentin.schulz@cherry.de>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Fabio,

On 7/1/26 7:58 PM, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@nabladev.com>
> 
> Configure the USB0 DWC3 controller for peripheral mode and enable the

Is this really required? I would have imagined "otg" to be enough. 
Considering there are setups U-Boot DTS is passed to the Linux kernel, 
the fewer changes we have compared to Linux kernel DTS, the better. I 
wouldn't take too much inspiration from the generic Device Trees for 
Rockchip SoCs if that's where you took it from, a lot is trying to 
support as many devices as possible without necessarily doing things the 
proper way.

> required USB gadget options to support the U-Boot 'ums' command on the
> ROC-RK3399-PC Plus.
> 
> The 'ums' command provides a convenient way to expose the on-board eMMC
> as a USB Mass Storage device to a host computer, simplifying development,
> image installation and recovery without requiring removable media or
> network access.
> 

Sounds good.

> Limit the controller to High-Speed operation by using the USB2 OTG PHY.
> 

Why?

Cheers,
Quentin
