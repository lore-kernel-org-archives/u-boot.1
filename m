Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6625FD3762
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 15:21:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56B0584082;
	Wed, 25 Feb 2026 16:17:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D067A84064; Wed, 25 Feb 2026 16:17:16 +0100 (CET)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6250484114
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 16:14:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=tempfail smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1vvGb9-000000004xa-34ys; Wed, 25 Feb 2026 15:14:47 +0000
Date: Wed, 25 Feb 2026 15:14:40 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] tools/atmelimage: add const qualifier to fix compiler
 warning
Message-ID: <aZ8R4NfCnbDvdGX2@makrotopia.org>
References: <b040fc218c68db39b51c9f8d7b180ddfc332d4e6.1772031799.git.daniel@makrotopia.org>
 <20260225150742.GH1593142@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260225150742.GH1593142@bill-the-cat>
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

On Wed, Feb 25, 2026 at 09:07:42AM -0600, Tom Rini wrote:
> On Wed, Feb 25, 2026 at 03:03:57PM +0000, Daniel Golle wrote:
> 
> > tools/atmelimage.c: In function ‘atmel_find_pmecc_parameter_in_token’:
> > tools/atmelimage.c:64:31: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
> > 64 |                         param = strstr(token, "=");
> >    |                               ^
> > cc1: all warnings being treated as errors
> > 
> > Add 'const' qualifier to variable 'param' to prevent build failing
> > due to -Werror.
> > 
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> >  tools/atmelimage.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/atmelimage.c b/tools/atmelimage.c
> > index 6a2d9d8feab..770f7a0de4e 100644
> > --- a/tools/atmelimage.c
> > +++ b/tools/atmelimage.c
> > @@ -55,7 +55,7 @@ static const char * const configs[] = {
> >  static int atmel_find_pmecc_parameter_in_token(const char *token)
> >  {
> >  	size_t pos;
> > -	char *param;
> > +	const char *param;
> >  
> >  	debug("token: '%s'\n", token);
> >  
> 
> How / where are you triggering this problem? This is part of mkimage and
> built on CI every time (and on macOS and Windows, in Azure). Thanks!

I'm using archlinux on my workstation which got a fairly
recent version of GCC which is used to build the host tools:
gcc (GCC) 15.2.1 20260209

When trying to use the u-boot-size-test.sh scripts you had asked me for
it failed because of passing the '-E' parameter to buildman.

Also 'dtc' fails building for the same reason and that can be fixed by
picking commit dfe057874b34c ("scripts/dtc: Update to upstream versionv
1.7.2-62-ga26ef6400bd8") from Linux.
However, that has far-reaching consequences such as the
-Wno-graph_child_address parameter no longer existing, and also dtc
became more strict and issues new warnings for many of the dts files in
U-Boot, so then the build failed because of that...

As I wrote in the other email thread, I ended up just removing the '-E'
paramter because the rabbit hole became too deep...
diff --git a/contrib/trini/u-boot-size-test.sh b/contrib/trini/u-boot-size-test.sh
index da722f5..4cef66e 100755
--- a/contrib/trini/u-boot-size-test.sh
+++ b/contrib/trini/u-boot-size-test.sh
@@ -1,7 +1,7 @@
 #!/bin/bash
 
 # Initial and constant buildman args
-ARGS="-devl -PEWM"
+ARGS="-devl -PWM"
 ALL=0
 KEEP=0
 
