Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6682FCD4F21
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 02:22:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8A528467F;
	Thu, 14 May 2026 04:22:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="aVGR58wB";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="JssbdF7S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 251238468B; Thu, 14 May 2026 04:22:04 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 970F684676
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 04:22:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: ab2d8aba4f3b11f1a3561939bc42ff46-20260514
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=iKWzkIyYOZk4S2SmD2yMdmDgs209QAlps9tLSx5qePs=; 
 b=aVGR58wBQd03/UVH3qXKiit2f1zN9+KPzII0SPrnNCyVDYvRG35QACZpUFNRqUJOr+hDkvjbv8mz+oUJOqroYHSj8sef6evKKLB3G0PNWafHczZNUcDd/yMpS8bQoEZ09GauTp3GUXvDNwoXJmM4WNFUkh2Wc2Gxu42Uy719Yoo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.14, REQID:2aee8041-fadd-4f0c-b7e9-3d1cdd1f94a3, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:9091e75, CLOUDID:f0bc61c4-1dfd-41c0-8544-20bb494fc627,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
 898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
 l,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ab2d8aba4f3b11f1a3561939bc42ff46-20260514
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw02.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1229815684; Thu, 14 May 2026 10:21:51 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 14 May 2026 10:21:50 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 14 May 2026 10:21:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Enanop8vqqiMyojDPwLWwDp8BBxzDCmjfAdadcr10asyQon3v6UaLec9IMJoiWOWd4X9J4xkEhrDaVu28V/8m+kR7SYT3+fp53uarHFTg25FHOoLwMzjL8Hi0Lcu2Nz2uyYSC7znKzsgLONpgi390ATIlPNzCwXcLqMNok23YjsRNfCN699DM/ql83HuH8t+N3NfStWTKL1zHXFYo5YPNPGZov3FDHSKQQmFIFRslY1XT78Emq7Y7RoOiIUA5OfXj93ysVvcBxsNkwOIlvC/LFynfFKLh57Ev5Ha8eEyd6u0AFIgPTs97DQpUcsy3eSGWl+MngOJDLBN0/zY1Xu4yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKWzkIyYOZk4S2SmD2yMdmDgs209QAlps9tLSx5qePs=;
 b=G2qvoSvr/lEirnmqDLy7LBc074LQEGBQD3Yh1A/Sn/lTmPeHuh/EDywE2D28uNg/MZJKUnALdLSFEAK0xrithYzKv8a1pAMs/wG6itTAwRK0MFO51dVbrgnvcKRPDiP0wLDSQNrH09LWeAwHiufC9TUFvX+Hp8wAiXWCab+iEoALrEJsCqi1NlNFMNuaV61IeHmzjy2x16idt3rH6zi8sdLtkLhfNy9HKRZQXTUnzgI77Q6tyO/ChV4orlwweeUbzfTwIYHaNLJDi3VveWZvk3+TTsWwQ8X4RIzjc5WyP0zH5NOsoeMJaXBTVyUKE2rwA0Utgpg0caAFYoeXZJorUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKWzkIyYOZk4S2SmD2yMdmDgs209QAlps9tLSx5qePs=;
 b=JssbdF7S5Tzm8zE10sJHOs5TDVO9DyomYA6p/Q32rIlwrHFl/K+7cgrC9EXaqyOdTHVO7BJ95qOEu3tD13s9OQ5+T1eDtxyLDDsahscUN1aFKKGeQ4ApZI3u1M67ceDrXa4AFxu5VMS8waEFovdf/axjmz7yXji1Ol6oYIitdgY=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by SEZPR03MB8183.apcprd03.prod.outlook.com (2603:1096:101:196::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.17; Thu, 14 May
 2026 02:21:45 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.21.0025.012; Thu, 14 May 2026
 02:21:45 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: David Lechner <dlechner@baylibre.com>,
 =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
 "n-francis@ti.com" <n-francis@ti.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "neil.armstrong@linaro.org"
 <neil.armstrong@linaro.org>, =?utf-8?B?SHQgTGluICjmnpfngJrlrpcp?=
 <Ht.Lin@mediatek.com>, =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>, "bhupesh.linux@gmail.com" <bhupesh.linux@gmail.com>
CC: Julien Stephan <jstephan@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: [PATCH] ufs: Kconfig: use bool instead of tristate
Thread-Topic: [PATCH] ufs: Kconfig: use bool instead of tristate
Thread-Index: AQHc4uI95tJm/ntmhUSNMuw5sOb07rYMywsA
Date: Thu, 14 May 2026 02:21:45 +0000
Message-ID: <fbeda482a8b04ebd5875100eb2c920608113fbbe.camel@mediatek.com>
References: <20260513-ufs-kconfig-no-tristate-v1-1-1aa5b53f29a4@baylibre.com>
In-Reply-To: <20260513-ufs-kconfig-no-tristate-v1-1-1aa5b53f29a4@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|SEZPR03MB8183:EE_
x-ms-office365-filtering-correlation-id: e4078af3-4594-4c99-8496-08deb15f8ba2
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|11063799003|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: zr+94rnOroyZ7pDiTIc55aXPNhmCIe7j6IRoQt/gsTxOx/QRCILOVRy39a+6ys3yS+VQselHquF9Kxih6emJ/BdiRFrdYSzLOgwkcEzwlHImeCBk6GB47xPQZLr0I+BIN2USlwphjBxjDa2ejd12uNqTyXM+n7in5BqsxS3lf0+ZWkYh0NH9G7hjOwPhS81I/FJdWfoXzA/JjCvlwdGGMMTxku6ADCxcEgjVZonLyKZuSKSyoGRa1KNTMLJPO2tlXMOxdSxoqGyLCFFFKy9nfGdqD1EEjsoGWvEU3GhEHinRfOA3fDaj3+2Ub0e871jIsw083e1OHkfjNbfwYm2IVBmPBZXS6rhBLb7znmZwHy/2CoaRam31i9rfWEVTI4fO36pElGCbFeMjqRAjmgqhcMWoiKnu9g2MnU4ABnn3tO//fzn/QVWGKB/7thxYGRuzp4Ai/E8qheP2Me2PuHI+uTNf8LPmatd0gzMJTG9UpMlOJceRfXVeAX19Lra/X/3j5QtSjiiw9B6A1HkNHdOnRWHeR+u5g+Dc+daiQJw5M0VechtmpN21MJF7XgL+q08wcztCKhH/1qoXBiBfZWbW/QxMU0fvKgtmegUyhEMnlgi+8xYzGVwApHquq4NX3ZBilXqcc1WC3TshkJ+uJVyZ0P9FGasXhXoO6dJjIIIQoKYTQtZJt6qzLAKXmcoeG6oIpBnwYynv4jCyfBKu3I1+PXExEtxjPjnD038nE3uFvQR5ue22Ykox5qTCzXIRA4hc
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(11063799003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVgrM1hUZHZPL3M4NG93LzFSN2VwdTZETjEyY3RGbTBJekVRcDdRcVhBNklE?=
 =?utf-8?B?Yld0ek05TXBmT3JRWEZ4c2lSZkRpbytzWXh6OFZreUxnSEZoTWE1UWZ5MnRm?=
 =?utf-8?B?SjFqYVdlYTdIVkE4ZzllWXo5Q2VLUFdRN3BVcFU0cHNkZy9RZ1VxQy8xa3Zs?=
 =?utf-8?B?SXFmck1CdXQ2cUpjcVBDMFBacHIyVjA3N1hpWXJiam5oV3djV3E3L1QvblhM?=
 =?utf-8?B?aE9Jamt6VkdTYnlFb1Z3Vkt2V3pJRHFhMGpJOS81SVljYW0vamVWTkgvOXQy?=
 =?utf-8?B?V2lWemJadkZOMTk0SVZ0MEhBTHN5bWZMZVRKZkFPalIwKzh4M1ZLbHdVZ1ly?=
 =?utf-8?B?dEZVbXd3ZldRU1l6d2dnM21pOENGbUFWdXphV0lXdFJFQm1mK0FYZXM5OWxG?=
 =?utf-8?B?dGhMdlVzTnFoQ0QvRFdNWGhKNHVtWjBvdmQzVXdVTjh3TC9JUGo3R3ltRkdq?=
 =?utf-8?B?cmw4RzdtTDN2WHRZSERiKzNnUWRzM3pIYndWTHBqdHNwYTV1czZqaEQ4Z29P?=
 =?utf-8?B?ZTcyVEU2bzdhbElTTXluT0lWcHIrSWQzUEtHZTVkWVJYL3ZKNmw2NXBTMTQ4?=
 =?utf-8?B?ZDZ3VVpXTHdISDFmRmdyV052aVZvM0R4SHFvaitvQlUyVklXUmJLTVRFUVQx?=
 =?utf-8?B?ZFFjQkhMbTlUQ1VqVjZSMGxTNWhnN3pPL2ZFMHJUMnJlR2hGWmFBSW9VS1M3?=
 =?utf-8?B?dVVKTEFkNlNXUk9iSE1kc0RoNStieGtWVHlRUytPUEQzTkUxbUpzbXdnU2Fk?=
 =?utf-8?B?L3NYc215TEcrZzlVV0t6eFoydkkzQ0J2cUhaOW01UkVNL1psSnBXOHFObzJl?=
 =?utf-8?B?b1VKNnY5alk2V0RBWlA1ekF0WU81Y0dOczJ2bTR4TytyWHVUR004WFFLUFFq?=
 =?utf-8?B?eVpsYUJZTUsrVldLRkdYZ0ZWMGVvSG52UEtPOTNBMUpONkVtSTM2MzBxOWhh?=
 =?utf-8?B?dGFmOE5HNUtHZDUrZ1MwczhwN29abzRYTGxKbGN1Z3VhTXpSK0xNZEhLRWNW?=
 =?utf-8?B?ZFdJdDlqNC9nd2tleGROaWJxYTJ1dGNYMlovdFJiRnRJN2FVcFV2RE5zQzBs?=
 =?utf-8?B?ZTYvVW1OWllFT1l3S3llM28wV2lNNmtHMHpMQzdJdndUWlJYUkJpa1JReExX?=
 =?utf-8?B?Wm9ZZFhKT05ybnVYUU1ERHUzUm5hL0lob1llM2tCS3Y2OVBYcElTYk9TTERo?=
 =?utf-8?B?a0xCck1NRFo1QXhhOTl3K3MxemRSbytDTDdxRFlhVEJnYzJ3Nk1FN3NKUzVu?=
 =?utf-8?B?REtiSTUwZ3ZvQlZ1VVFkQ2R1WXMraE85T0tEYm9QL0hoRS9uUkRyQkNXN0lq?=
 =?utf-8?B?MVRHVmc1SlhTQnlicXFjeDdJTkxKcjl5djBDQ24rWDY1SFpWQjFHZzI2Rmlo?=
 =?utf-8?B?RGdtdDcyZkM5WlgyQmNtRXlQMzJ3cmxmenRXNXE1RmhQK2JtbDFtcTNLcGFS?=
 =?utf-8?B?bEVKSk9URHl5QTJlMDIrRUFrZmYzTUNEWDFuS2NNQ1hpRE1UaGJiR2FJZm5o?=
 =?utf-8?B?ZWUvTEhYODBvN1ZPUjBMSkUza1FpNVlqdFVPT2JxRUN1Qk43ZStFRXdudEdN?=
 =?utf-8?B?a1IyMVVjRlNBNGtxd0RUS05zazhGWUJaWTdtaXJTV1pyR3M0NUg5ckhnbGpy?=
 =?utf-8?B?RWFUTjhKeXU3Vm9hcDhOOHdWbU1wVDI2ZVVKaXJsQlVOWU04ZkcyZEFPTkta?=
 =?utf-8?B?Q0g3ZmI0VjFvYlpQdDFwNis1QjRISVVMZmZVb01rZXh4R1NKWmRlT0U5QS9T?=
 =?utf-8?B?VmxiTVBpZE9FSzdJdzNmQjZucUx4WFphZ0FscVBRRm16aGNiVUxUVGFBZ3k0?=
 =?utf-8?B?WDZ4RHpRQWQ4R0JKd1VpUmxrY0JJU1luYzVlZkFWZTZNeTh4OEczNFYzcEl6?=
 =?utf-8?B?aENWM3RhU3ErWVNPNXBSNHdpRlp5aisreGZUaXVJeFFTREFIckRzM0VrM1Fn?=
 =?utf-8?B?TGpiZGN2ZG1hUmc1N3lOSHlybDRFMlRJRnhUanRjNFp1bzJwdEVPbU02YmdE?=
 =?utf-8?B?NmdheUxOQklQTDFVM3h0ZjB0aUhxN1lPZDlhRGtSWHhUQTFvVjRLYzJLUFE4?=
 =?utf-8?B?d0M3VjV6cjNJczhHdFRyWWNVS1F0NVhiVFZMYWJlVGc3VDVDYW4wd0IrWmdz?=
 =?utf-8?B?N1M1eGdEaDVGMG90aUp3d2VTMlRscVZ6Q0c3MWFheFl2NmYwck9aa1lqdUF6?=
 =?utf-8?B?YmVVY1cxdm5qZzdCVGcxdy9DQzFnNVhyQUZFMnlBRG9RSTBnNnk5N2JFb3FX?=
 =?utf-8?B?RjM1d0d3ZDBsNklvS3J1S0tGQjFDNGpDbmgxSjcvN3NzM2M5OWpXa1UzY2Mz?=
 =?utf-8?B?aFdDcWw2K2JUd1FXMGJMUlo5L25aUTlvM1g3cVU1WXRMaEduZ3FBV3Bpc3lh?=
 =?utf-8?Q?D+gs6D7yh2fAFYwg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5691D7E3834EBA4D97DB3AAEA790A20E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tCTZnCKjQOdAsGK1Bip2T9A8lLYbKffzKdyJCFJ7goukBQiQnwtO32NSbpSjdDWQaBtc2BaD7nftNEC+s6Jg5vNQvX6+D8lDFSNvbO7dHYNcG9B9gGBFCx5y/4woaie6nQ3e1Woow/bf6C78Y3uHUSYKj1V6bIu/GoVsy0h4+DGIF26kPUbjpqZJDEHeODMyNYRiuFZEAJ0iAnVKWXiH864tiTE/Ye8D//IDYDahWbOXqOLTVAmyBHtQUfxbKRQSpAZaPz9WuYGStgcsGfgo0bisdzgYEFYMlYT3CMMZO+f9vZz/fVqSgJHaWbnpWv5WP41vrCZEPdSmqt1AASxo5Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4078af3-4594-4c99-8496-08deb15f8ba2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2026 02:21:45.5858 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jUaa/OyKs02yahzVqY5lmuAG2xIKRK2Oqj2zTmBfjYfKjurR/iaTcP6AHsLFt0bV3D3VtbTWvYda3e/eVOL4y7UuU65vyInufAaAu9cM/l0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8183
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

T24gV2VkLCAyMDI2LTA1LTEzIGF0IDA5OjA5IC0wNTAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOg0K
PiBDaGFuZ2UgdGhlIGxvbmUgdXNlIG9mIHRyaXN0YXRlIGluIHRoZSBVRlMgS2NvbmZpZyB0byBi
b29sLiBVLUJvb3QNCj4gZG9lcw0KPiBub3Qgc3VwcG9ydCBtb2R1bGVzLCBzbyB0cmlzdGF0ZSBk
b2VzIG5vdCBtYWtlIHNlbnNlIGhlcmUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBMZWNo
bmVyIDxkbGVjaG5lckBiYXlsaWJyZS5jb20+DQo+IC0tLQ0KPiDCoGRyaXZlcnMvdWZzL0tjb25m
aWcgfCAyICstDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91ZnMvS2NvbmZpZyBiL2RyaXZlcnMvdWZz
L0tjb25maWcNCj4gaW5kZXggNDk0NzI5MzNkZTMuLjZkZGYwODIwMTAyIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL3Vmcy9LY29uZmlnDQo+ICsrKyBiL2RyaXZlcnMvdWZzL0tjb25maWcNCj4gQEAg
LTI0LDcgKzI0LDcgQEAgY29uZmlnIFVGU19DQURFTkNFDQo+IMKgCcKgIGNvbnRyb2xsZXIgcHJl
c2VudCBvbiBwcmVzZW50IFRJJ3MgSjcyMWUgZGV2aWNlcy4NCj4gwqANCj4gwqBjb25maWcgVUZT
X01FRElBVEVLDQo+IC0JdHJpc3RhdGUgIk1lZGlhVGVrIFVGUyBIb3N0IENvbnRyb2xsZXIgRHJp
dmVyIg0KPiArCWJvb2wgIk1lZGlhVGVrIFVGUyBIb3N0IENvbnRyb2xsZXIgRHJpdmVyIg0KPiDC
oAlkZXBlbmRzIG9uIFVGUyAmJiBBUkNIX01FRElBVEVLDQo+IMKgCXNlbGVjdCBQSFlfTVRLX1VG
Uw0KPiDCoAloZWxwDQo+IA0KPiAtLS0NCj4gYmFzZS1jb21taXQ6IGUzZTY1MWM0ODBjNDZiMzMy
ZjE2YTc1NTViOTdjNmM2ZmQ2NDBhNDANCj4gY2hhbmdlLWlkOiAyMDI2MDUxMy11ZnMta2NvbmZp
Zy1uby10cmlzdGF0ZS00ZDkzZTZkOWUwNTINCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gLS3CoCAN
Cj4gRGF2aWQgTGVjaG5lciA8ZGxlY2huZXJAYmF5bGlicmUuY29tPg0KPiANCg0KUmV2aWV3ZWQt
Ynk6IE1hY3BhdWwgTGluIDxtYWNwYXVsLmxpbkBtZWRpYXRlay5jb20+DQoNCkJlc3QgcmVnYXJk
cywNCk1hY3BhdWwgTGluDQo=
