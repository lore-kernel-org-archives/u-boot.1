Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFFDCC49EA1
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 13:24:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C0128811C;
	Tue,  6 Aug 2024 15:24:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="A4lMBFKT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA76D882EF; Tue,  6 Aug 2024 15:24:28 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::613])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE690880A5
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 15:24:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJ9gnCDyEo603R1CM7XS9QegPJ3/Bex3fBHMHc685HWIqgg6sexrXW1dmf9n3zOkUIkM/OFnHKokrHgftDGoUqOwYMcRHHEGa4JsE1DSZhIi10ZO3NGgj6LdVyjfLfsad/ZRpvtN+P9SBHr3bW6KEKTP966Z8luaOZUkrIPwtOskYpoCC4gmDI9KHJ7Ksva02WM1uZwQnj+dgWy82LE5OoCoIlxzjE/pjyIPTkeNDUBRs5BKcik0ziHs9F68bOTASgdvGBE8g16FteCuLE50WpP5unEmYYzSSUtFOABp1t75LnUjLJUPM5TED8SoJVDjLQN/klSyXu/JAoCVmCwKfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=np39xe+jnxEvqV0wtbkHuxw7C2cfqXBjiWsH6g1AR20=;
 b=xQC3hwziaY7QAatJwGewys863KNI07finyAgHlBdPOBS1WDixTV5Uz+V95d99VtMWS0Y2xvc/GfsaUrakRrlR6VKPU8Ce0tPZawMiorYEfWEBfZ3xm2nFBZPtCMrWmS7B8zNdLYNJxBjpkpgsCKBN6ofE3yjvMQ6ETwky744RcDKgXrp3OKy2HWg3B0tgQQmEYhUfJArlDFT46yUd2qh5cnRXnbiaQHZbOYY7bp7x5Sxszqle9C8hrCedpeJN3hTNj891/Zxr/NVWTTGnBEQh+zzIqz41j9pP4WggTpXRlkhwhpOpEPuCZKgsutzxNne/t69fxaQHDKTOgdaZHic2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=np39xe+jnxEvqV0wtbkHuxw7C2cfqXBjiWsH6g1AR20=;
 b=A4lMBFKTGuHSFSGvc6Jy1WWtC9uWQQkfwi9L4EAfrQD6ZMzA3Xwt1yK+1cinvgnCYTkWvKY+k+lKyBv6QMqBUJG5dsgNuf503XkLn6HvRF/QtIDEx2rJYxuP6o5fiXepXaPuhhJ9+l5aPrWXYyxa3ne3sbUlQeO3vnTK8lzuAEM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB9PR04MB9791.eurprd04.prod.outlook.com (2603:10a6:10:4ce::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 13:24:17 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7849.008; Tue, 6 Aug 2024
 13:24:17 +0000
Message-ID: <f21f478b-87ef-4074-84f3-3738cac3dda1@cherry.de>
Date: Tue, 6 Aug 2024 15:24:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/14] spl: Remove remaining #ifdef in
 spl_parse_image_header()
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>
References: <20240721152600.3212917-1-sjg@chromium.org>
 <20240721152600.3212917-5-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240721152600.3212917-5-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0319.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:87::12) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB9PR04MB9791:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f5ed8d5-a6e2-42ec-b7d3-08dcb61b12ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MHF2UU9wNmg0cXdYTERQRGdaNWRrZFFkbUduTUtyMnE2MFExNXppZTgyeWJj?=
 =?utf-8?B?OGlGckcvSGQ0Z2s2dCt0Yk9zWFpwWjZ5ZzRvdmtXcXN3NFVTdWxtSWhyZlY4?=
 =?utf-8?B?TnFoQnEvY252T01CZnN0aW1VbzliZWhtTjVqc2RqVi9yTk1QVWxLU0NGQUk5?=
 =?utf-8?B?emczdDlrTmhIUWUycWVzK3dJbnB3RUE4WXFXRnBWVVYzdXN4Z1lSNkwzc2xS?=
 =?utf-8?B?c2lFYUV2NlIxTE84Q0V6MWZNWThHZ1gyYTdOaE9uSE1yVXJQVm5JNG8zT0Rm?=
 =?utf-8?B?cWxXNTMvazZXcjJRL1lQanVaaXFHa3NUNEhSN3ZVa3pZK0UzdlFqQkdaVy9E?=
 =?utf-8?B?ajVlWHpmVUlQR0dnQi9ETlM3clJSekRNT283MEo0eXMwVktmeEErNkdHOWVx?=
 =?utf-8?B?bUZCNlMyeGF5WWhaOTNSaDhXaTBabXJHa0VTSlZvZjlhcmdPNm1wUDF4ZUxO?=
 =?utf-8?B?RDJuK1pCVjgyQ1FJZ2I3OVM4NzVOYWtsRnA2dWVTS1NhUnVhb1lvR21mSkc5?=
 =?utf-8?B?N0I3K3E0SXd3RUp4ZTIrVERhT2NRaXdGZEsyQnhmNm1oVVU2UnRyN1dHWGRt?=
 =?utf-8?B?QXJhREJNbTg3N1hSbnQzYTNaYzZjSm9na3hvVzlHRmZnb1haNFFtRTdJblRt?=
 =?utf-8?B?NDgwNzF2Y0xiZkdRc0hmTTY2Szk0bzN5bWZkb1c4azBadWRXenJ1SVNwcVNT?=
 =?utf-8?B?Ti8wdENGSnBNYVV1YkViYmxZdjlKYks4a1RWNlpDUXFDNENBVi9Ib1pSSzdO?=
 =?utf-8?B?R2tTdTlUWEN6Q2craWQ0UG9tWW5IM2dqRGZBQUMreFZTd2pERlRFVjcrU0FW?=
 =?utf-8?B?YnBQZElOdkFEWGVjSlVicURnemlaZWVlcXFTUWFSaUx5enZlZDFVMmduQm9V?=
 =?utf-8?B?OVJjZjQ3YTIzcG9RNVJENEJlU0M4Q2JVbENuQ2pTa1BpaGpnaWJ5Tk5DQlhk?=
 =?utf-8?B?cGNzY2pia1cwVmpuWE84d2xrZGF2a0dtdFFrdXZhWUUxMmR3VDVJR1B4TkQr?=
 =?utf-8?B?WXFuTEN6Z25XVzZteTQrY01sWlJYVW0vcnBsUUN1SVZCSHpHb25OWVd5VzJP?=
 =?utf-8?B?RWY5T1lwZmU2Smh0d0o5TVVCT2ZBbGtpM2s2YXlsZjZjTUl2cUFnME5YS0E5?=
 =?utf-8?B?ZmxQK1Z6d0UxREc0dnpvVmpoVVZJaDc1dTJ3T3kwbkk1NGxPYWs5dzZnallT?=
 =?utf-8?B?bTArTzdHUUJNMkZ1MGdNL2F1bzIxWW1xTTNvcjlOYm9iS0ZrbCs3R3pyY3J0?=
 =?utf-8?B?SlBIc203b1Q2QXo1YmJFRjFDWDV5N2lHZ05FOTVyT1FxVlIyZ0gwQTVsU2gz?=
 =?utf-8?B?ckdPbDBYRkQwaVIreGJzanJjb1NsZWdLTHRPb0czU29HSmxKTWN2UzVHVXgx?=
 =?utf-8?B?a0pqaG9sazZra3pFUXVZNG9YRUIzMGxXWEJlYTlMREkxZGR3aDB0ZnlwY2Rn?=
 =?utf-8?B?bWtqMkh4eUNERCt6L3VIR3RITy83UDFTaEE5NWd6VG9zZHVNOW9ud3MyYXFn?=
 =?utf-8?B?MGNBTXZsWHlKUlRLTWpjLzJ1UEs2RW9Ka3k3Y29kcFJHMktZS00zalFxT0hY?=
 =?utf-8?B?eHpQWUNBekZPQ0xhcVphbVk3VmgyVHBTT1Q2eW5WTmQrR3lQczBrdVI1dGlX?=
 =?utf-8?B?RjFYQlVLVDlQQmp4VEhwek85ZkFBUDF4N1J2c2hQT1J1ejZoL0RGRzFwNTZq?=
 =?utf-8?B?YzZSSXlZTUQ5WG50aVZOaHJGMEFMdGN1V01YUkZNQ2NGZ1RrU0IwUEFMZDRw?=
 =?utf-8?B?K2w0d0ZmMllFcmlEZHViSTd2cEMrUEdUME80RFVPRzhNUFlxTXVDMmhDRTZK?=
 =?utf-8?B?ei9XZnhCMW1INU5KQmRRUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnExQklReHJDUzVIdzJldk9rbHFqR0FGOC9aVkk4d3BWWTR5ZmkxVThycS9j?=
 =?utf-8?B?SUo1V3FrQWZqOHBHTWRVTWhSMVE3N2psRkhpV2IyTUs5aGVKaVFFckQ5dlQ3?=
 =?utf-8?B?NXR0U3F2Uy9NTWFlYTNTWk5HU2VNUWcrc3dnWDJlaHFQNVlNTVByZGNvakoy?=
 =?utf-8?B?VVRGeldmSUNJdzZEMmtxN3AzZm5YKzl1Skg0a1FmY1ZOYjJJTExMc0MyM1g3?=
 =?utf-8?B?ZlViaUtOcmVMOWNZQjFnVERCMzlXWXZGeEdkRUptcU5HenpkNk9KMkc4dHBl?=
 =?utf-8?B?bVY0ZVpzR0cvTDgzM2Z3MlFJdFJoc0F3enJVV3pyOC9NL0d2QUM2cGVwLzRp?=
 =?utf-8?B?ajkxMWY3NkNSOUNUbjZwaU8zYWpEdHpFcFhVQWloVWZyWWhmaWdaazVxYy8x?=
 =?utf-8?B?dlRuT0ZBcHhyRHRNdGp4NzcxUjVpYTNzQWFoNWp3YXBiQllaWkRrUm5jTkpJ?=
 =?utf-8?B?dXhXUEhZVWRIZHdoNFh5YkFhL2FsTG9vbDdQSWZxMU9nTjFONmcxMjc5SWZQ?=
 =?utf-8?B?WmJsZ2Z1d3RQYXlWUFBlV1ovZVIxMXd2ZDFZMDlkUXJSRVltSnVRdi8rUkdx?=
 =?utf-8?B?TWdMQnNVRTdNSzdxVEcyYUNiKzZUZGhCbVg2c3JKeFFLV0xtZzZWeGhPYm90?=
 =?utf-8?B?dWk4bWdrY21IWUtVcll0clF5U2MwS0REdU5wS1lmRFF0aTd5QzRWMk9FMDJL?=
 =?utf-8?B?UUZINWpXUXJtRXVmVmkzbEw5T1JrWUNNcC9QNnJRZ2pnOFlUbFEyZm9iSFhy?=
 =?utf-8?B?ZGlLK2dKcVFNZTB5dzRWUTJzaGdZNHdNSzZYOGJ1QkQ1bkMwcTNqbTgzSUEx?=
 =?utf-8?B?dGY0aWY1VHJ2bitLamREYVRLYjRUVlFrallnV3pzckNKTnpIdkhuSjZvMEo0?=
 =?utf-8?B?QUc3cXFYTXhpZzRpU3Q1YTIrZHA4bFBlbndveFJzR1ZBS0ZKcHNPeUlnNnR0?=
 =?utf-8?B?YVlDanFhNS9VV0RnZTBJcGd0UjZiWnlia3RkNFl3c25tNzhJSkI5aWZGT1du?=
 =?utf-8?B?bE5McmN0VTc3dWFsc0tUK2RaVzlvS0crZklNaS85L1M5UFlQSEp4OGswb0Fa?=
 =?utf-8?B?bzlyR0dEekxrUW1GVUZDaGJGUnRGMGl5Q3l3dWIwT2ViQ0RBemdzcVZXdWYx?=
 =?utf-8?B?VjFpeW1pTGd6MzVqcjcyVlVITStGL2ZVQllEd210RUJKUEh1NXlCQmsvOWVt?=
 =?utf-8?B?aldYVUphRTR5bzBiYllQdnNDb1o1Wmw1L0RaWFh6SFlXb0VMVDc3VVpETDBm?=
 =?utf-8?B?dUQzcGxDOGxTaTJFSVdraCtPb1owY0IrWEpkRmRCbEJYR1lldU1obXZONjZU?=
 =?utf-8?B?K3dhejEzNGFEcm1JNjBSZEZ0eGdYUVJ6VkVqM3RRZ0hVSHJ6SDRITjFnWHNt?=
 =?utf-8?B?dTB1U25tSWNhUmw0QWpIWmFCWmRSN21peG44S3NXd3k3M3VJN2NXOGtVSnZI?=
 =?utf-8?B?dmRUUkpzWkJtaEFET2VTNXZaQkEwWHZQWGM4bE5GRlM4WWcxbU1ETUtBUm8r?=
 =?utf-8?B?SzNaYXlSbytHSGlTMzc2Z1hmM0VDOUluWThDWUMzbjJ4VjgyQU16MVRnYTRt?=
 =?utf-8?B?bytNcjUwQzVDaTVoanZhOGlsdlplemxnVS9ERWFWbEpwQm03ZzY5d040T1Ja?=
 =?utf-8?B?Yyt5M1QvNXA4eWdQdDEwcFl4S2dxRXdqVHhiSTNxdzVQVUJJeUg4N3pxeW0r?=
 =?utf-8?B?R1M2UDdIUGVHVWdTWnE3TWxreHBVOXg4ZXBDUlE3VG1NOEVsVVN3dWg4ZU1U?=
 =?utf-8?B?bWlzdzRWd3hacVJSc1ZBSDVYRHBoclBFYW5zMnZDdW1ETUlFQTAvNjBQdE4x?=
 =?utf-8?B?WjZ5RC9YMEg4SWl3dHpUY2dyNXBBZlFnek9Kc3N4ZG94SGFPZXVUaWVnQ3N3?=
 =?utf-8?B?QVF1Qmw4a0ZzNTlXM3d6MzFxSG9yRHZoVW1UQUkxSGpGV245VWU3czRYQkFm?=
 =?utf-8?B?R1B0VHc1SHo0THRDTEloYldNUnVtbzEwVWpuU0krT0hrQlJtVUJmbkloSzlD?=
 =?utf-8?B?cURzZEJzaXRHSE5MRk1wRjBySDdwNWhBTUpHd2FtUTVITE9GNXdOcW1MNmF4?=
 =?utf-8?B?K1A5VkF3TER6c1BKZllNaFlqa2d1Tjh1UGVJZGdsVFViVHhOMWQwV000a0py?=
 =?utf-8?B?M2EvY083RU5JQU5ieTZkTi9OVHZKWGJVWDNKQXowUEJsVkM4eVB4QnFnOHJh?=
 =?utf-8?B?TlE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f5ed8d5-a6e2-42ec-b7d3-08dcb61b12ce
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 13:24:17.6660 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hvAoXqSuphSUll2fGMmePkGne8hqapw3MdbiV+ltDKUWHpExYZbybsPvJL5IXH7yuP1wb+L2iXkmTpgLvqm5OZmFXe19RDNSzK2DrTJXlu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9791
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

On 7/21/24 5:25 PM, Simon Glass wrote:
> Define spl_set_header_raw_uboot() always so we can drop the last #ifdef
> in this function.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Sean Anderson <seanga2@gmail.com>
> ---
> 
> Changes in v2:
> - Avoid changing comment
> 
>   common/spl/spl.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/common/spl/spl.c b/common/spl/spl.c
> index 02567e766f1..30ff1e6f7d7 100644
> --- a/common/spl/spl.c
> +++ b/common/spl/spl.c
> @@ -245,7 +245,6 @@ __weak struct legacy_img_hdr *spl_get_load_buffer(ssize_t offset, size_t size)
>   	return map_sysmem(CONFIG_TEXT_BASE + offset, 0);
>   }
>   
> -#ifdef CONFIG_SPL_RAW_IMAGE_SUPPORT
>   void spl_set_header_raw_uboot(struct spl_image_info *spl_image)
>   {
>   	ulong u_boot_pos = spl_get_image_pos();
> @@ -273,7 +272,6 @@ void spl_set_header_raw_uboot(struct spl_image_info *spl_image)
>   	spl_image->os = IH_OS_U_BOOT;
>   	spl_image->name = "U-Boot";
>   }
> -#endif

I assume this doesn't add too much to the SPL in terms of size? 
Otherwise we could just define an empty function when 
CONFIG_SPL_RAW_IMAGE_SUPPORT isn't defined to avoid bloating the SPL?

>   
>   __weak int spl_parse_board_header(struct spl_image_info *spl_image,
>   				  const struct spl_boot_device *bootdev,
> @@ -357,16 +355,16 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
>   				    sizeof(*header)))
>   		return 0;
>   
> -#ifdef CONFIG_SPL_RAW_IMAGE_SUPPORT
> +	if (IS_ENABLED(CONFIG_SPL_RAW_IMAGE_SUPPORT)) {
>   		/* Signature not found - assume u-boot.bin */
>   		debug("mkimage signature not found - ih_magic = %x\n",
> -			header->ih_magic);
> +		      header->ih_magic);
>   		spl_set_header_raw_uboot(spl_image);

We could return 0 here.......

> -#else
> +	} else {

.... to avoid here the else whose last instruction is returning -EINVAL.

In any case,
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
