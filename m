Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 359C8C5DF71
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 08:00:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 583CB848A1;
	Tue,  2 Jun 2026 10:00:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GpHgP/4+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE84D8488B; Tue,  2 Jun 2026 09:05:09 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2359484881
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 09:05:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-kaur@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7uGVDPnN56gEv7Vkpcf3AiG+1PnU5Ta1YeMuhtUUeUAMJU4rk8VVWTePpcdUuk+PEqRb8RbfQMZHGv8bTm07QyU1OcmIWI6b7DjCTfZflQmxG7rLMH47RX3J03ok44+TYrmHKkuZChrVV7H5yr75qz5qk9IUbmLjpQYhdGeEbbS7qdchYH7fvRJrYHgQqMTalrLhN7TeGgYz2U4c8AYKDJJvMZHYo52UN2txN6wcWEy3m8h91Rp5DnisEMnJdb8Pj+HtJ9aE7O9p6s2BSIKxTSJi2M5G2+MWNzm4YepVCV3iM9odOnLQRHfZMKpWSmGicSLfubxHbCky+VGSz1lbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7axsNRgi7/RlnBOf3m7orhQgsglWotQxNjEUeAWIsc=;
 b=a68OpSnXV2XMSeaCEvPcWRnVBsLffhiY69+zucLEDhZcdB2MChM5ZWd9Zuu95cfGMhOcrn2QeFAc/HUK7n4TA8wJWOQvodocDCxMwtnm1x0T2xDe/TpjOfbKOCbT05c2PRwRHtV10yihAfj1h+UG1va87BMH+NnqbXRh3s3TxTzHg/t2iSk/NvSnmlTdPSMezv/EcBtjs4CRoQ+d4RXSi6IQv1pgEi79PScIoNr1PBtU6aBWumvp1h8sCNqHyeZSLU56EHpgiYB9FDh4Z9AudUxl2a/Rs6JgxJ6r+SU9OykWmiQAnOogZua30qqtbuFp8EpX5TdT8+r8relr63WUwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=linaro.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7axsNRgi7/RlnBOf3m7orhQgsglWotQxNjEUeAWIsc=;
 b=GpHgP/4+PiIocJX8s3L6sZFDKXHWFO1AuzKamL9bql4KKpLJS1CHfbe8/aFOWmY9PvpKfkUzeyHE+nzMq5HCSOBqgAkBaaLn8GEuOg6kzne1ydLhNMmTPAN+p3Lb4qkX2K5fO8w8X8xUx/e+D7lxVD4HoAkQh1+L6gOxhryHyyk=
Received: from MW3PR06CA0029.namprd06.prod.outlook.com (2603:10b6:303:2a::34)
 by DS4PPF715E13019.namprd10.prod.outlook.com (2603:10b6:f:fc00::d28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Tue, 2 Jun 2026
 07:04:56 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::14) by MW3PR06CA0029.outlook.office365.com
 (2603:10b6:303:2a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Tue, 2
 Jun 2026 07:04:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 07:04:55 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 2 Jun
 2026 02:04:49 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 2 Jun
 2026 02:04:49 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 2 Jun 2026 02:04:49 -0500
Received: from [10.24.72.113]
 (akashdeep-hp-z2-tower-g5-workstation.dhcp.ti.com [10.24.72.113])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65274f8X2721431;
 Tue, 2 Jun 2026 02:04:42 -0500
Message-ID: <7a1d3b26-652c-4c83-a5ba-d9bb4a81ec97@ti.com>
Date: Tue, 2 Jun 2026 12:34:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] arm: k3: select tifsstub via
 board_fit_config_name_match
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>,
 "aristo.chen@canonical.com" <aristo.chen@canonical.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "vigneshr@ti.com" <vigneshr@ti.com>, "p-bhagat@ti.com" <p-bhagat@ti.com>, 
 "c-vankar@ti.com" <c-vankar@ti.com>, "m-shah@ti.com" <m-shah@ti.com>,
 "peng.fan@nxp.com" <peng.fan@nxp.com>, "dannenberg@ti.com"
 <dannenberg@ti.com>, "mkorpershoek@kernel.org" <mkorpershoek@kernel.org>,
 "n-francis@ti.com" <n-francis@ti.com>, "s-joshi@ti.com" <s-joshi@ti.com>,
 "trini@konsulko.com" <trini@konsulko.com>, "afd@ti.com" <afd@ti.com>,
 "sparsh-kumar@ti.com" <sparsh-kumar@ti.com>, "semen.protsenko@linaro.org"
 <semen.protsenko@linaro.org>, "b-padhi@ti.com" <b-padhi@ti.com>,
 "glaroque@baylibre.com" <glaroque@baylibre.com>, "anshuld@ti.com"
 <anshuld@ti.com>, "d-gole@ti.com" <d-gole@ti.com>, "w.egorov@phytec.de"
 <w.egorov@phytec.de>, "patrice.chotard@foss.st.com"
 <patrice.chotard@foss.st.com>, "ilias.apalodimas@linaro.org"
 <ilias.apalodimas@linaro.org>, "vishalm@ti.com" <vishalm@ti.com>,
 "u-kumar1@ti.com" <u-kumar1@ti.com>, "bb@ti.com" <bb@ti.com>,
 "a-limaye@ti.com" <a-limaye@ti.com>
References: <20260528132746.719699-1-aristo.chen@canonical.com>
 <20260528132746.719699-2-aristo.chen@canonical.com>
 <ceb5c957137128e8a003616616755ffdb91b0c42.camel@siemens.com>
Content-Language: en-US
From: Akashdeep Kaur <a-kaur@ti.com>
In-Reply-To: <ceb5c957137128e8a003616616755ffdb91b0c42.camel@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|DS4PPF715E13019:EE_
X-MS-Office365-Filtering-Correlation-Id: d54154de-fbf2-4897-ae9a-08dec0754072
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|7416014|56012099006|5023799004|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: jp742adnglBMGLJbnvspNaiUKW/cqDPnFQqJmwGCj4QI45eQvuInIPhbL3EWBEft3pohIyK2ne05ITaroYpIXE68gmXiI0kqB/tWQPI0nhsMXEqeRarBDd2nWK5gnCGKj2RlmbgHxUbu+gmp3a7+5lsn7f24E25UIUB8hCjU+72GTJf4w6Ir3BA15W+fXwt6qz/jLiDtFr/10aXEyXWdjRqy/W9tfHYxIGaryPbEzMSQKHwPxB7U2PE0a1L72/5lBZW5tiw5MKQ5hfsahCnHsPYX24PbOkmXumKmqhLtYQZyrYw4btC25eDNlQshLd4nPZBbB/cEz0cOECZQU0EBs63w1J20lSX5YIhFAYr8Vyz/VSNkzjRlKPm/5XtPs0bNJKAsxKCLtsYmFfJocNZ+jWR+wu4o97Zwag4F+zYVrVBxEYqBIWukZckbQGBjRQaOSVquoaH7LbVgBR+VlBi1/G0zAov80gwcpIz3IMcft4prC7llB57MwmmYK1l+NrDMNd/7SGiQtZnHpVoWo5FKvqyk8pdGOZMKIz3fqyXcZBR6qnnFJd4vRWl/+OLYCKDIxp76TLVU877/LcIupmFTF65zsa8OqPGLvFyeGh1qKyxVov82yRlA6nDyLTyjEpo7KupBrzL43YeQlJ5KVBQABN35RgK7Gj5RwYEmGdtWbVXlOe+nVPyOuXA5XxmH015dqRQGmx1yDkBknzWHfAqr5+FGvTiRlgXpf539wL7y0LI=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(7416014)(56012099006)(5023799004)(4143699003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4VULeRuX0vCGCTHDXpAb1kNZSPNZUbiLspCJQRzkxo7ROGFPgvJGojttk6yoGTk9+B6NljZZ93ZPB6JE2nRgTLPJLpvhYclZZBizFKlqonUd6g5Qc8AseDxEQdwO86FrHSfcAlqFTRl6mevsPbQdP6qdDTmIIL3BW3YSX3s67DJSmrCIwv4qS7s14PuwiZOVlEk+kKXiP8zqEwBcV3DtpUNAl4n3+AgAUopZcNmYWFBGM59RNOAfbNWfHUHRqeVUquuPjEPnYzSKxpCnEFExe7GPZgMnchdHq+GOS6jejLWqFMLBzpRRKvacrqnbgKN1lDH1ws1rQjhHY1at61er5blIrkSWZ3ska7qbAHT0QMi2IVE1vdJvVjQK2PfTS/9Qvb5Lrsnd9nNigymE1xgpAkNuoXU95brMN5Krui69EUjuETAr2ngLgatsAzfiRwdP
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 07:04:55.6767 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d54154de-fbf2-4897-ae9a-08dec0754072
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF715E13019
X-Mailman-Approved-At: Tue, 02 Jun 2026 10:00:24 +0200
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


Hi Aristo,

On 01/06/26 19:27, Sverdlin, Alexander wrote:
> Hi Aristo,
> 
> On Thu, 2026-05-28 at 13:27 +0000, Aristo Chen wrote:
>> TI K3 AM62x/AM62Ax/AM62Px boards carry two or three mutually-exclusive
>> tifsstub variants in their tispl.bin FIT images, all at the same load
>> address. The existing approach loads every variant and then discards
>> the wrong ones at runtime via a *p_size = 0 hack in
>> board_fit_image_post_process(). Switch to selecting the appropriate
>> FIT configuration up front via board_fit_config_name_match() so only
>> the correct tifsstub is loaded in the first place.
>>
>> board_fit_config_name_match() is invoked by the R5 SPL during FIT
>> config selection. get_device_type() is a simple register read that is
>> available at that point, so the security state can be determined
>> early. The matching logic is factored into
>> k3_fit_config_match_security_state() in arch/arm/mach-k3/common.c so
>> it can be shared by any K3 board that wants this scheme. It matches
>> configurations by a suffix appended to the description string:
>>
>>    -hs-se  ->  HS-SE  (K3_DEVICE_TYPE_HS_SE)
>>    -hs-fs  ->  HS-FS  (K3_DEVICE_TYPE_HS_FS)
>>    -gp     ->  GP     (K3_DEVICE_TYPE_GP)
>>
>> Configurations without a security-state suffix (e.g. u-boot.img) do
>> not match and fall through to the DTS-specified default config
>> naturally.
>>
>> Each TI EVM board defines its board_fit_config_name_match() as a thin
>> wrapper around the shared helper:
>> - board/ti/am62x/evm.c   (AM625 SK: hs-se, hs-fs, gp)
>> - board/ti/am62ax/evm.c  (AM62A SK: hs-se, hs-fs, gp)
>> - board/ti/am62px/evm.c  (AM62P SK: hs-se, hs-fs, gp)
>>
>> FIT configurations are split per security state in:
>> - arch/arm/dts/k3-am625-sk-binman.dtsi
>>    (ti-falcon, ti-spl, ti-spl_unsigned: conf-hs-se/conf-hs-fs/conf-gp)
>> - arch/arm/dts/k3-am62a-sk-binman.dtsi
>>    (ti-falcon, ti-spl: conf-hs-se/conf-hs-fs; no GP variant on AM62A)
>> - arch/arm/dts/k3-am62p-sk-binman.dtsi
>>    (ti-falcon, ti-spl: conf-hs-se/conf-hs-fs; no GP variant on AM62P)
>>
>> The runtime filter in board_fit_image_post_process() is intentionally
>> left in place. It becomes redundant once every board using the AM62x
>> family dtsi files migrates to per-state configurations. The dtsi for
>> phytec phycore and toradex verdin boards is updated by separate
>> patches in this series, and the now-redundant runtime filter is
>> removed by the final patch in the series.
>>
>> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> 
> the patch looks good to me and makes sense to me, but I don't have a
> setup with TIFS stubs to test, therefore only
> 
> Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
>> ---
>>   arch/arm/dts/k3-am625-sk-binman.dtsi     | 61 ++++++++++++++++++------
>>   arch/arm/dts/k3-am62a-sk-binman.dtsi     | 28 +++++++----
>>   arch/arm/dts/k3-am62p-sk-binman.dtsi     | 28 +++++++----
>>   arch/arm/mach-k3/common.c                | 27 +++++++++++
>>   arch/arm/mach-k3/common.h                | 10 ----
>>   arch/arm/mach-k3/include/mach/hardware.h | 11 +++++
>>   board/ti/am62ax/evm.c                    |  8 ++++
>>   board/ti/am62px/evm.c                    |  8 ++++
>>   board/ti/am62x/evm.c                     |  8 ++++
>>   9 files changed, 146 insertions(+), 43 deletions(-)
>>
> 

Tested these changes and patch 4 changes to be working on AM62PX HS-FS 
device and AM62X HS-SE device. Tested deep sleep suspend resume as if 
stub is not loaded properly, the resume will fail.

Tested-by: Akashdeep Kaur <a-kaur@ti.com>


