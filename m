Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AEC6CD5BB0
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 13:29:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E09B6846FD;
	Fri, 22 May 2026 15:29:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="RsEQa2sY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8946B846FD; Fri, 22 May 2026 15:29:10 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98049846FA
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 15:29:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 4522C1A366A;
 Fri, 22 May 2026 13:29:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 19DBF6003C;
 Fri, 22 May 2026 13:29:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id ED3E41081140A; 
 Fri, 22 May 2026 15:29:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779456547; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=2UUXb+tNHQkfZ2/nqjgCLRE/fmTR5YzWoVQCCMkzBRk=;
 b=RsEQa2sYKSf6543dd7etCsya9DleW9JMUDq2tsgbTFw3pam9MQdcTwlefTHpFDxXzzqZze
 WstPpH/MI8GnJecH+bqIULIWrBQNZUXg5T5fs6IUpJ0IqIez2/JVl4uJeYHpI+Qc6eOGVp
 lfSnpvXJ13dEWV/gDMc03wGY0yeNOA6rn+4/TXVZU2EoDj665LlkUK9oHZ5mc7IJeArrvC
 Jfl8ogNMwGCPxp0YWWAfXoLOKyGCH87jn1GwfGi0tVJhqofYVx8/unu5+KGSghiyBE/H1z
 VfqfTg7Lb0JWCuqxprCWiFFMuVWpO1S0JjzYrL2ZwjUoRb81t2L88H3/uaRcVw==
Message-ID: <4c039e22-4766-4b43-9d01-2f0a31b556fc@bootlin.com>
Date: Fri, 22 May 2026 15:29:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] fs/squashfs: add sqfs_dir_offset() error checks
To: Allan ELKAIM <allan.elkaim@gmail.com>, u-boot@lists.denx.de
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 Joao Marcos Costa <jmcosta944@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tom Rini <trini@konsulko.com>
References: <"CACgNL-F2=KJtZ+gThpx_BuWsn6puqFxK0uLOmnABSS9=rRQmeQ@mail.gmail.com">
 <20260514181854.399679-3-allan.elkaim@gmail.com>
 <20260514181854.399679-6-allan.elkaim@gmail.com>
Content-Language: en-US, fr
From: Richard GENOUD <richard.genoud@bootlin.com>
Organization: Bootlin
In-Reply-To: <20260514181854.399679-6-allan.elkaim@gmail.com>
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

Hi Allan,
Le 14/05/2026 à 20:18, Allan ELKAIM a écrit :
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
> ---
> 
>   fs/squashfs/sqfs.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
> index 07e2bd82..430e9bac 100644
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
> @@ -627,6 +629,10 @@ static int sqfs_search_dir(struct squashfs_dir_stream *dirs, char **token_list,
>   
>   		/* Get dir. offset into the directory table */
>   		offset = sqfs_dir_offset(table, m_list, m_count);
> +		if (offset < 0) {
> +			ret = offset;
> +			goto out;
> +		}
Don't we need to:
	free(dirs->entry);
	dirs->entry = NULL;
here?

>   		dirs->table = &dirs->dir_table[offset];
>   
>   		/* Copy directory header */
> @@ -651,6 +657,10 @@ static int sqfs_search_dir(struct squashfs_dir_stream *dirs, char **token_list,
>   	}
>   
>   	offset = sqfs_dir_offset(table, m_list, m_count);
> +	if (offset < 0) {
> +		ret = offset;
> +		goto out;
> +	}
same here?

>   	dirs->table = &dirs->dir_table[offset];
>   
>   	if (get_unaligned_le16(&dir->inode_type) == SQFS_DIR_TYPE)

Thanks,
Regards,
Richard
