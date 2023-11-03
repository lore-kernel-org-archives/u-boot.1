Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E9AC4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 03:54:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04622875DC;
	Fri,  3 Nov 2023 04:54:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="WQkAuO++";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 677B28712F; Fri,  3 Nov 2023 02:37:44 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe12::602])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB4B287645
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 02:37:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hongxing.zhu@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKVOJBHtkPdwxUrdyFejkUwxaYrRwvwWEYo6BEtpvRGFeHZHxBLUcYzH63zZKRdd0qTUyooP5H3LBQB90gfSN76caGlXBzquCfThoyoB8A8dX2moMqtLlrMw3OU4f0PZTuCCT3tKSpTXZoyyiZNIhDoTrzfaKOlr6LMZ35RC7MzWLJuVCON6p+123r7G7whzbOqzzirEwF5hXjwKFL52xARniT/mjJlh6aAK8TaEjaDtNZ0r/p0INVKAHudS0yQDwZoGUjmDbi788C9jZZnCzsbKLms34qJB+SQJA/cKK9aYH+TOZhs3do/CW8ClifDtpgm7TUdiZZMzcrFF2juTBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+a9To+L8W7dqfb7rMIZenhx2VApzgipTQgC91LwRaA=;
 b=ayOjKlmFqELexPB0GUDmUuuDkslw/5ipojd/zhyasHFlO5jBRMqRsB9CVkO9oafOCfk+G+ArXMBirwW2Tx2of17X+YT6MEYH6aUv0l+wZr2nCTuw53fA9MZzZYEFXwfff+HAN6QLnq8IFciXwcpElvE1pZDhVdR7huyAgjIDwiOjtFrogo3lnwBQd9vC0JB3TuXmQN7XgO7JYLJ4uR3F6px5QZbU7Ik6ET6Ril4taf/6eTL2F1USNMojuaLlx5xJQ7HBBjpb6m8/yv1q545TI7qgusFqHezyErk0Uy/QOhE4UqqsbDsot2HfshXr0DdOmVAFaaCn21MT5ZOBb2XJFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+a9To+L8W7dqfb7rMIZenhx2VApzgipTQgC91LwRaA=;
 b=WQkAuO++XNl/cnUvIp1JTK4eR5X51HQGL7dzL/EWW8qN0mUwgZmHmvxS606SF1XlgjutXZO4LRF0XG7CsYAMTdK51uI0ohSW2H5fk+Adc2/PR2enuk7qZ90e5tMKfRrLAM2A+J5nE6AvtgDzsD3S6/P37UpB+5QJi1LTn7GdmY8=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM8PR04MB7361.eurprd04.prod.outlook.com (2603:10a6:20b:1d2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Fri, 3 Nov
 2023 01:37:38 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::ee2f:6e8a:3c9c:c3ea]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::ee2f:6e8a:3c9c:c3ea%4]) with mapi id 15.20.6954.018; Fri, 3 Nov 2023
 01:37:37 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: "sjg@chromium.org" <sjg@chromium.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: uboot reports adding disk failed(EFI_NOT_FOUND) and first disk is
 gone in next scsi scan
Thread-Topic: uboot reports adding disk failed(EFI_NOT_FOUND) and first disk
 is gone in next scsi scan
Thread-Index: AdoMbvzePOEhAsuLTy2OTmnmM9WusgBhnjhA
Date: Fri, 3 Nov 2023 01:37:37 +0000
Message-ID: <AS8PR04MB867669CC8B5EB411BDEF45348CA5A@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <AS8PR04MB86760A4BC079AF5BD57C81B98CA7A@AS8PR04MB8676.eurprd04.prod.outlook.com>
In-Reply-To: <AS8PR04MB86760A4BC079AF5BD57C81B98CA7A@AS8PR04MB8676.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AM8PR04MB7361:EE_
x-ms-office365-filtering-correlation-id: 3c8ceec6-24cf-41d6-f529-08dbdc0d763f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4PL9591vYT22VaKR682vfdyKJjALTAT+xHyIYFqRbqjnq8VCQRHrTObbJOPFpxwvqhZUrFvvn6VRufLzonFPSn0e5iFr1WGZaT6DDdf143lNxODwENWcT+W3gq9nQ7/HCVEMmGygVfXuWatKPE02sHKxuyzr3Nwo/9cLg7Lh2B/aVoCFFNScMIuEI7VY1kIMOZuFOdw2KWnN4MyYMTob70UAkajec9EqYQ6zfp2uQljW+4bD9d+7owZJy2olWLeqmB1qsT6HElCaQt+HpCwDD6GXRqxB49BisLEitM4F+BfyY+286P25fDR4jq01O8qV6G/xT5LHv5FyD0lDiH0Cb0m134DpZiTikSruNPsolP32sPEz5GbsE92EgcQnQqlDGCtuEyCQTAEaN2zwBzEBcmupsbt3YOSUJXqFwFXgCd09w3uCw/YyExe/9kNXbaRAHY7nOXNelWaA3Y1QYRptzdY36NbtGM+ZS27wocTcjjDrXxfEPSVZcb43rKBUNTyuIc/gh8kdWi/VpyXxVlHt9Avcj6j+StHuIzhZOtsN/goT++0Vw5rxPxvm24u9HCMs41wX9+//j4T2pGtEL4QybbU8gbaqxK53A9fQ8xSXxyhyVsWYyyCXdTVm20H7jRkD
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8676.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(39860400002)(346002)(136003)(376002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(44832011)(5660300002)(38100700002)(83380400001)(52536014)(2906002)(122000001)(38070700009)(41300700001)(53546011)(478600001)(6506007)(33656002)(7696005)(55016003)(9686003)(86362001)(71200400001)(4326008)(8676002)(8936002)(76116006)(66476007)(64756008)(66946007)(66446008)(6916009)(316002)(66556008)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ME5qNitaeFNhSGNKcTdoUm1RNUtkUlF6M3kvVHRaWndnWGNMUHdZVnZGNmJh?=
 =?gb2312?B?Y241VzJqaXEwWWVjL3UwWEYxRHRNVFlBWVhod0RKMTFwZmFrcSt4a0tnSlBk?=
 =?gb2312?B?TUJENjVvWnZmblYwc1pnWDV4U1FXSXhsVTVoc3BKejkwdkh6eEZIQWdPM2hz?=
 =?gb2312?B?ZVBmcHY2TjVqemdiQWlRU3pHR3h1dFp3Vlc1Vno1UEs5emNWbC9WazVlMjNp?=
 =?gb2312?B?MWVYSUdPYWJCalp0WFZndU1CditPRVRkenNwajIwNWxkQ0M2MTJhY2pGem43?=
 =?gb2312?B?dEVLZ0Zqa1dpdVBobFJaRGZTRU5oYm5aRWtMeFo4emxMTUJhVXQwS1Vhd0l3?=
 =?gb2312?B?VDBTcXN0V1JodWlSMzRVdXV4N2d5MFNweENuVE9xYm5NNjJZLzRjNW5pVUpE?=
 =?gb2312?B?ZHlGWER1SDdXV3BBRTJpZThlV2k3U3hzL2NwOTlIM2ZSa1hva0VCY3BGNDNs?=
 =?gb2312?B?bGhxMGN5MFE5L055a0RCUUsrMEVWeE94K09pRmVnQXp4VWdYOFhOV01tRktE?=
 =?gb2312?B?S01RWXNzOXhsUDk0QWFhcng5YjhlQjZid1FTR1gyOHJmOHhhVC9lam92aDlm?=
 =?gb2312?B?QmhPS3Q5d1NpZUZEVzEyNTZ2MGFaWlpQd1ZvektQQU1SdTZPMC9SQjVzOFVH?=
 =?gb2312?B?Sk1GeVlLUkxLTFFPbkJOckRUam4zckd3WEc1VnJ0UU50c0FyWUt6THdZV081?=
 =?gb2312?B?b2JPWXQ5OFM4QXhOZ0NTanljbmU0eDA1bDNhTE5FUFU2SERoNnZ0dDM5OFhX?=
 =?gb2312?B?K1Ewc2M3ZVVZOU1qa0VUbVVLbmRleTg4MWpzT3BhczFubVBEeXRPNklHcGd5?=
 =?gb2312?B?WSsxcUJyOFdYeE5UUjJxZmYwQ2F3WnFMOWVMTlhHc1BtbW5kZkxKKyswTHov?=
 =?gb2312?B?Tkg2UEpVRzZZVkY4M3E4eUFFWUJ6UFVTUi80YmhkYmZEdDYyUFZvRUFxTmxI?=
 =?gb2312?B?YjFqSEg2VzhBTzN3ZmZ5Z0JsM0IycWxhU3VNc2Rya2lodjNiU3FFaE5sd1ky?=
 =?gb2312?B?MmVxT0xIajBqVmNUZmQ0Z0diYXl5SFVwZHFHMXRzd1Jibk9zbXl2R3dhYmFq?=
 =?gb2312?B?YnJsazJ6L09ST1lOZk9wODVKb1VZUVA3K240SlpoY1YyRzZLYk9JMUZETFho?=
 =?gb2312?B?RXdzcGp2QkF3OVh1VVNBY1kraGp3RC9WbUVUYzNmTEZaTFJoMFQ1VDF2emhh?=
 =?gb2312?B?dWt3Z1FxZ01oMStaQ3c4d2huVW1IM1UwQ1lkV01jNEJ3Q3B6c3RtMkJWWGhh?=
 =?gb2312?B?dS9URmY5Zk9DU3ZOSEZjUlZBTEhCRG9YdUFYOUlzb2k5cFJPSExna0E4Rzl2?=
 =?gb2312?B?U2tIYU5iQzR0bnpVWFhDajd2QlMyaFE3ank0R0EzaXhrcHdaN0M0TFVDQjhE?=
 =?gb2312?B?MHF4aW9PT3ArS3BOYnBXSS9LeUQxSEU0VlByTVBKMXNaV0FQeFJkaVNEMndp?=
 =?gb2312?B?enRkeUp1dmVhVkFJeHY5QnZURVZ3a1kzNDE1UzEvaEdBZHNKRnlyTU5wZEFl?=
 =?gb2312?B?UXc4M3AzcWZ1MDZoMDVpclRqNU0wK3AzTWcrRURrOHVUbnFjN1p2MWdnelA3?=
 =?gb2312?B?YjNRSFM3djFZMFZHSXdWQTFLRXUvTFAwKyszVmsvSERQRWxMTUxTck1HSlZ5?=
 =?gb2312?B?TGo5YTdLVTFUQUJwcTZud0Y5ZTRVdUJvMjRUbVl5WGM5bDdlc0JxcTNCaVd0?=
 =?gb2312?B?YXVOcHlVTjhyMWF0REtvbGI1ZS9PUlVwdHpSd3hXa2MxejlENlp3NFZLVDY3?=
 =?gb2312?B?Ymo4RGNMVHlmVDEwSmEyNGQwcFpVZFNLNE9QUGtuNElmMWo5dGYxanBnVjhD?=
 =?gb2312?B?MEF0YXVYdzZHeDl4RmhjV2wxYWFBdjhVV2FoU2NtdXN6N0FCNHJoUW9VWUY3?=
 =?gb2312?B?MEZubGV0ajFPSDRvaUh6U3RnR096UlAyd29KOWJ4WUZzRVJSdm5CZ0dDV2Qx?=
 =?gb2312?B?S0NIRGhBK2c0Tkd5K1FxaEg2OXdMN1M2UHRNWk9wdlgrS2VYVUZDY2Uzb3JJ?=
 =?gb2312?B?aCt6UjJKSFNtK1o3R1ovLzROZnVkUEtEUEUzL3pIVUxZSnd1VkJPNlVGcjRi?=
 =?gb2312?B?R0FVSWQvNGl6REx4NTRleWtZTFFyWWtlVWxja2NmQ0lmMmZWMy9hSkFod21S?=
 =?gb2312?Q?dfgoZlKZHS2CW8dj7tcVixBm2?=
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8ceec6-24cf-41d6-f529-08dbdc0d763f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2023 01:37:37.9434 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EluSX5t/tAeB10MsC6kUiPXrigyta4VORTqO3v5IV+nOmyXfFaQTlQZ82DSEvKjcVnfcoaOvRLc3+aIAKKHlFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7361
X-Mailman-Approved-At: Fri, 03 Nov 2023 04:54:05 +0100
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

SGkgU2ltb246DQpJIGZvdW5kIHRoYXQgdGhlIEVGSSBjb21wbGFpbmVkIHRoYXQgdGhlIGRpc2sg
aW5zdGFsbCBwYXRoIGlzIG5vdCB1cGRhdGVkIGZvciB0aGUgc2Vjb25kIGRpc2suDQpUaGUgaW5z
dGFsbCBwYXRoIGlzIKGwRUZJOiBpbnN0YWxsZWQgZGV2aWNlIHBhdGggJy9WZW5IdyhlNjFkNzNi
OS1hMzg0LTRhY2MtYWVhYi04MmU4MjhmMzYyOGIpL1Njc2koMCwwKSehsQ0Kd2hlbiBmaXJzdCBk
aXNrIGlzIGFkZGVkLg0KDQpCdXQgdGhlIHBhdGggaXMgc2FtZSB3aGVuIHRoZSBzZWNvbmQgb3Ig
bGF0ZXIgZGlza3MgYXJlIGFkZGVkLCBhbmQgRUZJIHJlcG9ycyB0aGF0IHRoZSBwYXRoIGhhZCBi
ZWVuIGluc3RhbGxlZCBhbHJlYWR5Lg0KRUZJOiBQYXRoIC9WZW5IdyhlNjFkNzNiOS1hMzg0LTRh
Y2MtYWVhYi04MmU4MjhmMzYyOGIpL1Njc2koMCwwKSBhbHJlYWR5IGluc3RhbGxlZA0KDQpUaGF0
oa9zIHdoeSB0aGUgYmVsb3cgZXJyb3Igd2hlbiBydW4gZWZpX2Rpc2tfY3JlYXRlX3JhdygpIGZ1
bmN0aW9uLg0KQWRkaW5nIGRpc2sgZm9yIGFoY2lfc2NzaS5pZDBsdW4wIGZhaWxlZCAoZXJyPS05
MjIzMzcyMDM2ODU0Nzc1Nzg4LzB4ODAwMDAwMDAwMDAwMDAxNCkNCg0KRG8geW91IGhhdmUgYW55
IGNsdWVzIGFib3V0IHRoaXM/DQpUaGFua3MgaW4gYWR2YW5jZWQuDQoNCkJlc3QgUmVnYXJkcw0K
UmljaGFyZCBaaHUNCg0KRnJvbTogSG9uZ3hpbmcgWmh1DQpTZW50OiAyMDIzxOoxMdTCMcjVIDEw
OjU3DQpUbzogc2pnQGNocm9taXVtLm9yZw0KQ2M6IHUtYm9vdEBsaXN0cy5kZW54LmRlDQpTdWJq
ZWN0OiB1Ym9vdCByZXBvcnRzIGFkZGluZyBkaXNrIGZhaWxlZChFRklfTk9UX0ZPVU5EKSBhbmQg
Zmlyc3QgZGlzayBpcyBnb25lIGluIG5leHQgc2NzaSBzY2FuDQoNCkhpIFNpbW9uOg0KTmljZSB0
byBtZWV0IHlvdS4NClRoZSB1LWJvb3QgSSB1c2VkIGlzIGJhc2VkIG9uIHYyMDIzLjA0IHRhZ2dl
ZCB2ZXJzaW9uLg0KTGF5ZXJzY2FwZSBMWDIxNjBBIFJEQiBib2FyZCBoYXMgZm91ciBTQVRBIGNv
bnRyb2xsZXJzLg0KQmFzZWQgb24gTFgyMTYwQSBSREIgYm9hcmQgYW5kIHR3byBvciBtb3JlIFNB
VEEgZGlza3MgY29ubmVjdGVkLg0KSSBlbmNvdW50ZXIgb25lIKGwc2NzaSBzY2FuobEgcHJvYmxl
bS4NCg0KQWZ0ZXIgdGhlIGZpcnN0IFNBVEEgZGlzayBpcyBkZXRlY3RlZCBhbmQgcHJvYmVkIHBy
b3Blcmx5IGluIHRoZSBmaXJzdCChsHNjc2kgc2NhbqGxLg0KVGhlIG90aGVyIGRpc2tzIHdvdWxk
IGNvbXBsYWluIHRoYXQgobBFRklfTk9UX0ZPVU5EobEgZXJyb3IgbGlzdGVkIGJlbG93LA0Kd2hl
biBydW4gdGhlIGZpcnN0IKGwc2NzaSBzY2FuobEgY29tbWFuZCBpbiB1Ym9vdCBlbnZpcm9ubWVu
dC4NCkRvZXMgdGhpcyBlcnJvciBtYXR0ZXI/DQpCVFcsIKGwc2NzaSBpbmZvobEgc2F5cyB0aGF0
IGFsbCBkaXNrIGluZm8gY2FuIGJlIGR1bXBlZCwgYW5kIGFsbCBkaXNrcyBhcmUgd29ya3Mgd2Vs
bCwNCmFmdGVyIHRoZSBmaXJzdCChsHNjc2kgc2NhbqGxDQoNCkluIHRoZSBjb25zZWN1dGl2ZSBy
ZXNjYW4gb3BlcmF0aW9ucyBpc3N1ZWQgYnkgobBzY3NpIHJlc2V0obEgb3IgobBzY3NpIHNjYW6h
sSBjb21tZW5kcywNCnRoZSBkaXNrcyB3b3VsZCByZXBvcnQgobB1bmFibGUgdG8gdW5iaW5kIGRl
dmljZXMgKC0xRSmhsSBlcnJvci4NClRoZSBmaXJzdCBkaXNrIGlzIGRpc2FwcGVhcmVkIGF0IGFs
bCBhZnRlciB0aGUgbmV4dCChsHNjc2kgc2NhbqGxIG9wZXJhdGlvbnMgaXMgZmluaXNoZWQuDQoN
CkRpZCB5b3UgdXNlZCB0byBlbmNvdW50ZXIgc3VjaCBraW5kIG9mIGlzc3VlPw0KDQpBbnkgc3Vn
Z2VzdGlvbnMgYW5kIGd1aWRhbmNlIGFyZSB2ZXJ5IGFwcHJlY2lhdGVkLg0KTG9nczoNCj0+IHNj
c2kgc2Nhbg0Kc2Nhbm5pbmcgYnVzIGZvciBkZXZpY2VzLi4uDQpUYXJnZXQgc3BpbnVwIHRvb2sg
MCBtcy4NCkFIQ0kgMDAwMS4wMzAxIDMyIHNsb3RzIDEgcG9ydHMgNiBHYnBzIDB4MSBpbXBsIFNB
VEEgbW9kZQ0KZmxhZ3M6IDY0Yml0IG5jcSBwbSBjbG8gb25seSBwbXAgZmJzcyBwaW8gc2x1bSBw
YXJ0IGNjYyBhcHN0DQogIERldmljZSAwOiAoMDowKSBWZW5kb3I6IEFUQSBQcm9kLjogU1QxMDAw
RE0wMTAtMkVQMSBSZXY6IENDNDMNCiAgICAgICAgICAgIFR5cGU6IEhhcmQgRGlzaw0KICAgICAg
ICAgICAgQ2FwYWNpdHk6IDk1Mzg2OS43IE1CID0gOTMxLjUgR0IgKDE5NTM1MjUxNjggeCA1MTIp
DQpUYXJnZXQgc3BpbnVwIHRvb2sgMCBtcy4NCkFIQ0kgMDAwMS4wMzAxIDMyIHNsb3RzIDEgcG9y
dHMgNiBHYnBzIDB4MSBpbXBsIFNBVEEgbW9kZQ0KZmxhZ3M6IDY0Yml0IG5jcSBwbSBjbG8gb25s
eSBwbXAgZmJzcyBwaW8gc2x1bSBwYXJ0IGNjYyBhcHN0DQpBZGRpbmcgZGlzayBmb3IgYWhjaV9z
Y3NpLmlkMGx1bjAgZmFpbGVkIChlcnI9LTkyMjMzNzIwMzY4NTQ3NzU3ODgvMHg4MDAwMDAwMDAw
MDAwMDE0KQ0KU0FUQSBsaW5rIDAgdGltZW91dC4NCkFIQ0kgMDAwMS4wMzAxIDMyIHNsb3RzIDEg
cG9ydHMgNiBHYnBzIDB4MSBpbXBsIFNBVEEgbW9kZQ0KZmxhZ3M6IDY0Yml0IG5jcSBwbSBjbG8g
b25seSBwbXAgZmJzcyBwaW8gc2x1bSBwYXJ0IGNjYyBhcHN0DQpTQVRBIGxpbmsgMCB0aW1lb3V0
Lg0KQUhDSSAwMDAxLjAzMDEgMzIgc2xvdHMgMSBwb3J0cyA2IEdicHMgMHgxIGltcGwgU0FUQSBt
b2RlDQpmbGFnczogNjRiaXQgbmNxIHBtIGNsbyBvbmx5IHBtcCBmYnNzIHBpbyBzbHVtIHBhcnQg
Y2NjIGFwc3QNCj0+IHNjc2kgaW5mbw0KRGV2aWNlIDA6ICgwOjApIFZlbmRvcjogQVRBIFByb2Qu
OiBTVDEwMDBETTAxMC0yRVAxIFJldjogQ0M0Mw0KICAgICAgICAgICAgVHlwZTogSGFyZCBEaXNr
DQogICAgICAgICAgICBDYXBhY2l0eTogOTUzODY5LjcgTUIgPSA5MzEuNSBHQiAoMTk1MzUyNTE2
OCB4IDUxMikNCkRldmljZSAxOiAoMDowKSBWZW5kb3I6IEFUQSBQcm9kLjogU1Q1MDBETTAwMi0x
QkQxNCBSZXY6IEtDNDUNCiAgICAgICAgICAgIFR5cGU6IEhhcmQgRGlzaw0KICAgICAgICAgICAg
Q2FwYWNpdHk6IDQ3Njk0MC4wIE1CID0gNDY1LjcgR0IgKDk3Njc3MzE2OCB4IDUxMikNCj0+IGxz
IHNjc2kgMDoxDQo8RElSPiAgICAgICA0MDk2IC4NCjxESVI+ICAgICAgIDQwOTYgLi4NCjxESVI+
ICAgICAgMTYzODQgbG9zdCtmb3VuZA0KPHNuaXA+DQo8RElSPiAgICAgICA0MDk2IHZhcg0KPFNZ
TT4gICAgICAgICAxMiBsaW51eHJjDQo9PiBscyBzY3NpIDE6MQ0KPERJUj4gICAgICAgNDA5NiAu
DQo8RElSPiAgICAgICA0MDk2IC4uDQo8RElSPiAgICAgIDE2Mzg0IGxvc3QrZm91bmQNCjxzbmlw
Pg0KPERJUj4gICAgICAgNDA5NiB1c3INCjxESVI+ICAgICAgIDQwOTYgdmFyDQoNCj0+IHNjc2kg
cmVzZXQNCg0KUmVzZXQgU0NTSQ0Kc2Nhbm5pbmcgYnVzIGZvciBkZXZpY2VzLi4uDQp1bmFibGUg
dG8gdW5iaW5kIGRldmljZXMgKC0xRSkNCj0+IGxzIHNjc2kgMDoxDQoqKiBCYWQgZGV2aWNlIHNw
ZWNpZmljYXRpb24gc2NzaSAwICoqDQpDb3VsZG4ndCBmaW5kIHBhcnRpdGlvbiBzY3NpIDA6MQ0K
PT4gbHMgc2NzaSAxOjENCjxESVI+ICAgICAgIDQwOTYgLg0KPERJUj4gICAgICAgNDA5NiAuLg0K
PERJUj4gICAgICAxNjM4NCBsb3N0K2ZvdW5kDQo8c25pcD4NCjxESVI+ICAgICAgIDQwOTYgdmFy
DQoNCj0+IHNjc2kgaW5mbw0KRGV2aWNlIDE6ICgwOjApIFZlbmRvcjogQVRBIFByb2QuOiBTVDUw
MERNMDAyLTFCRDE0IFJldjogS0M0NQ0KICAgICAgICAgICAgVHlwZTogSGFyZCBEaXNrDQogICAg
ICAgICAgICBDYXBhY2l0eTogNDc2OTQwLjAgTUIgPSA0NjUuNyBHQiAoOTc2NzczMTY4IHggNTEy
KQ0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQoNCg==
