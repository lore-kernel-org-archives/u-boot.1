Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B2FCF9C70
	for <u-boot@archiver.kernel.org>; Mon, 23 Sep 2024 14:10:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4467B88AD7;
	Mon, 23 Sep 2024 16:10:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K2gBJIA/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33F9C88B16; Mon, 23 Sep 2024 16:10:12 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A45288A0D
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 16:10:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6c34fb4f65eso41916376d6.0
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 07:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727100609; x=1727705409; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f0gjzAmRjocCz6MALBrpO4Kijqd1e9mTPh2vseK914s=;
 b=K2gBJIA/8pinYKD0DbQnLUWJmZ2i3ABj5cPWe2Fki2LGZ4foSrof/LOiwrJIvnr7W7
 m6EVI1PGtK6hgsnoFWOApjKK8Y5Stg52StZRqR9Zn1p4fw4M7GDVRB0ycFlNHWeZyEcU
 0RwlYJICeNBY7MbSlQ2kLhlGVSaXpHj039+D0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727100609; x=1727705409;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f0gjzAmRjocCz6MALBrpO4Kijqd1e9mTPh2vseK914s=;
 b=HHPqzS0Qkk5wrVVjwpgNl3RsQd6qlzWoCLEa/nPC9z2o0KnrEoDlrfGbJGfQ1E9ILr
 5v2BkllzgTqA4u/G3sneIimDL/rynbRQYGEqn+mDibdVAxFwO3zTFUHr6wM82a+NS4/+
 mkiY9BJ7pArSpwA78CyH0xRuvk8qWQKHWkcHDUCvJ5lrlHfQibRRxeNhk1yDFb65RkIk
 k6hIdVhz3NatJkHZT9o5MHiM8En1aH4EwktgaUvkS5qttg5XYLGSnpX7JPwH55Y8MCva
 EwTEPKZCWmzMcIPzohceFV6/8g9dz1G/7ZUku1uY+lyxJuC2y4nV0eD1b5/qQhoPp2cE
 CKpQ==
X-Gm-Message-State: AOJu0YyuptUvVBXJDwh+plPdMgJisVAhHJxYw878Sp1YnBfxTE8bOGP9
 GBhGOCrUzNqKLkxnQfajrccGP2WqL1L2bZw3nvik1Vau/6SVl24a20OnqA6uDEM=
X-Google-Smtp-Source: AGHT+IHkyvEbvwTt/xN1l5MW/uazOIm73pebqcQUZ5AhJYGpNRj/+n86T4c68U2K+IDbJa8SBfKAQQ==
X-Received: by 2002:a05:6214:3d87:b0:6c4:6f3e:d955 with SMTP id
 6a1803df08f44-6c7bc6ce13cmr228812006d6.10.1727100608741; 
 Mon, 23 Sep 2024 07:10:08 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c75e57b48esm47966366d6.129.2024.09.23.07.10.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2024 07:10:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <20240906171110.91195-1-marek.vasut+renesas@mailbox.org>
References: <20240906171110.91195-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v6] mmc: Poll CD in case cyclic framework is enabled
Message-Id: <172710060735.3613304.17681262112935377694.b4-ty@konsulko.com>
Date: Mon, 23 Sep 2024 08:10:07 -0600
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

On Fri, 06 Sep 2024 19:10:42 +0200, Marek Vasut wrote:

> In case the cyclic framework is enabled, poll the card detect of already
> initialized cards and deinitialize them in case they are removed. Since
> the card initialization is a longer process and card initialization is
> done on first access to an uninitialized card anyway, avoid initializing
> newly detected uninitialized cards in the cyclic callback.
> 
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


