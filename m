Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 203EFC44533
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 08:33:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CEADB407D3;
	Wed, 22 Jul 2026 08:33:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1STj8FVboyRW; Wed, 22 Jul 2026 08:33:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 10969406F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784709219;
	bh=VTFJcmKWcTKdkdJHVM90/JWRz2O0OQIwldDzhOvINN4=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=GkpaFiVmdBjXKG33oSWWSqNT3ng2mxAUFk5h51ZfCw+Gq5ktIsu2LuEFAGZQ2e7bM
	 crQ6n5TCmVUJCLHhWkLW8Ca22iUdt6jUvSt9dMlS4AVChKawDlEdPS7hQefIanvbqi
	 mcDZRqsGvq+mOB69ap9Q+dpPCK0CFBzL5IGKBAbHfl0dr7/adXRLrA23GKLb+BS972
	 TVogXMtfggpXCKmxJVKxDj4mXtEPPUkVWP57x5X9d4NkB6DTpNHtVpR3BB1sRmSSW9
	 9S+eaOmSSqQjS7bpG/+8TmUeJ+quLsQXEASqzWK5JL0TXFXIX74+Vutj2LIR1L/AQ9
	 N8judkD43kyzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 10969406F0;
	Wed, 22 Jul 2026 08:33:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5D694109C
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 08:33:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4F904406F0
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 08:33:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m7doKlC3Wo1O for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 08:33:36 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org DDB5E405B0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DDB5E405B0
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DDB5E405B0
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 08:33:35 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A7A88493F; Wed, 22 Jul 2026 10:33:34 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDD5D803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 10:33:31 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4954df200ddso30147755e9.0
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 01:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784709211; x=1785314011;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VTFJcmKWcTKdkdJHVM90/JWRz2O0OQIwldDzhOvINN4=;
 b=KyHZg9HB4m1lUYuzPgtRWbM+5PEaDFG98e86Xn1mMPfpzDNT0hegb1Nq8tf/87lfCl
 oWIA/rC06QUWHv5Hh8jdggKptKH3E/m0nCd618pNBNdh+2bS0kXvl1jpUyHFGT0HMOQm
 0EwwHXYW/BpRQad8cSzR6DiYZBQiu5UZBrXu5wrIxcDqeOrUU5t8F2pyaY+BPgPf5X1I
 3cvc430z1Xvmdd7fg2vms81cz7VUYShsgs7WNrbEp2an2LWbVLLIyFj56g7l5PoBt/47
 UNlAQccqm4ZdIk4A2VAz2OiQG/VKrR2TWOEiV3RhAPxKuBdpPc7SNXOK96d62kCKutTP
 NFKw==
X-Gm-Message-State: AOJu0Yxquv9x+0PnFyWw8ymBTw3aXWfCN1C+09OmS6Z6KnMMsxUIbIfm
 VSlLZf1dJDgB0bxFTGQId4LzY4SIsXLd0g21f17N8TR497IdECHxPaZy7EWkXEZkepM=
X-Gm-Gg: AR+sD12eq6mT/LwI07hU7Hal80Rk4X2zRxIMj4CwDmrT5zSq5B42NrZeP4+roLAvXOJ
 ZEEyXhnVkC79GoeiPmt8GnrwzhoAt1Gnma4lhwh8DMv2K9ZonKy3wHy7Y+i3eJKIhsljah2Yd9q
 /cQ3Onaec9Q7po85RJOXSlozYl+Y+50c8jnGclF6wnNZv3HcGz3QEBEgNhsONtHak5UQGLasNI3
 5H7Y53hgDSlM8sFMeHhKyOLZ+zlyy4YGrL3MYyqWch0iXi2DiRIdxMVTG7p7ul+xt68iqKIuCYN
 +p8tssM0n6u00qNVkJCjTfTJlJJKGA2sFSX1cBZc06cQaotPx6e6HuVnJEUUz7DwsQAP8pU4gPA
 iXU1q+m3bBYtAJZUYQGe9swQFo89fcxkEJdMU0QBz7sPLSogoZZ/uUlxB7qwi/Ct1yaNCdyNyux
 G0zckdsO+rVVSMI1PwrRh17y/VsNyjiDvBIT5tCNrYCGsGv+7r8KFO6Lo=
X-Received: by 2002:a05:600c:6289:b0:495:636b:e4e9 with SMTP id
 5b1f17b1804b1-495636be6c7mr101282425e9.22.1784709210417; 
 Wed, 22 Jul 2026 01:33:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:51c:217c:79fe:1b0c?
 ([2a01:e0a:106d:1080:51c:217c:79fe:1b0c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495686a8600sm105173145e9.6.2026.07.22.01.33.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2026 01:33:30 -0700 (PDT)
Message-ID: <32a5043d-d44d-434f-b512-e869b81d10c1@linaro.org>
Date: Wed, 22 Jul 2026 10:33:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] ufs: derive the per-region RPMB CID and size for
 OP-TEE
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, trini@konsulko.com, 
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org,
 bhupesh.linux@gmail.com, n-francis@ti.com, marek.vasut+renesas@mailbox.org,
 shawn.lin@rock-chips.com, igor.belwon@mentallysanemainliners.org,
 yoshihiro.shimoda.uh@renesas.com, alchark@gmail.com,
 tuyen.dang.xa@renesas.com, padmarao.begari@amd.com,
 macpaul.lin@mediatek.com, jstephan@baylibre.com, bb@ti.com,
 j-mcarthur@ti.com, venkyada@qti.qualcomm.com,
 hayashi.kunihiko@socionext.com, dlechner@baylibre.com
Cc: u-boot@lists.denx.de
References: <20260722060805.1428110-1-jorge.ramirez@oss.qualcomm.com>
 <20260722060805.1428110-4-jorge.ramirez@oss.qualcomm.com>
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
In-Reply-To: <20260722060805.1428110-4-jorge.ramirez@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784709211; x=1785314011; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VTFJcmKWcTKdkdJHVM90/JWRz2O0OQIwldDzhOvINN4=;
 b=UH8MoLfgW2/PY5E1lV/H0R/jGe3+Y1uVzGpRP6U9tJNZdVkAR0X5lgx8tzMDbaPnSC
 ifGs5K3fYmYYuSOZQRxeSDHpbMtTriRfA4oRwtQiEUcnBwQZnaW/fiXF0TqiwOb964l4
 Zloau86otH6I1VFVSrubGrHcaR7MITGdK+t2saCBkxCLW73NludIf6ZF+kwDKaRoCfz1
 AOLUiKiPkbsNVrvMyMvfVlNGmCQ3RKDC8VgJ7YFkeYVdqspflv2U09qGZetCfsIwAkgQ
 ZQY1jJbTbex3JQqgF0AWgTW+vwpMGmcoxiKNcHrg8k40/nEpGcqDOzUh2Y8DteYvzJZx
 naRQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=UH8MoLfg
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=neil.armstrong@linaro.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="UH8MoLfg"; 
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

On 7/22/26 08:07, Jorge Ramirez-Ortiz wrote:
> Read the UFS device, unit and geometry descriptors to report each RPMB
> region's size and reliable-write count, and build a 16-byte CID by
> BLAKE2b-hashing the same device-id string the Linux kernel derives
> (ufshcd_create_device_id() plus a "-R<region>" suffix), so OP-TEE derives
> an RPMB key that matches Linux. Exposed via ufs_rpmb_get_region_info().
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> ---
>   drivers/ufs/ufs-rpmb.c   | 141 +++++++++++++++++++++++++++++++++++++++
>   drivers/ufs/ufs-uclass.c |   4 +-
>   drivers/ufs/ufs.h        |   2 +
>   include/ufs.h            |   6 ++
>   4 files changed, 151 insertions(+), 2 deletions(-)
> 

<snip>

> diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
> index e320a6dcfbc..3a0bcd287ea 100644
> --- a/drivers/ufs/ufs-uclass.c
> +++ b/drivers/ufs/ufs-uclass.c
> @@ -1801,8 +1801,8 @@ out:
>   	return err;
>   }
>   
> -static int ufs_get_device_desc(struct ufs_hba *hba,
> -			       struct ufs_dev_desc *dev_desc)
> +int ufs_get_device_desc(struct ufs_hba *hba,
> +			struct ufs_dev_desc *dev_desc)

I still don't find where ufs_get_device_desc() is used.

>   {
>   	int err;
>   	size_t buff_len;
> diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
> index 9f55735602b..5dae8dbef72 100644
<snip>

