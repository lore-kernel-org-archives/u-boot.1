Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E9EE63CBF
	for <u-boot@archiver.kernel.org>; Sun, 25 Jan 2026 19:44:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95D3383D6C;
	Sun, 25 Jan 2026 20:44:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eeFpZtHp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F7D983CF3; Sun, 25 Jan 2026 20:43:56 +0100 (CET)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A668F83D07
 for <u-boot@lists.denx.de>; Sun, 25 Jan 2026 20:43:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-6610b45598fso1730718eaf.3
 for <u-boot@lists.denx.de>; Sun, 25 Jan 2026 11:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769370232; x=1769975032; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=r/sOH/uf1NTPVKyGZM3YzPAGbvm02zepZVuOiddLWOA=;
 b=eeFpZtHpk5t0h1Uk8+wKNwV/tx1/bgRM3mL5wcJtDN263uLv3NV6jzxa+5SOITJ3Xq
 +K+WJ8a4v5EB6mVOy/gmvxh2ZLotDyMx0dzLz6G7HGj/wKaQJDW6/xEBaV3YUrIJp4xg
 uttOPWZpUBLZIeXXcKw+yEXEkUNqmF40dh+Bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769370232; x=1769975032;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=r/sOH/uf1NTPVKyGZM3YzPAGbvm02zepZVuOiddLWOA=;
 b=ntIKd+EVCKwq5WvHBuBaXN7NnYos1kw1LMinUSJRW+eQ65zceV9TPhldsA0zp5Y5wZ
 UNCF4QyynEF+22BNCipXsDmSYwV1N3ALhIqGQ/KqKt6wc92GJ/J6CaMzWFjAibN4fZVc
 khFWBSyZNh4oSgM3NvmiclRppcNNdhAS88ABXpZO1HTwt/KMIT5x/3CzgPOUqIaKp5sM
 BGtUKNMds1mwJi+1Zsy09H7UFHA0gxRZOahuXQR9GLQffNYCJUEo2Eq1Lb7GODgE5F+i
 ng/usZUN4O7kfOXzKeQWpQVvo9+SW5C+n5PceFpUqpZ0ZRG4KjUKDSld7nPVp/IzPJIq
 7iVw==
X-Gm-Message-State: AOJu0Yy/gCkTs854siLpxwkTyJEnetQbfx3DwuPAjgEQi9PN8mWU9Q5O
 ht8U+GwI2rVBnrAkFACAezY6y1HhLI5sSTl0/gUUuYRbMowFka5PVpxk4J+BYDxGVhZ1ZWeeUrd
 RE2SAuYQ=
X-Gm-Gg: AZuq6aISWU+psfY99cwP/triBmriTIGAP/Yr4Z3rj64rYrN1A7FaqAYLA92V3ZZ1Jqu
 LR5RdJQ+6yg0sEWtzCHMP33WG0XHHhZBwUeWOqTZ1oqdGiNVeSgEckx8TEl+a07Mg4DSdNMJgZ3
 rjW7Edl3wkuIegK9LjbZBnnPmoXFjN5sD9sgzH6g4m5QkT5u00PLioosytKrvXMzdwV3NwSt/XI
 NDbDjq8x92/HwFLppb7seAv0kZE9E5V4/9HXYSvPoyzWoOk5EBwITHQQhrQKtJksNhPlZ90UtLr
 35K9O6/RybfnOEYQQ7QiV5OjYDilLh09tli/Qmdg0pT2rBKUWfJUe6i4bRznyEe0F6/kZV7SvGT
 qssmdI4NjvrErzVzr7VSJSFeaSJA6Z+l3FbHdgCtSxFL2hKkzyEENttHUmZA7My/mpqmxYMEGSX
 RlW+198+Y8qB2SVxihRAUnSloVUTOrDDEu0bqZgwlic4+HmE6KrSTZ5KGvEZWhdS3Okrst6YOYe
 0FI1w6Cg5FuSgxdchI9TxqDgjoIl/AvdsMG0OuRDxzKYlIJ
X-Received: by 2002:a05:6820:1625:b0:65d:c8e:840a with SMTP id
 006d021491bc7-662e049dbdemr1362613eaf.65.1769370232465; 
 Sun, 25 Jan 2026 11:43:52 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-662cb4e5a33sm4100544eaf.2.2026.01.25.11.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jan 2026 11:43:51 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260125162626.529902-1-marek.vasut+renesas@mailbox.org>
References: <20260125162626.529902-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PULL] u-boot-sh/master
Message-Id: <176937023140.3566385.13033135902279207008.b4-ty@konsulko.com>
Date: Sun, 25 Jan 2026 13:43:51 -0600
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

On Sun, 25 Jan 2026 17:26:13 +0100, Marek Vasut wrote:

> The following changes since commit 8de6e8f8a076d2c9b6d38d8563db135c167077ec:
> 
>   Merge patch series "sc5xx: Add complete board support for all ADI SC5xx boards" (2026-01-23 14:55:32 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-sh.git master
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


