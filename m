Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 775D5C0218D
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 06:51:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1947C8078B;
	Fri, 31 Jan 2025 07:51:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="mJjUrknq";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="j1kfIIpq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00E19807C0; Fri, 31 Jan 2025 07:51:10 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F067801FD
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 07:51:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: bbcaf28edf9f11ef99858b75a2457dd9-20250131
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Content-Transfer-Encoding:Content-ID:In-Reply-To:References:Message-ID:Date:Subject:To:From;
 bh=FiQ67Z65ixNUx4q3rQCyZ2F5jPdZp0RGD7hmauerI8M=; 
 b=mJjUrknqYVVLzWgsk2va+3cRvugzrhbThxriUVtzNaZbNVVXqwDpsylxmkTahtP4kYswbWWb/AqvJSSUIY+dLhau+V+xebELHBHasS31s6+uEkSZadmxwhZ29Hsa8nyYcgNQeoLYdIMb0prTWPyMagM/3MwkjuAhD6fD39C3AYo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46, REQID:4272614c-7cdf-423e-abf2-660afc682f4c, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:60aa074, CLOUDID:afbada3d-da39-4471-8a46-23da908abe46,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
 EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
 A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: bbcaf28edf9f11ef99858b75a2457dd9-20250131
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 194413540; Fri, 31 Jan 2025 14:51:01 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 31 Jan 2025 14:51:00 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP
 Server id
 15.2.1258.28 via Frontend Transport; Fri, 31 Jan 2025 14:51:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wSxlc4meqciayjrAYLFBj34B6n0gFilOt7iCFzNgpxgHmjtWG5W9k+N6nIViXJtxSsUkQC3bhLSlQs9L4mh4RZeyMqoW1PfRl5KYFDk2kSzAtILsB6TOZ3wXvKm4nya9yJNmzaxd5qcV6rJHyzybQGBFpSy7jEXVyqV1y4yjFPRRxwbao2WZBMeVg8YiUyutoB8PpzvlENSSfl9mm7w3fu8prOtZ27si/ZxkaLMQhcu+Z4lPB01gUlRcG5/7FAj2ivttAxfCDcI97mg4f53C6d18z24pP4QtGeRdlsldHC8pJD7sJsETMk3PLxmbDgP8n/mch9+U2ZWi7+unVSyWUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xoxTmEL6jCgCxm60yDP8+cUXjJ86egw8a/izB0UHbw=;
 b=RFzNBj8NlOtT59N95LBO/j3q87qen4jaGc9kS/h5tN2I58iu02mDDt+g47N7jRH6xxG/GsQTbU2YXdLZmT6ZAOBC+wGnYUW887D80m465QeyJq2baYKwRTzvI0bpZqGpiXJm9tycugnjvu7mkuy9Cwg0n6bYlyAVUdLZBpf3kjBI8ogFhyhjfp/3/CVaCjuU/Gcv/qdJSxUFcNKanuGyILYzTgZmdFpjNynuS283qoi9Y/3qcCTYDq59OpJHLLISzepSNPEZQKmtV+/rZruam1e1fX9r8eEKGYj2XiNHNOAn/Gg66seFbm31kB9VIkdqdPPHryjaZ3KUs+9l7KQ0jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xoxTmEL6jCgCxm60yDP8+cUXjJ86egw8a/izB0UHbw=;
 b=j1kfIIpqVhtjBLXgjElp8FltclP1J0So3XaOFNltcYBEjuc1HbBu9lBmFGGWXVdl8pXjtApN3A8DZsFthD45cY5MQhnIyQCTTsKg9Nc9Z/exM7R6mtCS9h3XmuoTHoN+SsnzHsmO3M9lrO0xwMVE89RuA5XbSB/hahC7yPVqH7w=
Received: from SI6PR03MB9045.apcprd03.prod.outlook.com (2603:1096:4:23d::10)
 by JH0PR03MB7808.apcprd03.prod.outlook.com (2603:1096:990:3f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Fri, 31 Jan
 2025 06:50:56 +0000
Received: from SI6PR03MB9045.apcprd03.prod.outlook.com
 ([fe80::53c9:58ef:a15f:6183]) by SI6PR03MB9045.apcprd03.prod.outlook.com
 ([fe80::53c9:58ef:a15f:6183%5]) with mapi id 15.20.8398.014; Fri, 31 Jan 2025
 06:50:56 +0000
From: =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>
To: =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
 <SkyLake.Huang@mediatek.com>, =?utf-8?B?U2FtIFNoaWggKOWPsueiqeS4iSk=?=
 <Sam.Shih@mediatek.com>, =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?=
 <Chunfeng.Yun@mediatek.com>, "john@phrozen.org" <john@phrozen.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "trini@konsulko.com"
 <trini@konsulko.com>, =?utf-8?B?RG9uZyBIdWFuZyAo6buE5qCLKQ==?=
 <Dong.Huang@mediatek.com>, "ansuelsmth@gmail.com" <ansuelsmth@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Ryder Lee
 <Ryder.Lee@mediatek.com>
Subject: Re: [PATCH 6/8] mediatek: mt7981: move gpio-controller up and rename
 pinctrl to pio
Thread-Topic: [PATCH 6/8] mediatek: mt7981: move gpio-controller up and rename
 pinctrl to pio
Thread-Index: AQHbcME36Hc8eQi4A06X+RdGUR6A8rMwd3CA
Date: Fri, 31 Jan 2025 06:50:55 +0000
Message-ID: <dfa58df7535df62dcc2c060de566b743d59574f7.camel@mediatek.com>
References: <20250127134046.26345-1-ansuelsmth@gmail.com>
 <20250127134046.26345-7-ansuelsmth@gmail.com>
In-Reply-To: <20250127134046.26345-7-ansuelsmth@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR03MB9045:EE_|JH0PR03MB7808:EE_
x-ms-office365-filtering-correlation-id: 7f439940-1b15-4c06-8a8f-08dd41c39cba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?Q01neGFSYXRIWG5lUVYybmdVN1M1Rm9JYWR1WFM5bHFGWUpkS1VIeHF4OTdz?=
 =?utf-8?B?dGFVN3lLNUtrdVRNZ0lZSFlqK25pVG5URm4wWHBoWFRsQlY1SFRYTDdia05o?=
 =?utf-8?B?QldnZ2pjZ2Q2bUdsUmRRaVFhRG0vVi9PVEx2VHdMekUrK2k1RmRNTmNUVCtm?=
 =?utf-8?B?Z1k1ZDJ6SGRoZlBuNkFiY1laZHJtbHZDTk9yOGVONGhDeG5uQUxtMHB2Wlo5?=
 =?utf-8?B?K3lVdFJJYTh2cGdIR0pPMklVWlBhUVgrUjBBZnV0VEVnUHBhYXZzQTEzYmV0?=
 =?utf-8?B?UmptRndwOXpvTkRSbWozenU5dHVRUFJqcEdHbEozYlBIRXZMNEFPMHF4WE8y?=
 =?utf-8?B?dU03MTZmYjVaQ0M2Q0luWUV2cDIyNldZbERDUDRjVDFZbXUyeGhSelRTYWwr?=
 =?utf-8?B?d1R5aXA0WFkvTjZLckFuVWtwNDk3Mi8rSjJldnIvZzZGQ0lCU0prMHAvaHdK?=
 =?utf-8?B?MFlRTHB3UHk1QVphTlFKNmFWbHViYmlGdFFNV0VqZ01IYzJyY1I3Ly9XKzBt?=
 =?utf-8?B?ZEl4R1B0RXlKOUc0ejNSSFFNWTdvcTJQenh1eitKVVBhdmdQWnZKbDI4RzJl?=
 =?utf-8?B?N0J2c0hCcDE2UlJLNkNzWHVPUFRhdEs5N1huMitJb0VEKzJhV0VQNkROSFMw?=
 =?utf-8?B?Tld2MEVxQkE2S1lCYkYyeFJodG1Cc0tEcFA0cmhac0hWZHM5TE9EaUU5bytS?=
 =?utf-8?B?ZTluL1BLM2FRakpiMGNxcUI3czQ3U2tRQ01PVmdNWFJKM0djV1lEWnNuc250?=
 =?utf-8?B?WExyTWFoQ2hEaS9VY0VxWWtlcTRPdXlqZTZITUx0RVlFdCtmSkhldllncUN1?=
 =?utf-8?B?M2RZWmRSVFh3Mld2c24yVFhRams0ZE1CWnBwQXJ5ZmRDTVNScUU3VFZqSlo5?=
 =?utf-8?B?a3VvSjVEWURaUGxydXdTWTMrT2ROZ3pWKzBhd2dJRVdWeG00Y2tFT1I1MDEy?=
 =?utf-8?B?azVobmhHWjZyVzFLOHpnRjB6OW5mZ0xQNzBVeUt4amlESEQ1dUkybUk1RkNn?=
 =?utf-8?B?NWNYUkhMVi9ETVEweUdjaDhPZFVxMVI2Vit4cFVpQ3o0cnVRZnFnQ05WOSsz?=
 =?utf-8?B?dDFvb29XVjNmb2lWYnYyWHp5OERCaEloWTJHKzNxZHRYeDVlTU1UdXplb2k2?=
 =?utf-8?B?OFc5MVROYnA4WVlITG9HTnJBa2t4VjVPYnA4cVBaOTdPVXpGQkRqMXUzd1p6?=
 =?utf-8?B?YmJ6RVlvZTFUcnVVeDdPN3JqZHhWMXgxbjBNVUZNV2dXcG5zS1Z2Snl5Rll1?=
 =?utf-8?B?SUpHQVlmangrall2R2VrSEZuVHBack53VmJuZjZ4RVhkQWEzRlVONWlzUnp6?=
 =?utf-8?B?dVM1NWRuaDZpWWRoM1ZqeHA5SUErNFVMM3VDbEVSeVkrcWhzWGdDelZJTWpt?=
 =?utf-8?B?V1MrWHVkZHptcHREWkdGaXk1bWNrWk93Yy9neFdicXFDREtGZkhOdjNoc1BS?=
 =?utf-8?B?QWUwKzE2WmpGeWh2MFlMYWFkQmN3dXlIakVQQS93NmJkNm14ZG5zdVR4VzF5?=
 =?utf-8?B?Q1YxQURyMGtJQTlxSHlrV1hqcnAwSUllVlE5OVhoTG5vbUNnOThDUVYvdTht?=
 =?utf-8?B?d2cxOUNydFZkR0JvVGNBWFQrUEFCRHlnV0RlS1FTekV0SFZDdFpOaGUzWUE3?=
 =?utf-8?B?K0tIY0xJaUpWV2RjSURVRE9PTVptOTZZdCtXQjcvdm5RcDNOOFFHVVprMThK?=
 =?utf-8?B?MVRRb080ellsOURpZ1RqN3ZycVJYcE5JcUV5TnVXSVFlSG5KeVlCd2x6dUdi?=
 =?utf-8?B?Rk9uaDYwbFhESWhXUTl4VGIwWWZERmNzNE5ZWEd6cGduMUNBR3kyblNFNjBi?=
 =?utf-8?B?NlNHbkFxbUNvZytUYi9FT3FYNGEwYWpBS2ZVcTMyMTlzTjZDV1M0QllBdGpX?=
 =?utf-8?B?c0VpZnpUU1RRVVp1Nnl6ZFdRbzIwRGZmRWd0VEZKSVNnWGw3SHlQY3MrTFZm?=
 =?utf-8?Q?1FlYxCJRaD9L2OU1Vw5kOaV6j4XdAEYZ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR03MB9045.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(921020); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmVIc2Ftbyt1bk9HZDlJdXF6dFhXb0twbDVkZ3ZOQVQ3Q1dlbnozMkRUWXF3?=
 =?utf-8?B?U3UzQUpCS1pUTWxoVllqTGx4clNGS2V1cHdCaUE5cVhHSlBiMjRGQldMUFRM?=
 =?utf-8?B?S3NHTEVicnRVeU13SUMxeDNlam4wa0FRQ0lmL3ZhUG9XV2s4WHZZSGdtWWFU?=
 =?utf-8?B?MFNIVkRyTUlhaHRpRm03WmxreEFTZFkzZHdHYVJ6a2lUclBqUXRTaGpDRERD?=
 =?utf-8?B?UXpXRUoxalVkbzdPM2RzaUdkSXorMVNWdWUzclBPQmZzR1FPOGRJYUNPYW05?=
 =?utf-8?B?WUhOQ0VUdUxjSVhJY2Z4blkvVFAvY2ZOS0dNUGFlMnJRaFBMdTJWWnJTVEth?=
 =?utf-8?B?M29GSWRuOTJBUmY5dVV1Y1EzRFRuQjVRS0FnaHYrZTBXRm04NWZMdU9tcUtp?=
 =?utf-8?B?bnZrSzBSKzR3eEp0bExKcEJDWEM2c1l5UVl2M1lORmcxa1RhcjZpQnJDZDNY?=
 =?utf-8?B?N1NVVEJtQVN6RW0wRXNzVUdPZytUYy8rUzVqM0Z6MzBWQ3BOTnhjeUV4UGlJ?=
 =?utf-8?B?NE1pUzBxQWYyeTBHT1V3UGIzZUZSYnUwS2pFRUhYelpQNFdTWUNVS2VOaE1I?=
 =?utf-8?B?UVJxTGxsUmg2VmdKbnVvdGhNZDVzL3BQRjF3eUlOR3duKzVjWVQvZWdFSmJF?=
 =?utf-8?B?TzZEQWZrbGRVVWp0WEpkNFVuZ0srZzcxWGlndHJFVlB6cy9wUFVoeXFIMm80?=
 =?utf-8?B?UVdPSkZjSy9COFhyc2NoTGRib0oxWTM2cXBaRlhLdUJFb2JqSHdpSnRFaHBM?=
 =?utf-8?B?OXNEZjlpbU1jd01JVzZMRGp4YVlVVWtXOHRlYThhdTdjcXhCVXU1YmNNLzNs?=
 =?utf-8?B?U1ZoQmJpeUt3djcvUmtkbTVjdzNyWTJqSGdBZHRzTnRWVjNsUnhtNlFXZ0Ni?=
 =?utf-8?B?RkpWUEZ3cnpkOWx5R2JvenRNZlNjSURVaU00bW4xaXdweUgwNHZVbCtDUEd2?=
 =?utf-8?B?ZTRHblA5U2UwM0ZERXloc3B2OTE4VTlOS1E1cGZub3dTTXB3REZiM1B1eGkr?=
 =?utf-8?B?bEJWNVdRNFd4L08zejZwMDc0UG5zdi9zR1NxM0pLVm1JZDVIQUJSOEJKdFd4?=
 =?utf-8?B?bXUzczlZaUEyNzdoc2k4SU51dVlRWU13Q1BTaDN0V3NJaGtFSnJYcXhOYlFF?=
 =?utf-8?B?d2VnMnBiN2Q0WTI3ZnB5cnlQRk5wNE1RaTh3WUt5N2NvMFR6Q0ExNm5Ia05s?=
 =?utf-8?B?b1NKYXAzUk9SV2dMZWFyVCtGS1F1QW5wSHhKWnJ0TUQwdGdMV0ZPN0loZnZN?=
 =?utf-8?B?N2hOMU9CbWtMeXpCL0RKKzZDc3ZNdU5kWWM2aElDREY3L3laYzh3QXVBdGdT?=
 =?utf-8?B?UitLWWZFL2w0Q1FHWHpEVE03RG5DblVWOHpQWkVZa0xYSys5U1JldDFidEFX?=
 =?utf-8?B?SnVxR3ZpZ3dUMEhTa0xKbGF4ZUdJOHJYTFRlZXlkc2N6VDQ2UTEwTWNZNThH?=
 =?utf-8?B?dWZLQzlPTlROZDIyeGhDMUowaWI3WHRVWTVtdm9yL0JwQjBDQTAwSW9qRFN2?=
 =?utf-8?B?Z3cyY0FDcGhxUjU4dXlQejJwa0tEUHZhWDZHMlB6S3VzUUIvazl2cXhiazVW?=
 =?utf-8?B?bEtsQTNsU1d2cGY0aVVyWkFTKys0SG5vOHUyRUt6bHpFZVNHSStIaEp5UUZo?=
 =?utf-8?B?RnVaRTgxWEw4RjBWQWxEWk5TbDF1MXEvYXgwSlVrY2IrZk1CM2FLQUdvYVJF?=
 =?utf-8?B?WW5qYjdJemFWVkVyRXJWbTQyVmw4VEJkZFYvejcvUDdldzZHa01HeDBrRFBE?=
 =?utf-8?B?cTNQUTdsWnhPTCttN3pxdkcxdjVaRTMrNWVFU0xuNTYzMU5nVWRJOXNZV2tU?=
 =?utf-8?B?dGxxYnZIL0NkOVNMOVkvUFZNYUw1bW9qeWtkdjZJQytiRmNKS1RRc25yRytB?=
 =?utf-8?B?WEljTDVTWE5ZT2hXN2N1L1NzMWwyRGNzQUhOMDlRUTl3QjFabCtCK3JxY1k4?=
 =?utf-8?B?SG40MndidEh0dXVFMFVYUU8xMUlIV2lHVzhrQzRvTzJOSWpPUkhiMFZyTlFF?=
 =?utf-8?B?aWs0cXYwUDRkRkJnZU9nbmk1ZlFnQ3ppZTVCMStJL253aW85VlVXVU5iOTQw?=
 =?utf-8?B?eUxHc3pKR2dXY2wyMVVqQVRRejNPMldMWFVkZ3F2UHByR0tSdUFDUWNXQjFV?=
 =?utf-8?B?N2ZuUkEzODRNSVp3bytBRUJVV05sYUtITW5OOW41eHdwTy9hZG5seXBJMFhi?=
 =?utf-8?B?T0E9PQ==?=
Content-ID: <0E4DEDAC81880B4CAB3BBA5BB84A1B4E@apcprd03.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR03MB9045.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f439940-1b15-4c06-8a8f-08dd41c39cba
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2025 06:50:56.0034 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Iq+iBhf01xR5OADlGJyjbCH4QGDaX1gEF/q2CAAkV/81Jszbz/2inqwoY16YECaUjt6a4z5gSkgSU8DAxPCG5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7808
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

T24gTW9uLCAyMDI1LTAxLTI3IGF0IDE0OjQwICswMTAwLCBDaHJpc3RpYW4gTWFyYW5naSB3cm90
ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUg
Y29udGVudC4NCj4gDQo+IA0KPiBNb3ZlIGdwaW8tY29udHJvbGxlciB1cCB0byBwaW5jdHJsIG5v
ZGUgYW5kIHJlbmFtZSBsYWJlbCB0byAicGlvIiB0bw0KPiBtYXRjaCB0aGUgbGFiZWwgdXNlZCBp
biB1cHN0cmVhbSBrZXJuZWwgbGludXguDQo+IA0KPiBVcGRhdGUgYW55IERUUyB0aGF0IHJlZmVy
ZW5jZSB0aGUgcGluY3RybCB0byBmb2xsb3cgdGhlIG5ldyBuYW1pbmcNCj4gYW5kDQo+IHN0cnVj
dHVyZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBNYXJhbmdpIDxhbnN1ZWxzbXRo
QGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBhcmNoL2FybS9kdHMvbXQ3OTgxLWVtbWMtcmZiLmR0cyB8
IDQgKystLQ0KPiAgYXJjaC9hcm0vZHRzL210Nzk4MS1yZmIuZHRzICAgICAgfCA0ICsrLS0NCj4g
IGFyY2gvYXJtL2R0cy9tdDc5ODEtc2QtcmZiLmR0cyAgIHwgNCArKy0tDQo+ICBhcmNoL2FybS9k
dHMvbXQ3OTgxLmR0c2kgICAgICAgICB8IDggKysrLS0tLS0NCj4gIDQgZmlsZXMgY2hhbmdlZCwg
OSBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNo
L2FybS9kdHMvbXQ3OTgxLWVtbWMtcmZiLmR0cyBiL2FyY2gvYXJtL2R0cy9tdDc5ODEtDQo+IGVt
bWMtcmZiLmR0cw0KPiBpbmRleCBkNjU5MGYwMWNmOC4uNjdmMTc4YmMyMzIgMTAwNjQ0DQo+IC0t
LSBhL2FyY2gvYXJtL2R0cy9tdDc5ODEtZW1tYy1yZmIuZHRzDQo+ICsrKyBiL2FyY2gvYXJtL2R0
cy9tdDc5ODEtZW1tYy1yZmIuZHRzDQo+IEBAIC00OCw3ICs0OCw3IEBADQo+ICAgICAgICAgbWVk
aWF0ZWssZ21hYy1pZCA9IDwwPjsNCj4gICAgICAgICBwaHktbW9kZSA9ICIyNTAwYmFzZS14IjsN
Cj4gICAgICAgICBtZWRpYXRlayxzd2l0Y2ggPSAibXQ3NTMxIjsNCj4gLSAgICAgICByZXNldC1n
cGlvcyA9IDwmZ3BpbyAzOSBHUElPX0FDVElWRV9ISUdIPjsNCj4gKyAgICAgICByZXNldC1ncGlv
cyA9IDwmcGlvIDM5IEdQSU9fQUNUSVZFX0hJR0g+Ow0KPiANCj4gICAgICAgICBmaXhlZC1saW5r
IHsNCj4gICAgICAgICAgICAgICAgIHNwZWVkID0gPDI1MDA+Ow0KPiBAQCAtNTYsNyArNTYsNyBA
QA0KPiAgICAgICAgIH07DQo+ICB9Ow0KPiANCj4gLSZwaW5jdHJsIHsNCj4gKyZwaW8gew0KPiAg
ICAgICAgIHNwaWNfcGluczogc3BpMS1waW5zLWZ1bmMtMSB7DQo+ICAgICAgICAgICAgICAgICBt
dXggew0KPiAgICAgICAgICAgICAgICAgICAgICAgICBmdW5jdGlvbiA9ICJzcGkiOw0KPiBkaWZm
IC0tZ2l0IGEvYXJjaC9hcm0vZHRzL210Nzk4MS1yZmIuZHRzIGIvYXJjaC9hcm0vZHRzL210Nzk4
MS0NCj4gcmZiLmR0cw0KPiBpbmRleCBkNmViZDY1MzljMy4uMDhlMWI3NmI0NzMgMTAwNjQ0DQo+
IC0tLSBhL2FyY2gvYXJtL2R0cy9tdDc5ODEtcmZiLmR0cw0KPiArKysgYi9hcmNoL2FybS9kdHMv
bXQ3OTgxLXJmYi5kdHMNCj4gQEAgLTM5LDcgKzM5LDcgQEANCj4gICAgICAgICBtZWRpYXRlayxn
bWFjLWlkID0gPDA+Ow0KPiAgICAgICAgIHBoeS1tb2RlID0gIjI1MDBiYXNlLXgiOw0KPiAgICAg
ICAgIG1lZGlhdGVrLHN3aXRjaCA9ICJtdDc1MzEiOw0KPiAtICAgICAgIHJlc2V0LWdwaW9zID0g
PCZncGlvIDM5IEdQSU9fQUNUSVZFX0hJR0g+Ow0KPiArICAgICAgIHJlc2V0LWdwaW9zID0gPCZw
aW8gMzkgR1BJT19BQ1RJVkVfSElHSD47DQo+IA0KPiAgICAgICAgIGZpeGVkLWxpbmsgew0KPiAg
ICAgICAgICAgICAgICAgc3BlZWQgPSA8MjUwMD47DQo+IEBAIC00Nyw3ICs0Nyw3IEBADQo+ICAg
ICAgICAgfTsNCj4gIH07DQo+IA0KPiAtJnBpbmN0cmwgew0KPiArJnBpbyB7DQo+ICAgICAgICAg
c3BpX2ZsYXNoX3BpbnM6IHNwaTAtcGlucy1mdW5jLTEgew0KPiAgICAgICAgICAgICAgICAgbXV4
IHsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgZnVuY3Rpb24gPSAiZmxhc2giOw0KPiBkaWZm
IC0tZ2l0IGEvYXJjaC9hcm0vZHRzL210Nzk4MS1zZC1yZmIuZHRzIGIvYXJjaC9hcm0vZHRzL210
Nzk4MS1zZC0NCj4gcmZiLmR0cw0KPiBpbmRleCAyYWRiYzM3NDcyNS4uMmY0M2U2NWFjNWIgMTAw
NjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2R0cy9tdDc5ODEtc2QtcmZiLmR0cw0KPiArKysgYi9hcmNo
L2FybS9kdHMvbXQ3OTgxLXNkLXJmYi5kdHMNCj4gQEAgLTQ4LDcgKzQ4LDcgQEANCj4gICAgICAg
ICBtZWRpYXRlayxnbWFjLWlkID0gPDA+Ow0KPiAgICAgICAgIHBoeS1tb2RlID0gIjI1MDBiYXNl
LXgiOw0KPiAgICAgICAgIG1lZGlhdGVrLHN3aXRjaCA9ICJtdDc1MzEiOw0KPiAtICAgICAgIHJl
c2V0LWdwaW9zID0gPCZncGlvIDM5IEdQSU9fQUNUSVZFX0hJR0g+Ow0KPiArICAgICAgIHJlc2V0
LWdwaW9zID0gPCZwaW8gMzkgR1BJT19BQ1RJVkVfSElHSD47DQo+IA0KPiAgICAgICAgIGZpeGVk
LWxpbmsgew0KPiAgICAgICAgICAgICAgICAgc3BlZWQgPSA8MjUwMD47DQo+IEBAIC01Niw3ICs1
Niw3IEBADQo+ICAgICAgICAgfTsNCj4gIH07DQo+IA0KPiAtJnBpbmN0cmwgew0KPiArJnBpbyB7
DQo+ICAgICAgICAgc3BpY19waW5zOiBzcGkxLXBpbnMtZnVuYy0xIHsNCj4gICAgICAgICAgICAg
ICAgIG11eCB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGZ1bmN0aW9uID0gInNwaSI7DQo+
IGRpZmYgLS1naXQgYS9hcmNoL2FybS9kdHMvbXQ3OTgxLmR0c2kgYi9hcmNoL2FybS9kdHMvbXQ3
OTgxLmR0c2kNCj4gaW5kZXggM2M4YjlhYjA1NzQuLmIyYzRjZDdiNTRhIDEwMDY0NA0KPiAtLS0g
YS9hcmNoL2FybS9kdHMvbXQ3OTgxLmR0c2kNCj4gKysrIGIvYXJjaC9hcm0vZHRzL210Nzk4MS5k
dHNpDQo+IEBAIC0xMDYsNyArMTA2LDcgQEANCj4gICAgICAgICAgICAgICAgIGJvb3RwaC1hbGw7
DQo+ICAgICAgICAgfTsNCj4gDQo+IC0gICAgICAgcGluY3RybDogcGluY3RybEAxMWQwMDAwMCB7
DQo+ICsgICAgICAgcGlvOiBwaW5jdHJsQDExZDAwMDAwIHsNCj4gICAgICAgICAgICAgICAgIGNv
bXBhdGlibGUgPSAibWVkaWF0ZWssbXQ3OTgxLXBpbmN0cmwiOw0KPiAgICAgICAgICAgICAgICAg
cmVnID0gPDB4MTFkMDAwMDAgMHgxMDAwPiwNCj4gICAgICAgICAgICAgICAgICAgICAgIDwweDEx
YzAwMDAwIDB4MTAwMD4sDQo+IEBAIC0xMjAsMTAgKzEyMCw4IEBADQo+ICAgICAgICAgICAgICAg
ICByZWctbmFtZXMgPSAiZ3BpbyIsICJpb2NmZ19ydCIsICJpb2NmZ19ybSIsDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAiaW9jZmdfcmIiLCAiaW9jZmdfbGIiLCAiaW9jZmdfYmwiLA0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgImlvY2ZnX3RtIiwgImlvY2ZnX3RsIiwgImVp
bnQiOw0KPiAtICAgICAgICAgICAgICAgZ3BpbzogZ3Bpby1jb250cm9sbGVyIHsNCj4gLSAgICAg
ICAgICAgICAgICAgICAgICAgZ3Bpby1jb250cm9sbGVyOw0KPiAtICAgICAgICAgICAgICAgICAg
ICAgICAjZ3Bpby1jZWxscyA9IDwyPjsNCj4gLSAgICAgICAgICAgICAgIH07DQo+ICsgICAgICAg
ICAgICAgICBncGlvLWNvbnRyb2xsZXI7DQo+ICsgICAgICAgICAgICAgICAjZ3Bpby1jZWxscyA9
IDwyPjsNCj4gICAgICAgICB9Ow0KPiANCj4gICAgICAgICBwd206IHB3bUAxMDA0ODAwMCB7DQo+
IC0tDQo+IDIuNDcuMQ0KPiANCg0KVGhhbmtzIQ0KDQpSZXZpZXdlZC1ieTogV2VpamllIEdhbyA8
d2VpamllLmdhb0BtZWRpYXRlay5jb20+DQpUZXN0ZWQtYnk6IFdlaWppZSBHYW8gPHdlaWppZS5n
YW9AbWVkaWF0ZWsuY29tPg0K
