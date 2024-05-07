Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E493C19F4F
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 19:35:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50D8A87DEF;
	Tue,  7 May 2024 21:35:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eblw77Fz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AC6887E01; Tue,  7 May 2024 21:35:41 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67C5587D33
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 21:35:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6a077a861e7so25378916d6.2
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 12:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715110538; x=1715715338; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fgwFBNXi3nHjOI4EUtCeSctK7t0bkz2k4H5b39jEc7E=;
 b=eblw77Fz398XGqgoR5oG9fvEoU22jMSkponNRRtJgBCTZ/hWPKKwt6LNZgphY0WJBK
 pVPyMmrK4RfpLh9itIeRgYqNomUQYjtW8tPkSA1ziW/nRugQhspNULLPKACnenVTqohl
 AZoNTAIrmsNgGrhvQvOKarWatOO5Gva8sr/2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715110538; x=1715715338;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fgwFBNXi3nHjOI4EUtCeSctK7t0bkz2k4H5b39jEc7E=;
 b=va6GfWsgRGTGiiYJu6g3kiNW61YN2cFIA472IvVZ19b+hCDGGC5y1nk1jwuIji/z6X
 OoxJa53KdZLqvHDIVNUayo4OF2BcFzDJ45yNSrXB5R3Atph3oNudBODSXqI+76D4GErC
 +94kRXHnPy6xLW2e/kOC2PhH2w8VXkB2aGJHzEIu3mdFAf1/+TI3IFdtO+C+yimGMHq0
 WNoAxcnW0xNx9sAMYSVyIKJFAIftTajxlTXqcIlEpH6GByPEL5W/gkjdpZB5hXGgJOh4
 fjlEVHUSHGfvP+UX1paNK1dTKXvTQCAVlElB4Sr7YfPVWR0FPuhzliBFkH///54JqvRQ
 wXRQ==
X-Gm-Message-State: AOJu0Yw3LLHmw8njII89TavX2RBQiJugRr+L73qSwlSzFekFvAs/i0En
 xem/S69+qaBvjSjlFpONsMfOTLvutyo1dA9dVT1Jc4gKa+wBZhyMWG3lHamD63o=
X-Google-Smtp-Source: AGHT+IEeqMxFHywzMAcnLb1LKQysjbJMIBqdY4bTWS9HxpVCWBiFq4TxUZ+hCuaI3EmJnSlCusIIkA==
X-Received: by 2002:a05:6214:4113:b0:6a0:cba8:68c5 with SMTP id
 6a1803df08f44-6a1514eee8fmr9460366d6.60.1715110538292; 
 Tue, 07 May 2024 12:35:38 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216]) by smtp.gmail.com with ESMTPSA id
 mk7-20020a056214580700b006a0f7f6f4fesm4931469qvb.4.2024.05.07.12.35.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 12:35:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Adam Ford <aford173@gmail.com>
Cc: aford@beaconembedded.com, Kever Yang <kever.yang@rock-chips.com>, 
 Michal Simek <michal.simek@amd.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Tony Dinh <mibodhi@gmail.com>, 
 Tim Harvey <tharvey@gateworks.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Sean Anderson <seanga2@gmail.com>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>
In-Reply-To: <20240501095813.23591-1-aford173@gmail.com>
References: <20240501095813.23591-1-aford173@gmail.com>
Subject: Re: [PATCH V2 1/4] arm: davinci: Migrate da850-evm to OF_UPSTREAM
Message-Id: <171511053589.3036039.14042903701802322832.b4-ty@konsulko.com>
Date: Tue, 07 May 2024 13:35:35 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Wed, 01 May 2024 04:57:50 -0500, Adam Ford wrote:

> The da850-evm can remove the U-Boot device trees if migrated
> to OF_UPSTREAM.  This means pointing the device trees to the
> ti/davinci directory.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


