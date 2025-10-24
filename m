Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8DCDCCD1BF
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 19:55:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E39983857;
	Fri, 24 Oct 2025 21:55:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WePjQJNd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DAF483885; Fri, 24 Oct 2025 21:55:11 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BDA483677
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 21:55:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-44d9eca1d57so115136b6e.1
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 12:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761335708; x=1761940508; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ypSQNP8ifRUxCRCC+duFyf6wr59zd6jpCPOQAB/QsbU=;
 b=WePjQJNd5e9I8K3ol4gZ0P2+ZrDuEYbanBdN78KbfNo9KGyDw8L5upTRQm5atGO4X3
 I2ZpeB/saLfpt4cbXalU+krrDDqvGD7RNn7hQmMTlivMAwvd9dD0XMZLlW8qoefxKUti
 9o6SpyW5CO5iuzvSFpJMk9eQ1La60ej5lhLgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761335708; x=1761940508;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ypSQNP8ifRUxCRCC+duFyf6wr59zd6jpCPOQAB/QsbU=;
 b=U1XARZ6wyxc1aEsjDre4nrceewu0G574BRoGca3EPhokqGAyJlS6+40X0Uom7XqK4O
 DK1ojhy+cn6q9MQ9tM3Lnaxt5JcuYD3P0pIuQmz8MEO2tQchTRSGzcTbcXexDVzXxDFs
 DTD0gEKw0ELkjjGtOSVXNvds0yLLS5hRktJtR5qN/jqrEcCYejAnK9DKwEAgXdCbEv1g
 e6LDdPjPvbRGELPjKdniNAWCIVmF7QLCnP36aTE0JzSqld4tCNn3m4wOLlCvmiW/swCX
 xJBFYdfcReZNKIoconY/NVHUV4m1/U+x/omBycPwoIbhkkWJTmeOXhjHr6BVTRRhHV6c
 5dZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW13Cbmes61XchFZyXPiQyFVxlJjHgOPweNyF1VQUJc/1VJJk5udEC5Zf51KFOyNC8lt6aC3Is=@lists.denx.de
X-Gm-Message-State: AOJu0Yw6W5QbVWlaHYXfE+LSqkrWQUmPNxRhxqYnCy6g8zOQD8JLhNVP
 wPR+XW1ibNRxd+jJNxuXUDYBItg1YfEXrcwlxkDFUW5BMb6R1gP4LIVGRbkpMNCWZ1gI+cBj0WV
 PuOv2au31WA==
X-Gm-Gg: ASbGnctEAbI39X3qFfCMLRb0fPzxvv4PK36s3SPBN5Wtu3yq+D4NPQXQl17J5nYAFMX
 ctp+T07Z4yzAb0Uiqsk5FAB/HCaXBAO/8C0zc8JwBtQzEmFeAI9DeQhZH/gXhUnGf4qZdVPS90q
 9AZlD8GTKcRAb298bEv37342mUrDPFI4LIb2K1dQoFYGIunK16yr46nkaoPdU4/d2Fc20lLvedw
 8p/8ivUGlIDzPM/LiUxCrxzQEcHC9DUnt6gzy4fYjCWjUUNS8XCEL/py4khTo98IW2LNhS/aAuE
 stPSlVMn7ABeKUPzweoX+xHpnyGUWXhkpzDIJlA9UUopfpxLrF0FUtW9KlfVDzgKC/55WjkyA4N
 XUM2iQqr4+3GcXDvYdjHdFYboTRbkqXUp+uoX2l77bqecpsQZ4L/80NIxS9nU1e6DMf7Ar4PR5o
 nW5bu2X73kFgf8btuEVjgJ1DEro/HI5kwb82Ch7w==
X-Google-Smtp-Source: AGHT+IEyiqQCzhqv75AOIEba0+ZNgj1SGbKf+eaTC9SYurGHYc062g9XF0F45SknpT5x+JQECtBjoA==
X-Received: by 2002:a05:6808:6f8e:b0:43f:7dee:468b with SMTP id
 5614622812f47-443a2dcb6d3mr13077274b6e.4.1761335708000; 
 Fri, 24 Oct 2025 12:55:08 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-654ef2eff7fsm10013eaf.17.2025.10.24.12.55.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 12:55:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20251022122317.3943103-1-ilias.apalodimas@linaro.org>
References: <20251022122317.3943103-1-ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] makefile: Fix recursive makes
Message-Id: <176133570717.2586772.12784501142962137900.b4-ty@konsulko.com>
Date: Fri, 24 Oct 2025 13:55:07 -0600
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

On Wed, 22 Oct 2025 15:23:15 +0300, Ilias Apalodimas wrote:

> Since the Kbuild bump to 5.1 and specifically
> commit af1a9935708a ("kbuild: make -r/-R effective in top Makefile for old Make versions")
> the recursion rules have changed.
> 
> 'make O=/output/dir/' as well as './test/py/test.py --bd sandbox --build'
> is working fine but anything that recursively called the makefile was
> failing e.g 'make tests', 'make qcheck' etc, which calls a bash script
> that ends up calling the makefile again.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] makefile: Fix recursive makes
      commit: 38f40e6de6029686356a1b786087385ae974d354
-- 
Tom


