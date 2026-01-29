Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF78D358F7
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 10:34:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4A7983AEE;
	Thu, 29 Jan 2026 11:34:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="oe9EZsq5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C874083F4D; Thu, 29 Jan 2026 11:34:35 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DEF083AAD
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 11:34:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSu/t09vYXT/Bh8R7mRXY2pths+kw4avM9Is+ruVFGA2MJSMYqkSEOZC6yOKE52XZykJv5w33AFfbHDHuo3dEX6bHBtvwNz+0U1qQKtQ+w2PLxHGtJXn0WqyrdngiPLGtB0Ss3rdvOPF7KdP9/z8MiBPMwIFj85oQ95wbij9Ynd12zNrIayjhAVp/EVl/zr/F2ur+fPgGs5FY975/ML5EVEUvt+FaVYqpHb1mRpFs3agLqI9DQE0AVG8sDzyO3kiizs67rvIrA/6/o0ECLyVaGpb6n0k1Bh4iYfLPoXyRzynE0q0WdUH/jyuq2oPpzeL67skDbF+o00e6owJbu2UEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHEfZ84BNTSfH4nrCmgx7eZF+tqsnE+fMoWuOcZqFxY=;
 b=s9w2kvUAgr1uh2FqPQ1kwvjMPUnKScV1+sbeeVBoK/m4WgLUhlmNw4pEagNPyrGbYpInADt6RkMK+hF5yPi3ZIDUcrARxjV1X7ipD/9/W0O0qCYkO44AewtX+0LuSD/FxIUuZnqB/dNzy3G2TWUO87OwNAcnkca1FkdFu6OzjwsmDsmfz6FH3kQT1lBjktSOipNgLeUP3YNTW0REEwRoE9kRK0WDuKkvNClF3TUDaDsVMi874XLEXHxhkBp5V6IusbFXxKYbwcyLz6CnG1Vool0GLivkBtCF7I6ZtqqiWJUigOpA/F1NW6QUTvJmT/igaP8Xqb0oNtolG2oMq2JXTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHEfZ84BNTSfH4nrCmgx7eZF+tqsnE+fMoWuOcZqFxY=;
 b=oe9EZsq58UdYnUTyQLQwSavWhaLVjOiP/dK8H+xg9VdZBopAVQTtZ5r3ZAbOlnn8EOrcZjoJGQqSwodsIvyvayNQ1N7pZxprGqK91jRdbs5bcD17WydwPe3Iy7mlidBQCna4bC62R+6J/YG89aEyfsqZJMYpWQLRbRsr7IiKmBuN01URTzG1y2vfUwCg+P86xzPIFJ+wOwXfENyuPcCqi/04WDwGZKoBgZyMIlUAKJXY4Fem0ePKTX4C9pg7Tgxzgx3DJNdQndRjr+AWpjjHrlpT8y92GVNopIlXtPOSCVPa8owslX0DQDqD4No94ZckbyHbmngKDYz8saXaDGTxKA==
Received: from DU7P190CA0023.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:550::25)
 by DU0PR10MB6654.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:402::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Thu, 29 Jan
 2026 10:34:30 +0000
Received: from DB1PEPF000509FF.eurprd03.prod.outlook.com
 (2603:10a6:10:550:cafe::d7) by DU7P190CA0023.outlook.office365.com
 (2603:10a6:10:550::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.9 via Frontend Transport; Thu,
 29 Jan 2026 10:34:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509FF.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 29 Jan 2026 10:34:29 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Thu, 29 Jan
 2026 11:36:12 +0100
Received: from [10.48.86.129] (10.48.86.129) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Thu, 29 Jan
 2026 11:34:28 +0100
Message-ID: <62021eae-d0e6-4073-a05d-48d8ad797762@foss.st.com>
Date: Thu, 29 Jan 2026 11:34:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] Restore boot for STM32MP13/STM32MP2 board family
To: <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>, "Peng
 Fan" <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>
CC: Lukasz Majewski <lukma@denx.de>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Tom Rini <trini@konsulko.com>, Marek Vasut
 <marek.vasut@mailbox.org>, Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Valentin Caron <valentin.caron@foss.st.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>, Lionel Debieve <lionel.debieve@foss.st.com>
References: <20260116-restore_boot_for_stm32mp13_stm32mp25_boards_v2-v4-0-d7cf17cd678c@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20260116-restore_boot_for_stm32mp13_stm32mp25_boards_v2-v4-0-d7cf17cd678c@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.86.129]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FF:EE_|DU0PR10MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: 55418cef-422b-4e0c-4926-08de5f21fbe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SEhIeU5DQ2xnd3F3ZHI3WDZXZDlSdk13T2w1ZTdHNzB2amRJOVFzN3hxK0hQ?=
 =?utf-8?B?NmY5M2l4REJwdVFFWjdsVkxjWDREUERGSEkvbmQ2UUtaSUVDT1FsZVJGZzhO?=
 =?utf-8?B?ZlpiSmFkYzMydEROZ09hMU5XRGM2QzZmWGxZUTd2NUpTbVNUOFhoMkJIMjNw?=
 =?utf-8?B?YVRyZGxOUGtyVTZaQURrSVdUN1dSRnlXMzJid09yYTZsNDJOd2IvWjdta2tW?=
 =?utf-8?B?eCs4ZTFRUjdsV2xKNElkTHV0YlBlVUNpOFlVQjlBZUE5eW1ZaE1zTjBLd3ZO?=
 =?utf-8?B?S0E2QWVpVFRoK2h0bUtIMkxuMWdXNmNuMktmYzVuUUhUZzVQbi91dyt5allV?=
 =?utf-8?B?aTBSbmFLbG9lQmt0M3lNcTIzWGJydTBUdElDM0xmRDVEY1hrSzdOMWtxTTdw?=
 =?utf-8?B?ejNMV0hyMnl3Zlo1NWkzajhQNnprdlBsOTZ6TkQvazhMMjZLUVFSWEl5VmxR?=
 =?utf-8?B?dWVNMEV4KzRQNmU0cUF5bUR2dkVPZys0Qkgzakt1WExsbmxRQlpXVUJuL2c2?=
 =?utf-8?B?NkxkdkN0NHZrK1pLK1FvMUNSQnRiK2tCNHM5SkNxUnMrZjV4K2NGVVdVWno2?=
 =?utf-8?B?b0RaQnIyMXpVdnd1d3ZURWhWeE9VNkhoUE94aUJ1UE00M0IwT2owcWplZ1Ny?=
 =?utf-8?B?ZjNqZitzeUs4SU1tKzJ1d2RWZ25jMVhualFEZXMyM0xsbTMxMzIwWmFRVXR2?=
 =?utf-8?B?eS82UFdqQnkvKzF5aE1nQ2piVXIwRGxsWTEyYWcwM3cyT01WWnZDTDEvWlpP?=
 =?utf-8?B?Tld3UlNhMDAwM0ptWGNNb1ZMNXY2RjkxT0hOc2J4QXNEQzRwblliV3ZXVDEv?=
 =?utf-8?B?Qm9PNmJNVndsUkhwSUd1ODZuTlRSbGVnQWJlbEsvRHNmVXZZYVNGUCtNYStp?=
 =?utf-8?B?aHdqSDZzK1FrVk9mbmJBQUtFMHJaQnk1Y1lJS1cxajVwVHJqOWFYL1FjTGts?=
 =?utf-8?B?amdPNjloVGNMcVVwSUxMYlhGWmNRUDdGT2lZbVNFTFU2aXd6Vlh4d0tmdEJo?=
 =?utf-8?B?MzdiT1dEY05VMHQ2YnVKU09pNnhlMDgrbjE4cVhVdEhabzM2SUJjYjVReFhD?=
 =?utf-8?B?ZitJZ1lIb2NIRTJHaWtNRjhrWHFULytPVlVtNEtJR2FtMVVlemkzaEVlVW1n?=
 =?utf-8?B?VXkveFhiNHd4SlIvMHQ3R0VZaCtHdjdCM01MVThDdFd5bmRHZ2tUS002QnhW?=
 =?utf-8?B?bEpLOHdFZ1V0YytidStocmRJTHQ0NmFuVkRacFFKOEJXY3NKQTNOc3EyeTBI?=
 =?utf-8?B?WGVMUkcvVjZrejVmZnpVejJjek5yZUo1RnNiZ2Y4Q09Qb0wvRUcvSnVUQVgy?=
 =?utf-8?B?UFFvSlArVGlNeFo1K1J3RFBQWiswVWVUcFU2a24vcitsYUtMWGtHdXR6MUh0?=
 =?utf-8?B?cUx6MFplZGFHOXpqRE5iY1dCYlkwQXhwNzYxaGhieXNZRGlrRVZpRDVGZ0FU?=
 =?utf-8?B?UHJOTGN3YUNyaDd6NGJlVmh2QWxkeEFmRG85dStUaTZRRTdJb1BpSG5CcS9a?=
 =?utf-8?B?dE5TdlFhelgwOVBOT3d5cXg4alRSMnhTRGhEbXBNVVJoS0JzZDNuZ2ZkZTVV?=
 =?utf-8?B?MGltNnA1aXFvbTFMVFJnRUdLYXhpdHNQOHpucGh6UWo2YUVEZnNjYkFxTVFh?=
 =?utf-8?B?cGM2b1IrR2xoOGdZUWs1ZXRvanpiWVpCVy91dlRlTk05MENQaW01dGM5ZU15?=
 =?utf-8?B?Q3ByeTF3K1kzdkRMcE1TL2NzR2RkN1lJZkd1bEFkRlZVOTcyeHc2cHRzUFFW?=
 =?utf-8?B?UEh1WXZkdUdMeWMwUVpiSzdYelVTSUxsU0xtQXNiZWFNbDhqem9iSG14M2FU?=
 =?utf-8?B?QndpVVNKOWZtTXdPaUl6Zmt4UzMxbk1rWlhMM2hUbnhEbUJsZTVYVzByaVp4?=
 =?utf-8?B?eVFhbVFKb05wVDhHdFZUMWRrUVB6cHV0VHlsaTIwNzBxbFM2K2NUeUtHRnJV?=
 =?utf-8?B?NHdTMXVmcWVXRTd5VVVHSGZxeDY2QnpXWVJGazU5U0duVHBIVWpXUzRPcFI1?=
 =?utf-8?B?R0V0YkZTaWcxMW1FOVZrZG9UU0xQTTM2V0lvUWdTQmNaYkxkZ0pteUFoNXJW?=
 =?utf-8?B?c0NyNFNZbjlsekozWVI2VzdnUm1wUGVYTy9hQ2hoZFQ4dlJXSlMzV2VQYXhy?=
 =?utf-8?B?aGVzUk4wTDZtK0JVOXB5Y09RbW8yUmFNUTllUVZvY3VYV0YwTVI1YVk0Z3lC?=
 =?utf-8?B?S1ZQWGxnRUZlRzBVckxpcU8zOTJNVC83Q3NSVk1aY1FaZXdiVGQ3YUsrTW9w?=
 =?utf-8?Q?fdsA36Gz8/GLjluzhVVMoDSXrfsP4THB+d4QsYtA3U=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2QD64q4uva2JxQOlLlqWmQc6O05kjay/yi8DtlR4Vz8yVXEkaFvs9Ptw0aa1X27H+vpqPTP7dTVqgrA9spKX2iW+TXewntxaWJB1vBYl3Sv4lAE1i0bOzxsLyPr6Zz0H5lEP6kEQ87PPNVKH19LXMzo7e8JVqMclYSPAYl4stiNyW4y/vwLNbGn643J/9eFjJujgT7wcEB1fjV0ryy8K84tD3dBgMLZaweuerSU3fO4NPWOs5CJDkgwE+erAFxOJT+xckt9d6J6iGBi7qR4pBarlRHvxX/ryCPwzWet96IqA4+FzZ8oKSgSqRKKUbFcnEURaRMGQzei9Xh4Hj1rHRipP3HznVOPHBmoaN8zHVxKFy6q/QRG7hdOW/7vrMzP2Pc3qQMeMR9MbbG8R8IAHtqc4W8Wq+vrpw57mqXerVr4dJ0mIcTtEKewdl5zdlbxslxFnBhexfTOVka7HB6iXh6hvdkr/q2GMDK0g/OdgYgA5DFEe/s28O/rVIfeVSAW3ol1oZl8/4uQ0zYbKgBcJ1/IneR7+HLZVCPaWZHH1dfRhHX7QKEHUqKc1OQRHDqBqcWgdI2HhaNbmaOWmxaMqZL1TR323w9L7xQlHg/UpB1FPk+QKc3UtgsOxsDTlLB22hbh5x/UmJZ+wpwI746O5XxIchOix+2VFxEXEhXuMluzDLTowZtqIk+fJVbAXpwtPzNT6lIaT7Mhsj/HriRyzoQ==
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 10:34:29.6539 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55418cef-422b-4e0c-4926-08de5f21fbe2
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509FF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6654
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



On 1/16/26 19:57, Patrice Chotard wrote:
> Commit fdb1bffe2827 ("clk: scmi: Postpone clock name resolution")
> is breaking boot for STM32MP1/STM32MP2 family board.
> 
> The issue is due to registering clock with default name "scmi-%zu".
> If one of these clocks has children clocks, it will generate an error
> when trying to register their child's clocks as shown below:
> 
> ...
> clk_register: failed to get ck_axi device (parent of qspi_k)
> clk_register: failed to get pll4_p device (parent of spi2_k)
> clk_register: failed to get pll4_p device (parent of spi3_k)
> clk_register: failed to get ck_hsi device (parent of usart3_k)
> clk_register: failed to get ck_hsi device (parent of uart5_k)
> clk_register: failed to get ck_hsi device (parent of uart7_k)
> ...
> 
> Clock management update for STM32MP13 and STM32MP25 SoCs family
> to no longer use clock name to establish relationship between
> parent and child clocks.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
> Changes in v4:
> - Fix data abort in clk_stm32_resolve_clk_name() during SPL boot.
> - Link to v3: https://lore.kernel.org/r/20251215-restore_boot_for_stm32mp13_stm32mp25_boards_v2-v3-0-d055da246e55@foss.st.com
> 
> Changes in v3:
> - Rework clock management for STM32MP13/2
> - Link to v2: https://lore.kernel.org/r/20251211-restore_boot_for_stm32mp13_stm32mp25_boards_v2-v2-0-44e6e7de2beb@foss.st.com
> 
> ---
> Patrice Chotard (3):
>       clk: stm32mp13: Reorder include files
>       ARM: dts: stm32: Add SCMI clocks in rcc node for stm32mp131.dtsi
>       clk: stm32: Update clock management for STM32MP13/25
> 
>  arch/arm/dts/stm32mp13-u-boot.dtsi |  27 +++
>  drivers/clk/stm32/clk-stm32-core.c | 116 ++++++++--
>  drivers/clk/stm32/clk-stm32-core.h |  42 ++--
>  drivers/clk/stm32/clk-stm32mp13.c  | 441 +++++++++++++++++++++++++------------
>  drivers/clk/stm32/clk-stm32mp25.c  | 405 +++++++++++++++++++++-------------
>  5 files changed, 709 insertions(+), 322 deletions(-)
> ---
> base-commit: 1da640cc46ad84efb57bb45e02dd6c40265b5488
> change-id: 20251211-restore_boot_for_stm32mp13_stm32mp25_boards_v2-e7497f503414
> 
> Best regards,

For the whole series

Applied to u-boot-stm32/master

Thanks
Patrice
