Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 463B0C44529
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 06:42:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE38340819;
	Tue, 21 Jul 2026 06:42:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 51fYHB9PYQlU; Tue, 21 Jul 2026 06:42:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C6DD6407D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784616166;
	bh=Cp9dc98BtOM//Gfsv+/4N1rpG3NtVmRiO2ViXjUcB5I=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=0a/nW/M2SAJ1tu/8vjrnpxECZ9yBYvyzqisMk284CBogh8QwjV+LBc00DOuWuVtFZ
	 5qYtUT1EGWAz7NYif+Ga34kBD1z0a+KFm69NSHZRKHD0aV2+/VDy2LpgEdqql8XBkc
	 GIHfjuBCx61mhnNyyOifK4JOlhyS7r+qKvUsS3E/ZDokpY12UpHkCFwguh1gqmwN0o
	 WKhXUc9O21lY+/8s2kjV7x2hFQm1xw9hFUbzREPvyzWiVni62ux6xpnkwvVeRBbyLx
	 ZETj3htfC9tfxFwejI28ZGhG4ja36ptKLmlNIqP0cd+5CeYjdW6lh5AIYrjWsvU4vK
	 CJPycziZaa/BQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C6DD6407D4;
	Tue, 21 Jul 2026 06:42:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1AEEF1099
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 06:42:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EC92040740
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 06:42:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tzenUJlJNUCm for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 06:42:44 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=dinesh.maniyam@altera.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C2919407D4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C2919407D4
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C2919407D4
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 06:42:42 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F64D84659; Tue, 21 Jul 2026 08:42:40 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E69AC803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 08:42:37 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IQrzMgq6HNeUYbF8YyobUjy+ZiNk2NRNkRZvBw02QIWlfoJrC2JXOGeNrjtWtTlP9Bv3hSmpS9eoyX/NePxFYpF43EtyLp6sLhWWclBtfSOduGSoIE3iD+s8S4DwoT+/JgI0ZlZb8IdIx9l/aZ/3478S4K3HhHz/DSXu/b3ZZfOjWABe4zIoWEAJjEAkn8/XJyfFwFcCqOeVU4mcDYKvoEfc3vrFszyDqMzoDqmiKDSOumnuO3MdyczdY+r1m2gNwrBhi8gLUEWQS/u5YxwX7ebNWLnHxT/JUy0XLSfwUbkwim+u0Y4fLwYmEpVaDcpmOME60fKK39kZI832f+R5rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cp9dc98BtOM//Gfsv+/4N1rpG3NtVmRiO2ViXjUcB5I=;
 b=wqLSKTZ9n16bJONMHQiCDE30gJNwkUJ2Rnb89zoe0N8j6UvPuV9yYWfTNH/jqJ1rXDEAPGf+OwuDzu5qzUvpJ92cp6XEUzWPYj08sa6bW2NNHnzGe20pJeHz/2rTcfBDrKwV/d2J4jcKZli58l7nh/H2WKOhn1k9Sl+/RvtczKnEgwul7EkXtQh2gZ9xcM/nxCNTvFpoEd8WCAUyZgluJfWuK/Uo02+TiaenqMT4v0BACEk0WghlIEtj6cZb/4ODEVuFhjBlgoPoraHPuWG3rYdoNxNuf7q+0aaEZ0fHdfLvl6DwVXCejwdZ9pTCuE2aWTvw07NqP5AzY+8hCCeJVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by SAWPR03MB989177.namprd03.prod.outlook.com (2603:10b6:806:4d3::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 06:42:34 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%6]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 06:42:34 +0000
To: u-boot@lists.denx.de
Cc: Dinesh Maniyam <dinesh.maniyam@altera.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Yao Zi <me@ziyao.cc>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2] arm: socfpga: spl_n5x: Switch SPL watchdog init to DM
Date: Tue, 21 Jul 2026 14:42:22 +0800
Message-Id: <20260721064222.23318-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20260304040843.11298-1-dinesh.maniyam@altera.com>
References: <20260304040843.11298-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0071.namprd03.prod.outlook.com
 (2603:10b6:a03:331::16) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|SAWPR03MB989177:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fc66f94-cf5e-4c9d-92aa-08dee6f33ea4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|55112099003|18002099003|10067099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: f4KWg2n5Odrb9nAYPkiCG6xJp6wYzsmE3Z8S5JL3bHjT0UWlYJjeJd1ri3CTCDwsN89QHZtsyUAyGrR+LqPavYnMuv8xnV3x0NYW+8jvKeEVSt/MMbsIyQ7xdSueg4NHrvQyFhaI6lPnSFkxH3qmoK7iMgG4gIYMDHVoWrDOl50pDUoe2XatI4dngIkMlz/xeM37J4XFW4oLTmn3izw4RmFpm2yic338TOAYC7iQzgE/2va3lGbeM5X0Pe30ca6wsunCwrb+YwvFD0cXhduxrjwdlQnUK43rGDni8oQw9zGZ5+/Q/LUMTWTMEcx4dO8b7/4vKI7Xz/R4FbuVEqfP+8tk/plMstcf8wsj8ZpFqE7RfnoRVK1fEEgvQPqDExBJw1im/eRcjQ9HfnghCGt3+zgus6l2hwC3vFrs1zaXCQKSbshi+0s8GTv9w28vvVvv5xAvWwK1aGRtw23xndPkaSN/ZKuDhL7kR3pEOQXDnxEOm+G1y/8wsLHC8AKRbzfUUmjIjjsLG07O4fZiGYtFRniDN3yAeD0CPNCEO4CI73gnmuiZolGbamVjejLwqeib7hcXRToazk77ATh6vaJNIekEOBnupPQsOBeRnCc59UJJFegd5ovTD9OCjSRm6FAjE6JRk9OEtyFcC/7lBsPQHbv5J99yMXrsgppUWQWgqcc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(55112099003)(18002099003)(10067099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J+75xAnkVB/RpiMliX9igavBHq1X5f5uUrKa6H9J3qRRR++ZzjFwS4v3hTir?=
 =?us-ascii?Q?CJt/YMrJh8fmnutBwXb5g2mxNkNrRHNoWCUXyaomcwDgm+ypstnZlT57ogL2?=
 =?us-ascii?Q?Y7IudMCYXm4QJYJmW3R0ccJScc4/uYZQPVDwR05671Es5uyXDwv0eI1T0cxV?=
 =?us-ascii?Q?I42NnXd7crFl4H9iImTnOOFN9N5G6ndPeXSIVwO7XvV0GA6J//629I1R+zhA?=
 =?us-ascii?Q?6ynuHwxymGgd8MiHHqMYRtsjSpO/1pHYE55NyBjZBDy3HDdBsfDgk4HxFSIR?=
 =?us-ascii?Q?kGxEBkwEpPjM3xSEBwVi6H/22UKBqz3cS1jpXet0C+DoSHTNoIq7/IFYXHNH?=
 =?us-ascii?Q?P3CB+TY+Z5cNCcoZG5YY798Qo3i8//gHkFb2PgoDbTN0x5Fp+KyqLSOyBuT3?=
 =?us-ascii?Q?dvyQq/7xMW5fJAnWRAKQyqBWuenbiqQ3W2Yj4LDBC9ySNJi4Unbh5weJJebY?=
 =?us-ascii?Q?w/Xf1Jmc/twWGOeP9MTp4QIF+8YGOE6ClOIGRjEdFPKxhIx6/8GIzbn8zKMH?=
 =?us-ascii?Q?o+ILPzhXXQfQrH2Vkae1herAG33owZ4TokFomAsFpNONSbNCQK3mmBXn6AsG?=
 =?us-ascii?Q?cQFiNdx4wJV3JMpzMUmv9pYS9yWJe0SvU8dzEhu2Ncf3BbWL6qD45GlJAah2?=
 =?us-ascii?Q?Zg0IKRvGJCtfWln7IAUGgM8f4aiNTLQR7R9FtFQ4kuljhpn4pMNhNq9PyahH?=
 =?us-ascii?Q?T6kO/tKfORP7JFRyGBp5CKuPb2TSgLZRnuKjNGNfGSpWJKo47Hvd3tBkoPnn?=
 =?us-ascii?Q?Ne/SpHdtxo7KujI2/V8y8cDQLdDy8a1SiBDrRJdRa4abT3HCiUisaa9eM2QR?=
 =?us-ascii?Q?awbmG5iNRiEV+dCNk5mg/qGDEfNkv3ZgWpCADEUCoeB0/Zce+PrBjRxEQenf?=
 =?us-ascii?Q?fK6uFTzYNhj3qIsNmYvOGbyopHJMoj3DgVHNpsIj0LLN2wfjLQ0T/nN3croL?=
 =?us-ascii?Q?9usTjvCEmfE7vWP8L8jZV1ILbkwQ1UB7x0a5fdUfCRjIyNmWV/tKOmDHRv3d?=
 =?us-ascii?Q?/OOzUFcVTnYBlSsbz77cUchKBbXGZ6fdupb0XODCnOp3/i1TAGNIagSdaC7g?=
 =?us-ascii?Q?V22OzOtPwyS0//Tg/+jYngkhJKIi2ugv1N9bsAOz4a6AvgR0sW1equkey3wu?=
 =?us-ascii?Q?QkUyIJRweLL83NspOuh0LdswIIoB6eXVGMKEzL4Q63AtIcdqdBEuIwCudyn8?=
 =?us-ascii?Q?Rm86q7o3pz1nzkt5HFPdElevtUyCBw8EhEhVLy+J79T3Z1wnqs6hHELX1GJb?=
 =?us-ascii?Q?5JGpBfBT2j8gESQvKUgpZ4z7kc67MfA0DCkHD3X0KgCkBXWB6BC6axdqfhc3?=
 =?us-ascii?Q?sCI+oowOpXIrdTOI7Ns3kb2OvZyu6Nc0CoiNKnoUkXnftvlC+CmkiYBvXqDK?=
 =?us-ascii?Q?ZOhHKAPYh4/S7ymBegb4sSGkrgSBiAt9hs8z/kdQt/9zszI5Qoy1nscaH+Nk?=
 =?us-ascii?Q?7i/TDs/dIwfiGHb2uCZwmlF5wFBkSrBzEKbV4j/PjEVSumfBJtbJ+ou+u9v+?=
 =?us-ascii?Q?0uNiwrs03oKS0/6c7LBxFQL6wiOInPKWXqc6CGXY4sT4RwKyZRZIdlnd1+M7?=
 =?us-ascii?Q?HuVjj0pH10yi0zWnXHiWw2Wr4CHfkabOuNB3ua9x+RaokQ87jWmdHkIHRzW8?=
 =?us-ascii?Q?hwTOiGx1F/vhbl+aml8J+2eXG6T4D/sU2t/tGtFQzC3IFdCo+ALUp/GoAvTs?=
 =?us-ascii?Q?CBjv33N1lzjP0CQYXhlkU6xd9dbS9KXAVPBupaL34zse3YczyieZb8VKAmXy?=
 =?us-ascii?Q?ovgxoiW2hgzLa5+9EOwycNGySyX0UDE=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fc66f94-cf5e-4c9d-92aa-08dee6f33ea4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 06:42:33.9273 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f3sfucEA4mqkbe2j+7sHatCarUDHlrVKnkTn3Pqo7u3CKnX0nEbnFr7CCJWxDsvicJd7jLwqxGZr8DXoB8cd52ZhuV/Fh4jRwnubNlurWXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR03MB989177
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=altera.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cp9dc98BtOM//Gfsv+/4N1rpG3NtVmRiO2ViXjUcB5I=;
 b=SLC7PC2nNZfEvN0VQTF09bCc3Sgp8iYmBaYMQHTOUOdoKxSzM5P2AVOX6wsg6Nv7GgRUG6C/uYKV+YtEJyPFZ5E8U/9Yv1xyzM0lXMp7/kI57EsnElVeTc4bIerb8hypHGlm8iCmOEZWIuvQSPy1+Us8DcxKMe2lWbGRiN961KLM7/GAKp50zOaesC3pBSZ2xfRiTyEYCFP1rNgLM4L/RYaUOqy51HHSyqSxN0/XMRBHCarsYdlQXvar3etRabTEM2fQTzUBkUNfANy+oQtD6yixaHyhGHEf2vWIJ+zQXveBP498ltV/4wzWa7hJjl+bNr/6z5MKPc6eePqLWdEouw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=SLC7PC2n
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dinesh.maniyam@altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=altera.com header.i=@altera.com header.b="SLC7PC2n"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
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
From: "Maniyam, Dinesh via U-Boot" <u-boot@lists.u-boot-project.org>
Reply-To: dinesh.maniyam@altera.com
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Replace the early legacy CONFIG_HW_WATCHDOG path (L4WD0 reset toggle
plus hw_watchdog_init()) with DM watchdog initialization via
initr_watchdog() when CONFIG_WDT is enabled.

Call initr_watchdog() after the clock drivers probe and before DDR and
other later board_init_f() steps so the watchdog can obtain its clock
rate, while still running from on-chip RAM in SPL.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
Changes in v2:
- Rename subject to arm: socfpga: spl_n5x: ...
- Expand commit message for HW_WATCHDOG -> DM WDT switch
- Drop unused smmu_s10.h include
- Comment wording cleanups

History:
--------
[v1] https://patchwork.ozlabs.org/project/uboot/patch/20260304040843.11298-1-dinesh.maniyam@altera.com/

 arch/arm/mach-socfpga/spl_n5x.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-socfpga/spl_n5x.c b/arch/arm/mach-socfpga/spl_n5x.c
index a49be837921..93424c2513c 100644
--- a/arch/arm/mach-socfpga/spl_n5x.c
+++ b/arch/arm/mach-socfpga/spl_n5x.c
@@ -17,7 +17,7 @@
 #include <image.h>
 #include <init.h>
 #include <spl.h>
-#include <watchdog.h>
+#include <wdt.h>
 
 void board_init_f(ulong dummy)
 {
@@ -34,13 +34,6 @@ void board_init_f(ulong dummy)
 	writel(SYSMGR_WDDBG_PAUSE_ALL_CPU,
 	       socfpga_get_sysmgr_addr() + SYSMGR_SOC64_WDDBG);
 
-#ifdef CONFIG_HW_WATCHDOG
-	/* Enable watchdog before initializing the HW */
-	socfpga_per_reset(SOCFPGA_RESET(L4WD0), 1);
-	socfpga_per_reset(SOCFPGA_RESET(L4WD0), 0);
-	hw_watchdog_init();
-#endif
-
 	/* ensure all processors are not released prior Linux boot */
 	writeq(0, CPU_RELEASE_ADDR);
 
@@ -66,6 +59,15 @@ void board_init_f(ulong dummy)
 		hang();
 	}
 
+	/*
+	 * Enable watchdog as early as possible before initializing other
+	 * components. Watchdog needs to be enabled after the clock driver
+	 * because it retrieves the watchdog clock frequency from the clock
+	 * driver.
+	 */
+	if (CONFIG_IS_ENABLED(WDT))
+		initr_watchdog();
+
 	print_reset_info();
 	cm_print_clock_quick_summary();
 
-- 
2.43.7

