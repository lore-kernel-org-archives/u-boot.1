Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1FCBF33A68
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 14:07:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12E808382A;
	Thu,  5 Mar 2026 15:07:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="c41/NtBL";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="tRO1DxJ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECB8E83F2E; Thu,  5 Mar 2026 15:06:59 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC59481E18
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 15:06:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: 8ffa858e189c11f1a02d4725871ece0b-20260305
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=vTy1Fb99glljBtE2EwEJHeZgjQJ6uMHdfJ/ZSzg6KUs=; 
 b=c41/NtBLYDLfietl5xYo1Ji0zl4EOY4CxYhUkK9lnuRcSgfcVvtLTz7ENDUyTaFd3Utu9Y2JhVWnc+dq9j2hwrqWIeWVlgr+1ywef0rUVD09eityVL3eHX1QDJHyp+eGgsE1XENHpuQXyOxguAsIqQQrvmnnU+EKLrABYRonBxY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:06281b98-8ff0-4333-97da-940fc276e50c, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:89c9d04, CLOUDID:2b698f7b-8c8a-4fc4-88c0-3556e7711556,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
 C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8ffa858e189c11f1a02d4725871ece0b-20260305
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw01.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1630811305; Thu, 05 Mar 2026 22:06:53 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 5 Mar 2026 22:06:52 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 5 Mar 2026 22:06:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GNzkiDD+CBtu/JbcTbtIalVvfg7g92I+hDuXfi/LX9g8lB3dkdyw5fJ5iNEQiIduRz110uEt3j98GcMuAGQrvgwXiWSvaxh7faYaJ1rLDMwEkEZNyN+IjCN5p/MKISJa+c04rsWyfHaftn5ur5QkblvRvMmwSeQdNq7Y3OSMLIu6f+Kvz+f+wQa1sXaZltbWbAdXsK3eVTG+6h7mwfYGkmotDelBYDlJkqhEq97SQKpUmEZ1sOQyuBYLoCno2SNEjh1WkLraMxhVgAwnp9VjMAbkmUG43OvaNzaE3lMZ6c6JQeVZFlnmEiak0J9/3xulkgEf2sya3OZ7lEJ9Tf2d3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vTy1Fb99glljBtE2EwEJHeZgjQJ6uMHdfJ/ZSzg6KUs=;
 b=qfAe5+FIxJezTdkGcET3SqcAVgQPl0W6uvy8WH8PMccnRloRL2bWdVpgO27SULLrHqnbcRPesiaXllrP1HcRWsfX/sbFQWjbbflg3HcZRchIhxfRGONtjOsJWQoU71Mixmdx3Svz2lH37RgFUAfLnMEQPIx4nTrj91G9oqnmqOX3ab+qpUBsfkzn0j8APSpkoxEnqjvmnPfh7XfZV0q5M6T39WGsMCxTJB4kjq1SDWTx17E4+qhHR3CzMGGpp8oXJHrvhRLKOzgyitnVFKfkDDU3OypTCOVcpc/kLmGH18AKzK7v2Sdq6zTE/xMJnwia+y7VIPVgdCyKKJ4DZPgdFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTy1Fb99glljBtE2EwEJHeZgjQJ6uMHdfJ/ZSzg6KUs=;
 b=tRO1DxJ2GnmZvZk72q4beLSVhelQrk/YeGOwD0QbThCbFFvJmu2/fTtI8QbtaW1wAPwu0l8XExi9b+Z95dRpc6caJEtDfUNwY/2aLNh1gEFrYj8XM0mxNCZS5Bco4fez64WylR/5A6BjWr7pgqVxabceP5XK3/QV2G/0hXrb1jQ=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by TYQPR03MB9429.apcprd03.prod.outlook.com (2603:1096:405:2f8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 14:06:48 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 14:06:48 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: David Lechner <dlechner@baylibre.com>,
 =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
 =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "lukma@denx.de" <lukma@denx.de>, "trini@konsulko.com" <trini@konsulko.com>,
 "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>, Ryder Lee <Ryder.Lee@mediatek.com>, 
 =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>,
 =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 =?utf-8?B?Q2hyaXMtcWogQ2hlbiAo6Zmz5aWH6YCyKQ==?= <Chris-qj.Chen@mediatek.com>
CC: Julien Stephan <jstephan@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: [PATCH v4 1/7] clk: mediatek: use correct struct type for
 infrasys clocks
Thread-Topic: [PATCH v4 1/7] clk: mediatek: use correct struct type for
 infrasys clocks
Thread-Index: AQHcq0ffziCGr1qCSkKf5xDl5i1oPbWf/AuA
Date: Thu, 5 Mar 2026 14:06:48 +0000
Message-ID: <a5a94e199784b3b8461f703aae7aa422b677a239.camel@mediatek.com>
References: <20260303-mtk-mt8189-clocks-v4-0-ee85f8dd2f0d@baylibre.com>
 <20260303-mtk-mt8189-clocks-v4-1-ee85f8dd2f0d@baylibre.com>
In-Reply-To: <20260303-mtk-mt8189-clocks-v4-1-ee85f8dd2f0d@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|TYQPR03MB9429:EE_
x-ms-office365-filtering-correlation-id: 08acf8a7-bfba-4d96-0fa6-08de7ac07113
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: OBQd7w7IOJAKo1+omkqEvsIDXNUaJtWqeZtyle/bKF69yjhYu3y5tMLUWLprIqdfGd7X6lFkEl4IDiOr5rLFQlqfoK4diQl3sw9ExT19Rbmri6NNR7CZ9XpekvUScHtMwtUdWX95oFkL4Gut+3mu02FiOfWIsRcGmBCJplT1yqFRC5GDO4nNhQEI9q7c9eG7MT1xq/sPkEX6EBBF2OjXD31hZ3gWTxEj7usA2huR3rk9FpidQBPpTNR//bx6SwYEg1Y/PYQzmek2teHT4AkEL08KKlnDC84HaAO9Tp1WQ0K9W9b6sju5ftfvG5+oolWdB7kiV9C8vpFIZho4BtF3IWiErKJwfCT0qWa9+cIkk2Cqos3897taj67TDdpgorEHx+S1XaNOe4C5AeOqia1knLe4gDNUrvNzNBbIx7PrOZKyfmryyzpevF72sPBKLPyKINMdVF8X0OS5ez4rFB5zKBBcLQodMAS8GJeo9Yk2nx6ReCfM7apu+JbP3W326lChbL9JwveHvvOZW/2I/UT4QGFXi1SOeOA6sDg7qIOVfPf5Mot1wTU2xQ0OM89XZC+2thcAULUlQFwvj89BeF47McWTmOjTuSNw8kra8wC9JnoDPs7Ma/KNkXwsDBB66l+TY/XCARIeiFJSXGbfya5MuTbp6J68ucAAYDorjapzxoyPbsDMfsImyNESaLJvwst9sl1GIztBSekULJDlT53MrXeECU4PAYuEnrxr2+1BZ8zUjKnSzfg9JCdE1kn7ANsynGmhBVt1oyHLXDjH1uO6lD3C/uH8yuYdtf0vjqfzDLTwgszWKisOMU3nnkg0AGaO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(921020); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUh1TUY0RktEbnE0LzNkR21pSkU2OHRYdkdydk02eW01Sld3cE80eDRhUXFo?=
 =?utf-8?B?Umw0b3VkOTFIM0FEWFRFZXJPV3EwVTVKWk93NW9mL09pWTgzNE1VeExhUHhq?=
 =?utf-8?B?M2pOQlpWL3dNczVmdTZWbWtXenF4bFY4MXJkZHVCcThrYjZjbDhEeDFubmdF?=
 =?utf-8?B?ZjI4VDlxZEd0bVJPTXR4S1gyR2I3bG4rcXl4VW1ENll6TmRucElVTFNwU0Fk?=
 =?utf-8?B?TkNsRW5GbzlVcVBkUVc2RjBKSmtXdkMwUTU4SVhtVVZiSG1hTHB4RlFnWEsw?=
 =?utf-8?B?OVMraWJ1WlZ6d053TmVDVktKK1VRcVhJMGt2dXFkZ2c5Mm01NERsOTZPZUFJ?=
 =?utf-8?B?Q2tETjJwVU1BYjB5MmhwekRyZm9ad1JRekptd0dibFhEWGplRGpVMHdhUXJE?=
 =?utf-8?B?N1pGc3lMdm52S3djMnZuUEVidEdIR3NLZVpLcHlSZXNKZkNOV2VuQnBrYlBO?=
 =?utf-8?B?N3lCT1NEc2VTRnhqUGZUVDdCYllzSWl2NmJKTWtiYlRBQzZsOHFDRUlNMktl?=
 =?utf-8?B?MVZhR1dSU0hTaHN2NjRDaEY5ejBuWUw3Q0VWYWhQUHhiWTBkckwwcnVPMzFi?=
 =?utf-8?B?LzArKzZ5S3RnaklMRTF1L0lqMjZLOHltV21JdUtKbEU0NE50MWs2b1IzNmR0?=
 =?utf-8?B?ZnJQWG5BMUV0bnFKa1I2VHppV3ovcmZLaCtVRjk3ci9Kc1BTMURJLzlGU2RH?=
 =?utf-8?B?TjFvWTZRK28yMTU4amhPMzNzemNKcWs3Wm1OUnNTY1JTaEFyamFTK05yc1Bh?=
 =?utf-8?B?WmtnaWVpMWxueWE1bzNXV2RhSFF4RjFWN2tNZXFWVG91dEcwa0NEb2tlOHIr?=
 =?utf-8?B?TW9UUTNJTjhtcWQ2YURxaGZCOFBGYlRwL1cwODVuZ1pDaUgybEY3dnAyUFZh?=
 =?utf-8?B?SXV3S3pTYUxQZk1YSURESE43a3p5cThjRWtiNEhldFRybjBjQTB2RTh5QTI4?=
 =?utf-8?B?MXRMNE9XMFFXQmZpU0FXSGs5NWJKalFEeVdSQnYraGsyMDZYMUFUdGJZUFlr?=
 =?utf-8?B?U245RFNwMnNxaGhPWmRzUXZsdGZwL3ZMUlVKQmJBOU8vMkU1dGRZSDMxcXla?=
 =?utf-8?B?ZVE3RXhqN0RjZGVJWERiV2NicWYvZXlLNEw5cjM5S1hiRGxGK0FFcHZzQ3lU?=
 =?utf-8?B?Vm9uOVprNTlwUVJBMXowcTZTb05Qc3pFd2U0Y2l3QXIxK0laaE9MSi9sdEJE?=
 =?utf-8?B?SnVkbnNhMHVPaEZOMTd5Vkt1amJXSWNmN3pocGZIbGFDeTRiaDQ1MU5wNGNY?=
 =?utf-8?B?NHNQb1lHVkVrcEZadmx0ODJyWUJMQXN3Vzg4V0hwQnRjeU0rMGdxQUp2R0Rt?=
 =?utf-8?B?T3R4SmhuenhXeTFkZ29DNEMxdnpCOVRveVFYNzhrZFNvNUNHOXhBOUZHS1Fs?=
 =?utf-8?B?bzQ3SGVwZldkcU1XTURrNTRpVlVpZFJIbDk0Vk9nUGhpWi9Bc08zanROcWE4?=
 =?utf-8?B?U2RmTFFnaDVjU1lYdjFMeUlPWWVzbFArNjZ1aG9EOGhpZVIwamdvc2VueUhZ?=
 =?utf-8?B?Mi9Lc001WTJLMHFrNTQ4ZmY2MmtjUk0zRk10MC9jQ0N1bnc5Q1dLU1pVTlVQ?=
 =?utf-8?B?UzV4ZlhuMVFsWVhPRHppYXRuNHBnNjJ4eGVoWEh4YWlEVHNvNDVSRkcxUndm?=
 =?utf-8?B?ckJXZEU4bjl2RlVwV25lRGhENStLY1FUSDhyR1luSklOQlBCMXFPaWVsNnIz?=
 =?utf-8?B?ZnR5NmFENXI0OHRFUmM3NllnM0hkL2pqeUszVXI1U1hGRVkxOEU1SVd1ZzZs?=
 =?utf-8?B?RW54YmpsUTBHMkFrbFJxWVlHTkFlS1cvZkFjTkJhV3laamJWRDZDdlUwdU9j?=
 =?utf-8?B?Tm56cGtGc0ZDTkZPRW1BNHJLWUxFUkMxQ1liVVd5U2tWOUZtY2hiU3orL2pV?=
 =?utf-8?B?NzB4ck0rYmhRdk5pMkVJYXJYcW51NWZwQlhTa1JRS2VUMzBKZFQrK1dJZjJX?=
 =?utf-8?B?Yk15TlBUZUxsLzVLWXVkR3UzZGJkd2xESW94OHFOampZUXN2U2JvMFhaYjlS?=
 =?utf-8?B?bWIrZWdGUWx0QWpqM1hhdU5vejM5NzRYV2pORyt0SWF5QmdGRkNCck9yN2Jt?=
 =?utf-8?B?aElJRTlYNFJTc2hPYmNTbkg0anl4c09ZdFBvMVBzWlRCNjZ4WXhBb3cvOE1m?=
 =?utf-8?B?UHU1SUs2NldpSEVGU2IvZTJJSWpaeTJ4aUprb2toVzk1ZEMzU2ZXTDdLeEpx?=
 =?utf-8?B?NERWa3l6WDRXczZWTHM4TFFTbEU1L0RnVkdaQVZzcWtUMnV3WU1wK1VaTi9Y?=
 =?utf-8?B?ZVUyaHR1WjB6UTFiSmVRekxuY1paUGVIRDd6U0ppZGsyWVI2UkY1ME1qTGpt?=
 =?utf-8?B?UkpvMHZDQzlMSjhLaERkUXYrQUdnaGZRVmsxZWtaMFZqeVNSWUgrNGZPSm1x?=
 =?utf-8?Q?lIzuEebWr9Sp73c8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AFA40283F6DCFA4CAF5C6A30CA025E0E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AmsLkGVHVlJDp9bjgS2j/DPBYgZEsTkpQ2vLL25Qk7h0Ypb0rQHBkOiH1TD5KJYQGM0O2ZYyhd9+ktb8cGHKWJ5fbOQ2jPmJ/DA8lKd7oiVikhevot+k1VjSizCFaoBfPH3KrEN5RyfRiL/EcKq4iXQoRgcNolWAwGuhs1v/VA1xwn7moxqCnQ+hL4jDR49im/Uqf9mn7d6CAWFwie5PVeVlh0Wye5lWklWO7bsf/M+b4uFb25KNyX9ttoUvGKqW6DqR1x8+R3gJq0xyX83C7EUeCp19H3U5MzYx5+lSlDiMatJfW8ZqkY1L1XSrOLaVQmCJsjTqDXw4izk1JNUqTA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08acf8a7-bfba-4d96-0fa6-08de7ac07113
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2026 14:06:48.1521 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0jsRw6kKK5qXOFGvmxRz1zNAzUlSmrxJAGanEqx8NbWyYSrDlouhS7a5M7xXAt+qgKPhmTIBHs2bB7t77P+c3rQlEGT6blI50R+i9O5nnwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYQPR03MB9429
X-MTK: N
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

T24gVHVlLCAyMDI2LTAzLTAzIGF0IDEzOjU0IC0wNjAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOg0K
PiBGaXggdGhlIHByaXZhdGUgZGF0YSB0eXBlIHN0cnVjdCB0eXBlIGluIGEgY291cGxlIG9mIGlu
ZnJhc3lzIGNsb2NrDQo+IGZ1bmN0aW9ucy4NCj4gDQo+IHN0cnVjdCBtdGtfY2dfcHJpdiBpcyBh
IHN1cGVyc2V0IG9mIHN0cnVjdCBtdGtfY2xrX3ByaXYgYW5kIGhhcyB0aGUNCj4gc2FtZQ0KPiBs
YXlvdXQgYXQgdGhlIGJlZ2lubmluZyBzbyB0aGVyZSB3YXMgbm8gY29tcGlsZSBlcnJvcnMgb3Ig
cnVudGltZQ0KPiBidWdzLg0KPiBUaGlzIGNvdWxkIG9ubHkgYmUgZm91bmQgYnkgaW5zcGVjdGlu
ZyB0aGUgY29kZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERhdmlkIExlY2huZXIgPGRsZWNobmVy
QGJheWxpYnJlLmNvbT4NCj4gLS0tDQo+IMKgZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ay5j
IHwgNCArKy0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXRrLmMN
Cj4gYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXRrLmMNCj4gaW5kZXggYjRkZTM4NzE5ZTEu
LmIzZjA1YmY1YTIxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXRr
LmMNCj4gKysrIGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ay5jDQo+IEBAIC05MzMsNyAr
OTMzLDcgQEAgc3RhdGljIGNvbnN0IGludCBtdGtfaW5mcmFzeXNfb2ZfeGxhdGUoc3RydWN0IGNs
aw0KPiAqY2xrLA0KPiDCoA0KPiDCoHN0YXRpYyBpbnQgbXRrX2Nsa19pbmZyYXN5c19lbmFibGUo
c3RydWN0IGNsayAqY2xrKQ0KPiDCoHsNCj4gLQlzdHJ1Y3QgbXRrX2NnX3ByaXYgKnByaXYgPSBk
ZXZfZ2V0X3ByaXYoY2xrLT5kZXYpOw0KPiArCXN0cnVjdCBtdGtfY2xrX3ByaXYgKnByaXYgPSBk
ZXZfZ2V0X3ByaXYoY2xrLT5kZXYpOw0KPiDCoAljb25zdCBzdHJ1Y3QgbXRrX2dhdGUgKmdhdGU7
DQo+IMKgDQo+IMKgCS8qIE1VWCBoYW5kbGluZyAqLw0KPiBAQCAtOTQ2LDcgKzk0Niw3IEBAIHN0
YXRpYyBpbnQgbXRrX2Nsa19pbmZyYXN5c19lbmFibGUoc3RydWN0IGNsaw0KPiAqY2xrKQ0KPiDC
oA0KPiDCoHN0YXRpYyBpbnQgbXRrX2Nsa19pbmZyYXN5c19kaXNhYmxlKHN0cnVjdCBjbGsgKmNs
aykNCj4gwqB7DQo+IC0Jc3RydWN0IG10a19jZ19wcml2ICpwcml2ID0gZGV2X2dldF9wcml2KGNs
ay0+ZGV2KTsNCj4gKwlzdHJ1Y3QgbXRrX2Nsa19wcml2ICpwcml2ID0gZGV2X2dldF9wcml2KGNs
ay0+ZGV2KTsNCj4gwqAJY29uc3Qgc3RydWN0IG10a19nYXRlICpnYXRlOw0KPiDCoA0KPiDCoAkv
KiBNVVggaGFuZGxpbmcgKi8NCj4gDQoNClJldmlld2VkLWJ5OiBNYWNwYXVsIExpbiA8bWFjcGF1
bC5saW5AbWVkaWF0ZWsuY29tPg0KDQpUaGFua3MsDQpNYWNwYXVsIExpbg0K
