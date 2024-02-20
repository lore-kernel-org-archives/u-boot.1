Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE1F1C48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 08:29:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D72D87F63;
	Tue, 20 Feb 2024 09:29:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="SDNc5TeT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FDAB87F65; Tue, 20 Feb 2024 09:29:17 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5743B87E02
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 09:28:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
 by mail11.truemail.it (Postfix) with ESMTPA id 57DB6225A9;
 Tue, 20 Feb 2024 09:28:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1708417710;
 bh=td1MKoYTi18l5wSyjdXZHOUZ80C8eWg9WjoNiaxC2AE=; h=From:To:Subject;
 b=SDNc5TeTtqWyV89KuWaRMsBtxVClSgeqmHRBD8bTfBfZCTEkLwT06QNyxtxVtxdT7
 xkUP7kX4IjjmiIj0ckZYaZ348mZiqsibvu0nSJ5v0qPwpdyeflBTfSFDrm0hBZZR1R
 86HIRAI1pkQqgKrwZre7SLNwn+hEJf+bi371KA/XbZ1KrxcM6lw8L2d7MmmNSJdc9G
 gmDR45c0onWSmnE/MaAnevvuuHUk4QD1p/TS/DBk5qL6hGzDPMECcvnN2rw4R0cqRo
 Hh1vlw1s2bAnSDeGb+PBUv161D5V5yZ1ngy9G/i/tGztf2PI/QBN7CWp5rTGvrt48N
 8Vzmv66U1sKiA==
Date: Tue, 20 Feb 2024 09:28:23 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Vitor Soares <ivitro@gmail.com>, marcel.ziswiler@toradex.com,
 trini@konsulko.com, u-boot@lists.denx.de,
 Vitor Soares <vitor.soares@toradex.com>
Subject: Re: [PATCH] arm: dts: k3-am625-verdin-r5: Change CPU frequency to
 1000MHz
Message-ID: <20240220082823.GA4685@francesco-nb>
References: <20240219123408.22054-1-ivitro@gmail.com>
 <00d656a1-52f2-4f69-a2dc-6e98347780b2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00d656a1-52f2-4f69-a2dc-6e98347780b2@ti.com>
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

On Tue, Feb 20, 2024 at 10:47:03AM +0530, Vignesh Raghavendra wrote:
> 
> 
> On 19/02/24 18:04, Vitor Soares wrote:
> > From: Vitor Soares <vitor.soares@toradex.com>
> > 
> > The same U-Boot binary is compatible with multiple Verdin AM62 board
> > variants. However, some of the SoC models can only operate at a maximum
> > speed of 1 GHz.
> > 
> > Previously, the boards with lower-speed grades were running at
> > overclocked speeds, leading to kernel complaints about unsupported
> > configurations.
> > 
> > To resolve this issue, the operating speed has been decreased to the
> > maximum allowable value across all Verdin AM62 board variants. As a
> > result, there is a regression in overall boot time, increasing by around
> > 200 milliseconds for the faster SoC variant.
> > 
> 
> Patch as such is fine. But one way to avoid boot regression is to fixup
> the clock freq using based on speed grade identified by
> k3_get_speed_grade() and freq mapping table for each letter as show in
> datasheet [0]

Ack. I would still merge this as it is, I think that is conceptually
better to have a safe and valid value in the DT source file.

We can still do the optimization you suggested afterward, we just wanted
to get rid of any potential malfunction because of this overclocking as
soon as possible.

Francesco

