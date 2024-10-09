Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C67B9CEDD89
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 13:13:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 097A2891CF;
	Wed,  9 Oct 2024 15:13:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="DpogOwa8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB72389159; Wed,  9 Oct 2024 10:22:40 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E256388FE4
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 10:22:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2fad100dd9fso94535421fa.3
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 01:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1728462157; x=1729066957;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=1qKXL4JSmylvtLvGlW/rsV0ew5kQgo3RZFid1IMFm3Q=;
 b=DpogOwa8fiorZ1fdBS9UEC7O38XBm/YBEv0quaqpM3z/Cn3Sa4pRubFFRKprJv9Dt4
 QZAQCeMelApYWZyCyXGbU8S5aXpW6xxkzjxJRxLdtkmNQ2hEnJFmXPkinLHL8J5tEw/n
 hMUjkP6H4EBuosANbOVV0YywrMndLHPmTwaP+cUacEF1mmwKrVXriyXVPr/dCctmYynW
 qwpJbITXLi7u+2MXmFQWP10pDjH+mCEz/kYTaSihEEMqr5Go2q7uESSmFttVUBrTYvjA
 4Nb+6WQD+mEfkXPTcdaPJhQ87Kw27UyiV5w/KxFKzBCilP9SXK6imJzv/3j49eRMq6OO
 9arw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728462157; x=1729066957;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1qKXL4JSmylvtLvGlW/rsV0ew5kQgo3RZFid1IMFm3Q=;
 b=B5oI3hseIrIkxN/1QJgE1S0PiFHFqJZ5IELUCs+ciAoVHyqADbFlImwkU76k8Qyhjx
 qMo9F6BBmXWq7rT+ktzBBUSiDaUu9PAoiKib5K3qiimlZhzfPzBkWnl9cCPM5jFIrznX
 yhQiCyr7js1AXRs3r1AbimTw/dhYrRdS3B0GEklkno3DAdNzQpfuEXHZcuOnmnTbqnfs
 Hr1sfKKv//fQSuz42tA2PkVdY8XfhC/zDqCqgHYCC5fuNkCbADKX68ZLqKF0kaMVVe+S
 9AbH4SlmTzU5yqPyXyWX5UWwHLksnRirpydJR+g9s6+BPZ1SDFyrBvw5wAHPJWk94HRA
 tShw==
X-Gm-Message-State: AOJu0YzsckZLtsejgS3xtkn0q2SB2ko9wEXaTPPzTR0FGjkGdjkYfFy0
 tMOlB9wJohHgNWsMbivyEJrLpHHUU7MI0Rb8H6tjs9eVmO9ShkOBls+ga50UKiGSqqJ73+NYUQ2
 B1GcVM+kb5vfND8MzuDxWddttTuXdykQcMp0DLw==
X-Google-Smtp-Source: AGHT+IEGGtkNZleV5b0aI862FTMU+/Z5ccZMSoSUu0PcT50xOhHD+py+wu9OojKgZjBQxDZ2hHBGIlmnvO+cms4ax20=
X-Received: by 2002:a05:651c:222a:b0:2f0:27da:6864 with SMTP id
 38308e7fff4ca-2fb1873ceadmr13050611fa.17.1728462157164; Wed, 09 Oct 2024
 01:22:37 -0700 (PDT)
MIME-Version: 1.0
From: Zixun LI <admin@hifiphile.com>
Date: Wed, 9 Oct 2024 10:22:26 +0200
Message-ID: <CA+GyqeZvs8eoS5XphbC6JvdESRBWB3v8OaNzr7M5k7PEVP3Qew@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: nand: raw: atmel: Use ONFI ECC params if available
To: Alexander Dahl <ada@thorsis.com>,
 Eugen Hristev <eugen.hristev@collabora.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 09 Oct 2024 15:13:35 +0200
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

Hi, sorry to bother, it seems like the patch is not picked up yet ?

Zixun
