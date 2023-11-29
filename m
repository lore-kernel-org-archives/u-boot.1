Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862E5C4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 14:13:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73E2887714;
	Thu, 30 Nov 2023 15:10:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=omron.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=omron.com header.i=@omron.com header.b="jlz/LqI8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F88086D82; Thu, 30 Nov 2023 00:59:07 +0100 (CET)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (mail-tycjpn01on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2019::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF52F8641F
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 00:59:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=omron.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=niek.nooijens@omron.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Erm8v2NKbLbhnDucmiy0A7hN4W5ELPj5DIpc6m3+BNUXGDqPXrcaJ7x+JbrV6nE7Uf0kqibTfy1f2RxGoT+m8EvoBOF6Hb/e+df5uh8mHXJc4J2VIps4wNntga+a5UDMf3LLlNLBvn9XcQyylXm80M7OKqKgjMw41apTCs3PgpiJ9Yy907VgEn+Q7dZnOPIUMw5w+i0mBaMiQBgHU3aViOBOrM715vZBTvIaW82dk0lAVgFo2HlPdjqd2RQfdMgJr1K4LsK91M1kF6GJE/vzO5j9R6h06EQoF5hdqkveTSI8D1t/9yc8dHAacYNiLeXPijlRTmkNnUnF+TEmSUCLPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tiedbu6xdCCNI5sTGxkDGPbeP8mC9/vB2+jmpSHmJE0=;
 b=HsmwGsvxZTrfshLnThjfMJd3HwfWEBEKoflhLM+/B1qUou/5DRmPjW29K670LwbH3Pd4qW+EAtaAf7RVW1Y5NSbo+XWmg/OXVQeoVnt+igFEwGXsPiSn8JHfWIPKoZJaQnWNk+wsb12jgZa+W0iuMbKdGflasK9+kUan8LU+OwejFCXLPpOHknaWSDWcjxkLCxvgOvLuAoAZcdjcPv+ziwJ05x7D6IzaTkZQ2bBOdpuYOcEM3sCKTpdEFczQZoptop/zYAgNnA24qXdKR8oKfw93TU/WZ7q6DncCYb27zr3LFzLb/0kn7JF+6J2kZZW3qKzO13Os34BC/vytgZNeKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=omron.com; dmarc=pass action=none header.from=omron.com;
 dkim=pass header.d=omron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=omron.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tiedbu6xdCCNI5sTGxkDGPbeP8mC9/vB2+jmpSHmJE0=;
 b=jlz/LqI8lOwI48/qgWMSjfOTvs/J0oN9LI6wAHaVda94FFMK1OnQv4JdPYh1g7T9l6tHzzmfEVRNHwNyqOirMgGxJOEGwfFgTwwmzjjzoYanIyQt+dAOU/9eViF8ga+tfyTcNan00Awn2/0nTxbSukFMyHWIRJGj/PIWHNwOFrQ=
Received: from OS3P286MB1495.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:17a::14)
 by TYWP286MB3676.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3f4::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Wed, 29 Nov
 2023 23:58:59 +0000
Received: from OS3P286MB1495.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d797:fe30:20da:e70f]) by OS3P286MB1495.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d797:fe30:20da:e70f%4]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 23:58:59 +0000
From: "niek.nooijens@omron.com" <niek.nooijens@omron.com>
To: Fabio Estevam <festevam@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: TPM SPI issue
Thread-Topic: TPM SPI issue
Thread-Index: AQHaImhfeiSebolxT0qUVjRMIp1rLbCRR90AgACy3sk=
Date: Wed, 29 Nov 2023 23:58:59 +0000
Message-ID: <OS3P286MB14957A0AA37C837969AB16A5F683A@OS3P286MB1495.JPNP286.PROD.OUTLOOK.COM>
References: <OS3P286MB1495F9E99D2BD002B94D4174F683A@OS3P286MB1495.JPNP286.PROD.OUTLOOK.COM>
 <CAOMZO5CasNqMJ28QcLX-asaLPd+LuPR3B4d=8zqGD1XS=pxD5g@mail.gmail.com>
In-Reply-To: <CAOMZO5CasNqMJ28QcLX-asaLPd+LuPR3B4d=8zqGD1XS=pxD5g@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=omron.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3P286MB1495:EE_|TYWP286MB3676:EE_
x-ms-office365-filtering-correlation-id: 95ef1312-b2d8-44fc-a2ac-08dbf13727b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uUY+lzhs20k0BRlXyi0kuflUNnVZDHY7Q6n+Bv0Vf7aoC03W5wkzlfbgD3g6aqc8NqIQtHQMBjM74tkXMsCdOBxkJ38cBFNBC3zNmJ/3PhrR0PzugUFxET5hX2KOLKUYRBaNfqtlO39KC3vnBJJdYjDjyWLJiG5OPyBhToKXAeTGCrPDNhjVqE9BhTBgbUWVZuBsoTx3BRQTd491fST8SL6Fmw38B7SxPC5cGW0mtGWtgLWiXu3PyqkR1NHsP0dz+YG6O98Nb96dbbZ5qp+oH0PLa+X00IVkuZz9QlyswVOl39bssIh+bZDHMeJ6nW3V597IAACi0uhfyQIvIVOVJcJC7cCEZS4iAdGksOlQ+lH761eVyDqiD66mal+voF7eAySL0Va8nGHqHWxUvStdB4ERP2AKN45Fr1fet/YjXP5s/LBI/OAKK2dDj8Ax1redNQdATwwp/wpUjgAtnRcwALJ1wv9I3jwRBLcSNW5gANC6YKVRXFvThUlSdEbNBYsvj+wchFt/Z6UrVS7iTaRAetWNdgtUP/MjwYGCbBV0++9dgL1qvSp+nAa+a+lKOr+Y4CU5YH4qOVClGZfqO1mIbkoTrZJc6Nb5MUMUDYO8B/FkSAiAcquLaYOrDryhOp4SUsD7vCwvCSOvzr39feeRJA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS3P286MB1495.JPNP286.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(346002)(39860400002)(376002)(136003)(84040400005)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(19627405001)(55016003)(202311291699003)(478600001)(45080400002)(966005)(26005)(71200400001)(53546011)(7696005)(6506007)(9686003)(122000001)(3480700007)(38070700009)(166002)(38100700002)(86362001)(33656002)(5660300002)(66946007)(66556008)(66476007)(66446008)(64756008)(6916009)(76116006)(41300700001)(2906002)(7116003)(4326008)(52536014)(316002)(8676002)(8936002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVZDTk0xVWoyRXRYN1JGVzR3c29STjdVNjFYWjJVVTB3NDRqSmtvTlB0SHlD?=
 =?utf-8?B?Y1hVNDhGVlIrL2NGM2JCL1oxR1U5SllwcXRVK1BhR2QyV1FTSnkwcXFNUm9R?=
 =?utf-8?B?VkhWVDVuaVJJVkZWQ2ZRNjJHdm93ek5aSys3OXE4T2F6ZGJYVWtDS0x3ZGJz?=
 =?utf-8?B?VHRqcmlVR2Job3BrUEV0K2JWcmhSa05FamxycWZLS2tQVmYxeWRTQWEwdWJY?=
 =?utf-8?B?RXVWa29tVkFXcmhyUjBJWGlpWlZnZGtDUU8zN1FISzJ5eFU5TXE3NGZQT1Rm?=
 =?utf-8?B?eUhjVEJsdUZFUmlqb1ZmRlY4WGI1ZDhjOXRSUkhIMzQweTd2Tm5vaGp2dHNa?=
 =?utf-8?B?UHNOSURTdjRnNmdHU1BxQUVtR0xlN1ZpWGxVOXM4RU1LWWw1Yzc5K2N0dlFk?=
 =?utf-8?B?ems3eVVGWmQ5MU9teWFwOVA2aGp0MXRzQnhza0tVOHJQS3hKcDltMVZaNlZK?=
 =?utf-8?B?OVhZeldKcGV6emVET0xUek9paVBKQnhpV2JpWjFaaEZRMWYyU3JmQXhsbmEv?=
 =?utf-8?B?Yk9EUUhSTXRPTkYyTFBaTXg3WCs5YldTMzFJQzc2UUZ4NEVicEc2cFdrTkt5?=
 =?utf-8?B?TFVtK2V2bkludStqTVFlR2x1b1NkaDRlUXlLODBRMWNHWnphUkYwSTQxVmFZ?=
 =?utf-8?B?OWQwZnFyR05iYlZ2RVJ2WlgzWVhpbDI3NDkxYk9YYWExYWFSeVNsYXNJMzFn?=
 =?utf-8?B?aUwxVTUxb1VRUStOZnhrZ1RUQ2Q4aTV5b1BUc3BzUjVScmRXOXk5ZEFoNytk?=
 =?utf-8?B?L1UrZGJjS21URTQ3dEFVODJoZE9tQVc3Z2ZBeDltSWwwQVJvVDF5Z2pPRGZ3?=
 =?utf-8?B?VUx2cW9UYllseFlZbDgzTTg5RytFRFpDbjNjUm5UWGhnV1NkdGJGeVU0YUhX?=
 =?utf-8?B?OE42bWR0L01RODAzWW04YUZaYmR5eVlsVDBVdURSYUYvc2VXZW5EZE5kRU9R?=
 =?utf-8?B?c1g5Z21Na3FNVythc0VnWTNIUEc5b0IweUV3NCtSVnFVY1BDTTI5SURzZ3ZF?=
 =?utf-8?B?NWhoVVFGNDBIUjFUbkJHdmJsNmpWZnpadis5NzllaWt4Y21zVmo0UTcxTmgw?=
 =?utf-8?B?VWZhQktoVnY5MFlTR1pDVG9sUEdTeVZFdUlXOU5JRWx2WmFMZDlmNU4vTVg5?=
 =?utf-8?B?bStUU0VIdzlFZ0lBbko0QVZWa1FjT2ZuSEdCMjJnN0F5NDJkSWlNSGZKV2Jv?=
 =?utf-8?B?Njl4NHluM2tCU1lVbkhoTkRNSUQvOVZUbUhRdUdna2RlUnlFczVHZGRJRWhh?=
 =?utf-8?B?OGdEa0ZxbUhKN3FiN1VVZ1JtS203MFlYZ1BsRVJ1QTNtb2NET2xQV0E4dGFu?=
 =?utf-8?B?Tlk2YzVObGpyZXFHOXBsakNqUGZ2L1FjRE1NSVpFZlAvakU4eXdqd1lyTnFw?=
 =?utf-8?B?OWI5Z1FqK1dsUjFsSGUydFVsc2RoMkk2ZmRHRmNtQ1lBc2pJOG92RDlraUI3?=
 =?utf-8?B?bE56cGJYYi9ZVzRnUkoxRmVLck1ublR0VWxkbGFkWU51N1lRd1dONHhXc0Jx?=
 =?utf-8?B?a3JxZjkxTDVhVlMrUzhyNnBaSzdlSXRIWkxsZHFqL0hIMEMwZzEza00vYTBO?=
 =?utf-8?B?YWRhWkYyR3dUb2lLNnVIZzA1a3BhMG41VWk4OFQxMFVtQndPY3g4Vm84bzUz?=
 =?utf-8?B?VnFBUWQxdU9WR0lSM21CRFcvM3d0L2Z2a2lDNTY5T0JCcVJIYmdsOWZkdmtL?=
 =?utf-8?B?N2RxbHROUFRLd3FnQzlvcUxwRk9NaEcwM21rZDgweWZMRFlWbU5QUE9oRHN6?=
 =?utf-8?B?U2hhQ3RXZURNYzI2Q2hzdzRyMDRTeGdYTjhIQ3RJb003MUxYV0c2bGdtV2Z6?=
 =?utf-8?B?U1V6UWdhWjBqVGV1bzhGdXJvcmVOc3JxcFlxSUpCRmtlLy9sek9IeVErNXla?=
 =?utf-8?B?VGEraDRkVTFFUXZudkg3UGFvUk5ON21QeDV0SFVpYmY5cXVNR0RpN0oweDI3?=
 =?utf-8?B?TzdvSWU1aUVDRTVFejdzTnE4QzRGeWpXdXVSQW9SWmFySXk5MG1Cak5pZkFx?=
 =?utf-8?B?a1JrVGtxSmJHdkd5elA1eFVneCsvbzF5anVlVVBRcGZsREF6ZmlmZmE3d3BM?=
 =?utf-8?B?NW15OWdQa0YxTmNQWitEM1psbjJPaXMwbzVVQnEzNTVEYjVkTTM5Q005YXhw?=
 =?utf-8?Q?ACwmizKGJj5943h9SLk3t5ylx?=
MIME-Version: 1.0
X-OriginatorOrg: omron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB1495.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ef1312-b2d8-44fc-a2ac-08dbf13727b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2023 23:58:59.4217 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ecff5a9-4bef-4a7b-96ec-a96579b4ac37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 147RC+SJ0ygfmuIKCZaL6+hCmctBP6WHs7NnYzrked6cOLkas2nLCX2fVxd4UPE5N1HUWDmLflT4qMmhism1Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3676
X-Mailman-Approved-At: Thu, 30 Nov 2023 15:10:40 +0100
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

SGkgRmFiaW8NCg0KSSdtIHVzaW5nIHRoZSBzb2NmcGdhX2N5Y2xvbmU1IHdpdGggdGhlIGRlc2ln
bndpcmVfc3BpIGRyaXZlci4NCkkgYWRkZWQgdGhlIFRQTSB0byB0aGUgZGV2aWNldHJlZSBhcyBz
bzoNCiZzcGkwIHsNCuKAguKAguKAguKAguKAguKAgnN0YXR1cyA9ICJva2F5IjsNCuKAguKAguKA
guKAguKAguKAgm51bS1jcyA9IDwyPjsNCuKAguKAguKAguKAguKAguKAgm1yYW0wQDAgew0K4oCC
4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCY29tcGF0aWJsZSA9ICJzcGktZGV2IjsN
CuKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAgnJlZyA9IDwwPjsNCuKAguKAguKA
guKAguKAguKAguKAguKAguKAguKAguKAguKAgnNwaS1tYXgtZnJlcXVlbmN5ID0gPDEwMDAwMDA+
Ow0K4oCC4oCC4oCC4oCC4oCC4oCCfTsNCuKAguKAguKAguKAguKAguKAgnRwbUAxIHsgLy8gc2xt
OTY3MCAtIFUxNDQNCuKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAgmNvbXBhdGli
bGUgPSAiaW5maW5lb24sc2xiOTY3MCIsICJ0Y2csdHBtX3Rpcy1zcGkiOw0K4oCC4oCC4oCC4oCC
4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCcmVnID0gPDE+Ow0K4oCC4oCC4oCC4oCC4oCC4oCC4oCC
4oCC4oCC4oCC4oCC4oCCc3BpLW1heC1mcmVxdWVuY3kgPSA8MTAwMDAwMD47DQrigILigILigILi
gILigILigIJ9Ow0KfTsNCg0KTkllaw0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18N
CuW3ruWHuuS6ujogRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPg0K6YCB5L+h5pel
5pmCOiAyMDIz5bm0MTHmnIgyOeaXpSAyMjoxNw0K5a6b5YWIOiBOaWVrIE5vb2lqZW5zIC8gT0Mt
SUFCIFBCRC1DIERFVkVMIDEtMSA8bmllay5ub29pamVuc0BvbXJvbi5jb20+DQpDQzogdS1ib290
QGxpc3RzLmRlbnguZGUgPHUtYm9vdEBsaXN0cy5kZW54LmRlPg0K5Lu25ZCNOiBSZTogVFBNIFNQ
SSBpc3N1ZQ0KDQpbZmVzdGV2YW1AZ21haWwuY29tIOOBi+OCieOBruODoeODvOODq+OCkuWPl+OB
keWPluOCi+mgu+W6puOBr+mrmOOBj+OBguOCiuOBvuOBm+OCk+OAguOBk+OCjOOBjOWVj+mhjOOB
p+OBguOCi+WPr+iDveaAp+OBrueQhueUseOBq+OBpOOBhOOBpuOBr+OAgWh0dHBzOi8vYWthLm1z
L0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiDjgpLjgZTopqfjgY/jgaDjgZXjgYTjgIJd
DQoNCkhpIE5pZWssDQoNCk9uIFdlZCwgTm92IDI5LCAyMDIzIGF0IDk6NTHigK9BTSBuaWVrLm5v
b2lqZW5zQG9tcm9uLmNvbQ0KPG5pZWsubm9vaWplbnNAb21yb24uY29tPiB3cm90ZToNCj4NCj4g
SGkgdGhlcmUNCj4NCj4gSSBoYXZlIHRoZSBzYW1lIGlzc3VlIGFzIGhlcmU6DQo+IGh0dHBzOi8v
anBuMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUy
RmNvbW11bml0eS5pbmZpbmVvbi5jb20lMkZ0NSUyRk9QVElHQS1UUE0lMkZJLU1YOC1UUE0tU0xC
OTY3MC1TUEktQ29tLUVycm9yJTJGdGQtcCUyRjQ3MjUzMyZkYXRhPTA1JTdDMDElN0NuaWVrLm5v
b2lqZW5zJTQwb21yb24uY29tJTdDMGVkOTM0MmM2ZjRlNGQxNGRiYmUwOGRiZjBkZDgwYjUlN0Mw
ZWNmZjVhOTRiZWY0YTdiOTZlY2E5NjU3OWI0YWMzNyU3QzAlN0MwJTdDNjM4MzY4NjA2MzU0NDUx
NDA5JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lW
Mmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzMwMDAlN0MlN0MlN0Mmc2Rh
dGE9RDNmMDlSVVg0aTBFY2dRaVVDNHJ2M3kxVlAzQTVLYTNvekFSOGRYZGVuOCUzRCZyZXNlcnZl
ZD0wPGh0dHBzOi8vY29tbXVuaXR5LmluZmluZW9uLmNvbS90NS9PUFRJR0EtVFBNL0ktTVg4LVRQ
TS1TTEI5NjcwLVNQSS1Db20tRXJyb3IvdGQtcC80NzI1MzM+DQo+DQo+IGFwcGFyZW50bHkgdGhl
IENTIGlzIHJlbGVhc2VkIGluIGJldHdlZW4gcmVzcG9uc2VzLiBDYW4geW91IGhlbHAgbWUgc29s
dmUgdGhpcz8NCg0KV2hpY2ggU29DIGFyZSB5b3UgdXNpbmc/DQoNCkluIGNhc2UgeW91IGFyZSB1
c2luZyBkcml2ZXJzL3NwaS9teGNfc3BpLmMsIHRoZXJlIHdhcyBhIGNvbW1pdCBpbiB0aGUNCmtl
cm5lbCBkcml2ZXIgdGhhdA0KYWxsb3dlZCB0byBwdXQgdGhlIENTIGxpbmUgaW4gbG93IHdoZW4g
aWRsZToNCg0KaHR0cHM6Ly9qcG4wMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/
dXJsPWh0dHBzJTNBJTJGJTJGZ2l0Lmtlcm5lbC5vcmclMkZwdWIlMkZzY20lMkZsaW51eCUyRmtl
cm5lbCUyRmdpdCUyRnN0YWJsZSUyRmxpbnV4LmdpdCUyRmNvbW1pdCUyRiUzRmglM0R2Ni42LjMl
MjZpZCUzRDZhOTgzZmY1MTAyZmYwZDg1OWRmMDVjYTNmNWNmMmY2YTE3YzBmYWQmZGF0YT0wNSU3
QzAxJTdDbmllay5ub29pamVucyU0MG9tcm9uLmNvbSU3QzBlZDkzNDJjNmY0ZTRkMTRkYmJlMDhk
YmYwZGQ4MGI1JTdDMGVjZmY1YTk0YmVmNGE3Yjk2ZWNhOTY1NzliNGFjMzclN0MwJTdDMCU3QzYz
ODM2ODYwNjM1NDQ1ODg5MCU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3
TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MzMDAw
JTdDJTdDJTdDJnNkYXRhPVEzZmVRakRjeUFyeGh3b2VoR0IzRCUyRnducTBwaFBQczNwYjhqZG1r
ZGFTZyUzRCZyZXNlcnZlZD0wPGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9r
ZXJuZWwvZ2l0L3N0YWJsZS9saW51eC5naXQvY29tbWl0Lz9oPXY2LjYuMyZpZD02YTk4M2ZmNTEw
MmZmMGQ4NTlkZjA1Y2EzZjVjZjJmNmExN2MwZmFkPg0K
