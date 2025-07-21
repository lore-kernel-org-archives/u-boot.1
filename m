Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97363C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 09:21:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C79C383087;
	Mon, 21 Jul 2025 11:21:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Wjs4QobC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 085598309A; Mon, 21 Jul 2025 11:21:24 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8810582DA1
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 11:21:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id DEA5D5C5B3B;
 Mon, 21 Jul 2025 09:21:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06075C4CEED;
 Mon, 21 Jul 2025 09:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1753089679;
 bh=0ndwHuks5IdDKrAvjtY1XF15ffQA5Y1nrbN0En6Bjnk=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=Wjs4QobCcKDFNDNUcynCqD3KGzoCuh5yB5eRITdg8acVfkYoPiHlGZFWZXtj5rYOH
 ebIE76SdDTsrudnYBOqdusqd7H734fgL2v2GvMQptiCSHGySs9wv64BHPGN6ICU2NI
 XXTO2BVJyMrcxd3ke6KaeSXCv7iUMjVQwkizI3WJEDdDWypJVB9RFa2gh2n1gXc1sa
 Zo1R8QaYRqpiLFpLiP1sqV/fPSNzkznkmvPG05g4JZrDpyOm8VmilqyDptUVBXTWBT
 sudLTlpD/nd9uhd0eVjf8nX+GhUqLlc9n9164NhqmAvEoRacfnQo5dKLBt9Kh622ZG
 rtLHsjnScpJiA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Martin Herren <sputnik@on-the-web.ch>, u-boot@lists.denx.de
Cc: Martin Herren <sputnik@on-the-web.ch>, Michal Simek
 <michal.simek@amd.com>, Leo Yu-Chi Liang <ycliang@andestech.com>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Peter Robinson
 <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH 2/4] riscv: Set SYS_BOOTM_LEN default to 0x4000000
In-Reply-To: <20250719214650.214931-3-sputnik@on-the-web.ch>
References: <20250719214650.214931-1-sputnik@on-the-web.ch>
 <20250719214650.214931-3-sputnik@on-the-web.ch>
Date: Mon, 21 Jul 2025 11:21:16 +0200
Message-ID: <87ldohlx0z.fsf@kernel.org>
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

Hi Martin,

Thank you for the patch.

On Sat, Jul 19, 2025 at 23:46, Martin Herren <sputnik@on-the-web.ch> wrote:

> This changes the default value to the most commonly used one among
> existing defconfigs.
>
> Acked-by: Michal Simek <michal.simek@amd.com> # xilinx_mbv
> Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
>
> Signed-off-by: Martin Herren <sputnik@on-the-web.ch>

Minor note: there should *not* be a newline between the tags that you
applied (Acked-by, Reviewed-by) and your own sign-off. So the footer
block should be:

"""
    Acked-by: Michal Simek <michal.simek@amd.com> # xilinx_mbv
    Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
    Signed-off-by: Martin Herren <sputnik@on-the-web.ch>
"""

I don't think you need to resend for this, usually the maintainer who
picks up your patch will fix this.

Also:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>


> ---
>
> (no changes since v1)
>
>  boot/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 2ff6f003738..54ef7052c5c 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -1057,7 +1057,7 @@ config SYS_BOOTM_LEN
>  	hex "Maximum size of a decompresed OS image"
>  	depends on CMD_BOOTM || CMD_BOOTI || CMD_BOOTZ || \
>  		LEGACY_IMAGE_FORMAT || SPL_LEGACY_IMAGE_FORMAT
> -	default 0x4000000 if PPC || ARM64
> +	default 0x4000000 if PPC || ARM64 || RISCV
>  	default 0x1000000 if X86 || ARCH_MX6 || ARCH_MX7
>  	default 0x800000
>  	help
