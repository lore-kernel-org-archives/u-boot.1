Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD941606A31C
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 04:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lIcXGyzS;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=HvnkhqLy
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9DFF0608C7;
	Thu, 12 Nov 2026 04:24:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T-IOOqEVxhgd; Thu, 12 Nov 2026 04:24:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E027E608B0
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794457482;
	b=ZHTlzoRcYC1qf7ga0EKBkeswfmVPF4eLZZp83XPC4ibXm6EawZ9uxdck/wc7OgRO9bOs
	 6lZ6Oppgfj1SMpqKHIKv7ECYKsccFEK6B0CWm7oVQLwS6gY/QYWBUryXJFyAQlUJSaYNL
	 OLovNjcNKbv7flDZyU/EOFUea5sihDkptXDogGYCY5nbNsl68D6EGPwvKRTU6o0bs5tcE
	 HuvBtOOiVVjC5YCCRD1Dx/9spWkqC415eFm7o2zpcrCuvnnXuPOGoQKaPUOLrSShzVDuc
	 KLYL6+vdw0gwHOOZdk2yr/Rh1sLaT2VVb/dtyyoFhx6g28j12z0WnD6EPbG0d8ymylg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794457482;
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
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
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
	bh=5qe7wbchfabokXUdnYHQ9Ma/TGPC2cB8QV/Ub6NjQZk=;
	b=k00UJeUW0K5XOfzpMc4PUZswPEpL/pfMCE1nbF2AMdXSHAWIJAIjbE1i0sdQyICb2Eg/
	 aCyFob+3Nw9MKJ/3dYQpWadJx21je64vs2WwdOZg5/Ovk3JnavpkW4V5pyoM2UrCEXMRS
	 2oxUDjO3vDURep85wUb0cp5hD24xbQ2GPMmFt1O70WB7NhcoUCtEApjjXEcjxRf84L2kH
	 YI4MOA/ojLAMGh0qW8/Gw0ucrh063m7VYmvUNkoR6ijLpuPTnu+Dz0X7qbcxl53LxaM3s
	 fKrJL1DIENGUvxMj9JVJvcnL42/DEfpVy9wP3MB0HHNMbfIW0Z5dckgB8ONjWinX4Rg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794457482;
	bh=5qe7wbchfabokXUdnYHQ9Ma/TGPC2cB8QV/Ub6NjQZk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lIcXGyzSk44GJWJlcHfnYMFMxHitpItFIzMl5D4Rgl9p7BEK7bmjiOIFPpyLYj5t6
	 nEZYuI09UIPDAbuKlBz+V06kcWLTyZBItmsK86xxpZ7GG5Er9CXfpnvOm/NdjYTumO
	 3G5qmckfZkrqIrk0dq4CY8pKi44lkh+6HsRTV822WFtE2Awj8CK/pr9qissU9/8UV4
	 1VCV3hasYfqA9+qsUqlBHLiM+NnsWR1b5h2WVSATSfvU40rr/zWuacyXjVX+xDtH3R
	 l/xfIGeMt48KBMnz0pli6WgFMP6OnaKRtlr6KHSgij4kv/tbw+1W8Ws4wSxp1cWlG7
	 1eoOyL8C1oxVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E027E608B0;
	Thu, 12 Nov 2026 04:24:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7AD9B156
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 03:16:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 60511403E4
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 03:16:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LHRkuVOYmcv2 for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 03:16:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 68F4E403BB
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c406::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c406::3;
 helo=os8pr02cu002.outbound.protection.outlook.com;
 envelope-from=bin.meng@processmission.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=processmission.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=processmission.com header.i=@processmission.com
 header.a=rsa-sha256 header.s=selector1 header.b=HvnkhqLy
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c406::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 68F4E403BB
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 03:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qe7wbchfabokXUdnYHQ9Ma/TGPC2cB8QV/Ub6NjQZk=;
 b=HvnkhqLy5a2wxUMzJHdW9EcACIFhrYxyTUPZaTjbSFtk3Wcj064AooUIINDN/KAQaNb0Bq3rfqmKGEaYgn1Tx8IWEy8fSwBph72DzTwLjakHm6xO8JHs5kLnq/gcH+cPUAiqurJSqCc5zhi4+8DreXEgYzyTa72/XVqYgE9XSc85hkGBeS2hr+vk1P/l310Ti7xNKwQpzHTCRgAtJpYx7r1DT29D4sWigpSliymuMigLmmZQa5UOJd+ANuPUiLJD0/f1dWTL7ISZ5+B7tS28DjN2Vk6V7sk1Ffm+J8dXrMruY5CbLGX5VRVA8K4w+3OU5k4rVlp+oXf38qorHBrC2w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by SEYPR02MB8806.apcprd02.prod.outlook.com (2603:1096:101:2d3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 03:16:52 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.012; Thu, 12 Nov 2026
 03:16:51 +0000
From: Bin Meng <bin.meng@processmission.com>
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [u-boot-test-hooks PATCH v3 1/2] bin: Fix the broken symbolic link of
 qemu_arm64 config file
Date: Thu, 12 Nov 2026 11:16:32 +0800
Message-ID: <20261112031635.1739906-1-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0365.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::12) To TYZPR02MB7121.apcprd02.prod.outlook.com
 (2603:1096:405:2c::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB7121:EE_|SEYPR02MB8806:EE_
X-MS-Office365-Filtering-Correlation-Id: 9470ecc1-a47b-4f01-6844-08df406b64f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|18002099003|261009223027099003|56012099006|261102123227099003|261022105027099003|261028144727099003|261021123027099003|261026140227099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: s97m2zT2cRVsIzx5/K94d3DWoN/XK5m6nMMDDjw++a8u1fG+vauhFFIjcYQ5K3eVq64TTzjSbap/VHQMESu3O+ttqUMyQzK65ZnnT98CYS1M+16haWzPZD1KOEVkHxBo6cSShAtNneIkemvihnRYpJb6O38wGUXzssBZBYuV3dH4Ici2eQmW8O3O2ccVjxbBsgqu1seYmGsIByiUuidT4jJxau7Stv54T4Q84DS4cCtJfZbjzvfNfeJJe+3RPRu+P2DyFQDrI8HRszwZFOYpZBkgNQghdLLqCZPi4BoNglQtaUFL2eKwLzXIQXeY5FwR/YU8v7tmokPMzQ9dvcARLe0v78QrPS85ZcG4jFxFwBFft5uDIqnRlvMZ8hg44WZy/UyRHop8/WZgdSU9IQPRmxz3rziaXzJ6VFDuSyI2VEbo65kmZCMYIve2iImJQ0lsrCArQq4F5XdRi/2JsUvp4HEd5l11Li6pHbLc/M1FcRlNQVWvm8o/CkNHuVBDv2QK/alzHZ9NboQTMyfLzXAlRwxoqP5XD2BAZokGSysqPJBVJ2OvvXX6l2xivy5/E5In96IkaujoGCsWGI4tLoSGLHWZ8rp/ibSHwSx5bTyNEIV3GpMG/Ctdo682Ks5V59CSRP07t+C0dSALOLJCuKK05P4W7JIX8EohhJgBSiGlwNw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(261009223027099003)(56012099006)(261102123227099003)(261022105027099003)(261028144727099003)(261021123027099003)(261026140227099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UYaKZDCrup+hoDr+bMeGdgMwcuwzjGq+n1QMheAtzz9dTrzgjnbwzum3qOQ6?=
 =?us-ascii?Q?8ehkcWUiq3p+UN2tDyFLW8y1KZVnbpI8eYVnJDiW4BgE3kOxdoNzjL6FzebG?=
 =?us-ascii?Q?dNiyXBHjT//gB/g0UGV5y0plFSXfpyAOde8FKcV8H7H10QcRC5UaTc+7mLc2?=
 =?us-ascii?Q?inLc+yKe8mP6k//J2LW20W9lUG0cbfycSv5tJ4bWOEfoYx/2DGcloA0qJBY6?=
 =?us-ascii?Q?1dTL5SHHIu6/X2seH47uNo4F8MXKLuTYqGE6Zoghzkmjxz/vrQ5H/RbLUth2?=
 =?us-ascii?Q?K6I8udcC2lp7H0YUNPnT7tyEgNEYzI3CRp7LFGw+zWcpk1Uzh0dbEXDznD/M?=
 =?us-ascii?Q?MBKgm28AGdr0+tO4z5/E+nez3sOEoDIwPmy8ccdVq7VipM9YqnPW08qE47Dj?=
 =?us-ascii?Q?v4nLtTfpDqM1qMz8Qm62HsZhuO6XjIgL0Dg3tTjm9Azc1Wb49qviRbp4j3/D?=
 =?us-ascii?Q?8HVqE46oI5h9GpZiWE8DLeiBJ9o2Wec8HjX0kNdobeK8V1QKcWn3/ob32DhT?=
 =?us-ascii?Q?DQ1tS4u3xpyhtZ/B012FMPxD3pjZiTr6TauqOtxKgD7wsG1FW+cWqG0eC41Z?=
 =?us-ascii?Q?rNkVfxD9mRIgDHUTAl+GmvXVb2ejAeIWVBG5TAnml3QoElwoA8yW32yMQV8W?=
 =?us-ascii?Q?z2CpF8dcNc1fM+u+SuFiUV2b1jzgg2JrgKdAbQxz4GGP1s3bsLJ2Yp6uHEmL?=
 =?us-ascii?Q?tfjftIsydU/B00QAiE9Av2gumkjH/QqHRGckhucKTmujgEzNH47nt/FBXku2?=
 =?us-ascii?Q?3CSpRRIDMBwdyDlEFxuoBzn2FjfWVhr+nIuMgdEhdYAlbTp/tifnJ/s2e6fd?=
 =?us-ascii?Q?5onBtUnS9seHEFRdHcg4Qyc1AfpMxqJgJ+cUXD1A+PMrcDqbeSsfUd/FyFV4?=
 =?us-ascii?Q?yRI4UY3dsJOKnQdK+BKbnfaAmFz4Wo1TgZIZC1FO+ILOyvpXaGTcpHr7ZIwj?=
 =?us-ascii?Q?2JrvgUt0wbNro6LFkzi74Eh9R2obN2qeSzoZ39/IJeyEgiHwiQfKArGR3YWg?=
 =?us-ascii?Q?aXjZ2ovy0iRtog/PVodO69IptxCYyK4McnA/yYGcgHosPKzomMt3fg2tMJ1L?=
 =?us-ascii?Q?kD7XIxp2xmoFIpBZl6awZ2xKvydaQXb+BJ8K3vdk2sAH6iVBuSooK0O1qKsG?=
 =?us-ascii?Q?+Tu8z51yC/q5DW9uj95Th0mjZUPkG3v/pQnzPJdtEIG2JOOVxgoKm8kS/373?=
 =?us-ascii?Q?aQs7mV/BK40McK+Po66LIhKPfNDwIHviasmD4g600ojD9rWLDelJpvbLkosR?=
 =?us-ascii?Q?G9flmUVI46mVYmP79S8RQQwWeam9fbpKS6Zy1kHPWqlKu2WpYP7qXBz7sdu2?=
 =?us-ascii?Q?MHBQYNsDjXJKlJZj14wLOI5EoAlQp+n+DOt3qTgz4lzFC6XdIveNy7risB06?=
 =?us-ascii?Q?9ezK9Z5+hrvfk3MbS1ezPydRFkOtuKhfBcRN0tI5T0Eimf2pIMCt7cP33hzA?=
 =?us-ascii?Q?NRZb3juqgoDOF7TyKW13DiiQ5aY9ISJX+mB71HUavMzQ3Z0o3QO0+/AeT4p2?=
 =?us-ascii?Q?gUtSEGcei8jyQNjnvCQe77rnWVHl0P3VyOlAbIFYVIz7jeDKuaAhYv96ucCe?=
 =?us-ascii?Q?+3+ftum9elermg2w0vEg746UJc1890WWawv7ZK3NJE0VIZCPwBNVVlK57UCw?=
 =?us-ascii?Q?WezC68ISCnwWODJhiEX/x4fyNEeDgubcepfCweuUhSUjGrsSbvn/u7PLLnYp?=
 =?us-ascii?Q?AuUXH/h+MDJO46Zib9kG0IniVbLNR9fuLAS9SubYyxG7jHkxS8U5Jn7xCnr2?=
 =?us-ascii?Q?6bOSa3B13DSadpEbspRIqYOy0pXK3wM=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9470ecc1-a47b-4f01-6844-08df406b64f3
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 03:16:51.1241 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2nFkCC/29bNlBD9TQWigv301TVbT4gX6/p+gAyfrRoQH8pxa62ts9CGbG4zghz8pEnGvNraAS+0zQucG3F6hGw9O+2PRk1FINlevpQG8nKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB8806
X-Mailman-Approved-At: Thu, 12 Nov 2026 04:24:36 +0000
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

From: Bin Meng <bmeng.cn@gmail.com>

Commit 48a0f7fa9619 ("bin: Run the conf without board_ident as default")
renamed conf.qemu_arm64_na to conf.qemu_arm64 but did not update the
symbolic link in bin/ellesmere.

Fixes: 48a0f7fa9619 ("bin: Run the conf without board_ident as default")
Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

(no changes since v1)

 bin/ellesmere/conf.qemu_arm64    | 1 +
 bin/ellesmere/conf.qemu_arm64_na | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)
 create mode 120000 bin/ellesmere/conf.qemu_arm64
 delete mode 120000 bin/ellesmere/conf.qemu_arm64_na

diff --git a/bin/ellesmere/conf.qemu_arm64 b/bin/ellesmere/conf.qemu_arm64
new file mode 120000
index 0000000..dee6855
--- /dev/null
+++ b/bin/ellesmere/conf.qemu_arm64
@@ -0,0 +1 @@
+../travis-ci/conf.qemu_arm64
\ No newline at end of file
diff --git a/bin/ellesmere/conf.qemu_arm64_na b/bin/ellesmere/conf.qemu_arm64_na
deleted file mode 120000
index cf56db1..0000000
--- a/bin/ellesmere/conf.qemu_arm64_na
+++ /dev/null
@@ -1 +0,0 @@
-../travis-ci/conf.qemu_arm64_na
\ No newline at end of file
---
base-commit: 59437fd1c7a6a84da05efe5cefde47264f78dcbe
branch: qemu-arm

-- 
2.53.0

