Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECAE9C27C6E
	for <u-boot@archiver.kernel.org>; Sun, 16 Jun 2024 10:18:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C34488119;
	Sun, 16 Jun 2024 12:18:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718533126;
	bh=kScIjqKPG5lgNUHTmfzAPSXR+DdvDhb0JRDGNgZrGlI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yYW1kG0aJnnOuCuPaD+WGahEhtFwmoV4rFiRq/kscgXZH06/hExjQZflfr0t8xb0l
	 7E/CAajDdQ2t5WN2a9hPMxhIsj0Y+poZ8NxvArRjwUKUfirwsZVQhtW78XwcuUyOhc
	 +MzWRVDW783ft6FSQ6JSFw7w+gjlVUdp9junjtrCPp1bqx031B+U9bCr/TJpUdmLs1
	 y0pg23BGwAH7/tn4CzDUlJJCVRDxgoe7FOW8Lti7bJgDcm4HPQFeXiMQveICQ1niVS
	 XUFJm4VRnUdMdDfVL4v7kyoDpxgVSare/HOTejyKNqHKDant9m3PGTvVJUS/5Y+BPU
	 9zahiyfLXOZaQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35CB98811A; Sun, 16 Jun 2024 12:18:45 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A23B87FC2
 for <u-boot@lists.denx.de>; Sun, 16 Jun 2024 12:18:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4W289s1KdDz9sSW;
 Sun, 16 Jun 2024 12:18:41 +0200 (CEST)
Message-ID: <bb903dc2-c995-4c05-9adc-2a37ccad361a@denx.de>
Date: Sun, 16 Jun 2024 12:18:40 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 0/7] watchdog_reset cleanup
Content-Language: en-US
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Angelo Dureghello
 <angelo@kernel-space.org>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Huan Wang <alison.wang@nxp.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
References: <20240528111325.2163560-1-rasmus.villemoes@prevas.dk>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240528111325.2163560-1-rasmus.villemoes@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 5/28/24 13:13, Rasmus Villemoes wrote:
> watchdog_reset is no more. That is, it is no longer called from
> anywhere, so any leftover definitions are just dead weight, and
> references in comments need to be updated.
> 
> I don't have access to any m68k, sh or powerpc boards. Only lightly
> compile-tested.
> 
> Apart from the two sh4 patches, these are independent of each other
> and can be applied individually.
> 
> Cc: Angelo Dureghello <angelo@kernel-space.org>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Huan Wang <alison.wang@nxp.com>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

Applied to u-boot-watchdog/next

Thanks,
Stefan

> Rasmus Villemoes (7):
>    m68k: remove dead code
>    wdt-uclass: watchdog_reset cleanup
>    serial: ns16550: fix comment to mention schedule instead of
>      watchdog_reset
>    sh4: move reset_cpu() from watchdog.c to cpu.c
>    sh4: remove watchdog.c file
>    powerpc: mpc83xx: remove unused watchdog_reset() function
>    powerpc: mpc85xx: remove dead watchdog-related code
> 
>   arch/m68k/cpu/mcf52x2/cpu.c    | 108 ---------------------------------
>   arch/powerpc/cpu/mpc83xx/cpu.c |  15 -----
>   arch/powerpc/cpu/mpc85xx/cpu.c |  31 ----------
>   arch/sh/cpu/sh4/Makefile       |   2 +-
>   arch/sh/cpu/sh4/cpu.c          |  10 +++
>   arch/sh/cpu/sh4/watchdog.c     |  61 -------------------
>   drivers/serial/ns16550.c       |   8 +--
>   drivers/watchdog/wdt-uclass.c  |  19 +-----
>   include/watchdog.h             |   3 -
>   9 files changed, 17 insertions(+), 240 deletions(-)
>   delete mode 100644 arch/sh/cpu/sh4/watchdog.c
> 

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
