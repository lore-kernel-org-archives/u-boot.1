Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B16C282C6
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 20:23:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67105810EB;
	Fri, 28 Feb 2025 21:23:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="awZuXn+t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B8C28110C; Fri, 28 Feb 2025 21:23:35 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7E23809A5
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 21:23:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22385253e2bso491715ad.1
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 12:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740774211; x=1741379011; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RUsg2jxH9QX9RpNihJ6E7ws28c8HRf6mLbtcW4QdCEw=;
 b=awZuXn+tgwcsWAV8yBfri6jTFWzOzZ6j53asfE7HHMN8YVO1fsq8VgtOCfIKsb6ZDK
 rf3lSU8XK3ACE0yL8/S0n6xVF5k4oClsQifEsjtP6TZgrUqNnakr9GkYjy/lJFjPh2tH
 ckhjLD6BSlfi2Aj10NK4Z5tnrDpf1iKOtOofM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740774211; x=1741379011;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RUsg2jxH9QX9RpNihJ6E7ws28c8HRf6mLbtcW4QdCEw=;
 b=bfdgJEZ+WDCDP1Mb/tJkTjIz9DNgCy18Yw5Yzh5DxVi1M82ot9bcNmF9+Ar0oQUOlH
 9WDmSG6bqXAclS9KC0s9n+NUDku6F+0yx/go8ogP1xWX2oSDw0dCuKRRyLLngvdllmkz
 sYt9aLRKHBF1qJ1G9TSTXsT9g6TS4dJLTJKiQ8toWKGtSduA3XTcQAas0PFgjcKDWN8i
 ho4Gk79Tj1zVpR63GYqC7GsQl3ipYEnFBLZyH1xNNN4caD9O4YoRfLA8Wdc51sAALcVn
 CL0jh94TbKCxH7Sk76auTLxW1RQSRYQFStS+yKAjYScs82zUAjfvJwFjxZ/CSmYR5F1p
 pyZA==
X-Gm-Message-State: AOJu0YxzN2aLZR/vsZBDYGKmgFC6IRcd6rCPFaXlwwNTmmjatKiiRP25
 Bxa9f2Sl4eYolZ8RoPyFi/bbsvm0+4GSd2eWg0i3esABQ13TOFFtZvDH7xJkEWY=
X-Gm-Gg: ASbGncsa+Qx17dcc7E9smk6xW8zE/gKFzfVCcUKLKU5h4VecH4JbdcxVZ+EdAwrbOYK
 BlP2GYydPxotUcpB8Ovsz/UlaWH1DlquWuKe68FFASu2FZ2OqXx4uJWZGOYlm9e2UVCd0SKt+jc
 2wVvTS/N3jhpFUlpnhGsZxu7Gs7uGstz/g7WNNIjMuRUis1rEOjlgltRdz+4YVqeqRK4GekktqD
 YIzo/m7IG0BFX0V5FR+/82CZ33ocyBpkTybKSAraB6XBRHHPfpKlozPFShQFQxTFTovOZpGfdTE
 e6c5mUZiooO5RzjHQlYzTIc=
X-Google-Smtp-Source: AGHT+IHVQJR6Eu6vtjozTj8Zifur0yu+MYBmgZ2+hUt7LjeGEll+sa2SBks9Ncfw+Pe7lBb+Np5IDg==
X-Received: by 2002:a17:903:1252:b0:223:26da:4b6f with SMTP id
 d9443c01a7336-22368f74891mr81796515ad.14.1740774211329; 
 Fri, 28 Feb 2025 12:23:31 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-734a003dd19sm4288337b3a.131.2025.02.28.12.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 12:23:30 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: sjg@chromium.org, alpernebiyasak@gmail.com, 
 Prasanth Babu Mantena <p-mantena@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, u-kumar1@ti.com, 
 n-francis@ti.com, vaishnav.a@ti.com, s-k6@ti.com
In-Reply-To: <20250220131827.1559137-1-p-mantena@ti.com>
References: <20250220131827.1559137-1-p-mantena@ti.com>
Subject: Re: [PATCH v2] dma: ti: k3-udma: Avoid Memory leak issues during
 dma memcpy
Message-Id: <174077420983.1188562.84442717480501852.b4-ty@konsulko.com>
Date: Fri, 28 Feb 2025 14:23:29 -0600
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


