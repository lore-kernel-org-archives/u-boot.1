Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD98C3600C
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 09:07:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B549831BB;
	Tue,  8 Apr 2025 11:07:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="BLibudEp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE216831BE; Tue,  8 Apr 2025 11:06:58 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08E49830F4
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 11:06:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it
 [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 116C21F91A;
 Tue,  8 Apr 2025 11:06:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1744103215;
 bh=dUxnACPBTP3IW33p9vCi9Mty9TJnP1zblvqTEWJI5b4=;
 h=Received:From:To:Subject;
 b=BLibudEpD6mIfhgzGs15yQmXDezOZdY0ZpHh9lQHfMZBrDeqqw5dcLUja0PZAcM8s
 wwBqXbhq8VeyIrTp3oiy3nRDuhjgjx/3MbAPF4BosmBA6DJmJtwtt+Spy2XzhbHuQD
 8sqwmB4Zn/oL0RVlQwM/VsxCg+kQW7lM5+yCAWvhCcCxTEdH79q0cjNAE2no2Y9XgZ
 ne6oqZctmjgfKZAW17t70iUu2p60VD2L86Pv/o9It4GSn4/Ios5zfgdR21UetH/vas
 D5tqIXKAaiaRefObwVP+6V+E17gLBb1++BSNZKNsueMWuxHcYcQtOnaTEpYfgw1bO3
 kFCwDG3NK90jQ==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
 id 77DF37F8D5; Tue,  8 Apr 2025 11:06:54 +0200 (CEST)
Date: Tue, 8 Apr 2025 11:06:54 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Marek Vasut <marex@denx.de>
Cc: Francesco Dolcini <francesco@dolcini.it>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] usb: dwc3: gadget: Fix match_ep callback for NXP UUU tool
Message-ID: <Z_TnLsKHod_fvDsK@gaggiata.pivistrello.it>
References: <20250319220805.219001-1-marex@denx.de>
 <87a59gdofd.fsf@baylibre.com> <20250324080315.GA6932@francesco-nb>
 <87pli6esx0.fsf@baylibre.com>
 <Z-FQeVtIImeHsfXs@gaggiata.pivistrello.it>
 <42f53c19-de12-45c3-9091-2e6c23d1fcd4@denx.de>
 <Z-FpUV-fwGvch4-W@gaggiata.pivistrello.it>
 <48e57653-d86a-4650-859e-1e77a6c29f4a@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48e57653-d86a-4650-859e-1e77a6c29f4a@denx.de>
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

On Mon, Mar 24, 2025 at 03:36:52PM +0100, Marek Vasut wrote:
> On 3/24/25 3:16 PM, Francesco Dolcini wrote:
> > On Mon, Mar 24, 2025 at 02:53:23PM +0100, Marek Vasut wrote:
> > > On 3/24/25 1:30 PM, Francesco Dolcini wrote:
> > > > On Mon, Mar 24, 2025 at 09:26:03AM +0100, Mattijs Korpershoek wrote:
> > > > > Hi Francesco,
> > > > > 
> > > > > On lun., mars 24, 2025 at 09:03, Francesco Dolcini <francesco@dolcini.it> wrote:
> > > > > 
> > > > > > Hello Mattijs, Marek
> > > > > > 
> > > > > > On Thu, Mar 20, 2025 at 10:47:02AM +0100, Mattijs Korpershoek wrote:
> > > > > > > On mer., mars 19, 2025 at 23:07, Marek Vasut <marex@denx.de> wrote:
> > > > > > > 
> > > > > > > > The UUU tool excepts the interrupt-in endpoint to be ep1in, otherwise
> > > > > > > > it crashes. This is a result of the previous hard-coded EP setup in
> > > > > > > > drivers/usb/gadget/epautoconf.c which did special-case EP allocation
> > > > > > > > for SPL builds, and which was since converted to this callback, but
> > > > > > > > without the special-case EP allocation in SPL part.
> > > > > > > > 
> > > > > > > > This reinstates the SPL part in an isolated manner, only for NXP iMX
> > > > > > > > SoCs, only for SPL builds, and only for the ep1in interrupt-in endpoint.
> > > > > > 
> > > > > > UUU can (and in our case is) used also on non-NXP i.MX platforms.
> > > > > > What should we do?
> > > > > 
> > > > > Do reproduce the problem (UUU tool crashes) on those platforms with
> > > > > recent U-Boot versions (v2024.10+) ?
> > > > 
> > > > Not tested, my comment is purely based on the code and the commit message.
> > > > Older U-Boot versions (up to v2024.04, included) are working fine, with UUU used
> > > > with TI K3 SoCs (AM69, AM62, AM62P).
> > > Are you talking about the NXP UUU ?
> > 
> > yes, it works just fine on not-NXP SoC.
> Then please test if it still works, and if not, this patch needs to be
> expanded to cover TI ... or apply unconditionally in SPL (sigh).

I just found the time to check some logs from our CI in which we execute such a
workflow.  We do use UUU only from U-Boot proper, so we are not going to be
affected by this SPL specific change.

However I found this error in the logs, on both a TI AM62 and an i.MX8MP

```
Starting download of 40524455 bytes
dwc3-generic-peripheral usb@31000000: request 0000000099f219c0 was not queued to ep1in-bulk
..........................................................................
..........................................................................
..........................................................................
..........................................................................
.............
downloading of 40524455 bytes finished
dwc3-generic-peripheral usb@31000000: request 0000000099f219c0 was not queued to ep1in-bulk
dwc3-generic-peripheral usb@31000000: request 0000000099f219c0 was not queued to ep1in-bulk
Starting download of 1675 bytes
dwc3-generic-peripheral usb@31000000: request 0000000099f219c0 was not queued to ep1in-bulk
downloading of 1675 bytes finished
dwc3-generic-peripheral usb@31000000: request 0000000099f219c0 was not queued to ep1in-bulk
dwc3-generic-peripheral usb@31000000: request 0000000099f219c0 was not queued to ep1in-bulk
Starting download of 82 bytes
dwc3-generic-peripheral usb@31000000: request 0000000099f219c0 was not queued to ep1in-bulk
downloading of 82 bytes finished
dwc3-generic-peripheral usb@31000000: request 0000000099f219c0 was not queued to ep1in-bulk
dwc3-generic-peripheral usb@31000000: request 0000000099f219c0 was not queued to ep1in-bulk
```

the download is successful however, despite those error messages. Any idea? Is
this related to this topic?

Francesco


