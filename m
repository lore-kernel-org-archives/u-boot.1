Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF78C36008
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 04:31:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4971680F70;
	Tue, 25 Mar 2025 05:31:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="Vmy+vU4Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C65B881026; Tue, 25 Mar 2025 05:31:09 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A86F980EEF
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 05:31:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 5152725D47;
 Tue, 25 Mar 2025 05:31:07 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PbVvy_jIzOLr; Tue, 25 Mar 2025 05:31:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1742877066; bh=MKBT+aG2a3VP6FOt4AT844JlGA/jhyKdxgffTLxXxm4=;
 h=Date:From:To:Subject:References:In-Reply-To;
 b=Vmy+vU4QyLfGGpyveSf6X3iXUbUt4NG9yTu22u+JycUj8rv30soByNZf+SBfRt67P
 X7uFXZq7InHGkN/tl7paHdIclF2ufKQXNhxFVUeVz8wv7EhHpJmi5v9bqu2Jvb+vhn
 92PkKvSnaUKC0rwX088M35SBwF9d26MDJyBavNgMkQS7bL/6jW9GYUbanCJeMdXVDs
 SGZu1VueBbQZARcTtTCWNrV5WX+Svsz0XfPs7PALPosV5ESnDF/JRhBXiZKQ7/JfJ7
 DxFKY+4Kgt5X5KQhExzgEgOqJGiBoTtWCqtuuxZKAYRugpxaOKfrvFypMCNEaFjeZR
 TeQB25r56WV3w==
Date: Tue, 25 Mar 2025 04:30:58 +0000
From: Yao Zi <ziyao@disroot.org>
To: "." <ytbeht@gmail.com>, u-boot@lists.denx.de
Subject: Re: Problem with UART in U-Boot.
Message-ID: <Z-Ixgt-evkBsytmB@pie>
References: <884baea7-dbe4-487a-9e14-ccb253166f52@Canary>
 <e0f4a8be-f08b-469b-b16c-b8b56ba0c526@Canary>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e0f4a8be-f08b-469b-b16c-b8b56ba0c526@Canary>
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

On Sat, Mar 22, 2025 at 06:49:11PM +1000, . wrote:
> Device: Orange Pi 5.
> > U-Boot is installed in the SPI memory. I connected the device to my laptop via UART, CH340G adapter, 1500000 baud rate. Connected: gnd-gnd, tx-rx, rx-tx.

Are you sure your serial adapter works at the same voltage level as your
board? It sounds like an electrical/hardware problem instead of fault of
U-Boot code.

> > As a result, when connecting a more powerful power supply, the output to the terminal works, but the input does not work from the word at all.
> > When connecting a less powerful power supply, the input works partially: there was an inscription like "press any key to interrupt startup", I pressed Enter and everything worked, but when I tried to enter something, either question marks (�) were entered, or nothing was entered, or even the text was erased.
> >
> > When installing EDK2-RK3588 (UEFI) instead of U-Boot, both input and output worked on any power supply, and everything worked fine, the speed was the same — 1500,000 baud, and the same adapter.
> >
> > It is necessary to install U-Boot. Can you tell me how to fix the input in U-Boot? Version v2025.01.
>    - 0 '

Thanks,
Yao Zi
