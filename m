Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E48C9C36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 10:41:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3536783641;
	Wed,  9 Apr 2025 12:41:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7D718364E; Wed,  9 Apr 2025 12:41:44 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 7095B8363C
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 12:41:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C4DB152B;
 Wed,  9 Apr 2025 03:41:42 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F6043F59E;
 Wed,  9 Apr 2025 03:41:40 -0700 (PDT)
Date: Wed, 9 Apr 2025 11:41:37 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Joe Hershberger
 <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, Marek Vasut
 <marex@denx.de>, Michal Simek <michal.simek@amd.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 05/18] net/net: fix switch/case fallthrough annotations
Message-ID: <20250409114137.181e39d5@donnerap.manchester.arm.com>
In-Reply-To: <20250409014646.GB5495@bill-the-cat>
References: <20250327153313.2105227-1-andre.przywara@arm.com>
 <20250327153313.2105227-6-andre.przywara@arm.com>
 <20250408222918.GA1475540@bill-the-cat>
 <20250409005347.04003b4b@minigeek.lan>
 <20250409014646.GB5495@bill-the-cat>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 8 Apr 2025 19:46:46 -0600
Tom Rini <trini@konsulko.com> wrote:

Hi Tom,

> On Wed, Apr 09, 2025 at 12:53:47AM +0100, Andre Przywara wrote:
> > On Tue, 8 Apr 2025 16:29:18 -0600
> > Tom Rini <trini@konsulko.com> wrote:
> > 
> > Hi Tom,
> > 
> > thanks for staying on this!
> >   
> > > On Thu, Mar 27, 2025 at 03:33:00PM +0000, Andre Przywara wrote:
> > >   
> > > > The net_check_prereq() routine in the generic network handling code
> > > > mixes case: labels with #ifdef's, which makes predicting fallthrough
> > > > situations tricky. We had two "fall through" comments in the code, but
> > > > at the wrong places.
> > > > 
> > > > Remove one unneeded comment (no annotations necessary between just empty
> > > > labels), and move one other instance to the right place (before any
> > > > label sequence).
> > > > This makes GCC's implicit fallthrough checker happy.
> > > > 
> > > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > > > Reviewed-by: Tom Rini <trini@konsulko.com>
> > > > ---
> > > >  net/net.c | 3 +--
> > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > > 
> > > > diff --git a/net/net.c b/net/net.c
> > > > index 5219367e391..f191f16357c 100644
> > > > --- a/net/net.c
> > > > +++ b/net/net.c
> > > > @@ -1525,7 +1525,6 @@ static int net_check_prereq(enum proto_t protocol)
> > > >  #if defined(CONFIG_CMD_NFS)
> > > >  	case NFS:
> > > >  #endif
> > > > -		/* Fall through */
> > > >  	case TFTPGET:
> > > >  	case TFTPPUT:
> > > >  		if (IS_ENABLED(CONFIG_IPV6) && use_ip6) {
> > > > @@ -1539,11 +1538,11 @@ static int net_check_prereq(enum proto_t protocol)
> > > >  			puts("*** ERROR: `serverip' not set\n");
> > > >  			return 1;
> > > >  		}
> > > > +		fallthrough;
> > > >  #if	defined(CONFIG_CMD_PING) || \
> > > >  	defined(CONFIG_CMD_DNS) || defined(CONFIG_PROT_UDP)
> > > >  common:
> > > >  #endif
> > > > -		/* Fall through */
> > > >  
> > > >  	case NETCONS:
> > > >  	case FASTBOOT_UDP:    
> > > 
> > > So this one is harder than it looks. With clang, we cannot seemingly
> > > have:
> > > 	fallthrough;
> > > #if defined(CONFIG_CMD_PING) || \
> > >     defined(CONFIG_CMD_DNS) || defined(CONFIG_PROT_UDP)
> > > common:
> > > #endif
> > > 
> > > And gcc was failing on:
> > > 	}
> > > #if defined(CONFIG_CMD_PING) || \
> > >     defined(CONFIG_CMD_DNS) || defined(CONFIG_PROT_UDP)
> > > common:
> > > #endif
> > > 	fallthrough;  
> > 
> > Yes, later stages of the CI told me so already ;-)
> >   
> > > Maybe we can move the label to inside the next set of cases, and then
> > > also add CONFIG_CMD_PING6 to the checks, as that also has 'goto common;'  
> > 
> > I found some other solution: dropping the #if's around the common:
> > label, then marking this with __maybe_unused instead. Seems to work for
> > both GCC and clang, and makes the code even more readable.
> > 
> > Will send this among the other gazillion fixes I meanwhile added in a
> > v2, to a mailbox near you.
> > If you can't wait: sunxi/fallthrough has the bits, though not yet split
> > up and without commit messages. Still not passing all checks, but the
> > CI builds seem to stop early, before revealing all issues, so this is a
> > piecemeal job :-(  
> 
> I thought I had tried what you suggest but maybe didn't quite get things
> aligned right (but I also modified sandbox so it would trigger the
> unused warning). That said, I'm applying most of v1 now'ish, and have
> only stopped as part of trying to narrow down the seemingly random
> evb-ast2600 CI failure.

Can you hold back with this patch here for now? I will send my new version
of this one later, which passes more CI. I didn't find more overlaps
between this and my new series, so I wonder if you could apply what you
think is ready from this one (definitely minus this patch, but maybe
others), and then I send another series with new fixes plus what's left
from this one. This would avoid me sending a v2 of this just because of
this one patch.

Cheers,
Andre
