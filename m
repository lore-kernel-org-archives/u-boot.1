Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41303C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 09:28:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2D5A88191;
	Wed,  5 Jun 2024 11:28:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="iKJTQ2yn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED8B588363; Wed,  5 Jun 2024 11:28:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F22C87A9C
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 11:27:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717579679; x=1749115679;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=WPoPOegDA7qnW7xFfyT9nDw0PzKrdK1SLTY1YDc7ZUU=;
 b=iKJTQ2yn1Gvviiy6rygyUqbOn7Q6x56rOJiZpB1LmjTbckTzr0OtDAwC
 3jmlSut5MwaEL8BBvva0A5hCLc0+c2V4ovZD+trIBWplDG1dVsH6/BloB
 9LZtLZ1rQSMAY6hqp/o1pp4Mbn/wwtkNsOeRovVuF/ckY20oUHo22mM1F
 XxyzREhsBROQ0WQHn45GUZG8NxjAwsWuMw43cIdI5j3ZXbt7ZuRMPUA3u
 AmhGCc7myXgMhZRl/GmNH/rWzGFGEN39GoaB2xBbNuJCbOLFnNRdQs7v/
 Fn2++ddnyr5CtBWL1NxqUwICC5aiiA0NbFhhK+gXM2VTzKoxlENl805H3 w==;
X-CSE-ConnectionGUID: 8iF8W90nTPK9c4EE/zty5A==
X-CSE-MsgGUID: /cbg2tqvTm6dduXI7Lo/sg==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="13924001"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; d="scan'208";a="13924001"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2024 02:27:56 -0700
X-CSE-ConnectionGUID: Y+Ho9WhCSY2ecqZ5YCiIzg==
X-CSE-MsgGUID: seE8UKgMT8OUkWFF4/+RSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; d="scan'208";a="41954955"
Received: from smile.fi.intel.com ([10.237.72.54])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2024 02:27:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1sEmvq-0000000DofM-1hwW; Wed, 05 Jun 2024 12:27:46 +0300
Date: Wed, 5 Jun 2024 12:27:46 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Sergei Antonov <saproj@gmail.com>, Ilya Lukin <4.shket@gmail.com>,
 Bin Meng <bmeng@tinylab.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: Re: [PATCH v3 02/25] mbedtls: Add script to update MbedTLS subtree
Message-ID: <ZmAvkgR96DhXWWHf@smile.fi.intel.com>
References: <20240528140955.1960172-1-raymond.mao@linaro.org>
 <20240528140955.1960172-3-raymond.mao@linaro.org>
 <CAC_iWjLhKEcFzNpAAms66+BYFOT_Q3AA2LBdOupFU=cXSVRXBQ@mail.gmail.com>
 <Zl90teNwRIDtgiKR@smile.fi.intel.com>
 <CAC_iWj+7MyQnN7b+e1egFCuur0wjsMuBL9FKbGYvFAqXzdk-2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC_iWj+7MyQnN7b+e1egFCuur0wjsMuBL9FKbGYvFAqXzdk-2Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
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

On Wed, Jun 05, 2024 at 10:11:04AM +0300, Ilias Apalodimas wrote:
> On Tue, 4 Jun 2024 at 23:10, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, May 31, 2024 at 09:32:38AM +0300, Ilias Apalodimas wrote:
> > > On Tue, 28 May 2024 at 17:10, Raymond Mao <raymond.mao@linaro.org> wrote:

...

> > > > +    if ! git remote get-url mbedtls_upstream 2>/dev/null
> > >
> > > if [ -z "$(git remote get-url rigin 2>/dev/null)" ]; then
> >
> > Why? I mean why do we need an additional `test` call? Above can be transformed
> > to `foo && {}` notation to get rid of if completely.
> 
> That's the usual syntax we have in other scripts

Maybe, but it doesn't mean that "usual" syntax is not suboptimal or well
portable.

> > > > +    then
> > > > +        echo "Warning: Script automatically adds new git remote via:"
> > > > +        echo "    git remote add mbedtls_upstream \\"
> > > > +        echo "        https://github.com/Mbed-TLS/mbedtls.git"
> > > > +        git remote add mbedtls_upstream \
> > > > +            https://github.com/Mbed-TLS/mbedtls.git
> > > > +    fi
> > > > +    git fetch mbedtls_upstream master
> > > > +}

...

> > > > +if [ "$1" = "pull" ]
> > >
> > > "$1" == 'pull'
> >
> > Why? Isn't this bashism?
> 
> You don't need variable expansion here, so I don't see why you need
> "". Unless you mean the ==, I am fine leaving that to =

The latter one. Since the script is shebanged with sh, it should be compatible
with any shell. Shell is hard to learn programming language, more than 98%
people can't write shell scripts properly, unfortunately. But this is our
legacy...

> > > Also on string literals, you don't need "", 'pull' is enough

That's okay.

...

> > > > +elif [ "$1" = "pick" ]
> > > move then 'then' one line up and add a ;
> >
> > >  == 'pick'
> >
> > Ditto.
> >
> > > > +then
> > > > +    remote_add_and_fetch
> > > > +    git cherry-pick -x --strategy=subtree \
> > > > +        -Xsubtree=lib/mbedtls/external/mbedtls/ "$2"
> > > > +else
> > > > +    echo "usage: $0 <op> <ref>"
> > > > +    echo "  <op>     pull or pick"
> > > > +    echo "  <ref>    release tag [pull] or commit id [pick]"
> > > > +fi
> >
> > Sheel should be written as much as portable and less verbose.

-- 
With Best Regards,
Andy Shevchenko


