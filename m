Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E8A6CDE008
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 11:14:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE3948404D;
	Fri, 26 Jun 2026 13:14:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="BDAbYBZ8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AED084704; Fri, 26 Jun 2026 13:14:27 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B6B580398
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 13:14:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VqKbbDoX4T0vLQ/4tRsX2dFQaW1RNgVdh8dfKlH3PBB8F4UaJhRm6s42JWNZEgBbCap+xxD3uTIxYG29CAaNDOafpeQ9U0nb5xW9dJ/9vs5PWjXRAvgTOM0+Cf6zMMflrPX633+9RrmpilQCmrLNQ92S2F9/EeZkyT5FI1rnIywoSJGItGb0vbQajnUeUHMlEIfdp5mB6SsrKu7qOv0QTFWVjXa393eFbpYDONmSg1OFHVSQAE5VRgVvARNJ195vvVc3b0xPInWfsv3Esr4tehdlsHudoMGLNYA2WWbuC6SUsP9Qh+UggXJ6LFGGIDe3ARimAKq7z6VXcye0/eN/OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TiqqndqlKa0PawRHmHUp3nEviDq8N9ZmmaCPnOW8o5k=;
 b=RnYQxxvUAaIBy0WqOCnKq2j8HlDn6J9nLrjh0qGl96YRvckoOufPRBJV8SJXYYgzdZeSgzmsikOT5H94cjpviX0iqziWTz6FM1GBQhtx09i9Yb2fS5XLrxuEdTVycyr5XaWFxNhSadns6UIrgz+56uVuyLr1X/NL0uX3p0C7rzHu4vvgywPKzpxGhKe8gv202SNCqciWVgUqoSf7yf8j+LV3X9Aw0qWSccoPyEAq8Fe+Ps7xa8UMqqMa1OL51EO5x5DG9eqpU0X9lOasiRZxGDLLb53CYTydvhCbNTxZCNRfwqQ86FJ3OqaHEFhlB3yepBpzEeRvcQQzYD/TOASAfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TiqqndqlKa0PawRHmHUp3nEviDq8N9ZmmaCPnOW8o5k=;
 b=BDAbYBZ89Xd96NBpAi+x7JjRbTP3MsNfPXKH3zi4HrFUFLu3GWwC+AxxS5xI4NDcBCDUaq53PaURXReMbglQ/4g0htsyiElvuTnJP5sf1zpaNv/1z69ElZKLkPvpE7L4ZcuDKiXzzrErNrcGSLf1BKQQ0fbzbINEA/xGXQy8K4A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DU0PR04MB9297.eurprd04.prod.outlook.com (2603:10a6:10:354::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 11:14:22 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 11:14:21 +0000
Message-ID: <659d8f70-bbd4-468d-90e4-7109a9166353@cherry.de>
Date: Fri, 26 Jun 2026 13:14:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] binman: imx8mimage: Generate FSPI header in binman
 instead of mkimage
To: Marek Vasut <marex@nabladev.com>, u-boot@lists.denx.de
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>, Yannic Moog <y.moog@phytec.de>
References: <20260610161748.54824-1-marex@nabladev.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260610161748.54824-1-marex@nabladev.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::18) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DU0PR04MB9297:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fcbe193-ef61-4959-8c8f-08ded37412be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|3023799007|11063799006|56012099006|6133799003|18002099003|22082099003|17002099007;
X-Microsoft-Antispam-Message-Info: jE+tDZlaskC49bRJdk/ajznHPDQLGf/SAlC6hJYVpUlwa9VY+mZnByRK2Y89tSfy1j4c6dfjACwE3hGTsoBrYpY9xW3BwpF4iCMng35qVwxqAB/Nsozc0Xtr5mVs+iWM1PaTZP5J+KfE69LayUzx50dVznr5k7ygSUfpt03Y28C6nAzw4t9B/PQtfyeiQHVS76+oaQ9LE9QBLoyLCJE2tpyAjach5aljP0wZiTbgrKGKZjlQul1xshdoIsp57D2deYXG4YHfKzE0dBnSJtgKw90s2amHFdSpK1eGpBIVT8MDW6xQF2N91mRBMsWPZT+0oqRquSw3WoYc9kxPy99ZhpKc1xFdgKDVVh7VWCZ8H5MlcWFKPbxhzrbbF1I3tJTAGNKvPA2AU2r71ZRxv/D9YCsa7sgc3MkQ6nxurllDiC719fOb/Cj9PhL+G9yPYKVlkRUCJbPNuLRqurQCpMva04ZWUyNQ56KFeAd5k+PbRWoD7iynX4dm7IhLxviQbDhciGmYey28dM1vjYrDXHoyrG1gkvQ1WkSIJedSwIhABENqjz/AGeYJW24fiP5GyCYHsGDHp2weDawpEgGbZTnqmMgFTwiePVhoD8V+gDKnDhp0JreYR95uFNsT0KMVhV0tOvjL+4Zmfy6VknDNLRQVfUuiLqkBIL3oV8x/JHZsZpE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(3023799007)(11063799006)(56012099006)(6133799003)(18002099003)(22082099003)(17002099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjZXVndzcFdKMFlDNUdRWmQ3WGM2b09MOUlmWks4L0ltV1dra05LdGpVdFFD?=
 =?utf-8?B?cEpyR3hMQTdKbnpFTVpvdUpBanp1NjVpbnFJNENOcm1xcFM0aVdmVWZyVnEz?=
 =?utf-8?B?SmFmSkxQU3BmV1E5T3l1VlYzRVhOOStNNGpLakxzaGx5MllTb2Z3UTRqWjdU?=
 =?utf-8?B?bTRwUStYdlUrNktqd0lucnhadCtQNE1IcU11M1hXZ3B0cVJmSnowK2YzcW1z?=
 =?utf-8?B?Q1hCa2ppcENnR2dMa0FubWNnWnU5QlRyUnFiMVoxbS9uTXdVNFZkWGZYN3E0?=
 =?utf-8?B?MUpHdHRTbEZXQlFsYWNoaFF3SW9FWkxrYlQySVQ0ZGhtOHgwdStZWE9kbkFL?=
 =?utf-8?B?Zno1czIxdTVYRFpETmQ4K3IyRjNEd0cwbmRWUFVQMWxlVk9weFZyM1NiT3Ji?=
 =?utf-8?B?Ukp0MUdSZ2hLRkVwano2ajJxcFQ2ZlhOWS9LWXpGWEh4TTRYYUo5NWlibitY?=
 =?utf-8?B?R01KVkNPZVl3eU9EZnZsZHRHZDdEVmJ2eDhqMUxkdE1melgvRkFabjVxM0M0?=
 =?utf-8?B?anJHeXc0K3dSNlJXK1MxS2lObW9Gd2d4Mzl6OXpRM3JlcUN6STR4NWdyblhr?=
 =?utf-8?B?ZTR6dmxyQWkzcUlab3ZkWkxINjZGWGdENG4wUGxCZ2Jwc2xwUGl3MjErM3E3?=
 =?utf-8?B?K284Nk54ZzF3UTE0bWNtWlU0TkRYMC8zT0hUMExSM0UxVnkvVy9DRU03QUEy?=
 =?utf-8?B?SUd2bFJyQm9XMVNjTk0xekh5K0NiRFFjbmpzVExVL3ZXU1g1bnVzU3dpbmNv?=
 =?utf-8?B?eklyTDlGQ3RJeTBLcEhJNkd1U0wzbFVXSittbFJRS1FiUTVGNkNkV2xLdDRu?=
 =?utf-8?B?YzVWSUtjMldpRDRDUFAyZHBBYTZLMWp0VGhCWlRURk94eU4yb2Q3UkhQMFdW?=
 =?utf-8?B?RmFtazVvcGVLWktlMWluclJCaGd1S3JPQW8waWJ5enVUN1hPcWl6b3VYdWNn?=
 =?utf-8?B?MWp3ejdOd2dhQ01wUE5wS25VM2ZuQjhpUCtWdzd5Qmg0b1R0ekIxbm1VSWlp?=
 =?utf-8?B?S2NPMGdOcythbEpvMjVZMzcxZGZsRzBUMDkycnhxN25GenVSajdQbWlNelJQ?=
 =?utf-8?B?VEVPTURadjZOVG44aE5pL0JNMHlCNldqRlpkcWNjbGtheXVlL1RIU1J0cVhX?=
 =?utf-8?B?eCtMa001WEJjVzg0Q2FWalp5Tm5WNFQ4YUNrVTBPcG9KWWlQQjdLWTE4WmxP?=
 =?utf-8?B?KzMvaW51RVBqODUrdS9iWkFQRG9SMDAwdFJZc25QMGRzNVQ1MDlQUWpSZXFy?=
 =?utf-8?B?STZTK2p2cmJPa1NKQ1pTdUlVVVd4Qi9ncnJ2eGZpVnRiUngzdjJKRDQ2T2pa?=
 =?utf-8?B?TVpWcmZlR296SUk2alNTRld2d3loMVFpUHdlM0Z5K0JVc2FSMXZRV3pvUm5N?=
 =?utf-8?B?UGl1VWxOR2Vjdlg1WFZCWUR1ZmVwbWcvNnJGVXdHU3paS2pxbXJuVzFkZkRr?=
 =?utf-8?B?c01rV2ZrdlBuNEV2ZEFTTU1nQjFySTFseWEvd0NHczdzZFNFQlZXWWhHUzVZ?=
 =?utf-8?B?eGI5MTBlVmNzalREVDl5MmtmR2JwYVdrL3l4NWE0WVV6Z2czZmpBY0g0VWxk?=
 =?utf-8?B?SEM0bm41bGFvVDJPVXE4b0pzQVFpMGZ1dWxrdTA4U0o3QzRlTXRBZmtiRk1v?=
 =?utf-8?B?K0lzK2s3cVoyeWUyUlFmcGJBdkFMUU9vaWZQaHBIWUF0ZEVYZ1A4SzlNbU02?=
 =?utf-8?B?ZjNTUnZuZHNCUEJTSHZGK0krb2xNdlZzNDAvcEppU0lKM2wvVEZUQ1doOGx0?=
 =?utf-8?B?Nm1kTGprTXh1OHI5bnJYa2h6NDBRNytyV3ZKcUxtZUNhaUpsOGRXMjEzMWlL?=
 =?utf-8?B?a2EzamRlUFhUM2k3WnhsR0RRcXB5UXdDUlFybVRheDNkaFlsTjliMjE2a1A5?=
 =?utf-8?B?dkhZUXNVa0xJTmhFM1V0NUhqUkFZY2NtbmlJWTZUM1lpU29pdWVrTGNMN2Zs?=
 =?utf-8?B?cUVSVUhOL1M1QUMxS0crR0VhK1R0bmhRRktMdzlPSUl6cHJhdjlDRStLUk9M?=
 =?utf-8?B?UDArY1huUTk3NFhOTHY4anQ4MHNiQU5ScTdSQkZaQkVHbGVVdmxRQXJCcHBs?=
 =?utf-8?B?NUhHcWdnOUg2ejFLaE9NMyt3Q25CYzZhZUNZVkZuclRDT0lMeE1raWVwczFa?=
 =?utf-8?B?RGIxTFRhdlRzclZkQnVZdnRmNUFjU3VDL0lhUTE2dno1b0NWNGdod1BicUdE?=
 =?utf-8?B?dEtobnE5QXByYzZWRzBmUzVtNUJmQzA0dENPWDA5V0NYLzBOd1d0VVhVbzZa?=
 =?utf-8?B?YzNWN0tKdy9JcXpuZUZuMFpkbzlscjRnam5lYXhsb3RaK0N1NmxNUkJvSkho?=
 =?utf-8?B?ekNhUnBFQzZNV2hTRUhjaTZxZmFicTJqd0dJVExqT3dqZ0M4QnpIUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fcbe193-ef61-4959-8c8f-08ded37412be
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 11:14:21.8448 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rB1yHG+ohFcdlq+fZEbRYFCdsDOXTARarBsQEoD5r8S7KauWjU2/GWUBoC7NKvpsxmqZRFYKQyBAU/lLb05Es/AOCcyPq8VDuerC8LrW8CA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9297
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

On 6/10/26 6:17 PM, Marek Vasut wrote:
> Stop depending on the current mkimage method of generating the FSPI
> header, instead generate the FSPI header within binman itself. This

Soooooo, do we still need the mkimage version or can we remove it? I 
generally would be against it since "users may make use of it" but since 
you would need to rebuild (according to this commit log) it to be able 
to compile what you want for your device, essentially making the host 
tool dependent on the target you're building for, I guess it could be 
removed? What do you think? I'm eyeing tools/imx8mimage.c and 
tools/imximage.c specifically.

Which makes me ask "is this something we could do for imximage as well?"

> is more flexible, as the FSPI header properties can be configured
> from within the board-specific DT instead of being hard-coded in
> mkimage at build time.
> 
> Signed-off-by: Marek Vasut <marex@nabladev.com>
> ---
> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Stefano Babic <sbabic@nabladev.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> Cc: Yannic Moog <y.moog@phytec.de>
> Cc: u-boot@lists.denx.de
> ---
>   tools/binman/etype/nxp_imx8mimage.py          | 93 +++++++++++++++++--
>   tools/binman/ftest.py                         | 23 ++---
>   tools/binman/test/vendor/nxp_imx8m_fspi.dts   |  1 -
>   .../nxp_imx8m_fspi_fail_columnadresswidth.dts | 19 ++++
>   ...dts => nxp_imx8m_fspi_fail_devicetype.dts} |  3 +-
>   .../nxp_imx8m_fspi_fail_flashpadtype.dts      | 19 ++++
>   .../nxp_imx8m_fspi_fail_readsampleclksrc.dts  | 19 ++++
>   .../nxp_imx8m_fspi_fail_serialclkfreq.dts     | 19 ++++
>   .../test/vendor/nxp_imx8m_fspi_pass.dts       |  1 -
>   9 files changed, 176 insertions(+), 21 deletions(-)
>   create mode 100644 tools/binman/test/vendor/nxp_imx8m_fspi_fail_columnadresswidth.dts
>   rename tools/binman/test/vendor/{nxp_imx8m_fspi_fail.dts => nxp_imx8m_fspi_fail_devicetype.dts} (83%)
>   create mode 100644 tools/binman/test/vendor/nxp_imx8m_fspi_fail_flashpadtype.dts
>   create mode 100644 tools/binman/test/vendor/nxp_imx8m_fspi_fail_readsampleclksrc.dts
>   create mode 100644 tools/binman/test/vendor/nxp_imx8m_fspi_fail_serialclkfreq.dts
> 
> diff --git a/tools/binman/etype/nxp_imx8mimage.py b/tools/binman/etype/nxp_imx8mimage.py
> index 25c43438a87..47cd4481acd 100644
> --- a/tools/binman/etype/nxp_imx8mimage.py
> +++ b/tools/binman/etype/nxp_imx8mimage.py
> @@ -8,6 +8,7 @@
>   #
>   
>   import os

You remove the only user of this module later in the diff, so this can 
be removed as well.

> +import struct
>   
>   from collections import OrderedDict
>   
> @@ -23,10 +24,25 @@ class Entry_nxp_imx8mimage(Entry_mkimage):
>   
>       Properties / Entry arguments:
>           - nxp,boot-from - device to boot from (e.g. 'sd')
> +        - nxp,fspi-columnadresswidth - FSPI column address width
> +            (3 - HyperFlash, 12/13 - Serial NAND, 0 - Otherwise)
> +        - nxp,fspi-controllermisc-diffclk - FSPI differential clock enable
> +        - nxp,fspi-controllermisc-wordaddr - FSPI word addressable enable
> +        - nxp,fspi-controllermisc-safecfg - FSPI safe configuration frequency
> +        - nxp,fspi-controllermisc-padovr - FSPI pad setting override
> +        - nxp,fspi-controllermisc-ddrmode - FSPI DDR mode
> +        - nxp,fspi-lutcustomseq - FSPI use LUT sequence parameters
> +        - nxp,fspi-devicetype - FSPI device type
> +            (1 - SPI NOR, 2 - Serial NAND)
> +        - nxp,fspi-flashpadtype - FSPI flash pad type
> +            (1 - Single pad, 2 - Dual pads, 4 - Quad pads, 8 - Octal pads)
> +        - nxp,fspi-readsampleclksrc - FSPI clock source
> +            (0 - Internal loopback, 1 - loopback from DQS pad, 3 - Flash provided DQS).
> +        - nxp,fspi-serialclkfreq - FSPI clock frequency
> +            (1 - 30 MHz, 2 - 50 MHz, 3 - 60 MHz, 4 - 75 MHz, 5 - 80 MHz,
> +             6 - 100 MHz, 7 - 133 MHz, 8 - 166 MHz).

OK, so... I have not played with i.MX8M but I would be absolutely 
clueless on how to configure this. Is there some literature, readme, 
docs we could point at?

Please also mention that all nxp,fspi-* arguments are only available if 
nxp,boot-from == "fspi".

Please document which is the default if the argument is omitted.

Finally, I don't think it makes sense to tell the user "say 1 if you 
want 30MHz, 2 for 50MHz", why can't the user specify the frequency 
directly and we do the job for them of translating it to something to 
put in the binary? (same remark for all arguments).

>           - nxp,loader-address - loader address (SPL text base)
>           - nxp,rom-version - BootROM version ('2' for i.MX8M Nano and Plus)
> -        - nxp,fspi-header-filename - FSPI header file name (CONFIG_FSPI_CONF_FILE).
> -            Used only if 'nxp,boot-from == "fspi"' .
>       """
>   
>       def __init__(self, section, etype, node):
> @@ -37,9 +53,30 @@ class Entry_nxp_imx8mimage(Entry_mkimage):
>       def ReadNode(self):
>           super().ReadNode()
>           self.boot_from = fdt_util.GetString(self._node, 'nxp,boot-from')
> -        self.fspi_header = fdt_util.GetString(self._node, 'nxp,fspi-header-filename', 'fspi_header.bin')
> +        self.fspi_columnadresswidth = fdt_util.GetInt(self._node, 'nxp,fspi-columnadresswidth', 0)
> +        self.fspi_controllermisc_diffclk = fdt_util.GetBool(self._node, 'nxp,fspi-controllermisc-diffclk')
> +        self.fspi_controllermisc_wordaddr = fdt_util.GetBool(self._node, 'nxp,fspi-controllermisc-wordaddr')
> +        self.fspi_controllermisc_safecfg = fdt_util.GetBool(self._node, 'nxp,fspi-controllermisc-safecfg')
> +        self.fspi_controllermisc_padovr = fdt_util.GetBool(self._node, 'nxp,fspi-controllermisc-padovr')
> +        self.fspi_controllermisc_ddrmode = fdt_util.GetBool(self._node, 'nxp,fspi-controllermisc-ddrmode')
> +        self.fspi_devicetype = fdt_util.GetInt(self._node, 'nxp,fspi-devicetype', 1)
> +        self.fspi_flasha1size = fdt_util.GetInt(self._node, 'nxp,fspi-flasha1size', 0x10000000)
> +        self.fspi_flashpadtype = fdt_util.GetInt(self._node, 'nxp,fspi-flashpadtype', 1)
> +        self.fspi_lutcustomseq = fdt_util.GetBool(self._node, 'nxp,fspi-lutcustomseq')
> +        self.fspi_readsampleclksrc = fdt_util.GetInt(self._node, 'nxp,fspi-readsampleclksrc', 0)
> +        self.fspi_serialclkfreq = fdt_util.GetInt(self._node, 'nxp,fspi-serialclkfreq', 2)
>           self.loader_address = fdt_util.GetInt(self._node, 'nxp,loader-address')
>           self.rom_version = fdt_util.GetInt(self._node, 'nxp,rom-version')
> +        if not self.fspi_columnadresswidth in [ 0, 3, 12, 13 ]:
> +            raise ValueError('nxp,fspi-columnadresswidth can be 0, 3, 12, 13 only.')
> +        if not self.fspi_devicetype in [ 1, 2 ]:
> +            raise ValueError('nxp,fspi-devicetype can be 1, 2 only.')
> +        if not self.fspi_flashpadtype in [ 1, 2, 4, 8 ]:
> +            raise ValueError('nxp,fspi-flashpadtype can be 1, 2, 4, 8 only.')
> +        if not self.fspi_readsampleclksrc in [ 0, 1, 3 ]:
> +            raise ValueError('nxp,fspi-readsampleclksrc can be 0, 1, 3 only.')
> +        if not self.fspi_serialclkfreq in [ 1, 2, 3, 4, 5, 6, 7, 8 ]:
> +            raise ValueError('nxp,fspi-serialclkfreq can be 1..8 only.')
>           self.ReadEntries()
>   
>       def BuildSectionData(self, required):
> @@ -59,10 +96,52 @@ class Entry_nxp_imx8mimage(Entry_mkimage):
>           if self.mkimage.run_cmd(*args) is not None:
>               outdata = tools.read_file(output_fname)
>               if self.boot_from == 'fspi':
> -                spidata = tools.read_file(os.path.join(tools.get_output_dir(), self.fspi_header))
> -                if len(spidata) != 448:
> -                    raise ValueError("FSPI header is not 448 Bytes long")
> -                spidata += tools.get_bytes(0, 0x1000 - len(spidata))
> +                # 0x00 ... Tag
> +                spidata = struct.pack('<I', 0x42464346)
> +                # 0x04 ... Version
> +                spidata += struct.pack('<I', 0x56010000)
> +                # 0x08 ... Reserved
> +                spidata += struct.pack('<I', 0)
> +                # 0x0c ... readSampleClkSrc (LSByte at 0x0c), dataHoldTime,
> +                #          dataSetupTime, columnAdressWidth (MSByte at 0x0f)
> +                spidata += struct.pack('<I', 0x00030300 |
> +                    (self.fspi_columnadresswidth << 24) |
> +                    self.fspi_readsampleclksrc)
> +
> +                # 0x10..0x3f ... Padding
> +                spidata += tools.get_bytes(0, 0x30)
> +
> +                # 0x40 ... controllerMiscOption
> +                spidata += struct.pack('<I',
> +                    ((1 << 0) if self.fspi_controllermisc_diffclk else 0) |
> +                    ((1 << 3) if self.fspi_controllermisc_wordaddr else 0) |
> +                    ((1 << 4) if self.fspi_controllermisc_safecfg else 0) |
> +                    ((1 << 5) if self.fspi_controllermisc_padovr else 0) |
> +                    ((1 << 6) if self.fspi_controllermisc_ddrmode else 0))
> +
> +                # 0x44 ... deviceType (LSByte at 0x44), sflashPadType,
> +                #          serialClkFreq, lutCustomSeqEnable (MSByte at 0x47)
> +                spidata += struct.pack('<I',
> +                    ((1 << 24) if self.fspi_lutcustomseq else 0) |
> +                    (self.fspi_serialclkfreq << 16) |
> +                    (self.fspi_flashpadtype << 8) |
> +                    self.fspi_devicetype)
> +
> +                # 0x48..0x4f ... Padding
> +                spidata += tools.get_bytes(0, 0x8)
> +
> +                # 0x50 ... flashA1Size
> +                spidata += struct.pack('<I', self.fspi_flasha1size)
> +
> +                # 0x54..0x7f ... Padding
> +                spidata += tools.get_bytes(0, 0x2c)
> +
> +                # 0x80 ... lookupTable
> +                spidata += struct.pack('<I', 0x0818040b)
> +                spidata += struct.pack('<I', 0x24043008)
> +
> +                # 0x88..0xfff ... Padding (end of FSPI block is 0x1bf, align to 4k)
> +                spidata += tools.get_bytes(0, 0x1000 - 0xa8)

I'll let people with an i.MX8M review the implementation but I do have 
some feedback to provide on the logic. This essentially removes the 
ability to use an externally-provided fspi_header.bin. So you should fix 
in the same commit arch/arm/dts/imx8mm-u-boot.dtsi and 
arch/arm/dts/imx8mn-u-boot.dtsi to migrate them to the new mechanism... 
Which likely means going through all board defconfigs and figuring out 
which values they use for compiling the mkimage that is used to generate 
this file and then put it in a board-specific -u-boot.dtsi. The other 
issue is downstream which will now be forced to migrate to it. I guess 
it could be fine but another option could be "specify the binary file to 
use or all those arguments instead" and keep current logic and simply 
extend it to support the new arguments. Otherwise, maybe checking the 
argument exists in the DTB and fail hard and tell the user to migrate to 
the new format with multiple arguments (what happens if we remove 
support for nxp,fspi-header-filename but it's still present in the DTS 
and the user hasn't migrated to the new arguments? does it fail the 
build or silently build something that they cannot boot?).

Cheers,
Quentin
