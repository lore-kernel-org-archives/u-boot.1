Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A690E7C4E8
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 18:06:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB64A87676;
	Wed,  4 Oct 2023 19:59:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="h/GvtwVH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE7DA8765B; Wed,  4 Oct 2023 19:58:52 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECA4A87652
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 19:58:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9b974955474so20586866b.1
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 10:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696442330; x=1697047130; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a9juIOIS7rMil+/Q0XpSdin5OuSiLqne1KCcXB8Rxs4=;
 b=h/GvtwVHlPxH62VvLXrqdtA57hem5LMxUU7QRNdc0dsYUfORncCYTEYSZ132B7GwRi
 Eeux09Ho9KT1jTN2d9vR/lAHwXtz9TtXyUtADuWMgrOzdUoIBX7ZZmVGft8nGm7OXo83
 faLrmg6kOYxrUMZC11oVaTariHPv4BqbhTqi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696442330; x=1697047130;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a9juIOIS7rMil+/Q0XpSdin5OuSiLqne1KCcXB8Rxs4=;
 b=GligCygSMYcta5KSDI4O9oWvtIxvcipL/UXGkNx8TSeiQ5aF5t4qVZY2c6FOEAGMLx
 q+6WilJvjdlv7vRHJ7ItWyNJl1XgDs6Jlg+mI9/mLVRSwspi90cJu56f/Hk+C5MrQR5N
 0WGtmIrlACNK0X35eQDdiogyo9CDmaVRIrRYOdDzVquwqIuS51itDOiHcF8z8DEIYZ4a
 QKC0/TweuIUM96nGdiiwnfQjh05zXp5/sJnEjhOvn4b4efFzNqMk8k5kcNtvWCa23KSq
 PDdi+g416cd6a+6yIIIG2BgIv6hMypBAgT5/UN4MOfuXmnqVLEtwpv/9hFlmMHVZytFG
 0eqQ==
X-Gm-Message-State: AOJu0YyOiYUOXPIM+Cm6I7MEZVldQwkRhBx1lAShEQqs4bb4ObA5WX7a
 4IcMGJYY4YjUvqS4zYPCG2yyZFUniNNg1sg0Wd2/zA==
X-Google-Smtp-Source: AGHT+IGqVIJSzHxWXq1oaDX+Z44vzVcvXUbJ1L+OXAUCyFIz/VzjBhjjTMS/gbMkWymSmjXM/+7MkdB+TVa2fRjZVDE=
X-Received: by 2002:a17:906:2253:b0:9b2:6db8:e108 with SMTP id
 19-20020a170906225300b009b26db8e108mr2609935ejr.13.1696442330118; Wed, 04 Oct
 2023 10:58:50 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Oct 2023 10:58:48 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20230923194424.1739224-3-sjg@chromium.org>
References: <20230923194424.1739224-3-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Wed, 4 Oct 2023 10:58:48 -0700
X-Google-Sender-Auth: CW26BdQJ358zxMR9zYCXO6xngEE
Message-ID: <CAPnjgZ0gWJw=Xdj5Tp6+OH=23cxWnD8vBfUFMkOz9SQJT6YMow@mail.gmail.com>
Subject: Re: [PATCH v3 02/27] moveconfig: Avoid deprecation warning for
 setDaemon
To: Simon Glass <sjg@chromium.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>, 
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

Use the recommended new way of setting a thread to be a daemon.

This avoids a warning:

   DeprecationWarning: setDaemon() is deprecated, set the daemon attribute
      instead

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Applied to u-boot-dm, thanks!
