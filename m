Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50201EB48F0
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 10:22:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4507D83CB5;
	Thu, 12 Feb 2026 11:22:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="bgpwNZfG";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="k4wGAG10";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6DCB83015; Thu, 12 Feb 2026 11:22:08 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E5478367F
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 11:22:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: a80b892607fc11f185319dbc3099e8fb-20260212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=7bmw1camswR3z6JrkTzw8M39TuMlhYX1ttsUcqYd814=; 
 b=bgpwNZfG7bL7ASB4Yo0eAWscjsUaVfAIB/Q9RYueqEkOBb0ptpcFF3jdUEC7KcANFaTHJ40A0tUiJ451bahqB2L+ScsrlKtkzbZknm+qxFi0u7XAz/bbpFFNwqXBcpmr+MgVtnSn7asT78JPAxoqkfE4D+AcRz+ULKHb/vD7WXM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:49320f3c-9858-45ef-ac52-6dde963f39d6, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:89c9d04, CLOUDID:cab69ff0-16bd-4243-b4ca-b08ca08ab1d8,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
 C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a80b892607fc11f185319dbc3099e8fb-20260212
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by
 mailgw01.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1548415925; Thu, 12 Feb 2026 18:21:55 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 12 Feb 2026 18:21:54 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 12 Feb 2026 18:21:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F7Il1XXs8Hbwi2f1ErQI4tSWwBUlkHKi8MqM+yek2jNQK0rSB7CF3UUkw+R6JGKqtqa+aayezGFCsaG/v2CpCWCnD7ioOHwv/4jPhKJ8PcU5c8O15LzexwKd7NBnvGj310/hu8JY1Hwt33vrAWUolIy7LzI6j0yXIDpe2yWuZYCOF4ECdiJTIEoErVHa8+nXTfCYh2m3swyXuPHJPdqaLsrLALVJtMraHmJVqijUb29H8KNlQTgBpufBk6J/dsbliwiRPheSBM+Eo+kFVd4L9u5JicDpqCa4HLlJxKHN1+rFsITIn2mm1nRtPXOPsbRN6Kx5zgMzo4FMbSXIohy5VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bmw1camswR3z6JrkTzw8M39TuMlhYX1ttsUcqYd814=;
 b=fHdZBuCpO5xCErzzetxsalFlmmLPOXq2qLHsajMZ4jg/xMnvsCa5qW8vm9bMnK6h5sw9LcK9HUigectMkwFZFHFt3WSz2f4ZekDC+bnGCcBL7No3yKbklz02NVttgCprmdXJjVUqbexxdl6uybZkFgyCoIVyduDs1BDox6bFeyoHozDZXYV44r7pTMkm+fAnqAwu7w9MGdwdt3Rpi4IapLGPmf6lEn/j2asBMXXxoFeZpSbAqdjVtyH3eyXWfQGirguYzkRjT7g4ZYc4dy8ZDVnmgwY+QCh3HZCsV3Ug2CcacBWZn5CGCuhPf6MxfOf0jP5eK6G+l1wd/J4sFuHthw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bmw1camswR3z6JrkTzw8M39TuMlhYX1ttsUcqYd814=;
 b=k4wGAG10aatLOHc0L33EVYN2UMraUSn47/K7c/Ue2UPhpxQKMeUtl92lBC0L6nMXNyHP0DCxXgXfUHcXFq/wtPzYvZ20SmZvrM53k7NaGWdd8keuEFSjTMKVsWfwRCTYlcKb9K8fpxU3CcIOHecPkTn/BaO2ueYgrFN98r/WDBM=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by KL1PR03MB7406.apcprd03.prod.outlook.com (2603:1096:820:ec::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Thu, 12 Feb
 2026 10:21:49 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 10:21:49 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: Julien Stephan <jstephan@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>, =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?=
 <bear.wang@mediatek.com>
CC: "hayashi.kunihiko@socionext.com" <hayashi.kunihiko@socionext.com>,
 "venkatesh.abbarapu@amd.com" <venkatesh.abbarapu@amd.com>,
 "kever.yang@rock-chips.com" <kever.yang@rock-chips.com>, "n-francis@ti.com"
 <n-francis@ti.com>, "trini@konsulko.com" <trini@konsulko.com>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "bhupesh.linux@gmail.com" <bhupesh.linux@gmail.com>, "michal.simek@amd.com"
 <michal.simek@amd.com>, David Lechner <dlechner@baylibre.com>,
 "philipp.tomsich@vrull.eu" <philipp.tomsich@vrull.eu>,
 "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>, "sjg@chromium.org" <sjg@chromium.org>, 
 "u-kumar1@ti.com" <u-kumar1@ti.com>, "neil.armstrong@linaro.org"
 <neil.armstrong@linaro.org>, "bb@ti.com" <bb@ti.com>, "j-mcarthur@ti.com"
 <j-mcarthur@ti.com>
Subject: Re: [PATCH v2 1/3] drivers: ufs: handle return values of ufs_hba_ops
 callbacks
Thread-Topic: [PATCH v2 1/3] drivers: ufs: handle return values of ufs_hba_ops
 callbacks
Thread-Index: AQHcmqmiMRpqeut6eUWS7OIpOt8+LLV+3SKA
Date: Thu, 12 Feb 2026 10:21:49 +0000
Message-ID: <0d587bea25dfb23e0e4c07e146de495f2e64833d.camel@mediatek.com>
References: <20260210-ufs-ufs_hba_ops-cleanup-v2-0-dd73da21aa92@baylibre.com>
 <20260210-ufs-ufs_hba_ops-cleanup-v2-1-dd73da21aa92@baylibre.com>
In-Reply-To: <20260210-ufs-ufs_hba_ops-cleanup-v2-1-dd73da21aa92@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|KL1PR03MB7406:EE_
x-ms-office365-filtering-correlation-id: 2ad51a02-fdb7-45cb-4672-08de6a2088b1
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?cWE4Y3I5ZHlITjJZVmpuZTloSGhBbi8yelJmalluUmhwWndCOFhGS0FuME1y?=
 =?utf-8?B?c0ljT1lycExqVXFvR1VKNjRqblBLaGhMeEo3NkthK1BoVnV5YWhueWJxRTNh?=
 =?utf-8?B?b2FtZmZ1YktXTXc5YTJ5YTA2NEhka0RTenFkdk5qd1d4K1BVTjZyemVzMU55?=
 =?utf-8?B?SFcyOE1TeEs3UWRIdVRRekl4Uk5aNjlrb2RMbXJzMElyeFV0cFJ0ZGpqVmtT?=
 =?utf-8?B?U3AxUjhlaVdhdTZGT0tTVnNKTnIxUzNXcmZyRVRLVlZSSytqVzIwTXNhaDBh?=
 =?utf-8?B?djY0T1AxejdKQWdFZkRtdnhFZlBqdjl5SmZRNnI5am5ldHhERGM0WmgrMlhC?=
 =?utf-8?B?aitYVHZ6VzBqbGNrZU5WcUllcHR6RHNiOXNrL2JabURRc2dNbVRoRE5XaFVs?=
 =?utf-8?B?ajY5eUVCYjRGMWdMWjJQT0RNQTRKWUJGWlpPQVMwYUdic2lHZUtEUnhOZmd0?=
 =?utf-8?B?ZU9FbFFaZTJoaExWNUs0UVhoYUNqWWhsa0sxUldzcWoralRSRTE5MVdzTVpu?=
 =?utf-8?B?S2R3NllJSmZ3Tk1ZZlBNU2JoM2ZDaWRsU2JqV2pJa1BIQ0k2T3VOcFdXbWxG?=
 =?utf-8?B?UG9NTDFWRWdkaXczRkVNZWJPMG5zekhNTGNoZWlHc29hYjhpWVZGSlN0Sm8v?=
 =?utf-8?B?dmh1VmRkRUxqTnp2cWdSZmpQbDZpN0tJdC9UdFFmaXdVRmtEdWx6RWJvRjFL?=
 =?utf-8?B?VFgxUWRrNFp5ZWhkTzdCcGNrMWtLRTJmTnRKTmZWbnJ3UVVBTFkwaU5tVUN4?=
 =?utf-8?B?bzVMM2xVd2R4RzFZWFVVcW42Ym5aaEJia2NXR1NYc3p0Sk5vVUNqbWFkSC9O?=
 =?utf-8?B?cWd2TjVaRllQaTNSM1FkVDdFNEx1VFNEZ3ovTVlHcUdvb01UNjE1YkJuZ216?=
 =?utf-8?B?U0x6VW5ZbzM4dXZrUWUva3lFeXVVbFFzUDdoZEwrQkNjREtyZ1pwaEFoUzNs?=
 =?utf-8?B?Rk9URHFlNEZER2NnbDlHcWdUZURtWXNuN01CNlpuQk0wK29yNlE0ajZRRzFG?=
 =?utf-8?B?SGcxcStpQU5DRXJNbkRBU3hlYTFXbldRS1BEV1F1TkRnUzFDNmM3cDdibk1Z?=
 =?utf-8?B?WjZKOUhDUkhlV0FrRXhPcmZHQzhOZWhHZHZuNTArVThvaTFWNVVjU3M0M0Fa?=
 =?utf-8?B?bmlFY2l3ZGIrWGoycndDdUVGdWY1MnZpRGYrVHdaOTlyWmQ5enFKbGtDQVhV?=
 =?utf-8?B?Y3MrQWxwR3FOVnUvR0hidUFrOXNhcFF0bGRUajlBUlpkTjNHOEJ3K0pCSFRj?=
 =?utf-8?B?NHUydFh1RGkzR1JTNVczSGt5K2xSN2dESTdGSGphRWs0aXl5MEdyZnBVeURu?=
 =?utf-8?B?WVBYMnpkRmt0YXhieHRUcng3dHl5TmRNZkRaV2U5MnoyY25zdlBia0RZUGdn?=
 =?utf-8?B?MUFqczhLMmFwYkhFQkF6WENhMTJvSUJ2RHJLV0tDa1RyY1lSQWY5UFBOYlJK?=
 =?utf-8?B?WDRQTkE4N1N4ZkZUelF5SklTdDBDZ0Y3Z3dKQmMvVjRkeWtyWVIyVm9JV0sw?=
 =?utf-8?B?WUxNaFVmcDJmN3pKR0FDTitlSTJHbmFYblNUcTAzQWJ3K2RlSmxNbXpOU3Vj?=
 =?utf-8?B?b1cvc0FiQTZhSVhUck5SVEg5U1VieGUrRHMralc5R1plL25FYWs4T2RLOGpD?=
 =?utf-8?B?WS9CbGg5Y1ppeVVLNjluK0c2LzNmV0hoSkFSbUxkN1lXOHZhc3dTcXJBMld5?=
 =?utf-8?B?QktBZXVEbTB1Y1p6R1puU2dESGRrK2o5Rlc3MHRCY3dhVXJ4SWdqdFVBdWhC?=
 =?utf-8?B?R2MreCtCQmhJZ0xSSldZdmN3Zk96QjRPaHZCbFhtMUxYSFA5YUx0NDRDbWxj?=
 =?utf-8?B?SVRmYzNpTFpLdkdjTGNWbC9PNW1tM0h0cDNkbitqQXFBV2lCT3orTjBZZWR0?=
 =?utf-8?B?T0ZuNzN6UEpIMWdPRUpTNzVja1FpcytBeEZmZTN0TXJZOXpmYXc5Tk5yVFQv?=
 =?utf-8?B?UFZvRmZwUklVWWE5cmk1RCtZN1l2M29YaUwxN3FWbUFxTHQycFpYWU9IbFFW?=
 =?utf-8?B?ZW02YTNjdkxjV2EyME16aFNTSU4yZlh1emRSM0tUQVdWRlZMaUw4TVFxbFhH?=
 =?utf-8?B?eFVUOVpBVitXdU5SemZFNmxxc3VlU0N0dXdmSnVzY1V2dlg2OTR3dlVFWUdy?=
 =?utf-8?B?Tndxbk1LaytCbDJ5NWxmSk56WXd3cERUOXdBM0NQelZNOFVQd25hQTF5SmRZ?=
 =?utf-8?Q?LimFNXU9TcZqVQgKtOlDnOs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NHRTU3ZXbWV2MDYwZ3lsa3BkZkIwZXlTckFPcTcvcndNRFMwQWhJQkZIM0pl?=
 =?utf-8?B?RTNyZ1RicFE4YnlHdnV2d0k3NXR6RkNxdDRGQm41dFE3bEVMQ1dKcWR4dHFU?=
 =?utf-8?B?clYrSklHV3BTdzk3bnhRN0lFd05mNERzbnAxMnpST0VseDFpUmI0YTAvODdu?=
 =?utf-8?B?Ynd2Zm1TdnhTUmp5Q2tSWmdLOWdJbGk3ZkE2UkJmUERQd1lUVVFHY1dySjRp?=
 =?utf-8?B?bUJnbm80MWFHYVZBWnlXTEhQMTZCM1pZZU5mTUVtWFRGVk5oUmZhdEJRR3Ev?=
 =?utf-8?B?M1QwRUROUE5Lai9lRjIvajdnSVdjNFRNcnA2MFZUbFFPWTF4K0hYSWhUdFE4?=
 =?utf-8?B?M01jZGRPb0VCdW1kc3M1VHVLMTA0MjNEdDdkZEZTNDkrbmtlaWUzdmdpcU9Y?=
 =?utf-8?B?bjdDTlZSbzBEbjRvdmo3bmdSY2ExY0tKYTZDK0ViVXZIWHhjUmo4bVJncFVY?=
 =?utf-8?B?MGVYRG1aamJ6UEpsY1JyV1FOY2tsQ3Via00vbTl5UkRyYUZuWEdHZGRVZVp0?=
 =?utf-8?B?dE9HSTZQc2lFYmRvd0pPeEMxUDhuQTBoYjBiMkVEa2NSWjYyN2UwbDk5a2dq?=
 =?utf-8?B?TUpvQURRZzVSUW9MZVY5elVDZGp2cHRoaURUbU1kUlNqeVdpK3hPY3hkb2Zh?=
 =?utf-8?B?b251WE91ZnJJeTdSRDIzV0k0ajU2SkFqT1RUQ21ybG5FT2ZFbW03TlNxeDJv?=
 =?utf-8?B?YnFEQU4zeDJqd3V0cGxMdUxYZmFwdzIxMGZsbDNoM2tJb3BrQXVpcE1YWGdk?=
 =?utf-8?B?YUJjVXV1L3Zndnk4c1Eyak5ZaU9QTFNaNlM4SW1oWlEvSktSUDNMNE9TcEgr?=
 =?utf-8?B?YTMxTEpjcUlvMncvYXQ0d29xeDBmYURRbGhxaVhSZ1RDVm93RFM2SkE1R3Rh?=
 =?utf-8?B?UWZ3d3JlRXgwVlpDUXAzWG1Hb3o2REs2TkxJZTZjVEpSTG5EajU1SFAvMkdN?=
 =?utf-8?B?QUpaVEZ4S1RkWWlKUGlUMjhvdmQ1MTRMMWpwUWpyK3NGcXdKMWNBRUp0QkRl?=
 =?utf-8?B?MmNKUnVBV3YyUkNGS3psTHhMNGNUWTdqQkMzbFdjRGN2UzNULzB0N2VTbVM4?=
 =?utf-8?B?NEZYMVUwa1p2STJPekp4K0w3SjlhWGZHTHNOY0tBaGZjUWZxd3FPM2JpNjVO?=
 =?utf-8?B?LzYxcEVKdksxbURGZU1VZUZ4dG50ZDU4NU1oUXdOSnlkWXZ1NzU3WkNxLzRn?=
 =?utf-8?B?aHh3TTRWMEZEZWVIaGZCczYwK0lxUGs5eDRvNE1mSWhwZVZqOHpiRVBwczZk?=
 =?utf-8?B?TFZieTVSa0ZETXJrMVlaSEhaOWJDaDRCdUxGTGo2SlRHcFVjUklTS2cveFZF?=
 =?utf-8?B?QVR3dVVmbEV1RFRjaFczSHMzZHBWZm1hMVBJeDhUaWkxSWhjQk5uekpscm01?=
 =?utf-8?B?Rm8yOE9HdXdLRm5OOTk0RUFWZFBKUVhNajQrVVRHQyt4MGJpT3Mzb3ZOcFJ3?=
 =?utf-8?B?MHdZMHE0andoeUFTOEFWSEswM2xGR2oxaFc5QTUzdThkTFFwZndGNWN4ell5?=
 =?utf-8?B?Y2YrNWZNdm5pUmEyN0hmTEYwWDhWcnZ5SCtIVXJ1M21wa2ZsY0Nla1VJaEpJ?=
 =?utf-8?B?a0JTMUdxejBva05BTG96ajhBWHBMc1VVMTAwZjZPTjdxZjgxZTBRMit5NGRa?=
 =?utf-8?B?YjdVU0tLYUUyTlc2SnFVa2xKSEswd0szeEx3WU9lYW5laWNKT1c5Yy8zWnRs?=
 =?utf-8?B?TytTa0ZpOXpVZG1VRE1DT3d6K2lEMmtrQjNwdHpxK09Ua1JUdzVCUG1lOGd2?=
 =?utf-8?B?c0Y0em5DVDBabWtuRTVKK09zZFRiVGxLcGZTM0M5T1VQMGQwbUJHbHdybjYr?=
 =?utf-8?B?aVk5YnJ0dnVNamZmVHlCNjI3R01IMWFkVWtVN2JTLzNidm1DMU84TUNXSTNz?=
 =?utf-8?B?T0w2cnRRdE5zM0lPSDZxY0ZLV2xZaGtsaDdEY1c4TkdXdzdLbHZMQktsLzFU?=
 =?utf-8?B?WG0rTkpCRW5wN0pSK3VQck01bVo4NUMvdUJUSlQ2b2lEQ2p3RndpY1h3ZS9P?=
 =?utf-8?B?dXNxRUNxa2hoWnJIZnQxYUVJZDBjMldwajBQLzRwTmNVckdjd3Z1NWU0RWpj?=
 =?utf-8?B?T2RNYkJBVzQ1TEp0MklxeGtaYWZsVkhtY21tL3B5UkJJQ2hUb2xRVG9lQ2pV?=
 =?utf-8?B?eldQeTh5VFVUeXp5aVdTbG9xdEQzTEFFVVB4cUs1U2FEbm9JV055M2I5VVNV?=
 =?utf-8?B?ckMzQi9CVjFiMHhoVEdKSHZEWEtFeVhubjdzYmhucGNRMy9idW9MWmp4Q0Ji?=
 =?utf-8?B?WUZlM2wvQlFwUURiWHFlTDdNQTBWbkdRUFJtMUx4YUJWWU9FODdnQUlPczk4?=
 =?utf-8?B?aGcxR2VnRzRaQzNvVGtqS2RqVnBiajVSZjl5UU9BamtrWmdVaVBrOVpRUHpI?=
 =?utf-8?Q?fwMwL1nLHqDeurL0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA287A3030C0EA438DDA83DAA3E43E1D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad51a02-fdb7-45cb-4672-08de6a2088b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 10:21:49.7665 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gjc0mG2a8ViIaiJfhLMNMkWdhP5RVGNjjuKRWgHYqmP2eW08NgIFA/QEOFJXZRf9gjTn9uX2gzUlB8gVsOmiz3BXjOleY1ejjq1ayfC8BXU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7406
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

T24gVHVlLCAyMDI2LTAyLTEwIGF0IDE3OjIyICswMTAwLCBKdWxpZW4gU3RlcGhhbiB3cm90ZToN
Cj4gVGhlIHJldHVybiB2YWx1ZXMgb2YgdWZzaGNkX29wc19saW5rX3N0YXJ0dXBfbm90aWZ5KCks
DQo+IHVmc2hjZF9vcHNfaGNlX2VuYWJsZV9ub3RpZnkoKSwgdWZzaGNkX29wc19pbml0KCksIGFu
ZA0KPiB1ZnNoY2RfZGV2aWNlX3Jlc2V0KCkgYXJlIGN1cnJlbnRseSBpZ25vcmVkLg0KPiANCj4g
Q2hlY2sgYW5kIHByb3BhZ2F0ZSB0aGVzZSByZXR1cm4gdmFsdWVzIHByb3Blcmx5IGFuZCBlbWl0
IGFwcHJvcHJpYXRlDQo+IGVycm9yIG1lc3NhZ2VzIG9uIGVycm9yLg0KPiANCj4gV2hpbGUgYXQg
aXQsIHJlbW92ZSB0aGUgdWZzaGNkX2RldmljZV9yZXNldCgpIHdyYXBwZXIsIHdoaWNoIGp1c3QN
Cj4gY2FsbA0KPiB1ZnNoY2RfZGV2aWNlX3Jlc2V0KCkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBK
dWxpZW4gU3RlcGhhbiA8anN0ZXBoYW5AYmF5bGlicmUuY29tPg0KPiAtLS0NCj4gwqBkcml2ZXJz
L3Vmcy91ZnMtdWNsYXNzLmMgfCAzNiArKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0t
LS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91ZnMvdWZzLXVjbGFzcy5jIGIvZHJpdmVycy91
ZnMvdWZzLXVjbGFzcy5jDQo+IGluZGV4IDNjOGU0Mjk5MjU5Li5jMDlmNjFhYTQyMCAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy91ZnMvdWZzLXVjbGFzcy5jDQo+ICsrKyBiL2RyaXZlcnMvdWZzL3Vm
cy11Y2xhc3MuYw0KPiBAQCAtMTI3LDExICsxMjcsNiBAQCBzdGF0aWMgdm9pZCB1ZnNoY2RfcHJp
bnRfcHdyX2luZm8oc3RydWN0IHVmc19oYmENCj4gKmhiYSkNCj4gwqAJCWhiYS0+cHdyX2luZm8u
aHNfcmF0ZSk7DQo+IMKgfQ0KPiDCoA0KPiAtc3RhdGljIHZvaWQgdWZzaGNkX2RldmljZV9yZXNl
dChzdHJ1Y3QgdWZzX2hiYSAqaGJhKQ0KPiAtew0KPiAtCXVmc2hjZF92b3BzX2RldmljZV9yZXNl
dChoYmEpOw0KPiAtfQ0KPiAtDQo+IMKgLyoqDQo+IMKgICogdWZzaGNkX3JlYWR5X2Zvcl91aWNf
Y21kIC0gQ2hlY2sgaWYgY29udHJvbGxlciBpcyByZWFkeQ0KPiDCoCAqwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRvIGFjY2VwdCBVSUMgY29t
bWFuZHMNCj4gQEAgLTUxMiw3ICs1MDcsOSBAQCBzdGF0aWMgaW50IHVmc2hjZF9saW5rX3N0YXJ0
dXAoc3RydWN0IHVmc19oYmENCj4gKmhiYSkNCj4gwqAJaW50IHJldHJpZXMgPSBETUVfTElOS1NU
QVJUVVBfUkVUUklFUzsNCj4gwqANCj4gwqAJZG8gew0KPiAtCQl1ZnNoY2Rfb3BzX2xpbmtfc3Rh
cnR1cF9ub3RpZnkoaGJhLCBQUkVfQ0hBTkdFKTsNCj4gKwkJcmV0ID0gdWZzaGNkX29wc19saW5r
X3N0YXJ0dXBfbm90aWZ5KGhiYSwNCj4gUFJFX0NIQU5HRSk7DQo+ICsJCWlmIChyZXQpDQo+ICsJ
CQlnb3RvIG91dDsNCj4gwqANCj4gwqAJCXJldCA9IHVmc2hjZF9kbWVfbGlua19zdGFydHVwKGhi
YSk7DQo+IMKgDQo+IEBAIC01OTgsMTIgKzU5NSwxOCBAQCBzdGF0aWMgaW5saW5lIHZvaWQgdWZz
aGNkX2hiYV9zdGFydChzdHJ1Y3QNCj4gdWZzX2hiYSAqaGJhKQ0KPiDCoHN0YXRpYyBpbnQgdWZz
aGNkX2hiYV9lbmFibGUoc3RydWN0IHVmc19oYmEgKmhiYSkNCj4gwqB7DQo+IMKgCWludCByZXRy
eTsNCj4gKwlpbnQgcmV0Ow0KPiDCoA0KPiDCoAlpZiAoIXVmc2hjZF9pc19oYmFfYWN0aXZlKGhi
YSkpDQo+IMKgCQkvKiBjaGFuZ2UgY29udHJvbGxlciBzdGF0ZSB0byAicmVzZXQgc3RhdGUiICov
DQo+IMKgCQl1ZnNoY2RfaGJhX3N0b3AoaGJhKTsNCj4gwqANCj4gLQl1ZnNoY2Rfb3BzX2hjZV9l
bmFibGVfbm90aWZ5KGhiYSwgUFJFX0NIQU5HRSk7DQo+ICsJcmV0ID0gdWZzaGNkX29wc19oY2Vf
ZW5hYmxlX25vdGlmeShoYmEsIFBSRV9DSEFOR0UpOw0KPiArCWlmIChyZXQpIHsNCj4gKwkJZGV2
X2VycihoYmEtPmRldiwgIkNvbnRyb2xsZXIgZW5hYmxlIG5vdGlmeQ0KPiBQUkVfQ0hBTkdFIGZh
aWxlZDogJWlcbiIsDQo+ICsJCQlyZXQpOw0KPiArCQlyZXR1cm4gcmV0Ow0KPiArCX0NCj4gwqAN
Cj4gwqAJLyogc3RhcnQgY29udHJvbGxlciBpbml0aWFsaXphdGlvbiBzZXF1ZW5jZSAqLw0KPiDC
oAl1ZnNoY2RfaGJhX3N0YXJ0KGhiYSk7DQo+IEBAIC02MzUsNyArNjM4LDEyIEBAIHN0YXRpYyBp
bnQgdWZzaGNkX2hiYV9lbmFibGUoc3RydWN0IHVmc19oYmENCj4gKmhiYSkNCj4gwqAJLyogZW5h
YmxlIFVJQyByZWxhdGVkIGludGVycnVwdHMgKi8NCj4gwqAJdWZzaGNkX2VuYWJsZV9pbnRyKGhi
YSwgVUZTSENEX1VJQ19NQVNLKTsNCj4gwqANCj4gLQl1ZnNoY2Rfb3BzX2hjZV9lbmFibGVfbm90
aWZ5KGhiYSwgUE9TVF9DSEFOR0UpOw0KPiArCXJldCA9IHVmc2hjZF9vcHNfaGNlX2VuYWJsZV9u
b3RpZnkoaGJhLCBQT1NUX0NIQU5HRSk7DQo+ICsJaWYgKHJldCkgew0KPiArCQlkZXZfZXJyKGhi
YS0+ZGV2LCAiQ29udHJvbGxlciBlbmFibGUgbm90aWZ5DQo+IFBPU1RfQ0hBTkdFIGZhaWxlZDog
JWlcbiIsDQo+ICsJCQlyZXQpOw0KPiArCQlyZXR1cm4gcmV0Ow0KPiArCX0NCj4gwqANCj4gwqAJ
cmV0dXJuIDA7DQo+IMKgfQ0KPiBAQCAtMjE4Miw3ICsyMTkwLDExIEBAIGludCB1ZnNoY2RfcHJv
YmUoc3RydWN0IHVkZXZpY2UgKnVmc19kZXYsDQo+IHN0cnVjdCB1ZnNfaGJhX29wcyAqaGJhX29w
cykNCj4gwqAJLyogU2V0IGRlc2NyaXB0b3IgbGVuZ3RocyB0byBzcGVjaWZpY2F0aW9uIGRlZmF1
bHRzICovDQo+IMKgCXVmc2hjZF9kZWZfZGVzY19zaXplcyhoYmEpOw0KPiDCoA0KPiAtCXVmc2hj
ZF9vcHNfaW5pdChoYmEpOw0KPiArCWVyciA9IHVmc2hjZF9vcHNfaW5pdChoYmEpOw0KPiArCWlm
IChlcnIpIHsNCj4gKwkJZGV2X2VycihoYmEtPmRldiwgIkhvc3QgY29udHJvbGxlciBpbml0IGZh
aWxlZDoNCj4gJWlcbiIsIGVycik7DQo+ICsJCXJldHVybiBlcnI7DQo+ICsJfQ0KPiDCoA0KPiDC
oAkvKiBSZWFkIGNhcGFiaWxpdGllcyByZWdpc3RlcnMgKi8NCj4gwqAJaGJhLT5jYXBhYmlsaXRp
ZXMgPSB1ZnNoY2RfcmVhZGwoaGJhLA0KPiBSRUdfQ09OVFJPTExFUl9DQVBBQklMSVRJRVMpOw0K
PiBAQCAtMjIyNiw3ICsyMjM4LDExIEBAIGludCB1ZnNoY2RfcHJvYmUoc3RydWN0IHVkZXZpY2Ug
KnVmc19kZXYsDQo+IHN0cnVjdCB1ZnNfaGJhX29wcyAqaGJhX29wcykNCj4gwqAJbWIoKTsgLyog
Zmx1c2ggcHJldmlvdXMgd3JpdGVzICovDQo+IMKgDQo+IMKgCS8qIFJlc2V0IHRoZSBhdHRhY2hl
ZCBkZXZpY2UgKi8NCj4gLQl1ZnNoY2RfZGV2aWNlX3Jlc2V0KGhiYSk7DQo+ICsJZXJyID0gdWZz
aGNkX3ZvcHNfZGV2aWNlX3Jlc2V0KGhiYSk7DQo+ICsJaWYgKGVycikgew0KPiArCQlkZXZfZXJy
KGhiYS0+ZGV2LCAiRmFpbGVkIHRvIHJlc2V0IGF0dGFjaGVkIGRldmljZToNCj4gJWlcbiIsIGVy
cik7DQo+ICsJCXJldHVybiBlcnI7DQo+ICsJfQ0KPiDCoA0KPiDCoAllcnIgPSB1ZnNoY2RfaGJh
X2VuYWJsZShoYmEpOw0KPiDCoAlpZiAoZXJyKSB7DQo+IA0KDQpSZXZpZXdlZC1ieTogTWFjcGF1
bCBMaW4gPG1hY3BhdWwubGluQG1lZGlhdGVrLmNvbT4NCg0KVGhhbmtzIQ0KTWFjcGF1bCBMaW4N
Cg==
