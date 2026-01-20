Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D36D2ECF7
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 08:34:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D069C83A2D;
	Tue, 20 Jan 2026 09:34:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jflNA4Mw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EB9B83A6A; Tue, 20 Jan 2026 09:34:05 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BB45839E8
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 09:34:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=baNqLiqLu+FqT5I/QR/lPOnijea3tQSB9Ndhp2gXv051d6rMyWXf1877jys+STVUwuf5NLt7CJoh+YOnxvR9LxtngxvmZy2yRY9V3aX6O754l9qSTCfdEPAIggkCKGXJNqP2XjkDnKwCBVN96knzjvH+K5CIX0i6IdqWjdf29GRsncEV+d0ySHb0rAnxZlvYfmNvubFc01hXNZl1OBP5Lo63FAKbEcf6G41bSB37X4ufO/1b3fD3ZtYpMJprNkFIQ/vNcE/W4lLNZrPNexQ7bKMZbpcsX5IoVBqUeIK/1FttXHki2bi1NjqO3HeXjySndMNFjtXHTCeZFfum6wd+ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMHrJDXqWH7PEudfIcwrCk7+fYO5r5nEk/AvVUQUtUo=;
 b=YW0sBHIXNTLOu+VBiJdhz7sWkGOv2OsBldsBDvhFgbWBegVTc089+KubWBE2LdBbcb3VdcNz3gVPVKPRaAHA9L1pyHcZH52+LbDFjwJr/F8knrV4/ukaP5sY/l1qvaGfNZcz3a2ptzL6a1PzQN/hMm0XD54emPGwHC6WqcHMWyj8CErcaM/9NbkwaX/M1THLbhtTcxPdtOxyjwIIU5jW7CujzR6fuikJPR5QzmNranz3/h50o7MV9zvlGdgMIyj5pz43Q9MwpL5B7HOma4dwA9LhNVXBcCMkVxTY2pDXraFMz3dv3YxYooDBLTTNC6QtAKRPwCNzOWMPRjdQb1r0gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMHrJDXqWH7PEudfIcwrCk7+fYO5r5nEk/AvVUQUtUo=;
 b=jflNA4MwOgHFOoWAi7u/whVq51q+LaFa47vha+u1eroXHGEwAM8hZdZKgee/OA08HG80yBCs0Q9JjAnJ/RNvIvSgjkN5/hch1YFjtEIZzuMgbguHyk1kztkyYoEkj68e7qpLyQhTbVV7VCYDGWIPq6JA9umYV7YSimXJB4zC0Dw=
Received: from SJ0PR03CA0001.namprd03.prod.outlook.com (2603:10b6:a03:33a::6)
 by CYYPR10MB7676.namprd10.prod.outlook.com (2603:10b6:930:bd::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 08:34:00 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::93) by SJ0PR03CA0001.outlook.office365.com
 (2603:10b6:a03:33a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.11 via Frontend Transport; Tue,
 20 Jan 2026 08:34:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 08:34:00 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 02:33:59 -0600
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 02:33:59 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 20 Jan 2026 02:33:59 -0600
Received: from [172.24.235.200]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.235.200])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60K8XuA5766687;
 Tue, 20 Jan 2026 02:33:57 -0600
Message-ID: <5f31017b-cdd9-4aca-a84e-b5f4cfd9a1d5@ti.com>
Date: Tue, 20 Jan 2026 14:03:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] arm: dts: k3-am625-binman: Configure firewall for
 ATF/OPTEE
To: Suhaas Joshi <s-joshi@ti.com>, <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <s-tripathi1@ti.com>,
 <k-malarvizhi@ti.com>, <kamlesh@ti.com>, <vishalm@ti.com>
References: <20260112093643.885903-1-s-joshi@ti.com>
 <20260112093643.885903-3-s-joshi@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20260112093643.885903-3-s-joshi@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|CYYPR10MB7676:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b62e65d-f0ce-481f-734e-08de57fea919
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QmlWWmZweWg4WDZMZU16cGt6Wlo2a0puYnBoREJtY2tzdFduczFGRldCZHlw?=
 =?utf-8?B?NmJXNHFMNldBMytPYmRyeHpjNE5LeitqdnFVbVVKS2JtclBjMFBQczV6dkJq?=
 =?utf-8?B?Z0REdFdBSnVkUnMrditGTmovME1qUW5CL0NINk5LV1hTYUhLTFRiMFhiUk1G?=
 =?utf-8?B?T21QVWNsYjZCMU9IQjNsTTlYV0EycUUxNkl5MnNyRC9rcURoaHpGazNUQ0Jn?=
 =?utf-8?B?TWJzZkxsMHAwYkY5eUFDc3BGWmNEd2pSWjhEeWRqd1VSQXg2bzR5eUxiNjV6?=
 =?utf-8?B?LzBNdGJmWjJQd2ZKVjdjWmFTRXBjbkR0RERNWENLbTJkUUw5Z1ZYckNpLzhE?=
 =?utf-8?B?djdna2pHbVlqNE80WkZva2UySTlRTUlEaEptOU5MTFJOU3lJUWlnQWxnanRR?=
 =?utf-8?B?eThyMGRhU1VUa29UOEVlVVFiem1qUG1vM2hZT0hFYkVHcXhOeklRaXArSTB1?=
 =?utf-8?B?WmM5eXBqUkRFTVNJYVhBWUZSMHdwZVQ0OFVhQVJLN2NXcnZnUnBLTDVqRzYw?=
 =?utf-8?B?TC9wS2IvcVRORnlWRjhnZzU1SHcyS3Nac0h4c2NZcWROVUJQTHBKQU5RK01Y?=
 =?utf-8?B?VVZIeFNyTE10cmNxdUYraDVKdVMzOG1SVStRN2tpVjgyREhaajVhTTZOVE9q?=
 =?utf-8?B?R2RyRU5FS2pkL1REdnliaERYSmp2eDZBRGducE5vZERPNkpub3NnKzM2V05T?=
 =?utf-8?B?KzVBWGRtMStpc0RMNDNnYjJwWEpKbU1VbzhVck9wSU8ram44cDFnSng0Qjk2?=
 =?utf-8?B?Qkk4RC9UTnJnVSt5V1dlbk9ycUxjYTVBdXNnMzJzVE9IVWluZmxaL21vandp?=
 =?utf-8?B?ZC91djl6MkZBV25vTEpzZENndjdQTWl3MlFtS2tmcGE2RjBPbzdCS3JIVnVS?=
 =?utf-8?B?S3hxbVcra0hWY1gyd0g0R2wvcnJVa3lMNDJiZlZ3dzZnQUs5TlAyQkk1K0Rw?=
 =?utf-8?B?S0hiSlRRdlQ3bXgzc1VQNzlxdGV0c1R6OERCbllzYTBxWXFvcXNPZCtPMFZM?=
 =?utf-8?B?VWRXdHNMb2FoV21UNks1TnFBREpTaEZCRWpubDh1aFRLMEVIQVh5VGdhRGw5?=
 =?utf-8?B?SzdkNHA3ZFpqeEtpTTZzM3UxV0RaNjhiMGoralFPUEhPQUl4dGh0b0dxQTdL?=
 =?utf-8?B?SFRYY2pTSVpTMWFWUEJjbFJURHJlZ2ptNFBwa2hwVXpXV09ReGVIaHdvK0pv?=
 =?utf-8?B?NEFZUmZDS1RRb1czNDArWjJYOGoyQTQ0dFhEQWhVQURRbW9YSEsxZUNFdks4?=
 =?utf-8?B?emFPc1FGLzJ6NDFkMy96SDFSVGJId1dnejZUeW5ldktNZ1BnM2NvVHJuNEFi?=
 =?utf-8?B?bGlCSHNkWFNNS3llVFlYNjhtamJtRE9QUnVQNEdTMVJhWnBERzEvT0taU29o?=
 =?utf-8?B?QUJSNWQ0R25ZY3pmaFNianEwRmMvQ2w1YWlEbk9IaFRLZmZKMUpFaUNFUmYw?=
 =?utf-8?B?b2dRbWdodXU4YloyK1hQQXhWaWpTTGN1YUxNeUZMc3R5czNSMEUrSGtuM1Na?=
 =?utf-8?B?ZURQWUcwVFlQN0Jac2I5TXpPRTg0WGJDdUpKcjB2amJMclgvRzZMN2tOVlBF?=
 =?utf-8?B?Ulo1SStjTWNmdC84bUxBVVg2UlNEL1J0RjN2RWRGZklmeTdEd0Z0Z205QzdH?=
 =?utf-8?B?YTVVVWZiSFV2dzNkUGZqaTVNKzkzVjFRY0ZaSFN2OUZGenBzeitPSDVGSHE3?=
 =?utf-8?B?b08yQzNEZGpXVGJMNTBFZHJFWHJOd3hOYis1eGowN0xCOUtqZDhWTVFxZFVQ?=
 =?utf-8?B?NDdubnM0Rk1iK3MzUGxaMkRmTWJGaW0wdW5zN3IxZERzSklEellyTEtKQ2VQ?=
 =?utf-8?B?TjA3ZHlVOENSTW1Xc0NYUkh4VU8zc29tVmVpUGtWSGtGcjMwbjNTdzhRVzZp?=
 =?utf-8?B?c29pOVJQN2xUQkxYL0ttTGxSMHdVV2d6YmZ5c2d4Q2VnNDlISnJhTXVIcnAv?=
 =?utf-8?B?aGFlZlQrWFppVUk4SlE5NUtNT25Jemxjc3A5M3lNUjdDMUUxT0pyRUlOckNo?=
 =?utf-8?B?cU9TR1V6OTFxV29mVWZ3dU1yUmJKS0NKOW44bXArZCtCK3U2TFc2dmtST2hH?=
 =?utf-8?B?UWs0QkpVQlZlSzV0emlFRzdXMGdwRjQ3eWpWanlxZXgxdGFyRVIrd2hxUkZw?=
 =?utf-8?B?am0wU2hmNDZkSk9WOGt2TTZnL1JoMHdMUElaZUhYQU45SUY3SWpzUVphN3JB?=
 =?utf-8?B?cGVrNC9PSUtML1FZTDAwWUFXSnFkVlJkcXhaR0ZCdkdBUUxHODNWY2xPdVJ3?=
 =?utf-8?B?Z0FmYSs5eVBLSUV5TkprYzdnYmp3PT0=?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 08:34:00.2272 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b62e65d-f0ce-481f-734e-08de57fea919
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7676
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

On 12/01/26 15:06, Suhaas Joshi wrote:
> Add firewall configurations to protect ATF and OP-TEE memory regions
> from non-secure reads and writes in AM62x.
> 
> Signed-off-by: Suhaas Joshi <s-joshi@ti.com>
> ---
>  arch/arm/dts/k3-am625-sk-binman.dtsi | 30 ++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm/dts/k3-am625-sk-binman.dtsi b/arch/arm/dts/k3-am625-sk-binman.dtsi
> index 42edb35fa7b..a1ac1f52c94 100644
> --- a/arch/arm/dts/k3-am625-sk-binman.dtsi
> +++ b/arch/arm/dts/k3-am625-sk-binman.dtsi
> @@ -276,6 +276,36 @@
>  		fit {
>  			images {
>  

nitpick: no need for empty line here
> +				atf {
> +					ti-secure {
> +						auth-in-place = <0xa02>;
> +
> +						firewall-1-0 {
> +							insert-template = <&firewall_bg_3>;
> +							id = <1>;
> +							region = <0>;
> +						};
> +
> +						firewall-1-1 {
> +							insert-template = <&firewall_armv8_atf_fg>;
> +							id = <1>;
> +							region = <1>;
> +						};
> +					};
> +				};
> +
> +				tee {
> +					ti-secure {
> +						auth-in-place = <0xa02>;
> +
> +						firewall-1-2 {
> +							insert-template = <&firewall_armv8_optee_fg>;
> +							id = <1>;
> +							region = <2>;
> +						};
> +					};
> +				};
> +
>  				tifsstub-hs {
>  					description = "TIFSSTUB";
>  					type = "firmware";

-- 
Thanking You
Neha Malcom Francis

