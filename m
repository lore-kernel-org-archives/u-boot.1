Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58CD8D6B087
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 16:17:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2F728401A;
	Thu, 29 Jan 2026 17:17:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KMsXMz+S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0CC884021; Thu, 29 Jan 2026 17:17:25 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8605A8401A
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 17:17:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C864443556;
 Thu, 29 Jan 2026 16:17:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373EAC4CEF7;
 Thu, 29 Jan 2026 16:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769703441;
 bh=OTWn+bQv1KUjepcD/rVFADYItdq920ySG5vRnse8b60=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=KMsXMz+Sh/vXcBSzxRb6Pw1g/IVqfjVT5STWDI2606SN3zAGgbYFEf86L5MFY6PfL
 TMLTkhrn1lZtk7D0sMtRvucoo7vkAxEm06HZhev9puPYIUI+WHtRHXtEDXxWzu4ZFJ
 vu5C1lwDlzZ/X5JXeEr4Mi5GhS4vO+N0WEbhktbEWpKZHSoLU9/7IynQLP0GhALi51
 fvhYuGHTNnSVjBJeWylWk2lz6sZeyVHduoX774CX9mgf+s2Z1uHk898fDcUoUVKUU+
 SHb7zwYcrevVg44mN3BCTb6VzAynx8RIKS1FgGUrHc/q/zvYMM3+5sXEk7cQEmurrL
 KkCZUd8ZphpSw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Alexander Graf
 <agraf@csgraf.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome@forissier.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Yuya Hamamachi
 <yuya.hamamachi.sx@renesas.com>
Subject: Re: [PATCH 1/3] gunzip: Add ability to disable progress indicator
In-Reply-To: <20260127235914.1503663-1-marek.vasut+renesas@mailbox.org>
References: <20260127235914.1503663-1-marek.vasut+renesas@mailbox.org>
Date: Thu, 29 Jan 2026 17:17:19 +0100
Message-ID: <87wm10mm0g.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Marek,

Thank you for the patch.

On Wed, Jan 28, 2026 at 00:57, Marek Vasut <marek.vasut+renesas@mailbox.org=
> wrote:

> Introduce new environment variable, 'gzwrite_quiet', which disables
> the progress indicator during decompress-write. This is mainly meant
> to prevent disturbing unit test which responds badly to the in-place
> progress update and reduce UART traffic. By default, the indicator is
> left enabled.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Alexander Graf <agraf@csgraf.de>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Jerome Forissier <jerome@forissier.org>
> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
> Cc: u-boot@lists.denx.de
> ---
>  lib/gunzip.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/lib/gunzip.c b/lib/gunzip.c
> index 040450c0e79..d31bbb2ba03 100644
> --- a/lib/gunzip.c
> +++ b/lib/gunzip.c
> @@ -83,10 +83,15 @@ __rcode int gunzip(void *dst, int dstlen, unsigned ch=
ar *src, unsigned long *len
>  }
>
>  #ifdef CONFIG_CMD_UNZIP
> +static bool quiet;
> +
>  __weak
>  void gzwrite_progress_init(ulong expectedsize)
>  {
> -	putc('\n');
> +	quiet =3D env_get_yesno("gzwrite_quiet") =3D=3D 1;

I've tried to test the series with:

$ ./test/py/test.py --bd sandbox --build -k ut

(I know ut might not the right filter for this test, but I always test 'ut'
before testing other things)

But I see:

    +make O=3D/var/home/mkorpershoek/work/upstream/u-boot/build-sandbox -s =
sandbox_defconfig
    +make O=3D/var/home/mkorpershoek/work/upstream/u-boot/build-sandbox -s =
-j14
    ld: warning: enabling an executable stack because of -z execstack comma=
nd line option
    ld: warning: enabling an executable stack because of -z execstack comma=
nd line option
    ld: warning: enabling an executable stack because of -z execstack comma=
nd line option
    ld: warning: enabling an executable stack because of -z execstack comma=
nd line option
    ld: warning: enabling an executable stack because of -z execstack comma=
nd line option
    ld: warning: enabling an executable stack because of -z execstack comma=
nd line option
    ld: warning: enabling an executable stack because of -z execstack comma=
nd line option
    ld: warning: enabling an executable stack because of -z execstack comma=
nd line option
    ../lib/gunzip.c: In function =E2=80=98gzwrite_progress_init=E2=80=99:
    ../lib/gunzip.c:91:17: error: implicit declaration of function =E2=80=
=98env_get_yesno=E2=80=99 [-Wimplicit-function-declaration]
       91 |         quiet =3D env_get_yesno("gzwrite_quiet") =3D=3D 1;
          |                 ^~~~~~~~~~~~~
    make[2]: *** [../scripts/Makefile.build:271: lib/gunzip.o] Error 1
    make[2]: *** Waiting for unfinished jobs....
    make[1]: *** [/var/home/mkorpershoek/work/upstream/u-boot/Makefile:2191=
: lib] Error 2
    make[1]: *** Waiting for unfinished jobs....
    make: *** [Makefile:189: __sub-make] Error 2

Adding env.h inclusion as following fixes it:

diff --git a/lib/gunzip.c b/lib/gunzip.c
index ed05f1d64d7d..98acf4c5b2a7 100644
--- a/lib/gunzip.c
+++ b/lib/gunzip.c
@@ -8,6 +8,7 @@
 #include <command.h>
 #include <console.h>
 #include <div64.h>
+#include <env.h>
 #include <gzip.h>
 #include <image.h>
 #include <malloc.h>

Maybe this should be included conditionally depending on the command
being enabled or not?

> +
> +	if (!quiet)
> +		putc('\n');
>  }
>
>  __weak
> @@ -94,7 +99,7 @@ void gzwrite_progress(int iteration,
>  		     ulong bytes_written,
>  		     ulong total_bytes)
>  {
> -	if (0 =3D=3D (iteration & 3))
> +	if (!quiet && !(iteration & 3))
>  		printf("%lu/%lu\r", bytes_written, total_bytes);
>  }
>
> --
> 2.51.0
