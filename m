Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 633F2C88E53
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 04:19:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F101680BDD;
	Tue, 15 Sep 2026 04:19:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9XjHDplX6WLt; Tue, 15 Sep 2026 04:19:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 18BC380B9D
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789445955;
	b=es9nYytw65H3xfsKkkzNkgBUjYoopRCXO8b6+LLQX0EViKtXEt1U4x4Ptr7628QTY2Bf
	 VxdKPZgQSE2sFcC1lTSuvM9eQghSk3azXqCSYfwkAfqWHeYS3PARkjXYrtorUFfS9VUXI
	 egWjI5r2uo2pYA1J9Y+bMuBiRCx2C3prv5ZOraaJgK9TWjsdDliaDAphyVBwMNhGcXnH5
	 JpyeMx5Ru5Zo2Tg7U9/KvMN6RbpZK+HKjZ3o8s+aLuVtAUtrkeLiadKSule5dJ9XJ86fm
	 /84I0kngJozsMd4UsDHovqb53urEQXqZmnF5BR9PIbLUGbViGuZS+Tb+QvhZYVIFZcQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789445955;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
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
	bh=i6Zlg8hcJHynxGvSpkBH0ULEGclBYDFe5c/iGr0ne60=;
	b=AzO+U6xrKVvzzIhbw6/NWMLak36g9YJc37ETxwutkiTZNz9ag0ATiEDkg/yNG5KDWiwg
	 n19BlUuGgF2iJRx/yj4UjE7aAnk5yji9Kl5RMGYV5q+Wzh59/PukYx4Ywwm7zN6utb0bd
	 bwe27CoO86D5eGaHq+o2y4jAL1gijePub5w1WAUr9ZDFY93aPrh9bN3jVd8B8XmE8Xd4D
	 kYLvaCeZ5nu+PwUI4mNOwTMTqgszT6ZtJJT/QGN2P5zmp4d14hs5QmIywRWPFN0SqQixv
	 3Io89LkwZFDyWqQOBOvjYGV60kw+xJyueyX5RqBOnvn6m3CItiOqHe1+uw4P/sdxl9Q==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kbx0LmrC;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789445955;
	bh=i6Zlg8hcJHynxGvSpkBH0ULEGclBYDFe5c/iGr0ne60=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=aFp+swyA8ax7BAmSlnxkDNqNKgSZx7wJOeq+OpQBICVgfFsTVfqfbfU+i5JtizHNP
	 w2auQnaiOdhWd42G2vMFVNP5e2gsRrLX5nePOcoOdLyxbnExUDugPNbpGUVup7cgFy
	 0/xn8T/iRL67qthck/NEgxF5LshK4jXHOCX1yq/AixL523zZXVHSXOW9GXa1VMu/dV
	 h0gmLTPLN6kZEGYUAQjT/afgJrbX/STvPmAZaVsFP+GP6dzpvXFKi/aAOsBbk4GJMk
	 czOe74y/ESXJvuvL+OFW+aJPD38lrmLnd/DZ9fEiSnfj3DinwraBeAqKvkCG7C19BD
	 gSq4zvWE/uLjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 18BC380B9D;
	Tue, 15 Sep 2026 04:19:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 407DCEB
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 04:19:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 25E7080B9D
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 04:19:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ss5rGnOxmhVi for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 04:19:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C834F80882
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c101::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789445952;
 b=OkjSZooJpRMVWUGZhF/TiQqqOuFUut/pnIMrTvtNkKhlS5d1TNMSz4MPAd+dtOpU27Vm
 yLq218cER6lzktiDMQ21T1u4JzE7bUtm8PAHXRirI2s7ya2xQq9VOkLDAQwr/eI+400+S
 NAwLClSzc/G1SefpraqvYQWi8etqvC3jEcKLxl7SAUxD6/lcVjXiAPzICeS5M34hAMGRM
 bV2+7o4rLGDaqRqMut7Bilk3YU8yr2WZ3Djz4cC4knpGYcjsRGZ14IF6HqmuKeAW8WHbD
 4O4OKZGHp+YN1BN0IrYbcXPJPFHh80PdBW9cy90a+k3vj/9hO+v+BQfSyO3ZusMUayA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789445952;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=i6Zlg8hcJHynxGvSpkBH0ULEGclBYDFe5c/iGr0ne60=;
 b=dzVRMoV4f9lkDkUk1hA78fIWqog64PMvmfbOcojazpBe6OdHSgQkXmkIB7iXgF+W0SdH
 giRXj/Fh27JPfHpTDCQ3KdeGDjnZ+lMjBA/4Rsl8UJOC6HgaSCd5U6Agb9or2Vne5xl1p
 sOgXz4+ZxzAxfUYWvswIo2NOAk4fDS7z2uaxF1q7arPadydfjfULQx41aYE0vYAfzrDgb
 QUWXiV1tm2U7/l+xtPCdU5usSTSeymO34B1r4+nJiNA+Fdd98/jVcoLMYQwUzbb61Dr3y
 z1SoUkd5HMocnBZ5nLKVGvXFNMNPDfv+pMTiucDPlnXbTvyroOG5rTVH6U+X1KXS1wg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=kbx0LmrC; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c101::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c101::7;
 helo=bl0pr03cu003.outbound.protection.outlook.com;
 envelope-from=pranav.sanwal@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=kbx0LmrC
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C834F80882
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 04:19:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CC5VJQsLtDlbtGqsXAkfTgtjSFl4ehCmLLTovQa2p+O226HrF4JOj8t7SKenWz/m6DP+HUTSdooGZOd1mV1MT/fXhnF582gt0qghXmV0b3AmHDuVGS2sHgqATUsv0tnsVhrBPB00kxMGJZcCJ+FDcGuzuqle2VmKOKKBgoCPFGGq226ScHeJGLEGpNM1895XUWRVLBWDEgRWnKLC3UlOPnHvPaDVZM+VI3oX+sQA3rz0HXLL9/L/dcRDR6OszvHmy1itrZ40dELBispp2mCYt18D1VPpmwFsYyrJFDHRqaPUn53h/7PYRQRPYhonj3YCQSqfrjphFoByl/KjY1SR/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6Zlg8hcJHynxGvSpkBH0ULEGclBYDFe5c/iGr0ne60=;
 b=M2zntrpEM7kmOawdeNx5ULX/IEmug/IZHC0xRlMp+0YSMTyzKZyUvFDTiOVZ6rya8BLHf0+xMcdUn3300deLl3TNUQzc36HqzqyuDkd4bELE26wUB2buSskMECgF8OqUiDtZyyveVdSVwSi0U6tkulbgohV1a1j1BZ9v3gqpodDr0DGNwGtQ23H/YjuEyFEQa6q8JgbrMD2Abkizi3xFMvG8gMxzfT09rT0Qi0CUgCr47mesDptFAd2Bm1rf7+7ha4JJ9gxxjXt/5Qa11c8+MDiuriYf9khIWSw2iXNKsTNil/jxkOhG8jzbzMX8LOBgqUdLx/iUebBE3EAmNb+xKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6Zlg8hcJHynxGvSpkBH0ULEGclBYDFe5c/iGr0ne60=;
 b=kbx0LmrC+7cJiuPe0PeqKaaNnhPjt0aEvIBZnp/7yhSscjBi4G6rsCGc/47lL1eP2ftCCF3upk4l2OjCxT61K43RGOOmlqSfkdOsaNB4LbupbJIeinLZz+R0/XxeaNSTl6RDAQsSMnJ46PPhbNkS5oIvLGh00vSDj2WFxgzJi0Q=
Received: from SJ0PR05CA0165.namprd05.prod.outlook.com (2603:10b6:a03:339::20)
 by MW6PR12MB9000.namprd12.prod.outlook.com (2603:10b6:303:24b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Tue, 15 Sep
 2026 04:19:05 +0000
Received: from SJ5PEPF000001F7.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::2d) by SJ0PR05CA0165.outlook.office365.com
 (2603:10b6:a03:339::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Tue,
 15 Sep 2026 04:19:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F7.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 04:19:04 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 23:19:03 -0500
Received: from xhdamitn41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Mon, 14 Sep 2026 23:19:02 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.u-boot-project.org>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH] xilinx: zynqmp: Remove fastboot support from SC defconfig
Date: Tue, 15 Sep 2026 09:48:55 +0530
Message-ID: <20260915041855.1957186-1-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F7:EE_|MW6PR12MB9000:EE_
X-MS-Office365-Filtering-Correlation-Id: d7fe50d4-1fca-4fc8-a168-08df12e07aa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: hpQfrbOXxHDdLciKUrkf1FBwW8hGHaNWhODHAjMgsaH5nGDyEZyhF1qVcHalnPOKnQGjzariElY9EttlfgeJw50HxZvZOOxW99ZF059N9A+KGQeYeRQhUSXQnsICnvhvAgv0HEG3UH3WLPB1FtI7xQA/C7eeBU2sC2OEFMrKRtcV8HltGhhdp6+J3pdbj70iI5xcYz1ogD7nw0XQhS9MBC+qaB8fM4X3H1++cZX/nzZce5iw+J/N/l4Crxjedmv6d1KnS2ztswiE3bYHF4aN3wf5VFPA47D1Bla2AkZb/zmCoYEl0oQ/eIF0I+S9iHOXKzeqYrX/K3JflXRxdAvi8g+XnyiuyJRRUjW3ObWmw3nbljolE7EIDEWwXMpi3KXJIAja11z4qIk8xh5Vva2c+brnb8Fi/gWJDn07iasU4O9dQZvLLhyBcf0tIZiISYhd0PiVcyYn7DH7MjJXqmB0flzX5SsiE1GV5juLyACFET3KwP00MY34WPOFiyMyIdy2UCsGSKcY6kwL0hC8pVnA5kq7MaYmr827/e8AsDl0LZICIhLAyiGx54vRcAwaVKa3/eSdE/dRuBXLHhXmyT767A4UXnJ6Of2TYNSEWFcvpjvbUSCYNqYn6bGwYQJVXJ0MX7bk1novPx08eQE1gmG6MQhuQnWLqQbiQLf565kEwakcToIzkFojuc98OG0QLQxKLliZ+ttO3wPKqj+rmKhM2A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fhbi4l07ltC1t9mXUX22KVzocr+u/CQPvRKe+OV+8FgbiWPaGgq73/Eq3oYrDZGikz3JL2Rnn76o2UyYnKjiCoDae57bw5LM/yUHRIZlY5nKQjoEW+MBreQoLs+gAdqi44v2+5q/hnWAyaWqZOaE8VrxNL5yp3rGbFs25NI9XMfSYQo7lRtjqRN7lT3u95jGJYOS7fVsufSPNJiUNUJZITLy8ZwJtes4ph3Mpat81rNIOei1nYcrfU9EQim4IDgaIcCaJ5laALTmlRoOpc7N1A3S3YExAAQT1atAcwsgs1WcKShea+U6bIkXEmeKQ4Qo832lxPuJ5syKy1sndxxf4lJFCHFcP6Gde7Qu8wogh5bbzGnz9mVr6vXMwzWK7wi3kf7gX8TQxDgDvpqsBO4Qgr0NBGY32RFvVUmHVTZfe1BxeUKYbHGUq65dVCHJbiBL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 04:19:04.8437 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7fe50d4-1fca-4fc8-a168-08df12e07aa5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9000
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

Fastboot is not used on the SC platform, drop it. Remove the
USB fastboot function along with its MMC flash target and OEM
format command support.

Fastboot was the only user of CONFIG_USB_GADGET_DOWNLOAD on this
platform, so USB mass storage (CONFIG_CMD_USB_MASS_STORAGE) can no
longer be enabled either. Drop it too since it is unused on SC.

Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
Message-ID: <20260912100752.743411-1-pranav.sanwal@amd.com>
---
 configs/xilinx_zynqmp_sc_defconfig | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/configs/xilinx_zynqmp_sc_defconfig b/configs/xilinx_zynqmp_sc_defconfig
index 0a05cbb3f76..554cc8808d1 100644
--- a/configs/xilinx_zynqmp_sc_defconfig
+++ b/configs/xilinx_zynqmp_sc_defconfig
@@ -77,7 +77,6 @@ CONFIG_CMD_SDRAM=y
 CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
-CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_BOOTP_MAY_FAIL=y
 CONFIG_BOOTP_BOOTFILESIZE=y
 CONFIG_CMD_TFTPPUT=y
@@ -123,10 +122,6 @@ CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x1800000
 CONFIG_DMA=y
-CONFIG_USB_FUNCTION_FASTBOOT=y
-CONFIG_FASTBOOT_FLASH=y
-CONFIG_FASTBOOT_FLASH_MMC_DEV=0
-CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
 CONFIG_FPGA_XILINX=y
 CONFIG_FPGA_ZYNQMPPL=y
 CONFIG_GPIO_HOG=y
-- 
2.43.7

