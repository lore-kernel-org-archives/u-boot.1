Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53DFBEBFD1D
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 08:52:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91103836AC;
	Mon, 13 Apr 2026 10:52:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="qzpd5zuQ";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="QJRjn0+v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60E07839D5; Mon, 13 Apr 2026 10:52:42 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3395D8352B
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 10:52:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: 197cd90a371611f1ae70033691e9ac7d-20260413
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=gmPFQKjJ+a4icpd4YyhPHzeJR+kDJItrDK9/3i41KOU=; 
 b=qzpd5zuQgJGfPu2AOqPh9T5pevfg5gfv982OKurEMWo4bJWcyCgIWYpwsCMci9bRMjB1X2s9Rui6eFoar2jbheoiFx2x3XUTVTkxL127g3dqqmJ/6pkvRGZd/Zwn10fvIJrOlcWrhUslHnaR+F4+V2HJ2cRHhttNPS3Ooim7dnM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:2e82ca68-dd64-487e-8863-01030f6e477e, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:762f5c8f-6df4-4a3d-a7a4-fbdc42d669ce,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
 898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
 l,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 197cd90a371611f1ae70033691e9ac7d-20260413
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw01.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 798466110; Mon, 13 Apr 2026 16:52:28 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 13 Apr 2026 16:52:27 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 13 Apr 2026 16:52:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tEHYMHFn5VorwOfQehQc+d1VXJPTz284SPKdO4EXshCsyY1Y21YOMJrZtJTFMw7gJ9FjOxOowflVHHW2Pl4LjsrUiyY6POCmUfIx6bIp+4QIVLHEypo/ixtkgJCxM9J3p7LqdyHrIk/wesucpRqOq34IMDAR/k5sDKBJC7TYnY1xzolBaWVRTtsCsdz9i0MQmnNNxOYWpu5lVo6TlWG7Jcwdy6uNNTaSEyz/7JscS3YVrt7O2B0wa/pMqu9LR30dxSQaLkGraJl9Xdo5eAh7BDtt9MmuTad5Ua+ITrhGRbz6O70iWMHlxSkuJs5/+oA0IvsO0LBiGTojxPAGsaE26w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmPFQKjJ+a4icpd4YyhPHzeJR+kDJItrDK9/3i41KOU=;
 b=u62cgx3zmGvjgcKYA/nG6Ds2j+mIA78JiABDTWeSwyNWBvgGHXzxz3GRAEEZBQlBaLzGavYiBnJqOlJ0rfASdXSh5FQITMRDiDs8JO+WbuW1DSrtL03IbZ3sEh5HG6tIlRQ4nt5UaSkKLo22XTbFPD+0YsFJUtFCJoL7HzezzRTX3rNKwgxF7NOyXzIFgcBpKnyHgOlGSmJ92F7S6c8kOvYR2IUcuqyXMIpn6av2x7+Ouc6qBylrGpgPFWGwOL96cm27i8BekMDb1On2w/jYnTq8UJK0I+3cGXQ68HHEZFHTe6yrWga0iDMxajCAopEnxLdnhazRDSmlbVx6z/HaWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmPFQKjJ+a4icpd4YyhPHzeJR+kDJItrDK9/3i41KOU=;
 b=QJRjn0+v/lnp3eQb320lTcm63jy6rs86QDS/MpORODyT8+1NIfB907bBU7+Fr/UEl8qWXUP7sPHs4YI6UqFiNlpCAXl0Y1LH1R7HYIgzHUrKvX1OIHo3lcofJ2b6Yt/yOi8PcuOsx6UVsWGly/QH0a7Bjm3iLYWnF++oskGtFdQ=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by KU4PR03MB9855.apcprd03.prod.outlook.com (2603:1096:d10:7b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 08:52:24 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 08:52:24 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: David Lechner <dlechner@baylibre.com>,
 =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "trini@konsulko.com" <trini@konsulko.com>, Ryder Lee
 <Ryder.Lee@mediatek.com>, "peng.fan@nxp.com" <peng.fan@nxp.com>,
 "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>,
 =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 "jh80.chung@samsung.com" <jh80.chung@samsung.com>
CC: Julien Stephan <jstephan@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, =?utf-8?B?SmlsbCBDaGFuZyAo5by15paH5r2UKQ==?=
 <Jill.Chang@mediatek.com>, =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>, =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?=
 <bear.wang@mediatek.com>, =?utf-8?B?Q2hyaXMtcWogQ2hlbiAo6Zmz5aWH6YCyKQ==?=
 <Chris-qj.Chen@mediatek.com>
Subject: Re: [PATCH 1/3] power: pmic: mtk-pwrap: add init capability flag
Thread-Topic: [PATCH 1/3] power: pmic: mtk-pwrap: add init capability flag
Thread-Index: AQHcvhySW1xumiAUU0ukFc+xDVA6L7XcyXeA
Date: Mon, 13 Apr 2026 08:52:24 +0000
Message-ID: <36ab27696da25625d5ecf3051ad4a159babebdc7.camel@mediatek.com>
References: <20260327-mtk-pmic-fixes-v1-0-ef874ca82409@baylibre.com>
 <20260327-mtk-pmic-fixes-v1-1-ef874ca82409@baylibre.com>
In-Reply-To: <20260327-mtk-pmic-fixes-v1-1-ef874ca82409@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|KU4PR03MB9855:EE_
x-ms-office365-filtering-correlation-id: 6ef3a54b-aaf2-432c-8420-08de9939fb6d
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 4fTGY7IC1b0sI3Fo1KuA9WKSBZB1dgJtWw7hYkDfcSAnOV1YXGaQzg9rBpgZP8KdadPfJmltDwYiVCkRXhvyXyarnOA0KB7n3Y+V1J+DaUU0J9OhvU1XOvbrUJSypQ3GnyDmJLX+ZrnVdLp/p3kl03eyfDUUU9j0pp0EORKXQSJQwM1h7/w01r6HH4qiqY9hJUs1ZgwCrT/arvy299QXThA8Jb2atb/4wON2qCJdJpKUWDgttDzoaqmVyrN17MiRUzRqSS+H7DaYLn/xw8VYz+EKwNakOrcu6wqaalW3N/kRRiaOV51a8nXjAzSpYr1fxsDG+ZEjQLWZsXm1DTT9kZ5ddwES44Z9YEIGUD7/SwOh1hU7nQogt+m8/hODoXXZXn47o1HfelBy988+B9EI57C7rXTVOovb3BwAXSZGFrOJ6cxHO4QX94a4TmZ3ltjZdFODskB6kCHiCn9SZI6qSKD1uxr0DZcUvNo2IGoEAfT4AtXYSsKaYivFHO4cyZh2Ke7o49FZL4Yl3cohfamExmkqOgfxVswx/cuVJOgnJxWGRk53HckqXnE3qxyilOUPHs1rg5Ga67dm4fJkA3JublYVxK3PEQlzDC4eaYdctHK2WwJqNgBDwBbkfYasRAHJj1vSdE/q3MQXrdRB0JfD0mfwoK278juio/4hHaPwcTfO1EX9tSEjcuSDrepB1Dy9a+/3xSoN6DiOicicRvG6v1ykQuHt0638vwFN2RpIkNudB9sj0N4ylzrU50EoNi0RhIFYrq5lRBAIs8vHhdUGLnDVcWHNbgchL1ZpvRQUUrQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0Z5T2pRY0pzbU9BaFJMRThta21ScmxDajEvbW16dW1URzc2ckc4Z3JYRFUz?=
 =?utf-8?B?Zzh6OHV2bktENGIxdmFuaURiYTZoWFVnNjRSdWEzL2o1ejJ4RVQ5UEhOdTl3?=
 =?utf-8?B?enNIMS8vMGgyeXZXSTVsUU9PNjlpNTBhSTY3c3FoYldKTUpaWXNtUklRSzIv?=
 =?utf-8?B?WjhyUzIrSm5jMFh5RkJnMEZhZVZaVTVqK0pSYnl4TW1ZVk5vcStLejJlWVdx?=
 =?utf-8?B?ZWhPZTlSOUNmMm1rWG52TUdzRGZ2cWtNQkhhMVpaMmNwR0J3Ni84b1dCOUdn?=
 =?utf-8?B?UUo3VFF5TmgzZ3pKVkFKWDdFVGJEaUpPa0RVMTQrOEZNVmFvRXd5RGc2bmlS?=
 =?utf-8?B?NVpxOWRnTmQ2WEJQK21FQ2lOZmRSQi92czV5Wk1NS3ZqYzBxMjdZblFJUjQy?=
 =?utf-8?B?MVMvNmg5RWM0UVo1bngzK3NzMTNGaHdWcnlyVDg4QW5uSDNXYUphZWFZN0d3?=
 =?utf-8?B?bGF5ZW1pdmxwNEFIWVhCdE9aOGFISEg5UUk5SnMvL2h6YXhUY3lIRXFGdHVE?=
 =?utf-8?B?SDNxQTFLWFBDL2hrVXIvSTFERjFxVThHSGpUMHMrRjMwMkxCTU5Ja25EdGUx?=
 =?utf-8?B?UmR1TjVVR0VOekJmaVJjQXVTaG9Ga1NLU3AvNkJpOGdGU1lpclNUMzIvSFFt?=
 =?utf-8?B?eGo2RVMxVktTMnJRS2doditYZFlPWGVldVRYekVHdUR5bENyYjBBWFAreEs1?=
 =?utf-8?B?SDdoZEQzMmxvWDcwLzI2NGNndm84YklhdnNUT0IzcWZxRFFXeldXY2NaVjBD?=
 =?utf-8?B?UEpFZ0RjOE9rR21GZi9RSzlWWkhLRFQvMDhUSEhYVCtCNkRHWHB6bzI5N3Ez?=
 =?utf-8?B?UXVLVThHbWNiZjhiSDEza3hPYVdVOWs3NUlKNHlCSytFMDM3NGNsSTBrbUFO?=
 =?utf-8?B?YzBVd2FiTWN4VTNLMjNDN2o4WUJndmdoWUF0YUZVa0ZaUlN6Sm02UzFDcDlU?=
 =?utf-8?B?bGVhR0NCcmpQVVhYaGJHRTM5QmxOa1FPV1I1TEE0cExRZFBwVFJiaTRtT0k3?=
 =?utf-8?B?OHU2dndhZ0dYU1ZQRDJxdUtMT3ZrZDVqazFnUWM3UmZpUmE4c0FKbndQRmIv?=
 =?utf-8?B?UEl3WHBPdjYxd3hDVXg0QW9mQmRxUy92ZlVOYkdtcm9zUm13RXR6N2lZRDdo?=
 =?utf-8?B?VjlYaWdaZksxVmpFS1Zod2xaVFMrbjlXb0RRcWlONWFNN29WYm9iRThqaVo5?=
 =?utf-8?B?aTlWUzZ3TXZjRDh6U1NwdUdlbG5GMlVsRUVKbTZtNGN6cVcxajBFK2gxbG02?=
 =?utf-8?B?cTFpalFEYU11WVJMa0xLVkhpck5ZeGdJbmo1bnY1MmNRRTUxRG83T3FrWCsv?=
 =?utf-8?B?aUVlRnlSRXZRRGpTMW1XNnFHSk5iU3gzdFYxeFk4anZKYnZNYlNhTWkwaWhG?=
 =?utf-8?B?V0RoRDJmOHBPV1N4YXhLbFBnUEYyaUJBcmpZTU52L2o1TXAzSnlwQ0pGZ0du?=
 =?utf-8?B?eDgyQUJpS215V21DRW1WNy9zcWMxeUFlcEJNMm9sbmNWa1VjVzJ4Qk1acVEz?=
 =?utf-8?B?eFhCb2ZicHhhNnJNVXh2TEVHaXpsWjhjUjJ2aGozZ01SSjVpb2wrSWU2cnlP?=
 =?utf-8?B?eGlGZmt2bmxyUkpIOS9sU05jaGRqTEJ2THlEUVZuakhyMjZFc2RteU5lQkFH?=
 =?utf-8?B?UW81N1V1WUdUaUEydTdwRjZEdUl6emsrRDBKV2JSMXVCeUpidWVJYVR5eVQ3?=
 =?utf-8?B?NkJDY3JuV3d2RkI3enFEcFdkdEdwN2Z6YnJIcHhSNnNxWW1Qd2YrTGpwdUFG?=
 =?utf-8?B?M1UyNTdhVmV2eG10UTAySDE2L1RnR2x1Qmd1cmsxVjBML2IvUnIrdkxteU1H?=
 =?utf-8?B?VCtzcDBQZm1ZMGRWTk1seDVEV09yNnBENnZ4SWtzQ1ZLeVl3Q1kxV21Td0dm?=
 =?utf-8?B?ZFlKZWhnU0xKaWU0RUNzZHFZTnVJdTJ5eWthQm1IV1lyRko0WnA2Szl2aElI?=
 =?utf-8?B?NWR6Wk5YKytTSUFSRkJuVFp1L1cwVDBYUWtMaDJqUHplbjZMTGxBNnRiK3Nn?=
 =?utf-8?B?cjljSEREdDZ3d3ZsSjlGMy8zamd4cnhZSzNJdzdyUGxqeDdQcklyQXdQR1Q5?=
 =?utf-8?B?bVVFdXZ1Z1RyUXNFbVdrVjN5SVJiTVJYOXkzdnlqYjJ0cFhIekNaeWdLL0RL?=
 =?utf-8?B?VkF5UTdtM0dnUGZMSmNUdzdseUMrOWVYQVlWRWJzV0ZRYXpRb1RRKzZhTnVK?=
 =?utf-8?B?eWt0ZGFYenVtVDNVeUtJNHR1TTNvK1hrWndCL2thNGNMeDM5MDVvdVhyc1k0?=
 =?utf-8?B?Zi9Ld3FKaEh2VEcwbGo1RHdwRUk1a0toVlRLdnRyU1ZDWm9QdHJXeUtkM25H?=
 =?utf-8?B?Nm8yUDdheEt0TDI5UFNlcFNjUFl1UkU4TjNhVnE4cDhKenRnT1NKOTlPcUpI?=
 =?utf-8?Q?gwf1zuNiCpBR7zRw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9D319FB2C2EB5469DD87BB1B70336F1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VqjYcWevyaeJwxso4ZD6WEu+7yY8hXor98n61lclNjP2Ywt7/BGyasifGARZV7qIBW906FXcKUrSoFcJ2jfwiX1ir9IKXU423ZMQxYAtATp4tl0MMFnDCFAWX+zvTeLLQxsq+EuWJzWWmt+OFPIIHsMNAMsrfQEOD2XcroUkaLTEgWcDQBRaH1gDMb3zQwwTRwiw4BigsYxddO8brVLynT5aKJ7P3foDirFfOIEZZ4DruiL6CzQMueviqQOS9/FhEDKJmJoTPVU0uJ56UkCCWidaHuoGACP13kp+EmPjGs6J4S9mD6AgeraBl83Z74MWycgMkA0Ca3VbG2YDU+m9RQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef3a54b-aaf2-432c-8420-08de9939fb6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 08:52:24.3014 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2boaJqfx9Npoyi2X8Pdx7Jjtc8l1sdPJuGPbXj7L6jKB9IkEaybD9qmo5ovjaaTzPbqLITem69bpY9dP/CeaMuh0wgl8tLYrMTIEypwroyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU4PR03MB9855
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

T24gRnJpLCAyMDI2LTAzLTI3IGF0IDE0OjAzIC0wNTAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOg0K
PiBBZGQgYSBQV1JBUF9DQVBfSU5JVCBjYXBhYmlsaXR5IGZsYWcgdG8gc3BlY2lmeSBpZiBpdCBp
cyBzYWZlIHRvIGNhbGwNCj4gcHdyYXBfaW5pdCgpIG9yIG5vdC4gTm90IGFsbCB0YXJnZXRzIGRl
ZmluZSB0aGUgcmVnaXN0ZXJzIGFjY2Vzc2VkDQo+IGJ5IHB3cmFwX2luaXQoKS4gSW4gdGhhdCBj
YXNlLCBpdCBpcyBleHBlY3RlZCB0aGF0IGFuIGVhcmxpZXINCj4gYm9vdGxvYWRlcg0KPiBoYXMg
YWxyZWFkeSBpbml0aWFsaXplZCB0aGUgUE1JQy4gSWYgbm90LCB3ZSBub3cgcmV0dXJuIGFuIGVy
cm9yDQo+IGluc3RlYWQNCj4gb2YgdHJ5aW5nIHRvIGFjY2VzcyB1bmRlZmluZWQgcmVnaXN0ZXJz
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGF2aWQgTGVjaG5lciA8ZGxlY2huZXJAYmF5bGlicmUu
Y29tPg0KPiAtLS0NCj4gwqBkcml2ZXJzL3Bvd2VyL3BtaWMvbXRrLXB3cmFwLmMgfCA5ICsrKysr
KysrLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Bvd2VyL3BtaWMvbXRrLXB3cmFwLmMgYi9kcml2
ZXJzL3Bvd2VyL3BtaWMvbXRrLQ0KPiBwd3JhcC5jDQo+IGluZGV4IDQ0NmI3OGZiMGVlLi45ZmYw
NmZkYjNiZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wb3dlci9wbWljL210ay1wd3JhcC5jDQo+
ICsrKyBiL2RyaXZlcnMvcG93ZXIvcG1pYy9tdGstcHdyYXAuYw0KPiBAQCAtNjIsNiArNjIsOCBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IHBtaWNfY2hpbGRfaW5mbw0KPiBtdDYzNTlfcG1pY19jaGls
ZHJlbl9pbmZvW10gPSB7DQo+IMKgI2RlZmluZSBQV1JBUF9DQVBfSU5UMV9FTgkJQklUKDMpDQo+
IMKgI2RlZmluZSBQV1JBUF9DQVBfV0RUX1NSQzEJCUJJVCg0KQ0KPiDCoCNkZWZpbmUgUFdSQVBf
Q0FQX0FSQgkJCUJJVCg1KQ0KPiArLyogVG8gaW1wbGVtZW50IHRoaXMgY2FwYWJpbGl0eSwgdGhl
IHJlZ2lzdGVycyB1c2VkIGluIHB3cmFwX2luaXQoKQ0KPiBtdXN0IGJlIGRlZmluZWQuICovDQo+
ICsjZGVmaW5lIFBXUkFQX0NBUF9JTklUCQkJQklUKDYpDQo+IMKgDQo+IMKgLyogZGVmaW5lcyBm
b3Igc2xhdmUgZGV2aWNlIHdyYXBwZXIgcmVnaXN0ZXJzICovDQo+IMKgZW51bSBkZXdfcmVncyB7
DQo+IEBAIC03NTIsNiArNzU0LDExIEBAIHN0YXRpYyBpbnQgbXRrX3B3cmFwX3Byb2JlKHN0cnVj
dCB1ZGV2aWNlICpkZXYpDQo+IMKgCSAqIFNraXAgaW5pdGlhbGl6YXRpb24gaGVyZSBpbiB0aGlz
IGNhc2UuDQo+IMKgCSAqLw0KPiDCoAlpZiAoIXB3cmFwX3JlYWRsKHdycCwgUFdSQVBfSU5JVF9E
T05FMikpIHsNCj4gKwkJaWYgKCFIQVNfQ0FQKHdycC0+bWFzdGVyLT5jYXBzLCBQV1JBUF9DQVBf
SU5JVCkpIHsNCj4gKwkJCWRldl9lcnIoZGV2LCAiaW5pdGlhbGl6YXRpb24gaXMgcmVxdWlyZWQg
YnV0DQo+IG5vdCBzdXBwb3J0ZWRcbiIpOw0KPiArCQkJcmV0dXJuIC1FTk9ERVY7DQo+ICsJCX0N
Cj4gKw0KPiDCoAkJcmV0ID0gcHdyYXBfaW5pdCh3cnApOw0KPiDCoAkJaWYgKHJldCkgew0KPiDC
oAkJCWRldl9lcnIoZGV2LCAiaW5pdCBmYWlsZWQgd2l0aCAlZFxuIiwgcmV0KTsNCj4gQEAgLTkw
NSw3ICs5MTIsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHBtaWNfd3JhcHBlcl90eXBlDQo+IHB3
cmFwX210ODM2NSA9IHsNCj4gwqAJLmludDFfZW5fYWxsID0gMHgwLA0KPiDCoAkuc3BpX3cgPSBQ
V1JBUF9NQU5fQ01EX1NQSV9XUklURSwNCj4gwqAJLndkdF9zcmMgPSBQV1JBUF9XRFRfU1JDX01B
U0tfQUxMLA0KPiAtCS5jYXBzID0gUFdSQVBfQ0FQX0lOVDFfRU4gfCBQV1JBUF9DQVBfV0RUX1NS
QzEsDQo+ICsJLmNhcHMgPSBQV1JBUF9DQVBfSU5UMV9FTiB8IFBXUkFQX0NBUF9XRFRfU1JDMSB8
DQo+IFBXUkFQX0NBUF9JTklULA0KPiDCoH07DQo+IMKgDQo+IMKgc3RhdGljIGNvbnN0IHN0cnVj
dCB1ZGV2aWNlX2lkIG10a19wd3JhcF9pZHNbXSA9IHsNCj4gDQoNClJldmlld2VkLWJ5OiBNYWNw
YXVsIExpbiA8bWFjcGF1bC5saW5AbWVkaWF0ZWsuY29tPg0KDQpUaGFua3MhDQpNYWNwYXVsIExp
bg0K
