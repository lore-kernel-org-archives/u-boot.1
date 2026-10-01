Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12CDCA5FCB
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 13:05:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6E70A40A74;
	Thu,  1 Oct 2026 13:05:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zXXrx_k69bLE; Thu,  1 Oct 2026 13:05:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B645340AAB
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790859950;
	b=BUvfa3Ys2PTd/3pg7UYSad+at0wGA8onadgxFJQknu1RFmf/CGZYAFuEG42p7UodjuNz
	 UdktISVY39eQbpjf389VeNQ0STQKiZb8q3xavIC0YSEmy+J9e978oZ5oEcrY/6yacnsZo
	 5xVjb/UVEZRv0Wm7OY6hPlQtdv80keoAMI8wLQklsdqcR8dIYYm/hHi9aLaAxXSvAfzCa
	 Wg+0Ii9du8p4o+Td6CKsg4DH6OgHd5b6dNl8bE/WFTxFvsrp6coqecbF5fn2GxGvJ8wp9
	 6cVWEwb8dd1Hd8qnx2ULW24mL4RXzivnqRopx8cv8Hs/3/bneKZ11OiJGxqyPPm/YTQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790859950;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MjAI3Cv/nGcQ7kjKv5XY9aXrpmTzhQ3/goI6mtcUyus=;
	b=O4ira0Ft2S7l0yXh7hB85Cs11F0fOMp16+URQvZGsAldj6u1VmjhlRDvMBbbyAR+Camk
	 X2Z2EDPPwvOIy6QtAJCOlCLPhumnEaWpF7NkvNxrKpzFTnR702+uX21yAv4DUQxjNpqdI
	 5r4FCJkDU39Tqsm9zjccp9pBAJjpjnKU+9aVYhnEtHXSnCARQldfQYOcKfSsbzVtvw8/O
	 gY5GvV9vhinrtAN61zZyBsSf1uaTqreBv6dc6YHR9FntSES8WK93jdNfS4ZzkMRMK9fO2
	 ZbQe6rJ5mwhveDTWWphctmpitx/krsmn2yXwq5ivQzX9pgwJS/3IbCS5jkNG9ThPo1A==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=A2vXGef+;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790859950;
	bh=MjAI3Cv/nGcQ7kjKv5XY9aXrpmTzhQ3/goI6mtcUyus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g9VlljoX3xJwFviFpzY9edKXgfDdDu8GDRH6yjjVUTMe/19OYUby9tjRRhkpRHbMZ
	 OdgnSbcZbY7EpDUcVtql6vc/vx9kSTjrNLnNR8I7HngQodq6TQrjFQ1rFZKCW4PsBj
	 egKUwbZ69O2tR3KgoYwY083iRid3khGG897VyoM1GQc3jpNH6jbPWyY4mFGu25F1BW
	 vn6Sm4TmIHqVJJ7l7pypXse7zaKZq1Ow3bGw6BSoCz5GOnNCHhCRKF0Wf+IaVj2X7z
	 ZGR4bS/2f2d4KwMspvfhZO2JTxNH3jZd0pkZrf1ohIEAcNsvBcY64OyyuT7mr3ZaVk
	 IDnYChzmNuQSA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B645340AAB;
	Thu,  1 Oct 2026 13:05:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E1F7B282
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 13:05:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C788A40AAB
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 13:05:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ro_cKbjPfDcP for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 13:05:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CF1BD40A74
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790859948;
 b=f1ODYldAbVIGp79c4HmvCcYVmykmW8b75X1PoznuyZIY2n1c6vyuNkBuqmCjc8YWevtR
 QnumHmlo8VmI+FTwspNsmie8Fu2m5cwRkooKAl9Oz12N9DqJYc70JSKcKwtFdy3jVodtI
 W2WDSQP4+Ajfm3UMQN8yIrevTG2E1MY0sZLt6iZ84MOFNKzH6P56ezB9ALW0hExCLsdZy
 JrCMtbe7IhUtU1bN86ea2l+IrnmPM9QEZMYOVPkSRxc9be033E+fbg8JjySZE9XxuUyBb
 pgfzum8cW7gFFb1KTpkEef4oC/FTydTdg2RRvRk8pqckPRaaZRNydHoHabzYMAZb5Lw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790859948;
 h=Received-SPF:DKIM-Signature:Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:Content-Type:Content-Disposition:
 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:
 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=MjAI3Cv/nGcQ7kjKv5XY9aXrpmTzhQ3/goI6mtcUyus=;
 b=nL43LaFyQDVXxQmEKgoKQ7XDaJn3G04aRUIlgXvE9P9WFt/gHMVVnCuPH1ScW00dxa1n
 vBHmrF+HSvrNNtKVu/fkGIdIhKF/gj2mVNo3Nv7iqb7Y78dv345ch2KIJPzs9/6o/v9yU
 1jxSvFdJ9EINRGjermEkpi1gXRjKU1wA1tzjT+XKpPW3Kbkx20WO+H2p64k/+RFIziUj+
 yz8YMEiixVkF6T1LUyONBHqg9WLR3deezCwVZ3CTapdaR45AKHgENJ9w0mll35xqFxbfc
 ArACmhqDaMg4G0ooT9YFZXxH0BlCA8gDtvvVoGC5OGOGEaqIi6m848mOVb0OfEFSFIw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=nxp.com; 
 dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=A2vXGef+; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=vladimir.oltean@nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=A2vXGef+
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CF1BD40A74
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 13:05:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WVKsMrGZnhh3I2/ecm/pcUJ8JqqC+lH9MpHlzAFMRy4rBsKAS7L3EK/ZjDdv0HIs4v1U4p3BQ1jEuGEBukzhuAFO89nkaHQaqM6En4jsGSAZlqvejm7/Yg7moK5wfrpyj8dK0BzThjxZ5HtgIM0FYD96fvroHmd8bw9ocLAtGy/ewtSdGPqVwr8Oo7PXe/VRHQ/ZFLAa7Eo/fCwQRhFzaS2z49KClck20TxDL2PH/AlKozqfua4/Zl6GnByL+IZO3xaYvqfUUzvihnybLce75RMf9OxH59V/WMvRy4j/frRnixhkbafZ0tPhmmGBQIatPYJuTY+Li3wYBl45wyhFeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MjAI3Cv/nGcQ7kjKv5XY9aXrpmTzhQ3/goI6mtcUyus=;
 b=iy0y1ajksdSPaoEL2+kqI2t663dDM1HDksA1qe5N253WvDxas8DlpEdu0NWFlFNhrEQXFZLe8yYribUn0+VIRy9W2Zqf5BITRVs9oBgB2+xUV5IwKiHNmTAIiMTS7Brywe773VDPBOed4c76e0oElwbhPCjWEcjeH6Q7SJQqbyEwtRi9qv7k4CunwhTVVB60EfwhWD72KbweCD6uZCUWB/4B2Uu3SYt0nrpSuatg9ABaHQgtt0Sbs4L3uTWwBohbYXXJvwZbP1MV7Iw/JbR94GEEHhU0NtiSSz19Q+2jwI3ig0TRD7JPypnhv8CJFPgwJZQTSLGiRJ2++oscWdtY6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjAI3Cv/nGcQ7kjKv5XY9aXrpmTzhQ3/goI6mtcUyus=;
 b=A2vXGef+TDCzyjSigaTRjXTmurmu1YAauKZ4sFYKhzptLQKGxF0+Qgj0nrTnuKhRt5xFbJPtU1mrc+FR6EZdaOZin8W0PVA7Rb8gBQ+pPgyIcCXQYYgz3poxKP65pOj9Pn5xiNvtGfZwBr7IC6V1sBLBqC1UVaUUaNzwY6hNksSxZDm8645dkvShxjqGReNxYTKwaQzNxiUJLKXsrQWra6CmulQ9qeFIZxYESWa24qmBggiHRxCGKQCPfbQ1S1bbqnmSj0rtSJZJSTbeaBFL++VGsCYroWJVuGkIw0kT3eHWvVedyVVsOKY2ScyPajqf9EatjmyrvErzloA0xAMZPg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB6902.eurprd04.prod.outlook.com (2603:10a6:20b:107::20)
 by DBBPR04MB7723.eurprd04.prod.outlook.com (2603:10a6:10:20a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Thu, 1 Oct
 2026 13:05:42 +0000
Received: from AM7PR04MB6902.eurprd04.prod.outlook.com
 ([fe80::6d09:9d2a:f8c2:25e6]) by AM7PR04MB6902.eurprd04.prod.outlook.com
 ([fe80::6d09:9d2a:f8c2:25e6%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 13:05:42 +0000
Date: Thu, 1 Oct 2026 16:05:39 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>
Subject: Re: [PATCH v5 03/13] board: lx2160a: serdes: rename SPLIT_POLL_US to
 SRDS_POLL_US
Message-ID: <20261001130539.qge45vkide6vn2p5@skbuf>
References: <20260929175947.1379710-1-vjardin@free.fr>
 <20260929175947.1379710-4-vjardin@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929175947.1379710-4-vjardin@free.fr>
X-ClientProxiedBy: BE1P281CA0105.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:79::16) To AM7PR04MB6902.eurprd04.prod.outlook.com
 (2603:10a6:20b:107::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB6902:EE_|DBBPR04MB7723:EE_
X-MS-Office365-Filtering-Correlation-Id: c6a569fa-cd75-4ca8-0a5b-08df1fbcb2c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|366016|376014|19092799006|1800799024|22082099003|18002099003|4143699003|10067099003|56012099006|11063799006|15866825006|41080700001;
X-Microsoft-Antispam-Message-Info: eQCjq/NupFnYwCauXZaKkwNzCsf76MxXaSv9ILeG4wJ8Z5lVpPpSqh1wHLftqLRA+mp/FI5bVoJhKOlVS0qhC3ABZgry9+XeZ/Nz4LcLH/S5Ve5FX8s/3nRfMfX2p8x6Z8aarftEsJTUApBKtbXYJdzYCIivcs/LyuM81Q/1s8EFo1tUWgzcrdkjMfQ9VUuy0ZK6KzsjGzXQ/AZelvLVuk/0wJG2CgwA5dDj2nHudmWXxo0nIWUDbDaxg9fYsnRo2EWoc9HPCZ0jNg+PntaPrGJkPR0oIzJUTB/1OwyKWjlVItrHxbM6Dr2Jmlx4JWGJYdZGVU+aC18kcLShJQRJ83Ua/yMMSkxqRXKekW7PFVsHpz9Kv42YlxbJMivE5ZGtv3kcnGUvZXKDDvn3UCx7nRVzLnX0OZRgnBWQNIhKA4jUdIWLswDaSv2RARWxIHfXrl0tiE99cFjQOnLgvRJIWRaPtu3jPSXRlhjTLaKSTzEjfiFCdmKJqTWVmS6muEfk5XGNNN8EnP8uEbJ2xl0a5bJA9EKdPnY2foDeWsEeDwbScj3/bR6q4W1ICrV0bLugPHnSee5H/OwfGSj1xarZ04frhb8/kZuCvbhPts+k7mezsa0YjwOpa+d9PsiwoIIkKfroyt77Sb750S0jj5rUme8hmpiQo7XM3wVFNJsBD4dForv9NA9+cYr0TBpYt02DMh0PkfRYFNuxYAPbAM73oreeCwEfrt2QvzkbXuRv6LKvz6AcYrgVTFOAJChoZfgj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR04MB6902.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(366016)(376014)(19092799006)(1800799024)(22082099003)(18002099003)(4143699003)(10067099003)(56012099006)(11063799006)(15866825006)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zClUQgDC02bLtHHE8hx3uviSzvpifKFNxJ2WxBqxPNebDc7bgf2DnMsYtXJ4?=
 =?us-ascii?Q?Ly0TLAM2kijj0P/Iue5704ZXypvwZJLKP+lZFsihaPh/lE2TzbOPLxOisEQ1?=
 =?us-ascii?Q?Au89B2KR5zfv/33Al8gtQgqvZaQAwUCNhfkag15FuT/XFAuITHZ9Iv56Djhc?=
 =?us-ascii?Q?bQQ5zZU3xY8KCr+c6Hy6hXCHai7uRLRyHUUVVo2VbxBAt4oMS6ttU6fhGNTF?=
 =?us-ascii?Q?g0Y/LIbhZXh6aEpybRBflkjhQp3pI7Z45ppIiwcoLsj4dU3vsDghfYv1RB0A?=
 =?us-ascii?Q?HbXVHRf6ENQXXpRUJkON41tNZiWwozzhLt0khiP4kGsvZhQCjWyMki2P4Pqf?=
 =?us-ascii?Q?BwZYUT0FQWBONTnNQ9k9bd1BfESRp7WRFZt2KJohBwseEawicD+FOlzTDbWN?=
 =?us-ascii?Q?ovWEuFC0lreFq2OMKE5f7WkxWq/SoHH6T8tYsofBiCAp+t9w1j+rLqBK4CJk?=
 =?us-ascii?Q?wjiyNCyNFSYHDkIWplOi1eFYIvtsWC8J+8dqX2zphLCiIG4Apdz2rPEyQ5r/?=
 =?us-ascii?Q?+XfV5TMuzgEKpNxvMEUeKkMO0S0VqrI+TxEqLRaezUmQ3S6JW6yTeQFlY/7l?=
 =?us-ascii?Q?iMrIkoFbwkS05MQaTI2ZsT6XSnUj7/xpDeiTzO9PbFYAM17xoZRt3PKWVNd6?=
 =?us-ascii?Q?8/x+Ix/dt99bKd8ZDkaFR2aTJIyzP460pFobNN+1gLWBdN3uOBRfko2df8G2?=
 =?us-ascii?Q?8wgutLB3f6jH0pRuAmHfGlOtRWunGcjZE1C1SuDB3xzI9Se7Nij4/n34+/+M?=
 =?us-ascii?Q?n1fKjhislOHBFVvg6n9PG05unEkIPGoXCq1MLOnIMNT/cvsmMhPy5GkCEwtn?=
 =?us-ascii?Q?4Z/eTqvPs26ViUHTYcoXO9I6TPUPEryvhsYFhex7gMrc8yPGDupHi6JPqddv?=
 =?us-ascii?Q?77otCXorAU78r+I2aBcmr+l0/ePF2ia8uDZpSG7icOXo2OlO5xIyLA+yKRhV?=
 =?us-ascii?Q?luEKZ3o3UNepKTCIYFI6RCwTyHQQIye71/U1mE7nxR3rjbfUEb/kF+vToS8n?=
 =?us-ascii?Q?ZK8vnTttGBIxWSMAC9SxO2SD7m78Q8U+3CQvUZ8879i99txyRd5PAfxiGoNG?=
 =?us-ascii?Q?wG2MLIS4wkZU51g6M3rphA5YYzfcw+ofKhBz01TOl/wZZIWuaFzBmuLkn104?=
 =?us-ascii?Q?Gb4lz/6odx/VqMD8dGSb89zJxPLli2aWEnYxZ89Dvva6LviUmqzwmw7ed+11?=
 =?us-ascii?Q?eHCqhI5RIOwIIogXlmwyPwFZgPGy9FEJKjQZqGtvhA1q4QDglmRO4Re5pira?=
 =?us-ascii?Q?aeTubIkZ/rcQEot5ZbrOX3z8n61HCXYOv2QUYDrK6/kHClz8BIvrDwGONIFM?=
 =?us-ascii?Q?yIJFt4ugY/ZQglVOXnRnajWvBaAwaBgsHAT09s/Vo8xJ08fSL2XFpUB1dUpb?=
 =?us-ascii?Q?L4iwfW7XO8RShT2VmkknCsz0DxDYgDhqTWjHXqOdGRoc96LGkopXh7FS41q5?=
 =?us-ascii?Q?7H5/IwMSSGgpRrCh4MgLCRLH4JCsPi6ZNAQO307vmom3ahAJiJF7Ix5LgTK4?=
 =?us-ascii?Q?Gxld5lxef+25/x/coxLIRS/frCmGf6dNrL0iG8Kv/Irlid19K2HujjWmWJP4?=
 =?us-ascii?Q?VJJ6n01pjy7w1v356+jOvtkdAucwdBFvHQIGEwV0K6YfDKlUSZ4w/2rQENgf?=
 =?us-ascii?Q?PJdF1dPVTtVEwY9Ab6iun9U2l+32Af9XbtrP4Comd/EV7JlnPlbyLd/4x2i3?=
 =?us-ascii?Q?H1GAAIgisE/+7oOc1F6OlbtWp5w3l8nexxuI1MaQl88qOn7hyonpWTPhbTM4?=
 =?us-ascii?Q?xHRJS02K6cqQA5qI9eeR9/mY4gp/GEB+l/M79vYgQT0mGqGQg99elHg5HHGf?=
X-MS-Exchange-AntiSpam-MessageData-1: 60OVBT/2daDJSDWbVUfwBWN4JOWaeW3KpIA=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a569fa-cd75-4ca8-0a5b-08df1fbcb2c5
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6902.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 13:05:42.5291 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wfq8D6OUiTTbSXJgPzgD8WgYAB930+W0pPcJNkvQgJCl4yP/2ayvjz9GXS/NYiwfW/U4EL6sV/mJm6h0fIuMWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7723
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Tue, Sep 29, 2026 at 07:59:35PM +0200, Vincent Jardin wrote:
> The poll bound is not specific to the split.
> 
> No functional change.
> 
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> 
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
