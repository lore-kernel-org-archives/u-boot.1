Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CADDFB518C
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 09:26:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D71D28404A;
	Wed,  8 Apr 2026 11:26:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dyAE9PeO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19194838BB; Wed,  8 Apr 2026 11:26:57 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB41480433
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 11:26:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id EB512406A7;
 Wed,  8 Apr 2026 09:26:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9E6C19421;
 Wed,  8 Apr 2026 09:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775640412;
 bh=YNN4/WQS41Fb8TaewdbcwzipBsW21zeTkQgRPh7oDdY=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=dyAE9PeOqwiRysX/xhQW+SzUgkEtO1ttffDVesu7RHSMqAsFysN6QE1+PoyByM1L6
 dbK3vj2acUB2QTG0ztvL/9OzMQiMDlnvrUbtpBN3+Ci2t0CCmCoS3azKY2m95hIydR
 WTgRCFxC3z2n/jRjH/W4z+z5KoCbPPWrPdzYXSCIGWIopjUw9nHPy3eN82M7kZQIUl
 5PpvT4jLcdQhM/+zXXof2PXJ/Pm67B73ApbfTLoXuSU/XcObWpd89raDF+0Qy69SJK
 axihXWqmKpOh85j3Itu44g0rrmDt5keyCtnrD0PekUumRDcRO+Ga1IOn2lxon+Zm5F
 uqEhWGPtOB46w==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>
In-Reply-To: <20260323143253.2272167-1-trini@konsulko.com>
References: <20260317012433.4162524-1-trini@konsulko.com>
 <20260323143253.2272167-1-trini@konsulko.com>
Subject: Re: [PATCH v2] usb: gadget: Move USB_GADGET_DUALSPEED to be
 slightly more visible
Message-Id: <177564041013.8234.15223529346866045261.b4-ty@kernel.org>
Date: Wed, 08 Apr 2026 11:26:50 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

Hi,

On Mon, 23 Mar 2026 08:32:53 -0600, Tom Rini wrote:
> As exposed by "make randconfig", we have an issue around
> USB_GADGET_DUALSPEED. It is possible to select this symbol (via
> SPL_USB_CDNS3_GADGET for example) and so have an unmet dependency due to
> how this symbol is placed today. Move this to it's own section of the
> file guarded by USB_GADGET || SPL_USB_GADGET.
> 
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] usb: gadget: Move USB_GADGET_DUALSPEED to be slightly more visible
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/ace0e8034982fedb4ef75b8adcd97c1af063a990

--
Mattijs
