Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6047D6CFDE
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 06:30:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18695839DF;
	Fri, 23 Jan 2026 07:30:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="elLVLP5A";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="LiXO6X8k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C272E83AE9; Fri, 23 Jan 2026 07:30:34 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C131839D5
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 07:30:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: fdfe66ecf82411f0b7fc4fdb8733b2bc-20260123
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=8Kv3Gu6g08LgiKZkLFoxU1iB1KaLpq0voeq+1JWEFFs=; 
 b=elLVLP5AeabRcv81EMJA9JdPB4hdoxK0oXQI6OSoxYHcFV/cZCGP0o67rn+jjjL7QGzqS+EETRty5M47M4zeo8W9Pzw6QGiOSwV07/lS5rWfrKSqmFU7IZEW3NPQxrZ533Hz2ToLajiK3Z1wNX4AJPJRitGw/jOFIL3vlKJQoGA=;
X-CID-CACHE: Type:Local,Time:202601231430+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:6c89c027-970b-4096-a87f-4f3b8aa68818, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:89c9d04, CLOUDID:0cfe765a-a957-4259-bcca-d3af718d7034,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
 C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: fdfe66ecf82411f0b7fc4fdb8733b2bc-20260123
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by
 mailgw02.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1756287322; Fri, 23 Jan 2026 14:30:21 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 23 Jan 2026 14:30:19 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 23 Jan 2026 14:30:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T7PFBGy13NUN0JZkxV1QpX6XCYbmBN4DtsLlySbPZRP98cJ6HWDXIo+cLwEPumpVtypoRD8g4k47hu9QxROGmvglnoONR7FK3g5FJp2z8y8mjJmk7K86d0pHI8zRvV2iNzuwIQl85izZfGB3Q8qJ2TE1/PjS8EhZU0M2xFQWr90URlBFlSo6KP+i0DhqgqM0BfAeP74sgIjWMAuKcpCrMw2NlvEpjvke123ePV2N4SmJTilJPHHLSgX/S5I+zXf3azfO3RJtUU6YKc5qOXzVXDdTNFkANHFE6Fb8azIHdtHakQEmY8rRMmnNrwpcgxGPo9/+YtxRiQ2D9fR3caAA/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Kv3Gu6g08LgiKZkLFoxU1iB1KaLpq0voeq+1JWEFFs=;
 b=bc9PVGyh5Jf5R35Y0VBc/VmdL2o686rdC/6nbUL65YtJCrk8VuK6oK+nyM+adn+TQGTGwS5hqK3VAZ3bvl2g/ekAL8yHiq3itwfrhy+b3KvgJEZMk2qD5jQNo2d+zQGwHlSdqt2FfOrIP+P6UvKm0r8oo/cabj2/WvR347MLiL3uxcdfbMo3woVrvizbVuk1d2r8Qu9pk9Yzpv2olqyPH2K5o70hFr3DE20IDHmWuLSk4/eor4krDxgQCST5yWt65RHW0xltezRBBXwz6FICdiHxFfpIH6sxxsjK3MhVIyZE8lvKhBRRmO6zqQlPiuF///37Il60r/H1Yq2k33QJpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Kv3Gu6g08LgiKZkLFoxU1iB1KaLpq0voeq+1JWEFFs=;
 b=LiXO6X8ky3jh4QMbDc6HQtBbcBHmYu0FRKySIgiOiEh9gnsudnlAZ8BYepP81HCXgmJ0ifnBe81BwVfJ9eFwZ5un+3eBm/04loMF7MCVcrx8e+AWOf+ASOo2sOLDFKyuXe9fkz5V8WeqDyJ2gvzFOuyIFQxQpsHA2Lyo55t3Sls=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by TYZPR03MB6818.apcprd03.prod.outlook.com (2603:1096:400:202::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 06:30:16 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2557:de4d:a3c7:41e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2557:de4d:a3c7:41e8%3]) with mapi id 15.20.9542.009; Fri, 23 Jan 2026
 06:30:16 +0000
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
 <u-boot@lists.denx.de>, =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>, =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?=
 <bear.wang@mediatek.com>
Subject: Re: [PATCH 2/3] mmc: mtk-sd: fix misaligned brace
Thread-Topic: [PATCH 2/3] mmc: mtk-sd: fix misaligned brace
Thread-Index: AQHciyysYkeLA+U7YkipA98WxjGmNrVfTR6A
Date: Fri, 23 Jan 2026 06:30:16 +0000
Message-ID: <9c7ea698d9ac7221d7a461e0e60b8ba42e8e72da.camel@mediatek.com>
References: <20260121-mmc-mtk-dma-support-v1-0-3764b487c087@baylibre.com>
 <20260121-mmc-mtk-dma-support-v1-2-3764b487c087@baylibre.com>
In-Reply-To: <20260121-mmc-mtk-dma-support-v1-2-3764b487c087@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|TYZPR03MB6818:EE_
x-ms-office365-filtering-correlation-id: 3256ce91-c61b-4642-a230-08de5a48df4d
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?WjVNRS9vZDJaMzZ6ZGlpb0Q5SzN3Y3llWmJxNWZZQlU2eWRtR2tCam9PS05J?=
 =?utf-8?B?Sm8xZGRsUDl1NnUwc0I2ejBIcnhpb2lFRGFGRWprYnh5dy9DY3lVWHVrTXAz?=
 =?utf-8?B?bTVaVHJUWkhoL0trNnhFY2o0REEwbHdzUHJMMUQ1dHZ5TGNwNTVnQzhNbzNm?=
 =?utf-8?B?bkFqbkM0bWFZQlJIOU5DRzJOSGFKVEhWZXdsSUlrWTRWemVVc0d6Vk1HVDZh?=
 =?utf-8?B?UktZVFZBbTZIcVV2aS8wN29Gbi9IWUl0NWlNa01GZXNHL3RQTmRxb3JxeVdE?=
 =?utf-8?B?YnE3NEx0SXpUMXlHaDVVa0lTMWpIYStTRDZTYUIza0ZLN2xNSHBhVTVBZ3VV?=
 =?utf-8?B?T1lwalR4a01lbHRyanVBRU00R0kwRUhtRTBsYkdHM3JwT1M1ZEE0TFhpVjhk?=
 =?utf-8?B?bnorMmhsdFBvYlV4MlQ1cUZZTnVGamFJdFZyZzM5ZnVrMmU1ekE5ek41VXBs?=
 =?utf-8?B?WURMWGpBbkhtR3hPMHlCN0dTWU9qV2l6MmNrYndGTVNHVjJiTWo0aHZlYU1t?=
 =?utf-8?B?Q0NUZ3NtUEI3ZTVvRzNCc2JiS0toTzhURmJvZ0NPQ1JMQUFwUXR3L3dYeU9D?=
 =?utf-8?B?cFRjZ0ZIQjl6bnB3ZlVhT2hmQWt3a21OQnpCYlFmL1JNWUhoR3hXcEVQM2pU?=
 =?utf-8?B?bjZNK3dmOERoWWxRQkRNWnU5WThudGRqWFhXN0JzUkhzRjRic01ZQVFwQ240?=
 =?utf-8?B?TnIyN3k1R2lNZm5qaWlQeWxUK21NVVlqeklTbmxUV2dFYzhORUZHZTJ1ZGpR?=
 =?utf-8?B?aGtXSnFaeTMxa1p3RFp3b096dHFtVW1ZeXVFREFCVG9taEU1aGRzaDBURm9W?=
 =?utf-8?B?cGhvS1NUdzFMMkplZHlyWXdzSXJZMUJOcER0eDE4SDNoRjVUeG5MeTF2N3p3?=
 =?utf-8?B?R1gwekV3NXFya1dzWkYrb2RzU0RkRk93MWZjbjJJOXlIbzl1WmNKU0RFaVpC?=
 =?utf-8?B?NFpHRHI5K1lVM0JFV3RMWmZzYUU5QTJ4YkJMQndoYUkrU25uZDA5b2ZpMmR5?=
 =?utf-8?B?Q04zdFFyanlFM2pOQXBVMVlJTnk4WWhySzVEMi9XY1BoYkRNN04rUC8yZHU5?=
 =?utf-8?B?QUNBNzdGVnZIc0ovZk5KYm9CZkI3ZmFHcGI0YU9QVitzTXVuNjZJUXhGTk01?=
 =?utf-8?B?WGorSGtoVGZNaVovNGZxWkxKV2xsTGhpRkUzRWdEaVUydXE0UTVVSVZ5dFpo?=
 =?utf-8?B?dGppeWthSk93R1BYaWxuRUN2aE8ydHJOVDYyUVEyQ1hpU3ZZd1hQdWRKdHVT?=
 =?utf-8?B?bnZJb1BabWlXdkZGUStVUEpmcGZqYndLSTBXcmtlaWxma0RvbXR0dS9UWFlP?=
 =?utf-8?B?aEp6UWxwdW9TS01yVEZQUUQzaHo3UHllUE1NQ2V2Y3JHSTYybkZWSGgvNzBm?=
 =?utf-8?B?V1Jjc2RlSEE4cmh2dDBBVTJWMk5KQTkyM09vOGZ4aG0raDFERnBTK2JTUjY2?=
 =?utf-8?B?c1dYT1Z5ZVJKRWRaOXBmbS90RXFtOGN0c3dHT0ZFWTgxQU9XSUhkdm9OY0xh?=
 =?utf-8?B?MkFaSzg3b0diWHcvMmNQQUVCZFdIdUR3dUh4WlVkaWI3cmJuZmtMTnpiSFZx?=
 =?utf-8?B?VktPbVRpRGd5MlJTelZEM0NyeW9aZzcvdGw4TWRZZGY2OFhFd0ZkUDZQS0Fv?=
 =?utf-8?B?TmhUVHR5bnBpQnhVWlgrU3dXdzIyaFF2bTVtekhHWjNmNWt2TzNVYkNEQnhk?=
 =?utf-8?B?eEZzUWdBamh2ODVWcDFhMWY3Unc5ZmhhS21LZGw5cmxrdWc3UHpwVzZ0QW5i?=
 =?utf-8?B?OGIxQjRDVmF6dk5rZ1NMV2FoQ0M3dGlybmJ3UTMvY0RYRkZRN2tFblVlaWN4?=
 =?utf-8?B?Q0t1WG1DZW02UnNRL1VVKzYwQVliUExscXAxT25INWNJbUVWVitsWmxJdzh6?=
 =?utf-8?B?d0NCV2w4SE9oTkRLYm5jN1kvR0NxUG52MitqVThFM2ZzV0tScDUvY3h6V2U3?=
 =?utf-8?B?aUNmazBzb09Qd1dMb1VRYmRNNWxaWlZ1dFVOekExdlFFdi9DTjdrelgramsx?=
 =?utf-8?B?TEhMSklrbGRWanJjTW9NVTN1ZUtUaXQzdkNoV3R0Q0R4c2crdk5HbWtaMHRm?=
 =?utf-8?B?N1lOaHcrVDdYSWZTeUhpVEJPWjZxMVJlcWlqcXAyZS9Pem1MV3QwTzZrZEFG?=
 =?utf-8?B?VmlsM05OdWZoV0FTRTF1c2d2YzJpUjlJWDQvRjM1bHhvU1VaN25Fbm5mdVR6?=
 =?utf-8?Q?8nginyeX3/V5gmHN77kSLw4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzkvWk5MQ0FHa3o3RHQ2MkZHaUdjQVJkZURuanF2UGRMUzVIT1ZsSWkxU0FL?=
 =?utf-8?B?TGozVGU2M0hCSlpNcDQ5S1h4YzhuL1NkcEorbnBtcFU3a1ZrY0RXZjZnQk9K?=
 =?utf-8?B?SExMancycm91UVNrVGhraURCWlFLSXAzVWdKR3BKQ2ppcWh6TmUzeWh0WHl5?=
 =?utf-8?B?WThEcEZjVzVGR0hsUDJvNFJleTFRdGRHM3dvbC9QUnJZVklrSzhrNWdBdGh5?=
 =?utf-8?B?d0FwQndVRXdpRXk1V09iZ3hySHA0UThFbDFFYWtEckpCM1NnSld0blpMSkFi?=
 =?utf-8?B?cHlzZHZ5TGttUENVR3ROamcvVFJlN0lvazZMZDcwWVJWdkN3QnFvaWZENUZn?=
 =?utf-8?B?U1VpRFhpZTU2Zzdua0dtMU8vaHY3Zm5EeUVaNmNyM1ZrZHVSdzNDT1M4bE5V?=
 =?utf-8?B?ZUVYaVYraEwrSHhCV01WWklnSW5TMDN0eFVjUmRtUkIrK3Q1U2J2TWNiWUtC?=
 =?utf-8?B?VmtwZ1VzRnZqNDlJRnUxZWszN21uMm5DVkppeXZVN3U5TVdzcTJMR1hwT2sz?=
 =?utf-8?B?ZXlLcVcyVmV6S3ZXMHN2NG5kVzcreU9ySFJVUU1aZnFQRkhWZEV6T1hCQThs?=
 =?utf-8?B?NVIrZ2FjSEhvOWZSWVdQUkVhZHZxYlN4L2RwU2V3TWZFRm5NMUF3enc1OVZt?=
 =?utf-8?B?d0hRNkcvd0RoSGNKQlJ2WUVFQVU1Y2RQZ0JPM1JNdXFMZTliSEpoOVhSQ1Fj?=
 =?utf-8?B?RW9ZelA5bjhNd2hOMVYraG1LU3JNOHNDYkNmem9RR1g1ZC9vNFh0TmdSUGhX?=
 =?utf-8?B?TEJnYXNMWEVkaGxPWFY3OG5VT1VEbEt3K0dabTZLejJwMHo5T3Bwanp3T0J5?=
 =?utf-8?B?dmU5bTdFU1cwb1JUV3BoSTJTV3hobXExdWI3azBRYlVqVitJYXRhaHdJYmF0?=
 =?utf-8?B?N3pVRGt4Q2ZLd0ppVFhPcitLTDBsdXNqbGlkczVmMlJPUC96MzNHWnZDSm5k?=
 =?utf-8?B?NHIrVmY0emlrYWZranhkUzV6NlJUUnBHcHhPWVZyS0MzNSt6RU9QdU03MWg2?=
 =?utf-8?B?THU0NFpkcTZSWTVTeVpiSEYraUJ2THBhR0tFQ2lSdkExU0MwT1lhUFgrdVU0?=
 =?utf-8?B?Y3VESG4wZ05LY3NFdktQREJwZ1lSem1KZkRjRFdFRW5YTXVkZDZwQ21LOTRx?=
 =?utf-8?B?WU0zemg5Sm5NMjhMQ3QyRmIrVHQ1eU9vd1V3eHpvbVQzeHY4R3hSeUc0dnVT?=
 =?utf-8?B?N0ZKWk5OLzZabFNRQUNuaWhiZFZKdS9mb0ltWERHaHJFYm5TajZxQ2ppa01L?=
 =?utf-8?B?YnRlTU90UHN1THJuRHFSU0FjTk1UL3ZncTR2eDJPZHFxTnBFa1ZBc29qcWFM?=
 =?utf-8?B?NEhMb3l6djhpelBMN0UrSzRNMERHUm9SVWFvQ3lJOW04MldrY0ZVWDViVUVl?=
 =?utf-8?B?bHN2eU5iS1ZmaXZJbTdtK0hvQVZHYzZ1RUdWdWdhUHdVU2hnMXJpSFI4MEhK?=
 =?utf-8?B?YUNOWmt3YzBtTmd4Wm0xM2ZmVkpaUC9zY0lVYXMxSTU5L3V1eEptT2Z5cDdK?=
 =?utf-8?B?b0NIdEJnTWx1MkZNVlNDNU9hcngveWRlSzlzdGdrTkt0YmU5Z1VKTXhEYUZN?=
 =?utf-8?B?WGtscjF6RjUzVWh3Uy9rVE5OQnJSeXZ6eStuT2JraC9xS2RGVE1NQk1CUm4x?=
 =?utf-8?B?emRPTm9yVWc5YmRSUmFEcERwdlFCR1VBSU9aVkFxNVZQWlhRMUlQY2dwR3Y1?=
 =?utf-8?B?bDY2VUFUbkthZWxqeThWWVhFY0lrMzBEcElwaWFLQ3JpK1pYcHk2N2t6TExH?=
 =?utf-8?B?aFNrT21hbCtEN3d3TmVWTGVla1BOeTBibDE5ZGt4dUVkR3NYVUZrbVgyV3dl?=
 =?utf-8?B?M201ZFgwcUNCMEZpbFRRUkRaVGc2M0lQc3pQbE01enBzYUJzbHYxL0F4enF0?=
 =?utf-8?B?OFFHekowdjIrWEdkdFJVSGFVZGpMWWJwQ2h1WGwydVcrbXFNUTQzOHFvdzhJ?=
 =?utf-8?B?TEZ1akNlallUcVRnb2Z5TXlJWVUyb3dVd3B1QTFEOWRVcmtvVm9GeHc0czJz?=
 =?utf-8?B?c2UrM2lQa0x0OVRnTWttaTRUWGgyR1E4Wjdyekc4aU84QUJIOThjMi9wT2xJ?=
 =?utf-8?B?WTdSTGQvNWlwemtZOU5NZWhFMjJMekxyY01QNy9WLzNyYzZGUmFzWXRZbkxz?=
 =?utf-8?B?OFJFVzB4azF3VldIVjVhRFRvUll0Sk9WWU1KMU1hdWErbDRITVpqWWU3b3pT?=
 =?utf-8?B?d1NxenJtVXVSV3NVWWJxRzZaQm5ZSFV6aWlUVG44L25jelF4dmFxMmtnK3Rx?=
 =?utf-8?B?dXcrN3RBTnJyU3BRL3VxZEVDb3lsdFMzQWtxUUZmYVZKbnFLRDdDbUtaWERT?=
 =?utf-8?B?NmZjdXRkaGgzeWlZRlpySG1RS0VRcTJOVVNINHBhVGViM0FaaEtIRVdOOFVW?=
 =?utf-8?Q?JVCNKB2R+Ucsx3CE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C7D16050C8593479A547342DAD18A22@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3256ce91-c61b-4642-a230-08de5a48df4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 06:30:16.3395 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZMmOVRhw4Fsct6saOFBl1r90paTP8Y40Ynrk7mP0bpyEb3w2GP/DRl/oLqs3zj2RnKWVawcID5smtQU6XRCy1Ph4/3FalK8lGq6E5lFgV+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6818
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

T24gV2VkLCAyMDI2LTAxLTIxIGF0IDE2OjM2IC0wNjAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOg0K
PiBJbmRlbnQgYSBicmFjZSBmb3IgcHJvcGVyIGNvZGUgc3R5bGUuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBEYXZpZCBMZWNobmVyIDxkbGVjaG5lckBiYXlsaWJyZS5jb20+DQo+IC0tLQ0KPiDCoGRy
aXZlcnMvbW1jL210ay1zZC5jIHwgMiArLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL210ay1z
ZC5jIGIvZHJpdmVycy9tbWMvbXRrLXNkLmMNCj4gaW5kZXggNjlmNTRhMzQyYzYuLmQ0MzQzNjM1
MDhjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21tYy9tdGstc2QuYw0KPiArKysgYi9kcml2ZXJz
L21tYy9tdGstc2QuYw0KPiBAQCAtNjU3LDcgKzY1Nyw3IEBAIHN0YXRpYyBpbnQgbXNkY19waW9f
cmVhZChzdHJ1Y3QgbXNkY19ob3N0ICpob3N0LA0KPiB1OCAqcHRyLCB1MzIgc2l6ZSkNCj4gwqAN
Cj4gwqAJCQlicmVhazsNCj4gwqAJCX0NCj4gLX0NCj4gKwl9DQo+IMKgDQo+IMKgCXJldHVybiBy
ZXQ7DQo+IMKgfQ0KPiANCg0KUmV2aWV3ZWQtYnk6IE1hY3BhdWwgTGluIDxtYWNwYXVsLmxpbkBt
ZWRpYXRlay5jb20+DQoNClRoYW5rcw0KTWFjcGF1bCBMaW4NCg==
