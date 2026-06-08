Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ECF2CD8C8E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 08:27:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B816484154;
	Mon,  8 Jun 2026 10:27:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UpxCt5Lj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77F3F8466E; Mon,  8 Jun 2026 10:27:13 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84E5183EEF
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 10:27:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3DAA26001D;
 Mon,  8 Jun 2026 08:27:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C41A1F00893;
 Mon,  8 Jun 2026 08:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780907229;
 bh=8eIfkFYYTCJGOggCy08oDzMjMvBQa0dDA23WQH9VaRc=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=UpxCt5LjWJb7TXRko1+utGCOt7/7vkRGYXDW4HXUSH0M4mLSqNMcMG+GQw+XKjYGZ
 waLGffWaW0EkdkTkvxSDUJIS1TpAM5if7kCZJX+/r0l44UExR1OXy5geRcoQ0r+8K+
 SPkGgdQnf38MAUB0ZFHGDQT2pJlA4HGeeTT5G1raIplN9heHSqPfXx03ez9qTdMm8F
 3igWJ4gQSXzZ7wNqIk03sPWT24rA9bOvuTE7GbeZnh95di6Q8b1cGniqwzYlRPcgMe
 BKJnf5bP6BY52B1OCiBBNILsIZU0mRSBppl0x/lpJpEcUQZMVHIgC4yCz/xbG4aqTI
 2mZX3a/JTt1sw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 09/11] test: Reformat line wraps in img setup functions
In-Reply-To: <20260523085455.750591-10-sjg@chromium.org>
References: <20260523085455.750591-1-sjg@chromium.org>
 <20260523085455.750591-10-sjg@chromium.org>
Date: Mon, 08 Jun 2026 10:27:07 +0200
Message-ID: <87pl21xwro.fsf@kernel.org>
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

Hi Simon,

Thank you for the patch.

On Sat, May 23, 2026 at 02:54, Simon Glass <sjg@chromium.org> wrote:

> Some call-sites use awkward line wraps inherited from test_ut.py
>
> Adjust the wrapping so each call uses a more natural format with the
> first argument on the same line as the function name where possible,
> and arguments wrapped on natural boundaries elsewhere. No behaviour
> changes.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>
