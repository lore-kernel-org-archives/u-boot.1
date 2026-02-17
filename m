Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3FA0E68156
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 09:50:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF7E183981;
	Tue, 17 Feb 2026 10:50:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="rAll4mOO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BA0283C32; Tue, 17 Feb 2026 10:50:28 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB9D18063E
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 10:50:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9494B60126;
 Tue, 17 Feb 2026 09:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE144C4CEF7;
 Tue, 17 Feb 2026 09:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771321824;
 bh=F/Mj/faGVgkEigBily7ty/pejSrjeU4kM/u1+nmfuTc=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=rAll4mOOjJkHEa0NP1KYfBaH5TFGbILrCY2ZU2QJlUdV5lJqPcuPq94e2Yq2pOQR2
 bWKXdijVlp2JDbxbPs2mRdP2gLR7rZSqVdW7ne5msZd8obew+01xPyh7p2i2QCihov
 FbNIQF8WMrOn3co99DjBeHVTyn8eN1v8Iev0rJ0XfsJ6OUYIOGsTww0K7FjY40Q3OF
 FoSTYlNcPNbf9nTZri2iVHv8U4ZmWkOZJxq2HgvXcBmt+M89iTCdRaeOgupMOa9jQq
 kPq8nBUfvLWwTdlJOpH8CFbUb6bTjQz/jB5Mp5LIF+zpEL/jZylWtnAYLInznDxfTn
 1GfpwBNXhPOOw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Jaehoon Chung
 <jh80.chung@samsung.com>, Jerome Forissier <jerome.forissier@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Peng Fan
 <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH] cmd: mmc: Drop trailing space in Name: before newline
In-Reply-To: <20260208145142.10341-1-marek.vasut+renesas@mailbox.org>
References: <20260208145142.10341-1-marek.vasut+renesas@mailbox.org>
Date: Tue, 17 Feb 2026 10:50:21 +0100
Message-ID: <87ms17k8bm.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Marek,

Thank you for the patch.

On Sun, Feb 08, 2026 at 15:51, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:

> The Name: line of 'mmc info' command prints a trailing space before
> newline. This is not useful and shows up as trailing space e.g. when
> the output is checked into documentation. Remove the trailing space.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Jerome Forissier <jerome.forissier@arm.com> <jerome@forissier.org>
> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Yao Zi <me@ziyao.cc>
> Cc: u-boot@lists.denx.de
> ---
>  cmd/mmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/cmd/mmc.c b/cmd/mmc.c
> index 6cb1ef5dc23..81b1ca4ad84 100644
> --- a/cmd/mmc.c
> +++ b/cmd/mmc.c
> @@ -29,12 +29,12 @@ static void print_mmcinfo(struct mmc *mmc)
>  	printf("Manufacturer ID: %x\n", mmc->cid[0] >> 24);
>  	if (IS_SD(mmc)) {
>  		printf("OEM: %x\n", (mmc->cid[0] >> 8) & 0xffff);
> -		printf("Name: %c%c%c%c%c \n", mmc->cid[0] & 0xff,
> +		printf("Name: %c%c%c%c%c\n", mmc->cid[0] & 0xff,
>  		(mmc->cid[1] >> 24), (mmc->cid[1] >> 16) & 0xff,
>  		(mmc->cid[1] >> 8) & 0xff, mmc->cid[1] & 0xff);
>  	} else {
>  		printf("OEM: %x\n", (mmc->cid[0] >> 8) & 0xff);
> -		printf("Name: %c%c%c%c%c%c \n", mmc->cid[0] & 0xff,
> +		printf("Name: %c%c%c%c%c%c\n", mmc->cid[0] & 0xff,
>  		(mmc->cid[1] >> 24), (mmc->cid[1] >> 16) & 0xff,
>  		(mmc->cid[1] >> 8) & 0xff, mmc->cid[1] & 0xff,
>  		(mmc->cid[2] >> 24));
> -- 
> 2.51.0
