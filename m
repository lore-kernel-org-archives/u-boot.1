Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF25ECDB479
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 15:24:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDFB38460E;
	Wed, 24 Jun 2026 17:24:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="hXL9mTzI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68E3F847C8; Wed, 24 Jun 2026 17:24:05 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46F4180398
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 17:24:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 86D06C6B3B3;
 Wed, 24 Jun 2026 15:24:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 58668601C5;
 Wed, 24 Jun 2026 15:24:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id AB949106C8373; 
 Wed, 24 Jun 2026 17:24:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782314641; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=7VUY9GJUVwTvK7gNnb69fS1YcHgTh2/r4wr02MUuJRk=;
 b=hXL9mTzIphrKpIQZcEOthw+LKe+pPzO/k28p+TotplpnVJWA2eWYVDBKkZ7YlpWe5Mq71U
 Zfi31YF0InHLbD2nB7kixI2R8xniVQCLZBZNzdQuaXqHkTrmi5Vq5UlwKSbOHVYY7KMMko
 ndMu7pW+q4EsQ5hDxrscQ8lfvsVVa6vuW4v5384b2FIUB2QPpFRA5KcGYFK3tdUyLFhHrk
 olaFiITcyGpIoAyWAK6gi3YgPbTEAzswU69SfGihjjWddOJR24PSGoFBW3Ssi+pQ2EGTC+
 LWsRZzE6DkXIs8EnZq8eEYbyraTx4hOBiZYp8abfoUQDXwtJ8+PqnP9AIObO7Q==
Message-ID: <1bfb8b3a-5204-47ef-9aa7-fc5748248453@bootlin.com>
Date: Wed, 24 Jun 2026 17:23:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] fs/squashfs: fix dirs->entry leak on inode lookup
 failure
To: Allan ELKAIM <allan.elkaim@gmail.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Joao Marcos Costa <jmcosta944@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20260611094353.722555-1-allan.elkaim@gmail.com>
 <20260611094353.722555-4-allan.elkaim@gmail.com>
Content-Language: en-US, fr
From: Richard GENOUD <richard.genoud@bootlin.com>
Organization: Bootlin
In-Reply-To: <20260611094353.722555-4-allan.elkaim@gmail.com>
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
> In sqfs_search_dir(), when sqfs_find_inode() fails to locate the inode
> of a directory entry just returned by sqfs_readdir_nest(), the function
> returns directly while dirs->entry still holds the entry allocation,
> leaking it. The bare return also bypasses the regular error path.
> 
> Free the entry and leave through the out label instead, consistent
> with the other error paths in this function.
> 
> Signed-off-by: Allan ELKAIM <allan.elkaim@gmail.com>
> ---
> 
> Changes in v2:
> - New patch, fixing a pre-existing leak of the same kind as the ones
>    addressed in patch 2 (suggested by Richard Genoud's review)
> 
>   fs/squashfs/sqfs.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
> index af32d008..df988774 100644
> --- a/fs/squashfs/sqfs.c
> +++ b/fs/squashfs/sqfs.c
> @@ -547,8 +547,12 @@ static int sqfs_search_dir(struct squashfs_dir_stream *dirs, char **token_list,
>   		/* Get reference to inode in the inode table */
>   		table = sqfs_find_inode(dirs->inode_table, new_inode_number,
>   					sblk->inodes, sblk->block_size);
> -		if (!table)
> -			return -EINVAL;
> +		if (!table) {
> +			free(dirs->entry);
> +			dirs->entry = NULL;
> +			ret = -EINVAL;
> +			goto out;
> +		}
>   		dir = (struct squashfs_dir_inode *)table;
>   
>   		/* Check for symbolic link and inode type sanity */

Having a 2nd look at the whole function, it seems that there a lot of:
ret = -Exxx;
goto out;
without freeing dirs->entry

Like here:
			[...]
			if (++symlinknest == MAX_SYMLINK_NEST) {
				ret = -ELOOP;
				goto out;
			}

			sym = (struct squashfs_symlink_inode *)table;
			/* Get first j + 1 tokens */
			path = sqfs_concat_tokens(token_list, j + 1);
			if (!path) {
				ret = -ENOMEM;
				goto out;
			}
			/* Resolve for these tokens */
			target = sqfs_resolve_symlink(sym, path);
			if (!target) {
				ret = -ENOMEM;
				goto out;
			}
			[...]

It seems to me that we could keep free(dirs->entry):
- in the while (!sqfs_readdir_nest(dirsp, &dent)) loop
- at the end of the for (j = 0; j < token_count; j++) loop
- and before the recursive call to sqfs_search_dir()

And remove all the rest to add something like:
@@ -677,6 +677,10 @@ static int sqfs_search_dir(struct squashfs_dir_stream *dirs, char **token_list,
                 memcpy(&dirs->i_ldir, ldir, sizeof(*ldir));
  
  out:
+       if (ret < 0) {
+               free(dirs->entry);
+               dirs->entry = NULL;
+       }
         free(res);
         free(rem);
         free(path);

(not tested)

What do you think?


Regards,
Richard
