Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19400FCE09A
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 14:48:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9819883E88;
	Thu, 26 Feb 2026 15:48:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Qkd1TYDJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8EFA83E96; Thu, 26 Feb 2026 15:48:43 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazhn150120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d900::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7ECFC83AA9
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 15:48:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJJ3hpBv1IWw4w5TPGNxU9Z6/a2pBnlDv9m3J5upAP7lKon+1X5dm2p9VIusQ9WUtK1xTFmGQ1pYT5q2erriCJL+Ii3Cjtk3cVzczfUDVq9l88chOTyFAjgSDbD5RfEUXDXMDLze5wwl/BP02EV7+iRpsawEv+ywmYkUJiloBZZEgz9v7nE/P6K4LH3mQjZTuh+6BZ63zc7Vwg1XWMFivb/T7HIJVC4oa0xwDfDIiaAMjvnDFufUREqzKeDoUi9EqPzaBqDzxsIt1PAoTSNcJYGC+SwA3pRYgCXflC8RLB7y8KAl0amZDvxEYqYdLv++Q5ov3uwra3OpD6RytDYsqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15SCOWwKYEevUbYJTJtskiWKDNLQlh6wWLQNgPEJkLc=;
 b=uu81lgXvMXdcXFPockXzQfNXb7yS4Eo6uq0y3IiXAkhLGkVDb2IulInJb2OOU7j/ZStv5pQcFUckvXbI7Fmp4hRz+xY3Gnwe7qdBG38P3Pe7TFudv+GpnKyV6hu6mlsAOUI3Sgv+K4ddsYhw+pQzd+QA+agD9CB9oAWfsQibf0FlwPQKjpVG8K7/xWN0SzdkmTmCyiRHtSzSUf5Vo0xlplN3GdL5EExhS6e6/p0a//HZYi3QCAVkBRQ+9sFF5eyx+SZT9SKOwEXIgGphzN0UXyXDJFW1TQafsq9v55hYiOUHN+YQjwFte//EpYFX4USt87NVYy93mOvExx9R/nFNqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15SCOWwKYEevUbYJTJtskiWKDNLQlh6wWLQNgPEJkLc=;
 b=Qkd1TYDJ+ED/GnRP3dgSVHUMpWMRDc8fJKMJNFzm+O4xal1rEdHb6DpSL0mR888+qjWStA2KYQoKCCibQcHYPLxMYz5b0x5TX7PqswRCCCtfuOCE3ZScwP8314WlMuGxpmH6O0P7rpdvYoHOv1PF/AwQlLFI1u0HvB0/mYBwpsI=
Received: from BL1P223CA0026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::31)
 by SA6PR10MB8016.namprd10.prod.outlook.com (2603:10b6:806:442::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 14:48:37 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::42) by BL1P223CA0026.outlook.office365.com
 (2603:10b6:208:2c4::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Thu,
 26 Feb 2026 14:48:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 14:48:37 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 08:48:20 -0600
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 08:48:20 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 26 Feb 2026 08:48:20 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61QEmHep2529705;
 Thu, 26 Feb 2026 08:48:18 -0600
Message-ID: <9cc3ee3f-7c6d-41da-b095-0e03623a60c2@ti.com>
Date: Thu, 26 Feb 2026 20:18:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH] mach-k3: Defer CTRL_MMR access until after TIFS
 version response
To: Tom Rini <trini@konsulko.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <u-boot@lists.denx.de>,
 <nm@ti.com>, <heiko.thiery@gmail.com>, <m-shah@ti.com>, <j-keerthy@ti.com>,
 <n-francis@ti.com>, <bb@ti.com>, Diwakar Dhyani <d-dhyani@ti.com>
References: <20260225051559.416445-1-u-kumar1@ti.com>
 <50d29e78-1502-4dbd-ad24-a1025142947d@ti.com>
 <f21a0fba-0a19-4f95-88c3-41e0728fb888@ti.com>
 <20260226143756.GC1593142@bill-the-cat>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260226143756.GC1593142@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|SA6PR10MB8016:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e6b1830-e9dc-4a6c-fc0c-08de75461fc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|34020700016|36860700013|1800799024|12100799066;
X-Microsoft-Antispam-Message-Info: JVU7oAtNtqBOj++a2s8YhbA+Th55OxVGo7EZnBzd39hQi9Z68NtNGCVHy4sqSqQf6KD64DtHqhit301/Ypa683f00ISEU8l4eItfatXh7UJav+T9pj8mODY9xDuGE2x3iXD3/XFVjwRpTSXBsEjV9ttjZSBPf7RqdjLNvBXPa7w9ZJ5wdYK5Oz4bqxLhmw4g+8HPocRAzxxgZPr3sYu+jB7CNGukfVknmwoftYjIAEfhFkzLKQAk8sSFLPY6mTCljbGdNKsri6YEL/GG/WO3SgIARrry6ImXd2YJdRrvGJYI9yNNxMStAhCcu5GAK9Mxq2bd0pishmCUoFkVddWWkOmnXLo+sbk+E4KueHSsLdyX40FGBA6HJsi8WFIN2k91Bupu4V4gIAUessCj+YHWXiRHhb7kssczHZbbwNvw8nfuJC2Zb0zlafgyfvpZeMx4jeYUmvjyjQotVR9BMHd1VMfqbYXgl6RGtIarFPaqqNTolRQ/3/OEQfM29VAnkbdYVgNB35VV4A5Th+23AwN4VD9gycfzffjqoL9Fblj5YPM6Wn0hie5VOFvuJLSkmJ2z8UX9ta87pvM5BAMLQ8jS9dOM0G6o4BhWVJZk22foQ3Q4Ogy6Iu2DNtFFGlFOoLXMSIOYjg9upZataDG+IBlkGIct+350u5DAfuFxLcMBwtWd5Lf+AbfkcjeKrentHyAlWTKhBmKknKTPo6WAzP3mk39+fzHIyR2aUztSmBuz3Yg9CQ+CPn83RKwWILXpb8ilExraGhYMskTdJCIUACk56PB8DyJaRDPXWeNr8x8nKLFuR5KWCmYm1B6Y8Yt/XjsII6ds0tvjEsUrHqIvQBrCEw==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(34020700016)(36860700013)(1800799024)(12100799066);
 DIR:OUT; SFP:1501; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: P70kerrT/qI8YYCNLTQ9q+UDiGsfk4KsUQYJZkA0BSfPpTVKB4bGNRr+MwRtmzBzMTMxyVzppzIiEZg74KX+TlBp0p5zMOCL9atF2dpNo4Rpp3jQpUNNO3khZH/9b1dFK14gbuYEVMC/szxsw3QVWFo4QIJXzVmFcxNTVpXodJxuget9LWJ+tsotygcziVoLvhurP1Cp7QM/dvQg5GK2n/n1OTnlsNC7b18XGRAWVkh1sJlDZqehPX52GU+uZL92K4KLh7sEM6NowTFmMDDuv/Bmd5A+1Lwf3c8PjQR0yTdDktMH8pNLeaZfxF8fP0WoQrGg+acoE45mSK/auiSnmvTHJOspoeikjlHGyw03Cl1wWVT6lnRGRm+mgKPzZjG4334U4GaI/tUSyIZA+Ehxjy/SsuXakcjIB54g8mj4MnAjkDDMV/syKqfYxcLr4aPp
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 14:48:37.3445 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6b1830-e9dc-4a6c-fc0c-08de75461fc8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8016
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



On 2/26/2026 8:07 PM, Tom Rini wrote:
> On Thu, Feb 26, 2026 at 10:20:11AM +0530, Kumar, Udit wrote:
>>
>>
>> On 2/26/2026 10:04 AM, Vignesh Raghavendra wrote:
>>>
>>>
>>> On 25/02/26 10:45, Udit Kumar wrote:
>>>> The CTRL_MMR registers are firewalled at boot time, and TIFS unlock
>>>> them as part of the system firmware initialization sequence.
>>>>
>>>> Current code assumes the CTRL_MMR space can be accessible at early
>>>> stage of board_init_f execution by unlocking them.
>>>>
>>>> But on HS-SE devices, TIFS takes more time to complete initialization,
>>>> and CTRL_MMR registers remains firewalled and not getting unlocked.
>>>> Which results in any write to these registers are ignored.
>>>
>>> Hmm, this looks like something that can happen on other K3 SoCs too.
>>> Should we update all the other SoCs to follow the same logic?
>>
>> Yes, we need to update all SOCs,
>> As Bryan pointed out, this issue is seen on other SOC as well[0].
>>
>> I will post for other SOCs as different series. 
> 
> Do you mean another iteration of this, as a series that addresses all of
> the SoCs? I'd prefer that (and cover letter explaining the situation) if
> possible and reasonable, thanks.
> 

Sorry I meant another series to cover rest of SOCs.

Thanks for advice, i will do v3 covering all SOCs. 


