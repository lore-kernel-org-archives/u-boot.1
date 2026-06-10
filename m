Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A73CCD8CB9
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 13:28:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A65EC848D1;
	Wed, 10 Jun 2026 15:28:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="N67TrdVC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C013D848DF; Wed, 10 Jun 2026 15:28:10 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6680C848A1
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 15:28:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-tripathi1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7SKDe8qbKRPnoc7/sIxG1JXtSVe0C9oCTBIESo/himQ9Fr1ft59HBxwc7cQkEaJ0/AP4SK+tP5Y+3lubYajS7eoRFZzTwyRxem5zx0vLioZn6rjKU57uZtlwOimdfumJMdW/8Sby2SL+CR/xOO1iS2/727wXygf4koGYK2NPNB3PQtmHQRYQaSAhhgraE1bVSwZ6XFLFbu4B1y4gyeUAE1pjNG9r5ZE6FzYQ7bUlJoiq+O5yd4+LUV8L/mBcOsTzOuTF3Cd17rXgbr0IBc5Nxbc6Wljbyyj6d/r9rbpWNSRoiLoiKOYYh3w1kjzgSH+zWlS4larxuHkALBYfgR5MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpuQRlxUbbd6p4MCEBAZ7oCBCv4nrTOayQZ1n/A7lKA=;
 b=oDHvGypr3m9PYmItMLocQZ/Sa/M2kMN4EYRkFcMfCPWwNpQHbyi0m9wYKj3utrTIUBU25S7jfs01PKOnoFfMqRPRbK92D1NxIxrooBFF2UprJHQ9N49RkXiWeMKL6k8oqHsgav7R85aXqjk+f0fxLR5G3sJDEIk7vClnSCLQiG9y8NzHDhUbGGY98Cnniu+7pVpk11e8EFu1nubdq0GMV/MqwJbOcJG6n4J7+lJwQu0Ja5FnRFJEvQWzbkzlEguqWtUykRglKjeiGDut9XH37NCLdx9tc3d0LFREJpkOM/wM1xOsvKJRkqz+C2cvVVsOGg1lbCUFw1aI/lzqHCHRKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FpuQRlxUbbd6p4MCEBAZ7oCBCv4nrTOayQZ1n/A7lKA=;
 b=N67TrdVCiCiuc743Y/FwFZh6myhXOyuKsNDDiIJ/IGV82wnANGGrWgaHqtT6gGkExiRWnLE7xadvrpWcpLmhn8TiYct1sVIR28IAvC/OcY5nrL82P87iozN1W8FH154u+VU8ur6xb3chSa7I1Y7Gr3gq3QfisgPVQuEIMaRuUiI=
Received: from SA0PR13CA0020.namprd13.prod.outlook.com (2603:10b6:806:130::25)
 by BN0PR10MB5078.namprd10.prod.outlook.com (2603:10b6:408:129::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 13:28:04 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:130:cafe::81) by SA0PR13CA0020.outlook.office365.com
 (2603:10b6:806:130::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Wed,
 10 Jun 2026 13:28:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 13:28:02 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 10 Jun
 2026 08:27:59 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 10 Jun
 2026 08:27:58 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 10 Jun 2026 08:27:58 -0500
Received: from [10.24.68.200] (hp-z2-tower-g9.dhcp.ti.com [10.24.68.200])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65ADRsdR3375630;
 Wed, 10 Jun 2026 08:27:55 -0500
Message-ID: <9b1540d5-81dc-45f2-a188-915a8b4b4c90@ti.com>
Date: Wed, 10 Jun 2026 18:57:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm: k3: Kconfig: Enable fTPM and RPMB support
To: Francesco Dolcini <francesco@dolcini.it>, Tom Rini <trini@konsulko.com>
CC: Andrew Davis <afd@ti.com>, Ernest Van Hoecke <ernestvanhoecke@gmail.com>, 
 <vigneshr@ti.com>, <bb@ti.com>, <u-boot@lists.denx.de>, <u-kumar1@ti.com>, 
 <praneeth@ti.com>, <kamlesh@ti.com>, <vishalm@ti.com>,
 <k-malarvizhi@ti.com>, <anshuld@ti.com>
References: <20260522061515.GA8642@francesco-nb>
 <0c76975d-1f87-4a6c-87c2-cff99584fa1e@ti.com>
 <20260522162048.GA114365@francesco-nb>
 <20260522173637.GW1858239@bill-the-cat> <20260610055141.GA13255@francesco-nb>
Content-Language: en-US
From: Shiva Tripathi <s-tripathi1@ti.com>
In-Reply-To: <20260610055141.GA13255@francesco-nb>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|BN0PR10MB5078:EE_
X-MS-Office365-Filtering-Correlation-Id: 66c4e270-7d3a-421e-178c-08dec6f418f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|22082099003|18002099003|56012099006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: Nb947ipB8UGvfG5zuI3qcW1fExExL3/FdAKEZJ93zrBaCvQs9qSDe57yYxntjzP6Uki3a2O7AqXx1ZDu5ip3EzRcKLzP4tqWEjB5Ky2xmC4RkF4mUuL/KuHKda01JpLvKgr56GzHBMbua37hRrgN7KvykiDQxfn/rT398bZVUKQ8+fUjIMTV8hgH67MZfs5GhpLS0AZ/JQyavULj5FZsx9WO7/eTBFhfv84bcTZcj9BdR7k2oP1zFh6NjNDp7hmMScvcXJidiQF+3Ezbmpix8aZT8iiXS6xGbzyPVHWSoFluRO1IKXna+43vdgVVJCBCXhq24xYlIirXnefbdNMOR8AOKlw6uCq9tDaXvPL6VohVrHyuQr78JQ/KNnWXXRJHvDkSTrDXNd2/dLssnhgnf84ifZhsPZOIR8fga4MhZmxdGSqbAFAENp2AGaJH+kBYtH/sTfopY7/LHh19ylUAhw2hmTo3vmDv/7UIV6v9JW/o83mYxDudLrof9V3rPKpfGoHnpGDdbp6VDqWIgwC/CtEM2Qk0S+cTFr2JQJGdjetagV2zN/EGBD7142NFB3maJ1XUlqTbka8voFFarNC3nqSiWUvz4xL8jotjbArUmZw9ikIiHOc1rVAelgY2Mws7QWJnBt5e2A+jmUNUvchB5JPcxl3D1TPVb3SYcIPNEla1VgAkuhnlx/lcrpe//xGpZnVEcukga6T6vp3YHG2QF1VnWiBbq8AtQklxgekAw9Q=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(22082099003)(18002099003)(56012099006)(4143699003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: o4mieCr13u2+/EvdbL1u2F/DfGBr36x49IGVK9RJyv0RvERkCLRnb1PpQsNKVfvrP6YS9EqUF7B/3mEpU2bis0RsZBMcLt6ykQkIXfpgnLtiZlYixXBJ4p2RUjtmNHmrS0p4MuUtU6iBozlFnsd4M2eThZGvJpZaweU5GEyB+/dCtpK5Tn+4A3KVjm2PcjKWonzQ8RACy8eKOb5YW73Gu3A0e3C3ItIcWbY1DcgXWeIlY7l5nIUvG67BtiedNMlVZ+Y/6j1KNm/NXTBNnqFqWdOltMVIDiift+HmFGoFCmxGEVCsyS8DHV5bQsL80xD9sHOYMUsZr4PFbsHck4eYwsQDCXS72ToQuWkftufANkpx971yPVTWr6aAgFVVEj2L5vKwlA87QlZHe3ysp8pqx4izGOduUcd+7A5RoA3nJyXUpSo1RSbqw2M/cuUdljkF
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 13:28:02.5498 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c4e270-7d3a-421e-178c-08dec6f418f5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5078
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



On 6/10/26 11:21, Francesco Dolcini wrote:
> Hello Shiva,
> 
> On Fri, May 22, 2026 at 11:36:37AM -0600, Tom Rini wrote:
>> On Fri, May 22, 2026 at 06:20:48PM +0200, Francesco Dolcini wrote:
>>> On Fri, May 22, 2026 at 07:49:27PM +0530, Shiva Tripathi wrote:
>>>> On 5/22/26 11:45, Francesco Dolcini wrote:
>>>>> On Wed, May 13, 2026 at 06:36:40PM +0530, Shiva Tripathi wrote:
>>>>> On Wed, May 13, 2026 at 08:49:31AM -0500, Andrew Davis wrote:
>>>>>> This makes me think we are at the stage in boot where EFI variables
>>>>>> are trying to be persisted to some media, and when trying to use
>>>>>> the fTPM for this it fails (as would be expected without RPMB).
>>>>>> So this should be harmless, but why there is such a large error
>>>>>> printout we need to investigate and try to make it less verbose.
>>>>>
>>>>> Any chance TI can help on this?
>>>> Yes, I am looking into it. The logs are showing up as OPTEE's fTPM TA is
>>>> failing to load, since the eMMC RPMB isn't provisioned.
>>>
>>> Thanks for looking into that, and I am glad you can reproduce the issue.
>>>
>>>> Even though these logs don't affect functionality, you can revert this
>>>> patch to avoid confusion. I am checking if there's a cleaner way to
>>>> handle this.
>>>
>>> I am using mainline U-Boot, if this needs to be reverted, it must be
>>> reverted here. Given the release timeline, and the fact that this is not
>>> breaking the functionality I am fine waiting a little bit to see if it
>>> is possible to fix it, we have some time before the v2026.07 release.
>>
>> And for the release I would like to make sure someone has a clear path
>> on what changes are needed, if any in the end, on mainline U-Boot by
>> rc4, which is June 8th. We have the last one on June 22nd but I'd rather
>> not have to revert then unless things are just unresolved. Thanks!
> 
> Shiva: what's the plan? As of now the issue is still there.
> 
> Francesco
> 

Hi Francesco,

I have sent a fix patch to optee_ftpm[1]. With this patch, the fTPM TA
gracefully handles RPMB unavailability without panicking, eliminating
the memory dumps.

For now, there are two interim approaches:
1. Revert the u-boot patch that enabled k3 fTPM configs
2. Apply the optee-ftpm patch in meta-ti recipes

I am waiting review from optee-ftpm maintainers. If it's accepted, we
will upgrade the optee-ftpm in meta-ti to the fixed version.

[1]: https://github.com/OP-TEE/optee_ftpm/pull/27

Thanks,
Shiva
