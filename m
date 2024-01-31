Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ADADC47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 15:38:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D95378745E;
	Wed, 31 Jan 2024 16:38:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Pdb+HTC0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2378E87964; Wed, 31 Jan 2024 16:38:23 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36E128745E
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 16:38:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40fb63c40c0so4269445e9.2
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 07:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706715500; x=1707320300; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4mJxMKgUDTI0iKHmeOvXtEfmRzesVmscOJGI+FdKxyw=;
 b=Pdb+HTC0xmrrzbHlZqLvgtKk6a3YtRQh+/L1Ya/GskqcqZoiPfz7kSd4Kl49pQfYH4
 ZueifMzZZNuTBdnO9f7LzPPZ5Z+YqGOQnwl1hEYUxWuIRSyUYML5V6qQH2lnZI7c/exU
 +OHWJDXdABAsRDxZGrX5WVseq6gmgX0aqQmXxzrUwo7jQb49ZdCENF8gbdtKN8YbaUDR
 wchIWByBGz+ZxyHypJGmYpsdrbaJ3ZMKIjxf72BeBggDiirabrHxgiNYR+4iouJnH0wQ
 vOGBNov4t6y68Cfq/gkpdG6elXHzmUbd06meY1WsS6clfkvP9RJniHsjHX6Iu5sHYGMp
 aDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706715500; x=1707320300;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4mJxMKgUDTI0iKHmeOvXtEfmRzesVmscOJGI+FdKxyw=;
 b=qz314hDzCvOnRhozkk4eT4ujxpO51C52bXpWhLS3s6nRtLYrtifBvWYQUhO3vC7CR5
 uKBWU00ia1qanLQxnTAYKMAE8izTzJU5D3mej1RLeGn3e2WW2mknkAExDecjFWcP9jVw
 7kteVQ7mfNgFrg/VDZxbzbu2V/beCzeEZmLor90aJNkMsFJf8XJ/trQQCaEtiX0GeUPf
 sMAnBn+BoxV7O3dcCOhjuHsePPu3Xe0tBtNERWNxbzb5hz3XMPoAtur8vFtQ9noKz8fE
 AVgh1WGXEi5n84MDDc6wx50IAUfwiMPiKFB5J1qrT6gETUOFOSGWJymFtyo4mIKOYNPC
 dkCA==
X-Gm-Message-State: AOJu0YxFUH5a84IGT7eHeahhelnpRo4ZottYTXGjnkRuANQkB8xiRhh6
 n/QfdHfp5fXGZrYAw0/SBDPKX+kqM2VV84v9UB2L4S5vd5bzHS33NN1880M2ZpU=
X-Google-Smtp-Source: AGHT+IHJ+YY6J1j112LX7xely0ldx6kEU+3L+QhP9XwWJ5X98o/Bg5xZ5kXQtZ+IIYiZsImy0irdLw==
X-Received: by 2002:a05:600c:c7:b0:40f:5f76:1b21 with SMTP id
 u7-20020a05600c00c700b0040f5f761b21mr1689639wmm.39.1706715500619; 
 Wed, 31 Jan 2024 07:38:20 -0800 (PST)
Received: from localhost ([102.140.226.10]) by smtp.gmail.com with ESMTPSA id
 j13-20020a05600c190d00b0040e88d1422esm1956366wmq.31.2024.01.31.07.38.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 07:38:20 -0800 (PST)
Date: Wed, 31 Jan 2024 18:38:17 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 06/13] clk/qcom: sdm845: add USB clocks
Message-ID: <a305146c-3921-4ff3-a687-cd6a63d0b8aa@moroto.mountain>
References: <20240131-b4-qcom-livetree-v1-0-4071c0787db0@linaro.org>
 <20240131-b4-qcom-livetree-v1-6-4071c0787db0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131-b4-qcom-livetree-v1-6-4071c0787db0@linaro.org>
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

On Wed, Jan 31, 2024 at 03:16:58PM +0000, Caleb Connolly wrote:
> @@ -121,6 +130,26 @@ static int sdm845_clk_enable(struct clk *clk)
>  
>  	debug("%s: clk %s\n", __func__, sdm845_clks[clk->id].name);
>  
> +	switch (clk->id) {
> +	case GCC_USB30_PRIM_MASTER_CLK:
> +		gdsc_enable(priv->base + USB30_PRIM_GDSCR);
> +		qcom_gate_clk_en(priv, GCC_USB_PHY_CFG_AHB2PHY_CLK);
> +		/* These numbers are just pulled from the frequency tables in the Linux driver */
> +		clk_rcg_set_rate_mnd(priv->base, USB30_PRIM_MASTER_CLK_CMD_RCGR,
> +				     (4.5 * 2) - 1, 0, 0, 1 << 8, 8);
> +		clk_rcg_set_rate_mnd(priv->base, USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR,
> +				     1, 0, 0, 0, 8);
> +		clk_rcg_set_rate_mnd(priv->base, USB3_PRIM_PHY_AUX_CMD_RCGR,
> +				     1, 0, 0, 0, 8);
> +	case GCC_USB30_SEC_MASTER_CLK:

Is this supposed to break?  Otherwise can we add a "fallthrough;"
annotation?

> +		gdsc_enable(priv->base + USB30_SEC_GDSCR);
> +		qcom_gate_clk_en(priv, GCC_USB3_SEC_PHY_AUX_CLK);
> +
> +		qcom_gate_clk_en(priv, GCC_USB3_SEC_CLKREF_CLK);
> +		qcom_gate_clk_en(priv, GCC_USB3_SEC_PHY_COM_AUX_CLK);
> +		break;
> +	}

regards,
dan carpenter

