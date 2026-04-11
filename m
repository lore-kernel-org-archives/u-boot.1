Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1846AF3ED40
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 16:29:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89A7D84198;
	Sat, 11 Apr 2026 18:29:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MObGRrb+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22A5F8419C; Sat, 11 Apr 2026 18:29:19 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1F9183DC9
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 18:29:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2b2503753efso25507915ad.0
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 09:29:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775924955; cv=none;
 d=google.com; s=arc-20240605;
 b=IuDj+qMVOdjqQ0o2g/btGuQjhfOolG4vOXqA+0M/eiCe0uD5oN3ufII2U2VwGkOHGO
 Z8qcCJlwFMID1ZtvvvhAcIpobdtDG7xX5KjB+MGDujmjP4bqP5QSe0UN5dZsbXCRL7x2
 aOWNdVuqmqprfE7+MlBoLLc2itT4+h7KwE5hgnIX7OfvvGtUZtYsYbG/ii/7BTXh4fx9
 +zFvMrRfIQYgZwDPqDR52dXSUhuBEH8VGlrfbIbLaJykz3k15GGU4lQjefrxBXJ8P6Lx
 d0dRHoaeyvQVTya1qkyFuOmEihHujom6UK+l64G+99QAcwlX9Kr93xblBD6EYXe3rEwK
 OJKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=q+OpAFKfzkGppTzTLfhYsZ+znyMviHTt1e8C1EjryCo=;
 fh=qlfCqAiDC3ltiUDXh2FNnfkIW0F1ElhX3Wnc0ZgWHsE=;
 b=hJ6/OnXCv4d/8wMgAGVvIeaGeiYwyy6do3Cf0qd6C0vgIWALQtuBlSHeUwhDOq4RW0
 uicAw3bYCQqlQR05zYEVmXq4FXZAiASrWNEPkbM3UHu2jQUb+qQzAoKwIGRu7nD5nKIe
 L3wXVG02Gf4Ri3GmAertUThYMY8j7BcorXhWvYyfwzxTWOVi9A75XohlUcXup1ncm8fm
 mLEsEfMyD5q3ojtR0YD6IJznyNixRPE5gzkb0JajqFnimjxZ9jUg+ap1EjK1Jr3J5trK
 KM2glKbW59uNAMw8tByxS3GJHEwIisyLsCgBNnxTBIqA6q2+QPiitja7/ioU3S0sGSNB
 9chg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775924955; x=1776529755; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=q+OpAFKfzkGppTzTLfhYsZ+znyMviHTt1e8C1EjryCo=;
 b=MObGRrb+iEYM+LvRmP8mryZRAJGCFZWEdkBBab8Z6J6D980YCYlGT5fxFErwuATv8y
 fGZrmBNF9peFMUnsAqvuXkpa/cl654C3jWu2VghA/Xk3WFHQCRlUjxJt5laSzcl/dNHJ
 gdbvNDv20/L3KT87I0LFK8kGWttHGm8bE6eDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775924955; x=1776529755;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q+OpAFKfzkGppTzTLfhYsZ+znyMviHTt1e8C1EjryCo=;
 b=i+5T32Z06QmA8eU8G4galrYC5GuiNF4QQfqTodNpTH8pzp5VF3CEK3VQjV7pq59a99
 7tc7EhwBbvpdfTamcu/Qn6jxmyxVLo1UPbSZSu1JhjXPIvGXHoj38lhMlcKIm+5pzSFU
 WdQEIiaXKpq78uYGW/qptPK3xdu2tS1sGK/SCKbmUmhK/wGBx8JKoCrljl9Hq4DS6MoJ
 Ti2cqpMbUkghaXPihOYE5AiMa9mI+iK2C/rMbQQX9moYyxYyRyL762ueErUJfb0oHwhW
 3SHAMQE5kOLqBc6+1zcXaul2PSO0PPokaY+rzSD3CWoDCnt6du1lrVpLzoFl7DY5KD0U
 +KoA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+6GOydoXWBJPzYoB/hkeO1b+dUPoPE52MfAEOYpidxj8oCiXXNAite/YRxNNcSS0QMtW7C4BY=@lists.denx.de
X-Gm-Message-State: AOJu0YyU14/SgEYxFwAwjmV6e9AxYQs1nMPtOcDGssjYfpOXWhQHFY+J
 csANmT6mjA2/M4RYKJyoubjgTckubKnBeTR65yGVDQyWueazXBJ++dMsdGk9xNpeOP+57E3hjqJ
 FXPATy/HupO5CLwlr5DPFwLi+Rrq6xKlK4sdpkupI
X-Gm-Gg: AeBDietwfRKB+OiFwgyOoUdMrPVYb4P7bQ9gPZDXaJzlRB2xgd+E6fh61Cm0IdLyZw1
 UZm4Mx+6inBVUolVOI9FnM77mkW1s1X44RlwZNFUmznLool+2U4QVNfKpnJia41YncFeqGTm/8O
 lyRO/89Vq8pNTsA2STpZ1n6y1GA0o5PTCS5gQZS9ncJlN5NF0uT7tW6QFcj0OLQViM1Y705CPY4
 3SaiLHzKyqwAsxsW2/TCPQdTkPgHrYNaO8S4B8ddVEMiOByDfTLVmbvI+B50QZ75wgCA1AA8lUw
 14cYVSFWJF8cYEjG
X-Received: by 2002:a17:903:b83:b0:2b0:c106:a402 with SMTP id
 d9443c01a7336-2b2d5944c5bmr90623085ad.3.1775924955478; Sat, 11 Apr 2026
 09:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260408220928.3328551-1-daniel@thingy.jp>
 <20260408220928.3328551-2-daniel@thingy.jp>
In-Reply-To: <20260408220928.3328551-2-daniel@thingy.jp>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Apr 2026 10:28:33 -0600
X-Gm-Features: AQROBzD-vYAWHGeYi36mR7mkQ3QgSjy_5sVbvrNEAwCxsXBhkWmgHPnjAjzZRR0
Message-ID: <CAFLszTghh2cs_=uQwksCj9-NkaTL3G7+HOnM_jEVAojUL3qLOQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] sysreset: qemu virt: Use __raw_writel()
To: daniel@thingy.jp
Cc: visitorckw@gmail.com, angelo@kernel-space.org, bmeng.cn@gmail.com, 
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On 2026-04-08T22:09:23, Daniel Palmer <daniel@thingy.jp> wrote:
> sysreset: qemu virt: Use __raw_writel()
>
> The virt ctrl register seems to be native endian, currently this driver
> uses writel(), which works by luck because its currently broken on m68k.
>
> Use __raw_writel() instead to avoid breaking this driver when the
> endianness of writel() is fixed.
>
> Signed-off-by: Daniel Palmer <daniel@thingy.jp>
> Acked-by: Kuan-Wei Chiu <visitorckw@gmail.com>
>
> drivers/sysreset/sysreset_qemu_virt_ctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
