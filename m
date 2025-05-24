Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95839C54E71
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 04:26:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CE9883443;
	Sat, 24 May 2025 06:25:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kUZSAplJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C19383409; Sat, 24 May 2025 06:25:38 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1828A83510
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 06:25:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-601aa0cb92eso640040a12.0
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 21:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748060734; x=1748665534; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M4ebnu8OmVIqmrwEDr5a4uarKQe24Oth8bbE74X+ThI=;
 b=kUZSAplJBPJZcele4wO7aRFK6qltw7dS156HEfqw+Dj++130mSqqKeklf/Mk9iS4j9
 4+nquWWbraMFthxYgpMdUVl/wCuaeo45BX45PtYLtjuYXf6F7wbV8x6vbG7QHFXaYQrP
 W9wtSIIDPxI3tSD+DX8sKpACOh9EguhxBASLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748060734; x=1748665534;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M4ebnu8OmVIqmrwEDr5a4uarKQe24Oth8bbE74X+ThI=;
 b=kQafoWqVrQT/4ycJvmn+qN9ptLNXkjwfSALanCSmzIUec1I4/K8AvazZrjOsTLyyz/
 U4Uw89pV+VEEMNI2JRA5Qn1f+or4N0bdbsGaosFSnlIFsr4217PbEshqvqpCaD5g7l9z
 YkbG5JV2mGWxM0sJwBasdLIRgLMOqUmi0P5OKeCDOqOq1jIw59CeEjl/N1069LIkRn76
 HfFNYZER3zVlvEoJfdzbwPGYMpOyjl94SxzYdSnIXPm9AXtekXKcxycNG1AaMZXDlZiY
 d7NyjUfg4jLZKR6f+BJIeIYzR7SA/fXZq5v17ukjWNKu2tit+TE+dhs9eyCuZIqwhNNC
 PfcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsPsg92XgXjyOjhbz7kmHN/2VkCfbqbvzOr0kO3pL5hIqhdZ3OOQEZ95peOS9QTwmrgwlNtbo=@lists.denx.de
X-Gm-Message-State: AOJu0YwEBu1lpDDCbJt0Os2yaFltxCR04z0NpfbdYHwmBD90QfWmsSl6
 CCBgd+pwZOCFSnanvNxvUMDawDqCzIDtNtcJmzdumi1pt29oLhhlEB8hpC92cK5f7QA3zXwbpmf
 TI1fOQSbzKJCw9Fj/JYqq2bmu+E3xtGgnnO1JK3Lr++ylnSc8XDWvwJrf
X-Gm-Gg: ASbGncs1o9hKMQYgoM0c6wiPD3BcoQd6hCTychtruefGNWQz9Bxc8nn7pk/sZBJEcxP
 sgKsvNuPksWqFGqRYWKRcBFiXJy2IjR2BltJdU+xIwvrE/z3v2fRorFwCJ+Cos0YN40DpTa65Op
 5dlV3U2ovl+U3n7PJ+SoA183Py+02dlkInAL31noPaUw==
X-Google-Smtp-Source: AGHT+IFftlImUZ3BCabqDoeo0YFbGePnTAqq2I3rjoWvcpyTpYP5HwafbsvK7ch0fnZRuSiSnDAqQkrTDq3EDjOJvJg=
X-Received: by 2002:a17:907:8686:b0:ad5:7dd7:837c with SMTP id
 a640c23a62f3a-ad85b183e22mr118043166b.22.1748060734589; Fri, 23 May 2025
 21:25:34 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 23:25:33 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 23:25:33 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250508072907.207175-10-sjg@chromium.org>
References: <20250508072907.207175-10-sjg@chromium.org>
 <20250508072907.207175-1-sjg@chromium.org>
Date: Fri, 23 May 2025 23:25:33 -0500
X-Google-Sender-Auth: pgpZsOifnafhO2r0dUVzZDoe-EM
X-Gm-Features: AX0GCFsvhmBrSyUeT3D7hTr57o21gOyqREfKFSoEXDPNMCDJ8uRMhIn8z0_W5mg
Message-ID: <CAFLszTiH9REDOVfb_nu+9jq1wVdytyN_RgVy73-D5c0v+NR3vA@mail.gmail.com>
Subject: Re: [PATCH 09/20] patman: Use .git as the git directory
To: Simon Glass <sjg@chromium.org>
Cc: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>, 
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

In tests, the 'git' directory is a subdirectory of the temporary
directory. Rename it to '.git' so that git will automatically find it
when git operations are done in the temporary directory. Set up the
config before the first git operation, so that this works correctly.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/func_test.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

Applied to sjg/master, thanks!
