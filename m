Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B60FD1812A
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 15:37:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96EB288DEE;
	Mon, 14 Oct 2024 17:37:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="WRfiIF4s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06BDB88DC7; Mon, 14 Oct 2024 17:37:51 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::61f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C33488FED
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 17:37:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=crLo7jF2z+M+oE98uL5rxgw+r2t4IIAKKc4P1GptrKs6oanlurnWlfmWJUeRUA4IIaHmhKg7H6hLLVi5BXISziM2L5VkgQsJAySxbDCCM4dgWcxXqjq2l4PDzah3KinKUAtyBy6yc5Orsv3fyD+hJz/NHoI3ZX878zAIrZiZYxsBpwhanlzzK2aT2rFLmqg3rK+0PbcXbC24t40O/8ewejwvr0XnEytQmwR0MH1EWG8PSoWt+FCUMaFqyTq+8SEnvijUKupQ6Tv2fEYdFUCjt054ypMSW4zUsEUkHxE84qsirQ9LSbTouMQSx8a4Gge86AhLW9fUrlpoVjVfoTn4GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CiB2FXyjV5qnogfaKzAB8hphJlSIeIihExv4VJ94b/U=;
 b=GLAfOJS+IajTklSxzOqRBYlqLBD7AXSRIkmiZh4BxbEXiOY781aJqfvQljCBKNZzPftQP7+JhjOoruRfaxYKBClD2qd5sZaaQd/w+VyfemwRw5WoQgqeFOWHe5vjtw1hEmMkSWO1vKzQRxY8j1WeAs5sp7s9WAl+B9jOjuqbCedNRqmJFodpdxDIT/MRLMLRjqcM7bVLLEARNnUcAWl167HjEk5qT5B29n7ZVM4T+gdNg3pKSI4xn43XbccRnwHHffQKA6v7j9AhQfb0IamPheEmQvmIVaROgQFXe70OEMY/n2OwVmyefOh6CHqYcTDmwRnA0omVFyTypiwT2WwD4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CiB2FXyjV5qnogfaKzAB8hphJlSIeIihExv4VJ94b/U=;
 b=WRfiIF4sMv2Xqc7hof1S72mpvy+Clmu9poS2qitOR+3GFxFeednjVex3Z/L463VV7h8CVliORNv9D9LXZkNThcjyKsDRUIq+f3LlB7k5OatEq3EajY2h3Rx3W0eKiKtJpwZ0xAUv/mJCTy2P9x+RKU0GWyGC1d/GMqCWv65A/Cs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU4PR04MB10718.eurprd04.prod.outlook.com (2603:10a6:10:58f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 15:22:17 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 15:22:17 +0000
Message-ID: <48de838f-dd40-403d-b062-083e06e7cdac@cherry.de>
Date: Mon, 14 Oct 2024 17:22:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] boot: type boormethod
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20241008204614.56215-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241008204614.56215-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0360.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::13) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU4PR04MB10718:EE_
X-MS-Office365-Filtering-Correlation-Id: 73f673b5-5551-472d-b1e9-08dcec63fd33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dXJXSDd6bjdQZ1ZKMUhkV2psZXFKVW5GQmRwOUFPMzRpSWpkdllzVEt4WlJC?=
 =?utf-8?B?T2tiWloyQ3RHRGQ5SDg4YTdKTmlVMEpGb0tBcDRua3FucXpHejM3RXRQcmMx?=
 =?utf-8?B?dVNEWWUyZXBDclN6Y0o5ZEdMN0pyRC9HcjduRmd6WEp3YUc0bnozcE1SRGZs?=
 =?utf-8?B?TDEveXBkZ2tPMDNld0dZTnRNMldLanFQSE1BZGNaRlRUUGV2My9YcnhTR0JH?=
 =?utf-8?B?bFdidDlRZGhaUEVGYTV5Z3FyTU8vRUZtR2gxYlhCdVZwT1RyRzdYZS9UZ3lz?=
 =?utf-8?B?MWdmclJUcVI0cGNsYzQvenVTT3hlYWw0czlJaU9JbWh6cDlTSCtRSml6cmx2?=
 =?utf-8?B?Ym1zaURDNW92Z0Zzc0F1QmlJSE14VUNKVjB5aTAwUXd2d2EzeHNqMSs5TUhB?=
 =?utf-8?B?dndxSlJUVURVbm1OUGs3QVc4bnpkSjlsei9FTUlOSmsvZnJ2ZWdpclduR2tP?=
 =?utf-8?B?QlBzd3BLcVFLaUMxWjYyTGtNcXhMQ3JCa1BVY0lkM1N2Zk9BbTN2QW9hRG1a?=
 =?utf-8?B?L1ArYmNpUFExOUNqRGZCNmI4aFBKei91QitiaHpRL3JISUxBL0k0N2F5eXlG?=
 =?utf-8?B?YXhObDhBMmQxc0pndkJrZUF0dTk3dzU2cGU0azJmbVBPSFBobzJENUY4dEhO?=
 =?utf-8?B?Q3d0bkRNVUJwVzAzN09Jd3MxV3YwOHZwejczTThaZGxxNUt1eE9rb3dNaTJr?=
 =?utf-8?B?UDNsVUlUOENTRkJwT25WRk1Wb05iejNqZDNXVFVQMVJUK0RBVzlVRUtCWW14?=
 =?utf-8?B?VzRZZzhhNVpjOXBQYUtOMUFnUlFaYzdxWmN2d29ETU05TTh1MmhCVDN6RWd0?=
 =?utf-8?B?dVJqS3BaTm5jdWVKZUM2anNKaDFadE9IaDdTczBUUXdSVkhXZ2NVVjRSbEtZ?=
 =?utf-8?B?M3BnTlgvY0RmNUFid3lTWjBQWmlwbHlWS3VDNURveVVRU3lmSVUzRjNYSkZs?=
 =?utf-8?B?d3pmN3REZm80MUhTZ1FRUEIxeGJwVVFyb2tqTk9BZVk1MWxPUUd1V2NDSXJp?=
 =?utf-8?B?TEpLN05JcWVKYU9aaTFQelBRWHM5WmRueFlBQU51dG5Rcmx0TGgzSmdPMlFW?=
 =?utf-8?B?RjFwRGg3UUpobEd0TXRadFFyN3ZWSG5TTUliYXQ2OStGcCtleEU0MDRrSTRM?=
 =?utf-8?B?VFRmQmlUeGUweDByREdnOEQ3SjJoZDMrQkpmWDZjYjd4ZFNGTDVFcVhnTFN4?=
 =?utf-8?B?WXVWRlZkcy9ZbThNTFlwY3Fid2ZXeEZ4UmljZWJKd0g1V1Y0WXBKc2lPbFh5?=
 =?utf-8?B?VWVUbUhONnpwWU5TaGNsZTY1MjFZTXh0aFJJbjUzb1Zwa2ZSRWozU0NOZlYv?=
 =?utf-8?B?T1d3RzJYZ0FMK2M5emZxM0NYbFhJYmlZeFlPMlZ6WExGdFVVT0FDb2YxdHlS?=
 =?utf-8?B?R0R4Uk5jdFUrZUsyaHVjdGFwNlBtZVVtYVYwSFlDend0SmNpaC85T0dQVUtE?=
 =?utf-8?B?dU13MGVQVnlVYTZNVVcya2dkcXZrVzdXaitLS05iQTBXSTd3dmtYbFQ1bTVK?=
 =?utf-8?B?WHJYaHd5VmJOVGpiR2w2SFc3SnVzV3RDbXVlTi9EblhnYlBJNmZENExpaU14?=
 =?utf-8?B?MENDSW05c21ZRVE4dzZpMXF2cGRaOStFc1d1NXQ1SWhHOGV6bXczejg0WVND?=
 =?utf-8?B?aVRXeFIydVl2dEgxTjdIb1N0WDNlbHA4V3pSa3hxN1REakpQeXlyeTkvUkJm?=
 =?utf-8?B?QmllRVpVMC9vZ2R6VnNPOVlUVEFRSEhMNkpzZ3FxQ280Y0liRitYTkF3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUNYMWZvWjVEd08yK0I0dEVZQ21ZSHdnNlRpcWlpT3dLQ0VFamVDWnJRQzNR?=
 =?utf-8?B?NENrS0VSeDczWEdDa2dUQllXQ0ZRd0hQaUE3WlZLTW54blZYeHlSNzRmMjNO?=
 =?utf-8?B?eERNTzlpQTU1ZDZjaFRiZFkvVHVTUXBXV29rZG01a1ZnbUFOTWF6ZnpGRk5O?=
 =?utf-8?B?dkVXRkN6WnVFcEtNTFF4dkVWU0YzQjlOWE5XUURLRTdsUGhaYXppTmRXTTZZ?=
 =?utf-8?B?cUtzcmhnV1lBUVJvb01IeTN2VE91YXB1NFNBZGc5QVVQRnZWbkFDM1F1VCtt?=
 =?utf-8?B?WkltVE5BTEtOVmhmdkdDbnVWZnk4d2E2QktWOXF5NGFya01NVWpsZFNxZEVk?=
 =?utf-8?B?VGVnb0VwTEdnWitrSFcyN0VyN0hpNjQwR0RWUTJhTDNYYnpaS3dZa2Q4Y2Z6?=
 =?utf-8?B?bjBiQTBiOFIyVXM1aUtkNHdpRlhBSkRFZnJYRm85cVFSWjhBb1pJVWk3R2cr?=
 =?utf-8?B?MTBwNE5tTW4vQ3hvU081dkgybVZxdm1oWHA5U1dpUENZNzZhMG5ScXN2M0ll?=
 =?utf-8?B?YUVGRzRlaWFwNXFUVHdOUXpsbmdOYVUwcmtkaTNlMTYwVkQrVUMydDUreWdW?=
 =?utf-8?B?eTBWN2xaRWJFbmtYbGlCZ29GNlJHQUZSODRQa2t2Q1V0NEpMWkdTbk9MNnFW?=
 =?utf-8?B?OGxWbnBSQ2Z1K2VPN2MycEFQSG5zaDBxcld0aXVRb1ZXMnpJK0trNjJHcGky?=
 =?utf-8?B?R2l6MjdMZTFPdFM4cGFXcytTY1I4NUg4UHFCcEN2aDgvTU9OTmRrZWhRRG42?=
 =?utf-8?B?L3VoaFlFT1V6ZWhVK3ZZcVF5NkV2U2lDNm52OStJaWk2RENGSUpmeURQWGZC?=
 =?utf-8?B?NjBmQ3hIa1RRL0dDU29BVHVyNmowblRnYVBNRG5LL2FmTjZjS0xueGVKemUz?=
 =?utf-8?B?QVpUQlJvK1RCY1dnOGFWdzF3eENFVmNaV2x4ZWZjS1RIeUpLbnpPdUV3UHpL?=
 =?utf-8?B?U3U4Z0wrejg2VHBwUHc5cW4wc01CcFFLS0VpL1JwckFEakZQdmxIQWZLamJk?=
 =?utf-8?B?WnNZRkdPRW9GN0ZzRUp2UFRjSS9hT0FzU3hQOStEYVF4VkVGSGxEMzhlZVF2?=
 =?utf-8?B?K1B2bnpSWms1ZytwdCtaTFl0UFp4U1hMczNHNGppelI4TnNJUytqWFFUWWIy?=
 =?utf-8?B?M0NSSXBPZXpTY3pPN2RkRUs5cFFTNmNxWGZ4UTlTYWM4OFAvVnNvOFFJZ0cz?=
 =?utf-8?B?YUZTc2J1bzNXZVNPd0YrbnRCZGhDcnhtOENFTndBNmUrRjlDcXBOVFNCSE5Y?=
 =?utf-8?B?WnFpdVhWYnhCbXpoUFB2aUFoWFZvSDlYeFQwOGZCWEdKakd2aHV4WGJNV2Rv?=
 =?utf-8?B?c2tpbWx0UWFabFZrQm5KSUFoRmRSWm5BZDF2dURhT2YxOEhUcnhUTHZsbHlU?=
 =?utf-8?B?ajN4SzB1a0tIUkdWOFpuQk5BMzhUN0JscUJNMXp2b2xBN3lkRkdzQk1OWWg4?=
 =?utf-8?B?dzJVd20rdnNyc0hyV1UwRGl1aVRsb1V3blpkOUpmaTc1N3RkckdHalBtbUpO?=
 =?utf-8?B?V1gvOERpTTl0ME1IenhJWEY1ZTFKcWRFaENQZm9oUlM3UzAzVWoxREh2YkJ6?=
 =?utf-8?B?eFRFaFJLOVV5MzAyTkE3MGFtM1RhVGM2ZnV4cE1jL200aGdKT2NYeFJnMGM3?=
 =?utf-8?B?M0tQQzUvN25vQnFnbjRmN3FoWXlobUMza0dEaUxBZzg1ZVkyclNqYTdhT2pr?=
 =?utf-8?B?bXo4cnA0MDlxYUJQRFd1ZURSTklua25uWEhqaHNLU3pIWS9vVVVBZVdLRUdu?=
 =?utf-8?B?YWh2a1MzM09nNTE2NDNtVDgrdXRMUzVSdEhnVG1iZkwzZ1lyQ0I2M0x1b1B5?=
 =?utf-8?B?dno4UnpXb3VFQkxGQVpSeHZmdmF2NHVOOWp2aUhoTFNuc2tGRTEzdUJiTGRj?=
 =?utf-8?B?cmNyQ0xnMGkyNkNhUzZ6Z1Qwck9pc3Frd1ZWcVpmT0ozSndPZERTRDg0QThF?=
 =?utf-8?B?a00yVTNpdnVZaDNoaDhvMi9HbUU3MVB2d3RYc1pxK2ZTWDh6M3VzbU0xejR0?=
 =?utf-8?B?R0FlSk5pektyKzk3VG8wVldMT1pyTUJkU01KVTlDeGNEMCtHK3kyY1J2RnZZ?=
 =?utf-8?B?Z1VHYlhnWXRxVndTNXB1Q2NUYU5mc0JFMXBXQUd6L290OHduVlV1Y0FWSGZ1?=
 =?utf-8?B?bWZOUEhTaWNEb2hjNU9xOWJrSmJWZUovdnhtQ2dBT2lSSm5NZGVRd1RsY2RJ?=
 =?utf-8?B?Z1E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f673b5-5551-472d-b1e9-08dcec63fd33
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 15:22:17.5302 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +eeqSY8zYnSmzbemcFye8LyWU8LG+7ojIKgqf3Uf5kg63/PpS672mapE1bhsp+MM6s4jam5eE/Jg8syXf6lw2ThUNnuvqhek4HwNffx/FXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10718
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

Hi Heinrich,

On 10/8/24 10:46 PM, Heinrich Schuchardt wrote:
> %s/boormethod/bootmethod/
> 

Typo-fixing commits need to have a typo in them, that's the rule. With a 
typo in the commit title, that's respected :)

> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
