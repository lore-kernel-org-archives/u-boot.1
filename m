Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9519BC07C79
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 19:48:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 219F8889D3;
	Mon, 22 Apr 2024 21:48:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="rOZ9czzX";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="n/VmhEMh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3793889D3; Mon, 22 Apr 2024 21:48:39 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC5A7889B5
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 21:48:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4VNbQs5y57z9sTs;
 Mon, 22 Apr 2024 21:48:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1713815317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kWPrint0AIaVajBtI5CJ6uo1SmO6M5ipcSYv4q0NTVU=;
 b=rOZ9czzXErU+q9Dsyx1MQKksFM5MYIFw7GrR8wTXJ7Qo4TtQqZgub8fE05QpdfpZAA+Ct9
 FzQtejzuDEcb+WZ8kBgOpJ92UTECQxIuCLYFY4CckzNz2tQPHl9YC0y6vClbEMcH0E5VAv
 uH+8G07eq1dhA7cU5rB7B7LVHpsfiPfoXoJnFgG2VUpULvK54otSU/S8msfxzEhtGMP9/M
 n+sLZpnDFimKY6KxgMnSpHKE+nC+ly17FsmMxazOpiSs7UndCGG8pbUx5l8WdzcydKM+0/
 VfQ8ku8Or7Pba/POYRbQ0v+yKDevsB4Eji69seAfRU+xTY80mUHjr9vMM4hbuA==
Message-ID: <38f2306f-4c82-4bc4-b2ee-6051dc55a4c2@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1713815315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kWPrint0AIaVajBtI5CJ6uo1SmO6M5ipcSYv4q0NTVU=;
 b=n/VmhEMhhkdkpiJ1Vm5cQatEaCxkm7ulph7XriYYecblVfc+rhSu2hpIPx3e3t4cURpEiT
 tm7XmEMnLNQgi1ECilFuVk1wrSV1SbWGPBpH5DlEk5eKHom755gobJp7PCcDDYTIBguzNy
 djGlwr+2AN/6NjaS2RywRgkHMvjBXUetg+C2oZZcUw1gDZmisUM5gQsoTYM7ezE4MrWtsH
 zST1AXaF7hnFBQ1DRHnmmIzUDs9EjeogV6kuG/0TYhDLjSTwiwmKa1879hPeaBtCxBb73i
 iIzDmgVpLsiNEuiSCKEvpdKSpVsnNOXORGBgEH3QCbeemqmLFqi6OsEIQDdLnA==
Date: Mon, 22 Apr 2024 21:47:21 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/3] net: eth-uclass: Introduce NET_PREFER_ROM_MAC_ADDR
To: Detlev Casanova <detlev.casanova@collabora.com>, u-boot@lists.denx.de
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Fabio Estevam <festevam@denx.de>
References: <20240422135927.23582-1-detlev.casanova@collabora.com>
 <20240422135927.23582-2-detlev.casanova@collabora.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20240422135927.23582-2-detlev.casanova@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: yacnicycx5odtrrcw1nigchi86wnwncn
X-MBO-RS-ID: 00742c81146706433f5
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

On 4/22/24 3:56 PM, Detlev Casanova wrote:
> On some boards, a MAC address is set based on the CPU ID or other
> information. This is usually done in the misc_init_r() function.
> 
> This becomes a problem for net devices that are probed after the call to
> misc_init_r(), for example, when the ethernet is on a PCI port, which
> needs to be enumerated.
> 
> In this case, misc_init_r() will set the ethaddr variable, then, when
> the ethernet device is probed, if it has a ROM address, u-boot will warn
> about a MAC address mismatch and use the misc_init_r() address instead
> of the one in ROM.
> 
> The operating system later will most likely use the ROM MAC address,
> which can be confusing.
> 
> To avoid that, this commit introduces NET_PREFER_ROM_MAC_ADDR that can
> be set for boards that have such an interface.
> 
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>

Won't the system pick ROM MAC if $ethaddr is not set ?
