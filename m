Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC9CD15D88
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 12:30:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 155A088DC8;
	Mon, 21 Oct 2024 14:30:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="jXCGEdnN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9iM9hP9u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D80688DE9; Mon, 21 Oct 2024 14:30:20 +0200 (CEST)
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4029188D70
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 14:30:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=b.spranger@linutronix.de
Date: Mon, 21 Oct 2024 14:30:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1729513817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uqvWUCdA842P56kowiGwK41lzuCYxVMwrvIjku19lyY=;
 b=jXCGEdnN6EfoWXaHN7OyKpH6tTJ48vFAMKcY0tE1N9fZUVGCWUqKMy0T+mjhVQEfJ++Hwt
 IiXT+qQxJrGDaizpgECp2N0JxGAahiJAz0WM3/P4wFGQosZScuA9U9TvTJUzZm1WJ3Tm6f
 r/wBUIkk4CFBiNX+5JOOk+5vev1qfTKA/+PBgyZi/i49F1xyM8h7V96BVzdhhmx387xslo
 vdZVHJALljQmF+9pJPzv2f7+BybKEjeBoI/OPfK13a4GnwePGf0NpCkSwnJP/JSjMBKZAc
 V9ypgiSlGkes4L6GylVt6bXruWhfmYCdCp5irKzG38TeQwpcEN+cJ8ox6dL/Wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1729513817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uqvWUCdA842P56kowiGwK41lzuCYxVMwrvIjku19lyY=;
 b=9iM9hP9u+hok/6epss2H8BypwzaU2qHiaN8GLK/PTd0g5xWHzmyJqhgHk8Fg7F1Yo0F+9D
 X4hm0Rk6eQUL50BQ==
From: Benedikt Spranger <b.spranger@linutronix.de>
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: u-boot@lists.denx.de, John Ogness <john.ogness@linutronix.de>,
 ada@thorsis.com
Subject: Re: [PATCH 0/5] collected fallout of porting an ATSAMA5D27 based board
Message-ID: <20241021143016.64dae8ca@mitra>
In-Reply-To: <768cd930-de7f-47fd-967a-3b5849b86069@linaro.org>
References: <20241018083006.10349-1-b.spranger@linutronix.de>
 <20241018-unsubtle-yield-8ac617356e92@thorsis.com>
 <20241018161908.3f6a13eb@mitra>
 <20241021-steadily-rephrase-ec1f100026e4@thorsis.com>
 <768cd930-de7f-47fd-967a-3b5849b86069@linaro.org>
Organization: Linutronix GmbH
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

On Mon, 21 Oct 2024 10:17:54 +0300
Eugen Hristev <eugen.hristev@linaro.org> wrote:

Hi,
  
> >>> Do you use at91bootstrap as 2nd level bootloader like me or
> >>> something else?
> >> I use the U-Boot SPL. There is no UBI support in at91boostrap.
> >> There were some attemps, but...
> >> No interest at the at91bootstrap side.
> 
> It's not about interest. There are two main reasons:
> First, all open source UBI stacks are GPL. At91bootstrap is not GPL
> and it cannot take GPL restricted code (being MIT ).
I do not recall any issue mentioned about a license issue, when I send
out UBI patches for the AT91boostrap over a decade ago. It was a simple
"nice, I put it in a branch, but we do not need it."
I followed the UBI topic in AT91bootstrap loosely after that.

> Second, all UBI stacks are huge in terms of code and memory. 
OK. Maybe we have a different view on huge. The board I am supporting
now is the successor of a AT91SAM9263 board. This (old) board use
AT91boootstrap with UBI support. BTW: The original requirement for UBI
support was to fit into 4k (PPC 440 bootloader).

> At91bootstrap is a second stage that should fit in 16k , 32k or 64k 
> depending on the platform. So far this restriction could not be met
> by any UBI implementation.
OK. This need some more in depth view:
A SPL needs UBI read support only. This support can be done in less
then 4k, as I mentioned before. So UBI full read/write support?
You're right. It does not fit.

Needed read support?
It definitly fit (and works fine for over a decade).

> ... and yes, doing a custom in-house small UBI implementation would
> be challenging, and costly.
If you look at ubispl, you got some clue, what's needed. The UBI
support to the AT91boostrap (for the AT91SAM9263) is about ~450 LOC.
Managable, but why should I do it, when U-Boot SPL does the job...

> > (What I do here: SoC loads at91bootstrap from raw NAND at offset 0,
> > at91bootstrap loads U-Boot from raw NAND at some offset like
> > 0x20000, U-Boot (proper) loads everything else from UBI.)
> 
> Either way, it is interesting to see that the U-boot proper NAND dm 
> driver does not work without at91bootstrap.
To be clear: The U-Boot *SPL* does not work with the NAND dm driver.

The old NAND driver does. So from a developers view I can spend some
spare cycles on that, from a overall project view: we use the old
driver, since it is working.

Regards
    Benedikt Spranger
