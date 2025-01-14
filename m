Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F70E77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 13:37:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A84E580657;
	Tue, 14 Jan 2025 14:37:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xes-inc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=xes-inc.com header.i=@xes-inc.com header.b="qN0Eb12o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35B5A8069D; Tue, 14 Jan 2025 14:37:24 +0100 (CET)
Received: from USG02-BN3-obe.outbound.protection.office365.us
 (mail-bn3usg02on0615.outbound.protection.office365.us
 [IPv6:2001:489a:2202:c::615])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A89F6805CD
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 14:37:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xes-inc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vfazio@xes-inc.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=bqVa1E51Gzwh1WmOhFPjkLzEHarZmvioi5ue0WBnMHtqYlqtnFGdns2yF7MGVu0rwayDFO4yKjoyT1TjOgomc97W07qbgdC+dN6NnhMQpBcBHY2wFQtiUPUA4ZGISl6G9LrYW8gtOjQ2VaekwE07hczGqtGHE8PzHHirx7+OQto/olCamRlKy84fI4/+6izDEsF8UxngDp0JfR//AAVvyiavhvqY+zSc+dVhsWNxufGPMRn8R1HVARMANA5PGBroQW4IPf5+Bb7SWGYCMSaiYUv+VmfRYv6zC+hWNmkeDpVikKjIqcNP9+c0XY1xtJxpSWxaM3+NQlr661RYWj5Rew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dxjc6Jubq+OguFgwwgWF5RT07UdhePqt+6guKMUb+WU=;
 b=FZsm3h1Xdb//v/xqHc/wYiaVyrq89ZNxbx758O0GKwaOxqt6eQy6MVmvR4ZdAj6odzksl4Qmrn5vDz5drQVHFSTAkHkqtAKSYOssWahv4KbXsPZ4PFZcybGSHG8juCba8nKJoQ6BAZXeS04KN33YibdKKZgdngSfX5yphgMF3mdeZMOTtIGT4gj1/XRl5oQSn4F9xIQo5ZjO983MgRxULwD8RZ7ITnKgTEKlvbUgX0DXULn8RCYBoAsNF9htbRQrKlORvEWEZgmFpOXjSwpRochPtNgcETxL+4HxX6LyF6WYEoKWiTFc5/mvKqTqm74ji9p4Qgih/mmtefuG18pHCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xes-inc.com; dmarc=pass action=none header.from=xes-inc.com;
 dkim=pass header.d=xes-inc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xes-inc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dxjc6Jubq+OguFgwwgWF5RT07UdhePqt+6guKMUb+WU=;
 b=qN0Eb12obm42hsRsKsSfGgQ1FxsSR76BSVqPlgeVhQmz2mnABb9atrPz0e0WL6PVfmh/9uHG4mccfJWv9PicAhjwXQ3L3sx3suKnGi+NGEDMKLbBrfAh+07lx0gqGcFw/HdAccJ1Jqoxeqkz+o6ErA/9gN4HQEaEuhV6m6TjZ1Ga2upcN3PzmEdEsvLQoUEtgwTarXgMR598Kux/cAVWj2H/GSSLanC0xs53VV0CY0v7D8Y5l2w0sS6z425eyHRI4NtPgRnC8HHW4y9ECYX3RVmbWcdBG5cw8G7N2deQtWTLMz+Sv92ekGF3JgKH0DW6gllNvFNcD+uD2Wv1Ui9zzQ==
Received: from PH1P110MB1603.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:18b::15)
 by PH1P110MB1203.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:18f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 13:37:18 +0000
Received: from PH1P110MB1603.NAMP110.PROD.OUTLOOK.COM
 ([fe80::71c7:106d:6bd3:fa2e]) by PH1P110MB1603.NAMP110.PROD.OUTLOOK.COM
 ([fe80::71c7:106d:6bd3:fa2e%5]) with mapi id 15.20.8335.015; Tue, 14 Jan 2025
 13:37:17 +0000
From: Vincent Fazio <vfazio@xes-inc.com>
To: Vincent Fazio <vfazio@xes-inc.com>, "michal.simek@amd.com"
 <michal.simek@amd.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "trini@konsulko.com" <trini@konsulko.com>, "vfazio@gmail.com"
 <vfazio@gmail.com>
Subject: RE: [PATCH v2] rtc: zynqmp: allow on Versal architectures
Thread-Topic: [PATCH v2] rtc: zynqmp: allow on Versal architectures
Thread-Index: AQHbZoiS6FOTqWqu5kevTb3AOAQIqbMWRJDA
Date: Tue, 14 Jan 2025 13:37:17 +0000
Message-ID: <PH1P110MB1603D6B10A41E07363849E639F18A@PH1P110MB1603.NAMP110.PROD.OUTLOOK.COM>
References: <d2ae2c87-8c0c-4496-8767-1ce5b28fbfac@amd.com>
 <20250114133040.2600232-1-vfazio@xes-inc.com>
In-Reply-To: <20250114133040.2600232-1-vfazio@xes-inc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xes-inc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH1P110MB1603:EE_|PH1P110MB1203:EE_
x-ms-office365-filtering-correlation-id: 03118209-489b-4571-0ec2-08dd34a0904e
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?PEV+a02SLLjWQfM/dQnNuYEvj5wbev7bH0DDuWEJqU94FVXYOvsiumzKRjlL?=
 =?us-ascii?Q?oZqfn1ui5PJ8JygLcFUHXHiyYzEUy/ch5vDPpV86tjWsYNI52IRiuRrVUbYA?=
 =?us-ascii?Q?7cj3jczgu1KBxoLYotOkVP4Hmkty8xvZtfhGtcDkRBlzWXcrEdED9LlDsgpj?=
 =?us-ascii?Q?Jlcsu5gUsN5NrcsRU4BpX2NKal8+fIHcqpng7ULN236mpgQ9NWRdZBMcZa/M?=
 =?us-ascii?Q?mgMAJEcrkNJ4RDLSCVk+Ox53PDBMtNfQDh3CqJ5ibNxr1/la838gp+z0YYOR?=
 =?us-ascii?Q?XrNsXlDJpJe61ZrlhlEOe/wjT61cTfC9YQXpW8msKDn7S0QJPdKHTWKfps70?=
 =?us-ascii?Q?AgM6PF6ZGnAyYFv3hGMQwykPi5R8M6KMT14ItgGRlrjKM7sQeY38xDatDslA?=
 =?us-ascii?Q?xcf6Og6vaj8DRVBJ3NGVmEws2ZgLU7aDfjtBKurywaTDtryG3Vg0ihdueS0P?=
 =?us-ascii?Q?0tk/oOZ0aDmprUFttn2XQ1ucq+p2pzDN539OKakmqzEaiOHiTIBgDBu0/GuB?=
 =?us-ascii?Q?gfP/WvCpPyZ4KE6lbv67qFFkb/xvE46Tq+AIlphQJ0KnhQoroIM9kKPEhsQI?=
 =?us-ascii?Q?ML79+WgQCh/mKNXsmNngOnffhbUFRT/WUaaNNu+bHz5jFo8T3xAxOxfkiAVj?=
 =?us-ascii?Q?KJhzHQCVSs6Mj2I6LsYay3daTIazU+cChqacwPFgz33SMuemhQdikQGfXesE?=
 =?us-ascii?Q?TpvQCm789CEBtYPJQKzWLvhO7moCfKjdybfJAUkJHuLm/VYhx/0Fi2XJtNPN?=
 =?us-ascii?Q?fi4k1X+hJwJfXBSU1DzZemoUqX/vUT8wd8Li/WxemDVNGBMEop+ogXTYLxWW?=
 =?us-ascii?Q?Vn7/GCODpvI9byUPU11TOi1O+zJ594kHFw5YXP4RU9D+J2m2l+tdDhKrxkQ7?=
 =?us-ascii?Q?EAbwnKqAzUfcGUFvZN75C2CByuETR4/9zIyn/nWQ3Idn2toy0BX2TFCZMTTz?=
 =?us-ascii?Q?S+N4oeqrnQjqMPQQUmTkGrwOi3+stXoDbcS0XJUsm8rPaoqzOoL+QK8sdXZm?=
 =?us-ascii?Q?Kjxe5WshfB+AKNsdP1ZAbXbLCnWfaCpZ7Cqt5gN62uRL5mpS3PPZ5APvgtAL?=
 =?us-ascii?Q?OUrmDEFPArehtfjZnDrZqkZBjtPJQzWfZP2RyP6dvlBhEQXxuRYMboJkR+XY?=
 =?us-ascii?Q?svx0WbGEDZAQwk6HJuxMV62bF+7E+cymHIA105DG1FesLC2e1rwHSeH/MDM/?=
 =?us-ascii?Q?yeAwOJu49+9N3Mii0MXz+GPXUWXJXKpoj3RzsOo/UuNaGefDlxjQQXtYPq1U?=
 =?us-ascii?Q?sVQKtr+qVju6vkMVjvE+ivUklU2j1zuqsLov8pWF7OaLojQpKIQaJXsQDfp2?=
 =?us-ascii?Q?wRM88/LF3CXaw3jvQoaz0WZLgYpeJmwXDmhWSsWWWnhOfRbz9u9SlGBb2q5N?=
 =?us-ascii?Q?jpH+uo+E0ii1cqHl82PrTV3nF7g0k71RGdf7VxjIV+tYQdzCTyCND0uLVN8i?=
 =?us-ascii?Q?Kbf469SrSHVMiqBb2kON7wpR378waKTI?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH1P110MB1603.NAMP110.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT; SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?njkdbYfVwQnGXO8Nrdl0tm+nYjon80cNQuEYJb2Wm6zU/j7ZxEMos81Gylfi?=
 =?us-ascii?Q?Sx9r0wUNRDxIQ9xZjb7Crnny8M8IOKQXFDB4r4HOfQJVkMzsx4zpGYtuUk4/?=
 =?us-ascii?Q?VTXRrCpIoJOcJ6r01/35u7mprUzK1vj3Q38Pc3mUuVu1GeRnShNS4XQ+snrV?=
 =?us-ascii?Q?3VCH77pTEgQQcT8NTEa1J9xGE95Fm6Agsab1Zibo/hk4VX5JYuGSsEPKboqj?=
 =?us-ascii?Q?ZyNKc7fOSCvzNIOeHYPD/RBZ+GMIC5XInoNxI26PR3D2iK23PTOv5OeKi8Lh?=
 =?us-ascii?Q?Z48eeO7cYgRxUecaf1E2ni/5BZa44Jow33C44+jF7z+mGaN85ZAF5F0wkWx6?=
 =?us-ascii?Q?Eu8H+oQHm61SYfnIhNpoAX517iPjfj1NGabb6ZOGPFAWGFkk7+eNZZ+rMKW9?=
 =?us-ascii?Q?SGrv0sPl51vwmxmPdblwuMEAv9Bzp2pdG9JoDEDHqstZ2pWj8yJBfv4L86Gl?=
 =?us-ascii?Q?H2ACAcYlhhVc7V9X6PcERbNtTj9TlmWq3D0dRriIkov4htmLY2VnTO1Mwskq?=
 =?us-ascii?Q?ay4HJW9Co6NvIj0HAVBrD0ojMiEeEVIH/GMGe+JJ95GbahpvrtVug68nx2f0?=
 =?us-ascii?Q?g0htfrGS5csECOiqYNV60kJlg77/8ZMzE9D10bE6qIjSYeFQDBDwf+anjnCl?=
 =?us-ascii?Q?29OBnPfy8oh6ZrPscMbx9J90+jUCym+zawi10PCSbxYimk4eIgoRa9RPDEaw?=
 =?us-ascii?Q?LsYLbSAzELNnoNhhfuOHokDrAArulTJ/TZ1cXyUhATXShMCDoigf43rbQm0b?=
 =?us-ascii?Q?Kqo5btWn3WjAr/tu7RcFng+8ybG2C0gK/lBjbJ9AOQUEk0foBnqv+P/SY6iY?=
 =?us-ascii?Q?ovwe9kaSt2xZurQdlDiQAWPeSCt3EtaKPAZWuA+wJAGqGhQIxnqJzbSHRq1v?=
 =?us-ascii?Q?cgEAUb/fEgvXgZ36iPLb8thEoGB2K6MSJbqwIcJ7zMGXacZwYeK6GIkoEeGG?=
 =?us-ascii?Q?48xjD8coXEhH8CmMtjA+ntnT1+5KJjIyDaVeisTGrd5tuAiWnrSdts9K1dQs?=
 =?us-ascii?Q?/H23/13RBo/TVb8uLWHEKg2hpO04usA5da0tGJAv3zC3XVijhWVQjjfpE3mt?=
 =?us-ascii?Q?7jy5u+MQrmfP28oITbB/lxeGPFdN2naCrcb/iUUUnltLJdi9ZCZqYfkRL1tp?=
 =?us-ascii?Q?48cE7iomlQ4R+0PU1Bw/FuVItcegp+Wdn/PbxozZ++Dga/uhO13f9mRuEl8n?=
 =?us-ascii?Q?YsaOzFlRo7T3XAMEcZ5D7+mKHccysdFYfsil/KFWImZgRu+8ZI9DrYlPn8EC?=
 =?us-ascii?Q?Efm+Zy8mTO7UVz70SHPUu8FpK3wELWafT5vRVUDNOiQ92UZIJFeVsZlcBWW/?=
 =?us-ascii?Q?zPUvmA7SX8m0kXabrjR7rYv9c9gAp8T2D8nBSKJT/kO5o8t7oar+bwKtSEDT?=
 =?us-ascii?Q?dCbcNnJGc5E7ftDMxuB+u/nE2tsVuRF1cYj2KNB73oGY1brK7E2AiJBxKrw3?=
 =?us-ascii?Q?ZBjmPBhCV7kl+gJw+kykaUA0g6Od4SVsA+uyEynft52kJaF/h5FaZm0o+HFF?=
 =?us-ascii?Q?+IKjeLcuMI5cq74=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xes-inc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH1P110MB1603.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 03118209-489b-4571-0ec2-08dd34a0904e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2025 13:37:17.6365 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2925f1cd-bdc3-4a76-bb38-6159e20a17f1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH1P110MB1203
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



> -----Original Message-----
> From: Vincent Fazio <vfazio@xes-inc.com>
> Sent: Tuesday, January 14, 2025 7:31 AM
> To: michal.simek@amd.com; u-boot@lists.denx.de
> Cc: trini@konsulko.com; vfazio@gmail.com; Vincent Fazio <vfazio@xes-
> inc.com>
> Subject: [PATCH v2] rtc: zynqmp: allow on Versal architectures
>=20
> Allow the ZyncMP RTC driver to be enabled on Versal architectures.
>=20
> Also, require DM_RTC since the driver uses the RTC driver model.
>=20
> Signed-off-by: Vincent Fazio <vfazio@xes-inc.com>
> ---
> Changes in v2:
> - Add DM_RTC dependency (Michal)
> ---
>  drivers/rtc/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig index
> 9c2d1398247..fe8cb254603 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -294,10 +294,10 @@ config RTC_DAVINCI
>=20
>  config RTC_ZYNQMP
>  	bool "Enable ZynqMP RTC driver"
> -	depends on ARCH_ZYNQMP
> +	depends on DM_RTC && (ARCH_ZYNQMP || ARCH_VERSAL ||
> ARCH_VERSAL_NET ||
> +ARCH_VERSAL2)
>  	help
>  	  Say "yes" here to support the on chip real time clock
> -	  present on Xilinx ZynqMP SoC.
> +	  present on Xilinx ZynqMP SoCs.

Sorry for the noise here. I had at one point included Versal in the help te=
xt and pluralized SoCs.

I backed out the "Versal" part of that out but apparently failed to revert =
all of it.

I'll send a v3 to drop this change.

>=20
>  config RTC_HT1380
>  	bool "Enable Holtek HT1380/HT1381 RTC driver"
> --
> 2.34.1

