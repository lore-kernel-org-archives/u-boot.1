Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E4D7CA0EC0
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 09:05:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D55E83394;
	Mon, 11 Aug 2025 11:05:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="CKc3wLMJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2DD483335; Mon, 11 Aug 2025 11:05:24 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9F128331B
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 11:05:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ty48uvDbaCqsUxBXnVWTtBk9+r5i5wyb7aTf92zeWtOH+lYqos6OkziS0hnxccM4D55KWYx1YLisVzs5gsK6CLTJ6LsGJly/VizutUpCmsSxuiD5UVcszrmyA9OHTeUnH4kAz5CSI4qreDVwHIcRNZ0N++/wwy3MwgARuvUleTWbpZvx0l8WX5c4f4FX1TiX1ChtpE1nF5hiGIYRxxCTvwAPfOWZQ2kl+GhwK4qmM3DHBxEoId2JF5QKvze/kmjFdZKdHHVO2uLSOSluP6j6lmKKjf1G9O3YvQB5UzxeWBfp+YJzD503h0JJ+msSlYlskNUlp9YQBv+AaPOCLDPZmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bn2O9I/RHManusu3kaJcjSouQT0VKBGoiTUF8CzF/Ss=;
 b=qCKqXbbPxofhtoO+Dpxd0bRYda8f/BJ+bJ8KdQn4Ns4Z1uDYRAAo/UnuhTSq5rBks+ZZBnOQecb1qiUcLzMlr7YYnFHaRdmh2q+rlDVnZukcF3E7i0dIxmtJ4rgyE499m0YODsp1x7Pp5B7EivRoA1b1WWtgMB8e5/UxTDRzAK+QzeqbR4Q9tpa6KZ7wV1JDP0eEiVmQWXDf03CNN09oXljv/+RAIM+n0Lj7jneFc4sxzai7gdSjQngbTTp+QLOLdDpuuumQtduhgJqCN50Rq+NhBVp0kOROpCsXn0NIZ3xcrIOQwUdfyGXIh7t5rHC6i5NxqvrOKIBWvoamvzzZhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bn2O9I/RHManusu3kaJcjSouQT0VKBGoiTUF8CzF/Ss=;
 b=CKc3wLMJWdj55bbTwiVM1UwtjlZ/zuwt8U5eCLCe1Eh0LIKzgR5DvfMorCu0Nm9LeJGO8mDlJA22/eiJkoZMpyKW+YaMQKrSWJK7+QPaQG6jRfmybX72Jr+heKmMpdzTI4zvS/WV+LHWL7c6mfX4wjTuB05CnZNAwKCfFVYRlsc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GV1PR04MB10486.eurprd04.prod.outlook.com (2603:10a6:150:1d3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.9; Mon, 11 Aug
 2025 09:05:18 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.9031.011; Mon, 11 Aug 2025
 09:05:18 +0000
Message-ID: <7ea37620-f8de-40a2-bbe8-9ae54a8fafe5@cherry.de>
Date: Mon, 11 Aug 2025 11:05:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] rockchip: sdram: Add rockchip_sdram_type() helper
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Eugen Hristev <eugen.hristev@linaro.org>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
 FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250801170933.2530191-1-jonas@kwiboo.se>
 <20250801170933.2530191-2-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250801170933.2530191-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::8) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GV1PR04MB10486:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bb95114-17f9-4f48-8372-08ddd8b6316e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YmhPVGZQbmpUL0VteCtRaUxlSFpjS3BGcnlXWDRGamwvemY4eHRRMnlnOTQr?=
 =?utf-8?B?SWtsbXA3RkdkZmRmZ1dFZ1ZEL3RYbk9Hak1RUXVzYmVqQ2R1N3dWN29PWVA2?=
 =?utf-8?B?cEhBYWVwRStjNTJES3FtWFBMRk9RbXUzeWg2MVZGTEY4ZTQralVUSWJLWEVr?=
 =?utf-8?B?NGlJb01RYmJqMnR4V2tMaHhrdWJFQVNzR0VGdElFQ1JrRGZoOHNlMjg5R0ti?=
 =?utf-8?B?WFRrUjNSRVpTMVNlZGZpSEdwTUxCQU91VTh0WHhPenlkVXNyc2k1ZVFJc0RF?=
 =?utf-8?B?S2Z6VGVuTm5rSGFjT0xWcWhmMTFzN1htOHRmdExLSmhXQmJCUWFYSU8wK2Qr?=
 =?utf-8?B?eXpjNnNwU1BDZDlNby80QjZyS3hGNE9FNStqM0N6MU43YW5LMWNIR00zRXJu?=
 =?utf-8?B?V1RpREdueStqNEVvWDlRNmpUalA2K3dHcVpHMEdiYnYwcC9QUG5IQnZIMlhH?=
 =?utf-8?B?WHNockUxWkYvWWhvRGZXdmtwMHdoUzFrNmMrcHUzRmFrTjUwOUYralc0Nlkw?=
 =?utf-8?B?RjlwR2lyYVcxVHYrMEt5T3BWekQ1MUMyRDN2SXNNZkhnU0RzU2t4bVdKemIr?=
 =?utf-8?B?eWZ0OXhXT2YvTHRBOWxtVUdOd1pLZ2kzbWdhbUV3RnNYZmFmYnMwNmQ3bTRN?=
 =?utf-8?B?R1ZEOC9WS2RHeFB1MHNQVDM1bU1uZ0dSQmljR0dNR01YY0M1OXQ5L1ZjVzNW?=
 =?utf-8?B?bHhicWw5R0lGYm1oQm40M3BMMmMyb3o2QXRabmM3RTdidE5BTjZZYjZkSkNS?=
 =?utf-8?B?YmkzSm8wZm5VN0tYZDA3RDN1RVpDVUJBb0tEektZT2hzSG1JYkRzZVV0RXB5?=
 =?utf-8?B?UlV5QzRFd3ZEejI5OGNnajRiaTBPT2hmcGZSRk45c0ZJWnJLTVFPdm82cmx3?=
 =?utf-8?B?NHBrTWVDaW8vS1NCYkk5cDI4MHpjNExma0ttRitsNU11cjNvU1Zjb2tFRTdj?=
 =?utf-8?B?YWRLdHJVbWI4bExPcnY3b0MzSTFiQlZGSDFkejBkM3ROZjkzbmJld2FoVEh5?=
 =?utf-8?B?MlVWb0ExT3A1ZmRTOVBDR0RqN3NLeU9Dd0VUbGpnaVMzaTM1K293WGZVMGQw?=
 =?utf-8?B?WStYUitwWE1zdWlCbjlLQnV5UjJpejRLaklIVVhaY2NXcWtsWnQvSW1PdVFw?=
 =?utf-8?B?Vzlmd2F2ZWtPUVJZTXZ1MFJEbnhnTkQ0dFdlNW4xb3BLY25RVHBxNVBWbmxD?=
 =?utf-8?B?TkpSQ3J6MjFMSDVmMXNEZk42Skw5cnlKUTV5ZllNd3Vrem9OeVdIMEpzVWFQ?=
 =?utf-8?B?UDV1eU1JNjBoNXVJZGw2UlVKWGcvWXMwRHV3dlZvSndIZmxHSDh0R2VjbVdt?=
 =?utf-8?B?TFVVanBNUDdaaUJqN0ZyMGpYbGdSNkFrTGFZS2hNeWlMTHF0WGt1djZJMHF5?=
 =?utf-8?B?MzFIRmlpdXNXS2plWHF3V20zdmY0VVVhbGk1UHpaalNWV0RLT080eHJEcHM1?=
 =?utf-8?B?K3FvOGlRMEhsdHZrTjVNYVNwTkZKd005L1Z4OTJVeXZ1YkpGZDBjd1pWdFpo?=
 =?utf-8?B?eDBDVWJ5Yzc2TjdhQVdZekd1N3NqM1J1SHNUZVhBVThqL0I0WUh5cmw0SFd6?=
 =?utf-8?B?NG5QSGROT240ei9JSUp0azhYdi8xU0RDYVFlU3RLN2tuZFZLZk1UTy9xR0Qv?=
 =?utf-8?B?N05sS2g0WEZ3ay9QREUvVVNHWE9hNnQrUiswZmI2S1BqVUwxYWhtY0NCdm0v?=
 =?utf-8?B?Um9BUzhTTjdKVnp5SXVuUGYxRzRpdG5IVXFpb0tndEl2U3pLK2xCNFdGdWVG?=
 =?utf-8?B?VVVWMjhXanh0K2tEZFcveU9Lb2ErM2RnM1VwWWZzZk9FNkp6Z0RWc24vQ1lm?=
 =?utf-8?B?VXZabGc2bU10bGxPUS9jNE5Xd2Zka1ZqejZ4d1pnUzBIYlc3YmdsQmxCd2xF?=
 =?utf-8?B?S2VDcjVndkNITGNLMHl4UVUvTjFPODZPd1FSS1dkU0RuU1E4YU1mUWVnUERv?=
 =?utf-8?Q?5jj+GXzgo90=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXlwaE5OVlpLUWtKWDMyUVY3QW1XUi9CVWM1UUdYQWdOWHpkdVdPdjFqM3dK?=
 =?utf-8?B?cFUrcS8xZTFFMVJWSVhaMVQyMkpnbVRzN0hpVkFnSURLbVBwUDRWMC81Rjc3?=
 =?utf-8?B?Q0JiRzBYSGZYcU1WSTBPTTBlZlhtOTcxUkhrNGhhZGNacXZ0eklnVXNaV09B?=
 =?utf-8?B?WnorYTNabUhvSzl3cGJRSmNaOXQveDRvYVZOVEZZcVlmMW81b2NONTJaaC9a?=
 =?utf-8?B?WVAya1QyL0RLMHJSYjhkejR6M3F2U2QweWpyajllZ0dWWGhBd3dZNHkyOUF4?=
 =?utf-8?B?dUZNUjUvcXRYMDdIeGVWMW5xaHhvQUMxd3RKTlJxQllqQUxyRkxkTGlqYlpW?=
 =?utf-8?B?UUJmZXJvQjVLMll0RWhVSng1OWVKc0xqWWFIT2twT1ZHcGIvNllOTFZrUzlV?=
 =?utf-8?B?RktVWjJIdFBST1VLNzRTdjFKTnljQXk0RVc0VDQ5bHN6OHdJdVNTMkdFTmlm?=
 =?utf-8?B?a0l2OE1XbGlGcXZ0ODhFUkdWWFBCb1ZBT0Ywc3ptQ0Y5aGpRcFlKSjM5NzNw?=
 =?utf-8?B?aTM3WTNPQlRLTCtlOHdmdzVCeEgxcWRyMVQwcWJqam5xdDIzNlZveXVPeEVt?=
 =?utf-8?B?UXFPdFduU0o5emI3QXE3WmZoTis5MVZSblBxZnpveVJtOTlVbjVucTRCQ0RI?=
 =?utf-8?B?dzdNMzl4RllzcUpIT3BQSjBBR1M1K3dxcEFOTnJJT29yNmJZcXdzbkZBbTls?=
 =?utf-8?B?QzZGNDErVmwxbElubzUrbUZnTUg2a21CamtlTVNobmhCaVhCMjgrMDE2c2N4?=
 =?utf-8?B?YVRxOTNTcXkyVVc2SzlXSHBEK0NOZ0lJcHlHK3pldi9HRURnWXk4c3pQNUZv?=
 =?utf-8?B?VXhUVmJGRFF5d29oSWwvc2NhQTNncjQ3bDZGU2g3OW10bXMweWZUNmplam12?=
 =?utf-8?B?ZS90cXQyU2NhUG9VUHA3SGlzRTdOV1U2UlBlYUk1RS9NVm41cmFjaG5FM1hC?=
 =?utf-8?B?Mzh3cUpOQkJ4by8vTVhkQ0dDY2tUZVlLT2Vubk12MVVVaTdqaUluSGxRN2FB?=
 =?utf-8?B?UkU4dm1nQVNsM01zbEUrK1FsMVc5bDRuTndRZlI1a1hZNzllanNSVjRaY2ZS?=
 =?utf-8?B?VkxoRTI5aFZKd2s4SW1kMytxcFFTczBjODBCZFJZT3FFSWZoNDVnOWIyZFdw?=
 =?utf-8?B?R1grRmJseXI0Yjc5d1YzVVUxNDlEM0xmVWlYL1FnOUhzUWVnT09Nd0w0VjVP?=
 =?utf-8?B?VlQ0STRLVXBUL1pQVzFxOWt4YjZ4ZDlpZ0VjKzh6Q0xyT2xISXgzTmpUUHlp?=
 =?utf-8?B?YmR4MUVGM0VYV3BSRldWQnYvdVFGK2dXMC9VRFpRMDFnY2lkaVVWZ3BrSC9s?=
 =?utf-8?B?TjJEcDl0Q1FiQ0pjbmdoWWpkNjJsOUZ3UDJGczY2ZE5oSFhkYWN1dVhXN3Zu?=
 =?utf-8?B?OWhFc2drb1ZDTThkSnB1ZWFRenB0YVMyOVVYMUN5bXl2a3NTUTFQTE1CMlFU?=
 =?utf-8?B?d2lYQTNJbTJ3UXQxakdTaVdiR0pST2p1ZGEzSGRzRXlnZXU2RVM0a2l1eHlQ?=
 =?utf-8?B?N3pEU2x3U3paN2JxbHBrZklOTHM0RUFtT2cwRVRvdFI3OGFXYVB5cjN4VzFL?=
 =?utf-8?B?V255RUx1ZHVjS3QxSWZ6d1BaVHY0RG11ZVFVRWplckE3eWlGVGxvMXNZc2JW?=
 =?utf-8?B?a1JndTBiQUtZamwwUHVJZExMaDdOeGUwMHErZURlUGVrSy9xOUpocHlKUHhU?=
 =?utf-8?B?b0NQUXVaUXZlSVFoRDU4QkUxMHZkUU15VFB0L29IMUhSc25yUERxZlBPNERX?=
 =?utf-8?B?azlmOFUrVVRFSGVGZkZlcmp0M0JTR1JXTlJWTDQ1TkNqUTBNa3pNUXNHRHBh?=
 =?utf-8?B?SFF2bzI3VW04SGR4SGFhSHBHcThpVnlmYml0cmhma09xMVd5V2hlQ3FRWnoy?=
 =?utf-8?B?bUpRSDh2THNOR2RLenFtZFNYRWlHNnJpUXVZNWxlZ2poazF1UFh5RHdZZFNZ?=
 =?utf-8?B?bDQ4Z3lLWG1qMnR5SkdUY3FpZENXbEZ1L0tpOGt3RWVrb3laQnAwOVlMV0xh?=
 =?utf-8?B?aTdQeFVrdzB3OU9SUnE1WExSQ0RqRExYS1phSzRJQ1QxOHlmQ05NQjRsSG9I?=
 =?utf-8?B?TDRGc2FvYUlyRC9FaktaRENWWXArbVlWVWU4RDI3cHRuVzBzWVdJZnQxUXJV?=
 =?utf-8?B?VTA1S2VWQ0RsOXhWNVhZbUNuNDRvTTVYOWpoWHdrMXdoNlNhYWNNYmpyM2dM?=
 =?utf-8?B?b0FQa0VsRDZSTjRxQ0djemlHdGRVM2QzUFVac29Vc24vRWtDOHhMUTVoWjVM?=
 =?utf-8?B?OUVXRkpmUmliZ1A1K0VjMUx0cE53PT0=?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bb95114-17f9-4f48-8372-08ddd8b6316e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 09:05:18.4700 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cSqdK6CNvmK/2axPgXBS9PCLFDX0VsOkCFk68k0/xyjRFbHc40kCoLnhVThWIXZpkS1fevzBl3QSKRtQNbGCRuXzoZGF1O49o6Akx4KPvdE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10486
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

Hi Jonas,

On 8/1/25 7:09 PM, Jonas Karlman wrote:
> Add a helper function based on rockchip_sdram_size() that return what
> DRAM type is used on current running board.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v2: New patch
> ---
>   arch/arm/include/asm/arch-rockchip/sdram.h |  3 +++
>   arch/arm/mach-rockchip/sdram.c             | 15 +++++++++++++++
>   2 files changed, 18 insertions(+)
> 
> diff --git a/arch/arm/include/asm/arch-rockchip/sdram.h b/arch/arm/include/asm/arch-rockchip/sdram.h
> index 4fb45ac5c76e..476fc1c4ee33 100644
> --- a/arch/arm/include/asm/arch-rockchip/sdram.h
> +++ b/arch/arm/include/asm/arch-rockchip/sdram.h
> @@ -87,6 +87,9 @@ enum {
>   #define SYS_REG_CS1_COL_SHIFT(ch)		(0 + (ch) * 2)
>   #define SYS_REG_CS1_COL_MASK			3
>   
> +/* Get sdram type decode from reg */

s/decode/decoded/

Please define in the comment how to map the u8 to the actual SDRAM type? 
I guess ideally we should have the enum in 
arch/arm/include/asm/arch-rockchip/sdram.h typedef'ed or at least named 
and return that type instead of a u8?

Please also document which register we should be passing there and the 
assumptions made in the fucntion (that the version (of what?) will be 
read in the next register as well).

> +u8 rockchip_sdram_type(phys_addr_t reg);
> +
>   /* Get sdram size decode from reg */
>   size_t rockchip_sdram_size(phys_addr_t reg);
>   
> diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
> index 3bc482331c7e..d560f90e873d 100644
> --- a/arch/arm/mach-rockchip/sdram.c
> +++ b/arch/arm/mach-rockchip/sdram.c
> @@ -345,6 +345,21 @@ int dram_init_banksize(void)
>   	return 0;
>   }
>   
> +u8 rockchip_sdram_type(phys_addr_t reg)
> +{
> +	u32 dram_type, version;
> +	u32 sys_reg2 = readl(reg);
> +	u32 sys_reg3 = readl(reg + 4);
> +
> +	dram_type = (sys_reg2 >> SYS_REG_DDRTYPE_SHIFT) & SYS_REG_DDRTYPE_MASK;
> +	version = (sys_reg3 >> SYS_REG_VERSION_SHIFT) & SYS_REG_VERSION_MASK;
> +	if (version >= 3)
> +		dram_type |= ((sys_reg3 >> SYS_REG_EXTEND_DDRTYPE_SHIFT) &
> +			      SYS_REG_EXTEND_DDRTYPE_MASK) << 3;
> +
> +	return dram_type;
> +}

I would have preferred to use FIELD_GET here but I now see that this is 
extracted from rockchip_sdram_size where it's like that.

Can we make rockchip_sdram_size() a user of rockchip_sdram_type() to 
make sure it doesn't get outdated?

Cheers,
Quentin
