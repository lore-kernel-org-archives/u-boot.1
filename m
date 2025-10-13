Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A95DACCD185
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 04:18:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1E918383F;
	Mon, 13 Oct 2025 06:18:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Xnuaafrp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0102A837E4; Mon, 13 Oct 2025 03:37:11 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B6F3837B6
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 03:37:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7w+BZJtxioZdwvtq65yuhzqoLBTg82MrTQ4cOectfTIW/Sq75OPNmjE5OLw1GHR8faC/9hmdmxPV7dRW2kcs/sTWVYkZxgYQba04UKJp+XtM3ELWlfFQsumN8R+jD8Pz9k/8GLH/hiQ8WmyWmWV5PgLfTUIM52G+8Eqi+GoVuiEpWGoD9gd/118jNlCQD107r9jEiAj9c09i1JDPmya6IiH8qE2sUxstX8mb0hw4lwTbrI0D9HxC9CG1XJyqQlscZYIZkWYTkKS0hPtFFzWreSOUPAGZCK+UWJmWnLYN48qRwnZ9LtS0f+DqYgiucR6rON6i32yF7HjuYVlAr2evw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tn2HHK4pK9tKQgdBPx2LLWWT+skRvCltL7WycX2/ag=;
 b=IOvKOHfOigrFn6cxGuDgajTavWuHzHPjLU2Sk6WTTMiq+zs8wCisVlAL4h5IE1hn1j1YhLqaSq2iEDUOOYZB9Mw1thOx+7Ge1zQWSJKXsDBVc4fkGvEoZxK/0RnsJ7NeykNdWaPNAvPRkbv6enjBeQK8xihQM1pKH00D0iShd2flXm/8/kRwThdAKtcXWM6yQmhW1IsIL/xxZScIKf+Ecwh/qk8ibsB6sYM6dk35EYkMk0qem/6H1V0NEncmvZr1nPtOrC0WxQ5Sf8Rfba+dJnpJZqDAh4xhVHXSiOrBoZEGOAgRwg8oSuWzPh+ZRJioFw4mzs5ufNLA7q+PyFDDjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tn2HHK4pK9tKQgdBPx2LLWWT+skRvCltL7WycX2/ag=;
 b=XnuaafrpegxwTp7cHzbSNJIzZFQ2Q1fT8+gTgCqCARZLqJcW3LF3Weu4eSHK24DZzaSfUJRuuByOl/cq23Fkv4aT4+dFuytuOc2BCxj2rm4h3Ar0OyFNZp5XP50t8ww080Cdn76yO7ONJvBx8d8tqyrMVVGet1aFLL6TpvndlTZgnnb9BPoTJhqZZmQ2M5afZP52YUxRTlYuILm43ZVGhZR4AMcPLqHENuQy48XgL59cgGrMkEZ2aoubiEz2359jcG2SQmJsOGi19PKtWbfO7zjX2tTGRDtkMWRmpDxyP5MgcdotO0vYu/XOh2D26EhY+Gn7ErRU7XtbvZagqiDNjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM7PR04MB7077.eurprd04.prod.outlook.com (2603:10a6:20b:11c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 01:37:07 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 01:37:07 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 00/11] remoteproc: Add support for i.MX8M[M/N/P/Q] and i.MX93
Date: Mon, 13 Oct 2025 10:49:19 +0800
Message-Id: <20251013-imx-rproc-v1-0-fb43a3fafcd0@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAK9o7GgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA0Mj3czcCt2igqL8ZF1jC+OUJHNTo2TjNHMloPqCotS0zAqwWdGxtbU
 A8AkSrFsAAAA=
X-Change-ID: 20251012-imx-rproc-383db752c3f7
To: u-boot@lists.denx.de, uboot-stm32@st-md-mailman.stormreply.com, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Udit Kumar <u-kumar1@ti.com>, 
 Beleswar Padhi <b-padhi@ti.com>, Hari Nagalla <hnagalla@ti.com>, 
 Andrew Davis <afd@ti.com>, Judith Mendez <jm@ti.com>, 
 Ryan Eatmon <reatmon@ti.com>, Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2PR04CA0202.apcprd04.prod.outlook.com
 (2603:1096:4:187::20) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM7PR04MB7077:EE_
X-MS-Office365-Filtering-Correlation-Id: fd023fcf-d812-426c-3f4e-08de09f9050d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|1800799024|366016|19092799006|376014|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y0pIMm5ucWdTeUlzb3I4K3JXb3liMDF2bmZhVVQ4aUZSbnJKaEpPb1lBelZP?=
 =?utf-8?B?RDVBdWl5MzRwWGx3Zk9VQ0tSL0F4ZzVPMmtsTWdRaVpZOVZ3NDA0YWsyMVRP?=
 =?utf-8?B?WXZsKzRGR0hGTjU2UnBVQVRTakRUQ0E2N0s2MkoyL3R0TjdpMWJDMDkxZGt6?=
 =?utf-8?B?TWlpWEhWbVRlVEJMVTZHZllrYUZHbU1ja0JVazA1dE01RE5YUXVWMldHZExr?=
 =?utf-8?B?TjJ5RTNrYWpMUG5JVzVzMi9jYWFoUHhYNHdqSENLYWdMenVFTDZGV2dTaUF6?=
 =?utf-8?B?SWptYXpxM0xMR1F2MGt3RXZwWGNRVWdsK3pTa252SjViL3ZMb0Y0UFJtNjRr?=
 =?utf-8?B?YTkrZDIxdW5ZYXdsTjV6bktDWlZlZUNQaHRzWkVBdFRTSmNHOW9vQnc3K09w?=
 =?utf-8?B?a1FmRXhycUtrMDZpZmZJVzY3VkhuNXJTRUlrOWhqRXJsamQ4NWh4QU1HTXo5?=
 =?utf-8?B?T3M3cUNTZUQ1WW15bytZQmNQRDdCdVdmTU1qV0FVRGVpVUt3ajZDS0M4Sm4r?=
 =?utf-8?B?MGk5R2g1Ykdka2xvL29rbzlvVDVpczJ1amV0a20vVUpHSFJHVmhTVkIrenps?=
 =?utf-8?B?ZzVucXBXYmlodGRZaGVja0t2eXQ0UVNzcEVpYUYxY3U3UWtYbHMwZXlzY2hD?=
 =?utf-8?B?ZnJPdVFkdGtGR1d6VjJrdlhpSXBWaFRhN1FpMWg5ZnhtWldmVEhIR3FST1F2?=
 =?utf-8?B?RFdpejBxZUllbkRLdXdiUDAxeklUZkNqY01rL2gxZ0N3eHFYaEl2MWRoa250?=
 =?utf-8?B?QnVKUmlzd3BLTGVEVFFLMkhVWGpkVzFwUEZRbGJXR3hRVmkwQXRSRE5qam1r?=
 =?utf-8?B?MmpYakFLdHJONXN0M0U1NHJpMXRrWXkyOWRhcGZwWHpDdy9WUkV6Q0MrZU1B?=
 =?utf-8?B?TkM4YitVQlAzMHVIbjNFc3Q0M3Y3OHgvQVloRFUvMFNMWXlEcW44eG5zdHlP?=
 =?utf-8?B?Qk9TMVFVWEJkai9VWHBRbG9ldlQ3c2lwSGoxTHZJcmJBU01PSGdJTDVNeDNp?=
 =?utf-8?B?aXRIdWN0NHNaN1JlVEFiYUUwUjVTeVpzNkREdkNrN3FoL1hLVTFMK3B4RHVt?=
 =?utf-8?B?OVNMM0RqTExwSVhNMGN5b2ZveHluYXFVbWVLR0dBcFlCWmZRTUhFZFRZMTdr?=
 =?utf-8?B?d2o4Ym9IcDBtQ2tWNTc5bHRKbDNwRlpSbzQ2MHhYV29Bd0FIajc3VGh3S0g2?=
 =?utf-8?B?aDNFZWNqUE5hdnYzL0R6N0tTWXFNQzhHREVsM0dUTm5PVzdDT2VZdDRON2FE?=
 =?utf-8?B?ckFTM2FHVXBVUlFGUFFzblJCdytCSmM0QWtFZ1ZPdVVxbDdSTmtadzVIS3Nk?=
 =?utf-8?B?Y2lJV2d4emFPczIyUXdiWlRPZlp1ZXhUcWZ3QlRwT2RNL2V1Y2VVbVFlMDNy?=
 =?utf-8?B?cThUaDlyOXhmTm1oQ04vb01MRGl5V3BMZHEreXM1THQvZWlLUHY4YktYMndH?=
 =?utf-8?B?UEhzK2ZTUDdPNUthbGJ0SWJ4RXNvcUUrMTlYcUFYN2dNM2NDaVZVeEVQVTBY?=
 =?utf-8?B?K3A5OFgrS1pReFRtN0hpZkFmYXdZdHNqWGFOczBsYU12NVJKRDdWNmVVN2t2?=
 =?utf-8?B?Z1VFeFBJZlR4MmpHRzdjcU5rS0F2akVzYXIrR2RUMXlvSCtIODNoV2M4M094?=
 =?utf-8?B?cUFUeTVZM2N6dG10T3FmVzhLNjY3RFdrdW81T084bXY4QUJHMkh5YVREMW9h?=
 =?utf-8?B?alV0QlprMTFGYlFrZHhpWHYwRzEvRDBNTmVJNkhYMllLVjNibFlyQk5UcThJ?=
 =?utf-8?B?N0VVQWFIOFRQckNvOXVrZUZRKzBUK1kvWkoyM294U1R6MkY3bFlTY1k2Y3dh?=
 =?utf-8?B?YTUyTHVEaHRMbmZOdm83Z0ltd0lBSUd2b1pLWGlMNHBHMTRCQmdEQm5BODM2?=
 =?utf-8?B?ZjQ5ZlBZSTFKVGY5eUUvTjZVNHNsU1VXdGVFR0dVNjNTTHZmcWE2eFhsSEtW?=
 =?utf-8?B?VHV4U0dQV1FHbTNQMWpERTNqVHh6V3p4bXEyaUdSalZTMzl0MHZMa0FrcXQz?=
 =?utf-8?B?cGFhOXdrQS9TL2ZBS29mM0FUT0NRQXNENEVLZWNpSkVDb2JWeE51U3QrT2d1?=
 =?utf-8?Q?f16SDy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(1800799024)(366016)(19092799006)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1hKQmpQTlAzNzRtS2x5NTNMeVhiajg4UFJRY0IzdGRaazNwSUhaQUh5SnM3?=
 =?utf-8?B?dUNXN0J2VExTanBhd3VYVk5hZzZBYXQxVzZDWHhIS3RBNzJNVGp0Mmp3ejNN?=
 =?utf-8?B?ZXhxZTB3MjV4alVZVnFSWVltYnpUY2ZuamUzYUQ3V1hFNkltRWNLWnI0Z2FC?=
 =?utf-8?B?amtzMklTV1hNZEVrMWRmN00zQTNkd0VITGoxeFRRbzZqekJqMzc4ek9hdXNu?=
 =?utf-8?B?b3craUVvSHF1N1Zwb2syMWRVNTZsQ0NUR0dhT3RtUFlsaGk4b0VWYmI5NmRR?=
 =?utf-8?B?bW9oOVNJRzNHcjB0ZzUvL3JxWnJHWkljbG5WbFZVdnFtWjlqY0hUbkM4c3Ni?=
 =?utf-8?B?eUV1TU1LKzZhUERXcHBKRXRNdGtyang1Ty9CUG91cTJUUkI0MG9wYktuaWg0?=
 =?utf-8?B?dmN3dEJtR01OeDhIYk5FRGRtdDQ0RWdaU0lYUkExRFRPTWdIMEFwM1FpUlF6?=
 =?utf-8?B?ZWpDVGFUTFd6RWpQdTNFd3FmUjNWK0lXeDNORmMxSGFQWVlLQWlSMmJZZkVR?=
 =?utf-8?B?Zk1jOVQ2ZzVudXp2TlFlTG9wTGJIdHFmM2ZWOUhoaWxjbFM5RWNucVZrTGlQ?=
 =?utf-8?B?Q0QyUGdPckhFdGd1SUswRXdaUjBoRlhNNU5vNXB3TDE3eXJvTkFES1NXejBI?=
 =?utf-8?B?Znk3T3BMdnpEUlFaQ295ZHB6WnpZZzMxVTZGU2hROHIyeDNjeTZuazBFODFM?=
 =?utf-8?B?UTVCSmdMRWlSalJBUlhLWUJNVW1oQkxoY2tBc0UxV25qNmh4MHJCVkpCUmNV?=
 =?utf-8?B?VDRaKy9rcDhHcStIdFZPdWJKODkrK3dhWG16dG9zOERjTWhoMHRmeG82UlUv?=
 =?utf-8?B?TDZDN2dJY1BOOFpUQmh3RGMxWDgzV082c3Rxd2pHWmMzQ3RSMjNCaVlVOTdy?=
 =?utf-8?B?ays2bUNlc1N2STJpcFQ0a0FUU0tIVm1TVW1icDNqMHFLTVVzQnUxVlViUndT?=
 =?utf-8?B?aHFHV291dHNiVzVkZlNVVGNRUHNabkVuT0NKeGJOVk9qK3VIdmFvT0lQM1Bi?=
 =?utf-8?B?anFMR0F1RnFSSFlXc0xWdU5LbHdjcWc2Q3ZiR0c0OUxRTHJhUVU3ZEFhOGh2?=
 =?utf-8?B?TExWRzV0NmZxNnlqNkZLUWV5djJaRWVlYnR3UWVJYnhCOUlYVkJVNE5mY1J1?=
 =?utf-8?B?dVJTWVdwbEY3b2dhalF6MWtGbXVYU0JXWkptVmtXVWZid3RpOC8weWw5RnRC?=
 =?utf-8?B?aWIzTzdSQ2t6TnV3VW4reEkyaXp4enJ2QTlBUTRsdi9OcXhmYjZ6dko0Unh1?=
 =?utf-8?B?UWZIeEdZbFNWUW9CMitDeU91TTBBTWM1c1JTSVkvMDBMME5zZVoyanIycjlC?=
 =?utf-8?B?YkNPZ2xwUlVoRGoySXFwS1Bwc05scVpYbmVVeUhRMkx1UVdESjlybUVpcC8y?=
 =?utf-8?B?UzU5YVdob2ZsdGx1MXAwWEk4dk00RXZ4bm9LRjVLODZqb3dJclFiaHB2QVhL?=
 =?utf-8?B?UldhV0xZZVhYMDVBT0ZLcElRYW1ORnk2eTJzRXkzM0YyQkNzYzllMHV3djlu?=
 =?utf-8?B?RE11b0NPbTNwWHVwWDl2YXA5d2U3S0pHM2Zwb0lLeHRHSm5ZcEtNenJERSt5?=
 =?utf-8?B?QVhKTXl1UUU0ZUU5TWZtVFdMYm1xSWo2RWR0VnlJbDdSMEx4VE1CV2w3U3FZ?=
 =?utf-8?B?SVloQWd2OVhwalA0bUx4SDlTZmVFSm1yV2Erb09kTEk3R0Fic1JPT2VRb1RP?=
 =?utf-8?B?aG1Gcm8xMERaZ1FVOU0xSG1XeENpMVlVYmRSaTZxUkJuWWJjczZEOTVZKzR6?=
 =?utf-8?B?cEFJSXBDeitWYTBlZ1BGNmR1WnhHV0ozOGc1TjVsczZCYS9mM2V2V3ZyT2VV?=
 =?utf-8?B?djJkNXpPZW0yZUUrSE1aUlhSNXlUU1NtTUlxcEtBcXlRbnBCaGhyTVc0M01C?=
 =?utf-8?B?OFBqS0x4dVhQQ1N1a1ZTSE9tMEZYQ0h2bktFQVk4TU8yMXRoNWduSzdvdnVJ?=
 =?utf-8?B?VTJFWVcrdU1RUTU1a01tQXRJb0JqUmVBc3lxcEdIQzhXbVgwLzFiTmxTVFZY?=
 =?utf-8?B?azR1L0Ntblg4NncwRkgrM0VTN0xhcGFKZk1hblM4ZCtBUkVMclNyZVBVZk5T?=
 =?utf-8?B?QUVDZEw1VUgxcUs5dkxkY25wM2g4c1dCS0lhbEY2NXFaTjJ1OVBaaEdkRVpB?=
 =?utf-8?Q?03yLxV5Hby2WIf9Qd2yExSKvd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd023fcf-d812-426c-3f4e-08de09f9050d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 01:37:07.1289 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lasqwAyW+g8QSQZLU5OD0q8JyaHSMdDdedL+wfdCC91FaZEIF6IWL3Ld3h/jRif7212e6XuN3bn2eqPt/YBiBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7077
X-Mailman-Approved-At: Mon, 13 Oct 2025 06:18:05 +0200
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

This patch series introduces remoteproc support for NXP i.MX8M and i.MX93
platforms. Most of the i.MX-specific logic is ported from the Linux kernel to
ensure compatibility and maintainability.

The existing bootaux command in U-Boot only supports loading raw binary images.
However, this approach fails when the remote processor firmware contains
sections that must be loaded into both TCM and DDR. To address this limitation,
need to use remoteproc framework ELF loader, enabling proper loading of
segmented firmware images.

Patch Summary:

Patches 1–2: Import memcpy_io and memset_io from the Linux kernel and enable
             them in the remoteproc subsystem.
Patches 3–11: Add platform-specific remoteproc support for i.MX8M and i.MX93.
Patch 6: Temporarily adds Cortex-M nodes to x-u-boot.dtsi since they are not
         yet available in the upstream Linux device tree. These nodes can be
	 removed once they are merged upstream.

NXP internal R-b tags are kept, because the patches are directly
cherry-picked from NXP LTS tree.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (11):
      lib: Import iomem_copy from Linux Kernel
      remoteproc: Extend device_to_virt with a is_iomem parameter
      remoteproc: Add imx_rproc driver to support NXP i.MX8MP/N
      remoteproc: imx_rproc: Support i.MX8MQ/M
      remoteproc: imx_rproc: Add support for i.MX93 CM33
      arm: dts: imx8m: Add remoteproc node
      imx8mp: Enable remoteproc for i.MX8MP EVK
      imx8mm: Enable remoteproc for i.MX8MM EVK
      imx8mn: Enable remoteproc for i.MX8MN EVK
      imx8mq: Enable remoteproc for i.MX8MQ EVK
      imx93: Enable remoteproc for i.MX93-EVK/QSB/FRDM

 MAINTAINERS                           |   1 +
 arch/arm/dts/imx8mm-u-boot.dtsi       |   4 +
 arch/arm/dts/imx8mn-u-boot.dtsi       |   4 +
 arch/arm/dts/imx8mp-u-boot.dtsi       |   4 +
 arch/arm/dts/imx8mq-u-boot.dtsi       |   4 +
 arch/arm/mach-imx/imx8m/Kconfig       |  20 ++
 arch/arm/mach-imx/imx9/Kconfig        |  12 ++
 drivers/remoteproc/Kconfig            |   7 +
 drivers/remoteproc/Makefile           |   1 +
 drivers/remoteproc/imx_rproc.c        | 370 ++++++++++++++++++++++++++++++++++
 drivers/remoteproc/imx_rproc.h        |  56 +++++
 drivers/remoteproc/renesas_apmu.c     |   3 +-
 drivers/remoteproc/rproc-elf-loader.c |  93 ++++++---
 drivers/remoteproc/sandbox_testproc.c |   3 +-
 drivers/remoteproc/stm32_copro.c      |   3 +-
 drivers/remoteproc/ti_k3_dsp_rproc.c  |   2 +-
 drivers/remoteproc/ti_k3_r5f_rproc.c  |   2 +-
 include/asm-generic/io.h              |  37 ++++
 include/remoteproc.h                  |   3 +-
 lib/Makefile                          |   1 +
 lib/iomem_copy.c                      | 136 +++++++++++++
 21 files changed, 731 insertions(+), 35 deletions(-)
---
base-commit: 48f21e66e360552c75d70a50421d0e0ed1f59e90
change-id: 20251012-imx-rproc-383db752c3f7

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

