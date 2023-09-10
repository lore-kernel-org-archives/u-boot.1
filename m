Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C51C9C71153
	for <u-boot@archiver.kernel.org>; Sun, 10 Sep 2023 22:37:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D72F86CD6;
	Mon, 11 Sep 2023 00:37:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cce1QLth";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 220E386CDA; Mon, 11 Sep 2023 00:37:12 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E5DE86CEC
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 00:37:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-52713d2c606so4991545a12.2
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 15:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694385428; x=1694990228; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=INzZ2P2p2DsH0uq5EmiLubkBF9nToqNexAHPCac7paE=;
 b=cce1QLthG953Nr+q3IybhHTnvnPubYWCOw8t72t7CogU2jkmoQ3Ij5pfwL79FvEBuW
 4Ghtures+whpeMcrJ5q+Xycucg7gsO1r98updWy2Yt7GvyLQHmwGSH6nQWLP7igcYOyN
 idf9ugVBjo+LNgb7PGN+2MsLeQuL7Er7dfYUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694385428; x=1694990228;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=INzZ2P2p2DsH0uq5EmiLubkBF9nToqNexAHPCac7paE=;
 b=XORr0Gc3a+PC8s1hNxe6vBZSXQuw0JN8fgI+4Fz1UGwiB6hKYE5/MqJL4aPK75lnvw
 y4oxsSVY1y4cFroCaXeAgnf7N2PWVTdWqCvTz/uxgxOickUjbwS6dMFyyUJNR94WqHtD
 CeNFqL0g9xQ4LRySkjmC7jHigxHPR551p/40SAeRnvBkrY6qktJhiw1lUaeznQv5t1u3
 J++zC5hOwPlNBXU3nd3TfDJzccKeCxkAlWk35ldTV5ay69dRXf4cQPvCkUMAb5AOCc0J
 2smlAcOUnvwWYHEa2M2LVD5moQOKbUt8Cg6gIFVTwjwXyBKfSDLI/SSHyAQZTCSepoEx
 695g==
X-Gm-Message-State: AOJu0Yzl3392N/84/cvIYgf9SGfCHXkUDwqXHI/RiywIuQGaIqxbRVva
 a9KdA6HItEcyfgkflvkI7g+nywrK3I0ko/8+3cEnzQ==
X-Google-Smtp-Source: AGHT+IHP2xVtgMzIBhSSbBMSEoLJml4PwX7suBZnmzUgJuzvEkZhE7609PnpCuA4aHSD/Mn2m2A2zoZ2zvhSNSGCT8k=
X-Received: by 2002:aa7:c6c8:0:b0:523:2e0e:5462 with SMTP id
 b8-20020aa7c6c8000000b005232e0e5462mr5527757eds.42.1694385427874; Sun, 10 Sep
 2023 15:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230905180959.392276-1-afd@ti.com>
 <7ef8bf43-f84d-a76c-afa0-f87a55d57c84@ti.com>
In-Reply-To: <7ef8bf43-f84d-a76c-afa0-f87a55d57c84@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 10 Sep 2023 16:36:53 -0600
Message-ID: <CAPnjgZ0+JaYX5sA=bYwiG_+F43t9torPqrbwkfgM9m1EeijbuQ@mail.gmail.com>
Subject: Re: [PATCH] Makefile: Force regeneration of env.txt
To: Andrew Davis <afd@ti.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi Andrew,

On Tue, 5 Sept 2023 at 12:15, Andrew Davis <afd@ti.com> wrote:
>
> On 9/5/23 1:09 PM, Andrew Davis wrote:
> > If the source .env file changes to one that is also older than
> > the generated env.txt file then it is not regenerated. This means
> > when switching board configs we do not regenerate the env. This
> > can be tested easily with:
> >
> > $ make j721e_evm_a72_defconfig
> > $ make # this may fail to complete but that is okay for this test
> > $ make am64x_evm_a53_defconfig
> > $ make
> > $ vim include/generated/env.txt
> >
> > Note this is still the J721e env not the AM64 config as expected.
> >
> > There is probably a better way to detect if the dependency name changed,
> > but that may involve extra files and hashing contents, so let's just
> > force it for now.
> >
> > Signed-off-by: Andrew Davis <afd@ti.com>
> > ---
>
> This is basically a revert of:
> 36fc832927eb ("Makefile: Fix incorrect FORCE deps on env rules")
>
> But without changing the `include/generated/env.in` rule. The more
> I think about it, that should also be changed to forced as right
> now any changes to include/config.h or other kconfig options are
> not reflected in the env.in file after updates.
>
> That rule should depend on the generated config file so that any
> change in kconfig variables will cause it to regenerate, that
> might be what we need for this target instead of FORCE.



>
> Andrew
>
> >   Makefile | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 9be24c4ec61..d195590d4b0 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1830,7 +1830,7 @@ quiet_cmd_envc = ENVC    $@
> >               touch $@ ; \
> >       fi
> >
> > -include/generated/env.txt: $(wildcard $(ENV_FILE))
> > +include/generated/env.txt: $(wildcard $(ENV_FILE)) FORCE
> >       $(call cmd,envc)

I thought that FORCE was only for if_changed - see makefiles.rst.txt

Could it depend on autoconf.h instead?

> >
> >   # Write out the resulting environment, converted to a C string

Regards,
Simon
