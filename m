Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F7ACA0EF5
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 19:43:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCFC482E34;
	Tue, 19 Aug 2025 21:43:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KL7dgcub";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9765882B07; Tue, 19 Aug 2025 21:43:15 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F6C780FA1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 21:43:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-74381df0c04so3212701a34.0
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 12:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755632592; x=1756237392; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y4B1JQyWVNOADvJWIg25wkh4xIyBeZGN5puqi95uyQU=;
 b=KL7dgcub8A5i1WpEmvofV/+bYEzPsNQFxUK41OBQO/SflJuIXFr3MZrZH7flloYcyf
 0K6sE70t9krR132gejHq2D8KON3gOAKmGCOH1EGLfDVEune5gdtY1fqcV3T2DUyPdANH
 erDoYVhUfRpsavqo/euYYGAZRBqlZBUFnJC1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755632592; x=1756237392;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y4B1JQyWVNOADvJWIg25wkh4xIyBeZGN5puqi95uyQU=;
 b=ULVeLF9vrmMjyzFqQGCxdZjQi7Q1TQDfYpQ7upFnxLr7fA8TPRLp8u7x6f4UC0MPHX
 Y1QnKwdHexdPXEnwnlpulaC+WrHbv+vMugBdbc+AmtJU17Dp0ISDe2VDlIjIAF1Z3TsO
 i7Bf7PMhuIt6g9sg5pF6h4P/zcSas/++5wiEkssEfU27Nd5ekAPKa2BGniCTMjMqUomT
 4uBApQQp3wR42/1/HzTC8vWnCyiOLZbZIB07SWWt2E+qnSMRsNie8iUNiFrL+uwWiC1T
 WVhNHo9a+IGLXhG+sqUbFZjSKxQWf3fK6xI56wGlGv5oOfECa0JfOgtx0CAm7XS7Qk6m
 aZmg==
X-Gm-Message-State: AOJu0YyL0r2feiXz1muD4tA0mscBQ5AZOG3hduilR1a09W/YOC/cVP7o
 odVSPSJA0rJ1Pwc7xZF3REsg33S6E6wLoKlZqYRzsR839zl5Yi6FlE5DEGeVcyg8n71DUgtGh7q
 4hqNK1qc=
X-Gm-Gg: ASbGncvECrox64vmZt4Mf5Qv8yyAKgU+x8C9PkGqwONK7gdDwWf/bEOIt9M+/oZUgYo
 EpkM7ECf7Qd8TikmQUP6rIgJKt8ujcG3CpLcqHBIpu2m0nlVi7zKClfTAj7MyacV6S3zacEaGq6
 WNN7B1fGITMMh8xy671Bd99YuW6Y+/mg3m6XbR7rz/EBdVUUjUK5oqYfAaD5oNcr4X7BdhhpTNY
 Ui7wLHwCCoeLwK9K6PB1gbsGndUaZGuMS9+3rAI3uPfvJsN24ZU6J/kMB33Eq85/5AluxO2uOvC
 77f76+2fvaZfuigwOYJ4h7x8r3nH9NR5jTl358rhvcNKShj3hoSKTM12s3xg2HAukw+f/WE/N+p
 CFX+S1GCnnmJQbTYOG93HTo5pN4GOGdZFJNtFKNYAMp5tIXmUF9ti7bQ=
X-Google-Smtp-Source: AGHT+IEHvuZt81nlPIIm9Q27vmtMn5Hk59yL/NyiZfCJI9RlhA6BBhhx1Ik7GcFuqYsKGpjvEWFjhQ==
X-Received: by 2002:a05:6830:618b:b0:72b:9b1f:2e33 with SMTP id
 46e09a7af769-744ebbcc84amr308665a34.18.1755632592141; 
 Tue, 19 Aug 2025 12:43:12 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7439204e5easm2525109a34.38.2025.08.19.12.43.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 12:43:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250812175908.3057051-1-trini@konsulko.com>
References: <20250812175908.3057051-1-trini@konsulko.com>
Subject: Re: [PATCH 1/2] sandbox: Improve dummy local_irq_save implementation
Message-Id: <175563259120.3359676.12727821315547235227.b4-ty@konsulko.com>
Date: Tue, 19 Aug 2025 13:43:11 -0600
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

On Tue, 12 Aug 2025 11:59:07 -0600, Tom Rini wrote:

> Normally, local_save_flags is used as part of the local_irq_* macros, so
> remove that as it's unused. Make local_irq_save do something to the
> passed variable so that it won't trigger unused variable warnings later.
> 
> 

Applied to u-boot/next, thanks!

[1/2] sandbox: Improve dummy local_irq_save implementation
      commit: 58998fed9e63e8310a96229565d2996ad29d191e
[2/2] sandbox: Add generic asm/atomic.h
      commit: 66ff673a8e9f56d2c08a32d12867094c77ea5fd3
-- 
Tom


