Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C26EECD6C4
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 16:09:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79E7883A47;
	Wed, 11 Feb 2026 17:09:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="fIGNLk2G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2257983B30; Wed, 11 Feb 2026 17:09:54 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EC478388D
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 17:09:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kImPq3vY9NM80q3biFbsvRl4QnrMgQjVpfJxwzncnDY8RlUOk8TZQRRR8AVwGAsFa/Q9KchImaVHzGuxx5Z+kegT8yD03o6RFKJKeUfJeSu+cofoMrKSr/TgLGjGajqGYnxn60dZz/UONBEzewYQ7STFfn3CS+e5UFUmpclTLuBKTgiPlt0wp3hUqW5yn/XfVGnklXS7G8UthHY3eEN4ihnI5lrrr7mDWTJwJG1tL1j//IMl4H/Ud4is8OCPMulbauMwIDU8+TGQz+GxbA8zzquX0Wv3MHxNf7QyFaXf/ot9xlKezT+tok6KFhWyrfgqoRp6E3I7SgWdWqlR3Ci4kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rJrGNnk51cyaRDhNFm9My3igQvzk/ImDYrCIn1OoSU=;
 b=ZesCtFiy898E/Aazi2rQd7IUzsy5G+PSrs5kwUn53UqgMt2rZtn3gtj4/ZAtD3R5tX1ztwwU0x+B29p73cczUQ1I0OmzJnigWW3zuwKM95QDKtJ1UEy6o6RdyyH/HpET6weDmMeH8/YifBs4yXO2I6SVxdiV9rS0/GzBly22bxE+/NzFxJ7MtljYG8ii4TeGpbQq+dJlpr1ir4ujyIZBOvy7gOHj07AK4CQ8j4CWebNM9/mIV8MTNZ+TzxQa9WcE+Zpfk3Y9NxykZrzYlFAehanAMD6wqGKPWIP+uEJQTrTEnmWnwiiSmsWfD+hZdf4RJZ6Jg7jwIjJbKy4WhHYfNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rJrGNnk51cyaRDhNFm9My3igQvzk/ImDYrCIn1OoSU=;
 b=fIGNLk2GnXuJr7FA4Ahe2Hx7Xr6M+zAJhl2ELurjvFlegExAqqGxgYYwO3UCpoBJARAZe6cxWN7aKH/cTrG4Sn+nxlh/Z3Y+yOvHg2emUJS73nANFfUyWlFoWchqKAXj8U98K4v1TkYacSuXpnmi/u2QMfWTxZYQna0UIfb6G3Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AM8PR04MB7732.eurprd04.prod.outlook.com (2603:10a6:20b:237::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 16:09:48 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 16:09:48 +0000
Message-ID: <0a7e63ad-6760-4190-a334-dbd564d3c3e8@cherry.de>
Date: Wed, 11 Feb 2026 17:09:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: EXTERNAL - [PATCH v4 6/6] test: binman: Add test for pkcs11
 signed capsule
From: Quentin Schulz <quentin.schulz@cherry.de>
To: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, Simon Glass <sjg@chromium.org>
Cc: Simon Glass <simon.glass@canonical.com>, u-boot@lists.denx.de,
 trini@konsulko.com
References: <20260120081206.251544-1-Wojciech.Dubowik@mt.com>
 <20260120081206.251544-7-Wojciech.Dubowik@mt.com>
 <dc9c88ee-d5a2-49f9-b8d6-629f6ad01c36@cherry.de> <aXDJ4PrbO2eL63B-@mt.com>
 <53afb4f1-ff00-40e7-8aac-3d0bd1275450@cherry.de>
 <CAL6eLbp5DjRMenAkYMH6zU=4NOakhk_7W+aYDeB8MjLtGXgsfg@mail.gmail.com>
 <74ead874-927c-4ece-aafa-808cd054ef3a@cherry.de>
 <CAFLszTjH=Yv72oDucXJHyhGrEvtRLRq_7EO8nRd2B2K6TttiRw@mail.gmail.com>
 <aYGvNb33Eoozx4zk@mt.com> <73085ea7-6207-4a60-871d-daf0620f4df7@cherry.de>
Content-Language: en-US
In-Reply-To: <73085ea7-6207-4a60-871d-daf0620f4df7@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0035.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::8) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AM8PR04MB7732:EE_
X-MS-Office365-Filtering-Correlation-Id: 6039e5f3-d121-4d87-8c1e-08de6987fa9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b25VbjdvYVNRSWthMm9oY0dSOHZiZG90YUxqS1F2VG50OWtuaCswNE9uSVlp?=
 =?utf-8?B?WkFBbXRpMEZxSUF3c3NtOGJsVGVtWnFhd3J2TCtXc3Q4UW9OdjVYQTdsMVlv?=
 =?utf-8?B?RHVWVXZDR1pEVGxzYmM5cXkyOURhajcrL0x6ZTNMK1ZGSGNYaXZnTWRRWVgz?=
 =?utf-8?B?c1drRk4rYlNXbWZJR1NzS1FhSzNqdXVTYVJTUEhsZTZHaVJGbUI1b3p1MWdD?=
 =?utf-8?B?cUVOQU5XbnkyaXkvQW83SGN5YWFuQmRqblM1cEdtWmgwa2FxeGFYWThlQU1B?=
 =?utf-8?B?b2FHNHA5QlV3YUdDaHdkeHgxRHZPTjg1T0ZQWXFsMnBGa00yS0tubzFiblIv?=
 =?utf-8?B?NURxZzYrYitqUnNPRnhHc3lJSi9ic3V4V0lTK0c2b1FHWVRJS2w0bmNabURF?=
 =?utf-8?B?czg2UVhXRzBMeklqeEttOS9JUUw2b2hnWXcveUNTL0pGQ29NZE5vZTZlWFhw?=
 =?utf-8?B?dnRQV1lVRGRvZFFHQ3pPL09oaHlqeVRLN1dGK2g2WUlLUDBZTzBTTVIrR0lx?=
 =?utf-8?B?VDAwMnp6VmZNUkJEeUJvQlE3QWQ0NG1uWS94RnJ3SXFnWVc0ZzhBaVc1cVdV?=
 =?utf-8?B?dkhDQ0wxbEhoNnVDby9kSGQ3RWdRaHpQUFpvRGFBTVpLUkJ5akRsR2NpVXFp?=
 =?utf-8?B?cW1FTStObkE3OVBpN1VWUlU2Vm1OcHRlQUo1YnR2MldqbVhKNmFrY3l2STdT?=
 =?utf-8?B?aE9JenRpYWNGUjBtS0RCT2VodEtGSXZvUUpveS9BVVIvTDZTMGFhVUUvenUw?=
 =?utf-8?B?d0Z2bUk1TWhISFBJL0JxL0lvYUNNVlJ2aFE4cndIYTF2clc2MTJySC9idzVF?=
 =?utf-8?B?NjVCZ0dUMWNOK0FwRERpZCtxR0Jaa3RHNVY4SEE0VXhuV3ZoN3NtUEtIMG0r?=
 =?utf-8?B?a3FPV2Q0MVpHajhVRmZvSW04elgxc3JYTGRDQ08vKzFaOVpaUXI0V3ptekk1?=
 =?utf-8?B?U0JzMmt0bTZ5QTNsYmFLRlZiWFpSa2VYSWFiOHJmcGtScW9iWU5BK1o1VjN6?=
 =?utf-8?B?OVRpd3o1YWZaU0puaFQ2SlBtd2gzUlgxTmtOYlFyNk1NTysrVllRWGN5NlhI?=
 =?utf-8?B?ZmVuSStsUmdKbTNRTzZUTW9HbkZibUhTM0lVMElJT05tUmd0NEVqYUg4R2xW?=
 =?utf-8?B?a0c2aTc3VW1yT3gvdFdsbWRabWZuZG92V24vY3g1VUF1dGVnU3FiUlBleHd1?=
 =?utf-8?B?eTBCWGRHKzErUERiQ1JEUk1BWUZUdDAvRVpDTUhqTUJ1SkUvRnBVbUpCZVRS?=
 =?utf-8?B?R0tCam5YYmZpUHh1NEdMOVN0QkhMK1pZVGQ2MUhyTy9IUWo2ak01WkhFaUJZ?=
 =?utf-8?B?VTMwSUFWeU5vY2hBYTV3a2JYSlRMQ0VsaVE0QTdRNDBTQjh4dDhBR0ZoVm93?=
 =?utf-8?B?aHpuVmdjTk9aYUVrcUlsNFNhc3NDVElEdmtnY0EyRmVyTG5TbDFiQmpFakxk?=
 =?utf-8?B?c1BKVWxTV1JZem42YlcwQWU2c29iY2FoRy9jY1lGWElETFZUVlhDb0ZSRWdH?=
 =?utf-8?B?MWJFazVYL3J6U0FBY2hXSVNuNVY0bTVwUmFDWXBkWGFhN0ptQWRENnFiTHlJ?=
 =?utf-8?B?eEY0ejNzNzc2V0xNY09rVkUyZXZab3lQUFVkODJQVTgxNHVYZFRVZmg1ZnIr?=
 =?utf-8?B?eVh4M0YxYWVPVUpIT2RSOStBZ3NQY3pOUWFTdm9zV1AvTE1lYkFzdmUwRDEv?=
 =?utf-8?B?NWRoUzAxN05nNVpmZU0yNUpnQk1KWXdMdmhXSTVWWnA4TWpIcWQ3WEZMU0pl?=
 =?utf-8?B?MG9EVnBreSt1QU1KaUc1ZnBXK0l4b2gvMUk0Sm9EVlFQVWVLVjJpbkxxNEV3?=
 =?utf-8?B?V3MyOGxjT0NLck9FWEZNaE16bkRoVzd3dUN3eGczWDdSclhEWGZVYlp6Z2tD?=
 =?utf-8?B?aitDeTFyN3BaOEQrek1uNjVrNko3RnR4bkt3bUdjNGs3SitVSklnYldqaUE2?=
 =?utf-8?B?VXlEZkNlNU1OeUF2SFBNWWlIQmYvdDlYeFowNUlhNFBpV0czWTZyTGExMHhi?=
 =?utf-8?B?MU1VT1lrcEFEVk1MN0tyMjFPUTlCVWowc2s2Z2dOZ3cxdnYzOHk3QVJ4UzlP?=
 =?utf-8?Q?rqgfPt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(13003099007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmtzTXdEZUM4dWEraDFUTC94TmcyWml0ZmJRYkRVWVB5R1RwdXFHNGpydXUz?=
 =?utf-8?B?TEJMRDZoVWtMZzlBQTcrOC90eHlEaEYvS2VMSTFmU2ErSUcwaDFlTXlqbVdo?=
 =?utf-8?B?ZThLeGcwaTRpeGZiOEQzSlZrR0JIVXp3a2YvY1YwbXNrQzUvOUNvUHdleTls?=
 =?utf-8?B?dVNlUC9VQm5YUmxhSFJYemJFczg0Rm11R0Y3SFA0aFB1YnFwalB3WGMzOXZj?=
 =?utf-8?B?WGtzNDk4MnRyNWtFd2M3WllNOHZ1OXJXRVBxMGRsTEFvK28wQTh6Q2t5UUxJ?=
 =?utf-8?B?UGJ4S1ZXK3VxQzJDbzZVdDJiWXNTb29KWU5hM3MrM1JQN3JwdkM0TnQ4clR5?=
 =?utf-8?B?VVV2VmVxMThUSmExcjIxZ3Y1cXVmdC9NaGlra20vMUxaRGFKMTY1U1NmeitT?=
 =?utf-8?B?ZWw5YWZvTWluc0pwbU9EeHZQa3lsS0Fkc09MVnNZZ003Um5SQzhNUlhNd0Ft?=
 =?utf-8?B?RmlnUzJOZXdiZW5iaDVZYWdrV1hIMjhmL0hyeUU3VDVHRUpUeTNDUWlONnVD?=
 =?utf-8?B?ZnhLc2U5Z3RkMlBhREg3K1J1T3duMGw1S0JXZ25tZGlNQ20xQjlMQkJwSGtE?=
 =?utf-8?B?WWlyU3dlQVlyRFpDYm95WTFXdG8vTUtxbE9MWnB6QmR0a24vcU1QWGp2OVFR?=
 =?utf-8?B?YU9EUjZvVDRqdlcyRTJEa0dCZVlMY3VpOEpJWkdUVkVNNGdaNlVTMitOd1lF?=
 =?utf-8?B?UjVEclRWR1hUVFgzdStOQVVYTzJ6S0htYWYyT0tIc2ZMcXVKZCsrYkFzZmJz?=
 =?utf-8?B?UTZyVlo1V3Rsd1F2TDVlN2YxY1lpejlEeUxWVmVuS1dHVVhsNHgrM09raXlp?=
 =?utf-8?B?c1JJVmx6U2ZCamUwRzN6SmhQTzdhT3BESzVzWUQrTktkN3VWbHQ3VUY5aGIr?=
 =?utf-8?B?ekZQTWNraEk5TklFcFZJeDFyUXJNY1YwQytucy81QW9PMlRQSXM0Sms4dVl6?=
 =?utf-8?B?M0R3ZDQwTVNiY2w3SWdZUXFBYzluY01aUDNYZWsvczhkMndkcTB0aHI5aWtP?=
 =?utf-8?B?ZDR4UGJCVEw4UGxTS3FxQWdqaTVraVBtSVIzT040bjMxZTdvY2xZMjdvR05L?=
 =?utf-8?B?U0R6MFB0c0U2SDBhZEh4ejIyN2svcmhyeWR1QkI4L2NMeXFWSklpUUI3TURL?=
 =?utf-8?B?UEYwZGxIN3VaQ0gvNUwydTVNVGo0MEp1L2dTK05DSDdmNWlqN2Rva1NVOG5V?=
 =?utf-8?B?emEzeFE0Tnpjc2ZDeGVKQmlnNzJ1Z3VHN1RiNG1YbEJHaWY0VUFGQllPSmpq?=
 =?utf-8?B?ZVNhMWQwd0V6aDJTaHh2MkpwMWtydmhmOGxMaUxHWmYwc2c2aTMyRWFNZlNP?=
 =?utf-8?B?d2Q1TDlUYURoQVUzSUVwc3VDVjg4UiszdUJHemFteWNFKy9MQWs1MHYyWjI5?=
 =?utf-8?B?YTZqcmVUcldaRnlNQnJFTC9NSlFlaTNtd0JWeXlhK0h4QVNWM0V5cXg0UVBS?=
 =?utf-8?B?ZmRORHBLbTlrTWZ1Tm0rMEphd3NuS3lYQU5nbGJpaVZvMkV0am4zUFZvN3pP?=
 =?utf-8?B?NG9nMnFXQlBKNHBEWGxlbnZZRlR0cFhHNisvUnM4Y2hQSEhFQ0o2VGdIUGR4?=
 =?utf-8?B?UzlMdW0yNDhjd2M1MG5Vd2pDTmVNdmN4N3J0am5xZ1diWC90Zm05QVdoK0VD?=
 =?utf-8?B?ckdyY0pNUVdRQ3lOdVVkSE02NXdjZUdlVldNRlorWFpvTTE4cTRVQUozcjIx?=
 =?utf-8?B?ZzgzYW54LzFWNzU0djlTV2J0RDBqd2t4MUYvc2dsT0JuQ0ZVbUNmNEdRY0J5?=
 =?utf-8?B?MzI5S2g5RC9IK3VvcnNkcjhRTW9PQmx3b3pRcjZweUp0SVJlUW5Fak53TlhV?=
 =?utf-8?B?SWZDaTdPei9vaXJySjdObERaME9KRGpIZ3hXV2cxWFBXbVI0VjdYS1dJMng1?=
 =?utf-8?B?RnBpMXkySkxsMmxITG5jRGFvRDF6Q1NmVEFPWXEwOFF6Q0NqSE9OamxqejRR?=
 =?utf-8?B?dHR4aVBLRjFhNElNbHUxRTRRZGdoSnhadjRwcHVUSkNGaGlGK2xWMVRQM2JY?=
 =?utf-8?B?NEkzM1BOT1dGdkd6dEo0bklYZmFRKzE0YjJDSWxZRDhzTmZCMWl3QWJSeUpW?=
 =?utf-8?B?Zjc1cHR4SlJTcnFsUTI3cmg1NnhEaUN1SE0zcThhODFuYWRLUGtGZFNtZUxi?=
 =?utf-8?B?S3lxMytlN2JjY3c4cG9Va1BzTTIvZStMMC9KZVFWcUNHZk1pVjRDN2pIMEhQ?=
 =?utf-8?B?OXJQMnRZUW5HTmZCMXVuaklzYmxjNytVMkcydXpZYWJQdFN3T1NxUXd0bGNE?=
 =?utf-8?B?bzhpcnVXQTNObCtuRlNnRW44U0pkRlk5TldFV2VLUlZ2MlhncE5DdXFyVm5k?=
 =?utf-8?B?MkRLK3Q1eFM2NXdFTnUvRDdpUDVtZWxER0hWZUN2ck5VOWNZdzI4Mys0M3pu?=
 =?utf-8?Q?WnFSNkU7Fwh1UOvZA38D8Dh1bh4hrCYarxNnG?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6039e5f3-d121-4d87-8c1e-08de6987fa9b
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 16:09:48.0238 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ac2/siioxzH0YtDAqfNn9p/0CrXLWgncjFiozc3daTxc0maMlC1igNqErHAEYfbQbOu3ryUJRJr+0wZripNoqCW+HwvPFcWLX4ZM4yfJA10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7732
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

Hi Wojciech, Simon,

On 2/4/26 10:49 AM, Quentin Schulz wrote:
> Hi Wojciech,
> 
> On 2/3/26 9:17 AM, Wojciech Dubowik wrote:
>> On Tue, Jan 27, 2026 at 04:00:44PM +1300, Simon Glass wrote:
>> Hi Simon,
>>> Hi Quentin,
>>>
>>> On Tue, 27 Jan 2026 at 00:43, Quentin Schulz 
>>> <quentin.schulz@cherry.de> wrote:
>>>>
>>>> Hi Simon,
>>>>
>>>> On 1/22/26 11:46 PM, Simon Glass wrote:
>>>>> Hi,
>>>>>
>>>>> On Thu, 22 Jan 2026 at 02:06, Quentin Schulz 
>>>>> <quentin.schulz@cherry.de> wrote:
>>>>>>
>>>>>> Hi Wojciech,
>>>>>>
>>>>>> On 1/21/26 1:43 PM, Wojciech Dubowik wrote:
>>>>>>> On Tue, Jan 20, 2026 at 04:53:04PM +0100, Quentin Schulz wrote:
>>>>>>> Hello Quentin,
>>>>>>>> Hi Wojciech,
>>>>>>>>
>>>>>>>> On 1/20/26 9:12 AM, Wojciech Dubowik wrote:
>>>>>> [...]
>>>>>>>>> +        os.environ['SOFTHSM2_CONF'] = softhsm2_conf
>>>>>>>>
>>>>>>>> This is wrong, you'll be messing up with the environment of all 
>>>>>>>> tests being
>>>>>>>> run in the same thread. You must use the "with
>>>>>>>> unittest.mock.patch.dict('os.environ'," implementation I used in
>>>>>>>> testFitSignPKCS11Simple.
>>>>>>>
>>>>>>> Well, I have done so in my V2 but has been commented as wrong by the
>>>>>>> first reviewer. I will restore it back.
>>>>>>>
>>>>>>
>>>>>> Indeed, I see Simon asked you to do this in v2 and I missed it. It 
>>>>>> isn't
>>>>>> how we should be doing it.
>>>>>>
>>>>>> This is likely fine on its own because there's only one test that 
>>>>>> is now
>>>>>> modifying os.environ's SOFTHSM2_CONF but this will be a problem next
>>>>>> time a test wants to modify it. I actually hit this issue when
>>>>>> developing the PKCS11 fit signing tests as I had two tests 
>>>>>> modifying the
>>>>>> environment.
>>>>>>
>>>>>> The only trace of it left is the changelog in
>>>>>> https://eur02.safelinks.protection.outlook.com/? 
>>>>>> url=https%3A%2F%2Flore.kernel.org%2Fu-boot%2F20251121-binman- 
>>>>>> engine-v3-0- 
>>>>>> b80180aaa783%40cherry.de%2F&data=05%7C02%7Cquentin.schulz%40cherry.de%7C4be38001079e40572d5708de63d2c7a6%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C639057954135737078%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=B5%2Bx5iUO54EpovAyDBUCwuq5NgcfcejIoD6Unhdoa%2FM%3D&reserved=0
>>>>>>
>>>>>> """
>>>>>> - fixed issues due to modification of the environment in tests 
>>>>>> failing
>>>>>>      other tests, by using unittest.mock.patch.dict() on 
>>>>>> os.environ as
>>>>>>      suggested by the unittest.mock doc,
>>>>>> """
>>>>>>
>>>>>> and you can check the diff between the v2 and v3 to check I used to
>>>>>> modify the env directly but now mock it instead.
>>>>>>
>>>>>> Sorry for not catching this, should have answered to Simon in the v2.
>>>>>
>>>>> In practice we try to set values for various which are important, so
>>>>> future tests should explicitly delete the var if needed. But I am OK
>>>>
>>>> This is not working. See this very simple example (too lazy to use
>>>> threading.Lock so synchronization done via time.sleep instead):
>>>>
>>>> """
>>>> #!/usr/bin/env python3
>>>>
>>>> import os
>>>> import time
>>>> import threading
>>>>
>>>>
>>>> def thread_func(n):
>>>>       if n == 1:
>>>>           time.sleep(1)
>>>>       print(f'Thread {n} read environ var FOO={os.environ["FOO"]}')
>>>>       if n == 1:
>>>>           time.sleep(1)
>>>>       print(f'Thread {n} set environ var FOO to foo{n}')
>>>>       os.environ['FOO'] = f'foo{n}'
>>>>       if n == 0:
>>>>           time.sleep(5)
>>>>       print(f'Thread {n} read environ var FOO={os.environ["FOO"]}')
>>>>       if n == 0:
>>>>           print(f'Thread {n} removes environ var FOO')
>>>>           del os.environ["FOO"]
>>>>       else:
>>>>           time.sleep(10)
>>>>           print(f'Thread {n} read environ var 
>>>> FOO={os.environ.get("FOO")}')
>>>>
>>>>
>>>> threads = []
>>>>
>>>> os.environ["FOO"] = "foo"
>>>>
>>>> for i in range(0, 2):
>>>>       t = threading.Thread(target=thread_func, args=(i,))
>>>>       threads.append(t)
>>>>
>>>> for t in threads:
>>>>       t.start()
>>>>
>>>> for t in threads:
>>>>       t.join()
>>>>
>>>> """
>>>>
>>>> This results in:
>>>>
>>>> """
>>>> Thread 0 read environ var FOO=foo
>>>> Thread 0 set environ var FOO to foo0
>>>> Thread 1 read environ var FOO=foo0
>>>> Thread 1 set environ var FOO to foo1
>>>> Thread 1 read environ var FOO=foo1
>>>> Thread 0 read environ var FOO=foo1
>>>> Thread 0 removes environ var FOO
>>>> Thread 1 read environ var FOO=None
>>>> """
>>>>
>>>> You see that modification made to os.environ in a different thread
>>>> impacts the other threads. A test should definitely NOT modify anything
>>>> for another test, especially not when it's already running.
>>>>
>>>> So now, I implemented mocking instead (like in my tests for PKCS11 in
>>>> tools/binman/ftest.py) because I know it works.
>>>>
>>>> See:
>>>>
>>>> """
>>>> #!/usr/bin/env python3
>>>>
>>>> import os
>>>> import time
>>>> import threading
>>>> import unittest.mock
>>>>
>>>>
>>>> def thread_func(n):
>>>>       if n == 1:
>>>>           time.sleep(1)
>>>>       print(f'Thread {n} read environ var FOO={os.environ.get("FOO")}')
>>>>       if n == 1:
>>>>           time.sleep(1)
>>>>       with unittest.mock.patch.dict('os.environ',
>>>>                                     {'FOO': f'foo{n}'}):
>>>>           print(f'Thread {n} set environ var FOO to foo{n}')
>>>>           if n == 0:
>>>>               time.sleep(5)
>>>>           print(f'Thread {n} read mocked environ var
>>>> FOO={os.environ.get("FOO")}')
>>>>           if n == 1:
>>>>               time.sleep(6)
>>>>       print(f'Thread {n} read environ var FOO={os.environ.get("FOO")}')
>>>>
>>>>
>>>> threads = []
>>>>
>>>> for i in range(0, 2):
>>>>       t = threading.Thread(target=thread_func, args=(i,))
>>>>       threads.append(t)
>>>>
>>>> for t in threads:
>>>>       t.start()
>>>>
>>>> for t in threads:
>>>>       t.join()
>>>> """
>>>>
>>>> Lo and behold, it.... does NOT work???????
>>>>
>>>> I get:
>>>>
>>>> """
>>>> Thread 0 read environ var FOO=None
>>>> Thread 0 set environ var FOO to foo0
>>>> Thread 1 read environ var FOO=foo0
>>>> Thread 1 set environ var FOO to foo1
>>>> Thread 1 read mocked environ var FOO=foo1
>>>> Thread 0 read mocked environ var FOO=foo1
>>>> Thread 0 read environ var FOO=None
>>>> Thread 1 read environ var FOO=foo0
>>>> """
>>>>
>>>> I've read that os.environ isn't thread-safe, due to setenv() in glibc
>>>> not being thread-safe:
>>>> https://eur02.safelinks.protection.outlook.com/? 
>>>> url=https%3A%2F%2Fsourceware.org%2Fglibc%2Fmanual%2Flatest%2Fhtml_node%2FEnvironment-Access.html%23Environment-Access-1&data=05%7C02%7Cquentin.schulz%40cherry.de%7C4be38001079e40572d5708de63d2c7a6%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C639057954135756872%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=K5LZPB7BkLnUsLU%2BFFK4Bmp1vOXqF8WiSryObldGBAY%3D&reserved=0
>>>>
>>>> """
>>>> Modifications of environment variables are not allowed in multi- 
>>>> threaded
>>>> programs.
>>>> """
>>>>
>>>> I'm not sure if this applies to any other Python implementation than
>>>> CPython? But that is likely the one that most people are using.
>>>>
>>>> So... In short, I'm at a loss, no clue how to fix this (if it is even
>>>> fixable). The obvious answer is "spawn multiple processes instead of
>>>> multiple threads" but I can guarantee you, you don't want to be going

We are already doing this actually and this is what I was missing.

When using binman in parallel (the default when not passing -P1), we 
create a ConcurrentTestSuite whose make_tests function "pointer" 
parameter is fork_for_tests() from concurrencytest. What this does is 
collect all tests to run from all test suites, divide them equally to 
the number of processes then fork the main process that many times. 
Before forking, concurrencytest creates a pipe for communication between 
the child process and main process. The main process keeps track of all 
those pipes and generate a TestCase list (one per child process) that 
ConcurrentTestSuite then consumes. This will then create a thread per 
TestCase. This essentially means that:

- tests are run in different processes,
- but each process runs multiple tests sequentially (not in parallel, 
not in separate threads),
- threads are used to get the output of tests from a different process 
but that's just implementation details,

As such, we don't have to care about thread-safety as that is only used 
by concurrencytest for communication purposes.

However, this does mean that we absolutely need to clean up after 
ourselves. This is the reason why modifications to os.environ were 
breaking stuff in other tests for me, not because of thread-unsafe code, 
but because sequential tests inherit the dirty laundry from the previous 
test and I didn't clean things up properly. This explains why using 
unittest.mock.patch() actually fixed things up, because it's handled by 
the context manager anyway.

So we have the option of using either a contextmanager 
(unittest.mock.patch) for setting the environment and not having to care 
about cleaning it up afterwards. Or have the code snippet setting the 
environment and what uses it in a big try:finally which then cleans up 
before leaving the test.

I don't think propagating the env through Binman (see _DoBinman() which 
runs binman like a Python module thus inheriting the current 
environment) will make things easier or more readable, so please ignore 
the rest of the mail I answer to.

The TL;DR is: no thread-safety issue in tools/binman because we don't 
use threads. Use unittest.mock.patch contextmanager, or write to 
os.environ and undo it before exiting the test (and this needs to be 
done in a try:finally block to avoid exiting early).

Cheers,
Quentin
