Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11857C61D85
	for <u-boot@archiver.kernel.org>; Thu, 23 Nov 2023 05:25:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E261874BF;
	Thu, 23 Nov 2023 06:25:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tom-fitzhenry.me.uk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tom-fitzhenry.me.uk header.i=@tom-fitzhenry.me.uk header.b="WIz7ayYb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C96C987590; Thu, 23 Nov 2023 06:24:59 +0100 (CET)
Received: from mx1.mythic-beasts.com (mx1.mythic-beasts.com
 [IPv6:2a00:1098:0:86:1000:0:2:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6715E870BC
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 06:24:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=tom-fitzhenry.me.uk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tom@tom-fitzhenry.me.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=tom-fitzhenry.me.uk; s=mythic-beasts-k1; h=Date:Subject:To:From;
 bh=42p79T8GLZZFOKbU1d76BczJWuzeSmD54a2Qw+BWLRw=; b=WIz7ayYbcxylYABUSudNj2VSXo
 JRGLCPnxJO36IK6a8B5OnyZL8Plzmdrg2a60RfYQ40RdGbar2oPyzWEBsF6ija6dXScr4Xz39pUFe
 yqvyfFFjrNDteKjAf4hRedyxrT7GggZeXBzmd6+r96GJzVkNCKd219b6vNlfdT8F9qaB3excAQtsH
 5c+RQlRqjE1x3x6ORrXgqFTZxLpK/xNmu6MrwBeCu35mjNGO292FdmGt8SdR6VpWgAvrA1ItEDK30
 jQhadrbnZL2TQYkuMpL0bxgGVFL67rrqw/kj2LglR4QZlNxM6Sbc22PX7VmjMlSacxJVFQj5oMOEJ
 U/F+4DIw==;
Received: by mailhub-cam-d.mythic-beasts.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <tom@tom-fitzhenry.me.uk>)
 id 1r62Cs-001XqL-Ho; Thu, 23 Nov 2023 05:24:55 +0000
User-agent: mu4e 1.10.8; emacs 29.1
From: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
To: eugen.hristev@collabora.com
Cc: jonas@kwiboo.se,u-boot@lists.denx.de,kever.yang@rock-chips.com
Subject: Re: eMMC errors on RK3588 (rock5b)
In-Reply-To: <6be35c0f-a89b-6b0a-cec2-a0e3b6d3624e@collabora.com>
Date: Thu, 23 Nov 2023 16:22:55 +1100
Message-ID: <87pm01oxd2.fsf@tom-fitzhenry.me.uk>
MIME-Version: 1.0
Content-Type: text/plain
X-BlackCat-Spam-Score: 0
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

I am able to reproduce this on RK3588 QuartzPro64.

I cannot reproduce on the vendor u-boot, used on stock RK3588
QuartzPro64. That works fine.

I thought "[PATCH v2 RESEND] mmc: dw_mmc: reset controller after data
error"[0] might fix this, but after applying that, I am still able to
reproduce the issue.

0. https://lore.kernel.org/u-boot/20230619103347.278004-1-eugen.hristev@collabora.com/
