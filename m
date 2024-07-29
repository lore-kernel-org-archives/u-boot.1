Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B85EC3DA7E
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 16:22:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A2B4888F0;
	Mon, 29 Jul 2024 18:19:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Hel63o2z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A448888CF; Mon, 29 Jul 2024 18:19:45 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEF6F88867
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 18:19:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6b795574f9dso18943986d6.0
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 09:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722269981; x=1722874781; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JJIusDgzkVzvo1QJcSfeG6JEZcY5119mUQTmdzajez0=;
 b=Hel63o2zM1sgMZdmorDHOpFXXUPaQvUfrbZ9APem281PfPKegNrlHwMiEsjpHJ8/yY
 peUcNNhPQOFv3Vlpyo1s8cTwexgCabmpg6JXNY/et3N55sUaT7+U1WA+GAZhRnZikwzy
 TbqBdD4kIMZHRFSVAIqGLVRV5Afxd0l7pzNaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722269981; x=1722874781;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JJIusDgzkVzvo1QJcSfeG6JEZcY5119mUQTmdzajez0=;
 b=iFP20gnqzAC1L3a14nTdWzoe7EVt8KdrkL+Y2iFi9t+R0hGNzWpGmX2Ky5aaqY8oyd
 lh3q70Lw1VNNu8j/w5mfjAGzMXAuF9c2jQq+UegMlU+2rLNZhQqVDnRy+UsQdSa9Rfbk
 rwg84wy5GFkr/fnsVCWBJQvGfQ7Q8V4RbEVGnwPxfgX3JtiCKkUa4tS2qcBD6Aqes7UU
 HELAgG43TZbaUHNkbwodxd+rY724dFu4EUTViPVZB0fiI+sPEgSivkxnywC1ys0AS/9+
 nDisuWcuVWA+CLkb9nXEPyT3E/LBMd9ps1AqWLXtmrU9xuO752byrPwEIzXDNzTRcoHB
 QpTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUghl5sKCp3GSgoCfLRAFsrmanP2rMZVm1uA6WS5cisO1eeQuJPimRSVYIQYeZqJ37z6Y7qVaCV4ApBRyTfMBbInihHeQ==
X-Gm-Message-State: AOJu0YymKp4FKzEK89E86g5vQlavctMUgGa3ZX0j7upxaRHdwLJVD54T
 xo88bdkDaBeAeuWMxaJWukFK/2WDtcjfDnk8evUTr1JmjdNNEf1PYO37gRoQUzF1WrkeNaOPpE+
 aalE4T5un0O16hofQIAHq3Vul1j6j0yFIZkBd
X-Google-Smtp-Source: AGHT+IFGN7eJ94QKrVJjSbQH2sduFs59DYpNY/RiT/qpqn4CIJCTbEYhLO5n/lhxcgnJdaZK4INbkP3CudzDK4s+Ee8=
X-Received: by 2002:ad4:4ee6:0:b0:6b4:f888:ebb5 with SMTP id
 6a1803df08f44-6bb559be90cmr125182356d6.9.1722269980780; Mon, 29 Jul 2024
 09:19:40 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Jul 2024 09:19:40 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240720104950.2730773-3-sjg@chromium.org>
References: <20240720104950.2730773-3-sjg@chromium.org>
 <20240720104950.2730773-1-sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:19:40 -0700
X-Google-Sender-Auth: YICCPY9MpNM59ZYdBbKKFohEecU
Message-ID: <CAFLszTgOAhYVrKd0Eh3yRLpvryQGvWWiHb-dtEpCOUDSuqgAMA@mail.gmail.com>
Subject: Re: [PATCH 02/20] binman: Correct an error in the FIT-template example
To: Simon Glass <sjg@chromium.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

The example contains references to an non-existent node. Fix it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/binman.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Applied to u-boot-dm, thanks!
