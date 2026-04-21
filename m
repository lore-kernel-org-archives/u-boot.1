Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AFC7F89248
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 10:10:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2A8A843C0;
	Tue, 21 Apr 2026 12:10:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IbV8nrqR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F86484419; Tue, 21 Apr 2026 12:10:53 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABD388439E
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 12:10:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=COLwgfoYBHWhuBBLxA3e3oUp3omLRylRyZj7Bv2EgWe4AdSmiiHub5MYgDwASWvTHCII18xQdy3WvnHYrXFBKrnwL49GcTki7OE3nC0RrvvAVpRPPKfGkSJR4Ti/7nMdLPLB+aSvJMtpEVpdXKkxyvoDtD7K2uniMFTpSJ7nrCoKKgbiZs/mNKIHOMC1QoW+V64huIIZG6PvpooQ3nde51S55BFB14CLYWtsIYYZ8lr+xap2Xng8KR57Cd96HiXguPrgfkFpY6Zq59y3QXZ5GXL8QU2wWNj7PuCaNWmoo4kc/fdCdMNuqmtDXJydgqnDgQGVi8y3E/TIIv/NBW01iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPsxbm9Zs3TvD/uJLGQomOskY6aN3u850UfdXKCU/ec=;
 b=Ps7nDlHCD5spWBSgHLrN0iNOrQv6lxdATROPnCWtH5S9nC0jqEXZWr/halQPfFF51vN+u8NmJ1ikGVnZmXo+87cNYFibyFwEzrwuLWxtUq7jSZmiuios/BXFcPdl0ANsdqbSxxOecSwjhBLwsN9Q4/Im6GpDso6bmyNcKAJWA2Cyb8WOsE2ANrLTjn98VHbUFas8SeyX9PRqEVHKk3un/1EWPSDNfwvuHVM5qQy5PNOwS5lRnVbod2V/qiD+9oZ1irTsGNWPkEvGQvVeVuFoVlO7NpA+jxlYNzsZIX/wKnt7lR7cxan9Sct2M0rwRo2ZWhCrODW7agj/MJF/sPz1LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPsxbm9Zs3TvD/uJLGQomOskY6aN3u850UfdXKCU/ec=;
 b=IbV8nrqREV7WysCZrE15EHau6GwOadCcFGrBFa5MoWkZd7zdRO9SbaLACjg3zDyBzuU3cTpU5sDQB8RMYV4dCkaifPZ8G8ZrR4t8sKhuarotLxX2fVIupbKrcWE1Vku7i5mlWnHkEeTEG86S2HRu74AVEv5Ne638cd9TQHUDc/k=
Received: from SA9PR11CA0011.namprd11.prod.outlook.com (2603:10b6:806:6e::16)
 by DSVPR10MB997869.namprd10.prod.outlook.com (2603:10b6:8:45b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 10:10:48 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:806:6e:cafe::da) by SA9PR11CA0011.outlook.office365.com
 (2603:10b6:806:6e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 10:10:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Tue, 21 Apr 2026 10:10:47 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Apr
 2026 05:10:46 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Apr
 2026 05:10:46 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 21 Apr 2026 05:10:46 -0500
Received: from [10.24.50.71]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63LAAgrq302807;
 Tue, 21 Apr 2026 05:10:43 -0500
Message-ID: <fcba4a77-53a2-4f7f-be95-e9cefcf347a3@ti.com>
Date: Tue, 21 Apr 2026 15:40:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH v2 5/7] arm: dts: k3-am69: ddr: Update to
 v0.12.0 of DDR config tool
To: Francesco Dolcini <francesco@dolcini.it>, "Scholz, Kevin" <k-scholz@ti.com>
CC: Franz Schnyder <fra.schnyder@gmail.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "K, Santhosh Kumar" <s-k6@ti.com>, "Brattlof, Bryan"
 <bb@ti.com>, "Chawdhry, Manorit" <m-chawdhry@ti.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "Kumar, Udit" <u-kumar1@ti.com>, "Gujulan Elango,
 Hari Prasath" <gehariprasath@ti.com>
References: <20251103071035.674604-1-n-francis@ti.com>
 <20251103071035.674604-6-n-francis@ti.com>
 <btgc6fvqwkqlnnmqicvobikkyjpib5lgvda7tfyguwn25bmd2s@hdhibzylbig7>
 <2b1b5496-cbd2-4ac4-85cc-2b8da653bbdd@ti.com>
 <20251120081659.GA12514@francesco-nb>
 <6726eb089e2f41ad9fa4a5ff3d6ceb54@ti.com>
 <20251120144848.GA58464@francesco-nb>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20251120144848.GA58464@francesco-nb>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|DSVPR10MB997869:EE_
X-MS-Office365-Filtering-Correlation-Id: e0ec505f-8ba1-477c-5cd4-08de9f8e4251
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: MUUar18MsD/wO30jPVTq9KtIWLc6Dh+E241YaPpb0Sl8PehUuGZ4U7koR/M/JcmtpS4rCLGKBC+BCut3xAUA4lf+raBPxGHBs30KZVtoOnxDl5FESA0KQSBnUS8AJ2jpMxeXU7FuDCrs93jLIo7Ly3ts9HObF6g8Nx2OodEELHcvREo5nToM2lwGz9TuGnMIVrXw5k0Tl4VsvCt3ESJGCYB/fvetB/4AE5jIq9t2fMRxfyb4q2DMXqc0Oso7VP7g+HC5ma7yH52ExhTIAqHJx5rPEwDOHSHzGIzYavhIdPccz8AG4zjkei9x0/vQ0SGv0TLYxDHoSXYH9Zt8I/Ts1D4ymxZdpMtkFL19cXKoV3p+/XrFeme09AknFMQt9ppJSt9rOhwUjsBZlcKHy70RIP79EtFd5QKR7wO+qYCUkqegahRR01WqmaBjoPmnoNn384cFDcWFHEa9/gqwkITy+VNIz3StgyQz38wzdg3S7BAHB6SU/OGiyE9agTdNfvXubKHsNd7DLdcB1O+yVLbCrWv9N2VQMga7kGIegNONK6ehN9Xxof2gh0A/KzRk8rbT+DRerXtiK+DxBVeYbrXxOn8Niic7nyis4jSAwctNDo1o6OPlUuM30DKmltzOzQrPDS7UjIMbgqbPY1a8CQvLCbLAaMTjSsDOtPMdj/veP/vFOtj+v9zfeqF45ewvvIeMy9nz8IWgfBV5c+Ny3QVvUZpiX8iUlcJlSi7kQhCSr8zbx51TXozNJyXL4YKMY1e1UXl4ZZFBR08uh0Shn6NPBA==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zsMnV0/F5SYR/k9DdCPd5GToTPtXOE2dbpHOcTfA0ez7dAGILFMd5tsAcBnUxheEPX86rW19c0OAlyFz5oUaq1o5iC5iffeCtrt8aTOsnVZdcjVSQuuepwZzYmcTRS2FOe6gF/4wcgBqq1Htz6W4q5qd9haeuVKNBBOErZf7zzzlmNEGoxMcJIeQDzeObkQaZqEmmzQkv1HeO5rWJ3LWMZ7/YZouhX5j5nxzHrrLYuTJGG8PxB4Xhmg4xYBnAjwJC4ZNeIx6e8R8fQLcqqYUsCwwhwtPD2fWKiCiR9l3MZQ0msg3hbpqlCQ++OXSVgoWfIMhvpwDGDjx2Ia1RysbSVYJER5Q6tlo2X/3n1zwmSlYCT3+1eYkzd4K2Rlba88Rf2yK0Mpt5anySkIrI+LNA5iO+Wq09A5zQoXbvedsOxH6uz91d2MWbnjLZBCEGWtn
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 10:10:47.9261 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0ec505f-8ba1-477c-5cd4-08de9f8e4251
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR10MB997869
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

Hi Kevin

On 20/11/25 20:18, Francesco Dolcini wrote:
> Hello Kevin,
> 
> On Thu, Nov 20, 2025 at 02:23:02PM +0000, Scholz, Kevin wrote:
>>
>> ODT is user configurable from the TDA4x (J784S4) DDR config tool.
>> Custom boards can modify this setting as needed.
> 
> Thanks for explaining me the tool and the related config options and
> changes, however the question is why you have this difference
> in your specific configuration for AM69A SK board in which only dram3
> has ODT enabled, and dram, dram1 and dram2 not. Is the layout/schematics
> of DRAM3 different from the others? Why?

Is there any specific reason for doing this as Francesco has pointed out?


> 
> Francesco
> 

-- 
Thanking You
Neha Malcom Francis

