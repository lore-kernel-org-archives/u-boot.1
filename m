Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAB2606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 21:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WEVxib8L;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=w0JbQlXc
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3922860677;
	Sat, 31 Oct 2026 21:55:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GcAQEWah8jOh; Sat, 31 Oct 2026 21:55:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6E5EF60618
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793483721;
	b=EUzlmC4WAg3MbAdzfcpcyL0B0oDa3mhP8S0ad1G6CouWSiVEHUCBYzm0Lb5v0gQYbmfm
	 rebZf6k89hIA+mom23+FmCupFc9ugfLiJ0lDObSdPWWN+a1HajbcT56/Z0eugD51fvjv7
	 xVAavUaRvgY2n0AldRbQ4n4z6CQVH7tn2cB5pMFFaa8akofnCkPKHX1VQB4uTmKfeho1K
	 Qo5eY6NVz+D0unUysud3GnOFUsVJ1djGuMAZup1V2brnU8Oc5IMYxBIZ5bv0b0HdzIFBl
	 ZY6a5PyuVAnfC8n7nZw29PPQEUmdbl2RamNxHrb8741vHsQzbxmK+iFLk87ioPyxYqQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793483721;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-Id:
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
	bh=ywppsVykBr2FFJkjj0CsyadKhxNJObwyrFP3qf/+kOg=;
	b=j7rhVD7Znrw/Y4l0XkuyfQScNFwzbmgVJcSh/cu7R51YZ/WL/NgFUiYZ/U1XplkZczoQ
	 Ef2xfc3sIhJjhPzkVmn/jcOEpMChAPhCE+NNXm/GS9nGpyOgmRfo2xpGzo/KlJ66+cgpG
	 tHziDsSAEIFD6b/DBa+DQEKh8EU0mnt7P2scgruhmbCH1Os0VZRN/39ZvC2xM2z0ewR2D
	 5Icq5bkKxV7VxTyP0CNHOci5nOnwhKfwGyUk/VZMOz6q2GmxakZlKBHJ7EXuJg5zGMOJ+
	 UCDN/bwnrj3FU3r12Zs0cslpI0FDePLN+G1pwOI1gRIbBkwcKBOq16KnUj+k3SeQiUA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793483721;
	bh=ywppsVykBr2FFJkjj0CsyadKhxNJObwyrFP3qf/+kOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WEVxib8LqE1z5FVUvsDZOxW1+Vr/UoK4WqkGAlnVyzDzaANVK6shIewwDNXbiR8h/
	 QIlgJ1JNy+zNVItzbTYRPm9MLGUKxiAHQ2ieJGlKP3Vc/FUqMkNiMaokq9Uc/HSUgM
	 +GIdv5VDiTMs0FDi3F6wtfF/xF1r7pchZgl7bVXXP2VWrE+OT0IoPuF5kijxBTnxgW
	 FOHdhIsycrSi2qghjHHCmUjsJa1PiJRLaukw3x9rG0mLv+v7np31kfw1nP06Bq2Mp6
	 OE13S94+NZeHaZWEWikOQyHoHJ9DAfuvSdJpz/i+GtgYJllkVrzzonW1+VRPsUNUA8
	 AQexxCpit43fw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6E5EF60618;
	Sat, 31 Oct 2026 21:55:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D10BE380
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 21:55:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B76E84067C
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 21:55:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qF2fxuMcfEjK for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 21:55:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0B6394055F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c101::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793483709;
 b=X3Wt9iXQ4XlzZSOcGu9p66G16WUwCDpHgoOAHT0bOFJtHZkuyE7gcOQ7k+ElKg+E9d1h
 kv7O2vtUwiNajFYdIRb7u+A8358BVJMQhBhEXwcEjRxgnjBow9o9mx1qDUnKcyCaS4dTe
 3G5JohVcgYZM8NB37Xi+yCvucYGenTiEqx8+7nuS01XDJYyTsblqVp+MJOTAlI/Dzal6k
 cyumylZmrgQZ3QS9rFEVxArs8cuFgbnMYtZJk+7/UtZ9E8CBO0NOKFVA2M/B9BXGr4ErK
 IAs3AYQjH/vxxGH48KgEvNb1mnuDzfulBCA2I4RNSOzTSCo+74ACDaS/e8hhOo97T8g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793483709;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:In-Reply-To:References:
 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=ywppsVykBr2FFJkjj0CsyadKhxNJObwyrFP3qf/+kOg=;
 b=OH+RxOTrpJgaGixW09c6+H1EAy9yIv1oS/0f8yJq5Xy+82pIs8eJNKPNb3W6G7pRyytk
 eI9Pv6HWzadWdvO/+lkVt+vEXbJC1WDLzoBcNAPcUGqwiYQpIP+2vSJT6Srwrd+fZFrHs
 IYyJ6RoH/+rNA9rX5RrYGrJAg8XXvjDPJ+IT6YEM7DibgBxfYAIiIjvdnO4CYpqXp3WiH
 epvCIHp8KOty9NAjRgvFJ8+byUricPogj08MONzXugYyCBsYai/QF6So5CrasVBWPpgHR
 RU1YD0TeEaYM7m/tXQaWQLDIMzaPteXliK+dnN0VByOWAfX+48Q2VQJ0lBi7SkMJxyg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=altera.com;
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=w0JbQlXc; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c101::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c101::7;
 helo=bl0pr03cu003.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=w0JbQlXc
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0B6394055F
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 21:55:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eE4vRNwa3yZuVKjXT7XSq9k4SGNyRI6mEFl92b06fPz50H6E+gkFCf6rzqGKhZtXrY4ohwILwbV7qy7eVjQmNkbqAMVKAtUvp7vK8cYJJxWdpbhH+ZFF3g8LI03/GGxbcQjtveZetRJnKHVaXPomk7CEACoBsUyu3NaT19jCEyC/q5jg61KkkoOVtrpJV2Q7hpaIcqTNnIkG5bMAFTjY0RKZaZ4Tn5Hx/6tb9Fh4uNuxJ+8vJJzL0Ip06Fno+BhgCcihPLH8NnOhND10cMC696QArqcg/06STwFCGasDcz4BKrq42IZMiD+F9xKD2rmqln0IH+aFl39ANerqeKEQmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywppsVykBr2FFJkjj0CsyadKhxNJObwyrFP3qf/+kOg=;
 b=tKaE/7WF2XRezu0irv6Shj5RRethop3WK7zgwHxeWWTi0nAIL3Q817ejoEJ/QamuQmNNG8RhGPZT4Nmb85V7rw1KSpZiT9hMo9kna4lv8+k1Rld0OhAWOboz4IabZ9NedfECwK2EzmHz/Jke60gtnD86IyvVosTyGAuBrQL5YrASiwGH2jOPktI8nYOeEjfn3rWZRZn0Jx1xqV9aKOkAIAX/b2+wL6GNUg1HhXgaTsNQjP+6xThUqiqDCIBfpaZvUUVzr6H+z2iumgeNrVgHyAFAPfMKcqCwvD05kWtdySlfYhh3vBB241GOeU5N8hEEKFDVhxc1kCN1BOOQCptihQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywppsVykBr2FFJkjj0CsyadKhxNJObwyrFP3qf/+kOg=;
 b=w0JbQlXcAFL4msK1Mucw79J0BwmGRe+XcBJrvm4G1tT4p4/rcRztNLoWsTmOyIvvTkQEhJ/TN6U2zeWZrCCIUWjxWDYpbngtlVNtW33dLSRiUp4BBim7L305zIqk8YtzMEB1L6BNuXJr/tdyDJ+Q2MWHEQWz/CWlqPraDuJPG8PfdjNAwvulz3KEUdBQ5HJ601+r45HbxgdwBaH3a89euFC0diMBju4XQjXBlXSkFsJP70uoHAqOupcjlWp6X88ha+GgPXqpi1WiKPfzG+8uJ0SKkFIoz8y8kxsjQ6sludehScHwgAUPuhH7ID1BST7QTeW7Kp3hviAfDsvVwLrdZg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SA1PR03MB6481.namprd03.prod.outlook.com (2603:10b6:806:1c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.11; Sat, 31 Oct
 2026 21:55:05 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0569.010; Sat, 31 Oct 2026
 21:55:05 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Yixun Lan <dlan@kernel.org>, Tom Rini <trini@konsulko.com>,
 Eric Chung <eric.chung@riscstar.com>
Cc: u-boot@lists.u-boot-project.org, u-boot-spacemit@groups.io,
 Dave Klotz <DaveWK225@protonmail.com>,
 Zixian Zeng <sycamoremoon376@gmail.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Guodong Xu <guodong@riscstar.com>,
 Leo Liang <leo.liang@sifive.com>, Tim Ouyang <tim609@andestech.com>,
 Yao Zi <me@ziyao.cc>, Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Subject: [PATCH v3 4/4] mmc: k1: do not assert the shared AXI reset on probe
 failure
Date: Sat, 31 Oct 2026 14:54:52 -0700
Message-Id: <20261031215452.16013-5-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20261031215452.16013-1-tanmay.kathpalia@altera.com>
References: <20261031215452.16013-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0011.namprd07.prod.outlook.com
 (2603:10b6:a03:505::20) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SA1PR03MB6481:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cdf26ba-d68e-4ada-91f9-08df37999f42
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|1800799024|366016|5023799004|11063799006|56012099006|261009223027099003|261028144727099003|261021121427099003|261021123027099003|261026140227099003|261022105027099003|10067099003|55112099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 2oGxgk+lDSCWvvgSQI5TTfOg/2lZD2PM2ccvrnDWnUpSpHlPgbMZv2spQ97bJ84IydPv2fZ/trUOVeRS4T4X6wB3HkWmZZCxaCspRp4CKU+rLZRhizBYiYYvDBwRm055vZg4T9/6jmENlq2m3Mb4QIOyc4qsWKXVBK1g+9CR50gBqGhDkLnsacBNIpQQLQde1PN8Sptl2C6vQL4ibEl6Nv5H9icHx6Xt4XsGnsebwo6Xt85VUDKMh9B+V5mDveKz5LAUIDFPSUMWRea/sqFfAy/IxbLICZ9OyQgRY+hbhu29FgWxQaBEF9qESlB9pwAojvY+zfhTH2mAAcTCXZOzzNo4XguSbrab5qgpunEfsyYJ7eR1J0uc/3gjHXfssThMEVD3Z22dHeWDu9LrCVTxsXmKxrhAYivfuj0tH27XBFEc28svzJjfBoa0pe+NwclK0rWAl1+CBdmiy5h2FBfnE5abgpcsfyhyBmC1AK0a/8tduUbvWugi6r5XOHb6SEamKUyMgITi9um/CLTJfKhxO1zkZH5YuflwYxxOatbGlInxCmsj4NygP/Ralay/5rj5ODUaaoJt/VWnUSETYVI30Mn/09K5EQ4pr3Hsh65r0dPXchIv+nVg+l8XU8WZyLcMce4TdlTlc0271dXp/mjlzePE02c4Yo9yBKFnyk9cfJ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(5023799004)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261021121427099003)(261021123027099003)(261026140227099003)(261022105027099003)(10067099003)(55112099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aixsk9kL0LoJ8qw+HEh+nVOqumPoP0fqtgeN76FOFzqykeznKrlERs6mHykT?=
 =?us-ascii?Q?24lG7WA70WnoYkq+8pxponLfjiXApLrBxxh1lVtcUau9QtBLBLcy2NO+52oc?=
 =?us-ascii?Q?wxGvPS5TlZVjTcdSh9nxyc2sdGDQLWcFDVmjmN4VZMilWG/QVCoEnNfKsKBk?=
 =?us-ascii?Q?wV0SoMiHHWUWsG0T7+A6c7DjR4dxiIWnHvoOd1Z4AUv18LkWidKNtvTe7QRU?=
 =?us-ascii?Q?BXHI19MmYIwr7SBsQqmv4G0Q73EDBRo2l/AudXx50vg+m1xgld00LZ5BiMLN?=
 =?us-ascii?Q?jmuL2yF45JsoZCxOf4uY0F1QZl9tFpAoUHjOhS6obwIB47L6q7zgr6rL03XE?=
 =?us-ascii?Q?7zV3Yn9c7KOzC+h2rV7p7ScU+hXKN8+jdqf+2XxXZTXZdmUaS3dgVi736mwd?=
 =?us-ascii?Q?EXd2y1QsHsQsEwFzbX3tTb9m6mEXclZesF7I6evWhqhQNjPNnBHy5YnYfhut?=
 =?us-ascii?Q?6UENSeFk8Qdm+PreA27vh59L6hA7xLavp6lTA0vmaCnh3w26sKmNd+o+dD7e?=
 =?us-ascii?Q?ZSTqbfigzzOUSdWQ7UhhOCsihn7D833i+Fve+lRvjLJSg4VWb3KP3KiGHWqA?=
 =?us-ascii?Q?Q7Z+vmTzsyc9HxbGGGhZfFQ5/hf8RsKLr9NoHqyWF0c2hWj4V5Ds7Vb57oHl?=
 =?us-ascii?Q?cN82q0VIwZORBrBk3U+c00N6Dcf1rTKKqBTetElw9gFQ2h/KXJeg9Ia7XFEp?=
 =?us-ascii?Q?9F22NoaDoj03mKGSrOrMS8mbTL9/K72hPX/6xs/zjFbW0+GdoVogHzFQpv4l?=
 =?us-ascii?Q?8PVAJa0+Ba491b9zle3FKm0M7QFxBcX0IsTItrGkAIz6KVPtbbGfqZdsDAvn?=
 =?us-ascii?Q?oILElm3EXdlGcOLsHcLnij5LkGQnFr2rsxjcy6/GddQTvzszS3Thcb5S9n4c?=
 =?us-ascii?Q?Xroc+EOhlNhwzfQLTfuHlaXsF8P5Yma6cxcyCTKo/zHWet68ZSLql6LIvo0a?=
 =?us-ascii?Q?/22vhf4JB9txpkN4sUVWZoIrDe5IFFbIODMdIbcNO89d9DXX5lDT9jE7bW0F?=
 =?us-ascii?Q?YL5zKc7yB617uEftYIkFv0bFMMUVR5DpUS98Kj3x3QE+WvfJBj3eW+/iA2DN?=
 =?us-ascii?Q?XBJNhV/8MtSxZYv/Hkyyw0G1QnTHF8MvzfiHwxzAJbZJqe5fgpHCF9DLbKVo?=
 =?us-ascii?Q?ynY22Pd4IwQ3OwCrgVa6K2nZrk6bhcQ4oX3z/XjVbTT5d3Ue3JFVMaiZK5a7?=
 =?us-ascii?Q?vHxw9qdIv2oMgkZ0QURsWD/cfKBxs7iXPYIpvWzmWdsTlwXcEZ3AiIk9ntOw?=
 =?us-ascii?Q?pI6vch2o7SEyuIWXs0MDbhh291Cl3+vU3l34vWCpoASHU6Is1ZXhMy27/V+x?=
 =?us-ascii?Q?okgAOzGzEW4AMXoxhXH0hSW7sMqWjCxoTPUe5hRTlx9az+VeGETdc6eNx827?=
 =?us-ascii?Q?/0IlhjcbOVOlAHO1dnR/0JHQdSgr5+tZfx/jnhW20uA2/i5EkzAKNxhtjOst?=
 =?us-ascii?Q?i6IHcJwK3EhxyEOKNsS0bd5Y2lzew5HpRHNG/Yw4dS+zRLQfOREKlsst5uHe?=
 =?us-ascii?Q?nka7ixhH11lruyAesa+ooeqn/aViPl00fow4seGJdsUhTEM7bZhdPGLIyPh6?=
 =?us-ascii?Q?qGMDwUwzVtIANZ91AHiw3iXWVQ8ieS3IVNdwInGf9F8oSTTIqSKCZnw3vOJD?=
 =?us-ascii?Q?Eu7gx9Z0C/n7Cs0MIpGGPZSX15/xAkV7Tczl0pLGRZBMbpibyRboZLH8pBxn?=
 =?us-ascii?Q?926oWdSuFuAcfvfzAzCPaZgJU065cGyLeKVZK0XLzuD6ijiRe9r1mt3c5Mvt?=
 =?us-ascii?Q?TwpdNxI9qaYtGYxBSuFgAA/+M/Xt6Kk=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cdf26ba-d68e-4ada-91f9-08df37999f42
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2026 21:55:05.3393 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1/K+Ssp3GdaKhb6HXb6Hphrs0POjZFJGl/NjrZvqYvOGvL515Nqm7mMZnznVNQ4BSrlGsTrz+Ap6SqRvc0gYaj94GNv4quSZ8vTekbAoh6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6481
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

From: Dave Klotz <DaveWK225@protonmail.com>

All three SDHCI controllers of the K1 share the SDH AXI reset, which
is the "axi" entry of every node's resets. When a probe fails, the
error path calls reset_release_bulk(), which asserts each reset.
Resets are not reference counted, so this holds the AXI bus of the
controllers that already probed in reset. mmc_probe() probes the
controllers by sequence number and then again in uclass order, so a
failing controller asserts the reset again after the others have
probed, whichever one it is, and the next access to another
controller hangs the hart.

The clocks are reference counted, so releasing them only drops this
controller's reference. Keep that, and leave the resets deasserted.
The SpacemiT reset driver has no rfree, so nothing leaks.

Fixes: 18e9745c9327 ("mmc: k1: add sdhci platform driver")
Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
Changes in v3:
- Keep clk_release_bulk(); only drop reset_release_bulk()
- Merge the err_reset label into err_clk
- Reworded the commit message
---
 drivers/mmc/spacemit_sdhci.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/spacemit_sdhci.c
index d3748847e48..fdedb9a301a 100644
--- a/drivers/mmc/spacemit_sdhci.c
+++ b/drivers/mmc/spacemit_sdhci.c
@@ -586,19 +586,19 @@ static int spacemit_sdhci_probe(struct udevice *dev)
 	ret = reset_deassert_bulk(&plat->resets);
 	if (ret) {
 		log_err("Failed to reset: %d\n", ret);
-		goto err_reset;
+		goto err_clk;
 	}
 
 	ret = clk_get_by_index(dev, 1, &clk);
 	if (ret) {
 		log_err("Can't get io clk: %d\n", ret);
-		goto err_reset;
+		goto err_clk;
 	}
 
 	ret = clk_set_rate(&clk, plat->cfg.f_max);
 	if (ret) {
 		log_err("Failed to set io clk: %d\n", ret);
-		goto err_reset;
+		goto err_clk;
 	}
 
 	/* Set quirks */
@@ -613,17 +613,20 @@ static int spacemit_sdhci_probe(struct udevice *dev)
 	ret = sdhci_setup_cfg(&plat->cfg, host, plat->cfg.f_max,
 			      SDHC_MIN_CLOCK);
 	if (ret)
-		goto err_reset;
+		goto err_clk;
 
 	ret = sdhci_probe(dev);
 	if (ret)
-		goto err_reset;
+		goto err_clk;
 
 	spacemit_sdhci_phy_init(dev, host);
 	return 0;
 
-err_reset:
-	reset_release_bulk(&plat->resets);
+	/*
+	 * Leave the resets deasserted: the "axi" reset is shared by all
+	 * three SDHCI controllers and is not reference counted, so
+	 * asserting it would hold the bus of the others in reset.
+	 */
 err_clk:
 	clk_release_bulk(&plat->clks);
 	return ret;
-- 
2.43.7

