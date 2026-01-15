Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B7AD4114E
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 09:40:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D5CE80325;
	Thu, 15 Jan 2026 10:40:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="S0mJ4hpw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6111183655; Thu, 15 Jan 2026 10:40:10 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 602E880077
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 10:40:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pE3Sz+wmGeb0ZX+ERzd/kMFHEJPv6Kybx0cLOIi2NtJjP4Q0pokZ3EpJbTFD5TzIAZBPuRQB+yqyce9tygcGmiUlfpIFTV257DNnfF0FPGoCpLcGyxtsiONHcDdZkse5YG0WNu3cFSLkuJxnzPtcUF46kVglVnDE+/pecV7bL4bCFP0othZzC/89nKotFCYSErVsUABES8ZzBq8wchtQ0S8GXl39wlOpp0GQf5hpVa7t/CpJp0XKDGvKsHn6Sc9E4R8aIhcmXC5l2xsnUpBhTVlpymV5pNDos1nNOMAcmSqKDPI16+SVEDwDdZSvYKteo4+X/Vo7rosBCmq8DSNYTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIgev+ujEOjmtLO9cP/yUFfiAbgIyaQYyPisbZBuN/w=;
 b=iWFKhiMRzzvxSi4bZxV8SP47Sc04l4p+qnsBb8iioVRluGsq0b9T0VFYzPAM6m5a1+nGxJM3DKyvmoSjDH/OZbgFP3Ao6PTmyEilNmkizIdY1zAW+L7LPYP/e3EnUTCNrBbEmTEN5mb7J34QeA3H0jKw50BaKxf8VfypcQJw5TZk2VGdHtCg0P7BL0gIOWtDeJY7Qs2dw8t7BmcgMT2qRtaaZwTN4L5ee8so5wbmORH7AGSfC/CkKIo6icp/5x+amT9EGj5iq1LuSQtm7TelKLNgXwbQnvC9P17hWl0cuBo38BkEMEJLIdgM/9aRurLg0chTtN3qRwf86dmFbMDzqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIgev+ujEOjmtLO9cP/yUFfiAbgIyaQYyPisbZBuN/w=;
 b=S0mJ4hpws956HAd1LXNzQWdgqYs3oNXJGzr6UhhK1Q2F2FxVWEMFV/aILCfU7ki9Yn5vQf1QswDqQzfT1lNxMjktXcJRaejEzGXIFe2kIcRF67tlKO2hdZcXSOTIjVuHUCwnIkewgL3e5EgsYLSFqlfgKcJe+uxO7T1KPgiHFdxuYE7FDq4WTxG+iSXeC+PqSOrRXN79FDE59DSmCGZL8N5ue0vHYi6/bxjcBmZPpp8oJrMy7dr7kqKBZ1tR1lSb4fpvS6uKgAtiZ+0A7BqChTOs3webM7NNdN3+U3CmPotgbY9TiB2QZk66yBorhtGtFcUwS6HsS82NEdO/yxhoqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by LV3PR03MB7588.namprd03.prod.outlook.com (2603:10b6:408:282::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 09:40:04 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%5]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 09:40:04 +0000
Message-ID: <01992946-b7df-4a0c-bb62-4658caadabcc@altera.com>
Date: Thu, 15 Jan 2026 15:09:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Revert "mmc: mmc-uclass: Use max-frequency from device
 tree with default handling"
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 marex@denx.de, tien.fong.chee@altera.com, festevam@gmail.com,
 ivitro@gmail.com, max.merchel@ew.tq-group.com
References: <20260108114002.1612-1-tanmay.kathpalia@altera.com>
 <f6ebd731-cc2c-47b1-98d4-961abd40ef85@mailbox.org>
Content-Language: en-US
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
In-Reply-To: <f6ebd731-cc2c-47b1-98d4-961abd40ef85@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0137.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d5::17) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|LV3PR03MB7588:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a667d4b-8625-4ca2-2d61-08de541a0f5b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S0tLTENJM2Q3RDBOSWROaEoxM3I3ajlVbE5tZGY5bTVYbXJpTVlXYUFpT1Iz?=
 =?utf-8?B?VWdZK2ljTVpVanRQa21GQVNCOGQza05tT2F6emc2TUhIVG5SdmNwRm5HM2lX?=
 =?utf-8?B?dWNZOUhSZHo1WGYyd1pjaWJRZmhEbVE1TFVtdjBsRFNjZHRVMVNkcnhrOE5T?=
 =?utf-8?B?SlpMZ0I3UTUvVnEwdlFvcGhFcWxDcFJsRWhFek1XKzhkdWwrWTVydjR2TWJO?=
 =?utf-8?B?dWtmZFhTQUlaL0Y4cS82UHgwaHJWR3IxZDVKdXBrNzlBZ3JMamkrb1JrVkF2?=
 =?utf-8?B?V0QvUFRlRkNIZ0RiTHlscWNsaFVZMzliMEZXQkxlRXdPMlhZMlAxWDlON1Vy?=
 =?utf-8?B?VEtycGpZdE1VOFljY3NHQ0ZkR09rb2J6K2R6SmF2N1RpTGFzUjd2ZFd2TXd1?=
 =?utf-8?B?ZTE3ajRXVUZlOUw0cnd2N2IxRWJRSFpCSTV3UytodkQ0azg5UXRpaGsxSEFz?=
 =?utf-8?B?RUxORE00MmtlVkcyOHIvWDR5blVLMEtLSG43TjE1OEpUQnRJMmhQVUVlaGky?=
 =?utf-8?B?UUdiY1pFTll6d0Rqd1RuYkxJU2o3SC8xM1BWSkh2TnFEUmlYZTc5T1NKcEhn?=
 =?utf-8?B?VW0yME9QY0xVNVNudEpsWlFHRzJrczR5ajBSekR0bk5xVlRNaTlrWVhGN3Za?=
 =?utf-8?B?MFNpWmMrNzNtdmN1MjJna1kzcGo4d0pJcUNqdW1vdnB1eVlYNFlHMHptZWd3?=
 =?utf-8?B?VXI4cW4zZ1kyVW05L0hqZ1V4dXgvMFZLQmZ2ZWpHNVd5ZG83ZmI0REVBK25m?=
 =?utf-8?B?VVh6ZktoaXRKWVl2SU0rbjdqalhGN1JvS3QzTWlTcWlFNU5TaGN2cUxraWdW?=
 =?utf-8?B?eFEreThTWHJwMDlyWVRkQ0ZzWWdtSzJiTHpMN2kvWG5LT0VBenVmSEluLzRU?=
 =?utf-8?B?NXMxQ2I0MzFTemxNQVlqT2k2TDd4ckQ5WmY3VGxwTjNScTRHUlk4OGZ5MVFO?=
 =?utf-8?B?MXI5UlN4elFlWjFwVU1nVDRZQXc4TUJsSU4xTFdsMmNOWTNNdjQrQThvU0d3?=
 =?utf-8?B?L0Q3cTlLbjhjeWZpTTdPRXZjSkloN1B1SW1qSnA0R3Q0bGFsNDJpbFp1SFdu?=
 =?utf-8?B?c0laRzRCNjhzSlpob00yK1N6eDZuOE8ydnJUbnd1MG9hRzFCRlllWVIrcWVV?=
 =?utf-8?B?QXlwL29TWENuUzZBV05ZbzVaUHdPcER4WU1SUE1yL0FWblBFRWVIdEc5cXpH?=
 =?utf-8?B?c2hRNXE4bGlHejVDWjZxV3llNzN3Y242NEtHU3BseENBbVR3UFRlY2VBQ3dN?=
 =?utf-8?B?TFBDV1g0ZnhjUTBWL3AwYS85R1BETkNPVXhEdTJWckdYaTA3N3ErYWlPblpm?=
 =?utf-8?B?aTRWTUMrZTF6VU56eExyV3JNUjV4VUVXSWltZENwRThZWjM3RnVsNUZwQThP?=
 =?utf-8?B?bzhTUmsxYjJoblZmSGVtck00aE5ldURSVVhxQTZ1TGZPUEZuY1ozanNVTVdl?=
 =?utf-8?B?cFNUcXRZVXlHZTRxOTIzZ1U1VTBvZ1JTQzAra3V0Y1ZDczB5MytXZ3BpVlht?=
 =?utf-8?B?M1B2ci83dnhxQTE1anM3L2l2KzFXR1AxLzNTMHJTbG54dXM3d2xDbUNKN1NB?=
 =?utf-8?B?NlM5eXpncitJOUdJTklpY1g4ZkRxdWwxbGNWWUhvNUtRZUlOSDYrY2ltTTJF?=
 =?utf-8?B?c3pUY2NDUi8zU2xqVC9MVms3aUFxcHJZZXA3RS9nT3U5dTVRdWt4SS93WHht?=
 =?utf-8?B?T2ZRZjlRanVmYXFlSE5RVnpZT1lubm9Eb0ZKTXNPTWdGeHNlU1hvaDdISHFZ?=
 =?utf-8?B?elNaRlROc0Q1K1h2RWppbm0wOVlFTEZCcnhSaVVpN1lBUCtPTU50ZkNwWVVm?=
 =?utf-8?B?UVl5cjhobjA1ano2QkhsTUJING44MnBXS3dRdXQxVlRjOThaQVFLc2poenZ5?=
 =?utf-8?B?WkE5THd5T1FRTDdhVU9NMzJyUnd5N1JsZkNjb294VjJvaENndkhXSWZIcVBa?=
 =?utf-8?B?RlczaXYyQWpWWUJNNGpHcjVIcTRJZXV1TXZqM0pTV2QrcUg3QzNBek9uZ3JS?=
 =?utf-8?B?VjkvbitFd3Q2R2JZRjVxaDZRYk9NcHlDeTcrSktMa1NoRmNwbVFpZ0cwZ1dL?=
 =?utf-8?B?cDRCeTVNMGpXQ0NsVDZkbTJVMStOUmdvZkUzcko5WXJqTDB3NUVxOGg5QU44?=
 =?utf-8?Q?xxW0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkk0MVF6SVdtZ05TVzgzeEFmTjN1RmpSTWtoank5eUxSWkN2Qmc5QkQ2cEFC?=
 =?utf-8?B?Ui93dVZlWW5oZ2JrL3g3bU9Gd0dteTA3YTdFdTRXMnVlRUZtVzNGcG8zbzhL?=
 =?utf-8?B?cnJhVHdQZGhFVXdCOHhHT2JIcXBGOU9VZ0xYSXV2by9FeXJtUmVxcDlkRXlV?=
 =?utf-8?B?T3JYUVpTaVNzNVdQVjV6ZGtZdUlRWWtibmlEZ2lyTzFxMng1VS9QZi9DYldL?=
 =?utf-8?B?MmlZaXFBZnpWYXlXZlRISVdoL3pudzc5RWtUVVdwR21BK0x6Q2hmUzVTRDRB?=
 =?utf-8?B?SmRaZWlvdXM0MGFrS2NZSlhrWkNIZHVSS3N4Szc1R3ZVMmpadmhMV1BMNmQw?=
 =?utf-8?B?VnU2eFBleGZtamNTOGlMK240MkxGTVJTV3NjeUpuRlQ3UnJoenZvL3orakVU?=
 =?utf-8?B?WnpsL243cGJiM014ZkZhRlp3QWQxVEZXc0lWRDljVmhSd2gyUFFFS3ZZSXds?=
 =?utf-8?B?TnZtOHVuM25Sbzd0R2c2N0ZuQ0tONUN6SXNscDZsMnUzZGtyNkhDSnA1eU85?=
 =?utf-8?B?Z1Y5T3F4Ymx4bVR1dzJCOG80MU0vTHBHMlR2YUx6WHhuaVlSYUFDanJoc3hF?=
 =?utf-8?B?d2dLME84MUtlbE9vc21BdWlFT1lvNnNCM0d4Q2lKeXJVMkhIZ25hL1Z6dm9D?=
 =?utf-8?B?N2M2SjNvZW1rYnRoVmYrSkZjMEN4MzZDYTJBUk8vbnpINTRLRUVrQTYycGlm?=
 =?utf-8?B?WURWS2cxMTVNOEZpTDhpM04vZGFKTTZKOEpVR3FvSDhuci91a0I2SDl5cmRC?=
 =?utf-8?B?Q3dMQmxjYURiVGkzOGNwNHVUdmdaZXF2bHhxSE5mSFdSN0pyMXBMQlNlWUMr?=
 =?utf-8?B?K095MW9XZS94K3pHZzRGVVJpMDlScHJjWjY1TFpNckZleCsrbzZqeGtEZzg4?=
 =?utf-8?B?ZUNvUzBRbWVaKzhFWWFzM0JuVXl3QUFSOGkwMzhYQ2w0Q2c5RzYzUnlvNWQ2?=
 =?utf-8?B?OTQxUWw5Q3M3ak5jd0R0ZEMrMTkvVXRWcEh4YmFRSWEyTGJoZjc0OHk1Mk9W?=
 =?utf-8?B?cXlqUTQ5OGsydHdHdWhRdkthalZMWkhXN0FOaFk5Q1RLeFZMcmF4cXFjNEJo?=
 =?utf-8?B?VU4wQUFkTkZ0SitzOU8ySTJxZm93WUVDZFBZSnVRUTZTdVVUVG9qa3g5SU56?=
 =?utf-8?B?RWVjMDI2Tm0xaDk0ODJOc283ZWlkVllBUitkV1FnNjdPeklZNTQrcWFTVUJx?=
 =?utf-8?B?OFdONU1qS0grNkxmcmFxNEx6c1V3ZDZWblZqd2NsQzJzQ1A1Q25KVHU2c1JS?=
 =?utf-8?B?dmMvcExCTFpzdmRzbXhBVGNLZ1hXUWh0ZVpwWlRyMytibmVPTnp1NEY1VGJh?=
 =?utf-8?B?S1ZWMTVCQllRVnM1WFkrUFBQZ1JsRzZZSU5sN2s3dUR5WFNtYVB1R2pXM0sv?=
 =?utf-8?B?cGRObytZakd2NytMUzBnZUlyMWozZmxlVytRRy80V3NYY2pJMGdFYW05MEdj?=
 =?utf-8?B?eHBYQzZXZ1IybEtYTlRQWEoxSUhqbHFTNTJ2OFNUazFQSEZKNFhXb2N6UkYy?=
 =?utf-8?B?ZS9LVElUMisvdkRXQ3V2SWN5Nzh5bWdEQkhPQTVNd0tqZmVqeTVYOGxSQjBQ?=
 =?utf-8?B?enFFQjZSRUgvZ2hoSm9idUYwRU8rcDBZMGUvTll2Q1R0WExMV0ZLVHYxMUtY?=
 =?utf-8?B?WFltV3EvOCtsdXJORTBEUG9PZ3l1TW5ncHdhMVJEcDlMWWRZOXBrTzhCRDVP?=
 =?utf-8?B?Vjk2TVp5Nlg4WWthRWFuS013dGV1c0RCZ21kSWlQc3lja054RXBVR3h3V05a?=
 =?utf-8?B?MWpKa1BQSk5sYzB0dlRoRmJtaE5EK3VTRE9CRDhvQXZERFh2SFZPQ0tqZWRz?=
 =?utf-8?B?emFvZk5XZWhWN0dOMzlVMkcyOUNNN0pPdGFpVU40a0tBUUtIQmhHYm5mbXNq?=
 =?utf-8?B?c3FoSVZvWU5kZlh0WUNKN2JLYmRuZWZRWTduR1VGMDd1bWZWaGVPeURCYmxz?=
 =?utf-8?B?ZC8yb3R0L0svdFVIN3hNQnlnMGIrOHR0TklrMU5aWU8yMTA3OElSSEdwN3ho?=
 =?utf-8?B?YUlXUUNtVVhnaFFTUXo4ZzFvNTRmWUg5Yis0MHV3emJrVUFocHpVbDllWWJ5?=
 =?utf-8?B?Z0V0NmJEV2RBeElza0ZIb1RMSGdsWk9iMW9VTWc3WjMxbGlVZzREV1BWcm5p?=
 =?utf-8?B?azhPUy84M1ZBbXFKR3IrMTlvL05BUUs2U01TYzB1N2tKTFlVS0pLTUtGNUVM?=
 =?utf-8?B?V2RmajhFdlNlQmh6RCtlMldmR0ZtdGkrckc4Q0s5T1FsZzFvWUJiN0dtNXZ2?=
 =?utf-8?B?dE5Ra0xWdFFvOHQxRmFWV1VDaWhybmNQeHFOemFnSUlxQUNNdHYxNjhURHAv?=
 =?utf-8?B?NENwR1d2S3czQ0Z2NE1RRzhDY1Y5dEFWWHVZUk80M2dDejAyMmdxTUh0WWM2?=
 =?utf-8?Q?PvW8ZjZa1E9/yO1U=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a667d4b-8625-4ca2-2d61-08de541a0f5b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 09:40:04.1590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qmp5NW4oiqeUC2c7CATVMaHz5ioscVp4RqqHGVUegnI5nK3qmCh+hZinKrXDI4f8V363MJadIwP0qnj/ZQWbh0+SMl8JQBjdaL+cGDtVE/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR03MB7588
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

Hi Marek,


On 1/9/2026 4:51 AM, Marek Vasut wrote:
> On 1/8/26 12:40 PM, Tanmay Kathpalia wrote:
>> This reverts commit aebb523a23818a8ee4199c9532b51e3d4020696f.
>>
>> The change to use dev_read_u32_default() with a default value of 0
>> causes regression for host controller drivers that hardcode f_max
>> before calling mmc_of_parse().
>>
>> When the "max-frequency" property is not specified in the device tree,
>> dev_read_u32_default() returns 0, which overwrites the previously
>> configured f_max value set by the driver. This effectively resets
>> the maximum frequency to 0, breaking MMC functionality for those
>> controllers.
>>
>> Revert to the original dev_read_u32() behavior which only updates
>> cfg->f_max when the "max-frequency" property is explicitly present
>> in the device tree, preserving driver-configured values otherwise.
>>
>> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>> ---
>>   drivers/mmc/mmc-uclass.c | 9 ++-------
>>   1 file changed, 2 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
>> index bf0bea93853..2f4dc5bd887 100644
>> --- a/drivers/mmc/mmc-uclass.c
>> +++ b/drivers/mmc/mmc-uclass.c
>> @@ -243,13 +243,8 @@ int mmc_of_parse(struct udevice *dev, struct 
>> mmc_config *cfg)
>>           return -EINVAL;
>>       }
>> -    /*
>> -     * Maximum frequency is obtained from the optional "max- 
>> frequency" property.
>> -     * If not specified in device tree, defaults to 0 and 
>> sdhci_setup_cfg()
>> -     * will set the MMC configuration maximum frequency to the host 
>> controller's
>> -     * maximum base clock frequency from capabilities register.
>> -     */
>> -    cfg->f_max = dev_read_u32_default(dev, "max-frequency", 0);
>> +    /* f_max is obtained from the optional "max-frequency" property */
>> +    dev_read_u32(dev, "max-frequency", &cfg->f_max);
> 
> Why not do this then ?
> 
> cfg->f_max = dev_read_u32_default(dev, "max-frequency", cfg->f_max);

Good point — you're right.
cfg->f_max = dev_read_u32_default(dev, "max-frequency", cfg->f_max);
is cleaner and safer.

I'll send a follow-up patch with this change.

Thanks!
