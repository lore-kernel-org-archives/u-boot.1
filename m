Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E335C0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 10:13:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DA77800B3;
	Tue, 11 Feb 2025 11:13:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="ZaSXn5Z6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8853F800CF; Tue, 11 Feb 2025 11:13:02 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [IPv6:2003:a:e28:26e4::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4909B80079;
 Tue, 11 Feb 2025 11:13:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0F74814871A0; Tue, 11 Feb 2025 11:12:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1739268779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f7T//AHQMRgQlNoiQBDBL/L3h1Dz0CaNB03HryV96rc=;
 b=ZaSXn5Z6m/oJqGlD4nFKUicX6RaKvRQYP4HYw3BjkGv1wQHInDopkMLoLsFQ+7Brt9R0q6
 yBbyJOtZzscna/9udUEEPxHwDsjG/kqa/V+wPPq32kAoRihHUeXGDNg5RYZgi2UDitH7/P
 NHkSDGBrDPlkhAvXRVdy5MwtTawZdpwx7baOdj53IH+WZD8IeRSCiYi/PTWZR7dv+DvhH9
 BBw3g+0VHkf5kv1dcM6PcnUEsszzy/oObbe9EZXgt/3AOOpeJoObV+LpaQO20EtXJ5qczH
 eXX/9F6rBblX6maZTo0ul/8679ASciD9ZihUs8I72OZAAH3xh8yJbUP4YPYIGg==
Date: Tue, 11 Feb 2025 11:12:57 +0100
From: Alexander Dahl <ada@thorsis.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-custodians@lists.denx.de,
 u-boot-board-maintainers@lists.denx.de,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [ANN] U-Boot v2025.04-rc2 released
Message-ID: <20250211-unissued-vehicular-5f2696655078@thorsis.com>
Mail-Followup-To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 u-boot-custodians@lists.denx.de,
 u-boot-board-maintainers@lists.denx.de,
 Sughosh Ganu <sughosh.ganu@linaro.org>
References: <20250210220151.GR1233568@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210220151.GR1233568@bill-the-cat>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3
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

Hello everyone,

Am Mon, Feb 10, 2025 at 04:01:51PM -0600 schrieb Tom Rini:
> Hey all,
> 
> It's release day and so here's v2025.04-rc2. As this is the -rc2
> release, I've now also opened up the -next branch and will be stricter
> about what I apply myself, and what I see coming in for pull requests as
> well moving forward.

This still fails to build on older arm 32 bit cores if
CC_OPTIMIZE_FOR_DEBUG is enabled:

    % buildman -o ~/build/u-boot/buildman -e -a CC_OPTIMIZE_FOR_DEBUG sam9x60
    Building current source for 5 boards (5 threads, 4 jobs per thread)
           arm:  +   sam9x60_curiosity_mmc      
    +arm-linux-gnueabi-ld.bfd: lib/lmb.o: in function `lmb_map_update_notify':
    +lib/lmb.c:458: undefined reference to `efi_add_memory_map_pg'
    +make[1]: *** [Makefile:1824: u-boot] Fehler 1
    +make: *** [Makefile:177: sub-make] Error 2
           arm:  +   sam9x60_curiosity_mmc1                           
    +arm-linux-gnueabi-ld.bfd: lib/lmb.o: in function `lmb_map_update_notify':
    +lib/lmb.c:458: undefined reference to `efi_add_memory_map_pg'
    +make[1]: *** [Makefile:1824: u-boot] Fehler 1
    +make: *** [Makefile:177: sub-make] Error 2
           arm:  +   sam9x60ek_mmc                                     
    +arm-linux-gnueabi-ld.bfd: lib/lmb.o: in function `lmb_map_update_notify':
    +lib/lmb.c:458: undefined reference to `efi_add_memory_map_pg'
    +make[1]: *** [Makefile:1824: u-boot] Fehler 1
    +make: *** [Makefile:177: sub-make] Error 2
           arm:  +   sam9x60ek_qspiflash                      
    +arm-linux-gnueabi-ld.bfd: lib/lmb.o: in function `lmb_map_update_notify':
    +lib/lmb.c:458: undefined reference to `efi_add_memory_map_pg'
    +make[1]: *** [Makefile:1824: u-boot] Fehler 1
    +make: *** [Makefile:177: sub-make] Error 2
           arm:  +   sam9x60ek_nandflash                            
    +arm-linux-gnueabi-ld.bfd: lib/lmb.o: in function `lmb_map_update_notify':
    +lib/lmb.c:458: undefined reference to `efi_add_memory_map_pg'
    +make[1]: *** [Makefile:1824: u-boot] Fehler 1
    +make: *** [Makefile:177: sub-make] Error 2
        0    0    5 /5              0:00:42  : sam9x60ek_nandflash
    Completed: 5 total built, 5 newly), duration 0:00:22, rate 0.23

I reported this three weeks ago already.  Did anyone look deeper into
this?  See for reference:
https://lore.kernel.org/u-boot/20250117-molecular-quicksand-e80bf947313e@thorsis.com/

Greets
Alex

