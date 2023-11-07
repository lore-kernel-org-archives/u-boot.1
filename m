Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5207C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 08:49:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D9B687001;
	Tue,  7 Nov 2023 09:49:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tinet.cat
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1710886F71; Tue,  7 Nov 2023 09:49:25 +0100 (CET)
Received: from mx1.tinet.cat (mx1.tinet.org [195.77.216.146])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44EEB87001
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 09:49:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=tinet.cat
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xdrudis@tinet.cat
X-ASG-Debug-ID: 1699346959-163e7b5e159a82b0001-4l7tJC
Received: from smtp01.tinet.cat (smtp01.tinet.cat [195.77.216.131]) by
 mx1.tinet.cat with ESMTP id Dhlnv4yJF6npDq4g;
 Tue, 07 Nov 2023 09:49:19 +0100 (CET)
X-Barracuda-Envelope-From: xdrudis@tinet.cat
X-Barracuda-Effective-Source-IP: smtp01.tinet.cat[195.77.216.131]
X-Barracuda-Apparent-Source-IP: 195.77.216.131
Received: from xdrudis.tinet.cat (191.red-79-152-186.dynamicip.rima-tde.net
 [79.152.186.191])
 by smtp01.tinet.cat (Postfix) with ESMTPSA id 75720605DE48;
 Tue,  7 Nov 2023 09:49:19 +0100 (CET)
Date: Tue, 7 Nov 2023 09:49:06 +0100
From: Xavier Drudis Ferran <xdrudis@tinet.cat>
To: Sean Anderson <seanga2@gmail.com>
Cc: Xavier Drudis Ferran <xdrudis@tinet.cat>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
 Marek Vasut <marex@denx.de>, Stefan Roese <sr@denx.de>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>,
 uboot-imx@nxp.com
Subject: Re: [PATCH v6 08/25] spl: Refactor spl_load_info->read to use units
 of bytes
Message-ID: <ZUn577z8xINpURlO@xdrudis.tinet.cat>
X-ASG-Orig-Subj: Re: [PATCH v6 08/25] spl: Refactor spl_load_info->read to use
 units of bytes
References: <20231106022603.3405551-1-seanga2@gmail.com>
 <20231106022603.3405551-9-seanga2@gmail.com>
 <ZUjdhAccsYbJS6AL@xdrudis.tinet.cat>
 <f546ba08-10b9-0cb4-4fa7-f7541dab1288@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f546ba08-10b9-0cb4-4fa7-f7541dab1288@gmail.com>
X-Barracuda-Connect: smtp01.tinet.cat[195.77.216.131]
X-Barracuda-Start-Time: 1699346959
X-Barracuda-URL: https://webmail.tinet.cat:443/cgi-mod/mark.cgi
X-Barracuda-Scan-Msg-Size: 2098
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.4994 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=6.0 KILL_LEVEL=8.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.116416
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

El Mon, Nov 06, 2023 at 08:54:03AM -0500, Sean Anderson deia:
> On 11/6/23 07:35, Xavier Drudis Ferran wrote:
> > Thanks for your work. I'm still reading... but...
> > 
> > 
> > El Sun, Nov 05, 2023 at 09:25:46PM -0500, Sean Anderson deia:
> > > diff --git a/include/spl.h b/include/spl.h
> > > index 951e136b9ea..ecfc50e0095 100644
> > > --- a/include/spl.h
> > > +++ b/include/spl.h
> > > @@ -297,10 +297,10 @@ struct spl_load_info {
> > >   	 * read() - Read from device
> > >   	 *
> > >   	 * @load: Information about the load state
> > > -	 * @sector: Sector number to read from (each @load->bl_len bytes)
> > > -	 * @count: Number of sectors to read
> > > +	 * @offset: Offset to read from in bytes, in multiples of @load->bl_len
> > > +	 * @count: Number of bytes to read, in multiples of @load->bl_len
> > 
> > I'm no native English speaker, but would it be easier to understand? :
> > 
> > +	 * @offset: Offset to read from in bytes, a multiple of @load->bl_len
> > +	 * @count: Number of bytes to read, a multiple of @load->bl_len
> > 
> > 
> > 
> 
> I think it would have to be worded
> 
> @offset: Offset to read from in bytes, as a multiple of @load->bl_len
> 
> but to me these both mean the same thing.
> 
> --Sean

Ah, OK. I doubted on whether it should be a comma or "as". Apparently
it was both.

They may mean the same, but I got confused by having "in bytes", and
"in multiples" so close.

"in bytes" means the value should be the correct answer to the
question "how many bytes" (not a number of bits, not a number of
sectors)

but "in multiples of..." doesn't mean the value should be the correct
answer to "how many of multiples". Should the value be a number of
sectors (first multiple of bl_len) a number of dozens of sectors
(another multiple of bl_len) or ...?

In the first part "in" introduces a unit of measure, but in the second
the same word introduces a constraint on a value. That was confusing
to me.

Not saying it doesn't mean the same or even that you should change it,
just elaborating why I said it.

