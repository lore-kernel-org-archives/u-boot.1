Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2117CD778B1
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 01:18:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A721C83DB6;
	Mon, 26 Jan 2026 02:18:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gPOCKp12";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A2D583DE4; Mon, 26 Jan 2026 02:18:24 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2270883CF5
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 02:18:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ulEWidgo3ohl2+/k2qDLlhSaWl15nn+lnesYaJ34J+dhr8BliDZlYXHCFwlysB8RzFkHvYabpuOsPFfhEpkhlGZV9rtEXCFh1n3uDdzrUeFn6ZnIElrNNPiuSGhxHYwghKGLk2eg8Km5uI32KbvNIbFLNYy8xCF6IWmw9Eb96uI2yK/MUiGSBkcf8rQ29EbcM9z2CRXerLJy0EN2bGyi0TBTAcG2CqEXy3/PszhCLTMoM/+hYqWNHxWSUg7zbyZCVQGPq7cksqbkNWVRTp1y9Mnr+uBvTxMrg3UHMRgEK4yKRYzSmlp30dYa0rZn+NuJNu9PHh0hcc4UOwjkvqrTnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfH9bdReSNa0cypwTEhRvv+ymKfyAVQZNcMtzjiOJVY=;
 b=b4lciPnpO7mJcauqdN2385de8cVnLmwXbdx7dGlM+OSIQHiKar57/q17obsVFDdC0K9zxuDooMI5BoJDgXox8OeUD0DLoaaE1IENZ3PMyeEzzAPANselJaXYIGZIl7eDae3w7baP2wfcIWEZip0RC0IZr/FfzIquq5JHJ2M/NOwE+3nIsb438+2U/CzWKqqRD3cHIRTPcdeqWwsrjO6xZVaEYewUXu2Zv5gDPxCJ24EaZ1cakg4ZJ2m4mv8bjUnHLwEuBhhiv/13ypWOXHov2IzPfJcVPDy/0sKIYm4QLgZDgNNBm6B6tP2+9LdG+O2M3yBRFhMrsemD31NSy/uLnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfH9bdReSNa0cypwTEhRvv+ymKfyAVQZNcMtzjiOJVY=;
 b=gPOCKp12knnbObaC6mnMz+FEZNHzqNpxNvp5XVGT/8Km9hM1Kg3Wd8nYxvKI3RixXQcnwFqERfKIEX0FPVzaGi59A9OH6a+zzHBlhRtKvhU6LcVGL7bDdYdrDnfgXpEclcJ8+C1XvYf2OMmvPNhL+Y7zSp+J14iWtQwXcxpNwtk1ZCXmi/hiodgcJpfumcuL99wAgBdcrrkSjEwMZ8zY0E7FvHhmTSOt62XQyy9ynecHG2oA1kkFhlIflDS1l0/HmW57I/nDVRLWMm+MnGBBtFzDlz1r6sHcP1BWdSrpYrObaus9EafZxmzug9hscR8TS+5ct0qOeEo1ivZ3rw/Gpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by VI1PR04MB6861.eurprd04.prod.outlook.com (2603:10a6:803:13c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 01:18:21 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 01:18:21 +0000
Date: Mon, 26 Jan 2026 09:18:18 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Heiko Schocher <hs@nabladev.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 Lukas Stockmann <lukas.stockmann@siemens.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Walter Schweizer <walter.schweizer@siemens.com>
Subject: Re: [PATCH v1 04/11] arm: dts: capricorn: move fec2 config
Message-ID: <aXbA2rQTr1vivURh@shlinux89>
References: <20260124055452.8799-1-hs@nabladev.com>
 <20260124055452.8799-5-hs@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124055452.8799-5-hs@nabladev.com>
X-ClientProxiedBy: SI2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:195::10) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|VI1PR04MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: c6f27dd2-673d-48ac-f05b-08de5c78cb56
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|19092799006|376014|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ys5au4dcIzXmAq8y09a8Quyl8+2BbbxY393VkDP4UlOng2meYJecZqTi3wZo?=
 =?us-ascii?Q?n6xjkw73TGRDWGdmaWtmGusgI3KCMqBfLfqJ6oJjWGsYekKlr35KEpeQyg2f?=
 =?us-ascii?Q?zKi/2cJgxOjTBD5/2OYUlmojYXYMeLOXeo/VET9jguo92x/VO7zqbnZ9gNRW?=
 =?us-ascii?Q?5bvF59mrU2aXdgwHGcCKl46hK/ZJ/LYebomTUwDBCnN2etRo83rL1qGKFc99?=
 =?us-ascii?Q?y4RAg7V5kJQ4rUhqu8DNEYgJfRBh4zgSVtkHXG7kfKPfUkZB1YML/nuGPT1b?=
 =?us-ascii?Q?YHXNdW6rhzi9/u2delJmoKWeA81VW6uwgIn1zQlDyjnmelnmQXHGm+IP1Z9M?=
 =?us-ascii?Q?QF3A51IlJC8MlSYs3kha6wEDoriBV3GWajHUWt3shUNvwEeCUXU2IS5GdmG8?=
 =?us-ascii?Q?Ctz5vdpNcdR9QCU0jM8OxaqxVe506bhOzBzhp5ZDJKvh2+gbgcEOiu5l960i?=
 =?us-ascii?Q?06Kz415XdcNjNf/iS+svx+sLRaTDWxfZWVkGhu0RuA9GbKx122TQDy02bHNp?=
 =?us-ascii?Q?YqP+VyJi4YI4s7/zY/AeLvk64RUxZJAM1sSy+tPlEq0vPqA1MNN16pnKgyEZ?=
 =?us-ascii?Q?Ogy8uHZ0fzHFn0x7iy/NopSW5zCYpoO4HwUOZu5ZlNTnr2TrUHOsLv0XIru/?=
 =?us-ascii?Q?M9cllncfeLGlFs+/0Hz0q6mYilUojtcnz63TihPw0ky5+sDSXGVuJmhxrfdL?=
 =?us-ascii?Q?Q8Aq3bklqVsN51ccAR9KOTEMm9ihlVvu2yOyflCThPbDv2Tugu1Xd2CVsXgV?=
 =?us-ascii?Q?v3VA3ugxnQpuUjghwMydlW8/GNAW7CnvTrg75Hcq6ec7O0ibzC3vXKNaYYFC?=
 =?us-ascii?Q?r7XPdZ+GTOqXVYKBQG7soeMVWS5f/lSU+iI5pJiSAjhRCXdzF6+MgFXxzEPX?=
 =?us-ascii?Q?JzaOu34GREaGMgdnIkF10BQV3P9RLZVt6o1vumnpePr1D9dsgN3lAh3b1fM0?=
 =?us-ascii?Q?gA+U98FZLHfLvYz8HwNm2CXQakAQvM6UP72VQeo5ouc5p0+JzRfQZ0aAjB9D?=
 =?us-ascii?Q?t3kgXL14bfo2Q6ldUVI7RE8p3Oe20cpTzL1WnOOFCQh+UGvfuzMRKwDSDVP1?=
 =?us-ascii?Q?vMBRb+OVEhwx6OtWStMI38S/I8MIQl8f/G1yTDJzGR+05CjyhYEvQLCh4ob9?=
 =?us-ascii?Q?XRy1uYZG5OofPvo2m0n2lPvueyQITuucROgnCXHCMjWQw8M4flJHwuydCsFV?=
 =?us-ascii?Q?kffmp/DNSUTLUjrT9iqitGuuc6W58jLwhvbdLetSSWTukJfUKC638NJ+WfHA?=
 =?us-ascii?Q?YscskfuFZdvTaZakY3lfT35CmWhF23pnBKbBZMX51RGrYtxGHu4ax/+zOjAN?=
 =?us-ascii?Q?roqK3qi6Oj/O8TSKnORRHo1ivk3/kk8j3X5qHpA/dfZDcAitm98ks3hyfLuF?=
 =?us-ascii?Q?VqjMjrZxAb3u/36M8VNoqhzof42ZNd3Ra6nPQxbZGQgyseoTMTS3H/mBjM5Y?=
 =?us-ascii?Q?XakXMb7QDzbnJV8qV4C7LJLh/SRwJmGUOOmY9jJcrniOTnnYE2E8TGJn8AOx?=
 =?us-ascii?Q?HxFAPFCcJ1u9ravOb8B/df77LPBs1oFo8aJvUB/cWCbBpbO2jzm0Ow0hI+c3?=
 =?us-ascii?Q?4UiQef3AjUKIYAN8q344Amvdk0wXumnzeoTY6FbeBYa5dSfDnh6gNg6daWyJ?=
 =?us-ascii?Q?vODc1nn8DrqzFW75Y7EvAos=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(19092799006)(376014)(366016)(1800799024)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tq4plvAuyjg0i/tTm/CS8tx4m7Ck1eR3x9erCk3GLKkoM/65oPq4yc/k1an7?=
 =?us-ascii?Q?AsL7speZN5RSpFRUJnOr4OJVSkURc2Mlsf4WSHahlFKVSve7nEG2Us8Qd21v?=
 =?us-ascii?Q?CHZylYiJuHE3PGgB5chfKwXkAVLjKORFQydfATCyNc43YbiRe4RnlArqgFMO?=
 =?us-ascii?Q?wNdOO+Dg4dxK2fQ/v88/WK/FL5TQ09DD6NO+JfnLcavtjWqjqsARazoNZlpl?=
 =?us-ascii?Q?Cmj5cxtbw5j4VY+jRSacyceueSvIltpDdSnLWK3ecuqbe8WgkgzleZkqVH3Z?=
 =?us-ascii?Q?0jGfNHw0WGLyoxwAyQ9lYAuGQYRNR2dxn+9NzG4COTR0UVM5OcoMoA0FeL2a?=
 =?us-ascii?Q?PUUY6jCY/hm+EnWg8PnG1tL7UAnMyaUDDYINDJe4xull8tYLgQjTMwu3o6rz?=
 =?us-ascii?Q?8/fl6PtBCk+caGs3nULD5Why3Wbsq7MLnZXa1CzDlRpEBhq6B452KNnpZHfX?=
 =?us-ascii?Q?5aFhayuMTYe6fcV3/tUlmRr1sd8aRPz9iiGSzo/Yi8Yg7WkgXE0xWKVCOBaS?=
 =?us-ascii?Q?8rlYmzKKuixTvC+BonDafamhdbBiZWnPH7lQ9RDw1JoJxhXF2BGEiBICE8gs?=
 =?us-ascii?Q?I7N93uizJAxKspgc7NR2YBA81e1JBlxJjMJdeOJS2SF8Dd2yNWYSA+KqP9da?=
 =?us-ascii?Q?5SUY+KXUB1yRcWloGId5ayC8aGAD05YB2ARPxNV7XK7wwRT+uqUf1BkQ1gUn?=
 =?us-ascii?Q?2C+e/3Ie166hd3e5796mLYlfOLxPYCOlyhSP4qE8pnq6hqK04kJsQNN+scVu?=
 =?us-ascii?Q?cSozWzzxAZaTKgNRWWNQqPm9hiDldMjVycuFvo9d2nZyiY5ix5v5UiF66MBn?=
 =?us-ascii?Q?q66ZY7182OV314m3t99qZlO/ysB2qXlCMIy/dXiIO8BJjheLRTFHBee+iPQs?=
 =?us-ascii?Q?kjAM3ck36D6bJDfKamXY0momcmLL1Ojf9SWODfwBMYWwyY28eeFAoWD91DVF?=
 =?us-ascii?Q?8gBMB7ZManah6qV6uUOERf8PqiRYbhc7hqFBDN5BiHLlft3BxqMvr2UgJIwQ?=
 =?us-ascii?Q?CAocpWNeb/u80lsRn/BMgcbsqUh2ydYE7cjyJiPXqz+wSIJztlwl2g2+Hkzc?=
 =?us-ascii?Q?rhsX57pR2RMonzTDW765jgTHY0M/x0XXXKUDiUoWSKLoTMkhBZH2OEOLGeJm?=
 =?us-ascii?Q?voWifNpXCaJt2IcNoeWvY3dW7uT1Jx4BcmM3G8r7B/Abn4kmm+hMqzYprFQx?=
 =?us-ascii?Q?KxXbD5JVUZ3+c8aT2nOJ9RhryD05Y2MW5DWg3PMqoWpKYZEuw9t690F981/Q?=
 =?us-ascii?Q?s7uzv+oVbaym+cfHmk6DfDNhFlAuSyc7cWP5FTpyldHIydKpSQRVv4zxx8Js?=
 =?us-ascii?Q?meLbkrIKS7PuecjzwHAB0arVn+kYQXK23dgnczt4nRKqzmsOmEvNyfFYXhK2?=
 =?us-ascii?Q?/k4srtgCHCskMPPXS6YEl5CXPCzcHfxrSJQAy1GtGDi3RoS3avrsBYhECKS7?=
 =?us-ascii?Q?eGEeTHHuul2sZ3/Dr1ZG3qPIy3HBx9QKPieRrw2M7gb+uUKpfJode78rJF0W?=
 =?us-ascii?Q?M7Vh8yKGXHcsUHFdz8gzYwHpuF2wg9zlvz26ZsvJkN9q+/hgX1rs5Kcce121?=
 =?us-ascii?Q?zcZPOXpFG2WbC23L5LIu1zXSw1wLGDcNr6sT8pHH9r4xL6LkyxOAY+Ua4QT7?=
 =?us-ascii?Q?ZY0OyNSYZWomcjbAi/uYzW1QFQuAOOxsiO0jHMArXCA4J0Rr1PtrRqV1ig3e?=
 =?us-ascii?Q?VZlMu190LlzlCDgzjWxmhWzfC9XruYvVzgIjChyNY9M8IvH93jvj8xHqWraS?=
 =?us-ascii?Q?qYFwdzCM/g=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f27dd2-673d-48ac-f05b-08de5c78cb56
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 01:18:21.2521 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b1xuXZgA8u4eolU+IzK/MY+npa8VXCUVxQY1HDFqEl3TZQ1uoY//QPyyeqxxcaITYl+reXLAG8Ues+ao/+UBfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6861
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

On Sat, Jan 24, 2026 at 06:54:45AM +0100, Heiko Schocher wrote:
>From: Lukas Stockmann <lukas.stockmann@siemens.com>
>
>fec2 config does not belong to the Capricorn CPU module, move it to
>the main board.
>
>Signed-off-by: Lukas Stockmann <lukas.stockmann@siemens.com>
>Signed-off-by: Heiko Schocher <hs@nabladev.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
