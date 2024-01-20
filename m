Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8433FC47258
	for <u-boot@archiver.kernel.org>; Sat, 20 Jan 2024 21:04:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D22687447;
	Sat, 20 Jan 2024 22:04:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mDGGh3/l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 594F687073; Sat, 20 Jan 2024 22:04:14 +0100 (CET)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C952087447
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 22:04:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-dc22ae44595so1729162276.1
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 13:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705784649; x=1706389449; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l/XOr0GD8seceViC42BgyAki/JEGlbO/J+h/wiRQ4Yc=;
 b=mDGGh3/lO64PhTUE1Azbfa2MnuFx4JYui256MZyvx8uWIPEeLLKdsSgxybM1x/3eZT
 lrmJuOszAhR/kkBeTYI2hXcPnnx+1Kgo+acwRdOWPkjnFUoalRMeMn5HhVWAJ24bBKTW
 TkAl/+uYKXpqQ1NpXyY9STY3T/1XsBRLSeStw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705784649; x=1706389449;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l/XOr0GD8seceViC42BgyAki/JEGlbO/J+h/wiRQ4Yc=;
 b=qJcgixPk/ZRr/u3ZLepQbWdW5kkLS/Jo4VPFZX0zWpLTso1Zvk/B9RDFJ6X9GKM6uY
 jX63StVpf/k6DK4bOlPqCwBCBo1LvWHS8HvdUGT4lINs5jyKzM37h4DUBTM0UY0z3yaT
 ryWlsfJjxLFXN6KN5DTkwjmnmhqS7ppj6W4+EWeGkMqSKkiI5QyRcrD+kSt38rIr4cs/
 l6YzKsKB980gMi9RmQepT8ZNJjyfB3nKQuFaMCgDHs+1SQmSnTeXCSNVZJJ3OZFQZ5O2
 cdUMzkGdXmU7DBnsvkiNrS8qI4r6RRpDerey9Y0rIpPkeGKUPbSXyr5LB1It7Cf4ELHE
 VtbQ==
X-Gm-Message-State: AOJu0YwJSAHNXaMRy+WFgN0x6eQykuszZy8UOXR4D/sSaqmoMsGNoIWx
 xmxem3Om7wN+8FR6Jaixs1LvSbVhazxj01U1SMzk3H2qZqOldrmUk9c3Z6hsEfU=
X-Google-Smtp-Source: AGHT+IEgp1U2z5kfX5zOgs3rftlJ8t9e+KrPFNUpsBhsLv7QqrhkSfr0CFf3tWTnZ0N1OcMF6MGqQw==
X-Received: by 2002:a81:4e86:0:b0:5ff:9d3d:290a with SMTP id
 c128-20020a814e86000000b005ff9d3d290amr1192765ywb.56.1705784649383; 
 Sat, 20 Jan 2024 13:04:09 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 l85-20020a815758000000b005ff821bfdd3sm2390414ywb.27.2024.01.20.13.04.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jan 2024 13:04:08 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: nm@ti.com, robertcnelson@gmail.com, marex@denx.de, 
 Roger Quadros <rogerq@kernel.org>
Cc: n-francis@ti.com, praneeth@ti.com, s-vadapalli@ti.com, 
 r-gunasekaran@ti.com, srk@ti.com, vigneshr@ti.com, u-boot@lists.denx.de
In-Reply-To: <20240112124951.238098-1-rogerq@kernel.org>
References: <20240112124951.238098-1-rogerq@kernel.org>
Subject: Re: [PATCH 0/5] k3-j721e: beagleboneai: Fix USB
Message-Id: <170578464815.3836582.4299053911769160839.b4-ty@konsulko.com>
Date: Sat, 20 Jan 2024 16:04:08 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

On Fri, 12 Jan 2024 14:49:46 +0200, Roger Quadros wrote:

> This series fixes USB operation on k3-j721e based boards.
> 
> CI testing: https://github.com/u-boot/u-boot/pull/468
> 
> cheers,
> -roger
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


