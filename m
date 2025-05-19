Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29939C54754
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 08:52:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61DEA81E72;
	Mon, 19 May 2025 10:52:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C8255F/l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EB628277D; Mon, 19 May 2025 10:52:13 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 097F8803DF
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 10:52:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ant.v.moryakov@gmail.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-703cd93820fso35836967b3.2
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 01:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747644730; x=1748249530; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6LuQ/TbR0iLpb6IreV/zoiezT+BK/4dahi7RMwaaUTE=;
 b=C8255F/lXWw07n7WEPESNK/5CB73bSaH+GY2YqkMLX4vHsOF8SmnnjX7Q2k7QY/AK3
 GT/RrMJEMiddkfXeziohiUEX6VI9dCWIAAdgd4mjZOmPqTLTPAc0cTm1vdtFrYoYEmmP
 ARG+F4brLBuewd+o8ltLL60Tx0c17604n75Iaw1CMi27CgF4EZ2v3BbmtczRjEfbS/C0
 8AcIBoh9dpU+pcpQrOB838hmWGaJ06XI/0H2JPqjIxckwFp7bl60vkgIbx2rwZdZJ8xR
 9RzW4zFteAvgx9GWXEfXxZex/hR/1RAiXXBqwlGYPmJEWVoh9cneK52UgF9HI1QFhohx
 nQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747644730; x=1748249530;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6LuQ/TbR0iLpb6IreV/zoiezT+BK/4dahi7RMwaaUTE=;
 b=B8cAgAOfQu0UHW01sItlNze3q26yZjlrXQZuPU3EPyrQcRwd2c9hb9GB1hNk7pYeji
 jReyNTErzce7ffBsBsloqGBuUTEvSqZAUTz5JV0jHrnW37xHlpOBsWMcVGKa5eGp3xMF
 UxJxvOnSS5ZHkFE16KI0NuCa8xtTiza5Pr39NyjOyVk2mVDum9nbo0exCeF4EqbGLK+Q
 DausF0Yb2bXtm4RKLJTOXcWLPYyk19ugwGdxUI7cVI7igszjDkUWiYRrh7ggezwlv/RG
 8OgLgTAEfYvvYObBS0YazPcnRWv1ycJeMtsx6UQErn75+99koD79v3LSP5hQjaMICjRF
 WZWQ==
X-Gm-Message-State: AOJu0Yy/nYMGaF3wunOnHwI6ACbR1ZhcJv9Wuxems/kDizcOuBKn+GVz
 7cHuE8kSglHfQfTvrWqkSQ0LpLjbFKx440XGwgaDfqISbfxYRLW1cpgkUPpCQbMUHm+842AB+33
 AX1v2Dij3QqGr/f7X4j0OplY7mQ41b70=
X-Gm-Gg: ASbGncs03mdhCw5t9TVLI0F+c7W7wTdzKqxyF8Ju7uL9ukhLWYxDA6A2+UUcg58W/wv
 OEEyXekIo7EcFjFo4Gy1HBnARMi7NY3UNzG9sLdmz/5sUkhmd5OisEmXViz0u8yMkn+PkzZCXL4
 yPkgLU+I5MoOEQUwSkxBG7jy84ZA+JgWh8
X-Google-Smtp-Source: AGHT+IG5JFxhmKvOSNsdMBTBKd3kkM9e8XrwWHAMUYPqwZMrNeOFnTeuIsmdVo2nZvY+/TLWztcWcNgEvl3fqWU32uM=
X-Received: by 2002:a05:690c:4a02:b0:708:15dd:712 with SMTP id
 00721157ae682-70cab0e83demr151240447b3.32.1747644729750; Mon, 19 May 2025
 01:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250516152538.75325-1-ant.v.moryakov@gmail.com>
 <2934aab5-6b55-4e21-a84a-87b52921a15b@cherry.de>
In-Reply-To: <2934aab5-6b55-4e21-a84a-87b52921a15b@cherry.de>
From: Anton Moryakov <ant.v.moryakov@gmail.com>
Date: Mon, 19 May 2025 11:51:59 +0300
X-Gm-Features: AX0GCFte65W6HjgaxYPg2t62M4H2toYtnRaQEcLE6Oyxzu7-wLeOmg_jwuKi7G4
Message-ID: <CAHb2+K6uRswzSCMYeTLbfZh+gsrUqtFQzFSzy-uA+mGgrLUQcg@mail.gmail.com>
Subject: Re: [PATCH] tools: fix handle leak in ifdtool.c
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Maybe. However, the static analyser did not swear at others


=D0=9F=D0=BD, 19 =D0=BC=D0=B0=D1=8F 2025=E2=80=AF=D0=B3. =D0=B2 11:47, Quen=
tin Schulz <quentin.schulz@cherry.de>:

> Hi Anton,
>
> On 5/16/25 5:25 PM, ant.v.moryakov@gmail.com wrote:
> > From: Anton Moryakov <ant.v.moryakov@gmail.com>
> >
> > Prevent file descriptor leaks by properly closing 'fd' and 'new_fd'
> > when fstat() or write() operations fail.
> >
> > - Added close(fd) before return in open_for_read() if fstat() fails.
> > - Added close(new_fd) before return in write_image() if write() fails.
> > - No close needed if open() fails (fd =3D=3D -1 is invalid).
> >
> > Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
>
> Looks fine to me
>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> I believe there are a few others in that file?
>
> inject_region returns without closing, same for write_data, same for the
> main function with bios_fd at the very least.
>
> Thanks!
> Quentin
>
