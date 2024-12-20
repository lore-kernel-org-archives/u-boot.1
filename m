Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9359E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:12:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E4298060F;
	Fri, 20 Dec 2024 05:07:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gL6hKA0v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21D85805EB; Fri, 20 Dec 2024 05:07:01 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07518805FD
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:06:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a9e8522445dso296830466b.1
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667618; x=1735272418; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=02QvfBBqKG1ToxTi2FeUHJ8YZZjA91Hkc+DHwJHEiAI=;
 b=gL6hKA0vA+MO/iF2B1cv3/puacjh8MCfK8bRUGm4aZNi2csBfBn2ABFFOcha5mnZWL
 +oSnv3H46fEdHynF20/vl/ftNu1rNeF4QODnRN1CmCxbmhNvUVFcK65CeRPs3pqKLOKo
 XgJrLrHftCMm6u3tveKLf7esrXUii1JayV6Vc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667618; x=1735272418;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=02QvfBBqKG1ToxTi2FeUHJ8YZZjA91Hkc+DHwJHEiAI=;
 b=gB3f9ln271kJxq3kFC8amCKFIXqkEUIfoHdwqDWSC7Rnk5pTHStRzeTtu+d8Dm9FyQ
 GXbJfN4AgkWk/+2DbxKdP0dKYqg1Ptp2ra+g3BTNV/lAA1OWBgdBbKqrYyJEn2BPcXrM
 urLMXlWGQAIwACfhTOJGdHoUbN2Z5XMz2UmekbC2DFb0bAxgIZGoF+xEJEIg5H31tY8s
 7GumslnKeFn8ffT4Gg5iEhp0gt5tZtr9Vax3kG7HK3vts/MV3Cq4qQRI7PQDe2SUSTjo
 Ftsi62LfR+rBzA8FEgiwNWs0cfo365/5ph6uMSrkuwSqV8cZ0vnWLUShunp3ErY7HKJT
 OqAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXe6Sen5XxLbsE4F8AHxtT5cxbfvGdsZACT0Z3fU8kdZy7NhRHG3/G2n9QQlNIrPy4ahYvV+c=@lists.denx.de
X-Gm-Message-State: AOJu0YwxEfN2G7jRlP82MjR/wB+4j9CaVb/+iwvmwPwQoKUalDgWZjSa
 ITVXKZRi/Xh7aVivOPUzeSC2NsgpSJ5oKUES166cPw+6FgixXgDO+L7/UhOBI6O1cyhc1X3S2FD
 nvmCFfgIaFP4bZfIT+kPqVnWhOL8sM/Sez6/MWNAZlvtiMO4=
X-Gm-Gg: ASbGncuGs3kCVdLOqUQtn69uzeRa4CgzCXP2YUjeMZ5zyr/K/DZ9TgLqcFASabKqoRx
 If8zAQp6R6arEe0yOhyrnl8c8Jg/Q0oMDYFT/KEk=
X-Google-Smtp-Source: AGHT+IERCkQ0UlgX+1UM6g8roaSfI3kpxUJrUC63tNVdTrW8LYs3Kq/isK0bMflbo80scFv83BXeC7PyKbZqo1cAQBU=
X-Received: by 2002:a17:907:6e92:b0:aa5:b1b9:5d6a with SMTP id
 a640c23a62f3a-aac336592f2mr83349366b.54.1734667618470; Thu, 19 Dec 2024
 20:06:58 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Dec 2024 04:06:56 +0000
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241206023626.2456858-4-sjg@chromium.org>
References: <20241206023626.2456858-4-sjg@chromium.org>
 <20241206023626.2456858-1-sjg@chromium.org>
Date: Fri, 20 Dec 2024 04:06:56 +0000
X-Google-Sender-Auth: uiPWrJ3pl0xuW7M-nRRjxXghRuE
Message-ID: <CAFLszThUx+4us8KUv_-UUjnDZeAC61NUhXyRNWgS4cUXOt5uRQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/46] x86: Drop duplicate definition of zimage_dump()
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

This is now defined in bootm.h so drop the duplicate in the x86 code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/include/asm/zimage.h | 8 --------
 cmd/x86/zboot.c               | 1 +
 2 files changed, 1 insertion(+), 8 deletions(-)

Applied to sjg/master, thanks!
