Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B460CA0EC3
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 11:42:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39F40868D0;
	Tue, 12 Sep 2023 13:42:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VQyyidPu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8A9F869D2; Tue, 12 Sep 2023 13:42:00 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2AA4864A5
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 13:41:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-99bcc0adab4so698487266b.2
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 04:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694518917; x=1695123717; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0jQkRHNOH9CSNebHCaAY4tP5ci1inkSpWHn0E/RjgMI=;
 b=VQyyidPuUNcId03oCfsJl+0WjWmMloWfKY+ITy/wzHNZsvHf8SMq7MdV/pq5Im3kW5
 VhvODbguluVw1uVuPIc/XouoUJnKd6tQmXms3GiG3hInIcB7S17HlEsO3zfKBAcB9nMy
 Ibhu0oL7CCOFS1STfFhZZ6AxyW1CFS9jkZZsmxwPrjwrjqs9VUWwZqmHVD44bLluznln
 8yineSWLDjw0qrngEWPaZZpmvvLIMN3CtjD7ANGnLYM/oRchbAkBYdBnyUceEPugcAtn
 MKfbocFQtBrt2c143cAY8/HhndDUIsBFt8vZfTEg2TaTwgMrzzyaMLDWxE6RUVr3ZhAW
 1W1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694518917; x=1695123717;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0jQkRHNOH9CSNebHCaAY4tP5ci1inkSpWHn0E/RjgMI=;
 b=KcVdWl9MxpY63XMTbxa2ihaAVOtn4dyFeczGB+S/P/VMYgkSGBEs6C7SHTV9A6Vvsi
 T9fJL2hcYaRHDlGOP3VBmBlUyRtC+DOoZjKgOixTO8rNxLvHldVWgWT4Spw5RLqrXA87
 47nG5JhmHsjrYeYZ0Zi7YqKJmIjKpXUp3KUT18JVLajehapuwGDk8KDAtntSjNkPZztm
 /v2YL3t/H7lo6QiY2y1wecvtKj350Dhnr3gYb5Es/d+KKziGMefJBTAHcgGp4ROoDEFG
 bFQXpBYk1OMAYBgYijwV7ThJE9hgmtTiBuM/7xpfBdxBwTZ69zMZQXKdbNXfQ2L4BO+l
 gigg==
X-Gm-Message-State: AOJu0YySzP6miJ9K5fXCfwAsVGPwPCmYGhkK/FnFxs8IgWnpxa5A6ef1
 zmxfdXpIuHAUC0hu+wIFNvrngKQtmclkkPi2QTfJcw==
X-Google-Smtp-Source: AGHT+IHy1AP9o8k/IHLbKrpQcOwAIKlZj+Q5nCoFms8jXRaZTm1VNOuZRL8fVYhbUpGyhwJCNLzioV63PBvip0cOcR8=
X-Received: by 2002:a17:907:7630:b0:9aa:2bd:b59b with SMTP id
 jy16-20020a170907763000b009aa02bdb59bmr8577096ejc.39.1694518917152; Tue, 12
 Sep 2023 04:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230908135320.7066-1-maxim.uvarov@linaro.org>
 <20230908135922.GC305624@bill-the-cat>
In-Reply-To: <20230908135922.GC305624@bill-the-cat>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Tue, 12 Sep 2023 17:41:44 +0600
Message-ID: <CAD8XO3bWmefyQ7Dx8fn7kc3s8=uCUhG3FcE6J4H6=qFdwa3gmw@mail.gmail.com>
Subject: Re: [PATCHv8 00/15] net/lwip: add lwip library for the network stack
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org, 
 joe.hershberger@ni.com, rfried.dev@gmail.com, goldsimon@gmx.de
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

On Fri, 8 Sept 2023 at 19:59, Tom Rini <trini@konsulko.com> wrote:

> On Fri, Sep 08, 2023 at 07:53:05PM +0600, Maxim Uvarov wrote:
>
> > Before apply these patches it  is needed to create lwIP merge into
> U-Boot:
> > git subtree add --prefix net/lwip/lwip-external
> https://git.savannah.nongnu.org/git/lwip.git master --squash
> > or
> > create git submodule, depends how it's more easy to maintain external
> > library.
>
> So, I think we're going to go with subtree.  Please work out how to
> integrate the above in to the build process automatically (and such that
> we can maintain it via upgrades moving forward).
>
> --
> Tom
>

I did not find a good way to friend git format-patch, git am and subtree.
And now with using subtree I can provide my thoughts, in general I do not
see any big advantages
with maintaining subtree code.

Problem is that:

1. subtree does some root reset. So rebase looks like:
label onto



# Branch acbc0469a49de7055141cc730aa9c728e61b6de2-2

reset [new root]

pick acbc0469a4 Squashed 'net/lwip/lwip-external/' content from commit
84fde1ebbf
label acbc0469a49de7055141cc730aa9c728e61b6de2-2



reset onto

merge -C ec4a128c8d acbc0469a49de7055141cc730aa9c728e61b6de2-2 # Merge
commit 'acbc0469a49de7055141cc730aa9c728e61b6de2' as
'net/lwip/lwip-external'
pick 739681a6f5 net/lwip: add doc/develop/net_lwip.rst

pick f0ecab85e0 net/lwip: integrate lwIP library

2. if  --rebase-merges option was not provided to rebase, then rebase will
omit subtree directory and try to apply rebase patches to root directory.
I.e. in current case squashed commit for lwip, will be applied to uboot
root directory instead of ./net/lwip/lwip-external.

3. due to broken rebases without --rebase-merges more likely things like
git bisect also will not work.

4.  change in subtree code ./net/lwip/lwip-external/../something.c will
create a git commit which looks like a standard U-Boot commit. I.e. path
starts with ./net/lwip/lwip-external/

5. lwip maintains code with a mailing list.  So we don't need to push
subtree git somewhere to create a pull request.

6. I rechecked the latest edk2 and they use submodules now. (openssl,
libfdt, berkeley-softfloat-3 and others).

7. dynamic download also looks horrible for me. I.e. create subtree in
Makefile on compilation process. I think maintaining that will give you a
bunch of problems. I think we should not touch git structure after cloning.

So what I can here suggest:
1.  lwip source code is 9.4M.  If we compare all code it will be 564M in
total. So just having 1 commit witn copy of lwip library will work here.

or

2. use git submodules. Size of the project will be lower.  Submodule will
not allow you to use local changes. I.e. change needs to be merged into the
upstream project and then you can update git HEAD for the submodule.

or

3. inside u-boot.git create branch lib-lwip and clone lwip repo there. Then
use git submoule to connect this branch as a folder to the main U-Boot code.

BR,
Maxim.
