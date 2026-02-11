Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8845E9E312
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 14:32:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BC5A83CEA;
	Wed, 11 Feb 2026 15:32:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="NSy1Ax8O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFCAD83A47; Wed, 11 Feb 2026 15:32:34 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E87F583CB5
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 15:32:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z9cEfFQoX6kBDgaIPMMazKjyKA2+i01YkkC0eVoUlrl2a7STJcWCb30t7+7+Sbu91W+RwuSY7iZ1GyevId+/IBuLxb2zgVtyB9ewlPFaiA9V/JLq4L3VAyilxmkpkd9odXftkWqkh3mPz1zt24L7d/M6J8iUX2db+Xw33sYa3Jc7G8rrN4TY46X66fJ1wMd2ItZvCx7ToqU0wbSGo1rNgb3CfiwORE4uq45i4yWxdZp0T+e8rAs1d6cLYRaQzK6+3Z4NhnI/GrypLYd6gAV7lDaz+JiUQ8KMEkCX6hLrAGQ28jYDmfusc9QMs0KuSY6hAVipAD+fmYGtdUQd/Jq7hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPmqwUn7/hKECswDaC01Z3IaddL1TaDXUTqOhsrwlYU=;
 b=Cm1cwrofiRt5jp7+q6SXT9zLEUNuVp7TM6+CSp7ReVdPSVagKv23S1YDjnt0JOLrbTYH9TjeRBC26NfsvAXhktIseDajw5xlM2eSkwfYIdE/YEP1mH/a+lX90NmDiVcNv3dQpmZVjMDwuz3hUA/qLCftB1DyNYIqs4uZgwtCGZTHbqeHRDhqt2WVY/0IRRKrtgCGFOkXhnTbi0bLsoTcmwzvTc6LMhEMBVQMb1RoXyM62Dekw6XjeGFgP4unAFKeUAatSCP9vDkl7BCclYvcYrf2xBXoO4MS5VdVgaLleCNZI+lJ3m+LHKqW71NkVUTDSJoBgCipKxcGFbYJvPEXyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPmqwUn7/hKECswDaC01Z3IaddL1TaDXUTqOhsrwlYU=;
 b=NSy1Ax8OIKBpv+mmMrIdzHNRHI3VnFoF0Z0ui7wFdt8WwAU1TorKgs4bHx9rJsh/AwViVSMnd9PyYX23UktmPWqq1LyjRXIX50velImKzZ9NKXXfEwrtuaU4t/htO5fcRGno6XPxwJo9GtZkBJFAyeFz7QE0eIfJ1KDTDefyxud5tQtQIjdKv0E+OHgDdh9trUvSizQ9YQWXTLHcYDxyFpbu6o8TxDm+JhxhtsmiNdB+AG/6chRsjLx0IQMYG7MqRbYfniXs3O+7YOWMNa3zQkgt0qoxPopADZ1Yyf/vPkRgeALb83bNrZaKoZ1ySPkyV+ODjZj67LQ1MyfjuHga0g==
Received: from DUZPR01CA0092.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::27) by AS8PR10MB5831.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:524::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 14:32:29 +0000
Received: from DB5PEPF00014B96.eurprd02.prod.outlook.com
 (2603:10a6:10:4bb:cafe::38) by DUZPR01CA0092.outlook.office365.com
 (2603:10a6:10:4bb::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.10 via Frontend Transport; Wed,
 11 Feb 2026 14:32:26 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB5PEPF00014B96.mail.protection.outlook.com (10.167.8.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 14:32:28 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 11 Feb
 2026 15:34:10 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 11 Feb
 2026 15:32:27 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH 0/2] board: st: common: cmd_stboard update
Date: Wed, 11 Feb 2026 15:32:21 +0100
Message-ID: <20260211-upstream_update_cmd_stboard-v1-0-63fd9b767bcc@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPaSjGkC/x3MwQqDMAwA0F+RnFdoiyj4KzJK1mQzB7UkVQbiv
 6/s+C7vAmMVNpi6C5RPMdm3hvDoIC+4fdgJNUP0cfAxBHcUq8q4pqMQVk55pWT1taOS6z1mpDB
 g7EdoQ1F+y/e/z8/7/gE5pkXKbQAAAA==
X-Change-ID: 20260211-upstream_update_cmd_stboard-40acad16a247
To: <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Tom Rini
 <trini@konsulko.com>, Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.14.3
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B96:EE_|AS8PR10MB5831:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e3d01b7-e722-4299-7e0f-08de697a61d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dGJxUVp0SWZieEw0eGdlbzhGdnBqYVhhSDlJL20rSU9wbHM3Qkg0eERyRHlq?=
 =?utf-8?B?ZFdzMUtYa2VFRDNaRlhUNXVERmFjNTJ4RWNLbTBheXl2Z0IvMm13WFZEb2Y5?=
 =?utf-8?B?c01EeFhrT241Q3ZCSytNMHpUMjdhcDZ5V2pSMW51L0VSd0NJd2dCUEM0cG5o?=
 =?utf-8?B?azdhaFFCNGtDeE9MU0xLZVFyaHlReEJVTGdibWRkYU52TE9WMTFRS2pmR0Jh?=
 =?utf-8?B?aklSc3FOYjVzT0ROMUJDNlpwVi8yZVU1a0VDNExGcTVFWDduWGVkQi9xMWtD?=
 =?utf-8?B?MGJ5eDRja1ZxVWRtc3hTTTh5N1JVV2JpZDFoY2V0M0lMeHhzRzdSUUMwRGYr?=
 =?utf-8?B?emp5WExZWmlCVUxLVlQ4OFhPNVd0Y0lkV3c5aDFZRDFMZEQ5RFZNcDFXU2o5?=
 =?utf-8?B?M3JZMFhpVzNIR25jZXgxL1hoeFVkMjRmOVZ0K1VkeVRDTlpvaXZLbU5HaEZh?=
 =?utf-8?B?OFFSQjdhY0RlQ1dEaFVPRU42VDFSOXlKc3ZEU3A1aGRjOVNYbHU1a0RHOGE1?=
 =?utf-8?B?SExMeGtXNlMwZTgvVGwzL3pheHBSVUI3WXYrVkl2eE05NFRQdFRrbUFockNp?=
 =?utf-8?B?RU1BL2g0bmxqaXppOGErWm1FUDhkSU5XYThFZE1sdHVUMFpkZlkwY2hKblpy?=
 =?utf-8?B?YWtKWlpSVjJlYm5NcUZxb1l3RTdkUEF5ek9Wc3dJWjAycXdBTWF1emM3VEJn?=
 =?utf-8?B?Z01lR2VUOWI1eUdlWWFobkVOVGMxMkJrakdOQktMMktUL3FGdkZsc2UrN3pS?=
 =?utf-8?B?L1ZIcnN0Smc3UU1JVXowT2RIeWcxcEZYVnkxemVHWTM2cmJEV0tJZ3R0eVR3?=
 =?utf-8?B?blVIa1N1ZXZBVzlmTDFmVnNIbSs2UVJKVk85bE9ieWlCWTdMWDZRUzZwR01Q?=
 =?utf-8?B?NzBRTnZnNlJHM2EzTEx2ZEJRQ2tOOGhNZjRUTkZBc0dGck9RaFdXclFJTXd1?=
 =?utf-8?B?SStJQUdrQnpTSmdVMVI1UDB6a1oxcGI5VkFSSjd0WTJmTnN6N2RmTks2dmdy?=
 =?utf-8?B?SXlmY0tvWHFXcXlweklJRTFnY0F4ZUlpMmtDVFV3Vkpxd0ZxYi9kdHh0d0V6?=
 =?utf-8?B?a2w0TitZckNlRmN3YkZyaW1BMDArYUI4ZGRRL2hLeFpFdjJJclg2VlNhS1A4?=
 =?utf-8?B?dDJqK1ZTWnVJRm1GYlFYWHZGUThXZGhRanBRVjVjVEpJT2RBbDdxNlFlbmNo?=
 =?utf-8?B?a3pIQlRnVzc0VFFRMHpQSU83b2ZyL3V6OW5rS1BxZnVlK0pkdmpjQnk0Rk1x?=
 =?utf-8?B?dTk3cjZWelVTZW5PVWk4cWdVZWhnd2hvbGlESlh6T2lKU3phRnVQaG9SbUZu?=
 =?utf-8?B?aThxR2d2YnF3ZDV3bWU4eXk4MmlvNC9MaWY0U2w0M0oxaHVzYzBSeE1VQzBU?=
 =?utf-8?B?VVdOVUZnYnhieFJNOUp5cUlDQzhxY2pvNThrQVJ4MkN2TUpta2R4d2Q0NmF2?=
 =?utf-8?B?S21zY0hXQXR1UlUvNERwWlF6MEEzelF0elJOVG80dFhBNENpVkI2cURwZjNT?=
 =?utf-8?B?N0xMc2hoM3VoVmRKWXZiSzlidGVoRVZFK20ydTVwQ3EyVGhyMkRtdmtGN2pM?=
 =?utf-8?B?OUVaR2dzcHkwai9hOWR2UGs0RWd3a1FYK0lTemNYNWUyakk0dzJ2NUd4d21p?=
 =?utf-8?B?NzNGbjY2VFpMVGdDVWNJeVhnZWZuL0tYN2RMcEJXRWZ1SVNqSVk4VFpuYUFM?=
 =?utf-8?B?QkhnaVB6ZWxteWlmNUU2TFpxdVhDZVkyaEpuejlRZy9mNGU2dWZCWnUyNmhW?=
 =?utf-8?B?dEU0MCtQREUxaDBvSUQrL3B3RWk4dVgrWWtLaWh1dnB5ZkVFSDBYaW1kVTZN?=
 =?utf-8?B?Z3lZT0k5bHpPdDB6Z0RkQjBNN25iTVZuS2Npa1dxRWxEL0JWaGVWMDhQUFUw?=
 =?utf-8?B?cis1NEdYRHdsR0crVU5aSGFKbGxZY0FQbFhCcUtWeUJoRTgvekorNmFVdzdi?=
 =?utf-8?B?NFNES1VUaVhzQURaMjNlTkllK0laWXNRTUp4Z1dqQ1VCNzVBcUVSaDBSckE0?=
 =?utf-8?B?NnRxeFZLM3ZaeHIxejR5WERXY0YzelB2dWFlZzZ4bGsvRTkrVUlZWU1ETzhT?=
 =?utf-8?B?SWVuTGpVaUM5RVVxNmpFV0Z3bjE4U1I2cFNnd2dudWdUTlo2Q2hRY2JkbVlu?=
 =?utf-8?B?cHpWWVlyUW92N0x2SkJKZVpJMHBOMHlLWTVPV2ZzRkFOL1p4UXV0c0tramIv?=
 =?utf-8?B?a1hBQ2R4UVlBcVNob0dwWFhvbmswRkVyYWhib2g5NHNDTHlHaXZ0VTh3Qlhl?=
 =?utf-8?B?b0xXVWI4ZnFFV2g1K3lOR0hmZkVnPT0=?=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TiO4Qekj/G0VDwJJZbWX+WK66pqoxBkDK9AgwSTejdxbto1jz+ITu8D9TfMS+98tC3UQMnX4fdC/KtGt8Jh8r9iLJHntCIk3ROR0KSmFTn0129/F8i/M2aqXZoRYXkc5WktVo2Ogc3kR4YPbZg00ro3BZKBL2IIUQ8lBDKFoKBoS03ci5qAs2sjDSffocoiIGEXFoGb/pRzE+RWO4o1RYhbuBQ2+fDSe8EYRDLHPh1TtuiFu5WeGG3MSIrmDN7MZoRfSGpmSH23paTWdzfO32BPkR2uO4uV+LGKNuiGQjcrdeGFUM5Y8mMTnxYj1zXvCEYq4mS+niJ6Cr9io1Nc96uvlNE49VxMHBJTlXRBi9HvBsfcxrlz9mD+5X+6LPsQqOVLiB01K4SzCwUxsY8UHCvPq25zeMQYOEzHg2fNdiyKhuNSsIkHJCniL2+nXza9L
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 14:32:28.0369 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e3d01b7-e722-4299-7e0f-08de697a61d6
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B96.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5831
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

Adds stm32mp21xx-dk board support for cmd_stboard
Adds uclass_get_device_by_driver()'s return value check to fix
Synchronous Abort.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
Patrice Chotard (2):
      board: st: common: Add support of stm32mp21xx-dk board
      board: st: common: add uclass_get_device_by_driver()'s return value check

 board/st/common/cmd_stboard.c | 6 ++++++
 1 file changed, 6 insertions(+)
---
base-commit: 66891ffb14920e35abfafcae795cf4604de6682f
change-id: 20260211-upstream_update_cmd_stboard-40acad16a247

Best regards,
-- 
Patrice Chotard <patrice.chotard@foss.st.com>

