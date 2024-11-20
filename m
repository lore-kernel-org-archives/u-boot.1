Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF6FD63939
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 13:40:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96293892B8;
	Wed, 20 Nov 2024 14:40:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NJytK79R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91CAF89270; Wed, 20 Nov 2024 14:40:03 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDDB088DD9
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 14:40:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2120f9ec28eso6101725ad.1
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 05:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732109999; x=1732714799; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Dlpt0TuQH3iI1fCWemg1PWbKkX63mfD7Q+1ORBqGrp4=;
 b=NJytK79R55NS8rtjy1b37DBdTfpLz77n+5Bt2wqBIfepmyFExQ3K/KgJ7nwC+v3YH5
 DkdtX1/MUMvXPrX1WPMP8Oz4Qu2gLFRFpi0aMmjGDJgYhJExa8Bg4SUauA2GtqLYbScs
 LLcawF4+EeMuwXCL5YYXqILfV0sCt7FIAQYkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732109999; x=1732714799;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Dlpt0TuQH3iI1fCWemg1PWbKkX63mfD7Q+1ORBqGrp4=;
 b=OFdlooxomO0Pm/Pz7J4/gaCpcYdlsdrgkrovpyJyfkr35hmg8F7Qke5OsZU4bPL1jL
 fdOVj/TPl3vZNxEwV8t2/P6yy9N+BA/jhC20UdulMs+fQiLYA749CRsWwJ6GCr9wV1pS
 BsJjxtNYxsWOiEZYcHWULGILQRfRwQOlfXgQVN43KmEzAQHqz4eN1/ulOPg/xtFz2238
 /msY7zG2NQMzMMu4t4/4X7mWQDEOPCsL9KR3TfpiUAZfywD8rL1G3VCzBGKpj0yNapzO
 Nm5A6tK9xEUN4TYeLuqvtFGvxqkWZMnkWOQxos/UpmqugAylLgMiYch39uuiyoUZKs45
 8wCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkcwgdJwuH7pVrV73NtDCOXcFuwt3ELYLe/Z1Vj4BrzQ2EPMfwFUOE8BxDc9czSTqhXm04EAI=@lists.denx.de
X-Gm-Message-State: AOJu0YwpSHdzgxf/l6/4QVvlA+aDmpbH8CMToz4kdEs/U63Wl//fRMKd
 CZopF42XQKnQR/rYUi2bxIx/nDxO+uQYjZeupNHuFmMNsbKVUYvPX+JeU6bY/cOB6QHhqt8pALE
 TEgufo1I7ozygW18otbZXdU1ovbmS+pnEKN8T
X-Google-Smtp-Source: AGHT+IGvpwQBDw679bY/1mJ6GvCDpr91b2IVqGNY1VXJn4awrUgN+uYaSwD9jrfvKFXTAzU9D9D7GZbvIKpLxxrCFDI=
X-Received: by 2002:a17:903:298f:b0:20c:72e8:4eb7 with SMTP id
 d9443c01a7336-2124d0f2b92mr110284665ad.25.1732109999482; Wed, 20 Nov 2024
 05:39:59 -0800 (PST)
MIME-Version: 1.0
References: <20241120103943.886802-1-paul.henrys_ext@softathome.com>
 <CAOTsJ7oYArwpXks9bwMcn3FdGjV0ogRHqAC-2_qF1vqx99j8Cg@mail.gmail.com>
In-Reply-To: <CAOTsJ7oYArwpXks9bwMcn3FdGjV0ogRHqAC-2_qF1vqx99j8Cg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Nov 2024 06:38:04 -0700
Message-ID: <CAFLszTjUM=12bKUorbABeB7O77BzqAEL0rR--m2+mwnYS60-bw@mail.gmail.com>
Subject: Re: [PATCH 1/1] arch: x86: lib: Add support of legacy 64-bit entry
 point at 0x200
To: "Paul HENRYS d'AUBIGNY" <paul.henrysd@gmail.com>
Cc: Paul HENRYS <paul.henrys_ext@softathome.com>, u-boot@lists.denx.de
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

Hi Paul,

On Wed, 20 Nov 2024 at 06:03, Paul HENRYS d'AUBIGNY
<paul.henrysd@gmail.com> wrote:
>
> Hi Simon, all,
>
> I am really sorry about this automatic footer added by SoftAtHome's mail server. I complained about it but the legal and IT departments did not agree to remove it.
> I will now send such a patch with my private email address and notify SoftAtHome of it.
> Sorry again for the inconvenience.

Thank you. It makes me wonder what the meaning of your signoff on the
patch, since it seems in conflict with the idea of sending a patch to
a mailing list. Are SoftAtHome's lawyers trying to assert that the
patches are not subject to GPL, or something else?

Anyway, thanks for adjusting it.

Regards,
Simon
