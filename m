Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFC5CD13D3
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 17:29:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19532803C6;
	Thu, 30 Apr 2026 19:29:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="f4JgkP9o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0248C83693; Thu, 30 Apr 2026 19:29:01 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF64F80086
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 19:28:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+dlYI5gNIkHdtIY/Z6YGLquzczaZSQB+pq2OFPKVGB+2eGUAMTLs+lcqqNCeYBy2Zgt6dQW3fGF/7RbT+aAx9Z++rDM6Azdd7NJ+/evm+Upcp9yywabwmuvIs1XWqbe1zZuefyfnch0cAtnvjinpMHX387c8pTPtMAkX/d6PrBI98gGWtnvP4n/5+oLw41XykWmcJS0gRUTE9Ptv83QPiudshlJfHBxdpHzRIszdrYQgRaNBM+5niIgmq3KUh1WhfSz8jGcFYglxWU8DHsMaSUvlZiNCCr0Zw1qY0/yeU1Nu9FNgIaY/g5CG6Y2H8NiiS0pBSp1W7yz9TX6dCFSEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFpJtU6flT8fQxqopAvSINQwpn0byQXGVPRtO8rSLuk=;
 b=QqvY429YDB4sBCkduNZdkmed1DNSpDC5QlgcRW//8ueXUhiNw9RRWlnVDEPdwV5xIPBxBOWUw2Lo15HClrzSHuXg5vlka4XKSUQCvvkA3vK7JN42jQ7FfpaOgHekyWwl0Z+jWYPCkp3OHrMUW/zlMZ8YiVOxsjcJhXZz1cu0X5Sd1ek4d0hTfp/xNyJ2kFu6aJ6OQiHmDPUfp+4TwvkZE9pxNbLoYmsgniXl652kmmdTUjxNT6Qg0jhR08zLNBYcnK0uJOhBcp2VNdEwsgicglBU7tgzlyJIoKRcV+hjwIKW78kFTbRUr4LMhzOY+dUynYxyvCL37XVrgyHF5bqazw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFpJtU6flT8fQxqopAvSINQwpn0byQXGVPRtO8rSLuk=;
 b=f4JgkP9oJYMWS2Osq9G2MtqLSZODWVibfkkFIhfK1aohvmGRuE4OeEM9I/A8pUa/ttrOtqLxLd2yitknE8XglFrEmqnGzHv89z21tA3tBw/6BudfrM676powKrwAKffsvd/sTA7spwKQ5ea7JdU4LwGcEfs8okT12QaJtTNnKEg=
Received: from BN0PR04CA0122.namprd04.prod.outlook.com (2603:10b6:408:ed::7)
 by DM6PR10MB4283.namprd10.prod.outlook.com (2603:10b6:5:219::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 17:28:54 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:408:ed:cafe::95) by BN0PR04CA0122.outlook.office365.com
 (2603:10b6:408:ed::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.21 via Frontend Transport; Thu,
 30 Apr 2026 17:28:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.22 via Frontend Transport; Thu, 30 Apr 2026 17:28:53 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 12:28:52 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 12:28:48 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Apr 2026 12:28:48 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63UHSlg01596095;
 Thu, 30 Apr 2026 12:28:47 -0500
Message-ID: <af7ef143-2bfb-424c-b1cf-a49fc02f9192@ti.com>
Date: Thu, 30 Apr 2026 12:28:47 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/20] arm: dts: k3-j7200: Extend firewall for ATF region
 to TIFS
To: "Richard Genoud (TI)" <richard.genoud@bootlin.com>, Tom Rini
 <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof
 <bb@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary
 <j-choudhary@ti.com>, Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>
CC: Markus Schneider-Pargmann <msp@baylibre.com>, Udit Kumar
 <u-kumar1@ti.com>, Abhash Kumar <a-kumar2@ti.com>, Thomas Richard
 <thomas.richard@bootlin.com>, Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, <u-boot@lists.denx.de>
References: <20260430084414.1354490-1-richard.genoud@bootlin.com>
 <20260430084414.1354490-21-richard.genoud@bootlin.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20260430084414.1354490-21-richard.genoud@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|DM6PR10MB4283:EE_
X-MS-Office365-Filtering-Correlation-Id: 64c490d7-f40e-4880-6add-08dea6ddf36c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: bl23ntVJGlgXD6p7B02l1H+B7RGzfPyt2qmjlERbe1LZTwAbyIGh3RW24taGS0WwhppcVp6Ir9I0pbHzRTfV5LLPMymf9vSyvs4oTfrXRn2uTnSVuJ/Ek6z9PZ0M2ScTPa0gmkd9G99c4P824QR05GHiSKIY7MVqiqq7uaEkTgXdd2M0DMZ+Xjy7aVpFVjWiIQRuwtOjEj1dOugQfgn8g6I14WD13NVBUJPaDu670yEYaWbzRrfWMWd4mRxjMdSlVC2+3pJ/rbtujFR06mpBojz+4qxjVv/fJHkf1xaAdugPcM0UTBHThUBJL/XXwHPSDxoaDYpYxEr6jHtE6MGo+XdCjHSY8xC3lpe8W3GEsJ0g7g2j8/OQChAoUluCZytVzU6KyBPJEYv0jSIyNGLE3BoX/7ngQoD8ffF1P0rA4AfwjMOC43VppL4k8PeblzZcgPxGDKMXyqFnyTzaHt/at1tnQmtF+Pqe3Shd2LvVqX8mfAl4J0ree7GCfANj3sgZra9WSjWcLx+rhRNmf76w8u0cTSkqeYy9/Waqtfrk/xmj6d4OvYupLPw68XNj/w2JVlMge83flKWci1ocdqd5QljHSb1dSmKSrOj4zRJ1xZ6BL0i16KNyhcmNVGeLAL7EhdQMK3G45eWg6Z95jxYHmajEByk/CEyEbriSguzsAl8SDgzkskXUtabf+frTdlB4z5dFVdQXGch4hNImKVEYnTiImpf2t4qi0ZK7lkAw+2XDBxsgGUkw1U/xqMnVUPkqGw/uAiIq3GiD5nk++pq56A==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(921020)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: drPmxSoR3EuaNFPGYrxHyfsDF4N3iKBOy8zluXwUk3rFWhUZQONZqdryDL2VyD0b18A8AckR+MfOH08+tDCYzDZw7MHz4P5ZOGEatvDa7ZchUjUEOnQcGk3vBPpQpdYYcyFOSBqojj2ZOcC6dUcdf/ZfbwBfAEqwONd4zlcz6WdOWjGrGYO/Pq7kNIPDS5dwFJ+e7CJmFudmxGIrE/dUdIkk2FvOxPJAYdLcwvuabiS0XxsMYqvD+aQgdK4qsktnUBAsofjF2D8WL03TqSZHu5EQbBcofkcO1F6JIanfxxnqicjPYzQZRMCvFky+sCk2MsrJDiJXOwsKVTXeSYt09g//7WNmigoct6Je0Qnaoe2ADwpVlB9WClocjQSVSsRowmQWX5WTy9WJ/UanBug68/hJtS3MSr3ZZ7RmbDf/4saqyu9KtSmVc/2qjDhOeLCx
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 17:28:53.3988 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c490d7-f40e-4880-6add-08dea6ddf36c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4283
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

On 4/30/26 3:44 AM, Richard Genoud (TI) wrote:
> From: Prasanth Babu Mantena <p-mantena@ti.com>
> 
> Extend the access to SRAM region of ATF to TIFS as well. This is
> needed for TIFS for encryption and decryption of ATF as a part of
> low power mode sequence. TIFS encrypts the ATF while entering into
> low power mode and decrypts it back while resuming back.
> So, giving permissions for TIFS to access this region.
> 
> Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
> ---
>   arch/arm/dts/k3-binman.dtsi       | 18 ++++++++++++++++--
>   arch/arm/dts/k3-j7200-binman.dtsi |  4 ++--
>   arch/arm/dts/k3-security.h        |  1 +
>   3 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
> index 0fd93f9536a2..4ffd8ec9e1c1 100644
> --- a/arch/arm/dts/k3-binman.dtsi
> +++ b/arch/arm/dts/k3-binman.dtsi
> @@ -479,7 +479,21 @@
>   		start_address = <0x0 CONFIG_K3_ATF_LOAD_ADDR>;
>   		end_address = <0x0 (CONFIG_K3_ATF_LOAD_ADDR + 0x1ffff)>;
>   	};
> -	firewall_armv8_optee_fg: template-8 {
> +	firewall_armv8_atf_tifs_fg: template-8 {
> +		control = <(FWCTRL_EN | FWCTRL_LOCK |
> +					FWCTRL_CACHE)>;
> +		permissions = <((FWPRIVID_ARMV8 << FWPRIVID_SHIFT) |
> +						FWPERM_SECURE_PRIV_RWCD |
> +						FWPERM_SECURE_USER_RWCD)>,
> +					<((FWPRIVID_TIFS << FWPRIVID_SHIFT) |
> +						FWPERM_SECURE_PRIV_RWCD |
> +						FWPERM_SECURE_USER_RWCD |
> +						FWPERM_NON_SECURE_PRIV_RWCD |
> +						FWPERM_NON_SECURE_USER_RWCD)>;
> +		start_address = <0x0 0x70000000>;

Should this be using CONFIG_K3_ATF_LOAD_ADDR like the other templates?

Might be easier to just update the existing `firewall_armv8_atf_fg`
template to also always allow TIFS. TIFS is the security root and
if it really wanted to it could just update firewalls to let itself
in, not like anything is really protected from TIFS to begin with.
(if we are not locking the firewalls that is)

Andrew

> +		end_address = <0x0 0x7001ffff>;
> +	};
> +	firewall_armv8_optee_fg: template-9 {
>   		control = <(FWCTRL_EN | FWCTRL_LOCK |
>   					FWCTRL_CACHE)>;
>   		permissions = <((FWPRIVID_ARMV8 << FWPRIVID_SHIFT) |
> @@ -489,7 +503,7 @@
>   		end_address = <0x0 (CONFIG_K3_OPTEE_LOAD_ADDR + 0x17fffff)>;
>   	};
>   
> -	ti_falcon_template: template-9 {
> +	ti_falcon_template: template-10 {
>   		filename = "tifalcon.bin";
>   		pad-byte = <0xff>;
>   
> diff --git a/arch/arm/dts/k3-j7200-binman.dtsi b/arch/arm/dts/k3-j7200-binman.dtsi
> index c2b86339d593..68ce4aa0ff12 100644
> --- a/arch/arm/dts/k3-j7200-binman.dtsi
> +++ b/arch/arm/dts/k3-j7200-binman.dtsi
> @@ -259,7 +259,7 @@
>   
>   						firewall-4760-1 {
>   							/* nb_slv0__mem0 Foreground Firewall */
> -							insert-template = <&firewall_armv8_atf_fg>;
> +							insert-template = <&firewall_armv8_atf_tifs_fg>;
>   							id = <4760>;
>   							region = <1>;
>   						};
> @@ -272,7 +272,7 @@
>   
>   						firewall-4761-1 {
>   							/* nb_slv1__mem0 Foreground Firewall */
> -							insert-template = <&firewall_armv8_atf_fg>;
> +							insert-template = <&firewall_armv8_atf_tifs_fg>;
>   							id = <4761>;
>   							region = <1>;
>   						};
> diff --git a/arch/arm/dts/k3-security.h b/arch/arm/dts/k3-security.h
> index 33609caa8fb5..3e066bca6ad7 100644
> --- a/arch/arm/dts/k3-security.h
> +++ b/arch/arm/dts/k3-security.h
> @@ -7,6 +7,7 @@
>   #define DTS_ARM64_TI_K3_FIREWALL_H
>   
>   #define FWPRIVID_ALL    0xc3
> +#define FWPRIVID_TIFS   0xca
>   #define FWPRIVID_ARMV8  1
>   #define FWPRIVID_SHIFT  16
>   

