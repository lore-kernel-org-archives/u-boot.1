Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631EA606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 17:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TSCe0fDd;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UiezXijh
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 29B5E60642;
	Tue,  3 Nov 2026 17:32:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hqCNYQ92eybz; Tue,  3 Nov 2026 17:32:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 30A9F6067A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793727122;
	b=HH7ZrWmrQAZs//bXqLxTdCjZt/MwLDBKpA9tKBwJDMACivBX7gxMA1mcOm2hWqsvtT2V
	 HyhZ+44H0ygNDfvs9uOg+5+Qws18Pn99tM+sRMpTFCWpvFurIJOu1itMIgox7Tt0JbE84
	 eqztnuI1trSfZTlvGlNXqlWbqYcqbjgxMBvgAdIatZyf90i10EJBqs5xP+WYzMiL8kCIJ
	 inngfbHSn9SjqbXRX4q3iGTmrDuY9v74rC1QxHeY4cTs6H75qxBMashQsWuE0sDVFz0d0
	 A5hyGXXrJLiKuOReyk4HykWQ+p9zMFBNWub87p9H58Z4j0fv60/1RsRhKqCsxfrv6hQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793727122;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=MuuCqqmMmjj+T2OBAHbH2GjIOxqxd73UMZE43UXDtMY=;
	b=qCTvBRTakhxSsFUxM9HmIhBVMnoWHux69f1X0TpEdnqAVCNgG/J29WN/hfzZVPXzqcVc
	 n2e3SRoGzlasI5fzq/ogJll7LWaLOy8YcXq1h+YZYn89KyHdH2oWSnLRjPIAaEo6Xm7YF
	 u27hr98z//8GuxlwRDoixI4jEx4oe6CvnLtFF0NMzqCMPQrcW9WfmqPe0fUU8fRERGiQR
	 lq/yzisAyz5eomYx+KBMqh7NbiEy3nKA/TajdFMIuQ9EhMWG8W12odksyAyV0ucOr5kZb
	 iJm5EzP9Jw9uR0fuJiZzeD7CZXdngusVbaS3G81y0V44mr/g86zf/kA9aWa+eg6GaKg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793727122;
	bh=MuuCqqmMmjj+T2OBAHbH2GjIOxqxd73UMZE43UXDtMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TSCe0fDdmt9DNjccNnvz5TeXKVICAi5sxf+ilo2iH93YEr0SGgISL3JST/EfD7B3z
	 Utti7hRJ0BcdRhtUQAV/PMJV92uD0Neyc9lPTaZBGJ+C1fJUO51tK16BIrqX85BjvH
	 J3ldqA/+F3H9h22WOxycAiaWSmLWidfYQQ8jl4E96L+GvGL0B6kt8qI7ao7T7CuYWG
	 hW8VSWb4quqfSX8GipvZrWLDYYquenw7X5/uGCWMv52FagHBFiHxR8fZGtfvS6AdZ5
	 +/3W8d7Xn6XJnCc8vnE3mvoCBPwSmZq0GDbL2tUMyy/xsBkobvWkY+0zHF+Bb1qwQn
	 IkAiTq2z8lvXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 30A9F6067A;
	Tue,  3 Nov 2026 17:32:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C20F8A5E
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 17:32:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B180880CED
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 17:32:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ib84u8cis1zE for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 17:31:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 96FCC809EB
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::e35"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793727119;
 b=fVpsgjMzGKGi51bCrRGmgiqUXXRzRY33vJSG990ueXFK1ieZLiLXjtnUcoSF5wzpIbME
 QKOK4+Aucf1xVjIg9z7JW+aimo6LY6dSob6A3PvptYwdlvlXkZMHcUKtLKu3cMFhZXtaN
 4tcpsBgdCQ8MCyQwsMp+akwP191lbbB4QzpkrEi7kDpjh8sRTJyFxAxuTWADattX5jtXe
 LgjXDckUMgoUDQLWx1nCAlE1WSLegFgbtE6iTOBF15d8q7Uyver/SkkyDfy3dKAveOaug
 lfn0GAPT4YsI0V0KM7cKe+K6TqOlZm6jlUH5TGfEvn6HbDuPq5QlLzQ7FnAwFTQWJYw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793727119;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
 bh=MuuCqqmMmjj+T2OBAHbH2GjIOxqxd73UMZE43UXDtMY=;
 b=IRRAKSHTX43SS+b2aubENgK4/cdUBpYG6+GZv2PAEcBTkLwJfUwjK/d7RLtSCTtb8xWh
 mDwyzRse40I4lsSHN250ttHbWQP2n4bAeJ68srPDlNR5cB4VNDpzGYNi1f5sbTHOYX9YT
 BqRBIX9ZAjGQhfRvJML612XTLkWfeskMO3W3WaQKBUwsQd5isDSBIwBKmAC73XeVr19JQ
 4EPEQz7vAodDjrUlkeaAbfBeo1tw8eRE/PU2h7BNiLlfX45WOKpIyxp90ITWJwNmehIsM
 EXi95t+7ahKxL+bmf7ntpmZUrgzEGFT+69JFoqYr+/32UdCRZ+/mH3BoaojRT4NUmgg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=UiezXijh; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::e35"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e35; helo=mail-vs1-xe35.google.com;
 envelope-from=jpaulo.silvagoncalves@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=UiezXijh
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com
 [IPv6:2607:f8b0:4864:20::e35])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 96FCC809EB
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 17:31:59 +0000 (UTC)
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-7ce78f9d6baso651943137.0
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 09:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793727118; x=1794331918;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MuuCqqmMmjj+T2OBAHbH2GjIOxqxd73UMZE43UXDtMY=;
 b=UiezXijh1U+eK8s+cK3mFS/eBo82PLvqw2WLgqYsgYk4ORW5vLmY9KEYLIh4ZN616A
 3TYnvr/OrGWkjyYhZHFHYUdqSpDSKsFk2aFF1Lzn9KA2me2TaXIQ01YHLEbFcsniEcsD
 2CNhv9HAplXo3GjONDKYuPAjQS45pjQ/OBIxRvwTS9B/0egzXoyx/WCIaZ5L4IXG/fzx
 iRmpEY1Qg2rbUlQl26Wqwc7o+ebWwfDAPyuBKLyvh9g5fR9NZeCPX71jEmMr5pPFhGTX
 ClXtg+vVoU3s5Kx8Ep5aqPUTUl9AH64fQT08kA8OujksjMnKU+bH60ltIWjwHTCQeq5o
 VkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793727118; x=1794331918;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MuuCqqmMmjj+T2OBAHbH2GjIOxqxd73UMZE43UXDtMY=;
 b=0LhMS9oSp7vW56D3AS/M6n5MUBQp0/bCVjqoB3pAg30dflHPtajpCMffVCXq64jsBk
 IZDA12A8lPc4kFbK83WCtZ7WRC9cSTDnJ3IMBAxSvKZtF84Cyobi4ymrM1p6LKnRau82
 nuInd3fCJRU011NVKRf6NTvDMpUuHcIRoiO64D5qpy5t1zZwEDP4s/KOAhKoXt8onK3+
 q4oaDMWoVBkN2GOmOhlekl/bQyRfB27UNoYIvqAkXzfbOsPMOd/jXZEiJ7oiol8KWCix
 gFRTwEyAjIqr4L6ZP+Fftp5VtKdK7vgEXXB+qqBa0V+FttxCtg2NiEUTdI29mVD2Pvqh
 CG8g==
X-Gm-Message-State: APuU4Z8Eoh8vlSR5SpwV/M0pfMrawEgLbXCDcbW8tlCQgO09/SHWs+GD
 aPw7eK+UEZmURymISxMWhsT0uT4933MXpMQ8N3KaEHfDALWT/xYtYQ8Z
X-Gm-Gg: AYBFou2mofH490XJphzYRybNFpevFAcezz3acj3w30G8QtCkvlLSy+bkoFGH5CcfJ5O
 R3VjCsZp3Bdx9eQtcgtDWsGJ7uRyzYYuCDXavEO87/HjQ+pEw7QuSvJWMefnNS9r8t0eOrTmhJl
 wwMSn3qZiymCm5CJH9PqsdruE/MdyjccxBW0g2z3v9rN/dtK/0usC9KlKalLBU9fADks4/E65Bl
 RsafEOWDiyQ0fIH049T9Wal5lFuxQcYifAxSMgsAs1uoOj9xtjheCuuSbgn51HsxcKKAAxpsfjh
 iWZZUOO7FDpVBA/Dg9f3J/o3Fmbu/awaRkXNBccGtVY3jsoZH7UmyLQND0sOUBPaITqKnuxiju1
 HrKBsVr+soF8u+7960CmQ1Sau8gSOOcTGYp3v1WKpMTpUfuJHBj4to1kVP1tIDPJ/eM0kRL+Fil
 OPGp43nYhlvz0SGtmpCXbIenINdWTualGgYg8K5Bts7VZYtEycgtqou0e6qofiNKTgH4UO1LDst
 LptznMxthXZt8UeVzjdYF5PHN0t56WwW3MCDK/gKo7USV8rkDluOoqdEKwYnGQhyC/RdiVUcLUm
 8PsC09mhZF9t6i/7jNnU+Fvwyneq5J3GtYT3NhVLAmLTOyW6aD4tSgoRG2GgwWge
X-Received: by 2002:a05:6102:4b0d:b0:7a9:e680:efd5 with SMTP id
 ada2fe7eead31-7d0542ccbc4mr5265129137.28.1793727117932; 
 Tue, 03 Nov 2026 09:31:57 -0800 (PST)
Received: from jpg-duosnb ([2804:14c:490:135b:b225:aaff:fe93:9186])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-992ee509f58sm15124856241.12.2026.11.03.09.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 09:31:57 -0800 (PST)
Date: Tue, 3 Nov 2026 14:31:51 -0300
From: =?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>
To: Hiago De Franco <hfranco@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Marek Vasut <marex@nabladev.com>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Kongyang Liu <seashell11234455@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Bin Liu <b-liu@ti.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Andrei Lalaev <andrey.lalaev@gmail.com>, 
 Zhuxu Ran <zhuxu_ran@zohomail.com>, Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH 6/8] board: sophgo: milkv_duo: enable RTC power and reset
Message-ID: <auoV_97xdZB8MLlU@jpg-duosnb>
References: <20261021-milkv-duo-spl-v1-0-ee7618860237@baylibre.com>
 <20261021-milkv-duo-spl-v1-6-ee7618860237@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261021-milkv-duo-spl-v1-6-ee7618860237@baylibre.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 09:54:22AM -0300, Hiago De Franco wrote:
> Let the RTC power domain handle shutdown, warm reset, power-cycle and
> watchdog reset requests, and stop the board from powering back on by
> itself after a power off.
> 
> Without this, the reset and poweroff paths are left in their BootROM
> defaults, which do not match what the vendor FSBL configures.
> 
> Signed-off-by: Hiago De Franco <hfranco@baylibre.com>
> ---
>  board/sophgo/milkv_duo/spl.c | 53 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 52 insertions(+), 1 deletion(-)
> 
> diff --git a/board/sophgo/milkv_duo/spl.c b/board/sophgo/milkv_duo/spl.c
> index 8b2dc2756ae..97681e5a61b 100644
> --- a/board/sophgo/milkv_duo/spl.c
> +++ b/board/sophgo/milkv_duo/spl.c
> @@ -2,7 +2,7 @@
>  /*
>   * Copyright (c) 2026, Hiago De Franco <hfranco@baylibre.com>
>   *
> - * PLL setup based on the Sophgo FSBL (https://github.com/sophgo/fsbl),
> + * PLL and RTC setup based on the Sophgo FSBL (https://github.com/sophgo/fsbl),
>   * plat/cv180x/platform.c.
>   */
>  
> @@ -13,7 +13,9 @@
>  #include <hang.h>
>  #include <linux/bitops.h>
>  #include <linux/delay.h>
> +#include <linux/iopoll.h>
>  #include <linux/kernel.h>
> +#include <log.h>
>  #include <spl.h>
>  #include <spl_load.h>
>  
> @@ -52,6 +54,25 @@
>  #define CLK_DIV(div, src)		(((div) << 16) | ((src) << 8) | BIT(3) | BIT(0))
>  #define clkgen_reg(off)			((void __iomem *)(CLKGEN_BASE + (off)))
>  
> +#define RTC_BASE			0x05026000UL
> +#define RTC_EN_SHDN_REQ			0x0c0
> +#define RTC_EN_PWR_CYC_REQ		0x0c8
> +#define RTC_EN_WARM_RST_REQ		0x0cc
> +#define RTC_EN_PWR_VBAT_DET		0x0d0
> +#define  RTC_EN_PWR_VBAT_DET_PWR_UP	BIT(2)
> +#define RTC_EN_WDT_RST_REQ		0x0e0
> +#define RTC_CTRL_BASE			0x05025000UL
> +#define RTC_CTRL0_UNLOCKKEY		0x004
> +#define  RTC_CTRL0_UNLOCKKEY_VAL	0xab18
> +#define RTC_CTRL0			0x008
> +#define  RTC_CTRL0_WRITE_MASK		GENMASK(31, 16)
> +#define  RTC_CTRL0_HW_WDG_RST_EN	BIT(11)
> +#define RTC_POR_RST_CTRL		0x0ac
> +#define RTC_EN_REQ_TIMEOUT_US		100000
> +
> +#define rtc_reg(off)			((void __iomem *)(RTC_BASE + (off)))
> +#define rtc_ctrl_reg(off)		((void __iomem *)(RTC_CTRL_BASE + (off)))

Instead of hardcoding the bases here, could we get them from the DT? The
upstream cv18xx.dtsi already has the RTC node (rtc@5025000, with
"syscon" in its compatible), and its range covers both RTC_CTRL_BASE and
RTC_BASE. Also, use syscon/regmap in SPL (CONFIG_SPL_SYSCON and
CONFIG_SPL_REGMAP) to read/write the registers.

Just a suggestion though, I'll leave it to the maintainers to decide.
> +
>  struct cv18xx_clk_div {
>  	u16 off;
>  	u32 val;
> @@ -173,6 +194,35 @@ static void cv18xx_pll_init(void)
>  	writel(0, clkgen_reg(CLK_BYP_1));
>  }
>  
> +static void cv18xx_rtc_init(void)
> +{
> +	static const u16 en_reqs[] = {
> +		RTC_EN_SHDN_REQ, RTC_EN_WARM_RST_REQ,
> +		RTC_EN_PWR_CYC_REQ, RTC_EN_WDT_RST_REQ,
> +	};
> +	u32 val;
> +	int i;
> +
> +	/* Let the RTC domain handle power off, reset and watchdog requests */
> +	for (i = 0; i < ARRAY_SIZE(en_reqs); i++) {
> +		writel(1, rtc_reg(en_reqs[i]));
> +		if (readl_poll_timeout(rtc_reg(en_reqs[i]), val, val == 1,
> +				       RTC_EN_REQ_TIMEOUT_US))
> +			log_warning("RTC: failed to set register 0x%lx\n",
> +				    RTC_BASE + en_reqs[i]);
> +	}
> +
> +	writel(1, rtc_ctrl_reg(RTC_POR_RST_CTRL));
> +
> +	writel(RTC_CTRL0_UNLOCKKEY_VAL, rtc_ctrl_reg(RTC_CTRL0_UNLOCKKEY));
> +	/* BIT(6) is set as in the vendor FSBL */
> +	setbits_le32(rtc_ctrl_reg(RTC_CTRL0), RTC_CTRL0_WRITE_MASK |
> +		     RTC_CTRL0_HW_WDG_RST_EN | BIT(6));
> +
> +	/* Do not power up again after a power off */
> +	clrbits_le32(rtc_reg(RTC_EN_PWR_VBAT_DET), RTC_EN_PWR_VBAT_DET_PWR_UP);
> +}
> +
>  void board_init_f(ulong dummy)
>  {
>  	struct udevice *dev;
> @@ -190,6 +240,7 @@ void board_init_f(ulong dummy)
>  		panic("Failed to probe the CPU: %d\n", ret);
>  
>  	riscv_cpu_setup();
> +	cv18xx_rtc_init();
>  
>  	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
>  	if (ret)
> 
> -- 
> 2.53.0
>

Best regards,
João Paulo Gonçalves
