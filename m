Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA809C47DA2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 14:06:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAE9E879C4;
	Wed, 17 Jan 2024 15:06:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QhNjNjQX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68B74879E1; Wed, 17 Jan 2024 15:06:08 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48DCE870B4
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 15:06:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-28b93b04446so1999240a91.0
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 06:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705500364; x=1706105164; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wtmurr5OzC3IwTP2sg+WZKeJ0tj5NoczwsLgehL/nLI=;
 b=QhNjNjQX6nfm9CXts9NQroHVlYYJysiR0DQaZ37hoc41Dz7FYFXgCcPhJBey7AHOgh
 f4lkFYL3ojZlP+YrMrEAz1YhyLNji56dPeWeVcwgi8U0RnkeSFIAfcOEbO4zSDoFn71T
 jg8DpjaivbdwSYPdQNFkzQatFQGKFcyh74qAMUXYO5BSIFHqKv1JMJ5hjHFlEFEEwWDP
 8MKzBQ3Ras70gSDXoULLGZ1M9q+8LpLEjQEFlRV5Q+zvgOPU8QR/k+4s/iVqjOKNO1N8
 83xm3tFW/lPPkcGriAYVF31QD3gDE2zAPaZxXvSHi2eQWJDpgVLK0jhdb5ZiJFhhFCV9
 E4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705500364; x=1706105164;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wtmurr5OzC3IwTP2sg+WZKeJ0tj5NoczwsLgehL/nLI=;
 b=fIKddx/NeyVZotXcB1I2RuBKM9WQ0uHYCS1mBP3UcOp15zuZFBLHqF5Pr+EvU7H/FH
 tiEfmDICZG5EHAJyXbBZ2zWWz15UXDS5OLKzFaB+dJXE1rGVwGzrDj2xflwYtljVrDVA
 VJdVJ7yCUhp6OmgSrT/xNXHIXeKvgyQ9ANftp6LqPRCmuDTuNvKxtMiHjZkMPWZoTn/9
 UvXkD6PlPWHw8GzWtzOysyV38n75WChkZrnQ5Y54qaCyaXeGGcr02eM3YgQg3ND7eRio
 214/DhIVUvDYPK5blL+oNHBWEkqmo3roTlgGTFN+sHufjvGyIMmfJd+kWafFDq8N098x
 CG+Q==
X-Gm-Message-State: AOJu0YwjHk2cc9GMhC1BGVEeA3AKfwasr0Lb/7C6iFmlYYXJLtmk89bZ
 TgC65MglbOEaECYhuqEzeU06edcJNnCrGGudMa8=
X-Google-Smtp-Source: AGHT+IHXZchmemIap9sN9zSjlCO/vJlM+6fqamBqtPtPm8PaLzJD8WgZ8HVweGUD5bu/qUGI4/gzfwWDfe6p2Ifvk44=
X-Received: by 2002:a17:90b:1bd0:b0:28d:e180:5429 with SMTP id
 oa16-20020a17090b1bd000b0028de1805429mr15228088pjb.2.1705500364467; Wed, 17
 Jan 2024 06:06:04 -0800 (PST)
MIME-Version: 1.0
References: <2dba1330181940c78b5ad47f18ee43fa@supermicro.com>
In-Reply-To: <2dba1330181940c78b5ad47f18ee43fa@supermicro.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 17 Jan 2024 11:05:52 -0300
Message-ID: <CAOMZO5DTw2uU+uEmVLR9nbFkR4QPgmhuY9VUAz-sgg+GppMG9g@mail.gmail.com>
Subject: Re: Could you please help me in resolving the
 "arch/arm/lib/vectors.S:87: Error: no such instruction: `b reset' ?"
To: Liu Wang <liuw@supermicro.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

On Wed, Jan 17, 2024 at 9:27=E2=80=AFAM Liu Wang <liuw@supermicro.com> wrot=
e:
>
> Sir/Madam,
>
> Could you please help me in resolving the "arch/arm/lib/vectors.S:87: Err=
or: no such instruction: `b reset' ?"
>
> Sincerely,
> Liu Wang
> liuw@liuw-SYS-E100-12T-H:~/Downloads/u-boot$ make cse_ptjob_cb3_r102_defc=
onfig

This is not a configuration supported by U-Boot mainline.

> #
> # configuration written to .config
> #
> liuw@liuw-SYS-E100-12T-H:~/Downloads/u-boot$ make all
> scripts/kconfig/conf  --syncconfig Kconfig
>   CFG     u-boot.cfg
>   GEN     include/autoconf.mk
>   GEN     include/autoconf.mk.dep
>   UPD     include/generated/timestamp_autogenerated.h
>   HOSTCC  tools/mkenvimage.o
>   HOSTLD  tools/mkenvimage
>   HOSTCC  tools/dumpimage.o
>   HOSTLD  tools/dumpimage
>   HOSTCC  tools/mkimage.o
>   HOSTLD  tools/mkimage
>   LD      arch/arm/cpu/built-in.o
>   LD      arch/arm/cpu//built-in.o
>   AS      arch/arm/lib/vectors.o
> arch/arm/lib/vectors.S: Assembler messages:
> arch/arm/lib/vectors.S:87: Error: no such instruction: `b reset'

Have you exported the toolchain?
