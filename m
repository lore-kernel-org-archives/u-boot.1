Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 146BFC197A0
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 13:41:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30FB486FA7;
	Fri, 17 Nov 2023 14:41:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="q7HbleF3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E31E68749F; Fri, 17 Nov 2023 14:41:01 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0EE486FB8
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 14:40:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-677f832d844so2262576d6.2
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 05:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700228456; x=1700833256; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K2SoHUNWiUM/4zw4Hi63H8zUeC6WgFwwCl8VEZlBQAI=;
 b=q7HbleF3hkwrESFpnSLGMZsO6OSLlFML5fECJzo7V1pX7xr0r8mH5vyC+5M6LD6N6s
 FyrNZKAY7pFnX6QBGuvMqSVmu2TscQCWNI3MaeeWoQUH4kEjCCw9TcryukoSxtwWXU0e
 Ww29R0sgoHOm1IwqetDQS742ikdkPYJFG9qLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700228456; x=1700833256;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K2SoHUNWiUM/4zw4Hi63H8zUeC6WgFwwCl8VEZlBQAI=;
 b=eKBPyf/GrcZ1u+G2CnLwDnwFEU5r+vI/dwnkTn2pDGIBkWfAne8kNr3whr69Vfv6F/
 eKfnONglSWsCJWC9yuRFPoTg1TL4Az19S2ZOsbEpvOueVjn9yf+3l3UMg7zMgteuzHXN
 MS8zphkoq5KEpAKJqAPIp4DcJJ9Z+di82I7Kfl1JOEBKM37NLZMlD5nLAIZMWrHzVk6m
 U4kMEk+luBaABQwSsuXn9BI9IAOhDCj6uHLesxfuf/IkqEr2ukHQobxn+eoMVa7P/0dU
 VkXM7wxHlEVEkUGLOM9K6YFYF0XEwmkzkz//oeqP1ZkkG2t2OW2rXpz0xS6qV7xwLrxK
 gwnw==
X-Gm-Message-State: AOJu0YxzrY+9wZs6t6eep8notc441soeGKmoirntBlAQlevp6rxwFT2g
 awZz3PwMrmZLNLDXsgA7cqX+oQ==
X-Google-Smtp-Source: AGHT+IGmOKiTW2a+cbG3H7flpm3WUjeIq+XOjmAyEvXVy9oHq55x6vFBJZ2snHKXnp0soPUV3Kky+Q==
X-Received: by 2002:a0c:ee63:0:b0:677:864d:c72 with SMTP id
 n3-20020a0cee63000000b00677864d0c72mr11668317qvs.26.1700228455812; 
 Fri, 17 Nov 2023 05:40:55 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-6400-a78f-80e1-dc58-f720.res6.spectrum.com.
 [2603:6081:7b00:6400:a78f:80e1:dc58:f720])
 by smtp.gmail.com with ESMTPSA id
 lw23-20020a05621457d700b00670f8570a24sm633820qvb.23.2023.11.17.05.40.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 05:40:55 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Sean Anderson <seanga2@gmail.com>
Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Heiko Schocher <hs@denx.de>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Weijie Gao <weijie.gao@mediatek.com>
In-Reply-To: <20231104203753.1579217-1-seanga2@gmail.com>
References: <20231104203753.1579217-1-seanga2@gmail.com>
Subject: Re: [PATCH v2 00/15] nand: Add sandbox tests
Message-Id: <170022845499.752997.11727109077004834794.b4-ty@konsulko.com>
Date: Fri, 17 Nov 2023 08:40:54 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.1
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

On Sat, 04 Nov 2023 16:37:38 -0400, Sean Anderson wrote:

> This series tests raw nand flash in sandbox and fixes various bugs discovered in
> the process. I've tried to do things in a contemporary manner, avoiding the
> (numerous) variations present on only a few boards. The test is pretty minimal.
> Future work could test the rest of the nand API as well as the MTD API.
> 
> Bloat (for v1) at [1] (for boards with SPL_NAND_SUPPORT enabled). Almost
> everything grows by a few bytes due to nand_page_size. A few boards grow more,
> mostly those using nand_spl_loaders.c. CI at [2].
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


