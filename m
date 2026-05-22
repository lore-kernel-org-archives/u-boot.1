Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C590ECD5BB0
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 14:19:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EDEC846C0;
	Fri, 22 May 2026 16:19:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Mr3O0Zdb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4B0B8470E; Fri, 22 May 2026 16:19:45 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E29B846A7
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 16:19:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-tripathi1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VOxnU2X47f5oXgoPJ5FL4rzGIM1I2PU9/Jz5fOm1cHxR0kI9+KvAbjPnNxOcQd4dL2IMskazT6xNSLRZcnhg5JW7t+11xKBnUjGll2rSDIrirVdX2lacyQGr9vi8fO+HShk7fB7SqOZlkktDvZo38KN60z3MIH3Rism6urkaw47l/cnHr1grAPDIiEHO+F1gvTVS7kTrUhDUWxXvOMnmHhSjm1PpRNtbSQN5SRFqxWmypd7aIVr9ppo6n8t/G4mWoooz49d4iTrExhvgkgalguv8erTgc/rpDav9fvwy2BOCAPbAcf9sc6bbmkXLp8CLO+1m9lc+BCNfDjcPu48PBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T01RqSYZ5/GbcDsmENR+EG11JQdfmYMurJPUsycqZEU=;
 b=l5lR5BEicAf17CWB4o2linGMPhkEp8u5E3cAA/cz4jCLU7jKT2LihPX4OhoWhR1FlMmfGKSKF48sU++8ptURguO2B7yX8EmOtGnTd5bUtBGrOdOUx/KNybevQ4QK1NHmWopgbdYyYJzqfYlhTja2cHun0cX7yOC9D2GMg0MOlTYzjcJEat3tqJlSnGpe/hTnhTsH9m/FRp1LSUdCiV09qN8ykq253oKo6lu2LLFZFX+nEEZveWjLCRlC09W+SPsXg8We0cEbdH1GAVj5hTJcZ7rm85+ym61eX5AwkSd20AUdFmkiPB7YPSDEV99XEC8t4g4G930dm1w+vwfVEZTrIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T01RqSYZ5/GbcDsmENR+EG11JQdfmYMurJPUsycqZEU=;
 b=Mr3O0ZdbWg5bbTtiTtEBXrTV4bCugIXi7/o9p0JSfQiKHtjkJz2aRgeVYZOvlNyPKL0HowOZ6t8xwsRTKqGb5hSjHh+sZqZETGcdt2qlR1xEFeJyR7lUAYE53VnwjFwn/pXwWkxzwEyzFrxFqfb1bqT53k1i+ac5LKpFiYHnekU=
Received: from SJ0PR03CA0076.namprd03.prod.outlook.com (2603:10b6:a03:331::21)
 by DS0PR10MB7068.namprd10.prod.outlook.com (2603:10b6:8:144::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Fri, 22 May
 2026 14:19:36 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::a9) by SJ0PR03CA0076.outlook.office365.com
 (2603:10b6:a03:331::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Fri, 22
 May 2026 14:19:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 14:19:35 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 22 May
 2026 09:19:32 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 22 May
 2026 09:19:31 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 22 May 2026 09:19:31 -0500
Received: from [10.24.68.200] (hp-z2-tower-g9.dhcp.ti.com [10.24.68.200])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64MEJRAs1632546;
 Fri, 22 May 2026 09:19:28 -0500
Message-ID: <0c76975d-1f87-4a6c-87c2-cff99584fa1e@ti.com>
Date: Fri, 22 May 2026 19:49:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm: k3: Kconfig: Enable fTPM and RPMB support
To: Francesco Dolcini <francesco@dolcini.it>, Andrew Davis <afd@ti.com>
CC: Ernest Van Hoecke <ernestvanhoecke@gmail.com>, <trini@konsulko.com>,
 <vigneshr@ti.com>, <bb@ti.com>, <u-boot@lists.denx.de>, <u-kumar1@ti.com>,
 <praneeth@ti.com>, <kamlesh@ti.com>, <vishalm@ti.com>, <k-malarvizhi@ti.com>, 
 <anshuld@ti.com>
References: <20260522061515.GA8642@francesco-nb>
Content-Language: en-US
From: Shiva Tripathi <s-tripathi1@ti.com>
In-Reply-To: <20260522061515.GA8642@francesco-nb>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|DS0PR10MB7068:EE_
X-MS-Office365-Filtering-Correlation-Id: eabd7c47-1525-4ee9-19e6-08deb80d2698
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|18002099003|6133799003|22082099003|5023799004;
X-Microsoft-Antispam-Message-Info: nSYoSI5G+8I+rFQH2wFO+F59Gorc5m4NDLNOAsXEkReBvAvCjrzAeAFgIHF0NlkS52NPa5FhSmurR9tgdoNbxqATzocpqm9+yKCMJCljJ29uj7d8raxHffw7MwQXmo12gn5tnIyyc0MyIstucH/D6ZaIkuXaqLTaR1a1YCcjCpu9tmz5MhO7W/qKlKA4M1KnInGPtXn29BRI73HtEpAX5cj+SGFG7DZMYPiwD8OIkNFQ7v8lklu2r/NAPu3fxSU7EOt80wBYsk5AY+4x5meiqKd4LSwSuVRCHyJDTRnU8qcq98TPm16izHB615qWMvrgY0cPKvn8V79N4kOD38Oz3WPM0M3GqopFtbODHgNypSlHEcSwISj6Kjj3Akhj4AgOKCYiEZERfLw0pjZ43KfokDtv049by60oL2PZSigF/5/BmXSRrV2osgRIGoHtjbZjT+AFPV+6i4hJ+/+ZWzguSgLmBdrI94h6Z/kz2PsV+Sa6r/KMTuGlgr2RAer64xREgU39/vE6J405lmgRsDhNtDx9N1zEnqtD0xlkhDnAif7CCHLkcnP2kmnp8nJNscsKzkZDLZ5EMXldx1N1/u8n94YXXSpUc0S3Zc8AGtja04VQi5HLNwe7vIi7cYvPmaV3eD8kRpifQiC/nKi/B5vYjmEKFoyDCxHN07LtM7PylVcPl5R/G//e4Cakw2k367oMIdAuPeE+V0vKAqzod1IlhPCkggZnNDdGZw+sOI7eAes=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(18002099003)(6133799003)(22082099003)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Mihw4EgU+5k2mx5On2h7Cpfi37Cn36GwSzYzANSS+R0qN15r2oCxAxJeG9zbDRcNXkYDqiKE/s+kFpEsBtxWntzUqm6AaVqfLblwdau0SAQH823BDQNicAeXALjfJfAPa6fBQU970JDmmaGYQCnYi2g/v5KJNATmY0HZC3otxevmiqL6r1aKP5cPf4Ho1LRQwPbDy4Z2+vrLFVeeGa8rl4ClzV29Gok+g5AMekyFs5yW1N+akDj0e2DoFKvla7Ou4GBDuVntwxb0swU1onJYeY2MfroksvH4lxZr69azmN+YkdF4OrjQlDM8BpcCIiwiTlSYCkplB3OWw9hzfXyOXLwLup0qv++E0fcBE3YpCjBSevBd9WowLQ+U5dGQ4CmQmMu3mCoOlPibqb594pG3xeiqEHArHmQm2ixIMXgxXP+AFXmU7h934M7gcuwYn8jf
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 14:19:35.3431 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eabd7c47-1525-4ee9-19e6-08deb80d2698
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7068
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



On 5/22/26 11:45, Francesco Dolcini wrote:
> 
> Hello Shiva, Andrew
> 
> On Wed, May 13, 2026 at 06:36:40PM +0530, Shiva Tripathi wrote:
>> It's not expected for all K3-platforms to build OP-TEE with RPMB
>> support, some platforms lack eMMC entirely. fTPM is an optional
>> configuration for users who need measured boot, disk encryption, or
>> similar TPM related use-cases.
>>
>> The Yocto SDK we release for K3 platforms includes the fTPM TA embedded
>> in the OP-TEE, not sure if the same is true in your case.
>>
>> RPMB provisioning is needed for full functionality, but even without it
>> you shouldn't see these errors. Maybe the fTPM TA is missing from your
>> OP-TEE build, or something similar is causing loader error.
> 
> Any comment on this? We are just integrating current meta-ti master with
> latest master U-Boot, as I wrote a few days ago. There is nothing
> special going on on our side, and your recent changes are introducing
> this unexpected behavior.
> 
> 
> On Wed, May 13, 2026 at 08:49:31AM -0500, Andrew Davis wrote:
>> This makes me think we are at the stage in boot where EFI variables
>> are trying to be persisted to some media, and when trying to use
>> the fTPM for this it fails (as would be expected without RPMB).
>> So this should be harmless, but why there is such a large error
>> printout we need to investigate and try to make it less verbose.
> 
> Any chance TI can help on this?

Hi Francesco,

Yes, I am looking into it. The logs are showing up as OPTEE's fTPM TA is
failing to load, since the eMMC RPMB isn't provisioned.

I am able to see these dumps on am62x as well following your setup
details i.e. with upstream u-boot, these are briefly flashed before grub
window appears. But with ti-u-boot (part of meta-ti) the logs don't show
up during boot.
The meta-ti already uses "CFG_TEE_CORE_LOG_LEVEL=1" verbosity for
OP-TEE, which doesn't prevent "dump_ta_state" from dumping these loader
errors.

Even though these logs don't affect functionality, you can revert this
patch to avoid confusion. I am checking if there's a cleaner way to
handle this.

Regards,
Shiva

> 
> 
> Francesco
> 

