Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67923CD5BAC
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 14:40:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81A0F846BD;
	Thu, 21 May 2026 16:40:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vlV9TtfX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37854846CF; Thu, 21 May 2026 16:40:24 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50E93846A4
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 16:40:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b+dBE61Yw1uCu0W8ySzwKW6U/92pxv+SsbNIHg5c/Wg54a+TGNxrMjXv4THxRoEXTIL1iIfe4c+/AIUqRn34b7zCHbltgmNiWuSUoWFsbC30vnR5Ekh8AyN5RWsW3S8IfSsP+66572CS4oQgzQw+DalV77PGP/MvI73W3eTsUeTioK9ieyyF0T9zKt9/UaGCwXdk/QxOo945II2ME5DTRTuFtS3nx/Owwe4O5hFGACtDDXlpr+gJQ7rCEK1EDM5a4r2xFxLI89b5hGqPceE7I4RsoIIfbAwQhfh8PpW/eCZ+44DscySP9+bfo9ZeIUxuFa/pVG2A7EPvy71gaxIlaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBvWK4sQSsbCx3L+kyOA0ejthKwfy+WwV+5HAdm7BJM=;
 b=IdW+/2O90NMI7sTVBF5OmgFndUjDwSx/CySDvAe1tZe+uzrV8f4DW3XXJuT6IUsHWF7RuIVn9V1Bqu/9Mpz3yBqTxEFZhKNQmnDUx8nRCCZ6ETxXjtMI2B9LGfxqi9kzn2m4R2fZo32Fh0NGtepcJ72DLANy5/tkc11JBaMM78EHhF0bRvHn6UCMjzjpJf/9xVDgY/KDlURHmCfE/+7wKVi1/gE85CGBr228zxe8O5U6bZmValcapeELttZfDPu4W0CgMucxd8KGrrszCEMRu8nj8BoCuUUg8l5c+kKw3zGMd7J/fn+6lJ7O2s1pGqenCskGhg0kbtSsXcJGOlyktA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBvWK4sQSsbCx3L+kyOA0ejthKwfy+WwV+5HAdm7BJM=;
 b=vlV9TtfXGIjI2U1AFciSk0vjZTREP++UuA2kwbR1xMyyEs3Dwe5DjXMuOZeSJ2DhPSRoLm7VJoG4SrFmL1NtzDSEUCMpc9xTG7+InzEfpo1DQtc/HlnI/FqRivZOmDZUO6euM81S1ZtZyI/Tn04uKKlzWqbNbgYP5mdCguorlnQ=
Received: from BL1P223CA0043.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::9)
 by LV3PR10MB8036.namprd10.prod.outlook.com (2603:10b6:408:28c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 14:40:18 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:208:5b6:cafe::53) by BL1P223CA0043.outlook.office365.com
 (2603:10b6:208:5b6::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Thu, 21
 May 2026 14:40:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 21 May 2026 14:40:17 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 21 May
 2026 09:40:17 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 21 May
 2026 09:40:11 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 21 May 2026 09:40:11 -0500
Received: from [10.249.135.81] ([10.249.135.81])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64LEe6bs092317;
 Thu, 21 May 2026 09:40:07 -0500
Message-ID: <16539e82-86b2-401b-b0e1-61e54ca0c3ab@ti.com>
Date: Thu, 21 May 2026 20:10:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/20] mach-k3: r5: common: add helper functions needed in
 LPM resume sequence
To: Richard GENOUD <richard.genoud@bootlin.com>, Tom Rini
 <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, "Andrew F . Davis" <afd@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, Vaishnav Achath
 <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
CC: Markus Schneider-Pargmann <msp@baylibre.com>, Abhash Kumar
 <a-kumar2@ti.com>, Thomas Richard <thomas.richard@bootlin.com>, "Gregory
 CLEMENT" <gregory.clement@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, <u-boot@lists.denx.de>
References: <20260430084414.1354490-1-richard.genoud@bootlin.com>
 <20260430084414.1354490-12-richard.genoud@bootlin.com>
 <7d8e528e-0b17-4e30-987f-059476da263d@ti.com>
 <a69e559e-9271-4859-9841-e1d991121693@bootlin.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <a69e559e-9271-4859-9841-e1d991121693@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|LV3PR10MB8036:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cf1e894-3cfb-4d8e-e526-08deb746e0d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|921020|4143699003|22082099003|56012099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: aZ05ikrvMzj4dHznxvnMBSL/XfQ4hnD5D+xBP8ZXNMszsnW9ad6oVdRik0i+lGe9K2FDacutsMTh5DZX0bu7d16k8YNiv75WjIFqGNl/gTrJyqtFUJryH/gHskuLwXhQ4F3IFhk89h+6TOtrRS8SXdh4/o3KfjMCrNFmyHH2oOriSYLDrYvRAplEiWtyZ+fK3LlW0gMLPtb/X9ZjVvXyOPE5Qt0WtExNU2SK+hXIQ3HR+lsi6DHEfiENuu1ANNBDK3VoxfT0t07gMWK60tHbhQcErO6vD+Zr5lZN8QIhj1sTp2ENQweU9aZ63VOGGVHPsv8idq0TEdZWOAnILkS0MmbyU7sw/eqfFLEV1J7lTPUzGOT9BUHOqZMix0aNNmoACdJKfXwND65b8c6W1SBsiJETpI+gDe3E2HftnG7QMG0b1shVuR/T4B+i7G2Uhgo8tdspKrM63Bx7c6uG3X3eLdIQVOus0gs02t6NdUcBtMEHqpdapJcWV3Sp9cI3oLMga3TZ1UmqdAvP50JT/Lu+BGj0J9Gf0MdbYunMy2BU6/8uUd9dWdxQ8lJ4PljcnopSkDHlpwqHfLBRnTyhM/kaJxT3Ek6j9v69LRrcgo08Fc83kvC32JXfqeAGSfvZMPW6oLBiNnARo4gVxvro4t7jrHkMzKKvPkZhJNklaoeapFE09dycTabMXSns7hXshe9QqiZSAyYxiKNXOl0wc2LJhxuJOs9XOPS8p2Tuv3uTI2RL+JpDyOUrmxySGvzsbGWHa8pf1Ab3FVMrRTJULU/P8Q==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(921020)(4143699003)(22082099003)(56012099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: N75wxEkLgWY5zNsQFXJQw51uo5HiJfUK+GkT/f6YO4R3eg+euk00dIP229XcyixM4An3yOo7gGPZZDjmotoHAfx5PmHx5MvopBUoHtID0VBrx5RcT2nrPXCYflZWEfeFlBWwV6WMmxRklLboJbcur4PMJ6Ofx/P/0/T+a88RKwzlmJfvkSndyI47IjmEDGvg81ArjDi3mMjkqk6fLGN4hW1rtDeM0Z+fJRTMnQRrLPix2WRIvKt8Rn4ty/MFYezqVHYCSr9zNxtEY2awwXlkAYosTHmo2bdT1u79PT8h9/h/VYrPKC/aIIXm2Qj4pF2I9FYZtMs6Wa0GkoT1af1VVR/wyx0B0yielxwmN4iEB0CsoF/db9VBRL+O7j23Hhka3bKVfgInARHT+EmhcoOqnYm7JsnWVTJ/Gcq399ZiNZF6Eyc80JXS/XTZLibO97AN
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 14:40:17.9627 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cf1e894-3cfb-4d8e-e526-08deb746e0d3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8036
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



On 5/21/2026 7:38 PM, Richard GENOUD wrote:
> Le 11/05/2026 à 12:52, Kumar, Udit a écrit :
>>
>>
>> On 4/30/2026 2:14 PM, Richard Genoud (TI) wrote:
>>> +   
>> [..]if (ret)
>>> +        return;
>>> +    save_addr = (unsigned long)mem_addr_lpm.context_save_addr;
>>> +    ret = ti_sci->ops.lpm_ops.lpm_save_addr(ti_sci, save_addr,
>>> +                        mem_addr_lpm.size);
>>> +    if (ret)
>>> +        pr_err("TIFS lpm save addr fail\n");
>>
>> please check firmware capability instead of sending it w/o any check
> 
> as the DM is not yet loaded, checking the capabilities failed with
> Failed to query DM firmware capability -110
> Are you thinking of another way to check for TISCI_MSG_LPM_SAVE_ADDR
> availability?

Is TIFS capability , not of DM. >
> Regards,
> Richard

