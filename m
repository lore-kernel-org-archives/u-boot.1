Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA86606A33D
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 21:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bmO5f4Vl;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=LBua7rbi
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ECD7780D80;
	Mon, 16 Nov 2026 21:13:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KZwjVFK06KKf; Mon, 16 Nov 2026 21:13:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3DDF480D84
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794863622;
	b=gj1kJTPEw0qwIF2yQlFhpwSjJNFTFG+9m3RbKrpRK7Pir/Na/2tVHhV6/2wxC656852n
	 VYM0w8KwFv4T+kQMYRP4dsGXmb0nyDIHyjFEVNl00qQFMNT3jHwtMgh1zRsHi2iNQg4/D
	 i1QK/de86xNAU/ILwa7Xi3ufnfnfumh53qrc5Phqk216l0sEKAByWSkkkIeCo0b2EG/vM
	 scbecGht7DM3I1lG/fDv0KTxM/i5807DbwYRrEt7WI//1XX5Tcs70Y6hFsAPSF0IGNGBl
	 wULmTVTuCw+flioAQygLRxctS/Zl3aMehei2hAEgO/Gsj8aED0kt11c3z/dbdm/qbOw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794863622;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tTFrccqx7uE8NdUaWA6b7niP8829+N+YTeIPGiFu6Y0=;
	b=g2ukzBeIb8KhrtjdQTY8+3UZYfvhmaaIw5sw893oQlNrg0jUjmjVJEbIqITSGXBgjKWX
	 hB6NjMI/4iX+N0Eb4qS4nX/1o4PtgStTaS/Xc5Tsf3iD5qV46sjqTZDV6D+ZuV10wyym2
	 R7Ei06kcmu3yX6raillOssG3cZ2k9vP+7EryLIX0L6vhNGAFVzuMShXr68JixxlNyXDGh
	 ww7vip0imscFe8UidplKSINZybqbzEoaYgKhuIV24TdZ6ISFRnhe9VInHnbXPMHuULGlj
	 cJXfMaaJViv6tvTTnIswcdbr/NllOQ2uKmGZNYT6HRjwmmILG1p0JPVnqCPDJyWRAaQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=LBua7rbi;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794863622;
	bh=tTFrccqx7uE8NdUaWA6b7niP8829+N+YTeIPGiFu6Y0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bmO5f4Vl8YDDrakvKABFtJTovktRXl4CCWvwPFkmrEyXW7xX7SaKP8hSURMhSIkb8
	 Cq2LX/sWtvu60yLeHeVIjVjM+gsOfq64OnWvjrcx5DmFf1jDvpKdS09E1J5Giyym3H
	 w23rUv5u/YTLPMRtfn6zB+gwk8CdlU7uyGyy/HuUKRQVZUp4TOhYLlOaqRtWCp6WMi
	 JjM/YHNT1eblzuKBdGAtHuNoJYRukxZdflkr8pxHT83PeDt3qqp77aahtx42gH0ByB
	 1K5iUG6kSDCCUwBWIXZ4xzJAkrDygz//KT3iesOTF1MmaMMwh6RCNqC3qyvwgsTv6C
	 1Wu3gdkX5pkFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3DDF480D84;
	Mon, 16 Nov 2026 21:13:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9012213C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:13:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 764E880D80
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:13:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sTX7oqHgvg6y for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 21:13:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 850EF80D01
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com;
 envelope-from=wqu@suse.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256
 header.s=google header.b=LBua7rbi
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 850EF80D01
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 21:13:38 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c506a231b88so570091566b.3
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1794863617; x=1795468417; darn=lists.u-boot-project.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tTFrccqx7uE8NdUaWA6b7niP8829+N+YTeIPGiFu6Y0=;
 b=LBua7rbiKEHNaNehJ4GdmNmVrM4lU2/OncsT3MuEKNgkssuF8rQK30EN2Mp3sRlmhd
 eDV9jW3jYpzJUn4J+/WbYXnr3BMrnTGUHvBSpC2fEHhIWkoEW57veHt83mPmvfp6rwMM
 4a6uw9wuaxTutmewNvfmhk5JtBnD/gCOiz/YHocXdFSHYGaHOF+QY0YH6GLrjypaGg5w
 T6dICFQ+VzpnKNzmaO5bOMaclTb5ZQyjeL915aL3TY3jTxCTHEEc3gHhmLvJY6KWAEcN
 hFh/rmHap6DRcR4/aIN1jauLD3tbEhNIWEVVo6gTlzAGtZxRIelGvkxKPWGlOw/R5e7s
 qAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794863617; x=1795468417;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tTFrccqx7uE8NdUaWA6b7niP8829+N+YTeIPGiFu6Y0=;
 b=GPrCGlEPLoWi+wram3OVCZei4JBTxz6UzpXcl+/j1eI6ugw4VXtcJmFIAXjZppT7am
 lxyr0rfkU4ZDLHbL65FpigTjlZRbjYUMgrwdj3aPFXdzjrsFR7bwjshLRx9SoUTlLfD/
 8Zlov4ScSlbRvhKFQpDWEZE7js3faWBIiqTByHQqcmqZIBYR5wR6xAmFCuj+kLByRqgY
 kBK5IyjKVij1lM1Uk97xtXAmgpW/ot+1T2hQkgJTF8eWO13ngTAX9T2MdBmA4E8FWc/S
 rxNw35adH5dKofLd+My5EflKJwzrwkJ5X/J335lYFQV1LjhTciF8xNaY3Kf06HIhGlsH
 5qmQ==
X-Forwarded-Encrypted: i=1;
 AL+hErG2Y5ss+fPut1O4Ms8QJgi7aCe3IH63kATARJ5MfZ0PVb2JncbhLdq2VVgZYMIJZPLmPzDprhU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+w6eULVtgoyZCqjvqYxMoG5ptICiKNLAanpVRaXxeRmTJ58AIV
 tJRCnNGXThNpLclmBeclGaPMCZ8+U3MkEJG8bFZFsOeE8kFwlq0K2vOgM2vo+YMvWV0=
X-Gm-Gg: AYBFou19hPkm498O2PTwEhizhZ2/wDub9hxapU0M9VCwMXRId3JXZMAV0mOPGVTu2hF
 zB4R0tjBTBtTtiGkYvJsaZ3KTxoO8H35m5iSp9dIgNfGTamuzo8lhCBhduxHIsWG0fG9lr3gBbV
 1PSGlGJgsi+qC3L8maEYVRNq+77j/Zq8QMsLqCTC2DlBggAfOJDwfrpXuQbvudYlwfuwPVGZHzo
 oP2D4hgXfAgYdqn3thdq5UuHrin67g/RpmV4CFK9cys5hzt/YiS5RfHfzAWAs3cd0Jqhrc3GYze
 VQnzSM4zsVeP1Mq1Gbr9/tqId4dUJZASH5dmghDhi0Ry8P0Pm5Zae2T6a1CepML5x1hDNNJ9upC
 PNDgO0cal07zm+bEbQJKTq4JHQs3T8+JzcfKhGVHfb3CsqbBQTzmMsupqsJcoYb/PmDBDle0e9f
 aTFZOTl+OTJnH0qbGZTUXWbxsnY1SzBXxxG7BOZxqZtHQ2M0DCUtTVq5sDWvCl3h2ZB0tvWIsIl
 oKj/PwIS2Pc6HCVh5Ooxr/RczCY61gyaHtlCQ1kY3sWgbRthLRWd1AQpCLrqKPuG2AICPrhasgx
 ABfdvEo8/mOV0K7rXPeXrA==
X-Received: by 2002:a17:907:c13:b0:c38:ee33:2931 with SMTP id
 a640c23a62f3a-c509654c8b7mr949894666b.37.1794863616613; 
 Mon, 16 Nov 2026 13:13:36 -0800 (PST)
Received: from [172.16.0.229] ([159.196.52.54])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b3ab9f3c5dsm848264a91.0.2026.11.16.13.13.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 13:13:35 -0800 (PST)
Message-ID: <767dd299-5aa0-4e4f-a84f-a55395214a30@suse.com>
Date: Tue, 17 Nov 2026 07:43:31 +1030
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/btrfs: fix path buffer overflow in subvolume listing
To: Dilip Mallavarapu <dilipchowdary21@gmail.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
References: <20261116205502.14884-1-dilipchowdary21@gmail.com>
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
In-Reply-To: <20261116205502.14884-1-dilipchowdary21@gmail.com>
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



在 2026/11/17 07:25, Dilip Mallavarapu 写道:
> get_path_in_subvol() and list_one_subvol() accumulate a path across the
> on-disk inode-ref / root-ref chain with strncat(path_ret, tmp, PATH_MAX).
> strncat()'s bound limits the source copy, not the destination total, and
> there is no depth/cycle limit, so a deep or cyclic ref chain overflows
> the PATH_MAX path_ret buffer (CWE-787/120).
> 
> Use strlcat()/strlcpy(), which bound the total length, and reject the
> path if it would be truncated (which also terminates a cyclic chain).
> 
> Reachable via the btrsubvol command on a crafted btrfs image.
> 
> Signed-off-by: Dilip Mallavarapu <dilipchowdary21@gmail.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Just a nitpick on the comment.

> ---
>   fs/btrfs/subvolume.c | 25 ++++++++++++++++++++-----
>   1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/subvolume.c b/fs/btrfs/subvolume.c
> index 68ca7e48e48..bac9c1d1722 100644
> --- a/fs/btrfs/subvolume.c
> +++ b/fs/btrfs/subvolume.c
> @@ -64,7 +64,16 @@ static int get_path_in_subvol(struct btrfs_root *root, u64 ino, char *path_ret)
>   				   (unsigned long)(iref + 1), name_len);
>   		path_ret[name_len] = '/';
>   		path_ret[name_len + 1] = '\0';
> -		strncat(path_ret, tmp, PATH_MAX);
> +		/*
> +		 * strncat()'s bound limits the source copy, not the
> +		 * destination, so a deep/cyclic ref chain would overflow
> +		 * path_ret (PATH_MAX). strlcat() bounds the total; reject
> +		 * the path if it would be truncated.
> +		 */

This comment seems overkilled, and it only covers one call site.

To be honest, I don't think there is any comment needed for usage of 
strlcat()/strlcpy().

Thanks,
Qu

> +		if (strlcat(path_ret, tmp, PATH_MAX) >= PATH_MAX) {
> +			ret = -ENAMETOOLONG;
> +			goto out;
> +		}
>   
>   		btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
>   		cur = key.offset;
> @@ -128,7 +137,10 @@ static int list_one_subvol(struct btrfs_root *root, char *path_ret)
>   				   (unsigned long)(rr + 1), name_len);
>   		path_ret[name_len] = '/';
>   		path_ret[name_len + 1] = '\0';
> -		strncat(path_ret, tmp, PATH_MAX);
> +		if (strlcat(path_ret, tmp, PATH_MAX) >= PATH_MAX) {
> +			ret = -ENAMETOOLONG;
> +			goto out;
> +		}
>   
>   		/* Get the path inside the parent subvolume */
>   		btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
> @@ -146,9 +158,12 @@ static int list_one_subvol(struct btrfs_root *root, char *path_ret)
>   		cur = key.offset;
>   	}
>   	/* Add the leading '/' */
> -	strncpy(tmp, path_ret, PATH_MAX);
> -	strncpy(path_ret, "/", PATH_MAX);
> -	strncat(path_ret, tmp, PATH_MAX);
> +	strlcpy(tmp, path_ret, PATH_MAX);
> +	strlcpy(path_ret, "/", PATH_MAX);
> +	if (strlcat(path_ret, tmp, PATH_MAX) >= PATH_MAX) {
> +		ret = -ENAMETOOLONG;
> +		goto out;
> +	}
>   out:
>   	btrfs_release_path(&path);
>   	free(tmp);

