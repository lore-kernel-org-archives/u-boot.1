Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD2E5CD1284
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 13:56:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 256A588372;
	Tue,  2 Apr 2024 15:56:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="hHQS1c/k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DCEA88377; Tue,  2 Apr 2024 15:56:23 +0200 (CEST)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on070f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::70f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6668E87E9B
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 15:56:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSAarNvPHb5Y9iqQCCgPNyJTsOP+u5US3hz/lTdyG4HSd6Onvu/O+ThY/wpm3HfIpUsi6imSX2VlsYPe7WD/mD5dbntAYLYi+XwnObn85Cf9odtFRPo5VxKwyGU01Aa+aRbK4nHpPMp9IWD8cW8SJ3YAmykevMtzGuElaHngsHypHi82ME0RySTGNlpN4vUsmonbBhT9SOAFDlZTtdTYkulqBO0CmEzrHPosTa0Cmg7Na6mi2OphCslFng1595mvv7QxlG1OExkFf70ZD2PMR734BwX+rtMxSgVD/cn+vGi9dOUXZsMFl+F1b/qdRbWUU0e5wsPdxXnltTimlLw08w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1YPMHIjgB3ax1qzLdSEeJO2VGH7mP+7BMR0cjPIZ/k=;
 b=eY9mKOalNuKGlC2UCIFLNRnDs6/QiUpS34qFBwXavcNoHnMEdt9PN/rEs8Ijm2hN0jKZxGei5n+qo5wk+OCdqIUdQYYk3agGPF4DgP2sDz3X2LVdfqJYR1gNHwXH0fZPG4ztEYTTVQlIL46thyQIq0B9E6SWlzWp1VMIQp7SsnbPaVL9nwhLrReFIvger+JxE428B9kugEGHkof6h1lfqso12dg3WRX+XLhmWBtfsLCnboMO6a82Yqm4zmQxqDM4WU5XEVQYzY66H7xZlNZ/2uV4QXQ19m3YFbx4meRUYXTcKTfudUx86ZHlrV/zsIjuqT2th/ZkLPd3hb3XBWHNBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1YPMHIjgB3ax1qzLdSEeJO2VGH7mP+7BMR0cjPIZ/k=;
 b=hHQS1c/kUcz5h661S4VdCebihD/aoHWvMrAK5iT3fRMg2QxyYyh5xnZqoe37NkpAXOTJ6rMvLbXtuFP5tkGfTc1f3lqiAlsgn/SMprXjfrgB5/ebunp2YAuJZLSzMSCyB5ABNRoaGQm9W2+Tz0l2Q8aUh+6CfBHT0ZnFukNINXnyXc0/OodGm0mGcRM4Xn0TyFre+2rd/UWQZ+yTQvPQ5XxZlXjxVC4anvaA6wd7DOhn9q7O55VK7+7E4hQug2vPKWxMWNKO0eUoHoDBjAvP1B82y2ZufcLzxziBoIX7jqRdRCS0ATdMoRxzlg3aLcj5rWaIrRAXmGclUpCogGLIXw==
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AS8PR04MB8882.eurprd04.prod.outlook.com (2603:10a6:20b:42d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 13:56:19 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 13:56:19 +0000
Message-ID: <db049d01-7340-4ee6-80aa-274d7b05be00@theobroma-systems.com>
Date: Tue, 2 Apr 2024 15:56:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/31] rockchip: rk3399: Imply support for GbE PHY
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <20240331202921.262323-7-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240331202921.262323-7-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0009.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::20) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AS8PR04MB8882:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5xC11QEx5LDQstsjAhIlj2uXfp9AVQZKgBtPrrcD6INqYv6BizkwWq+kghc8epRpx7gx6HjxDDbT7yC19yr48RNKqNqqF1SeADcIA1TOHeAZ4REpDkWNA+xBGaBGzSDJ8E2JOluxA5x36eO5biI7dRq3n96FrN8xtjrSjqaxPepK7FmaIX4q4FTgZYthYHU906DjA+hEeBm8+v8fx72lepFBHfyLpTscr3GJuCUKselIJAcDUA61Q4zQ/vvGdYu1N5bWUwKMKm8Ub4ixwm7WAdWIRWNUKrDkT7cUhrFmW3fVup9fCSoJxeGYxzb0kXzJ2g4bFDWNzwh18NABf/DbMT3r/oHsFZ44jThbgJzOAuTI7YUU6FHFk2l1e2r4xhvOmIxVurAao4oDDlEKckuIAx1nXd2dFX7KFv9FDIz0xLOV6NG4C1Tw6HF/gzYcItLcEi6MiETQuscNv0REEjd9P+0jdl7jVcuv1P1lLwvv9mMMTkXW8S0QcWsCYT6UKPArGMYA30fNrIoTWo7OjB9uPxOWaQgBU5RmwiI3xZyUwxyewwvQ03AVIaP1vuezBcEFRDUiaG3L4tQcrhYQUkAk00jsOVutwVouqFuKOeocGkZEFN5vl9ZlT9GRKG3vgfk70GNDJLKgTMl3smJI/FL+LvCxkfI6qBQrGscQE7d3/O0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVBEM2dNVzJUTE45Qm5ld2tETllvQlM4UlNWemtqRHd3YUtDNmxieDJXNFVi?=
 =?utf-8?B?V0JuYWt2Z2tub0FUWWFQdnRyTmhGUk9FWWY0QXRhREQ5WUFGL1J3aE9FbHZW?=
 =?utf-8?B?SFRDKy9rN2RkWkI3VjFZRFduTjgrbDFiZ2Z3SVIreTArZTVrWXZjbVRHbmV0?=
 =?utf-8?B?ZXk2QnlMcWk5OG9zaDE5bTdtRzlMbXhZeitTcmliWjRsUzJoNVdMSTVVTUh3?=
 =?utf-8?B?UlNaaHc5ZERsZEVCVG9ZWG91bjdlVVdCVHVRQ2RySUpqR0xIRmxtN2x0Tlp3?=
 =?utf-8?B?NnBFbWh4MFNKNnpoMkNZeElyTHhoVlpKcEJ6M1RyWHRsZmRnQ0gwUXlVSlFw?=
 =?utf-8?B?cXQvTCtGRHFJWERFR0hLdFpTVEdUNmZnRE5kM0JDWXlNMWtpZVd6akIrYXVD?=
 =?utf-8?B?S3BSaDBSL0M5TTZYUGtoN1JrNW5TSGJSeldjb0t4c1pqTEtONTFBYUdySjh4?=
 =?utf-8?B?dm1Sa0VQalAwYzJ4d0Y2a1h2MFBta2FwdE9HWGNuQlNpSlBmdEdsYnpjU3pC?=
 =?utf-8?B?TGZCT3I5bVRFUzI3RnY3eklZN1BGbk9ScHVrdXJydW9OckpjaWtCejNOS3VN?=
 =?utf-8?B?MDBtMEtxeUlZVjcweE9TRmsxL0FoVk5lSWNIUnd3MTVSRjZpY00yb3I2ZFlU?=
 =?utf-8?B?RFFUN1FtVVJZUm1FUlNJblpKTERkM3RLK04xRW5oTkRQTUVLNmVSN2VIOWVx?=
 =?utf-8?B?ejVhQjU3d0pFNU5qTWhYd0JnOXluTDE2anc4eGU2bU95OThoTG9kQ21MZ2oy?=
 =?utf-8?B?OGpSK1ZJdlFqU21nTEQxTThyS1JJNEt0UGVhT2l3TzhERDVnYjVMbE9CQjVU?=
 =?utf-8?B?VmxGejA2aVZ2YkRoZVVoazllSEVyenpjQ3A2VmRFZXprOGxOMGhJWUJLWWND?=
 =?utf-8?B?TjVSUnU4N3ZpMmpzZ203TXdRWU1XRmthSkRTeG4zMEZoaUMydUgvVnZxcElH?=
 =?utf-8?B?TkkzSFhCaitFNm83aWhoVFdLbXFPRU00eThtR2VvanhETGNCRjZxbXU5MU1U?=
 =?utf-8?B?MnRvRXpwKzJGeWxZU2N5R2JQdXNlYVBnZDd6ZjUzL2w5L2VQMWZESnFrOHMw?=
 =?utf-8?B?L3RibFE2ZlkvQzliUmYzdWVoS3AxamxjZUNFZUNSK1d5NWJkRWFhWEVGT3Mr?=
 =?utf-8?B?UzVlbFdRRXp2T0REd1ZVNUwrOVpmek9KeVVsZmJSVDNSVjM2S3gxZklyOTBH?=
 =?utf-8?B?LzlaTm9VS1JGNXQvMmpTcndwVmwrVlRhWGZrRUNaalNMaERLZFl0aVBOOVNE?=
 =?utf-8?B?SFo3b0FGL3NZV2tzUnJCWitzNWJCRXdSS1BrOUc4MjVoTURRTnpPTFova1Jo?=
 =?utf-8?B?L3o4UUNDUUkwNkJ6UVVLSFFIOTNSQ0p2TllwakdJRVlkV0NLM3UzZW9STU9i?=
 =?utf-8?B?QUI2OG10RURXMFJJYjk4UFk1aFpqRkNQbEJ6TXN6MUVlUXp4eGtXNGg2UjYx?=
 =?utf-8?B?MWp6M0pjd293VHpXbzhubnU2blNTaE1BbE9pZEFsUUtVYTFVTUVTbVV4d3ZD?=
 =?utf-8?B?YkxaTUloQmhRYTNnUXNBWS9Ld3I2L1hONVpsOGNONTJUSG9XVUU3TVB6RUZP?=
 =?utf-8?B?akNtYTFGeE9DWksxeTJXeUlxNzNTak03Y2oxc1dwSnE4T09yYnJTeW5GRmFl?=
 =?utf-8?B?OVpPOXpZTDJTSGFtVWNrV0MySXg1MjhLS0QzYk83V01kNlFMODR6SmNIUE9w?=
 =?utf-8?B?MC9vVVhlZGtXbkllbHlqYWNmV2NsK0RKWkRVWGJpNmhkdmljRUpOdkRwQ08y?=
 =?utf-8?B?WkNtRGZraU1NcjdDQ0h6RW83TTkvcjVMaGhtTUhUaHZjTkNzbmFLWDFGWmxy?=
 =?utf-8?B?djRnVE1rRVRnQ3hJRnBQOWlyR283NVdrQm92ejRaRDlvcTFEbnVTS0orNXdV?=
 =?utf-8?B?UTErOW1VcUYrTjNqSWtyWkxDSUFrN2h0TTdiK25rb1ZQRWtFVWdUMnk4cTl0?=
 =?utf-8?B?YUNTRWJQRXFEbHY4dktZNnZ0cmQ4Qk9nYTgrM1puU0kxdFRHdmQyMDd3YnU5?=
 =?utf-8?B?dmM1UjJHbGFtY1BoUGwrWGF0WHEvdWFLc29ycjZkRVlhbG1ZVk1ac0k4ZFJR?=
 =?utf-8?B?RWRSSTJkK3VldnBndkxDQ0pKMFNTR3A2SDArRjJ5eTRLVWxIaVpxTkppZVNU?=
 =?utf-8?B?YjRPNFRmQ2U1S3cyK3Zrc0tibWxxY3kzcndUaSs2M09EcHMvVEpCdlpCR214?=
 =?utf-8?Q?Q2UBxxBRvoNC9VJkAC4WcW8=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2b89fc0-8d38-471f-6f41-08dc531cabc3
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 13:56:19.2659 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J2EnsR14OrB+n5EssIci0zmA540JS+TOAWMSbpTGqHoY0Z/hrJfRo7QeLUNbIv1cTpR8J1mnsUrRIA0GBFyMFiR5tNUn7alrX0mIv3Fs+nOKJJSHN9S3m9/Q8pik/Qzo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8882
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

On 3/31/24 22:28, Jonas Karlman wrote:
> Imply support for GbE PHY status parsing and configuration when support
> for onboard ethernet is enabled.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Thanks,
Quentin
