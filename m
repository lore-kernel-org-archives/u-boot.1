Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F34D6D116F1
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 11:05:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A6F283AA4;
	Mon,  1 Dec 2025 12:05:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mvSKJIpG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA7D083BD2; Mon,  1 Dec 2025 12:05:11 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69F8283942
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 12:05:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h/39vb/euirkFIZpsnbg3ax7GV42/Sp3j8TYd1xFFQa8re9dnK3YebAao5frdXFeLlpRpzjtGag5783HlLeo4oXDuyuXrx/Hn0sL/8SHTx7JXN7QBCO/6ovnG/4T/jo3a40h2ik+aebWNDBRzOqEF82Y4Uvih2z1DmqBwIoRRIi6yElwqrkDoJHFN0MoaSenZBa3/MwZUbPZjWJWyquvoutpHio9MOcE/58GCmVO5kohC3yetF7d3/tdg7OqGT20oXWwVbMxrriUbZ9Qem25eFqMb0c2JxzfOPskPThZSjN8XG1xroirI8sK0YyepaXoBC4zGpI20WvLaYsp36Xbew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfiJFd83aF2ouvM1NLa+TO8pWgdjJZDHXmuBlfDWVsM=;
 b=WiOqfAM7KAUkiFApYn5kScWAmuUKOgsvmVfUH1jEMaXjNZdV7Q0CAvbdDr4J+7VzeH6U3GZiHRIngJNcuK3uMrZQyKPjLQTqVi78+j6gSvGQZ7IIqumh78fOTVLlSknPlD0IjEL3ouNAZh0tYV3OCQtppzwFJTQQmAa8343bFvwG44WBHZA4F1JGxW8gWKfQsKOkZ9gRT61yc8M4UTcvd6VYCnYTrJb2fyXsV7IP+iNfhsoM0HniDU3RVbWzJ5Ahg1K262hz0Ydc0QixhuOxm7YXgXHtnkATG7jQteP8IYn0U7QMCSowKj179eV5Dq0PNPaJ/9u1ulVoc9S7NvMkuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfiJFd83aF2ouvM1NLa+TO8pWgdjJZDHXmuBlfDWVsM=;
 b=mvSKJIpG4UyBpyKi2Y7YqamU9yEHSVXNQEsSqPR+B+CVQUFkiY6pyTVEGV7sgYdxxLg7+9jPHlZ+EZ1kCHKWJVlklZAC+K5OcsDsGM3t/4lfWws1RiljKlmO2eiXvrLuTJhfolg4K0UjJX9xhwDoUOXqHt7S1ceSTfrJp4b98DZ+LT9hjYwZS7gL98dM/3uZiEPga7ZAOlMR42EEiKhdONkB6yc0/PVJO/vQmGoXj2Xjul0BYnzmtpabXwYpEBUk88hpHABN/LyQ01ad8e1n+0Ohn+pMVR3BbAfOzH+cgkCHI+z7u0N3+eLvwBSwPTP+veDl/kOVtkKKl4J66LfEFQ==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DB8PR04MB6970.eurprd04.prod.outlook.com (2603:10a6:10:fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 11:05:05 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 11:05:05 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, dl-uboot-imx
 <uboot-imx@nxp.com>, Marek Vasut <marex@denx.de>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>, Ye Li
 <ye.li@nxp.com>, "tharvey@gateworks.com" <tharvey@gateworks.com>, Mattijs
 Korpershoek <mkorpershoek@kernel.org>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Stefano Babic <sbabic@nabladev.com>, Peng Fan
 <peng.fan@nxp.com>, Lukasz Majewski <lukma@denx.de>, Simon Glass
 <sjg@chromium.org>, David Zang <davidzangcs@gmail.com>, Alice Guo
 <alice.guo@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjEgNC80XSBpbXg4dWxwOiBkc3Q6IEVuYWJsZSBV?=
 =?utf-8?Q?SB_controller_at_0x29920000_in_host_mode?=
Thread-Topic: [PATCH v1 4/4] imx8ulp: dst: Enable USB controller at 0x29920000
 in host mode
Thread-Index: AQHcYrJYFWjKIGzyfUGR4Xxfl6TFzQ==
Date: Mon, 1 Dec 2025 11:05:05 +0000
Message-ID: <PAXPR04MB96447CF4C79D53663C3F298FE2DBA@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20251128-usb2-v1-0-25ec5ac127ff@nxp.com>
 <20251128-usb2-v1-4-25ec5ac127ff@nxp.com>
 <CAOMZO5DisnpWRxfzwp0F7VOMPBLb+nmYE5vdCHADCe5VbP3Ejw@mail.gmail.com>
In-Reply-To: <CAOMZO5DisnpWRxfzwp0F7VOMPBLb+nmYE5vdCHADCe5VbP3Ejw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|DB8PR04MB6970:EE_
x-ms-office365-filtering-correlation-id: d6b3a7ff-807f-442a-6474-08de30c97b8d
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|7416014|376014|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?dzhEVHZzaHpOU1RvcDBTUStYSDRvNlViU0UvdEd6QVFMRGRHNyt6ZXdPMDNz?=
 =?utf-8?B?bVNtcVJxd2twK1hnT1lLQ3pvQ2hWcmJ4aEtpK3dEYWJlK3pCeXp0SkQyZXdj?=
 =?utf-8?B?N0R0anJSOXVKbmt3SCtyVCtRMkllNlh6S0RBb3F0UTVHems4S09yZXM2clQz?=
 =?utf-8?B?eENLQXZseHFDakFDbnUvMWY5N0VRbURrVWtTVGM2UUdQU2dSd3V3NEZGT2ho?=
 =?utf-8?B?NHg3TThjWm1wSFZKRG1TWStLcG9NNm0vMzVxVFY1ZHZ6UWZXcGJUZjFEUTJk?=
 =?utf-8?B?b05GRTJvWENxZjlSZHVNQ2YzVFhzRURCVFpBMHEvai81dkJJbEMvNXFVOGFp?=
 =?utf-8?B?RTl0SERSRndIaTFLa0xUcW1FaHg2TnVUODVOWUlMbmZxVUtzNklyc1FDQk43?=
 =?utf-8?B?Y2UvbWFKZEhOZEVMQi81ckUyb1dSSkFaaStEQndxY2FBNXhqREtkRzZoKzAw?=
 =?utf-8?B?RnJBWHJYVUNib0QydXIyMm9YaEQvYzJzVzRkU0NySXJ0QmJNek1QSnNBaDVK?=
 =?utf-8?B?MnVGelg0YUUxeEQxdWlHd3MrTGs1akpJK1I2Rzl2a1ZtL1NzRkhlbkEvSWZl?=
 =?utf-8?B?WDR2VURWTFd4R3VIRWZ4NzQvK2RERUNZT1BvS1JLSEtrd2lLMTVCZEl4dVdm?=
 =?utf-8?B?UkEwYUE2RlV2NkJNTjBaUksyMkgxRU9tbFlyRG16VlFBL3NxTVc4eEJDUXEz?=
 =?utf-8?B?c0dKZ01WbDNRV0JCYjdIOWpTMTV4N1FjbHFDR1NHaUxwZ1d3NG9ILzRrU1Fq?=
 =?utf-8?B?Vm55THZxZ1lMZFJjZlQxZkhhYitPODdrMjFmTDFCRUMrYU9pWDZMUFg4TTRX?=
 =?utf-8?B?aklNQlFadW5OMTBPemNqUHgwMzUzNXVDUmlERmVzTUlnMHFvM3NuRnFkRGxQ?=
 =?utf-8?B?L3pBbERYYkptRDl2YWNySWNpWmY2bS9uTW90SGFTSHA0cEZTRVN2YXl5WHVF?=
 =?utf-8?B?TFVQdUxmeU45ZFhWQ1ZWMVBBNkUvaTF5Skk3QlVWN2V3SkRGaVdzOUMwZTc5?=
 =?utf-8?B?L3QvOHJMdTZZYmdQUG41VUhVT3Nud1FUM0x2dEM0Ui9MRjFHdnVyVnVnbHZu?=
 =?utf-8?B?VVB5L0FXZDhCNE1xa2dzTVJmVVdMZXlrUHdpU2hNSmRvU3IyYStjZ1l1SmNW?=
 =?utf-8?B?YURGMWhNb2NOUU5JK0tIa1EycG14WWI5YmxVSllpdEhwM3JuUy8rWTBNdzlj?=
 =?utf-8?B?V0VvOVRlaEt3N3dqQXBhcmJFWm1DUTBIYklVcjMrYjY1TkdmTjc1RzNkUjlY?=
 =?utf-8?B?bUswSE9XbmgwWmRWSUFxUEZTRjlwTXB3QWMyOTM4T3p1dXlXTU1acktGbXgv?=
 =?utf-8?B?STA4NUp6RUM3b0V6UEtvbVVNbHNiQVdqdTN2L3VnTXR6WVBBdWNMcHNYNDdG?=
 =?utf-8?B?b0k4cUUxTjhpeFhkZHNueDErR3dVOTFYVWZjY25zVmJqQWV4Q0lQNUVGdnFn?=
 =?utf-8?B?dXhSdnNGL1VOMExYaklDcFVuRmF5NDRDWU9aVFdNSGt0bWhlZytObXFObng3?=
 =?utf-8?B?bGZVdGJXbGU4UTVkcUhLMFZnd3luTForSjcwYzBzMG5ITzlPUE1UVDJlTHRp?=
 =?utf-8?B?NFBzbEpvL0NHNklVSHJXQnlTVElsZDRuNmt1alhHSXU3N2xJK05WSVlMYkU4?=
 =?utf-8?B?MnlXSUszZmM2QWtkVmlJdktPTDlha3pGUGVjWk5NV2R0cUhDeXVzczRWQ2NY?=
 =?utf-8?B?Mkx3YzJDcVozcGx3UE9TUmlMNHNBNlppeWxTTFRraUt2eWNSK2NUR0ZETUpI?=
 =?utf-8?B?S0xWRTFOZWJveEpZcUI4elZEc0JaeEJGbS9NVXhyQVplMy9wYk5QcG5EZkFq?=
 =?utf-8?B?aVg5dlkzVHh2OGNjaGl5M1hoOUV4aGlmYjFSR3pWZU11Z2tlVzZnYnkybHg4?=
 =?utf-8?B?UkwrRTVvNGE5SVdXQzArMTFTZ2FCZFpHalBWdVFKc2xaWGJGdFBHRmduY3Mr?=
 =?utf-8?B?RGtOendXNjNoSlMvR0R2a2N1SUliK0hranpKQit5VTlOY00xRWIxaWxDTjl5?=
 =?utf-8?B?eGozVFRWOHBnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(7416014)(376014)(366016)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UzU1d3lndHg0TERTRzZjSXFpTURVdW5qU04xYU9jT2x6M3RwUnpGOXlxYk82?=
 =?utf-8?B?VGpxd3drY3dLVFZndE91VGU0THZod3hrbm8xQkV0S0VReTF1cTNPUXVTMTgx?=
 =?utf-8?B?UE10czV3cm9HY2NFMUxPMzFER3FZTTIxa0ttSWdlNkJWRkx3NXB2Q2wyK2xt?=
 =?utf-8?B?SEJ3VW0ra0xxVk15TVNpWEdNVnB3UDN2cXBUMUdpWStvbzhFcmdCbFhVS1g1?=
 =?utf-8?B?ODBjUEdKN2IxQUJ5VG8xcVEzelVmODE1M2kzVTdBNjZBK3gwTzNjWXR6RFFk?=
 =?utf-8?B?RkpsWDM2MExBUnNYZWhOT0pVWjZxVTZMQlVDWitnQ3pTVmI4Y1hPM1IzNWNM?=
 =?utf-8?B?cU83d1ZYZFdoUHpjY1pnajRDdDFrU3hSS1V0UVZGZlZwOXZ1L2J2ZXRmT1h2?=
 =?utf-8?B?NVhKd0ZQSDdjYTk4V0gvRFcxay9tL3F6WDlOYWdJeGtlKzlHMW9RS3g4WmRR?=
 =?utf-8?B?OGZsV29aZUlZdVprYVNMejZYR0JkWi9wMHdYVEZNeWg0bEZRQ2Q3d1o5a0pJ?=
 =?utf-8?B?bFZ1ZGJkK0dWdUlraVFPMzJxT2Z3cGNkZGlNbi9ZMlBjbkNsT2FiU3NwODRj?=
 =?utf-8?B?UEFmeGw0L1FndWNqempUYUxzZVFobEVjQkpSNE9weW9OWHpNTFNPTGJ3aUxZ?=
 =?utf-8?B?TWVJQ1ZNbDkvRWM4c1ZSZjhkSUw5d3J1TFpTbWtIQXRaaWRJblQ5RVk4MTNq?=
 =?utf-8?B?QVVjOUM1WitGUDZUdkplZlkvajFSOXF2VHZzQlVCNW1lb3FjOEk4eDZrYlpx?=
 =?utf-8?B?enJncDh4UkFNYXg0c2lKaTIrcjdVa3Q2aXZVUUlBNjBJM0paNTdJQnhkVEY0?=
 =?utf-8?B?aUNtSks4MlljVmJXWlVhVlVvTmxQbUthRDFGeXFQS08zckJDd2pGVkFmQ0ZW?=
 =?utf-8?B?U1plNEY3TGZ0UzU5R2tOY2RVUHdOZVlBSmdjaDB3TUJjL2pXQlo2emV2MjZU?=
 =?utf-8?B?bk1wTm54Syt0cTNNdWRFYk9CQmczLzRad2ZMa0lUYnNzcGRlaDZmNHEzWGVk?=
 =?utf-8?B?WVJ4TmUrWmQyQjFwbVNYS01adTRTMno0NFo2WDA4Zkg3TzB5S0l6eWxYV2tm?=
 =?utf-8?B?eHBGdW1QNmJLRjFYM2VzSURySWRMN0xBTithQlhMc1pKR1VHdzFTSFdNazkz?=
 =?utf-8?B?NGhuTkxjcDJQaSszaDN4T1JRZHRBWWUyWStMOHFJVkpCSVJsaTB3TkNURW03?=
 =?utf-8?B?a3pEcllBU1JydkRLaUVWMVI4VmdjYUFId0hOa21qejI5Q0ROUUZjb2tlYUFS?=
 =?utf-8?B?SXkxTHNJdzRaYjA1TWhuK1JTck51aHhjUnlHWjJuODAvdDNERFB5d3R5MFBH?=
 =?utf-8?B?SG00YzB2aXA0MmZabDM0QXR6VVgxQXJMdlRJRE5lYXVoVHpQOGJKUnN1WW51?=
 =?utf-8?B?UkRycytRY0VwNFdXRFNBYW1zWER6SHNlZXMycWNJZHZoN3A3eWk3cHZoM1Zp?=
 =?utf-8?B?elY1elJpZTZJSmhwekhia1BrZk5HUGhuZXh2Sm5mZlY1YXVCWDdqZUVYSGdG?=
 =?utf-8?B?cEdOQVVaNnE3T1BsbStWU0kvL3pyZGpEcFdVSzU2YWUyL3BuL3R6UG5TeFBa?=
 =?utf-8?B?Y2Y2dzgrU25ybjVJNEN5dmE3UEhGY0JPMlVRZXhrOERHWFRSMGF6QnR2SFk2?=
 =?utf-8?B?UzU5aGFTTU5YUnpyZ285ZkN1bzgramNIM2kxYzMvckxHc2lzS3B0dmJmVjlF?=
 =?utf-8?B?d25qckwza0xxa2twS1UvWHl4MThHc0plY0lkUWFkV04yaVplbkI3dmVubFRn?=
 =?utf-8?B?WG5vUnE0dmJYbm5LQzZINUpiZU5FcDlHbi9TekVFTGwzSlcrZU1xSVFBQVhY?=
 =?utf-8?B?eHFISGlKK05lbytSeDNnc3NIRFpxVGpWclVzZDNWNGdUN0p5SnlqZjlzR1Rs?=
 =?utf-8?B?Um9uajJiRFllWUpCaGExYzhxTUFPVFFOajI4SzN3QVQ5TEVjcEp0LzdjcVNr?=
 =?utf-8?B?SkFnbnBmelVhbWJOZUtQWHU3enRML2tJalU0UkQ5ck44RUFJQy9YcWgvYVk0?=
 =?utf-8?B?M2Z6MjV3TVg1b3lIZm9nc1Nib2dtcnZRS1VkUDJ3a3hEb3ZQSzJ6V3g4bFlL?=
 =?utf-8?B?MFlYZllYTnREVXVOVXpUUkFWV0VtR1dOZzV0aERiU1NtVmhaV1RFTzNVN3J3?=
 =?utf-8?Q?4TfOx6RW8wOSXjgvpKWPiTj5h?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b3a7ff-807f-442a-6474-08de30c97b8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2025 11:05:05.2142 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LgV6clTI5feG8VFhLOYXERV6HelqwFrnSS9iZeUH2e774Fwglx4K0JH+a44Q8WyuyvZl3KhskpaJh1IqMkmKUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6970
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogRmFiaW8gRXN0ZXZhbSA8ZmVz
dGV2YW1AZ21haWwuY29tPg0KPiDlj5HpgIHml7bpl7Q6IDIwMjXlubQxMeaciDMw5pelIDg6MDcN
Cj4g5pS25Lu25Lq6OiBBbGljZSBHdW8gKE9TUykgPGFsaWNlLmd1b0Bvc3MubnhwLmNvbT4NCj4g
5oqE6YCBOiB1LWJvb3RAbGlzdHMuZGVueC5kZTsgZGwtdWJvb3QtaW14IDx1Ym9vdC1pbXhAbnhw
LmNvbT47IE1hcmVrIFZhc3V0DQo+IDxtYXJleEBkZW54LmRlPjsgTWFyZWsgVmFzdXQgPG1hcmVr
LnZhc3V0K3JlbmVzYXNAbWFpbGJveC5vcmc+OyBUb20NCj4gUmluaSA8dHJpbmlAa29uc3Vsa28u
Y29tPjsgWWUgTGkgPHllLmxpQG54cC5jb20+OyB0aGFydmV5QGdhdGV3b3Jrcy5jb207DQo+IE1h
dHRpanMgS29ycGVyc2hvZWsgPG1rb3JwZXJzaG9la0BrZXJuZWwub3JnPjsgUGF0cmljZSBDaG90
YXJkDQo+IDxwYXRyaWNlLmNob3RhcmRAZm9zcy5zdC5jb20+OyBTdGVmYW5vIEJhYmljIDxzYmFi
aWNAbmFibGFkZXYuY29tPjsgUGVuZw0KPiBGYW4gPHBlbmcuZmFuQG54cC5jb20+OyBMdWthc3og
TWFqZXdza2kgPGx1a21hQGRlbnguZGU+OyBTaW1vbiBHbGFzcw0KPiA8c2pnQGNocm9taXVtLm9y
Zz47IERhdmlkIFphbmcgPGRhdmlkemFuZ2NzQGdtYWlsLmNvbT47IEFsaWNlIEd1bw0KPiA8YWxp
Y2UuZ3VvQG54cC5jb20+DQo+IOS4u+mimDogUmU6IFtQQVRDSCB2MSA0LzRdIGlteDh1bHA6IGRz
dDogRW5hYmxlIFVTQiBjb250cm9sbGVyIGF0IDB4Mjk5MjAwMDAgaW4NCj4gaG9zdCBtb2RlDQo+
IA0KPiBPbiBGcmksIE5vdiAyOCwgMjAyNSBhdCAxMDoxOOKAr0FNIDxhbGljZS5ndW9Ab3NzLm54
cC5jb20+IHdyb3RlOg0KPiANCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vZHRzL2lteDh1bHAt
ZXZrLmR0cw0KPiA+IGIvYXJjaC9hcm0vZHRzL2lteDh1bHAtZXZrLmR0cyBpbmRleCA3YWVjMTcw
NjM4Mi4uZmIyODc0OGVjMTcgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm0vZHRzL2lteDh1bHAt
ZXZrLmR0cw0KPiA+ICsrKyBiL2FyY2gvYXJtL2R0cy9pbXg4dWxwLWV2ay5kdHMNCj4gPiBAQCAt
NDQsNiArNDQsMjYgQEANCj4gPiAgICAgICAgIHN0YXR1cyA9ICJva2F5IjsNCj4gPiAgfTsNCj4g
Pg0KPiA+ICsmdXNib3RnMiB7DQo+ID4gKyAgICAgICBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQi
LCAic2xlZXAiOw0KPiA+ICsgICAgICAgcGluY3RybC0wID0gPCZwaW5jdHJsX290Z2lkMj47DQo+
ID4gKyAgICAgICBwaW5jdHJsLTEgPSA8JnBpbmN0cmxfb3RnaWQyPjsNCj4gPiArICAgICAgIGRy
X21vZGUgPSAib3RnIjsNCj4gPiArICAgICAgIGhucC1kaXNhYmxlOw0KPiA+ICsgICAgICAgc3Jw
LWRpc2FibGU7DQo+ID4gKyAgICAgICBhZHAtZGlzYWJsZTsNCj4gPiArICAgICAgIG92ZXItY3Vy
cmVudC1hY3RpdmUtbG93Ow0KPiA+ICsgICAgICAgc3RhdHVzID0gIm9rYXkiOw0KPiA+ICt9Ow0K
PiA+ICsNCj4gPiArJnVzYnBoeTIgew0KPiA+ICsgICAgICAgc3RhdHVzID0gIm9rYXkiOw0KPiA+
ICt9Ow0KPiA+ICsNCj4gPiArJnVzYm1pc2MyIHsNCj4gPiArICAgICAgIHN0YXR1cyA9ICJva2F5
IjsNCj4gPiArfTsNCj4gDQo+IFRoZXNlIFVTQiBub2RlcyBhcmUgYWxyZWFkeSBwcmVzZW50IGlu
DQo+IGR0cy91cHN0cmVhbS9zcmMvYXJtNjQvZnJlZXNjYWxlL2lteDh1bHAuZHRzaQ0KPiBkdHMv
dXBzdHJlYW0vc3JjL2FybTY0L2ZyZWVzY2FsZS9pbXg4dWxwLWV2ay5kdHMNCj4gDQo+IFBsZWFz
ZSBzZW5kIGEgcGF0Y2ggdG8gY29udmVydCBpbXg4dWxwLWV2ayB0byBPRl9VUFNUUkVBTSwgdGhl
biByZXNlbmQgdGhpcw0KPiBzZXJpZXMuDQoNCkhpIEZhYmlvLA0KDQpQYXRjaCB0byBjb252ZXJ0
IGlteDh1bHAtZXZrIHRvIE9GX1VQU1RSRUFNIGlzIHNlbnQgb3V0LiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy91LWJvb3QvMjAyNTEyMDExMTAwMzQuMTk2ODg3MS0xLWFsaWNlLmd1b0Bvc3Mubnhw
LmNvbS9ULyN1DQoNCkJlc3QgcmVnYXJkcw0KQWxpY2UgR3VvDQo=
