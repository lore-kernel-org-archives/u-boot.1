Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE762E74AC8
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 19:48:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8216B896E9;
	Tue,  3 Dec 2024 20:48:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y8VClhhJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D0A8896F2; Tue,  3 Dec 2024 20:48:12 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E98E0896EF
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 20:48:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2eb1433958dso3990637a91.2
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 11:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733255285; x=1733860085; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J0bgHOW9kvUPn/syYaFO0uo71qav9n4OT/QvxmNf43s=;
 b=Y8VClhhJHCo0BWBQEOy7FbLVniBSfmud5NIp4xR7RIgITxN2/vUDo38ELs8kVEafst
 GWplOYZURxiga2FH1JYBinA4vOSc5SUojvvAi2mz6+lqv9xei5Wmp6VGbD3JzGZRiXxx
 Z+BqE82RE956FhXBTL8ha6oGSioSCBiBCy8hA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733255285; x=1733860085;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J0bgHOW9kvUPn/syYaFO0uo71qav9n4OT/QvxmNf43s=;
 b=MrToHS+KSAAEUUo3EUvuFGOUB6njHT0U8CVW6+ZOoJxDVO3RhvlCNpnhJPWBkEuK6p
 fy9KrBmVpsxLva3rNPgUJCXDv++qJ5vcznoypgItQjg3F2udMKOQSLZagVl96zJzbXbs
 dPFqX97oazK/w5aHerCXxdnLWdexQ1ueLIcoJ5LNuR1WYZe8tnpsV+yunUmJpZMAc8q4
 eDzgGCgo/B3/Z4dZvnjAJPgj19JyLsExsBtWKMhyOw8s0meZ9L5Oc1de6UXEUDHl6+Ic
 WGy9VRS4e0GFi3xc6ICwsHhm+1A6Cpoq7LbghCJsfeqVd4OuQX4qaz1f4rNMf99tIoXC
 9VJQ==
X-Gm-Message-State: AOJu0Ywe+k4bKcYA4MNL3727ZMsGncFepw8Ysog8Eeekv480n5azizOI
 XgGeilxqSGI8jFhu/7zMbjiqJYIN75b9AB2h+/mQDhDPydsAEczCPo9gqtI47QlUR1DdGfYrAUf
 zXQEtHAmkmHj3r0CY4zBLce75ZxRxJJvSbijLlRhOFjNu464=
X-Gm-Gg: ASbGncu2tiZsLfq1ZwfSYqz9tE7PmqodI/Map6E9NO0fyrxMqPUAY1UsBUh2YcR29Iz
 husHdvD5H0Q++A6rEOmQrBUJpGGsveQcO
X-Google-Smtp-Source: AGHT+IG2V9UXFKVcDKTgQHZffo9WKNtxdddt+agTbYQuypVKw1GZWNT2Cee1kG+3oNOscgZoKDlmPfO8uG9Bojgu9sQ=
X-Received: by 2002:a17:90b:33c5:b0:2ee:7538:be70 with SMTP id
 98e67ed59e1d1-2ef1ce69491mr1955834a91.5.1733255284969; Tue, 03 Dec 2024
 11:48:04 -0800 (PST)
MIME-Version: 1.0
References: <20241103003322.626036-1-sjg@chromium.org>
 <20241103003322.626036-7-sjg@chromium.org>
In-Reply-To: <20241103003322.626036-7-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Dec 2024 12:47:31 -0700
Message-ID: <CAFLszTjA4uCQD1EWqT7YMu_+BcBO5RafzhkJiZH7KAFu1HDthA@mail.gmail.com>
Subject: Re: [PATCH v3 06/25] arm: Drop old LED support
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Albert Aribaud <albert.u.boot@aribaud.net>
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

On Sat, 2 Nov 2024 at 18:35, Simon Glass <sjg@chromium.org> wrote:
>
> This has been replaced with a new LED framework, so drop this old code.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  arch/arm/lib/crt0.S | 4 ----
>  1 file changed, 4 deletions(-)

Applied to ci/master, thanks!
