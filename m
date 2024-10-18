Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7003BD30011
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 14:53:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 674658919D;
	Fri, 18 Oct 2024 16:52:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GHBnpyyV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D31738919D; Fri, 18 Oct 2024 16:52:47 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4F8289066
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 16:52:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6cc03b649f2so14278496d6.3
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 07:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729263164; x=1729867964; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ucr7Dz/HYX6cHA4/i15XCQB7REKTILIPflgWvtxihCA=;
 b=GHBnpyyVElSsN7IAfHlhio7InFIIIkXlugFacEPeIeJ4rvlAZt6d9/iG10S2roqzOI
 1xvWgWdJXEF22mxBWGLHQnn+r28v72HUpMtDnoVs0E3nOcR5CTCniNMVf+jLZjpzI+mX
 BJCt+ubS/uGcVGQg2aOjuYXT1J+Y2MlP1PPZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729263164; x=1729867964;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ucr7Dz/HYX6cHA4/i15XCQB7REKTILIPflgWvtxihCA=;
 b=HAl/NTq8T4y4pbhzBkhYbs/1PbefL16PnBmGIPASK5c/zeN68WAOnfrwQjGzwCxXDq
 iGCozwtH3CJQPQL6OdLP5LOUcRU/3acLPUsYWEALPevVXEmnHeyuOGXT6xiqSh9E+ShC
 6xFAnVFcMwzVtqGTmiJplRNWlWXbPFzkeDjhU/j0Ff9B0BwtXnlgKx4/rW9389u6DS2S
 cLqNdIl/W96bloeSvq21Pvda9NHOMR9o1Gl8MDlvyNxhPAAgDA8lI2NdAyDRclhjADkY
 y0NxckGWfkgWGkRJJgYXunajY+Sw+oogAZ/x/VRcDJGGeO+qeQQy0VaRgfBG4o9/bq4j
 ekiQ==
X-Gm-Message-State: AOJu0YwJAsUfxBMByqYPz/pLkxcoCKpw6FVfnaLhcko2kOAkS3h89br6
 HBGesg62vnVjBC8hxJqK9lLy3MLO6sPRqJP+s24NDFxSNr97uHY7grTxSX6z2aLSLxyUpfnUfs3
 0a06nAmqDqRAl12eA+Mm+pDsgxNMkc4/K+t1i
X-Google-Smtp-Source: AGHT+IF42giASY3nKheP3i/gx+Q7EcZ2xcLwZtSMbvn4D0eLmWEOvFz6k1aD2QQBAiN3zTEQztJA6mRbT+4HA37C9cc=
X-Received: by 2002:a05:6214:318b:b0:6cc:654:a1cc with SMTP id
 6a1803df08f44-6cde15fe478mr29329386d6.47.1729263164603; Fri, 18 Oct 2024
 07:52:44 -0700 (PDT)
MIME-Version: 1.0
References: <20241018024657.134492-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241018024657.134492-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Oct 2024 08:52:33 -0600
Message-ID: <CAFLszTg8bT7ytmgpT98tP1RfYa4De2FFH4mOZCwd7TBZDFFP=w@mail.gmail.com>
Subject: Re: [PATCH 1/1] cmd: upl: correct printf code
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, 17 Oct 2024 at 20:47, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Building on 32-bit results in a build failure:
>
>     cmd/upl.c:75:51: warning: format =E2=80=98%lx=E2=80=99 expects argume=
nt of type
>     =E2=80=98long unsigned int=E2=80=99, but argument 3 has type =E2=80=
=98size_t=E2=80=99
>     {aka =E2=80=98unsigned int=E2=80=99} [-Wformat=3D]
>     75 | printf("UPL handoff written to %lx size %lx\n", addr, abuf_size(=
&buf));
>        |                                         ~~^           ~~~~~~~~~~=
~~~~~
>        |                                           |           |
>        |                                           |           size_t {ak=
a unsigned int}
>        |                                           long unsigned int
>        |                                         %x
>
> Fixes: 264f4b0b34c0 ("upl: Add a command")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  cmd/upl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Thanks
