Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE301C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 20:39:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E4A080AE5;
	Mon, 10 Feb 2025 21:39:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G7gHhF5v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A268180BAA; Mon, 10 Feb 2025 21:38:55 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AAD880815
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 21:38:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-6fb0200b193so10810077b3.0
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 12:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739219932; x=1739824732; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+/o12i7VxBndzfEB4apBrpddzHtYX26wgy9N1jb+Lc0=;
 b=G7gHhF5vIciN8S7LgQ2ouj8Ozbnvg3LXQFK4jfMHWSHKMiBaXME4LLl+bSP+4aC9Pt
 hmM/rXmqf1+INB3/kAC8P3qJWDiriFz2v1TVlaRW13MsilVUL87G/xmnTA2j3ZFX5cp5
 ovwWfzfa2+scI1hCnSw7NmwleptoMxV4T6Ka0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739219932; x=1739824732;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+/o12i7VxBndzfEB4apBrpddzHtYX26wgy9N1jb+Lc0=;
 b=Hrkqz5npYoBQ4GikxHCWXXXuObz/zvoNWFGU/gyN9vyzY8IGrHf9SYDGItuTRHIQBx
 nVNttD4fshbmLytQXwuYmSCaJf8ZyKyAT41oJZXH9xKlr7T5M0inV55TJGnHjX3mjvcY
 Q/zc73YyzCsvmUIrniw5IOcje5uS/gqI4oZUUJknp/8y7OCDXRFzAcIwOzw8FF1nNpNm
 jotYTcEs0nfL7F8btZCcI+i22DtjhR2ZoZeWPpOvTbdei/8LqQygRXZjbUcXRS6YP3Jz
 lPmV7o4lMLv1xFAfTBpIjfzbzscOJKAn/x1tN9Idlzomdryx33HSaugeuCG0P12Snlpi
 jx2A==
X-Gm-Message-State: AOJu0YzUgtN06ZivKK04jD7oznxzMRvtwJammFYeJpw1Pe6WCq+Np//g
 LQnUK/lIn5DlxCWOA4krj7HzPzkdANTNfldEzgqM22xksf6JYoTtmUUmJhsTgZg=
X-Gm-Gg: ASbGncuyW7br3UFgJCzxI9LnBzDogAtXha5zq2YXH/gbcrcsbeKnrEsn6Fy3QmmX3m7
 uNyrYoOaR8AXnMltC5DHIaooXEr+HDlN6V9DXpLlgsxr7nHLGqpzQh8S3QS7+DukO4HVYYxODnT
 K48hYuCvK4leGGBXxZzduteGL5Fgzn8Jqj32Pkz9TI+08ael3iuAuDaec6vxl2p94LajPSFNrum
 TV0MKW0Enn2lScuRn/d3dt674g4XLiKmBjJSl1QwyeLZftBLXRR6q3MkiUyBtTC1aZWALnt0XA3
 hC5FhSO5s0KKsA==
X-Google-Smtp-Source: AGHT+IEyKMOkTrg0L+8RePLxatcph6ByReONyDACewULxQFlRhDICwBf7iXBD7S6ZCx7qe1AV599lA==
X-Received: by 2002:a05:690c:4a0e:b0:6ef:60f4:3d41 with SMTP id
 00721157ae682-6f9b28783b3mr138441877b3.16.1739219932050; 
 Mon, 10 Feb 2025 12:38:52 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f99ff6a8d8sm18233207b3.79.2025.02.10.12.38.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 12:38:51 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: a-limaye@ti.com, n-francis@ti.com, s-k6@ti.com, a-dutta@ti.com, 
 vaishnav.a@ti.com, j-humphreys@ti.com, p-mantena@ti.com, sjg@chromium.org, 
 Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: u-boot@lists.denx.de, srk@ti.com
In-Reply-To: <20250201091809.1894892-1-s-vadapalli@ti.com>
References: <20250201091809.1894892-1-s-vadapalli@ti.com>
Subject: Re: [PATCH v2 0/2] FIX: Re-enable MUX_MMIO on J721E/J7200
Message-Id: <173921993060.2921783.8356168468002986125.b4-ty@konsulko.com>
Date: Mon, 10 Feb 2025 14:38:50 -0600
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

On Sat, 01 Feb 2025 14:47:58 +0530, Siddharth Vadapalli wrote:

> This series re-enables MUX_MMIO at U-Boot proper on J721E and J7200
> SoCs. The commits which introduced support for Hyperflash boot on both
> of these SoCs disabled MUX_MMIO functionality at U-Boot proper, thereby
> introducing a regression.
> 
> Series is based on commit
> 2b1c8d3b2d cmd: Fix Kconfig coding style
> of the master branch of U-Boot.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


