Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A05E7C02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 02:38:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C161E80312;
	Fri, 17 Jan 2025 03:38:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Gz4KRczi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76DB68069D; Fri, 17 Jan 2025 03:38:51 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53A2B801B0
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 03:38:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dEp6xGBMSIbYrcxOHClYB2LMIRnCZCKfK9XoZysLudsoEwwMzAUr0HmMPgamfqiE97K3kwXONxpJkuw0eqoCoCCTpTQSENN5U+8KW7wcL+b3kmmcrhX9KoWKDelmpcPiYZTN7KfRRQv8gsQdGUWYOTqM+SSw6XLpbDgjfjtgJTPWUqC1pXPzwr0SrYUerypTl6NKaDhqV0uzHdsKmr9dEwgM5UVHnAZRyvfFSIi6rC6f8zaZAlMQnNVBHv7NbX2lnIrQQiw/CtGU0nQYhPnJmUshSzYcEbq/qm9wOFQxiN87eoGwFMi/gGoAF+yL23+OpA0lcadwdYy9KnTw/lpi1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJZoTcjcTRc2TtqR8hKO4JnD1sdrHDZ0JY5PRHAjDuo=;
 b=Xsk38qyreFXjGqI53W+is1ZTg+5iTEtk4qbucxLS/w6OPP0fmO0G3TWSeCIa3iFam/tWPyGVYw0aqKxiM3/8uO+j5/DS2mFzay5/QemA3+PSFzQNH0GuofglIps5aDi0NGhuNdpx7UT+PR7rNHk2ceFMlrAkInCpBxvoMF+qtpuZyqKjdqQQDOMZ0agG6Mjmtjce4eBA1tnXF/1To0sQW4rvmFoay5FS+ht20agteLywiM1xWuGfpBTKmFUXBj1ElcmyipZEqies+Ed6wiVrdhi0HCC8sl1qDTsoZKB9+w3b7T+6nJDe1A+24t73sxWTuzbiU7uwLn1BApPNFzrFag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJZoTcjcTRc2TtqR8hKO4JnD1sdrHDZ0JY5PRHAjDuo=;
 b=Gz4KRczi4A2DGYSAYCAKZYsMRI6b5Ziw2hm8F3fu2h45uQuU3qUNaqkCUUOFzWl+XK6UQJqldtPAWMZfASrvloVH31LhPtdMt6Yonf0nPYWA2CMMEOYNv8b8rMJHC9cfIuSCRh7Cw+Ye2lL5MG+wnDS/ID85zuTt+rQlLH1zOwRPtX6kxTwCilk1erN1UVD5WAb1li4gyF3KW4Y849LNMbPJvMEW3ajfPJZ1OlZe3gJLQnC6sCgm1gPGJCGqDACgHr4gvecWD3BJwnzvVQbNgS/D0J4u6bC5L2sn+7oQzH5xxpsgpawTQq3RPghI7afKqiRu2YXQjgQ4ihSXk8R9Yw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM8PR04MB7859.eurprd04.prod.outlook.com (2603:10a6:20b:24c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 02:38:48 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 02:38:47 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, "trini@konsulko.com"
 <trini@konsulko.com>
CC: dl-uboot-imx <uboot-imx@nxp.com>, "y.moog@phytec.de" <y.moog@phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "marex@denx.de"
 <marex@denx.de>, "tharvey@gateworks.com" <tharvey@gateworks.com>, Fabio
 Estevam <festevam@denx.de>
Subject: RE: [PATCH v2] imx8m: Guard binman nodes with CONFIG_OPTEE 
Thread-Topic: [PATCH v2] imx8m: Guard binman nodes with CONFIG_OPTEE 
Thread-Index: AQHbaIM1k3a8gLqXdUCT+B/wTpUuULMaQK0Q
Date: Fri, 17 Jan 2025 02:38:47 +0000
Message-ID: <PAXPR04MB84597F2ED81D0DE0C29E381D881B2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250117015642.2373824-1-festevam@gmail.com>
In-Reply-To: <20250117015642.2373824-1-festevam@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AM8PR04MB7859:EE_
x-ms-office365-filtering-correlation-id: b2c5e1b8-15aa-4bb9-0b74-08dd36a011ba
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?3KWXuP2p1P6tMLfvenuR7E9DWJOq4PJMQ1J9in79hhPDdWGQ1al3vcucPFWS?=
 =?us-ascii?Q?hvqf/hZyoOceOv0Ai/ZXo/4Sm+MmyzGsj1s0gIsFJja9NKYmq0WC9hM8+mG7?=
 =?us-ascii?Q?W/1qoDILypG/yfoHCE4xR1VqNFuZC/KUN1bEMzuPc2P+XZIDWPNVPqGyoKwF?=
 =?us-ascii?Q?9xKmAoqlsTV5CVssyGrfXOt7WL6XWJvUFPhGIIxSdmkc+yllvVEM7RjD+7pR?=
 =?us-ascii?Q?yvutA6QNFRTELBtWyLo5IxkuGMpidxhJM7WRVnUoEqMV69rIiBiMVdwBdfJH?=
 =?us-ascii?Q?8kN0L/kx/RLUTpkyg/liNUOguqXUV2WaUvny7X+FLFt07/CVisdeQGytpMxJ?=
 =?us-ascii?Q?cmxUPjBR709eKPYTOmYmbYd1I45GEibMP2oWdejnsfsEpG2UQ7xn9y2gRRCa?=
 =?us-ascii?Q?QrtxTyJMbhbGKE93uIFHfu8InNABBFRcqZUKBhEap9wUDX08PE5fSpm6xv5W?=
 =?us-ascii?Q?WRw+nh0oQ1I9n/OKSmbG6HX0yrYK3hwX0AuZ3tlHCE7FmVkydnVQNqPA9t7F?=
 =?us-ascii?Q?F/w7jg6LUB9t9kIEXjFfvoPzBpmTHQm9BWdq08lVMT6se3CR5REgiH0n55Dr?=
 =?us-ascii?Q?2YkezcQ90IOvWwlSXeOgI1Ls1ORYH3YSGmts4M4aJ6YOwwX57V8KJxoZlwMt?=
 =?us-ascii?Q?eNOP1hUM4SArkCNEein1sgKtoTuD8uEawxG2ORKHY+XkdnZrkKBd1SD74jjf?=
 =?us-ascii?Q?qgAu2JIqMNkbGGNouA/yF4WqgZt7ua+LoxqmrtZXIoZ7/qnwlkCFcKcY4pQG?=
 =?us-ascii?Q?uN6stJ11KZFKXCIQCw/wbYZ6bfb2QgakTdj2kcdWqFUHqwYKwGr5se5MJWWK?=
 =?us-ascii?Q?FO/XGZpkN0kZ7JLO1ew+JRG/PQEjNDzzXHc7dnhZs58TQe2hdkv9ppKi1b1W?=
 =?us-ascii?Q?ngapf9xyWDvyypIYda3jr8FM3XoC9wbjC5E4olhLsa3eGoSROsstlxl+3rFq?=
 =?us-ascii?Q?lFNybRHbOEdZRUenoy0NGPEDQX6t81hte5IXr2tgxIM91ca3o1ugVV30Pcth?=
 =?us-ascii?Q?IWDAp4+AEobc+3WRoQ01cdasJWzOlF+hWviPrfEmgN6/aAbh2BSNk0BT9e9Q?=
 =?us-ascii?Q?OWUGPdPbPsnJCoByv2b5Agf6E2E7R2e7hPm6cNvQCuvcl2MhIgScXYnt7u1c?=
 =?us-ascii?Q?5UK58DVxvF7IJhDRpxKncSJzC+oOI4+ZWOWfL/F98OF1Lfb9YamXrJedVAoc?=
 =?us-ascii?Q?eC8XR7TfUI/DU2jU422U6vi0S+1Ycm0JY8ZkK90YGhYQAbPJxYf4eEbJliVp?=
 =?us-ascii?Q?lO+XiATV9v9DXNBOu/yQ0Yf6P2kDbn85uXMKbj16DUxzpWrj4S9CNEiI2iDz?=
 =?us-ascii?Q?HOckOXBerGV4GbUgPQb403Eowkh96mkkuxTPeDO/B+MiraUmDpN0pRFhQAeZ?=
 =?us-ascii?Q?JbfTjDsJEH9h+V9KAAZxxtMg1D08K9uUlD5YZdpKv16RWSRzgHwcBkq/O2qx?=
 =?us-ascii?Q?Z/b63JmbeX0gwlB2n0c+YsB4uH8TLrjI?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xjnQJTIYKPx3iSBMQYIzqLnBR0Afz+sfTYUt7ww4mhoE7nYHy+oq6kxNgCLO?=
 =?us-ascii?Q?tlmqMDVRliyK4UkqXDHRFn5H5V/6e1NNDovakx4KcLJijzbFPtx2OV2pHqcp?=
 =?us-ascii?Q?GliyIKpvzR3Ucfa2bSer+v7AytWBkfumBi7Zoi3Ces7CkClV9+yz+Jh2Rrq2?=
 =?us-ascii?Q?zrC8qg9JqZ+PBrDyxJ4Xsc9siIwDkRrdOru+Vwfrrom8UsdEluP8+kSFNTjN?=
 =?us-ascii?Q?n0B4J8XoOqkmyV4z4Cc2PVdRkZHOKZ9YIeRWVILSINpwUzTIj05/xKZVyam2?=
 =?us-ascii?Q?SJz2KYTlJRfr2P/0n1shQl7/56Sy0nRA21ZfQkeNmi9p/2OlarC1t394ztq4?=
 =?us-ascii?Q?KGXCQ4JFjnmda94uqyk6YQX7HdVRQ+UPUpZqpwvPMuI0Qhg28jaMg2DhPQeT?=
 =?us-ascii?Q?Wqhgc4FZgyELyjRrHWPCk9CHg7BlbG2VWfX4rsSSUges+dpNAIv2rvVavVMn?=
 =?us-ascii?Q?kx2RNr/2kvSPoG75H0YY9h9Xk8zipNdA2YUx9hZORq8IZQOnVVh4MyzqLgVw?=
 =?us-ascii?Q?sUhBTNRSm0aWSGvgIPcFw5UY26456WdNsMYqmomaRos6BkXylpkeO4T2cKAE?=
 =?us-ascii?Q?CGpBSOVAJyTTZlQFt7YF4SXY8WXPRERtMM+OniuulMQ8fpl3NTHL+E9ReWaT?=
 =?us-ascii?Q?seJONobflWjsZr1dox0hsy/H1H7h1lx3VCbkNyhLdcaCJkdJ0wpLj72NzrfY?=
 =?us-ascii?Q?ZL7LMRAOsiemeO91xt84+ssOeMsblcCAQof85RgLDMfLryCfiI3FouO14+yC?=
 =?us-ascii?Q?WypWHokS7hlQdV31uSildOOkzdEY8VkYkCCyLPTMXzp0Xrs1DSyGYzSTRuLj?=
 =?us-ascii?Q?Vv6y5AxvClTmv35XTiRuhSbObXHx5sJ5y3HOVyK+iY9LB2IxbD7vCvd8HjHj?=
 =?us-ascii?Q?9DGOtO82pau+GXfvtmU1t8up3YlAnOFMLP+CsbJK59IDOXyOEssnPxBWMXGd?=
 =?us-ascii?Q?g0vE6sXu5XEe76jYdarNIr28c/w5AcuQ+7L42J+rKdUA+ilAUWWDPP6RjpUl?=
 =?us-ascii?Q?7f91VQ2M/CR7n74yMdhRWlV59Fv1L6/raqZmwxHud7TWjR3OpG6RQzF6iA2w?=
 =?us-ascii?Q?wlD95KB1BFrqTD8QyLofkuWvp2g1xOXzSXCsxA6qhJhkdJ8uTogG+UO+qyNL?=
 =?us-ascii?Q?PLcV7DSVTl3IYfeD3vzwFq/XItyEeLXUeoigqGmd9l/Jxv2EYjio04xshtnz?=
 =?us-ascii?Q?AyzOyGtECogNNywFtmA8MRSOLfVWxELy7BxIhNkhGvkmkxOSzO4S8Axjws4A?=
 =?us-ascii?Q?MzTgQ1RL9ASW39YIy400h4aML51I3IN1DfYnNcoc4vIzi8n3PRMcJ4yFSqL5?=
 =?us-ascii?Q?Hip9IdGKNn2ce0uWd2wXIihuLnICAiUg0iS5AH0mlyE0zUXdBB07SLWKcPBv?=
 =?us-ascii?Q?AjASAAZCnYpyKM1CPekORSS6uOqi5ilfodSyKl1XpNeVjnjKM5/LhxJUyXca?=
 =?us-ascii?Q?ilLlEnDaX6CSN/qQwhGJ1vDS1bgQ0IwTCcqbYIhlchHvfFcNyS9EKHGUfD4Q?=
 =?us-ascii?Q?yyWwLdTNqKzR35qC7/ePMre/DVV3EENVgF7hS1iCTIVHhCj3IRzsVqR8OElJ?=
 =?us-ascii?Q?1zrqId8ChkKNlhblj9Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c5e1b8-15aa-4bb9-0b74-08dd36a011ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2025 02:38:47.5920 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GdHLQSCdbR+R1/L+lh7SVJRD3f4EF0yKBb8w8+QU9pyEDs24e1dGNyL5QfjnqRBoc0imuR2iuVGqATs058986A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7859
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

> Subject: [PATCH v2] imx8m: Guard binman nodes with CONFIG_OPTEE
>=20
> From: Fabio Estevam <festevam@denx.de>
>=20
> Guard binman nodes with CONFIG_OPTEE to fix the following error
> when building without optee support:
>=20
>   BINMAN  .binman_stamp
> Image 'image' has faked external blobs and is non-functional: tee.bin
>=20
> Image 'image' is missing optional external blobs but is still functional:
> tee-os
>=20
> /binman/section/fit/images/tee/tee-os (tee.bin):
>    See the documentation for your board. You may need to build Open
> Portable
>    Trusted Execution Environment (OP-TEE) and build with
> TEE=3D/path/to/tee.bin
>=20
> Some images are invalid
> make: *** [Makefile:1135: .binman_stamp] Error 103
>=20
> While at it, only pass tee to the loadables lines when CONFIG_OPTEE is
> defined.
>=20
> Reported-by: Tim Harvey <tharvey@gateworks.com>
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> Reviewed-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>


