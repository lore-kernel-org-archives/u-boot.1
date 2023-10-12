Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4308CDB47E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 03:51:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7CC286F2A;
	Thu, 12 Oct 2023 05:46:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aqhy98iW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4DC286E0E; Thu, 12 Oct 2023 05:46:21 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E29A286ED3
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 05:46:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5a7d9d357faso7169567b3.0
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697082360; x=1697687160; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oqh7eOUTAOA04BSPdQA92u0SLc4J6o+4mm7Lbd6lWUs=;
 b=aqhy98iWk/Y8Ew+QvZ0IOPXRG8NsNOCyCfdG0iGa1lgZinYjitsYfrUdN8pOHDTSv1
 peTFSGWKo7stMh4dYI7W2d3ZlD0BmGq3hqDtzRJzCw6JX6lhmNr6ImwuJDG5rvoLn07J
 jXh3YmKA0jcYyUrmPwCFRMXdjZi9QIZoltM4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697082360; x=1697687160;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oqh7eOUTAOA04BSPdQA92u0SLc4J6o+4mm7Lbd6lWUs=;
 b=f2SitYij1VnCYJviAJn/xZKuJEEwC75MGrB0uLAzEmzh0+g+29eBkoRxZRKKbhUJw9
 eQKruJgdGw28Hy+rCt2o7/idMtVM8ZCQ2aPRHTRDTHGAUKfKtw4QJdmUeThQ/W7A7MOz
 QeYNOrz4pxDl/Noq1DpIAztLJRf+p09qdUHzlWFcg41JqrbIW+hKfbXIry/N80qhz+xE
 PA23H0MTTBq7rmI7wFFaGOGJBuSKdRgiye1OfMEkQdEYmARkCCVhikycl02RMH+BCFAp
 QhcOUGuHlTg3tDhhC/RRv0kQx/wFMsypi7EwsBf/7Hwtu07mcJNT6gsJyYYW6XWB2C3Q
 SW6g==
X-Gm-Message-State: AOJu0Yz8CHMIau/Exl6+5CLWdNxMH9T8UUC6lqLfMZs4NDAYDCM3YzcT
 3Zocuqr9pEngNU+WfjE3cKsNrIIK7q8q0cSC47lohTwth0rgDhM+BAU=
X-Google-Smtp-Source: AGHT+IEErVt1XfCO5nTAxk3Yp5LbfwYfUnHJoFV0wSoE5sKk4cTsZwAz11e2mUZWm4mWRAlKldTL1bg00kB0PmAv56Q=
X-Received: by 2002:a05:690c:4513:b0:5a7:e3f9:a1fb with SMTP id
 gt19-20020a05690c451300b005a7e3f9a1fbmr3660296ywb.42.1697082359618; Wed, 11
 Oct 2023 20:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <DM6PR22MB22626D184E4A7038A3648C97BBD3A@DM6PR22MB2262.namprd22.prod.outlook.com>
In-Reply-To: <DM6PR22MB22626D184E4A7038A3648C97BBD3A@DM6PR22MB2262.namprd22.prod.outlook.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Oct 2023 20:45:19 -0700
Message-ID: <CAPnjgZ28JE+8Tb4ft-B73fey_TOiWuJ1tyrxgOSwAMEud==iEQ@mail.gmail.com>
Subject: Re: coreboot 4.11 + U-boot master
To: Jay Talbott <JayTalbott@sysproconsulting.com>
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

Hi Jay,

On Wed, 11 Oct 2023 at 19:03, Jay Talbott
<JayTalbott@sysproconsulting.com> wrote:
>
> Hi Simon,
>
>
>
> So I gave it a whirl to do a build of coreboot (on the 4.11 branch) with =
the U-boot payload, specifying U-boot master to get the latest version of U=
-boot.
>
>
>
> Unfortunately, it failed to build the payload:
>
>
>
>     Cloning U-Boot from Git
>
> Cloning into 'u-boot'...
>
> warning: redirecting to https://source.denx.de/u-boot/u-boot.git/
>
> remote: Enumerating objects: 945927, done.
>
> remote: Counting objects: 100% (6622/6622), done.
>
> remote: Compressing objects: 100% (2418/2418), done.
>
> remote: Total 945927 (delta 4232), reused 6496 (delta 4159), pack-reused =
939305
>
> Receiving objects: 100% (945927/945927), 190.29 MiB | 6.01 MiB/s, done.
>
> Resolving deltas: 100% (793720/793720), done.
>
> Updating files: 100% (20136/20136), done.
>
>     Fetching new commits from the U-Boot git repo
>
>     Checking out U-Boot revision origin/master
>
> Already on 'master'
>
> Your branch is up to date with 'origin/master'.
>
> Branch 'coreboot' set up to track remote branch 'master' from 'origin'.
>
> Switched to a new branch 'coreboot'
>
>     MAKE       U-Boot origin/master
>
> In file included from tools/imagetool.h:24,
>
>                  from tools/aisimage.c:7:
>
> include/image.h:1396:12: fatal error: openssl/evp.h: No such file or dire=
ctory
>
> 1396 | #  include <openssl/evp.h>
>
>       |            ^~~~~~~~~~~~~~~
>
> compilation terminated.
>
> make[3]: *** [scripts/Makefile.host:112: tools/aisimage.o] Error 1
>
> make[2]: *** [Makefile:1858: tools] Error 2
>
> make[1]: *** [Makefile:75: build] Error 2
>
> make: *** [payloads/external/Makefile.inc:187: payloads/external/U-Boot/u=
-boot/u-boot-dtb.bin] Error 2
>
>
>
> Looks like it needs openssl to get pulled in as part of the build. Is the=
re something I=E2=80=99m missing that I need to do to get that to happen au=
tomatically? Or is there a manual step I need to do to get it pulled in?

For Debian this is:

sudo apt install libssl-dev

You can see all the pre-reqs at [1]


>
>
>
> Also, in coreboot=E2=80=99s make menuconfig, there=E2=80=99s a place for =
specifying a U-boot config file. For the first go at it I didn=E2=80=99t sp=
ecify one, but I=E2=80=99m guessing that maybe I need to at some point. If =
so, can you point me to what I=E2=80=99ll need to put in there?

Nothing in particular. At some point if you want to build a particular
U-Boot version from a separate checkout, you can manually replace
U-Boot in coreboot.rom:

# update u-boot
cbfstool $BUILD_DIR/coreboot.rom remove -n fallback/payload || true
cbfstool $BUILD_DIR/coreboot.rom add-flat-binary \
   -f u-boot.bin \
    -n fallback/payload -c LZMA -l 0x1110000 -e 0x1110000

If you want the 64-bit U-Boot then instead of u-boot.bin you need
u-boot-x86-with-spl.bin (and you must use 'make coreboot64_defconfig'
to configure U-Boot). In fact, that option is not available in
coreboot yet, so I should send a patch!


[1] https://u-boot.readthedocs.io/en/latest/build/gcc.html
