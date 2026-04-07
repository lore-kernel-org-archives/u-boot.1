Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37360FEEF41
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 13:26:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE7B484105;
	Tue,  7 Apr 2026 15:26:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="ngile4SO";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="hw4c1Rlw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8A0084105; Tue,  7 Apr 2026 15:26:38 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8969B840AB
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 15:26:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: 6429c6ec328511f1ae70033691e9ac7d-20260407
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=VZJYsqjjMYGV15drhpQQkjX0T4pgl4Jga0yr1xqb7fA=; 
 b=ngile4SO4R47O3/NUcaqL55Uny+JtfTrHtMl1EC88+ChxaCcD8FQLXAsWGIw3l+P7gq87h58LMztaWpDpnbROsxCwIdv4zPwZMDv7hf70gA6gVSSznne6Wd3KI4pp+84ridcI32SOfkKWXm6k1xVANmnZN6eTTKTbKh4GOeqbO0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:f1df010e-1699-4b5d-9553-868063f9b983, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:4db99524-cb5c-4236-a89a-9a7fb20c9bc4,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
 898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
 l,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6429c6ec328511f1ae70033691e9ac7d-20260407
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw01.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1083255943; Tue, 07 Apr 2026 21:26:31 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 7 Apr 2026 21:26:30 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 7 Apr 2026 21:26:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/RHou4aoBr/HfxmpRf5RpS3/VGSxRDidhaLvmEQgAlGT9Vfim0ygpv0k+hooUCiwhHuM1iexxSaqyT1eIkMGdTIvGGCR8RGkItLfV2HfzyHPDxvmvGl05SpyQILiqdUEulQrBQ3qSF77i03EuIKkcwsaUS/gJ7JjGI9Jj/tjDZ4quM0QfzxpGONhG2oE5d9y1Bq5DembDHthTyL7G4PV4fb+yMZ8AgS9h5/zgtO6G2RL7NwmhfwoFiAHpa37iwa7VnPzPV8UiIHJ7+CYKUnq0qxdkE6AinGQYZbwrtPUXHakPcPIUUp01gJ4MqD0XO41HoFtSpQe/ZYAYatJXa81Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZJYsqjjMYGV15drhpQQkjX0T4pgl4Jga0yr1xqb7fA=;
 b=B0Udjphw7klEBpDKbaP6btGYRpJ78Jd3hJ+C2uwa1Hcy3N5VyWOt59tVxgqGmdINJjorn3RsPQACRbPq/XhJnQRxrkhWyoZmohnFZgJiGkYG/7iU66AJaqaKFHSP5aUQ5Ou3YDRtb/7GxNIDnr/5ML5n46B/bKWM4l9jW37/S9Lvlwf5MHxXqdZYVSuqKxCeIHodntndP/IwkVfmWM5DToCz62re21xjEucM7Wkncg/Qst1429ZZmoQzduOvn0PxrvqUpi2Y8jqVlaLMgKEfNRewGJsjIK0Hlm2qwer1cvAH9ce1DzGbZtFWUrDusSVk/juoYvCM95Zgwc4NcAq4ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZJYsqjjMYGV15drhpQQkjX0T4pgl4Jga0yr1xqb7fA=;
 b=hw4c1Rlwliv1LHIy0XsQEWzSzIT9f7ZVExIh7dVC2XbN3IE4p+qnFRcBJQfQXr8s/GYUo36y9hYAhbWBOSqU1/xzlOx4C3a6uXxnMIcwsD8MmnBgflusicRQTJx0orx46bFstttzokNMDJ28t0gK4GSXkgEc116hUYycO46qQkg=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by TYSPR03MB8427.apcprd03.prod.outlook.com (2603:1096:405:59::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Tue, 7 Apr
 2026 13:26:27 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 13:26:27 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 "trini@konsulko.com" <trini@konsulko.com>, Ryder Lee
 <Ryder.Lee@mediatek.com>, David Lechner <dlechner@baylibre.com>,
 =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>,
 =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>
CC: Julien Stephan <jstephan@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>, =?utf-8?B?UmFtYXggTG8gKOe+heaYjumBoCk=?=
 <Ramax.Lo@mediatek.com>, =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?=
 <bear.wang@mediatek.com>, =?utf-8?B?Q2hyaXMtcWogQ2hlbiAo6Zmz5aWH6YCyKQ==?=
 <Chris-qj.Chen@mediatek.com>,
 =?utf-8?B?SG93YXJkLXloIExpbiAo5p6X6IKy6LGqKQ==?= <Howard-yh.Lin@mediatek.com>
Subject: Re: [PATCH 2/2] arm: mediatek: mt8189: print specific CPU information
Thread-Topic: [PATCH 2/2] arm: mediatek: mt8189: print specific CPU information
Thread-Index: AQHcwINA72w9AcTTHk2NSj2UrH8r4rXToz4A
Date: Tue, 7 Apr 2026 13:26:27 +0000
Message-ID: <175cc84dc13e6abd92b5b7d09f432974cec57a8d.camel@mediatek.com>
References: <20260330-mtk-mt8189-cpu-type-v1-0-4059c3b52761@baylibre.com>
 <20260330-mtk-mt8189-cpu-type-v1-2-4059c3b52761@baylibre.com>
In-Reply-To: <20260330-mtk-mt8189-cpu-type-v1-2-4059c3b52761@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|TYSPR03MB8427:EE_
x-ms-office365-filtering-correlation-id: 60a32875-2619-4cf2-780a-08de94a9459b
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|38070700021|22082099003|56012099003;
x-microsoft-antispam-message-info: nYrLIRoSqS3cKMIiLYz8KuaiV0KTfp/WvoyM3p/kUIIMmhkcenayuHGVvqX+k9hB6lzb1UzC/K0GfT1JZncijfhzNQ7RsjRgTwcxOenVqT/Puw7kTUZ4luhty/s7e1EIffwRX/oiqYwFrT1scFjfQWVTJxo7exsp9/iL3GX2AmVzzYkraXjBtpySgP7xn0EvlAgB5xJ0Myj3Aohgv/Xa1m7ouXptcCUU23Sb5kQorT5f2r2lsjCj5Zq3RpSkezLyD7QFnXR+9oQwPB1T9EhSqZXvnCXiGycSxgxPooAOn3faRDIw88r0tfb1TI+mpqZ2Gkidt2YmihhwI/PrRoKrqtNnsx/I3NGcBMPPJmV80h56WTgI0h+/Dv3QCBx0aHh36O9SBl+MayOscTWiZoPXO4+YTcu/QPHGSto+sEUdFY/WY0OVM/vTMAfKiEMzlsEfYga0GghQ4VvigDvTu0ghwI3SScxeacmOqzIQHPYZfq4PmnOLsOrOODtNiprUuxxkx/JFbj1fkHwFlW4YZ220TvQCY6XyD4dB454RfIEFfHnR2V1Fk7vxMmPqAW7tsdjzv7QndcfyzG035kpQxRNKTJh3c9RyGTzmGeKcSN0Pa9UI4PKItTvKzF4KnxZQ1XXhOV1s/7onfI+V6c83vmI+XTo0WodHxfUQD0sIImXXiMb66/fwssGuyNNrk1BYF/MXeUXi8+a44hwXJINDeh6jvmtuhv84KwZdh6R5NW2sCc4UIj3ykEZA2K/6EPSZ1GCMHi1+K1Qk3NzR7UMbRd2iFxsMQ/1eP42QCY8zjQoqn/A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(38070700021)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enU2VGtxVG1RNENBZmc1UE5sQU4vMUgvd0oreTU1MGZnRG9UQkZjMEdLTktX?=
 =?utf-8?B?ZEdCc2lvMEFHTEtpcjBpRWhVTWVxaFl5R3BOMGR4Z3pUT0llTnpMajFCRDR1?=
 =?utf-8?B?elhTSE50LzBRK3FHb2FibE5UVWNOeFJwZHlrSkJZV2Yzb2t5Mk9aelFyMHdH?=
 =?utf-8?B?OTI3bUhkd2w0Si91S1AxaWdNVXpqNG9EekVGL2MrdDV5YllScXNDaHVQaVNu?=
 =?utf-8?B?Y2hGMEpkajBLdUQya05aZEQveHd2d2YrSE9obGlkSU41R0Nwa01GTVJIWXhB?=
 =?utf-8?B?bXlrazZYazdKUjlWUjVLYklXbDVReHcrNTFEOEI3MXhXQTlUcTFUWGp4c0xX?=
 =?utf-8?B?NU5BeUxYZm8wMzV1Q2JjMXV0dUF6OE52aE5IcEVjdENNNW9LVzAyRDZ2OTFn?=
 =?utf-8?B?cWh5STJySmVJSURzZFJCQXRId1hqU0xBRHV3K2hBRll0OERlbFBKRWl4ZnQ4?=
 =?utf-8?B?bWhzQlNoajBzL1k0QnBoSHlPT21PTlExbkFBQk1zRmdPdXUzcXhLV1o0M2p6?=
 =?utf-8?B?enZQd0FZdEpVWWtmc3YvVTJHMjdFcG1DaHFIMEs5M2UvU05pdFdxSVg0cDE2?=
 =?utf-8?B?aVhnRnNHNEdPK1kvK2xNakJIamsvUFZHc05qYzMwaEdqQTQ2NHNUdjV2aE5Q?=
 =?utf-8?B?Q0szV2dWZk1jL3FiK2IrZUUybG5aT2FRVHB5SXNnZFZyWmo5QTBiOHBVU1oy?=
 =?utf-8?B?cnZpZm91WkUwQnBlRWphYmZvN2lrQytpQm11VWMwbklkS3d1ejRHZEJjVTFC?=
 =?utf-8?B?eVZoZjlEMXNBcW5aYWttcFRsUFY2TThZTkRFRE5yQTIwaFd1cTUzNWRMbnJC?=
 =?utf-8?B?Nyt0OUc1WklwcUNPYUVPcnNFZnhhNnp3TU96OENPczJDeUVMUzExUnJWaURs?=
 =?utf-8?B?K242aWlhZUNZMmxuakhUaW84bmRialQ5eTRLVXdicWllUWg0WWRDM2I4Z3I3?=
 =?utf-8?B?QWN2anNGOC9IVGR5b3FCcnBPbG1TNTI4V1dHSks4eHY3MjRZTm5QcGlNb1Js?=
 =?utf-8?B?U2kyL0JOOEdFblRWcjd2bngzQkVpVDN6WEhSOVRVNEMraGxzWlk4TUwwK2Fl?=
 =?utf-8?B?MG5oMHliekhJdXdMSTZVbmhiYXZTWVdiWHp0b1dnMjdCcThxNXBKdGtIbFpO?=
 =?utf-8?B?dHZqMHV4NDgwejZKQjl1M0FBdy81NkI4ejl4OTBadDg3YTd6RzFIaUtFcVdz?=
 =?utf-8?B?OWE3aE5JaWc5eisrblZUc0RvWTlQNHNXbjltVmFVWjIyQUpYV2IwNHk4cnll?=
 =?utf-8?B?MERidnN4SlNuS29WQVVnOFlaYUxzU0xKUm1RQXhXVjZHZ2k1cGNLbkQwenBE?=
 =?utf-8?B?dC9obEZNOGM0cm9oT1ZZUWNJSlhsdkVwNkR3OFI1NjQyL3VibDdyQ3JkalJW?=
 =?utf-8?B?M2lDRHlkZDJCdHQ4VENXcm5kQ1ZjakRUTmI2OW5ReVVYcmRRbDh5TW1OSC85?=
 =?utf-8?B?NWlEOGwvaG9LRW9QU0NkenFvaUdTZDdKR0ZLMzBaYXBKakJpd2Q3dHZoQXI3?=
 =?utf-8?B?cG5DZWdkdnIvejRTdVhIZG5MQ1VCaUZjQVJwc2RxbHNyQm1hZU1uOWc2NnFN?=
 =?utf-8?B?M0ljY0VMYkFuSmZaM29meXNBaDNXak50VHRKVVJaNTg2TFJ5VERXT0NLQWZu?=
 =?utf-8?B?RC9Qbzg2M0E1OThSbGw1b0tKM2hFMGJyZFNTL3dLcmxjUlg1dFdVaDdEdzlG?=
 =?utf-8?B?cThzM0pOOTJla2YrMG5qcDN2Nnk3emtFSDZLWVFCMXFhWmo3c0tDdlhjWGFD?=
 =?utf-8?B?cndOaVVWQnd2aHhDNGtlNnZLazVpTVJNTjZ1dGp1Q0p3ZWovT2h2SjM1WU4w?=
 =?utf-8?B?eThZbm9rbVBLNWxFZ1VBRjRzQnh4VWpXTnAwSFB2UHg2TzB3QVJHSCtXSHBZ?=
 =?utf-8?B?VHJCczduTUJJeldnT3V5VnFNbkdiMGtiVXY0NXdvUTFrWnc1RVViT0ZpNlFy?=
 =?utf-8?B?U1dRMWM0VFlxSnR0UDZEUzJRMVY3RUpiUXdYSnZkYU94YngvRmV3a3VRVVZX?=
 =?utf-8?B?U0trNU1IWjhoWndpWmtKWUV2RXVTYUtLaVo4TXRDVXdOU3VOc2hoMitQMUhp?=
 =?utf-8?B?R2tNUlNRdjdZUXFraE5pcGIrSkY3NmFaQUx4aHcrOUdXSnZtTnZuaW1INGxu?=
 =?utf-8?B?dFB2RHY1RENnMjU3OG1lK29QeGNBaFBrR0s0cGp3Z2dnWFlBWXFVUzhHQ01i?=
 =?utf-8?B?RWkzRHBJNnZqQ3lBUlp6Vzk0d1NUSWhKOTY4eU9HYTJuVFp4Zk9mbnlGdUwy?=
 =?utf-8?B?a0h0cTlQeDFTeVhmRWEzUkdTZU9PWFVjNUtsSGxrSHdsVHVsa3I3NUREc2NL?=
 =?utf-8?B?aCtHaXNQYTNqVnZVZGcxNU8xZEYwbnJ6MGFBSzN2b3Z3VEp5M3ZHai8wc3dF?=
 =?utf-8?Q?4xOOcX3EFCZM3J6Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC14EF6E30C0F4448A60C6220494B9D6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QMdwEn6bDdnC79IM+YiUMJqhYbY88NRO221338yF3A9WvqgbhXc5zATbKYdjTroE9ZGmROo05aMcLQ8N1KhWv2Fb4pQ7YbUgXNFhd97Ckpkg19XR9LZPSeSHbLsvL7Ne4tW7+iKrsfPPmRl97Mcnda5XN17HVGDnh63dYokCAn41RqJEPjmzpBcDsoFxna5qPTMLambLrCQziAMRc8yYjlewORtZYixp7Zpx3GhA46aN7Dhh0ehDXmiCwURrEZnmePiSzmqHDZpH/JbwJE/kk6flEglONwftrbT8sSuu0D2S5lJjOeNp13jJVeC1N/UJjPL5744nMDPOCEHFD0CVag==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a32875-2619-4cf2-780a-08de94a9459b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 13:26:27.1154 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hZTBA1FiIiC/rv7Vpdhrnt+9Aqko7gD3fSt1/SDVFkxeOgtMkhrwelqyN+XMY9erywkTzrEiFu1THVG3NUFkoHxNH+TQkrQlHnXTZdYEEuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8427
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

T24gTW9uLCAyMDI2LTAzLTMwIGF0IDE1OjIzIC0wNTAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOg0K
PiBNb2RpZnkgdGhlIHByaW50X2NwdWluZm8oKSBmdW5jdGlvbiB0byBwcmludCBhIG1vcmUgc3Bl
Y2lmaWMgQ1BVIG5hbWUNCj4gd2hlbiBwb3NzaWJsZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERh
dmlkIExlY2huZXIgPGRsZWNobmVyQGJheWxpYnJlLmNvbT4NCj4gLS0tDQo+IMKgYXJjaC9hcm0v
bWFjaC1tZWRpYXRlay9tdDgxODkvaW5pdC5jIHwgMzINCj4gKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKy0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtbWVkaWF0ZWsvbXQ4MTg5
L2luaXQuYyBiL2FyY2gvYXJtL21hY2gtDQo+IG1lZGlhdGVrL210ODE4OS9pbml0LmMNCj4gaW5k
ZXggNjQ4YzE3YWMzMDUuLmVjNzU4N2MzNTg2IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9tYWNo
LW1lZGlhdGVrL210ODE4OS9pbml0LmMNCj4gKysrIGIvYXJjaC9hcm0vbWFjaC1tZWRpYXRlay9t
dDgxODkvaW5pdC5jDQo+IEBAIC0xMSw2ICsxMSw4IEBADQo+IMKgI2luY2x1ZGUgPGxpbnV4L2tl
cm5lbC5oPg0KPiDCoCNpbmNsdWRlIDxsaW51eC9zaXplcy5oPg0KPiDCoA0KPiArI2luY2x1ZGUg
Ii4uL2NwdS5oIg0KPiArDQo+IMKgREVDTEFSRV9HTE9CQUxfREFUQV9QVFI7DQo+IMKgDQo+IMKg
aW50IGRyYW1faW5pdCh2b2lkKQ0KPiBAQCAtMzMsOSArMzUsMzcgQEAgdm9pZCByZXNldF9jcHUo
dWxvbmcgYWRkcikNCj4gwqAJCXBzY2lfc3lzdGVtX3Jlc2V0KCk7DQo+IMKgfQ0KPiDCoA0KPiAr
c3RhdGljIGNvbnN0IGNoYXIgKm1lZGlhdGVrX2dldF9zZWdtZW50X25hbWVfc3RyaW5nKHZvaWQp
DQo+ICt7DQo+ICsJdTMyIHNlZyA9IG1lZGlhdGVrX3NpcF9zZWdtZW50X25hbWUoKTsNCj4gKw0K
PiArCXN3aXRjaCAoc2VnKSB7DQo+ICsJY2FzZSAweDgwOg0KPiArCQlyZXR1cm4gIk1UODM5MUFW
L0FaQSI7DQo+ICsJY2FzZSAweDgxOg0KPiArCQlyZXR1cm4gIk1UODM3MUFWL0FaQSI7DQo+ICsJ
Y2FzZSAweDgyOg0KPiArCQlyZXR1cm4gIk1UODM3MUxWL0FaQSI7DQo+ICsJY2FzZSAweDg4Og0K
PiArCQlyZXR1cm4gIk1UODM5MUlWL0FaQSI7DQo+ICsJY2FzZSAweDg5Og0KPiArCQlyZXR1cm4g
Ik1UODM3MUlWL0FaQSI7DQo+ICsJZGVmYXVsdDoNCj4gKwkJcmV0dXJuIE5VTEw7DQo+ICsJfQ0K
PiArfQ0KPiArDQo+IMKgaW50IHByaW50X2NwdWluZm8odm9pZCkNCj4gwqB7DQo+IC0JcHJpbnRm
KCJDUFU6wqDCoCBNZWRpYVRlayBNVDgxODlcbiIpOw0KPiArCWNvbnN0IGNoYXIgKnNlZ19uYW1l
ID0gbWVkaWF0ZWtfZ2V0X3NlZ21lbnRfbmFtZV9zdHJpbmcoKTsNCj4gKwl1MzIgcGFydCA9IG1l
ZGlhdGVrX3NpcF9wYXJ0X25hbWUoKTsNCj4gKw0KPiArCWlmIChzZWdfbmFtZSkNCj4gKwkJcHJp
bnRmKCJDUFU6wqDCoCBNZWRpYVRlayAlc1xuIiwgc2VnX25hbWUpOw0KPiArCWVsc2UgaWYgKHBh
cnQpDQo+ICsJCXByaW50ZigiQ1BVOsKgwqAgTWVkaWFUZWsgcGFydCBNVCUuNHhcbiIsIHBhcnQp
Ow0KPiArCWVsc2UNCj4gKwkJcHJpbnRmKCJDUFU6wqDCoCBNZWRpYVRlayBNVDgxODlcbiIpOw0K
PiDCoA0KPiDCoAlyZXR1cm4gMDsNCj4gwqB9DQo+IA0KDQpSZXZpZXdlZC1ieTogTWFjcGF1bCBM
aW4gPG1hY3BhdWwubGluQG1lZGlhdGVrLmNvbT4NCg0KVGhhbmtzIQ0KTWFjcGF1bCBMaW4NCg==
