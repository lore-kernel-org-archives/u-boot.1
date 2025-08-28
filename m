Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8726CA0EED
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 08:57:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D434832AD;
	Thu, 28 Aug 2025 10:57:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="D3qmG6kh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3522D832AD; Thu, 28 Aug 2025 10:57:16 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20724.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::724])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D7ED831D5
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 10:57:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m.schwan@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yy3GioATjARuEftZKlyRYVJsF4RsV1O56H0jXbNd4R+ojaA4JsJBJDq7j36lq58xd8SIPxynkSZSQ26xtBBnCuNALf4gQXnKMAL8acyamtClAHHELVq6DhGT7psVJb/h02Frt3VKw6VynYiagl/2agZTe+ha0lc7Ku/Duy1AYC9hIRAW3YuZ6KYk5rGPy0xaA02igXvbzsMxHxjw3LG8f6zVI5xjHJHwXK2nON7D5OXGKJviFQOx/fsvQidRRa9d3n7nMATy1snZzy0x47aJ4fB0n6mtfqPJ+imIZAyXqPqqgEUoDPX+FQHjab0TLIa4jNMPMJ1LhSr8BWSiPD8aDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/o7H0JP79DUQLYN5VOtEJxF6zINkHO+ElDG1HTkxNY=;
 b=IQkh8zW+PHiU5olT3yDp+Tx9ZeARE270tiKWGvBV1P1FVylr4plksOrfnOO7ssQHEcMtkRPYBbn7vOfQL30GmIdXYQ/a3+KyDoJZbGM3jRxmVlluQdHlOjptMPXMKgCTaocHhUfcKR44LsRF7fifSG5RpQ64de1nX9zLd4hkn5uGFphuT3QWHJgCNwy2QS1b1t9rkROS4ZF/MPLjmtK5bV6MuFyp62LA57bcs8OvobjorQvuIQsbc+o9pcce2Jej5BomzG/6Ve0Pa/IkF9kgExDwOw/GFcH0nfjXeANCTEsVJKMozyTYUPSHY0tsNoZHn4LtrRp+GSNu9t/wf38Y7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/o7H0JP79DUQLYN5VOtEJxF6zINkHO+ElDG1HTkxNY=;
 b=D3qmG6khnqmmfUBL/ciGlRvGfMJPyGtboKLbIOSShfPwq3zekgIWb3uqTq/sHtx2vXA/LgCxBkviZIsFpdyKw9/F3IaK3ZXBL7mMUO3kPR25KWbVrKx9W6xguPrFfZtvanWmUSMrwjH5GAA6caGEHgzxbyHRhMtDz2vH2oFTSs87n5gMVqyKCd0pMQSo6tJY2lsYV5otupphbTnzMZVedAg8XP88lg/MnO2H6bZ1rJu0MS8kY7hlL4STu9jOCurrkA3HRnWEOTIJMFKbjCU6mVscWVwQzQseo/3KMbsbPj8qmeqzHRwaeOxyMIhhIntOWkf54DApjfmn4JejsHRozA==
Received: from VI2P195MB2489.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::12)
 by PRAP195MB1556.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:297::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 08:57:12 +0000
Received: from VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
 ([fe80::83ab:361:2a81:b582]) by VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
 ([fe80::83ab:361:2a81:b582%5]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 08:57:12 +0000
From: Martin Schwan <m.schwan@phytec.de>
To: Christoph Stoidner <c.stoidner@phytec.de>, Primoz Fiser
 <primoz.fiser@norik.com>, "m.othacehe@gmail.com" <m.othacehe@gmail.com>,
 "trini@konsulko.com" <trini@konsulko.com>
CC: "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [Upstream] [PATCH 1/2] configs: imx93-phycore_defconfig: Disable
 CONFIG_AHAB_BOOT
Thread-Topic: [Upstream] [PATCH 1/2] configs: imx93-phycore_defconfig: Disable
 CONFIG_AHAB_BOOT
Thread-Index: AQHcF/SXo6hdRwfOo02ASvtMH92rILR3w5AA
Date: Thu, 28 Aug 2025 08:57:12 +0000
Message-ID: <fa4d9eb8b7333c5871b79acf9d09f6c10f74c438.camel@phytec.de>
References: <20250828082008.2978900-1-primoz.fiser@norik.com>
In-Reply-To: <20250828082008.2978900-1-primoz.fiser@norik.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2489:EE_|PRAP195MB1556:EE_
x-ms-office365-filtering-correlation-id: c2528442-2460-4d2a-ddaf-08dde610e0d7
x-ld-processed: e609157c-80e2-446d-9be3-9c99c2399d29,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RVNQeTMrYzB6ZjR6QXhBc3dMRXF4VFVRWjJwb2JwV1laakF6Z1VodkRCaUVx?=
 =?utf-8?B?Y01tcWRiVVU1R3NTYjEvQm9RSVBkSWRMa1Njd3Vxc3U4T05sQSs2TW92bHVk?=
 =?utf-8?B?RlB4ZUMwb3VBOXQ3UU11YTNGZ2srQVBUeGtsbVNyMmxmRFg0VWRjT0JTcnE1?=
 =?utf-8?B?OEF3cnZmcytXTURBenozd0QyRFdQbFpPbi91UTB6NER5dGV1VG5ENHN5VEcv?=
 =?utf-8?B?WFRJbXUvZTRyZEVseFlLK2g3ZktOTzdSaml6alhLZnlXV29aYTdQblA2cmJi?=
 =?utf-8?B?Tys1TmVuQjVYaldxUTNMNWl4VmZZTEt3TmlSR3JPNmNyWVVmemVrRnZqSy9z?=
 =?utf-8?B?T25IQUtYRE5LQ0FIbmVNZEdKSmk2RkZiNGlleFBkcnFPeGE5TmRGRTZiRlor?=
 =?utf-8?B?dUx3QlI3cnBkM3owWHhUR2VOd1pSK3JpSUxRQVpjRlMzeXdIc2ZSM3FZMC82?=
 =?utf-8?B?SkNyejNIeGNSa2lxaDJLM0l5NkpPazBkZWZKQkxuWlM4bXJXK0lLcW9kRHhj?=
 =?utf-8?B?MUgyL1VXUm9BTkVyOWl4bUJsOFRhR09XVnpTenFQdndkRHBjQlB4OThBQkhK?=
 =?utf-8?B?RStWMXRPNzNKdkhiVTdLVTBtVFVRQ0w1SldhMFU1eDVDbHpLUkplSlpZakJ3?=
 =?utf-8?B?eTcvbzZZMUhoK3pac2FrUzE2Z3hMVmc5cXZjclVFZzFnQ1g5MG9QSWUwN3R0?=
 =?utf-8?B?dVZTL2IwNmdpazBOQm81amwwT2tlUlV0THptOHUrR3U5dlhXZ1ZHOVJkTVVx?=
 =?utf-8?B?MzZrZ3o1bXNKb2N6K3Mzb09TZERPd1NrcCsrYzQ4ZFVoNG16dkxxRkYyKzN4?=
 =?utf-8?B?SFl4MW5nR2Zod1RzR3RBQXdUTHYvWHdvZHhYRnorM3loZXZOK2o2bUpIbitY?=
 =?utf-8?B?SXBIWHpPZU95ZWZndU95YTlSakM3QkVJWmExU0RIaXFDS2lDNEVzNjlOUmNZ?=
 =?utf-8?B?QVNXYUdTL3VFUTUzVTNFTVZTanpSRXdvTmw4MjN2eVhCYUp4VjZha1h6QVJw?=
 =?utf-8?B?MVluTHlTdWFJZWl2THlaZHR3Und1OFpFZkFySitrQ1VuT3NRYXZlSWRxNnAv?=
 =?utf-8?B?MjFDOVEyWnJHUS9UcHI0b0haMzNSUS9zSXZ0WU04b1FwcmZNTXUyMXd0S3U5?=
 =?utf-8?B?SXIrc0dxa0FkNXNUbjVFL05PZCtwQmVpcTliSm9QcU9SVE5xSDM4aHB1TE1v?=
 =?utf-8?B?QWF5SmdWUFVvRkhlYlIvZWVyU2pFWEI0NUNDT1dVc2pvNzVHcGpNTlZvOUZI?=
 =?utf-8?B?enA5Q0x0QktTUDF5d1kxUnhjYWYvbEg5UEpVSzZ5Vy9GOUdPRkJoZ3BCMUxO?=
 =?utf-8?B?ak9LcC9qRmd0cGhHbDVkSEd5ZC9YTUJMVXNOd0VPbldiNGN0NEJKSnJlcCtw?=
 =?utf-8?B?ZTcyMGo3Uk9iMElnZEpiR1pGSkJNenF1RXZEZ2RQd3VoU2tWWUhZT1JNQjY4?=
 =?utf-8?B?UE9rcXBqNi9XUXVROUZ0RVhYcTROWWp6QUIwSkkxQ3VNV1pSTkNvZGM4cG9Q?=
 =?utf-8?B?NWZqZW8vcTU0a283NVRvSGxlQktudWUrQjlrdEFBWFUxWk9hRmo2MVRrRzdr?=
 =?utf-8?B?TlRLemV5NURJb0dXYnlHanFYaE5sQ2JXdXB0eHlLQVVCQ0ZuVFZiemhnbE1v?=
 =?utf-8?B?cDBsOUgySjdIbGpONUJ1MXZFcWhCMFh3eUY4NDhBQzJBVnkraTQzb1FXWDVS?=
 =?utf-8?B?MXIySVpMWHJOTll4NTdmRHY3NDMzSlVuZnlpSzJ5YjVFZkZURG9hUWZXWjl0?=
 =?utf-8?B?dFczZjBZNDBxU3VVMjZNTjgrYkUzMGZ1VzNHdlpjUDAyMWhLMkFWR2RSNnVi?=
 =?utf-8?B?ZW54ejErMkdjVGd1aDVkajRyd2VWUllpUW9wQlZOZVJzMzlVZnZSVkRCUUtY?=
 =?utf-8?B?ZWdoZE9MV0dXcWFkMFQrREpFRStLcFhEcDNLRlk0cU56dTRqaFB0UTE2eElL?=
 =?utf-8?B?eU5tTDluNkwvOHE3MGpRblBFa2U4MW9EWkRSOVIwYVlvQi9SYzdCdm5nZjBS?=
 =?utf-8?B?UExncFVpbStRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2489.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHdWUlhaekI1bFFUZTRnTTVHbVVhTGhrNzBNblc4M1JKckR4UG1CYUx3ODhJ?=
 =?utf-8?B?QmIwaXN0aGlOaGdTMUlrWHB3SmtlQ2JHWnYvWGgxOGhqZmJ3QSs4UWJwOTFl?=
 =?utf-8?B?cDJuYXJ4WSthd003SjFORzlPYXp3T2U2L1poY0RRV2p4d0gya3JnMmc4Ry9Z?=
 =?utf-8?B?eUVaV0Iza3NDNlY5bnMxQ3JhelBmeVBOMGhOR3hHR3dvckdYQXBOZFRiVjA5?=
 =?utf-8?B?ME1lNjR1amREWXA3eUEvb1ZNN0hVbWhSUXpCVEdkUWN4dy9UMlgwU0tiaWZY?=
 =?utf-8?B?ZzFCZkNhYTRnM253RnI2M0JJSW5jVy9Nd2RSY1gweTlzUDNQK0JTdmhHNVE0?=
 =?utf-8?B?czQ5N1o2VElGTXQrNHpUL0JmOHArcnZRYjM4NklyWnp5UDJXMUFub0dSb0xm?=
 =?utf-8?B?TGVYakxDamxOV0pxUnlGek0zb2VzeGd6QUFCV3p0MmFzaS9nL0M3ZGRBNnU2?=
 =?utf-8?B?dFRUUHJsSk44azRFYnNYRTNRMVhybktWUlZCWm9kb3dkUDJGQjdnUnBtaXNF?=
 =?utf-8?B?aUdMMmE4ZjFOamJsdVM1WlZoTWRSRG5IUFRCV2JSRWJWOHh5eVdBQXBtL25w?=
 =?utf-8?B?bGViSkxuYnpXY0xjRkIyR3lseTRrSFdzZ1Iyd0p3UzdwZ3NEd0RUazBIV3Zx?=
 =?utf-8?B?YU5SdTlHZjNZWFVGcTZYcGk0aUNMNnl3NThxcjQ2cEhvRjVabHNkQ3VjOXJx?=
 =?utf-8?B?Q1FtRDdjYm5vNnZyRzFKNjlKV01IOVVqVjgvbk1uc2syK1U1MXhqclloMUpE?=
 =?utf-8?B?V0c4L2srR21ZeDJha3JUZi9rUjZTVFYyVndHQklaenBEMjBQYW5Da0dBWnhZ?=
 =?utf-8?B?VllUanREMk9Da25NMXBlL3c1L2w2UG1WMUliTzd4N2dXRHUzRW0zZURLLzZ2?=
 =?utf-8?B?V0tBSUJFM2RFRDh3YStRK1BnaFZORVFuVFlGKzRoWU9sZDliRkdYTGdjMVJu?=
 =?utf-8?B?MmZPWndSR3pnWmFQSWloMU9zbWFQbWV3amh4TUU1VGxPV3hqUm9IR3pWd1o2?=
 =?utf-8?B?NENpbDFiSUxCTDN5ak1FZGdFNjdjd2pTMnljZDdTd1l2blVmUTlwWVFsckhX?=
 =?utf-8?B?WkpPdkUxWXU2cTkyRHdOUkF1QU5CTDRjL3YwNmhCbVkyRlo2YUpEL3VFcXhK?=
 =?utf-8?B?dXlPKzJnYmNRdG50emdBclh6Zmxka0RpamVjYlRYa1NjRkFzNkowZ05ZY0xy?=
 =?utf-8?B?YUgxTEI0OGxUbnYreWVCWU43TW5peDFVMU1vbXdBb2Rpdjl5MjZUQVFoVm1U?=
 =?utf-8?B?b1dYNnFSaTdoVnNOc1MxNXJmK1ZUanU3TFVwNllTamt3SnNqRklkaWpZbTBN?=
 =?utf-8?B?bFNpbnh3aDRRamMvRTZKaHBSTDQ1MHBXcUNxcHJaZmRlOXRRcHNSczVYcWZM?=
 =?utf-8?B?U0ZyUTdleHl1TWRGay8zVXNjMjdIa0ZSWmN3akMwR3RkMjZmK0htK2xYRGxR?=
 =?utf-8?B?NG12dzcza2RrUU11Qk9rRWtkMTBWZ25GQXd2dkNzTmhVeDU0a1ZjM2RlTlUr?=
 =?utf-8?B?U2Y1VS8zN09RUTg1VFZpbE9oRjNUQU1hZ0tqWHJKSFhkdlozKzNVeFdwKzZv?=
 =?utf-8?B?WEZEL1pvSUZ6VE02a2RKcVB0NWZUVDluUFZpNlZZNHpDc2hPZWpnVndwTG11?=
 =?utf-8?B?Wkw2N20raUhHaGZxWERnWDVMZ050c1BlVUFrU3psWXhnRHBhZndGQmRpM0pr?=
 =?utf-8?B?WkZGUmF4YUo5aTMzRzJTU0FMSjYwRjR6Mklsd3N3dGxpazh0UlBBUE1UL1p2?=
 =?utf-8?B?dk9WZCtUb25rUWlRdlZ0UW9sUlhKQWVNc0xhQVg5cjFDUkZPbitlS3BZNDNO?=
 =?utf-8?B?Q043VXpLLzJZSG5EUzVvY05JN1NGRFkwanlMMFRQUEJtbUNMc2t1UWVMOGJX?=
 =?utf-8?B?MjBrdU9uejdmS1RXZ29kanBMc2dxbzJpdXEzazlmc0kvc3pWOGJHUEI0WHN5?=
 =?utf-8?B?TGQycWVJdU9VVzN1b3hMa3EvVUZsNmowZ0UrbUdoaThzdkxFUjlLT2NibnQ5?=
 =?utf-8?B?czk0dDlGVUNyRTNPMDVES3dhQzBKdkkvRWdzTnhNMWdaeU54aHhwbWYybDF1?=
 =?utf-8?B?bk1MU24rdVoxajVLVXFkbTFNdGl5ZmNLWjZxYmhndm9EdHNoRE1wTUlDQmxY?=
 =?utf-8?Q?w6sf1+PO/lnABAcPWX/t+F5HR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <64507E38EBF89B4180A8E465F831EA1B@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2489.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c2528442-2460-4d2a-ddaf-08dde610e0d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2025 08:57:12.2029 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Be9O8bAIMjpUDnDrol4JnTI5nsrDPXSIS3gCAjQFdfQK3BZHajaJ29GPPABqfiwF2JaCyk3y9bB0XI2G9PZAJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAP195MB1556
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

LS0tLS1CRUdJTiBQR1AgU0lHTkVEIE1FU1NBR0UtLS0tLQ0KSGFzaDogU0hBNTEyDQoNClJldmll
d2VkLWJ5OiBNYXJ0aW4gU2Nod2FuIDxtLnNjaHdhbkBwaHl0ZWMuZGU+DQoNCk9uIFRodSwgMjAy
NS0wOC0yOCBhdCAxMDoyMCArMDIwMCwgUHJpbW96IEZpc2VyIHdyb3RlOg0KPiBCeSBkZWZhdWx0
LCBsZXRzIGRpc2FibGUgY29uZmlndXJhdGlvbiBvcHRpb24gQ09ORklHX0FIQUJfQk9PVD15IG9u
DQo+IHRoZQ0KPiBwaHlDT1JFLWkuTVg5MyBiYXNlZCBib2FyZHMuIFRoaXMgb3B0aW9uIGlzIG9u
bHkgdXNlZCBpbiB0aGUNCj4gc2VjdXJlYm9vdA0KPiBjb250ZXh0IHdoaWNoIGlzIG5vdCBwcm92
aWRlZCBieSBkZWZhdWx0IGFueXdheS4gTGV0cyByZW1vdmUgaXQgZnJvbQ0KPiB0aGUNCj4gZGVm
Y29uZmlnIHRvIG5vdCBnaXZlIGZhbHNlIGltcHJlc3Npb25zIGl0IGlzIHN1cHBvcnRlZCBvdXQg
b2YgdGhlDQo+IGJveA0KPiBmb3IgdGhpcyBib2FyZC4NCj4gDQo+IE9uIHRoZSBvdGhlciBoYW5k
LCBpbiB0aGUgY29udGV4dCBvZiBQSFlURUMgc2VjdXJlYm9vdCwgdGhpcyBvcHRpb24NCj4gaXMN
Cj4gc2VsZWN0ZWQgYnkgdGhlIGRpc3RybyB3aGljaCBlbmFibGVzIENPTkZJR19BSEFCX0JPT1Qg
YW1vbmcgb3RoZXINCj4gc2VjdXJlDQo+IGJvb3QgcmVsYXRlZCBvcHRpb25zIGFuZCB0d2Vha3Mg
bmVlZGVkIHRvIHByb3Blcmx5IHN1cHBvcnQgaXQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQcmlt
b3ogRmlzZXIgPHByaW1vei5maXNlckBub3Jpay5jb20+DQo+IC0tLQ0KPiDCoGNvbmZpZ3MvaW14
OTMtcGh5Y29yZV9kZWZjb25maWcgfCAxIC0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlv
bigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2NvbmZpZ3MvaW14OTMtcGh5Y29yZV9kZWZjb25maWcg
Yi9jb25maWdzL2lteDkzLQ0KPiBwaHljb3JlX2RlZmNvbmZpZw0KPiBpbmRleCBhZjE0OTEyOGVk
NDEuLjUzY2QyOGRmY2JhNiAxMDA2NDQNCj4gLS0tIGEvY29uZmlncy9pbXg5My1waHljb3JlX2Rl
ZmNvbmZpZw0KPiArKysgYi9jb25maWdzL2lteDkzLXBoeWNvcmVfZGVmY29uZmlnDQo+IEBAIC0x
Myw3ICsxMyw2IEBAIENPTkZJR19FTlZfT0ZGU0VUPTB4NzAwMDAwDQo+IMKgQ09ORklHX0lNWF9D
T05GSUc9ImFyY2gvYXJtL21hY2gtaW14L2lteDkvaW14aW1hZ2UuY2ZnIg0KPiDCoENPTkZJR19E
TV9HUElPPXkNCj4gwqBDT05GSUdfREVGQVVMVF9ERVZJQ0VfVFJFRT0iZnJlZXNjYWxlL2lteDkz
LXBoeWJvYXJkLXNlZ2luIg0KPiAtQ09ORklHX0FIQUJfQk9PVD15DQo+IMKgQ09ORklHX1RBUkdF
VF9QSFlDT1JFX0lNWDkzPXkNCj4gwqBDT05GSUdfT0ZfTElCRkRUX09WRVJMQVk9eQ0KPiDCoENP
TkZJR19TWVNfTU9OSVRPUl9MRU49NTI0Mjg4DQoNCi0tLS0tQkVHSU4gUEdQIFNJR05BVFVSRS0t
LS0tDQoNCmlIVUVBUllLQUIwV0lRVGg5amM4TkJWS21NRzlneE5SM1lVNDUyZVRBUVVDYUxBWjVn
QUtDUkJSM1lVNDUyZVQNCkFUYS9BUUNDOUhTOXV0MHBSWkhRcC9pOGd4ZEZRY1U0d2xoSlFNQUcr
WGJBY3ZvOGpBRDlIN0pZYWZqNXlPMFENCmxvWUVCNHduZSt1a1Bsb0xEbjh3d0Q3ZkFqeURoUW89
DQo9UVJOaw0KLS0tLS1FTkQgUEdQIFNJR05BVFVSRS0tLS0tDQo=
