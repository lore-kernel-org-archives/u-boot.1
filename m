Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D322C88E7F
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 15:52:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A1CF180C50;
	Tue, 15 Sep 2026 15:52:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yoIDj4tK8CGN; Tue, 15 Sep 2026 15:52:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org ACC7280C87
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789487530;
	b=XNKdtJ8NjNcnSN3ePNv6ccyqcR7BqGi+6SXNolNNUw9FwJMwaDGxN8y7G8hzMOJagVIp
	 vNQIo08JL4aqy82GvqPszNNKBsUF2uh1TOXlRo3Fvt8t3k7T7YYjJf6rO1mqAHP5W5vhJ
	 i1Ohnd8riUu8gmtLkJc7GTD0ZH/UfqjCz6czBtLUFf6dgEnwgToMJsWsrjn71OIzp3IrS
	 SoG49gcm+32TIVj8gAgTYhWpexjBPxybDtlKkL6+5SP+eKyPi/Vi5OX9jKo+iVIFcy7Oj
	 XvWqr0ba/k4mEXtuKrfxvO/7Jvfc51V96BskN40xipe4dujB2mF3QOgSG51X1zpvUsQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789487530;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=SNZK5zvJkboZf77WFxp13KH9qEH0czH6XjXpfEn3khs=;
	b=OlMZ82iG5+/l+++08JJ+DlzgZr4cMhpTBg4Ea3aOCtNFXcmrnNPIy08ABsVe5UNl9dO3
	 Seo2QgU5xLUe395ZjKhvMtfTM+Vvb/PEcGNHXAR/ilKb4/ccgClw4LbMFwAdFw41ABT2H
	 Uql8Kecz7URqYhjHIQG2W49iijAr2wn81huuSupBvpW37xilcy6mdU+m5BAb56I2f5io7
	 K6+1MDnWrBNjN2qcLujhAgxsyWTKuE52PAvrooPq+R1AhdgdALjn2miCqFMdOmN0SojV2
	 RjoYiCvPjKkuPpkH4KMnilwVWXYBGkSL8075CiXtYCQjCXio2+v7bG0H2aLSQzaKQaw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=emteria.com;
	dkim=pass header.d=emteria.com header.i=@emteria.com header.a=rsa-sha256 header.s=selector1 header.b=XxdsiFR4;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789487530;
	bh=SNZK5zvJkboZf77WFxp13KH9qEH0czH6XjXpfEn3khs=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZddwfD+RhojCdK8SLIW1w2pYKlM/t1F9+JNRkPB6smea1eoDNwdsjhpOgpWF62u38
	 YxmWoKdeeuUaAhBtkPVLZr+rSXtQj2acGfv17qA6qZPoUu5iLWqrUW8cRXJs78RRmI
	 YuFZl0G7gbQZ1hnOjl9UWwLEAdbGpgtJ+24iLHAjmAuib4WZ5afKbWKVDvMxYdJyDO
	 6WBIbba5LWxQxuxPF3poSFuxQ3c/1zymNIBAlQII6ZfuoXf4oXx0RwI/qbu4c/IJB6
	 33cnwdtrBjRd1aN2E1Vf5/K5IJ2R6zGVhjWrbLPYrVKo2dNgEV4+ShWShem0f9IzMh
	 S7DDX+VwauVpg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id ACC7280C87;
	Tue, 15 Sep 2026 15:52:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id F221DEB
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 14:56:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D79B680A89
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 14:56:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qm_OdM25k7Yf for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 14:56:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AF07C80A87
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789484216;
 b=PoiZpE6jDyu5GZ5TTY0A7srMSkrfadefkt4xG1Jwq21bZrOrgNi8CuhmhUiwOf70LVFk
 pClraNWXxdNEZhCqj7lCxVwvaRqUekjEFJE57cFeWBYT/flv/t3KIbP/sy4HjJbR+SkJA
 dBL8I2YdOrQEh19x4ZALbEYXUxSA6sYazS1dXd5WNbXxMc/mCRVj9/eiA2G/bcFTFFv34
 kePjnMtXkpA21Tq4nrroIMXX5vrbtW/l9UOVdqKHTCdv0Juj8ytOfeV/kYqRki3vFOFP0
 Bt1LRz+Z4U/0ohF+kwOp3mQNdu9jOLUtVIZ6VMhpNckarvrHJ88cnSP2VmgAqu50qsA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789484216;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=SNZK5zvJkboZf77WFxp13KH9qEH0czH6XjXpfEn3khs=;
 b=OPbMf/K9jtN44GcazSPkrmd/hhVFxDdNKxR4x6QCbwDyGGEg9kpqXvtY9Z7/DtAYbS8V
 fNzAmvIyfRR6CBRUIPDIV6cKz7JJV1hUDN/Wy2i3aHMboNffwfEKidoRHegR/R8EU/Ff6
 O+INu2Tlw84tZ3r7y/9EHL54BJqLX3/7WuSKjRkuJ7YM42wlpVXxBJADz8XYFPUeg0TgV
 v1fl+OSnSp1Rm0Mb/5IQJsmHKKeCtrdXqLG6ApMRDeKrWXShO6+woBSqfYK88JJypk0gF
 ROdlfGyXq/N/oU9DL4AciecZ3FBI6X88tLLRaoDbFE5nA5GDoPImMUteFDQnUYSp02g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=emteria.com; 
 dkim=pass header.d=emteria.com header.i=@emteria.com header.a=rsa-sha256
 header.s=selector1 header.b=XxdsiFR4; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=jan.kehren@emteria.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=emteria.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=emteria.com header.i=@emteria.com header.a=rsa-sha256
 header.s=selector1 header.b=XxdsiFR4
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AF07C80A87
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 14:56:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fo5FvUKu93Ln9UdlapN4YXU1SUztQ69E3qNWmQ/lYiS+r1yCe+VYNxGOEsL4sGkc65nbxaJ9Fo77ycS5fJuu6Gfo/jk9UkLjnfPqLyz/Kc/cUyO7NaNg6cMijQ/14xQuK+38gRZPI8sFRCV0giuTY6z1PpVtFr196/31hi6slUGw2KpL971ZfSmlSY9Bw6xEgC7Jcw1Pts4aREf3tJ6LRbeSJC5JI4AIpMhN5mL3cJfXhn2jLjP5z48qdUPcn5pNydSV9gAkZ4cwlTb35dm1uLnfT0ILqCUiHT7DbiYPN/7mauJobqqmTiFLHmFn0d0ZywK5MX+qlJZUuztsKGrSEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNZK5zvJkboZf77WFxp13KH9qEH0czH6XjXpfEn3khs=;
 b=FrIIohAN7DN35lxW2Ec37jQ9vJhucTwbbRJqMjSlVIzblfzzRl80O31hgz+mN1FS68TPV9IkGAokH7bgFaRyfx9Fs3VifWsTcZkk4DpdZQPFf5D4YtiJzpp0UWacYrJDkYOf+XO2AZi7HZSfkVPfQnTqh2fyZTQgU7GJI3ofDGJMSM31H/tYW6C7L5gcQA5N837cmsUsrZDppaoWGa9ow20nxjrkYmRQICVA2t1lZsckzpw7OB9BboQamlsACM8yzVmER2EJ8j7YQmDE65pnXQsdNMfvihajoa4NY0WNv5dvzQEGP3y44Fj8LdhHRLTx7lD81etPRiQnnPPVjlOjWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=emteria.com; dmarc=pass action=none header.from=emteria.com;
 dkim=pass header.d=emteria.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emteria.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNZK5zvJkboZf77WFxp13KH9qEH0czH6XjXpfEn3khs=;
 b=XxdsiFR4+nzPc9AR9wnKYiOTgErYie8hXfNErKKNjo6NlKH3zOehGsFK976dNavGnOklUBpyyFw6dNDF8K4/pnBlIsYfB5tNXLctb044cSkG6MoQVlGkSFs/gMAK4C01AMyp/YZxfXk5FktYcSxLWwcRi0cwlXAYz3hXh34edqI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=emteria.com;
Received: from AM6PR04MB6662.eurprd04.prod.outlook.com (2603:10a6:20b:ff::15)
 by PAXPR04MB9219.eurprd04.prod.outlook.com (2603:10a6:102:222::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 14:56:46 +0000
Received: from AM6PR04MB6662.eurprd04.prod.outlook.com
 ([fe80::8a0e:d777:59b6:f25d]) by AM6PR04MB6662.eurprd04.prod.outlook.com
 ([fe80::8a0e:d777:59b6:f25d%6]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 14:56:46 +0000
From: Jan Kehren <jan.kehren@emteria.com>
To: u-boot@lists.u-boot-project.org
Cc: mkorpershoek@kernel.org, igor.opaniuk@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Jan Kehren <jan.kehren@emteria.com>
Subject: [PATCH] avb: Take a storage interface in the AVB operations
Date: Tue, 15 Sep 2026 16:56:29 +0200
Message-ID: <20260915145629.995499-1-jan.kehren@emteria.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0334.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::10) To AM6PR04MB6662.eurprd04.prod.outlook.com
 (2603:10a6:20b:ff::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6662:EE_|PAXPR04MB9219:EE_
X-MS-Office365-Filtering-Correlation-Id: 6506dee9-aba8-4be5-6c67-08df13398fd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|23010399003|1800799024|376014|366016|10070799003|6133799003|18002099003|3023799007|5023799004|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: ACTpMCbnz85GS74DCfHGyLZ8EZftg0poAoUJ9aI404gtl6zQ4nhPdTRL29/zi6DKWQA3OsTXJvxgwcALcqwixGCqRK8MvFRYEp0v7QGjCEAmmVTIm+/2Ld0C5gVtPnZxyiH2IW5d7Trjx7UzT2ls56xi3FerjR0Jyit5rLGMVkNjgi8Mhpg7pJ1icGHto5E900vMZGHje3wR3JaZawchym96zgUBSh3aVRcHdjMXlONgQnZscrV3MZnkx4mgeHhlmkojVOuNF4DiLt1jWSfg+QlLHBqVHav+yt4K20t4tpHoqd34CErsBG4oi7in8Ia5VTVpjDtK69IQIvZXcrCYMVTviscp95DxfFUoUBU21RMqyfqkB32k3TYfQYS/rlQd6FciRqhG1SNtxj5lmP24h5Tka2AcSickacEtTRT5DZii61LqUK0EtWYwvT5Bi55WSanDxcSraLbKT4EuC/cryiwG5xhyXgQMaXRO0YWK+zWPl79Zsp9zUmGkIIhkpy9hYMm829s2ssAYrUE4LKZaAcUT/KmmPrkmNl4D6/NaZWVV1BTUOv0E/IvCncgzAfbklz7YJC5hWH9y9RVSspjusKKk0xZy12+6+oquqHT9KYUu80ifCTYjI6knBHOa8HcEBBRVes0Aai77FcmqGzpXpDQCRC4Y+1aO7diMfSXQrVA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR04MB6662.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(23010399003)(1800799024)(376014)(366016)(10070799003)(6133799003)(18002099003)(3023799007)(5023799004)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lSAczJt0QdqREr0J9agu7AK12QemtNvahaS2lKxV68uy8R+y8Ny562wRRA5s?=
 =?us-ascii?Q?Sgtemb8iRM3nehhUOAImg9gz61LYP8yh5pSrHX07m2uEl4yQuLrJT5UOv/lO?=
 =?us-ascii?Q?/0psM9or9bOlmsMlx3zc9kx640qPKHiR1hkkxcMrf/ZieHdAO3u3idgaIMDE?=
 =?us-ascii?Q?PIcpAcaQ8PQNpyTe2WjF7r64Ky8e6AZxb8g96Z/iwhNe1jFzki8svIC1m6Y7?=
 =?us-ascii?Q?dcIH5yctTQdAVFQsT+rCXvpgZxRj//4v/YQp3WxD/EBv7HI+/5ypA4mS4TcS?=
 =?us-ascii?Q?S6DuhqjvHy22qi4nwgYJhT0UCQi9hAUNGNRc+nvLksSOSapr0v2uJdksjExs?=
 =?us-ascii?Q?OIworqcDAx6y8HkrVhrE45FwI6IY9Mf+ujUDulzDglZW6jqL5IRNgfebJDpU?=
 =?us-ascii?Q?pWbqae2Nej8T2CnqkjUMCUu4JXx/+f1oRg0csniYkMQLeyEtAeQoC93kx0gd?=
 =?us-ascii?Q?yNy2B/kclGv27YxpzV4fcz8bPO/7F2hJQ/SG+fGBY+S66Nn3nmEeLPe/SHFR?=
 =?us-ascii?Q?HenQ2vsm/61bDwEv2k1pUtFNUJks1OYJDiR8ReavAvYCVRbsOgPyJ+0Y3fVJ?=
 =?us-ascii?Q?SWvi88Pr5Ws+ztqnhoeeYsX1ve0KSIZ1oPyJdY5OsQt0DNvLOkmXCyLdFzks?=
 =?us-ascii?Q?G3C2WRql4LfwkK2j9y23JQdlLCWSHUe/5OZXLJH6gVUFyqRehsePvaA5cxdv?=
 =?us-ascii?Q?9+cFnYilOw/yEwbI02VHtCwYTtbC3HwYYnEOaNSlIFORJhAb0T6Sbjfe0h5q?=
 =?us-ascii?Q?Dmu+xBVg2gFGmL+aRTTYuysBODRcFcf8fXEM5B7OVWjm8L1h5r/rDVqLlXtc?=
 =?us-ascii?Q?8t79UbhKhRxE1v9dybOYLbl+WdVg6vkXt3zt/CKlnTT3D66Fgf9BADaKmbU4?=
 =?us-ascii?Q?zeXSWwM0suf8s7K1pmiumOTJh9phbcrJelLjpXPa6xXHzVTEFagsMV8Yccu3?=
 =?us-ascii?Q?Vja/Y/W66xC6ZY5xpam90J2MjQVDwW2KUR7D16i+SGTPU69C1rLh5qD+gJqF?=
 =?us-ascii?Q?qNHsCLhfrX5CGkzgstrbMETxNm+n8Vjn9AWg7ISj55uovXqRCCptbdgGBLHp?=
 =?us-ascii?Q?mL/OEOdPnr5wn6iRvZ/vQu0kt8zlLK36TR+8kjVQaCCBuv55cjVXY7Te3TLL?=
 =?us-ascii?Q?pajBEybls1oO2RkjPM8ztvvyN4Oca6rFuB1nidB0DaohXi7Uqh83/fiIfaq6?=
 =?us-ascii?Q?DGRefIXEOYoZ9WF1qRuqKmibHeTFzmVY04bHDoSQik5T3GZBIadNRYF8WBSe?=
 =?us-ascii?Q?iEYypy8OqmfPfGYkDSYXmf0M1jxWO+N01eIbwBVfcm09OL79vW1xO2dlKiJO?=
 =?us-ascii?Q?o8MxBM7dT0vK82Nw8ejI9PE2FQuUVymF8/pM1PNoAzfe2M4LZd1Ntzym813b?=
 =?us-ascii?Q?1vPre6nsRLk8NM5zA2zRQA+Xwxv7vfgbFZlwOlPE56AmdO4qwC7gy9ErbDeE?=
 =?us-ascii?Q?hOIE6z5ze0RglJGCpNlaOIRR2WI+NL2589DZ8WPfc4vyYLeuq4ckKSxzn+Do?=
 =?us-ascii?Q?QqtFwn9M4qykcDpgYBxn6Eyqn8C2O9DiIlMR9H9T5x0gSDBMYtbDTiUcYLtw?=
 =?us-ascii?Q?zjQhop1sq8DahruCzClmD0Gp/3c+l1MiFsIbzodfyNDT6YhzUoceKLm2Bq55?=
 =?us-ascii?Q?8lWPHZ70VaRP9F72wYscP1xG5wkAV93XrIEpSDRTqGOYDMDcYuvlypb4Ix+Y?=
 =?us-ascii?Q?6WFqumQbtllV7mQF0PshQTR29oxfow3DSM9AMc/ygS6TdbAsS7lCG/ydiKZv?=
 =?us-ascii?Q?oq+ddso6e4mTamEUICfaBqbMKEBZQwgBkV81ew1IH8HlSw87tsZ4XSOKzl+c?=
X-MS-Exchange-AntiSpam-MessageData-1: 4KM/YBFDUmB/1g==
X-OriginatorOrg: emteria.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6506dee9-aba8-4be5-6c67-08df13398fd5
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6662.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 14:56:46.0766 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e416006-a062-4a38-99be-aba82ce308ae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3v9VuC1ID8MQewpzyk9It9dDm5gcVIfGrI9VtO7TRL1VGOLja3+7JCvoK+5y58QFFQFqL7DOGrHqohCz7WkyfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9219
X-Mailman-Approved-At: Tue, 15 Sep 2026 15:52:02 +0000
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

AVB assumed its partitions were on mmc: avb_ops_alloc() took a bare device
number and get_partition() called find_mmc_device(). bootmeth_android
accepts any bootdev but passes only desc->devnum, so an Android bootflow
found on nvme 0 or usb 0 is verified against mmc 0.

Carry a uclass id alongside the device number and resolve the block device
with blk_get_devnum_by_uclass_id(), keeping mmc_init() and the hardware
partition switch on the mmc path only. "avb init <dev>" still means mmc,
"avb init <interface> <dev>" selects another bus, and both now look the
device up before allocating. get_boot_interface() returns UCLASS_INVALID
without ops, so a caller that skipped "avb init" fails rather than reading
mmc.

The IO helpers and struct mmc_part only ever used struct blk_desc, so
rename them avb_blk_read(), avb_blk_write() and struct avb_blk_part.

Signed-off-by: Jan Kehren <jan.kehren@emteria.com>
---
Prior art: this is the third attempt at the same change. Both earlier ones
stalled without a design objection being raised.

  https://lore.kernel.org/u-boot/20220926220211.868968-1-adelva@google.com/
  https://lore.kernel.org/u-boot/20220801080717.9899-3-andrii_chepurnyi@epam.com/

The first carries Reviewed-by: Simon Glass. Review asked for the in-tree
"avb init" callers to be updated, plus docs and tests, and the v2 never
came. That version made the interface argument mandatory, which is what
broke the callers; keeping "avb init <dev>" as mmc avoids the problem, so
no caller changes and board/ti/am57xx/am57xx.env keeps working as is.

AVB_VERIFY keeps its "depends on MMC": the mmc bring-up path still calls
into the mmc core. Dropping it needs IS_ENABLED(CONFIG_MMC) guards and is
left as a separate change.

"avb init" still parses <dev> as hex, as it always has, and the help text
now says so. Happy to switch the new interface form to decimal to match
every other block command if that is preferred.

Tested on Raspberry Pi 4 and Raspberry Pi 5, verifying and booting Android
from SD on both and from USB mass storage on the Pi 4. Those boards boot
through a downstream command rather than bootstd, so the bootmeth_android
hunk is build tested only.

On the Pi 4 "avb init usb 0" then "avb verify _a" passes, "avb init 0" still
resolves to mmc, and an unknown interface or an out-of-range index on either
bus is rejected without disturbing ops that were already initialised.

Build tested with khadas-vim3_android_defconfig and
khadas-vim3l_android_ab_defconfig, both AVB_VERIFY=y CMD_AVB=y
BOOTMETH_ANDROID=y. checkpatch --strict is clean apart from two CamelCase
notes on libavb's own AvbOps/AvbIOResult types.

 boot/bootmeth_android.c                |   2 +-
 cmd/avb.c                              |  24 +++-
 common/Kconfig                         |   7 +-
 common/avb_verify.c                    | 168 ++++++++++++++-----------
 doc/android/avb2.rst                   |   7 +-
 include/avb_verify.h                   |  38 ++++--
 test/py/tests/test_android/test_avb.py |  28 +++++
 7 files changed, 182 insertions(+), 92 deletions(-)

diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
index 0db08d4f86..ae05c08488 100644
--- a/boot/bootmeth_android.c
+++ b/boot/bootmeth_android.c
@@ -443,7 +443,7 @@ static int run_avb_verification(struct bootflow *bflow)
 	bool unlocked = false;
 	int ret;
 
-	avb_ops = avb_ops_alloc(desc->devnum);
+	avb_ops = avb_ops_alloc(desc->uclass_id, desc->devnum);
 	if (!avb_ops)
 		return log_msg_ret("avb ops", -ENOMEM);
 
diff --git a/cmd/avb.c b/cmd/avb.c
index 8fbd48ee5a..9381c2aa68 100644
--- a/cmd/avb.c
+++ b/cmd/avb.c
@@ -16,17 +16,28 @@ static struct AvbOps *avb_ops;
 
 int do_avb_init(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	unsigned long mmc_dev;
+	struct blk_desc *desc;
 
-	if (argc != 2)
+	if (argc < 2 || argc > 3)
 		return CMD_RET_USAGE;
 
-	mmc_dev = hextoul(argv[1], NULL);
+	/* "avb init <dev>" keeps its old meaning of mmc <dev> */
+	if (argc == 3)
+		desc = blk_get_devnum_by_uclass_idname(argv[1],
+						       hextoul(argv[2], NULL));
+	else
+		desc = blk_get_devnum_by_uclass_id(UCLASS_MMC,
+						   hextoul(argv[1], NULL));
+
+	if (!desc) {
+		printf("Can't find the requested device\n");
+		return CMD_RET_FAILURE;
+	}
 
 	if (avb_ops)
 		avb_ops_free(avb_ops);
 
-	avb_ops = avb_ops_alloc(mmc_dev);
+	avb_ops = avb_ops_alloc(desc->uclass_id, desc->devnum);
 	if (avb_ops)
 		return CMD_RET_SUCCESS;
 	else
@@ -428,7 +439,7 @@ int do_avb_write_pvalue(struct cmd_tbl *cmdtp, int flag, int argc,
 }
 
 static struct cmd_tbl cmd_avb[] = {
-	U_BOOT_CMD_MKENT(init, 2, 0, do_avb_init, "", ""),
+	U_BOOT_CMD_MKENT(init, 3, 0, do_avb_init, "", ""),
 	U_BOOT_CMD_MKENT(read_rb, 2, 0, do_avb_read_rb, "", ""),
 	U_BOOT_CMD_MKENT(write_rb, 3, 0, do_avb_write_rb, "", ""),
 	U_BOOT_CMD_MKENT(is_unlocked, 1, 0, do_avb_is_unlocked, "", ""),
@@ -464,7 +475,8 @@ static int do_avb(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 U_BOOT_CMD(
 	avb, 29, 0, do_avb,
 	"Provides commands for testing Android Verified Boot 2.0 functionality",
-	"init <dev> - initialize avb2 for <dev>\n"
+	"init [<interface>] <dev> - initialize avb2 for hex <dev> on <interface>\n"
+	"    (mmc, nvme, usb, ...; defaults to mmc)\n"
 	"avb read_rb <num> - read rollback index at location <num>\n"
 	"avb write_rb <num> <rb> - write rollback index <rb> to <num>\n"
 	"avb is_unlocked - returns unlock status of the device\n"
diff --git a/common/Kconfig b/common/Kconfig
index c739225621..5590fbfdb2 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -885,9 +885,14 @@ config AVB_VERIFY
 	  This option enables compilation of bootloader-dependent operations,
 	  used by Android Verified Boot 2.0 library (libavb). Includes:
 	  * Helpers to process strings in order to build OS bootargs.
-	  * Helpers to access MMC, similar to drivers/fastboot/fb_mmc.c.
+	  * Helpers to access block devices, similar to
+	    drivers/fastboot/fb_mmc.c.
 	  * Helpers to alloc/init/free avb ops.
 
+	  Only mmc is initialised by AVB itself. Any other interface must
+	  already be enumerated when AVB runs, either by the board code or by
+	  a command such as "usb start".
+
 if AVB_VERIFY
 
 config AVB_BUF_ADDR
diff --git a/common/avb_verify.c b/common/avb_verify.c
index b96cd1ebd7..6be34db129 100644
--- a/common/avb_verify.c
+++ b/common/avb_verify.c
@@ -8,6 +8,7 @@
 #include <cpu_func.h>
 #include <image.h>
 #include <malloc.h>
+#include <mmc.h>
 #include <part.h>
 #include <tee.h>
 #include <tee/optee_ta_avb.h>
@@ -304,13 +305,13 @@ char *avb_set_enforce_verity(const char *cmdline)
 
 /**
  * ============================================================================
- * IO(mmc) auxiliary functions
+ * Block IO auxiliary functions
  * ============================================================================
  */
-static unsigned long mmc_read_and_flush(struct mmc_part *part,
-					lbaint_t start,
-					lbaint_t sectors,
-					void *buffer)
+static unsigned long avb_blk_read(struct avb_blk_part *part,
+				  lbaint_t start,
+				  lbaint_t sectors,
+				  void *buffer)
 {
 	unsigned long blks;
 	void *tmp_buf;
@@ -342,7 +343,7 @@ static unsigned long mmc_read_and_flush(struct mmc_part *part,
 		tmp_buf = buffer;
 	}
 
-	blks = blk_dread(part->mmc_blk,
+	blks = blk_dread(part->blk,
 			 start, sectors, tmp_buf);
 	/* flush cache after read */
 	flush_cache((ulong)tmp_buf, sectors * part->info.blksz);
@@ -353,8 +354,8 @@ static unsigned long mmc_read_and_flush(struct mmc_part *part,
 	return blks;
 }
 
-static unsigned long mmc_write(struct mmc_part *part, lbaint_t start,
-			       lbaint_t sectors, void *buffer)
+static unsigned long avb_blk_write(struct avb_blk_part *part, lbaint_t start,
+				   lbaint_t sectors, void *buffer)
 {
 	void *tmp_buf;
 	size_t buf_size;
@@ -382,59 +383,83 @@ static unsigned long mmc_write(struct mmc_part *part, lbaint_t start,
 		tmp_buf = buffer;
 	}
 
-	return blk_dwrite(part->mmc_blk,
+	return blk_dwrite(part->blk,
 			  start, sectors, tmp_buf);
 }
 
-static struct mmc_part *get_partition(AvbOps *ops, const char *partition)
+/* Hardware partition 0 is the user area, where the GPT and our images live */
+static int avb_init_mmc(int dev_num)
 {
-	int ret;
-	u8 dev_num;
 	int part_num = 0;
-	struct mmc_part *part;
-	struct blk_desc *mmc_blk;
-
-	part = malloc(sizeof(struct mmc_part));
-	if (!part)
-		return NULL;
+	struct mmc *mmc;
+	int ret;
 
-	dev_num = get_boot_device(ops);
-	part->mmc = find_mmc_device(dev_num);
-	if (!part->mmc) {
+	mmc = find_mmc_device(dev_num);
+	if (!mmc) {
 		printf("%s: no MMC device at slot %x\n", __func__, dev_num);
-		goto err;
+		return -ENODEV;
 	}
 
-	ret = mmc_init(part->mmc);
+	ret = mmc_init(mmc);
 	if (ret) {
 		printf("%s: MMC initialization failed, err = %d\n",
 		       __func__, ret);
-		goto err;
+		return ret;
 	}
 
-	if (IS_MMC(part->mmc)) {
-		ret = mmc_switch_part(part->mmc, part_num);
+	if (IS_MMC(mmc)) {
+		ret = mmc_switch_part(mmc, part_num);
 		if (ret) {
 			printf("%s: MMC part switch failed, err = %d\n",
 			       __func__, ret);
-			goto err;
+			return ret;
 		}
 	}
 
-	mmc_blk = mmc_get_blk_desc(part->mmc);
-	if (!mmc_blk) {
-		printf("%s: failed to obtain block descriptor\n", __func__);
+	return 0;
+}
+
+static struct avb_blk_part *get_partition(AvbOps *ops, const char *partition)
+{
+	int ret;
+	int dev_num;
+	enum uclass_id uclass_id;
+	struct avb_blk_part *part;
+	struct blk_desc *blk;
+
+	part = malloc(sizeof(struct avb_blk_part));
+	if (!part)
+		return NULL;
+
+	dev_num = get_boot_device(ops);
+	uclass_id = get_boot_interface(ops);
+	if (uclass_id == UCLASS_INVALID || dev_num < 0) {
+		printf("%s: no storage interface, run 'avb init' first\n",
+		       __func__);
+		goto err;
+	}
+
+	if (uclass_id == UCLASS_MMC) {
+		ret = avb_init_mmc(dev_num);
+		if (ret)
+			goto err;
+	}
+
+	blk = blk_get_devnum_by_uclass_id(uclass_id, dev_num);
+	if (!blk) {
+		/* Every bus but mmc must already be started when AVB runs */
+		printf("%s: no %s device %d, is the bus started?\n", __func__,
+		       blk_get_uclass_name(uclass_id), dev_num);
 		goto err;
 	}
 
-	ret = part_get_info_by_name(mmc_blk, partition, &part->info);
+	ret = part_get_info_by_name(blk, partition, &part->info);
 	if (ret < 0) {
 		printf("%s: can't find partition '%s'\n", __func__, partition);
 		goto err;
 	}
 
-	part->dev_num = dev_num;
-	part->mmc_blk = mmc_blk;
+	part->blk = blk;
 
 	return part;
 err:
@@ -442,22 +467,22 @@ err:
 	return NULL;
 }
 
-static AvbIOResult mmc_byte_io(AvbOps *ops,
-			       const char *partition,
-			       s64 offset,
-			       size_t num_bytes,
-			       void *buffer,
-			       size_t *out_num_read,
-			       enum mmc_io_type io_type)
+static AvbIOResult avb_blk_byte_io(AvbOps *ops,
+				   const char *partition,
+				   s64 offset,
+				   size_t num_bytes,
+				   void *buffer,
+				   size_t *out_num_read,
+				   enum avb_io_type io_type)
 {
 	ulong ret;
-	struct mmc_part *part;
+	struct avb_blk_part *part;
 	u64 start_offset, start_sector, sectors, residue;
 	u8 *tmp_buf;
 	size_t io_cnt = 0;
 	AvbIOResult io_ret = AVB_IO_RESULT_OK;
 
-	if (!partition || !buffer || io_type > IO_WRITE)
+	if (!partition || !buffer || io_type > AVB_IO_WRITE)
 		return AVB_IO_RESULT_ERROR_IO;
 
 	part = get_partition(ops, partition);
@@ -486,11 +511,11 @@ static AvbIOResult mmc_byte_io(AvbOps *ops,
 				residue = num_bytes;
 			}
 
-			if (io_type == IO_READ) {
-				ret = mmc_read_and_flush(part,
-							 part->info.start +
-							 start_sector,
-							 1, tmp_buf);
+			if (io_type == AVB_IO_READ) {
+				ret = avb_blk_read(part,
+						   part->info.start +
+						   start_sector,
+						   1, tmp_buf);
 
 				if (ret != 1) {
 					printf("%s: read error (%ld, %lld)\n",
@@ -505,10 +530,10 @@ static AvbIOResult mmc_byte_io(AvbOps *ops,
 				tmp_buf += (start_offset % part->info.blksz);
 				memcpy(buffer, (void *)tmp_buf, residue);
 			} else {
-				ret = mmc_read_and_flush(part,
-							 part->info.start +
-							 start_sector,
-							 1, tmp_buf);
+				ret = avb_blk_read(part,
+						   part->info.start +
+						   start_sector,
+						   1, tmp_buf);
 
 				if (ret != 1) {
 					printf("%s: read error (%ld, %lld)\n",
@@ -520,8 +545,8 @@ static AvbIOResult mmc_byte_io(AvbOps *ops,
 					start_offset % part->info.blksz,
 					buffer, residue);
 
-				ret = mmc_write(part, part->info.start +
-						start_sector, 1, tmp_buf);
+				ret = avb_blk_write(part, part->info.start +
+						    start_sector, 1, tmp_buf);
 				if (ret != 1) {
 					printf("%s: write error (%ld, %lld)\n",
 					       __func__, ret, start_sector);
@@ -538,16 +563,16 @@ static AvbIOResult mmc_byte_io(AvbOps *ops,
 		}
 
 		if (sectors) {
-			if (io_type == IO_READ) {
-				ret = mmc_read_and_flush(part,
-							 part->info.start +
-							 start_sector,
-							 sectors, buffer);
+			if (io_type == AVB_IO_READ) {
+				ret = avb_blk_read(part,
+						   part->info.start +
+						   start_sector,
+						   sectors, buffer);
 			} else {
-				ret = mmc_write(part,
-						part->info.start +
-						start_sector,
-						sectors, buffer);
+				ret = avb_blk_write(part,
+						    part->info.start +
+						    start_sector,
+						    sectors, buffer);
 			}
 
 			if (!ret) {
@@ -564,7 +589,7 @@ static AvbIOResult mmc_byte_io(AvbOps *ops,
 	}
 
 	/* Set counter for read operation */
-	if (io_type == IO_READ && out_num_read)
+	if (io_type == AVB_IO_READ && out_num_read)
 		*out_num_read = io_cnt;
 
 out:
@@ -603,8 +628,8 @@ static AvbIOResult read_from_partition(AvbOps *ops,
 				       void *buffer,
 				       size_t *out_num_read)
 {
-	return mmc_byte_io(ops, partition_name, offset_from_partition,
-			   num_bytes, buffer, out_num_read, IO_READ);
+	return avb_blk_byte_io(ops, partition_name, offset_from_partition,
+			       num_bytes, buffer, out_num_read, AVB_IO_READ);
 }
 
 /**
@@ -630,8 +655,8 @@ static AvbIOResult write_to_partition(AvbOps *ops,
 				      size_t num_bytes,
 				      const void *buffer)
 {
-	return mmc_byte_io(ops, partition_name, offset_from_partition,
-			   num_bytes, (void *)buffer, NULL, IO_WRITE);
+	return avb_blk_byte_io(ops, partition_name, offset_from_partition,
+			       num_bytes, (void *)buffer, NULL, AVB_IO_WRITE);
 }
 
 /**
@@ -883,7 +908,7 @@ static AvbIOResult get_unique_guid_for_partition(AvbOps *ops,
 						 char *guid_buf,
 						 size_t guid_buf_size)
 {
-	struct mmc_part *part;
+	struct avb_blk_part *part;
 	size_t uuid_size;
 
 	part = get_partition(ops, partition);
@@ -920,7 +945,7 @@ static AvbIOResult get_size_of_partition(AvbOps *ops,
 					 const char *partition,
 					 u64 *out_size_num_bytes)
 {
-	struct mmc_part *part;
+	struct avb_blk_part *part;
 
 	if (!out_size_num_bytes)
 		return AVB_IO_RESULT_ERROR_INSUFFICIENT_SPACE;
@@ -1111,7 +1136,7 @@ __weak AvbIOResult avb_read_root_key_digest(AvbOps *ops, uint8_t *digest)
  * AVB2.0 AvbOps alloc/initialisation/free
  * ============================================================================
  */
-AvbOps *avb_ops_alloc(int boot_device)
+AvbOps *avb_ops_alloc(enum uclass_id uclass_id, int dev_num)
 {
 	struct AvbOpsData *ops_data;
 
@@ -1134,7 +1159,8 @@ AvbOps *avb_ops_alloc(int boot_device)
 	ops_data->ops.read_persistent_value = read_persistent_value;
 #endif
 	ops_data->ops.get_size_of_partition = get_size_of_partition;
-	ops_data->mmc_dev = boot_device;
+	ops_data->uclass_id = uclass_id;
+	ops_data->dev_num = dev_num;
 
 	return &ops_data->ops;
 }
diff --git a/doc/android/avb2.rst b/doc/android/avb2.rst
index a514701241..cef49d3e0d 100644
--- a/doc/android/avb2.rst
+++ b/doc/android/avb2.rst
@@ -29,6 +29,10 @@ integration in ``common/avb_verify.c`` and the platform port under
 
 For additional details check [1]_.
 
+Only mmc is started by AVB itself. Any other interface must already be
+enumerated when AVB runs, either by the board code or by a command such as
+``usb start``, or the partition lookup fails.
+
 AVB using OP-TEE (optional)
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
@@ -80,7 +84,8 @@ AVB 2.0 U-Boot shell commands
 Provides CLI interface to invoke AVB 2.0 verification + misc. commands for
 different testing purposes::
 
-    avb init <dev> - initialize avb 2 for <dev>
+    avb init [<interface>] <dev> - initialize avb 2 for hex <dev> on
+        <interface> (mmc, nvme, usb, ...; defaults to mmc)
     avb read_rb <num> - read rollback index at location <num>
     avb write_rb <num> <rb> - write rollback index <rb> to <num>
     avb is_unlocked - returns unlock status of the device
diff --git a/include/avb_verify.h b/include/avb_verify.h
index 66655aab87..6dbbb39a8a 100644
--- a/include/avb_verify.h
+++ b/include/avb_verify.h
@@ -7,8 +7,9 @@
 #define _AVB_VERIFY_H
 
 #include <../lib/libavb/libavb.h>
+#include <blk.h>
 #include <mapmem.h>
-#include <mmc.h>
+#include <part.h>
 
 #define AVB_MAX_ARGS			1024
 #define VERITY_TABLE_OPT_RESTART	"restart_on_corruption"
@@ -24,7 +25,8 @@ enum avb_boot_state {
 
 struct AvbOpsData {
 	struct AvbOps ops;
-	int mmc_dev;
+	enum uclass_id uclass_id;
+	int dev_num;
 	enum avb_boot_state boot_state;
 #ifdef CONFIG_OPTEE_TA_AVB
 	struct udevice *tee;
@@ -32,19 +34,17 @@ struct AvbOpsData {
 #endif
 };
 
-struct mmc_part {
-	int dev_num;
-	struct mmc *mmc;
-	struct blk_desc *mmc_blk;
+struct avb_blk_part {
+	struct blk_desc *blk;
 	struct disk_partition info;
 };
 
-enum mmc_io_type {
-	IO_READ,
-	IO_WRITE
+enum avb_io_type {
+	AVB_IO_READ,
+	AVB_IO_WRITE
 };
 
-AvbOps *avb_ops_alloc(int boot_device);
+AvbOps *avb_ops_alloc(enum uclass_id uclass_id, int dev_num);
 void avb_ops_free(AvbOps *ops);
 
 /**
@@ -78,7 +78,7 @@ const char *str_avb_slot_error(AvbSlotVerifyResult res);
  * I/O helper inline functions
  * ============================================================================
  */
-static inline uint64_t calc_offset(struct mmc_part *part, int64_t offset)
+static inline uint64_t calc_offset(struct avb_blk_part *part, int64_t offset)
 {
 	u64 part_size = part->info.size * part->info.blksz;
 
@@ -110,10 +110,24 @@ static inline int get_boot_device(AvbOps *ops)
 	if (ops) {
 		data = ops->user_data;
 		if (data)
-			return data->mmc_dev;
+			return data->dev_num;
 	}
 
 	return -1;
 }
 
+/* Mirrors get_boot_device(): no ops means no interface, not a default one */
+static inline enum uclass_id get_boot_interface(AvbOps *ops)
+{
+	struct AvbOpsData *data;
+
+	if (ops) {
+		data = ops->user_data;
+		if (data)
+			return data->uclass_id;
+	}
+
+	return UCLASS_INVALID;
+}
+
 #endif /* _AVB_VERIFY_H */
diff --git a/test/py/tests/test_android/test_avb.py b/test/py/tests/test_android/test_avb.py
index 137d83e1de..4c5b3c6f59 100644
--- a/test/py/tests/test_android/test_avb.py
+++ b/test/py/tests/test_android/test_avb.py
@@ -135,3 +135,31 @@ def test_avb_persistent_values(ubman):
 
     response = ubman.run_command('avb read_pvalue test 12')
     assert response == 'Read 12 bytes, value = value_value'
+
+
+@pytest.mark.buildconfigspec('cmd_avb')
+@pytest.mark.buildconfigspec('cmd_mmc')
+def test_avb_init_interface(ubman):
+    """Check that 'avb init' accepts an explicit interface
+    """
+
+    response = ubman.run_command('avb init mmc %s' % str(mmc_dev))
+    assert response == ''
+
+    response = ubman.run_command('avb init %s' % str(mmc_dev))
+    assert response == ''
+
+
+@pytest.mark.buildconfigspec('cmd_avb')
+def test_avb_init_bad_device(ubman):
+    """Check that 'avb init' rejects a device that does not exist
+    """
+
+    response = ubman.run_command('avb init mmc ff')
+    assert response.find("Can't find the requested device") != -1
+
+    response = ubman.run_command('avb init ff')
+    assert response.find("Can't find the requested device") != -1
+
+    response = ubman.run_command('avb init nonsense 0')
+    assert response.find("Can't find the requested device") != -1

base-commit: 6e3f574e576585b0250ac387475d59e581bb5d9f
-- 
2.43.0

