Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D07EAD2FEFA
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 00:13:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45D508421D;
	Wed, 28 Jan 2026 01:13:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="ZKdDBkHx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AD6A8421E; Wed, 28 Jan 2026 01:13:20 +0100 (CET)
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c40f::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 296EB84164
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 01:13:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chiawei_wang@aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k7e1RjTbO31f9kmEHBwdjZtQscQ3LzPyMiFHHzVHCLrvuIZe2CKhypoG/maJoXXg7sNWf2z06oNUwr/il7jSDfKRS9FCbfsZFk43xmcuP0ryTB/hG7O4xQWMaiEustgBLQt38cDJ62uAelaMlJ1lUCZeLhceWKBleQgElGMCcxg+1xJ6t6QkBPojUM/ufX/kCZWDVg8qrh8txyAn9R93+cJGUDVU9DnpYQoXaSHJfb++W/IV0xHHhayE2524jCUTI8v4EwuDk+I1yw8ypnMG2I+70/g5LGPyiKjVLrUWPdfDrqygfOjczOPrF5cxSjMEwglAFEy4EDPOvY4Ctt7LoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rwe7JE9Em9wQhXlGdDWw5z5eUlLfeCxFrVUL0ROZfaQ=;
 b=u7zB6W/KI5g6amJf5rPTOubupwYq4AiqNbdAi4e8ogPGvc/1wfUeNt4GfUqxZQYe5QeAraYITx4ncR80qXWayCMZIPaGwcU/gACXAeS6E856kinlK/+zDFBk0O9/8sbySpQBBQhzyL5/MEt4kkT189LSU3Vs+6LbmSph/Ni5zLPPMFGRB4UyZsYcwQKh1U5qv8G/SvPf0SY9cPJXn28DxOzDp7nMIck8XvMrD11+qgQZMNhNzQaL0wTnX3Ewz0j4OMEorl2R9A9t8wH2awubtstUO6qHXBeVDdXtj2Wc0waZkukfLYeJ8PTzX0EF+md/wlY405TZ46lIwVAlECjV8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwe7JE9Em9wQhXlGdDWw5z5eUlLfeCxFrVUL0ROZfaQ=;
 b=ZKdDBkHxM9LGX4xTJb045GxuNd8XIJIxfog0meUiEzbWwzITCXK1NEHjTtvPdn5fmlAmy/GSVV/o2Xo/Bac5nylX1s5gbjsSG1M21F7eJkj/wqE/Yw4NNw6eKogbQqStHggE4OWAosZCl2upzMuG6vk9sAMH+SzdA8gNuF6S1/yaK8j/Vs0PCDzT60wVw8OxHgTZQU8GhwiPFsGniKYGLUGxIfY+7WcN+ATNSq3pAxIcMbn23+G+T+fB++jWY5MK3FahpNNrPbMqcpLEQ6d/cYnpXR8HXZpClllJzybB79zs7fsitEhFZVoP2oYvJI1AdVrygAKzb0htNavcu8KdcQ==
Received: from KL1PR0601MB5488.apcprd06.prod.outlook.com
 (2603:1096:820:9d::10) by SEYPR06MB5135.apcprd06.prod.outlook.com
 (2603:1096:101:5b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 00:13:13 +0000
Received: from KL1PR0601MB5488.apcprd06.prod.outlook.com
 ([fe80::d45a:6698:a285:990]) by KL1PR0601MB5488.apcprd06.prod.outlook.com
 ([fe80::d45a:6698:a285:990%5]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 00:13:12 +0000
From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
To: Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Fabio Estevam <festevam@gmail.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Adam Ford <aford173@gmail.com>
Subject: RE: [PATCH] arm: Remove rel.dyn from SPL linker scripts
Thread-Topic: [PATCH] arm: Remove rel.dyn from SPL linker scripts
Thread-Index: AQHcj9RdTek7cySKk0yVdfVXHtDGerVms8jw
Date: Wed, 28 Jan 2026 00:13:12 +0000
Message-ID: <KL1PR0601MB54882F38FB9675D83E1F1D129191A@KL1PR0601MB5488.apcprd06.prod.outlook.com>
References: <20260127213149.1338179-1-trini@konsulko.com>
In-Reply-To: <20260127213149.1338179-1-trini@konsulko.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB5488:EE_|SEYPR06MB5135:EE_
x-ms-office365-filtering-correlation-id: 28562c91-94e1-41e9-130d-08de5e0206b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?/Am6Wn5Oc1vz3BBFFaj79JWYoRQ8BLXvmXmNZmLl+WJr8w3j4s1I/KcvpoRA?=
 =?us-ascii?Q?YhnoKzwuCc3jjC3FWR0d5RaFiILgzfHgY4CWlqr0iTFiVOy7k6WJbs553h7c?=
 =?us-ascii?Q?ApxaPdtnEAhRgp+eXVNTy3fUywZf86B+SVQfERkIXTuDb/6vn6BAvpJasran?=
 =?us-ascii?Q?YlnzGkPQxCCG7qxnHOQcn8F+gxX8jyLvQOtDNZxUNi0ow4dCsekOUgOVYR8P?=
 =?us-ascii?Q?KqSceTqluZ13/Vtcp4fgoUEBaO8COV7fIuM582L9psU5Dm41DEOSm5M5tJda?=
 =?us-ascii?Q?smMtYzryQc7G52cXBuXDGTCf+ZTWPcb7VV7xdGFILXe/60JKn+BQMbauc/7A?=
 =?us-ascii?Q?MMf+/LPblKBQCnFb48MEmYyLoM/7okp37eWJlKAsCwRz2B0ggVMRkPDEQm21?=
 =?us-ascii?Q?3jw5CESaRf0wFrgqoIROPhr3XmvmLDrI/HYuTi7JWm73u80VeRbmhqJwdEh3?=
 =?us-ascii?Q?3hJmfFSDgIEzg1Zf1hQYzs5S+mP5PhVXIMddBN8+peJDS7YpXsCRg4Sse0QW?=
 =?us-ascii?Q?5muzSNqK8U8AYyOad+IFfVj5ZQsNvy8odwOIrrMSy8IXAATyLnrRLeNryW9H?=
 =?us-ascii?Q?zNVIAcXOJ0n2dQ4XKqMfWmk8I4ekyXR2BdVstcTjrSowvHQF+nf4xBwDkGql?=
 =?us-ascii?Q?NpiM7AQm7Gr5d7CkuwY6Kou5QrEWYyGM8ZVQnUSe9xS7oCXf5TxHPI8WfLFD?=
 =?us-ascii?Q?hqccJUv41P4CxiPBv4ltWmDocLQN1KHJxDnM9IU4GXq0uNKJNxkS4f3IDzTX?=
 =?us-ascii?Q?ACa4Bba3k9WNgpusTGNjguN0RO9T4XMhBIgepqIn8N9SL5zRTauzF3vEpR9Q?=
 =?us-ascii?Q?l7u+495SZj6MWrnddeWtHozKQgF88m1a2KV6palvM7pYSAm6WS9J1BJf/d7Z?=
 =?us-ascii?Q?Oklg+UKbdY7aPfuZ0Oc/s0V3M1yLGhlyCjlDEzfvczBK7yfJ/G7dnu+jjIf+?=
 =?us-ascii?Q?5a+NUFGh+L/SbZnuFs7z4wrs0uCo92UrmTBhyO2t9BRq0FZbHTa1ta6S+Pbn?=
 =?us-ascii?Q?GGuXGCpKk8A5zr9oT9EQnkjR4p2mIBAMLp4vGqe7T/pdoY8Iy7sxLr3RSlgW?=
 =?us-ascii?Q?uZ2Ti5zoG5MJshHYoU/uXEnRAxqBW5DYQm2QSdYoPowGUVb6UVlGR0vXp6N0?=
 =?us-ascii?Q?Ctj/95IuZYtL9gqo8cBkvWTzxAM4Dqk2QfrFEwctdQ+ElyC1chtfcNwx55dH?=
 =?us-ascii?Q?LZz47cU+zWfxBq9NyTwI2J7pQo67r44K1akz8yypFcBocp4C479N6qNMRUog?=
 =?us-ascii?Q?Sz5903GqA6Pndq5kRcayGXCGw7Ia3uN8f6FOmfJyyyeOafJPRWw3LS/gMB/o?=
 =?us-ascii?Q?cxBngkACILuoc8kajgEmNMNMbHcWhFASaFdRs60JiooQlOtoJaeuXx/8eH2t?=
 =?us-ascii?Q?GoTB3bhLUBOByferODbdQa56D2NWbtd9Rx6ukxKxGxJUiNnlcbO9qh27U/3m?=
 =?us-ascii?Q?J5UC9rChrR1LVtoEml2p+cWG1TVOnT0xFnT243zJkPMWBPVBquQaS4S9Dxp/?=
 =?us-ascii?Q?1h50PN2UeNZbQjVyUKjra7Y3jtJwE15KyoinhUK/gVqljYO74f4QzlEU/I7c?=
 =?us-ascii?Q?yekctdG8Fg5i4MHgJCSvShlGTZnaTEOZzOsBzhakFBT/i2/sMr8Y9Ot1IO8w?=
 =?us-ascii?Q?d0pG1RkT7H1lP7Qd5C3F4VA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR0601MB5488.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6wD8Yh69PiL/hgSGI+HIOhgKOLJrcqIhnbCce8VcTls3KGdngabRAmZ9xnfL?=
 =?us-ascii?Q?zFUWHpjAR6j561/QAUukalyXFj50m8fBxL0einMHB6m9Ih4shLmSHMLuQg1U?=
 =?us-ascii?Q?xaXrm7Eld6a3ICooknBWCa+rEiAKFxvPFuglXfdJD7deZ/z7zJMFSaupNviB?=
 =?us-ascii?Q?0Ma+ri9Awe2mHVLN0yqguZ0d5am0UO1sRFGOnE6XIrOXksrV8dEBuUbiytUd?=
 =?us-ascii?Q?3F7JwYnfTNSPisUAR0h5dwHPtaD4zdjMycHwhBfrE0LepX45EJ9uXvEFoiQZ?=
 =?us-ascii?Q?ta0im2t0msgQPEfGSUpugWGPs3T2DCixkYj1yriNMLNmupI2JKmfkaWWqOA3?=
 =?us-ascii?Q?eZ2Bll6SaqRypMURLmxCjFpbHGF8n+ETuiSmbVsN0Zs92l6WqsoNUVgIfiU9?=
 =?us-ascii?Q?lOaUhgC51lpjv7Fw/DMjJhjgT2prDsolYFnnV3KGyyxl5XFQgC2UNgguSIjd?=
 =?us-ascii?Q?6mYa24QbqEnC/KqqBwA5pzcOfvUsscEPCC83aKkP1jr/nF2Q5N0uIdjWika2?=
 =?us-ascii?Q?XXMDkWFupZdh4qQWF3Eo9eJM66FgrxnAV6f4PD9cZw2GwMdwxAT9/eptCS5q?=
 =?us-ascii?Q?JTl19zeC5GNGR/CVctnMDO5gEBeiFKNh9cGNn7D8DxcwHqC4i6jirTB0lBqH?=
 =?us-ascii?Q?RVwE1IWwRR7HIkrdk9mEpGxjNTpjbgPDUHAfpY92D2mZ4XcOsuBOWlIAdCgr?=
 =?us-ascii?Q?z+aqXJimH3YXBhg5Z2zIHC2l0G585ep6blp70oKp8jle3ou2ZFo5gF8s/F5C?=
 =?us-ascii?Q?pWoAxiFqD9M29TEXFCfLMLWyOkIZdSXxGAIelZ+dcixwZRErZsTFPVAoR9oc?=
 =?us-ascii?Q?s5sQMgEPURYOag/9mRn3sFS8FenBJQiG2jarj1ds5lXGvSXPF2zYwjPfypFU?=
 =?us-ascii?Q?9MWMW/hG3MQV3SXvEDCqnkKOmUXFuCmx623bTnR56R4IMMOOV+9vU5OslpJE?=
 =?us-ascii?Q?c/74SmpHOqgi4EcxBy7ju7sefX4vjm1Ryi0TLG+aE0NZDv8EIB4erqtLxswO?=
 =?us-ascii?Q?05BPCvDaLPSxGZz7G+PCnpu1/t1+Us8hwZlXonOiKsvGtX8Y07LToQfx7d4j?=
 =?us-ascii?Q?FG03omRgo+8UFE5xackOFdDh6zm3m2RP9Kkn5DTCOkGhgZKq78RaphhjXmMq?=
 =?us-ascii?Q?rP7AV0prhx951yADhDQbCgrIfabBYClHEAXxbCYN9Y78FAdW7hBh87N+KVFh?=
 =?us-ascii?Q?IQ7g2KcTD45vjCJb2gTOuAjsnKQxUO/wb/HDp4hDVdhHXb1uXRvOfCfYiguD?=
 =?us-ascii?Q?gydLluJZ+Z+LBBwyZXVXmZ98uz71NcplO168tvG83XVvrrVp/U9E5NZpj0eH?=
 =?us-ascii?Q?69XMoDY+RiU+x3DdsBHznDGiVyRBI38zs97IQvtD3oS5KoIwbLPGX5/h13IS?=
 =?us-ascii?Q?jmPV1DZ6Jd4aCwWGCEC1l/R15DQAkfzJQSe3eikD43UuV0ro+VRfCtT1M8vI?=
 =?us-ascii?Q?VljR8x2phEC1F2jO1SKZpEzQtax34kFq0E+FqmLDt3sbmRzDRVwxeJcy5kp3?=
 =?us-ascii?Q?RwBs42Oq5v5DnCo8E//bFtEAZGauCvi6+ss/OZe2QCuZoEl0rDd6ZE/5uxQO?=
 =?us-ascii?Q?T79QR/VbGjXmPTP6kIVjrb7GLI7Jf2zFzA5rVWNwUZ9LBf8ilhtz2ukm04xP?=
 =?us-ascii?Q?tDe/msbYBHItDy66lDQxHye/bfgG4U3tBcDC1TBSnumWUVpbjlTbsM80f3Mv?=
 =?us-ascii?Q?fxFkcwSVGzkp85mon2PqbGd0Ek3lt8D1qyLWM1yafv9/d9MykrPbQxKuGmOU?=
 =?us-ascii?Q?+LrrQJaUVQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5488.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28562c91-94e1-41e9-130d-08de5e0206b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2026 00:13:12.8394 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TxPPxGgL9TryTDTPXMy5Z86MVJIX6roMuRC22HcbZC71s9cfpYXWPrMih10+vcwAIqOpkzdAJ4+ZjVNLHbcjr/MsfiDkafuRA9295a6v41Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5135
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

> From: Tom Rini <trini@konsulko.com>
> Sent: Wednesday, January 28, 2026 5:32 AM
>=20
> As of v2026.01, no platforms contain any rel.dyn sections in their xPL ph=
ase
> images. Their inclusion in linker scripts initially was an oversight as p=
art of
> taking the full U-Boot linker scripts and modifying them down. Then in co=
mmit
> 8b0ebe054bb3 ("arm: Update linker scripts to ensure appended device tree =
is
> aligned") these sections were used to force correct alignment for the dev=
ice
> tree. This however, lead to a different problem.
>=20
> That problem is that when we do not have a separate BSS section in SPL we
> instead would overlay the BSS with the rel.dyn section, in the common lin=
ker
> script case. This in turn lead to creating an incorrectly sized BSS "pad"=
 file
> sometimes (depending on arbitrary changes within the rest of the binary i=
tself).
> This in turn lead to the dtb being in the wrong location in the binary an=
d not
> found at run time.
>=20
> This commit fixes a few things:
> - Remove the rel.dyn section from all ARM SPL linker scripts.
> - In turn, this moves the dtb alignment statement in to another section.
> - For ast2600 which uses CONFIG_POSITION_INDEPENDENT we need to keep
> the
>   symbols however.
>=20
> Tested-by: Fabio Estevam <festevam@gmail.com>
> Reported-by: Fabio Estevam <festevam@gmail.com>
> Co-developed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> I sent this off-list to Fabio first to confirm it finally fixed things.
>=20
> Cc: "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>
> Cc: Adam Ford <aford173@gmail.com>
> ---
>  arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds      |  8 --------
>  arch/arm/cpu/u-boot-spl.lds                    | 13 ++-----------
>  arch/arm/mach-aspeed/ast2600/u-boot-spl.lds    | 16 +++++++---------
>  board/davinci/da8xxevm/u-boot-spl-da850evm.lds |  9 ++-------
>  4 files changed, 11 insertions(+), 35 deletions(-)
>=20
> diff --git a/arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds
> b/arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds
> index b4adae272eba..ac166d1d8526 100644
> --- a/arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds
> +++ b/arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds
> @@ -33,14 +33,6 @@ SECTIONS
>  		*(.data*)
>  	}
>=20
> -	. =3D ALIGN(4);
> -
> -	.rel.dyn : {
> -		__rel_dyn_start =3D .;
> -		*(.rel*)
> -		__rel_dyn_end =3D .;
> -	}
> -
>  	.bss : {
>  		. =3D ALIGN(4);
>  		__bss_start =3D .;
> diff --git a/arch/arm/cpu/u-boot-spl.lds b/arch/arm/cpu/u-boot-spl.lds in=
dex
> d780a5060774..c578c3ebf821 100644
> --- a/arch/arm/cpu/u-boot-spl.lds
> +++ b/arch/arm/cpu/u-boot-spl.lds
> @@ -41,23 +41,14 @@ SECTIONS
>  		__binman_sym_start =3D .;
>  		KEEP(*(SORT(.binman_sym*)));
>  		__binman_sym_end =3D .;
> -	}
> -
> -	. =3D ALIGN(4);
> -
> -	__image_copy_end =3D .;
> -
> -	.rel.dyn : {
> -		__rel_dyn_start =3D .;
> -		*(.rel*)
> -		__rel_dyn_end =3D .;
>  		. =3D ALIGN(8);
>  	}
>=20
> +	__image_copy_end =3D .;
>  	_image_binary_end =3D .;
>  	_end =3D .;
>=20
> -	.bss __rel_dyn_start (OVERLAY) : {
> +	.bss : {
>  		__bss_start =3D .;
>  		*(.bss*)
>  		 . =3D ALIGN(8);
> diff --git a/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds
> b/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds
> index c9664a6ce566..303ace2f61ca 100644
> --- a/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds
> +++ b/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds
> @@ -49,19 +49,17 @@ SECTIONS
>  		__binman_sym_start =3D .;
>  		KEEP(*(SORT(.binman_sym*)));
>  		__binman_sym_end =3D .;
> +		. =3D ALIGN(8);
>  	} > .nor
>=20
> -	. =3D ALIGN(4);
> +	/*
> +	 * These platforms enable CONFIG_POSITION_INDEPENDENT and so need
> +	 * these names. The always however hold the same value.
> +	 */
> +	__rel_dyn_start =3D .;
> +	__rel_dyn_end =3D .;
>=20
>  	__image_copy_end =3D .;
> -
> -	.rel.dyn : {
> -		__rel_dyn_start =3D .;
> -		*(.rel*)
> -		__rel_dyn_end =3D .;
> -		. =3D ALIGN(8);
> -	} > .nor
> -
>  	_end =3D .;
>  	_image_binary_end =3D .;
>=20

Thanks for the fix.
Aspeed enables PIE mainly for the U-Boot execution.
For SPL, the symbols should be fine to be the same.

Reviewed-by: "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>
