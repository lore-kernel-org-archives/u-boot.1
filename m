Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91FDECD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 09:02:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09711846BD;
	Mon, 11 May 2026 11:02:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ofg3n8Iq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CE3884706; Mon, 11 May 2026 11:02:31 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D8D3846A5
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 11:02:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 0F3EF600CB;
 Mon, 11 May 2026 09:02:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63879C2BCC9;
 Mon, 11 May 2026 09:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778490147;
 bh=ta4gVzoCFRM6Cshw/A21SedzvUcPek0C1M8B2Tdoz2E=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=Ofg3n8IqKTDifbo4DcYJdcemO1D8Dn1RKrJxDa0XchO3kVsXlBkdzeSyEshZ4lb7C
 vzBaox2sef8awtIwSBbxA0Hq2r08QtAEn2HBxFUeexdTcajwiBI3G4xh6kKpVAqB9y
 6+9QbtK5P8TFrZx922uX+cdgz5SEBk16Q224mxqaaAitmKFrAubnlBT7Tmx/dNWAXZ
 XgVl2qwcEGREaQRj38uqrTlsPwRyR78spbP9jZ38KrA/9fVoXR3cMvAswFYG49MGNu
 WMLc3xjYy0LuqkfT4v8eG7sBUOHsdeBgpWy+89FTI67RQ/YC8/pa9ct3Xi5A6wysrq
 gQVDihj6i7gbA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>, Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH v2] usb: gadget: f_acm: Fix memory leak in acm_add
In-Reply-To: <BESP194MB2805271AD5DBE47B322F8DC3DA3A2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
References: <BESP194MB2805271AD5DBE47B322F8DC3DA3A2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Mon, 11 May 2026 11:02:25 +0200
Message-ID: <874ikewc7y.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Francois,

Thank you for the patch.

On Sat, May 09, 2026 at 19:22, Francois Berder <fberder@outlook.fr> wrote:

> If udc_device_get_by_index fails, the f_acm struct was not released.
> Free it before returning the error.
>
> Signed-off-by: Francois Berder <fberder@outlook.fr>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
