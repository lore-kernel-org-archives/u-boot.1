Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8AA606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 09:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Mox3DFYY;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=Imb8Ywbc
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DA8E08116C;
	Fri, 27 Nov 2026 09:45:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CygdBnzToOzU; Fri, 27 Nov 2026 09:45:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1CCD6811C5
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795772755;
	b=Pfs2voJJJh0RUNO0AdPuuhKiCb/NKjWjqR0Jk36xnZZ398q2HLptbbHfgLxbhbaqqYjr
	 SAARFcvow+dy5LRWKfqVjIRMxF9I2fMq3fcROyz3sn7+4s9cdDcyKicijkCIT/A7gXDKV
	 zT0r0ibiOIboIH+m//jJup6QCPaQcm9wcC722rT674FRhUrY2n+a0PTj/kldwe8XU5mSH
	 UZY6d/tYYWw2uNQfzgxv/2l8XQNzxyhB6sFeUWgtEfRo9lWFHUyPnSskz+5TKp2x9YHv7
	 X7yn/MBUOaQYzYTJG+DvEzM91NIxGmJ+5ilFa6z+dR3WJVg8gjeUiODhDZMJ8VhE+XQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795772755;
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
	bh=zXkc/IHoujpLHyApn/58ti7iI7FfXPeI3P38W2w3IXE=;
	b=NHcafvHcMr01l9NS/0VjY5mi2sJCqnIjwk5G7aonLG353LpJqg4XCUhEPODuU7gxXgCk
	 vQ/Tszi0cNgtKmBcR9zpAT0V3IYht2nq8oohc4A0RqyOGuCOo9pETFxJvkPixyfRCJmC8
	 G1rVjR/50CNT6FCFym6rwPMSFJwTn3/gqGq6f48J5Ncdfflvkmn/wYbfg89EPkAgWtAuQ
	 eHO6IUYZ5779a+c2+bwL57grpjbmfQ5W9RLGw9EvHCz/YUs6HaGi4LzKkasz+yWHnmc2x
	 vnkMnEKUverWvXSdDLFHMWWPVVUrP4c84IzebR+0o7o43ZuW4EVmcqddeJx8m35jFow==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795772755;
	bh=zXkc/IHoujpLHyApn/58ti7iI7FfXPeI3P38W2w3IXE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Mox3DFYYGp507AsP3uy3WFKrb7Bf4XtTIcR6bg3+D+7/2h1LbGnK8irE3kAkymyZs
	 ITTZiV0VIucn1zF4cUugzRQHvCbES5GhC9dWdeLh8malHlukP+m9gDzVc+Xqp4McHT
	 AuWhsO5hhyzp7sr7nt04Z3GI1/gzuhVyepxEb7ToHjs9iCZ78vudrLm/cybZrPQbuj
	 7hO+Src5EcOXj2PfbU5N4jcEB710lTnAOweH3GvvnILn0HD2MZKIFnDHZgeViwT6ih
	 t7HB3Q29ckNy2yB1woH1DUESGe+j3on8pjREWfL8DiHJJb6IxvfGK5pA7tujra2KXm
	 D+7dJIhuozqJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1CCD6811C5;
	Fri, 27 Nov 2026 09:45:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A0258D1
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 09:45:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 85A63409D3
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 09:45:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OK51PxtdIGTP for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 09:45:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 70365409BA
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=yannick.fertre@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=Imb8Ywbc
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 70365409BA
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 09:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXkc/IHoujpLHyApn/58ti7iI7FfXPeI3P38W2w3IXE=;
 b=Imb8Ywbcqw+SznywSaDg54TTt/c41O7uWAMqygglgN7bTlYD4oVhfT0EGDqzLCd1lKB79PcYTUcEI+u0iLmq0LiN/U0EE+ZHfxy2bSv8xSTApXenINVg5M5WR9iZq9Jqun26C4MUVNITx7daWkcsQd7emUtHnkK5FueoA1D+C1cgXgKKDO2VeHrgJJGzort8YD4uysr5SYfDiPjjkcMrdIJFRx7ByLouE99WXvsCR/CwsrILGW7hTp8hL1W0ZYecDgKa4fzHxHt7W0DOmUpgAwtWlBUbFqMWgg2mTxd9BvUY4Iq1KeBeuvb8xoV0H2oB0UyvZU5mW0vqbDvCGqIOuA==
Received: from PAYP264CA0012.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:11e::17)
 by GVXPR10MB9006.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1eb::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.688.4; Fri, 27 Nov
 2026 09:45:44 +0000
Received: from MAD0EPF000008C4.eurprd05.prod.outlook.com
 (2603:10a6:102:11e:cafe::a3) by PAYP264CA0012.outlook.office365.com
 (2603:10a6:102:11e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.9 via Frontend Transport; Fri, 27
 Nov 2026 09:45:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MAD0EPF000008C4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 09:45:44 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 10:46:50 +0100
Received: from [10.48.87.178] (10.48.87.178) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 10:45:42 +0100
Message-ID: <f046379c-2128-4160-adb8-57370382d447@foss.st.com>
Date: Fri, 27 Nov 2026 10:45:42 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 22/35] video: stm32: ltdc: fall back to a panel when no
 bridge is connected
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>
CC: <michael@amarulasolutions.com>, <linux-amarula@amarulasolutions.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Raphael Gallais-Pou
 <raphael.gallais-pou@foss.st.com>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.denx.de>, <u-boot@lists.u-boot-project.org>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
 <20261107143241.2236511-23-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Yannick FERTRE <yannick.fertre@foss.st.com>
In-Reply-To: <20261107143241.2236511-23-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008C4:EE_|GVXPR10MB9006:EE_
X-MS-Office365-Filtering-Correlation-Id: dba574e7-4505-47ea-f286-08df4c6b34ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|10067099003|56012099006|261026140227099003|261028144727099003|261022105027099003|261021123027099003|261021121427099003|261021135927099003|261102123227099003|261009223027099003|22082099003|18002099003|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: CiNF0cayvUtJsKyhU2rNAcc/lcZZecsLknaM8PEz1GHkXLWJkuBPWyjfSoFJ6pv6cv+ugLb065FR/Z5loHvwZYqgO/rNkw1WMH6xs3zHtFb97zktxLNfp9WsfkV7ylgcSIK/3IyBAofbxWNjRci8n5ZEb/ideQ0mMFSpW8Bvy2PTCJSGnzxGQdWjc/SFZ4Op7LkzePc1nVGgxJAtC8f7ETLJA08NNMtXVOUFzr6NctlPh7dC7NI3Ux0IdA/o5H7J8ZVy4ONjsIadolvVgsFtuEdlqwjLDdRsPYjxGXSQs5SM3VGSMRrxb/32xDT6kWKvCVwo/voOzeAGeNUB6ROI0GQJqu4wWqqF6Rc3M1ujY60yngGmoA1pu9oWd1W6VH0bTyoRnm3gY2qpGMcvdcIqLyN1Ip0DXVyTZ1LDT4c97r9fjofdvAiIcJXBQCIlvf8S/gbawVRdCa4Hh3fpC+msJWqJPjSaJlSxQOG8rAS6/jRbP6/TQua/41oX/Sxw5WX/5dTNVN9m0Ph4/pJ94Av/cIOEJmewZ3AwcsdwFlEtFvVAz1gh3iIa7Hsg33TVv/Caf83x8PqqjmL7sVDPIOrioOiegM2POlL8gJvB1Q4UEd4T82CxojgvlwL6vvHZC54l5uix85gK4f4MxqYAZzN27N8THnHJ+XRlJEdqCzXKlWy3fz9UIMgAWhk9szfQqrXxUOxCdKMxwNHFfBo39T4vHg==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(10067099003)(56012099006)(261026140227099003)(261028144727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261021135927099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(11063799006)(4143699003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WsTJyn/7+psAiaaTvLZh14casPAuRd/QT9pKd9UATqgiF5TSkINSb+0VZSila7gzUsR+1RJ3GjcMsD5R9rrSfBShtKFOuXe4KlVABN3Br7fc9CRefCz8j0zpSJPg1teToJWfCjlFIuq67VxigbHXFPfSDAGJXMxloOT8yzAmy3G+xB3h88pAaD8pdrgFdwdTlJpHfVE3I/dUWtzciG0V2I0gMcEC+5uJ6t4s7ldIdavL2L1lOnGT9C8bmEzZvK676v6U43mCL1GMn0JXNj6fgWJsYwYOTaWwUBlhkvxwxglfVri+lIxn0hXIOD3Icy+NrgVa6d5msRj8ExMcCAmCwjtOvfk1GiYQABBOcK04g6jzna3V6ZlJY8n/wKqyd9pbeZJx1dtr0YHGI9qD57b1WY1K27GRC0lpTCurNE4eKWF2PTQmsGSw0OIwadqW0RQT
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 09:45:44.1838 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dba574e7-4505-47ea-f286-08df4c6b34ea
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008C4.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9006
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Dario,

thanks for the patch.


Acked-by: Yannick Fertre <yannick.fertre@foss.st.com>

Tested-by: Yannick Fertre <yannick.fertre@foss.st.com>


Best regards

On 11/7/26 15:32, Dario Binacchi wrote:
> With CONFIG_VIDEO_BRIDGE enabled, only bridges are looked up on the LTDC
> endpoints, so a panel directly connected to the LTDC, as the RGB one on
> the Engicam MicroGEA-STM32MP257D-RMM board, is never found.
>
> Look up a panel when no bridge is connected to the endpoint. Also, reset
> the bridge and the panel when no panel is found behind the bridge, so
> that the next endpoint is not affected by the failed lookup.
>
> Fixes: 35be94614733 ("video: stm32: ltdc: properly search the first available panel")
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
>
> (no changes since v1)
>
>   drivers/video/stm32/stm32_ltdc.c | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/video/stm32/stm32_ltdc.c b/drivers/video/stm32/stm32_ltdc.c
> index 267da5debe4e..7bd6724bc2a7 100644
> --- a/drivers/video/stm32/stm32_ltdc.c
> +++ b/drivers/video/stm32/stm32_ltdc.c
> @@ -593,16 +593,21 @@ static int stm32_ltdc_display_init(struct udevice *dev, ofnode *ep_node,
>   
>   	if (IS_ENABLED(CONFIG_VIDEO_BRIDGE)) {
>   		ret = stm32_ltdc_get_remote_device(dev, *ep_node, UCLASS_VIDEO_BRIDGE, bridge);
> -		if (ret)
> +		if (!ret) {
> +			ret = stm32_ltdc_get_panel(*bridge, panel);
> +			if (ret) {
> +				*bridge = NULL;
> +				*panel = NULL;
> +			}
> +
>   			return ret;
> +		}
>   
> -		ret = stm32_ltdc_get_panel(*bridge, panel);
> -	} else {
> -		/* no bridge, search a panel from display controller node */
> -		ret = stm32_ltdc_get_remote_device(dev, *ep_node, UCLASS_PANEL, panel);
> +		*bridge = NULL;
>   	}
>   
> -	return ret;
> +	/* no bridge, search a panel from display controller node */
> +	return stm32_ltdc_get_remote_device(dev, *ep_node, UCLASS_PANEL, panel);
>   }
>   
>   #if IS_ENABLED(CONFIG_TARGET_STM32F469_DISCOVERY)
