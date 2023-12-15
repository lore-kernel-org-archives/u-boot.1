Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD95C4167B
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 20:56:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA51087C7B;
	Fri, 15 Dec 2023 21:56:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cNjHb0QR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C793B87BDE; Fri, 15 Dec 2023 21:56:30 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6ACF787C78
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 21:56:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-77f552d4179so70058685a.1
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 12:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702673785; x=1703278585; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iEkZdkMinB+4Gnj0Q+hMa8oc+JfmWmux9XvVTku8Mzg=;
 b=cNjHb0QR1SOnK6OQfdbQPdkagFsu2EQowGIoE5Q/naw5bIrGwW3mGJ0hoI4jyKpPK/
 1ffPt5sqhjJxXCopdFjiYiwpZhMJKH5xkND2CAjrXki91uc8wZVG38UhbsC5XLT8C/vh
 czuoPhUtabUKokFdblbOuYYKtdILymDVyw+UEZDPNHfyUyXnY1/Kw9Lbqgzt0/qqSNtD
 6TiHfDKNYxUWBL4SYzPxiLimQuPZgdFDBwA3VYDxShtbstcavhJBF1Foh9mY2gyVGfSq
 IjTR2a1GBK9QFLTPHSuzZWwaGQP8keLFdiO4YjNu27bl2mrWNI01suJHRMS7jnb2+yow
 hDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702673785; x=1703278585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iEkZdkMinB+4Gnj0Q+hMa8oc+JfmWmux9XvVTku8Mzg=;
 b=XqqRQJ0t3KeZ0eRnDctX34kaZGC6Yjivntf8U1KN2WQ+Fif9juIgq+R390gUjUPdYt
 sC8N2ozSDxyTbIrXjywDTKITUCSbVeSeexKIBgfDKNJdNLM675UGdoyNe4cyCB1dql9e
 L0Q3YmWTS7sM0n+IeWEO3Mjnqw7WwXWOXvHiKSJi4xSPP1v2eE0z7VXIL0lBJ1gdMB3d
 ZRFYWYpBP9eVDlQwl1W4xi0x6LaJ/Gxq7m+1QRdZEeYdybsxhwzGMIeIK8RtYEhpozth
 BG3YlJ6e4W4SABaKmPhWveXr0vJFgAGyXDgOYSjKwcO5r58+5Ii8j7zvIApH2l7nS16w
 2iEw==
X-Gm-Message-State: AOJu0YxLMqB6C3JA6kZYH4bT3t0TvSU49/dyRZb3WhmJyMwK2madiiOr
 Wf4GneiU49gzK+mkRP8qpj4=
X-Google-Smtp-Source: AGHT+IEdcJ82tWEe9/4LTIvoOOI89INK8VsETQ2Dl3ibZED13LiNX2D+euo1dJAs+62uAWAQwqwpfw==
X-Received: by 2002:a05:620a:100a:b0:77f:2978:53e5 with SMTP id
 z10-20020a05620a100a00b0077f297853e5mr13919104qkj.114.1702673785258; 
 Fri, 15 Dec 2023 12:56:25 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 qp27-20020a05620a389b00b0077dc7cb232asm6190831qkn.103.2023.12.15.12.56.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Dec 2023 12:56:24 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: forbidden405@outlook.com, Lukasz Majewski <lukma@denx.de>, sjg@chromium.org
Cc: Sean Anderson <seanga2@gmail.com>,
	u-boot@lists.denx.de
Subject: Re: (subset) [PATCH v3 2/2] test: dm: clk_ccf: test ccf_clk_ops
Date: Fri, 15 Dec 2023 15:56:21 -0500
Message-Id: <170267377371.2422101.17831050827549880987.b4-ty@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231111-enable_count-v3-2-08a821892fa9@outlook.com>
References: <20231111-enable_count-v3-0-08a821892fa9@outlook.com>
 <20231111-enable_count-v3-2-08a821892fa9@outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Sat, 16 Dec 2023 02:28:52 +0800, Yang Xiwen wrote:
> Assign ccf_clk_ops to .ops of clk_ccf driver so that it can act as an
> clk provider. Also add "#clock-cells=<1>" to its device tree node.
> 
> Add "i2c_root" to clk_test in the device tree and driver for testing.
> 
> Get "i2c_root" clock in CCF unit tests and add tests for it.
> 
> [...]

Applied, thanks!

[2/2] test: dm: clk_ccf: test ccf_clk_ops
      https://source.denx.de/u-boot/custodians/u-boot-clk/-/commit/d30618243990

Best regards,
-- 
Sean Anderson <seanga2@gmail.com>
