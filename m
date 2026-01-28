Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92DD7D3F083
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 16:56:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E80C984034;
	Wed, 28 Jan 2026 17:56:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="e5kEVjJp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B5598407D; Wed, 28 Jan 2026 17:56:16 +0100 (CET)
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c405::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A12228401A
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 17:56:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chiawei_wang@aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SvyJL3kbLcVhiRE9PZyr8GZpBW/6gwfd6xtn9Ch2HPCVpAnrz/vqAcC4tiZ4GX1U4ZyindOrahoZLavmU1R5n9rb1tpsmOMTW5JWhn5YjnHY9viO9mrld/XveP5kQLVn3wGYXCTW8FcjjBMmr3J9LBl5Rcpqs7NpmuaXcHB5Tv58UKf6nTic/WBVYFYJm/b1CDgNSJTpvnwYJq9i8UIfMqCtU27emYhJmiMbaAwYwB805FqVz2VEikHT719LRG0MToZEIWiXObTZKsWh3cTFs6h230+uAdgQBaixabnIy3jPElIaj+9Y8kfAcOPaAI+EdXSlk04XdUTbwidnu2WSCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIbWfyyPbZw/0OvTO83mOhPsHgjc89NpoU6glxWb+RE=;
 b=oGbBeRxI3VfIwMJBgThvqpGrSdZKYJFu8CB1mwXE+C6EjhqHUr+OGVbUqKSs2W2NDZRBb0Xf5Vi8t1ygEjjo+pb5mkjmwzOmf+Nz/C8W52rTcEjjxFa7y5L8c9t8bc7aW+3y081Tr3GBb4WR16cSLv54UQL6zBfFVHT9hHmQ9KS4vOmdNIRjIcvag4EE7QhnGTX3LaF+1Rwl2RMqePEYM4jnmbKFOl663Rb8k6NAzEWECpyQj0Z/ljuUnsVeFv90hte4t3dC/jCpDvbNOOZnYiOj8W2w5HArIB6vOc+9M9LkkwDijlfUezvD5Ibq4h50fUj8nNoQYGDsuc50sGEKWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIbWfyyPbZw/0OvTO83mOhPsHgjc89NpoU6glxWb+RE=;
 b=e5kEVjJp2CRjiNcDNOytTR4pqm5q9g1miK4Eafl63UIi8tLpNiD08lL6t1OBxVSQhXv/BPBeu+NYbhczYKYZBC5BZvOXcPwxKJb3FgUUjUnLS8WECZ+ktiuPqasbLqANSTa81O9yZCiPXJYXM94/55sz0SDBPcbPcKo4B/6+wP93reaNFcbccoKTjoc7ZRgEpJux6vJRRQayELFYWdllraNK+LIIxmCe8wlVwY2ktKNzhZVlnlwxl0EjvW9SNv4MmakP/OC2wqnelKEHK7I1/Bb/UhgOxVp6J96Bxv095MEetE7V9HryBRnW+SYqI0ah3UPYCD/Y/BrJ4HHj+NJBsw==
Received: from KL1PR0601MB5488.apcprd06.prod.outlook.com
 (2603:1096:820:9d::10) by TYZPR06MB6420.apcprd06.prod.outlook.com
 (2603:1096:400:45f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 16:56:07 +0000
Received: from KL1PR0601MB5488.apcprd06.prod.outlook.com
 ([fe80::d45a:6698:a285:990]) by KL1PR0601MB5488.apcprd06.prod.outlook.com
 ([fe80::d45a:6698:a285:990%5]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 16:56:07 +0000
From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Fabio Estevam
 <festevam@gmail.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Adam
 Ford <aford173@gmail.com>
Subject: RE: [PATCH] arm: Remove rel.dyn from SPL linker scripts
Thread-Topic: [PATCH] arm: Remove rel.dyn from SPL linker scripts
Thread-Index: AQHcj9RdTek7cySKk0yVdfVXHtDGerVms8jwgADx7gCAACbq8A==
Date: Wed, 28 Jan 2026 16:56:07 +0000
Message-ID: <KL1PR0601MB54888B50088BFBFA4364B37B9191A@KL1PR0601MB5488.apcprd06.prod.outlook.com>
References: <20260127213149.1338179-1-trini@konsulko.com>
 <KL1PR0601MB54882F38FB9675D83E1F1D129191A@KL1PR0601MB5488.apcprd06.prod.outlook.com>
 <20260128143044.GI3416603@bill-the-cat>
In-Reply-To: <20260128143044.GI3416603@bill-the-cat>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB5488:EE_|TYZPR06MB6420:EE_
x-ms-office365-filtering-correlation-id: dfb6b28a-7bb2-4686-0076-08de5e8e2181
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|10070799003|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?gCYnSvZLdZ7LdRSGXK40ERc91Im2LWRPKz37PfpnQTk787k1G6Mi6F8psNu0?=
 =?us-ascii?Q?nn3f4rmpriIkafG3s9gzY/wiJNphUavgnV1/us7dZEjShisBfj2WKPVy7Rev?=
 =?us-ascii?Q?Fvgr//X3tCk9dFIa03BiMNzd/bVoqVtgvCuiEa2KVDB3UkWwJCcG/5zvOw/b?=
 =?us-ascii?Q?XHl9DiEqhzYv2KVAA7n5fh46FIm0NZpbdQVnIAEt2aZNgOXumIW3pbttFKVr?=
 =?us-ascii?Q?4ZpHB/IkpUvszHUWo+H0kdo76k5BXd6QAdqJR3sbsogu4kOvFhYOVdPyLYTi?=
 =?us-ascii?Q?F0qEezMN6xf5Tx6tJ/eN/k+qVonv2L4Ve6LiNwl6LmQUGfSoKWXY1itUK2V2?=
 =?us-ascii?Q?0Sc3SkYeG5t2OdsyRfEIUjwe1w2QodNeWixVM8qU+Uvk4afA5xwBJTH04iXC?=
 =?us-ascii?Q?6+8ZnnBFymaUiKT+zXUqlXG6yk4m1Suw8uTw8JFbkvYUlbLankiz2qJK+70U?=
 =?us-ascii?Q?JKyhPpgM494ukDgaJGbTv3aSYupQrTmRTBjX6uq+sCGc21+A/bwcuqwswn+x?=
 =?us-ascii?Q?T5NTTVvpF/6/qq38bR3MOFOdBPTH/VNLR5o4hSbVH7WdRjEmMBhsGww2SiZ4?=
 =?us-ascii?Q?QPaInKrCziwWLRbV4nljtMLqWNd9LeS7jEpHZTrCci4K2tI4SvLIPv5B2+IE?=
 =?us-ascii?Q?0jAXCDmQDOwnGC5xc2tIpKArPAlfcCkM482avkAnWET4xyWUpUDBFTNfX6SF?=
 =?us-ascii?Q?ZYWVwR9UsfBysbWr0O7yQiAkfdavRe1EX+9E71vqduC6lYcvYS6UL6Vwwuyk?=
 =?us-ascii?Q?Z9qBiwwRLelOgiXcZPLeqRF/Iuz1CGBdeb1XozwDJdY20AfoQqKnD0iM9yXw?=
 =?us-ascii?Q?GGQ0OM/KSCArv2wfgQ/9xcc3BwdGUP2RzvMKxcW5+MGMeTdftBwsUwYVWqbX?=
 =?us-ascii?Q?xuGaYx6FyS8p/bLOe5q78VDMjUNl1HWTgK5m94yKffPkNYTM5ub8R7aq5lWA?=
 =?us-ascii?Q?xkVlLyp8t2ZJLlx0WqbmhMViyOee7bbAZduuZ7VTYnXTwEIIP20dtYmUGqVA?=
 =?us-ascii?Q?bK5MhZb4NT1lJeSxTKshgt6OmNtTRKCjMz4tgUdcj0eBZ3e2xDbSEYYsqGFB?=
 =?us-ascii?Q?QWJ43tNCaGDg/zLWcqGLVYCiSjuJ2KMRig2zZVVCecGQ9IocSDZfteicu/Rj?=
 =?us-ascii?Q?nzOPigqkZYKeIcoFQR9niFlKyG/dLrHMHblDm2pU2cNvHcjwMbSc2LgE5UOk?=
 =?us-ascii?Q?Me3DH2+L207cOPF/TZPe9yBt3780qGDanZ8EfL+S5Bj+xv9tJBHKbFulRYOk?=
 =?us-ascii?Q?UJsBDtFCoW5FySW9X8KVHPRdBY29zx4SgHOtjxPVXT6lmGSnQ92eq+Pnhze+?=
 =?us-ascii?Q?QZd/1sUtuimnk8IGsGAeVA5WZvMkYTPs7W069q6nw11ByTutElJPQ+WSaKSd?=
 =?us-ascii?Q?Shq2TEXS1yUn6dMjq5SpXcb23VOX1Ml+JkA/gN+J0zxzrmH8TxRFNPnJOQ6a?=
 =?us-ascii?Q?DE2q7yMd01NPlwYZx3JYiupp1spTeWDwLmOjoneS6ulfYqs8r/7mbHo0wIxB?=
 =?us-ascii?Q?gAwnDpDslLJqvmN/zKP+FSCKRPBCI+dPlKOYL+zvtHC7nHi07ymEO9G0mwo2?=
 =?us-ascii?Q?8+WKrbKoS0K9guqcSxdfX9C36sMFHl6r7r4dJHHw04H5fjG0oiXMrRjUGgnL?=
 =?us-ascii?Q?pagjbGm8Gi+F2ObnwJE7inY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR0601MB5488.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2yr3W/NS4kBFQ+ZJR3MOzJ3EyWsFCabKtaYKnwUJYV/m7IG95CWXOqVBMBZK?=
 =?us-ascii?Q?7gRqG5RtdoV3EbpetRoW6S0hcu19YBmJgaQEOt0cJW9PtAff9CQw4KyIn5mr?=
 =?us-ascii?Q?7wRLGL6vi5JC3CJL7oyOf4SzAF1m3YkrBZsqBmfNNEXVITT5ePTzB0NY3YcP?=
 =?us-ascii?Q?USsldu/mrRqq4A6Gqq0hN8Z3GkiCw+JFW3iX4rCUwauKe3MUpIaHbKYuI9Di?=
 =?us-ascii?Q?ocgTLJ5b1CATwo6bIyb3qQZdlbhmBLd+O4YkXVWj2AEizutKxEENgEUItW4P?=
 =?us-ascii?Q?oKUIVkncmp5AviPf/vJNSMstQe/zQjQzSVZUIq/yNMMWusHu8a2opvwotvtr?=
 =?us-ascii?Q?uKldvEPnrXBhjdrejPxZlXn+qaAeV6dsiViaA+rACph/O8ueaH5zutA87/sU?=
 =?us-ascii?Q?xrZ9nXhme7T9XKRvlF4BBLf+GnKQ7/FZOu5bWLoZqFX4dhyqC8AGrysdC2oW?=
 =?us-ascii?Q?ElteEa9FMUHyVhagx9k6VwAoCifMQ1tLhpFI/8YtOAFIatZjb5Da9U8JRzT8?=
 =?us-ascii?Q?/rkvC4tITFiX19053cyO/fMreEr+lDbqQPCC2x/oql3UiDyUJ+Cb8Ns2dXiP?=
 =?us-ascii?Q?xYUZx4IRa7IXFOdVY5UcdcYJXmQU1LzeQPwr2wxq4u5gHFxLobNKvKMw1StL?=
 =?us-ascii?Q?1sx8rpD0JB4KjnotU1VPyt5RlnTeBta1AvqlkT0uM5GovAkf+e6pT+r90CrJ?=
 =?us-ascii?Q?X2G8HA6GzchT2LPTQaPgrFIrYF6LzxOTdp7CYfIbO5nZ8qIrzG+0Fa+bS/RP?=
 =?us-ascii?Q?cPKHzaIvWJgMZe3b7BJ9L1rmwff2TQjMRVtci3jFuFiBicHadT2HaRHJCHLK?=
 =?us-ascii?Q?EonvJD1LrKQLNFl9MW7pV78NuvM94pqL5NzYfHcAvj0lsIgIrovsm0NYTMRk?=
 =?us-ascii?Q?D6UKbGrytY673OsTPIizQzGjR0spfedbOHgwD+J4ifVp/bcA2Gb/H+bDt/Db?=
 =?us-ascii?Q?CXtKdmi2H47Ar0tEXLv4IZNzAKzI5Nf67oCDO1PH2gqgorDTBPYDmlvsv6WG?=
 =?us-ascii?Q?8oMPpx10TLO1lAM4G8io88kkFNk5BRlqin6pkXqsbAB85m2X4mVdIuVJQIOl?=
 =?us-ascii?Q?pyRLBm3gxc008BbCqNulLVWSJRLoDX8+gQR9gpo3t47OP9KBBNMWIFCboB0Z?=
 =?us-ascii?Q?HNDEPbuWChSTWRz6+1lqMAAotASknM+9OwioTcyavLExExtjTp3C/s0YdvOz?=
 =?us-ascii?Q?SxZ7g8jJtVBjELc5EePKdrH/o/NJ6bYZuinvFTJRq21yakVf8CGOb1r4YWZR?=
 =?us-ascii?Q?w9DtvdczSba1hTP2OV5Bi7q/YWH2+LFd3iuZNf2Yhvo7HzShEUVS+lzzXgQm?=
 =?us-ascii?Q?asSJOR/YZc0gT+n+gHKoj9xBIdNG3XRsWTCI+orbHEWWB7vmZbfD8K1hm+0H?=
 =?us-ascii?Q?N1wLnOxa4QmfOatHlc+3DCRw9RR24sBWDZ3/C7yi3qM2Od3HaEGbABEelNBG?=
 =?us-ascii?Q?Ei2e2Nzq6+VJTW+IQq3HV2yL9VzKDaDy1YKAlre9XGkwEXA1PmypXeZl9xq/?=
 =?us-ascii?Q?Ayj23+WigjaQlOcHo47Z9BDamT7uQdD6UITlcRsCZeefC5GcAfdBgO6lHLyu?=
 =?us-ascii?Q?bBWZi2p+EExAN010ZZrci8zzzI5wfzueZsFXO0ajvlfcuVMB/l3IuHdfF3CJ?=
 =?us-ascii?Q?QrA+BosJjR8LOWdTNFzqZRaZ+VXDOvtR9w3etJSrUfqoqGJl3Cau/usTmhDD?=
 =?us-ascii?Q?nqdoqkvpzDjF3eMAD+wCAfHmnkyre32kfvrdZgelQP5V7fvcNeiKJbK1qytY?=
 =?us-ascii?Q?uW4EeiONLopx7A+O+f8SK7OnT7gAK0/mkffhOOPdiJK2CdlsBOli3IWbXBZE?=
x-ms-exchange-antispam-messagedata-1: WYgIh58FvtsDhw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5488.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfb6b28a-7bb2-4686-0076-08de5e8e2181
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2026 16:56:07.3377 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GVef4UxfDtSEOru4GG+WdtfDRJ10iIruowRIoXOHbB5yr1nuBnui1DTaZsQbWCsnWvb9ZMtcR4xVA6rA5roCwXlU3xtOT4pegvnFd3dRlU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6420
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
> Sent: Wednesday, January 28, 2026 10:31 PM
>=20
> On Wed, Jan 28, 2026 at 12:13:12AM +0000, ChiaWei Wang wrote:
> > > From: Tom Rini <trini@konsulko.com>
> > > Sent: Wednesday, January 28, 2026 5:32 AM
> > >
> > > As of v2026.01, no platforms contain any rel.dyn sections in their
> > > xPL phase images. Their inclusion in linker scripts initially was an
> > > oversight as part of taking the full U-Boot linker scripts and
> > > modifying them down. Then in commit
> > > 8b0ebe054bb3 ("arm: Update linker scripts to ensure appended device
> > > tree is
> > > aligned") these sections were used to force correct alignment for
> > > the device tree. This however, lead to a different problem.
> > >
> > > That problem is that when we do not have a separate BSS section in
> > > SPL we instead would overlay the BSS with the rel.dyn section, in
> > > the common linker script case. This in turn lead to creating an
> > > incorrectly sized BSS "pad" file sometimes (depending on arbitrary ch=
anges
> within the rest of the binary itself).
> > > This in turn lead to the dtb being in the wrong location in the
> > > binary and not found at run time.
> > >
> > > This commit fixes a few things:
> > > - Remove the rel.dyn section from all ARM SPL linker scripts.
> > > - In turn, this moves the dtb alignment statement in to another secti=
on.
> > > - For ast2600 which uses CONFIG_POSITION_INDEPENDENT we need to
> keep
> > > the
> > >   symbols however.
> > >
> > > Tested-by: Fabio Estevam <festevam@gmail.com>
> > > Reported-by: Fabio Estevam <festevam@gmail.com>
> > > Co-developed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > ---
> > > I sent this off-list to Fabio first to confirm it finally fixed thing=
s.
> > >
> > > Cc: "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>
> > > Cc: Adam Ford <aford173@gmail.com>
> > > ---
> > >  arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds      |  8 --------
> > >  arch/arm/cpu/u-boot-spl.lds                    | 13 ++-----------
> > >  arch/arm/mach-aspeed/ast2600/u-boot-spl.lds    | 16 +++++++---------
> > >  board/davinci/da8xxevm/u-boot-spl-da850evm.lds |  9 ++-------
> > >  4 files changed, 11 insertions(+), 35 deletions(-)
> > >
> > > diff --git a/arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds
> > > b/arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds
> > > index b4adae272eba..ac166d1d8526 100644
> > > --- a/arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds
> > > +++ b/arch/arm/cpu/arm926ejs/mxs/u-boot-spl.lds
> > > @@ -33,14 +33,6 @@ SECTIONS
> > >  		*(.data*)
> > >  	}
> > >
> > > -	. =3D ALIGN(4);
> > > -
> > > -	.rel.dyn : {
> > > -		__rel_dyn_start =3D .;
> > > -		*(.rel*)
> > > -		__rel_dyn_end =3D .;
> > > -	}
> > > -
> > >  	.bss : {
> > >  		. =3D ALIGN(4);
> > >  		__bss_start =3D .;
> > > diff --git a/arch/arm/cpu/u-boot-spl.lds
> > > b/arch/arm/cpu/u-boot-spl.lds index
> > > d780a5060774..c578c3ebf821 100644
> > > --- a/arch/arm/cpu/u-boot-spl.lds
> > > +++ b/arch/arm/cpu/u-boot-spl.lds
> > > @@ -41,23 +41,14 @@ SECTIONS
> > >  		__binman_sym_start =3D .;
> > >  		KEEP(*(SORT(.binman_sym*)));
> > >  		__binman_sym_end =3D .;
> > > -	}
> > > -
> > > -	. =3D ALIGN(4);
> > > -
> > > -	__image_copy_end =3D .;
> > > -
> > > -	.rel.dyn : {
> > > -		__rel_dyn_start =3D .;
> > > -		*(.rel*)
> > > -		__rel_dyn_end =3D .;
> > >  		. =3D ALIGN(8);
> > >  	}
> > >
> > > +	__image_copy_end =3D .;
> > >  	_image_binary_end =3D .;
> > >  	_end =3D .;
> > >
> > > -	.bss __rel_dyn_start (OVERLAY) : {
> > > +	.bss : {
> > >  		__bss_start =3D .;
> > >  		*(.bss*)
> > >  		 . =3D ALIGN(8);
> > > diff --git a/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds
> > > b/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds
> > > index c9664a6ce566..303ace2f61ca 100644
> > > --- a/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds
> > > +++ b/arch/arm/mach-aspeed/ast2600/u-boot-spl.lds
> > > @@ -49,19 +49,17 @@ SECTIONS
> > >  		__binman_sym_start =3D .;
> > >  		KEEP(*(SORT(.binman_sym*)));
> > >  		__binman_sym_end =3D .;
> > > +		. =3D ALIGN(8);
> > >  	} > .nor
> > >
> > > -	. =3D ALIGN(4);
> > > +	/*
> > > +	 * These platforms enable CONFIG_POSITION_INDEPENDENT and so
> need
> > > +	 * these names. The always however hold the same value.
> > > +	 */
> > > +	__rel_dyn_start =3D .;
> > > +	__rel_dyn_end =3D .;
> > >
> > >  	__image_copy_end =3D .;
> > > -
> > > -	.rel.dyn : {
> > > -		__rel_dyn_start =3D .;
> > > -		*(.rel*)
> > > -		__rel_dyn_end =3D .;
> > > -		. =3D ALIGN(8);
> > > -	} > .nor
> > > -
> > >  	_end =3D .;
> > >  	_image_binary_end =3D .;
> > >
> >
> > Thanks for the fix.
> > Aspeed enables PIE mainly for the U-Boot execution.
> > For SPL, the symbols should be fine to be the same.
> >
> > Reviewed-by: "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>
>=20
> Thanks. Does SPL really execute from address 0x0 on this platform? What
> confused me for a moment when looking in to this is that we have a non-ze=
ro
> CONFIG_TEXT_BASE but CONFIG_SPL_TEXT_BASE=3D0x0

Yes, SPL executes from address 0x0.
This is backed by the configurable bus address decoding.
Depending on the boot media, ROM will configure the bus setting so that 0x0=
 will be decoded to either SRAM or SPI NOR Flash for XIP.

Regards,
Chiawei
