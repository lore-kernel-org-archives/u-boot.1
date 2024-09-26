Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E76CDE03A
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 21:34:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3259D88E77;
	Thu, 26 Sep 2024 23:33:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FcpDqH3l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FFEA88E26; Thu, 26 Sep 2024 23:33:49 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8065188EC6
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 23:33:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6cb3bbb9cf5so2116156d6.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 14:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727386425; x=1727991225; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=98kmsWz9mj/8mckorKviYOLWaoWZQZOUlOodbyr4ZHw=;
 b=FcpDqH3l0fUOmbthtezLp/gVdDEfpo9xh9fVA5CyByKflQSgjVAvMmQvGpgYMarEW8
 ENryAjiYDFkipNekvLfyAqDIHn/rQQhxdPNFB1NLosIQli69eOwgzSY7UuDhTp88sRBl
 kyApNrioyT887acJ4Cth1/SCG5WTb698lsfW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727386425; x=1727991225;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=98kmsWz9mj/8mckorKviYOLWaoWZQZOUlOodbyr4ZHw=;
 b=cHW0ORmbo5pCn6RSS7RTIRmxWrD9WC60N/CLUbeJzGcaLmpXOkriZNnscpShAJ1S5D
 HMbfARROZcC6oxHZcCmBDrNagELOgLvDiKQDMAsYo8YMOLJ/2VUSX/NCuSl0zs4oKawY
 VTg/06OzRQStfId9gbOdsPVmf6TT/T3F44I83lUgHBfwiKLBcqZHf7CFjZyz/N90JJyP
 e4Gnbq6H/UN69DPINB3TnOGz4wz00vswecLT9ZPQ6VYuVO4ddPd6db2UqcSKb4dJ/C9u
 3M2xOpbhM7OLI7fuLlIfZ7SEc/N5gizmCnTQBr4x4jW4YvCXJ1dQGsSUu9m8K/nXDeM2
 Nqvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUe8rbj7FYAjhFnaQ57pS63s/H367vZm8UmAySwl0woImWCoFuCv03PEXUtKfOM+Aqme9Xpp78=@lists.denx.de
X-Gm-Message-State: AOJu0Yy8+mtDWXVHCpJlP82aDQD82gZZUhSSQmJcXT+cNw5g79GDI+rr
 N6ADqp7OvGzgETJytFmb9xEvhURnz7DLfwsIaUjbUu8liGKQw51BTc4TcGUF3gbAxzLEQy4KxBL
 dM13VeLctDIiAsAdeyA8dytuwxafUU1rI+saa
X-Google-Smtp-Source: AGHT+IG2IIciQhCkHTF2dKgObE0bj0oahhoDLLB4Sk8MEn6Kt2MBGw6j2xe5Vd/MJPI2DEZe7cBzVPr+Ju/EnWMisik=
X-Received: by 2002:a0c:f408:0:b0:6b5:e2d9:cfb9 with SMTP id
 6a1803df08f44-6cb3b63f633mr12975106d6.39.1727386425319; Thu, 26 Sep 2024
 14:33:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240920225101.2008-1-ansuelsmth@gmail.com>
 <20240920225101.2008-11-ansuelsmth@gmail.com>
In-Reply-To: <20240920225101.2008-11-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 26 Sep 2024 23:33:31 +0200
Message-ID: <CAFLszTim7f6fre3v7E5wPmNncEw6A9s1+uwCY98UvGvdRX3nhA@mail.gmail.com>
Subject: Re: [PATCH v4 10/11] test: dm: Add tests for LED boot and activity
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Sean Anderson <seanga2@gmail.com>, Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Yang Xiwen <forbidden405@outlook.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>, 
 Alexey Romanov <avromanov@salutedevices.com>, 
 Martin Kurbanov <mmkurbanov@salutedevices.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Artur Rojek <artur@conclusive.pl>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, 
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
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

On Sat, 21 Sept 2024 at 00:52, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> Add tests for LED boot and activity feature and add required property in
> sandbox test DTS.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  arch/sandbox/dts/test.dts |  2 ++
>  test/dm/led.c             | 72 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 74 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
