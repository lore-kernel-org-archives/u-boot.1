Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1342C41535
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 18:49:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3634887C4C;
	Sat, 16 Dec 2023 19:48:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gHn0furY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE8C187C47; Sat, 16 Dec 2023 19:48:23 +0100 (CET)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4C9F87C11
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 19:48:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-db3fa47c2f7so1186201276.0
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 10:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702752500; x=1703357300; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9g9Syvngv/mOTgs7oEPFpIQeolz+Pq7U/c2VjKDosK8=;
 b=gHn0furYYuOXG/pvZ4pqLoUTeBZh1BBIqcWQ2WyriTZXgN5nuvqpBB0ofa408WmWKJ
 OT6WREpx4IwN6wccDv5jKq3aRTqE0VFJECZSmXV9HBFFRngEqOSZmHzv+zJJVcRuGbLJ
 Dj0cUkhB/Uh8rnIHd3dEEoCqgNaPFVfTT7o3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702752500; x=1703357300;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9g9Syvngv/mOTgs7oEPFpIQeolz+Pq7U/c2VjKDosK8=;
 b=u4OFoKh/9fCK0XhPaVihNNheRQcnOUvPpW4ub957F8+BquB8oVvEIEMp+lzUT3mSQl
 tLT1bvIAbDxIGHI0Abbgij5ij+zN6ETi0r5/GTLJxVv0VzHFzX5LV+vxE67Igju59jeE
 uiKClF8EYItbqdqPhq1dQjxHLD6f8Cr12vTAfiIUZaXkWmj5vIiZaAy8SqBPE2wRX5Kw
 fG3zMdFdAN6eT2xKaXPwCZYFt+Lc6lZhZuVcN7l9exktz76l1p11Kgi5N5CkB7K5RPVM
 4U8l+5jfJc9iPWe5Z3weWJVyAdn1mVk3kWLJeAql+22ZyRIzhCVI1dFUPEgcMI/h8KI9
 oZaQ==
X-Gm-Message-State: AOJu0Yz7l34+/UbXLMbBItvSuIDRXDIUObBFlcHXZQeSxo3NVnE+NE4G
 k0tO6JxpJm45XGgzTwISxh3G7reEcf+EbbcnlIGBfOYLT1nQyeqp5iI=
X-Google-Smtp-Source: AGHT+IHh6Tpz0Du+wfu2m3pf7zvFl8EyX0TNvYal4YuK4557HpcJ5+A/dCh324+u5n0IZmAm5PFmh30en+eYqbbrjVM=
X-Received: by 2002:a81:4e81:0:b0:5e2:d4e0:3a89 with SMTP id
 c123-20020a814e81000000b005e2d4e03a89mr4906775ywb.79.1702752500073; Sat, 16
 Dec 2023 10:48:20 -0800 (PST)
MIME-Version: 1.0
References: <20231214181658.3359902-1-trini@konsulko.com>
 <20231214181658.3359902-11-trini@konsulko.com>
In-Reply-To: <20231214181658.3359902-11-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 16 Dec 2023 11:45:54 -0700
Message-ID: <CAPnjgZ2hGqv3LBDfHMa=yUuMNMkFj-w_HaYrfNO5HRRJ9u1eXw@mail.gmail.com>
Subject: Re: [v2 11/16] lib/sha*.c: Update header list
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Thu, 14 Dec 2023 at 11:18, Tom Rini <trini@konsulko.com> wrote:
>
> Cleanup the list of headers we include here. For the tools build we only
> need to exclude <cyclic.h> as that's used by the target build for the
> prototype for schedule(), and we don't need to get that via
> <watchdog.h>. We can also make use of our <string.h> intentionally
> existing as a redirection to <linux/string.h> to reduce ifdef'd lines.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  lib/sha1.c   | 7 ++-----
>  lib/sha256.c | 7 ++-----
>  lib/sha512.c | 6 +-----
>  3 files changed, 5 insertions(+), 15 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
