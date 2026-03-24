Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26092E9A775
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 11:40:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7088D838FA;
	Tue, 24 Mar 2026 12:40:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qzbZqPW7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91FDC83952; Tue, 24 Mar 2026 12:40:45 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A01A0838BB
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 12:40:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-486ff3a0fc1so32633245e9.2
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 04:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774352442; x=1774957242; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ndr81qWrh1fbHF13yyK1nq93jUzU2WWIcf+1FEmV7LA=;
 b=qzbZqPW7pcQF+Ec0YuB+RVYRayFzEPjvw81Gv9f3A0yc3p1Esp6DEmqqCMl7/dhFyk
 /1Jx7VaYB9xnMrkK3iNvK5RvlJ9IPk4fceUu4nGD6dug4XgIw0jPHy0R/EVUzstlkaUG
 OpehAtsjwEpiLorhTq92UJDg5Lvdt+f36Zy61uHBzLyZjTjmnKvmMrD4iw9c7rmO4rfa
 vSu5biTpYZ6VSTri4y88PrAvY0+HO1GsmuYeHSHG5U2z8xYVbDyf4yOUZXXaR2Sh0AEt
 YOtDz+t5Gc1oC3sBewdzDI+4IUe5epWGFik5appv2loDgJEjgId/73xnZ10B6kTQRTMF
 4Eaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774352442; x=1774957242;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ndr81qWrh1fbHF13yyK1nq93jUzU2WWIcf+1FEmV7LA=;
 b=P69Y+3XkCD+4VQ4dUGCNqzo1sxhxafEWyLbJPB1XbwtufHb6W0yEYt/xOiCVbrMVoh
 2wsrE7E2s0P/y6neA8BRzMmHgVHisv4yRwU0gB+kGyBoxR/h5V3QWPOhM2ouQf6XxSdp
 M1uormRu/Q2slQKFtVZB8/eodjy11sHGi9IC9w5tyLum0QDdFwl3s0F2KbbvE4MhRZrq
 /vrXLcicCpk2E6/gBUboNox8OUGeLWQRz0aLe+OR5oT6LdLQoOTYY96rOgGtpqUKW+If
 sv8htu+9AbsEdnIZDHLPslXAbwZikKxZSDDiQS9WC/fib5te7hLLFom8fZrbdCkFXs6o
 Ch1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9XvRDP6bpW0n17Wm7EZXVNKpbND/7omGHW19ccOcBYHqJtCboK/39LDzYcEQUW/n5XDAsEp8=@lists.denx.de
X-Gm-Message-State: AOJu0YzQSr1qRL+XjNgo/sXuAOfZ7Fc8yYSBtaP4GOKHeq8Y3yMHd00c
 Ua5dyeiDPq9sH0XLqSExEJ4FVleM+MW+xEzzoD8uyoOHYvtLutBKXxVPxWHOeB5GPv0=
X-Gm-Gg: ATEYQzwX6JplvFMW9byiOz9XxYIgSd0QXK6VQ91/bWFqEOe5Q5eesW1GNTKPnkhf0hg
 ZuMc/xpW8iw8xt4TskVDWNrhZsDtgX1ACkPLc0qGVpGeTY4hT2i3efRgDFawxsIsdzAKWNd6kyw
 fSwc03zelEdl64jZMKdq5J4AZYSZFSQX8RYytJMd7GhPgpbArqp0G7wJ4GjMin9QQQv0qHeQQLX
 6VJM0mFWZOh5iJj1ArtkdeHjjsfoGZ44jQ02Qmn5Ul5wJRfzyyycq1HPHqTS5UWmGnp+bbJWCeC
 irJMPE/SH1MlASW+rwVU6UgZ8ViLYnqEXvkwcCEQ5u6QCPDkdWJXTxNZTmQv5Tb4HR/9yX1b5Ec
 Mk7X9UDC68wZiOKrn5aLbxWMFs2UsA0a0JEXkxi159H8fD325IJlOvsMgbiAKrQ0flipeHR8S6C
 2/AMcNJH+23brBpmq+DdApa2gv25yH
X-Received: by 2002:a05:600c:46ce:b0:485:2f4a:6ae6 with SMTP id
 5b1f17b1804b1-486febb56demr206987245e9.6.1774352441962; 
 Tue, 24 Mar 2026 04:40:41 -0700 (PDT)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48711701804sm47542065e9.4.2026.03.24.04.40.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 04:40:41 -0700 (PDT)
Date: Tue, 24 Mar 2026 14:40:38 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Peng Fan <peng.fan@oss.nxp.com>, Tom Rini <trini@konsulko.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Greg Malysa <malysagreg@gmail.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Eoin Dickson <eoin.dickson@microchip.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 u-boot@lists.denx.de, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 arm-scmi@vger.kernel.org, linux-gpio@vger.kernel.org,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Khaled Ali Ahmed <Khaled.AliAhmed@arm.com>,
 Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH v2 4/4] gpio: scmi: Add gpio_scmi driver
Message-ID: <acJ4NiwCRchgq7-t@stanley.mountain>
References: <cover.1773256350.git.dan.carpenter@linaro.org>
 <f8e1dcb617917dfe69efce0b3407f8786e4c971d.1773256350.git.dan.carpenter@linaro.org>
 <acC2fSdjDmj5Wp1a@nxa18884-linux.ap.freescale.net>
 <acDzsKoMdfcXecca@ashevche-desk.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acDzsKoMdfcXecca@ashevche-desk.local>
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

On Mon, Mar 23, 2026 at 10:02:56AM +0200, Andy Shevchenko wrote:
> On Mon, Mar 23, 2026 at 11:41:49AM +0800, Peng Fan wrote:
> 
> [....]
> 
> > >+	ret = snprintf(NULL, 0, "gpio_scmi%d_", bank_cnt);
> > >+	uc_priv->bank_name = devm_kzalloc(dev, ret + 1, GFP_KERNEL);
> > >+	if (!uc_priv->bank_name)
> > >+		return -ENOMEM;
> > >+	snprintf(uc_priv->bank_name, ret + 1, "gpio_scmi%d_", bank_cnt);
> > 
> > build fail in CI [1]:
> 
> Moreover, this is reinvention of devm_kasprintf() to begin with.
> 

devm_kasprintf() isn't an option in u-boot.

regards,
dan carpenter

