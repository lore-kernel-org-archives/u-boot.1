Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB85E9B249
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 10:33:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30E3283DCB;
	Tue, 24 Feb 2026 11:33:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="kzaCkgQ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C90C783E1E; Tue, 24 Feb 2026 11:33:09 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E142283DCB
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 11:33:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.delaunay@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T6reziqEOby53Z709hD5rH8yJOQxcFcQ2gqoXeab3YocFZlcNX7usCuEXeq+8PF6/jLdAXPSFPMClrIuXHxBgnwAE7oNWojQbJ3m5tlx4CfvkbrBY7isa7vHfDrfqC7zpqKhRNk1L7nssS9MfYiqk84cvkW1oDTDY3vtuM9kMmk0IwwjYSZQvIdwNvlQv2LPsnZhy8PX4IXzDOIiMXA5WtaKTu+Wz8Hg6MXA+T4gzrryU+/tyaWC3ieB0qS/pOKCCEfJl1UroUjBR3gFH/t/aRnjyw0WBjaJO6F2AX52PiVpMlDwQpo0UU2SjocPzPRwZvYgYHvQ44Fb7okzKGE7WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lU//DFrTM+ZZyL33d6aLU6RJVC5lG4K8eyXmLWUVOPE=;
 b=VeleTyyxBFyKUjuNVq6mTxYedtDc5idCy4dCYG6av8hUT7XojoAyUBiES67i3WvkcslBD+YUUiK7biSu81Ud5+dRLD9Awywi4OJKA4utlqf4q8xmgj+wczFlOsa0Ogt875JPvdYinmNLeStW926UqQ+aL7VH36TBMg61P+ZCk2xwkuTFszIipjNlAcpilVOXedkEaki0ZyhRwzDF2DDHzAtcBzWDixzQEDAtN/i8sdhcqC7ejyn2NecqzU3dVJWFEWKmqQqGx/gmb4axgoOMqRAmh23ONOSE1Hwk0tVLVOcPhdaqPa1iW03BmPvcaT3FmiNGU4vLAnuvADWlOwDfZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lU//DFrTM+ZZyL33d6aLU6RJVC5lG4K8eyXmLWUVOPE=;
 b=kzaCkgQ+5sudw/TCockF1W/qfg1YS28R20O5tRIyAmirDQHaya/EcsUOv725PA68036e3RMqptGFWomxT3dnTRCxj8GKvnda4y/jXA7+N1ATXhP+O9u3fjsaPAn089Kx4nvFiXADStg270cTfmEMVTNXcM5q+3vNsoy1uufAGDVHt1evdtLv36riEdLSD7Wa6GrErEQMxat0FQAU7LdtV+JdWZ6tftiXPi1AfPvOMYfmni9rpwlREDgRj+MjkMES7xb5k334f8ltlWvxacbFPB2ZxNCesT4XxU8HhnAfjT4D4D1MnqZ3HA6PjpQGM4ejezUklwF7KN6fmLwyVWfNEg==
Received: from AS4P190CA0033.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d1::13)
 by DU0PR10MB7262.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:449::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 10:33:04 +0000
Received: from AMS0EPF000001B4.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d1:cafe::f9) by AS4P190CA0033.outlook.office365.com
 (2603:10a6:20b:5d1::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 10:33:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS0EPF000001B4.mail.protection.outlook.com (10.167.16.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 10:33:03 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 11:35:08 +0100
Received: from [10.48.87.244] (10.48.87.244) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 24 Feb
 2026 11:33:01 +0100
Message-ID: <eda61827-deb2-47e1-8a22-8ef7ed2e0011@foss.st.com>
Date: Tue, 24 Feb 2026 11:33:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] ARM: stm32mp: Fix CID and semaphore check
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>
References: <20260210-upstream_rifsc_update-v1-0-74c813fa4862@foss.st.com>
 <20260210-upstream_rifsc_update-v1-3-74c813fa4862@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20260210-upstream_rifsc_update-v1-3-74c813fa4862@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.244]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B4:EE_|DU0PR10MB7262:EE_
X-MS-Office365-Filtering-Correlation-Id: ab6ccf77-952f-45df-8bc5-08de73901739
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cm8raTlZNUg5UFVJclVvVlE4WDFWUXl4djFIcUlTUmpYRDZxVE92WUxXYVJM?=
 =?utf-8?B?RG9JR2YyeHBFZGltY2lTZy9QbmNTNGIxalhhL1BsUlZESGN2ZGVqdWxJUlMv?=
 =?utf-8?B?N3BSc2NnYVNBK095ZnBGcDU2UEFyRDZaRzVUSVNSZ1ZMNXk0bmZkcHZnMG9q?=
 =?utf-8?B?djdodUtmZ2pnOCtEUFlES0FPOWlXNHoxT1ZQeHZTL3BLSldTZE1ERGhudkQv?=
 =?utf-8?B?eEdNdnQ1OFA5dGhjczB5NjRXaUd1K0NRMHdPcTNmTU1qVEpqSUpCNTByQkRm?=
 =?utf-8?B?OVR2cEtiUXpGU0k3YmlHcWtwOHJtUVVzYXp1dHhRTFNMdFRyby9Da2ZJYUVV?=
 =?utf-8?B?bk53UFhNNndIVS9uMlovZWRwQ0ZYbmQzbVo5dXEzZnFDRjU2WHJ0ZU9KVTg0?=
 =?utf-8?B?YnZGK1RvRVNTVjdBME1vQnhYcHhDK3pWMzJMUkFSNy9OeXAycTM5bHU3bVJW?=
 =?utf-8?B?RGdQRU93aldOY2FXa214Z3BFZmN1bDZvRG1KWFdiTmZHNlVuWHF5U1paTGJI?=
 =?utf-8?B?NDMvbTNhSHJLSUoyTkxySk13NTJoOWRXbWdESHJqOEYvUDBBNHl6ckUvOE8y?=
 =?utf-8?B?ZVJIR3pzajM1R1FueGcrakRESnRQd1RDQVB4Y05BSnFjV3dSQmlxWTJXcE9v?=
 =?utf-8?B?Y1Z6S3RhYUsrT01peTRzdk5QaEhQTE1DR2h2d2hGdWl5TndTUURQSklGN0hy?=
 =?utf-8?B?NFJaU2NUV1BTVzZtWHl4dG1jSzVhWTFNTng2VllDb0JsWUROYVdseFFhZHRZ?=
 =?utf-8?B?N3c2L3VWT0UwSWFXT0V2RWhFL0o0eG5FT2NEZmxLSHFEUlBHTkNHRFNYU091?=
 =?utf-8?B?M29paXpDbWM2cGIzL0habWMzSGFoc0ZVZnUzREJqODdGb2FuMk5LSHpIMExq?=
 =?utf-8?B?Qnl2b0JUa2l1T1BqVnQ5TU5TNmdWd2FabUQ0aWcveVgrWUZPdlVrM1k0cHpm?=
 =?utf-8?B?QkxpY1M4bWJuTUxVMUpHK2ZlbkJoc3hoTC9iSXM2UmE5aCtiSGxvZW1HcjZK?=
 =?utf-8?B?RnhvWW1QOWhTdXV4cmlWMHZBT3VtWXRwcFZyYUVlQm9YVlE5Wko1aWpyQ0Jj?=
 =?utf-8?B?dUdybDBwZkNUaUxwSkxtRkw3aytxb2dTcmlxNGszbUExcm81K1NwQk1mMVF0?=
 =?utf-8?B?bzNXd2pBUEkvdWRKYk55VmZLTVREbDR6bEFrOWMrYVcwWjZRQUFHOCt0Njdq?=
 =?utf-8?B?T1NMS3ZKdjlzckp4M0NlZ2JoeFZndklnbjVYbkxxL2lSUHJVYTVJZlhqOGF3?=
 =?utf-8?B?eXo5RSszWmRkZXJFV01EYUNrN1dwaCtEVFA2UkIwRm80NWZXNm0rbThUNHNs?=
 =?utf-8?B?Sms1dEZGbGZ5TVdJdC82SER1M1JvM3FlR0NoVWFQQkl1djBMcmpIRWZ4M21i?=
 =?utf-8?B?ODdsQUxSZVJBSi8zLzQxbWNyL283b3ovSlRUbGhySGtpUE01dkNaSHdZN1cx?=
 =?utf-8?B?Q21GdmVtU2M3SWlOWkZVUy9lWlUrY2FodnBzdDdPOFJ3T1k0L1dUaXZEa1Vu?=
 =?utf-8?B?cmhReHEyejNUQjhoUFpLMFVwbUVsa1JjQWdsTXNzNnVPOWtYZThTaDkxVWta?=
 =?utf-8?B?aCs5SEtwZUwydkM1aDVqWWNpVHZ5Sm84MWEydHNwd0dFazJCZFNXVjNiWU5z?=
 =?utf-8?B?L0xNc3I0U3FDUWtQVlQwMGdNVVlaMWErQ29RRFRVK1lycGhBcG5BSWlmc2p5?=
 =?utf-8?B?bUZXQlBzMWxNVkdXWkRMdU5HWlpycmJOd1RIc0k2ZVhLa25VZnhkV2lVcjNo?=
 =?utf-8?B?YmZVdEZaRTFZQkxldElDQUV5ekQ5Zm1zd0hWRW9USVc0VXh0RVZLWjUxcVI4?=
 =?utf-8?B?QXpBb2pxSG5kclRVaWp1TTdSNU9YelhMWXk2ZFI1STZxU24xK01oOUdSUVVH?=
 =?utf-8?B?eDFzOUtHQm1zWC9lSUFhR2NDRVdGV1VoYVBKVDc4ZmtjT0MxWTcvQWg1TlZq?=
 =?utf-8?B?RE9aQWJUOUloQVo4eXM5NGxXYkNXOGw1TTVsWDZoZGlscFJmVDYySDVMWWtV?=
 =?utf-8?B?UEMyYTZzR0hPbG9tc0JVZWkrMnlXckx5ZVRId3JYSXgydFNtYTZ0V29wYVRK?=
 =?utf-8?B?VHBuekVxdm1pY0JiSEhHazk3bmJqOVVjeFhsNTFDdXV3NXNyWnRoSnFwc0Uz?=
 =?utf-8?B?MkhJbGQraHhBQlhtZHJ6RG43OXQ4Mmd2SUsyRTRoSG5uMUtFWjRqSkFhTHUr?=
 =?utf-8?B?RDdHS3hhYW1CU1Y2SkF2K2wzM1E4K0RhemYvd01Dd1YyYjVLSzlXNUFiSjFV?=
 =?utf-8?B?Ni9kNGlyWUsybEZzZnpIYkEzcUNBPT0=?=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3VxdelCzucWNjI61t4dI+Bvg6CFpmlDG8+rpbbR+E5lgWDcnxQ5am8E5eGw7YWhKj1fsvIZUShQIYFnQivbodUAN8xf0NTCx0hknbgC+kwNCpKKz+1WLUGV3JfCoUX33D4Sc3an6Zwq4YEnH3G2WXPdimGOBlb7J5nKVAtq3Xz8zq7tePJfTa/nlMF+e8K5Ga1cLxlWrMbHLI1md8mfEWYGdFixHtDpcHYhbNNaOUM1EbS2VGkSRqjkpA5wPnwZ6FzVifrtYHqTWk0BDilrGlPL1kq5BJnUAAPi0i2Ik+/vbfEbkrKNrqE8DzQl9fFQF9zKZpBbuqFR8Yad0OXQUNln18+Gc479ikhynJkAJlDPKzO1FUoT9+3oRcssw9gzZnkyssdPrA92ZbAFjayYecO/f9s8JbjnXka1my89ZJMfwXsuKXxTD0pnQ3Y8W+oZE
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 10:33:03.4421 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab6ccf77-952f-45df-8bc5-08de73901739
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001B4.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7262
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

Hi,

On 2/10/26 11:26, Patrice Chotard wrote:
> From: Gatien Chevallier <gatien.chevallier@foss.st.com>
>
> Peripheral holding CID0 cannot be accessed, remove this completely
> incorrect check. While there, fix and simplify the semaphore checking
> that should be performed when the CID filtering is enabled.
>
> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>   arch/arm/mach-stm32mp/stm32mp2/rifsc.c | 24 +++++-------------------
>   1 file changed, 5 insertions(+), 19 deletions(-)


Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick


