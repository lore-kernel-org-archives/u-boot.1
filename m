Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4230BEB8FAF
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 06:32:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A3C186611;
	Wed,  6 Sep 2023 08:32:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tinet.cat
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17C6586543; Wed,  6 Sep 2023 08:32:44 +0200 (CEST)
Received: from mx1.tinet.cat (smtp.altanet.org [195.76.233.59])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E66DD86672
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 08:32:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=tinet.cat
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xdrudis@tinet.cat
X-ASG-Debug-ID: 1693981957-12aaf213d6616910001-4l7tJC
Received: from smtp01.tinet.cat (smtp01.tinet.org [195.77.216.131]) by
 mx1.tinet.cat with ESMTP id NPFvBGEBMyrWTzAi;
 Wed, 06 Sep 2023 08:32:37 +0200 (CEST)
X-Barracuda-Envelope-From: xdrudis@tinet.cat
X-Barracuda-Effective-Source-IP: smtp01.tinet.org[195.77.216.131]
X-Barracuda-Apparent-Source-IP: 195.77.216.131
Received: from xdrudis.tinet.cat (42.red-79-152-186.dynamicip.rima-tde.net
 [79.152.186.42])
 by smtp01.tinet.cat (Postfix) with ESMTPSA id 3EBC2605D521;
 Wed,  6 Sep 2023 08:32:37 +0200 (CEST)
Date: Wed, 6 Sep 2023 08:32:26 +0200
From: Xavier Drudis Ferran <xdrudis@tinet.cat>
To: Sean Anderson <sean.anderson@seco.com>
Cc: Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
 Stefan Roese <sr@denx.de>, Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v5 05/11] spl: Convert mmc to spl_load
Message-ID: <ZPgcnA0XnGcDRs95@xdrudis.tinet.cat>
X-ASG-Orig-Subj: Re: [PATCH v5 05/11] spl: Convert mmc to spl_load
References: <20230731224304.111081-1-sean.anderson@seco.com>
 <20230731224304.111081-6-sean.anderson@seco.com>
 <ZMtl65DZ0NmO7pZO@xdrudis.tinet.cat>
 <4546689a-5b75-9ae3-3dd8-1a15bf896b5a@seco.com>
 <cb381ee1-fbbf-54b3-873a-d3003cc4b528@kwiboo.se>
 <ZPXUt17X/yGVme8+@xdrudis.tinet.cat>
 <0ca9f21a-5f22-4730-d17c-6f4a1feae737@seco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0ca9f21a-5f22-4730-d17c-6f4a1feae737@seco.com>
X-Barracuda-Connect: smtp01.tinet.org[195.77.216.131]
X-Barracuda-Start-Time: 1693981957
X-Barracuda-URL: https://webmail.tinet.cat:443/cgi-mod/mark.cgi
X-Barracuda-Scan-Msg-Size: 3112
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5015 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=6.0 KILL_LEVEL=8.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.113728
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
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

El Tue, Sep 05, 2023 at 11:02:44AM -0400, Sean Anderson deia:
> On 9/4/23 08:59, Xavier Drudis Ferran wrote:
> > El Sun, Sep 03, 2023 at 08:17:26AM +0000, Jonas Karlman deia:
> > 
> >> > Fundamentally, we can't really deal with unaligned images without a
> >> > bounce-buffer. The method used by SPL_LOAD_FIT_IMAGE_BUFFER_SIZE will
> >> > continue working, since we call into the FIT routines to load the image.
> > 
> > Yes
> > 
> >> > I would like to defer bounce buffering for other images until someone
> >> > actually needs it.
> >> >
> > 
> > Fine.
> > 
> >> > Note that in the FIT case, you can also do `mkimage -EB`, at least if
> >> > you aren't using FIT_LOAD_FULL.
> >> 
> >> With the following two commits introduced in v2023.04-rc1, the alignment
> >> issue for Rockchip has been fixed and all external data is now accessed
> >> block aligned.
> >> 
> >> 9b2fd2d22852 ("binman: Add support for align argument to mkimage tool")
> >> 5ad03fc77dfa ("rockchip: Align FIT image data to SD/MMC block length")
> >> 
> >> Regards,
> >> Jonas
> >>
> > 
> > Well, yes, thanks.
> > 
> > I was carrying Jerome's patch still thinking it was needed for me, but
> > I just tried without and it works too, in mmc. In spi I didn't try but
> > it should be even easier (bl_len=1).
> > 
> > For me it's still odd to write outside intended memory. Would a warning
> > in case legacy image loading writes before load_addr be acceptable ?
> > Just in case someone was using the memory there for something else.
> 
> We could add something, but it would have to be behind SHOW_ERRORS. This
> series is already having a very tough time reducing bloat without adding
> any (other) new features.
>

When I looked at it I thought the check and warning was only needed at
the end of spl_load, for legacy images. For fit it was already
aligned by calculating offset as a integer multiple of sectors.
I might misremember now.

In cases where the buffer is reserved it could just include the extra
bytes at the start before the load address, as I tried to suggest (v5
02/11), and then no warning is needed. Which is silly because the
spl_get_load_buffer doesn't do much at all. But someday it might do
more...

Your changes moves the extra bytes from the end to the start, and I
find it more unexpected than just having extra bytes at the end for an
image that might not have such a fixed length. I'd expect people to
leave room at the end when planning memory, thinking a future image
might be bigger, but not thinking to leave room at the start. But I'm
not all that sure...

If not a check and warning at least note something in documentation or
comments somewhere...

And I think you are really adding new features, in that even if the
formats and methods stay the same, there'll be more combinations
available after your change. So I'd be tolerant to a small code size
increase in exchange for the new flexibility. But I can understand
some cases can't afford the luxury, maybe.

Whatever you decide, looking forward to test a little your v6 if I can.
