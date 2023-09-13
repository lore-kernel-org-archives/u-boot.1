Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF10CA5500
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 07:32:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB41E86E4E;
	Wed, 13 Sep 2023 09:32:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kIsW6zG8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFC6D86E51; Wed, 13 Sep 2023 09:32:09 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7A6986D80
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 09:32:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-99357737980so807535166b.2
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 00:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694590326; x=1695195126; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=e8jgM7S5g+ElXtRCxVcrN2ek7f/6n3jl2/6+aualr5U=;
 b=kIsW6zG8N8W9F0+Oxay84TWVPByR9C/V/TE/3O4qWWtvhHCSSrX+ricBN3QtnJ1AjF
 xVwRuTlWL/TjDy+bWaJgexw1B1RkV21RvTFZHFRSeN0/vmZsTrQQjvmea+Bvixjljr+9
 RtwivPuYrbbD3G/I3xEy7c8RJth2GGxjQcKmKjesL4rJWncrpgwg2HPegb/E7MDrEtE+
 i2indiuvMN/Wdj13645EpoNWfyCk59/IS10Ky3t38WbuqdWzriNWNGQzhYlcKC9CXMCe
 zqa9QFDXGDlgenUkKnW1e1oOwm2H5Uyk6UJABWAO2LS2ANGcveVlDNc3V1zBrsX49pp8
 fFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694590326; x=1695195126;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e8jgM7S5g+ElXtRCxVcrN2ek7f/6n3jl2/6+aualr5U=;
 b=xGVwvOlYxT2LSH9uQ56sxw0+Rk2OHQ9vk5K71YTYme/xZkDQuLyTtf4JiiWzgpAR1f
 kYY568RlJBlk0MVXBwcSJnxsoSSoZaR80x/g7lCLCCBtLMpf/ZxBOEh/lhIoY9OI3rO9
 SyTMonplhwsq4xOZ1dFIByQ7J87lc1MA6+aaQ79f/uvB4Lsc/CrDcuMIKWLKfl6nBUmN
 u6HYTaCVrmxfq4ywkSW7JQiAklepU/47kzLCrPiXHk7i8uRvbfEWBZdOFUUi/h26o9vn
 1K4kNvbgrQB35/oBqULnqUyTPB8gDJkReArvu65cw15hP/Kl3Kdf4HPdaP7BuXyjlLDc
 rBvw==
X-Gm-Message-State: AOJu0YyxgNQ4x9Xmi/eJmHl/O1exL3P7pYiXOo7NifWiBILHTNSeb+z/
 nSWEsqlVeQiChFrYDErlmBh4QKt61a9v/jXVZY96hA==
X-Google-Smtp-Source: AGHT+IEz8ZlfORkCI1tEdncHWk4Kd9hcDcmSlxuF1e2npPdSKCTo+gUBm8YA8zrHTk+Y7SwlXKXVkVNRuIF5J42Gh5U=
X-Received: by 2002:a17:906:538f:b0:9aa:1c9f:8c79 with SMTP id
 g15-20020a170906538f00b009aa1c9f8c79mr1444894ejo.68.1694590326177; Wed, 13
 Sep 2023 00:32:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230908135320.7066-1-maxim.uvarov@linaro.org>
 <20230908135922.GC305624@bill-the-cat>
 <CAD8XO3bWmefyQ7Dx8fn7kc3s8=uCUhG3FcE6J4H6=qFdwa3gmw@mail.gmail.com>
 <CAPnjgZ2Y6FJELJX7RA3_PehnCQ7zaiCeQd-VKJmtj_8nwnv3_w@mail.gmail.com>
In-Reply-To: <CAPnjgZ2Y6FJELJX7RA3_PehnCQ7zaiCeQd-VKJmtj_8nwnv3_w@mail.gmail.com>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Wed, 13 Sep 2023 13:31:54 +0600
Message-ID: <CAD8XO3Ynafpncs42KPX9sDw-5VQHQpwJq=22SzXDi27Dz6rrEg@mail.gmail.com>
Subject: Re: [PATCHv8 00/15] net/lwip: add lwip library for the network stack
To: Simon Glass <sjg@google.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 goldsimon@gmx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Wed, 13 Sept 2023 at 01:27, Simon Glass <sjg@google.com> wrote:

> Hi Maxim,
>
> On Tue, 12 Sept 2023 at 05:42, Maxim Uvarov <maxim.uvarov@linaro.org>
> wrote:
> >
> > On Fri, 8 Sept 2023 at 19:59, Tom Rini <trini@konsulko.com> wrote:
> >
> > > On Fri, Sep 08, 2023 at 07:53:05PM +0600, Maxim Uvarov wrote:
> > >
> > > > Before apply these patches it  is needed to create lwIP merge into
> > > U-Boot:
> > > > git subtree add --prefix net/lwip/lwip-external
> > > https://git.savannah.nongnu.org/git/lwip.git master --squash
> > > > or
> > > > create git submodule, depends how it's more easy to maintain external
> > > > library.
> > >
> > > So, I think we're going to go with subtree.  Please work out how to
> > > integrate the above in to the build process automatically (and such
> that
> > > we can maintain it via upgrades moving forward).
> > >
> > > --
> > > Tom
> > >
> >
> > I did not find a good way to friend git format-patch, git am and subtree.
> > And now with using subtree I can provide my thoughts, in general I do not
> > see any big advantages
> > with maintaining subtree code.
> >
> > Problem is that:
> >
> > 1. subtree does some root reset. So rebase looks like:
> > label onto
> >
> >
> >
> > # Branch acbc0469a49de7055141cc730aa9c728e61b6de2-2
> >
> > reset [new root]
> >
> > pick acbc0469a4 Squashed 'net/lwip/lwip-external/' content from commit
> > 84fde1ebbf
> > label acbc0469a49de7055141cc730aa9c728e61b6de2-2
> >
> >
> >
> > reset onto
> >
> > merge -C ec4a128c8d acbc0469a49de7055141cc730aa9c728e61b6de2-2 # Merge
> > commit 'acbc0469a49de7055141cc730aa9c728e61b6de2' as
> > 'net/lwip/lwip-external'
> > pick 739681a6f5 net/lwip: add doc/develop/net_lwip.rst
> >
> > pick f0ecab85e0 net/lwip: integrate lwIP library
> >
> > 2. if  --rebase-merges option was not provided to rebase, then rebase
> will
> > omit subtree directory and try to apply rebase patches to root directory.
> > I.e. in current case squashed commit for lwip, will be applied to uboot
> > root directory instead of ./net/lwip/lwip-external.
> >
> > 3. due to broken rebases without --rebase-merges more likely things like
> > git bisect also will not work.
> >
> > 4.  change in subtree code ./net/lwip/lwip-external/../something.c will
> > create a git commit which looks like a standard U-Boot commit. I.e. path
> > starts with ./net/lwip/lwip-external/
>
> I don't really understand most of the above, but I take it that
> subtree has some problems...I did find an article about subtree [1]
>
> >
> > 5. lwip maintains code with a mailing list.  So we don't need to push
> > subtree git somewhere to create a pull request.
> >
> > 6. I rechecked the latest edk2 and they use submodules now. (openssl,
> > libfdt, berkeley-softfloat-3 and others).
> >
> > 7. dynamic download also looks horrible for me. I.e. create subtree in
> > Makefile on compilation process. I think maintaining that will give you a
> > bunch of problems. I think we should not touch git structure after
> cloning.
> >
> > So what I can here suggest:
> > 1.  lwip source code is 9.4M.  If we compare all code it will be 564M in
> > total. So just having 1 commit witn copy of lwip library will work here.
>
> So we add a 9.4MB patch for the code we need? I suppose that is OK,
> although it is much larger than net/ today (0.5MB).
>
> What is the churn on lwip? E.g. would it be easy to add a commit every
> few months to bring in upstream changes?
>
> >
> > or
> >
> > 2. use git submodules. Size of the project will be lower.  Submodule will
> > not allow you to use local changes. I.e. change needs to be merged into
> the
> > upstream project and then you can update git HEAD for the submodule.
>
> I really don't want to work with a submodule project. I've just had
> too many problems.
>
> >
> > or
> >
> > 3. inside u-boot.git create branch lib-lwip and clone lwip repo there.
> Then
> > use git submoule to connect this branch as a folder to the main U-Boot
> code.
>
> It really needs to be properly part of U-Boot.
>
>
Ok. Then more likely we don't need all the git history of lwip inside
uboot.git. Then the option with a single commit is more preferable.
Then we can use part 2 of this article, how to  go with standard git
commands:

1.
<cmd>
git remote add -f lwip https://git.savannah.nongnu.org/git/lwip.git
git read-tree --prefix=net/lwip/lwip-external -u lwip/master
git commit -m "lwip merge sha: xxxx"
</cmd>
this will create a git format-patch friendly commit. Then we send it to the
mailing list  and apply.
I hope the mailing list will allow us to send a 7.8 MB patch.


Then if for development you need  to pull he history of lwip, you can do it
with:
git pull -s subtree lwip  master --allow-unrelated-histories
(but I think nobody will need this.)

New update of the lwip net/lwip/lwip-external dir will be done with:
git pull -s subtree lwip  master --allow-unrelated-histories --squash
Squash commit also has to be git format-patch friendly.

If you are ok with that proposal I will send v9 with the first patch
created with steps above.

Thanks,
Maxim.







> >
> > BR,
> > Maxim.
>
> Regards,
> Simon
>
> [1] https://www.atlassian.com/git/tutorials/git-subtree
>
