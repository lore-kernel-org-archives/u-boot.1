Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC45CA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 17:05:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DDCAC80EDA;
	Mon, 28 Sep 2026 17:05:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SuQzolZsnejn; Mon, 28 Sep 2026 17:05:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C582480E9C
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790615107;
	b=SgnSabv1ssucNsQqyYnZUFsTtxwqTbxG536AsXt7nlGCSRRXny83Wzx6nZNfKDb+cLLh
	 wjMHhFr5O/V4dz4qM1NJykAQnifJKBPCoI21yRcW6rSU2LEau6Ff2tSPPwolWr5xsx5yN
	 54dDvHOPj0jh+zt4SpK7r+ammMQ4IxUQhqzVNTqPLg9LGLl5ZSxMhM4lRnhgRbKBfZuCN
	 mGGuuhVHZsBXuZRxcM+xOdWH1eUrc2TUIgZTUPeGPnNe2pckr9uPVsZQXi8HoIS3HuU8U
	 9KKLS395mhCsVFMMRk0ul+kn2xK368cly/CKTMqdLmHhfUCZ+YTwledo8QPKzYuWtag==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790615107;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=o7yg0l0DQ7wbF6bCSYBslskESY4YZVh3w33+OZM7zUU=;
	b=Zl8ZCWDpx9zpFy6RigvrWBb+85cdLVVroG/VkdA+PJNLlFdbqskPRPdUZwcf6l65Jw38
	 X/nm9hiSa90ylsSiKMj/dvCyMSb6dCXKCM7WC5mW7WCSc4D244dsxKW7NHC17zEha2aiX
	 8Yq0W5wWyd7prVwaO9VuHE5tAtKYeiLTsstxBG7I1ymNrnnJaq8r/h0ZmtHErlylcveJg
	 kjcv2jcsQ9pP/GjUyvYO3TQEWBy6R27PSkiqtyWWn41xowX/VoOBA754AnMSrY9IEXs37
	 eemToMCyLWWDO5X90G8OHvOhKp0+dDqnF3FjaH3s9AgNAovaPtb3m2eFGGveAxueVow==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790615107;
	bh=o7yg0l0DQ7wbF6bCSYBslskESY4YZVh3w33+OZM7zUU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JupOvO3KxjPEZRqy3TDsCaonS5lVCLuQ96H9u7Sxtcym++9UXFJRi6vF3MdJZMPPT
	 JzQGCK+On4gUaKX25a8m6YZsG44xLGO6kUQEdOcNwVSuDLfEdG6kiNcm0qZPC3leb8
	 j612cdSvxnvu33kM1bMuIe7g4B9zs0cchYH2KgMss/XRaXXJTo5eMF2mZYj9G9+WqM
	 aCH3nJQP4yEb9+Cb19rziVoBYlYwtgXQMYENd5rqa5czBrK9BKTB/WYAQSjjqVuMxj
	 RMfpUbaQw05Q/yPbX+Txj8tcdLQYxd9x0VftQchfI87e/mZVoXkENt5dyTLgno7bXp
	 vr+08pX6T3XUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C582480E9C;
	Mon, 28 Sep 2026 17:05:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id AAAAE3D8
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 16:35:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9C170400CD
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 16:35:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pdUpCoRSlXL5 for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 16:35:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org F1CD1400B4
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790613311;
 b=ms1YG7eQwh0rZCYbuGQs2cgNGVUP4Jbe6VDNS21emB0+GepE0IUOJIhz84AivS5SwejA
 Y80pKg6p2VhXSt2LUcx6qlagilSOXz2e22Zmvy2lfzFfNSQGoOOAb7lZItoaLLTbQH4/c
 0zPrX7HrqcyoBzJxGKTyVWAOqM2zXssOkKLnJ+qeOZenyzgu75vxltHgOAqFKXTCfAazm
 z27id3IFbIEhlFYWSrVlR7q0mraFb6VYjRO9j/f09Sou/8c5BUzS7VUX8g9iXJJOt2EKa
 3BKmiC8x2Bgt5yRqxhbls8KlsYRnMjKlNAO/WL8F+D7R95N6uGfxeJ1VMk348kGVT2A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790613311;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:CC:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-EOPAttributedMessage:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=o7yg0l0DQ7wbF6bCSYBslskESY4YZVh3w33+OZM7zUU=;
 b=hB8sz4ZNPWY8cOnTt3kpxs0TV8B5gr+1fiU+wi3hKahQSHW2Tfbzjw+ATlf/aEQeOpTF
 uX7txu5N1xay6BuqvgsmMYnYWq+10p1U0D8STxNeZHxWwPfdmQVUCd/8mzsjaI2rqwlZA
 G3GQHlIO+1AG3ORdXWoai/FKSqeIxyvD+WCWZWPCyNFiZsDHVE5TDmDdJmVXXMvOtyprT
 F907AnAgJT40TXowJAkez+Ms2ggxmtei4cs5iTmnke7JhOtuRDGdkfU87TnQfycH6p6E+
 kMhB9TVoITw5vpySzgYgBFXq0LBsSQpEsquW/Tibc767dQLkmHGIn4lVgjPKlzGT5Pg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=QLC0GUtd; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=hrYn5pFv; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=afd@ti.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=QLC0GUtd; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=hrYn5pFv
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F1CD1400B4
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 16:35:09 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68SFK1NQ2811903;
 Mon, 28 Sep 2026 11:34:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=o7yg0l0DQ7wbF6bCSYBslskESY4YZVh3w33+OZM7z
 UU=; b=QLC0GUtdMboX6eMqhORdt5jF10c8RLGBwbi5Og+bNdeY5AAgMiRbVz4pe
 ZTzjTnDdsrHlvnf9/kHoO5KUolYINTwdfGRJoFp6SElyW8ZEbSQCB6acxTDrlJca
 h3BRHM7O00lp02tt1Vlin23GzA4XNjKe+BTBem82YB+7EYeAxiU01hmo6jfD0B/h
 RyhfPn4hoSfhh16DYTJCV4mj0udgxGaWon/YW7H2EDIZX4hXzQl6hjkpPYVwqtOX
 UZjYlscl+50Isvgd34kDfUDGRSdalYc6FKwlxiYtssfOmbM1FcoQUH57CTCaeHRD
 EElQHy87fjR+RYlnTV3ahjBGQq2kQ==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11013060.outbound.protection.outlook.com
 [40.107.201.60])
 by m0384305.ppops.net (PPS) with ESMTPS id 4gy00nf08e-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 28 Sep 2026 11:34:29 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AFaAPIyD215mXsMYrVYpv6RPjcRBfmKByIdTx2k4gV96SeCEAQIKylExhlAg7qgrpyX+wUEt/iqdYZLjO+HmW/OLQPEbBWP7zSJAff1wnWPHvcBbdSXLBmD44aWo0KKn9O8+Eem7mh0qBjl0JAnIoW4qFUkfR1l0+1nxg9qCKNX9tl8ooaSfi5YHitxoQMvIX4oB9BS7eFVf/ge/9gXjXF2kcmVeW+/ON4aCTnIzkeePiaaK3YpjwZta/s+7uBQVMlzMrJbYwBQUy8PgVygzEhtmXH17kvPUwsFbMAZ15rCFyTpaCHEKu8nm9dzuMIhzP3Xb8dMgcljSgdZHTmiTPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7yg0l0DQ7wbF6bCSYBslskESY4YZVh3w33+OZM7zUU=;
 b=ODVjHr7500PDUZlHNWxQO2/SoPz4aBCgr2Ts3hHjo3c8ZjakPaKcROPSYlsEsNb82YTIL5b4tcfoOekD8Ccs77AL8+wgLqd0MCqDzu7yYy4y/xTK1OAnjI1Gr5iIAytwOkuQ07FnXxuzxmGCpBxvDnEhbpT8QV1UArVRzpqyNPzlnggLm889xyzgFxWNvXytDHKc8Riy5LGmZoiLXTWQmKNbSquMAFl77Lx1dHuCGR2ISUAF02Lt1CUxSgrRLCiAbb7eAmICdTc9e+H7KfeJr1WwvCU/Pnl8MQZ5c5a/QRAIdO0JO5cH8asT9akTQpNaTkhSXi06X4+HfhHauSLX6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7yg0l0DQ7wbF6bCSYBslskESY4YZVh3w33+OZM7zUU=;
 b=hrYn5pFvcKFSGbpkaDzqX9QzTMzti0XZ/XTxnGt3P53kYeUUwKOb78kzvYcaG4lZDvjhmyijjZMpkdDz+3ApBkTgTfet2dVo4sXlD0I5YlwbkHLvjay46P/S3IzlZBhTP9HbiRAGnSd7BRmiew7fiW4iqVSWkN89XJQnBI22y6Q=
Received: from CH0PR03CA0366.namprd03.prod.outlook.com (2603:10b6:610:119::12)
 by SN4PR10MB5798.namprd10.prod.outlook.com (2603:10b6:806:20d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.14; Mon, 28 Sep
 2026 16:34:23 +0000
Received: from BL02EPF00021F68.namprd02.prod.outlook.com
 (2603:10b6:610:119:cafe::82) by CH0PR03CA0366.outlook.office365.com
 (2603:10b6:610:119::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.23 via Frontend Transport; Mon,
 28 Sep 2026 16:34:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL02EPF00021F68.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 16:34:22 +0000
Received: from DFLE20.ent.ti.com (10.64.6.57) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 28 Sep
 2026 11:33:40 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE20.ent.ti.com
 (10.64.6.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 28 Sep
 2026 11:33:39 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 28 Sep 2026 11:33:27 -0500
Received: from [10.249.33.243] ([10.249.33.243])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68SGXQlW214544;
 Mon, 28 Sep 2026 11:33:26 -0500
Message-ID: <da1e4a57-a511-4e6e-9f53-8e781b9a334b@ti.com>
Date: Mon, 28 Sep 2026 11:33:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] rockchip: binman: Add support for Falcon mode
 FIT images with TF-A+Linux
To: Quentin Schulz <quentin.schulz@cherry.de>, Alexey Charkov
 <alchark@flipper.net>, <u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, Neha Malcom Francis
 <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>, Peng Fan
 <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>, "Andre
 Przywara" <andre.przywara@arm.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Ronald Wahl <ronald.wahl@legrand.com>, "Richard
 Genoud" <richard.genoud@bootlin.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Bastien Curutchet
 <bastien.curutchet@bootlin.com>, Johan Jonker <jbx6244@gmail.com>, "Daniel
 Golle" <daniel@makrotopia.org>, "Markus Schneider-Pargmann (TI)"
 <msp@baylibre.com>, Peter Robinson <pbrobinson@gmail.com>, Tony Dinh
 <mibodhi@gmail.com>, James Hilliard <james.hilliard1@gmail.com>, "Quentin
 Schulz" <u-boot@0leil.net>, =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?=
 <joaomarcos.costa@bootlin.com>
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
 <20260731-atf-falcon-v2-9-acb97c172993@flipper.net>
 <75fbfc49-a610-414c-99f3-9b86c1b415d7@cherry.de>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <75fbfc49-a610-414c-99f3-9b86c1b415d7@cherry.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F68:EE_|SN4PR10MB5798:EE_
X-MS-Office365-Filtering-Correlation-Id: a1ebf299-2055-4756-b0e0-08df1d7e5a2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|7416014|23010399003|1800799024|36860700016|6133799003|22082099003|18002099003|5023799004|56012099006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: kSELR0vpwBQquSEMvCMHM4Et1qKJ0yxpgVj7RvTSBUw02wCzRC0HD8UQiueXw9RbJ/uOq7FSRm939AoVkJSI5amCOGpz8LFaTz7SyDj7LVp9u1/etfuZQfH6QE4WSIRtZwgMXjOAAsWOTcmLewtnEjad5nMgjrl5FewVNHVqWhFW36L9yaQYreJFD+JnSp/zgV7gErW7pW0pC2Z+/q8bUJ3mQSKiIphmsZa9calfvLB7aoGmXZ0qYT4Mjr00XxhwBkOq6Qju5O1qXXdAkEjRKIC3ah/AukZ1ajQJ6finhH81tnyqLt9tOQKv6mvAulxnJcC66PHUsmpHUyu0E2XL7HBh9UKFglIBaxESnxE/LDX4SOu+5W+jV4AWetrSdzLRyhceaqQU0liJoap5uoLgObvLIfosJItFffwWMLNsXrRP76hl4bVkwpAVgttg+0CFNTjRqWa1E2PK92Yg85cFDX3NHB2irkxgbtRGirFjkQZIOqgoAok+5apR2bEQ07vEl6bHf7kxITCELIIkRtCloFgzLdFiUrRRyt1MrHO2uz5ig0Ece+S0/lhhf/mterDTWnkb23KxH5di4ravS/MKOy8xOk7HzxlCPht5ogpkKYIAUeA9JiJZUSUQkoXHlP4HiI+XJ/QA9ByzGac2LpKuU1jVyAGfb1Jd3ajftkc+hgc=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(7416014)(23010399003)(1800799024)(36860700016)(6133799003)(22082099003)(18002099003)(5023799004)(56012099006)(10067099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /FZ4nQj8MbXdQA4s1fBwtGjwOyC0W6goek7PzUbV3RuU48ex8AxgZ6RSL+3Qb2ZT0Hn80rAQcf5Bo+vTs9e5PmAwXeZ21SHxIh0QUGZCHjLGQMP9vXHukKvxNQ2mmXPLtOqwHTYqUPHpB12Zuz8lXG+vRCAstFaR9i5qXDaPKEjmvQ8fuLL5uJslHxEI+SDgWPMS54lwNT00EIp8QBFYN0k3DAULfR+/Wf/+wx6V3bXvqw8FM7B+Y/dDvg3Um4Rw+y4AgGQoKBbKARoPS+alrLFgg/0hry5QL8TcXEok3fyhmQNC5Sv8i9Y16S1wSNpnlA+lAhR5wC9pS+ynsSxGjjC0ENMTUFZqaxMZcg67OQoorpxbLbj0aed+HDi5PNgeb7NCBloso3P4WohHj+wXiNGBTbX6K1ov+zPfnBL/vg0luvlvYY4i7wQg9OYhSuN3
X-Exchange-RoutingPolicyChecked: YTptRSFr4lApb407vYNeSLZI8ecgWe1VFxlYB948PHzZ6h+mfB4d3tBM6SmZKIv2/sV3NbfLduDGh2D6lYk3Yju8QSFIAnmJujJypdZuF2wipeno/GOyuhKtodKN3aLsJ7YX8NawCHRVWa3tqwmCOur60h5GIbQHHQdX3JuqVWozcJfACGic02cwTzdG9zYDvzIQs/7ZJ+QS1cL/tY79i3EMxB7Ylns82kr9oKYaW1cs4WhonZDTo+S66xyWQufgawyVX7x0X7T0qNE8AYqzKRXDiSV7lz6/YiqmkALmrY8y7XFwLN0htS78cPSel4/lYyC7sTA45EpoUE7YE7h9Ag==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 16:34:22.4981 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ebf299-2055-4756-b0e0-08df1d7e5a2b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F68.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5798
X-Proofpoint-GUID: nZ-LBxAfaXQw0yuSeN3IVyQFLDMnP-z_
X-Authority-Analysis: v=2.4 cv=fKysTpae c=1 sm=1 tr=0 ts=6aba9715 cx=c_pps
 a=qSo88s0AsKk38onbse8luQ==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=NEAV23lmAAAA:8
 a=IQDsJNHIAAAA:8 a=YLEENLuxxDyuZr8Da7gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2-utFV9abThaIUZd8OCy:22
X-Proofpoint-ORIG-GUID: nZ-LBxAfaXQw0yuSeN3IVyQFLDMnP-z_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2NSBTYWx0ZWRfXziekywaQWviR
 fYrh5jPloiwnKU2RByKraayP2l7Y2zZuqA0zw7Lpja75amNgHEvT23tcBWq86hlbg8YyVgL+/px
 7ctLatBsW6qNqDDG0hMfl0vpgfp31gQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2NSBTYWx0ZWRfXxae83krNjTim
 KWz4eieFg5dwFPFkuQb9ywsZCPkPAlRSEjgGxyZnyS67EdC7fnhOKB8wZM6iBae7ulkjKmppLOk
 fBa+vBLa99KJWYif9A8YnEiYz++FbBD8IFClvEPMHRNPgdUvSTlBj2dsy9nLxCRaUj6fNekcH+2
 nytB3UZhT33Ki5wLHzRvL4c+N6rn/XqTd09/loReTCza/1gmb+UlKwIg5qsx7+W88BUZah7KaRf
 gt47ucczByD8SSITjS+NKIsMxES0qAM0yO5GeV7HRS3kwJDhmTqNgjYGaQXv9WZZ2L0ly/6CjAM
 UHVtGEwMJGB2K81sBa1EbKh9OP0p0DjcBjYvOmIaNVEmWz/3icQADSNqcV5mSZH5pSm+xzc4GFc
 cIQmMWqtdlmsxudYzxgaUOdWnAsepDKuvqmLfRgdhoMxntyrzgbSPGAIPvLL2j+r8wLSkd4PArK
 WF2cYYOwxGjGawBZsxg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280065
X-Mailman-Approved-At: Mon, 28 Sep 2026 17:04:44 +0000
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

On 9/28/26 10:14 AM, Quentin Schulz wrote:
> Hi Alexey,
> 
> On 7/31/26 7:10 PM, Alexey Charkov wrote:
>> Modern Rockchip SoCs such as RK3576 require TF-A to be running to provide
>> firmware services to the OS. To enable booting Linux in Falcon mode on
>> such SoCs, add a binman template for generation of FIT images containing
>> appropriately split TF-A and TEE binaries (as is currently done by binman
>> for U-boot proper images), externally provided Linux kernel and optionally
>> an initrd.
>>
>> Any FDTs provided to the generator will be pre-patched with a /chosen
>> node containing an initrd load address and size (if an initrd is provided)
>> and a bootargs property containing the kernel command line (if provided),
>> so that the kernel can be booted directly without external preprocessing.
>>
>> A config fragment rockchip-falcon.config can be used to enable Falcon
>> mode boot and the building of TF-A+Falcon with binman, e.g.:
>>
>>    make nanopi-m5-rk3576_defconfig \
>>          rockchip-falcon.config
>>
>> This will produce a FIT image u-boot-rockchip-falcon.itb containing TF-A,
>> TEE, Linux kernel and optionally an initrd, which can be flashed to UFS
>> and booted in Falcon mode.
>>
>> This can also be combined with the existing rockchip-ramboot.config
>> fragment to obtain images suitable for booting from RAM, e.g.:
>>
>>    make nanopi-m5-rk3576_defconfig \
>>          rockchip-falcon.config \
>>          rockchip-ramboot.config
>>
>> The resulting images can be uploaded directly to RAM via Maskrom with no
>> storage or USB loader required, e.g.:
>>
>>    rockusb download-sram u-boot-rockchip-usb471.bin
>>    rockusb download-ddr u-boot-rockchip-usb472-falcon.bin
>>
> 
> I'm sorry but I don't see the benefit for U-Boot to have this complexity in.
> 
> I already find arch/arm/dts/rockchip-u-boot.dtsi difficult to parse, and this is not helping.
> 
> Moreover, this has almost nothing to do with U-Boot, except:
> a) it uses U-Boot device trees,
> b) it concatenates SPL with the Falcon FIT,
> 
> a) You should likely use the kernel Device Tree instead. Even though we sync regularly, we still add our own stuff and may lag behind. The Device Tree used for the kernel doesn't have to be linked to a given version of U-Boot.
> 
> b) You can simply generate this image ad-hoc with a simple cat (taking into account padding). Also, this doesn't take into account boards for which there's only an SPL, in which case 0x471 binary should be SPL and not TPL. While that is already an issue with the current code (which would generate an empty 0x471 as far as I understood), it doesn't improve the situation. I'm worried about the increased test matrix needed for this, how do we actually make sure this still works and we don't regress? We would need a gold kernel binary and initrd on a supported board and test that.
> 
> Honestly, all those concerns could be alleviated if we had binman as an external (to U-Boot) tool, then I wouldn't need to care about what you do with it. There was some discussions about which tools to move out of U-Boot's scope and we started with patman but binman was also on the table. Neha Malcom Francis suggested it could be useful to other projects, c.f. https://lore.kernel.org/u-boot/f697d6c6-3cf9-41eb-a833-880a892643c1@ti.com/
> 

Just to provide some more info on the need for binman as an external tool. We (TI)
had all the boot image packaging, signing, blob fetching, etc. as an external tool
originally[0]. We moved all this into binman with the hope that someday it could be
factored out into a standalone tool for use by other projects. Like was done with
the tools in `u-boot-tools` package. And like that project this doesn't require the
source itself to live externally to the U-Boot repo either, just that binman can be
used outside of a U-Boot context (not so strongly coupled to the U-Boot build and DTS
files).

One such use would be in Zephyr where we are trying to build standalone bootable
images. Without pulling all of U-Boot in as a Zephyr module, this is currently
requiring us to duplicate all this binman logic/scripting into the Zephyr repo[1].

Not sure what the next steps would be in making this happen, but it would have ours
(and probably many others) full support.

Andrew

[0] https://github.com/beagleboard/k3-image-gen
[1] https://github.com/zephyrproject-rtos/zephyr/pull/106763

> I've provided one additional review below that may be useful for the other patches.
> 
>> Signed-off-by: Alexey Charkov <alchark@flipper.net>
>> ---
>>   arch/arm/dts/rockchip-u-boot.dtsi     | 204 ++++++++++++++++++++++++++++------
>>   arch/arm/mach-rockchip/Kconfig        |  49 ++++++++
>>   board/rockchip/rockchip-falcon.config |   3 +
>>   3 files changed, 225 insertions(+), 31 deletions(-)
>>
>> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
>> index 4ba6a87e78ab..5e23ff761751 100644
>> --- a/arch/arm/dts/rockchip-u-boot.dtsi
>> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
> [...]
>> +    fit_falcon_template: template-falcon {
> [...]
>> +            ramdisk {
>> +                description = "ramdisk";
>> +                type = "ramdisk";
>> +                arch = FIT_ARCH;
>> +                compression = "none";
>> +                load = <FALCON_INITRD_LOAD>;
>> +
>> +                linux-initrd {
>> +                    optional;
>> +                };
>> +#ifdef FIT_HASH_ALGO
>> +                hash {
>> +                    algo = FIT_HASH_ALGO;
>> +                };
>> +#endif
>> +            };
>> +
>> +            @fdt-SEQ {
>> +                description = "fdt-NAME";
>> +                type = "flat_dt";
>> +                arch = FIT_ARCH;
>> +                compression = "none";
>> +                load = <FALCON_FDT_LOAD>;
>> +#ifdef CONFIG_USE_BOOTARGS
>> +                fit,bootargs = CONFIG_BOOTARGS;
>> +#endif
>> +                fit,initrd = "ramdisk";
> 
> I've just had an idea now but can't we use &ramdisk here? This would avoid issues of typos between the property value and the node name? of course we would need a phandle for it (ramdisk: ramdisk) or use the full path (&{/binman/simple-bin-usb472-falcon/payload/u-boot-any/fit/ramdisk} (and the other one, as we cannot declare a phandle inside a template if the template is instantiated twice like here). But again, I don't think this is a good idea, I think we should rather do runtime fixup of the FDT based on an initrd property in the configuration node.
> 
> Cheers,
> Quentin

