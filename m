Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57E2606A321
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 06:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SySxxspB;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Sjle9LYx
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A5DC880E0C;
	Mon,  9 Nov 2026 06:34:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zTMavR5G3W2K; Mon,  9 Nov 2026 06:34:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F354980EF9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794206094;
	b=WJdeuA7tq4Q/mLsEwfl4L9zX2xKPuIjQr2lgfZFKLzcobpN1s9XGG5rwaGPyuLO8IXN8
	 rTc5NLEoTj8LjMuMWfxxx3hYMsgR9zh/dFJBEtaI1IuN7wmHGJeoYBbRwmDjoa7+LwZur
	 RcNOj36AQCIEdGp02opWiaYP/SdVu15gijsb/3deWGrn4E9LuAQEyrO5Dl7ga7lVGTEM1
	 r8xbmUoEsaH5hjF2x/V7jIbmrEweYSaQ5Oang1EFutSx31VNgE1UN8YykSAyTN/iiUlK0
	 XMVd4wPdEjUETM7RTzHqHOM1PQjLPwS+T7dgMFjR5uQQmRLPaf54Ok9wj8SZLzxcj/A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794206094;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zGbbthHHA4ZQw0lfPHI8W4R1dIfKQ76zlu+PAejWZdw=;
	b=F4RddQfyeCykSMLD05Ggp13Ejw2fpiY1r6Hsb6xDBHhESJ+wAXMPQekIht+tvIxMFXoq
	 XftJf3oOa09f5ycjb1nPPBxBZx+TpdxH7+Fo9qlrQgxAXGWgebidjlWNIuHcPUbCSIdSh
	 xACH5ftKmSdDD8NEaXMPlY1F7GYPxApsFTGZDVJKVNxKEXV6U7ziRSPwc6lvAO0SP3DKG
	 V3S9Br2kwZJGf4onIWkzDsOqr4pcSiQlIxu//HGnv3oTfmpNub79VFvKfkOBZBvMe3EyN
	 /jZfkqxd8pBQqbKAPBIXkYVFDD7ebZ/HXPvowHmzPhXeIuwsZZ029qAKJqVqt1DUWjQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794206094;
	bh=zGbbthHHA4ZQw0lfPHI8W4R1dIfKQ76zlu+PAejWZdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SySxxspBHqfBUJfBpykdgl1CzHAmZ9p+0NWiNbwtWbsoiSr/hHEgoQh93kWj+8OaU
	 WUXaK4meBPhAMJT06YJl05uswx20H8/rnmg+PlWq0v1jPj9O++YSjeZJjaMh+dyp9z
	 6hjU2YA9Lwfw03n2keKlr2Le3u6k5k3KZ56oPVuTMo5Fd5ubRDo7s9c3YBjHkCrBf4
	 liFbSQ+Pp82X4LmZ9Te64K9IhJByrKAqpjgy/Utc3ZNptadpNfzTEwIHwNubHFJ7j9
	 AfbQRvLsC6QMgx7S2GKk0bQQtRj8kMmh8CTfEC6MFACHBYmtHYqOzrg61y8XIDaYRR
	 VZroXnG+rxY6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F354980EF9;
	Mon,  9 Nov 2026 06:34:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AA9571A6
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 06:34:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A7F9060621
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 06:34:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SnYm2nuDoq-O for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 06:34:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7F0386061D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Sjle9LYx
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7F0386061D
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 06:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGbbthHHA4ZQw0lfPHI8W4R1dIfKQ76zlu+PAejWZdw=;
 b=Sjle9LYxtdq+f0KftIxBQFO/NDTW8ZMqhHetglonP5gGXZ1nAJYrZMaN5DZOO4OJIcA9n7wXIGVqQ9iDJzrGMu1xfTE2firfmWaNnIGQMGX9eBr0r78UJXsLT0wbYM3En4KZqnt0w0LQmht9PWTgkfeHqccTqx1NeAfIDhHdtYiw/G1d7Y+yYQKYoC29s9iJrYOMPsgmnb3Ya+JJWHzK2uLsRgbmRUDTPeGP6fWFbQOICz4UbhKtxSmBMZIL7o2sAGVq7IU5uo9LboGiJ6AsW0FUpIXlL1XxQI8v/HZAoT9ggQBIvxdzqZjCAzeeUzApbIcri2rsrMpUNw26mq00Kw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by DBBPR04MB7849.eurprd04.prod.outlook.com (2603:10a6:10:1eb::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 06:34:46 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 06:34:46 +0000
Date: Mon, 9 Nov 2026 14:31:16 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Daniel Drake <ddrake@baylibre.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.u-boot-project.org, Fabio Estevam <festevam@gmail.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, francesco.dolcini@toradex.com
Subject: Re: [PATCH] imx93_frdm: prefer fastboot over regular boot in
 recovery mode
Message-ID: <avFotON9kS1KXQU2@nxa18884-linux-1.ap.freescale.net>
References: <20261106-imx93-frdm-usb-boot-fastboot-v1-1-c0bdfbff3c63@baylibre.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106-imx93-frdm-usb-boot-fastboot-v1-1-c0bdfbff3c63@baylibre.com>
X-ClientProxiedBy: SI1PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::13) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|DBBPR04MB7849:EE_
X-MS-Office365-Filtering-Correlation-Id: affa588b-1f75-4cfb-cab0-08df3e2b8bbe
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|19092799006|10067099003|11063799006|56012099006|261026121527099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: xEZ6CGWtoGqrdMgccCv8OVJQp3hz+6ot5CzrbW0s90CrlBNqgtjyaIfUK2oeCfj+GX9uITjMboQdkcJktoEUmt6B/wvpujBhfoxz0JyJkQeoy7z3mT0SWTVj83T4BPUUhxBn1PZk5EAKevsF89095UkJ62aWBcv7SwVFgBZx6dqFUdytqBqNK+P1oTyNli/wD/iAIVXURo/MJ5CP+lSzs0bPGIJ07vFq89x2wEoQG2InbYPeVfFFzJEu4BZeZwiw/736nxNPik/36Gp4kZRHQMSCyIvsVoQC+isxceZGulcV6ayE0aFneZTRB1HFxdP6I+kh0d6AtSkgQt8plCXNGueJTJh3R25IcAXWCsC97PB7ih8UIbJ9UbCeFk9yLnZi+nWratV85IrD0zWbxSgO+L1z1bhzy7htVvc1DcpMKbwnd6ddFSRthjKVZwVgMZP3lCwKscV2Dly9XeOH5m5CcfGPdmv7IH+QggH1kIWuvXcIJ2zqpI2/iX2FYsyRgMOM2WqkV8SMRPDtFmrrGfFoPkdQImnBZoRr+yW68liYKioAULZzYC4kBHSf/Enduoh5dSEenNmzJyPAwzWrpm7UNM6T39N6U8Eh1JA7hNpvDvUyPyHuv77LASh/mecnXZEkc4Gv2m5riFP1TskLg9t6Zixk5cmbokVvntj6OCo4g0o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(19092799006)(10067099003)(11063799006)(56012099006)(261026121527099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sB5pBpr4j6bRsPy+oyTtjOslD+FtV3DF86Xfc89XO+VbSRRt6xoO7RbML6eG?=
 =?us-ascii?Q?J5Q6/6h9a1wmYaxBQFFpRo+w5PVLWGiJcRHKquDQLHCOKvtzzl+FRM7zsM87?=
 =?us-ascii?Q?GMC5E029vgV8wlYKy7p/jUdMKHLbrMw8sFQ2VyBmZlomIW7pAKFTX+vElUuD?=
 =?us-ascii?Q?6ekcC+axEW1fuboggKzk39BOjrZLWfSADAdlAbDihXLfZTrOCSwudFsUr9pL?=
 =?us-ascii?Q?p/znmXap6qAzl4oXmgWLBA1eCafmavJIJmACIHwOlTvqDWeOT5t1vDBV2ywf?=
 =?us-ascii?Q?0NdGWDnxa2pvSrE6ZbsbK9EcyROffZmmKD1BrMnU6mblQOw7dq4xyi1SjlpF?=
 =?us-ascii?Q?LAfJybIzdgYXotUp+q/7vrLxO9P0FIRce7fcFWtpoNv0OWsFHEbIwIDLBoj0?=
 =?us-ascii?Q?T3Ptn+JCtv/JAx0eDPCIQrknWtFvpV9zuMA/59b4UBnh9AQ/DXP4d7VlnEav?=
 =?us-ascii?Q?Vjrmtk6HyhfRjTQC6kXoLNH2Sdgg9KVqxnp54MEFN0VYppBePk60OHuvJuwE?=
 =?us-ascii?Q?XUKm4mkeY97dn5mTT9vNIQzm/VGvX8p492CsjrbddAyylymS6hnLZlq9WhIv?=
 =?us-ascii?Q?kKiqe1F/1DjeIc/cuzdSH0/Vsp1p3k2VyI8JeraFg1pfHr4UUwOAzPXQxksI?=
 =?us-ascii?Q?mIJIsBqt9a+PcgASiGMi/fODeOw21OFJJ9T18jFQO1G8YZ5HXIPo6ZO+fByK?=
 =?us-ascii?Q?h7q2VTfYpDNYulPa63Z6UkWPzPCuHKE8QBw7uiQ7tiPCCl1dREjP32ajuPpA?=
 =?us-ascii?Q?wUsGOQPS/UakoFaBGjji0XStrh+9rigAS1WFydiybuYv1x6EDsVdinyzVyYC?=
 =?us-ascii?Q?GNzF4rAle65CC3Ut6mFsU/1reSadxV2ok3gfpAMDsqXQ3T4t3DO49lmYvoo4?=
 =?us-ascii?Q?XsjxiQjytWkwyKyHarB4eCdOe3UzJUvdoxPqDasJ/Nqmg6w92+8HQZm//atL?=
 =?us-ascii?Q?/mJ4B/NoCOIwjvgf9YzysUcCawM+/E9RbtmzMl/rMdJSi1rd7cBYjB9jOUMY?=
 =?us-ascii?Q?XXIi1LY1zpmuney8vRhMCVh874EPs6f3lU8vCxV2q9OP/s08Vp2+XlLXJB90?=
 =?us-ascii?Q?4Omr1xV76NJXdNp0DX2KSGMu5NqCfwCc/M8DxjK52Qdaw/8eQviursJbdhAR?=
 =?us-ascii?Q?ECDcNM/pwqLf+ndRk6aS/YPZWThnDZ9i0lxg3np/0NM8dUaS2w+SF4dY7HUE?=
 =?us-ascii?Q?rpb9NbkumJZmn8tyUqrKiiPyNpD/AA5BEbpBrentm0M+dpK2nW5EuQCZTwno?=
 =?us-ascii?Q?SAP2ZR+ga/d0US1dYhHOPd4xXthR8lUu2vrNM15uDabPzv3yE4gZJMFTBq+Z?=
 =?us-ascii?Q?hBTHOubTIuFOVzab6vzJ1RucCBn+OkiDszJCXz3uhP8+V90/5J6h9ucWG5p6?=
 =?us-ascii?Q?RZ29o2Ho7rI6jdQL7q2OCgI8uw0ItBlAJWK6Q9y1c3E44WRibjWUAXQ/8TVT?=
 =?us-ascii?Q?N0FyqxYNVYEjm+eZDBBNXvzGTlH4VNsKTudJlzSGVyqgslhHX4lTesqL0W1y?=
 =?us-ascii?Q?zIKlUd1h0JNh3lWjGqD1leDdzZkHdBzK0tiJMgJXYhYTaDkeZOhhvlpQR6VG?=
 =?us-ascii?Q?T+CoAZXdPUi06hfSlb5jIYksm9rkPBOkwrGvk0Hod9dcetMB+4pLWIcVced4?=
 =?us-ascii?Q?4G9XwMD6XzWXnrWIiywzIrp5fkGVKfSFNATYqaCvTy5TsbOzoazit4ue2br4?=
 =?us-ascii?Q?AXUvgcHVQkNdDYjYIQUveAnNfEIsf9TbbrBR9HOrhcYqm8sjJl406VvCR9rG?=
 =?us-ascii?Q?1ovJMPuW2Y6qHVm70nNnf7HzlMVbWhY4/XY30OKpgYD7pnhgU1/w?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: affa588b-1f75-4cfb-cab0-08df3e2b8bbe
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 06:34:46.0292 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LDdaLcvNOD7oBRp+u5MUe1tNBRSYuarxZJHz1hwnYY85zSJaOWIFQ3RpNUOMAtj484YJMnU+5U0LBeXytpuMMHs2vEKBu3z6DHw4u2vNaO0uolhBFhyK/vnT7q2Xpt5s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7849
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FORGED_SPF_HELO,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,T_SPF_PERMERROR
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 06, 2026 at 06:41:45PM +0000, Daniel Drake wrote:
>The FRDM i.MX 93 board can be booted in a USB-serial download
>mode where the bootrom pauses and expects the host to upload
>a U-Boot binary which will boot directly into fastboot mode.
>The host is then expected to use 'uuu' to flash storage devices.
>
>The current implementation of this will only enter fastboot mode
>after the regular boot command completes, which means that U-Boot will
>prefer to boot existing OSes even when the USB-serial download mode has
>been explicitly set.
>
>Fix the USB-based fastboot launching to prepend bootcmd instead,
>following the example of phyCORE-i.MX91/93. And if bootcmd has been
>customised then this behaviour will be skipped.
>
>Signed-off-by: Daniel Drake <ddrake@baylibre.com>

LGTM:

Reviewed-by: Peng Fan <peng.fan@nxp.com>
