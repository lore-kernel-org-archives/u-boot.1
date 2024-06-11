Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E796C27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 19:20:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 957F78869E;
	Tue, 11 Jun 2024 21:20:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dIR1GwoT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D47CE88655; Tue, 11 Jun 2024 21:20:05 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF8DB8839D
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 21:20:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-62a0809c805so61652867b3.0
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 12:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718133602; x=1718738402; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3AdshU1Ar1YpEjXa/TWW4PMYPChwySLmmtZKpUAcdt4=;
 b=dIR1GwoTyWh14hKs1MYtEeWo1zlqoecucb1MlieXAGTiDnmXyS7NgvGfQ75qAUq3NO
 7fVt9bzUkgN/E7duLXdF0lASt1jUNOVCdy5ZWkJMkV5V/0rhEii4QaTOaVDzEkfw9Bqe
 mFtNop465g31MwcWVHGm9aeoaGkSZ4ZA1IBsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718133602; x=1718738402;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3AdshU1Ar1YpEjXa/TWW4PMYPChwySLmmtZKpUAcdt4=;
 b=cqoMgL/7r99Bo7SR0qV11tAVB4QV1VirQxERCRHGx86kKiSDUMCuH82P5KpH5NLD7f
 E0eXinv/z/r8mDx8gBCnED3nzdNOSe9tI21BWOgkXH6PHxx5lQUcmyKa23GrGK/VIvE9
 RV1sb2F67tJapJlpS0S1KHGsBCQR6oUEFJvsFw08aW7y2Wb6/H7/e9nDC0sQwhRNNBD4
 ub3DVVyLG/89jxCy1sFsqvgx3UzXuUzotEGJQdBitYnU/PD1LfZLnzB7fIvy+dB4xF2F
 xv1m//3TCSwmNZ6PlmsH4AGA4uqRvKvqEAXAmigjNlno5ymn/nEKeOg7oiH6W4dNStob
 w43w==
X-Gm-Message-State: AOJu0Yyp9ysilmXrgEzcTeOeQMoecTEfY6LVehV9py/ZNT1d599QTQ0g
 pMw/2oGElW6mvy1HhK1+hgZz3d8L0DRSnzG9erP+q2mdkYESQc+XnD+Q2mojT49hozZcJOBiEhN
 6V91O59sBNTMlpUDeZAXHeclWRyRV64UaHADI
X-Google-Smtp-Source: AGHT+IGeYNfBgofSaz48E8ytFbkLOgRTi195ssKz0aKXKwPLzCnivWt9jX77Oa6Rfc2IdpehPTn+7wVOmERhmpjTyEo=
X-Received: by 2002:a0d:e447:0:b0:627:88fc:61e4 with SMTP id
 00721157ae682-62cd5571ca2mr128801837b3.1.1718133602324; Tue, 11 Jun 2024
 12:20:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240611144031.1311008-1-ada@thorsis.com>
In-Reply-To: <20240611144031.1311008-1-ada@thorsis.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 11 Jun 2024 13:19:51 -0600
Message-ID: <CAFLszTiROkbpMucrBZtyZG=MgvmkQ-At3CH73c=OFiJHano9tg@mail.gmail.com>
Subject: Re: [PATCH] doc: Fix link reference to general verified boot docs
To: Alexander Dahl <ada@thorsis.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On Tue, 11 Jun 2024 at 08:40, Alexander Dahl <ada@thorsis.com> wrote:
>
> Fixes: ad29e08b79fd ("doc: Bring in FIT signature files")
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> ---
>  doc/usage/fit/signature.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
