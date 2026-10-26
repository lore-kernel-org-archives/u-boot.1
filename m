Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F9A606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 08:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=X4z302L9;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VC4o4+S4
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 73AB78082C;
	Mon, 26 Oct 2026 08:14:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WkgoPkHWnQt2; Mon, 26 Oct 2026 08:14:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AF21D8087B
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793002454;
	b=Yd7tvaeaZZLSge4w4M1RULCzTImQ0CXdNm/aWvzwqterTiY7hUujiKzE0t45E3eamIeM
	 Yvxhjf60bn5de51uWfuHAbRS1bZd4O7vcaPiaDyJe1YK861z0YPe7Wh6Xgw4cHmfQ9MMa
	 jRA845ui6vYjIWDX2QC4wgVy2z4Pe2ziSG2+xSg7WVi4iEcnkccDZDaFe+wFouMNVk/ve
	 pvdFS2x0NO6DqCboSWRr3Q8M2T4epeuYfy2Tbedoxv4Z5hpVgrEd3drZsFhgZddgkIZR9
	 nLLIKyg+PwVPvA0B8AsJ9Pa5rsFB3E4RmDXk3swP11AbRDEXHibPtdsMbzjYU3d1zpA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793002454;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding:
	 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
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
	bh=NRc0GDWEtE3ztHhDp3kHea9E01w466e0tQVACbnIFFk=;
	b=TUU8jbyNPk7sf0WIS2DEZFBlYVovNNfSmWHLqUQn/jSxVgfGucmTX0+geLG9EPDeelVg
	 hsi2aAAb+go5g+XLCp4Dgy+9/OLXtJ3nnJ/tsE77QzgONI8vHN/WsN29ZESZBhcaH+GrL
	 ojKm1Jdj2/P+Kwx8pXCZw1BNYHx+xC9gT60NS3K6gjqNQdJ3ryJKabZ0sydL+Mk1sxaCY
	 9hMYP38Go8XvEGZi3Pckf/jA5JYNGAmfFakCeAdNzqC91phe1dZBtw1lzN6urb2ERXG7i
	 eLlKnfvhGDTJB1NNGkhEvrK9j7drYbqdbSTWIhHAYRHTU6NRglkuYFRR5CBuAKYDpkg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793002454;
	bh=NRc0GDWEtE3ztHhDp3kHea9E01w466e0tQVACbnIFFk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X4z302L9Rd8pi4RdEkEgJb56SXyfEcU6hPubCXK8Dlxtx4D4CpZRHCdyHsfFu7BSw
	 tV1tVmkI8jMUATNUj+RomKmUC16mdvzcaAlrTvtPZ32ELrlERBpK+Qt/lROgMttz5H
	 WqiJcote+sKdwabdLBKHTd+xELcoE/AxNAla+TIz7zt3wRDnr15hDNatJlasprv9CO
	 Z5RqA1BWE3vtlrQBDE4mWr0p1mbSGQvy7sQVaEeBMe89OQFhSoKGGHzRHKm+za+53F
	 M7nAARSh/qV7TqoHRVGk2bqZUOjEwB7dmr8bnuTWwMclO/AJvL218bkFeXzqPfcwEe
	 9Sx5ALlfVJpfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF21D8087B;
	Mon, 26 Oct 2026 08:14:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4DAEC380
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:14:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3F0F740586
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:14:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gzI-Yki5tz-5 for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 08:14:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 934084056A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c112::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793002452;
 b=r2WosPEH7Bd6yYjnyyQtd5ZhC0f891gxSlbgosLXvm05N3uKDwS+J/3H354YbkybwbKI
 WBsDfgh1NcbikVfwiGJqvqQfqedbMwl9xc3DnFMvywbrHJdNWiuQKJjmGzxX8ZzYNwmiA
 GjTLFRPw3iMX0Zs2yEbyjWn9sqwJgSUliQ0WXUmxwMGgcKlAwMGN1dPJXMSNcdsz9C+oZ
 +hrbmgL2Wa7knwlWqwqUss6MQ2aitamxPji3owULhXR8bKUShWHySBYf3M0ii4HaX7ihN
 NnV+8km1y9RpDe6RBHTXEs3kNUJBD709DD4KSUKWHIvaih+mTqy5tiStfqkrvP1zqvw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793002452;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-Developer-Signature:
 X-Developer-Key:Content-Transfer-Encoding:Content-Type:
 X-EOPAttributedMessage:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
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
 bh=NRc0GDWEtE3ztHhDp3kHea9E01w466e0tQVACbnIFFk=;
 b=QKCznFiENGRHa7igACTjTCEmrMrWxZdBCBacX3vn6mm+T2R1RVkqgRWqpQ39E76faH2N
 vKLJTq2NmzOJAEwh3EPZ44gyvFli4d5ePxmn5gV8JeAUDlTQMAvK7sjRLclYqS796tX8r
 Wo674b09ryhHByYPKAc0vpX3CbEITgOS8ZCK9P+AJJLJwtqtyXMob8Xux/NfZfw7yxUlE
 YEHcagLxcnyePPp8v80y0Fux3yB733KgYoOUE0tfDyAiXS0nJc6s+fnOb5L2E4aTw11B8
 LZxsHZfSjfOIi9t4PICdVFqajxaKj0jKzEdktaBxalAqyFS4HaDo+07myh1hIfte3fg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=VC4o4+S4; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c112::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::7;
 helo=cy3pr05cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=VC4o4+S4
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 934084056A
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:14:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dQ0a8pCReOeEgjka4OaF1zBWXVeXB8vesf+BGlXVZ/KJ/5nDUkL6TxV7Gs/3cO1gFRWgHNbZEy7Unkz7XxHf4+6o30SqPORioPR3m2k1x7aIxncpNQhBQO6XR2w5LoI20z+m0Eb3+ykQRfztKVKrSF3tq9Xf4FJvh0t0Zkl6b70mqnUmlZTCBDhN5GoxALpKbYcjdHaNOgDXBL46W07zhcv4OQ0V4ZZm6pNXzbWWX/91xQMSUAuglI/dvKsZ/dxiJ8p9brkwpim2XaI7rbtrFS5bs3+zpV3E3IMwIbidxS9fGUzUfjEdS4xOwIFeg4mAoZkdCmt7ok7Pb6z4xu38Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRc0GDWEtE3ztHhDp3kHea9E01w466e0tQVACbnIFFk=;
 b=FI2NrZnjkGFNSBRPQTgKAZMx+U23LOpD57CjMI/R1lIH7Tt9xv+FaW8e6c6vNAS2JlfejKw4lGRUa0QFXsB3UtilhsS3pJGIRSpWaGMNuVEkT34z/+N1D1Wve4DDaZ/0SuPh5FzJK5Hro4xNBqH8Xc6lqCdMf5gU9h7FJOOOpZ28mlLHmnTeRNzcJj0UNT9vRdlx6wbtMp7NPMonf/INDypy51hfS9HlSqodIvLolqYt6xlS/bEWVxJiS+Z86WRRjMBuG++evpKDGapGGDjifXAfeWBdQ7yG5/r1VA5hGgJaNdUd47cB4MXj9RA+e6sAvrWHypm48UCMMR7fRkHyvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRc0GDWEtE3ztHhDp3kHea9E01w466e0tQVACbnIFFk=;
 b=VC4o4+S49u/5AOyfkBUKIPn/szWxwv/yiTIOUQmE7lbz1KyuBGSELAK0wn9YRrY4/sw7n4AxY7or0PitFIb/IY1w9B6vkrqnsGALjMXquwk1aK60PlFqEqk9ThTObBdFUc9b1740PuDAShGGR/Nz/bxn/C5Yf03ZxAizeF2dWsw=
Received: from CH5P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::28)
 by SJ2PR12MB7942.namprd12.prod.outlook.com (2603:10b6:a03:4c3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 08:14:07 +0000
Received: from DS4PEPF000001C3.namprd21.prod.outlook.com
 (2603:10b6:610:1ef:cafe::11) by CH5P220CA0022.outlook.office365.com
 (2603:10b6:610:1ef::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Mon,
 26 Oct 2026 08:14:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS4PEPF000001C3.mail.protection.outlook.com (10.167.23.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Mon, 26 Oct 2026 08:14:07 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 03:14:06 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 03:14:06 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Mon, 26 Oct 2026 03:14:05 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Leo Liang <leo.liang@sifive.com>, Sandeep Gundlupet Raju
 <sandeep.gundlupet-raju@amd.com>, Tim Ouyang <tim609@andestech.com>, Tom Rini
 <trini@konsulko.com>, Yao Zi <me@ziyao.cc>
Subject: [PATCH v2 02/11] riscv: dts: mbv: Update bootph-all in xilinx-mbv64 DT
Date: Mon, 26 Oct 2026 09:13:43 +0100
Message-ID: <60370dd54a25c548e4fb79e5a2f8f3c0376c9339.1793002418.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793002418.git.michal.simek@amd.com>
References: <cover.1793002418.git.michal.simek@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1368; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=Vqnbur2cC9htXHR0QDo0wwmqHM5+xv2pBeKPd1xRFIA=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTd597Hu/d0myifg9LUB5vahBWW/LmU3au01CCqWC9dp
 WVqB7tlRykLgxgHg6yYIst0Jh2HNd+uLRVbHpkPM4eVCWQIAxenAExEk43hf3lw48oLeyzT+txX
 1mzInnPI5eNcnjURNTYHNstxNrSus2H4HzH/96Wi7i+1hf9rb2r4SwVzXn/A63XptmVzbGnAfi0
 TRgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PEPF000001C3:EE_|SJ2PR12MB7942:EE_
X-MS-Office365-Filtering-Correlation-Id: 00284133-d2f2-42f8-7a90-08df33391b4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|11063799006|56012099006|261009223027099003|261022105027099003|261021123027099003|261021121427099003|261022075727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: D7BWHxQY4+fJTNkYg0XDU5DZpiw9qxi+5NPAYWqZcSKr90JZB8uVl04EF8fENghzSwNrC2Z7SuUY3l+iAaPZQFM9f8MecGFuvu5MRX/rbaqFOUajvoptsNuV9wUJ9gvLvgz38MG150W7IOFQE8pqQFU2DohKNR4J96Nv0Jze6F86o8TbwLuDSQXGZPZ2zJrwFDHT1ftySS8ZdgtiTwmGZ/A1bxVdPP+LLdx8To0DqT6fZq7xb8B83KP5Nj/qYh8F8LBWud9z1krk/xiXBTSJLccJU6L+SFKwhTzdCgNKIVxKhpF58GvVJNqtkLEG6cHGbtgPfNxuW/+pqdPJOHzmCe8NihOkojA8sEYwHpfUfvO9kLN2XRMYojfgQl979A6oLHXzZMj753x4tGSc73NwNyPiKb1NUdiSCO+Xge5lZxjf1JprPI8OpFmFthz0tCx3BeyxvRMp5rkHbvJqsf6ogQd4RSZcGQ07ltS6hvKqL3B9mQd6kcctKTyAY9mqVWnXo1E/RgzFy5LzunFWo53Y3PuueEyJSmXfS2UfiuJYylcoAhgb4l72AFpJslLcNp6M9yhXVX9doTrg3BQoJEP9WzsbKW6BrHSejYqBNSQiXg6S8mB2DIVZA4CpU0dHFqwaSRfIqOMtO14pd/tJQIkcEtxHo57h73qH6+ZvcqHjkEw5FKXLvUyTsQIltSaTAbkPWHzntDHyiQPHUF5Tg39YCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261021123027099003)(261021121427099003)(261022075727099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: u6Deyc9zg/GYdiPFv66TIQbdbfLWXD+MYot/h9lcRjNVUXy1v4u0x71Ar7AwhSRPbLrskUPUzyOwmCoI4n2fsAdS2HXwaq4exFZXdiEv16MYxAcEXT4ciecRt466V53ModT03Dr+7a7bcMjhPTFenbtWivuwaoL/WEtDeurT1iLHUGr2HAioIaR+buVQ08MVJRkzY94X7+RYKw9GlzSqOFJDjTGc5fwxHXQWuuv9AQIJkJ2PU5EyLBiE3w4ovCFLQ6TsxHnW+Mm1Zo00HFNvGC4UBtdmAGC/pSs948cTX7mS+JJW5sYtqWsuJrSynNGjhdsMksQ8rNsA8pCVGZfd90kVijdbyFEf/mBrwvP7KP2zs0cx2sOYxpv649eOgmi0qz58XcYSB5Krj3Ia9nBIrKPdbxckoRLQTWRb4yTmFcyMhagG3QAf2Mx8CnLOt+Jv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 08:14:07.3376 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00284133-d2f2-42f8-7a90-08df33391b4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS4PEPF000001C3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7942
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Mark cpus and clk100 with bootph-all to have them available during SPL.
Also remove it from axi timer because RISC-V timer should be used instead.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

(no changes since v1)

 arch/riscv/dts/xilinx-mbv64.dts | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/dts/xilinx-mbv64.dts b/arch/riscv/dts/xilinx-mbv64.dts
index cac7f65cd569..46950155bbe6 100644
--- a/arch/riscv/dts/xilinx-mbv64.dts
+++ b/arch/riscv/dts/xilinx-mbv64.dts
@@ -2,7 +2,7 @@
 /*
  * dts file for AMD MicroBlaze V
  *
- * (C) Copyright 2023 - 2025, Advanced Micro Devices, Inc.
+ * (C) Copyright 2023 - 2026, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
@@ -19,6 +19,8 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		timebase-frequency = <100000000>;
+		bootph-all;
+
 		cpu_0: cpu@0 {
 			compatible = "amd,mbv64", "riscv";
 			device_type = "cpu";
@@ -51,6 +53,7 @@
 	};
 
 	clk100: clock {
+		bootph-all;
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <100000000>;
@@ -78,7 +81,6 @@
 			reg = <0 0x41c00000 0 0x1000>;
 			interrupt-parent = <&axi_intc>;
 			interrupts = <0 2>;
-			bootph-all;
 			xlnx,one-timer-only = <0>;
 			clock-names = "s_axi_aclk";
 			clocks = <&clk100>;
-- 
2.43.0

