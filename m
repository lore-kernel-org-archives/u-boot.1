Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE9E606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 08:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=U3deSgyW;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=HcHy5P1T
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 95FB860604;
	Mon, 26 Oct 2026 08:14:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4HD9tuT-VGmD; Mon, 26 Oct 2026 08:14:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E3B526060C
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793002459;
	b=I/nTfnU4GafF63TB2rlPvdoZ55wq0zNIXLEYCciW9Ex6mTLDMeeZ7lkFtrx/TBCesdi+
	 GfNehMfjLj8nMfpWsRzUsCpZlGw1XlazI8wCcGtlh9e0XqVsgqygF88zWZhCxTEeFtx2Q
	 TBv4ZbPA14/Vs8GpN6pWiHYHh6Qpc5aHa9VZo0JQyr5Lw3kV1r3YV9hVYrN3+PRDSNVTS
	 vxO5OMkGooG8JExDWlY6YVjVphs74/vhxRON0fZSwnxBdcLzoA+58CA5SFZ8wINz6PJ0n
	 i5Y/AJ2bmNbRPDfPXs0Omb8Wsz9VkyOJnUvV7u5+gieufTdry6u6XrmFQfS7VWO3UTA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793002459;
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
	bh=uwD8Ki4zXaVwsEfuJSRrQN+O/WOT2nmY6bm+stfOQ0E=;
	b=V3MWaPXTzmzCgeiV/gqUqPgo00Qy63H3bhTJW8gY/PTC0taZdbnnawQl49kiPGNNvpGj
	 J4GwE3tU013rjqSAF2DElJU7+VZa44Od4D/lqH2Ixy8JcE+Qr2hHyG80x6+N0BRZ8d2mC
	 ZEUN2135pUVP6mXP9U7tgRhHv4QblDqx8G37diWuXXpt1AI4pcPc1XhCqsixr8blyUhUG
	 rVdo+K9AN1Dh29xVDIIF/3utfwD+jG8jI0rgt5c4GMM7ne1BBHxGXA6oAoyiixBsBmsK7
	 Z4tFXi0XwFq1hjxKBGVoiOZ5L+kZY86hw7riyrR9K4A+eqA1/39VP6AVWxHTvwR7q+w==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=HcHy5P1T;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793002459;
	bh=uwD8Ki4zXaVwsEfuJSRrQN+O/WOT2nmY6bm+stfOQ0E=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U3deSgyW1HUlsnfsUGNfd2imVLcwGuh83r44MP9XRUkUF52GqY3+ZkC8kyvS9JL0I
	 Izd/gFapWtBq8A7D6+y60xzEQlizV1S3ajIgBN5MEQipEU+vJNDguc1UYEgvnu4Ap+
	 dKczaDBmBhVO4AWAcdCiy7m4qVV9cxmVgi83Uwg6upsVxS1aO6ShF0fXU4TBijuc+r
	 gizu7goXrE26uB8wVuqRFszsFMQrlfDtLvVM23snjHpAz9ykkvGsm8PetL8zpsfsBi
	 BC6vJ3CAfBsJzvrv6YNhOrOTD2NdNTo7XzzAVZrDaYYHlwHrFAUyXbEurURXAvnOjW
	 FRlBfzcpIfN7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E3B526060C;
	Mon, 26 Oct 2026 08:14:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id AA5B3334
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:14:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 95C2E6060C
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:14:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q8KFbwdJJER4 for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 08:14:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CB75E60604
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c001::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793002455;
 b=bKi5goTIGjOyYJqHzKysk22h1Lm/NCQdpbk1GWpXeefBeEsKEYOu7kOSzHjyAcpoeN/P
 qIeUPwWhaqGPzqoCAcSIOEDL0vLA7chkIx0AQ9QBV4qT0CrsFRPt4b8aYriQKYHTcZfyJ
 D4xOJHM1f611vgpaisVhuEG+S5LYzFigoje2onf0KFZLftsd9lDGSFi+SV0i+bskrN3kL
 AQ7acn7oEKiJ+iAG3ZN5prl0fIf5f2aSGYHFAsGdYUGeO7OSrm0k/ZRaqCqsEA6QrYF4y
 VbFAxzQ4oiMz3HziKEMiGZq/RxqMoSvyxw/76XpLwneBiAFURNOtZ3QGWPxudebmVKQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793002455;
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
 bh=uwD8Ki4zXaVwsEfuJSRrQN+O/WOT2nmY6bm+stfOQ0E=;
 b=dL2PqKN1Rs2w7n5pRLRE5MRgTnQd6Ensoj1NXOSwOR03Aq45amI7GPDmPOYBxnONfv0z
 Gduy7vSmD9iu7uO0KCrsVmGdabZm6DaQr+2qgdM3O/+OyoReS16xd9xh+z8jEr+YfEt0D
 bD1Fq6avd+KS+jX5zHRkxO2v7Xlz1tXzDI15OBJiKmEvQgLx9Gm+GInc9ZKV3Rd3FpujA
 R8JV5vfog/NsC8AxpjtIHFugXGKHytW9mPk3LMeK7RgFa3g3yEM4oP2aIMpXRH5c3xzD5
 AvBMaPKzUG2ooA2SGYWrG5patOUtSHropy6/hrNBs3AMwRGR8sy6C3GZKj9d8oqPqoQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=HcHy5P1T; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c001::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c001::5;
 helo=byapr05cu005.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=HcHy5P1T
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CB75E60604
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 08:14:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UIVAEDs1AFi/mFsin1tqledF4nTusiwOLh+P2fNGsQP+/TMu6fgxNWZRZEhj+fE5Ijttuv+RPQs+XMfMeawxlx6CdxfPwCyUIKM2J79JJHlhPEUYFFzormBki+b1IsKoPxv7RTk6qnCotEa0oVK678LN/KNhlVgV2TInb64D4g7jDn05LXntwHcNB2hzifBZR5Jim/P4L+WM3kmIRwtfMhLuKRd4+goHEC4oBjgO6k6LRdKn0YaEBZC5bnZKXb7AQo3BY44WXH8fOphortOog5RLEfuaiUlkPvqon/NuaRTF27m39vc4rlHB1LIJkrksbivgQ4gyTxBlin9nqKFapQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwD8Ki4zXaVwsEfuJSRrQN+O/WOT2nmY6bm+stfOQ0E=;
 b=PiQD6/P4ZbbqZJAn0A1YyNg/AZLd29u5SiYSajw/8h7v6tiMxB+md8duEWsjOm65881fq1H/jzWrta1bsJFZ/LoqlFcfZT7X4N+SM36Tyy6A00XNxesuDrA6Ca8e3zxPGKfXiP8/rBNPqXrGsJJSJwfqpYGZ63keOFAdAlFF2vMgD1vP2Y8lA0R33CjaPmSu6WoDHQn2oZM6F0W3io0aNJghPOKKxB2BrxmYklrmfnd8dJoU+hatmbA+VHgF7G71A7WdH5zMb5n6jOzIYxWf1MDBkiVyCRKNq+h/V/GD/9duxMHiPvXce2gKVBzftOK/TBnl1VB2M11nye47EHW94w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwD8Ki4zXaVwsEfuJSRrQN+O/WOT2nmY6bm+stfOQ0E=;
 b=HcHy5P1TDKbaDxOGZBsD++zTN8HbO19YQUMi7kjttSlPSWcpYkohWC86eoGRwUH1yqZ4HtzphTKq0VP9RFa7t/gTv9cZwdPsHkNhsOiYdjpTrD3dKTnoztY2YvFgBAbhIxMH+DO47r168sBLZGfxokNX12q0+qx/T03fBLVsyLE=
Received: from CH2PR17CA0027.namprd17.prod.outlook.com (2603:10b6:610:53::37)
 by PH7PR12MB6468.namprd12.prod.outlook.com (2603:10b6:510:1f4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 08:14:11 +0000
Received: from DS4PEPF000001C0.namprd21.prod.outlook.com
 (2603:10b6:610:53:cafe::10) by CH2PR17CA0027.outlook.office365.com
 (2603:10b6:610:53::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 08:14:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS4PEPF000001C0.mail.protection.outlook.com (10.167.23.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.0 via Frontend Transport; Mon, 26 Oct 2026 08:14:10 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 03:14:10 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 03:14:09 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Mon, 26 Oct 2026 03:14:08 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Padmarao Begari <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 03/11] xilinx: mbv: Enable Ethernet support
Date: Mon, 26 Oct 2026 09:13:44 +0100
Message-ID: <2bde4cf973133c52a6963e74ba1b2e8d227eec17.1793002418.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793002418.git.michal.simek@amd.com>
References: <cover.1793002418.git.michal.simek@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1256; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=PPhOuGgRdI2NVvBeS+iWvYbMbBt+cvoKKTaCZDZbxfU=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTd597PG52//1N1jXeRWtfaB66yq1edtOyeWrhUT3nmA
 0nOIz1LO0pZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAimosZ/grZfExMEtKecuKi
 +83fi/69C4zdv+PIwzZbCbZKJ1+lFl+G/+EPXd64iD7kFmuuL+wJPPlv/jnObdNYrhxxma9b8yn
 hFDcA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PEPF000001C0:EE_|PH7PR12MB6468:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b5f08ed-ae1f-4032-a77a-08df33391d3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|18002099003|22082099003|56012099006|11063799006|261021123027099003|10067099003|261009223027099003|261021121427099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: OuElkTQvP6Vgyq5exWL0ot2vb+xkHwaAkI5jnQ5KHzEesCgI5ovecaBjn3ZJMmtKpuXrDxkfEGpYz+qPCJqWcaLPLSBnRLlpamFBNodeff6sVOeKAtbXOz51dxmljO91Exbvc1dkuu0X9U3y3WEj02gb5VMivVrn01X5o7Apy1A0Kj9Fh17Z66LmqAG7CUpSy8pm0c82Gqk6wK/T/kptjqksInSaGljlyvTsGSa0Y88j8IJUmjUPU4rQFseIvEp09dqH2jR0hkzM61yzCV1ynDbwIIcldYMErcCe5T1IoEP+u1B9M83BIOLhArMKIhi1hHyR0FY68mmkB1FknkbxstY7OC8e69ztN1DLcYY2mKuF16+4IzP9WwcpXprH5Z7ILGdDqcynKQswwbSvPDJgTG22NuXa7AeR7cBruJGrC1qDGfzNqw0qg7JOGMuOIuGZGEA3nirJjn7zQ4oV6zp+D8Ag1dlOaLKOecanRhwQJkamjdcNeKgLlo8nF0dWMJDiiCcCLf1hF2pA+XYLviB5Ad01xqxcGLtg9kxYLwHIGlX1YesQxZcSk17QCbFwdBFYinqx6tNh3Ud+ykn5/0Ln5S5Xvpwmwfbn6NLO68DgaH7+yvaRt9gWEs3pq4buBq3cflRpVdG1EnoYGeviD+WFWtvH8ZdV6kLgIeruXf/1wK5g60/MyhQ1xnoJc2R1F111l1cDACES6L3RsfNkPyB9yw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(261021123027099003)(10067099003)(261009223027099003)(261021121427099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NYjcygZOH5eCZYKLjF4E5d3YzkajBgEjpBErJoMafok/W0v9uJwS3TWjzNKEFY6EPz+znKW9IafKo2G4kUKyTqqSyFXv3E1LTw2ri5F2N6yiI60mPlfFdoD5xRoPCmG0zzFIymJmYHTf/edMxiAmdo7N6Iboz1WgxAfGqOoLUIFIRn5QplJAJnML+L6jznouVv0J6v9Zk2Xc/sLB0tBUnlhm8Z8pZeDHUWpivqPYvqkQW7p5BvWInhCQIY23RXEzm2AAALb2U8ePNcxkgK2SG+4ZH3BSE8LKtAnb3HX8LEmlnDdtvkXuS4K+S9g5jFT8fpHJTw+9zgRg88J2GX/gI6vPvANwojrfcYYkceVAfy0GOLCdokljrvLFg4Q5epS7kJTRb9+tugp2mGxXF3szqdVV3k+gHfjjqCrfdZDP7oFxjv9LBya0QNxrZ6+PslnZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 08:14:10.5750 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b5f08ed-ae1f-4032-a77a-08df33391d3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS4PEPF000001C0.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6468
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

From: Padmarao Begari <padmarao.begari@amd.com>

Enable Ethernet support based on LWIP with emaclite and axi ethernet
drivers. Also enable phy drivers available on kcu105 and scu200.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- change subject and enable only ethernet because upstream QEMU has no
  riscv internal timer enabled

 configs/xilinx_mbv32_defconfig | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
index 47cecd6878a7..07ed096ab480 100644
--- a/configs/xilinx_mbv32_defconfig
+++ b/configs/xilinx_mbv32_defconfig
@@ -43,12 +43,19 @@ CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80000000
 CONFIG_SPL_SYS_MALLOC_SIZE=0x200000
 # CONFIG_SPL_CPU is not set
 CONFIG_SPL_REMAKE_ELF=y
-# CONFIG_CMD_MII is not set
 CONFIG_CMD_SNTP=y
 CONFIG_CMD_TIMER=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_NET_LWIP=y
+CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_DM_MTD=y
+CONFIG_DM_MDIO=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_XILINX_AXIEMAC=y
+CONFIG_XILINX_EMACLITE=y
+CONFIG_PHY_MARVELL=y
+CONFIG_PHY_TI_DP83867=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_EMULATION=y
 CONFIG_XILINX_UARTLITE=y
-- 
2.43.0

