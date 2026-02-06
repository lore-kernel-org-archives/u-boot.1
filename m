Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441E4EE6B44
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 18:16:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22DDB83C54;
	Fri,  6 Feb 2026 19:15:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jyqpBK2u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D3D483B8F; Fri,  6 Feb 2026 19:15:31 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B60583BFE
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 19:15:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7cfd8ca8191so383417a34.3
 for <u-boot@lists.denx.de>; Fri, 06 Feb 2026 10:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770401728; x=1771006528; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5/IZ1mrb5KWaRwktdhDX3DdNkpQEMG0DGZ1dTwDkhHM=;
 b=jyqpBK2uW2qec8GWvqQpHz+++TLeKwDn9jji7OHZfVhrUUHWCGiYhY6kl8M12tTnSJ
 A3ULNLuLeLG2DpJfqDzTIODvQnVUbSgK2eE4s2/bav4lasxnuoWcYv+rR3p3C6JFJs7O
 JlzvWQ9am4+oZJTjRBVuQUzpTMKj4D9tBFnqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770401728; x=1771006528;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5/IZ1mrb5KWaRwktdhDX3DdNkpQEMG0DGZ1dTwDkhHM=;
 b=LmJ8efH01r2KukAH4kFYlprQ4KvT5HY4ek3Qkjxq1xDViYFthJQVtdQmQcd7tKOmc2
 RYdOB5m0xaehfWA2O+bycclk60pwI4zl9vNrfGKxgcv/Z8Bt1ocgaQKnwnPG0Lj04e2G
 ufEmbflwhawHgiFUQQ/P2pLBucJBfEatyJ4W2NgSrER4LT130I5MrHAvqgyaJWZvSlmh
 g9X2ElglDH52c2q1Vc9Ser6fIs9w1XD7sPffP40sttIU2PGsohxt/ApChLB5U9Hh8GlZ
 8iHv/NLTEU5skXaVU3CAN5UJMZdOwes6pUlgs5x+4pRMQpygTEmjyHaJN/duY3DVo64H
 k5Zg==
X-Gm-Message-State: AOJu0Yy4YyHQEwOINAIRJSQnukq8TphJD+8Fla7C6XPsJY2IjVnMWZV1
 ySrf0WjsGrGieV1/gKijOshvSRKivU6rc++G7omLZ9B9G228sPsca6WrLE9iCDcrIoVa/6exw2i
 uTr3Z1yA=
X-Gm-Gg: AZuq6aKCjhofzNDWY4XgDAZjiVT/w+OATUYf/MNKwn7+UVFV3ii66sAYf1wOyyPvmp/
 7oGxDb1dJuHLGAxoYeIR7/j6eOqACDIWgfRCk+Fs9Hz2Rkqpy008P3aoikg0QR+0LEcHxZ3gOeF
 1ijWA3Cb3q1uhX2cyUDutkQnwQ7beON7NoKAJ9+4wM2B/1fVqsQo6u3b+vz7+avV3u+1ekqt8BW
 P7SIpFbYWkHOixGEQbqzZoUgO82ADMFmVpV67w+DkLbtGnKSeEZeVwE8oz3U0xmqkNR49oJaMC1
 UlwKA4WdWdVCuc0/CUpdp5TPaJuGnPFObUIDdgiE+2uehY3GLQJAwuIMyqNCnd47wX5l+5+lHde
 paX4gTJ33S9dJAB06eVlZ+wPhTZX4f8gIeHYoMBh4pmEgetYxY6Ud6PzwIsPboSuQ9xL/kybf2w
 Jyt0tp9dLFoYh6Tgc7FZjSq+2Q/Rde4qk4uRagtEkvHA8YsQ03o+EBxDTYCrCEznIKL0wmfEqV0
 cJzmZ4dlM8u+XNmTBomw0BWR+mD+vw+J4VZaA==
X-Received: by 2002:a05:6830:3889:b0:7d1:582d:71db with SMTP id
 46e09a7af769-7d4646c772cmr2072351a34.38.1770401727865; 
 Fri, 06 Feb 2026 10:15:27 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d470914a1bsm97426a34.27.2026.02.06.10.15.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 10:15:27 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260130215722.3117956-1-trini@konsulko.com>
References: <20260130215722.3117956-1-trini@konsulko.com>
Subject: Re: [PATCH] CI: Update to using grub-2.14 for our tests
Message-Id: <177040172732.4023747.15792709246154355298.b4-ty@konsulko.com>
Date: Fri, 06 Feb 2026 12:15:27 -0600
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

On Fri, 30 Jan 2026 15:57:22 -0600, Tom Rini wrote:

> When building grub-2.12 with a newer GCC, we run in to warings (treated
> as errors). The simple fix here is to move to the latest release tag. In
> order to build a newer grub from source we need the autoconf-archive
> package to be installed.
> 
> 

Applied to u-boot/master, thanks!

[1/1] CI: Update to using grub-2.14 for our tests
      commit: a54d613baf742a95b6deb7a016ef6262737d1918
-- 
Tom


