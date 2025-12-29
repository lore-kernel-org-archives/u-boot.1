Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1130E8FDB1
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 04:17:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7D0983C67;
	Mon, 29 Dec 2025 05:17:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Vmz3wiWE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C9A783C72; Mon, 29 Dec 2025 05:16:59 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B73C283C39
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 05:16:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 920296000A;
 Mon, 29 Dec 2025 04:16:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E247C4CEF7;
 Mon, 29 Dec 2025 04:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1766981807;
 bh=OsfqkWorOn3j7wkrU/Z+0SLrfglhc/qwKMqocb8sAUs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Vmz3wiWEtaHXTmVfNPm4XLR+bzMwDgR/5VN5BE4R8tfps7j4GkNEI106ctXXP6vs7
 abAS++ppYCc9xQ3pvBLE1SmoD90n26JaS15c8e4YGC8Mkv6555o5X5t2DKYQRr+PO6
 csxQ+Lsr5q9EQBaTcIa41V8m+t42PCt0m3G7FpKHPho1G0P50r5PUuWT1T7HiW9yaV
 qs+nIrnNZvDMMKa39uFd1cxHfxPYGJoQ1FmRQyD2nSBItHNh2weLA8RzmxEG4u9QXZ
 27ePP6haNz7PuZt6oFvtaa9LQBe+ydOAvW7skwHkcnjRD/eMAKcPTUbA+/7Gu7Dxhh
 q/QB7yzdaUXkw==
Date: Mon, 29 Dec 2025 09:46:39 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Tom Rini <trini@konsulko.com>
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 ilias.apalodimas@linaro.org, christopher.obbard@linaro.org,
 quic_varada@quicinc.com, me@samcday.com,
 marek.vasut+renesas@mailbox.org, alexeymin@postmarketos.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/2] pinctrl: qcom: Make pinctrl drivers default y
Message-ID: <aVIAp2585U8DVEMV@sumit-xelite>
References: <20251222115144.2146964-1-aswin.murugan@oss.qualcomm.com>
 <aU5JPlsbh-ER7Den@sumit-xelite>
 <20251226145629.GC710860@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251226145629.GC710860@bill-the-cat>
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

On Fri, Dec 26, 2025 at 08:56:29AM -0600, Tom Rini wrote:
> On Fri, Dec 26, 2025 at 02:07:18PM +0530, Sumit Garg wrote:
> > On Mon, Dec 22, 2025 at 05:21:42PM +0530, Aswin Murugan wrote:
> > > This is a follow-up patch series to address review feedback on the
> > > QCS615 pinctrl driver addition:
> > > https://lore.kernel.org/u-boot/20251112164758.1560041-1-aswin.murugan@oss.qualcomm.com/
> > > 
> > > During review, it was suggested that since all Qualcomm pinctrl
> > > drivers are already within a menu conditional on ARCH_SNAPDRAGON ||
> > > ARCH_IPQ40XX, they should be made default y based on the appropriate
> > > architecture rather than requiring manual enablement in defconfig
> > > files.
> > > 
> > > This series implements that suggestion by:
> > > 1. Adding 'default y if ARCH_SNAPDRAGON' to all Snapdragon pinctrl
> > >    drivers and 'default y if ARCH_IPQ40XX' to all IPQ pinctrl
> > >    drivers in the Kconfig
> > 
> > I see the usefullness of this feature but in turn it will limit the
> > capability to reduce U-Boot size to an essential minimum. In scenarios
> > where there are contraints on flash size or on-chip RAM for U-Boot SPL.
> > I would rather favour something like following like:
> > 
> > 'default y if PINCTRL_QCOM_GENERIC'
> > 
> > where PINCTRL_QCOM_GENERIC can be enabled from generic Qcom defconfig.
> 
> If something is merely "default y" it can still be easily turned off.

Yeah true but then again in say any SPL defconfig every config option
needs to be turned off which is a similar thing you want to avoid now.

> If
> we want to make the "if ..." part more precise, OK.

Exactly, lets do it properly.

> But I don't want to
> go back to (nearly?) every snapdragon and ipq40xx defconfig being
> modified, as it was in an earlier iteration.

Sure, we don't want to go back but extend your suggestion with
PINCTRL_QCOM_GENERIC.

-Sumit
