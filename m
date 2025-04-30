Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C7BC369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 12:19:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAF2F82B45;
	Wed, 30 Apr 2025 14:19:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="TmOhaCTG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B991682B16; Wed, 30 Apr 2025 10:31:57 +0200 (CEST)
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk
 [78.40.148.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 507AF82B07
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 10:31:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=codethink.co.uk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap5-20230908; h=Sender:MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
 :Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7FGthCEC/U48uLWnxuJF3Lz7D4qopFC8exN86774uFQ=; b=TmOhaCTGGRbJ7zs4UtW3XDy1iZ
 +EMkjTXoH9NZjGCVVjLo762HMI/elqLPD3faDa9sW+8f8WzpKqnO8pPAuOq7pNHhaPDse7bZLOyl3
 InlCdYDvU+UJvQSXumGWrhsrF4cDsg5+ukrVZ8R+YRV9uiLsNvG5bsBoNwH05Utm+nKO/q86e0HhC
 82bF7MQiuSpznsqwt8XRz4xFjE6dMhVN/r2mP/QxgHxsZ1cO/x7kR4F2hjXq9V5ThN3q+znWWg7nn
 IDaXOSSjzEDKCa00ajz+VybAEdXjuLaBWbyqtLS124uN98IpoCsD+s4fj0+BPwZqlT3nqoQ4Fgkk8
 M6jcBntQ==;
Received: from [178.38.100.64] (helo=[10.10.1.154])
 by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1uA2r9-004Xps-2q; Wed, 30 Apr 2025 09:31:52 +0100
Message-ID: <38a3f622ac70ee53465180d7e18e031b3736d214.camel@codethink.co.uk>
Subject: Re: [PATCH] common: board: fix build condition of noncached memory
 initcall
From: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>
To: Weijie Gao <weijie.gao@mediatek.com>, u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Jerome Forissier <jerome.forissier@linaro.org>
Date: Wed, 30 Apr 2025 10:31:50 +0200
In-Reply-To: <20250429020424.48795-1-weijie.gao@mediatek.com>
References: <20250429020424.48795-1-weijie.gao@mediatek.com>
Organization: Codethink
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 (by Flathub.org) 
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 30 Apr 2025 14:19:14 +0200
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

Hi Weijie

Thanks for fixing this :)

On Tue, 2025-04-29 at 10:04 +0800, Weijie Gao wrote:
> CONFIG_SYS_NONCACHED_MEMORY is defined as hex, not bool. It should be
> replaced with CONFIG_SYS_HAS_NONCACHED_MEMORY when switched from #ifdef t=
o
> CONFIG_IS_ENABLED().
>=20
> Fixes: 6c171f7a184 (common: board: make initcalls static)
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>

Tested-by: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk> # rock5b

> ---
> =C2=A0common/board_r.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/common/board_r.c b/common/board_r.c
> index bc6fd6448c2..b90a4d9ff69 100644
> --- a/common/board_r.c
> +++ b/common/board_r.c
> @@ -639,7 +639,7 @@ static void initcall_run_r(void)
> =C2=A0#if CONFIG_IS_ENABLED(CONSOLE_RECORD)
> =C2=A0	INITCALL(console_record_init);
> =C2=A0#endif
> -#if CONFIG_IS_ENABLED(SYS_NONCACHED_MEMORY)
> +#if CONFIG_IS_ENABLED(SYS_HAS_NONCACHED_MEMORY)
> =C2=A0	INITCALL(noncached_init);
> =C2=A0#endif
> =C2=A0	INITCALL(initr_of_live);

Cheers

Marcel
