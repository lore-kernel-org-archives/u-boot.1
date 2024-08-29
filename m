Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6976CC83F2D
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 15:03:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E392588CD5;
	Thu, 29 Aug 2024 17:01:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mm2DWYSc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FCBC88CD9; Thu, 29 Aug 2024 17:01:25 +0200 (CEST)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DBB988CD1
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 17:01:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-44ff7bdb5a6so4046871cf.3
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 08:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724943682; x=1725548482; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DyWDhzJ3gR3Lu//otGQuD+DLLRbpQG69hcPmRWyuNHw=;
 b=mm2DWYScXRGUUSJdvhdi8a2QdW/z1ftr9wM/AxnPC1WYLHv7axx91My0SOs+7dxfEs
 M0Of0+DJL6iZdY/jMZlox44QqI3Oy3de2lSy1SIxX/8btCEyIalJNmNVbS4JH1RmxCFA
 wdP1MCduX+nCAUKctpex/E5ObRZXHjCq1fZQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724943682; x=1725548482;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DyWDhzJ3gR3Lu//otGQuD+DLLRbpQG69hcPmRWyuNHw=;
 b=MK54rivrAicaSgGUQ0hCSd/eNZu52oQcmI94r3lRanfA2kCbYU46uI5WIQDQt6JmWg
 O2yswzpV+o4BGH1a6LRKTBRqmRrkm+XDshVPw34CWPYQR84UYqfML0+Q7EbZjh2vRfIw
 JFKLHZ3WuvDxw6twFE+jgQI18GQCUkRK0goQU342Efm299zeNh5J0HxF+k3iUTxaYVZP
 hm3dz5xPbD3cRsSwFHyqhE6zcLfV1obckcek7MTzAem118g/C+Kuu8dsH8jljvVHxrEH
 dX3bC9nxLddWEmih2JvhnlB8XCY1dHI9mM97GUeJvdRxHB1ncniUfTiVJxG31YjjJnvo
 I6MQ==
X-Gm-Message-State: AOJu0Yxwh3grikOXdAZCsLxClO/8EfQ1jkyorQrt9W6NYGx9lkhwJ2PF
 KWkkBwYxqI92Yw1SX3eJCkJDBgubrPXGhWjazAgnAQwmeQz1MA04Ln3MBlBmAET5HEoADLIshIL
 7oCRrpbBWE4LZeEjy6X/z4Tv4SwLJkJE3mZ+mjYPqo0ZQXR8=
X-Google-Smtp-Source: AGHT+IFpk+UVVP8DDivvY1yAoSFJ3IOnpCi/32r8EvSC+wr+moupubEgl3nkFjjmu0w1wrsMmovQxnYMj11YprpI+Ow=
X-Received: by 2002:a05:6214:4a0a:b0:6bb:be58:f28c with SMTP id
 6a1803df08f44-6c33e69630amr38598646d6.48.1724943682287; Thu, 29 Aug 2024
 08:01:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240828220846.1205813-1-sjg@chromium.org>
 <20240828220846.1205813-4-sjg@chromium.org>
 <b2a176a0-f3fc-440c-ba59-8bb97fb858dd@linaro.org>
In-Reply-To: <b2a176a0-f3fc-440c-ba59-8bb97fb858dd@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 29 Aug 2024 09:01:11 -0600
Message-ID: <CAFLszThcq98op7bcJY=-tW8EtVe6yav43tA0WnoXRiybdjDgaA@mail.gmail.com>
Subject: Re: [PATCH v5 03/20] test: Pass stderr to stdout
To: neil.armstrong@linaro.org
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
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

Hi Neil,

On Thu, 29 Aug 2024 at 08:22, <neil.armstrong@linaro.org> wrote:
>
> On 29/08/2024 00:08, Simon Glass wrote:
> > Some tests may output things to stderr. Ensure that this output is not
> > dropped, by redirecting it to stdout
>
> Can't you make sure to output all labgrid output to stdout in the hook script instead ?

Possibly. Do you mean having the hook script redirect stderr to stdout?

>
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >   test/py/u_boot_spawn.py | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/test/py/u_boot_spawn.py b/test/py/u_boot_spawn.py
> > index 97e95e07c80..81a09a9d639 100644
> > --- a/test/py/u_boot_spawn.py
> > +++ b/test/py/u_boot_spawn.py
> > @@ -10,6 +10,7 @@ import re
> >   import pty
> >   import signal
> >   import select
> > +import sys
> >   import time
> >   import traceback
> >
> > @@ -59,6 +60,7 @@ class Spawn:
> >                   signal.signal(signal.SIGHUP, signal.SIG_DFL)
> >                   if cwd:
> >                       os.chdir(cwd)
> > +                sys.stderr = sys.stdout
> >                   os.execvp(args[0], args)
> >               except:
> >                   print('CHILD EXECEPTION:')
>

Regards,
Simon
