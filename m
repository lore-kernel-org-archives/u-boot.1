Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB0AED6CFDC
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 06:25:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11C1E839DF;
	Fri, 23 Jan 2026 07:25:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="P0Nuv4yw";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="JjS/+C5j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFE6783A6A; Fri, 23 Jan 2026 07:25:29 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD1A5839D5
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 07:25:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: 4a141000f82411f085319dbc3099e8fb-20260123
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=RwIFIJfpf/Xf8JaMCJhwOwsm8h15WFabLfvLtJh3zSk=; 
 b=P0Nuv4yw53WxQQAv68kEtNhtGeeLyYOIKjQKD/Uu6RxFbeONal3fig80euVXmDvnd1LBM0Ql2qUWbZm2M/ZekCd3vXpR6UG+lozHq3rxkK6tuDFz6wKRaEOir+PYm+20sFanNQtaGmxlkZAEsZwbu8GkntBQ2z+A6jlCd01C9c8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:a59e0bb0-7bb1-448c-a59c-604257432368, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:89c9d04, CLOUDID:5889ddef-16bd-4243-b4ca-b08ca08ab1d8,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
 C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4a141000f82411f085319dbc3099e8fb-20260123
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by
 mailgw01.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1409626146; Fri, 23 Jan 2026 14:25:19 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 23 Jan 2026 14:25:18 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 23 Jan 2026 14:25:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VhGXQ3HALNv9tW171N/M/u/q2Qmvu5Dk9qQjTZAX6bBuqNB1BZbB9Tr7Zf/DZBKC7qNKpO9UZy4UigRwSNEMvRHv3XYFeVx6Hk2LMOnxTo+aMmdlFZA/KPN3a3ZAELCLKZBHzRGnWHcB9+HxUE//thsdhfm9jkLPaGNpZRyqvj59RvlYPFNtQ3LMRZHiQslSL3Hgnpp6IxiF5quZg6LURnWfwW/O/08f6iRz8x0RM6iMF3Qj5RGBku74B+neu/R4fL34qLl8pi7FFh/Q1Rc1/oiy19xIIoR6pXuQ6L08Vw+H66PB4e95ZhJ/zkWZ+kymUFQr2bbcRcqSQsc4dMnmdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RwIFIJfpf/Xf8JaMCJhwOwsm8h15WFabLfvLtJh3zSk=;
 b=HnIi1ECHZbLUo4O8wLYfDJZU231bF2yDqbAMQPwJeJrVeZuIbJT3+I5uNfJ4cQzKVjLnAbX6bX3kNpd2E9S3LU/OnRbgMI0psHLI8/uX8gRAnLclwlahq90ZTaOtROUgkq8hSKdvHNxpiA0g+g/iIZO9Cmw8YSez2J+S700AK6aBnaeMr+81keKsjtgqlIzyv/aezuxxEPtkqwM3N9m8hUu5w5sk4YNZf+iOq3kJ6/5MQFlIg/e7Txf8Ww0WV/J57As4Sl59FmAv35YTIw/8L7XEmCJUmUxoCY10kdO+UV2ahagi/PNeBMn1679PuOpRkToedd+kaH0rX0Fk0tHmMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwIFIJfpf/Xf8JaMCJhwOwsm8h15WFabLfvLtJh3zSk=;
 b=JjS/+C5jXYVBgOiTpzqj2hAJ1x+L0RCxlN88qCEyVbowgMOdv9j/ftYxU7GjnMwUt9fqqYQ2j7rl3rDifDBfFPLzLYxy6/93T+cveCqJx6Cx/SHA9tFO2Kydszjji+Y6Ioa7aiFEXB0CZK7ajBeEFzTf1ZtGAZfI5A6WMpYMkgM=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by TYSPR03MB7650.apcprd03.prod.outlook.com (2603:1096:400:42f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 06:25:15 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2557:de4d:a3c7:41e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2557:de4d:a3c7:41e8%3]) with mapi id 15.20.9542.009; Fri, 23 Jan 2026
 06:25:15 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: Julien Stephan <jstephan@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: David Lechner <dlechner@baylibre.com>,
 =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
 =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "trini@konsulko.com" <trini@konsulko.com>, Ryder Lee
 <Ryder.Lee@mediatek.com>, "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>,
 =?utf-8?B?SmlsbCBDaGFuZyAo5by15paH5r2UKQ==?= <Jill.Chang@mediatek.com>,
 "Vitor Sato Eschholz" <vsatoes@baylibre.com>, Julien Masson
 <jmasson@baylibre.com>, =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>, =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?=
 <Weijie.Gao@mediatek.com>, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>,
 =?utf-8?B?Q2hyaXMtcWogQ2hlbiAo6Zmz5aWH6YCyKQ==?=
 <Chris-qj.Chen@mediatek.com>, =?utf-8?B?U2h1LXl1biBXdSAo5ZCz5oGV5piAKQ==?=
 <Shu-yun.Wu@mediatek.com>
Subject: Re: [PATCH v2 2/2] pinctrl: mediatek: add pinmux_property_set ops
 support
Thread-Topic: [PATCH v2 2/2] pinctrl: mediatek: add pinmux_property_set ops
 support
Thread-Index: AQHci72l5zWrVAkrD0yZ0cX3VMktSbVfSpSA
Date: Fri, 23 Jan 2026 06:25:14 +0000
Message-ID: <41a684d41bc3a773202185370262ebc826211792.camel@mediatek.com>
References: <20260122-add-mt8188-pinctrl-support-v2-0-324b4c8f2b64@baylibre.com>
 <20260122-add-mt8188-pinctrl-support-v2-2-324b4c8f2b64@baylibre.com>
In-Reply-To: <20260122-add-mt8188-pinctrl-support-v2-2-324b4c8f2b64@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|TYSPR03MB7650:EE_
x-ms-office365-filtering-correlation-id: 3c0ea9a3-35ef-438c-db76-08de5a482bae
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?QU1hSVUwT0hjVm85c0ZMU1ZmWkdGZTRNdzYwelRqOGQzVmxNeDNZSDZwZXNR?=
 =?utf-8?B?MzgwcHhKcHYrYWlSVlRRSnd2U05NemJRdGQwRFp4NnRZUi9NMXFqNGVacE1B?=
 =?utf-8?B?UlU0T2NaNlpVSy8xM3NRQXFSTFJIQnM2OEJLYWV0QUxOYnZuWHVnYjM1ZGl3?=
 =?utf-8?B?bXpvOWdtcUZubERkNUlFQVJNMUJjek1rM3JqQm1QejhXNjV4RFlVSVBMNXAz?=
 =?utf-8?B?RmNRSGx6bll1dlE1TnQyYUcxdWlINjdQcU1OUHJIOWlLZTY4bXNtTUJ2Wmpx?=
 =?utf-8?B?cG02cFFhZnF1eUFnNXRqVytLbVNHOXRJc3pXbnRDamYzdndjd3ZrS0NRQXFK?=
 =?utf-8?B?UjhacCtSOUREaFduUlhLQTlVYnhqYXZVMUJvZFVVOHlZaVQ2RnhpWjcrTlVZ?=
 =?utf-8?B?VDd2bU5TdGFJcUVRdS96aStSS1BSa3BrS1pkbEZLSCt3RFFlTVdLRXhDTENs?=
 =?utf-8?B?WU1IRVFHVHY5ZTdzTWxGYm9PZDlsSVVFUG9IeElubnI5TzNpc0VnWHBxYkZM?=
 =?utf-8?B?L2cvM1RkQllPWCtza2FRNDdCNERva05iUFpmbEdiTVJCZC9PRXRJSm5ia0VM?=
 =?utf-8?B?QncrbTIwSXJDcUpycmJoeWlEWUh6cVB2R29UeS9VdDQ5VEhKbGh3VE9mdjFW?=
 =?utf-8?B?MTNHWjQvbklpdXFvK0haOU1oQnVjaVhOZ1dtYXhUK3U2WWtQazNIaE51Q0dK?=
 =?utf-8?B?VjFkdmJlVE92bmwvc0NmajZNbkVWYWoxN1BzOHdWTlBYUi8wZFNzTHd1aGZw?=
 =?utf-8?B?b1dzVU5TbGx6L25SanRBTTZXOEgvcHFrbzR3THp3OXovVmdBbmdpTngwM012?=
 =?utf-8?B?cCtNUXdGNVRKeDZYR0FlbHVRVnd4dUE3aW1SNHNCeEEvRzEzcU0vZEFsR3ZK?=
 =?utf-8?B?SDBZZUlEZGMvaGRLMjVHWEpldXh2QVNWeHdrTUttM0doS3FRNGloNmtxZEpD?=
 =?utf-8?B?UTdLcVNERmd5NUluSmJLMGFuRTFMK1FENndxcU92d055SXlKUUEyTVRSL1Rt?=
 =?utf-8?B?WEFoMnRXaWNzQTUrdEtleUZvaEZKbnpIeEsveHhpc2JSbU56bjZOWUlSNm9n?=
 =?utf-8?B?L2J5aXJaKy91VDRoWGdzZWlPL0VaVGo4OUlTT0Q3L0FMYVkwbW5aRWFMNXp0?=
 =?utf-8?B?ajUrVmQ5T3EwQnlhZ2JOME80K29KWXRjb0N0MmYzdit3bHVSL1Zhcm9semto?=
 =?utf-8?B?UGcvVlE0LzNwdjZYU3A1Nit6aVhYRHArOERZOUhWWEs4Ujl2Uk1HZVVlL3k1?=
 =?utf-8?B?STFQRXU1bk9wcXh3RHdvUEtKbmxLSzhQSHl2bGEzRXZJQVlObXFzaGFpbnVm?=
 =?utf-8?B?eFdLRTNRTEExV2w1UnVkVnFPcjhXMlV0OUVTN3JOZFBxMk5QS3U4N0pOQllZ?=
 =?utf-8?B?UlU4KzNWeFpjeTRHY2gwV3VKbEdsVUkvVkhvbXNlYkJMb0xPaFhQQS9LUzcr?=
 =?utf-8?B?V3JrS3NQdHljNXB3a1RyQU1FZi9jYlFkTnlBYVVSQkFyckorNEJTUXBLNmZ6?=
 =?utf-8?B?bm4rRmRlWTFjdWliQ09XV1RhY1F6cUNrdlJSN3JUbWFJYUllaFBkcHdMQ3dJ?=
 =?utf-8?B?ekszczg4U3lIbzhDcHNQeGJCUVJsOG1pbWhqRWxyS2lnV2hsVGdEWHJzcHBP?=
 =?utf-8?B?am82djJLZ2NuZU5BMm9obEtrUTcvNXE5Mlg0NHhWeDBXR2Q5SFhML2tnWFJn?=
 =?utf-8?B?VU03K2FoY1JTMEEwMFlCaUpVNHRQL3NwOFZ0elBpak9SalYrZkFUc0ZGcXRR?=
 =?utf-8?B?SEZGOENqNmlsbW9XVUpMZHBtSnlWOTVjb0h3TkhmL3ArS0ZJZlhES29xa2VU?=
 =?utf-8?B?djhJVUducGpzazJQVlNsZjBtemlZYmJlU2JvQzdEVEd1QU92S2p3MCtYSmNG?=
 =?utf-8?B?bjZpamR4bU81YTh5ZmNYaWhlK3NCcGp3aTV5NDlHTXhwdU8zdkFsV3J4VWsz?=
 =?utf-8?B?dVpkRUhrRndhcTVPS2paSXRoeUIwK3NzOXNlTmYwbEZtSXJURWl3ZGZCSmZE?=
 =?utf-8?B?Vm9PajFTdnRhQUFaVjVzV0JiYUIwdlBUdGU0ZWhEeFRMd0s0eHVwclptTTQz?=
 =?utf-8?B?NUgwa1k0UGdpNytLSFlZSGVmdlhyaTZhbGZzMEZnc0NNbktTNUVMeFc3MlZ1?=
 =?utf-8?B?SGU0Uld3VEpIYjJ6UDVOS20zc3NrVjhBTWlwa0x5bGFNUkN0R2lSM0FYWnZh?=
 =?utf-8?Q?ERUxbP5qtffCj63rCQCbBm4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmZvemRDbEhVSlRWRVlvZTk2ejZDTGEvaWl5bUd6bXB1UXFCMEdZZHhLTFQz?=
 =?utf-8?B?SndJY25IVy9xVGdNQXdRS1hxaHhRZVNNaE1ScS83a0x4Nm0rbGhydCtINWZ2?=
 =?utf-8?B?UUVtOGVjck13Y3lWRkl0VGc4WVRoeGlXbTZLMVMrOWhrZ29tdDFqOEFWazNo?=
 =?utf-8?B?U21Od0ZWdmpDVzBaNDg1SncxVHc3NWNGbTZoZWllMnpXNHh4MjV6RFZ6R2hI?=
 =?utf-8?B?MGN2RTVkUHNnSFRUWFlIOWZiNGRIMncrZXg4VzdNaHl0bVJMcWl6ZkNuUkg0?=
 =?utf-8?B?eE5QVHJFN3IzOHdhNjFGaFJBR0FVaTdCYVN6MVBuMHZIalBsd2VBMk9GVG42?=
 =?utf-8?B?eFNTbWtEUmFnOEdKL2xBbzkySkt1bEo4c3pYNklkWFp0b3FnZ29mdDFReHhB?=
 =?utf-8?B?NXNrSVIwZlNld0Zqa2V2b0d1NkdrQnZOeW5SWitmYmo5WDkrbW1UcGRoWEov?=
 =?utf-8?B?c2NkVS82bE1HTDdVMm1tbDhieGlPMVVXaytZRU1WL3hQNUFlT09TaXl3OE9j?=
 =?utf-8?B?cWV1cFo0MnVCSlJIbnJoWEQzU2FIekQxL0d2RUpoTkdTd0RwUC91ck56bk05?=
 =?utf-8?B?WVFqWWFIS3VXNHM1SnFQbldVNmYzdm1uR0R4Vk5kOUlSMlErRjYwZlV4SlBQ?=
 =?utf-8?B?ajZqanM4ZEtxamRKdlJVdFQ2M3JIcmVadzk4MEpIdWU1TUJ0UmxvNDF2a09F?=
 =?utf-8?B?Qm9raUVpN0FQdld6TW12NmdnUEQ3c3dmK1NrOXpSUGJFN0N2RnZOSklUNXdY?=
 =?utf-8?B?N0RRR2N1K09XbWpkT2s1TWEvK2FldFRSdVJKQ2xXSlB0cWpZK2czYkY2TzF0?=
 =?utf-8?B?QXpBaWVwNTllTVZYbnNsTUUxemJOTGNkNmlrWUROR2dKaCt3Z1lIRTlpYldy?=
 =?utf-8?B?WnB4a3RZT0dhSXM2OFRXWlBTSjdPbHYwOGJMdFY4WldwU205YVgya0tpVW5Z?=
 =?utf-8?B?a0ZCVm00UDk3eEl3UTFzS3djNTdlcXFBSTNPUVoxZUM4cDBKMzI0eTFTajZm?=
 =?utf-8?B?MlkrTUhrSFBqZ2pBbFNRSklISElnM0c0dmhvLzRIallMK1l4empvQmRXWVFI?=
 =?utf-8?B?S2VSZ3pDU2FST1QwZGprelVESEpGeElGNmFGRjBTOHFpNktBKzFKUWVSek95?=
 =?utf-8?B?UisxTU9tV2t1Y21YQlZIN0V2SFB6dmhNUmpWS2hsVWtwNHhIUFlTcE1CSHVr?=
 =?utf-8?B?bEVyS2RqS3d4MEpkUnpXSU9oTmpzbUNvSmdkWm9YUWxPcG9nZlFYYjhoalJy?=
 =?utf-8?B?SGhURVppM2h5dHBDYy9hbVJwd1JuUHAwWkgvU28yOFRaVmZZWnZ4KzFJeW41?=
 =?utf-8?B?aWdnYm1SVWdlME43M25EM3hISWZMaWxTdmpWY3lKOG1ORlBVR2lDbFBWN2Zs?=
 =?utf-8?B?cDhVZVJBT0ZhMUxhTTZ3Mzk4M0RoUncxOHhCL015TzZCMWdMcCtJWUIrUnlD?=
 =?utf-8?B?YVVMeWtpdUd6WUtZTWhQZnZCd2pkSXlFYXNmYnByKzFVRjN5WFhya1BBT21Q?=
 =?utf-8?B?Z3BERUpUUEkzemZBMTZPeldGamhsdkRINXRqczJwZWZmSEsrUGhEZ1BxVE9C?=
 =?utf-8?B?N0dQUGhWc3E1VGpyY0RlTkU3REpOMFVqeHkvakYzbThIRWErRndJV3lpT1J5?=
 =?utf-8?B?WmtyQVN3S3dHTUQ3K2dTNGlzMjZFdy9PL1Q4K1hCdXBaNllvWVVTVG0ra1Va?=
 =?utf-8?B?VUNaZU9JbE5XeWhSV1p1UWE4QnVyYnNMWkxjYmhFQWx3R2tIcWNjc1BVbzVM?=
 =?utf-8?B?LzRISkVBejh6ZFZYRVZYZHAxeHdWOFRqdmx5TjNHc1k0d2NKSzBZbHdYa3RJ?=
 =?utf-8?B?U3luTzc3TGkyWmQyc0Q3WjE4QWJBMGV6b1F3WGZFUmhRSG81VTFrYlhSWHJ4?=
 =?utf-8?B?Sy9rMko4YjFQM1hrcjlRVC9lT2N5ZTZuRXFTWE9ndkt0SFp5U2M3TVJLTkU3?=
 =?utf-8?B?SUloQ0ZFSG5XT0pmN1lSaWxpMzJzOWxJRnZObzRweFBydFZlZXFoQkxXY3FO?=
 =?utf-8?B?WkNHdHEya0lFdkZjSjdzKy95b1dqc25SSFVEdDBIZE5INVN1SEZFSWZKUnZn?=
 =?utf-8?B?emVQd2UvRlRIVzFlWnE4b1BNODR1ajNXNHlLeVJmK3Zsd2w0NDJ0Y2pXRU0v?=
 =?utf-8?B?N25qRGE5TGl1d3BYMUpHa3FRaDAxcGZ0TTVRM3RVVndGdTh3Y3lrZUN4czVE?=
 =?utf-8?B?S29VeUFYRmJRc05JV3pyYUw1TjQ2NDJNVmNEMmh4cVcrVHZsT3ZpTDVSUmZz?=
 =?utf-8?B?ZjQ2VXlVdlg4ZDlkc0VMODVyTDVqdkttUVQzRnAxcGFuenNmUzVpOWlVL0pj?=
 =?utf-8?B?L2hqMWp4QzZLR1NGRVE0Z1dqRlIzVkdZcmpiQ0Fnb0pBNHlrRDdpOGdYeG5V?=
 =?utf-8?Q?RMJIs+ytgioaVo4Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6DBD7BBD5EC5C45AFA5C8B72B0F9ADF@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c0ea9a3-35ef-438c-db76-08de5a482bae
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 06:25:14.9849 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TAVNGljnuw3WwsgkFq4Tcxc4mzTND48qZLWDps8LjbQi3a0JiddND4H1+NNRcRYdzbKYuL3KQ+RgUVPUzHkqvEbs7Nrivm1kX4JRB4z/3UU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7650
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

T24gVGh1LCAyMDI2LTAxLTIyIGF0IDE3OjM4ICswMTAwLCBKdWxpZW4gU3RlcGhhbiB3cm90ZToN
Cj4gRnJvbTogVml0b3IgU2F0byBFc2NoaG9seiA8dnNhdG9lc0BiYXlsaWJyZS5jb20+DQo+IA0K
PiBBZGQgcGlubXV4X3Byb3BlcnR5X3NldCBvcHMgZm9yIG1lZGlhdGVrIHBpbmN0cmwgZnJhbWV3
b3JrDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKdWxpZW4gTWFzc29uIDxqbWFzc29uQGJheWxpYnJl
LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogVml0b3IgU2F0byBFc2NoaG9seiA8dnNhdG9lc0BiYXls
aWJyZS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEp1bGllbiBTdGVwaGFuIDxqc3RlcGhhbkBiYXls
aWJyZS5jb20+DQo+IC0tLQ0KPiDCoGRyaXZlcnMvcGluY3RybC9tZWRpYXRlay9waW5jdHJsLW10
ay1jb21tb24uYyB8IDEyICsrKysrKysrKysrKw0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNl
cnRpb25zKCspDQo+IA0KDQpSZXZpZXdlZC1ieTogTWFjcGF1bCBMaW4gPG1hY3BhdWwubGluQG1l
ZGlhdGVrLmNvbT4NCg0KVGhhbmtzDQpNYWNwYXVsIExpbg0K
