Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA30CA5FBE
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 10:41:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C3F8F80C77;
	Wed, 30 Sep 2026 10:41:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Nh7d20G0dqNy; Wed, 30 Sep 2026 10:41:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E896480F84
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790764915;
	b=hsntMw1LErBJeAvB46uo69YREf/toruKcot/PJCyTQ/OKrqTbKwlRAViOvp97g5x9/Rf
	 uGkyEKkuQ4u7hV0V8x9hRNDluy1ikGo4B9NHQcXpqVSeLKjNE2XoMYcW3S9JgM/EINh8B
	 pzh86a1LU/KSfjGxXIQkPVzUBvET+3stuY3M2uVXtlWEAH9vPXXhUF4wEGdLXvjOqpCIC
	 qeVeUxyWsWdGCNthmLLNkrYRYC0iDCRq0JG8BQ3hi7XG37u53yuO3UAv4tUabMDK/XkXy
	 DHY2ULtcjR7Ece9QKu2xewLNb///d006BrvkLxvzRlENzNF3oNBU9s2b2D0PpMH3G8g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790764915;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=VcEXUmKOAXrhELj+7ubQALnYRIgQ69xCU/xfqkQcEDE=;
	b=IB6/39z0usXvTJLm9gajS5sA8TPONr+f9zxFccEQ5E6D775bGs8hXVzUAwr2tkqCHISp
	 ub9o8UpmVZS79shGb/jxtU/LOL79KwSv6cczSqSNoTVB8YfaJ16ZQIRXjjjoeyYf83xhz
	 ZvhhMlJYzAszwhp3FCdtwbFWFBdOKlhc2cWB46BeSjH36il2+olksgugbM0Jc/HFkHGm8
	 sMHOCnoE2Ns6hpGemtO0/aPWd6XA/h9WSAHMLSVKVdlcaSfiG62j0EjF3wp9XrIrG5MuX
	 jtKdfNK+55q9Cm/koyZ+Feo2BKZdqauaYCxRbQYLrnTSFYik1ch+QK8z/mvl5cv+UtA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790764915;
	bh=VcEXUmKOAXrhELj+7ubQALnYRIgQ69xCU/xfqkQcEDE=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FeRa2td0vU22qYAulASsJ5QqRZKm0QiQO8Emjcx2ts6kvf8ozI9KPVMUtPLaN0jiR
	 a6rbyfbiFBytLvBZW9HdMyP0TU1TBENFzZnA9DUsB77w0CKETY40MSFRqw0q7XaPzK
	 PHMuU6Uba7TUjYI9ZgoSNrm5yoWQIMRuhPgsJtBX9Erb9actCGaErBnMyzk2sgHhTY
	 iGPRYyoHs5GhLRBT5IaRj4xt+Da8XHZEQzybJQVFqlVNDxPObwIVOCzrfQjTR9kFTV
	 vaCH9H7dG1T+CpJ4RIDEuBhiiaALITJpkRykl1EXXPB3rkW9x1Ql3IGSLYq8Qu6Tpx
	 UFr3gZ635bc/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E896480F84;
	Wed, 30 Sep 2026 10:41:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D96734E
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 10:41:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 33618607A1
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 10:41:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nv4ZVuaePfbf for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 10:41:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org AD6B4606B8
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790764912;
 b=KgE+0+vRtMAuEperDRxRrwPbSq6/LzEsHiHltBZN4lSDkIy1TE/FASiFkzIrZXpylO7z
 YtNZmQ6qv/Nqq445mYNmLDq20Lj0uk9Rf0Ylxj633tSfMbriZ0jXfChb9SBAby3al0d9H
 ++qjAm2GInxvnjdT4X3xOwZUer3CSqofZICjnbsCxFhwHRfGK75/7DE5RkZd3Kuy/+Hd5
 bJmOZzJ2v+iqt4UBgcp0x/dKdN2A4vWa/I5XIohRp6V74aL+J31iVU57KH1jZS2TCsFSE
 eZMWojG8WMToJPgeGILff3RFh9cerV4OxaH3XRIbnkEV6VTkzRT+2uHNlIKi+qT5Fgw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790764912;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=VcEXUmKOAXrhELj+7ubQALnYRIgQ69xCU/xfqkQcEDE=;
 b=d34yjT6P0M9F67xEcSpVxaJxyTVVL2ebGbkEcLjR6203R/9Rm4gZyZ7pKHine0vWs4TS
 RNA1g6k6OwYyQMMpHnScsVFnMnu0LN+rfIHPVxV/5WS6Ekt2tDlxP/YT/LVTJqvMQCybM
 96cb7LeKlYbRghFfP39zRJ+1+Mau+Ne1hVvEdb+fi/Cg94C7nv6yOurAH5yAmBXLfx7lp
 k62LmIerAL5JIYeTm1VcLT6dYx/JU2r4KmvnrrsF2altUQxkZeqlrA9pYXm+BaeNHGIZL
 inJkt/moi6zkPXPnE+6OCHKk+FcKC1FrAa1hEvvJLJLjOpRai4n1aqQZyyCxoUvzSBw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="jGPDm/NR"; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=jGPDm/NR
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AD6B4606B8
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 10:41:50 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e7bcb94d3so38962995e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 03:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790764908; x=1791369708;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VcEXUmKOAXrhELj+7ubQALnYRIgQ69xCU/xfqkQcEDE=;
 b=jGPDm/NR6GYndgQKp2LNa7BzE01oG+AQBpsxNEvsg5892F7DIqtAn4qp9fuCD/88fc
 tV2hcUCUHrKQZEtPfLVXfEelNyPyZvuakXlCWJaGR/NFzWVnJYN6C96xDkwZGX5/cpQJ
 wcJISKmjMgM6kDyf8/BGlT9ydj29WpFV1Ba31fRRy6roy5/QFaZvNMyZMgfWJy+/WowI
 fBJIn/E/JYoOtjO0hjATRp/AsMcXai0Zt1P+pIXJsdMYJNo3GmfaMEjueKUvXk2n0aQD
 6snH7t83Tj8Po7rbghre+KTCan0bZuLXWqogFOVEn4QAsYse0QYjwiGEjOlhSrBo7xhz
 LuXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790764908; x=1791369708;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VcEXUmKOAXrhELj+7ubQALnYRIgQ69xCU/xfqkQcEDE=;
 b=CFKI1QN2mlVGX5DoOuBxK7ulCFGC9Wt2a1eDlvomZUILC7KwgOuPktiPu0FJ6dY2zQ
 JEgLozeyWinBaKJCbMYvbVy4tsFnHd+tV3qAM1bR9THPDGv2Arz//v6lBFMt6g9qZxim
 pzwZyHcoJVsyTIBVSmiFWl+BolaLLkavt2CkbgsMU474RvS+6zZad77QpChfufj8U9hC
 1MB8So39B4ETJ9ooF7d5R0ckU4JliAnN5vNNh/CHdiXqlFsphxNXnfcwlccV4+23S5Ra
 EQ/aWVvuNNvHJGGpuBF9vVzHMULWdynm+ZnAgt+Ju/8Sr7vLvwvPFYdCkohCjfOXnrCu
 J5TA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzbYswBGvJK4wt3/jznFJZVhpT8X9L/zwAr3/gBT+lOc92xjYsCj+xvGCqzrTMegrgHr+fZUss=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kBQBc1TYaBkEXUVDa/JhwIrq2FK0sarKi+68Tpl1kGCNuUMr/I
 vqW8D2xgeEHEIs6YQaRwPfio6DyTHCWgLRxwfi/jkdVNcGyCNiIekc3qMOwJXV5lVmc=
X-Gm-Gg: AYBFou1eLiY4cgWeES94RcC9vdWhI9cFMuA/3tl6P7gFhAoXKIXI5SxlVuxp0r+aq93
 6vvZdvdR96vUMALypkIq3GkFnHAMjXg+sKjZhZk0mGvr6C6gif8sZkBkqD8qgN48rcum/TGOGjN
 piXm2ChUqjUmZlZvgK4AdSMSJoidvkXqmi8LRGTE984WCy1seDuDvLBCO/ne2z5B6D8JdRtQNA6
 9ksYF7azyS+RJvmkBXKyipIDSTrGfZRU24cAOY7jAj/WCZQJUj5hR1piGVdV+c7CkjXBtu50zC6
 +QLOe2fg94xLnrYELxdmtpgsTedI8amFJd+YyMGzF8WKpKkdox/LAYMjsyLJsKk4W9wrDN4hUDY
 VZ9OwCpnROqpuMH0aC5NNCXr7VbuHPphHdrevZZ0am71KsuIupUjKSPYJulmxFCdbMiquhQYrPS
 QzjPoQHqfkzPiNt6EDJBoUS/ssArC77FKYgA2M2fg3D9Atx9jOr5pVBKLLVIaH8UyU+6H+RO5zF
 dQQjpvHq0dgv/bpo2NCBQFjOruZzZ/dtWDXZLI/FUo/YU+Ra64NuFCTBWcW3KKAtG2Cx3IjPedS
 n2/Q/hw7QJxcHTPwN5wnq25jxEVZ7rH1E8i2FckWP+gcx9HUllE3UWFiHipD5jtbaQ==
X-Received: by 2002:a05:600c:8b38:b0:49f:ce72:e930 with SMTP id
 5b1f17b1804b1-4a01b13d7d9mr15243305e9.34.1790764908355; 
 Wed, 30 Sep 2026 03:41:48 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0174e161bsm71190345e9.5.2026.09.30.03.41.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 03:41:47 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 2/4] arm: mediatek: add MT8366 application processor
From: Julien Stephan <jstephan@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org, Chris Chen <chris-qj.chen@mediatek.com>
In-Reply-To: <20260918-mtk-genio-360-bringup-v5-2-31451a136f96@baylibre.com>
References: <20260918-mtk-genio-360-bringup-v5-0-31451a136f96@baylibre.com>
 <20260918-mtk-genio-360-bringup-v5-2-31451a136f96@baylibre.com>
Date: Wed, 30 Sep 2026 12:44:06 +0200
Message-Id: <179076504678.1985961.10452262328690731030.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1790765050; l=4312;
 i=jstephan@baylibre.com; h=from:subject:message-id;
 bh=IRALhYtVMITAIVi/TpORmhQAP1RVHXKbQ8bw0l9lK5E=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgphAWFBQbyQxHwqbCvwEwIl9NQxnNa
 Ewt+3w/AUXP10QAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAomFhZIX3U/ffwURrzW/mOlhFObyK1UFLNXUQkE77CwNdbfoOeAFA0estAcomOiibZkEDT7wPf
 z9CXVJuEARwk=
X-Developer-Key: i=jstephan@baylibre.com; a=openssh;
 fpr=SHA256:PPc8djUi3lnQXuiRHH4CZ/icbEYOsksrEsOV7pDEmZg
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

> Add basic support for the MT8366 application processor including init
> Kconfig target.
>
> Signed-off-by: Chris Chen <chris-qj.chen@mediatek.com>
> Co-developed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
>
> diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
> index 5e6c50ca64d..c278b220773 100644
> --- a/arch/arm/mach-mediatek/Kconfig
> +++ b/arch/arm/mach-mediatek/Kconfig
> @@ -119,6 +119,15 @@ config TARGET_MT8365
>  	  It is including UART, SPI, USB2.0 dual role, SD and MMC cards, NAND, PWM,
>  	  I2C, I2S, S/PDIF, and several LPDDR3 and LPDDR4 options.
>
> +config TARGET_MT8366
> +	bool "MediaTek MT8366 SoC"
> +	select ARM64
> +	help
> +	  The MediaTek MT8366 is a ARM64-based SoC with a single-core Cortex-A76 and


> +	  a five-core Cortex-A55. It is including UART, SPI, USB3.0 dual role,
> +	  SD and MMC cards, PWM, I2C, I2S, S/PDIF, and several LPDDR4x
> +	  options.
> +
>  config TARGET_MT8512
>  	bool "MediaTek MT8512 SoC"
>  	select ARM64
> @@ -159,6 +168,7 @@ config MTK_MEM_MAP_DDR_BASE_PHY
>  config MTK_MEM_MAP_DDR_SIZE
>  	hex "DDR .size in mem_map"
>  	default 0x200000000 if TARGET_MT7987 || TARGET_MT7988 || TARGET_MT8188 || TARGET_MT8195
> +	default 0x100000000 if TARGET_MT8366
>  	default 0xc0000000 if TARGET_MT8365
>  	default 0x80000000 if TARGET_MT7981 || TARGET_MT7986 || TARGET_MT8183
>  	default 0x40000000 if TARGET_MT7622 || TARGET_MT8512
> @@ -207,7 +217,7 @@ config SYS_CONFIG_NAME
>  config MTK_BROM_HEADER_INFO
>  	string
>  	default "media=nor" if TARGET_MT8518 || TARGET_MT8512 || TARGET_MT7629
> -	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8183 || TARGET_MT8188 || TARGET_MT8189 || TARGET_MT8195
> +	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8366 || TARGET_MT8183 || TARGET_MT8188 || TARGET_MT8189 || TARGET_MT8195
>  	default "lk=1" if TARGET_MT7623
>
>  config MTK_TZ_MOVABLE
> diff --git a/arch/arm/mach-mediatek/Makefile b/arch/arm/mach-mediatek/Makefile
> index 35f748a70d6..51bf5789bb5 100644
> --- a/arch/arm/mach-mediatek/Makefile
> +++ b/arch/arm/mach-mediatek/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_TARGET_MT8188) += mt8188/
>  obj-$(CONFIG_TARGET_MT8189) += mt8189/
>  obj-$(CONFIG_TARGET_MT8195) += mt8195/
>  obj-$(CONFIG_TARGET_MT8365) += mt8365/
> +obj-$(CONFIG_TARGET_MT8366) += mt8366/
>  obj-$(CONFIG_TARGET_MT8512) += mt8512/
>  obj-$(CONFIG_TARGET_MT8516) += mt8516/
>  obj-$(CONFIG_TARGET_MT8518) += mt8518/
> diff --git a/arch/arm/mach-mediatek/cpu.c b/arch/arm/mach-mediatek/cpu.c
> index 56a41e42df6..04ede8823b0 100644
> --- a/arch/arm/mach-mediatek/cpu.c
> +++ b/arch/arm/mach-mediatek/cpu.c
> @@ -39,7 +39,8 @@ void enable_caches(void)
>  u32 mediatek_sip_part_name(void)
>  {
>  	if (CONFIG_IS_ENABLED(TARGET_MT8188) || CONFIG_IS_ENABLED(TARGET_MT8189) ||
> -	    CONFIG_IS_ENABLED(TARGET_MT8195) || CONFIG_IS_ENABLED(TARGET_MT8365)) {
> +	    CONFIG_IS_ENABLED(TARGET_MT8195) || CONFIG_IS_ENABLED(TARGET_MT8365) ||
> +	    CONFIG_IS_ENABLED(TARGET_MT8366)) {
>  		struct arm_smccc_res res __maybe_unused;
>
>  		arm_smccc_smc(MTK_SIP_PLAT_BINFO, 0, 0, 0, 0, 0, 0, 0, &res);
> diff --git a/arch/arm/mach-mediatek/mt8366/Makefile b/arch/arm/mach-mediatek/mt8366/Makefile
> new file mode 100644
> index 00000000000..661744a4398
> --- /dev/null
> +++ b/arch/arm/mach-mediatek/mt8366/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +obj-y += init.o
> diff --git a/arch/arm/mach-mediatek/mt8366/init.c b/arch/arm/mach-mediatek/mt8366/init.c
> new file mode 100644
> index 00000000000..13123be068e
> --- /dev/null
> +++ b/arch/arm/mach-mediatek/mt8366/init.c
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2026 Baylibre, SAS

s/Baylibre/BayLibre


> + * Copyright (C) 2026 MediaTek Inc.
> + * Author: Chris Chen <chris-qj.chen@mediatek.com>
> + */
> +
> +#include <fdtdec.h>
> +#include <stdio.h>
> +#include <asm/global_data.h>
> +#include <asm/system.h>
> +#include <dm/uclass.h>
> +#include <linux/kernel.h>
> +#include <linux/sizes.h>
> +#include <wdt.h>

nit: out of order

-- 
Julien Stephan <jstephan@baylibre.com>
