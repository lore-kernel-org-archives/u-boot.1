Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E81C36011
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 08:52:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69D07812BC;
	Mon, 31 Mar 2025 10:52:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qm+7eq59";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A74238144A; Mon, 31 Mar 2025 10:52:17 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 868018129B
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 10:52:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3965c995151so2239264f8f.1
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 01:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743411135; x=1744015935;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=fFcyDfx++loJn3RI2yVMt8jsSXElbAZzTCrDwtckiVU=;
 b=qm+7eq59kgeTKnz7G8r6iNXHnsenvA2nbwG0BL8yYZuGzbmnxDQWsGkpCT/jiAKWD7
 7XaVzmVo+qIYkNNQH8K+/nuGGfekFwhGqzoiChEOlua06JEF1vOo48y4Cd/T6imVXKeR
 pHC2wb2iRF0kbdTzN4phFsyeXw/WbL5+h7+TeS5hfdKXPjI5avv9vD4qlc50HhQ+qkui
 aIjSel4xjsTXVV055YkvUI6Bzr5UF/CC5/wC833cefatxuxsTwuwN8gEhIQRB3mSALxk
 4Hk8ktGJAuA9mS0oGzIgDM4AaK7s4xc95L5IxBvYgmgvpZD9WzTlnMbRqTPlCj29h1EZ
 bugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743411135; x=1744015935;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fFcyDfx++loJn3RI2yVMt8jsSXElbAZzTCrDwtckiVU=;
 b=TGIQ1Fa0IO6hqAvzWuKNjipVXspRrfBHVLKWdqN00+uWxJL6FeRrJLz7AALH9aQ0Df
 rwMS+yl/HPDrHVIWmLnpi+PpL8PmX1/hgTkYopFiZb0lXcwtQxePzr8pERpBRir4tRpo
 EqmlR2eMNkeyGjZOVLTiYlgHOq9wKeQR+SpotT4TQX2TGHQYVtAbVoDIYbSNB87jMuBq
 2Q0TDL6hykGGQA7WxSdXinZkEafWCecB1azR7iDNNPXmFCEGnY5vlTw/pjThZ5Et03UI
 DGthdjfsscDnDL/dQ10d0L1RvaxF7cV/3ezRom59XDAHoKhDVqyuaviFv1wlCNQ8WXLd
 YFDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjX0B8PCF/U0UKjC1BJOO4BV0+P9E4bhPcdrbwB+0VFGCmq0VLz3Ynn4L8KtNq2EjhWtG1f9M=@lists.denx.de
X-Gm-Message-State: AOJu0YxHNh85k99Yz86g057tVPAgVMKfLWBmHcRIrgQz7BIhc/O96s4M
 pnqgisanMUIFs4h5IOKb9NAhB5QGHZCjjo/64jg4BcS0mouFZDWRzL/G/tzEoGg=
X-Gm-Gg: ASbGnculSePyH7azci7IWDW/CPPkl6JlTye/e8ElrLbO875Kjd0W7qzReB+Qi7rJcwp
 8OFhkg2mIz2TL8K0mJS0mqR5Lg1yT3Txjbql3JT+QrQbJwXo4wzoOSUQnGurbactoF2vcQw1zTx
 ki8Lhf4K9/Gp5CkJIvz91gfJwKjfGHdvUquSHoN3jLpKd/QVEC1eQbOM2+G0bFb8PF6sWHGKCBJ
 XHz7zqrfRnG5NJ7FTRqkjCkUmWDFnikKhwZU+7I6jm28lqHRuXmvgM4LE9KY1BVKIFJJY3kp2FF
 B1QEbZaRMOYAuVRWTSt8SmbljWbKYQ5ReudKH7Z36t81BusZPQmuBQ2zTB/CsnHPpK6g/E7IQon
 5lqU/k+p9wlmx0U3a/g==
X-Google-Smtp-Source: AGHT+IE6wqtCm8eGKmVT+jbZpw48U/+2Q9IhBhDztd4C4VyoYdbUTZloDMOGH9f+AOpyCZdWpiDbkw==
X-Received: by 2002:a5d:6daf:0:b0:38d:badf:9df5 with SMTP id
 ffacd0b85a97d-39c120dee69mr5854031f8f.17.1743411134841; 
 Mon, 31 Mar 2025 01:52:14 -0700 (PDT)
Received: from localhost (lfbn-tou-1-752-68.w86-250.abo.wanadoo.fr.
 [86.250.199.68]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8ff02e84sm114409135e9.32.2025.03.31.01.52.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 01:52:13 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Daniel Schultz <d.schultz@phytec.de>, w.egorov@phytec.de,
 trini@konsulko.com, u-boot@lists.denx.de
Cc: B.Hahn@phytec.de, upstream@lists.phytec.de, Daniel Schultz
 <d.schultz@phytec.de>
Subject: Re: [PATCH 1/3] configs: phycore_am64x_a53_defconfig: Enable
 remoteproc cmd
In-Reply-To: <20250328055824.3849523-1-d.schultz@phytec.de>
References: <20250328055824.3849523-1-d.schultz@phytec.de>
Date: Mon, 31 Mar 2025 10:52:12 +0200
Message-ID: <87ecydpooz.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Daniel,

Thank you for the patch.

On jeu., mars 27, 2025 at 22:58, Daniel Schultz <d.schultz@phytec.de> wrote:

> This enables the 'rproc' command, allowing users to
> start, stop, and manage co-processors as well as load firmware
> images.
>
> Useful for systems with auxiliary cores, such as M4 or R5 cores
> in the AM64x soc.
>
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  configs/phycore_am64x_a53_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/configs/phycore_am64x_a53_defconfig b/configs/phycore_am64x_a53_defconfig
> index 4ee1bd829a3..72936865132 100644
> --- a/configs/phycore_am64x_a53_defconfig
> +++ b/configs/phycore_am64x_a53_defconfig
> @@ -77,6 +77,7 @@ CONFIG_CMD_GPT=y
>  CONFIG_CMD_I2C=y
>  CONFIG_CMD_MMC=y
>  CONFIG_CMD_MTD=y
> +CONFIG_CMD_REMOTEPROC=y
>  CONFIG_CMD_USB=y
>  CONFIG_CMD_CACHE=y
>  CONFIG_CMD_EFIDEBUG=y
> -- 
> 2.25.1
