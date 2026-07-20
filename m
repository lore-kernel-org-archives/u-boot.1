Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9277DC4451B
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 08:01:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF61A82991;
	Mon, 20 Jul 2026 10:01:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BzL6UASv";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SHHjpqbk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52401841F2; Mon, 20 Jul 2026 10:01:40 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8761680517
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 10:01:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66K6UChl1428096; Mon, 20 Jul 2026 03:01:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=mazCl0S8hxEYqpth5g/MlQPdlT13qETOiFKDiHEbJ
 so=; b=BzL6UASvrdwrOBtnfYxYmPVXz/qjJIhYomAQzJoVFkyKtJKz/cpteCvNt
 z6cjseFklzPET8xR1sZRvLI6llelrCbAfPIyWihCNfPSa/8BtWDNcirJrXu+qqmd
 tkZRzWbvPol0TzwNbO9czjxn4QDfspu7KyKm7rsDchNH18Hnrqo7jrjJbjbeGpxk
 MtAMzdVozIgsovyCO1vNT8oacPfAgsb/Q+aCNcxXUhQIgwX1/bO33A26pNjaZm9R
 SzXhJ5wqJWxgOErkRKe83O2RXkHBSBittXMN3jibuEtzU/XjOi+zHwdXjgz5lPU7
 bQ2MMtjFnksyZBvGP28viTmdMjmxg==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011006.outbound.protection.outlook.com [52.101.52.6])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fgrmkvvb1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 20 Jul 2026 03:01:34 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJ+jifUU+Gst/7YLVQGRPWfB+cvOQx2+TKLyjfFkCo7C4R0IkRBQ7/Bl0yFZ0AcYP5FmldVZPPd2Mp+bWqmVkSkc/R6yJirmPcina+YaDZl95dRdHNXfOF+H78z7q6WnoIL1Vv9SDBXzjVe3GFMDZ2YHhoIczmNJTBAPTK2jMDC35VNCzSRFoGf3nYtDXXy1V6HlN1bc7jMkabLamampKCyqc/MYKQjmWgGA1AkpjHzKYVE3spZHRhU+TorDG+0dIJraKx0tK69vu9WNVRBQVXhAT1iovt2hCPNFh/lOxOUMX4G+EgdanuWo/24fUZkCWaMWUX06Ay0gnHlTBxuIAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mazCl0S8hxEYqpth5g/MlQPdlT13qETOiFKDiHEbJso=;
 b=Ctf/SnEg2U6jlkZ9VdrRrZBs6gLvUIqvSN7l8KZY7JRwf3OTopTbDbMkXKLU7fjdREplFNCpY0f13uyXdmAYHNAWN7bjyW6E5d95QODSvZaE+FKkHiK2UAtSWQ9Ge9uBOiKc4Hix4YhL7pbHv+Xn6ZbyjPU5iY8hfm2v12VGKSOuxvmi9R7iyU1hiXMfAahzpb7yYopK18oNyndHw9INXOHV9nmfg7Yryi/4+6uZwI/Y4nlSxxxdXnK8v8zERQG6ISoTotTGiL5fVGBgu0oAvBDkDv8FRCZqyAUHf6CVLVepNYdORZgUSF8lUID/BUweQbOw/xDchw3hFXOVPHkX/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mazCl0S8hxEYqpth5g/MlQPdlT13qETOiFKDiHEbJso=;
 b=SHHjpqbkk6z1G5c3HrMNtiwSYyMbg7gxUksJFFynyMpCPuKBbQn1D8St9GBOwt5UdGRR2S6NuqeMIYS3OLcBsZtAbmSLgDimRjahj4vP8BOiiFacU0+8h6tGltsTB5a6yIPtfaF9ei0W1J2OGJ6C8XdwFCgCLuwEW3NjojWjj2k=
Received: from DS1PR07CA0013.namprd07.prod.outlook.com (2603:10b6:8:456::16)
 by CY8PR10MB6755.namprd10.prod.outlook.com (2603:10b6:930:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 08:01:31 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:8:456:cafe::36) by DS1PR07CA0013.outlook.office365.com
 (2603:10b6:8:456::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.16 via Frontend Transport; Mon,
 20 Jul 2026 08:01:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Mon, 20 Jul 2026 08:01:31 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 20 Jul
 2026 03:01:30 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 20 Jul
 2026 03:01:30 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 20 Jul 2026 03:01:30 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.50.162])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 66K81FFo2478591; Mon, 20 Jul 2026 03:01:27 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v5 3/7] arm: dts: k3-{j721s2/j722s/j784s4}-binman: Add
 template for packing HSM firmware
Date: Mon, 20 Jul 2026 13:31:10 +0530
Message-ID: <20260720080114.775206-4-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260720080114.775206-1-b-padhi@ti.com>
References: <20260720080114.775206-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|CY8PR10MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a86a5aa-7654-456d-a869-08dee6351c08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|18002099003|22082099003|13003099007|10063799003|10067099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: CXFVfYt+w8ji9gJSFOmKBUrQdVuhMe6AESoVAJI5+9cxS5oxSHbwH2pd4s0Sd2W/42gUrSlL8X+1AwPlIvkNET3cZMqLNV3wk6hFDx7mzQhspcWk6d1ROEz16tMebxHAmRlwTdZK9Ip8aKkSAKMuNDB+02U/4ugJZBZry48lOjD04kU5HRDn7n0HdqBee8+09Jsx2Bq3dZEWfRC+4Ol+b5g3uagYfiuGbiIgZXHhzFFFP7tF6TjQxx/AGzq0SZ/DH+DprqmYzuGZptZ/Lqbxc+TKk8pV1Zo2YHtOhCqGa4QqNfpEQSfeaH1SOSYjfLAJuSk9dwDkYw5c44/V7X7O4bZTyGzqSt+xMxU2jTLxFcMKLrcps1bQkpTI8H4ZKBL9wdjCpcgK69S+HiUtI4xS/ROwRpx8ACiXbQfkiEbkHJcGpwAm08WCk3e0/83zVhTq0rs1a1Fsvj8/RvMRV1Z27G2lr+qEtfET+jxXHfGDrRLva6N+7G0MkSloqqCAdKMvdqg55Fo3jUeR0+BJvS8dksXfokbdhzndlL0deamiEyurqcCLG/SdQdpXJ59iy19WiMnRQ2LuAisLwH4i5BnLNYf7ujVi2TcdWFV4N9JnfMIJ7YAWR9rVlegvPb99sC7kTBagosvmCt+zUSusp8MA4g==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(18002099003)(22082099003)(13003099007)(10063799003)(10067099003)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5SwrXql7F5Ajq/x6PHhx8snWtih7BGWwN1s8Gxp5IQZQpSlareuUOvv4tc4ZH3VdWUfdvXahybRGqyHQWfg1b9HGASz5/7XIL8dJdqH6IIG5xmCgxKXdv1kVUX70ffg2r6i/UzYTmRCe5uksoBf+BNsqMKXyqw2QCqsNLB7d5c1er9XKBD52Jr+Jrg3Yb3eeIddmQMMZdGr/EupjcFBNyZT0i/OtzC2jhW9OpD7ffHEXDijKhV9Cc69kTBaRqty+BqdRNg3PRcHk0d6fLEMmYWxy+zWy6ld8XF79bj2Dtli5MG9tKavGV5NIVPAUm9lvoXwf8UKTJaPYpQNL59UbCLTy/iSWl88nibAsczvOE+cIqnXJC7+RSXnnnPZy6P+i78HVes7knZVWf/25K/7uGxu3s0ejXDJfIzQaWCCtXE71j7GfL7/V0QF7ey3Xn2QK
X-Exchange-RoutingPolicyChecked: FQSLOxlmgmE5pYkmRHUR/UcvB5jtLdPq950jINZUQ6rn30InM5qdv88NPAzdPTzQh4AaPep0GPGn3k51xDjNgYwKYLLuFBsN9PzvhiG16WF5U5E5aRSWGs1HM87/zeBT4nDjTJZPLL9e2nTyQ+waWJLuT5JYkhQqtNcbWDyQglknyHMgSaZJhdNSaJpit2D30t+Ejqlyg7K4ABU0EcRmnCN0fRMDGO0RrdPLG4pnSL4HvIY4U2MbmOWJfwi2iA/G5qSDdYqif5SBCdlhgKFV1XoESox/DpQ3BysgBFTYsPMHZxZf8trEMAvF2ozojUoxTzhhUP7EAewxpVv47rvxaQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 08:01:31.0265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a86a5aa-7654-456d-a869-08dee6351c08
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6755
X-Proofpoint-GUID: 4vOevVzDAUlshaJk2nldVgMo6LLoxuMs
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA4OCBTYWx0ZWRfX/tS6OKfLa0qu
 UHqK/ezrOqFb+2kwhUvaH6tDTW3ZeTdWpPzaZGuOA1vVJD5Nv7OhyZPj86rusn5z6fNQPbTxJgM
 VyhqdlZBvLNHe+OgDPr3V6/pGP/NldI=
X-Proofpoint-ORIG-GUID: 4vOevVzDAUlshaJk2nldVgMo6LLoxuMs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA4OCBTYWx0ZWRfX/2pq5VBhD7EP
 lh3aeDqtBR4jMsU/ofug95kw6T8J1jeXmB15ECbM4q5UTQANyXCF7X1uD2PBzPOaPtyqSaeiAHV
 Feok5EFyJhYRzDi2CHQJ30ALGL7LO2QC46pqlw8YkOca2rHwaTw+N0S5VwvUrskXLZB0E8gX5Dq
 v0RkKycY3MGm6cR4hABgc6Bl5a+PEm/IYR9Xi+gdkcPndrHq/N6yWpmQo3TKexOn7YFNJeA3y1U
 bJqlq7qwKh1qbnL/ol6smoxEcE24E5s0sSjrbitTJRj1XXi1GpFSkz6yXeqliJIrhA01+bYWM2R
 cZ5cBq7Nbgt/t6oJaEn3IXy3OBK3CZOLodZNZwDqa0A1QRQgWtUD3tEUQ3lSeMBiBLqU/SkT6Z0
 3vUYxtgnw0M/bbV0ffeXFjAfocN3iZXbI5o/CLCcKfUf77zW0lqFvmfoLOi6qJBbEtkEj09/qRA
 mHJaozrMtl2bXpbERGg==
X-Authority-Analysis: v=2.4 cv=KIJqylFo c=1 sm=1 tr=0 ts=6a5dd5de cx=c_pps
 a=Al0BzvsZ99ielPXA9PThCA==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=cm27Pg_UAAAA:8
 a=FXiWu2nYAaGsj2XNjoMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 phishscore=0 impostorscore=0 clxscore=1011 bulkscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200088
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The HSM M4 core needs to be booted at R5 SPL stage so that it can be
used for further Authentication and security services. Therefore, the
firmware for the HSM core needs to be packed in tispl.bin fit image so
that it can be used by R5 SPL to boot the HSM core. By default, point to
the firmware for HS-SE device type. This needs to be changed to point to
appropriate firmware when using a different device type.

Add a template for packing the HSM firmware in tispl.bin. The template
also contains necessary fields which will be populated in the boot
extension and load extension in the x509 certificate for HSM firmware.
This is required as the HSM firmware needs to be signed before invoking
TIFS to authenticate and load the blob to HSM core.

Note: The os = "hsm" property is matched against
image_os_match[IMAGE_ID_HSM] in arch/arm/mach-k3/r5/common.c during
post-processing. This string must be kept consistent between the device
tree and code, as changing it will break the image identification logic.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v5: Changelog:
1. Squash [PATCH v4 05/11] and [PATCH v4 06/11] into [PATCH v5 3/7] for
bisectability.
2. Use hyphens in DT property names.
3. Update commit message to call out os = "hsm" matching criteria.
4. Add comments explaining DT property values and add link to ti-sci
documentation.
5. Use whitespaces consistently.
6. Add R/B tags.

Link to v4:
https://lore.kernel.org/all/20260425033742.1519298-6-b-padhi@ti.com/

v4: Changelog:
1. Changed phandle from hsm to hsm_fw in 'content' field to match with
   node label.

Link to v3:
https://lore.kernel.org/all/20251231173621.1069988-6-b-padhi@ti.com/

v3: Changelog:
1. Added ti-secure node for signing hsm firmware image in U-Boot.

Link to v2:
https://lore.kernel.org/all/20250506104202.16741-4-b-padhi@ti.com/

v2: Changelog:
1. Got rid of 'load' and 'entry' properties. Rely on U-Boot to set it.

Link to v1:
https://lore.kernel.org/all/20250422095430.363792-3-b-padhi@ti.com/

 arch/arm/dts/k3-binman.dtsi        | 26 ++++++++++++++++++++++++++
 arch/arm/dts/k3-j721s2-binman.dtsi | 12 ++++++++++++
 arch/arm/dts/k3-j722s-binman.dtsi  | 12 ++++++++++++
 arch/arm/dts/k3-j784s4-binman.dtsi | 12 ++++++++++++
 4 files changed, 62 insertions(+)

diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
index ad127663d03..af752619255 100644
--- a/arch/arm/dts/k3-binman.dtsi
+++ b/arch/arm/dts/k3-binman.dtsi
@@ -297,6 +297,32 @@
 					};
 				};
 
+#ifdef CONFIG_K3_HSM_FW
+				hsm {
+					description = "HSM binary";
+					type = "standalone";
+					compression = "none";
+					os = "hsm";
+					load = <CONFIG_K3_HSM_LOAD_ADDR>;
+
+					ti-secure {
+						/*
+						 * HSM (Hardware Security Module) core boot configuration.
+						 * Refer to TIFS Boot Extension format specification:
+						 * https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/security/sec_cert_format.html#sysfw-boot-ext
+						 */
+						content = <&hsm_fw>;
+						keyfile = "custMpk.pem";
+						proc-id = <0x80>;      /* HSM core processor ID */
+						flags-set = <0x04>;    /* Bit 2: Release processor from reset */
+						flags-clr = <0x00>;    /* No flags to clear */
+						reset-vector = <0x00>; /* HSM starts execution from address 0x0 */
+						dest-addr = <0x43c00000>; /* Load address: HSM SRAM base */
+						auth-type = <0xfd00>;  /* Upper byte 0xfd: HSM host ID, lower byte 0x00: Copy to dest-addr */
+					};
+				};
+#endif
+
 				dm {
 					description = "DM binary";
 					type = "firmware";
diff --git a/arch/arm/dts/k3-j721s2-binman.dtsi b/arch/arm/dts/k3-j721s2-binman.dtsi
index f79b3e543ae..2b36b04965e 100644
--- a/arch/arm/dts/k3-j721s2-binman.dtsi
+++ b/arch/arm/dts/k3-j721s2-binman.dtsi
@@ -268,6 +268,14 @@
 
 					};
 				};
+#ifdef CONFIG_K3_HSM_FW
+				hsm {
+					hsm_fw: blob-ext {
+						filename = "ti-hsm/hsm-demo-firmware-j721s2-hs.bin";
+					};
+				};
+#endif
+
 				dm {
 					ti-secure {
 						content = <&dm>;
@@ -300,7 +308,11 @@
 				conf-0 {
 					description = "k3-j721s2-common-proc-board";
 					firmware = "atf";
+#ifdef CONFIG_K3_HSM_FW
+					loadables = "hsm", "tee", "dm", "spl";
+#else
 					loadables = "tee", "dm", "spl";
+#endif
 					fdt = "fdt-0";
 				};
 			};
diff --git a/arch/arm/dts/k3-j722s-binman.dtsi b/arch/arm/dts/k3-j722s-binman.dtsi
index 278b7bfac7f..3834d081c30 100644
--- a/arch/arm/dts/k3-j722s-binman.dtsi
+++ b/arch/arm/dts/k3-j722s-binman.dtsi
@@ -117,6 +117,14 @@
 
 		fit {
 			images {
+#ifdef CONFIG_K3_HSM_FW
+				hsm {
+					hsm_fw: blob-ext {
+						filename = "ti-hsm/hsm-demo-firmware-j722s-hs.bin";
+					};
+				};
+#endif
+
 				dm {
 					ti-secure {
 						content = <&dm>;
@@ -153,7 +161,11 @@
 				conf-0 {
 					description = "k3-j722s-evm";
 					firmware = "atf";
+#ifdef CONFIG_K3_HSM_FW
+					loadables = "hsm", "tee", "dm", "spl";
+#else
 					loadables = "tee", "dm", "spl";
+#endif
 					fdt = "fdt-0";
 				};
 			};
diff --git a/arch/arm/dts/k3-j784s4-binman.dtsi b/arch/arm/dts/k3-j784s4-binman.dtsi
index 34b2cc1e681..ac12335a84c 100644
--- a/arch/arm/dts/k3-j784s4-binman.dtsi
+++ b/arch/arm/dts/k3-j784s4-binman.dtsi
@@ -154,6 +154,14 @@
 
 		fit {
 			images {
+#ifdef CONFIG_K3_HSM_FW
+				hsm {
+					hsm_fw: blob-ext {
+						filename = "ti-hsm/hsm-demo-firmware-j784s4-hs.bin";
+					};
+				};
+#endif
+
 				dm {
 					ti-secure {
 						content = <&dm>;
@@ -188,7 +196,11 @@
 				conf-0 {
 					description = BOARD_DESCRIPTION;
 					firmware = "atf";
+#ifdef CONFIG_K3_HSM_FW
+					loadables = "hsm", "tee", "dm", "spl";
+#else
 					loadables = "tee", "dm", "spl";
+#endif
 					fdt = "fdt-0";
 				};
 			};
-- 
2.34.1

