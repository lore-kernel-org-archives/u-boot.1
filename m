Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF53C79FB9
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 07:56:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6D55340A48;
	Thu, 10 Sep 2026 07:56:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eQa6bYbYeMWA; Thu, 10 Sep 2026 07:56:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 789E740A2C
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789027003;
	b=Bi/Dy+meIZrzvwjJvgd3xR0qr0H4VCNWsc553PvhH7zFGJJa6NIyJ5+SPNdQL9Yvak3Q
	 F/peNnBJ/OIGQKugeIbUAac5fzFfJ3PgpeL5hfduAwvhLDQElRnrbb3waVZx+yCVJ0U2h
	 I97ojtl331ufy5CH4BNP1UyKSuZIySFnGHLXWWE6eQ7i4DRC3rIRcQB4Fxi3/vj9vEF/F
	 5HyHcqdJeJa+Exx2I9uzn6SMlcojyH+WA+4p4oj+U6mNyQrHnp35SykXgwecOrQbbFV1Z
	 I/OyZvz05Uy4GDA5IuYxt64TD5cZNhIAt8sXiuzT8/gZu5mzlw3Fekvv1RNepj0XV+A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789027003;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 Authentication-Results-Original:x-ms-traffictypediagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-CodeTwo-MessageID:
	 X-CodeTwoProcessed:X-EOPAttributedMessage:
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
	bh=lCVLLqqtF7GUm6nNlyN71/TlEL90RRgiivtbuxC2lAo=;
	b=GSLI35HkPM6p5WpSc+CjausAnOkcskhlaMA1m2QteO16mine+Yo7MNg1wuATvEMkYaxc
	 mWqnYYAcse3aI9sAk2M8BFIEOvRt+xJw7+fkWqtnfhOQcihuvghSZPFJbBlWjofd9yALA
	 bQBYqo9LGti6eVzxyjBtA0QtQCvbhhzUxLd4ft0DXzKVpxLEuY90LsNj8ig35ehZe25O+
	 JsPqJfdg86ryK/l9qWBMCGPniE+crxC0wo5AQFDyNsQ1Z9+sgd/r63CysPHPh/9nQo3Da
	 Pjt1k/W3wSCtlAu8k4PmHKWba98d/btNmLPAZp6kftIl1cQVx/Z5z/3N21cbdhooEsA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=sttls.nl;
	dkim=pass header.d=sttls.nl header.i=@sttls.nl header.a=rsa-sha256 header.s=selector1 header.b=dC1XblsM;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789027003;
	bh=lCVLLqqtF7GUm6nNlyN71/TlEL90RRgiivtbuxC2lAo=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z4CGTTH/O2aSo/Ty7CYXDjuTnqRjZ26LvOHBSERqye5eTG6lUNNx9EZcQww/1skSm
	 XGYfdgUXYDtz5eXrRJipdjbYesavcD5jjNtOGS66cHs7VoRJLWPmTUGng7Cp/Ipo+G
	 yoUxCIWVQwC0h9CFl00oAWLbpn79c6dOwAsXEJbiwkuU+8veeHES7nTATRrB1i52HM
	 FatXc/IJkMQbt6k1e9Gw+ckENu7pmkx0t2WgkGZRCkBKxotoWHqoTwybbybgqNa1HP
	 zsc+m8LCS7yXH1d1dEU3W7UbZgB99HGYuRH9tcmdURqGBSzT85ERrRQdHddI+DMhnf
	 BfK6WnB5VTH1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 789E740A2C;
	Thu, 10 Sep 2026 07:56:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CA4F4E11
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 07:56:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BC06240A2C
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 07:56:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CUMhxMZBvneK for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 07:56:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 792C240A22
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789027001;
 b=kvJ3PgFQc2M57k9pLPlhCiS/aul6TXlxj3lLFd41D0DMMuDIxTWyTTW1WGMRs7nAgB69
 2zcqtNu0d5C/O0dJ4S2KzqAVGA179gg1KutIpgxI+zHprzsesGKDFfXu6jzd9zrPw5P4r
 vIrwO+d4ZLJPqMri7A9g46z2opjgGWtjzaciVoIBlSduro+THWyAGog3yyrAcKqeFgJG2
 V88nJaFADLpA6RVRJIl+VXni06kvkIBRzW1yM7e+RvzRSVP2aWtEia8yRhfzRjbz/tFTB
 hgnrmAb22f2YTE1n4PD+2ALcHjPEexbb/vy9dWjXtgqlTZb/J6eGQeFZ0R/hIME0SAQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789027001;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
 X-MS-Has-Attach:X-MS-TNEF-Correlator:Authentication-Results-Original:
 x-ms-traffictypediagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam-Untrusted:
 X-Microsoft-Antispam-Message-Info-Original:
 X-Forefront-Antispam-Report-Untrusted:Content-Type:
 Content-Transfer-Encoding:MIME-Version:
 X-Exchange-RoutingPolicyChecked:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-CodeTwo-MessageID:
 X-CodeTwoProcessed:X-EOPAttributedMessage:
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
 bh=lCVLLqqtF7GUm6nNlyN71/TlEL90RRgiivtbuxC2lAo=;
 b=obCpNoyfDzB+Ua0p6XX0J9YujBwPDxTBxKD5Jyuo1bx7ApMzm5K8ZYYOJIwV+ZieKqzC
 GE0T11bJf0plofyby1uWv0Nu5gsecPUaPfm3rkRSTtCqugI9vmuwRqh+t28OZQAKzjN2a
 Fc1IAdLCJSD+qrdJInlJmMX5gLapAYcxfzmttJZmUhDeuGS27NfBNWNwJEaMWMNu+vIBP
 zKL984MHI5CBWYsj7iKegLk9YLN54FsRmXYEk4Z3/NOflBiBsjYe2yyIqyOkG86ZMGXlJ
 piTbBWpPHW/tLW9Ki0ymo6usD4GO5bxvIHubW2mjDqM3PlbVIBypXQUTxxsyE5cateQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=sttls.nl; 
 dkim=pass header.d=sttls.nl header.i=@sttls.nl header.a=rsa-sha256
 header.s=selector1 header.b=dC1XblsM; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=maarten.brock@sttls.nl; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=sttls.nl header.i=@sttls.nl header.a=rsa-sha256
 header.s=selector1 header.b=dC1XblsM
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 792C240A22
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 07:56:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7Pro/s+sEaxOvLKUprdNZHd1T39sYJYQ+cjQMBB8g38fJq4E9H+soT4A+3f8GCMvIcfC4RvCQh5J0yUhA4WwYLqTq124jA8UzhKnzwXyC8UcKvZr+t6AngvpqH3/uCFqhjec3FuI64hq0fdISMkK+WgmG7ck6VB+sn0u6ISXjC17JJlLRDfpp9I+d6nJrBSsfoW32yVFgz8LYcZMLbO9vK5C+MTELlYt3d3k+3gbL2jfU6uZ1Q9h79p3tYIt94Kx6V3Qbpm9xRd5aYWU68sGZ99vhOaKAbVA/w+mWM5Y4j8EWGa51MAxN89TNU9PH9lVJE8HWFBOB1yEmP3RK+W/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCVLLqqtF7GUm6nNlyN71/TlEL90RRgiivtbuxC2lAo=;
 b=Fb69BbzGSr7H9OgWY1lNPxHNPpo6cvuYt0c6oYk5ILhJ8XBCcEe7v57p9qNdUr7MsoTVrQMd4RX0PBAEmuZK3PqizNheCfOopgWjUNiLtkyVupeioG5nrn3ohHChyEZ7TQ9lGEHWErir8IsFOqNS0a/9BaCfEnajrcr76qf9pxe5XtX6bqAe7PzGDke6tKGliI37odt3ilhG9nWAN7mBBejoM8Agu3Yuro43VCyQo9SmvSyjkhpPLalwJ95DPB9CrfVh9eKCt3SErzS3VUmh7ObZM579CO2Ym3zHEw39ZEtjCLUd+eENdHxvO5m5QFZVHnM7ZwXY0Z74tUTykeY6cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=linux.microsoft.com smtp.mailfrom=sttls.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sttls.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCVLLqqtF7GUm6nNlyN71/TlEL90RRgiivtbuxC2lAo=;
 b=dC1XblsMOQFmkqe4HPh+MFuS9b2vaBLKsj0ma2GGhpgfXy1Zd5CrUtlBC8yASTSUHHvX7q9G+3Ijgrr2mNB1PUkQHLBlcAvinYrqkCfqgzZTraLi9dE60IbIvIZtZvwZ/EpKGlzmFMf6s/m7Vu1HkJhwK1jBWuHxeZZLtLtprOe61uX08wI3raMEo28Vghbulif3u6+JIsFKab6DBHJsUEnOkx0MgBUdbP/yOZKbK/q8YjldAsL5qxTeyRSOrTGIWPMz7RnWLuhZLMynv6CZGWeskR8U0ViyEgf9Y/WS+g3FtvcG1MvHea5ux60ou5mgak9TmlzpNahkS28CBdAgZQ==
Received: from AS9PR06CA0732.eurprd06.prod.outlook.com (2603:10a6:20b:487::31)
 by GV1PR05MB9772.eurprd05.prod.outlook.com (2603:10a6:150:a5::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 07:56:32 +0000
Received: from DU6PEPF0000A7DD.eurprd02.prod.outlook.com
 (2603:10a6:20b:487:cafe::a7) by AS9PR06CA0732.outlook.office365.com
 (2603:10a6:20b:487::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Thu, 10
 Sep 2026 07:56:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 DU6PEPF0000A7DD.mail.protection.outlook.com (10.167.8.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 07:56:31 +0000
Received: from DB6PR07CU003.outbound.protection.outlook.com (40.93.64.92) by
 westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12)
 via SMTP; Thu, 10 Sep 2026 07:56:30 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 (2603:10a6:150:2cf::21) by GV2PR05MB12786.eurprd05.prod.outlook.com
 (2603:10a6:150:353::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 07:56:26 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::86e3:136c:737e:e29a]) by GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::86e3:136c:737e:e29a%3]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 07:56:25 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: Sriram Sriram <sriramsriram@linux.microsoft.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
CC: Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, Drew
 Kluemke <ankluemk@microsoft.com>
Subject: RE: [PATCH 1/2] board: xilinx: Use strlcat() in board_name_decode()
Thread-Topic: [PATCH 1/2] board: xilinx: Use strlcat() in board_name_decode()
Thread-Index: AQHdQJwbo6vaYjctnE+jPPHKOB9Y5bbHcZRQ
Date: Thu, 10 Sep 2026 07:56:25 +0000
Message-ID: <GV2PR05MB1194168C12157621CC125568F83BF2@GV2PR05MB11941.eurprd05.prod.outlook.com>
References: <20260909192047.217421-1-sriramsriram@linux.microsoft.com>
 <20260909192047.217421-2-sriramsriram@linux.microsoft.com>
In-Reply-To: <20260909192047.217421-2-sriramsriram@linux.microsoft.com>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic: GV2PR05MB11941:EE_|GV2PR05MB12786:EE_|DU6PEPF0000A7DD:EE_|GV1PR05MB9772:EE_
X-MS-Office365-Filtering-Correlation-Id: 7546425f-7167-4996-6fcf-08df0f1106d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|23010399003|18002099003|22082099003|56012099006|38070700021|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info-Original: t556Hv/arrYqM4UjqVtR3VugAi5gcTJ87L0GwfAQEDFviuBL1khyjPPMFfSWfmtY6r0cEWGEnp26uPBQ3t53GLpQ6C67rNJEsFPao4p6Yms4wwAzJZbTRGh/Y9kiVFV1tIoUZabi39JymzZxizxvpSLtl2jYYX8rDa3jDY1pgn4ivdF2U2ygdhQMUJXE45WhH24gsa/rF/dYc0rxYVGqEdKFydiGcSwC0yT/rdLy5Ct5768jLTucgcGmXcim5e4Trk8zHn6JV5EzDWoitOFrexqFul2IQauBB3z+E36xgiMEKkr7ZAtT40okDmUFN3fMocn03/a/vbDkke+2LstOr+l0dAyPckF+2er7A7lgAYzAChJrHL4cHvJ3+Kau0WI7taUNIkeIKyvjKpD0ZbfIqsjhh4SQ2ELb+9PGLYFBJHdubqEIHIPjm96rGFSuARjFNOQUSaFqHrerGmwPZaAuBgd0tpdNY4mR7hfIbjC2n73EHVjexU96148DieHgKCRrNeVwWi47PS/Qprf9dovdcLwHTnwoDd7I9ah7mpYwWr4w0LRG41SCcUt/SguisHNGu2GR5CZ0B0PuAD4jV41MuH4TuOwwABkXmYFtbCPBpswZ4nWt7yzCDVBohvO2Ys5VedVLgjQ7T8IdDPL6CuLPutQQ0SehkYULxqern9jqNyDxYKJ1p95KJ3SJ0O1YV1E5A+YPQR93OJLoldEaTAQYZhR/wCqqVIcDX4Vo3lE9U/E=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GV2PR05MB11941.eurprd05.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(38070700021)(4143699003)(10067099003);
 DIR:OUT; SFP:1102; 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vb03sMCcQGkgHpGG+hJ/raJA9Oejjwa4+4Ka+N+8bGP0MbezN3YjdyPOITKWiTX0oqhFAibH/IQUTdQBzz/vAcLW+KHeHFvo1ikhHKoBjWshwazV0Qj3ekXc+8uQHn9owT5lqi/iFov2BNw4G3e/GYwYgpoUhIky4R8xXXZnXvcvZP+cVaDaxvVzJiQM7DmGwWrt6ugn97c0ed50EsDSidRqTS88D2WvyoVLWTP2CnwRzpcTCQLDWfKl8DgL7a4bwd8AAkH2vAedKQn220gaL9EIVEV9iwW8vCLcwbvVHRrJ9wx5ZvpbvVN1nhlS4zOKFt5OuO9El2L6m/IKhpgwWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR05MB12786
X-CodeTwo-MessageID: 306a2d57-5a73-4c4a-8b5b-c89d8085dccb.20260910075630@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF0000A7DD.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 42cb1333-f1c3-4f94-ef9b-08df0f11036b
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|35042699022|36860700016|82310400026|14060799003|1800799024|23010399003|10067099003|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: yvYl+qJSK3kizyJyAteS1+dnjRRE3M1NHknN3/KFkAziVycTq11RdfQ0R5mZPrdga6WjEbo5/oAbQC1Wzil54PlkEMQSWwVicba+spoZxr9LW3rTCu9JEBQ5yCAQ8RpYr2QyUztVnbRP0JEpCUNx4kOiF5kiHrditnCoBy2PkGxlcBqHYPPDHtnp9mxTrCLSY2nCToM/HxJsz8XN0sWCznCoCVFYrVROn03n2cmn5uvxsMOjov6LikH5SrX7hVJEgDkNmABp9xQnhJWrSABqhRD4wxvUWblfXsG5eDO2aueHVNp3cut18osQSOL7cbCW8l3SJFXgFO3vFIyuB3H5qL9cyMgFzGs3YCluPTDOuu3wkkZqZzVOvV2+K04k08q6eb2LEEOidf7esQFoUG9fhqEZa8e0FrYMmHsGabtX5a8gZ/TBNuXzYOLcgzkDuXuUYrm3SMq8zIHXrvsCAHLP5YM/DRB/8tgD0bi66VIBeo8fyF/o4RaA7KxTpjqrRSlpsEwT8uW5GPue/RrLXjozf4Z5SCKPp6VCke/cMV8TxT62VD9W+C/vNml6cSg3bz94Kn6CtH3X4PfUIF5JASOsjeWAsm9cdEtCIN+XrYSdje/bfIw4NqSphTjzXrU6LydK762UWbCnd1tv2RWRvMZSQ+/echLDfZDqKWjpUc0HRDhvtHC8XgrDvVremPnL9vaLFufBn/8367jfqHTlwmOKyg==
X-Forefront-Antispam-Report: CIP:20.93.157.195; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:westeu11-emailsignatures-cloud.codetwo.com;
 PTR:westeu11-emailsignatures-cloud.codetwo.com; CAT:NONE;
 SFS:(13230040)(376014)(35042699022)(36860700016)(82310400026)(14060799003)(1800799024)(23010399003)(10067099003)(22082099003)(18002099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IxA7cRb1qu3SiwrNFZ1jc4PCI+hY2qhsDH62X6DIPGcJtL6F0GsVn+4FQhZ+jSPpdlCO5XiK8L0IAgYBqqRlM0xz2JT/hDF+7UAzSH5puOKCQ5QXIZjD7dCf4K8PKaGkdBujQDuQ9qhtps4Fc+/WymywN+9pUbIgdw4ok31iLT3aBlXFKvxz21v4vWQ8aGz3aeu3PqxuVMYb5If4Dpmw6mqxwYDyHyt+4reG4OS1Z+QLMTyHqernLQFRyFJzR28pBlJ5KOCaqEKVo0pvg0cwkXzAfuMiEWt7r4FTK3GblC1plKmEUqD1ZKYi2bRINvPZz+vJSL1j+dvNq13ayqENcBp/AkENUEEeH+C7P4zFBDVFVyYeM0uoUnUAbdUJhUOZNppU+VVpqJ1KiGAhxPi4A0/96HfatporyKIgCXcCGdPgFEXm4XygELWOu55n9SRx
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 07:56:31.2395 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7546425f-7167-4996-6fcf-08df0f1106d9
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a; Ip=[20.93.157.195];
 Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000A7DD.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR05MB9772
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

SGVsbG8gU3JpcmFtIGFuZCBEcmV3LA0KDQpJdCBzZWVtcyB0byBtZSB0aGF0IHRoZSBsaW1pdCBv
ZiA1MCBmb3IgTUFYX05BTUVfTEVOR1RIIGlzIHByZXR0eSBhcmJpdHJhcnkuDQpJZiB5b3UgZXhw
ZWN0IGl0IHRvIGVhc2lseSBvdmVyZmxvdywgd2h5IG5vdCBtYWtlIHRoYXQgbGFyZ2VyIGFzIHdl
bGw/DQoNCktpbmQgcmVnYXJkcywNCk1hYXJ0ZW4gQnJvY2sNCg0KPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiBGcm9tOiBTcmlyYW0gU3JpcmFtIDxzcmlyYW1zcmlyYW1AbGludXgubWlj
cm9zb2Z0LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5IDkgU2VwdGVtYmVyIDIwMjYgMjE6MjENCj4g
VG86IHUtYm9vdEBsaXN0cy51LWJvb3QtcHJvamVjdC5vcmcNCj4gQ2M6IE1pY2hhbCBTaW1layA8
bWljaGFsLnNpbWVrQGFtZC5jb20+OyBUb20gUmluaSA8dHJpbmlAa29uc3Vsa28uY29tPjsgRHJl
dyBLbHVlbWtlIDxhbmtsdWVta0BtaWNyb3NvZnQuY29tPjsgU3JpcmFtDQo+IFNyaXJhbSA8c3Jp
cmFtc3JpcmFtQGxpbnV4Lm1pY3Jvc29mdC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCAxLzJdIGJv
YXJkOiB4aWxpbng6IFVzZSBzdHJsY2F0KCkgaW4gYm9hcmRfbmFtZV9kZWNvZGUoKQ0KPiANCj4g
RnJvbTogRHJldyBLbHVlbWtlIDxhbmtsdWVta0BtaWNyb3NvZnQuY29tPg0KPiANCj4gYm9hcmRf
bmFtZV9kZWNvZGUoKSBhc3NlbWJsZXMgdGhlIGJvYXJkIG5hbWUgaW50byBhIGNhbGxvYydkIGJ1
ZmZlciBvZg0KPiBNQVhfTkFNRV9MRU5HVEggKDUwKSBieXRlcyB1c2luZyBzdHJjYXQoKS4gSXQg
YXBwZW5kcyBDT05GSUdfU1lTX0JPQVJEDQo+IGFuZCB0aGVuLCBmb3IgZXZlcnkgZGV0ZWN0ZWQg
RUVQUk9NIGRlc2NyaXB0b3IsICItIiwgZGVzYy0+bmFtZSAodXAgdG8NCj4gMTYgY2hhcmFjdGVy
cyksICItcmV2IiBhbmQgZGVzYy0+cmV2aXNpb24gKHVwIHRvIDggY2hhcmFjdGVycykuDQo+IA0K
PiBUaGUgbGVuZ3RoIGNoZWNrIHJ1bnMgb25seSBhZnRlciB0aGUgbG9vcCwgc28gaXQgY2Fubm90
IHByZXZlbnQgdGhlDQo+IG92ZXJmbG93IGl0IGRvY3VtZW50cy4gRWFjaCBkZXNjcmlwdG9yIGNv
bnRyaWJ1dGVzIHVwIHRvIDI5IGNoYXJhY3RlcnMsDQo+IHNvIGEgYmFzZSBib2FyZCBwbHVzIGEg
Y2FycmllciBjYXJkIGFscmVhZHkgZXhjZWVkcyB0aGUgYnVmZmVyLCBhbmQgdGhlDQo+IGRhdGEg
YmVpbmcgY29uY2F0ZW5hdGVkIGNvbWVzIGZyb20gdGhlIEVFUFJPTS4NCj4gDQo+IFVzZSBzdHJs
Y2F0KCkgYm91bmRlZCB0byBNQVhfTkFNRV9MRU5HVEggc28gdGhlIHdyaXRlcyBhcmUgdHJ1bmNh
dGVkDQo+IHJhdGhlciB0aGFuIG92ZXJmbG93aW5nIHRoZSBhbGxvY2F0aW9uLiBUcnVuY2F0aW9u
IGxlYXZlcyBhIHN0cmluZyBvZg0KPiBNQVhfTkFNRV9MRU5HVEggLSAxIGNoYXJhY3RlcnMsIHNv
IHJlbGF4IHRoZSBjaGVjayBhY2NvcmRpbmdseTsNCj4gYXMgd3JpdHRlbiBpdCBjb3VsZCBuZXZl
ciBmaXJlIG9uY2Ugc3RybGNhdCgpIGlzIHVzZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEcmV3
IEtsdWVta2UgPGFua2x1ZW1rQG1pY3Jvc29mdC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFNyaXJh
bSBTcmlyYW0gPHNyaXJhbXNyaXJhbUBsaW51eC5taWNyb3NvZnQuY29tPg0KPiAtLS0NCj4gIGJv
YXJkL3hpbGlueC9jb21tb24vYm9hcmQuYyB8IDIwICsrKysrKysrKysrKy0tLS0tLS0tDQo+ICAx
IGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9ib2FyZC94aWxpbngvY29tbW9uL2JvYXJkLmMgYi9ib2FyZC94aWxpbngvY29t
bW9uL2JvYXJkLmMNCj4gaW5kZXggZjQ1Yjg3OTczNmUuLjY5MDk5MWJiNDM1IDEwMDY0NA0KPiAt
LS0gYS9ib2FyZC94aWxpbngvY29tbW9uL2JvYXJkLmMNCj4gKysrIGIvYm9hcmQveGlsaW54L2Nv
bW1vbi9ib2FyZC5jDQo+IEBAIC01OTAsMzggKzU5MCw0MiBAQCBjaGFyICogX19tYXliZV91bnVz
ZWQgX193ZWFrIGJvYXJkX25hbWVfZGVjb2RlKHZvaWQpDQo+IA0KPiAgCQkvKiBUaGUgZmlyc3Qg
c3RyaW5nIHNob3VsZCBiZSBzb2MgbmFtZSAqLw0KPiAgCQlpZiAoIWlkKQ0KPiAtCQkJc3RyY2F0
KGJvYXJkX2xvY2FsX25hbWUsIENPTkZJR19TWVNfQk9BUkQpOw0KPiArCQkJc3RybGNhdChib2Fy
ZF9sb2NhbF9uYW1lLCBDT05GSUdfU1lTX0JPQVJELA0KPiArCQkJCU1BWF9OQU1FX0xFTkdUSCk7
DQo+IA0KPiAgCQkvKg0KPiAgCQkgKiBGb3IgdHdvIHB1cnBvc2UgaGVyZToNCj4gIAkJICogc29j
X25hbWUtIGVnOiB6eW5xbXAtDQo+ICAJCSAqIGFuZCBiZXR3ZWVuIGJhc2UgYm9hcmQgYW5kIEND
IGVnOiAuLnJldkEtc2NrLi4uDQo+ICAJCSAqLw0KPiAtCQlzdHJjYXQoYm9hcmRfbG9jYWxfbmFt
ZSwgIi0iKTsNCj4gKwkJc3RybGNhdChib2FyZF9sb2NhbF9uYW1lLCAiLSIsIE1BWF9OQU1FX0xF
TkdUSCk7DQo+IA0KPiAgCQlpZiAoZGVzYy0+bmFtZVswXSkgew0KPiAgCQkJLyogRm9yIERUIGNv
bXBvc2l0aW9uIG5hbWUgbmVlZHMgdG8gYmUgbG93ZXJjYXNlICovDQo+ICAJCQlmb3IgKGkgPSAw
OyBpIDwgc2l6ZW9mKGRlc2MtPm5hbWUpOyBpKyspDQo+ICAJCQkJZGVzYy0+bmFtZVtpXSA9IHRv
bG93ZXIoZGVzYy0+bmFtZVtpXSk7DQo+IA0KPiAtCQkJc3RyY2F0KGJvYXJkX2xvY2FsX25hbWUs
IGRlc2MtPm5hbWUpOw0KPiArCQkJc3RybGNhdChib2FyZF9sb2NhbF9uYW1lLCBkZXNjLT5uYW1l
LA0KPiArCQkJCU1BWF9OQU1FX0xFTkdUSCk7DQo+ICAJCX0NCj4gIAkJaWYgKGRlc2MtPnJldmlz
aW9uWzBdKSB7DQo+IC0JCQlzdHJjYXQoYm9hcmRfbG9jYWxfbmFtZSwgIi1yZXYiKTsNCj4gKwkJ
CXN0cmxjYXQoYm9hcmRfbG9jYWxfbmFtZSwgIi1yZXYiLA0KPiArCQkJCU1BWF9OQU1FX0xFTkdU
SCk7DQo+IA0KPiAgCQkJLyogQW5kIHJldmlzaW9uIG5lZWRzIHRvIGJlIHVwcGVyY2FzZSAqLw0K
PiAgCQkJZm9yIChpID0gMDsgaSA8IHNpemVvZihkZXNjLT5yZXZpc2lvbik7IGkrKykNCj4gIAkJ
CQlkZXNjLT5yZXZpc2lvbltpXSA9IHRvdXBwZXIoZGVzYy0+cmV2aXNpb25baV0pOw0KPiANCj4g
LQkJCXN0cmNhdChib2FyZF9sb2NhbF9uYW1lLCBkZXNjLT5yZXZpc2lvbik7DQo+ICsJCQlzdHJs
Y2F0KGJvYXJkX2xvY2FsX25hbWUsIGRlc2MtPnJldmlzaW9uLA0KPiArCQkJCU1BWF9OQU1FX0xF
TkdUSCk7DQo+ICAJCX0NCj4gIAl9DQo+IA0KPiAgCS8qDQo+IC0JICogTG9uZ2VyIHN0cmluZ3Mg
d2lsbCBlbmQgdXAgd2l0aCBidWZmZXIgb3ZlcmZsb3cgYW5kIHBvdGVudGlhbA0KPiAtCSAqIGF0
dGFja3MgdGhhdCdzIHdoeSBjaGVjayBpdA0KPiArCSAqIExvbmdlciBzdHJpbmdzIHdpbGwgYmUg
dHJ1bmNhdGVkIGJ5IHN0cmxjYXQsIGNoZWNrIGFuZA0KPiArCSAqIHBhbmljIGlmIHRoZSBzb3Vy
Y2UgZGF0YSB3YXMgdG9vIGxvbmcgZm9yIHRoZSBidWZmZXIuDQo+ICAJICovDQo+IC0JaWYgKHN0
cmxlbihib2FyZF9sb2NhbF9uYW1lKSA+PSBNQVhfTkFNRV9MRU5HVEgpDQo+ICsJaWYgKHN0cmxl
bihib2FyZF9sb2NhbF9uYW1lKSA+PSBNQVhfTkFNRV9MRU5HVEggLSAxKQ0KPiAgCQlwYW5pYygi
Qm9hcmQgbmFtZSBjYW4ndCBiZSBkZXRlcm1pbmVkXG4iKTsNCj4gDQo+ICAJaWYgKHN0cmxlbihi
b2FyZF9sb2NhbF9uYW1lKSkNCj4gLS0NCj4gMi40OS4wDQoNCg==
