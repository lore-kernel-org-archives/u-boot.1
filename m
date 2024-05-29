Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD47C25B7C
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 16:33:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE2BF88658;
	Wed, 29 May 2024 18:32:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mNtApH5M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 003C98860B; Wed, 29 May 2024 18:30:01 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5D9188606
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 18:29:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6ada6a476c2so2519876d6.2
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 09:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717000199; x=1717604999; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2tt8YtqpTmRDOdcxcIpam0z1KV7ews6HfuweLXaFc38=;
 b=mNtApH5MAiiN13BFmnQ07YC9M3bZKwWnlppguD/IgvnjGU6zCEeU1PKfcbYvXoIY5e
 EGk4Gb6dGk7u/KRx7gH4KoSCe/d9bKDo2JxIzSCNE8o6VPYoGkmatCEObK0/GLoonJBU
 dCDUFY9YdLRx/Q3yZ26QswopOCgSFtUwIIkq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717000199; x=1717604999;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2tt8YtqpTmRDOdcxcIpam0z1KV7ews6HfuweLXaFc38=;
 b=NOzuU903qSq/iSL4lorBkXkfJP/gHhCAe2iwDH3OKrGLlZ5xSziyQbDGod8917Xo3o
 zysMtfRzm1f+KURI/VCv9qXS0OQ5i/+EXeK0UqG1g+r3wlbmJeh9qUP9YJ6+csjI1Gtq
 bOPPrIdN+ua22pzcQPQYLtFzBNNv9U92bLaZZ2uM4cmRIDUNXU5oSzzBnhEp5GO/uEAC
 q+fGlRYNsRemTJzHLeYOj3U7z6drSB4iRIpI0HB1OQgH0ud4YpvdNn5BBtAMA7w0G4hq
 N95Hrk5lyhdv2NZ9tC+JY4Wu5z4nsC4uo7Q20jVDiPyvUpWrYy+Us49g1ex2yD8wRkR5
 mWbQ==
X-Gm-Message-State: AOJu0YxjFCCn1kV/kqqf4AzPRqw4C9x7pRR07NOcOeMCY9t7XVh3oy4R
 EucZxHZ4K+wL+pyl3lXmrv9csvL1m3gZTuQhqiIoWAoXREoORuKjwOcqxKzcJluvfPMx79UT7rm
 lCKlKi3nTnRtC8nqAECrRa0/8Wi1MlHzzupbCpzedoAIneHY=
X-Google-Smtp-Source: AGHT+IGn4WraX6qxrm1mQZAWbWCOlcaR8oF8tTGQJgrsDp21TCjOYBlC1k8jSsfFYnecyhwWL5KtbyW0XnzGAdh4Aqo=
X-Received: by 2002:a05:6214:3909:b0:6ad:a31b:1ad5 with SMTP id
 6a1803df08f44-6ada31b1c39mr16289936d6.59.1717000198801; Wed, 29 May 2024
 09:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240524-bootflow-doc-typo-v1-1-d8e64a40e2b1@baylibre.com>
In-Reply-To: <20240524-bootflow-doc-typo-v1-1-d8e64a40e2b1@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 May 2024 10:29:47 -0600
Message-ID: <CAFLszThnZsc6FJH936JGigAoH_ePtNAxkfh2vJd+-p9jO3o=5g@mail.gmail.com>
Subject: Re: [PATCH] doc: cmd: bootmeth: Fix extlinunx -> extlinux typo
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 29 May 2024 18:32:00 +0200
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

On Fri, 24 May 2024 at 07:28, Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> Fix a trivial typo in the bootmeth documentation.
>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  doc/usage/cmd/bootmeth.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
