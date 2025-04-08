Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A408C369A2
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 13:46:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0830182114;
	Tue,  8 Apr 2025 15:46:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="REdFldSU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9F038211F; Tue,  8 Apr 2025 15:46:42 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B0EE8210A
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 15:46:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0682E43F5B;
 Tue,  8 Apr 2025 13:46:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98188C4CEE7;
 Tue,  8 Apr 2025 13:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744119998;
 bh=erwJKBKiMyDNrQfdbvzK72Tvys66fTcD1/WzJp/btmI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=REdFldSUIrsTQdgM+ZWFk4Ti58cku8yh3CAauScM8VOtMOCXJyEPdrxGQxPEoYQ8T
 CVjz3u9BGgDdtZPPBcTyuRj3e/IQ/7RzHM0c4qRS2T8k0aN9ojPjujYk8L66+tkLaI
 VGClDDPUH5plK3lf3oRwKF5p/+nD964uCis4TMzYkDZQLKZZO1wTQ+8Ej22ntcuD/t
 5HKwOxm8sYrXr75TZzAwCpQ7d6jvwCZofBHVyvnBnfhU3Cuu34Jp3tRMKwpvuzD24a
 tjhwGpuRWxxVWAeWsWIcsVScVfzHeGykU/Qrxz3VncF+zyVN5r94Iu6VzrK6Nqwv4L
 pFxEVenLmx8Yg==
Date: Tue, 8 Apr 2025 19:16:32 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de, neil.armstrong@linaro.org, trini@konsulko.com,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] arm: dts: Add override for RB1
Message-ID: <Z_UouNz11eRxIIa-@sumit-X1>
References: <20250407132810.35149-1-sumit.garg@kernel.org>
 <20250407132810.35149-2-sumit.garg@kernel.org>
 <baa7e896-a286-47ed-bd9a-18338978fc0d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <baa7e896-a286-47ed-bd9a-18338978fc0d@linaro.org>
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

On Tue, Apr 08, 2025 at 02:17:29PM +0200, Caleb Connolly wrote:
> 
> 
> On 4/7/25 15:28, Sumit Garg wrote:
> > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > 
> > Add U-Boot override for RB1 to for USB in host mode as OTG mode isn't
> > supported. Also, disable sdhc_2 as it's currently not supported, sdhc_1
> > works fine though.
> > 
> > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > ---
> >   arch/arm/dts/qrb2210-rb1-u-boot.dtsi | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> >   create mode 100644 arch/arm/dts/qrb2210-rb1-u-boot.dtsi
> > 
> > diff --git a/arch/arm/dts/qrb2210-rb1-u-boot.dtsi b/arch/arm/dts/qrb2210-rb1-u-boot.dtsi
> > new file mode 100644
> > index 00000000000..1e136ee405a
> > --- /dev/null
> > +++ b/arch/arm/dts/qrb2210-rb1-u-boot.dtsi
> > @@ -0,0 +1,11 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/* This is usually OTG but U-Boot doesn't support that properly */
> > +&usb_dwc3 {
> > +	dr_mode = "host";
> > +};
> > +
> > +/* SDHC_2 isn't supported in U-Boot as of now */
> 
> I'd rather avoid disabling this here, I guess it's just missing clocks and
> regulators which doesn't justify modifying DT. An error that mmc1 couldn't
> be enabled seems fine to me?

I totally echo with your thinking that we should avoid modifying DT but
at the same point we shouldn't enable peripherals in U-Boot which throws
errors. It's also possible that U-Boot misconfiguring mmc1 which might
turn as a problem for later stages.

I have been totally working with a remote lab to fix issues on RB1. I
will soon get one on my desk then I will be able to fix mmc1 too.

-Sumit

> > +&sdhc_2 {
> > +	status = "disabled";
> > +};
> -- 
> Caleb (they/them)
> 
