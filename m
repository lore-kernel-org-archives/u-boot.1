Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73BC606A337
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 20:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=M0SGzvIq;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=dMsSS922
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B501C405AD;
	Wed, 25 Nov 2026 20:12:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PKyUxJ9BXFpY; Wed, 25 Nov 2026 20:12:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 126FB405AE
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795637526;
	b=VAt5mvdp+n96tXKJF/JoWZN45GwZ/O3ymYmQCP/fAcAuEUkuFMe3Sr80teNdK5Kui7P7
	 OhupvDBIAa372ea5D7eM3D4g+ZiypC+3mlBU3/3WzI6exkys7R7TI5sgJgx5qjQpaZw5o
	 d9KZdooNqY4LdL1x4hBxdjXD4EKxq3ZcWd6FSgWZRCYIz1U7XIzlHHj+HMYSxBD8Ue7i3
	 pmkf5rkENmSVecn/SDKk5l4jwwRo3XEmoArhLycTPkC/lXOToV1JtpcJCQbXtuDaBir5p
	 H0WFL8uBoH+yPF5+WOIe4I63BsZECbsS/28cWqfUi3V12qhlLxDOVmGqgo9MjjOil0A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795637526;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZOj+wmbfnR4V93/1LXUJrz6FcwePRTn6Ri+meHwW8kY=;
	b=br4CUgK/q82UeFTocMpZ2OoZ0lSk7ALNdWSC+J8EfeUmBJYmvBp5zgj84cTSNhAg3QJg
	 m2js3CwOq7vaqJhX9OP8KK9CVX+sGKtTIeh00ack7NKqSc5MK0cZMjdFgmShzGxpAcLyr
	 CsyZKPBZgLgFt4p8jfySAswMz0pT9TZ0EdsoM0GRS/HdYfyMnrBwTmKyqfQoc7/qwreST
	 3KcXzNHLOLNLA+iyG5eg9agCcf0c6vIhdp6FwtZEaloMYHt2OdVd7F4RRfm/ZA7p/WP17
	 rX3GDKvWYAMcP/SKMvgJ1sCVplbM5f3fkjfykmy5VVOaPnydNe7bLX7JVuMWKfM9F6g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795637526;
	bh=ZOj+wmbfnR4V93/1LXUJrz6FcwePRTn6Ri+meHwW8kY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M0SGzvIqBBXfjoRekFtXRPiH1syT3EfGNHoKvIaMpI2owvUUd9XphYI1ITXtbRM6/
	 8MnhBPdS+2EmBH5mT2fsASg0z0H1m0ufSNmZnvI4Q4XTXZV0kxaLX51IdUFJJA1Ams
	 B2Dr1iB80pKAzYsZ/3gPVnuTyy5x44h15h73+tE/XNnTLWmsYj4AtXrfEmkE97b4vS
	 sq5SVCOju5pwtjpsSyy2re9gjeJIHISBNFWp4nk1iuD8A1+w+rleNo8CKaVZwOCOpq
	 Kl7SQwgSkT9J5IFtaiVTW82LNlRnPhHZOhTCSCKM/y46lW93CLjTM4pwEZMcdtMQZI
	 u3fR+jgGOT+0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 126FB405AE;
	Wed, 25 Nov 2026 20:12:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9C702371
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 20:12:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8D02B80C8B
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 20:12:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 63NzL5om19Ql for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 20:12:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 89B7280C9A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com;
 envelope-from=wqu@suse.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256
 header.s=google header.b=dMsSS922
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 89B7280C9A
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 20:12:02 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c51bf011392so60228966b.3
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 12:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1795637521; x=1796242321; darn=lists.u-boot-project.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZOj+wmbfnR4V93/1LXUJrz6FcwePRTn6Ri+meHwW8kY=;
 b=dMsSS922UVq4/y9ZH/hLgdcPwFKCuv2Ov4K3cC/C+hEcvPKkhrIMDZOl6GSIWCHzSl
 2a4VakShw1PjdO4KcWozTX+HhccN6Rp+/TO6fTcK3ZKFZdBzWYICBa9TFR+ZjFGhw5vb
 BI+Ey3UJIHu59tsyR1xmWRSgFLnrskB/TWEmOrtK+gPN8NfxgQLdM2X8TKZ05k3YF2YA
 sadc8/h6j0Snz1Xqy8QO9BzNNKzVIrAPWFh0HYVYNrUBteGrmoTzJGS/0zOlpOkXYh+K
 KdrskiyMLdQDfr7ekh0pAknvLn+1Gb2s5S9I4faO9Zmkssju0jz5q6IiMVN6ACPgfUeZ
 ffhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795637521; x=1796242321;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZOj+wmbfnR4V93/1LXUJrz6FcwePRTn6Ri+meHwW8kY=;
 b=ycvPBG8J6pZ15MDx6uzoTFtI8vcTIpyF9j+NgFKMYqp0AC3H/wQFjWRXOGXoIuFC2m
 O79VYG3EvPM76q7nVkbQlptSUuNXs6myktWsaMU5IaFkW3QBcodi5c+9wW6tAubwmS7b
 CK+MSp+cplTsvxD3r96F4/xewUmBXIQZYtfQrVr+BXVMmrZRhb1ioWH/yaRM/+7BG1Sr
 zrNHknFQz1I2ZqlJwWttQhbkWWPFhTgC/amcD4Jq9pU6UkXK16o15QvAQQ2Y53FZU7WS
 92ATyHKNDsoeEU8i6P+jTBVU+cESZ46bCld+K6wrO6eLi4m61EXFZZzXZgW0r4JDQbKG
 1n1g==
X-Forwarded-Encrypted: i=1;
 AL+hErHHa3Mri7YJFPZDpU20SsnmdGR06EjnN2wmjRjT6xim+w5DFUz/1Xh65q9w3kdgiWJhdXsLbSU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+O6Zss1eL5FDzRNuxTmCWmrfRYh/DR8FbOGrQX43RWnO/hTqNS
 B+DUiBZPZqok2SAGHJqBeqeXBpd1US44eMiddvfEaZTvjC1Uftjx3IjRafIUzcdvlPI=
X-Gm-Gg: AZFdTZeRectbztq3oiNI8qMb7nz7Lm8E+vUvMS56kE7WcfDHj8m6oHXhI5y8tGOGihE
 dJzwIuOM+R2ReI06p3dolkUfrUnbl8E6h2+S6T/kFWuzpIahlcYBxl32Z1VBqvqDJw6aFjx3863
 D72a6XnQU/tSOEkBMme+dDozsoql8QkXVisRo1tki1W6x64qPZ70KEthV0pnYp3hZ5D2Wm9YTgs
 4Bt3eqw1ZSxlAtbwYq31Tc19dAYNANNPnGrOnje7Ox7K+Vz5gkhnDgbzE1WJzRHrCJVMdZRbQf+
 Y2nFUSQXDyA+aRlVhYBFacXI85wL26Tlv5yLwpwE7G8xyx+zAF/BQWXAw1l+1Oc7wim9JGcXyCw
 c98cRfrn3Opx1Av2goibfqsVr0fERYgajT5RzW81PxjdRpR1Qc8n17Euym2+4Iys1wDER0RAVcl
 yiPPJvgJj7w5xsXzdHKwroJR/B/BgBgyQyIWEMNQxn6A07w38wc9NrLEGdUJsUegUQu9EX4pz/z
 atgagUrA9k5wEHa8SrQlD9oHQYJxIOhDDOQ/Y9gwaBf2zIyNiRuxsCNwvztDeG6O0m4Q9FSL9ia
 TvUP/B3m4n5HURJ1SA1GZyUoAaLEFkylSpCsOeHRei0=
X-Received: by 2002:a17:906:12cc:b0:c49:b393:f1ab with SMTP id
 a640c23a62f3a-c513ab33761mr1186252466b.30.1795637521004; 
 Wed, 25 Nov 2026 12:12:01 -0800 (PST)
Received: from [172.16.0.229] ([159.196.52.54])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b40f4312dfsm30679673a91.3.2026.11.25.12.11.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 12:11:58 -0800 (PST)
Message-ID: <71c0ba96-c3de-4c1b-81e1-27f224aaeeb5@suse.com>
Date: Thu, 26 Nov 2026 06:41:52 +1030
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] fs: btrfs: Avoid a 64-bit modulo in __btrfs_devread()
To: Josef Schlehofer <pepe.schlehofer@gmail.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Bradley Morgan <bradley.morgan@linux.dev>, linux-btrfs@vger.kernel.org,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
References: <20261125124259.95636-1-pepe.schlehofer@gmail.com>
 <20261125124259.95636-2-pepe.schlehofer@gmail.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJq3ujyBQkUpLw5AAoJEMI9kfOh
 Jf6o8OIH/0mqW+TQM4m2x3hCsnK+oB4yJH1qnGvIhFF/Lhs48wI02sGh6/4aA0hkCDfd9LHQ
 +ci4FUepZ9y4VS01+oIExbg/8ytzGYTzLtb44jK2GBOBVSJkMiha6jp22XFt7WUkT/tvbreu
 WWdGsaJIRQaZChy7xsMI8lqQ2WdmluZJ4LT0wD3l/l6QU1ZseMGySebdY9sVOQEOJNV7Qj92
 /KOAFNmeZshV/qDI8Iw1RTs6TvLqCcqmlZLCmJkYSVhT1RonWRren8xIRcFEgMe004IDnt7V
 qdQhk/nhTS9x9MBAhMRl0TTE1VKDLvVALsud3iZLrmmtYvwPApzGJk052f0m28vOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJq3ukKBQkUzDspAAoJEMI9kfOhJf6o
 SNsH/1ysUWOKmzY0rGS3ZdS61QgqMGhSWD/EJ4UiPw+xO4l4+GtX0fOAqxqsmBKqje3vyhBa
 Z5o/1Y+gNiN+E6RBcSz4b1TAd78sQ2bvT5DWOvBjeeVxHdiuQMIn4S8xk5ZpySBw5ifjoiuL
 0M33UVtJOzM8yfAeL+d/Rp4leJw72SutjkLyZTG/gJIp4pJGD/kFHn24OLL0IxEcO0gOekNZ
 os5e1R6jAJ2ILk7+MDnvU8wXHcCiVzuDhJLI1tih1uUIE50muHQJWbYuVBbdJeu8WlIDDssx
 UOCxLylNG3gDXV5MhLubPTOpp9OiFc/XC37nvkgEcrlmlOFBv4/NJCbECpo=
In-Reply-To: <20261125124259.95636-2-pepe.schlehofer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



在 2026/11/25 23:12, Josef Schlehofer 写道:
> On 32-bit PowerPC, GCC turns the u64 '%' in __btrfs_devread() into a
> call to __umoddi3(), which U-Boot's private libgcc does not provide.
> 
> The shift by log2blksz on the line above already requires a power-of-two
> block size, so take the offset within the block with a mask.
> 
> Suggested-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
> Cc: Marek Behún <kabel@kernel.org>
> Cc: Qu Wenruo <wqu@suse.com>
> Cc: Tom Rini <trini@konsulko.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/compat.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/compat.h b/fs/btrfs/compat.h
> index 4596b9d1dd3..e6784884835 100644
> --- a/fs/btrfs/compat.h
> +++ b/fs/btrfs/compat.h
> @@ -60,7 +60,7 @@ static inline int __btrfs_devread(struct blk_desc *desc,
>   	int ret;
>   
>   	sector = offset >> desc->log2blksz;
> -	byte_offset = offset % desc->blksz;
> +	byte_offset = offset & (desc->blksz - 1);
>   
>   	/* fs_devread() return 0 for error, >0 for success */
>   	ret = fs_devread(desc, part, sector, byte_offset, size, buf);

