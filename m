Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A3DBC54E90
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 08:46:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 519D081E06;
	Sun, 25 May 2025 10:46:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UmBXzT76";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F80482BAF; Sun, 25 May 2025 10:46:18 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D0C18144A
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 10:46:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6049431b0e9so137565a12.0
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 01:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748162774; x=1748767574; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=RdlpfA2P/4YboSlNBj30VCSagXC/hZSA0dJSVmT0Kfc=;
 b=UmBXzT76X38dgQhc5aJg6j26Cah8teJx8ShasVjFT6vmXDQVRQsXfyyuqr2I/Vjrof
 J8LFnUhrdEwnhBafHhkGCarTvniFDlKeYVY6m4q51Yu99at9qVpywT8/A9X9hEsuq+Br
 Nmjpg/uywYknDbj3t1nA4nSVhUzIEUlgcw8kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748162774; x=1748767574;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RdlpfA2P/4YboSlNBj30VCSagXC/hZSA0dJSVmT0Kfc=;
 b=X/pQhUZQPsd1z4//9SE33+R0cdjc8rQ2iT+0EosKkhfWByc/R3j62B9dClGGBdK5BZ
 q/M/OkQ58BUbo1HlImSK5mwmobdQ41DqAY/aUHm/TPTDjBVrrw0VZd3a7D6MKnKFGuOH
 8EM0b90bcelwvoSpfgAJ7Burv8+rtfkONklhSlnP1JN8qJ6ji29J/G3TWHQqslRar6aQ
 UJPplREvmTLmyphxEx7b+UehyvBb9lT0oRCigmwZtm5AsgeEk30vMYHUNOQBBp2vbPpV
 weC0pvZpZ947QBYsz96TSgaFyuz5kzaH5kchHp7d2hzXXV2ihxYVLfESrAckLDPLIcFF
 kDuA==
X-Gm-Message-State: AOJu0Yxl/i3HR4/K8EAXGmCxKIyjHAK8Gvs7cU/FIa/S9ogWRNzfmN78
 hfHXcceRbYhXxGTmUFc1rqAWzfkcTPFHxNb5bxwR47MG7HG4xymROoucQ2xZan9Ttpanj5bvPWG
 0gw2QwBcJBXPsXYIW+dSwKQPeL+Vu3ALU2m2/N3a3XbAS4CFjiIC0FO83
X-Gm-Gg: ASbGncvdGitOiyzTwFUx32kDFFwiw9HrwYKQ+xMLsfdRt1u374omTdXHbpJdDWV1WCC
 jyoAtuChJrST5Upmc+hIMPb69sao63wO8qkjPABr5CxE1DDukY+1K5/rpidQRb8zDTXrwa/c2i3
 dUoMtsvelnoEJFLSLyrj+0hFuhTOUxrN8=
X-Google-Smtp-Source: AGHT+IFkESKZ1DtvV1uwFkXPGvd3/uGUeuEwxwchaFuGNgjG2H45OaDzWMlU0eGr7KO+3kvXZQAV6Et63GypJSCtDwI=
X-Received: by 2002:a05:6402:4407:b0:5e6:e842:f9d2 with SMTP id
 4fb4d7f45d1cf-602da5f8b9dmr3127483a12.29.1748162774444; Sun, 25 May 2025
 01:46:14 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Sun, 25 May 2025 09:46:03 +0100
X-Gm-Features: AX0GCFvkhy9MjJqtn4dzLn31j8YGC7vO1cZ3yOkLVO0TO8_DZpTqlohiOLzsnLQ
Message-ID: <CAFLszThbRhKF1Xwqk+hLu8Y-VXB6+fHVXYfphfVjWMN=dVC1dg@mail.gmail.com>
Subject: Broken boards?
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
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

Hi Tom,

It seems that some of the boards in my lab are broken in your tree.
Have you noticed that?

Regards,
Simon
