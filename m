Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A40CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 20:17:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98850838F0;
	Wed,  8 Oct 2025 22:17:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h4GsOikp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49013838F3; Wed,  8 Oct 2025 22:17:08 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6ACFA838EE
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 22:17:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7a8e7ece907so202753a34.0
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 13:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759954624; x=1760559424; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OUpAVCuI+/f3UUG9udI1E0H8sF0KO+PFOCs0hgAZ0tc=;
 b=h4GsOikpwzixs+mv7h5Y4v0OMj1vC5beltAO9h7kKpm+K5Dv2Be8pfZoG97GlGe0Nd
 PJTiWDJFudmeJB9iqq+7lWIuYbH7wLDe/RNLmrqFQSeEDLRmF+3iLvNdUccw/q4bAWZP
 dKDyKp73fidXwKnk+BlG3S/hAEBK2XB3ewRiX8KEptqQDGijZ5TFxTiFN2j9uC1WtNLP
 Xmfrzj59hHkCYCyBUj18xmbWXkmAHMXKMWek/jksuV8OToVOdH0gK2X63H3EmOYhf7nx
 +E9/GK/NBT0hnsh+6qFG42O3iPGP2/NOmniHlp+uiqypH1TVFk0X/ffbVMeoL1gXm+T4
 CUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759954624; x=1760559424;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OUpAVCuI+/f3UUG9udI1E0H8sF0KO+PFOCs0hgAZ0tc=;
 b=OfB92fbZz5gWCu1waBKg/UI1kBYTGckm+rrsk2CIq3BVuj0/+gMmuBViK63IdZgIa2
 rw/hIF9/Fpi0XTOq5k7w0+SpFDr1MXC5TP7P9egR4WA1rf63vur5HEhi6JaipIawXBoJ
 ESyATruTWCq9ws0LBLvUIluT0uRc+UZqMgvin/y2AMm8EKiolOusTIC7owlwAod2runA
 dfdUv5bxeRvdtdsJgaNjKtoLwiIZX/zENgeq7/zo1cp2Mpxo0/dW9jdUdivoNEOc9A5R
 c9hHblfdxnqHn2KK/Ol4tLa7dG4PgLjBt6R90+HFt26L/fu7r7yem2AVd6Cl71/vyIeZ
 mYoA==
X-Gm-Message-State: AOJu0YwHWO2O/ChCbnAUe3Kp8RWAG9GauiC4wNCVyXmT2N1+tJ3gbqua
 O138gXq57azE+5xiFUuO9u4NyPSH4mtqoqyg7aBtWTEfgeHmN7B52ZH2fqD8sLKzOurJo1O6Qj3
 McYsaRZc5h24NWAOtxBSljzAicmwuXHacl4LKMJzNM+di
X-Gm-Gg: ASbGncu3I7jLZL6FbdlG+Fb9s09xksptY3I4BZtDNO1zycNe7LsSZ7Vk0Nkqtm7a1AH
 gLdxj9WIy+dFKr3HeOM+fHlbRvVvxFw115fxehhWm9J5MDqdCvCnynFRkVSvDfR6qnghllIThGk
 al912RyYsOtbK7jd+Igo1yL1GhEt0d+PF7SPLV12lyG3CVHP5iOAQ7ib50iFtGROu5Nt598Pl57
 EYCq69rAhqswqUe6nOZ1QkzyBn3uF4=
X-Google-Smtp-Source: AGHT+IEDZOkumkQu86Dek62VI0j3pz2ynSzZ35fslO+26DrZUz3BcCMJkkoHdN8TaeLiID8KjoA3kGfRbbTPW97g+rE=
X-Received: by 2002:a05:6830:368b:b0:78a:1d62:ff20 with SMTP id
 46e09a7af769-7c0df7e01d5mr3052333a34.30.1759954624061; Wed, 08 Oct 2025
 13:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <20251008174408.381-1-briansune@gmail.com>
 <20251008190713.GH298503@bill-the-cat>
 <CAN7C2SAaia8qV4sx-uMF2Y1GE4GW=WmmgSMHMApW0YoTzTqQOQ@mail.gmail.com>
 <20251008193306.GI298503@bill-the-cat>
 <CAN7C2SDaP65Eu914rAzNdhKG9oAUEeM9EhE-EEh2odONnBjWVw@mail.gmail.com>
 <20251008194613.GJ298503@bill-the-cat>
In-Reply-To: <20251008194613.GJ298503@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 9 Oct 2025 04:16:51 +0800
X-Gm-Features: AS18NWArzlzraG_S19NY0blcuNyFSrbOjcRsZcYoyBIliFuYDLRZ0cggsy64dxg
Message-ID: <CAN7C2SDR9NLpmF3Pcd9QRVRk5gBrR2fciiPwccCsev7tpRYHJQ@mail.gmail.com>
Subject: Re: [PATCH v1] cmd/dma: documentation
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B410=E6=9C=889=E6=97=A5 =
=E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=883:46=E5=AF=AB=E9=81=93=EF=BC=9A

> > > > > still) in the shell commands section. Also please do "make htmldo=
cs
> > > > > KDOC_WERROR=3D1" and make sure there's no complains for v2, I see=
 some

without adding any rst

make htmldocs KDOC_WERROR=3D1
  HOSTCC  scripts/basic/fixdep
  SPHINX  htmldocs --> file:///media/sf_shared/u-boot/doc/output
  PARSE   include/linker_lists.h
Running Sphinx v8.1.3
enabling CJK for LaTeX builder
loading translations [en]... done
Converting `source_suffix =3D '.rst'` to `source_suffix =3D {'.rst':
'restructuredtext'}`.
building [mo]: targets for 0 po files that are out of date
writing output...
building [html]: targets for 694 source files that are out of date
updating environment: [new config] 694 added, 0 changed, 0 removed
reading sources... [100%] usage/fit/kernel_fdt .. usage/upl
looking for now-outdated files... none found
pickling environment... done
checking consistency...
/media/sf_shared/u-boot/doc/develop/package/bintools.rst: WARNING:
document isn't included in any toctree
/media/sf_shared/u-boot/doc/develop/package/entries.rst: WARNING:
document isn't included in any toctree
done
preparing documents... done
copying assets...
copying downloadable files... [100%] ../Licenses/README
copying static files...
Writing evaluated template result to
/media/sf_shared/u-boot/doc/output/_static/basic.css
Writing evaluated template result to
/media/sf_shared/u-boot/doc/output/_static/language_data.js
Writing evaluated template result to
/media/sf_shared/u-boot/doc/output/_static/documentation_options.js
Writing evaluated template result to
/media/sf_shared/u-boot/doc/output/_static/js/versions.js
copying static files: done
copying extra files...
copying extra files: done
copying assets: done
/media/sf_shared/u-boot/doc/build/index.rst:6: WARNING: toctree
contains reference to document 'build/buildman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/package/index.rst:16: WARNING:
toctree contains reference to document 'develop/package/binman' that
doesn't have a title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/package/index.rst:16: WARNING:
toctree contains reference to document 'develop/package/binman' that
doesn't have a title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/build/index.rst:6: WARNING: toctree
contains reference to document 'build/buildman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/build/index.rst:6: WARNING: toctree
contains reference to document 'build/buildman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/build/index.rst:6: WARNING: toctree
contains reference to document 'build/buildman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/build/index.rst:6: WARNING: toctree
contains reference to document 'build/buildman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/build/index.rst:6: WARNING: toctree
contains reference to document 'build/buildman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/build/index.rst:6: WARNING: toctree
contains reference to document 'build/buildman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/build/index.rst:6: WARNING: toctree
contains reference to document 'build/buildman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/build/index.rst:6: WARNING: toctree
contains reference to document 'build/buildman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/build/index.rst:6: WARNING: toctree
contains reference to document 'build/buildman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/build/index.rst:6: WARNING: toctree
contains reference to document 'build/buildman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/uefi/uefi.rst:379: WARNING:
undefined label: 'etype_efi_capsule' [ref.ref]
/media/sf_shared/u-boot/doc/build/index.rst:6: WARNING: toctree
contains reference to document 'build/buildman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/package/index.rst:16: WARNING:
toctree contains reference to document 'develop/package/binman' that
doesn't have a title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/package/index.rst:16: WARNING:
toctree contains reference to document 'develop/package/binman' that
doesn't have a title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/package/index.rst:16: WARNING:
toctree contains reference to document 'develop/package/binman' that
doesn't have a title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
/media/sf_shared/u-boot/doc/develop/index.rst:9: WARNING: toctree
contains reference to document 'develop/patman' that doesn't have a
title: no link will be generated [toc.no_title]
writing output... [100%] usage/fit/x86-fit-boot .. usage/upl
generating indices... genindex py-modindex done
Creating redirect 'develop/py_testing.html' to 'pytest/usage.html'.
writing additional pages... search done
copying images... [100%] develop/pics/flamegraph_timing.png
dumping search index in English (code: en)... done
dumping object inventory... done
build finished with problems, 125 warnings (with warnings treated as errors=
).
doc/Makefile:70: recipe for target 'htmldocs' failed
make[1]: *** [htmldocs] Error 1
Makefile:2687: recipe for target 'htmldocs' failed
make: *** [htmldocs] Error 2
