Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC091C25B78
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 20:10:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 593CF87CF1;
	Tue,  4 Jun 2024 22:10:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="iTi8wiEM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A85EA87ECD; Tue,  4 Jun 2024 22:10:43 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B295487C69
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 22:10:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717531841; x=1749067841;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Ak8TgT2QOTzyoEFTIWcKvpCCZKK51HjKEvGid7QsAkg=;
 b=iTi8wiEMyqu1dVQmMcVYf7HxR7l56bfqVCFlMGo8y0ZumRAXKftYpL6/
 I3BvuwhNPvjVJkauuvx7Plw+F3ZBA4B9NznxC45AijASfX5VBd0taOSjr
 Kh4naepBEwaBWrJZ2sLUhzTxYDzCmg3f5/+4UsVi6aWUO20ETN+Z4L8l7
 PNOI/V0AJKh8jk6CglqQcGFz9jY69v7wmwAya9oQPnV88zhaeLGonnhX7
 oBPsCbfR9oJpwHT9AcVLEOzmguY+DH4Yba4UHRzCt5nluzawDJIHSMZdN
 jLiR1o25XeZsmf4IB8+U6+caJQ503UrdgJ8diqR0NFyg/9eKccefqZK+Y A==;
X-CSE-ConnectionGUID: TqSE0j5gTB6IXA88Bd/i+A==
X-CSE-MsgGUID: TKBo2uZ9RNGSBIks7Q8Z6A==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="11904309"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; d="scan'208";a="11904309"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2024 13:10:38 -0700
X-CSE-ConnectionGUID: Xg99aHJiSpShpZnkp7FT7Q==
X-CSE-MsgGUID: BDOlfaSHRmGJcZ5wqjPcag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; d="scan'208";a="37363786"
Received: from smile.fi.intel.com ([10.237.72.54])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2024 13:10:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1sEaUH-0000000DeQK-48KT; Tue, 04 Jun 2024 23:10:29 +0300
Date: Tue, 4 Jun 2024 23:10:29 +0300
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
Message-ID: <Zl90teNwRIDtgiKR@smile.fi.intel.com>
References: <20240528140955.1960172-1-raymond.mao@linaro.org>
 <20240528140955.1960172-3-raymond.mao@linaro.org>
 <CAC_iWjLhKEcFzNpAAms66+BYFOT_Q3AA2LBdOupFU=cXSVRXBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC_iWjLhKEcFzNpAAms66+BYFOT_Q3AA2LBdOupFU=cXSVRXBQ@mail.gmail.com>
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

On Fri, May 31, 2024 at 09:32:38AM +0300, Ilias Apalodimas wrote:
> On Tue, 28 May 2024 at 17:10, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > lib/mbedtls/update-mbedtls-subtree.sh is a wrapper of git subtree
> > commands.
> > Usage from U-Boot top directory, run:

...

> > +    if ! git remote get-url mbedtls_upstream 2>/dev/null
> 
> if [ -z "$(git remote get-url rigin 2>/dev/null)" ]; then

Why? I mean why do we need an additional `test` call? Above can be transformed
to `foo && {}` notation to get rid of if completely.

> > +    then
> > +        echo "Warning: Script automatically adds new git remote via:"
> > +        echo "    git remote add mbedtls_upstream \\"
> > +        echo "        https://github.com/Mbed-TLS/mbedtls.git"
> > +        git remote add mbedtls_upstream \
> > +            https://github.com/Mbed-TLS/mbedtls.git
> > +    fi
> > +    git fetch mbedtls_upstream master
> > +}

...

> > +if [ "$1" = "pull" ]
> 
> "$1" == 'pull'

Why? Isn't this bashism?

> Also on string literals, you don't need "", 'pull' is enough
> 
> > +then
> > +    remote_add_and_fetch
> > +    git subtree pull --prefix lib/mbedtls/external/mbedtls mbedtls_upstream \
> > +        "$2" --squash -m "${merge_commit_msg}"
> > +elif [ "$1" = "pick" ]
> move then 'then' one line up and add a ;

>  == 'pick'

Ditto.

> > +then
> > +    remote_add_and_fetch
> > +    git cherry-pick -x --strategy=subtree \
> > +        -Xsubtree=lib/mbedtls/external/mbedtls/ "$2"
> > +else
> > +    echo "usage: $0 <op> <ref>"
> > +    echo "  <op>     pull or pick"
> > +    echo "  <ref>    release tag [pull] or commit id [pick]"
> > +fi

Sheel should be written as much as portable and less verbose.

-- 
With Best Regards,
Andy Shevchenko


