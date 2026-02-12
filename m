Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77386EB48F3
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 10:29:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E56AC83DCB;
	Thu, 12 Feb 2026 11:29:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="Jdu/qdhP";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="BQPryFpj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D873A83DCB; Thu, 12 Feb 2026 11:29:36 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DB8E83CF2
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 11:29:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: b5ebf26407fd11f185319dbc3099e8fb-20260212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=Om7IH3dIJmdYathr686dX/eWtuDCCJz0289YmExjydI=; 
 b=Jdu/qdhP7JT70lTaNvyV/UXKeW1YLFYo8bfb+ruetap10ebyNeDdfnoqP3ihnCKIoyxKtsg/TowimbyesmXfS8OxXlVRlnrYisee0fuuGD1Tkts5KY3n3hP3MHZDKcbJhsOyvikqa3hWpZpZc1kIK8bSYQZ6QNXPE6KtoVdddNo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:2c77f403-30b8-4683-be40-352e082d4fce, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:89c9d04, CLOUDID:65c39ff0-16bd-4243-b4ca-b08ca08ab1d8,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
 C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b5ebf26407fd11f185319dbc3099e8fb-20260212
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw01.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 853159089; Thu, 12 Feb 2026 18:29:28 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 12 Feb 2026 18:29:27 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 12 Feb 2026 18:29:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E9EB0dvxC4y/lGGjGqIlQjMX6KfhgSSboUr3PJVHdoElo/xHdgJkB3uKVubnb60hZ7Q2gbPsUlSj8HmcssfhZXq2a0y8rzjCkNJdEFbQj/Qg6rFZFoK1nb2KORBrwW1k0F0Apa0TvBeVbXKG1m+F4PcjVmqOaxdftjCUwbD6bL91fdzkVZH6nNT4t3nxN6JFIOF8LSYqHZrucLWRpfMePvOZbfhuLlqrAAVgwUvL6jxqy358TzZ+XXD3QvbOwh5z+zjNrCOAUgRkQYEY1zL+jGpTJNAtZphnPFIOezsNwy/FzO4WeDMMhn8umMepKHArwoKBPjW0f1VjYaqDkbGrcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Om7IH3dIJmdYathr686dX/eWtuDCCJz0289YmExjydI=;
 b=P8LUgyTR5E+FeBTJkwmfr4fCBcnUHrEd3ki4G6dUjCyHc6se8k+sPNqSmD43H9dYblJTZEBQH957RNAxam4fC365JBO0Yp8N0G5Jax6NhOzq98WtcTGdQkjsFfAddDWXmACfgA+URd1JtLdqWVuvJLBz1amX1yqiSY67kjdwao64cF5dZo5o2+1Lzx6AtZZ+L2sEJJKZ/CA31ODd21wDdB0PuY5+ujlLXA6WX3BIS3Z7xaW75QfbwjJW6huXN1z1DfDjBrDAA6alArd78DyXp+b+gUYi+eu9MHRNPSDfEhGEyCBzIRp7ADPNdCPUPvac47QpjnXZ34STFJKM/5QfgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Om7IH3dIJmdYathr686dX/eWtuDCCJz0289YmExjydI=;
 b=BQPryFpjMqo0MoF3E0brCyZ58q2Al4jxKQn2IvXasfqwGSRF0vtPoC6j/wChNGREJibNmAdBdIzgVeiqt7XPVnm/sQZLqmUs0w1SHLG1aso3JiSt1Kf8Qfrm/r2PFtDlNKg3vDZDUcsc/0Q1kgU6qcRVjB/JEcUFIf98d4KZsbY=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by KUZPR03MB9357.apcprd03.prod.outlook.com (2603:1096:d10:2c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 10:29:23 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 10:29:23 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: David Lechner <dlechner@baylibre.com>,
 =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
 =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "trini@konsulko.com" <trini@konsulko.com>, Ryder Lee
 <Ryder.Lee@mediatek.com>, "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>,
 =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>,
 =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
CC: Julien Stephan <jstephan@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?=
 <Rex-BC.Chen@mediatek.com>
Subject: Re: [PATCH 3/3] pinctrl: mediatek: add support for mt8189
Thread-Topic: [PATCH 3/3] pinctrl: mediatek: add support for mt8189
Thread-Index: AQHcmh4ZULzGsynsd02rgstKHKXoALV+4KsA
Date: Thu, 12 Feb 2026 10:29:23 +0000
Message-ID: <a85b8a7603d91f26d23fb42a18e47bfe99db2841.camel@mediatek.com>
References: <20260209-mtk-pinctl-mt8189-v1-0-a7a3069eda6c@baylibre.com>
 <20260209-mtk-pinctl-mt8189-v1-3-a7a3069eda6c@baylibre.com>
In-Reply-To: <20260209-mtk-pinctl-mt8189-v1-3-a7a3069eda6c@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|KUZPR03MB9357:EE_
x-ms-office365-filtering-correlation-id: a4aa3abd-31b2-4ca4-b035-08de6a219706
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?TmkzSVFRcGJRTmU1NTFWOGFudDRDWW1wMmV6dm5BVmtCQnI2WjJzUXJ3UHRs?=
 =?utf-8?B?S3J5MTcvc1Q4WFI1N1NhMXdPRmhZNHpFRmtla2puc0E1bU9lenJpUGZpSUx5?=
 =?utf-8?B?dG92L3p3K0luVTh1R1kwQ0hJdS9yNnl6RWw2eWhJbjBSNXdwbWhQZ0FqYTlw?=
 =?utf-8?B?L0t3TmgrWWhxbmNWWVZwblZSU0dqNkxpeVNTN0dQZWhYbmc3dFpjNjlaZStx?=
 =?utf-8?B?SktMUHlxbk5SY0IwTmVSNy9EZGNqSXRNYXNCK1pjbm12S1ZOYmNkSjkzK3Bw?=
 =?utf-8?B?elVkN1ZRekdRS0VOWnIyNVhYODlJT0JZUDRuRHJEOWNibHNyYTlxc3JvTWwr?=
 =?utf-8?B?RmIvK2drQmo2TGU1Z1hBMlFvNUMvRkFmbmQwZHJRNnRaMXFoVXEzRVNXNnFr?=
 =?utf-8?B?YjV5cGM1TUdaa1dNZFBMV1JWVzdpQ29aVVFuc1hZS1FnUFNObWNnTjNaeFVr?=
 =?utf-8?B?V2hucTI0R2NpZFpuNm4rbklscVlFVWMrRUQ3d1A1cjdDTDBFdk94SitsUnFv?=
 =?utf-8?B?SzkzQU9kT2dvT0FLODEreGc3WCtQd1NKVyt1aWF0WFZXdm5kSUNlTDB4MlVC?=
 =?utf-8?B?U0RYWnNxVG5ORlN1dlVVaVlxMXd6dkdUd1ZYekNXTnVPb2k1byt4QVdzbWNV?=
 =?utf-8?B?azV3WWkreFVUWDh0L2w3RUpqL0E3Rm1LUlN4aGhEVWswY1ZuaWVKbGV3Sk01?=
 =?utf-8?B?RHphOTFFclZHNlRJUkdrS1FiSkdsT1RMQSttNThzenl1OGJnUmc0N1ZPdThx?=
 =?utf-8?B?REFjT1FlYWprZ0tET2ZjRnNJTWVsMHhtVkFaQUVRVTRnZ1ZFa05ZUmN1eFBh?=
 =?utf-8?B?bmZSeHd4L1Jab1ErVzErbis0czBoNllNR2htbllqd3pGM0tiSFEvRUpobVZ6?=
 =?utf-8?B?NlIyUzY0Zkg3bEZkMlQyckszUjUxVUFwaHVKSll4c2ZUOEJmU01lTTc3SXpj?=
 =?utf-8?B?SUM1TjZJRGJSS29nOCthZENobzdWNzcxMXJGNE5qM1ZaakRuU1pnT2YyVFQw?=
 =?utf-8?B?d21lRzRPQlIyTHlNd0tLbjh0ck1OYnd4c0VZdGFxN0ZEL3d6Yk1jbnViN0dl?=
 =?utf-8?B?dk02T3JtcEhPcERFa2lxKy9pbUVGc1duVnE2UlZNNzVTTzhNMzhYYkNISDNn?=
 =?utf-8?B?UlhrUWhmZVg0RjVNTC8rVFBOcytIdmtON1R4VUVld3hISkhDb3pXSjNCdTQ5?=
 =?utf-8?B?amFiZDJUbXhRSCtrMnU4T3lIYVJ6SzlKSXpjaVNRcmpVRFYzdVAwU2NxQStC?=
 =?utf-8?B?Q2RrcVJLQjNJN2d4RVhxNFlJV3A5TnQ0VjBLb0RtR1pkM0lDRi9uOW82V205?=
 =?utf-8?B?UTc0alV1aXhoK05vdmdZbW9KcUVUVG01cUFKNEN0VGZhWlF0SXdTOHR0dU13?=
 =?utf-8?B?a1pGZjhCRjJwb09CWnJtcVBjVE9lWm93ekNBM1JrUUp6Ni85aFJ5M2ZibDRZ?=
 =?utf-8?B?Smxjckkyc2NiL1ZjSEZtZzVkN1dXWVJLcHNRcFNGT3BmSVpGSWZRWnlKOVE0?=
 =?utf-8?B?Y1RiUG9xcWRhL3hlWmVNZXNlMXJFUU1lSzB6emxGQkNQUmRXcjZMVUlOL0Y2?=
 =?utf-8?B?dXBkOVBVWis4SHE1bU9YRStpVzdlWVVwbEVJaEk3Ny9mdzZFd1JQU2loWHQy?=
 =?utf-8?B?YUtaN0dhZWw3ZlVRZTd0V29YRU5xWWVtcWJjR1pVbDlCQ0lOK2ZQWFRFMHZE?=
 =?utf-8?B?N09lcXR5cFJDS2Y5b1Qya1JKNjdJeWU1QU1iNWlSVE82UzZMT3c2ZWE4cEw2?=
 =?utf-8?B?MkZId0kxeEdESkRrbVZCS2tRL0QvbVRHMGpIZUJXaHkrVWtLVlVZK2NtRDdY?=
 =?utf-8?B?QlZwRlVkOXBHVXV4MUliNWgwVUpCRFpCV2FyUkFxZ2pzZVVBVlVvQnJEYkRq?=
 =?utf-8?B?K25KUkljdk9NTTNRc0IrR3JwcE95U3VudkNmYVc3WmFFOWh5MnpJTlIvUWZq?=
 =?utf-8?B?V0k5OFhqdzhpYkpkN3Z5SmN6V3FLSVZvM0ZZZlVDcGlKZGNscnNFak9QallQ?=
 =?utf-8?B?ZWVoNGJBRlNpM0FBaUVmdGtlbGlnMTBINTVqYXp5bUx2aSt5R0dNWVZSMlhL?=
 =?utf-8?B?TEhvVWRKdEJFMUdiQld2WDdjMlZqYkM4TjIzQ3NxelE3K3VoSDkrWWtlRVI5?=
 =?utf-8?B?eVZKY29ROVBkalp2eUp6VVNlWnNxOXlSd1FjbWRWTW1Rb3RZdi93V2Vuek5l?=
 =?utf-8?Q?/+VzM7nYa6CyOG1erdwWvxg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wk1jYU1pUUVQeUZEeDJQNTd6T0VXNEZreDlHMXljVnk0a0o4bTBEN1dPcmI3?=
 =?utf-8?B?cmpOdU8rL0s1N1ZKOUlwWkxPdWxZd3c3akFWV2gyVFJVQXZoNkIvSytmTVZo?=
 =?utf-8?B?RENpaTg4V1lEUGd1NzlGcmNNTzRTVmN6TERGMTlyOTNkbzIwNm52N0tRQ0Zr?=
 =?utf-8?B?Q2xZTlVPeXRTb21wVTZ2OGtZN1liQ1lpOEFJL2VSU0RsNjB4SjV1MnA5MkdE?=
 =?utf-8?B?dGw2Q0J0V0Z2c3hxanpJaE4wZTRIWTJPOFA3ZytUaXg2T3lBRklGMjJqK2U0?=
 =?utf-8?B?cUo4blBpa0hxMHo5STFGK3VwRmtVL2pVblZQUXdDemVNTE93UFhZQ3lBeFF3?=
 =?utf-8?B?di9jM0tMTlJUL1R3dGhqcSszcWJHZU42cHc2R1QrRUVOY0p3bFg5RE13YW9r?=
 =?utf-8?B?bi9jRUdjYmtVTUY2b1gvb3FXdWRncGJNOW5SSDFHeW9wS1NRT0JPNUJFUGVa?=
 =?utf-8?B?WFJwZzFMbFFtamdpc3l4UzhEeGI0U0RwOUF1b2hod00xWmZPMjlmVXBDalhy?=
 =?utf-8?B?clBuVENPbEZiR1p4UEQ2SzZoNGFTWVo5ZzlvMnh6dW16YnJBNy9sNlJ4b0Fi?=
 =?utf-8?B?cGNMSUIxbXF3c2FrdHJlckNyTmdMU2ZYQmlFME5ML0tTcVF4cHNXR3pXR1RM?=
 =?utf-8?B?dG9IVWFRTEcvaUUyUDgzWnFLNkhYMkppNG1SSGRTOUFCZ1YwUjBjRXF0dGdy?=
 =?utf-8?B?SFR3Nm9aeWQ4RUZMcnB1WE5hNWV6aXcxTEowTzY4QWxycEwyZSt4MG9UREls?=
 =?utf-8?B?WUVPZVY4ZU1URlg3RHFFdDh2SjU4YjAxWVVsT1pIVnZsTk9oMGRHS1lkdHh6?=
 =?utf-8?B?b05NQmpxMXJ4N0JKWEY2bDFXYmZ2VWd2Ulp3UnJ1Y0EvWG9MZlhpUWpJVDZv?=
 =?utf-8?B?M3lyQUtqQXZYTURTUFhUaXBSMGpxNldQVGFDMW13eGZIbVdueldrUVdDTU83?=
 =?utf-8?B?QWl2ZjNNdCs4UWVraVFPYnpGYWk3RXN4aGo3ZldDL2hjU0lQOXpqRGp0ekdm?=
 =?utf-8?B?SVdNbG9tMUQ4VFR2UWhWVTRQMC9YT3NnNjFSMWhaNVpwQXhHN1c3NmNJa2sy?=
 =?utf-8?B?bFF5cDdmL2tUWnRGU3c2Q0VUeTlPc0dqL2NPOWJYR3djTXpIK3VEOWhXY2hT?=
 =?utf-8?B?TXFvOUZBOWl0d1VFMnY0MU5UMWltdVFiOFMxcUlvcjVWblhYUTFRNHpIK2xF?=
 =?utf-8?B?Q2c4eGdVYlYwVW1kRFBlbWVsUVArOFA3cU1DdENiZzZ3cmFQQ3F4TWs1blVZ?=
 =?utf-8?B?Sk9rdHZiL3N2Y2lETUcrNG5TSTQrU1I4V0xKSWVLRFVNV2QzV1dpb3c1WWtC?=
 =?utf-8?B?Y3h2YlJSaDN6TXlpOVRueGF2K2tsRHRZRUFIckpXZitvUDJublNUR010Y21l?=
 =?utf-8?B?V2ljNzdnTk9EVG9xYkFpalZrMHk2ajNDMGVTZnE0dU5IWUVwVFJsYnoyZFNF?=
 =?utf-8?B?YlZSaytIVE1JOFM4a3pXN3lhY2ExZTdMMUxPQlpIUmt5RU56cnI0N0JmQmFF?=
 =?utf-8?B?d0J2bWdvY2xsWUNtcGtiaWNrcWN2VkQ0YmJTRS9MZ0MwZVZ0bytXTnV2dytT?=
 =?utf-8?B?TENvM3hFK0g0azgxMVZRbDg5QllkQ2EvRUtqbndESzNYaHkyRWlMSS9lWURP?=
 =?utf-8?B?OVpKMHF0dnI4aDM3Y3ErSm4zL0lNV3pVbTM2SUN1VkpYbStEdTZ3SzNRZmJp?=
 =?utf-8?B?bjNEWnVYMk1TZzc1dng0RXJuNGZ5U2lKN2ZsNWhCamJjb3EyWGdnNHh3WWZ2?=
 =?utf-8?B?OXhWWndEbmpJcVNWQlk4R3FuQnNNTDNUUFVMVTNneCthNVZnRWdBeUxTeGVE?=
 =?utf-8?B?NGVaQnhYTDBSTWJkMjJmZmgzZEx3VDdlQlRuN2o4RVhodXJjdVFRODVZSGJ3?=
 =?utf-8?B?TThjRVI3ZjI0ZmhZL3paZzF0aWVUN3RCTUM0ODZucXdSbXZGQ2pFdGJVbU4r?=
 =?utf-8?B?UHZCS3Z0SUxEUXdBWnVqYy9rSlVWaFV6NG9DK1VXSlhlWUNtcnZ0MHVvWlFr?=
 =?utf-8?B?Rnk4elNUa3FVYTNzdlRWemRMQng3MGRicWkvUGJCS2tXUWRFWXd0c0pIZGFN?=
 =?utf-8?B?cEMrQ2pSeFI3ejEyZDY2eEtrWVpXdFVOck53RGIrMW41cGlmcG85bzhqSGd4?=
 =?utf-8?B?ZXRiNGZ0Wll4OXV1WE5TKy9RNExwRkVhR2hxbncyR2tUVU1ET0tqbkhGVUJV?=
 =?utf-8?B?V1FUbG9MY1U1Yk12RmQ4V010UCtjZWVSY3JnbUZraXFGc0RyTEZkRDdKR0xM?=
 =?utf-8?B?NTBodHp2aUw0R2pWNVFMd2RYTzFlUHFqN2hhdWozc08wVWYyZnA4K0dhQmYw?=
 =?utf-8?B?bDdyamZsemhYa0VKUUI2SmdTd0xQdUQ0bjhIL3p3TzhLbE5oZ01HYWlpT3dj?=
 =?utf-8?Q?xnOPbdSJ97qwP5kQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E661F5B29159746894217DF9CA8B156@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4aa3abd-31b2-4ca4-b035-08de6a219706
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 10:29:23.3221 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AGbqNTDILTDgetMH4llvchQ4tuefdmcO19cHH79A1IAss4V53OYTM1OZR8aJ/+HGCMkIaD7AYn3oRrLfCSkVMLOd8ff1mPkKauma5cmiiHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR03MB9357
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

T24gTW9uLCAyMDI2LTAyLTA5IGF0IDE3OjM0IC0wNjAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOg0K
PiBGcm9tOiBCby1DaGVuIENoZW4gPHJleC1iYy5jaGVuQG1lZGlhdGVrLmNvbT4NCj4gDQo+IEFk
ZCBwaW5jdHJsIHN1cHBvcnQgZm9yIG10ODE4OS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJvLUNo
ZW4gQ2hlbiA8cmV4LWJjLmNoZW5AbWVkaWF0ZWsuY29tPg0KPiBDby1kZXZlbG9wZWQtYnk6IERh
dmlkIExlY2huZXIgPGRsZWNobmVyQGJheWxpYnJlLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogRGF2
aWQgTGVjaG5lciA8ZGxlY2huZXJAYmF5bGlicmUuY29tPg0KPiAtLS0NCj4gwqBkcml2ZXJzL3Bp
bmN0cmwvbWVkaWF0ZWsvS2NvbmZpZ8KgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoMKgIDQgKw0KPiDC
oGRyaXZlcnMvcGluY3RybC9tZWRpYXRlay9NYWtlZmlsZcKgwqDCoMKgwqDCoMKgwqAgfMKgwqDC
oCAxICsNCj4gwqBkcml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvcGluY3RybC1tdDgxODkuYyB8IDEy
NzYNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gwqAzIGZpbGVzIGNoYW5nZWQs
IDEyODEgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGluY3RybC9t
ZWRpYXRlay9LY29uZmlnDQo+IGIvZHJpdmVycy9waW5jdHJsL21lZGlhdGVrL0tjb25maWcNCj4g
aW5kZXggOGE1ODhkMTdjNGIuLmNhNjk4MGM3YTc3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3Bp
bmN0cmwvbWVkaWF0ZWsvS2NvbmZpZw0KPiArKysgYi9kcml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsv
S2NvbmZpZw0KPiBAQCAtMzgsNiArMzgsMTAgQEAgY29uZmlnIFBJTkNUUkxfTVQ4MTg4DQo+IMKg
CWJvb2wgIk1UODE4OCBTb0MgcGluY3RybCBkcml2ZXIiDQo+IMKgCXNlbGVjdCBQSU5DVFJMX01U
Sw0KPiDCoA0KPiArY29uZmlnIFBJTkNUUkxfTVQ4MTg5DQo+ICsJYm9vbCAiTVQ4MTg5IFNvQyBw
aW5jdHJsIGRyaXZlciINCj4gKwlzZWxlY3QgUElOQ1RSTF9NVEsNCj4gKw0KPiDCoGNvbmZpZyBQ
SU5DVFJMX01UODM2NQ0KPiDCoAlib29sICJNVDgzNjUgU29DIHBpbmN0cmwgZHJpdmVyIg0KPiDC
oAlzZWxlY3QgUElOQ1RSTF9NVEsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGluY3RybC9tZWRp
YXRlay9NYWtlZmlsZQ0KPiBiL2RyaXZlcnMvcGluY3RybC9tZWRpYXRlay9NYWtlZmlsZQ0KPiBp
bmRleCBiOTExNmMwNzNlYS4uYzYxZTEzZGZlYjggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGlu
Y3RybC9tZWRpYXRlay9NYWtlZmlsZQ0KPiArKysgYi9kcml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsv
TWFrZWZpbGUNCj4gQEAgLTExLDYgKzExLDcgQEAgb2JqLSQoQ09ORklHX1BJTkNUUkxfTVQ3OTg2
KSArPSBwaW5jdHJsLW10Nzk4Ni5vDQo+IMKgb2JqLSQoQ09ORklHX1BJTkNUUkxfTVQ3OTg3KSAr
PSBwaW5jdHJsLW10Nzk4Ny5vDQo+IMKgb2JqLSQoQ09ORklHX1BJTkNUUkxfTVQ3OTg4KSArPSBw
aW5jdHJsLW10Nzk4OC5vDQo+IMKgb2JqLSQoQ09ORklHX1BJTkNUUkxfTVQ4MTg4KSArPSBwaW5j
dHJsLW10ODE4OC5vDQo+ICtvYmotJChDT05GSUdfUElOQ1RSTF9NVDgxODkpICs9IHBpbmN0cmwt
bXQ4MTg5Lm8NCj4gwqBvYmotJChDT05GSUdfUElOQ1RSTF9NVDgzNjUpICs9IHBpbmN0cmwtbXQ4
MzY1Lm8NCj4gwqBvYmotJChDT05GSUdfUElOQ1RSTF9NVDg1MTIpICs9IHBpbmN0cmwtbXQ4NTEy
Lm8NCj4gwqBvYmotJChDT05GSUdfUElOQ1RSTF9NVDg1MTYpICs9IHBpbmN0cmwtbXQ4NTE2Lm8N
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGluY3RybC9tZWRpYXRlay9waW5jdHJsLW10ODE4OS5j
DQo+IGIvZHJpdmVycy9waW5jdHJsL21lZGlhdGVrL3BpbmN0cmwtbXQ4MTg5LmMNCj4gbmV3IGZp
bGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAuLmI3OThmM2MwMTliDQo+IC0tLSAv
ZGV2L251bGwNCj4gKysrIGIvZHJpdmVycy9waW5jdHJsL21lZGlhdGVrL3BpbmN0cmwtbXQ4MTg5
LmMNCj4gQEAgLTAsMCArMSwxMjc2IEBADQo+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjog
R1BMLTIuMC1vbmx5DQo+ICsvKg0KPiArICogQ29weXJpZ2h0IChDKSAyMDI2IE1lZGlhVGVrIElu
Yy4NCj4gKyAqIEF1dGhvcjogQm8tQ2hlbiBDaGVuIDxyZXgtYmMuY2hlbkBtZWRpYXRlay5jb20+
DQo+ICsgKi8NCj4gDQoNCltzbmlwcGVkXQ0KDQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG10a19p
b190eXBlX2Rlc2MgbXQ4MTg5X2lvX3R5cGVfZGVzY1tdID0gew0KPiArCVtJT19UWVBFX0dSUDBd
ID0gew0KPiArCQkubmFtZSA9ICJtdDgxODkiLA0KPiArCQkuYmlhc19zZXQgPSBtdGtfcGluY29u
Zl9iaWFzX3NldF92MSwNCj4gKwkJLmRyaXZlX3NldCA9IG10a19waW5jb25mX2RyaXZlX3NldF92
MSwNCj4gKwkJLmlucHV0X2VuYWJsZSA9IG10a19waW5jb25mX2lucHV0X2VuYWJsZV92MSwNCj4g
Kwl9LA0KPiArfTsNCj4gKw0KPiArc3RhdGljIHN0cnVjdCBtdGtfcGluY3RybF9zb2MgbXQ4MTg5
X2RhdGEgPSB7DQo+ICsJLm5hbWUgPSAibXQ4MTg5X3BpbmN0cmwiLA0KPiArCS5yZWdfY2FsID0g
bXQ4MTg5X3JlZ19jYWxzLA0KPiArCS5waW5zID0gbXQ4MTg5X3BpbnMsDQo+ICsJLm5waW5zID0g
QVJSQVlfU0laRShtdDgxODlfcGlucyksDQo+ICsJLmlvX3R5cGUgPSBtdDgxODlfaW9fdHlwZV9k
ZXNjLA0KPiArCS5udHlwZSA9IEFSUkFZX1NJWkUobXQ4MTg5X2lvX3R5cGVfZGVzYyksDQo+ICsJ
LmJhc2VfbmFtZXMgPSBtdDgxODlfcGluY3RybF9yZWdpc3Rlcl9iYXNlX25hbWVzLA0KPiArCS5u
YmFzZV9uYW1lcyA9DQo+IEFSUkFZX1NJWkUobXQ4MTg5X3BpbmN0cmxfcmVnaXN0ZXJfYmFzZV9u
YW1lcyksDQo+ICsJLmJhc2VfY2FsYyA9IDEsDQo+ICsJLnJldiA9IE1US19QSU5DVFJMX1YxLA0K
PiArfTsNCj4gKw0KPiArc3RhdGljIGludCBtdGtfcGluY3RybF9tdDgxODlfcHJvYmUoc3RydWN0
IHVkZXZpY2UgKmRldikNCj4gK3sNCj4gKwlyZXR1cm4gbXRrX3BpbmN0cmxfY29tbW9uX3Byb2Jl
KGRldiwgJm10ODE4OV9kYXRhKTsNCj4gK30NCj4gKw0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCB1
ZGV2aWNlX2lkIG10ODE4OV9wY3RybF9tYXRjaFtdID0gew0KPiArCXsgLmNvbXBhdGlibGUgPSAi
bWVkaWF0ZWssbXQ4MTg5LXBpbmN0cmwiIH0sDQo+ICsJeyB9DQo+ICt9Ow0KPiArDQo+ICtVX0JP
T1RfRFJJVkVSKG10ODE4OV9waW5jdHJsKSA9IHsNCj4gKwkubmFtZSA9ICJtdDgxODlfcGluY3Ry
bCIsDQo+ICsJLmlkID0gVUNMQVNTX1BJTkNUUkwsDQo+ICsJLm9mX21hdGNoID0gbXQ4MTg5X3Bj
dHJsX21hdGNoLA0KPiArCS5vcHMgPSAmbXRrX3BpbmN0cmxfb3BzLA0KPiArCS5wcm9iZSA9IG10
a19waW5jdHJsX210ODE4OV9wcm9iZSwNCj4gKwkucHJpdl9hdXRvID0gc2l6ZW9mKHN0cnVjdCBt
dGtfcGluY3RybF9wcml2KSwNCj4gK307DQo+IA0KDQpSZXZpZXdlZC1ieTogTWFjcGF1bCBMaW4g
PG1hY3BhdWwubGluQG1lZGlhdGVrLmNvbT4NCg0KVGhhbmtzIQ0KTWFjcGF1bCBMaW4NCg==
