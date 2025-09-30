Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E96B4CCA470
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 09:39:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B7A1833E9;
	Tue, 30 Sep 2025 11:39:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=googlemail.com header.i=@googlemail.com header.b="ZIgSYq6a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA902833E9; Tue, 30 Sep 2025 11:39:16 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9BF1828A2
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 11:39:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=googlemail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yegorslists@googlemail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-57a292a3a4bso6890981e87.3
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 02:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1759225153; x=1759829953; darn=lists.denx.de; 
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=olWh16kB+r0IeJ8XFNJnBjB7CcGsmHhV2sLmYEqFaVM=;
 b=ZIgSYq6aXpRF8DWcsnRpyq2aoaehWflRvXhE3dhWQEgB9bCeWe6Ea3Hl3m7layzh+n
 AYKRNk5F4SfzcAnNB6UQiIsVTtvXhDZkYDWs9R1ddXeGfOfot4USBailEUptsSd4lwKk
 aGrmG8jOko4n47nB4u3sWlp3o07iNpzjj8SaRuqPCZwvPTjPJouVtGkfiq/QAmVZBKnb
 PJ9bf0Bn5DOr1zieHGjgZN4lqGwMiomy4EOAkivVzMqxYlGM1FQ2BlliIo8h6P820iZX
 9hIKrBa7X9k5cmlmJ8bZFaO7kQ9fnBhGYi7EhfOG3VtrLmS0Jz0qmmCBHk1Thxa/8yfN
 op9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759225153; x=1759829953;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=olWh16kB+r0IeJ8XFNJnBjB7CcGsmHhV2sLmYEqFaVM=;
 b=OrbwRbaF3I6XW+n4/kq1gJsRZ8O8A4h6ZsOwjqbWJzxxxZ1J0N0tf0Dak8J2un5owR
 fsx9RNNtfquDzfuSBFX4hiAaaazjU1k7osQttWdrxZJA1L/JEeNmlzdvOy7u6lTFlv19
 kNbDWyAh4Arz2F8tacJz8ejxoFU6/oZJ+JK2vIqmCGZY1K634ZzpCvB3eDs27rnCvFxQ
 o5u9Oh4WkkEh7gurdCl8pdErRv1U70JrAvQOingye5HhwLxYYBbadTFOziWpYIjxuT1J
 +zlCdirgHg/8qeGtXNo4RnC/xhT4542RnoGvI8wyk3mZaxlWG++ilmaLqNVpj9vAX2G0
 rtEQ==
X-Gm-Message-State: AOJu0YwpYf/bFYF39jJGYiu+f+meXvCK9GAF80WUvhras6aLRFxWs9SN
 RBRdNAsdTLvRbpA14r7VyHAsOPiAIHmHlRUUfL41+PvOEkgFJsn9MYX32XFrds91+744mAID/SG
 QLNkfzaTDkeWAkiKctp3nyyFsr0WBi4iULEn4
X-Gm-Gg: ASbGncu/LpYv+Fa7OJK+LAPlcV/MWj4rLTHocT0swO9wg0P4wQtY4GrzW1drg5NINp5
 HvpTEIqPG4OEyCcg/zyH6/fgccCtQou/pNBtaoWczSIfYmhN1PZGEV/38D9uU3UMtWko83LZ/9r
 6phXG/viCteIZrfMBEuiqqn2xTY5qsEXA1jOe4J157uL3Sf+9uJilv0D5SkXzt7N5tx3EwL86Nu
 WjFA95Un5E5nJO3YMRrVj9R/mewt8IA4mq0GDog6QCF/uwfnEWUNA==
X-Google-Smtp-Source: AGHT+IEj3zYDAUozApEGXSCx4ti/YhoQikacVKBazfsdNs9/gKHgrD6FX1I1WsF+SxGKQJcWOKXpu8RnWoBW+FP0l/M=
X-Received: by 2002:a05:6512:1113:b0:55f:536f:e895 with SMTP id
 2adb3069b0e04-582d3ba06camr6973175e87.45.1759225152799; Tue, 30 Sep 2025
 02:39:12 -0700 (PDT)
MIME-Version: 1.0
From: Yegor Yefremov <yegorslists@googlemail.com>
Date: Tue, 30 Sep 2025 11:39:01 +0200
X-Gm-Features: AS18NWAyM3zdYhpzK6jtG4KC8fXKlradQI1fB_fv9rQk3diN1hBKLSTB0yuLkAg
Message-ID: <CAGm1_kuVn1WbwGRKD0HsPe+gkFc_aDA18mG5Rr50TS_oB6wPMw@mail.gmail.com>
Subject: clk: ti: CLK_TI_CTRL name confusion
To: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi all.

Why is CLK_TI_CTRL called "TI OMAP4 clock controller" and not "TI OMAP
clock controller"?
OMAP4 is not mentioned neither in the help text nor in the driver
itself. Its ids  "ti,clkctrl" can be found in all OMAP clock DTSI
files.

Best regards,
Yegor
