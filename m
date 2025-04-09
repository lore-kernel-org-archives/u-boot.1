Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4331DC36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 12:35:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FFC783721;
	Wed,  9 Apr 2025 14:35:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DLOsz35u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15C1E83726; Wed,  9 Apr 2025 14:35:15 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACAF9836EE
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 14:35:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 348BF429C9;
 Wed,  9 Apr 2025 12:35:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032AAC4CEE7;
 Wed,  9 Apr 2025 12:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744202110;
 bh=4kCTcjKoPU48o6q9kv7PBoUESJSDnW0Ftbscoa6LMQY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DLOsz35uAGBznyapMTcHRapmXUljQt0drurOgBRa7HJm+WZDGrMx4ZksVVKc/ObGG
 kZ6fpolRS1KQwJF7sdOAlM5piGuEj8vjS5j6IT7ohLTu+sMfzEdFwBIYgcbDMocxlU
 bxPqLMOWlyeva4+M3hYCeW7+oVUP6tfx0wvRgm1waf6Oc6ge3ehmKlk7Q+9ovznX5f
 dp/ubgiUZif1fXbjLOVLZvm35n9moA23PEglt0H1bpOArdcsDS10qnwobfNJar/Z0w
 7wzao8RLTF92ah+KHo53uXkJFa95bAXB3V0QjjoNCQG20EhudeVl9OHEEcMG7VGq+K
 45twqvoEgPHqQ==
Date: Wed, 9 Apr 2025 18:05:05 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de, neil.armstrong@linaro.org, trini@konsulko.com,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] arm: dts: Add override for RB1
Message-ID: <Z_ZpeSFEyJan2mZB@sumit-X1>
References: <20250407132810.35149-1-sumit.garg@kernel.org>
 <20250407132810.35149-2-sumit.garg@kernel.org>
 <baa7e896-a286-47ed-bd9a-18338978fc0d@linaro.org>
 <Z_UouNz11eRxIIa-@sumit-X1>
 <deb7ccd0-978b-4b97-bf67-de540dc02fe6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <deb7ccd0-978b-4b97-bf67-de540dc02fe6@linaro.org>
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

On Tue, Apr 08, 2025 at 04:43:49PM +0200, Caleb Connolly wrote:
> 
> 
> On 4/8/25 15:46, Sumit Garg wrote:
> > On Tue, Apr 08, 2025 at 02:17:29PM +0200, Caleb Connolly wrote:
> > > 
> > > 
> > > On 4/7/25 15:28, Sumit Garg wrote:
> > > > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > > > 
> > > > Add U-Boot override for RB1 to for USB in host mode as OTG mode isn't
> > > > supported. Also, disable sdhc_2 as it's currently not supported, sdhc_1
> > > > works fine though.
> > > > 
> > > > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > > > ---
> > > >    arch/arm/dts/qrb2210-rb1-u-boot.dtsi | 11 +++++++++++
> > > >    1 file changed, 11 insertions(+)
> > > >    create mode 100644 arch/arm/dts/qrb2210-rb1-u-boot.dtsi
> > > > 
> > > > diff --git a/arch/arm/dts/qrb2210-rb1-u-boot.dtsi b/arch/arm/dts/qrb2210-rb1-u-boot.dtsi
> > > > new file mode 100644
> > > > index 00000000000..1e136ee405a
> > > > --- /dev/null
> > > > +++ b/arch/arm/dts/qrb2210-rb1-u-boot.dtsi
> > > > @@ -0,0 +1,11 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +
> > > > +/* This is usually OTG but U-Boot doesn't support that properly */
> > > > +&usb_dwc3 {
> > > > +	dr_mode = "host";
> > > > +};
> > > > +
> > > > +/* SDHC_2 isn't supported in U-Boot as of now */
> > > 
> > > I'd rather avoid disabling this here, I guess it's just missing clocks and
> > > regulators which doesn't justify modifying DT. An error that mmc1 couldn't
> > > be enabled seems fine to me?
> > 
> > I totally echo with your thinking that we should avoid modifying DT but
> > at the same point we shouldn't enable peripherals in U-Boot which throws
> > errors. It's also possible that U-Boot misconfiguring mmc1 which might
> 
> I disagree, DT isn't enabling or disabling peripherals, it's describing
> hardware.

It would be helpful if you can describe the use-case for "status"
property then.

> U-Boot lacking proper support for that hardware isn't a good
> justification to disable it. Especially since you might boot Linux with the
> same DT and now have no working sdcard for seemingly no reason.

We shouldn't use same DT unless both U-Boot and Linux support that
without modifications and *not* being in a broken state. The similar argument
holds true for USB OTG mode too.

> 
> An error in U-Boot is exactly the behaviour we want to see, masking it only
> created confusion.> turn as a problem for later stages.

IMO, our first priority should be to fix U-Boot issues and then see if
we can use unmodified DT.

> > 
> > I have been totally working with a remote lab to fix issues on RB1. I
> > will soon get one on my desk then I will be able to fix mmc1 too.
> 
> In that case we can surely land the proper fixes for 2025.07 anyway, so I'd
> just keep the errors until then.

Fixing errors in mainline will help other people confidence who are
trying to boot U-Boot on RB1. If you still have a strong preference to
keep SD card support enabled in broken state then I can live with that
until I fix it for real.

-Sumit
