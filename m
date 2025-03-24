Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F30BAC36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 15:09:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12FB280548;
	Mon, 24 Mar 2025 16:09:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="ZtOUUjAQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12B8F81E5A; Mon, 24 Mar 2025 04:06:03 +0100 (CET)
Received: from MEUPR01CU001.outbound.protection.outlook.com
 (mail-australiasoutheastazolkn190100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d40e::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F28881E14
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 04:06:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Zone.Niuzh@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dRLai+rybNXZ3i07JLX9rWabAXKCWblMwPBcaWKs0Nkj3bNDQYW3gnNwl9HS01a4suZr1zYd4x7ib0mqj0Jfbs67403nigivU+1j70GuEJG0Fpo7qRHG2j5Z5Iia1x2uQfxLTcHnmvFYqXWqkqekGbekqRf/d6QwsvRw/42zGseY0OlQ9PrLriCfSd/k5XcpgxRg4Fx3KACDyQZ0I47dlSjltE80JVB6R2s79+2XDNN+Yb3QvmDqilhA4govkVMySNL1C4FWSuwCCfPOWgvksu/TbdvPW5jz6L29SQQX0ABj9zxymZy3qVBkBTwHvA/klgwI/hGKlBbpOQ+NnHYOJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIUU4Q1aPdE1evWk88zLR14X0MMgi1Z5OBD4MMKiuh4=;
 b=w4KG2REm1QcSI0JUJVLrUFdgUnt6dvq85AeXUShJNnq7WrFy/+Ej/PELaOE2t2KySi10I+uHg4q5s+DX+jnd6PAxPaYiAj1JRR2qpchV7c5nvrM4sVt3adnLTHpN08+hGlp7ZBrzXvfQafsLaFDQZ0RBB+gGqB6VIozbCTtqYTm1dREIgN45NYWMGx4dYuao8+6F+y/Dl6m7aIo/lqUBtOiBZR4/s2NAX9ffhm4/XaqGxn/DT24oV7trbGsf8GIBHlCimasQ2RZcHMjHY2nai4bEcYDte+vyKTX2M55Mpr6Yq2nZEToDjCJZoV/iyJKc4oBze5NKrQgATf+/hh4qLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIUU4Q1aPdE1evWk88zLR14X0MMgi1Z5OBD4MMKiuh4=;
 b=ZtOUUjAQFKL3EOsOQESTfh+w2wlmVESGhqzIaLgdfifmk7HRa5LJwjeHHvcKImk4Atecv3q9uS09SIwR1+oi8YkYJfw8BQy+k5v8HvKBKLqzVhRRlkce2ZAFmv4tv8Nh7pK2b9kQRn4WrAwe8dGmNblx0nggHBzuraPLHfWy72u7EzIssfLjLbCds+dguI+PPdVMpqinBI+Fob/Kh4VDwB+8EOO5O9aEVU9adV20eslWKupVTTsDvOY650C8Sfrsp/YqumNJaxB35uledP0Qif6t7stSJ9QndxLybUTyaLEnjVK1WTSXJRA/NANiiN0DHWISJkSQumBwhh+nc5p00g==
Received: from ME0P300MB1309.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:241::8)
 by MEUP300MB0047.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:21a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 03:05:56 +0000
Received: from ME0P300MB1309.AUSP300.PROD.OUTLOOK.COM
 ([fe80::b19a:4f0c:b8c2:555b]) by ME0P300MB1309.AUSP300.PROD.OUTLOOK.COM
 ([fe80::b19a:4f0c:b8c2:555b%3]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 03:05:56 +0000
From: =?gb2312?B?xaMg1r666g==?= <Zone.Niuzh@hotmail.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: [PATCH] bootm: Add support for passing arguments to elf app
Thread-Topic: [PATCH] bootm: Add support for passing arguments to elf app
Thread-Index: AQHbmjpw74hnnpx4jU+sx5+6JouhN7OBnrib
Date: Mon, 24 Mar 2025 03:05:56 +0000
Message-ID: <ME0P300MB130971571336A7F169047BED9FA42@ME0P300MB1309.AUSP300.PROD.OUTLOOK.COM>
References: <20250321082242.59565-1-zone.niuzh@hotmail.com>
In-Reply-To: <20250321082242.59565-1-zone.niuzh@hotmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME0P300MB1309:EE_|MEUP300MB0047:EE_
x-ms-office365-filtering-correlation-id: 833343c6-28c8-47fd-5b24-08dd6a80cb9b
x-microsoft-antispam: BCL:0;
 ARA:14566002|8060799006|15030799003|19110799003|8062599003|15080799006|461199028|7092599003|440099028|3412199025|19061999003|41001999003|102099032;
x-microsoft-antispam-message-info: =?gb2312?B?cm1idDR1ay9FZ0RIUUtBNXg5bnljUkdaQmZTTmVGWEc2VElIVEtZNmNubzhp?=
 =?gb2312?B?KzQ0aHl3eG5RM3o4MXdvYksrY01Zdi9nV1AvTTgrcHJHMEdPN1lNY29HWDFo?=
 =?gb2312?B?ankvckk4U0RZZTRNUmJORFhibnU1MkhXV1dIV01WVjhEYUlaNnFQL0tyNlRR?=
 =?gb2312?B?cTU3RVVWMy8yZXdsU0FybTFBTzUyam8wR1RLaTR6VFJ6KzhGTk5SOXZhb3RB?=
 =?gb2312?B?ZFJzT3MzK0Y5UkNsalRnZGpWak5KMjNSelVQOUZnT1NYVzFGQS83aFBaZ0k0?=
 =?gb2312?B?ZWlDLytGRy9vWmIxOE9ocFZGOXdzT0RiYzh1L21kbzdqR1AraHBwcEZiYXlK?=
 =?gb2312?B?cEFVaGpnTkpvc0hBSjVFZklHZUxQZm1nVlorN1FkSU5zZzJFNE1EcTN4Y2c3?=
 =?gb2312?B?WXJCQUF2c1RaWkl1Mkx3QitoNitZaWQ0N2dOWGtoOTlLb3JyVzJYWTZtalo4?=
 =?gb2312?B?cWRScXkrNTZiSUhzR3lQdXd5cVdhQWpsWHA2NlBPTFlXM2dKdmdweHlwWXVt?=
 =?gb2312?B?ODc2MVRkdEc3Y1VRdTVYS1dJTEQwY1kxMlVmNGErWjFrTEk0V1Y3Z1NuNmFV?=
 =?gb2312?B?K2MvVlJMUTRkVE4rNnZqdyt5WHlSWHpDRzArbTkxYUcxT2JhUXlSazYzemJj?=
 =?gb2312?B?b2k5SFlSRlpLWDNWcW1sa0thSnlWY1hLdFFHY3RVZSs2NzI2alpnQTJXQVBy?=
 =?gb2312?B?bnB2azc5cG5LUDUyYlg5alFnNHRKcEt1bHlZWjZ3MGNPMCtyUEJQNU44dmxw?=
 =?gb2312?B?RmJQeStOSVI2ZThXODRPeWtMQW1SbFhQUGc3R0xNLzcvSHMrdjY3TDYwdjBj?=
 =?gb2312?B?cmp1dmU3bnN4WHpSem5WUGxWanl4L2h0bnpocjhtNTVQSXFMR2M3VEthQ3gy?=
 =?gb2312?B?bS9EbCtsOUJwSHBucnlDT1F2Qlpvdy9CejV3UVZXNkVyU1EwU04wVnB6KzhG?=
 =?gb2312?B?aDJZRFdmSEtxSDRNL0xmVWM3Y3pmRXZDSU1MVGZyZkRnNnNBazU0alh6TFBX?=
 =?gb2312?B?UUdnb0tHNEdGTHRFVWwyRXZzS3NWN2JRNndUdE9SUG9PcVdMbS9xdkVEcUJq?=
 =?gb2312?B?eVg5Qkt0SWlSalhpVEJtSVhkeXhYNlB3VlNzYVNiV0F4Tmw0VkNaMnNWdnRR?=
 =?gb2312?B?eXF4dWU2Y1ZrQkVlOCtWYk5ERlhmeU8wL1lFUVZVelY2RVNvaHBJK1VUZDQ1?=
 =?gb2312?B?Ulp5SUVjZzZrTWE3TXFWOEtKTGVhSjhBSjVyVkFHZkZXempJT1JIRHBPOUpQ?=
 =?gb2312?B?V3NsV08rWjMyZFFiaS9sQmJxdFBtSUxUR2Vkd2tHay9BMXlzcnU3MFVIR3Bh?=
 =?gb2312?B?SmlIeFU4d2F3NHpFd3NsYUpoRXBxMUxkZW9RQkwyT29TOVdiajZxK0ZpeDIr?=
 =?gb2312?B?a0Y5S2tDNnIwUmtDenlVelloSi9HdFJZMTd0QW5VOVRRY0dhUC9nVksvV09V?=
 =?gb2312?B?Y1VVUndhWlpza2ZLMVJhbm1scTNLenN3VUVjS1pUSU1CaUpVZmVvck9TVjVh?=
 =?gb2312?B?bFB5ZDlxMjdOaXNZVjdnRm9UaG1QVy9STnl5VU1SdkdpUVNWV3pOTnBJUDR4?=
 =?gb2312?B?a2xrMG85aWp3M2xIczhwUDRnTFhRcXc4VWlzZncwUmhGaTNoaFdHNVVmOW41?=
 =?gb2312?B?QkZKelRuN0hTUVFKSWc3SkFmTHVCK0E9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?d0cvVmZQT3Q4MjFOMTljWlhXZkwxNjRhZHdVeGczam5VTW9IVFhTM3E2alNu?=
 =?gb2312?B?Qm1uaC9vK2xXUEhPRERkVnZmbXZmSWlsdy9sMDFBWk5yalRaVnBaTGNxQmwx?=
 =?gb2312?B?SmZrN05mNWkwUTJXekJFbkNJK2tuU2JLNXNGYXJxMHFRMHdCdkU1UFVUL2Ju?=
 =?gb2312?B?NXlvYUFGZk90M29wRVZjTjRsOGN6cFlPeVZScG5xbU95YitmRVF4Q1h1eHAy?=
 =?gb2312?B?UDhVZHg3ZWFmcHA4WTdoMnkyVjdvRG0rVHdJbG1kVmt0TDQ0ajFYTm52L1R2?=
 =?gb2312?B?bjlMNTMxcDVCeXFNSmxWQ3ZVc1p5TWNGc2RPNitsTGxUMjNoOTVEdTFqOFFE?=
 =?gb2312?B?aUxYaDZadUpRN09TT2R4SmR5L0owRU12YmhsMTlGTUZ6VGtlRmdVL1NGbHg2?=
 =?gb2312?B?SmJWcTBJV2ZaS0N5aDQxNE5hUEc3ZFZUclNISWpKUDk5Z3FsT0Fvd1J5UjdO?=
 =?gb2312?B?TkR2Sjk1bGgyb0VWODBQSlVBTFZLckc2Qy9yM3Z2bG5tcmFuNDNDcG5OMGtz?=
 =?gb2312?B?QzVIdHVyMEV5WHVGUjYzUERXeFBSWEZhR3lrT1lOaFptb0FoaElMcGZ3d0hF?=
 =?gb2312?B?MkRHaUJnSWp2TEtGRVNNNHlJdnJiTzlTSm9sUXNIcDVZNlh5QitUWnZxNVlw?=
 =?gb2312?B?Sy92NWpoTUUzK0pPV1dJTlBUemNhc3RMZ2NOM1A2dVBzb2thczdRUHhBVEhr?=
 =?gb2312?B?NlA3UGJTS09peXAzU0s1d0N5UklDRVBwT09vOGc4OFIzdm80d0MvUXZ2WVV5?=
 =?gb2312?B?UlpsK1dhZENnclNwK1ZYWHg5eDlMamVMNXJHM1dTTUUyOHUyNDN3QjhUdXhC?=
 =?gb2312?B?OHZpWFc0L0pQYWlzM1ovQWxHbW12WkdWcnB0VGUxYWpBY0x5b3hDUGNrTGxr?=
 =?gb2312?B?RmRnQ05OTWtYdVp3bmVpdUFnZ1lhNkFwRTA0dmViSER1UVVBN3VXSjI2amEr?=
 =?gb2312?B?dzJnVi9QQVJmTVhTR2hURHloYVJQSnFVQnNMajdxLy9QOWhsaXBhdFBQbzha?=
 =?gb2312?B?QWJRWTFNVDc2SEpZMzFtaUs1eVlCaDZFQThlN2lKa0Y2a1lXalNVK2xCUGxL?=
 =?gb2312?B?TStGcVptcHJ3bklnUk85ZmkxQmh2cHFldThrajlGUnlocW9KTHdaL2RaVnNz?=
 =?gb2312?B?ODRMcHNhZWFFVkxveDVvazVEL0ZIZ3NUSFpDRnlKRFdMU3hKV3JUbXJUMzFF?=
 =?gb2312?B?d09FQVRnVzNqdGpndmlidExDdmFxM05PbklxdkZFa1Jod2d4L0J2RkNhcWRs?=
 =?gb2312?B?K0NKdHBSTklzV0ZBbFZUUTRYRnhnSHl2bjUwNEpiQ2FwZFlQYXpNWE1HU3J0?=
 =?gb2312?B?emFqTExPUDRtWmJxUnRiL3BWQlJDMG81OTJIWXJKUVljWWJhUktQMWV5cEk0?=
 =?gb2312?B?UkxBVGJSYUQxVFI1VWdRRy9pYkgrTGRBN3pkYkxuN0xqaWh5bTVUVVRyWmdI?=
 =?gb2312?B?ZXYyemJlUTNpYkQxb2JnKzVvZ3p5ZEE5TW55V2IvK0MrZ2lVTVlPNE9FWDQ3?=
 =?gb2312?B?MGYwTnEyeUR2bGM1NTBMTkllTmVpNXVxY3dGSUdnNnF4czJTUTJ4c2c4NW1j?=
 =?gb2312?B?SUprcWVHRGRzTFZZUVJJbnIzL1VFS0J5NDZ0dkowanlTN2tMeUZzejZ6UGRq?=
 =?gb2312?Q?ORTUFbWWK2Dbo9dChVdnkKeobaFALPbhi0v1tWvbjjV8=3D?=
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB1309.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 833343c6-28c8-47fd-5b24-08dd6a80cb9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2025 03:05:56.0756 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEUP300MB0047
X-Mailman-Approved-At: Mon, 24 Mar 2025 16:09:23 +0100
Content-Type: text/plain; charset="gb2312"
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

VGhpcyBleHRlbmRzIHRoZSBib290bSBjb21tYW5kIHRvIGFsbG93IHBhc3NpbmcgYXJndW1lbnRz
IHRvIHN0YW5kYWxvbmUNCkVMRiBhcHBsaWNhdGlvbnMuDQoNClNpZ25lZC1vZmYtYnk6IE5pdSBa
aGlob25nIDx6b25lLm5pdXpoQGhvdG1haWwuY29tPg0KLS0tDQogYm9vdC9ib290bV9vcy5jIHwg
MiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpk
aWZmIC0tZ2l0IGEvYm9vdC9ib290bV9vcy5jIGIvYm9vdC9ib290bV9vcy5jDQppbmRleCBlOTUy
MmNkMzI5OS4uN2U0MWUxZjYxNDEgMTAwNjQ0DQotLS0gYS9ib290L2Jvb3RtX29zLmMNCisrKyBi
L2Jvb3QvYm9vdG1fb3MuYw0KQEAgLTQwMiw3ICs0MDIsNyBAQCBzdGF0aWMgaW50IGRvX2Jvb3Rt
X2VsZihpbnQgZmxhZywgc3RydWN0IGJvb3RtX2luZm8gKmJtaSkNCiAgICAgICAgIGlmIChmbGFn
ICE9IEJPT1RNX1NUQVRFX09TX0dPKQ0KICAgICAgICAgICAgICAgICByZXR1cm4gMDsNCg0KLSAg
ICAgICBib290ZWxmKGJtaS0+aW1hZ2VzLT5lcCwgZmxhZ3MsIDAsIE5VTEwpOw0KKyAgICAgICBi
b290ZWxmKGJtaS0+aW1hZ2VzLT5lcCwgZmxhZ3MsIGJtaS0+YXJnYywgYm1pLT5hcmd2KTsNCg0K
ICAgICAgICAgcmV0dXJuIDE7DQogfQ0KLS0NCjIuMzkuNSAoQXBwbGUgR2l0LTE1NCkNCg0K
