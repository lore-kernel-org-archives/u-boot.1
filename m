Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79FE4E7C4E2
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 18:01:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7E3387614;
	Wed,  4 Oct 2023 19:58:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aG7jD5bT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A07687600; Wed,  4 Oct 2023 19:58:33 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB790875DF
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 19:58:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5346b64f17aso57246a12.2
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 10:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696442311; x=1697047111; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WcBl1iZbQt6CqzDTu4q981gQI1JL/l7f51u4BZzm8iU=;
 b=aG7jD5bT5VXZrwBrNPajmiefErkajXsbC04WyhJG3Rve3HYj734cqSjigiDShoQkX/
 o1JKN0EMEvM+Bx1CXkhwbu4T8yTSyT4v5jaYEPdFnDgQddFb0fDuMpH5fUXOwqr5mhCm
 GnQlLuiVRmxiojAl6po59n5axqWWd0016hHMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696442311; x=1697047111;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WcBl1iZbQt6CqzDTu4q981gQI1JL/l7f51u4BZzm8iU=;
 b=kyIzmQuRb3VJAbMosMa168TKoBW3HDOmv8rr2n4LCO3drNBEej4OOLeGxcwjkGqUPn
 jIyNi2TTJqRuPfXqbRgX5ocD5d4uruizsB7NUwfnMUQm5kPQVHr4jO2sweLVXKxBi4Ex
 G5U0stWM7bkrH70VNAJTt8mtRW+hsMuThvpupg0pQuHr0PqggZVJApLs1qzzLS0b/PX1
 2gR/MpAQkiXrQOeDc0+jTObViuNlRfcfQqA2f8vc6oEPiiHllnayleWbCFDv1enl3+1+
 tNLONHm8aJAfxx4HzMdLpjGg+aGRUh0hIhxlL+QfuPM1PULp0soHdzrUavJ31bJbeBjH
 ql+A==
X-Gm-Message-State: AOJu0YwonkdnjZ2JWYqfA6H1ovOioYlFxfuHPC8RQ0cwA56okfHzch1D
 b+NtBTkq7d/hg4lWnUhI5eYpH6oT1kGnXwbbRDGMqw==
X-Google-Smtp-Source: AGHT+IHR+3CzFdclaDitAUZ8xEdU6cYvSJMJ1DULXIYHmTwu+DD0odFdCLLziVEd6intEmsw7J6CJc+Zf2hAyM1wlhA=
X-Received: by 2002:a17:906:9c9:b0:9ae:4f9e:7813 with SMTP id
 r9-20020a17090609c900b009ae4f9e7813mr2208269eje.73.1696442310980; Wed, 04 Oct
 2023 10:58:30 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Oct 2023 10:58:30 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20230923194424.1739224-18-sjg@chromium.org>
References: <20230923194424.1739224-18-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Wed, 4 Oct 2023 10:58:30 -0700
X-Google-Sender-Auth: BXPj2gKICmDeLwHLtMuuAkj6gJw
Message-ID: <CAPnjgZ2f0vjewGFB2Q6fFYhxD=LBWAfGv5W_fjjUuNCZVV90QA@mail.gmail.com>
Subject: Re: [PATCH v3 17/27] moveconfig: Only show output when there is a
 reason
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

There is no point in listing a board if everything went well. It makes it
harder to see the failures, particularly on a fast machine.

Suppress output unless something actually happened.

Drop the 'Syncing by savedefconfig' since this is selected by the -s and
is the same for all boards in this mode.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Fix 'Supress' typo

 tools/moveconfig.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

Applied to u-boot-dm, thanks!
