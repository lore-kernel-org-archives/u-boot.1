Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABEBE7718A
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 02:44:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E76280352;
	Thu, 19 Dec 2024 03:43:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Db0cetCw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72A6880352; Thu, 19 Dec 2024 03:43:54 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E1718036E
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 03:43:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5d7e527becaso442762a12.3
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 18:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734576232; x=1735181032; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AbkG815MZnPqgZdcSiwAjox304/VZeGqoGNAPgdupUI=;
 b=Db0cetCwtl6T/Zt6ikxsAcR7AKqaXeheUlC4K924jcWwr6HqnObIAoRlpmZXDJIkBh
 Ffhvh6KoIglnSY8KMgY8gN/BwTzkEbNU/7PK7J/utz1fc6Yh+6Xf6cYtj3XwC1Whlfa4
 RC3/FdupDPJyUy7n2f1hgxEu3kc0tAIt/9Kwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734576232; x=1735181032;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AbkG815MZnPqgZdcSiwAjox304/VZeGqoGNAPgdupUI=;
 b=d2OI2I4pad5RU0JAXesljwlbWr4W5OsI2HTu41P6334bbtsmEFDcU5hQhmyvJ61k26
 0QIZqAj6O87yAsYr4Fd5yu5tuhRg1+p6kd5yfbXmpRD4dJM71anluFWv5xRLukyftGYO
 c7FIFnEGjRuNRrorxqQa+PifkyUs7DrjuaNPG4sl2P4oYM+Sbg+R+XQqCtdsp5LMsfDG
 I11NsHo9AD9WjOI0gRfxKzdS1JHzluFt23qERmJITmVFt7D9KsgORDOBtyXdo/1m+5ZC
 TB60amuw9ACeqXiypcFKK4Kt4xIUWMC2ItQo6HnJ/C2XTCs2MgzYO55Xf8nTQNCL6LHl
 lk7Q==
X-Gm-Message-State: AOJu0YwH1ommEtHkL7yDJ0YS05f2heJVDLdGwyk7eFKfV+EdCHCT237j
 XZ4UxraPLgmLwVwOLMl7kFjBqfaCKqXRsmZ8DzXXFncNoUH6aH7u8F1fcc2+vRA79fZ7NteefHz
 4ALVb3mjUFFpy8Lc80D6r+XJWs6Dn9kpwe+Zs
X-Gm-Gg: ASbGnctepx6hyJSiBb/CjH5YGLc0SLpTM/gXQhHgMotehoSvbGXFocPXfd94Qpy41SW
 WDOInw9OW2SKfYwKgs+07gcr6v3iVElSPDU3bzjY=
X-Google-Smtp-Source: AGHT+IF7q4KTyFcrMxVBi82C4fU3HEGnFiwJ/zixEgHJxoSD0r51+Z0I4LDf9jUs9G9ykX2NvQ7UHcXKxLL6IVa0WkE=
X-Received: by 2002:a05:6402:50d2:b0:5d0:d818:559d with SMTP id
 4fb4d7f45d1cf-5d8025b3875mr3195813a12.11.1734576231845; Wed, 18 Dec 2024
 18:43:51 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 18 Dec 2024 18:43:50 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszTh2611n1qZRWsodHEeQ7_JwcK75=+qDpcO+fB7zOo-eYQ@mail.gmail.com>
References: <CAFLszTh2611n1qZRWsodHEeQ7_JwcK75=+qDpcO+fB7zOo-eYQ@mail.gmail.com>
 <20241211223822.2446254-1-sjg@chromium.org>
 <20241211223822.2446254-4-sjg@chromium.org>
 <CAC_iWj+5-uoXq9BanaOSxedVgbBYNFQ2AZVqka+J7iwMv=eC5w@mail.gmail.com>
Date: Wed, 18 Dec 2024 18:43:50 -0800
X-Google-Sender-Auth: bYGJYjvgzggoJXfvTdpSU3mCA7U
Message-ID: <CAFLszTiOSqx2H-T04Qqa89rH0FZvCzyCfxh+cYgxNh2Mg4+W3A@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] efi_loader: Update efi_run_image() to accept image
 and device path
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Moritz Fischer <moritzf@google.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

Hi Ilias,

On Thu, 12 Dec 2024 at 00:44, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Thu, 12 Dec 2024 at 00:38, Simon Glass <sjg@chromium.org> wrote:
> >
> > Provide these globals as parameters to this function, on the way to
> > making it possible to start an image without relying on the globals.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Adjust argument ordering for efi_run_image()
> >
> >  lib/efi_loader/efi_bootbin.c | 20 ++++++++++++--------
> >  1 file changed, 12 insertions(+), 8 deletions(-)
> >
Applied to sjg/master, thanks!
