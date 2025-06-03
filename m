Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C834C5AD49
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 13:38:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B097B80F9C;
	Tue,  3 Jun 2025 15:38:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="tHQ8kfTx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mJINohNP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F9EA82145; Tue,  3 Jun 2025 15:38:06 +0200 (CEST)
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6026380AE1
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 15:38:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bigeasy@linutronix.de
Date: Tue, 3 Jun 2025 15:38:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1748957884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=APUDEcMzhF5VQylUW/tOF6ir7we8KWNTMBB9e7rnoh8=;
 b=tHQ8kfTxstKVo8VsYMCWRVeuPKgbsRgzAwwRtASfqjSBdE2P4EIR4+Q8p/ZBVyghZOYN3s
 vsNIftxK1lhUnP1YzLCDsG0/+92WU/0niaKwKCQskR2mTu4ibfmFoHS/n4aX4CmY19vodQ
 M30tPBIpBLoPNpVidEPVf32Y74Nrfk2qG+snzf4Y++sxKXTxcpYcerzDKX2HhaMhYpXy5T
 jAenLkCWPeC8guh1DAG3LOA2kx/4MUEBy1rM8R+DpsN5QtT+l1QKApfzR5+wGe1wC0xqmB
 TxXXBS/toFrLr0WiEwlPhqrF6GM4wjLb+3Aj+prFEnpDKwSdVw5L3bILtuUDAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1748957884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=APUDEcMzhF5VQylUW/tOF6ir7we8KWNTMBB9e7rnoh8=;
 b=mJINohNPfTce34Beg4EUXJNdqhfyTeZ/Cr6sUinAt5l0atNTyOkvTmMQRg76oM9OMi+5Ck
 8iFQsrboO4o82tAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Manuel Traut <manuel.traut@mt.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v6] arm: imx: Add support for Mettler-Toledo snowflake
 board
Message-ID: <20250603133802.t1Ui2-vu@linutronix.de>
References: <20250603120223.292889-1-Wojciech.Dubowik@mt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250603120223.292889-1-Wojciech.Dubowik@mt.com>
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

On 2025-06-03 14:02:23 [+0200], Wojciech Dubowik wrote:
> The board is similar to "Kontron SL i.MX 8M Mini" SoM.
> There are two variants. Snowflake_v2 has an external SDCard Interface.
> LEIG is the same but without display and with emmc card only.
> Both variants support 1GiB of main memory.
> 
> [ bigeasy: porting and a bit of cleanup ]
> 
> Signed-off-by: Manuel Traut <manuel.traut@mt.com>
> Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

The Signed-off-by chain looks broken. I had Manuel in From: since he was
the Author. This has been dropped.
Your Signed-off-by should come last, not in the middle. You are the last
one touching it.

Sebastian
