Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE0EE9B34D
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 09:57:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 730E083E63;
	Mon,  2 Mar 2026 10:57:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hO9EYr+0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED75183EC6; Mon,  2 Mar 2026 10:57:53 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azhn150120000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d91c::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CD9183CDF
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 10:57:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7lGnbm7KBaK79QAR5GERRC3PxCDWhDqK+5U5bf60a1wRpJiFpc0Vv5TmYO0r0zQabASZ4oWU8IHVicBvQGqMYWoRtMY/hh/nspmAFptSojAzM8MusWFzNaPTtVWnuUJ2pFybFEaDypmlVzaGJ4VLAETygsw0x2vTq38ADki0YXYoOyoqO0u8LXtI/QPJik6tugR4Sy5RAkRTEWcgDDzvIke99IF8IaV+LPgzOR6cFrziuuyEd9jdJKWbtW8hHf9XJjycvXsxqiK+zv322/o5MMjuOG5KOV+0LzeKf0wpfaIUF1Ml298ihj+MStaMRkPLoJBvSpm6WoDmOpprbVNug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PplL3gZb6SHwpi3zB31DmeGJiqBqn0y6GdYxjszOt0I=;
 b=h6CZ7puf4gvGgZvqOze74NVh4zSg8MPAX3j1k8ZHLdxhCeSjAIkIybuSuZD5IikOdv5c2Y4BlIoW3yfrBaa7nfAI+XJsDLdATB7+FzedostqozT8JvKaPfIxaqGr/aQWwvm2CsNnH9BLZhUzdbtgk+eiu/NyVwfWvLm3mfZEma1/9x8Iz+fxPX67ILKbF76HkaA56oY9k01xrrLfvOZQrWuI+3SQeT1z/TQnqhuPIjbhFjqnrGWS/+0DfxNV98Z6Euqa3SH47RbHnPAaAjXc1R0Rw4dVHnO0DP+tiZbQ2KAh63yQvHYjG1bMrhteT92eJU6T7cEPta88x/bMTEAJ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PplL3gZb6SHwpi3zB31DmeGJiqBqn0y6GdYxjszOt0I=;
 b=hO9EYr+02GFHphov7UtauwPZzFJjOtuEYl6GZMdSitiTkYsL/nD/OWnLBPSQrERkgjjJic7ap1aNFRwbdjM8F54LrfEVLidC41avAi6j6Lg0t6D+yFyh9P6Dq27tp+8kXMTQ/5NjBKfsNYnVt6lHlRBVS4q51H6FXG4V7LI6WYE=
Received: from BL0PR02CA0050.namprd02.prod.outlook.com (2603:10b6:207:3d::27)
 by MW4PR10MB6629.namprd10.prod.outlook.com (2603:10b6:303:22e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Mon, 2 Mar
 2026 09:57:47 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:207:3d:cafe::54) by BL0PR02CA0050.outlook.office365.com
 (2603:10b6:207:3d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.19 via Frontend Transport; Mon,
 2 Mar 2026 09:57:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 09:57:46 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 03:57:28 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 03:57:28 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 2 Mar 2026 03:57:28 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6229vO56082759;
 Mon, 2 Mar 2026 03:57:25 -0600
Message-ID: <95205612-acfd-4623-8264-828f7823a156@ti.com>
Date: Mon, 2 Mar 2026 15:27:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH] mach-k3: Defer CTRL_MMR access until after TIFS
 version response
To: Tom Rini <trini@konsulko.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <u-boot@lists.denx.de>,
 <nm@ti.com>, <heiko.thiery@gmail.com>, <m-shah@ti.com>, <j-keerthy@ti.com>,
 <n-francis@ti.com>, <bb@ti.com>, Diwakar Dhyani <d-dhyani@ti.com>,
 <u-kumar1@ti.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|MW4PR10MB6629:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e389900-b858-44ba-3608-08de7842281a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|34020700016|1800799024|12100799066;
X-Microsoft-Antispam-Message-Info: QNRkHyXV7SOsQ1zZcweePoQrH98ShGSDjNGcUMw1GRwN1RUPTTBcaOmj4RDvc+bFZ3SAz4IffopOrLDegQ40iuTNfRhtR1mjdIAbusTw7j0nV2HygDUDEsyiP4eID4zoYvMnpjFJcBnWo1zxJcy6OcgnKWKhEcXattacQSIsIEMNwr7BQ9pL2LgmXLsZU1cBWNqZAdslTWgyvFTGBJI8WitNzw2WYojVnTWDSehSJt/3dRAf/JRgi0gUQNsknU0rNIvdAcllicOzADps7S5zaN/vXzcqdv256013pA0/pBICv/oz3eUmWkCw7wPy3sA6yMAeyESLcCHiRl4NIv3tHC8ldrUA4+fGTKFtk2aTSe21GrxSl9wFvhSVT6vFgq2g7r5zk7vsCNwUjB7JL+fz+z1GBegWv2wwTdGdg7WKjiZEH8/4uW9WWXOXVPCbjgyCBWSNyMqV7s7ZdAeFWLMo6mjgekoVC35LajRBoMrE4OdtMPEp7v12hYC2uoCcDMCf9ax24fFvi4N+VrqR6Wvi/9KocpGMsihFZA5JVe+RZK5RrI/f8PP32Rm4RW2YGS7xuuZvz9PTuSNTq0O0RtUqSerObhGmtMWkyeO2/5QzGtDl/Y8L57JJ+f3GgX0jpjthqj4gKqH4f4wFKkSjyckwKVmTNm9OKCcENi5dkEt0N+zcfLWwu3d16Ijqg410QZEvI7motyDmdIpFAYq1C/AVQL7MSXD7BEWekl9B74aRAju69VsRrQKtTjnYFK495jrxoG5B8VBVnHup5Y+UTVt3UJnAlR3MNwTFE+yWK2pBV9rvRkxPZ1SohMnlGnlGf+dwq/rhU5nS5zlNhEuVoYAhmQ==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(34020700016)(1800799024)(12100799066);
 DIR:OUT; SFP:1501; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JrP3SCEGZV0TeZ92aU+PUvrFrZngvXZwvaTwkI8goNRs48+pSk0OfDYpG90nSOz+fEpJaX54XOUvJMk+THZ8t2w4uvASN0RItRLz46K1+aEYVeLnZ8hFoPCw7tCT3Uzt2mOek6LltJraF6xKzG/b67OHG+g7oa8l0p6zeVZOae/kN2auXTBvct0NCLrX0pT85iTbd0Y+/0ZqulZ7s6Gw4mzWCLJKodbnhuT0NqvGpHWjWuOYyXNPsTEOaG/0J6KSrpiGbRWZ6ps5lWCjAP02f6tNH0/7yP3HEMVkH+4LWxQwrWUZcnTS4JCOOVYNLDPE6WmdiAXla//0cTA68iOBeqhmoNrKh3j9LObmkwJeOeYdc2Pr4+/gJShIp6B/NcgMlC15Koqyu/4ui0j3io2SY1uVqjiuiLzNaLpq3B8fv35Lg1WbYTzfPpC/HWhNhYwN
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 09:57:46.7975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e389900-b858-44ba-3608-08de7842281a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6629
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

Looks in general mmr-unlock can not be moved on all SOCs after FW print version.
I am seeing boot failure on other SOCs, need to debug more on this different behavior.  
 

