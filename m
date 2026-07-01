Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FFECC43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 06:27:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 732C884A3C;
	Wed,  1 Jul 2026 08:27:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="dQqkhLVi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F69484A65; Wed,  1 Jul 2026 08:27:51 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 236D184A26
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 08:27:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=igLE4iYe0ZlOLNwCBIRnUgMQByZhiJdX51aWgqpuz51horcLif1rtuKH3OtWSCfds2BSnHTN0+5Xrk8NPRb7EgBjvKRoS5gwudjhdUwx+UDi5DzGBb54fKkaC8hnJo3MqPA09eI7PgN7yOX6q+/OA45/l6+x4rbMzV/ZFzY9y/NLAyfVlKHXLFVe12VNeW52nz3wT1D2Zzo+9Bn9/2TvCpyMU2qqtYrNH4qZCsb7NnDXwtJpRCm90y1YxeLDZ1Qx25OTEiyYvJV5ZHBcXKQrZw7JddKQ8/og+GUfHPfG34wPg64cofV25qR1y09T38KnfcRyhxTAp9Gf7qos5H8+xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3t1+XuADpLdV+RWPfOR1XuBv1xsu8J9S0NqwLlMi7A=;
 b=oscnyITICJEX3tjqcW+IllZlGbDGCVQaCaXDYenrwqNMPXLx9aXGjlHhVVIx+PgAEXR+4z/ObsGF1YnMhmHqIfyKeN/8UxM0VqFtaFjVQU/A+bRQTuZXlNTOp/wAmX8Bq9y0qlS95o0oKDiICHFO7CtLTSHuYssT/6aEVgguIb32gT4ix24SPxBs5mA71wHD5XtmitmbPrbdtsR/mVlJD6YqIxOQ14TWe/lyMIkhOzZ7xKMpagJW90Vw+lrBThPbMr9wyskLHXzPrJkP3fkpRnPCTzIL66QWnKZYK/kJgCSr2pvmGS4ZyKGaU8vAguYTgKPyJHX5zOPf8yOGh4EGdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=mailbox.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3t1+XuADpLdV+RWPfOR1XuBv1xsu8J9S0NqwLlMi7A=;
 b=dQqkhLViJDWQb3wfhfH5TjnHOEVtL84OCiPGVuomawJVSNSZxmvukzD75FjWu3AYXamiJg3l64An216+xQk+8XHAZFGYnRfxtb2pXQ31Dsah/19DCgMtWd8oiMTBZqudSm+scqgsvl+ZZLRqSEUMi8ogjwTKzUU/v0ilfwpw7tISV+dwD4DYbbM2eljPt0uiph6r2z3AynGRzqSl3eMJAPNSUBEfXvC6utz+BiQfMLhx0vKFJ7kAGdMWvendabc8D5i4r7ZCQSzU9PRWuUzYb21NNEO0ueVkHgYODg9sG0rEmBHkryonmMe/5AtesIWJcDoM2YRrxrxBEzO3X+GkRw==
Received: from DUZPR01CA0185.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::11) by DB9PR10MB7290.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:462::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 06:27:46 +0000
Received: from DB1PEPF000509E7.eurprd03.prod.outlook.com
 (2603:10a6:10:4b3:cafe::97) by DUZPR01CA0185.outlook.office365.com
 (2603:10a6:10:4b3::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 1
 Jul 2026 06:27:46 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB1PEPF000509E7.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 06:27:45 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 1 Jul
 2026 08:32:01 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 1 Jul
 2026 08:27:44 +0200
Message-ID: <4db136c5-aa08-4506-99ac-bbfe0c7963d8@foss.st.com>
Date: Wed, 1 Jul 2026 08:27:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: gadget: f_mass_storage: Move schedule() in
 sleep_thread()
To: Marek Vasut <marek.vasut@mailbox.org>, <u-boot@lists.denx.de>
CC: Lukasz Majewski <lukma@denx.de>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Tom Rini <trini@konsulko.com>
References: <20260625-move_schedule-v2-1-2e4abf0c5425@foss.st.com>
 <750d6e53-d48b-4791-8544-6d5edf7a895d@mailbox.org>
 <d239690c-4503-4c60-90ce-478394aed4c0@foss.st.com>
 <2051a113-6091-4ece-bf1d-affb2797374a@mailbox.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <2051a113-6091-4ece-bf1d-affb2797374a@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E7:EE_|DB9PR10MB7290:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bacc74a-3b1f-4905-d39d-08ded739dd4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|22082099003|6133799003|11063799006|4143699003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: Ii7dpK75zs3jnz3JI76CJJQJv4PDIoLHt+m9rAmFARhu8Q0KsswJZtq3pbwzdXH/6y6S+ElTNiJvIn3n3TXjK3CvsAhvx3DFT1ocVU6/2ifKDW15mEWRqq3X2Y0utOi8Z8PMXZUdbc14vJw5AzbYvZM8Ml1248ZhKFmQcHDLsz2gnHgWu3DlC38smJOdiqZxHIIJcyhimubzHuSV1GiTgiSg+Yrt9rgX5A6I2Up+v42FNZe/tB4XOSqKPB+UDIw2aYr+uXYBxzxwnaQsNtbf8+FB9BPcMXKU5P5Z8qWyJLA3iPXDiPua1q01cdQm7eA1ZaeKKYty34j62I0xhy9KayZapllVzEEUCZq5EtGwoAunKFHSae2fTyfAwzz4Egs127iYbIVGJgTdvi4yxbm/vTszon5yxOi4PDSCTEyRD7LUDZAlT4t0kRLOQYmdznVjVpGfm2WJYbN6LKwCJ4Ckh/P4tbgXsgeqmcwsx/ot+JI1d2WjJDTcZPRf5V8Dq6PrT+EX3IhViKmu73Dty/y3RqcLmo0eeTSPT5ey//jSJptRDjZoSrLrnaX6RR31RzICfd8JUZl5x+USvtReVyC6Vre6vFlhxExgtKrfYrMIxxt0ZPXuE8iP2RGX9ZrK4vdAVeljdPaigSpFw96jCNfFJG+m93YgrxRc0ZY/PvKP4DoOsM6mQizQOYC0ELCyPkI4c7Ypbmt7SoUAt10ouc07NA==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(22082099003)(6133799003)(11063799006)(4143699003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pB22HW3FPI2dl7BF2ghJLw7xQXGCzixW+fzzhIifPlCu27NZOwgZTm/fKQPFgxdDC/9XYBtzCV/EgrcHI8KzuYQSsng9fJK4dUcQauoFGNPG7EM5eQDGnoIhHrCci+2YfkelXIVYmv2xfuv/e+Im+/QgAZ67Q4yTiuKbBwvzWNAmepxNQb6ASxms6hHpNDXFkMA1e2ytPLscFaRLqv8z5dJRF8LDvGpEpNJoIi3N2KbpXEzvurvhvJ9aQjk+hW2evM5OVfAns+2y6YLld7kgG+JwZLmBhqqX5ZaSXpeRzFCTx3vpTbdPGMdBdzACWv3pqnCQ5w3/b860u+qSChMOjq10viZGR1/sDaAZKTxDXc5eMJWh5cYZupbOUEtvSwFfY//FbOEY82WnMsBckU41lrYhBFsXdfoMSv5nxUREO8zNCLa4xq9lRA02UiAp4B5j
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 06:27:45.7917 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bacc74a-3b1f-4905-d39d-08ded739dd4b
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E7.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7290
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



On 6/29/26 23:08, Marek Vasut wrote:
> On 6/29/26 8:24 AM, Patrice CHOTARD wrote:
>>
>>
>> On 6/25/26 14:36, Marek Vasut wrote:
>>> On 6/25/26 10:38 AM, Patrice Chotard wrote:
>>>> On STM32MP157C-DK2, when aborting the command "ums" using CTRL-C
>>>> it may take a while to get the control back on the console,
>>>> sometimes around 1 second.
>>>
>>> Why does that happen ?
>>>
>>> [...]
>>
>> On STM32MP157C-DK2 board, there are 3 cyclics registered which are called by schedule():
>>    _ mmc_cyclic_cd_poll (1 to 2us) every 100 ms
>>    _ watchdog@5a002000
>>    _ video_idle
>>
>> schedule is called on every loop, whereas ctrlc() (CTRL+C detection) is called every 10 * 20000 loops.
>> That means ctrlc() is called every ~700ms on STM32MP157C-DK2 board,
> 
> What takes 700ms in sleep_thread() , surely not schedule() ?

Hi Marek

On STM32MP157C-dk2, each schedule() execution takes between 2 and 4us depending of the cyclics function to execute.
> 
>> Moving schedule() from main loop to same level that ctrlc(), it allows to call ctrlc() every ~70ms
>> which increase reactivity when user hit CTRL+C.
> Maybe I am too tired, but that does not sound right to me. Why is ctrlc() called every 700ms, where does that massive delay come from?

schedule is called on each loop, ctrlc() is called every 200000 loops, that explain why there is around 700ms between each ctrlc() execution.

Patrice
