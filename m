Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A73CF3191
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 04:41:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B6BA8913B;
	Thu,  3 Oct 2024 06:40:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j6JcGaH0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51CB488FC5; Thu,  3 Oct 2024 00:59:21 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6ACF888F99
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 00:59:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42cb60aff1eso2382755e9.0
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 15:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727909959; x=1728514759; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=HcN04KbujN8G3LiYNTUKzvyBELMpa466hybMn3Z56AE=;
 b=j6JcGaH0TrbxBX4Pe2YrwfUierb6yRDOzTin+1DUS5jpmMQQjwXmOPRKNzSUVCtuKa
 MVK3w99rL4uNpEu3EAnV4UOEo4suA5aENKlb2bw37Q/S0xHmt0mbceyPkj0u+OSRacOI
 O5Jycvtv5ZPU0zMgfWrMWZc/CZ0n2wqOKCowEViioZsj8Qizj/1AmPqZGknOU+IDdLFX
 BMeXVkOWuyTL1jNGLV2yfeqlTEgVzIBz4fd0F+0OtcvJ71bSl7HFZyDwmvCJ3E36DtMh
 vuwSVGvx+sTMdwcyLhIbVgoWBbMLc10/3hQJWFc2KI5ArYHI9zgxLDqXYAUa1Fq2wvNF
 DUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727909959; x=1728514759;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HcN04KbujN8G3LiYNTUKzvyBELMpa466hybMn3Z56AE=;
 b=UezdmA0qMaYJS08K5JdDB2qpMXdsYAtboJhnAXbxE5UYBnSWoQsJgqx6aQaF3rtzO0
 yCREVtgiF0ZtczD5P9riUSBPgESstsuxVoFr+c9DhKIaS9PJDKwdr8ImrbfSc9iG3YpL
 gET7TC49EiydLovYH1WvBZd3fbo15OJMonw6XBfHa2GKF/pWV+AGSjL1UKrrkYtRaCem
 WfLyh8VNuGuXarXKuMkNop+VZuINgQziq1s+/CbDY03Cwj/azHyKaSD5swPzz0PFSOkI
 QWefo34GTjfbRHP/TJe+/sXIeBvatcj237/Oy0Q6FzpFCTEnsa+4tf+HnAL7c/v2qlsY
 PHRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCztjTxT7ZrIJTEovGmxyDDSdRakkqFVZeLliFr+09eOaMNauPbB5FQVoMdhehp3EJQ1K9NAQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yyt9YgIio+BUWqA7NVN0utsWzQE0MCXNp+PxXgAKyiuK2/bxipY
 dmbCzmM8JEGlkTmo1sH31sCypuUXJSBUBUJZISLXvr6jCJByC3t3
X-Google-Smtp-Source: AGHT+IG0p0RovECA0wv46rEPWoTJ/ZnFX1ylkeaUwPnp9vhmMxfejrNVo0edzOZ/0H1QCNjF8npT5w==
X-Received: by 2002:a05:600c:5253:b0:42c:ae4e:a990 with SMTP id
 5b1f17b1804b1-42f778ffcaamr31121475e9.35.1727909958677; 
 Wed, 02 Oct 2024 15:59:18 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f79d8d309sm30276855e9.6.2024.10.02.15.59.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 15:59:17 -0700 (PDT)
Message-ID: <66fdd045.050a0220.3cdcac.ce00@mx.google.com>
X-Google-Original-Message-ID: <Zv3QQYMYpBhTpOeO@Ansuel-XPS.>
Date: Thu, 3 Oct 2024 00:59:13 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Sean Anderson <seanga2@gmail.com>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Alexander Gendin <agendin@matrox.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Artur Rojek <artur@conclusive.pl>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, John Crispin <john@phrozen.org>
Subject: Re: [PATCH v5 01/11] led: toggle LED on initial SW blink
References: <20241001122511.8832-1-ansuelsmth@gmail.com>
 <20241001122511.8832-2-ansuelsmth@gmail.com>
 <CAFLszTit8i_rEj-RS1EfHpOjDQ+bqWMBbZYANJ8ZXcuYLnBxcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTit8i_rEj-RS1EfHpOjDQ+bqWMBbZYANJ8ZXcuYLnBxcg@mail.gmail.com>
X-Mailman-Approved-At: Thu, 03 Oct 2024 06:40:55 +0200
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

On Wed, Oct 02, 2024 at 04:55:41PM -0600, Simon Glass wrote:
> On Tue, 1 Oct 2024 at 06:25, Christian Marangi <ansuelsmth@gmail.com> wrote:
> >
> > We currently init the LED OFF when SW blink is triggered when
> > on_state_change() is called. This can be problematic for very short
> > period as the ON/OFF blink might never trigger.
> >
> > Toggle the LED (ON if OFF, OFF if ON) on initial SW blink to handle this
> > corner case and better display a LED blink from the user.
> >
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/led/led_sw_blink.c | 17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> Running a little bit blind here without a changelog. If you use patman
> it will do this automatically.

The cover letter didn't slip in the mailing list? Changelog is there or
I'm missing something?

-- 
	Ansuel
