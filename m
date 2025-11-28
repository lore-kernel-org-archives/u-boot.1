Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98429CFD376
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 14:13:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 023778458E;
	Fri, 28 Nov 2025 15:13:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="n3BvLagN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09E2C8444D; Fri, 28 Nov 2025 10:52:10 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC70E842CD
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 10:52:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gfRHpzggM6EMZEfVkJTkHL2oKDlzrnBVhWL4/jXcQA5864MPxlgtp8KNsZk5evjtJFsVj3bf+KPjkgjqoT5eLaxji5YQs236uYppf/I8x9+uaJi0ShKPg84Mufqjv5SJf9FU9byQbypq4316brVg1gzcZjdpCOfcyCj6esOIAIxilwGAdiUX0h04KjoGw9yb+mNQrQwsrMMSWKTy4VyfzbV9v/lBx3pddJxvxJSA0TlaM7VjW0FIMbCI4DPm9DWHDvGRq7wh156Sg/kmASfbhvjtchLhx8N9DlXg+q6Q9UyX/j+1NkhTXUre4Gi6yezoK7GPIBGqDFRZ9eMPb+M1OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Kmi3wCKGLExkPWt2O0S5HQ33En46O6wMSZsn6dNtNc=;
 b=i34/oMhL1ndPgboNi9LQcgPI2/xI5n+uWkJG3I74QLxm+7SLcBGkUgTITI4Tnf4NF+MhURexEKWY4SuZ64HkpI84Mx16hZLSr9LTdiSKlg47p21kDE917EmbyEOrFl9jN7OhACTujsWwMUe3fhz3k9Ua3tpFo+vnZGrtcHKd48LqsGGKddJjFad22QBadRKMPCONs2dF2ZEzoFM0zepTIMoUTTST+PHpCwfoQOOkWhuVWtU9s9iqr/4C3rlGFDgE99g2JQ2oqtqKkUMRktZoE+A3gJnFTlEVYPEPYUseh8dt9GIrf8QOVr0iOnCG68/vk06jjVbM7sPfU2DOWLUAlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Kmi3wCKGLExkPWt2O0S5HQ33En46O6wMSZsn6dNtNc=;
 b=n3BvLagNqnJlvPlfrZJyGVdN4q0IobZRZOTY4SGPiU+wQrJD3+BXlUac0d/AMA2GOsD2HPR8yvRC9AzFJ3KTl8hKPvDM22HTEa8Z88SRpaB8RHEhyo3WXgkuwgXsVSmlwqROPI5od5lB4qiaDnu33h7EEjugKB0RkqLq2Ftxz8l76PUY+a7LjtLHbEcUnjTSc7Xax1+iyG8/F9HwCcug+i/kEzACvWspbRkgOU40dM+MVpfiybuykYrJM9QixWxpFb8dhJe2m82De2kXsmXkX7Nck1DGGsDbpJ2XohJjuIBpS+So8wFFOxXSj158samV/qhf5HDPye4jQZJdXIqieg==
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com (2603:10a6:10:320::21)
 by FRWPR04MB11176.eurprd04.prod.outlook.com (2603:10a6:d10:173::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Fri, 28 Nov
 2025 09:51:55 +0000
Received: from DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::8be1:62a3:dca7:efa3]) by DU0PR04MB9636.eurprd04.prod.outlook.com
 ([fe80::8be1:62a3:dca7:efa3%6]) with mapi id 15.20.9366.009; Fri, 28 Nov 2025
 09:51:55 +0000
From: Alice Guo <alice.guo@nxp.com>
To: "Ross, Fedor" <fedor.ross@ifm.com>, dl-uboot-imx <uboot-imx@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Ye Li
 <ye.li@nxp.com>, Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
 =?utf-8?B?Sm/Do28gUGF1bG8gR29uw6dhbHZlcw==?= <joao.goncalves@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <ravi@prevas.dk>, "Ross, Fedor" <fedor.ross@ifm.com>
Subject: =?utf-8?B?5Zue5aSNOiBbRVhUXSBbUEFUQ0hdIGlteDk6IHNjbWk6IHNvYzogVVNCIGlu?=
 =?utf-8?Q?stance_number_change_for_silicon_revision_B0?=
Thread-Topic: [EXT] [PATCH] imx9: scmi: soc: USB instance number change for
 silicon revision B0
Thread-Index: AQHcX8Z5W6Iwvh5q3EC2X10zC4lLXrUH0d6Q
Date: Fri, 28 Nov 2025 09:51:55 +0000
Message-ID: <DU0PR04MB9636116854EC605E717FD8E3E2DCA@DU0PR04MB9636.eurprd04.prod.outlook.com>
References: <20251127-imx95_b0-v1-1-fc3bd2ba1b56@ifm.com>
In-Reply-To: <20251127-imx95_b0-v1-1-fc3bd2ba1b56@ifm.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9636:EE_|FRWPR04MB11176:EE_
x-ms-office365-filtering-correlation-id: eab64626-8b50-41c1-5ddb-08de2e63c3f4
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|19092799006|376014|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?Y2xlcUI5ZnREcmVTSDh1S1JPUHBERTIxSzNIS3pjRXZ3K3VYb2paSWNQNldn?=
 =?utf-8?B?alZnZ2J6OHpMSCtmTDdkNy9qWkF5Y2hmK1hNY2xOMlErb0ZDZUJqVlZ4N3FH?=
 =?utf-8?B?Q2wrNVl2ZUxITDMwRGhVRGtjeWtBSlE5L08wMWxGWHVHTnM0NDQyUkk2YzMw?=
 =?utf-8?B?WmFjRlovKy9menh4cnJQUE1CZEN2TFB4ZVYwcDM5RkM5aTRPUlpxeGlTc0k5?=
 =?utf-8?B?cFZTeEVycFJodUhVVGw2VGM0U0xpY1FrdHlBb1pGelBieFk0WlByam9qNHoz?=
 =?utf-8?B?TnkvZFlMVFRGTUxHNWxzdXRBRHplVDhYdDR1YS9CMzB4QmRwUTh6cHZxTldH?=
 =?utf-8?B?MlIwUEtWYnM4VUVFNzgrZnZvcTk2VkNjQ2d6dFBuRmtHUGJabHBwOG1GZGpI?=
 =?utf-8?B?SCt0SmxBMzBEdWdwZjNGMUpRZ0dGalNibWRDaGdDTW1JbGxHa1ora3ZzU2xW?=
 =?utf-8?B?WnBscFBlb292bWQyLzZEUW1mSHl0cURFaU5MOEFCTzhMMHkvWEd3T1pnVnpY?=
 =?utf-8?B?RkRWak5wbCtSVWVqZnczdDkza2JvSkhOTFBXdENuVmh3a1NNMEFWNEtVRGNE?=
 =?utf-8?B?ME9udktsWkVDNEh4NkNLKzA0TmVyalQ5S0ZoUFVhWisxcEFLSjBXeml2VFBj?=
 =?utf-8?B?R0YyakV3RGhlRzJ4QXVsb3ZRUHM3czFqTldodW92MCtiN0J6bEI1MHJuYzZa?=
 =?utf-8?B?cmd4TnJVV2FyZkx1VkgzdWx5ZzhNNHJ2RVdoU29FLzFKaWNqb2E2RmMxSHhi?=
 =?utf-8?B?OUhCMCtoRVdmTXNON1J4eDZxS3lZUEpuQndRMFY3TWpDMVlsOHpSa2R2aW1u?=
 =?utf-8?B?LzZyd2lEbzd6d2xqRWx4WnJvTFF4ZklXbUFOZ3dTSWRybi9WYjdzTE5rWjhJ?=
 =?utf-8?B?VUoyeHhaRFpLRGRuVXVqSDdqbTNHWUlqcXQ5WEJYd3hQUERRZnZrZFk3RlMz?=
 =?utf-8?B?ZC9XYVYvK295MmhGWW1DMzA2UnltdzhleHI0VXJPUW1COFVSYlRzNGFycEtp?=
 =?utf-8?B?enh5ZGFOSUwwTG9DOG83WEE4Z0JyRHh0ZnIwVHJSQjNIUUFWZjU5ZWRDVlE2?=
 =?utf-8?B?a3A5alU1MndkQjhDcWRkbHMvbmxyUmk3ZGJQUmxSTFBrblB6YkF3Skd6bHhH?=
 =?utf-8?B?U0FjTTVENGNZQzZBdFJvMmhGVzRmUExHbU5Jdjlud0NoaFZvcUszUURydjlq?=
 =?utf-8?B?eTcxODlTaUpUeUlqNmkzSTU3UUhxajZoSGQ1SFAwL0FqZHkreC9GYXpYNkdH?=
 =?utf-8?B?WGYyTWF5dGVRVVAxOTlHcEVCRExRa0xhSXFlOHh3TjR6Z1czOUYrYUdTUzVQ?=
 =?utf-8?B?OGg4NC9DWmVVUm1pZG9Uc2NyK1Rxc29Telo2YVhPOG1neVViaTZObVVlWkVl?=
 =?utf-8?B?Z1RTaGY0akZmMWVhSkx3UEVBL3pFSGlnTWtzK0dNQ1RJazVrV3liSzVzaENs?=
 =?utf-8?B?U3lqQ002eFhUbGtGQnBtTkVpTU1oSlFrbzQ4T05tK2I2bFF3d0xmNHRyMnJ5?=
 =?utf-8?B?K0Q0VmZqZk56NVRIK2dJMWVOTzZVa1RsV2FrVkgwcEtlaXRja0dCQ3kzemFD?=
 =?utf-8?B?Y0VxYkdyNGcwWmQvNG13WEJOYmdENytaWTVNUWo5TTdrUzVJUkQxc2g0aDZZ?=
 =?utf-8?B?U3R0ZW9qaDBMUDQ0U2RaczQzSitNbVRqTmlpOXBzMG9nbVY5SkhQQ29icVZo?=
 =?utf-8?B?NHV3Y01kalpIYkV1SnJKTGFTWE5SZWYvaG1tYTY1T2w1anh6Z0dNdVZXRGpp?=
 =?utf-8?B?RFBsK2lVdXNSKzg5YytDNTFoQ0pYRll6MkpJQ3F2NWxja3IveGpHV3hCVVIz?=
 =?utf-8?B?dnZTVllGbjd2NG95RXNmUzZ1WjQ1bFdkSEk3SS9XSzJxL3hCcnBieE9GZEto?=
 =?utf-8?B?OEhXV21jeUJBeElUejhpTENxU0ZxSVpEYW1wbDd5Ukd5NTdlQXRYQ1hnRzl6?=
 =?utf-8?B?MkJJME5jNncvWHBNdVQyL3V6WkZCblVTb3F6Q1hoTnZHMnl5QXRkelJkbjUy?=
 =?utf-8?B?WGJpTjdwcVRSVjUrL1QrSlpsYWZnVFJZNGtCTHdMZCtRQzdWaEhpSS9MMHlR?=
 =?utf-8?Q?CmhLHF?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:DU0PR04MB9636.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(38070700021)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0dKTVMwR3JzdXhsY1I2OElmY2pvRjhzaXdDODdCTDVObFhzQWlLOGgrb0R6?=
 =?utf-8?B?R0pJK0J5QTBld0lidzgwYjRqVW10dE02MjBPSERZWStPK1NoT1BqaGlybkVL?=
 =?utf-8?B?R09JcHRzS1greW9xbno3MHdZcG5la2ltZEkzVlkvVFIrUnF5R1ZRK2taR3FX?=
 =?utf-8?B?UUJtQURUSk9XU0NsWE5HMG9GdHF3bEhmemtjeUkySUVxVkRVZS9XaXZDTWxz?=
 =?utf-8?B?dWgxRm5MMVZiR2F0Y2UvZ3JYeEY2KzNzQVhkZU5CZ3BxRCtqZERaUXJsWC82?=
 =?utf-8?B?Wm16TnExcTVIbjY0bjdvVDVrNmRwQll2R0d4alFVb3ZCU1JvYVFjZkJTRVpi?=
 =?utf-8?B?WmY5eVNpcy90c2ljcFErd1pUSnBtYXZYbTliY1k4RUJPaFJrN1ZlLzhZUEtv?=
 =?utf-8?B?RjB3T0tmci9FNFNYTXByelJYaHlldFFEUVl1OTliZ1lxSnpTVXhhdU1uY1NX?=
 =?utf-8?B?T2pDdHBWemN6eVhLZ0RkZUJGRnd4MDFXRjRyNDZtQ0hIMHREVGliQmp4UEhh?=
 =?utf-8?B?N09sQnE1TWxLQUZwUFNXQlFhblRnVUtOK1hPeFVoM0w4UCtEWHppdG9yNHhj?=
 =?utf-8?B?ZWQ5L3dvbHZMQkhrYVdpeW1VVEZYZlJETEl2ZWJtZVFhQkVQV1VUMStZWXRX?=
 =?utf-8?B?NkV4UXIydHdJL01uODJNZFBWcVQ0WUxib3VEcEdxOXhIbHJZQXBJeWVCTFZn?=
 =?utf-8?B?MUtBb3FtTTlHUkdJdTV1VldqbEU3K0d1V1lxMTg1eUR6WWRWT3czNzgzaGxO?=
 =?utf-8?B?L1RoK2VjYzBTUndBcnZOdUowenJPandFVG9MM3lKMjdOOUIxQnZlK3JBOXIw?=
 =?utf-8?B?alN5QU5VTkd0aG1KWUwrUDh6eEZCbDB4bFdXZFZ1T2VFSUd5OU5YZW5GNkJs?=
 =?utf-8?B?VTZBeGl4TmFXRUJ6ODgwRWlib1g5MTFwQy9IZWZGQWtUN2Y5Rlk4MFlldUt2?=
 =?utf-8?B?LzhTUkgyRVlFWmM1L1pGU3pYbS9vdEdjeUVYd2Z2Q0I4Q3N2OXVWSHdlTDBs?=
 =?utf-8?B?Vm9uY1I1NTMyN1lod00zbSs5eVVBU09HVlozWTdFbVI3NzVJNHBuU1l6R0hY?=
 =?utf-8?B?L2RhcHoyQlFrQkJWSDFKV0l2a081ei9jWE0zdHhMOG12NjNmMWNoYkp0SjVr?=
 =?utf-8?B?V0dvbVNLR1VsVWNwTm42NUJPa1c0a3ZkcFVSVVZxeFlvWmd3QVBLN21hRFlt?=
 =?utf-8?B?ZmRGRzNDRE9RZlJFcDR4RzkreGFwdTVhbEJqM3lacjdydzhwNElBenl4Wkpr?=
 =?utf-8?B?bzljK3UwWGQxRjJubTZUV0FhankzSmxIakNpSjFJa2l1R1hZcVEyYmVFU3ps?=
 =?utf-8?B?VWE4ajZjSmsrd3krUlFLTHpSbmxjTDY0MmJCeTl2Zm5Na1F5VE1CRFMvRzMw?=
 =?utf-8?B?bk0yM09GbXMwcXIvUmZsYXF3S0dsYkRad3dpaWhvcmpwa1FmdUl3c0VOVVJp?=
 =?utf-8?B?bjk5L0g4K0pEWktEbitNK3cyckY2MmZuYzV3ZzdGMDFMcm12VG5OZ2dpdDEy?=
 =?utf-8?B?aUhOTThLTWpVdTVzaGNiekpTL0VRUi9kWEZyNjE5dTNvNVpuWFpLMXBCQi9a?=
 =?utf-8?B?ZmlYLzIzWDEyVzlGS1Y3RHZPVXlHcVVJMm12T2Y5OFV0VVhoSDAzWkFpeUZC?=
 =?utf-8?B?WnB6NXZST2krQWxIY2VUSmJkUkFtQ3F5cS8xVmdkUnJGdE9TNGQya05tem5L?=
 =?utf-8?B?cmdjVjlEL010L0ZVdEFnMVJOUUFQU015c1kvQXFpbHdTVkYvaHhSL2ZkaEFW?=
 =?utf-8?B?VU5jaXJ2WmgveG5uTTZ5NzRacEtPcC81R1VYV0IyclFpMzZtdFo4dEh5QlUw?=
 =?utf-8?B?R0hXMWpid1dXWSs1YlViRDMwcllJbEU0MmR0cEF0UTRKcWM0cVdnQ1lYTURu?=
 =?utf-8?B?SnNnZ1c2eVBOSEk3NXh3N0xQbGUzOTM3cU04aW9EckFjTHZQWEZUMWN3eXJ6?=
 =?utf-8?B?dTlDMTgwU1NBWXkxbzA4WnQ5N3dEWFp4TzEvUFlVT1NtT0lTMWJqUC9RMGRx?=
 =?utf-8?B?TXdaTTV1MTFVL2VJWTRkQm5QajJ3ZG1iQzlCZjlyZVFMbEl4QWxUU05EbHV0?=
 =?utf-8?B?blNBM3gwRU5XTTZzQ1lpNU9WL3AySW4xSDlNcVpHdjVJR2xJdzFCekJ1N3Zv?=
 =?utf-8?Q?he+8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9636.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eab64626-8b50-41c1-5ddb-08de2e63c3f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2025 09:51:55.7300 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8eNE9iNvEld89RrdCyDgIw8LN/ZJzNhfUyiDBTX4O7LLHPrcszmue7CpVnsmFeOiaNpSEXaop4RWrr06tWLCDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11176
X-Mailman-Approved-At: Fri, 28 Nov 2025 15:13:00 +0100
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogRmVkb3IgUm9zcyA8ZmVkb3Iu
cm9zc0BpZm0uY29tPg0KPiDlj5HpgIHml7bpl7Q6IDIwMjXlubQxMeaciDI45pelIDE6NTENCj4g
5pS25Lu25Lq6OiBkbC11Ym9vdC1pbXggPHVib290LWlteEBueHAuY29tPjsgdS1ib290QGxpc3Rz
LmRlbnguZGUNCj4g5oqE6YCBOiBTdGVmYW5vIEJhYmljIDxzYmFiaWNAbmFibGFkZXYuY29tPjsg
RmFiaW8gRXN0ZXZhbQ0KPiA8ZmVzdGV2YW1AZ21haWwuY29tPjsgVG9tIFJpbmkgPHRyaW5pQGtv
bnN1bGtvLmNvbT47IFBlbmcgRmFuDQo+IDxwZW5nLmZhbkBueHAuY29tPjsgWWUgTGkgPHllLmxp
QG54cC5jb20+OyBBbGljZSBHdW8gPGFsaWNlLmd1b0BueHAuY29tPjsNCj4gUmFuamFuaSBWYWlk
eWFuYXRoYW4gPHJhbmphbmkudmFpZHlhbmF0aGFuQG54cC5jb20+OyBKb8OjbyBQYXVsbyBHb27D
p2FsdmVzDQo+IDxqb2FvLmdvbmNhbHZlc0B0b3JhZGV4LmNvbT47IE1hcmVrIFZhc3V0DQo+IDxt
YXJlay52YXN1dCtyZW5lc2FzQG1haWxib3gub3JnPjsgUmFzbXVzIFZpbGxlbW9lcyA8cmF2aUBw
cmV2YXMuZGs+Ow0KPiBSb3NzLCBGZWRvciA8ZmVkb3Iucm9zc0BpZm0uY29tPg0KPiDkuLvpopg6
IFtFWFRdIFtQQVRDSF0gaW14OTogc2NtaTogc29jOiBVU0IgaW5zdGFuY2UgbnVtYmVyIGNoYW5n
ZSBmb3Igc2lsaWNvbg0KPiByZXZpc2lvbiBCMA0KPiANCj4gW1NvbWUgcGVvcGxlIHdobyByZWNl
aXZlZCB0aGlzIG1lc3NhZ2UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWlsIGZyb20NCj4gZmVkb3Iucm9z
c0BpZm0uY29tLiBMZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRhbnQgYXQNCj4gaHR0cHM6Ly9ha2Eu
bXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4gDQo+IENhdXRpb246IFRoaXMg
aXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSB0YWtlIGNhcmUgd2hlbiBjbGlja2luZyBsaW5r
cyBvcg0KPiBvcGVuaW5nIGF0dGFjaG1lbnRzLiBXaGVuIGluIGRvdWJ0LCByZXBvcnQgdGhlIG1l
c3NhZ2UgdXNpbmcgdGhlICdSZXBvcnQgdGhpcw0KPiBlbWFpbCcgYnV0dG9uDQo+IA0KPiANCj4g
Rm9yIHNpbGljb24gcmV2aXNpb24gQTEsIHRoZSBVU0IgaW5zdGFuY2UgbnVtYmVyIGZvciBVU0Ix
IGlzIDMgYW5kIGZvcg0KPiBVU0IyIGl0IGlzIDQuIFRoaXMgY2hhbmdlZCBmb3IgcmV2aXNpb24g
QjAgd2hlcmUgdGhlIFVTQiBpbnN0YW5jZSBudW1iZXIgZm9yDQo+IFVTQjEgaXMgMCBhbmQgZm9y
IFVTQjIgaXQgaXMgMSwgd2hpY2ggaXMgdGhlIGludGVuZGVkIGluc3RhbmNlIG51bWJlci4gU2Vs
ZWN0IHRoZQ0KPiBjb3JyZWN0IG51bWJlcmluZyBhY2NvcmRpbmcgdG8gdGhlIHNlbGVjdGVkIHJl
dmlzaW9uIGluIHRoZSBkZWZjb25maWcuIFRoZQ0KPiBjb25maWcgZm9yIHRoZSBCMCByZXZpc2lv
biBpcyBJTVg5NSBhbmQgZm9yIEExIGl0IGlzIElNWDk1X0EwLg0KPiANCj4gVGhpcyBwYXRjaCBp
cyBiYXNlZCBvbiB0aGUgaW5mb3JtYXRpb24gcHJvdmlkZWQgYnk6DQo+ICJBTjE0NzUwIE1pZ3Jh
dGlvbiBHdWlkZSBmcm9tIGkuTVggOTUgQTEgdG8gQjA7IFJldi4gMS4wIiAuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBGZWRvciBSb3NzIDxmZWRvci5yb3NzQGlmbS5jb20+DQo+IC0tLQ0KPiAgYXJj
aC9hcm0vbWFjaC1pbXgvaW14OS9zY21pL3NvYy5jIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9h
cm0vbWFjaC1pbXgvaW14OS9zY21pL3NvYy5jDQo+IGIvYXJjaC9hcm0vbWFjaC1pbXgvaW14OS9z
Y21pL3NvYy5jDQo+IGluZGV4IGRiYWExOWE5ZTZlLi4zNTRkZjdkODhhNCAxMDA2NDQNCj4gLS0t
IGEvYXJjaC9hcm0vbWFjaC1pbXgvaW14OS9zY21pL3NvYy5jDQo+ICsrKyBiL2FyY2gvYXJtL21h
Y2gtaW14L2lteDkvc2NtaS9zb2MuYw0KPiBAQCAtOTIxLDcgKzkyMSw3IEBAIGVudW0gYm9vdF9k
ZXZpY2UgZ2V0X2Jvb3RfZGV2aWNlKHZvaWQpDQo+ICAgICAgICAgICAgICAgICBicmVhazsNCj4g
ICAgICAgICBjYXNlIEJUX0RFVl9UWVBFX1VTQjoNCj4gICAgICAgICAgICAgICAgIGJvb3RfZGV2
ID0gYm9vdF9pbnN0YW5jZSArIFVTQl9CT09UOw0KPiAtICAgICAgICAgICAgICAgaWYgKElTX0VO
QUJMRUQoQ09ORklHX0lNWDk1KSkNCj4gKyAgICAgICAgICAgICAgIGlmIChJU19FTkFCTEVEKENP
TkZJR19JTVg5NV9BMCkpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGJvb3RfZGV2IC09IDM7
IC8vaU1YOTUgdXNiIGluc3RhbmNlIHN0YXJ0IGF0IDMNCj4gICAgICAgICAgICAgICAgIGJyZWFr
Ow0KPiAgICAgICAgIGRlZmF1bHQ6DQo+IA0KPiAtLS0NCj4gYmFzZS1jb21taXQ6IDk2MjcxMTQ5
OGRkYWM2MTc5ZjFkMWYzZmExMjMzOTdiYTAyYTM4MWINCj4gY2hhbmdlLWlkOiAyMDI1MTEyNy1p
bXg5NV9iMC1lNTgxMTNlMTAyY2INCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gLS0NCj4gRmVkb3Ig
Um9zcyA8ZmVkb3Iucm9zc0BpZm0uY29tPg0KDQpSZXZpZXdlZC1ieTogQWxpY2UgR3VvIDxhbGlj
ZS5ndW9AbnhwLmNvbT4NCg0KQmVzdCByZWdhcmRzLA0KQWxpY2UgR3VvDQoNCg==
