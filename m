Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9073F10F284B
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 16:27:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D57C784118;
	Fri, 27 Mar 2026 17:24:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="uaYYQgjf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F045F83DA7; Fri, 27 Mar 2026 14:50:05 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EF858394E
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 14:50:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fLpv5VxTLzFjgvYW5kerX82OaPTFw36luGDB5/7ORYip9UQ3Gw0mi37NSeg0wqQXvd8g1Rkorx01YDchEpzlcbwZJ61kxTubZQrVc+ulYScK1Qb3ZWenLybegbdGuq+FILAoW0gT2eZ9VsY5mMN/N4Sj/Mq3s7YnflY5+H5aYxR7avj7ALLTeenGiatkCrpF/zVGyoAUR7oshcF++vpOZUUEwlpMiLBPSpWr9adlrIPZ7jOlyYV682Yh5hxtNaxvaUcmAC9g4WeVwsH4SpCs4rt/D7nDWWRf1Ybrsj9R0ZMfTCpehkeVMg/hOWJSlF7V98UL8+C4FxEsDbangcPl9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpreFVm1reS5A0nfnLx0kwNcEhfQlhwGNJfoiLag80U=;
 b=dF88aVmKYeN4xV2vLfNRmG5KcHQQG1fqAQdQQu8D4Q2ho8veLBtYVevNwnjDkTbNis04ObsoFA4vL9k2g1obcHZrqiLb8dyOMKN4joTCMQoXLh7SEagK9OdtynD4PJTbuacCc9siF7RmsHoDEkUlrP3YBb3ti5PbopY0fFlNlyflEZocPrXHzf5rYEzSPmeJzYF9E/w0cbjtetFnR2cLjVv+RwARp1VS41LNRFI1i6LXacinTcnZURmBZ4LhF3GBgJpPpSz31j1EuwmzLV+Kb71AiNaXLYxA0Z5NzCxgJGGboQXqPaAX+XNISabYuWxxZLVOCZ26854H9dHkEkYbJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FpreFVm1reS5A0nfnLx0kwNcEhfQlhwGNJfoiLag80U=;
 b=uaYYQgjfmTJeJnHtbv8fuKPeFeOlvSKhTs2qkUkbhMAjaCZHJSSYHrxQGKpL2hQJkwifKOL6h8TRTJGfTx9vO2sRYCJlMmXQ51tfRwKoCMKEy4fdTuJ3SLR3UwpLWLyl7Dd7gbuSKcKMTbLhXuvauR6WYmxdaRaczwwO6a7S0wFZytZfjqpdFPkUQePuRzhqlcCO3oqpsHwtouyXJCJ9qEZgQVd/n5mqBmpWYR4zC5oc6VfAsDT0tJ/uOY4nkMtarQju6eiF5fNx+m8cnHbkmmMwqiqkMgzplr90W1tohMoH4dZLB0F88KVAvehvEKZYrBK+jTz2sfOHlvK387/B0A==
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com (2603:10a6:102:4d4::20)
 by DBBPR09MB4570.eurprd09.prod.outlook.com (2603:10a6:10:204::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Fri, 27 Mar
 2026 13:49:59 +0000
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81]) by PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81%6]) with mapi id 15.20.9745.019; Fri, 27 Mar 2026
 13:49:59 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: Leo Liang <ycliang@andestech.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v5 6/8] net: pch_gbe: Add PHY reset and MAC address fallback
 for RISC-V
Thread-Topic: [PATCH v5 6/8] net: pch_gbe: Add PHY reset and MAC address
 fallback for RISC-V
Thread-Index: AQHcdOyMJ2UnBhw+S0Gtr2K71CcxmbWy7DAAgBALJwA=
Date: Fri, 27 Mar 2026 13:49:59 +0000
Message-ID: <1fa25543-f7ae-43d8-aee4-50ef2e49fa0d@htecgroup.com>
References: <20251224154449.946780-1-uros.stajic@htecgroup.com>
 <20251224154449.946780-7-uros.stajic@htecgroup.com>
 <abkVsH2JESBRsnvD@swlinux02>
In-Reply-To: <abkVsH2JESBRsnvD@swlinux02>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR09MB8140:EE_|DBBPR09MB4570:EE_
x-ms-office365-filtering-correlation-id: bc0bae86-ef27-4790-ddae-08de8c07bcc3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: uAfTPU0fm1BYLg7F/kC77bWsLMPACsF7LagyeC1y5OJADrM+gssc2gSYHxqYkpCXaOJLMMkXmlGCZ4dhB1smWyeZzIgJbE6qUSuSZqwXZ54jibLQ5gObt1KZTaDGl8h1bmjbu9XZDIAlPaibsQjwxkGwBbMnXJWmnVtuNrv6TrSKwv3AQBISH1a66ifETyEqJHGUkZefef9XByCa1xG+6USIyRzN2ojvYx2SCg5F92w88m8st+kaeJc04sYz+HKwnr3faf8F0meU5+vBb0oulaLQqACcS0lKFZ+w6B/jxKWJM6b+yOjoszUGG5pP4L4Z9z75U6A7k7DmVOKmg2Syf/KFtU4HxWBVSqhTSwMGHL9rcseo3ZU8aGL0TIOMyLb63xASqSlJkdvh/XcVFco/HvTPvUMjm4akGZv5s7SmYILbbiZc10K8ZS3FQlfyXTZwdfMGViZV6FcXz7vqUMCrLn/VI+uSyvd3rEu/Yo4DbCb1f6j0gSGIUqv0HyChOBDfMaGsArhs8/r2CrxGgYWASi81vx28JmSfrxDtI56801GqVbk0ubhvZQAvn7WD3+vFjE0NLp98lXfVA4HtZKKI457EE1r+vP75hUIpLUDFuS3O5lZQOZaazmk1xeIEWpEMV1fPtRxFGqBrWj/amOGoap/ool55ZvH1x+tA96sewnxq9UYdUxHCj3fisA7YST1M/jhpDZFX+JhFgfzrv5K3HXLSIiOeLm4nmkr1YnPjgvbl1IsrSkHcaEHdvVn8dK+mVJSR25oTtGYXSoeQw3GYXOw3FAvFNWt2AVEqcnuVeRA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR09MB8140.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UnlvcmNTQ1RaR2tIcngxVGdQTEE1S3ZWQ3hnTVYydWEvS1hwUUE1QVdyQ2dO?=
 =?utf-8?B?MkE2cG5yUlNNSEQyL3haQkVqbk9LTGxiWlh1V2h6V3c3VlpQbUdhS2p3Y2xZ?=
 =?utf-8?B?QkVRQ3k2ZGJkMmNESmx2eHdkcVd5Q2tOcmxKb0p4dEJLWnkvVVhoT21WTHZJ?=
 =?utf-8?B?Y2ZYcmhsZ3QySnFRcE5jbXRldUpUZW9ZOURrdjdrb1NORDkwU2g2RUMzME9i?=
 =?utf-8?B?SGJ5Znc2MGYwaGZCTkNDamNJN0dOZEpHNEljQk9zNjNaajQrYnVCZHBWZko3?=
 =?utf-8?B?bnBhSEIvbDlCZzZ2d3N3S2hnK3kxZEZyY0c0Wjl6V0w4S2xKc2JyeUxrMS8w?=
 =?utf-8?B?NldKdHB0NldBUCtPcW9xMUtSK0NvZWJtRk0yTGJxYUtDa1hxQnNkVnlnMjE3?=
 =?utf-8?B?TjJ5NlpLbE5kSXFNY3o0bXlVN1RyWjYwbUZERW9zbzFPM1lnUGRMRlhXN2kr?=
 =?utf-8?B?VStMYWl3NitNc2lockdobWFVaWxScnZ2MlF6Si9OM2l5Q3dWaHhibG5GQlYv?=
 =?utf-8?B?dnRKWldYekpDYnpqMTkzTFE5bUxQUzdsVWs5QmZZc0k5VGdwSWxqRG9YdDhI?=
 =?utf-8?B?VE41QjR2YVNzUndLSUpYVkNkd0d5U1JFbnhVcDUvVUdacHBSenhHczVHek5R?=
 =?utf-8?B?TmVEenl5V3JUN3grRHZqUUkwRDY4b0FIOEc1YTJLTmszeGVaTng3dWtwaEp4?=
 =?utf-8?B?cTFMei8xbWt0WWdqMW9jYWdiOHh0U3RJY3BBclNySUcxTFlOTm8zNHpQMHo2?=
 =?utf-8?B?YXhWUHl1SjFWWERmZFFHUkJEZHRuckVPZlEvVmJPR2lZQUUrOWN2NWZDYzY1?=
 =?utf-8?B?UGY4QXo2bGtZZFF0UE5heG9pdGI4aGM4N3VJUTNaNXdoemxOUVZJdXdoT0h0?=
 =?utf-8?B?Nk4rVkdJbXEwNGtWbnhrVUNHSklEcUJHQXpFbXdDa1FlNVBJTzk0TlFVbUF0?=
 =?utf-8?B?NW9ZQS8reGpKR2xWTFRGWE51MlJBYUY0VEROd0p6bmhTTUsxbXNrQzJsUFZZ?=
 =?utf-8?B?Vjgwc0RNK2pNdUh2N0JDTjJnMEdwdHJBeUNCU3N3ZS80eWNkNnRaTlRTSlgv?=
 =?utf-8?B?TVZaMFFMZU8wR0RvZ0pUd1YxVzcvQ1JOMEZoV09UM0xOT2J5enE0UmNGenFs?=
 =?utf-8?B?d1NQc2JQWHRObWpDVmo4cDZVS1E5ZkN1OVRlVDF3Yldqc3B2dVdTUjZZaEpR?=
 =?utf-8?B?eHd0K0E4YXU2NXE0a3BGaWpTQU56YzVLOUtoVGJGZTNVc1UwclA5eWFyemxv?=
 =?utf-8?B?bEd2Z3UyQ0dJeWtyR1lOZ1BWQlB3aWRIc2xNbENzMUszd1U0QVEvbFF0YjFH?=
 =?utf-8?B?OS9ZUlZWM0RBc1dhb1NuMnJTam1WMERUZjhjdzRDQVZSM3l0blFpWmdaY05F?=
 =?utf-8?B?azZLYjR0Mi9aNktSdzY5VkxUTk1EUU9LblFuWCtaOENmZFBMV3RZSTBEWUpH?=
 =?utf-8?B?Y2JYRFdRNk54eTc5bVlEazU2TndMQlZPNXBER1J5NDlJZlBTVktmREo4RnVJ?=
 =?utf-8?B?bGpJU3FqMjl3M3NhM21rS3NtSW4vK2xRL3RmZGs0eEtyanVVUVJnOHdDQmEy?=
 =?utf-8?B?YUdjRjlXYjFNYUFwVjZHMGM1KzNrN1lzbFg3SVdRUWlxOTNIWWFWTE5xVVhJ?=
 =?utf-8?B?c3ViMzFXWUJmZ0NBbVBTTU9mMlUvQVpua2N2UHFFOVY3VlE5aDh3NmR2L2Iv?=
 =?utf-8?B?bm11bXdvdkpTNG5kd291QzlzYmFjRi96dThRL012ek40T3pYVldpL1ZRZi83?=
 =?utf-8?B?d2NTKzdwV3R1WlpZWWZhOFdGMXR5UXk3T1JWVWJmcEVpQ3dMR0lFcGZleW5B?=
 =?utf-8?B?azRndmZua1lRYWFsRHlGMW1wazc1QnhIaFhIVS90SjYrMVNyREpibm4vbi9C?=
 =?utf-8?B?R3FuK29hWFVDelU4VU94Wmd4LzBxSFUvaG1VdjNnVGRxOW53OWt5ZFFJaURi?=
 =?utf-8?B?Ti83ZDRVTkZ0dmZaWHdJVEhldFpOV1hLOXNBTFpHWDZEelR3Rjd4Y1pRdU5k?=
 =?utf-8?B?RTVJcnpwb0I4enc4RWQzYXVXRmFBVWhCMllWVm14RDNORFBoeUNpMDR1Uk5o?=
 =?utf-8?B?NHRmY3lFbExYbURLY1g2cDhRZG10VEs0UGE1dDZSMmxLNDJ4RmFicDM3RjAy?=
 =?utf-8?B?cFc0dm0vRVg5aFIyU2txVDUrcHdGa2FiZnk0VUltM3dFMFBsNVJVNGsyRWhD?=
 =?utf-8?B?V2NyV2h2Q0s0ZDdlcXFFeTBXU0U2LytxK09vRk5jYTE5SHJuZ0lHaksyUzNG?=
 =?utf-8?B?WUVNaG1YeTZMa1lqRmV5NzliT09WRmtYM2lmRVpUWHRleTEzemdTZEswMm1D?=
 =?utf-8?B?cDd4c0NLRkQrT2EyVlE3aTNRYlp6OGMreVVUYTd1dW5ieEgraFNoa3dBdjRK?=
 =?utf-8?Q?pSh+307MgMnyU8RE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <00639E9C560D60468C0B6553B56ABFAE@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR09MB8140.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc0bae86-ef27-4790-ddae-08de8c07bcc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 13:49:59.2395 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fwt7+LfmY/q1NszwLBzSL0RGXh5t8a54dQeGit7V0+5wwfX8qxTNEfiRdp11LtVuN1osS+HTfB48yTAtgPEOb1o5OA6hPHAdSIpN1wsAmBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR09MB4570
X-Mailman-Approved-At: Fri, 27 Mar 2026 17:24:54 +0100
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

SGkgTGVvLA0KDQpPbiAzLzE3LzI2IDA5OjQ5LCBMZW8gTGlhbmcgd3JvdGU6DQo+IE9uIFdlZCwg
RGVjIDI0LCAyMDI1IGF0IDAzOjQ3OjAyUE0gKzAwMDAsIFVyb3MgU3RhamljIHdyb3RlOg0KPj4g
RnJvbTogQ2hhby15aW5nIEZ1IDxjZnVAbWlwcy5jb20+DQo+Pg0KPj4gQWRkIG9wdGlvbmFsIFBI
WSByZXNldCBzdXBwb3J0IHZpYSBHUElPIGRlZmluZWQgaW4gdGhlIGRldmljZSB0cmVlLg0KPj4N
Cj4+IEltcHJvdmUgcm9idXN0bmVzcyBieSBoYW5kbGluZyBwcm9iZSBlcnJvcnMgYW5kIGZhbGxp
bmcgYmFjayB0byB0aGUNCj4+IGVudmlyb25tZW50LXByb3ZpZGVkIE1BQyBhZGRyZXNzIGlmIG5v
IGhhcmR3YXJlIE1BQyBpcyBmb3VuZC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDaGFvLXlpbmcg
RnUgPGNmdUBtaXBzLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFVyb3MgU3RhamljIDx1cm9zLnN0
YWppY0BodGVjZ3JvdXAuY29tPg0KPj4gLS0tDQo+PiAgIGJvYXJkL21pcHMvYm9zdG9uLXJpc2N2
L0tjb25maWcgfCAgNCArKysrDQo+PiAgIGRyaXZlcnMvbmV0L3BjaF9nYmUuYyAgICAgICAgICAg
fCAzNyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0NCj4+ICAgZHJpdmVycy9uZXQv
cGNoX2diZS5oICAgICAgICAgICB8ICAxICsNCj4+ICAgMyBmaWxlcyBjaGFuZ2VkLCA0MCBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ib2FyZC9taXBz
L2Jvc3Rvbi1yaXNjdi9LY29uZmlnIGIvYm9hcmQvbWlwcy9ib3N0b24tcmlzY3YvS2NvbmZpZw0K
Pj4gaW5kZXggNjhjNWZjNTA0ODkuLjRkNTVkOTY2MDNlIDEwMDY0NA0KPj4gLS0tIGEvYm9hcmQv
bWlwcy9ib3N0b24tcmlzY3YvS2NvbmZpZw0KPj4gKysrIGIvYm9hcmQvbWlwcy9ib3N0b24tcmlz
Y3YvS2NvbmZpZw0KPj4gQEAgLTQwLDQgKzQwLDggQEAgY29uZmlnIFBIWV9SRUFMVEVLDQo+PiAg
ICAgICBib29sDQo+PiAgICAgICBkZWZhdWx0IHkNCj4+DQo+PiArY29uZmlnIFRGVFBfRklMRV9O
QU1FX01BWF9MRU4NCj4+ICsgICAgaW50ICJNYXhpbXVtIGxlbmd0aCBvZiBURlRQIGZpbGUgbmFt
ZSINCj4+ICsgICAgZGVmYXVsdCAyNTYNCj4+ICsNCj4+ICAgZW5kaWYNCj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL25ldC9wY2hfZ2JlLmMgYi9kcml2ZXJzL25ldC9wY2hfZ2JlLmMNCj4+IGluZGV4
IGFkZWNhM2QwNDBkLi5kZWE4YWI4MjhhYyAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbmV0L3Bj
aF9nYmUuYw0KPj4gKysrIGIvZHJpdmVycy9uZXQvcGNoX2diZS5jDQo+PiBAQCAtNyw2ICs3LDcg
QEANCj4+DQo+PiAgICNpbmNsdWRlIDxjcHVfZnVuYy5oPg0KPj4gICAjaW5jbHVkZSA8ZG0uaD4N
Cj4+ICsjaW5jbHVkZSA8ZW52Lmg+DQo+PiAgICNpbmNsdWRlIDxlcnJuby5oPg0KPj4gICAjaW5j
bHVkZSA8bG9nLmg+DQo+PiAgICNpbmNsdWRlIDxtYWxsb2MuaD4NCj4+IEBAIC0xNSw2ICsxNiw3
IEBADQo+PiAgICNpbmNsdWRlIDxtaWlwaHkuaD4NCj4+ICAgI2luY2x1ZGUgPGxpbnV4L2RlbGF5
Lmg+DQo+PiAgICNpbmNsdWRlICJwY2hfZ2JlLmgiDQo+PiArI2luY2x1ZGUgPGFzbS9ncGlvLmg+
DQo+IA0KPiBUaGlzIHNob3VsZCBiZSA8YXNtLWdlbmVyaWMvZ3Bpby5oPiwgcmlnaHQ/DQo+IA0K
DQpUaGFua3MsIHlvdSdyZSByaWdodC4gSSdsbCBzd2l0Y2ggaXQgdG8gPGFzbS1nZW5lcmljL2dw
aW8uaD4gaW4gdGhlIG5leHQgDQpyZXZpc2lvbi4NCg0KPj4NCj4+ICAgI2lmICFkZWZpbmVkKENP
TkZJR19QSFlMSUIpDQo+PiAgICMgZXJyb3IgIlBDSCBHaWdhYml0IEV0aGVybmV0IGRyaXZlciBy
ZXF1aXJlcyBQSFlMSUIgLSBtaXNzaW5nIENPTkZJR19QSFlMSUIiDQo+PiBAQCAtMzMsNiArMzUs
MTMgQEAgc3RhdGljIHZvaWQgcGNoX2diZV9tYWNfcmVhZChzdHJ1Y3QgcGNoX2diZV9yZWdzICpt
YWNfcmVncywgdTggKmFkZHIpDQo+PiAgICAgICAgbWFjaWRfbG8gPSByZWFkbCgmbWFjX3JlZ3Mt
Pm1hY19hZHJbMF0ubG93KSAmIDB4ZmZmZjsNCj4+ICAgICAgICBkZWJ1ZygicGNoX2diZTogbWFj
aWRfaGkgJSN4IG1hY2lkX2xvICUjeFxuIiwgbWFjaWRfaGksIG1hY2lkX2xvKTsNCj4+DQo+PiAr
ICAgICBpZiAoIW1hY2lkX2xvICYmICFtYWNpZF9oaSkgew0KPj4gKyAgICAgICAgICAgICBpZiAo
ZXRoX2Vudl9nZXRfZW5ldGFkZHIoImV0aGFkZHIiLCBhZGRyKSkNCj4+ICsgICAgICAgICAgICAg
ICAgICAgICByZXR1cm47DQo+PiArDQo+PiArICAgICAgICAgICAgIHByaW50ZigiTm8gTUFDIGZv
dW5kIGluIGVpdGhlciBFRzIwVCBIL1cgb3IgZW52aXJvbm1lbnQiKTsNCj4+ICsgICAgIH0NCj4+
ICsNCj4+ICAgICAgICBhZGRyWzBdID0gKHU4KShtYWNpZF9oaSAmIDB4ZmYpOw0KPj4gICAgICAg
IGFkZHJbMV0gPSAodTgpKChtYWNpZF9oaSA+PiA4KSAmIDB4ZmYpOw0KPj4gICAgICAgIGFkZHJb
Ml0gPSAodTgpKChtYWNpZF9oaSA+PiAxNikgJiAweGZmKTsNCj4+IEBAIC03NCw2ICs4MywxNCBA
QCBzdGF0aWMgaW50IHBjaF9nYmVfcmVzZXQoc3RydWN0IHVkZXZpY2UgKmRldikNCj4+ICAgICAg
ICBwcml2LT5yeF9pZHggPSAwOw0KPj4gICAgICAgIHByaXYtPnR4X2lkeCA9IDA7DQo+Pg0KPj4g
KyAgICAgaWYgKGRtX2dwaW9faXNfdmFsaWQoJnByaXYtPmdwaW9fcGh5X3Jlc2V0KSkgew0KPj4g
KyAgICAgICAgICAgICAvKiBSZXNldCB0aGUgUEhZICovDQo+PiArICAgICAgICAgICAgIGRtX2dw
aW9fc2V0X3ZhbHVlKCZwcml2LT5ncGlvX3BoeV9yZXNldCwgMSk7DQo+PiArICAgICAgICAgICAg
IHVkZWxheSgxNTAwMCk7DQo+PiArICAgICAgICAgICAgIGRtX2dwaW9fc2V0X3ZhbHVlKCZwcml2
LT5ncGlvX3BoeV9yZXNldCwgMCk7DQo+PiArICAgICAgICAgICAgIHVkZWxheSg1MDAwKTsNCj4+
ICsgICAgIH0NCj4+ICsNCj4+ICAgICAgICB3cml0ZWwoUENIX0dCRV9BTExfUlNULCAmbWFjX3Jl
Z3MtPnJlc2V0KTsNCj4+DQo+PiAgICAgICAgLyoNCj4+IEBAIC00NTAsNiArNDY3LDExIEBAIHN0
YXRpYyBpbnQgcGNoX2diZV9wcm9iZShzdHJ1Y3QgdWRldmljZSAqZGV2KQ0KPj4gICAgICAgIHBs
YXQtPmlvYmFzZSA9ICh1bG9uZylpb2Jhc2U7DQo+PiAgICAgICAgcHJpdi0+bWFjX3JlZ3MgPSAo
c3RydWN0IHBjaF9nYmVfcmVncyAqKWlvYmFzZTsNCj4+DQo+PiArICAgICBlcnIgPSBncGlvX3Jl
cXVlc3RfYnlfbmFtZShkZXYsICJwaHktcmVzZXQtZ3Bpb3MiLCAwLA0KPj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgJnByaXYtPmdwaW9fcGh5X3Jlc2V0LCBHUElPRF9JU19PVVQp
Ow0KPj4gKyAgICAgaWYgKGVyciAmJiAoZXJyICE9IC1FTk9FTlQpKQ0KPj4gKyAgICAgICAgICAg
ICByZXR1cm4gZXJyOw0KPj4gKw0KPj4gICAgICAgIC8qIFJlYWQgTUFDIGFkZHJlc3MgZnJvbSBT
Uk9NIGFuZCBpbml0aWFsaXplIGRldi0+ZW5ldGFkZHIgd2l0aCBpdCAqLw0KPj4gICAgICAgIHBj
aF9nYmVfbWFjX3JlYWQocHJpdi0+bWFjX3JlZ3MsIHBsYXQtPmVuZXRhZGRyKTsNCj4+DQo+PiBA
QCAtNDU5LDkgKzQ4MSwxNyBAQCBzdGF0aWMgaW50IHBjaF9nYmVfcHJvYmUoc3RydWN0IHVkZXZp
Y2UgKmRldikNCj4+DQo+PiAgICAgICAgZXJyID0gcGNoX2diZV9yZXNldChkZXYpOw0KPj4gICAg
ICAgIGlmIChlcnIpDQo+PiAtICAgICAgICAgICAgIHJldHVybiBlcnI7DQo+PiArICAgICAgICAg
ICAgIGdvdG8gb3V0X2VycjsNCj4+ICsNCj4+ICsgICAgIGVyciA9IHBjaF9nYmVfcGh5X2luaXQo
ZGV2KTsNCj4+ICsgICAgIGlmIChlcnIpDQo+PiArICAgICAgICAgICAgIGdvdG8gb3V0X2VycjsN
Cj4+DQo+PiAtICAgICByZXR1cm4gcGNoX2diZV9waHlfaW5pdChkZXYpOw0KPj4gKyAgICAgcmV0
dXJuIDA7DQo+PiArb3V0X2VycjoNCj4+ICsgICAgIGlmIChkbV9ncGlvX2lzX3ZhbGlkKCZwcml2
LT5ncGlvX3BoeV9yZXNldCkpDQo+PiArICAgICAgICAgICAgIGRtX2dwaW9fZnJlZShkZXYsICZw
cml2LT5ncGlvX3BoeV9yZXNldCk7DQo+PiArICAgICByZXR1cm4gZXJyOw0KPj4gICB9DQo+Pg0K
Pj4gICBzdGF0aWMgaW50IHBjaF9nYmVfcmVtb3ZlKHN0cnVjdCB1ZGV2aWNlICpkZXYpDQo+PiBA
QCAtNDcyLDYgKzUwMiw5IEBAIHN0YXRpYyBpbnQgcGNoX2diZV9yZW1vdmUoc3RydWN0IHVkZXZp
Y2UgKmRldikNCj4+ICAgICAgICBtZGlvX3VucmVnaXN0ZXIocHJpdi0+YnVzKTsNCj4+ICAgICAg
ICBtZGlvX2ZyZWUocHJpdi0+YnVzKTsNCj4+DQo+PiArICAgICBpZiAoZG1fZ3Bpb19pc192YWxp
ZCgmcHJpdi0+Z3Bpb19waHlfcmVzZXQpKQ0KPj4gKyAgICAgICAgICAgICBkbV9ncGlvX2ZyZWUo
ZGV2LCAmcHJpdi0+Z3Bpb19waHlfcmVzZXQpOw0KPj4gKw0KPj4gICAgICAgIHJldHVybiAwOw0K
Pj4gICB9DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3BjaF9nYmUuaCBiL2RyaXZl
cnMvbmV0L3BjaF9nYmUuaA0KPj4gaW5kZXggN2UwZmRiZmQ1YTMuLmRjYmI5NDA5NGJjIDEwMDY0
NA0KPj4gLS0tIGEvZHJpdmVycy9uZXQvcGNoX2diZS5oDQo+PiArKysgYi9kcml2ZXJzL25ldC9w
Y2hfZ2JlLmgNCj4+IEBAIC0yOTIsNiArMjkyLDcgQEAgc3RydWN0IHBjaF9nYmVfcHJpdiB7DQo+
PiAgICAgICAgc3RydWN0IHVkZXZpY2UgKmRldjsNCj4+ICAgICAgICBpbnQgcnhfaWR4Ow0KPj4g
ICAgICAgIGludCB0eF9pZHg7DQo+PiArICAgICBzdHJ1Y3QgZ3Bpb19kZXNjIGdwaW9fcGh5X3Jl
c2V0Ow0KPj4gICB9Ow0KPj4NCj4+ICAgI2VuZGlmIC8qIF9QQ0hfR0JFX0hfICovDQoNCkJlc3Qg
cmVnYXJkcywNClVyb3M=
