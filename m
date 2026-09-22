Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9202EC982FD
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 02:57:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3CAF5406F7;
	Tue, 22 Sep 2026 02:57:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WYHp_kfguYqm; Tue, 22 Sep 2026 02:57:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 694D64077F
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790045822;
	b=iRTdOiK8dn5ySX2N9GZqfNaq557bLRGqVP1DrtdzWHk3nsD0+RvPt7xGgn+DpP2sErDb
	 jJPhWxI/3Q3AmTMZaxHREnxEK/HirycJm4wFb5sPGv1ycujn6SkbH1Lf2Jg369zeGCeIC
	 sLjAh49LPDr3QqGAGDhIQKxqc4XkuyxoFgUwMDuor1JP90hfXzSE69VbqJfJzOzfZawk6
	 Y7p0CK3Sr5oCYshlSQ1xlNlx1fmSSVYtd+MO01yRaZy7evvCgtQTauf4jngroQr7RbdDr
	 ADOCWWqjDO32zIyklZX1/iUrte3QgPvDdbyot63mK6jJRzteCRJzyTd5TeXOgheXe8w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790045822;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:Subject:Date:Message-Id:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=z9bCEALrzt7PrdK2pLWB0eeIuNOjUcMdrQpyPis8/UQ=;
	b=g3E+3us82+WWhvE4rXwjYLR2DDTb5IHsmjBITvGzpQHTmyqD1ezJjodR23gL487HJiGq
	 DMgodFf5maLsVRveQpEv/aQeg3Jf2CurASomHCsR+JXvQDChNW5X9XxNL3RcE/dkj9fMD
	 qOXWxjfmMkbzIU4t3M1Ip9EB0VYoNtyaAmhfmAheXH+s5vtqcs2eFbYkY1BA2w+oWMs+l
	 hlkTMMy+keTTnbRMh5c56Qb+oE7Yu34lFsan6ud4X3l9HxGfbW/BlbTj6iz5WZ7qePH/p
	 jfNgi21ejXARCfqfNMtKrkOO69zF/9a5Ra80jjhrFPe1lPiIHWSKPBaaZMiLb80GSXQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790045822;
	bh=z9bCEALrzt7PrdK2pLWB0eeIuNOjUcMdrQpyPis8/UQ=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oBYmpSLuRbWod68Wod5zT3e8HEypxe/YFPhJFktMiHzz6HN/iOn+UuutwLcKOjhCJ
	 k/arzXqFBqTFXslOkId1x9WpMwJqqb5tvpCfwhcit0i9VbI8a4XtEQ7rCx/JOANiep
	 t0rKXbgSJRtlvN10egQ1XGCC1F/08DzfUi/fuF2Q5YoM7zBRNiBBAI2yCHgBvMhcS7
	 mlMtj2gpXTXnLrGMcKD8HSXHZbfwmV5vPPaVY4SVsFVAUaBrJ+0Sscu2dQnjZMpOnw
	 t4DDIbj3Cu6WdMaYyIeCiiZyVnK46wOIEBzksT92OX0eJd2VyudFg/Ce+bBp3iC0G/
	 H9gctLWMskxrg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 694D64077F;
	Tue, 22 Sep 2026 02:57:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id EA53613B
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 02:57:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DC21160644
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 02:57:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ajhdcY5rE74M for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 02:57:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CFA3360642
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790045820;
 b=sTdCoLo/vgxs/9gmCTVCzq603yIE4/5mx6CZQPV6EAbACI98i7K3rowxFaRX/ZbIHtsH
 fn90OBSo/cgJ208zAVK6rCU9iyIWwHHEGpObL7iZTr1IH9tCCYB70lIK2GCiv+BDcHtwU
 PQQlygMskkIyH0lYnjQ6eCk+fak5GjH8MOmEOC16UuopAmM+wqIRBJJ5zRktMbvocIUcM
 MjP59H9MVglzL1T9wEVlkdy3QJ3yByQp8O5PQ3sFMuwsWJZi08raY896HP/7npAFdCWai
 ShGt56Vnxyf1LJAOAcZpGuiua8HYXiI4OmwxmUk2CAyqFRZ4BKWazCXOcEZe3YlZtzw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790045820;
 h=Received-SPF:DKIM-Signature:Received:Received:From:Subject:Date:
 Message-Id:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
 X-Change-ID:To:Cc:X-Mailer:X-ClientProxiedBy:MIME-Version:
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
 bh=z9bCEALrzt7PrdK2pLWB0eeIuNOjUcMdrQpyPis8/UQ=;
 b=jltTNAvfGDuar2CGReWZ38ewWalQRdw32+PpHaLdXnlMQNFQRZw4fAdkndoeVedu4ivC
 9jMumWCy4I6PbJha1MSxwZodhTGJrDcbBOqNl9DA/VxhdsSLK6loiZ5bBbROmvCsytx2x
 vrSP1srzYRVtV795oY55hby036nPcJlJ6oBgKUixYx8PfR4r32Bs7gb+K6JMs0K0It/gJ
 PHNjW5mH/M2cka+kfClbMA3/CdhVyrJ3GUlrgHkz7SixVwYWjNf4apv/7x9Rem6+CzhqP
 5mmJTdPgtAetWmB7f4Porw0zbMcladjH8N6rjUMZwcxqbpMjQ9Ay49lJZc925hOiDZw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=fail header.from=oss.nxp.com; 
 dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=VY4hTOOf;
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=alice.guo@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com
 header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-NXP1-onmicrosoft-com header.b=VY4hTOOf
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CFA3360642
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 02:56:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VcjxB2qQBDEMpXf11hac+MdpJxyEtDLV8A7+2xbYfsKiRU5aeQyvMs3N7RMuo4wFzB4kjFjMscFg0/hlWqHL2oSZIpR+Yski6tA37VmGoVmSLG5qqwwltLRYJwNWTX+oumByL3Em5/LjCkyba2tMiFwB4WaKXCSmuCEoc7q9iZ+qcZv+YUMf52ldVHxy9Q7fp42g5qbkK7R2R0mJMYVTx8QP1TawTGLk9nSF7HCfvGX7t1zYRdYEyBwcr5kwFiKCb1CdEUTCc/KvI3U2Be0jSzY1tCaNzusq4LT90bIVYDZIHC9XzNPldvU7D6dk9aTPR8uyFBoPxweQoISZoiijOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9bCEALrzt7PrdK2pLWB0eeIuNOjUcMdrQpyPis8/UQ=;
 b=efQ/fzyH2areVXMyq5BClfRYn9jmteuchw0uyF5ikVU4SvhMDys+DTYkdm4x19T+SJz7AXq07nDwdxPrkgr/bRZQRW3EL0s2622w3kMIzljGaPdfZMJLPqMSCPaCDqAQeOKBoNQ5ufkTeI1/2V55HNnvGHoPISAWAinh/3yE7U3vNgqwzD2FMtpPDiJffTP7cKzjX3Zf66dk8MgoRiAtakm7UmfRAfY+oA7rj3WNbPoKasjHn24Se26+tZayoUr4+qW6Qxfeg1SC5jQRstdHvbdDTy6DlpVGS99bFZPDRMkU/Kju998fTbFwaAdg1xKRlog6AQcFozZOryZU7ZjckQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9bCEALrzt7PrdK2pLWB0eeIuNOjUcMdrQpyPis8/UQ=;
 b=VY4hTOOfHqfthNjtTYVNBENpop7x7NGUujZHHKOLVZfHFPRNdDLjD3wthZzG/NKt4GQzo1WhPXW8ZuCfbqDHlE09EXpEMu4Ue7PLxlPz2TznEli1OMXoENde8Qef+3jkNqN+ykz+h3nRunPwQcQKwZdo/NMDSEc5JourbVx+9Kow8/6QbFhDU6w4UGCMnJupsvRFVoakgyhi6ltf4Pg/Ibh3LOSx7NscHIrdRhRItuqe5CRLBdE+9+0kGU1oHFrOST32HvE4lyGcivi539+oZcehCFTq15D7wdatP2PqXCBEyXoankLL8nX+FRenfP0wJN1fcA18OLC8tSLSQBEHBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::22)
 by AM9PR04MB7555.eurprd04.prod.outlook.com (2603:10a6:20b:2d6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 02:56:55 +0000
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1]) by AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1%4]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 02:56:54 +0000
From: alice.guo@oss.nxp.com
Subject: [PATCH 0/2] Add i.MX91 9x9 QSB support
Date: Tue, 22 Sep 2026 11:01:13 +0800
Message-Id: <20260922-imx91qsb-v1-0-8f8b0ae23af4@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHnvsWoC/yWMzQqDMBAGX0W+cwPJggF9FfFg7Kor+JdtRRDf3
 dgeZxjmhHIUVpTZici7qCxzAvfK0A7N3LORd2KQJW8LIiPTUbhNg2GyOfnGdSH3SPkauZPjt6q
 wO9R/p98wcvt5HriuG+DklU9wAAAA
X-Change-ID: 20260922-imx91qsb-e20526a1fb56
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Joy Zou <joy.zou@nxp.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Primoz Fiser <primoz.fiser@norik.com>, Johan Jonker <jbx6244@gmail.com>, 
 Ye Li <ye.li@nxp.com>, Joseph Guo <qijian.guo@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: MA5PR01CA0304.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:220::9) To AM9PR04MB8114.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b7::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8114:EE_|AM9PR04MB7555:EE_
X-MS-Office365-Filtering-Correlation-Id: 56e4639a-8ddb-4104-96fe-08df185528cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|19092799006|10067099003|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: O/BmWOGfaezlHmi/n1e5wkp1A+g6/czHcYtVFEjdkJ7S4v4lXHAEtq/CsHg3vTC16ji3Ei0mM0SSY7rfHBRpgXnJ8yq4HuO5OhmUKCIcFTWWtUOdOXLHOC5hJ4GwGvGhwghCn8YNquA9yCup/ZIcFKSzNMjGEex2vClOYH310Q6V6RIJQ2b09+a9pALwtZW8rl/8XHLcxBf9+Frhn0PsiqQQtuALBxIFcoDDIG/t4KflpMJHx4cePRwo+hWOuRglGZPl1d4WctRrow/v+rkxdSv+8TkkooyQQZ2ANEyDUDmps+4+e3bKgKfC82a8CI9OfNQANFdEHxsaVfjHgiH/3NWMgdNczZQZC7nq6r9P7d3bg1hWNTh4pETHB6TxLYDMPp6mTTqofr5lrHtOox907BGyhtsFPGVxPg15YSwBQDkTWb+sPyXQ0u9mL4x4t9jJAFeeMS3GI/QXiB/EeAdMKEx1JRCaXzTBIL8x27qHE8hbQBQvxz/cLdW2Q2acR+AgYGH2n2YwpcEqul6a60D1k385QO/hnsEpF8cn/7O8vN/5ZWDeym25KAzD4wIj9nkwVKzRJSNwxiqyj2oL5hwQkqR74gWp7rEbkM/gjjA65+YYA6ClNT9M7zlexkdBdu/i3vDp5DrSUs6FidW2evoWLaP6enWltTycbRUP6UGEor8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8114.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(19092799006)(10067099003)(56012099006)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFdrMSs1S3JJZDRKMm8yaXZRSHh4MVRsRE9Vei9aSlNIbHZic2dsaUlLYS9D?=
 =?utf-8?B?NmFMR1NzcWlBR2dwYnZvQVZpTVN0MHhtZWFDb2ZFb1FvczM1OXA0Z0g5MTlP?=
 =?utf-8?B?Um1TQTJrV2FYL09HZm9sZENtNlU1WmJIOXZzOHJrMEF3Rm96UWtaNTl4c1Zz?=
 =?utf-8?B?Slczdi8vd3FnQ25oRUJaTEVhaFQyS1BqQ3JKenRWYWJqYmN0cXBtQ0hBSUd3?=
 =?utf-8?B?ZW9kWDZhR21YMC9VLzUwMEY3dE5Nb0NaQW1hazkwY3hWRXpFL080QVlFTlBs?=
 =?utf-8?B?YkxDN3JLMGc4aTFMTngwYnpHdXNPeEEyalhxNlhRWDVwemg4TkZHdE1ReXU2?=
 =?utf-8?B?MVJhZnJReHg4bmc0enJWb1ZOa2ZoRXJKcUxKSUtQL0JYZHNlOWorR0Z5VGVR?=
 =?utf-8?B?WFpCZ3QxbEFYZmtPNmlpbTdWVUtsOUUyRHZsRHExL25lV1cvQmZ6NTFlUEtC?=
 =?utf-8?B?bnVaMGtOTnRTWGN2S0FQVko1WHhRV2srSTBudUk0ZW9reGJscjIzZXVvV243?=
 =?utf-8?B?TnBtNi9qamEzcm5jeFFKU1pUOGZydEV2L3o0RVFrZ0puTVZrRGJFcEJrc0xF?=
 =?utf-8?B?NXBEWmJjQ0NpdkwvTkVFRnAyeERMVHY1UFp6b0MxbVJKais0empMUWVYbXRw?=
 =?utf-8?B?b2MvbGFsZnlvRjRZVnFDclJhamNQUE1FcE1admlmMi9UT1dzckJybE42bVIv?=
 =?utf-8?B?RTJEMnF0NllHUmE2TFZkVi9SWDdkQ2RxUmNIWk9QczhPbHEwVWs2STFtOUFS?=
 =?utf-8?B?WVNDOEhkQUhHSDBaY3lLSVdYcGNnU3IyRHdoLzVBTmI0a3Q0RXk5U2Z2R3dT?=
 =?utf-8?B?NEhvRjFITWxHcTV2ekpteE9QM1VUMXdtbkFmUGpPSFlUM0xGU0hiSXRqMThZ?=
 =?utf-8?B?NEsyMng2VVZ6S3hKMHRKVnFhbzBjVExLUDZ4ajdXNmN0YWJEdVEvOTM5NVBO?=
 =?utf-8?B?U1ZzNEJjc1hMNzM2NTAzTG9uaXhjVmZTblJCNVM1S3dRTG1DK3ltbWlpbm9Y?=
 =?utf-8?B?K25DN3ljRnB0dTBYMU5OUUxmbkJVUGNFM0xQdDRTTEtvSXJSZVd2aXB1Ulh1?=
 =?utf-8?B?NnV2QWxNZ3FHZ3IxdHFsZ0ZUK2ZmczhrM3d2c2JqUU4zaXJPbnJzY3JBR05M?=
 =?utf-8?B?ZjU2SHRFdzZUVldGMWlrcjA3YXhBajJhcDhzVlQvamhSMjF1VVlRMlpldnhI?=
 =?utf-8?B?dlJKNHBuczE2bEFXaE0xK3p3bkFpOXJKN0JsSkdCLzQvc1BxbUpHZzJxTUEy?=
 =?utf-8?B?OUdEWFBLL3pUangrdkR0bE5kRmZiZ3Jpa2x3QWVyWjFlK2xjNmFTNXhIeUhN?=
 =?utf-8?B?NEIvdVFueUltYlRoV1lDTjdKTnhmYzI4UXpBSUNmaCtMaE9BUVpCQ2lCSjJp?=
 =?utf-8?B?Z3NjcXZZcWY1SmRMdnNkbmRXZTdQeXU2ZlBpNE9EQW1jTUU2ZHBCSVJ2MjB6?=
 =?utf-8?B?WVgrcGVteDBiUnpXRWVDVnZvQ0c5R245TG9mamhaUU1Nb1Y5UklZMlMreG9L?=
 =?utf-8?B?K0Z4YWJnbnJwYnA4WHNZajFFMDIxVnhCUGN6YlRZTzNXc3gvdy95cGU4Zkdm?=
 =?utf-8?B?cm8vVzI0Wm9SSnVPUTFpNUp3NFN6UitMU1dkSW5YRW5LWWpjZDBJandUOTdk?=
 =?utf-8?B?STQrT1BmR1pENjZ5YmlFaHhEcUQ0azFDVUxIclo3eEllc20xY21NVXJ5L254?=
 =?utf-8?B?UXNJbmxGZmRYK25vOUhaQzduS0lDOUp5cmdMUTk4Y2dvRUhoU09vaTVGOGpE?=
 =?utf-8?B?SkNpOGRyQTg1elprVVlZcnJOazk5R2x0S3BMZmRJckpSU2RnbFZIb0NWSDg4?=
 =?utf-8?B?S0ZmQjMwaGQzYU9xdm1ENkx5TFJHeXRqK3Z1YnBBM1VXd0JmcDVhVnVaTkpl?=
 =?utf-8?B?Q291SlRUeGR5SUhybEljZUZKckJFbFgvTlExcHJkb3BOYnNEb3B0bmx3clZC?=
 =?utf-8?B?WXlrMW45V3o2M0dzUVNrYmRDSmVzYlREdHZacDdHUGJFVElSSzNzSFhlcHhp?=
 =?utf-8?B?RVp0Nk5Sb0xndmZMWldJcFNFL0EwckxCc2gxaVYvcjl1cTFJWmJzS2JsU1Ev?=
 =?utf-8?B?STIvOEgwRmhnaysvUjVERW1SMTBpUCs1bXJPN2tNck5ZYWhZLzIyZWdBemJo?=
 =?utf-8?B?TWhWU3dtQU0waUJVUWhRZUZDdXFSa3NWMmRDRnEwQkw5cGZPdk1hbFdUK3Mv?=
 =?utf-8?B?VUpRdUNuU2U5SGpZZ2ZXQjdYNEVHODFDb2V1cTRSRnJvR3IyYm43d05UZUxv?=
 =?utf-8?B?dUd4UGtubjFRQkZDRDFyVXpicHdDUDZQT1A2ZG8zWERaeFJsMnkrS0hLQ1R5?=
 =?utf-8?B?d3k1bkp5aWVPdmJHNkphcEdLYjdWbW8zSWRKcTNMd201bzlHLzBYWCswRnZU?=
 =?utf-8?Q?iGeb6mXxcV2OarOVR9GqHIf/UXnCXC6WHgsOF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e4639a-8ddb-4104-96fe-08df185528cb
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 02:56:54.9348 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zhoOUDmzh/THVI21M5UTg2aX5ELe5ONwIxbzS4H3bgjlN2ZueFvQCTrBoTIwJ2AslwZUmTvpLXJs0brtZMEJ/l6tp/rSqVKMCtJ5F2fIPFs5ZVENH1316SdzyWCsydT/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7555
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

This series adds U-Boot support for the NXP i.MX91 9x9 Quick Start Board.

CI: https://github.com/u-boot/u-boot/pull/1051/checks

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Joy Zou (2):
      arm: dts: imx91-9x9-qsb: add U-Boot specific dtsi
      board: imx91_qsb: Add i.MX91 9x9 QSB support

 arch/arm/dts/imx91-9x9-qsb-u-boot.dtsi          |  184 +++
 arch/arm/mach-imx/imx9/Kconfig                  |   10 +
 board/nxp/imx91_qsb/Kconfig                     |   12 +
 board/nxp/imx91_qsb/MAINTAINERS                 |    7 +
 board/nxp/imx91_qsb/Makefile                    |   16 +
 board/nxp/imx91_qsb/imx91_qsb.c                 |   84 +
 board/nxp/imx91_qsb/imx91_qsb.env               |   98 ++
 board/nxp/imx91_qsb/lpddr4_timing.c             | 1998 +++++++++++++++++++++++
 board/nxp/imx91_qsb/lpddr4_timing_1600mts.c     | 1998 +++++++++++++++++++++++
 board/nxp/imx91_qsb/lpddr4_timing_1600mts_ecc.c | 1998 +++++++++++++++++++++++
 board/nxp/imx91_qsb/lpddr4_timing_ecc.c         | 1998 +++++++++++++++++++++++
 board/nxp/imx91_qsb/spl.c                       |  141 ++
 configs/imx91_9x9_qsb_defconfig                 |  151 ++
 configs/imx91_9x9_qsb_inline_ecc_defconfig      |    3 +
 doc/board/nxp/imx91_9x9_qsb.rst                 |   69 +
 doc/board/nxp/index.rst                         |    1 +
 include/configs/imx91_qsb.h                     |   28 +
 include/power/pf9453.h                          |    2 +
 18 files changed, 8798 insertions(+)
---
base-commit: 951132236b9adc592c2e49faadd103c6a355cac3
change-id: 20260922-imx91qsb-e20526a1fb56

Best regards,
--  
Alice Guo <alice.guo@nxp.com>

