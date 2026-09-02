Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E82C61DD6
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 13:19:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0629B80F85;
	Wed,  2 Sep 2026 13:19:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kcmI39khNFuE; Wed,  2 Sep 2026 13:19:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788355182;
	bh=DHbokjYFmY7fMzoBH8SK8ELj5f+jeDn85Tf4f4vnfLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dXylenLIjfZPN9UI7C1834bly0PzrNBjX3xfDNNg8TtGuQ73XAoG6RpEQqbGokudu
	 ZvFoCoS1y5iktAIeXTJ2w+nzIiVj37fpP4ygxNEuPcSljxomnWtb7ATGTBRnnsvupw
	 IRqfMlujlleSg/+6Xy7+9/urprooqevonkyeAkTvutomymC9YBSQvRt/r+TKA9zNCo
	 Q/nQPzofY97aXBdax/Mbt39YJcFz4tl+MscWb7hNFKpFnAKHl9+Mw1JNl2fqusxy8J
	 Vs45X1CYxybCGj5Eizm8MFlGmw/XhQjUPAQqf74mekpR3U5btoyQKzP1C42HiwjHnJ
	 xFYhEvylc+yVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0AA5280F83;
	Wed,  2 Sep 2026 13:19:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3ACA9127
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:19:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2CBA4606F1
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:19:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QVViKrk19XDr for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 13:19:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Oxr+Y8fX
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8504C60648
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 13:19:39 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-482f9309813so1055440f8f.1
 for <u-boot@lists.u-boot-project.org>; Wed, 02 Sep 2026 06:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788355177; x=1788959977;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DHbokjYFmY7fMzoBH8SK8ELj5f+jeDn85Tf4f4vnfLI=;
 b=Oxr+Y8fXCGmYc46tCmVU1a8hkI1VlFgKQ9DjeUdoa3+I/LOsM+8iLrJwXH9AKw97W/
 rz2lOowgL/WFEbiwV2ZzRiFK/YjD/Xt+QJ+RYOGurga0J/vCsofLsca+nP/A+0Pe7l2L
 RQusTotIagfYv91WcT4xSvjsQmgxfbV92GSrfX8MYAURyCFBCkPAtlSaDsTxoF7ao6B3
 oAIkb51kPlE3ynn2yT+PHM6drX2y9eogWUempWKpp9NzK4LS8RGQfIwDGjAwIfyJNELy
 sONa1VjAVqkPjeKXSIjl/7Ga7wNsZ1pi1XQhHfLR/Y82AI+3jpyNyVJor7Oaxk/ufrVB
 2Y/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788355177; x=1788959977;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DHbokjYFmY7fMzoBH8SK8ELj5f+jeDn85Tf4f4vnfLI=;
 b=iqfY5fWYalf7OvBpyo45JwyyRtyxKX6arEoYf6Ihj3xXUdnAyXNM23PCBlvUkh4vlk
 3koKE8k2E7LNhwniqLHslp+z9amWfnb4hU1RjZ3VoG2DfNddg8MSXSkEN2Hrk3rjWbpB
 1aq5XpDfoPfy0W+c/BlVNDHuzBqJ+3YeIqa8iVOKAE3vGS+MH1BQxvLyTzTnmnqnzlx1
 UcyW54MsCncbPJ24iQz+/lqfEnAVvJEsiICLoG0LwK21iF0PFs6oczEA0wHW9+C+yEhP
 Z05VecqUTIJCqe2pHKWadRQj+bC6oKuH8ltIAA2QwHDyFP4/xeoKncoXjSrRO7wMRIJI
 KY+Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpc1fjq8qDAgxG3j/0Rg7i8S1lGEKBryFOiH0fxVAThy9eOUM5zU6BIRJKMqxcXQWs6VyZGCDM=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++ntAci3bID/maXsGQVqbUInvWqAUiyrUjDXoMzB4uTJ5xB6KgTW
 HAuKo5soG4mC+NeXA5N2PuSqBd/jCr2XyzixP8CPg6eyqg/rx6BpZLI9sSBfmKGjd1E=
X-Gm-Gg: AR+sD121VbJz+QTqG6BCHya5t2hNXm/ti4iBYXlcwEkf6CV+DQd+qD1aJvU+60Bkc8t
 kYrBJIhAPzE2xsSnS4IFguoP1m0nt25eDAJkgxODa8EWoY07k6aSKkIsCKe5cjQH+hZt2tYMaJR
 Eqg7nPu/oSTXhkLF4VZ/nkq26nMNfpbZ7AxOTTPSpse6eMjylTZ4/nxjxQ+BBQ4QyZTy5nYhiaZ
 /azkB1nCfTUI2Gddc1Zrv4kXTx0RfwfKxvs7VraQfXr2dYna9Q0YPClr11uu13CvGyWND6btgHJ
 2weZWILzOb7brocl5BC3QhIw3rGtwGJ1DIA+9vznJBkVZLKSbmhdZJdJSu89ybFMbsBhk3HWNzT
 JwCZE4g0Pf2lz8sNy+YPxaZj1WQKZBNcio67hgK1LRy2a2VGC7zG9dPoyp1F77jizd63P4p7gT8
 kHZ66+xMDG8OFAy/l4kuZ4csJwSofdvtUL1OuJ+TlbyH9WNqqyWVG32lXQUj92ILfRn+5BA94HM
 R6gKlaJIZk/GUSG+enVjg0R1buzWTFi18091eMktBjySUTsWhXOb14dhRectIAVcHtVzwDgwZEt
 7Ms8BaBipIkHKEM=
X-Received: by 2002:a05:600c:5307:b0:49c:cfbe:5a76 with SMTP id
 5b1f17b1804b1-49ce55ecd3amr98490665e9.2.1788355176863; 
 Wed, 02 Sep 2026 06:19:36 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-232-147-181.retail.telecomitalia.it. [95.232.147.181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce478daf6sm122204325e9.15.2026.09.02.06.19.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 06:19:36 -0700 (PDT)
Date: Wed, 2 Sep 2026 15:19:35 +0200
From: Carlo Caione <ccaione@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] pwm: add MediaTek display PWM driver
Message-ID: <apgiLiV4SpC44DEh@macbook.homenet.telecomitalia.it>
References: <20260814-mtk-pwm-disp-backlight-v1-1-847992f0b815@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814-mtk-pwm-disp-backlight-v1-1-847992f0b815@baylibre.com>
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

On Fri, Aug 14, 2026 at 14:30:15 +0100, David Lechner wrote:
> Add a new driver for MediaTek display PWM controller. This is generally
> used for backlight control on MediaTek SoCs.

[...]
> +static void mtk_disp_pwm_update_bits(void __iomem *base, u32 offset, u32 mask, u32 data)
> +{
> +	u32 value = readl(base + offset);
> +
> +	value &= ~mask;
> +	value |= data;
> +
> +	writel(value, base + offset);
> +}

Can we use clrsetbits_le32() & co. here?
