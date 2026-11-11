Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B887606A332
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 13:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=z3JghBkL;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=Xfqgw7vR
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 056844084E;
	Wed, 11 Nov 2026 13:31:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gliET9MciFTo; Wed, 11 Nov 2026 13:31:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 120064053D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794403868;
	b=IMasJ0uMpyAVnQTWC6Ynj6Th8g5wad3KrMs+OIr9K67n2WpmT98IaCLJ1f+ecPaB/3qt
	 GeCrX7z8c1Q0zIVVSC1hP2xcbOCV2UQ9npJllINRBH8wR3tN0aw4ucE+p/EeaHuT9b1do
	 dyy4Z0y6fpRUyCwMoZ6/3e9hF5xOULTsyN8Hj2vBIYuGE7lc24ZFjOfMTyNLg3WpPjIg2
	 6FT1dNL+PzkzW4Z+/TfJOZTsx06HMhgu2U6W8bNNuzqflDeebTzntIgLorYJz0B3oMkPC
	 RvKhIVG40NkPgRNrwM3ZgAXzOhJVQke6Kn7XTDBoZPgnd6bvd44wmSYq5HF4Et4yRVQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794403868;
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
	bh=g8ToQAGoJZXofVYzXKrwYIOfJ/PBe0X/YeffGHPLM6g=;
	b=MtvLCQ0GQJvVCU77IWXGzhr7qB4wGIAlIetVfQwz0Ip6rPNagYOuHYXYLvd7bIx83yX3
	 3Nmjkl/VSi60N1iJsHIKMX7Y1d3tDzFdxukVH+3lBlW0bfZjX8yrtGoNY/qeCY/kD63wP
	 FxNwW7THiIw7L+2dupru6W+kF2tAwDqu/2500dXHh/NL25Fi4jLRGImoetRjeEjhzdAk6
	 je2rKA5E46ec1VrjaUG+YNWukdrgp3AOAh3wlBOAATm69Ph7go+3N5kbJcnsE4fjuFEiE
	 PGCVf8Z3k0iT2mdLcGg7yb801tlOyPPjB2DHBln684Rtbukeus/PMW1uD2HlNN6Gbpw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794403868;
	bh=g8ToQAGoJZXofVYzXKrwYIOfJ/PBe0X/YeffGHPLM6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z3JghBkLTVMocCX1ozPXLlZwfBEazHa/g2DSZgWs0OIYgmvWl1bc+LikwdGj4Ocvf
	 6loOMJr5PDlZiJF14vGE5JTwtOhObwxM1hk9bvrMR362C6Ro+irtMmhqJSFlrv6SY2
	 rdBCituSSGIUKew2rNjx50KEmkRWFzT30joLbRuzrJk643OLJKoqEnDldTfS9FG2Oa
	 pB1J/bP5WYssf8CW81BD/2+wrRiJAUcLPsiEA0+FXTs0jFVLQ4vgpnmUhuyQ7WQvCD
	 iopOXYR91VZ2eD/wBesn9ijS1aSEm9FJMMSx3U+8sv7MfsmULuCkaF8pJ3hFGWcDZ1
	 GZ7jnmK+wGV7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 120064053D;
	Wed, 11 Nov 2026 13:31:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1FC9E731
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 13:31:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8682B81312
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 13:31:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 91XoqtZGCeTW for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 13:31:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 015DB812DF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=felix.moessbauer@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=Xfqgw7vR
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 015DB812DF
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 13:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8ToQAGoJZXofVYzXKrwYIOfJ/PBe0X/YeffGHPLM6g=;
 b=Xfqgw7vRoijYiPOAmerv/BgkA9bfxi0pmi3yhiJTzW+P0z8MMVSoR1nAukc61Rr4hVugHXjxXU8I4d5yxAOkshtnMn9YRNjQSLO7DqOjuQJs/d0gzokA0av4kiKJ+aeGZrdo8j5HtLudxBqS/6auK5K9YpH70PrtqdXIGcWhT6xHZOVvG0CMN/hycNqtzNobslupHTRx7S7PF2VltjW/0EWPG/3Cy+E1T21FFxNeUCq+c/J+3CqFvIeUl0Gza0kqC6avbFYVQn+gS0soc5XzGolavjzWYg4+2/meHDGSrFtVMGF3RWffKObNtwx4yF8vpTEFCvnaGb4fd8cfKbND2g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10)
 by FRWPR10MB9356.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:d10:187::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.7; Wed, 11 Nov
 2026 13:30:55 +0000
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c]) by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c%3]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 13:30:55 +0000
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: u-boot@lists.u-boot-project.org
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, jan.kiszka@siemens.com,
 Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [PATCH v3 2/5] timer: set end value for drivers with narrow counters
Date: Wed, 11 Nov 2026 14:30:26 +0100
Message-ID: <20261111133029.2538132-3-felix.moessbauer@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111133029.2538132-1-felix.moessbauer@siemens.com>
References: <20261111133029.2538132-1-felix.moessbauer@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:194::7) To AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:17e::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR10MB3956:EE_|FRWPR10MB9356:EE_
X-MS-Office365-Filtering-Correlation-Id: 23ab70dc-e03b-42d4-a63b-08df3ff8033e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|6133799003|10067099003|55112099003|261102123227099003|11063799006|261009223027099003|261021121427099003|261026121527099003|56012099006;
X-Microsoft-Antispam-Message-Info: N20tVL45Sz5HL7Uf8lzR3X/byztcOtQQTizErlw1cJScTEwfmGqyQi+LLbgD2oTb0d5Xtvqw5uUjMY/1iSMgSnWoNqHgMN8BzyGPvo5bJBMZUxLxv1NwclAC7fgSYUSra9rQeGOdzCmbRMfLBV8lWXU+kERs1RRbJ74RI9q0Nxrrm/9Fsj0+2eMfq9YA0YUVhOBM0KTtV3vPekW/cOeAtmrcRh2ntRTKoujH5iKg6QlqnpX1FSscpVz37ltXSfE0ybKKQK2FyXfkEr+xtDcva2ed9b71nLSp5Q4kSvU9LkiQVIOhkiu56gKthcSPm4X4J5UNVrdtaXYkeT6htm8ueWgoTU3TgpqxhWG/s3Bh94OjMohUpTRPweVepCuPU6lrlt8Gy7oOjmsHkfcSkxZV38+iBF9rLsYHXOjnzo+k82Aaekaozfoy9TzypeybAOCJp70Fh2dvpzsa3VJs4W2lAJrQOFhJqhOYN9YUmWDTbnpjUx8jeOdKRl3BPpcIUqxj8IIFQZseJ3FUv84uxpMIeMehDn4aYS+QpZr7l0iPIBXLGH4CiygaYi5DHMN068Opuio8wAlsTnBp6ufVVxMKX1kpxBBCWDvx9l9Ke/7vmOWrsuRrMf7y4mQANfvRdKVOcIKTCMoeAruZNL5j5lajs0NHc9h0agZ9RQDmXTReeSo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(6133799003)(10067099003)(55112099003)(261102123227099003)(11063799006)(261009223027099003)(261021121427099003)(261026121527099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vf7ZJkmuGMmVofgmPs8BQHkWzdQWrbW5YPDugAaVbpUR1DL/6i2MRMbA02UY?=
 =?us-ascii?Q?Jpdu7FNcikEFF358v64ERJ+WE6M2Mm838tIFBrwnSmpu7NQPrwDhlO3jYsKA?=
 =?us-ascii?Q?HpjYc3A+51qYPMjjM8iMmRX04hdQu/cW4v4t/XBViUowYI8k9CH7mGbxkb7c?=
 =?us-ascii?Q?PALS0w4XEeh04qad4dWSaB6k5YPJT13NKl0xYvNnUhsEwn22MrKSrubjmvXJ?=
 =?us-ascii?Q?iWkOD5DjQzdt9XZ1f+qJDDDwME0L20M0ya/bOMvwox4aDBgZF+e9XoseODKW?=
 =?us-ascii?Q?hgUEIIobbcfdR98hN/Pkre9szC7tkia+jmFgl04JMiosIZWrZxDno1BVrQ7Y?=
 =?us-ascii?Q?Utg2SIQ5xDnnodjjOJmEew+Avpsqir7adpKnZdBMxhdwbd0YFLXfUWGaTutB?=
 =?us-ascii?Q?TIwzMdroMis9Pmr9iJ1ViW3WmwwPq4LDdvuQOH/Pfw9GDt8jKHk7b0RmodnI?=
 =?us-ascii?Q?gEiV1IQgXUFE+1/EU2zeMuZNOK7pQ8A3Xm8kvXghm/wz/XlcA6AabponRVH8?=
 =?us-ascii?Q?xhOlmfJHqC5Zu3QfsCrlGZdAQGBOfyeG3PvDrhwf6M8kLD6JmSPTqYRyedHC?=
 =?us-ascii?Q?gj2vpcNRNqn/KOdIfJXQk6P/s9QYTfGhXdjUeKaaoKlEzff7MWgsw5bUYIhV?=
 =?us-ascii?Q?mtGOlAfXNbF3RwL7wfW4H8UVclt5zmBndfn2NqwB+xHqkMfzEgk7SlTVxeBX?=
 =?us-ascii?Q?1prMVT0LysyZUDM1yzEODpz4ux9P+WiTiawjQ/FmBcedJHxp9So4+2/JRDW/?=
 =?us-ascii?Q?+g5kCY40laDREfPSzzUr0rmFqCWhczyz5k6HAGxUA7sYe7Bp/s6mAF2tizF+?=
 =?us-ascii?Q?jR+j+aKkFSCh5geAOirOJ3r2Xu5Qe2bFy+ov60ACKHgMg0yjOR5PpnXz+Gb6?=
 =?us-ascii?Q?8KOEHRpBt0wdtV4SsyJYKrffICQQE2iYKlWQ9HZHVjYo7uvmmG1WMnbFLqE3?=
 =?us-ascii?Q?QmG/qnrsjz5I3anTgqeYSkg828v/wjodySI3QgRXLnX+mTY3FnDX+4I2qxzs?=
 =?us-ascii?Q?TyfwqM5tpuIDUJ/1D9oqz+oJ3NI8RMNWXdlwp9LtMuAkOxF2T4jgb6qCODR3?=
 =?us-ascii?Q?/l/L4ldM/EQkdPRTChFTkkNjrYj8JFjQAo4/BZ8dTEUHczGlxilKKvUDFTbg?=
 =?us-ascii?Q?Cx6bNnoGd1b5RtHEnT6JNrB35xSqzLYoV1rDQSLdl0vaZOQbNqTcMvSw6rLA?=
 =?us-ascii?Q?uj4d4anfKI9HZbnQbF8Cdh1w7DtzQDIhvaBIhGdhz04xkZiv1Bae4LwOFkzr?=
 =?us-ascii?Q?FO36eQFgP6NpO90892mQoMkqM850zrT86dVg5Ubw3vozY6YkWO6t5qjBRPtu?=
 =?us-ascii?Q?L+TEIqSyKg9lHrMdgOfl81IqnnkDq2rpvolskqt1noy2H64IPMjMupjQ7Wid?=
 =?us-ascii?Q?v7HoIhv7hBl45bY262UViUMvVayXwn+NP5Sd+lVPDlUys1x8qXUxR75p+McZ?=
 =?us-ascii?Q?Vlp24CvGw8rJzX/7I0HGCJCuTzLm8KqEa7p6tFHE5X3F5L+OBD3snB9BMSMk?=
 =?us-ascii?Q?YKmlOTzjkc2ZigncQiBvCzbziSjkDUNqF1F/gKlmsEzmPI2VZElWAKukFOVH?=
 =?us-ascii?Q?cEDOvaTLjrlPOHH0O8zk3c/3FG6WDJk1ZqamcUr+qgjg//hDTVix+nDbCzL+?=
 =?us-ascii?Q?+YBxGg3gKYG/8XukyFCx1qfBfidMfivKUOg76XgYK2E5hz7WrwMY6iYFezh7?=
 =?us-ascii?Q?X6XvEzn/6CRy+5O9RjXnNKIbjg+VQRtOGEz8ZUkIanrzRAotwuObP8KzIOz7?=
 =?us-ascii?Q?Ld9H0D7xDYrb1bAbjil3jhCsNse5Q2Y=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ab70dc-e03b-42d4-a63b-08df3ff8033e
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 13:30:55.1685 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qbB/AjJn73WY2tAUqvSrdDcJMLgyho05zlkYt1vkDYUpKGYFnhoJCb76p1FeUp4ur4mllI2xkBKNByujYKooQsYdqKqjy8/3x4q8rctj4Hs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR10MB9356
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Most timer drivers extend the hardware counter to 64 bits, e.g. by
using timer_conv_64(). The following drivers return the raw hardware
counter value instead, which wraps before reaching U64_MAX:

 - ast_timer: 32-bit counter reloaded with AST_TMC_RELOAD_VAL
 - cadence-ttc: counter width given by the timer-width DT property,
   which defaults to 16 bits according to the binding
 - sp804_timer: 32-bit counter
 - starfive-timer: counter reloaded with the timer-size value
 - stm32_timer: 16- or 32-bit counter. The upper bits of the
   auto-reload register are read-only zero on 16-bit timers, so read
   it back after writing GPT_FREE_RUNNING to detect the width.

Set the end value in their probe functions accordingly.

Assisted-by: LLM
Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
Changes since v2:

- added this patch

Please note, that I don't have the hardware to test all of these drivers
with narrow counters. The list of affected boards has been identified
by an LLM. The code is fully validated by me.

 drivers/timer/ast_timer.c      | 1 +
 drivers/timer/cadence-ttc.c    | 7 +++++++
 drivers/timer/sp804_timer.c    | 1 +
 drivers/timer/starfive-timer.c | 1 +
 drivers/timer/stm32_timer.c    | 3 +++
 5 files changed, 13 insertions(+)

diff --git a/drivers/timer/ast_timer.c b/drivers/timer/ast_timer.c
index 6601cab7b16..d016dda872f 100644
--- a/drivers/timer/ast_timer.c
+++ b/drivers/timer/ast_timer.c
@@ -46,6 +46,7 @@ static int ast_timer_probe(struct udevice *dev)
 		     AST_TMC_CTRL1_SHIFT(AST_TICK_TIMER));
 
 	uc_priv->clock_rate = AST_TMC_RATE;
+	uc_priv->end_value = AST_TMC_RELOAD_VAL;
 
 	return 0;
 }
diff --git a/drivers/timer/cadence-ttc.c b/drivers/timer/cadence-ttc.c
index 3cffb1bb88d..a55ca2493f1 100644
--- a/drivers/timer/cadence-ttc.c
+++ b/drivers/timer/cadence-ttc.c
@@ -67,6 +67,13 @@ static u64 cadence_ttc_get_count(struct udevice *dev)
 static int cadence_ttc_probe(struct udevice *dev)
 {
 	struct cadence_ttc_priv *priv = dev_get_priv(dev);
+	struct timer_dev_priv *uc_priv = dev_get_uclass_priv(dev);
+	u32 width;
+
+	width = dev_read_u32_default(dev, "timer-width", 16);
+	if (!width || width > 32)
+		return -EINVAL;
+	uc_priv->end_value = GENMASK_ULL(width - 1, 0);
 
 	/* Disable interrupts for sure */
 	writel(0, &priv->regs->interrupt_enable1);
diff --git a/drivers/timer/sp804_timer.c b/drivers/timer/sp804_timer.c
index d1a5fc8c5bf..1ff1fb15f91 100644
--- a/drivers/timer/sp804_timer.c
+++ b/drivers/timer/sp804_timer.c
@@ -75,6 +75,7 @@ static int sp804_timer_probe(struct udevice *dev)
 	}
 
 	uc_priv->clock_rate = clk_get_rate(&base_clk) / divider;
+	uc_priv->end_value = U32_MAX;
 
 	/* keep divider, free-running, wrapping, no IRQs, 32-bit mode */
 	ctlr |= SP804_CTRL_TIMER_32BIT | SP804_CTRL_TIMER_ENABLE;
diff --git a/drivers/timer/starfive-timer.c b/drivers/timer/starfive-timer.c
index 6b79c8858b5..10f53ecad2f 100644
--- a/drivers/timer/starfive-timer.c
+++ b/drivers/timer/starfive-timer.c
@@ -74,6 +74,7 @@ static int starfive_probe(struct udevice *dev)
 	/* Set Reload value */
 	priv->timer_size = dev_read_u32_default(dev, "timer-size", -1U);
 	writel(priv->timer_size, priv->base + STF_TIMER_LOAD);
+	uc_priv->end_value = priv->timer_size;
 	/* Enable to start timer */
 	writel(1, priv->base + STF_TIMER_ENABLE);
 
diff --git a/drivers/timer/stm32_timer.c b/drivers/timer/stm32_timer.c
index 1dc21c5c1be..a9903cbbf0c 100644
--- a/drivers/timer/stm32_timer.c
+++ b/drivers/timer/stm32_timer.c
@@ -109,6 +109,9 @@ static int stm32_timer_probe(struct udevice *dev)
 	/* load value for auto reload */
 	writel(GPT_FREE_RUNNING, &regs->arr);
 
+	/* Upper bits of ARR are read-only zero on 16-bit timers */
+	uc_priv->end_value = readl(&regs->arr);
+
 	/* start timer */
 	setbits_le32(&regs->cr1, CR1_CEN);
 
-- 
2.55.0

