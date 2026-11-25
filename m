Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846E4606A321
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 00:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hrpMx4bI;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=HRtIWUZt
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4CBA1605F0;
	Wed, 25 Nov 2026 00:23:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i5xf55y4kc7s; Wed, 25 Nov 2026 00:23:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9DC52606F6
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795566180;
	b=cDncsFsCa+ln/108HjOmYOjDXMBPhd8YVgCIg1rX10XPwYfkocOUAqOeISoZH/GyazNX
	 pRGSm1didivQSheaMW2+3bVhnxUUzasG68Ll5ujVKGhACC0T5SoDujna/3c3EGDhix9HV
	 iWPTQN+1+NRqnTX3iNk8TVz+yMWnO2R0l7yMhfMjR2hfscnL9M9L5R9VusLd+Y5aVuwLi
	 1wTSrW8w6ookMpUn3RBqHOWw9Wt+Qy+dF7IKVrEKIYFNGLtv8pwD/2F5Bdc7gku77kH8O
	 HQ+Gy0CdjCnIkWY6QsckzMTbSUstmHeK0wNAglO7FUOCycM2Je2qiFLeeM3trUZs0FA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795566180;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
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
	bh=I6WdiJcdXr/grA7ROzzfyywyeHkW6u08sSMgQ/SmDaI=;
	b=OVvpn7mg5rZGE6M9MOoVMBIzdoBzPPJKBvO0orAfQwdQXEOof7lJDaZR9YnCx78FB3UI
	 9pr7jfI/MRUR6Yuflw5TY0K5Mc5Q7AEnRYIbotdR1mtWo//4cPzw7Lrs46hfpJW02jqFy
	 sWc2kyEidt4SA9f/mo/mp66YmFEP5VLoOUHvvRtV+kBGTU8IgPVw0vti9BsYXveo6iDes
	 ROZgsynOC/X8YzcT54jCIjmZhzAGNqoi42rEcQoSpR/Cq419RanVuj+FYHcr5AiEstIFL
	 QgjDJx8O28TPYnadb57sEjYOzkDyqfHv1xhETZShLTIIT0ThB3aKD1BTfxBIAS3qAtA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795566180;
	bh=I6WdiJcdXr/grA7ROzzfyywyeHkW6u08sSMgQ/SmDaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hrpMx4bI0ochhBe4knY4ssbU0gTpFxL2aGIwQLuvAeqnv5iCHKdMPuXROEH5/PI49
	 qj4qub+zLr+xXypXGOooWm1yaYJSXuijReu67VLdl3m3aumwHxEc966pxotDGF0ve3
	 CXKwFrYDo5ewuDGthOvJcLmTLLxhGdONcmYT5c+TJS0drVUlBJKIyA4Fsz7OXC6P6D
	 xVZo1HnjP3c6LfR7Xb3Ub3AJ7a8/NhM1CX1js+W/sNB0L/pzsO6EH0E86XdLekEvv/
	 5O9eAomq2AbpXFY9Eue0Gc2b/6aAFxxsr+T1WWYglVPsa4Z6FrIub9FEgKt7jAtHej
	 WXrcssCg+NmEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9DC52606F6;
	Wed, 25 Nov 2026 00:23:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A56A82F5
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 00:22:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8B7F880CDE
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 00:22:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WQR-t9XwjKPB for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 00:22:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5AE3880CD8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=HRtIWUZt
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5AE3880CD8
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 00:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6WdiJcdXr/grA7ROzzfyywyeHkW6u08sSMgQ/SmDaI=;
 b=HRtIWUZtubdSRqyDnsDcZyUFhi4qSTUwsRFCWQfhsjLsYe9Ah7xnRlZtNPGOvF4Ezcd2tKkyzdHTdQ/3kAkwFH49oRsHf4KogoT11Lij0sA0y0Lq9yXnOcmf8XB6bKzX7ZymR7LOpu/J9CZFPn52DxKLHR9wfUv5gSnLGR6YMOIjIw5wMFpC8kBcyilMaPLcQ1MaHQ77TCs1pM1WYM3EINaQ9g97r6tmZVxGds9IX2tnYlIYbxQmBnHk6dvpkmn0eJQ3ECK8VizJz2T60l3F3KGsThED5cZt7gppIpWXLS7H84qeY9YRXla71XRQjW6K/yWddwqlkUgQf2Tjl7PHWQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by VI1PR04MB6943.eurprd04.prod.outlook.com (2603:10a6:803:13a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Wed, 25 Nov
 2026 00:22:52 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 00:22:52 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Marek Vasut <marex@nabladev.com>
Cc: Peng Fan <peng.fan@oss.nxp.com>, u-boot@lists.u-boot-project.org,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] arm64: dts: imx: Enable CRC8 support Data Modul i.MX8M
 eDM SBC
Date: Wed, 25 Nov 2026 08:19:54 +0800
Message-ID: <20261125001955.18619-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261124151716.36270-1-marex@nabladev.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::10) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|VI1PR04MB6943:EE_
X-MS-Office365-Filtering-Correlation-Id: c8d7b1d7-86ab-40a6-9d2a-08df4a8a3e5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|19092799006|376014|1800799024|22082099003|18002099003|10067099003|56012099006|11063799006|261022075727099003;
X-Microsoft-Antispam-Message-Info: hbw+OpTlZ1MCpsKawkJH24GY9PZ3HrJOcnz47fPvvNhuzE7beLLNh4fdvYBP5PnaatjbwMRVwa9jQyr+4rEhardFiI9tFJ+RImT8B4vrrkXtD8utSvWP6iz7LITug4fm57QLcbL6FdseZh0wgyR6t3QzOKYNTGEiiITuTTT6sEHjWB6kfDf71akngCxDiA0sFP6jGdMieKReR6kDhxkIhCLDd8IiWGt7D0H6t187+efUz9O4WvFwpM+jEKxvWoOwT9IZ15TgLIR9qcqxU/zOhdCPKpLzJO7JGw4bxcBgQRrCqX7i1dHFwOZ3qhqdZylRfdC6bbVzfXAkvuR4pEvFq4+d8/cNZz9fJk2RB7Ri/EobjsWAAwsi4NdB8noM9SjONzlz0yNEBCVZeeXBsothguTDmJ+KkEvTldB6Dl8mlf7R264ZQevlMaOoP6gDRY2l3a8v7J3Bojat+9D67meOHHcWbTOrtzqjZ+Sljbke2MhRdYglWhkR+/WW/L+FsFem7hcLs/P0d3n26GsEvkphJbZxh+fZ5LB8x35JFKC9PiEuoKmYI5XC6CTbhA7mrsPcZ4+bePDu8Ew1OArPt/R6rRIM1IUJar9ZbQghrvsMm7So0Kc11svOzJouyNu14HeLLaqiseoeHTpCPVn3qNzTj2MWmfm48kLrSydtqPCY7rI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(19092799006)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8TGW22zOBj76rVfBGYcr5JEiyezuXYcELzGDZASTSxtXuPvWSo8Ydl7+KA/4?=
 =?us-ascii?Q?S4oErpypQizRy5h934icc+97Vct/EMcvJ26gLm/lOwjjvEXLVqHIIrDIiXBM?=
 =?us-ascii?Q?Q4PkH1AHze5wsN1iy280vNvcpzJp6h/qjtuiX2GRztpRz205iKqLYdLpZhmK?=
 =?us-ascii?Q?azrBBnUR14GTdfaJFsuEeA6damLo/1g0xnaq/QZqwbzyjDZUZcY++x9sFPFa?=
 =?us-ascii?Q?6R63hflOe3SG+XdYw07UWdWCMmAHJ40k8rzGgFgVI/gmMf51XiJovEGXYG9y?=
 =?us-ascii?Q?BJe9FwGH57gx2+dKp+xXsh+K+E+ts6bdeVc1Yix/2HE89YF6lnLDgutel0xL?=
 =?us-ascii?Q?GYl2HaT+bO5rvS69dc06gfbxyrvdsVE9vOJAfHZgc5KOJXoDZcKmJhvS8j87?=
 =?us-ascii?Q?aJZJa6yxFHg+LSGgZwKS2K7R/4xbUJvn9lmlNzFz3k4Yp6sBoWzi+89U0mpc?=
 =?us-ascii?Q?SZtUuuePHtvP/owg4mK45DgOpHi2xUoX4yHvfNSZQ41zyCK74pNESZI760Ei?=
 =?us-ascii?Q?pVQy59dAvO3DCX6/h6K9gAVqifvTVbku/+1VzFq99c+hbak6iHDOoOlIW9Xg?=
 =?us-ascii?Q?gXcGRJMFD78djcVV9vfgXl27gPfsQO1r3SGD38B+hryRyBwItVcR2Y0Y3BCi?=
 =?us-ascii?Q?O6f0fexkRLiDb97OjFm+pwII7h0yOeEMlueZul0badGabhUmgNbD/vT5Yblc?=
 =?us-ascii?Q?GAGuB9Q03cF2yVAtY2AEDZgdrpPyzg9U6EPTUDcJ4bc/pt0Y3Ep6hKFPZzTK?=
 =?us-ascii?Q?in6k0mI/I+tBRSb9T157dUdNqFb1YmLo6NppZW6Jj495TwkbCEzaUZKjKgQp?=
 =?us-ascii?Q?SX0/Oyx/ZjZk7Q8DPUVRiMlbfwMSUIhPhdDUDIs1E8jLaWkxUHZhBACs7jwf?=
 =?us-ascii?Q?chZU+Ou3CQoUxCAv0Fw4MljljuPkE+i2Mn7r0yvoYKgoaiLPYhhxr2nKepjo?=
 =?us-ascii?Q?l44T972XmF6IV6IpUDWCp0SdrRDWAmhKiu71mfm2eqVl7HUA1PS2NMhc9pX3?=
 =?us-ascii?Q?Jfv6NrmChEeUy0Bp1UNJWOruKKJ10weku7lR40S7D1q+k8aB5p2KETnjCrDM?=
 =?us-ascii?Q?upxexLPSvV72DyG3ly/jtg9cv563nck+yvp1yOzMnXqT2yzdcclycb/1k7x+?=
 =?us-ascii?Q?JbIuKe+i6l2dCuNgB49u2zuTjuf2hcdIxKzy5Pocx1jNx6gFsHYfrlHFao1M?=
 =?us-ascii?Q?AxiQYJDz6qXBoeXfv7TXL6wNTd4sbtK/Bkh4dDybZmqMeHItTBO4m6yoD0eP?=
 =?us-ascii?Q?kVpDi58ER85yfh7lsJX98Djr/HgFpGS8vcrqNOkTOIoJrZcN15E156gcT18Z?=
 =?us-ascii?Q?HIbw9HCEC9tgcwpfdSb3+p3FxAdzN1Lfc4cv+NwKjhgJJGQ/Y+WxTTwRSDUO?=
 =?us-ascii?Q?CNTUXyqg10zpNl6xdPsbUYp11oh2/Jih/3lstvtXokzzLzi7ZSSfpAqAoTFg?=
 =?us-ascii?Q?iJ9uX3hW3Eb7okOiDqvdLYZUMNDZsX9Q22ZEY0s9HDHIR9jeduNCbpFvkPcI?=
 =?us-ascii?Q?+CK4jetckmi2CNT6W9l0wVicsFgJv3KbAZSTdUAsqn536G/CDOzLmZVM2RPI?=
 =?us-ascii?Q?fECgy4pOzqrfwTah8t6c4zGQ7mWd+L1TuJyX6FhQsRNWHGTMU8/PSCJBDd+j?=
 =?us-ascii?Q?rI7chBRj4sG/WdD6DyLVVW6Gvx/SYSXm7cl5hobrwolpTQFfS1WsIM5Rxp10?=
 =?us-ascii?Q?isWN7RJanFr9dNTvRdyYdiI2RL3akhdmZm/LD6CcMrqIf1unioOMu3R2YQhn?=
 =?us-ascii?Q?plhPJ2KDV/DMQs9ExyoY7nxcMzj7zT1MIkmr0kbScUKP+KTdNU/v?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d7b1d7-86ab-40a6-9d2a-08df4a8a3e5a
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 00:22:52.3401 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nzb918D0H/bZrrJ2jdLB8EySNUfY/+kP3yBVzlKXSufMsu3uCoKRo0+H8+jf5w8q9hQwUX4tT0TfI/FyGEHE/VRZfZW3aFlRGfiyppzX5B4dj+IIfBJlUVg1XLhlFt8H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6943
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 24 Nov 2026 16:17:04 +0100 Marek Vasut <marex@nabladev.com> wrote:

> Enable CRC8 support in hash command on Data Modul i.MX8M eDM SBC.
> 
> Signed-off-by: Marek Vasut <marex@nabladev.com>

Acked-by: Peng Fan <peng.fan@nxp.com>
