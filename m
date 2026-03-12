Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA37FED2DE
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 07:32:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21E5D83F8A;
	Thu, 12 Mar 2026 08:32:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="B4WFVoPA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D04F183F9A; Thu, 12 Mar 2026 08:32:34 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A94DD83F6D
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 08:32:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-439b9cf8cb5so775684f8f.0
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 00:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773300751; x=1773905551; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QiXMM5jF1nGW1k5BoCG1A7OXeQgJqBMtsH8RcIzP0SE=;
 b=B4WFVoPAGH3k4Q3Awo8GOCfMujILEr1jEBiW+7Q8rxVrSRuiLUrjP2pWjHPUmjsmDJ
 BqX7jfT2PSTNxdBR6x4kKdz06B2CCFP8wubVoncACNKuXe0WcVNp4aLt4eE6SyoxP2UR
 rIQPWCilXLB38eNPBQe6ttma0lox6j+miU7pdC7/5TGD9cuoGbC+1WTTDCWDaJrjplfb
 fV+Euq+5Pw/vUxpe8selG6qI+yHivWLdSmfGIU3l8jTSjVLdh4Iv5Tp5KOAirmtqGFSm
 XwjrIPqDIz32agWK8jqe30TuW+woauteADb5lXkNU7LX9K+EEJOJWVl5UPu9Vikyw42Y
 +XLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773300751; x=1773905551;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QiXMM5jF1nGW1k5BoCG1A7OXeQgJqBMtsH8RcIzP0SE=;
 b=MgPv105SS23Qv5sqmhUK9trdqsfhloUKWS9URRFtfV0hUxyrapQ0yCFeW6NC+G92v5
 O1we6aNFRuU9BDyaU5BhRT0iq8SJZiFgXqbAGpKC6FasHRjtDlj73zNaBs3c6Cny05zS
 zj3druR4iJ6UOA1n8YSQD6UqsR5wJ4HtNnlxlG7dFG8h6mgaBVqIWLhbq8ELQYzCAi+l
 aiDmkwkonO0rxGLxnk/Sbj7WsGPBcFGLnH1RffRJvrcGXfkFHgRGP45a++rdyC3LXP2H
 sWGyFTb928VgW/BBfGkMs/Q3VXL0hkHSGredxYqkawCKMbJDtxfl/M9yROv1mslcEOFZ
 Z6lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUXKNqqnNiv+KFqy/jI0yt+TSaTdgJzX1arz5z/lKV/oGt8uC1YZmsHM4h9jBLOhk21o6fcrs=@lists.denx.de
X-Gm-Message-State: AOJu0YwPRe9AcA4MZb5d2rCB+t0ad/xKVI1UuX/RkhBlSqiEBdd1ZsFf
 jPWIYkUSRlBwqDdssmfynqFiYqIAM2sGvuzphTRED7RMfNmTHaK8CRcDAylUTH3+tHs=
X-Gm-Gg: ATEYQzxh1oWSap0aXelpfRtbdMyVzBFhf1v9LD1yELdZeQmQeZ+2TXMRSsYgqJpclsT
 OekMECO/ZxHM2+ZWourY3m12nFLFT18iTOLR+wMipJY3Ux4kw75tkdkdBRerGxGYgHfqcTJQg3l
 LFLQ3F7nEmnELxBisFOuki8tdqyLQc1s4X7ONqJitXkDHrN/6zCTtOihnyxCPbWrHIocz0132YS
 0aCUtV/PmFCM4guMo0UA4cupBuc04KjlcQnio93pgAJQ4w42IIgded5adnAFbx2b+xoY/5mZHp2
 j1bYa/hBPtghFKmVURO30jJ9xzzfMB7Le69pXUhlBnQo2G/MPCU8ksPEV5Kwyg1UpAyS9XYl17S
 1cwNqlGfJ2dnYZAXu86Fikh48PAy5dJrELOw2zlvSW/v0BfV/nTbN3kHHg/WCN6AHMCpET1pFLT
 yuXTxApc9DzxTj0iw1e4bicEusG/Im
X-Received: by 2002:a05:6000:230e:b0:439:cd10:aaf1 with SMTP id
 ffacd0b85a97d-439f8225346mr10304360f8f.53.1773300750991; 
 Thu, 12 Mar 2026 00:32:30 -0700 (PDT)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe22dd67sm6521914f8f.36.2026.03.12.00.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 00:32:30 -0700 (PDT)
Date: Thu, 12 Mar 2026 10:32:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Michal Simek <michal.simek@amd.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Ian Roberts <ian.roberts@timesys.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Philip Molloy <philip.molloy@analog.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Eoin Dickson <eoin.dickson@microchip.com>, u-boot@lists.denx.de,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Khaled Ali Ahmed <Khaled.AliAhmed@arm.com>,
 arm-scmi@vger.kernel.org, Linus Walleij <linusw@kernel.org>
Subject: Re: [PATCH 4/4] gpio: scmi: Add gpio_scmi driver
Message-ID: <abJsCq0eqL_6NUFC@stanley.mountain>
References: <cover.1771856828.git.dan.carpenter@linaro.org>
 <e3649db2cbde07a53c7139d72c2c597f9a6d8fbd.1771856828.git.dan.carpenter@linaro.org>
 <4fdab7f4-aa11-4abe-953e-6d9785945fbd@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fdab7f4-aa11-4abe-953e-6d9785945fbd@amd.com>
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

On Tue, Feb 24, 2026 at 05:10:26PM +0100, Michal Simek wrote:
> 
> 
> Can you point me the dt binding document?
> 
> I am aware about this one and grep is not returning me anything from linux-next too
> 
> https://lore.kernel.org/all/20231002021602.260100-1-takahiro.akashi@linaro.org/
> 

Yeah...  I should have done the more standard thing with gpio-ranges.
In v2, u-boot and linux use the same device tree format.  The difference
is that in the pin control driver, u-boot handles pin muxing by sending
raw commands.

regards,
dan carpenter
