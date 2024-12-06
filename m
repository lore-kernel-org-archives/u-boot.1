Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F0DE77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 12:55:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87BE38921B;
	Fri,  6 Dec 2024 13:55:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="inbJwl54";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A72648937D; Fri,  6 Dec 2024 13:55:34 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F2D788F83
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 13:55:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mebat6IHD2hA2//Eyvw9jC3g5dheqKvNQ8hlc/wKlhKJmOFTX6I35BaZzRAlSCul2SiDhwLYBEeWKGgC821IhErOwpl9/oIqVcqiVusTlCTmvl1rCl8KmCjqmbWVidnMyOLNh7Q75jMH/HxSSRrjlnh6JZreeKOESplbyoI1uR0G84p/X95uwShJsAd2Bt1BWDl/bb5CJADz0JgTQa11pvsHBQCpX6cWj6nif71CKVAHmDT7LV8kcbt6acEmMuMK8rRQmyMAgKsRUl3sajFh8NoRSq2Vv2dhmU269b+vI1vsknZGv5o7a637+IE18+IFPtzHKPDw+5Pfo6QpHzz0hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0T+hzKK3uStYtqHP0KgLONTo4Go0wB3w/zhgo63FSNs=;
 b=KGlu7z/hxAzLvrkvJBKuwst6i8O04LCRx1kmbLzATr+SeQk7CjK31WiqzWUuPsJLRkUgfUv69eFP5MLfaW9EGt9l0D/JPkajJSraVDScskSRCS2Mvk+r0HTgE9D8rXGXnbSIuYZ+S3yoTYhzfBByx+nRYEN1MNnLYrSSVWaRcek0lwmDGU9WiyUiJDwm+/3VAJ/cymjxVQSvvidheRCDygQ7BeZdWlNz88UrPsQxiqLY54zSzSYPI+fPHT8oiTFhVYvhFhHX5wRT1vhgiqegS9qtx2q0vLNv235Cszp7eTv2+nF2UsZiL0b75AECsmpudCvcTc6xE9d1sWWwNAFISw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0T+hzKK3uStYtqHP0KgLONTo4Go0wB3w/zhgo63FSNs=;
 b=inbJwl54TgH0XgVBDmy5a0vp1Fzv80paQesnAByrm96C1XIStw960QisNtDbcwXPpBmBAJ+SY1zf1cbqkSk7RkbwXbXs1OQSxHMJyFZx06fstGJcbKYL5AFUyBMG856ZG1d1/fLJL+Lbe0flx8+eAxyOTYf4wf76DfMZNvLfVCM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by AM9PR04MB7667.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 6 Dec
 2024 12:55:30 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 12:55:30 +0000
Message-ID: <f1868466-4340-485e-8fc3-20ca7002f0db@cherry.de>
Date: Fri, 6 Dec 2024 13:55:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3308-rock-s0: Fix SD-card boot on v1.1 hw
 revision
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241203214711.1011176-1-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241203214711.1011176-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0290.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::20) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|AM9PR04MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: 861f6f6d-94ab-4b49-49eb-08dd15f5438b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SElWclE5REowemh5ZHFvbEZZdWVrSDd2U3VBV214Ti9WQUtxVXlDUDIyZmhl?=
 =?utf-8?B?Q2dsYkVEZkhlSlJ1a21DbkdiS29iemVkYUlrUXVxT0x4WDdyVWdUNndMTkpx?=
 =?utf-8?B?VDVPbHpPYWJBbytpL0hRZ2IyTFM1b3hsVDExaFhMNGdCZUthNGRpNkNXVG1h?=
 =?utf-8?B?NWdUL1ljNmM1RllXZnllTEpDOVlrTnY1TDZ4c1ZDNG9nWXRFQnhzRXNab0lH?=
 =?utf-8?B?OUVuYW15WXI3RGJBdVNsRHdObXJhSjErMUZQMHhMZTN5TXZiZWNtWHRkeXVD?=
 =?utf-8?B?UkNsR092Q3IwemM2L3M3UWxQY2M0TXhQUVc2QUpqczV4T2tyWFJObEFCZVlt?=
 =?utf-8?B?dTBUa1JpMEJRUWxKYnVrNllMT1p3cm9FekdMNzlqeGhCU280elFFZjNKZ1BI?=
 =?utf-8?B?VG1ibnNzR1dWZjBGWmI4Qy9paC84OVN4N3RHYytidHkrOEhkWWxqSnp0WGgv?=
 =?utf-8?B?Z1hsWXA3aDNDL29pL2lRNGxIVlZXZlBxb2RheEFYMXRBS3ZSM2RiMWJDbktZ?=
 =?utf-8?B?NWNmT2JERjBoY2ZJVzJCMk4zWUFGSGc0aGhuUUs2MWRpTnNseXRsL1c2ZDB6?=
 =?utf-8?B?M3FmL1h6amNPYW81TWdwL24wM3V1YThOL1hkSER2RWtGRXEvVFJzSHljVThP?=
 =?utf-8?B?TXRtL2F4NFBmWXNLTmY1VEgzeUdaQ1V0VnVxaDRPZURUZ1FiK3BVQVhUZlBz?=
 =?utf-8?B?QnVXU25xV3J3NHVtbDJ1OG81UG50dTU1bGlhQkJtUGFFUmR1WE1JMHFKaUNr?=
 =?utf-8?B?Yy9GWmw2UDRRNXcvZVZ4VFlVcnlvVExmUTBMSjM2UzBHdkN0cmlEQnNFZnJV?=
 =?utf-8?B?cm1LMkpnbmw1aFE5TCtpZFFGRlNZbWdGRGIxOEJwRitmZnI2SnNqSGZOdTlq?=
 =?utf-8?B?d28xczR4REtGRzVMa0tHODZuMzNBUzJrclIxOUVQVWYyWGMyTUVPdk5semtT?=
 =?utf-8?B?WWxYdzJNczJ4V0VGYkZwc2FsNngybk5mc0pHcG81TzBtVGVSQUhYeGY2emlF?=
 =?utf-8?B?QXpORkNkYzZpOGxuYlNkZXVsbjZGYXZIMm1WQ3k4dkVqeDV6azNsUEVpNkxm?=
 =?utf-8?B?ZmFZM0QvM01QbDVZazg0VnYwNHVFM0FNakFGdXpWdjExRklpRnd2eE00M1Zy?=
 =?utf-8?B?V0FqUUhhcVNESTl0KzRLejNka1NiL3puY3hKWGdpc2hJR1NGM2w0dXB0M1FC?=
 =?utf-8?B?QlA4UU1LTGUwZnp6YkdzVE1YbUlXVHRzc2xYUmppN1QvcTFtOW9ZM1pmRGU3?=
 =?utf-8?B?amowSVZxVVlTM01UekxOYTIwT0Fqb28zTDRhWllPdWRBcEV4MU9zSDBPQXJi?=
 =?utf-8?B?ZWhjTW51dDZpUHRjU1FnWms0cG9tYUVEMkIwN3czUnRWSzBWYXE0REhVU2RV?=
 =?utf-8?B?MFpVdit5L0FBRStTSjJmTnJVYkNMdU5nV1g3eGlwUml1UkhUeEZDd1FPVkJU?=
 =?utf-8?B?YXpBOS84SGNSQnk5a2NOdDdrcjExUktCQUFoUnlqcHlGclE1T3BVNktjLzR6?=
 =?utf-8?B?SUR4d1E0OFlUZmVEYkNNaTJtR0MwR1E4OUlrQk5GSlU2djlTdzMxY29uL1Iz?=
 =?utf-8?B?aTkvQTdlbkY2eXRnVVFiV3J5QzRlLy9pZEQ0Q1c3SzA0MzVidWpwZUF1M1Zn?=
 =?utf-8?B?NVZ3MEJPVFNOdDl4VE5XS1AwS3RLZUx5ejVqY0xjVFU4bkpnN0ZZNFJUcFNa?=
 =?utf-8?B?TWpsRjVSRUJ2RUp6dmRWWnhTb0d3UmtzZTZleEZUMG9YYWxobGZXMnpHdnh2?=
 =?utf-8?B?ZHlyTjVqUW1BMTlmZk9ZaDg5SXE3YkcwTFpZSW9iUDNqdFVPMFEvNnVXdnhP?=
 =?utf-8?Q?7Blm4/s0TFIMU2hYPyU9MwBhiAg8g+PWs3Bs8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUtrd29VQm5PemtHZTRrSVBmQjFZNytkMHRkUzJZUDVVQmxDMVJsNDNHY1dC?=
 =?utf-8?B?N1F3VElpZkh5d2lUNFFSamkzTk9yWVZpMzFFYUlzRmN3ZFlUNFRLRjJYTFcw?=
 =?utf-8?B?Z1QwdWNIQjZ6RDBYbTl1T250MTZkNzViMzVrZU1sdDdMYmFEWGZGQVRuQit6?=
 =?utf-8?B?aXRPd1kyRXVvWnNJeFdQVXFZV3R3YjFZeVZnL2dxbUNYbGQwR0Jpd3NETmZE?=
 =?utf-8?B?eGF0cGdsWnM3MWM3MFVHOWJDUmRvazI5Z0ptQk51WW9FUWJ5OVY3bDdrZVpM?=
 =?utf-8?B?eVN2QTdCdEU4OWJha2o2Z2xYU2lyZ0RybWZaeUZYTnllS2FqWFdEUFgwWUQx?=
 =?utf-8?B?MnhiR0wza0ZhWjVUZHhWa0pGaUZDcGs2ZHhDNmdNYVVFK21JYzJvcEwvcS81?=
 =?utf-8?B?OTh5WnUyaStvWDFiSURETXM5Z1ArL0hQVnlROHBvUTExWEl3M2Jna2Z1QjZa?=
 =?utf-8?B?Nm8xMzBOWHB4Z0ZNbXdaT0lUT1p5ays3cHFxOXpBalpuTVIwRjZXMWhjK2FZ?=
 =?utf-8?B?ZU15VXYwN0huMEYrSWsySzlpNGNTRHpuemZkVWFHOFBEckMzU1hEalBBZS94?=
 =?utf-8?B?cXNKK2VPK1NaM2pKbDhWZGtRTFpHYmxWMCtoZjIzRnVya2RYdVhtbU1hdlBl?=
 =?utf-8?B?QWN0QkJiWXZ2dXM1VzdiN096RUdhNlhHQzdLZFBhbG9Ib2ZMRE54UVRaUlUx?=
 =?utf-8?B?OUFPdExYWDR3MFhqbm1IVEc0eXcrQUwvOHNXZ2RyM1VTa1c3bGpXbHYrU2dE?=
 =?utf-8?B?dzF1blppcDhjSW8vdlZrMzZyVlJsZDlDWGdncWF5Nms4aVd4NXloOEhKdGQ0?=
 =?utf-8?B?RkQxUGZoZ21iT0VNVktEVk5JZHUrY0xsaHVsMkc1SzRmOXBjK1dFdmE1Q2pK?=
 =?utf-8?B?MG50eFVmbEpEZTVRREFWV1Z6RktFZ25WVEJLN0dwem5XdHhsZW95aG0xejdp?=
 =?utf-8?B?UGorZXNnVUJoYVZRWUpjZjdCVUFMSTl3VjExdEN3MGhtRjFENWs2dU1LZ3h5?=
 =?utf-8?B?S3lMTVlRRUpMWm9sRTcyVXZxZjBlYlIySkxPcHZrQzdGWit2V2ZUUDhkU09z?=
 =?utf-8?B?VHZ2WmZSVVNsczhuMEcya2dNMFAxUEIwYzY2L0FDaXBDVVJWZU1xMWIrUDdS?=
 =?utf-8?B?QlpVd3J2UTBFK1B6U05BdVcxZTIreXdDcTdJWkU3RWc3Z0lwVFU0YmZ4UFhC?=
 =?utf-8?B?VkorbHZ5Tk1jSkx5THU2dEo4RjZXLzZaSXRaRm1pc09ycWNFSFREZWtzSkRS?=
 =?utf-8?B?Mmp3cy9zTUREamhSUG16alVVNVJLdHZ2NXowZlNJck1kb0JKMW05QXc4TUNk?=
 =?utf-8?B?ZG10NzBRYlk4L2VzMnd6Y2xqL0gxbTBZcFF4THJtVmhGRVZLY0Y5KzZsQXpT?=
 =?utf-8?B?NDNXZE5ydnhDZnJTME8rR0pPdkNEMXpNSVB2eHJyZHpybXJmMTVsUkx5Z3Rk?=
 =?utf-8?B?Z1Q2SmpjS0F3cWdRSHYzOXN5N1QrLzRJQTVVc1BqMHdLNzY5d2tNWXZDUUtq?=
 =?utf-8?B?ZjFPeWRVemZESFAwaEZ6cmhzcUFzZUE0b2RvK3JPMUNpRzB6dFhaOFQ1NlVQ?=
 =?utf-8?B?TWxGNE5hWVZlY3VxKzN5UkR0NjF0SDh2Y252Nm1TdDE1cFpuMFNUcm5ocm5N?=
 =?utf-8?B?Zkx2TW5HYmxDY0tKTWw5OEdNNVR1cGlpbkw5bUkyeDlSUGdsbGhBdE9wcjZ0?=
 =?utf-8?B?bjlYSTJXMlpKQmU1Y0NsTjUvTjZzUGpCdTNDcnJ5N3ExK3labDJ2ajVwQ21L?=
 =?utf-8?B?ZUU0cnRESFFCM0tTMWt6Y2k1Z0pRV1ZXN0JJY1gyNFU5SHg3VDFCQys4NXkr?=
 =?utf-8?B?Q0pvNzJEZzM3YmJrb0Q2Mjlva2FJRGxjUEtzTi81SlE3NTRnb2RyVHphRDkx?=
 =?utf-8?B?Zm9xYUszWUFsV2RmbHo5KzM4N3JLVjNLaHh4aGJxNElGWjZDU0l2QlZLTnRM?=
 =?utf-8?B?SkVGMkcrTUdwQWZHcmJYMXg5TCt1NERyc2VPYjlmcjdlRHA0bFJVVXZ5Z09B?=
 =?utf-8?B?U1c1MWZDSU1hTE4vQ3dkaEZJVGxGY1VQTTlYYlNyRlo2K2htTW82SW5LQ1pk?=
 =?utf-8?B?b3V3UlZHYTliSUhJeTBTTlhrYnMwZmgrSWFSc3FHUnlKdFdackJQemtCNXFm?=
 =?utf-8?B?YW9Xbys3RFN0Tm1BejJ4K3luQVMxRXhCS3oxN3dScFo4akRzNXFQa2h2b1Fj?=
 =?utf-8?B?clE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 861f6f6d-94ab-4b49-49eb-08dd15f5438b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 12:55:30.2030 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7oqfsD+GnQx0jrQkgKnAzvgBxUWRrGzhwXiMXxM40OJrTZODbh/movd5z9mRgngz0CNwIHGVZA7p95czU+rEFfAiGNYoOMzGua1rRdZuu2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7667
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

On 12/3/24 10:47 PM, Jonas Karlman wrote:
> BootROM leave GPIO4_D6 configured as SDMMC_PWREN function and DW MMC
> driver set PWREN high in dwmci_init().
> 
> However, HW revision prior to v1.2 must pull GPIO4_D6 low to access
> sdmmc. For HW revision v1.2 the state of GPIO4_D6 has no impact.
> 
> Upstream linux-rockchip maintainer tree has merged a patch "arm64: dts:
> rockchip: Fix sdmmc access on rk3308-rock-s0 v1.1 boards" for v6.14 to
> fix this issue.
> 

Would have been nice to provide the commit hash here so we can check 
against it ourselves :)

https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/commit/?h=v6.14-armsoc/dts64&id=b89a4235eb8cdf1b4bd2f9e4ed096d8adf8994e7

Looks good otherwise,

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
