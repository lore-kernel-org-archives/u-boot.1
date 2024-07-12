Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0C6C2BD09
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 07:59:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73A35885F5;
	Fri, 12 Jul 2024 09:59:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sigma-star.at header.i=@sigma-star.at header.b="RKRZaBuf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 537D988766; Fri, 12 Jul 2024 09:59:56 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AABF885EB
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 09:59:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard@sigma-star.at
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-36785e72a48so888635f8f.3
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 00:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1720771194; x=1721375994; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k3z89JOwFT6Ps5GkXAG2GBNXRTn5WAuGezIVjSA8iEI=;
 b=RKRZaBuf7tJHi7fKkmEEjEdaMWZUAEiA+waci4lp3HDSYnlQ7cqT9eNxU6AFKi+YIC
 TAbjAt1O3YiTDkfi0g4qVNo3FV9V6U3GS4OhvjXFfrQ/xTs+WWdcOay+lpT2szXXHCP9
 RWG5Fa8lzgygfwJSipNYpu78lUlRXUxVG98euNWJz8fScgV6OK4J4u5SeYD36uGTZuH2
 HH4b3rA2ZuO5CHhzuIUe4YYGwMB40qIPC8bY4+X2P/y7YZxs+SCA7frX8DD/hw2DxGKA
 bmTN17CRCVj5sHUMAb4zX4lEsqJO8oyIK98jfS9PzmcWplfuks/GLOESHHLsxBSuRvXx
 70LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720771194; x=1721375994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k3z89JOwFT6Ps5GkXAG2GBNXRTn5WAuGezIVjSA8iEI=;
 b=kPUUzpKIfZa2IV9N1In6uvciYUWtxp9r9wU/WH/seuaNJPR2A5jwlidyehD+eJ5s78
 Va/FAdDGNP7Wh6CJS2PbVMFdSJ8gQC3rEHAqxIokIlq2Qe5t0yFAum2IBUVgMdowOa+A
 AKQcuaCh7gAbneYpdH3AjOxFrBC6P8czfW+CY1Z7UPQSeWJBBJTSWjpiErPCPAedvB/S
 jsCzCa4nRio+s3WXIswFBt8yl2r7JO2RsvpLPsaUHcYPKc5nJ+xlYVXc5UWtxrVZLc4u
 RPvuuSZITfT6b2xPyP9CbKERLHBh/ny1bHT7cEl0i3iNs3MZj2q0XqKLq8DnvdG4MzsX
 Cqyg==
X-Gm-Message-State: AOJu0YyizdY60mqeZeaZn7NbBkQEVC418IFiKdsplBrzNpNnq8ZNM/Nd
 kXr6w/iITUalJEVuyAXm9la0D+mJj8RJNKkLsN7hcyPVzBL8BZ0JZeR33oulMK0W7XdwxABi/NE
 1
X-Google-Smtp-Source: AGHT+IHHaF4bR0DztWIXdz5ZhSOr7TK4pUL4IIEjNnwWswrkrvIi/kW5E+jmKV2+fPtIOrEjfr/J8Q==
X-Received: by 2002:a5d:598c:0:b0:361:93d5:782f with SMTP id
 ffacd0b85a97d-367cea46081mr8518812f8f.9.1720771193677; 
 Fri, 12 Jul 2024 00:59:53 -0700 (PDT)
Received: from blindfold.localnet (84-115-238-31.cable.dynamic.surfer.at.
 [84.115.238.31]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cdfa05eesm9489842f8f.84.2024.07.12.00.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 00:59:53 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Richard Weinberger <richard@nod.at>, Jixiong.Hu@mediatek.com,
 sjg@chromium.org, patrick.delaunay@foss.st.com, ilias.apalodimas@linaro.org,
 seanga2@gmail.com, xypron.glpk@gmx.de, upstream+uboot@sigma-star.at
Subject: Re: [PATCH 2/2] ext4: Fix zalloc()
Date: Fri, 12 Jul 2024 09:59:52 +0200
Message-ID: <2866901.Y6S9NjorxK@somecomputer>
In-Reply-To: <20240711154517.GA2391959@bill-the-cat>
References: <20240702194223.31998-1-richard@nod.at>
 <20240702194223.31998-2-richard@nod.at>
 <20240711154517.GA2391959@bill-the-cat>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

Tom,

Am Donnerstag, 11. Juli 2024, 17:45:17 CEST schrieb Tom Rini:
> The problem here is that "zalloc" is inline and so this change causes
> about 1KiB of growth on platforms which enable ext4 and so at least
> mx6sabresd now overflows it's maximum size. Looking harder, I think the
> best solution here would be for ext4 to stop using its own wrapper and
> instead call our kzalloc compatibility function.

As discussed on IRC yesterday, moving to kzalloc() is fine.
But the crash around malloc() still needs a fix.

Last night I investigated further why u-boot's malloc() implementation
crashes on my x86_64 test bed when ext4 tries to allocate a lot of memory.

It turned out that it's an integer overflow around malloc_extend_top()
and sbrk().
malloc_extend_top() uses a size_t to calculate the amount of required
memory and sbrk() takes an ptrdiff_t type.

On x86_64, u-boot seems to use unsigned long for size_t but just
an int for ptrdiff_t.
This is causing the trouble.

How about this?

diff --git a/arch/x86/include/asm/posix_types.h b/arch/x86/include/asm/posi=
x_types.h
index dbcea7f47f..e1ed9bcabc 100644
=2D-- a/arch/x86/include/asm/posix_types.h
+++ b/arch/x86/include/asm/posix_types.h
@@ -20,11 +20,12 @@ typedef unsigned short      __kernel_gid_t;
 #if defined(__x86_64__)
 typedef unsigned long  __kernel_size_t;
 typedef long           __kernel_ssize_t;
+typedef long           __kernel_ptrdiff_t;
 #else
 typedef unsigned int   __kernel_size_t;
 typedef int            __kernel_ssize_t;
=2D#endif
 typedef int            __kernel_ptrdiff_t;
+#endif
 typedef long           __kernel_time_t;
 typedef long           __kernel_suseconds_t;
 typedef long           __kernel_clock_t;

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y


