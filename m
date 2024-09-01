Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A84CD3420
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 20:12:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 453B188BBF;
	Sun,  1 Sep 2024 22:10:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fCXJRBu8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 619C188C30; Sun,  1 Sep 2024 22:10:17 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 264D988BCF
 for <u-boot@lists.denx.de>; Sun,  1 Sep 2024 22:10:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1fc47abc040so28040345ad.0
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 13:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725221413; x=1725826213; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=X4AnpQD6ayEWOBc/C0eZZgqQZ/o7kwLsvutCikcOZY8=;
 b=fCXJRBu8YmrLom+GpzeYVnjW+ifWr3URWZkXz+0joKZnuDKfqelYH0IpX5SLTnHmld
 VfBqGkKSonMWJ556Ltq+I9VgPTbqOOKpvhabh9c9Ca4sR9mzI9GkZtuPvh4Z4cvP1iBo
 PUgP/aayaT9dwDwM5K+0zRou/jMb+cKGq3PVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725221413; x=1725826213;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X4AnpQD6ayEWOBc/C0eZZgqQZ/o7kwLsvutCikcOZY8=;
 b=pcWBu7n26dqEgh/0zy10whp9H9b/U4c+TMlA89vK2C5AGO5uVmS2jZMz7AWOilk4r1
 TcKtNqvoBgnUOVJwXSFNC5PgJtXajwwDybuKmnF5ojMA2hJxA3USl95kwxSvYASx6vL8
 MYryF9o6KSl26iUMPWOaynK2hVgOrElPTFTepv+Ot6XMy2iJPCj53QWtQoAINhn4JjhT
 E72vEUDrkJ9zov4lBD/s33XqvXOZmN4HmRyt94B0QoypI2vFVFAJT8xWTs4bRlM3CbEw
 q10p2x4Z22d4yne5Ys8RruxEVvLDXTgBK9/6es4pmaVR5arV4B9Lh8HfWyd1GaugaY7e
 IAtA==
X-Gm-Message-State: AOJu0YxDPx5fRXm1VjMsWlHaiM++m9CiTfHJtO2bEVte2gxIwbeF0P5G
 uSQEWcn2Rv9giXLl35ec5wwHtwYcjiApzhhRSDhLWi0xLGx2+UWTV5ahvd4aaPcL35p1ODoRtFO
 k1A6luDdBJPzac0N5ndfv+L8tV2Uifn+bXek9
X-Google-Smtp-Source: AGHT+IHqXEZcNeEKqnTBT/WKsnckDiR6KqK/K58yzBGjcCoXY9KgpRXL0HgAp5AWTg/LkHiF85sk8O71pD1x0AYz4JI=
X-Received: by 2002:a17:903:32c7:b0:205:7db3:fdd1 with SMTP id
 d9443c01a7336-2057db3ff8dmr10108535ad.36.1725221413563; Sun, 01 Sep 2024
 13:10:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1725012294.git.jerome.forissier@linaro.org>
 <655de02f937e3ea3a8f5306ef510d817bee8065b.1725012294.git.jerome.forissier@linaro.org>
In-Reply-To: <655de02f937e3ea3a8f5306ef510d817bee8065b.1725012294.git.jerome.forissier@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Sep 2024 14:10:00 -0600
Message-ID: <CAFLszTgrNpeObzMCpgg_gDfVNSsYNEzU2uZOgSB=B-Bcrpf5oA@mail.gmail.com>
Subject: Re: [PATCH v2 02/16] buildman/toolchain.py: set CROSS_COMPILE only if
 self.cross is set
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
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

Hi Jerome,

On Fri, 30 Aug 2024 at 04:17, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> In MakeEnvironment(), CROSS_COMPILE is defined to be self.cross (with
> or without a full path), optionally prefixed by the toolchain wrapper
> defined in ~/.buildman. This is fine when self.cross is not empty, but
> it doesn't make sense when it is:
> - Either there is no wrapper and we end up with an empty CROSS_COMPILE
> which is the same as not defining it (the host compiler will be used),
> - Or there is a wrapper and CROSS_COMPILE will contain only the wrapper
> which obviously is not a valid compiler, hence an error.
>
> Test case:
>
>  $ sudo apt install ccache
>  $ grep -q toolchain-wrapper ~/.buildman || \
>      printf "[toolchain-wrapper]\nwrapper = ccache\n" >>~/.buildman
>  $ make mrproper
>  $ ./tools/buildman/buildman sandbox_noinst
>  $ ./tools/buildman/buildman sandbox_noinst
>  Building current source for 1 boards (1 thread, 24 jobs per thread)
>     sandbox:  +   sandbox_noinst
>  +In file included from boot/bootmeth_efi.c:16:
>  +include/efi_default_filename.h:20:15: error: operator '==' has no left operand
>  +   20 | #if HOST_ARCH == HOST_ARCH_X86_64
>  +      |               ^~
>  [...]
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  tools/buildman/toolchain.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Can you please put this on top of [1]? I am trying to resolve a
code-coverage problem in the same function.

Also, please do add a test case.

>
> diff --git a/tools/buildman/toolchain.py b/tools/buildman/toolchain.py
> index 324ad0e082..ff987a9eea 100644
> --- a/tools/buildman/toolchain.py
> +++ b/tools/buildman/toolchain.py
> @@ -201,10 +201,10 @@ class Toolchain:
>          if self.override_toolchain:
>              # We'll use MakeArgs() to provide this
>              pass
> -        elif full_path:
> +        elif full_path and self.cross:
>              env[b'CROSS_COMPILE'] = tools.to_bytes(
>                  wrapper + os.path.join(self.path, self.cross))
> -        else:
> +        elif self.cross:
>              env[b'CROSS_COMPILE'] = tools.to_bytes(wrapper + self.cross)
>              env[b'PATH'] = tools.to_bytes(self.path) + b':' + env[b'PATH']
>
> --
> 2.40.1
>

Regards,
Simon
