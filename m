Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6960DC3DA4A
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 00:30:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B18A88D5E;
	Tue, 20 Aug 2024 02:29:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="o4fCVKDG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2A2B88D42; Tue, 20 Aug 2024 02:29:47 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C525488D3C
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 02:29:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5d5c7f23f22so3067839eaf.0
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 17:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724113784; x=1724718584; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=okdkoJEQgWl6YsjS7cUC6Ok2wpWPzff5ZQjMN52jexQ=;
 b=o4fCVKDGWUMSFQvIXrw2SUtixsi92EqObEXMxXdM+w38LQ016w6Z1aTD2dqkdZgEO5
 nyIloAPo4cRSfBQKqD9vrptdZnXAV8JAjeGKldLWPsxyiEeP4h1m6FYDj5Nn0kyU7fO/
 reQKWzIEjL6DDIZAp00/xFUAiT0n74h7ghikg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724113784; x=1724718584;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=okdkoJEQgWl6YsjS7cUC6Ok2wpWPzff5ZQjMN52jexQ=;
 b=nGwQEv3kE+U9Umuz0+NS4pDDf5QGhr0fguu01kcFCMHXCRY/oE+MLCLVNY8UaJocy0
 lXYSJfuwMC98HN45yLm3GpWo8O61CkxjoGHjsWvPhCv8FwcGgAvHEaM5Y4t3/Tv0OBUG
 vGKkXrXO/yl12VBWVOHBYWGMAmwXs6XC5aVMVtfuhdlUbwccbiI0rJwqfCsNCfT7Blrk
 0eube/l8NC+mPP25a1HuZUV1wUWuJ6LLSQOJuBPOFg3WZo3lrqtuaSbjCVfJ1049wMtk
 kmh7ZtmajYntqN+N4YHm/6Z/CewS+KRXnFGi4bqIB3PfD2heH7y5NnSVADQ/+CgyX41P
 bEZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWm/NF4qhw3zoDq5GlZl4xmWO4kEGhgxBIRa9dXf+9uyL672oZikcd4O/ZpW0+MA7fokhKNK9Q=@lists.denx.de
X-Gm-Message-State: AOJu0YycgAhj/ggQhAaFJzlsnxpKREBEAWZX5iCvJG2FLgIljnjlTxgu
 HuIVygzxsZAtsC2h4ynwHSTs47JYPEIzTrMAUJin+kf7MvgmGQgICRes6kJS6Lc=
X-Google-Smtp-Source: AGHT+IGrJTHdF5SnnScL1CIY5jfDQn8nX2A453sHb9SrvS45rh/aF+ii6Jhg4S2nRkDk9HB97tFYxw==
X-Received: by 2002:a05:6870:e313:b0:260:e453:5368 with SMTP id
 586e51a60fabf-2701c5f3d12mr15378217fac.46.1724113784362; 
 Mon, 19 Aug 2024 17:29:44 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-270046a6208sm3319572fac.27.2024.08.19.17.29.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 17:29:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Frank Wunderlich <frank-w@public-files.de>, 
 Dong Huang <dong.huang@mediatek.com>, u-boot@lists.denx.de, 
 Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20240803083305.30697-1-ansuelsmth@gmail.com>
References: <20240803083305.30697-1-ansuelsmth@gmail.com>
Subject: Re: [PATCH 00/13] clk: mediatek: mt7988: clk migration for OF_UPSTREAM
Message-Id: <172411378330.165406.6745514549440092348.b4-ty@konsulko.com>
Date: Mon, 19 Aug 2024 18:29:43 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Sat, 03 Aug 2024 10:32:49 +0200, Christian Marangi wrote:

> These are all the required patches to migrate clk and correctly support
> OF_UPSTREAM. This will align the clk index to upstream to support the same
> clk implementation with downstream and upstream DTS.
> 
> Christian Marangi (13):
>   clk: mediatek: mt7988: rename CB_CKSQ_40M to TOP_XTAL
>   clk: mediatek: mt7988: rename TOP_DA_SELM_XTAL_SEL to TOP_DA_SEL
>   clk: mediatek: mt7988: rename TOP_CK_NPU_SEL_CM_TOPS_SEL to
>     TOP_NPU_SEL
>   clk: mediatek: mt7988: move INFRA_PCIE_PERI_26M_CK_Px clock at top
>   clk: mediatek: mt7988: fix wrong parent for INFRA_PCIE_PERI_26M_CK_P2
>   clk: mediatek: mt7988: drop 1/1 infracfg spurious factor
>   clk: mediatek: mt7988: rename TOPCKGEN factor clock to upstream naming
>   clk: mediatek: mt7988: reorder TOPCKGEN factor ID
>   clk: mediatek: mt7988: drop 1/1 spurious factor for topckgen
>   clk: mediatek: mt7988: comment out infracfg clk not defined
>   clk: mediatek: mt7988: replace clock ID with upstream linux
>   clk: mediatek: mt7988: convert to unified infracfg gates + muxes
>   clk: mediatek: mt7988: rename CK to CLK
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


