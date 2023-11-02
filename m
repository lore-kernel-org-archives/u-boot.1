Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4060CC4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 13:55:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB810877AE;
	Thu,  2 Nov 2023 14:55:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="P9rVJ2RY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EEAA877AC; Thu,  2 Nov 2023 14:55:14 +0100 (CET)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.111.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4533F877B3
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 14:55:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1698933308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6BQe6b0rQG14XINJQsU2B3DwKSTubjQX75hRBF+AKok=;
 b=P9rVJ2RY0oUa+iyNBkqjLWGLBYQDIO3fRCZm+Fky4gsHahYSnSRcLg6d4WOxX1E9uRSaUH
 1iL+AhUkjaDCSHLS6qy+fTmceGmk34e7gPr/K95MjWGKe2SWB0uYl9rdjrpqbkkWm/prEh
 fqb3zJId5fqazyRyHRQF72BbzeGmIQw=
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2104.outbound.protection.outlook.com [104.47.22.104]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-2-IBV3N1MGMEeb64SiHWBSpw-1; Thu, 02 Nov 2023 14:55:05 +0100
X-MC-Unique: IBV3N1MGMEeb64SiHWBSpw-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZR2P278MB1131.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:5e::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.19; Thu, 2 Nov 2023 13:55:00 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::a3b:50bf:57a:b96b]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::a3b:50bf:57a:b96b%2]) with mapi id 15.20.6954.021; Thu, 2 Nov 2023
 13:55:00 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "tf-a@lists.trustedfirmware.org" <tf-a@lists.trustedfirmware.org>
CC: "festevam@gmail.com" <festevam@gmail.com>, "uboot-imx@nxp.com"
 <uboot-imx@nxp.com>, "sbabic@denx.de" <sbabic@denx.de>, "ping.bai@nxp.com"
 <ping.bai@nxp.com>
Subject: TF-A Hang on NXP i.MX 8M Plus QuadLite
Thread-Topic: TF-A Hang on NXP i.MX 8M Plus QuadLite
Thread-Index: AQHaDZQrk4OkjTlT9EeRsmEIZbzMUA==
Date: Thu, 2 Nov 2023 13:55:00 +0000
Message-ID: <b252bceb2344db8df8cbdf4988625c7157d1708a.camel@toradex.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|ZR2P278MB1131:EE_
x-ms-office365-filtering-correlation-id: 4480d5c8-3c67-4101-03c1-08dbdbab4e6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: p6DTvNcN6LuXtyOSZWTf+nRzVcLW4IFqM7SmEswfDwvTZTXW0nAxqkcGwkoQ2ctLiREuKDuSdM3KjZoiDheqmk7gqguBgaUyP3Qrp8qtYiJntWigHCcd6gGSmNG03OsyF99BBhtXxnf/QLNPS/DpEIRJMctiTSmyq+ju/YV9CuaU2Lq/aAqgesK8/Ah8uzAc93ZLInoaBSNBDfEB0cXcf0yFODEsOthsvVqYn0tm9pKIAFpkaGqaFhUqY0LGq+24lupJGkOevP5C1XxwXEYJxoXg0yDS31gJ+hx0Jeqy8wDjAl9xIfGSgBo0A/GSFIRa3/1k2kqc6tKOaMLpBQP06gwIoWT5TP6cNLomp8p23S3+xRbeDeDFc3q0xHN3gur5GnAcMxiXXCjpnkLDGJzLpCyUz2AZ60PdN1+2nTcE0j8BQZEBWRY6FXg6FPCoyzCYo3A9x4U/9UDYCCH8yivHTSqHGa9UKNLSfXUn1eXz83kWuTxEeKitJxogumEscxmzrrTAqSCB9HWh/qZPYeTaGzYqUP5Y6nRMTQpA6PlGqfSTo97jduCSgMOX3o3wpfQLgDDIHhDAqtMhKc5q1RhPlWq7zxHtyZpfrYktl6GJ0Ws=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(366004)(396003)(136003)(376002)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(2616005)(6512007)(26005)(38100700002)(38070700009)(36756003)(86362001)(122000001)(2906002)(83380400001)(4744005)(478600001)(71200400001)(6506007)(4326008)(966005)(66476007)(66556008)(8936002)(6486002)(316002)(66446008)(8676002)(64756008)(54906003)(76116006)(66946007)(5660300002)(41300700001)(44832011)(110136005);
 DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWxGb0kxTWt1QXVFTjlRdWQzWnlGMlVYbzdocDEwMTIvWk1RRnh1WHptM0lM?=
 =?utf-8?B?amZsbVhhNy9vZ0JUUGZvMGpFdDRqb09PaS8yZ0JTbllvUDVzbnRSR0kzY1VE?=
 =?utf-8?B?UTZPS3BaUGZwNmhKOWhLMEUrUG9aOEhrWEEzdXBSTTI5c1Z0WHQzYlQ4Y3Zm?=
 =?utf-8?B?c09pUURCY1lTTzNySTY2M0tzUGxzeU1GcnFMQWVma3NBRXR2ZHYva1FHQmZ4?=
 =?utf-8?B?VlRlTGJERmsyVmtBaVlPM3lrSjN1OUtzSmJ6NnUxRGg3VkZNSVpmSUFFR1lT?=
 =?utf-8?B?ZE1jV1dZL2ZWd3RUK1R0MFlQcUtkM3Nxd05FZGIxOHQ4cUZhbUJ5ekVzUkY5?=
 =?utf-8?B?Vk0ya1pjK1A2NTdsRDNGcnZjWTV4S2VjUEwwZmEzWGxGVVFUaHk4d0RjTWgv?=
 =?utf-8?B?NnpndnJRM1RaRHZmY3N6QmNRY05OS3p6ZDRBT1JqN0tZamNRdTFYZjJva2Ey?=
 =?utf-8?B?aFlla2NXZE5hMC9QQlB0V2h5cTV4aWFHbnhFUStjeEtBdWhYcGhQVld1MWh2?=
 =?utf-8?B?VTZEb3ZMRXFJQlNJODVSc2dJaDA3bzBuWTd5M1E2d0QvRmlzUWtOY1FGWWsz?=
 =?utf-8?B?V051QnYzZmlEZDhPdDd2OFhYOVN6bXFkaVlaYzRudHVzVkJYbWo0Tk9DMzlE?=
 =?utf-8?B?cHFKUUlmQTRaT2ErcTBadXFOUkZvU2swRDhLbHRyRHNZWlJRTC9vcFpmOVNU?=
 =?utf-8?B?bVMrdElGZEJuYUFSdjNEYmRobGc5YXFzeFN0NWNJcHdqTmttM05NbHV2R1Mr?=
 =?utf-8?B?Tzl5RTVuV2drTkFreDVKQmwvNDVUbTRqbENaUlhjd3hvQzhxM2V2QjlBWHZU?=
 =?utf-8?B?LzhtTVg3SG9zeHpFejFrbU1iWUlOU0s0Z2d1anFrRGkvN25uRStydFgwaXhF?=
 =?utf-8?B?bFN5ajlWQy9wWGdzWmxWTmRjbTJ2ZGtCeVZRQUJsZFB3b2ZWeGpjZ2QweTdF?=
 =?utf-8?B?NWlFUGxueGczMy94OE02RXdnRmE5OVpnVU90WTRRM0MxUU8xanN0a1RvRmdx?=
 =?utf-8?B?VTZMZHgrWDJSMmFrTndXQ2JiTFk5Uk1PcERYN04xM1dqU0RYWnRvelZVVzNy?=
 =?utf-8?B?bjQwNjNDbFJzZElUTmhKN3MyYzZQb1FCZk1mNllUZStMdU4xZ3FFcUdHbHVa?=
 =?utf-8?B?dnc1a1BRK0FueXhSQ25wUE9lQitJK3RRK2JOKzcwcVFmMTkvTURrRGRqZ3Rh?=
 =?utf-8?B?M3pYMnNRYmJPeHdvU1N2d2hmamZHRW1sTDV1cTlnd1NQUGl3VTQ1NUFkbkJt?=
 =?utf-8?B?OWtweDYycDgycWRpd2kvcUowWGsyczJFODdITXgyK0lmQ3NxVkxKQVpnUFh5?=
 =?utf-8?B?QVNFa2dkSW13M1MzbFA5Sm5CM3ZkRGNEQ0ViRE1YQzlxMDRoRElCM0EyRGlV?=
 =?utf-8?B?cXRNMGU5SHpuU01yci9aMkF6bG5pdFF2MU1sSEttU0NwbGNhWko2RklXZkZ6?=
 =?utf-8?B?Yjl1S0JreWNLbkJDMVZCTXgxNll5dEcvMkZ2ZUxmNDJuYldWcHpGS2lGSHo0?=
 =?utf-8?B?Y2VTSS9lQlNLblFmeEI5M0pDbVIyRVUzN1A0MFIwOXJTdHU4bTZNdk8yT1lI?=
 =?utf-8?B?SS9LL2dEQU53enRTU0V4N1YxSnVEVzl3MUkrUkNDSmFzL0xOQzVqaUdWaVho?=
 =?utf-8?B?eXNucFFCZTBYYUdkc1V5VC9IdnNKbk5OTDF2a3dFbVJCOEhmSlZuYmhkamE3?=
 =?utf-8?B?TXpsUzdGTmVGTmdlRkNZNnAwdlRpTE5RV1RHSGlWSUEvRjBMbkVPTjNDN0tx?=
 =?utf-8?B?SHNmMW5JamdhNjhjQTRBU2Q0TExVdk9iaFc5M0ZpMEw0MU1JWXZFd0VaWTZP?=
 =?utf-8?B?cUZIUms1UDJmeWN5R0o3bXlKNDJKRWlPdndUcS9DSkEvcExsRDlvaERFNWwx?=
 =?utf-8?B?OWxjZ0Yzdi9PVGlhZE5kdWZzZlkyUm4yeWdnTkFXMmFPTllnVXZjRGFWdGov?=
 =?utf-8?B?eTY4Rjh6TEdkcWxBVENaeHJ3VUtOSVU3UDFaZjdhYUJzYnU0bjRaaDViaGJm?=
 =?utf-8?B?VTE4RVowaHY0OTdRaDUvbjIvWUc1VXdxVENNRHRoYnRkRHcyU3JWaVYydzFR?=
 =?utf-8?B?NjJmZVNNWVNDZUpHYWo1NS9sVnFBUk9MMU16WVRZZ1dNeGRtNThzeC80ZTUw?=
 =?utf-8?B?MG55K2xZWUh0L29PT2pqK0xnV005ZWo3dUJZTXUvNUlJMmNhVnhrYk1seGNX?=
 =?utf-8?B?OVE9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4480d5c8-3c67-4101-03c1-08dbdbab4e6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2023 13:55:00.4201 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4SGY9998gmteyC3+cbBK5IzVouM2qqS1zCVALkq0zEogqxa9o5eldfUN0WBOMFq6O5TJQSj+keDykbIIExiWG0wuTNc5VVto1a/KzJha7kI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR2P278MB1131
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <E04FDA11E1B0924396AD91DCB24C0FF4@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
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

SGkgdGhlcmUNCg0KV2UgcmVjZW50bHkgZ290IG91ciBmaXJzdCBiYXRjaCBvZiBpLk1YIDhNIFBs
dXMgUXVhZExpdGUgYmFzZWQgU29Ncy4gV2hpbGUgTlhQIGRvd25zdHJlYW0gd29ya3MganVzdCBm
aW5lIG9uDQp0aGVtIHRoZXkganVzdCBoYW5nIGJvb3Rpbmcgd2l0aCBsYXRlc3QgdXBzdHJlYW0g
VS1Cb290IChhbmQgVEYtQSkuIFJlcGxhY2luZyBURi1BIHdpdGggdGhlIGRvd25zdHJlYW0gTlhQ
IG9uZQ0KbWFkZSB1cHN0cmVhbSBVLUJvb3Qgd29yayBhcyB3ZWxsLiBGdXJ0aGVyIGRlYnVnZ2lu
ZyBURi1BIHNob3dlZCBpbXhfZ3BjX3BtX2RvbWFpbl9lbmFibGUoKSB0byBiZSB0aGUgY3VscHJp
dC4NCkxvb2tpbmcgbW9yZSBzcGVjaWZpY2FsbHkgSSBkaXNjb3ZlcmVkIHRoZSBmb2xsb3dpbmcg
c28gZmFyIGRvd25zdHJlYW0tb25seSBjb21taXQgWzFdLiBTbyBpdCBsb29rcyBsaWtlIGluDQpk
b3duc3RyZWFtIE5YUCBpcyBsaW1pdGluZyB0aGUgdG8tYmUtZW5hYmxlZCBwb3dlciBtYW5hZ2Vt
ZW50IGRvbWFpbnMgdG8gSFNJT01JWCwgVVNCMV9QSFkgYW5kIFVTQjJfUEhZLg0KQW55Ym9keSBr
bm93cyB3aHkgZXhhY3RseSB0aGlzIGlzIGRvbmUgYW5kIHdoeSB0aGlzIGdvdCBuZXZlciB1cHN0
cmVhbWVkPw0KDQpUaGFuayB5b3UgdmVyeSBtdWNoIGZvciBhbnkgaW5zaWdodHMgaW50byB0aGlz
IG1hdHRlci4NCg0KWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS9ueHAtaW14L2lteC1hdGYvY29tbWl0
LzQ3NzU5Y2ZjYTEwYjIyODZhMjE4MDYyOTE1ZDRhMjgwODQ4Y2ZjMTUNCg0KQ2hlZXJzDQoNCk1h
cmNlbA0K

