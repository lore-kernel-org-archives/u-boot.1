Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9EBFC4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 08:18:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D05286F1C;
	Wed, 29 Nov 2023 09:18:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5Kf70nRZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FDD986F1F; Wed, 29 Nov 2023 09:18:21 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::624])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A647869CA
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 09:18:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYtlgm8WzREcRWoRebX1+dMUhxA36qNP+LNtfjn1DbhbGazduOM2R5xGDhvZhBlHq99nRBo/gwslDYelOLWnVO3/DPsDIZNUW93QuQszOsscgo2T0W1mAyGbNcCPeBpxuQvnRNUHIy06hctXENbvvpFDdVj/oit+uH+kpsUyH9Vq9eZxZIvM26wMEppp2h5epzG4xR2dsreYr4XhUdyeJnum8XKaNRJhoUFwCFGVZY+otCWJt+swkai5FkJlpEHHFrM0RIRlY7gEYDbnuOaTG4D+jlU1bq+dcjSsc96dAj0sc5MSLY8NUUW5843Ui93e96+ToC2QMZIsYEJXRylZ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3RKpCrTYx+FP5eh6Jy4eMIQQGwnmM8UigcNODdB66yY=;
 b=H1xWA53c7i0HcBGKN4zPJznNZNZghSudMJxYXLM+TK37AnAFSWuh4DSwp+tKi6baZw5CfzAFow9OaKa9VScnqJ18ABMmn1/xGvtrk1tZ+A+IKKyTI2nAKtVswhnsruZfWUTuqhDZxD+HLfs5p402GMVOwpu+t5uXUdMWuSdjXAnwXSVICXV1IfVVj1+WS4idIX/R/wHYS1XCIR49FCuc1UHJxxQAyi+E9AIxM0lBbgSQw5g5YvpzPVAEEGNzN8XnolopArJ/SW/D+pKkXAec6AYOdjPAoNt7NjtZIKOAVclpPI88cXh4OcBYlfgzpQ4HS7sSM9F0werrYp91HvjipA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RKpCrTYx+FP5eh6Jy4eMIQQGwnmM8UigcNODdB66yY=;
 b=5Kf70nRZETHiUuG7yoCx5QCrCvuuQpTXr2xhUAyKX/RMyIUcDvh9mSxlfZd+89CyK8i7I3xed70admhz1x0qboof/ri3flFE2WS8i7Lq4853xf+Jo9ycM6RtXwCgUx9QCo6kPr5ovpkdOaKMiPZ51nU5+wg295tCRdTyODb4RQc=
Received: from SA0PR12MB4461.namprd12.prod.outlook.com (2603:10b6:806:9c::22)
 by MN0PR12MB5835.namprd12.prod.outlook.com (2603:10b6:208:37a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Wed, 29 Nov
 2023 08:18:10 +0000
Received: from SA0PR12MB4461.namprd12.prod.outlook.com
 ([fe80::b0e8:702a:bb63:c606]) by SA0PR12MB4461.namprd12.prod.outlook.com
 ([fe80::b0e8:702a:bb63:c606%7]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 08:18:09 +0000
From: "Kumar, Love" <love.kumar@amd.com>
To: Mayuresh Chitale <mchitale@ventanamicro.com>, Jagan Teki
 <jagan@amarulasolutions.com>, "Simek, Michal" <michal.simek@amd.com>
CC: Mayuresh Chitale <mchitale@ventanamicro.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH v2 1/3] drivers: xilinx_spi: Use udevice in start_tranfer
Thread-Topic: [PATCH v2 1/3] drivers: xilinx_spi: Use udevice in start_tranfer
Thread-Index: AQHaIpxVapRES2zJqE+MI+Lsd6KPog==
Date: Wed, 29 Nov 2023 08:18:09 +0000
Message-ID: <SA0PR12MB44618467B31528B4102674068383A@SA0PR12MB4461.namprd12.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR12MB4461:EE_|MN0PR12MB5835:EE_
x-ms-office365-filtering-correlation-id: f98c282a-1301-40a8-96f2-08dbf0b3b8e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +NXQf6RBTugZepWV6sf8/FHscjmcLoQwziqzvDogpkyMdZSry5gPlkaHFZ+NqDiAPKWt25pIhCVM+LDD8IJODV+gbFZPZRtDDinaGWfWcUDQG8rAD+nJNJxDdrWkeCslA1YQr/g6h71t0tqO1lpePBZk682+iosloSjyPbrSAgdcHim/NNsNJUMSf5u8wSAUT39GlpVAA2kxFZa/ZLZBWJVemrPUWTyHY7yVGfHgAgytjTb/swDCzckEnbDn7Ysb1dv8e9t4dbZGgnmgQjaf3Inn2PL6/LsvPFGsoSGcQYv+Trq0/5FV8fNs8gjnQ8FUiYwzOJsb7EGP/07M4vSwalBVIRLtHMQCgPbG6zkAk48RfS2dunMApe2u0SDienRwJQ4sJp7khij9Lx7jRvLWgn0kZ7KV86FRK3iMAky0mE3Ed6GIqJSTZctKizooHZoKpFmyU0DndyXXuzlAxyJ1UchOwHKJ3NhajediKLOHHt5CU/qOKKj6Te4xABlVHFk2qSYIdnEQ2tj6P+fRW2cx3LKdRX6FCt52X4DAHGE4j9PVWXp+xJPaUq922Uo6uJUEcXl3KKMO7Iv8yMzPQatwb9bEnPoUsy4Ea5yrRVxUmJM2mD1tuM32/rlwrhqZI5LWUaAKsYdZMrNe5rAURbu6shCHUKN7zgsI5sLt4QZpons=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4461.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(230173577357003)(230273577357003)(1800799012)(451199024)(64100799003)(186009)(41300700001)(55016003)(2906002)(52536014)(64756008)(8676002)(8936002)(4326008)(6506007)(7696005)(86362001)(71200400001)(9686003)(53546011)(316002)(6636002)(66946007)(66476007)(38070700009)(66556008)(5660300002)(66446008)(54906003)(26005)(110136005)(33656002)(83380400001)(478600001)(76116006)(38100700002)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THVkWlV5dTZVaGRtdzZueTNmT0ZVT1pVWmxIZUlzSlJHZHJqRURHSkd2cEVW?=
 =?utf-8?B?OEtkaVBveTErcW91N0ZQQkxicnB2dzZ6S1ZQc0VMV2E3bk14RVZvTXlsdkFR?=
 =?utf-8?B?bFdhU2FuQ0cxcmx2ZWl1S250OE9XSkNYdkhJMjUrTWVVNVNieFN1WkdsZDRj?=
 =?utf-8?B?cDZaZXRrTlFQR3c1dlpPb3BKSDRrUWRUd2ZNK0EyRGEvZFI4ZUpzMmdxS3J5?=
 =?utf-8?B?RStXekdFRDVEcTUwV2FDTytZTGdrZ1p2eVp0SEs1cCtaUWFDbThnQ0FHMVRu?=
 =?utf-8?B?T3VWSzZ1SHZnTmFtM2V0N2llTzQvRkNzcG9OWE1jTzJ6c1UrVGFmWitiTm40?=
 =?utf-8?B?a21YQmJibmZkWTMvMzQzUFJ5QzAycGlKZGlraEQ1UkdzcDc3TitJWHRiKy92?=
 =?utf-8?B?QTdXZzFYZGxQWmg3czgzdkhGaEcyUW1QTE5iMUx2dnVWYjRUOWMra1BxUWRu?=
 =?utf-8?B?UlEvTGFZRVIveVI5UTJHT0hNNEIxY3hWcHNiUjlyYjhkSVlRVjJPT1pYSW9R?=
 =?utf-8?B?QUlNRURzVTVJWmxkVndpRTZmelYvZFFlZjBXcXVkemNnL2liSHlPR0o4YTE2?=
 =?utf-8?B?VWQxdDhIQnMyZ1QxazZKRzRDZ3RUVm0yczBINi9DYmViM0ZLQnNYekFDcFNU?=
 =?utf-8?B?UUpyYVcweE9YcmhMdklLL0J5V2l1WWI3ZFQyd1NITXdqZTdtalFEUHRoOWlr?=
 =?utf-8?B?SmdUOGxybmVyNURPa1dWLzdFTzVVTzdhYVptZjNEcDZHYUJvRXVXK1VUa1B6?=
 =?utf-8?B?Wm9FMWcyc1FvWVFLQUlkRGFLZWNxUjJzMmlzc0ZTazkrQzBvWHdOazd4dHls?=
 =?utf-8?B?UTBXak4vcllSdTBCOXVteWRSN1RHUno0M0k2U0dqT1diajdPR09SQ2dRT09h?=
 =?utf-8?B?MUN4MHRuSjQ4OWVibzdkMDNEMCtONDBCa0k5Z2o4QnlOMmFWR2NXVlAza1dI?=
 =?utf-8?B?WFFYZ0VmWVd4SFlodDFBbDdqZDB0dkhVemthekNnblZWS2ZNb3h1NFhxYkhE?=
 =?utf-8?B?S1R5LzNuWDNINkx3MDJacEhIN0Q4SEJiQ1ByVnVQVlJXYk5SdUxuQU9oaitK?=
 =?utf-8?B?MjVuY2kxdG5GRHp0TGlZTmloK1pmRllpZXBZWEdocER1YkFnZWZQeUFqYjlL?=
 =?utf-8?B?Qk53eTR1bXk2WEZUVG5wbVMvTW9QNGZ5bS95Rzc5VzZoVWFxM3piSFN6cGxm?=
 =?utf-8?B?QWpnd1cxSmVVNjhjUnVoT2hpVSsyaWx0MklvajFIUlo1REJHRnRoZ0lpMk5l?=
 =?utf-8?B?azYwUHljRkYwOFc0Um1KV1lheTNaQVNITzhaOU1PV3EvZDFQM0ZqRXc2RHpE?=
 =?utf-8?B?dTBWY3RtbkdqNkRUL0x3MFBnZndqOGJwNHRYdGVFWmFXdlR1Njk1OGo2MlE0?=
 =?utf-8?B?aExRZHhhTzR6d21MbkdHTStmNER5ckhmU0JDcmJneGdtMGtXYVRrTU4va2Zp?=
 =?utf-8?B?YjNUT25tbEwvYnI1L25SeWtHU0crTHJuSEt5ZGlGWHVZYWFUZFlYc0djOGRi?=
 =?utf-8?B?N2xBcWlnOHFNVkl1SXVaTngwSTZwVEZpSWZFUFk5RE92OXp2YzZCdGxjL1hG?=
 =?utf-8?B?eTRvTW1GYjM4N014WEJsdkh5YWFSSTEwUC9QbWlkYXNTM1RZOEptNi92aGc1?=
 =?utf-8?B?NHEwL1dHM0k4NFp5QUdKczJPaGVHYTBMMmFCbDB6K2ZaWUJ4WHpvcnJBSGI4?=
 =?utf-8?B?aFZ2MzVaWDNlWXRJZ1c5NC9EQTJjdzlyWmh5THpMRW1ZOUlnYXhXaC9QK3JO?=
 =?utf-8?B?KzFXYStGSWN2dVNRRGhHb0taL0dBY0ZTeE5kZTJPSTNxTDc5YzJFWVU0MjVy?=
 =?utf-8?B?OWJXckQ4M2FjcjkwQWxEK0pPYk1OL3h4MW1oUzViZnV1MFhoUC9OSTU5QVJK?=
 =?utf-8?B?RjVFOHgrZW5JU2ViazRWSFJpZE1sYjAxSjNBMkQvbG9rTEFZZEJ1Y05RTE9B?=
 =?utf-8?B?N2ZaQ1VTWjhpSXQvOTNzNHRRSnd1TERTT2ZLNytSSzN0UVo1T3p5SVM3UHVK?=
 =?utf-8?B?eHgrdldCNHo5NUc5K0xwZnlKdEdpMjhIVlNsWnhyTEtlMHRtbGxWZmlhUkJk?=
 =?utf-8?B?MzZyRUREYTcrK1NHeTZ6aFcxazdlcURWMFc3MzRZUmpwbTZnTGxFNmhnTmw1?=
 =?utf-8?Q?i9Eoh09lOLY6s//WWnFOYAWVm?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4461.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f98c282a-1301-40a8-96f2-08dbf0b3b8e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2023 08:18:09.4758 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MXNnH6SyPiZKxTBToWBxa3fgTfQ6WYg7SJgHZg1VOfdNqlzEGpARoQWZNvJwwzAD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5835
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

VGVzdGVkLWJ5OiBMb3ZlIEt1bWFyIDxsb3ZlLmt1bWFyQGFtZC5jb20+DQoNCk9uIDE2LzExLzIz
LCAxMDoxM+KAr1BNLCAiVS1Cb290IiA8dS1ib290LWJvdW5jZXNAbGlzdHMuZGVueC5kZT4gd3Jv
dGU6DQpNb2RpZnkgc3RhcnRfdHJhbnNmZXIgYW5kIHJlbGF0ZWQgZnVuY3Rpb25zIHRvIHRha2Ug
YSB1ZGV2aWNlIHBhcmFtZXRlcg0KYXMgaW5wdXQgaW5zdGVhZCBvZiBzcGlfc2xhdmUuIFRoaXMg
aXMgbmVlZGVkIHNvIHRoYXQgc3RhcnRfdHJhbnNmZXIgY2FuDQpiZSB1c2VkIGRpcmVjdGx5IHZp
YSB0aGUgeGZlciBjYWxsYmFjay4gQWxzbyBmaXggYSBjb21waWxlciB3YXJuaW5nLg0KDQpTaWdu
ZWQtb2ZmLWJ5OiBNYXl1cmVzaCBDaGl0YWxlIDxtY2hpdGFsZUB2ZW50YW5hbWljcm8uY29tPG1h
aWx0bzptY2hpdGFsZUB2ZW50YW5hbWljcm8uY29tPj4NCi0tLQ0KZHJpdmVycy9zcGkveGlsaW54
X3NwaS5jIHwgMzIgKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0NCjEgZmlsZSBjaGFu
Z2VkLCAxNiBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvc3BpL3hpbGlueF9zcGkuYyBiL2RyaXZlcnMvc3BpL3hpbGlueF9zcGkuYw0KaW5kZXgg
YjU4YTNmNjMyYS4uZDlmYWNlZWMxOCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvc3BpL3hpbGlueF9z
cGkuYw0KKysrIGIvZHJpdmVycy9zcGkveGlsaW54X3NwaS5jDQpAQCAtNjcsNyArNjcsNyBAQA0K
LyogU1BJIFNsYXZlIFNlbGVjdCBSZWdpc3RlciAoc3Bpc3NyKSwgWzFdIHAxMywgWzJdIHAxMyAq
Lw0KI2RlZmluZSBTUElTU1JfTUFTSyhjcykgICAgICAgICAgICAgICAgICAgICAgICAgICAgICgx
IDw8IChjcykpDQojZGVmaW5lIFNQSVNTUl9BQ1QoY3MpICAgICAgICAgICAgICAgICB+U1BJU1NS
X01BU0soY3MpDQotI2RlZmluZSBTUElTU1JfT0ZGICAgICAgICAgICAgICAgICAgICAgICB+MFVM
DQorI2RlZmluZSBTUElTU1JfT0ZGICAgICAgICAgICAgICAgICAgICAgICh+MFUpDQoNCi8qIFNQ
SSBTb2Z0d2FyZSBSZXNldCBSZWdpc3RlciAoc3NyKSAqLw0KI2RlZmluZSBTUElTU1JfUkVTRVRf
VkFMVUUgICAgIDB4MGENCkBAIC0yMTcsOSArMjE3LDkgQEAgc3RhdGljIHUzMiB4aWxpbnhfc3Bp
X3JlYWRfcnhmaWZvKHN0cnVjdCB1ZGV2aWNlICpidXMsIHU4ICpyeHAsIHUzMiByeGJ5dGVzKQ0K
ICAgICAgICAgICAgICAgIHJldHVybiBpOw0KfQ0KDQotc3RhdGljIGludCBzdGFydF90cmFuc2Zl
cihzdHJ1Y3Qgc3BpX3NsYXZlICpzcGksIGNvbnN0IHZvaWQgKmRvdXQsIHZvaWQgKmRpbiwgdTMy
IGxlbikNCitzdGF0aWMgaW50IHN0YXJ0X3RyYW5zZmVyKHN0cnVjdCB1ZGV2aWNlICpkZXYsIGNv
bnN0IHZvaWQgKmRvdXQsIHZvaWQgKmRpbiwgdTMyIGxlbikNCnsNCi0gICAgICAgICAgICAgICBz
dHJ1Y3QgdWRldmljZSAqYnVzID0gc3BpLT5kZXYtPnBhcmVudDsNCisgICAgICAgICAgICAgIHN0
cnVjdCB1ZGV2aWNlICpidXMgPSBkZXYtPnBhcmVudDsNCiAgICAgICAgICAgICAgICBzdHJ1Y3Qg
eGlsaW54X3NwaV9wcml2ICpwcml2ID0gZGV2X2dldF9wcml2KGJ1cyk7DQogICAgICAgICAgICAg
ICAgc3RydWN0IHhpbGlueF9zcGlfcmVncyAqcmVncyA9IHByaXYtPnJlZ3M7DQogICAgICAgICAg
ICAgICAgdTMyIGNvdW50LCB0eGJ5dGVzLCByeGJ5dGVzOw0KQEAgLTI1OSwxMCArMjU5LDkgQEAg
c3RhdGljIGludCBzdGFydF90cmFuc2ZlcihzdHJ1Y3Qgc3BpX3NsYXZlICpzcGksIGNvbnN0IHZv
aWQgKmRvdXQsIHZvaWQgKmRpbiwgdTMNCiAgICAgICAgICAgICAgICByZXR1cm4gMDsNCn0NCg0K
LXN0YXRpYyB2b2lkIHhpbGlueF9zcGlfc3RhcnR1cF9ibG9jayhzdHJ1Y3Qgc3BpX3NsYXZlICpz
cGkpDQorc3RhdGljIHZvaWQgeGlsaW54X3NwaV9zdGFydHVwX2Jsb2NrKHN0cnVjdCB1ZGV2aWNl
ICpkZXYpDQp7DQotICAgICAgICAgICAgICAgc3RydWN0IGRtX3NwaV9zbGF2ZV9wbGF0ICpzbGF2
ZV9wbGF0ID0NCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBkZXZfZ2V0X3BhcmVudF9wbGF0KHNwaS0+ZGV2KTsNCisgICAgICAg
ICAgICAgIHN0cnVjdCBkbV9zcGlfc2xhdmVfcGxhdCAqc2xhdmVfcGxhdCA9IGRldl9nZXRfcGFy
ZW50X3BsYXQoZGV2KTsNCiAgICAgICAgICAgICAgICB1bnNpZ25lZCBjaGFyIHR4cDsNCiAgICAg
ICAgICAgICAgICB1bnNpZ25lZCBjaGFyIHJ4cFs4XTsNCg0KQEAgLTI3MCwxMyArMjY5LDEzIEBA
IHN0YXRpYyB2b2lkIHhpbGlueF9zcGlfc3RhcnR1cF9ibG9jayhzdHJ1Y3Qgc3BpX3NsYXZlICpz
cGkpDQogICAgICAgICAgICAgICAgKiBQZXJmb3JtIGEgZHVtbXkgcmVhZCBhcyBhIHdvcmsgYXJv
dW5kIGZvcg0KICAgICAgICAgICAgICAgICogdGhlIHN0YXJ0dXAgYmxvY2sgaXNzdWUuDQogICAg
ICAgICAgICAgICAgKi8NCi0gICAgICAgICAgICAgICBzcGlfY3NfYWN0aXZhdGUoc3BpLT5kZXYs
IHNsYXZlX3BsYXQtPmNzKTsNCisgICAgICAgICAgICAgIHNwaV9jc19hY3RpdmF0ZShkZXYsIHNs
YXZlX3BsYXQtPmNzKTsNCiAgICAgICAgICAgICAgICB0eHAgPSAweDlmOw0KLSAgICAgICAgICAg
ICAgIHN0YXJ0X3RyYW5zZmVyKHNwaSwgKHZvaWQgKikmdHhwLCBOVUxMLCAxKTsNCisgICAgICAg
ICAgICAgIHN0YXJ0X3RyYW5zZmVyKGRldiwgKHZvaWQgKikmdHhwLCBOVUxMLCAxKTsNCg0KLSAg
ICAgICAgICAgICAgIHN0YXJ0X3RyYW5zZmVyKHNwaSwgTlVMTCwgKHZvaWQgKilyeHAsIDYpOw0K
KyAgICAgICAgICAgICAgc3RhcnRfdHJhbnNmZXIoZGV2LCBOVUxMLCAodm9pZCAqKXJ4cCwgNik7
DQoNCi0gICAgICAgICAgICAgICBzcGlfY3NfZGVhY3RpdmF0ZShzcGktPmRldik7DQorICAgICAg
ICAgICAgICBzcGlfY3NfZGVhY3RpdmF0ZShkZXYpOw0KfQ0KDQpzdGF0aWMgaW50IHhpbGlueF9z
cGlfbWVtX2V4ZWNfb3Aoc3RydWN0IHNwaV9zbGF2ZSAqc3BpLA0KQEAgLTI5NCwxNCArMjkzLDE1
IEBAIHN0YXRpYyBpbnQgeGlsaW54X3NwaV9tZW1fZXhlY19vcChzdHJ1Y3Qgc3BpX3NsYXZlICpz
cGksDQogICAgICAgICAgICAgICAgKiBhcyBRU1BJIHByb3ZpZGVzIGNvbW1hbmQuIFNvIGZpcnN0
IGNvbW1hbmQgZmFpbHMuDQogICAgICAgICAgICAgICAgKi8NCiAgICAgICAgICAgICAgICBpZiAo
IXN0YXJ0dXApIHsNCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgeGlsaW54X3NwaV9z
dGFydHVwX2Jsb2NrKHNwaSk7DQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgeGlsaW54
X3NwaV9zdGFydHVwX2Jsb2NrKHNwaS0+ZGV2KTsNCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgc3RhcnR1cCsrOw0KICAgICAgICAgICAgICAgIH0NCg0KICAgICAgICAgICAgICAgIHNw
aV9jc19hY3RpdmF0ZShzcGktPmRldiwgc2xhdmVfcGxhdC0+Y3MpOw0KDQogICAgICAgICAgICAg
ICAgaWYgKG9wLT5jbWQub3Bjb2RlKSB7DQotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHJldCA9IHN0YXJ0X3RyYW5zZmVyKHNwaSwgKHZvaWQgKikmb3AtPmNtZC5vcGNvZGUsIE5VTEws
IDEpOw0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldCA9IHN0YXJ0X3RyYW5zZmVy
KHNwaS0+ZGV2LCAodm9pZCAqKSZvcC0+Y21kLm9wY29kZSwNCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTlVMTCwgMSk7
DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChyZXQpDQogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGRvbmU7DQogICAgICAgICAg
ICAgICAgfQ0KQEAgLTMxMyw3ICszMTMsNyBAQCBzdGF0aWMgaW50IHhpbGlueF9zcGlfbWVtX2V4
ZWNfb3Aoc3RydWN0IHNwaV9zbGF2ZSAqc3BpLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgYWRkcl9idWZbaV0gPSBvcC0+YWRkci52YWwgPj4NCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICg4ICogKG9wLT5hZGRy
Lm5ieXRlcyAtIGkgLSAxKSk7DQoNCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0
ID0gc3RhcnRfdHJhbnNmZXIoc3BpLCAodm9pZCAqKWFkZHJfYnVmLCBOVUxMLA0KKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHJldCA9IHN0YXJ0X3RyYW5zZmVyKHNwaS0+ZGV2LCAodm9p
ZCAqKWFkZHJfYnVmLCBOVUxMLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgb3AtPmFkZHIubmJ5dGVzKTsNCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHJldCkNCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZG9uZTsNCkBAIC0zMjIsMTYgKzMyMiwx
NiBAQCBzdGF0aWMgaW50IHhpbGlueF9zcGlfbWVtX2V4ZWNfb3Aoc3RydWN0IHNwaV9zbGF2ZSAq
c3BpLA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkdW1teV9sZW4gPSAob3AtPmR1
bW15Lm5ieXRlcyAqIG9wLT5kYXRhLmJ1c3dpZHRoKSAvDQogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG9wLT5kdW1teS5idXN3aWR0aDsNCg0KLSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXQgPSBzdGFydF90cmFuc2ZlcihzcGksIE5V
TEwsIE5VTEwsIGR1bW15X2xlbik7DQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0
ID0gc3RhcnRfdHJhbnNmZXIoc3BpLT5kZXYsIE5VTEwsIE5VTEwsIGR1bW15X2xlbik7DQogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChyZXQpDQogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGRvbmU7DQogICAgICAgICAgICAgICAg
fQ0KICAgICAgICAgICAgICAgIGlmIChvcC0+ZGF0YS5uYnl0ZXMpIHsNCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgaWYgKG9wLT5kYXRhLmRpciA9PSBTUElfTUVNX0RBVEFfSU4pIHsN
Ci0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldCA9IHN0
YXJ0X3RyYW5zZmVyKHNwaSwgTlVMTCwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgcmV0ID0gc3RhcnRfdHJhbnNmZXIoc3BpLT5kZXYsIE5VTEwsDQogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgb3AtPmRhdGEuYnVmLmluLCBvcC0+ZGF0YS5uYnl0ZXMp
Ow0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9IGVsc2Ugew0KLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0ID0gc3RhcnRfdHJhbnNmZXIo
c3BpLCBvcC0+ZGF0YS5idWYub3V0LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICByZXQgPSBzdGFydF90cmFuc2ZlcihzcGktPmRldiwgb3AtPmRhdGEuYnVm
Lm91dCwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBOVUxMLCBvcC0+ZGF0YS5uYnl0ZXMp
Ow0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9DQogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGlmIChyZXQpDQotLQ0KMi4zNC4xDQoNCg0KDQo=
