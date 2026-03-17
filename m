Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F0FFFD8740
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 11:34:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51EE8841E2;
	Tue, 17 Mar 2026 12:34:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bmM6FwpC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C737841F7; Tue, 17 Mar 2026 12:34:41 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52132841D2
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 12:34:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-tripathi1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=niyFuW41SAR1uMjmlZYNnKBPOwa74WDcqst638cQNN7j+FsjdejHBGp1klUmf+z07OtLfnsf00MtWFwdNn0ZmnMezc0X42YKqoOrFSGR6JqvpYYgZ38zG5NFOauBtv3kSlFUm40Js1hpt176UgwCPYqGwvCi2wUwJdFrZifLxgd4/rKP8qQ4rtDCFLHPmiOCKKG6NGQ6gJ4AOSvMuDobaY1m+aByQCzZiCNpzWiQ+zl/YL3cft6gMUdZ8PzIQoR+sTSGOJiPqMmszgVU9f1x7+HPyJ9nqcvRoyy2A5qJo3t/rIuy2PbJG2QFus6927lVb+qqfRnAIYjYaNaRJIec2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Ub0f+2cT1U+PcsK1k+1Qhibtyx0ALJS+/3DsCzx8f4=;
 b=PsXfJHEX0S+LGuxZtAFS0vIUGvoeoz5G88o3hrM9p+Edl5Jre/G7H8m6PoeCYg+K+CTTUYLjn4F2XVHlBEXMg4t0NI6LfuiWFth0CE1Obm7lKhtJCxuCEcbewsuXreEgXDQMcGN6Ia9vtulDGLXyyj+XjiGo1FvNT8/YHPsKDLKSK9fH2aJUNontAKZ9DCJBEzwHgiqsSG5SW11QnarU9rqJGdfq6gG9xmB0hb9cEHEX513Rl3dqw/AxeMqk4kM0byyDUDz0934dNK5EHRSEF7TpJM64zjMe7GC7X66SQHRFiVt7rCoZa8CKPP7SQD/QGBcFQSxwBjda5vRkLzVqdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Ub0f+2cT1U+PcsK1k+1Qhibtyx0ALJS+/3DsCzx8f4=;
 b=bmM6FwpCJYR6Q3IvwzIiNPHfEr/degIycvW4dcA+2yHWfEdwxx/oB2Yh6NGIDeNMuujK/hpzyx1usbJMBrrtjUTbMKXf1J4ZFOum+KR0rlDtWVCANSZQ25X04gyA/lEMnr2uzOsBytlQwQ/BF5RUKoaHMp0l4hAD1FN2Ioo2V3s=
Received: from BN0PR04CA0169.namprd04.prod.outlook.com (2603:10b6:408:eb::24)
 by SJ0PR10MB4541.namprd10.prod.outlook.com (2603:10b6:a03:2db::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Tue, 17 Mar
 2026 11:34:34 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:eb:cafe::3) by BN0PR04CA0169.outlook.office365.com
 (2603:10b6:408:eb::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 11:34:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 11:34:33 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 06:34:33 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 06:34:33 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Mar 2026 06:34:33 -0500
Received: from [10.24.68.200] (hp-z2-tower-g9.dhcp.ti.com [10.24.68.200])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62HBYTAw2616915;
 Tue, 17 Mar 2026 06:34:30 -0500
Message-ID: <5e6a045c-5d5d-46e2-a7a1-1fd89ae64e3b@ti.com>
Date: Tue, 17 Mar 2026 17:04:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm: k3: Kconfig: Enable fTPM and RPMB support
To: Tom Rini <trini@konsulko.com>, <vigneshr@ti.com>, <bb@ti.com>
CC: <u-boot@lists.denx.de>, <u-kumar1@ti.com>, <praneeth@ti.com>,
 <kamlesh@ti.com>, <vishalm@ti.com>, <k-malarvizhi@ti.com>, <afd@ti.com>,
 <anshuld@ti.com>
References: <20260225112438.1035185-1-s-tripathi1@ti.com>
 <177317553318.23044.13643896894203476698.b4-ty@konsulko.com>
Content-Language: en-US
From: Shiva Tripathi <s-tripathi1@ti.com>
In-Reply-To: <177317553318.23044.13643896894203476698.b4-ty@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|SJ0PR10MB4541:EE_
X-MS-Office365-Filtering-Correlation-Id: f91c0689-3bdb-43ec-2b28-08de841929a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: OFHERx/xk0IZMvdB2mmVN76Mfj7nXu1nx8oK3h2ouHzcqbk1fzLuhsjLoyqv+qjGSmBuadqLKOouLtSBqNEj8SFN8Z1yAKNW5sXdsOr+9LZmdPl6EDgCJD8agkW+3FaprJLiEIS/Kn1PNAaMxWZbjf3IEHQvG8T/yiQ3V5vL2SopB73O/a1Bafj453dAIvj3V5x1OViMaEzK0sefqns4xFj6jZlvA4QR2oppjNl5CaztNst/kIgoBfLgDTTYyTqTnEeRtK+ZMDd9QhHuVxbfhhEgksfaemCJVcLeoqQuDj4V+LrxdOwjTO7NU30C5ii25eRk0hyP9Mt5nZvELLukSB/Dop5DV2FPa+otRfvlRm8I9mVGOe1jScEFoJstEwmrKpRsygtAYQUTEg3O72aeiJpoP5uQcBGFLX5368Asa7j5RReo1S3Ok94mxs9nQeK82vefsjolgxZwGEJGjsrEbbAUwE9SCbv9oVaP42AYNtlk6B6xp6xOx+J01FIi8rhgaNl66CAuY4FslVmdBir8vamkFAM5kGYbOcVACqvf7UM03RlN2ltFPh9bphN0Vbb85A1UENyk31l+PeFGOIlOgvubphx85PpnOoQZSItCe6X7uSqgW96lCxecBe3TM80T0EX0jXx1fEpAGHBx8KLD4cIeqE1ZVHGF6HALk4M2Hx6bLSY4zWWR1LQQndaiy/W9ohazKXE7hnbGnl7A3XxUSBWXsChXCm/IbIEFHxkXTeX4+WaFLcqIZCuXJ6N5v3vrw5FgmlVIHFQwRVwhAc1/d8Bu2LJqeM5ORznuWExS1/Q=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ki4XSs1w4APqfWuYVLo+Yzcj+qwz2ViqhdFB4hy4ieD5IihsKUrdONAaQ/LsMIeyxmcnG92fzbO1vzM2XUFwvk6VgUo/cpqsuYuRna2pnYM7dNspFUg60LbK3XbvVqU2qOdDU7koqk4WbpVnx+CRdlnw0aKB6uwJGITayiM2WPaRASJwp2MydFulQ3s6foboz8fHRhLMziyXFfWIZPt93dYSh1K0xkEFz5a1mb+U2VUufZDD9Sjk21pMz0JAtF1+8Q/tTIbceCo8q/HpZCQ/IEXfbe5RVPe+yYrFi0lttcHNDmX0HxKQOQ6T8ke/MRQtKXRdsjK49PeN2WqC8y/iDADj9bpU8zDrqH/+/l22u7kBcUYn+lCxFy+9kTvrkmZabD2ococv39C3lXNQDofpXUq7PG55s6dd3DSeDEsBS2Xtq11Tq9kCdfQXtkMKe1s2
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 11:34:33.9473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f91c0689-3bdb-43ec-2b28-08de841929a1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4541
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



On 3/11/26 02:15, Tom Rini wrote:
> On Wed, 25 Feb 2026 16:54:38 +0530, Shiva Tripathi wrote:
> 
>> Enable firmware TPM (fTPM) support via OP-TEE for K3 platforms with
>> MMC hardware. This provides TPM 2.0 functionality through
>> Microsoft's fTPM Trusted Application running in OP-TEE secure world,
>> using eMMC RPMB as persistent storage.
>>
>> fTPM support in U-Boot provides the foundation for measured boot
>> and disk encryption use cases.
>>
>> [...]
> 
> Applied to u-boot/next, thanks!

Hi Tom,

Thanks for applying the patch. Following are the steps to test these
(I'll soon update the relevant docs for this):

a. First step is to generate fTPM TA binary using ms-tpm-20-ref [1] and
optee_ftpm [2]. I have been using yocto to generate this fTPM TA Binary,
for reference, the binary I used [3].

b. Second step is to use above fTPM TA and build optee-os with RPMB and
early TA enabled:
  make -j$(nproc) \
       CROSS_COMPILE=arm-linux-gnueabihf- \
       CROSS_COMPILE64=aarch64-linux-gnu- \
       PLATFORM=k3 \
       PLATFORM_FLAVOR=am62x \
       CFG_ARM64_core=y \
       CFG_RPMB_FS=y \
       CFG_REE_FS=n \
       CFG_EARLY_TA=y \
       CFG_RPMB_ANNOUNCE_PROBE_CAP=n \

EARLY_TA_PATHS=/path/to/bc50d971-d4c9-42c4-82cb-343fb7f37896.stripped.elf

c. The optee binary can then be used to built final u-boot images,
testing logs for reference [4]

[1]: https://github.com/microsoft/ms-tpm-20-ref.git
[2]: https://github.com/OP-TEE/optee_ftpm.git
[3]:
https://github.com/shiva-ti/ftpm-binaries/blob/main/bc50d971-d4c9-42c4-82cb-343fb7f37896.stripped.elf
[4]: https://gist.github.com/shiva-ti/8ac6aded2bf0a3c9bd99627a45b50f6b

Thanks,
Shiva

> 
> [1/1] arm: k3: Kconfig: Enable fTPM and RPMB support
>       commit: 8bc2a5196c1c0bb5dbdaca073323da0015a0de37

