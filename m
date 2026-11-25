Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1C4606A323
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 20:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=G9ObFyEw;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=MtYa0HdB
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CD09040525;
	Wed, 25 Nov 2026 20:14:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kSN6EIQ5YhwT; Wed, 25 Nov 2026 20:14:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1463040505
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795637664;
	b=EhaQ5zkCQemaf7v+Cr8Ks72BghhxR4rBpsRFCYTrvEy2K0F+UKwwKRjEQ0yUUD5wvg6W
	 hI6M12kkPXdJp28BQ9ZAvQgaNZZUYcwJS+3gvMiGb04/LAvCAey+1eEEPxpu/QvElvYx2
	 waO9kxFaLcGsF4s+QqG/27Sqn+y5XnR5s73NVdPFE/vWbFnh7DImy8jSUi6Q8rShrgfYZ
	 0EZDqeRng4/Az+CNNezjp0SYvqLQbOzBJmpm295RWUUgLf8fckXJwf2yMUwXk08NaoPiw
	 ws3HY5Uz2q9rzfkkd+8H+9+jZeZTFhD657OjUTABo5JbaxJswPLnmSUg7V9IwOSWzQA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795637664;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=CHzlAEKEhKAcoRx6ZR9OpUH0lTyUbeq8rOmcJLHcMYs=;
	b=mUOZgl6oXlXYyK99DI0+uMBBGMdi7//F1q78WQISgEBvI/KieMFBoYKmZo6QpWGbVC7E
	 ukRFqeJB9GEKSgCqP3KQaTDouoJpNiS9fpt3Z/ojKySGFnKqxUhrhcZob4Q/wvLCNYsBK
	 fcW8NXdlU/mYsvxwKA6OyYDlTLGwYtMApF5ULgS7QveIfQVsqa7BS8ByMK5azR7HObkKf
	 KiczjmxQqHSoIzSLXF0XDSG7J6q6rE0WIyh+GyRgonDL2CfaxqOkrYaFzkdQuzo24Xb8Z
	 tezkXV9Y8uO6ZZCEG+yWr8Ngl7izRY8mO8JN5mtlvXZ/RRpjYOf1tkQmiafDxLhoMDQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=MtYa0HdB;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795637664;
	bh=CHzlAEKEhKAcoRx6ZR9OpUH0lTyUbeq8rOmcJLHcMYs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G9ObFyEw5rdKi2pi3vNtou2gYzVv57Q2eRLgOkyM5wo9PrByHvL31P7CLb+1GEb7w
	 4QovhR5IA4uWyE5HyPP+rt9fCoGr66TtOyC4eH6g98Gs7oNIQZupEwhO4v6E8oZumQ
	 OXwVyEPvZWnnJ16Ju7TfpeIJDdGCLd1shXD6UMYMIrx/qjQ8xVaLSXuS6Ex6YvleMK
	 Qe5UhbLTglvw2xOPWf5C0h4prkveiEf8f3wLNghbnXkFMfN0zOQOvyYXYOOf58BqTH
	 O0UDsFhGR2l+oTlPo7s7WNBXiAFz9zVmO9N5a527Snrx2r1g3GBTbovaBE881eXDE2
	 cB1zmAmE+zrpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1463040505;
	Wed, 25 Nov 2026 20:14:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 713AE22B
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 20:14:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 62B5B40505
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 20:14:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BY8vOgOc68Bc for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 20:14:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6B768404C8
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=wqu@suse.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256
 header.s=google header.b=MtYa0HdB
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6B768404C8
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 20:14:21 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6b887ca9f5cso8928500a12.0
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 12:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1795637660; x=1796242460; darn=lists.u-boot-project.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CHzlAEKEhKAcoRx6ZR9OpUH0lTyUbeq8rOmcJLHcMYs=;
 b=MtYa0HdB2kpIrP+5GQcIFQ2acHR6mCPwt54QMw8bNFT1bn80KsNUOR3YB23+nu29jv
 fQwyYRjQxuhGkw+IxW7y2LhcPR86msFQGZXmj5Znojb+DGX6qz7zRmjWzjOikkrNqL2U
 WqFDJ016hPXWObF8SFErPyA7aMcAbAc7kB7DUjoTDq6f9dzyJFRRmv7Ljdy8DvDV2FM1
 Fj5FpkE6ACT9uTjhPuexMbLYENlIY2hxOT1+e1XpwUaDTb2HdVOB67hIUC0h+FoJvfC8
 hTuoxvMj+3qKGYV53M0MaoIvXrqFMzRm72kHRFeTJkdUux+2Q41+Pxzg/k5UyHTEFu2d
 L2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795637660; x=1796242460;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CHzlAEKEhKAcoRx6ZR9OpUH0lTyUbeq8rOmcJLHcMYs=;
 b=hriwH+mTxxnlGyXEtEnVlBCrft6VwP+FxT+y9X2ctnZtar/K3YKxISBT+zEUgx+eQv
 9YMAo08AKLT/oqYtONvzrg05pvgqxWDPSw6rgQKWRvoDvKeX07PvknE7yUoG5DcSsGHx
 AOOvizg705s8QR/aeB8rj6abTDtb8tp9ljoH4yxebNqgp4xvYgLc59ra/FIFaN3gUT2U
 LsFWlhvNQbLyzTPxZb6KiZbtP1hOu58VyEoz4wuxtSu4ByMB6j+J/+V6sav4T81/Tn14
 tWz8F0iQf9nzMP+teFc/fRrjf7IUUAjg7r3a23q15AdBs9XcOYejHViVLEjXrjDUbOH2
 eL2w==
X-Forwarded-Encrypted: i=1;
 AL+hErEqR7+Pp780LvrzhDnNXyGkjp9GGahbtdratkPyFEUDztks4zOcrDj1bSnzywDPWLSKQu6uOAw=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+EHlmYCRW7kmEEYezFddRygEfykQMVSHnNGnGuzr82fU9l8oSc
 9xMmo9FwQK75ZLJ1HejDc5W0HQYjhySGmtn8bzfYRHfwnucyJCBuXu7ubhl2ndVpU08=
X-Gm-Gg: AZFdTZeeQ0+fL7N/48/6w1OOLp5CkY9DoLP2XkziuJVG1HmZQKGAca7s51LizfxH1sO
 USacy6RJmdoGcAMVa+qRpkIgyS/SqQN7Mv1kS8/dqaMs3g4pQw/AiXetVmxnV9tGEd++86qUFGj
 xNmdHHO+cCgUh9I7FNVI/oBCOtDPiE6nrmMby7ycwZWPRRZAWByHoDh0jzT+9C0CGtM3w/yR+fH
 4j8PmXhQOGFxvHiwpXsmfcM4hNDC629IJvs1hOpxhFbjLPGjSLUEtaTbUMYnBrpxFO5CUngjZH6
 wJ+L0lrU+W03rIODKzJqGET4QbEpTHp+7n2M3pbESiizpo+8ux/FNEGBOjYb/1CvJZgiQ/HXmxO
 XwvKWQqP1lKnl15d4XkHG6enviS02J8BKBr4wS7/phEU4p0i9TLZEgtXin3bc8mPnEEdEyZpfnm
 ZYVdCrYAoRXGDAmpH9goqTTYWP04PNgC62m1Ag4vVtXXjA/QLQLCZLxwqUgBqh3X4UAihSuomTy
 +B4PYbEqC+XUBXIvbg9hF12CoW3CFd6ygRrw6SRApE4+4wlEJnQ/CoifDN+DJYAQZQQNTG9oADl
 l40/UOt14lhG0LvPNnTFnE7YExk/i6XEUh1AKXE6vq4=
X-Received: by 2002:a05:6402:1941:b0:6ba:7b46:78c3 with SMTP id
 4fb4d7f45d1cf-6ba7b46833cmr10286360a12.22.1795637659120; 
 Wed, 25 Nov 2026 12:14:19 -0800 (PST)
Received: from [172.16.0.229] ([159.196.52.54])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03f0dc13fsm92440295ad.29.2026.11.25.12.14.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 12:14:18 -0800 (PST)
Message-ID: <56a63ebc-1d33-425d-a11f-6d7c73e820be@suse.com>
Date: Thu, 26 Nov 2026 06:44:11 +1030
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] fs: btrfs: Remove the unused dev.c
To: Josef Schlehofer <pepe.schlehofer@gmail.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Bradley Morgan <bradley.morgan@linux.dev>, linux-btrfs@vger.kernel.org,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
References: <20261125124259.95636-1-pepe.schlehofer@gmail.com>
 <20261125124259.95636-6-pepe.schlehofer@gmail.com>
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
In-Reply-To: <20261125124259.95636-6-pepe.schlehofer@gmail.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



在 2026/11/25 23:12, Josef Schlehofer 写道:
> Nothing uses btrfs_devread(), btrfs_blk_desc or btrfs_part_info, which
> are all that fs/btrfs/dev.c defines. On 32-bit PowerPC, GCC turns the
> u64 '%' in btrfs_devread() into a call to __umoddi3(), which U-Boot's
> private libgcc does not provide.
> 
> Remove the file.
> 
> Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
> Cc: Marek Behún <kabel@kernel.org>
> Cc: Qu Wenruo <wqu@suse.com>
> Cc: Tom Rini <trini@konsulko.com>

The removal looks fine to me, however since there are only 
__btrfs_devread() callers, it would make more sense to rename 
__btrfs_devread() to btrfs_devread().

Thanks,
Qu
> ---
>   fs/btrfs/Makefile |  2 +-
>   fs/btrfs/dev.c    | 25 -------------------------
>   2 files changed, 1 insertion(+), 26 deletions(-)
>   delete mode 100644 fs/btrfs/dev.c
> 
> diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
> index 31b426d572a..79d96c6e0ca 100644
> --- a/fs/btrfs/Makefile
> +++ b/fs/btrfs/Makefile
> @@ -2,6 +2,6 @@
>   #
>   # 2017 Marek Behún, CZ.NIC, kabel@kernel.org
>   
> -obj-y := btrfs.o compression.o ctree.o dev.o dir-item.o \
> +obj-y := btrfs.o compression.o ctree.o dir-item.o \
>   	extent-io.o inode.o subvolume.o crypto/hash.o disk-io.o \
>   	common/rbtree-utils.o extent-cache.o volumes.o root-tree.o
> diff --git a/fs/btrfs/dev.c b/fs/btrfs/dev.c
> deleted file mode 100644
> index e27a032c9f6..00000000000
> --- a/fs/btrfs/dev.c
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * BTRFS filesystem implementation for U-Boot
> - *
> - * 2017 Marek Behún, CZ.NIC, kabel@kernel.org
> - */
> -
> -#include <blk.h>
> -#include <compiler.h>
> -#include <fs_internal.h>
> -
> -struct blk_desc *btrfs_blk_desc;
> -struct disk_partition *btrfs_part_info;
> -
> -int btrfs_devread(u64 address, int byte_len, void *buf)
> -{
> -	lbaint_t sector;
> -	int byte_offset;
> -
> -	sector = address >> btrfs_blk_desc->log2blksz;
> -	byte_offset = address % btrfs_blk_desc->blksz;
> -
> -	return fs_devread(btrfs_blk_desc, btrfs_part_info, sector, byte_offset,
> -			  byte_len, buf);
> -}

