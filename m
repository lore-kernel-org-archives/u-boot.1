Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3631CCF9E3
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 18:39:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD69983E23;
	Fri,  7 Nov 2025 19:39:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cMz3f68P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFDE083E16; Fri,  7 Nov 2025 19:39:19 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0DC483D8B
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 19:39:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-44fe4c3c19cso376688b6e.3
 for <u-boot@lists.denx.de>; Fri, 07 Nov 2025 10:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762540757; x=1763145557; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n2DjD6wIhJhTQ6Z3ItimSp0D4PMebFl4+YQo/Q08mjw=;
 b=cMz3f68PBwDwhVgWZgxZKdH56ql1cEthUExVLMULs/Q0sEDgcp82hc1bLz+TUWHxFz
 l2IZBx+ta4dAkHejxrq119KSFV8vz6jvkiRl1mnKuBhSwMEbiYFgnZJtmz4iBzRwUL8X
 NBFOg4BN0b/1dRDkDJEoLTYQskQSJ4As+pghk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762540757; x=1763145557;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n2DjD6wIhJhTQ6Z3ItimSp0D4PMebFl4+YQo/Q08mjw=;
 b=KOdYMb4IvlUBK71Sov1+oTY/O/8VSti/Ie+zc+vaQvDUiLSxAApZnLWjE1V5xlCYHr
 F8cGZiYgU5jgZ4fbuBRXAn5p16cnSV1acAsY3aguq30TFt4aYjtpkp9oxdTWNRddNp+H
 fIeB2arUYSiDkHrQXK1ecoTIx7dLwiwX0W7mbVUz5l+ecPaw/lh9JItkyRduaPDTn9nF
 E4+2zQVP13kEbt34F3D7fppv6fe+RbPTuB8vmFd9TTb3+tMbiPRocIylvD+CWJyGykF1
 KCq/yxiCad7FmOAyUhAQ8z+cV9bckXdlLJYxC2eozWU7vs0jthyENAPdQW/5xoMdkIdO
 m+0w==
X-Gm-Message-State: AOJu0Yx7b+araoNBas3xQSMcoA2p/Uorj/XYdijc7h1iJyHOPu0NIYf1
 q+n3bfxp51r/aLK0WB9LLMVuujErL5U2YPkObRKS9AeqcjsYaeE4L3VSVOrF05jUKSE=
X-Gm-Gg: ASbGncvVBad/tGPCbXCpbmvUKH6Qb6TEelb4hohx04K9TVs4bwt/yzA2PboWgOir9CS
 qbz6/iBnq5NEr62cm4NjDkKiuia9zlWIexMAARAEJh2/THlDFElY9x++kMVFe6FoSQc+kpNEWj9
 dw5F1xlxhy3W8whn9AH6XRmb/EFPMEAEXmZLJIOqOEvzPzWqj+LoHg4TdcaYqyjjCyXdD8Z0xGM
 H7agPmUJdxS8fohfsxCvypUf557LbINHwYgwuoMWLAc/HeSDZz58iIdHMEZ1lXQQRY17KcqChen
 FUFuQQQ+40CzUpuOJdJbHngKp0DJGf2caobNNl3jUqi2+AszzCDEjwNU2nDN0KvAl7UW8XAOb5h
 gQBvH6qvowY+EaoGRtfMhpCE28eGqywFXmO3cc5cXUlliyYXVXhzdlDGojQ+LIe5oWNZ3Jx7zBE
 MDYEb3TldKooQGzcFDvOj+1LnoDTvtEopy4wE/nw==
X-Google-Smtp-Source: AGHT+IEA2h7FzU3UxmH2wM01KLvMYFugHOJOCn3BIJ1JqD4ENByafEx5L6m2RaB3JNzbiYmr6QPKEA==
X-Received: by 2002:a05:6808:6a95:b0:43f:5e4b:42ae with SMTP id
 5614622812f47-4502a1b090cmr159279b6e.17.1762540756629; 
 Fri, 07 Nov 2025 10:39:16 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-450027e19e6sm2587642b6e.21.2025.11.07.10.39.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 10:39:16 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Lukasz Majewski <lukma@denx.de>, Nicolas Belin <nbelin@baylibre.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>
In-Reply-To: <87ikfm9dp7.fsf@kernel.org>
References: <87ikfm9dp7.fsf@kernel.org>
Subject: Re: [GIT PULL] Please pull u-boot-dfu-20251107 into master
Message-Id: <176254075565.1989038.794245400181412723.b4-ty@konsulko.com>
Date: Fri, 07 Nov 2025 12:39:15 -0600
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

On Fri, 07 Nov 2025 14:25:56 +0100, Mattijs Korpershoek wrote:

> Here is a PR for master
> 
> Android:
> * Add bootargs environment to kernel commandline
> 
> DFU:
> * Support DFU over PCIe in SPL
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


