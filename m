Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A22F9E8FDC3
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 02:13:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F266D87494;
	Wed,  4 Oct 2023 04:12:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Euzcoxg/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34E818723B; Wed,  4 Oct 2023 04:12:41 +0200 (CEST)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6630F87479
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 04:12:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-d865c441a54so1745898276.1
 for <u-boot@lists.denx.de>; Tue, 03 Oct 2023 19:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696385556; x=1696990356; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ntwW2zDM1+rmsicy1+qgQDqCXsDPOdiiVLb65JJ01tk=;
 b=Euzcoxg/wEBLRCeAtzPPBRFKXkrun0tsdCrbv8IrvBfDqoZXsk/GaZbt7sKAYIia5H
 u9VDXmsQy8XobfexTbQC0+ZFU89Jzj2n+mEYbhwOI/2BKy4vJpGHBxW2PYcucMakP9K1
 R5BSPneNMYFdQ9mTlBNIKEdnpmgqth9kf3SCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696385556; x=1696990356;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ntwW2zDM1+rmsicy1+qgQDqCXsDPOdiiVLb65JJ01tk=;
 b=mpdajMOPFqESGH4QMT7zLFVdP5LCfRWQvg/jHem1r/OnA71aQ/e1HR9XrL0WHLVBZ3
 AvTSAiTnukIFI1Kp1kudA0MA6qD4FKHRKg0NocV8hgnx6NqP6c2mbrGd5i35lCuCNFVQ
 CvuvFQxLQu2iATh6pqdgpLRNx0nqO/RcKdQ4IN9Ceh48W0bXsJ9QmiV4ftDdYHNMgUea
 iPMkumP5virKjL+3QP9inr49WIb2gkQgJ8sakGuhd7HtMBtBldQtTq9nAsFyKwAH5UXc
 OsjVr/FCvRslzGX6Ej74b9RLBoiJYDNnjAV3YVQbP0MdI8ZQ/ZmVDPyzjzPoP/bE3XSU
 fvyA==
X-Gm-Message-State: AOJu0YyaH6cxuBEqIL7wd8ZRvpGt0xi3MI+ngW7xhcfebaki0hrL19P8
 3IOrucEwYn8UdSfjtYVxmA+0oHLAKtqoAWKIemqVuw==
X-Google-Smtp-Source: AGHT+IHVto8tNgU/Cz+sDpMzk41ZuoeR4LE/J8VNV1R5F9hakbH8hxZoXCmx2LHIJYm4CtGfhx6/MuzgGqXWwQN/mxk=
X-Received: by 2002:a25:6854:0:b0:d81:a0c5:f275 with SMTP id
 d81-20020a256854000000b00d81a0c5f275mr827350ybc.15.1696385555924; Tue, 03 Oct
 2023 19:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230803152215.3794531-1-lukas.funke-oss@weidmueller.com>
 <20230803152215.3794531-2-lukas.funke-oss@weidmueller.com>
 <CAPnjgZ0Xxqb4=AA3jYWOp9aW7jUjC4xPbhA9Zma1Opy39HRrXw@mail.gmail.com>
 <CAPnjgZ0t5AhnaTZDYgN6FCFoae=7RNK3LU15PHSuLJguWpx9EQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ0t5AhnaTZDYgN6FCFoae=7RNK3LU15PHSuLJguWpx9EQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Oct 2023 20:10:56 -0600
Message-ID: <CAPnjgZ2Dk5QMT7-51mxejX_s-HD_m8exXVHFL2d8UKoQkn=3nA@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] binman: btool: Add Xilinx Bootgen btool
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Michal Simek <michal.simek@amd.com>, 
 Lukas Funke <lukas.funke@weidmueller.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 lukas.funke-oss@weidmueller.com
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

Hi,

On Sat, 5 Aug 2023 at 13:51, Simon Glass <sjg@chromium.org> wrote:
>
> On Thu, 3 Aug 2023 at 09:22, <lukas.funke-oss@weidmueller.com> wrote:
> >
> > From: Lukas Funke <lukas.funke@weidmueller.com>
> >
> > Add the Xilinx Bootgen as bintool. Xilinx Bootgen is used to create
> > bootable SPL (FSBL in Xilinx terms) images for Zynq/ZynqMP devices. The
> > btool creates a signed version of the SPL. Additionally to signing the
> > key source for the decryption engine can be passend to the boot image.
> >
> > Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
> >
> > ---
> >
> > Changes in v4:
> > - Fixed some typos
> >
> > Changes in v3:
> > - Fixed an issue where the build result was not found
> > - Fixed an issue where the version string was not reported correctly
> >
> > Changes in v2:
> > - Pass additional 'keysrc_enc' parameter to Bootgen
> > - Added more information and terms to documentation
> >
> >  tools/binman/bintools.rst     |   2 +-
> >  tools/binman/btool/bootgen.py | 137 ++++++++++++++++++++++++++++++++++
> >  2 files changed, 138 insertions(+), 1 deletion(-)
> >  create mode 100644 tools/binman/btool/bootgen.py
> >
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> Applied to u-boot-dm, thanks!

On -next I see this:

binman tool -f bootgen
Fetch: bootgen
- trying method: binary download
- trying method: build from source
- clone git repo 'https://github.com/Xilinx/bootgen' to '/tmp/binmanf.0bzta5ph'
- build target 'a'
Exception: Error 2 running 'make -C /tmp/binmanf.0bzta5ph -j 64 a':
make: *** No rule to make target 'a'.  Stop.

- failed to fetch with all methods

2. There seems to be some test coverage missing:

tools/binman/etype/xilinx_bootgen.py                       72      1    99%

The offending line is 216:

   data = tools.read_file(bootbin_fname)

Please could you take a look?

Regards,
Simon
