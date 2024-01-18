Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C960C47DB7
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 20:47:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B996887B52;
	Thu, 18 Jan 2024 21:47:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="n8N724MM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C66087BB9; Thu, 18 Jan 2024 21:47:02 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02D228795B
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 21:47:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 9764C2228F;
 Thu, 18 Jan 2024 21:46:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1705610819;
 bh=LKHi8SygsYOd1OR9+cuhop5IwH/zFNQmcK19D9B9RuU=; h=From:To:Subject;
 b=n8N724MMloQXx04Saa1NEH0eZeiciqyZlvSkr5dqs2Rm3L04ooNIiqCco2u/wqNRb
 uZ/VULqnAg3XCvqxBohHrJh5yB2//z6y+/3N01Y5JgijM0ysQWYZm8GwAOa5QTtgkz
 0zB6KLyPe+1BkhftOd2zkz4Kc06uB4NCerHG7/u3Wab639XKgiw+5i2bwZ+Q6Ep7Uh
 cDT/WxiTjoaiV/o83CqUXUJ0TYBgvoCX7qgPRPRNGdk/5wmdWok0gA0DJ4YHArvhDi
 q502H4L1NNyscjkBNX2vInG6hqANG/t5L+QuR9upVWqeETWm2F7cVqT2TLQL4N75AP
 tli3oW4uNqgFQ==
Date: Thu, 18 Jan 2024 21:46:54 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: max.oss.09@gmail.com
Cc: u-boot@lists.denx.de, Max Krummenacher <max.krummenacher@toradex.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Jonas Karlman <jonas@kwiboo.se>, Josua Mayer <josua@solid-run.com>,
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, Nishanth Menon <nm@ti.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH] headers: don't depend on errno.h being available
Message-ID: <20240118204605.GA25631@francesco-nb>
References: <20240118181106.4133924-1-max.oss.09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118181106.4133924-1-max.oss.09@gmail.com>
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

On Thu, Jan 18, 2024 at 07:10:47PM +0100, max.oss.09@gmail.com wrote:
> From: Max Krummenacher <max.krummenacher@toradex.com>
> 
> These headers follow the pattern:
> 
> | #if CONFIG_IS_ENABLED(FANCY_FEATURE)
> |   void foo(void);
> | #else
> |   static inline void foo(void) { return -ENOSYS; }
> | #endif
> 
> In the #else path ENOSYS is used, however linux/errno.h is not included.
> If errno.h has not been included already the compiler errors out even
> if the inline function is not referenced.
> 
> Make those headers self contained.
> 
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

