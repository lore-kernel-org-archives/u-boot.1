Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F3EAC54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 07:36:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BDDC87E93;
	Wed, 20 Mar 2024 08:36:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="DPKm8Ztn";
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="JKTrKx1M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EDF587E93; Wed, 20 Mar 2024 08:36:09 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 991D187E6D
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 08:36:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Mihai.Sain@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1710920167; x=1742456167;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xSl+GbUfQKibSioRB/CtPvGCcW9M8PeJ3pdIcxfMfBM=;
 b=DPKm8ZtnvrjdTQRPWJ5/jQrTOsKTaKL9iICr+gH+iQPP9XoGRM3no0/f
 fiWbJv5/zcv6qFxXbzXOrigqqrbhtlhQlfOzaHIFChg1VEwj1t5zF671v
 Ep26pA1VOSYLUwg3QdOrRcJTe3jhfyaTurW6tytVysHiR1uo3AntCErf4
 /SPM7oyKPjSB3BSJQbeLXiDqNxpTLJcnXXcT5fzay15J+q4D6dXKsrHit
 suHmK2gA31fQCzpKAMt+1zhFV4xtJ46asXwmoFRKGFp/WBllBcIRH3n/G
 eFlBfM6YpLJOjRaQGd5tjVtFcnwuF9dHA3s+pbMcm0+oFNzymeSI7eNcx g==;
X-CSE-ConnectionGUID: GmVA/gOwRQKwxOf1FSz+aQ==
X-CSE-MsgGUID: NUyZLhS8RK6NQi2QsRYwkg==
X-IronPort-AV: E=Sophos;i="6.07,139,1708412400"; d="scan'208";a="248657738"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 20 Mar 2024 00:36:06 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 00:35:38 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Mar 2024 00:35:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bExu999HhFLY+vNMQ3cb1nnDYTcAGhV0x5PI8AZ0s/9MT9Ma3r9afa1iyoHmoLSvb4C/1YNL+Q7AESlzmqu4Dqfd10MMo4rlLu17b42p/sAiGlYQdYpvEchHzv+3fnLZ0ceNcwDCwB/guzZQC18OiakQAXiaiY+mmL5XtWKtkHuanf3g9Uc92CT3hIQY2RRcaVeADF1nT8xyKZL7OszB4cSI8xGEyhS6kYyrbQjxFsGD2a9S5nBta1dNfk8xBWoGVk4vcjj7YKvwn4XPfDABpSJ8AbLJwqoIt+t54xi7HPRHuZCI4XwCmee7LZdWbYvk2nXWeMjDbuJ5eINdtnrgGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSl+GbUfQKibSioRB/CtPvGCcW9M8PeJ3pdIcxfMfBM=;
 b=LSS8puwxlVYakuLNcaynyJteNC41U9Z1ST13CtQSqihRIXkMbN40KIZikpEkZSLSfjIfx5oEP/wxgaA2S3/L5zUeUw92EcszemUTnklezjlSLyaTlCM8lsH8ooPWj5junWl+c0oPGBT7WuWoGOYVh9Bwv2LNvVohy3sWpU6Kg2yMYiweuGw3UX0ZHNnyMEgz5j7tp/m3Up50FGJ/HhSEidLhRqoNPLix2yww2P7II44jbJW6PRYHxGd58wj5LXknbiL1aculYF6UrCUKxQ1uk5nIuXA/FJyYQf9wHU8F3m7v3VIX/8++kEf1/Gm9nTdReZYsARNxCkdnsY3r4xoNQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSl+GbUfQKibSioRB/CtPvGCcW9M8PeJ3pdIcxfMfBM=;
 b=JKTrKx1MkPv/854VqO05F+8dP6rNUKqY4IbsTt2dxPnwTjumAM8vvo/qT6WEjM8WRnY2a+gdfc6QtO9yRVWYpWKUtHhUznrEOSaL1N9ODFk/bkg4rG04PZw/CtySOh6EVh9CHfr42W5q9ef3RxLSdUlWHAH+pBFnaO7mBGElilH22cx6X5MX8oCWsLN0FjWfh+vtC4kgKM/MMsHxeIEIEqdpQvADfDqcB0mDL42SlCCVURda95WOIykycmNaX4EE9xYda4iJbN5qvVmG7OWeS+TYz4EQyhVXpBb6CyekGeC2WicRLc7V5q+520mwV0rJKuUZ//v+TmuhBbhYRf8zjA==
Received: from PH8PR11MB6804.namprd11.prod.outlook.com (2603:10b6:510:1bc::6)
 by CY8PR11MB7058.namprd11.prod.outlook.com (2603:10b6:930:52::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12; Wed, 20 Mar
 2024 07:35:36 +0000
Received: from PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::8724:4f0d:7186:266c]) by PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::8724:4f0d:7186:266c%6]) with mapi id 15.20.7409.010; Wed, 20 Mar 2024
 07:35:36 +0000
From: <Mihai.Sain@microchip.com>
To: <ada@thorsis.com>
CC: <eugen.hristev@collabora.com>, <Balamanikandan.Gunasundar@microchip.com>, 
 <michael@amarulasolutions.com>, <u-boot@lists.denx.de>,
 <dario.binacchi@amarulasolutions.com>
Subject: RE: [PATCH 4/4] mtd: nand: raw: atmel: Introduce optional debug
 commands
Thread-Topic: [PATCH 4/4] mtd: nand: raw: atmel: Introduce optional debug
 commands
Thread-Index: AQHacHYz5NjLBjcwWUSp31aMRMD+07E9M2MAgAAHzoCAAAQkoIAAHZ4AgAALSwCAAZwMAIABSxMw
Date: Wed, 20 Mar 2024 07:35:36 +0000
Message-ID: <PH8PR11MB680413463F35EE9AABC6CF0182332@PH8PR11MB6804.namprd11.prod.outlook.com>
References: <20240307091014.39796-1-ada@thorsis.com>
 <20240307091014.39796-5-ada@thorsis.com>
 <82a5ea3c-ab95-4460-9685-2676fe18d6b5@collabora.com>
 <PH8PR11MB6804301C3B361D21EADCEE71822D2@PH8PR11MB6804.namprd11.prod.outlook.com>
 <00241bf0-2543-4836-b43f-1b6452caf2e6@collabora.com>
 <PH8PR11MB68048E53C58FAAE710FE51F3822D2@PH8PR11MB6804.namprd11.prod.outlook.com>
 <20240318-renewal-properly-6edd58ed9c79@thorsis.com>
 <PH8PR11MB68040409774B3441A8657DA1822D2@PH8PR11MB6804.namprd11.prod.outlook.com>
 <20240319-transpose-enjoyably-6f0a11f36382@thorsis.com>
In-Reply-To: <20240319-transpose-enjoyably-6f0a11f36382@thorsis.com>
Accept-Language: en-GB, en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6804:EE_|CY8PR11MB7058:EE_
x-ms-office365-filtering-correlation-id: d2d1780b-e978-4c1e-d6c2-08dc48b0559c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d2poyUhknfT4lzYvQz1pPbrokkMW/PHxiEG9i+S07YvhFIGlfpOljLSduh+4mi0NJqxIYyJ2TgJA0VTSrK2MKlvLqp3hnKJPwAWs1nwW8OnIFMM3B0jAf4MYFKMTvkcQ8mgRmYHQ7hwclgVQ/1v2ILTZX+0frh1q7eJ3Jt//ZOA28/+SB/P5kSxTxzCyUDrNP18NgUSLtJw5S27TF3EmG3Q484c+fVGuHWB6w6A4ac3KdPg8YoDMuWia7eBQURKvV89BUgCYJ8uGj0Gkh3hBDV9UIdQJwiM44l6DxooZDgxDgvGRHAsYH8xdlKEB6DmZ4hJP4A9BBQdtSnC1BE++DqqnFT3MMpHvbhvIWrArvGUx4RkxUmKRZtJ/niJgDO06c+i0/k4Xbc6twO/3d+siLnBwXRgzM2P0WfmfAGyN8QF6w/ZZsrdviDs9ihkhtW8C5//IFHv0zxPflgAP5WeTinaH1KRtyH+iRnIf/E2zyGJDwmherNmEUcl7trxpLDquYPKk+TtXtRD3qs34zYzxgVF1Zgii471ddpLS+JMMbhfcDeUkYL1WaL0xYQgsgJB86Ruvdby/aSCiLrz7jefabxs5p7NBqnE1LzhUi3D/Az7XDyUoIZUA5bVa/5m3J/Vauiwh/9Km4z19X+kxKuKJwey9wACoEQCQq5kmaeyM4FM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6804.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGJiNUN2d1QwbEtodlRvcHNHdlNGY3FTdUd2TkRYOUVYTHVMSEdOV0NBTkZX?=
 =?utf-8?B?WTcrUURaWUJCcy9UWUlJeVVnNlFUUjE1Q2JQc2dkaDkyL0N0dHQ4YmJNSjJj?=
 =?utf-8?B?THE3Q1VrMGxXY1UwUWFkdHE4aCtzdGU5ZzJNS1JRd1RoaGxHbnlyckh4T2hk?=
 =?utf-8?B?cEtVYXVNZUo0OGF4c3lXUGhGMzBjSVZmU1J2YS8vSXc3eE5nMFI4eGVlUUpY?=
 =?utf-8?B?L3BOSnRZeFNjY1crMjREd1Y4R0tvTkZKSVcyK3lOYWRiQ1JUUDdJdFhPWlp4?=
 =?utf-8?B?bU1qSmZMMTJidnhyVUFtbUZUN1lwQWx0dlJQSGdPdGE1aXpyREpFMzcvNFFN?=
 =?utf-8?B?RXgwZHdXamp6czU2WVF6b3NER0JTaW1zVCtaMlNlYWtmb21mekx1cVRWVSsy?=
 =?utf-8?B?Q2VMK3RCSUNqUUkzU3dhdzgyOWo2NjJmejNlOThITlc2S0JaV2NiNXcwN2dY?=
 =?utf-8?B?WGx1ampJMUpqbXB5RldaRnVPL2JtRE1ZU1RxUUsxbWtVSnlWMDlZekoyM1Uv?=
 =?utf-8?B?eFdwN1lRbHk0b1dWSVJ1UmNIcEFGNjhnRk5zei9sVTNWWCtCNjRlU05yUjBE?=
 =?utf-8?B?b085MGJRcUxUV1VYQVNBeDlqa3l2QWUrTEIzYnVIOUNVWEFNMGYvQXdxRVhX?=
 =?utf-8?B?djVzcTR3UVFuNml4Q0Fab3B4RlIzd3JCY1dUdDhlWE1oMHVMczVpbkdFelhU?=
 =?utf-8?B?MFlwUWhwalhyLzlndGJqazZkY2dGSmhEcHNwemlBaklTa0l2MUdQVkl0citD?=
 =?utf-8?B?RGFOM1d5d3F6VlpQTkoyYW9pQWZ6TTA0UHExN3dGNTJLK3FsMmg3TkZTczZ6?=
 =?utf-8?B?WDVPZGpFQW9SMlV5azdXU2RqUk5QVzNicERIMzQ2dVh4U0RkYWdkN20rb0ZD?=
 =?utf-8?B?aVAxdHZWeTRrTncvWXV5K3AvalVZeVMzeU0wbmVzVTRUQ3dsVGZJc2pkM2No?=
 =?utf-8?B?WTJmcnhaTDJXN3hGdlVNVGhnZk5lV0tpeXA1d1FsR2Mrc1JNd3U4U01UM0l3?=
 =?utf-8?B?OWFxM1JiMW9GMmpjZTkyR1FoOTR5aEdJZStZbURoazA0aldKWHkrRVc2aTBo?=
 =?utf-8?B?ekRWV1BUdksza0RvK1E2UkdxYUtDcE02WklpTXhIczRnWU01ZzgxaHRRTVNW?=
 =?utf-8?B?S2t6bWh1R0FIZGkrVzkxMXh0N056eHRuZ2FiRG5ubTM0bEF5YWdCbXRRQXFY?=
 =?utf-8?B?aEF3dmdaQlRESmxueFlaMXViT3J0aGhxUkVqOWp0ZDcyTFFMNGxDM3FhN2Fy?=
 =?utf-8?B?N0VTRy82S2tyT0JkVm9ra3ZOQ0p3bW9nOHkvbUJZZFBGeEFDWFJtemU1YkRz?=
 =?utf-8?B?L0l6SlJhYUJKY1RBeUZPQ1IzdURDYVpTMGE2SjVWMW41elFBb3NqY3UzTzBN?=
 =?utf-8?B?UUNsREx3UTlUU21nOVRsTWV2QzRPZUkvU0xrblVyV3pLS2gyQnpUS1N1UEdO?=
 =?utf-8?B?YU9oNlR5cnhSRWNldzBhVHZScjdrSklwWmY4dHFmdVRIcTI2TDZwQ0ErNTRm?=
 =?utf-8?B?Wk1aVWpmSzQwT1FucTRjcW5kNHlJWnY2N3hYTUdRMWVTNGcvQnl0N1gzYzYy?=
 =?utf-8?B?eHVwU3BYNi9iNkFuWTBVVE1mM0dKU0owYlVHM0pJTkpkdjk4QnRRVjJiN3BJ?=
 =?utf-8?B?b09RQ1RKWWZ1Q2ZBS1BsSVljMWdyNlQrSUF4RUp0ZjdZQXdxaVFhaUhQYUZi?=
 =?utf-8?B?aUJnQzdDdDhUTmJDdCtyMlgzYm4zRm1FN25wMFgxemxLN3lNVGp0c3FOU21t?=
 =?utf-8?B?K0VhS1lpTVJ2T2VVbVc0M3Evc2ptY2w3VmxmVGZqdmJCb2EyZ3oxOFRvek55?=
 =?utf-8?B?dEk0OXI3M09ramdkN0w5UitaWHpzWUR3a3VBSjFVa2pnYWJlNFlSbEJIU3Fw?=
 =?utf-8?B?VGRNRWFhUytNRVQvekp6bG1XQlJHUFJyQmhPbDlYcW1Ta0pXTTFHZFU5SThW?=
 =?utf-8?B?N2RvN2Z3SmM3aDlwc2ZFYlpSS0FUSnFtclg3M3NnTVpGZVZPRmZJZ2U1RGZX?=
 =?utf-8?B?UFlmMkpiU0U5TDVRUXNvQWJ4UkhqUVdpL2tJMk4xZmNXVHR6ZE5IUlQxdTRX?=
 =?utf-8?B?aVA1ZE5PTUl4bzJadWZmc1pWb0tBcjhiMjFva01rT2Y0b3lvY2FVTkJYekpI?=
 =?utf-8?Q?mfYI81CHcVoly9YGRESvdwqo9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6804.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d1780b-e978-4c1e-d6c2-08dc48b0559c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 07:35:36.7247 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4UIs9Qvk+SkE9xvIjgRwdqhIdehddGP1T5CTfM7Yq0EovueWFiXH2Sohur//wok+6eO+56VzWW6U0MrM5FD6dTpE3c2nF/ptGTKQPgKyShs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7058
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

SGkgQWxleCwNCg0KPiA+IEFsc28gSSByZWNvbW1lbmQgdG8gcHJpbnQgdGhlIG1hc3RlciBjbG9j
ayBpbiBNSHosIGFuZCB0byBwcmludCB0aGUgbWFzdGVyIGNsb2NrIG5hbWUvbGFiZWwgZnJvbSBj
Y2YgZHJpdmVyOg0KPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS91LWJvb3QvdS1ib290L2Jsb2IvbWFz
dGVyL2RyaXZlcnMvY2xrL2F0OTEvc2FtYTdnNS4NCj4gPiBjI0w0MTANCj4NCj4gU2hvdWxkIGJl
IHBvc3NpYmxlLiAgSSBjb3VsZCBkbyB0aGlzIGFuZCBzZW5kIGEgdjI/DQo+DQo+ICAgICAgIFll
cyBQbGVhc2Ug8J+Yig0KPiAgICAgICBBbHNvIHBsZWFzZSBub3RlIHRoYXQgb2xkZXIgU0FNOS9T
QU1BNSBzZXJpZXMgaGF2ZSBubyBjY2YgZHJpdmVycyDimLkNCj4gICAgICAgT25seSBTQU05WDYr
IGFuZCBTQU1BNyBzZXJpZXMgaGF2ZSBjY2Yg8J+Yig0KDQpPa2F5IEkgdGhvdWdodCB0aGlzIHdv
dWxkIGJlIGVhc3ksIGJ1dCBpdCBzZWVtcyBub3QuICBUaGlzIGlzIHdoYXQgSSBjYW1lIHVwIHdp
dGg6DQoNCi0gICAgICAgICAgICAgICAgcHJpbnRmKCJtY2sgY2xvY2sgcmF0ZTogJWx1XG4iLCBj
bGtfZ2V0X3JhdGUobmMtPm1jaykpOw0KKyAgICAgICAgICAgICAgICBwcmludGYoIiVzIHJhdGU6
ICVsdSBNSHpcbiIsDQorICAgICAgICAgICAgICAgICAgICAgICBuYy0+bWNrLT5kZXYtPm5hbWUg
PyBuYy0+bWNrLT5kZXYtPm5hbWUgOiAibWNrIGNsb2NrIiwNCisgICAgICAgICAgICAgICAgICAg
ICAgIGNsa19nZXRfcmF0ZShuYy0+bWNrKSAvIDEwMDAwMDApOw0KDQpBbmQgdGhpcyBpcyB0aGUg
b3V0cHV0IG9uIHNhbTl4NjAgd2l0aCBDT05GSUdfQ0xLX0NDRiBlbmFibGVkOg0KDQogICAgcG1j
QGZmZmZmYzAwIHJhdGU6IDIwMCBNSHoNCg0KVGhlIGNvcnJlc3BvbmRpbmcgbGluZSBmcm9tIGBj
bGsgZHVtcGAgaXM6DQoNCiAgICAgMjAwMDAwMDAwICAgICAgICAgICAgNSAgICAgICAgfCAgICAg
ICB8ICAgICAgICAgICB8ICAgYC0tIG1ja19kaXYNCg0KVGhhdCBuYW1lLCBJIGRvbid0IGdldCBp
dCB3aGVyZSB0byBnZXQgdGhhdCBvbmUuDQoNCglZb3UgY2FuIHJldmVydCB0byBpbml0aWFsIHBy
aW50IGFuZCBhZGQgTUh6IPCfmIoNCglNQ0sgcmF0ZTogMjAwIE1Ieg0KCVRoYW5rcy4NCg0K
