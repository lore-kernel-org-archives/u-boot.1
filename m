Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDBE4EEE245
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 07:38:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E8E888B9E;
	Fri, 13 Sep 2024 09:38:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DyvWre99";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4445B88BCF; Fri, 13 Sep 2024 09:38:38 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::61e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0E6988B63
 for <u-boot@lists.denx.de>; Fri, 13 Sep 2024 09:38:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Prasad.Kummari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FlasefIBK5x39v93zpaBZUoMkUxyHWTf1oI5VmUG0YS4Y0NQsnFww/zzBqxTooIBzldo9JdQIovS3GIoR6MdvjU/D6xAf1euLhhL0syXWewdQIHeMBzKw6XkbaColJo3KuKWBP02lHd1gS7Vgl25brYAKj6roTWZPHA0r0YcxQs4FeYhP+e9rqnkMJQbC3DCDxgyih/4uHUMLTx9cArzts5mXOzywzZcGLgSzLuMRJDp/2jUC5EV5+PjbF7e1KgcLpCelKmabTLfY5X8XtoIMmXGXJE7u/BN3bdzZsSFn8DqnKe14J61NSJSy+zTUXux+saAw8bpf9mS7Z5okhCBLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PODMGgJbKeJDtauOyoCGO1Eyn7T5XShU3GFHMttc1AQ=;
 b=cIl5qg4tUSqN+d0ho4aMC9FNr1jsCZAWCC4OYuIpc0sTqHo3bjULppdUF6hs7HjAUcqlb2dcbtv9BNkW9XQVwsnX8p62vTe47Qr+dcUhmKIqFJTaDWohw2OuP1BBxc8ijz1vqlud4NfsFW4g6W835O6kbnlnzkpETYvEB6IcDHmRREJO/C/z035pSJVnVWeSQRe/9PI4KO36RGewzn+Yq4Xbc16Kw0MPDsGSeCUcCPG9H6nZ3AgBuTxeN9uzwe3Qb4HdIOPG851f32Xp2sV5AVfpzeSFqt57qzr95wcGLtWO7o78Ym2oFOs3f5i9cjonL7LgOU6SnMWJMO+eZsyN8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PODMGgJbKeJDtauOyoCGO1Eyn7T5XShU3GFHMttc1AQ=;
 b=DyvWre99vLKamjwzXF0k+tyg/+dCakQdUWCXCT3ESvYPpPj1Jx/Q0VigsZ18iVvUZC1qYbRX+eVYXVfNzc0KK0vlT7hXRJLiU24gOVkUJhDykd8mjk3eDraz9X0ClsykAXIqqMOKZkorzb418Cj/89+0Gn1euNfyaMSbR0GuCqQ=
Received: from SJ0PR12MB6685.namprd12.prod.outlook.com (2603:10b6:a03:478::17)
 by MN2PR12MB4080.namprd12.prod.outlook.com (2603:10b6:208:1d9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Fri, 13 Sep
 2024 07:38:30 +0000
Received: from SJ0PR12MB6685.namprd12.prod.outlook.com
 ([fe80::92b0:daca:e351:d6bf]) by SJ0PR12MB6685.namprd12.prod.outlook.com
 ([fe80::92b0:daca:e351:d6bf%4]) with mapi id 15.20.7939.022; Fri, 13 Sep 2024
 07:38:30 +0000
From: "Kummari, Prasad" <Prasad.Kummari@amd.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>, "Simek, Michal"
 <michal.simek@amd.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "git (AMD-Xilinx)"
 <git@amd.com>, "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>, "Begari,
 Padmarao" <Padmarao.Begari@amd.com>, "git@xilinx.com" <git@xilinx.com>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>, "n-francis@ti.com"
 <n-francis@ti.com>, "d-gole@ti.com" <d-gole@ti.com>
Subject: RE: [PATCH v3] cmd: sf: prevent overwriting the reserved memory
Thread-Topic: [PATCH v3] cmd: sf: prevent overwriting the reserved memory
Thread-Index: AQHbA5hjHDCn0NJLiUWQE/WsJsq06rJSceuAgAAA+gCAAAGEAIAAAQCAgAAGm4CAAtvSMA==
Date: Fri, 13 Sep 2024 07:38:30 +0000
Message-ID: <SJ0PR12MB668549E97CAABEDBC88C8DC682652@SJ0PR12MB6685.namprd12.prod.outlook.com>
References: <20240910154344.1837906-2-prasad.kummari@amd.com>
 <CADg8p94Fc55EYFVca8V5NPq6xWePgLhV93ebRfFEf-H_GoFgpA@mail.gmail.com>
 <3f149f20-7663-4e37-8a9c-52e4f87b62c8@amd.com>
 <CADg8p97E-Kj_7Sf=_PmgrMAoQwks3wx1Gkqx4Mk9yHhG4Mz1_w@mail.gmail.com>
 <9fd1ffac-4045-44b1-b0b9-e2a7442d2fa9@amd.com>
 <CADg8p97OnGd43GQF1Oy8WGnXMkH7BVpVKbcQgRX_+3q+0ond6g@mail.gmail.com>
In-Reply-To: <CADg8p97OnGd43GQF1Oy8WGnXMkH7BVpVKbcQgRX_+3q+0ond6g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB6685:EE_|MN2PR12MB4080:EE_
x-ms-office365-filtering-correlation-id: 7f06f023-e06a-4d19-3ad3-08dcd3c71036
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SlZZNXp0cFh3eWtiMjlFNGNGSmgyVjBoV2RNZjdyRWVyOUFQaGlLRGdxdzF5?=
 =?utf-8?B?MEdQWHpJUmp2M0xWQllHWFZWWUZ1Wlp1UnoyRGhjRXYwTnE3S1o2NWNBZjBx?=
 =?utf-8?B?aTZHVUNlc05HRG9PZ1JVVmxiYkNQZUNycXZvUzg2ZHdmbUEwdGFuRXBSSXg0?=
 =?utf-8?B?R3hINk5TRHBOdldZNU5OZzFML2EzbmNUQldVRFo5MUFGbDNKOFRNREtkdmNN?=
 =?utf-8?B?aVkrOXZTMTExaFFZTnh0dHJzdjdPYnllLzlDdWpFWnoxYmtFVVI3T3BiSjBL?=
 =?utf-8?B?cU96VjhwR00vY0FjWDdUY21LN3VZT3UvVENvTWM2dXBpMC8zdjc2TW44ODNO?=
 =?utf-8?B?VndMMlpyYWUrRGUyK0dycHdhSVhmbTBJWER1MUhhZnhrQWhTOXF6ekRnN2px?=
 =?utf-8?B?djRmbml4WERlR3R4dlFIck4zRDZzNjczOFEwRmo0bkU1WFAwd2tCVkRPZldq?=
 =?utf-8?B?TGUzUGY1eUsvTHFvbGtubHlVSnM0KzRndDFDcWlMd08vbW1Ja3g1TFk2RS9M?=
 =?utf-8?B?emd5NWZPMEJVSXh0Y055ejJKc2w1T2VUbUY0blhDUGltVXJnZkxIS3dQcDZF?=
 =?utf-8?B?VEU1NzN3Z1RidE13U1QrZk9LL3JiR2Nhblo0azRBU2g2MVUyeGNIQnBIS3Zj?=
 =?utf-8?B?ZmEyKzN1dktkZkRDYlNOektmbEVhaHJHWm5ITTU0ZjNwS3dmaWJ0K0Z5QXZy?=
 =?utf-8?B?a0tHRXEvdDVqaXh1OUpMLzJSR0pWMHl5WEZZRHNDSytLWDVrQ1o3WUdpV2Yw?=
 =?utf-8?B?TmVHRnlKOHNHSHVYWjM2UU9CekxyNkRrdUY3SFIwekhzQ0xMU09JcXZWVFJi?=
 =?utf-8?B?ZWQrdk04T0RwTWc5cEw1bGcvMUk5SFlnbW9zLy9tUDZsNEtsZzVkTGxVY2xq?=
 =?utf-8?B?cHlQUTNTVjg2WHQ5VTJzcWQwVE9ra1R4blZJV1JWclp4YTZxV2JSZXpUU3pk?=
 =?utf-8?B?dytyMTkrTzRuNkg3MHJ5YjVnS1o4MTlzaGdzVEJiSHRXdmNNUEs2T3NuQmVz?=
 =?utf-8?B?bVcrTS81d05VUk9QWWp2YnNqZTRpYk50STREdE9VdjhxRWFhQkl6dWFKenFp?=
 =?utf-8?B?cFBYQmpCVS9Kc2FjakM0UEM1YXZXSmpBRE5hbnVvbnBUNmdKYlVMUzR4T3Ew?=
 =?utf-8?B?NDJoaUIzbW5Mdk1hN3lsS290Yjd0WmlndG5lNXVRWW1yMW1QOHdyOC80MWp6?=
 =?utf-8?B?QjRlNHpQMzUzV3RmeVg3ZHNkZ2VFTFZ5QVBDbmgwcnhKNmZrcmRkZWQvYlRF?=
 =?utf-8?B?MG5jN1VVT3dwMXlPaTJtK3JlR2tDYVpUdDZkblN0OTBEajNGTjNSVGJIL1VP?=
 =?utf-8?B?SWplY21Uc050NU9ITWN6MUNzRC9RTmhkZExaQ01jWnE1VERDeTlnVnlsTVYx?=
 =?utf-8?B?S1NldXZrcmdaZGZLVTdoNXhCZkxGVm5oTm1qY1R0TkJ1WWYzVEs2bHV1TDRn?=
 =?utf-8?B?dDAxem1vOTF4VU5XeUl0eWtHWUtFOE1OTnIzanFwc3dlOVU0Sy9CNHZoVTFE?=
 =?utf-8?B?Vk5vRlNob0VZc1E0cnJSU3RhaENzdGY4QU5NRHg2M0E0SDMzbHJxQWVtR0Rj?=
 =?utf-8?B?VzVBWDJDNkd4Y1VEa1RBMm5LRHhQNlRTaFRLUVJ5T0ZoTUVJbWFidVVyUnpp?=
 =?utf-8?B?dGJKZGtkSmk1Zm1VVUxTalJ5SG43dk5NdWs3M2lib3RWd2QrQURGREJGcFcy?=
 =?utf-8?B?VW9BWldqRkpJeTBweC9pNFJ2NlM5bjkwVk94YmNEdU1LU00xWU56S1RpVW1T?=
 =?utf-8?B?N0Z5djdUTzVNNHhSSWRsUE94YVY0MlkwNmt4Ry9oRytIbTdQSStGSldkOXRV?=
 =?utf-8?B?QUtQSWZaRnZOeXdMWjNONmtGb1N6UVRGUkNaaTB5b2NFbGl1SlFpWkRnenV3?=
 =?utf-8?B?NUVvWjJ3WDNVQzdQN2t6UlpKU3JEdmYwVi85ZzNMakNvdUE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VU9taDRqN1pyK3ZQS1c4cmNyOTBUQVd1cU56NmJVTGpvWVJJU2I4NXNxcHgy?=
 =?utf-8?B?MCtldytRM0ZNTlVsOG11L2FJUkhITWxtK0MvT081NEJxU3RDbWVTQXQwaTNS?=
 =?utf-8?B?elVpaERVdjVJTVdLempObE5QRllIeVBJWmhvRlpCcTVVOFdocVkzekJWQS95?=
 =?utf-8?B?K2htSm94Rzhia1RmRWZzQTdZQkRmcUxIeitzRHZtaXJUN1pwNVRNUjRqUSsr?=
 =?utf-8?B?Y3dBUnRBNS9TM0pQbndEZjlRbElaZzlrQXdYOGhocUwxZkQrTjdsbXpkcktu?=
 =?utf-8?B?RWRqbHBBYUgyR2hhV0pLNjI5dTg4eUFqSFNUaS82WndLMUpPMXVPamtiSC8x?=
 =?utf-8?B?QTVuTzlKQ1ZzSkcwMmlnV0E4aGpsUW56aEsxZVNsaDdZM09tL1BvUmU1MVR5?=
 =?utf-8?B?aWozVzFwczRxendPajlJeERPM1B1L1FuN1lid3FUQmVpTnJ5R2p5ME5pb2po?=
 =?utf-8?B?cDRVVzJDU0NNd0EvZm5qUG55ZkNCb3lHR3NWaWQ0dDBSUXVpMzRRa2VYVitu?=
 =?utf-8?B?QnBBaE9uMmV4Z3JwbkFQd2tPTVduaWxWMUFVMmV6Y2JOelhyNHJ3Tk9QdTRu?=
 =?utf-8?B?ZnJld0JhU0xjU3VmUWNpMmN6YzRZNWNVZE53cUNScjR6N0x0SDd1SDhFSkNG?=
 =?utf-8?B?aTlzcUpxMVo1OEZRd0czUERjRmZDaFk4OHZkcDBGcTNIS1BqM3NxSXNubENW?=
 =?utf-8?B?M1R5Rm4zMUtFNTZobVlXQXFCdlhoZDZpUE5FZDVHZmRGK1JsZDFIVjlhYWp2?=
 =?utf-8?B?WmVYWGtqejRLbGphY2N1SmQwRUFWV00rdGhrMVJobTdFSlZzdWd5ZWQ4WFRt?=
 =?utf-8?B?UlQyWHovZ0EzY2kvNy9JNDJrdG5CWTN3R25vaWI5RjE5Sk5adWMvYXdudnJi?=
 =?utf-8?B?WDhsZTRSOUJ6cGRLWjNUMW9nc3B2SDNGbDBPTEQvaHlJRGRub0g4L2R1T01F?=
 =?utf-8?B?dm5jN1lqbVlZdTlYc0ZGa081bEVzeEhYTnZaRWpZUitYeFVLVkNjblVDcUF1?=
 =?utf-8?B?MVMwSlkxZzVYanpkL25CQmt0aVNCWW1JVG1JVlRyMDJwR0JzNHF1M2diSEpV?=
 =?utf-8?B?MVBFS0U1cFpqWHBXem0yWFJIaTBQN1ZQTlFJSlpWU2k1QWNmcDlrak5aYlZU?=
 =?utf-8?B?L3pNUjF1QUZLNHlqQkJzZm1DL3dOWXVwWjRidXgxZVJxZ1BmazhtTmtlRWRv?=
 =?utf-8?B?MWpPNFNxSWlMaFVqUDI5WkhmM21MOWFKRlZQK2FhUTB5b1VKcVR5R05HanZS?=
 =?utf-8?B?S3FyaE43czByMG1NSmVXbUFiRGkyU0I4WVJXZE0xUHpVeXZDVTBmZTZDUzRW?=
 =?utf-8?B?eW1ZeGF5dnR6d1JiUFlIVG5WQTBGRllNWDRNcWl5RGRteFQ0NXRsU21uVkRQ?=
 =?utf-8?B?bERadHlObDIzUDVoakNZYkRmL0YyUmNRbjl3NG9XUExvREFxcUI2K3g0czNB?=
 =?utf-8?B?aCtiOVRkN01pL29Vd1loNmQrRFJrNDArSmUzalYyNFdVVHAySXNiT1hDRTlV?=
 =?utf-8?B?cFVuUlRQNldjL2pqMjR5UGg0TjFsMHdNc2pLOEs3TVlMQ1NLNjRPZ0RMODEx?=
 =?utf-8?B?MXJOWG5HYVdSVmxUcS9wc29aaStzRWZidXVaczFtbHduU2NtWFZxUHRPZHZO?=
 =?utf-8?B?amNkTkVMZU0wWEgrdVdEdFZIeUNlSGkxTENMSnYrbnp4NlB1WmF0QUtyYjlx?=
 =?utf-8?B?bnpWaC8xZjk5d1ZxTTh6eTVDd0g5S2ZpVzkwcHlKVVVKeVJ5QmlEL3o4a21w?=
 =?utf-8?B?TmJWRUozYkkzbEVxZVl2QjdOY0I0aEwycjJ4TVVjckplU0F0VmtpZTQ1eHpy?=
 =?utf-8?B?aFYrK0FVVVdTL2J1UStCd2MzSVZmaW01VjRyVlN0RWN0ZnBab05VRHViTDZo?=
 =?utf-8?B?My95YWN4R1RaYXI3OTYzLy9TZE1yVzkvdS9qSm1iVjk1dWZIN3ZYN1orYnps?=
 =?utf-8?B?dExXQmZCNkVvOGZicXBWcTR4aHdTQzc3YkdnRTFWcmhwYTM0ZGxVbVFxWXdN?=
 =?utf-8?B?OXVXVEdXSnM2RUd6SjZOVGhWNTVLbGxrUlhEVC83djFONTJUOG9DMVlOQkRo?=
 =?utf-8?B?Wlp5cGh3QnhQTG1DN2VLTTZhbHBhQ3BheEJzOFp0U3VwbmpGTEF5NmV4N0JI?=
 =?utf-8?Q?ZoLw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f06f023-e06a-4d19-3ad3-08dcd3c71036
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2024 07:38:30.3682 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W3mX3p9PszUGIDCP1ZEwf87S7T2U6qDiGSYx8gl0gm8Q/ISsx/nQx8KYzzivfwEH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4080
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

SGkgU3VnaG9zaCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdWdo
b3NoIEdhbnUgPHN1Z2hvc2guZ2FudUBsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIFNl
cHRlbWJlciAxMSwgMjAyNCA1OjI2IFBNDQo+IFRvOiBTaW1laywgTWljaGFsIDxtaWNoYWwuc2lt
ZWtAYW1kLmNvbT4NCj4gQ2M6IEt1bW1hcmksIFByYXNhZCA8UHJhc2FkLkt1bW1hcmlAYW1kLmNv
bT47IHUtYm9vdEBsaXN0cy5kZW54LmRlOw0KPiBnaXQgKEFNRC1YaWxpbngpIDxnaXRAYW1kLmNv
bT47IEFiYmFyYXB1LCBWZW5rYXRlc2gNCj4gPHZlbmthdGVzaC5hYmJhcmFwdUBhbWQuY29tPjsg
QmVnYXJpLCBQYWRtYXJhbw0KPiA8UGFkbWFyYW8uQmVnYXJpQGFtZC5jb20+OyBnaXRAeGlsaW54
LmNvbTsNCj4gamFnYW5AYW1hcnVsYXNvbHV0aW9ucy5jb207IG4tZnJhbmNpc0B0aS5jb207IGQt
Z29sZUB0aS5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2M10gY21kOiBzZjogcHJldmVudCBv
dmVyd3JpdGluZyB0aGUgcmVzZXJ2ZWQgbWVtb3J5DQo+IA0KPiBDYXV0aW9uOiBUaGlzIG1lc3Nh
Z2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHByb3Blcg0KPiBjYXV0
aW9uIHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywgY2xpY2tpbmcgbGlua3MsIG9yIHJlc3BvbmRp
bmcuDQo+IA0KPiANCj4gT24gV2VkLCAxMSBTZXB0IDIwMjQgYXQgMTc6MDIsIE1pY2hhbCBTaW1l
ayA8bWljaGFsLnNpbWVrQGFtZC5jb20+IHdyb3RlOg0KPiA+DQo+ID4NCj4gPg0KPiA+IE9uIDkv
MTEvMjQgMTM6MjksIFN1Z2hvc2ggR2FudSB3cm90ZToNCj4gPiA+IE9uIFdlZCwgMTEgU2VwdCAy
MDI0IGF0IDE2OjUzLCBNaWNoYWwgU2ltZWsgPG1pY2hhbC5zaW1la0BhbWQuY29tPiB3cm90ZToN
Cj4gPiA+Pg0KPiA+ID4+DQo+ID4gPj4NCj4gPiA+PiBPbiA5LzExLzI0IDEzOjIwLCBTdWdob3No
IEdhbnUgd3JvdGU6DQo+ID4gPj4+IE9uIFR1ZSwgMTAgU2VwdCAyMDI0IGF0IDIxOjE0LCBQcmFz
YWQgS3VtbWFyaSA8cHJhc2FkLmt1bW1hcmlAYW1kLmNvbT4gd3JvdGU6DQo+ID4gPj4+Pg0KPiA+
ID4+Pj4gQWRkZWQgTE1CIEFQSSB0byBwcmV2ZW50IFNGIGNvbW1hbmQgZnJvbSBvdmVyd3JpdGlu
ZyByZXNlcnZlZA0KPiA+ID4+Pj4gbWVtb3J5IGFyZWFzLiBUaGUgY3VycmVudCBTUEkgY29kZSBk
b2VzIG5vdCB1c2UgTE1CIEFQSXMgZm9yDQo+ID4gPj4+PiBsb2FkaW5nIGRhdGEgaW50byBtZW1v
cnkgYWRkcmVzc2VzLiBUbyByZXNvbHZlIHRoaXMsIExNQiBBUElzDQo+ID4gPj4+PiB3ZXJlIGFk
ZGVkIHRvIGNoZWNrIHRoZSBsb2FkIGFkZHJlc3Mgb2YgYW4gU0YgY29tbWFuZCBhbmQgZW5zdXJl
DQo+ID4gPj4+PiBpdCBkb2VzIG5vdCBvdmVyd3JpdGUgcmVzZXJ2ZWQgbWVtb3J5IGFkZHJlc3Nl
cy4gU2ltaWxhciBjaGVja3MNCj4gPiA+Pj4+IGFyZSB1c2VkIGluIFRGVFAsIHNlcmlhbCBsb2Fk
LCBhbmQgYm9vdCBjb2RlIHRvIHByZXZlbnQNCj4gPiA+Pj4+IG92ZXJ3cml0aW5nIHJlc2VydmVk
IG1lbW9yeS4NCj4gPiA+Pj4+DQo+ID4gPj4+PiBTaWduZWQtb2ZmLWJ5OiBQcmFzYWQgS3VtbWFy
aSA8cHJhc2FkLmt1bW1hcmlAYW1kLmNvbT4NCj4gPiA+Pj4+IC0tLQ0KPiA+ID4+Pj4NCj4gPiA+
Pj4+IENoYW5nZXMgaW4gVjM6DQo+ID4gPj4+PiAtIFJlbW92ZWQgbG1iX2luaXRfYW5kX3Jlc2Vy
dmUoKSBhcyBwYXJ0IG9mIGxhdGVzdCBMTUIgc2VyaWVzLg0KPiA+ID4+Pj4gLSBFcnJvciBtZXNz
YWdlIG1vdmVkIHRvIG9uZSBwbGFjZS4NCj4gPiA+Pj4+IC0gbG1iX2FsbG9jX2FkZHIoKSBpcyBu
b3QgcmVxdWlyZWQgYmVjYXVzZSB0aGUgZ2l2ZW4gbWVtb3J5IGFkZHJlc3MNCj4gaXMNCj4gPiA+
Pj4+ICAgICBiZWluZyBjaGVja2VkIHRvIGVuc3VyZSBpdCBpcyBmcmVlIG9yIG5vdC4NCj4gPiA+
Pj4+DQo+ID4gPj4+PiBDaGFuZ2VzIGluIFYyOg0KPiA+ID4+Pj4gLSBSZWJhc2VkIHRoZSBjb2Rl
IGNoYW5nZXMgb24gdG9wIG9mIHRoZSBuZXh0IGJyYW5jaC4NCj4gPiA+Pj4+DQo+ID4gPj4+PiBV
VDoNCj4gPiA+Pj4+IFRlc3RlZCBvbiBWZXJzYWwgTkVUIGJvYXJkDQo+ID4gPj4+Pg0KPiA+ID4+
Pj4gVmVyc2FsIE5FVD4gZmR0IHByaW50IC9yZXNlcnZlZC1tZW1vcnkgcmVzZXJ2ZWQtbWVtb3J5
IHsNCj4gPiA+Pj4+ICAgICAgICAgICByYW5nZXM7DQo+ID4gPj4+PiAgICAgICAgICAgI3NpemUt
Y2VsbHMgPSA8MHgwMDAwMDAwMj47DQo+ID4gPj4+PiAgICAgICAgICAgI2FkZHJlc3MtY2VsbHMg
PSA8MHgwMDAwMDAwMj47DQo+ID4gPj4+PiAgICAgICAgICAgdGYtYSB7DQo+ID4gPj4+PiAgICAg
ICAgICAgICAgICAgICByZWcgPSA8MHgwMDAwMDAwMCAweDcwMDAwMDAwIDB4MDAwMDAwMDAgMHgw
MDA1MDAwMD47DQo+ID4gPj4+PiAgICAgICAgICAgICAgICAgICBuby1tYXA7DQo+ID4gPj4+PiAg
ICAgICAgICAgfTsNCj4gPiA+Pj4+IH07DQo+ID4gPj4+PiBWZXJzYWwgTkVUPiBzZiByZWFkIDB4
NzAwMDAwMDAgMHgwIDB4NDAgZGV2aWNlIDAgb2Zmc2V0IDB4MCwgc2l6ZQ0KPiA+ID4+Pj4gMHg0
MA0KPiA+ID4+Pj4gRVJST1I6IHRyeWluZyB0byBvdmVyd3JpdGUgcmVzZXJ2ZWQgbWVtb3J5Li4u
DQo+ID4gPj4+Pg0KPiA+ID4+Pj4gVmVyc2FsIE5FVD4gc2Ygd3JpdGUgMHg3MDAwMDAwMCAweDAg
MHg0MCBkZXZpY2UgMCBvZmZzZXQgMHgwLA0KPiA+ID4+Pj4gc2l6ZSAweDQwDQo+ID4gPj4+PiBF
UlJPUjogdHJ5aW5nIHRvIG92ZXJ3cml0ZSByZXNlcnZlZCBtZW1vcnkuLi4NCj4gPiA+Pj4+DQo+
ID4gPj4+PiByZWxvY2FkZHIgICA9IDB4MDAwMDAwMDA3ZmViYzAwMA0KPiA+ID4+Pj4NCj4gPiA+
Pj4+IFZlcnNhbCBORVQ+IHNmIHJlYWQgMHgwMDAwMDAwMDdmZWJjMDAwIDB4MCAweDQwIGRldmlj
ZSAwIG9mZnNldA0KPiA+ID4+Pj4gMHgwLCBzaXplIDB4NDANCj4gPiA+Pj4+IEVSUk9SOiB0cnlp
bmcgdG8gb3ZlcndyaXRlIHJlc2VydmVkIG1lbW9yeS4uLg0KPiA+ID4+Pj4NCj4gPiA+Pj4+IFZl
cnNhbCBORVQ+IHNmIHdyaXRlIDB4MDAwMDAwMDA3ZmViYzAwMCAweDAgMHg0MCBkZXZpY2UgMCBv
ZmZzZXQNCj4gPiA+Pj4+IDB4MCwgc2l6ZSAweDQwDQo+ID4gPj4+PiBFUlJPUjogdHJ5aW5nIHRv
IG92ZXJ3cml0ZSByZXNlcnZlZCBtZW1vcnkuLi4NCj4gPiA+Pj4+DQo+ID4gPj4+PiAgICBjbWQv
c2YuYyB8IDM2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+ID4+Pj4g
ICAgMSBmaWxlIGNoYW5nZWQsIDM1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+
Pj4+DQo+ID4gPj4+PiBkaWZmIC0tZ2l0IGEvY21kL3NmLmMgYi9jbWQvc2YuYw0KPiA+ID4+Pj4g
aW5kZXggZjQzYTJlMDhiMy4uN2JiOGJjZmNlMiAxMDA2NDQNCj4gPiA+Pj4+IC0tLSBhL2NtZC9z
Zi5jDQo+ID4gPj4+PiArKysgYi9jbWQvc2YuYw0KPiA+ID4+Pj4gQEAgLTEwLDYgKzEwLDcgQEAN
Cj4gPiA+Pj4+ICAgICNpbmNsdWRlIDxkaXY2NC5oPg0KPiA+ID4+Pj4gICAgI2luY2x1ZGUgPGRt
Lmg+DQo+ID4gPj4+PiAgICAjaW5jbHVkZSA8bG9nLmg+DQo+ID4gPj4+PiArI2luY2x1ZGUgPGxt
Yi5oPg0KPiA+ID4+Pj4gICAgI2luY2x1ZGUgPG1hbGxvYy5oPg0KPiA+ID4+Pj4gICAgI2luY2x1
ZGUgPG1hcG1lbS5oPg0KPiA+ID4+Pj4gICAgI2luY2x1ZGUgPHNwaS5oPg0KPiA+ID4+Pj4gQEAg
LTI3Miw2ICsyNzMsMzEgQEAgc3RhdGljIGludCBzcGlfZmxhc2hfdXBkYXRlKHN0cnVjdCBzcGlf
Zmxhc2gNCj4gKmZsYXNoLCB1MzIgb2Zmc2V0LA0KPiA+ID4+Pj4gICAgICAgICAgIHJldHVybiAw
Ow0KPiA+ID4+Pj4gICAgfQ0KPiA+ID4+Pj4NCj4gPiA+Pj4+ICsjaWZkZWYgQ09ORklHX0xNQg0K
PiA+ID4+Pj4gK3N0YXRpYyBpbnQgZG9fc3BpX3JlYWRfbG1iX2NoZWNrKHVsb25nIHN0YXJ0X2Fk
ZHIsIGxvZmZfdCBsZW4pIHsNCj4gPiA+Pj4+ICsgICAgICAgcGh5c19zaXplX3QgbWF4X3NpemU7
DQo+ID4gPj4+PiArICAgICAgIHVsb25nIGVuZF9hZGRyOw0KPiA+ID4+Pj4gKw0KPiA+ID4+Pj4g
KyAgICAgICBsbWJfZHVtcF9hbGwoKTsNCj4gPiA+Pj4+ICsNCj4gPiA+Pj4+ICsgICAgICAgbWF4
X3NpemUgPSBsbWJfZ2V0X2ZyZWVfc2l6ZShzdGFydF9hZGRyKTsNCj4gPiA+Pj4+ICsgICAgICAg
aWYgKCFtYXhfc2l6ZSkgew0KPiA+ID4+Pj4gKyAgICAgICAgICAgICAgIHJldHVybiBDTURfUkVU
X0ZBSUxVUkU7DQo+ID4gPj4+PiArICAgICAgIH0NCj4gPiA+Pj4+ICsNCj4gPiA+Pj4+ICsgICAg
ICAgZW5kX2FkZHIgPSBzdGFydF9hZGRyICsgbWF4X3NpemU7DQo+ID4gPj4+PiArICAgICAgIGlm
ICghZW5kX2FkZHIpDQo+ID4gPj4+PiArICAgICAgICAgICAgICAgZW5kX2FkZHIgPSBVTE9OR19N
QVg7DQo+ID4gPj4+PiArDQo+ID4gPj4+PiArICAgICAgIGlmICgoc3RhcnRfYWRkciArIGxlbikg
PiBlbmRfYWRkcikgew0KPiA+ID4+Pj4gKyAgICAgICAgICAgICAgIHJldHVybiBDTURfUkVUX0ZB
SUxVUkU7DQo+ID4gPj4+PiArICAgICAgIH0NCj4gPiA+Pj4NCj4gPiA+Pj4gVGhpcyBpcyBvbmUg
d2F5IHRvIGdldCB0aGUgbG9hZCBhZGRyZXNzLCB5ZXMuIEJ1dCBwbGVhc2UgZG8gbm90ZQ0KPiA+
ID4+PiB0aGF0IHdpdGggdGhpcyBtZXRob2QsIGlmIHRoZSByZWdpb24gb2YgbWVtb3J5IGhhcyBh
bHJlYWR5IGJlZW4NCj4gPiA+Pj4gbWFya2VkIGFzIHJlc2VydmVkLCB0aGUgY2FsbCB0byBsbWJf
Z2V0X2ZyZWVfc2l6ZSgpIHdpbGwgZmFpbCwNCj4gPiA+Pj4gaS5lLiByZXR1cm4gYSB2YWx1ZSBv
ZiAwLiBXaGVyZWFzIGlmIHlvdSBjYWxsIGxtYl9hbGxvY19hZGRyKCksDQo+ID4gPj4+IGFuZCBp
ZiB0aGUgbWVtb3J5IHJlZ2lvbiBpcyBtYXJrZWQgcmVzZXJ2ZWQgd2l0aCB0aGUgZmxhZ3Mgc2V0
IHRvDQo+ID4gPj4+IExNQl9OT05FLCB0aGF0IGNhbGwgd2lsbCBub3QgZmFpbCwgYXMgd2UgY2Fu
IHJlLXJlc2VydmUgbWVtb3J5DQo+ID4gPj4+IG1hcmtlZCBhcyBMTUJfTk9ORS4gSGVuY2UgYSBi
ZXR0ZXIgYXBwcm9hY2ggd291bGQgYmUgdG8gdXNlIHRoZQ0KPiA+ID4+PiBsb2dpYyB1c2VkIGlu
IHRoZSBmcyBtb2R1bGUgZnVuY3Rpb24gdGhhdCBJIGhhZCBwb2ludGVkIHRvIGluIG15IGVhcmxp
ZXINCj4gZW1haWwuDQo+ID4gPj4+DQo+ID4gPj4+IEFsc28sIGxpa2UgSSBtZW50aW9uZWQgZWFy
bGllciwgaXQgd2lsbCBiZSBiZXR0ZXIgdG8gcmVmYWN0b3IgdGhlDQo+ID4gPj4+IGZ1bmN0aW9u
YWxpdHksIGVzcGVjaWFsbHkgaWYgdGhlIHBsYW4gaXMgdG8gaW50cm9kdWNlIHRoaXMgY2hlY2sN
Cj4gPiA+Pj4gZm9yIGxvYWRpbmcgc3R1ZmYgdGhyb3VnaCBvdGhlciBpbnRlcmZhY2VzIGxpa2Ug
bmFuZCwgbW1jIGV0Yy4gWW91DQo+ID4gPj4+IGNhbiBhZGQgYSBmdW5jdGlvbiBpbiB0aGUgbG1i
LmMgbGlrZSBsbWJfcmVhZF9jaGVjaygpIHdoaWNoIGRvZXMgdGhhdC4NCj4gPiA+Pg0KPiA+ID4+
IElzIHRoaXMgc29tZXRoaW5nIHdoYXQgeW91IGFyZSBnb2luZyB0byB3b3JrIG9uPw0KPiA+ID4N
Cj4gPiA+IENhbiB0aGF0IG5vdCBiZSBkb25lIGFzIHBhcnQgb2YgdGhpcyB3b3JrPyBJdCBpcyBh
Ym91dCBoYXZpbmcgYQ0KPiA+ID4gc2luZ2xlIGZ1bmN0aW9uIGluIHRoZSBsbWIuYyBmaWxlLCB3
aGljaCBzaW1wbHkgZG9lcyBhIGNoZWNrIGZvcg0KPiA+ID4gbG1iX2FsbG9jX2FkZHIoKS4gSXQn
cyBub3QgdmVyeSBjb21wbGljYXRlZCB0YmguDQo+ID4NCj4gPiBJdCBpcyBtb3JlIGFib3V0IHRp
bWUgc3BlbnQgb24gaXQuIElmIHlvdSBrbm93IGhvdyBleGFjdGx5IGl0IHNob3VsZA0KPiA+IGxv
b2sgbGlrZSBpdCB3b3VsZCBiZSBlYXNpZXIgZm9yIHlvdSB0byBwdXQgaXQgdG9nZXRoZXIgYW5k
IFByYXNhZCBjYW4NCj4gPiB2YWxpZGF0ZSBpdCBvbiBvdXIgcGxhdGZvcm1zLg0KPiANCj4gUHJh
c2FkLCBDYW4geW91IHRyeSB0aGlzIGNoYW5nZT8gSWYgdGhpcyB3b3JrcywgeW91IGNhbiB1c2Ug
dGhpcy4gSSB3aWxsIHdvcmsgb24NCj4gdXNpbmcgdGhpcyBpbiBvdGhlciBmdW5jdGlvbnMgbGF0
ZXIuDQoNCltQcmFzYWRdOiBJIGhhdmUgdHJpZWQgdGhlIGNoYW5nZXMgYmVsb3csIGFuZCB0aGV5
IGFyZSB3b3JraW5nIGFzIGV4cGVjdGVkLiBJIGhhdmUgc2VudCB2NCB3aXRoIHRoZSBsYXRlc3Qg
Y2hhbmdlcy4NCg0KPiANCj4gZGlmZiAtLWdpdCBhL2NtZC9zZi5jIGIvY21kL3NmLmMNCj4gaW5k
ZXggN2JiOGJjZmNlMi4uMzNkODhhMzUzMSAxMDA2NDQNCj4gLS0tIGEvY21kL3NmLmMNCj4gKysr
IGIvY21kL3NmLmMNCj4gQEAgLTM0MywxMyArMzQzLDEyIEBAIHN0YXRpYyBpbnQgZG9fc3BpX2Zs
YXNoX3JlYWRfd3JpdGUoaW50IGFyZ2MsIGNoYXINCj4gKmNvbnN0IGFyZ3ZbXSkNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgc3RybmNtcChhcmd2WzBdLCAid3JpdGUiLCA1KSA9PSAwKSB7DQo+
ICAgICAgICAgICAgICAgICBpbnQgcmVhZCwgcmV0Ow0KPiANCj4gLSNpZmRlZiBDT05GSUdfTE1C
DQo+IC0gICAgICAgICAgICAgICByZXQgPSBkb19zcGlfcmVhZF9sbWJfY2hlY2soYWRkciwgbGVu
KTsNCj4gLSAgICAgICAgICAgICAgIGlmIChyZXQpIHsNCj4gLSAgICAgICAgICAgICAgICAgICAg
ICAgcHJpbnRmKCJFUlJPUjogdHJ5aW5nIHRvIG92ZXJ3cml0ZSByZXNlcnZlZA0KPiBtZW1vcnku
Li5cbiIpOw0KPiAtICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiArICAgICAg
ICAgICAgICAgaWYgKENPTkZJR19JU19FTkFCTEVEKExNQikpIHsNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgaWYgKGxtYl9yZWFkX2NoZWNrKGFkZHIsIGxlbikpIHsNCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBwcmludGYoIkVSUk9SOiB0cnlpbmcgdG8gb3ZlcndyaXRlDQo+
IHJlc2VydmVkIG1lbW9yeS4uLlxuIik7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgcmV0dXJuIENNRF9SRVRfRkFJTFVSRTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgfQ0K
PiAgICAgICAgICAgICAgICAgfQ0KPiAtI2VuZGlmDQo+IA0KPiAgICAgICAgICAgICAgICAgcmVh
ZCA9IHN0cm5jbXAoYXJndlswXSwgInJlYWQiLCA0KSA9PSAwOw0KPiAgICAgICAgICAgICAgICAg
aWYgKHJlYWQpDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xtYi5oIGIvaW5jbHVkZS9sbWIuaCBp
bmRleCA2ZWYwM2Y5YjYzLi42MDEwNTVhODM3DQo+IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xt
Yi5oDQo+ICsrKyBiL2luY2x1ZGUvbG1iLmgNCj4gQEAgLTEyMiw2ICsxMjIsMTEgQEAgc3RydWN0
IGxtYiAqbG1iX2dldCh2b2lkKTsgIGludCBsbWJfcHVzaChzdHJ1Y3QgbG1iDQo+ICpzdG9yZSk7
ICB2b2lkIGxtYl9wb3Aoc3RydWN0IGxtYiAqc3RvcmUpOw0KPiANCj4gK3N0YXRpYyBpbmxpbmUg
aW50IGxtYl9yZWFkX2NoZWNrKHBoeXNfYWRkcl90IGFkZHIsIHBoeXNfc2l6ZV90IGxlbikgew0K
PiArICAgICAgIHJldHVybiBsbWJfYWxsb2NfYWRkcihhZGRyLCBsZW4pID09IGFkZHIgPyAwIDog
LTE7IH0NCj4gKw0KPiAgI2VuZGlmIC8qIF9fS0VSTkVMX18gKi8NCj4gDQo+ICAjZW5kaWYgLyog
X0xJTlVYX0xNQl9IICovDQo+IA0KPiAtc3VnaG9zaA0K
