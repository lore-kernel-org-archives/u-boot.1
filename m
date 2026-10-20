Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15526606AA2F
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 14:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=J+csAocc;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mMbNtHkf
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D5C1781068;
	Tue, 20 Oct 2026 14:20:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4LKrNO6L9ALu; Tue, 20 Oct 2026 14:20:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 124C18100F
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792506027;
	b=CPedkGJyTM3Gu2H4Nfi+bYzMovLo127CZlvOfhr9uilypMkjFs8H6s7lDX84kh1odmoB
	 /axYyvgx27vh8I8Nu1JeHB5a6Hf25FVfouy6qDKyaXITVshf03PLVD3ICVHEfENaYe7/j
	 f2GJByMT9urMqiIEm9chWppUUOLdTlW6dlWG3NLPznaNj4DAhwE91AyIU+0Z3P2SlMOyX
	 lt70TTVp+Ht6I8aamWWV5DcMYyztzdgtqLn3066rLEyOuRvxBBnSAj7VH3Tx0rnwLs2eS
	 hheHZMR0hwk2jlltQAZ0PP47ZCoPUYRjvTow/L/SAzEbbQRsi8+ndjYYG215qnSTYxQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792506027;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vaylBL3Dnp5mG/bKi+H0PV5jRa7ZcisYK+9ttvbgT38=;
	b=pKIPsLSrIU9gE9IUJJhsMixek0agWot1HmCnxlLVcDME+Ek+cY1eAM+Hl+sOLD/Frrnx
	 Lop/nBmgkziy9f5pB+/Ol17zH16MgFaC0qwIz/zavvHrOdN9FAoMhuyxgIzI1Xw22h9u9
	 xwzSYA4z4l29+MR20kFy5aGFjnWZlpZEkXVB350hfFH6S38ChG7cH3H2kNPjrjgcYDj4Y
	 P9br8PV1lOWgKqnAs+1jVFE9emNdHX9jvwlHOfpmnOvZsZUiqaX5I3g/EaT3YGQDIngHB
	 7YS3c/l/x+B6sO8ZREA2QgMpQTvSNllsyHIwsG7U80da6Ys0ykMOdrMjHbV8bJutXig==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792506027;
	bh=vaylBL3Dnp5mG/bKi+H0PV5jRa7ZcisYK+9ttvbgT38=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=J+csAoccdDsw0vmVcNrlUyfdouv/IgkBp1isxFFXrLqYz1yUYgO1G1ZkO1mUSiFh+
	 g9jcz8DgH3jWQf8jsJ017hznDmDDMrbaSDa/PGAeLkkyovvAhPkczLdd/+gZbDzImM
	 UKzFRZX1ottDTZ9k8srxJtmNhxNhAoKLXXCE6q/DgVltupS3BmmyWbCujSiAKXnwmW
	 K5J9V7t2D9Zh+7uVgAVruDWFXhMgMW/wzzNLBsm3tbJRt7asbK5FpL2Xj1BUismI2a
	 Vz8G73a0F8Q+QCa/J9HaAWcmiWNOu/SXqBZkSWFQojXl3ibr1rZrzSmAvgERGrykiM
	 /qJipDjP7qZmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 124C18100F;
	Tue, 20 Oct 2026 14:20:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id ABA3C75
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:20:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9B95C6081E
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:20:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DptxtMZP5UTp for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 14:20:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BD3AF607BA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c10d::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792506025;
 b=dk9uo4RVgo43FaIv37K4ZVamiKBKbcSAZEfPnnX99q7Vfz8cQff/n1WyYrIxLcul/3rZ
 McMv+myYaEcAzx0FAUti6e16Dua6NwdH1l8blWvIkHUvm07LvpNJJk71VPpFycnxuZsfw
 FDU4t0XpgxrZLJRnlWjDdOMh9eHC6Negzo+rCVGfaIZ8H5ivbmvYZoF29c8AssSF6B6U6
 GHxtFeWw5NixRyh+fJnUfEDGjIH107LKG3i9TbEdQIqTgc8qFcvArtHSWSSN97KwUmW6S
 URiC2BQERgwUQMsvIO2TAVJTRpr4GoReAZrFFGmNkIt4AtAHk00sbLhAefRXa0vIb4A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792506025;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=vaylBL3Dnp5mG/bKi+H0PV5jRa7ZcisYK+9ttvbgT38=;
 b=rf9ojFKBHlEZLzY1CuWZj7Ynix1BlPbxoky7QtYiJP82PWtoYIv/K+V/gZmNP5kCWlpP
 tCNiMscX6gi/UyWjDnA8z0GrNF4kVgjSy/pkWl9e91yW6QasW6CjBuuQhLR7k5GddQ1LY
 pUIHqdInQVakEfK/kgV2t0CHdfL4j9NZT/YcOo+0vcXvMIZDjAYZhcEAcHl0ZgUx2Smwv
 Y69SJ6yLuZ4ZhajUwN/HfoQ8eTDHPJY7+j/fAnbzvZe94/uoD+a9F3IdG7f4VhqERfLt2
 sNunMV2+3C35WVBRBaukmGnJ8s9FVcoUAvIHiTu45AxdOk4X3h+LKowH2RyCuQ3MMAA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=mMbNtHkf; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c10d::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::1;
 helo=sn4pr2101cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=mMbNtHkf
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BD3AF607BA
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:20:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rJV5kjOI93b8I9SPoZsXcg6cRC9LSFgYwcA5MGtuEYrV5DhR+CcWuxuMEd4Mr+JprOXVh37hr0Lsr8z3RbVmcXChl0GRtGBkOOpOVNrmh2CcwMCLzE6y75nXvpe72fzRrjeQ7PoV5TSRSQBrFaK8Co8+Vq04495liWl5gxXvBCRmLbXntuzuPDuYrScZRsQ2916U5ZaCNvUFJ7ysrSoBu46Ekm1CLd2DDEkh2QSiTt5+I5Soeup7SgBu/gtfK782DgipraN2gbiPTqtYz49qHzZemFY43F4va5lnGqyUqEtfTHKno7ItZ2ERDfV3rMP76bBVg+UxIpjQcg1654MaGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vaylBL3Dnp5mG/bKi+H0PV5jRa7ZcisYK+9ttvbgT38=;
 b=I6blY7NaumGaUXeQiFH52y5myHjmo9u7FkO8Ek+DIVv5mqr4JrrOotJytM2rzF4sqnC0j0ioVmDE72TjNL0fDOxhHzCJmFS2jz+roOIbWlpIx0x6p+EtdOjPo4L5z8jaBvREuv5HqSxXashSCHQ0DvsOjqdjvrKs//AuP+r4EFtbBWiv7TTFqhwk7Yi6F3EXlzeE+v5KlAc4tqLmz9q7zgEXMP/Y8TnQkJfcDPan7kr2xiAOhzsauQWONjPD3nnzxfLa8pWDyqz4t/8dD7S00SV4g4qWA5xRsGnvWxc9wtQm5m9kMHjlKGoPmxvp5pRaWVK95VApka4I8uSufNlivg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaylBL3Dnp5mG/bKi+H0PV5jRa7ZcisYK+9ttvbgT38=;
 b=mMbNtHkf2JYKY5TeteJq0if/DRLC/75TEcAbhIS/kzfoKGW7+XZa2eD4fM6JdCsunLogVFjUJBcHisY6svyTciC+p86IbSdxoNJ0vHm1Fz6F1y5EcLTOOq1YX/rfk+wc0ZhtZghurmX0nGegAoiyOlizlB607m8v519g5OkuOKw=
Received: from CH5PR05CA0009.namprd05.prod.outlook.com (2603:10b6:610:1f0::15)
 by SJ2PR12MB8719.namprd12.prod.outlook.com (2603:10b6:a03:543::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 14:20:17 +0000
Received: from BN2PEPF0000A7FF.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::c) by CH5PR05CA0009.outlook.office365.com
 (2603:10b6:610:1f0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Tue,
 20 Oct 2026 14:20:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A7FF.mail.protection.outlook.com (10.167.245.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 20 Oct 2026 14:20:16 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 09:19:58 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Tue, 20 Oct 2026 09:19:58 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>, "Rob Herring (Arm)"
 <robh@kernel.org>, Shaikh Mohammed Suhan <suhan.sm@amd.com>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH] arm64: zynqmp: Fix DTOVL warning about graphs in kv/kr260
Date: Tue, 20 Oct 2026 16:19:50 +0200
Message-ID: <3445b6285bcae67a16c284c524c0a57aba8c00ff.1792505988.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2638; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=oYFEayuxsqHaeh4ZaqOWZ6jxSOnvFTBK7u+SSmH+FqY=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRdr+iOnf/2icC35OOKk2IFq5wzZ++wzcoUc3/Ukmfg3
 HM19tysjlIWBjEOBlkxRZbpTDoOa75dWyq2PDIfZg4rE8gQBi5OAZiIxWVGhm+T3MW0JN3Cniwp
 33puVqh3AcdzeSnXmuXas0NDuLy7ZjL89zm5tOz87te/1sb9jomVP1W26Km0vr8xT+eyXR1Wn3a
 sZgQA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A7FF:EE_|SJ2PR12MB8719:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c4e5803-d220-4cf4-4f81-08df2eb5434a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|18002099003|10067099003|11063799006|261009223027099003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: 2n/8zmZeIhMW/VM1fq6S6PMmAnYCGvvXvJad+Jj+VH+VQ/2aM6qdrYH4Yl3NJffWPQXWUDwleKqUdILkmlUvc4nawqFg54YOJpQbz56nvDnz1KLfZBc28ZaECWpjJ5DdHwUtjUa2nLwkw2XP6Hv6DNZ2fadruNqEE5EUTO4t/YqtBMw+VZ7Ut1kfGprusv+erm4lEn4siKesRJ/UPIDkFA3WCw4lgc7uj6IE5Htyt/1FmascBr3BG5HyTQXek5xjyGM2Lzprnhk46l/uJUf056VXESLPMCkNAKmoNocar3xybRHioBkvfU2pcerlM+h2hwUlP/bfaa8sGtRHzQfGhDFHc7m3iTh1vFz3Uzg2pWO26DXXUVP6JsxB4Z0iD8n2Uv4m5p8W7373x9VaTVAxbIzDqMK3Ci+Le0R0vAJIHdmn/00+J5YYhDAaVqZdkHQ//8IXoLJVlwyVF1rCGJHoxWqyv+UTHrNNOZg8wbuH/BxrCxD8SOk6078LsnUMZVJM13nxeJEzf13+zUO+aRkc3jk6Jr3MkxRQugZ7jKo49t/VdRBXoPzyIWhiwsnMqw3c7Gd0aKoxEvh9bXzrSFZiebKa5IBaIATYp6GtBJ7+3qkKANLnZXMqJfE1d645dewOCBDIZZleopq8w5VjGvuCJ4iVgMgzX0iWvh2UqEgLOVbdZuqljk8Hhp2iaHD59MMS3b9d/YMUrl5a88enoVR4uQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(18002099003)(10067099003)(11063799006)(261009223027099003)(5023799004)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EEGAKvNPobqiHy/71gfpDpN+u10TsJhIN4IKnrSCVsJbpPoiLgO2JdHyAdUgkqOA3uqiQM2thq22kTOGP79TYNCGbjEqQ5Suhg802pDhZNsRa5mL8J5MscCCSbmUpqddg3mSNeYOKG3Q4OzsxmKhaaNt+n0KAzUb3J+7jLk9dpcq2jOn30Gsu7DJ92ZW+ZFoKazkWen4C04i3FDPNtQxF0HInWedI584V+rRNyQJ071UV8rAdzPEAiI1pxNa7ZLCeP2nH75c4PW647ik6KDgR9UDJTzA2SFNdig/WWEKLZcW3J0rM3WDRqnO6RMHiw7OQ+hMosUS/kiGHp+8ucYDR2Pja/42gkLXkD0KX2LjMbEvNjT2MhMfwwJXhSgraYZ6KbL8buz9fqX2uA4nCvdkYGvTxNsuMhiDUzL8lrZ1w4vzsalnK97gWMDgN8O/q1Bp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 14:20:16.2374 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c4e5803-d220-4cf4-4f81-08df2eb5434a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A7FF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8719
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DTC is generating warnings about missing port like:
DTOVL   arch/arm/dts/zynqmp-smk-k24-revA-sck-kv-g-revB.dtb
 arch/arm/dts/zynqmp-sck-kv-g-revA.dtbo: Warning (graph_port):
 /fragment@5/__overlay__: graph port node name should be 'port'
...

That's why change description and add it directly to dpsub mode to contain
full description with also port.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sck-kr-g-revA.dtso | 4 ++++
 arch/arm/dts/zynqmp-sck-kr-g-revB.dtso | 4 ++++
 arch/arm/dts/zynqmp-sck-kv-g-revA.dtso | 4 ++++
 arch/arm/dts/zynqmp-sck-kv-g-revB.dtso | 4 ++++
 4 files changed, 16 insertions(+)

diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
index 3a47beb9f995..0d1be060d866 100644
--- a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
@@ -176,7 +176,11 @@
 	assigned-clock-rates = <27000000>, <25000000>, <300000000>;
 
 	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
 		out_dp: port@5 {
+			reg = <5>;
 			dpsub_dp_out: endpoint {
 				remote-endpoint = <&dpcon_in>;
 			};
diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
index ddcee42ffbfd..09e1c11692d8 100644
--- a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
+++ b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
@@ -176,7 +176,11 @@
 	assigned-clock-rates = <27000000>, <25000000>, <300000000>;
 
 	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
 		out_dp: port@5 {
+			reg = <5>;
 			dpsub_dp_out: endpoint {
 				remote-endpoint = <&dpcon_in>;
 			};
diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
index fc8d3467198d..7cce0906dfc3 100644
--- a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
+++ b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
@@ -152,7 +152,11 @@
 	assigned-clock-rates = <27000000>, <25000000>, <300000000>;
 
 	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
 		out_dp: port@5 {
+			reg = <5>;
 			dpsub_dp_out: endpoint {
 				remote-endpoint = <&dpcon_in>;
 			};
diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
index 80d1577c92bd..63328b3e224a 100644
--- a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
+++ b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
@@ -137,7 +137,11 @@
 	assigned-clock-rates = <27000000>, <25000000>, <300000000>;
 
 	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
 		out_dp: port@5 {
+			reg = <5>;
 			dpsub_dp_out: endpoint {
 				remote-endpoint = <&dpcon_in>;
 			};
---

-- 
2.43.0

