Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5CC606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 13:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=U2itZMRs;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=oc0L5OaP
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 17DF4405C8;
	Wed, 18 Nov 2026 13:10:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tpwpXR85SDJo; Wed, 18 Nov 2026 13:10:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 43E98409AD
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795007400;
	b=N5WXTlPLuzlbReJwnxuVYtYe+DvmoXv9jkja9L4d3PWGLvnmYc0Ub43MCtSkYvMgO8Tu
	 Rk7OLhqezvduBEjngsrkPr137cHZzXWEjfhvTav1TqqLiUM9XJVPEyzUmrs4XJkRuJQnT
	 P+k9ApKAluMNHOEqkv3D6QWud8hXJu3EHCPNYPg6rEgChk9K0wODsceJXBKaE+fblnJYl
	 8PAwWjIig5LKN8jKIILJ0DD31lupeLdtQfOed0mNGKL9Qf08TENtf9uGGiyLhMJwPvFnV
	 mvZeVRKUgjlJvBBV578F6vRLIKPhVGx51gkmjE/2RrQIJaH6G9s07P4Rr+rQrjucQFw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795007400;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=NZYaRUu7G92Armw3RgiAPbEBIFOKTwrROWbkKdSyOuM=;
	b=V/m0sbVzZjA7mGoVBK0GQYsQDdxrwASVJglSyrB9twR2u1lruMNFUaXUxD/11zJU2Tf4
	 E269FLQg1UcZigwoIHz42epms3WbX9O+JJLyKmXpJDE4LDezPiHSHAElNbeiWy0mTedaS
	 mLyEYUTjQhyCxyZ28TaC7yOKiccAy3pbQG4zlGvNkBvoKIw15UDlg7scPEcYl4A3Izbth
	 co47SkSt5W8rdS26TubAPM4yfMDs12a7FCXhLf2FevabNsIjc5aEPJHxbTQhvMHMqVxol
	 LgzlpfQ3e8dXFXTIFHWKSl7R3U79Lh3EmkBSgw/UNPzGgl2XXKcG+zvXSzd9T1+TwIg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795007400;
	bh=NZYaRUu7G92Armw3RgiAPbEBIFOKTwrROWbkKdSyOuM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U2itZMRss1HLny1/ekEATretfB+wE/+8IRgTAXJophdLPxkG/X1fFZlS96vw35Vvy
	 SL8NP1UsiMtRy20znxyn642xc1YeHlHSi5C/RTavKvonHP6VkC9QfgxDO6a8jIH/71
	 1aXKWqO2mc+fRlqJEl9JV/zZIKX+cbfktJwspaYTGMKeWNOQsGw7SCoExWzVlxl8IN
	 T7593gS0Rwitkl8LlxjVr7KsAGstSyrUJ/3yKjnRHl+IoL6YJn2qdNT6ZEYYrM3Jeq
	 dzrpWEn4kEcZrLAFJtRTElNIcLDV//azomKt33elC91QqrO5WLsWq15N44Kp1RvW35
	 6Vw+pmylxs8XQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 43E98409AD;
	Wed, 18 Nov 2026 13:10:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 08E8770B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 10:00:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EE187810C6
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 10:00:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gXIash3DqrB8 for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 10:00:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5B9FF80DE5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=fabrice.gasnier@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=oc0L5OaP
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5B9FF80DE5
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 10:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZYaRUu7G92Armw3RgiAPbEBIFOKTwrROWbkKdSyOuM=;
 b=oc0L5OaPK2OKcrkNa0BuZPcZSZSebs2UZrCSeBZKiCw1BPnUcz8DmhQ59pdCoAxBx7210Ce1JM9pqLmiF9LN0fXCZn9o3nbgH575/3QvSGpiG/H1SOaPMI2jW/vidi1BQVdAyjjkfOOZGhF5nhxEBwBnoemt9q61j27Nc4fLvTsMQFN+bGK70Skce5ezbD+3rmEpsOWdKDuTVFJMIXJqPsKgQaqfFIXXE00fHXgzfvimQ/GL5eBhvTxQ1vh/LFGAEjEydCKxDH0jeS5K3f3t8CQ0IXHONw96Z1tXwOWxMdi48mG76gNT5/CnQyna7Ocn5HNYSiBIKduTYNH7r2NyTg==
Received: from VIZP296CA0006.AUTP296.PROD.OUTLOOK.COM (2603:10a6:800:2a1::7)
 by AM7PR10MB3794.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.1; Wed, 18 Nov
 2026 10:00:21 +0000
Received: from ZR1PEPF0000E6B9.eurprd07.prod.outlook.com
 (2603:10a6:800:2a1:cafe::1f) by VIZP296CA0006.outlook.office365.com
 (2603:10a6:800:2a1::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Wed,
 18 Nov 2026 10:00:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 ZR1PEPF0000E6B9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 10:00:20 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 18 Nov
 2026 11:00:58 +0100
Received: from [10.48.86.251] (10.48.86.251) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 18 Nov
 2026 11:00:12 +0100
Message-ID: <f2cc2d24-de98-409b-9dfa-075434b1ebac@foss.st.com>
Date: Wed, 18 Nov 2026 11:00:11 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: onboard-hub: Move usb-onboard-hub into drivers
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 <u-boot@lists.u-boot-project.org>
CC: Alexey Charkov <alchark@flipper.net>, Hung-Chun Tseng
 <alan.tseng.cs@gmail.com>, Lukasz Czechowski
 <lukasz.czechowski@thaumatec.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>
References: <20261118072332.627163-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20261118072332.627163-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1PEPF0000E6B9:EE_|AM7PR10MB3794:EE_
X-MS-Office365-Filtering-Correlation-Id: 150690a9-4c94-4770-0307-08df455ac1ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|10067099003|11063799006|56012099006|261026140227099003|261028144727099003|261022105027099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: D6BJgNc3G5MvLXEtqTLga0Is1I0DS60Z/7jb1gO9qEp0teLnc1tJOJ8Ka5s2JmioFwATAUkQxzTO/27KchifoonjcSkmQR/RXQRAW5NyteAp3pmuUbTYgcWJ8NMCxhXRIKsyh7tI3fLgSeTdtCBd6GeNkZEKwouaCTZVYZziRBQOF50oWwIwJfG26vNAzBaRicbzfhySBlso55QsC81IrDKNjRobDODxE1S5TvzNuNUgBC6wMv6ZHVIxIrBNVGN6ueYd3YPiGdq6PnDeP5VD3HDznh788eXBFA/yWMW4wh5jb82Z9452WisZ3qwNvYvCb5J/31oEf/14HmNiLf8wTCE4VrGljvlwu4Y6fddhLG/GKx1wym5A0jjPWyVGhO4Me//JBmsZb9/lqvx3sStE9jnrX3xqc4qKcnvmEkWonlQZsz3BgsPn2jmijQJjZ9Vx1GVKVpWCPan9wFUlmKAj0hwEKaHdys4DfR+ppf5wJ5Pwgg0qcJy0Bxm33wS30nUW+ssJEJ8fNUXfQ/GZLAZoVKRY3xkweVtTLcB7o3CMYWQ/8MPjRXD3hvYacOVRcCo5Myi+k8qOtg0lNIKvOt/zgx4U2Z/mIVtdVu8c5DI+2p6orKf/NMFroSt5eVJkBEFF9rta3T3hgT6Tv/Vz5JhjKltlzqTduXpCov46ldcazTbJ7H2xVA8L1SQif/mF8pYX0+t0wli7N0kcFnFjoEBfIA==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(11063799006)(56012099006)(261026140227099003)(261028144727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZRUPEkbe9qJ/8KryZM37d8L8gi70UeXTxDwTknVmR/GtS3DgFFQZUOHleUYNYqfdYIE8RUPNI+ZNBIjIdLzrvv0Y8oDGTE2B/XVSFV6QfHAUVy6RQqfvZZO4RnBNX1TBZEc9K800ZXuuBv0aBjbIxlG9ns9iwhA3qHUeaZvkaAzZUXItnSzrQUQC3Yk8JWYjBwL78nBL0szp1IpP/AbO4zcFiZaA6uNMQmpTu6i/DkLWNYbLgF908kYZZTMZ+e9tdYMspG4bgL9rpbeMC0JMN8Qitzr73mqC16H6P4EVi8MnRcBX5Vwl4gq34bW82Qth54Jh0ZCg5N7wyTTGfUXT7Tnk2E5v8G2s31Ud53jYC8oyqnjDlUmlDETbXajw03U6HZy3wfpWlSsSqyhfL+uJilTsYP2HSgqWd6wzNmfzpyf6f+9Ont0kkDcSVcTG2tRa
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 10:00:20.8317 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 150690a9-4c94-4770-0307-08df455ac1ac
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: ZR1PEPF0000E6B9.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3794
X-Mailman-Approved-At: Wed, 18 Nov 2026 13:09:59 +0000
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

On 11/18/26 08:23, Marek Vasut wrote:
> Move the onboard hub driver into drivers, this is a driver and should
> not be in common/ . No functional change.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---

Hi Marek,

Acked-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

BR,
Fabrice
> 
> Cc: Alexey Charkov <alchark@flipper.net>
> Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Cc: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
> Cc: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> Cc: u-boot@lists.u-boot-project.org
> ---
>  common/Makefile                                  | 1 -
>  drivers/usb/common/Makefile                      | 1 +
>  {common => drivers/usb/common}/usb_onboard_hub.c | 0
>  3 files changed, 1 insertion(+), 1 deletion(-)
>  rename {common => drivers/usb/common}/usb_onboard_hub.c (100%)
> 
> diff --git a/common/Makefile b/common/Makefile
> index d62ea34599e..ac6a2d1ae6a 100644
> --- a/common/Makefile
> +++ b/common/Makefile
> @@ -35,7 +35,6 @@ obj-$(CONFIG_PHYLIB) += miiphyutil.o
>  obj-$(CONFIG_USB_HOST) += usb.o usb_hub.o
>  obj-$(CONFIG_USB_GADGET) += usb.o
>  obj-$(CONFIG_USB_STORAGE) += usb_storage.o
> -obj-$(CONFIG_USB_ONBOARD_HUB) += usb_onboard_hub.o
>  
>  # others
>  obj-$(CONFIG_CONSOLE_MUX) += iomux.o
> diff --git a/drivers/usb/common/Makefile b/drivers/usb/common/Makefile
> index db8f35c10c4..e7d5356e521 100644
> --- a/drivers/usb/common/Makefile
> +++ b/drivers/usb/common/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_USB_GADGET_DWC2_OTG) += dwc2_core.o
>  obj-$(CONFIG_USB_ISP1760) += usb_urb.o
>  obj-$(CONFIG_USB_MUSB_HOST) += usb_urb.o
>  obj-$(CONFIG_USB_MUSB_GADGET) += usb_urb.o
> +obj-$(CONFIG_USB_ONBOARD_HUB) += usb_onboard_hub.o
>  obj-$(CONFIG_USB_R8A66597_HCD) += usb_urb.o
>  obj-$(CONFIG_USB_EHCI_FSL) += fsl-dt-fixup.o fsl-errata.o
>  obj-$(CONFIG_USB_XHCI_FSL) += fsl-dt-fixup.o fsl-errata.o
> diff --git a/common/usb_onboard_hub.c b/drivers/usb/common/usb_onboard_hub.c
> similarity index 100%
> rename from common/usb_onboard_hub.c
> rename to drivers/usb/common/usb_onboard_hub.c

