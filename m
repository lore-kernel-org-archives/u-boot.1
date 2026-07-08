Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1185BC43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 04:02:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 665EB8497A;
	Wed,  8 Jul 2026 06:02:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PGuDN9kL";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xDW3p5fb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96FF08499C; Wed,  8 Jul 2026 06:02:56 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 828E9838D7
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 06:02:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667MaWb7633064; Tue, 7 Jul 2026 23:02:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=yZfJEiJIzvsoDI5wu+66PJeXmVAmZaW3ArYb6PdCi
 hA=; b=PGuDN9kLrAfEPP4LJ76RiZq5s3KrmWXRpr5NftsFWN0yvNWrlP4APJQPQ
 LuRX/iH3LQ9z61Nq6KrB8B6GfG7g4PIe5uNSi92gmlgkQvmMkECZVBl7AIM1QaO+
 fJ4lwwuUU1PHGrODKUHMJKpxIclSWNs98zgL5HDYZXwd3sn15XliK2FhCkrAFZNC
 tNNc6DoW2zJYjnByGbLKYz7S5iIkKoYOWld+4TS+DwbdtRn3cXxoVqTeYlffRbH1
 2h+ZnT9oCQlhZofRD1q2yzSCQ+2GR84cREXb19MO0/lTDR8MILxQvg+9RON2gP2M
 V6nGphD6Q1AFJUBNkBOozjVVYg8JQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011045.outbound.protection.outlook.com [52.101.52.45])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f90cb5x7u-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 23:02:52 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K+7UW5JyJwbG6sooYP2bmzsEcbQ1+/Gj9bQp5q6xDlFUFnZRVcDIk8vociKW17JdyZ5ZCdHef7spFX9Bwdm87F6Zte4S7vendo0tJzMG4JrhYscZ78cfAZZHWHqnCMh+ZjhUHUKMQl27fTy/8DorsjKCC6DNsZKQ9vOYpnJg03jkEjE9hxtNiH/4stOt9sNYjFTWFP0cAFWq7xXh9ayhWh5Tpe0mR+/eo5WpTBCpx/A4vGH4TocuG1N+7avSrj5CO/2jfLyYyNYdI2JMtbdGK4nEfN2AMPfrG4l4orxO6Y0n8Oh0bMZMHgoENdnwi1QAKUPaIcGvFGFXe2RDVYMsTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZfJEiJIzvsoDI5wu+66PJeXmVAmZaW3ArYb6PdCihA=;
 b=dlx3kC+9AtoEF6/nnHRGMUFoIRlYN9q60QZzVsTOTVXckOR6VPXZxwz/BRjO8AZM+Mdos4nxZ8S8LWQgcC1Lz1sYqHMRBms6k9aHq1FI9MgSzdydOyEGFaApHNhd7BxhpsAKWs/cI+OFR+zYuFFHyJqEVaIO0CYMA2IEFPy0I9wpubF1nAI5Nvr8E5lreUZQ/3jkyGLiW0aEey+CH/iDpjs5vZA+9kUofAAaEpjeCXhIsSeGoPZVIn04swRbKZ0K0rBcw3jRLcKiShrD+EOcioBsXStLNyLHjSu9/gPyFi7O23gjHaeeTPIkznuFExUuGlE6GuA4Mw2imTVGIRo9eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZfJEiJIzvsoDI5wu+66PJeXmVAmZaW3ArYb6PdCihA=;
 b=xDW3p5fbypT9FmMc41W+bbe+gZTTNkOguU13c/qzSPWcm44nCXB/jjRAWN1T8bdBj1OnM0dGCPt8hAecT4O1eoXM30MTAtYmuTQTyS84u+4u3VzWHfS/dDgC6s57Mj1hzdG68tjHtZs9UBdZvfT/T7JkeygWg4RevGU8A865sKY=
Received: from BN9PR03CA0265.namprd03.prod.outlook.com (2603:10b6:408:ff::30)
 by PH5PR10MB997709.namprd10.prod.outlook.com (2603:10b6:510:39c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Wed, 8 Jul
 2026 04:02:50 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:408:ff:cafe::4b) by BN9PR03CA0265.outlook.office365.com
 (2603:10b6:408:ff::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Wed, 8
 Jul 2026 04:02:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.0 via Frontend Transport; Wed, 8 Jul 2026 04:02:47 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 7 Jul
 2026 23:02:27 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 7 Jul
 2026 23:02:27 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 7 Jul 2026 23:02:27 -0500
Received: from [127.0.1.1]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66842I5g1259162;
 Tue, 7 Jul 2026 23:02:23 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 4/4] arm: mach-k3: Add DM reserved memory fixup
From: Neha Malcom Francis <n-francis@ti.com>
To: Paresh Bhagat <p-bhagat@ti.com>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <praneeth@ti.com>,
 <vigneshr@ti.com>, <u-kumar1@ti.com>, <msp@baylibre.com>,
 <v-singh1@ti.com>, <anshuld@ti.com>, <afd@ti.com>, <m-chawdhry@ti.com>,
 <joao.goncalves@toradex.com>, <bb@ti.com>, <n-francis@ti.com>,
 <sebin.francis@ti.com>
In-Reply-To: <20260701075021.3626094-5-p-bhagat@ti.com>
References: <20260701075021.3626094-1-p-bhagat@ti.com>
 <20260701075021.3626094-5-p-bhagat@ti.com>
Date: Wed, 8 Jul 2026 09:32:15 +0530
Message-ID: <178348333513.719416.13545702355812506341.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783483338; l=506;
 i=n-francis@ti.com; s=20260428; h=from:subject:message-id;
 bh=sAsVYiBKneZBZoEA26A5nfsX/+j6uztPl9N3j2sX+q4=;
 b=0B3vbnkxv/fel0Sn19cGESkRaPwdaACfgwZvPjZxWak/NgKUA+WoFjXCetpn81Zj11eDuytT6
 lif7YDi95InBsCUmsiB3uFlFgJozum6f93xOnagfFSYcFBhHza/Oqgm
X-Developer-Key: i=n-francis@ti.com; a=ed25519;
 pk=Z4nV5FmpAM9e1Jk0HnCKOoVUtHW8cscgDRncr2IngXg=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|PH5PR10MB997709:EE_
X-MS-Office365-Filtering-Correlation-Id: 94b12f95-dfec-4508-4929-08dedca5c5e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|22082099003|56012099006|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: sXG93WWNHgVUm3x3BW34f3eXMK/8DlwAZlK9b+Wh8OFz2G6cS4Pa2J43X8EDdzR3s5qCnuSt7N0OQayHLYJjYc97+wHuE5RAh765m6T6F28IvOrMmGt4zgo/Av/pVHyraq689OoxaKHQXNp6V63R5yaf0qgv/MJ/7z2h3sjvdZrsZZ/xAKZ94NH4N/0axWWn7TMfkA0Saf+tK7US2GeUwHdhKCEGef/U2XORXa9vb7QBXh8BOnF6AHA0BCYy2ZT/1ng6W8ehWye8DaXZe/HxGg6CsC3PCWnQVJVxRYlbWzANwW0zwq5sx7bgiFtHqryimOIHIximt6QqsNPTU4/pI1o6qvdaxKSCRfbiv6tvqOTwmkGy3JBuaUqzmNdYcJZuHkmClskx4mR4xYL6HXv5mLCCAOTVtRjjfpKyWj947hOBXM0r+cjNS2sro8SrwGVqevqW812ZETZpMlOvhnWczWERvVftMPl5Axh54p+GRvCmEdaVVAr4j029rjagacdL1SF6cHuGPSvYpdftbrCq8+rdpo55szwldrA8lLD/J73iXGYqxxBRVqHbCs0IuMZiiQjM3chjuIzGGCSeEm9wlFCX1/k2vk9O4CEOcTHgwNvSJLeidEC+6VJTnazIJVJ+ejCC8nnm4qhodMkUeCabHn0UyHcWOzIpMw+2X/AEgGiVSld6HLY24wgA9HCTB9LAY0LpDE0WB2NJIlUj0qBCxQ==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(22082099003)(56012099006)(18002099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: g+GE0EpECGamFzhIwbaTKXEd1Ydn5ARQ9G4cFWzJ/uuSd+vgy4mNg1MNCqP+7QSHefSX2C+lMu+qVp5z0LxlHrz0na22YzSPL0ejXspIGTNTyl9HyB6Med4rb2GGCrIVvZDNaNGjZQhDMM94Nfw2kmgLQ4CIk5Bd8kQxePn2IO3lND3gwtlkfR1eveI0c32NWtyvTQJVazjLJFHvRs7BG6hR8VjckIygoBTbMtfljazk1LwfWAkUflDCchWLp097oOMrNRFkGwHQe/2d0J8f/ArIpxJuLTFcd9FO1oqk6SyJq5ulmlULfxKmebY68uUjFJlMAd3tmkQ9SR1OfrHfIGcUul465ekOWDw83O9TGuKWbKeLmm33x9RVpa9DZ13Fp1TvjN2ApazZpjgv8B/znLwm4a7jQLlzX0oMr610zOSm25IdD22u/aMURkNXT81r
X-Exchange-RoutingPolicyChecked: bzuWCsgboccL3c/R8jlM//8zxVPVQL1cqaB3ezF5qWzvzRssdfNhu2ufYi/5ZHnM4DCbWxl+kSIU5DkK4/ELjPrswmYBM9tag+IvzEScSKiKEkpuaoVL/lgo56uTtzbh558TzhNRvNtEalQQl9ON6JnlUxRUyZGbYNsjh4v8cvi7kTR8IYv7Bnx0wtV9D/mnp/xQwyYINAvpjMo0T9PzoNOh8r0Flufo7nHj9VyTXF/JFRxivPTMgt0/+GlYsgEZgG26ZhDs5TItmOvFJfgouSD8d//116tu+CiIbgaJjyHyGvOXIbHO0XjodCPSHgHDj5t6VOZF3Uy1gA2wrhXS+g==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 04:02:47.9742 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b12f95-dfec-4508-4929-08dedca5c5e2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH5PR10MB997709
X-Authority-Analysis: v=2.4 cv=Iey3n2qa c=1 sm=1 tr=0 ts=6a4dcbec cx=c_pps
 a=f/vGOH3Q9iIJglbWlzIglQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=7UaoH-4qwE9fVbfpNgMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: qwMmyw1AMk-NsgCI1aaLi8l-9F9Mw3Lk
X-Proofpoint-GUID: qwMmyw1AMk-NsgCI1aaLi8l-9F9Mw3Lk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDAzNSBTYWx0ZWRfXy6ObpqN1mVXl
 Co3FSfVNwt3KFRRJe9nYzC7ybaKULv1fLcBfG6xYC9dcbw4rCSvZ6HuRDTuQ2zjcOrEmmVePWiW
 HwM3aJQp4Vihq6wpNcz3GqKZ+BmjuvMt7i8bAaH7wg8D+4zNwX/W/EXJhE3hDimI4I5rltkK4KI
 EJU4PV+tl/UtHu1K5sAhYMoPCqgz+KN6ZdJJKxzzPYGpLuib1JtEwuozRQyRFNfjzhnx9PnjXST
 t5BCuZRdJv3+L2UlmU8MntRzgEfyfFOiZ1XLaKO+6VY9SSYoH0RFC0XZYPCGgM8Bv7qokYgp0Wf
 aqBxyPysvPxk0uxsrCDNwQrtzoj0B7vJF3cp/PT6CwMj8l+6F/f1T4HSnNtZekV+wcu7+MU+/03
 Z5h/JAzGJWLZNSNRHj3r+Vm/Syow7rXSzSCDEH8oG/fBU4/R1ko42ZmDkTltzhvxgyHx2Qd5WV7
 0WosZ6CFg6tEH84h0kA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDAzNSBTYWx0ZWRfX8UPDK/OQSpxM
 V1YBFh+nncLfZpXQJ6QeQ+hIgepYVLORIw/22YaEXKxMPS8y+V8+ztw6R5nCo5cykDaY05eBVpL
 GZe6zCTsUU140PVQ0tsqd75fgbCSX0s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080035
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

On Wed, 01 Jul 2026 13:20:21 +0530, Paresh Bhagat <p-bhagat@ti.com> wrote:
> Add support for fixing up DM firmware reserved memory in the kernel
> device tree for K3 SoCs that use separate DM firmware.
> 
> The fixup uses the CONFIG_K3_DM_FW_RESERVED_ADDR and
> CONFIG_K3_DM_FW_RESERVED_SIZE Kconfig options to update the
> reserved-memory node with the correct DM firmware carveout.
> 
> [...]

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Neha Malcom Francis <n-francis@ti.com>
