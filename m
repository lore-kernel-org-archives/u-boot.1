Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E6BDC54FCD
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 22:40:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5BD2B4082F;
	Wed, 29 Jul 2026 22:40:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VZKjL6Vy8FDi; Wed, 29 Jul 2026 22:40:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4960F40825
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785364840;
	bh=vhrvP0cR5Kv5y7mKiM+XtV9f0k5g4dxQ64pWwrwrNpI=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d/4Sulqll6TyGszD9dOvVpv6Zqa4DRAtO7sjOmd8RchpDCxk690l66Frzc58Yq1zk
	 fLOUDpezBhcRnQ5zhCZsaHAh++P1HEQfte6v1zqgeM57N7n3QH3dlzSs5E1534GBqZ
	 EJ/lEcYyIbXx4IjT9L7Vu2QdVKFMBvXSdKv6hzxCMG0UiqjRTCeOUvF8wobDlbrtDv
	 CQUj9hDrNUMVqdnVupibobKMvkbYbrZgoR0C+FS7ijiOQSqe02nFB0Zr3lUIi0/v5c
	 b9TFkpN6LjMOFwXqBkO5gL8+m3AZ7PTOUHzox/mWYLWyUJoDriTjVl4n4iLXWHt0AD
	 cTqNghEzKfv5w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4960F40825;
	Wed, 29 Jul 2026 22:40:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 951A626C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 22:40:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 868806076B
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 22:40:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 347IKrtNtvWC for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 22:40:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 190F060736
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 190F060736
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 190F060736
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 22:40:34 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id D12F98498B; Thu, 30 Jul 2026 00:40:31 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75F678493F
 for <u-boot@lists.denx.de>; Thu, 30 Jul 2026 00:40:29 +0200 (CEST)
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7e9ecd7216cso864440a34.3
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 15:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785364828; x=1785969628;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vhrvP0cR5Kv5y7mKiM+XtV9f0k5g4dxQ64pWwrwrNpI=;
 b=rLMeRP+TkEXs+OVFSr9KvEDO9jP+MUmbBhWtAbMj70QDA7jYAjXjIZBBoTxmjXqxlw
 yX9xmtp6YXkWNjSV82yGy8VFawn0PPzIRsMZ0QJX5JfVC659u9GefukL5ySTmzW8Zh9h
 UV1iYDr9YtPBr/nsA2lYgatKLNSSJRx8KAYhtnhUE1K7ulyLTJHIuypXMNDFzmrTiw2u
 H0zHrAwpZMENcriyIYAcvBf69bGWvfAZlS4jdIrh2OmbrKNKj6inOdPrvSmzm5dlHBSo
 Q53hkcfXZnuagmjRvxkFrG1X5XjTsHVqeDTyVhY+WzysVkS6n/lWc7hdpPCiduZcVGAZ
 tCFw==
X-Forwarded-Encrypted: i=1;
 AHgh+RraDj0Kh2OzFyfuXzuv443AsOlJHiTisRIpv6e0kGRt9R3Gzw9/k0sgVAeasW63jHVnLXpSGes=@lists.denx.de
X-Gm-Message-State: AOJu0YxSIZvjBXRoAz2taAEh5Ez1HLw8g1U22rvXn2Btx2wOPqcQ7HJd
 e94S0VOkj3rSpIKVIGDvmOOLGvQzFK6HFkJ+AUdozu/umiDg2VVX4JJfC8RnFBUe0Ho=
X-Gm-Gg: AR+sD12mwpamfhj96tHHeJHA+a4SDe3Nbaw1nHINnGpvWkpM05w2OeccnWsCWv6Qw1z
 fScVIy30YkkEeuo9u5o4Nkib03rGG5R6QSuLvTVaVVAjOjIj7WWi2MIPjeTuZb+V91TKp4Hc5CD
 fOG3vyn3Cp1gKd+UmAhKcpOwIJfLqUmtD1zbn/g3Nze8eMIOUu+vVegKt+uZ0eIf7gmvKT615wW
 KlCd7tpOUfiZXhG8/jx1EX0ib2YefC4gZHs1QkzwEt22aPYMrIz4qK9aWh2H1tTJQF0yR2pidiF
 6sbtixTTvok4vEBtZ2tEFkRT80TvOxspD+Q7Dbr9eem8X+jWdUIMDmbIkKmFfiVemB1mfh2N4Hf
 NdJvE0LsCmcQcTv51vR30pm9nfbizcelRUs211Bpuy7Ktr9d3+6XCiILjMjB84TkIpbcNBR6u61
 h+sJr3xCJeOTmTjdOee5XjFBJkDHkGtCkfFm+BEal77XoPnDjoutcQBpz6Y5SMo5CnWfBc8pn3b
 MpZu7TU6cpR9hrVrYoP1CaH8/sY8IDPrLPmw0k=
X-Received: by 2002:a05:6820:4b97:b0:6aa:dfe1:b8eb with SMTP id
 006d021491bc7-6acbc04ca59mr178399eaf.37.1785364827889; 
 Wed, 29 Jul 2026 15:40:27 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:ea38:c35b:7ec6:8152?
 ([2600:8803:e7e4:500:ea38:c35b:7ec6:8152])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-458c2138664sm125614fac.0.2026.07.29.15.40.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 15:40:27 -0700 (PDT)
Message-ID: <aafb5591-db56-4bfb-83f0-013b0f873949@baylibre.com>
Date: Wed, 29 Jul 2026 17:40:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] ufs: derive the per-region RPMB CID and size for
 OP-TEE
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 neil.armstrong@linaro.org, trini@konsulko.com, jens.wiklander@linaro.org,
 ilias.apalodimas@linaro.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 bhupesh.linux@gmail.com, n-francis@ti.com, marek.vasut+renesas@mailbox.org,
 igor.belwon@mentallysanemainliners.org, shawn.lin@rock-chips.com,
 alchark@gmail.com, tuyen.dang.xa@renesas.com,
 yoshihiro.shimoda.uh@renesas.com, padmarao.begari@amd.com,
 jstephan@baylibre.com, hayashi.kunihiko@socionext.com,
 macpaul.lin@mediatek.com, venkyada@qti.qualcomm.com, j-mcarthur@ti.com,
 u-boot@lists.denx.de
References: <20260723143852.2287208-1-jorge.ramirez@oss.qualcomm.com>
 <20260723143852.2287208-4-jorge.ramirez@oss.qualcomm.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260723143852.2287208-4-jorge.ramirez@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785364828; x=1785969628; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vhrvP0cR5Kv5y7mKiM+XtV9f0k5g4dxQ64pWwrwrNpI=;
 b=ALz9zoayuCtF0qw88Mj0POxYbmxbxvvmZvypRibLJQ8C6X8pacRhapu0xwkTaqBbhb
 TKS479rDX55CpiqZYiZ+NjXjHNmVZNz0Ljs1WKNguu8ij9zNbnj2RePHC5H4SOluy5rK
 V8cOBeZp+L+7v/MEWHMk2mazgSThNXOQlE+Y1OUgifFiJ2DOpsEPJsCKpWu5u6ZNvpoY
 T/tQm8TBXf6L/sb0RH5WCBwvX6Bfeqsbat7Yh0HY4yY+Gl1pODZbc6IKg/YDfkBRUhzU
 faP1B5ux1OQEOlLbnMJVOVzQql5VooJ3jsWw3gd/Afxvo3y8VWV0fbhguxkh/nwKU2R6
 uJiQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 spf=fail smtp.mailfrom=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=ALz9zoay
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dlechner@baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=baylibre.com header.i=@baylibre.com header.b="ALz9zoay"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/23/26 9:38 AM, Jorge Ramirez-Ortiz wrote:
> OP-TEE computes its RPMB authentication key from a device identifier, so
> U-Boot must hand it the exact same identifier the Linux kernel uses;
> otherwise the derived key differs and OP-TEE cannot access RPMB secure
> storage provisioned under Linux, and vice versa. The OP-TEE RPMB probe
> also needs each region's size and reliable-write count to discover which
> regions exist and how they may be written. Provide both so OP-TEE secure
> storage stays interoperable across U-Boot and Linux on the same device.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> ---
>  drivers/ufs/Kconfig    |   7 +-
>  drivers/ufs/ufs-rpmb.c | 148 +++++++++++++++++++++++++++++++++++++++++
>  include/ufs.h          |   6 ++
>  3 files changed, 159 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
> index 99160a0819b..d39fcda42dc 100644
> --- a/drivers/ufs/Kconfig
> +++ b/drivers/ufs/Kconfig
> @@ -95,11 +95,14 @@ config UFS_TI_J721E
>  config SUPPORT_UFS_RPMB
>  	bool "Enable UFS RPMB (Replay Protected Memory Block) support"
>  	depends on UFS && OPTEE && !SUPPORT_EMMC_RPMB
> +	select BLAKE2
>  	help
>  	  Route OP-TEE RPMB requests to the UFS RPMB Well-Known LUN using
>  	  SCSI SECURITY PROTOCOL IN/OUT commands. Required for OP-TEE secure
>  	  storage (CFG_RPMB_FS) on UFS-based platforms that have no eMMC.
> -	  The OP-TEE supplicant handles a single RPMB transport, so this is
> -	  mutually exclusive with the eMMC RPMB supplicant (SUPPORT_EMMC_RPMB).
> +	  BLAKE2 is used to derive the fixed-length RPMB CID that matches the
> +	  Linux kernel UFS device_id ABI. The OP-TEE supplicant handles a
> +	  single RPMB transport, so this is mutually exclusive with the eMMC
> +	  RPMB supplicant (SUPPORT_EMMC_RPMB).
>  
>  endmenu
> diff --git a/drivers/ufs/ufs-rpmb.c b/drivers/ufs/ufs-rpmb.c
> index fb4cd42ad75..ed5ecc0a5e6 100644
> --- a/drivers/ufs/ufs-rpmb.c
> +++ b/drivers/ufs/ufs-rpmb.c
> @@ -1,10 +1,14 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  #include <dm.h>
> +#include <hexdump.h>
>  #include <log.h>
>  #include <malloc.h>
>  #include <scsi.h>
>  #include <ufs.h>
> +#include <vsprintf.h>
> +#include <u-boot/blake2.h>

These are mostly in alphabetical order, so would make sense to put
<u-boot/... after <linux/...

>  #include <asm/cache.h>
> +#include <asm/unaligned.h>
>  #include <linux/errno.h>
>  #include <linux/string.h>
>  #include "ufs.h"
> @@ -25,6 +29,15 @@
>  
>  #define GEOMETRY_DESC_RPMB_RW_SIZE	0x17
>  
> +#define RPMB_UNIT_DESC_LOGICAL_BLK_SIZE		0x0A
> +#define RPMB_UNIT_DESC_LOGICAL_BLK_COUNT	0x0B
> +#define RPMB_UNIT_DESC_REGION0_SIZE		0x13
> +#define RPMB_UNIT_DESC_REGION1_SIZE		0x14
> +#define RPMB_UNIT_DESC_REGION2_SIZE		0x15
> +#define RPMB_UNIT_DESC_REGION3_SIZE		0x16
> +#define UFS_RPMB_LEGACY_SPEC_VER		0x0220
> +#define UFS_RPMB_REGION_UNIT_SHIFT		17
> +
>  static u16 rpmb_frame_request(const void *frame)
>  {
>  	const u8 *p = frame;
> @@ -171,3 +184,138 @@ static int ufs_rpmb_read_geometry(struct udevice *scsi_dev, u8 *rpmb_rw_size)
>  
>  	return 0;
>  }
> +
> +static int ufs_rpmb_read_region_sizes(struct ufs_hba *hba, u16 spec_ver,
> +				      u8 sizes[UFS_RPMB_NUM_REGIONS])
> +{
> +	u8 unit[QUERY_DESC_UNIT_DEF_SIZE] = { };
> +	int ret;
> +
> +	ret = ufshcd_read_desc_param(hba, QUERY_DESC_IDN_UNIT,
> +				     UFS_UPIU_RPMB_WLUN, 0, unit, sizeof(unit));
> +	if (ret)
> +		return ret;
> +
> +	memset(sizes, 0, UFS_RPMB_NUM_REGIONS);
> +
> +	if (spec_ver > UFS_RPMB_LEGACY_SPEC_VER) {
> +		sizes[0] = unit[RPMB_UNIT_DESC_REGION0_SIZE];
> +		sizes[1] = unit[RPMB_UNIT_DESC_REGION1_SIZE];
> +		sizes[2] = unit[RPMB_UNIT_DESC_REGION2_SIZE];
> +		sizes[3] = unit[RPMB_UNIT_DESC_REGION3_SIZE];
> +	} else {
> +		u64 region = (get_unaligned_be64(unit +
> +					RPMB_UNIT_DESC_LOGICAL_BLK_COUNT)
> +			      << unit[RPMB_UNIT_DESC_LOGICAL_BLK_SIZE])
> +			     >> UFS_RPMB_REGION_UNIT_SHIFT;

A bit hard to read. Maybe like this?

		u64 region;

		region = get_unaligned_be64(unit + RPMB_UNIT_DESC_LOGICAL_BLK_COUNT);
		region <<= unit[RPMB_UNIT_DESC_LOGICAL_BLK_SIZE];
		region >>= UFS_RPMB_REGION_UNIT_SHIFT;

Also probably worth checking value of unit[RPMB_UNIT_DESC_LOGICAL_BLK_SIZE] before
using it if comes from a potentially untrusted source.

> +
> +		sizes[0] = region > 0xff ? 0xff : region;
> +	}
> +
> +	return 0;
> +}
> +
> +static void ufs_rpmb_string_to_ascii(const u8 *raw, char *out, size_t outsz)
> +{
> +	int nchars = ((int)raw[QUERY_DESC_LENGTH_OFFSET] - QUERY_DESC_HDR_SIZE);
> +	int i, n = 0;
> +
> +	nchars = nchars > 0 ? nchars / 2 : 0;
> +	for (i = 0; i < nchars && n < (int)outsz - 1; i++) {
> +		u16 c = get_unaligned_be16(raw + QUERY_DESC_HDR_SIZE + i * 2);
> +
> +		out[n++] = (c >= 0x20 && c <= 0x7e) ? (char)c : ' ';
> +	}
> +	out[n] = '\0';
> +}

This looks similar to ufshcd_remove_non_printable(). Should we try
to share code more?

> +
> +static int ufs_rpmb_build_cid(struct ufs_hba *hba, const u8 *dev_desc,
> +			      unsigned int region, u8 *cid)
> +{
> +	char serial_hex[QUERY_DESC_MAX_SIZE * 2 + 1];
> +	u16 manf_id, spec_ver, dev_ver, manf_date;
> +	u8 serial[QUERY_DESC_MAX_SIZE] = { };
> +	char idstr[QUERY_DESC_MAX_SIZE * 3];
> +	char model[MAX_MODEL_LEN * 8];
> +	u8 raw[QUERY_DESC_MAX_SIZE];
> +	u8 blen;
> +	int ret;
> +
> +	manf_date = get_unaligned_be16(dev_desc + DEVICE_DESC_PARAM_MANF_DATE);
> +	spec_ver = get_unaligned_be16(dev_desc + DEVICE_DESC_PARAM_SPEC_VER);
> +	manf_id = get_unaligned_be16(dev_desc + DEVICE_DESC_PARAM_MANF_ID);
> +	dev_ver = get_unaligned_be16(dev_desc + DEVICE_DESC_PARAM_DEV_VER);
> +
> +	ret = ufshcd_read_desc_param(hba, QUERY_DESC_IDN_STRING,
> +				     dev_desc[DEVICE_DESC_PARAM_PRDCT_NAME], 0,
> +				     raw, sizeof(raw));
> +	if (ret)
> +		return ret;
> +
> +	ufs_rpmb_string_to_ascii(raw, model, sizeof(model));
> +
> +	ret = ufshcd_read_desc_param(hba, QUERY_DESC_IDN_STRING,
> +				     dev_desc[DEVICE_DESC_PARAM_SN], 0,
> +				     raw, sizeof(raw));
> +	if (ret)
> +		return ret;
> +
> +	blen = raw[QUERY_DESC_LENGTH_OFFSET];
> +	if (blen < QUERY_DESC_HDR_SIZE)
> +		return -EINVAL;
> +
> +	memcpy(serial, raw + QUERY_DESC_HDR_SIZE, blen - QUERY_DESC_HDR_SIZE);
> +	bin2hex(serial_hex, serial, blen);

Why isn't this also blen - QUERY_DESC_HDR_SIZE? Is the 00 padding intentional?

> +	serial_hex[blen * 2] = '\0';
> +
> +	snprintf(idstr, sizeof(idstr), "%04X-%04X-%s-%s-%04X-%04X-R%u",
> +		 manf_id, spec_ver, model, serial_hex, dev_ver, manf_date,
> +		 region);
> +
> +	if (blake2b(cid, UFS_RPMB_CID_SIZE, idstr, strlen(idstr), NULL, 0))
> +		return -EIO;
> +
> +	return 0;
> +}
> +
