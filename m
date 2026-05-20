Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48680CD4F3C
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 10:10:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86A6E846BD;
	Wed, 20 May 2026 12:10:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MusWAEdg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CEEC846D0; Wed, 20 May 2026 12:10:45 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E150183FB0
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 12:10:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D121660120;
 Wed, 20 May 2026 10:10:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56801F000E9;
 Wed, 20 May 2026 10:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779271841;
 bh=W5aiRgyY23HQ3QWewo+ccC7yYOfBI4uY/41QWWeZLko=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=MusWAEdgj3873XboGKmZUjYeAmHPrWxYUfK6QIZdUDGajL6j4ag/Fd6MXrwENLklr
 Y4jqQsTCssI4QEOj3ce4e2nqOLTFAOL+5ugDAohPKj3y1LgMinW0MaO/+2GZcCihl5
 TmugL8elHPYms4UAd4Gj3CHRuwA752UNF4M+fgCcupsgAL2wn2TEbkbtyEBVeUlFHY
 b5gQE7JGDJScDxl8MgSIz3RENry291lRzYcGoag+9mrjXL0cZUWtX0yOn6CvXCGrbt
 oSJ0Xp1sHhwWuY81Otf5718pEDUBB+PmAGDaahnH+3rsq+dL/bfLC8ZFOFjM+dax/i
 jgZJ9ExgpcAig==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: u-boot@lists.denx.de, Zixun LI <admin@hifiphile.com>
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>, Zixun LI <zli@ogga.fr>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>
In-Reply-To: <20260515-udc_ep-v2-1-cd335b4e62e4@hifiphile.com>
References: <20260515-udc_ep-v2-1-cd335b4e62e4@hifiphile.com>
Subject: Re: [PATCH v2] usb: gadget: atmel: do not disable endpoints in
 reset_all_endpoints()
Message-Id: <177927183866.9596.11502517761525058912.b4-ty@b4>
Date: Wed, 20 May 2026 12:10:38 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
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

On Fri, 15 May 2026 12:05:41 +0200, Zixun LI wrote:
> Endpoints should not be disabled on bus reset inside UDC driver,
> otherwise a race condition will happen between gadget driver. Gadget
> driver will free the requests and disable endpoints in disconnect ops.
> 
> Also remove outdated comment about it in usba_ep_disable().
> 
> Fixes: 59310d1ecb9f ("usb: gadget: introduce 'enabled' flag in struct usb_ep")
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] usb: gadget: atmel: do not disable endpoints in reset_all_endpoints()
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/7f34bb50a59804f6ebe02c1f62b7b29093eb103c

--
Mattijs
