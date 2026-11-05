Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE210606A326
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 02:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Z8va/MdX;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=K3y3T7RB
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 86B2980FD8;
	Thu,  5 Nov 2026 02:44:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vDmAfHu9ZZ52; Thu,  5 Nov 2026 02:44:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D66E780CBA
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793846672;
	b=j0+Q4+cHxPbcJqnqbYM+6eft6XXjkHNesqiZ7qHC4MMm4lRssu34IPP+11SSQ/+0TP0O
	 IPx0fHKlyXyl+Vx6WhcugxEu5IPxdAtphNVAayYJXEq8uWZHyUjuv4QM+kcuNco6PaTCv
	 iOC8m/rd2rEzNukg1+oXBu+8TFzn6PtppYtd/xcI3qY3uSdy+h7JseAkId+3EPXglZXrd
	 hoCH9ATXiNMXDRkyvmdTrkN/sk27Z7mDsb6x5a0HqIbEVQxszzGpVXD1kQhE9k2/ugl8g
	 ZFFNhJw8mNCG5C+8SD7LmR0nC22cEW0rjo9bIKXOl//lrbHoyGFp8YqksaYS3sxomEA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793846672;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
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
	bh=wXt7UgE32EMD/shys1zge1w3QOsIomL97foVmXVLH8A=;
	b=b/l+aV8IAwz44EJa7tzLbn6vgyzzIlsmBK8TOkPhm8oUErRlJAOlLRjZ8sswyModi+4X
	 KIGjBTHwrZvfrVsD97AobsbD8AJUTXybxlmdSlBDBDVt6/kKNdr9aKASc8WXDFR3O9wUp
	 RCO+M7q8VRhMf0cAozpnKYdAU3yt2uviee9S4NEUhYKwid4IkzbxfRf0Dze0mHXHlQB4b
	 xHuHjx2im3T3JFguBLIEVk9QHezi9Cj/MWZmJy6OgzWplZqNlAhBya3XyREYF0FFPiUxS
	 LVZYtAo7SiKEqw3mciQJozmu+OCImgZORfz4yThMshifUynGDJHmufTpBTkYeKr1+dQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793846672;
	bh=wXt7UgE32EMD/shys1zge1w3QOsIomL97foVmXVLH8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z8va/MdXbajJru+WV61rjQi+ThT5l/gtcE68S290k4AJE0VSa56th6NakMvvZj8vH
	 PHLp2ZZpSWAkBAPjeySgDUVKzjgWHxYyJkRf8aCwav2IkfTqE8amF781r6Li3LkVq6
	 GeHsgReYftzkuat45P/eDAKutGcJXpVs+DZtL1c2UqX0rmC05mdE3tHciUIVo15D8p
	 mHW4ipmxRrbg1xVnrkfhrkD9dAOku/ZUQPPHzXSkP0in6ocRzq0ikK8k31lbz04TkD
	 NXKHYMKnExwhcgM/6KONxA8pBZruJWA/ZpF9yKtDeJ0UavRrPi9gtimK0F30iF1xcf
	 zaSb1jtKl0Z6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D66E780CBA;
	Thu,  5 Nov 2026 02:44:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D203952B
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 02:44:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CF4C5606E8
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 02:44:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jQt3C7naCOv6 for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 02:44:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 32905606D3
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp3.osuosl.org; spf=fail smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=K3y3T7RB
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 32905606D3
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 02:44:27 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6405D8482B; Thu,  5 Nov 2026 03:44:24 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20F3484820
 for <u-boot@lists.denx.de>; Thu,  5 Nov 2026 03:44:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXt7UgE32EMD/shys1zge1w3QOsIomL97foVmXVLH8A=;
 b=K3y3T7RBEjR8OKI+HvudYe8FYKB7jqrj9EpGWwaaIy9OiOaz086Qrd2o0K+X0+6hKl1AT3Zx8zkUHIKjzgVStsjLAU68BLo/uTGNtZQGYQ9rZpApvs+r3BgJbH8qohcQ2AkBR4VX8D7Hcf5bTp3z8lFlQ2o0OsoQf79qlBYJkEWZMwx6iZi2PcKDrCn/4A/IcwigXyjdkM4c5eO+eL5EPlFC7Kzi3eoV5tmYIh6/S2J/F6fquPkIOZG75emVMu46THD+5uTczTZC2WielijmLDk1NPVmhtVL78U93aqFb8ngqYFtacEP7hiALCEv/BKoQX81E5y4cq5ixB1DjQlViw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PAWPR04MB9985.eurprd04.prod.outlook.com (2603:10a6:102:385::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 02:44:14 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 02:44:14 +0000
Date: Thu, 5 Nov 2026 10:40:54 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Mateus Lima Alves <mateuslima.ti@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Alison Wang <alison.wang@nxp.com>
Subject: Re: [PATCH] configs: ls1021aiot_sdcard: Limit the U-Boot image to 1
 MiB
Message-ID: <auvstk3A7DDC-GeA@nxa18884-linux-1.ap.freescale.net>
References: <20261026040403.1863907-1-mateuslima.ti@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026040403.1863907-1-mateuslima.ti@gmail.com>
X-ClientProxiedBy: SI3PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:295::9) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PAWPR04MB9985:EE_
X-MS-Office365-Filtering-Correlation-Id: c46d3dcf-4d13-465f-cb72-08df3ae6adb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|19092799006|5023799004|11063799006|56012099006|261021121427099003|261022075727099003|261028144727099003|261102123227099003|261026140227099003|261022115727099003|261022105027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: u6pzb1AbvxFD7G02P1yjqDQ+LWVqnFIQKJafGRh6nWCq6HxSPJtUE93QOZ5gWkdilhALk6I2kNTyu5/w5TcvFmBQTGvOX0X6YsKdD34ANN7Pv4lWLfJXr7gl4k3jUHIdkDaWu3k8rxTs6AhSN/u1ekEu49II9joOagI2Z6VBfARXkcgMdfEUeCDuEx6QoUg//SVD5XQO0CIvZXE2Zw0KQWRv08zAs0ZWG7vLK54HdFYyvHYq77dWpvD1gxvuqTI+OXwYL+qKoysiZTFh7fKO+06NfQJzcWePHBJjjzcqgfzisn9DQFEfvGYdZsgmUBtm0noQIkhuDN9x6s6XQXyXquV/xA1XzLVpfX8xW6u+jFwPM1nyWbn6dLKWiONtjftkbfLTiWz4ncUkA3JcMoYC4g2r6bNW50qa/cpFj/Lfbix5KwBolBoZFQAbg2FEf0ue26h7IBmZZLiq2bUD/7+bhWPCuLK1Ai43HD5lrXlnT+Ghcytk7Ok4Lx2eZuXWr0+dge7jGmZWJB3qIsYXXaXi/gpYvoZx7IL9YBAHsnWTd6KyMTqolRpe8JbdOSzh574k8to/7RhAXOtBruqH76OJScPnF3IyQBKMzwBzbaADE90AsGT3uA8nyLMq5YKsuRQS1Ca94NO4OW0XbnEng6hgHBS0wgLpoVGmFeyA9i9UMeo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(19092799006)(5023799004)(11063799006)(56012099006)(261021121427099003)(261022075727099003)(261028144727099003)(261102123227099003)(261026140227099003)(261022115727099003)(261022105027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4HHK5GAAmeJmvql78YR1Sx8U3T3T0Pcg8JzTE2ncFgjRijvF4HyamYFpflsc?=
 =?us-ascii?Q?J24mqQDqF1GCY+ZZKK8T3T1cLfNVGzivdXIYqXStVTZmz1/FXb95LtBboXkG?=
 =?us-ascii?Q?R0gyl5esinw2xTqb6Nv5pZPDIgVSpHILdFk4PzYQ93Ejsf2rAAWuTLG34ld8?=
 =?us-ascii?Q?N92Mi5namLcOZEKcTixabrH18wjaGW41tp6O0XIdIHDTKQYOWFwOQqK79FzJ?=
 =?us-ascii?Q?SAEFH5KHKbKA/Wb9FX7+YK0twCdRg4mqfMdOw95ePkUnv4tq7K5chQuf2ZxP?=
 =?us-ascii?Q?421EV/hbq6VmlmmsCJiInpnbxQWHBpw0UXX2oddsjr/41IqJMW6AzgRlEybx?=
 =?us-ascii?Q?EeIEBlVjCFBbOP6Dmue0lfZI3JWnYkeHDM1tHCgr3T+BdK1LuI667Z6uFo8v?=
 =?us-ascii?Q?HTkKiLdXdK97OAnk3dAc/jac74UlGdu5iSfw5lU6pqdoW3lUxL7kYLkvxR5b?=
 =?us-ascii?Q?P+0oPp45LO5LaZVMm5V+4zwD9gxytsn7l8C1QZu2qdgH6YKmLVBAkwAzUqoy?=
 =?us-ascii?Q?qKqC7+CAPYkzxMNC5fS4Dr4rkckZ0tmbOzmsufKqsl/YpZUDzwcifHGn0CLx?=
 =?us-ascii?Q?meccwJoq+KjuzvQK6lCAi7AUB69ge8b/wPO8IJpKISF4QGpgMEvUfFC44M6L?=
 =?us-ascii?Q?1efeh23CduW2+7IkGxc0E3XH7FprswYH5/L1a2KOJCO8LQCBp3SFRb4ci5sT?=
 =?us-ascii?Q?YCFu0PvAyy1aUg3yeDTtlaFHrPHcwXdK9zBWvUsW78545FUlllfpPqdbW89z?=
 =?us-ascii?Q?34HgBh+eNdiaMJcZaLx0BjiyynWa5z/4cmIWmJEzAcGZcZ1hc69t0letnxuW?=
 =?us-ascii?Q?knxoqUbK6IueroZXQt54YQsB+0IIoBgQurpoSVqWS1WdECLd084/PkXDlJ1O?=
 =?us-ascii?Q?VcOSpGknINykc0e/nmP0TIlSs6nYAuDVX8We5pq/a2ojiaLIv6hKdoBYqb1r?=
 =?us-ascii?Q?Ib/A4QwbT1G/Dl2f+4rWKJfVjNOsC9uks6fkDJM+xpBNuGvoWLY4aoDNpBQZ?=
 =?us-ascii?Q?Tkyx90jc/Juyy9AX4iqIO8xmFzk5Sz9N6OjsSnOxeoVaPpz+fcyzoWRpslOm?=
 =?us-ascii?Q?jl3iQUEgC/E0fib/VMO85O2VUtp1eyTLXwvimArXNYiaOXQbky59Zsr7FABf?=
 =?us-ascii?Q?Xna/NXzAANNIJXNiQavm3OTlVDbWoKuRHhxivrkdzr1BWOkf39+o3vXjoBDJ?=
 =?us-ascii?Q?+K1tEiyDclgYATEX5EnMvsYIQJct2SByFZDT3CofW5tIyMckL8Al70L8+lz/?=
 =?us-ascii?Q?p3iU6v/KG5QIiAjFlBEXgN/0vbFvlWtXaGv4ZmP//7THCqT6cXsxfTtkhbBC?=
 =?us-ascii?Q?+SGvwukARqZCyUHsbcQjF4BTb6M0QYMzAcH5r6DpocP8OVHBuK+FtusYa/DN?=
 =?us-ascii?Q?V7taumxHcBS7TX98MWc6d5G3E3F0NGCOJp4gClaQj6u6+4KlJzL6VHapReEd?=
 =?us-ascii?Q?6/g8jwsEzRmo38LqUnQx1f9SGVIr1ieC1BACQvAv4jtRFgZqZQ1Rsi135AO4?=
 =?us-ascii?Q?Gz16H9QGyjEn00fH0ZRFZIhZQrSer7Bxcp9ahTSixQzAlIic/CqGV10PfYNq?=
 =?us-ascii?Q?E6/UfBP791XHPGIZ5dKpqoCtxpmtdbki55DFT35wnmsM4iRdPifctSHoHYzR?=
 =?us-ascii?Q?PDO+FrXI7v7GRTPg9+Ti+tU0gPNlld8/Iqurzroc54qjKjMB5fN9vVeGlZFF?=
 =?us-ascii?Q?pHsFfJKcl8dWyFtvfVuTrbjc/Chhw4bdTpM9ky1Prv/2tTeogNgS8DyPkTg7?=
 =?us-ascii?Q?ypfxSGwouWWSUGGdKw1sgqMKMHkN1NtOzLD9chyUh9oWAo6rszSY?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c46d3dcf-4d13-465f-cb72-08df3ae6adb8
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 02:44:14.2519 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gCfLCI79aAZHQLMpF2nwZhW3FvNoWiCLMtj3g3EaZkmrSBz1JmwgiqYCICIfmR8p1hmEgkQveD/iJLT0KxMjGnr8bZ39JZdRb/Rukqx0xFw1qE5mayfDias8y3FH1aRr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9985
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 01:04:03AM -0300, Mateus Lima Alves wrote:
>The SPL of the LS1021A-IoT board loads U-Boot to 0x82000000 and keeps
>its malloc pool right after the CONFIG_SYS_MONITOR_LEN bytes reserved
>for it. When U-Boot outgrew that space it overwrote the pool and the
>SPL took a data abort at boot, with nothing at build time to tell.
>
>Enable BOARD_SIZE_LIMIT with the size of that space, 1 MiB, so that an
>image that no longer fits fails to link instead.
>
>Suggested-by: Tom Rini <trini@konsulko.com>
>Signed-off-by: Mateus Lima Alves <mateuslima.ti@gmail.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
