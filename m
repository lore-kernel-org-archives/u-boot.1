Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE46EE3F0F
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 19:27:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F5A187027;
	Tue, 12 Sep 2023 21:27:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="t3mx6xcd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC96B86E2D; Tue, 12 Sep 2023 21:27:09 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DBA086D43
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 21:27:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-401d10e3e54so65530125e9.2
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 12:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1694546823; x=1695151623; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+P16TbxkkPAcEvwQrwCouDqYXZdoAU5Pn1jt+kkorhs=;
 b=t3mx6xcdY30HQmRKXUY/SLgAHXYeaSqKOUGeBtqixSAvOuKgYstQOxST8zaQhuyuze
 vKPWtD/6O3LhIwQVfp1q5VaDtiv0Y7yHN5tJdUzAou/twVgntb2f5aldJ04f5uoGU2g9
 qSgChDF2qsCXgQZM+vO81fmoKVMshx00tnG2gLSMfY1BAAdSFOsDZAgnV507R56WdMNh
 4J1G5MmFlJhSij+jF5wxUADRSiZ9uTDkkQzCb9yxTrRC7GTi6HWmDeCtRc5MBAgcigik
 nAx8MULgoShP1QkK6V0/0p/T64bhWnJJ+oTxSjh8yajV4gvvZRsnIaF6NPZKnLhTKHbq
 dvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694546823; x=1695151623;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+P16TbxkkPAcEvwQrwCouDqYXZdoAU5Pn1jt+kkorhs=;
 b=hO6GeEUbK1ncOfxkNhUWs/Dfj6Z7LyqsZ5jdkdL+YKeW4jbMpDQ7wWvUSraD9LIWP9
 cq4cWQJsca1eF+5PwSEiP66JJO2cG1z5obLBKmCkDXRt8W4dwt3gO+a/t5M5l5Svp9x0
 oHQsax7sb6bl+moE+sE37JiSGJ+8jAT20xP7DdbK8yGDQ3YZWHiHJp4L+T8MfRhW2Lg7
 xZBntIHrnnKmatG8E1d1DeTgDq3zvyeAZnjCg9fgk/Qaj+wPGVXH3JzZoAeS+Lebuu8x
 GgBbe7QYRbPAd6jQAGGzw0VW5JyX5xAnHq6swpJYZMPFyr7/HZzgA2dLrFoJk5uVINzB
 YHHA==
X-Gm-Message-State: AOJu0YxPke93eQOQFyk2hehdME61DWTYIKypzKxbxRQEdK7YXDje5mn2
 gT541Ktm7NMLeMNBsY58IIhW2qG2FDzPCfE3lL2vKQ==
X-Google-Smtp-Source: AGHT+IF3eR+nYmJFqPFARF4C35yH9ThiH5H18E2vjIeMDcQglt2LI0pQdKpBlO81EyMsQZoy+F2/KcZTe3Ue/AKVm3k=
X-Received: by 2002:a5d:6748:0:b0:317:7062:32d2 with SMTP id
 l8-20020a5d6748000000b00317706232d2mr343938wrw.54.1694546823509; Tue, 12 Sep
 2023 12:27:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230908135320.7066-1-maxim.uvarov@linaro.org>
 <20230908135922.GC305624@bill-the-cat>
 <CAD8XO3bWmefyQ7Dx8fn7kc3s8=uCUhG3FcE6J4H6=qFdwa3gmw@mail.gmail.com>
In-Reply-To: <CAD8XO3bWmefyQ7Dx8fn7kc3s8=uCUhG3FcE6J4H6=qFdwa3gmw@mail.gmail.com>
From: Simon Glass <sjg@google.com>
Date: Tue, 12 Sep 2023 13:26:46 -0600
Message-ID: <CAPnjgZ2Y6FJELJX7RA3_PehnCQ7zaiCeQd-VKJmtj_8nwnv3_w@mail.gmail.com>
Subject: Re: [PATCHv8 00/15] net/lwip: add lwip library for the network stack
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 goldsimon@gmx.de
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

Hi Maxim,

On Tue, 12 Sept 2023 at 05:42, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
>
> On Fri, 8 Sept 2023 at 19:59, Tom Rini <trini@konsulko.com> wrote:
>
> > On Fri, Sep 08, 2023 at 07:53:05PM +0600, Maxim Uvarov wrote:
> >
> > > Before apply these patches it  is needed to create lwIP merge into
> > U-Boot:
> > > git subtree add --prefix net/lwip/lwip-external
> > https://git.savannah.nongnu.org/git/lwip.git master --squash
> > > or
> > > create git submodule, depends how it's more easy to maintain external
> > > library.
> >
> > So, I think we're going to go with subtree.  Please work out how to
> > integrate the above in to the build process automatically (and such that
> > we can maintain it via upgrades moving forward).
> >
> > --
> > Tom
> >
>
> I did not find a good way to friend git format-patch, git am and subtree.
> And now with using subtree I can provide my thoughts, in general I do not
> see any big advantages
> with maintaining subtree code.
>
> Problem is that:
>
> 1. subtree does some root reset. So rebase looks like:
> label onto
>
>
>
> # Branch acbc0469a49de7055141cc730aa9c728e61b6de2-2
>
> reset [new root]
>
> pick acbc0469a4 Squashed 'net/lwip/lwip-external/' content from commit
> 84fde1ebbf
> label acbc0469a49de7055141cc730aa9c728e61b6de2-2
>
>
>
> reset onto
>
> merge -C ec4a128c8d acbc0469a49de7055141cc730aa9c728e61b6de2-2 # Merge
> commit 'acbc0469a49de7055141cc730aa9c728e61b6de2' as
> 'net/lwip/lwip-external'
> pick 739681a6f5 net/lwip: add doc/develop/net_lwip.rst
>
> pick f0ecab85e0 net/lwip: integrate lwIP library
>
> 2. if  --rebase-merges option was not provided to rebase, then rebase will
> omit subtree directory and try to apply rebase patches to root directory.
> I.e. in current case squashed commit for lwip, will be applied to uboot
> root directory instead of ./net/lwip/lwip-external.
>
> 3. due to broken rebases without --rebase-merges more likely things like
> git bisect also will not work.
>
> 4.  change in subtree code ./net/lwip/lwip-external/../something.c will
> create a git commit which looks like a standard U-Boot commit. I.e. path
> starts with ./net/lwip/lwip-external/

I don't really understand most of the above, but I take it that
subtree has some problems...I did find an article about subtree [1]

>
> 5. lwip maintains code with a mailing list.  So we don't need to push
> subtree git somewhere to create a pull request.
>
> 6. I rechecked the latest edk2 and they use submodules now. (openssl,
> libfdt, berkeley-softfloat-3 and others).
>
> 7. dynamic download also looks horrible for me. I.e. create subtree in
> Makefile on compilation process. I think maintaining that will give you a
> bunch of problems. I think we should not touch git structure after cloning.
>
> So what I can here suggest:
> 1.  lwip source code is 9.4M.  If we compare all code it will be 564M in
> total. So just having 1 commit witn copy of lwip library will work here.

So we add a 9.4MB patch for the code we need? I suppose that is OK,
although it is much larger than net/ today (0.5MB).

What is the churn on lwip? E.g. would it be easy to add a commit every
few months to bring in upstream changes?

>
> or
>
> 2. use git submodules. Size of the project will be lower.  Submodule will
> not allow you to use local changes. I.e. change needs to be merged into the
> upstream project and then you can update git HEAD for the submodule.

I really don't want to work with a submodule project. I've just had
too many problems.

>
> or
>
> 3. inside u-boot.git create branch lib-lwip and clone lwip repo there. Then
> use git submoule to connect this branch as a folder to the main U-Boot code.

It really needs to be properly part of U-Boot.

>
> BR,
> Maxim.

Regards,
Simon

[1] https://www.atlassian.com/git/tutorials/git-subtree
