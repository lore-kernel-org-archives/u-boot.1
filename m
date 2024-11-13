Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB916D637A3
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 17:41:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8573889349;
	Wed, 13 Nov 2024 18:40:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EgWwf68o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7443289349; Wed, 13 Nov 2024 18:40:46 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C4E6891E3
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 18:40:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3e60fca5350so4114120b6e.2
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 09:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731519643; x=1732124443; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yE0Ez7rbXDQGPxK9D5po79QIvnF1JQ2JLVp9qil0R20=;
 b=EgWwf68opM+pjwHP5BFYHBN6GavcA/VtBPov7YckLEI94kHrD2SfotpYIIddj1HWvq
 2xnqfExR+lFZZuhrKrqgyC9OaGYO12BGJM1ygyz2YVgRzipPFQJfee73Ajil4J2tONfx
 u4SpuVcEdy+o1Ss4kLXA8ZVruu844as4+TvTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731519643; x=1732124443;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yE0Ez7rbXDQGPxK9D5po79QIvnF1JQ2JLVp9qil0R20=;
 b=jUwGwNKtxouUEKfISuDIqQ6sLKUsXJ9oN0cumxhjRR5ICZEGxYKmQ2/pLt8P5WY9Q5
 0KDDldNjujBnZoVgFUF/1QHQ54XEz2WoxanmLQOX7owgBbnSx2W603QY/BrRgZn9W7oE
 DOuqkwlDswSzkl6HkE4CnD0lX3QKL6Ho38M2xyFLX2LAsNKVl1XcCLuMwa6mhEl/tvQM
 TvJhJyUsvnAi3y9uFI2JKdRtONaa3krmIXhA9Go0GV3FFk+Rf/Y+Q8NhXJL5eaFSTwSZ
 YElTupPR9oZmw+a87Jp4FrT/jaznuWZkZiYp2d47kQrBVHq9JZmm+sCda2Zso3hdyruu
 Gezw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGH73/nvLKX00b05nPr3bFZMkXoWvN/LhK5/SAvBMghavGVzjE74SNjpApKHzmAocFyPmVGXY=@lists.denx.de
X-Gm-Message-State: AOJu0YxtPkHANml2Zq9h7wfqTdjK4fIn6nhP2ZdnT6DsB6jZslSbtls1
 eo788SQtjUfVBKtXzyJkr4Vw6FauE3NvJISDOlpVUoZcWtgt8faouBTCuBavhGF+MrVeaQm+tpe
 I7LQ=
X-Google-Smtp-Source: AGHT+IGmlBw8uA/wctkmsPJk8IWoLl1t206/5/gm9d66YYug3L2BiByCitD+LwCdTZo8TW/QXY/NOg==
X-Received: by 2002:a05:6808:1306:b0:3e5:ef2d:f53b with SMTP id
 5614622812f47-3e79469e376mr18759076b6e.11.1731519641712; 
 Wed, 13 Nov 2024 09:40:41 -0800 (PST)
Received: from [127.0.1.1] ([145.14.135.248]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3e7b096bdabsm736295b6e.21.2024.11.13.09.40.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 09:40:40 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de
In-Reply-To: <20241103175400.155790-1-heinrich.schuchardt@canonical.com>
References: <20241103175400.155790-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] test: run longjmp() test only on supported
 architectures
Message-Id: <173151964007.1299521.17990850922676630128.b4-ty@konsulko.com>
Date: Wed, 13 Nov 2024 11:40:40 -0600
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

On Sun, 03 Nov 2024 18:54:00 +0100, Heinrich Schuchardt wrote:

> We have only implemented longjmp() on the EFI architectures.
> 
> Define a symbol CONFIG_HAVE_SETJMP and have it selected by the relevant
> architectures.
> 
> Use CONFIG_HAVE_SETJMP to decide if the longjmp test shall be built.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


