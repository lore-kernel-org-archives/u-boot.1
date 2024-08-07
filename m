Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 984B6C3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 14:55:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D6D888A7F;
	Wed,  7 Aug 2024 16:55:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="G5GIiiLA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4298788D35; Wed,  7 Aug 2024 16:55:52 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [IPv6:2003:a:e28:26e4::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DEA688BFA
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 16:55:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 31D551487439; Wed,  7 Aug 2024 16:55:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1723042549; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=GJl0lEQ7rCOp4BnTU8mGIEoPTI9JmDht2ICzb/0OeBY=;
 b=G5GIiiLAJdYFbRNwbroUgXQrM5cKD1xyaczWK/HbtQVmMfB3ecZQUdSC83Ad2ekU++bpCS
 23zIuRG6s76uNyrpJryc2oCaFhgfxtHBZx+7FUZgeHMceYEefwGFq1S1HtidfNn+WG/+vH
 g9dlEa7BIoYcG9U3aqfV+L4XrnuNjzoxGcpZ96QBAFF+n4Y9aH/Ghv5siHXD4klCZfDSlR
 +YTe0WIflc0hDFUyxjf/VObj4UOhNvn0H2zUwJMvH8NL01pVWiuOQw0LkHnlgd/na9fmfM
 YPTVvsiDrD5e+uXKoK07BCnVl0J6eGSSIYX3uaeLs61AwvII1NP/MVuFb4nKkA==
Date: Wed, 7 Aug 2024 16:55:45 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Heiko Schocher <hs@denx.de>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: [RFC PATCH] ubifs: Call ubifs_iput when ubifs_iget is used
Message-ID: <20240807-pancake-estimate-ea370d7f9dc8@thorsis.com>
Mail-Followup-To: Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@denx.de>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20240805173140.84453-1-michael@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240805173140.84453-1-michael@amarulasolutions.com>
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

Hello Michael,

Am Mon, Aug 05, 2024 at 07:31:40PM +0200 schrieb Michael Trimarchi:
> The inode should be freed after a reference is get to avoid
> memory leak
> 
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>

Tested this on top of my recent ubifs series.  No obvious problems
found on U-Boot command line with various combinations of commands, 
no crashes, so …

Tested-by: Alexander Dahl <ada@thorsis.com>

Greets
Alex

> ---
>  fs/ubifs/ubifs.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ubifs/ubifs.c b/fs/ubifs/ubifs.c
> index 048730db7f..6acd6c3776 100644
> --- a/fs/ubifs/ubifs.c
> +++ b/fs/ubifs/ubifs.c
> @@ -319,9 +319,7 @@ static int filldir(struct ubifs_info *c, const char *name, int namlen,
>  	}
>  	ctime_r((time_t *)&inode->i_mtime, filetime);
>  	printf("%9lld  %24.24s  ", inode->i_size, filetime);
> -#ifndef __UBOOT__
>  	ubifs_iput(inode);
> -#endif
>  
>  	printf("%s\n", name);
>  
> @@ -557,6 +555,7 @@ static unsigned long ubifs_findfile(struct super_block *sb, char *filename)
>  
>  			/* We have some sort of symlink recursion, bail out */
>  			if (symlink_count++ > 8) {
> +				ubifs_iput(inode);
>  				printf("Symlink recursion, aborting\n");
>  				return 0;
>  			}
> @@ -568,6 +567,7 @@ static unsigned long ubifs_findfile(struct super_block *sb, char *filename)
>  				 * the leading slash */
>  				next = name = link_name + 1;
>  				root_inum = 1;
> +				ubifs_iput(inode);
>  				continue;
>  			}
>  			/* Relative to cur dir */
> @@ -575,6 +575,7 @@ static unsigned long ubifs_findfile(struct super_block *sb, char *filename)
>  					link_name, next == NULL ? "" : next);
>  			memcpy(symlinkpath, buf, sizeof(buf));
>  			next = name = symlinkpath;
> +			ubifs_iput(inode);
>  			continue;
>  		}
>  
> @@ -583,8 +584,10 @@ static unsigned long ubifs_findfile(struct super_block *sb, char *filename)
>  		 */
>  
>  		/* Found the node!  */
> -		if (!next || *next == '\0')
> +		if (!next || *next == '\0') {
> +			ubifs_iput(inode);
>  			return inum;
> +		}
>  
>  		root_inum = inum;
>  		name = next;
> -- 
> 2.43.0
> 
