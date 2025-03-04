Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE86C282C6
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 04:42:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2C24812C8;
	Tue,  4 Mar 2025 05:41:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MI1yhi17";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7ED7781249; Tue,  4 Mar 2025 05:41:57 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FC7881249
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 05:41:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-6f6ae4846c7so45696677b3.1
 for <u-boot@lists.denx.de>; Mon, 03 Mar 2025 20:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741063314; x=1741668114; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RUsg2jxH9QX9RpNihJ6E7ws28c8HRf6mLbtcW4QdCEw=;
 b=MI1yhi17j7Brx06bTZn/V+oE7CHpWFI/B5TsA/W8LjD0MCPUU5aC2lxTmYfx+FcWs9
 kjtf98/HwARKqeYGPvHTBupBVTvHd7vVWDxTcoevJ800HKj1bXs/8sjDh7l3LBEAoPAJ
 lZuMOb4D4PpxvflEYEDTs6G/TrEtCHxIAhsEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741063314; x=1741668114;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RUsg2jxH9QX9RpNihJ6E7ws28c8HRf6mLbtcW4QdCEw=;
 b=lpUmqdz9g8bRgb0U8Fi59ji/yZXBc6xnqU+8ZR+4npTNA5TcjRUFymagQj1MYKHYwS
 8ZSZ0wj3YXJcGpacvLWzCqqjda/rZTitzxFSyEF78pxshqSR3S9Oikd2t2kIgAJyTYJS
 uAeX3iohzFJ5sohMw3vKgmh040GBsG9MLV3KnVjm9ERoMziGMsdT52Np2MG2sMYbSKmf
 9pXDBMyzScXzuUhSbJAebaRzhyMKB5482D7AIOXp2l4M6ChB80wHFsqi4Iu1dOyEyudW
 gG2CPRBqftqI9GBmWecU8w7A2oBSTgA71Vqam8rNAKDgSicWocxeHV4IRMDyCL5K2Sj2
 831A==
X-Gm-Message-State: AOJu0YyDUnbig91Xd17WqCObq0bd0Y9E9sum9lvjltzRvfc9KMxhQN4R
 X/bEnAN7KVScltfs1xUia498hFffGUiahiOLjfr4qFXoesf0QmTidQCFaa0JL4U=
X-Gm-Gg: ASbGncvYqJGgexunde2qGSKPJkrz1iDfBTwXP/FtZmXses6Bn4Q6B3GJ7bFA7JigmrD
 fU4lgbrXo0KZt0gpk1Kqo54Ed+mGcgAp5bK4rgbcWm90fYVeDQywTc8EyP5VEPUx31RdQEOrNDD
 xtjWZC2y1fQr0OBINt9elSJfB2gv2kYl1KyXtAVt3M176VmYmkZ9Fli88Je8YC1y2LqJ+9k6WKl
 Kj4NIz8c7Uf85m5AKY5u08r7lO43izwLXcUeqkTCuD/jgmjm3QfjsxhK8S5yNfmwYUgcT/KITEf
 QpmnkZeBzRjJ2l00gGmg9/AEbYqE/a3bO+B08wqM5A==
X-Google-Smtp-Source: AGHT+IGyrjsZa3IoSsorK+bzuD0g34QgLiFCBW6L9uKJA91J6tswpH5Kkh+Nx5S4ElxQNsZGtSjLmw==
X-Received: by 2002:a05:690c:2e13:b0:6fd:6748:928a with SMTP id
 00721157ae682-6fd674894ccmr81595107b3.29.1741063314128; 
 Mon, 03 Mar 2025 20:41:54 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6fd3ca60d57sm23182697b3.51.2025.03.03.20.41.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 20:41:53 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: sjg@chromium.org, alpernebiyasak@gmail.com, 
 Prasanth Babu Mantena <p-mantena@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, u-kumar1@ti.com, 
 n-francis@ti.com, vaishnav.a@ti.com, s-k6@ti.com
In-Reply-To: <20250220131827.1559137-1-p-mantena@ti.com>
References: <20250220131827.1559137-1-p-mantena@ti.com>
Subject: Re: [PATCH v2] dma: ti: k3-udma: Avoid Memory leak issues during
 dma memcpy
Message-Id: <174106331194.1753567.11650351662023883158.b4-ty@konsulko.com>
Date: Mon, 03 Mar 2025 22:41:51 -0600
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

On Thu, 20 Feb 2025 18:48:27 +0530, Prasanth Babu Mantena wrote:

> During dma memcpy, bcdma descriptor gets allocated for each
> transaction and not freed after completion of that transaction.
> So, avoid the memory allocation for every transaction.
> 
> Add one descriptor per dma device and allocate it once in
> resource setup. This descriptor can now be used for all
> dma memcpy transactions optimally.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


