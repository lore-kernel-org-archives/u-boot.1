Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F26CD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 16:34:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCF7584936;
	Tue, 19 May 2026 18:34:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="m5kY1TVf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 184C38490A; Tue, 19 May 2026 18:34:03 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E14F18493E
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 18:34:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yann.gautier@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OLfhhUPWfK3u0+6H7VblShiAU81ANvj3Nur/LM62SGT4zLKwFdq7eZEF+cHt7RgAB7uBpzVWM3ayoi5AiAYpBNwBY4VzjobD1PCL0FG4CIxbz8VYfORKYgWJ4K9nsmaVJAAKp+ieMpC/wHjef0na/63iFcutjydx49lI5muBVaQOHT+aM3wnpuvq7yiREYnW8SAXqDGvhg3d+U+zsq5vLEocDvaiYgNCsLLHz4diQEA/Y3a7Z/SF9nOu+WGGW9DQ9eljVM/ZpuFZi5q8MgcZvINA2Xb2E6Rz88OIXF0CFXyc2zMKIG7OYeomCP2PD8Gi3Yvc9/3w56xOOv9ss1o8lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XaOOCXxedCzTf9gBCyPJQZERgbzI1l7FDQcm3WwzqXM=;
 b=T+D4jpHL34IIHrJngm1nVo4DYzO1ocwVlv+pIGKpTlccfUTxCjcPthWyUzjQlnTk9phNfIcbQlo4JryTE1sl65ImMkv+58UMv/OQMalxCzppwtDQ/gtwlo9o2gGqxAaJTUD7MqvOM3C9P+DbtRGd1/Ck5IpZPmO6y1YD2rA25GTXXbZ1pRCMyNYHqJzT3/UoSPP0x6fNNI+EAohc9PVHxLH8mT3sM3sQAr2peiDRxSiJLOFeg4v4sXdITvBVOuYCECZ9b91jeMtzNwp0RnKzgwVt+KonjzizfCopdbOrAyw9f0caH4mRrr1UUu9Cpt7tWSyEyIxjrBoIu/SUqEINRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=mailbox.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XaOOCXxedCzTf9gBCyPJQZERgbzI1l7FDQcm3WwzqXM=;
 b=m5kY1TVf3+Hr2l/Ut0CNH3/nV5r0cw3gTHK033gJH44tOcGQlJjhYSSe97wTQ79wpS75QeAJ2UXANKuhI1E4cFo3jkHYblhEn41H4IW8jKUmRlodtLTRmHcE6zvwyz+BVa7CF+CdEHRqZZTcndH5yFSmuyEXbBJVugXM5UVnCJ9MTa2x/INod27jJvGtVPNKxVIywqqWYxi4Q7sLQqRE3QWSs7CkCXulg5MpNn3QKXi0pLPYaUnNtmo4x4Ueqn0pg37rCuefc8Knk+KFKRoipPKmFYKPcYhoxkxuJmWpc1fwKqwIH+UVRXyzi/ikb9iiTPMlXOyY1R9UsQhtBSkdVQ==
Received: from DB9PR06CA0028.eurprd06.prod.outlook.com (2603:10a6:10:1db::33)
 by PAXPR10MB5518.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:23c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 16:33:57 +0000
Received: from DB5PEPF00014B8B.eurprd02.prod.outlook.com
 (2603:10a6:10:1db:cafe::bc) by DB9PR06CA0028.outlook.office365.com
 (2603:10a6:10:1db::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 16:33:57 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB5PEPF00014B8B.mail.protection.outlook.com (10.167.8.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 16:33:57 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 19 May
 2026 18:37:26 +0200
Received: from [10.252.30.192] (10.252.30.192) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 19 May
 2026 18:33:56 +0200
Message-ID: <a9c147d1-f671-40be-9669-1ab9ff3cde76@foss.st.com>
Date: Tue, 19 May 2026 18:33:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] configs: stm32mp13: activate watchdog
To: Marek Vasut <marek.vasut@mailbox.org>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>, Tom Rini
 <trini@konsulko.com>
References: <20260519080737.47928-1-yann.gautier@foss.st.com>
 <20260519080737.47928-3-yann.gautier@foss.st.com>
 <101a1835-657d-424b-aa7c-7aa75bdb436a@mailbox.org>
Content-Language: en-US, fr
From: Yann Gautier <yann.gautier@foss.st.com>
In-Reply-To: <101a1835-657d-424b-aa7c-7aa75bdb436a@mailbox.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.30.192]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8B:EE_|PAXPR10MB5518:EE_
X-MS-Office365-Filtering-Correlation-Id: f88d5f29-70e4-4010-ac43-08deb5c46cc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|13003099007|11063799006|56012099003|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: VBGFVV1U+9WTjVzcLCvxAKNB7j1SCTqeBQ11xlO7kQ2uCntskQjDr5rxJ6PixifsEBSbd3LmppTuufW6mKkrMfJ9Nx0MwQvnBvg89MAgMLfuP0DuMlZIGDDNgK8nk8pOrKDvPrj9NK7ORQ6wJ4Ec8/7M+7zkVwVHHSYe+0s+XYlmDMNWIBltREEfosd9EoSi05SZPmjjrY3vS5HXhaUX+x7/n3anuN4vcxmYhPN7sO6F8ahvPWKQflHtsA8NiR/Yw4TfIawqLNeGkdErOnmbr1QqljnJ0f2BAvT4wHCCXvxfmWmCoj3LEFKBkk4UhGtYUWu0077z6TBv6Ae7S4tU2nK3JiRxCqPrWy15ByqvDsFL2v3ibvtmOpzp2od6xEx9I9YmE6O2KegzjGBdrh9Am4UyGJXHPYVuHVQRgcAQG9p+ilOckyU4/RuG2Ae6wuSqbI8MxGUzIY7dfjJfCrwxHRUIlKng4puClFxyk+JnE273UlqgHcSu02Zimchj0kNGwwGxrdGh98TFkcSa/EmX6d3MqstuTyWor4Zhzto27xyYJZOuL/gBD8G1jzUJaC9JyPHRrO+sFe1NhKzdybWRgIqWQvHeB/8favdJZqts0D18gT+Xs7D6qC/P7GUpIncxevhzqRzfLE+lTCiVoT9QTjH82NmGqn9RlZjv7ZSyC04XYaEkO7tt41IhKzMHpM21gsZTOJQSel/Itkdi1xSjX/lTPsEYU9sXdeOiDFT56RM=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(13003099007)(11063799006)(56012099003)(22082099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AZJrd0V9wEhsulK6gxg1ceblgUw/5NeyJRdCfwBBJiGFEMPr5/SY+V847dhnZ1IUAwqjHvPpVbz+5X9kSoXABfUPGHW3r6cQULka27Fk3XfESdzn78B4/VdxgpDGor1tncTvE6pERQRic8bLAjyfbL81kv93B7Z5UW2TWcBZVIbmn1ZwhEYCZkfM7dEQ4BOP6bFQl6tiUJvMj0CdhXhLzGAtejMJrLSV6zZZHcslF4Ty2+EzC9TSbbIfegR1VyN2Nowub379sXawLwcWHLgBL1dBnRvICoEvz0d8gRBzNMZevJC+50dtRn8a1ktOAwZXmX+ZznzfPJfP6Reoy20fI8VVyFX6g7/O91qQeZGM7g5iH992VF80Ii+5TWAApS30i1SUlHvO5sBzod5F8JH0D0OeEoU/qV2trRjRHjhOE5hRj0TmOajwgEB2FlLW2UY5
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 16:33:57.5146 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f88d5f29-70e4-4010-ac43-08deb5c46cc5
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B8B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5518
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

On 5/19/26 16:31, Marek Vasut wrote:
> On 5/19/26 10:07 AM, Yann Gautier wrote:
>> Activate the watchdog for STM32MP13x.
> Please expand the commit messages , this blurb above tells me literally 
> nothing. Which watchdog are you enabling ? Why is the current iWDG not 
> sufficient ? And so on ...

Hi Marek,

I've updated the commit message in v2[1].

[1]: 
https://patchwork.ozlabs.org/project/uboot/patch/20260519163145.221668-3-yann.gautier@foss.st.com/

Best regards,
Yann
