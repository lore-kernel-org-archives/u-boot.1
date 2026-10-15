Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00BFFCC6B33
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 13:15:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5826160AAC;
	Thu, 15 Oct 2026 13:15:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MAnvfmIq5b_P; Thu, 15 Oct 2026 13:15:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 63E3160AAD
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792070101;
	b=Bmi/U6rjQLOZAPhNulTD/ruuNpEo0kB/OESlncp6+YtVvclfKusG3Yck9vedGdjWoBip
	 JVya4WaQnjmuPZMsTB3De2QdHhBo+1sqeKeoPwLjPM2bj/lotCLmBi8xDtHRVteEvWAhc
	 4kjAUgV6JWKAxbBGd8tQ0uIIMa0quKCh29dCOif8XB+BB4FPkGCdgCliF8EVy50/pMsaQ
	 SnTnnv3JocT9M4nuDfAJFb6rz4yxBKoahkzA+lY8yP4oxKSw5VCtiRqXTg/Gtn5492zHp
	 aRprf+sxRB2qCsKWVzc7OPr2foVhfvIoV9RpCmXzCtR7e6+sGtFOZR6TUuaLWJmG0tw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792070101;
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
	bh=ly7rmmvvYcSCrRUvUbrw7wx9oj3M2xinkNeZx4ujTKk=;
	b=b2/r9l4ng3B1tm/nV6yoTeFh3AZaea83dwjr4toCrnPyiUt94Z/JqBCuai3sxRdY7mKp
	 YpcSFs+EJsxBeR/IuYdpkej7hF0Y4iLLGF3aQndo6W8f3vhx39gQY8Tm3EyD7LrVn4Y9v
	 xLRRQbkxXko7xuVja8wOTZ7NPKNMF44A/VrG5WEmOBPrK3rp1FMBRjgt9523KqOBswnNM
	 AiukBsY3ZQoJs/yU/xmvM2I0l1FS6TzNnbz7UIZ5yG0CyG7RvzXMQBqfHHyzatTbRtvK/
	 HbDGwG7fAY04rKdnnxceTJy1yR0f3vulCNUBe1dtLBPmrMfk02WNO+fgLHc8xn8XB2Q==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792070101;
	bh=ly7rmmvvYcSCrRUvUbrw7wx9oj3M2xinkNeZx4ujTKk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OKT3YZYXJMKYNaa52kW6WbqWgb3cmPuQNmWqLPvV6kpzjy0bv/ZRP4aWxAVXT6h50
	 ua/L3yElu8Q8IPhmVXvtp6az7GmxFPwXkGeWsfvJS8dyChuT3ePG3RONGi1P3F+U4p
	 cPtiqH+qOz4IYHiXASzBXO3Wu8w7dx42lSCGqFiWwLNs76QrGanK3ePbO9skTj3Uhr
	 QNwLA7RrTQtWZDwOLOwoZP7MsPBpDqKu90o/57R7XNWFrSIu9X2T9WTm6i8G8y2pT+
	 1WdvDnJiEKd1pxA1p2gEwOErpFzQftnxBrD3fYcXDhcAu8WFSfMZXxPl7tci5FdzfT
	 0ruUc4mZy5a8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 63E3160AAD;
	Thu, 15 Oct 2026 13:15:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6AB9BA58
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 11:13:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 503864080D
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 11:13:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RFUxn7178eML for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 11:13:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 363D1407F3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c40f::6"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792062833;
 b=SumVJ2qLwsP3Dzuj/839JLvp8pRr85vBQYHSP+QpY7BX3HxrTrEqlXs1DPkjO24H+mWF
 bmhDm8+1yMfaBleKRBhuOQi6TVBu6qEKmA7u5fgXLvs7OWaJoPaWM8OnXlvLCXc3eHgVy
 gmbIz/wlNT4gfoMvKdH5q13vKCCX6w1HlRjI9PIaUDPqQJtePUFqVL+yMS0NAnR0AT9AM
 jMVJhfqrysGTID5pjyT5sGSOUs5MpWJo4LHVgxDg9/h9t+Re6nrjGLCWvGjzRlLXblDNs
 U7R4RFvcZC2oUuqxr2rP+JFnUGyYg73a40CyxfX0Es1mAFjZ9kYzauDRZEgT1LbLYvA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792062833;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=ly7rmmvvYcSCrRUvUbrw7wx9oj3M2xinkNeZx4ujTKk=;
 b=d8UuZXhWdIH8RmSMsS7dVLC+YfK90ulDUM0lNeD6G+lWwK/0pwOc4TkJY6RvrNhwkWAh
 yiwQJ9RglgyFe2VN/FG2gqF6MzUdq2TMIDxGnIcRUOBnzV5ypa3bfo3IK4y3KwV7qlU1P
 FrCTfjxVTjuHDOKxrMZQRL+MpK0hKVwEt3TiKVvpxbJFFaoSoJswcqrJxpM/U0i5/BbQ9
 xsw+XuCM7WQA2OVl/MWyq+PQLF5zhl8A4zPUS5ZpMjvRlcOmKDbhd7a0M2upzh2pD0mYY
 YeA4c3aprlEp5I/4mIjy5NkLcju+pIzO8PwJdYgC312U9VnaNV7hhk9qttoubwn6O1g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=processmission.com;
 dkim=pass header.d=processmission.com header.i=@processmission.com
 header.a=rsa-sha256 header.s=selector1 header.b=fVYaVTO2; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c40f::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c40f::6;
 helo=seypr02cu001.outbound.protection.outlook.com;
 envelope-from=bin.meng@processmission.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=processmission.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=processmission.com header.i=@processmission.com
 header.a=rsa-sha256 header.s=selector1 header.b=fVYaVTO2
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c40f::6])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 363D1407F3
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 11:13:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ah4eV8n8JxbdOUFSvODlqCzaruu02jUrrZGA+1dYO3NOYzmS0IJp+2IKL/8P+yChM0DsbT6YbTHYgQ/Okh+l/2y0J1I8Sl2rkjPhTTpG2kyWH+39iwR6YrxHBsVZ9r4UNKRgGN5NcQQoTdk93qLhTUmlI7Wi8sV719Yb8s+nJyrumDEwXGrYnQpxzXjNZLu6yxOPKrKI5qzG+8nlXL2sJpgpWK/eqNP1feoee6UmcvLVQ+D0TeHL1XJneIa8fzzq4zQhGMaKxeUByF4YsRmYPmAhPgX6xv72bhtkFVAQ9RHUMh18Gzsnd1ZbR5idXq5ZZGfV1dPlDJsCk8RnSrqFEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ly7rmmvvYcSCrRUvUbrw7wx9oj3M2xinkNeZx4ujTKk=;
 b=MbrfHlRz/MsS15KJY8KUocF8jtaa6uAB0w9YC71+l642IYW82UMid5WksdH7xFaXNfucMDSt7wqwrHv3GpPjcMXU+pZtnAsv4v17UQfpDW6CumFlaUykUWYux+MGdvxAmj+p4Pg/B7L6nx66xbG32uANCQkxCyEw1ZZR5SKoQteTl+Nk+RHrWZkaA1zAVfhGOKs+LZgROctTSY0jDahnEfloCo7L4xV/5OF+JBgWvagkmrGU5PrFDJsdlH8cUZkjKhakM6QAtl0PhzUmLnRaC7QEj6a8Rk7scsULMG7UrNVLTqqyme/pZhmysijQDziOcsdDhSdepx0O+91Rf0+9fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ly7rmmvvYcSCrRUvUbrw7wx9oj3M2xinkNeZx4ujTKk=;
 b=fVYaVTO2nuQe2vCXBPYYbF6m7T9tJmNAezBC3k3pIovfbSfQt1TeKX9SLlJwzBXTTm/gCNiu+DRMPrxlZjgXi1ysIFwxmXzRLEkZ3/lYvaYJpmfcSGSs7HcIikh1QjwyhYZdsARvJmIGaJlfi59Yns+Zt0EfBJ994hYPIUqTtbUL9JB2Hs6poOSkXUnto3iUXp1zEIFyWr0L88jMvZTNKw3D5YdxRSmrWAOirbm0p5vnM59JODtmbJ2GYR4OshRvdsKp9k63wkjTI3yVzaWWNLUTs4P+d7oUWj8DZ3e/TCIyIFzvU997FxCBQdC4hQ0xe8RJpcv2l0UPkInIaRnOSA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com (2603:1096:820:da::11)
 by KL1PR02MB6237.apcprd02.prod.outlook.com (2603:1096:820:9f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 11:13:46 +0000
Received: from KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215]) by KL1PR02MB6257.apcprd02.prod.outlook.com
 ([fe80::ecf9:e832:8196:215%6]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 11:13:45 +0000
From: Bin Meng <bin.meng@processmission.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Christian=20P=C3=B6tzsch?= <christian.poetzsch@kernkonzept.com>,
 Daniel Palmer <daniel@thingy.jp>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Marek Vasut <marex@nabladev.com>, Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/8] virtio: Fix virtqueue teardown and probe cleanup
Date: Thu, 15 Oct 2026 19:13:15 +0800
Message-ID: <20261015111328.1269775-1-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0354.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7c::17) To KL1PR02MB6257.apcprd02.prod.outlook.com
 (2603:1096:820:da::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6257:EE_|KL1PR02MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: 609c37c5-1cdb-4a72-e8b5-08df2aad60c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|366016|56012099006|261009221727099003|261009221227099003|261009220027099003|261009223327099003|261009223027099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: smbKz7yp5Cvba8G5DwqWP51XSj38vghEMZu90Qi4RhCyEjH6sAOURGmEI1LgsOkLF6qKkR7VoM4etAp78zjQED0Hfc4ScluHmiJkoZRD96ofmOyrGQlSCODBZ4bQ17JWF1FIVvsP1YR68o1kSI/UA1qseap0mco69mzfo3I4tw+DxI1/e+q/dxE6/YmV0qU+BBFPgYGEOrw+VQ7T03NexmQbBVWEGkRzuatlf4TMoysBTLcWoeqkcXyRv1p8JQgratabeHGC87o7M6nnscsQ7zQPmjeXulJeZpwMO5+9jpfXfgEzUE8iA/Yu9npOmbz7C7d46HN8PA3GjugLG5ZWOJGFsm0BObW9DiFXf0UYynpnC648EOakiEj8pZyNmyL7g+OcpBVppu2FU2h73Yf/PZaheKPB3D1ZmvHSDNXnS/3p0R9AFTpngCiMV4wOcK0GyFFxHRyNkHO7IZdhfadqDUY4xNEtIXPrL0bfsArai69ZR7GStBkPC2Hg/y0cKrzAFbO5qhHllBJmnDv96WUVOqCcWnr2M++i8/kGrh6mqrH15sJ8n+gUzzBVXn2NF8mFMFbGFZyDo3jpn+IVkm2voBM+GxhXHBm8GOU6a3g05E/6GNvOhMMu8wKbNZFVVi8DAh14abOMpH7CCSUH5QPOMcGFRawH/kiZZkjKMJWMO9g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB6257.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(56012099006)(261009221727099003)(261009221227099003)(261009220027099003)(261009223327099003)(261009223027099003)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M2u6o78TzMnbeCx+VeKrXajYl+xd6PRdx0v+CxB4EGMUzSrUmTkZlWS7d3ql?=
 =?us-ascii?Q?HXaYtRwaPg4PGtEdYXoJBPljXmWVJayMbskExLprj+Wm9cvKffJilLcR00MC?=
 =?us-ascii?Q?E6CUe35wo9myhokRuurt6TxIigpFuUTTCKkVvWL3+B6K8tOrxZIgNbkoQJUX?=
 =?us-ascii?Q?Uh322193O/Jl8fum7a4IzI5N7OmTfm5kToA1d9pZLCv//2ifh8WPSiabPE89?=
 =?us-ascii?Q?lqSwhnrFa6KmOI2suJh6vizbXa38UuR9NDFxQM8hQo5B/0SIdvPfeuNgZ4PX?=
 =?us-ascii?Q?1NCrJZThlGlce0NVmMFjKg5w1rt/usiR2n2+dc9FyZGn9TO4p5jPTuU5WbbK?=
 =?us-ascii?Q?siiuTYtkWxEJ1wxfQbxUy02PhIEXKJy9N0zMuiCsZxLM/116KOxT5ASu2SSE?=
 =?us-ascii?Q?XxS5cEiUlV/XWKzLyrKywsTaWFam8JMFTk9ErAMwfQQMxKRByos2CNKdChOD?=
 =?us-ascii?Q?S65fdqVHX24C8Zc+vfH98/mVq8WqTkI9uUco7uthSP6YdxhcBMK2GYqD+Wy1?=
 =?us-ascii?Q?f317Wb/JTX9OGjgs6QKF2P5yPwuEnGBbxBH9U6xBLJg5td62TOdcD27u5J1x?=
 =?us-ascii?Q?WAKFaw6tzrRV3GglNPdyEWdo8egiJgF4AbMCKk10urA+imJSp2uKgfqO2lKb?=
 =?us-ascii?Q?4yDvZ/CC/aj3l/ZdKTrjNtk824r8yCYwFbdrG7iXYzBf36l9XQnl2Sp/igm1?=
 =?us-ascii?Q?z2X0xYb7Ky6dxnprK6eoRsiE3uPaYyhLFUOavPaohUvfnfsySXZ6oNlJYyPx?=
 =?us-ascii?Q?vKuMz5/tTAV2zvY0Xt/foZF3HaygpDGawJ5vGukebMMLS18XKPId0Z/X2jgt?=
 =?us-ascii?Q?+TehHHJZT1XIkzfx7j7vaW6zm79Mt7ErzM5tWilgOBF8Qv9OCNpsWAb7zxat?=
 =?us-ascii?Q?+QxJgdUdPlPTvwwlUGzKqEu8ISbbps7xECRyPTm/reTajk5uMJanbWXOqmRh?=
 =?us-ascii?Q?6i75P3qlE4v2xWx7J3LjjimXdHxiN1C6lHhri6ycfFuS87yOC2NV9v/GJ60O?=
 =?us-ascii?Q?8S1xbcaZSXUVsrWj1SddcGCLVh56sskJX+qzDiXz9rPxtfWVmB32iPzexDbk?=
 =?us-ascii?Q?rY2eezTWXpoLcrZ3/7OvWBcI83+oIzu2QwpNePyJTIai2Lut63VI6h9jVA4U?=
 =?us-ascii?Q?5ut7COag2QnNXf8EesIHReQ3I1+aQfDY3+IvC071NigCurmuWiykmIW2zny6?=
 =?us-ascii?Q?upXgVCyoO1zal9JUBe6j1U4ZYpxoeZR9F5VEwWd0NzaWrzeyrqou6YcABDjW?=
 =?us-ascii?Q?v70YZ8f28E6WmpbL+3bxMi2tabrusRBFx2daN35eYoKUW5x0RGBnbTBXYJ0g?=
 =?us-ascii?Q?Bdol79NjAepQSb1RY7W1QD9r4z4qjLvC3xWQjv6AmqVUMSVlSftOqyzaDnbO?=
 =?us-ascii?Q?cfI7RuRtHiM4UAztEiDB5tAQBvkz4cRoADIbqeXhseGvNl8nWM4nLZDD8dfr?=
 =?us-ascii?Q?Xk8O83kEugKU59O3BivJ6Dp9KAraFaEOPGw296A5/wvplmiZOL9BJkBz3JvM?=
 =?us-ascii?Q?o1FJ1POcb6L/BqjQdy6fs/zRxf+3QSG71Xpe87pQRGKxkVOqsBvf/UsJ90r2?=
 =?us-ascii?Q?FFY4B2nvQsRY9oLxK65xgCqCOrHBRBl8Pc/BjiXoGAgfMwRwGRo5+agL0OIm?=
 =?us-ascii?Q?9sjPIV3exnVNIjIXxlJx2WCBJctXBkhgbO1IdWoUEcOWQ9wLKBwmFtC1Cvtu?=
 =?us-ascii?Q?u2duAKhd74+t4OHrRN040Tw5WV03y9w5qOK7OOeIU/AVY04ZzKDmBISjT1xE?=
 =?us-ascii?Q?OF+lALuWqhVwcoVL5Aede0dtOX6CABI=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 609c37c5-1cdb-4a72-e8b5-08df2aad60c2
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6257.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 11:13:45.4345 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uqek7qoEjD0hWoEdmEktM3XxnCoGS8YIMu2nJ4mKKqtHq1I5V95bQlJ5zUudvIsXPSKiYdb3QhE7/k6afc+iymAMAvaChZX0GDzxHmVuS2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB6237
X-Mailman-Approved-At: Thu, 15 Oct 2026 13:14:48 +0000
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

This series fixes virtqueue teardown across MMIO and PCI transports, as
well as a queue leak on failed virtio block probes.


Bin Meng (8):
  virtio: mmio: Fix private data lookup when deleting queues
  virtio: pci: Fix legacy private data lookup when deleting queues
  virtio: pci: Fix modern private data lookup when deleting queues
  virtio: Release virtqueues after device reset
  virtio: 9p: Reset the device before releasing its queues
  virtio: blk: Validate configuration before creating the virtqueue
  MAINTAINERS: Cover all virtio driver-model tests
  test: dm: Check virtio queue cleanup on device removal

 MAINTAINERS                        |  2 +-
 drivers/virtio/virtio-uclass.c     | 18 +++++++++++++++++-
 drivers/virtio/virtio_9p.c         |  8 +-------
 drivers/virtio/virtio_blk.c        |  7 +------
 drivers/virtio/virtio_mmio.c       |  2 +-
 drivers/virtio/virtio_pci_legacy.c |  2 +-
 drivers/virtio/virtio_pci_modern.c | 14 ++------------
 include/virtio.h                   |  7 ++++++-
 test/dm/virtio_device.c            | 19 ++++++++++++++-----
 9 files changed, 44 insertions(+), 35 deletions(-)

---
base-commit: 32ebe922e574a733d01c3f106fa77d9176bfecad
branch: virtio

-- 
2.53.0

