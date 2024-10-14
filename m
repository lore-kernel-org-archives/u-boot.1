Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62BD8D1625E
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 12:45:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB6A788E50;
	Mon, 14 Oct 2024 14:45:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="SuDwUFCF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E6E188E21; Mon, 14 Oct 2024 14:45:51 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::62e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68E1088F3F
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 14:45:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QVYBWa2z46jqhUbNgMLf9lU+IIKdTFQKv0m0FwKBwcNzoPEoqWw2Zz/NoXzhBas4YTWBqeXA7/rgPCxPX8vXUNFh6qbOFGZ8/xEGf7bEAO5HZOfrSZ/RPGm9dhVD/+T83m+Kw3ojqig35z4zsUyeQsjKtr2vRJPUriXmhhOAo5ISeQY9JlvG79AVxq2n5mF+VmiN/NX2HEnNH3ugnnJ+I7xu375mT/pXGSSLBentELFzrFVPcyuHyH9VfVwewdqimQ3U8Wy30zJyKbh1Ok/jQYHf31jt9FhQJd0dE2G6CZdM9Mk3iZvmdeWVE8xzVGhtCHhgjdBD/WPcBjkvToBVfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U11fQZIhbNPlYnu4w7IQ7FOWrFjIqmbkMlweIAHEBGo=;
 b=MJIlc3LU34x1Mvuy6lwquUxwxv+Ww+YEwGHgvHk3PqyUdFozAjO9Po4Z05+uVLj6VPZW8t6MoQbEYLKUx+WB2dmRKyTkVVQuo9QI6vrRz3zVlVewZMlGIiJOOrHfHD/in/Y7Redx4qUFDDRmXWy49mlVGpNj3yn3r2Z7KW61DTdVxhWSTNS+u6hmyqxaEgZ2Shaucdtn6c6PO+t9ZY3U4Aja5q3FxHxGzqQJSFtqRy4+dmnoEL5feH34IaWSTlgvBRJkYJP04q2gWX/wo5SgEBLAkcPRHFKZ2xPTu8+/qeXcstcB7PzfZmXD1UAds5Xrn5kNqQNHFo1R3ZAgxpzU5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U11fQZIhbNPlYnu4w7IQ7FOWrFjIqmbkMlweIAHEBGo=;
 b=SuDwUFCFkAHNEMDWXuvqLNVR2x60k/lTmvB91utJ2YenyhmEprmY5NnXIA3JaPcfhQz1+KW3foFqZ3vMt0//yLnNKvGIdjrzP5gCCNptVKBESbSe1ubmYUe3cyggogontcZwkhl/Rmtom/C3dFzgAvsHU5P2aN/9LOx+jy3IOOg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB8607.eurprd04.prod.outlook.com (2603:10a6:102:21a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 12:45:46 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 12:45:46 +0000
Message-ID: <ba067182-a114-4ba0-8e29-495b87293c3d@cherry.de>
Date: Mon, 14 Oct 2024 14:45:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: blkmap: Fix typo in command example
To: Ken Kurematsu <k.kurematsu@nskint.co.jp>,
 Tobias Waldekranz <tobias@waldekranz.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Masahiro Mizutani <m.mizutani@nskint.co.jp>,
 Yoshitaka Ikeda <ikeda@nskint.co.jp>
References: <TYCP286MB233485B48812E07222B95435DB6A2@TYCP286MB2334.JPNP286.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <TYCP286MB233485B48812E07222B95435DB6A2@TYCP286MB2334.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0099.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::16) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB8607:EE_
X-MS-Office365-Filtering-Correlation-Id: 44766bd8-1514-46e5-0981-08dcec4e1fad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WWNrWXZKMWRRZnYyQ3Z1MHlJbFF6QTJzYk5sUHlVOGxWKzQ0akUvQkdRRjdP?=
 =?utf-8?B?eG1XaXpYdmdIaDlVWnFkdHRqYVVZb2cvTHNXdmRQN0ZibmRJSm92TkNOb1Bz?=
 =?utf-8?B?aFhYQkJuSnNLWlZnbXR1ZHYyL3Nha21mS2FhNjFzUmVmVGtURjRMQmo1TDQ2?=
 =?utf-8?B?djBsb01UQmVZTTBHaHVhUG5nYjg3UUp0SUFZV3hkSjRtMmJnZVoxQXlOckNU?=
 =?utf-8?B?L29Uc3VUMEVsc3d0N1IvbGJ1am0vUXNJS0d3cXIyUGxROWF3cndXZEQ1MkFQ?=
 =?utf-8?B?UXhuajI4YVpRa1p1R2oyWXFEY0FJcXNvODNrb01aN3llMmUyQXZMWDRxMUJS?=
 =?utf-8?B?NjJPUlUrRlJsbERLamJMK2xkaVV3b0RUbWtIL0ZDTXBZM1I2cnVRS0E1eUJZ?=
 =?utf-8?B?VlBxOE51elZSMVAxWVcxdTFKTUNYNk1mK01BaFpUbjJDMDdOQjVRVkdLa1Bv?=
 =?utf-8?B?RSsxSzNYMmFFUlhSU3o2bDhzWXJjRkU2alNyS3kwOVpITGEwdmNOcS9LendC?=
 =?utf-8?B?R1R3dTJjWklNUlBnbGI0SlpCekRnVUhWTzBVVlNsdGw1N25uenQwUnd5V29Q?=
 =?utf-8?B?N2ZjQW1yNk12TkhhS0VzenZnOVZQMUpwWjFTbUNnbFBRdVk1UXJPbm04UUZP?=
 =?utf-8?B?bHlPZWtlOTBlWm16ekk1MjVSc0FXVGZvb2Qrc2J1RC9OMEFxQ0ljc0tjWVpw?=
 =?utf-8?B?aWxyaWwzQnYvUHgrU2Z6alBEa2dwZjJlWTA2YldWOU5QRVUwN2tkZDBUL0c0?=
 =?utf-8?B?bHVxTlBDdDBMUm1oeFpkOHlnRjU3TUpqTk56STU2bG1FVVdlaXVMOTVyR0c2?=
 =?utf-8?B?aEw1c0dWYXNKMTNRYm1QaC8rcWYxU2R6TDNYVE83YXBHeXJRczNYd1lKSzFD?=
 =?utf-8?B?UklFbUx5RGhHUThla0JxQ0xMNm9qZ2paRGdFZ1VPQU8xUXV3Y1YxUlBIanpG?=
 =?utf-8?B?YXJqbE9uTTBpaWRzVUZGSDRVYzc1OVZKUlZRSHNrdG5kR0pCNVZ0ZGIxUFA2?=
 =?utf-8?B?RVcyeDRRL2ZlUUl6L1VpVEJkUkZtZ0orM2JnbjdHQVZ5S25URnhjQWEzZ3hV?=
 =?utf-8?B?ZmFONEtjUXBickVLbno3a0Z3YjdKMmx6TzhuT1B6NFBaTm9JdlBvbXlwOW52?=
 =?utf-8?B?RER0MzZkK3FmakVWSzh3V1l4a25ib1p1SGprbk1qd2ZCR3pyVVdDdnR1aWRz?=
 =?utf-8?B?VkJaRm1iN2Vvd3ZVYU80NVJBdFdaUUsyTkNVQ2p2TWg0UmhuWnA5a3FYTVV2?=
 =?utf-8?B?cmh5QlBmRVFwQTd5OGlrZnlWVTNrRkpQQ0NpcjFPalA4eHBwV3EzVUxxbytw?=
 =?utf-8?B?QTJEOXRVVC95by9ZVDI4c05xaGFBV2RxL0dPa3YyWHFuTmN2R3p2WjdKRDha?=
 =?utf-8?B?L3JucGpBdnRIc255OEVlMll4eERjRUptR2U4MGJ4UkZZRndZU3ZVWnNQcVQ0?=
 =?utf-8?B?ck5HcG9sOUI0aFMwVjUxSm9vM2thWXV6djljb2NmNzI1M3RUQjdRNkgvMjJj?=
 =?utf-8?B?NXdlNU1uSHNZWUNaYnFJajdyaXVhNFRnalU3T1lQdDV6WXZTZTR3cW54ZEdD?=
 =?utf-8?B?ME5ZVDdCUmsraG55c2VMcjNiMWVMbTJ5YkpSYjFuWjRyN2poMjFpZjhkUDNZ?=
 =?utf-8?B?SkUvNVg0Zlp1NlgrNWV3V3NoaWw3UlJCWTVDd0NkWE95TFYwdWpBZ2Q3S3kv?=
 =?utf-8?B?YjlxYVJjQnFWUmRYbDlkSjREanJUcGwvN3dsSlVFQkJGWG84WnJVUE9BPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L243SDJmQjJwYzZsem1kb2gxS3MrdkdGL0crc0dwLzdVVWpUOTVxYXVjazBJ?=
 =?utf-8?B?NXBtNFZkWmhXUS9NRW1oT1NwdFV6c1NqTGMxUzlCdGdSc3JWbHdReDVqRlds?=
 =?utf-8?B?QzhvbjdzVVB2SFJOR1RtTk55dkZtMWNHdUl5M3EyVHIvYVo2L21xZlJsTlp2?=
 =?utf-8?B?ZitqSlZSaE9zOVlkUWp1bUFrZzM0NWNjYU5rOGZNMmlXS0tzQlhjRGQ5YkhC?=
 =?utf-8?B?ZE1lblBzb21EWmlXYTlQMjBWSmpaZHZDdUNKWGJpY25VQ1BuQm1zRGNSa2Q3?=
 =?utf-8?B?dVVneXVFK2lPYnJvUmgvckt5MnJjNjFsK3FiazZVZC9XSCtWSEFWSzFXcWFC?=
 =?utf-8?B?dVM0WHdFTGlRbFBnWS9vbW0vRk4yQUNCRVVPVmRmOGxsVEtrTnE1NFZYNGJ3?=
 =?utf-8?B?M2g4WS82b1NIZG1qbUNTY2R3L3N5L0QyaXVGUThqcnNtQjNmUDhzYldUeXZW?=
 =?utf-8?B?Z1ZybmdtKzRTSVRYK3puc2dhei9OM2owa0ZBSkE3eWhaNHcvZEZQR3NVcDg0?=
 =?utf-8?B?ZnB0MW55QjdjR2ZHMHY5TmlwcXNuazhwWG1pNUdteUxFUnpwcER2anVaMlhn?=
 =?utf-8?B?UVpHRThNM3hRL1BlbDV3a2U1cjRhM0FpQW5PbThxQzVwVk1GdVZScTYvdUtL?=
 =?utf-8?B?UXArQ0R3ME01M3VJeFJHTTl2dXlBNzFjSmd1NzFPOWQ3UnE2UzZ2dW1KQ2JN?=
 =?utf-8?B?WDJ1S0wrR1I4T3RJR2YrS2N1b05RNE1vYVBGemVDMk1ZZHJ0dFlNYVBTR2Vw?=
 =?utf-8?B?eXZkZms5MFIzSzh6SFJrU2F0UGtyRy9kaXhnYmo4ZnVvcUJOQVQ1MDZscUJB?=
 =?utf-8?B?OE8vYjVEbkRrdG9MbXRoakRYZ3Bnc3lqdFRSWXg3UWVrQ2pZSFV5cUxlVy9o?=
 =?utf-8?B?bVF2REdaWkdmZnk0V0RoRkxFY0dLM1dLVUJSblZWRk9tTVphbitmNHg1cUgr?=
 =?utf-8?B?Z1FBY3lLYzdNYXcvbWdSeW1iSXRQZmNxMlQ5Ykh6M0xSU2ZST1NmSGNTOFZy?=
 =?utf-8?B?cE0rb0FWdEYrcW5aaXU4eElDMWdJZnlEdm1CaHNSWU42dldOeEh6Z0FpZ05t?=
 =?utf-8?B?VVRkOUMvZGoybXhGZTJSc1NuNkZSRXJuMnhxWmhSOUJiZWVSM2szOXYzYlNN?=
 =?utf-8?B?c2ZidTNPVllKdWxaQmJ6alR6cUdKMVQ1Tk9EQVVOSGN3NmtOVTVvSWJLclo3?=
 =?utf-8?B?Zm1ENGszZjl5M0dDMHZGemJRZnMvc3RzOHlJSkc0YWFyYXhQdDRnRzA2RmVw?=
 =?utf-8?B?MXBRazlBZDFKa1ZaK3FvRlQzcG9peDN2a093dFFGMWQ4YzJ2QklRbERndnFW?=
 =?utf-8?B?azBtTjB6N0svNVZVeHJHRStXNEZPNXIva1pUbVVHcmxJU3FhbVZIU1QyZnZa?=
 =?utf-8?B?TDhGTlhLNVByR1hJZGgxcXBUOUxqZC9EdGg3WnhLbm5td1U0eFZLMjJHeTFZ?=
 =?utf-8?B?eUdHWDRFWWUwTUtWbld0eEt4STJtQmYrVVQ4NUtCWUIvVUFTNjhhY2EveEph?=
 =?utf-8?B?Mk5URTFVdmhlblZqclpoYmM5V3JGYjNMZml5MlVHOHpuTTFvUlhadUswTWEv?=
 =?utf-8?B?cnhTMWFPUWJMSVRiQmlXMkk5cnl2eVc2LytwTkFCNHJwWHVtUXpWMFRINWUw?=
 =?utf-8?B?YlRsZFhpY2d5eHFtbEZ0VTZnU2FnTGlrSWdQQmE2Vy9UWXZ1YkJBSE1JRTVp?=
 =?utf-8?B?RWtBQk9WYXc2ZWQ4aERXVDNWdXlHckh0Q1p0dFlHNDhrT2tDc044V082TGtH?=
 =?utf-8?B?b3VFMXdvRTgycU5wOTkwUWU3U2tYV2REYldxRGtrTk9kejBtdjlUUk9veU1s?=
 =?utf-8?B?Mm56SlVYSTRMbU5tWFJTM0RrQVNOQXNtWTA5cnVvM3lQQ0orbUhVUnJSZlJT?=
 =?utf-8?B?SXdFbzVxd1dsNk1kdHdZcVpvbTI4ZDREekkwcTFiRzhseFlzZFpTb1hCcS92?=
 =?utf-8?B?OTNsTDIrYmthb1c4ZEZHMG9PbTcwRUZHUlRHellDZ0hCVldnMXozc21TVWFh?=
 =?utf-8?B?QkdMVk5mU0Z2cHlNVWxzREtkK3FyU1BSNE01Zmo4ODZkU2tvUHBuMy9MZExH?=
 =?utf-8?B?WEJ5TVNCa3BtVkxTTnlGeGFVd3dBWFE2WFJoU0ZjNzJKcmw1cXloREtUSnhX?=
 =?utf-8?Q?2kgsegr2v9JrRCa9B+SnuX8qm?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 44766bd8-1514-46e5-0981-08dcec4e1fad
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 12:45:46.4396 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LXzaTtB4CYEND16upN3nJ9X3M5fPC+6V9CsigSwPHPBUlcVI1u9YpmZQ5pBu9bC4RNzwJ7Vu9P00+v7yb8w12d5UU39cON+Jcza8YQcTAEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8607
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

Hi Ken,

On 9/26/24 11:26 AM, Ken Kurematsu wrote:
> [You don't often get email from k.kurematsu@nskint.co.jp. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Fixed a variable that was incorrect during the calculation of fileblks.
> 
> Signed-off-by: Ken Kurematsu <k.kurematsu@nskint.co.jp>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
