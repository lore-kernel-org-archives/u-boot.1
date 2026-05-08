Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B5B9CD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 19:42:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F72484C92;
	Fri,  8 May 2026 21:42:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D44984D2F; Fri,  8 May 2026 21:42:43 +0200 (CEST)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F22AE84B02
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 21:42:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=duwe@lst.de
Received: by verein.lst.de (Postfix, from userid 107)
 id AA99A68C4E; Fri,  8 May 2026 21:42:38 +0200 (CEST)
Received: from localhost (dynamic-095-117-005-203.95.117.pool.telefonica.de
 [95.117.5.203])
 by verein.lst.de (Postfix) with ESMTPSA id 33D5F67328;
 Fri,  8 May 2026 21:42:23 +0200 (CEST)
Date: Fri, 8 May 2026 21:42:22 +0200
From: Torsten Duwe <duwe@lst.de>
To: Simon Glass <sjg@chromium.org>
Cc: Peter Robinson <pbrobinson@gmail.com>, Matthias Brugger
 <mbrugger@suse.com>, Bin Meng <bmeng.cn@gmail.com>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, Tom Rini <trini@konsulko.com>, Andrea della
 Porta <andrea.porta@suse.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Jan =?UTF-8?B?xIxlcm3DoWs=?= <sairon@sairon.cz>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/3] core: Skip parent device nodes without a DT
 reference when looking for dma-ranges
Message-ID: <20260508214222.642b15cb@lst.de>
In-Reply-To: <CAFLszTgaG8RV=kWgr7Gu3tkVniq5pNVQ7RSUEv2EMyyQ4ALO6Q@mail.gmail.com>
References: <20260508154108.336B968BEB@verein.lst.de>
 <20260508154239.1E16368BFE@verein.lst.de>
 <CAFLszTgaG8RV=kWgr7Gu3tkVniq5pNVQ7RSUEv2EMyyQ4ALO6Q@mail.gmail.com>
Organization: LST e.V.
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; aarch64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri, 8 May 2026 12:47:45 -0600
Simon Glass <sjg@chromium.org> wrote:
[...]
> There's already a unit test for device_get_dma_constraints() in
> test/dm/read.c (dm_test_dma_ranges). Since you are extending it to
> walk past nodes without an ofnode, please can you add a case
> exercising the new path - a sandbox device whose immediate parent has
> no DT reference should do it.

I'll have a look.

Talking unit tests, is it just me who experiences reproducible crashes
on RPi5 with today's master branch?

	Torsten

