Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59361C5DF87
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 10:55:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D2DD180F11;
	Fri, 21 Aug 2026 10:55:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iyRxsjqURhPx; Fri, 21 Aug 2026 10:55:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787309738;
	bh=FUc5EO0/HyruZIVOx5HHAgHGKNaDrEMDsiGlnw8kXwI=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m3wbzNjxHxsLSeDj3ctapPt8YwaUTozhHfCtFkVakwleWnCAHkThZTMrN3G23giZt
	 c8eCvLryA4+QLa91LRQlaAJlCUsr6AEi58L1oOKYtleXT0fPFShODdNo2zK1BFlda1
	 yrP6LfyFClWFmKAMMpE++N17AM7Jpccvt3xzo1YWyC35ZZUz6alXG7IG6MKwlW6gT4
	 +W5hwjKnTlYkRg96h4AKeqNNazSl/XRReHFPjHvhVIQYAQeCD5MexuP/G2/nmmhitU
	 3p3Jr1U+JzZltu+FPelrPFXoPQYMcrwFazLS2R8Bbwz4uB935Lu4ou2HL3M8e4tZJ4
	 vAvBoE71Qh2dA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1681F80BE6;
	Fri, 21 Aug 2026 10:55:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9CE424B8
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 10:55:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7A80F80BE6
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 10:55:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FdWxtSwl3tgi for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 10:55:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=79.135.106.118;
 helo=mail-106118.protonmail.ch; envelope-from=munzzyy1@proton.me;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=protonmail header.b=mw5g0LEE
Received: from mail-106118.protonmail.ch (mail-106118.protonmail.ch
 [79.135.106.118])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F273480ABB
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 10:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1787309731; x=1787568931;
 bh=FUc5EO0/HyruZIVOx5HHAgHGKNaDrEMDsiGlnw8kXwI=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=mw5g0LEE/+9qfQOoNcAN9OFWTNKiKtuOq/z0An4K59PZ0Wvg3iG2VQxOQHgL5viaX
 jOyTWE0i6f9J8EvLcyiv54lDw2TGQN7hE99ioSQJ2j/JMfRqcbrLFF1KBU2u5vuhge
 5HqQE9q72SBl6+wodJntN28MvWI3Z97Ds/NeKdw2Z3SJjPuQ2uhNyo0OVfAFcC2wMZ
 so3y9++KMzeCMu6V/q5JrQqNnTsbHKY5YDWv/e5gEUNv4eaX9NPE8Hy1yjPWchRIF3
 CRhvU8dfcZBXo0WkQ1xJpAYYNWSqF5KiI9fixTzQvOepXpifwkQVJOrhdKu91Rf8Pf
 rrzUUVNvgkkfA==
Date: Fri, 21 Aug 2026 10:55:25 +0000
To: Quentin Schulz <quentin.schulz@cherry.de>
From: Cole Munz <Munzzyy1@proton.me>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, Alexey Charkov <alchark@flipper.net>
Subject: Re: [PATCH v2 2/2] spi: rockchip: skip the unused FIFO direction on a
 one-wire device
Message-ID: <20260821105513.830048-1-Munzzyy1@proton.me>
In-Reply-To: <9ce1174c-fabe-4618-bcaa-7edfd0b09d56@cherry.de>
References: <cover.1787238071.git.Munzzyy1@proton.me>
 <9ddf5b446d236c42e39aef5c7dae9bc359dff694.1787238071.git.Munzzyy1@proton.me>
 <3a8bdd54-3ebc-4659-928b-ea2f88cc22c3@cherry.de>
 <20260820170026.117260-1-Munzzyy1@proton.me>
 <9ce1174c-fabe-4618-bcaa-7edfd0b09d56@cherry.de>
Feedback-ID: 209578162:user:proton
X-Pm-Message-ID: bf98d5f2cd9eeb9a5708ecbef129abec0a922e98
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Quentin,

On 8/21/26 12:12 PM, Quentin Schulz wrote:
> Are you sure? The controller needs to tell the peripheral which data
> it's interested in. Therefore, the peripheral cannot send data to the
> controller until it knows what it wants?

At the protocol level you're right. The peripheral has nothing useful
to say before it sees a command. At the controller level TMOD_TR still
shifts POCI into the RX FIFO on every frame no matter what the
peripheral drives. The existing loop depends on that: toread counts
down todo bytes even for write-only transfers where in is NULL and
every byte is discarded. If the RX FIFO stayed empty there the loop
would hang today.

> The controller has 64x 16b-wide RX and TX FIFOs, so my reading of the
> TRM means that you can have up to 64 16b data pending in RX and/or TX
> FIFOs. So I'm not sure "pacing" is the correct term here.

Fair, pacing was the wrong word. Writes run ahead into the FIFO and
nothing slows them down. The RX drain gates the loop exit instead. The
last RX byte only lands once the last frame has clocked, so in TMOD_TR
the loop cannot exit before the wire is done. In TMOD_TO that gate is
gone and wait_till_not_busy() is all that remains. Same conclusion as
yours.

> If we agree on this, then I think
> it's more appropriate to reword the comment just before
> rkspi_wait_till_not_busy() to specify we wait till the TX FIFO has been
> sent over the wire before starting a new transfer as disabling the
> controller will clear all FIFOs.

Agreed. v4 shrinks the toread comment to your one sentence and rewords
the one above rkspi_wait_till_not_busy() to say the TX FIFO can still
hold unsent data and disabling the controller clears the FIFOs. Thanks
for digging into the TRM.

Cheers,
Cole

