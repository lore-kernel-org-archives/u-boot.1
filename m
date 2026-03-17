Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B04FD877E
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 14:21:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47D2484332;
	Tue, 17 Mar 2026 15:21:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="i6X9s1BY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36B348433B; Tue, 17 Mar 2026 15:21:38 +0100 (CET)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E14B884011
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 15:21:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-4042fe53946so2208795fac.3
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 07:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773757294; x=1774362094;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oOeKMQh4wGO20fsss9Z+8h5pJKR8hh7tKES9RQAvAx4=;
 b=i6X9s1BYONxvMEuvhEYB/vT+qofgzEr02aeRggjsJ7SWnTCem/QmgrpFkADjG89vI9
 OWltnm79uoDl/cApyAcZMxRFEDXh8hgIfxND5bhSw7NqLF8YkhABFVHAsgJXns3TaPkc
 I8Vkzss3EfEKiB4RW7iTp3j1sFdBi+fODXV4P1s4NfUd11QLFQNFjshxlIl9QNMUfi9I
 GAuPQUJutBwuTLIdd4fxZUVzUKTj63v62jhzcVCECgy8yZdONMAMIS7hOmMhTbi/3KXW
 VYiVtn41BGjYmzq9Xna7I8jFQ5yg/8Lltkk+2KM9c3cQOxS0cB6PRZ9DQst4hfKRofQq
 E8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773757294; x=1774362094;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oOeKMQh4wGO20fsss9Z+8h5pJKR8hh7tKES9RQAvAx4=;
 b=a2UP990kuPzMq+OGo4KK7zrmXtICyPPs9OYJIDt42216NJIHw5E6Ha5BdQyLWF6GV/
 A0659kDuVx+e0gEBEKJ4VA5XbEmahnm/jMCcWXp98iuhwtL49vt95RsVEnqmyOygu52u
 utnHWQXoVq8Thet92TtGMuT9KiIuU8/WT2qN6radQ4N3f2iY9vfXZiki8nQE97wynWxl
 Wy7ABSh0MkvtqUg6xkYoHOCD3Al7HaQujn5g6pXrxJzaMBcT2JJGOm8L5p7iiH6WVcwf
 OxsjRNLAHrw1XUQwOZLIePQKGrIgKeAdPJCSjYrJA2S9aRj2FKTu+ByMh6CmVT98fp7I
 4eQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYofNhkYNb4XjfZj7QF3B7Kesz24B0BalZ+ui92z0FKXkiXw39coL7r5NgF4RBclyVX+Q4pcI=@lists.denx.de
X-Gm-Message-State: AOJu0YxxmQcgJ0Fob2FKyucNAYSK0a+0fPsElQRGH3FuC+cFKcihwvuy
 u8+jMzJnpsn9tGUiTrZFqLmrMrcIX/uUkQil2VLCUniAjIttu9HVUgIG6FTidSl4pOI=
X-Gm-Gg: ATEYQzwENDWnaDhh2wm8wXBE2IBgzWBmRDh4A2TpzoBCkg0UTQ7YBZM0k3RT1ZHMLr8
 OE7M15Qx/2/pme6ilYkYwTdk9FuFsEgV0trmADChMgCLB8iR6BXv2RsKKqFtlg70Cs1wP2uPMBG
 xPH2Bl6hasM0gge49GfuK9s9lU7iAyqSeUdPbtbSIY4YoNSBnGyEtI66zni10HhAHJ5Xa9Y/Dx9
 anaBP9NBiiLUBsXqQJM62j8XpqF/SkqA7JUCf5ZlyawuMLNFg4vTW5DIWp+3RAk7IcuAxauphhv
 /6GfZ3Qqnf5GzQz3yqqzU1FFX7Tv4PrV3Z5rtOYY78M0TPXR0P3MLAE8uP3Uc/YMRkqdr8Skjf0
 fdfFpnc9SNyWq/lmP4SF5BcBBUq9vR3seKvWPJgbxHhHwodVl3uoKef5giZ69C3c5E0HrHzwM6F
 frEPQ7jKbj+Jo+c9nlFS65RguhkqxnibEbjITOnSnqPsDfILzc4y+Wuz9Wb5gGQ5hR3ObmGeKxz
 5417HHT+Q==
X-Received: by 2002:a05:6870:aa9a:b0:417:2daf:6aa1 with SMTP id
 586e51a60fabf-417b93d6d49mr11519671fac.37.1773757294371; 
 Tue, 17 Mar 2026 07:21:34 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:6995:28aa:eeda:102?
 ([2600:8803:e7e4:500:6995:28aa:eeda:102])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e25f037sm19148083fac.5.2026.03.17.07.21.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2026 07:21:33 -0700 (PDT)
Message-ID: <67054ce9-c839-45f4-b73f-ec46899379e1@baylibre.com>
Date: Tue, 17 Mar 2026 09:21:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: mmc: mtk-sd: disable dma for MT8188 and MT8195
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 "ht.lin" <ht.lin@mediatek.com>
References: <20260317-mt8188-mt8195-disable-mmc-disable-dma-v1-1-220da4144920@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260317-mt8188-mt8195-disable-mmc-disable-dma-v1-1-220da4144920@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 3/17/26 8:31 AM, Julien Stephan wrote:
> MT8188 and MT8195 SoC should be fully compatible with MT8183, but
> currently dma is not working on these SoC. For now, disable dma.
> Investigation needed.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  drivers/mmc/mtk-sd.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/mmc/mtk-sd.c b/drivers/mmc/mtk-sd.c
> index 7a4bdee7496..8f93e51599f 100644
> --- a/drivers/mmc/mtk-sd.c
> +++ b/drivers/mmc/mtk-sd.c
> @@ -1989,6 +1989,30 @@ static const struct msdc_compatible mt8189_compat = {
>  	.enhance_rx = true,
>  };
>  
> +/* MT8188 and MT8195 should be fully compatible with MT8183
> + * but currently dma is not working on these SoC.
> + * For now, disable dma. Investigation needed.
> + */
> +static const struct msdc_compatible mt8188_compat = {
> +	.clk_div_bits = 12,
> +	.pad_tune0 = true,
> +	.async_fifo = true,
> +	.data_tune = true,
> +	.busy_check = true,
> +	.stop_clk_fix = true,
> +	.enhance_rx = true,
> +};
> +
> +static const struct msdc_compatible mt8195_compat = {
> +	.clk_div_bits = 12,
> +	.pad_tune0 = true,
> +	.async_fifo = true,
> +	.data_tune = true,
> +	.busy_check = true,
> +	.stop_clk_fix = true,
> +	.enhance_rx = true,
> +};

These are identical to mt8189_compat, so we could reuse that instead of
duplicating it two more times. MT8189 is in the same situation that it
should work, but needs investigation.

And actually mt8189_compat is also duplicate of mt7986_compat, so I probably
shouldn't have added that one and just reused mt7986_compat.

Another approach could be to revert the change that enabled DMA in mt8183_compat
and add a new .compatible = "mediatek,mt8365-mmc" that has DMA enabled since
that is the only board that has been tested where DMA is actually working.

> +
>  static const struct udevice_id msdc_ids[] = {
>  	{ .compatible = "mediatek,mt7620-mmc", .data = (ulong)&mt7620_compat },
>  	{ .compatible = "mediatek,mt7621-mmc", .data = (ulong)&mt7621_compat },
> @@ -2001,6 +2025,8 @@ static const struct udevice_id msdc_ids[] = {
>  	{ .compatible = "mediatek,mt8516-mmc", .data = (ulong)&mt8516_compat },
>  	{ .compatible = "mediatek,mt8183-mmc", .data = (ulong)&mt8183_compat },
>  	{ .compatible = "mediatek,mt8189-mmc", .data = (ulong)&mt8189_compat },
> +	{ .compatible = "mediatek,mt8188-mmc", .data = (ulong)&mt8188_compat },
> +	{ .compatible = "mediatek,mt8195-mmc", .data = (ulong)&mt8195_compat },
>  	{}
>  };
>  
> 
> ---
> base-commit: d31f96cac1e25153779c44f1fe014978f9b06032
> change-id: 20260317-mt8188-mt8195-disable-mmc-disable-dma-b64499a6a47a
> 
> Best regards,

