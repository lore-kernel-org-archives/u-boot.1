Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44020CA5FEC
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 18:15:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC82440E8B;
	Sat,  3 Oct 2026 18:15:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WNZAU2LBEL_9; Sat,  3 Oct 2026 18:15:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2A8EE40E90
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791051301;
	b=okxrMlQcTQ2bRB3VR1qiuodIY9hmxtRsqd4O9pg2FWCOpwmfP92V4p4W2hI4CwU0669k
	 D3l9wZ1+YsuNwgm7KaqNS248VQ+OxdFTLnRVgJnzshmbcive3eANsBNo02+jTb7mlSE5K
	 6rgYdeP0bChzrT/Q/f7YHr16HsQKZ39DqQ6qvoJanOMmlt8cX/LEleKE5m7xoFDgaj1iP
	 5IewarA1cZvjM0kDfOKvubKrmi3qBpcpuA0ygNj0eCP28ppwsl2jbm5Y8AA6EpZ3W8//h
	 RBN/N5clro1Og6cq+2vNZnIX4suIk6rPbemF5lRJHUyAUv1hd3ll2/2m9Cr5zLfu/SQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791051301;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
	bh=M+lx/g4f5xeW/J2kUm08+zobDqAZkrtycSExqvGXoF8=;
	b=UkHYCn3un9S0MlTfNpGnh8VW4sLIEIh25X7Wvf+X+2boikaC6n6868H9k+CEQhyAg/K0
	 4GNYHgsTvPj8QbSsz2DhO5ytCpt5QRyN9V1UIEDNK2xbQpg6VXJKQkgVSh/BDnxMk9T13
	 wdqSarAxKApTbP1wzA9QOYzFecM6h3JgJxi6fQV+jgTpMUI79tm17O/gCWXIGxxCUmWQ1
	 KQfMiqq9q6sluQCSjvwymhWykjiwZf41hz2SeJGeuqHjHzVSRxPMqDQQmSHddsNLn4P0D
	 yejjvqObNWaC41QwcXYoW39JZ7lKheT+538swJTWhxJ0DgoN3sEB23TuEV4RTnWnh0Q==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791051301;
	bh=M+lx/g4f5xeW/J2kUm08+zobDqAZkrtycSExqvGXoF8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=E30ITHnJjdk+i5MvgGIxD3XpeMNnJQO05SDZZsj4UvTB2Eh+HVzOSaIMIZCjyMgkT
	 NfjtdFQgf6baAT+dL6HvzMQPAVS8xj8Lg1Fyxtre2Khr/98C4Ltn7H4ZBVpmZvcF+z
	 3uS/QT8yQ6e7pM0GLoKVnbYiKi66qEeDTvnYJuodAeU2OdD/tcqyJRgMMQ1UGLjVR+
	 PcAXRfHvr8JdpIxNaptRoWWNUzeBA2iY2a8Nu6bcLydRfclppsL1n4kHhS/xOYNny/
	 ZHnl+BWIs96AAvF7zFwE5hJ2+fA7dnOcWEYC1cFcawfiwI05DETT7RNbCMMJoJfnjn
	 WYy57f3E7JLtg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2A8EE40E90;
	Sat,  3 Oct 2026 18:15:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9A3A7282
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 18:14:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7FE21606B3
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 18:14:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S1yJZS8VyM95 for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 18:14:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 84275606A0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c000::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791051298;
 b=KqI2Qn8ORBxYbpirTinilVKbdWpzN1r0AQA5vnHYF88m7hG4outQE30KXfjHrWoGU1fT
 29KMiA5mAVp5j09MCIl3wmDBNQ2djxD578IkbkxIrXgBtQWDdl477kXYyf6e70XhbePrg
 5J10QjoForztenKwT6eHacSKEPHaFzXGGzY/A8b4Iborr3Fg9YB1Vaf93JSG/3uMbojTZ
 ONDa03Lpfr57Mbnu2mZkCIJCovak/GNG3EjIO6IQn1zUfpFCsnivyVgj8TE8RqI7sQuNx
 cmodemqR6l4ci+IBFcipv7+H3k5ROr7Qy0yheBDk1g7MhQRxyBmoDY463raboxyoG0A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791051298;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:Content-Transfer-Encoding:Content-Type:
 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
 bh=M+lx/g4f5xeW/J2kUm08+zobDqAZkrtycSExqvGXoF8=;
 b=dMKatsCDlARzFa2g4XxnDceODVZUr23kNlgKpwyPKjbEKJmfOd0+nZBTAI+ZAexAnkY9
 TnuD+X73Tf0MiAi56GwbRVZg5JAfJgNuzPPmT91C59V2m9Ker/lNHqOHh3FxBEsHtF9RT
 bjamCSLNQ1qeG+ebmqdYVvfBJNSsYH3yHHH1bh01PpakhRJGMZI9O3+ulbZwmIOo5GzYR
 IQ0FFLPziKJ7WR7VYFfTlALAPDsqf1rFkFORG8YrP62ofv62vS7oBZD6AA5oTnbbTE5Nj
 /jbg9/ZViJMcizTFeZ1SheiGTTlDe/bFX52RsZZT8XwTqpMPyQdKMFL7p2FJvrzgisw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=altera.com; 
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=gZeZCYHb; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c000::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c000::1;
 helo=byapr05cu005.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=gZeZCYHb
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 84275606A0
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 18:14:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hxOXslyMpQM4kDkPS59eZiaR8kAPoN+ULfKftFPQ12zewag5fD9r/tNd4sxQ3z/BGXsIkVjkM+4hC4YaK8mreEn50lZ64yz1ee6DCkqXV10B4ZqTiL3PcMTu+8i2PUhs/pF7IoM26kO4Xntym32R9dJnMoqmlsOeKcpscjFSNu+s5dSSo5CUyt1jQKY+WaxeFaS40YLWH6iJoZQvK3tjAy8K7wd6gBa4rHbGAaZRcBBeX3swPkuE6JcBsYjls4X5N2Q/1XF3tvOmgG83y1qaLIsD/CG7npDJ9wxK2xSekzBAXIQX4OiTDr3DpAzFUVhBjtCAsyV+HviXF4F5NJWN6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+lx/g4f5xeW/J2kUm08+zobDqAZkrtycSExqvGXoF8=;
 b=SO703tud/KWGyHq5j2RV8o7jF8wodCKwMlD68TiRYUmBzrzwkPAWP7E/9Hf7qH1eFhjUHq3eDIXWQ0itWZwHnUpPGJC2fsvokQlTIj3I/EWXOCaOI/eUDQJWorv8+ntZdgt4VpQoyFWc1yEsWmS2hi6/fcyo4GM2ctWGYkw06MfkbNFKEFJFRkDx9x9NFJXueiZoOzrOkIaN4yNvfHdFMmktqMPIq0r3CRXR2WdB8o0xfn8vJy4k11KlqUsLx3JeWmaTnzk6K1tLBs6lgavLh8R0P7X7lb7KboJ1gQ6+fhcl65Vmn1RZZSKWJtU+YVyTznSHy6gN5Ts8S0PiVc4wuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+lx/g4f5xeW/J2kUm08+zobDqAZkrtycSExqvGXoF8=;
 b=gZeZCYHbEYHXpS2e4dKgwc1Rp0FI9fx2rA/hC76U+M1ut9YO40dJ5LO6hzBbkAbfTpbLX1VpgHkGxN2wtJfN0jH4UK0bPgHPpdnfxJAyAGQ6HEKEntio7bLUjMs2ZI+kZvIghH5tHTXW8O2JN9X+Km71dKUqTWLYSAs+b63MoVHxU0jReb+336EA/jR/adSKDi/B7/NFPfml/Bm5UcYMQUkiI3Li+BPx6V0kA7s/hOlCsC5/xWKXMEYcJ9AzQquuJchTO/3C7FVhYJvgSnkQaxH7GXL5ZamIRQLD7QNbXdLKiITw/Ss65QDqtubx/MsuSDE5p/fw+X9NTJpDZO1q0w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6199.namprd03.prod.outlook.com (2603:10b6:208:315::18)
 by MW4PR03MB6921.namprd03.prod.outlook.com (2603:10b6:303:1b8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Sat, 3 Oct
 2026 18:14:52 +0000
Received: from BL1PR03MB6199.namprd03.prod.outlook.com
 ([fe80::e36a:e873:e394:f6e]) by BL1PR03MB6199.namprd03.prod.outlook.com
 ([fe80::e36a:e873:e394:f6e%2]) with mapi id 15.21.0451.026; Sat, 3 Oct 2026
 18:14:52 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Judith Mendez <jm@ti.com>, Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Subject: [PATCH v1] mmc: core: Apply power-off-delay-us outside regulator
 support
Date: Sat,  3 Oct 2026 11:13:31 -0700
Message-Id: <20261003181331.3217-1-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.19.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0185.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::10) To BL1PR03MB6199.namprd03.prod.outlook.com
 (2603:10b6:208:315::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6199:EE_|MW4PR03MB6921:EE_
X-MS-Office365-Filtering-Correlation-Id: 99650160-9d9c-4711-48e6-08df217a3809
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|10067099003|11063799006|56012099006|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: YdtcipChbxrVhTXavA8AKnFuH5ycFtL/H2d2bRzZc1on2+sXxT66Z2pSoCizPf5Mdtc/d7I+mSBgGMqL/QSaeIQzkFgh/OWY3wFkJLjNHHfl/HEtnXXqPXdScH+F1QkJYHS/2uT7WqVmVGYzFLMq2YF/4Odw+OGNCuoaqAFfyaVbQgD8aPpxAX1dH6WARjRvMzBGjFS7gbCWXJ50pDSraY+gC1xRXIxurhgHZYcueo/dZzV4J1Vgc2weSYstu1u1FpyIEvZsbr9W21zD6ZXcaeJu9sSzBbU3vpQrpAjc3Q3ra8ETaca+pXJzmRkzQKojr0RkpLNMEKkdq8IMXfQ/wTKWA+LzHfEheP3cAJzPS+Gfb2KflbBH+puge9tctDynMRVwVgMwXTVqIinrvn7cUX1dxbDGG1G8yL4/9tNJqKJDl1FehF4YfREUbfMo4T5GkrfRDpywtdc1SzXuTZGZ6oqvYWOhw6QMK3oZghL8F/SjQFFFxcksZCFvfXT2p69zjxSaeBxqppe0A/vWW6UM4I94nOZWq0/84z3HUERXGpgstZ7zG+oWeoLYqaO0fVvlqililtOafSzaChpwGTgqvuqHHRiHiNy/Th5sHNOwJVi6PJqoQW4WH6HFuLmGR3O9MuVLKxpI3eEmqfh903BuVmu2YGogLhY/R/rgp6avh+w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR03MB6199.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fljj/6mtHBT8paZlQIPZmPBXlBKoFISFRXCbH+PVDj+kckQTEA1WXw24CdZ1?=
 =?us-ascii?Q?DD1NIX/EpuqUqpu9x8oyM0MPCwYdx6xyxbeOXe/Q15WfDhtq2mdUfsK/ulC/?=
 =?us-ascii?Q?7GEdMQEk2vFRLAwoRw/TegMWI0ElJYuO5VanOdB6hS35XQ1a4YYF8uMVxAml?=
 =?us-ascii?Q?rFgRrTT+mjY89Y6tG3m/QpK5cqeTI2PNhWIIPNiwkFpvqWa1/N/cGADF6NU1?=
 =?us-ascii?Q?8xBSfmdYLRQaQ3Ygk1ZUSA6I2me8tgl03Epkpn9qfatIMgaRt9vabL5wkWgw?=
 =?us-ascii?Q?UoarxxPPOf22p5VZaYXbllW1YxnN3IsdDtxmToaOezimnTUkdco1cIW7MsV3?=
 =?us-ascii?Q?W2HLptIo0iezsStNrIB0c8Zym7srNSJoyeTIxONY4pWON+rpa14iJKl1cfHy?=
 =?us-ascii?Q?hfl3WkU3t344dv+giTWzcSI5VUjO8AEF8rngKpaCZqRmX7DAwzmLeT8nbLgp?=
 =?us-ascii?Q?OeR91gRdp+fDqLyN17prZMUUPPRAf79KGaKFtRuqXS3KSHMrWhfDcJYiGGtL?=
 =?us-ascii?Q?7Tv+ZqaDJwnB7Ey6XEV5Tj4lJ+jWh6SX9uERDxkMMdYMKe2fytYb4JkwAn2v?=
 =?us-ascii?Q?+8z/WK0PO7hqewSdkh6SGsFFbdwQBT/JmmMsvI/MNVuAWn7UJvgIO0YjYf2B?=
 =?us-ascii?Q?3TLjRYeYorNr3NHP6p5PSwjgrhEQuembnIL6BtbYAotJO+RtrmceQRqL8iO1?=
 =?us-ascii?Q?7MrDW5wPPLBiaxc4Qxty58ThbhQRLNTZj7aJO6Ig3IlvrT2hBIZ6g915xmno?=
 =?us-ascii?Q?kuVhmTOyNkFAFxCOGzdfFC4PLo09hPcJV25Z9Lg4m8IpSPNyR5xzpgi4mZdu?=
 =?us-ascii?Q?TnF4y/F6IyBqY11uc0smELVP4xv6wHCOi3JR0BHQrprxD7FLwVtfSpr2smaz?=
 =?us-ascii?Q?arbeO3Zu9KdwdQifMUjXGPhCsY3jywshpquzLTkhBKCA3JBA6TOtBBqhDJAT?=
 =?us-ascii?Q?R2IwMSEYvftJhCei7mee4MROolp3Ag4oenZIr1j+KGENyB7z99CpAFAMRhkM?=
 =?us-ascii?Q?2cXzpchuk0S0zVkM50kyGBrXa+WYH/6qsrz6L5isjAgNcV75+3Nrp5fzFxyA?=
 =?us-ascii?Q?FiIUKsV8sQEnph70H8x2tQf/bEPeUCaDQfLb7Gv/eoqoZt45eqOwQjSe5JsE?=
 =?us-ascii?Q?Tc6ePOhs/7QcCrHri63XxBggKo+b+7SdFDw19TllO7sbAvnrUnkR3p4p5UL6?=
 =?us-ascii?Q?xXEp8Dqv0FPo3q8poM99BP2SashGZUpHE/7BAED2WwFKkm6hRqJ/y5jWMEIE?=
 =?us-ascii?Q?8ptIPFUJHpvpvVdSssxBwqD8f3jwzsrdQ1ARr6nGUXU5+ASAxnduByJQ7wSP?=
 =?us-ascii?Q?cRn7/fP/KGmTWI5riXKXwXxSMep57gnojQYNVE1ep+tiFcyDajO8qe+dQFyg?=
 =?us-ascii?Q?Ip6AGcwcQzvf/hyQFNAmc5o/xrRfpIqwCzy5BS2v5E/UuRnFSNlGCWLNnqJj?=
 =?us-ascii?Q?3Uy7TiBsZlYxmhKRyORuCOlSeqW+Sd6CmFRErgLgexbB73QvVjO+tk+tzbsv?=
 =?us-ascii?Q?yZmKHahICisj5hd2+eyMJ4mXsdvlKuiqbCVzJxVuaiBCTMa3+zbyh8gtOC3Q?=
 =?us-ascii?Q?DE5aJWVp6W2F/YmVNyu9pL2lLj2NkyKwhXO9SEVyc/0ugWIvOQZl9joSon2e?=
 =?us-ascii?Q?KvBn5P7Qh13vjXoigPjp4tBBjxLwRg4E7y1apbWh0k98HOBkjNxNvB3/j8vi?=
 =?us-ascii?Q?er4bz/dafF3012dz3SvPOb5Gl2/jrs46+53XdSPXF5R5A7gOYuz68VRPlK7j?=
 =?us-ascii?Q?ZUGzkG7vvzf9iAH2kGutoCqR4jwPoTE=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99650160-9d9c-4711-48e6-08df217a3809
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6199.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 18:14:52.1369 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SBTpz4CTE8VCIuRGv/GePeTlHqNSHl19uaTygOKNAb4J+tgBOc32LVyddrZy74dF4YjPlJ4GR7wuvDgc2cExyzUM1zYqvoGAxFe8XRB7R1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6921
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

Parse power-off-delay-us once in mmc_of_parse() and wait at the end of
mmc_power_off(). The delay was compiled in only with DM_REGULATOR, so a
board that set the property in a build without regulator support never
waited. The default stays 0; mmc_power_cycle() already waits 2 ms
before power-on.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 drivers/mmc/mmc-uclass.c | 3 +++
 drivers/mmc/mmc.c        | 9 +++------
 include/mmc.h            | 7 +++++++
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
index cd930807802..5f28469f6c5 100644
--- a/drivers/mmc/mmc-uclass.c
+++ b/drivers/mmc/mmc-uclass.c
@@ -296,6 +296,9 @@ int mmc_of_parse(struct udevice *dev, struct mmc_config *cfg)
 				    MMC_MODE_HS400 | MMC_MODE_HS400_ES);
 	}
 
+	cfg->power_off_delay_us = dev_read_u32_default(dev,
+						       "power-off-delay-us", 0);
+
 	return 0;
 }
 
diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index a619440fc4c..be41b925bcc 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -2910,7 +2910,7 @@ static int mmc_power_on(struct mmc *mmc)
 
 static int mmc_power_off(struct mmc *mmc)
 {
-	__maybe_unused u32 delay_us = 0;
+	unsigned int delay_us = mmc->cfg->power_off_delay_us;
 
 	mmc_set_clock(mmc, 0, MMC_CLK_DISABLE);
 #if CONFIG_IS_ENABLED(DM_MMC) && CONFIG_IS_ENABLED(DM_REGULATOR)
@@ -2933,13 +2933,10 @@ static int mmc_power_off(struct mmc *mmc)
 			return ret;
 		}
 	}
-
-	if (mmc->dev)
-		dev_read_u32(mmc->dev, "power-off-delay-us", &delay_us);
-
+#endif
 	if (delay_us)
 		udelay(delay_us);
-#endif
+
 	return 0;
 }
 
diff --git a/include/mmc.h b/include/mmc.h
index 9a796e0655f..1e054a228c2 100644
--- a/include/mmc.h
+++ b/include/mmc.h
@@ -628,6 +628,13 @@ struct mmc_config {
 #if CONFIG_IS_ENABLED(MMC_PWRSEQ)
 	struct udevice *pwr_dev;
 #endif
+	/*
+	 * Extra discharge delay at the end of mmc_power_off(), in
+	 * microseconds. Default 0. Boards with slow RC discharge on MMC
+	 * VDD set this via "power-off-delay-us". mmc_power_cycle() already
+	 * waits 2 ms before power-on, so this is additional time only.
+	 */
+	unsigned int power_off_delay_us;
 };
 
 struct sd_ssr {
-- 
2.43.7

