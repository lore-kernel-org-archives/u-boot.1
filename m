Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6664C4167B
	for <u-boot@archiver.kernel.org>; Sun,  3 Dec 2023 17:45:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEFD0876BC;
	Sun,  3 Dec 2023 18:44:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K1/eQHYK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D10C487519; Sun,  3 Dec 2023 18:44:52 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BADAF876C4
 for <u-boot@lists.denx.de>; Sun,  3 Dec 2023 18:44:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-548f853fc9eso4915508a12.1
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 09:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701625489; x=1702230289; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Yrb89zMEq2ozCh4HXxFJ6cv8pEa4mKckMUlrzD0rrB0=;
 b=K1/eQHYK5SOOC6haTV2F8vW5Z2N13vnNeorDAtPqaLcVkc2PC/ishK7FSF4UQIexKB
 /14LpEQEsgt3lQZwzACd8u2+/VnVDjtQB8ivcqrIZpbC6cDqqgjKxEc4ANWIxskf0Ird
 ah+PW+Hg7f01HG0IA23YVGBQpOVrZasyZn4+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701625489; x=1702230289;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yrb89zMEq2ozCh4HXxFJ6cv8pEa4mKckMUlrzD0rrB0=;
 b=WVhFgzFDo+o/XlQCvCWW6tIpAMbyGyeKdL/lntaCDo6noLiHiVkbizHdBOY0jTMfp6
 XKbJIkuVzyQeM+T6M69CscQGF1jswU51NJXmknMngRHbjjp7pO9U6jJVSqL7eSbQyNA7
 rM9/r5VRG2A9eJGDIXhLbuzH+5Zy19QQHo1aCq1sY9wwiN/DFrdFdqJ//6tHANg0APUf
 SOTtQf8/cWz6BFvNIQ4fzXosj1nl0P99N5YvpS1RA3ZLukz5MVvckKiNyv8Yk8FS3R38
 IlvwM3OdRHxjNQYynYU+D/Y7u9pBoqhFBhQsFfqbFwJVPSBP9XDUDhMzhZKtrS8eVi/l
 kLNw==
X-Gm-Message-State: AOJu0YxvQVK7La7g0m0qWTw0yKlSecAK5kSawWOsU3QIbNwI+dSiyAa0
 /D8/4AYAij/Skl5YxaIJPFQQnwb4wquKjYSOk4ST3Q==
X-Google-Smtp-Source: AGHT+IE1yhHS+jLOlWcKgobHYCoUeCE+3AXNKfMXKjBwt6EW+w3sM8hO3h1o44888zm084N0KO8F15AWFQhstU/eAzM=
X-Received: by 2002:a17:906:ca57:b0:a19:d40a:d24f with SMTP id
 jx23-20020a170906ca5700b00a19d40ad24fmr1437922ejb.283.1701625489172; Sun, 03
 Dec 2023 09:44:49 -0800 (PST)
MIME-Version: 1.0
References: <20231202193314.1513224-1-seanga2@gmail.com>
 <896d4dd3-d023-851e-e7d8-3bf4d324f1a4@gmail.com>
In-Reply-To: <896d4dd3-d023-851e-e7d8-3bf4d324f1a4@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 3 Dec 2023 10:44:33 -0700
Message-ID: <CAPnjgZ1hwOLEt8Djj5t0Gn1CP7Y9RRMvG=UYbz0NSht40060Qg@mail.gmail.com>
Subject: Re: [PATCH] doc: Replace examples of MD5 and SHA1 with SHA256
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Peter Robinson <pbrobinson@gmail.com>
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

Hi Sean,

On Sat, 2 Dec 2023 at 12:38, Sean Anderson <seanga2@gmail.com> wrote:
>
> On 12/2/23 14:33, Sean Anderson wrote:
> > Both SHA1 and (especially) MD5 are no longer as safe as they once were for
> > cryptographic use. Replaces examples which use them with examples using
> > SHA256 instead. This will provide more-secure defaults for users who use
> > documentation examples as a base for their own use. This is not too
> > necessary for non-verified-boot scenarios (since someone could just replace
> > the checksum), but I wanted to be complete.
> >
> > Signed-off-by: Sean Anderson <seanga2@gmail.com>
> > ---
>
> I forgot to mention this in the commit message, but all the new hashes were generated like
>
> echo fake kernel hash | sha256sum
>
> which should be fine, since the actual values were just for example anyway.

Ah, I was wondering about that.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
