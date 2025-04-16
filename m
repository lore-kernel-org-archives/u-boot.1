Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98154C369B1
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 07:29:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1D9581E14;
	Wed, 16 Apr 2025 09:29:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="KNiCiooj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC5DE8214B; Wed, 16 Apr 2025 09:29:10 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0864E819FC
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 09:29:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0ED4314831B8; Wed, 16 Apr 2025 09:29:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1744788547; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=lYZNHL11ssJ0+Ulh1ZmhLnbAuuebt9o7MHGD3R4p4Q0=;
 b=KNiCioojltKMw0jhkMxLBKQxGwlU7Z9c1TOTuRzGPON2/lfdjWjNaKZUvbHpZ79BmeTz0n
 5Ovi9PASubcXYRPBgx9RsBBTNWDx9YZb78I+w7OHxRXNqYRh8fJVF8Od4IHc0IJ5wRASKR
 Oi6jXxuwAkG5RzrR5mZ5M2feHHtrjk5Rmz+CyuwMNRCn5zjfsKvU/sMBNFHN5zyhNIV3Lw
 MNs+agFvEtqZrgK/0BvSe5tJdUJZ/Yyw5WUDjoZrkNVFcAYZcYXC7O6ovib8TdqPlTGb28
 TwJXmT7rUEgWX/TCmDtLBA4YnxR5qF4Cf3nNvxjVHwP0MaVThuC7gOdJt8pRgw==
Date: Wed, 16 Apr 2025 09:29:04 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Neha Malcom Francis <n-francis@ti.com>
Cc: trini@konsulko.com, sjg@chromium.org, u-kumar1@ti.com, afd@ti.com,
 vigneshr@ti.com, devarsht@ti.com, quentin.schulz@cherry.de,
 j-choudhary@ti.com, jonas@kwiboo.se, richard@nod.at,
 raymond.mao@linaro.org, m-chawdhry@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/2] doc: memory: Add documentation for system RAM
Message-ID: <Z_9cQJDHEqy29zW-@ada-pc.thorsis.com>
Mail-Followup-To: Neha Malcom Francis <n-francis@ti.com>,
 trini@konsulko.com, sjg@chromium.org, u-kumar1@ti.com, afd@ti.com,
 vigneshr@ti.com, devarsht@ti.com, quentin.schulz@cherry.de,
 j-choudhary@ti.com, jonas@kwiboo.se, richard@nod.at,
 raymond.mao@linaro.org, m-chawdhry@ti.com, u-boot@lists.denx.de
References: <20250319140327.301266-1-n-francis@ti.com>
 <20250319140327.301266-3-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319140327.301266-3-n-francis@ti.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3
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

Moin,

Am Wed, Mar 19, 2025 at 07:33:27PM +0530 schrieb Neha Malcom Francis:
> Add documentation for system RAM utilization in U-Boot.
> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>  .gitattributes                        |   1 +
>  doc/develop/memory.rst                | 158 +++++++++++++++++++++++++-
>  doc/develop/pics/spl_after_reloc.svg  | Bin 0 -> 193600 bytes
>  doc/develop/pics/spl_before_reloc.svg | Bin 0 -> 224608 bytes

Had a look at the first svg.  It's just some rectangles, arrows, and
text.  This should _not_ be ~200k but really small not much more than
20k!  Actually there are pixel images embedded in your grahipcs
instead of just using text.  This is contradicting a vector image
format, please invest some time for proper graphics instead of
throwing bmp cloaked as svg to git as binary.

>  4 files changed, 158 insertions(+), 1 deletion(-)
>  create mode 100644 doc/develop/pics/spl_after_reloc.svg
>  create mode 100644 doc/develop/pics/spl_before_reloc.svg
> 
> diff --git a/.gitattributes b/.gitattributes
> index 7a7c4163560..735b13da278 100644
> --- a/.gitattributes
> +++ b/.gitattributes
> @@ -6,3 +6,4 @@
>  *.ttf binary
>  *.gz binary
>  *.png binary
> +*.svg binary

nack, svg is by definition no binary format.

Greets
Alex
