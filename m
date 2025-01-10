Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA43E77188
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 12:36:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C09D80613;
	Fri, 10 Jan 2025 13:36:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="oVHXkjZg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10EC280613; Fri, 10 Jan 2025 13:35:59 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2072d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::72d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9301880608
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 13:35:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aHavJa/msV7Ev/abwBu6ak8MwcCCe6juGyFVS17pA7dbyn8b8gJo7+10nuIfMYU2tfLa5MSylZk/YNg6Mu10siDVD3dAXI4jdl4ARxQoEudA9NvL+RNl9t0y3q5w/9/lItqFBO8NdEo38hgTbxJUHd7f8VaDB+dJ8zFK4F8sM6Z8dEoZGwYx3dGYfpOGq3RPtLbn6I4fikp4mMyNp4ZYkYMwnB3f+GCLVbPi9mSuke5G9u2j7gVdD0ZYfutWaPqdMzXr1wXAKUubqBk8yDtW3IVl50EMh/Au8AxPweGpYkUoP6KLt2qWA1F3cAbS3dxgnGI2CUFwpMEuMnOnbKmfqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWw8hQ8emTWkCeRddKlxsdaK7oMmfq8wMSETmLZ7fGQ=;
 b=QxmmK3TPxB68NNBQx8VIIDV2EorlfEOc5+KlmpfhZshelbql8JxnyB1WBcwTuLLip6zfl/ROFgaw3pAxxn9eeTmWotNAGsVzg7Sf41tf0r9oQ23eJ4ikdjNV00XQBIqniEKZypNXenZND6GoUhd4kePOvfRYIhF+Qdu1M7S0wTXYxq9wVXMZF3ICAnq8OmZ5dvX4fyOZqZ7wRNOSsxIvlqoLAz8oFYtdt1Em6l1D4BE1ShFnfSEIpvMJmHX1zTQpoFhdIj1AnKEe79gS6u/HviBal7kVoEd8+I/Twz6Hxq9e6tt/Z0laHcHRBPyrR9rtvS0U02ZrLqIU0Vqm8FpFhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=gateworks.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWw8hQ8emTWkCeRddKlxsdaK7oMmfq8wMSETmLZ7fGQ=;
 b=oVHXkjZgb6SsGtrLdOljnsRKyUsicZjFFwZ9D088srb0v9OOxntgein8jtQTQbQp5arl6qFQDnnP8ZvNV8HEk1FAb9fho4F38iM5AjO+JbHSvwAJgz+fBJOS3t0CxCjAEsr+iR/6LxrFp+OP3o4rNcZSoT2ySXXmyykH4J+BB3F8VmZH/3PkJVexJ4cdvgepPDEgrZW2BOYQUCe63sQtkcUZAJxE2NoeGEC+pbg/lqUIBxDgnKBSUsHjAw5GsfsjftALSRcTrNV6k0jgUGvXLVl5fWtuVIqh6uY5lvTifNwZU3/B+f8d189byCt8SSbaU60WkoqnyDlHt/vfOZ20SA==
Received: from PA7P264CA0143.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:377::16)
 by GV1P195MB2639.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:1f4::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Fri, 10 Jan
 2025 12:35:52 +0000
Received: from AM4PEPF00027A65.eurprd04.prod.outlook.com
 (2603:10a6:102:377:cafe::7c) by PA7P264CA0143.outlook.office365.com
 (2603:10a6:102:377::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.12 via Frontend Transport; Fri,
 10 Jan 2025 12:35:52 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM4PEPF00027A65.mail.protection.outlook.com (10.167.16.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Fri, 10 Jan 2025 12:35:52 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 10 Jan
 2025 13:35:50 +0100
Received: from lws-moog.phytec.de (172.25.32.31) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 10 Jan
 2025 13:35:50 +0100
From: Yannic Moog <y.moog@phytec.de>
Date: Fri, 10 Jan 2025 13:35:34 +0100
Subject: [PATCH v3 2/6] phycore-imx8mp_defconfig: add optee load address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250110-phytec_imx8m_optee-v3-2-6c39dab15592@phytec.de>
References: <20250110-phytec_imx8m_optee-v3-0-6c39dab15592@phytec.de>
In-Reply-To: <20250110-phytec_imx8m_optee-v3-0-6c39dab15592@phytec.de>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, "NXP
 i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
CC: Tim Harvey <tharvey@gateworks.com>, Manuel Traut <manut@mecka.net>,
 Benjamin Hahn <b.hahn@phytec.de>, Teresa Remmet <t.remmet@phytec.de>,
 Yashwanth Varakala <y.varakala@phytec.de>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.1
X-Originating-IP: [172.25.32.31]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A65:EE_|GV1P195MB2639:EE_
X-MS-Office365-Filtering-Correlation-Id: 4295a0b5-8c2f-4414-7634-08dd3173520b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UUk4dS9lZyt0U2NzWnZQMzNMeERVZHV0YjRuZFhpemJiYVNTeFVRRWs3dDEz?=
 =?utf-8?B?dUlJUTVhemtQRzZFMjlZTWh3V3EyZHlQcVRsMUVucGNKWWNCKzZWZUVPMEhO?=
 =?utf-8?B?Q21VdG9tWjFyaFd1b1F2bUo4NUxMbHd3eWZwN1h3cWFhZFZoVTJPZ09EQmll?=
 =?utf-8?B?VmxwandsVFhOSDI1dkRMMjg3T3ZFUzR2eFBTVWRlaVc2ampSTUlHWHE0bW9w?=
 =?utf-8?B?YVo0dUxNbmZrZDBJdnRWM2lvWkVxYWFuRzZZS1h2OFdmRzlVVFJSWkFJM0lx?=
 =?utf-8?B?bVYvYlRQNDFBSURjeStFTmhQbm1Bd2pNaGgwUkFCVEZENDNEV20rOURJcFEz?=
 =?utf-8?B?TDZ3VitEemZDNVpWTkNVdVJsZjdQRUZUbTdHR2hVdTVCUitjZGpxQUJvaTJo?=
 =?utf-8?B?RXYwKzdRZnUvYUVYZ0pzY3RERCtJQVV5Vk9Oc1doOFlsaVJqeUs3dnRlenhs?=
 =?utf-8?B?VWE3K2xPQUx2OE04OGFBZ2RQY0xWeWJXcVFxaW1xeWRFUVpncndRMW9OajdR?=
 =?utf-8?B?UzJZNEMxaVhIeUpqYS82QW9DU0ZkRVJqNUtpRjk4VlBnQjJTaUdCQU4xV1NL?=
 =?utf-8?B?TnpnekNlUEdrTnBlN2tDSlF0enNVa243YkpYcUhVck04UUVVWmVsaFF0S2ZF?=
 =?utf-8?B?dTM0T2ZFaC96S3VacVZCTGtEd0Zadm9wRnprdmRQU0Zja0J6ZGh3MzlTZXh6?=
 =?utf-8?B?MlZaN2ZOUUcvSGZ3M1hXcDN2V0ZwV2R6eTZuTEdQdlBoNE13VENVS2dvenRu?=
 =?utf-8?B?bG5aUjNEbGlydWdPMHRRQVNvN1k4S2pjb2pKeTBkYWdLcTZGZ1FyVUtrUlJT?=
 =?utf-8?B?SHc0QUtXZEs4SUQ5QWNTa3BQaW9rWDB6Vyt1K0xCTm9WMUhpNk0wUDhWNWNR?=
 =?utf-8?B?UWpUcUFuTlpxUDZaZmlaWXpPZEk4elRCb1dWNkxyYkNaOEZBdllMelljcGM4?=
 =?utf-8?B?QXdCZzYwK0tMQXFWTW5yZS90c0JOQnJsQm11VXhXQXoxQjEvcjQvRzJ0Vkwx?=
 =?utf-8?B?aUwxQ1dyTWk1QytNeWRxZHh2YjJVdnNQaHh2Rm4zOWhGU0JuKzl5TTBrc0l5?=
 =?utf-8?B?dXBSY0FLQ3R3eGV5RDV2RUpqdDRCUzdyZlkxYTlGRUdwTmhUWEJ6b2NMS1VN?=
 =?utf-8?B?SVI0SC80WUlOVkpWcmFGMkxlOSt1elIxMmZqYXkvK0ZNWE9DajlhOGF1azFj?=
 =?utf-8?B?d1E2Q1lQb2QzNEhyWG9tRkN2OFVhVmtHSEhXeU5TdHd3L3lkTXhLRmJ0ZGhR?=
 =?utf-8?B?SHRXaldkSnhVQitpWnJEZFV0TktXYksxbGsxUUxXN0ROcEJzWnVkc0o0SVlO?=
 =?utf-8?B?S1cvNnZPQTRXZXE0QlVGeU1hRTgzMnlHRDBsQmIrYWI0MTY0eCs0NW9ZRHBN?=
 =?utf-8?B?VjZZRnIraG95eG9nRDg2QlY2YjM0SHVpMnNMS1VPMUlCUkJNYzIrR3hvK3BI?=
 =?utf-8?B?dVBqSlZNZnZTeUhtL0ZTUWY5WjJ0SmoyNTMwNTg2WmwvR0NsMmR0VHEvcEZu?=
 =?utf-8?B?OXVxYUlLVHJxUjZBeDVNdFJlQ2tFNUp0cHp0WjNsZXJMQjZHUTF6UVdnZ3dp?=
 =?utf-8?B?VmN2dVZSaWJERGFvUlFYZjFYck9hSmpTRzRFdFZNOGl1QjFEZmJ6dHM1ZUNo?=
 =?utf-8?B?K3pxVmtvK1g5b2dFWFpjaExZRDlpSjlRMUF0aVo3Tmd1dmovdmNBQnBJNk5x?=
 =?utf-8?B?NDNLS0U0UnJaYmtPbUlhenBiZG5aWFJoQld5eFZKYzJnM0tTYThnTUFhMXJs?=
 =?utf-8?B?dmp1L1FPQk13Si9RckdaQ0RGSEFtVS8xOVZTVGRlR0wwcVExT2dZRk9KWGNS?=
 =?utf-8?B?NmtRRFNSWkV6QitDc2JacCtGUkJWVnRHbnRRRzhGRzRaaGFtSm1PSkpxN0Jq?=
 =?utf-8?B?MlRDL2JNZU1uNGxWcDdXR21GemNqTlVYMlFWQ0duWUtUMzRRekJsbHZKUHJ1?=
 =?utf-8?B?TDVnZ3llQlRIWjMwZjM4dnhUeW5NaDB4R09KRHdEY0k5N3RJZnJJaUJ4NXZG?=
 =?utf-8?Q?RI2NL4xQ3XaUtJIfXcWZmgWrFDBIKw=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 12:35:52.3492 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4295a0b5-8c2f-4414-7634-08dd3173520b
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A65.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P195MB2639
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

The phyBOARD-Pollux expects 0x56000000 address to load optee.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 configs/phycore-imx8mp_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/phycore-imx8mp_defconfig b/configs/phycore-imx8mp_defconfig
index 23981826109..ba716a6875b 100644
--- a/configs/phycore-imx8mp_defconfig
+++ b/configs/phycore-imx8mp_defconfig
@@ -5,6 +5,7 @@ CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_IMX8M_OPTEE_LOAD_ADDR=0x56000000
 CONFIG_PHYTEC_SOM_DETECTION=y
 CONFIG_SF_DEFAULT_SPEED=80000000
 CONFIG_ENV_SIZE=0x10000

-- 
2.43.0

