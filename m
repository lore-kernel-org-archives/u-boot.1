Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28128C44529
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 07:52:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D16094084E;
	Tue, 21 Jul 2026 07:52:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ge1k62LKT5U6; Tue, 21 Jul 2026 07:51:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6D1FF4082A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784620319;
	bh=eqjTy7o3Ok2j3EYdJTLSdJ+N6c5MXOriLtriSo9GUBQ=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=DZm/ZOKvUWZ6b4ZjIfqtb2IMx85380sN71zIBKotGNPepqlAxcLrpgvPYN3BEh6Vj
	 BAzN7SnEDUghq999FbyssuWpB9d+VynaUqEpqI2zgVuOG8xKtalMK3LNRoxW75MtmA
	 DInHG5SsySSL+E/SI5Usm/KwYtxNQo6AWSdFun8bqf6CQ7X1XDb5wbFnblxRKMPN3e
	 hmMpzPTqQzQ2HTL7KKITe16e09VuVRWUzvEyVHX0TpS3yF7lQ2PwmOsv8Mp4eD3sH7
	 0foxU06ZNWyMSwNXgxIg09vbpC8OdfnGQ5Fs34HrAQOVuRUIX7XTAIq5BuiVlZVAMO
	 1Et7DvRZtiTLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6D1FF4082A;
	Tue, 21 Jul 2026 07:51:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8527D109C
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 07:51:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6274580E7F
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 07:51:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4QFptBMyFufw for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 07:51:56 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0B27880E86
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0B27880E86
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0B27880E86
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 07:51:55 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D57A84659; Tue, 21 Jul 2026 09:51:54 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AF0C803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 09:51:52 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4955aa106b1so18251395e9.0
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 00:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784620311; x=1785225111;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eqjTy7o3Ok2j3EYdJTLSdJ+N6c5MXOriLtriSo9GUBQ=;
 b=sTRmaLvEsHirwRjWPi0vn1TavI33ggkC0zYOaHrak6Kgx0uzk4rstId31ET1w6T8R1
 iI2L2UOnSCD6xrdEIqoK0ughkXd0kOq0Z8l2cPRMHq9HT/Dee6cNFgF9SBZiM/bwlqP+
 m36NFeiIzok5/IOwYL6CHRhs3u3/r8AYmcxCK59dyw9sTKtUMJdhHLUUN5OMmqe/nwEN
 uxxYQl8WtcVMGqzR0bUcNgNYe+KVwwQNDD24+gw6rfj3GBrZH+SWFpX/cyvub5EIVtoH
 Ht8lw5pxtyGe1ln1uwB2vd0k7abLCrd2E160SkiDFeCX9qE/9kbEAvd0u1xplS3jFoVE
 ZmUg==
X-Gm-Message-State: AOJu0Yw4YetgQCHdqD6CEFMByl32zmAV90y8ErxsFkQpXyNwgewqM3vy
 FJRMWuMUtP9SKTiunLgRYnLgrZW4gtDLnKOYB+aJSsGrI9JJi4BeWbuhM1bvp8nOIvM=
X-Gm-Gg: AfdE7ckoHA+qm4cunLoFYbTp8t+vDCwaaJ6FrLLLCnUDkn/oT1rBAhypAMSjywlBgHt
 f2A8ymgMeiy9tnXyj5Z3pcfQlfy/eDXF9upuMQV8ozFW6ACUXO1mQ8w/bdb3JkmUYJUbCqrB58/
 QgFLMNC+MSIs307FWjS61Mycm6arWn6I9JixYNbvSI4j/YrYWTdEyQ2BjyUE96eggEbXGiCUEkK
 RToxy0XKFofLLw8hZuWlbMfkrvWPWMwm0m7jcxQF9baBn8PYEk7nSN42E/linvHhkdcQGdrqG5m
 VBLHMuRUnuW9fVxcQu0+EOQ2dczeshnRNLxwGGtCwEI+I/a8zZsDnmNbJQ1bcM4jHC4Lj2HLWzZ
 sBJCgpsuOwEiUNJAhOMPqhVAWDFrzNwOEkQTZN5JD5PRNWmU8dwEy9guNy47nIruSgwyu3jG4OM
 tKrxWJa6ovMxX5SDPMlzWNdcgYjdu800hk4ivU+Of6UfXWz+egSU3Hl1Zf8w==
X-Received: by 2002:a05:600c:4f93:b0:493:e404:3727 with SMTP id
 5b1f17b1804b1-4954a40ebe1mr202300655e9.23.1784620311215; 
 Tue, 21 Jul 2026 00:51:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:77c9:2d2d:bb1f:99c1?
 ([2a01:e0a:106d:1080:77c9:2d2d:bb1f:99c1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956547323bsm49957025e9.4.2026.07.21.00.51.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 00:51:50 -0700 (PDT)
Message-ID: <3bf19531-058b-485a-aa43-74cd09caa9e3@linaro.org>
Date: Tue, 21 Jul 2026 09:51:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/7] ufs: rpmb: derive the per-region RPMB CID and size
 for OP-TEE
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, trini@konsulko.com, 
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org,
 bhupesh.linux@gmail.com, n-francis@ti.com, marek.vasut+renesas@mailbox.org,
 igor.belwon@mentallysanemainliners.org, shawn.lin@rock-chips.com,
 yoshihiro.shimoda.uh@renesas.com, alchark@gmail.com,
 tuyen.dang.xa@renesas.com, macpaul.lin@mediatek.com,
 padmarao.begari@amd.com, jstephan@baylibre.com, bb@ti.com,
 j-mcarthur@ti.com, venkyada@qti.qualcomm.com, hayashi.kunihiko@socionext.com
Cc: u-boot@lists.denx.de, sumit.garg@kernel.org
References: <20260720085202.537019-1-jorge.ramirez@oss.qualcomm.com>
 <20260720085202.537019-4-jorge.ramirez@oss.qualcomm.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20260720085202.537019-4-jorge.ramirez@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784620311; x=1785225111; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eqjTy7o3Ok2j3EYdJTLSdJ+N6c5MXOriLtriSo9GUBQ=;
 b=LjhV075YMXlDP3vAv89G+xrdhtNcbyR/TP/CprL7UCxJcTGvZmovhLvb5nVby0n05X
 BUFTZucPtbD6jGQG5Azq73KZ0JXPVZGJGKOfgx/UUL1b7fXckZDLwIDc7Hd1RK4YHlV/
 gr35C2q5gIhu75NzNJgifYtImK5w2QH5DR+xytdRMtSymNuMOGusCBD4qViJECML6VO1
 FAF/ANyOLOb0b1G5LWo37CYVibDVFaAUSD+8hqys9yWWqrYEUbDdLxqqdrRnAeiCVHQv
 fN+1eswsLq96JS65uviNpDYZ5Ma9o6c09cg69844F1UZqGiJSF5/ZpR5KPG4gWTeXEeJ
 sZXQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=LjhV075Y
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=neil.armstrong@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="LjhV075Y"; 
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
From: "Neil Armstrong \(Linaro\) via U-Boot" <u-boot@lists.u-boot-project.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi,

On 7/20/26 10:51, Jorge Ramirez-Ortiz wrote:
> Read the UFS device, unit and geometry descriptors to report each RPMB
> region's size and reliable-write count, and build a 16-byte CID by
> BLAKE2b-hashing the same device-id string the Linux kernel derives
> (ufshcd_create_device_id() plus a "-R<region>" suffix), so OP-TEE derives
> an RPMB key that matches Linux. Exposed via ufs_rpmb_get_region_info().
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> ---
>   drivers/ufs/ufs-rpmb.c   | 135 ++++++++++++++++++++++++++++++++++++++-
>   drivers/ufs/ufs-uclass.c |   4 +-
>   drivers/ufs/ufs.h        |  11 ++++
>   include/ufs.h            |   6 +-
>   4 files changed, 151 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ufs/ufs-rpmb.c b/drivers/ufs/ufs-rpmb.c
> index 636ccb6e74f..7919162ddae 100644
> --- a/drivers/ufs/ufs-rpmb.c
> +++ b/drivers/ufs/ufs-rpmb.c
> @@ -1,8 +1,12 @@
>   // SPDX-License-Identifier: GPL-2.0+
>   #include <dm.h>
> +#include <hexdump.h>
>   #include <log.h>
>   #include <scsi.h>
>   #include <ufs.h>
> +#include <vsprintf.h>
> +#include <u-boot/blake2.h>
> +#include <asm/unaligned.h>
>   #include <linux/errno.h>
>   #include <linux/string.h>
>   #include "ufs.h"
> @@ -130,9 +134,8 @@ struct udevice *ufs_rpmb_get_scsi_dev(int dev_id)
>   	return scsi_dev;
>   }
>   
> -int ufs_rpmb_read_geometry(struct udevice *scsi_dev, u8 *rpmb_rw_size)
> +static int ufs_rpmb_read_rw_size(struct ufs_hba *hba, u8 *rpmb_rw_size)

Why ?

>   {
> -	struct ufs_hba *hba = dev_get_uclass_priv(scsi_dev->parent);
>   	u8 desc[QUERY_DESC_GEOMETRY_DEF_SIZE];
>   	int ret;
>   
> @@ -144,3 +147,131 @@ int ufs_rpmb_read_geometry(struct udevice *scsi_dev, u8 *rpmb_rw_size)
>   	*rpmb_rw_size = desc[GEOMETRY_DESC_RPMB_RW_SIZE];
>   	return 0;
>   }
> +
> +static int ufs_rpmb_read_region_sizes(struct ufs_hba *hba, u16 spec_ver,
> +				      u8 sizes[UFS_RPMB_NUM_REGIONS])
> +{
> +	u8 unit[QUERY_DESC_UNIT_DEF_SIZE] = { };
> +	int ret;
> +
> +	ret = ufshcd_read_descriptor(hba, QUERY_DESC_IDN_UNIT,
> +				     UFS_UPIU_RPMB_WLUN, unit, sizeof(unit));
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
> +
> +static int ufs_rpmb_build_cid(struct ufs_hba *hba, const u8 *dev_desc,
> +			      unsigned int region, u8 *cid)
> +{
> +	u8 raw[QUERY_DESC_MAX_SIZE];
> +	char model[MAX_MODEL_LEN * 8];
> +	char serial_hex[QUERY_DESC_MAX_SIZE * 2 + 1];
> +	char idstr[QUERY_DESC_MAX_SIZE * 3];
> +	u8 serial[QUERY_DESC_MAX_SIZE] = { };
> +	u16 manf_id, spec_ver, dev_ver, manf_date;
> +	u8 blen;
> +	int ret;
> +
> +	manf_id = get_unaligned_be16(dev_desc + DEVICE_DESC_PARAM_MANF_ID);
> +	spec_ver = get_unaligned_be16(dev_desc + DEVICE_DESC_PARAM_SPEC_VER);
> +	dev_ver = get_unaligned_be16(dev_desc + DEVICE_DESC_PARAM_DEV_VER);
> +	manf_date = get_unaligned_be16(dev_desc + DEVICE_DESC_PARAM_MANF_DATE);
> +
> +	ret = ufshcd_read_descriptor(hba, QUERY_DESC_IDN_STRING,
> +				     dev_desc[DEVICE_DESC_PARAM_PRDCT_NAME],
> +				     raw, sizeof(raw));
> +	if (ret)
> +		return ret;
> +	ufs_rpmb_string_to_ascii(raw, model, sizeof(model));
> +
> +	ret = ufshcd_read_descriptor(hba, QUERY_DESC_IDN_STRING,
> +				     dev_desc[DEVICE_DESC_PARAM_SN],
> +				     raw, sizeof(raw));
> +	if (ret)
> +		return ret;
> +	blen = raw[QUERY_DESC_LENGTH_OFFSET];
> +	if (blen < QUERY_DESC_HDR_SIZE)
> +		return -EINVAL;
> +	memcpy(serial, raw + QUERY_DESC_HDR_SIZE, blen - QUERY_DESC_HDR_SIZE);
> +	bin2hex(serial_hex, serial, blen);
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
> +int ufs_rpmb_get_region_info(struct udevice *scsi_dev, unsigned int region,
> +			     u8 *size_mult, u8 *rel_wr, u8 *cid)
> +{
> +	struct ufs_hba *hba = dev_get_uclass_priv(scsi_dev->parent);
> +	u8 dev_desc[QUERY_DESC_DEVICE_DEF_SIZE] = { };
> +	u8 sizes[UFS_RPMB_NUM_REGIONS];
> +	u16 spec_ver;
> +	int ret;
> +
> +	if (region >= UFS_RPMB_NUM_REGIONS)
> +		return 0;
> +
> +	ret = ufshcd_read_descriptor(hba, QUERY_DESC_IDN_DEVICE, 0,
> +				     dev_desc, sizeof(dev_desc));
> +	if (ret)
> +		return ret;
> +	spec_ver = get_unaligned_be16(dev_desc + DEVICE_DESC_PARAM_SPEC_VER);
> +
> +	ret = ufs_rpmb_read_region_sizes(hba, spec_ver, sizes);
> +	if (ret)
> +		return ret;
> +	if (!sizes[region])
> +		return 0;
> +
> +	ret = ufs_rpmb_read_rw_size(hba, rel_wr);
> +	if (ret)
> +		return ret;
> +	if (!*rel_wr)
> +		*rel_wr = 1;
> +
> +	ret = ufs_rpmb_build_cid(hba, dev_desc, region, cid);
> +	if (ret)
> +		return ret;
> +
> +	*size_mult = sizes[region];
> +	return 1;
> +}
> diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
> index 962b6093762..f5e5bfd2e27 100644
> --- a/drivers/ufs/ufs-uclass.c
> +++ b/drivers/ufs/ufs-uclass.c
> @@ -1800,8 +1800,8 @@ out:
>   	return err;
>   }
>   
> -static int ufs_get_device_desc(struct ufs_hba *hba,
> -			       struct ufs_dev_desc *dev_desc)
> +int ufs_get_device_desc(struct ufs_hba *hba,
> +			struct ufs_dev_desc *dev_desc)
>   {
>   	int err;
>   	size_t buff_len;
> diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
> index e66d2c5f533..cf89bbc2008 100644
> --- a/drivers/ufs/ufs.h
> +++ b/drivers/ufs/ufs.h
> @@ -20,6 +20,15 @@ struct udevice;
>   #define UFS_RPMB_SEC_PROTOCOL_ID	0x01
>   
>   #define GEOMETRY_DESC_RPMB_RW_SIZE	0x17
> +
> +#define RPMB_UNIT_DESC_LOGICAL_BLK_SIZE		0x0A
> +#define RPMB_UNIT_DESC_LOGICAL_BLK_COUNT	0x0B
> +#define RPMB_UNIT_DESC_REGION0_SIZE		0x13
> +#define RPMB_UNIT_DESC_REGION1_SIZE		0x14
> +#define RPMB_UNIT_DESC_REGION2_SIZE		0x15
> +#define RPMB_UNIT_DESC_REGION3_SIZE		0x16
> +#define UFS_RPMB_LEGACY_SPEC_VER		0x0220
> +#define UFS_RPMB_REGION_UNIT_SHIFT		17

Maybe move them to ufs-rpmb or create a new ufs-rpmb.h ?

>   #define UPIU_TRANSACTION_UIC_CMD 0x1F
>   #define UIC_CMD_SIZE (sizeof(u32) * 4)
>   #define RESPONSE_UPIU_SENSE_DATA_LENGTH	18
> @@ -822,4 +831,6 @@ int ufshcd_probe(struct udevice *dev, struct ufs_hba_ops *hba_ops);
>   int ufshcd_read_descriptor(struct ufs_hba *hba, enum desc_idn desc_id,
>   			   int desc_index, u8 *buf, u8 size);
>   
> +int ufs_get_device_desc(struct ufs_hba *hba, struct ufs_dev_desc *dev_desc);

Why ?

> +
>   #endif
> diff --git a/include/ufs.h b/include/ufs.h
> index 90c6aebcec1..79573e02278 100644
> --- a/include/ufs.h
> +++ b/include/ufs.h
> @@ -20,12 +20,16 @@ int ufs_probe(void);
>    */
>   int ufs_probe_dev(int index);
>   
> +#define UFS_RPMB_CID_SIZE	16
> +#define UFS_RPMB_NUM_REGIONS	4
> +
>   struct udevice *ufs_rpmb_get_scsi_dev(int dev_id);
>   
>   int ufs_rpmb_route_frames(struct udevice *scsi_dev, unsigned int region,
>   			  void *req, unsigned long reqlen, void *rsp,
>   			  unsigned long rsplen);
>   
> -int ufs_rpmb_read_geometry(struct udevice *scsi_dev, u8 *rpmb_rw_size);
> +int ufs_rpmb_get_region_info(struct udevice *scsi_dev, unsigned int region,
> +			     u8 *size_mult, u8 *rel_wr, u8 *cid);
>   
>   #endif

Thanks,
Neil
