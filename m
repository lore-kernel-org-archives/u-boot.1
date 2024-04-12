Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ADAFC4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 14:19:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70F33881D7;
	Fri, 12 Apr 2024 16:19:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="B1o09ib6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27423881C9; Fri, 12 Apr 2024 16:19:11 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AECF487DF1
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 16:19:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-69b1effececso4131486d6.3
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 07:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712931546; x=1713536346; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+OOD9wkDvGyYQbEuSUrQx9TW0wA8XrWZhIx1OO95SbY=;
 b=B1o09ib6GIbRLjBMTwUZ/VGtbK5TEULBN1AAJ+Y212/eJ3bGLe8ku0TMauP59LmILA
 EIVNuBKz5lVTJ7wrBJQCsD189bPagZjo/4a1/3qXo4DK6Uxh94Rk63W9Y0TG1LsEBzk2
 KpYAXE8k27TSkRHM3rZ43DkBsvi2lbGbj1qBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712931546; x=1713536346;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+OOD9wkDvGyYQbEuSUrQx9TW0wA8XrWZhIx1OO95SbY=;
 b=sDexTSsnzrsK9liqr5hah1VR/kjg8PqTEAEFVKNdFeGJnbswFXztrWfdHH9LgwwfP5
 YVG3eYNwP5h0kfy8h4wgkZaMGTTvWtKeBpk3nv9c47KggwKRFc8DzjowCyyjnB+vYr2F
 mv+6VcpEp71skbgLDvzOJcXvrmz01pSNF1Nqp3DezJ2FaYXiKb+OqrFwUJVYP4TnVwzv
 x7NFo//K77swareQ/DlI5RIFm8Cr+4NVRxSUgVM/ymT2QAQbrmaf97WMng/97jMsGSMZ
 hc8O8L7E4aOeybM0MMdO7bAnOyoen5orZtt+qRavXLcDNsT9ku4TsTUmgStE0Y1kJX4P
 6cPg==
X-Gm-Message-State: AOJu0YwxfS/IugngYT1RAuWhCotqU3lW0IEqB6PI+s5vK0t5u6TrDNxy
 E6vbu9CDPUbKnJLGjMGTwD0O/SJGf26KG2vjQ0IWRdlvLQyX+9X5bKwNB2QkJYY=
X-Google-Smtp-Source: AGHT+IFtsNQiksWkYXuzmM5LRCSAdOBf0SSk7H4mzuWsPagt52O37O3kl8MMHuTnxtlKfyuUCOjkpw==
X-Received: by 2002:ad4:5802:0:b0:69b:f88:9567 with SMTP id
 dd2-20020ad45802000000b0069b0f889567mr2976371qvb.1.1712931546608; 
 Fri, 12 Apr 2024 07:19:06 -0700 (PDT)
Received: from [127.0.1.1] ([2806:102e:18:245e:b648:93e1:5c61:68a3])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a0562140c2500b0069b5150712csm1759399qvd.56.2024.04.12.07.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 07:19:06 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marcel Ziswiler <marcel@ziswiler.com>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Andrew Davis <afd@ti.com>, Bryan Brattlof <bb@ti.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Dhruva Gole <d-gole@ti.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Kamlesh Gurudasani <kamlesh@ti.com>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Michal Simek <michal.simek@amd.com>, Neha Malcom Francis <n-francis@ti.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tim Harvey <tharvey@gateworks.com>, Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20240403071518.400771-1-marcel@ziswiler.com>
References: <20240403071518.400771-1-marcel@ziswiler.com>
Subject: Re: [PATCH v1] verdin-am62: move verdin am62 to OF_UPSTREAM
Message-Id: <171293154379.965666.12011190709629771966.b4-ty@konsulko.com>
Date: Fri, 12 Apr 2024 08:19:03 -0600
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

On Wed, 03 Apr 2024 09:15:10 +0200, Marcel Ziswiler wrote:

> Move verdin-am62 to OF_UPSTREAM:
> - handle the fact that dtbs now have a 'ti/' prefix
> - imply OF_UPSTREAM
> - remove redundant files from arch/arm/dts leaving only the
>   *-u-boot.dtsi files
> - update MAINTAINERS file
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


