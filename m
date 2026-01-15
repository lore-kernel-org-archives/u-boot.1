Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E79D46602
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 17:01:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D63798367F;
	Thu, 15 Jan 2026 18:01:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="LX3yLMIh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C8DC8367F; Thu, 15 Jan 2026 17:17:04 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E353F80325
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 17:17:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jamie.Gibbons@microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RN8Qvfky05pjITY9mHpmZ/h8WkEzcenzXZ0VaT9jAGBJW96Ql2kK/COxz6MvN3KbSumdjE45Ku55mJJFXWZolxsdVGHWK9elGk48IWX1mXDIOarNvtN8Z8/kY30IDR6hNFYs9pATzxKhp9U29iBnnAu5Twn0fZaxhY9O4YuhRfLs/SqWeBvFI4yb44n3BrjIc4hp6bwaMqHeBRuUV23zaMbc0koaWEhQIMlxwk2PE/QLiUcqMFTYyjxBAYK3OUgpSgZ+bh4tLKaMfZKY8hzk/cJxX0bAk2gBdNiAl3foocA1znfb5kPyk22ax2QfbjxJvB1dzGKMV7HYVsmEnAemog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFumZwoju3U7/9QwJ9QupQPY5cf5P0wqJaA7uKYMTUY=;
 b=uinlpypUFw7o+Kmi3HLu2mzCA4uw5MqNergHeFc+yUWOw36ql17jv2Rh2dSdtxTk7S95BRcxY2cXVuFJxUlInYqmMjNRVte3fUHe3GOz8WdlZlCdw1hN03Z7N3m590dwBQWqkQ5U6oti3ZOyV/U3BNAG/P7tF6cW73fiOaxRhrxWmJBWlqh8Hl+NgyHmtP5Cwy+rpG0G4FO+J5XkPYKJPqI+FtgnTBmR54XLkGBuhCyAtLXlyMS4Q7Mg3Bw2apQlpgYHXbvJn7EOiq/ym3iTvlO5mlU9ooTfyVaXPCfzN6out63N5MkNpfRyWfmOHjkGJxexStkfgZ3zk6LfB+99zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFumZwoju3U7/9QwJ9QupQPY5cf5P0wqJaA7uKYMTUY=;
 b=LX3yLMIhW+uYCO+b6U9gzwZ7BsZfsG0hrmziJmOAPxR+JtH7Ib4b+WPZIoITGnr3mqhAXg7U/SkrRqNwLCBXFMIZgSJShyYrZHdw9/xCgavjZW8facTED3GwYgMQaal0DPN2GQ6frNHITyHbslSz/Md1npiLeTHqQBPxRnX0IuBCnfuURUBvFJuSbX20aVgbOODhNTzZ2VLZIESxKVYs99KMrjgnhTks+TufwXdTupyLRitVm8ezduHCg0aGgWJeHFBLD0/4M+v1yph/kkXXXUPIM1TQI21Pw32vKW113fGF5GSweNJip9qnxTTtdpyuk8FQCMC3OY2N1oiWZhKbcg==
Received: from DM4PR11MB6335.namprd11.prod.outlook.com (2603:10b6:8:b7::10) by
 PH7PR11MB5915.namprd11.prod.outlook.com (2603:10b6:510:13c::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.5; Thu, 15 Jan 2026 16:16:56 +0000
Received: from DM4PR11MB6335.namprd11.prod.outlook.com
 ([fe80::3adb:8c97:94da:80]) by DM4PR11MB6335.namprd11.prod.outlook.com
 ([fe80::3adb:8c97:94da:80%3]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 16:16:56 +0000
From: <Jamie.Gibbons@microchip.com>
To: <trini@konsulko.com>
CC: <andrew.goodbody@linaro.org>, <u-boot@lists.denx.de>,
 <michael@amarulasolutions.com>, <Conor.Dooley@microchip.com>,
 <Valentina.FernandezAlanis@microchip.com>, <fberder@outlook.fr>
Subject: Re: [PATCH v2 2/2] dm: core: Default to using DEVRES outside of xPL
Thread-Topic: [PATCH v2 2/2] dm: core: Default to using DEVRES outside of xPL
Thread-Index: AQHchWGRWanG+SXlbE+k2PlHaUCZCLVRupuAgAAHLQCAAaguAA==
Date: Thu, 15 Jan 2026 16:16:56 +0000
Message-ID: <9fd13735b55dac213d23dc13309f0c3199be481e.camel@microchip.com>
References: <20251219202121.4180810-1-trini@konsulko.com>
 <20251227223833.3019311-1-trini@konsulko.com>
 <20251227223833.3019311-3-trini@konsulko.com>
 <ef5c3866fa673dd814264f1a26f73c5a9fb75b6b.camel@microchip.com>
 <20260114145842.GD3416603@bill-the-cat>
In-Reply-To: <20260114145842.GD3416603@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6335:EE_|PH7PR11MB5915:EE_
x-ms-office365-filtering-correlation-id: 7e9225cc-8b39-40c2-7097-08de545180b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|4053099003|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?TDQ5Z1gzeTF3UkpnUG92UzBxc0xueWNJMHJSVEU4QzRGc2k0WVc4ZHR0aytK?=
 =?utf-8?B?SUx4OEFXWStxVUkyWTB0N2FVUFBnOEdyT0s0V25hTG9OYUtXTENCT2RVRWdG?=
 =?utf-8?B?b2QzNDNPaTEyVHNHVzZnRXFxbjNRditTdU5pNURmUGdyMGIvaloyYy9KM3Zo?=
 =?utf-8?B?Z1BieE9BYnhhb3BSQ3hLZTlvUTdFVkhYak0yS1N6Y3AzZWg4amFhekl3Q1Rz?=
 =?utf-8?B?REk1SHo1ZE5jcTdCeG93dHhiZUg4ZThQM2wxNlhZYlZOVHdDbTJSNU0rZHZs?=
 =?utf-8?B?WDR5K2p4dGZRcHQyM2l2dFNQN3k2QTZUb2xQaEd6YkdpVjBnT3FvS2FjaGJa?=
 =?utf-8?B?WWRXM1JFb2tYalh0VC9LTXdhT2JRQVhLNnRHdC82dGRkNXZDOXhOcHVpbmlz?=
 =?utf-8?B?bUJoa3BmL2ZPS3ZqS1l2dWxvc3pxSGRIL3EvVVNXZzEzWDdvMDJkeFdmUkVT?=
 =?utf-8?B?U1NETVpKRW1COHdUV0lRYXI1YWxQblRzdm9FQjRwY2tFc0tlcU5iMHVNLys5?=
 =?utf-8?B?d0RscXJYWEFEKzNrR2c2V29OOEVNbjJJRG1RZ0F2OWdDWGxjdngyMUFncWEr?=
 =?utf-8?B?dnEzUUNSUzdqWjNkalJTeTMrVXphcnNKTXBicnZUbWlFb3E4cUFjbGs3WW1w?=
 =?utf-8?B?ME12VHduT21GcUx6TlZlZnh0cExoQWRvd1F3MjF0MTJKUFJJUUJHYzZlemFt?=
 =?utf-8?B?ekkvQnBNWUtZYWlKbFQ1N0NNSTJlSVpQZTI2VFlnZ0VCc1pieFhNWGFSbGhO?=
 =?utf-8?B?d3JKdXBORFdqWldRL2cwVDFELzhMRXpuV0dlbTBtMWdvSThMMnY4SjZPVkdB?=
 =?utf-8?B?MWV5UEFod2d6YXZFcFVPRmZ1cEpPd2JZRHhyUk0yVzdvN2RQdHM0NG43Q3ly?=
 =?utf-8?B?NHBTNVhkM0dhRk1LZ29EMTk3RXF3c0Q0Q1dNV2tyMDdLbXFJOG9XSzRWS094?=
 =?utf-8?B?RjlEWnRJRGtSZm1tNEZNRDRPNkU2TmNZbkpxTTcxeFpmSzk1YzRleWdhUG91?=
 =?utf-8?B?V1BOVTJFbW5JTEpSdmN0T0NJZll3TDdjWFl3V28yOTVCeDA2OVpMblBCY1Z2?=
 =?utf-8?B?OU5UaWM4dTYxZGF6MjNnZnZQcmZIcndLa2ZMT1RYM1A0VnFvOHBDMGxUU0JI?=
 =?utf-8?B?aTlyNllDNkMyQWVjZ253YWpObE9qVjkvcmlkQmxhbm44K3hWcDk4RTgvWXlR?=
 =?utf-8?B?eHBUQ3hoNlp2cC9aU1cyeFVtYmlyQ281L0hxWTIwdjhoYUZka2ZJTzNBSDBk?=
 =?utf-8?B?VSs3UVd4Wjhqdkh2MXExcG5BeCthWjl5dmRpZ28wRFVjZ3RCNTBGZW9tMmp3?=
 =?utf-8?B?M2VvNzZad3p6d2tCVTNacWlZMk1HUmJES3lHa0Vlc0tvZEVVVkxjNitteFJv?=
 =?utf-8?B?b3RMTUVOYkRyZXdab3c2TXVwdmZuRTZQSnZsNWF2cXNYcklkMDJTbS93QlpN?=
 =?utf-8?B?SC9Ramo3Y3JabUlEWnc5SGFERVo3TFRSNG82ZzYvOGEzRmM3ZDYwb3lEbG1M?=
 =?utf-8?B?RnIxcWxUTVFCYXdNdC9tV1JWSjBnYWV6cFZTWGErNVY2bWlDMTRyRXE5L0hY?=
 =?utf-8?B?QkMwUk1idzVja3QxT0IwdmRBQk8zVDA2aXA1ekpSQ3JKdFhtcGFOUlA4eWYy?=
 =?utf-8?B?UHg3Nkhad2YwZUhBQ1JRNGpDczlGOE14eXdxT0taMnZIbkVNT0JzTlc0Tk9r?=
 =?utf-8?B?bC84b1c4QUVPV1VrM29KQmhaMmRNUUdUSVFONmcyL0dreVJyTUNzL0orK0Er?=
 =?utf-8?B?U2RCZUliQ29uTDYyYkc1cGM5WDAzYnZnVTR6OVFNKzErOVduWGdVZDNKb2lM?=
 =?utf-8?B?VFdnQVpHL1RjU2ltWjFWdFhRdFR4VFRGZDd2dHJhZkJqN3hhcmRONlJNS1BG?=
 =?utf-8?B?WSt3ZDFiQnVzRFNqSEk2MGRzQmlrYWx3QlJmTHlWeUdqMlRxVDkwd0l5L3lN?=
 =?utf-8?B?UDRhTjA3OU5pNEJQSmlRS1hMSjd3eGpxcDJrMXFrQ0hiZ1FUSExTT2Vrdm8x?=
 =?utf-8?B?NnlGaFVUdzl2VFZzdkV1ZWZvOWg5ZlZobHdIaVJnTWo5RDVtdU56VjFUK0Ix?=
 =?utf-8?B?R0VYeUVoQXBzQXR1bkR0S2srQzZoM3BVOVVaS01zbDJrdmRQT2w0ZG5RaU1j?=
 =?utf-8?B?aCtPdWpZT1BkTFNwOXU1WlBSUnJXdUhxcktENHkyUUdpOWt2SVJrQk0vZmF4?=
 =?utf-8?Q?HSgArV5E8HXcdnLAa7lLWJg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6335.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(4053099003)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qi9zTUpRbDVqK2w2V2tJUlN5NUhvZDh0RTVKc2EyWlNoWGFGUnIyWlh6bm42?=
 =?utf-8?B?c3RkZTUzY3U5VkNsYWNIMUlwa1RlYmhST3dObkNSYzA0MnF5NUIwY3NTeUEz?=
 =?utf-8?B?NHNZM3N6eTZRd0lQY0pqZUIwZ2pVelNBNm9LRTRvd0VSZjdqSTIxZXgzT3A3?=
 =?utf-8?B?VWZUVUdlVFR0UzJPc0FMTTMyQm5IdGRGU0xSV2lEb0NlV3hhNzVsMXVIaUI1?=
 =?utf-8?B?UFZKVHRFUCsrY2tnZ1NnMGt2dmJueVZGaHBlZ0JoUUhXemR4MUkrcGtGeVNo?=
 =?utf-8?B?cGNyb1AvU1BOUzlQMHlFenVIWFE3clFjN2U5QysreThOUDdsREhTL0pQU0VW?=
 =?utf-8?B?K1FrOHNGcVc3VGQyVTBvMFhaYmZUVXNWaFZ6S01xZW1DK2l6R1hqNTBNYmd0?=
 =?utf-8?B?bVZlQmtjOE5WWEdFU1QwUlFsZlVreW5QN21HUDl2V3k2SWxxOFpRRVRWRlNS?=
 =?utf-8?B?QktjUjlNSkZHNDVaK0RSSm0vUDNXK05zdlRhWEJBNlh6UUUzUjBwbkFEUXBh?=
 =?utf-8?B?ZTZyTDJJNWxtNTdTemRST3N1a1dmN1M4ampYM3A0cTNXQTVGNTBTM280clpa?=
 =?utf-8?B?YUhJTS9xT0RZa05ISXIvRUpaaDVPaUFGMHVzRGQzdlpiNmVuV3VGTSsyR2R4?=
 =?utf-8?B?SmFIcll3WlJHejZRZmNOM2hMYk1GbWVWRkRMMnhiVUZPWFN0VHhFK09aRXJQ?=
 =?utf-8?B?WTFEbzQvZk1LaGJKM2UwMUZ4R2pTSHI3N0srZDByTVlscGR4QWJORnVCVWN3?=
 =?utf-8?B?di8yUzFUTkxzNDFwenVEZGQ1bnRxb0VJWUVrd25hV2RsUUk5ckxnTUJUcjZa?=
 =?utf-8?B?L3MwbThYdFhSeDFYWG45OGJ0VVhVWlQyWmM1cm9TVDhiV3VMWitjL2pqU1RG?=
 =?utf-8?B?dEh3djZPYk5uMnJ2S2hnWGxieVlwY04yYXh0c1Y5TGpYRG9rSVlsbldIQ2RD?=
 =?utf-8?B?YlV3dEo0M3FFU0Fwa3R0cmc3SXkrRGcyaExuSURGc04wd21neE5SM0hXejZj?=
 =?utf-8?B?bnhvRlRHNzV5aGVVSTlyOUdQbnp2eGVlaGtaYWV0ZGxUUGdpV2JOb2FJVzFz?=
 =?utf-8?B?OStoWDRyVEZUMTBGb0F6Y0h0V1hJb1ZEOGdJa05RamVVa3lpZktuNVZQTUpq?=
 =?utf-8?B?STlWSlZVWGplQUYxNDRhTkJPUGJvR1ExV0phWmpSVWtrYWpMQ2hDWVVjVkJE?=
 =?utf-8?B?M3dEb0tSd3FuR0RkZExFS1JxOFhodVVCWjRNRmJWYnpNbDBYWEw3V2tzQWhl?=
 =?utf-8?B?RmJ4Y2htQ2VkYkJXNWVJL0RyZC8wVEN4OXVGbkhrOFhZRG55QlNOaldGMmsy?=
 =?utf-8?B?Szc2emxSdFFRejRmVmYwSzE0c3hjb1VZSHpzenptejFYZjVldWRCeUhMTDNR?=
 =?utf-8?B?T3BmTHhnWHUrckcrOXF5SW4wTnZKMWJvdzhybkFDb3c5L09LMVp4ckxSTTNr?=
 =?utf-8?B?RjIvK3lsNG5oMk93eFZSMWtrb2ZGaDd4dEswbXk2a1drWXZSUjViWnRWdmdK?=
 =?utf-8?B?YktoeS9SNXRtS1BiYkNNUnVnc1NaNzFWZkREQjJJbFJFZmhER0ZiWGNFZUpQ?=
 =?utf-8?B?aklXZkZoQXZhalEzN0VUTE83WlN3allvMG85ejduL2V3dzdMK1hvNmR3dldQ?=
 =?utf-8?B?eHNLRFpvcnVJbitSL0E5Y0I2SjE1V3JUaStzcmY5OWxZZW11dUgyQjZaQnk0?=
 =?utf-8?B?Znh4cXlZWlFMWXdMbkN5U1B4cUNZQyt6R0JUaEhqY1ZvaWQ1dzdNUG1xMTEv?=
 =?utf-8?B?MmwzMGZPMis5WE41TFVnZ0F2d1ZTc0hhNXd5RGFzaEMvZS9TQ3JUemdDOHk0?=
 =?utf-8?B?ZDMzbnZKMUxOa1Q1SlhjcHB6andxMXJhVmdaZUI5SEo2Sml6SlZESlZTclB0?=
 =?utf-8?B?SHkvOVJZR2g3REpVcGxpYy9BWTV0OUhjSldRS2JKQUIrb3FUcjA0Mm1ZOWxo?=
 =?utf-8?B?cjBMYW5uZS81R3Y2bHp2NnpiRGJKSUpSem9qZ2NuZnBMd1JSMksrdUg2aHky?=
 =?utf-8?B?MTZ1TUl5NUlZZlUrOWZ6Q0RPT25Na2Nta1FXdTBCTWN2dHg1YzNlM1RacnI2?=
 =?utf-8?B?LzBOYWtRTG5USm5rOXQzeTRCYUxSM0o2NFl5V3RITlRUakRSNkgyck9tVTht?=
 =?utf-8?B?TVY1WDd6aS9PcXVYTit4MVczeXB4ek1yL1djVElMZ01OUTlwdHprOWZtcEds?=
 =?utf-8?B?YUJ1RklnU05uZ044ZWFLSVQwek4wZUNua1BlZnlvTnpGcFEzbUJmWTV6VGJP?=
 =?utf-8?B?a3J1c3VwTThIWjFPL0ZBR2ZMSGV4TVlwN05BUThYajJ0ZXVXWDlMSzZBZ25D?=
 =?utf-8?B?WVBxYkllZXBHY0tFWGR3Q0RyMDMyTGF1eUoyekYxTkU5M1RBejhIbWlQSlFw?=
 =?utf-8?Q?F0cTZjcHUKSQH0ys=3D?=
Content-Type: multipart/mixed;
 boundary="_002_9fd13735b55dac213d23dc13309f0c3199be481ecamelmicrochipc_"
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6335.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e9225cc-8b39-40c2-7097-08de545180b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2026 16:16:56.1028 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7xp1AVe91huxvZ/rPx9LeZxeoTwqF8ZHEgPb0sV+6limozG9yKofp5lQtdGdlhKZNEDu8uD5FDtewXpLHrDX8Wn+MD4uDJb3Q4NMUKp+EiU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5915
X-Mailman-Approved-At: Thu, 15 Jan 2026 18:01:19 +0100
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

--_002_9fd13735b55dac213d23dc13309f0c3199be481ecamelmicrochipc_
Content-Type: text/plain; charset="utf-8"
Content-ID: <96D661902C0C5A408F8EB0980F0236A4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64

SGkgVG9tLA0KDQpPbiBXZWQsIDIwMjYtMDEtMTQgYXQgMDg6NTggLTA2MDAsIFRvbSBSaW5pIHdy
b3RlOg0KPiBPbiBXZWQsIEphbiAxNCwgMjAyNiBhdCAwMjozMzowNFBNICswMDAwLA0KPiBKYW1p
ZS5HaWJib25zQG1pY3JvY2hpcC5jb23CoHdyb3RlOg0KPiA+IEhpIGFsbCwNCj4gPiANCj4gPiBP
biBTYXQsIDIwMjUtMTItMjcgYXQgMTY6MzcgLTA2MDAsIFRvbSBSaW5pIHdyb3RlOg0KPiA+ID4g
VGhlIGRldm0gYWxsb2MgZnVuY3Rpb25zIHRoYXQgd2UgaGF2ZSBtYXkgZm9sbG93IHRoZSBMaW51
eCBrZXJuZWwNCj4gPiA+IG1vZGVsDQo+ID4gPiB3aGVyZSBhbGxvY2F0aW9ucyBhcmUgKGFsbW9z
dCBhbHdheXMpIGF1dG9tYXRpY2FsbHkgZnJlZSgpJ2QuDQo+ID4gPiBIb3dldmVyLA0KPiA+ID4g
cXVpdGUgb2Z0ZW4gd2UgZG9uJ3QgZW5hYmxlLCBpbiBmdWxsIFUtQm9vdCwgdGhlIHRyYWNraW5n
IGFuZA0KPiA+ID4gZnJlZSgpJ2luZw0KPiA+ID4gZnVuY3Rpb25hbGl0eS4gVGhpcyBpbiB0dXJu
IGxlYWRzIHRvIG1lbW9yeSBsZWFrcyBiZWNhdXNlIHRoZQ0KPiA+ID4gZHJpdmVyDQo+ID4gPiBh
dXRob3IgZXhwZWN0cyB0aGF0IHNpbmNlIHRoZSBmdW5jdGlvbnMgaGF2ZSB0aGUgc2FtZSBuYW1l
IGFzIGluDQo+ID4gPiB0aGUNCj4gPiA+IExpbnV4IEtlcm5lbCB0aGV5IGhhdmUgdGhlIHNhbWUg
YmVoYXZpb3IuIEluIHR1cm4gd2UgdGhlbiBnZXQNCj4gPiA+IGZ1bmN0aW9uYWxseSBjb3JyZWN0
IGNvbW1pdHMgc3VjaCBhcyBjb21taXQgMDBlMWZlZDkzYzhjDQo+ID4gPiAoImZpcm13YXJlOg0K
PiA+ID4gdGlfc2NpOiBGaXggbWVtb3J5IGxlYWtzIGluIGRldm1fdGlfc2NpX2dldF9vZl9yZXNv
dXJjZSIpIHRoYXQNCj4gPiA+IG1hbnVhbGx5DQo+ID4gPiBhZGQgdGhlc2UgY2FsbHMuIFJhdGhl
ciB0aGFuIG1hbnVhbGx5IHRyYWNraW5nIGFsbG9jYXRpb25zIGFuZA0KPiA+ID4gaW1wbGVtZW50
aW5nIGZyZWUoKXMsIHJld29yayB0aGluZ3Mgc28gdGhhdCB3ZSBmb2xsb3cgZXhwZWN0YXRpb25z
DQo+ID4gPiBieQ0KPiA+ID4gZW5hYmxpbmcgdGhlIERFVlJFUyBmdW5jdGlvbmFsaXR5IChvdXRz
aWRlIG9mIHhQTCBwaGFzZXMpLg0KPiA+ID4gDQo+ID4gPiBUaGlzIHR1cm5zIERFVlJFUyBmcm9t
IGEgcHJvbXB0ZWQgc3ltYm9sIHRvIGEgc3ltYm9sIHRoYXQgbXVzdCBiZQ0KPiA+ID4gc2VsZWN0
J2QsIGFuZCB3ZSBub3cgcmVtb3ZlIG91ciBub24tbWFuYWdlZCBhbGxvYy9mcmVlIGZ1bmN0aW9u
cw0KPiA+ID4gZnJvbQ0KPiA+ID4gb3V0c2lkZSBvZiB4UEwgYnVpbGRzLg0KPiA+ID4gDQo+ID4g
SeKAmXZlIGVuY291bnRlcmVkIGEgcmVncmVzc2lvbiBvbiB0aGUgTWljcm9jaGlwIFBvbGFyRmly
ZSBTb0MgSWNpY2xlDQo+ID4gS2l0DQo+ID4gd2l0aCBtYWlubGluZSBVLUJvb3QuDQo+ID4gDQo+
ID4gQWZ0ZXIgY29tbWl0IDIxN2NmNjU2ZTI0OSAtIHRoZSBhcHBsaWNhdGlvbiBvZiB0aGlzIHBh
dGNoICjigJxkbToNCj4gPiBjb3JlOg0KPiA+IERlZmF1bHQgdG8gdXNpbmcgREVWUkVTIG91dHNp
ZGUgb2YgeFBM4oCdKSwgVS1Cb290IGZhaWxzIHRvIGJvb3Qgb24NCj4gPiB0aGlzDQo+ID4gYm9h
cmQuIEFmdGVyIHRoaXMgcGF0Y2ggd2FzIGFwcGxpZWQgdGhlIEljaWNsZSBraXQgbm8gbG9uZ2Vy
IGJvb3RzDQo+ID4gYW5kDQo+ID4gY3Jhc2hlcyBpbW1lZGlhdGVseSBhZnRlciBPcGVuU0JJLiBC
ZXR3ZWVuIHRoaXMgcGF0Y2ggYW5kIG1hc3Rlcg0KPiA+IEhFQUQNCj4gPiB0aGUgZm9sbG93aW5n
IGVycm9ycyBhcmUgZm91bmQgLSBwbGVhc2Ugc2VlIGF0dGFjaGVkIGxvZ3MgZm9yIG1vcmUNCj4g
PiBkZXRhaWw6DQo+ID4gDQo+ID4gwqDCoMKgIEZhaWxlZCB0byByZXNlcnZlIG1lbW9yeSBmb3Ig
ZmR0IGF0IDB4YmYzODYyMTANCj4gPiDCoMKgwqAgUmVxdWlyZWQgRkRUIHJlbG9jYXRpb24gZm9y
IGFwcGx5aW5nIERUT3MgZmFpbGVkOiAxDQo+ID4gwqDCoMKgIENvdWxkIG5vdCBmaW5kIGEgdmFs
aWQgZGV2aWNlIHRyZWUNCj4gPiDCoMKgwqAgRGV2aWNlIHRyZWUgbm90IGZvdW5kIG9yIG1pc3Np
bmcgRkRUIHN1cHBvcnQNCj4gPiDCoMKgwqAgIyMjIEVSUk9SICMjIyBQbGVhc2UgUkVTRVQgdGhl
IGJvYXJkICMjIw0KPiA+IA0KPiA+IFNvbWV0aW1lcywgSSBhbHNvIHNlZSBhbiDigJxVbmhhbmRs
ZWQgZXhjZXB0aW9uOiBJbGxlZ2FsIGluc3RydWN0aW9u4oCdDQo+ID4gYW5kDQo+ID4gYSByZXNl
dC4NCj4gPiANCj4gPiBUaGUgbGFzdCBrbm93biBnb29kIGNvbW1pdCBpcyBiZWZvcmUgdGhpcyBj
b21tbWl0LiBJIHVzZWQgYGdpdA0KPiA+IGJpc2VjdGANCj4gPiB0byBjb25maXJtIHRoYXQgMjE3
Y2Y2NTZlMjQ5ICh0aGlzIHBhdGNoKSBpcyB0aGUgZmlyc3QgYmFkIGNvbW1pdC4NCj4gPiANCj4g
PiBTdGVwcyB0byByZXByb2R1Y2U6DQo+ID4gLSBCdWlsZCBVLUJvb3QgZm9yIE1QRlMgSWNpY2xl
IEtpdA0KPiA+IC0gQm9vdCB1c2luZyBIU1MgcGF5bG9hZCBhcyB1c3VhbCAtIEkgdXNlIG91ciBi
dWlsZCBzeXN0ZW0gQnVpbGRyb290DQo+ID4gZm9yDQo+ID4gdGhpcw0KPiA+IC0gT2JzZXJ2ZSB0
aGUgYm9vdCBmYWlsdXJlIGFmdGVyIHRoZSBhYm92ZSBjb21taXQNCj4gPiANCj4gPiBBbnkgYWR2
aXNlIG9uIHRoZSBwcm9ibGVtPw0KPiANCj4gSXQncyByZWFsbHkgc3RyYW5nZSB0aGF0IGl0IGJp
c2VjdHMgZG93biB0byB0aGlzIGNvbW1pdCwgcmF0aGVyIHRoYW4NCj4gc29tZXRoaW5nIGRldmlj
ZSB0cmVlIHJlbGF0ZWQuIERvIHlvdSBzdGlsbCBoYXZlIGZkdF9oaWdoPTB4ZmZmZmZmZmYNCj4g
b3INCj4gc28gc2V0IGluIHRoZSBlbnZpcm9ubWVudD8gSXQgd2FzIGluIGF0IGxlYXN0IG9uZSBv
ZiB0aGUgbG9ncywgYnV0IEkNCj4gY2FuJ3Qgc2VlIGZvciBzdXJlIGlmIGl0J3MganVzdCB0aGF0
IHRoZSBvdGhlciBsb2cgaXMgZnJvbSBiZWZvcmUgdGhlDQo+IGNvbW1pdCB0aGF0IGFkZGVkIHRo
ZSBwcmludCB3YXJuaW5nIGFib3V0IG5vdCBkb2luZyB0aGF0LCBvciBpZiBpdA0KPiB3YXNuJ3Qg
c2V0Lg0KPiANCkFwb2xvZ2llcyBmb3IgdGhlIGRhbHkgaW4gbXkgcmVzcG9uc2UsIEkgd2FudGVk
IHRvIGRvIHNvbWUgbW9yZQ0KZGVidWdnaW5nIGJlZm9yZSBnZXR0aW5nIGJhY2sgdG8geW91Lg0K
DQpUaGFua3MgZm9yIHRoZSBzdWdnZXN0aW9uIGFib3V0IGZkdF9oaWdoLiBXZSBoYXZlIGl0IHNl
dCBpbiBvdXIgYm9vdA0Kc2NyaXB0cy4gSSBjaGFzZWQgdGhpcyBkb3duIHdpdGggYSBiaXNlY3Qg
dG8gOTIzNWRhOTQ0NmUgKGJvb3Q6IFdhcm4NCnVzZXJzIGFib3V0IGZkdF9oaWdoPX4wIHVzYWdl
KS4gSSBoYXZlIG5vdyBzZXQgZmR0X2hpZ2ggdG8gb3VyIG1heGltdW0NCmFkZHJlc3NhYmxlIHZh
bHVlIGluc3RlYWQgb2YgfjAuIFRoaXMgZG9lcyBnZXQgcmlkIG9mIHRoZSB3YXJuaW5nIGFib3V0
DQpmZHRfaGlnaCBpbiBVLUJvb3QsIHNvIHRoYXQgcGFydCBpcyByZXNvbHZlZC4NCg0KSG93ZXZl
ciwgaXQgZG9lc27igJl0IGZpeCB0aGUgdW5kZXJseWluZyBib290IGlzc3VlIOKAlCBVLUJvb3Qg
c3RpbGwgZmFpbHMNCnRvIGJvb3QgYWx0b2dldGhlci4gRHVyaW5nIHNvbWUgYmlzZWN0aW9ucyBp
dCBvZnRlbiBmYWlscyB0byBhcHBseQ0KZGV2aWNlIHRyZWUgb3ZlcmxheXMgYW5kIGRvZXNu4oCZ
dCBib290IHRoZSBrZXJuZWwgLSBJIGhhdmUgYXR0YWNoZWQgdGhlDQpsYXRlc3QgY3Jhc2ggbG9n
Lg0KDQpGcm9tIG15IGJpc2VjdGluZywgdGhlIG92ZXJsYXkgYnJlYWthZ2Ugc2VlbXMgdG8gc3Rh
cnQgd2l0aCB0aGUNCkRUQy9saWJmZHQgdXBkYXRlIGNvbW1pdCAoMDUzNWU0NmQ1NWQuLi4pLiBB
ZnRlciB0aGF0LCBvdmVybGF5DQphcHBsaWNhdGlvbiBjb25zaXN0ZW50bHkgZmFpbHMsIHJlZ2Fy
ZGxlc3Mgb2YgdGhlIGZkdF9oaWdoIHNldHRpbmdzLiBBcw0KYW4gYWRkaXRpb25hbCBwaWVjZSBv
ZiBpbmZvcm1hdGlvbiBkaXNhYmxpbmcgTVVMVF9EVEJfRklUIGFsbG93cyB0aGUNCmJvYXJkIHRv
IGJvb3QgYXMgZmFyIGFzIGZkdCBlcnJvci4NCg0KTGV0IG1lIGtub3cgaWYgeW91IGhhdmUgYW55
IG90aGVyIGlkZWFzLg0KDQpUaGFua3MhDQo=

--_002_9fd13735b55dac213d23dc13309f0c3199be481ecamelmicrochipc_
Content-Type: text/x-log; name="icicle-uboot-mainline-boot-crash-3.log"
Content-Description: icicle-uboot-mainline-boot-crash-3.log
Content-Disposition: attachment;
	filename="icicle-uboot-mainline-boot-crash-3.log"; size=2789;
	creation-date="Thu, 15 Jan 2026 16:16:55 GMT";
	modification-date="Thu, 15 Jan 2026 16:16:55 GMT"
Content-ID: <EB299BA301EA5B4A818E44FD2CDBC75D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64

VS1Cb290IDIwMjYuMDEtMDA0OTItZzFkNTk0NzkzNjJjNyAoSmFuIDE1IDIwMjYgLSAxNTo0ODoy
MiArMDAwMCkNCg0KQ1BVOiAgIHNpZml2ZSx1NTQtbWMNCk1vZGVsOiBNaWNyb2NoaXAgUG9sYXJG
aXJlLVNvQyBJY2ljbGUgS2l0DQpEUkFNOiAgMTAyMCBNaUIgKHRvdGFsIDIgR2lCKQ0KQ29yZTog
IDY2IGRldmljZXMsIDE1IHVjbGFzc2VzLCBkZXZpY2V0cmVlOiBmaXQNCk1NQzogICBtbWNAMjAw
MDgwMDA6IDANCkxvYWRpbmcgRW52aXJvbm1lbnQgZnJvbSBub3doZXJlLi4uIE9LDQpJbjogICAg
c2VyaWFsQDIwMTAwMDAwDQpPdXQ6ICAgc2VyaWFsQDIwMTAwMDAwDQpFcnI6ICAgc2VyaWFsQDIw
MTAwMDAwDQpOZXQ6ICAgZXRoMTogZXRoZXJuZXRAMjAxMTAwMDAsIGV0aDA6IGV0aGVybmV0QDIw
MTEyMDAwDQpIaXQgYW55IGtleSB0byBzdG9wIGF1dG9ib290OiAwDQpzd2l0Y2ggdG8gcGFydGl0
aW9ucyAjMCwgT0sNCm1tYzAocGFydCAwKSBpcyBjdXJyZW50IGRldmljZQ0KU2Nhbm5pbmcgbW1j
IDA6Mi4uLg0KRm91bmQgVS1Cb290IHNjcmlwdCAvYm9vdC5zY3INCjYyNCBieXRlcyByZWFkIGlu
IDggbXMgKDc2LjIgS2lCL3MpDQojIyBFeGVjdXRpbmcgc2NyaXB0IGF0IDg4MTAwMDAwDQpXb3Jr
aW5nIEZEVCBzZXQgdG8gYmYzNDk1MDANCjY0MjAxOTIgYnl0ZXMgcmVhZCBpbiA4NiBtcyAoNzEu
MiBNaUIvcykNCiMjIExvYWRpbmcga2VybmVsIChhbnkpIGZyb20gRklUIEltYWdlIGF0IDg4MTAw
MDAwIC4uLg0KICAgVXNpbmcgJ2NvbmYtbWljcm9jaGlwLG1wZnMtaWNpY2xlLWtpdCcgY29uZmln
dXJhdGlvbg0KICAgVHJ5aW5nICdrZXJuZWwnIGtlcm5lbCBzdWJpbWFnZQ0KICAgICBEZXNjcmlw
dGlvbjogIExpbnV4IGtlcm5lbA0KICAgICBUeXBlOiAgICAgICAgIEtlcm5lbCBJbWFnZQ0KICAg
ICBDb21wcmVzc2lvbjogIGd6aXAgY29tcHJlc3NlZA0KICAgICBEYXRhIFN0YXJ0OiAgIDB4ODgx
MDAwY2MNCiAgICAgRGF0YSBTaXplOiAgICA2MzYxNjI5IEJ5dGVzID0gNi4xIE1pQg0KICAgICBB
cmNoaXRlY3R1cmU6IFJJU0MtVg0KICAgICBPUzogICAgICAgICAgIExpbnV4DQogICAgIExvYWQg
QWRkcmVzczogMHg4MDIwMDAwMA0KICAgICBFbnRyeSBQb2ludDogIDB4ODAyMDAwMDANCiAgICAg
SGFzaCBhbGdvOiAgICBzaGEyNTYNCiAgICAgSGFzaCB2YWx1ZTogICBlOTJkY2NhZDUxYmY5ZjYx
ZjJhMDhkMjZhM2RhOTA0ZWQ1YTg2OTUwZGI3OGQ5MzliZDYyMWVmOWZlOWI5NWFjDQogICBWZXJp
ZnlpbmcgSGFzaCBJbnRlZ3JpdHkgLi4uIHNoYTI1NisgT0sNCiMjIExvYWRpbmcgZmR0IChhbnkp
IGZyb20gRklUIEltYWdlIGF0IDg4MTAwMDAwIC4uLg0KICAgVXNpbmcgJ2NvbmYtbWljcm9jaGlw
LG1wZnMtaWNpY2xlLWtpdCcgY29uZmlndXJhdGlvbg0KICAgVHJ5aW5nICdmZHQtbXBmcy1pY2lj
bGUta2l0LmR0YicgZmR0IHN1YmltYWdlDQogICAgIERlc2NyaXB0aW9uOiAgRmxhdHRlbmVkIERl
dmljZSBUcmVlIGJsb2INCiAgICAgVHlwZTogICAgICAgICBGbGF0IERldmljZSBUcmVlDQogICAg
IENvbXByZXNzaW9uOiAgdW5jb21wcmVzc2VkDQogICAgIERhdGEgU3RhcnQ6ICAgMHg4ODcxMTQw
MA0KICAgICBEYXRhIFNpemU6ICAgIDI0MjQyIEJ5dGVzID0gMjMuNyBLaUINCiAgICAgQXJjaGl0
ZWN0dXJlOiBSSVNDLVYNCiAgICAgTG9hZCBBZGRyZXNzOiAweDhhMDAwMDAwDQogICAgIEhhc2gg
YWxnbzogICAgc2hhMjU2DQogICAgIEhhc2ggdmFsdWU6ICAgMmExMTFmN2VjYjIxMDU2ZTJlMzE1
ZmFiNjczZmVmNGQ1NjZkN2NkYjAyODRkZTNkZWIzNjYzYTRmYTA3YzYxZg0KICAgVmVyaWZ5aW5n
IEhhc2ggSW50ZWdyaXR5IC4uLiBzaGEyNTYrIE9LDQogICBMb2FkaW5nIGZkdCBmcm9tIDB4ODg3
MTE0MDAgdG8gMHg4YTAwMDAwMA0KICAgTG9hZGluZyBEZXZpY2UgVHJlZSB0byAwMDAwMDAwMGJl
MzMxMDAwLCBlbmQgMDAwMDAwMDBiZTMzOWZmZiAuLi4gT0sNCldvcmtpbmcgRkRUIHNldCB0byBi
ZTMzMTAwMA0KIyMgTG9hZGluZyBmZHQgKGFueSkgZnJvbSBGSVQgSW1hZ2UgYXQgODgxMDAwMDAg
Li4uDQogICBVc2luZyAnY29uZi1taWNyb2NoaXAsbXBmcy1pY2ljbGUtY3B1LW9wcCcgY29uZmln
dXJhdGlvbg0KICAgVHJ5aW5nICdmZHQtbXBmcy1pY2ljbGUtY3B1LW9wcC5kdGJvJyBmZHQgc3Vi
aW1hZ2UNCiAgICAgRGVzY3JpcHRpb246ICBEZXZpY2UgVHJlZSBibG9iIGZvciBDUFUgT3BlcmF0
aW5nIFBvaW50cw0KICAgICBUeXBlOiAgICAgICAgIEZsYXQgRGV2aWNlIFRyZWUNCiAgICAgQ29t
cHJlc3Npb246ICB1bmNvbXByZXNzZWQNCiAgICAgRGF0YSBTdGFydDogICAweDg4NzFlOGE0DQog
ICAgIERhdGEgU2l6ZTogICAgMTM5MiBCeXRlcyA9IDEuNCBLaUINCiAgICAgQXJjaGl0ZWN0dXJl
OiBSSVNDLVYNCiAgICAgTG9hZCBBZGRyZXNzOiAweDhhMGMwMDAwDQogICAgIEhhc2ggYWxnbzog
ICAgc2hhMjU2DQogICAgIEhhc2ggdmFsdWU6ICAgOTM1NWUzZmVhYTRjZTY2M2NiNWEyMjNlZTcz
YTI2ZWYyMjdmMDI1ODYzMjdiM2Y5ZGI0OGI1YzM1ZGRjZGM3OA0KICAgVmVyaWZ5aW5nIEhhc2gg
SW50ZWdyaXR5IC4uLiBzaGEyNTYrIE9LDQpmYWlsZWQgb24gZmR0X29wZW5faW50byBmb3IgRFRP
DQpDb3VsZCBub3QgZmluZCBhIHZhbGlkIGRldmljZSB0cmVlDQogICBVbmNvbXByZXNzaW5nIEtl
cm5lbCBJbWFnZSB0byA4MDIwMDAwMA0KRGV2aWNlIHRyZWUgbm90IGZvdW5kIG9yIG1pc3Npbmcg
RkRUIHN1cHBvcnQNCiMjIyBFUlJPUiAjIyMgUGxlYXNlIFJFU0VUIHRoZSBib2FyZCAjIyM=

--_002_9fd13735b55dac213d23dc13309f0c3199be481ecamelmicrochipc_--
