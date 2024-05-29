Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F43C25B7C
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 07:36:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2971D88590;
	Wed, 29 May 2024 09:36:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="payajS33";
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="idndBBDS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8DE588225; Wed, 29 May 2024 09:36:15 +0200 (CEST)
Received: from mail.kernel-space.org (mail.kernel-space.org [195.201.34.187])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA65E88590
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 09:36:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
Received: from kernel-space.org (localhost [127.0.0.1])
 by kernel-space.org (OpenSMTPD) with ESMTP id e6d36123;
 Wed, 29 May 2024 07:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=s1; bh=5N
 AA6SL1xUWn1RG2xaRgXDbY90s=; b=payajS33Pt9j64+slX0baqni9jWDeKJ3YV
 wA39/RdW46chnuszIgxPjwus6oGLchMchittQrvm+6KP93oomQvF3InZiQDpZ9PZ
 n/9IxvhCFVMcFSSaF9i19Hs9U24BFHTotxLisoP61m8gBWZZVMzFqdEajsNvLeYh
 N9rD7gLZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; q=dns; s=s1; b=
 fGUGYIgEwamJFr0ZAHsme54LCHu/MtsbKOi96w0wsFf9tGn+Pt9vEzx8vYI/pEvl
 oRipjNBbMNE2T1/2BkLIfW3vjY9K2qRvoPFL/8P5PmptmCvr9qE2Fg+T9EYDjI5g
 2Xrp5harpkUv1ua/wglp1/wbzZNOMkTcNd+3H0uS8n4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1716968020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2I031fClhfsxK/H2vNhWEZ1PCyRrxhgIugjL+a2LCfg=;
 b=idndBBDS6MZTtiAw748tQav+xsPw62aMENYY0PPBG3B0728yGmYDW8jHz975vmgh444d45
 kRdlZhD6InM27BPutLBI6r18pAki9308ayvDM6MTF+Mqd4roRhN6ayEiRV7Cpd8grko6mg
 edbfKXcIPXbr4Sfp+N/wWpcKj7kugrA=
Received: from [192.168.0.2] (host-87-9-236-85.retail.telecomitalia.it
 [87.9.236.85])
 by kernel-space.org (OpenSMTPD) with ESMTPSA id fe8786e7
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Wed, 29 May 2024 07:33:40 +0000 (UTC)
Message-ID: <03977371-0c2a-428b-aa14-73f244874a51@kernel-space.org>
Date: Wed, 29 May 2024 09:35:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Acked
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Huan Wang <alison.wang@nxp.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
References: <20240528111325.2163560-1-rasmus.villemoes@prevas.dk>
Content-Language: en-US
From: Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <20240528111325.2163560-1-rasmus.villemoes@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Rasmus,


On 28/05/24 1:13 PM, Rasmus Villemoes wrote:
> watchdog_reset is no more. That is, it is no longer called from
> anywhere, so any leftover definitions are just dead weight, and
> references in comments need to be updated.
>
> I don't have access to any m68k, sh or powerpc boards. Only lightly
> compile-tested.
>
> Apart from the two sh4 patches, these are independent of each other
> and can be applied individually.

Thanks for the cleanup,

Acked-by: Angelo Dureghello <angelo@kernel-space.org>


> Cc: Angelo Dureghello <angelo@kernel-space.org>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Huan Wang <alison.wang@nxp.com>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>
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
