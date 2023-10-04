Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B49E7C4E7
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 17:59:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F4CF875F4;
	Wed,  4 Oct 2023 19:58:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="etHxMJOU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EE57875D5; Wed,  4 Oct 2023 19:58:31 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6807B875DE
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 19:58:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-99bf3f59905so18038666b.3
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 10:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696442305; x=1697047105; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lg6j2c0N8SHTvR7J4pKspW9BZ1IiqKTF6ZrqRr+r5II=;
 b=etHxMJOUG+T7XirWlcxUjzKwNGTdKVSG4zwQUcWFzxYhSZIN98hkMoppw5a3TMDhXV
 SH08uAtTanIqbixXOAJ1m5PgHv7dv2+0m7GzO/CL0Sp8JRe84YMhapIfnI9vFiu3C0c2
 RdxiySI5EaecUGFurc84k46dv+ia7aAieWaEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696442305; x=1697047105;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lg6j2c0N8SHTvR7J4pKspW9BZ1IiqKTF6ZrqRr+r5II=;
 b=YucEp1/tl+ZDRTUinT5z/fZRRWp99M1sec3dDoka4d9zvqle28nDdPkNpyXqifrvVy
 OL0XvvmgWE6k8xBUnuPbEh1ytcrrTq6k118M7SyqHOdDj/wzbEghWgPc7lUb5ZyaP0Si
 bUogoqFSs/+1dIsgdNnnH5CD0+Ok/tcrSEZHpjlz5QMlmidnfljhVXMfO6GbfCtktR4C
 bq2Nq7HXCHtqYBIXFGvGHJDtEjNWYo5Pou03W3ynwXEZT8yv8kqdz7XZenNzVe+tf7z/
 2hOKS7ayiMrv6CiCG5MZXNNHH3+bauMGeDQJ5cnp6+242elCfSjC2fPhcIznTDs+1OZl
 jC/w==
X-Gm-Message-State: AOJu0YxL5Uh77KLpTaRCDtYyCl9jcr87lc5JGspzwqELRBiPTdGN3aC4
 lR9EqqyT1xwjmmxnJx8AjhBxLfjsE2cswUCBAWp0YA==
X-Google-Smtp-Source: AGHT+IGr1VeY/EwQlyGdkcHBnVhT/ZgFKUcn50iDukBejYEWhObMuumJIOeplxFenPau8l+96cCyCGhcjI7E6FK8klE=
X-Received: by 2002:a17:906:1db:b0:9b7:2a13:1611 with SMTP id
 27-20020a17090601db00b009b72a131611mr1910523ejj.38.1696442304475; Wed, 04 Oct
 2023 10:58:24 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Oct 2023 10:58:17 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20230923194424.1739224-28-sjg@chromium.org>
References: <20230923194424.1739224-28-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Wed, 4 Oct 2023 10:58:17 -0700
X-Google-Sender-Auth: U6RWdDCmptmUY_ND4S1Li9_Fk98
Message-ID: <CAPnjgZ2tcCMT2KpMkHt-Z-BreWzrSrcFauboXCV4jsVxJxRKXg@mail.gmail.com>
Subject: Re: [PATCH v3 27/27] qconfig: Update the documentation
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

Update qconfig's documentation to better reflect its new purpose in life.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Update based on Heinrich's comments

Changes in v2:
- Reinstate the -C option

 doc/develop/index.rst                       |   2 +-
 doc/develop/{moveconfig.rst => qconfig.rst} | 160 ++++++--------------
 2 files changed, 47 insertions(+), 115 deletions(-)
 rename doc/develop/{moveconfig.rst => qconfig.rst} (59%)

Applied to u-boot-dm, thanks!
