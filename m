Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C2DEC1459
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 14:40:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36198839DF;
	Tue,  3 Mar 2026 15:40:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ku4V7O13";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 538FC83F59; Tue,  3 Mar 2026 15:40:16 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6971D838BB
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 15:40:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yOu6dNz8kTmOQ/IdGAZxGgMDv28fhXNmgf+6js75x90rxmN1teS4gYTFhrq1Tb8CocQDWH5FSVACg/L3Rwg8gKBKZ/cK//Y+df3iiGLtK28O10oWYn79cYwZc/B1wXlf63vv6yFWEjefymk/mTHbMg0GaQ1j19/ESKNa8eu+MfaMY6WwYfDvae+F0nRJ4mqE9oT8gsLNbbh8hbctqbXZ8YeWOvVUAYEKPt690nI2y4jNbEIN+OmcYhA8KBfTeTjcP9o32z8JT4HVV7Hp4iPmCX+LO7Nn9EwEotysyERYZcaYu8S3QgxlJrg8RmKF6rFiWYyVbGBdwbRSWYWLAkHZhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YWdFLHcCzNugKM+/CYbI/DkUgiramo7fmdb4m384yfE=;
 b=VBQAZDE6WREIJxELxDJI+pErlPtoNrBUxV9sbLZ23QYdPquAet6q75c0NhZkgCNYjxYkRDb4dzeWPmZjj+9HMLdN/FKdCLfLhRijlSHlcfygShSDfly8KDGW4ppdoN4S85y3tchO+l4WLnHswWeJpb/ZXYzPxCcRwMxvRL42WRo2mII16eeNI76Hn+FtaQiGhg/oWoLzQ4U/UXe4+1qW7VMBpHwfJAEheGPK+PKE0hz279OoofIzwGgKZ4POn9ifGO8G+49kOMNRqrzGjyM69asjnx2njTfKMXWVDskDpxe/Li63pFgCZ6KZvRCE8ltD2wA37HuwohuQmkyBgqlccg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWdFLHcCzNugKM+/CYbI/DkUgiramo7fmdb4m384yfE=;
 b=ku4V7O135ll5yBb8zvJh6U8FaQGsPThhdoO0FyMj1xNZ9h8dninu07yEp/8Wd9UjNxlxjOg3fE7gtZ6+rQMco5JlcNzjQU/Y7n34O6fNG7inKw8e9fLztS2jx/Zoy+YL4SluXd/W1L7/vWbXeCBNKPvVABh7rVVhheDDRSbsaBM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by VI0PR04MB10290.eurprd04.prod.outlook.com (2603:10a6:800:244::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Tue, 3 Mar
 2026 14:40:09 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 14:40:09 +0000
Message-ID: <8ad0f894-45b7-44d1-ad49-63c44b448221@cherry.de>
Date: Tue, 3 Mar 2026 15:40:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 10/16] binman: test: Move mkimage test files to
 test/mkimage/
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Yannic Moog <y.moog@phytec.de>
References: <20260226234802.345968-1-sjg@chromium.org>
 <20260226234802.345968-11-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260226234802.345968-11-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0148.eurprd07.prod.outlook.com
 (2603:10a6:802:16::35) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|VI0PR04MB10290:EE_
X-MS-Office365-Filtering-Correlation-Id: fe573993-8865-4f86-1ef4-08de7932c51a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: RZZ9M/16lYP6FV4UdLEKlRgAmnK69DBD+AWGdbw7JOjdf2U4vzXInxV99wU9WtXUcaJyBJei7qyRoKF52Ir31MREgZS2TcfX0/gEUoWPvWxtYwq4CwpCE67BxUSqtcsOUMF8SI2HHkd4UgtDLcELUoBDnzbez40yolMcWPGgHWR/hKlNp6jDEiYGxZIfFR0yi3bkjYyE0qAPyS+dAd++0H/5kxnel50e5yTG+5goNRXmSCiszkuxQDr5gSiepdEAwoZ/kJmZNP3A8o53+ZuR8R0imATrof22K5JwQv1st1IVryKXaP24C8gjsJn+LIbtu9EOtnWep+eBgjHWA/Ys5vrs8nFB2DctvzqUqacJVj9T9TzjNHcnkpNLIBTh58jxxdcmbggnYC+EXRfI9R4IA7xGBVfYlRblz+sILplCztMCaSxG0o+rxHbaTMWb2j1s4Dei20cOROlvzstH1+xFTwUN1BYMmI/+UEyJirAxZVkE/W8fLeQuW3J6EJp3HEUmzQWoqQ3ZBWgz8qriTmKhkMoL0d8sQXLQbtKITq6weUIk5GIIfe21m/mK2FHVd41JyYoQ6rVkWKQmYTU4EuXVta0U9Sm4eVhl8ITQPYDOmGQnf8rdBXvrz9pfZ5UHiZlZ/pFIQGmcesKrGtZxYM1BfVdvpS9ovwrsaKRhEcaNAb73SVqiFaWAJrXTLElXagiF49FT4UFUbhfWIYB1mfKWPeoJEsWzDykdkFAIPXau1ek=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3RMY0hkdC9ZOSt5NWJ5bzJzeGx1Rzljb2JFNGhtRWJjNVl1VTUvWFo2amcx?=
 =?utf-8?B?bll4aFhVQWZXdVdwK1JJcUpQMVM2ZURyb3BGOUJNUndybFBCMHhXcVRsSkhj?=
 =?utf-8?B?T3VtQS9lS2ZQZklld3VyS1Z2dVk4cnpEb3Q1ZThUYk9NWjFneUJTSDBIYWVR?=
 =?utf-8?B?VlFZRFh4NFp1S05nMmFCUlpxemdGOVNDNVhqNUFiNytKTzYvM091c0UwWkxs?=
 =?utf-8?B?WHJ4aWFqTnRrdVNRcE1MdVRncDBDMEtVWWVaQVI2UDNrc0hsdlFoc1VPNEVr?=
 =?utf-8?B?clZlV29SWU4vVUNySTMwMCt3bkdRN3g4YjJNNlFxSFF3Yk5yZUhuOVhCSXht?=
 =?utf-8?B?Q0hEdjR3US9WRUdxSnZXUnJjL2lDZnBwVTg5by8yallFc1ZEQWdIZ2thandW?=
 =?utf-8?B?QU5aOXdoMUN3RU1FbGYzSE5ZZ1NvZXBaaUk5NzhXcUZWQlpLODNOR2NTMUxq?=
 =?utf-8?B?c0VHS0JEYmRGKy9SMlkvNzF4WVVuTUlmbjF2MW0rdkxpV1FLcUs4ZTdlZFMv?=
 =?utf-8?B?dGc4Y2JZMGRoQXNiUjMzRkl3dFFSbUhZZlJsS2Z1Z3RhclVNc0FoSFJYdXlM?=
 =?utf-8?B?dXdidWJwaVRsSXpRdFFmZlZsMEx6WnN0aktycXVoU1dLZ0xkZG9mWVh0bWZw?=
 =?utf-8?B?UXZ1NzFiaUNWdDNpak94YXZibzRhd3lsUzNtVURBajNrQmNqUUlKM1ZDeG5i?=
 =?utf-8?B?a1lXM0x4b2R6N3lqOUlZVlQwSlRNV0hQc0k2M0dPM0FDNXJHMVFXWis0Yjgr?=
 =?utf-8?B?eVB6ZzRRQWNMMzU4cVRSYlc3cVBTN2lCcG5kSFUyZGdoS1FITlJnWndDMWZr?=
 =?utf-8?B?dnNBY1hlSGpmMlNwU1I0eVdReHB0UkpKcGJTUmFXa1lLU21SR1V6UW1GNlZJ?=
 =?utf-8?B?NDJMR2dXbFl2eTR1OERZMzQ5UDZ5eFl1bndINU5RclZRaXNiTUNpQm4vUStP?=
 =?utf-8?B?MVc3eEIwZzRPYldmZkJnZjMxYzUrTVlrcThHbENyNmlDV3NBVUlDMm11bmd1?=
 =?utf-8?B?V3hUK3hLUUtLcmVJVldLL3VJenRWdmlZcDYvSjc1dGVwYnR0ZWxHcDdKYmg1?=
 =?utf-8?B?cGdXa3gvL3p3QW00SjMrS3g5eUZVOFNvVTMxLzE1ZHFtNC9PTFM3Rm9ySWxv?=
 =?utf-8?B?NG1BVitob1RFQi9lZVpUaDFnajJkcmM5TG1XM28xZEQ5UVlJOW1EMXlMUit4?=
 =?utf-8?B?d1FuRWZkWDBCZHF3dmxmNFNxNkh1L2o5Njd5Q0NBcC81WVdEcHJPYWlOc2VN?=
 =?utf-8?B?QXpBU1hpR01yUGVyV3djL2MrOGFrS2poVTdndjhLREJOaVVYTzJabllMSytN?=
 =?utf-8?B?amxRcng5VWdzOFVWUk0zMTN2Y0g1YjdjVmJ2QWlyL2FJcTJ4VHd5SVhtcUFU?=
 =?utf-8?B?UkdvTGorZ2MxRU5GS1loazBXbjFOT0t5blFwZ2Z3bXE5RklYbDZZQzMvS3Iv?=
 =?utf-8?B?U0tySm4wOE9uYVdKZGxqVUYvSUlzejl3WnlZcW9Hc3hkU3N5OUF5SmF2cW9Q?=
 =?utf-8?B?YWYyT0VFNm4yc2ROQm5mVU1qZzRXMDc4d1pQdEFnWEFLOFdLdjNKc1pzQU56?=
 =?utf-8?B?YXdqM3VlK01odkZMNGt3Q2N2UGhvQmgyTHRxenZrTHpEL0krdER3TGNPZmVs?=
 =?utf-8?B?RzVYTjNaTlNvVk1YNWo1ZTExaGhWWEw4TGhSa2F1UGlNcUZ3QVBsYlFYdm1Y?=
 =?utf-8?B?VXliTGxMUEJFdm5zU1pQc3RENjlKNktjTVRTRHhJbndOb2h3YzRtOXQyRUd3?=
 =?utf-8?B?TGJ5TFMyK2dEN3JIb0loMjhSYnh1VjQ0b1R6UmJEMUxCSm1iR1h5M3Q4NWNM?=
 =?utf-8?B?Z3ZJTVhCcHNsRmRvVWlPYngvS3ZHOU1wSTJQQkVMSVlDUUpubDlnYUlWNEZz?=
 =?utf-8?B?dnZzMmJWZW9TVmdLU0xTTEJ3R2VLNkh6MUdDOENsS3lQdElDTFNubm1vdlRy?=
 =?utf-8?B?T3laV0lBbGd0WFVCYlBienJOemVNOGRNQXZCaXd5T1pSSFA5U2xnT1h5Y3lW?=
 =?utf-8?B?bTVtTFF3UUZLUUI5aGZiZXBRTGRla1RySyt5bnpnSktRbm0zMUE0a2lrWHZ1?=
 =?utf-8?B?RVZpWWRlSkdveXgzQ0ZKRGl1WEw5S21XdUhmTGpLNW5zeGVjS1R3eHorMVF0?=
 =?utf-8?B?V0pnS3pDK2JYLzZFdVgxdERtQmFTMThQT0gxY1Y3Y1UzdDZMSi9OanBaVGZp?=
 =?utf-8?B?RkxERUxDRGZGckZRTTNKQ2FaUHlZalc4YVYrNXluYXZzTzlCdmkxbFZpRGZ4?=
 =?utf-8?B?ajNzdDdyU3l3NERDZjBmVGRMZ0RpM2hQSTFteEVnYWZNaTJTL3R4QzVHTWl6?=
 =?utf-8?B?MnRLNFlHbGp6RFM4SU03dndXTWlkOG5mYW5HM3kzNzlldUJORFpqQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: fe573993-8865-4f86-1ef4-08de7932c51a
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 14:40:09.6980 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cTtGDeugtip9Lpawsf571NPwiIjUbp09LyOKMiL3rOdDycnsdAWqVXuHF8S391aAuLKvehD8WJscCk4+5S/kjhMZwa2W8KyQh/fTJFMkhtU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10290
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

Hi Simon,

On 2/27/26 12:47 AM, Simon Glass wrote:
> From: Simon Glass <simon.glass@canonical.com>
> 
> Move about a dozen test files for mkimage entries into a mkimage/
> subdirectory. Drop the numeric prefixes and the redundant mkimage_
> filename prefix, and update all references.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
