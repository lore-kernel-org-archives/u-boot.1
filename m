Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F9FCDB481
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 14:49:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51F378460E;
	Wed, 24 Jun 2026 16:49:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="bj/DKpJi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D04CA848DC; Wed, 24 Jun 2026 16:49:55 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A06CC80398
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 16:49:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 21CE3C6B3A5;
 Wed, 24 Jun 2026 14:50:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 17050601C5;
 Wed, 24 Jun 2026 14:49:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8D2A3106C8210; 
 Wed, 24 Jun 2026 16:49:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782312592; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=+JWHlbfRX35PV6rEjJ3/XLZHlO61SuaW7GalT0MIpIw=;
 b=bj/DKpJiE1rXWojP0djT9pkM8RttKpTVc6ij2sVWdxrZyiz1x8bqde1Qns5yj91V/ou/6+
 4HVIJtKQkHrXt4RxvESWm/AaE9/vQm/p6yFzWTIRv54xNBomjKIEVqcs1vLTuKdVQUlE/I
 CFjyDdkoxi1CpYkT4OTOIOAgNqmujUpqmVwgQ+gAo9r7dTaDfQ3IthkvtR+vSE9/5FvHAf
 sZMpo6sn1XrO6+zUyVRYpNlKImW4rehfoq+jpO5LC1O7ikyVr7OftIcINn0VH0/5Hj2A6k
 oTl2/qNS23l8IiNjcyTnzllxPYlq9MkCiGPHlupwIE63V8xO/UvLABHb3gJFjw==
Message-ID: <6652f7ee-e479-4b47-b984-435f82879d1a@bootlin.com>
Date: Wed, 24 Jun 2026 16:49:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] fs/squashfs: add sqfs_dir_offset() error checks
To: Allan ELKAIM <allan.elkaim@gmail.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Joao Marcos Costa <jmcosta944@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20260611094353.722555-1-allan.elkaim@gmail.com>
 <20260611094353.722555-3-allan.elkaim@gmail.com>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <20260611094353.722555-3-allan.elkaim@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Le 11/06/2026 à 11:43, Allan ELKAIM a écrit :
> sqfs_dir_offset() returns a negative errno on failure, but three
> call sites in sqfs_search_dir() use the return value as an array
> index without checking for errors first. If the lookup fails,
> dirs->table is set to an invalid address, leading to undefined
> behavior.
> 
> Add negative-value guards after each sqfs_dir_offset() call so
> that any lookup failure propagates cleanly as an error rather
> than producing incorrect results.
> 
> Note: the corresponding sqfs_find_inode() NULL checks and the
> heap exhaustion fix during symlink resolution are applied in
> separate patches.
> 
> Signed-off-by: Allan ELKAIM <allan.elkaim@gmail.com>
> Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

nip-tick: It's more common to put the Acked/Reviewed-by you gathered 
before your Signed-off-by, but IHMO, you don't have to send another 
revision just for that.

Reviewed-by: Richard Genoud <richard.genoud@bootlin.com>


Thanks!
> ---
> 
> Changes in v2:
> - Free dirs->entry and reset it to NULL in the two error paths
>    reachable while a directory entry is held, so a lookup failure
>    no longer leaks the entry (reported by Richard Genoud)
> 
>   fs/squashfs/sqfs.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
> index 07e2bd82..af32d008 100644
> --- a/fs/squashfs/sqfs.c
> +++ b/fs/squashfs/sqfs.c
> @@ -496,6 +496,8 @@ static int sqfs_search_dir(struct squashfs_dir_stream *dirs, char **token_list,
>   
>   	/* get directory offset in directory table */
>   	offset = sqfs_dir_offset(table, m_list, m_count);
> +	if (offset < 0)
> +		return offset;
>   	dirs->table = &dirs->dir_table[offset];
>   
>   	/* Setup directory header */
> @@ -627,6 +629,12 @@ static int sqfs_search_dir(struct squashfs_dir_stream *dirs, char **token_list,
>   
>   		/* Get dir. offset into the directory table */
>   		offset = sqfs_dir_offset(table, m_list, m_count);
> +		if (offset < 0) {
> +			free(dirs->entry);
> +			dirs->entry = NULL;
> +			ret = offset;
> +			goto out;
> +		}
>   		dirs->table = &dirs->dir_table[offset];
>   
>   		/* Copy directory header */
> @@ -651,6 +659,12 @@ static int sqfs_search_dir(struct squashfs_dir_stream *dirs, char **token_list,
>   	}
>   
>   	offset = sqfs_dir_offset(table, m_list, m_count);
> +	if (offset < 0) {
> +		free(dirs->entry);
> +		dirs->entry = NULL;
> +		ret = offset;
> +		goto out;
> +	}
>   	dirs->table = &dirs->dir_table[offset];
>   
>   	if (get_unaligned_le16(&dir->inode_type) == SQFS_DIR_TYPE)

