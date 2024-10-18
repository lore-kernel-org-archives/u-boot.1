Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02032D30011
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 14:19:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A12889189;
	Fri, 18 Oct 2024 16:19:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="cfn3zBhG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7D1qW8B/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B8F7890A9; Fri, 18 Oct 2024 16:19:19 +0200 (CEST)
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAB1789189
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 16:19:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=b.spranger@linutronix.de
Date: Fri, 18 Oct 2024 16:19:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1729261149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vz4vrlphSbOpZ6rpP/4BjOJzXH61m0CV3dQm0Dn3EEo=;
 b=cfn3zBhGah4QfsO2+x0JuJAqbw/eAI6QtB1hHzAkO3T0DthXqqZ6qScZLK0Qzxt/8I6dfi
 uUo19atluP5+gmo/LJUkcq6SypWml70g8+hPmLHfbUrU5RrS5/8ccs1yoXw/LJKSKSFweJ
 2jmfyT/8oQo1DhW/wnBJErbuIswiSUcsHsfQ/rRcM09MAGZ8RClz/fagyhoGz97A54P7cT
 zXOxQw7fFA4DVW3wDhfJQRC4vyg8SX8Dpc0Qz7KA2ak2EWUrcurOI0F4VTLBV4pVGG1byT
 bdSSvKZqPuJOHB12gmNsJwsawDM3r+dhtKka9VIT0u1Ca1/+Souf/5nauR/8aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1729261149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vz4vrlphSbOpZ6rpP/4BjOJzXH61m0CV3dQm0Dn3EEo=;
 b=7D1qW8B//WJOQGm1dHn2zY2Hqzpkzowf3Zpupd0yHF7P7HPW9W30hPFuzTWD/DTrpuEb2Q
 hAARIbtAZVYix2Cg==
From: Benedikt Spranger <b.spranger@linutronix.de>
To: Alexander Dahl <ada@thorsis.com>
Cc: u-boot@lists.denx.de, John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH 0/5] collected fallout of porting an ATSAMA5D27 based board
Message-ID: <20241018161908.3f6a13eb@mitra>
In-Reply-To: <20241018-unsubtle-yield-8ac617356e92@thorsis.com>
References: <20241018083006.10349-1-b.spranger@linutronix.de>
 <20241018-unsubtle-yield-8ac617356e92@thorsis.com>
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

On Fri, 18 Oct 2024 15:11:20 +0200
Alexander Dahl <ada@thorsis.com> wrote:

Hello Alexander,

> Am Fri, Oct 18, 2024 at 10:30:00AM +0200 schrieb Benedikt Spranger:
> > OK, you might say the nand_atmel NAND driver is obsolete, but it
> > was the only solution to get booting from NAND running. The new DM
> > based NAND driver refused to do anything usefull, so I dropped it
> > after spending a couple of days debugging it:
> 
> Strange.  I have at least three different boards with SAMA5D27
> successfully booting from NAND flash with the new DM based driver
> (unfortunately none of them upstreamed, which also won't change in the
> foreseeable future, sorry).
OK.
 
> Do you use at91bootstrap as 2nd level bootloader like me or something
> else?
I use the U-Boot SPL. There is no UBI support in at91boostrap. There
were some attemps, but...
No interest at the at91bootstrap side.

> For me it was basically getting the dts for U-Boot correct, but
> I got that running with all U-Boot releases since 2023.04 up to
> 2024.10.  Could you share some more detail?
I face all the trouble in SPL. And since the SPL is the essential part
here (UBI support) I gave up at one point. I simply couldn't any
usefull read data from the NAND flash, but all 0.

Regards
    Benedikt Spranger
