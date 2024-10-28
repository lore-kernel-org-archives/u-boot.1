Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399D8D5B158
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 21:33:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22C7B8914C;
	Mon, 28 Oct 2024 22:32:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iris-sensing.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iris-sensing.com header.i=@iris-sensing.com header.b="cLcMLrm7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A8EF88D06; Mon, 28 Oct 2024 16:30:59 +0100 (CET)
Received: from FR5P281CU006.outbound.protection.outlook.com
 (mail-germanywestcentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20c::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A77CE8909F
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 16:30:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=iris-sensing.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=erik.schumacher@iris-sensing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZbWG4WavVrEjNL+fYIxjf0GWAWZ2bDvyJmb2gmeN+kvfWXnqBD50rfomK4XlZC0rVO/HBXuQBpiJNV2JI2iqaNxmwXWUID80Rl+BnpnHBIoEkE9YC5r+46SjkZwnja7Fjx8UrqgWzc/Tvgn2QSx6C6hLEIaI7AjYBWnqiY/OHvftcEeuA9KGkhlLwWD9H/xZKmSA3TZGi2tNsDucsJ/pnT86ExFuPkRTU7f46jWkMInf7C/xmuZPKl0WPQo8JWjmslhnoikoW+8fw5m7S0u/3h62VoRw+ao8uTv/JuLQ4aLV6TISYtOiDWNoj2ah7RA65IgWmhh3MIOtZ4yAhhkfDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPACAvmFxoMmRamM+GFtxc/Nj8j7IVuIUGE++A/2hT4=;
 b=n1IrneUBMZQySKWCCUvir1anKNmZ1kmZFD7Nu1X7mrl3phJm6LjgXPxJJdtmHdUfCXi6IClz8puUgE1HvZ8AWzQJSkGG2s80vGukrBoNmwX4KIxU36qgqHlt3tYIwPAzuputj26EgzVqfqjFx8/RPZ3hlJ/T8yakzdWGHiLXNgdREcs6y+nZ2ovlEzLRrvnlGlIhgstuXxOUkK/e2IrnOrnUO0glYwP1/LcOnACCaHy6QZ/oBUUiUH9z8esunyxWIBPevq361CAoCbrqpNzYYBiOx4LV/TQVDGxOJ/GGkVKZkIv7y6i3U3X5LRSUq6WSqupXRn0KHcVwV/YuRKqa5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iris-sensing.com; dmarc=pass action=none
 header.from=iris-sensing.com; dkim=pass header.d=iris-sensing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iris-sensing.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPACAvmFxoMmRamM+GFtxc/Nj8j7IVuIUGE++A/2hT4=;
 b=cLcMLrm7bZC+FE3gaWF+fYR6xLnPpz/E0sgyMqPffgMjFZXsCrDU1ENi7HWNESEzkiGakusGlSr8WklWItxulLZzt/XXJfV+XsecpjmD4zUUZAphok23sCoNS+5hrjnVO+Umxr3bL9Xa0iTqut6CcHyRVQAcr+PxcJpkJqIhf3Owyfmv9wEBvMT3xdzIrHxVsAZv0Ge2B3V+t7ejdmww4Z5KMQ2pOFn3KuBG7CmIQr84q9WtGm5HLn7v1S3Tm+qVKSCk8D4891cp/9taXy04kSLCr9/pSBVrRZD7JT3E8ROFkP+Wjnr5caCrpltUSyMPlPI2bXNoshpUtg1L8SGdEw==
Received: from FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:23::8) by
 FR5P281MB4748.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14d::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.21; Mon, 28 Oct 2024 15:30:56 +0000
Received: from FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d685:f312:e114:519e]) by FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d685:f312:e114:519e%4]) with mapi id 15.20.8093.025; Mon, 28 Oct 2024
 15:30:56 +0000
From: Erik Schumacher <erik.schumacher@iris-sensing.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "pro@denx.de" <pro@denx.de>, "marex@denx.de" <marex@denx.de>,
 "joe.hershberger@ni.com" <joe.hershberger@ni.com>, "rfried.dev@gmail.com"
 <rfried.dev@gmail.com>, Erik Schumacher <Erik.Schumacher@iris-sensing.com>
Subject: [PATCH 3/3] net: dwc_eth_qos: Remove obsolete imx8 includes
Thread-Topic: [PATCH 3/3] net: dwc_eth_qos: Remove obsolete imx8 includes
Thread-Index: AQHbKU5hcGACA+8sSUq+ZFWew5+J1w==
Date: Mon, 28 Oct 2024 15:30:56 +0000
Message-ID: <0b9514e865afb9e1f975339a48846100e4b316c6.camel@iris-sensing.com>
References: <0b4ebdf6a0219a871eb031fccd9aa6d8c9cb2348.camel@iris-sensing.com>
In-Reply-To: <0b4ebdf6a0219a871eb031fccd9aa6d8c9cb2348.camel@iris-sensing.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iris-sensing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR0P281MB2809:EE_|FR5P281MB4748:EE_
x-ms-office365-filtering-correlation-id: 026572b6-f314-42de-02ae-08dcf765844c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|10070799003|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?cVlwNEkxQ3FJVHNnamRsVGh0cUE5dzlnZ0tIRGwxRG9mczRodVNKMW5TSUNF?=
 =?utf-8?B?ckZlOTB3b29jdFhlWGE5V3JWcWdpbUlHbnFUR2xIZ0xDRDlOQUZOVVhxMExY?=
 =?utf-8?B?WjRtNzFDeVA5NUV1M1l6cDIzelFKZk5Pa3VER3U0alZ6NEgyVlduYXpHWjZQ?=
 =?utf-8?B?ckxOZlVKT0tZdERid2hialRhK2tLU0h6My9EbE5sRW1NM2h1WnY0ZEpVNHdV?=
 =?utf-8?B?bGJlZ0JLZy92akpMQ2xzODNTZzVmV2FUNk1Hd3dPbXpTQk1tS29qM0lWWXRr?=
 =?utf-8?B?YjBKQlByeUV5dHBScTB3bEgraU05UkZDb2NPWHNlNndMZGVUQnJUZ3hxVDVz?=
 =?utf-8?B?MVgwN1U1d0R1ZU51Rk83dGl1dHJTa3dZdUtIbDNtNmZPUzYxTG5nT3piMFdw?=
 =?utf-8?B?VlMxN3pFaDc1TFlxSHlkRk5EclE3U2lNWVpua0tYUkl4Rzl5bC85QVRWV3p3?=
 =?utf-8?B?U1pGMXZjT0RKVjg4V0FVL1dLMDdrZm1jbGtzYytrcFhtVjVzTTA5KzVsNGYy?=
 =?utf-8?B?YWUvZjN0TVFlTXdVT1o4QWk1UEd0UkVmbHQwK1ZFMVhSM0g4UkFIR2FQOXNG?=
 =?utf-8?B?cjZSWVFRMHdybjNVdHh2VjkxeFNaeDZsNFFtUkhNWTdQYnZEQlhDUHlzdDNz?=
 =?utf-8?B?WVkxMEJBcmN1S2RNb2E4V2lsTUhwV0xVbGJpUzYzNi9LQ1Jab3NTV1pkK3dE?=
 =?utf-8?B?RnlGeDJJSVQ0bWI3Zi8xeGk2bGEzRGtudjlraVN4ODVJeUVpNHRsNUZQd3Z3?=
 =?utf-8?B?TDNGWFJYUSs2eVJCQ1E1emxnalBKQUdxOVpuU0JkUXpoK0tQVExnQStFaDBs?=
 =?utf-8?B?TkZ0UXJwbjBSNHVqc2k0V0pKSjZUYk9Qd1ZmcmZIaDhlWGYzMDVLVEppcXYw?=
 =?utf-8?B?U2hheDUzb2RHU2d0VmNxZFZ0dGpsRXdaajRQQldHNmZxMm5nTXZHUjZjZjdo?=
 =?utf-8?B?eGFpQk02L1NkaWRqbFFiR0tlUmZRZ2l0bDlDM3ZsR3N4Rkwydm1IOGtuM3NL?=
 =?utf-8?B?cEZxMXhmdGdiRHpDblZFL3UvZ1Z6VHphZHJMVDhuZ05Zd2J0S21YTkRIZG9i?=
 =?utf-8?B?TzRsTDdUbldrN2s0Y05idStJdVE0UjcxQUpBOGJyZHU2WFR6bmV6TmV5SjB5?=
 =?utf-8?B?cVJBRFpBK2xNZ2JEbzdLRWI2emh6ZlJjeVhMNjlaeGZXZ0pwRU5XK2t1SkpW?=
 =?utf-8?B?d3NSdVU4Nit6TlpYb2RsUVRBYVFrc3ZoMmZMSDJHNEdTV0VOTloyUFhob2gv?=
 =?utf-8?B?WmdhSzhYU2wyR3kyT0dJbENDZmxLajhCL1BvRUdjYmozWWpkZG82VGlUYlFW?=
 =?utf-8?B?c1ViY25qRlNNZzBhcHRzd21PcXhwWVdSandXbFVhcGVseGNKVkFXd09FOStR?=
 =?utf-8?B?V0d6Y0lKOFhsTlFWWXdPcldEWklSVzh0NVBScEdPaVhIQmVaYVdwY3RhZ0pJ?=
 =?utf-8?B?cDBaVEFjUEZwajBBRW9WamgyaGgzaVZybStpV3Bpaks2ZEVFZjdsNXJaM0RS?=
 =?utf-8?B?RkIvVm1PT0ozU2MwSGJ5UkxiY1V4STFvelRVbktuOVhKRkVvMkdFQ0hLQTVD?=
 =?utf-8?B?Y00rVE0vSGNZblVDVVhLenVnTDBKb3Vvbi9FbVcrbGR6T2FCNjFFVDgrSHM2?=
 =?utf-8?B?UllwYU4vaGFSMkQ3a3IvYmxTcms4MHVFMStIaEtpQjBZSzQvTkZnSTY4WVZv?=
 =?utf-8?B?NzVhR1k3TEJxUXlEcklrRytMUWhCQlR6cVlKa1VwRHpqcWt6emhOL1dtWDQ0?=
 =?utf-8?B?dzFFN0lmdTRlUEdrZ2RIbWtaRjZabXV0N1NBUGNyaGpaUlR0OUczOXFvS3RM?=
 =?utf-8?Q?oNRSVQjxZNufyAD5ijS27SGswownXVIAoPHUs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFhLQy9CYUxXQ3crNENqTEFLTUh4ZHFoNE9QNVhLVlJoUzBlY0tJSW40Si9B?=
 =?utf-8?B?aVVoNTJtQW9ESjFLNHFMMEtSVW1oeWcvd2IrWTdoZUJZMjBHQ0lNWm12Vm14?=
 =?utf-8?B?ekVkdExiYzB3SmwwRGY5VWtmdmZwNzdVSzFSVzl4OFphbUZWTm5COGFzSEJh?=
 =?utf-8?B?cnB2YSszSytoY2FIeUxoZHVQeXM2OGZFSER4dFlNSXZQbEVPL2pIRGQwNjRO?=
 =?utf-8?B?ODZ5aThqQTJTR3ZrN1JIbU5PSnlkcTBaNS8zSmJkVisya3V5TEdRTkZESjBh?=
 =?utf-8?B?elZVdmFkZWlzUHZLUHFoSWVxdldrWHllQVBYSit2bTlTVzBlSWNKbWpLMmRr?=
 =?utf-8?B?ZWMydGdxNHhsQ0JDZmZmOFRYNWpLcndNVVF5aml0eEVNRlZEdnQvcG1UdjBD?=
 =?utf-8?B?YU8wZ3FtVzZtQ3ZVZTJkSU4wb1ZGazRJM1lYVHNyNGFDdG9Uam15clZ1Q3B5?=
 =?utf-8?B?TENZcTZ0WXNJMjZaQWRWSTdPdFVxd1VLTHRmQTNCdG1LUG52TW00a3lIOE40?=
 =?utf-8?B?SFVUUEp0SjdXcEs4aDlNTWdNZWJJZHRZY2tEcTFVNzhaQzJIeW1xd053SUNo?=
 =?utf-8?B?Z25oSXBkQmZVZ21MTFhxOFZGOVJJR0hrM2I4aE5XT2REdnRab1oxcG9LRTR0?=
 =?utf-8?B?a0RPOHh4ZHJsby9XSEJyYW5xYm15VjhQcGtGYjRPMm5hVk5ra2hNNm4wM2tI?=
 =?utf-8?B?dWhZb1hsbU5LTXR4eForVjJSaDNPV3JBSG1EVkRXeTVkVXl3UVRxSi9rNzY1?=
 =?utf-8?B?S3lsRHJkNkZ3K3ZtQlEzN3hJUW5SckRuQU8raVZ0N0lIdlJHNkRNdVhXeGE2?=
 =?utf-8?B?VnJSdmFoeDVsMEl3V2g2aUM0WUZhQWNvSFlXb1YzWVYxMDcwY2EyRlpQY3lj?=
 =?utf-8?B?K3BPRGFyQ3AvRjlGZS8yczV2bU5rMUd5REFJbUg1MCtCaGNIQXV5S3FJa3Ay?=
 =?utf-8?B?WUhFazVYK2UxOElvWWVXRDd6dFk5WUdTY3lYSWpLQVU3RnZEZmYvY3RkTWw3?=
 =?utf-8?B?VWpqWkxCRW05ckNjMDN3eUE0N0EyOUMxbTFrMGhZMDMrL2dGL3NrMWtaU1Zh?=
 =?utf-8?B?azlPL1pybUppaC9LdzEvMFArLzBTUkNwb285S2pQbjUvclJCTzMxUVROTGVw?=
 =?utf-8?B?MFQvcFZ6RFJtUXZFK3ZGb1hPQ0MyNlJlTjJvVzNCSHAxR2pGTlRXNjNSZzdH?=
 =?utf-8?B?VTVSd242aUtOeXFxeXMzU1JHaDgvZVJzd3pERTZlK3ZhUWhFZlBSMW9tMGJ1?=
 =?utf-8?B?aG1nZCtqcWo0ZW5QQWhWRFcwWmVMMTJYa0Vhd2tnOUF3aVdQQ3lEL2ZBekx4?=
 =?utf-8?B?SGV6WlhBU2tjU0V1ZlNtY2tDUVNIMVhlT3lyQnZzNmhjYncrRGl0UFRYMldV?=
 =?utf-8?B?VCtIdmZsUElvd284Ty82UmhMa2E3OHVnclR1VEpqT1FKdk5kcDU1YTN4TDJq?=
 =?utf-8?B?MzdNbS9uQWw4YS9IZHJESUdnYnFsTU5tWDlHY2FGUkluUzJRYXZXUUxRZmkz?=
 =?utf-8?B?cXNtZTB2Z3JOeHNHWUNJQlZ4dlhZTjU5TFlsN0JrTkJPV0N2U2hmbDVSTDNI?=
 =?utf-8?B?RVhQZm9aN3ltUjNGb1hmSHppaUVYbjQzaDVOMjhwUmxmTHBMR3RjSzd1SXVQ?=
 =?utf-8?B?V1RaMG5yR0tsQUJtTGh4NDBYUnI5cFRoS1A4OGNkVzFwWmxhR2ZBM1hkaS9X?=
 =?utf-8?B?OXM4bDV2WkJCUG9uU21xd2V0UkhIbXhMOWF4WTY4bGF6Z1Z3Z2lESmtUU3Fv?=
 =?utf-8?B?bEhSNnZ5U3ZHYmg5NW1JaDI2eWY4TzBxc1BNc1hZWHY0U0VXY2Vjb3hWU1BS?=
 =?utf-8?B?b2duK2V2WjVXQTdLNkpqZk40aGVyVWc1eGZMT2JVdFdWZ2hBRExWNGZoODlD?=
 =?utf-8?B?Mm9zRDY1VVgyWVpMVWJFOEdaRVRJbTZGUEhGcVVra3dZckpEcTlYclZkSVJU?=
 =?utf-8?B?Mi8wbE1TbEJRcUxLWnlHSHY3YmJrQVdueGppM241MVNyVVh3dWVFcW1MMFlI?=
 =?utf-8?B?SjRybk5QMVhOaWUrcWJOU0pkWC9QbUx5TVRNbXVxdWRJOWl1RkNHckhFOWRm?=
 =?utf-8?B?NkdOZEQrWFZpWXFad2FMaWcwZU96VEVseDg5ZWljUCt2OXg4WSs4S3pTa3Br?=
 =?utf-8?B?ODVzTTdEVDI3aWhOb0NaWFlmVzZ6bENoRjZCVWYyRHZPeTh2Nkx5b25pSld4?=
 =?utf-8?B?cVowek93T002Q3VYYUlmdXB3V05aR3k1cFNCQkNRZVh5R2xuVXFSZ0oxMnRo?=
 =?utf-8?Q?vizUZBoBPTf/rPwl/tFNKGhLJqUknTFZZeyzTtGHIM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <82666AD487A27348BB0BD76CBB69FC80@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: iris-sensing.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 026572b6-f314-42de-02ae-08dcf765844c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 15:30:56.2498 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 963f3913-ffae-43fd-856b-2dfd3f6604e3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YpaKsVHlrrdMxo3B8j2gPBaB4wz+bI1ipm99HEKBFjo9A5a0+Zu3Fw1hJ7hzcdD1SqRcTMOVni3MZpD03wo1PTjvbbdgOA2XOhZ3FHw83McmVaTA9XdSJ/qsOA96B67R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR5P281MB4748
X-Mailman-Approved-At: Mon, 28 Oct 2024 22:32:48 +0100
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

VGhleSB3ZXJlIGFkZGVkIHdpdGggY29tbWl0IDBlOWQyMzk0NWNlMCAoIm5ldDogZXFvczogaW1w
bGVtZW50IGNhbGxiYWtzDQp0byBnZXQgaW50ZXJmYWNlIGFuZCBzZXQgdHhjbGsgcmF0ZSIpIGJ1
dCB3ZXJlIG5vdCByZW1vdmVkIHdpdGgNCmNvbW1pdCA1ZmM3ODNiNWQ5YzkgKCJuZXQ6IGR3Y19l
dGhfcW9zOiBtb3ZlIGkuTVggY29kZSBvdXQiKSB3aGVuIGkuTVgNCnNwZWNpZmljIGNvZGUgd2Fz
IG1vdmVkIHRvIGEgc2VwYXJhdGUgZmlsZS4NCg0KU2lnbmVkLW9mZi1ieTogRXJpayBTY2h1bWFj
aGVyIDxlcmlrLnNjaHVtYWNoZXJAaXJpcy1zZW5zaW5nLmNvbT4NCi0tLQ0KIGRyaXZlcnMvbmV0
L2R3Y19ldGhfcW9zLmMgfCA0IC0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgNCBkZWxldGlvbnMoLSkN
Cg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2R3Y19ldGhfcW9zLmMgYi9kcml2ZXJzL25ldC9k
d2NfZXRoX3Fvcy5jDQppbmRleCBhYjUxYTk4ZTlkLi4yMjc5NDgxZDkzIDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9uZXQvZHdjX2V0aF9xb3MuYw0KKysrIGIvZHJpdmVycy9uZXQvZHdjX2V0aF9xb3Mu
Yw0KQEAgLTQ3LDEwICs0Nyw2IEBADQogI2luY2x1ZGUgPGFzbS9jYWNoZS5oPg0KICNpbmNsdWRl
IDxhc20vZ3Bpby5oPg0KICNpbmNsdWRlIDxhc20vaW8uaD4NCi0jaWZkZWYgQ09ORklHX0FSQ0hf
SU1YOE0NCi0jaW5jbHVkZSA8YXNtL2FyY2gvY2xvY2suaD4NCi0jaW5jbHVkZSA8YXNtL21hY2gt
aW14L3N5c19wcm90by5oPg0KLSNlbmRpZg0KICNpbmNsdWRlIDxsaW51eC9iaXRmaWVsZC5oPg0K
ICNpbmNsdWRlIDxsaW51eC9kZWxheS5oPg0KICNpbmNsdWRlIDxsaW51eC9wcmludGsuaD4NCi0t
IA0KMi40Ny4wDQo=
