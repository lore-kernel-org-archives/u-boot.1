Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A5E606A31E
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 20:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EetLA6TR;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=C7p44bf6
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E29F560750;
	Wed, 25 Nov 2026 20:15:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5fCoJIem1wag; Wed, 25 Nov 2026 20:15:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 08134606F2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795637741;
	b=harFD9kvVwDN5McaFFbAwVdkiwGPEVHfX0T3vnupJDz3uXsG3ziUu1oMiQkRFA8S3egY
	 C0dTckka5F5xckkJGNKet40q8Qdb6RbWijgKkJE+g/iU+G3rC/wUXnoayBKQY90CkzTeF
	 Pzw8lShzJ5u4VOJSZfvrHdyYGbB67Kh6lWz4PUPaS4ngHJDafkEYoSwKxaTVPvFjYIWe+
	 qFA9HgJVr7RE8HF0nfTUfyPk8ukMV0qg/kXMHqtWkEkOTm9a0Y82kNp2kc5YbUvDBrYvn
	 y36Hu6pXg8SqoJZUpJ9HBZH2fMBgW099KjQcT6Z70VMSmJ1hkaQmlAHVTTcN89BWPWA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795637741;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VjAawZmK4adGquUvf2bKR5vmv5LsHtKaxCEyqp2mZ8Q=;
	b=T9pjeaSx4tY0JTET6WUSISSPBT1MFT3VJ1VFxphvjXbu6N3F7vY9gNqRe2ukKzXd7sV/
	 5nG/IJGavASPGQVo7qBOWvDfbYHLgqdFn5aiG+907WwpV4ejbkzFB1Qa0miFLp4xDris4
	 pZI+g56iWoTyb7qSdl8LOxV+AsuprKWDTCJSBDpsab3MgRLdz4BQMK++mENdMeOMToxz/
	 z625XT5JjS183rlzfmC/d8hfqbR1FZPuV78hV2ujGfTVrc3Rub9RuCO2taZoUaPXBFdAq
	 PJ2BHxY1PWzZswZi/6nY4R0m4M/oOY5WLJo0BgUm8cNBpwOA4+8ZW5EJ/qhMLGucykw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795637741;
	bh=VjAawZmK4adGquUvf2bKR5vmv5LsHtKaxCEyqp2mZ8Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EetLA6TR/RGUv/dhQ2ry1oRta0O4bEy4L00UScM2Ji8pyomJfsYT0RA6GlSf2g8t6
	 nB38IbxCjrTv6m3gDwu6UWseiFfZpRClsABDhZR8zxdYGtF0NuSSxmH/RfiFiJZ97y
	 gPKCYogKw+8IXfgcL7q+ttjjeEPgG57wLA2N7cQAol0UHtSibwGm8zfEVs+PgjbjnH
	 kHjUunpG6ptbZYK5AdugxNNVcRAN/HEqyvAk3Uw4qg81rXKqWS0rJDEnjtIzc2NjXs
	 PHV+rPLklJGOMfANz1Efw+gkwarGWLejZPfBlyTI29nXzZi23OQj5XD0mAe90OglBr
	 E/J+c/OeQtriA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 08134606F2;
	Wed, 25 Nov 2026 20:15:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4415E325
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 20:15:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 355C580C8B
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 20:15:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pkZZ1XBNwokt for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 20:15:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 272D080A82
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com;
 envelope-from=wqu@suse.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com
 header.a=rsa-sha256 header.s=google header.b=C7p44bf6
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 272D080A82
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 20:15:37 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c50aaad19fbso689691366b.0
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 12:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1795637736; x=1796242536; darn=lists.u-boot-project.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VjAawZmK4adGquUvf2bKR5vmv5LsHtKaxCEyqp2mZ8Q=;
 b=C7p44bf6EyGohtbRiVW7KQlVvWZyFa51hyns7oFtyfxYg+nZQSJoJiUBj710PT7+dM
 LFK805KLaIN6MNL3vt+DxCZ43kkbO8mocMbVIUARDrz2QTEqwSuRHFH7CfhQAV5oCJJb
 cFbgaRDaHSLSGrxj4DkyRkvd9OdaWYa5iOGu8Qw6ACWM8lYHXdCfNK/j3rAjX2NZJO9B
 f/IZ45nkTpu+VyFLCYHWQFPgMVvykbl7W9SRddAAsZw4Rmv6uLz5cxMjIcIJto6Oeqhy
 OT+CvJsfMQDM2k6Z2uWn6hpuNnVGqha9yw5bJq6gktp3IyVKO7xYEJl7vxpDItYxkyBs
 Yrvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795637736; x=1796242536;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VjAawZmK4adGquUvf2bKR5vmv5LsHtKaxCEyqp2mZ8Q=;
 b=QhCC/Tw6z8YXJB8gUssW6334+oaArEf4nYEnqelfXxo4wX93RRE9KPLGFrpa0VMO6X
 hlB7b47cXZo/wOMGFZ15TE0MoEOLLbV0b0998TKJFS8NTSQai/lwcaV6nMyt6hjrI1Xf
 5OK241r6hv9Kn8mDmpNxKxLQ6IuFtFOEtUIQdGpLgvAFsS6bPJCyzCpP5b57uz7v8cjE
 i5wA5rVVJKYIcTaD+7ewfLaBd7/70mBBlMfgYRd1vpbD2qRY3i0bXmsHtNAdICVXFskN
 iuyxW15cZsirrZSwxLtOdVDChOb0pMNU+Gsq3moTvrn0rJcXLPoDDsNbOmsQ0YpS06hB
 H0Ng==
X-Forwarded-Encrypted: i=1;
 AL+hErHMISEWs+l+077urQoz+xIJOXHtZOcZP/ZO08GzlsF6Gg7EJcS9+3jPqXqBMB227w4PWyUQvQA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z92gjU/hd3mGHcjZRD8TI3t2blpzJ9UhGKyyh8jwAjb/S28P+ti
 KyWJxeIM108NxnfsS3GAO+1h8Oa5icjWt0W8KU5xmg9KGKG2r1z/xouOOLowUdfnxaRmuZms+RO
 MRMFvWDU=
X-Gm-Gg: AZFdTZfc4nlSVsKKzZl1n9YYEtCWRJeipsYvlsEj+DbzfHcf5y8MWV6bN0NjG6HuG9u
 xfW4dMD07Y3VzbpJHaBOcRd2rgAurmq11rat6egJuQTsRlMPjCAse03mPuYmR51wOv4y71ciNq+
 fWW2+BTMefez9NnNe5p0iqS4I60r8EX7lGNr31TENpW7VFLe5+H8VTs+dptiFo5UXjvf+ZddhJa
 IR+OnwN/gSVnTna1JQkD7cPlaMe3WpXANcOoPtsObnE+I9OdoThJUdeuVLaazB8cpDCysS+nfdC
 EVQflbgKwbJqoOzPBkjVjkmGK37Mf0SxeDmSoJZ9v2S2oT+lS7Yw51wV3uenJBWLPq8BMkD35Uh
 hyAOvgT/5mm3KZIcY+KAtdXm0fW3oBr9aeY3pEnUpnEagwM7nptP/SP1UB6vec2owc8JIIu5sVg
 /WrcrByLG44wIa6mTMLKJIKKsD7urgTVVRK7XFyRHeyNsvvqi1+N26dzrARbc6ZT4sg7firlvDu
 5qsdWFS1LqpwO/qhrcoHEF10a6q0txo+kK1DmiQk8ZNP3o5xVSmXmgOikOaSMsoxeifjPQ7bIuq
 xWjz/eFlwNPIRu38bVE8WTQ=
X-Received: by 2002:a17:907:9692:b0:c48:ddac:7eb1 with SMTP id
 a640c23a62f3a-c513aad95cbmr1548985466b.45.1795637735895; 
 Wed, 25 Nov 2026 12:15:35 -0800 (PST)
Received: from [172.16.0.229] ([159.196.52.54])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f04ed9620esm85182655ad.26.2026.11.25.12.15.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 12:15:34 -0800 (PST)
Message-ID: <ff0e9c8e-051b-424c-a07c-67f99cad1702@suse.com>
Date: Thu, 26 Nov 2026 06:45:29 +1030
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] fs: btrfs: Avoid the remaining 64-bit divisions
To: Josef Schlehofer <pepe.schlehofer@gmail.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Bradley Morgan <bradley.morgan@linux.dev>, linux-btrfs@vger.kernel.org,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
References: <20261125124259.95636-1-pepe.schlehofer@gmail.com>
 <20261125124259.95636-7-pepe.schlehofer@gmail.com>
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
In-Reply-To: <20261125124259.95636-7-pepe.schlehofer@gmail.com>
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
> On 32-bit PowerPC, GCC turns the u64 divisions in btrfs_stripe_length()
> and in the RAID5/6 code of __btrfs_map_block() into calls to
> __udivdi3(), which U-Boot's private libgcc does not provide.
> calc_stripe_length() has the same divisions.
> 
> U-Boot never runs these divisions. btrfs_stripe_length() and
> calc_stripe_length() have no caller, and the RAID5/6 divisions sit in
> the branch that fills a raid map, which needs a raid_map_ret. Both
> callers of btrfs_map_block() set it to NULL. Builds of turris_1x_nor
> and turris_1x_sdcard still link that branch, and with it __udivdi3().
> 
> Use div_u64(). Its divisors fit into 32 bits: num_stripes is a u32 or
> an int and stripe_len is an int. full_stripe_len is the product of two
> ints, so declare it as a u32.
> 
> linux/math64.h pulls in linux/log2.h, whose is_power_of_2() conflicts
> with the copy in compat.h, which returns int instead of bool. Include
> linux/log2.h in compat.h and drop the copy.
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
>   fs/btrfs/compat.h  |  6 +-----
>   fs/btrfs/volumes.c | 19 +++++++++++--------
>   fs/btrfs/volumes.h |  9 +++++----
>   3 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/btrfs/compat.h b/fs/btrfs/compat.h
> index e6784884835..f973f3f1185 100644
> --- a/fs/btrfs/compat.h
> +++ b/fs/btrfs/compat.h
> @@ -4,6 +4,7 @@
>   #define __BTRFS_COMPAT_H__
>   
>   #include <linux/errno.h>
> +#include <linux/log2.h>
>   #include <fs_internal.h>
>   #include <u-boot/uuid.h>
>   
> @@ -74,9 +75,4 @@ static inline void uuid_unparse(const u8 *uuid, char *out)
>   	return uuid_bin_to_str((unsigned char *)uuid, out, 0);
>   }
>   
> -static inline int is_power_of_2(unsigned long n)
> -{
> -	return (n != 0 && ((n & (n - 1)) == 0));
> -}
> -
>   #endif
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 71b0b55b9c6..fcb20a761f5 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2,6 +2,7 @@
>   #include <stdlib.h>
>   #include <errno.h>
>   #include <fs_internal.h>
> +#include <linux/math64.h>
>   #include "ctree.h"
>   #include "disk-io.h"
>   #include "volumes.h"
> @@ -825,17 +826,17 @@ u64 btrfs_stripe_length(struct btrfs_fs_info *fs_info,
>   		stripe_len = chunk_len;
>   		break;
>   	case BTRFS_BLOCK_GROUP_RAID0:
> -		stripe_len = chunk_len / num_stripes;
> +		stripe_len = div_u64(chunk_len, num_stripes);
>   		break;
>   	case BTRFS_BLOCK_GROUP_RAID5:
> -		stripe_len = chunk_len / (num_stripes - 1);
> +		stripe_len = div_u64(chunk_len, num_stripes - 1);
>   		break;
>   	case BTRFS_BLOCK_GROUP_RAID6:
> -		stripe_len = chunk_len / (num_stripes - 2);
> +		stripe_len = div_u64(chunk_len, num_stripes - 2);
>   		break;
>   	case BTRFS_BLOCK_GROUP_RAID10:
> -		stripe_len = chunk_len / (num_stripes /
> -				btrfs_chunk_sub_stripes(leaf, chunk));
> +		stripe_len = div_u64(chunk_len, num_stripes /
> +				     btrfs_chunk_sub_stripes(leaf, chunk));
>   		break;
>   	default:
>   		/* Invalid chunk profile found */
> @@ -1085,17 +1086,19 @@ again:
>   			int rot;
>   			u64 tmp;
>   			u64 raid56_full_stripe_start;
> -			u64 full_stripe_len = nr_data_stripes(map) * map->stripe_len;
> +			u32 full_stripe_len = nr_data_stripes(map) * map->stripe_len;
>   
>   			/*
>   			 * align the start of our data stripe in the logical
>   			 * address space
>   			 */
> -			raid56_full_stripe_start = offset / full_stripe_len;
> +			raid56_full_stripe_start = div_u64(offset,
> +							   full_stripe_len);
>   			raid56_full_stripe_start *= full_stripe_len;
>   
>   			/* get the data stripe number */
> -			stripe_nr = raid56_full_stripe_start / map->stripe_len;
> +			stripe_nr = div_u64(raid56_full_stripe_start,
> +					    map->stripe_len);
>   			stripe_nr = stripe_nr / nr_data_stripes(map);
>   
>   			/* Work out the disk rotation on this stripe-set */
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 9d1a07ae789..d66547c6c10 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -4,6 +4,7 @@
>   #define __BTRFS_VOLUMES_H__
>   
>   #include <fs_internal.h>
> +#include <linux/math64.h>
>   #include "ctree.h"
>   
>   #define BTRFS_STRIPE_LEN	SZ_64K
> @@ -138,16 +139,16 @@ static inline u64 calc_stripe_length(u64 type, u64 length, int num_stripes)
>   
>   	if (type & BTRFS_BLOCK_GROUP_RAID0) {
>   		stripe_size = length;
> -		stripe_size /= num_stripes;
> +		stripe_size = div_u64(stripe_size, num_stripes);
>   	} else if (type & BTRFS_BLOCK_GROUP_RAID10) {
>   		stripe_size = length * 2;
> -		stripe_size /= num_stripes;
> +		stripe_size = div_u64(stripe_size, num_stripes);
>   	} else if (type & BTRFS_BLOCK_GROUP_RAID5) {
>   		stripe_size = length;
> -		stripe_size /= (num_stripes - 1);
> +		stripe_size = div_u64(stripe_size, num_stripes - 1);
>   	} else if (type & BTRFS_BLOCK_GROUP_RAID6) {
>   		stripe_size = length;
> -		stripe_size /= (num_stripes - 2);
> +		stripe_size = div_u64(stripe_size, num_stripes - 2);
>   	} else {
>   		stripe_size = length;
>   	}

