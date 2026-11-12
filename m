Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DD2606A8BE
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 13:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0n3Bo08N;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=q+fK8MMD
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A791740A32;
	Thu, 12 Nov 2026 13:21:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wBuaDeFpUN4Q; Thu, 12 Nov 2026 13:21:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 585DA4059E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794489670;
	b=SaATq6kKgk2nmPeb+4YpLRIycB/9EM8Ms2FQRXb1HyVIqFT0IALOCQ6oexQ+VJ4M0QX8
	 MzkTqafxuHdRckIi56Xr9dGVQl17zxmTdeAt2smT3iomUYgRpV4Ij97J0cO9oIwEIYUQm
	 6oVAkKKJUwviqhxVYxBsC8eSYkD9eVnA9uQBhUuTu0hjzghCWifHnehBmYRylGdwZ6bie
	 ukMl1lQ1cXpKERvrlCglVx4uRSoNq/8vVzYTb74T/RbhlyP83WQdOQUSiIEx8SMK1b9UP
	 MM1DsHr5w8Ta1Ouz5QArnTq4Q/TIwkVgZ+QG2dlXqAEqDlITuobcu1J9MPgnkDJhelA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794489670;
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
	bh=50Jip+PMP1cnvgwVoqMzXgurCA8vGj2fwRIuaXz9hIQ=;
	b=Nnc8SSl+xiM8d0QYiyXkcSysUrvEFultpPW/pAJcL+Y9wcL83cuvI936vkOClCX4kqf5
	 IUpEPcDfIc/+61mLDy9SkEPe9mcpOdGHBqrEqR5Rd06u8S0TWbXZyyw9W+M4f2XXS8dpg
	 AF0rorLHHeH9mP6f5P95wWAigvU/qFZQCSYFSEzuNFGKyIQTLaggCPZSL4UIEyd1k+F13
	 7wjuc5/t/zIDtzIa7QmKj0p55k9r4KwWvJhqv/O/RuoX1EYkow8GboHGFoLlFzwCJVhTz
	 3QeVUbGbkiHJU/FAZsh22WPDODyoSWOLWECXcPx3YOGPUI21R7vdJKWI2l15wiaX3sQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794489670;
	bh=50Jip+PMP1cnvgwVoqMzXgurCA8vGj2fwRIuaXz9hIQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=0n3Bo08Nyn2vcMBDnYiixWRW0obS7hw4VfAyhCceXexQMuRopQV7m7G+DnTcA/a+c
	 8460ZMCLX+sksvTD/3zVDhm5qjHNopk6wxH18O9y/fIp7aAa3RuEOre4tjWcFBMTFy
	 Y0S2k8dDLWJfpJIEf4u2TLt+Z7r9Ywvci/72xTqCgulkB7/i+6GSu0040BZqBiwTL2
	 fAaLh2FsHnDT52JZC1oDRJEEdq3YnU43BA/pVs7DflZB+qgyXZbTnEFPPtKqZCPwFA
	 /pz4qVfCZnIzwRctc+85TIu5EQOPtECSji2xtYIoXyCcmxWgSroSZTgQaman5UXfWL
	 Ew12HOU3eF+1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 585DA4059E;
	Thu, 12 Nov 2026 13:21:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A2F3870B
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 05:28:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 94B8E811AC
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 05:28:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BlFELckKBgg6 for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 05:28:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2BFE4811B2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c40f::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c40f::6;
 helo=seypr02cu001.outbound.protection.outlook.com;
 envelope-from=bin.meng@processmission.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=processmission.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=processmission.com header.i=@processmission.com
 header.a=rsa-sha256 header.s=selector1 header.b=q+fK8MMD
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c40f::6])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2BFE4811B2
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 05:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50Jip+PMP1cnvgwVoqMzXgurCA8vGj2fwRIuaXz9hIQ=;
 b=q+fK8MMD6pbMY9mP9PWecLboJe+yQs9K5rEoyM4Z6ZGpRT1pEMWp/1psl+bLp+gTAleAr3BAdsjbrlyU04gDLKMIMIXns7CUJRL1UmcIEyj+RDWfAq3dMZBazE9k5TNp3KEg+dJ9PYrQc1YrygG8dKeVFJJozZ9CYbdA3Hbm/6gbxDVyno702W0z9zyww2BhJivgstmQqa0CQSZ+q8JoGuFMRqeMpeyz1qeAYowcEF7a/eNQ1ECCF79nEe21nHZQd77VqLuVe/yqjIUdHO06vcXlKwP85gk20Mue4p4uwyEu1WBVOBmJSZl7TC51p+usRIS+kLDV6z7ikLPK8iGNbw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by OSNPR02MB8964.apcprd02.prod.outlook.com (2603:1096:604:45e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 05:28:51 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.012; Thu, 12 Nov 2026
 05:28:50 +0000
From: Bin Meng <bin.meng@processmission.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Marek Vasut <marex@nabladev.com>,
 Michal Simek <michal.simek@amd.com>, QEMU <qemu-devel@nongnu.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Yao Zi <me@ziyao.cc>
Subject: [PATCH v4 1/2] qemu: arm: Rename QEMU arm* defconfig files
Date: Thu, 12 Nov 2026 13:28:32 +0800
Message-ID: <20261112052835.1883576-1-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0362.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::16) To TYZPR02MB7121.apcprd02.prod.outlook.com
 (2603:1096:405:2c::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB7121:EE_|OSNPR02MB8964:EE_
X-MS-Office365-Filtering-Correlation-Id: 42452412-cebb-44a1-651d-08df407dd511
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|7416014|18002099003|6133799003|261009223027099003|3023799007|13003099007|56012099006|261028144727099003|261102123227099003|261021121427099003|261022105027099003|261026140227099003|261026121527099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: hYAwpFQxbo5q+qQnHpy7M0masi6yTum5x7QaKECXz8LI03oIULr5kvQlyj5qjJtU8hCmU7Q6rmVk1ex9NT+dVGDFiR4KccvxarVDJ6rpDo1enqTiFXxCsvdcuMH0XA/Dq0o+erL7yErFnAR+y6KNBuOR5aaq1mDwRDGSZUfBiJO34H6tSlUXABhT2T/FgvEMDTaDPhGvsZ3G15yQf7Fo7TrrAG54QuGMcEV3gx1f+qPcFnLSBJP479/AzfSG/QBlmdrHD+5EhZkjUhJv0QQoZ0mdFi7uDzeXy0jXvQhcVu/BmJt5DF0eeqgkenuAMiz8OUiOMqzkn2I0D3IGwRrl0U0Q2sBygQapeqLmrHHphg74BfOfW7vDI13UEActNylnLmApqgS4w9HoxNegj2VwM8c5b+XYTRiarvFkH8f1z7pdy6xnXezaVoggbo2kqYXg1bUGeybYOgHEw//DJT3oCrDYzhj6Jd7lPDP7MfEROh+f0kNywqDn8da+6fW0M+524AA5YVw30GbsUQ8lxcYE/H/JVy9gQIfQrov16c9vcgHV8jFg20y3MgAMy4VIItMcoZ+GMLTzHPNkD7Sgassz8gfP4SQa0DTi2Ko7f317mAbfizZFm5dDcxGgp+r4Ldl0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(7416014)(18002099003)(6133799003)(261009223027099003)(3023799007)(13003099007)(56012099006)(261028144727099003)(261102123227099003)(261021121427099003)(261022105027099003)(261026140227099003)(261026121527099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZzEGfGGDjMV+8SRmwfSRO48zn0CWTqtj7DPu2H4zptbij7Nd2wYx+1KN4X1Q?=
 =?us-ascii?Q?hoeMGnaoOASwK5M1bxAX7z+K2lOje5NVeYdNIExRgp7UDydsZ+enEDd94RX8?=
 =?us-ascii?Q?urt87uGZTUxd04VU0f8FO0nBe6RIjD0RKADXU/Kl98cbi6lGFEbi3AGpPD5y?=
 =?us-ascii?Q?/yuf4HsEVr51hi1ITNjkSFblk0WXRMvW7xR3VHh/Bt6evEakC55mwjOMzlHK?=
 =?us-ascii?Q?4ZrFRIsI+qA7C2JzuSBi+yIRF6klpMjp3nGWnsd2FohzK/xLJz/dZjvSaZ08?=
 =?us-ascii?Q?gKauyz2w7+1hVX4PCbDoeH8i1n78pCW4/wtJJyOLfOrqoAvWFKREawbKvBKe?=
 =?us-ascii?Q?vstQ3UO2tcRBl6M375Q5bXkgzD5d/of31MHYMf2nUJzDwSYI1ECA8h+WEPMo?=
 =?us-ascii?Q?p98JdotqDwJMsLeP4ucB9LcM8OE3Y3WInHDA5INh37U11bWo0nraA8Ln9ytf?=
 =?us-ascii?Q?mDzZox3iAYzPrxtdTjj5nmcIcpIW6rz0/CtJMcwYgcMCRQxpGueiwsUV4S61?=
 =?us-ascii?Q?PoOa5XPGKd/UUoxW6iV2mjqPfK9u5H+RhI9dfZPHo4PVaou8WDzdvORyRMTM?=
 =?us-ascii?Q?MtdYhA4cX3Hpns/KEtbepEdklQb7c7mQume+Qqf4L628pwMprZOuY9AvTHnk?=
 =?us-ascii?Q?5QB8xOuZgPPb5XycN5qQAbunQ2RzRmTKxx7VXAzdtv/eYqS7eRtTSAEYT8TL?=
 =?us-ascii?Q?Mf/kXiELMW9RJorqGyEJ3HZ559MolLMcZCMvetbHRmcQSRy3BJaFgZbsDpou?=
 =?us-ascii?Q?IVm1fWCq2swFjMXLymFurK0aK9v1z8No/Z/ANvZLds0bZL4cPj6ADDaVA0MU?=
 =?us-ascii?Q?9ulTLpyJUjISBDbkW1g3kIwGnAVnHCYDylpeRIf66rd3/eKXouFa3tHuHchA?=
 =?us-ascii?Q?5mni0DY9a42b50dGe2nGFs6MKu+9me8Q4t1Wz08z5nc+G5pX0q/sURzWOyba?=
 =?us-ascii?Q?XiMK5l/O/77qWMSMINxWQPsUzUX2iqKeTaZsDnDpS1ImPFVfLIU740ITnTHs?=
 =?us-ascii?Q?ih1oILqE2HGjJNsAS+p4fKl9PJHGESkUSJzaCIE7a+/K/2ZVWs9jwUapLsMb?=
 =?us-ascii?Q?xAZ0/CIiDMDItef7cs+BATrc3t3EizQitq+wZe/HI44rlTtXjSrkfgU0a4IB?=
 =?us-ascii?Q?Y/heFq3i+2Q7RMiEnxYK0zB1s/IV/svhLWCJujw0unROqa0wuoBG6aTQ6vz+?=
 =?us-ascii?Q?5llDrLFEYRfQQPCpWb2OukxjOXc16vdDIaR+XSkNWLwH0lwnRDXGmdSdhGzj?=
 =?us-ascii?Q?bste0YXS3R6Ir0isQe6r6vCkkaro/wui/5hW0deX3iWz8rEOzA2MoIezma2x?=
 =?us-ascii?Q?s8Sle7mEdvmAyiyOlBkj0u7qCXLjVRqKUInaBkdd4I5EViWwcafeP0wUzo9f?=
 =?us-ascii?Q?VRWaouwezC+tKVzvZbj1jnPmkCYwcZ58HksElzr8gl4hOWxjbxN9OPNmWDU2?=
 =?us-ascii?Q?4lQLzBHqhMyhEx1ecgC9lZS7X4V74MjIW5YTZPfTCOJnvtn9N0rs3D0zngI3?=
 =?us-ascii?Q?KnOa2rv/WsY76vuSzbwGCDe2x3ZdBVO8wFUlUOBier0hsy73BrDDEvxvxa5a?=
 =?us-ascii?Q?jyBipkuLX0oJrfNlYPJ2VKnlOVLAJ/kOr5XHHe9mYP934dcOTx8KjR+7qKfZ?=
 =?us-ascii?Q?YAbXsKAoRGxRvC4zv/vMjt0jOo43o6QCrTt/xp0eQwRc/bHRhCUb2WxPOv7k?=
 =?us-ascii?Q?dfA+x2O/dP+6j0INMguKsYmvnTFXIhdHD8JcnMyU4041JLYub+zQO1XohS5k?=
 =?us-ascii?Q?SsBWnG1wt3rkPEPHdNsf25BCNL4UcZ0=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42452412-cebb-44a1-651d-08df407dd511
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 05:28:50.2335 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /mMgZlsPkHboNoo724+NRBsQGTokz3gB1AqJzyUrtpFy7ZwvOfFa1hZYuqF6wmrOFv5Ks/ROWFHcArFaAcLc2Mg4mRTcocZywexmfxZQscE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR02MB8964
X-Mailman-Approved-At: Thu, 12 Nov 2026 13:21:07 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Bin Meng <bmeng.cn@gmail.com>

Other QEMU defconfig files use a hyphen between "qemu" and the
architecture name, but ARM uses an underscore. Rename the ARM
defconfigs for consistency.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Bin Meng <bin.meng@processmission.com>
---

(no changes since v3)

Changes in v3:
- Rebase on current mainline and keep the removed ARM devicetree deleted

Changes in v2:
- Add missing Azure and GitLab CI changes

 .azure-pipelines.yml                          | 24 +++++++++----------
 .gitlab-ci.yml                                | 24 +++++++++----------
 MAINTAINERS                                   |  2 +-
 arch/arm/dts/qemu-arm64.dts                   |  2 +-
 board/emulation/qemu-arm/MAINTAINERS          |  2 +-
 ...pi_defconfig => qemu-arm64_acpi_defconfig} |  2 +-
 ...u_arm64_defconfig => qemu-arm64_defconfig} |  0
 ...ip_defconfig => qemu-arm64_lwip_defconfig} |  2 +-
 ...{qemu_arm_defconfig => qemu-arm_defconfig} |  0
 doc/board/emulation/qemu-arm.rst              |  8 +++----
 doc/develop/driver-model/virtio.rst           |  6 ++---
 doc/develop/uefi/uefi.rst                     |  2 +-
 tools/docker/Dockerfile                       |  8 +++----
 13 files changed, 41 insertions(+), 41 deletions(-)
 rename configs/{qemu_arm64_acpi_defconfig => qemu-arm64_acpi_defconfig} (54%)
 rename configs/{qemu_arm64_defconfig => qemu-arm64_defconfig} (100%)
 rename configs/{qemu_arm64_lwip_defconfig => qemu-arm64_lwip_defconfig} (83%)
 rename configs/{qemu_arm_defconfig => qemu-arm_defconfig} (100%)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index fcf7aafade6..ccd30efa2d9 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -253,9 +253,9 @@ stages:
           cd \${WORK_DIR}
           git config --global --add safe.directory \${WORK_DIR}
           git clone --depth=1 https://git.u-boot-project.org/u-boot/u-boot-test-hooks /tmp/uboot-test-hooks
-          # qemu_arm64_lwip_defconfig is the same as qemu_arm64 but with NET_LWIP enabled.
-          # The test config and the boardenv file from qemu_arm64 can be re-used so create symlinks
-          ln -s conf.qemu_arm64 /tmp/uboot-test-hooks/bin/travis-ci/conf.qemu_arm64_lwip_na
+          # qemu-arm64_lwip_defconfig is the same as qemu-arm64 but with NET_LWIP enabled
+          # The test config and the boardenv file from qemu-arm64 can be re-used so create symlinks
+          ln -s conf.qemu-arm64 /tmp/uboot-test-hooks/bin/travis-ci/conf.qemu-arm64_lwip_na
           ln -s u_boot_boardenv_qemu_arm64_na.py /tmp/uboot-test-hooks/py/travis-ci/u_boot_boardenv_qemu_arm64_lwip_na.py
           ln -s travis-ci /tmp/uboot-test-hooks/bin/\`hostname\`
           ln -s travis-ci /tmp/uboot-test-hooks/py/\`hostname\`
@@ -474,21 +474,21 @@ stages:
           TEST_PY_BD: "integratorcp_cm926ejs"
           TEST_PY_ID: "--id qemu"
           TEST_PY_TEST_SPEC: "not sleep"
-        qemu_arm:
-          TEST_PY_BD: "qemu_arm"
+        qemu-arm:
+          TEST_PY_BD: "qemu-arm"
           TEST_PY_TEST_SPEC: "not sleep"
-        qemu_arm64:
-          TEST_PY_BD: "qemu_arm64"
+        qemu-arm64:
+          TEST_PY_BD: "qemu-arm64"
           TEST_PY_TEST_SPEC: "not sleep"
           OVERRIDE: "-a CONFIG_SEMIHOSTING=y"
-        qemu_arm64_lwip:
-          TEST_PY_BD: "qemu_arm64_lwip"
+        qemu-arm64_lwip:
+          TEST_PY_BD: "qemu-arm64_lwip"
           TEST_PY_TEST_SPEC: "test_net_dhcp or test_net_ping or test_net_tftpboot"
-        qemu_arm64_tfa_fw_handoff:
-          TEST_PY_BD: "qemu_arm64"
+        qemu-arm64_tfa_fw_handoff:
+          TEST_PY_BD: "qemu-arm64"
           TEST_PY_ID: "--id fw_handoff_tfa_optee"
           TEST_PY_TEST_SPEC: "test_fw_handoff"
-        qemu_arm_sbsa_ref:
+        qemu-arm_sbsa_ref:
           TEST_PY_BD: "qemu-arm-sbsa"
           TEST_PY_TEST_SPEC: "not sleep"
         qemu_m68k:
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 0338f20b8a2..905523e3e27 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -37,9 +37,9 @@ stages:
     # Clone uboot-test-hooks
     - git config --global --add safe.directory "${CI_PROJECT_DIR}"
     - git clone --depth=1 https://git.u-boot-project.org/u-boot/u-boot-test-hooks /tmp/uboot-test-hooks
-    # qemu_arm64_lwip_defconfig is the same as qemu_arm64 but with NET_LWIP enabled.
-    # The test config and the boardenv file from qemu_arm64 can be re-used so create symlinks
-    - ln -s conf.qemu_arm64 /tmp/uboot-test-hooks/bin/travis-ci/conf.qemu_arm64_lwip_na
+    # qemu-arm64_lwip_defconfig is the same as qemu-arm64 but with NET_LWIP enabled
+    # The test config and the boardenv file from qemu-arm64 can be re-used so create symlinks
+    - ln -s conf.qemu-arm64 /tmp/uboot-test-hooks/bin/travis-ci/conf.qemu-arm64_lwip_na
     - ln -s u_boot_boardenv_qemu_arm64_na.py /tmp/uboot-test-hooks/py/travis-ci/u_boot_boardenv_qemu_arm64_lwip_na.py
     - ln -s travis-ci /tmp/uboot-test-hooks/bin/`hostname`
     - ln -s travis-ci /tmp/uboot-test-hooks/py/`hostname`
@@ -386,33 +386,33 @@ integratorcp_cm926ejs test.py:
     TEST_PY_ID: "--id qemu"
   <<: *buildman_and_testpy_dfn
 
-qemu_arm test.py:
+qemu-arm test.py:
   variables:
-    TEST_PY_BD: "qemu_arm"
+    TEST_PY_BD: "qemu-arm"
     TEST_PY_TEST_SPEC: "not sleep"
   <<: *buildman_and_testpy_dfn
 
-qemu_arm64 test.py:
+qemu-arm64 test.py:
   variables:
-    TEST_PY_BD: "qemu_arm64"
+    TEST_PY_BD: "qemu-arm64"
     TEST_PY_TEST_SPEC: "not sleep"
     OVERRIDE: "-a CONFIG_SEMIHOSTING=y"
   <<: *buildman_and_testpy_dfn
 
-qemu_arm64_lwip test.py:
+qemu-arm64_lwip test.py:
   variables:
-    TEST_PY_BD: "qemu_arm64_lwip"
+    TEST_PY_BD: "qemu-arm64_lwip"
     TEST_PY_TEST_SPEC: "test_net_dhcp or test_net_ping or test_net_tftpboot"
   <<: *buildman_and_testpy_dfn
 
-qemu_arm64_tfa_fw_handoff test.py:
+qemu-arm64_tfa_fw_handoff test.py:
   variables:
-    TEST_PY_BD: "qemu_arm64"
+    TEST_PY_BD: "qemu-arm64"
     TEST_PY_ID: "--id fw_handoff_tfa_optee"
     TEST_PY_TEST_SPEC: "test_fw_handoff"
   <<: *buildman_and_testpy_dfn
 
-qemu_arm_sbsa test.py:
+qemu-arm_sbsa test.py:
   variables:
     TEST_PY_BD: "qemu-arm-sbsa"
     TEST_PY_TEST_SPEC: "not sleep"
diff --git a/MAINTAINERS b/MAINTAINERS
index 9fc6614e519..01450e760c5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1337,7 +1337,7 @@ M:	Jerome Forissier <jerome.forissier@arm.com>
 S:	Maintained
 T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-net.git
 F:	cmd/lwip/
-F:	configs/qemu_arm64_lwip_defconfig
+F:	configs/qemu-arm64_lwip_defconfig
 F:	include/net-lwip.h
 F:	lib/lwip/Makefile
 F:	lib/lwip/u-boot/
diff --git a/arch/arm/dts/qemu-arm64.dts b/arch/arm/dts/qemu-arm64.dts
index 95fcf53ed74..382d131f47f 100644
--- a/arch/arm/dts/qemu-arm64.dts
+++ b/arch/arm/dts/qemu-arm64.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+ OR MIT
 /*
- * Empty device tree for qemu_arm64
+ * Empty device tree for qemu-arm64
 
  * Copyright 2021 Google LLC
  */
diff --git a/board/emulation/qemu-arm/MAINTAINERS b/board/emulation/qemu-arm/MAINTAINERS
index 538769f8040..b2b1fce75cf 100644
--- a/board/emulation/qemu-arm/MAINTAINERS
+++ b/board/emulation/qemu-arm/MAINTAINERS
@@ -5,5 +5,5 @@ F:	board/emulation/qemu-arm/
 F:	board/emulation/common/
 F:	include/configs/qemu-arm.h
 F:	include/configs/qemu-sbsa.h
-F:	configs/qemu_arm*
+F:	configs/qemu-arm*
 F:	configs/qemu-arm-sbsa_defconfig
diff --git a/configs/qemu_arm64_acpi_defconfig b/configs/qemu-arm64_acpi_defconfig
similarity index 54%
rename from configs/qemu_arm64_acpi_defconfig
rename to configs/qemu-arm64_acpi_defconfig
index f85f2913530..ef4c9f156c5 100644
--- a/configs/qemu_arm64_acpi_defconfig
+++ b/configs/qemu-arm64_acpi_defconfig
@@ -1,2 +1,2 @@
-#include <configs/qemu_arm64_defconfig>
+#include <configs/qemu-arm64_defconfig>
 #include <board/emulation/configs/acpi.config>
diff --git a/configs/qemu_arm64_defconfig b/configs/qemu-arm64_defconfig
similarity index 100%
rename from configs/qemu_arm64_defconfig
rename to configs/qemu-arm64_defconfig
diff --git a/configs/qemu_arm64_lwip_defconfig b/configs/qemu-arm64_lwip_defconfig
similarity index 83%
rename from configs/qemu_arm64_lwip_defconfig
rename to configs/qemu-arm64_lwip_defconfig
index 06ed5a131db..5b1ddb2af03 100644
--- a/configs/qemu_arm64_lwip_defconfig
+++ b/configs/qemu-arm64_lwip_defconfig
@@ -1,4 +1,4 @@
-#include <configs/qemu_arm64_defconfig>
+#include <configs/qemu-arm64_defconfig>
 
 CONFIG_ARM=y
 CONFIG_ARCH_QEMU=y
diff --git a/configs/qemu_arm_defconfig b/configs/qemu-arm_defconfig
similarity index 100%
rename from configs/qemu_arm_defconfig
rename to configs/qemu-arm_defconfig
diff --git a/doc/board/emulation/qemu-arm.rst b/doc/board/emulation/qemu-arm.rst
index 9e993ca9783..d575bc64ff6 100644
--- a/doc/board/emulation/qemu-arm.rst
+++ b/doc/board/emulation/qemu-arm.rst
@@ -32,7 +32,7 @@ U-Boot
 
 - For AArch64::
 
-    make qemu_arm64_defconfig
+    make qemu-arm64_defconfig
     make
 
 On successful build 'u-boot.bin' should be created. It's necessary in the following
@@ -100,12 +100,12 @@ Set the CROSS_COMPILE environment variable as usual, and run:
 
 - For ARM::
 
-    make qemu_arm_defconfig
+    make qemu-arm_defconfig
     make
 
 - For AArch64::
 
-    make qemu_arm64_defconfig
+    make qemu-arm64_defconfig
     make
 
 Running U-Boot (secure)
@@ -182,7 +182,7 @@ Booting distros
 ---------------
 
 It is possible to install and boot a standard Linux distribution using
-qemu_arm64 by setting up a root disk::
+qemu-arm64 by setting up a root disk::
 
     qemu-img create root.img 20G
 
diff --git a/doc/develop/driver-model/virtio.rst b/doc/develop/driver-model/virtio.rst
index e5da9f4301c..90a12fb3003 100644
--- a/doc/develop/driver-model/virtio.rst
+++ b/doc/develop/driver-model/virtio.rst
@@ -32,8 +32,8 @@ network and block device, the most two commonly used devices, are supported.
 
 The following QEMU targets are supported.
 
-  - qemu_arm_defconfig
-  - qemu_arm64_defconfig
+  - qemu-arm_defconfig
+  - qemu-arm64_defconfig
   - qemu-arm-sbsa_defconfig
   - qemu-riscv32_defconfig
   - qemu-riscv64_defconfig
@@ -51,7 +51,7 @@ variable being properly set to a working toolchain for ARM:
 
 .. code-block:: bash
 
-  $ make qemu_arm_defconfig
+  $ make qemu-arm_defconfig
   $ make
 
 You can even create a QEMU ARM target with VirtIO devices showing up on both
diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index 94ddf690440..c2bad4cdd5f 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -713,7 +713,7 @@ HTTP(s) Boot can be activated by specifying::
 
 For QEMU targets there's a Kconfig that supports this by default::
 
-    make qemu_arm64_lwip_defconfig
+    make qemu-arm64_lwip_defconfig
 
 The commands and functionality are similar to the legacy stack, with the notable
 exception of not having to define an "httpserverip" if you are trying to resolve
diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 187320c26d5..8680ea257e5 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -251,7 +251,7 @@ RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
 	make -j$(nproc) all install && \
 	rm -rf /tmp/qemu
 
-# Build OP-TEE for qemu_arm64
+# Build OP-TEE for qemu-arm64
 RUN git clone --depth=1 https://github.com/OP-TEE/optee_os.git /tmp/optee_os \
 	-b 4.7.0 && \
 	cd /tmp/optee_os/ && \
@@ -264,7 +264,7 @@ RUN git clone --depth=1 https://github.com/OP-TEE/optee_os.git /tmp/optee_os \
 		CFG_REE_FS=n CFG_CORE_ARM64_PA_BITS=48  \
 		CFG_TEE_CORE_LOG_LEVEL=2
 
-# Build fiptool, bl1 and fip for fvp and qemu_arm64
+# Build fiptool, bl1 and fip for fvp and qemu-arm64
 RUN git clone --depth=1 -b mbedtls-3.6 https://github.com/ARMmbed/mbedtls.git /tmp/mbedtls
 RUN git clone --depth=1 https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git /tmp/tf-a \
 	-b v2.13.0 && \
@@ -294,9 +294,9 @@ RUN git clone --depth=1 https://git.trustedfirmware.org/TF-A/trusted-firmware-a.
 		MBOOT_EL_HASH_ALG=sha256 \
 		MBEDTLS_DIR=/tmp/mbedtls \
 		-j$(nproc) all fip && \
-	mkdir -p /opt/tf-a/qemu_arm64_fw_handoff_tfa_optee && \
+	mkdir -p /opt/tf-a/qemu-arm64_fw_handoff_tfa_optee && \
 	cp build/qemu/release/fip.bin build/qemu/release/bl1.bin \
-		/opt/tf-a/qemu_arm64_fw_handoff_tfa_optee/ && \
+		/opt/tf-a/qemu-arm64_fw_handoff_tfa_optee/ && \
 	make CROSS_COMPILE=/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch64-linux- \
 		PLAT=sun50i_a64 -j$(nproc) all && \
 	mkdir -p /opt/tf-a/pine64_plus && \
---
base-commit: 3cb2cbbc75aa7fe2391f662607d6b2f46c1292a7
branch: qemu-arm

-- 
2.53.0

