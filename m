Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F074606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 14:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ba1G5LD2;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=TVK389sb
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 311E440737;
	Thu, 19 Nov 2026 14:34:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gqOJlEdY_hMk; Thu, 19 Nov 2026 14:34:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 03805405BD
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795098876;
	b=D9SYjaW9OX+53pUyDUzeMLS+bPXrrWPTZv66ZP54PkKGtWghhcHkWRQJ1nsuhohYPeQH
	 Cbx5SLSqCA91T++iwMF2ihjJM9VBKiEX3/n3sR4TSJuEWBzMn5ajdc8BZqm961HWzTXYQ
	 1sQneMAC7XHtvrMJf49Pl4ikbmdBDZ5MufWXg4a9U1ar/r4j1L5ax4gGLeC6fo/F7JrWJ
	 FKcGyi5YAGZbqF/BXE2f5a7OLZ54tBjUmN6f9xLv4hR4E3xZcJ+14Es3N7A54ajNBXxKU
	 iH9rjHdjL9czM+4pVBqaDvwlQa2qbM6otaRdoLTktd5srmvOCsY9p9b4ghKFLheSoPQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795098876;
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
	bh=y6u9mzDH2RFl/owT/Pn6XWhGfT1MjCUdwoDnjTFAtmA=;
	b=h6mNzZcy494yMFptOrVjScTHqmEnN7IhkMwD33rH28HUdu03aW6cdeAqCl9SREBGUn2K
	 dPzz3OjJYyZ6ieImEibHLGz5xUbsUhrLuKWCo/1BiOGBr9PxMUi839mJBlnIR/+QF5pF0
	 qBvsO2VAOv0zRfSKiqQnVIX0Ta60tmjwhTxeGFzZXhPS6wMbu3buMYPM6bgdT8aHF6Giq
	 flhO98NzlEcSqhIhjHz59d4MmoWA/YA2KTjoY4qCS/kdZbtn2i3C6bl2IzTX7buy8Gvqv
	 cMopYYnJdFx4XXEdzXnS3NWuwIFcNnRg0vGoNYxzE5XbZPlc0rDoof0ef51KLh85ziQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=TVK389sb;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795098876;
	bh=y6u9mzDH2RFl/owT/Pn6XWhGfT1MjCUdwoDnjTFAtmA=;
	h=From:Date:Subject:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ba1G5LD2Z+E9mNVLOo0VblWcKKDJtcXVzLXjWsyw4wgvIxuIesZ2n/bbI7//w+70S
	 O6wewQlUZfTE8AtRWxQ0rrxEm3ORu+O8kiwQXWNrX76F8rAPdhq9YtpKFNDpdrMNw9
	 4ldWrYUP/LMjzEZv0I1TThd+0a503JgsOqB1iW/slFv7oA4O4lRaNLaoT6ar8DrU8N
	 asTqx6byh9FinECDIQeOQdU5GvKA6it3F57Np48mJcTVxdIzvyRhedFSqoivbFi5WX
	 24kmseE/okiD2ykKIhKxFaaC/bJnDxpeyG85dpbJdrrK9EKG8MEnI907UaD7ZOYjE+
	 feZNCUR7BfGRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 03805405BD;
	Thu, 19 Nov 2026 14:34:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 016E82FB
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 14:34:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E7490405BD
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 14:34:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 88cF0FAgV33y for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 14:34:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 989B6405B3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=TVK389sb
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 989B6405B3
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 14:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6u9mzDH2RFl/owT/Pn6XWhGfT1MjCUdwoDnjTFAtmA=;
 b=TVK389sbAYfx/Pp8F9uqgJRf4yg/V5SiT6Z22k57JhjRoDb7f0MVZsnvzhM+jOK1i3cX2Q50hw6NLCH/OyyKq8Qhw1WJqoZvoEONOj1dkSPBdBRGA2D9eC00d4ViK4OvKiPmlg1mgba1tK/28QLKrCjgrg+EamwQBGkkenADGyxZSwpS4reou9R5TMNFhb95i4xJZtSwuWUC/NrTxG/5f5fErEfgOIovMpH8qn9g0Q2GMs3r3z5PpuwnWRlQkpatg+9EB3KUQ3zr0hKmhCp5C/tNs5CCRIr6mEOADDFjukG/AZUxnirMJsKnYlgfCMOXo/jIPE2y+7OT6hp6wuPw9A==
Received: from CPAP307CA0007.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380:3::12) by
 DU0PR10MB5776.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:323::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.1; Thu, 19 Nov 2026 14:34:27 +0000
Received: from CPH1EPF00000528.eurprd05.prod.outlook.com
 (2603:10a6:380:3:cafe::75) by CPAP307CA0007.outlook.office365.com
 (2603:10a6:380:3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Thu,
 19 Nov 2026 14:34:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 CPH1EPF00000528.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 14:34:27 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 19 Nov
 2026 15:35:29 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 19 Nov
 2026 15:34:26 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Thu, 19 Nov 2026 15:34:25 +0100
Subject: [PATCH v2] tools: fwumdata: fix redundant metadata buffer overlap
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261119-fix_tools_fwumdata-v2-1-ce6c95f40988@foss.st.com>
X-B4-Tracking: v=1; b=H4sIAPAI/2oC/32NQQ6CMBBFr2JmbUkHCVZX3sMQUspUaoSaTkEN4
 e4W3Lt8yfvvz8AUHDGcdzMEmhw7PyTI9zswnR5uJFybGHKZl1KhEta96+j9g2v7GvtWRy1MQxb
 lSVl7JEjDZ6BkbdFr9WMemzuZuJZWo3McffhsrxOu3t+DCQUKhaU2TSELg4eL9cwZx8z4HqplW
 b4xhHNKyAAAAA==
X-Change-ID: 20260818-fix_tools_fwumdata-cbef1098ff7e
To: <u-boot@lists.u-boot-project.org>
CC: Sughosh Ganu <sughosh.ganu@arm.com>, Kory Maincent
 <kory.maincent@bootlin.com>, Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CPH1EPF00000528:EE_|DU0PR10MB5776:EE_
X-MS-Office365-Filtering-Correlation-Id: de520efc-37b8-47bf-017b-08df464a3705
X-LD-Processed: 75e027c9-20d5-47d5-b82f-77d7cd041e8f,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|18002099003|6133799003|261009223027099003|56012099006|11063799006|261102123227099003|261028144727099003|261026140227099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261022115727099003|10067099003;
X-Microsoft-Antispam-Message-Info: QVj8MZgOEgO0tFngPopxGN9vMNZh0fhysZmn/Bvajlc3LIouRC9FBA4hpEX0/8FqBcIXEacNrhUY0ft3MC8ivV/p3ww7/F2FNnGp+yr1w8HdqG2fWGwhmMFOiLGYTjugTs/fY1HAVFndxy/AOGyQFAD5hx9zvI1xh7YT87fgXF7jTiVPuWKtmejke9XtrNIHQpzrqaWsxHZbweKueXOmBtt3+A/ANUWOp+CK9eZu8KI3JRfTwTVAbPzgstQygrMzDax6LF+1H5I/6IbaECgk6s73DqChwlJWyt4q8UZYJbRSmAt0GIUqpoIESdksdl9IpJ1fJBB8ksipd/++XqKTOl6Qo4QouQOspYyNx6spAgwb91Do++n5BnQRWfK4WJKduMdfoLzhFxpOOnCdOdFmRhQujy302j3m/SOShCltBcRs1vcmIATdsN+sunqcmQn1C57ZP3cwnfmrb8N8XXTJvSSe8g97yGWzfZcHTwj8runpgCy1CwHEpETs6rVdYW/PE65t1HHr73rgnHPyvEGP1TYOpRhXjS7QrHe6ZNyYkMhlg7rC5EB0Iu+2bInzRcnSd9UcYWEm5vcQfQHyfUAWAXMLg1GrAXKD/8KrmW5nPW9ZZJrhdLjr685V6WwMxmjLGf4e968fF6x6KNSZItV0pA==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(18002099003)(6133799003)(261009223027099003)(56012099006)(11063799006)(261102123227099003)(261028144727099003)(261026140227099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261022115727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kOamYLWpGlOHa498D2EarDlXS3pv9z/15/Fb9E1gYaINFykLjgoHdlMNUZL7aPiLG4KHf0vfmOAk8yAe1L/aFAqYHePyCgsEjBx/kWcpzmcXAApVqX26AMIDgBfF3jygA1GV1llY8fBWJNlNs7NVUt81xLKI5HJSX614mFZ0ettJqxjplyBbcs8e/Sc6iynUImzLcZ+9ulNpBkg+lCJtY32IDGJ9etW9nZtzmiMTGUUwIHosp4bTOGKAMtaz76p/DxFGcJWGxAhM9oBTgymOj6Tmvwk3lhF6X9MvBfrzxD3+tfwttdaXmEXSgiPnPVJUXeltxibMrd3ig1htDo+ZzV6oVkCNXfr9HewCIhkp40HLofPkZKHy3qpDfF6tvoOemKCPnp2QSG0O0Onu6FnW//WmmfyYzBygEngaQ54c9wBfmx88SyPrmynmsMWWbiPI
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 14:34:27.3595 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de520efc-37b8-47bf-017b-08df464a3705
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: CPH1EPF00000528.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5776
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

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
Changes in v2:
- Rebase on v2027.01-rc2.
- Remove Assisted-by: Claude:claude-opus-4.8.
- Gather reviewed-by.
- Link to v1: https://patch.msgid.link/20260818-fix_tools_fwumdata-v1-1-816acb404c13@foss.st.com

To: u-boot@lists.u-boot-project.org
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
index 44195ce2bf2..f54a3b78d08 100644
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
+static struct fwu_mdata *mdata_copy(int id)
+{
+	return (struct fwu_mdata *)((u8 *)mdata + id * devices[0].mdata_size);
+}
+
 static int read_one_metadata(int mdata_id, size_t size)
 {
+	struct fwu_mdata *md = mdata_copy(mdata_id);
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
+	if (validate_crc(mdata_copy(0), alloc_size) < 0) {
 		fprintf(stderr,
 			"Warning: Primary metadata CRC validation failed\n");
 		mdata_mod = update;
 	} else {
-		valid_mdata = &mdata[0];
+		valid_mdata = mdata_copy(0);
 	}
 
 	if (have_redundant) {
@@ -296,16 +310,17 @@ static int read_metadata(bool update)
 		if (ret)
 			return ret;
 
-		if (validate_crc(&mdata[1], alloc_size) < 0) {
+		if (validate_crc(mdata_copy(1), alloc_size) < 0) {
 			fprintf(stderr,
 				"Warning: Secondary metadata CRC validation failed\n");
 			mdata_mod = update;
-		} else if (valid_mdata && mdata[0].crc32 != mdata[1].crc32) {
+		} else if (valid_mdata &&
+			   mdata_copy(0)->crc32 != mdata_copy(1)->crc32) {
 			fprintf(stderr,
 				"Metadatas valid but not equal, use first one as default\n");
 			mdata_mod = update;
 		} else {
-			valid_mdata = &mdata[1];
+			valid_mdata = mdata_copy(1);
 		}
 	}
 
@@ -313,7 +328,7 @@ static int read_metadata(bool update)
 		fprintf(stderr,
 			"No metadata valid, use first one as default\n");
 		mdata_mod = update;
-		valid_mdata = &mdata[0];
+		valid_mdata = mdata_copy(0);
 	}
 
 	if (valid_mdata->version == 2) {

---
base-commit: ecdcf9e365df6249a57cd8cc946e7026804ff4ae
change-id: 20260818-fix_tools_fwumdata-cbef1098ff7e

Best regards,
--  
Patrice Chotard <patrice.chotard@foss.st.com>

