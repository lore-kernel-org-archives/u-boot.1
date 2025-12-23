Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53FF6E6F06C
	for <u-boot@archiver.kernel.org>; Tue, 23 Dec 2025 08:27:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B5E183EDF;
	Tue, 23 Dec 2025 09:27:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ajE+RAia";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0356883EE2; Tue, 23 Dec 2025 09:27:17 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD23983C28
 for <u-boot@lists.denx.de>; Tue, 23 Dec 2025 09:27:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 88A9B60120;
 Tue, 23 Dec 2025 08:27:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57ADBC113D0;
 Tue, 23 Dec 2025 08:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1766478433;
 bh=uERFqd0IWwrKEbnnF83IYhGXcYlMRuGenHvdNfVTnnI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ajE+RAiatk0SEKx3VSfAamDew0/Im6KWoYqmA2yHRcZq9oPsQWaVt9i+Jz1btPjxT
 RHCUD4rh7GgLJpdARFSJ/gt1MpIpxbjTWTH7X7k3lli6+ZoeWOJGRWB0pINTJP8LH0
 HF3UZ8jhyyA4UASNP6Cer/J57xBt9QjZUMCSekDjzFTtMasupy478S+xHgH5eKw7Io
 mzyYyMWhtEfOGistztq/BqopIjDKaAsN28pwBsi9YHGTl++Nf4skhnAJf/uG/1EKmY
 ftPxKxE0Rx7Ix5MJp3dv7klGzGSeZa+x5JN3uIWoICLbg0/0UQohMHcUS4FDMrFJCy
 z4vosVe2qnBHg==
Date: Tue, 23 Dec 2025 13:57:03 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, marek.vasut+renesas@mailbox.org,
 michal.simek@amd.com, alexeymin@postmarketos.org,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [RESEND v2 6/6] doc: board/qualcomm: Update RDP flashing
 instructions
Message-ID: <aUpSVyZoHOsAcJ64@sumit-xelite>
References: <20251218061557.1999367-1-varadarajan.narayanan@oss.qualcomm.com>
 <20251218061557.1999367-7-varadarajan.narayanan@oss.qualcomm.com>
 <aUVkq7zt5PG7nZZo@sumit-xelite>
 <aUokgCzdxE8jSED2@hu-varada-blr.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUokgCzdxE8jSED2@hu-varada-blr.qualcomm.com>
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

On Tue, Dec 23, 2025 at 10:41:28AM +0530, Varadarajan Narayanan wrote:
> On Fri, Dec 19, 2025 at 08:13:55PM +0530, Sumit Garg wrote:
> > On Thu, Dec 18, 2025 at 11:45:57AM +0530, Varadarajan Narayanan wrote:
> > > Update the flashing instructions to include fastboot.
> > >
> > > Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> > > ---
> > >  doc/board/qualcomm/rdp.rst | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > >
> > > diff --git a/doc/board/qualcomm/rdp.rst b/doc/board/qualcomm/rdp.rst
> > > index 99cf8eba57c..97a64e4677c 100644
> > > --- a/doc/board/qualcomm/rdp.rst
> > > +++ b/doc/board/qualcomm/rdp.rst
> > > @@ -42,6 +42,20 @@ on your device with::
> > >
> > >  U-Boot should be running after a reboot (``reset``).
> > >
> > > +This U-Boot doesn't have the n/w driver.
> >
> > Can you expand a bit on "n/w driver" a bit?
> 
> This board is capable of network connectivity over ethernet. However,
> the relevant network driver is not available yet for U-Boot. Hence,
> trying to enable fastboot to update firmware.

Let's add that information to the doc instead. Using random accronyms
should be avoided in the docs.

-Sumit

> 
> -Varada
> 
> > > To restore the original U-Boot or flash
> > > +modified versions of the above built U-Boot, 'fastboot' can be used.
> > > +
> > > +  => setenv serial# ipq9574
> > > +  => fastboot usb 0
> > > +
> > > +  C:\>.\fastboot.exe devices
> > > +  ipq9574  fastboot
> > > +
> > > +  C:\>.\fastboot flash 0:APPSBL u-boot.mbn
> > > +  Sending '0:APPSBL' (620 KB)                        OKAY [  0.042s]
> > > +  Writing '0:APPSBL'                                 OKAY [  0.030s]
> > > +  Finished. Total time: 0.342s
> > > +
> > >  .. WARNING
> > >  	Boards with newer software versions would automatically go the emergency
> > >  	download (EDL) mode if U-Boot is not functioning as expected. If its a
> > > --
> > > 2.34.1
> > >
