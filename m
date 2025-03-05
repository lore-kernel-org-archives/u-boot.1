Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D777C282E3
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 11:40:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D82ED807B1;
	Wed,  5 Mar 2025 12:40:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="vAFQufHJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46A438083E; Wed,  5 Mar 2025 12:40:12 +0100 (CET)
Received: from TYVP286CU001.outbound.protection.outlook.com
 (mail-japaneastazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c405::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A36FC8003E
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 12:40:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=biju.das.jz@bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lsEqOQlGjyGB9Y1kN8pLLM1OkXp1rPuJ2JCLBpLi+whnr4cyFz4O6owBHkHn9M0fGp+laTRaqNr55iHTwXJ2ct+RnsjPrbT/sEoUZSWPOw0zRPCzUiwDYEUBTkZUKYoDxM6omrMauI1tlA30M87WZYOBWdYPiTgHRy+Epf1jVOOhBt5WeyfJsLd/Qh0Uns54FOsbM9OMl1zKxOTt4/VPi+PCPEXMQ0mTA3Xj7vn5+fn/vhCtT2DyykOZQGrNSBJLgTHdCuDpupUwb09l/C/fd96YTeFiubP4kCSs+8/oqfwoREVcAqcdDoGRdpHwBTzFPf6D6EBNjlM/jDHcMKKg2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JF3sZwSXo2o0KQ2GvhHWo8wjIqQuy80wAQVB2KyoEog=;
 b=vGtARa0C5Disq+0SiGCx5JWuhfK5QqHYzxXbuU++ZOjV5PBvUw6EklSY/+5AS6PvN5KN1aYILHCFbSk6B3I1nxtL5sdx2+Re49h/DhxwKNHylucj1N61hmc0VSnsFJPjdT01N1oZzYiFbHb/kBON7sL5rjIKSR9VuqPEuqovFbQ4Sf+FFlT4Pvx0f3DCYmyiRv2mv3nJ5zyCBBE7z6QneyQJZsc4CKzvSTc4uVnemk9OEt0CSvPlJ6+UX9ux3lvCw+ZfIlFofib9FJsOLqwNhTpQtSwgYP/dWfyJvpi+Ado3S4Gbf0OCuuCqa1iU8Cn/cT6QiIUDmlRWBkT3fFIe5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JF3sZwSXo2o0KQ2GvhHWo8wjIqQuy80wAQVB2KyoEog=;
 b=vAFQufHJTvytsF2bDHOjtkhAsMyBTcTP4Ih8kg+5MhzOobmGOEW9TPhCnrsNARMB3QYJ/GkdAaAKBUOlzoTW81kILOpSt7l31AUq1zNM4J9ZSWe5+Ma7sYG+yVXhMoOk89o0mVJj56pF8Uye8dJNuXbgyPbngPxryH+8POfJc+Y=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYVPR01MB11294.jpnprd01.prod.outlook.com (2603:1096:400:36a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 11:40:04 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 11:40:04 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Paul Barker <paul.barker.ct@bp.renesas.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH 1/5] reset: rzg2l-usbphy-ctrl: Add new driver
Thread-Topic: [PATCH 1/5] reset: rzg2l-usbphy-ctrl: Add new driver
Thread-Index: AQHbjSPUJdziOWZfOkyOEhFojIQZx7NjNLYggAE2uwCAAACdAA==
Date: Wed, 5 Mar 2025 11:40:04 +0000
Message-ID: <TY3PR01MB1134614FFFEA2FE5CD59A278286CB2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250304163736.89326-1-paul.barker.ct@bp.renesas.com>
 <20250304163736.89326-2-paul.barker.ct@bp.renesas.com>
 <TY3PR01MB11346554557CE20B11A93AAF086C82@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <8a36371e-2608-49f6-89d9-8a9546bc522f@bp.renesas.com>
In-Reply-To: <8a36371e-2608-49f6-89d9-8a9546bc522f@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYVPR01MB11294:EE_
x-ms-office365-filtering-correlation-id: 793583e8-fa85-4804-34ce-08dd5bda78d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aEU5TGN6UURpQW1LQTRHNVlWZzNubC80azRKb3VkRXdYeDhNb2NmQzJFaFJV?=
 =?utf-8?B?dnRsbUxhWEJ4dnpaTDhEMmlqMzVtS2RpU2xVWmNnV04xaEUwN3lvUWhsTjAz?=
 =?utf-8?B?SmtESTkrVzEyS05UYzk1Q1F3SE5NU3JqUHBpeUUrTFJJR3Y1N2ovTVNIMlpZ?=
 =?utf-8?B?ZXZmVHo4N0dYMmRFRlBnYjFyc3FySDdpSndSalBSSnNsaE9PZXNnbENGcUV4?=
 =?utf-8?B?ODc3YW9ESG4raVVxMjVsd2hHWWhaWkNDU2pvaGFvQzFGTk1UbmxYQTZaWXlG?=
 =?utf-8?B?VXh6VVhkeE1YM3ZWdnNlYkNsT3FiT0VBL0ExZW9BUi9oa2xKWHlFaHNtZVBC?=
 =?utf-8?B?Y1g3MWlnY3hGalQvTkdqK2ZSZWwrL0xJcy9SMmpTL0pGaVBjSXd4R1pGa0dx?=
 =?utf-8?B?cExmSW84Z0pMMExLdnlaK3JEVXFpcEtRZHRDN0J4MjBNSU9vK28xQUdLVXIx?=
 =?utf-8?B?ZFZtNmY2RjUxc3F6bTQ5UGRhZHJhbGdyVUtRTWJmNUYrRlBKMDdwVkloVkxj?=
 =?utf-8?B?cGhlK09hcHdRdnJQVFZwQ0RWWFZLZ1NDaGk4QTF6OUpiWUxRVW9kNlpQVXpW?=
 =?utf-8?B?U1lBY1VXeEJXYUlUSkN1ckVZM21lTkFncDd6VzRnNXEvUC85OVhJMlkvTFBG?=
 =?utf-8?B?TW5FTkRta2hmd0NsZHVOeHlIQ29BeG5rTkJzS3VXemZtM2wvLzBteXMzVEdV?=
 =?utf-8?B?RGQ4NklMR2JmeHVJRTVLTjNhMGRRb0lGcGNnb0hsVzdaTlI5dGg3RElheWxB?=
 =?utf-8?B?dmp0bUhjR1hPaHhNVDNjUFI2dkxkeVhVM3pvdWxVYVdnV0hqSkdmemJLMUFy?=
 =?utf-8?B?Q08vMTZLTlI3ZWJsd0gxTnRGUjl4cy9pYWZDTkwyZWVDLzdHQkJQTkplQmV6?=
 =?utf-8?B?WTlXWktVYSsySyt3Yk9FSmt4bVRpcTNwUkZ6MkZsaHptLzJpa3FhejI0MU93?=
 =?utf-8?B?L0kwKzF1dkpZMzkzNmJFT0FNemxGUDNXMC9xVUpSbVpmalhIY09OQXUyUnF3?=
 =?utf-8?B?bm5oNUNXbjNtWGw5WDYyVlgvdGF6MndrT3o1UkJ6dGVWM1lCZWtHRzBYbGk4?=
 =?utf-8?B?bUJlWGYzUlhLeDhPbVdsZG1RbFkvbXBhQWt3QlIzbTRqTFovZUFzV3RYeFRO?=
 =?utf-8?B?M09OQUVJWDg5NkhpbWczN2k4bEVyMTMvZ0pCYzZ0QzRWdlRNZTlvaEVnV0cw?=
 =?utf-8?B?Rk5uVDVZU21BZEowMWpFbVN2bE1OTS9KWndmR2lLYUdscUxrUFJlTm9pam0v?=
 =?utf-8?B?TXZ6Qm96S1RkRzFQc21KQzROZGxWRzB4S0dMYTNkUzNDQWgvZmxjbW81WlNW?=
 =?utf-8?B?UGovVmRxd0RyWHp3M3F3dUJ5MlhTbDdJVkR0WEdpNHpaeENReXZZVXRGdS9V?=
 =?utf-8?B?SjFOWXBYRGRNZDlGZFhUaXhBMGd2RStVY0N3eG5zV082UWREL3pEVWNHYUpZ?=
 =?utf-8?B?aFZERkhjZ2lEQjhmZitOVVhZZjd0azhhN0FyUTNDaVp2cXk4RmdjbkJtRXc4?=
 =?utf-8?B?ekdmZjlMRTdBbHFtdzV4eUJlZUxCTlc1b0o1T3cvL1dnOEFBbFNsbmJ1cHhF?=
 =?utf-8?B?V0lBeW9mUS9OK3VGbnRRV2xpVjdPMTJmQWNkUGZheEpiYklVNjF4S3I5Y0tv?=
 =?utf-8?B?OGpqcStyV0djdWI5YjZkV2hQSWFkV3Q5dTdOeFNyeVZCdTJQc3dLTzRSOXAz?=
 =?utf-8?B?MnU2RklBdjJjdys5MjRXSXlVMmxEQUlDN0Y4Tk92cXVEbHRTeXNpeS8rYnIv?=
 =?utf-8?B?bjN3N1Nna2RWL05HaC9aeU9TUkxuNnBtSm9UdnJhWFh3aDlEcDQ2aXN3TWE2?=
 =?utf-8?B?clN2VC9aUWU2Tjc2ZHg1c1o0K1N1YytuZFRoNThuU09aeEhmR2NibXZEZ2Vz?=
 =?utf-8?B?enV3L2FnTUgyMy9WQ0gvaHlsYkpTcmIvbXEvK2ZyRG1UeGRIY1NYK3RCZWIz?=
 =?utf-8?Q?VjZgxLU5KLQRUma1s8/jObS0KbPXIpNi?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0gzaFdMRFdQcGUzUVc4Z0hPQ3JNMjZzbklid1Z0RU5nRGgxVlhwbDBLWVpn?=
 =?utf-8?B?QVgvb2ZadThTU2hORXJqa05NNkZSREgyZmlKL0JUTWtBT1RsVTY5MlFaUmlF?=
 =?utf-8?B?Mm9YVFRUdnJTblZCa0g4WS9sTCtJM2crSnozc0JzanZLM2ZlWmlxclVkMCtj?=
 =?utf-8?B?K3Y1R3AwR0svQjRab3NISkpFczJnTG41R25yUDN4ejZXdFNLUk9RMUdSUjZ0?=
 =?utf-8?B?UmNxcFRUbjZkMzRJWlhBRURnRDc4SmpyaENXSUFyUU12SjFFY3VDaDJleWRW?=
 =?utf-8?B?b0ZPV25UK2YvdElYYjAvRW1PZ3VSV1Z4VkpxUXJ1U25CcE9GeUwxYXlnc24v?=
 =?utf-8?B?N0xkbjM2NmozQXA2SDQ2R2JJZGYzd0FlTy9LbjV6ajcrUWdnSU43dXYrOU10?=
 =?utf-8?B?RGRrTmZaQmo5dENIelFVbWs1bWExTy9yN0pFUlZFVjJ3Nk5MdjJtVGgwOS84?=
 =?utf-8?B?djNJZkZ0UG8rY0NaS0dwRStyMVVvWERuRkRsb3NOeXB4VHZoL1llUG8yeThp?=
 =?utf-8?B?Zy91Y2wxVzBaQU8xcDVaZkpINklSSE5LV3prdXpkZTZnMDdTQlBLNklPOW9k?=
 =?utf-8?B?Y3dPUG53ck13TUZFZUhBL2tpRjVQSXJXSmtUWDUrVmtjM3FNN05lYUdBTVhG?=
 =?utf-8?B?UHRsWWdNT1FTUVdSd25DRGJnT2lETDJDTnVXUnM0TldTR2p5TFV1R3JMUFli?=
 =?utf-8?B?MHJibWFFeThyd0lBNktXeGJWbkNNUWJZZXpPSVlGNlZRRDFYZ0JMSGQ1WCtY?=
 =?utf-8?B?dE4yWGw0b0Jtd1FjR3JuL0Y3VU4wUjczWnQ3MnNxWGFQZFdoMGZ1KzBlelUz?=
 =?utf-8?B?ZjVCQWs1d1Z4UDg1endsaTBoWHFJNklENDd6Q2xvT253TFNlM3pZbVp2eGRo?=
 =?utf-8?B?QWNabmpEa0RCTVdJb3pTOVRCV0JMQ05xdVFpRmtuUGlpcUEvVUduM00wY2NP?=
 =?utf-8?B?NWEycEY4NGtxVzdOci9nU2lxK0tzZGFZb214YVRpYlEvQ1VTNmV0TkM0SGE2?=
 =?utf-8?B?bEk1N2p5UVJjd2h1UTg5Y2JpWVQ2b1RZcE94V0hYQklBK1U1NGdWOW95MVVk?=
 =?utf-8?B?Qm14UUpmcmFtenN6UEsxRU9jVDRQSUUydnpRdUFPTFQwUGV2a0RXTWI5VzZO?=
 =?utf-8?B?U3UvdFJvZ2M1NGVVWTJsa2k4OHhZSkVFbVVURzNQY3A4bUdUWG1SNmdtVDV0?=
 =?utf-8?B?Y3lQNGZTcFducVdHM05OaTdhYktnQXc5bVBsZ3RlNFVZcXJyU1FyemYwakxv?=
 =?utf-8?B?N3Exc1lJbXhlUWQ2SzRUT0xRVk9yQW1JYTlXTGVWSWo1c0MxK0FXN3NwbFF6?=
 =?utf-8?B?d2dMekMzQXQwWHVvajdidnFmb0tFMnllQU81cVplbmwvZmt3SE41d0Fhcmlx?=
 =?utf-8?B?NWpOWHNuM1ErdHV5QlNFUXloQVJKdGdEeXlLYXBnV1VRaEUzV0RkNWxqY1Yy?=
 =?utf-8?B?UVNHRlR0U1hsaitQdWEvR3FZd1NGLytkZ0duZkpGYk56QUtBUG8zZDdqZ0dN?=
 =?utf-8?B?QnVoZkpYUlQ1RkJxamxrb1QyVmVsdXRSWFdPK1NQV0Q0NzNFcVdQNHVydk1H?=
 =?utf-8?B?MG5DMHByRHI5aXVsNk5USG52MWhKYTJiLzI3Tm01UkwzcmcrQlJkdFFtRTh0?=
 =?utf-8?B?Ri9HdENrK3NGVW5ycmg2Q0FHWHplaExaVExydkhTeWRNZWZsWlh1QXF1MDhD?=
 =?utf-8?B?d2tyVEptaVlmVlEzZDhOZ0p0cmJlb0tGclMvejlxb2J6aUVkalZzTDI1TUZC?=
 =?utf-8?B?c3dGeGkzeHhEODc3WlFJcDdlMVFJcHNWZy9XQUNuaWYvUWp1Z1EzcVhvVWd2?=
 =?utf-8?B?ZnJ0bE96RjJwVlBBL2drTmRGdFFrb1V3eFdDV3ZpVE5BVCtDTzd5UkE4cGlq?=
 =?utf-8?B?SEFDTDRMTGs2YjJXL2JWNmVVMlRscGlvRENYY09xLytuTVk1ZW9ETlJxb0N6?=
 =?utf-8?B?SlFueWhUSXRnb0ZDSmM0VlM2TmVIVXYxcjVEOENFbDFhSWtDaWFzY0M5ZGhJ?=
 =?utf-8?B?OEhLUzZTZk9YUk1ybmpPSS84T3NlUnJGTmg5cWF3RnlaYkIvc2FpQkFqOU1V?=
 =?utf-8?B?am55RVhGdzBFSHBBcXA1ZHBOUld2M3hjaE0zSEhkMTZtSWJxTmVEWEhqRlE3?=
 =?utf-8?B?a1NEcXlsaEs3dTREU3VUMkZWd0lOaER3R2RBUFArQldWM1IvNExXRzNHelp4?=
 =?utf-8?B?Rnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 793583e8-fa85-4804-34ce-08dd5bda78d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 11:40:04.4892 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b5e26EHhWtk2yxZCr5QxUzykCgL38v1fUvzg7x4K7GU8N6/TYNIsj5Vj22bYSGJSk3sKlIy32ePUl+AokK/FP9OtCBtRb6n+4h6kAySGKSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11294
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

SGkgUGF1bCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYXVsIEJh
cmtlciA8cGF1bC5iYXJrZXIuY3RAYnAucmVuZXNhcy5jb20+DQo+IFNlbnQ6IDA1IE1hcmNoIDIw
MjUgMTE6MzcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzVdIHJlc2V0OiByemcybC11c2JwaHkt
Y3RybDogQWRkIG5ldyBkcml2ZXINCj4gDQo+IE9uIDA0LzAzLzIwMjUgMTc6MDcsIEJpanUgRGFz
IHdyb3RlOg0KPiA+IEhpIFBhdWwsDQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gPj4gRnJvbTogVS1Cb290IDx1LWJvb3QtYm91bmNlc0BsaXN0cy5kZW54LmRlPiBPbiBC
ZWhhbGYgT2YgUGF1bCBCYXJrZXINCj4gPj4gU3ViamVjdDogW1BBVENIIDEvNV0gcmVzZXQ6IHJ6
ZzJsLXVzYnBoeS1jdHJsOiBBZGQgbmV3IGRyaXZlcg0KPiANCj4gPj4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvcmVuZXNhcy9yemcybC11c2JwaHkuaA0KPiA+PiBiL2luY2x1ZGUvcmVuZXNhcy9yemcy
bC11c2JwaHkuaCBuZXcgZmlsZSBtb2RlIDEwMDY0NCBpbmRleA0KPiA+PiAwMDAwMDAwMDAwMDAu
LjFhNDZiNTg1ZjE3MA0KPiA+PiAtLS0gL2Rldi9udWxsDQo+ID4+ICsrKyBiL2luY2x1ZGUvcmVu
ZXNhcy9yemcybC11c2JwaHkuaA0KPiA+PiBAQCAtMCwwICsxLDE3IEBADQo+ID4+ICsvKiBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCAqLw0KPiA+PiArLyoNCj4gPj4gKyAqIFJaL0cy
TCBVU0IgUEhZIGNvbW1vbiBkZWZpbml0aW9ucw0KPiA+PiArICoNCj4gPj4gKyAqIENvcHlyaWdo
dCAoQykgMjAyMS0yMDIzIFJlbmVzYXMgRWxlY3Ryb25pY3MgQ29ycC4NCj4gPj4gKyAqLw0KPiA+
PiArDQo+ID4+ICsjaWZuZGVmIFJFTkVTQVNfUlpHMkxfVVNCUEhZX0gNCj4gPj4gKyNkZWZpbmUg
UkVORVNBU19SWkcyTF9VU0JQSFlfSA0KPiA+PiArDQo+ID4+ICsjaW5jbHVkZSA8ZmR0ZGVjLmg+
DQo+ID4+ICsNCj4gPj4gK3N0cnVjdCByemcybF91c2JwaHlfY3RybF9wcml2IHsNCj4gPj4gKwlm
ZHRfYWRkcl90IHJlZ3M7DQo+ID4NCj4gPiBUaGlzIGhlYWRlciBmaWxlIG1heSBub3QgYmUgcmVx
dWlyZWQuIEFzIGl0IGlzIGEgc2luZ2xlIHZhcmlhYmxlIGluDQo+ID4gc3RydWN0LiBJZiB5b3Ug
cGxhbiB0byBhZGQgbW9yZSB2YXJpYWJsZXMgaW4gdGhpcyBzdHJ1Y3QsIHRoZW4ga2VlcCBpdC4N
Cj4gPg0KPiA+IE90aGVyd2lzZSwgWW91IGNhbiBkaXJlY3RseSB1c2UgZHJpdmVyIGRhdGEgYXMg
cmVncyBpbiAuYyBmaWxlIGxpa2UgYmVsb3c/Pw0KPiA+DQo+ID4gc3RydWN0IGZkdF9hZGRyX3Qg
KnJlZ3MgPSBkZXZfZ2V0X3ByaXYoZGV2KTsNCj4gDQo+IEhpIEJpanUsDQo+IA0KPiBJIHByZWZl
ciB0byBoYXZlIGEgc3RydWN0IGRlZmluZWQgaW4gYSBoZWFkZXIgZmlsZSBpbiBjYXNlIHdlIG5l
ZWQgdG8gY2hhbmdlIHRoaW5ncyBpbiB0aGUgZnV0dXJlLg0KPiBUaGlzIGVuc3VyZXMgdGhhdCBi
b3RoIHJ6ZzJsLXVzYnBoeS1yZWd1bGF0b3IuYyBhbmQgcmVzZXQtcnpnMmwtdXNicGh5LWN0cmwu
YyB1c2UgdGhlIHNhbWUgdHlwZQ0KPiBkZWZpbml0aW9uLiBXaXRob3V0IGEgc3RydWN0dXJlIGFu
ZCBhIGNvbW1vbiBoZWFkZXIsIGl0IHdvdWxkIGJlIGZhciB0b28gZWFzeSBmb3Igc29tZW9uZSB0
bw0KPiBhY2NpZGVudGFsbHkgY2hhbmdlIHRoZSB0eXBlIGluIHRoZSByZXNldCBkcml2ZXIgYW5k
IG5vdCBub3RpY2UgdGhlIGFzc29jaWF0ZWQgcmVndWxhdG9yIGRyaXZlci4NCj4gDQo+IFRoZXJl
IGlzIGEgc21hbGwgY29zdCBvZiBhbGxvY2F0aW5nIHNwYWNlIGZvciBhbiBpbnN0YW5jZSBvZiBz
dHJ1Y3QgcnpnMmxfdXNicGh5X2N0cmxfcHJpdiwgYnV0IEkNCj4gdGhpbmsgdGhpcyBpcyBvay4N
Cg0KV2UgY2FuIGF2b2lkIHVubmVjZXNzYXJ5IHB1YmxpYyBmaWxlLiBUaGF0IGlzIHRoZSBvbmx5
IHJlYXNvbi4NCg0KQ2hlZXJzLA0KQmlqdQ0K
