Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E14C0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 10:30:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79CD980ECD;
	Wed, 29 Jan 2025 11:30:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="XWl6eoq0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DFC581F69; Wed, 29 Jan 2025 11:30:19 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20703.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::703])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D93A81EEF
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 11:30:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G9RYNTjK3O3sNXEAJIrsqCAHlEZEns7o3ay66S9e6qmK7FxKuMziVAW16ilTZ2IYlYRC52CpY7mypF+uZXsHu/FbZsC8mAK0gQ1/IwTx3e5V9qTz/6uNBJz4oUPPrmT6IDTMKyaGtr+yyYtrlHhDmV9hSvdaNEJIOy4CJHNlqDhGHin9Jin0ViDoIpZ6yaEk18YssfHKBxEwwk2AiMr9GWIp9Yh+9Hltmj7QH4XawjqThzS4SmUAKFPsNvQaEk9+ozRyl6xDaTbCyIO8kv7ujff3qy1bOZoD8MKE9Jl0XfJkEAq9sxKtcwIE0DbPlm9Op15nTP58KGteXrZBusr3qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6nPSPZ/woV87+vj3vUBKcjQQclX4pWq5fRzDWLT3YM=;
 b=XPdUDU5yp0zdFTB3J2K7ZPYXMKWqC4oWItpckpOCmxpWOXfqznS5HiEcKsaNQ7ucjj9qAUAvsSQ9jAkQpaqQUUkXQlviPPNtEQylS54F1tW7RGPX+SvlD+D5TVdGhPQcWj2esOf4HybGjer36KJbHt+6TcDcAqSQnj5kG+UTJywYXGu7ASzFAH9pk/aqro52qae9Y9aLbqEXXfKDKL0aW3Rbc0BmC2jWB5Vh/nw2ZqGrqNkDWxPk1RYjgOQ8l+E4aW4YV42IQ/RVJhsv73SFdEa+Lr7+L/EtpmaawLXHgXSD/FwHJOkYS5dr1anTyZUTvC1sMLyUUl68HwMIk15Kpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=chromium.org smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6nPSPZ/woV87+vj3vUBKcjQQclX4pWq5fRzDWLT3YM=;
 b=XWl6eoq0W8NTphTD+RDaeJmwvQc0bmeJoMA1S/nx/qDKYMv9xFavpXDWR/oXDMRWyqqiuJH8xXOUAPeauHZDsJetF+jCx0FG58xJatWH74vvvxMxpLNIdWFvMcYWFgVGJ/n2a5h98Igq4LGmy8nddbLhRxsgdOoOAWP4irjmQXpDLzUPLRjwRBOeZvh5QaVZ7OnCZ/8YdlM06PLl++f7h1unTpRhM8XDpN34BCWHhfwbfYDhuS53kIE3KkEp9oOUueMBw6bsEOxS/bZhNR0WsPTuqqDhcMKcIdoqHM6NEZxYWqQHRrA1Sin9wkPgA9MbCcD+Vieh41CbPXLzv8Ni1A==
Received: from AS9PR06CA0180.eurprd06.prod.outlook.com (2603:10a6:20b:45c::27)
 by PAVP195MB2187.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:32b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Wed, 29 Jan
 2025 10:30:11 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:20b:45c:cafe::8c) by AS9PR06CA0180.outlook.office365.com
 (2603:10a6:20b:45c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.18 via Frontend Transport; Wed,
 29 Jan 2025 10:30:11 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 10:30:11 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 29 Jan
 2025 11:30:10 +0100
Received: from lws-moog.phytec.de (172.25.32.60) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 29 Jan
 2025 11:30:10 +0100
From: Yannic Moog <y.moog@phytec.de>
Date: Wed, 29 Jan 2025 11:29:46 +0100
Subject: [PATCH RFC 1/6] tools: binman: ftest.py: fake ext blobs per
 default
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250129-binman_faked_optional-v1-1-a4534bc67cbb@phytec.de>
References: <20250129-binman_faked_optional-v1-0-a4534bc67cbb@phytec.de>
In-Reply-To: <20250129-binman_faked_optional-v1-0-a4534bc67cbb@phytec.de>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
CC: Fabio Estevam <festevam@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Benjamin Hahn <b.hahn@phytec.de>, Teresa Remmet <t.remmet@phytec.de>,
 Yashwanth Varakala <y.varakala@phytec.de>, <upstream@lists.phytec.de>,
 <u-boot@lists.denx.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.1
X-Originating-IP: [172.25.32.60]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019B:EE_|PAVP195MB2187:EE_
X-MS-Office365-Filtering-Correlation-Id: c5ded72f-c455-4719-2d9f-08dd404fe959
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N29Vaktvc0xRS3p1N01wNm0zK1gzWGtpSnVCeXNRSlQ5SHVqWFQ4WFN4OVor?=
 =?utf-8?B?TFltUWhUbmtaK0hTa3draC9DR0NRQUxYOUtBNzY4UnVReEZ5RCtIMkg2MXZV?=
 =?utf-8?B?VGxldkFScU9iYk1OeVNyY1NRMVlSYkg5TG96dFhCbld0ckY3ZGZwVndsL0lH?=
 =?utf-8?B?bFNJRTJPdk5Zd3RzT0o3MnVQMW5aR3lRZUtibzl6eG82NGFQSjNtL2hWRFdQ?=
 =?utf-8?B?cEhGWGF2YmpkK3NSb0hvN3BBbU5CUDAycVI5eC9IQWFiS0RTVzh3OWhiK2o5?=
 =?utf-8?B?aTc0TVVJY3JObUZnYzQvbTJQMGFwdHBQbHEwdmZlVmw0dHNIWXE1OFFUWjY4?=
 =?utf-8?B?VGRvb0JvS2F0Uml4cmpCc2JqdENHNDk2NVdsZFhZek4wcExrMWEvVjZkSlNX?=
 =?utf-8?B?anN0YW1aQmdRT2hMNmpLVCt0UEhibEMwMGZ3bXhkSXpSV2NhbC9RUUNTdm5R?=
 =?utf-8?B?Y0dRSXJpY3hTWlFiL0ZBQUx1Z0xoM01aS1hmMmd4NEx0ZlhOSTJFZHBteGYz?=
 =?utf-8?B?bVpENlBZSUFDM3A4TktIWlplZi9QK3JOa0I2OHZKMHQ4cHhPTkNRVklIcGYz?=
 =?utf-8?B?TGVKMGY3VUtWQ29CTGJIYnBCTkRXelRsaVUzditrSnV5eDJKSUJFMzdyczBP?=
 =?utf-8?B?cHFxajlhdXgzQ2lGOC9EU1N0TUVGZENDSXRmcnoySGFab1poWTVrcnNJN2p4?=
 =?utf-8?B?cnF2VGNtOUlFOVNSSDdna1FUR0FEKzQ5OTlMT3pIY01ZeVlORVNpbFZoVHdQ?=
 =?utf-8?B?QWFRcWtLL1FIaDFjZDhqSERSTXc3dnRaR0lkRUhkWW1VaE9yRmwxTHl1TWtY?=
 =?utf-8?B?b0dYVFByQkVmelo5a01JbUdJNWI1UHI3M2hTLy8rMjVMelZUT2diN0poWC9s?=
 =?utf-8?B?bFk2NmI3Mjk0T0VDOS9TL0V2UWx6N3pkVms1dmc2WmdBZWVUandYQkdDL1cv?=
 =?utf-8?B?Z1EyZVJ5L01zZzg1UUVaUzBlRkRFSHpSWXA3a2xQREZFY3g3N0VPd1ZraCtG?=
 =?utf-8?B?VmNOZ0FHTVJBWE52M0U3emt5d04vMlZqMUpMNHdXazhvSGhpY2VGcEk3dDhl?=
 =?utf-8?B?WE5NdDI2N1gvNTBGdEx0ZWxNeGNNT01kcTZHbmlvU3EyYlVaVWZkT3JyRHN3?=
 =?utf-8?B?a2xIK1hOKzYzWGl5U1lQZlhFbnBLRlZmR3hKc3J0Wnc5MThTMmZMWGN6UTVn?=
 =?utf-8?B?OVcyaG9VUzJFNWFONmxMUXZOODBoaHVjL2pJSjFkaFRuQnlHSm1LcmoxMUZs?=
 =?utf-8?B?TldQeUdwcWlDVlZ0U1cyc21QZVZ0QzFLUmRyUUFxZnh3bkRjM0pIcElBRnhv?=
 =?utf-8?B?Yk1zYmxidDdkeFBwbTYzOEd4ci9OYi8zK3YraGZQNFRYazQ2cWtIZXFLY1h6?=
 =?utf-8?B?R3AvWkhjZUw4VkpZbUJtVmV4NkZtMVRiTUdKQnY3d08zcXYrWXFxREE3TDlj?=
 =?utf-8?B?Z2lTQjVvY0EzYldRUHIyVnhwREF6UExIR3hobGRCb2theUJVZUM0OEN6Um9i?=
 =?utf-8?B?ei9RUFNCOStVNGJSRmJMSjhobExDTTBsWVB0VDU1QkU5Q3FVdWlaOGhsVzN4?=
 =?utf-8?B?a3JGSmhQdTAvVkZUQWpCc2srclBSdmVZb2JzdUVvTUpUQ01Sb0NQTFJRYitR?=
 =?utf-8?B?QS9tNm9raHFlVWh0aHVVTjJCM0JJSU1HSDd6ZzMvb0JjMk12ZC95dndzYU9D?=
 =?utf-8?B?dUNrd0xmRFlROWtlSHAya3NnQ1ZRS2VTSmZDWWNXcE52WnBPdkVpbEhwLzYr?=
 =?utf-8?B?VzFwczRDNnIxaExFRjczSXlCaXdUSkhjb3dpdEs1ZE1sV0g4ZW5zSnRGM0Zp?=
 =?utf-8?B?b0dJZS9SQzNOUm1HRWVMVWFrYzVKQmtxeVFkei9QV0RTSmFkaXRDMkN2UGVr?=
 =?utf-8?B?Z3ZKYWtTa2pmcnhWWGszUjNtcEU5WVhLemZieW9zamRhV0tGRGJBSFd0V0xr?=
 =?utf-8?B?R1habTdQM0ZOYTExanFuTXlQSFJBNmlNT2tOZW9rSVFXTnoyVTArWC9oRm9C?=
 =?utf-8?B?L2VBSmRrc0d3PT0=?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 10:30:11.7695 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ded72f-c455-4719-2d9f-08dd404fe959
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVP195MB2187
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

The top level Makefile calls binman with fake-ext-blobs.
The test setup should reflect this to spot potential bugs before
reaching users.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 tools/binman/ftest.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index a553ca9e564..1f194f9ecae 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -372,7 +372,7 @@ class TestFunctional(unittest.TestCase):
     def _DoTestFile(self, fname, debug=False, map=False, update_dtb=False,
                     entry_args=None, images=None, use_real_dtb=False,
                     use_expanded=False, verbosity=None, allow_missing=False,
-                    allow_fake_blobs=False, extra_indirs=None, threads=None,
+                    allow_fake_blobs=True, extra_indirs=None, threads=None,
                     test_section_timeout=False, update_fdt_in_elf=None,
                     force_missing_bintools='', ignore_missing=False, output_dir=None):
         """Run binman with a given test file

-- 
2.43.0

