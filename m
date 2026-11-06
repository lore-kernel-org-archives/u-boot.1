Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A18606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 03:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tR0Pu79D;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=KPYfzk32
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 029C0811B9;
	Fri,  6 Nov 2026 03:19:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eprYeJfU3B0O; Fri,  6 Nov 2026 03:18:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C8524811FE
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793935139;
	b=MQy99Vw3vDYf3h3eUeD3bH71soRGTSnbhKNwu4fmqlKrh1JQxdi0OrVpwiUXGkOZ2RFf
	 JTIHS3yCY63c1r0gXZD8dVlvDi2fsboMh9u6o5smUw3muYq7ErRmOmPrv6c4wYREk3Bq3
	 pgyaQgmJ5YI3+w+qjLvvTCSfzW3NXpMdxofOZFezV5ZQLY/PQfOCipe61UboVugekV+dS
	 Ycfx9UVOFs2RgrK6ur4hGoFZBlZcF9Lbpq6P+w/v3ZU7a/lNYJhfdw3d/PA66p/BWpv2f
	 Oz9D9sWqExNfzzHyARJrqJaJ4YMdGCFoIJTka+h+6EfB8K8difMNhfBUTJK8aybZzhQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793935139;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=oQiWFCfcv51MBNU34fTpVHzzBvFHPuk0/sswViseV1g=;
	b=atCm6vcb3w8fVc/youfHj4ub8HbnWlni/mM7+7jEB0BGG0Juudl/zk0L7FOCijBSLohW
	 JqB4UNHZkyE1TOyzKmHESAoIVBVucSNxHqE4DBPxbwyg7Gfrr3Gc7/fXf3H+v/eeA08Qw
	 Y4OSWhrBrIxopIeP5zMuNKFmV/Uob3W/jDhEPJB+BMhMyBQz+7mqFC1Ngk0kgngWqUtAS
	 kdTe/x2NEDw22gTPh4ylSdUaweez5CCmlMXJgxQ075SOAalvVba2lqcMGJHe4CI3+E27d
	 IkJwZ5aTvnnkSRQFWU5sqKCo9+u1ZFrCAO3ZKSAiorrY9/EiXl59+7EQOllCEor07Qw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=KPYfzk32;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793935139;
	bh=oQiWFCfcv51MBNU34fTpVHzzBvFHPuk0/sswViseV1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tR0Pu79Dlrn57vxFQx8RiHipI/fGQMpdUZaTDH3oxNA1OH+YE1sLOnUDfaKDuLXHn
	 aR4HopvaGQ7vy4XxPUM2XtrSF53cQ+2Vb9TaWXQINnclLpN25+V+c/bVAIJsC7bNf6
	 wuI1POAVhB9IyJMM1l0grYqA+m4MT0JlhGB7CrTHWcOMausV614dctIy5RHDO6LWYN
	 T9nqb6T5axGWJeyrpKRlQuoWBW1jWEI2xqGPMDaKw5C2HOZlxQp6xmhPXtpYrzEm0L
	 /UuwfaRPmi1LDJIw/LM8E8Ztqt/8zazjxeI2b3mvr9twIV5hz1A20hjjV6nJOhL9MF
	 ovhuXww8272QQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C8524811FE;
	Fri,  6 Nov 2026 03:18:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8BBAB31F
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 03:18:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 71B718118F
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 03:18:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6IAYkJZoe4ju for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 03:18:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A509C811B9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c105::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::7;
 helo=ch4pr04cu002.outbound.protection.outlook.com;
 envelope-from=alif.zakuan.yuslaimi@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=KPYfzk32
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A509C811B9
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 03:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQiWFCfcv51MBNU34fTpVHzzBvFHPuk0/sswViseV1g=;
 b=KPYfzk329+Zbiu1pJ7VagPB7KWBFDUReN97YqBY9MXEur92xKP35/7RgKWlBcM3zOJg4NPn7O1UEx0cCdjWYZYqj9NxzGKLPOjK53IAt+nRo4x9Do0eTGge7JQ8Mppd6ss//L0D6cNItmwYvb7cGXNFOpRBwOqDDlkeVWI3o5SIkVwM97NAtCLBXx6hQDSrlME9HjaIxbRvP4a0FVT6HW8q4xs4VQAJhRYIKysLBStu4y240BFRZ4DhyB4yFbB7WAKQtMAaZ5dUYxkPfkfDpWdKqhnebsSSfgcx2+/DyKR4fP0hjN29ulMEXdggu6j8taAyakbClypt7nmULCYBZgQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SA3PR03MB7301.namprd03.prod.outlook.com (2603:10b6:806:2f0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Fri, 6 Nov 2026
 03:18:51 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0569.011; Fri, 6 Nov 2026
 03:18:51 +0000
From: alif.zakuan.yuslaimi@altera.com
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Dinesh Maniyam <dinesh.maniyam@altera.com>, Tom Rini <trini@konsulko.com>,
 Pranav Tilak <pranav.vinaytilak@amd.com>, Heiko Schocher <hs@nabladev.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [resend 2/2] cmd: i3c: drop unused includes and skip empty device
 slots
Date: Fri,  6 Nov 2026 11:18:30 +0800
Message-ID: <20261106031830.13625-3-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261106031830.13625-1-alif.zakuan.yuslaimi@altera.com>
References: <20261106031830.13625-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0282.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::17) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SA3PR03MB7301:EE_
X-MS-Office365-Filtering-Correlation-Id: 04409045-7800-4fb1-235b-08df3bb4ae15
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|261102123227099003|261022075727099003|11063799006|261022113327099003|56012099006|261021121427099003|261021123027099003|261026140227099003|261028144727099003|261022105027099003|261026121527099003|18002099003|22082099003|55112099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: mMmIiUoFkFLey7HYoOQmMQD3L/WML+WVmG5/RluyBsmRyDMOh3TFY7ZgE9Y77gwzBNFEdwPJZfky4dQBD2OWyw415VPLBdVxF0XA2t0ApmkIA28GHer7pgkvCdGRs2RK467Bd6uklAK79RRGClFatgPlUjOG82pxtrxEowmZl20YLxH4aQzhr8peCKx4uVEEyKrW15Y1yBqyK9nhooopb9hVfoZUo6zsiUW4iyVQIRKEWEnuosDwApA1z3VuUWa1w63uPN7tC59sYhz5qvgs6NS+AiVYdFAHjpFXKAMVBk+YjZm5n7HOz7jvMjiOFyZfZh/Qrr1WnGYkZlqNEM89hqgOnGL/7NAc+nvUAU2VnwGRvDlv2y/BGaBfG/uddDZw4ebULnTjWWJDr4Mxsdy+ob2kMuvmPipU/QLU62mSc3hWAoEWef9Fd06bbcFeWbCWZltdE1LXTMSkrBL6JQUmxSsw08SBzbSQFhiE1Seaq97bYbOg3pzY56d6F6nhlHascZ45TgAdX0tbdQpenVbaSru+uq9cr8OLrkWY3tR0cWLf5KzCgAQBLMpqOcoQvMVrBv2rbtjyl8wXPt/B+kuwDueeCZXFTn+zQTVgnAcH4CNd3OTQ9NHQPjfFHTVHaCl/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(261102123227099003)(261022075727099003)(11063799006)(261022113327099003)(56012099006)(261021121427099003)(261021123027099003)(261026140227099003)(261028144727099003)(261022105027099003)(261026121527099003)(18002099003)(22082099003)(55112099003)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2ZLDmanVHthjhfz1cYN3eMYcYPDEoIZjUTMidMG8God7bq6ngp9DHVMRNvba?=
 =?us-ascii?Q?uGh2BOv/ilKnOR/ZmM1/m7flnkr8+MjKqEE+O6IpqDyGZDkiBvlt41yKK7zZ?=
 =?us-ascii?Q?c5xFgUhx3kNjLlctUO9zCD0y+XiKpTNYAD2ylHIyiLV8olOgyGqcgnsPOTbx?=
 =?us-ascii?Q?8gyrU1cjjOYLFBJwmbmpQtgHbj7BGApbdPQKNZvMaxyHbk0CPqBRAzffZ9gg?=
 =?us-ascii?Q?SF4JAKkbPQFB0ZvCA8Byml6uRBqb7xKHifQbDI4c3SIX5FBNpzxwEGbLFVRq?=
 =?us-ascii?Q?yz2EP51bFJumV130cRXuIizt4YWZHJBcSZB/lsi36zwMOZBMPPDvvdy97oZG?=
 =?us-ascii?Q?CXTRUqP+ZDHENwYYi6xT83ePCSO0k2Qf2jn7z9KWIjTBumY6eJflsmUC5jKX?=
 =?us-ascii?Q?kvSlxNn/VG844QT5J8/QM/pKhWplaW3W0rwaikd1ex23O6NCez36PepNMLKx?=
 =?us-ascii?Q?UAxcoUDIWSMxCXeKuCgPQp/D4VQfo67WAUaPF02efvlqeVAy4IYD1P6mHcPX?=
 =?us-ascii?Q?DWseGwJjPoPAdidqQsqj8/qVfUhFnnQKs2qAlA3IT6+1ujotO9NDs6G1YQQB?=
 =?us-ascii?Q?JPAngUZF1fbmDlHgaI54sqgvZ6TFDtu7hrVIX+GKHjKyMf5b6JL8arfedv/7?=
 =?us-ascii?Q?Cn3JbjfjhbnbiWuteLyfH4dwBFcdvocSweJS9PtJI+FXfgMQLnxFCYb0hpXW?=
 =?us-ascii?Q?gOHq9/nZyos6M2WVUHUz4A2/8svLjmDiXuMHM7tWLU2T07AMGjrHRyF17k0c?=
 =?us-ascii?Q?ah3wJnN3NYeVnD9ITPWMJZq6ZmQZusqAivY3tWAsMLJS8BqBPHigWdxHJL1A?=
 =?us-ascii?Q?fhPtBe9VWbHMRJ3l1CGRjbrYh8JUV0ge3FetUsmtVS/TwVyKZs4QXcYshRq3?=
 =?us-ascii?Q?RB11j6MMIqKyaH2E8CvNPC9AdztJy5tU7rDmuqGhGxhTHoLmHyDyxJm0RatR?=
 =?us-ascii?Q?vaKnT5y51K5RYE+kLnZ/rye+xbY0/ie5NwM6z5s9zl3wifu9foK2OM0MGS4h?=
 =?us-ascii?Q?RrtyX+BAGffX7m3dT4GhGYhnYhTYGYRZdu4XIQLsZ8F1UAxmYxCE1CJXoGrb?=
 =?us-ascii?Q?nbRHkYHImr38OWVRbI72Jkyd5kVmqp5UxIjNCj3dT7lfPTgyzpjufs91+Gy3?=
 =?us-ascii?Q?Q+vif8UzRHdlvtl2+wmxnNSLGK6NbdMdUlQ0d/TBOoG6zpmAjo/QWElW3e3L?=
 =?us-ascii?Q?NSTr/Tv4ZGWns3InZhREbRKqdEY44rr5SAg5GHHEiymhPoe5Cm62BV4AhUkz?=
 =?us-ascii?Q?jDfdBEtf7JovzTlPdOv1MN5xC0dezB14grn7vIin7dc0cQQ76Gu2o609H607?=
 =?us-ascii?Q?3cv/BVTxmkAsHvve9qinQSfkE7enMqlJ5rQhYLKFN+Zgs+0Bno4BjjYXtY6L?=
 =?us-ascii?Q?kSZQt35kaIwc146w4Bh0zY1WQYipvxjO3ZHDuJl+6eACMevPEtk3wOsdquY7?=
 =?us-ascii?Q?cx76zQFoNd0V28dTgtuChmOjCsDCohKv2NSnDLCmGxzT1pnZpJPCrmChPytM?=
 =?us-ascii?Q?CQmikaCSG13THAT3Hlqo01uSFZFNRR249qacwPd/boHmbiF7Z5DXmOkdVh/I?=
 =?us-ascii?Q?iyK5ggvCFOk7LgeKI+47l4HD4pi9te6xq4al8iiQufIJoWTY3/0z5kl43xI7?=
 =?us-ascii?Q?ExEvu416xcg70xV4/cWAd6fapAoT1CPEVIpqXHD4LR/rB8MhShKwBt61zxW2?=
 =?us-ascii?Q?AN6Utg5ENS07n6+oZtYQKnXNld8sQdEaEFfoxVKhSlbotp4dyOtw7dKVYq3M?=
 =?us-ascii?Q?jBL3zoovMzCtwLVrheqVIJ+IFwymysE=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04409045-7800-4fb1-235b-08df3bb4ae15
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 03:18:51.3391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MIO9R47G4f9mAeZ6wEsWvY6HiYDvlpTtk2GBbP6uM9aJ4RntZzxqe0ygg3PaS+cAoYwBcGv4k2OZAmMm/SOWoUdrTlBcIgP1a/iyK5khchw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7301
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Remove headers that the command does not use, and skip NULL i3cdev
entries when listing devices so a detached DAT slot cannot fault.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 cmd/i3c.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/cmd/i3c.c b/cmd/i3c.c
index ba99a937990..6d287ac930e 100644
--- a/cmd/i3c.c
+++ b/cmd/i3c.c
@@ -3,23 +3,14 @@
  * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
 
-#include <bootretry.h>
-#include <cli.h>
 #include <command.h>
-#include <console.h>
 #include <dm.h>
 #include <dw-i3c.h>
-#include <edid.h>
 #include <errno.h>
 #include <hexdump.h>
-#include <log.h>
 #include <malloc.h>
-#include <asm/byteorder.h>
-#include <linux/compiler.h>
-#include <linux/delay.h>
-#include <u-boot/crc.h>
+#include <string.h>
 #include <linux/i3c/master.h>
-#include <linux/printk.h>
 #include <linux/types.h>
 
 static struct udevice *currdev;
@@ -103,7 +94,12 @@ static int handle_i3c_device_list(void)
 	}
 
 	for (int i = 0; i < master->num_i3cdevs; i++) {
-		struct i3c_device_info *info = &master->i3cdev[i]->info;
+		struct i3c_device_info *info;
+
+		if (!master->i3cdev[i])
+			continue;
+
+		info = &master->i3cdev[i]->info;
 
 		printf("Device %d:\n", i);
 		printf("  Static Address  : 0x%02X\n", info->static_addr);
-- 
2.43.7

