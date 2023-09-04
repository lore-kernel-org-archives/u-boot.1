Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB3FC71153
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 12:48:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B18E686517;
	Mon,  4 Sep 2023 14:48:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tinet.cat
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E02086453; Mon,  4 Sep 2023 14:48:43 +0200 (CEST)
Received: from mx1.tinet.cat (mx1.tinet.org [195.77.216.146])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D54E867C3
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 14:48:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=tinet.cat
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xdrudis@tinet.cat
X-ASG-Debug-ID: 1693831717-163e7b47e046ee50001-4l7tJC
Received: from smtp01.tinet.cat (smtp01.tinet.org [195.77.216.131]) by
 mx1.tinet.cat with ESMTP id Kv5cbQ4KDN97gTlc;
 Mon, 04 Sep 2023 14:48:37 +0200 (CEST)
X-Barracuda-Envelope-From: xdrudis@tinet.cat
X-Barracuda-Effective-Source-IP: smtp01.tinet.org[195.77.216.131]
X-Barracuda-Apparent-Source-IP: 195.77.216.131
Received: from xdrudis.tinet.cat (42.red-79-152-186.dynamicip.rima-tde.net
 [79.152.186.42])
 by smtp01.tinet.cat (Postfix) with ESMTPSA id 948FD605D080;
 Mon,  4 Sep 2023 14:48:37 +0200 (CEST)
Date: Mon, 4 Sep 2023 14:48:26 +0200
From: Xavier Drudis Ferran <xdrudis@tinet.cat>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: Xavier Drudis Ferran <xdrudis@tinet.cat>, u-boot@lists.denx.de,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Marek Vasut <marex@denx.de>, Kever Yang <kever.yang@rock-chips.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] usb: host: ohci-generic: Make usage of clock/reset
 bulk() API
Message-ID: <ZPXSGkf+vdXlIbVq@xdrudis.tinet.cat>
X-ASG-Orig-Subj: Re: [PATCH] usb: host: ohci-generic: Make usage of clock/reset
 bulk() API
References: <20230830080150.473374-1-fabrice.gasnier@foss.st.com>
 <ZPL7DAQfE3WxCFa+@xdrudis.tinet.cat>
 <428ea549-1092-fb39-15e1-10f2284691e8@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <428ea549-1092-fb39-15e1-10f2284691e8@foss.st.com>
X-Barracuda-Connect: smtp01.tinet.org[195.77.216.131]
X-Barracuda-Start-Time: 1693831717
X-Barracuda-URL: https://webmail.tinet.cat:443/cgi-mod/mark.cgi
X-Barracuda-Scan-Msg-Size: 4602
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.8822 1.0000 3.0378
X-Barracuda-Spam-Score: 3.64
X-Barracuda-Spam-Status: No, SCORE=3.64 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=6.0 KILL_LEVEL=8.0 tests=MARKETING_SUBJECT
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.113652
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
 0.60 MARKETING_SUBJECT      Subject contains popular marketing words
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

El Mon, Sep 04, 2023 at 11:25:06AM +0200, Fabrice Gasnier deia:
> 
> IMHO, the OHCI should have failed too in this example, instead of
> silently ignoring the error. Hopefully it has probed.
>
> The clk_get_bulk() code does a similar job compared to ohci current
> code. It counts all clock entries. So, when trying to get them, these
> should be found.
> 
> Having a clock listed, but it can't be found or taken rather looks like
> a real error, that needs to be fixed.
> (e.g. missing config for a clk/reset controller ? Or could it be a bug
> in such a driver ? Or a miss-configured device-tree ? something else?)
> Ignoring such error may be miss-leading (as you pointed out, one was
> working).
> 
> I hope I don't miss your point. If this is the case, could you point
> more precise example, or how it used to fail ?
>

No, you don't miss my point. I'll give you pointers to the case I
meant, but I'm afraid it might mislead, because it's already solved,
and for current U-Boot it should pose no problem with or without your
patch.

The general problem might be that dts come from linux, and the drivers
come from U-Boot, so U-Boot might ignore some hardware described in
the linux dts that it doesn't need. Now this is more typical for, say,
a VPU than a clock or reset. But it once was a missing clock driver in
U-Boot that linux used for suspend/resume and happened to be at the
end of the clock list. So it worked when ohci probe ignored the missing
clock, because U-Boot doesn't need suspend, but it didn't work for ehci
that called clk_get_bulk().

There might be other cases like that example somewhere, but I'm not
saying it's likely. I guess we'll know if some board breaks.


If you really want the gory details...

https://patchwork.ozlabs.org/project/uboot/patch/20220701185959.GC1700@begut/
https://patchwork.ozlabs.org/project/uboot/patch/Y44+ayJfUlI08ptM@localhost/
https://patchwork.ozlabs.org/project/uboot/patch/Y5IWpjYLB4aXMy9o@localhost/
https://lists.denx.de/pipermail/u-boot/2022-December/501811.html
https://lists.denx.de/pipermail/u-boot/2023-February/510676.html
https://lists.denx.de/pipermail/u-boot/2023-February/510678.html
https://patchwork.ozlabs.org/project/uboot/patch/202013db5a47ecbac4a53c360ed1ca91ca663996.1685974993.git.xdrudis@tinet.cat/
https://patchwork.ozlabs.org/project/uboot/patch/464111fca83008503022e8ada5305e69ffd1afbd.1685974993.git.xdrudis@tinet.cat/


> > In that case, a fix by ignoring the missing clock
> > in ehci was rejected, so maybe that criteria applies here as well and
> > your patch is deemed correct. I don't know. That case won't break now,
> > I think, either with or without your patch, because after another fix,
> > that clock will be found.
> 
> If I understand correctly, this used to fixed elsewhere (e.g. there used
> to be a real bug fixed) ?
>

Yes. See above. Or don't, it's not that important.
A clock driver was missing, only needed for suspend/resume.
ohci ignored it and worked (U-Boot doesn't suspend)
ehci failed probing and dind't work.
Current situation is this particular clock driver is no longer missing.

> > But I don't know if there might be similar
> > cases.
> > 
> > I just wanted to point out the change in behaviour. If the change is
> > intended, then all is fine.
> 
> IMHO, this should be fine. I hope you agree with this change and the
> rationale.
>

I do.

I just wanted to point it out in case anyone knew why ohci wasn't
calling clk_get_bulk(). It might have been on purpose.

In fact Kever Yang once proposed to change ehci to be tolerant to a
missing clock like ohci was (but with an explicit warning). But Marek
Vasut proposed adding a clock driver and Kever didn't complain, so I
don't think this is his very strong opinion, he may just be happy when
things work and others are happy, I can't read minds.

https://lists.denx.de/pipermail/u-boot/2022-December/501811.html

FWIW

ohci_probe introduced:
fee331f66c9 (Alexey Brodkin   2015-12-14 17:18:50 +0300 

loop for clocks introduced in ohci_probe:
155d9f65d3b (Patrice Chotard  2017-07-18 11:57:12 +0200 

clk_get_bulk introduced:
a855be87da4 (Neil Armstrong      2018-04-03 11:44:18 +0200 156)

So ochi_probe() didn't call clk_get_bulk() most likely because it
din't exist back then.

So, unless someone else has a failing case, I agree to your change.

I'd welcome if the commit message would say that the new policy is any
missing clocks or resets cause the probe to fail. But since you
already sent v2, it doesn't matter.

