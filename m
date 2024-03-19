Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B49CD11C2
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 15:05:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD04587EA8;
	Tue, 19 Mar 2024 16:05:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="pLaZy0+a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AA7487E02; Tue, 19 Mar 2024 16:05:39 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E55B87F0A
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 16:05:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 217151F932;
 Tue, 19 Mar 2024 16:05:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1710860736;
 bh=XNEQuB4f9/fHdF5WzSLfV9fX1Ivg+wrXwL//ribkPIY=; h=From:To:Subject;
 b=pLaZy0+aYmnNOdj0DVsJWfNK+t24p9VC5HU6VFHSwhGG/HYYiDiMrbSVhRCTtMgq3
 TbBZdhg4IqA8byFs1rbkcQ0971KjKgt+4tQXPeneM+xASuNfn2wWPNKc1BZe3hLTqh
 au7kpirmkMeOtpMno+McHjMo3LRlVS6Uj5keVZSPgwcNvIDhu6f8KxsciYTARdyYFQ
 M92pafDkE+Kn+qoQ0Izv75HerYAZupdMh+PbtMUpurJv/4Ei4b8sWncCqkZWZWFjWA
 NTBe15az836Seb/vh5CeIr0NRQu+3DBUJZpJcjrniTTjsiY5kCK6xp+PnwwouJm9ng
 YyJSEw7bu52vQ==
Date: Tue, 19 Mar 2024 16:05:31 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Tom Rini <trini@konsulko.com>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>, u-boot@lists.denx.de,
 Joao Paulo Goncalves <jpaulo.silvagoncalves@gmail.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] arm: dts: k3-am625-verdin-r5: Change CPU frequency to
 800MHz
Message-ID: <20240319150531.GA17472@francesco-nb>
References: <20240319140427.73721-1-jpaulo.silvagoncalves@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319140427.73721-1-jpaulo.silvagoncalves@gmail.com>
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

Hello Tom,

On Tue, Mar 19, 2024 at 11:04:27AM -0300, Joao Paulo Goncalves wrote:
> From: Joao Paulo Goncalves <joao.goncalves@toradex.com>
> 
> The lowest speed grade of Toradex AM62 SoMs is K speed, resulting in a
> max value of 800MHz for the CPU operating frequency. A solution with
> runtime selection of the CPU frequency is already planned to avoid these
> kinds of problems in the future.
> 
> Fixes: 8fb8a6d49977 ("arm: dts: k3-am625-verdin-r5:Change CPU
> frequency to 1000MHz")
> Signed-off-by: Joao Paulo Goncalves <joao.goncalves@toradex.com>

We have a patch ready to make the frequency adjusted at runtime that
should be on the mailing list in a day or so, as suggested by Vignesh,
targetting uboot-next, this one fix should go into master however.

Thanks,
Francesco


