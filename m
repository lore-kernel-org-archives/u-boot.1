Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 740BFC43458
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 17:59:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A9858460E;
	Fri, 26 Jun 2026 19:59:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=iki.fi header.i=@iki.fi header.b="vRpUqJX1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62462846DF; Fri, 26 Jun 2026 19:59:32 +0200 (CEST)
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F21D683FEE
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 19:59:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marko.makela@iki.fi
Received: from kehys.lan (dsl-hkibng32-54fb5f-245.dhcp.inet.fi [84.251.95.245])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: msmakela)
 by meesny.iki.fi (Postfix) with ESMTPSA id 4gn3N029LhzyQh;
 Fri, 26 Jun 2026 20:59:28 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
 t=1782496768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P5tRW0BiloXhwEf/ORTcuToSdpFDwOcstcshHyriyzA=;
 b=vRpUqJX1qF27JWKr1y0lgs6+tlCewdj8ohelL7PaKfKwqJ+0R42kpOgRxILvrVxtv+z7wb
 3tDHgZ4Sg05uAWEJrWWAY6woxGH+3zRPRhf1qxrSYMQUVJrCFb3DIqokl1WJyJLO7OCWEE
 MEwLe9feHJZGrbI/lGMsCX/xmezMAS4=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1782496768;
 b=w3c6YphFAARPPKzvZssCMsd6SVHWUwDXcjRBxCFbH2ADt5SPSo+6V2/dcnQNKxVD9/uxf5
 gPMrrvTVnzx3f+xG3t0jx7sxDR9SUgVo/AjykLg5tg4EHztHBExQEuJA187DX/6aSLkdUM
 rkuuwwHixjBZ2/6Bu8+/K/4XdNna8rI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
 s=meesny; t=1782496768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P5tRW0BiloXhwEf/ORTcuToSdpFDwOcstcshHyriyzA=;
 b=XZlSsdHS46XW9ZmRFj/7Hrp6PmOdBpzs7lvQDwgoSZuo1c6QZPaeLZNV4ci5g3qvVcAGCP
 0R68FRW1ju60EazSFXd1F2L+csDTzdAGAXsvXd6WM8PoHYV/FHnjyBzWN4bNcYPI/8W9d9
 je+IIx0W/qZgR941cg09N75KjADCldU=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=msmakela smtp.mailfrom=marko.makela@iki.fi
Date: Fri, 26 Jun 2026 20:59:26 +0300
From: Marko =?iso-8859-1?B?TeRrZWzk?= <marko.makela@iki.fi>
To: rs@ti.com
Cc: robertcnelson@gmail.com, ayush@beagleboard.org,
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com,
 trini@konsulko.com, afd@ti.com, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org, sjg@chromium.org, u-boot@lists.denx.de
Subject: Re: [PATCHv3 0/4] k3-am62-pocketbeagle2: add board and variant support
Message-ID: <aj69_uiqzmGuXql-@kehys.lan>
References: <20260624211949.327905-1-rs@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260624211949.327905-1-rs@ti.com>
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

Hi Randolph, all,

I tested this together with the ECDSA patch series v8, on top of the 
current u-boot master.

I built a signed FIT image with Linux v7.1, target load address 
0x84000000 and device tree address 0x83000000. This did not clash with 
the $loadaddr of 0x82000000; the kernel address 0x81000000 would cause 
u-boot to crash and reboot.

The kernel booted fine, but the
https://www.beagleboard.org/distros/pocketbeagle-2-debian-13-5-2026-05-19-minimal-v6-12-x-ti
user space would fail to start up ZRAM. I guess it's simply because I 
did not make any kernel modules available yet. I was able to get into 
the login screen and shut down the system nevertheless.

My ultimate goal is to set up trusted boot on top of TF-A. The 
PocketBeagle 2 is a convenient development platform.

With best regards,

	Marko
