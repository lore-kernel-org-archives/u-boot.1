Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E57E6BF0E
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 13:28:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3B3A842FE;
	Fri, 30 Jan 2026 14:28:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="AS2T7GlB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58454841DD; Fri, 30 Jan 2026 06:26:29 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDB9983D1A
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 06:26:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLZmPXsjLbCtDpUfNpqwfwBY/lRYsMgMcq6u4WXt8544/NkR/0Z1v5P0Ms23NTDeYevb/MtauUbXUMgDVhthybWb52elYxigJveQ+YxNYNB9yQSuCvnhiQgvJAPUzxh8CVodV/gdgtTbFcBTCnwT4WKUNSuS0lmcB6nWIT/k8VwveAc+6LIBT5bZpVz52UyKeE9TnPmcYWPoztBYLRT8RaIAgHfNI5lbs4E2vtk9m56mG/aWhehuZr83G2x1FH/BkFae6sr9XabvYcq6FBWuWlA642DaXAuMiIeRyM0LJSk00RLesTx0xaOl9grCqlpwtnPAkFlyoCWYxhepgyZMFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fT9S0le8iWSGMQR2zDyGBYj59rHHKN59K0yAQ7X+6V4=;
 b=aVirdu37OJgm+H6QJRRe+RBk/4QMBVyWZ8BYG7BgiPwGafS2nBltougeNdYN2GUchYw64qVP6v/NCDX6rgSl0REQtDGqYUe518f33U5kC7g5NJRZGxRkFCqVFM1jnRarviDTmHdvpbbk2hFTuPAcNps7684aY7/4clQYzbVVb98QlG3PCuORBXFQlwVwUaz/VgLXpmaF2F5MaH1QVQj1lhMrodUquycSMvE4+uerCK7hLBfJlhJvgXe8sXwKNFFaFFIix2CDM0QxhS7X1p7igh+lA3XNz0ikKEwH0ikce6FvbbUQxMBw0JHguL3O6EY3BPs+k7XAXbELda+1FIyMEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fT9S0le8iWSGMQR2zDyGBYj59rHHKN59K0yAQ7X+6V4=;
 b=AS2T7GlBYzg1sNT6sry2rVA5xoLeq8ZTraNZt7gsg/os79Vu7Y69GYMb3As8iwN661chCzeF8kej/FJeHdwSGhbuCsVrjsNzedbv+PhgOTH9Wi5mmyYCIeSoqAOaMKCmX4jBhjg7WXEt81MVRDgS5MmS1QyS24k7kqe26kPnkz8BRWLN8sjkSA8p++mBHoDjV+JyNxoRgTeH55UMi/ycAKpna0xPD7rQsTKPuFlRrW38+FB7TBBGznjr8zGGH/yUBp/uaW2esa9rdiClD43hJFT0IG4dQLPGGvsBJB3tCugkJy3CRTraTnVVl/FjH0pXu2E51xQQFpjcJbyde0agaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by SJ0PR03MB5792.namprd03.prod.outlook.com (2603:10b6:a03:2d5::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 30 Jan
 2026 05:26:23 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%7]) with mapi id 15.20.9542.010; Fri, 30 Jan 2026
 05:26:23 +0000
Message-ID: <781ac487-3219-4217-914a-8983a45f0fd2@altera.com>
Date: Fri, 30 Jan 2026 13:26:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] mtd: nand: introduce SPL_NAND_FRAMEWORK_CAPABLE
 Kconfig option
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Jan Kiszka <jan.kiszka@siemens.com>,
 Tien Fong <tien.fong.chee@altera.com>, Kok Kiang <kok.kiang.hea@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>
References: <20260129050446.8858-1-dinesh.maniyam@altera.com>
 <20260129050446.8858-2-dinesh.maniyam@altera.com>
 <20260129152426.GV3416603@bill-the-cat>
Content-Language: en-US
From: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
In-Reply-To: <20260129152426.GV3416603@bill-the-cat>
X-ClientProxiedBy: SI1PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::19) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|SJ0PR03MB5792:EE_
X-MS-Office365-Filtering-Correlation-Id: d3b77191-1fd7-4529-40cf-08de5fc01b7f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZzM4NUtCVG4wbVBKWVk1bDZYM3JxekNQNlhZOEQ1QVZ2YU1Va3BzRFFOQVJG?=
 =?utf-8?B?c0dCRVZodjJONWxDdjRwS25CZDRSemhoMFdrTUFqU0oxUjI1VnlFRW1MMm5i?=
 =?utf-8?B?SVpPbytNYXcydE9PZGEveTdaMElQZGJ4MHF5RVNmL0VhMjJadHRoWlRVckc3?=
 =?utf-8?B?M2F0WUJBMFp3KzdjZmxkbUFEa2ZmcEk4SkpCM1RtSitnSFpaNU5PM2JOZGRL?=
 =?utf-8?B?L2pISHJzZ2pRQUUvR3FRZ1NMK2tGcU53UDRKM09RMGRtT0o4MXp3TWZVL2Rj?=
 =?utf-8?B?M2pEc1JNa2ZuSUowMXZ6Yk1PNVBvUThlOTZKb2NtUm9iREFKYldoMUNWU1lz?=
 =?utf-8?B?TTJpbnJ1eDQ4VmF3N1o0RDA0WjdHalVmNVMxM2VNZjh3R1VKWm1NSm41WDdZ?=
 =?utf-8?B?amFOY3BBRE9ycDhVL3pvRkMzNEEza1lnbXBqcURBUTl0dXJGMVE0TWgvZFhH?=
 =?utf-8?B?RTZ2eWg4Ykpsck9LZDBjaWs2U1pkQzZybzFmNm1rOHoxRkZJZjFTNWIwaG56?=
 =?utf-8?B?ZjZ1ZHgxNHpaazh1SjIwNTZHNjRRc0VzVmFRRXBLb0hwOXdmUGtJRm1qV0N0?=
 =?utf-8?B?MG91MFNMVHNsSlJPeitPdGFOdU0xL0UwM2w0QnBETUxvZlltSDg0Wk9HWDNO?=
 =?utf-8?B?S25sOWRONFE4ODJ3VDB3cFJqcjlsK2ZCZGNkeDdDdU52ZnA3aWRBZ3JRRDVU?=
 =?utf-8?B?NEZ4THllZEE3RVQ3Wld0dll0TWthZzVYYU5wU21oL0lJY2FWZndnKzZtRXFD?=
 =?utf-8?B?ZjhIdi9tOHU1ZjZRTWtIem5ZNlVTdFh1UlhIQU1UVy9kVGNwL1RYaVhRYTk5?=
 =?utf-8?B?YWNXZHpqRi96UlhBeGFVYUlRMlJTaktOamhjcXY4OENsVXJsOEZLbFZhOTNC?=
 =?utf-8?B?S1F4VTdCZUU3QytFcElodDVLNnNwMWpPREhSTkw1bXNsV1BqQ3d2a3p3WUNO?=
 =?utf-8?B?d1RzcG1odjhSWlpwVjVVellFT3RCbGhhZjRhN1VraWErR2w0cm5OSy80TUxX?=
 =?utf-8?B?Uk5BMEVKdDd2UHVhMTdvS0J3QTBvZUZ1YzVBYzlNVjRSc2QwY21WM1VNbUxk?=
 =?utf-8?B?WjYwdGZhVGtoVWxHcVplOUIzbDJjQ085STI4NzJubThDT0c2eGhaczJNbHpo?=
 =?utf-8?B?anJsTkx1YzNWTy83UGQ4VmR0RVVnYnFsM3lGTWMrMzQyQnJqWEIyUkZHZUxU?=
 =?utf-8?B?N1JjQ0wwNllaZ3BJSCtGenR6S2N3cXk4NDVLbkk0ajU5UmNRTEJFUDdPdG4x?=
 =?utf-8?B?clJhNUxxY3U5M3g5Nmg5TGthWTAwZElRaUF2b3UzclBnbHBKQTU2SjZJbVEz?=
 =?utf-8?B?Y0xWWW5tL0d6Z2tmcGxsNkNMWVhXcHZpSFRWd2phRjBOcFUzU3I3blJ0NDhw?=
 =?utf-8?B?dFpIcWRBMXJIZnltVWJWWGwvcXNoeHZsR3YydFBvUFd1NVdJQjhjZm1wQ3RG?=
 =?utf-8?B?OTNnKzdDdXdpUEFjTno5ZFJzRHdJdlpsLzhDdGR0S2szWDdNdVkvQUVQU2ht?=
 =?utf-8?B?QnhWT281cWVGZUFWcDdHRnkrTlp3bGNLVGtiV015Tnd0UVJGUGk5Z0J0ZWds?=
 =?utf-8?B?Sm4rdHRPZ0Y0UnVlWit3UHRmYTd0RUVhS25Xd2FCRVZCWEJpcWUwNHNXa2lq?=
 =?utf-8?B?ZUo2R0JOYW13d0RKYlRVQTdOb2ExY3RZbmRka0I0UmczM2FLbmNwbE5MdEU5?=
 =?utf-8?B?RS9OWjFqQVU3NmdMdmRJakhWTnRBUDk2dnNLa3Y4dmpaQnBsU2JEMFV4a2NM?=
 =?utf-8?B?MnRyc1pZa0dEYWUwSE5BM2lXRGd5Tm9HZmJTR3BvSGJERzdHQ2RSRWV6dTdE?=
 =?utf-8?B?bWEwdE1vZzllemNScUExNmtzV21yM0lIalJ6UDJHUzViZU4yZE1MeCs4ZlJY?=
 =?utf-8?B?dDRyZTFrWDNUMzlRMDc1MHRlV2VSNW1tYVljTHplN3hhUDdPUVZyaEMyeUg3?=
 =?utf-8?B?Ri9sSmFOWHc2UmtoZWVaNlJTWlQzN3lLWUJYZnp3U2xjQVM5V1VYUXY1QlBU?=
 =?utf-8?B?NlhxSUNLOThmc1ArRHV3cEZOSCthdThycFlZTlhZZDBFSHJWWDMwa2ZSME1a?=
 =?utf-8?B?dXhueGgydGhiZ2lId3ZwYlJ0Z2daMGpXTDZXNG1ka01RUHNHMUZZOW8xelZr?=
 =?utf-8?Q?1RS0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHNmMU1oSTl0MGxIZTRQd3BxeklUUUJUYnVSNmdUTTE2L1l1bVVRNzdxS0Nm?=
 =?utf-8?B?VDQybitmOSt6bXBOVHFSSWlvODl2YVBNdWRDNWoyTS9jZ0p6L3kzS2VvUE9j?=
 =?utf-8?B?RXZCRlJFNWhQSllEQUlETTBOVTdlVVBIRUtDemFkbjFuSDkwVC9WSEZDK1ph?=
 =?utf-8?B?Zkg3UTNrMTFESWJWOFBBdXcweGZjWGZJbytBTm1hUGJBYWorbUd4REdWQndB?=
 =?utf-8?B?WkdTVTllRWlBQlpLYS9KczROZVNienJ5Ri9mc0pkZkthemlUeVV3VStFamxs?=
 =?utf-8?B?NklteVJ6ZkJCLzJvVlh0M3VVcjhHVC9JTVBkVmVGaWlSMEhkYzh0bkhBNGx3?=
 =?utf-8?B?cElRMERKSUlITm9LYW4wUjJrSUZxNmxMQWhNSDkzclcrK1BvcWNPbHV1RHJo?=
 =?utf-8?B?SC9zODMzQUxXMnA1MFBhSHdNUjhkMHpKb1QrS0xhZnhXSGc2VmtEZGNtb3Rn?=
 =?utf-8?B?SVFMTFlNM2x4K0V4RWlMejhFNFdNUjBRbnpxaVdxUU9ldWIvUkJtZWVHdUVo?=
 =?utf-8?B?ejFtN0RXR3Y3UFhZUXliVHVPeXpxelJQQ0RsWVgvUytYM0VrWE0yTVdnZmlu?=
 =?utf-8?B?U283czU1TEJoNzhmaW14S3pqZ2JOWEpJVXE5QmFLck9LVUhHSGVQOHBFT0N5?=
 =?utf-8?B?dmswdWg3dkYrRnNBVzdHdUhLNG42dDJQZHdiTStxU2J0NnVTbVgxTVE1dGxm?=
 =?utf-8?B?L3ZNZldyNnpCS2NJVnN3UFE4QVVuSW14UWdpQjNLOTZKejhralVnY3NucURE?=
 =?utf-8?B?MUdETnE0eHBlOVFPMDZ1NEFSOVpPdlAvZ09PQWhuVm04dUNyYVUrZGZxbUdw?=
 =?utf-8?B?ei9oYUFIR2Z2YXRWNzdpMlpLSXJ1SGNHQU1FYlA0WHJOeEFwMlRab0hBMjVN?=
 =?utf-8?B?U2EvVXN4LzNjVVIzZHVvcTFwY25HaWxVU2FWazJmcGJka1AySHJaMjBvTkN2?=
 =?utf-8?B?aTcyWlc3WnoyUXpmTzc4NWJxV1hwTHZzV0ZYc3ZDdFNsRE0zSG44dDZleVBZ?=
 =?utf-8?B?cEpBdmJVTDlvNitUR0RKbUs5RjZzU1JIalFPZXB2eWNNSTlNYVRtRWh4Y3lP?=
 =?utf-8?B?cS9NTHJNdmZQWExydzhaNkFrQ3ZOeDEySnNrdDhPZ0RQUGhyMkNXNGRLeDl5?=
 =?utf-8?B?cnVLYmY2QStIUUJraVhiMHJxeWNuOWxPSmpDK3BicGI4ei9NTkViL3lxc0wz?=
 =?utf-8?B?UkNrNDJhUEVVcjh3SmlJMm9QS0xEaENCZVE1ZVdqc3ZjMU9JaXBTYVpzaHh3?=
 =?utf-8?B?Z3BGUGxqUDhrQk5udG1DSzkrallXVkpEcmxVYXU0Y2UzT242ZTVIVjBBeDR5?=
 =?utf-8?B?T21XQkl4V0ZYWXRzajN5SWlUK3E2bzJxU3RIMzBTM25xT2dGT0s1SHI1UWYz?=
 =?utf-8?B?andhWVhoUHdQSk1Ta1lmT3Zvano5SUpaYXlLQnp4YXZwRkpWZ2laeVAyNGRZ?=
 =?utf-8?B?dTVvKzRzbUlETDBNVk1jd09kTmNvemRXMDZ4dCtjc1J6U1UxT2srWkxJZlV5?=
 =?utf-8?B?bGF3UWNtKzJWWW5tUXg5OGN0d0VQbUdZeXI2b2lNRFRIZzZzK2M0L2JhbEsr?=
 =?utf-8?B?S29BZnUrbjlOdXkvdmxVQnZMeStFQ2k1a1dZTUM2ZkpDbUt6MExqVGhmSU5u?=
 =?utf-8?B?S0MyeW5Ebm45YzE2VEp2c1lSeU1XbEpzN2RtMWJqczd6eEh2dU9lc1VVb28r?=
 =?utf-8?B?WXBJTkpmdHRuRHdsMnpwOVZ3VXQ1Z1NqcDhlWVBuWmJNNXhJMlJtMTQrdGMy?=
 =?utf-8?B?a0NLdmQwVmJzK3l3MDZHd3dqLzNTTVhFRkNrWEJzZUhMajJtbDNjTDJQUC9I?=
 =?utf-8?B?ZEFaVjdsK3FkUzFWUmpVK2FLQm9XV3pIT09ZdlZpYk0wQ0thcUxrZGJOaFFW?=
 =?utf-8?B?dWhwbnJ4SThEbWlFNG1lRDJycnlnRUg4UGlkODVMRGlRcGJpTzFrR1FRT2JF?=
 =?utf-8?B?R21aZlRrK0I2K0Mya0QrNjhtclNFTjVJaG14Z2dkTmZvUGVxeUdyV00wT21Q?=
 =?utf-8?B?cTJzZXljejVIaEwvRjJRSHNvelVnNzlDMFp0OGNpYkdxNG8rQzVoR09ZY2Mw?=
 =?utf-8?B?Skpnbm1ZM1ZQRDZuM3RTSVlXelhObmJXcFpDL0hsd0tXTGYrNkw3ZE1UWXVO?=
 =?utf-8?B?bVBDenJwUDJVcWZ1cWY1MVJybXdMYk1lV2RDa3VPVE9zYnpaM3JQQllpZHZC?=
 =?utf-8?B?bUV1OEN4KzZVNGk1U2Z0VUp4NERjTllMTW5oQy9ncThMRzdKblczTE9DUlhM?=
 =?utf-8?B?VU1yQmswUGkvOEt1QUpVbWs2L2Z0Wlk4cHRaSTJNVGx1dVdXdmJFdGlLUUh2?=
 =?utf-8?B?QzdSRHllQlVqNW5mdlFURHhuT21Fa1JWdzI5SHJ6TkNYOE1UUHMzMlVTNHpC?=
 =?utf-8?Q?Ep17XkGsvUfcYoLY=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3b77191-1fd7-4529-40cf-08de5fc01b7f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 05:26:23.6888 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ByYVVvmtpzQWDHamNXot1ofZ2NoqpJ1WtSqsmUBgPZmkBgUOGGiyJHEhocqhi5UdJFRsAkdHeucxU8rgfdY49OE2PIuIy5cwGPqJOqOR+cE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5792
X-Mailman-Approved-At: Fri, 30 Jan 2026 14:28:16 +0100
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Tom,

On 29/1/2026 11:24 pm, Tom Rini wrote:
> On Thu, Jan 29, 2026 at 01:04:42PM +0800,dinesh.maniyam@altera.com wrote:
>
>> From: Dinesh Maniyam<dinesh.maniyam@altera.com>
>>
>> The SPL NAND MTD framework requires working driver model support
>> and sufficient memory resources, which are not available on all
>> platforms.
>>
>> Introduce a SPL_NAND_FRAMEWORK_CAPABLE Kconfig option to allow
>> platforms to explicitly advertise support for compiling the full
>> NAND/MTD framework into SPL.
>>
>> This avoids accidental enablement of the SPL NAND framework on
>> platforms that cannot support it and provides a clear capability
>> boundary for platform maintainers.
>>
>> Signed-off-by: Dinesh Maniyam<dinesh.maniyam@altera.com>
>> ---
>>   drivers/mtd/nand/raw/Kconfig | 25 +++++++++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>>
>> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
>> index e0ff28cb21b..e41e5ef2e94 100644
>> --- a/drivers/mtd/nand/raw/Kconfig
>> +++ b/drivers/mtd/nand/raw/Kconfig
>> @@ -809,6 +809,31 @@ config SYS_NAND_HW_ECC_OOBFIRST
>>   	bool "In SPL, read the OOB first and then the data from NAND"
>>   	depends on SPL_NAND_SIMPLE
>>   
>> +config SPL_NAND_FRAMEWORK_CAPABLE
>> +	bool
>> +	depends on SPL_DM
>> +	depends on SPL_HAS_BSS_LINKER_SECTION
>> +
>> +config SPL_NAND_USE_NAND_FRAMEWORK
>> +	bool "Use NAND/MTD framework in SPL"
>> +	depends on SPL_NAND_SUPPORT && MTD
>> +	depends on SPL_NAND_FRAMEWORK_CAPABLE
>> +	depends on SPL_ENV_SUPPORT
>> +	depends on ENV_IS_IN_NAND
>> +	select SPL_SYS_NAND_SELF_INIT
>> +	select SPL_NAND_BASE
>> +	select SPL_NAND_DRIVERS
>> +	select SPL_NAND_IDENT
>> +	select SPL_NAND_INIT
>> +	select SPL_NAND_ECC
>> +	help
>> +		Enable loading U-Boot from NAND in SPL using the full
>> +		NAND/MTD framework instead of the minimal SPL NAND loaders.
>> +		This provides bad-block aware reads and flexible offset
>> +		handling via the common NAND/MTD infrastructure.
>> +		Platforms enabling this option must also provide working
>> +		driver model support and sufficient SPL memory resources.
>> +
>>   endif	# if SPL
>>   
>>   endif	# if MTD_RAW_NAND
> It sounds like dependencies are missing on existing symbols, and should
> be added there, from the description. It also sounds like these
> platforms have hard limits on SPL size, but aren't setting the
> appropriate options to enforce that at link time. Or am I totally
> misunderstanding?
>
> Spot on!
> The SPL memory requirement was only documented in the help text.
> Add an explicit dependency on|SPL_MAX_SIZE| to ensure platforms enabling the
> full NAND/MTD framework in SPL declare sufficient SRAM.
