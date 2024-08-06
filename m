Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC30C52D6F
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 21:51:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B255D88A96;
	Tue,  6 Aug 2024 23:50:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MztpEz4R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71DB9881C1; Tue,  6 Aug 2024 23:50:59 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6028088AE1
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 23:50:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6b5dfcfb165so5875786d6.0
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 14:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722981048; x=1723585848; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yGp2AMdl2nfV+59/mct2siOhp6zgxU/nDV2qSQyirVA=;
 b=MztpEz4RCxllFVPGvh4MMshgIMRfeAAO/embCfwKZ7DUbo/YZcadgPI/NB0xMKzPus
 zCeifZ0uRwP2//N9kR3Vl0k6LKq6eHY74KlV1HRlVnsXg5K8irfoz68KfZYPI7KM36Hz
 El7/GWaGIiB8+tNugyAuG2BnTYC0cc86pYDEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722981048; x=1723585848;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yGp2AMdl2nfV+59/mct2siOhp6zgxU/nDV2qSQyirVA=;
 b=ZLEU1++0aCmcm3xmeS5JXY8lsqJ78CZLyGoAKzVVSDrLEuh62XNVnXJn1fu1asObUl
 Lz+HTT/6M05wnQ7LmENhtlOjbybAV4DFdXLJbYT6Yqx4yHH1sjp8bTLMt1SMeD+Uhb0R
 AUj746+SCjXaO6Csi1UvKuFhV1L3JPhhCFUwbdR2IBAiCsmwQQ9IX4YQlW7l51zwhuxX
 kl7XUzfVkykP0d4WckkfaluGD+Qyi+E18CkrM0s9G+ALuCu7+tQACad6qQOu58bLeXTj
 Tp34LOr95caW+zuhtTHeWE13wZbC/q+lrOJqltP/+pZNauw509uh/eckqdK+E+pRizjk
 024g==
X-Gm-Message-State: AOJu0YxAmj1nDGvwgVf6/vj7JueOdw4EOZ/ed3i0HYBUc2RzyAryv921
 SyVai1oYbzM/DGorMX8XaXa/TYyKnp53PAb/WxFAKg/yQE7yIuvgnu6Tp741/MFzSR97Wzs8atX
 2C3uHux5H48/HfWEGK+NVsUEaYC2oWVqlweUQ
X-Google-Smtp-Source: AGHT+IFurs9sPU2HqQ4yOqk2LlzYYLVBiClXy3EDA/p5XIElF9fwyGxwDR/yPvKtMd3yFj7GxB3R/ybbLYdhsoc86C4=
X-Received: by 2002:a05:6214:498a:b0:6b2:b11b:c326 with SMTP id
 6a1803df08f44-6bb984b06bbmr223999696d6.48.1722981048597; Tue, 06 Aug 2024
 14:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240802092539.162892-1-pro@denx.de>
 <20240802092539.162892-2-pro@denx.de>
In-Reply-To: <20240802092539.162892-2-pro@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 6 Aug 2024 15:50:37 -0600
Message-ID: <CAFLszTix_tPc583JY4JQVimoCQdBNd-FmTG0Qdvs7OH71DL03g@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] x86: provide mb() macro
To: Philip Oberfichtner <pro@denx.de>
Cc: u-boot@lists.denx.de, bmeng.cn@gmail.com, caleb.connolly@linaro.org, 
 christophe.roullier@foss.st.com, epsi@gmx.de, eugen.hristev@collabora.com, 
 festevam@gmail.com, forbidden405@outlook.com, ivprusov@salutedevices.com, 
 joe.hershberger@ni.com, jonas@kwiboo.se, kever.yang@rock-chips.com, 
 leyfoon.tan@starfivetech.com, marek.vasut+renesas@mailbox.org, 
 marjolaine.amate@odyssee-systemes.fr, neil.armstrong@linaro.org, 
 n-francis@ti.com, patrice.chotard@foss.st.com, patrick.delaunay@foss.st.com, 
 philipp.tomsich@vrull.eu, rfried.dev@gmail.com, seanga2@gmail.com, 
 sebastian.reichel@collabora.com, sebastien.szymanski@armadeus.com, 
 sumit.garg@linaro.org, trini@konsulko.com, xypron.glpk@gmx.de, marex@denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 2 Aug 2024 at 03:25, Philip Oberfichtner <pro@denx.de> wrote:
>
> Implement a x86 memory barrier mb(). Furthermore, remove the previously
> used mfence() function, which does the same thing.
>
> The mb() macro is now equivalent to Linux (v6.9):
> linux/arch/x86/include/asm/barrier.h
>
> Signed-off-by: Philip Oberfichtner <pro@denx.de>
> ---
>
> Notes:
>     Changes in V4: None
>
>     Changes in V3:
>         - Remove mfence() function
>
>  arch/x86/cpu/mp_init.c     | 10 +++++-----
>  arch/x86/include/asm/cpu.h |  5 -----
>  arch/x86/include/asm/io.h  |  1 +
>  3 files changed, 6 insertions(+), 10 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
