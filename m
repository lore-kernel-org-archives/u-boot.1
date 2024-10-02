Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA23BCF31B9
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 04:41:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46AFA89065;
	Thu,  3 Oct 2024 06:40:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JC4WRQ/o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B7D98901D; Thu,  3 Oct 2024 00:56:01 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C921E88F7B
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 00:55:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6cb29ff33c5so2820826d6.2
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 15:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727909756; x=1728514556; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=y95KSwJGkD47a3tN8w2UAocGZ5H9mAWoD1/WG9HJTWU=;
 b=JC4WRQ/os3KZK39XJiBQgmsPoI24/xFC953DRFsuBbBChOTNxXCVytx5l/+hagqDko
 DAYcUR4ID92uPKxp2/5Pq4qqBXUcP0+xyIOwBGvXHwx8bve/cKNZSUE+23t+jlGBGOlA
 U1k6wqXz0J/rkVAdnUG3pbz/QZ1fXSVk21tLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727909756; x=1728514556;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y95KSwJGkD47a3tN8w2UAocGZ5H9mAWoD1/WG9HJTWU=;
 b=XpCm2Q9crOHo8MF95db7WW0H55CNbHKHhMT2KuACmTHhh4ZBgQ6pgLTonJQ1xdB1OG
 W4UnT5AhzwH/aW06OiDVa53vYHuz583V287sZcfX7USMv192Y0s8WD7Q09O0GUKAXRdu
 QS5v36S3HK2DORtu2+uwYaa+bk6OGHcC4Da8wstIPDVG/tViOvDcQRacUOoTsVHT9i7o
 XIkXK5iHl4N4MHXwsCeyAZEpA26TQgfP1KySME69/3ilPFBYpVzzBrzHw+kibAzZrmqP
 e2RJtetSZnWMFl7p7IqtJiL7PnzUeLU7lTdp54tEHG0C9uJvAFpCMVnjBnQ4Pa79NP5P
 zqUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZkcqiHZ8lwMrmoV/9c8aR76y5gdo3LbmvnXJIAFrwhtN1tDpfiESOhkMdoszDkqqg61UvXmY=@lists.denx.de
X-Gm-Message-State: AOJu0YyjVHTbgjEh+lBNqhXvyC2Rwe26cCZ1XucyiqEqxH13Pcr03ubN
 CZtcNa/v21Zh3P1qk4CzcMjVSs4hYmiMu2lwbrhaAYbrmigAMOJfZWzp35bscM7LBdzTZUlkMn+
 ve99hcIg/w0xk2e0d9HV6OWNAScJm6+xLejLC
X-Google-Smtp-Source: AGHT+IHOA7eg+z5LZUyd3UfwGmrbQo22SrR929rPz3nvV+BRU1xOLfQ/tc+uHDN5yLSh9UqGXthqFio6Tz8Ed6cNJac=
X-Received: by 2002:a05:6214:4521:b0:6cb:72fc:7080 with SMTP id
 6a1803df08f44-6cb81a48ecamr83548996d6.32.1727909755800; Wed, 02 Oct 2024
 15:55:55 -0700 (PDT)
MIME-Version: 1.0
References: <20241001122511.8832-1-ansuelsmth@gmail.com>
 <20241001122511.8832-8-ansuelsmth@gmail.com>
In-Reply-To: <20241001122511.8832-8-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 2 Oct 2024 16:55:45 -0600
Message-ID: <CAFLszTiWDihQuwe5Ap6mFz84aDkcBKb+PniYh6OpV-09yMcjfg@mail.gmail.com>
Subject: Re: [PATCH v5 07/11] mtd: implement support for LED activity
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
> Implement support for LED activity. If the feature is enabled,
> make the defined ACTIVITY LED to signal mtd operations.
>
> LED activity is implemented HERE and not in the subsystem side to limit
> any performance degradation in case multiple call to MTD subsystem read/write
> are done.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  cmd/mtd.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
