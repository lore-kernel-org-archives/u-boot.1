Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB14D2ECF7
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 08:31:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62A0483A2D;
	Tue, 20 Jan 2026 09:31:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="p3tqKQCb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3D5683A3B; Tue, 20 Jan 2026 09:31:46 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E99C6839E8
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 09:31:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZPXYyvieDd5bwVR1MAmBVWpy/pJmN6Knt/sXEl554NfL8/JU8kCgw3CoeIiVs+eufWsjO/z3RGDOq6qikauS/PfYMmGF60YzTfDmp3Hvw3yyvLeQMNfhWfIC1o6hy+4s+mP3q992I71Lf38M8q52xxOGDDaJXpmcuyecmOA/+rBt4ngSvqqVOT4lF24DVNPNzssDQK7rp9kQMbhTA6pQohVc480U/u/HKYIFWDZQlLdKq5xhNSQCrtDZ9g9erO8p7jnQbJ1kpP1p6JDKAMSBvtcu/N44JTWPQilp50AI3tCF+WhFo3g2weJZutxILsurueKwS46DfEOhzP2rmxvxig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bay3I0L1tau3xs4oTS8mqn0QwVhNcVycOz+KNGy+Q/Q=;
 b=IXJ9+AHVuuZfygpo30JJiYf9RUntGgF3q3VspVw+zMsS5ILYK0viPGCWx5dTu2wKwuuN4cSpkU0mtW20tgZj6r20xf04nSt61XkMhgXgsBDcPgZZv+YCmqvWUKkdtjXuieMW+ltQuYLwoDMjomLWIPQvsNjNPnvZPeZ7R6TLdbrVHwfIpfjyWhykNditBdtSXlzsqCubYAWqFkk8ZqvU4cdfGBwiK3BOXYpG1tsos9fXEsRsqUAJmn1dqBom+OIuhJamRAdwU3Kfen8o1DAVlCzxU2t3sQiNW7ocXki7KA6tDWJluG+rsKYjzTvyVtXu0/0X/vkQBEPIerAbiqSx8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bay3I0L1tau3xs4oTS8mqn0QwVhNcVycOz+KNGy+Q/Q=;
 b=p3tqKQCbjEfFdEmY7D/RinEmdy+4nN+c8C5TdZfSRIJ3+8bY7f9+F+2bXWzpAWYvQwQ4mhWo09A/wL7RKeFtgJztl5GMUY4IgvxI4J5+pjR6G8tvCWCmJnFMLDxhtVsDMLKU7ikNIkAwt7mq91b2zoyETcVYOjiVlybYQu1ZO5Y=
Received: from DSZP220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::13) by
 CY8PR10MB6803.namprd10.prod.outlook.com (2603:10b6:930:9a::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.9; Tue, 20 Jan 2026 08:31:41 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:5:280:cafe::51) by DSZP220CA0003.outlook.office365.com
 (2603:10b6:5:280::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Tue,
 20 Jan 2026 08:31:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 08:31:39 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 02:31:27 -0600
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 02:31:27 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 20 Jan 2026 02:31:26 -0600
Received: from [172.24.235.200]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.235.200])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60K8VORW763758;
 Tue, 20 Jan 2026 02:31:24 -0600
Message-ID: <1df24684-644e-40f8-8f49-5387a9d21716@ti.com>
Date: Tue, 20 Jan 2026 14:01:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] arm: dts: k3-binman: Use configs for ATF/OPTEE
 addresses
To: Suhaas Joshi <s-joshi@ti.com>, <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <s-tripathi1@ti.com>,
 <k-malarvizhi@ti.com>, <kamlesh@ti.com>, <vishalm@ti.com>
References: <20260112093643.885903-1-s-joshi@ti.com>
 <20260112093643.885903-2-s-joshi@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20260112093643.885903-2-s-joshi@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|CY8PR10MB6803:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e897b53-e511-49e1-2dc3-08de57fe555c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dWd0MmZ0NFozOVo2ZFJvRUorK1JDSzZrbXh0Y1NJa21hVXVFREtFaEkyVzlJ?=
 =?utf-8?B?YUlUbjVEZFo2Z1RYeUFSMGxya2ZZdjBjZEdRbWg0UWlWeE1jQXNFekp2RXBx?=
 =?utf-8?B?TmVsQjFHMk9IRzc1VnJIeUoxdnBFWTZyUjgwbDYzUjZkRytxbHFJSU1tWW1y?=
 =?utf-8?B?UEFTdVZtd0U0QjlMQmZ5RFFnNWRjQVgxSDl0UldBYm9YL3FwNEZYdUo1TDRX?=
 =?utf-8?B?M3JJa1JYM0V3Z2FZTG80TnR2c2ZBa2dpdnNja1N4TW9Va1NUb004NDU0Tld1?=
 =?utf-8?B?KzByTmRoQ3R3ajVhYk5NblVlOWpCdEZqeDhkRzEwU2lob2lLMUUvblVnbWtw?=
 =?utf-8?B?T0RJUkRxVEQwaEtWcHh2MkFQUnpXL0ExaHpKazZvTEd2UG1oa0pYWmVsNXI1?=
 =?utf-8?B?U3RsSTZDVlZMNktmZEpHYWh6YzN2WmdtSG9iVjFqaUJLQ1F6SzlrUmtVR043?=
 =?utf-8?B?RGhyckhZcVRyb1prMFJoY1Z0V08yaFY5ejArU0lnc0U3dGZ0RFFyT2hkYWsw?=
 =?utf-8?B?SkpGRGhrUUVJVVBVeWR4OGRKTWxRWWdrZlB6eUZHNEUvY2xFOHJFSWFETnl6?=
 =?utf-8?B?R0o4RVNxM2szT05abW1mNCtnbW9CRXViQXJhY3I1ajdHL2x4Y2dSSVRQc3Jr?=
 =?utf-8?B?cnN0MEw2dkg4REQxSy9ZaDdVVmxpTFdaK0owenRaRTlMM3o4S3NEZG9hRmRM?=
 =?utf-8?B?Z3dpOVRGd3ZnT282L050UzQwN3pwc0FIYTVEK3VHVmtZTXdtSW5OMHlxTGZh?=
 =?utf-8?B?Q20rYzYyR0EvQUI2U1VQVjErc0Zrc29pa1VDR2diZzJzbEZCbzQvVDBYK1Na?=
 =?utf-8?B?NFJIQVhRQWpJNUFtRzZKWEVPampadlFWZlRtQWlERDNBU0JwY0p3ZWhJZGxH?=
 =?utf-8?B?STZhOGJJbXFYcERCckVNdVpSSEtoaWRaWW9OemEwTjJjMDZvVTdnMGNicGF0?=
 =?utf-8?B?RnkzazFtQUZUMFRXbE9xNjcwOGlsbENlQ3RFUE9FRUU5NnZZMHh2U1pjcity?=
 =?utf-8?B?MmVQajdPemk0ZjhuaEpJN3cvdGNUNFpOUmljRGFnY2RIMDd1YzJ1MkV2OU85?=
 =?utf-8?B?ME95Ky8zODVtcnNXVXRVV0xwN1VLVzltTW1hcmRlaGVqa0dDZDF3WXpZTFFi?=
 =?utf-8?B?dnV2TXlQRWovYmtjRjBiNjZmUnlISVdOdmp4Wlo4eThKNnZzWUp5KzhJNm9p?=
 =?utf-8?B?SXVjU3UzRzcxQTZUQXFrT2IrUHhrQ1ptanpoVEN3UnZacG9tcFlIbDgrOERK?=
 =?utf-8?B?SGlsUXBraWN1WlBXSUVhZ0hVNUN1RVJmVFZWQUYvdG9RTk43dE43VmU0bzRF?=
 =?utf-8?B?dC9DS3pweGNhYU12VERVRjB2OE1WeVpsMXJqQ3ExbmNlVHRMMWwwRnordGpI?=
 =?utf-8?B?UjN3MmxjSkZQMEowQkJOUEtiZ0pybVNFcnVRaXJHby81TUF0cWVTZFZKRUQ3?=
 =?utf-8?B?OHMwOXYrZkR1Rmw4Q1JMb3RTdVpiVjUxZEJEZzM1QSsxTG00eGVKbGlPaTIw?=
 =?utf-8?B?QVBNU1JoUkQ4VTR0TjdIeGtObW1HZTk2aVdNOUh5cExEVmF4alpyRlBHYTE1?=
 =?utf-8?B?d256Wm9ETjdVS2tqTHlHQjRMNFZXVjh5dmNselp4WVlhV2lNNm1WNGc5VUVM?=
 =?utf-8?B?c3ZpbnYrcU5PWVY5TmluWUhaY01UNXNWMnkzUE14Q0t0bmhnY0RLeWU4Tytm?=
 =?utf-8?B?cDhQbExaTldSbDgxbzZlN1pkMVRoSHU2SmNob09aVjd5M3pBMWVvMGF0aThK?=
 =?utf-8?B?eUN6Z0xVa256RTdnTWtXc1FNQ1k4MW8rdTlEb0lQT0NrTmR5RklYZ3ZiampO?=
 =?utf-8?B?c2NPbFc3Rk1lMGozRkl6cVozTDNCYzNoTXFEMUwrcG1ZekFyTnd5Vjd4SXhR?=
 =?utf-8?B?WU9QTWIzeGo1QVZMMkpzdDE0clA0WEJ3YnR5dXpneUFYYThRTVc2NWEySVlB?=
 =?utf-8?B?TzJhTTIxSXR0akFMdVpTa1JGdHBIdWk3YU1XbFBSVVh6Nk1Ya3JnK3ZSNUhN?=
 =?utf-8?B?NW4xVTFiQUZxRHFiNldKVlpyK3MvenBua1FBd0FMOG03bjlLSkVUdFZLVm42?=
 =?utf-8?B?NVRKQUFZMXFKTmRhZ2RuU3hNS1VDbHlkbXZDS1lISmMvU213KzBIdzBzL2dv?=
 =?utf-8?B?UEVYbVJsVi9tZjNwOTc4cGI3YlZIQjlYZ2xWcE1BbGN4ZUhVb0JsS0p6R0t3?=
 =?utf-8?B?ekFjdHJESWdWRmluZWcreFdZSi9Tc1FmZ3NlRjN3S05qVG1nTXhLTVhKNmdB?=
 =?utf-8?B?ODZhWGVHaHI1THNnVlZVNTZ0dVlBPT0=?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 08:31:39.7642 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e897b53-e511-49e1-2dc3-08de57fe555c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6803
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

Hi Suhaas

On 12/01/26 15:06, Suhaas Joshi wrote:
> Instead of hard-coding ATF and OPTEE addresses in firewall configuration
> templates, use K3_*_LOAD_ADDR. Doing so ensures that if someone moves
> ATF/OPTEE regions, the change gets picked up by binman without
> explicitly having to modify dts files.
> 
> Signed-off-by: Suhaas Joshi <s-joshi@ti.com>
> ---
>  arch/arm/dts/k3-binman.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
> index 761b1730464..0fd93f9536a 100644
> --- a/arch/arm/dts/k3-binman.dtsi
> +++ b/arch/arm/dts/k3-binman.dtsi
> @@ -476,8 +476,8 @@
>  		permissions = <((FWPRIVID_ARMV8 << FWPRIVID_SHIFT) |
>  						FWPERM_SECURE_PRIV_RWCD |
>  						FWPERM_SECURE_USER_RWCD)>;
> -		start_address = <0x0 0x70000000>;
> -		end_address = <0x0 0x7001ffff>;
> +		start_address = <0x0 CONFIG_K3_ATF_LOAD_ADDR>;
> +		end_address = <0x0 (CONFIG_K3_ATF_LOAD_ADDR + 0x1ffff)>;
>  	};
>  	firewall_armv8_optee_fg: template-8 {
>  		control = <(FWCTRL_EN | FWCTRL_LOCK |
> @@ -485,8 +485,8 @@
>  		permissions = <((FWPRIVID_ARMV8 << FWPRIVID_SHIFT) |
>  						FWPERM_SECURE_PRIV_RWCD |
>  						FWPERM_SECURE_USER_RWCD)>;
> -		start_address = <0x0 0x9e800000>;
> -		end_address = <0x0 0x9fffffff>;
> +		start_address = <0x0 CONFIG_K3_OPTEE_LOAD_ADDR>;
> +		end_address = <0x0 (CONFIG_K3_OPTEE_LOAD_ADDR + 0x17fffff)>;
>  	};
>  
>  	ti_falcon_template: template-9 {

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis

