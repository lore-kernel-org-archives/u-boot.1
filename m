Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0307C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 20:03:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F88D84A4F;
	Thu,  2 Jul 2026 22:03:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LenZ627P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AC2F84A57; Thu,  2 Jul 2026 22:03:38 +0200 (CEST)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB81584857
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 22:03:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-8479f1a86ecso1561054b3a.1
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 13:03:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783022614; cv=none;
 d=google.com; s=arc-20260327;
 b=Yrj7d+nSt6bLjqIj96+lmHtHbu37MFy7wrn+3dZqxY1If6MvVXTLfRXha8DO6Oz7HL
 Tn6PZw6oQ0GQRwX584jP3cBeXcAl9FqLGh24YSFsLLADb/tQ+C2QptABudKcTlS7s/BD
 AfwOA6kcidKmnItaqRDhTXPe4EYhi02mSiV8ymAIKHoNmJdsQQ8dVYyFuqBajA+JVOcv
 Zl4p2ViMnDPZhcT8ztl11pxq3GI+H5r9+33WaQYPsm13rwKe2y6qAAPYLZ+gvLJlu5Vy
 LR+/rGQjxI5Ag8fMyUkF6mnxKhx6DPfO4gGDU5d/Rkm9VVx375tZBFj09DlR5gN8Bz37
 JQUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=len17yRenJaby3myfsHt0y1LnxMBrxOq582P4VJbB2g=;
 fh=Y2qJ7jgQP4S/n/2ubmk0pcfVUhrCG2JS/4j7Jrehd8g=;
 b=mBjIaO/gZK2E/JWsUJOWc2koDQjpbmLE4JSF+ybbmqUuNP/g6j0W5VlRfNokSthlO2
 C/kTxMqWfoLwkm8YP7EocLGLdmMDZbPDINZX2MzjL1GF4ekthQ0lq8h163TJLxMHN3Uu
 EsrYJDIYw4M25aJCYSiUYBb/2d2Tc+v3+ly6pM7Z1dwE7dXM9a2dP7v0zHREBtM6nEuS
 4YrUs6AM2qpQFE4YJVx5Vc78kS/ci5PZ20bOZPeqglvnkE+RKwM4zEjtiyIzvNCpqGXL
 KPz6hE4NC31Uyqv6ooDp4+hTUqSfu/Oug+27YEAKtFKJRP/SEC7D3/0yfvSObynKmN1E
 MWfw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783022614; x=1783627414; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=len17yRenJaby3myfsHt0y1LnxMBrxOq582P4VJbB2g=;
 b=LenZ627Pdowl2vK/3RwTdxTQTwgV+Y8HtKP8+8ghFaZ3yw9GXi7+gpEQ6lPGojnGE7
 S6Xqvemt4ck6GSia8bcT8z89MrJyVOBlY8K+DPaGDRyNf1ielZUEPPhxGjP/WFm+3UDQ
 nVwU9ENF36iP8S2FzNr6rSUkaKP2ok2S+M5eM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783022614; x=1783627414;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=len17yRenJaby3myfsHt0y1LnxMBrxOq582P4VJbB2g=;
 b=K0xsZsNxyj1oGK8TCaYp+ZS9sr/ve4KemZJaguoCKb25bNjqF49zs8sRpeBGsp6Xr6
 fQrpN9eIarXFnH1cmWP/Iw6yQbavXlDfTLCqjUgNpCHD/6oYm/B1p0l3ptdmaBTEWUd5
 ZkxvtQ12AVUD50ERWuYS98ZE/N2QeF8PdxuAPmhgbDX05KD9jRJz+dJFpcmWxBjJY9ls
 Ng35clzMCJrKThqeGuwR0aqqa7Do1kWfFjyKlrYEtRg9Ga7fWyhlZBuPwEdEe9JNPVWm
 8fuVwLMordp2XcQkJi/hBlj5wQ6xA6fKGMOA2eyZG3g8WHpb4gDw16bBUpJfqOVZMrVq
 gcdQ==
X-Gm-Message-State: AOJu0YyPX3bvfiGPaAsRt2H2Tw0Vy9qANaz3v95oMnLrEjT2TgXrYA1a
 CvBQnvvg+y/edIE8+tPsmfPuQc3V67D2Lit9lIL5zmBZEfcJSG8S68DDF1Nwm/J9sY5gqOLloRN
 Nc7XublGDNl6KMX7Rz8d+1aprRfklqy4IdRpJoctB
X-Gm-Gg: AfdE7cm02KhEnXlkjDxTUmcaAVCTdSjbO1xQn5dJuLu1GWfBuD0YwCHsQiMofh6/TXV
 oaSzjwhXNQC2SWZpM+ZicBjMQtp4/uP+YZ94PI2aETWr6qT/RYL28feoRdKhonktqm44RHbFWIX
 hkWUHwf6vG6QK2LcriXR2uGg+jE4dh8GIDjcBoFCdBxLQ/e9vN1Etv4DU0QoCPErZoEf3aXEFRK
 USEzmzhBGTP/OBqnNDGFi5WdVX/BDqX+K9dAeSHkHVzPRtgHE2tK90rD8hQgm70q4nrlrnAqQ==
X-Received: by 2002:a05:6a00:4f86:b0:845:d285:3b6c with SMTP id
 d2e1a72fcca58-847c51f186dmr6446197b3a.56.1783022613871; Thu, 02 Jul 2026
 13:03:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260702014724.1534351-1-james.hilliard1@gmail.com>
 <20260702014724.1534351-5-james.hilliard1@gmail.com>
In-Reply-To: <20260702014724.1534351-5-james.hilliard1@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 21:03:05 +0100
X-Gm-Features: AVVi8CfhN1A9mYHRICD-_tI8aImrJ3EVZ4SXFR17IgZczdTo0aErAVejJZBLjZ0
Message-ID: <CAFLszTjSDDtcNir9XL_=5kUtZ-4LLBR9AyFo4wY=wBv8xadHQA@mail.gmail.com>
Subject: Re: [PATCH 5/9] clk: sunxi: add H6/H616 CE gates and reset
To: james.hilliard1@gmail.com
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Lukasz Majewski <lukma@denx.de>, 
 Tom Rini <trini@konsulko.com>, Richard Genoud <richard.genoud@bootlin.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>
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

On 2026-07-02T01:46:51, James Hilliard <james.hilliard1@gmail.com> wrote:
> clk: sunxi: add H6/H616 CE gates and reset
>
> The H6 and H616 devicetrees describe the Crypto Engine with module, bus
> and MBUS clocks plus a bus reset. Add the corresponding gate and reset
> entries so drivers can enable the CE through the normal clock and reset
> uclasses in U-Boot proper.
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>
> drivers/clk/sunxi/clk_h6.c   | 5 +++++
>  drivers/clk/sunxi/clk_h616.c | 5 +++++
>  2 files changed, 10 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
