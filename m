Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C91CDEDF15B
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 14:10:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17D3683AA9;
	Fri, 13 Feb 2026 15:10:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="Rn99WDTt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39F3183AAB; Fri, 13 Feb 2026 15:10:25 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38C2983015
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 15:10:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 0154E1F995;
 Fri, 13 Feb 2026 15:10:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1770991822;
 bh=eTFAa8ESEh1271PgGO91pR+Oek7cMnQBTfympaw0PC4=; h=From:To:Subject;
 b=Rn99WDTtQzqG34XTqTv8OaHLo5QLXaVsB0j/LZrCkmMU3s4e2uomGhRtXtveFXewy
 o9NgCcGBRTUMCeZVz6jwZVyp3tZdz7GvMCJDOHxLNunW0sjGcxYxYsDXGScvOKSxsr
 Ju3eEJJyKHaMGMaJB+iqbgJm68m5mfCoLtWH8HHJmQJj4o4IMssbA7L+BQmjbX9poK
 EMN8Scs+KnKKfESoTA8SXgy2Fw+ujd+AFbVC++TgWKMHQ8QA6FwNINLUopDR4FeM5S
 CHgVgiiXnWp2wgFAaIUM/d+AFoa9yzZUJgtog0m5dgICFmeHHzk1hAK3MEtm9+TOw6
 tuwDMkuAIqt+Q==
Date: Fri, 13 Feb 2026 15:10:17 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Vitor Soares <ivitro@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>,
 Vitor Soares <vitor.soares@toradex.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] toradex: tdx-cfg-block: add aquila tda4 0223 pid4
Message-ID: <20260213141017.GA61045@francesco-nb>
References: <20260213120200.543875-1-ivitro@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213120200.543875-1-ivitro@gmail.com>
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

On Fri, Feb 13, 2026 at 12:01:59PM +0000, Vitor Soares wrote:
> From: Vitor Soares <vitor.soares@toradex.com>
> 
> Add PID4 0223 Aquila TDA4 Octa 16GB IT to config block handling.
> 
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

