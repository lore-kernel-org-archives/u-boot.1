Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD47C88E64
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 11:34:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 78D5640638;
	Mon, 14 Sep 2026 11:34:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HaeLunJ7F_0d; Mon, 14 Sep 2026 11:34:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 96C5840603
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789385652;
	b=pOa5vFP6FYKHSE9nAlUj0jHyD9RghC3d6eeXObWK4eD7h3otEqVZiB0HR7PbPDEDnANV
	 KZnMqKqbMi0VSnLOZvWEz25YjeGqgKqkqEH+lVFxQhy3zuhKDbJA3euj9wE0pMbKwhrzy
	 +C2YPC96GB29p1zUGHhbUzALsimpVj9WitEE5QvcV5jmoSWBUadpZaQ00LHsJEWgZSXym
	 JB66u9mh4dLa66PTgEn+DNqBPZIGVKD92MXhdohmJcqQi55xZegbMcpNvbooa3Zn0A9qN
	 DpEIIgpcWLCus6YTKo/2AUmLRs2uzxFJHqizIAtafubKmuxxdpxRTB/ATbZDCWkJYXw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789385652;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 Content-Type:Content-Disposition:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=99L9St5iz8lc/mRMQzyi7wglUXEsicJv1VtUh3BYOJg=;
	b=A4AdmCHrQ8jhyshUAmVy7EjH1dUalELpeel1OQCnmgaCBRKGUA7en38L76rMVZ/iIIun
	 X2GhLAKPvSnQGSOrsuOqq8RPQ73CHaUxFUZ9/e6oUvOMfQmXwsA9NnbqSz6hU0uhX22g/
	 W2aUANaTLhsvKhOW/JpMEvNGC0Pk6VHMNpPAtnKB4rjzHZj1XYNwKuCkNnvuPIGO9II8B
	 /OY7uAw22bk5KZ5kHBPgeF3xQNj9xWKYBYGiE4Qavr+h+K7/e6nUiZG+XYwAbepM5UuIe
	 /rxxsaBJxS/GiCwK9H90xgsV+B+TY68Q4BN2qKJ9IkJVwyElM3BNvZN6uTUYdw5JC7g==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789385652;
	bh=99L9St5iz8lc/mRMQzyi7wglUXEsicJv1VtUh3BYOJg=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FocmSqQmtbI1ygMmnDsK4evAMpz/agQ/m6MuLzOyjsylFZZ7KpYKFlXA24da1qene
	 vUuYz7MYFKpKXMvi+5fE017oMjmJq2c9kEBYPLIKoKekZvJz/kUPzUpaBR/JrwxfeQ
	 yHXmgv4Evi1ev6HnVh//GZylEdpCxJWwpg/cNm7SquJimf4udEqq6b7+znmiMxo/Lu
	 3K3eJNDadduK/TiONQDYV67SJhx5JPxHVPqvWtHO29wRMks58pwUzbQwABOrM7tuuE
	 eWOQDjuzNffZ81DNME4LsvTvIRuATdfxgXkPa4krtFIk21JwzLb7SXTGMORdzelti9
	 B0xOSzpIm5XtQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 96C5840603;
	Mon, 14 Sep 2026 11:34:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B64FD465
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:34:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A79AE60689
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:34:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wai-EMMDnlTd for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 11:34:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9A6D960606
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789385650;
 b=kRCTKmiVnNguYjzEcwRAQlL9EtDwTxvOMEmknDMUUE9SEfW8vodUSbdZMj4E7vSYrBmv
 +0ThC78iqGZo3Mg4U5a5sy6GKyEE5fYlH/TSWO/pTlxF4E3nyt2wSI8Lxnxnqo+1qVnb2
 IbwGPWRheYili8tH97G4QHFyrVap7jfMDPBMsEPDnS4wt6R0C79atq+gPuRIRHRVfq8Aa
 czdg2Ru0IkBoeBWQwIg/MJrWYMESiCwwOAESSRcgatEfe89w3ADcWpgKsNwaI/j9d9RGt
 veAUNMsy0HdZPfkMNnKAzOlKK3C7HO/P1KLz95a5mw+rt5vfWw7oPu/6Cq5mPM/uvkA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789385650;
 h=Received-SPF:DKIM-Signature:Received:Received:Date:From:To:Cc:
 Subject:Message-ID:Content-Type:Content-Disposition:X-ClientProxiedBy:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=99L9St5iz8lc/mRMQzyi7wglUXEsicJv1VtUh3BYOJg=;
 b=YhIskfFV7l8qLvA+OXXJZTWknBY8ZgjPkSqU2wsvyZxiVbij+8w1K/Mut7zb1jgnejRK
 fj1zJtHlBmDCP3wf1dM6yLE0FPasLlqdv8vMpaRG2dhAms3Z6nVxDvYv32bYwROpW6smh
 zZ92goBPZdOAatvbBoF6piupf/zdTlagrafKVPlJw+gtPqsT8KVLkrOQsfMSrRlV25A3E
 BonnCYnVaFVDGWHdwaFeViYCUcJLH9RAID2yuoIsIBys0c2sZWnH/1x9AzyF2jDD65dy5
 ZyoN6XwEBvN7ZVPPB3h/SSg9YuQdxhgOKNFXofmqNLNxRGRi2k5bPHnQH3tzC1R5etA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=fail header.from=oss.nxp.com; 
 dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=OLsoCsZY;
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com
 header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-NXP1-onmicrosoft-com header.b=OLsoCsZY
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9A6D960606
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:34:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V07/Sh9Hj5WVI57DTgQ4qyUkqL49fHkDcAAjjsZoPngOjNI8NSeJQ/60ouqgQ/nfjVizhC2x58xdb1qrhOMhnH3logw6Fn/utHCQmCzfT0f193M3DHKOXu9JSrSXeBQJECI3ZRsazKTh94syYoh2T+YOSiWOvmznEfODaCfYmbXNxyQAQxUD+IlJuA2t2rmDo6gEzdqHOMQU1dwUg+5J7aJxtQ3ZOoTVHRKrsqxH21/BBNsCUKa3kv8oaEaYiq9dZZ1YkPtxx1jgC/NnxELtrj8yMAfNuIkxKGvdUkM8fm75SHn1mdP6UsmL0aorHdbzH2mRfvwc5ohnJ9zelte/kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99L9St5iz8lc/mRMQzyi7wglUXEsicJv1VtUh3BYOJg=;
 b=KNzK+aAYLYwc4U9P6mcCtyQioFaqUlcUjil1lSepRkDHGaI/UI3bV3frJFZoM8RNfqbLDtPlNunyHMElcl8nAA+3gasPtABTLDJE60+lOtXlyHODi2LejPXXU326OcWhUzfeflw0FznCdvHIaK4GyUhmEZenqOly1AYhYqdRM1bGQhdudswg9ZlKkk2on+g/FTkll676d75qsW3QNojK4kf7u9nMv81fiyZhSYEr5gLKjhc4V5cfhpoBPud4Oj5Qpj6Mc8DvaMfZNXazAnfF4MBC7YKgZdWEIa/FSwwxF6AHOfZqasM58m6Pe1YhfBJ8YiyK0PaR3O7dHohH41g75w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99L9St5iz8lc/mRMQzyi7wglUXEsicJv1VtUh3BYOJg=;
 b=OLsoCsZY729unDsQmZdc1ZJi3uDdXQoUHvfnG89NTkzJxjjs6FjhL4eIiVuCgq2Cn0uFoNKZ30R7u7RpbO3ZtPxlz2HX5mTYCFie3YWeppmMarz+cDr1fw4HbADcS84Z5Bgcs8M8Rf1cYA1rhVgBZbhnVIUKbhqV8WBEO8jIya6fM1NNc/Ky9ZMCpwZBYQtZIU8lf5IWiZVeczszd19BBYP9BzT6sZTw+mSnFcKSsSKyTyZemGBLEWTKQre5lIcv2PgDjMSOT2/thrhgs9JfZf3bWWa7p98joMJorhrhGXn51iFCeI96SCF2d5auh7vFPNkx0YQBU0A/FL6qogmd+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by DB9PR04MB11600.eurprd04.prod.outlook.com (2603:10a6:10:60f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 11:34:06 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 11:34:06 +0000
Date: Mon, 14 Sep 2026 19:31:48 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Andrei Lalaev <andrey.lalaev@gmail.com>,
 Torsten Rupp <torsten.rupp@8tronix.de>
Subject: [GIT PULL] Please pull mmc-next-2026-09-14
Message-ID: <aqfbJA4BEdYc9B7R@nxa18884-linux-1.ap.freescale.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: MA5P287CA0171.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1af::15) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|DB9PR04MB11600:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ed4d7e5-d153-4b78-453f-08df125415aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|19092799006|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: X6fNQGp+qE30KNkPQHo4iN6PE1MMmgaQ/GWhyPcc6tnH7rxQgpD5xAROxGOdyBXyCdrAvaXkohJa2Zd+CEnPuYgkCWTK92W67amS7uuZ8jt9n00nYypfb/ZC9lY53B6y1CCAuE04MiBExD1rRDso/qYxPlf9W27GeHkiGxUsYBz/AhlcmpmKtmVJYR6GLvAJjLIustnJGVohTZHwZkWjInuoZCv0syOPHmwHUMIDftTOBWAVAIoE4oP632ehqZQ3Cj0b29WZAtgjaXXytsHt4N44H5K1bJGAhiczKNk+avzhLhibQ4+0Lb4h9dXtE0+G5hJr+HUN5ggWam7VDcd8aA11oN6WhBWkwFIIMhrlzlwmgj2bKEr4qoau2LRej9CP+liYurhbEKHVA9wKDrY9d4LHQJAX5MFQ6lDO6wmL8F2mvIRIngQSu5eDIzdD3tVPKyT0kY2XjmMKLUidc+HPQj+U+z4XojJZpwddFefRXO+O8IZd01oe6Aa9wuPcRU/XMhwplCQKV2JZN4IqOyC8ydI2AO8D9O18Lnly6fpGNNyHKxN3Ehyi+qos12znat+le4P1GfLW07CS9StqG+HN9T/vHz/ZWe2pNiuAABhMqRIETAcRXmk1x7AZbmjo2Nfw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(19092799006)(11063799006)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KM/sEXE1ehefiDtG2XiTysXChwVUNKVqzZVV3AhwgjTjFxFo+PtdmNe8dmhc?=
 =?us-ascii?Q?7466zuDrhl20hPM0cHD7tW8oUY8P9fRnCitSZnn6wjmMxloT3pg0EePUN8ic?=
 =?us-ascii?Q?fCMdbNElbW0bFlaP/omgwOiqkcPamovG55la2sQKzO6v8pp5lenBrU/8vILx?=
 =?us-ascii?Q?hePjutw/YxwhMOQpGwoKdLxRXNiLsRpNBXDoPrIjCZ0At40rNIXgkb3gB0LK?=
 =?us-ascii?Q?fRfWAVwAZ6Q+i/6CtzH3prTHEQzcEl+1e+L0e11hUoXhgfyfZtBEAcDYC0I5?=
 =?us-ascii?Q?p1tcRsIX4pYaGTnNVvCMWt9r1ZDCbHEX8cSnCzZBds1dTOvfSsfU0RD+it21?=
 =?us-ascii?Q?m8+qetGN2hrgcu0BE3GZ2FDzLWZNGufqqNQATrdtcGFv9k4V6m55AS9W7mel?=
 =?us-ascii?Q?4evXVCqeRJ57TE+OaniGqHwtTltfWm3/ZcINv8sAvGGvimA3EjhYwVjURUOF?=
 =?us-ascii?Q?NNOmSiwbVgnSTImECKmB8VI2rMvGtm3Y4kmnn/K3TJ8pzSVAsArzSNq1hd8v?=
 =?us-ascii?Q?kAq56evUA4E1tPukxVKaxgiqkcHse48T34mfRlJp8G5UTQn0CeSygQ9XHLa4?=
 =?us-ascii?Q?MgVExsZXmBDSlj2ecBjGepwVDS2Y0FqsBm+4h3DCZ6s71FG8WHn+QY+j62P8?=
 =?us-ascii?Q?7wJ081Sq/a7+HPiyu9QdPvV04Q8uSGzw+0l1nFHc5CNYQNkTg7vneeeRkiRz?=
 =?us-ascii?Q?Y+8BjMspMQ0IG8h2Vkyczzh2hZyfJeU8DHT+jzbrh01Wb+5H/tct5gSPnK0A?=
 =?us-ascii?Q?17873Y/yxpPQZQOTQ4BAiH8XundBtQ3+PUGvdGisRO9HtOArmmrvziWxVnkg?=
 =?us-ascii?Q?RnE8wst6ZaofMfBFVuO8oNpwqCwNpCUs+Sep1s22crgVGw/zZ3HFqr4IX4Wb?=
 =?us-ascii?Q?JqWj4pyeTY3PNnNRaMCJu/eWaj3QEfNzlxkMuLbT4gRR8g5bwjhRwXrPBUhY?=
 =?us-ascii?Q?8gOOqf2D4nawB4hqcFDiCfxNPH4DZ16U9yfuharp6u3GQ5TVV0NqDws2Ta16?=
 =?us-ascii?Q?uJ1Y7xOvJAodsmIt8/KqtZNHOMhwIz4Urb9oNzEysHUPRqumBhzURYx6Staj?=
 =?us-ascii?Q?l+DzvFVU62m9VPT7SFIVXD6ztozp7oh+S3MKCyWAsDr0AqYDJ05S3fryv85k?=
 =?us-ascii?Q?0BmPvCy+3O9iSxGBcWt4c820NlOFPlYIbtHqFaaheVWCTbW0wZ8b90dRuVhv?=
 =?us-ascii?Q?2QAg9rcV+Bfl3h3Yi23gldcs1TzwDXbzBB53r3iSE46NnVURjfhV4ElpNrBP?=
 =?us-ascii?Q?toO/4JDSJ+/Cp1wnSaHsLIfB8smwXsUJzr0RwmA9zjcMwbC49Vu10Dt2t7Oj?=
 =?us-ascii?Q?x9ZONQZIux5cqydut2PfCgSHB/GiQXyhub0BmId8JDkaOoML0mCBARkixncJ?=
 =?us-ascii?Q?8jm/mVNlq48uqXzuh8CXUceMiG8WIF3iTd9NTFI0yuGyyco1EYtp0kSN5why?=
 =?us-ascii?Q?6eb4WOEy1nCWHlKnPWRsjPm2OaeopJSK1C0wAHcmHN1uLPUQc6UMTElBsf7p?=
 =?us-ascii?Q?Vl+kTnnJd2+Yq56cBD7E18TMlHWpCKQezgukTpuCfhV0eipCuFEhfD3UfYiu?=
 =?us-ascii?Q?vRoL6+ABG2gphyf9bJ3cKc6hcQMCrcnzR+IcYRuUVeT582cVd8h6UPQaBUhr?=
 =?us-ascii?Q?gqc3Yy57QT1njcHaPE2mQJcUdiopvjJLdU4+mLyRPV9svYl6GyounO2KKssg?=
 =?us-ascii?Q?8ozLFGPILTbWcK3uMtms2q7WfHrIac45UGKCPulgVdIxF2EQ2gsQn3XPoSfH?=
 =?us-ascii?Q?o3AzI5OD83FiCl63O8YcRjFUCQRyyj4Yvm4rpnudzor3Gqb8I3Hc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed4d7e5-d153-4b78-453f-08df125415aa
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 11:34:06.1047 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W1Gq6X58erCfRFsVpfjA0qyWmlb0/fxSsgCl9B+V3e7e5SI9eBjcyak8e2iSxe0FPqIfBY2nIhbg1PcZPolt93iJkVPMF5b6HhHHryxOFOsN1KG9iqkuQsEY93RldMQa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11600
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

Judith Mendez <jm@ti.com>, Minwoo Park <mw.park@telechips.com>, Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Bcc: 
Subject: [GIT PULL] Please pull mmc-next-2026-09-14
Reply-To: 

Hi Tom,

Please pull mmc-next-2026-09-14 for next

-----------------------------------------------------------------
configure SDHCI PHY for cv1800b_sdhci
Add power-off-delay-us support for slow RC discharge
add option to skip eMMC deinit on OS handoff
Add Kathpalia as a reviewer
fix 32bit silent truncation of 64bit offset in mmc_get_env_addr()
-----------------------------------------------------------------

CI: https://git.u-boot-project.org/u-boot/custodians/u-boot-mmc/-/pipelines/1276

Thanks,
Peng

The following changes since commit ff22b8227d2531e3698ef1e2623805d0bfb20bbb:

  Merge patch series "fit: cipher: bounds checks on the ciphered image path" (2026-09-11 17:20:14 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-mmc.git tags/mmc-next-2026-09-14

for you to fetch changes up to 2f949f2463d89b38f7c2eec8169a1722d77b18cf:

  mmc: cv1800b_sdhci: configure SDHCI PHY (2026-09-14 17:51:31 +0800)

----------------------------------------------------------------
Andrei Lalaev (1):
      mmc: cv1800b_sdhci: configure SDHCI PHY

Judith Mendez (1):
      mmc: core: Add power-off-delay-us support for slow RC discharge

Minwoo Park (1):
      mmc: add option to skip eMMC deinit on OS handoff

Tanmay Kathpalia (1):
      MAINTAINERS: mmc: Add myself as a reviewer

Torsten Rupp (1):
      mmc: fix 32bit silent truncation of 64bit offset in mmc_get_env_addr()

 MAINTAINERS                             |  1 +
 board/kontron/osm-s-mx8mp/osm-s-mx8mp.c |  2 +-
 board/kontron/osm-s-mx93/osm-s-mx93.c   |  2 +-
 board/kontron/sl-mx8mm/sl-mx8mm.c       |  2 +-
 board/nxp/common/sdhc_boot.c            |  2 +-
 drivers/mmc/Kconfig                     | 24 ++++++++++++++++++++++++
 drivers/mmc/cv1800b_sdhci.c             | 30 +++++++++++++++++++++++++++++-
 drivers/mmc/mmc.c                       | 11 +++++++++++
 env/mmc.c                               | 10 +++++-----
 include/mmc.h                           |  2 +-
 10 files changed, 75 insertions(+), 11 deletions(-)
