Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2350C28B2F
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 05:03:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB1CC8141E;
	Tue, 18 Mar 2025 06:02:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="XxoKqWOV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AB3980F70; Tue, 18 Mar 2025 04:11:55 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E14D80077
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 04:11:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/hX7yLQmnHCot7T1WNqfjVF+K1QZL4kyorvYHpnzEWFDUVR2EwOcZXxH/MK4g/76QZNNJh4wxTYfIjDxWZUNg7lRWCGNQ4A8ts0ydyp5j0mRL9YLyRS2XDOp5Jq7nPfP5zrQhPETmq6GO/+IFrN2NoV4PQHqJocIZda409limhTQ8+Sm4G19wFOT9+bp6bmTHBYrge2RzcR+0/UFMiswLHupLQ6cRjJ2qm4r/yY0rO7IbmpoAj3F280U/OrsCEJzieZEYBGIe8DipaJjZc/uJIrjAytHQ1Wa/HO7qT7X3e9v7X6pype1LFW0wi892nU6R9//NtgbuIEtbEgGit5xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XqECKfVmSGL2rtcy42XE4Ofgm4J2rTw409kT1xTtXI=;
 b=vqx9sXz0dZ69avAmqVkTgRDOM5/vDcG5/gI5K6KiiGlD6PsOcvQW4diL+7wSk9Dz43rL7l7jDZMHtfZ2B3zNbn8NaDQtEbtpz/yx1vy4PLWmwNzIrHR39oMLILa/L80y7IQZiNYaTbfojeueMNmswTffjusdynek6EgwoTSLsPD9TcoCw307GLOeL5JwzFOmmrrki//P3R3rGN0QhUsKN+AGvSKqJGlZYGqsJKYmBzsqDgn0ZDM/WZmY344e3NHuUn5nusOwVWlZU+b4aEj7U9jDUw54KGlWYI+pVu3UsDyX3QE31glr3VcO8II917kK8JUMZP2iBkasWfN/J2Vf1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XqECKfVmSGL2rtcy42XE4Ofgm4J2rTw409kT1xTtXI=;
 b=XxoKqWOVfif1ZWsdWVVdD+WVb9XoxL6s/nK/6CGQ35EAJv7wMmolQT4BFBMcbN+/ElALXQjNwDBeFPbCSYrTC9N0rwLke3b0nfwZmyzRoC370zFO3YGof7xekrR7zOb0mL4EPFpx67nfqK7lg9zp0L9MNzF8QMrI/0qyXkxDkGDWDtgF9VeTCU4YTfsKIaRfJKFLTkLY5NMERzNwoDYoU8fXL1qpV2Wtq+RSMntlYCmJSc6UGdNXRuaDHcE4xSt6RvfmydFinxbCDFWKPiQTbU+67GDTKFbHkNRWU+4aDBd/TkbL4+Xyz0orOUC/jQSoG+ojsmwy/lkmUIt/NSxyeA==
Received: from SN6PR03MB3583.namprd03.prod.outlook.com (2603:10b6:805:47::26)
 by MN2PR03MB5040.namprd03.prod.outlook.com (2603:10b6:208:1a2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 03:11:44 +0000
Received: from SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad]) by SN6PR03MB3583.namprd03.prod.outlook.com
 ([fe80::263a:babf:7ed2:3fad%3]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 03:11:44 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: RE: [PATCH] ARM: socfpga: Drop incorrect imply
 SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION*
Thread-Topic: [PATCH] ARM: socfpga: Drop incorrect imply
 SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION*
Thread-Index: AQHblUmm6b252GIHgkaUBZm/cb9U6LN4OuZQ
Date: Tue, 18 Mar 2025 03:11:44 +0000
Message-ID: <SN6PR03MB35836ECB9BAFF92F78B520FEA7DE2@SN6PR03MB3583.namprd03.prod.outlook.com>
References: <20250315012900.399381-1-trini@konsulko.com>
In-Reply-To: <20250315012900.399381-1-trini@konsulko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR03MB3583:EE_|MN2PR03MB5040:EE_
x-ms-office365-filtering-correlation-id: d2d6cc68-261a-4684-2de4-08dd65ca9d05
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?+ehBwkASZmZhER+4GS46uX/1ataayS0gZZZwEe7152DnmQ5nU36+IeQcqu4Y?=
 =?us-ascii?Q?kX2NeOMXPLDj4cmNS/9wQHZUPeTCgwMNZ/RQPu0zFJK/zKGZ+zkUoMbh2kRw?=
 =?us-ascii?Q?Grl38fZ1CFIasQCGa1FA9gzFCsHTTWPdPwKbOHV6roj5aPBb59MHfsr9eqGO?=
 =?us-ascii?Q?gqmYif+I9t5dSz2on2w8nn905S4VSwnwkxdJyhoyq0R3no/KiA34MLTAv+Je?=
 =?us-ascii?Q?GBopuhP6QX75hA1nJTNYROhwV+08WAtxHahX/ysXsbGanji4dMxsoOFIuKlg?=
 =?us-ascii?Q?nK6H3jHFW9v9+1w7ng1vfIQG6ViDQnGhmSyK3FT6rb5gRlAZB4+9M34uT2bo?=
 =?us-ascii?Q?mWUqDAu5kxYYjk27A+sIq6Yqu5xIpYJQ+rqrO6iekzRbF9e+48ntE07WssGs?=
 =?us-ascii?Q?jMyz2K3ssXQ9x/pmta+TZl92wCnSSZObJ+Dny0x51XvVVWDUSMY+qoZG+En3?=
 =?us-ascii?Q?sfPxOqT2vrgIDV4jLi2oJRi3czD23SUIUl+wQubw7OjbTNtt9kATcrWQPhcK?=
 =?us-ascii?Q?Lo+FAq1Wk2cDCCIVZhM3wySg65UZPO+C6kRAG2UldSYdK2hN8aQEvot4ar1S?=
 =?us-ascii?Q?eCV61QkWaTfxVI5PPpNlAXhO3EtMy6da7ALvmOqsxzLtWoNaJyhAHIyHIl4c?=
 =?us-ascii?Q?1mAtlGWT0LioJ0J+B8arHjgc5FUotL0o3ms2wZMDTBczXYPacvmPGHufqE2A?=
 =?us-ascii?Q?39/XyTsK82rVKg93WBV9VgtXwJoLe0ksOrP/WXo0HWI9ueejeXWl4LO+VmuW?=
 =?us-ascii?Q?g6//0G8Zjfk35mHE+ZxiKmFPV5wEUlERlPUgXkcFwKJr2mA28dUqcyoJ4y7c?=
 =?us-ascii?Q?m+BPiLrKLhKlLR68/3jDjMigFakafHryzRmFhPHUl07Fdp6R8u21APvDQhL5?=
 =?us-ascii?Q?A1X3lKc5s+T+6f5cNnfnoaOtXhzYDQgqQK6cvgX+QhXjDyw+bUMPirAtakvW?=
 =?us-ascii?Q?ZdqmE2rKfwuE9aiT/sHg45HfGD2me5Vofd8VDAFuOS12UP+V7RQT4Xptl8cf?=
 =?us-ascii?Q?tjrwE7ndVr7CgZXbSDwOtCpDuGeM6ZAUXL1IALoiUqVK1rSyp9mhEg01kjIQ?=
 =?us-ascii?Q?1+AzRwiFaawq9zmbxz6UxPAxlMmpwpDCarAeM3AXjxC9OJtU8lNCj7dbkL5/?=
 =?us-ascii?Q?1e1Iiyyrdsg9El1Bqk+JovRAlI9IUQKzRDu9DycvSfl2IbkF7OZkCUsZb6ia?=
 =?us-ascii?Q?9aNfaGQ/Hc2xhtZB92tNJjaHsUfvQSaSuxU7KmaQH3vMtk0/Fm/W2KwERl9d?=
 =?us-ascii?Q?fwqa6mciBOBCgNEk/IbPw7aiFL1xGSBWW1EzxMjoUKwqwEgBi6C6DVIE+Arh?=
 =?us-ascii?Q?Aj/40hTPE+AxDbPfIMfRDQTvCFpaKy84H2f82czDVufx37rBU1cUZJoebwLb?=
 =?us-ascii?Q?SKafxV882AqLyhaBmoyMMoHAG0TcugoQ8jcpVki4PPGc8FFAj1MlM11Cy6uk?=
 =?us-ascii?Q?NNUb2rSw3yT96a8s+ncO/n8/7p3pOF0Y?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB3583.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ij5NHTY8Y25xL8Ffn+w8UPKlYChTeOWwjVPc5fBOCfyW56pAiSyILWzBEyIR?=
 =?us-ascii?Q?uoYXKfhFjRS4/Jq3LUWo9WKqcMN4nhJJxjKDGtBFlBZ8Cda9eecI1gJ0aonG?=
 =?us-ascii?Q?48hWmIpGbKNlxkE4ObOoLQkajJatAWC1D42wo0dNq2lt0wHauwuyuidLAtX1?=
 =?us-ascii?Q?NUHcQBlDzw0N1+7iDfzsl+Bf6V6rK++UqFMqF0+2lBGX9EWe9Fe7RqGyJo0Q?=
 =?us-ascii?Q?X7+ThfsEWoDYjKNhfdHldXFYeH5yPjUUmVzDSkaoTjx6zAJSjDz4HDqRaiE4?=
 =?us-ascii?Q?4e06N+F0EXGjPgiLhJUXukwebZGqnpod1wLzFm+VfhMP8l5j91k1gEDZKeSi?=
 =?us-ascii?Q?dn400yKl7e6CbODBZKc7TUO0wz5XWXINRcPGKjmwmAx4mz8Bj4dIV5Bm9QA8?=
 =?us-ascii?Q?OHzIgsT1lxVA1OZWBuvePeiI8ITawk5uF3+aBzXC4bUSEoYv47RK6sJy+7CB?=
 =?us-ascii?Q?lnLQA865uk3tuZ12gGzoWlz4g+rSYFmjrBFiITeGMVsR0d9VFE02zIylMu6t?=
 =?us-ascii?Q?Xb7IYxM7EyB9wy5+mZAP8gMWc1qJaEzcbrhEbLeumUQpUTykvbsqRv1Sh73q?=
 =?us-ascii?Q?awTHlMMQx1NiBMctMHQdscmsRxzIADk9rwu5pnSMt6IfOHA8bkYDV6QaO6mW?=
 =?us-ascii?Q?lJnFypZc4SgwZCegaxho8dW1ro7KyV4yQ67ovKXXQRNff/fvMB7X6EafmEG1?=
 =?us-ascii?Q?cNFWPuqvlqM2ktHezQI3l6uhmyD6bDuuTTn5Kv9i+5VqRKH7Kff9yPSyj3ty?=
 =?us-ascii?Q?Ads6SIOb8s4wVsOXcNAcKepTnRCHqeQBu/px7sfvwu4hWvbsLw/PKGT0xIGT?=
 =?us-ascii?Q?du6djYUKbaOaToGVNy89j0R/c3ykd3VjxwSMsQosWSyHVTV9pyLk4qXKgbQT?=
 =?us-ascii?Q?YfezPWytvaKsyMS+FFW1NCuWOvMz4+mOmalWsm3hDXshNAfheD7yZ7Toutib?=
 =?us-ascii?Q?1W9v04+VZSZXjdRuyO+sjw1f2jfYwODX32u8uu2hgt+/a1fK7xzfffKCACnQ?=
 =?us-ascii?Q?1bmNTkH6PE21kG9oWUEEIwo2tZC/fCqVIJlXZsRIRyX+FQ9PvPiwU94NnBmc?=
 =?us-ascii?Q?cVJUmH96iCaFjEL8epGy1Z3Ka/Fy1h9ZQR910pzUoQG3f3qv//rCytPSFT8B?=
 =?us-ascii?Q?kUGrvDfyy0+1dMTFXF8CMRSgmU0FXzJC3oTgscAjATa4yh54xBDy4toGab03?=
 =?us-ascii?Q?WA7eUper/BygjQP9COTlRCAuUYrwGSRvViSDMYQdR14C5gKG1FKCHl1BOLUI?=
 =?us-ascii?Q?nkLEekkjhJwCFf42CGzwQTeodRCx4y4RLMtOgL/YE6WodVV+3sm4RZmS61rq?=
 =?us-ascii?Q?Ws6bxDM4FxAHSyf/tY86rwOZ8jOWQKCChAoZOkUALXE+h9kT3ep/3JtPvn8J?=
 =?us-ascii?Q?Foy0vsJuQXmt0JPc4v8QFHC6Edpi2UQ0qCvXUIqhYy4pPyqThoOEiQgfRVLw?=
 =?us-ascii?Q?NI0Iu2BoesDN0ptGat4j3HylWG5mtX8tF69QYBMHO8fOTNrBz9AcZEPacW/y?=
 =?us-ascii?Q?ENMfWpFPkfn2CCY0WAOgWk7/KoWEe+Eshya9UXVnXAIOkLbU6W+sIvYUw8QZ?=
 =?us-ascii?Q?VQNV9z8DUVwqUZv1s67coXYWVaB8e2Pk3TPJ4LR3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB3583.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d6cc68-261a-4684-2de4-08dd65ca9d05
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 03:11:44.8106 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZbCdz35cpRM3o+GMOire7NpcnIk9+BMefokk+8MFunOiD6/HC5sMWmYvLN6f4+aNZUJkeFfsPj9TYOOOBaDvECbUzOSPQJpk5FshvXvjmIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5040
X-Mailman-Approved-At: Tue, 18 Mar 2025 06:02:14 +0100
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

Hi Tony,

> -----Original Message-----
> From: Tom Rini <trini@konsulko.com>
> Sent: Saturday, March 15, 2025 9:29 AM
> To: u-boot@lists.denx.de
> Cc: Chee, Tien Fong <tien.fong.chee@altera.com>
> Subject: [PATCH] ARM: socfpga: Drop incorrect imply
> SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION*
>=20
> The use of both "imply
> SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION" and "imply
> SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE" here is wrong
> as those are both part of the same choice statement. Furthermore you
> cannot select/imply something from a choice statement, it must be a
> "default ...
> if ..." construct within the choice statement in question.

I think the imply here which allows for overwritten in defconfig. To suppor=
t the "default....if...", new config for platform specific in Kconfig is re=
quired. Is there any other approach better to support this?

So latter approach is preferred?

>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Tien Fong Chee <tien.fong.chee@altera.com>
> ---
>  arch/arm/Kconfig | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig index
> cf08fe63f1e7..071fbf1fb202 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1163,8 +1163,6 @@ config ARCH_SOCFPGA
>  	imply SPL_DM_SPI_FLASH
>  	imply SPL_LIBDISK_SUPPORT
>  	imply SPL_MMC
> -	imply SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
> -	imply SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE
>  	imply SPL_SPI_FLASH_SUPPORT
>  	imply SPL_SPI
>  	imply L2X0_CACHE
> --
> 2.43.0

Best regards
Tien Fong

