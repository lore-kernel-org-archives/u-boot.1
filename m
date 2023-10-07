Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F958E95A6A
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 20:38:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A38486D7E;
	Sat,  7 Oct 2023 22:37:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="We3PwWTY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47173863CF; Sat,  7 Oct 2023 22:37:40 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 702DD8694A
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 22:37:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5362bcc7026so5845300a12.1
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 13:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696711058; x=1697315858; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XQkRJLeigVXEN/EVAKQ5w2GU1EEeP96Rh7s2nW4UEeA=;
 b=We3PwWTY+Z0mZooSMQGVAy0dXEPWHYB4DpIxzQ83BiMDZ8XFbXRULm7VlMFSfR9fD7
 Jb5ASOkj9ZblssyRpKUSjZpR4NDGrU6Wu3kkknaxnx9M+Hq0fSx/GWk5TO/uDNgUFmPi
 DW24/XHu/6J8bOxmAnUsyikCsykV7MS2ptKh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696711058; x=1697315858;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XQkRJLeigVXEN/EVAKQ5w2GU1EEeP96Rh7s2nW4UEeA=;
 b=tV7MYSFIXxciestG9jZ8YVFc9gUhP+SB5TPW0f0LsXqQzkID/3Rq8NJQ3qUGjfUcdf
 /NCVZ+/h0VQFKISq67khctRiLnBmShCsmb3UJuMey/TfjYagO67CT8ZsnpCSl41wzv1B
 EQhbQ9vmFb6iyKBGjh9N6n0Mp7WZodhWK92WOnoFCtxLBMoRIzB00oWTZLFhBe99xUQj
 5JAvMF6ZIlTslNPZYz5dflfw2R+IXU1C5+LunJ4XfukF+diGSYPhEl/uc8F7jiBBFTry
 tN7m6NACAa7rln0jsmDv7u71jcutdIYEJdg7nhrAmT+wUkoE1LzYiEylWFlHO6stgrb7
 qw3Q==
X-Gm-Message-State: AOJu0Ywzoihhi/EUX6dWJIjW3dM1mUPpL6TxDcX3iFgWFO4tAZ1F01qB
 bww1WHl/mXqEgily605qwCep0WekgxHAT8Tl1vL52A==
X-Google-Smtp-Source: AGHT+IG/D1T1GWJFcBjn337aTYjZhSo9MyHE+6jw1W/RMBqwfSBpnVAEDb5lgspWj6+PjgsDhnncn1BNafwEzFbyqGc=
X-Received: by 2002:a05:6402:124c:b0:52f:a318:d7a0 with SMTP id
 l12-20020a056402124c00b0052fa318d7a0mr9190921edw.26.1696711057796; Sat, 07
 Oct 2023 13:37:37 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 7 Oct 2023 13:37:37 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ0LJetkR4wJtK_bWrOVyzEYS4txEBtDOtkc46sNGU0HBw@mail.gmail.com>
References: <CAPnjgZ0LJetkR4wJtK_bWrOVyzEYS4txEBtDOtkc46sNGU0HBw@mail.gmail.com>
 <20230923194424.1739224-27-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Sat, 7 Oct 2023 13:37:37 -0700
X-Google-Sender-Auth: DPo-kVVO9HkDciR5KNHeYbufAkI
Message-ID: <CAPnjgZ1dqtL3ySMaAFSOr=jbEm8Qn6ooX0NBOGPQO2x+z6xCLg@mail.gmail.com>
Subject: Re: [PATCH v3 26/27] qconfig: Rename the database file
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

Use qconfig.db as the new name, to reflect the tool's purpose.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 .gitignore       | 4 ++--
 tools/qconfig.py | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

Applied to u-boot-dm, thanks!
Applied to u-boot-dm, thanks!
