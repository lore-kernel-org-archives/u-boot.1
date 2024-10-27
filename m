Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D77D1358B
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 23:11:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75FD088730;
	Mon, 28 Oct 2024 00:11:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="A6sU7xAm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91AE888EBA; Mon, 28 Oct 2024 00:11:13 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AE228862E
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 00:11:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6cbe53a68b5so28317266d6.1
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 16:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730070670; x=1730675470; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=js7PvqUJZbSu8S8l5QTSgUXdh74hY0iSV4EapY/yL3g=;
 b=A6sU7xAmCQ0CGV0e1lu/qAM52z1kMMhb4LlnUxmMK2XS0KJZek0LDxJe/XpGgwa69W
 qub65mZWzKn3FkL+m/fgvnsViQrSDjgtC6yJZ2sW0y+rK61KltJPz3+Oc6aiZLwrpHUE
 aSw1t5LrQ3NsNu/6ahxxHoDi1AXgqhMEiuc7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730070670; x=1730675470;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=js7PvqUJZbSu8S8l5QTSgUXdh74hY0iSV4EapY/yL3g=;
 b=hejqzG57UuV63kXR4+YjR2MZd7BS/E2Y9UMY1ogUI8dLC9nV/OrIFCOj9e2UHSQajM
 REHA2pZd3DV5QAHt5P9dy+bxerYc0rMlgdAFUEntaeMC6ntBFpsdin+/M+onDqOtmXsO
 SFcajnuHzyK19wprM7gle7ua/KsaiLWGcrvhGdQDy4GpX8lg7BOs8jTRMNqj9AqEMNjf
 n7XbOyY6rpPP+x3/9feItfmQd8zLO1tJpPIerwmqyXcgV/K1y0efaWuPufpVXYpQF+Zr
 cx8dD30wvq/OoG1XdjnKj1MdQHDGy6fkIqsjPmr3kIz2RXcybhfLf17PQWq+yaV2kgul
 5iGg==
X-Gm-Message-State: AOJu0Yyh0gRfJWg2j5UAmnOnnG34ur8/Dngrp1Bfstqrzb6kjGMusXY6
 ELkJgA8s5FZ5tqbCNg0uh+Ro4SoKKOQzq8TCvzN1FAPVZLLNZ6CuyZI7tavJiCPsM7kqHK7mXGO
 Tkbs=
X-Google-Smtp-Source: AGHT+IEWQ4vMEZfWDQxCHcU/X7tbtkEbcc8ZiNW/DgjI4g4ak7EuhSvU1nlsoXpAMtZLlIEtPvT08w==
X-Received: by 2002:a05:6214:4b08:b0:6ce:d6c:499b with SMTP id
 6a1803df08f44-6d1858899bamr101930616d6.42.1730070670335; 
 Sun, 27 Oct 2024 16:11:10 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d17972f622sm27464976d6.9.2024.10.27.16.11.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Oct 2024 16:11:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 ycliang@andestech.com, tekieli.lukasz@gmail.com, 
 frattaroli.nicolas@gmail.com, Frank Sae <Frank.Sae@motor-comm.com>
Cc: yuanlai.cui@motor-comm.com, hua.sun@motor-comm.com, 
 xiaoyong.li@motor-comm.com, suting.hu@motor-comm.com, 
 jie.han@motor-comm.com
In-Reply-To: <20240912120225.28884-1-Frank.Sae@motor-comm.com>
References: <20240912120225.28884-1-Frank.Sae@motor-comm.com>
Subject: Re: [PATCH v1 0/2] Add driver for Motorcomm YT8821 2.5G ethernet phy
Message-Id: <173007066732.2057421.12297852745969266200.b4-ty@konsulko.com>
Date: Sun, 27 Oct 2024 17:11:07 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Thu, 12 Sep 2024 05:02:23 -0700, Frank Sae wrote:

> YT8531 as Gigabit transceiver uses bit15:14(bit9 reserved default 0) as phy
> speed mask, YT8821 as 2.5 Gigabit transceiver uses bit9 bit15:14 as phy
> speed mask.
> 
> Be compatible to YT8821, reform phy speed mask and phy speed macro.
> 
> Based on update above, add YT8821 2.5G phy driver.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


