Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A96FE7716E
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 17:57:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 092808950A;
	Thu,  5 Dec 2024 18:57:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H1qZBzTh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FDF0894F9; Thu,  5 Dec 2024 18:57:47 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F9E1894BD
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 18:57:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aa5b0d8bd41so177105466b.2
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 09:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733421465; x=1734026265; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9o0wc/ggbQQ1/jBf1QJyfOAIRkB1hT+LtGrF8QF4OCw=;
 b=H1qZBzThRgnkm/ou8SeT8O4AGNeuu/hp1ae5d9cIFz/ZqWTdl7UPxlPKTO17gX8+rm
 NYeLW95OzwVgSEyBE6HGQGEv438b4REEXczT3vtwtLyfzlJWdQDtLX17FQO96q73aaQq
 M7rsdPvyaGSWO8J8iggb34lbe1ZYvJJGMBjMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733421465; x=1734026265;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9o0wc/ggbQQ1/jBf1QJyfOAIRkB1hT+LtGrF8QF4OCw=;
 b=Z1pP7LTFykWyPzMde+0pgQAXiteF5/gvPRR3y2zSRaElk8/hoROshIbJ9UugWFfhYe
 bonnmLbCvYiOjTVR5gjl9d4cZzHkFAIC4I0VQRDqbiyCHjTn3ufqz0a+ImDnwCF1iXGV
 hXyVly1gNkhrEPhUg1F4UhJuSTHdkgC1TN+I25vsl6N6Sdrljy3010yX594ulhQkGiBR
 /EHiUE7+CLhiKrL+Lmbz46S8DMoCtCpLiI8Bo3JoWTfF82Lbb16wOfSzxor+lfyJ2lHG
 F2vjVSlbskP3b8k8jhkuapdGHLOxbg5D/R8rTVv9Vhl3P5hcWbQ1KbkMyIn8RCQ+hvjs
 CTIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvguRG2eflo6lIPss9htdkm/8RxOoUscxuwBSs/ZO/WxCKoUp6hfCF9pwYD983BCZ5UlbtuAI=@lists.denx.de
X-Gm-Message-State: AOJu0Ywto+mpU5HzsFVnpnMa6fYCRhJ5ct0VFhpLw0Gl99HOV++kxAxA
 6tBep6UISEK8dpcCP64j39xfWY+Ug4fNIlasv2Eo0zfFpyumxO0VtTEJnBef0GSynrwzqfNeGu8
 XKE39DhcT8prIqOxICDL9tp06fPpqwt9MxPdr
X-Gm-Gg: ASbGncvRUDSdvQhvVHE5SCAZYrOXqUZykq/dIuytc3/97++tSxFi7a4ywdBsfwYA15C
 x2+DwmwytSzJYSK3UFTRn2pVqkd0dEGGq
X-Google-Smtp-Source: AGHT+IEOPnzyxuNyJCWHKgdbWilFtqlZV9SYJjHFK+n0nlJhXRy9zTdtdRZKHNItVz1gcb2IoI6Sy9W85x+KvB3H9kU=
X-Received: by 2002:a17:906:30cf:b0:aa5:1551:99f2 with SMTP id
 a640c23a62f3a-aa5f7f4ad09mr731834366b.49.1733421464812; Thu, 05 Dec 2024
 09:57:44 -0800 (PST)
MIME-Version: 1.0
References: <20241204183313.144473-1-l.rubusch@gmail.com>
 <20241204183313.144473-2-l.rubusch@gmail.com>
In-Reply-To: <20241204183313.144473-2-l.rubusch@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 5 Dec 2024 10:57:30 -0700
Message-ID: <CAFLszThu2Oh9Q6zY5Zgc-fUJzmAfsOZ6EUEoMx_jHo751J+ZgA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] doc: develop: Fix typos and wording in
 binman/binman.rst
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: trini@konsulko.com, alpernebiyasak@gmail.com, ada@thorsis.com, 
 xypron.glpk@gmx.de, mkorpershoek@baylibre.com, 
 dario.binacchi@amarulasolutions.com, u-boot@lists.denx.de
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

On Wed, 4 Dec 2024 at 11:33, Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> Fix some typos and duplicate words in binman.rst.
>
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  tools/binman/binman.rst | 234 ++++++++++++++++++++--------------------
>  1 file changed, 117 insertions(+), 117 deletions(-)
>

There are also some debatable change here, but since you've gone to
the trouble of such a laborious tidy-up:

Reviewed-by: Simon Glass <sjg@chromium.org>
