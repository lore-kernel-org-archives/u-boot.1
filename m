Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A90AD5B876
	for <u-boot@archiver.kernel.org>; Mon, 15 Dec 2025 23:05:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C6AE80077;
	Tue, 16 Dec 2025 00:05:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="O9ic2+k2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 045FB800D0; Mon, 15 Dec 2025 19:37:11 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C61D08003E
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 19:37:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 701BE26779;
 Mon, 15 Dec 2025 19:37:08 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dom_9OGOrpsG; Mon, 15 Dec 2025 19:37:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1765823827; bh=6OW5Qrhre9YwsuTRhGF14Vl9FU3IuuFWj6hXqG1soKQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=O9ic2+k2B13QjX/j7LWjCuXccWbf7LdoLpQaGN0kfTUNVNFEEuwx7HxBrKDtC9fQj
 evYl9hIZUkEv7JMSRDK9Z/sc1oRCDML9EzOEOW78A8LkVF20U98zQzq6qkl/ZgGzfm
 yLuw1c56D7N+qhYNYT6wOdNNHyTpIHrs6l14Ua8j1kog3BCzeoj/2T1qklYVmT6Jaa
 hGPEfxIiy2l1rzXJEJgoWtyvEii/7PdIBEHtovFS5RPMQFOJIbRHH+d9QKhG4WTL3A
 B9EPqtV3B0egKXHx9Nv8y0+q9g2F7Aw4fc5EwbyT4geHvdkKRm8UF0xkdREZgsmswO
 u5Zz75kfKuPkg==
MIME-Version: 1.0
Date: Mon, 15 Dec 2025 18:37:07 +0000
From: Kaustabh Chakraborty <kauschluss@disroot.org>
To: u-boot@lists.denx.de
Cc: Heiko Schocher <hs@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2] i2c: samsung: add support for Exynos7 HS-I2C
In-Reply-To: <20251104-i2c-hs-exynos7-v2-1-93b4604f7409@disroot.org>
References: <20251104-i2c-hs-exynos7-v2-1-93b4604f7409@disroot.org>
Message-ID: <35799dc588baf60d670d18435f1deea0@disroot.org>
X-Sender: kauschluss@disroot.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 16 Dec 2025 00:05:08 +0100
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

On 2025-11-04 06:14, Kaustabh Chakraborty wrote:
> Exynos7 (and later) HS-I2C blocks have special interrupts regarding
> various data transfer states (see HSI2C_INT_I2C_TRANS_EN). Add support
> for enabling and handling these interrupt bits.
> 
> Add the corresponding compatible, 'samsung,exynos7-hsi2c'. In order to
> differentiate between the multiple device variants, an enum is
> introduced which is used where difference in implementations exist.

Bumping this series for visibility.
