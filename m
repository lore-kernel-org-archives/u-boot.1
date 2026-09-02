Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D82C624DA
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 13:17:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D631060AFC;
	Wed,  2 Sep 2026 13:17:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 17fLGTe0ZuAE; Wed,  2 Sep 2026 13:17:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788355043;
	bh=NFbCjEU8/TJ/g19gN5/cccQK0VrdZMNRnVHDMPHuUpU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JCic5+ikNl3iJaL3GJrdREIKZ5hFq8lwmnyrQ3w5BzgQGWVMa0neIuzvqKBoAxeWO
	 UpVz/CGLA3A0x3i+MVOb7/8N27NO8iMCXcRqB4b0h9rldJ58BMAnkXbZh6ngOuK5Oc
	 PywcAmrbtJO9zKvqxch4Ov7do2vAfWUngrZ/RmXKzmnMUysvxMDKQjxIW/nMkr2Ra6
	 Es7/rst7p1sObppIpt1AvPh/62jQR6Gowj1j+xjya2OlaLBinlRq4Ylen2q0ZwcaFa
	 7OpjO7YoCEYzPQKYOUP+3yhNJpybog56IC23B19rNPF3mznww55oUK+UTLPjrLPbiQ
	 /q9zhQBnD8ZhA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 99D7E606F5;
	Wed,  2 Sep 2026 13:17:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8BAA7498
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:17:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 70AAF60ADD
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:17:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CDzQfJzGMuEu for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 13:17:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=Zlbd8e9V
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 97EF8606F1
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:17:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CD82ITDYIdX7EGtCbIWesyDMozFTiFh5NFupJIeJcONtUS26HVu6ZewAIqAwHy1kJxmf3xwqUcSuKWKXGZT5JZLZyHTloTA3nbGw4AEq0sz/aSvutcD4z5u9ELGNcWJRdFl5FMaElPYbj5JTLOoXHq/x23NOmjwM0MlkTLq3gl/Sn/bxhXa+VyDrILGTA2d89c8pODsqFwICU0jjTE645dN/OrN6Xv/Jp7SQVcSDLzd+6Hat4+0L2k19jaaiThDJeiidBXtOHAf4SuZfmN7NdMOIn0AjwkPuEgTISkxCof3Jf2kYuE5FXMvxHWNzwLg+ogy4nV+DKPwMGZq1ynH5Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFbCjEU8/TJ/g19gN5/cccQK0VrdZMNRnVHDMPHuUpU=;
 b=E7q+gKz56L8lMjSLFN5Oxaxj3dXB2XzSLx2lmLEo51ujT/bmrd0MhIt+KSn8AtA8eoI3xPsZl0G0tw8AVOyAGMlVRgxwQ+FoV/1Y+rtr5qloqT2FQqacr9tMP0fCXBtYvK8YMuyVJNaSMamA8lJkFaURbsVd6jLr6Fx59JqvLWpnZe50mFiAWPohY1VBp2bBbexPz5aTcwXzOkH0I3zNmlapjI2azyzH5p6yDr9FVJ9QlwSeb9d2cODZwPiURoneQM+jCdjNMwI2PJyP4QYwQsFrpTv7HBB2KUtdMWQyn+qSMl9QmRDdBT5CT2tBAoSHZsm9y9VjNNR4fWyTXT3LuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.88) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFbCjEU8/TJ/g19gN5/cccQK0VrdZMNRnVHDMPHuUpU=;
 b=Zlbd8e9VL3GjBOIi7gtWDpv0tN3H05ZaVulEffETB80029jyvfgm9xtlcQMyGphYw1UU6+4QsUGBtzUrKCap2wtXKKI5du/IjrzFxkYB6HVxH80TVEFxOjXtmCa6PvqmHIVwXT1gMrblNk6yvI8YqOX+/oz12meGbzMexzeTVrFMWJheF64+rq9p2EE9eeDb0Vh3gX05oZ8aXHBFSkZNv46P4Ud5AtMVxvsPHXYOg9ZHTNRCUMlfd5gSOpRe36ubRZW59nu3f4XOwefWVzxAtoKoPfFR8JumnuyNxLDSexwEWD+czG7DIUkY9nDpMEmcX2S4VMWkVLGV34WcgY8htQ==
Received: from AM8P191CA0022.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::27)
 by AS1PR10MB5532.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:477::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 13:17:05 +0000
Received: from DU6PEPF00009527.eurprd02.prod.outlook.com
 (2603:10a6:20b:21a:cafe::7f) by AM8P191CA0022.outlook.office365.com
 (2603:10a6:20b:21a::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Wed, 2
 Sep 2026 13:17:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.88)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.88 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.88; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.88) by
 DU6PEPF00009527.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 13:17:03 +0000
Received: from ENXDAG1NODE3.st.com (10.75.129.196) by smtpo365.st.com
 (10.250.44.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 2 Sep
 2026 15:14:21 +0200
Received: from [10.48.87.93] (10.48.87.93) by ENXDAG1NODE3.st.com
 (10.75.129.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 2 Sep
 2026 15:17:02 +0200
Message-ID: <aac7e28b-9643-4a41-a535-88c452865a0a@foss.st.com>
Date: Wed, 2 Sep 2026 15:17:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] board: st: Fix compilation issue
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>,
 <u-boot@lists.u-boot-project.org>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>
References: <20260818-fix_tamp_fwu_boot_idx_mask-offset_definition-v1-0-611201a282ce@foss.st.com>
 <20260818-fix_tamp_fwu_boot_idx_mask-offset_definition-v1-2-611201a282ce@foss.st.com>
 <5968db82-3945-4446-a03c-b02547605d79@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <5968db82-3945-4446-a03c-b02547605d79@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To ENXDAG1NODE3.st.com
 (10.75.129.196)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009527:EE_|AS1PR10MB5532:EE_
X-MS-Office365-Filtering-Correlation-Id: 38a54cbc-2e23-49fb-ab52-08df08f47b20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: zYb0FH/IacyjdwHg0JtcyKkZU3h8akyRinLUCR0x9PCw4Q883UpviQ71tBXcElg3qhBaWHRAUF9RjMO+g5Oq1ji2Nq0HYgOGV1sCcAi9Fb82R6L7Ag6rfv6nv2ywYtFK4tZpC0+anV0B4Siuwp5HPAcsgxW4SqXtvT8Y/tH3pJDiVThcNRv2MF9OgqsVgyTwWQcjqT8enXLQ10Z1hHCFfg8yh25oG1mswk5jhA/q58EIOdGTospiYVeYojwqLivpdULj9HT7lh+kj76dwsWbpQTeSuaXXy9nWYOtJI+6vLITTVB+8dvXpzEySIKNGhqbIXSDhVBbJ36tFGXcSztxyJlaQLi5OE+fN3Db17tNnunl8pwkbBgPQEoKcaMMeM+cYepy2DNoCNwnlu14yWUMsEv9W1De7J8q515Hn/u25RsaTDWvJ65l/bdl3aHf9kHsT236j2QSOzE3md2NUAORzHlK4xXKIYwmGTFcDVLFykAzF7lm/uJrQUWqf27rESV1+nBKqjmHoZT8FrUp8BiyQd2ZO7OIjtcXgo1zCMnpDyFr/YWRCrXUMaJ7KMbEIm130CyIbbETEqeN+Imz0F/M8TIxnMKWHkNMr7wXXJN64s5Kb1INyjGYBphvRW38wc4lgc/7R8WsnZ2E3kTrUsH9pn3ezV8MtsUKp2cBEpesPDvaSPCmoj4WCnjpt84g+mu4cmCkt6cSG+1g0Ybmaf4RTQ==
X-Forefront-Antispam-Report: CIP:164.130.1.88; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 85tHYCGclML/9TbaSMjCTUCMqJwjad/RLDnsAe2FvPFTrrtlpRP3DUOgC4SbRmOMrjVJUL1I4xVbrZlfSmV8u1cPWrTcDzVQOmbxG1K6qyueXKauhvjAd+raG4X7BJ2STn+/ahAd6xTklTkt3fkKR1WsTzwdTsb3yCU6v30ozqvZHg5DENCTFuQUHXi+WANE7gZYU703EB40yu6X/KYmheFFF2TJQ1HnjgbcEhGH1hlbLEp6QoRsOEoaF3AcKGGjmOM+hWZl9nbcawyVKb3X5Ac/H81sTNF+Fzxq2fnodaltXkBqhPil6XwLhdjFTRRs21VMKv91aPd4K5g/O522TFMzkyEu0rhXfBTRYbh44G6isc1KhHCMYBcikcwEG9GcLn1uZRS27i9znu6+cAfcU5FS/jqmltiIzFhuoB8/1WWz+Hw6ljPPB9gJMMfVNgbB
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 13:17:03.9457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a54cbc-2e23-49fb-ab52-08df08f47b20
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.88];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009527.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5532
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org



On 9/1/26 11:01, Patrick DELAUNAY wrote:
> Hi,
> 
> On 8/18/26 17:11, Patrice Chotard wrote:
>> This patch solves a STM32MP2 compilation issue in
>> board/st/common/stm32mp_fwu.c when CONFIG_FWU_MULTI_BANK_UPDATE
>> is activated :
>>      - error: ‘TAMP_FWU_BOOT_INFO_REG’ undeclared
>>      - error: ‘TAMP_FWU_BOOT_IDX_OFFSET’ undeclared
>>      - error: ‘TAMP_FWU_BOOT_IDX_MASK’ undeclared
>>      - error: implicit declaration of function ‘env_set’
>>
>> Fixes: 4369c6a05035 ("board: st: factorize STM32MP FWU multi-bank support")
>> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>   board/st/common/stm32mp_fwu.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/board/st/common/stm32mp_fwu.c b/board/st/common/stm32mp_fwu.c
>> index ac7ca6bdca2..cff020a99bb 100644
>> --- a/board/st/common/stm32mp_fwu.c
>> +++ b/board/st/common/stm32mp_fwu.c
>> @@ -3,9 +3,11 @@
>>    * Copyright (C) 2026 Amarula Solutions, Dario Binacchi <dario.binacchi@amarulasolutions.com>
>>    */
>>   +#include <env.h>
>>   #include <fwu.h>
>>   #include <part_efi.h>
>>   #include <asm/io.h>
>> +#include <asm/arch/stm32.h>
>>   /**
>>    * fwu_plat_get_bootidx() - Get the value of the boot index
>>    * @boot_idx: Boot index value
>>
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 
> 

Applied to u-boot-stm32/main

Thanks
Patrice

