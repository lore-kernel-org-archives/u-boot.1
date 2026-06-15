Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED158CD98C5
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 07:15:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2533A8484C;
	Mon, 15 Jun 2026 09:15:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="b0HFHISo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE9BD84704; Mon, 15 Jun 2026 09:15:44 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B40083FEE
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 09:15:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B58E740940;
 Mon, 15 Jun 2026 07:15:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD7E1F000E9;
 Mon, 15 Jun 2026 07:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781507740;
 bh=vEthmk/Ghx+O1822HOCfnPG0qqma9CcjPOdzUssdhQk=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date;
 b=b0HFHISojJ2M6UixJBjNeUOHy5xoIJSYCivX6Rjau4TvdADiXlGYHpZbCr3iS7pqN
 dGOiARmCt1902RCur0+i5Lw6oZz2EoyNeGP3ARTDu0bgrgIqSEWbTzopag8VQCSfL6
 6wL3KQZjZ0pQw2W6ctwa1y2i9njznc0DZ9uYOYDzLhSs8vPUk0ckmEL8YpTlyPN7fb
 HsOXhO1T9QDHExCNhSStAkeryyg0+yuYr5mdX4xZRYEAYYGdhy2aigJUiNkLTJZic8
 kOq+W/TojTiUPh/cP0oEuiR4xKqOZ0W42M6Mc+nQy1bfPoOF29KTbC6ElGy+wfsjMV
 hbMQUPL/CT2uw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: u-boot@lists.denx.de, Francois Berder <fberder@outlook.fr>
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>
In-Reply-To: <BESP194MB2805BBD03E7C92727F116585DA0D2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
References: <BESP194MB2805BBD03E7C92727F116585DA0D2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Subject: Re: [PATCH] fastboot: Fix blk_dwrite error checking
Message-Id: <178150773763.19584.12915819965555473141.b4-ty@b4>
Date: Mon, 15 Jun 2026 09:15:37 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
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

Hi,

On Sun, 24 May 2026 21:25:47 +0200, Francois Berder wrote:
> blk_dwrite() returns the number of blocks written.
> The code was only checking if the return value was different
> than 0. Hence, partial writes were considered successful.
> Fix blk_dwrite error handling by checking that all blocks
> are written.
> 
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] fastboot: Fix blk_dwrite error checking
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/1bd1d033377796418008e9a2351f18dbdf88940c

--
Mattijs
