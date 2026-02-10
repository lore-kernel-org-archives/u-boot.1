Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDEE7EE6B73
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 04:01:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C7438341A;
	Tue, 10 Feb 2026 05:01:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Fp3Gyz2P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9852983CB5; Tue, 10 Feb 2026 05:01:11 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 829168309A
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 05:01:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HBQeZPbM7DwHw468NhnCxHwU49xXsURWD3Tk2V2yRsEVP1rX5AnVRmfiGIa5MMxKWwxkh1p9VjLjSHQ2Oa9eyla0VyhDchEW43oZFzwFlj4UNThokxj0PC1kMbf93qIDqB7USR3p6Z3S3jH+6LLMXPPbhBMVXKof2Bz6RNptSZvUeicu596v9/8Xi6qSJ3fkE8LC4R018PmkmDrVloORdI9D2Y1tMLEUKxld8QqQEy7/8DbyGlPcwo8EI05cA0LxAYEn8HETAjxeRR3Ga988Dl3p5t0vOHbN2o5CT9qSmk8onPLzkXn7Wqsq3MTBcGD6R5vZj+eXcy/UQpM0KEKLdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ST0H49tVsJB3hHFRGu8vV5/brbax73XPTzygaO+Bcg=;
 b=qMV8lUmX3UcRbXGjXdWAP7wFyNT8XH1DTS+JeIQaP+EpmUJpuw7+x3rsZMPtqcz4iXm7Kte8d9UcZFsO0flMqzDR5+KIjA3c6rGLW4qHCN3IACYZFex8aihwX7WlwzWODw1YVKrHcsDWUw2QZDNXfCKM88KkkQYLSf+TkAIyRBTIqXbl2RoCYqmIptddixonznu0LCoMBB6UThfKC4604uAYqZnMtpV/ZjYUSrytUNyLP8Fe/6ExbjdasJB6GESX42B9pFcMOcEKQTZaj+rXy1uQXSh7nuhLyWsDdJ9SbyYkhhsQN0Gge9bsYPOAmwFusWOF9maecTzWAp6bQUPC8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ST0H49tVsJB3hHFRGu8vV5/brbax73XPTzygaO+Bcg=;
 b=Fp3Gyz2PlN3WM3JZ6P3OPzaDBibPEfdCfPXfWULkUaIWS4M6NGIJgCDNNZ4IFKAnNMTUKNNwqVgREeAMTywNhqqGhSDHwGP/MKdSQAqDAFpd0oSTdnVRmMj/1BH3YxyG6yRnHOssgLvXOlsjMnJ1pns+Xsb7gT7ar++0oWNDk5nvQZ7uOHLV3s2CNzprnte/q4bGtOoViZ364vDoowhvh0pTWuq7b26uJ0QyyzXw9YOIPdfDksbXZC4xtoIyPF1kc4v72O4P/fWeZT+NkptAgKiEM5mByTpbXRUCQYomu/15xpEF0DGHnH7wEFL/5fc72p3oh969xW1WE57peP7KNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by SA3PR03MB8349.namprd03.prod.outlook.com (2603:10b6:806:460::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 04:01:07 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9587.010; Tue, 10 Feb 2026
 04:01:07 +0000
Message-ID: <c7f23e3c-d445-4c3c-bd36-593c8a5e85fc@altera.com>
Date: Tue, 10 Feb 2026 12:00:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] socfpga: Remove incorrect CONFIG_SPL_LDSCRIPT settings
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Lim Siew Chin <elly.siew.chin.lim@intel.com>,
 Chin-Liang See <chin.liang.see@intel.com>,
 Dinh Nguyen <dinh.nguyen@intel.com>
References: <20260205221645.3749285-1-trini@konsulko.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20260205221645.3749285-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:195::17) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|SA3PR03MB8349:EE_
X-MS-Office365-Filtering-Correlation-Id: 39a5aa37-822f-4586-a063-08de6859045d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L1ZPMVZwM2NkVmh5cm01bXZaRGhISzdSR0FkMnNNeWpTRzE3b1JMTktBOTJG?=
 =?utf-8?B?ZDErcVNrMjNvVWhobFlhUmZ2UnBDVUVrQWdHR2lIRnkrZU53L1FvUFRUYndM?=
 =?utf-8?B?bDYwOGpRUU1hYlllcGt2Z0o4RkRwVXlHWFBHWjNvSFhwaUdpMzExYjJsb1Y2?=
 =?utf-8?B?MkVzbGp6enh4Yll6UDNDSXBzNnhkNXRoSVoxaHFDZmRiWUtrZW1SNnZNOGV2?=
 =?utf-8?B?cEhVdHJnc3o2eHc1ZkUwV3puQWpQb1RhM1pWOXZncktPV2ZZbkROVmpnTDV2?=
 =?utf-8?B?ZWxYS29vTDVJVHowcFVsWlNVUnE0S0F2RmV5d3FFeWpwZVJvbFE3ajIvTTU3?=
 =?utf-8?B?V3k4bEFVOFhEUHBHdkt3R0cvVHREcnVMS01lQ2pIR0k0K05BckhoUFVJLzhl?=
 =?utf-8?B?UHJzS280Y21CdHRDcld5Q3hlRngvV0xFV3RoSElEZGJWVTVZSGQxMFh2M3Zr?=
 =?utf-8?B?TjQ1aHBCUDFvb0ZoME5qMUEyOHcrdzhCWlFxZ2RkWlB1bFZHdWwwOFRzUUpM?=
 =?utf-8?B?YXE5M1pMY0JBbjkwY1pTS0Vnb3JrSnJGRG96Q2lPR2Y3VWZZcGkxakxwUVo2?=
 =?utf-8?B?YnhwN1Y0bW1JSzlYUHJyRWdrYXA5cmlZUUQ3bGFIL3cxVjF5Nm41UExBNmNm?=
 =?utf-8?B?Uk9Sc01qb2E0UUEzL3dpbWlEbFp3VUxHUXpaOEZ2VXBXSmtnOUVCNVRtV29I?=
 =?utf-8?B?TGNvOFdLUU1aQ1RwTVRLVkdzQzYzNmRaeDRscEpNQjNPTkcreDIvb0I4VWgx?=
 =?utf-8?B?R3NENDV1SU5xME5MVHM2ZWpjdE50TkVwaitEa2JJS1B4WFJUTm9KUDVVY1k5?=
 =?utf-8?B?UU01RG5ZUkEySWVDcFhsSnlLMGRQaWkwMHhhOHZUc05HTEdsSkJaN000MWxz?=
 =?utf-8?B?SVNSRC9URHhyZldhSThVcGlRVVhlRVRNeWZEZFlkM2ovaDA3aDRUcENVS0VX?=
 =?utf-8?B?YTlkOGJ0QUduLzJIUThjTUlmOTJDaXN3UElyYU44TkVpaFBKUVh4d0c2VnQ4?=
 =?utf-8?B?M0puVGp1SWlOaGNoWVZtSTRiaDg1amxUM0RLKzRzZVJyY1doSk9yOUUzTU1N?=
 =?utf-8?B?K3hTUS9yQ1J2eEFlVWpldk9kNVN2eDdqQUcvZUt4dlRFZW9ZcU9oMnAxV2NG?=
 =?utf-8?B?VnZ2Uy9ZalFsdXJ6ZGNpQVg5QWlKUnRYRHJack5ZRStHRVN5YUFhNk9DbUZ1?=
 =?utf-8?B?cmlsTEFxVS9QRElTejB4dmFoSXZUVWRBT1hDZ0dIOWc2UHdOUDErWkRKdmZp?=
 =?utf-8?B?T2ViQk84blFjYmpDbnFOQnByRTZmYzZnU29uQmxBcThBRFNKb1dhLzZoYkRG?=
 =?utf-8?B?RjAzNE9sZ015aFBRUWlkaWF5VzRiV2dMVDk4QW1ZWW02MUkzbHR3bTNZWEdM?=
 =?utf-8?B?VVlZdElNYXRuYXF2TzBXbzVONTRRdEo1cGZJU0drL2luSS93d3lES0dHUm9Q?=
 =?utf-8?B?a3l0ZzJVL3JONGVjQWU4TW0rdEpqLzN3UVVuVG43M1FjTXQ0V0NWaEhYbm5V?=
 =?utf-8?B?eVR2MEdaNHdENUk0N3g2OXphNVN1SDZKTTh0SUNJSitHZlo0UzhPdkxyUnlv?=
 =?utf-8?B?Rmh3TWNRNVpjNVVIRXhyWEdrUm1uZzF3aWIrbklLLy9XTlpaWlJXYk03Y2R5?=
 =?utf-8?B?b3J6SGZaMFA0OTR4VUg3Y01waVhENzV2dXU3Q2E2d0lpVm1tS3plL0pMM1pV?=
 =?utf-8?B?WDQvSi93UEx6V3ZuUXROdjVPTUxPdWFNVWVaZm5BZzVuOCswc3BQNjh3OGJr?=
 =?utf-8?B?YkM3Ym1HVHBxZzkxQm50RnBCUkRibHN6bFBuenN6YXlMbVh0MlpURUFEQURV?=
 =?utf-8?B?NXk4UGlaVmkzUVgvWXFsSG1IZ01OWEEyOTMxVyt5NlBERG5ZbkEyVVVJcFNi?=
 =?utf-8?B?TGVZWGQ2bjloQVJZU2tmNWdFZkRuL0JYZnkyL0V4b3RFbUI0a0RtZTJOZEZu?=
 =?utf-8?B?bGRyR0xJenZIdXBaRGZoRjhER012RVcwWDdReEJONWZUWUQyS3duSHRSc1ZI?=
 =?utf-8?B?UDJqQXBoMGZOSDBLcHEzMjZFOFI2SVZ5MmdOa3NtcGdZZVcvRjRmeXpLTis1?=
 =?utf-8?B?RE9qeDRiZUw2eGo5YkFabHppcVZjNUF5VlB2K1dBbWRpRlA0eVVZOGs3dmZo?=
 =?utf-8?Q?ZBuo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckg4ZDFtcUNjRU03ejhGcTl4N1EyVzkvUWxpNEdOcUprc3JsUlZCdHlKZkRL?=
 =?utf-8?B?NDZkODYxdnE2MzRkeVZVVEpITFc1WWllYkRHazFjYzlxejJRSUUxWTdja1ZC?=
 =?utf-8?B?NXhWRk1BOElaWWd3SlZiRnEwdVB2MWdaRHBVYnRUUmF0c2tUMVdZRXJiS2pD?=
 =?utf-8?B?Sm9YbTNBWndOOHAwbjFDeTErM0hESWZ4NmZKd2h0amRIM2pKSFhoU1lRa282?=
 =?utf-8?B?RWdycXE2WkYxUzJkL1R2WlhQLzA5SXBNcHIrdmpXSm93a0ZkcGpuNFpLKzNm?=
 =?utf-8?B?eGNjVU9aNDdyclE1ZTlaZzZhS3lrVTloM1ZUYjFXMWJnMnBqZ0F3YVdIN2Uz?=
 =?utf-8?B?aDNId0IxSWRxNzhBYnYxb2hWUVlqM3FuQjJQWEZlUjkyc29vYlY3bzdKZDBs?=
 =?utf-8?B?SU9XclMwK0VmU3RtdG1hM3NZOG53UFdjK0V5bXYyZ1FubVN2RlFjbERUamFC?=
 =?utf-8?B?NmJWNkxOa1gxd0NYRzRpMW5zUG5tcVgzVzRzcU9VSlg4cWQ1SUZDZHVpblBv?=
 =?utf-8?B?VUxXZml1bnQ0eHMxVmdVQkZVYzBlc1JDNUttYWN3SlJUQ29CSW5oQjduZEpw?=
 =?utf-8?B?NlY0SHlWZ1Q1VTJ0VWpHS0p4ZWs1UENFc3JpR284cFhnWHdtd204OXIxY3lD?=
 =?utf-8?B?aGlIZGhCb2REMzJlM0JTUjcvTkc3eG9lRUtMbXZ5a0x2SkYxNHNOQS9ZUzRx?=
 =?utf-8?B?M0RlZ2lhUkZ4SVY2UVFZTlFGbmthazltTG5hMWYwQTFDRmF1Ny82VWdDRnVO?=
 =?utf-8?B?R25BNjdmVlRGenVvY0xnbHpxL292eFU0ZEp6NXBpYUREMDBYVG94QURyZHg2?=
 =?utf-8?B?SEIrOFR5cE5wekhkbzhvZzJnSkliSGRBRElxNFc3Rys4cFk3NkdwSEFacE9H?=
 =?utf-8?B?TklQcEJ3V3dZNUJ6bGRSbGxtQU1kMWZHMWNlZnFlSWVYZXBualFhcnU5TVhk?=
 =?utf-8?B?SThHak9NYy8yYW41TnFWRHV2QVVIMXV3ejUwL2V5bFBSRzhMVjg4aVBCSGw2?=
 =?utf-8?B?Y3c1M1g3SWV4d1BxSDV4dWtQUVVsRVhxYWlEOTNaelFPNlppWVNCS1NuMUN6?=
 =?utf-8?B?aGlvcDNoQ00ydG0yVXl3Uk1aT0NWY0xhTHF0YzVhaVdlN2YxWFRXZFNuYUxI?=
 =?utf-8?B?Szd2cjhoQ0pUa3lzTjBZblRwUmJmemZuK01SNWZOc2Q1VktKUHZkOXJ6T3Rz?=
 =?utf-8?B?YlBFY1pSNmx2KzlWb0NxK2FyTHJWSHpoeUd5S1dBYjdrRS93NXVEMmUrMk5B?=
 =?utf-8?B?TEtpdEN6bGpZY09ESVhNUVpZTS9Yb1B6M3RsL0t6c0tuczllNEw2cFJvMGVv?=
 =?utf-8?B?U0dnM09oKzhzeHE1cUtBd1ZSN1hZWGNRMEhOaVNtMW5kZmE0cWtYb0NUeUJZ?=
 =?utf-8?B?eXBGbWJNZitXWHU1L3RRcEtxUlQyNm1UNDJWcWNUc3p5U1BGckdzOGxYb2Zz?=
 =?utf-8?B?S01nRU9kZ3I3WUk3Nk1KNk83Ynk4SFk2dm5qL0J2SjY0MHh2QlA0VU5MYmR6?=
 =?utf-8?B?Y29mTi9LNWlVVWI3VFkyZkMwTnVjT3RXRlFQOUlvN3lvMlBTMHRXbDRDRWRP?=
 =?utf-8?B?enRoRVJBMTJsbWVrN3l6WW91UUFHcHE1c1ZyUnl2S1NKTit3TS9waE5FSWFl?=
 =?utf-8?B?ZmEzOHJBYjIvYWZWOFVaT3pxbVNocWJsRzRLN0FCYXEzRWNoUUZ6RS9aS2Jz?=
 =?utf-8?B?OW1PcTJDU3VaalF1aEUyckk2MW04Z05BODhmbTg1a1pPWEdaS1o0VVBXZWx0?=
 =?utf-8?B?SklueW50SXl0bENXaG9HeElqVHZUc01YVVRKSUZuMkU3a3VVL1JwcEZ2VzNl?=
 =?utf-8?B?VFdwMFNOWUFlSVN0TldhR3d0VVBmeEhyczRZNWRtdml2UFpGWW92YUk5SHNi?=
 =?utf-8?B?R1ZjRlkwcE0xSFhQcDRiYmlFMHkza3JkMWs3WW9DOFdyd21EV3hyd3h4UXRX?=
 =?utf-8?B?Y0ZJRHFrRzluMHZaNnVzN29RbUd5bys2T3V0VnFzL3g4LzN3UHBaM1IxaFZF?=
 =?utf-8?B?R1M4c2xwTUVtcGN2M01xNEdWMzA5VkNlK0tacXR6Si9CcDVLc2QvNklXZ3pU?=
 =?utf-8?B?eHh6NEdyZGVBK1Q2VzFEUDdPYktuVENxRVFBVi9WbFJWWDlmM2w0cXcvNStL?=
 =?utf-8?B?dmpkWHdxcVNXWm4rQ2lNRUVQQUVNRlpkQkUwRFVDK3cxYXRZVW9RQlJZVith?=
 =?utf-8?B?ak01WkJHK2lBMTJTaDVVeG9lZkRWZjlSaURGMWgrYmY2bkx3dTlyV3dZbUVL?=
 =?utf-8?B?ZFZ1dkhMeTVydnhmRmh5VlN5UGtHSEM4alJ6MUVYTU4rdlRFd0lRc0FRMWNB?=
 =?utf-8?B?K3hlUE8raGt5V3p6YmJlNHZ2S3RNblQvRThuV3BnNXJFMU1velh3UE9ITTlv?=
 =?utf-8?Q?YveZX7eBd4HdIdKo=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a5aa37-822f-4586-a063-08de6859045d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 04:01:07.1030 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YemsxAks0rs0JXlbMVy7wzol5tf02y6nbNkXw55SqxU2H99njHo0kBHo2PCBQSxZgNajw5KVC5bMQh8oFxfeg7hRcgd2D+6pb8TWXiNQZO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB8349
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


On 6/2/2026 6:16 am, Tom Rini wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>
> These platforms set CONFIG_SPL_LDSCRIPT to a file that doesn't exist,
> and in turn were using the default of arch/arm/cpu/armv8/u-boot-spl.lds
> instead.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Marek Vasut <marex@denx.de>
> Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
> Cc: Tien Fong Chee <tien.fong.chee@altera.com>
> Cc: Lim Siew Chin <elly.siew.chin.lim@intel.com>
> Cc: Chin-Liang See <chin.liang.see@intel.com>
> Cc: Dinh Nguyen <dinh.nguyen@intel.com>
> ---
>   configs/socfpga_agilex7m_defconfig      | 1 -
>   configs/socfpga_n5x_atf_defconfig       | 1 -
>   configs/socfpga_n5x_vab_defconfig       | 1 -
>   configs/socfpga_stratix10_atf_defconfig | 1 -
>   4 files changed, 4 deletions(-)
>
> diff --git a/configs/socfpga_agilex7m_defconfig b/configs/socfpga_agilex7m_defconfig
> index 0a8c58234b95..d3ecca436efd 100644
> --- a/configs/socfpga_agilex7m_defconfig
> +++ b/configs/socfpga_agilex7m_defconfig
> @@ -1,7 +1,6 @@
>   #include <configs/socfpga_agilex_defconfig>
>
>   CONFIG_NR_DRAM_BANKS=1
> -CONFIG_SPL_LDSCRIPT="arch/arm/mach-socfpga/u-boot-spl-soc64.lds"
>   # CONFIG_TARGET_SOCFPGA_AGILEX_SOCDK is not set
>   # CONFIG_IDENT_STRING is not set
>   CONFIG_SPL_BSS_START_ADDR=0x1ff00000
> diff --git a/configs/socfpga_n5x_atf_defconfig b/configs/socfpga_n5x_atf_defconfig
> index 1ef20ba97a84..bb8f1eb7264e 100644
> --- a/configs/socfpga_n5x_atf_defconfig
> +++ b/configs/socfpga_n5x_atf_defconfig
> @@ -4,7 +4,6 @@ CONFIG_ARCH_SOCFPGA=y
>   CONFIG_TEXT_BASE=0x200000
>   CONFIG_SYS_MALLOC_LEN=0x500000
>   CONFIG_NR_DRAM_BANKS=2
> -CONFIG_SPL_LDSCRIPT="arch/arm/mach-socfpga/u-boot-spl-soc64.lds"
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
>   CONFIG_SF_DEFAULT_MODE=0x2003
> diff --git a/configs/socfpga_n5x_vab_defconfig b/configs/socfpga_n5x_vab_defconfig
> index a4798e2f953d..78fe42e107c7 100644
> --- a/configs/socfpga_n5x_vab_defconfig
> +++ b/configs/socfpga_n5x_vab_defconfig
> @@ -4,7 +4,6 @@ CONFIG_ARCH_SOCFPGA=y
>   CONFIG_TEXT_BASE=0x200000
>   CONFIG_SYS_MALLOC_LEN=0x500000
>   CONFIG_NR_DRAM_BANKS=2
> -CONFIG_SPL_LDSCRIPT="arch/arm/mach-socfpga/u-boot-spl-soc64.lds"
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
>   CONFIG_SF_DEFAULT_MODE=0x2003
> diff --git a/configs/socfpga_stratix10_atf_defconfig b/configs/socfpga_stratix10_atf_defconfig
> index 63ea467baefe..206343885d96 100644
> --- a/configs/socfpga_stratix10_atf_defconfig
> +++ b/configs/socfpga_stratix10_atf_defconfig
> @@ -4,7 +4,6 @@ CONFIG_ARCH_SOCFPGA=y
>   CONFIG_TEXT_BASE=0x200000
>   CONFIG_SYS_MALLOC_LEN=0x500000
>   CONFIG_NR_DRAM_BANKS=2
> -CONFIG_SPL_LDSCRIPT="arch/arm/mach-socfpga/u-boot-spl-soc64.lds"
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
>   CONFIG_SF_DEFAULT_MODE=0x2003
> --
> 2.43.0


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

