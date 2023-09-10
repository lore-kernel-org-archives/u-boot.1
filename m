Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384AEEE49A4
	for <u-boot@archiver.kernel.org>; Sun, 10 Sep 2023 22:38:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE79586CD0;
	Mon, 11 Sep 2023 00:37:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="drbzFnwk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AAEB86CD5; Mon, 11 Sep 2023 00:37:15 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9C6186CC0
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 00:37:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-52e828ad46bso5002442a12.1
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 15:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694385429; x=1694990229; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aoI1xo68IKvqKn7RCw4qajKiFAaBT2nRTRA5Lc8vU+0=;
 b=drbzFnwkqAKqYmLvxFwezaTmGJYYkfxrXB6ZIJ0qZwnbOVIX/7llclxF6Nt7Qx4GgG
 h2mz2f8jiADoJUFa/r/8mZKg05yp+MRtL8LX5SWtNitebq1OJesQ9TsYHZUk2yOqie8/
 r4PJgYETwp5stYVdUlFysIvQ+hVj/pAd16xQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694385429; x=1694990229;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aoI1xo68IKvqKn7RCw4qajKiFAaBT2nRTRA5Lc8vU+0=;
 b=NYjBE6w2hH1V/kYn5qyfPTXfk8gVngZxnh4hRRh7NikbeAy90tZqlZxJ1ODXXupvpC
 14KzSF0JrRq2W2WDFZSxb2WcKE/qv4gF/j8rLbzlJOv1z596pYOLidhavS8XKhOvQjgX
 HN1HLwg7vudihJKRMUpay/00IBHe+NN+XVCtH6ALbrkq6g0w9FQf8geImnjdMTU6hojw
 4ryUXzG8Oltj9pLoKXQOugQABx2idNpK4xgF21cligyGvZhxi0kBuRH6UomZPbiuiw1v
 WgoMHIGHZXcyQ6Lx+BIeU2xZOdr4mzp7X/bvAKMJovNH/UMd7g0/5xVOfpqmqkglPQi+
 sDMQ==
X-Gm-Message-State: AOJu0YwdsvS3DUzwOfWeyZxI0t/AIly9r0R7xB+vJ88Lqjsh74ht+hEP
 3iIQzqf5w22OuJgQRWPiOIrO0onKWyqNRepYSvFSlygAbDYywDplPz8=
X-Google-Smtp-Source: AGHT+IGAKygUVa/fHmaLQ4IGBrmYY/++iwOR8BOisOw8j+nDx9pHTwP861vkS7P0iwuGqzaC3QB4QgY7OizHn5LFGdI=
X-Received: by 2002:aa7:d955:0:b0:52e:3262:e6c9 with SMTP id
 l21-20020aa7d955000000b0052e3262e6c9mr7125957eds.33.1694385429507; Sun, 10
 Sep 2023 15:37:09 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_A957A85155C40E033B2189AC8CCB3995F607@qq.com>
 <CAPnjgZ1fWjL_qy+W4ygOvA2dDjK2v15zTJFkeNdqSSCDq8FuWQ@mail.gmail.com>
 <tencent_BA46C710370DF285E4B2EA2E35553A5FF909@qq.com>
In-Reply-To: <tencent_BA46C710370DF285E4B2EA2E35553A5FF909@qq.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 10 Sep 2023 16:36:54 -0600
Message-ID: <CAPnjgZ12yLwPpo=8BBFmNOnz=RWykTtCzFOQyi11MgvS74QTcw@mail.gmail.com>
Subject: Re: [PATCH v2] binman: Fix SyntaxWarning: invalid escape sequence '\('
To: =?UTF-8?B?6I2j5rab?= <rtoax@foxmail.com>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ivan Mikhaylov <fr0st61te@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, open list <u-boot@lists.denx.de>,
 Rong Tao <rongtao@cestc.cn>
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

Hi,

On Tue, 5 Sept 2023 at 19:34, =E8=8D=A3=E6=B6=9B <rtoax@foxmail.com> wrote:
>
> Thanks, Simon
>
> The following lines is my systeme ENV and make log
>
> $ cat /etc/os-release
> NAME=3D"Fedora Linux"
> VERSION=3D"40 (Workstation Edition Prerelease)"
> ID=3Dfedora
> VERSION_ID=3D40
> VERSION_CODENAME=3D""
> PLATFORM_ID=3D"platform:f40"
> PRETTY_NAME=3D"Fedora Linux 40 (Workstation Edition Prerelease)"
> ANSI_COLOR=3D"0;38;2;60;110;180"
> LOGO=3Dfedora-logo-icon
> CPE_NAME=3D"cpe:/o:fedoraproject:fedora:40"
> DEFAULT_HOSTNAME=3D"fedora"
> HOME_URL=3D"https://fedoraproject.org/"
> DOCUMENTATION_URL=3D"https://docs.fedoraproject.org/en-US/fedora/rawhide/=
system-administrators-guide/"
> SUPPORT_URL=3D"https://ask.fedoraproject.org/"
> BUG_REPORT_URL=3D"https://bugzilla.redhat.com/"
> REDHAT_BUGZILLA_PRODUCT=3D"Fedora"
> REDHAT_BUGZILLA_PRODUCT_VERSION=3Drawhide
> REDHAT_SUPPORT_PRODUCT=3D"Fedora"
> REDHAT_SUPPORT_PRODUCT_VERSION=3Drawhide
> SUPPORT_END=3D2024-05-14
> VARIANT=3D"Workstation Edition"
> VARIANT_ID=3Dworkstation
>
> $ uname -r
> 6.6.0-0.rc0.20230901git99d99825fc07.3.fc40.x86_64
>
> $ gcc --version
> gcc (GCC) 13.2.1 20230728 (Red Hat 13.2.1-1)
> Copyright (C) 2023 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is N=
O
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOS=
E.
>
> $ make qemu-x86_64_defconfig
>   HOSTCC  scripts/basic/fixdep
>   HOSTCC  scripts/kconfig/conf.o
>   YACC    scripts/kconfig/zconf.tab.c
>   LEX     scripts/kconfig/zconf.lex.c
>   HOSTCC  scripts/kconfig/zconf.tab.o
>   HOSTLD  scripts/kconfig/conf
> #
> # configuration written to .config
> #
>
> $ make -j8
> ... [too much logs]
>   SYM     spl/u-boot-spl.sym
>   OBJCOPY spl/u-boot-x86-start16-spl.bin
>   OBJCOPY spl/u-boot-x86-reset16-spl.bin
>   CAT     spl/u-boot-spl-dtb.bin
>   COPY    spl/u-boot-spl.bin
>   BINMAN  .binman_stamp
> /home/sda/git-repos/u-boot/tools/binman/etype/section.py:25: SyntaxWarnin=
g: invalid escape sequence '\('
>   """Entry that contains other entries
>   OFCHK   .config
>

Thanks for that. What is your Python version?

Regards,
Simon
