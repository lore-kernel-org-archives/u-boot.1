Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D15CA9ED0
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 09:36:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9F7BC80D05;
	Mon, 12 Oct 2026 09:36:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0XjoeIOxE9ot; Mon, 12 Oct 2026 09:36:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CFF3380D09
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791797767;
	b=nRgoGSpYeaXFQqjcwMXYK6d7kCClkq/1WZGcDdFie7XQz6PNipKwopBgY84Z8NEckt4P
	 oz7eDiPBqB4slfW24OFerHODtrq0G9VOJgmLIk/9+ensHejT7IVKKthyEeuplhC2IXgfv
	 Z1qF1W24WCPKeNROfZ5rV0/VufL2UUNuGPeXczTxUcS573p0TnoOUg82iotm2WrL58cUJ
	 +aUZQxqnfGGVht0Y1++qjTHXvFp23Qtijg+NuqeQ57pjIF3UVQKETMKcEAs4/DiY1OsPZ
	 dI6McaT3uC8fUnpkKCFJu1yZjJfN72kK6qN2yyojvflaSFZud3UxQz5a2mqXtH7vw1A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791797767;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=fnzs9dyYryDU6rt3o1CVpCAGtpyWaW8DvKOCOYwKryw=;
	b=LKOeyhsdl4KgT6P95CbT6/QA1Pl7yGHjK9ybIcV2lFMnbcE8fmsYlJfTmpmL/tIGnqse
	 KpamClXJOPSVv4L9Zy8axZd9RVvDztGESFR0vFFDGxhQfV6/ONQ/5n0flmONz19R0jwCU
	 GK+LbfhPygx5GL/RBZ4RowD2Ld8S87pXFoH3W0FCJfPSTRN4A/Xuu5h34WjAaA6jKeOfK
	 6bPLqKsPuoM5uQIzjnVKy9T9MsP6shoAQ7imWQo5PffPzCkILtmZ/ygFX7hHPbeCOkINq
	 WI8giv3EvEvFM6LNY9+P2rw1eWo4Zrehrn6+/9ZRjWqdxoy/cxP1oJMmXie/oJzR39w==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791797766;
	bh=fnzs9dyYryDU6rt3o1CVpCAGtpyWaW8DvKOCOYwKryw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xyuzcbb7gBukJAz78Fgm6i5Kw+z2gJAEa59rSPKfiS/iuWbd4vah44RWo/Zuvqfn4
	 ZFoxuzf5hA7pp5aqRq2Pa4H3h05pM390UUXvACFTfL4nsmY4R7H0902iI/ChCKGpa6
	 cwgpKnn9xEFsjTL7ojCMgbP7dnfdiK0Qx3FnI+n6g09jLBiYdnJcGwNitdBcYa4LVL
	 boSwYD4SedRmqxfSQWadNTyRFIgMKH/ovhOv53q+9LCgFRjoaELMpnPJGLy8iDxnKx
	 fIVDOXLK3BT+APSe7Nka0RkYo2QJdtfUbwbuE6zC82Ueq+uBSni6iJlgidgigWYMpM
	 YAA3Y1Fu6Bbug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CFF3380D09;
	Mon, 12 Oct 2026 09:36:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B0EF9380
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 09:36:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A2912605F5
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 09:36:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8r9WsyMh4ahR for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 09:36:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6B4DC605EE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791797764;
 b=SJXNkwockt+BxtGd36cyzPAMEQCsc4iQdx9F00WJ+sVGsYd4N/e88wnqAdxL1yLhDcen
 2AJmFEdwv30VdYIMbatDDbE5xXro3zWEpQVWRQzsuv+kBag7WFKHoRFQD0mskKdqJHq73
 898KZOkBNNQ2oqSENxmlZ0XIFKIpEL2f8pw5h1Min83cipgzz2F0ME6sME9Mm1heGiPyU
 AjLL0c+qdNdqX7LYAsiasSdMprlfhDDGwFDzjVFw0CR0Dr2sgFWjuGv2FpZtY4mTKLewN
 BwdkIYny5Qr1RUeWLSw6F85QAVBWv4Ci44HjRQO1pg5uDcHOStBz/5nO1TOUTG4j55A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791797764;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:
 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
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
 bh=fnzs9dyYryDU6rt3o1CVpCAGtpyWaW8DvKOCOYwKryw=;
 b=dlZBXHHRdCHKEoRAYayctiGIyXzATRskJu++oHklVcpc/yVvlUYzmw1Ihb+N76xHa4/E
 7B3GyYPREOGp+lrl4HiOWogOw13VEpmW0andC2RGqdoXknYTO2kZD3zeeXG5dRGH3bJZm
 n8ByhS2FH1cBjfy/bDlurqdoHkuR+DAOADp5iNHqYPJSmPdOtuZIsdTUQ57NnIw6WhKPc
 yjtoV0QKkNHU15mK3pYyJU2Pp4EJ2dmV2tfq5i+h6W/ZnPGrQjWBcYxYWvD1guuKEDmtN
 xbR/TYo1umJaaHbLIkPtltmtrNUOE6aXxeSKS0R1Jt0EQZ0B01hk9PykVeQBbIwHOEw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=fail header.from=oss.nxp.com;
 dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=dyirOHjU;
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=dyirOHjU
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6B4DC605EE
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 09:36:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vWaBXtLMIAP/crN1hzIJZ4ZM7uhTlHVan/KIyV9OdZ6nCmdeGtwGaIHVpIk+l42JQM1KLGRlx9Kz7ILw09uxFtu23JFqCUuwv0Pb0YjR749n/TT8dh0K053KFOp613jXOjq2shxh3PGIiDGU86qV6vxJs1rncEi46Qd1WQEnpoa6tpyxlCJ1ayJbiKoRMxRgxR56V34y/ngAryjfl1Y4n1wuZBvNFGni/ZqEcTB/eoQrBrbPv2gF4/3HMvVN8E2Tu+eku5IZn3bbAB1JX/rEF/K7LKNZbEBwffveRyPef7Ye0LAVdT6dTFpUlA5tYZTFRrWXCoTvJQpfz/Qpu8cuyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnzs9dyYryDU6rt3o1CVpCAGtpyWaW8DvKOCOYwKryw=;
 b=LOEPlhyq4dijZeYFzwrtRqMxNSiL0NrMwVa5JmMxT5bT2L7gzR0TdjIazBjXew5JDLTZXQe2XBN+fulANSDZ4G3KVb8Pt9svhC23ETV1NIBo0mh+B+GI3VRDtQ244ijYLLvPy90i16rQhGEeDNbq+hm7xRwII1ViZGjZzTTZOOBveVHyId32j3upGbo+mDGx9ASqI+j2Yy1XSmzgsgHgoB+kMYwX2zpjudu77nl2ebXQkisxPPeSEcseboDnZGtw+tKowEknH2LwdjopJdCxXcwT8j4w7+9X1kxIByk+OaqVNxbozLjmNinBbvDf3/s45eOcoqEadOEMxmn7bNoL+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnzs9dyYryDU6rt3o1CVpCAGtpyWaW8DvKOCOYwKryw=;
 b=dyirOHjUjMnvsv4jdqBPY8n8AJ0vg+IVAOT91j8cF+fJ7sV9CbcBtm+L0zVEYSu3Vp4Uf82ArwI8NdYvTWW09wkX9uCeMWlVjU1DUUhe0z02f7UpI4crqXh4WculNioHw5DMkKhGfIof8hoVaY6Hotgb4ArFlXdAbrKzJRo9Mxq07csduUXRlW0k96+XuCUNvB0kBFV5FG3jJgcnyApUnyXGGmLu9uwk4JZfISuEt45ETJgtuJGC22jL1lwp43a6IBvvi//IeZM1j8na4P6MJfHiSTWNru1qHpEImRBqz1MgorBarInw6HhBpqpYdhqKQwJq5WHHk341Rc6U5CIl5g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by FRWPR04MB11224.eurprd04.prod.outlook.com (2603:10a6:d10:173::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 09:35:57 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 09:35:57 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Peng Fan <peng.fan@oss.nxp.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 u-boot@lists.u-boot-project.org, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH] mmc: sdhci: do not time out a command that has completed
Date: Mon, 12 Oct 2026 17:33:13 +0800
Message-ID: <20261012093317.282792-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261011-upstream-mmc_sdhci_timeout_b4-v1-1-f33c02445924@oss.qualcomm.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0030.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::17) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|FRWPR04MB11224:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f97f7e4-3f94-43e8-855a-08df284437cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|19092799006|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: J1Us/6fCe9ZoRsoKEFIA/OD2HDF4/+2W1q2apz3wLVdirn/94lgR4yVAR/ukkTz9RFG7hsR0ZmuWajpPKq5Qy0vOZTgaiGJw5KOtKuztlZbe/oQtMbcymn4i0GUknpTzzF6iqgGZH91duNueGU1Oc+F+RrKFziDDXrRbxolFFKrYmAOJN2NF/rBZgehSJ1G+w7BzzWXbrqrgzk0uAqMuq8Kvbpjel8DvvXO1ZxbFlvkIFgufp4hfG4xZkXlkPW91WeDqpW/eQIooUdeFXTwzjynyVSmbIvjyxPBeR/A7/X80FUi378I/XyAnFt6YAxm1wr2fzMvNLnyns9qYX8/LZYGK1sntvl8DwD+3ObJ+1hgd44vImO4bJ8yBbmEe3hRyh/C4YTMhVVoqFltR+UGflswHarWxdnIvXrCTDTtQGitz4+mZsmH+tiXofDA4T74VVUoCD3KmUf/5Lp0Yd6TnXgd5xSFS8tbHcLC7NeF1zakNtUMKoE3ciur26sFziFZ9XFyQlhvTlomAE9hhyfZZHBk8d8hG6iG1CINk5qX9j4y/kyHJx9+YcDnI9ALmJieoo+Dl8QRofGVCOIit57twzsSUaFoDa/FV/G+bL6YzEC9A+ikhfh/HhiuvaoVOwpRVs6pjuO/mpj02k+5xmlT+am7tQVIBBVmKcmeQUsRt16g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(19092799006)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8R92lA3ZV437YA4/Xem42sUvWv6vhKOYkbUmeyIsTJYKor9/u3+FVsr9yrfz?=
 =?us-ascii?Q?wWsx1h3r8yfoM0lENqP/pNTweVnOrHF70GjS/dQIQSLE9RTYABf0wvKFkEP8?=
 =?us-ascii?Q?ghzVCOeTq/0DM/9xgbg0xXmgdyWuI33nkUZ/3Efm37QYgZGRCxfE36g8gvQw?=
 =?us-ascii?Q?OYiG2CZoDpDWWk0n+HBM9F9a3X4ALUhM1pEmqyQcMXaB06wp9uTSDHeG23Wf?=
 =?us-ascii?Q?WnJ7HjTVT92RrR/CAScHvQx6mFYnQYYJvGVUjCIuSXawq3qi0l7xkYSeqDjd?=
 =?us-ascii?Q?WndhQN2BfFQHH6UZclYjT5vdnY3UV0zA//6Z7alo6d+Pk7XRUyImF65AbOkN?=
 =?us-ascii?Q?jeHX99IGl36lWMR5POYzbddZV/lO1GPjIvGo3NZAxOFiWmbHj9ODlOv6cJGb?=
 =?us-ascii?Q?YNMzlQVo+Z/RMQtTUEq064L+KjbNMBeXmRsdNHrSVcy0RMKmdHj0tORLgNCy?=
 =?us-ascii?Q?Q4SRewf9hFSH29JHB2e7K9k8JhDAwDa8WBgMsMitKahkhpVLBvh0ZJ4mLbm3?=
 =?us-ascii?Q?7WzzFwNKTXey89Chg8dQypKtMAmytt95rC/ok3DWl/9dkBfW1J1xjk75SSdA?=
 =?us-ascii?Q?gXTUIuvcM7RtLjCWEZrh5MI3/qFuMKItYZj0ZmmF+sz2xtkLSTChCNwGcOB/?=
 =?us-ascii?Q?4BNZv1bOOstOMNcuBNmazFnxDmMoCL5hYsM7j9t7UQu3kFbn762pDMJgld6A?=
 =?us-ascii?Q?t4z2tO2yV55E/y/RfhILWuOvuM3gBdtPbhku902t6SLdq02026hzbLntQaBD?=
 =?us-ascii?Q?Y1wl+B63U4gyQzu9zPT5ZGbxO2M6RMDROXIrpeNJiak8xpopZBgSMnmMsfll?=
 =?us-ascii?Q?wNvL168xUi+hDKnV17ypABntXeC7Q/VEyGOmN7JDeD2NgITfFxXwT+MePPtq?=
 =?us-ascii?Q?zREzbvUueATAY9Xx4hFSS/Bg/d22LgMHOzZc90UFraTv7DJi0QEWeigcskVT?=
 =?us-ascii?Q?GrwSC5f19JD5g8VLEvEcCYX2P5pmtTkAwiRNFWEPAkXnNzo1tLagsi6pR5tM?=
 =?us-ascii?Q?P5u5ftu9zcUZQFJXjIB7aYleoZrpMCmcxhBdgdgoMSqBJlfui5wxzlhco0PQ?=
 =?us-ascii?Q?JZh4aIs3/58jbdH+2P7RA3K4xC1+1Rul5Y5Sq3ogmdiTgC3isnz7MRwJjqay?=
 =?us-ascii?Q?DmZiwplz2kaZRbXT9y/m4IIS4bdpoCeQcSMG1EdlB3NuWhYU1IeHbVEnV1Lg?=
 =?us-ascii?Q?TkX6MUEC1IO6mxe/qOLFQKQ4RucRrityF4XPTCxf+VCciEB1o4ttrbUVrKHx?=
 =?us-ascii?Q?MUFdaTIczBUOHa1vY6G/l7zeTOSEYfGiPvTaDsJuQ3rK6T5Gp9MW9x9qkpAg?=
 =?us-ascii?Q?MmotvJojtuo40vhiI1PQUawxKg9XculYaafKg80kMhUim7rbkOVv2NAjjDze?=
 =?us-ascii?Q?tDh0NslECUY8825XH36JhI5gkB6c06XnSJngHnOA68poxxO+9KAupPfxGmHw?=
 =?us-ascii?Q?5lQkVopPC2hRCHAFDspSfv0q+cJ2JdAaSm3T+83feUVEsHe7xhPQ6nwA3YHx?=
 =?us-ascii?Q?JrSDjx73XtjMvC1LcOiKCt3eVKHsubb4XdFoktCMtacckeYhL7vplwqvMVJo?=
 =?us-ascii?Q?97gl/OP3iI+P1mD8U9HNsNsbUk+lJiCh14UxPbhRLDJLZFGO0c9X3xtEEt6L?=
 =?us-ascii?Q?VQwJcj5erm+M3HMnrSnWteMR00kbWhB2joTjYVGPnqFevTey8RKAhzyZ3n7V?=
 =?us-ascii?Q?JQSTJN6bgYZXOAhMx1tDUpaDi8jXNhfMg1I00AB0avCqju5scE/j6xjIkluH?=
 =?us-ascii?Q?eCYhp5iPWKZL8WH/WYZtiqn4lSSwdjrCaPSvm9Aj4sf2xuRnSQHI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f97f7e4-3f94-43e8-855a-08df284437cc
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 09:35:57.3685 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1lKYG2OvwbfC7SE0mXmk2fN+B070Fp7es9w1Xil7R773AAmKclcIet3Wo3hKBhEKzfgw1rHs8YL0FFibyAO2RbOsybFFVB8fGyaDJeUBxe5VaeacDkWcwAR4eHgjpRSU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11224
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

On Sun, 11 Oct 2026 15:12:23 +0200 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com> wrote:

> sdhci_send_command() polls the interrupt status and gives up after
> SDHCI_READ_STATUS_TIMEOUT, but it evaluates the timeout before it looks at
> the status it has just read. When a single status read takes longer than
> the timeout, the command is reported as timed out although the response
> and transfer-complete bits are already set, and the caller aborts an
> otherwise successful transfer.
> 
> This happens on QEMU's SDHCI/eMMC model under TCG: a large ADMA transfer
> runs in a timer callback while holding the big QEMU lock, so U-Boot's next
> MMIO read blocks for seconds and the subsequent command appears to have
> timed out ("Timeout for status update: 00000003 00000001").
> 
> Check for completion first and only then for the timeout.
> 
> Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

LGTM:

Reviewed-by: Peng Fan <peng.fan@nxp.com>
