Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 205C0EFB7F0
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 06:58:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93D838366F;
	Wed, 25 Feb 2026 07:58:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="W15mPdV3";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="DbZwaF8a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2910183946; Wed, 25 Feb 2026 07:58:25 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BE5E82A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 07:58:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: 5beecd08121711f1b7fc4fdb8733b2bc-20260225
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=YlMhKsy2cgJaIn+vPVw1Z4TKgQGFq2vqNeo7qRKEO74=; 
 b=W15mPdV3aFOr2FM7CMPV5B8H1cRpq5c/fbLgmipbdT3zf8xpVHwB7aqy3W9ng3nG0PI0RJGuCxq87ah0oq6SW5xSL7IyGQVrke04QDcj0QezPRX02U298ChzzDaYV/Qr7WXafWMz7pCnBvIBUAAmfShYNC033jz5KleeQwsI+dk=;
X-CID-CACHE: Type:Local,Time:202602251457+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:623b1e12-1670-45cf-af98-6c6a17ca9695, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:89c9d04, CLOUDID:c742965b-a957-4259-bcca-d3af718d7034,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
 C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5beecd08121711f1b7fc4fdb8733b2bc-20260225
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw02.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1955500630; Wed, 25 Feb 2026 14:58:16 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 25 Feb 2026 14:58:14 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 25 Feb 2026 14:58:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvxpOpiZZJAb6WeOh1Tw3bplQJ5cIsmROKwXEz5bWL2uilQ6qVtOLDMhBWtFtU071BPA0p4UV+PlWaCgraZp+bNsFnFTTIWXfah4csKNFRWiMiuvjcAirr0gcwsh8SnHE20gIqXEN2R/JZxhsMtfFgDqFD+IhHAwfqnQ6VTKPvv4tht5K+nUezxGwuCnUJQCn0yNjEzflRZHEsRkHz8oFVi3dT8D5S0YiHFt8zcopav0HrmLuMHXtB5y7UX7U3UShoW10FJmCm7kdGVWXQ1vkbQeEHsjN+nQR0NZHm6/zKgHxsmADA+G/6dmiEA2hlgPGnj8H1KYYJM9NHw+Od94gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlMhKsy2cgJaIn+vPVw1Z4TKgQGFq2vqNeo7qRKEO74=;
 b=qq6fdnnEnO0bc3IuMh6FF6Ca+wG04N0aIVWLVrO/POh4cKkEpFOZBIio1i5nBryKBL3h0AShAyn2+dWfUzgcX30Syena/iG1HltSommWK8iQ0MDyohBN49TpyfCu4gU+uCFfcfbN+cFMTFgK/0gQTJHAHZVTlMFkM+K8jtSIeP2+YZYWSJcExOmVpXOjWwK3PRIoZdbDQuwtin+2S5XIjS45jEt6RdPALRPGNhUFxyZ0IyBkpSN7dmpayFa/7AUzxYEuw2yziOxYVALiYlhYPfSzmG1M0NHgnhHMrnaJODdIAzojrj7D1/1zquFYF1QJBR/Xtd8TxKxnTWDNg4of2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlMhKsy2cgJaIn+vPVw1Z4TKgQGFq2vqNeo7qRKEO74=;
 b=DbZwaF8aKuXqNZdPdjk6zVQquQ5wfxH0NrVaLtnjkOR39E8elarlEb+IBSRf4igVRhquNzoNpTumASOU09/VmWKHzmGncHJeMYK7hHf3g3DGWRIJL5CLLEQwMbCJoL7e+kKHEHfH4VwuFxvJtcnb6ykvYtjyDu4WxjNaYWiOWe4=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by JH0PR03MB7384.apcprd03.prod.outlook.com (2603:1096:990:11::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 06:58:11 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 06:58:11 +0000
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
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 2/3] pinctl: mediatek: increase max number of base
 addresses
Thread-Topic: [PATCH 2/3] pinctl: mediatek: increase max number of base
 addresses
Thread-Index: AQHcmh4YvjCadr4DlEiHc4AeH3pJz7V+3+cAgABpRQCAE8rLAA==
Date: Wed, 25 Feb 2026 06:58:11 +0000
Message-ID: <2fefa7f6e9b28c918abf86215206145dffd50faa.camel@mediatek.com>
References: <20260209-mtk-pinctl-mt8189-v1-0-a7a3069eda6c@baylibre.com>
 <20260209-mtk-pinctl-mt8189-v1-2-a7a3069eda6c@baylibre.com>
 <f517099b1f4fcfb974d106316dd31c4826872b42.camel@mediatek.com>
 <2241d6aa-c979-4305-abb3-f2cce85d90b6@baylibre.com>
In-Reply-To: <2241d6aa-c979-4305-abb3-f2cce85d90b6@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|JH0PR03MB7384:EE_
x-ms-office365-filtering-correlation-id: 15fdd8bd-cdd9-4158-4dfe-08de743b3d45
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?U0dWcTZyVWtoWmpzR29ETkVQSExIcVFpZklMVTJKa0VqK0VyQXZJYW1qU0dQ?=
 =?utf-8?B?L1o2QkE1NzRwcmd0M3RWWGFjVW12OUhuVGQ2akJaTVE4Ly9rd1J0eFYxbEsr?=
 =?utf-8?B?V2RKalJVMEJiVXQrd3ZyNzJQY0VuQUNqWGw0ZnZaMkIrelB6ZHN6QVZLaFI5?=
 =?utf-8?B?MHJrWjRMMnZaT2pBWUxadmhMd2hBVE55YVhPcStiMU42dHpBSEVBUnM3cEwz?=
 =?utf-8?B?ckppZnRHc1FXNURyV202ektFRVRkeGdONXZNb3NtV2ZISzhmdm5nN0l5YjVq?=
 =?utf-8?B?K3lRZjJobzNEMFF2eU5rUU5YZnhGZTFVV0p0SVIrY2RwTTVNSVY4UVhzM2xQ?=
 =?utf-8?B?YkJqeU84ZnRTdzZ0ZEdXVHJYSlhwWjlLdkVwYnJtZk9GUUl2TjE1QlcyTjh1?=
 =?utf-8?B?TFNJM1ZPN1J2d0luVTVlS2V1YlYrbjRKNjN6aUVvYkY5WmdKRFNJWjYzYkVp?=
 =?utf-8?B?aVV4RU5xSElSNFVSMm13clE3WFNtTkdlZUZralVKU2JlUTYvdHlIVCtPS1l6?=
 =?utf-8?B?RFpuR1VrV3lsdDNVV2xicHp3WW0vdGZSQzcxNmM3SmkwYmdaa0dLWHlCc1Vl?=
 =?utf-8?B?M0l6LzYrUEdkVWc3eHFaNmN0T0x3Y0tibGkyeDZvZDJ0Tkdwckc2L1FSMFY1?=
 =?utf-8?B?eWRobk1YMVFHTHVpSnVNeGJiNU13aERmYjVPRDRUaFF0eUZRVWpvb3YrMTZz?=
 =?utf-8?B?cXpNK2tkUHAwYWI3ZjBmWUl4TnJKbGs0SHdGRk5hclE0MWJXbGpwSk91ZmJn?=
 =?utf-8?B?Vy9WU3lmMGhGUlhiVXJMNDhSeWRiUTIrRndIZlQwMVJydDEwVjMwQUxJMjZp?=
 =?utf-8?B?TjBnSTYyVTZ3cjA3ZmVUTVJOSjlMR0lmQjBOTjNoVjFaTWRYbmV4d0Y2SlNs?=
 =?utf-8?B?ZnFTdU9JZENubnBzUFIyVG5yN1ZPVC9aYXBLK1ZUMmZXMmRSYlVueklwQnl1?=
 =?utf-8?B?MDVSUzV6ZWhOMnpYeFQrRVVzV2VTSGJWc010aklIT1RMMURNMTk2WU00SWJB?=
 =?utf-8?B?cjN1aWpSOEdTcUZGdVZYQWMyOCswRU02MFJCYnJHQmM1T2k1eFU2L1I5LzQ2?=
 =?utf-8?B?S08zT2JtTG9Ob01SR0JFdnJTR0hsVFBjZDVvWWNSU0ZZci82VnlrKzd2SE1J?=
 =?utf-8?B?QkIyc0wzTHNzdXZGYndpTC9rb0t3L21lTFJ2cTlUUTIrVHBUQUhodUY5K0p2?=
 =?utf-8?B?NFdtcUJyMEJ6U25lNjhVUjhMa0duU09VMVZkME50R3VzQVcrbzRTME5GS09v?=
 =?utf-8?B?SU5LSmZBNlRteGFMLzVBeDcxNTNIMktsb0hQWUpuSnJyTkFnL3AxYVpQR0Vh?=
 =?utf-8?B?bFFYOUQ1dUpJaGo0M2h1cE54SGk0eEJJaFhtRS9mSkRVMDRrVEZWYVFFaVJ3?=
 =?utf-8?B?ZTZ2MkxwVWYyakFPNjZab1VKY1NNYXhCMzY2OXUxcThSV3l0OEdJdjM2ekla?=
 =?utf-8?B?VlE5MDNnd1VSbGEwS2RzbWJiQXdjcURDYVBpamdvR0JiYTFzeVNVS1cxQVJ6?=
 =?utf-8?B?U05tWTVWSnQ3RHprd3hISTNyb0JvNFZsV2YzUm9tTFcxV1NzWWRJM01jaEpM?=
 =?utf-8?B?NDVvS3lpaU1xbENjNVg1dERhbnFpRmhkbC9sNnZNQ2Y4eWt5TXAycXIwQnFj?=
 =?utf-8?B?ZWJnaTZreFFwOU9JSGQ5aWVnVnFnL1E2aERwdzN4em1DQk9VU3p0SzV1MXJh?=
 =?utf-8?B?eWZpZlVuU0tYUFhqS3ZuaTRpTm5nYVVSY0RBUFVmSFVSUTNpQjRTR3lKcEVj?=
 =?utf-8?B?eE93YUVxMnh4SXBYaW5ZNVYvTkEzc0Z1ZzhmRXlqaWd2Qkx0ZExpRUVaUmRv?=
 =?utf-8?B?eDM5UmlmbEQvYmJidk41VlZaeDREb3o2ekM1U2R5dUxkTTFRREdFNnhjcHh4?=
 =?utf-8?B?dHp6YzdLVGhWWGdrVktVbGlNeXY5NHFLaXNObWtyYWpoam12TzRBc0ppdTVx?=
 =?utf-8?B?bnRvOUlUMDlRNkEvK0RxU2xjVVB0THcva05QRVZ6NS92V1FDWVVISHRwSHU2?=
 =?utf-8?B?ZUF1dG8zaEY1WWR1ZFVoc1VHL3gvNGE1dFgrZ3hUamZuQ0pjN0t6SklkYk9m?=
 =?utf-8?B?dkl6L1dseHhRUFpHMHhveHBaQVU2S0pCNzhNVlNXeWNjVmFqWUNTMlJ0YUlJ?=
 =?utf-8?B?dEcwd1h1UXl1MDZ5R2MwZ0JPRi9DeUlvNFo0UEhCeFRDbHhHRnBaQ1NxWjE2?=
 =?utf-8?Q?02+GUkMHhs3MeZVqTRGKlEg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2xRcWtsV2hkVVZTZ2NaTndPd3pXUWFOYUFQTFhuWWEva2NXQTVMZzVIeXAx?=
 =?utf-8?B?N1VHYXlQZTBjLy9YU0puMWp0bVcrRHc1WU9PakhlM09uV2pWbytJYkxwQUlG?=
 =?utf-8?B?ZXYrOUpPOGw2c0NwNUdhVDJpS05qdVdKanBMcHlFUENYMjVEZkw4WEdyMytu?=
 =?utf-8?B?OEZKVjJLM1FJYThnS1ZmZjY4UFZuVFNnMnc4UW43M2hRdDBXUXNpdEMyTUVX?=
 =?utf-8?B?L0NTOEs5Z3drSjY5anpTeElvSmw5V3NKa0NmblhpMFpEU1M3c3hpQllyUmpx?=
 =?utf-8?B?aVZFbHZORXIrTjMyYm96eS9FeFlQMWFmR0Rka1d2SWFaK256UEVFOHhkVDV3?=
 =?utf-8?B?N3RPeUVLaXZhVmtESzFuK3BVOWdzaFVOLyt3MktEY1U4TkxkbUN2TzZ4Q1E2?=
 =?utf-8?B?eXRGT3I1QlNXSUNTejlzbUlGNGthMlVpR3Nsamh6S3R6UUgzNmg5NnMzRkQz?=
 =?utf-8?B?SWFWZnYzRHJpQzl6bC9YVXpOY0lYWDV4S2lacExic21wUFlkQWpxZi9ocHdQ?=
 =?utf-8?B?eEVSbmFKTE5wQUtZdEUvVWNrbEhYSEsvbEZIMnFpYVF1U0wyMHRERDNta3Nl?=
 =?utf-8?B?am1KMDlpbmwzY0tjTGkwbVpad1h3S1dDQkU5WmlLMG5uOXhOZXUxRkVNT1Q0?=
 =?utf-8?B?U2tGc1ZENDRlallpemhXdjl2ZzhKcG15eFRWdUUrOVNCUUx5Z2ZuQm9aTWNH?=
 =?utf-8?B?SjFFME8vRHJ6M2VKNzdBQWZ1RHNGYkUvOVNwYmRLYnV4UWEzRXlYRXhDQms4?=
 =?utf-8?B?K1ZLZmFybC9GOFVPU1NybTV5YUMvR05VVkhrZ08xQ1UvQ3l2SG9hckV4RGI4?=
 =?utf-8?B?ZWdJb1pnYkc2RmJjMWxqRElYWnhKbzY4MDJGVGJRZldXNWJ2RG1ZMTM3eUw1?=
 =?utf-8?B?b2lhZjlxYnpUWWFSTzB6Z0E0Ump3YWZlMzIyc0tlWW9tSGdFdXhObWp5RjdR?=
 =?utf-8?B?eGxFZFFRa3R6a012TUs5aVp5TjRtcllLdjJYVDcyTi9HNDRQUlZrWkwyVFJF?=
 =?utf-8?B?czNjMW1IKzc3ZllqdFV4TktZRmk0ckw0NGFwQmthakxLYmpueUQ1VEY2NzVS?=
 =?utf-8?B?UnlvdGdWb1U4K3MwMnJaRitjU2JPeTdzakZZNU1qbzNhOG44NWVJVVhnYXlK?=
 =?utf-8?B?WDh1UDRDMTdLd0Y2bzE0dnJSL0JzcmM5WkcwTEtZTWdiRnMyOVBOdUw5ZzVq?=
 =?utf-8?B?N0VPaVBVRWNFQmlXNFZtUWVKWEhtQmJKWnpxR0dDQWdEcnJpcDhZaEhTRGQ3?=
 =?utf-8?B?bC9sM1JkNFFocVdMNXIrZGI2ZUIxSG1VUnhRWHNtLzUwK00vc2xBZ0NjVGpW?=
 =?utf-8?B?Z2duTnJoak92KzE0RXZMZEh2WlczQkJSNmd2dXpSeXU2ZVBrN1VhS3ZnMm4v?=
 =?utf-8?B?OExVd0p6WDFnZzFjV3I1ZFN4TDRpRysyd1UyVDBjMWxZU3ZRckhJWVBCQ01F?=
 =?utf-8?B?VVJySWZlUThpdytZRUxwdjNjZUcveG9sMmgyWWxvZWV6U0I5Uks3R3BCZExW?=
 =?utf-8?B?azhLQmRiTlEycFVEcHU3c2c5L0RPeEVmVFJuZmJTSmtWL2lBMUhXeWpsb0E3?=
 =?utf-8?B?WnMyMzJ4Y0VubVo0dUlTSFdURlZYaDhBNUxFbURrSElKWFN6Y2lmSWIxNDdW?=
 =?utf-8?B?MEZ5aWU0bjRlcHBVRTBJK2lNTVl6TEJXdjIxeFJJL1dkVis1VzZsMjBpaDBp?=
 =?utf-8?B?WG5RVmxZNUpML2NKWTBnL2xNNHZSK3d6VFY2b2UwMDVscTNtSWMzNEdDeTgy?=
 =?utf-8?B?Z2hua09zR1ZYWTlZeTN5bUw1YUQ2cHZBUlE5UjBjTzFEVzg4WlBNQ3RJNFg1?=
 =?utf-8?B?QnBiNEFFNG5LTzVNZWgvdEZwM3E3SkwxeFZ2VXhVQkRpQkRoWTk5RGRSRThV?=
 =?utf-8?B?YzMwTnIwN05hZ1BTYnY2L3UvdTlrYTdnVmtxcFJPU0FFOUw3aFYzdTY2c0hY?=
 =?utf-8?B?SGJMQTF6ZGZBVkFydlFDbFRyYjVxcGVteHNIUkwwVkpoTlRCWDR0bnZEbmEy?=
 =?utf-8?B?bU9IN2llNXdGdU52aTlXdE9XLzBQeEdBTzdRdVRoM2tjV21YeEwwNFNRT3VQ?=
 =?utf-8?B?Q3hHSzA3R2RQaytid1JMblFKc3RUQ3RibjRIRzlZZExNbnRSMHFUN0g4U1pF?=
 =?utf-8?B?R0tBUlE2ZmIrK1hkcjZpaWdKMi91em55anlFNFdCNlV6VlhEVVYwOTY2M1VG?=
 =?utf-8?B?NzNGRlh3eUJ1NVd0UE8zWU1EaXVBTkJDSHd2d1VybmN0dEl2alRGUUJlOVlT?=
 =?utf-8?B?TDcyRHdMVjI5WHZKVk9OWncrUUhGVGVicG9VK3JsNzlsdmcyaFcxOGR6M1h6?=
 =?utf-8?B?MnZWd080ZGlCUlQwbDNkaGM1dHBPQ3JjRExPSGtqelJDU1V3L25qQk5ncHhk?=
 =?utf-8?Q?mSoyS/2BcQdldmRI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE46CA6AA277CC47B29E6EE9CFED83E9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ItCa2tWaSN9ukI+gh2RQBUQb/j88p4Itf3AX4XX3K7P2RC1lDnsBL9SQsN3mh+Mg+vhlLJDmmaJ5Kcr+33Q+p9mH9m82a22/3Y/2VD8aCT5MSro46Zag/tnSU3rxGHI8glWWyRCwJHLsaaMiKouDSEnAqrFwRGPqh8t6XpdoFtsBvuV0MYQOuqcEKdGJIo869g/lDxvsgfH1EQLaWYx2QwsXUPrx3RfAITGaQH3G5YO2UWsZc/jrwpcDSKiOUR8YeLRaIS6GuhG27Vav25GBHExRIOKL/JI3NrkWDHgmiCx+No433UqiSuzT7lXN8EPuS5lxDqdwLIxiVHhLAzr3vg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15fdd8bd-cdd9-4158-4dfe-08de743b3d45
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 06:58:11.2818 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OqyvV9Cw2/kPmCZkfWQW4yrkR4I87irAraICscCj5BIeHEyme/mzRMRAznciUJTAA9Fm8fSuvxfpFralwNzUl8SDoEU9OF+HLcZnLaew4q0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7384
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

T24gVGh1LCAyMDI2LTAyLTEyIGF0IDEwOjQzIC0wNjAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOg0K
PiBPbiAyLzEyLzI2IDQ6MjYgQU0sIE1hY3BhdWwgTGluICjmnpfmmbrmlowpIHdyb3RlOg0KPiA+
IE9uIE1vbiwgMjAyNi0wMi0wOSBhdCAxNzozNCAtMDYwMCwgRGF2aWQgTGVjaG5lciB3cm90ZToN
Cj4gPiA+IEluY3JlYXNlIHRoZSBtYXhpbXVtIG51bWJlciBvZiBiYXNlIGFkZHJlc3NlcyB0aGF0
IGNhbiBiZSBoYW5kbGVkDQo+ID4gPiBieQ0KPiA+ID4gdGhlDQo+ID4gPiBtZWRpYXRlayBwaW5j
dHJsIGRyaXZlciBmcm9tIDEwIHRvIDE1LiBUaGlzIGlzIG5lZWRlZCBmb3IgdGhlDQo+ID4gPiBN
VDgxODkNCj4gPiA+IHdoaWNoIGhhcyAxNSBiYXNlIGFkZHJlc3Nlcy4NCj4gPiA+IA0KPiA+ID4g
U2lnbmVkLW9mZi1ieTogRGF2aWQgTGVjaG5lciA8ZGxlY2huZXJAYmF5bGlicmUuY29tPg0KPiA+
ID4gLS0tDQo+ID4gPiDCoGRyaXZlcnMvcGluY3RybC9tZWRpYXRlay9waW5jdHJsLW10ay1jb21t
b24uaCB8IDIgKy0NCj4gPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRl
bGV0aW9uKC0pDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BpbmN0cmwvbWVk
aWF0ZWsvcGluY3RybC1tdGstY29tbW9uLmgNCj4gPiA+IGIvZHJpdmVycy9waW5jdHJsL21lZGlh
dGVrL3BpbmN0cmwtbXRrLWNvbW1vbi5oDQo+ID4gPiBpbmRleCAxNWFiM2MxYmYwNy4uNThmMTM2
MTM2MzMgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvcGluY3Ry
bC1tdGstY29tbW9uLmgNCj4gPiA+ICsrKyBiL2RyaXZlcnMvcGluY3RybC9tZWRpYXRlay9waW5j
dHJsLW10ay1jb21tb24uaA0KPiA+ID4gQEAgLTksNyArOSw3IEBADQo+ID4gPiDCoCNkZWZpbmUg
TVRLX1BJTkNUUkxfVjAgMHgwDQo+ID4gPiDCoCNkZWZpbmUgTVRLX1BJTkNUUkxfVjEgMHgxDQo+
ID4gPiDCoCNkZWZpbmUgQkFTRV9DQUxDX05PTkUgMA0KPiA+ID4gLSNkZWZpbmUgTUFYX0JBU0Vf
Q0FMQyAxMA0KPiA+ID4gKyNkZWZpbmUgTUFYX0JBU0VfQ0FMQyAxNQ0KPiA+ID4gwqANCj4gPiA+
IMKgI2RlZmluZSBNVEtfUkFOR0UoX2EpCQl7IC5yYW5nZSA9IChfYSksIC5ucmFuZ2VzID0NCj4g
PiA+IEFSUkFZX1NJWkUoX2EpLCB9DQo+ID4gPiDCoA0KPiA+ID4gDQo+ID4gDQo+ID4gUmV2aWV3
ZWQtYnk6IE1hY3BhdWwgTGluIDxtYWNwYXVsLmxpbkBtZWRpYXRlay5jb20+DQo+ID4gDQo+ID4g
SG93ZXZlciwgc2hvdWxkbid0IHRoaXMgcGF0Y2ggYmUgcmUtb3JkZXJlZCBiZWZvcmXCoCANCj4g
PiBbUEFUQ0ggMS8zXSBvZiB0aGlzIHBhdGNoIHNldCBmb3IgYXZvaWRpbmcgYnVpbGQgZXJyb3I/
IA0KPiA+IChIb3dldmVyLCBpdCBzZWVtcyBub3QgbXVjaCBpc3N1ZXMgYmV0d2VlbiB0aGVzZSAy
IHBhdGNoZXMpLg0KPiANCj4gU2luY2UgdGhlIG1hY3JvIGFscmVhZHkgZXhpc3RzLCB0aGVyZSBz
aG91bGQgbm90IGJlIGFueSBidWlsZCBlcnJvci4NCj4gDQo+IEkgY2hlY2tlZCB0aGlzIHdpdGgg
YnVpbGRtYW4gdG8gYnVpbGQgZWFjaCBjb21taXQuDQo+IA0KPiA+IA0KPiA+IFRoYW5rcyENCj4g
PiBNYWNwYXVsIExpbg0KPiANCg0KVGhhbmtzIQ0KQSAiUmV2aWV3ZWQtYnkiIHRhZyBoYXMgYmVl
biByZXBsaWVkIHRvIHRoaXMgcGF0Y2guDQoNCkJlc3QgcmVnYXJkcywNCk1hY3BhdWwgTGluDQo=
