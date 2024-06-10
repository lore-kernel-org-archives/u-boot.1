Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 362CCC27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 14:25:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86D7F8857E;
	Mon, 10 Jun 2024 16:25:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="YPUVO69Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2A988857A; Mon, 10 Jun 2024 16:25:28 +0200 (CEST)
Received: from APC01-PSA-obe.outbound.protection.outlook.com
 (mail-psaapc01olkn2080f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:feae::80f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28A2F88581
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 16:25:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=forbidden405@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COxEKJVhmDdDgGr0NzIjPNcQMZnQp1qwJPqclwIIe5htVRjfNIlWpCVCFv4RBFWggkxMZ5bqmwGHicMDRtEucBa3+RNA3Tgp8Vyr7i/XJmV4uzmmN30HnjuewQyWFDNpu9Ja+DiXzmqwiVNTLsa8oroFAaYD++J5SFP0u3mBd8Z8ST8og/Zhp1xWBMPuHLfGTuvsTpB0+lt4Hr9wLTBLPc7eF5nFYX9VS8N7WG8t/KhDwI0Lnnehvvp0CEbSsrui5gdEl+VLo+Rf2VPYhXqW9VYxQ4zafiHH394SAB3HxWr6VAGEX7tYyVO9t4cI8PtEs/7ENqTUG7raO3fFuYQPeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+R01M5rdVNPlwIZ5CQHc9qMVwBtL+wAZYR1U+52gKSo=;
 b=ZvCZulo+Y35mtKl13G2XuDcQcWdaNY/FGdTZjmpzvrUXRiZz5IteRHJ5WEz5xttOypwDH1BlubxRlcwC/O4rXTLJ/rkxxuwzRnBJlu6f9EarU5D2VTixX3zR/TncD5kYqDEhssFX1B0N+ZQt9Ib1KpASEjh8zO9F2/sBVIZNJ0QTOAEECa5FLJvuFJI1CJFMmrxkiS/FQaK5vut5YIleu4TBRHBC4e+5qSzoVZ5038o1L0zUVcleEN2twB3xveW/oYPVx+DmyahIE1U7A7Tip8L/u8ZBe7SQVhmTRKCnGgykRv4GaVhbel5CWb0OFNGn06AlMV+2JEFN42slN9YVDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+R01M5rdVNPlwIZ5CQHc9qMVwBtL+wAZYR1U+52gKSo=;
 b=YPUVO69Zc+0VvimgIK1hSw0njPpz8JJKqc8qxaQK73hffrpoVB6TLs0+Dyg7AdK4FAu2aUvsEevCen5ayNow08sqNP75NHvpS+MiCqffEDdmvIoZcnglo6mFQc+MAmrssY6zmVY95XrOrMFgNO4HtL2VmOqMMDxh3JKgZkD95EyGKtkrD+r8q2VMxCMJ/MQJpwh7CBTVc2nsMnky+TdGmNoxiq9w3NVRDndWIbgTOmEATfF4wcnb0k6DxBxZLU/EpKEj+XiWvdXEzyyf62NZ/1EIXv1jHy9A8ua6/6HWVTLHI+Hhkf2EiJKr7GiV/hO8J6sjNW19wPGV2Rn65MchRA==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by SEYPR06MB6684.apcprd06.prod.outlook.com (2603:1096:101:176::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 14:25:19 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::67f0:b5df:46f2:9f97]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::67f0:b5df:46f2:9f97%4]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 14:25:19 +0000
Message-ID: <SEZPR06MB6959E033F3220C5D8351072096C62@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Mon, 10 Jun 2024 22:25:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/40] mmc: dw_mmc: Replace fifoth_val property with
 fifo-depth
To: Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini
 <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
References: <20240610011226.4050-1-semen.protsenko@linaro.org>
 <20240610011226.4050-13-semen.protsenko@linaro.org>
Content-Language: en-US
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <20240610011226.4050-13-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [+skqAzDp05zrisgX54bZsYdgwa+Ixb2jxQJ2VX3XDw4h4kB/o+MguIwfl3Srr3eJ]
X-ClientProxiedBy: SI2PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::19) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID: <ed4754ec-98e5-464e-bd3f-5da9974fd8d3@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|SEYPR06MB6684:EE_
X-MS-Office365-Filtering-Correlation-Id: 63a13b36-334f-4abb-c9d2-08dc89592729
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199019|3412199016|440099019;
X-Microsoft-Antispam-Message-Info: /n7H2oG70WewTpdPmRtsz5IqsZ33dIln3GVMF4qWU8NGVucMNasV7vj7h6wv2xeqgqaKqvXr1Ytl0N5XsammJxYGyWxcBrqPpfj/IhR7bFgBvd6A2O5jFBHsk6xWfNU5bJczXTLXnLkksy7wAPLjgSv1ANo9NaBRwSXL6Et9Ml/DIUZkStv79DGu2xxlWYxjXZau5ixuMO6AzoVWwPYjlHG5YIV8q9XmWOvUjBKk0SiY0s244y+8cPLC1F8/RfMdvF0ILDbkQHIQkfN8luPyB9Q0zdh2KhGgixB3zh0xWaXVJ0H/Xh4Px+YTCrUDpSJmlmtkuDOD2/VQYLg/nlORKM5Ub8nd3VX8YILQRKPvlv5y1ZofI8LVKrzHuMhO+6e7FWYM8BFXRtuFXfV9FIa24vV91GMKxlAsT5vv5/iPlkt1nqL+Iv0b6nhXB9O5iwesUT73ux+Xqnd6gRlPmHt3FdTwrat7+E2FXu19dbQ6/gV0EqoavIPwRRlhRVf/PYtO2KvE0RSAPFLDAzc+kr4fo6UdmC49HhfhstAyxWOAxCN1dKT1gFW6K/zxIQ5vtV+y
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wjg5clJhejVhRWljTzRSa29lN1I1VU91b1NmUzlzNEVQZGRWUExXM25mcFIw?=
 =?utf-8?B?ZWdvS1JvTW9ZYUNoMDFxd3BDYUNBZ3BqZk00aHRScFVmQkh1cEtkTTNVQi81?=
 =?utf-8?B?S0JjNHFaUGptWjhnS0szaDd0RDQ3QTRMdy9TMUJ6NDA4eWVSVlJOMGZGUDZt?=
 =?utf-8?B?cFZwSWlvallNZThjcDVuUkk3aGJYdTMxRjRrbjgyOHNRcGdxdHYxdmJMS0VW?=
 =?utf-8?B?U216WmlzYkxra1VITmppOXNVVVRJbVc1d2ZSM2k4c3ZLVUhLV1VpQ3cwWUxV?=
 =?utf-8?B?MCthTXJ4d2ladTViQ2QzVHo2cnZpY2k4ZDYvZGh1UHFHL3lyNGlmTjR4ZHEr?=
 =?utf-8?B?SDhTZzNvU2MvTXlNYzBSbGRaYkhaUTh4WVI1VUFROGxTWDZHM0lrUzlVdml6?=
 =?utf-8?B?RFRTMWx3UlZBOVRXa3MwendOa1FvU0RFM21EYzNRZWFKaEF0alU5bFFqSjA0?=
 =?utf-8?B?aHpJeXl3N1hlNGxXWVlEbk5mRWJmbGxHenVybkdub3kyK0UrV0x3QmpFdE9n?=
 =?utf-8?B?Wm5yL3VQMStoc1hUN2VFRVkybTVDUXpoRkNyNDh1OTJsVVlaVDNEVWE3TDVy?=
 =?utf-8?B?Qk1Yd0xNNVZja0NBS1JjL0NqRUZLUnpYdURWZjdWSU5Vb2dGVlRhRUtCVHJC?=
 =?utf-8?B?dmgwMU14M1o2SUNpRFBJY0pWcTBUYWFmTGhwMGRIZk9kQy9xdFhmSG03V284?=
 =?utf-8?B?UWwxNTBNWCtDZlM0ekZjaDVEMTFSS3FEOWhCYlBmeHZxK1hUL3E5QnpGRU8w?=
 =?utf-8?B?R01pM2JKNGxHU0t1UkZyRlJCRTNrUm1VS2xwMXU5MXJNWXZrZEF1MzlDVUg3?=
 =?utf-8?B?Tzc3TEFrRjkwclJkbCtIeVBmdGt5L0EwcEhlQm9vTjlqUTNZZ0Vsc1FUVW85?=
 =?utf-8?B?RU1rYkJUOURVOGp4bU1XTG9wK3Z4R3ZNZ3VQV0FTSFlhQjZSdUNHM0YxZzVO?=
 =?utf-8?B?MGxOTFl3SFFvTDhRcWVVaEluZmowclAza2VVZG9VWjg0OE43Y3drMHZkeThz?=
 =?utf-8?B?TW9yNDFDKy9tbXBZc0pwOHFJQUg0M2hOT3dOVmZGQnFraS9UOWZxWHIxRzU2?=
 =?utf-8?B?dVNDNFpPVDlvbmlsc1cwK2VCdG5KU2Q5TTQ1RzdrMmVQZlFlWGl1dDNtSGpy?=
 =?utf-8?B?SVRaT1k5b0hmZ3UwUlgwTm1qc0JBeU5oQ0ZWdzJiVllIb1p6WHJJYjMwN3pX?=
 =?utf-8?B?QlVYL2dIKzA5bHJ2RytHbW90U3prVkhoS1UyYkUvd3lzaWpVS3VwM0RMdXF6?=
 =?utf-8?B?ejhuMHp5OVZDSElqRUxqR3FuZU1aZ1hIb3BxUnpCWHpwZzAwaGxub2RWZ0I3?=
 =?utf-8?B?ZDQySktueTRwOUFBUWVtQXpsQ0YxWUhoVlk0SnhYYktvTHJkZm9IdFE3QWRE?=
 =?utf-8?B?b1IyM21HR0JOL2pibVRmd2hjeUg2ajdQVS90MlBBYktwVWNIMUg5RzVGc2xN?=
 =?utf-8?B?UmtKRWJ0L1g4R0hhZitsMnJIN21kOHNmM3NmK25kNEorTWFXS2R0UURpRXpH?=
 =?utf-8?B?aWg0em95ekVFNTEwUExpSEd3UTE5c2c3Mlo2cFhoRVc1ZC95OUU4VmdJU2wz?=
 =?utf-8?B?WmN1RWhObVJVcUhSd0FyNVRRSWJFMmgvaTFPcFZFSklnTHg2UGpPT0krV3R4?=
 =?utf-8?B?b3JHM2lpTzhXWEwzT3AvUVpNeklBR0RadEYyeklvRnVzbUJSY2xpbTQydnJP?=
 =?utf-8?B?KzdGaG1xZFhTNzNIa3RISFFlUFlhSTNPMnpOUjRoMm5Nd1YvV2g5RzRkNWtj?=
 =?utf-8?Q?/04PmATS4n7IU9r07At9j32GjURXXgdOUYFq34J?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a13b36-334f-4abb-c9d2-08dc89592729
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 14:25:18.4428 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6684
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

On 6/10/2024 9:11 AM, Sam Protsenko wrote:
> Replace fifoth_val property with its fifo-depth counterpart in all DW
> MMC drivers. fifo-depth is a common property used in upstream Linux
> kernel. The FIFOTH register value will be calculated using fifo-depth
> value in DW MMC core (dw_mmc.c). This change reduces code duplication in
> platform drivers, and pulls common FIFOTH register value calculation
> into core dw_mmc driver where it belongs.
>
> No functional change.
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>   drivers/mmc/dw_mmc.c          | 21 +++++++++++++--------
>   drivers/mmc/exynos_dw_mmc.c   | 10 +++++-----
>   drivers/mmc/ftsdc010_mci.h    |  1 -
>   drivers/mmc/hi6220_dw_mmc.c   |  7 +++----
>   drivers/mmc/nexell_dw_mmc.c   |  5 +----
>   drivers/mmc/rockchip_dw_mmc.c |  5 +----
>   drivers/mmc/snps_dw_mmc.c     |  6 ++----
>   drivers/mmc/socfpga_dw_mmc.c  |  4 ++--
>   include/dwmmc.h               |  4 ++--
>   9 files changed, 29 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
> index 7aa3dbbe83ad..8af665a00222 100644
> --- a/drivers/mmc/dw_mmc.c
> +++ b/drivers/mmc/dw_mmc.c
> @@ -218,8 +218,6 @@ static unsigned int dwmci_get_timeout(struct mmc *mmc, const unsigned int size)
>   static int dwmci_data_transfer_fifo(struct dwmci_host *host,
>   				    struct mmc_data *data, u32 mask)
>   {
> -	const u32 fifo_depth = (((host->fifoth_val & RX_WMARK_MASK) >>
> -				 RX_WMARK_SHIFT) + 1) * 2;
>   	const u32 int_rx = mask & (DWMCI_INTMSK_RXDR | DWMCI_INTMSK_DTO);
>   	const u32 int_tx = mask & DWMCI_INTMSK_TXDR;
>   	int ret = 0;
> @@ -254,8 +252,8 @@ static int dwmci_data_transfer_fifo(struct dwmci_host *host,
>   			if (ret < 0)
>   				break;
>   
> -			len = fifo_depth - ((len >> DWMCI_FIFO_SHIFT) &
> -					    DWMCI_FIFO_MASK);
> +			len = host->fifo_depth - ((len >> DWMCI_FIFO_SHIFT) &
> +						  DWMCI_FIFO_MASK);
>   			len = min(size, len);
>   			for (i = 0; i < len; i++)
>   				dwmci_writel(host, DWMCI_DATA, *buf++);
> @@ -656,16 +654,23 @@ static int dwmci_set_ios(struct mmc *mmc)
>   
>   static void dwmci_init_fifo(struct dwmci_host *host)
>   {
> -	if (!host->fifoth_val) {
> +	u32 fifo_thr, fifoth_val;
> +
> +	if (!host->fifo_depth) {
>   		u32 fifo_size;
>   
> +		/*
> +		 * Automatically detect FIFO depth from FIFOTH register.
> +		 * Power-on value of RX_WMark is FIFO_DEPTH-1.
> +		 */
>   		fifo_size = dwmci_readl(host, DWMCI_FIFOTH);
>   		fifo_size = ((fifo_size & RX_WMARK_MASK) >> RX_WMARK_SHIFT) + 1;
> -		host->fifoth_val = MSIZE(0x2) | RX_WMARK(fifo_size / 2 - 1) |
> -				   TX_WMARK(fifo_size / 2);
> +		host->fifo_depth = fifo_size;
>   	}
>   
> -	dwmci_writel(host, DWMCI_FIFOTH, host->fifoth_val);
> +	fifo_thr = host->fifo_depth / 2;
> +	fifoth_val = MSIZE(0x2) | RX_WMARK(fifo_thr - 1) | TX_WMARK(fifo_thr);
> +	dwmci_writel(host, DWMCI_FIFOTH, fifoth_val);
>   }
>   
>   static void dwmci_init_dma(struct dwmci_host *host)
> diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
> index 2f849c43b129..14cb0c05cb55 100644
> --- a/drivers/mmc/exynos_dw_mmc.c
> +++ b/drivers/mmc/exynos_dw_mmc.c
> @@ -151,8 +151,8 @@ static int do_dwmci_init(struct dwmci_host *host)
>   	return exynos_dwmci_core_init(host);
>   }
>   
> -static int exynos_dwmci_get_config(const void *blob, int node,
> -				   struct dwmci_host *host,
> +static int exynos_dwmci_get_config(struct udevice *dev, const void *blob,
> +				   int node, struct dwmci_host *host,
>   				   struct dwmci_exynos_priv_data *priv)
>   {
>   	int err = 0;
> @@ -201,7 +201,7 @@ static int exynos_dwmci_get_config(const void *blob, int node,
>   			priv->sdr_timing = DWMMC_MMC2_SDR_TIMING_VAL;
>   	}
>   
> -	host->fifoth_val = fdtdec_get_int(blob, node, "fifoth_val", 0);
> +	host->fifo_depth = dev_read_u32_default(dev, "fifo-depth", 0);
>   	host->bus_hz = fdtdec_get_int(blob, node, "bus_hz", 0);
>   	host->div = fdtdec_get_int(blob, node, "div", 0);
>   
> @@ -217,8 +217,8 @@ static int exynos_dwmmc_probe(struct udevice *dev)
>   	struct dwmci_host *host = &priv->host;
>   	int err;
>   
> -	err = exynos_dwmci_get_config(gd->fdt_blob, dev_of_offset(dev), host,
> -				      priv);
> +	err = exynos_dwmci_get_config(dev, gd->fdt_blob, dev_of_offset(dev),
> +				      host, priv);
>   	if (err)
>   		return err;
>   	err = do_dwmci_init(host);
> diff --git a/drivers/mmc/ftsdc010_mci.h b/drivers/mmc/ftsdc010_mci.h
> index 782d92be2f5f..36187cfa04f6 100644
> --- a/drivers/mmc/ftsdc010_mci.h
> +++ b/drivers/mmc/ftsdc010_mci.h
> @@ -28,7 +28,6 @@ struct ftsdc010_chip {
>   	int dev_index;
>   	int dev_id;
>   	int buswidth;
> -	u32 fifoth_val;
>   	struct mmc *mmc;
>   	void *priv;
>   	bool fifo_mode;
> diff --git a/drivers/mmc/hi6220_dw_mmc.c b/drivers/mmc/hi6220_dw_mmc.c
> index dc0210402bd2..e0b473f3f55c 100644
> --- a/drivers/mmc/hi6220_dw_mmc.c
> +++ b/drivers/mmc/hi6220_dw_mmc.c
> @@ -37,7 +37,7 @@ struct hi6220_dwmmc_priv_data {
>   struct hisi_mmc_data {
>   	unsigned int clock;
>   	bool use_fifo;
> -	u32 fifoth_val;
> +	u32 fifo_depth;
>   };
>   
>   static int hi6220_dwmmc_of_to_plat(struct udevice *dev)
> @@ -126,7 +126,7 @@ static int hi6220_dwmmc_probe(struct udevice *dev)
>   	host->mmc = &plat->mmc;
>   
>   	host->fifo_mode = mmc_data->use_fifo;
> -	host->fifoth_val = mmc_data->fifoth_val;
> +	host->fifo_depth = mmc_data->fifo_depth;
>   	host->mmc->priv = &priv->host;
>   	upriv->mmc = host->mmc;
>   	host->mmc->dev = dev;
> @@ -159,8 +159,7 @@ static const struct hisi_mmc_data hi6220_mmc_data = {
>   static const struct hisi_mmc_data hi3798mv2x_mmc_data = {
>   	.clock = 50000000,
>   	.use_fifo = false,
> -	// FIFO depth is 256
> -	.fifoth_val = MSIZE(4) | RX_WMARK(0x7f) | TX_WMARK(0x80),
> +	.fifo_depth = 256,
>   };
>   


For HiSilicon changes in hi6220_dw_mmc.c,


Reviewed-by: Yang Xiwen <forbidden405@outlook.com>


>   static const struct udevice_id hi6220_dwmmc_ids[] = {
> diff --git a/drivers/mmc/nexell_dw_mmc.c b/drivers/mmc/nexell_dw_mmc.c
> index 2723e4887cf7..aad848ca2825 100644
> --- a/drivers/mmc/nexell_dw_mmc.c
> +++ b/drivers/mmc/nexell_dw_mmc.c
> @@ -187,10 +187,7 @@ static int nexell_dwmmc_probe(struct udevice *dev)
>   	struct dwmci_host *host = &priv->host;
>   	struct udevice *pwr_dev __maybe_unused;
>   
> -	host->fifoth_val = MSIZE(0x2) |
> -		RX_WMARK(priv->fifo_size / 2 - 1) |
> -		TX_WMARK(priv->fifo_size / 2);
> -
> +	host->fifo_depth = priv->fifo_size;
>   	host->fifo_mode = priv->fifo_mode;
>   
>   	dwmci_setup_cfg(&plat->cfg, host, priv->max_freq, priv->min_freq);
> diff --git a/drivers/mmc/rockchip_dw_mmc.c b/drivers/mmc/rockchip_dw_mmc.c
> index ad4529d6afa8..d52ae9cb6fd8 100644
> --- a/drivers/mmc/rockchip_dw_mmc.c
> +++ b/drivers/mmc/rockchip_dw_mmc.c
> @@ -139,10 +139,7 @@ static int rockchip_dwmmc_probe(struct udevice *dev)
>   	if (ret < 0)
>   		return ret;
>   #endif
> -	host->fifoth_val = MSIZE(0x2) |
> -		RX_WMARK(priv->fifo_depth / 2 - 1) |
> -		TX_WMARK(priv->fifo_depth / 2);
> -
> +	host->fifo_depth = priv->fifo_depth;
>   	host->fifo_mode = priv->fifo_mode;
>   
>   #if CONFIG_IS_ENABLED(MMC_PWRSEQ)
> diff --git a/drivers/mmc/snps_dw_mmc.c b/drivers/mmc/snps_dw_mmc.c
> index 0134399e3934..4a72f41ef16f 100644
> --- a/drivers/mmc/snps_dw_mmc.c
> +++ b/drivers/mmc/snps_dw_mmc.c
> @@ -82,7 +82,7 @@ static int snps_dwmmc_of_to_plat(struct udevice *dev)
>   	host->ioaddr = dev_read_addr_ptr(dev);
>   
>   	/*
> -	 * If fifo-depth is unset don't set fifoth_val - we will try to
> +	 * If fifo-depth is unset don't set fifo_depth - we will try to
>   	 * auto detect it.
>   	 */
>   	ret = dev_read_u32(dev, "fifo-depth", &fifo_depth);
> @@ -90,9 +90,7 @@ static int snps_dwmmc_of_to_plat(struct udevice *dev)
>   		if (fifo_depth < FIFO_MIN || fifo_depth > FIFO_MAX)
>   			return -EINVAL;
>   
> -		host->fifoth_val = MSIZE(0x2) |
> -				   RX_WMARK(fifo_depth / 2 - 1) |
> -				   TX_WMARK(fifo_depth / 2);
> +		host->fifo_depth = fifo_depth;
>   	}
>   
>   	host->buswidth = dev_read_u32_default(dev, "bus-width", 4);
> diff --git a/drivers/mmc/socfpga_dw_mmc.c b/drivers/mmc/socfpga_dw_mmc.c
> index 387cb8b6b50a..f795472d10f7 100644
> --- a/drivers/mmc/socfpga_dw_mmc.c
> +++ b/drivers/mmc/socfpga_dw_mmc.c
> @@ -135,8 +135,8 @@ static int socfpga_dwmmc_of_to_plat(struct udevice *dev)
>   	 * We only have one dwmmc block on gen5 SoCFPGA.
>   	 */
>   	host->dev_index = 0;
> -	host->fifoth_val = MSIZE(0x2) |
> -		RX_WMARK(fifo_depth / 2 - 1) | TX_WMARK(fifo_depth / 2);
> +
> +	host->fifo_depth = fifo_depth;
>   	priv->drvsel = fdtdec_get_uint(gd->fdt_blob, dev_of_offset(dev),
>   				       "drvsel", 3);
>   	priv->smplsel = fdtdec_get_uint(gd->fdt_blob, dev_of_offset(dev),
> diff --git a/include/dwmmc.h b/include/dwmmc.h
> index de18fda68ac8..7bb456e792b4 100644
> --- a/include/dwmmc.h
> +++ b/include/dwmmc.h
> @@ -187,7 +187,7 @@ struct dwmci_idmac_regs {
>    * @dev_index:	Arbitrary device index for use by controller
>    * @dev_id:	Arbitrary device ID for use by controller
>    * @buswidth:	Bus width in bits (8 or 4)
> - * @fifoth_val:	Value for FIFOTH register (or 0 to leave unset)
> + * @fifo_depth:	Depth of FIFO, bytes (or 0 for automatic detection)
>    * @mmc:	Pointer to generic MMC structure for this device
>    * @priv:	Private pointer for use by controller
>    * @dma_64bit_address: Whether DMA supports 64-bit address mode or not
> @@ -204,7 +204,7 @@ struct dwmci_host {
>   	int dev_index;
>   	int dev_id;
>   	int buswidth;
> -	u32 fifoth_val;
> +	u32 fifo_depth;
>   	struct mmc *mmc;
>   	void *priv;
>   


-- 
Regards,
Yang Xiwen

