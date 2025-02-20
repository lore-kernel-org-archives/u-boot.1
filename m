Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A56A6C021B2
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 13:50:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B23E80F53;
	Thu, 20 Feb 2025 14:50:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=wiedemann-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=stwmm.onmicrosoft.com header.i=@stwmm.onmicrosoft.com header.b="MQVYhfzJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0B0280A46; Thu, 20 Feb 2025 08:14:15 +0100 (CET)
Received: from mail.sensor-technik.de (mail.sensor-technik.de [80.150.181.156])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A2B4801CF
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 08:14:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=wiedemann-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alex.michel@wiedemann-group.com
X-CSE-ConnectionGUID: 0WJFvVgwRJKRhIbuA1eakg==
X-CSE-MsgGUID: akOay4OFTs+trPl5fc4hEg==
Received: from stwz1.stww2k.local (HELO stwz1.wiedemann-group.com)
 ([172.25.209.3])
 by mail.sensor-technik.de with ESMTP; 20 Feb 2025 08:14:13 +0100
Received: from stwz1.stww2k.local (localhost [127.0.0.1])
 by stwz1.wiedemann-group.com (Postfix) with ESMTP id AEE3BB5A87;
 Thu, 20 Feb 2025 08:14:12 +0100 (CET)
Received: from mail.wiedemann-group.com (stwexm.stww2k.local [172.25.2.110])
 by stwz1.wiedemann-group.com (Postfix) with ESMTP id CA235B5A86;
 Thu, 20 Feb 2025 08:14:06 +0100 (CET)
Received: from stwexm.stww2k.local (172.25.2.110) by stwexm.stww2k.local
 (172.25.2.110) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 08:14:06 +0100
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (104.47.18.104)
 by stwexm.stww2k.local (172.25.2.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 20 Feb 2025 08:14:06 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHRDOQOrQCCglCIViP/o1KzAgqtibUyECHW8GoKtktNfbi5Qpz9twcbfo6/7224j04ekmQc8wgUzfgluuaaJPetSQ4Hkf6fJ0tGCbpRDTYOD7n7s2GaO5OJoE17Uk7T+MOQqfclvEnsYzkPOMEdyXWJyJ4K0Q1lmjy1AHC8Z5T/OKvri+aYJ7UWDCbp1ouTgQ99PjDMylXuL9v05JCrLfkPtWi56TBRB8XvX+crLGXAct/8eCU3It3P0zR9WHX7X1RAxUQjunfCImUZ23SHe0wOU1E0yTgwCs6pRBk4lvhsaa2GmxYpNEZ5vSis6Gqt2ovp39BpT41hGY79EHYIU2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85jzdlvQIN3zVMRriBD+oJrRVzip0t2jjwJ24pr2yno=;
 b=JXg1RE30F62adDoZJ4nL2+m2QPMvlmf1jglIy2/3AgsZrCPBNeCvfLFT3P4xIdSmbe3IXez+OQVgLzNROJgxskrDF9kVdNehaklkmMSyAx3EGR4qfjPB0WQIss1h9KydO0zhrpUnC5VdCucwu2VXgrHy8FhvPhuZtTCAu4v4EEj7LxOsHf2SJhAZVeVDJ536vbqE8dz7YJLe9zefpUgdyySsecHenjS+UxmRASYloVDMIg657++rnxvAUjaSJQ0OhzQ8dCDT9/n2zyem1ACTuMwuAmJmnmvNipLcXrIXUGC/apiC9/Z1Hwyww1bJiJ1dTeHK3MnqTcNOp9TRWzZ2tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiedemann-group.com; dmarc=pass action=none
 header.from=wiedemann-group.com; dkim=pass header.d=wiedemann-group.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwmm.onmicrosoft.com; 
 s=selector1-stwmm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85jzdlvQIN3zVMRriBD+oJrRVzip0t2jjwJ24pr2yno=;
 b=MQVYhfzJBDDoGI2K9woRXgVUTZOrpC8jjvYiAKcjn2wx2VhsaMj9/JlIKCXgOB3THgKZTF+KrunXjq/d12e6hktEQOA4U6u1UfEO1OvAfYK1l6Z7d0544R0cXPnENw76YeV00G9tRMdZj1PuScLcOUQtJGQbVnBuDBxYiTURYlg=
Received: from AS1P250MB0608.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:48d::22)
 by AS8P250MB0268.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:37f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 07:14:04 +0000
Received: from AS1P250MB0608.EURP250.PROD.OUTLOOK.COM
 ([fe80::b4a:3a:227e:8da2]) by AS1P250MB0608.EURP250.PROD.OUTLOOK.COM
 ([fe80::b4a:3a:227e:8da2%6]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 07:14:03 +0000
From: Michel Alex <Alex.Michel@wiedemann-group.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH 1/1] tpm: fixed the nv_define_space command in TPMv2
Thread-Topic: [PATCH 1/1] tpm: fixed the nv_define_space command in TPMv2
Thread-Index: Adt+FMb8bmfTybjzTt6jwqR3i88GxADw0RMAAGOEuJA=
Date: Thu, 20 Feb 2025 07:14:03 +0000
Message-ID: <AS1P250MB0608391F8B37E8E9292205A7A9C42@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
References: <AS1P250MB060864865460745C69F23D74A9FF2@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
 <Z7Q43GmC4mpcG249@hera>
In-Reply-To: <Z7Q43GmC4mpcG249@hera>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiedemann-group.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1P250MB0608:EE_|AS8P250MB0268:EE_
x-ms-office365-filtering-correlation-id: afbead4f-c307-41c4-6b61-08dd517e283b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RWlTb0JEN0tzM0JieWxJbk5WQTg0U3VVNUpRQTEwNTh6WEZGeUNPcHlqeGg3?=
 =?utf-8?B?UXZxY0o0OC9INWsrNTU3MC9KUVB2RFFtd2Y1ZEJGV0lhZXVzSEtpbVVkTXNQ?=
 =?utf-8?B?QTJFSHRuUkl2dVZhcXVLM0N2RGE3K1ZnY1BvdjRCcjJ5K3Y0T2xjeHdnT3pN?=
 =?utf-8?B?bnppSWFkTDVDNGRQdm5XMWcrZk5jTlJiamw4bHZOa1k4RUx3TEZRU2lWT25o?=
 =?utf-8?B?RHRZWlR6ME44WERIM0dqOFY0MG1qY0lDZHI3L2hpeTdZdXkzZTZOQndRTFZ6?=
 =?utf-8?B?UHFFem9na3lxazM2U1FWVGxhY2ZlaVdQYnNjQVJBdmlUdUJQdE9Gc2RSdDVU?=
 =?utf-8?B?L2lqYmtpVjdZN2JPbU5IQXpDeGxvTzNqWUVnUnFEaEMrNEdrSUkvbjdoMzFQ?=
 =?utf-8?B?NkVtRk9BTXl6WTNURkFHZkJSVVo2cXNoUnF3Skt2U2YybHppem8wdmpKbWt1?=
 =?utf-8?B?MllaWHord1dtTUsweGE5SjloZFluVVAyUG1OcGFuV0VXSjJoZXd0a2FwV0Yr?=
 =?utf-8?B?cXNDT1gxRG9SZEF4aDNzeVdzTjljUmE4ZXJldUwzdlhaSVJpNFdCVzBNZ0Va?=
 =?utf-8?B?cVZrSERRNHBFUGtlcUxGOGVOOWgwUzJiYm1wd1BjUUpjSC9MTXdDajhKVzJD?=
 =?utf-8?B?bVY0UzN1MDJxTXloSGNUaFViTm5TUFhQWUQ3dEJLV0VwOVpqQ09rR0g0U0p0?=
 =?utf-8?B?Nk9QSmRBRm0zSkdtSmg4SC93aFlaV0JlRTBBVG5BcHdXVys4WldMeTJpRko4?=
 =?utf-8?B?bCtKRkZrR0Y4d1cza2lZcVpha296RFVkUHM4VDBzeHoyNkFaQjcrZ3BFODJx?=
 =?utf-8?B?MUhhVnZuby9heElNNi9DU3pBeW8vMHlnN0lmN0J0ZHJyTnJSdXBQZGNmbGZo?=
 =?utf-8?B?WXV3UHFzQzF4N3hWNnVwd25ZT0dlMHZoMm8rejVSSjBXMnFCZDZFVGtzd0VV?=
 =?utf-8?B?NFdsbnQ1eTBUeU5xVzQ3UDVIbm9uQWVpRnUrQ0ZoMXpER3lDN3BieklYcEl2?=
 =?utf-8?B?eFB6dlFjaEUvYkxybjJIWnZMRTdCUVN2c3k2cG4vOG1ZdE1CbklaYjRUTy9x?=
 =?utf-8?B?QmpNcXVKOFgwbmF1eldTL3Q4am9yMHdWdzdmSUFzK29yNDViVVlWeS9YRllH?=
 =?utf-8?B?dUZJWWcyKzdMV1o2UFBHZ2JucVhydTc4N0xZUlc1eXdTUkppazF0eUNuVW1Q?=
 =?utf-8?B?ZkNjNWdzOW9jeHBaYWpiOEd1WldLTWxwWE8xRHFkNk1YZ3pzQTNqVW1JSkp4?=
 =?utf-8?B?SEhZMENTQVlXZHY3UkhKYTFCSkZpd3JvNDc4NzZXRHpPRXpJZ3o5QjBLYXAy?=
 =?utf-8?B?WEhpaVlJdWpzbjFMN1U5a0RhR1l0UnN1OUxJVXJOUVpEMnpSb3JFRTRaY3Vj?=
 =?utf-8?B?NW1SV1ZkRzc5Vld2dURDS2IzWlBESDFRWmN1VzBWVFM5VVgvZVdjSXhQSG1E?=
 =?utf-8?B?WHV2UzdOa3MySW0wbWRGaFcyMUNnWWZhc3lMY2xpMmJpdXBvYVoxMEE3RTRM?=
 =?utf-8?B?UG90UitQZWlWZmVnL1J5VlBlNHg2bzdZOXIyUS9YWDl0ME1zUWhXaHlYZGdK?=
 =?utf-8?B?SXgzbUhCS25VTjV2LytKVy91UWRubDJ4WjNpbTlSWk01Zy93aXk1YlhGdWVC?=
 =?utf-8?B?ZlJGeGRiSWZSZ212TTIvMjNwQWVkdTQySThKZEJ5aXA3YVBJN2grUzZKa1Jp?=
 =?utf-8?B?NnF1SXVnT1VsODMzcExXenRXTGorQ2lLTXJJNTZrcEtVQURIWmcrczNKcXNY?=
 =?utf-8?B?WnhVV1NGTXM3c3F4UDMzUkRZN1crenRyQnVJS0ROa0F4Yjg2VG5qMk93WjVO?=
 =?utf-8?B?cUFrVXdseU9NRmxUTWYrRHRlK2tXRi9IYlhoZ0V4clc0cGZ0Z29wMnlnakZi?=
 =?utf-8?Q?7KoIfSsK2QNBQ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1P250MB0608.EURP250.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzJmeHRSMkNKOUV0aWdLN2dFSWNqZzdpeEV1T3R1bHpzbVkyWGVpM1JBU3JW?=
 =?utf-8?B?RFFSaTRkM2xYOGl2SUVybCttWFBYL0M4NHV2VGFTeUJ0QThraFNoNldwTld0?=
 =?utf-8?B?U255UjhaTm14R1l3Y1FZZzBaaVZ4N2xyODJZdTJGRGRNZ0Y3eHJXbWJPVFM4?=
 =?utf-8?B?MXRzcTZQVmdlU1dMWmdhQnRhMnpuZ2h2eHFJN0FJK1RZWUdibm9sYWd6SGp4?=
 =?utf-8?B?VHVXQ2FnOURFRGtFaWU1b1g3Zkx5cWpXbCtqZGN6TUNHLzBHdFFnbFNmU3o1?=
 =?utf-8?B?a1JoS3hmK2JZVzJBWXFUSTY5bE9NaGR6c21kV1BoTmxCeURONEZ3V1NhV0NY?=
 =?utf-8?B?VC9HM1VpSmc0UkJOWGIxQWxHT3NWVWJFV3c1TVk3aXVUZEhQRlpERmdFRTVs?=
 =?utf-8?B?a2VBMWNtVGt6cDNzVExDZlBJQzBNNG45QVNJZUdMVnhXTTN4VDBPNWhtRlNK?=
 =?utf-8?B?NGFCeWdZT1NSK0tOVU4yVjJCVEN3ZmZYY0Njd2twWG5HQW1iaXdhK2V6OFcv?=
 =?utf-8?B?YVRmSThTeFROSVhVTW1rdFZMQjh0NW51Znc5RnJ1Z0RjdklOUE1IaDFxRS9M?=
 =?utf-8?B?ek9hNFpBTFVxOGVRVnJUQ1NTak9sUVo3eG1BZGtmWElVWlFXODUrOVRYamlY?=
 =?utf-8?B?aEQwSk1JNGJzRWJiVTNqWWdrNnArOVQzbmRmaEFoaElVRWVQZDZaSXVPQ2Fr?=
 =?utf-8?B?KzJEcU9HdVY5MGlycGR2WTFMeCtGUzVnRW5QNE9GRnlIZVNmYnRRVkJJR1Vv?=
 =?utf-8?B?M1ZaQTNwTG0wQkt0aDVTMzJhd2pJVFlmalhOVXdSMWYzYUtVK1orcXpVMVcv?=
 =?utf-8?B?ZkJWOUpkMjk0ZFdyanlpblhodE9YSXBUV1BkQmJvQ1FHU0xzZXAzM0ZlTXJq?=
 =?utf-8?B?RngzcjNKa2V1TFI5RDhYTUhPTTVaM1hFU25Lb3VYTlRKSzNMV2VUUmNBN2xP?=
 =?utf-8?B?eE9IM0haYlRtdTJXWis4TW94aDJQSGswV3liQ01hZkIzY0ZxVUZhdmpudldL?=
 =?utf-8?B?VXduQmJUTFd2UU52Sms1dGIwemxocHZ0YzZ0cWFRTGR4UlVDRjUyNnVpdVpn?=
 =?utf-8?B?cFBUS2d0cEZOS1NDWXIrQVd2U2Y1SEtzV3c2L0lhRzZSdkhvSmxOMzdyVU9m?=
 =?utf-8?B?bGFQc0NGWnRrZk15WGZWZWx1QXlhSlBQeGlhN0pMa2I4VFhDMnJINmZqK1JU?=
 =?utf-8?B?VzRzQm13UWV0ekNjdHNrR3gzbWdQQjE3NCt2NVhFUllLZWMrME9sK1EzbnNz?=
 =?utf-8?B?c3h6czgzSzZhRnVOM21FUU9wZEYrWXo3OWFKTmYrRkgwRVVvK0d3U3ExOHdh?=
 =?utf-8?B?dXJaOXhwaDVSSDdiWHFnVDNmOEUxMUtYVVJ0b2dGNExSZ0gyR3RoVjRKVmVZ?=
 =?utf-8?B?K1dXTzNsVFBYZFIxSGlxWlNicjZ1TDdGREVvUVNhK09wMGlYeU9SdjlWYkR5?=
 =?utf-8?B?SEtEU3drd1VyUGlvVVlkSEVkN3BWbE1EekM4ZjB1K2V1aVlDWi9ZSWlhajJS?=
 =?utf-8?B?NDN1V1ZPV2lxNFA2QjhXZjhEbE9BSzVMeHBlZE54NVFtSWZRcGNCazN4L1FO?=
 =?utf-8?B?V0thVG9lWityRmFVaVcwbm9UMm5VUHJhRlprdm1NYlMzYldVeFlDR2NpTDEv?=
 =?utf-8?B?d0NaeVNIb1c1cndlb2tXQkRZUWN1eTMrQjZ5Vnlrb2h4ckw1dGpyemdQQitK?=
 =?utf-8?B?eEdUa3pZNXdWMHNUWFpHN3lmaHk1R0xna1NaellnQk1PUHllZzFTc2xxQ05k?=
 =?utf-8?B?UFV2ekVrUnBFQ3RQbWdSRWJ3N2FYMW16S3FpM1Awb1V1MkRIT0cyMUlOZzk1?=
 =?utf-8?B?TExPN3lZc0dHZi9aRkU1TnNvWHh0VCt0TmFXUk5CQzM0dEd0M0F1VGdRV2hs?=
 =?utf-8?B?bzJsT2p6blNOb2Zxc1h2a0pESTh3cXIwRXowN2IwQVlzMGo3cjRDUUkwSTdT?=
 =?utf-8?B?a25QZEg4VE4zY3ZOWGZodXpISjVMaXVNL2VhQWQxMGI4UHRweEVET2daYWI5?=
 =?utf-8?B?aDk2eUkzWWpyMVV4eit3bkRmdDFGdWJkdlNiWUVUd2tsWTRLVERML2IzcHdL?=
 =?utf-8?B?V1ZqcFFFTzA0bVh2ZTM1WlhSTjB6NnVGU2R4SGN6clAwaEo5RXZEVWNla2Jz?=
 =?utf-8?B?VXNTalJNMGx0S0V6TElMT0xPTkd6QWpJYzd1aHpEQWNRSlhUMUxnQ3pQQVJy?=
 =?utf-8?B?bnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rMakTQb8gfudTEdNeM1grPNRj0i+F8xGd3Fij7+wEcjggj3xhhUc6m4hbsd8UA3uIZPzxXSJjX3xq91B03YCXHQX6pEgHo8972LKvP89iHm80mw/F4iydPsPGjFsUEWCke5aDoaa9H9pMpYAvy7Ll1k1gEhhTK3idcf3d6qwOuwGckO44ldKx9FBnbK2NZJMQ5+GLdZg4+hVNUukhDjoN1QW+uFzEJHbw42P1jD1wywvHBgKBrJUtXEhOJTmG6VcGx4YrVPsFWdY7EWlstFe/WD3rVqmyNRkUZQvL75XLMW9vPHBcgN7l29DG1X05jEzg8SAi5QsX4pfk6Sb7wYwa08Nnr3gbxIKWs002zimdz2ha5Wfaxo68HlQHGdrfPuqdDWATrGoB0TZIHrq4BGcHcGOScBsKvjLRJJALCuldUv6Jp7BgC28wt5SUz76+UQviu+di07dfOCAlAKpzXuM5hq5iMCQEXffHL7MZxdHbuEXJgEV9ziYzi0VLDRMeTwYRJzW28GGc306E4b6nVQVLtvQFFz/1x8zNr6ZWNrgov1aVHXC/2JVl7QAa/4FRCp2YHdDusiKu5qhX9LbzSmDNA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1P250MB0608.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: afbead4f-c307-41c4-6b61-08dd517e283b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 07:14:03.8627 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f92d38a3-9c84-427f-afc3-aef091509c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ou+MdzwIC2oDL+BO4fGRYYksew0XoQzXzdLvajdygfyZfIVDFI8AD1fAmUOB4US6ligTjyC05UVMp+syqpAWTbDFgJXRys74DD2xNUYxsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P250MB0268
X-C2ProcessedOrg: 71f8fb5e-29e9-40bb-a2d4-613e155b19df
X-TBoneOriginalFrom: Michel Alex <Alex.Michel@wiedemann-group.com>
X-TBoneOriginalTo: Ilias Apalodimas <ilias.apalodimas@linaro.org>
X-TBoneOriginalCC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
X-TBoneDomainSigned: false
X-Mailman-Approved-At: Thu, 20 Feb 2025 14:50:09 +0100
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

SGkgSWxpYXMsDQoNCkkgZG9uJ3Qga25vdyB3aGVyZSB0byBmaW5kIHRoZSBzcGVjIGZvciB0aGUg
dHBtIHYyIG52X2RlZmluZSBjb21tYW5kLiBJIHdhcyBqdXN0IHdvbmRlcmluZw0Kd2h5IHRoaXMg
Y29tbWFuZCBkb2VzIG5vdCB3b3JrIGluIHUtYm9vdC4gVGhlbiBJIGZvdW5kIGEgcGF0Y2gsIHRo
YXQgaGFzIG5ldmVyIGJlZW4NCmFwcGxpZWQgdG8gdGhlIG1hc3Rlciwgc2VlIGh0dHBzOi8vbGlz
dHMuZGVueC5kZS9waXBlcm1haWwvdS1ib290LzIwMjMtRGVjZW1iZXIvNTQyMDg5Lmh0bWwsDQp3
aGVyZSB0aGUgbnZfZGVmaW5lJ3MgbWVzc2FnZSBidWYgd2FzICJmaXhlZCIuIEkgdHJpZWQgdGhp
cyBjaGFuZ2UgYW5kIHRoZSBudl9kZWZpbmUgY29tbWFuZA0KaXMgd29ya2luZyBub3cuDQoNCkFs
ZXgNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbGlhcyBBcGFsb2Rp
bWFzIDxpbGlhcy5hcGFsb2RpbWFzQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIEZlYnJ1
YXJ5IDE4LCAyMDI1IDg6MzggQU0NCj4gVG86IE1pY2hlbCBBbGV4IDxBbGV4Lk1pY2hlbEB3aWVk
ZW1hbm4tZ3JvdXAuY29tPg0KPiBDYzogdS1ib290QGxpc3RzLmRlbnguZGUNCj4gU3ViamVjdDog
UmU6IFtQQVRDSCAxLzFdIHRwbTogZml4ZWQgdGhlIG52X2RlZmluZV9zcGFjZSBjb21tYW5kIGlu
IFRQTXYyDQo+IA0KPiBWb3JzaWNodDogRXMgaGFuZGVsdCBzaWNoIHVtIGVpbmUgZXh0ZXJuZSBF
LU1haWwgdm9tIEFic2VuZGVyIElsaWFzDQo+IEFwYWxvZGltYXMgPGlsaWFzLmFwYWxvZGltYXNA
bGluYXJvLm9yZz4uIEJpdHRlIGtsaWNrZW4gU2llIG5pY2h0IGF1ZiBMaW5rcyBvZGVyDQo+IEFu
aMOkbmdlLCBzb2xhbmdlIFNpZSBuaWNodCB2b24gZGVyIEVjaHRoZWl0IGRlciBOYWNocmljaHQg
w7xiZXJ6ZXVndCBzaW5kLg0KPiANCj4gSGkgTWljaGVsDQo+IA0KPiBPbiBUaHUsIEZlYiAxMywg
MjAyNSBhdCAxMjo0MzozNFBNICswMDAwLCBNaWNoZWwgQWxleCB3cm90ZToNCj4gPiBBZGRlZCAy
IEhNQUMgYnl0ZXMgdG8gdGhlIGNvbW1hbmQgbWVzc2FnZQ0KPiANCj4gUGxlYXNlIGNjIHRoZSBU
UE0gbWFpbnRhaW5lcnMsIG90aGVyd2lzZSBJIG1pZ2h0IG1pc3MgdGhpcyBwYXRjaC4NCj4gDQo+
IFdoYXQgdGhlIHBhdGNoIGRvZXMgaXMgb2J2aW91cywgY2FuIHlvdSBhZGQgYSBiZXR0ZXIgZXhw
bGFuYXRpb24gb2YNCj4gLSB3aGF0IGl0IGZpeGVzIC8gd2hhdCB3YXMgYnJva2VuPw0KPiAtIHBv
aW50ZXJzIHRvIHNwZWMgdGhhdCBkZWZpbmUgdGhlIGhtYWMgc2l6ZSBhbmQgcGxhY2VtZW50Pw0K
PiANCj4gVGhhbmtzDQo+IC9JbGlhcw0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQWxleCBNaWNo
ZWwgPGFsZXgubWljaGVsQHdpZWRlbWFubi1ncm91cC5jb20+DQo+ID4gLS0tDQo+ID4gIGxpYi90
cG0tdjIuYyB8IDUgKysrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9saWIvdHBtLXYyLmMgYi9saWIv
dHBtLXYyLmMgaW5kZXgNCj4gPiA5Y2E3OTMzYzA5NC4uNGEwODJhZjc4YWYgMTAwNjQ0DQo+ID4g
LS0tIGEvbGliL3RwbS12Mi5jDQo+ID4gKysrIGIvbGliL3RwbS12Mi5jDQo+ID4gQEAgLTI2NCw3
ICsyNjQsNyBAQCB1MzIgdHBtMl9udl9kZWZpbmVfc3BhY2Uoc3RydWN0IHVkZXZpY2UgKmRldiwg
dTMyDQo+IHNwYWNlX2luZGV4LA0KPiA+ICAJICogY2h1bmtzIGJlbG93Lg0KPiA+ICAJICovDQo+
ID4gIAljb25zdCBpbnQgcGxhdGZvcm1fbGVuID0gc2l6ZW9mKHUzMik7DQo+ID4gLQljb25zdCBp
bnQgc2Vzc2lvbl9oZHJfbGVuID0gMTM7DQo+ID4gKwljb25zdCBpbnQgc2Vzc2lvbl9oZHJfbGVu
ID0gMTU7DQo+ID4gIAljb25zdCBpbnQgbWVzc2FnZV9sZW4gPSAxNDsNCj4gPiAgCXVpbnQgb2Zm
c2V0ID0gVFBNMl9IRFJfTEVOICsgcGxhdGZvcm1fbGVuICsgc2Vzc2lvbl9oZHJfbGVuICsNCj4g
PiAgCQltZXNzYWdlX2xlbjsNCj4gPiBAQCAtMjc3LDExICsyNzcsMTIgQEAgdTMyIHRwbTJfbnZf
ZGVmaW5lX3NwYWNlKHN0cnVjdCB1ZGV2aWNlICpkZXYsIHUzMg0KPiBzcGFjZV9pbmRleCwNCj4g
PiAgCQkvKiBoYW5kbGVzIDQgYnl0ZXMgKi8NCj4gPiAgCQl0cG1fdTMyKFRQTTJfUkhfUExBVEZP
Uk0pLAkvKiBQcmltYXJ5IHBsYXRmb3JtIHNlZWQgKi8NCj4gPg0KPiA+IC0JCS8qIHNlc3Npb24g
aGVhZGVyIDEzIGJ5dGVzICovDQo+ID4gKwkJLyogc2Vzc2lvbiBoZWFkZXIgMTUgYnl0ZXMgKi8N
Cj4gPiAgCQl0cG1fdTMyKDkpLAkJCS8qIEhlYWRlciBzaXplICovDQo+ID4gIAkJdHBtX3UzMihU
UE0yX1JTX1BXKSwJCS8qIFBhc3N3b3JkIGF1dGhvcmlzYXRpb24NCj4gKi8NCj4gPiAgCQl0cG1f
dTE2KDApLAkJCS8qIG5vbmNlX3NpemUgKi8NCj4gPiAgCQkwLAkJCQkvKiBzZXNzaW9uX2F0dHJz
ICovDQo+ID4gKwkJdHBtX3UxNigwKSwJCQkvKiBITUFDIHNpemUgKi8NCj4gPiAgCQl0cG1fdTE2
KDApLAkJCS8qIGF1dGhfc2l6ZSAqLw0KPiA+DQo+ID4gIAkJLyogbWVzc2FnZSAxNCBieXRlcyAr
IHBvbGljeSAqLw0KPiA+IC0tDQo+ID4gMi40My4wDQo+ID4NCg==
