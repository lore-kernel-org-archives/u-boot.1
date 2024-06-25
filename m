Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A8FC3064D
	for <u-boot@archiver.kernel.org>; Tue, 25 Jun 2024 12:38:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7306488511;
	Tue, 25 Jun 2024 14:38:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LITGZlg8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD0FC884FC; Tue, 25 Jun 2024 14:38:18 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45487884F1
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 14:38:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6b4fe2c79fdso22655476d6.0
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 05:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719319095; x=1719923895; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=svU8+6jcuTmrVw0Xuwz2lSlI5T6a/Wo5eXSiZfAXV0w=;
 b=LITGZlg8rYMkE18GCbnahkGBT6i8/oZbxcI6wgCpLXlS9yq2MzsL2l9b6hNaJ6kQ9k
 Mu3PbrX0IeVHGaOFyBVUgbg+kPsm1y8o3cNShuyPiZ2YUYTfcIgoGTalAjgSLB0OzASJ
 JzdEzhg3DMh6i95PicdyFBkwUv/wXOpE89tGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719319095; x=1719923895;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=svU8+6jcuTmrVw0Xuwz2lSlI5T6a/Wo5eXSiZfAXV0w=;
 b=cg8FqUxkhLjvoOxw7PeDNKP0BkgNdPUYXlIJDXuhkoZlEAO0LpFcvvqmVY4xssecQZ
 N7nTIClM6VcYXUMonjeteainAPNKdW4gYRGLSWWPtVrj/iYPQN6047wqeKcspENldNRt
 A0T+QmpDIJg2IW5ib9MIzgsZ/iQu6UCVcwMiiwVU0Vv6d2+DBiOYbnj+b4x7Y+XMgMDq
 YSMquMU5SlboUcAOBtaTSqGu7NCKs2MvPUhf35YOeIQQR55uTPCXhNFv4aiUGRFAZEJq
 lrqgAiPJZx66hXQISjVJVw39UQZPlbFxQSCPq68HRv9eBSbqr61A6S10Sr2Pmn4tS46j
 8VmA==
X-Gm-Message-State: AOJu0YwrSDxzCh71PmpGW1MjyKNhszAH5p+PZKCKvlqW+nw9I+UHA8su
 zdb4IxVhiZ4dWdEvAA82Pmhxw0QiE6xDVa7yILmHnV8eG67/BxyJ5h0xaTun7FZSfoLsyXV4bej
 SbO/yfnsx2EAwHDCK3GKsp/ESa/sR1oWff+IKxo/Fw1YPdTL9xw==
X-Google-Smtp-Source: AGHT+IGsU30IuM3zhGxuZNYEQ74h1e2MRrig47v8ZZuSPWFSn3X0yY0DCpsx62wpIc6P7u73iQmc1r32J6fdkptzXQ0=
X-Received: by 2002:a0c:ca0a:0:b0:6b2:cf90:8b7 with SMTP id
 6a1803df08f44-6b53bcd223emr74477116d6.23.1719319095174; Tue, 25 Jun 2024
 05:38:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240623203033.1566505-1-sjg@chromium.org>
 <20240623203033.1566505-14-sjg@chromium.org>
 <20240624182931.GI38804@bill-the-cat>
In-Reply-To: <20240624182931.GI38804@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 25 Jun 2024 13:38:04 +0100
Message-ID: <CAFLszTguTkc1m2JYb=5+yW_8uY+J0AsQZ_L0hFJHDfEXNeb0wQ@mail.gmail.com>
Subject: Re: [PATCH 13/14] Update u-boot.cfg to include CFG also
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Mon, 24 Jun 2024 at 19:29, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Jun 23, 2024 at 02:30:32PM -0600, Simon Glass wrote:
>
> > Some configuration is now in variables with a CFG_ prefix. Add these to
> > the .cfg file so that we can see everything in one place. Sort the
> > options so they are easier to find and compare.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Add new patch to update u-boot.cfg with CFG_... options
> >
> >  scripts/Makefile.autoconf | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/Makefile.autoconf b/scripts/Makefile.autoconf
> > index b42f9b525fe..65ff11ea508 100644
> > --- a/scripts/Makefile.autoconf
> > +++ b/scripts/Makefile.autoconf
> > @@ -71,7 +71,7 @@ quiet_cmd_autoconf = GEN     $@
> >  quiet_cmd_u_boot_cfg = CFG     $@
> >        cmd_u_boot_cfg = \
> >       $(CPP) $(c_flags) $2 -DDO_DEPS_ONLY -dM include/config.h > $@.tmp && { \
> > -             grep 'define CONFIG_' $@.tmp | \
> > +             egrep 'define (CONFIG_|CFG_)' $@.tmp | sort | \
> >                       sed '/define CONFIG_IS_ENABLED(/d;/define CONFIG_IF_ENABLED_INT(/d;/define CONFIG_VAL(/d;' > $@; \
> >               rm $@.tmp;                                              \
> >       } || {                                                          \
>
> I don't like this because whereas "CONFIG_" is enforced to be set only
> by Kconfig and so always all reliably set and found via a single header,
> CFG_ stuff is not.

OK, so how are CFG_ options found? I hit this when trying to find the
SDRAM size on rockchip 3399 and I could not find any way of figuring
it out.

Regards,
Simon
