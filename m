Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7997DC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:41:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B32A8788A;
	Wed, 13 Dec 2023 21:39:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C8J90HUu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 740D28786A; Wed, 13 Dec 2023 21:39:18 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EEE987871
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:39:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40c2c5a8150so67596615e9.2
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702499952; x=1703104752; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0aZRWGFdRZWLX5wC2q7JsdZ+MkXPmP0CHhAy0DdUpWY=;
 b=C8J90HUu2EB+KjoE+HJp1XQCQ1OdDS00gjd0BtysbgBDQoI7J/BuChM94XO15BhAQ8
 k3E6ErM9utbUf6MKMgSVu7XQBK/1K3vsklnyFO/jJpQ9vYLld0L+0RMZvgzzlIeZ5wHf
 gpktls/vNG7ivfbPvvtSuikOTXPMeJOjF4oY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702499952; x=1703104752;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0aZRWGFdRZWLX5wC2q7JsdZ+MkXPmP0CHhAy0DdUpWY=;
 b=I1g0ZQiUJPegKZRpYR0fEBF41b1esntUuDlO3n//uAG7FVMtLmg/rUs/t/zDRXLxpq
 909pLG2ikhSDsBV2cSURNDfOkh3UCR7nPO6eOGhPwUAEOwdFsRtE3PY+G2JGCu9J0/iI
 aUdQq+R1NFYd8FJtT6Twp2Ok2boapLenJNDbuFqTVopowg6TNbreNZUMxhWGI8SouIjV
 6j6uuqQ9D0mqIBTxkHF2gS0KprUmSn2NkGSAS2xmcZlWrtx9akphp+GmTuZlVWk4zubs
 Bdsm7b8V3zKluVqBu+aTBM4Nf1cqPi6aAq5HN5uB8WPYISDPstJFlSI7V4HUi6vwIRRS
 G0sA==
X-Gm-Message-State: AOJu0YzR6Nn62aEfuSGUqEeQHOfA+zVHQlKlo2lGjrQIGWYKea2/zvTK
 Cg5SiasdGzjkWnS24q5bJ3TPAz07w0KBT3xt2m6njg==
X-Google-Smtp-Source: AGHT+IFWV7DOt7TnWmiO+FDRZNpjSunqTfvkfxsrUO7BbG6jPu05b7RgPSs50aXaAktLUkFE3tFAKo4opjuMUAgujgQ=
X-Received: by 2002:a05:600c:2147:b0:40b:5e21:ec26 with SMTP id
 v7-20020a05600c214700b0040b5e21ec26mr4343656wml.88.1702499952348; Wed, 13 Dec
 2023 12:39:12 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Dec 2023 12:39:09 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231119153611.639252-6-sjg@chromium.org>
References: <20231119153611.639252-6-sjg@chromium.org>
 <20231119153611.639252-1-sjg@chromium.org>
Date: Wed, 13 Dec 2023 12:39:09 -0800
X-Google-Sender-Auth: DyC712S4k5fJ70kWZXuh5YfZFj0
Message-ID: <CAPnjgZ14yAOZfJcYK9KxT1w73Hr+UqivNrVzS2yGK7kQXsz+rg@mail.gmail.com>
Subject: Re: [PATCH 5/7] tools/make_pip: Add mention of u_boot_pylib in tool
 list
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

This is not a tool but it is handled by the script, so update the help
to include it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 scripts/make_pip.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Applied to u-boot-dm/next, thanks!
