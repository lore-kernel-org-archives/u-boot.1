Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 846CAC83F33
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 12:59:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7B2C86611;
	Mon,  4 Sep 2023 14:59:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tinet.cat
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B13786915; Mon,  4 Sep 2023 14:59:40 +0200 (CEST)
Received: from mx1.tinet.cat (smtp.altanet.org [195.76.233.59])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4F0C864D8
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 14:59:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=tinet.cat
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xdrudis@tinet.cat
X-ASG-Debug-ID: 1693832376-12aaf213d5509ac0001-4l7tJC
Received: from smtp01.tinet.cat (smtp.tinet.org [195.77.216.131]) by
 mx1.tinet.cat with ESMTP id V5H77nAsCnbEyfew;
 Mon, 04 Sep 2023 14:59:36 +0200 (CEST)
X-Barracuda-Envelope-From: xdrudis@tinet.cat
X-Barracuda-Effective-Source-IP: smtp.tinet.org[195.77.216.131]
X-Barracuda-Apparent-Source-IP: 195.77.216.131
Received: from xdrudis.tinet.cat (42.red-79-152-186.dynamicip.rima-tde.net
 [79.152.186.42])
 by smtp01.tinet.cat (Postfix) with ESMTPSA id 4F719605D080;
 Mon,  4 Sep 2023 14:59:36 +0200 (CEST)
Date: Mon, 4 Sep 2023 14:59:35 +0200
From: Xavier Drudis Ferran <xdrudis@tinet.cat>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Sean Anderson <sean.anderson@seco.com>,
 Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, Stefan Roese <sr@denx.de>,
 Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v5 05/11] spl: Convert mmc to spl_load
Message-ID: <ZPXUt17X/yGVme8+@xdrudis.tinet.cat>
X-ASG-Orig-Subj: Re: [PATCH v5 05/11] spl: Convert mmc to spl_load
References: <20230731224304.111081-1-sean.anderson@seco.com>
 <20230731224304.111081-6-sean.anderson@seco.com>
 <ZMtl65DZ0NmO7pZO@xdrudis.tinet.cat>
 <4546689a-5b75-9ae3-3dd8-1a15bf896b5a@seco.com>
 <cb381ee1-fbbf-54b3-873a-d3003cc4b528@kwiboo.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cb381ee1-fbbf-54b3-873a-d3003cc4b528@kwiboo.se>
X-Barracuda-Connect: smtp.tinet.org[195.77.216.131]
X-Barracuda-Start-Time: 1693832376
X-Barracuda-URL: https://webmail.tinet.cat:443/cgi-mod/mark.cgi
X-Barracuda-Scan-Msg-Size: 1311
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5000 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=6.0 KILL_LEVEL=8.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.113652
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

El Sun, Sep 03, 2023 at 08:17:26AM +0000, Jonas Karlman deia:

> > Fundamentally, we can't really deal with unaligned images without a
> > bounce-buffer. The method used by SPL_LOAD_FIT_IMAGE_BUFFER_SIZE will
> > continue working, since we call into the FIT routines to load the image.

Yes

> > I would like to defer bounce buffering for other images until someone
> > actually needs it.
> >

Fine.

> > Note that in the FIT case, you can also do `mkimage -EB`, at least if
> > you aren't using FIT_LOAD_FULL.
> 
> With the following two commits introduced in v2023.04-rc1, the alignment
> issue for Rockchip has been fixed and all external data is now accessed
> block aligned.
> 
> 9b2fd2d22852 ("binman: Add support for align argument to mkimage tool")
> 5ad03fc77dfa ("rockchip: Align FIT image data to SD/MMC block length")
> 
> Regards,
> Jonas
>

Well, yes, thanks.

I was carrying Jerome's patch still thinking it was needed for me, but
I just tried without and it works too, in mmc. In spi I didn't try but
it should be even easier (bl_len=1).

For me it's still odd to write outside intended memory. Would a warning
in case legacy image loading writes before load_addr be acceptable ?
Just in case someone was using the memory there for something else.





