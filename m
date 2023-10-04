Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C70E8FDC5
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 02:13:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91714874A1;
	Wed,  4 Oct 2023 04:12:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SBBQXExg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE21E87272; Wed,  4 Oct 2023 04:12:25 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7651A8747D
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 04:12:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-59f1dff5298so19844167b3.3
 for <u-boot@lists.denx.de>; Tue, 03 Oct 2023 19:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696385540; x=1696990340; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JntiJ03fwDwDUoE1ZQEM4rfSn2FrbjCcRZWFtKSpy5Q=;
 b=SBBQXExgitEUCGuaHnifnRWryA1qOB0w6a97ERH8gsNpRE8QZmso/P55FpKAvQfH/w
 ZJQXUCwo9fKCpcBZ+UE0vlElob2KeGvYppkl1wCRr6GgVvGWz35oSJKZ4dyuJLexsygC
 xxRdlgpGPAVF8++Kgol8ejOJ099wNCzuQEFdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696385540; x=1696990340;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JntiJ03fwDwDUoE1ZQEM4rfSn2FrbjCcRZWFtKSpy5Q=;
 b=LifxY3gVfw7zJVmj8JudxGd1+Kheptaopx5qMogC33VmOzNRoOaES9bfcW229JIKRl
 fgx+YJsTQBLBn2aYOY3sDChp7IS9nlvFnhI0qAWLabneQbfP5MUhK/w2t5nCsqf35PYE
 apLiH3OUERmPBpmezdddGlwr7EHuN4ieslhp0KK86UbvuxXZin/PJieD/+dStIKrmsxT
 1eKoyTSgozBb3ZMIyL3NgUj1uHFBLagSEKCfxtGZUuwz/WsdXXcKZ/XqFAglhtZuymfq
 qHz81E5C9R6yvqGUEg6AsP90+R/ZOQJiCvWu5swksWnPWjaiWim+Vmrks8no1+jF31eO
 bWig==
X-Gm-Message-State: AOJu0YxUvFMRy26i2+nsLFgCd5nS+3oMeuAc9FwXtDvsLos5c+fCiWqt
 YE7vHaaKxrwnTldTF2vP7HEKwWTixjVIacjUIs2FGA==
X-Google-Smtp-Source: AGHT+IERrIkzxIu5WSaScHRZ9Hnlzzv0pr/u8cML06ng8Di/JMCcxkxz7TOUj2ametCaCR8QFzKUGFZhg/Ut1i/1lbg=
X-Received: by 2002:a0d:f245:0:b0:595:89b0:6b41 with SMTP id
 b66-20020a0df245000000b0059589b06b41mr1308792ywf.38.1696385540446; Tue, 03
 Oct 2023 19:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231003100217.3721395-1-rasmus.villemoes@prevas.dk>
In-Reply-To: <20231003100217.3721395-1-rasmus.villemoes@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Oct 2023 20:10:54 -0600
Message-ID: <CAPnjgZ2LYithR2_n3h51WZBRPCapw7XuYEGYoZaWg_PXUNcWxg@mail.gmail.com>
Subject: Re: [PATCH] Makefile: make u-boot-initial-env target depend
 explicitly on scripts_basic
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Tom Rini <trini@konsulko.com>, Max Krummenacher <max.krummenacher@toradex.com>
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

On Tue, 3 Oct 2023 at 04:02, Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> We're seeing sporadic errors like
>
>   ENVC    include/generated/env.txt
>   HOSTCC  scripts/basic/fixdep
>   ENVP    include/generated/env.in
>   ENVT    include/generated/environment.h
>   HOSTCC  tools/printinitialenv
> /bin/sh: 1: scripts/basic/fixdep: not found
> make[1]: *** [scripts/Makefile.host:95: tools/printinitialenv] Error 127
> make[1]: *** Deleting file 'tools/printinitialenv'
> make: *** [Makefile:2446: u-boot-initial-env] Error 2
> make: *** Waiting for unfinished jobs....
>
> where sometimes the "fixdep: not found" is instead "fixdep: Permission
> denied" and the Error 127 becomes 126.
>
> This smells like a race condition, and indeed it is: Currently,
> u-boot-initial-env is a prerequisite of the envtools target, which
> also lists scripts_basic as a prerequisite:
>
> envtools: u-boot-initial-env scripts_basic $(version_h) $(timestamp_h) tools/version.h
>         $(Q)$(MAKE) $(build)=tools/env
>
> However, the u-boot-initial-env rule involves building the
> printinitialenv helper, which in turn is built using an if_changed_dep
> rule. That means we must ensure scripts/basic/fixdep is built and
> ready before trying to build printinitialenv, i.e. the
> u-boot-initial-env rule itself must depend on the phony scripts_basic
> target.
>
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

I have wondered for a while if we could have a few tests of the form:

- build sandbox
- delete an output file
- build again
- check that the build succeeds and the file is there

Regards,
Simon
