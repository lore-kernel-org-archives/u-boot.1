Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0284606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TG295DAd;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=bavRybhm
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A910D40A3A;
	Fri, 27 Nov 2026 13:18:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hm_mwUqosRfD; Fri, 27 Nov 2026 13:18:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BF74940A08
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795785500;
	b=r1YHIq4tNE/tOojz3gWdDWNirlBCJSL9IGMcL8OTDAad4ulA8+bwt2ca8J770GlzXxFv
	 JSoaLjkSwIhWgHobhyufZLhYhfwzrFs3HmmvdPxgUhpUI83/NuxMj31azc0FNtXF4fapL
	 bpFM2ydvpIZeQG1It5PGyildkVGKej9ROhoS9gJvwYuwn+dvpiEPmOXVZGg4MT1R/9+cN
	 l9xoW2HXWIvWhEsod2R59d+amfCB7XQc4FyWaiXyx+yAR9S4VZyLA3ND6IwBP4Cg5d2Lm
	 tskkhJ8V3JmHTUAsTB4eYb38j31R9MOHr2baohc9HwGjgGwwFAK/VmBpGf67BlF/eFw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795785500;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:From:To:CC:References:Content-Language:In-Reply-To:
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
	bh=IgxaiS+BD6g9V87g5XYMZa2LhY6vpx36upnXIeb3RRo=;
	b=MdxChP9pl5/LlGC2B/3QxxXHlYEtvxQKH/k5B/x3JCXxQS1RQ0gTyTqdX00Y/NPO1rJq
	 q1Kk9kXn6zz7nDz5Mg0HSdMYJgJAyzubzHQ7J163VGGPZwFZdxNbcKxrOE/2BghjJedNB
	 RxJd9UcPe4IBWmZ7SFghm1yUzT88upi63QB/WKBUiGdXS41X4loeoCEgFxgz4kO3uBWv5
	 Vd6JY5BG2cXRW+HuZx+0D+1hOI86erpT09/24jJHw4G5Uj9EjLWDqE1JwBtpzQnXzwWl3
	 KwVAX1fF71MF0uO1QFyEzuyV6/CTDxBQ8x8Id4Ir6vm7wrGiGQ2+xRegxaE0J842heg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795785500;
	bh=IgxaiS+BD6g9V87g5XYMZa2LhY6vpx36upnXIeb3RRo=;
	h=Date:Subject:From:To:CC:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TG295DAdEttt8JA27eQ+u9oYOljgaUom3aUSRk3EDA/U/LKgJPYGM39sKRhN/oFw5
	 Pn5wJ7wEl+BkKtgBjTRf5x1ClO63ykiVpaHBQTX1mdY8OZpCN/KR23XIOWqPzTNwBc
	 qP0rICNInC7z8ZrAHqbOKft+Kjle+veQMsKsePvtVsV26ANoQoqwio845z6LgV+u1z
	 jJD4UQOtyxQ36jhTG6ilR0iACcVxK44LImjDPqtGABVIUqQlSVGNQt1TJsSLlWIzgG
	 twE8hoUzi84yfXXcPkAXS3tzdg/GdARSPC7cPH6oJrbocplea3OIrLKpj/0UAxFoWv
	 Bztnlhl2Sd0AA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF74940A08;
	Fri, 27 Nov 2026 13:18:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 54EB1311
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:18:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3B31D400F5
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:18:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2K44g3dMMA5l for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 13:18:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 19B034004D
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
 header.s=selector2 header.b=bavRybhm
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 19B034004D
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 13:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgxaiS+BD6g9V87g5XYMZa2LhY6vpx36upnXIeb3RRo=;
 b=bavRybhmH1BftHqP1DpNLX/4fUq9GPWYmGxOWA36exGe4X2fwjCsevHe+8p+r6PeyeS+mOgw6rHKZnUHUa4i5YNSSPdadNejwnlve4JvTg2uoA4ujp5EaBDYbW2xvz8jXgEB/5niS7qbbnru8wSqpelJejHCcUgM7kfEpFlhDyODLqsYqRLazHCTbUeQIu4wKP3Smsv1GlPXbibLX6Y4eRr4oVJppxz2z/SfX39YvBsSbCml9YFMPT1C2984+mQpQaBK1NnB1XGHb+s12hLsNPbM7+Jqp8IjAog9HJyr+kVtz2V5d4vvRm4qCfE3zOnAJGJAjkFAq+1G3ClS+HBYuA==
Received: from AM8P190CA0007.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::12)
 by MI7PR10MB375404.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:290:100::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Fri, 27 Nov
 2026 13:18:11 +0000
Received: from AMS1EPF0000009E.eurprd02.prod.outlook.com
 (2603:10a6:20b:219:cafe::7) by AM8P190CA0007.outlook.office365.com
 (2603:10a6:20b:219::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.10 via Frontend Transport; Fri,
 27 Nov 2026 13:18:11 +0000
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
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 13:18:10 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 14:19:00 +0100
Received: from [10.252.12.59] (10.252.12.59) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 27 Nov
 2026 14:18:09 +0100
Message-ID: <a2b406c3-b939-4f5b-ab11-eaa3b1213b8a@foss.st.com>
Date: Fri, 27 Nov 2026 14:18:09 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Uboot-stm32] [PATCH v2 23/35] video: stm32: ltdc: stop looking
 for the panel once found
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
To: Yannick FERTRE <yannick.fertre@foss.st.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.u-boot-project.org>,
 <u-boot@lists.denx.de>, <uboot-stm32@st-md-mailman.stormreply.com>,
 <michael@amarulasolutions.com>, <linux-amarula@amarulasolutions.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
 <20261107143241.2236511-24-dario.binacchi@amarulasolutions.com>
 <64337014-f5a4-4121-a992-132f1c99a8b5@foss.st.com>
 <3197827e-6f9b-49ff-9eb6-14c099ebb3f0@foss.st.com>
Content-Language: en-US
In-Reply-To: <3197827e-6f9b-49ff-9eb6-14c099ebb3f0@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000009E:EE_|MI7PR10MB375404:EE_
X-MS-Office365-Filtering-Correlation-Id: 73399eee-de1b-4194-3c56-08df4c88e27e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|36860700016|376014|82310400026|56012099006|261022105027099003|11063799006|4143699003|10067099003|261021121427099003|261026140227099003|261021135927099003|261028144727099003|261102123227099003|18002099003|22082099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: PcayumTFdK7TS2Jd2QS0fg8+Ap5LSQFAxUfyvbdpOO5Mbki89hj8m+WtGJK5MdS+AsEK3DS4Rrf91H5fkjUOUfbaMSogA6AM8ffET23w5iTF5i8bhaxxT09cbh1OQefuHfkQwhzo5NEvkatc6zM2tB2EdVVAHoN1On3X5K915xAEzhPzwpGCLdiEDCDxXBcI0F+LWxd4jHAlOwPcn9zfQDPRC7+nFC0b2zqzvHFIVzecZ7Cp3QlbT32LQSj3bk+IxDUEvTSaczoOh+OyGw2sKo1Pm5K3ReVWr1jev97vgxBED1D6aGgLizWz6gk1doCcYMJPDDnCKHp0n8l2zRwFYaWfY0EJN4PTD9nf8nrGcsIGU3ZoaL1ibQmN68//SSlOgCcpivcv+tXLNiDhtnJKZFZeC9dT7XIIG9t6KMAaM8a11eljJOWyXBDnjaceA7mPtR89csHLOZ9gAlWlY1ok3s63iyi5xmi1szCUXfDmtFMBRQaHbwxjXLOh7XvKtCnuuqFCI4dc0Zo5deRXR4HMmTdneefAh4hQ6Y8o9EX/TP/xDEgoP+uZnxzVTT43hIJiMTXdBJ4A3xZ2o+y7l638D+ZUyQrm5Q0uB2beyHcqUeyhiaHyiWmDvieN8eYJ43TzYhyvrtS+wEG3yPnsgAD/T0c7/wfIyUQXbdAEAe3zgq8=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(36860700016)(376014)(82310400026)(56012099006)(261022105027099003)(11063799006)(4143699003)(10067099003)(261021121427099003)(261026140227099003)(261021135927099003)(261028144727099003)(261102123227099003)(18002099003)(22082099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CNoF/JYBejavHU/Rg9oqkbqNdA27FCHDBuXpmz9V7aFsZlm0peHqhdmjZp8IUclq3ZfSOvATlIQYeZJDj0pAjyvRWXQfYKaoM+agMjeYyiZY6NT3cislrSQEizwhOc9crog7M60aY3BDlMdzLPuLS0l0az1YbyTtUuBbW01Uin6bCB3L9yrhot6kZgt2rDFFTdFdtl/FZMuDIhRJswKZvBWwdGb4hBrolr1kv+mLfwNTBWGVN0m0NIx2bou1uDs5Hu3gMrCAkGxULcJqN1WyYbkdiIyHcADEcgUmz/EYFZKISTLYuj5inNatYSLdKUD/xoPgv+ark+KyImFFxZFO0KTzXpZlpjyywiL32Ko9PLFXqA2KhDcnSTrQY5d/+BVPBkLpMCGH/5Us5LJ4lN8fd71Q164emhC4/HyJhynR58vhiqIxOeHSmj1a0O8A0FS6
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 13:18:10.8226 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73399eee-de1b-4194-3c56-08df4c88e27e
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF0000009E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI7PR10MB375404
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



On 11/27/26 14:17, Patrice CHOTARD wrote:
> 
> 
> On 11/27/26 11:30, Yannick FERTRE wrote:
>> Hi Dario
>>
>> thanks for the path.
>>
>> Acked-by: Yannick Fertre <yannick.fertre@foss.st.com>
>> Tested-by: Yannick Fertre <yannick.fertre@foss.st.com>
>>
>> Best regards
>>
>> n 11/7/26 15:32, Dario Binacchi wrote:
>>> stm32_ltdc_get_panel() looks for the panel on each port of the bridge,
>>> without stopping once found, so the panel is only found if its port is
>>> the last one in the devicetree. This is not always the case, e.g. when
>>> the ports are added by a DT overlay.
>>>
>>> Stop at the first port connected to a panel.
>>>
>>> Fixes: 35be94614733 ("video: stm32: ltdc: properly search the first available panel")
>>> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>>> ---
>>>
>>> Changes in v2:
>>> - New patch
>>>
>>>   drivers/video/stm32/stm32_ltdc.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/video/stm32/stm32_ltdc.c b/drivers/video/stm32/stm32_ltdc.c
>>> index 7bd6724bc2a7..da580a78a5db 100644
>>> --- a/drivers/video/stm32/stm32_ltdc.c
>>> +++ b/drivers/video/stm32/stm32_ltdc.c
>>> @@ -571,6 +571,8 @@ static int stm32_ltdc_get_panel(struct udevice *dev, struct udevice **panel)
>>>               continue;
>>>             ret = stm32_ltdc_get_remote_device(dev, ep_node, UCLASS_PANEL, panel);
>>> +        if (!ret && *panel)
>>> +            break;
>>>       }
>>>         /* Sanity check, we can get out of the loop without having a clean ofnode */
> Applied to u-boot-stm32/next

Sorry i made an error, instead :

Applied to u-boot-stm32/main

Thanks
Patrice

> 
> Thanks
> Patrice
> _______________________________________________
> Uboot-stm32 mailing list
> Uboot-stm32@st-md-mailman.stormreply.com
> https://st-md-mailman.stormreply.com/mailman/listinfo/uboot-stm32

