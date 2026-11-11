Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCE0606A324
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 19:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KdzNR7pD;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=klNxpLGQ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4F99560DB2;
	Wed, 11 Nov 2026 19:04:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id syBESYQc3vj8; Wed, 11 Nov 2026 19:04:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 711F860D71
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794423862;
	b=BTjtxa1Ocv4jpWXYfNjwiZcDu48EHFBJwz40hO7JfjQfZhXtFiONdEKAaMkcB0je1kJj
	 B7P4DZjv1GSl7KpMaodoh2PjkPF1sKh2n3YQVd7B+rQruvkOCmCV0YkKIk0QWimCc5uls
	 RoAt3DDikgNOx6dQjxDwU1OtMG+8ATOe6dQ78TMlnmes8fixY2bpHH+0ndHVPjMxYPFBK
	 UPPVo7eELKw/6cQuVF7NTMWmX85w1z4br0UIBR5YNk3zqXfsMO2DbE6S37JjksGTpkctA
	 xI9nuPdg77yhdS/mh95l8IYhM8PQcyoRI1O/vz7cMky7+mMAW5NpzGY5yRq1WLrfPSA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794423862;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=gMEwbVo0hz1k6qTzK9LSi66TL/UpbjMV7MmhIeYDye4=;
	b=RdpgZk7HlPsHHcy0VyrFZ8idUGSDbrcSBrKCfCfdokE/t5feIW29m3sDhXHrjQRx/uns
	 7B98Mz1SbdMe5DIwb2I98eE3TXmd6C7B9ylbUm1N5g5hc6njdjc8PRoHuyzJF9rJU1WR6
	 ZR1iseBzct6h78IXS6QhgOMnzd/IBZ4ddZha4K9OmIWNix1FUKaxwZH7nQ7IDNO+P5mcS
	 U0ZiP3+XhYe1ibFO/JHhFhY8ra56PKz6ophbPSBTRuKa1UfvF3uQ5h+xKFuo/6TiwJYR/
	 5vHAY4Kq+SGRzFoiuF1KUBUu9vfTuE/HyuUoiu8Re42h+yyZZmpgdCyVhChGpMhaxjg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794423862;
	bh=gMEwbVo0hz1k6qTzK9LSi66TL/UpbjMV7MmhIeYDye4=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KdzNR7pDelZikrq5s+5PLK/gzIkH53iA2Po+oemCp1nhiTAw/nD4Na4gh64ZwnbH5
	 FmQEKkbxI1dZ5qiTdh6ALo6voXOrUWAlnIFxJfCEIy8AgEjFwEeR1cD2Ri+fm+jGDf
	 nz0O6BOQEG64lmg9eGEsWy9TpljZlPFuTRgJrIuJYBYXCQnqmkaWRc6nvCUBkgusyk
	 QoqkIUTPAbiLRHTVo6UjBnuuMxaMfmgO6wtmolGxgN3Dxwqoim3A8cNuw4T9G8Bg1F
	 PgA5lxq42Fh3DaVYFebJrk1B2/HOpc43JxlvjzbLvsJIF3RHvLW1VTvpXTUJi1Cukc
	 qIVNSzHp9CSZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 711F860D71;
	Wed, 11 Nov 2026 19:04:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8449870B
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 19:04:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 75BCB40987
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 19:04:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UHIciAGCi-pQ for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 19:04:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8316C4034C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=klNxpLGQ
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8316C4034C
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 19:04:17 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so29917165e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 11:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794423855; x=1795028655;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gMEwbVo0hz1k6qTzK9LSi66TL/UpbjMV7MmhIeYDye4=;
 b=klNxpLGQB3z9mCiDHuP+KaLsyscmv+WLm0ypnYEIz9HorC2DNahvqVCDZAk85wd1n8
 PoJ1m7fpfp41ESm5iHyIugXaUkxluCyNRyOKT+byDiQxXVTsxguDRzn2nMIp5dt9eYr+
 QPN/xgo6dZfv4SPZR5xEuHICcuo8PyXFePjd0XmX4eTBR9Bj2O9kYoVd2WlmevH1nGti
 kwAd9RqcC7bElT/h8r188Olg6Fw0S/dq/+0uGPgR4gpfrsYmFCWodREc1Fcn1jT2EzDp
 0G0hUg7FPxD/R+4nHMdgrQl0dZRLnmRpcwl/GBlUUQUII/zUr25TY9VyMisczzc7KG0+
 4jwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794423855; x=1795028655;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gMEwbVo0hz1k6qTzK9LSi66TL/UpbjMV7MmhIeYDye4=;
 b=DYydKDIOCEKGFB5dvFWIbC0/sTel0m+2TCx4fJGYWgUfzSS0c/S0nhtwyOsVxj3urX
 KybsMaCVoGGAUWcqQf8dxEaLZIAnz6O5TYzilHd7lKTWkhXcA+pLXU62O0hPPjgUc8KN
 FVrbgwKltbbbnEULst+ggJBpTNZfj1tnt8b3ZI7B4qfdfhPcl/SdBMqUFfEDpcH+oX6E
 81X2fw16x6NyMQSBSYLNAAgVtiDrDO8SnlGCyLBKnv2XrlHzUobHK+yAMPsiVen2YXXC
 xSJxhQNmxNgmLUunhRme35miMTux7Zn0v5J/QpE2l/Qx594agaVNTBd5DSDYVTcah7NA
 HBVg==
X-Forwarded-Encrypted: i=1;
 AL+hErEMF8shvLHC/zGRUvNnzhJqanGR8I596ZAsu4dNBkttZhCXJI+NWUaiidoSc9rhhCjz6tc0+Gc=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/8xaQFM+psm0FG1LXZ5wPNtQraPeUGk/h8zHyDBZubo4jhVh6B
 yYNG5VzoVehoWmqi4/ZbJFRwPGWLWKlsAnpGS/ekPSaAXLhFWOU29iJY10l7mOMQHk4=
X-Gm-Gg: AYBFou1kzJkYLyszHW020nMZtlfMR6N7T08Fcb7BEQOCLIAbCj97//OGMm+XDRB8jk3
 /xoVB84CPH2iLVyIC3xSW6uvLxV3GHqX0hDn+8cBMuRBuNOn3QA19qw2E+f0tDIYU02B0ZQ1xKL
 3kz0m4R8KwPUyV33EPuQbMcZHQhBNyDXJo9alBzTy3S05g5U38uYXzUSWz64whpbOq+Xm/Fyiia
 TnVf7rm9TsLoSe3IdOd2y0CX4WMZjBXdYO/9F7yw/zLj7SgWDdhC3b1kkHtNnNUdTXYQSWipC/C
 OsqqIvzrG+PMTtXzfJM45hEoBzYEQkCgC0Lw8kllaaM61/zKtDPEQoO3VSHqMG7uMCtufRyr85c
 X8qV5mfo4tr5YhNiGlkmbFjLOSiZkoyN5UxZAPiYnvyjzXey7qTX5BVUQty6jabW7HOokzrxVQ0
 eC3IV/Hi/FFFXLKb0Z8TGpJ8ppHLajwzHQcSu9ElDqC3F0kCVbY/iu0zXhS9TDU+92x40u81WKn
 /xhBCUBXjxGUPfPnPXBb1dECf0rBXuW5hvnzhm2/VgYxKQteJ5h5XOdpo/SRGUsdhakCkbzRuBa
 2GpqvOrKkOzymRl7MEMJNM8oN97bXQyopWZJIdUlOut2Z+MjghVZOgOWObVyiazea8ahXmpNewZ
 4yI7LJHtjS/7Mglc7rT954b8Ztf7me8c/ci+tS+drlUsMUQ==
X-Received: by 2002:a05:600c:859c:b0:4a8:cb23:f71b with SMTP id
 5b1f17b1804b1-4ba093be24cmr49413185e9.18.1794423855193; 
 Wed, 11 Nov 2026 11:04:15 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e251c26sm8622285e9.1.2026.11.11.11.04.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 11:04:14 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 5/7] arm: mediatek: make the BootROM header info
 configurable
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
In-Reply-To: <20261106-mtk-genio-720-spl-ufs-v1-5-90c578b6c43b@baylibre.com>
References: <20261106-mtk-genio-720-spl-ufs-v1-0-90c578b6c43b@baylibre.com>
 <20261106-mtk-genio-720-spl-ufs-v1-5-90c578b6c43b@baylibre.com>
Date: Wed, 11 Nov 2026 20:04:09 +0100
Message-Id: <179442384950.26078.9227626835965738462.b4-review@b4>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Add a prompt to MTK_BROM_HEADER_INFO so that a configuration can
> override the per-SoC default. Some SoCs can boot from more than one type
> of storage, and the BootROM image header has to name the one that the
> image is written to.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
>
> diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
> index fec9601e80c..4f7bedcb28b 100644
> --- a/arch/arm/mach-mediatek/Kconfig
> +++ b/arch/arm/mach-mediatek/Kconfig
> @@ -221,11 +221,16 @@ config SYS_CONFIG_NAME
>  	default "mt8518" if TARGET_MT8518
>  
>  config MTK_BROM_HEADER_INFO
> -	string
> +	string "MediaTek BootROM image header options"
>  	default "media=nor" if TARGET_MT8518 || TARGET_MT8512 || TARGET_MT7629
>  	default "media=emmc;arm64=1" if TARGET_MT8188 || TARGET_MT8189
>  	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8366 || TARGET_MT8183 || TARGET_MT8195
>  	default "lk=1" if TARGET_MT7623
> +	help
> +	  Option string passed to mkimage -n when generating the MediaTek
> +	  BootROM image (mtk_image). The media key must name the storage
> +	  that the image is written to, for example "media=emmc" or
> +	  "media=ufs". See doc/README.mediatek for the supported keys.

Should we have `default "media=ufs;arm64=1" if ...` as well?

-- 
Carlo Caione <ccaione@baylibre.com>
