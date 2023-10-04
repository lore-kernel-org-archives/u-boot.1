Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37636E7C4E2
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 17:59:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21579875EF;
	Wed,  4 Oct 2023 19:58:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iA9l0FjE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE00D875D7; Wed,  4 Oct 2023 19:58:30 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38567875D4
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 19:58:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9b27bc8b65eso21074166b.0
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 10:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696442304; x=1697047104; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eiw5sauQ8f9wqOycGOGXPkyIrUgCaSTJvp2Gu3ElyWE=;
 b=iA9l0FjEB6hTT4zn83xIi40gQp8+bifjBwZfv9t3wrwa2QcdL+dBLSEgch3i+2SVpV
 6z6gaOqfNMzXF+0+qw18hqsL9EwCvEIbNnxkNvKFOcOsyZ93YSxdCSU1ytQbOYw4Drjl
 KGNJmW9CkXx+AY4CIXmCcAqfjx29bEkFO6chg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696442305; x=1697047105;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eiw5sauQ8f9wqOycGOGXPkyIrUgCaSTJvp2Gu3ElyWE=;
 b=joDzevtAivhwu5iXIqiRKxbMum8K2L3mKGGncnJ5N5Nw5M3YTqBbFbFcmDwAYb9QUY
 gr/neGbhwxN0YpAdvCe9cCU5QSFd7TpG+M5fxCxafDNSQs8aC/PueD8spPfMqrUOZ8MC
 NuDFVr7CkpEITOe2tlMw4VnPcsg5IndJbEsdUMjduYZUc4FWeBejPDNyvaVXcB9FoAGA
 Ij6xlDj+fZpVHXbo3i8i+VzCaXJal1UPxi3FHsNAJlRUAxid7q1lo9/tXRCFwfVYlar3
 MmTy1/ToqwbTElNmw8wdLTK0RxN0xiA/jQrvYuqILO8Cl6+SdMVgoMq4dXVzzo0X+EI8
 eOyg==
X-Gm-Message-State: AOJu0YyKy2NDheOgytMHYm3yiAngbsOn2PZcwXEtQ0BCUvFiH/1+luul
 AsLGPq7f+tTjL2u14Z+G+rsJG4Iqyx8aP+AwIhkbVw==
X-Google-Smtp-Source: AGHT+IFfIAEThr53/varSm1mbPr5raUffFx1DQMSsyh1Vqjv4OwJjRF4KlQ6IiNavabxbEy1Nr9DiQhiQ3zHSAfIUHw=
X-Received: by 2002:a17:906:5a6b:b0:9a9:e525:8705 with SMTP id
 my43-20020a1709065a6b00b009a9e5258705mr2313210ejc.57.1696442304570; Wed, 04
 Oct 2023 10:58:24 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Oct 2023 10:58:24 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20230923194424.1739224-24-sjg@chromium.org>
References: <20230923194424.1739224-24-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Wed, 4 Oct 2023 10:58:24 -0700
X-Google-Sender-Auth: GZZ0EZIXeqEFTH7w_cQmGJNHAQA
Message-ID: <CAPnjgZ12sWToa9GCT3MakQT8Rh0C-uszfCLRsqj2PX-vXwUF2Q@mail.gmail.com>
Subject: Re: [PATCH v3 23/27] moveconfig: Drop the initial output
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

Since moveconfig now just does what it is told (build database or sync
defconfigs) we don't need to print what it is doing. Drop this info, which
is of very little use.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 6 ------
 1 file changed, 6 deletions(-)

Applied to u-boot-dm, thanks!
