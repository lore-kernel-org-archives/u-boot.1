Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C29FFEFB6E
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 16:22:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9D8183D1A;
	Fri, 27 Feb 2026 17:22:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="O0ASq4+6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7488F83E8E; Fri, 27 Feb 2026 17:22:50 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E2D883CDF
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 17:22:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AnxNg2KG8wPfGkLIWtlD/lLzJYwLgoSKV22yQtz4rFkamJgWBqCUR0J2+EmKP0TwFyxcZaVJQWL97PAa9PHHSK5JXcwcAiggHzPux1eT4vfFZHNXNtUQfbECtZImVHfZaqXTNp/kfYKqwEz+QeVbGwFPzpP4tzqPEfzjXGAw9ZPVoJfSFkeHB3ROhrFAnCfjsN5hzCO8D2E9/0w5I41JRQeZBY7N7Z5S41jNbDJUmTeog7g+FBpt/OFGYUeQc5O7K/L7RCscbpSNNMxR/Ih+nxNfXBfo8o12AhdU28YNOirbf7R+I523BRvzCy90wym84TaR7s70Lf54c/g+Us3SZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffa8aMF/CDT8iO8myPE3fu8Jm09oDO6DB9zSqbt+32E=;
 b=KOIV/QDYdq57GED4cybl/U15gJunGQmt7GZHSnK/kVusoqgrUZPlYowzSaR5si283qDg0w98wxz0289UpyAunVCBdnwYGxdKw7Q9ba5LaXQg7n83IwAyO65ymIo+dVb+qDaM89rV17Id28bfF5CpSIKy6q7GXQEkRNUfUGRqsfs2E4TLNKkhDNwsVsDJBHmXZVlIBcTgA1r/CYlndcirRtUMYcCafOk4QJvG5tVFvdWtIBQl+s3cmaQLKNXqjPsAMzrX3WFEyhFi4gqAIvt3+RHri7ReVye+5OnKhkg74T2sji3efx/EbJwWU3JKTPzDFyJLmkycFMzaupSc6tYvuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffa8aMF/CDT8iO8myPE3fu8Jm09oDO6DB9zSqbt+32E=;
 b=O0ASq4+6PXJH3NKoKw93fDcG/GC1IoLxvLJuJj7xumlpvCp6MmSoov/S1ck8uvkBnqxPiH1EsVZR5Im3n81crrkBAial2ogLGJAiq/yXOw4ZQ/NNJm1Yi/rdah498B6AXQiBGjAFR4hCPDtWigcdAC+yeKyXp0mmE2wjzy1rNtQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AMBPR04MB12288.eurprd04.prod.outlook.com (2603:10a6:20b:730::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 16:22:46 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%5]) with mapi id 15.20.9654.013; Fri, 27 Feb 2026
 16:22:46 +0000
Message-ID: <0a00c978-9059-4bb1-aba1-dda5c59db815@cherry.de>
Date: Fri, 27 Feb 2026 17:22:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kconfig: fix buffer overflow in
 conf_get_default_confname()
To: Anton Moryakov <ant.v.moryakov@gmail.com>, u-boot@lists.denx.de
References: <20260226205846.57752-1-ant.v.moryakov@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260226205846.57752-1-ant.v.moryakov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0036.eurprd03.prod.outlook.com
 (2603:10a6:803:118::25) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AMBPR04MB12288:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eb335a4-0fcf-4a4f-6bbf-08de761c714c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: Oyjz+1rxg985AAKo9BWtavqJylJoiXP+e6ux795lzIpcJzdbp2AhIyr00fMpoDaJOhY7TuIrJWs3Zgcu095VfEW8/KtbO+mbpZP7CBzCPBqfCCyvNj2oXJEVetKCzWkrYpSMpLNi/imdNXDXq8I7l9nrux7QNHad5jkF+Oxdfh9aWIhus0L1DsF7bRDsrP8s/Evffrf5b46HzfvxVdvhU8HJtE/s5w4crtjtd7tGNOAwp6e6mKz6cGv1VitpO3ggvrIBTX4x9wQXgFiwbIabmTaI8+oM+oPCYT1eXXwNXQ6LsM9q9poQciWw/mrtf4H1UOHWMkBPy3uCX24CQImnY+6pFu/30ov2V8l3utbTaJ87LJSz/3Q0nLoN7d8N6eTSy/qY+U+g87vtvumUtC2uJx3xraoUx9FlZ6moOiVxVWw2N7+np119cfmzQDmxcZnXa3KrKDvgKk7EH84+q3Td+am4OefnxRlbR9o7WlQuPk+2D9r9nRFnVrgv/Bdf7czd75wgMgi6cuajP7FI5tbYPY/2lDlbgg0X7LYk6OSTs1/S4/hPrXdUByE9gWAcnawODQdWbs+an93QQWI0Pae/5HCLtsy5GPSsWH/DNtf/Xp2rfeGG+APqqtwxHJaR6zhcPxYMHP20Oo71rybtI+ICeZ3GadhOXS6MisSNxNWmmS/faDHvGLtaN8NiVq4lmD6VVV9Hct4ZemHi75qcW8y+J9X4boBAckTqTaC0wpXVK5o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGNGZXRzODUyMGN3TlkxS0FDdWMwdEtUU05ERTdmbkdROTR0aUlQbWdNSmZV?=
 =?utf-8?B?OU1ZTmxDRE9mbGRWSU54MUVKSEVla2dnTmJvNTRZODF5TGdqbDA2VTMraWhF?=
 =?utf-8?B?THgyRUQyUUUrVTZEMXZ6NnhrUU5PSFJhbkFFZEJ0dzcxdEFkUnZ3ZTBIQ2M5?=
 =?utf-8?B?SkFpZ09XYXBmQkpBT1ZGL1J0a1RrS2EyNDFiLzd0RU5selZVRDhCaUY2Wngv?=
 =?utf-8?B?cjMrakpjaWNyR2xvcGJKT25hTElad2pmOG5CQzZkTzJNbHkwVDJiTkFMV0M0?=
 =?utf-8?B?cmZTdDdUOU9Eb280TVdqWUlJOXJweitDV0Q2TjBKdWhKbkFKbmZmeHhNQXJY?=
 =?utf-8?B?ZDdIazZ0aVJPaGszUURXRXlLcXR5dGhSN0ZtaDJ6Q3dHOXdWbGlPRFNvM1Bl?=
 =?utf-8?B?SXpoSUJ5VGF6Rmc1cHZCaVdvRnYxUjhHN25JeG9TM1ZmU0hCcVAycnlHamJI?=
 =?utf-8?B?VVRwK0ExVjNicDVKWGw5TlJHUWlaZWxaRnhxTGVKOG85Zy83YXg5ZThkUUtZ?=
 =?utf-8?B?U2ViY1BYWmJ1QnlXWUZMOVFpRFFQekhQdkhocjFXZklMeU95SDNaSmVPc2Fh?=
 =?utf-8?B?bmNmKzM2YTJsaU5hNnNBTGVyRDFtMXFjMXllTkxrV0paNDdxdThoT2drRi9M?=
 =?utf-8?B?b2hnUDJyUlZvZjFXZlRyKzYvL3ZjZHVhL2hYZ1QvVytqNysxdWNDVFU0ZFhZ?=
 =?utf-8?B?dlZQSmFmRmhpdEpGbE95ck5ScG91ZG1venVhWHJTdWJJR3hkU2w0dWZkN2ts?=
 =?utf-8?B?b0w3QUhGK2Rud0JaVlZXRG5nN01ZZ2pYOEhNNEY3U1d3QVBxRTlraHFwVjVj?=
 =?utf-8?B?THExM204QXpvelJCT01CL1N2YTJNWGJlTUEzZWRpZ2djN1owSzFYcmZwVnEv?=
 =?utf-8?B?V1hCalVIWkVoQUU2eFBtamYwRVVVcCt6aXZReUtVNEFIVThMRGUxZEtNdU1H?=
 =?utf-8?B?eVBZQy9pVzZKSjhvU2JiRmpRNkc4WHUvRDdhWXZwWnhObjZCTVJtZWNCYVlT?=
 =?utf-8?B?cGZaQWFFTXJLNlBIRkgrZjZFK0g5RUpLaVhVOXdYR2RxaE5rWTJHQXlKcXU0?=
 =?utf-8?B?ajJDMlcwUlNCeEo3QmdqR3JmczNsRk5xQzB3cDFQMnhRTjJTdXpPdzIyZk5h?=
 =?utf-8?B?bnh2YW9zUEFBOVRiL1FEcDhEZDR5ZUdvTytpekl5U2NZU3RnOHpWc1BQbDV1?=
 =?utf-8?B?SlBIcy9wYmdKYlJQTHc1elV6elU3SnI0T0ZydmJQZlZhZDM5ZWpmN0lTVm5G?=
 =?utf-8?B?NnNmT0R2SWc0Nk1xdnFYVTZvTklpSC9XNmI0NmhKaFdlSnlHb2tuVTZPU3Nl?=
 =?utf-8?B?S2o5b3hjN1VzV0hydmQzckZJaHdEUEQrQzIwSGpCeFZUZXNuZzIrdmYrb2Vo?=
 =?utf-8?B?TTEvTE9VZkR2cVg5L3pmWEpuNktqS2xQc3gwS0FRWTZ3ZUI4V1hLeitzYVZJ?=
 =?utf-8?B?T1F2dXdnUVQrMGhZY2NxamY0Uml1R0ludGlrYzhkREpkVmRmZFJzeDl0cXFO?=
 =?utf-8?B?QXJ1OXExWjJLRVdRaU5tejM3UTZFNmE3NkxYNHA0bGlLd1pGNXJvNEh5b3h6?=
 =?utf-8?B?ZmhUclYzRlEwL25FNUJxWjYvT3pzQVgzeTRkdWhaR3d2V3c1eXZYN29aajRj?=
 =?utf-8?B?RnFNVlhLMm5QTGo3MU5LdS9XZXZKSmd3YmszWjVubTQ5NGNEa0xZdUpPMVZr?=
 =?utf-8?B?K3RCVldxRU4wMUFFRUJrS1ZsZ0NIUUovNGkxTVYveDBuY3dnMkJZVU1PaXVv?=
 =?utf-8?B?Y2hIZVVHQU9GbHNNVkxKd1lCbUdQSHpsS29wemNibmgwaXE2THFRMjBVZWx4?=
 =?utf-8?B?SUFvUEhiMitxcEhJV1FGVUI2VXRWbS8xZzNTVExrU1dYWFY2azRWSmZMODF4?=
 =?utf-8?B?NHVzNjh5cnl5djdQNzhsY2VTV2lGMGRNRE43V0QyWmRHa1ZXVkRZNUI4Z3JT?=
 =?utf-8?B?ZUx6Vk9LQU9LazZoZzdwa2hSY3JycFZhZHBXMm4ramFJNXhVWk9MMkYvL1E3?=
 =?utf-8?B?N0dFb0l4OVRhQldHZUw5a3hZVDMyb0ZlMDZJMmxTSUlNdVFqVS83MUJwOFRQ?=
 =?utf-8?B?ZFNYN1RDakFPVlZwZGNxejg0aWVDcERudkdvWlZRR3NJYXhIWHlHVWdSRWd0?=
 =?utf-8?B?enNLRjByOXE2dForY25PZkM5RUdlK3BlMlpnMkljN0tGV3QvZFhnanRISUF6?=
 =?utf-8?B?SXVtblBCcFVmMlR2T2EzWGVxQlRkK1d3NmJKZWV2Qkx5b3EySmhySlBEQmZ3?=
 =?utf-8?B?TkpORWJYNmlMU0tHOVVZekhEMEpsVUhKNksvNUtZOXpudEtNVDNUenJrQWda?=
 =?utf-8?B?NFgzQVl3Nyt3QkVpZm1uYnhLQ0VvL1NienhtTGRtVHpIYm82V1Rmdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb335a4-0fcf-4a4f-6bbf-08de761c714c
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 16:22:46.6750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wPt5jmlN2Nah8HN82DPvn0I4iWqdnt/Ak/EtCu+XDa8ILQQDyxCbciyuEzSVKF2iltF/fwZQm/LBdocmPQYHcu6f+34tVwZwkCSBa8H9Mmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB12288
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

Hi Anton,

On 2/26/26 9:58 PM, Anton Moryakov wrote:
> Use snprintf() instead of sprintf() when building the full config path
> to prevent potential buffer overflow.
> 
> The function previously used sprintf() to concatenate SRCTREE environment
> variable with the expanded config name into a fixed-size buffer
> fullname[PATH_MAX+1]. Since getenv() can return arbitrarily long strings,
> this could lead to writing beyond the buffer boundary (CWE-120).
> 
> Changes:
> - Replace sprintf() with snprintf() with proper size checking
> - Add validation of snprintf() return value to detect truncation
> - Emit conf_warning() if the resulting path exceeds PATH_MAX
> - Return the unprefixed name as fallback on error, preserving behavior
> 
> This fixes the static analyzer warning:
>    confdata.c:119: buffer overflow via getenv() tainted input
> 
> Reported-by: static analyzer Svace
> Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
