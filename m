Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F25C27C79
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 22:23:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB1D288025;
	Tue, 18 Jun 2024 00:23:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="aH3RaHeS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1024883C3; Tue, 18 Jun 2024 00:23:09 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0D7E87D70
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 00:23:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wqu@suse.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2ebdfe26242so55259451fa.0
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 15:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1718662986; x=1719267786; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=LRHNSzfkySw8bdD6HMA6VwKW5sxTvCWdBzYMXFVS4Ag=;
 b=aH3RaHeS2VmdTTAALFE18jfMlrzFtyRAr4Ufby0EpD3IDO6kFGYV6RZrPwSp64Fado
 Krw6H1z6eoaXJEIVwUPy3OFtUAPfQ+zR+5j4Nekq9TgAP3cYfed3FAgvNhljxa3vfe5M
 ACSo4QC6Kl3WjYbUFWcrdtISlR7fCW1iNltWuxYTMCHIOs0vcaqd2W7zpdpFsgsoh/cp
 pBjKGYmfYZaR2QgJbPNcGf5qA9jTEUzJzBCHjd97q7q2Q8a7gZ8/2/aluSQdHy1DsJ4s
 f5gJI9sToKp4PPspxZGRwSC7BCn46Q8SBqV9JywjgNjRTZEFbubLLjM7qdV/17X9vd9N
 RtIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718662986; x=1719267786;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LRHNSzfkySw8bdD6HMA6VwKW5sxTvCWdBzYMXFVS4Ag=;
 b=Ynnuqc62IrsAgl3lkGty5wRxubiXGQ55xiXi0X+fcCW3x4LqqIrYcu/+rQyOa/e3N4
 +f2UXA/R5xyRRxTyQRiolyqaKLxeIoEJqw87ij7nOj6MSt9ESHMck0e4PaJldZ+Cnge7
 w/IfaLbndz7d3pHYVkxEjDMkAGJM9OiFwdc7NYElJndKZsXl1wCo3FPzodSEk7Jthfvs
 KEJnD9wV44LPTRqpbWqpNuXnVra73S0F987N0nv0M3orYzfGBkSac+xwk9vffoUb1fVo
 el3NKQckII0sqUwjX9fy3334/Zc4OayXOhztJg26W1ERy4yzc5Bvz15JIpdq2T7IkhuE
 v/1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWce5ECGgVUDLq6/jVM5RyjP1tfw013o3LFO1KBJmlFKzdsH7wYO11/yNzQ0FFXfhAQvv5yIa9VVKRY+TSF6swIaTQGWA==
X-Gm-Message-State: AOJu0YwqHSQUuLaTOi7Xz1GR/+0XLLwZ3zlNOwwey8/4UYuEP+tlmpxm
 Q4cAUHGsr+AUFXk0mdYRQJrYOwOTQ38eHcffHsDkCRAxGaimOji/DbF5/tYOwL4=
X-Google-Smtp-Source: AGHT+IF8VNtBjxICmjpXxFoPDOl8Te3nEdwgAXg4I4e8LrCs9ZDE+Z9fWKtm9TCXHYFb95NQApkVPA==
X-Received: by 2002:a2e:3805:0:b0:2eb:ef0e:3f5 with SMTP id
 38308e7fff4ca-2ec0e46dee9mr66382631fa.18.1718662985922; 
 Mon, 17 Jun 2024 15:23:05 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299?
 (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855f185a8sm84312475ad.235.2024.06.17.15.23.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 15:23:05 -0700 (PDT)
Message-ID: <ffa17a61-7f00-4f10-a80c-3d94457be23f@suse.com>
Date: Tue, 18 Jun 2024 07:52:59 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: btrfs: fix out of bounds write
To: Alex Shumsky <alexthreed@gmail.com>, u-boot@lists.denx.de
Cc: Dan Carpenter <dan.carpenter@linaro.org>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Tom Rini <trini@konsulko.com>,
 linux-btrfs@vger.kernel.org
References: <20240617194947.1928008-1-alexthreed@gmail.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <20240617194947.1928008-1-alexthreed@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



在 2024/6/18 05:19, Alex Shumsky 写道:
> Fix btrfs_read/read_and_truncate_page write out of bounds of destination
> buffer. Old behavior break bootstd malloc'd buffers of exact file size.
> Previously this OOB write have not been noticed because distroboot usually
> read files into huge static memory areas.
> 
> Signed-off-by: Alex Shumsky <alexthreed@gmail.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
> 
>   fs/btrfs/inode.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 4691612eda..b51f578b49 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -640,7 +640,7 @@ static int read_and_truncate_page(struct btrfs_path *path,
>   	extent_type = btrfs_file_extent_type(leaf, fi);
>   	if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
>   		ret = btrfs_read_extent_inline(path, fi, buf);
> -		memcpy(dest, buf + page_off, min(page_len, ret));
> +		memcpy(dest, buf + page_off, min(min(page_len, ret), len));
>   		free(buf);
>   		return len;
>   	}
> @@ -652,7 +652,7 @@ static int read_and_truncate_page(struct btrfs_path *path,
>   		free(buf);
>   		return ret;
>   	}
> -	memcpy(dest, buf + page_off, page_len);
> +	memcpy(dest, buf + page_off, min(page_len, len));
>   	free(buf);
>   	return len;
>   }
