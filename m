Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2454EF8FA7A
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 13:42:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97121839D5;
	Tue, 21 Apr 2026 15:42:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ftXG/9XE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B48383BC4; Tue, 21 Apr 2026 15:42:38 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D10C680433
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 15:42:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cMdfHCHsXiY22jriyt9+omENP0S5OtOAgLio5RWkwGqunI07S0eQWPsnfZjz1PaRofpIuzIS7PX9oVkygaZylgdEkZHHHyhS5eKDmuG3e1XmH9Ip3qoNXkE0nxW6IQBI5LJkXhd9MWGmtXPg+MnmnWmwpMdVi4HCmUr1RoH+0n26do68L6SwtSENHRzsh4+3xHTLKhXGRm5cNhTdyv8I9RtQ+1P0+pP5/fN5Hxd1rhtYjsUyM7XALbX46R5x0phh7It6GF0fi245xr3fstt2ICzTbf8fZiLAxr8VwnR3XUP+NtpB0QW5ODqWC/B/dVkJE+NcSG76FmB8BhRyxJBRDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M6zrThstcB6EMKzk+AK7aXqRynkCVavDLqpzUivPALk=;
 b=RkNoGN8rdv3NGugDAYHhif88a3WsCyxQmjRgmZZ6wqLg9rcvVBP/SwU0HvpsPwbEDxP2tXwcs6HWS6bNYOM/QS5oCvFdxsud1o4dD2uH+CJwKzcv20Ha953YQiICRFR/fz5/LJROUeeHefky5MQglBswm+1i74osqkLk9CEVMsK8B6NAdbWoImFhSmUbDu/GGN0m/njzepVuLg4LhztDHlQ6UBGeZ2AZvdcvKoJYG3z3W/9Syy/PpjFmQRDmZEicE5zBoxa4t1d4duqPFXunM2DGUul2nvmWtgcXdb23K9sAqul+wn7EjAiezyrbNe/ipzBIipE1eNjZFTCL1G2ENQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6zrThstcB6EMKzk+AK7aXqRynkCVavDLqpzUivPALk=;
 b=ftXG/9XEQHOYUzPisnZIv5PVGzEp3J4SqOc7rMEjVelt0kyHNXlH+dt6hf6fMExVzXuc6Y6SmTGHmu5uP33PBhVDhFkpLsCc6S2NR51lwRp11mtxCSQlqhNZczGOFQ0kviW4s6Js1hqqt4kOwoqFijmd6tMmcGLJnmrvaikRM3E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AM7PR04MB6885.eurprd04.prod.outlook.com (2603:10a6:20b:10d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Tue, 21 Apr
 2026 13:42:32 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%4]) with mapi id 15.20.9818.033; Tue, 21 Apr 2026
 13:42:32 +0000
Message-ID: <5016a59a-c2b8-4676-b18e-877aabdeec27@cherry.de>
Date: Tue, 21 Apr 2026 15:42:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tools: mkeficapsule: Rework pkcs11 support
To: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, u-boot@lists.denx.de
Cc: Franz Schnyder <fra.schnyder@gmail.com>, trini@konsulko.com,
 "openembedded-core @ lists . openembedded . org"
 <openembedded-core@lists.openembedded.org>,
 Francesco Dolcini <francesco@dolcini.it>, Simon Glass <sjg@chromium.org>,
 David Lechner <dlechner@baylibre.com>
References: <20260421121418.3257226-1-Wojciech.Dubowik@mt.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260421121418.3257226-1-Wojciech.Dubowik@mt.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0065.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::18) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AM7PR04MB6885:EE_
X-MS-Office365-Filtering-Correlation-Id: d659bcdc-376e-471a-1fe1-08de9fabd68b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 38NnA7fciVv0ya7t+ko2SMZyoRkEOr80TSrFF5tPnBUyO3f4AxNNy3J1dhABFuxS+4UMDdKOkla2diGBV2zW5z6T3vYYbqUYoyNAf5Qq/D03s8wgbaalJDkV37uzm0ih89l6a6sDFhVxhfMHVFY2ACBdwUT4qSM/pTTgpFSQ+bf3xVs7Cgr4HTqsyaszfDQx1+QxM8R+kvIL8c9+rSpkTv8rDFpMmhHau4DRefMBPnDPCdaLu+FRTIQfDnbF3FlCn9qHhK0kbZmiLrA7Y09mowjM9rV5mCct9F6yr51Lw8F0tqhfVAOXqG8qPHG4DQ3UTORS1BMBQHU3r4SFxXLKNTgf9fVAl4zPCj22CMQEYdgzljeYhsrITZGqpsVqsXdXT0dCjXYBi2vgePt+k0NnfiBTZ0817loArYRV2g2Cn+eSMHAzLLFQeHmWk+ed30WmcqJ2+K+VICQQj/Sp9p5gSGkXivGEaK9EnaPs5J8FYHCMp2inUplDw+94neWxayG6ommnGO2pf4bs8O3Ub/g+0atxqPNEm/vb/kAKd30GKJQolX2cW6QkLqT/dMMhTB3DyQW0mSpxv/r3ipXoH0SYK9fVlb0Q6/pt1vFPlfyOGzi9mW3dtYGJmEtEVfvJPF6iVMklUKPB4b6tKTvIZlFeYxHHpjgc6pnIDos8XwyyG47+QihOr3C+Toq4SFYDG4GMsz/zb8kdn76C+IFQTOtFURdanpkpltZ7sgkcoyJf+/I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VklGZW85elVxeE9EdDJ6ZHVMTEFoTEllb3dkSjltYzRPM1RkdDdoS1NiTy9X?=
 =?utf-8?B?N2taVHFwOXk5Y2c1SStKNzVpM3MrQWl0UUU3anY2VFA3RTRUbzNEYTB6Yk5K?=
 =?utf-8?B?Z0ZQdTJ3b2VtcXhNRGJoWHEzYzFyTlEzVEowYTBCSURud0FmWktrU2hsR1U1?=
 =?utf-8?B?RVgvOStRZnNmZzRrOXYybVMxSHRtUDRTYzhDSUhYdXJDUzVxNUlYalRsc01n?=
 =?utf-8?B?bHVEY0wzRzkwOGpxamtVbU5hdW16bXJrRjlVWG9YbXRrVFNBMlN0TFBWeFI2?=
 =?utf-8?B?Q3JSVnlaSjFEcWlwRnJ4bEpyZU5yN2hUQnNhWmx0ek5Zb0F3U0NMSkIxVDJU?=
 =?utf-8?B?eFpzRkNiTDF3UlFlWkNXYjRCTVlpU1hSVUpPa040K3VxK1dWamJNbkxLa2tH?=
 =?utf-8?B?eW9Ub2tOMjdkNm1JWE5XNjNGS0g5U2lZbERyMENCaktZZHRYSzlEa1BrNWN3?=
 =?utf-8?B?c3Z2MHZNNnV6VlFYN3lRcnJQY2l0Tk8yaUVudjErbGVEVHhWTXE1dGx0UjFw?=
 =?utf-8?B?VHFHcGtGS1IvUlUyQ05VY0dNTU44eVlLUm1ydGZvTVAwTzA2Z3R4Wlo0RVZS?=
 =?utf-8?B?UDVRVlNIU2tWRFF0VlFEV29JSzB2YkRzN0ZyQ1NNR0IzdHdDVWRjZXVUMjI3?=
 =?utf-8?B?aW9ERER2RlBBNHowdG5XY3RjYk5wT0k1elJpNTNqSHFpb1k5UVpiY0FOT0k2?=
 =?utf-8?B?TCtDMW45elo5TS8vMXFpdEtXMktycTVZVmI5WWhYVXFOVm8rYVpoY1VpaVZQ?=
 =?utf-8?B?M3QrZG8xNWRWUTNnc1hFbHNNODFma0ZjRGxMeHFPa2ZNWGhxT1VaSE5BbGIy?=
 =?utf-8?B?dVNDWDJYaFhndGNpTzRkTjMxeTZyek4zZjJmaFUyODUvUkYrYWFRRzFPQW9V?=
 =?utf-8?B?MW9kejdYTE1FZVRYd045bTJzUjU1S09KcnRNQzZQcGZhcXY4bVllc25kLytt?=
 =?utf-8?B?ZEJvRVp0K1BNQTdXZWRjTzg4YVdQbGJJVE03M3I0TU16MkJXUlI2WHdmMDhG?=
 =?utf-8?B?ZkdvSi8yNHlWTSs3cUhTbm5JZW56OXNZL2ZiTndKaFlMTHJMMFlRbFdPM21v?=
 =?utf-8?B?eHczbUU2UjJ1eGxiTGpmbDkvMmxnSWVrNW82UmZ6L2NLVDBwRVhTOXpYcDFZ?=
 =?utf-8?B?STBqaUdpc2hFdFFRVGZid2JhbDBMTzJrVTVGcWxRYUFEYTVoN3NXVkNXKzU4?=
 =?utf-8?B?Zk1Oalg4T3ByQWx2OGRUQ3MwVXBmeklscUc4b2xMVHlLdmVCdThMeGVPblZ1?=
 =?utf-8?B?L25HU3E4Q1R2eHBrcnFwSjFteTJsME80ZXZGS3dKR0xZcGJCbUxMQk0wbVpX?=
 =?utf-8?B?eCt0c1R0RWRMTDIyRFU5ZzMwQ3BRb1hQd0VzMkRmMEVYdDZjTFZwNzlZZjdU?=
 =?utf-8?B?aUY3QTFTWnUyMDhzaC9HMnNVbFJhYWRsSnBWZ1p1NEpJVGx6d0liU1lVa3hp?=
 =?utf-8?B?WHdmcnVHWk01WE56RnRzVFZwWTdTTm4wZjdDeGJWbjJWajB5dEtGNzhleWg0?=
 =?utf-8?B?elpaaWg2U0F0eXVXZkpIUkxlNVg0aEUrSjB5TWdlRmFDQ2VSeUJ2T1dvZ3ZU?=
 =?utf-8?B?ZUNBa1poV2VYUFVNaWRsVU5rWWExU3BSOG9LZ0RVZ2lUNGtiQ000Skd4Ymdm?=
 =?utf-8?B?bG8xc3NCc2w3RWJzYjRGU3liWm52Z1hHaktHcUpsUytiNnkzbHhCZVpyajRo?=
 =?utf-8?B?YUdGazFkVkxKbG9KaFIzZDlUM2pzdUpINm5Sd21oNFFMVHhrbmJKbG04dlYr?=
 =?utf-8?B?a1ViaThtY0d6bDdHVW96VStQb3VFUGsvWEpxNUZyekJEVUpLR3Z1NUUxZjZh?=
 =?utf-8?B?dDBMUVRaYitDWkZpcUtCckViZkNVeit6ellBajlVdmhYbnBzTzR1dVM3WUYr?=
 =?utf-8?B?UmIzT0VkUzJDS1JHN3UxUlVIYkZxM2xBblFwb0Z2S3hYMEdBN3R6dUtGSlNJ?=
 =?utf-8?B?bGxhR0FLcWhQTWtMb0dwYVQxRVp2bG90YlBORzh6VWhWZDMzZ0piVHRoRkpw?=
 =?utf-8?B?NWdpak1zbmduRUg1bHl2dXRTWlVBMmhoMGFjTFgyMTdEZWJvd1ZQQmNSK21J?=
 =?utf-8?B?WC8vVU5rUFZxZk83dFIvY1dRT3hyTzR5dzI4VHFSVFlzWVdSVGRrSHAyOG0v?=
 =?utf-8?B?Sy9WSlpsRTRqbkg3bWVGUmRwU04vczRmbVA5TFVkZ0loVm5iWmhrK1J5S2lu?=
 =?utf-8?B?RVh2QVI3QXN2S0tTeUpkRGNKZ28zMkNIK1AxMnphYkFPSTdaeC9QZnFoSit6?=
 =?utf-8?B?KzlhV0kzVEdUUjFkZEhQVVFhT3lZUHJpS3NIUkt6eDdZK3Bhd2NzZndVZTVj?=
 =?utf-8?B?aVNGZmNwODhkQ202NE5KR0RtOUUrby8rU01PaWRmdXdYOHZyK2dEUVJOUEtR?=
 =?utf-8?Q?kF2AVCq7vU5yH+Z+XMu18xcpO/k1WsSmokhiY?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d659bcdc-376e-471a-1fe1-08de9fabd68b
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 13:42:32.2298 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WnLqHp9t6E7xmpReqWLlWVRp1S3A8TV1M+WqSTzYQbdAK1BOf8rTjMMrEhPk/EgCOr/EoCpahPUePU1H35zGvStcxw9fsFvXbaC4lb0ti9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6885
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

Hi Wojciech,

On 4/21/26 2:14 PM, Wojciech Dubowik wrote:
> Some distros like OpenEmbedded are using gnutls library
> without pkcs11 support and linking of mkeficapsule will fail.
> It would make maintenance of default configs a hurdle.
> Add detection of pkcs11 support in gnutls so it's enabled
> when available and doesn't need to be set explicitly.
> 
> Changes:
> * remove config option for pkcs11 support and add auto
>    detection in Makefile
> * reduce amount of ifdefs by abstracting import pkcs11
>    functions
> * add missing free and deinit functions
No, this must be a separate patch.

We also don't need a changelog between patch versions in the commit log 
(place it below the ---).

> 
> Suggested-by: Tom Rini <trini@konsulko.com>
> Cc: Franz Schnyder <fra.schnyder@gmail.com>
> Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> ---
> Changes in v3:
> - remove config option for pkcs11 support and add auto
>    detection in Makefile
> - reduce amount of ifdefs by abstracting import pkcs11
>    functions
> - add missing free and deinit functions
> Changes in v2:
> - make use of stderr more consistent
> - add missing ifndef around pkcs11 deinit functions
> ---
>   tools/Makefile       |   5 ++
>   tools/mkeficapsule.c | 117 ++++++++++++++++++++++++++++---------------
>   2 files changed, 81 insertions(+), 41 deletions(-)
> 
> diff --git a/tools/Makefile b/tools/Makefile
> index 1a5f425ecdaa..e85f5a354b81 100644
> --- a/tools/Makefile
> +++ b/tools/Makefile
> @@ -271,6 +271,11 @@ mkeficapsule-objs := generated/lib/uuid.o \
>   	$(LIBFDT_OBJS) \
>   	mkeficapsule.o
>   hostprogs-always-$(CONFIG_TOOLS_MKEFICAPSULE) += mkeficapsule
> +GNUTLS_SUPPORTS_P11KIT = $(shell pkg-config --libs gnutls --print-requires-private \
> +			 2> /dev/null | grep p11-kit-1)
> +ifeq ($(GNUTLS_SUPPORTS_P11KIT),p11-kit-1)
> +HOSTCFLAGS_mkeficapsule.o += -DMKEFICAPSULE_PKCS11
> +endif
>   
>   include tools/fwumdata_src/fwumdata.mk
>   
> diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
> index ec640c57e8a5..747431bce8fe 100644
> --- a/tools/mkeficapsule.c
> +++ b/tools/mkeficapsule.c
> @@ -207,6 +207,45 @@ static int write_capsule_file(FILE *f, void *data, size_t size, const char *msg)
>   	return 0;
>   }
>   
> +#ifdef MKEFICAPSULE_PKCS11
> +static int import_pkcs11_crt(gnutls_x509_crt_t *x509, struct auth_context *ctx)
> +{
> +	gnutls_pkcs11_obj_t *obj_list;
> +	unsigned int obj_list_size = 0;
> +	int i, ret;
> +
> +	ret = gnutls_pkcs11_obj_list_import_url4(&obj_list, &obj_list_size,
> +						 ctx->cert_file, 0);
> +	if (ret < 0 || obj_list_size == 0)
> +		return ret;
> +
> +	ret = gnutls_x509_crt_import_pkcs11(*x509, obj_list[0]);
> +
> +	for (i = 0; i < obj_list_size; i++)
> +                gnutls_pkcs11_obj_deinit(obj_list[i]);
> +	gnutls_free(obj_list);
> +
> +	return ret;
> +}
> +
> +static int import_pkcs11_key(gnutls_privkey_t *pkey, struct auth_context *ctx)
> +{
> +	return gnutls_privkey_import_pkcs11_url(*pkey, ctx->key_file);
> +}
> +#else
> +static int import_pkcs11_crt(gnutls_x509_crt_t *x509, struct auth_context *ctx)
> +{
> +	fprintf(stderr, "Pkcs11 support is disabled\n");
> +	return -1;
> +}
> +
> +static int import_pkcs11_key(gnutls_privkey_t *pkey, struct auth_context *ctx)
> +{
> +	fprintf(stderr, "Pkcs11 support is disabled\n");
> +	return -1;
> +}
> +#endif
> +
>   /**
>    * create_auth_data - compose authentication data in capsule
>    * @auth_context:	Pointer to authentication context
> @@ -221,17 +260,14 @@ static int write_capsule_file(FILE *f, void *data, size_t size, const char *msg)
>    */
>   static int create_auth_data(struct auth_context *ctx)
>   {
> -	gnutls_datum_t cert;
> -	gnutls_datum_t key;
> +	gnutls_datum_t cert = { NULL, 0 };
> +	gnutls_datum_t key = { NULL, 0 };
>   	off_t file_size;
> -	gnutls_privkey_t pkey;
> +	gnutls_privkey_t pkey = NULL;
>   	gnutls_x509_crt_t x509;
>   	gnutls_pkcs7_t pkcs7;
> -	gnutls_datum_t data;
> -	gnutls_datum_t signature;
> -	gnutls_pkcs11_obj_t *obj_list;
> -	unsigned int obj_list_size = 0;
> -	const char *lib;
> +	gnutls_datum_t data = { NULL, 0 };
> +	gnutls_datum_t signature = { NULL, 0 };
>   	int ret;
>   	bool pkcs11_cert = false;
>   	bool pkcs11_key = false;
> @@ -242,10 +278,12 @@ static int create_auth_data(struct auth_context *ctx)
>   	if (!strncmp(ctx->key_file, "pkcs11:", strlen("pkcs11:")))
>   		pkcs11_key = true;
>   
> +#ifdef MKEFICAPSULE_PKCS11
>   	if (pkcs11_cert || pkcs11_key) {

This one also in a separate function. As far as I could tell, we should 
return -1 here if PKCS11 support isn't available in gnutls. We shouldn't 
continue if we already know we are going to fail. We do need the code 
below to be ifdef'ed (in functions like you've done is fine), because 
somehow the compiler isn't smart enough to build those out and thus 
we'll fail to build if pkcs11 support is disabled, even if we can never 
reach that part of the code.

> +		const char *lib;
>   		lib = getenv("PKCS11_MODULE_PATH");
>   		if (!lib) {
> -			fprintf(stdout,
> +			fprintf(stderr,
>   				"PKCS11_MODULE_PATH not set in the environment\n");
>   			return -1;
>   		}
> @@ -255,10 +293,11 @@ static int create_auth_data(struct auth_context *ctx)
>   
>   		ret = gnutls_pkcs11_add_provider(lib, "trusted");
>   		if (ret < 0) {
> -			fprintf(stdout, "Failed to add pkcs11 provider\n");
> +			fprintf(stderr, "Failed to add pkcs11 provider\n");
>   			return -1;
>   		}
>   	}
> +#endif
>   
>   	if (!pkcs11_cert) {
>   		ret = read_bin_file(ctx->cert_file, &cert.data, &file_size);
> @@ -296,35 +335,33 @@ static int create_auth_data(struct auth_context *ctx)
>   	if (ret < 0) {
>   		fprintf(stderr, "error in gnutls_x509_crt_init(): %s\n",
>   			gnutls_strerror(ret));
> -		return -1;
> +		goto cleanup;
>   	}
>   
>   	/* load x509 certificate */
>   	if (pkcs11_cert) {
> -		ret = gnutls_pkcs11_obj_list_import_url4(&obj_list, &obj_list_size,
> -							 ctx->cert_file, 0);
> -		if (ret < 0 || obj_list_size == 0) {
> -			fprintf(stdout, "Failed to import crt_file URI objects\n");
> -			return -1;
> +		ret =  import_pkcs11_crt(&x509, ctx);
> +		if (ret < 0) {
> +			fprintf(stderr, "error in import_pkcs11_crt(): %s\n",
> +				gnutls_strerror(ret));
> +			goto cleanup;
>   		}
> -
> -		gnutls_x509_crt_import_pkcs11(x509, obj_list[0]);
>   	} else {
>   		ret = gnutls_x509_crt_import(x509, &cert, GNUTLS_X509_FMT_PEM);
>   		if (ret < 0) {
>   			fprintf(stderr, "error in gnutls_x509_crt_import(): %s\n",
>   				gnutls_strerror(ret));
> -			return -1;
> +			goto cleanup;
>   		}
>   	}
>   
>   	/* load a private key */
>   	if (pkcs11_key) {
> -		ret = gnutls_privkey_import_pkcs11_url(pkey, ctx->key_file);
> +		ret = import_pkcs11_key(&pkey, ctx);
>   		if (ret < 0) {
> -			fprintf(stderr, "error in %d: %s\n", __LINE__,
> +			fprintf(stderr,	"error in import_pkcs11_key(): %s\n",
>   				gnutls_strerror(ret));
> -			return -1;
> +			goto cleanup;
>   		}
>   	} else {
>   		ret = gnutls_privkey_import_x509_raw(pkey, &key, GNUTLS_X509_FMT_PEM,
> @@ -333,7 +370,7 @@ static int create_auth_data(struct auth_context *ctx)
>   			fprintf(stderr,
>   				"error in gnutls_privkey_import_x509_raw(): %s\n",
>   				gnutls_strerror(ret));
> -			return -1;
> +			goto cleanup;
>   		}
>   	}
>   
> @@ -342,7 +379,7 @@ static int create_auth_data(struct auth_context *ctx)
>   	if (ret < 0) {
>   		fprintf(stderr, "error in gnutls_pkcs7_init(): %s\n",
>   			gnutls_strerror(ret));
> -		return -1;
> +		goto cleanup;
>   	}
>   
>   	/* sign */
> @@ -357,7 +394,7 @@ static int create_auth_data(struct auth_context *ctx)
>   	data.data = malloc(data.size);
>   	if (!data.data) {
>   		fprintf(stderr, "allocating memory (0x%x) failed\n", data.size);
> -		return -1;
> +		goto cleanup;
>   	}
>   	memcpy(data.data, ctx->image_data, ctx->image_size);
>   	memcpy(data.data + ctx->image_size, &ctx->auth.monotonic_count,
> @@ -371,7 +408,7 @@ static int create_auth_data(struct auth_context *ctx)
>   	if (ret < 0) {
>   		fprintf(stderr, "error in gnutls_pkcs7)sign(): %s\n",
>   			gnutls_strerror(ret));
> -		return -1;
> +		goto cleanup;
>   	}
>   
>   	/* export */
> @@ -379,7 +416,8 @@ static int create_auth_data(struct auth_context *ctx)
>   	if (ret < 0) {
>   		fprintf(stderr, "error in gnutls_pkcs7_export2: %s\n",
>   			gnutls_strerror(ret));
> -		return -1;
> +		gnutls_free(signature.data);
> +		goto cleanup;
>   	}
>   	ctx->sig_data = signature.data;
>   	ctx->sig_size = signature.size;
> @@ -391,24 +429,21 @@ static int create_auth_data(struct auth_context *ctx)
>   	ctx->auth.auth_info.hdr.wCertificateType = WIN_CERT_TYPE_EFI_GUID;
>   	memcpy(&ctx->auth.auth_info.cert_type, &efi_guid_cert_type_pkcs7,
>   	       sizeof(efi_guid_cert_type_pkcs7));
> -
> -	/*
> -	 * For better clean-ups,
> -	 * gnutls_pkcs7_deinit(pkcs7);
> -	 * gnutls_privkey_deinit(pkey);
> -	 * gnutls_x509_crt_deinit(x509);
> -	 * free(cert.data);
> -	 * free(key.data);
> -	 * if error
> -	 *   gnutls_free(signature.data);
> -	 */
> -
> +cleanup:
> +	gnutls_x509_crt_deinit(x509);
> +	if (pkey)
> +                gnutls_privkey_deinit(pkey);
> +	gnutls_pkcs7_deinit(pkcs7);
> +	gnutls_free(cert.data);
> +	gnutls_free(key.data);
> +	gnutls_free(data.data);

No, this is unrelated to this pkcs11 fixup. Please have a separate patch 
for this (same for all gotos and variables being assigned a default 
value at the top). The idea is that we should be able to revert a patch 
if something is broken, without reverting unrelated functionality (here, 
either the ability to build without pkcs11 or correctly freeing things 
on error).

> +#ifdef MKEFICAPSULE_PKCS11
>   	if (pkcs11_cert || pkcs11_key) {
>   		gnutls_global_deinit();
>   		gnutls_pkcs11_deinit();
>   	}
> -
> -	return 0;
> +#endif
> +	return ret;
>   }
>   
>   /**

