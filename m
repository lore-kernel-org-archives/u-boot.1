Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1937606A333
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 03:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Qd4YHumM;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=SggltcUl
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8EDCF80E6B;
	Tue, 24 Nov 2026 03:37:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bIxiZHRmTiu5; Tue, 24 Nov 2026 03:37:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A10E580E5D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795491478;
	b=aCLAk60yYnR+OUJgvOQrXAp1EHAU4G3ov5i3shLR8LmsuMxKSk9KuaXKmiY/BIL166Ri
	 c7eg8Fw47Si8DpFXDdVy/nmKtXkIkCQxV1Zahz5eogqCPDnGbtzWJEwEYpha6J6RTZ+9b
	 vtWd3CBgB8cKVAI3PK1t9d2Q37STW+ZQK7jkLCDmCIXbiWZ9F74x3SDsqQf2lvP9uhiD7
	 cGdoY5G9Lpb1juAGJRkYJvfsOwbJRdGYu6iPL2HpeZhxZAW+JuiC2TMcNFYbHbb9lOX9W
	 xpbqyKmSa5tG1Mwctk+jYV7ArTw6/RiiHnimm+giOQugNZVUiSmRIPLSGO8mi1FJIMQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795491478;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:Content-Type:Content-Disposition:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
	 X-Virus-Status:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=qEAEJUxgx2p1L6dVlFGnKF7HLxqXSDDKkAjeSQpiN6E=;
	b=gQleB2UE+SZha7GWxgNmh9yjtxg4Blhn/ldmgwfQ41U7vrM5XAHG6Ccmdj90CW6LecPr
	 Uh1B0XeXk/+pjD3kUFw5Y2UI1oYUyOIVLARaxUM+RbVv9s6GqCRe8FKLOz1OxnEtWU9Ku
	 Esh7PRYSlFzA5MNjEWx/h55F01+hN2luMBbzGBwsdoQPOsabW3SHSKk6erLmJBhUYA8bX
	 HnGeD+yHYSPuIBNHOZ9hvOtAhXQpb5yjM/CsvXaFRdtXZ02aK7eDrHPeyPGbCgzhWTtQ/
	 CChhdUShcfoi6CNCRuEIjwno8y9h15JrXlbRM9nqCyhM2rVPlZgd/NpRq3ckj18qfPA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795491478;
	bh=qEAEJUxgx2p1L6dVlFGnKF7HLxqXSDDKkAjeSQpiN6E=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Qd4YHumM78WEEJPxZzF7AtBq9/+SjwyiUxgmNXyPLg8Wc1bvRw5r7iIJQrs01tbX5
	 eBZdykJ+kCgDNfiTEUHxunfocJPm4puRcFjiJDElyClZsiKoh9ZZ8YfGsxKIqeVxDP
	 LVS9sfH0yh/SRZAg6YhiPoFKX/vb6FedOw7Sa/cJnb6V9+ETsPFUxfyVbf5LegtQiJ
	 mvdz1d1fOTbqNevU13P4KSzDhiGP7ufsvaayJrU8TlDm8QC7r+3VRladVxC2iQ1A1v
	 uInzvt3Uyew7v6OAn/hWQsy7vXBBwtPiA9C8E2FfKXrmXFVpPULS+AaNAzmKVHyHZD
	 exGwDbaE2ewFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A10E580E5D;
	Tue, 24 Nov 2026 03:37:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1F75E3C4
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 03:37:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1179F4006F
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 03:37:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BAu9mCGty_NC for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 03:37:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org CAE5A40068
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp2.osuosl.org; spf=fail smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=SggltcUl
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CAE5A40068
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 03:37:55 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AF6B83B4B; Tue, 24 Nov 2026 04:37:52 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58F3A83108
 for <u-boot@lists.denx.de>; Tue, 24 Nov 2026 04:37:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEAEJUxgx2p1L6dVlFGnKF7HLxqXSDDKkAjeSQpiN6E=;
 b=SggltcUl8oMNfUFVS3015m1mph099osBqGt1EHeago8eaykKmnju/7NemK/lqrqzqtbO5CCcG7wHy9vQVlRFtb+N7sJJq3KM0Uabd53slO7zrfMQjMhdJGdI9WQrq/8kirG8phkh0Dwu6QN5uRgKYvR4fXLhtlVpLNX+Anl38BVHkztYpIJ0Kl44+u6+1FtR7AKyjPQkLGXGUkgvgTogwDf1ZM8DgADzDvuYI8F9y7FQ7WNls7E2Tk6lE2YC1t48egUBxkBFdoG2j2q5EWDnTZFZ45y3oT8mPSNvqw/5r/F66u0czjDGFNuuJ4XTlae0f6F2zfqXwezyvRPrCvIS2Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by DB8PR04MB7049.eurprd04.prod.outlook.com (2603:10a6:10:fc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 03:37:41 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 03:37:40 +0000
Date: Tue, 24 Nov 2026 11:34:46 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>, Yixun Lan <dlan@kernel.org>
Subject: [GIT PULL] Please pull fsl-qoriq-for-2027-01-rc3 for master
Message-ID: <awUF1tJS6-53BKGK@nxa18884-linux-1.ap.freescale.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:194::11) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|DB8PR04MB7049:EE_
X-MS-Office365-Filtering-Correlation-Id: afe1bfdc-805e-485e-845a-08df49dc4a7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|1800799024|376014|366016|261022115727099003|261026121527099003|261102123227099003|261022075727099003|261022105027099003|261026140227099003|261028144727099003|261021121427099003|261021123027099003|10067099003|11063799006|56012099006|261009221227099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info: tfjvLHul5S3vqg1e2gqGhR5nnvfQcjrtEYpmeEBPe2WQ95ej9a/Vx3lExp24GzcT6QkNZ60T8Fr24uwt/+vaOf8ukg/ggRXYHkkgO/jf1oTQjdbQyxHUiHnkP76NT37RicRGWXiBjqASSUR87WLVKpWFVoBk7fKv1hZRvLJ5BYSBZuPXbJASDaTo4fpYPxrPh/xG8reHW+9X1wa+IKcCXFDwkwV+Rv5wfA8I+/mKzO72oTHXoZZh5MQZr+Gq0FTkMhugVgk2OKgPud+gBzSpMBFeAvZmEaL3BkAAwCuYqQ/8w5zEVpKIiq0Vs0IkKFRXHt+Jt6SPLySzgi7wudM/bZNQh6bnytjrxyeoSwRlU2l0ioRvhACN/IRGgFdcpUVqsigVaxgg9kAe1njaywXpB7VTGyYdxdUIQbzYiQStTRWyarhUlRI1QP4sdTTzCJxCA29Ea2R+TQbzh6JenztJOUMOemY1vG2L1NETt+RU+c7rtcd+TOrf2HyPkkv4m8RXwLO5y4CulY0RU8KET50iRC+rzwcxvMK50jId2W8msSTjHCXJptKVymvh3pdfCRIwhgyduT9VG9lYYODCmwHjweGLHNApg6DbxS8PZ9GTKPUkuGB/k4SRE72GNqvyzqlC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(1800799024)(376014)(366016)(261022115727099003)(261026121527099003)(261102123227099003)(261022075727099003)(261022105027099003)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(10067099003)(11063799006)(56012099006)(261009221227099003)(261009223027099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p6hW07ha2Df/hKQJ334xCj6pdzvX/yRRCZ7RNFpqddQg6iEnL5Cb3c/dcll4?=
 =?us-ascii?Q?a+wiFfopPfEybWktGIzgwUo2HH5jCg0dbEgm/a9LFKuBmogxIQLhEBH1q2ce?=
 =?us-ascii?Q?cIKtUmKrnw+c9SWGnpI1Eb8auNR6c0WMGT9VlO8ADJ37h23c9TLYMlWQY9Ja?=
 =?us-ascii?Q?H5LfoGzqtSHB9QALiDBaZxi6DEmmHbpHtCXV6XpBnOAkTNj/bEgYHEXMfN3d?=
 =?us-ascii?Q?X166r9/bbHMmUQoXpKH/5ESEULLJHw4TaD2SRw1L77l/rEsbqeM+J9cPmM7F?=
 =?us-ascii?Q?pBLOC44dMcGwfdMMU+O0wj7UtQ1h+xv8iBvUH1uEKWrxaYseipDCE+k7K1bK?=
 =?us-ascii?Q?rbzOvEXaEEdsZJGZHCIhiYAdnRrTJxKOn5ja2k9rOBYV4Rh999CTxkA7nPyy?=
 =?us-ascii?Q?UcjrStw4GN/lZC5htfDNyC5y8JAnL3iJKAtRSbwMf4a0aNv88Lu13hu/lope?=
 =?us-ascii?Q?OX1eCNS22GZ8YRvp0xwGnZh32arakryozfLf5AWfyVn5p7qehINbXhBLZCec?=
 =?us-ascii?Q?bxfdxQxa8v+YHHIOfy0vknqr+IBfiWoCyZkO1iVwF7gcpwwKF5W/tP6Zw7af?=
 =?us-ascii?Q?7us18L38QlHPAJK/DkG8IKxvG7KQXFRhzYNq4A0HAHCEaqhrhRcFZENJiuZG?=
 =?us-ascii?Q?yaBaMBUUMN9zB0eDliPxuki6qTdQUAB08ryJov+IskRLIcPnqow9QNOIRMP2?=
 =?us-ascii?Q?Y8e2Q7wWxsrWaBeENcuGLDWZZWnQAKv11gQdHwAsL55CcG7JkI17HMYb+NpJ?=
 =?us-ascii?Q?ABpgnJXF593+c/ERkT/kzRB1TIHgj212nZ5K2LH4CkWP3Pg46bPmfnXN7G4X?=
 =?us-ascii?Q?406wnjhAvCooRg6sSf+SZiDmXqli9C8PcTO338wuJDRhhhjOZ0pFLLhvVVe3?=
 =?us-ascii?Q?eVNmpAs8Z6DB9079xIDS75eGocffY6FlZeAfTojJzLLuX9GM6v5nq9mUi0Kd?=
 =?us-ascii?Q?DU+hKkTeyi7gbYLF/tLPU7NRSB1m0tHWU2fujGbuDxcsINqTq6/AZt8oyFUc?=
 =?us-ascii?Q?TEnfcKCbKL6lvM+iRP3IcrlwlXt1ipSfM2sMXAyG2YlMbjKmIiOUBtnOfTla?=
 =?us-ascii?Q?GIvJIgKDWgq7/OjsD0ruA8qC9aNtimhPGi43zzSR2bZH7lUEXt/4zQQ1mpre?=
 =?us-ascii?Q?0MCiW4LC0iH/ws7fKiShAqjDc9iwpux/S8MjNfqr9hd17JGAvMdORDKCooKf?=
 =?us-ascii?Q?7rr+RDkAuAjQOJahXbBp7lZ3TDIkZ3ekXjDPn4PJ1HoUAzdj+OGkeyoCfX/s?=
 =?us-ascii?Q?XYgXOB6OXr4UR8ouabQhe93OLiRAezdTm234QVNJmtVmLGjJgNEoX/to+Ocd?=
 =?us-ascii?Q?RELZ+WHskplPVEpSFWN/chyIPMpZbSRdbHoG9AE+ByXPYLBBqiWoJBEtHFIo?=
 =?us-ascii?Q?sd7OMcS1Ah/d8+btDyRJuR4jNlKLFmTYynoGNBaxqFyFfTLwNHnhGAG1fVSe?=
 =?us-ascii?Q?wllZ+r+QCRwgguZ2ilCtlgxktekILrZFex4qc7fHHbLBUfibOx6vES5Pe8xH?=
 =?us-ascii?Q?daqC7XL+9ObmdPxX/jWic+xegLyiQ7532b7OgOBatgFn76HHixleqOUxUTQt?=
 =?us-ascii?Q?IuGcn2qRXxRgN9/jLqmFX3gjOQEBDCg7aNHmU7DZVcadtKWDuT70EgU+g+Ku?=
 =?us-ascii?Q?AXp5k7jV9P64C6ASH7sC43DyYi8YEfSm3PMn4r6B9IjnZEI1ig3lThQGe+Uk?=
 =?us-ascii?Q?aw7Bi9CTAzDKU9baCSVVrxrbx+R6UGhqzchuJu5ySxmbFdN054omRQmxHejO?=
 =?us-ascii?Q?2IxG/VSUQ+dQykuUum3fY5DZf78WSry69fpmBLbX5r7Fgkzk/2ou?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afe1bfdc-805e-485e-845a-08df49dc4a7f
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 03:37:40.3351 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: waiqe1+jFRJ5AR1DsEWszeViKk3j65KK5ouOHdl7ZlKdribgd8zSAqV3EQqj6b36aCRLECd8pPjZ4B/OvFPgEpFZpYCt2xyRr06R0b73FC4vt60ibnqQU59lIxXYqLQH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7049
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_FAIL,
	SPF_HELO_NONE autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

Please pull fsl-qoriq-for-2027-01-rc3

------------------------------------
Fix SCMI reset domain ID for sandbox
Constify scmi driver ops
Fix ls1021aiot boot and enable FIT
Add optional clock support in fspi
------------------------------------

CI: https://git.u-boot-project.org/u-boot/custodians/u-boot-fsl-qoriq/-/pipelines/2124

Thanks
Peng

The following changes since commit ece349ade2973e220f524ce59e59711cc919263f:

  Prepare v2026.07 (2026-07-06 17:50:43 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-fsl-qoriq.git tags/fsl-qoriq-for-2027-01-rc3

for you to fetch changes up to bc0acfc3cf24d56c03a8cd053276425f2d2d312b:

  firmware: scmi: Constify driver ops (2026-11-22 19:27:39 +0800)

----------------------------------------------------------------
Marek Vasut (2):
      firmware: scmi: sandbox: Fix SCMI reset domain ID
      firmware: scmi: Constify driver ops

Mateus Lima Alves (6):
      armv7: ls102xa: Apply erratum A-008850 on all LS1021A boards
      armv7: ls102xa: Terminate CCI-400 barriers before cpu_init_cp15
      configs: ls1021aiot_sdcard: Reserve 1 MiB for U-Boot in the SPL memory map
      configs: ls1021aiot: Enable FIT image support
      configs: ls1021aiot: Allow 64 MiB decompressed OS images
      board: nxp: ls1021aiot: Keep the IFC enabled in the OS device tree

Yixun Lan (1):
      spi: fsl_qspi: Add optional clock support

 arch/arm/cpu/armv7/ls102xa/Kconfig         |  2 +-
 arch/arm/cpu/armv7/ls102xa/soc.c           |  3 ---
 arch/arm/cpu/armv7/start.S                 |  6 ++++++
 arch/sandbox/dts/test.dts                  |  2 +-
 board/nxp/ls1021aiot/ls1021aiot.c          | 16 ++++++++++++++++
 configs/ls1021aiot_qspi_defconfig          |  3 +++
 configs/ls1021aiot_sdcard_defconfig        |  7 +++++--
 drivers/firmware/scmi/base.c               |  2 +-
 drivers/firmware/scmi/sandbox-scmi_agent.c |  2 +-
 drivers/spi/fsl_qspi.c                     | 25 +++++++++++++++++++++++++
 include/fsl_ddr_sdram.h                    |  4 ----
 include/fsl_immap.h                        |  4 ++++
 12 files changed, 63 insertions(+), 13 deletions(-)
