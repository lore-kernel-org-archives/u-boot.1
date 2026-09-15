Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD81C88E7F
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 15:52:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B607040527;
	Tue, 15 Sep 2026 15:52:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8jGBy7aDDFzh; Tue, 15 Sep 2026 15:52:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org EF84C404F9
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789487529;
	b=iZB88HSUsKiJre8f3eQOwrNKQ43ScKY0thfxi68SgWOdxslUlo7dcdo/PQ4xDx/9E5vX
	 2yBG0CsdoigCOLf8sxDnnAy+OZNmCWXnhO+PUbWN7YxjOdX863v68gJ34C5utWtZNb5RI
	 OduXOkQDHAU3s7PW/EAflLSorIkpj8T1MWTbqPr/+GpzOzkvi+knehPMbSERuDzL4r+KG
	 8l0MdRZjLarJ+NKg0kvqrZJFdP3bj1AV9tmtB6ACKeZk+NV5yoFx/4z/MhoWwX0+S/0K7
	 703FDgqDZmFY0i4G1IF5abmqgETyfNPGjdudRlDqy8A+AP2AkaCqN2srFIa0oYk530w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789487529;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=NAkX+Av39U2OFHHwNB97I4yo5Ch3MKE1jvPj+lUlbJ4=;
	b=r/xm4MaQMPYmISjA2wfVk/Ts8uwbPM0Nlk6fOiYfhx6jkmfB/YNOmhC4J2mAehbHqHb0
	 7n8HIQAbh4p5cAqUlWJ3EezGBBsYaA9WnuAPK19fGBhpMntgXK4O8e1LySXpX4SbFFY2V
	 KXLhCRfZGVivBqHlJ+52+rJfOU4YuU0qCNqeyIHDfIrcjIXfJ+dr5NuNpCkh494OIIP21
	 JL9QJjP7s6ihG0WSc0GvgVX6+LqLyD8v59yoObazfWMhk0J02ORf3LLh8OFmrfDIlOMkb
	 idUzRKz+WqcJdARqEYQUESJM4sRXjH2PuRjWA2QHFZszV0P7rJBJjIC3iSavUIZ4g2w==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789487529;
	bh=NAkX+Av39U2OFHHwNB97I4yo5Ch3MKE1jvPj+lUlbJ4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RZ3wU0qpJnOdqLTeNJljXQGEBzaNjGhbiqi01+NRPRh5xN4Mumo0AHQLFpHiW6BeT
	 OjoDuV7v8cpQ70lS131Gsbp5jhfaytzkFC5XzQ7eYii1C7W6wXvoQdk0Id5LDw9+kB
	 zCqxeNDZuyYmjIGYjkvhqwPE4n352v1DrrWM3eYzzk8yzFUz6pefVS6+WE3SfNjJ8G
	 UANS5/oOyCYeRzXRzCLM5cMfBo6LjIcTtb35mNBEBkpLiSIvmstLI+r4QPthXWhKJ+
	 0Zm9yOcmSd8hD2lWXe8wi4K8e7Ihn9yppm8kJ1L/N293cJcV4WPPSH8kbPObR8sOdM
	 IiKxqXy9aGxog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EF84C404F9;
	Tue, 15 Sep 2026 15:52:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3B1EC493
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 09:36:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3773D80CC3
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 09:36:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LmCqoSpr8Gwb for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 09:36:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 530CE80CB2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789464976;
 b=VlWWHf9dTHpbs3qK+JB2iKiqwhJ0jH8prN2iRSgzyo5CcJcicEZE2Z3DGy9Aqia5TBWD
 D1HoZeyF6yrPbENbbT1+Egp3Xp2kJktS7VksFR61Am73NaurLR76NsdIe6zSP0++Ufa9T
 ElSvDqEp71HRrDBWFCK2YpqxXGSmgiwPskc0qiNGvVN2tEoe1H90ntPLumbDYG5F6CKy0
 P5lhMQlCjnYIwscItsktVpnnk1QiK88nlGhOY2l8G78EXW+2/7egVMwl83QAeW3itCfTT
 VoKydCW7NqDQ3Mxp/zpkcws+Txo7KahnY/5HsVWrA/f6019WR69yfjs8n1QusB5hjAQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789464976;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=NAkX+Av39U2OFHHwNB97I4yo5Ch3MKE1jvPj+lUlbJ4=;
 b=iqsFGdpGBkFwrWy1nnaHU5Gp+XeN19CWe4u8mB38EsK75w21dUZ5ywESHxfYz1xiQIeq
 tAYmhtuhvOgLLcFMY9BLT3yi5j3YspccDz10OoQReKPilgLHobJLjpgjU6ys6VLQfTXGP
 Yu0SnRfUUufGXFi38IxhLgK1PTTL72r1AvoteuXGPt2b3+jTPxMnrrv/RQJH2AIKHwci0
 cSQ3z6HDbZSgMV9OTJe9pyFPUk3OlWMh7wM5S9rrUde2GcsUfUpw4UxAxh2OGSOYKWBS5
 VoASsBFcwGrvO8QUyDOP0OT5MN2gyA3NN6HKYjpeMUx++/RDSn4P5UcN5/Cq8PBOD4w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=cherry.de; 
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=U4clz6U4; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=U4clz6U4
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 530CE80CB2
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 09:36:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vmn/iSwfcCY/gWHc/vxsMZmEhv60Ju+er/R4fDi79L4dISgAwYjvU1+evID6fabvCAlOnphNfGVrHFbVzYLIxFj8KPm02tFB/SGnhl4giRvdzMNmejo7oJLSXU6Ua+26K8CgcuiddCki9gJwyGJpnI880q3KMhlXEMn0gKMcJ2bIw95X9YM7luNZpFoGFDhYTW+O2qoB451WlHc2nfNlHU0xX93DEyfbMOnAiS0rJSL0fJSRSD/s2oVkH00xLOQplb66TdrJNcJah9zooWUjNk36oT+i/lffCrHRNwkEnvbrd8CNI2Cz90PI2XPEWY7GtLAM6E+ue/KEGnoE4zRT/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NAkX+Av39U2OFHHwNB97I4yo5Ch3MKE1jvPj+lUlbJ4=;
 b=ljulk3N2iGujA0jkpjd/q4eZP/kDkEAVfsVrGl2/Ne870DdIlg9mD6voBPfQN53yl5uaWfMmubs8WHOAg2s6llLFpnSEjPFsGXiUNflsA7ROX5/YimEb1JwjJDUOmVDKncKejgq16oAoHV1LqQlwW8QqMyFlGDlAnRk1umiX8aSoR06gT0yNZMkxSFUpLlgqtuzLeJVhYAi791x7eJ0R93OWeNZlMMtthwkNku6T8fFeFa/OFBrF8+Wcsv54/rjVnR4JK/S1xRoKAuaEHsXsGEDtDlzL7jKBfpHlwV1Dhp/vk87Z8YXh0g6zRpPmwGdJW0AY16KQDn1IqRbk2Ethuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAkX+Av39U2OFHHwNB97I4yo5Ch3MKE1jvPj+lUlbJ4=;
 b=U4clz6U4UPH2/flVlsV4xU+mEKR5xsAcIEmzfLiru8rkPKhGAAxqTkMLeG1HXJFI5Nvv4A/cdalrVSJpPJzoB95OragV+ZlyBPpwZK7iGHzg+TALlkSR+qLwbEqc8WBSm/5NeTBUxjwy+EVBB9JRrZxwf3/XyNwdYzdUEnRiCLw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by DBBPR04MB7851.eurprd04.prod.outlook.com (2603:10a6:10:1e1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 09:36:09 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%4]) with mapi id 15.21.0406.012; Tue, 15 Sep 2026
 09:36:09 +0000
Message-ID: <0026be77-2d45-4749-bf9e-f3c8da725007@cherry.de>
Date: Tue, 15 Sep 2026 11:36:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/14] phy: rockchip: inno-dsidphy: check
 dev_read_addr_ptr() for NULL
To: David Lechner <dlechner@baylibre.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Julien Masson <jmasson@baylibre.com>,
 Bo-Chen Chen <rex-bc.chen@mediatek.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Sjoerd Simons <sjoerd@collabora.com>, Eugen Hristev <ehristev@kernel.org>,
 Claudiu Beznea <claudiu.beznea@microchip.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Chris Morgan <macromorgan@hotmail.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Dylan Hung <dylan_hung@aspeedtech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Macpaul Lin <macpaul.lin@mediatek.com>, u-boot@lists.u-boot-project.org,
 Stefan Roese <sr@denx.de>, Bhupesh Sharma <bhupesh.linux@gmail.com>,
 u-boot-qcom@groups.io
References: <20260903-b4-dm-addr-null-checks-v1-0-db945bd5e712@baylibre.com>
 <20260903-b4-dm-addr-null-checks-v1-10-db945bd5e712@baylibre.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260903-b4-dm-addr-null-checks-v1-10-db945bd5e712@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0119.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::17) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|DBBPR04MB7851:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b29aad3-4ca7-4df9-6eb8-08df130cc631
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|22082099003|18002099003|921020|4143699003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: aQuZlznl5j8gRKu9sbvBWn6RCv+rXVPDV3pjRlyeT9SfMGex7tc1xey8gV8623K+CRuiYHm1rO8mr3epsBlQKi30S4L/wnJRoqTRcjvRz9eyxvJb9KRAi9x3Un0I9BHKR+HyO+5K2cURw944tr4UU0U92qbeN1ImsQ+wmgkR4MnPMa2CiES59Pnu+SfHeEcOj06ZCg2Zfq2CmaywcANbBKjd589kHZ4jHKBKwBD7Ey+xMKOiWrp0bLSKdVf8FOmnTYiNQI2PVm4IVSLzu0tpRTPDr1HLZsCkqx70vjWOT6kQcx9YUaz7eAIKYuqFaGlg5rBs7x6K3jO2Y+Y3dwzIe+jD02yXNt1peCcFz4yqtcSUEa9aFBz9Iwfq7cCqax8UFJN33oNLQYc5XDxXTyKZTLcVlN20OwESk3TAPr6t1uOlzSjwp4VvD4vZaWh78meDwrBwsapm3W+CZrna/uxtBVuOqAzL45tMPnvlZwec06GK81ztsHDqLeGKYeiT792AwIDNwUm7X84rSXNVHYkRG//ToX2coGBkhCl8+3te8azGT4P1XGZPg44YZRidQoUtBTt+0MMxtRcvW2B0ni55yyu9q0BRRXiieKxYZdqFiEeZI1kJMrMgXO8+kF0GvHxvJi+xsS5xWIGtOPieDyYkJN7/qiQPxW50zkd8LqGpgX4ZD3JOX9dx/Qg4gx4NIdRHxG1/a3456Oy2+uACr2bULQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(22082099003)(18002099003)(921020)(4143699003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzNSU0NveE5kVzFrVFo4aklNdVgvVUZhOGlaS3pDVlBxdjJGeVJRMmwxdFIz?=
 =?utf-8?B?Nm9jY3UyYytGUHF1TWIxODlqa2g4MkE2ejVCdlE0S3JaaXhqMW40N3paT1Zt?=
 =?utf-8?B?NjJwM0h1NzNUTzk2L3BIT1ZWcDVXKzVzKzI5WU1hQ0UxMDdjejJRQzRhNFB5?=
 =?utf-8?B?bU50STJZd2RNb3R5QTZxaGtJVnpYLzQxdzd5S0NzbFNrMGNKMzg3OXUwcXpt?=
 =?utf-8?B?Rk1ZMG0yVyszVXVudVFqa2xyMmlCTHVycVJSREhmODMyR0x1SEE3Yk9oQ2s0?=
 =?utf-8?B?S25MNWlwdEJWSTFEd01peDM5Z2R4d2xNSWVSdWNsUFB0bnIwczBaSHhXQkZR?=
 =?utf-8?B?V0hRbVB3dEZwV09xRVBtcVBuU0ZnOEQzdnAwaGdVSVRyUHlEYVBzanJTaC8z?=
 =?utf-8?B?eVNrSml4dmxjaWxnSUV2T1IwSTNPa3VGcDVMNHoyaGtlSHBHWHl6YVRmMSts?=
 =?utf-8?B?NEx0aUluUWNLSzlCUzJqUEZRb1JLaEJ6WlBvSGhEWUF0eWl2YkpnVy9kZkxB?=
 =?utf-8?B?ZHhFSVZkeitub3dpdVZjU2tNSVNJMmQ3aDJLQzVHdGhBUXBwWHdjSUpSd0Jq?=
 =?utf-8?B?SytJd0ErVnF5QUdWMUgwRUl1UXRUWU9HcmlwOFlsYmtBWjJkRFYzbVNOOWtp?=
 =?utf-8?B?VFI4RGdITkQ5ZHEyZ1VNZ1lTWW1UU3QyQ0JZY3MzMjFOMmxiY1B5OXFmN204?=
 =?utf-8?B?am9jdWNYU1FvWDhDMGM0SXNXVVZReHlxOTE5YlZjL3V4MmZ3THRkNDVMQmlO?=
 =?utf-8?B?WHJvQldEbmYyclJKQmdjMGtyWGFYbnZwWFdkRjMybmU4OE5RY1lyc0lhUU81?=
 =?utf-8?B?Y1RiK285dDlnMUZjZGp1RHJhS2tPekt1VHNraWlBRWhwNmk1M0NaeFl4WVpD?=
 =?utf-8?B?YzRGQlpnTmxLR1Raa2I1Y2RVbVBsZDZYVDYyWUtzbWdzTDIrT3U0b2FpSXVM?=
 =?utf-8?B?Vk5BclNZaUJzcXlVRkR6V1hwQUR4d1RNL01vMnEwSjJ1dWFuaDM2UXhuZDVy?=
 =?utf-8?B?Z2srUUJaNVRyRHNzL01SQ2FCai9IVk1RaWpIOXRkZUI5UG8zTHZLL09uRWZp?=
 =?utf-8?B?R2tJSUVZaFpSaURLZldxclM3ZkFwVFNaTE0vRFN4NmJDOXhoV1REZ0NrSFdB?=
 =?utf-8?B?YVk3c0RXcFhyR0ZtWlR5U0dGbDFqQlRET0RmQTRObnZtaGxOUi94YW50QlZ4?=
 =?utf-8?B?R0c4YTM3YlVHZmh3OVZxMlJnM1YvZFY5Mk9GejFLMU1VK3ZIak5MK3NGWVUy?=
 =?utf-8?B?UE11bmpXZEVJekNzVTBtaWh4MUNJU3BQK1FGTGpGVDlFRCtrOXJoY21HaEFx?=
 =?utf-8?B?bUVERkw3Ync3b1JNUmRIeS81ZkVWT1JMSkJpTWhwak5TR2Vsajg2V2diOWcv?=
 =?utf-8?B?MzdQMk9Ma0NGZUN0TXdnRmpDNEhkZXVhN2hVTmJOa3hlVWRLVjNjVXJOaXJk?=
 =?utf-8?B?ZzNuTm9iQ0pKWVU1bGcwckNoUDNJdUR3emRBU0FXcStSU0dicU5rUHQ1eGJJ?=
 =?utf-8?B?enA5a2ZMTDBiZnhFVGNoRFFZZDNsa0d1YXNIUURDenhQMkFQNU1hOEx5NnVw?=
 =?utf-8?B?S1dxc21DT1hYOEI5bnZ2b0kzWTZhckdOTDRwcDlnUVlpSDFWS011K0t1M1p4?=
 =?utf-8?B?TFdNdjVuT1RXcTVsaW5lM3dSSUIwcDlXakF1anAxc0VrVGVidU1lVytVTHFh?=
 =?utf-8?B?NDN1Vyt5dmo4WmdNK2NUR05rWVpFL0VXc1hCVGU3NFFHTGFDWnd5dENXejlI?=
 =?utf-8?B?OHJpc293UXAxKzBzVzlqTlprcE9ibFFCQUdCK1Yrd2JPQmE2cFdKSXFJdS9D?=
 =?utf-8?B?VDF4MDhCZkNMM0pVcXA5b3RTMnlyUG5KWEoveDcyNGxsSVZlZUdBUGlSQjJv?=
 =?utf-8?B?aHZybkNVejJaZDk3MXdGT2VqaGJPNGs5Z0VxRERuV0NQb21wMlZFS1UxUXVS?=
 =?utf-8?B?R3NvYndRL3hCTUJQWWtWTkFCWFVQSnd2cm9Qejc2elJYRzQrUDdaakdOa1ZC?=
 =?utf-8?B?UGplU241ZGd4RHNuYzFPd0JMQlp1SVQvWDZzZWMxcjFSd2V6YUFHZ21mQW5o?=
 =?utf-8?B?bGQ1bXltbkxRUm5WMHlsNlA5Y21qZkpzbFQ1VjJpVU5MdjFnOUwrY3Vzanh5?=
 =?utf-8?B?VFBpaVN0eFZzWDc0c2ZCeDlvenErZm9jZWM0cXlJd1IvSXg3c2wxRnUycmN4?=
 =?utf-8?B?YTdhSE5jTkRQUzIzaHlBSGlxMzF3Tm5tSFl5cXJHZk8vRWFabDl5bG0xQnps?=
 =?utf-8?B?N1d1T2pkbU1kUmtJTE1lbzJBQm9ZVWRhcytKd2xZOSs3R0FnaGNsVGRkU25U?=
 =?utf-8?B?dnRaekE4WTYwZ0pOWHBJR0FpUjlWT3l2cHE0TlhQbGt5NzRHU1FwUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b29aad3-4ca7-4df9-6eb8-08df130cc631
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 09:36:09.7487 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VjMvi/EH5HgwQM0tPKn+zSDLQzx7abQLY+fd5L0l5DnEWjtf0HphJsRYXCmIF8if65u3i2k9sTSCYrVSrsOo+kL2CO1x5ognrvRnH7BReSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7851
X-Mailman-Approved-At: Tue, 15 Sep 2026 15:52:02 +0000
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

Hi David,

On 9/3/26 11:35 PM, David Lechner wrote:
> Check the return value of dev_read_addr_ptr() for NULL instead of
> IS_ERR(). This function only ever returns NULL on failure.
> 
> Add <errno.h>, since this is the first error code used directly
> in this file.
> 
> Fixes: bf57dd5889be ("drivers: phy: add Innosilicon DSI-DPHY driver")
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
