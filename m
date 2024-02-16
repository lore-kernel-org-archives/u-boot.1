Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B440AC48BEB
	for <u-boot@archiver.kernel.org>; Fri, 16 Feb 2024 07:29:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0FA787A23;
	Fri, 16 Feb 2024 08:29:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="Crc+9Nib";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A27F487BEE; Fri, 16 Feb 2024 08:29:41 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96003877EC
 for <u-boot@lists.denx.de>; Fri, 16 Feb 2024 08:29:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id CF9A1212F8;
 Fri, 16 Feb 2024 08:29:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1708068573;
 bh=g+TDZMlO9jzHYI3OwXVSMee1HMlsPm9/DEyzmDDxVb8=; h=From:To:Subject;
 b=Crc+9NibJePW4JuBJi7PHFAGwud0jwXDqpa+nqFSWs9bFVhIg/Wk/Sl0+yOkFXJVE
 202YO7pkap/Tk9oA7Y2qTJj3rK/QYnoCTIlmdLLtCCEdVLuHUMvOT6MbzGEuxSqCdv
 kGojOKospEPREWT+YWUCfakyzxJooQH12Co24JUOOkBcHaPXsRkBlb4dalwywJQ769
 Bhw+tnvAO0otTTf3CopqYOMxHdPVPK6ViJ7uBgcx1aP7PBIfTo4pcP2vCZaKoeSvcs
 qbfmtzPtu+B33f8SjlZxJ7HeYe7sL848Ke+RvrppON2RTse22jcSKzsgJoM4xujxLY
 EUAB8XOXldCww==
Date: Fri, 16 Feb 2024 08:29:29 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Sahaj Sarup <sahaj.sarup@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: verdin-imx8mp: Ethernet does not load at boot
Message-ID: <20240216072929.GA4293@francesco-nb>
References: <CAKZ1LvM45MB8N0CqgU+C7i9=Bjb6kqNTxWo2Tv407HKLWtCMkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKZ1LvM45MB8N0CqgU+C7i9=Bjb6kqNTxWo2Tv407HKLWtCMkA@mail.gmail.com>
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

On Fri, Feb 16, 2024 at 10:31:20AM +0530, Sahaj Sarup wrote:
> On a verdin-imx8mp platform I am now unable to use the ethernet ports.
I believe it's a known regression, we are currently working on a fix.

See https://lore.kernel.org/all/e40ed93bd8f371ec56b8fc451dcb458f3ce6dcba.camel@toradex.com/

Francesco

