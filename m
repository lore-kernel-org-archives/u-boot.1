Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E2ACC02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 09:00:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95EFC803B5;
	Wed, 22 Jan 2025 10:00:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="j4i4BhcS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5435880586; Wed, 22 Jan 2025 10:00:56 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE31880283
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 10:00:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1737536452; x=1738141252; i=xypron.glpk@gmx.de;
 bh=uU1e0rPUNGWFHEeuICla2P+gGydS8tcI67+fmOVaje0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=j4i4BhcSAyGqZHpQPEPuGvE26vaf+ub24LgQrlOmvGzEIpq0rGYarNxnDsmKTqys
 af9+/vNkIaJzsk6C0Hvvh5DMD4P7BR98dUn0hltLkLiZQodz2tYazkDOC4fxbv9os
 r3jtoi5otghHA1M/3qCeL1PKbvzIUyn9dhS7460UoBijjjp2FbM34Khv/AjVE8Ho6
 /zAAe71GXqseoCHluPKKVZRbYGeHirxwJMpGydxfZ0KQxeHqwop9HPDKEVKT1rQr4
 m4CJpB4i4Q2keml5tJ1nguBqQziOyuZJ6Bu7hGfFCKNat3MF9ceP3TsvIQNeutdcL
 T9QLD8wRHqrmVXWCiA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.102] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLR1f-1tt0vX13HX-00Vnig; Wed, 22
 Jan 2025 10:00:52 +0100
Message-ID: <14244381-2773-4265-82db-972f6ca684b8@gmx.de>
Date: Wed, 22 Jan 2025 10:00:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] fs: fat: update parent dirs metadata on rename
To: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20250122053232.17365-1-gabriel.dalimonte@gmail.com>
 <20250122053232.17365-5-gabriel.dalimonte@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250122053232.17365-5-gabriel.dalimonte@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DUxpyRhPhlRE2ZpZIRQimSH7foO3XzkXwD6Jh3Jb0h5Dxb39Ua5
 DS5erAnigVNtKGeVQOciyp5YjTUo3Yw1qjHKmNfcK8mGHNkPkj5RVGlGKklOWCdV/QAu+mM
 YCEOxONB0zqKd+uorkNoOOuVwK/n+TFCLvB5ImACLCz6JcoCZFSnwi9vmnVOHwTD5XU/cwG
 zQbmFXiECl/5wfFGG8LjQ==
UI-OutboundReport: notjunk:1;M01:P0:8Vu1xoYHFZE=;EY8OMOR641Ak8z/ivJ+w2UA9xV0
 YdjNjIongk2Ja9fFO+ps1rNSis/JoSEWP08IT5VKVOyGywU/HnNL51WBDjX9OFtGOvOyj24zf
 5ZefhoCXc+tt3kGpIuTFOeXJgYGjV/1yxO1+8xO6govJP2i9pzFvyWuy2RbpZA4tkjPbRRvPa
 E7ACUdmrgeaH0WFmbWz30bte/a+zTI413KgZDfBtagu7epBVQqcuCKYQb44gcFnTrQIxWTJbB
 s2kEYZtSjDME++Y/pe6M23LQcxLoTQxhfRJJN5AqVTnaEvAUWDsRhtK+T9zKAzCGTLoO9lbwe
 p/GRWRNrtdIy7t42RlX2SFoyM/Bwza9FXO30wFBjvd09FEqNrgLErErMDsgYztykLV7oOODGY
 Ew4jqKL/PLrvaprHtwgLgjvFqM8RhENxFTDVwX0beXbKIKjLhA6lgLby7GJ8dgrUSzWXElpGm
 5eYiOw4dBCxqCd1hFy5tawDgv2+F2WWRZKOPPT2y0IkxGjxNeNKPRRgtZIsCLXyyZStPv+ME4
 +ktJwco92YbkBNujFPS9IChMql4Qctx8ejnOQMDHwwvG/LjMzMjB4Pi/8dtTk/ChUTkuXSgb9
 vJrTZKhpHQojuOLOxw7+IMpRG0fL++1mIOpWdnQ6R6/Xg34DxWXp2jLrBVDxgIzp+aHGoEPsT
 wt/E0PsltthmfBIJ0BgNpLnl92F1pzU/vy5TJWye5obzcYNUfTGGsegC5bKYPeSMnFkUAHS3h
 jigbkuJvVa/QA4DsFie9DpKIeVU48EklmOKBXfX28j+D+wO0x3YM90U1Jof+vCTxuyZh3zCht
 OBqedQb0Jb/1cxELk1wppPmWIBecGmYrQZ/CB3+QqaRtvOVa4oGhunAfvCaLgQrF1vWCvg8hf
 bohx7o5RAr8QIiJWDWaG8UrSj3+MA8ljlCcZlVbgmkjvrVbfe4lxqtRxiJpHmGJ20yeKprltF
 8KnsiJfI0+Rao9BtCAfb39C5vfv9jxEONZ+YHHYFsVCz5PIdcE16vgZK0OBfbz3jj8+H6SDQU
 R5EdTWZs0dIEwQMaWC14qiowy+PrwUUuOQjVjjNQvLUK4Pyr0qXuzz5WozWT1suXHAwnPtjf8
 qLCslYjRhw2BGufR4ZQ3wbt49wM61108YgyFN5LjpVTDXAcBOyD6JlgG32w7OSoL572Hcizkm
 7VtVTFS6dUgOhn8hOCL0rXbkYDNus+m5EVvYbI/LTgQ==
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

On 22.01.25 06:32, Gabriel Dalimonte wrote:
> None of the existing fat code appears to update parent dir properties
> however, the POSIX specification for rename() mentions that the
> last modified timestamp should be updated. In addition, I believe
> the ATTR_ARCH attribute should also be reset on the parent directories
> as the content of those directories has changed.

Could you, please, provide a link to the referenced specification.

E.g. https://pubs.opengroup.org/onlinepubs/9799919799/functions/rename.htm=
l

Here I find:
"Upon successful completion, rename() shall mark for update the last
data modification and last file status change timestamps of the parent
directory of each file."

Does this mean that if we move a directory we would have to update the
fields of all moved non-empty sub-directories?

On many boards we don't have a real time clock. Should we skip updating
if we have no RTC?

If we want to update parent directories, we should do this for file
creation, too. The update function could be called in the function where
we create directory entries.

Best regards

Heinrich

>
> Signed-off-by: Gabriel Dalimonte <gabriel.dalimonte@gmail.com>
> ---
>
>   fs/fat/fat_write.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
>
> diff --git a/fs/fat/fat_write.c b/fs/fat/fat_write.c
> index f9f7051e30..2559e38d5b 100644
> --- a/fs/fat/fat_write.c
> +++ b/fs/fat/fat_write.c
> @@ -1912,6 +1912,42 @@ exit:
>   	return ret;
>   }
>
> +/**
> + * update_parent_dir_props - updates the modified time and resets the a=
rchive
> + * attribute for the parent directory
> + *
> + * @itr:	iterator positioned anywhere in a directory whose parent shoul=
d be
> + *	updated
> + * @Return:	0 for success
> + */
> +static int update_parent_dir_props(fat_itr *itr)
> +{
> +	int ret =3D 0;
> +	__u32 target_clust =3D itr->start_clust;
> +	/* For START macro */
> +	fsdata *mydata =3D itr->fsdata;
> +
> +	if (!itr->is_root) {
> +		ret =3D fat_itr_parent(itr);
> +		if (ret)
> +			return ret;
> +
> +		while (fat_itr_next(itr)) {
> +			if (START(itr->dent) =3D=3D target_clust)
> +				goto update;
> +		}
> +
> +		/* dent not found */
> +		return -EIO;
> +update:
> +		dentry_set_time(itr->dent);
> +		itr->dent->attr |=3D ATTR_ARCH;
> +		ret =3D flush_dir(itr);
> +	}
> +
> +	return ret;
> +}
> +
>   /**
>    * fat_rename - rename/move a file or directory
>    *
> @@ -2086,7 +2122,12 @@ int fat_rename(const char *old_path, const char *=
new_path)
>   		ret =3D flush_dir(new_itr);
>   		if (ret)
>   			goto exit;
> +		/* restore directory location to update parent props below */
> +		fat_itr_child(new_itr, new_itr);
>   	}
> +	ret =3D update_parent_dir_props(new_itr);
> +	if (ret)
> +		goto exit;
>
>   	/* refresh old in case write happened to the same block. */
>   	ret =3D fat_move_to_cluster(old_itr, old_itr->dent_clust);
> @@ -2097,6 +2138,7 @@ int fat_rename(const char *old_path, const char *n=
ew_path)
>   	if (ret)
>   		goto exit;
>
> +	ret =3D update_parent_dir_props(old_itr);
>   exit:
>   	free(new_datablock.fatbuf);
>   	free(old_datablock.fatbuf);

