Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480F5CD6E74
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 13:07:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40E5A848F5;
	Fri,  5 Jun 2026 15:07:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pdWz+upe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D308C84915; Fri,  5 Jun 2026 15:07:56 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57575848A1
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 15:07:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rmandrad@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-bec429c2bb1so285178666b.1
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 06:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780664874; x=1781269674; darn=lists.denx.de;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=4G6jJB4OmpEXeZ+mXvCd9WxpnIQ/YlGtCl4diLi4Wqw=;
 b=pdWz+upemP/ki1RYrsfV6AmQkMsc3/SZPUCnz3Xbm8O5ApFwSVzzNhoUhbtjjtNhs5
 fU4Gz1/JN8j3nt+5NDUTq9ZMx7OtRmolETzgNYg1uTgl8a2X32ZKwBu3CdFUyEE4opLH
 JHjPbl89/tOyUaZoeQ7OPg83r52HoVw48u6xTWV3saZNtIGB8vqlYPJsYJwfA62i+54t
 FX+hODE2x0SZigHvsuJMCIAjMhlZ/pWKk1/g63tt3LLjhCzXHIVUj+9gXo1HFa74nMR2
 V6zihHikAv5Y9xRmYszSEuGISel1sF1cj9yPI99G/xSOMQs35FHLMcxEoAX3j4E/O7wV
 2Bfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780664874; x=1781269674;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4G6jJB4OmpEXeZ+mXvCd9WxpnIQ/YlGtCl4diLi4Wqw=;
 b=go+X3uAvWj12yUxA7hEuIniNniv1J2iV/UWu62PwU3K0Bvk3YqsgFhwq1r2KD0McOl
 a0W8rupGBLeRtfdvWgXcvD0IoD8pQ327OqrlLMTsIsFsGRcV2PMZSKaX3xym3xE73Y2U
 lWK2O3ZC/lEOOFpG9oC1LnaqLY/U26vfyYH/tnJo7Mg4BaXYEMJP4XilTP/pioZNF55A
 TtLaQPRKSC5sjPcXbsrBWnTTlbzlQX3hxGClHJK7PeVwEk527ly9J0omGlSiRzcHn4fe
 JXT2qeWfIkQhxv2qQEAwexo35BVZF1hoFswTvKqaLagQNS2OwS/ipxVYr46aOnftsUUM
 lr9A==
X-Gm-Message-State: AOJu0YwadBqzfiGvsSY2TeX6i8078p+RkWS0CKUTiPp+SdSwbyo+e2Li
 vHaFR4kJTEy6d/2Nvo46N3HJQ2OPnVelwJQpaKNSKV96ooIynXBBrL4=
X-Gm-Gg: Acq92OG5hhrsQKGmZ3JcgkHr3ElExiTJG5XWIXRW9yRVGkJVI2z+sXaWU8ffdih52ij
 aJGnO1+DDJ8wV83fHFf/dRV+ejjXUH5dMrarUtGfTY6QqId91zOaZh4VQd9+u32DjD/0kpJLPs5
 6FgkGTdEESH6trM+LVPtdqpQoBzSkRgcthS/Qy+IVZLc/pezcugAfzRI5L9OjmLIXuYjGHivxhG
 CNy9p1EDO0bjcqS6LlzpOHzU3KAgWcBco16xdzBHZUDloO2M3DRreqxL0bqgGZHHIy8d/RJaQrF
 NnH3Ro8Y8f1I6kk+5s9HojP82IFu03YpAvXFxZTjj4H3ITfPF0RHeUxho0X88DrC0AAN0+FJ0Ns
 ge5KJNRVJ4g6y5bA02KGMQGlHpDr35hyQ/VPX3q1ekpY8LyqrimOwpnSqWPs6bs+d8RHPr0L+Nx
 rFAeX2OCxC5V5tFIGSMtwBFGWCRiZcDgC1LQCMoevxGSqfWD+MVrp1EPezXvpYMOEHGdWQnuSAq
 5fHt6R2Ph3Xj74wGleXy6o=
X-Received: by 2002:a17:907:968b:b0:bee:9809:3ccd with SMTP id
 a640c23a62f3a-bf3701813e4mr182513766b.4.1780664873377; 
 Fri, 05 Jun 2026 06:07:53 -0700 (PDT)
Received: from winhome (cpc112753-pert6-2-0-cust678.16-4.cable.virginm.net.
 [86.18.22.167]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf05176fd20sm472782766b.7.2026.06.05.06.07.52
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jun 2026 06:07:52 -0700 (PDT)
From: <rmandrad@gmail.com>
To: "'David Lechner'" <dlechner@baylibre.com>
Cc: <u-boot@lists.denx.de>, <trini@konsulko.com>, <ryder.lee@mediatek.com>,
 <weijie.gao@mediatek.com>, <chunfeng.yun@mediatek.com>,
 <igor.belwon@mentallysanemainliners.org>, <jstephan@baylibre.com>,
 <GSS_MTK_Uboot_upstream@mediatek.com>, <emanuele.ghidoli@toradex.com>
References: <20260602162233.2418471-1-rmandrad@gmail.com>
 <CAMknhBFeV8qio29t1zNhoBNdumbWh2ErOE99dQEphDKZN8GodQ@mail.gmail.com>
In-Reply-To: <CAMknhBFeV8qio29t1zNhoBNdumbWh2ErOE99dQEphDKZN8GodQ@mail.gmail.com>
Subject: RE: [PATCH] arm: mediatek: mt7988: restore full DRAM bank reporting
Date: Fri, 5 Jun 2026 14:08:33 +0100
Message-ID: <003e01dcf4ec$6a507830$3ef16890$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIEQ/kMLkV4Qkej/ZvY+9FqTz2RbQHquDCHtdH4C5A=
Content-Language: en-gb
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

Not the header file as   TARGET_MT7988 sets SYS_CONFIG_NAME=3D"mt7988" =
in arch/arm/mach-mediatek/Kconfig

In the mt7988 I don't see CFG_MAX_MEM_MAPPED used elsewhere than just in =
common/memsize.c where it limits get_effective_memsize()=20

Unsetting/removing CFG_MAX_MEM_MAPPED would take u-boot above 4gb... =
Some MediaTek ARM64 ports may keep U-Boot below 4 GiB because =
peripherals such as MMC need DMA buffers below 4 GiB ... so, it may work =
on my setup but not others. Also, not an expert on u-boot  I would =
suggest for others to comment/review
=20
-----Original Message-----
From: David Lechner <dlechner@baylibre.com>=20
Sent: 05 June 2026 13:52
To: Rudy Andram <rmandrad@gmail.com>
Cc: u-boot@lists.denx.de; trini@konsulko.com; ryder.lee@mediatek.com; =
weijie.gao@mediatek.com; chunfeng.yun@mediatek.com; =
igor.belwon@mentallysanemainliners.org; jstephan@baylibre.com; =
GSS_MTK_Uboot_upstream@mediatek.com; emanuele.ghidoli@toradex.com
Subject: Re: [PATCH] arm: mediatek: mt7988: restore full DRAM bank =
reporting

On Tue, Jun 2, 2026 at 6:24=E2=80=AFPM Rudy Andram <rmandrad@gmail.com> =
wrote:
>
> MT7988 detects the full installed DRAM in dram_init(), but after=20
> commit bddd6bbef3dc ("arm: mediatek: mt7988: drop=20
> dram_init_banksize()") it fell back to the generic =
dram_init_banksize() implementation.
>
> That generic path populates bd->bi_dram[0].size with=20
> get_effective_memsize(), which is capped by CFG_MAX_MEM_MAPPED. On
> MT7988 this limits the exported DRAM bank to 3 GiB even when 8 GiB is=20
> installed.

Can we just remove the #define CFG_MAX_MEM_MAPPED (and the header file =
that contains it)? Or is it used somewhere else?

