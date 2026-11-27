Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284F9606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 13:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wdxjUBAt;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=WUandi6b
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7981160AD7;
	Fri, 27 Nov 2026 13:16:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uxsf3phvNTgD; Fri, 27 Nov 2026 13:16:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A7C7360AC2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795785418;
	b=CPf5h/SU6FRFf+JKlHfJ2RVju5b2+omtXDjnu9pwn3YxkOPvUNwjYRlROS4RAy7/E/XI
	 //4NOkXM7rmcgB4uAavcpAcQx9ESeOF0O/hpxeYEBRW/ReBvredszCQacVzezehMW+zr/
	 Ituk2wb7q+/XRugEtZmxmx86nv4YPiyiBtyF2Rjc1IvSJnXByEqAMvrSrSaz28GURXezx
	 yfL7vq51RqoQc3HNCkV4uPpdqSrMaZaxmrqegks8rzIBLJel3Ji7dscCSfUisxxZHNVdI
	 nLNhN+dnFPZ8j0kksgxWhfm/EJpLJG4wIjfpF5XrA9dKZImOM3eEBCjLQKMmJbtbgag==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795785418;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ilp2HuE187MZ6nVOIZ+GjQbrSFLKfHJY4Pe1apQDqK0=;
	b=hpcQ7LSWNQcCCGrWRkP3+sPawPqwYSjIQC5BrlPH5kBqx4XtYLCzty8vriKxtTGJA3fj
	 amTNiBJbMznqHO9BkayywKTUS2OXPka7ejFo+v6TXeHG4bTwiNXVksMmdF8K09b4Qs9Qu
	 gSI2KWvnJsSMbobFzWGU3JEB1L9WtHoKfW2H4BXLgFcTkgGeuM5z/BLatJ1oRBl+SZdnW
	 dN1G3BCi/VrNNHF8/39REgO1z+Dbmb/m9XFbfHLscQVSTEiFA4J5O6NrfcxaLeCR/VJzM
	 /xq6badGCMkh3Bz0KJ7dIQETkuiZcLuTiGKDa2LkYHG0WqIYsHePsq06RtdNt2g9kNQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795785418;
	bh=ilp2HuE187MZ6nVOIZ+GjQbrSFLKfHJY4Pe1apQDqK0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wdxjUBAtgGkIIk/fh9o7HOQNv3UhTq/tU5V0+Z2+JC4mqcaW35jsMv0uJ2R6ke7/d
	 1G6G8ulAnVgTu6LHKBt/4VrWH8cGGAzg2MWEBKj0MoR+2sW4ZklHRR14ysgLVCuQlV
	 +DXTblloA+MwCDRsu+SORx7SRlwkKsvAj+qSXgaa/xk1YlMgIyZgIR5vs9taOqV+d7
	 RLAMOrS8618UheHuY6/zIqrBlxP+xX8ewv9ATcyKDY+z/M1ChYABZy3Nx6jinZuWcD
	 d9FBcD27Hgjl/Tcv+7hECVgkS8w6OrT71wQKnJqc6OuP5qK1Z7Q6gEMQti+t4d9fbw
	 Hg93x4brpnZLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A7C7360AC2;
	Fri, 27 Nov 2026 13:16:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EA9F1373
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:16:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DC24F400F5
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:16:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GYg95KRA4eaT for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 13:16:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 10B034004D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=WUandi6b
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 10B034004D
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilp2HuE187MZ6nVOIZ+GjQbrSFLKfHJY4Pe1apQDqK0=;
 b=WUandi6bbS2VUgZpQFD1aCcBAcRO2uXnk0Zt3kof46JdyknCCcd5jYqz0jivBCqwV88DYq0y6eN+XZ+hz8nakcg38YH8kXco4vpJ1503tlzW9VWiCvOeBQcLYhLKTRKfm2QJRHKDudCjfdjhdVCFsDBqEa+yngMrKS9UQ3hRpagcMlCCzN1gdTYg+oFrh04bVD2LfaZXeGk2dL9CIBb3Zsj+9wacEwn7hIgbro+e+R2B9HEgu8uwyqmVDJR/xVdosddoQnr4HepKw4Bahrsq0a9LelQYxG3+za7tOQR7pFC6SSLHzPweUtkXQ9D4Fg5z529rFkgBL7uErh+zmlbF2A==
Received: from AM8P190CA0009.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::14)
 by AM0PR10MB3652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.688.4; Fri, 27 Nov
 2026 13:16:52 +0000
Received: from AMS1EPF0000009E.eurprd02.prod.outlook.com
 (2603:10a6:20b:219:cafe::5b) by AM8P190CA0009.outlook.office365.com
 (2603:10a6:20b:219::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.9 via Frontend Transport; Fri, 27
 Nov 2026 13:16:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS1EPF0000009E.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 13:16:52 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 14:17:42 +0100
Received: from [10.252.12.59] (10.252.12.59) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 14:16:50 +0100
Message-ID: <cca5d1be-c8b8-4f02-bb14-987ededc17b2@foss.st.com>
Date: Fri, 27 Nov 2026 14:16:50 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 22/35] video: stm32: ltdc: fall back to a panel when no
 bridge is connected
To: Yannick FERTRE <yannick.fertre@foss.st.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>
CC: <michael@amarulasolutions.com>, <linux-amarula@amarulasolutions.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Raphael Gallais-Pou
 <raphael.gallais-pou@foss.st.com>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.denx.de>, <u-boot@lists.u-boot-project.org>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
 <20261107143241.2236511-23-dario.binacchi@amarulasolutions.com>
 <f046379c-2128-4160-adb8-57370382d447@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <f046379c-2128-4160-adb8-57370382d447@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000009E:EE_|AM0PR10MB3652:EE_
X-MS-Office365-Filtering-Correlation-Id: 37c16f52-7b45-4e17-571e-08df4c88b393
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|23010399003|82310400026|10067099003|4143699003|11063799006|56012099006|261021135927099003|261009223027099003|261021123027099003|261021121427099003|261022105027099003|261102123227099003|261026140227099003|261028144727099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: yGSsJfQdWNvkithLQ9dSFVjulnr2yDX/6xAcsNudGefu7BYIirLT3mvUoHvx2rwI5Qd4RKyg2IxEscIga+k/cfjQ5LGX9rKfnINh6gMjFSat44VdLdWB+VZ4IIdazxbWB3cgfP32WT+IB739GLZU1rHjAQtHgMnP3AcH4jA59d04KzRh+ZD3mWr3obxDuzkr6q7l0xy3P4isWNTOIYjKSIXbiFW9yumeOzVFW7K68WEE+2B+3hTeeNw7XGdPA+0ETq9YSJtKRbWDS8Tul1zIDqXON92jc0i84nKGpqlXeNPCFhfzlcQcpuHSegWeb3+b63b9HNQwDU+11nCRE+Fgi9F3foZpuxxxWPPDCtZVbl72n3/xUtoerCr5Xi7dmX6UNlZX3vTFmNRiV03Aq/XLSpzM8/F1Y91llAvjslytu7YZf9NpJk26tLzQUT9xo/Bh9ywZMJso5UWrpA44NKV3dARs8PwOgwWktzuO3hWoH/L3BZ8y4NWwYz72OdN7+KheRXk41ht9FcyJKfmBxiaPumBN/0yaUHsZ5d6yb7IkHdwBnnP+xwSLSgUWbaFL8iGtECxHoCOcWRYDnHXdoyuyHgwu95cV/X5eCPz2GS3hdSDnxaoBBpEXlj7bkpxZeCky7ycjoulRVGrC3uKmr6QLr1jY1JEiX2i0DVJGLoivIQW+pzcmrwqjVUuGQHmnfp/lGpaok3FbCSOg5KMvNZ9EbA==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(23010399003)(82310400026)(10067099003)(4143699003)(11063799006)(56012099006)(261021135927099003)(261009223027099003)(261021123027099003)(261021121427099003)(261022105027099003)(261102123227099003)(261026140227099003)(261028144727099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: j6gXxAiULvsAR8mDlTdK9s9TkRKdZbvvUcPMA+oPSAuhkWojqA/4IfBu/p1zoAbouFXR4HmXrj/9U1D+r0ZwTtHFOQ4tAKqDEhSKml4G4tljOsy1dck3tTCPm+55T/i6ZGe1RPoLcIZf7pVc/jarXF6DLohbXub0LIANElg02gQ92d+RnWwP5zdcMahR37VdrqCHpbzmDu6gLWlQYn/PT65gJJdsh6O2jQT7opBUg1X1kbtnDeEf20G6AhnsiZz86tEU59TMrR5CsablKx3+ZyyTRHhg0phfAWaMZF7FKTfj4pwtu8vsygfPGCPSUzfz8v9a5uQKbM0esYTL+PUpf7ta65B9YcTIi+D0mefBXGyERHLzWZixOmzj4EBmYafDyX04JjiABl3r8aXmUgodBDqcwEk8ePQodinBLgGfxzPe5fOuow6DkHlsMHnIOJN6
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 13:16:52.1088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c16f52-7b45-4e17-571e-08df4c88b393
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF0000009E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3652
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/27/26 10:45, Yannick FERTRE wrote:
> Hi Dario,
> 
> thanks for the patch.
> 
> 
> Acked-by: Yannick Fertre <yannick.fertre@foss.st.com>
> 
> Tested-by: Yannick Fertre <yannick.fertre@foss.st.com>
> 
> 
> Best regards
> 
> On 11/7/26 15:32, Dario Binacchi wrote:
>> With CONFIG_VIDEO_BRIDGE enabled, only bridges are looked up on the LTDC
>> endpoints, so a panel directly connected to the LTDC, as the RGB one on
>> the Engicam MicroGEA-STM32MP257D-RMM board, is never found.
>>
>> Look up a panel when no bridge is connected to the endpoint. Also, reset
>> the bridge and the panel when no panel is found behind the bridge, so
>> that the next endpoint is not affected by the failed lookup.
>>
>> Fixes: 35be94614733 ("video: stm32: ltdc: properly search the first available panel")
>> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>> ---
>>
>> (no changes since v1)
>>
>>   drivers/video/stm32/stm32_ltdc.c | 17 +++++++++++------
>>   1 file changed, 11 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/video/stm32/stm32_ltdc.c b/drivers/video/stm32/stm32_ltdc.c
>> index 267da5debe4e..7bd6724bc2a7 100644
>> --- a/drivers/video/stm32/stm32_ltdc.c
>> +++ b/drivers/video/stm32/stm32_ltdc.c
>> @@ -593,16 +593,21 @@ static int stm32_ltdc_display_init(struct udevice *dev, ofnode *ep_node,
>>         if (IS_ENABLED(CONFIG_VIDEO_BRIDGE)) {
>>           ret = stm32_ltdc_get_remote_device(dev, *ep_node, UCLASS_VIDEO_BRIDGE, bridge);
>> -        if (ret)
>> +        if (!ret) {
>> +            ret = stm32_ltdc_get_panel(*bridge, panel);
>> +            if (ret) {
>> +                *bridge = NULL;
>> +                *panel = NULL;
>> +            }
>> +
>>               return ret;
>> +        }
>>   -        ret = stm32_ltdc_get_panel(*bridge, panel);
>> -    } else {
>> -        /* no bridge, search a panel from display controller node */
>> -        ret = stm32_ltdc_get_remote_device(dev, *ep_node, UCLASS_PANEL, panel);
>> +        *bridge = NULL;
>>       }
>>   -    return ret;
>> +    /* no bridge, search a panel from display controller node */
>> +    return stm32_ltdc_get_remote_device(dev, *ep_node, UCLASS_PANEL, panel);
>>   }
>>     #if IS_ENABLED(CONFIG_TARGET_STM32F469_DISCOVERY)
Applied to u-boot-stm32/next

Thanks
Patrice


