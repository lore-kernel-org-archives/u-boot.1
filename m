Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B75DC44529
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 07:47:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C5E2140831;
	Tue, 21 Jul 2026 07:47:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oRsubxalqI1v; Tue, 21 Jul 2026 07:47:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D4F1B40743
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784620029;
	bh=tCanwTh/89YhuALsQ2Zhn4omISAnxYtoHhSeXufuyrU=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=X2qiGw2UCWsCuNGwnH/YFwSoEJYhGsphkORyq2xEyIy7bbdEgnTxWRPbLoGOFxOJY
	 yQMtnoPkU7WfiS544YL0+l1CPAike0Y4Mum5EHZju9KqYIt+u7vlIVV4n+0zVM8fNV
	 eXMFMFg94jd+2Pcgrj8ppe9iKq9erNgkQbLWK+tSghb/uHQDH5yP2JxvtDc20KGAwt
	 mSPlm/Tb8s5bj+1GvRFgfOnWBMSFm9dGI2WxqUw1+ub8Tlu6Ydeh3PvKQPL9nCUOow
	 1ErXGisEMxpfYR+7Ut1QY94fFql5m7Ggjbt8Xcfg00a3yBWGrB9/29VdbIR5vwacJD
	 CDMUWUUvS6QPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D4F1B40743;
	Tue, 21 Jul 2026 07:47:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1B3B8DF0
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 07:47:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0D127607F0
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 07:47:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 26GGxNE1CnPG for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 07:47:06 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 969A3607EA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 969A3607EA
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 969A3607EA
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 07:47:05 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFDDB84659; Tue, 21 Jul 2026 09:47:03 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5220803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 09:46:57 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49548e01d02so17793495e9.0
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 00:46:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784620017; x=1785224817;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tCanwTh/89YhuALsQ2Zhn4omISAnxYtoHhSeXufuyrU=;
 b=IAAfk5nEl/lpAycRq81Bj0IRTkUCU2HwTUoDtoKF2u4oihtHxDZI/h6fS3nuPy1KR8
 tr/ZdXtenLhzwp1d2+NULbalJNtuj9g7PBJfvqkg6SJbgO/GR9CV+sxiqHxVgnd/vPA8
 akjGPEi4nnbUe+AG9WSOufq20iQu5p0B6Zkmr+tejJZLHTDdPDVMFAib47GZi4QGjuYq
 Qbfed9KyPQ9GVlc11bDpWKvWSJ6eG/plAwh+n8uluGDvpUBXLtIil7iOgRQxvG4H3wqY
 3d6IcnAMDeLVcy33C/wonPgzYXqlVS6IIf5RzwYtxJaol5f4QdjYFx2fRQleStQHCntV
 tl5g==
X-Gm-Message-State: AOJu0YwWvF4Gu2clESo3r33aCt3qUad4RV2xrBtQNNTYOkcu0OhauKry
 3Xy4LouPazVRjUQeoZvYiofjiHZ8TjDI/NBT6s2Yyo8TwHb/abzM3l3InAwi9Tl3je8=
X-Gm-Gg: AfdE7cnMslCeJo4NVvmY4Ka+86fwxDx5MXcRvkzidQWSWXx4/6TIaQGk4Joozp3Ofc7
 uV0EUAdS/CxSALbcNJerbV15hXpFl3VhQBPdplNxBJs4LtPT8bzXpWeid8T8aas5jH8QR09MSEp
 RS62CsMxAWNubbmx+vgvBfycWUWDvDd4nzj50zTyaLgMPPwxu4DnspVKRcnrDclWER6jAhFJIWq
 ccCPVzm+gFa+XafpdXPco0aMFZahfpNKanaF5ot+XzinSz3Tmkxf3SawGXx7T6I3Swpw+4uLvn2
 m8VGP1P54CSnm+7+RQrQqiSuNkzVzgjss7uhYIXWm9SF15VHF//I1EwOsl0bbJOXqFBi2YLmJGg
 c1nGe8u+SzgLfcpZmksV62+i6uG35wWLymIPq1w310PxJlnBaKGD3czGfyRQmL8JUEShQ+qQpr+
 yPo7KDtu2TIKBChZMN/RuA9hZ1MnQnHzAGPLHtUsf5f0DZ2MdiDcCpkxdeaA==
X-Received: by 2002:a05:600c:524c:b0:495:4e12:6ae5 with SMTP id
 5b1f17b1804b1-4954e126afamr188343165e9.26.1784620016779; 
 Tue, 21 Jul 2026 00:46:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:77c9:2d2d:bb1f:99c1?
 ([2a01:e0a:106d:1080:77c9:2d2d:bb1f:99c1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495653c8760sm43837305e9.14.2026.07.21.00.46.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 00:46:56 -0700 (PDT)
Message-ID: <6655cb53-fe79-4163-b148-377ee35fbee8@linaro.org>
Date: Tue, 21 Jul 2026 09:46:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/7] ufs: add RPMB transport over SCSI SECURITY PROTOCOL
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
 <20260720085202.537019-3-jorge.ramirez@oss.qualcomm.com>
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
In-Reply-To: <20260720085202.537019-3-jorge.ramirez@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784620017; x=1785224817; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tCanwTh/89YhuALsQ2Zhn4omISAnxYtoHhSeXufuyrU=;
 b=OwbEOmF4fJ6ENtzWGIUyM5tNAqejbktloJMXH6fUgEs4ygeyrJHBk+HrrsOdXfx/aX
 DXQpWq80f8ixpEo8xuxdoSS3yf1n+DPJf2VoUW/UKWUaym34SRf862177xsMQS4VBWb1
 RwgFmu0djgBBcrAtZAA5sf/4sTEOTz1vFo+lHiri67WoC9azAj5ctLvbZ9Z1MmkZRcz1
 1MTiZw87j00n9RlsPvR8aIgH7luDIspvxNS+DpcGnRQ5g6CBrYV9VyfJ+vy2J3hP9SVK
 zzrNMYpI/xMByPCFp30Ph7Q8Vl0luhbk6gHkWlc9clNeMC4+ePuFn1c2j8dd/nponIGy
 1gbg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=OwbEOmF4
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=neil.armstrong@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="OwbEOmF4"; 
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
> Add a UFS RPMB transport that moves fully-formed JEDEC RPMB frames to and
> from the RPMB Well-Known LUN using SCSI SECURITY PROTOCOL IN/OUT commands,
> exposed through ufs_rpmb_route_frames() for the OP-TEE RPMB supplicant and
> guarded by CONFIG_SUPPORT_UFS_RPMB.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> ---
>   drivers/ufs/Kconfig      |  13 ++++
>   drivers/ufs/Makefile     |   1 +
>   drivers/ufs/ufs-rpmb.c   | 146 +++++++++++++++++++++++++++++++++++++++
>   drivers/ufs/ufs-uclass.c |   6 ++
>   drivers/ufs/ufs.h        |  13 ++++
>   include/ufs.h            |   8 +++
>   6 files changed, 187 insertions(+)
>   create mode 100644 drivers/ufs/ufs-rpmb.c
> 
> diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
> index 49472933de3..d39fcda42dc 100644
> --- a/drivers/ufs/Kconfig
> +++ b/drivers/ufs/Kconfig
> @@ -92,4 +92,17 @@ config UFS_TI_J721E
>   	  This selects the glue layer driver for Cadence controller
>   	  present on TI's J721E devices.
>   
> +config SUPPORT_UFS_RPMB
> +	bool "Enable UFS RPMB (Replay Protected Memory Block) support"
> +	depends on UFS && OPTEE && !SUPPORT_EMMC_RPMB
> +	select BLAKE2
> +	help
> +	  Route OP-TEE RPMB requests to the UFS RPMB Well-Known LUN using
> +	  SCSI SECURITY PROTOCOL IN/OUT commands. Required for OP-TEE secure
> +	  storage (CFG_RPMB_FS) on UFS-based platforms that have no eMMC.
> +	  BLAKE2 is used to derive the fixed-length RPMB CID that matches the
> +	  Linux kernel UFS device_id ABI. The OP-TEE supplicant handles a
> +	  single RPMB transport, so this is mutually exclusive with the eMMC
> +	  RPMB supplicant (SUPPORT_EMMC_RPMB).
> +
>   endmenu
> diff --git a/drivers/ufs/Makefile b/drivers/ufs/Makefile
> index e7f3c1d30c4..d60440ca119 100644
> --- a/drivers/ufs/Makefile
> +++ b/drivers/ufs/Makefile
> @@ -13,3 +13,4 @@ obj-$(CONFIG_UFS_RENESAS) += ufs-renesas.o
>   obj-$(CONFIG_UFS_RENESAS_GEN5) += ufs-renesas-rcar-gen5.o
>   obj-$(CONFIG_UFS_ROCKCHIP) += ufs-rockchip.o
>   obj-$(CONFIG_UFS_TI_J721E) += ti-j721e-ufs.o
> +obj-$(CONFIG_SUPPORT_UFS_RPMB) += ufs-rpmb.o
> diff --git a/drivers/ufs/ufs-rpmb.c b/drivers/ufs/ufs-rpmb.c
> new file mode 100644
> index 00000000000..636ccb6e74f
> --- /dev/null
> +++ b/drivers/ufs/ufs-rpmb.c
> @@ -0,0 +1,146 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +#include <dm.h>
> +#include <log.h>
> +#include <scsi.h>
> +#include <ufs.h>
> +#include <linux/errno.h>
> +#include <linux/string.h>
> +#include "ufs.h"
> +
> +#define RPMB_REQ_KEY		1
> +#define RPMB_REQ_WCOUNTER	2
> +#define RPMB_REQ_WRITE_DATA	3
> +#define RPMB_REQ_READ_DATA	4
> +#define RPMB_REQ_STATUS		5
> +
> +#define RPMB_FRAME_REQ_OFFSET	510
> +
> +static u16 rpmb_frame_request(const void *frame)
> +{
> +	const u8 *p = frame;
> +
> +	return ((u16)p[RPMB_FRAME_REQ_OFFSET] << 8) |
> +		p[RPMB_FRAME_REQ_OFFSET + 1];
> +}
> +
> +static int ufs_rpmb_secprot(struct udevice *scsi_dev, unsigned int region,
> +			    u8 opcode, void *buf, unsigned int nframes,
> +			    enum dma_data_direction dir)
> +{
> +	struct scsi_cmd pccb;
> +	u32 len = nframes * RPMB_FRAME_SIZE;
> +	u16 spsp = (region << 8) | UFS_RPMB_SEC_PROTOCOL_ID;
> +
> +	memset(&pccb, 0, sizeof(pccb));
> +	pccb.lun = UFS_UPIU_RPMB_WLUN;
> +	pccb.cmd[0] = opcode;
> +	pccb.cmd[1] = SEC_PROTOCOL_UFS;
> +	pccb.cmd[2] = (spsp >> 8) & 0xff;
> +	pccb.cmd[3] = spsp & 0xff;
> +	pccb.cmd[4] = 0;
> +	pccb.cmd[5] = 0;
> +	pccb.cmd[6] = (len >> 24) & 0xff;
> +	pccb.cmd[7] = (len >> 16) & 0xff;
> +	pccb.cmd[8] = (len >> 8) & 0xff;
> +	pccb.cmd[9] = len & 0xff;
> +	pccb.cmd[10] = 0;
> +	pccb.cmd[11] = 0;
> +	pccb.cmdlen = 12;
> +	pccb.pdata = buf;
> +	pccb.datalen = len;
> +	pccb.dma_dir = dir;
> +
> +	return scsi_exec(scsi_dev, &pccb);
> +}
> +
> +static int ufs_rpmb_send(struct udevice *scsi_dev, unsigned int region,
> +			 void *frames, unsigned int nframes)
> +{
> +	return ufs_rpmb_secprot(scsi_dev, region, SECURITY_PROTOCOL_OUT,
> +				frames, nframes, DMA_TO_DEVICE);
> +}
> +
> +static int ufs_rpmb_recv(struct udevice *scsi_dev, unsigned int region,
> +			 void *frames, unsigned int nframes)
> +{
> +	return ufs_rpmb_secprot(scsi_dev, region, SECURITY_PROTOCOL_IN,
> +				frames, nframes, DMA_FROM_DEVICE);
> +}
> +
> +int ufs_rpmb_route_frames(struct udevice *scsi_dev, unsigned int region,
> +			  void *req, unsigned long reqlen, void *rsp,
> +			  unsigned long rsplen)
> +{
> +	unsigned int n_req = reqlen / RPMB_FRAME_SIZE;
> +	unsigned int n_rsp = rsplen / RPMB_FRAME_SIZE;
> +	u16 request;
> +	int ret;
> +
> +	if (!scsi_dev || reqlen % RPMB_FRAME_SIZE ||
> +	    rsplen % RPMB_FRAME_SIZE || !n_req)
> +		return -EINVAL;
> +
> +	request = rpmb_frame_request(req);
> +
> +	switch (request) {
> +	case RPMB_REQ_KEY:
> +	case RPMB_REQ_WRITE_DATA: {
> +		u8 status_frame[RPMB_FRAME_SIZE];
> +
> +		ret = ufs_rpmb_send(scsi_dev, region, req, n_req);
> +		if (ret)
> +			return ret;
> +
> +		memset(status_frame, 0, sizeof(status_frame));
> +		status_frame[RPMB_FRAME_REQ_OFFSET] = RPMB_REQ_STATUS >> 8;
> +		status_frame[RPMB_FRAME_REQ_OFFSET + 1] = RPMB_REQ_STATUS & 0xff;
> +		ret = ufs_rpmb_send(scsi_dev, region, status_frame, 1);
> +		if (ret)
> +			return ret;
> +
> +		if (n_rsp < 1)
> +			return -EINVAL;
> +		return ufs_rpmb_recv(scsi_dev, region, rsp, 1);
> +	}
> +	case RPMB_REQ_WCOUNTER:
> +	case RPMB_REQ_READ_DATA:
> +		ret = ufs_rpmb_send(scsi_dev, region, req, 1);
> +		if (ret)
> +			return ret;
> +		if (n_rsp < 1)
> +			return -EINVAL;
> +		return ufs_rpmb_recv(scsi_dev, region, rsp, n_rsp);
> +	default:
> +		debug("ufs-rpmb: unsupported request 0x%x\n", request);
> +		return -EINVAL;
> +	}
> +}
> +
> +struct udevice *ufs_rpmb_get_scsi_dev(int dev_id)
> +{
> +	struct udevice *scsi_dev;
> +	int ret;
> +
> +	ret = uclass_get_device(UCLASS_SCSI, dev_id, &scsi_dev);
> +	if (ret) {
> +		debug("ufs-rpmb: no SCSI device for dev_id %d: %d\n",
> +		      dev_id, ret);
> +		return NULL;
> +	}
> +	return scsi_dev;
> +}

This is a wrapper on uclass_get_device(), why not using uclass_get_device()
from the caller code ?

> +
> +int ufs_rpmb_read_geometry(struct udevice *scsi_dev, u8 *rpmb_rw_size)
> +{
> +	struct ufs_hba *hba = dev_get_uclass_priv(scsi_dev->parent);
> +	u8 desc[QUERY_DESC_GEOMETRY_DEF_SIZE];
> +	int ret;
> +
> +	ret = ufshcd_read_descriptor(hba, QUERY_DESC_IDN_GEOMETRY, 0,
> +				     desc, sizeof(desc));
> +	if (ret)
> +		return ret;
> +
> +	*rpmb_rw_size = desc[GEOMETRY_DESC_RPMB_RW_SIZE];
> +	return 0;
> +}
> diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
> index 4d10e0b11fe..962b6093762 100644
> --- a/drivers/ufs/ufs-uclass.c
> +++ b/drivers/ufs/ufs-uclass.c
> @@ -1712,6 +1712,12 @@ static inline int ufshcd_read_desc(struct ufs_hba *hba, enum desc_idn desc_id,
>   	return ufshcd_read_desc_param(hba, desc_id, desc_index, 0, buf, size);
>   }
>   
> +int ufshcd_read_descriptor(struct ufs_hba *hba, enum desc_idn desc_id,
> +			   int desc_index, u8 *buf, u8 size)
> +{
> +	return ufshcd_read_desc_param(hba, desc_id, desc_index, 0, buf, size);

Why you don't expose & use ufshcd_read_desc_param() directly ?

> +}
> +
>   static int ufshcd_read_device_desc(struct ufs_hba *hba, u8 *buf, u32 size)
>   {
>   	return ufshcd_read_desc(hba, QUERY_DESC_IDN_DEVICE, 0, buf, size);
> diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
> index 0f6c93fbce7..e66d2c5f533 100644
> --- a/drivers/ufs/ufs.h
> +++ b/drivers/ufs/ufs.h
> @@ -10,6 +10,16 @@
>   struct udevice;
>   
>   #define UFS_CDB_SIZE	16
> +
> +#define UFS_UPIU_RPMB_WLUN		0xC4
> +#define RPMB_FRAME_SIZE			512

Can this be declared in a common rpbm header ?

> +
> +#define SECURITY_PROTOCOL_IN		0xA2
> +#define SECURITY_PROTOCOL_OUT		0xB5

Those are SCSI indentifiers, move the, to sci headers.

> +#define SEC_PROTOCOL_UFS		0xEC
> +#define UFS_RPMB_SEC_PROTOCOL_ID	0x01

Those are not UFS internal identifiers, move them to the ufs-rpmb code like Linux.

> +
> +#define GEOMETRY_DESC_RPMB_RW_SIZE	0x17
>   #define UPIU_TRANSACTION_UIC_CMD 0x1F
>   #define UIC_CMD_SIZE (sizeof(u32) * 4)
>   #define RESPONSE_UPIU_SENSE_DATA_LENGTH	18
> @@ -809,4 +819,7 @@ static inline void ufshcd_rmwl(struct ufs_hba *hba, u32 mask, u32 val, u32 reg)
>   
>   int ufshcd_probe(struct udevice *dev, struct ufs_hba_ops *hba_ops);
>   
> +int ufshcd_read_descriptor(struct ufs_hba *hba, enum desc_idn desc_id,
> +			   int desc_index, u8 *buf, u8 size);
> +
>   #endif
> diff --git a/include/ufs.h b/include/ufs.h
> index f6e27d90e43..90c6aebcec1 100644
> --- a/include/ufs.h
> +++ b/include/ufs.h
> @@ -20,4 +20,12 @@ int ufs_probe(void);
>    */
>   int ufs_probe_dev(int index);
>   
> +struct udevice *ufs_rpmb_get_scsi_dev(int dev_id);
> +
> +int ufs_rpmb_route_frames(struct udevice *scsi_dev, unsigned int region,
> +			  void *req, unsigned long reqlen, void *rsp,
> +			  unsigned long rsplen);
> +
> +int ufs_rpmb_read_geometry(struct udevice *scsi_dev, u8 *rpmb_rw_size);
> +
>   #endif

Thanks,
Neil
