Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEBE5C2BA15
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 22:22:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB77D8752A;
	Wed, 19 Jun 2024 00:22:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="QS7aWKzi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3D6F87B1A; Wed, 19 Jun 2024 00:22:02 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA12380E9A
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 00:22:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quwenruo.btrfs@gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
 s=s31663417; t=1718749318; x=1719354118; i=quwenruo.btrfs@gmx.com;
 bh=PLPfalnLls6leW3SlWjdM2CghETE/9IWaoFeS2MJFCE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=QS7aWKziGTmk6VGhbxsqicNGtST06920xRpHiRAC4CreystSBX7gqs6/DY+4FhT6
 I93k9lqZFgZKZcMofgLM+23uRMkkF+0gNW4YZUPtajuQF2lcTa/lxsmA9QVO8XUYi
 x3A8H6irrP7RvseqdhcIQAwMfbLqvQyUwKRijaIaBwL5Y+y32p/wDcZAiR2qt2S0T
 pllqElqLFdTcR9UKxghZmnFjYfgQmzGA70t0jxnqbijVxujzlN9CWmuoNT0rstj1t
 Q9gBhHyXlH6h8fiBh8qgtIt3Vuw0QOkLImPKULpOtBv3dBM17uuxTpAVgoQDPOhiz
 jFENPudgv0ZpuoRjVA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MJmGZ-1s4dKu2Gnx-00Vk4L; Wed, 19
 Jun 2024 00:21:58 +0200
Message-ID: <846975bf-1a75-4a07-ab63-764ca56cab98@gmx.com>
Date: Wed, 19 Jun 2024 07:51:52 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs: btrfs: fix out of bounds write
To: Alex Shumsky <alexthreed@gmail.com>, u-boot@lists.denx.de
Cc: Dan Carpenter <dan.carpenter@linaro.org>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Qu Wenruo <wqu@suse.com>, Tom Rini <trini@konsulko.com>,
 linux-btrfs@vger.kernel.org
References: <20240618214138.3212175-1-alexthreed@gmail.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <20240618214138.3212175-1-alexthreed@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n0MudmM7UipAHVyAbzfSpokRo6NdwL9G7QwU6hfLdfAlXuyjq0A
 UBS69oc6ovFCWMaBr1q8Co8ygHYuNeKNQvC0wTxC9qMyutBBdFhhbeiVC2T1I9kVUmlLpMA
 ewopLICihLV8LhwLP53JBs4KvvhMfOphia0a937SjIk2QIrWkBwJxcyk97PER8wfl1I+kEP
 9NmCBAmZYJt9KjnorwLFQ==
UI-OutboundReport: notjunk:1;M01:P0:laf7TQJTeC4=;QYTJ6qaByVYyyPbFID1wGsjF5Ub
 oomQArzxy3Mjc65wFh/A4pBOm8sWW1oQBV89ZqY7qYK4FdBFD4fnz3Cm0i4eF/nYO5p4h+gAz
 sdbmyX+lR0iD0qZBEns9t98zk+OhdrvvFs+HoW9nkIfSl/hOgyEW8vKE9uzMHxxUDqDpwl1Dl
 Mdk+XUTDeTOh2ecLoil1hEMyIEIJmQzKyrH6HZGCwg1tOHuNrXYQgZHjzW5zxPhv5JhDTuCP1
 BkU67kXMuBv0jXyFTf9Eg2ALove7ugFaTGsyJqrNx4IiyE2gYOgKTCBig0yazXyfV5AnHVVmS
 txkIOEdyXJq9Nh7slwxgFS0XRLYxl9f7Elpt/WHv75s/VebST93IvMtEJsjycVV/v0KGJBIJX
 99zBtcmXpjkhMn41folxsu9P5F25S+EU2aJbU6DkmBrCfSU9SvmK/OST3+zxFV5Bb+Af/uXpN
 lRMHP+4NyPjOvaD709o1jxfFjgr/qM6/eihYArXyFy5vvY+7P0N1BqwimFO3CaAq+xiCTVIzw
 0W5d1y6JkFBL93YNVLvTyz5o9emhiUXp6MJn7C10PVZXPNHPUl9Q3OR2vS7R0vSKrCVMHPFcX
 oz8/M+I9ys388a/+cEdPQTeK00f/72Gn2wQlcH8L9l9NnAjZJPLpjNh0C67zPhyYzwvilXp2a
 7V++KnD1rlqPMFyrtZvST6cXaye8HzhP90vEHNMeXfcoWHecmNRZgpL1Odyfn2K4+SjAcZExo
 5XtwYL4AXC9TCxS/8zAxom41ejknX6N47rR2j5IOgbqfzd10w2c2QchutchEQdRAimIQWQVrv
 T9flK6AiNchZu2naOTz379oHOcU5Ene2OBK2C+mGn8uls=
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



=E5=9C=A8 2024/6/19 07:11, Alex Shumsky =E5=86=99=E9=81=93:
> Fix btrfs_read/read_and_truncate_page write out of bounds of destination
> buffer. Old behavior break bootstd malloc'd buffers of exact file size.
> Previously this OOB write have not been noticed because distroboot usual=
ly
> read files into huge static memory areas.
>
> Signed-off-by: Alex Shumsky <alexthreed@gmail.com>
> Fixes: e342718 ("fs: btrfs: Implement btrfs_file_read()")

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>
> Changes in v2:
> - fix error path handling
> - add Fixes tag
> - use min3
>
>   fs/btrfs/inode.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 4691612eda..3998ffc2c8 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -640,7 +640,11 @@ static int read_and_truncate_page(struct btrfs_path=
 *path,
>   	extent_type =3D btrfs_file_extent_type(leaf, fi);
>   	if (extent_type =3D=3D BTRFS_FILE_EXTENT_INLINE) {
>   		ret =3D btrfs_read_extent_inline(path, fi, buf);
> -		memcpy(dest, buf + page_off, min(page_len, ret));
> +		if (ret < 0) {
> +			free(buf);
> +			return ret;
> +		}
> +		memcpy(dest, buf + page_off, min3(page_len, ret, len));
>   		free(buf);
>   		return len;
>   	}
> @@ -652,7 +656,7 @@ static int read_and_truncate_page(struct btrfs_path =
*path,
>   		free(buf);
>   		return ret;
>   	}
> -	memcpy(dest, buf + page_off, page_len);
> +	memcpy(dest, buf + page_off, min(page_len, len));
>   	free(buf);
>   	return len;
>   }
