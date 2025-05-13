Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C339C3ABCC
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 12:28:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A2F18091A;
	Tue, 13 May 2025 14:28:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="HW7XPP//";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A96F81FAB; Tue, 13 May 2025 11:51:00 +0200 (CEST)
Received: from SY2PR01CU004.outbound.protection.outlook.com
 (mail-australiaeastazolkn190110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d40d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F6198129F
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 11:50:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Zone.Niuzh@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sf3Lz6MWL8MCSuwIneyCmXEduDE/8UI2oMtWzWr2J4OCxAjynRarkXMz63+Wqr/W6Ydr5eGudsReCKe1L4fJvF9VtQr1o15danqxYEh84+mVSBztDrO1xWGQrxg1ZkjHp0n+ZMecS30llp7UqxizvB/O61LyabasuMYPJ6s2RJKZhvOphyFwROBp8TMkrSWpNHq9uZSztQ4tEhhFGovO7BnQlvt3yjPnfc3CzHHZCzDp1JqD5G60v3HJo6fwIRgbKhPpr1i4lhHvEKYfinygRUyyDVOVyU5ltXKbKEixEsS/jxzo64CS9D+IPl0OG06+f8/95BxFfzfG9eUQ2vwWGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QqI2ZlguSnww2PAn/QVLIk2YzP0Q9xsMZSmklUdzsTw=;
 b=j5znHv3U5UmfmrJVVDSLZpZ7r76mhuhe+txqG+ofWRqkg67cuu/t+S4QBVEDbCenw7xk3pgU2eOwVDyj0DbyB2o2wBJBqLR9tfICxLoj7wEiM+isaHlOiP1QwsdKdATGB9/CUXHV2u9RZM32D0V4izqdmzj6oSNV0O3l86tGY1WWXqZIshGoz7aP5kzrHJJ5kV4eXRk6aBYbDOkxslpB9p1LHl7HsffjV+rSnExp+gDKw4bB05GgmFJU/ue2MqhYdA7Z9c0k6wPB9eXacPyjIk5dDR/iYeOi8RUopDx0Lq0TOoCFKDHm8xh9UehC8kIhmRhu8V4boiR7jDWEjGkMaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqI2ZlguSnww2PAn/QVLIk2YzP0Q9xsMZSmklUdzsTw=;
 b=HW7XPP//u5GSKrgSi8o1vdocxDVpcz9wBR0SufMsWJ6jH9dY8+wrz0oAqH+zZ2YlaZiV6PyX0nL2ow/+7lLJ9d8MQRCUCoZ1sWMuOtHYSWrOEBg6FNJEVQZQdrZS2Xgp/uSR0OqPt/QD3peO4h9jM4MSlm56EmoI8xuO6KQutBmnLmQZ2mmTRh85Y2OrrLGvvHVojXm9TUXNI1uxia8jbOProGrFv/+kHxSrwHPtSjgL7OHBMf56lek8GNgno2prBevYuNH6e+Jy56ZqeYnPihpa0+X6uc8pmChvsgPxwrZOGUMKOliN74Ni4ULQlG0NqC1BTUxhoPhlXzjX2yblvw==
Received: from ME0P300MB1309.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:241::8)
 by ME0P300MB0384.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:230::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 09:50:53 +0000
Received: from ME0P300MB1309.AUSP300.PROD.OUTLOOK.COM
 ([fe80::b19a:4f0c:b8c2:555b]) by ME0P300MB1309.AUSP300.PROD.OUTLOOK.COM
 ([fe80::b19a:4f0c:b8c2:555b%3]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 09:50:53 +0000
From: =?gb2312?B?xaMg1r666g==?= <Zone.Niuzh@hotmail.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: [PATCH] bootm: Pass SMP core ID and DTB address for ELF-formatted
 kernels
Thread-Topic: [PATCH] bootm: Pass SMP core ID and DTB address for
 ELF-formatted  kernels
Thread-Index: AQHbw+wQwcnJGm7yoUyxCR20r1ZpnA==
Date: Tue, 13 May 2025 09:50:53 +0000
Message-ID: <ME0P300MB13096732AF44AC5409B9D0D49F96A@ME0P300MB1309.AUSP300.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME0P300MB1309:EE_|ME0P300MB0384:EE_
x-ms-office365-filtering-correlation-id: c64d2831-18bc-4b6e-3369-08dd9203a690
x-ms-exchange-slblob-mailprops: 30ekHghIwFpWJZJ/S7H67WW7FVejyf+CnZdPdXjxG/ZIujQbXBooQsZS3EedTMsaIRB85LHH2tjVPFT6t4EFVZaYh5nubZlGo8KdFQZpVgcJaUXKcN6IMkHn7MTLbPD+irtXaCBVlMnFPUJRTqPVUkoJtEbFQYrIw+pPo4kbWMatsT3/iBNZBtQ6ttvv4me7v9q0BhVVIIIi7IDYV4pRpaPtmo0qRwn1+mLb4uWes7R/EELiP0CR/Luo1/pxJlNlb5zN1qxM/TxXU35cpXfZRj82ePRUH526lU0q3AiMAuHHT8JqssoInknM805LLteWgdbP3RsGcpdR7CrLLbp5WEjD/X+ZfkT1CSTkCMEtX8emc9r0ZwuQLGsEz+iZTQ2GaWUSbzQtcA+HZgtxTPn8VONwjd2nM849fb6EZA08XtuDccM9YVm1xK8k9aEJy/rXW1hYBXHvnCZ37JuYxJtObL2egBgqyqUWSjs/yrlefHSjZOCVhuE7h1lc5898C3pV88v+nY6awVCoaXn55jSQCgnLOK1KnHl+sBMNf1WNv+c+8k3G5QZRXzaDUuqyxXz3UDitvEHbDrCeB8vdG3/wEimwhzZhNLihc+WSRGgAnj2PJ1qt+Ky+j2+luiuuPMbkZREXKAJWVtRcvnqovsI7XKgRP6Ok1wHUEzNlzVVWimAIYMWB4yfYQfJGbZ93uYWNSJX0mYnqEphA//JAUZNPI4n7PaYpoJ/W3BjHwK26VgJDp+3OMn0KWsNaT6PKS2mZ
x-microsoft-antispam: BCL:0;
 ARA:14566002|15030799003|461199028|41001999006|19110799006|15080799009|5062599005|8062599006|7092599006|8060799009|440099028|19061999003|3412199025|13041999003|102099032;
x-microsoft-antispam-message-info: =?gb2312?B?T3R0VzVDRldPanFpS1dJcXpVbkt3RThYL1duRnAxTHNKNnNmeE11NjFvMm95?=
 =?gb2312?B?eERZT2tZcmo4R0RtMllxa21uU0RoL2xwY1RKYUlUR0l1amJEbHc5YzZvQUNT?=
 =?gb2312?B?dDFKRURlQUpLWnNpZU1icmthamZrcStlTjdsbk44MHpOU1Q0YVhzSXVPYzNT?=
 =?gb2312?B?RlFLaTEyQk9tQlg4MjEvT2JiTFBlWFc0YVpFSEFKdUFQVmFUdU9zY2ViMUhN?=
 =?gb2312?B?cjk5Y256bnB3Sy9TSnc0OWNtNTJiK2lVSUlabDByR0hoMkNiaVNuQ1gyTnFQ?=
 =?gb2312?B?UktkMkNZY3NPeEtGMDM3SCtIQzBCWEs5dkRBRTZDWFRGNXNuMmlibU95UG5Y?=
 =?gb2312?B?cFV5N1BZVGJuWHJpVjJxODFyNE1IdTdIb01ONXlnbGowS3VsMTJLN253ZkZj?=
 =?gb2312?B?MXc3TDVsZ1lxZkt2c0VHc0xEWGJBbXZBaGZwdUZlbTBneGl5TnZvMHh1MmNK?=
 =?gb2312?B?MEFPTkdMcVJQY3Q4MXpEdExieTc2RmlRZEpjem41a1NXeHkwZ1BtTExMUDd3?=
 =?gb2312?B?d1NNY09vaWhJRUp0aVhlVTM2SXZjY0NnSUhUMSs5cG55Zk9yS1MzWWpMTHJH?=
 =?gb2312?B?c2tZbDBzRkp3TkRCVHMxeVkvNitDUEQrN1I4d0tGMVNKcTU1bGNDVGxKaHRi?=
 =?gb2312?B?T0tkRXNYQlBHaHFKRmlLcGVteGRGUEJjb21wSUhlRi9oemxmVE8yaTJxNU1i?=
 =?gb2312?B?a1gxTWFtMU0yY2FtMjJmMHN4UE5tbUFJYkxWZGlNbGF2YkxWQlJwUHlYUzB0?=
 =?gb2312?B?TjVvSzl1THUwZlY2V2NqVUl4ZG9nRlFrMy9MQklIdDJiR2gySGwvM29BVzQy?=
 =?gb2312?B?M0tEem9XOUFadVArZmdmakNMR0lpTDkyNFpwUVpQZFlkR3BjYVlrZVUxSWZC?=
 =?gb2312?B?VFlPejdQNjNBQ2NreE5ENDJ3K3pFTVJ3UXovaDArSXZCRkZzb3JUNzNsQ25G?=
 =?gb2312?B?MEwrc0RzOG55b2FXWkRham5WN2g3eVhNaU1YbU82OXl1cHJKSlJtcmNIbVdR?=
 =?gb2312?B?OTIydVEzVkRaaXVhbzFDMjNKWjNLdGdFTmdjbFg4cTdsZ0tOUmdWTXp0aW92?=
 =?gb2312?B?WEV4U3NQZHFyb0VnWTNwbUp0c3dDR25PUGcrSzVETUgrU3lXbjlCYktZbGpW?=
 =?gb2312?B?eDBSVjRVbHVneGlKdzNlYkdJNTJ1d2prQ2NVT0l5b3ZpMTFxQm45QW4xeVk3?=
 =?gb2312?B?UnB1bG14UEk5N0puRENhZnJ1dHVwSVZJeldJU2NQTlZTeFF0Z095SmUwdWJ1?=
 =?gb2312?B?TjB1eHcrdXpGNWRPMmlwNk4rQ3RWSDRXZEtTaUlRd0FFYnRuSE9oR0MvVlNk?=
 =?gb2312?B?OTlVenU0WHp5bUMyYWUrYkxjSTBPckZSbk5CMnY5MGRZRk1lei9wQjJXMVBh?=
 =?gb2312?B?d3RjdnFzNVFha1dxYTFhR2h3Y2lTNEh5Vm1ZUGpjUWc1K3R1ckNNSVJ5WUZS?=
 =?gb2312?B?U3lKTkxxL2tFWmFuMnQwSGl2aG5nQ3RBZEtYc1pDQ3VsOE9QdmExTlNXVnpo?=
 =?gb2312?B?V004OFZCeXMyMGtzdXIwczlCbVZBcmw4dXkxdVp2eTBlNmNGelB0NGdxQzc4?=
 =?gb2312?B?a3hZTFlCMUY5bDVhMlBwemt4RElNY29vWCtIREdHTCtQekU0ajNOUTIvdHE2?=
 =?gb2312?B?Z2VVUDJycjZOOGdMUHVhZW1jV2xGSHRJVGg0ZVpMR3BhZXhCNlIrK1h1V3RP?=
 =?gb2312?B?eFpmMkt0L1ZvcWxZeUFudEFncWMzZFhCWGQrNEY3dzVvRlVUSWU0ZmZRPT0=?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?alhXVDJaY3VyZjE4K3UyS0NmNDdycjhwZEVqT1pTd2JnalFyR2tmQm5HM1FQ?=
 =?gb2312?B?RlErQmZ1NmpzdkxhQldqdTJveFphVW1wcm9kQ2dvUEh5S1lxYm5oZnpYNDRX?=
 =?gb2312?B?c25YME80amxoUkVUT2loL0RkblorNktsdEk3VkpRNXlqVHhTN014d3YveUFq?=
 =?gb2312?B?STdOakZOdG52QzdCWU9EalZ6R2hkQ0sxRlVQUmtWVW9CN0FCSU84U1EyZDk4?=
 =?gb2312?B?aDBMd1pDdHZuUjhYZXpjb2JZVFlzQlVxYlJVVEx4TUVxL2NiMTJxMkNKTFNQ?=
 =?gb2312?B?NjdtQXY1RCtQNnlORWdNWElnNjY0eFllMk05L2t5UVRZUFVGQ21Ld3B1Zlhs?=
 =?gb2312?B?OXYyYUpTejBKVzhwVTZadm16QjAxczI0cU5JdTR3NTU2Q1BTamsrKzYyMngv?=
 =?gb2312?B?UWpXenNLN1RtcnpadlMvUGl4dXJPUkZjSnh5cmxJbHNFdkM3YjFvQXUrblFO?=
 =?gb2312?B?eFNYMCtxVnJGaWhiMXRpVW9rTEg4M1ZwNUQwRVJCU1YxVkJNKzhYV2crT0JH?=
 =?gb2312?B?MFFhUUhuOXhMMEVVdVFaaVY3eGJROGV5R1JEUEJnS1RIdnpsZURQNU1KMTlC?=
 =?gb2312?B?Rlcra0w3Znp2RHlOblJOVlFxd1hMbm9mbTNpRG4xazltbXZGeFhtTDhKRDJr?=
 =?gb2312?B?ZEN2VWoxemhvOC93RG5yVFNhZzlrdlgrTkdwd09WTmx0UzJrckFJOTRRdS9s?=
 =?gb2312?B?a1VEWFVuUk9XdEJ2YWROaUdTYU9FbEhCd2dHNGdlcFE2Y28yQk8rTEd5VmNn?=
 =?gb2312?B?K09pYWE2Wkl2ZEg2bEZLdTZBbUlpYjZMMmhjOWpiVHZ4TGRuVnhYaFpTUEMz?=
 =?gb2312?B?NTE5N2ZFS3l1eTFqVWREa2d5TlZBV0NsbUF5UDR6OW9TTllUU3l1NmhQZDZG?=
 =?gb2312?B?RGR1MVhoM1h6Yy8rRFU1dXA2RmJGZ29qb05wZ0tuMXV6RzNiNVBpak1QT0JN?=
 =?gb2312?B?Q2Q0aDB2aXlzQ3Z2K1NyOUVkNkVJWnAvUmdzcGVqaDNWUTBRZE02R2JaZ3RC?=
 =?gb2312?B?dmlZQkdtb1lnbFFaQ09PaW5Gekx5T1FtSGMyWXByN2FPZkFORlRENTY1Q1FR?=
 =?gb2312?B?TmhscjBjWCttUmt3L2tCV2lxZnd1YlpjVk5EQ1hQK2FZM1RWd2MzOTZNQTFu?=
 =?gb2312?B?K0NHcW9kLzVMbWl6ejRZamhST0VTTDhNdjV4cHZORWFPQkNCRUQ1OHBuUmo1?=
 =?gb2312?B?SU9BbFZmS21VQUcrMU5TZE1xdEtHTEQxRUZDY2ZzalFCTDhkaVZtdEs1ZlB1?=
 =?gb2312?B?YVlyVTlVVzVUVVlDYVZ3WnE2c2dTenBrMnZXK3JTd2lxNEU0eDY3VktwR2d4?=
 =?gb2312?B?UHZ6Tmt6QzBmYU56WjFSdDdyQ01oWmNrMlkvclBlYlo5VGp1SGJJVXFVelZZ?=
 =?gb2312?B?d0c2dlpkbDhXTzdCSFFlcUszeVVUMWs0QzVXNHIwemVUc1VLanRoNVExSFc3?=
 =?gb2312?B?U3NIS1ZLTWFSWEs3cFJnKzlZKzUvZFAweVo1OFdMQUZSb25vS1VleTZINlhu?=
 =?gb2312?B?eXlvZWVlQk52V2tJWERjNHJhelZ0TWNGWVhlZzRzNytQVk0vanhHd1FMbElx?=
 =?gb2312?B?TTBZSm1HQURDMjNFUWVYMk5oUUtZdEphd0dOelIxMVhqQWEzb0hQTzkzZDNo?=
 =?gb2312?Q?1FeXsIGnxxN3uynEyI3ubXSGE84Lzo8IjVcAtFZsid2g=3D?=
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB1309.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c64d2831-18bc-4b6e-3369-08dd9203a690
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2025 09:50:53.3488 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P300MB0384
X-Mailman-Approved-At: Tue, 13 May 2025 14:28:49 +0200
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

V2hlbiBib290aW5nIFJJU0MtViBFTEYtZm9ybWF0dGVkIGtlcm5lbCBpbWFnZXMgKElIX1RZUEVf
S0VSTkVMICsgSUhfT1NfRUxGKSwNCmV4cGxpY2l0bHkgcGFzcyBTTVAgY29yZS9oYXJ0IElEIGFu
ZCBEVEIgYWRkcmVzcyB0byBjb21wbHkgd2l0aCBtb2Rlcm4NClNNUC1lbmFibGVkIGtlcm5lbHMn
IGJvb3QgcHJvdG9jb2wgcmVxdWlyZW1lbnRzLg0KDQpTaWduZWQtb2ZmLWJ5OiBab25lLk4gPHpv
bmUubml1emhAaG90bWFpbC5jb20+DQotLS0NCiBib290L2Jvb3RtX29zLmMgfCA1ICsrKysrDQog
MSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvYm9vdC9ib290
bV9vcy5jIGIvYm9vdC9ib290bV9vcy5jDQppbmRleCBhM2M3Y2I1MzMyZS4uYTBmMzEwYjEzNTkg
MTAwNjQ0DQotLS0gYS9ib290L2Jvb3RtX29zLmMNCisrKyBiL2Jvb3QvYm9vdG1fb3MuYw0KQEAg
LTQwMiw2ICs0MDIsMTEgQEAgc3RhdGljIGludCBkb19ib290bV9lbGYoaW50IGZsYWcsIHN0cnVj
dCBib290bV9pbmZvICpibWkpDQogICAgICAgIGlmIChmbGFnICE9IEJPT1RNX1NUQVRFX09TX0dP
KQ0KICAgICAgICAgICAgICAgIHJldHVybiAwOw0KDQorI2lmIGRlZmluZWQoQ09ORklHX1JJU0NW
KQ0KKyAgICAgICBibWktPmFyZ2MgPSBnZC0+YXJjaC5ib290X2hhcnQ7DQorICAgICAgIGJtaS0+
YXJndiA9IChjaGFyICoqKWJtaS0+aW1hZ2VzLT5mdF9hZGRyOw0KKyNlbmRpZg0KKw0KICAgICAg
ICBib290ZWxmKGJtaS0+aW1hZ2VzLT5lcCwgZmxhZ3MsIGJtaS0+YXJnYywgYm1pLT5hcmd2KTsN
Cg0KICAgICAgICByZXR1cm4gMTsNCi0tDQoyLjQ1LjINCg==
