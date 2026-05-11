Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D85CD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 13:11:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D3E380398;
	Mon, 11 May 2026 15:11:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bnK343yn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D713280398; Mon, 11 May 2026 15:11:36 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C483800AE
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 15:11:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-bd2087858c4so16101266b.0
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 06:11:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778505094; cv=none;
 d=google.com; s=arc-20240605;
 b=GGUzjXD1l0T27lkwkGNVBMcCrpQJNi2q1HZQMMs963goLlOIUxn6E3t9RvzIHfsTyL
 qW5aLhAkjD7MK/h+O7TuxagGH8j+3x0WtT29TzkFAMVHd+ok8xgg5zRjNuT5VZNhZ20k
 z4kHYu+vL8fiX9MICK8Fv6ejMYDpE8FjkZiamV9oQTi/fJcfSnp5Q4xeuzh9pgsunpy8
 QT9Z99zb5c2DIfZo4AreEI+WIlTwYMij/j0xA3dnH8XAdRHNvLOW0aqXOypV2+Q1atPz
 eqGtUHl865Q+FnvL0iA7v4x9PEGSIpKzTdCQCib4r/wttbiHYss3+bZeQsyvY3TkGu2y
 7E0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=pmgiTsXZIdpnkqsD5y4GPgBzCB0XSOR8tDx8PzFLdtc=;
 fh=67RZ2VDMohRd4xCN7RZNy+ukoYEZv238NGbW23+wOvw=;
 b=amCjpxti1ycpej8Uspq8rTItcU898XBV6HNkNzvvDcvpmf60Le+sSa5mfOTr9pcsCv
 KHbEEtFwYISdwPXC4puT9lCSvumONfNtLy92hcPnO/6pq2rOzP0Vu0/fjP46/KImqvv4
 eFlt93+hxTNHQj1DUJYhNbCoDPiXdd9PFQf8yL+hln1ZwzJeScVIb5i0phVUwxAv2rM8
 xrB4SlBnngQKqM0zMS+BIEUxvjfLT1PmMnNrDs2u6lS9vrfqbLjHXGFm1Cqw02QWExrV
 DpJjqedy8ALAvUimRG6NWuTLWyPuh33QT0pkavi9F2SNLaY6o/xOWdw9IFQh/WutOog+
 RFCg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778505094; x=1779109894; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pmgiTsXZIdpnkqsD5y4GPgBzCB0XSOR8tDx8PzFLdtc=;
 b=bnK343yn/e+mCq3CRN+bwbx+jua15GSWfc9ZGo7nNULvBd/nFUWHO1w0YDbMZRqQ0q
 tFu/ahecKXAXK7iiiWA8mCqe10j8MKPz9RMbqKv9bTChsaxeWTNLI1gbDeM2YK8Jq2FT
 da0ZGdtmP6n1yOU3aClbqd+QXtKTzHB3cXiRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778505094; x=1779109894;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pmgiTsXZIdpnkqsD5y4GPgBzCB0XSOR8tDx8PzFLdtc=;
 b=MFOGhRiAzDf7Bk8z7Puo08hQx5h5YNRNXNzCMF4UF7wd91JFHPB0GPoOA589PFqQaz
 d8BxwLkQQiKGIiEyphks6wO2/CdlSONA+yoIm48wbf5YigcxeHGFfAr2zjHFS6oqUvOW
 Ww3E18Zd4p4bZW3ooIn17NUV8CR6Cffn76DO0F6+3muFvFeOYYB5lObAsOWCNx54P3q5
 GuldTLbt4INzXcPRja/DZPEOGO8H4zRhy4Viqb4+Sv1vBkMmrbXD6dd1bhVjky4EB6Ze
 FnQLJFL8oqbi/lM0uDgzA6h3Zp9CwAjfLdi409B3yAad464S1b0wh3boerttBPRnyAlJ
 Iuxg==
X-Gm-Message-State: AOJu0Ywg62UpBivFkpsgpA5lku48iUAP6ugdOtS0LrRvdQi3+Wjfm4fm
 /TsUWLZcK7ZWCPm3rUHQREE0Q2pKEmFzwdWSXHl4H04tx0BsNDdCMSj5QPAgHfcw1R5ccdugd6W
 sqtScXGB85o3UJImCNdgxdxoh86bcCQ/s8YxHf/tb
X-Gm-Gg: Acq92OGLcBvs0ACkYh9o1ok6eDT8Xjcyo4Bjm1sv7cvn/MMD1blW0QbYGq17I4WyCxA
 NcFZZ6MQHN1/Q4FNZ/NlWbRF9H0Ac21Kzb/ezBbrxMCDPVpAay5sAyY/P+Ph7I6CP97ukzCqEnT
 /Cg5r6aiG9zuZJXkGbXqj59JM8fIcZJxOAPbcwfM1QYGrw/dCmNhMtdURlfdpBth+VE9biP50eE
 O30hkv6/S2GrS7GiSGWse1b7xCbgreEj9lGTNhprrtSSOhf2g5p/6mXcHPT3c5+rSNySEMRxRmi
 tCfiXg==
X-Received: by 2002:a17:907:60d3:b0:bad:f032:fc78 with SMTP id
 a640c23a62f3a-bcaa9f60fbbmr727202566b.1.1778505094258; Mon, 11 May 2026
 06:11:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260510171723.56866-1-marek.vasut+renesas@mailbox.org>
 <20260510171723.56866-9-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260510171723.56866-9-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 May 2026 07:11:03 -0600
X-Gm-Features: AVHnY4JgQy_iofIvGdS81MhcwCrpyudV3szEv1Jhd-vUR9IYsFoHr444HoGfr_A
Message-ID: <CAFLszTiQMA-1e4Tcvxrpxr6=sV5ig5M5TOfrzL-NWEh-A0w00g@mail.gmail.com>
Subject: Re: [PATCH 09/11] video: stm32: Staticize and constify driver ops
To: marek.vasut+renesas@mailbox.org
Cc: u-boot@lists.denx.de, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Tom Rini <trini@konsulko.com>, uboot-stm32@st-md-mailman.stormreply.com
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

On 2026-05-10T17:16:56, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
> video: stm32: Staticize and constify driver ops
>
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
>
> drivers/video/stm32/stm32_dsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
