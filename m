Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A294CCD183
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 15:40:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5B4A839AF;
	Mon, 13 Oct 2025 17:40:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="nQ575p2P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E389D83741; Mon, 13 Oct 2025 14:00:22 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E240883700
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 14:00:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Oleksii_Moisieiev@epam.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KbQ/q8Yy2KcP2dU9kHCuK1fXnKL9B7/etaToHOtcMlqoCc9ckUBNOXf5UH+XEmOVJs4A5HGWBvU4fBwAUZ4HisA/Xz3mQl57O79b5pGcIhsRtJ2lA/B+ZCqYYllfgs48qBvIU7hJc6WZpfrmMt0b3DcQLjJHadc+7meyJQAbANYcjfbirdBqlbHMjnsz5sAq97pRfBICwGDgmN+4m5kTCmaiwdOKY9Xj248QjPHzJs1TzPqZ/TmuiDkJY8eq+2lVmr699n5uSTyfMnnYpYwpM2nRU3zHFwN1Y5ydug+VhJQT+h0tf7BBEJdzYAprKWuQ/Z6CBGqLotCtYsdXMTGohg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W94v8NRgTGhbS1+vW6n0Z0dU8K739EzF4eK8ABpNPF0=;
 b=W5xy08fNbVXyQAiYVY6KyQ5+Gg8RPcmR+qD9oapiybAaoeJ9hcVshX2Nibxc6oZzM7N1oure2MZvLt7xA+R2YI8cVGtbvStfhxidFTfXyst20OmXzo8RNdFAHFR01XvyxZZoy3k+s2lv0QTsuwJcP+DsOkCPOGVZlV5VjraQWAb/k9OBhU7iMK3Y1qIG1J821Bdf8ble4WNl1AEr1seGSgiNlgbb7KA5QyFLbDn7vKL8SdHMlEqPbaaztfEsID4HuLpp+couNHZ3gvEUDjS6/pOSW6kRMbcahmGnAyQfSV41uKfnO9JhrlzJ1KsTA7BKbMQ1bnCakJwNVgCjmWMIfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W94v8NRgTGhbS1+vW6n0Z0dU8K739EzF4eK8ABpNPF0=;
 b=nQ575p2PkNCh7I6bh03QA7MYZafhxRusstAyoS5zqlwZ3E64OQOKcxQ7jfqGsXtmToN4vuz9pSIye/16TuHFordhK3hBd41EzrwbdIN/+czEMk8yCaQVycfgShiRR6B7lFwaPDWstwXm4LuWGBQmVwS5jDCSy6xPBqEaGs9fdxioC8eclLrdZJz556r5zX3oGgC6pMoe5s0dI6scq16pymkmBXZx0s+68IyFPI1fGZewtTSmt9Csl2xe0scu+j2n1OWcj9PY02uscMm5sZKlcHiv/50A7BS8oRJwYmVO5gmudbaplJvZkBUR63dsXoOIEtOic00AMBvcnls9Z25fzg==
Received: from DU0PR03MB8934.eurprd03.prod.outlook.com (2603:10a6:10:473::15)
 by VI0PR03MB11043.eurprd03.prod.outlook.com (2603:10a6:800:2cf::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 12:00:17 +0000
Received: from DU0PR03MB8934.eurprd03.prod.outlook.com
 ([fe80::26fd:98f2:a1cc:be40]) by DU0PR03MB8934.eurprd03.prod.outlook.com
 ([fe80::26fd:98f2:a1cc:be40%7]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 12:00:17 +0000
From: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To: Torsten Duwe <duwe@lst.de>, Matthias Brugger <mbrugger@suse.com>, Simon
 Glass <sjg@chromium.org>
CC: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH 0/4] Improve RaspBerry Pi 5 support part1: Fixes
Thread-Topic: [PATCH 0/4] Improve RaspBerry Pi 5 support part1: Fixes
Thread-Index: AQHcOgD8HUzJwI/l802un+lqOr/ENrS//d4A
Date: Mon, 13 Oct 2025 12:00:17 +0000
Message-ID: <dad6decb-4383-4894-81ee-80ddba8ccb1b@epam.com>
References: <20251010161442.410C4227AAE@verein.lst.de>
In-Reply-To: <20251010161442.410C4227AAE@verein.lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epam.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR03MB8934:EE_|VI0PR03MB11043:EE_
x-ms-office365-filtering-correlation-id: e7d541c5-ee77-4652-967d-08de0a501361
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?SENXN2lqOEQ4cUUybTlUWXZpblhVWG5NRjlxc2d4Ym1BSXhTVWRTSitjMnNL?=
 =?utf-8?B?aG1CNVZFV0R5QXU1UnBuajdFZ01aTDdaVmlBcVpHS3k4VkxOYjdlZFo1d0I5?=
 =?utf-8?B?ek5yclpuNlZwWWdoR3JnSGFUWEpZL2RNUEw0QVBwQ2lUWnRGRXF4cmpCb3pB?=
 =?utf-8?B?NXRmSVhWeC9PcWJwUTgrd0QrTFFCTWxkVkh5QUlHeGcybW50SlJJUVA0Qjdo?=
 =?utf-8?B?YzNGOEUySWFBWlcvRVhhR09ycThBZlBJbVNVSGhtOEFVQlRpVXppZTA1N0k0?=
 =?utf-8?B?VVpGazVLSmg5dzByUEVQRitxQnNWa2oyc1JhYmNOS2dEZEhDUEkva0loMmJ0?=
 =?utf-8?B?L1UwR0xRelN0Y0JETTBwNDVTeFloRGtQU3kySTdTYy9SYVExU3NSNklWbG5H?=
 =?utf-8?B?OE5FaUE0bmI2cWMxT1JvbEhaa29WdWFBVXdxUnNIM2FuZE9uQTBpTE1OOTVF?=
 =?utf-8?B?RE9UU1d4akhlVWxueWJJRmRUNTNvdk5KQWU1NkNtRExYRjVmR1JvVU8vSlpR?=
 =?utf-8?B?N0NpZFRzZ3FxWWExUXBtU0YyMlVuNGcxZmJEVjFhNXZzNE0yRWhxVURKMUVh?=
 =?utf-8?B?MXRGQUUzR25yUWd3RXdhRmNTLzJqUnhkSVVua1JLdHh0S2xENXBKNytveEFx?=
 =?utf-8?B?Q3U3NjhybEJqeDdEb1RoNllSRDI3bXlRZDNJMFNhOEp2K0x5U1d2THhnM0M3?=
 =?utf-8?B?aGFTTHNPdjRsWFE0bXVZd29QbElvRWJqLzVXVjhUZ3p1Tm1wZFpkMU1zdG1a?=
 =?utf-8?B?SzNDOEJCNlNJTHZML3JPR1VYaUxCR1hiTnI4L29iUUFWaFBCRU9rakRsUTQx?=
 =?utf-8?B?NXlCSmhVdVpuWW1qa2UvK0VoWXEzejlGRjFlMkF6Q1FPZVcwd3BxUThlek1S?=
 =?utf-8?B?cmlzbzN0Mk91WE5EUmZlcERUdkgzbE96SUxsdGkrVFhYR21rdWlHWXc5bFBH?=
 =?utf-8?B?NGU5bWZ4YngvR2I4b21nUkRFQkJ4TnZFVHY3M0JLbjFLRHpHRXp3YndnWFNT?=
 =?utf-8?B?SjdZRzJhSEFyMURWcjdjUUc1OTBoaG1EUWZsMkg1VWtHL2JSclVBZDVyOUVZ?=
 =?utf-8?B?czE4cEpGWjlBbzYvakMvYmM3ZHdkVzFoZDNFa0xKTmpucnRsU3l0WDR6L3lz?=
 =?utf-8?B?TStVd0d2SStic1I5czRCWHJoR2JYWTZGYzFpUWhOWjBEMUg2SmlrRWl5b0ZQ?=
 =?utf-8?B?ZlJBQVNhd2ZZU3A3YXZjZUttbEw1dXNhaE9nMFpqb0ErY2ZLd3VoVlR4bUZl?=
 =?utf-8?B?VjJ5NytwaXF0V1gxaS9MK3Q5Z2M4RmRtTGZlRXFSdWdBSWJVTjlzYWUzMjlT?=
 =?utf-8?B?ME9kM1F5cnhlY00zT3orUjlLMWZWUWJRdUVUdnFVVGx0bGtxTndoRyt6dkwy?=
 =?utf-8?B?amFYUFc3UUVYVkNpdVNWNWFIZ1REUzJrQm5FNXN5cWxOdVVKenU2MzIvZmlu?=
 =?utf-8?B?elhsTnY2aGdlY0lqWm5WeitPNlN3Y1EwelA0WWNyTDliUU9PV2ZxdXNlVkpo?=
 =?utf-8?B?bnl0OUNTejJ2V0tDMTZjNjc5alVRSnMvSFBKdTZVMkN0RUxCWlNZL1JVUGxu?=
 =?utf-8?B?bENwQnlvUmxvWThiTkVlV1NMTzZRLytteCs1aGxrY09YbFd2clBJVEowWkMz?=
 =?utf-8?B?WFd6UTBYRDRuSFdDNy8zb1FFbHU1d3NEMDdUdDh2aDlpUmwvaTZWelFZUE03?=
 =?utf-8?B?S0tIM3lHS3FaaVBNcUZmK3puTk4raStqQjVGNUdXQ1hVWm0zRU0xTVhsN1VC?=
 =?utf-8?B?WERqSHd6ZnpMOUhRSW10bmJTaTY5SE40cHFQcU9JOEMrSWdLK1JhZTJubVZl?=
 =?utf-8?B?dDdOc0JnU1lucXFvUGVsaERDam9tM29sdytRTFQ4dlhwSU9HQkJCWW9Dd1V2?=
 =?utf-8?B?VlpUckpxYzRvTi9mMXJ0UXBFaDQrczh4Q0NUV3F4dkhWMlJlOGZYQUxHWkZs?=
 =?utf-8?B?WmI3cjR0cUFTc2MyUlFnREpiR3VzY1lpeXBCMWVUdHAydmpUbnJvUkR4QTVW?=
 =?utf-8?B?eDFFM3ZuOUNRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR03MB8934.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWJpS0dxaWgrRWcyaHVLQmFVWExtQU5IejdDTHoxKzNVdUJLTjNlQ2RCbXVa?=
 =?utf-8?B?WFUzQmRCVnhDUmNmTUlqdE1lUVM5UjI0TGo4K0NxN0hmTmwwYS8zN05xcUJs?=
 =?utf-8?B?ZU1zK2Y5cnM5MTVBQndRMkhRTk5MOE9FS1UwRmgxbit1QXhsWkRjYnN1WWtJ?=
 =?utf-8?B?NVprRUxMUEVERWJwcWQwK1pCQS8vUEVrS2h4ZVQxa0ZySSt4THpudlNWVkVE?=
 =?utf-8?B?SjFScjFvWk1lWGFJLy8zMW90Rmo2YW40NmlpTWhHclB2WkNHSVdmWWY3TmV0?=
 =?utf-8?B?MXpFM2VHUDRFdWY3cGJnSDVtREpYdDFmbmFXYWFHYkpzUEtiN2duYUdCYktL?=
 =?utf-8?B?TU9rRysyRmNSTXdHbTVrSENNVVNqUCsrZTNrd2YrUTdwSkpuMlo1eXBucEVO?=
 =?utf-8?B?MjIrT1BzL3hxM2tKaUg2Y05kajVYV3FhUWU1MXJNajN6QXFVbXd4UU0wMFBY?=
 =?utf-8?B?STFpUXFNT3AzTWxUajBMcUQybksvc0Y4NE0vRWNoWm5SRklDRjVpdWM5NUNh?=
 =?utf-8?B?OFd1a0hQTWhVazBUUlpaL1pvRlBFZXlwYWk3N2sxVVl3aFNYNFZ4d3kxRGFu?=
 =?utf-8?B?Y1JhaUVmdjZoRDAvQndSaTRhWS9zbU9sckNRalVXUlYzU3ZYU3BaQmlMWVFV?=
 =?utf-8?B?WlBIUXJYM1hla3U2am1kK0RqbFJPdGhJem5mRm9LSXg1RnpzN3FzYUd3cllZ?=
 =?utf-8?B?M0xkdmd3aStGK2IwUEo4Zk9vQmREdjVNL25ma0N5S2VUR3ArdFp0Y0RpVTBx?=
 =?utf-8?B?ZHJtRkREaWxxNkU3cU5jVzhDL1dBQ3dpWjE3dHZIUk40OEFEbWc5QWJJUXRm?=
 =?utf-8?B?cUdYWXRZVHVsajJxQTd1d2lhSHJtMzlSSTE3eHpvNUg5RkNybDhSOWVLY0J4?=
 =?utf-8?B?c3RnR2hjZ24rNmQ4L05IUHpEZVF4dEdoMWhOWXJlangyR3dpdlV2aWdzVG1t?=
 =?utf-8?B?bGRYeUxsVDNtSVlSdThiMFFLSGM4QjJRWjNEaXEyK0c0UWtZcVJmZ3Zrem4y?=
 =?utf-8?B?QkFKSUtQZFBXazBBYUo4MHV0VDR6a1VpdXc4OW4rN2ttS3JmTTYzclQwY0JO?=
 =?utf-8?B?dHFkdnJkWVM5V29DVGZWUTRMakVyUWNsTEdKT2tuUitzUVpNQXZDQzhKYms2?=
 =?utf-8?B?L1hHUzhtTjRFRDFkT3RSMU1hRlFEaHZ3RWNKR3Q1SUJxejBHcFlpZGdydGls?=
 =?utf-8?B?QVZXTVRZNExvUEIwVnFtT1NtOTNlUTRiSWE2ZXJMSE04b1Z6WXp3K0MvdUI4?=
 =?utf-8?B?aVR6cld3YjY0K0wrVG9rdndMdnhQWGFGSlNzbnZzQThwMUN2ZCsxUEJydHV6?=
 =?utf-8?B?SWdNRnc1bkhobUtsWTZ4U214eG13VlVVYzVlaEx3aGYzWHpoQzlnNmgwMXlB?=
 =?utf-8?B?WVduaHNtc0Y3WndzNUtXN0FQNS9KdzRiM0I0R0lWQUNnL3VzeTVCMWJQYU1o?=
 =?utf-8?B?QlFVSlh6MGpTa1R4anEzVmxRUHoxTGUvZEZHR29zSHNNUHZFV2wxanh2MWd0?=
 =?utf-8?B?dThaZEppeXIyM3NIajFrMVVRbW03a3M2enhraWtlaHVSRG9IMGxxZEQyK1hD?=
 =?utf-8?B?aWJQMEJsK1QxaWg0Tllpd0NTbFRmTDFjY1Y0TStGR1NGR0lBTG9aS1hmaWdq?=
 =?utf-8?B?bENPcDZDV2RmZWdpQXc2dG9sVUxPUFFoZDVjaUtjQnVwNzA5dDcxa0p2aU5k?=
 =?utf-8?B?Qlk0QURTNGdkY2xtUm9qSlFtUGFQSW5RQ3NxK1hCcXRHb2cyNGlsMWhzenpv?=
 =?utf-8?B?cnVxRUFSR2tiRjlQYnZsOEFKeXJPelpFK2w5eGFsa21FWFU4RWVvRE0zSm9J?=
 =?utf-8?B?YnlndFhIU3I3MGR4WkRibHNEVzlUOFpjaTFjVzVubjJnSm9vaEhJdVhUbTdF?=
 =?utf-8?B?NGpKV3JsMGlQUWFTL3c3a1BzOHlCRHVjOWVXeEQrYytNcThjemQwVGp1OVlD?=
 =?utf-8?B?T1VCa1ZRcjA0M2ZMbTk3VU14N2xJMUoyR2dQNEFhZ3RJNTFWSk1sYlNmV0RD?=
 =?utf-8?B?WW91L2N6dkNFbE43ejRZNWV5dC9RSzZCOTZIWHA5bTZlSCs3cm9DOU9mdm9n?=
 =?utf-8?B?K3FwSEphQ2lteEc1ZlFNbnN2UFo0eTZ5YWFrR1JOSXNBbDVwVFVUK1U1WXpR?=
 =?utf-8?B?c1lBenVsV1ZSa1pkZm5HN2tYdDlTZjFsSWpHbWF4UDR4OTRRT1NuME1UL01Q?=
 =?utf-8?B?YXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <94FEE51B125EC84CB2061A6504190BBB@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR03MB8934.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d541c5-ee77-4652-967d-08de0a501361
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 12:00:17.1553 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S4QaziiBXUJMkWIHCqget+eXcrpe9IYUJM88tTP/jO73bcdpDcGfUH2uyXjweFf9yqZGJ+zSW7cNxhLKVJfHiRNaebzQkfAEuy8t75yAV1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR03MB11043
X-Mailman-Approved-At: Mon, 13 Oct 2025 17:40:45 +0200
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

SGkgVG9yc3RlbiwNCg0KRmlyc3Qgb2YgYWxsLCBJIHdvdWxkIGxpa2UgdG8gdGhhbmsgeW91IGZv
ciBwaWNraW5nIHRoaXMgdXAuIEknbSByZWFsbHkgDQpwbGVhc2VkIHRvIHNlZQ0KY29tbXVuaXR5
IGludGVyZXN0IGluIHRoZXNlIGZlYXR1cmVzLg0KDQpBZnRlciBhIGJyaWVmIGxvb2ssIHlvdXIg
Y2hhbmdlcyBsb29rIGdvb2QgdG8gbWUsIGFuZCBJJ2xsIGJlIGFibGUgdG8gcmV2aWV3DQp0aGVt
IG1vcmUgYXR0ZW50aXZlbHkgdG9kYXkgb3IgdG9tb3Jyb3cuDQpJIGxvb2sgZm9yd2FyZCB0byB5
b3VyIGZvbGxvd2luZyBwYXRjaCBzZXJpZXMuDQoNCkFkZGl0aW9uYWxseSwgd2hlbiB5b3Ugd29y
ayBvbiB0aGUgTUFDQiBkcml2ZXIsIHBsZWFzZSB0YWtlIGEgbG9vayBhdCANCnRoZSBmb2xsb3dp
bmcgY29tbWVudDoNCmh0dHBzOi8vZ2l0aHViLmNvbS94ZW4tdHJvb3BzL21ldGEteHQtcHJvZC1k
ZXZlbC1ycGk1L2lzc3Vlcy81MCNpc3N1ZWNvbW1lbnQtMjkyNzc0MTAxMQ0KDQpJdCBzdWdnZXN0
cyBlZGl0aW5nIHRoZSBCQ00yNzEyX1JQSV81X0JfTkVXIHJlZmVyZW5jZSBpbiBtYWNiLmMuDQoN
CkJlc3QgcmVnYXJkcywNCk9sZWtzaWkuDQoNCk9uIDEwLzEwLzIwMjUgMTk6MTQsIFRvcnN0ZW4g
RHV3ZSB3cm90ZToNCj4gW1lvdSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSBkdXdlQGxzdC5k
ZS4gTGVhcm4gd2h5IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJv
dXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+DQo+IEhpIGFsbCwNCj4NCj4gVGhpcyBzZXJpZXMg
aXMgYmFzaWNhbGx5IGEgcmVzZW5kIG9mIE9sZWtzaWkgTW9pc2llaWV2J3MgZnJvbSBGZWJydWFy
eVswXS4NCj4gSSBmb3J3YXJkLXBvcnRlZCB0aGUgY29kZSB3aGVyZSBuZWNjZXNzYXJ5LCByZXBo
cmFzZWQgc29tZSBleHBsYW5hdGlvbnMsDQo+IHJldGVzdGVkIGFuZCByZXNodWZmbGVkIHRoZSBj
aGFuZ2VzLCBncm91cGluZyB0aGVtIGludG8gYXQgbGVhc3QgMyBwYXJ0czoNCj4NCj4gICAgICAg
MTogRml4ZXMNCj4gICAgICAgMjogUENJZSBzdXBwb3J0IGZvciB0aGUgYmNtMjcxMg0KPiAgICAg
ICAzOiBSUDEgY2hpcCBhbmQgTUFDQiBldGhlcm5ldCBzdXBwb3J0DQo+DQo+IEhhdmVuJ3QgdHJp
ZWQgVVNCIHlldCwgYnV0IHdpdGggdGhlIGZ1bGwgc2VyaWVzIE5WTWUgYm9vdCBpcyB3b3JraW5n
LA0KPiBhbmQgSSBnZXQgYSAiZmlsZSBub3QgZm91bmQiIGZyb20gbXkgREhDUC9URlRQIHNlcnZl
ci4NCj4NCj4gTGV0J3Mgc3RhcnQgd2l0aCB0aGUgZml4ZXMsIHRoZXkgc2hvdWxkIGJlIHVuZGlz
cHV0YWJsZS4gQ3JlZGl0cyBnbw0KPiB0byB0aGUgZXBhbSBndXlzIGZvciB0cmFja2luZyB0aGVz
ZSBkb3duLiBQYXRjaGVzIHNob3VsZCBhcHBseSBjbGVhbmx5DQo+IG9uIDIwMjUuMTAgYW5kIG9u
IGN1cnJlbnQgbWFzdGVyIFtlY2RjMzg3MmE3NjddLg0KPg0KPiAgICAgICAgICBUb3JzdGVuDQo+
DQo+IFswXSBodHRwczovL2xpc3RzLmRlbnguZGUvcGlwZXJtYWlsL3UtYm9vdC8yMDI1LUZlYnJ1
YXJ5LzU3OTU0MC5odG1sDQo=
