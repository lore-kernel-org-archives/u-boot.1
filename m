Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC69DCD8CA8
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 05:46:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27DFF839A8;
	Fri, 12 Jun 2026 07:46:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="MsnqjfM4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9879683FF5; Fri, 12 Jun 2026 07:46:49 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 343908005D
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 07:46:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iBC2XzBu8O8aT/3W0zisaG/mpYDtb1PgvNY9z9GWyj6pmdEgRv9EcwycQ4rYxY/9biVneYGBP2ll+XR7e9wJCUiRpt9sYmLYZqTeziS+JOxK3fEPJ0R3WWXPd8Kf2g0QDO6cZN9PcECAtZfijoZLsaFNS2ABcm4PWvmmyrD5lRFcFBkXNEm9jd2YmIjGAOV8zuUx2nXR58eo+vfSNpSjJR6ILWlxqEZZpjgVrlg30vadFFR7Ov8XIHmRwLbU4ArWZMgRmauU0SPu+TRL7CZEm+rjs+38RX1xh7UmRBKdtJmfsoj+SThkYucGDJ0tE0WkihxfNfGY4pn8OEM5urrDGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RzvOVKnMli365S9WfgP63im6rX1fF+43xGUpbFZVRR0=;
 b=A5/DJniVM9ffWPotnmtN4aD9cFU69UoylNPw2PL1SZiQmBTg7LbD7+rqPlL/3hGGgYY3++zgMebDyv+EMzr9WZ/ZIiQBTl1KX/OqUC0WqbD0rh12XW1+1IhCtv4zDsannSlvae7H3V+uDJ+yh+/gYlVvjBNeIKJkm9mDll2Z/WGv9agQP/FapwabSSPKDiTUM+OqOPUgjlO0+vQbfe+ufxEjTUXAEvrYGnlM17jojQiyoPR2CLmsLHkwGX4nLiJo+VyKQ1ZeErXbQ77DJTXQ5qFbqHo4ndyS2J8/vZ+jUgedOZI3LzR3wzV43nGRB4JmxEEZeL0+MiEhmiW8RZvgLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzvOVKnMli365S9WfgP63im6rX1fF+43xGUpbFZVRR0=;
 b=MsnqjfM4EqXiun93178ZVGtXyC4Pd5+9Yry6j5IQbc6NwridJtc2y+DtRDUdzq+t6Of0QA3/XPqWpKtOXEr14c7n5YF9eawjOG1oo/wowCbEh/HYP6rbXTuR3DKWBo9w3Ippz0v1Dd0ZwFwiiBfQ3PcmZ8MDRz/yc6QDFFzBWOw=
Received: from BN0PR04CA0085.namprd04.prod.outlook.com (2603:10b6:408:ea::30)
 by BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 05:46:42 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:ea:cafe::22) by BN0PR04CA0085.outlook.office365.com
 (2603:10b6:408:ea::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Fri,
 12 Jun 2026 05:46:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 05:46:41 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 12 Jun
 2026 00:46:22 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 12 Jun
 2026 00:46:22 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 12 Jun 2026 00:46:22 -0500
Received: from [10.24.68.110] (uda0492258.dhcp.ti.com [10.24.68.110])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65C5kIai2853073;
 Fri, 12 Jun 2026 00:46:19 -0500
Message-ID: <3ef4f04c-1bb4-48ce-b1f7-1e2e83f08a6c@ti.com>
Date: Fri, 12 Jun 2026 11:18:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <s-vadapalli@ti.com>, <andrew.goodbody@linaro.org>, <c-vankar@ti.com>,
 <jerome.forissier@arm.com>, <matthias.schiffer@ew.tq-group.com>,
 <trini@konsulko.com>, <u-boot@lists.denx.de>, <nm@ti.com>, <srk@ti.com>
Subject: Re: [PATCH] net: ti: am65-cpsw-nuss: allow skipping phy_config() for
 speed
To: Jai Luthra <jai.luthra@ideasonboard.com>
References: <20260611120652.3656640-1-s-vadapalli@ti.com>
 <178118305958.1799417.3241467311184856154@freya>
 <18490eb5-3ab5-4e78-a723-553983c9ed17@ti.com>
 <178124243466.1799417.15145017019051587066@freya>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <178124243466.1799417.15145017019051587066@freya>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|BLAPR10MB4835:EE_
X-MS-Office365-Filtering-Correlation-Id: 4655e47d-7315-4aa3-04ea-08dec845facc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: Xjyw0pYPxBU9e+NgsGV5YBaQc3xWF+1VFB8mULBYSt7tnCJUexEt+PjuRdBVdPOCQjhB2/vIVwE7tvwZOFohfyouaBUaVRzMniP/B9hqoqHNnIwexkE4gBk9a8h6Lx9RO6JmEnSkKQ7urKASX+WbTL+awIzSv3bsJdt+1qF3lkRnBAP730SdYsscO43d4EEdJuez8DjL7HIRqvTBU95fO1gvgUPj8M5yysaqwMWalVOtNE3nmggFVQKlsLpvqNBejEMaPMez+QXZ18gDkp47OOISg8MgIsqcEUnXRO/pSiLjVEa7PyzoPTCzSCmcSoDmpu7DzE0WufZctQg/Co5AVGn/CqoEM9uwp4M9B4GFSt9Ah999nvnTFGuJkM8vJ7e9DOkmokkc+6TupqMNTCIqdhsEfuP+1SJcs07nvj2JnwOJWEgBeBbQWWt7nBMYpQEZf78T1jfG26K6A/cixetYon/pyb1m9r8OmmA8gQ/ZfqD+dens9DeaYbEnE/SYjNnis7NOY5/50jHZFa88zG6oaApE6BC09otp+UP4XhpWKLb2qXpIHaPl01PxztOiHWHo5R0qxCcFNG5lMfnb/2HIKMWNJWtugIYs78DckdAkkMwHYZJjkA0mxNgoaZoZKTdNcJZuacyMG1+WslgzhOCzqMKvTnBTooTQslsoK0iuyGY=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(22082099003)(18002099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +ABjztR5Defn/na2M4Okgynz3VObfxPjPo7D1GlEzdn/gY+Af2+ERAdn7KWSfAKbxzj2MlfTIEJczlHvgodmg1yDjwL7CHNOXSLzqlL1ixGJ1kk1Y9p3yG2ChpB5Vkh0mr6HDBWI7XEUO8NZpoYYOC3WajbRCxqDmx0CnHReM0YiMMhDY4UBKk05mNt5yKk9MWG7RI4MBGNErZLz4cLnEMXmmQqa9ycOTuwOseMRug3+gjulnl48xLSiDH3I25Q9fLx7TPAj7D6psyj21MNqXDXQgBjtPsf/YpOKAF722dIjjWluMHf+hf4J1mYxixrCKdZXq415s00dCplVhGqGFzjED7cBXn40gcwvYo/zwpd96mPq5loRm3zxSktA8+PsEcmZCctiH95ryD1ceeQBM4rGtR6lK1CDfxd8TyOYq+uY1JdwiMFLFodpii5ZsuwJ
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 05:46:41.7939 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4655e47d-7315-4aa3-04ea-08dec845facc
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4835
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

On 12/06/26 11:03, Jai Luthra wrote:
> Hi Siddharth,
> 
> Quoting Siddharth Vadapalli (2026-06-12 10:03:31)

[TRIMMED]

>>
>> I hope this clarifies your question. Let me know otherwise.
>>
> 
> Thanks, that makes a lot of sense.
> 
> Given the failure happens once in two weeks with hundred of tests, I have a
> slight preference for keeping the default to not call phy_config()
> everytime, or maybe just documenting this environment variable prominently
> somewhere, as most developers with a board on their desk would prefer a
> broken link every two weeks as opposed to slow transfers.
> 
> But I understand anywhere with automation it's okay to spend a little more
> time and keep it robust.

I agree that users may not be aware of this feature unless it is 
documented. Since the environment variable is TI specific, I assume that it 
cannot be documented in the common environment variable documentation at:
https://docs.u-boot-project.org/en/latest/usage/environment.html

Instead, it probably needs to be documented in both:
https://docs.u-boot-project.org/en/latest/board/ti/k3.html (TI K3 boards)
https://docs.u-boot-project.org/en/latest/board/beagle/index.html#arm-based-boards 
(Beagleboard documentation for K3 SoCs)

Let me know if you have any suggestions regarding a better place to 
document it. Thank you for reviewing the patch and providing your feedback.

Regards,
Siddharth.
