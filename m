Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7244BEB1076
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 20:45:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A14C984166;
	Tue, 10 Mar 2026 21:45:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="R5VE0Wkh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92E92840F1; Tue, 10 Mar 2026 21:45:32 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C61683F8A
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 21:45:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-46704177543so1503871b6e.2
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 13:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773175529; x=1773780329; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XTPtY0AnR1FQs4phQ1DTEHJ+okoKani/HXAVwGSoNHI=;
 b=R5VE0Wkh3XtOo8Pgrhz0H7xwZ75wAgJ8uh92yENE40bwWIdC1pg//VZB8S9mmIcuh3
 fhAu3PfNVblJ/nMITrC7WoFTXpdXNJZnVydIOS22G7iRoeEZSo5DXOWIhy4t/QM+K1/G
 FC8O9UvZDYmp4CwXae7E5bhFCzFBTbc1AcTaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773175529; x=1773780329;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XTPtY0AnR1FQs4phQ1DTEHJ+okoKani/HXAVwGSoNHI=;
 b=oCvc4OZbEwyhWIeVS7EZ2OGJ1vX2GdknBw9MnsFXkW31Ro/GSEDKiyx70J3EVt/Zwy
 CJAF5s219cp7a7PScE1UzYrdJco+VpDPxK4eCL853AO4+adYvIT2pJdbqL+tnl8wDn1p
 h+ZSoaPRNGCSYFi6de5oouEOzr5kbx4oRxKF0uAjtSquQ6D8MbMtGNT5jTuzSWmKvUXI
 8EjpI/MPoymFl2MeaVvcl2F5f7T4zCGLwlreQkGSG2grz0KASU79RfsA8jGoenIXOtAp
 MkQG+VShMyIRaX11lREapdaj/4eJXKetj6paJ3+UqLJzSUrHmMQt/xbmjtLkESG0Kloy
 k00Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHuUQAmyVTLOQrUz7VjFumz4zVPJRtuLe33/Y8ipNleBmSV8qvCg7nP+sglVWk1AnQXJMP10k=@lists.denx.de
X-Gm-Message-State: AOJu0YzDiOGvZt+mox0GZ1HjR9ZTwOE3eorJCVIPPN/fSgXLMLMS1AHv
 MZ3TzmiQVbydaEe6AihtpnasjL+pmww0PI80iNbkaf5esd75EaVnvfNMR4LxyXkHGqI=
X-Gm-Gg: ATEYQzx/vMz9WnzooB8iVwOxyVZM9bM+g7GRVOvutlYdHXs6ymmnIZeqGDAFdD2gTfp
 3n0pr41iUj2Ew5WpgYVL/IlraQJGYWEPNDZBbmb+w2BqMatMPuNMafWT2JA9CJLywr6wKMu3HdB
 IY+A71kLy0hXUcMCbV8jtvenLUf4bmD3a4PdYZ1YRXwo/C/6KEq1c+G5b3gfHP0dzcdijpRQzfS
 B8kydyrWXkGMoGlBzoVvKlCQff4owuzhIbuoXEKm246btKsmEY3WcYu3SLs7XYpt9n6arE0qvg/
 nbMrKHDJr4cumbPWubslKJ6lmQPJN8awsn94X9FSTCALkEwKopW0u2IyTOTaA54UfhS2aX5VQvQ
 U3YdFBJahLpIWMKnbtcIrOE4oYSRv7tZEHOmTa28woLqhks2EmuRproVLxkfWqqNIcw/N4eif7+
 xyGbDNuSyHCcw1hlq4xutdRozBNNc3KKRuIRc2iluz0a4gvNrt+uh1w0p+Jv/LfaspwkUe5eONC
 Kzi2V2fwyzlWejdyiYSdPR3mcPjOaoRz6o/1zCR2OfQ
X-Received: by 2002:a05:6808:f8b:b0:45e:a1e2:2808 with SMTP id
 5614622812f47-4673345a40fmr60165b6e.27.1773175529176; 
 Tue, 10 Mar 2026 13:45:29 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-466dfac3acfsm8256086b6e.16.2026.03.10.13.45.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 13:45:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>, 
 George Chan <gchan9527@gmail.com>, u-boot@lists.denx.de
In-Reply-To: <20260225073711.51688-1-heinrich.schuchardt@canonical.com>
References: <20260225073711.51688-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] boot: don't select non-existent CONFIG_VPL_CRYPTO
Message-Id: <177317552814.23044.14232299909019612201.b4-ty@konsulko.com>
Date: Tue, 10 Mar 2026 14:45:28 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 25 Feb 2026 08:37:11 +0100, Heinrich Schuchardt wrote:

> Symbol CONFIG_VPL_CRYPTO does not exist.
> Don't select it.
> 
> 

Applied to u-boot/next, thanks!

[1/1] boot: don't select non-existent CONFIG_VPL_CRYPTO
      commit: ff1b59c9bd49141efd45d50ddba291820a6ae975
-- 
Tom


