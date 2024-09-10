Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F699ECE58B
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 22:38:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6449389138;
	Wed, 11 Sep 2024 00:38:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AYbu6j7C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50EDA89133; Wed, 11 Sep 2024 00:38:41 +0200 (CEST)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C7AD89098
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 00:38:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-4584a719ff5so6543731cf.0
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 15:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726007918; x=1726612718; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5SK2Eedqxd2iAIhXS2FUmtXfo3/fzxmy5NRGxfkLY3g=;
 b=AYbu6j7C0Sj5R4In+Sq5qPDqQ/GGaBvG69KmVq5uTYRW9bo9Fxz8Z9qEGVTA1m0OLm
 BCtr3VtXG941JXNzyRV+MH952HflDMErXQVqiolOI8uCeVUBVLoY7xTCXgMnK0FDJQAj
 dUtzKXv5rmhC+MiE6eJprLQB7/SIxOaT2p2SI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726007918; x=1726612718;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5SK2Eedqxd2iAIhXS2FUmtXfo3/fzxmy5NRGxfkLY3g=;
 b=JwTtFbncldb/6sCFWgXNxnyyUeqlorhHAHOWY+yY5oBbleS/63tajF6HHPihmNwhMi
 bZZcNodeebY/GR49MGzU9gpD49gkn31VHYTA04BfPHMDHzxdCBo+UzICTrdZRAUA7V/9
 7euBd8J6JzdKUYRpKLqFur1PwLdbJczGwSYvFw2i3ErQ3tthIv/QeoJS8GWjEwTmU2Tl
 jJBr53Cn90mFQZXdDn+/1eoobKtvbe2NeGAcvPtKpy9hb59c1YH1gnOcJ2aIlAto7aJf
 +Dlz2lvQP0LA/aF5XDSjyIILZoPLDieRtCn4MSv70DrJeinKUmfhndnH3O+0BAqd3B28
 tNGQ==
X-Gm-Message-State: AOJu0YwtXJNJeHfpyd5y4DhWLKUJ/AQago9t5CwQJyCuwhGaIIa0vaq+
 PFIcdMMF0ne4ZuNwAbBetG76Ozkwwkfi2t23MZNhZQBpQSvwJMB/uoBtHEnXcXw=
X-Google-Smtp-Source: AGHT+IGLUAmzb5Saiwfx/3eWejDjNW/hY1CHWdq2vHR8gbbZtE5nrj2bY2bQ/Tn2ZDO36rS18T68cQ==
X-Received: by 2002:a05:622a:181e:b0:458:40bf:7135 with SMTP id
 d75a77b69052e-45840bf72f2mr45978771cf.9.1726007917873; 
 Tue, 10 Sep 2024 15:38:37 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45822e63873sm34009611cf.7.2024.09.10.15.38.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 15:38:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Sean Anderson <seanga2@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240902132511.148683-1-jerome.forissier@linaro.org>
References: <20240902132511.148683-1-jerome.forissier@linaro.org>
Subject: Re: [PATCH] net: guard call to tftp_start() with
 IS_ENABLED(CONFIG_CMD_TFTPBOOT)
Message-Id: <172600791636.367866.758911439376584619.b4-ty@konsulko.com>
Date: Tue, 10 Sep 2024 16:38:36 -0600
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

On Mon, 02 Sep 2024 15:25:11 +0200, Jerome Forissier wrote:

> net_auto_load() cannot call tftp_start() if CONFIG_CMD_TFTPBOOT is
> disabled.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


