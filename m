Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC37CD6E6E
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 22:34:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47FCD849B7;
	Fri,  5 Jun 2026 00:34:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="aiuK1CrD";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kNK+/PaF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17A7F84868; Fri,  5 Jun 2026 00:34:26 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB26C849B7
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 00:34:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gWfWM3pMSz9v0f;
 Fri,  5 Jun 2026 00:34:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1780612463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8mCMjTXzuQSDVN4KUem5yyoFygNssk8ek69FH1ABjZ4=;
 b=aiuK1CrDJQ7Gmda5XsXt3xJE7ucTPTM8HdB447Csllgfr5+VIneFfsSD0Vw261f3AQMRax
 Z//o8d3UjwA5Y/AtGxs3Pz0pkkcxy60ZVYBBCbINBx93udI5dcmcZ/Gx8GwsPZB9UPnl6M
 nKoiOSUcyXkIexF5UxAaemOwJszx7kRzWIzrj/mHag/pKYBJAMdndV1RjT0xuStdusDzMi
 D/0b/2bSJbORQOzUno7jwFLVujzlBKToFX5Ygdyw2msXLUmBrSPgKdhG7ptIgnHTqbhruJ
 z6yXiLL9F1AvzjH8aiLbvkDgkE9YiWj8VOSeTsCwnR0NdiuqDTVBvWEYgMAWJg==
Message-ID: <89b2f624-796b-48b9-92b9-4739cc64a497@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1780612461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8mCMjTXzuQSDVN4KUem5yyoFygNssk8ek69FH1ABjZ4=;
 b=kNK+/PaFp5HYzOgj3fRbh+Gaq8rhVcgN7XgxDrsgJxY6rYeEXl+oTivOkkHC1aGQqSt9hA
 Z/nRbAk/Wr2lp7viq+33hVAv+fh+4JHeFdkJKNjJzjga1OSu18CWgYCXBe2gbB245tntfP
 9z6gfiUDxhOaUJQcrVXC56N/08M3MCffVJota7ISaT9DzUQh0y4bsX8a8JTHFSyAUoFVlH
 BHKvxE+sCblWxO9yKgY1OHIaBRzMSescOTSSFlm72uElj0JBRCTdT2W4/ltdyaSbwHsPBR
 83nOI5ph1td7PEtgL2H+Pp4W7f173ZdrBcMV9paGfI+cmO2F52uNWFyOlrRToQ==
Date: Fri, 5 Jun 2026 00:31:10 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v5 1/7] treewide: move bi_dram[] from bd to gd
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
References: <20260604073719.48723-1-ilias.apalodimas@linaro.org>
 <20260604073719.48723-2-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260604073719.48723-2-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 8e88088bc8bed24feea
X-MBO-RS-META: j4zk767odseofobcquyfc3s1jzehfyso
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

On 6/4/26 9:37 AM, Ilias Apalodimas wrote:
> Currently, the bi_dram[] information is stored in the board info
> structure (bd). Because bd is only valid after reserve_board(),
> dram_init_banksize() must be called late in the initialization process.
> This limitation is problematic, as it forces us to rely on a variety of
> bespoke functions to determine board RAM, bank memory sizes, and other
> early setup requirements.
> 
> By moving bi_dram[] into the global data (gd), we can run it earlier.
> This is particularly convenient since boards define their own
> dram_init_banksize() routines, which do not always rely on parsing
> Device Tree (DT) memory nodes.
> 
> Additionally, U-Boot defaults to relocating to the top of the first memory
> bank. While boards currently use custom functions to override this
> behavior, having the DRAM bank information available earlier in gd makes
> relocating to a different bank trivial and standardizes the process.
Regarding the BD, this is likely really old, but it seems BD might be 
passed from U-Boot to Linux somehow ? See [1] and U-Boot 
include/asm-generic/u-boot.h :

  8  * NOTE: This header file defines an interface to U-Boot. Including
  9  * this (unmodified) header file in another file is considered normal
10  * use of U-Boot, and does *not* fall under the heading of "derived
11  * work".

Are we certain we are not breaking ABI here ?

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/boot/ppcboot.h

