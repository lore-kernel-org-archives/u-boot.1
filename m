Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3B1F55449
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 04:19:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3271883E76;
	Wed, 25 Feb 2026 05:19:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=airoha.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=airoha.com header.i=@airoha.com header.b="JwULLxTg";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="dkVKbp/d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12DE283DCB; Wed, 25 Feb 2026 04:08:03 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3A6D83C39
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 04:07:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=airoha.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tommy.shih@airoha.com
X-UUID: 2a9503f011f711f1b7fc4fdb8733b2bc-20260225
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=airoha.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=pGeadrkBLSJ2w9t+2H+0yAKM5EOIzxtb30eD+9vip30=; 
 b=JwULLxTgFFokck1hdSaSLi7sw9YGFrD8ub6r9tyH9ox0XZJiy167ApuF3uAvFNC0yY3dPhyOGFU44cGwH5sGpFRZ2+UMwE6JHoO5fClxGf9UPOBZ0Z5mc4jgvm/x0Tmco7+vUdR9KubOXBUI3wHAt0IG6shnDQZdGX0w447Vr6g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:eeab0a52-c3b3-4750-930b-530711ee1db7, IP:0,
 U
 RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:25
X-CID-META: VersionHash:89c9d04, CLOUDID:f030faf0-16bd-4243-b4ca-b08ca08ab1d8,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:11|82|106|80|1,File:130,RT:0,Bulk:
 nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BR
 E:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2a9503f011f711f1b7fc4fdb8733b2bc-20260225
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw02.mediatek.com (envelope-from <tommy.shih@airoha.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1943868505; Wed, 25 Feb 2026 11:07:49 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 25 Feb 2026 11:07:48 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 25 Feb 2026 11:07:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c0ra0r4twwH29mSXs33yxc61xG7xMVA2NdO67eGdtrqKN1ue1mfidD1dPxWYsp7T/JreOShYp0KEuW76PoxhyYNrs1o8DJ48rKsZPSL0PihQTDEil4dNuIdoMtFnuS2DTfeL0W2AG/cpbV2h9qvzJBloW3jOTpzM0yV0zLsRD+ONxksjeJr6pyiS7IzhMwnBCYFZlUGTxbEQYvpC7Afkmt+Puv59dhzAXyt5SbdkOCGJvxCeuGSuOu19vySzNFYEUdMC6hPEsQPyzUqfwYUSvPvAeZDi+wWu9Rz157Gw0EWCENLShaOVjXKr4enoT9wwCIYIQxU+bPVAME9crLhXtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGeadrkBLSJ2w9t+2H+0yAKM5EOIzxtb30eD+9vip30=;
 b=As6/Zl2l4HNLRMI0g1s2yZ8J5NjvLQAkkwXhBDGlWsw1JtEikg2XQHiwrvleg77UpEnt/tsaT3QAKk5iJoLn/M1BLJSz6S/TN1jv3KzSre2smcX3JZkpL6dkSxAJh7FBWJioMX1Ro2S/TFXO7uT8Ey29gSuglMQPt096iR6wxfjlRCiXzgs/D0m5DDdsq5zjaqq6eSpuIPVdDZu/2U1IxyvOqam/LTB9B+OX0qApURYd9nDBm8OdR3qnCUexfqxDVLdgD3vaN6WcfZPcEeloFOGNZpcgRbw7QNbecBtowY6qeFwCcwXo4rh29CK6ivmI16Zrv7noX+GFx5e85kOxTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=airoha.com; dmarc=pass action=none header.from=airoha.com;
 dkim=pass header.d=airoha.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGeadrkBLSJ2w9t+2H+0yAKM5EOIzxtb30eD+9vip30=;
 b=dkVKbp/dSnU6wZWtrAPgnqEZlDrt0NAsk26q30fuIbh9IuOls0FL+8rlMKWz6Bx9f7xvTTrvI+GFf2ZHS73D8UVHMUD1v9h8IgonQhrfquHZbX+OVSPWCzYzRH5wvl5I8lLHdsbtVddDeXPMPwuGjiBZHyaFDO1ty3zAN0M9lVc=
Received: from SEYPR03MB7816.apcprd03.prod.outlook.com (2603:1096:101:166::7)
 by SG2PR03MB6454.apcprd03.prod.outlook.com (2603:1096:4:1c2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 03:07:45 +0000
Received: from SEYPR03MB7816.apcprd03.prod.outlook.com
 ([fe80::84bd:8c8:6669:c784]) by SEYPR03MB7816.apcprd03.prod.outlook.com
 ([fe80::84bd:8c8:6669:c784%3]) with mapi id 15.20.9632.019; Wed, 25 Feb 2026
 03:07:45 +0000
From: =?big5?B?VG9tbXkgU2hpaCAorEmp9qfKKQ==?= <tommy.shih@airoha.com>
To: Daniel Golle <daniel@makrotopia.org>
CC: Christian Marangi <ansuelsmth@gmail.com>, Jerome Forissier
 <jerome.forissier@arm.com>, Joe Hershberger <joe.hershberger@ni.com>, "Lucien
 . Jheng" <lucienzx159@gmail.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Ramon Fried <rfried.dev@gmail.com>, "Tom
 Rini" <trini@konsulko.com>, "frank-w@public-files.de"
 <frank-w@public-files.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 =?big5?B?THVjaWVuIEpoZW5nICi+R7K7tnYp?= <lucien.jheng@airoha.com>
Subject: RE: [PATCH v1] net: phy: air_en8811: add support for Airoha AN8811HB
 PHY
Thread-Topic: [PATCH v1] net: phy: air_en8811: add support for Airoha AN8811HB
 PHY
Thread-Index: AQHcpX1YkgYcyLXryEWvdz0IRvvWbLWRv32AgAD5UmA=
Date: Wed, 25 Feb 2026 03:07:45 +0000
Message-ID: <SEYPR03MB7816A06EAB7179223C233076FF75A@SEYPR03MB7816.apcprd03.prod.outlook.com>
References: <20260224110403.418941-1-tommy.shih@airoha.com>
 <aZ2S-UhkJogfU0ug@makrotopia.org>
In-Reply-To: <aZ2S-UhkJogfU0ug@makrotopia.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=airoha.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7816:EE_|SG2PR03MB6454:EE_
x-ms-office365-filtering-correlation-id: dca8d1d2-c1dc-4af9-d341-08de741b0c51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700021; 
x-microsoft-antispam-message-info: =?big5?B?bjFtWVQrTVpGZTFBS05PNVQrVlA4MGRSVkhSUTRnYk9qbHVURXI2VWwwalpoQXcv?=
 =?big5?B?ZVphdDcwYUpPRFQ3NGp1VEdiVXluNFhtNDhKTWJsSkdBczJNNjk5Tlh3SGFpRmRv?=
 =?big5?B?SUYvbndmUFdLemM4aHd4ZHlmRFRlSXc0VlFFY3AveFM5K285L3p4dzJwZVh3d0U4?=
 =?big5?B?ZkxPcjhrN3BJT2lJYzdVV1M5am9uSVJ3a2VFOUdLNXd4S1RlZEgzekZmV284Z1Y4?=
 =?big5?B?RHA5VTkzbEJoQXBBZ3VpZVh4SnAvV3FFbG4zdnhUWGV6OUh2UVh6RGdGc3JhQ2p5?=
 =?big5?B?aGN3Z1Z2NjVXbXRPcFY3cU52WmNwdldqbWR1MkpIZ3dHV0M1c0h2cE4xU2g4V2tw?=
 =?big5?B?VEQrR3ZWdklIa2tVNVVvQjR5SlE4cjltZXl0SWVwaFl2cTNwVlhnYThvUzlYQ2Va?=
 =?big5?B?S1Z2S201aW01aFoyUUtwbDdtZ0w4aW14NDhWdWRBRExOY0praXF1VUZZWmswVmR0?=
 =?big5?B?UytUcHVZREtNL3VMeWl3ZUIyWXdnTlFNWjl2Q2Y2Y0tHbS9tS1l5dWMwRTJVUld2?=
 =?big5?B?TVkyaFBjc3RJeXlUU04wNHdMZWltTmE1bjFUajdZcXdUeFM1azJmOXlRbnJVM1dl?=
 =?big5?B?NjBGNDlrZ2NtS2RSVVRzYzRzSGlWUVRaaW43S1pKekwrTURyS0tqVDZJY0RUZGVK?=
 =?big5?B?OXkxeG1xQmVsU3NHZDhOYWdRbFlUK2dINGIyRG81T1VwTHAvaXphZFNxUDNaZHlJ?=
 =?big5?B?dHM1NmlsM24vMDJDbHdUaGFXdG1zekxsbWtUZEZxcUpkTnF0S2ZKUTJZcTM3VUUw?=
 =?big5?B?bCtMMTNaM3c4YzdZWW80RzJ4UzhxZjdNZ21tdk5oMzBpa1I4UDZJSG8wOW0zc3VH?=
 =?big5?B?VmhSUURQekZlUklBMFZKVExnK2xYbStLd09CbHJ0UnNLNE5zaUFzVll2bWZqM3hZ?=
 =?big5?B?ZGYzODdFaGJhaE9EWm5oYkdPczllVklXU282UFo0TWVFc25EcDA0SGJqb1VycTJi?=
 =?big5?B?eHQvQ2FGTTFueStaS2VTT2YvTWlWUWFRTm5CM2Z2Z3VRZFFsQTV5eHZLRlJGaXBX?=
 =?big5?B?NFZXNlA0ZU91cHNUSUxhbXRuZEdFK1ZCZmhSdnE5SFBHbWNFSWovK1JPMUU3QUJo?=
 =?big5?B?cHJwSDRoQjhOa2tqYk9ZWllCT0pOQzg0SnFFc0tsLzRUK09uRW1hRHFDTGxxSFpO?=
 =?big5?B?dGRILy81QWJBOEN1Y240cGdHMUFJZXFXTjVnWGNDc3VDVUVJSURyNUU5MUp2WjJj?=
 =?big5?B?OThwU3psaG5XUzlTZi9xRHVuUGV2R3pndzRkaDRwN1dzaEVTSFBYcWlrTTFVUTB5?=
 =?big5?B?aEpkS0d3RVNzS01leTA0UTlNbEFlbng1NFhyMDBYRHBBQ0c1Z2lybFUwbFZxVjFt?=
 =?big5?B?SjNHSWpqbmw2MFNCV1JMOXUwSkJndkh3SXU5Rm45SVZtMC9xMGIvQ0IrS2kvTE90?=
 =?big5?B?YkNKSklmVWJQbkZXWldqOFB3dTNGeVdEZnBhajQyTUM2eGtjTVkvOFVPY3pSZlBB?=
 =?big5?B?b2ZtYUV5NUJwVmFSR08zT1dRcFZVaTA4Z05tYUlpbHpKVzRUekpJWTE2VnFsdE9B?=
 =?big5?B?cmNYWHZiTEhRK0hCa0F5NzV3ZVRiZFowQWJrelIzM2NuZ21NeHRkZjlMR3hXeGE3?=
 =?big5?B?RHZqY0syWVZ5WGlkcnZsaCtzY2lJZXo3L3p0UEJibE5hNVQyOENueDYvQUpkSnFW?=
 =?big5?B?VHYzSlp0Q3pRQng4a1pTRi8raVRBTk1MVm9aQ0dNY1RFTnRFZW8rZ2o4dFcrYlla?=
 =?big5?B?OXdYN0t0WkQ0MFZlVkIrOWRVWWhHM1RRbXdNcFBwV2N1eHo2OG5HYWU3WVhzMG1Q?=
 =?big5?B?VEczcG9DWHNjZE00ZXB4VTZiTmdkbmJpSUxuQkdBVlp5TmlLbHNrTnpmQzF2RjBp?=
 =?big5?B?SW9zRFg1VzJRT2dzNE4zWnJNYWMzL0pXbCszd1N1OEErS084aCtRUnRNMDE0THZk?=
 =?big5?B?K0Y1ZGFEdHh1ZW1qN3dLMGh0aDZqZ2NYRi9oOWZYZS9sdzR2dEtCdUdnWEs4SytY?=
 =?big5?Q?HnWPFfHts+SPGom7LnKg7Nk9koCiRSv8E6M+aNp12tQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEYPR03MB7816.apcprd03.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?big5?B?SVg4YUk2WHF3RTZZaVdRTmM4K3l5ZlhER3ZiL3RyVzNCcDNCaGt5Ly80T2NKbjA3?=
 =?big5?B?UVFaUUF2RGhDRi92UnA4UlpFaGdDNldLUTJ5c1JKWTBRbG9LVStlRHNOL3lPMFZG?=
 =?big5?B?b3BxbFNHK1lsNmU5c2d6Y3dhK25MdytDZDNyanJ0TFFoVkl2aHNlVnZHaStXbWpR?=
 =?big5?B?S3pnUkgvdFlXdlp5TkhKRFRJL2ZxWlhwUElrTmhoOEp3WUtwSnZYQ0NaUm9WQXZN?=
 =?big5?B?cFpIT2hrRXB1VjI4UFBJN25nYTBtSVR0UDJlYitubEJrQTFYd2srZmo5d28rU21l?=
 =?big5?B?MkQySncxaW04QnJXUXZkeG50amhnejNwandXbStuMllPazNPMWg1N0ZxR3B3M1RI?=
 =?big5?B?UU5FRHNlN0VIRlIxSU9Ub0dydXA0RzhMaFFkU3NsaDdabUh0UCtybDZhME9jVWhG?=
 =?big5?B?RjlUYUVwOVpnMmJ2eVczZjkzRHZwY3ZoeHBadjVsQzd4MnZkbm5Fb1RrMlhOVFYz?=
 =?big5?B?L0NpUDY4aldJRWw4Q3Q0UHdQTWZDM0RhY0twcjBmSXhUeFV5NnYwZEdkcE5jRjk2?=
 =?big5?B?ZFhocDA5TjQ1UlJvdldVeWt5dk03a0JZd1JyVVVpKzR6aGpGR1BGUDd5VUlrU2hj?=
 =?big5?B?SERDV25VRFZvVDZ4cVNTMUNzeGpXRFdNeDZLd2N2eU1YK3Fma3BlMmRLSVpna3B1?=
 =?big5?B?VXpNVVdQaW5JdkJmN2JxelQ5d2RrN3VwaWRtRXY0alo3UVZVcGRDeWI3Q1htTy9X?=
 =?big5?B?dHA4NjA1K2ZzSkNTbkFmR05VYURJYkUrd0VYZnAxZmZQTU10LzlDRGwyQlMrVlor?=
 =?big5?B?UHlwUnpRV1FzZ1BZaGM1OXorcm1ybCswLzdMOTcyV3FjcjlnVncwQklWRkVYcFk2?=
 =?big5?B?NFdNa29ldm5NTHlUWi9UN2l1YlE3RVRiSEpmOVBBd2E3bDB4QjM3RHF5RmRMQ0VH?=
 =?big5?B?dDdTMk9HYldlenR5V3MyWmRDOGdWTjhnM0FBbXpCVXZDZVY0YWFhbi8rdW0rclBx?=
 =?big5?B?S2RPUDB0bEZqbW5WM3BEc1JkSTY5MURMVCsxcmV6REFMT2swdXJ1TVY0UGszcXJF?=
 =?big5?B?MDZ5WkNJQjZQYnlEM0w2a1BmS1JXMTJxNExwYlJGUjRrd2orV2c2UmFnRTVUcGdP?=
 =?big5?B?OHhnT0dCQWwvMk43eFVOTXlmazVjTU5wdngrOHBtcGNBRTBTMUZlWGIrQnhFY0Js?=
 =?big5?B?d1B3WWY0S3hvOHZNZXZ4Q3QyR3NmR3JoWWV3QjFYUXV2TzgvNTh3czBJRFZZcXc5?=
 =?big5?B?Qm9VZXVoSE00ZGlNSHRlTGd0REk1Y0pidDl5Ukh0eWwyNmZrSXplczBMTHNLRXE2?=
 =?big5?B?OW81aWZKZ2FVYjVSRHM4ZWkrazN1QjNrczI0SzhKZ3FIdDkxendSSFZjYm8rODZ0?=
 =?big5?B?TFF5dFkvZEpSbExtcEVqZUd3bzJYcVFDZG45Z29nUDJJc0IrUDRyUm95dkk4UStS?=
 =?big5?B?aGNJMW9IV1Q4Rnd3Wm96bmVMeXp1dUFUdFZDRmRzZDc5QTErUnBEVGsvT25FZURn?=
 =?big5?B?SllKR0s1OTBCVVJVYmc3RUFmTVpxWWRrMDN1ckV1RlJOSmlHNmhMQ0taSERKekRQ?=
 =?big5?B?TkFFNkFIUkluLzdSMzVjTE5NMzlycGp2eXB6VDloQUt6QmFucHBLM0NNcE1ZU3JP?=
 =?big5?B?bUx6TVg0YzBLK2ZTMm0vclhhSTRvYWVVSE9jb3ZPRTZRclZsb1owSDBUZ0o0eUhG?=
 =?big5?B?OHl2bCtpQURkY01iTktPK2dySzJkSzYvTDAreGhVK2UxbDl6bWQzUWp0ZUlnd1pP?=
 =?big5?B?OEpqbHJOVFZPUnZPaHN2L1lmNkhFbHlaVkYvUmM3bDV0aGkrUW1VRlluRmxZNTlv?=
 =?big5?B?QWJpbXZOQTVtbzFXRmdqS0kwTEtTdVJLSFpGazhWV05QN1g1d2NHSDUrY1BtblAr?=
 =?big5?B?UGtJL3JzVVR4b2Fpdld0U2NkWTU4VVZ0d09JRnFaQWF6Ukx5dzBaOUlpb242cWlq?=
 =?big5?B?MmdBWENaaDQwSlBnclh6WjNlYWtPR2g0RDdEeFpkUFB4QkU5TkNaMis4Mm9XZTkw?=
 =?big5?B?QkppRTRzRVBSTGFrV0xUYzRqaUZycGxzWHNrZ2dUTFJsckMxZkVqWmM4MWRqV3ND?=
 =?big5?B?bkdLYlVlNHBEM0lmdXgrS1k0WTlKQ09GalhGT0hkbUtUd1JKRnZtRDBtQlNpYUhX?=
 =?big5?B?Mnc5U1c4em5FNDdlNHMzd1VuYzJUTzdYSTUwYktoRklkcmtQSGNsWkNBT0RSRmM5?=
 =?big5?Q?JP1JRTh3+wJ02k8UK6qK9+Z+TugufPgfmxn57XcIoV0Lojm5?=
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DWBD3xeSq2ec3nvvMcQCwc/vjnvqMkfaUg9/ktf249AzOqoNOW5hKkyrfZWplWkVAEZFkgRcOr4W0uyDqudwhXJHd62zWGTFQIOwXb/5xFrIHNot3knjqs/k33A0jz8wYi92Mfl7BFQHM9FZn9cJ+6ylM9WMjXRf2v+f+SG04difU9qp5LD94aQ647NSoMeJk3Xv1BES+dOFCobPOrmsAnusHQKHfFPlFJmycGlRHrryBrisbA9vVoVBZnAEdDkjmuC5KFNTlGvGRjJ4Mj4H3rZvuhzz51pih/knPmMIc/bUWGDR660wS6HJN/UXD58/VJZiSxD4hyZfxahg4Jw1OA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7816.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dca8d1d2-c1dc-4af9-d341-08de741b0c51
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 03:07:45.2777 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ETPDLGt1HLbpHs22Sc2/GNM9si0U3z/MsMmv7Pb/NVH3/PJwz0meFymiYCzOAyz+65qSvV8FqUnFB345qw1g0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6454
X-Mailman-Approved-At: Wed, 25 Feb 2026 05:19:09 +0100
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

SGkgRGFuaWVsDQpUaGFuayB5b3UgZm9yIHBvaW50aW5nIHRoaXMgb3V0LiBJIHdpbGwgY2hlY2sg
YW5kIHJlbW92ZSB0aGUgYWRkaXRpb25hbCBoZWFkZXJzIGluIHRoZSBuZXh0IHZlcnNpb24uDQoN
Ci0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBEYW5pZWwgR29sbGUgPGRhbmllbEBt
YWtyb3RvcGlhLm9yZz4gDQpTZW50OiBUdWVzZGF5LCBGZWJydWFyeSAyNCwgMjAyNiA4OjAxIFBN
DQpUbzogVG9tbXkgU2hpaCAorEmp9qfKKSA8dG9tbXkuc2hpaEBhaXJvaGEuY29tPg0KQ2M6IENo
cmlzdGlhbiBNYXJhbmdpIDxhbnN1ZWxzbXRoQGdtYWlsLmNvbT47IEplcm9tZSBGb3Jpc3NpZXIg
PGplcm9tZS5mb3Jpc3NpZXJAYXJtLmNvbT47IEpvZSBIZXJzaGJlcmdlciA8am9lLmhlcnNoYmVy
Z2VyQG5pLmNvbT47IEx1Y2llbiAuIEpoZW5nIDxsdWNpZW56eDE1OUBnbWFpbC5jb20+OyBNYXJl
ayBWYXN1dCA8bWFyZWsudmFzdXQrcmVuZXNhc0BtYWlsYm94Lm9yZz47IFJhbW9uIEZyaWVkIDxy
ZnJpZWQuZGV2QGdtYWlsLmNvbT47IFRvbSBSaW5pIDx0cmluaUBrb25zdWxrby5jb20+OyBmcmFu
ay13QHB1YmxpYy1maWxlcy5kZTsgdS1ib290QGxpc3RzLmRlbnguZGU7IEx1Y2llbiBKaGVuZyAo
vkeyu7Z2KSA8bHVjaWVuLmpoZW5nQGFpcm9oYS5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIHYx
XSBuZXQ6IHBoeTogYWlyX2VuODgxMTogYWRkIHN1cHBvcnQgZm9yIEFpcm9oYSBBTjg4MTFIQiBQ
SFkNCg0KDQpFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbCB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBj
b250ZW50Lg0KDQoNCk9uIFR1ZSwgRmViIDI0LCAyMDI2IGF0IDA3OjAyOjUwUE0gKzA4MDAsIFRv
bW15IFNoaWggd3JvdGU6DQo+IEFkZCBzdXBwb3J0IGZvciB0aGUgQWlyb2hhIEFOODgxMUhCIDIu
NSBHaWdhYml0IFBIWSB0byB0aGUgZXhpc3RpbmcgDQo+IGVuODgxMWggZHJpdmVyLiBUaGlzIFBI
WSBzdXBwb3J0cyAxMC8xMDAvMTAwMC8yNTAwIE1icHMgc3BlZWRzLg0KPg0KPiBVcGRhdGUgdGhl
IGRyaXZlciB0byByZWNvZ25pemUgdGhlIEFOODgxMUhCIFBIWSBJRCBhbmQgaGFuZGxlIGl0cyAN
Cj4gc3BlY2lmaWMgZmlybXdhcmUgbG9hZGluZyByZXF1aXJlbWVudHMuIFRoZSBmaXJtd2FyZSBs
b2FkaW5nIG1lY2hhbmlzbSANCj4gcmVtYWlucyBjb25zaXN0ZW50IHdpdGggdGhlIGV4aXN0aW5n
IGltcGxlbWVudGF0aW9uLg0KPg0KPiBUaGlzIGRyaXZlciBpcyBiYXNlZCBvbjoNCj4gICAtIExp
bnV4IHVwc3RyZWFtIFBIWSBzdWJzeXN0ZW0gKHY3LjAtcmMxKQ0KPiAgIC0gYWlyX2FuODgxMWhi
IHYwLjAuNCBvdXQtb2YtdHJlZSB1Ym9vdCBkcml2ZXIgd3JpdHRlbiBieQ0KPiAgICAgIkx1Y2ll
bi5KaGVuZyA8bHVjaWVuLmpoZW5nQGFpcm9oYS5jb20+Ig0KPg0KPiBUZXN0ZWQgb24gTVQ3OTg3
IFJGQiBib2FyZC4NCj4NCj4gTGluazogDQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19o
dHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmUNCj4gbC9naXQvbmV4dC9s
aW51eC1uZXh0LmdpdC9jb21taXQvP2lkPTZmMTc2OWVjNTg5MmFjNDFkODJlODIwZDk0ZGNkYzY4
ZQ0KPiA5MDRhYTk5X187ISFDVFJOS0E5d01nMEFSYnchbUVuQXc5dGlGTUVGTW1aa25WTlBQeGt6
dTM3ejNQcjlfTDZBenlfZm8wDQo+IDFFSkFYYVZkTmJlb3YyTHAzV0tIUmIwNE80T21mVGl0YUlv
b2VwTUlnJA0KPiBMaW5rOiANCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8v
cGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9uZXRkZQ0KPiB2YnBmL3BhdGNoLzIwMjYwMTIy
MDcxNjAxLjEwNTcwODMtMy1iam9ybkBtb3JrLm5vL19fOyEhQ1RSTktBOXdNZzBBUmJ3DQo+ICFt
RW5Bdzl0aUZNRUZNbVprblZOUFB4a3p1Mzd6M1ByOV9MNkF6eV9mbzAxRUpBWGFWZE5iZW92Mkxw
M1dLSFJiMDRPNE8NCj4gbWZUaXRhSWg3M0tKbEkkDQo+IFNpZ25lZC1vZmYtYnk6IFRvbW15IFNo
aWggPHRvbW15LnNoaWhAYWlyb2hhLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEx1Y2llbi5KaGVuZyA8
bHVjaWVuengxNTlAZ21haWwuY29tPg0KPg0KPiAtLS0NCj4NCj4gIGRyaXZlcnMvbmV0L3BoeS9h
aXJvaGEvS2NvbmZpZyAgICAgIHwgICAyICstDQo+ICBkcml2ZXJzL25ldC9waHkvYWlyb2hhL2Fp
cl9lbjg4MTEuYyB8IDY5NSANCj4gKysrKysrKysrKysrKysrKysrKysrKysrKystLQ0KPiAgMiBm
aWxlcyBjaGFuZ2VkLCA2NTIgaW5zZXJ0aW9ucygrKSwgNDUgZGVsZXRpb25zKC0pDQo+DQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC9waHkvYWlyb2hhL0tjb25maWcgDQo+IGIvZHJpdmVycy9u
ZXQvcGh5L2Fpcm9oYS9LY29uZmlnIGluZGV4IDk5OTU2NGU0ODQ4Li5mY2FjZTlhMjRhYyAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvcGh5L2Fpcm9oYS9LY29uZmlnDQo+ICsrKyBiL2RyaXZl
cnMvbmV0L3BoeS9haXJvaGEvS2NvbmZpZw0KPiBAQCAtOCw0ICs4LDQgQEAgY29uZmlnIFBIWV9B
SVJPSEFfRU44ODExDQo+ICAgICAgIHNlbGVjdCBGV19MT0FERVINCj4gICAgICAgaGVscA0KPiAg
ICAgICAgIEFJUk9IQSBFTjg4MTFIIHN1cHBvcnRlZC4NCj4gLQ0KPiArICAgICAgIEFJUk9IQSBB
Tjg4MTFIQiBzdXBwb3J0ZWQuDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9waHkvYWlyb2hh
L2Fpcl9lbjg4MTEuYyANCj4gYi9kcml2ZXJzL25ldC9waHkvYWlyb2hhL2Fpcl9lbjg4MTEuYw0K
PiBpbmRleCAxYTYyOGVkZTgyYi4uOTc0ODg3ZGEzM2QgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
bmV0L3BoeS9haXJvaGEvYWlyX2VuODgxMS5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3BoeS9haXJv
aGEvYWlyX2VuODgxMS5jDQo+IEBAIC0xLDQ2ICsxLDM3IEBADQo+ICAvLyBTUERYLUxpY2Vuc2Ut
SWRlbnRpZmllcjogR1BMLTIuMCsNCj4gIC8qDQo+IC0gKiBEcml2ZXIgZm9yIHRoZSBBaXJvaGEg
RU44ODExSCAyLjUgR2lnYWJpdCBQSFkuDQo+ICsgKiBEcml2ZXIgZm9yIHRoZSBBaXJvaGEgRU44
ODExSCBhbmQgQU44ODExSEIgMi41IEdpZ2FiaXQgUEhZLg0KPiAgICoNCj4gLSAqIExpbWl0YXRp
b25zIG9mIHRoZSBFTjg4MTFIOg0KPiArICogTGltaXRhdGlvbnM6DQo+ICAgKiAtIE9ubHkgZnVs
bCBkdXBsZXggc3VwcG9ydGVkDQo+ICAgKiAtIEZvcmNlZCBzcGVlZCAoQU4gb2ZmKSBpcyBub3Qg
c3VwcG9ydGVkIGJ5IGhhcmR3YXJlICgxMDBNYnBzKQ0KPiAgICoNCj4gICAqIFNvdXJjZSBvcmln
aW5hdGVkIGZyb20gbGludXggYWlyX2VuODgxMWguYw0KPiAgICoNCj4gLSAqIENvcHlyaWdodCAo
QykgMjAyNSBBaXJvaGEgVGVjaG5vbG9neSBDb3JwLg0KPiArICogQ29weXJpZ2h0IChDKSAyMDI1
LCAyMDI2IEFpcm9oYSBUZWNobm9sb2d5IENvcnAuDQo+ICAgKi8NCj4gLQ0KPiAgI2luY2x1ZGUg
PHBoeS5oPg0KPiAgI2luY2x1ZGUgPGVycm5vLmg+DQo+ICAjaW5jbHVkZSA8bG9nLmg+DQo+ICAj
aW5jbHVkZSA8ZW52Lmg+DQo+ICAjaW5jbHVkZSA8bWFsbG9jLmg+DQo+ICsjaW5jbHVkZSA8ZnMu
aD4NCg0KSSBkb24ndCBzZWUgd2hlcmUgeW91IGFyZSB1c2luZyBhbnl0aGluZyBwcm92aWRlZCBi
eSB0aGUgZnMuaCBoZWFkZXIuDQoNCj4gICNpbmNsdWRlIDxmd19sb2FkZXIuaD4NCj4gICNpbmNs
dWRlIDxhc20vdW5hbGlnbmVkLmg+DQo+ICsjaW5jbHVkZSA8dmVyc2lvbi5oPg0KPiArI2luY2x1
ZGUgPGxpbnV4L2RlbGF5Lmg+DQo+ICAjaW5jbHVkZSA8bGludXgvaW9wb2xsLmg+DQo+ICAjaW5j
bHVkZSA8bGludXgvYml0b3BzLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvYml0ZmllbGQuaD4NCj4g
ICNpbmNsdWRlIDxsaW51eC9jb21wYXQuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4N
Cg0KLi4uIGFuZCBmb3Igc3VyZSB5b3UgZG9uJ3QgbmVlZCB0aGF0IG9uZS4NCg0KPiAgI2luY2x1
ZGUgPGRtL2RldmljZV9jb21wYXQuaD4NCj4gICNpbmNsdWRlIDx1LWJvb3QvY3JjLmg+DQoNClBs
ZWFzZSBjYXJlZnVsbHkgY2hlY2sgd2hpY2ggYWRkaXRpb25hbCBoZWFkZXJzIGFyZSBhY3R1YWxs
eSBuZWVkZWQuDQo=
