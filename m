Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A31FF60C6
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 06:04:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E71FB83EB3;
	Tue, 31 Mar 2026 08:04:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EkqH3ls5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F9E883F0A; Tue, 31 Mar 2026 08:04:49 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70E3783DA7
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 08:04:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rvx/ew5TcWM4wBfx/OSv6Gy6VQzj50BbESOrY5JEBfq7YBDo1/I9DMMxRYuBUX52l7iOaN5Er8BK+mra3zFB8usX/EaECc5mom8ntx8ePHzRVHLpPOp5xQal8FHP4MRIVd8Vxkpf+SXHH7heBlTLEAeBLMqGpfzvVmsZ+SQ1BWFqjciZ5dBNuCwE7ICBu94Vfk+QFMIslUHEzgEgWF9HeJ8hzLrpKfshRM7IL3xDzOiCLeN+0dKKgQD2ezzgpId9+3zpIsiTstQEqNWvHkh3Gzpj0F9DuBu3px5Eql5OILe5CLLrMoq+frY/22C6Pgs3MyZxgJVK3oBWpY4HkNlGbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3NhH9HfN0GJSDVLmb702O5p09Wd0N6D9UhMQHQw+zg=;
 b=Flz4zMOK0VvqQlatObb1JwqIajusPmCQ+ybHSkJuMxNVhltf/rVZZPARwJNUORbVYX5mTpwuyql7mmdujrntViRuTiSfb51K7wjYkwelvMib3GR+rpEkYYnq1WqnGixa5uXjZlVLwrsxapXo9wmGZ/ZF3Ub9xQlXRPDHEMJ/J2GiKfY+hwuFJvxD5zb3moWlSkjc/LZ53qH0VVKyzrghnzikUdEGSM26MpqC93KrfnDSAC0X5SgSC3pqS7E70EW18Sr3PmvHR0VAzOo6HnvFaVPRrll4K3Nv3K/TZERI7LZV35S0YGvICVtTKN/H2YKEcV/xEEncKzC8wZ3Mu7jCgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3NhH9HfN0GJSDVLmb702O5p09Wd0N6D9UhMQHQw+zg=;
 b=EkqH3ls5LOAn0bHU1XJhG3gcCIbwLaG4z7O79P2vOghF+VwYuyMsJb4JnbFoKy2coXhHMRnBe4mzddWZXk553yyGKO3aDRGeFLgiJjCe70ROS8vT5ZSmbj2zGHVohH7TsjFabjQQlTnRzuaNP4xtw75+gLs2I078j4zgTXJow1Y=
Received: from SJ0PR03CA0347.namprd03.prod.outlook.com (2603:10b6:a03:39c::22)
 by IA0PR10MB6844.namprd10.prod.outlook.com (2603:10b6:208:434::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 06:04:43 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:a03:39c:cafe::3b) by SJ0PR03CA0347.outlook.office365.com
 (2603:10b6:a03:39c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Tue,
 31 Mar 2026 06:04:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.0 via Frontend Transport; Tue, 31 Mar 2026 06:04:42 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 31 Mar
 2026 01:04:41 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 31 Mar
 2026 01:04:41 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 31 Mar 2026 01:04:41 -0500
Received: from [172.24.28.230] (lt5cg60819vj.dhcp.ti.com [172.24.28.230])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62V64cdm1731988;
 Tue, 31 Mar 2026 01:04:39 -0500
Message-ID: <c8a97353-0c3d-4d98-8252-c0bb91a658a5@ti.com>
Date: Tue, 31 Mar 2026 11:34:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm: Add ARMv8-M aarch32 support
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, <u-boot@lists.denx.de>
CC: Casey Connolly <casey.connolly@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "Jerome
 Forissier" <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>,
 <u-kumar1@ti.com>
References: <20260329231442.332359-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260329231442.332359-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|IA0PR10MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: 046c0c20-401d-46c5-ce41-08de8eeb66fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: BFJQiqubWL6eBhPVpkc92pX4mk1YE6VcbAHfCptyYIBtni0RYHwUU3suOeT89QxlNcMa4quvON5wDml6Xy6LlM5id0klLXMWMXGojbvKpcd+ELzrPkrYRJrk+QMWah3nooEzfEZvWDS9ccrIu5LqK5RuIMbAf0tirH3dx4g6dtN+flUxuN5kp47p19SBdLCnVOSQfrB5N55poGbCtzXrH4+mTdMGthc/KHvVgIrcDV7VJ4e55Uegbuycmnpz0rcL1JQjX2idzaXvYaTJ7F4P2kLIf7hHFSnv1xjhskINUInq5JD64LvwcvR1ptSxkCLurTtSPuKXQbm0a2FQjfVpatvwVXv+n5kEmL8zc5GFB4ViIhzqM2RvigZV94Gxc/LaaBuzDWbe7NtK7FxtiuoKRQOCgodD3FbsvFG/A4WTboPGofXQSN4l42txVfFg/uFEn+3QucGk5rXa+Fosad8gM1BDUZOi/ZH8sd7aB7GRb+g30FsBYLE6DpBSRtf/TypCqBaBMaYTf8IcsPPTGW3G/0eifU1daq79+xaJn+bx1Y53sEi+M/zFsZDGZE2PNLbDUhUtvxz0wdb5fDSYuAlCKiR/J9q3rOTYTI0llzWwOqEjar297fZ/MJsM6XZwxZCG38Xw1z4R4fWwB6/7V5NtHMNax2+VDz0MZqhvA0W6BV1fMZA1W+6T1L8myKofxvUN14XRC9Y5fGG4AF2fyccyeEQpBC8FdJPkcUjGcidNjdYINjYx/smNZFLB8MVnokguhX57f8/Unj6TNy3JLfITKg==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wPb3hlCFyRWDIQc8O79nV3lhyl1h2zPDN8yTkdqBy+bCf9DS9hu4WncEsAqKcFjidmTTB0Nt4au121NZi3kvakKoFMNXfoR6MHEHvclxlhnfmeLFO6MXoN0xUtK+r9d7gYSPQBZ9+4OLivllgDg/cr9VqjEB6j/7KiL+VTKkjLSS7N/eCsqOw9W1NByKl3xhr5RvD8ye/hwGnH6YUuSrf+x/j5Epl87Wd7oXSIuNkWwvWc0HfM4UgGQflKRpZdqKIY43R2ceJUIN6qLYG4GBYgn8KuZhgNGtDUS4liS38KVWFga1sZYyv7JL7nkV1Sfj8gAdKdZIpRpT0rdae8prLwiJUJ8APtxfPKA5Vh50KRgSUpY/nUuGLzrQDQkUjFENPLfJt5RaNuHG9GW1+QuQ3TqkfNe41v3iNqzDqqwer4x1RhB8TZ1gUbdy+apsfMyd
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 06:04:42.8266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 046c0c20-401d-46c5-ce41-08de8eeb66fc
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6844
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



On 3/30/2026 4:44 AM, Marek Vasut wrote:
> Add configuration for ARMv8-M aarch32 core, which are currently
> Cortex-M23/M33 cores. These cores are treated similar to ARMv7-M
> cores, except the code has to be compiled with matching compiler
> -march=armv8-m.main flag . These cores have no MMU, they have MPU,
> which is currently not configured.
> 
> Unlike ARMv7-M, these cores have 512 interrupt vectors. While the
> SYS_ARM_ARCH should be set to 8, it is set to 7 because all of the
> initialization code is built from from arch/arm/cpu/armv7m and not
> armv8. Furthermore, CONFIG_ARM64 must be disabled, although DTs
> for devices using these cores do come from arch/arm64/boot/dts .
> 
> To avoid excess duplication in Makefiles, introduce one new Kconfig
> symbol, CPU_V7M_V8M. The CPU_V7M_V8M cover both ARMv7-M and ARMv8-M
> cores.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Casey Connolly <casey.connolly@linaro.org>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Jerome Forissier <jerome.forissier@arm.com> <jerome@forissier.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Udit Kumar <u-kumar1@ti.com>
> Cc: u-boot@lists.denx.de
> ---
> V2: - Rename CPU_V78M to CPU_V7M_V8M
>     - Isolate V7M specific and otherwise option bits in cpu.c

Thanks for v2 Marek,
Apart of name of config discussion over v1 [0].

For changes,
Acked-by: Udit Kumar <u-kumar1@ti.com>

[0] :
https://lore.kernel.org/all/30108d25-efd6-4ff6-9bfe-0dc55670a83f@mailbox.org/


> ---
>  Makefile                         |  8 ++++++--
>  arch/arm/Kconfig                 | 15 +++++++++++++--
>  arch/arm/Makefile                |  2 ++
>  arch/arm/cpu/armv7m/cpu.c        | 10 ++++++++--
>  arch/arm/include/asm/armv7_mpu.h |  2 +-
>  arch/arm/include/asm/unified.h   |  2 +-
>  arch/arm/lib/Makefile            |  6 +++---
>  arch/arm/lib/bootm.c             |  2 +-
>  arch/arm/lib/crt0.S              |  2 +-
>  arch/arm/lib/relocate.S          |  4 ++--
>  arch/arm/lib/semihosting.S       |  2 +-
>  arch/arm/lib/vectors_m.S         |  6 +++++-
>  cmd/Kconfig                      |  2 +-
>  dts/Makefile                     |  4 ++++
>  lib/efi_selftest/Makefile        |  2 +-
> [..]

