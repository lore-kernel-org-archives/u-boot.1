Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA0ED38FEF
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 17:19:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5033803F5;
	Wed, 14 Jan 2026 18:19:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="cCqfqur1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE3D580433; Wed, 14 Jan 2026 18:19:26 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB94980325
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 18:19:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fx16MsQ+ytCJFUPDZoxpBBr4jp63zxmEgzaG4mWDFr7iRYSNH7uSvbhyq9oHkrGJLnMzewCh2FMmxf6GdAL/pktbH8p9WRstrzl7p2qx9NXwXcFfym3BdjFadZO42EXVky9GVcy3D083JJrXisKU0jNF+IWHJb/LCM6ptcW23NJjGC478DFaLhs4ZC5mzaeXmAV4ZHyKOXilEG4BfBE3UMDAtl+PQfzI8PTNGq6IQPazfTHF991LBK0RHr28297VKfkAXIvy+DrOG9XGD32bnUUXrcCNY2DG3ymdItmkyBLF2jZXxhPsENVzR3I4/XxWZwfcc2G5mgtCYfHEcRa8TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRR7F+rVJBMhimmaxLCv/Xk+/Qxn+W6UbhxdUiMHm2Q=;
 b=dAgFVmWZU+4qm8GfnzovqvTYFusyClnRXQ1jItSVSHVwy1znPvkEnetE1XntfY1Rs3b4UNW5BU0hDxkEjKg5dsHIvjqYMfw2hxZ4vr9/j4ZSYjHGt26eKCxc+O8bwT2t4n93nqiji84jNwdMe5rydkStu9fR00qEqFI9E5Yhf+jdGuNMTe1QC06LuGHExlIF9pVoxtOk4rvBGMXb3zZrciE4fTlBKFYADncHqJvelNgC5EVc8MeZnKK/kchP/HuVP3BfuZ3vId3nDClxq8qeJaBHOC7N5vBDCyz56GXjWGvUjsDwbWY94hXUBgn/sMCPStrtKcEoGWD9lSicITsiVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRR7F+rVJBMhimmaxLCv/Xk+/Qxn+W6UbhxdUiMHm2Q=;
 b=cCqfqur1Z1WS6H9u+JIA0tOz30G0Zr7sK7kikeJ7qXzn6VSC3/sHD7fSF2q50/txa3NlsfkvoP7EuLj4puHb70NGvs7Y0HoW44x0ZCmVEGkf0e6pcwUCsuPW6VaONO00sXZzUOucHyvOO1XIC9x0jb9AtznfJeu3SncYR6TfS5I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PAXPR04MB8861.eurprd04.prod.outlook.com (2603:10a6:102:20c::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 17:19:23 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 17:19:22 +0000
Message-ID: <fba47ca8-7cf7-446a-9242-54c50087cf3c@cherry.de>
Date: Wed, 14 Jan 2026 18:19:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] pinctrl: mediatek: kconfig: fix logic
To: Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.denx.de
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Sam Shih <sam.shih@mediatek.com>, dlechner@baylibre.com
References: <20260108-pinctrl-mediatek-fix-compilation-issue-v2-0-3d0499d3b6db@baylibre.com>
 <20260108-pinctrl-mediatek-fix-compilation-issue-v2-1-3d0499d3b6db@baylibre.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260108-pinctrl-mediatek-fix-compilation-issue-v2-1-3d0499d3b6db@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::12) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PAXPR04MB8861:EE_
X-MS-Office365-Filtering-Correlation-Id: 966c993f-777c-47af-1896-08de53910f77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WmduTUpSNStXUUo2ejlwY2NHZXJ6WmlkbVU0UnNUekJteTNsT0N2ZnJLUUtB?=
 =?utf-8?B?NjRQNWNscEdTcmFmanVVbk5QbUtTbVB0akpuVm5GR0YvN0N5MExNRHpVZTd2?=
 =?utf-8?B?c1d0dXFLMWRuanVzeFJacUxuUDkxemo1N20zSUJaKytXczFLemFSV2NvcU9U?=
 =?utf-8?B?eGRubzBnT1lxWDl2YmxRcmhxMUt1VzZEYzZzQm1tWk0vNS81STdyZjFMdi9N?=
 =?utf-8?B?Y3J0NDdkbDhHa0Jhb2lhbXhNNER3VXIzS2hnQm54NFNxQldwelFDbk5nekxL?=
 =?utf-8?B?VWtDTXBJSXV0eFJzM2pWbVdCYWg5Mk1XRFl6OUd2bFhpOEkra2g5UCtIZFkw?=
 =?utf-8?B?ZmUreHZ2di9wb2xKclhHSFd3K0Eweks4TlRyeWROVlI4TlMyTzhCQzhJc002?=
 =?utf-8?B?WWdZNW81c3NYWWNFZkFIUlRGYVlLRHh6b3dDbm90Z0tVVnl3ZjQwVk5OY3Rv?=
 =?utf-8?B?QVFBd3o4UU0rdFJUM3I3THNsUjBpemxMcU9ZV09GSi9RVWRGTHpwRVBzZHYw?=
 =?utf-8?B?bWVBZWdCQWg0QklKUHdxbjdZTHcyOEJWb0dJdjlTZkxFbTdHcnZidTd1V3JO?=
 =?utf-8?B?QngwZWM2c0k2VU1WZlpSN0VUcVNpTnA1elFpengyQzhkeU9PYlFZZkExOUhD?=
 =?utf-8?B?QnNJdUhGN0xQWnUrNlAwRW5meTFTQW1mRHlCQyt6dWd4NWFKYmVnMmR1THFl?=
 =?utf-8?B?QzMxS09pSUc5R2hFUzhuVEJlTUU2b3YrK2UwQitvYWpOV0dyQmhUZDJ3NFlz?=
 =?utf-8?B?Tnc5MTJ3UmE0NGl0dVJ2S3Nvc2N4OW5QS1kvQzJEQlgxTndIS0diUzBKWm03?=
 =?utf-8?B?NlV5NE41dXlRdEsvZmJNTkJCS09RZndxMi9qdHRXUVhhR1UyeEFwdlQvR1VK?=
 =?utf-8?B?NGdZTUVGOTJjSHFaK21aSWh0a0RiQW5YaUwrTEpHV3hDNDJNb0V1Q3pWUjVs?=
 =?utf-8?B?RlRRdjNDRkMyNFgzQ0N5SFhubFNJMnRrdUxNRDhoMVhyVjBpcU4zUk9LY1dT?=
 =?utf-8?B?dEJSVGFHUUtMcWtKQTBKYkdOakM0YUhZdUJLZklDMEhiSExrRWNMVnQvUDI0?=
 =?utf-8?B?d2lJUEdCcnVGR201SFd5cmd0T1I4WmM2ZzRSUmthK2xHcGdaN2l3YkFHUTYr?=
 =?utf-8?B?RjUxWnNiTGUrdHNXaldLV0VGMXp3VitoamYrb28yQlJoS3QvY24yYjcrS0Q0?=
 =?utf-8?B?RE1kVjQ3azd2Z1ROdmF3VTFienBaTm1aVkhWN2p3OERLcGsxMWVHTWI5VGlZ?=
 =?utf-8?B?Q3pHWGNWZS9samFPNXVmZFdXWXZYeEM4aVcvb2d5c2QwUmxXUURNcTcvWllv?=
 =?utf-8?B?c3ZTR2NlRld1V2x3RmhZYnliK0dNVnhtMUhKMEEwUDZIWDliSU1wMFVDSi9z?=
 =?utf-8?B?SCtuUjFxU3dETUp4Wi9RdHpTK3lPOWlIY0k0WWovWmwrUFEwcGtPZVdLTkxi?=
 =?utf-8?B?R1htNndBNmdWaVdXWDZjVTZaWmM0bW9yWkhLK3d2VHZxRnFWRlp3cUpPVks3?=
 =?utf-8?B?SGRWMXdodFFrZDlnYzk1bTBDZEIvSXY5Y1dxZ0ZCMlhRNDhTU0dzbXh0eTBk?=
 =?utf-8?B?U1ZwYWFEbzRsc3Z5bTFYSEpzVXJDdmlqZEpWOUdVNkJaU2Z3NnIwY0JJNCt3?=
 =?utf-8?B?NDI1cEdCWERpd1lTVW44NlBCb3BaYS9tQ0p2dk4yaHZVNW05YThad28rMFVj?=
 =?utf-8?B?amNRU3kyRzBBdjdpdG9QTFZzK1U4U2JVN05HNS93c2RoUEFBQi9zZmZ0RWw1?=
 =?utf-8?B?eVA2U1NvTDU4ME9nM3BtTHp2UWltRTJOM0NVckwvQkNlaStVMEFPTFd6S0pp?=
 =?utf-8?B?bDBheVhmMElWam11NVEzdTFSeEs3TGxWY20wdmRwSjFMbVFmd3hwOCtJb0ZS?=
 =?utf-8?B?VnVKdDl2dDJ5aExpTlZaU0g2VUdEVlQvYUxwM1UrRnFpTGhnMDczRkpaSUNh?=
 =?utf-8?B?em5DeExSTHJUb2hvbTMxL1QxMys2em1MVjFkTzUrd2diNit5ZHV2L2tNMzdr?=
 =?utf-8?B?eXVmQzA0YUQ4UzUrQUloUWk0VDZvTEhRbE9YM2UrNi9BaDlzWXYrTWlvVGhO?=
 =?utf-8?B?dkhaUkR4dGtlejl0L2FCVjJLM0kyK2V3TjFncmxPWDVrQ3pYOW5wUHptUFEy?=
 =?utf-8?Q?Qnug=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REYySDJnZDJXeEF6dWY3VjdPRlRCZkNSWHNiUmt4OWZkeFFySjFSa0hGbUE3?=
 =?utf-8?B?K2E1dmNnemVGNE5LRzRORndBVE5iaFpxbDRIRW0yY0JnZDdZWG14amh6Rjlt?=
 =?utf-8?B?WXlMdXQ3VWtrNmdLckovM1I0YUJDQWtjMFBtejFpUktVZ0hXMHN2cGM1MnFn?=
 =?utf-8?B?WFhrQmdzTzFLRWdCVTFkVktxTDQvZVNNYnAzVFVIdU5xNnU5VEJNeFdBeUZn?=
 =?utf-8?B?SW80Mjg2UFNkOCsvaVlVQzZRbUZ6dVlNMVRqUkZxUW05WU5iLzQvYjBaSUpB?=
 =?utf-8?B?WXZNcXlVaXBJaW85akhuc3gyeWVLTElOUCtKRnpZazFJcERCZytxV25vaUVk?=
 =?utf-8?B?a3QyMENXc3NpK3dyT1RYRC96bEhYdUFUaHkxdTNqQWpOd0YrZ2lEVStQeFhJ?=
 =?utf-8?B?Y0JHUG1JWTRkSDFzZEprRS9ad08wNTB0ZDFvY0tYZC9QbFNONmxTdHpaSFcx?=
 =?utf-8?B?K09LWng5eHkxTkxWcEo5Z2V4cnlXeTRZRCtPb24vUVJDN0MyQWdTY3I4MUNo?=
 =?utf-8?B?UlJPWGNoUmVHQWFnLytiR1FXb1crNlFWb2VlbHN3NDhEeU04OThMSm1Ib3Ri?=
 =?utf-8?B?dzNJd1MxdFc4UWFOTlZzUWRaUkFsazJuVEwrb3Nmd1doQnE2VGNwdGFjdGVu?=
 =?utf-8?B?NzEwQXNsM25NUUtLTW5RTE5MWEhhZ1R3RnRmMmNielNEdUlaeFFYS3BpVlU2?=
 =?utf-8?B?S3p5aXNyVFVxWXcvQzRsRWRwN01ZQWEycWpVUmhCY2xEQWlGYWVJT0NUanpH?=
 =?utf-8?B?TXNvYkFieGpENThVV1hKMGxINGwxQ3A1TldUTk9aU2phRjYydGpIWUVEL1Ar?=
 =?utf-8?B?UUVucTJpNllWbTQ3MlQxOEI4ZnZuZG9PQm9yVFFMZ3ZBZS8wUStKM0VhMTE2?=
 =?utf-8?B?UjlycE51S05VSEx2MDBJOHRGRXFWdk1XM1RSNGgvd28wdTZTRFhWS2QvdEZD?=
 =?utf-8?B?QjVOSjA5dmhkWTV2UXEyWGp1V2RyR0JQMXhMU3V2VGtOUU5yK0hYa056Ynd0?=
 =?utf-8?B?ZnVGMVdmeDRsVE9uakNFNlRDL1J0Q0R2T3VIeGdYMlNrWDZ6cWxpODF0T1Rl?=
 =?utf-8?B?bTQrRFRGdDlHNUpobWtBa2txOHl0YzZGNDdhQjcyZFFmR3FGV1l4Vlc2RjBi?=
 =?utf-8?B?T1JTaGhRVU0xU3hBRFRQbk9xcjhBY1lka2RWUjQvQjU0OFhlUmFQTnRNc1l2?=
 =?utf-8?B?OXBqT21LTFhSRE5JZk1WMWcyNHFveXFqd2xuR1YxU1FYeWxRekxUZjVTbnlt?=
 =?utf-8?B?NGNVNWpNNGFtenUvemZVeFYxbmhNcHc1K2VCNUpmZStydEFSaG4rYnA4Y1NY?=
 =?utf-8?B?elpnVmlOMlgzVTR0eSsyOHNXK0ZKSGV3eGlLRStSdmxYRVhWVGIzdmZvaHg3?=
 =?utf-8?B?bWpENFBKOGpyN3dlSk5SVnM3UUV6cHM0dysxc0NMZXZFMFdKZ3YrVzVqNUQw?=
 =?utf-8?B?WHExbkFlVGV6c3dyRHNzbXRla3h5KzZicFhjNXpHRldnaWJsQnIxRG9iRmRB?=
 =?utf-8?B?eGhDK1djZnlBcHM0TkNBbnVaUnU4SE1vZitGYUJaTHBoa0c1ajZkMzl4SHU1?=
 =?utf-8?B?aDV4WHprSENoYmxieGlTTDlzbEQyWGJIYjgwSTVkSnhyNzFyMzRIVmFpNUEw?=
 =?utf-8?B?cHNPV3drZDRLY1Z6R0NPc2tZU1pJQkxBbHhNa0J6WmtrK3o2N0lKUU1nTC9V?=
 =?utf-8?B?SUl1VVlBVDZ4SUtCcUt2cmNWeFEzUnBNNWptQTI0ZEx0R0o1d3VqMjM0U3NJ?=
 =?utf-8?B?dFh4SSt1MXVlb1dUQVhaVURBM3lPVHJJNGNWeXFDNkg4QVNqN2xZQVRwdmd3?=
 =?utf-8?B?SnFyZkkxUmk4N3E0RW0xa1plNGd5anJHTE9wcmtLbHVOdjhWMU5VNDF4RVQx?=
 =?utf-8?B?aFlaams1OVdHaGdhMDhnS2NkQWtaY0h1aTQzeUV2UFNkZU9BcDdXb3hKeDVV?=
 =?utf-8?B?dzYxV0hMcWgrWStvQXpCU0kxb0FCeUdXWFVvM0ZhYlR2bFliZzUrS3U0YVJk?=
 =?utf-8?B?YWJUTll3eURERVhIdTQ3U1RlVGgvdnNBQ0lGNW5DUWtLdytXNm5IZ1g2bWF5?=
 =?utf-8?B?MUxwT0FQM0Q3Y0plVGZVVmtBVHI4ZWxTcWY3SzRnRmNUUWdCdWYxZm51RFVx?=
 =?utf-8?B?dkx1YzZMMytUbFJ2Nk52cDlkRUJOQ1RNRDJoZmZMR1ZFTmQvcko1bXoxZitv?=
 =?utf-8?B?eGE0Y0Z6anl2VkJtV0JlU08rVnJiOE0rVWkzSDJkMVJvd3VIZ1B6clNsbFFD?=
 =?utf-8?B?Yzg3VmFKNS9rem1xeWdQWjR6Ylo0Y3l1MWx3TE9LVXZRODQ5eHRVUFlXL1hC?=
 =?utf-8?B?TzhzTFFHWlJyS3VjLzdibDVVTGljTU8zS0xTUXE0YUJLc3ZhSm5OZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 966c993f-777c-47af-1896-08de53910f77
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 17:19:22.8953 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wgJJJ5bnoRJCcEHdiyzONsLvUnKMvwH3CcaQQKONXeT2iZyXZL82zDlT/mTRcn6QhR2bEUkiksBxrhrjYzuilizMY7Izavmh1CaCDzWFNMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8861
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

Hi Julien,

On 1/8/26 3:47 PM, Julien Stephan wrote:
> We can't have PINCTRL_MTK depend on PINCTRL_GENERIC and then all
> drivers select it. Individual drivers should directly depend on
> PINCTRL_GENERIC.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>   drivers/pinctrl/mediatek/Kconfig | 21 ++++++++++-----------
>   1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
> index 8b9180bd2aaeb56325ba42d08afa42d9317f23a1..d10d08d9fe80441a5a2f8acc13e312825fa43a5d 100644
> --- a/drivers/pinctrl/mediatek/Kconfig
> +++ b/drivers/pinctrl/mediatek/Kconfig
> @@ -1,47 +1,46 @@
>   if ARCH_MEDIATEK
>   
>   config PINCTRL_MTK
> -	depends on PINCTRL_GENERIC
>   	bool
>   

Are you sure this still works?

Since nothing selects PINCTRL_MTK anymore and this boolean isn't 
selectable (doesn't have a prompt) and there's no default (Kconfig 
defaults to n when it's missing), how are the drivers/pinctrl/mediatek/ 
going to be reached (see drivers/pinctrl/Makefile) and 
pinctrl-mtk-common.o be compiled?

Maybe you want something similar to what we've done for Rockchip maybe?

Have only one symbol for all drivers but only build the SoC-specific 
driver if the symbol for the SoC is selected? (this will also make it 
easier to have SPL_PINCTRL_MTK for example (don't have to have a symbol 
for each SoC). Using CONFIG_TARGET_MTxxxx for example? Something akin to 
what's done for the clock framework already for Mediatek, just with the 
additional PINCTRL_MTK symbol?

Cheers,
Quentin
