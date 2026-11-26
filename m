Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730F5606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 09:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Jt5lpN7b;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=DGm9ClMY
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D041940884;
	Thu, 26 Nov 2026 09:58:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vNvMRqyd7u-r; Thu, 26 Nov 2026 09:58:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9C0C840869
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795687091;
	b=djvOT91oFh/wVdGhTSPJnUfKpCI8+TJq+qitxX/4e9Ykw8Qfv10MzfEKhtomzTIp99GW
	 QqYiBKO9gR1Z2ix34uSGlBQZn8SUcObW5onj9wHCFPxvv3IwQcS6OlI8xmZrMm9BYGdUV
	 ddObLNg4ZwfxL5RBumy51qBHrOa3PRux0gqNrLd+xb9/K7X213Ik/FkaCFJtc+SK24kWo
	 Yzp1L+sITmzDBG5EE84PF0+AOCPMO6lfm5VL4cMRbGUzHq+sOihAcJu8Cn60fMDi1EsrG
	 jQIlsPf5TMzQGHV51DIcJFYPBTG+h8dIERkS7IM2Qp2Q/SqQcJ/YL0/0AtOcogcboLQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795687091;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
	 X-B4-Tracking:X-Change-ID:To:CC:X-Mailer:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zQ4yY1Fje+gQkF70VehOdxSCVprDtlAVFmWo3AzYXD8=;
	b=OgMtbR6MqU8mOLveVbB6NeJUsNOvVAHtsnOSuMf9Pk2NzqS9Kd4OKp7jGTDhrvxkLOO3
	 JhHWH8xOV2Akm4UEDFBEZ2kx6ZijjRMhVVRHGxxErIM5NlS/HYqst3+EmCkFKRRJ97F71
	 99vXfKseMfnv6Dwuxz006MMfo4CATrFb1v2u3icDEgkF63wiyUn/hsvHvJMNHHB4CaWeW
	 5JKpLndl3+Wmq7QJFtPWEaUKP+VbbvU5+NErGvuwCG4J8sCeWSRGHYO0sBgk5uJkU4HUG
	 Xycu4aTVHsp2Ay91VLl/6rJNgJynNCeath+Qx3XI2Wtr1xMMsWf2VjNwI6D2HvxS6Lw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795687091;
	bh=zQ4yY1Fje+gQkF70VehOdxSCVprDtlAVFmWo3AzYXD8=;
	h=From:Date:Subject:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Jt5lpN7bPimCc7dCa0tA6gTg/IhE/wXHrIomd4skMh8ng4ENZ9JOMv3YkI4oWuNat
	 2tH1QHP8rBF2Hug2eNdBvL+xDsXkxXLJdu3khPkKDFZ7OYNDiTfLhKqjWNtDHIn8E1
	 YEujImLwpYI71pq8NOOFflUW/dXUewVJReLRNfI047xFq7MTgCWISPeHDiMFt/0J65
	 LnMZJlFMRW9QVXBLQqPCaEBG/JxfVsp32WrKPN50tNQN4C7onSbFGeBRBi9uarPTqJ
	 1MGdYeC3iK0z8XPFPj4yfyDY7zGSL5cAEnAiLC5Jr3DSg3BX7eXsMZeQ68SKPYoqq+
	 XF1j6Xz+63L1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9C0C840869;
	Thu, 26 Nov 2026 09:58:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 18953260
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 09:58:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F2AE260799
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 09:58:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mnGcj1vUy3WC for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 09:58:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 490B36062B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=DGm9ClMY
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 490B36062B
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 09:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQ4yY1Fje+gQkF70VehOdxSCVprDtlAVFmWo3AzYXD8=;
 b=DGm9ClMYM8ib27Yc1DA7xtIJB5o3Agwbu8kKCX438Ir+2lfgFmgMZwjWkf+s7guzWnP5TrFnlWv1A49G/CeSU6wc8igNHwipmvnW9UuepeYcNy5KZ2P7Rm2AY8CebFmVUkji/Hb3EGg/7XG42JUXVI6B7jkJelNAt3fvKBdpqxG7l+qdQjQAJ0kQsjeEkxcy6V2F1qm2Q9juIyCVxFmUpXGVSKYABuk49JKDO56lIKm/4U3xVB9SZ5Oyx4n2oJFIKmkmbv1OebotGUNX22yM3KnZWKQkDU7ijLW2SQN66qqLQ/lp5+VjrTegueeydZBa0r/tJicxxhHZba8NXq3JVg==
Received: from PAZP264CA0053.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fc::18)
 by GV4PR10MB406241.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:40a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.688.4; Thu, 26 Nov
 2026 09:57:56 +0000
Received: from MI3PEPF00008485.eurprd02.prod.outlook.com
 (2603:10a6:102:1fc:cafe::94) by PAZP264CA0053.outlook.office365.com
 (2603:10a6:102:1fc::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 09:57:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MI3PEPF00008485.mail.protection.outlook.com (10.167.240.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Thu, 26 Nov 2026 09:57:55 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 26 Nov
 2026 10:59:01 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 26 Nov
 2026 10:57:54 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Thu, 26 Nov 2026 10:57:49 +0100
Subject: [PATCH v3] tools: fwumdata: fix redundant metadata buffer overlap
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261126-fix_tools_fwumdata-v3-1-e321d2a62390@foss.st.com>
X-B4-Tracking: v=1; b=H4sIAJwCCGsC/32O0QqCMBSGX0V23cSjZrOr3iNCdJ7lIl145irEd
 28zCILo8oPvfP+ZGeGokdg+mtmITpM2g4dsEzHZ1cMZuW49szRJi0SA4Eo/KmvMlSp1n/q2tjW
 XDSpISqHUDpk/vI3orTV6PL2ZpuaC0oZSMDpN1ozPddVB8P4OOODABRS1bPIkl5AdlCGKycbS9
 CxMuPQTAYDyZyT1EYmFLLcq99+K78iyLC/f1N1yDQEAAA==
X-Change-ID: 20260818-fix_tools_fwumdata-cbef1098ff7e
To: <u-boot@lists.u-boot-project.org>
CC: Sughosh Ganu <sughosh.ganu@arm.com>, Kory Maincent
 <kory.maincent@bootlin.com>, Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF00008485:EE_|GV4PR10MB406241:EE_
X-MS-Office365-Filtering-Correlation-Id: fa5f51d2-8a26-4f4d-9da9-08df4ba3be68
X-LD-Processed: 75e027c9-20d5-47d5-b82f-77d7cd041e8f,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|6133799003|261009223027099003|18002099003|13003099007|10067099003|11063799006|56012099006|261102123227099003|261028144727099003|261022115727099003|261026140227099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: zaJdjiERMYte/IwkhH6CnvUMcaYLha7pS/NG3a5004nwU4vpuXRRWP77BXVgO5nFOWaBVLiSjUAjgqpBj9ufgGPPypZyd1lLbxys1czzV95W1YG1lUvpuJfaeTxWtdAoFvURlxEBwqwpobdzQ6wi5qHOwzeF90iWFmWs7w/rBinRGDcjfOVb0gDlP7gQ9jg+lBaOPW2pP7ZDzFvsusa4ShWcPYRTgmYWo1AYGWtrsx4Dp9j691QiPWHoKIeUm7DvbV6uNwQMa5Gme7FT7LKkdcAy/VAMnSXGPGg/cYPFPdeA0jB/QnU7ZHR2uhVi88p8v0s/YDZWSaujzMRoLmcPqMb6xzH5ga8cLd8a4Ba7roecLRPlKaTmMKO/PCogXVhDT0x2DAtCs0NW0kPr63VL0cl0e3BjqYQ76vc8PNxH/gpcVsP3vaIpqWqMwc2gHnJB9fgO4vog+A7uYaAVz2J7CMp7xPJMFZFpKYuxucxLowW+JERqD5scu3LQdI3BKss3er/Ff6ZNieR8aAP5rbbtlONguX43533S/u6hhlzuwFZKqvyuJ0srcxLKn7bWs3kCUcp/2dARzR5YdCPmDSfyvVYLcr54YzdZA5joxhnzpUtD92PBzC4wa2ZwqzYT6de1rekc1KU2n/emAJvPSCN6Vg==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(6133799003)(261009223027099003)(18002099003)(13003099007)(10067099003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261022115727099003)(261026140227099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RUIe+7eilppBVIHVT/BfKJtSGFlvNng5v1iSzhv8QKnObJcbqG8/1RQ1PyN2r3uEECo0KzaCc8mhgdGZRwZ8FZRVupBTHDVzUZ1AIoLnq0zC76dmcqZBjwseK7tIMIoYc2Q+kymlfieu/RlYyxft9WyZqP8xZrnyt4nGWmF016FJVkyHqfxRubeOzWEPduwSzp510TaZBBasQAjgoZGWp0RXag1aiF38sW9FFV3TWadc0WYnzs8qYV2NrLfz0cyYuqtvXv7xt0MLm6V7EWSFr2PkQNOmJDyBjIhF1v036I2Pn+tLPcNSzcSizuwydI8WVeiDkYbdmoZa3/1vMyuLgYSAAEnpIn+nHCFdhpS/9ErTQVgUxvwmlUAHDeDhHAMTHdub0NhI9xos9x/2LNsv/LCXsG/h2r1qnthxpV9LJbar4A97p+MaQKY7fblKMnM7
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 09:57:55.5699 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa5f51d2-8a26-4f4d-9da9-08df4ba3be68
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008485.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR10MB406241
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

read_metadata() allocates a single buffer holding both metadata copies
(calloc(2, mdata_size)) but accesses each copy through &mdata[id], where
mdata is a "struct fwu_mdata *". That stride is sizeof(struct fwu_mdata),
i.e. the 16-byte common header only, not mdata_size, so reading the
second copy overwrites the body of the first and the two copies overlap.

When both copies are identical the overlap is harmless, but as soon as
they differ (e.g. after an interrupted update, the exact case the tool is
meant to recover) the primary is corrupted: for V2 the metadata_size
check then reads garbage and the tool aborts with a bogus size mismatch,
for V1 it silently operates on a mixed view and can write it back to both
copies.

Index the copies by byte offset (mdata_size) through a small mdata_copy()
helper instead of struct-typed pointer arithmetic. Both copies are
guaranteed to share the same size (checked in parse_config()).

Fixes: 02673659e813 ("tools: Add support for fwumdata tool")

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v3:
- Add Fixes tag
- Rename mdata_copy() to mdata_get_copy()
- Link to v2: https://patch.msgid.link/20261119-fix_tools_fwumdata-v2-1-ce6c95f40988@foss.st.com

Changes in v2:
- Rebase on v2027.01-rc2.
- Remove Assisted-by: Claude:claude-opus-4.8.
- Gather reviewed-by.
- Link to v1: https://patch.msgid.link/20260818-fix_tools_fwumdata-v1-1-816acb404c13@foss.st.com

To: u-boot@lists.u-boot-project.org
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Sughosh Ganu <sughosh.ganu@arm.com>
Cc: Kory Maincent <kory.maincent@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
---
Way to reproduce/check the issue is fixed :

cd /tmp
cat > gen_mdata.py <<'PY'
import struct, zlib
def build(active, prev, bank_state, img_guid_byte):
    version=2; num_banks=2; num_images=1
    sz_mdata=16; sz_ext=16; sz_desc=8; sz_img_entry=32; sz_bank_info=24
    per_image=sz_img_entry+sz_bank_info*num_banks
    total=sz_mdata+sz_ext+sz_desc+per_image*num_images
    ext=struct.pack('<IHH4BI', total, sz_mdata+sz_ext, 0, *bank_state, 0)
    img_entry_size=sz_img_entry+sz_bank_info*num_banks
    desc=struct.pack('<BBHHH', num_banks, 0, num_images, img_entry_size, sz_bank_info)
    body=bytes([0x11]*16)+bytes([0x22]*16)
    for b in range(num_banks):
        body+=bytes([img_guid_byte+b]*16)+struct.pack('<II',1,0)
    payload=struct.pack('<I',version)+struct.pack('<II',active,prev)+ext+desc+body
    crc=zlib.crc32(payload)&0xffffffff
    return struct.pack('<I',crc)+payload
open('mdA.bin','wb').write(build(0,1,[0xFC,0xFE,0,0],0x30))  # active=0
open('mdB.bin','wb').write(build(1,0,[0xFE,0xFF,0,0],0x50))  # active=1
PY
python3 gen_mdata.py; cp mdA.bin mdA2.bin
printf '/tmp/mdA.bin 0x0 0x78 0x78\n/tmp/mdB.bin 0x0 0x78 0x78\n' > cfg_diff.config
printf '/tmp/mdA.bin 0x0 0x78 0x78\n/tmp/mdA2.bin 0x0 0x78 0x78\n' > cfg_same.config
printf '/tmp/mdA.bin 0x0 0x78 0x78\n' > cfg_single.config

echo "===== FIXED: differing redundant copies (previously: 'Cannot read metadata', rc=234) ====="
/tmp/fwumdata_fixed -c cfg_diff.config 2>&1 | head -8; echo "rc=${PIPESTATUS[0]:-$?}"
echo; echo "===== FIXED: identical redundant copies (regression check) ====="
/tmp/fwumdata_fixed -c cfg_same.config 2>&1 | head -6; echo "rc=$?"
echo; echo "===== FIXED: single copy (regression check) ====="
/tmp/fwumdata_fixed -c cfg_single.config 2>&1 | head -6; echo "rc=$?"
rm -f /tmp/gen_mdata.py /tmp/md*.bin /tmp/cfg_*.config /tmp/fwumdata_fixed

    ===== FIXED: differing redundant copies (previously: 'Cannot read metadata', rc=234) =====
    Metadatas valid but not equal, use first one as default
    FWU Metadata:
            Version:            2
            Active Index:       0
            Previous Index:     1
            CRC32:              0x38e2fed9
            Metadata Size:      120 bytes
            Descriptor Offset:  32
    rc=0

    ===== FIXED: identical redundant copies (regression check) =====
    FWU Metadata:
            Version:            2
            Active Index:       0
            Previous Index:     1
            CRC32:              0x38e2fed9
            Metadata Size:      120 bytes
    rc=0

    ===== FIXED: single copy (regression check) =====
    FWU Metadata:
            Version:            2
            Active Index:       0
            Previous Index:     1
            CRC32:              0x38e2fed9
            Metadata Size:      120 bytes
    rc=0
---
 tools/fwumdata_src/fwumdata.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/tools/fwumdata_src/fwumdata.c b/tools/fwumdata_src/fwumdata.c
index 44195ce2bf2..08eff1bb1b7 100644
--- a/tools/fwumdata_src/fwumdata.c
+++ b/tools/fwumdata_src/fwumdata.c
@@ -246,21 +246,35 @@ static void update_crc(struct fwu_mdata *mdata, size_t size)
 	mdata->crc32 = crc32(0, (const u8 *)&mdata->version, size - sizeof(u32));
 }
 
+/*
+ * Return a pointer to metadata copy @id inside the contiguous buffer.
+ * Copies are laid out mdata_size bytes apart, which is not the same as
+ * sizeof(struct fwu_mdata): the latter only covers the common header, so
+ * indexing mdata as an array of struct fwu_mdata would make the copies
+ * overlap. Both copies are guaranteed to share the same size (checked in
+ * parse_config()).
+ */
+static struct fwu_mdata *mdata_get_copy(int id)
+{
+	return (struct fwu_mdata *)((u8 *)mdata + id * devices[0].mdata_size);
+}
+
 static int read_one_metadata(int mdata_id, size_t size)
 {
+	struct fwu_mdata *md = mdata_get_copy(mdata_id);
 	int ret;
 
 	ret = open_device(&devices[mdata_id]);
 	if (ret)
 		return ret;
 
-	ret = read_device(&devices[mdata_id], &mdata[mdata_id], size);
+	ret = read_device(&devices[mdata_id], md, size);
 	if (ret)
 		return ret;
 
-	if (mdata[mdata_id].version != 1 && mdata[mdata_id].version != 2) {
+	if (md->version != 1 && md->version != 2) {
 		fprintf(stderr, "Invalid metadata %d version: %u\n",
-			mdata_id, mdata[mdata_id].version);
+			mdata_id, md->version);
 	}
 
 	return 0;
@@ -283,12 +297,12 @@ static int read_metadata(bool update)
 	if (ret)
 		return ret;
 
-	if (validate_crc(&mdata[0], alloc_size) < 0) {
+	if (validate_crc(mdata_get_copy(0), alloc_size) < 0) {
 		fprintf(stderr,
 			"Warning: Primary metadata CRC validation failed\n");
 		mdata_mod = update;
 	} else {
-		valid_mdata = &mdata[0];
+		valid_mdata = mdata_get_copy(0);
 	}
 
 	if (have_redundant) {
@@ -296,16 +310,17 @@ static int read_metadata(bool update)
 		if (ret)
 			return ret;
 
-		if (validate_crc(&mdata[1], alloc_size) < 0) {
+		if (validate_crc(mdata_get_copy(1), alloc_size) < 0) {
 			fprintf(stderr,
 				"Warning: Secondary metadata CRC validation failed\n");
 			mdata_mod = update;
-		} else if (valid_mdata && mdata[0].crc32 != mdata[1].crc32) {
+		} else if (valid_mdata &&
+			   mdata_get_copy(0)->crc32 != mdata_get_copy(1)->crc32) {
 			fprintf(stderr,
 				"Metadatas valid but not equal, use first one as default\n");
 			mdata_mod = update;
 		} else {
-			valid_mdata = &mdata[1];
+			valid_mdata = mdata_get_copy(1);
 		}
 	}
 
@@ -313,7 +328,7 @@ static int read_metadata(bool update)
 		fprintf(stderr,
 			"No metadata valid, use first one as default\n");
 		mdata_mod = update;
-		valid_mdata = &mdata[0];
+		valid_mdata = mdata_get_copy(0);
 	}
 
 	if (valid_mdata->version == 2) {

---
base-commit: ecdcf9e365df6249a57cd8cc946e7026804ff4ae
change-id: 20260818-fix_tools_fwumdata-cbef1098ff7e

Best regards,
--  
Patrice Chotard <patrice.chotard@foss.st.com>

