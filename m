Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C901C3ABA0
	for <u-boot@archiver.kernel.org>; Sun, 15 Sep 2024 15:47:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7123E88DED;
	Sun, 15 Sep 2024 17:47:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Wi6wgIh6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2DF588DDA; Sun, 15 Sep 2024 17:47:44 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE5B088651
 for <u-boot@lists.denx.de>; Sun, 15 Sep 2024 17:47:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6c35b72f943so31259446d6.0
 for <u-boot@lists.denx.de>; Sun, 15 Sep 2024 08:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726415262; x=1727020062; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ps9ES8v+Fg5VTeUI8oWWZYu3FY9fmPyERl/e09iRcRY=;
 b=Wi6wgIh68Crmg70VFRkHD4vOTXHl8+JEjAsL2rXONuNhpA7g09ysE9kHIOeCSu3AEt
 1T2RQxhXMvZ8+TPzZ3Ri4ar8ojANbVuh78ZP+UlbIwPMkcwH/Ero0QrT6zRyAE4Yq04T
 ZAvS++bE29/IkMGqdaCaPOzybUQuNpBD5kXEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726415262; x=1727020062;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ps9ES8v+Fg5VTeUI8oWWZYu3FY9fmPyERl/e09iRcRY=;
 b=Khhzt1Sx7SSL8n+XA06SDhJv8NTrPssQdulgVtmoIzafy+XAaORLOpSEcvrTFOwV9b
 EBq4A1Lgnh87h0GK/Cr4ahOOr2vXXvrwUQ/9vpzxgQPp4sAdNcKtCHcVDROx5nCI34Zx
 SFlQhZPtkavLOFrTJMcSn3RfQ+F9CX20zdkmAFUD2x4afqCAPmdQOjmu+L26QV8uG1QU
 GULmgth6FX0v3d7+buc4HP3fWNS5eYngEKQHgeTUIaUzqu/4JZx9AmTONnUZFubvcF+i
 HN5ZOqmbu1PLVh7IVtS6baPqxW0aDtyCDe415mgUoSBkUMG7Ir2tWlS3qYteauBl5+2z
 4ykA==
X-Gm-Message-State: AOJu0YzGY+YUZ7JfVCkFLLtglEzJ5g32Qd61NarE8RMkA8DKJe88Xqj/
 Is/CBJ8+Se/S9wIoB0kUtqY4zdYG/16eEfXKwHjG15+StJoouUtW6473W/AHoi3jJHebwGJp91m
 rkAU=
X-Google-Smtp-Source: AGHT+IGiLgcS207MHd7jEQA32mLyIVd19FWBHlnHuuPiaJCsEz3UV+Cpb5TW+O0TGq5ygIFmQyHelA==
X-Received: by 2002:a05:6214:4697:b0:6c3:61c3:5d47 with SMTP id
 6a1803df08f44-6c573b20da2mr252787986d6.17.1726415261202; 
 Sun, 15 Sep 2024 08:47:41 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c58c629557sm16435396d6.24.2024.09.15.08.47.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2024 08:47:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Francis Laniel <francis.laniel@amarulasolutions.com>
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
In-Reply-To: <20240903170944.98747-1-francis.laniel@amarulasolutions.com>
References: <20240903170944.98747-1-francis.laniel@amarulasolutions.com>
Subject: Re: [PATCH 0/2] Bump new hush commits and fix old hush test behavior
Message-Id: <172641525963.1836849.11494102379702567949.b4-ty@konsulko.com>
Date: Sun, 15 Sep 2024 09:47:39 -0600
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

On Tue, 03 Sep 2024 19:09:41 +0200, Francis Laniel wrote:

> With this series, I bumped the new hush to get the latest commits from upstream.
> 
> Also, I added back a reverted commit which goal was to fix a bad behavior in
> old hush test.
> I had to tweak a bit this commit, but everything worked both locally and in the
> CI [1].
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


