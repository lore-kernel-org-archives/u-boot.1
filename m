Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1839FC27C77
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 15:11:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D37688224;
	Wed, 12 Jun 2024 17:11:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=cern.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cern.ch header.i=@cern.ch header.b="PpuaS+Rf";
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="PpuaS+Rf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B58588224; Wed, 12 Jun 2024 17:11:33 +0200 (CEST)
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2620::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67C6E882E0
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 17:11:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=cern.ch
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vasileios.amoiridis@cern.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PwQH5tkYunfQY8j0gq0OBCYMwzqzTR107AZsk/OVEKuGWv+CuV03AkemQUWHQ9l7PDlb9uKgCItMnGNP38k8W0/PqIhdHLqMkNE2AebhrCMSMJ7xKtWytPa80BCcWovLuBw++qknEnitvSjMhOEo+DTshtWNyNOV0KTKttkFjj3BGXkV5uhIioqLJzu1r9GLwkcdfgwMb8hLMTzdvtKlR0dOoB+gMwj2SgAbbhWgf5UjJvyWn10vehdp0su75R55n/y+vYqEqQanim1DhJpyCIfOq2tSLKJfyID+ejrBuvGoc5+lUOfx0WD9fHeoXsG/J3DNnUTFdMFvouk4ah9w3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9RJqMwpcAAT0CwMRyEywy7cI92uRlcQ3lPYivD6HHec=;
 b=TfMKhdpyHIdcj2KT79Ldys4zYRum8Dd+lfYhwLWgbXB7cnCX8jYS/JI+GXVWbnu2jotnkE3YUuYDGqypuAyql6paL5D0iGVNSIcZWRn71ny1vwygDCpO5XpZ9GpQAh6zdJSzRPm4/nurvT61uQpSHWVy9iUF6qMUZhBpl4LlXCklEGsG4oE7GqZsjf02qwhKUxN9bMLxbIKg84fCqoVEnNbD8D4JbbWpEGqkiomq4bjcv7cHX1TfHU/VvVWPvawUfCbTgLw1iUrXGY4nvqYdy4rBlQV841czJz47kUPi/JPLQh+iOxugKxzndtl0gPVlLvOgdMTU5kP7ealAaHpeRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 51.107.2.244) smtp.rcpttodomain=amd.com smtp.mailfrom=cern.ch; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cern.ch; dkim=pass
 (signature was verified) header.d=cern.ch; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RJqMwpcAAT0CwMRyEywy7cI92uRlcQ3lPYivD6HHec=;
 b=PpuaS+RfvNkju2YMVTrhwywAWhWrgVD6VWawNWM/IirTeoNqkX7gYzjVLrye53HF9qDWUxkjCe2sn9h0JXKsl2TwS67xsOzlaVP+DFwdj2oliT9sXfdDPrsFbvcLOfedre6cjwwubuBKo2KE7glZ7wE/Zsq2m9WE2cGsvMF5fqU=
Received: from DUZPR01CA0128.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::21) by ZR0P278MB0917.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:42::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Wed, 12 Jun
 2024 15:11:27 +0000
Received: from DB3PEPF0000885A.eurprd02.prod.outlook.com
 (2603:10a6:10:4bc:cafe::ca) by DUZPR01CA0128.outlook.office365.com
 (2603:10a6:10:4bc::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20 via Frontend
 Transport; Wed, 12 Jun 2024 15:11:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 51.107.2.244)
 smtp.mailfrom=cern.ch; dkim=pass (signature was verified)
 header.d=cern.ch;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 51.107.2.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=51.107.2.244; helo=mx2.crn.activeguard.cloud; pr=C
Received: from mx2.crn.activeguard.cloud (51.107.2.244) by
 DB3PEPF0000885A.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7677.15
 via Frontend Transport; Wed, 12 Jun 2024 15:11:27 +0000
Received: from xguard (ag_core.activeguard.xor [172.18.0.5])
 by mx2.crn.activeguard.cloud (Postfix) with ESMTP id BA670814E1;
 Wed, 12 Jun 2024 17:11:26 +0200 (CEST)
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2040.outbound.protection.outlook.com [104.47.22.40])
 by mx2.crn.activeguard.cloud (Postfix) with ESMTPS id 6E4688140C;
 Wed, 12 Jun 2024 17:11:25 +0200 (CEST)
Authentication-Results-Original: auth.opendkim.xorlab.com; dkim=pass (1024-bit
 key; unprotected) header.d=cern.ch
 header.i=@cern.ch header.a=rsa-sha256
 header.s=selector1 header.b=PpuaS+Rf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RJqMwpcAAT0CwMRyEywy7cI92uRlcQ3lPYivD6HHec=;
 b=PpuaS+RfvNkju2YMVTrhwywAWhWrgVD6VWawNWM/IirTeoNqkX7gYzjVLrye53HF9qDWUxkjCe2sn9h0JXKsl2TwS67xsOzlaVP+DFwdj2oliT9sXfdDPrsFbvcLOfedre6cjwwubuBKo2KE7glZ7wE/Zsq2m9WE2cGsvMF5fqU=
Received: from ZR2P278MB1164.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:5f::9) by
 GV0P278MB0052.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:27::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.20; Wed, 12 Jun 2024 15:11:23 +0000
Received: from ZR2P278MB1164.CHEP278.PROD.OUTLOOK.COM
 ([fe80::b971:7e0c:3b2d:cc67]) by ZR2P278MB1164.CHEP278.PROD.OUTLOOK.COM
 ([fe80::b971:7e0c:3b2d:cc67%3]) with mapi id 15.20.7633.036; Wed, 12 Jun 2024
 15:11:23 +0000
From: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
To: "vassilisamir@gmail.com" <vassilisamir@gmail.com>, "monstr@monstr.eu"
 <monstr@monstr.eu>
CC: "michal.simek@amd.com" <michal.simek@amd.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "santoshsagar.algapally@amd.com"
 <santoshsagar.algapally@amd.com>, "LPolak@arri.de" <LPolak@arri.de>,
 "venkatesh.abbarapu@amd.com" <venkatesh.abbarapu@amd.com>, "sr@denx.de"
 <sr@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 0/1] xilinx: Add option to load environment from
 outside of
Thread-Topic: [PATCH v2 0/1] xilinx: Add option to load environment from
 outside of
Thread-Index: AQHatdXD0/P73fwV50Kiuh9pvfodrrHEMRQAgAAEGQCAAA32AIAABsSA
Date: Wed, 12 Jun 2024 15:11:23 +0000
Message-ID: <a1567b35ac623cfcbcc28ba12f43813f6e3d8887.camel@cern.ch>
References: <20240603164738.437834-1-vassilisamir@gmail.com>
 <CAHTX3d+mD+iqJ-+N4W+y5XVUozVqq-n19-zRBBT5BqDs3BpJAg@mail.gmail.com>
 <482398653f2b41292c056eb67077ca29f0b9a7ae.camel@cern.ch>
 <48dc217d-f5ca-4ba0-b174-18b4ba6ac0d8@monstr.eu>
In-Reply-To: <48dc217d-f5ca-4ba0-b174-18b4ba6ac0d8@monstr.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cern.ch;
x-ms-traffictypediagnostic: ZR2P278MB1164:EE_|GV0P278MB0052:EE_|DB3PEPF0000885A:EE_|ZR0P278MB0917:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b81c49d-9377-4232-75da-08dc8af1ee76
x-ld-processed: c80d3499-4a40-4a8c-986e-abce017d6b19,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?VGtqZ3VuVE9RYnFXcEFlR0NPRnE5L2ZGeE1kSkx1dnVZQUw0YU5jMWQ4aDFl?=
 =?utf-8?B?eEx5NEFnWTdDRFN2a3R4MitoMVo1clJWQitFTXlsODNwV0RYTjBlMDA3K0hH?=
 =?utf-8?B?M2NKZXBvZktxakhzdGJpWHBtSHc1VHdCbUJhV0VIeXk1UkNtRnRKUXYzalcx?=
 =?utf-8?B?WW4xMnN1dmszYUxURllBbGNPbUdGQ1BEUVY2UE5KSGV1Y2Q3dDRRemJtVUZl?=
 =?utf-8?B?OEJsaURkcnMrd3RFTmNCa0VyRWdJOUtveGNMem1FRkFudnptWjVDeDRzcDJk?=
 =?utf-8?B?Uk8zMndKYlFVeC9yRDFUdGJsZDlQWVBraXk2WC9ac0t4K0IwUUx5SUVNdHJQ?=
 =?utf-8?B?SElmdWNkVDVoVmRjUDVEUFM2bHF5Tmh1QktKcktMK1d3bTIzSGFQVENPMXQ1?=
 =?utf-8?B?bDg1MmpYRDdycXJwTkpvcEplSVAxMG44enBSbk9TWStCd2xEdjRqTkMrZytw?=
 =?utf-8?B?ZWh1QUtubG5xcGVTRXpaWnhwYmw3dnpTazFOdUVIZ1loZC9MSldpWWs0bzhx?=
 =?utf-8?B?WDYxTTZjditkU2o1ZnV3MnViU0kyQ2c3dWxVWXBXRVlJWGFUTWxzSzR0YjlE?=
 =?utf-8?B?TURkR08vSkcraElKN3hmYWY4eVQ1S1diTmgwV1VLaTAvcWd0aXU5MGlraGtZ?=
 =?utf-8?B?bXpJZXovQ2lMS2RLZWZKby8zZnZ1NWlUMVZySWZNbEl3bEZmODl1MFpRaU15?=
 =?utf-8?B?ZENHQ1EzTWJnNGM1anl6NTlWQmUxVDhKRy9CVm41K291VVVQL2VveVhrWi9V?=
 =?utf-8?B?QVRjR1dxMkQyNHFDRlRhMFFaZFF3RnVaUm1QQ2MwcTdDSGdTdGxJL1U1SVlp?=
 =?utf-8?B?OTRKeEo5cmJtV3Z4bHQwMzRRa0NHSS9KSmQ4S1l4K3BYNksvMldPaUpTbUdi?=
 =?utf-8?B?cmpMUGNXQUZ2TllyVkduQ3FxVEhUZGpVWDR1VlBSaUtGV1lqZStuc3ZIVVNi?=
 =?utf-8?B?NTZ0a3gxNFd3NWNOQ0toUHltbEV6Nk01UTQzR0h0RFlkUmZ0VWRKWEJITDRF?=
 =?utf-8?B?SnBFdTRzNWdPb1VTdk44OG8vTTJxcWUvZEVuQytybHFiL3J1cit6c1R5UzVr?=
 =?utf-8?B?VXk5N3JXd0V0WGd3YmIwV2pZUUVCSkM2WlFORVV2eGswTVBYRUljN1lkZmRz?=
 =?utf-8?B?TWhzY1ZSdlZIWWQvcjBma3hiRVFMNERXOXNwWW9mN3N6dEZVQVErYStlclhj?=
 =?utf-8?B?YjhOTjRKNU45SVcyajkvVy9FNXFEL0lsVDlyUXloT1hhYVNxVDEzZGpvMlM3?=
 =?utf-8?B?QU9YK0xxVmptMDJiNFlvUmZ1OE92bTVjb1VjbDBVVllkdFR2N25DaURRbC9K?=
 =?utf-8?B?anNLQ3dHcUdOSGZNdjAvdHh0VHV4TVFhTEpCekFIWHk1U245NDM2d21GTVJ0?=
 =?utf-8?B?U09IMzBRd2xuckhHZng1eEJ0TjJhd2tqMU1aeVBYZFNsQ3FRY3hPMmMvOGFm?=
 =?utf-8?B?N0JyODlDaXhqem5ubGtPcnpUQlhTZENLaytIZHEyanJMdUVmdE94eElRVHJl?=
 =?utf-8?B?ZTNOU3djZ0hrMmpoSEhxUGVxcEN5K1h3VStsUDVzaFkyV2ZMKzhkRUJEUjFT?=
 =?utf-8?B?Y1pSVlBrSXZMalZpM0llNm00SEU0b0tQR3lpbWJ6RlNHUTFmNjRydm54dWNl?=
 =?utf-8?B?MTRYV2QvZjdZbTR1Y0Z4OGJNNEl2VzVEWHd3SUM3RldIYTRWYXJwVWhEZGFC?=
 =?utf-8?B?OGx1ajZFOVlPV3dwazlXdHBrU0tPb2NYQldSbkNhaUs0Ykd1NzhpNTYycG1u?=
 =?utf-8?B?eHV0aFNkU01FdjFHSU9MaWhzZklDTWpFQlcwY0pTb0tTMmg3MDBPemV5eExO?=
 =?utf-8?Q?4epwECJT8CTaR1Rg0iYPqGdsKsPAUwjr0Y1+4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5966A1F6466389449AC01CD54DFA2F8B@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0052
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB3PEPF0000885A.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 50c99759-3aae-4111-6f71-08dc8af1ec33
X-Microsoft-Antispam: BCL:0;
 ARA:13230032|376007|82310400019|35042699015|1800799017|36860700006; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UHpqZm5KS2hEa1FvcWM1K1VPYXJzcDBjUEk1RWpldXorTENNUUNZS0RwTVFj?=
 =?utf-8?B?ckFUZTlRRHlwTnRaaU1DalpKYkVrUEZLK3M4ZUs3VVNxS1dRZ3ZibXMrR2dS?=
 =?utf-8?B?T0dKR2JsTXhleFZrU3RMWmg4dEdlcnJiQ2wrSkVudGpYeVA3THFKVVNwVGR0?=
 =?utf-8?B?bENZRVdsNWVRNUM2RkJhM3JoS2llc3dHT3Q1cXJUUC9ndnRneTdwS2tjT0ta?=
 =?utf-8?B?dlBHYUgzNC90OVRTNndoTTZuWFpBbWlvanQzWHFzUy9lY2R6N00zNXdTdU1Y?=
 =?utf-8?B?VllqaGlKZjFxNWtKRE1PZ3BWQWt3YUp5YmFEUnFZVTl2aUxNVy8yMnRtcTBm?=
 =?utf-8?B?SFpqbklnb3doenhUVitiZmV2NkNCWG9GZG9XMTRpTS9aTXNWUkJDR3JrWlhS?=
 =?utf-8?B?NEFDckl3M3Nuekl4ZlBsNm5mQkNKVzZaNnRZaXpNS0tsTVl3ZUNTaFhRTUFw?=
 =?utf-8?B?aStTS1hiclpNdjZxQ3RoWnlXekp4V1FiV3dqRU03d09FTFNPS2xRZTFEVHFr?=
 =?utf-8?B?Y2xVdUsxaUVUeWZKYm1zczEvZDgycVNGK2RuM3IzcFJGZ2dRciswYjVkSWNo?=
 =?utf-8?B?NTcyNnlEWjlIV1RmWVgyL2FLcmIvWGRQUktsQUNVUFI1Zy9aUU5YVjlxR3dK?=
 =?utf-8?B?RWh1U1BuUkZmWkw1dEVlQjZtME11R0ZHT21jenI0NTZVd0xQeUFCdVZBMy9X?=
 =?utf-8?B?blpPU0hxVTBGMmR3ZE5VVXRPdHU4K0FsbEJabzBSdncrTE1RSGNqTHBTbTFE?=
 =?utf-8?B?dk9JZ1p3RldubXRGayt6c1hUWXBLQm1hZ01Ra2hpSUVFalVCOENqTmpsRTgr?=
 =?utf-8?B?RFZVQXJEQVNzNUlnOUZveEJpVW51Mm5qYnJuRzFQakRMZVFQZUdQa3hSMXdF?=
 =?utf-8?B?TkFQajdGNjU1ZUVaRVdvUi9TQURLckNaRjEzRWJUVzZSWFgzTWg4dG5hZDcz?=
 =?utf-8?B?a0JmMEhXdlRrbm9XTFNkN1ZOb3pGRzJRckQvR0RDNUxIN2g5TGswUDdERnQx?=
 =?utf-8?B?M0VFUlp2WU1sVkhhaUEvZnFJN2xiVTRGZ1Zvd1JDTDRUZW1UZEZPcTJncmR3?=
 =?utf-8?B?UElaK1BlVEtieVR5SlNHK1IwZkQwNU0xSGI0ME9XWEhqYlIyc3QyQTE4TjF2?=
 =?utf-8?B?d2l6SHJFd2FjY3E1bTFzc2tYdkR4RGNQTkxoTmNCaHNVcDFsbUczc1A2K0lw?=
 =?utf-8?B?aGlHcXRKeEpqcFR0NVRVK0Q3TC9UL25xU1JmYWtVdjdjQTU5dG9XT2xlWmEr?=
 =?utf-8?B?a1pnSlFQRXFRK1ZKMkY5Y2VoMDNDRFdJaVZlRGhGMUZwTDlId3ptN0NxbnVm?=
 =?utf-8?B?STF4c3NXU3phL3BKc1BhMUtwRXR6a2lxRjhiT1BqbVBXQXMzbWxHYzNxYVJU?=
 =?utf-8?B?MWtqVFBydCs3dnFFN1lzYmJac0FWR2hkTGlqUktCMlh0OU5oVEp6TWJRRHJB?=
 =?utf-8?B?VDBGZEFqTVJlR1dEWVJHMklseWtzV1Y2Sk4zeHh4V3NVd1B1VXp1a2Z2dC82?=
 =?utf-8?B?NFVRRDhWaU1PL0gveWM2UTU0RkdlOXlBMWdWM2svYlkzWE5kL0tZQUM5WVdG?=
 =?utf-8?B?MDdld1l3eEYvelBhYm8yOTBPRWt2ZE1EYTR6V2lveXNMV2FYYTNZVUZQU0ZY?=
 =?utf-8?B?QWVPWEZUNDNQK3BXaTZuRHZKdlBpWW9PdGk2cFROM0d6V0RyRGRyNkRvSG1t?=
 =?utf-8?B?K3NyRDg3UWZSSy9OcjRwdTkvSms1N3lZdHprcmhFc0pOWldES0E5cm1IdmlJ?=
 =?utf-8?B?ZDVjUnJTVStTTWpxRzRFSnZqcWsvRGFyR0FtazliTzFpSjYxQ05vNFlJUm8z?=
 =?utf-8?B?OGszSzBXeGc3VzhwUG5FS0Yxb09zVmk0dkZ4VURPeVU5NFRWVlZkR2ZDTXJ5?=
 =?utf-8?B?cm8rMkRqNVJHd3ZybndCUkRaMzNBZkp1YnZndHAxcVNLVEE9PQ==?=
X-Forefront-Antispam-Report: CIP:51.107.2.244; CTRY:CH; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mx2.crn.activeguard.cloud; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230032)(376007)(82310400019)(35042699015)(1800799017)(36860700006);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 15:11:27.1166 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b81c49d-9377-4232-75da-08dc8af1ee76
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19; Ip=[51.107.2.244];
 Helo=[mx2.crn.activeguard.cloud]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF0000885A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0917
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

T24gV2VkLCAyMDI0LTA2LTEyIGF0IDE2OjQ3ICswMjAwLCBNaWNoYWwgU2ltZWsgd3JvdGU6DQo+
IA0KPiANCj4gT24gNi8xMi8yNCAxNTo1NywgVmFzaWxlaW9zIEFtb2lyaWRpcyB3cm90ZToNCj4g
PiBPbiBXZWQsIDIwMjQtMDYtMTIgYXQgMTU6NDIgKzAyMDAsIE1pY2hhbCBTaW1layB3cm90ZToN
Cj4gPiA+IEhpIFZhc2lsZWlvcywNCj4gPiA+IA0KPiA+ID4gw7p0IDQuIDYuIDIwMjQgdiAxNToy
MSBvZGVzw61sYXRlbCBWYXNpbGVpb3MgQW1vaXJpZGlzDQo+ID4gPiA8dmFzc2lsaXNhbWlyQGdt
YWlsLmNvbT4gbmFwc2FsOg0KPiA+ID4gPiANCj4gPiA+ID4gRnJvbTogVmFzaWxlaW9zIEFtb2ly
aWRpcyA8dmFzaWxlaW9zLmFtb2lyaWRpc0BjZXJuLmNoPg0KPiA+ID4gPiANCj4gPiA+ID4gQ2hh
bmdlcyBpbiB2MjoNCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoCAtIFJlbW92ZSBkdXBsaWNhdGlv
biBvZiBjdXN0b20gaGFyZGNvZGVkDQo+ID4gPiA+IGVudl9sb2NhdGlvbnNbXQ0KPiA+ID4gPiBj
b2RlLg0KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgIC0gQWRkIGltcGxlbWVudGF0aW9uIHdpdGgg
Z2VuZXJhbA0KPiA+ID4gPiBhcmNoX2Vudl9nZXRfbG9jYXRpb24ob3AsDQo+ID4gPiA+IHByaW8p
DQo+ID4gPiA+IA0KPiA+ID4gPiB2MToNCj4gPiA+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
dS1ib290LzIwMjQwNTIyMTc0NzM4LjczNTIyLTEtdmFzc2lsaXNhbWlyQGdtYWlsLmNvbS8NCj4g
PiA+ID4gDQo+ID4gPiA+IFZhc2lsZWlvcyBBbW9pcmlkaXMgKDEpOg0KPiA+ID4gPiDCoMKgIHhp
bGlueDogQWRkIG9wdGlvbiB0byBsb2FkIGVudmlyb25tZW50IGZyb20gb3V0c2lkZSBvZiBib290
DQo+ID4gPiA+IG1lZGlhDQo+ID4gPiA+IA0KPiA+ID4gPiDCoMKgYm9hcmQveGlsaW54L3ZlcnNh
bC1uZXQvYm9hcmQuYyB8IDQ3ICsrKysrKysrKysrKysrLS0tLS0tLS0tLQ0KPiA+ID4gPiAtLS0t
DQo+ID4gPiA+IMKgwqBib2FyZC94aWxpbngvdmVyc2FsL2JvYXJkLmPCoMKgwqDCoCB8IDQ3ICsr
KysrKysrKysrKysrLS0tLS0tLS0tLQ0KPiA+ID4gPiAtLS0tDQo+ID4gPiA+IMKgwqBib2FyZC94
aWxpbngvenlucS9ib2FyZC5jwqDCoMKgwqDCoMKgIHwgNDkgKysrKysrKysrKysrKysrLS0tLS0t
LS0tDQo+ID4gPiA+IC0tLS0tDQo+ID4gPiA+IMKgwqBib2FyZC94aWxpbngvenlucW1wL3p5bnFt
cC5jwqDCoMKgIHwgNTUgKysrKysrKysrKysrKysrKystLS0tLS0tDQo+ID4gPiA+IC0tLS0tDQo+
ID4gPiA+IC0tLS0NCj4gPiA+ID4gwqDCoDQgZmlsZXMgY2hhbmdlZCwgMTAxIGluc2VydGlvbnMo
KyksIDk3IGRlbGV0aW9ucygtKQ0KPiA+ID4gPiANCj4gPiA+ID4gLS0NCj4gPiA+ID4gMi4zNC4x
DQo+ID4gPiA+IA0KPiA+ID4gDQo+ID4gPiBJIGhhdmUgdG8gcmVtb3ZlIHRoaXMgcGF0Y2ggZnJv
bSBteSBxdWV1ZSBiZWNhdXNlIGl0IGlzIGFjdHVhbGx5DQo+ID4gPiBicmVha2luZyBjdXJyZW50
IGJlaGF2aW9yLg0KPiA+ID4gQ0kgaXMgcmVwb3J0aW5nIGFuIGlzc3VlIHdpdGggaXQgYW5kIEkg
ZGlkIGEgY2xvc2VyIGxvb2sgYW5kIHdoYXQNCj4gPiA+IGlzDQo+ID4gPiBoYXBwZW5pbmcgaXMg
dGhhdCBpZiBvbmUgbG9jYXRpb24gaGFzIG5vIHZhbGlkDQo+ID4gPiBkYXRhIGl0IGdvZXMgYW5k
IGxvb2tzIGF0IGFub3RoZXIgbG9jYXRpb24gZnJvbSB0aGUgbGlzdC4NCj4gPiA+IA0KPiA+IA0K
PiA+IEJ1dCB0aGF0IGlzIHRoZSBkZXNpcmVkIGJlaGF2aW9yLCBpZiB0aGUgZW52aXJvbm1lbnQg
aXMgbm90IGluIG9uZQ0KPiA+IGxvY2F0aW9uIHRvIGNoZWNrIHRvIHRoZSBvdGhlcnMuDQo+IA0K
PiBUaGF0J3MgaG93IHUtYm9vdCBpcyB3cml0dGVuIGJ1dCBpZiBkZXZpY2UgZG9lc24ndCBleGlz
dCBvciBub3QNCj4gYWNjZXNzaWJsZSBieSANCj4gdS1ib290IGl0IGlzIGNsZWFyIHRoYXQgaXQg
c2hvdWxkbid0IGJlIHVzZWQgYW5kIHRoZW4gYmVoYXZpb3IgaXMNCj4gY29ycmVjdC4NCj4gDQoN
CkhtbW0sIGhvdyBjYW4gYSBkZXZpY2UgYmUgbm90LWFjY2Vzc2libGUgYnkgdS1ib290IGJ1dCB1
LWJvb3Qgc3RpbGwNCnRyaWVzIHRvIHVzZSBpdD8gSG93IGNvdWxkIHRoYXQgaGFwcGVuPw0KDQpB
bHNvLCBJIHRoaW5rIHRoYXQgdGhpcyBpcyBhIHByb2JsZW0gb2YgdGhlIHVzZXIsIG5vPyBJZiBm
b3IgZXhhbXBsZQ0KeW91IGhhdmUgY29uZmlndXJlIEVOVl9JU19JTl9OQU5EIGJ1dCB0aGVyZSBp
cyBubyBOQU5EIGRldmljZSwgdGhlbg0Kd2l0aCB0aGUgcGF0Y2ggeW91IGdldCBhIHZpc2libGUg
ZXJyb3IgdGhhdCBVLUJvb3QgdHJpZXMgdG8gYWNjZXNzDQpOQU5EIHdoaWNoIGlzIG5vdCB0aGVy
ZS4NCg0KPiBJZiBkZXZpY2UgZXhpc3RzIGFuZCBzaW1wbGUgdmFyaWJsZXMgYXJlIG5vdCB5ZXQg
c2F2ZWQgdGhlcmUgZ29pbmcgdG8NCj4gZGlmZmVyZW50IA0KPiBkZXZpY2UgaXMgSU1ITyBwcm9i
bGVtYXRpYy4NCj4gDQoNCk1heWJlIEkgYW0gc3RpbGwgYSBiaXQgY29uZnVzZWQsIGJ1dCBJIHRo
aW5rIHRoYXQgaWYgeW91IGhhdmUgZGVmaW5lZA0KRU5WX0lTX0lOX1FTUEkgYW5kIEVOVl9JU19J
Tl9OQU5EIGJ1dCB0aGUgZW52aXJvbm1lbnQgaXMgbm90IHRoZXJlIHRoZW4NCnRoZSBiZWhhdmlv
ciB0aGF0IHdlIHNlZSBpcyBhY3R1YWxseSBjb3JyZWN0LiBVLUJvb3QgdHJpZXM6DQoNCmEpIEdl
dCBlbnYgZnJvbSBRU1BJIGJ1dCBmYWlscyBiZWNhdXNlIGVudiBpcyBub3QgdGhlcmUsDQpiKSBH
ZXQgZW52IGZyb20gTkFORCBidXQgZmFpbHMgYmVjYXVzZSBOQU5EIGlzIG5vdCB0aGVyZSwNCmMp
IEdldCBlbnYgZnJvbSBub3doZXJlLg0KDQpUbyBtZSwgdGhpcyBsb29rcyBsaWtlIHRoZSBjb3Jy
ZWN0IGJlaGF2aW9yLiBJc24ndCBpdD8NCg0KDQo+ID4gDQo+ID4gPiBPbiBaeW5xIGl0IGJlaGF2
ZXMgbGlrZSB0aGlzLg0KPiA+ID4gDQo+ID4gPiBNTUM6wqDCoCBtbWNAZTAxMDAwMDA6IDANCj4g
PiA+IHByaW8gMA0KPiA+ID4gTG9hZGluZyBFbnZpcm9ubWVudCBmcm9tIFNQSUZsYXNoLi4uIFNG
OiBEZXRlY3RlZCBuMjVxMTI4YTEzIHdpdGgNCj4gPiA+IHBhZ2UNCj4gPiA+IHNpemUgMjU2IEJ5
dGVzLCBlcmFzZSBzaXplIDY0IEtpQiwgdG90YWwgMTYgTWlCDQo+ID4gPiAqKiogV2FybmluZyAt
IGJhZCBDUkMsIHVzaW5nIGRlZmF1bHQgZW52aXJvbm1lbnQNCj4gPiA+IA0KPiA+ID4gcHJpbyAx
DQo+ID4gPiBMb2FkaW5nIEVudmlyb25tZW50IGZyb20gTkFORC4uLiAqKiogRXJyb3IgLSBObyBW
YWxpZCBFbnZpcm9ubWVudA0KPiA+ID4gQXJlYSBmb3VuZA0KPiA+ID4gKioqIFdhcm5pbmcgLSBi
YWQgZW52IGFyZWEsIHVzaW5nIGRlZmF1bHQgZW52aXJvbm1lbnQNCj4gPiA+IA0KPiA+ID4gcHJp
byAyDQo+ID4gPiBMb2FkaW5nIEVudmlyb25tZW50IGZyb20gU1BJRmxhc2guLi4gKioqIFdhcm5p
bmcgLSBiYWQgQ1JDLCB1c2luZw0KPiA+ID4gZGVmYXVsdCBlbnZpcm9ubWVudA0KPiA+ID4gDQo+
ID4gPiBwcmlvIDMNCj4gPiA+IExvYWRpbmcgRW52aXJvbm1lbnQgZnJvbSBub3doZXJlLi4uIE9L
DQo+ID4gPiANCj4gPiA+IA0KPiA+IA0KPiA+IFRoaXMgaXMgdGhlIG1lc3NhZ2UgdGhhdCB3ZSBn
ZXQgYXMgd2VsbCB3aGVuIHRoaXMgcGF0Y2ggaXMgbm90DQo+ID4gYWRkZWQuDQo+IA0KPiBJdCBt
ZWFucyB5b3UgYXJlIGJvb3Rpbmcgb3V0IG9mIFFTUEkgYnV0IHFzcGkgaXMgbm90IGFjY2Vzc2li
bGUgYnkgdS0NCj4gYm9vdC4gQ29ycmVjdD8NCj4gDQo+IA0KDQpXZWxsLCB3ZSBhcmUgYm9vdGlu
ZyBmcm9tIFFTUEkgYnV0IGVudmlyb25tZW50IGlzIGluIGVNTUMuIEluIG91cg0KY29uZmlnLCB3
ZSBoYXZlIGRlZmluZWQgRU5WX0lTX0lOX0ZBVCBhbmQgRU5WX0lTX05PV0hFUkUgYnV0IHdlIGhh
dmUNCm5vdCBkZWZpbmVkIEVOVl9JU19JTl9RU1BJLiANCg0KPiA+ID4gcHJpbyBpcyBteSBwcmlu
dCB0byBzaG93IHdoZXJlIGNvZGUgaXMuIFFlbXUgYm9vdHMgb3V0IGluIFFTUEkNCj4gPiA+IGJv
b3QNCj4gPiA+IG1vZGUgYW5kIFNQSSBpcyB0cmllZCBmaXJzdCBhbmQgYmVjYXVzZQ0KPiA+ID4g
dGhpcyBpcyB4aWxpbnhfenlucV92aXJ0IGRlZmNvbmZpZyBkcml2ZXJzL2VudiBsb2NhdGlvbnMg
Zm9yDQo+ID4gPiBvdGhlcg0KPiA+ID4gZGV2aWNlcyBhcmUgcHJlc2VudCB0b28uIFRoYXQncyB3
aHkgaXQgZ29lcyBvdmVyIHRoZSBsaXN0DQo+ID4gPiBhbmQgaXQgYWx3YXlzIGVuZHMgaW4gbm93
aGVyZSB3aGljaCBuZXZlciBmYWlscy4NCj4gPiA+IA0KPiA+ID4gSWYgdGhpcyBydW5zIG9uIHJl
YWwgSFcgdGhlbiB0aGUgc2FtZSBiZWhhdmlvciBpcyB2aXNpYmxlIGFuZCBJDQo+ID4gPiBkb24n
dA0KPiA+ID4gdGhpbmsgaXQgaXMgcmlnaHQuDQo+ID4gPiBJIHRoaW5rIHRoaXMgc29sdXRpb24g
c2hvdWxkIGJlIHJldGhvdWdodC4NCj4gPiA+IEluIHByb2R1Y3QgY3VycmVudCBiZWhhdmlvciBm
cm9tIG91ciBjb2RlIGlzIG5vdCB0aGUgYmVzdCBhbmQNCj4gPiA+IGN1cnJlbnQNCj4gPiA+IFUt
Qm9vdCBpbXBsZW1lbnRhdGlvbiBpcyBub3QgYWxsb3dpbmcNCj4gPiA+IGZsZXhpYmlsaXR5IHRv
by4gV2UgYXJlIGVuYWJsaW5nIHJlZHVuZGFudCB2YXJpYWJsZXMgd2hpY2ggY2FuIGJlDQo+ID4g
PiBvbmx5DQo+ID4gPiBvbiB0aGUgc2FtZSBkZXZpY2UgYnV0IG5vdCB0aGF0IHlvdSBoYXZlDQo+
ID4gPiBvbmUgY29weSBpbiBRU1BJIGFuZCBzZWNvbmQgaW4gRU1NQy4NCj4gPiA+IFRoYXQncyB3
aHkgSSB0aGluayBsb2NhdGlvbiBzaG91bGQgYmUgcHJldHR5IG11Y2ggcmVhZCBmcm9tIERULg0K
PiA+ID4gVGhlcmUgaXMgb3B0aW9ucy91LWJvb3Qgbm9kZSB3aGVyZSBsb2NhdGlvbiBvZiB2YXJp
YWJsZXMgc2hvdWxkDQo+ID4gPiBiZQ0KPiA+ID4gZGVzY3JpYmVkIGFuZCB0aGlzIHNob3VsZCBy
ZXBsYWNlDQo+ID4gPiBlbnZfZ2V0X2xvY2F0aW9uKCkuDQo+ID4gDQo+ID4gWW91IG1lYW4gdGhh
dCB0aGVyZSBzaG91bGQgYmUgc29tZSB0eXBlIG9mIG5ldyBVLUJvb3Qgbm9kZSB0aGF0DQo+ID4g
ZGVzY3JpYmVzIHdoZXJlIHRoZSBlbnZpcm9ubWVudCBzaG91bGQgYmUgbG9jYXRlZCBhbmQgZ28g
YW5kDQo+ID4gc2VhcmNoIGluIHRoaXMgZGV2aWNlPw0KPiANCj4gTm90IHN1cmUgaWYgbm9kZSBv
ciBqdXN0IGR0IHByb3BlcnR5IHdoaWNoIHBvaW50cyB3aGVyZSB0aGF0DQo+IHZhcmlhYmxlcyBh
cmUgc3RvcmVkLg0KPiANCj4gDQoNClRoaXMgZG9lc24ndCBzb3VuZCB0b28gZGlmZmljdWx0IHRv
IGRvLiBTdGlsbCwgZXZlbiBpZiB0aGlzIHdhcyBkb25lLA0Kd2hhdCB3b3VsZCB0aGUgcHJpb3Jp
dHkgYmUgZm9yIGxvb2tpbmcgZm9yIHRoZSBlbnZpcm9ubWVudD8gRm9yIG5vdywNCnRoZSBjb2Rl
IGlzIHdyaXR0ZW4gaW4gYSB3YXkgdG8gY2hlY2sgZm9yIHRoZSBlbnZpcm9ubWVudCBvbmx5IGlu
IHRoZQ0KYm9vdG1lZGlhLiBNeSBwYXRjaCBhZGRlZCBhIGZ1bmN0aW9uYWxpdHkgdGhhdCBpZiB0
aGUgZW52aXJvbm1lbnQgaXMNCm5vdCBpbiB0aGUgYm9vdG1lZGlhIHRvIGNoZWNrIHNvbWV3aGVy
ZSBlbHNlLiBUaGlzIHNob3VsZCBiZSB0aGUgb3JkZXINCmFsc28gaWYgd2UgaGFkIHRoaXMgdS1i
b290IG5vZGU/IENoZWNrIGZpcnN0IGluIHRoZSBib290bWVkaWEgYW5kIHRoZW4NCmNoZWNrIGlm
IHRoZXJlIGlzIGEgZHQgcHJvcGVydHk/DQoNCj4gPiA+IEl0IGlzIGEgbG90IG9mIHdvcmsgdGhh
dCdzIHdoeSBJIHRoaW5rIHNlY29uZCBzb2x1dGlvbiBpcyBtb3JlDQo+ID4gPiByZWFzb25hYmxl
IGZvciB5b3Ugd2hpY2ggaXMgc2ltcGx5IGNyZWF0ZSBuZXcgS2NvbmZpZyBzeW1ib2wNCj4gPiA+
IHRvIGRpc2FibGUgYm9hcmQgZW52X2dldF9sb2NhdGlvbigpIGltcGxlbWVudGF0aW9uLg0KPiA+
ID4gDQo+ID4gPiBUaGFua3MsDQo+ID4gPiBNaWNoYWwNCj4gPiA+IA0KPiA+IA0KPiA+IFlvdSBt
ZWFuIHRvIGJhc2ljYWxseSBkaXNhYmxlIHRoZSBib2FyZCBlbnZfZ2V0X2xvY2F0aW9uKCkgdGhh
dA0KPiA+IGV4aXN0cyBpbiBib2FyZC94aWxpbngvenlucW1wL3p5bnFtcC5jIGZvciBleGFtcGxl
Pw0KPiANCj4geWVzLiBTb21ldGhpbmcgbGlrZSB0aGlzLg0KPiANCj4gY29uZmlnIEJPQVJEX0VO
Vl9MT0NBVElPTg0KPiDCoMKgwqDCoMKgwqDCoMKgYm9vbCAiVXNlIGJvYXJkIGRlZmluZWQgRU5W
IGxvY2F0aW9uIg0KPiDCoMKgwqDCoMKgwqDCoMKgZGVmYXVsdCB5DQo+IMKgwqDCoMKgwqDCoMKg
wqAuLi4NCj4gDQo+IGlmIGRlZmluZWQgKEJPQVJEX0VOVl9TRVRVUC9MT0NBVElPTikNCj4gZW51
bSBlbnZfbG9jYXRpb24gZW52X2dldF9sb2NhdGlvbihlbnVtIGVudl9vcGVyYXRpb24gb3AsIGlu
dCBwcmlvKQ0KPiB7DQo+IC4uLg0KPiB9DQo+IGVuZGlmDQo+IA0KPiBNDQo+IA0KPiANCg0KVGhp
cyB3aWxsIGJlIGFjY2VwdGVkIGJ5IHlvdSBpbiB1cHN0cmVhbT8NCg0KQ2hlZXJzLA0KVmFzaWxp
cw0K
