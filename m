Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA2EFD2A54F
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 22:33:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2930883F6E;
	Thu,  4 Dec 2025 23:33:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CYdLfuym";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA4AB83B4F; Thu,  4 Dec 2025 23:33:30 +0100 (CET)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D488A840F1
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 23:33:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-3f0ec55ce57so1261616fac.2
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 14:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764887604; x=1765492404; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u3Wck14hfV8e+UdlEOLFzRSPx1pfWYOnyAtT2BeJo60=;
 b=CYdLfuymLQ8QnNAhOx3ZGmgRer/RaeQ+47A6bIPUsjkmIBymRWd6WnnKJn6FtOh2jq
 ftf61P5cMQy9CPJxH1j90ZRXvESWw7Ct0hHGHwXwUl77T+hFrvV5klW4XmDj7f7B84pb
 jVQXM55Dco7UBu4x2tM1ocB9cEeq+0UH7ldlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764887604; x=1765492404;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u3Wck14hfV8e+UdlEOLFzRSPx1pfWYOnyAtT2BeJo60=;
 b=kiPqpS35KqO6EfGhqwmzVIjh27a/JEn4OGS0RKqxE+tNfnugeKkBWf6ZMmBJ7j4gcC
 YhDTcAIZb+vIbP0zN/12ZLzwtkrwoAk+2pLNKkYpLUNLNGcWcE6XR1SHDHyKHKLZvIHa
 uu+DoUmRT+w//9L1SeJAxxzTmpErqGir9za6Rm5Uc/rKFwllUG7M1/zJqaSQo4dUw9Db
 fHwhtayasGXGM2JNUtmQ/PEYrCc4/iMHhVc5efX3TPbXw5QipiWgy26vEgCLYC+jcJY/
 AQjs/gvCKfyniHzvHAh5pOVu8EzACT5sHUra/gUjeF8MGj2ZqV/+3xQN9CPhvdRHNoqu
 KwCg==
X-Gm-Message-State: AOJu0Yxk+UFZ6T+qL1WBZNUoK04Sn0sfW+THjzR4OZvaywL/j6sVO/8Y
 8td6bZSwbxGh9OMh2LRgyka8ORASDsB7wqiWLc296CrMLZ3SMKnaJXNSgugniOJheDxS9Ik0PrO
 P5l2ZwKs=
X-Gm-Gg: ASbGncuemDZ3TP+LY+K4POYyGQJkpElz+mX99kQ7tE3oUvrzpWow01WCAzxsju3Yy1r
 RpCMvXTTRY8OTV/8pQyUin9MNSZTeUb9MjKJ7uHa+GrErSzSWopMR5bXZ0KGRiyrT0iDRAf8I2R
 WhbqvN0kP4rbuuno/IU+x7ckMSi9GMsyz4N3bl9xQ82sDp3dAiN97KzhztJWKDe10WmwiuvQCVW
 Bd7ZvFS00EK6k+IhL87FJ2MjaihFipUFdgUmkENOkHO2lOLXvDmjthQ99BQs4iZVbdH1ERT2z2S
 USa0OOXdtqncozz2cFBAfNWUx70R5e2+94hWpZM06d0mBLl4SJTD8fgrDSLvGDPgGmCOmZ5ivBo
 Og+RH5U+BOEJgnPzTh8udyrless9Ro7Berhn6fknVF+6mzaXFYER9PEhQS8G6LLdV2UpjZtC9Wh
 DFsRWH79+oTJkwvPEx1EHYtL7MaRVgnv1i467wR7IlGcZBRFck
X-Google-Smtp-Source: AGHT+IHoPirLbbzs5ttH9pIULC7+LMUzMksbgBTTpsIQeOCET8+hoI5Nfzg/UytzSQ9KV4pXSjGc2g==
X-Received: by 2002:a05:6870:9690:b0:3d3:4834:b3c with SMTP id
 586e51a60fabf-3f16935c369mr4720275fac.35.1764887604371; 
 Thu, 04 Dec 2025 14:33:24 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3f50aa31534sm2220312fac.2.2025.12.04.14.33.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 14:33:23 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: David Feng <fenghua@phytium.com.cn>, 
 Linus Walleij <linus.walleij@linaro.org>, Peter Hoyes <Peter.Hoyes@arm.com>
In-Reply-To: <20251119145541.843466-1-trini@konsulko.com>
References: <20251119145541.843466-1-trini@konsulko.com>
Subject: Re: [PATCH] vexpress_aemv8: Stop disabling device tree relocation
Message-Id: <176488760341.2085159.6934397254696990379.b4-ty@konsulko.com>
Date: Thu, 04 Dec 2025 16:33:23 -0600
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

On Wed, 19 Nov 2025 08:55:41 -0600, Tom Rini wrote:

> Remove setting of fdt_high to ~0, which disables device tree relocation,
> from the default environment. Doing so prevents U-Boot from correcting
> problems such as having an unaligned device tree and leads to various
> failure modes in the OS.
> 
> 

Applied to u-boot/next, thanks!

[1/1] vexpress_aemv8: Stop disabling device tree relocation
      commit: 59f9fcc1f514762674ac07c13c2a85f7aace7250
-- 
Tom


