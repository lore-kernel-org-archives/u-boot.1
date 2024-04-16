Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04BD2C4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 23:52:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66E9A8831C;
	Wed, 17 Apr 2024 01:52:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ex6TyNu1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 172C08840D; Wed, 17 Apr 2024 01:52:27 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 986B988224
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 01:52:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1e65a1370b7so28707465ad.3
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 16:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713311543; x=1713916343; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CZ9p783RxHjzlxiH0O7Nv6sHi8DjT7ZCWaOyMqnjazU=;
 b=Ex6TyNu17Rayn9A6kUdRERZiDARuQOs1SyVDjujbjosug8jNzfWktf1JgESvklJ6uq
 zSELblhys60mCG2FWAUcsrwCw8d47PdnNQOHCF0+80fJ+8CQKJd8tG1f1M9tMh+9A2cm
 6SxKtvX4YhZNyYopeEsP0d39i+iWOGypltY0vKxmAtbi0Apf5HdgXRfQw8rBCvDBDxGq
 4bROBvRycNyCC5BQ0hapJlYOtmy9NKx9spObULNes5imyhfL4gnuG8LCu4CiW8pBw9lT
 Lf4VsK8SSeKg2AlMOJHVa96KGvplXs3qLw9GC4kwn2/4tN76n3hFxLsssSs/n1SzA7FA
 lWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713311543; x=1713916343;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CZ9p783RxHjzlxiH0O7Nv6sHi8DjT7ZCWaOyMqnjazU=;
 b=dpqA3/52o9+1MGanXg+YiL7CmluYx67CJ74bUj/IltmS4UtlI+yr1wYxCy8m+RKN0j
 aVaAedMQSlssv3td5JnrjiGdlawKfy2vwgEDpUeyI2nir6KmrQez1UoAFwBhhKEXlzfG
 Aq6JPU2miXZEj5QnTxMIc5lOeJwY6Odw3s7nr8KVVQhYQOJO0oMjM73S/sdhUdrRMsTv
 GsxxpcQOL2rSgCXjxD6OQsJlrMY4fuzWpDBNq5PuyhSGm6NIUPuK9BNtlTXfelZgzcqL
 LSZnQU5njDYlCwx+I0kuMkN+I0X4Xb/tD/OCuP7j0Pdf/Vo5Lq4IaJ1PUOPjMdpft/wJ
 Vdow==
X-Gm-Message-State: AOJu0YwxEhQmWlHnUvCkLQ2qIRAsTrryj+MaRoYBY4t5XDCj3xWbLZTl
 TZfccjoIN0R8ZKD3+IeP5Q66CDRCY1MabxCOhvdauyuPhA4lt2lOMrJC0frkVBjxNpWFIqk+NSl
 2yD2p5wNO8Ae+s597cWMRk/StLd3DGBxMzJ4CUg==
X-Google-Smtp-Source: AGHT+IGpHPph7WFVg8o/zcslgm+NbhlAMLfGYX0qktU+r2NtI/GaStPnBI/s8p3rDMyHZG1b4HcLKpN1U0ZMFP0HVe8=
X-Received: by 2002:a17:902:d2c9:b0:1e2:8841:8d67 with SMTP id
 n9-20020a170902d2c900b001e288418d67mr20739385plc.32.1713311543096; Tue, 16
 Apr 2024 16:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240416190019.81016-1-raymond.mao@linaro.org>
 <20240416190019.81016-6-raymond.mao@linaro.org>
 <20240416191902.GU1054907@bill-the-cat>
In-Reply-To: <20240416191902.GU1054907@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Tue, 16 Apr 2024 19:52:12 -0400
Message-ID: <CAEfUkULVEQxGK9R7MH1P9cxtng2R8khSuUhEJC95qnCEotWD9Q@mail.gmail.com>
Subject: Re: [PATCH 05/23] test: py: add sudo for virt-make-fs
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, xypron.glpk@gmx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Tue, 16 Apr 2024 at 15:19, Tom Rini <trini@konsulko.com> wrote:

> On Tue, Apr 16, 2024 at 12:00:01PM -0700, Raymond Mao wrote:
>
> > Fix a permission issue when running virt-make-fs
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> >  test/py/tests/test_efi_secboot/conftest.py | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Can you elaborate please? The point of virt-make-fs was, I could have
> sworn, is that it doesn't require privileges.
>
> We can drop this patch from v2. The privileges issue is due to my Ubuntu
host setup (missing the permissions to access /boot/vmlinuz-*).

Thanks and regards,
Raymond
