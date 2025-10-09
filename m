Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 552CFCCA470
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 10:34:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A636D844DE;
	Thu,  9 Oct 2025 12:34:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DlZ0Xd1T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7099F844ED; Thu,  9 Oct 2025 12:34:12 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08986844D8
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 12:34:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t3h63csgISJd+Zm4GeasbvGAknvBvvBx3rRlAQv4Qkn5h/fm4qY9BBXUEjHCMO9TPnZyHa5gVVz6Tb3biRNupPXe+ptDyzTMKQtN989U3zcIBE3altWl+MjXP95188oCZcx2rbSSS7rhu9ILjhcX45kYyfkW1GcRr0Vzl7J7GZP+Jz5GI+sHOWaqYFRo34Ox7MhfeY/2IFdDtsnILPuEgnqp7iZSOJwt0ANvKJw2kN7bThFmvGjCOrV93RmlzD80pE0r2jiBMUSj8WqGiQA/5TuZUDLNdo0mPJWfJDzKQNrwp9p+G1fPy55afJD5qh8UP+OkCNON82p5tNokQrUHvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBgpkk6XCOz+EnnlOxq5bFx5PM9bcEIIOOLwlvFKWHM=;
 b=hAdoYOphXNY3YOjQez9CnvnFGH32FgGOaQx0wlr63iG6IyKaPh6xdxPIqv11zidwHKoGg0rf0ZDfR8PfQXbbZ8z4g7aUcH76mDokasN3hQSq4/p3cjqDpeiX6RK9DgPGrHavn2+EYA00KKzRTECNoY0XJxwWV+Wn3TjUcg6v5BmFYh1ugF5kFx9xYpVv06VxfzlE1Lo21+R0wZ7RYyln39hs9wh93DoiIoiNb/0khH4C0a6zv3YbRCHq1PJO62Nl8QZU+VZK8zQqxroMbr9k8Lc0IPTfmid/TcEkZCAkEkUQUzUD2J+AZ2kP0PjDXq0skDl/gpCUDn8BMXfWvGc8rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBgpkk6XCOz+EnnlOxq5bFx5PM9bcEIIOOLwlvFKWHM=;
 b=DlZ0Xd1TybiMeQxWcKSO6riBitpqol7VMTmGBuCVY54rlAbYqiUu4x3ovZPUuKOwVZ4woXQtKSi8ea0TlUyv1liPE7sfYPOnA94FRtFnpqVwXMvX1sG6nwUG3/TH2SHwCY00NbJp49Wsz7RTUN5H9yRsQrCWWwwXyhEAf21mLmdOGUgpPaA8Lk6geRVVPAfFYfs/QBvs1TiszQ1yfHrEshchLybnBcZo+2P8wSRIaxeXY0slFMqz6ao34XQc3iU/E1wol9m9EyVB08i88Rascv31Y32BP0ZQ4P5U7iGsvrK37WdCNKI3eJivJejjGjhZS8BuwNt5/7jJadyOsrmGtQ==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB7592.eurprd04.prod.outlook.com (2603:10a6:20b:23f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 10:34:07 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 10:34:07 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, "Alice Guo (OSS)"
 <alice.guo@oss.nxp.com>, Stefano Babic <sbabic@nabladev.com>, Fabio Estevam
 <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>, Tom Rini
 <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Troy Kisky
 <troy.kisky@boundarydevices.com>, Adrian Alonso <adrian.alonso@nxp.com>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>, Alice Guo
 <alice.guo@nxp.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: =?gb2312?B?u9i4tDogW1BBVENIIDUvNl0gdXNiOiBkd2MzOiBnYWRnZXQ6IEFkZCBkZWxh?=
 =?gb2312?B?eSBhZnRlciBzb2Z0d2FyZSB3cml0ZXMgRENUTCBpbiBkd2MzX2dhZGdldF9y?=
 =?gb2312?Q?un=5Fstop()?=
Thread-Topic: [PATCH 5/6] usb: dwc3: gadget: Add delay after software writes
 DCTL in dwc3_gadget_run_stop()
Thread-Index: AQHcOQg98IUY+nQX5Eif41YQNiuTGQ==
Date: Thu, 9 Oct 2025 10:34:07 +0000
Message-ID: <PAXPR04MB964469BED1917590C26B835DE2EEA@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250720-imx95-v1-0-759619b47b1f@oss.nxp.com>
 <20250720-imx95-v1-5-759619b47b1f@oss.nxp.com> <87a52dk5mo.fsf@kernel.org>
In-Reply-To: <87a52dk5mo.fsf@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|AS8PR04MB7592:EE_
x-ms-office365-filtering-correlation-id: 64ce7319-11e5-45e0-16d3-08de071f6031
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|19092799006|366016|38070700021|921020; 
x-microsoft-antispam-message-info: =?gb2312?B?UnpmQml5bGN3TzVMVm8zZzVVMEl6MFZpckdVa05OMEtFQkNJQ3l4UWZjWmMx?=
 =?gb2312?B?Z3BKN1JFRGlVMi9NZkVjMkR3UmY5RXl5VTRxWmVIZEhWLzVjZ0JScFJDY1Bl?=
 =?gb2312?B?cGZnVEgxY01sTHZLK1JZRVdSVHVVa2pPSVlOWkRkd0orbEhSSVJSVlZ4ditO?=
 =?gb2312?B?dDROcHRNU0UxSGVCeHp3ZEhUL1NleU93WVBkaWVWYW9hYXZ5bVJWY25EblVk?=
 =?gb2312?B?NnJ4cVhhK3NKY2NIaTJEdHVMSU9TYTRwMVNPWCthN0gvRVFqYlZWS3MyaS9p?=
 =?gb2312?B?Y0NuMHhXb1puNk9hd2hKMmRGRE1CM2R6UDBoL2d1SGNxbWdwSjBSblM4ckg0?=
 =?gb2312?B?dFI4emVpcnNCWVVYc081MlRoWjhGQ3k3bkU1N2ZtMzhhbjBHNURWWVJZTDZ4?=
 =?gb2312?B?RkxLODZ1RHgxbERPYlZiMGtObnRkTUV4V3MyUDc4QVkweE9TMG1VUloxQjM2?=
 =?gb2312?B?RjYrQitrUWQ1aXhiMU5RWE92b0gxWnhCSjd2QW42ZjBFdm43YWR4T28wZXkr?=
 =?gb2312?B?QjByeVBJcVRXZWwxQm9ydzZnNnZreVJuN2hPNHQ3TkEraE1rc1pJVTVUNVhP?=
 =?gb2312?B?bUdEVEd4dmxFckVtbmp0VUdWWXJZRWJzazF4bG1OWVFSMENXbzltNU9IajlP?=
 =?gb2312?B?a21vV0tZOEJHZDdtWDgwNnFFSldlTlR4eVhwVWdpNGswWlFXMzVCaGNiMVBQ?=
 =?gb2312?B?UkRkNEFTN0tNRklVMGhNMDhzSUxMSEkxSmZwT3AxMS94cTYzelhnS3VTNEZw?=
 =?gb2312?B?UkpYYjRBQnAzcmZWT0FsNTdCVzBFQno4ekp5SjRzM0xFTkpYQlNTc1l1d3hi?=
 =?gb2312?B?TE43VG96RnhRaFJlbUxJclFKbExJcjBoeGVjZGNlSFZiOHRIMGJCVEF4M1NF?=
 =?gb2312?B?WjBjQllLdXd6NzkvTkxMaFVuQ0RYU3NIWVZqNVRIWVhMVnRBNUlaTTZvUjJy?=
 =?gb2312?B?MnBnSS8zd1BtekVDNkFiSkRUYS8rVEVRdWNxR1FGeFUyQVpqZDFwc2V2UEwv?=
 =?gb2312?B?eGNscDI1cXZ3YlMrU05mU21rZWlJU3dySG5xQWJROVp3bzRZaG40OXduN2Yx?=
 =?gb2312?B?WnV1UUFPS2JUNlpVNWM5WG9ORzV5eWRzZjVUQTlZdzkwcWEzNndrd09uS3lq?=
 =?gb2312?B?TnVWM0lkRy9YNVVwY1pxU0NCd0FObC84SFFwd1ZiMFlYVllrSkVtZmdMVys5?=
 =?gb2312?B?V3RnYXBqakZ1Rzc4Mk42TFFmTEJVaFpFSmhtMmZCU3BOQkFkMjdQV2V6Z1ZD?=
 =?gb2312?B?d1pvWnFPUHVBOW9HQVluOXVWUldQWkw4Qko5Vk1pRlUwb1BZUUh0SmZpVTVF?=
 =?gb2312?B?S3JQNW5ucE9SSTEyVFQvYmVZeTNYd2JJN1RVVjZwTmE3RjF4allWWG54Mlo5?=
 =?gb2312?B?c2ljWGlTeWs4U2JHeXlwaDNYZC9aRXkxTC9YMUR5czNsNEhqNE1nYVZnVVQ4?=
 =?gb2312?B?dFZ4RXFvV1NvS2hEOGwxdmlzTFFxWVN3SStKa1J6SkVCTnc2K2RhUDNmMWFJ?=
 =?gb2312?B?VWljOXg2QllzdDRQem9kTEMrcTFDbVBvL0dRMHJ2WWlzWFJOVDV5NGdlNkVK?=
 =?gb2312?B?dEhmZWFGQXVKelFRODNZVGw5bXRyUnJRV0UyU1ZmNVdFQTd5OEQzZjB6K1NE?=
 =?gb2312?B?MzFINGtMSFJHeTdlYkx2VGZHczIzMmw2SEdJLzVyZEw3dmFSNDlxN21naGhy?=
 =?gb2312?B?VTBGK3dYNWxnMUpzcGNFMVZCTFI3d25iNG5oejlvVlNSWUlGZWYvOGNtWVNt?=
 =?gb2312?B?SUVmcTVPdWsveFBqaHpDN0kycnBVQjZTYmtMdmU2KzJudVRRY0FnbU9qT21s?=
 =?gb2312?B?WXdUUURDNVdwaDFtSDJkd1B0Q2YyN0xyNU5haTlFT25xMzIyeWFycnhDcytT?=
 =?gb2312?B?T3NPMG9HdjJoQzVjTk9qSi9BRlpjckpJWXJ5cjJ3VFBsc2YzOXREbU1aN214?=
 =?gb2312?B?TVRtTXZrelBFZlc3NHFaZU9FVzhkaGkwZ1ZEbTdiL04zYll5eXNFQ3d3VDB6?=
 =?gb2312?B?N3dZZURwSzZTMzErcEFac0h6V2RrT2hPY0RhWXQ0c1dITEpubVd1c3VQRzQx?=
 =?gb2312?B?cjlXbEJncjZ3SGVFZUt0bFRTcFNJRG5mZWN0aTUyQUNlMER3SDl2WERSUnJ6?=
 =?gb2312?Q?oDwI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(19092799006)(366016)(38070700021)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?cndmUVk5SUluUWR6WkVGUnQzUm50eWFMNWdvYWFoVGt6bkRvUDNpbGNPdUx4?=
 =?gb2312?B?emhUbW1pdHIwdGY2Qm9HUkdsSEpBRmdBZFVFcHBIdStDbXV5U0NVNExYSHFJ?=
 =?gb2312?B?TU9GRG92Q3U1S1RXNXNTNkltMXRUMURQa3ZjT1EyQ25FYnpuSjdya2lZRmNx?=
 =?gb2312?B?NTFCbEF1RHdNRXhhbWdFZUdJRUZpSkVqKzhDY3RUcTNuUW0rOUp1WlpSU2ZZ?=
 =?gb2312?B?WGttRkFxdC90cEN1Wlowbk9KNUFDN0ZUUG5DTzZCMFNKU2cySUl6dG5jaVp4?=
 =?gb2312?B?VWNYQWFCTHI3L014OG4vM2VxOGdhS2VrWkdLS1h6RzBOS1cwZjVCb05Ld01B?=
 =?gb2312?B?ZC9ZM295TUpLVkxIQUc0M0ZqQzhOL1kwY3R0OG1KUCtHYXY1bXZXbmRHZWpl?=
 =?gb2312?B?SVEyVjlaUEJ4VVFHVUhreUw0ZzZjM1VSbVRLaW0ydzlRUWpJellEVkV4d3Y5?=
 =?gb2312?B?UXBWOE5OKzJtMWl6cTJKTm5MVThoajlhSFhkNVJlS09ISGVReFdrZlVjNkdn?=
 =?gb2312?B?d0VaOXRuMzRJMjYrNnZTenV0dWZKSzBpMFhMSHNLMHF1UG1oVlpEQjhiVVpV?=
 =?gb2312?B?MSt0emJXNGR2ZGg5TGUvVU00b3lacEZOTTRpbDVRVnZTUWNydzE3YlBHRXNP?=
 =?gb2312?B?REJjQ1kxZ2kveURLb1o1Y1lCZVVHUjgyZnZ5bWUyNXJ2dWlNczFFVG1BUm9X?=
 =?gb2312?B?WGg2VjJGaVdBNEdHRWhxeGNsRGQwN0dlVlVQc09TVWFBMTQxUjB2Tzk4WHJU?=
 =?gb2312?B?WU50d2QxNjdzWW5oQzRpWmdzZkk3MW9vdTkvSGVjdWdTWDRra3Vxc1hFbnIw?=
 =?gb2312?B?QmNmc2JPbFdyUm82TzhMMEhvd1NwU21VUGVwcERBd3pBcGJraTFIR29YMGli?=
 =?gb2312?B?MlRST0duYnRsQmFTQ0NHUFNQbzNwQnFWd1p0bkdsQWpDK01aL3VJcUt3MlFx?=
 =?gb2312?B?R3JuYzZZYWVvTVBKZGVjZUhHc1N0T0dCelhSSWdaODZJMHFqdkZhTE5zV2sv?=
 =?gb2312?B?MXNYT0xUVW1ISk9BZzl2aXJDYUVIREhIUVpjMzNiVkRZZUc3TFF0VXk2Vnp5?=
 =?gb2312?B?Y1F6K2pYMEdkYndwaXlaQ1lRVG5xS0lTQ3hnbEpLTjlWS2dFMEhRQS9ZUWUw?=
 =?gb2312?B?S2N5NUtpeXVXWlcyTnZaRkNvdUlvODVXK2VySDJGc3p0LzJnOFJFK012Y05K?=
 =?gb2312?B?azZNR2JtTEFXblFPcTlaRmxvUkhkMjUwOWE4dTY2eGZKTnY4QzFxSWs5SDJG?=
 =?gb2312?B?cy9vbHNESE5RaHpGYjZGd0NoYy84OUVJcmtHQ056Z3VkZFhPRisyVFBnZjNq?=
 =?gb2312?B?OGVzUC9pbkJnUUwrZkZ1WkFVeVFLRld6TnArNkZ2NFpuSEFieStoYlI2YVM3?=
 =?gb2312?B?ZWZMUHZ6b0thRnpBRThMaWxkNFl5QVc2M2JMcXBYMG5BRVVsc1BVUDNLVFJH?=
 =?gb2312?B?ZkRtWS9mUktoNkFadGJSREFBZXVXNk13OE9PbWYvZmV2UW1nbUNCQnpIRm9L?=
 =?gb2312?B?Zjlybk0vNGduQTIzay9odXdWMktwdklLRFNyZEIyR0t1RTN3ZFRGdnpsUm1S?=
 =?gb2312?B?TFcrL3NWcHVHN2o5QzV2Z3RON2NPZnBEWmxYazZZT1BxRkJUOW44YnhFWFo3?=
 =?gb2312?B?alBEcXpmTnAzSjdlL0V0VFczT1F1NVNqL1ZmRzNaU2F5dlpxcU1qZEZTTGcx?=
 =?gb2312?B?cmM4RnpRQ3dXR2YvQ3Q0OEt4UXZCdDNnTFFJVUdIdVk1UWRNakVWaU1HeTZM?=
 =?gb2312?B?Q004dzNMWXErUzM3RWs2aVVPaGVaVDhyYjJueTlScHNtci85T0xhelFrY1ZH?=
 =?gb2312?B?WDN5YWQ2MnFISTNROTJXdUN0dUZQVjRzQWpNZDRIQWpFSjhqdGIrSXo4SUFl?=
 =?gb2312?B?UnduSk1uNEQ3R2xYYUNsdTNQUThPSStPbkhWbSsxN0h3TTZ5U3lIanNvMDZk?=
 =?gb2312?B?ZlFWUjRmN1dDV2J4MldiZVBET3NmZ3BzN1RsV0xiTzhkTVJzY3JVTG1Kbkkw?=
 =?gb2312?B?MVRqQ3FXcU9ubUoxQWhSMHlYTEpPeUtWbGlTQkNnN3AvcGpTWWRCYUw1OFlH?=
 =?gb2312?B?TEtSWHF5MVdMWXppNGZ4ZTR1ZFQxQ3l0OXV3R0gzNW9rNG5UWXNjaG9ZK0RQ?=
 =?gb2312?Q?/ATs=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ce7319-11e5-45e0-16d3-08de071f6031
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2025 10:34:07.1667 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VQsm7p2kcVnfXsqi1RnXUyBrmOPOh0VLAYYVHHLzehyjvY0daDRYOu/mgPIRNcuROvAJvnrFsdhZlNg3epmJlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7592
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

PiAtLS0tLdPKvP7Urbz+LS0tLS0NCj4gt6K8/sjLOiBNYXR0aWpzIEtvcnBlcnNob2VrIDxta29y
cGVyc2hvZWtAa2VybmVsLm9yZz4NCj4gt6LLzcqxvOQ6IDIwMjXE6jnUwjI5yNUgMTY6NDcNCj4g
ytW8/sjLOiBBbGljZSBHdW8gKE9TUykgPGFsaWNlLmd1b0Bvc3MubnhwLmNvbT47IFN0ZWZhbm8g
QmFiaWMNCj4gPHNiYWJpY0BuYWJsYWRldi5jb20+OyBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBn
bWFpbC5jb20+OyBkbC11Ym9vdC1pbXgNCj4gPHVib290LWlteEBueHAuY29tPjsgVG9tIFJpbmkg
PHRyaW5pQGtvbnN1bGtvLmNvbT47IFBlbmcgRmFuDQo+IDxwZW5nLmZhbkBueHAuY29tPjsgVHJv
eSBLaXNreSA8dHJveS5raXNreUBib3VuZGFyeWRldmljZXMuY29tPjsgQWRyaWFuDQo+IEFsb25z
byA8YWRyaWFuLmFsb25zb0BueHAuY29tPjsgTHVrYXN6IE1hamV3c2tpIDxsdWttYUBkZW54LmRl
PjsgTWF0dGlqcw0KPiBLb3JwZXJzaG9layA8bWtvcnBlcnNob2VrQGtlcm5lbC5vcmc+OyBNYXJl
ayBWYXN1dCA8bWFyZXhAZGVueC5kZT47DQo+IHRoYXJ2ZXlAZ2F0ZXdvcmtzLmNvbTsgQWxpY2Ug
R3VvIDxhbGljZS5ndW9AbnhwLmNvbT4NCj4gs63LzTogdS1ib290QGxpc3RzLmRlbnguZGUNCj4g
1vfM4jogUmU6IFtQQVRDSCA1LzZdIHVzYjogZHdjMzogZ2FkZ2V0OiBBZGQgZGVsYXkgYWZ0ZXIg
c29mdHdhcmUgd3JpdGVzIERDVEwNCj4gaW4gZHdjM19nYWRnZXRfcnVuX3N0b3AoKQ0KPiANCj4g
SGkgQWxpY2UsDQo+IA0KPiBUaGFuayB5b3UgZm9yIHRoZSBwYXRjaC4NCj4gDQo+IE9uIFN1biwg
SnVsIDIwLCAyMDI1IGF0IDA2OjEzLCAiQWxpY2UgR3VvIChPU1MpIiA8YWxpY2UuZ3VvQG9zcy5u
eHAuY29tPg0KPiB3cm90ZToNCj4gDQo+ID4gRnJvbTogQWxpY2UgR3VvIDxhbGljZS5ndW9Abnhw
LmNvbT4NCj4gPg0KPiA+IFdoZW4gdXNpbmcgTlhQIFVVVSB0byBkb3dubG9hZCBmbGFzaC5iaW4g
dG8gaS5NWDk1IDE5eDE5IGV2ayBib2FyZCwgaXQNCj4gPiB3aWxsIGdldCBzdHVjayBpbiBhIGxv
b3AgYXQgc2RwX2luaXQoKSB3aXRob3V0IHRoaXMgY2hhbmdlLg0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogQWxpY2UgR3VvIDxhbGljZS5ndW9AbnhwLmNvbT4NCj4gDQo+IEkgc2VlIHRoYXQgYSBz
aW1pbGFyIGNoYW5nZSBleGlzdCBpbiB0aGUgTGludXgga2VybmVsOg0KPiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9hbGwvMjAyMjA5MDExOTM2MjUuODcyNy00LXF1aWNfd2NoZW5nQHF1aWNpbmMu
Y29tDQo+IC8NCj4gDQo+IFBsZWFzZSBtZW50aW9uIHRoaXMgY2hhbmdlIGluIHRoZSBjb21taXQg
bWVzc2FnZSBmb3IgdjIuDQo+IFNlZSB0aGUgZm9sbG93aW5nIGV4YW1wbGU6DQo+IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2FsbC8yMDI1MDExMC1kd2MyLWRldi12NC03LTk4N2Y0ZmQ2ZjhiMkBw
aWdtb3JhbC50ZQ0KPiBjaC8NCj4gDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvdXNiL2R3YzMvZ2Fk
Z2V0LmMgfCAxICsNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3
YzMvZ2FkZ2V0LmMNCj4gPiBpbmRleCAyYjAxMTEzZDU0Yy4uNmIyYjI1YzdhYTUgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvdXNi
L2R3YzMvZ2FkZ2V0LmMNCj4gPiBAQCAtMTQyMyw2ICsxNDIzLDcgQEAgc3RhdGljIGludCBkd2Mz
X2dhZGdldF9ydW5fc3RvcChzdHJ1Y3QgZHdjMyAqZHdjLA0KPiBpbnQgaXNfb24sIGludCBzdXNw
ZW5kKQ0KPiA+ICAJfQ0KPiA+DQo+ID4gIAlkd2MzX3dyaXRlbChkd2MtPnJlZ3MsIERXQzNfRENU
TCwgcmVnKTsNCj4gPiArCW1kZWxheSgyKTsNCj4gDQo+IENhbiB5b3UgZWxhYm9yYXRlIG9uIHdo
eSAxbXMgaXMgbm90IGVub3VnaD8NCj4gDQoNCkFwb2xvZ2llcyBmb3IgdGhlIGNvbmZ1c2lvbiB0
aGF0IEkgcHJldmlvdXNseSByZXBsYXkgdGhpcyBlbWFpbCBmcm9tIHRoZSB3cm9uZyBlbWFpbCBh
ZGRyZXNzLg0KDQpIaSBNYXR0aWpzLA0KDQpBcG9sb2dpZXMgZm9yIHRoZSBjb25mdXNpb24gdGhh
dCBJIHByZXZpb3VzbHkgcmVwbGF5IHRoaXMgZW1haWwgZnJvbSB0aGUgd3JvbmcgZW1haWwgYWRk
cmVzcy4NCg0KVGhpcyBwYXRjaCBJIHN1Ym1pdHRlZCB3YXMgaW5kZWVkIGluc3BpcmVkIGJ5IHRo
ZSBjaGFuZ2UgeW91IG1lbnRpb25lZCBpbiB0aGUgTGludXgga2VybmVsLiBUaGUgbWRlbGF5KDIp
IHZhbHVlIHdhcyBkZXRlcm1pbmVkIGVtcGlyaWNhbGx5IGR1cmluZyB0ZXN0aW5nIG9uIG91ciBk
ZXZlbG9wbWVudCBib2FyZC4NCg0KSG93ZXZlciwgYWZ0ZXIgYSBkZWVwZXIgdW5kZXJzdGFuZGlu
ZyBvZiB0aGUgZHJpdmVyLCBJIGJlbGlldmUgdGhlIHJlYWwgcm9vdCBjYXVzZSBpcyB0aGF0IHRo
ZSBVU0IzIFBIWSB3YXMgbm90IHByb3Blcmx5IGluaXRpYWxpemVkLiBXaGVuIERXQzMgaXMgY29u
ZmlndXJlZCB0byBEV0MzX0RTVFNfU1VQRVJTUEVFRCBpbiBkd2MzX2dhZGdldF9zdGFydCgpLCBl
bnVtZXJhdGlvbiBmYWlscyBiZWNhdXNlIHRoZSBQSFkgaXMgbm90IHJlYWR5IGFuZCBjYW5ub3Qg
Y29tcGxldGUgdGhlIGVsZWN0cmljYWwgYW5kIHByb3RvY29sLWxldmVsIGhhbmRzaGFrZSByZXF1
aXJlZCBieSBVU0IgMy4wLiBUaGUgZGVsYXkgYWN0cyBhcyBhIHdvcmthcm91bmQgdG8gY29tcGVu
c2F0ZSBmb3IgdGhlIG1pc3NpbmcgaGFyZHdhcmUgaW5pdGlhbGl6YXRpb24gb3IgdGltaW5nIGlz
c3Vlcy4gT25jZSB0aGUgUEhZIGRyaXZlciAocGh5LWlteDhtcS11c2IuYykgaXMgYWRkZWQgYW5k
IHByb3Blcmx5IGluaXRpYWxpemVzIHRoZSBVU0IzIFBIWSwgdGhlIGRlbGF5IGlzIG5vIGxvbmdl
ciBuZWVkZWQuDQoNClRoZSB1cGRhdGVkIGNoYW5nZXMgYXJlIGluY2x1ZGVkIGluIHRoZSBwYXRj
aCBzZXQgdGl0bGVkICJFbmFibGUgVVNCIGFuZCBFTkVUQyBvbiBpLk1YOTQzIEVWSyIsIHNwZWNp
ZmljYWxseSBpbiBwYXRjaCA2IGFuZCBwYXRjaCA3Og0KaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJz
Lm9yZy9wcm9qZWN0L3Vib290L3BhdGNoLzIwMjUwOTIzLXVzYm5ldGMtdjEtNi01MDdjZGRiZTcy
MTRAb3NzLm54cC5jb20vDQpodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3QvdWJv
b3QvcGF0Y2gvMjAyNTA5MjMtdXNibmV0Yy12MS03LTUwN2NkZGJlNzIxNEBvc3MubnhwLmNvbS8N
Cg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2shDQoNCkJlc3QgcmVnYXJkcywNCkFsaWNlIEd1bw0K
