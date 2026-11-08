Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9BD606A31C
	for <u-boot@archiver.kernel.org>; Sun,  8 Nov 2026 18:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jPTxf+Hg;
	dkim=pass (2048-bit key, unprotected) header.d=processmission.com header.i=@processmission.com header.a=rsa-sha256 header.s=selector1 header.b=W2iZgvt4
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 57DDF40681;
	Sun,  8 Nov 2026 18:14:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id top07U9XANf6; Sun,  8 Nov 2026 18:14:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 92F514068B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794161674;
	b=Wq6PiU14qazolAnvtGF7QagFaQpM8PZV8IsMoYLJdtbgBHMG9BPD17anRncidW4Y4xHM
	 dky5ncPhiCGQObLBQWbT+IKlR6W2qI7ZZwpYKAOtnYSHNPO0oIvpTqprzLdRDRPIOwfCW
	 8cGPljyh3IaVH7RrWXvsge7SSplGbbRd4e+18uXBYaPlMVQeMy5FHMFnH1OujdbEJBDSJ
	 72VwO7AA1YjKhXu46zlNLGh/O5ba+qC3e/LmGvOy4k3u4dCf4Ca4ARkhW7riiPX8m5hvU
	 wdDchZSOVdlsTYXbe9GcZ+bweXUbOsiYSqoZmIf+iV26fqvSsLZdkoMKDD1qR0nWzkA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794161674;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=7h5OhiFAbmVbFXOG5PrfbAhjnPtS1tQj7iazR39XUaY=;
	b=Gm9R5ofLvBWBXZT/7gIkH29CMt54u54dRpDWu869XNWTkBYkTEZBXBP9igjLkpL5CWrj
	 fcFrxDzVb+gjionUzGYT22L9ROi7ZGVZfXLokg99UFPpm4IdOwo7nUMqHROjNNcY30i3X
	 4gn2qIiBWhRbrgkFE2zy7RDDa1G7z0RBmp5SvVSWwEtRsrTHRNCEJY99mFQWWQMr/Rdzv
	 70UWEX1M8ecxD0sPRkBC0hb01iby61+QgTybmtHmJs7iv/DNjwzZZezdCZ0wFIdqjUClt
	 kpLYGSrpskPklb3grFLUiRF2Khmd/PU4z3RlXuzKnJBerZxhzq/EG465XHsmSteXLRw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794161674;
	bh=7h5OhiFAbmVbFXOG5PrfbAhjnPtS1tQj7iazR39XUaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jPTxf+HgNB3TUMLGOlQByVidm5dxQBXXSvH2ACytsBb3o70gGu5PZFELCidtNt90S
	 pn0ICtzMoWkE1RSqbKgDrsfFwmgiVZE/1M7DJjcrMP+ZpCGfPh04nB06iQJt46FxqR
	 FgmJBvORrXIarrKp/QZQtMXgBxo3ROxOo6GH20QacwlF2AGrt9IL+yuJfayYYSv7pb
	 S3B2y2ES261bFMMqimQ03fPWNsOPX25r3cB04GXheoi4WITyOrSdAwY+WzTfnJ5kqB
	 cupc717xpZwKBsU/Q0B/UJadyeB2n4f/10rHWMz0DylwyTBrJQbm0xqH13EiE4JCL5
	 jZsXtTl1vQiDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 92F514068B;
	Sun,  8 Nov 2026 18:14:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 20419111
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 15:37:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1150B80CF1
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 15:37:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bb5ZtQ7ECuza for <u-boot@lists.u-boot-project.org>;
 Sun,  8 Nov 2026 15:37:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A55DA80D5B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c406::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c406::3;
 helo=os8pr02cu002.outbound.protection.outlook.com;
 envelope-from=bin.meng@processmission.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=processmission.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=processmission.com header.i=@processmission.com
 header.a=rsa-sha256 header.s=selector1 header.b=W2iZgvt4
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c406::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A55DA80D5B
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 15:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7h5OhiFAbmVbFXOG5PrfbAhjnPtS1tQj7iazR39XUaY=;
 b=W2iZgvt4RVMY0hVJKgm9nS+DwPazBnvyYhuE9CtmnYoBSCiyJRLwmZ6nsmMpqy+b4B3DfitG73ILEwIf75aqMS1LUyhrmqDpusmTGOdFKcndSV1eSOimMzUdEW/tyBd0Bich9wp68xrD4ai0fzfWDbCNVy6oJsY0kWJrtSX8TkTc9EQkX00jwq+mclZcLEpqlzlfMhOtxzXbhYkoo49sEPbQdRPSTA/az8uvMvFuvAfkiOuIktec/AYtLxvagBuxjC1Rt1E4t2DTfjjl0QXhsrjY3c6XcU1JNlPZ7F0DrKN91IoGhkNsjBi4QPjEKuWuF1tzhvAgYNeVua3fq4xQvQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com (2603:1096:405:2c::12)
 by KUXPR02MB9334.apcprd02.prod.outlook.com (2603:1096:d10:9e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Sun, 8 Nov
 2026 15:37:40 +0000
Received: from TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10]) by TYZPR02MB7121.apcprd02.prod.outlook.com
 ([fe80::5d81:393:2e5b:6e10%5]) with mapi id 15.21.0592.010; Sun, 8 Nov 2026
 15:37:40 +0000
From: Bin Meng <bin.meng@processmission.com>
To: sjg@chromium.org
Cc: bmeng.cn@gmail.com, frank-w@public-files.de, granquet@missingno.tech,
 james.hilliard1@gmail.com, jeremy.compostella@intel.com, jonas@kwiboo.se,
 marek.vasut+renesas@mailbox.org, mchitale@ventanamicro.com, me@ziyao.cc,
 neil.armstrong@linaro.org, patrice.chotard@foss.st.com, peng.fan@nxp.com,
 quentin.schulz@cherry.de, ranquet.guillaume@gmail.com, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, wolfgang.wallner@at.abb.com,
 xypron.glpk@gmx.de, yangshiji66@outlook.com
Subject: Re: [PATCH v2] arch/x86/lib: implement cmdline configuration property
Date: Sun,  8 Nov 2026 23:37:19 +0800
Message-ID: <20261108153719.2036277-1-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAFLszTh6+tKdfSWNzKAfyCb67a0U+m7A3YEaOhS3HXZHcPBvyQ@mail.gmail.com>
References: <CAFLszTh6+tKdfSWNzKAfyCb67a0U+m7A3YEaOhS3HXZHcPBvyQ@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0214.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::10) To TYZPR02MB7121.apcprd02.prod.outlook.com
 (2603:1096:405:2c::12)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB7121:EE_|KUXPR02MB9334:EE_
X-MS-Office365-Filtering-Correlation-Id: a4d53fde-add7-490e-1d29-08df3dae3902
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|376014|1800799024|22082099003|18002099003|6133799003|10067099003|3023799007|261028144727099003|261102123227099003|261022105027099003|261022075727099003|56012099006|261021121427099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: e+BmvloXqnrSLQRKTi99X80oGreGem7VK2p+Imej9RU4EOkXirPD4eXOZNqR/APGj0hxIGW74YQ9iX/0lgksHUalhi/0QVVjs/PLq9Ith5jc4hqjbg0QbzF1UIPgfHI6A0Uyhjbz2Vf6dyCxsunDczBlyl4M7gy20GqS3PX2GCTDt96b0GYolJ4VRp/Pj/Oy2J0eVfIJMkaPSZjBcwUCFF1LneU6+QoTmf8mP/poDhFDcYLzAK+YTetJ3fcmie8x+JWzejm+IF1RxwljCyrxBlRQJvxrlQt2vmmvwRMpMuMTVhQ6aWP4x6NE5XgAwNW48xOOoKxFecQMQrSixF/PZi214l7wcqmn5sSpIoWIIjkztNTF38MGmUIxct/pem2wdmt3Wi6JUHSEXwN9PLJOQpBOMp/ClPBu3n/gTeT2HBTW8I6mmr+h0AMbGIMlY0B8X/P17VvsMDkOw89bzIWEQ+OpE8grFEKRhz75jRGnC58xMX/taoFK7DhyOFaOSuIlsqwE033SJ91IeP9PBlnClRN34t0bUVdogb9IuBZWwOgnYdqBpYmclCyJu1Y8zNli3DzlnCZ0AAWJ+mnJ4by2sBt3C6pDRZz44QDjRpkugdYE0Plp8lKLq0rE4dHR6Oycx8ZKKnX8S0comVKq7N6M5w69gIqXr/eeVQnQcsqGdOk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR02MB7121.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(10067099003)(3023799007)(261028144727099003)(261102123227099003)(261022105027099003)(261022075727099003)(56012099006)(261021121427099003)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oZNRjaOIh5FdKzdOQZO8Y7G0wu5ONEkuQRJZJIizKG91+XzDNc+Eg7yeMgPn?=
 =?us-ascii?Q?odOTnjHEEav0crpkJ5ssKY3sV/CRZrBT+bQvw4UkHaJZQuo1XD5pHTZbL2Bk?=
 =?us-ascii?Q?fuetPBlQP3NtdvxFNSaWEMQy0VaAS9K0I6oR1cAZyw0yIxSrjlG68QeoguRQ?=
 =?us-ascii?Q?yVTkpOuvZ54wFJ5DdrcM8QChTQ04BumYcaXTkXv76RGmw81Qn/5g2aluKRwn?=
 =?us-ascii?Q?jy0fvcb28jLFnC0G8r3kfY0ULbM3qDSbk859LxrUXOJVDVMh9HBhhJTBylEG?=
 =?us-ascii?Q?HU787DJdbPpC7KDG7qEV9JzJyiw+lKCTzwYwWEera0JVIPx/UMP1zOYGWYqp?=
 =?us-ascii?Q?40Knpq61xuwwCWU4wuaq3bsKSe1T7Dy90fS/W3NcGps/XPTTD2O/I9brGyGz?=
 =?us-ascii?Q?9Yf6iOFCYHF6gxKgw7GV23N1n10rmKXxCWY3dZb8byfTxnOZuiPxxro6CI1Y?=
 =?us-ascii?Q?I1/M9trLWD2uau4/KmkzDl5cxASDwuEl2wMjCQL1xo7/L8LojUMQojN1tB4I?=
 =?us-ascii?Q?GfnRThoYo99D17L/Zt3xdGVn8eSV6pcuKHyi1GbdbX2lGnFZzlxzU1O1kGsL?=
 =?us-ascii?Q?TiMvb6KWWXHPNn/5tuRHBqGU9psg1d3nNZj5BFuFszth3FQm2DhH/aAhxbMm?=
 =?us-ascii?Q?gQvnpB50PbH2wKUdhNjBwz8YE7AafN0cxG34B+Q6vCNYQ56Na3hdAkRky0PD?=
 =?us-ascii?Q?dPma8J/FU2DBw3wfXgho8P8MaWG39vEouSMf8g2JGBHO88oVpYWSwT/DbKnl?=
 =?us-ascii?Q?nf2l+YszTtwb4UwJztD9QP/nl+2F+mJ3efy86RHnztHQRFoe0S+XMZ89qlUt?=
 =?us-ascii?Q?t3vGGYOKdc49WRmdVdY6410N+r7oP/R1e2CuR40fARtThgHGGDUppYWs/UPJ?=
 =?us-ascii?Q?VW98eYunH5jI5RUmTzhflxKocJb3DK1gkN5MXtGAnTBcTCLGGIdOja/vynoY?=
 =?us-ascii?Q?mqmYm9M2K5Dzk9rTLuZGnhh7PJWGkFw4Xxv5Q+kKZmGwBD/1joz8eBxmQA+I?=
 =?us-ascii?Q?Ns/7WwaZVi1QK5WK8Mh/n5z3a02baIZk/FFhVH0IGkjkuOCb7Z0HQxNm7gUw?=
 =?us-ascii?Q?dP1ss70q+iuh3lh46cWzXdXZ7stBIDH6PWEtnf+Ir2hAnZXdr5UpSBvA29PV?=
 =?us-ascii?Q?MAw081exUBjIa3kmmud0dPpNtG9vHfNcwG4tTPklmJYonsnypknEpGnW+X27?=
 =?us-ascii?Q?f+8DcXXO3ceQ9dmmA7A1khUYVwm5JBikB6/bbP7SNT+QzhrnX3PTqxrpHnXe?=
 =?us-ascii?Q?9BX18STj8YO+ZekvwCrrSJ7EgrPR8FCAXKVdFPwDv+Omtm9P6ECRy5vh72A1?=
 =?us-ascii?Q?S+v4wnEtnvEaCBMYBFE92rFnI9Na8VQpW3v0MzEcmQ9flGkijKcnTHxn5Wzt?=
 =?us-ascii?Q?WDQPnWGit+gYOvErB6jGAiF10MvITSQkfd+Ls6mDlJJyfUnA0Fy/S377R+Oh?=
 =?us-ascii?Q?668IxtrX7+OkpsDPhPo+XpkB2MSONd+Cq6JwIC9iTbfHfOye+Q0c1Wg5t6jp?=
 =?us-ascii?Q?kIKPP5hlfbujbHC4nHB1IOSFKDNCbln1En/C52vdXlQTLYAKpDSsSBQNxfXS?=
 =?us-ascii?Q?lIMAu2flgw/BLiDVSjNIEFZMZ/bzlTAd6BCjuUJVkl8CwokBYdvhQMm7ekcH?=
 =?us-ascii?Q?SV0lVgwV9KTw1H0giI0MklqQ6aE0G2GTr+ErGZZzZwGY/zgArCyt+XTW8uXb?=
 =?us-ascii?Q?W8+GOndsWoXs/SiIiqGLCE6qIh5y+/J/alLxPGaPgloefRlPbcf6D8oS66jt?=
 =?us-ascii?Q?cHCO41D1mxArrZWPYIfvrdnYrG91C50=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d53fde-add7-490e-1d29-08df3dae3902
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB7121.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2026 15:37:40.1152 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wvx7Z9ZdozERZB8fKDSFUVj8hQygGe97lUud2KXsb9Ib0jDuWFXi1l14NNd7tVZ0sOZFuSiI3NVd6T4xKDIMqsXAEjsT1OW01KhnFyWIGqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR02MB9334
X-Mailman-Approved-At: Sun, 08 Nov 2026 18:14:32 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Heinrich,

Simon Glass wrote:
> Hi Guillaume,
> 
> On Mon, 13 Apr 2026 at 04:48, Guillaume Ranquet
> <ranquet.guillaume@gmail.com> wrote:
> >
> > On Sun, 12 Apr 2026 13:37, Simon Glass <sjg@chromium.org> wrote:
> > >Hi,
> > >
> > >On Sat, 11 Apr 2026 at 05:25, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >>
> > >> Am 3. April 2026 16:28:23 MESZ schrieb Guillaume Ranquet <ranquet.guillaume@gmail.com>:
> > >> >Implement the cmdline configuration property as described in the spec
> > >> >[1]
> > >>
> > >>
> > >> I can't see in the spec that the command line property is x86 specific. Why would you try to implement it in arch/x86?
> > >>
> > >
> > >This is a little tricky though. It could perhaps be handled in
> > >bootm_process_cmdline_env() by setting bootargs. Both legacy bootm and
> > >bootstd (via the on_bootargs callback) would then pick it up without
> > >any arch-specific code. But I haven't tried it. Commands like
> > >'bootflow cmdline set' need to continue to operate as now.
> > >
> > >Regards,
> > >Simon
> > >
> >
> > Indeed, I've looked at implementing this in a generic way but it
> > requires a bit of massaging to get things working.
> >
> > I was also under the impression that no one in their right mind would
> > use the command line property if they had access to a device tree?
> >
> > Tell me if you think I should propose a generic implementation?
> 
> I'm happy with what you have for now, so I'll leave this to Heinrich.

I see this patch was assigned to me on patchwork and there was no follow-up on the ML.

What's your opinion on this?

Regards,
Bin
