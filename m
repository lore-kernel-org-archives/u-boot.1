Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4383ECDE03A
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 21:36:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA3D288EAF;
	Thu, 26 Sep 2024 23:36:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l5SO/Fwo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7B3F88E8C; Thu, 26 Sep 2024 23:36:26 +0200 (CEST)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44C7988EEE
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 23:36:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7a9a30a0490so142068185a.3
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 14:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727386581; x=1727991381; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YhZn4lBRaTsy5GsGEcaGlTcXw7lBcGw7RTbgF084KxI=;
 b=l5SO/FwomTXuLTZlOCnaeFEVhduqCrQunbEBUT/VUXeoFZv+tU9sdfbeaa0yPdNTLK
 aU3A9cYdXr2OIvAlMewc5i7l+2xav7HUo0KN499g3NQXEKTneXeRoCTfOHP0+m22hUWo
 K8bS4WWcW1MXBRAy96REzra8hmfU+urXjXlpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727386581; x=1727991381;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YhZn4lBRaTsy5GsGEcaGlTcXw7lBcGw7RTbgF084KxI=;
 b=kfTZ+QqqbAMAYGW7OTUAxjhl4lMsOAs4L48n0ijVpIgeeCD5zbK91qNl9h5/sTz2R6
 MoZ+IwJO6uAsJn0El8QtwJa/AM2Yi3CLm5RqVSLKnKB1DdIyn2Lesvnzt7/OybgWLv9g
 ToOr36JdRRTe0nbkLk4MTr8dkS2OOepYsf9XD1JU9uMgyQY+Rfd4NuIASWzk8PtL4EQ1
 tAeKZcQmKBd/Apxg3/TNcHASUZKGeFemg3miZc/zcu2LfEszraJSOhUlviUYSZmcexH4
 xkENFDe6iO8D4OuuQZ7PnP4xOf98GnoKP2TGeFLpgglkM83rwBv/CtkY2Xktf+l/oImz
 kJmw==
X-Gm-Message-State: AOJu0Yz2FHwr5a5RpA1aT/7M9d/uOSJA/IFFkVExq6IVHrN1dCWIdww4
 bwzZQE8h6MpScWTVhcgS0btg8kxogi+VvJyQgTDawiGwCZRSKnRkSyRXzvQbLtDR431xoiJkvO+
 Wm7pFCQ2+71FZcX4P8yyMxh+m/5fXnvf3MzWy
X-Google-Smtp-Source: AGHT+IFt4e2uMStq18MQA3WUBix249GqTqSFTGFYtsWOEGUkW1iFkRLRiZc6q11ZmrBtoqAgHgBOxrSEN2nVr8SgdtE=
X-Received: by 2002:a05:6214:5411:b0:6cb:20b6:f39a with SMTP id
 6a1803df08f44-6cb3b5c7d52mr19531366d6.13.1727386581161; Thu, 26 Sep 2024
 14:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240925125622.197915-1-sjg@chromium.org>
 <20240925125622.197915-5-sjg@chromium.org>
 <20240926040649.GG4252@bill-the-cat>
In-Reply-To: <20240926040649.GG4252@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 26 Sep 2024 23:36:09 +0200
Message-ID: <CAFLszTjYs=A2jTTxH7GyYMDFBzb=Z6JNnLzGecy6Uv9wM2XizA@mail.gmail.com>
Subject: Re: [PATCH 04/19] spl: Provide a way to mark code needed for
 relocation
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>
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

Hi Tom,

On Thu, 26 Sept 2024 at 06:06, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Sep 25, 2024 at 02:55:30PM +0200, Simon Glass wrote:
>
> > Add a linker symbol which can be used to mark relocation code, so it can
> > be collected by the linker and copied into a suitable place and executed
> > when needed.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  include/asm-generic/sections.h | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
>
> This patch, unless there's an implicit dependency on the other series
> and so introduces an #include leads to fail to build on sandbox.
>
> https://source.denx.de/u-boot/u-boot/-/jobs/906194

Yes it is in part D:

https://patchwork.ozlabs.org/project/uboot/patch/20240920072444.134997-2-sjg@chromium.org/

Regards,
Simon
