Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7CC6C02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 18:59:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22EBF80EE5;
	Thu,  6 Feb 2025 19:58:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="NbqJQZrm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 324F780BAD; Thu,  6 Feb 2025 18:29:33 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::621])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B10A380A55
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 18:29:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Oleksii_Moisieiev@epam.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=slPmORpC0uINZ1P3wxh1x0bOGJBlMXKMJ7a7Kd85TfW0LJvH/qUCPVXTKmlxIiS39hipDHq8Ykk+d8AuT25ZFOgu5ncJiyaNxcXcj2PFT3EWGGTdNsz1XE8GKWBQdw6eXwl5sU/b9QZjVMjC2eGqgKyiBmrzcKgQLnzMAfGF87qlAHUJczE1rzYYnu3KQuUTzAghhYFvtPXeLAPSmqvEKdjAEC5q2icbAh1ks4H1ENUlmcg5EVCJUoJI8In8crZqRV1Cp16G0rgwQXQA3e+xwIoGDI5BvTaMXsTahJNzWX4ip7GPPXSTC4g38S6gHZnrI9HoGvyDlSEUWKj4kWg1Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSaNfSoi4mfp9wkJuS/K74gzlO4GjMmEj3xSojfjPnI=;
 b=vjqrs3LoqMVIw2CMDEHkhdrZdXS46LLAn52NDLyIHwE/0ndTOvfubXzBckNqHzAfytv7AHothmkl+37/cvvHMJE+X3YQvVcpFWemCnZiAHVgKGV6wUf4aT3rKygY48wttPkuGrtoxBVLS6Pq3GP6dIf/MbykORiLCVjV613QykpqVio+W87loPDzDo0BTaXGTCSJr+8rEAWzGtq6AouLghSNHrXZis+aU5LyCti+POMmAVH8b8k7VIhNvusS8be0FYM+7NVn3ctcAcM9hF5esfEmJNEE31ouDZ+qtU0W52nJBW2J2/01fRtwEdq3TgzNkum6zI/iZkj9QeTKLT7Ifw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSaNfSoi4mfp9wkJuS/K74gzlO4GjMmEj3xSojfjPnI=;
 b=NbqJQZrmaj8J5jNB2JYPhFTnr5IAwgyIB45xUhzTeHB+6A8R59vQB0YbgjOgEboC4ti9hY6QlDq7lLLk2GiKs/Dxhol9GBC+dK1t5nhbEj/br4etDuud8VFKieqpUea1z1a1vTyB0L5TMwnOQcSBLtFOPdL6oaLou6h8PQWY3sB9WNT2Dq43GsYUdQfKvkx9PUeZwMcjkIMKvedTSBFrUA1sdnNQfGuYBDOWHMU23Fl9NumG7bKpDZ3SBykXqmTyxj+crSWcpBYPVycr18siiUCmC7rpqzrFvDqUtzgNaCd15ae3UiTJD3fXy1F0yIeuG0nDHJkvmyeZkX29zwQfIQ==
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com (2603:10a6:102:32e::21)
 by AS8PR03MB7703.eurprd03.prod.outlook.com (2603:10a6:20b:402::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 17:29:29 +0000
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc]) by PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc%6]) with mapi id 15.20.8422.010; Thu, 6 Feb 2025
 17:29:28 +0000
From: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To: Tom Rini <trini@konsulko.com>
CC: Simon Glass <sjg@chromium.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, BELOUARGA Mohamed
 <m.belouarga@technologyandstrategy.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Lukasz Majewski <lukma@denx.de>,
 =?utf-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Marjolaine Amate
 <marjolaine.amate@odyssee-systemes.fr>, Matthias Brugger <mbrugger@suse.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peter Robinson
 <pbrobinson@gmail.com>, Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sean Anderson <seanga2@gmail.com>, Stefan
 Roese <sr@denx.de>, Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Subject: Re: [RFC PATCH v1 00/20] Introduce support for Raspberry PI 5.
Thread-Topic: [RFC PATCH v1 00/20] Introduce support for Raspberry PI 5.
Thread-Index: AQHbd7boMg6OKeAhq0iRP9GJxZu6mLM6NqCAgAAEFQCAADW2AIAAArMAgAANFACAAAm3gA==
Date: Thu, 6 Feb 2025 17:29:28 +0000
Message-ID: <51781b4c-69f3-4aa7-9c56-80e79eb0ebe1@epam.com>
References: <cover.1738749764.git.oleksii_moisieiev@epam.com>
 <CAFLszTicLJR6n7WAaAmp5DDnk96gELO=x3qaOCwLCSJ510kKMQ@mail.gmail.com>
 <e190bf7b-a024-4698-8450-2346d5b0531f@epam.com>
 <CAFLszTjh8qd0ycyqafHUaBuBS0Lhgtp0763FUER6PO_QAw4JdQ@mail.gmail.com>
 <5db27eca-7960-463e-9345-46d40d8a3350@epam.com>
 <20250206165440.GE1233568@bill-the-cat>
In-Reply-To: <20250206165440.GE1233568@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epam.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAVPR03MB8946:EE_|AS8PR03MB7703:EE_
x-ms-office365-filtering-correlation-id: ce95fda1-f25e-4602-2720-08dd46d3cf78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?bXNwZ0lTUTBnM3pObzdwQllKR2l1UTljRGtoekE2UThMcVNKNHNqVHNDR3Iv?=
 =?utf-8?B?TFlzV0F2UnNnRWd1bVN1ZXF4OVBCU3I2TFRNRFlZd0VqcDFxS2NOak9Cb0t1?=
 =?utf-8?B?SWh4TStPem9qUExlOHhhak1XcG5nSmViQ1NQQ3drOEUvb09RNW44OE03NEVR?=
 =?utf-8?B?RnpSbVZOckU1dTQ4ZmlEdG1YUElUM0RQNnp3cjlzU2hlYVk0SE42NktSTnhH?=
 =?utf-8?B?L3NpQmdlOWE3QnJPV0ZSMTc3RHlrcW0zY2MzT0ZReHlMZTNZZ1hpMjk5WVh5?=
 =?utf-8?B?cVdGZGdsNFIrK1RjMHFrZWl3R0FyeGxMT2g4UVZscXRyZjhTdXhKUVQ5dFpD?=
 =?utf-8?B?WmFBNk96ZUJpZ2dvZStHUm9QN2hOZER3RUEvTHRubXVtd1NKRDl2ZXlhUXhK?=
 =?utf-8?B?d2RlTFNlTnFMNGhHaUppQjBHWWdPVDAvbXNVMGprSlpjRDlVODZtYzdHV0FJ?=
 =?utf-8?B?bmtLUWUraGhZNW9KM09Ga3ZXRzgwajV5bTVTT3JvYUN1WU5uaEE3TGdZSFBx?=
 =?utf-8?B?Z2dyVHFqQVA3cHZzNXR0dFhaZXE5czNRM010Zk9XeVB6WThvRnlWZEplZmc3?=
 =?utf-8?B?T1RJazdhWmpoNUNETXVDa1FzejZob1pyaEJKZmE5VUlVL3FUTHEvcWxiUUw4?=
 =?utf-8?B?M0tVKzVRc2FNUkRnSDdYZVh6WHFtbGtjb3VPd3FHeGhCN0U3cTNoVkloWnRi?=
 =?utf-8?B?RnFhblVwNk1nWDJCSDZ2c3c1YXIzelZKNko4bU5INnAzdWZRK2dIdFZ4QmJE?=
 =?utf-8?B?WnZvZFRXZ1g0R2JmRXhta2xoQ0lDMEVJK2xMcTd2SXVGdmNtNzV6TmFyWGRQ?=
 =?utf-8?B?Sjc5WWlmTUplcFk2ajdHR01qbU1xVTM3ejFYMWcrRk9IY0RXK0RYc0UzL2tn?=
 =?utf-8?B?ZW84ZEFSelNUeUxVSWtqNEZpRTMwelZXOUhURWlmT2VsVEhWWXE3UlhQNkN2?=
 =?utf-8?B?am9iUkhJbjVtZ1d1dng5NW5QcElDeHZFRjl5MjIzZU5BenA1aDBOT0M4dGlh?=
 =?utf-8?B?TFFNT25CVnc1WUNqYW83YWR1Y2xWYkxZUVIva0xCNG1QZW5uZ0lrd0Y1b1FO?=
 =?utf-8?B?aXZVSzhpVFZLbDJzNE5RWVFPMHhic1k2bXVrZmFsZkhpSitQR1dnUDFqeDZ5?=
 =?utf-8?B?MW56UzdUeE1jMUNISFZKbkYra055YVBBbFVFcEYwUTRjUG14c1JQZ2x2M2li?=
 =?utf-8?B?ci85ay9neCt6VDhldEZYRCticWpnMTFsY1MzbDFnRXQxMjMvY2NuU2JhRCtY?=
 =?utf-8?B?UVVvTjdmdGo4K1lXTCtYNG0rMG5mZDR5RUkvZ1R1L2VPUEZwek1tSzVyWSs4?=
 =?utf-8?B?YkRSL3p0NzdOY25UTlNKa0NnRkJrQWZpeFVmc08wOUZSbGQvVFV2N3ZmRlMv?=
 =?utf-8?B?dXk4MmNpTVBFR2UvQ2ZWSUp5bEczK2ZBeGdrWU5XK3pUVlcvbEFTWWJlbTND?=
 =?utf-8?B?MGFvV0lyMUtqa1dkdW1ZNkZ1UjRPL2Q3eWhUZnZNRktVVkNXMkc2T3ZpTHF0?=
 =?utf-8?B?WmNUODk2YTBocHlGVkp0Q1Zwd3drbDFKakFZS0FqV2xjUVFDb0pxb1NOQm1h?=
 =?utf-8?B?QnZKZmJIWS9LZXVMUTF2cC8xUWhXYWVnUkxCUGk3SnQ2d29yd1JwR1lJbEdS?=
 =?utf-8?B?V3M4MWgzbjdjK3AyV29Wc3FiWnhLd0FFM3ZxazhnTzBhdFR6VytOSnZZTkJS?=
 =?utf-8?B?b1hUTWhoNytvM1E0MnhXYWdlMjFlY3U4cHNtaldsVTVvK3NKR2IwUWo0N1Jk?=
 =?utf-8?B?bzUyWThkRVJjeE9palJBajRFN2Fya0pLeEx1Y0RlNGdaWGVYdTQyWEpVWHhT?=
 =?utf-8?B?clRRWVdBRytBdTk0VjUyaFdWR2o5ZGNweFdHSmRFMXJQS2VzeS96OXdTQW5O?=
 =?utf-8?Q?QbZ3ONGJW2rcc?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAVPR03MB8946.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkVyVDZUTmlncThtZmJqSDJqZzR5V2pJZ1FLMUd1RTg5U1MzdHdqVGU0U0E1?=
 =?utf-8?B?YmJLallDcG92MFVqVUw1U2xHVTB4MkpyU3V2TUhJb1F2V1BzV2JGeHpHaDJR?=
 =?utf-8?B?SHdVWHR1SzFvK0ZKNVdEMEg2YzhzTTlIcndHVjFoeThwRGtwTENuQ1djNitL?=
 =?utf-8?B?WmNsUXRoZkd2NnZRcFBDN3F6RU5aMld3UTMvR05VRHE3SWZrTGY2SWh0ZlNy?=
 =?utf-8?B?SnMwMUVZcy9MbjdUZkFrVkFjaE1ONTZDQlV5U1hPd3VBbDVkQ1ZhdkhYRjFH?=
 =?utf-8?B?dGIzN0Q5UE1BNGxqNzJuMVZZa2RPdEFkWjE4bGlYTWtMcjdVSkQrQVZsTG1v?=
 =?utf-8?B?dWVFdnJ3Yys3WlpiNU1OY0VRS0p3cEtBckpaT0paSkFJS3IwbWc2UjZ4VHJq?=
 =?utf-8?B?VE1kQnMxNEtWM1NQcnhGcGxab0g3YW9meVhYUGYrVU94c0U0MExtSWVjK1JI?=
 =?utf-8?B?U0dTVVVKeVA5aUZyeGczZExYcHc1YXNsVzRsZHorMktqcVN6ZnhuTCt1d20v?=
 =?utf-8?B?cnlxeVZPY0xmczdyZ2VmMTBab2thaEY2NWFoMXhNTWJTc2tnejhCSnNOOExw?=
 =?utf-8?B?ekc0dGtWVEl1WnBCRStDY3ZRa3ZTa3RYYUQycUVTa0xKNTlZbXdWSGpISzda?=
 =?utf-8?B?M3hrSXVoLzdPdXJraTB5cjkzWS9wWW1WRzhWZVQ4ZlpGZzRNc1JVWEY4NHRR?=
 =?utf-8?B?YS9QcWw2dGRKN2tlejhBMDZWOWt0YzlLbFpSR1hnWU9zSFRCMDl0TlRrb0pY?=
 =?utf-8?B?cFI4Ynd2V0preHRsKytFWW1sQVNFSWd1bjduRmx4R0IwSGZ6eGk0NnUzUWxI?=
 =?utf-8?B?Y0JraW5oa0xRRzdhSUtNaUpOekpESUllTGVXU1UvcEU0K0dqeitkc1JjUVc3?=
 =?utf-8?B?ZlBYc3hpaVhUZmgzaDVCS0RDQ3p3cHVZbHkyeUg5VzI5Y1d1Y0xIMnhpOXNl?=
 =?utf-8?B?K0lsU2tMUkdRMzA3SE5jOVNubUlVRUNoUDBEVkswU2tSZnJqU1k4VFJaZnRB?=
 =?utf-8?B?N1FIK252R3JvYTY5eHJYTko2K1JCVkJFUHF6UnNjUThrWXd6bEhsd2RBK1dU?=
 =?utf-8?B?VWNjUko3c2h4eWJJRTFnaVdrSWV3ZUttencyUndLdjhnMXZzZjRURC9SbDhX?=
 =?utf-8?B?MjgxSHorZnY0Z0RjQStLYWFQekI1dXlwdzViM0lQZXB0eWh0UmpBRVVjMkJX?=
 =?utf-8?B?SFZDYi9KaGpIZjI4TGxRNW9qVEN1V01KdEs1ajMzcDI5SGtYZTFPbCtDNjNS?=
 =?utf-8?B?VlA1eng1ckhRM2tMaE1ySWxOWklTUUxHcElnbVBhS0cvVHlJazh6RVQwSFVo?=
 =?utf-8?B?RjFLb3VVS1JwMi9HcFVUVE45MUdRd1NINzdLQ3ZrRVVzSm1jVXBzeStOalJh?=
 =?utf-8?B?VTFCMDR4UGtGalBqZ3BROTRGWGQwOU55K05BZ2tOWXNLWmFicFdmLyt5djlt?=
 =?utf-8?B?dWFEZmQ2aGpCaWVoTEQ2Q1RDS3NSTnM0UllMRFRJZDdHQXFXaFBoeW9uY3ZT?=
 =?utf-8?B?cmc3OGhiWER3MEcwT3dwbDlIWHpYSUoyNVdPbnJaR25GY2R5SXNsVk93Z2FJ?=
 =?utf-8?B?YWhXK29kb0ZvVjZ6QlRtdWZpRUo0SGVZNUhoTzdqbU1TdXFJNExnOWh1ejhn?=
 =?utf-8?B?Z3p5QkVaeDJTNHVZdkQ1dnVWYkRRbkFFY0ljNE9LeHFIczkyd2hkYzFhYklu?=
 =?utf-8?B?UVN4OFZWTVFMQlIyNnhhWFpSb01wTGtOZjU1MmtpM0RHVmFqV2h4NHQva2Ey?=
 =?utf-8?B?Q3l0WWV2eE9EWndKdlhrNmNNWnFjUTV4UkNsMVhka243WlFBY2F1U2ZEbWxU?=
 =?utf-8?B?ckdUMXZtSkhhVFA3TWIvNFVVa2IzcndVV0VHYTljQ0tiUEZyb2dQMXVtUEI5?=
 =?utf-8?B?WGRJWGl2QURudlFIeXRESnkvUnNSMzNjRjJjTHptS3gyMTRIcjduTmRKYllW?=
 =?utf-8?B?dTdVdXJQZjYxMk56UXVtQjlOK1plZEp3WjZLS2tCeDYzWnkyOS9vaFZiUG1C?=
 =?utf-8?B?QWo4MDZveWdhWFN0NVBselhJaGZXVktJMnR5WGtVYVdRWGdlNlpmV3poYlBL?=
 =?utf-8?B?MkZRaGhvSW92RThGT0dRZHdXcGtNUitRVTc3alBZNnRMZHdjVUdjWDMwN21N?=
 =?utf-8?B?ZjF3TWFjRXRqK21hK0oxVnJ5NzlPeGNxQSsrNlNRK3ZnU2FzRDlWTlhURUF3?=
 =?utf-8?B?ZVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AEE6F6A7632B764B86C4825A58261898@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVPR03MB8946.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce95fda1-f25e-4602-2720-08dd46d3cf78
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2025 17:29:28.9094 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GV+XBvSG2Xq7FyJOfxkBVid2mWdexZMipeHGlN3VA6jvK7TLIK8jTALApKdTYv+l2Kn8U5OV5cxZYO0QflrHsWIQaHXux1PzvCBDqsToYmI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7703
X-Mailman-Approved-At: Thu, 06 Feb 2025 19:58:54 +0100
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

DQpPbiAwNi8wMi8yMDI1IDE4OjU0LCBUb20gUmluaSB3cm90ZToNCj4gT24gVGh1LCBGZWIgMDYs
IDIwMjUgYXQgMDQ6MDc6NTNQTSArMDAwMCwgT2xla3NpaSBNb2lzaWVpZXYgd3JvdGU6DQo+PiBI
aSBTaW1vbiwNCj4+DQo+PiBQbGVhc2Ugc2VlIGJlbG93Lg0KPj4NCj4+IE9uIDA2LzAyLzIwMjUg
MTc6NTgsIFNpbW9uIEdsYXNzIHdyb3RlOg0KPj4+IEhpIE9sZWtzaWksDQo+Pj4NCj4+PiBPbiBU
aHUsIDYgRmViIDIwMjUgYXQgMDU6NDYsIE9sZWtzaWkgTW9pc2llaWV2DQo+Pj4gPE9sZWtzaWlf
TW9pc2llaWV2QGVwYW0uY29tPiB3cm90ZToNCj4+Pj4gSGkgU2ltb24uDQo+Pj4+DQo+Pj4+IFBs
ZWFzZSBzZWUgYmVsb3cuDQo+Pj4+DQo+Pj4+IC0tIE9sZXNraQ0KPj4+Pg0KPj4+PiBPbiAwNi8w
Mi8yMDI1IDE0OjMxLCBTaW1vbiBHbGFzcyB3cm90ZToNCj4+Pj4+IEhpIE9sZWtzaWksDQo+Pj4+
Pg0KPj4+Pj4gT24gV2VkLCA1IEZlYiAyMDI1IGF0IDAzOjE1LCBPbGVrc2lpIE1vaXNpZWlldg0K
Pj4+Pj4gPE9sZWtzaWlfTW9pc2llaWV2QGVwYW0uY29tPiB3cm90ZToNCj4+Pj4+PiBUaGlzIHBh
dGNoIHNlcmllcyBwcm92aWRlcyBnZW5lcmljIHN1cHBvcnQgZm9yIFJhc3BiZXJyeSBQSSA1IGlu
DQo+Pj4+Pj4gVS1Cb290IHdpdGggYWRkaXRpb25hbCBoYXJkd2FyZSBkcml2ZXJzLg0KPj4+Pj4+
IFRoZSBmb2xsb3dpbmcgZmVhdHVyZXMgd2VyZSBpbXBsZW1lbnRlZDoNCj4+Pj4+PiAxKSBhZGQg
Z2VuZXJpYyBib2FyZCBjb25maWcgZm9yIFJhc3BiZXJyeSBQSTUgaW5jbHVkaW5nIGRldmljZS10
cmVlDQo+Pj4+Pj4gZmlsZXM7DQo+Pj4+Pj4gMikgYWRkIHN1cHBvcnQgZm9yIFJQMSBjaGlwIHdp
dGggYWRkaXRpb25hbCBoYXJkd2FyZTsNCj4+Pj4+PiAzKSBhZGQgc3VwcG9ydCBmb3IgcnAxLWNs
b2NrIGRyaXZlciB3aXRoIGR0LWJpbmRpbmdzIHVwZGF0ZTsNCj4+Pj4+PiA0KSBQQ0lFIEJSQ01T
VEIgZHJpdmVyIHN1cHBvcnQgZm9yIFJhc3BiZXJyeSBQSSA1Ow0KPj4+Pj4+IDUpIGFkZCBjbG9j
ay9yZXNldC9ncGlvIGRyaXZlcnM7DQo+Pj4+Pj4gNikgYWRkIGV0aGVybmV0IHN1cHBvcnQgaW4g
dS1ib290Lg0KPj4+Pj4+DQo+Pj4+Pj4gVGhpcyBwYXRjaC1zZXJpZXMgaW50cm9kdWNpbmcgdGhl
IGJhc2ljIHNldCBvZiBzdXBwb3J0ZWQgZHJpdmVycyBpbg0KPj4+Pj4+IFUtQm9vdCB3aGljaCBh
bGxvd3MgdXNpbmcgc3VjaCBmZWF0dXJlcyBhcyB0ZnRwIGFuZFxvciBORlMuDQo+Pj4+Pj4gSSd2
ZSBwb3N0ZWQgdGhpcyBwYXRjaCBzZXJpZXMgYXMgUkZDIGJlY2F1c2Ugb2YgdGhlIGZvbGxvd2lu
ZyBjb21taXQ6DQo+Pj4+Pj4gZTUxY2EwZDIyMSAoSEFDSzogZHJpdmVyczogbWZkOiBzZXQgYmFy
IGNvbmZpZ3VyYXRpb24gZm9yIFJQMSBkcml2ZXIsIDIwMjQtMDUtMjEpDQo+Pj4+PiBXaGVyZSBp
cyB0aGF0IGNvbW1pdD8NCj4+Pj4gVGhpcyBjb21taXQgaXMgcGFydCBvZiB0aGUgcGF0Y2ggc2Vy
aWVzLiBIZXJlIGlzIGRpcmVjdCBsaW5rOg0KPj4+Pg0KPj4+PiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy91LWJvb3QvY292ZXIuMTczODc0OTc2NC5naXQub2xla3NpaV9tb2lzaWVpZXZAZXBhbS5j
b20vVC8jbTIxY2YyMzk4OWZiMDhjYjY1NWUyNWIxYTJkMDgyNjMyYjZmODY1YzkNCj4+Pj4NCj4+
Pj4+PiBJdCBpbmNsdWRlcyBIQUNLIGZvciBycDEgZHJpdmVyIGluIHUtYm9vdC4gVGhpcyBIQUNL
IGlzIHNldHRpbmcgYmFyDQo+Pj4+Pj4gYWRkcmVzcyBpbiB0aGUgY29ycmVjdCBvcmRlciBiZWNh
dXNlIFJQMSBkcml2ZXIgaW4gTGludXggS2VybmVsIHJlbHkgb24NCj4+Pj4+PiB0aGUgcGNpIEJB
UiBjb25maWd1cmF0aW9uIHdoaWNoIGluaXRpYWxpemVzIEJBUnMgYmFzZWQgb24gQkFSIHNpemUu
DQo+Pj4+Pj4gVGhpcyByZXN1bHRzIHRoZSBMaW51eCBzZXQgQkFScyBpbiB0aGUgc2FtZSBvcmRl
ciBvbiBlYWNoIGJvb3QuDQo+Pj4+Pj4gVS1ib290IGRvZXMgaW5pdGlhbGl6YXRpb24gd2l0aG91
dCBhbnkgc29ydGluZyBzbyB0aGUgY29uZmlndXJhdGlvbg0KPj4+Pj4+IG1heSBiZSBkaWZmZXJl
bnQgZnJvbSB0aGUgTGludXgga2VybmVsLg0KPj4+Pj4+IEJBUiBhZGRyZXNzIGNvbmZpZ3VyYXRp
b24gaXMgc2V0IHRvIG1hdGNoIHRoZSBMaW51eCBLZXJuZWwgb3JkZXINCj4+Pj4+PiB0byBhdm9p
ZCBmYWlscyBvbiBhZGRyZXNzIHRyYW5zbGF0aW9uLg0KPj4+Pj4+DQo+Pj4+Pj4gVGhpcyBzaG91
bGQgYmUgY2hhbmdlZCBhZnRlciB1cHN0cmVhbWluZyBSUDEgZHJpdmVyIHRvIHRoZSBMaW51eCBr
ZXJuZWwNCj4+Pj4+PiBtYWlubGluZS4NCj4+Pj4+Pg0KPj4+Pj4+IFByb2JhYmx5IHNvbWVib2R5
IGZyb20gUmFzcGJlcnJ5IHdpbGwgcG9zdCBhbiBhZHZpc2UgYWJvdXQgaG93IHRoaXMNCj4+Pj4+
PiBjYW4gYmUgcHJvcGVybHkgZG9uZS4NCj4+Pj4+ICsxDQo+Pj4+Pg0KPj4+Pj4+IFUtQm9vdCBz
dXBwb3J0IGZvciBSYXNwYmVycnkgUEkgNSB3YXMgYWRkZWQgaW4gdGVybXMgb2YgdGhlIGZvbGxv
d2luZw0KPj4+Pj4+IHByb2plY3Q6IGh0dHBzOi8vZ2l0aHViLmNvbS94ZW4tdHJvb3BzL21ldGEt
eHQtcHJvZC1kZXZlbC1ycGk1DQo+Pj4+Pj4gVGhpcyBpcyB4ZW4tYmFzZWQgZG9tMGxlc3Mgc3lz
dGVtIG9uIHRoZSBSYXNwYmVycnkgUEkgNSB3aXRoIFplcGh5ciBhcw0KPj4+Pj4+IENvbnRyb2wg
RG9tYWluIGFuZCBMaW51eCBpcyBEcml2ZXIgRG9tYWluLg0KPj4+Pj4+DQo+Pj4+Pj4gSXQgaXMg
WW9jdG8tYmFzZWQgc28gaXQgd2lsbCBiZSBlYXN5IHRvIGJ1aWxkIGl0IG9uIHlvdXIgc2lkZS4g
UGxlYXNlDQo+Pj4+Pj4gdmlzaXQgbGluayBmb3IgdGhlIGRldGFpbHMuDQo+Pj4+PiBJIHRyaWVk
IHRvIGFwcGx5IHRoaXMgYnV0IEkgZ2V0IGEgbG90IG9mIGNvbmZsaWN0cy4gQ2FuIHlvdSBwbGVh
c2UNCj4+Pj4+IGFkdmlzZSB3aGF0IHRyZWUgaXQgaXMgYmFzZWQgb24/DQo+Pj4+IFlvY3RvIGJ1
aWxkIHVzaW5nIHRoZSBmb2xsb3dpbmcgcmVwbzoNCj4+Pj4NCj4+Pj4gaHR0cHM6Ly9naXRodWIu
Y29tL3hlbi10cm9vcHMvdS1ib290L3RyZWUvcnBpNS0yMDI0LjA0LXh0DQo+Pj4+DQo+Pj4+IEl0
IGlzIGJhc2VkIG9uIHRoZSA3LTggbW9udGggb2xkIG1hc3Rlci4gSSBkaWRuJ3QgZG8gYW55IHJl
YmFzZSBvbiB0aGUNCj4+Pj4gdG9wIGJlY2F1c2UNCj4+Pj4NCj4+Pj4gaXQncyB1bmNsZWFyIGlm
IHRoZXNlIGNoYW5nZXMgd2lsbCBnbyB0byB1cHN0cmVhbS4NCj4+Pj4NCj4+Pj4gU28gSSd2ZSBw
b3N0ZWQgUkZDIGJlZm9yZSBtYWtpbmcgc2lnbmlmaWNhbnQgY2hhbmdlcy4NCj4+PiBJZiB0aGVz
ZSBhZGQgbW9yZSBzdXBwb3J0IGZvciBycGk1IHlvdXIgcGF0Y2hlcyB3b3VsZCBkZWZpbml0ZWx5
IGJlIHdlbGNvbWUuDQo+Pg0KPj4gSWYgY29tbXVuaXR5IGFjY2VwdGluZyBpdCBJIHdpbGwgcHJv
Y2VlZCB3aXRoIHJlYmFzZSB0byB0aGUgbGF0ZXN0DQo+PiBtYXN0ZXIgYW5kIHBvc3QNCj4+DQo+
PiB2Mi4gQnV0IHRoZXJlIGFyZSBzdGlsbCBxdWVzdGlvbnMgYWJvdXQgIkhBQ0siIGFuZCByZWdh
cmRpbmcgZGV2aWNlLXRyZWUNCj4+IGJpbmRpbmdzIHdoaWNoDQo+Pg0KPj4gc3RpbGwgd2VyZW4n
dCB1cHN0cmVhbWVkIGJ5IFJhc3BiZXJyeSB0byB0aGUgTGludXgga2VybmVsLiBTbyBJJ20gYXNr
aW5nDQo+PiB0aGUgY29tbXVuaXR5IGlmDQo+Pg0KPj4gZHQtYmluZGluZ3MgdGhhdCBjb3VsZCBi
ZSBjb21wbGV0ZWx5IGNoYW5nZWQgaW4gZnV0dXJlIGFyZSBhY2NlcHRhYmxlIGF0DQo+PiBsZWFz
dCBmb3Igbm93Lg0KPiBTbyBsb25nIGFzIHlvdSdyZSB3aWxsaW5nIHRvIHVwZGF0ZSB0aGUgYmlu
ZGluZ3Mgd2hlbiB1cHN0cmVhbSBQaQ0KPiBwcm9wZXJseSB1cHN0cmVhbXMgdGhlbSwgeWVzLiBU
aGFua3MuDQo+DQpIaSBUb20sDQoNCkkndmUgZXhwZWN0ZWQgdGhhdC4gSG9waW5nIHRoYXQgc29t
ZWJvZHkgZnJvbSBSYXNwYmVycnkgd2lsbCBhcHBlYXIuDQoNCkFueXdheSBJIHRoaW5rIHRoaXMg
c2VyaWVzIGlzIHRoZSBnb29kIGJhc2UgdG8gc3RhcnQgZGlzY3Vzc2lvbnMuDQoNCk9sZWtzaWku
DQo=
