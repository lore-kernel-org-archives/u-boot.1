Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DE7C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 12:51:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22E50870ED;
	Wed, 29 Nov 2023 13:51:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=omron.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=omron.com header.i=@omron.com header.b="jAgUYGLt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A5FA87687; Wed, 29 Nov 2023 03:05:13 +0100 (CET)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (mail-os0jpn01on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:201a::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A339087045
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 03:05:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=omron.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=niek.nooijens@omron.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMMw1mfrrzB0hRzDDXGctbkPmlyQ3wC8MlYTDVWh8geCK9r9R1Y+b/lWz8SMB5jRtTLyWxuQgKA7DwmWpej2OeGFHXbRmcCbpKFBZmADwaczP0Bobk6XFextA1hfu8nXqh6zfJK6/BiLu7wSWHmvyhchE0TIMCcGsMRpOGTfJ4K1kEIz1DMdYTRzX417i1ozAsP8+vfqjd75Nqy4+fl8WOelj8wykq0UkMI+j3B21QgOTivgl9FHAwcOAqdcrcpBamVoJ8QYEJn6HNCFNjCCmodh2+QTTnxO/Bj4BcvwznB73hLJ8+UdCx28aOqqxIIOQm1k8Q6G2Yw8znKKJJFTMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hem+sAOHlY1JKZXbh7qE8TNGeXG6BlRQpqOVS124K9E=;
 b=hJT3jY2MC9LGLcHPGSJT3ES9BRsDUoroE4GCQZ+AIR2BDVmXHnoVtJD+phH9zaCtMLuYk0IvkKUeJ+UVfe/PcDwK1XC92lDcb+FGNNdc2911xj3gATYCQWVsS0eHspSpm/FDz/lQYtq49Xmpope89+9ezLjENgRG1wIM6X9P97bOQsRaknBMnz5Ic3Wvd5Wh4CzpYdLpoRBLuhUny8P4yCDrii3XGY3u43cUVUWDwDt4SqYyTd/n/bzfxkJSxRQ4/9x4jxC0QmYoLeSmz0caCvzsrEXAlaKSdv7tYt9+eEACPk+qkPLy6YcxxpjIqUjHPb3Lu/5DhXyW52+0/SpcLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=omron.com; dmarc=pass action=none header.from=omron.com;
 dkim=pass header.d=omron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=omron.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hem+sAOHlY1JKZXbh7qE8TNGeXG6BlRQpqOVS124K9E=;
 b=jAgUYGLtLRJff3Ot8gztOs9RUtOkYzfnVlICDu7moIRqeHD7FENrruH0UjwXNFI72UCBm6B5AQU83Ns2fp81AKeDnkolgdGugjdU9JsQ3jiP23Ps/FWZuRUP7EMe+mB5Hx9lawAoeRgasz4b0e1ZX3Bt6BfljYxXiWAdnII57qc=
Received: from OS3P286MB1495.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:17a::14)
 by TYWP286MB2153.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:176::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Wed, 29 Nov
 2023 02:04:59 +0000
Received: from OS3P286MB1495.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d797:fe30:20da:e70f]) by OS3P286MB1495.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d797:fe30:20da:e70f%4]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 02:04:59 +0000
From: "niek.nooijens@omron.com" <niek.nooijens@omron.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: TPM SPI issue
Thread-Topic: TPM SPI issue
Thread-Index: AQHaImhfeiSebolxT0qUVjRMIp1rLQ==
Date: Wed, 29 Nov 2023 02:04:59 +0000
Message-ID: <OS3P286MB1495F9E99D2BD002B94D4174F683A@OS3P286MB1495.JPNP286.PROD.OUTLOOK.COM>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=omron.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3P286MB1495:EE_|TYWP286MB2153:EE_
x-ms-office365-filtering-correlation-id: cf8367a3-a2de-4061-c083-08dbf07f9773
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KvPhlKfts1Tqj3K+oMDPy9OFoP65In3tiMP65RZuCuqCdmrdS0aTSRO4gz9dErPXoEztlBeF3u+d/bN+5WDU0gXMHSnefIXloPRA5k1AU60p6davvi8/Db4zHYew7dMl2KyxD77EaaPQy+go9GSRRP0Lq15oCRNRroXT9BgoOLWJAD1oqYyTrfotXFHud0NC0ZNUmmzs31os5BqnIfOsvlWytMTu+q13CDnMmChbQZjofeBkfd7Rj2Kozv62bPJ+RSvd+rh1cSFAzfLKBXGoq48LkNlMZ1fKi8yYtNxX9+UUrCNNlR9qVHoUO4mr6qxFGCLHCZRItwvosWLrrwFCe9A3AfNhRgpBIKu6oZflnSZD6Ku/zhhcA/c7dirXln9pU9g9SZArIqXNpJnUADHnPYhX1YXO45U4R+2ps+yrsUSzhvKCb8w6lXHe7CaREzwX/+tmexd2EjYUr6rvXU6U+D1ZhGVyq6rM+RD5TX3y9pIl2jIMPTIKYwH4VWCMixv7jcr4vNzYOkP2zyzAtFeeG1sjUeQE5nm+WxHk2ffpjVOmpXyCN6SFubFSHF5Yhox3GyC/C0Ukyz4mqrpvP/pc6tva3XUYFfHVEkgvw3nCM7k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS3P286MB1495.JPNP286.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(136003)(396003)(346002)(376002)(84040400005)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(38100700002)(122000001)(8936002)(76116006)(55016003)(8676002)(7116003)(71200400001)(316002)(66446008)(3480700007)(166002)(66946007)(66556008)(6916009)(66476007)(9686003)(64756008)(86362001)(966005)(5660300002)(19627405001)(478600001)(2906002)(41300700001)(33656002)(38070700009)(558084003)(6506007)(7696005)(52536014)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?N2FrWUtoRms5K3Q2Uzcwdnd4U2oxOEh2MVhXVS9zZ3JVQXJvTm5Renhz?=
 =?iso-2022-jp?B?U1hSbVpqUkhaMFRjbjhkK0RoU3gzWjZEZ0RVZXNwTGdRTmRTTXNKK1VY?=
 =?iso-2022-jp?B?YlFmQ0hyditMeE5lcm1tTVZTM2QvVS9vdFdhQWNhU0Z5V3VUYXI5a0JK?=
 =?iso-2022-jp?B?cGhZQ0xVYzFma0l6UUVST2RWeUNPYlhMK201Y0xydDNIVnBDUWRZYkY0?=
 =?iso-2022-jp?B?cmJxY3E3Q0xVVHRMMlRrSFZYT3lYT2xsOWwwOFl5and4R3NzMTk5YlRG?=
 =?iso-2022-jp?B?UXJKRGZHSU4reEcwZlBQZytXeVRpUk1RMXdwbnUycUxGL3dvUHNXd2du?=
 =?iso-2022-jp?B?dG8vS0l1TzFUMkp0OGxUd1dDL3VSaHkyOE9lUjJiTHZVbUJGZXBWM0ZI?=
 =?iso-2022-jp?B?N013TWlnTU9FNE9Mek01RVozeC9uYm5sRzRCV1I2eVBISlVwWElDRHpR?=
 =?iso-2022-jp?B?MlE0dFhKMVBJb2R4NG15d0FIak8xSkgxbmRpVlJ2TVVIdWNqcEEzWG9F?=
 =?iso-2022-jp?B?UEs1cjdDKzVaajIvbi9uU2dzc28yME5XMThNRDVJZ25iMWMzazVHVUpa?=
 =?iso-2022-jp?B?VE5pY2MxcXQ0U3NIakhHMGc4c0Zya1gvMmJUWG82YUoxMTd6d3RxMm1m?=
 =?iso-2022-jp?B?SFpaY0VNMFZ0SFJtRWF4WmJ6bktMRmVDZjdDVXZwelBkb2dna20yeEMv?=
 =?iso-2022-jp?B?UGZTQUJ4ekhmWmNSRVdrTVFuQWQrTkN4eTNHVlVObndUUWFiYzNRY2hv?=
 =?iso-2022-jp?B?RGZ2WUU1bGs3aEo4K2czRU9mTTRZZXJqSmVPbEU5SVhNWWVucjlwNkNq?=
 =?iso-2022-jp?B?Um0xZG5MVGw0WXFTZ200Y3FjWmFlNDBrYThyR3ZWVmsvdWpVcEpJK1U5?=
 =?iso-2022-jp?B?M25VN2FOUlBwMjlCcDhVd0xXYjIvbGZ2RXMzbGRTZkxpV2dSdHlscGtV?=
 =?iso-2022-jp?B?VXZrWWo2Y0x3US9KM0JDNTNENkpndGFIRFd0ZVBoV0RqdDhvdHBvTDYy?=
 =?iso-2022-jp?B?cFNVR2Rncmc0TGJaTDBjbGZ2TG5vZllCZzl0dy9RaHlwRVp5VFhoMkdv?=
 =?iso-2022-jp?B?QlhvdVJmWHVNM3NVSHAyMUhzOUZnQmhWNDRtN2xZblQ3Y2pOVXUzRnBZ?=
 =?iso-2022-jp?B?cjNBNFprSWo3cWwxUVdqcDlXcW1zMGpmWUovVjBNV2V5OEw2WFhGeUdN?=
 =?iso-2022-jp?B?MlEwSGR0MWx6VFN1ZFdvL0xwaU90VTRxdkJJRFViVjdKYk1zNzJkMWsz?=
 =?iso-2022-jp?B?cXZiaGUvVVVGMGx2KzVWak00c29rZm5RQ0ZXWFZqNUxvTlp6cWhLNCtx?=
 =?iso-2022-jp?B?VGdBbmVmanhrOTVpZWhvM05OTU5vdC9PT1BSaHYzTlNkcWdsYmtTQ1Jm?=
 =?iso-2022-jp?B?WnllcEhOaUxkMHlkU2pGS05iRERKVVNnZ2ZPRWRuQTBQV1ExakFRWDVY?=
 =?iso-2022-jp?B?dG5nMVVUWXN6UTZlMXRFaUxYUVZ2THU2emorazV1aDBNeDhZNTBmamMx?=
 =?iso-2022-jp?B?N294NVNBMS9EcHZjRXlVMFVwaGVsaFhXNzB4Rm43MzZ0OEZRYVpBS2lZ?=
 =?iso-2022-jp?B?aDY0VURqam5SOGRPeVcwcGpGY1FXWnAyL1U3WEswa29CdUU4SEdMcjhm?=
 =?iso-2022-jp?B?MVdFZzN0a256OHhZczJ4TXRjOGdGUHRCSkZEdGhpTXA4Z3NHbWt1ZWJH?=
 =?iso-2022-jp?B?bmNFTi9aZkZxSFZmamw3Zk4wcW9pTi9PNXIyaHpCQzg3eWJwdHVUTm1k?=
 =?iso-2022-jp?B?d1NISkcxdzNaK2NsNEhpOTZDalk4TS9EQ1BzMkxyMzhsSFZEY0ZMUGQ2?=
 =?iso-2022-jp?B?ZGN6NHk1ZjBmaXhzWVZ4OEdkclNFUFpPUnNvNUtGRkR5bCt1VVJHV1Fv?=
 =?iso-2022-jp?B?WFF0VFRLN2d2b09wS25aZERxM0h0NDJZQytiYlFiRWhxY214TzdlVVF5?=
 =?iso-2022-jp?B?Z29TcThoUUtXcDJPN0hQR0RFckNqY2IzNExPYjRSbHJoeEN2R1hZMlVX?=
 =?iso-2022-jp?B?RzFGc2l4SWpYZ1VLZllYc2R3eUVNUUNNZU1maFZtTG9xdlh4S3BCRWhJ?=
 =?iso-2022-jp?B?MkM1eU1HNS9Ldnl2QWtUck15eFAwNFUzaU1BU0EraG5HKzZITE9QTTFr?=
 =?iso-2022-jp?B?cTJiQTJBbVZvcnlyZzF5ajJFcTVHNjJidGtCS3BJazRSWElObmE3ZVZJ?=
 =?iso-2022-jp?B?ZVlRSGFVTHNvN0hkamV6cVh5OW1GbHppK3ZxaG5lcDJicmF2eFM5ZC8x?=
 =?iso-2022-jp?B?SDRJRCtxbTM4NldtV2FkNVFNQUtwcE5yRjd6RUJEeDVmb29CbC9OSVpY?=
 =?iso-2022-jp?B?N1RVUg==?=
MIME-Version: 1.0
X-OriginatorOrg: omron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB1495.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cf8367a3-a2de-4061-c083-08dbf07f9773
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2023 02:04:59.4770 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ecff5a9-4bef-4a7b-96ec-a96579b4ac37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RmwHoyPm2SUL7ErnCJhJp2n0N6OMa5Gu1XOXZr+JrQo6QwiU1S8QVUPZAeXT0OKCKuEscEW5GrPGdNIjnIZ97w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2153
X-Mailman-Approved-At: Wed, 29 Nov 2023 13:51:19 +0100
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
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

Hi there

I have the same issue as here:
https://community.infineon.com/t5/OPTIGA-TPM/I-MX8-TPM-SLB9670-SPI-Com-Erro=
r/td-p/472533

apparently the CS is released in between responses. Can you help me solve t=
his?
Thnx!

Niek
