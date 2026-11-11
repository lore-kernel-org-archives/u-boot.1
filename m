Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824A6606A335
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 19:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=OXxL8WEC;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=nkuR4AJ5
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5409F8082B;
	Wed, 11 Nov 2026 19:04:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N6Hi3uPxxvbP; Wed, 11 Nov 2026 19:04:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A3D1880FB2
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794423859;
	b=n8uvjqIKgv2FL+dd2HUy7or4dB9lxNftUZAUY81S8/uVjgDAkuu/4ZX2N8418ZLYxuU2
	 BcfW9Cwv+rCEa+KtcDZsfiWaT+ErR4i3rYS6yBEVEpKTTCq0tUGxaT2Pkc7vBLCFrghT+
	 XCaru88E2DcppOiBD+mBAzWAV8mFy2bhs36LwZn63gAow7Jcx/TFZ51yGxax9MD5GeaGZ
	 YKYKYU7lp5aVaU23zo+qmS/qdcpMFmNa8xgR+JexrStttSwzVntxDOKgBki59Jiv4YP94
	 L7SMpi19tJdJ5jhPXde9AkIatUBhCmvR8cGQm0qpLFqhTs3b0YwIHnMsBaWeRWv+/PA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794423859;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=AffJXCrCvnVZsyGs3QKdfVR29yvTUUW0fhPYsDrl1qs=;
	b=iaEcuwBBUJw0spXpyyPuw05/kFcaqB3SE+5Uc74Xn5lRmxuohM4eksUsqhePXQxx740e
	 Dbb5vbU6yQHNNNv7Uv8ovgwE2Y+97iAXzFSMPKK6mQmvdkCkhycObz7ulwUz3mSx/KQL+
	 AL9+m/X0/LdMU4xxSr7Dw63D+tgMPVIxYAjeLlX028JDl4NNxPmLFd5DML45saaDHlRvJ
	 oQMhXrR+FRuFEvCWOx48je0yyPcYnMxESXeRGl2QjFZvKiQkOyXHtLZq2pTj/cQTWaeUX
	 4IxxG8dlscQ20i0Knd7l7k2PoAHO8Q0d5mHW3Xapfa44wSnnzCi9wkg62UDtj+B8CWA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794423859;
	bh=AffJXCrCvnVZsyGs3QKdfVR29yvTUUW0fhPYsDrl1qs=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OXxL8WECFKHvPHNR6Vv2M7fZ22Pd3qfwSbyFlzrB5fhFIQOuC/fMJefdpVMnQrVDc
	 BDVDOSrG+9ZQixLskPGLLF/7lC7yAxaCq3YhgK0D1SnRz3kpSyb26CdKVujZzeS+a6
	 0mTVlc/AuPGKg2QfD4bX2/6WmT0P1XbC1iOUpVh5x9nRq2d0/14+bkJU9FRcPEKOHJ
	 Eoy3X7n9c31G8pzTlHAn1wc7tvApuXHvemF3MQFLw/rAi2pmqMg3zqtXn4GBWMmHFE
	 ZdRn6Ib/DPsJmq9d2VNErm9SfFLC73ItqDsFvnydepRX1P2I32coU7CgVNm0pg8iGd
	 TfaGzf/d2RVPg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A3D1880FB2;
	Wed, 11 Nov 2026 19:04:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 96D1B31F
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 19:04:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 88AF6403EE
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 19:04:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NvO6Mqwz3zSo for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 19:04:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 95C3F400AF
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=nkuR4AJ5
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 95C3F400AF
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 19:04:15 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so29916635e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 11:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794423854; x=1795028654;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AffJXCrCvnVZsyGs3QKdfVR29yvTUUW0fhPYsDrl1qs=;
 b=nkuR4AJ5QoVS08POdFVKJPfuLzYXwK9pCck7t70D/7YPoUbCDs/J/brUHBQvkbTXR2
 Hsw0zCvBGF0KwjcHh/1rRfibfPIlt/LRT3ZfGcRKVGnbh04ey4Iln13IWf1PfuW1Iwga
 fR5NiqF17jg0MUy8Sd9tHSL5PGaXwZRju5HqJwmXsjdgVVptJT/3H3jI2PRCVX33IwsV
 +C7DeIjE7GHDaF9mH7dqIGhPcYC6HgbTwh0mCuc/ojYuJNVbGZyUCxMzxAfW64CqHoVB
 DLSwW4FX+tJ+iJub2M6Ejf/Ahd3LBk49kIhz36KeqiDCC+hTBYAZueP8TYac+MHL1sgD
 nSFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794423854; x=1795028654;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AffJXCrCvnVZsyGs3QKdfVR29yvTUUW0fhPYsDrl1qs=;
 b=Qp99NKIV1XOtjZNOIL2D3ng++LG0g0IpSF4iTwx+3VLqCftArnxclAioG3R1Q53CFH
 b0Nk9Zw8BURpesgCWtANZ9N5G07yBrQurAS8IR7PGWkYb58wxNM0+JoQgPAtyCrMUzz6
 EHvRzPbW52VmXP+UHEGnKz1tRVn1+btJsQ6KcIdVhEZIOjht/rJkRpkpc1H1rcPH2hjj
 xo/ynReLGzWV9hqPxOlGqT8LH71DeToj72VKQ7cLDfK9vjFVxvq6rK/1fCirQVUlZkmi
 waVYUH32ffAdBl8R4kZ1TcHMfOE1fOX85rI9MS90cFsY7gkDfz3jUTBqmkbgAuLdMZMs
 DxQg==
X-Forwarded-Encrypted: i=1;
 AL+hErGnmcCkSm/ln9ObGibGrwHLpjYiYbPHkk54OE3Fetvk7Miq4EwpuMtBLHOrZGbkKe0KHxeM7nI=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+r57PyQHt7xbPTSrHYYTEgQJ2Vn5A+a6YSvOr1bZJnfhLnzLDD
 JIQEyvEGMlQ/eYP0ujkFq36G5c4yqNbOMPtoy/oFoxIX3XneD2NjKnBeF3wWO0Er7a0=
X-Gm-Gg: AYBFou2hOVjpROQksncY/htj2ynmQKC14D4cjsbjiMWm0kp+ClaCaDr1S+tgngRnbw/
 4ZQzAWtAmQXpEe/EdFpQdrzHK6m00ibC6RyJjgVXkr4KYLseg2GZjNn3N4JsjtvOWuvauMvmh7H
 TtOoM494k8nFfGim3Ze1IVvZ+aw+l1ciWp+XlnHM54/CjwXheGzHIa+wHmpP7UDXDOFmzhbCmcv
 GCo4L9nE9zVb+mxTWrWUN0GaDhWj0Lw2/j4Ee/RjBKjonkAzG/jjwm0AiShyYlZCozR2jANe/hC
 nxUSPIq9ORYMbc+lFTnWfLDesKqjxB+DTtl3oZ8XFh2wh1ssPJhELF8JNOWtv4oKxyfZ7+XY7lQ
 fmX5i7EHrCBOe3bmqW3z0NPRAPR0VkEamDgDmAmlTQQ4iHBA/eOMUI4/S5scn9v13WXZiysY9jD
 WQCxEfnOpjlPuW0hTdzScEUbnhNdVbpypuh8eeoel7865A9wRaRe7w/PcfhDTyz8wyLRmGdVhv6
 H7gjgkYnLyHCBBei1Wm/9fiomSgW06sgl/QJMfFeRVqMuyhpHh55JW6AH7NItMZN82EIpWl5JNc
 28kIcrp13dSLBlAMQM/v4nPSBQtaFFG2RwALt5r4SD6W4u2SRd8FJaoik05tacuGo/ZsmsI3Rh5
 rtlegcZzuUjUR6QsphWYtWtOgIdNdJRWILOtyPmwRftbxYA==
X-Received: by 2002:a05:600c:c166:b0:4b3:ad9d:e21 with SMTP id
 5b1f17b1804b1-4ba0936ed51mr65118025e9.12.1794423853966; 
 Wed, 11 Nov 2026 11:04:13 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e251c26sm8622285e9.1.2026.11.11.11.04.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 11:04:13 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/7] ufs: mediatek: skip SiP calls when running at EL3
From: Carlo Caione <ccaione@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org, Carlo Caione <ccaione@baylibre.com>
In-Reply-To: <20261106-mtk-genio-720-spl-ufs-v1-2-90c578b6c43b@baylibre.com>
References: <20261106-mtk-genio-720-spl-ufs-v1-0-90c578b6c43b@baylibre.com>
 <20261106-mtk-genio-720-spl-ufs-v1-2-90c578b6c43b@baylibre.com>
Date: Wed, 11 Nov 2026 20:04:09 +0100
Message-Id: <179442384949.26078.15240674797898354872.b4-review@b4>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Do not issue the UFS SiP SMCs when U-Boot itself runs at EL3. There is
> no secure monitor to handle them then, e.g. in SPL before BL31 has been
> loaded, and an SMC would trap into U-Boot's own exception vectors.
> 
> The SiP calls only notify the secure world about the reference clock
> and drive the device reset pin. The firmware stage that ran before SPL
> has already brought up the UFS device, so the host can still be
> initialized without them.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
>
> diff --git a/drivers/ufs/ufs-mediatek-sip.h b/drivers/ufs/ufs-mediatek-sip.h
> index 6a61f7bac69..cb27da1458c 100644
> --- a/drivers/ufs/ufs-mediatek-sip.h
> +++ b/drivers/ufs/ufs-mediatek-sip.h
> @@ -9,6 +9,7 @@
>  #ifndef _UFS_MEDIATEK_SIP_H
>  #define _UFS_MEDIATEK_SIP_H
>  
> +#include <asm/system.h>
>  #include <linux/arm-smccc.h>
>  
>  /*
> @@ -37,6 +38,10 @@ struct ufs_mtk_smc_arg {
>  
>  static inline void _ufs_mtk_smc(struct ufs_mtk_smc_arg s)
>  {
> +	/* No secure monitor to call yet, e.g. in SPL before BL31. */
> +	if (current_el() == 3)
> +		return;

Can we return an error from here? Otherwise functions like
ufs_mtk_device_reset() are going to assume that the function is
successful.

-- 
Carlo Caione <ccaione@baylibre.com>
