Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E94B7CCFA00
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 15:49:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74E31839C6;
	Fri, 31 Oct 2025 16:49:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kqAu7Qel";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CB3C839CA; Fri, 31 Oct 2025 16:49:32 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6C5C839B9
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 16:49:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 22C9A43C17;
 Fri, 31 Oct 2025 15:49:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B97C4CEE7;
 Fri, 31 Oct 2025 15:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761925769;
 bh=AYpKtYsw79/mJHv8EAPhiXVYZQ7BWeMKbAHD6nJXmbQ=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=kqAu7QelxwvA1CCVfuXyjJerZmneKJiSARH/3fdTcS2BkyDN4fLnSJTKnN3cEjC69
 jr7071ivUbWi0lPLlJkyfNgXg7ZUXs6162Lo1FMKiqbEn6pPNuqKhr22SmTxLKto8b
 8Bobxo+8yx7sSX4o+3liAPYrDSyodR1Sfr7Lsm5pGBEm6nwJXo6s++FQiHMYu7/j3L
 f9P2TFaT1t1rBRekk/Xoe3tudKb7wHQk3dm7yYo454ZaUiI0G62jGy4w/pQuAqh9ca
 2nGQH72iLa82btMjU5syBf6EbJJcop8KjBL1kQTIAoDR3zP3oH4OQTkoBKYh9W66QZ
 dOyBdh6VDB7xA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>, Tom Rini
 <trini@konsulko.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Julien Masson <jmasson@baylibre.com>, Guillaume La Roque
 <glaroque@baylibre.com>, u-boot@lists.denx.de, Simon Glass
 <sjg@chromium.org>, Nicolas Belin <nbelin@baylibre.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Aaron Kling <webgeek1234@gmail.com>, George Chan <gchan9527@gmail.com>,
 Sam Day <me@samcday.com>, Jerome Forissier <jerome.forissier@linaro.org>,
 Maxime Fournier <mfournier@baylibre.com>
Subject: Re: [PATCH v2 2/5] boot: android: Add sandbox memory mapping support
In-Reply-To: <20251017-bootconfig-v2-2-8c7c2f2e5474@baylibre.com>
References: <20251017-bootconfig-v2-0-8c7c2f2e5474@baylibre.com>
 <20251017-bootconfig-v2-2-8c7c2f2e5474@baylibre.com>
Date: Fri, 31 Oct 2025 16:49:24 +0100
Message-ID: <87ecqj5awr.fsf@kernel.org>
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

Hi Guillaume,

Thank you for the patch.

On Fri, Oct 17, 2025 at 15:19, "Guillaume La Roque (TI.com)" <glaroque@baylibre.com> wrote:

> Use map_to_sysmem() to convert header pointers to physical addresses
> in parse_hdr functions, and add proper map_sysmem()/unmap_sysmem()
> calls in android_image_get_data() for sandbox compatibility.
>
> Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  boot/image-android.c | 41 ++++++++++++++++++++++++++++-------------
>  1 file changed, 28 insertions(+), 13 deletions(-)
>
> -- 
> 2.34.1
