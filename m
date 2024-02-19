Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32634C48BC3
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 21:21:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E41787BF1;
	Mon, 19 Feb 2024 22:21:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="HFw9vUc/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D159887F5D; Mon, 19 Feb 2024 22:21:18 +0100 (CET)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF05687061
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 22:21:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2d241ff062cso13136871fa.3
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 13:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1708377664; x=1708982464; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R67Bxc7LKzZC/2sq6Ndw65qfSIBjkeY/mqDZQ7YdNPw=;
 b=HFw9vUc/QKv7q4J4YzSQ5IDpYyhN8LOsBhMtxtZpl0FEgqivXBZh+PUXRnUr6ZuvjI
 xyZKu5QlqE2XVmwo45qI+b9S5gSXjctCS8/WZm7PILIfujJI6wnxVqhglSR9/btt8YyK
 SNyE2qifrEdBrWOmivfLFC/RgOr5QG6A6pPrILm0ccfvjddr9cWZvfFfZfs8+oa3NlI1
 rYAak177uj+JEwRgkhnH9ticMdu/Vjkf/Uu7vKJ2rSfEVkG5XSZJ9huIAApiAFZVrx/i
 FOaT1p52vSTw/y2+iyV6NpX5l4QecQnX27s0g4MkmxF2m2XR0RoNQaZ4y86Rue+6NvJG
 mUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708377664; x=1708982464;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R67Bxc7LKzZC/2sq6Ndw65qfSIBjkeY/mqDZQ7YdNPw=;
 b=dblblOkDWiPf7OLdkaBV6+ORWzBMe0slBsVXILk6LLkQcbFccowIrtic5S3R6GcyNc
 x/FU8HQyGeeWuUbPD3tOWSgCGYnRMpMcICeynkmLLKBTjJr8fQAtsDU8awG/tq7lg3yw
 HOl/N6pgL0cCOGdIObmYfH0lbeCHr5EgIcXcUsgVn7ViXBk5fpdN1GWGGoTxDS54vDGr
 15zoT9ZdzqJvul9A1rRhfay3htmwaIYigTvAMvliUT+l+hyW6f36gw5k1+e/ZgA3khJT
 XWX/XiAv4psGRq/ZrC/YZQhyefWDyKjYRXMwg0CP19UcGbRHw+Z0qd74DoydApc03A1Y
 XYvQ==
X-Gm-Message-State: AOJu0YzNXNtarCZPHhUgiPShQ1DlkfrN48gFbSqAkDYdklWtkWoKGi3K
 2Ym5aFjmgHUKycpMj6WQTblbwUEnWYjexfi+YoZnkLOL2gMGABoeNyMqBALS1+2AuGb0oHISk7g
 s6rNVB8UyDGfIDhYNxBalJGw/3SHxFUGrUqLzrL2hbLPojRcKr3hH+Q==
X-Google-Smtp-Source: AGHT+IE2N6XYSr8OZ7OyluJ2xARtJEgYMOIOBQ5EgbmeYXpUoaDmn7w82GSz1FJhIL55nejb2KRgGxWhbOg/kwt/gYw=
X-Received: by 2002:a05:6512:3a93:b0:512:c35b:1a99 with SMTP id
 q19-20020a0565123a9300b00512c35b1a99mr44532lfu.55.1708377663843; Mon, 19 Feb
 2024 13:21:03 -0800 (PST)
MIME-Version: 1.0
References: <CAKZ1LvPwQyWadPtmv4LRmANm-6CHQpNZQqgRyzdxM3fvBTT=1A@mail.gmail.com>
In-Reply-To: <CAKZ1LvPwQyWadPtmv4LRmANm-6CHQpNZQqgRyzdxM3fvBTT=1A@mail.gmail.com>
From: Igor Opaniuk <igor.opaniuk@foundries.io>
Date: Mon, 19 Feb 2024 22:20:52 +0100
Message-ID: <CAL6CDMFAWq4FioquMThu+mDkEfj+umRfBSXYpnL1ehqSckC2Lg@mail.gmail.com>
Subject: Re: LTO build failure with GCC 13.2.1
To: Sahaj Sarup <sahaj.sarup@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hello Sahaj,

On Fri, Feb 16, 2024 at 5:50=E2=80=AFAM Sahaj Sarup <sahaj.sarup@linaro.org=
> wrote:
>
> Hi all,
>
> Since commit f8cebb4f789c9950caf55a0b73e88049e7a1c3a3 enabled LTO by
> default for imx8m platforms,
> I have been having issues building u-boot.
> I am primarily working on imx8mp instead of imx8mm platforms so the
> bug resolved by that commit doesn't affect me yet.
> But I guess it's a generic issue with u-boot's LTO requirements and GCC 1=
3.
>
> Build log:
> ```
>   LTO     u-boot
> /usr/bin/aarch64-linux-gnu-ld:
> /usr/lib/gcc/aarch64-linux-gnu/13/libgcc.a(lse-init.o): in function
> `init_have_lse_atomics':
> /builddir/build/BUILD/gcc-13.2.1-20230728/aarch64-linux-gnu/aarch64-linux=
-gnu/libgcc/../../../gcc-13.2.1-20230728/libgcc/config/aarch64/lse-init.c:4=
6:
> undefined reference to `__getauxval'
> collect2: fatal error: ld terminated with signal 11 [Segmentation
> fault], core dumped
> compilation terminated.
> make: *** [Makefile:1766: u-boot] Error 1
> make: *** Deleting file 'u-boot'
> ```
>
> GCC Version:
> ```
> $ aarch64-linux-gnu-gcc -v
> Using built-in specs.
> COLLECT_GCC=3D/usr/bin/aarch64-linux-gnu-gcc
> COLLECT_LTO_WRAPPER=3D/usr/libexec/gcc/aarch64-linux-gnu/13/lto-wrapper
> Target: aarch64-linux-gnu
> Configured with: ../gcc-13.2.1-20230728/configure --bindir=3D/usr/bin
> --build=3Dx86_64-redhat-linux-gnu --datadir=3D/usr/share --disable-
> decimal-float --disable-dependency-tracking --disable-gold
> --disable-libgcj --disable-libgomp --disable-libmpx
> --disable-libquadmat
> h --disable-libssp --disable-libunwind-exceptions --disable-shared
> --disable-silent-rules --disable-sjlj-exceptions --disable-threa
> ds --with-ld=3D/usr/bin/aarch64-linux-gnu-ld --enable-__cxa_atexit
> --enable-checking=3Drelease --enable-gnu-unique-object --enable-init
> fini-array --enable-languages=3Dc,c++ --enable-linker-build-id
> --enable-lto --enable-nls --enable-obsolete --enable-plugin --enable-t
> argets=3Dall --exec-prefix=3D/usr --host=3Dx86_64-redhat-linux-gnu
> --includedir=3D/usr/include --infodir=3D/usr/share/info --libexecdir=3D/u=
sr/
> libexec --localstatedir=3D/var --mandir=3D/usr/share/man --prefix=3D/usr
> --program-prefix=3Daarch64-linux-gnu- --sbindir=3D/usr/sbin --shared
> statedir=3D/var/lib --sysconfdir=3D/etc --target=3Daarch64-linux-gnu
> --with-bugurl=3Dhttp://bugzilla.redhat.com/bugzilla/ --with-gcc-major-
> version-only --with-isl --with-newlib
> --with-plugin-ld=3D/usr/bin/aarch64-linux-gnu-ld
> --with-sysroot=3D/usr/aarch64-linux-gnu/sys-root
> --with-system-libunwind --with-system-zlib --without-headers
> --enable-gnu-indirect-function --with-linker-hash-style=3Dgnu
> Thread model: single
> Supported LTO compression algorithms: zlib zstd
> gcc version 13.2.1 20230728 (Red Hat Cross 13.2.1-1) (GCC)
> ```
>
> Thanks,
> Sahaj Sarup

This might be related [1] (try tocompile with -mno-outline-atomics):

"GCC 10.1.0 introduced the -moutline-atomics option which, when
enabled, use LSE instructions when the processor provides them.
The option is enabled by default and unfortunately causes the
following error at compile time:

 aarch64-linux-gnu-ld:
/usr/lib/gcc/aarch64-linux-gnu/10.1.0/libgcc.a(lse-init.o): in
function `init_have_lse_atomics':
 lse-init.c:(.text.startup+0xc): undefined reference to `__getauxval'

This is happening because we are linking against our own libcflat which
doesn't implement the function __getauxval().

Disable the use of the out-of-line functions by compiling with
-mno-outline-atomics."


[1] https://patchwork.kernel.org/project/kvm/patch/20200728121751.15083-1-d=
rjones@redhat.com/

--=20
Best regards - Freundliche Gr=C3=BCsse - Meilleures salutations

Igor Opaniuk
Senior Software Engineer, Embedded & Security
E: igor.opaniuk@foundries.io
W: www.foundries.io
