Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 978B2CD4F21
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 02:23:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B3458467F;
	Thu, 14 May 2026 04:23:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="N9WXMpsL";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ClovEgW6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E3088469A; Thu, 14 May 2026 04:23:37 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D3A984676
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 04:23:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: e42cbdcc4f3b11f1a3561939bc42ff46-20260514
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=o+BZOEJK8+0qaco+J5HwbsZApRgUpHpctfbp8cmfzjc=; 
 b=N9WXMpsLkwt7B8EcouBBRh3Hmuf2FAA4eO1S+EjCNW6jETJ2G2pOxBofX0/e/FW3Gai99eL4qW6bnlc+hCVeVhwweX2BiZVDUc9HXzaSx2gSftLrKOJrgYTxhqd+ETLS72FcjlpaWG9S1rw06dObE7yZFq/17r3q69rgT94hw1E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.14, REQID:b92a3546-90c7-406f-aea8-c39a45eaf726, IP:0,
 U
 RL:0,TC:0,Content:2,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:2
X-CID-META: VersionHash:9091e75, CLOUDID:a218e140-4f1a-4cd1-8315-22e1f88ac479,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
 898,TC:-5,Content:4|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
 l,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e42cbdcc4f3b11f1a3561939bc42ff46-20260514
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by
 mailgw02.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 330425897; Thu, 14 May 2026 10:23:27 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 14 May 2026 10:23:26 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 14 May 2026 10:23:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D+Rei5+h8PBMfStJqyF9dbueW02WetsBW6IMmzEOHOcWY6DAe0Do9bAFe5xznOO/wMvqFJ5PtDzZh64upTnSo0bFYrbB6mF3gHsEs/gk0up5WCqxBJnVLsvRyQiP4Xt7P4b848vO5+dNfcXhbnSphHcv8Ofhh0QZ9SJzJbi8uOKXWbUERL3Vd1EiTssrR5PKVomIt1sR80o8d/NQIgB67ub19Emb/0LR3EeoHbp/+CreQx5YjW8Q934Lr8fYoHTa1rSUNEX1Z2jl/JB3neFbHLqsLOEiLYui5MFwGGmj2e0WmzL5AHoEBvpo6JiPMxyIHAi2cVQX8CbqlXBj9Ch/Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+BZOEJK8+0qaco+J5HwbsZApRgUpHpctfbp8cmfzjc=;
 b=QwxUwuapvz1b47lfedxPWKa3bsmwo1kdNsGix+dHbR/Ey0EPG1QNYblhGAnJITExUSZBH9jMt+JnrjfXbqXxIWDrYlge/CriaObEnMjOnqb3wYeS9jPu1Z9YfTgCGcTTe6HMGyXMhGFS8dPDh+ctRb0d0ONAB2oFRbKwZSz7Xzz6KfQ/pIBOlaOn8Vebe4WyNWMHXc8h2Cqp3YB+zWdwn7UrYunyPmw5Eu7fMt7uj4coeoshS2lRRk+7iYGEw4nI6InSCQKTtF5EOPrLROC+Rtu8dn3+vJ/3SVvPl1njW/g7kTEA6EmUROwP8hoT6yoyscRRurMK2R3yEXbvzQVTXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+BZOEJK8+0qaco+J5HwbsZApRgUpHpctfbp8cmfzjc=;
 b=ClovEgW6mpOFTK5l9sAXsSNCBmjKV4TlMRzeLSndIilRI+VNWkYqZEbeYlW490MuI+XiUQ0Q6qQPhon9Y6WiZrq3GlthPEXTGOCFHEbGrpfQdL3yYOozTvJFgFf5F3PX+EA9FjlCly02i2elffiJ9MlF6k7SLkuffroeXbLmJ8w=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by KL1PR03MB8238.apcprd03.prod.outlook.com (2603:1096:820:108::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Thu, 14 May
 2026 02:23:22 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.21.0025.012; Thu, 14 May 2026
 02:23:22 +0000
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
Subject: Re: [PATCH v2 3/3] configs/mt8365: enable bootstd, FIT and DT overlays
Thread-Topic: [PATCH v2 3/3] configs/mt8365: enable bootstd, FIT and DT
 overlays
Thread-Index: AQHc4l9O0P6kMy+9EEeTjQS+Beeg6bYMzIWA
Date: Thu, 14 May 2026 02:23:22 +0000
Message-ID: <e7b90ce0486cbbe8c57e8aa2b0247a7c97a9f3e3.camel@mediatek.com>
References: <20260512-mtk-genio-defconfig-v2-0-bf4c30ef7f14@baylibre.com>
 <20260512-mtk-genio-defconfig-v2-3-bf4c30ef7f14@baylibre.com>
In-Reply-To: <20260512-mtk-genio-defconfig-v2-3-bf4c30ef7f14@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|KL1PR03MB8238:EE_
x-ms-office365-filtering-correlation-id: 849ba9e5-e080-4716-5df4-08deb15fc52c
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|56012099003|18002099003|22082099003|11063799003|4143699003;
x-microsoft-antispam-message-info: 66P2z4SjmzR/FvPDvesSkbh2pCTC0F9M7aLbpGl/RuPvFRVO3bIm8/6TTJjS5JmQoG3wmecxOFlOL6YveFUmuhh4YojW+khcpY7Jr6f26Jjg7qBJuxC7MyPkQl1Hd+YT/GGqpoTBL1whP4mMSZJfRMVoHnqbmmQgFEuzQlbmqgWOWDuQq90E2IhPGLbzWFzvF0U2UsmkiCUiNWejiHUeLWAYdn85A4GZmRiYfIPv129aX4CAD0e6RJbDtDXwVV9UicZc12Vw/8RsQO8dHTAty61662NnlmS2ZOKQU8iG7XTps89IJZ4JaHb803aAP7YXpNiT64YzD4VJRr1bHHikvOfGgW2BZmRdD0H5m+DFceQe4UqDNuIXG2rSh6RrgVwsE/i1tDnAnc8EkqkelTbNQXrQc3trB4BY/Alc46HaHQTi7TLZ639SxZh+PSgtps5vNqUkxFeB0wmaZ6SiB/DycdbeDN6NnM9Zvz6OYLFmQvAqU00Iq514Tp+BE1l360f2OFAxf97K2qZcQXvsuc3Y8nzGQQHdO7NRkhq7pZI+IYMevP1jnCoe87YgCKZQuYl9lMJ++EasNLQjmt/68a//VawXbgHeeL1KgNI6XqzGHE0ECz+u7/7gVC02rdyCBNUHAVxRIYPAXiUlJ7otnvxrgKOcwMntNBbUSVi2raZMHfbv8f7Llx5d8sRD9+20G0mEeyVHqxpV2f1VgkPNGfTqrqr8YbJNgOhTsXz0KH4PbK8lICQezQS9au9aiDrqokhr
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099003)(18002099003)(22082099003)(11063799003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVlXZU9GSzFEek5xb3IxMkQ2NUZhMHhFVERGd0VXZDhjWiswak1xcHVxQ0FB?=
 =?utf-8?B?U1AyTytzZnZ2TUU4WXpzaStpZUZNZmQ4a3RaY1FsQWFwTlExcTFtSE91cDNk?=
 =?utf-8?B?MlhlU09oaXpOMU9IRnFmbGt5aXR3K1pPY2QxVDF5djRLUGVaRHU5UWg4VEZY?=
 =?utf-8?B?YUVYYmFQQUpqM2NsRlZuMVZjSWF1OGxuZWljeGVKTUhlTHRzcnVheDF1c240?=
 =?utf-8?B?VWU0cm1xcVZFSTBaeFBXaitnL01JbUZkWXlXZ2ltWjRqNWF0c3BrU25NbzVB?=
 =?utf-8?B?WW1GNXd4Um9kMG43RHZuWUtGUWNKL2RsazltdkxNMHF5VWxuVnBJMHBNMUNk?=
 =?utf-8?B?ZzduL3AyRFhQRHFEQ1RDMjNWaUk3STdmTmY4bldMaGhEWTRsOEJCNmM1VElS?=
 =?utf-8?B?QXRjN3pEOC8yZFBqYm9pSWUyd3RXWXNyMk8zT3g0MU5rN0FBSGxVby9NK084?=
 =?utf-8?B?dWFTRS8yT2c5ZFpDSVorc1Bza1k1a1BMZ01PVnZzNjhqTUR3QXJUekhsU21o?=
 =?utf-8?B?RFlBekt6OUhtSmJwMUJJTExtaHYySTFlL2todmJOWmRrRHk1VG9wSElPY2sw?=
 =?utf-8?B?VCsxekE5SnZ6WU5zbXBJYzJVK254cE8yVW01c3NLZy9MOVBXRFdBcE1Vd0Y4?=
 =?utf-8?B?QlVYZUcySHVMQUg4a0h5YXk5dzR2MWN2L250SGlhVDV1UEl0VW9WNG1hMkYy?=
 =?utf-8?B?eTBNYXhBbGYwczkydmdhMjhCa2xsU3lCRjhEaDJWMzVYNzYzNTQvbkd6OXF0?=
 =?utf-8?B?RkMzUHNZb1NtMWFIV2p6V21LdWgza0pRT3pDV3VRcXRWYS9rU0JTSUxpN1JM?=
 =?utf-8?B?cEdqN2pWdjVvTXVFR3I5SG1SYWR0RTVKYkNzUzc5bnhIQVZ2Uk94UkxMNmVL?=
 =?utf-8?B?SEdMRlZFYzV5cHY0b1liYk9ucXZQZDR0VmJGUmtFb3l4emk1Y3JYZlB1Tmh0?=
 =?utf-8?B?M3VpenU3THc5UDgwaHVVMmI0RHplZTRxNStoZHVGdmhzYWllUDdFU2kybk5p?=
 =?utf-8?B?a3AwM0xkWk1xeGxBMnR4RFFPSHJkMjQ3SFRERUVkSDAvMlFvdDd1RERGQVdn?=
 =?utf-8?B?aWRaZXh1VTBWKzVlRjBSNWZ3Z1NQQ2xHcFRicnBLa0ZXS0ZGazNPdGpmaG5K?=
 =?utf-8?B?czNVai9hUXJGYW1ZdzFPU21QanRTd2RlOEt3ZlhVZTB3UExTd0xkZEl3MjRE?=
 =?utf-8?B?NHIrelFRNGcrejRkTlF6L1VkNWFqS3NSb0xPOXR5M2prYnB4RmpPR00zQnJJ?=
 =?utf-8?B?V0lGUmZaeUtyUlhWM3B0TjRUa05rMHd4cU91Z0NOOSs4bGFtK05QWEx4YjVP?=
 =?utf-8?B?eU5EaTU0UEMvYTJVeUs3S3RZMGZiV0tDdU5uOUhpRXNWMklWY2NOaTk0d3Fq?=
 =?utf-8?B?RUxSdEZvNFpmdldEckNzOG01UHJYdmpiUlZMemJQOWczdGNNRHRoendYclNo?=
 =?utf-8?B?YzZIRnFkV1JaQnZkTWxvKzh4eWRFd1VkQlFQcEpLMWNTMkp4NFZKdC8vKzdr?=
 =?utf-8?B?Y2k2cUx1QzEyQXJCZ0lCWmNuQWlHZWRna2R2NDJKcm5nYlR4bEwySEtCOHlK?=
 =?utf-8?B?WGxuYlB4NmltZ29CUlN5WkE4WkViaDl6SlJzOTJOSWN2RU1wN05MSEJqV3pM?=
 =?utf-8?B?Uy9GTTB0bjNIdGV5bHZrRmRKalI4bnUrV2wzekFyb2QvZTBLVkFIcm1tWHlK?=
 =?utf-8?B?NGZVSmp6TFBrNWFOVFVCQUNLdTlUNllmSVY0K3NDQURmRU1zeTFlcG9IS1Qx?=
 =?utf-8?B?dXh2djFtNU1RTGZ0K2FjNkxDVjBLMG5LL3pTenY4aEtQeG9pYzRJcC9uT1Fj?=
 =?utf-8?B?QVl6V3BPK3g0YU9PdHdJVUhGN0VBdnpLckV3RGZKdmh5Y1NiOUI3dnM4YWJr?=
 =?utf-8?B?NjdLTkJyYkV1VUluNTJ3RjFNdk5JazBmYWxuODRVKzJEb3plM21YSTdvbVFD?=
 =?utf-8?B?MGx6OGZlSjZuTUNEMUcyY29SV2ZNcC9ReGhlTmFQa2FNanpxdTQyRkNMblNn?=
 =?utf-8?B?N0NjV2pFanVGQ2VEUnM0R003U3h5UHorMGJvcGlTT1ZoRGtEd3ltRW9RQlRQ?=
 =?utf-8?B?elNjK1loMXF6ZHJUZ2J3K0k4SUJlVk9VOVpIdlZVWWpkQ0poT0hzNWNkeGwy?=
 =?utf-8?B?RFhqWWI1T3llUFcrcHNzSGlUOE51SXFaRVRuN2p5SGtsbHJYZmFscThsaFVX?=
 =?utf-8?B?VjRrQXNEdGZRUXlsSmh2WWNVdmovVEQwbGpiTy8yUlRsdStEVG9Eb2Zycitz?=
 =?utf-8?B?SFdFd0srdm9mTVhSVEhDK2ZmSkZPcW1JaXgzVlJDbmlIcnp0UXJYWHFqNkNW?=
 =?utf-8?B?LzVXckVjNGd4cWFqamRkbnArVHphaldTMks4RzNjNWlwOGFrTU9saGtrNjdh?=
 =?utf-8?Q?kW8k3XXxa1gQxojk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E44BDA94787D6C4585CB41AD68A2C262@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HFKsLN1DNEi57reYO9s6HyUSHf07Jq8E6vIYf70pvut5zDUULbrg31tvFaG65hnsZ4ozMKL4txsPnGSuzY8bUjKl3jdhu+HtEUHagxKOzaXZDVZvLX5bprZUxxJV/BkWxhxBiSjtW60f4OL6UTQP/wt1sx6eDQV+SRdWUStQ8q8jrkaD4Rmydc3ReRtvpPncSO2lh1zL9xHTwWBkEpmFP3r4b6KGvF9/HVyYCCExTyobdNPbxojlgR59H4Bt2Jeq8LkUE5SVuW/G0Xp0iDTwWoJMv9ZUmwgdRVDDGWflN8Gk+RwzxfKtVpaPm8SdG7TqpFamL3UHY6BuW46phoS2Eg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 849ba9e5-e080-4716-5df4-08deb15fc52c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2026 02:23:22.0708 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cIL0/mlfFfvaMDsumBzUKnpfvCIGcYC7FuY+kaQwZjwgZjrAvlwHlmIR/66Avn1mNLpRLx7kRtj8ViEYFWv+QWVEnHku7azp3GN367cNlNk=
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
YWdlIGZvciBHZW5pbw0KPiAzNTAgRVZLIGJvYXJkIHRoYXQgdXNlcyB0aGlzIGNvbmZpZy4NCj4g
DQo+IENPTkZJR19DTURfUEFSVCBpcyBzZWxlY3RlZCBieSB0aGUgbmV3IG9wdGlvbnMsIHNvIGlz
IHJlbW92ZWQgaGVyZQ0KPiBzaW5jZQ0KPiBpdCBpcyBub3cgcmVkdW5kYW50Lg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogRGF2aWQgTGVjaG5lciA8ZGxlY2huZXJAYmF5bGlicmUuY29tPg0KPiAtLS0N
Cj4gwqBjb25maWdzL210ODM2NV9ldmtfZGVmY29uZmlnIHwgNCArKystDQo+IMKgMSBmaWxlIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2NvbmZpZ3MvbXQ4MzY1X2V2a19kZWZjb25maWcNCj4gYi9jb25maWdzL210ODM2NV9ldmtfZGVm
Y29uZmlnDQo+IGluZGV4IDFhMzg1NDkyNTQ3Li4yMDI4NzliYTY2ZCAxMDA2NDQNCj4gLS0tIGEv
Y29uZmlncy9tdDgzNjVfZXZrX2RlZmNvbmZpZw0KPiArKysgYi9jb25maWdzL210ODM2NV9ldmtf
ZGVmY29uZmlnDQo+IEBAIC02LDE0ICs2LDE2IEBAIENPTkZJR19BUkNIX01FRElBVEVLPXkNCj4g
wqBDT05GSUdfVEVYVF9CQVNFPTB4NGMwMDAwMDANCj4gwqBDT05GSUdfTlJfRFJBTV9CQU5LUz0x
DQo+IMKgQ09ORklHX0RFRkFVTFRfREVWSUNFX1RSRUU9Im1lZGlhdGVrL210ODM2NS1ldmsiDQo+
ICtDT05GSUdfT0ZfTElCRkRUX09WRVJMQVk9eQ0KPiDCoENPTkZJR19UQVJHRVRfTVQ4MzY1PXkN
Cj4gwqBDT05GSUdfU1lTX0xPQURfQUREUj0weDRjMDAwMDAwDQo+ICtDT05GSUdfRklUPXkNCj4g
K0NPTkZJR19CT09UU1REX0ZVTEw9eQ0KPiDCoENPTkZJR19ERUZBVUxUX0ZEVF9GSUxFPSJtdDgz
NjUtZXZrIg0KPiDCoCMgQ09ORklHX0JPQVJEX0lOSVQgaXMgbm90IHNldA0KPiDCoENPTkZJR19D
TURfQ0xLPXkNCj4gwqBDT05GSUdfQ01EX0dQVD15DQo+IMKgQ09ORklHX0NNRF9NTUM9eQ0KPiAt
Q09ORklHX0NNRF9QQVJUPXkNCj4gwqBDT05GSUdfQ01EX1BNSUM9eQ0KPiDCoENPTkZJR19DTURf
UkVHVUxBVE9SPXkNCj4gwqBDT05GSUdfT0ZfVVBTVFJFQU09eQ0KPiANCg0KUmV2aWV3ZWQtYnk6
IE1hY3BhdWwgTGluIDxtYWNwYXVsLmxpbkBtZWRpYXRlay5jb20+DQoNClRoYW5rcyENCk1hY3Bh
dWwgTGluDQo=
