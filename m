Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04055D74945
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 22:28:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5182891A3;
	Tue, 29 Oct 2024 23:28:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IVFXsWZU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF70987BF4; Tue, 29 Oct 2024 23:28:23 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCF25891AA
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 23:28:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7b14443a71eso569227485a.1
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 15:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730240901; x=1730845701; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pgr9f4ALeFgWBn/9lZyGFmJLwfnEnZ0+x4jzNi93hb4=;
 b=IVFXsWZUFL4N8cCYw53v5ywGfozpukXa3/8SLaxtaAZVruOVeN0puSPWQe8KpZg7oV
 RG4vmMvQ0/zKOH7v7t9crukMGs3/DdfNInzWPAwh1gke07+z/xhdqYWgVzHQaOgpcSPC
 yTbmxjX5WKDSxdGcAh/1D6v4/q/nmEQmUFQok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730240901; x=1730845701;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pgr9f4ALeFgWBn/9lZyGFmJLwfnEnZ0+x4jzNi93hb4=;
 b=gO3IX6a8Y9h7lKZqHPINOhCOt6oeda8Kh6FYcteHzolNduqnxAydC44qco6rovp226
 CMLpd9XjBMyMCVXjlf8kXVwZH6rLzHQ3e3SFuS1pc/b0+o4pWZURwKc+ZXtqFBNB+BuD
 d+dVMnyCJn5rzP8frMhXKa8b5tW4TasxE1mTf+u1W/7ywImKwohxpjYhNFkputHfrXqx
 6MN3Gp7qIwkBf54V4/7B+GgeMc4Bwy1tScDxQn2cJKXNiDWumJJkEECC8xOO77Hhqc5n
 08IVajjcArvl7f2lToSY5IAzWpFgm0O1xdsIywShPs9s/brhuU/hhaN6usfq9GyvpI/t
 xMIg==
X-Gm-Message-State: AOJu0Yz+lNuWmFn1seZclhMhhYlF01Sf909aBXC62mKOYUg5Xc5SFjp8
 Xt7JOqPShYwX78y0VgvrZFJ678ncSuy+VD6NrQhTwrn9L28ZbVPpAhu4KafQf47kVw5nYFD8Qy5
 fzwQ=
X-Google-Smtp-Source: AGHT+IEB/n00oWRaTQdeiZXLcIwtEPXnJCa4g2SLO3E4DfKZGXCtllHATtQkR/ljIaw1dCPeA90wkA==
X-Received: by 2002:a05:620a:2406:b0:7a9:acf4:36bc with SMTP id
 af79cd13be357-7b193ed6f17mr1892090685a.3.1730240900751; 
 Tue, 29 Oct 2024 15:28:20 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d3480d7sm459351285a.123.2024.10.29.15.28.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 15:28:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <20241021172433.637950-1-sughosh.ganu@linaro.org>
References: <20241021172433.637950-1-sughosh.ganu@linaro.org>
Subject: Re: [PATCH] fdt: lmb: add reserved regions as no-overwrite
Message-Id: <173024089898.2563570.12206300030785963890.b4-ty@konsulko.com>
Date: Tue, 29 Oct 2024 16:28:18 -0600
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

On Mon, 21 Oct 2024 22:54:33 +0530, Sughosh Ganu wrote:

> The boot_fdt_add_mem_rsv_regions() function reserves the memreserve and
> reserved-memory regions. These regions are being set with the LMB_NONE
> flag which allows overwriting and re-using the regions. This was fine
> earlier when the LMB memory map was local and not enforced
> globally. But that is no longer the case. Mark these regions as
> LMB_NOOVERWRITE so that they cannot be used.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


