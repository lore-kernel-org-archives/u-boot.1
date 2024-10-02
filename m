Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC32CF3191
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 04:40:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 964C588CFC;
	Thu,  3 Oct 2024 06:40:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kbNdDoAj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0251488FA5; Thu,  3 Oct 2024 00:55:56 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 810BE88FAA
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 00:55:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6cb29ff33c5so2820366d6.2
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 15:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727909752; x=1728514552; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oo3QfWVNMCl58SVNH5MYzR8fq17S1q7ZNUo4bTI+9NI=;
 b=kbNdDoAjR0rY51n+w7LJ3+Pl6HWZxboGvvuIk+BYCw3dU5UnJvb0M79SzNHiAX/IkT
 RKnI7rL8I1R93fqBhfOWCCKCAuWHtQ3WjrAP0kak6N0yD3fHboDWc0mvcaMyxyVyIgYH
 vsPg0FfB9pc4rd7gj/jGjGsdeLlrl95h7nQc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727909752; x=1728514552;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oo3QfWVNMCl58SVNH5MYzR8fq17S1q7ZNUo4bTI+9NI=;
 b=iJjfrFOaJoy5QKVTUEOEXnf6HBLxF2O6s/CBL4rmsNMCMMatHmOwmmcHXVwzGfNn5A
 GbUImUbN7UtA3ULP+vb11THysCbwpZ4P/lmIaqA7ALSydJKs73dxyE6U+j53wKRfd6j6
 1r6u6Gxn9B8wpu+8E6lu/7uD51I6AFk3SzeL5zFx12AmIq9oF3aJCGW9HvGUhoekyzNw
 nHkoJRBFABnZRwBxJL/58ljLyTmYNMkuE8aPHwyj6SgvrESKl3FDgozcX3BrWR/JYa8o
 +AUb9phPD7k0jXc9f8HpR5Aqu9LJ9FfqgYh25O1eBr9YrA5eATy8B21wv0UQTXWVV8fG
 yP0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUT223aXtWmt+9KoRKLbBB1KBKpE5FgkDWdq9Gvmk2yfDLCTVdgxKiTi+NcMGqtYD5QjrFz6NY=@lists.denx.de
X-Gm-Message-State: AOJu0YwC2zekMavY5ZQJJftl9aXuv4ic8SfYJNif0xXeC1+4Wo2f+eR7
 j0dS2eEPupI31rVLj9Y+31/Me+CFyEcJWuzsDYRR+qniptjWWPlIjLGcS6jQa6Evq8FoSDfVX+x
 Mr2Klfa/3UO2A52fUVTEi1BLLeozboJkj+vjj
X-Google-Smtp-Source: AGHT+IGnZTTFYwbQuOem7bzzu65IZLNSTtjzFelQZxK3l2Q7QH1uZYvSRfoNx6btfn785AEpwuvWXVIOEN8tOFkqw5Q=
X-Received: by 2002:a05:6214:3f91:b0:6c5:ab2b:3a9c with SMTP id
 6a1803df08f44-6cb819b2cbcmr57362086d6.4.1727909752415; Wed, 02 Oct 2024
 15:55:52 -0700 (PDT)
MIME-Version: 1.0
References: <20241001122511.8832-1-ansuelsmth@gmail.com>
 <20241001122511.8832-2-ansuelsmth@gmail.com>
In-Reply-To: <20241001122511.8832-2-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 2 Oct 2024 16:55:41 -0600
Message-ID: <CAFLszTit8i_rEj-RS1EfHpOjDQ+bqWMBbZYANJ8ZXcuYLnBxcg@mail.gmail.com>
Subject: Re: [PATCH v5 01/11] led: toggle LED on initial SW blink
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Sean Anderson <seanga2@gmail.com>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Alexander Gendin <agendin@matrox.com>, Yang Xiwen <forbidden405@outlook.com>, 
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
 Doug Zobel <douglas.zobel@climate.com>, 
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 1 Oct 2024 at 06:25, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> We currently init the LED OFF when SW blink is triggered when
> on_state_change() is called. This can be problematic for very short
> period as the ON/OFF blink might never trigger.
>
> Toggle the LED (ON if OFF, OFF if ON) on initial SW blink to handle this
> corner case and better display a LED blink from the user.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/led/led_sw_blink.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Running a little bit blind here without a changelog. If you use patman
it will do this automatically.
