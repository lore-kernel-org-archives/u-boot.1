Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20955CD37AC
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 02:24:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE19C8467F;
	Thu, 14 May 2026 04:24:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="IkHLmqe8";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="RqnrVIW2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F2ED846A1; Thu, 14 May 2026 04:24:25 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB61C84676
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 04:24:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: 02ab14ce4f3c11f1b5a00d44d12bea5a-20260514
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=ow2FxioMkYeB1kTgh+/HHH0nviYhKMSOV3TzxCRT264=; 
 b=IkHLmqe8NsaNE30lVHGDXe87pXOOmQa/pO94MDT68iS7SgADIWqE8kUZZxKdjdQ2jQr4MpOYjFZ7NeG0yK69jgV7O669k0LCwzQ9M5QsRbZVLHuCqvh1/TL9MXbpSxO3PEce0s6YQUI5hV2OOfOkqRO0niToHVT39OwHxN3R/p4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.14, REQID:f47330d2-624d-44b0-805e-704e214aa162, IP:0,
 U
 RL:0,TC:0,Content:2,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:2
X-CID-META: VersionHash:9091e75, CLOUDID:e0c661c4-1dfd-41c0-8544-20bb494fc627,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
 898,TC:-5,Content:4|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
 l,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 02ab14ce4f3c11f1b5a00d44d12bea5a-20260514
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by
 mailgw01.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1289845255; Thu, 14 May 2026 10:24:18 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 14 May 2026 10:24:17 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 14 May 2026 10:24:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KEQTge/0JeQlDJktjqMnl7CFmguEhX2akchmKcmofmf7OAo3vCiV/Xgb/4fM5d9TuVJaMRr/gl1tPeX3pj6p8ANFgU9dSXsklX+5K4OSl2A7ybC1tV/Cca1GNO9R3+mK2FpYEsurWfe5buiUVTscGSzc3ImYSs95vqMUazLctWDBkhRUlQFBroBrSDvnpK4xTXWNzozkdcNIfddySiKVvxn/RqirmtyFiJFU+SRqMoN0mBDOeiFx20PW42BaIfqwnGrr2Xjsw1YW+y6Gf1rMEFsB7SD7KU6FQmjracL3OtMx7Ek+xF5QI52/yeyxI/cH6c5GUCZlP1icbdUD1sunYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ow2FxioMkYeB1kTgh+/HHH0nviYhKMSOV3TzxCRT264=;
 b=E6Ec9o9K0CE3W9rCzrQ8HYc7MAweB9T+ojq0+cNh3h2ZjykdHy+gUxhSbBvaLX+3OEqfhjTF/Cxiz+OnqggjqsjtsDxBghOSGGoFVxmUZpSBQNxCqTKlyAGmM4NMkZyZ0Z6J7mikntPjfUxCjiGCdffNmsL6/SiqajVJ75u8ryODAtKEEc1TjFF3WTNp32LYwgik0/msv81ojSgtJkzYCcQ3PDaD8GRAYFU/ZcwB8XiksSXGOf4+dOvPFvoSiGLj8PJyELwfXt9yzisP/w8VMEBzhcdEKtDpF1EbB62wG4/skRBl06Xd/dAJzz2rYpFgMnKUAPWLeA1E+lpiKHalDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ow2FxioMkYeB1kTgh+/HHH0nviYhKMSOV3TzxCRT264=;
 b=RqnrVIW2sy7kmWoqLG4k+1Wpl0a29pAOIRAELlA50kdq+k7ETTC3XTNN3nOP/mpmoPaUe9qaOYAdrv9Ac0fI58S+g+Ggblyr72P6cUa94+cAVjpFeSo9seFLOsAMNZwX4wPvr/Ic9t1fdGhefM9GWy6gMJvP0emZQEWTKmmtz/M=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by KL1PR03MB8238.apcprd03.prod.outlook.com (2603:1096:820:108::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Thu, 14 May
 2026 02:24:14 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.21.0025.012; Thu, 14 May 2026
 02:24:14 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: David Lechner <dlechner@baylibre.com>,
 =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
 "trini@konsulko.com" <trini@konsulko.com>,
 =?utf-8?B?UmFtYXggTG8gKOe+heaYjumBoCk=?= <Ramax.Lo@mediatek.com>,
 =?utf-8?B?SHQgTGluICjmnpfngJrlrpcp?= <Ht.Lin@mediatek.com>, Julien Masson
 <jmasson@baylibre.com>, =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>, =?utf-8?B?Q2hyaXMtcWogQ2hlbiAo6Zmz5aWH6YCyKQ==?=
 <Chris-qj.Chen@mediatek.com>
CC: Julien Stephan <jstephan@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 2/3] configs/mt8195: enable bootstd, FIT and DT overlays
Thread-Topic: [PATCH v2 2/3] configs/mt8195: enable bootstd, FIT and DT
 overlays
Thread-Index: AQHc4l9M2s1IniSg60S23MGnX5wH87YMzMOA
Date: Thu, 14 May 2026 02:24:14 +0000
Message-ID: <99b2eec5a4bd0bf3c085ab21a4dfb210f5236c83.camel@mediatek.com>
References: <20260512-mtk-genio-defconfig-v2-0-bf4c30ef7f14@baylibre.com>
 <20260512-mtk-genio-defconfig-v2-2-bf4c30ef7f14@baylibre.com>
In-Reply-To: <20260512-mtk-genio-defconfig-v2-2-bf4c30ef7f14@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|KL1PR03MB8238:EE_
x-ms-office365-filtering-correlation-id: a318367f-502e-403c-2dca-08deb15fe453
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|56012099003|18002099003|22082099003|11063799003|4143699003;
x-microsoft-antispam-message-info: a3hJnqnOJU6RaRqfn3OCuJNxqsRBFrHEPs+jACcMk2DKev5LiqIFizjVWxwvaRodT33xy4Tv0M1GZ14P3hiuhp50hnr6tgTdBXuqs0x2/eo+qh2EUgmcoXb+sDWqNgSKbJ0Qnc3ECwJ/nvHFG/SkjBhAvUHcKGTCElsFm3AxvikbRM99LW0ZqydUk05jVrIz1L0jEa4bbZ9wYD/eV6bVTL9IyFtp/MJidLCHyEVSwwJuo60fN7I+0Hy0uuYflqRYXVJunEniwSJCbFUR2DWPalgsjbBYT3bBk4E//93M75ktvt3JAtKcLUwpq3pjGqE2+Z44AAN8ktEMwhkbj/kQ28cRuaojkZAZbr0GUO47T8lLz5XcYVaqYsOZESzYZXkbAyshVvRePwvnco/RioNk8lBGfvphq8QHfRT+A/4HesGYudDStVMi4gokkLfHpw692Ku9/bpWEHseKhTaLyR2OSxyMmQflaC3eOOrzrZKOFkpZnzzdEqtwQBcXy/sT/7/T9R1+4quaKd2S5Fq3A5/TdTBtTOxY1DGXPXqey9nWhpIhSRyye7/wEiD+rujWu/mirn9hEyjllzhsHhUsPl1B0lIxwDv/Ex8MpClkjwL+nMwVKFTgNmp2jAHGXJYUY/loX/qDQXtjU8lMexFLKp3gn0shfPPhbmq9HH41sMOf4btgv3ca9CiJrs3RFEDPLjT1wnmZ5/PPPQ8QL+JnZt+ErpYDRNQPSzI4T2sRz0Jo3Qh5neVEUML8p6ExlAQXtYY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099003)(18002099003)(22082099003)(11063799003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NDFUczMrQzM2bmJSR3c2cHo4ZE9qeU1BZDBEV2pxZ0prbTd0bUxFNkQ3TE0y?=
 =?utf-8?B?NHkwb1RITjJpZEpTa29zOVhFa3E3YlFSWS84UE9jWHRZQnBSYjdHVEk5S3U0?=
 =?utf-8?B?NDRQUnZWM3I3d1JQbzl6YXJaRjAwZ1hPQi84TzJJSDFXVXlQVXpFZk9nLzQv?=
 =?utf-8?B?QTdmeW1TSzJDVkdxei9MZDVtZVBrcTgzTlpZd082TERQVHFDMVNlZ1djUGdq?=
 =?utf-8?B?ZmV0a2hGM0NxQ293OEZsN3ltSnpLVjdqYTJLbCtLL1dyT0lnTnMvSFVhZjNm?=
 =?utf-8?B?dmY0NHRhQTNrQVVJUS9ReEJTdEZzc1VNS2RrOHBXVTR3QlpwS0g2OEpORXFo?=
 =?utf-8?B?T2dPSk5qS0dZWkpEaU4rWG1mSEI1YXgwZHNBMUE1Z255Vm9xZFVqNXFGMWdV?=
 =?utf-8?B?cWdpb0dFNmoybTZud3FpS3JrTXY3U2RyS0dxbG9YTFpySFpmWXdPd2dIckk3?=
 =?utf-8?B?b0sxejBmV0NiSFAxRm91RWw3ZWxpNHBtRzl0SDYyWWxuVmNjS1FpdVhvWE9t?=
 =?utf-8?B?NFY3dDVQOEhDNjQ5NUNleUswNXQxN1c1VlA5a1RMVkNmYzZaSTF5RkNSMlpt?=
 =?utf-8?B?VjlvVHJ0N3FtZnFCQ3lKQnJzU0lWcGxUOEVCaldvcFdwNFBBc2ZoaUwrQ3FK?=
 =?utf-8?B?NGdWZGJGWkJXdlFxcnd4UG03a1krc0ZOUkV1UlZLVkttQ3hjMm1IYVRsbVph?=
 =?utf-8?B?Sk5raFJxWkRoWFJWclVTVjZvU3lNU3JPVFBIVGpGZ0NnbGhSTHI4Z2pDOE5p?=
 =?utf-8?B?QnhTMlNmdjc3WEN4UGpSeTN6TEpYUUp5eXFzbFYwZ05xWm1XQ1FCNkhhUVRQ?=
 =?utf-8?B?clJicUh5aVlwOUhJb2dhN2dKOWhWcHVnaDhuZ0RCT1Fna2cxL01mRmVSYVRp?=
 =?utf-8?B?bDZVd2JSbURzNHVsQW9ENnhyMERPOHBsajA3d05TYTd6cXNYZWJkT1hUMXlz?=
 =?utf-8?B?S1ZBblBPTWx2VVBnOW1FZURBdWF0TFdtZm1PR2Jocm84bkxoaG90b3VucjE0?=
 =?utf-8?B?Wnc4eks5SkZPQjQ4QlRMSHQ0S2htRHpEQnZyMzlZQWlhK3loZEV3eVVNbmtT?=
 =?utf-8?B?M3YxOStNL3B0SE1NZTVENjR6NHBmM2JNZi9VYmhGL3pGNE5aVFBhcmR1Nm9W?=
 =?utf-8?B?MFVHYm9KNzJuWTBKa2lXMTNZN1RlVVdUcUs3a2lDRFMvWmgyZTlsOXdMM3J2?=
 =?utf-8?B?K1Q2ZU44VUUwMUoyc0EwbFlTQkFSVCtSLzhBajJ2dWpwOTVYY2t5V1k2cGNp?=
 =?utf-8?B?QlNzVXZrcUhhbDM4UmJvTUtLRjh5S2lWM0hJaXFDQWNoMzZlR3lBblgxRkxj?=
 =?utf-8?B?V1EzMXdJMG04NmU0TEJPTktvc2E5a0FzTXdhVjhHSFViRStUa2tmZ0syczk0?=
 =?utf-8?B?S0o5Q1VVRXE5Vml1UGNXeUQ1d2RldmVOcCs0TVdBOGY1MTNOaXpPcjkzbVlZ?=
 =?utf-8?B?dGg5a0dVRXZDRk9YRTllR1FRRW0zdEp2REFVMnFpZlJhRVBUMkprRTdYelQy?=
 =?utf-8?B?MWJrQS9lcDJNVER0bEtzWE9CVzIrc2JQdkMyVytuYm1lSkRFdnExcXBmMkdY?=
 =?utf-8?B?a3VTWk51WVhpcTd2OGdxVjJYNnNGYThHSFUvK3NuZUJ1LzhRR05sdytJSnpP?=
 =?utf-8?B?M0FldmsrKzJYUzZBT0NPWlgzbUJOV082WFRCc2xJd3hnNG9OYjNtUTNyQUtO?=
 =?utf-8?B?SlFxN3Riei9URGdkOU5xVDZiNlJqU0ZTTncyQUhzWWRrdmZVUVNncGtoVW9r?=
 =?utf-8?B?VERZcGdJNUppUCtwQURvNGNFYlhKNXZuNWtKL2VUYURRYjlVTUNBczlxOFZz?=
 =?utf-8?B?K3M4bmRSMTdrWHNsOThHVlRsK3dGTGFyaWtBbFNSYWw0clhZTDFRNXBXRktL?=
 =?utf-8?B?NTJPQU4xbFZVUG9hUE05K25adEgyYS9SNE1yWFpMTjdzckJ3YnhvdndGY0Mw?=
 =?utf-8?B?SnZkR0Z0MkRuaWx2UWdnOXNKdG1MVlVJRzQ0ZDViUEtWOHBUQU8xZkszNm9E?=
 =?utf-8?B?Nlg1MTdZL2RQK3lTa1M3ZWhBNFg5Q1FPcmZVOVkrMmk3VU0xbFd5ZEErTi9a?=
 =?utf-8?B?TlI3OGtRWExEaGg4Nk5ZdllPM0pVNDV5K21XYmFXWkhlay9CYTZqOFNFK2I5?=
 =?utf-8?B?VllUWTUrbnFSU0pETzdjQSt1ZERhUnZjVVJqTDV3TnVFRERvNGdTRmp2bGh4?=
 =?utf-8?B?K09SVGg0Wms4KzE0cEE5UG1UQUhvTzBrWUZHQ0FJN2NOd3BSdTlSQ2l2WW5H?=
 =?utf-8?B?TnVqaVBqNVVuMUtDWTVQNFU1ZExhNmt5aHpYZzVWS1lWWHVPMk96RDIyd1Yr?=
 =?utf-8?B?VEJHa0lxVnZ6YnY4OTZCMVdpVld1YlUvODAxTHFub0lRZ1MyTlZpYVE2VVo3?=
 =?utf-8?Q?uve8nmuQVsSco+94=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <37FFD2F5DA620241AAA788C3C415166F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nu4833CnL/GMNJJAhXHnYARMWwxwPOYppwWOw3tPihcVyx7DZ4nxEPeE0nvJyHW5H5TrdhS4irRF69U3BE6+JVTRTz/Nc8GoFFiwsIHP48ielftiBv9ok18xkQBOpHoKqEHqMv7Q66jDICbiF8GPwflIYKl4eenGb444Db5fBTew9nbPgmXLn91EjZsFXcNTmPKVY+wC55iko4DOC/FU2n0QG2Qv4R0DkZLnz0/ps6hbBa86JR2rJSvCySv8Lsu/jwb5SJ5eYFf1ixwGpqksNnqtDQPTpqwHcIFdJNzB5BOKiKvHuHUK+F7ZZELxBuLEcrQhwBv6pCZZ1c+lvSQT6w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a318367f-502e-403c-2dca-08deb15fe453
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2026 02:24:14.3543 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qDuqsDryjdGXp0oy4uHT6b1mvKAj05bEHb1U+J8dDvfoOpIBllGyToBg8bhIfwUha0bxEClWGTyOtihb3b6ixLYaKsR7ntFjOfOOJxzVfgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8238
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

T24gVHVlLCAyMDI2LTA1LTEyIGF0IDE3OjMxIC0wNTAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOg0K
PiBFbmFibGUgb3B0aW9ucyBuZWVkZWQgYnkgdGhlIGRlZmF1bHQgYm9hcmQgc3VwcG9ydCBwYWNr
YWdlIGZvciBHZW5pbw0KPiAxMjAwIEVWSyBib2FyZCB0aGF0IHVzZXMgdGhpcyBjb25maWcuDQo+
IA0KPiBDT05GSUdfQ01EX1BBUlQgaXMgc2VsZWN0ZWQgYnkgdGhlIG5ldyBvcHRpb25zLCBzbyBp
cyByZW1vdmVkIGhlcmUNCj4gc2luY2UNCj4gaXQgaXMgbm93IHJlZHVuZGFudC4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IERhdmlkIExlY2huZXIgPGRsZWNobmVyQGJheWxpYnJlLmNvbT4NCj4gLS0t
DQo+IMKgY29uZmlncy9tdDgxOTUuY29uZmlnIHwgNCArKystDQo+IMKgMSBmaWxlIGNoYW5nZWQs
IDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2NvbmZp
Z3MvbXQ4MTk1LmNvbmZpZyBiL2NvbmZpZ3MvbXQ4MTk1LmNvbmZpZw0KPiBpbmRleCBlZDY2ZWEy
Mjk1Ni4uMDNmNTdkNDY3MDggMTAwNjQ0DQo+IC0tLSBhL2NvbmZpZ3MvbXQ4MTk1LmNvbmZpZw0K
PiArKysgYi9jb25maWdzL210ODE5NS5jb25maWcNCj4gQEAgLTQsMTMgKzQsMTUgQEAgQ09ORklH
X1BPU0lUSU9OX0lOREVQRU5ERU5UPXkNCj4gwqBDT05GSUdfQVJDSF9NRURJQVRFSz15DQo+IMKg
Q09ORklHX1RFWFRfQkFTRT0weDRjMDAwMDAwDQo+IMKgQ09ORklHX05SX0RSQU1fQkFOS1M9MQ0K
PiArQ09ORklHX09GX0xJQkZEVF9PVkVSTEFZPXkNCj4gwqBDT05GSUdfVEFSR0VUX01UODE5NT15
DQo+IMKgQ09ORklHX1NZU19MT0FEX0FERFI9MHg2MDAwMDAwMA0KPiArQ09ORklHX0ZJVD15DQo+
ICtDT05GSUdfQk9PVFNURF9GVUxMPXkNCj4gwqAjIENPTkZJR19CT0FSRF9JTklUIGlzIG5vdCBz
ZXQNCj4gwqBDT05GSUdfQ01EX0NMSz15DQo+IMKgQ09ORklHX0NNRF9HUFQ9eQ0KPiDCoENPTkZJ
R19DTURfTU1DPXkNCj4gLUNPTkZJR19DTURfUEFSVD15DQo+IMKgQ09ORklHX09GX1VQU1RSRUFN
PXkNCj4gwqBDT05GSUdfQ0xLPXkNCj4gwqBDT05GSUdfTU1DX01USz15DQo+IA0KDQpSZXZpZXdl
ZC1ieTogTWFjcGF1bCBMaW4gPG1hY3BhdWwubGluQG1lZGlhdGVrLmNvbT4NCg0KVGhhbmtzIQ0K
TWFjcGF1bCBMaW4NCg==
