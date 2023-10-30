Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FEFEC4167D
	for <u-boot@archiver.kernel.org>; Mon, 30 Oct 2023 15:35:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 425F18709A;
	Mon, 30 Oct 2023 16:35:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="LV7D/IWy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33DCF8709B; Mon, 30 Oct 2023 16:35:47 +0100 (CET)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk
 [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D06B98702F
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 16:35:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=armlinux.org.uk
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=linux+u-boot=lists.denx.de@armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WE1tsrC5nD1he3EQ3Z3HGaPKaykIF9HkdVI/EJRhi6c=; b=LV7D/IWyq2Mw7vTdVg1EkrxxC1
 fzJ5yRFzlAYj4fcJjzZtnGfpsXsCDVpO/UNR4YqP7qxjUUybZ7nZGyfZdxNL8kBxxQkTNHp25yUtf
 2KJzm3FlMnAL5p+Qfjj1+ikr/MrjmBoYN+ASKZakexZnFd/Jo54EhdMWhyKesftBsfU5qrKyX8seW
 2UDWVakMncsXCtbJFuOdiZGI2aEPV89Xh1oXklyVX3NGQmGLi6KaY+dx3jnwOaLBVjTYN0oid1QbQ
 0DQd3kQw+sLq/tI01uxlHkEV+3NVgkTq8vOAmgPzCLveX2HVgoTtA134mT1CT67pbwFxd0FsFsTiv
 mF5Xt6Vw==;
Received: from shell.armlinux.org.uk
 ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53860)
 by pandora.armlinux.org.uk with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <linux@armlinux.org.uk>) id 1qxUIh-0001q0-2T;
 Mon, 30 Oct 2023 15:35:35 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
 (envelope-from <linux@shell.armlinux.org.uk>)
 id 1qxUIg-00047C-OV; Mon, 30 Oct 2023 15:35:34 +0000
Date: Mon, 30 Oct 2023 15:35:34 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Simon Glass <sjg@chromium.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Nick Terrell <terrelln@fb.com>, Nicolas Schier <nicolas@fjasle.eu>,
 Will Deacon <will@kernel.org>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: boot: Support Flat Image Tree
Message-ID: <ZT/NRvLkvR8uuP5+@shell.armlinux.org.uk>
References: <20231026072628.4115527-1-sjg@chromium.org>
 <20231026072628.4115527-4-sjg@chromium.org>
 <CAK7LNASATGRaS-6QxzqTEq7qNVkZPXOBE8pfRBg=2bQGyy3=yw@mail.gmail.com>
 <CAFLszThguWT0u0R0EHfpBro0f-pWDwLOGk+5pQZEVhFYNKH8fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszThguWT0u0R0EHfpBro0f-pWDwLOGk+5pQZEVhFYNKH8fQ@mail.gmail.com>
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

On Sun, Oct 29, 2023 at 05:46:12AM +1300, Simon Glass wrote:
> Hi Masahiro,
> 
> Sure, but that is a separate issue, isn't it? We already support
> various boot targets in arm64 but not one that includes the DTs, so
> far as I can see. The old arm 'uImage' target is pretty out-of-date
> now.

Does that mean it can be removed? ;)

I've NAK'd FIT support on 32-bit Arm in the past, and I remain of the
opinion that boot loader specific packaging of the kernel should not
be in the kernel but should be external to it - even more so given the
multi-platform nature of 32-bit Arm kernels.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
