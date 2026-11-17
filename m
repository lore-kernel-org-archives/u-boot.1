Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22262606A332
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=K4p7kZo2;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=xLfezT2j
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED5838116D;
	Tue, 17 Nov 2026 15:09:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1BKxLdZ77CmU; Tue, 17 Nov 2026 15:09:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 21FA281126
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794928148;
	b=AnAuMAKK89iYc/t8xbvXOSL0P/VF7rCjA1H20AT3Tq22zGEC7oZp43bDqJK5qt8voOeP
	 nvmmEVsrg07oQxKG9Z5bVmDUDVoWRH2IcRPXXDUWRCsbx87gp+l768jruRoivbB/Ru6BB
	 MYTkmuidK+Nzl4oqpJ4izZGN8XUrzFoH7zgU1n2EvdoVntTPt+umyHLSCnEWaaPhmQ/M/
	 QeTOAp09RK6MoZ4+gCTsF6vQ9kfrwn2CJUSlbtZm4svAXmGiFVrWykGkHYqx4iXOyus4l
	 C/CQnYRQhAc3Tf9Lr49kg5tlHzzWpHSNnYS/RBsFEtGp3oLyRLxJ4wnmZ45TfgmaylQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794928148;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ifYziuG048AVeQeUn0sg61C6qFGIfGMPfUuybXXJ0eI=;
	b=okhRnaXMB3zsDWaQ96RtVJeAi60kEHOsz7J04QvlWa1WG1yVI07iZuls8A+qqbHEcWxU
	 qNdpp6qEbP/FGqjTw5U93JYUEP4WpK1jw0l35nCT8mNn4RpBPx7bORSR2O4LMTcln9SOP
	 RQeoOL2UOgQz9Y755+tOzvXD2gEzLJDwMlZWgD3OfBQjv9+L3rlNdE0rblGPrXFvFbj/a
	 ZxIGKVxoDqR0o7IQvmZt/+CIL4wWN4WEiOHVD0g4r4LoQQreJ0EwIBw92DNTfQZsQ7YWY
	 9oeaRURG9BeQOtoo1uRn+Ty79KmC6AZwR9XUG5JRUMx74TGJ0nYAVBYGKF+fo1vuF9Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794928148;
	bh=ifYziuG048AVeQeUn0sg61C6qFGIfGMPfUuybXXJ0eI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K4p7kZo2Decu2QwnCp8ZyrmA6a/U+uxhpld+34/24smPJRbp9e47NpTY7Eo3/h0j/
	 5h+W4Dh63S/nFK1HDq2M2rlMeBJJoylnBNKPjXtBg5kBDeUoP8ucpsqAYY0ZoOmhHb
	 4BJ1kj0++zeJZlOmbquMY7iaDOhEfnfsmpEf1FTVAak6KhQjlDOFuzL0J81S7RhJfA
	 QkjgHBJ0PWnTIkXm4QJmyb49sSseWoCWCq1XK84wGzIKrXI8E6fial2nGM2zLLrr8b
	 pL+XMuts7eQPeIr1ycWj+M/CT+BA68gz38sKiYTLOhTXE1ZsMnBGRRwFz8JktayQEt
	 /t2endiSmNIRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 21FA281126;
	Tue, 17 Nov 2026 15:09:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C6E370B
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 15:09:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 62AA2401C2
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 15:09:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XOxhDTiPgFG3 for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 15:09:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0D1E6400BB
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=185.171.202.116
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.171.202.116;
 helo=smtpout-04.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=xLfezT2j
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0D1E6400BB
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 15:09:03 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id CBBA4C4EDBD
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 15:09:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 595D65FD6A;
 Tue, 17 Nov 2026 15:09:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C3ADA11BC0035; Tue, 17 Nov 2026 16:08:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1794928136; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=ifYziuG048AVeQeUn0sg61C6qFGIfGMPfUuybXXJ0eI=;
 b=xLfezT2jVrfR1RfXyws4f5SOs1s2upbDuWOX6VPrYNEMCzMQ/NBpkQKp9OlHHVrDTZ1M2G
 14z2+vhByCxk9jBdwlXTwwlUUs2ymwpxYO+1d8YnXBnO3n50+D6EZBbjjEtmJkbuT9zWvC
 PbhW9jhHchlN6o6MvfphuL6a9Wm9g+FsNtbFpeDpcQY/nzCzDIW+mqkKH42NWr9t6p09RD
 0NnWi1VIv0Z6raFN3cgxUfToBC461pBEh4JkG+Vda/ZbOUVQY3oldgipUJF5B9+joz8Cag
 U2459mNrQEK7ylv8cl7ZM8Q1cvfCIka3tzXbtHD+d9xRBd86q8Dn4n3CxiOuIg==
Message-ID: <59ed1c1b-8fa0-40f2-8141-acbbbe760adf@bootlin.com>
Date: Tue, 17 Nov 2026 16:08:54 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs/squashfs: fix out-of-bounds free() in symlink path
 resolution
To: Dilip Mallavarapu <dilipchowdary21@gmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org,
 Joao Marcos Costa <joaomarcos.costa@bootlin.com>
References: <20261116215757.18682-1-dilipchowdary21@gmail.com>
Content-Language: en-US, fr
From: Richard GENOUD <richard.genoud@bootlin.com>
Organization: Bootlin
In-Reply-To: <20261116215757.18682-1-dilipchowdary21@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Le 16/11/2026 à 22:57, Dilip Mallavarapu a écrit :
> sqfs_clean_base_path() computes the first index to free as
> count - updir - 1, where updir is the number of ".." components in an
> attacker-controlled symlink target and count is the base path depth.
> When a symlink escapes above its depth (updir >= count) the index is
> negative and free(base[i]) is called on pointer-sized values read from
> heap memory before the base_tokens[] array (CWE-590). The caller's
> "if (bc < 0)" guard runs only after the frees.
> 
> Reject the escaping path and free only entries we own.
> 
> Reachable from sqfs_search_dir() when resolving a path through a symlink
> on a crafted squashfs image (e.g. sqfsls host 0 /s/x with /s -> ../x).
> 
While the driver has a real bug that should be fixed, forbidding
/s -> ../x is not right IHMO
We should forbid /s -> ../../x
But at the root level, /s -> ../x is ok and is the same as /s -> x


> Signed-off-by: Dilip Mallavarapu <dilipchowdary21@gmail.com>
> ---
> 
> Changes in v2:
> - Drop the inline explanatory comment (Qu Wenruo, Tom Rini)
>   fs/squashfs/sqfs.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
> index 2092e3c1c71..caa8baecfeb 100644
> --- a/fs/squashfs/sqfs.c
> +++ b/fs/squashfs/sqfs.c
> @@ -391,12 +391,18 @@ free_strc:
>    */
>   static int sqfs_clean_base_path(char **base, int count, int updir)
>   {
> -	int i;
> +	int i, start = count - updir - 1;
>   
> -	for (i = count - updir - 1; i < count; i++)
> +	if (start < 0) {
> +		for (i = 0; i < count; i++)
> +			free(base[i]);
> +		return -1;
> +	}
> +
> +	for (i = start; i < count; i++)
>   		free(base[i]);
>   
> -	return count - updir - 1;
> +	return start;
>   }
>   
>   /*

Thanks!

Regards,
Richard
