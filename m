Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16239C5B549
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 11:19:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB071832DA;
	Fri, 30 May 2025 13:18:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jnFCf8h3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28E0A8329C; Fri, 30 May 2025 13:18:53 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A28183285
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 13:18:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a4d877dfb3so1998989f8f.1
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 04:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748603930; x=1749208730; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Vf35Ajjg41nrzFArpcADdU6InuR26ZFzVOJaSbcnq8w=;
 b=jnFCf8h3PTmdqxyhpcFPXGKlWnTWRneVD7Mo0c4065WCNWGgMq1h1Kov1pDKfZFUKW
 pdSes2lgaiTALRwqjngreCgPgvPSFs1M98moZL27x/nVOBeykPzW/knQv1BgKq1rxk5q
 uZdWEP692kqGwedJ81vglPqptPXFwT2RIwxLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748603930; x=1749208730;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vf35Ajjg41nrzFArpcADdU6InuR26ZFzVOJaSbcnq8w=;
 b=LPxkV7kyvwZT/v5/PuFkb58rj9agI/jc561SUq7wiIbkXCOIxn1fY2TC2di4EIdfF7
 NqDsQx9lSY9pSrz1BXP48yhbySD6xClXQPcz53ne/y4np10baqAAEvztrU2tsev2uEPH
 lx3h7ytwlXUvEUxeOeakFsHWeaVM5hQWcAzwmdHy+4lxcm6MkWP5T82GjQYq+vk2fn8f
 Up5h60vrjcy1cGABr9cR/S2dXZxkqscV6tSRE11HJv7lGrMtGy8js/oCTLpyVuMH2FCe
 8V83jirjyo0nL+qdmrzwWXcuKogIfY20BDOzIn54pGgPlJu3zA0WvVxLd+X8N9hllfVo
 h0RA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWg6xz73R64bl6CmvggM50nlyhHY+2Uk+m1Mz55jLlh5cb48f6YYjP98e7kk6l9B7KI1YzVWmI=@lists.denx.de
X-Gm-Message-State: AOJu0YwujHpQjTYGKeuvmTd6rgmC834lcntzyZLwavFOut9jvHO+S12i
 vpKTtWIU/Rzg8Ae4gc/sFM/s2yyfl61EoUoJco4li/1NRyOnLs8rOiTK/ETQQSsx/p7frJ+OLQi
 80GvOy8lGo+qNbPnxYjj/yUsRNfbLNPH+kVe0ce4Kj1X6YvjkJgVt5g==
X-Gm-Gg: ASbGncu3qZ/z4WqBOaEhe0x2IM3/XqLRx+D1HA6MEPpbvc8rx1QdqZcANSK4ObG9BHX
 a+vtcfnsQT6Rq92lnpAd/x1ZeClhZwncis+X4fat3OqusQ7Tmdv3dzpXzgUFkG6mOoRihLat8m9
 PgrpmLpYAlHJF5w4K+3sxvvW2nG0cEIygk6h4yn4XBDjqY4J7OrNom
X-Google-Smtp-Source: AGHT+IGSyQy+Not2XuBHsOTOqTCmQsMv7zPH/DGcfhekSmIivObxiwPsjb+CRA0s9nj8iPArdS8AxCOf+WrV7KY+DVs=
X-Received: by 2002:a05:6402:234f:b0:601:68ee:9641 with SMTP id
 4fb4d7f45d1cf-6056db21285mr2622938a12.10.1748603919916; Fri, 30 May 2025
 04:18:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250527-binman_faked_optional-v2-0-3362ab897581@phytec.de>
 <20250527-binman_faked_optional-v2-3-3362ab897581@phytec.de>
In-Reply-To: <20250527-binman_faked_optional-v2-3-3362ab897581@phytec.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 30 May 2025 12:18:25 +0100
X-Gm-Features: AX0GCFtPqbOt8kP8PeZXsnLXXExkcTZcHX0oq6kkqgsqesFevVr9acasejNhDwk
Message-ID: <CAFLszTj26VDM0nQOscCwDzhB0LEJMF+OvdMEo_egPoCzgSg-SA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 3/8] tools: binman: mark optional missing blobs as
 absent
To: Yannic Moog <y.moog@phytec.de>
Cc: upstream@lists.phytec.de, u-boot@lists.denx.de
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

Hi Yannic,

On Tue, 27 May 2025 at 14:24, Yannic Moog <y.moog@phytec.de> wrote:
>
> Optional blobs should mark themselves as absent to avoid being packed
> into an image.
> Extend the documentation of this behaviour. Although the documentation
> implied this before, the "optional" property had not been explained
> properly before.
> Note that the intended behaviour is the same, this patch just documents
> it.

This seems to indicate that it is just a doc change

> The actual behaviour will change as now absent entries are no longer
> packed into an image. The image map will also reflect this.

But this indicates that it changes the functionality. Can you clarify
this in your commit message?

> As a result, the CheckForProblems() function will no longer alert on
> optional (blob) entries. This is because the missing optional images
> were removed before CheckForProblems is called.
> This, as well, is intended behaviour.

This breaks testExtblobOptional() for me.

I applied your patch: tools: binman: drop "faked" return value from
check_fake_fname

Then I applied this one and got the error.

I could not apply patch 2 (ools: binman: ftest: pass allow_fake_blob
to _DoReadFileDtb) as it broke a lot of tests.

For testExtblobOptional() I see that you have fixed it by the end of
the series, but I get 11/12 test failures . Are you able to make the
series bisectable, so that 'binman test' works for each commit? It's
hard for me to comment on the series in this state.

Also there's no need to put an 'RFC' tag on this series. We do want to
resolve this, one way or another.

>
> Reported-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Yannic Moog <y.moog@phytec.de>
> ---
>  tools/binman/binman.rst    | 7 +++++++
>  tools/binman/etype/blob.py | 2 ++
>  2 files changed, 9 insertions(+)
>
> diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
> index 84b1331df5c006f72167016b7f33de73f4a269fa..392e507d449c75eeba4431fe2db01d820bce8f61 100644
> --- a/tools/binman/binman.rst
> +++ b/tools/binman/binman.rst
> @@ -1143,6 +1143,13 @@ Optional entries
>
>  Some entries need to exist only if certain conditions are met. For example, an
>  entry may want to appear in the image only if a file has a particular format.
> +Also, the ``optional`` property may be used to mark entries as optional::
> +
> +    tee-os {
> +        filename = "tee.bin";
> +        optional;
> +    };
> +
>  Obviously the entry must exist in the image description for it to be processed
>  at all, so a way needs to be found to have the entry remove itself.
>
> diff --git a/tools/binman/etype/blob.py b/tools/binman/etype/blob.py
> index 970fae91cd9b2a31b3f31d2ecdb77e27a89d69fb..acd9ae34074e4b4b9792b107cc80514dfdd88b3b 100644
> --- a/tools/binman/etype/blob.py
> +++ b/tools/binman/etype/blob.py
> @@ -52,6 +52,8 @@ class Entry_blob(Entry):
>                  fake_size = self.assume_size
>              self._pathname = self.check_fake_fname(self._filename, fake_size)
>              self.missing = True
> +            if self.optional:
> +                self.mark_absent("missing but optional")
>              if not self.faked:
>                  content_size = 0
>                  if self.assume_size: # Ensure we get test coverage on next line
>
> --
> 2.43.0
>

Regards,
Simon
