Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72DE3C44501
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 13:38:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32AF484C83;
	Thu, 16 Jul 2026 15:38:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.b="AM3cXAtb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D36384CA3; Thu, 16 Jul 2026 15:38:49 +0200 (CEST)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE19E84C3F
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 15:38:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1784209122; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=cAMAs2qjo6xUWaWFP0gWrjq6cdrSA3ZhutbHqs1nmNz5l3kESNgfAICBcMMcG57FrUZBtCgvBJ+UZqlcot4DidfJzjS6/8bkA7Me/ok2OSXW+Q3ZQCW6M11z4TL6cp1u4UCjYd47tXDrlSgypkqqdlxT9VtqT49jQAnMQO/y28c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784209122;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=84UAuBqH5v/tsKvn2GcpHlgsiau5HQw1ny/3kZI7/Pk=; 
 b=Ay/izNbVfywUfDmOiebcRekM+dWzTz3yrWxLi2/q1xtJk+zUzaY85ejiyaE9tOFpoyFJuJYs0aoasQRBjFfgoZOAx6bv4RyhxviIC/rH29P73wYe/EBbhDyj8eYz4+sjJuGurjbdhp+sEPVkGU2hSkbRCE6Y7JnId6EcaEcuzCo=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784209122; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=84UAuBqH5v/tsKvn2GcpHlgsiau5HQw1ny/3kZI7/Pk=;
 b=AM3cXAtbFnrd+qZ9TVKaurXy4pdoLR1DChUz9N6RHFgjh7Psz/WZFVWcW529vqrH
 rqua5iLGuVaM+a2nbsMBKYEaz2+HlvGW4W7hvoTIZco4IF33vr4ZiF/T7ROVCfDJw84
 viaWHg0U/8xqRe1tIH6JK/1pxarKZygxWWcCzhcg=
Received: by mx.zohomail.com with SMTPS id 1784209118738935.2567743379011;
 Thu, 16 Jul 2026 06:38:38 -0700 (PDT)
Date: Thu, 16 Jul 2026 13:38:25 +0000
From: Yao Zi <me@ziyao.cc>
To: Michael Opdenacker <michael.opdenacker@rootcommit.com>,
 u-boot@lists.denx.de
Cc: Wei Fu <wefu@redhat.com>, Yixun Lan <dlan@gentoo.org>,
 Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH] doc: thead: lpi4a: detail how to enable fastboot
Message-ID: <alje0f_T7MZWfYPg@pie>
References: <20260715-improve-lpi4a-doc-v1-1-4cc045eb59bc@rootcommit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715-improve-lpi4a-doc-v1-1-4cc045eb59bc@rootcommit.com>
X-ZohoMailClient: External
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

On Wed, Jul 15, 2026 at 05:04:04PM +0200, Michael Opdenacker wrote:
> Add that the "BOOT" button must be used
> to switch the board to fastboot mode.
> 
> Signed-off-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
> ---
>  doc/board/thead/lpi4a.rst | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/doc/board/thead/lpi4a.rst b/doc/board/thead/lpi4a.rst
> index acd7ac2698d..3920efcd710 100644
> --- a/doc/board/thead/lpi4a.rst
> +++ b/doc/board/thead/lpi4a.rst
> @@ -91,8 +91,10 @@ OpenSBI firmware and proper U-Boot.
>  Booting
>  ~~~~~~~
>  
> -u-boot-with-spl.bin should be loaded to SRAM through fastboot. Connect
> -the board to computer with Type-C cable and run
> +u-boot-with-spl.bin should be loaded to SRAM through fastboot.
> +
> +To put the board in fastboot mode, press and hold the ``BOOT`` button,
> +connect the board to the computer with a Type-C cable, release ``BOOT`` and run:
>  
>  .. code-block:: bash
>  
> 
> ---
> base-commit: 8dbe57ba648648c4897717cebbc4505a8e0a8c23
> change-id: 20260715-improve-lpi4a-doc-feed8191d37c
> 
> Best regards,
> --  
> Michael Opdenacker <michael.opdenacker@rootcommit.com>
> 

Reviewed-by: Yao Zi <me@ziyao.cc>

Thanks, this is indeed more clear.

Regards,
Yao Zi
