Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30DBBCC6B33
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 13:15:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C885760A99;
	Thu, 15 Oct 2026 13:14:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pd2uwdklt8YM; Thu, 15 Oct 2026 13:14:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 940F9608ED
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792070096;
	b=eHjaEuiJ/MvPH5j8cnblNkGzb6Usm5TW4V9jk0RxTIcoFRh0kI7FKoQmMz16IOUoUBtb
	 9/IjH895o2+6BzK96GgepgHOMK07k5bPY0fd4WdeOcsEL7heGKiGo/z/dJYzsEjEd1050
	 C3JOM5xG11utHHPj9742odlKjLY4vnCJew89RN5XsiGomoOfcyOsTb/yA+ylKBuvczMbm
	 oJQC7UTqFpRJ9ZAwOmW878nq2V0RwdsOIjyRAZpI6oXSN5EjrnA+/0xRFBjN3UdStxF+p
	 JaEXKIN3o4Ra7LeX5Xf1negBKlAEKrl9DjtNskJ6YwSgZ3XSRBmeO+4rCqCKbqcs4tw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792070096;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-Debian-User:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xrDMSt78qYu4nh8SBVnPte6zV/k7eXurRbYjm4OpsOM=;
	b=UA34uojWVrDUAIvRJ4IwwTByOO22lePpaiLU5lDX5blFrD/pWsMk0jY/G5NEbwHDODOu
	 9o3ALLNacdWqZQTRLahjBAva3554pDUk3GKCqwL4HN9Qbii0Sl+hYG1l9JWOCGdW5N4Ks
	 BpP748ihDEdpjT0gXhtbD1J0c3Xs+Ih2A1B7yqkMAOQDvKNcj676CQIk0sKdmV8QtstcE
	 FXJOrmk6r7NtKYa8OrjOc6nFpk/QbHgnT1u2A7JS0Lf/Anvjb9omWb6ryq++CLvAxq07D
	 SpMXQvn72+Y+hqdHFL+YpHkSprXyXyMBbV1R0TCUDD5uQI14CNqbQeb6a9isjHRI7GQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=none header.from=fatal.se;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792070095;
	bh=xrDMSt78qYu4nh8SBVnPte6zV/k7eXurRbYjm4OpsOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sPeN7jKlFLH6BrbTpjTmeDAj5dCIWf6mnx+r8D6gCNjwcrxqL70jJyfgAF/turE2l
	 zDqlGdo6WyvMhQko08JJD4UkcZy+tsUwM4K4adIHc9dMpZg3mg97IIEhYeF3ohB5Kx
	 6DBykOoUgh2aqOUO/Q9CIVggfc9H1Gf9OG6CRAdLAhP98FwwJKFAhrSbjs/YllgrYK
	 TlU3EdUTZHpw24q5qv1UjfIJ4afCfSj3IrSZYC8uXBXpe+QBttsqIjzr//oxVHyMUB
	 Y8Z6Hwawbwks82sOu62pO8FrR/dUkzFkVjkVmFluCUe13KRfjoE0+iuYI1R0l7xXOe
	 g4wHJudiSu3eQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 940F9608ED;
	Thu, 15 Oct 2026 13:14:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1E1011DE
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 09:48:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0401160767
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 09:48:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MaWGIaNerRIR for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 09:48:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A58CD606C2
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:41b8:202:deb::311:108"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792057718;
 b=o7UO2Tm7wqGBMM8rM4g8D3qZY8P2OiOrNqeXRL2m7Y7t+KXe0hdGMdKf6PqG7Rps4tb/
 V45TXBlvc+wzCDeBTLOID7OGZ9vsZ842OcVELGMM7V3U723FlT5BcGIfTF57Y7aYTM3/j
 FW8rkDCeaMs15mQ9dWBMqvA+QcftGhXxDmQDRCPEmQbdT8gAjkurzp17vw4hRjjj42za7
 dyBd4uj/pyq+av4Y3BafWlLKW4xNup3bfWyDX8wwG+rLlxkJwzRtOP9ewgwXyKrdWe1lc
 3XMkbfJXPv1a5Rqj7lxUdP05plufA4s283GxY72ZGivhndfjfz+vUJbNMRO9beRB7IA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792057718;
 h=Received-SPF:Received:Received:Date:From:To:Cc:Subject:Message-ID:
 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
 X-Debian-User;
 bh=xrDMSt78qYu4nh8SBVnPte6zV/k7eXurRbYjm4OpsOM=;
 b=PQMYiQZ5wCi1A259dqyL4/gBC3QqbNqvcUuIGHl1EUkYHnIe31pn3UhOV9EGkOR91nfR
 UKhgyREIT5mQNlzUtE6QuyTtJuAwu6I3VL1FtUgzapjjnzOjKt6RE5PByuFkbTJrf5GVx
 Q6mGlCpfeSCSzR96/a6JGx1hTnTb14SelA+uqZ01JA3zAc+CMl9Gj6du070uMwLoLrSlF
 AmF9SfB7YuDaU8k+10YEZi/NdYo0IN9ftxgw2zABIoBnKHdy9dgAjMA0ZQTsEvm8ZN2lt
 ZGAjC+mGb5iDpJr90kjM4uBT3LpaiuY1lTPJMjEp+4L2q3d/iHUH91OB9iEhTMelWrw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=fatal.se;
 arc=none smtp.remote-ip="2001:41b8:202:deb::311:108"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:41b8:202:deb::311:108; helo=stravinsky.debian.org;
 envelope-from=andreas@fatal.se; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=fatal.se
Received: from stravinsky.debian.org (stravinsky.debian.org
 [IPv6:2001:41b8:202:deb::311:108])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A58CD606C2
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 09:48:36 +0000 (UTC)
Received: from authenticated-user by stravinsky.debian.org with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.96) (envelope-from <andreas@fatal.se>) id 1xHI4b-0056PG-26;
 Thu, 15 Oct 2026 09:48:30 +0000
Received: from m1pro (unknown [IPv6:2a07:5cc0:4750:8a00:ca89:f3ff:febd:8b38])
 by pi.fatal.se (Postfix) with ESMTPSA id E71D188;
 Thu, 15 Oct 2026 09:48:26 +0000 (UTC)
Date: Thu, 15 Oct 2026 11:48:23 +0200
From: Andreas Henriksson <andreas@fatal.se>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, 
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] lmb: enable LMB_LIMIT_DMA_BELOW_RAM_TOP for ARCH_IMX8M
Message-ID: <lpxlj4vic6nwfbwhldqr3c5gugdk7txqya5tt2iroy6xsqznjf@onabit7gtng7>
References: <6hnbarafo7qy56l23qwzcbzfm7v5liabgpnd6t5i5sbinmxqhs@6aggwhpwx5cy>
 <20261014174957.GA152546@bill-the-cat>
 <vheanflup2men4bi5bmhm67pxdk5kq54hzgc6dxtfx6aw2lbog@ahynysqlf55g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vheanflup2men4bi5bmhm67pxdk5kq54hzgc6dxtfx6aw2lbog@ahynysqlf55g>
X-Debian-User: ah
X-Mailman-Approved-At: Thu, 15 Oct 2026 13:14:48 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Wed, Oct 14, 2026 at 10:38:12PM +0200, Andreas Henriksson wrote:
> On Wed, Oct 14, 2026 at 11:49:57AM -0600, Tom Rini wrote:
> > On Wed, Oct 14, 2026 at 09:46:44AM +0200, Andreas Henriksson wrote:
> > > On boards with >3GiB ram, we can end up with transfers above 4GiB
> > > which is not allowed by SDHC driver.
> > > 
> > > fsl_esdhc_imx.c: esdhc_setup_dma():
> > > 	if (upper_32_bits(priv->dma_addr))
> > > 		printf("Cannot use 64 bit addresses with SDMA\n");
> > > 
> > > Tested on Toradex Verdin i.MX8M Plus SoM, where bootefi would not work
> > > (with systemd-boot as efi application) and print the above message.
> > 
> > Is this a driver limitation which should be fixed, or a hardware
> > limitation that needs to be enforced by this Kconfig option?
> 
> As far as I understand it, this is a limitation in the (S)DMA design
> of the SoC.

See also commit e27bddff4b97598baaa7186196ebfb28075f702c which contains:

    /*
     * Some IPs have their accessible address space restricted by
     * the interconnect. Let's make sure U-Boot only ever uses the
     * space below the 4G address boundary (which is 3GiB big),
     * even when the effective available memory is bigger.
     */

(This is only in arch/arm/mach-imx/imx8m/soc.c and none of the
other arch/arm/mach-imx/imx*/soc.c has the board_get_usable_ram_top
function.)

Regards,
Andreas Henriksson

https://git.u-boot-project.org/u-boot/u-boot/-/commit/e27bddff4b97598baaa7186196ebfb28075f702c
