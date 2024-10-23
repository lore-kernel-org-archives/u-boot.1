Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E58AD2E021
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 07:52:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9ABA988A43;
	Wed, 23 Oct 2024 09:52:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="DUVaujlD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4E8188A4C; Wed, 23 Oct 2024 09:52:25 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [IPv6:2003:a:e28:26e4::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1B8E889E9
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 09:52:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DFF9B148B1E8; Wed, 23 Oct 2024 09:52:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1729669942; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=FHZgnu86H2wBqH4o/4Q7W07dDd3jJHg8HPMmEgfsQNc=;
 b=DUVaujlDe5k3efxSIJjDBfIp1as9lTOhfE8Ah+cwdOnRObK4k6HEDyJdVDyT7xcQ57jPNp
 akGIZgX3uSma+ME44+NkQ7zlsyOKylufJGSWXsIphkJnLuyJXzZmUpXgUUDPiNY5kilcbm
 f9pF9FpCLn4FlKu8x1fI1lGOwsRpbMZkfhaoBfDnDd3qv+nUAIch3lzNzhqvb3Cwmzevac
 3zas7POlC1LfK8RDm2qIT/T6TYGtuc6GXtQK4mdyFGb4RNeJJRzHXV6GSgkErjDMaps3cM
 i4lVFA6rLYAVhM8PeFpmnJVZWpQcYmlpSFrUt0TQQwzIa3oPWzlNU28DMG6Y5A==
Date: Wed, 23 Oct 2024 09:52:09 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Bin Meng <bmeng.cn@gmail.com>
Subject: Re: enabling W=1 by default
Message-ID: <20241023-gizzard-untracked-4a1c6d2f6be6@thorsis.com>
Mail-Followup-To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>
References: <ZxZk4K4ff1T3gUVm@smile.fi.intel.com>
 <CAFLszTjuodDFZW8fJDL1Q3nByLVzcTTEAeJfws-sbtupCwNd8w@mail.gmail.com>
 <ZxenO05qCbt5IIZS@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxenO05qCbt5IIZS@smile.fi.intel.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3
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

Hello,

Am Tue, Oct 22, 2024 at 04:23:07PM +0300 schrieb Andy Shevchenko:
> On Mon, Oct 21, 2024 at 06:32:21PM +0200, Simon Glass wrote:
> > On Mon, 21 Oct 2024 at 16:27, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > looking at the redness of the output of `make W=1` here is the question:
> > > isn't it a good time to enable `make W=1` by default. Yes, I understand
> > > the impact, but at least we can do it mandatory for a _new_ code submitted to
> > > U-Boot, right?
> > >
> > > Ideally I would have what Linux kernel has for a few releases already, i.e.
> > > Werror by default and getting close to make a clean builds with that and
> > > make W=1` at least against default configurations (yeah, with U-Boot there is
> > > probably no default, but sandbox one).
> > 
> > Warnings should be warnings...
> 
> Yes, and ideally the code should not have warnings, right?

+1

> Otherwise how can we do better? It's quite similar to what you wrote WRT
> documenting the function prototypes, the same applies to the new contribution
> WRT `make W=1`.
> 
> > if you would like to enable it for CI that is fine by me,
> 
> Yes, that's the idea, but I'm not the owner of any U-Boot CIs,
> hence it's a proposal.
> 
> > but the U-Boot makefile shouldn't do it. It defeats the purpose of
> > having a distinction between errors and warnings.
> 
> While it's not what I wanted, I disagree on your comment. The idea is to make
> rules stricter (for new code) to make it better and that's why Linus enabled
> Werror by default in the Linux kernel. And personally I consider that as a good
> thing to follow.

Long term experience: each time you upgrade your toolchain you get new
warnings.  Each package (u-boot, kernel, userland, does not matter
which) enabling -Werror breaks the BSP build.  What should a developer
do then?  Fix each warning in each foreign project and bring it
upstream?  Or disable -Werror?  Last thing is what is usually done.
You can see several patches in buildroot or ptxdist disabling -Werror
for this reason.

Just my 2 cents.

Greets
Alex

