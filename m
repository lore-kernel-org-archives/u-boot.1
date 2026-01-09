Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C3B2D26D7A
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 17:49:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 926578436C;
	Fri,  9 Jan 2026 18:49:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="MgsAL8WY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 589F684379; Fri,  9 Jan 2026 18:49:16 +0100 (CET)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1FBD84206
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 18:49:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 816fa22b-ed83-11f0-8fef-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 816fa22b-ed83-11f0-8fef-005056999439;
 Fri, 09 Jan 2026 18:49:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=bw0SnJemN8vlRdVnFJHe940LY/ZQwWMmL8qdJw3GKeI=;
 b=MgsAL8WYHTzUiSyPt6OllR+IY0o90Qam/Uhv1ggAtMvnoBQ+UvKjsGLur4RNkc+CqxhBbovjoz3K5
 EVkISFCCtLQ9FuJnIw8XyFEMdpTERc+iqSOIgeJBQ5bcoRRm6L4NEnuX9Zwao/lyeTNf3V3V5BKkra
 U1h25fE1UQ2qnwrX6x0yZOjNiOKVv3BXGGQ1Rx60CC7LU6Tpbx6KZucrs0kiW2lO0Qe87KqWTZYzpd
 hi1nQqHag4i5ycYtJhd5sTmBuid5xOt+0RnTfEYyP6DdMTJpnaGxBQi3Hv9R/U0Jmh8xdaIHnHoECr
 An8C2iVOgueqeY14QfFSGWBSP/13Www==
X-KPN-MID: 33|VVDSZ+0jHKd1FmhjOV2xDnLeDasiUteuVbDNhk3T1sdD6bVgMng8jMvD++JkMEs
 5N2lxe2P+O3qMva5vIcjRQS0bsDIDEhFMC3dJA3TWTk4=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|gXdr302CMm4hyLOW8EnVueqrKBFT0CAPZXuiSZ9vTnZvf9DdkFdIv1aO5UVURTL
 Rt8pZ+Mxne0XmE4nPQdcSwQ==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 81a4ba5f-ed83-11f0-9bf7-00505699d6e5;
 Fri, 09 Jan 2026 18:49:12 +0100 (CET)
Date: Fri, 09 Jan 2026 18:49:11 +0100
Message-Id: <878qe6ad7s.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Tom Rini <trini@konsulko.com>
Cc: j@jannau.net, u-boot@lists.denx.de, kettenis@openbsd.org,
 asahi@lists.linux.dev
In-Reply-To: <20260109173351.GF3416603@bill-the-cat> (message from Tom Rini on
 Fri, 9 Jan 2026 11:33:51 -0600)
Subject: Re: [PATCH] configs: apple: Enable SMBIOS / sysinfo
References: <20260109-apple-defconfig-smbios-v1-1-16477009c034@jannau.net>
 <20260109173351.GF3416603@bill-the-cat>
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

> Date: Fri, 9 Jan 2026 11:33:51 -0600
> From: Tom Rini <trini@konsulko.com>
> 
> On Fri, Jan 09, 2026 at 06:20:30PM +0100, Janne Grunau wrote:
> 
> > Enable verbose SMBIOS table generation so that user space applications
> > can use the SMBIOS table to provide details about the system. The
> > desired information is chassis-type to determine whether the system is
> > laptop.
> > Adding the chassis-type property is proposed for the upstream device
> > trees in the Linux kernel in [1].
> > 
> > Link: https://lore.kernel.org/asahi/20260109-apple-dt-usb-c-atc-dwc3-v1-0-ce0e92c1a016@jannau.net/ [1]
> > Signed-off-by: Janne Grunau <j@jannau.net>
> 
> Reviewed-by: Tom Rini <trini@konsulko.com>
> 
> > ---
> > I do not plan to update u-boot's in-tree device trees. The Linux device
> > trees have almost reached feature parity. The main missing features are
> > the USB Type-C ports (on track for next merge window) and the laptop
> > keyboards. I think it makes more sense to close the feature gap and
> > switch to upstream device trees instead of adding to the in-tree device
> > trees.
> 
> This sounds like a good plan to me, thanks!

Yes, it is probably time to remove the in-tree device trees for these
devices.  They were never actually used in the build anyway.  Just
added because a maintainer insisted on having them in the tree.  But
now that we have the upstream device trees in the tree, the in-tree
ones can go.
