Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A91E606A321
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 02:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KRWXLUch;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=tVi7OOHe
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B146040643;
	Thu, 26 Nov 2026 02:13:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hGs9FOdwKydm; Thu, 26 Nov 2026 02:13:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 065854052C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795659238;
	b=pZZWDYl4xzYToVwlELkdmBgBpqydCHL8oYDnD4Z36MvVENiH2VZlmBVosckzEIpPggYN
	 doQWQf3sIbZtizCHXyjUPcoF67xBnHWxt7/nM5kNchR9yjL1ktciZPrrUA17fqcGuiPVM
	 bIGu5rxErtKsfGqa0gD9a+RPiexKyk3ythBHBL3fKfOrwQQF42h1OjsM6fy8Newdj7pFG
	 rpJ+juooWq8iFCYmy+L9FniTdn5SAXqO3hVZTveFk60iQIsh1702r+Kj84QZ4IH0O3x+i
	 XM968k/sDtZoDtUhlaGbTGHWFGVPKsh2xwEnIrQZ8pru+bceEyMO7L+gFIEk4Q5rEbQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795659238;
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
	bh=sDFgoZjmagiN4P323zOSpMhB2iy4M8CsmqtWA563jjw=;
	b=FyrzRSaPUnA8UlEMKYiXVINpVhkzJbaffv2ifHbUGby5BMqqmMIOyb8ArHvZwWv8EtSl
	 XMpz2/k01qs/RlgWycMvnfbvnFUb2H8i95HFXdgdigrgj+0rmtYPFDXPCgmQUItxLKr6H
	 v3rkhiXNH6PWAXU7GEg+GdJklkuRaCoj7thjrCGqEMiY9T4SCnHGvOY4uiR5dePHTLZgT
	 aHTmsrTJR4X01efT7YgTPLFBQ6oQVAL/fFawehIiCHyEgwzTrV72WqU284yaxlu7MVcXy
	 9LbYwHfRItA/aPlYMy+UI34SVLrrR276EvenzF/8pJl1CQ24NvlkwQ+iCE39dEk3SyQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795659238;
	bh=sDFgoZjmagiN4P323zOSpMhB2iy4M8CsmqtWA563jjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KRWXLUch2OD1QHJWOcnRvkbY22V/AqjVzsRSduRVYBZy4DdmeESdM8Z/ZmVzaBnwJ
	 2ISe/nPCYbYexW0I6sZ0drpCf59ubGGE2fgWQ4vC1sOHSWNlBuMNClELyff4l9celd
	 ikGpSP4ksKj9+a/hKNlT4uG4s94+LQb65UnpuS6TAl0NqyHcUpo9fbH5GyWHeEV5LD
	 IfYTezUfqGTNDuN0BzxTVScbghrwDXQUszq/6is7alpRYVTyEQ1wqSxKmgwE6os5fL
	 9FVt3Lti+kpITjyYTZWZczGzsSCDjMGTydLp55tXeRUTfMxVqtM2+3C5H+gEoWUlSk
	 62Yw8Vy0x4VwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 065854052C;
	Thu, 26 Nov 2026 02:13:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 477EE260
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 02:13:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2D085605DB
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 02:13:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UFYKJe6nzJbg for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 02:13:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CF2C7606D9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=tVi7OOHe
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CF2C7606D9
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 02:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDFgoZjmagiN4P323zOSpMhB2iy4M8CsmqtWA563jjw=;
 b=tVi7OOHeXfKEuUpPYpcaAinbwbgXldeyZzVbXmrnra/lY1qU44OMgPAWaQ2UYasqSrt5X6tqn3+OR/g9LjtsY69FbZDbzatrCg4qu0otazFLrZ4Zq28pJEEvAR8pYX3AIH/Gjiq0c/wCvhGJ2G5g2k8IObzYXgGowjBF/qPJaf/9ch2vnjVaj1Se0v0QHeU6ibtmYLZBF3pRE+Viqaw1KW9VWg5+aKwWApfpyO47mfEzCCNQAPomijhQ5f4Gz1lj7EGCR2zPuCJfQcbUm2RIqcWB40MHGlACV15bMxCl7WY5clnzI4YgyEhi/7uIHShM005Dpo+nzwNg0VX7IvXROw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AMBPR04MB12312.eurprd04.prod.outlook.com (2603:10a6:20b:723::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Thu, 26 Nov
 2026 02:13:50 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0639.012; Thu, 26 Nov 2026
 02:13:50 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: Peng Fan <peng.fan@oss.nxp.com>, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Bradley Morgan <bradley.morgan@linux.dev>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Subject: Re: [PATCH 3/6] mmc: Use div_u64() in mmc_berase()
Date: Thu, 26 Nov 2026 10:10:51 +0800
Message-ID: <20261126021051.40183-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261125124259.95636-4-pepe.schlehofer@gmail.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:295::19) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AMBPR04MB12312:EE_
X-MS-Office365-Filtering-Correlation-Id: 13ff4cf7-4da9-4be3-417f-08df4b62e962
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|23010399003|1800799024|376014|261026140227099003|261022105027099003|10067099003|261026121527099003|261028144727099003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: M4xnm7QXn/ZptQpjCDB0hZ+jdxa7LazjcbNPqpZJig1hnF/QZALd+k+RRW6YWdOXVtFJwcrHIX9MncW1rt/opIkzZQmZtxC4sOkL1WsDIcoZ8kymV2W3HOMvf8l0ebO6qhiSzwpJ9Vr9rvidCqU74wCypye7ikM64vesxpgPU+VJfq7DzVk/QG4VQSyxqSrlAaneWuGS0g4fqcqAf713C8Id2AjsiR4d5Q4teai+UEAnB5mNvbuLQtNPjI7VEzXVXCJiiL1O1QlG+td2clC0u96KcgjCWRcdEW0rFcEUtKhHZyGyWTFd5fNnehCr9xXRdKa9DWA3dnlBUHZIcldzC1yWG8pn8jN3I4boZ01iHfmLdbqqHREH0H4cZSldaOQVP+/VSW7YOkCZ9cMTzfeXfvPeJVE23XBYlsHA9JJGT1gtFj6Pi1dhW0anEc2pJ/+Ju/CtpyWp6qT5zuQszxXc3ixLCwS0AcdhgtwF7ZKP2/8ioHi7IpNOrZuxLfV0ftqbx34DTJzr8mBJAIHkMo9clp4e9ZE/uSNAMJtHQ4LIsBOHGUfjK4T8zHQaCqtmFz2RQLY4rOv7XcDqMm4huOtISqV5BmKCJmBX4L7ePSoHckfSXAi9qELRAwxFoiylH8+sQ6Jv8hYEUIYeM5CT+1SeiAZFA4J8P9PHHJ80O8OQEeg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(23010399003)(1800799024)(376014)(261026140227099003)(261022105027099003)(10067099003)(261026121527099003)(261028144727099003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?439THnu+c79P52hDdV+6+qq+WiIfQ4UcdUQKr80Uq9zsjFdKhqY8gI1Uqqhj?=
 =?us-ascii?Q?qGwWSrmwEUVS8oM1V7S1b5X0wC2476Bvxp7Xg8FoIE4sx5RnSmVA1HGNeLas?=
 =?us-ascii?Q?QdeTvGo3jZiNOopsQE7D6LkYKQdhFrPSc9VfbvhaAb24BR8hg1aM3K2Kl3u+?=
 =?us-ascii?Q?GMGWyJwhDUtjCV0BydRInZIThxwYTTWBqaYW4XEq4mPTrwl6Nhzw33EKG71G?=
 =?us-ascii?Q?cv87WbNiemJm4V1P1N/mTAF/UNwi1pg5DjMGOw33VHybw8B3mXnZOUD6gBKq?=
 =?us-ascii?Q?bwI/TOkAOEDvsd8tsJKgf8uUvtlYFvVsfxy6MDXopjcTgYldAxs8lr4C3D6i?=
 =?us-ascii?Q?il5hAYRQolrPOgxR1i27jwqWs6fZ4hzF+uqzF15P6w9ynb79lEiOqJ/I7D2m?=
 =?us-ascii?Q?jxBjgZ9ilEZ7LmAQE0YaI7JSC9cyfzuOpa8FMo2+T3bIQthOM/j7guIcFGz/?=
 =?us-ascii?Q?UEa1k85EURe9EJsEbiQbsALa5vjoinHDz0Z904RJ1Wpwt9EWYs8fQ/VMwdiy?=
 =?us-ascii?Q?xnc6/d5o1Prn3idkEzzTMDfIufeEILgUfGT+K9gKLDsmMBt4dlggu2CvbYq+?=
 =?us-ascii?Q?UGqB80nSlas7Dkv/RAzDqbqaMds6GGvdgLRk8/0uaqfZ4Bc4byZ8DT8wxU+H?=
 =?us-ascii?Q?9YQB/jBRVRZbKD6V6wxT7kBLiZB0oDoClp+CmJ7AWiVlNhpnmCRFKV9vIIMz?=
 =?us-ascii?Q?lk4+SYmkRA4GUF9E6vazT9rt8xugQoJ3QRpTRAPec84JqNOlikFAiNZHDDit?=
 =?us-ascii?Q?5QHBC9rwT95Y2pklcQKjLaVDWL03pBEIuGbPzPfjhmaMpl7Avikgp8sMFfob?=
 =?us-ascii?Q?UITRlx8hrOsva9cogqiST9zb7fDxDheHZfIn8mlVXa/yV196errERLT31w8z?=
 =?us-ascii?Q?cWmZKXFs9SjN8sDuRB3wMR8i+5kAVADibQT564oLzH3A7pRxzWLei+UNCEiw?=
 =?us-ascii?Q?DO3TeYnCBBhD+BW0nSCcbcCZvFvEBlQ1DulgrqeD2HsQbucvXIYgf/VvD+z1?=
 =?us-ascii?Q?O5Oekhsin2uO55SNR7rsxuv+T4O1hwUVDD776mQCJPM0l6y0rghBho/2ZJSD?=
 =?us-ascii?Q?WcVCxNgaCekth21r2DpgwddyVLcMEfIPpZSWyXcE7irX8+Xo024FiLIXQzDw?=
 =?us-ascii?Q?w6q+menKXcl2CsZdR0lvxV20Wm/JRe4irMkT+hnThIUJMEL9JBi207AGELNN?=
 =?us-ascii?Q?STQHnWqRjwG7WWMEyzEcYhG2Ptu9OfgVjfzNAZr0Crmlsb9oXfsQFbddMTBe?=
 =?us-ascii?Q?iIm+p55YShPx6HboQ1HSO/WPgV8NQ4wnCIFo2FVB4lihYptSizgj+1GzgAkk?=
 =?us-ascii?Q?AQYTLXEJNodAatG1Fo3dkgN/A8Pbp4T7+qQFmLUKeN0dapxoGdTVLNH63v0D?=
 =?us-ascii?Q?2ltHIf1LAAvvBqQXKNFhblDy5mXb/jvSttI5hkLWcviZT++TL4Lx/EpnnN1y?=
 =?us-ascii?Q?5mb+X3WYDHnyQMSu4HtCkfnfqZOaD1N9CeXEPIW+Yk1G0NDFrpunLJeVY1q8?=
 =?us-ascii?Q?mAiZFvKPM9IsIlVE6/i4kptPGNbuXrPXYaXfrVyhfknx6HSEk304kBtBOHi3?=
 =?us-ascii?Q?c6cYOJiZ8f9YCTDlJH17Z5z3WQbKSoTx8iQ07awiRgkddogbVaGWWgZaJnVx?=
 =?us-ascii?Q?feNLKfkHFh5oc7Yh2MLWQ78EJ+yrJTuxLZkOVvKngVDuvYb7qZzgtSIikSVi?=
 =?us-ascii?Q?eKuorXurr920eFatV4d2y/9bB1cUF4mYZP0CoZPVxQmRHN1e/hRNolKinb/m?=
 =?us-ascii?Q?6GVB9KMVWUxFtIvXblcsERTkCekvJm+8wOPhcq2EZj+1GviQJWQp?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ff4cf7-4da9-4be3-417f-08df4b62e962
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 02:13:50.6181 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zoGTHxULRBpavSKEuOvOhL2//lmwChSGDad4ellnKghGkiWyk/oVbF7SNOyqHEeqp0ZUk1eMfSguXRcegCzG7m04NCUBfGzqEfQgZ7TKzFeRPBMymHo4HBcsVqvRPDEn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB12312
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,T_SPF_PERMERROR,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 25 Nov 2026 13:42:56 +0100 Josef Schlehofer <pepe.schlehofer@gmail.com> wrote:

> With CONFIG_SYS_64BIT_LBA, GCC turns the lbaint_t division in
> mmc_berase() into a call to __udivdi3() on 32-bit PowerPC, which
> U-Boot's private libgcc does not provide.
> 
> Use div_u64(), as the remainders above already use div_u64_rem().
> 
> Suggested-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
