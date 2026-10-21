Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21111606A321
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 14:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QiL+wMtT;
	dkim=pass (2048-bit key, unprotected) header.d=topic.nl header.i=@topic.nl header.a=rsa-sha256 header.s=selector2 header.b=XffA9PXg
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 50FC6408FF;
	Wed, 21 Oct 2026 14:47:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G4W2OuXM5g5H; Wed, 21 Oct 2026 14:47:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8F098408F0
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792594045;
	b=RYjbUuArLBdIll98HVTV3AUICTgQk9oKYP7bMavvdSFP+WjzO/D67APqLJhVH4EkJ2xo
	 j8uEKbAYQ2lMHibjoHxSs246osiTTbMDy9u3NsX2quF6cs9WZl91yxvNNd4ldsmfdR6sL
	 tzpBiSwMgUgp+7Yzf3T46WWmV/q0Ab94CCtGBX8JUsEIjdnrHFTdeR+jHdbFeu8IEZeDp
	 fsFeWYjZQebEKYn/aAr/F1o+X/ZhjUraX8osSO3lHf0E53ca7UUENiciLaoHaZ8klAxQ0
	 sMEK3A4ka1d3uK5PC+ApIidJY+tL81UvM84a5Vc5Fnb/U+casmCRwuxI18VIXCLyYyQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792594045;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Authentication-Results-Original:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-CodeTwo-MessageID:
	 References:X-CodeTwoProcessed:X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jlfqVju18ELkDWK50mHqBJbzmPZtlNoWP/lGbxWcWUs=;
	b=DhnDZYA62F2T+g24yfWWO/PM/LJ87L5P8L39c3i/xgXQR3ALGsqmQWSyvtLxl8N0CR/e
	 j3ytCsAcGs+N+JYEPsc4/3bxbgazQpndGJDEmo5u6anopO+a/CJNtpfjJCg/rNTFCTGMp
	 3CMSOWEWQQ969om/O3aaGXXB4BqtoQCfz4diECKS4KlLEmDyYlBPToyYDR/7qau3nu9mt
	 bNg2JFNu7FRAPs7cVzstR+AwMmFLaLJvYQ9htkrX7l41lNx8oNB9G6Oimd+G+bBNFuqMg
	 dEVMuUbPwD1aZuCXuQl9t8dO9UhSAri7tB8Xl6DNyM/vppx1XYQXuff15RXAupGopQA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792594045;
	bh=jlfqVju18ELkDWK50mHqBJbzmPZtlNoWP/lGbxWcWUs=;
	h=From:To:CC:Subject:Date:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=QiL+wMtTBvrHtvYsbr5mhbyKtI23biuKUMHsRuxUNuvSPmlVnha2vYjXm/LU8+0Hv
	 uzdL/tiKY4tsyj8kD8h1Lc39E2zDGXQv+5ZIlTcnF+uOzJXTSpbvsQDvg6OLZRjctY
	 ZUkapgoyrYqK2B5SyH7giBsXFsq6ZO92XTw9lDPflZyns3bRWo6XsoyL7B08V5qN6g
	 RyPwwlo/yLZJlzom/+M76NL1t6bzV3d05R/TlvpvBag4pu97J+W0IpN6MdcnnjR67r
	 3oriCzQAaNAVcX9o5n4K9fJa0mGfpPb/3ujR3hMeejJycW+dsdiOsQZZa9wUYCT9yt
	 ELbWfNHITlUwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F098408F0;
	Wed, 21 Oct 2026 14:47:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B4D652A8
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:47:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9A806810AD
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:47:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FnShCX6k6wMC for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 14:47:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 49B6A81184
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792594043;
 b=oetfzn1t9TK6QIEecj8Fa4uOhRKAyRDb+ZTNKjThuXefBOiPS4f/d9JH9OkkdcbxkXI/
 S14CjBmGosT2L4qLPNDE7Et9REau/qXbwFiwCXM+yVrXc/R4XFhhfRP4PM32BL6sKgC40
 zEZC+mnvnQvg5gWDrsuO8A3rzqF7nCDNB8OrQBw0QhVxxhAVRcHIvuc9prZHt++M5llbW
 kxHuGtBHYCr+bhOQAIkPZzsi1bm71hQ/Bo8jXZjup7ClXMvPBe8nfYj8/YMl+9RTym8VL
 Wfvl1oKV0xGsHU8XRKF551oZUFwZ5DN0/hAWM7zERFwvOwHqatrFkADKlRdSp07J9yg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792594043;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Authentication-Results-Original:Received:Received:From:To:CC:Subject:
 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
 X-ClientProxiedBy:MIME-Version:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam-Untrusted:
 X-Microsoft-Antispam-Message-Info-Original:
 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-CodeTwo-MessageID:
 References:X-CodeTwoProcessed:X-EOPAttributedMessage:
 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=jlfqVju18ELkDWK50mHqBJbzmPZtlNoWP/lGbxWcWUs=;
 b=ls44asMRKHfA90a+4FSo3TMiiespunBqDsTsFCseMjbdmy+M0dSRILYrNlnY4EgYM7g2
 IIwMV2G/3cyFc9vMZaFhlioHDstjxxIWlMaN8WjWV+cn/3qE/8IVQPnlO3yKALb8odAEC
 naxGfitIbXkqyMtIlcTXr+gXyJtiEVbHkqpNOeJiNDX4Ym2swAHZa41uX00E9EwtMD6Hf
 7VbTGkhZ7afrBhUnGY6p16NC/YZMHhNBy9MNbeISp7/O90PkzCufc1rMTLEEhxIb0kJS4
 hEn1TGd/436jpkYi/uBkuhuVcU/hJDmeK3FerUB47Tqi08aQEkHFTNU74ERCdy431Vw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=topic.nl;
 dkim=pass header.d=topic.nl header.i=@topic.nl header.a=rsa-sha256
 header.s=selector2 header.b=XffA9PXg; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=mike.looijmans@topic.nl; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=topic.nl
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=topic.nl header.i=@topic.nl header.a=rsa-sha256
 header.s=selector2 header.b=XffA9PXg
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 49B6A81184
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 14:47:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i5Iall3qXDoR8AVkTRql5MGhAPueaz5jpf+r+MMTe+O0WvoZkbGfP5SKFoiwqldnOtWKynjSjCJIMfE1fjxuH2crYbv4e2JY9wH/TGNDhq28wEMEhUIGQpQv4K28kCvhTIMSCmf0Uys2D3dO086BpHhIBljfg5RoGbA78IiJjcJfz964pSGJiCPKAXGr3nlRzi8N9EPGs6u97WmYwZYfNHqbMZz4fyBDsUQkjuqwdu9yja7Gl+vaW9ZCgUwfqFkZw258603qN9f/IHHG+PT7SghJv96q3YpE2eu6dzcNOYwyuH0PHcOr2H2XNnNTg0IN4xyIrYn9BI7nzzY/v4sY2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlfqVju18ELkDWK50mHqBJbzmPZtlNoWP/lGbxWcWUs=;
 b=KtB2XxS0C+hlWwBPrwRj0coPeDsELLKQcJqFInxCbouIz3Y8fWe1yGxrykwY2KNJXh+/n8gYad9iSqrcOXpdPS1/Q54uYr3eFcrtGrBzNdiwetebC+s/MK2rleF9MB9ZV6hI2nLqU7x+Uy6pRBB93AUaH72OzUJTM/53iH7Q12wExMQSGtOQcnzuqFIi/++wF1TDKMJPslt5rPGaVfCMWzP6f+VYcGjWhHeXJebm3Z9bvUxwWZg1S0J777kI9Mn01Zzv55gAgvNvCz5MLG1SxQzcqzJOMvJAO/a++nkF74LTayCIx8ULIO8ry7ZMWUc+1+3bLcj9TCZ3BiUbsama6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=topic.nl; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=topic.nl; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlfqVju18ELkDWK50mHqBJbzmPZtlNoWP/lGbxWcWUs=;
 b=XffA9PXgDBi2/OAT2CjADKIC56537SRIiUS1GgZDoH5INRBaNVTu9wBB3SjstcxdCOU890qK7rFOgxQ5rR9DmHznFwCXwXwbPglB6mQN9+8JCstCDpT23M8iQbI3f7CfCm5P4WVPNIpVoqkGBjCeydbgUYtgd/0pCo0CHEMQMLZ3r1QSzYjmVgMVFUBnuZayHhedvqZWqnWLqOCnoxl92PAzN8rU/6rLl5VuPPJaFKBa60RtmcsezVRNDMiP5M1dCTBoIq8e/UINRldPTFCT+fqUXh98+tWU+o+9gFohcNhgSNKNTPNjSg0XfgkUBSVtOQRPjtXY8atRbhpaT12CYw==
Received: from OS6P279CA0106.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:3c::8) by
 AS8PR04MB7624.eurprd04.prod.outlook.com (2603:10a6:20b:291::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 14:47:15 +0000
Received: from CPH1EPF00000529.eurprd05.prod.outlook.com
 (2603:10a6:e10:3c:cafe::8a) by OS6P279CA0106.outlook.office365.com
 (2603:10a6:e10:3c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 14:47:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 20.93.157.195) smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 CPH1EPF00000529.mail.protection.outlook.com (10.167.241.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 14:47:13 +0000
Received: from GV1PR07CU001.outbound.protection.outlook.com (40.93.214.97) by
 westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Wed, 21 Oct 2026 14:47:12 +0000
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from VI0PR04MB12030.eurprd04.prod.outlook.com
 (2603:10a6:800:316::24) by VI0PR04MB10103.eurprd04.prod.outlook.com
 (2603:10a6:800:24c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 14:47:08 +0000
Received: from VI0PR04MB12030.eurprd04.prod.outlook.com
 ([fe80::e428:3105:17ec:8224]) by VI0PR04MB12030.eurprd04.prod.outlook.com
 ([fe80::e428:3105:17ec:8224%4]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 14:47:08 +0000
From: Mike Looijmans <mike.looijmans@topic.nl>
To: u-boot@lists.u-boot-project.org
CC: Mike Looijmans <mike.looijmans@topic.nl>,
 Akshay Belsare <akshay.belsare@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] board: zynqmp: Remove 1 second delay in psu_uboot_init
Date: Wed, 21 Oct 2026 16:46:54 +0200
Message-ID: <20261021144702.8027-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0051.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::10) To VI0PR04MB12030.eurprd04.prod.outlook.com
 (2603:10a6:800:316::24)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR04MB12030:EE_|VI0PR04MB10103:EE_|CPH1EPF00000529:EE_|AS8PR04MB7624:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a8e051c-7e26-41e0-fa1b-08df2f8231ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|23010399003|38350700014|56012099006|261009223027099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original: DeY5FDYsKiPKN4uZZ1eB3F5uuHk0O7y9RQ1wQ6TD+3Lqzv0je9KqgaQWUkn5IFPIgOE81YZyyztVRzqsT/d53Is+9DxjfZzpeF7LDMJXvEu5SkbpVpyy4LLKoyADpwuOKyKZeh4PgmY5U0iSbLRhiaJUe2bIn4T29eaWNM+t4HJGrWp+iR5Xq5F5eqnvF6QUeRCYl9hTzKnJl2AZ86712s5VPE84cdpC3u4PQgOFzcOmFYRufW9nj9HSt3u2Vs54CjzEWRgYlhWNlptoS6y4IJ0ewj7RqHLl2YeOclPcOpWjXZwkuGZoxqYGeTwWsfJ3qlFHO83gnp0fUDFlOtgSKdCCARGvt1TTTs0SnoZEQXh904ZOyEhXfYUl5ReH+fceqRNmQXHq0evgZ8yH2wGt7nGoGCGDwWTinyeUxVRmR6qZE2aoLUtDJN75DuLF4Bl7ULIyxNAW1aVeRWT1AAeCyPp5J1DdnL0V67jtTOR2XkS/0HTY/cG+4p1XTNJHwOjA7CLjH2xZ5iVgaVQzJTFXPtFgj31a/QTDqnjpQFdQdr8E7ZXfhgL0QL9klL9VPkIzPBvvizOMd0d7wssG9oxjvbfV85kcCHnPvPtokTgyZghWO/uIw5q0N8ZIJjsq3QWXgrh5mOjoHj5MB7ObLHSJCJaEMV2wYa/ga8OQlRCyIqRWGoNouPByTbK5CBzcrnG2CJBYS5Tf3oH4BFtA5+iTTOjc+lptazBZ1ltKgP33ofQ=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR04MB12030.eurprd04.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(23010399003)(38350700014)(56012099006)(261009223027099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-Exchange-RoutingPolicyChecked: btS0MYKjEhELmS6BwSJtGtKAOhSbkDZRRVXmGCluYiL4RlxzMAN40qaNg6aU82nnfyZTYhqbmDkTUz0x7b6NzqAI8VVFobr3uS0UvNNtbw4iPvpCeQ/pklT4MHPW1GjF59Ywvj3pTLGOnf5BBJ197JLg1WMG7xrQ+BFsbP1ynBXSVmyqgIHH7D6fVKuqralRCl2L7um1WqGvTqj1rtFwrKFESpRA9Togxq9sCMkW9RalIKWOKlaw59sO3bx9NwBzbM/1AWBKp4xJguUFHPhfd1umGn7Nw8Jy/5M5ORmdOifN0DAgut+u2JrXhcJgRkGXV+UOxRxMQPxHxFqfyGCn/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10103
X-CodeTwo-MessageID: 3ea997eb-6a5f-41ea-aca8-2141719c0c6c.20261021144712@westeu11-emailsignatures-cloud.codetwo.com
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.1317d009-0e43-4329-a100-1e7fd66855c7@emailsignatures365.codetwo.com>
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: CPH1EPF00000529.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: d9963d21-b034-4d53-6096-08df2f822ead
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|14060799003|23010399003|35042699022|36860700016|376014|1800799024|261009223027099003|10067099003|56012099006|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: Feg9535IilVJbUMlm8zrunWsvdGCIII90eTe0jlLwV356f6kYHgtbAbD5/M7EpaqgNRw8U6t2zuyn25+S4HeJZo3SrlQCME4cnoB83+GMe2B6EJHkW/5Q0DYYlNfdOMZ3R+UtqB05SQq8hIcvB/NZbWfCrIkqe4OEv6p3pajuJifmFJplrBTx3bgcn5hIMQFaieC7j/yJbqwNas2EnnOuHyWGgPY9i/BmVvsuNSvqOcBPyqIYMjONGqYvsstJMoPdg6jvBm3P0E+3ouH47cG8wGXyjqkPwFXVhO9QxfblSeDFLh1OpSDZrwJ111cDZXbhE2NLo8PnAG6ziWqeJMb1V+6BJIOSp1spA0i1FWIKNKEIbx3JrvFywrrDYXqEMUbhvf4lUkju56oiGy+yDND8HaFLZ3VbuMLgwo8Ek4KxDY4KyrDDkVbhvj8lrd1IGjsXOAuofyD21RVFzAyrBl1f9Op+yr2lVhOOT5p19rdvKVBf83SKg3fy9YW/Mz9Orxvb36FMNpUvm1V/SIduG9W8O6n245ZVMJ1iqsLCwnODYK4tYdQkNh1cngiKYCI2tdH/UDdMaX+/NJDtHcx5wwMZYj2k525rn9eaxojXnOhegU2q1g9AEzudCkD3nGOZIKuW47pLGejE6XkR/A8pP1yiw==
X-Forefront-Antispam-Report: CIP:20.93.157.195; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu11-emailsignatures-cloud.codetwo.com;
 PTR:westeu11-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(82310400026)(14060799003)(23010399003)(35042699022)(36860700016)(376014)(1800799024)(261009223027099003)(10067099003)(56012099006)(18002099003)(13003099007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NyUp+59CZTrkGwsow+ix7T3usr+hWiBXVhDm70da+NIFTkSma6VEg0JTgPqvUHze3iC0diA0w4pfinL1d04Ie3YpIeYrfjfwWGHuXO3A+J49jGotSEEJt3afUYE4x7g/NR98cScYspvsD6960k9VPZhc92Y3xIcdeJaoqyO2PIhk7aJRSr/Pd/bC++VDutbVL5tFx+5jQ3TY+ZBPKMv77Mscwwu7UzGEpB2i6b7c35a1KhDAujMcxsiGbOvKRhwlNt6iG0nsevb85uB58VrM5/zPrraFCa/XD0lzjNLQiST+aCclAKu2MLZwjwWJG3s5UKR0vPPKU9LOhihSPtjuLTdRqWeqvbfaENDmj9Pn1l8t3TSDn5bwlmMT2wi240ljqZaJ/H6LyYO0fOpXFLsrQXeGh0eCxVdhL8uH4MUf5Lm5p8R1KRG5OLtn5VBNXzBj
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 14:47:13.4698 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8e051c-7e26-41e0-fa1b-08df2f8231ae
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3; Ip=[20.93.157.195];
 Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: CPH1EPF00000529.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7624
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

There's a 1 second udelay call in psu_uboot_init that supposedly waits
for clock propagation. It was likely added somewhere in history as a
workaround, but testing shows that it isn't needed at all.

The psu_init routines internally check and wait for a PLL lock already.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

---

 board/xilinx/zynqmp/zynqmp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
index c7464b493c5..0fe0c34df67 100644
--- a/board/xilinx/zynqmp/zynqmp.c
+++ b/board/xilinx/zynqmp/zynqmp.c
@@ -81,9 +81,6 @@ int __maybe_unused psu_uboot_init(void)
 	writel(ZYNQMP_CCI_REG_CCI_MISC_CTRL_NIDEN,
 	       ZYNQMP_CCI_REG_CCI_MISC_CTRL);
=20
-	/* Delay is required for clocks to be propagated */
-	udelay(1000000);
-=09
 	return 0;
 }
=20
---
base-commit: 62c9805d8d57cad407f0295879cc9a6182da464a
branch: zynqmp-init-no-delay

--=20
2.43.0


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topic.nl=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=
