Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE87E95A6A
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 20:44:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0C7886F03;
	Sat,  7 Oct 2023 22:38:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SjvbT7Cu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75DED86EB3; Sat,  7 Oct 2023 22:38:18 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B5F286DFC
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 22:38:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5a21ea6baccso40399077b3.1
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 13:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696711091; x=1697315891; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KvY3Q5DWQaVLhY1c9hu+Ta7YlyEKEXXaEjX+xjsEk3Q=;
 b=SjvbT7CuZHpXVKYVWTC26aURo7/t7835mYkq8XBRmKN1O9fJS7LIhX9SUiCGMK+VZg
 Dy0SwIwyXVWMUgdgv2lB3ipboSdWgcPRe2W3mRWwX2uQZssxwdr4SocMhL41NA9juwid
 V3OPEE91GhHqQhdzqm3FNBqFUAMswq5HNrAXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696711091; x=1697315891;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KvY3Q5DWQaVLhY1c9hu+Ta7YlyEKEXXaEjX+xjsEk3Q=;
 b=ADOnrMrora/tPIA5cTCSbGaNT77DHGIncWZRweyz+qZzLHjhr3YcrbQtftbMiKw+Jq
 2ZqzopurxPoPZQzrKaDgg687LJgA4YMqEYXR5DpWnaaZPvYoOL+ECM6oxVIuiTHnPCFP
 KmDXIv5DljvJwi33UdkNL9hZkUfcpQnHxeY3PU+UVG4O/qz232c2YM9iVkZs4wuQ6jtT
 EYRQIiXNB+Zu3Lf86DQxi2Y3aAavIAwsag/viuhqZ8yJaCy1UIrd3OkIZExEFDK/LOBU
 vI1BlfHg0SgyarQfSq0PHEVjerndmBAdWwNOxxWtw3hLKK3/YahNxapix7wBpfypb2Ab
 lN+Q==
X-Gm-Message-State: AOJu0Ywe10rlU0Zr+TWRT45moGJQhR+LbDVCrIPnlGeZ+ZKBDvYhIPVD
 Rc0U0A9HdVtYT/3UlIbNeb+B41QoFmdduz4waV9sKw==
X-Google-Smtp-Source: AGHT+IHZZxc+s/kbSSmHbYidGqKbArxa3xyEESq2UB5nVOQHBVGvWLrbSxWsiL9vgfQMYiyuCrbOYIlk5HGPYYkzSEg=
X-Received: by 2002:a81:9292:0:b0:56f:fbc6:3b0 with SMTP id
 j140-20020a819292000000b0056ffbc603b0mr13078349ywg.14.1696711090962; Sat, 07
 Oct 2023 13:38:10 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 7 Oct 2023 15:38:06 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ0P5w=eVus+i-HCtcrhbMMDULcKwnXSdsetRFq5SCeEgg@mail.gmail.com>
References: <CAPnjgZ0P5w=eVus+i-HCtcrhbMMDULcKwnXSdsetRFq5SCeEgg@mail.gmail.com>
 <20230923194424.1739224-6-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Sat, 7 Oct 2023 15:38:06 -0500
X-Google-Sender-Auth: ieY0XdtE932ECIbXtLOmcCGTS_c
Message-ID: <CAPnjgZ3Py=y6K=eDO3g1o8sGbtAJrWxPkRUTLTFXUY_y920Pag@mail.gmail.com>
Subject: Re: [PATCH v3 05/27] moveconfig: Drop CONFIG-moving code
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

As a step towards cleaning out old code, drop most of the code that moves
CONFIG options to Kconfig. This includes parse_one_config().

Drop the ACTION_... values as well, since they are no-longer used.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 163 ++++++--------------------------------------
 1 file changed, 19 insertions(+), 144 deletions(-)

Applied to u-boot-dm, thanks!
Applied to u-boot-dm, thanks!
