Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B704CCFA02
	for <u-boot@archiver.kernel.org>; Sun,  2 Nov 2025 19:55:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32B47838CC;
	Sun,  2 Nov 2025 20:54:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UuxDt699";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F220C838AE; Sun,  2 Nov 2025 20:54:50 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 836248394A
 for <u-boot@lists.denx.de>; Sun,  2 Nov 2025 20:54:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b3b27b50090so604577366b.0
 for <u-boot@lists.denx.de>; Sun, 02 Nov 2025 11:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1762113287; x=1762718087; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VjcPmmn4yfBr3JGKuzKUKqg+DnMsYIErtNMs2v8QNLs=;
 b=UuxDt699yZ+VdBklgjy6CYR0JLdRuDj9fbWDdLWnSJFAqHWVaGR78aueUDC+wjA4mM
 kuxKYldNGLEPrF3f5l0F49wz59yURmaj5uoM/PHuqZo1wpW5I8lDzRJt6rR5m7XVjXVr
 /qipgEZm9ftwWOrGbJRB5icm9l9NX0pBGoz/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762113287; x=1762718087;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VjcPmmn4yfBr3JGKuzKUKqg+DnMsYIErtNMs2v8QNLs=;
 b=R5ra/J6eBeIWSVRNPfvLz4+jnk38hSxI43kcGkH/XUPqkI1XeiiOBm/plVK/o6sUN3
 MfK2AuY63eXfBfzX3x3DIpC7DgqLT4uaLf41MlT75A1psNdTz3VRNBzMWFU/2c83lT1j
 R2EAxu3lndcxIC3bQd+M/DFjJmA6zoQ2vdO6mPVA0xu6PXfqRt4YgM5zvl9ys/NgWWH+
 sJzyEHP/zh8B2r1SUCZQOROlEF04GlnqWkOCk0IU5Bs3vcWKa8nN5vKIUhG5OKk3XSyz
 Vi2duUxuLGnRQ613IFWUQPU8eb98XZ7XEag+e3pRr1cslGgIc2ymZCNXDq3hMJOT5nIP
 Thww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdbMJ1B84xl0O5WZNb1d8hN0kwINDLSs/FJx6F6Fj6KgNxqE6A3MwEAQMcz06I3JJynuZk+ns=@lists.denx.de
X-Gm-Message-State: AOJu0YyFIKbkASysuxMipU2xRabxBbB/l2Tf5Xb3f0xN+i5fffIZ7M6Y
 u0iV3Z3IWzKVBEuGqVqMsyhf6U+GAiDZRWKYgO/FNUbqGUY8t8gDKah0NzlB45jQqMd8T5iToWQ
 3pOK0k5JCXQxZFw2559KCpB2cNYvTEwRuF71Yodwf
X-Gm-Gg: ASbGncvcks9H4PXcO2pKWRw/GfPJY/QSNsIZgIPFXCFur+FlglBlMzxMp1Hw10SPggv
 JvhT/RjWUuJBFEcDjqikoWH7332frAYxx4HES2G3+pzzuA4SFSSdx1Ovb3eQngVjjnmcsxOIBqO
 l5gkuPsNKs6Y66h7vK6iDWrB5KAx4rD4rU0Ed2IEq9t8aTFJoE5XzGC8dGWnzLC3mEyXXgFb00C
 aFY9/2H2YaQDAmo+Dm6iqMm9ga4QJWbpVH0/AKSThIckS/NHKdblNq83LVBeg==
X-Google-Smtp-Source: AGHT+IE3e8k17l7UWWqwArRz9u22JNcpZAUmvMJzRKpiT6N87gg5nYCzC5oTHggd2J/GwmljSY/YhYIvQd7H4fDOrRM=
X-Received: by 2002:a17:907:7295:b0:b32:2b60:ee2 with SMTP id
 a640c23a62f3a-b70704b5273mr1170599266b.41.1762113286962; Sun, 02 Nov 2025
 11:54:46 -0800 (PST)
MIME-Version: 1.0
References: <20251031210700.643712-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251031210700.643712-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 2 Nov 2025 20:53:50 +0100
X-Gm-Features: AWmQ_blzRg93ra1D85tSJa6WXfsIKNwtxwkA19LRCIA3rkgS2adl4l4eVDD7df4
Message-ID: <CAFLszTiQTzwnf=tmE0YVH0bbbYHy7ausHFzofN4jvOG9Q+a8ng@mail.gmail.com>
Subject: Re: [PATCH 1/1] sound: all sound devices must depend on CONFIG_SOUND
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Fri, 31 Oct 2025 at 22:07, Heinrich Schuchardt <
heinrich.schuchardt@canonical.com> wrote:
>
> Clean up the sound Kconfig options to let all sound devices depend on
> CONFIG_SOUND.
>
> Before this patch it was possible to select CONFIG_SOUND_MAX98357A even
> with CONFIG_SOUND=n.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  drivers/sound/Kconfig | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
