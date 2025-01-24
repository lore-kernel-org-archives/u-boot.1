Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC3FCC02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 13:31:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29CA8807E4;
	Fri, 24 Jan 2025 14:31:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="KiT++mml";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7254807FE; Fri, 24 Jan 2025 14:31:32 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C963680780
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 14:31:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BD33A1481677; Fri, 24 Jan 2025 14:31:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1737725490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Oxju3YTaccJfOkd8SvQHcOY+TtkbpQnq3P9smLdtaMM=;
 b=KiT++mmlwhGF67/BDZmSmg+QCxK/9qUdfbXvZiGmA/7fUXZ8gYstSgDEn0r4gZ/yAaYdmv
 Fia9r799VJTw5MVbop9K6toqXAbbjVv+FoiRwOJttTUENuonuV0VMneHgWrbVVQkV2HIc0
 vmOBhAzlkrrEW/klphLKwPvCw65TgV7S4DOSfw7ByFh+n9C3fkfn/XxonC7Sqrfk+sYfWP
 mIvTGtRZpDj/hQLwqESRew2TQC8xQ4XPpa24eBceJXq0zsLJPQqCobHDFRksz+K1t9nMj6
 cHl+WlwGtuX8TTocDHyCwXdrdmkwy0RBkSXFs1SJlfKQbaZ0Q0qavwtcBpZ4zA==
Date: Fri, 24 Jan 2025 14:31:27 +0100
From: Alexander Dahl <ada@thorsis.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] fs: ubifs: Remove unnecessary assignment
Message-ID: <20250124-capacity-deem-c48dca188c21@thorsis.com>
Mail-Followup-To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de,
 git@xilinx.com, Tom Rini <trini@konsulko.com>
References: <f3ee698c9d5b43bb3b7e2a3cffa1b1b3151c59b9.1737724676.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3ee698c9d5b43bb3b7e2a3cffa1b1b3151c59b9.1737724676.git.michal.simek@amd.com>
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

Hello Michal,

Am Fri, Jan 24, 2025 at 02:17:57PM +0100 schrieb Michal Simek:
> Variable self assignment has been found by clang. But Linux kernel already
> fixed this problem by commit 2a068daf5742 ("ubifs: Remove unnecessary
> assignment") and commit ae4c8081eb77 ("ubifs: remove unnecessary
> assignment").
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>  fs/ubifs/recovery.c | 1 -
>  fs/ubifs/scan.c     | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/fs/ubifs/recovery.c b/fs/ubifs/recovery.c
> index 6b6884fb2098..12c0575cc976 100644
> --- a/fs/ubifs/recovery.c
> +++ b/fs/ubifs/recovery.c
> @@ -439,7 +439,6 @@ static void clean_buf(const struct ubifs_info *c, void **buf, int lnum,
>  {
>  	int empty_offs, pad_len;
>  
> -	lnum = lnum;
>  	dbg_rcvry("cleaning corruption at %d:%d", lnum, *offs);
>  
>  	ubifs_assert(!(*offs & 7));
> diff --git a/fs/ubifs/scan.c b/fs/ubifs/scan.c
> index 7a6e46df5d90..2335e9e2d256 100644
> --- a/fs/ubifs/scan.c
> +++ b/fs/ubifs/scan.c
> @@ -169,7 +169,6 @@ struct ubifs_scan_leb *ubifs_start_scan(const struct ubifs_info *c, int lnum,
>  void ubifs_end_scan(const struct ubifs_info *c, struct ubifs_scan_leb *sleb,
>  		    int lnum, int offs)
>  {
> -	lnum = lnum;
>  	dbg_scan("stop scanning LEB %d at offset %d", lnum, offs);
>  	ubifs_assert(offs % c->min_io_size == 0);

Wow, these are old, both date back to 2009 in U-Boot.

Reviewed-by: Alexander Dahl <ada@thorsis.com>

Greets
Alex

