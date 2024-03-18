Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80352C54E5D
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 09:15:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE17F87CB1;
	Mon, 18 Mar 2024 10:15:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="TdjXSUi0";
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="1lVUAMjx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F46F87D46; Mon, 18 Mar 2024 10:15:54 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 831FD879F4
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 10:15:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Mihai.Sain@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1710753350; x=1742289350;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=6pyOHssMx0rhGdkNktfkdTA8zi6DtHZX8YTo6IdrID8=;
 b=TdjXSUi0UgMdXNyWsbcHi4E4u6ajc6TNPZHZ+heWIiLMBtd8P5nGt0ve
 FdnIY5C8iT8bMlPzT0mDWuR6DLcyaqNOiUzUAjBGjovSc+HZ2Clmj0lj9
 pWn8D6wrxn2E7HVKzMNEudzgI56E4IQH2KvgQKGZs+wqbd0seawFP51np
 4KvjU57On3ILdD+L9C1yFQtBp0fONjSVTYlcK2xSwMTq7ct2qvzyQc8bD
 xkoOnCQblXHaH5nQMhsLPTDC9IAPM4U6VrWnV6ZvGKXbw9n+MFSm7/mVm
 N+OONklN8Lfx5kSXeP8fFORA5DHinmeUYpDbVffAVHDZ9eh7CICfBHh0H g==;
X-CSE-ConnectionGUID: 3oisjJVSSwCTYwIWD2v+hw==
X-CSE-MsgGUID: U7HsYCITSvm/ERyqZNDhOg==
X-IronPort-AV: E=Sophos;i="6.07,134,1708412400"; d="scan'208";a="17778690"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 18 Mar 2024 02:15:48 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 02:15:31 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 02:15:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEV6twopH5zNLubAehv1QGb2KRwg5ijZdJXIZc0s66Kzs/ubsTXAo/llNDzssrLlMO4MFD5dFyXQXh5Doyno2V/JhNBVp+OPVNS/3EjSkXrzx3TlVz1zPIgvEhhYHDIFwM9HlQ7Xnd9OY70FIkUmgfORU+9pJl/4ZzT5/BGpBRQUXiL8ybAH+8iQLBRoQHyUhUKbK9+7T+b98vqspjZ/VZytr4c12aE+X+YjLK0xuwdE72iFNqK1qap+bOqqm7znMe2eR/o1rneNbnsEvDhbYT8ODKQAd8KMRXK3qcJXnOnScdZIe7HMOvFz1ORxe+ypIvacAxcwc4yTIAaAMtLtsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6pyOHssMx0rhGdkNktfkdTA8zi6DtHZX8YTo6IdrID8=;
 b=YyCBvbeEgaPoB6XEDoNkKkGyd4DRk5k3k+kwocBzwl8fD5HxUWqWvPhDsCtExm+uGL6O9LfZ+aY86qbWlRc7d2S2lpCKta4DlXlwBDuJeP9PgnM3d6jCPCEBlDkYjJPOIzMLu7UeW8/uliGaNSt+qaHqYuoAsuJzX0uNSe+/GA0qwtm9ZKHj9mMHckfnBUO6DbDj0xo0+Gd2MEGeGl+MKYSjeGS7pxo2brhgqtsbwuz4pi+74I6YWZ5RIIZ99r6RoLTZMO+iThu0XJGSOsBGR++4cyv92+pag1AuYUx+wVMqT2acU00sJxrDzD+SizRDj+908z83Al7RaXFbF3u3YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pyOHssMx0rhGdkNktfkdTA8zi6DtHZX8YTo6IdrID8=;
 b=1lVUAMjxevyvBmIOIzgB4IrF9AiEAoldO7QN+thA5Ot5I+O8XeywAiIec5muDfYIq3AJ/hLlDpiVTmEbdxoMln5PgRZ4PJIWBB/KicfDsdjR8x2qPx2PSJTGsiLWmVy8CWH45RpEgw2Q2/QoJvOwDskd27Wcvi5yPcO170OzjjrpvXQNu4SlIYts+Cf4C/j1lwSQoBWP9eoLxQMpy3l3HqnTETfVeDjFZVUutV+tVRQ/6k1DwARs0HsyKqIjfz5BvaN3cXZ+WpdqZGJ0rCepSv4GiM3t8azZArTujtGLCkD0c+OocsFPSG838d/HB9EuK+wukI+9c9onQXDGII/eEw==
Received: from PH8PR11MB6804.namprd11.prod.outlook.com (2603:10b6:510:1bc::6)
 by PH7PR11MB7985.namprd11.prod.outlook.com (2603:10b6:510:240::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Mon, 18 Mar
 2024 09:15:29 +0000
Received: from PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::8724:4f0d:7186:266c]) by PH8PR11MB6804.namprd11.prod.outlook.com
 ([fe80::8724:4f0d:7186:266c%6]) with mapi id 15.20.7409.009; Mon, 18 Mar 2024
 09:15:29 +0000
From: <Mihai.Sain@microchip.com>
To: <eugen.hristev@collabora.com>
CC: <Balamanikandan.Gunasundar@microchip.com>, <ada@thorsis.com>,
 <michael@amarulasolutions.com>, <u-boot@lists.denx.de>,
 <dario.binacchi@amarulasolutions.com>
Subject: RE: [PATCH 4/4] mtd: nand: raw: atmel: Introduce optional debug
 commands
Thread-Topic: [PATCH 4/4] mtd: nand: raw: atmel: Introduce optional debug
 commands
Thread-Index: AQHacHYz5NjLBjcwWUSp31aMRMD+07E9M2MAgAAHzoCAAAQkoA==
Date: Mon, 18 Mar 2024 09:15:29 +0000
Message-ID: <PH8PR11MB68048E53C58FAAE710FE51F3822D2@PH8PR11MB6804.namprd11.prod.outlook.com>
References: <20240307091014.39796-1-ada@thorsis.com>
 <20240307091014.39796-5-ada@thorsis.com>
 <82a5ea3c-ab95-4460-9685-2676fe18d6b5@collabora.com>
 <PH8PR11MB6804301C3B361D21EADCEE71822D2@PH8PR11MB6804.namprd11.prod.outlook.com>
 <00241bf0-2543-4836-b43f-1b6452caf2e6@collabora.com>
In-Reply-To: <00241bf0-2543-4836-b43f-1b6452caf2e6@collabora.com>
Accept-Language: en-GB, en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6804:EE_|PH7PR11MB7985:EE_
x-ms-office365-filtering-correlation-id: 3e128c4d-7a0c-4eb8-bdf6-08dc472bf4e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OHdN41vHHWmXqrY9/aSaYHeT9Od8/BN+yjdRY5tX0H0EAufBJDwaxyfwT8XaosVJBfVcFhbjIqC4IqN0cU4QdROJeeLcD+Iha78Zi4VPij0hYXtsierD7vl1/SyDzEWMZlTpvchr+AM7TJXKAa4G5ghA/HQ+KkdYDsQVI38dwGP73fT58McTZgNHOJw8L6Uq0Z7f/ZwUWvp56TPx/dK3PisEtab9lWMxIY/+ej7uRVHQjCamhMa0TmB3uuorqGwKSmSuP1FkazrINrr9d+oKdNvx7zmlsYd7AV6t2zS//mrydKCLIssXXLb1J9n91/a0OUvEXZQekTDId2sUIMM0UGf8wHdZpi3E6Fk7iVvRkQdjG3mT4mb0WNfBtOpeq8DyjC3JdbiIRRScMH0p3hSk5I2zne4UQ06fvTPg+dItbB++tg417XjdCvVCxU2cm+2kgcrCgVGRpRDK/KJtN85GeNAbMd0UBFdjX5Omsy2aHuCyYNoL+wKVcfmgKmM5HqgxCoBPvqPs167/mx1Aisz3TEl/qVraTNm6ZRcNZbQgFT57MaJyUD2zsJ7CaWzo0pNTdkGfgwlWUX9dmTYOxM9yFqJSnjggk4v7jIx4j8gR01KdXB20TMpyLO/e5QvnYYQTiFKF8PfML9+/WGKyYJifiHxgyJyf2baj3Vv//Wdng9s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6804.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VTRjZ1pGQmNZUzBzVVJnYzhyMDBqUU9XcTV4Z0pMdGUveUk2ZDd0YmtwS1VU?=
 =?utf-8?B?cS9PSHU1VU9tak5TeG1jQXhsQlY2VWVYQ2F6TzZWNTNwYW5PV3BwdzBmNVlI?=
 =?utf-8?B?S1M5a3lLRldWV1F4U05XK2k1eFY1cE0rTVZObVZTZVp1QlVwd0orTzBCRE9q?=
 =?utf-8?B?R2tpeXBocXhGNWkzN0pYSEZ2SHFzWkk2eXhJTXFxK1hBdk1jbUlJYml4ZFVH?=
 =?utf-8?B?d1M2UGZLVmNLZDlabXFtNmNzUnpGWTFSOEhRb0FlUHZNaG9PRFVtTEhvVEZJ?=
 =?utf-8?B?czArY0NLMUprcUI2TnBQSUxBWjJWYnNkbmVhb05SUkVaeDlGRTc3TnBCak9n?=
 =?utf-8?B?aVIxRThPb3EwS3Z0Ymh2eDZmcWJTUkk1MzNtcEhWTlJrbGhTU0hHa0F5WnFu?=
 =?utf-8?B?b1NQUzBaZ1pCbnNJS3dLZTB0MzZpdFp1RUtzWnA4VU9uY2RoS0llVVNqN1pF?=
 =?utf-8?B?M0lFcDIyZnBTOTRNdktvejVTVjJITnBYZGVQQ1VjcVVlSmJNdFpsblZTK080?=
 =?utf-8?B?bmkzVHcydzFvcjF1N1NKd3VKTEx5bzVIVVdJWTIwd0dIL0lGR1RLQThsY2kw?=
 =?utf-8?B?UjJFekRCRlR4VGhjOCtiMXlocVBOY0Jxa09PTERmS0FUb3pWNXFHcHZCNGFh?=
 =?utf-8?B?eCtQRFdMUmxreUV2ZXhsSWZxTGRZcFZKQ3VsTVJUaXk3TWRQQTIwKzdDWDlr?=
 =?utf-8?B?dWtHeXhXamZGYngwY2dRUE9vRkVWc3krNlhocmxaUzYyVEQ5clNlSHBUdG05?=
 =?utf-8?B?RzhZc1J4dDdUb3Nrc0kvanZlN1NialNTU2dZd1FqYnY1eDFlS29YUkxiMURH?=
 =?utf-8?B?V0pWaWRtSzY1UUpqTUdjeTNXNFRtTXBMYVVSSFZ6VVVKWTZraktmU3gxdzNP?=
 =?utf-8?B?TVNvTjB3b1V3UzJOK1ZuSjRVZHZ1RXJObkp0anc4WHd1ME8xbkNOSnJpRk5z?=
 =?utf-8?B?UmRtV0lQTDVYem41RDRlUTBkZXo3NW4vWnJjOUtJNE9tOVN0RlRIWTV6a2dO?=
 =?utf-8?B?YjFGeGpFUnhOMTJRYldVbDY4NEYwSkNsazFBU29hWHhvbVBIaEcwYkYwaXhK?=
 =?utf-8?B?eTRFZ0N1UFBvWEF5ck1pNktCakdEWkdJeDNCUXU2RXBjdjNRdVdVRXkyRVIy?=
 =?utf-8?B?NU4vQXpJOUp6NUdaV2NuTlRGc0VGUm1GNEtiZDF3R3BzQkNRb1pIblZlbUdI?=
 =?utf-8?B?QVhXTWNKN3BBWWhDdmIxSzJ6aTJ4elM0V2FhaE1wTlBCV1ZKc0lBeFVManBF?=
 =?utf-8?B?azdpakVNYVo3clNDQ2Y2bk5RSFB1ZzBsbzhybEFJUmptUW5hRDlpNEE1R3Rw?=
 =?utf-8?B?eDdZK1MyZWlENHVkNUQvQ1JWSWxGT1pHejAzMFdxelBZc1gzT1YxNnJRZ3dK?=
 =?utf-8?B?RkZYaDZSVEp1cVBKdjNnZFNrSktTNlVML0FrcU9Cdm5OVWxpU3VxY0lzZm5m?=
 =?utf-8?B?K2NGZ24vREx4aEF5di9BQ1ljS0h3QndreWM5L0srbXFOVGRCazBtVjkzV1pN?=
 =?utf-8?B?V1hDNml5YnA1VTdIN2dkYVdLRGFxQlBXLzVKSHlPRDZ0cVhqNHUrZG96a1JF?=
 =?utf-8?B?UEhva1FYWFo5RUx3bXA1UTNVNXdyaUYvZ01zeEhNZ1R4L0tjOUlHeHF5VmFp?=
 =?utf-8?B?UlVTUC8zc2NJZEUwYlJQR290SUxZZGxINWxialVBcGpkSUFQcUlhS0dsOW9M?=
 =?utf-8?B?ZldxdWUxTWZvVEZQRDg4OE94WUkwUGVLd2xxbXhjNkFPOFpOZnorbVlYTGNr?=
 =?utf-8?B?VzNjT0wyYUJwNStKeVIzREFIb1ZVaVczTzlvdExuVGtJcEpYMEhIVnludEFn?=
 =?utf-8?B?RVNtcTBoaGEycS93cEwwNUtpb1BqUUF2cS8velM3YkFoYlZWL1prUXZSczY3?=
 =?utf-8?B?UmMzNEJWQU8wNHZUbmFIc0V0L1FpOHZTVlZDVzBxUGRwcDFRbDRKeDlLQ2NH?=
 =?utf-8?B?eVU3djJFWUV2ZzhQMTlETldmUGs3K2hpa2NNNFRDMlMzZjF0S3Ezd0hpS1pm?=
 =?utf-8?B?QWJ2NU9HVHAyQkF6UjNFZndhVUtpVnkxdW9RK0IvQVkzclJ1S3UycDRSS2ZC?=
 =?utf-8?B?cGtVdmRQMERjZ1doMjhkNUU3K3l1VTVROVlJdHZYN1pyNkFpelJWa3FnTUFq?=
 =?utf-8?Q?ffU599WaNKUk8RfH3hC5vjT+c?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6804.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e128c4d-7a0c-4eb8-bdf6-08dc472bf4e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 09:15:29.7060 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1VE3BJh+BNALSxk/pYT4OqTJQPA+rWYvSX+kkz6omNeoZoOkF3m1DVJP+3gYteEyVzKuG40dZbTGlNtYsnXisON4pBpRcnHMGrtIu+wV6sg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7985
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

PiBIaSBBbGV4YW5kZXIsDQo+DQo+IEkgdGVzdGVkIHlvdXIgd29yayBvbiBzYW1hN2c1NC1jdXJp
b3NpdHkgYm9hcmQ6DQo+DQo+IFUtQm9vdD4gbmFuZCBpbmZvDQo+DQo+IERldmljZSAwOiBuYW5k
MCwgc2VjdG9yIHNpemUgMjU2IEtpQg0KPiAgIE1hbnVmYWN0dXJlciAgTUFDUk9OSVgNCj4gICBN
b2RlbCAgICAgICAgIE1YMzBMRjRHMjhBRA0KPiAgIERldmljZSBzaXplICAgICAgICA1MTIgTWlC
DQo+ICAgUGFnZSBzaXplICAgICAgICAgNDA5NiBiDQo+ICAgT09CIHNpemUgICAgICAgICAgIDI1
NiBiDQo+ICAgRXJhc2Ugc2l6ZSAgICAgIDI2MjE0NCBiDQo+ICAgZWNjIHN0cmVuZ3RoICAgICAg
ICAgOCBiaXRzDQo+ICAgZWNjIHN0ZXAgc2l6ZSAgICAgIDUxMiBiDQo+ICAgc3VicGFnZXNpemUg
ICAgICAgNDA5NiBiDQo+ICAgb3B0aW9ucyAgICAgICAweDAwMDA0MjAwDQo+ICAgYmJ0IG9wdGlv
bnMgICAweDAwMDI4MDAwDQo+DQo+IFUtQm9vdD4gaHNtYyBkZWNvZGUNCj4NCj4gbWNrIGNsb2Nr
IHJhdGU6IDIwMDAwMDAwMA0KPg0KPiBIU01DX1NFVFVQMzogICAgMHgwMDAwMDAwMQ0KPiBIU01D
X1BVTFNFMzogICAgMHgwNzA0MDgwNA0KPiBIU01DX0NZQ0xFMzogICAgMHgwMDA3MDAwOA0KPiBI
U01DX1RJTUlOR1MzOiAgMHg4ODA0MDJmMg0KPiBIU01DX01PREUzOiAgICAgMHgwMDFmMDAwMw0K
PiBOQ1NfUkQ6IHNldHVwOiAwICgwIG5zKSwgcHVsc2U6IDcgKDM1IG5zKSwgaG9sZDogMCAoMCBu
cyksIGN5Y2xlOiA3ICgzNSBucykNCj4gICAgTlJEOiBzZXR1cDogMCAoMCBucyksIHB1bHNlOiA0
ICgyMCBucyksIGhvbGQ6IDMgKDE1IG5zKSwgY3ljbGU6IDcgDQo+ICgzNSBucykNCj4gTkNTX1dS
OiBzZXR1cDogMCAoMCBucyksIHB1bHNlOiA4ICg0MCBucyksIGhvbGQ6IDAgKDAgbnMpLCBjeWNs
ZTogOCAoNDAgbnMpDQo+ICAgIE5XRTogc2V0dXA6IDEgKDUgbnMpLCBwdWxzZTogNCAoMjAgbnMp
LCBob2xkOiAzICgxNSBucyksIGN5Y2xlOiA4IA0KPiAoNDAgbnMpIFRERiBvcHRpbWl6YXRpb24g
ZW5hYmxlZCBUREYgY3ljbGVzOiAxNSAoNzUgbnMpIERhdGEgQnVzIA0KPiBXaWR0aDogOC1iaXQg
YnVzIE5XQUlUIE1vZGU6IDAgV3JpdGUgb3BlcmF0aW9uIGNvbnRyb2xsZWQgYnkgTldFIA0KPiBz
aWduYWwgUmVhZCBvcGVyYXRpb24gY29udHJvbGxlZCBieSBOUkQgc2lnbmFsDQo+DQo+IEJlc3Qg
cmVnYXJkcywNCj4gTWloYWkgU2Fpbg0KDQpIZWxsbyBNaWhhaSwNCg0KSWYgeW91IGhhdmUgYW55
IHN1Z2dlc3Rpb25zIGZvciBpbXByb3ZlbWVudCwgY2hhbmdlcywgb3IgeW91IGFyZSBoYXBweSB3
aXRoIHRoaXMgY29tbWFuZCwgaXMgaXQgdXNlZnVsID8NCllvdSBjYW4gcHJvdmlkZSB5b3VyIFRl
c3RlZC1ieSB0aGVuIGlmIHlvdSBjb25zaWRlciB0aGlzIGlzIHVzZWZ1bA0KDQpFdWdlbg0KDQot
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tDQoNCkhlbGxvIEV1Z2VuLA0KDQpZZXMuDQpUaGUgY29tbWFuZCBpcyB2ZXJ5
IHVzZWZ1bC4NCkkgd291bGQgbGlrZSB0byBoYXZlIGFsc28gdGhlIE9ORkkgdGltaW5nIG1vZGUg
cHJpbnRlZCBmb3IgbmFuZC1mbGFzaCDwn5iKDQpBbHNvIEkgcmVjb21tZW5kIHRvIHByaW50IHRo
ZSBtYXN0ZXIgY2xvY2sgaW4gTUh6LCBhbmQgdG8gcHJpbnQgdGhlIG1hc3RlciBjbG9jayBuYW1l
L2xhYmVsIGZyb20gY2NmIGRyaXZlcjoNCmh0dHBzOi8vZ2l0aHViLmNvbS91LWJvb3QvdS1ib290
L2Jsb2IvbWFzdGVyL2RyaXZlcnMvY2xrL2F0OTEvc2FtYTdnNS5jI0w0MTANCg0KVGVzdGVkLWJ5
OiBNaWhhaSBTYWluIDxtaWhhaS5zYWluQG1pY3JvY2hpcC5jb20+DQoNCkJlc3QgcmVnYXJkcywN
Ck1paGFpIFNhaW4NCg==
