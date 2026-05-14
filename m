Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F48CD4F21
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 02:25:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FA6D8467F;
	Thu, 14 May 2026 04:25:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="nSrL6QEY";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="wAgUZ+3r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6E55846A5; Thu, 14 May 2026 04:25:06 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF0E084676
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 04:25:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: 1c4b499e4f3c11f1b5a00d44d12bea5a-20260514
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=4AYkaQi5j5jMDFr/wQh42r1wQsSWpIqPwdTKw8HjCBw=; 
 b=nSrL6QEYlvpoKXsHsarjGu22m38ZwXcTfo3+J1tKfrg3JX0K9dGONbQYg0euLjwg1sZSWJqPBPSMq5zDTbpd0+aH6Dx4y4heVlA1avzCiQCbKMkxd2oq1YpZ+z7fjFt39qH0F1qjcergvJj+ibknmhDzGzuKHmyizugWtziC5C8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.14, REQID:1453bf32-2a23-41cf-bb03-5044e95739b6, IP:0,
 U
 RL:0,TC:0,Content:2,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:2
X-CID-META: VersionHash:9091e75, CLOUDID:bf1ee140-4f1a-4cd1-8315-22e1f88ac479,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
 898,TC:-5,Content:4|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
 l,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1c4b499e4f3c11f1b5a00d44d12bea5a-20260514
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by
 mailgw01.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1277037764; Thu, 14 May 2026 10:25:01 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 14 May 2026 10:25:00 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 14 May 2026 10:25:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=REfuORTLCp98Yr1p8HeFCQIDoxXagKSjWUkdg/RcqrFoLYYY6zptjPbURU6fU8I8RxaaYFIluzlvHMyiRkIbKkDJKU4HXqVE8ncaMctkqmmw+70rtgv104CbO3966NUEaEaHCg4zWJ+8Kn0jRavAvfMZQ1SeImhPm9TxBWHMHTq3pqxmc8x6rdq3vR4p9hkmWg8K8IqebIARAMoTWP2K4Lz9qGkUa5ska+JTeRyicN/Imbf4qNj/Dln6zRAHzNbMdi9xmngfOUPw0UUsn5PsSCL6bbOJYH8b0oylodmB0+Zp3eBf8yNYhjTmRflc6qZpYU04JWA6t5bKGLYcmemnow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4AYkaQi5j5jMDFr/wQh42r1wQsSWpIqPwdTKw8HjCBw=;
 b=DLxciu5KtkNdRfK4QkCI2Q9yFQJ4YZ1FqcQrPJ/1Ru6JjeuzyXmp6qyiE618ZjFX6PWlB6c2RxUnKGlUEU/zJfcmEPoTt5B9QxqTQaE6UJ7TkQ27Tud38fFUn9dZ+D7YUYpgnG4IFSdXdg5jKq4pfhSb7wcVYCqI+fUnAN2pakvr/JxfGYjCZX6vKVtMtOzodxx6DCTO6XJ/rSuVY7rHwGGM3fwUKiyrmSPfeT/1DXbdIn/2wKaRUUDjVgzudSroKM6Jww2KAJMqyUmL13mPB2j/p01n93HR58Dl8sr7q/C17+z6OUUzq8rlhMrhtQwzHRhM0o+8Cpf2KOY2MydfGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AYkaQi5j5jMDFr/wQh42r1wQsSWpIqPwdTKw8HjCBw=;
 b=wAgUZ+3rcGsYvmjtk7lkS067hMcdwd8+hcu3rfWmXodJvjWxUM4GaNRSTDBspAM5d0T55c7mO6OVvlPkqyroLaKFj0a8C9AT1RPNWNCL53zZiBW9KShvzyNadktTl8CbsM2K8XdCUY9PBOfaxsYKfMUDIczdaoqdWAhsifJ5zsY=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by KL1PR03MB8238.apcprd03.prod.outlook.com (2603:1096:820:108::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Thu, 14 May
 2026 02:24:57 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.21.0025.012; Thu, 14 May 2026
 02:24:57 +0000
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
Subject: Re: [PATCH v2 1/3] configs/mt8188: enable bootstd, FIT and DT overlays
Thread-Topic: [PATCH v2 1/3] configs/mt8188: enable bootstd, FIT and DT
 overlays
Thread-Index: AQHc4l9NGfg5bwv6rEuNzm8BImLJ2bYMzPYA
Date: Thu, 14 May 2026 02:24:57 +0000
Message-ID: <3c1d981f711799b0c6a64307e973343c68f81ee2.camel@mediatek.com>
References: <20260512-mtk-genio-defconfig-v2-0-bf4c30ef7f14@baylibre.com>
 <20260512-mtk-genio-defconfig-v2-1-bf4c30ef7f14@baylibre.com>
In-Reply-To: <20260512-mtk-genio-defconfig-v2-1-bf4c30ef7f14@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|KL1PR03MB8238:EE_
x-ms-office365-filtering-correlation-id: a7dd981c-6676-4fdf-f64f-08deb15ffe20
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|56012099003|18002099003|22082099003|11063799003|4143699003;
x-microsoft-antispam-message-info: 1F+0g9SBAqomdui+ZYsgW7HBq4wTzB0mezncl5RS9vtjJxZ7+NkCQLf6LvsUYit/D+SrRoAb/m3V1y9dzODMgS8ff8VmbdRF8QsiqPTyw65y8cuXGy6KxRgavvLrmeQlwkPjJlR5tV0rcItoZ8tOXnBflo7QND/yhGkrtTxWXy+Jm5tuZ/ky6kx9QmgTobi91wWkL6gxtQ4Y9B51/wYWDKhYAscflGwvPv6UyTdFJOdRtQLIkrNILcd85MnTfllxkKxINyQ0O8SOlb31uKB52fqdDv5M0FYDqnnnSXVrgE9If/bGwRomrD3vUggoY1Iws70ba80FfKPqVYxnfJd7MY8Lx3sXF6DvC2fJ0Um51tMrSEy1KGEax+R6UnJHp0xie+vLrWkMGx+OjRkNnoGZBzsE/petchBBCdxL7g/7CB331+fRqOlksLBD2pAIArZiSzyxB9CYL4orElCXpqWNh53LQHHv8XSNOR+VVUVIfaNosSqCdK3fYSnkuhTq8qHXTUNhb1qDntKnEOxwZW+LnOuihxzvfUA9nE2qPw2BJFKgWK/n/ayd7931a5pwCGjI2wj6dq90Wj/OeIKyJxuBIoEb5DuilVwgQJg5Ut+mIteDxS2RY5MHPffrAO8jK8HFXhw29bnXUfWDM1dJtRKR2np8wpjfFydoEiOuzg1mcnwHrI9ofR6r9XJ/wwqVXAi7gJuFFJIFNDOV8np9fQHN8+pAf/bM/61uKiSiTypm7SCMxQaQKNhyEqZ9IYSnmdXq
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099003)(18002099003)(22082099003)(11063799003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFBwVXpQR2VXYjV1Rm1xMFBZNENKUDY4bTJYMjR5TjJHSHVOOEthMGt2cUVH?=
 =?utf-8?B?YnNUM29WQVViTTVNQlltNVdjZnhvTjNwZTBzUE5jRSthTUxmNUgwSlY2ak5B?=
 =?utf-8?B?NXhpZyttUk5CekR1cDFET3QrRWRXMzBrWWQ1eCtZM09MVHFycTIyejBZWUdr?=
 =?utf-8?B?T2xxOEZLb0JVN2UvcGRLMkQ2WXRMODBOcVlvUURhbGYzMUNLNm1pZW1jL2Ro?=
 =?utf-8?B?VXhmNDBtR1pSL0NDRFFaRHlvcFQwWklVY3NTaUdtRmRlR0ZIM05SQmRtSVJF?=
 =?utf-8?B?S29RazJteUFOWUFYeWdEODhnZ1VkNWhUME9NT2FUNytuWHJKcUhCWnZ6Uklu?=
 =?utf-8?B?azdRK3M5K3JreHdnMml3WFhOSnR3K2VXVVQrR1d1bHhHOHlLaENBQit6L0Yr?=
 =?utf-8?B?TmpjMVZueGpoZ1YyazJVdG41RytwYlFwNGxaaVUzdjJJOFdtOW82WVAxcGV5?=
 =?utf-8?B?eDhIV1dPT0RDU0VPRlVrbnI1djZXYXlIYjQ1NjFCcHA5NzI1M21iL3J2QVNv?=
 =?utf-8?B?WUpybXdCdlJGejFKcUZFWDFFZ1NEVGs4dGh1cWtmcVFzaWx1OU9qR1QxRjNq?=
 =?utf-8?B?VTllU0RtYTNaQW1QUzd5NysxTWZIeUZzVWo1d2d3cHpCT1hFaUV1STUrTTdn?=
 =?utf-8?B?c29RVWpEWnplKzVTbTZhSXcyMU1haFNIVEw1SlptWlJzcHFYV0xkdU43aGNJ?=
 =?utf-8?B?MmhvWHJabk1VTDBXTXhaNTBWelRrUXlOR3pMcUxVSE1KaGR0NUVYSWhRN24y?=
 =?utf-8?B?clZZTHNzdUxIaEdNRDBSZERDRW1KcEN4RVR3WFc4VlR5dDFDMWRSVkM2ZnZ3?=
 =?utf-8?B?SVJGMk4vZ0U0VEFVU1VEVGsyZXdYNUx6cUduZEdXUGg4dkxvSmlJYzliWmp2?=
 =?utf-8?B?U1I5UlJLb1l3ZTcrUmQvKzdsYVhscDJtVVJRK0w2Qm53ZmdCejRidnFqcDVS?=
 =?utf-8?B?c1dHY29DcTd4NFpLMjNwNFpHa1hOUWtEMHFNMEhsbHovUGoxSEpJYmROeFg2?=
 =?utf-8?B?bkw0WDY3RWlQR2lVMC96ZUJsd0NIWEovVms2cnZsZTAreGhuZ0dxNDk0RVhJ?=
 =?utf-8?B?RUpVNGNHcGxmQjNyM0ZzeFZ4WWZSVzA3RFRVSWdZdmo4ZG13VVYzeXVaWWtS?=
 =?utf-8?B?dHBrSUh4U1l5YVJHL05uK2NVVHFNTlZScmpzR3FrT0JXRnVXVHNJbHF4M2gz?=
 =?utf-8?B?MzlyMDAwdG11bzlTYS96UGV3MW5BZEU1M1hlYzNVNGYzN050UFJTek1XckVR?=
 =?utf-8?B?eFhlR05OTG1OakdtRGV2RE91QmZkYnNwM3A5NEFzN3VWWWRRSmNMODhBM2hi?=
 =?utf-8?B?M0phbldJdzJGV05Dd25YVHluYUtGZGU4cHZieFJiMEhpaDdUb3pUTCtXSnRP?=
 =?utf-8?B?cExMZm85NHF4bXpqZ2tsMWpScU45dEZwWXkzT1dINmxkTHF3MVhmaEVvMmYv?=
 =?utf-8?B?YW5wdDVvaFNCS3dydHhxM1p5aExVTUpTKy9VSmgza3p6ZWRkVWlXbDJjcXhv?=
 =?utf-8?B?d0hFbFd6dFJDRGN2WTluU0prQ0E3bmczSkx3L0kwaGxEWWZzZVllYkIvdmlS?=
 =?utf-8?B?MW1qb2txUG83OE1jbzlZUkJXUndQWGkvZUtZMWVmaUVYODIyMVNPNEF2eTI4?=
 =?utf-8?B?NElWNTVpWE9qSHZpN0lXWmFDN2RhTWc3WVJqeFJ5WHJnN2YvNmRDdFQ4SHNm?=
 =?utf-8?B?L0JrVjlKeE8zeDdlVFl6N3JZNG5NemJ4Y3pkdC91aTNVelRjQ001Qm1DNWU4?=
 =?utf-8?B?Tnk3ZEtZZlJSR0JFeE5YNkN0U1pNMHY1SCtHV3FLZGxKczdtREhYRzdYbmlV?=
 =?utf-8?B?eTJGMnVRcTExcldCbDcyWU53aE81amdRU2F1MldBWUhTWE9EUmZZbHJDUG91?=
 =?utf-8?B?elR2QjRLWWkzb3VScmoxZWI5Y2tzYmJCRHRCakRLOU1YVW8vMjlKVDBKSnBH?=
 =?utf-8?B?cm1lNGk5UWRxRDZuTE5NeGV2aEF5QTNKNkJwMUtaUjhHMkpTaDRtT3RVL29p?=
 =?utf-8?B?SHkxWXhTejhZWHFYWUt0WEM3U1BUOEVRQVY4bFlIZS80N2swUjNPRC9nWTZo?=
 =?utf-8?B?Rm9TTEFSOGNBSlNzaVJkdjh1Zk1Mb0JrVGlHZHFOVjVrVDhtUURHTi9XaXlT?=
 =?utf-8?B?OGZCMW5CeTZBSWFDY2tiL3JlK0h5dDZ2MU9jNWl4V1BXSmlGaDFCaWdsNFdD?=
 =?utf-8?B?aDdDOGxGVkttUmUwdUN4SzMyS0x5TXpJRFE2MTZ0OXhzRmpPcTIxRHYvS2hJ?=
 =?utf-8?B?RDZLVkw0a2dhS1JXd0hna1d4bTVqWEJmNmpPTEdpUnBGaGVTYnUzRjFoSzlG?=
 =?utf-8?B?RVo3UmtTQWw1R3hOcVVPUm9NYWQ2L2liNHFIbC80MklNSkVxdTYxcWh0eXdi?=
 =?utf-8?Q?c1uwb+CVaZmwn204=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <26C53E93DEE97F4F8511708D2CFBF0A7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kCc0Ugh4Z9hWIQSjKq3iVoolNIP9ZCa0Ir2GQtk6IsPMtHJckqCijDwDGvyEw3iX/ZWA/E9dRmCoQm7CIWCdAvyuxWedpmxxF3QilHP3AdsWbJV1ACA1RvkS0P1DPz6sAq0jrLFOpN/ShFYTk5XoKiXEdSOoLnj5VeBK0krBQwkfDU6IL20QpIWYBTCZwTRsGE0pNrQ6Hn+7LO0tU0wDlvu48TGys74zCa5ObmrFX83fifvv+711HRmUoW4To1yFdAtEMKigrLI83vIOaI/DputDpx6oAwDMEpW1mZhgzibvWNFtFmRqsuzYjK5dG33lvPxWkdeQN/ZeG6rhep8jLg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7dd981c-6676-4fdf-f64f-08deb15ffe20
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2026 02:24:57.6664 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IaNTFr1PtSVD4P9+MAKueddlDMvkdL7uo5CJfqIIphFOonUDZSPduGYc3y29pn9WgDy86z1EaJowncPbByhOCmSq2oCW6gMHKVZbKplj0GE=
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
YWdlIGZvciBHZW5pbw0KPiA1MTAvNzAwIEVWSyBib2FyZHMgdGhhdCB1c2UgdGhpcyBjb25maWcu
DQo+IA0KPiBDT05GSUdfQ01EX1BBUlQgaXMgc2VsZWN0ZWQgYnkgdGhlIG5ldyBvcHRpb25zLCBz
byBpcyByZW1vdmVkIGhlcmUNCj4gc2luY2UNCj4gaXQgaXMgbm93IHJlZHVuZGFudC4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IERhdmlkIExlY2huZXIgPGRsZWNobmVyQGJheWxpYnJlLmNvbT4NCj4g
LS0tDQo+IMKgY29uZmlncy9tdDgxODguY29uZmlnIHwgNCArKystDQo+IMKgMSBmaWxlIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Nv
bmZpZ3MvbXQ4MTg4LmNvbmZpZyBiL2NvbmZpZ3MvbXQ4MTg4LmNvbmZpZw0KPiBpbmRleCA5ZGZi
YTZiZjk5Zi4uMGY3NDg0MTU2MDIgMTAwNjQ0DQo+IC0tLSBhL2NvbmZpZ3MvbXQ4MTg4LmNvbmZp
Zw0KPiArKysgYi9jb25maWdzL210ODE4OC5jb25maWcNCj4gQEAgLTQsMTMgKzQsMTUgQEAgQ09O
RklHX1BPU0lUSU9OX0lOREVQRU5ERU5UPXkNCj4gwqBDT05GSUdfQVJDSF9NRURJQVRFSz15DQo+
IMKgQ09ORklHX1RFWFRfQkFTRT0weDRjMDAwMDAwDQo+IMKgQ09ORklHX05SX0RSQU1fQkFOS1M9
MQ0KPiArQ09ORklHX09GX0xJQkZEVF9PVkVSTEFZPXkNCj4gwqBDT05GSUdfVEFSR0VUX01UODE4
OD15DQo+IMKgQ09ORklHX1NZU19MT0FEX0FERFI9MHg0YzAwMDAwMA0KPiArQ09ORklHX0ZJVD15
DQo+ICtDT05GSUdfQk9PVFNURF9GVUxMPXkNCj4gwqAjIENPTkZJR19CT0FSRF9JTklUIGlzIG5v
dCBzZXQNCj4gwqBDT05GSUdfQ01EX0NMSz15DQo+IMKgQ09ORklHX0NNRF9HUFQ9eQ0KPiDCoENP
TkZJR19DTURfTU1DPXkNCj4gLUNPTkZJR19DTURfUEFSVD15DQo+IMKgQ09ORklHX09GX1VQU1RS
RUFNPXkNCj4gwqBDT05GSUdfQ0xLPXkNCj4gwqBDT05GSUdfTU1DX01USz15DQo+IA0KDQpSZXZp
ZXdlZC1ieTogTWFjcGF1bCBMaW4gPG1hY3BhdWwubGluQG1lZGlhdGVrLmNvbT4NCg0KVGhhbmtz
IQ0KTWFjcGF1bCBMaW4NCg==
