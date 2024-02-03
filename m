Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C153C4828F
	for <u-boot@archiver.kernel.org>; Sat,  3 Feb 2024 02:56:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1ABD487F7A;
	Sat,  3 Feb 2024 03:56:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=matrox.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=matrox0.onmicrosoft.com header.i=@matrox0.onmicrosoft.com header.b="mWBi04Dy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82C8187F7B; Sat,  3 Feb 2024 03:56:25 +0100 (CET)
Received: from CAN01-YQB-obe.outbound.protection.outlook.com
 (mail-yqbcan01on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:241d::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 569B587F76
 for <u-boot@lists.denx.de>; Sat,  3 Feb 2024 03:56:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=matrox.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=agendin@matrox.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBjwbcIbzcKJkmO2F2WXipBHPqVWLq0BdPJqNu7hV/g8JKi7InOA89ooGYh4PgUprRmPew4osa9abN4tNBKQm00L+ToRXiab72yNWseiMYO0bEfFMbZsLpYfxOyl5btVQu4iuD0sPHOR9Sft7jVY+zFtaDXm7O9SKKNWMSByxSuwQP1/zRAsOO01qa6UX/fJwjrAUG3A4tXX4Chb86zFYCGJ0w7mFxkf8m/gau6xqGUFNSzR1yjmSwPC/5+A8xv678MeIu+pjnFdFv34pE/u31hB4H0TuqTiYwsyKA0goyda5qwUa4JB0UgmxeqYawaus5t5tWRDchtpFY6SVisKQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWRFDJaxE+EROPBlB3eZtOuwKuChnacxcnqAL1aW8O0=;
 b=cm0raFTgPF8QSs2uSUKO7fO6+33heqL56OCTpwIEeweV63XRrTOf3WJcVW4L1HCwUmYocpmTdkqX6MKsLIYJ0jri3DitdxLp3W3m4OPacuENiYRRooiEwFPIzzNcOT4KJvRlxopcN3VUsFqMZm3rwvQvXSfT8LqlmLHJMJYu5lqqAR835X66sm9BQM5DfWyDo2q6r2pGeA+xSKerMgDAcukRBN5Yy2kjBnEPeNSEp7GmqTrIXcg8Ijrj3GnhvzyvyBJSqKjmqTEvpYh/3lS1JMbx9AGo6EX/fu5JnoCEI31ymBt3o6d0pGKejoyQOSsyCcdOirlaswN1Gx2tTScZog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=matrox.com; dmarc=pass action=none header.from=matrox.com;
 dkim=pass header.d=matrox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=matrox0.onmicrosoft.com; s=selector1-matrox0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWRFDJaxE+EROPBlB3eZtOuwKuChnacxcnqAL1aW8O0=;
 b=mWBi04DyYjBAqFU0B4lll5QtGgmWJnUGoIJpoAGA7nB9aUfO/GXSWc6fYhrbbTy1Z1ffW6DgsvKmQtqw1EbAqBgPHkbQgVkYV13laQzUTRVxrRcDTBNUY+Mp7pWJ3qIvtU73TYdI2Z8rD+Yjq+LJ/T5VbzXKFcJ5FPQXGmKhOq8=
Received: from YT3PR01MB5626.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:60::18)
 by YQBPR0101MB6007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:36::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.31; Sat, 3 Feb
 2024 02:56:20 +0000
Received: from YT3PR01MB5626.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c169:d317:47cb:8715]) by YT3PR01MB5626.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::c169:d317:47cb:8715%7]) with mapi id 15.20.7249.027; Sat, 3 Feb 2024
 02:56:20 +0000
From: Alexander Gendin <agendin@matrox.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] test: cmd: mbr: Fix Smatch static checker warning
Thread-Topic: [PATCH] test: cmd: mbr: Fix Smatch static checker warning
Thread-Index: AQHaVkyQJirSjOsD2Ei1YGIUoTGLYw==
Date: Sat, 3 Feb 2024 02:56:19 +0000
Message-ID: <Zb2rU_JCEkRionLj@alg-gentoo>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=matrox.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: YT3PR01MB5626:EE_|YQBPR0101MB6007:EE_
x-ms-office365-filtering-correlation-id: 5b6ed47e-d6e4-4073-1d99-08dc2463b2c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mhTZ8tCL3yoOWVo2/9/ZH0czq+18OlLlBIwtr958AfIOKPlVp3ZZCTw/Fa1IzHI853RzQ/Hf4mkwF4YaFWJRhmFkX6zS8BervcAqjLbcXVKmahMDx5VRrkQSoyX799XcSng8nwAhZR4gOTGzUTsicmroSxn4oY640JwTYTfiSlEUTa8BW6dPioEtjuFI5dUb6mQDGkJhfMjQDIX4oRj+U2hWGUFw0Z43v5ZgGnehYKwLwawIqItlp/4xXRfLifEagna1j/KCxSemkIvjn1RUMY3zaqenkndUbvODeQiI7eyT60Yt4JtdhBxctJmpd8FtNjISoJUk8K9v45VdSQl21D3l0/olPK3ulpYzfX5sm+88zYGxxh5m2T3x6YDOnH7qa9noCAPKyxYLtMbIVfesKlXqAx+bwT/mlTGhHp3ejzC7lDF6f0q/Jx8M71WtSuWg6MpSQT72kXN1xQju6HZ6vUqB31HUho0DhdTzZGR9+/x0a2TWHCJSwiCLvkAGHiW0+Rf8Ystb1+YQOzTSKUiADEf1JQh+hsnWKSuCz+s5lRO8WPT4rk0DgHtAy6gjeOkrvIPG7nEgZUaovHAG4ydFBUMhyHeMax+JZE4cTEw1nlip0FFooGGlkkPilzyly19T
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:YT3PR01MB5626.CANPRD01.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(7916004)(346002)(39850400004)(376002)(136003)(366004)(396003)(230922051799003)(230273577357003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(26005)(6512007)(33716001)(9686003)(38100700002)(122000001)(8676002)(5660300002)(4744005)(4326008)(6916009)(66556008)(478600001)(2906002)(8936002)(54906003)(64756008)(66446008)(66476007)(71200400001)(6506007)(6486002)(316002)(66946007)(76116006)(38070700009)(41300700001)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LytoRWJtRFJlYnpqRVEwUHIzT094Vk8zSmdMbFV1UmwzTThkV2N4bGlhSnZC?=
 =?utf-8?B?Ni9VM1UydUlhcnRxRGJ1SzN1ZXRiQ0VEMUxxaG01SDh0WE8wck9BTXR2c0Vr?=
 =?utf-8?B?S2NKa0dFUU1wNWo2T1RUeGdmak9UQnVUeEUyMVlqU3hreUlSSWJGS3BuUGJ2?=
 =?utf-8?B?WHVSVWUvdnUrMmdyMFdVTG1yN1lScnJCcVdoOWI2NHRQN2wyZExJNVJjZzdt?=
 =?utf-8?B?aHZTTlIzZDZwejZaaU1lZmQ5KzFJZHFiZXhxbFNDNVJKLzZYTUhuOHhQVmRY?=
 =?utf-8?B?djkvcmJWR2s4bFl4a0xMNmpLY1lramg5aHBGUlZvMGszWkNhNUk0OW5PWDNW?=
 =?utf-8?B?K1FjVm1qY3duSVFJamhyNE1XNmhER2J1eHF6d09tMEVvT2RSckVUSCs2WUNr?=
 =?utf-8?B?cUxlSGdNRVFEMmhWUE0ybkYxbjFHRmFUbHA2ODFRdi9iSit0enl5ekZyaDd3?=
 =?utf-8?B?eWJzMW0rSS9DYmJvQnVqdDUzbmQ1QzJWR1lGWDA1MkIycVZBdzhBOENJcWMw?=
 =?utf-8?B?V1A0bVFSZS9GSXYxYkNoVUE2ZEJ3cjE1a2FWZ3VGR2J4cmgrZXVOYy9ieTR5?=
 =?utf-8?B?aDRFUWdnWW8vUk9lcmU2dndld2xUbE1FUjR4Q2NmSTJ3RFJTdUdwNURmOVEr?=
 =?utf-8?B?Q2pEMzNaZktZRG5qK2VISnpWSTE2eDN4d2NBcUpEOFJRdmRoUWtnT0dOSW9h?=
 =?utf-8?B?WmQwYWtCNGFJS25ZbjhBTG1RMWRha0Y4ZTJadGwzMmtGTGVGbG8xQUNBVE5m?=
 =?utf-8?B?b0RXNGw0NFlPSEZIdkZrOGI1TGQ3OVdKcWRpWU8yVGhpb1FrK00vb2g0SStC?=
 =?utf-8?B?bHg4QnpFRVpNTTJ6dFZ4QUczSHVHM0ZHN3NtOEw3R1laaC9haFlqVlQvZjlw?=
 =?utf-8?B?Tm9VZzR2ZXZtMEE5dUJScy95RTNRcngxaHBuQVVHbGVoQndYeVJ2aVhsQnps?=
 =?utf-8?B?ZmZnbkhYMnFaSzBtK2dCRmM0OWdGeDdncUx3T0lDVnBGNjBQQXUzMGl4TVZk?=
 =?utf-8?B?ejZyWHovYmlRZWNqMUU3c3NrUitQcnNJSTFpNG9ySitpUW0xc05sUkxONnBq?=
 =?utf-8?B?aDUxc0lrcFNNUW9hREJNcml2eXlmVFIvSm1SRzNmSWN4ZXlmMUJ1OUdQQWF3?=
 =?utf-8?B?bUpDTUpqQWZBbE9CVGxNdlBGUmNvU09MdW9MdHdJZURFMDdpblAvNTYzZnpZ?=
 =?utf-8?B?RGx4Z0VqWmtNRDNodElwOG4xOXRRTXRSRGtLVkFFV055cHQ4K3ZTNmIyS3ky?=
 =?utf-8?B?SlMyUnFGYU5rZEUyRExsQnpZOW1uK3RVdWJPMGM0b2RuRUs3d3dYMGZjTlZp?=
 =?utf-8?B?anNLZUxtckRtNUlta2h0RGJjNlpCb015OGJsemVsZnAvdUF0UWdNdGpQWUJr?=
 =?utf-8?B?aG4zaCtRWUlBV1ZtVWJ1K1pyUzNMTHZMdnRHRUpEaER2YVViOWcyQndFaVJ3?=
 =?utf-8?B?Q2I0T1ZyMkw1ZXY2Qldjam5YMnZUY1p0UmpYcXR3c2VWbHhBQklraWYvQ2RL?=
 =?utf-8?B?dy80K1FzVG0ycWJ2cHBleit4ai9BSWFUaU42WS9nYWd6c2daYURhT0kvOWdR?=
 =?utf-8?B?YzJtUUloWkdzRVJYd2JYYXpUdUxGdm5nMEo5NnIyZ0wxWWpWeTFvTU5Xc2JH?=
 =?utf-8?B?TFE4MDd3YktuV3VrT3hoL2RNMGNGSXZnbG1IT2VXeEhKWVpXK0h0cGZSYUJU?=
 =?utf-8?B?a0x3MnVlb0srbVJWM0dYMk5uMFZDMmp6cnJ0UWxqRnNFcWF6ZitZakNxMU5N?=
 =?utf-8?B?VzRYL1NvbE82d1h6SjQwRXJteW1PTnFpMWhEbllKRUlNMTc3WllJMHRCV2hS?=
 =?utf-8?B?S29aem5rc3U4OW96RjZOdnI5VFVtYzk1UHFUYndYQTFYMGZVRHFmOGM2ekhp?=
 =?utf-8?B?eVlVQ2NPMm1wd3FmMER5RlZHbG10SUlRNkpwWjVOUzhacTcyODBHR3Q0ZzZB?=
 =?utf-8?B?T2ZjY3doTlZBRm9LRFloMWFWeUlVOUtJNUxHVVQ5MUY1R3pZbmdIZXFTQUVO?=
 =?utf-8?B?a3lrbWtyV3B3YVpBZGRxRWpEc29DZVh0QmpEbWEvdzZEaEFQNFZ2cmkrQThG?=
 =?utf-8?B?aVhHSWhvTkhmQ0tXTlpPN3ZkRTR3eVY1cjNPUHRkQ1RSOWppMVJneVRFZDdx?=
 =?utf-8?Q?KKeDx1b9dKkdfAN4zTmfn9e41?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <04E3A740CB4F7F4A8F15991C8A9C4FF9@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: matrox.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB5626.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b6ed47e-d6e4-4073-1d99-08dc2463b2c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2024 02:56:19.9276 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 09c2e324-8cf7-459c-b6b4-e23db24b9d4a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cdXbALjwl5qu08Zbc4zvt5JWK1Zr8IdKctnlvOjvWogNxWoBbywWbLso00Db1srmWE5+tDSsyRC/tMKz5aIypw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB6007
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

VGhpcyBwYXRjaCBmaXhlcyBTbWF0Y2ggc3RhdGljIGNoZWNrZXIgd2FybmluZzoNCiAgICAgICAg
dGVzdC9jbWQvbWJyLmM6MjQzIG1icl90ZXN0X3J1bigpDQogICAgICAgIHdhcm46IHNpemVvZihO
VU1CRVIpPw0KDQpSZXBvcnRlZC1ieTogRGFuIENhcnBlbnRlciA8ZGFuLmNhcnBlbnRlckBsaW5h
cm8ub3JnPg0KU2lnbmVkLW9mZi1ieTogQWxleGFuZGVyIEdlbmRpbiA8YWdlbmRpbkBtYXRyb3gu
Y29tPg0KLS0tDQogdGVzdC9jbWQvbWJyLmMgfCA2ICsrKysrLQ0KIDEgZmlsZSBjaGFuZ2VkLCA1
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL3Rlc3QvY21kL21i
ci5jIGIvdGVzdC9jbWQvbWJyLmMNCmluZGV4IDQ2Yjc4ZTcwNmMuLjIzNWIzNjMyOTAgMTAwNjQ0
DQotLS0gYS90ZXN0L2NtZC9tYnIuYw0KKysrIGIvdGVzdC9jbWQvbWJyLmMNCkBAIC0yNDAsNyAr
MjQwLDExIEBAIHN0YXRpYyBpbnQgbWJyX3Rlc3RfcnVuKHN0cnVjdCB1bml0X3Rlc3Rfc3RhdGUg
KnV0cykNCiAJdXRfYXNzZXJ0KG9mbm9kZV92YWxpZChub2RlKSk7DQogCXV0X2Fzc2VydG9rKGxp
c3RzX2JpbmRfZmR0KGdkLT5kbV9yb290LCBub2RlLCAmZGV2LCBOVUxMLCBmYWxzZSkpOw0KIA0K
LQltYnJfcGFydHNfbWF4ID0gc2l6ZW9mKCdcMCcpICsgMiArDQorCS8qDQorCSAqIDEgYnl0ZSBm
b3IgbnVsbCBjaGFyYWN0ZXINCisJICogMiByZXNlcnZlZCBieXRlcw0KKwkgKi8NCisJbWJyX3Bh
cnRzX21heCA9IDEgKyAyICsNCiAJCXN0cmxlbihtYnJfcGFydHNfaGVhZGVyKSArDQogCQlzdHJs
ZW4obWJyX3BhcnRzX3AxKSArDQogCQlzdHJsZW4obWJyX3BhcnRzX3AyKSArDQotLSANCjIuNDEu
MA0K
