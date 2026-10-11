Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE8ACA9EBD
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 06:33:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B52260690;
	Sun, 11 Oct 2026 06:33:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sHD5qRo0ngZs; Sun, 11 Oct 2026 06:33:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DEFB260640
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791700389;
	b=pUwoc4+htcgyTHc42EUD2nUpc3uzyT0OZL1OqPSuAsZlQq82Gmr0ygcfc49/DRRRnHGB
	 QsY1Pc2R/gjgfspjM5xmdWjQ1VsoV5kCxm3FIfsZGJ5c+GOKhxcE7ubJlbVB77c1FnUMC
	 C/sX34BQD6isLo70eo2IG52R4bkvMFVrUT3AU9nbzZn5tIrVLJ5IrrP7m5GcL9Po5gvwp
	 sVuLlbs/BDRp8NG0DwaXZGDlM8kI2UdFvxYhAe+vsb98WODK2NqG4Cft4iTcVzY2PaQBL
	 i7syGkrk3yZKhlK+ZypBeE3r9JBDzwgu9cvn4sF8qbuEBiP4PxOZeJu67k+DceqXjZQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791700389;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Provags-ID:
	 UI-OutboundReport:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=EqTk/eFvkirLhBTTTO0GAZNNUc+Zq9BYUIAAXazBWa0=;
	b=qSs55/s3K6IMVQ7NndPiPU9VfvaYG81KbIUSx6agwUc31OlKFmTHLWyDp1jTOA78yU0t
	 h04obEstYPJTujiYbVOGlsVUvPYv81eEWGMIUHIZlvpg/SM1wPtdcaXPjxEYMMj5lscNq
	 0+yG2R6U55Lh9rkYWpOyoxuC7V4A22DcP7Qb/xc2X3Yh2YtVKV3vtNdL16uwO4oiNRC2A
	 PpqEFQGKOXJyez6/bmISmKIsNBb0djK5U+gnfQrrOboH42UshVG1P375MVR6ajMp0F5bS
	 s6oJRQAMuDCQhKddSSrfcCF42CLzwm9cAcLXgrGdGJYc437A1q93ZqvB5ly/0ItVxpQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791700389;
	bh=EqTk/eFvkirLhBTTTO0GAZNNUc+Zq9BYUIAAXazBWa0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nxaTBznRrOYbCpJlHGPjDbMPwX3+SScvxdVFd9X3Lr561BUFGNfuFGFPa2UuXQCKW
	 LYGDqK65luYm+5YQZG+SVYannTMT49mPHQap8/LimPgHF4p3Hy43zeUoi4HvrOVZWy
	 WCZW6jJnkWvQqsNa0Hz37jJQrSap1Na+EOAR5I/ZrtS6CFwUWFiUsMLPurjjXans/K
	 AaEbd0A2J8FHYWRVOzka10WL+ahat+HYuZudcO5r11LxhdFzQDdUIqozG6sfgsMGau
	 oKMyOBfhDE1sOpCXxGY2Gyu39PXOOXBvIhy1YjDq7v1i4GlbFi+4P8sk/4YN/feNfa
	 ssvz1H/6ORhNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DEFB260640;
	Sun, 11 Oct 2026 06:33:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B1D99DF
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 06:33:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E79AC400D5
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 06:33:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9-YlegVXpZUS for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 06:33:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7F95E40042
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791700387;
 b=G3b+HF4DWap2kpCWVjQEX0vnqFm4bEfk7ASVurdDxsd4G/ZmLBccET21DtHEW7Zp4kb7
 YEmwapoPhW11PJZgJ9jCZgmalqEw84FRwdhRozYEsCNAOL9yQnNHfBeywqd+a0eH/wcqB
 hUQMAh5r1cMrX0PB9zV6XUv2TOQx8G+HU4SKD2zcRRKk49YLee4SlkzETVOo7bCgmzfP6
 Xy1Co+01WDijBXVtL48dKLw27P8a0oH71fxtBx5WogNZfSi2OE8SMQ3orulCxur3LF7sA
 c5cD83okCoJMINEVkjPk5qudyBXDY/g/3I8BkQDJiN3w7CgumXI5ZcoiPt7hQJTrg2A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791700387;
 h=Received-SPF:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
 bh=EqTk/eFvkirLhBTTTO0GAZNNUc+Zq9BYUIAAXazBWa0=;
 b=biLerPQQcQ5rbSSvRjA6eAmmTzZAi+sMrTCrIC8SkWJMMjAmA8uUJjPQ9j/9PnrGmHyk
 lOocPTWoeYfiu7qGIvlgY093qhInTghFWeMwzygpT1LGFXtuYcVegT0+Lz+BqRQ7Yf+VJ
 z/KRDCfDc6R3khIa7SuJKMTBKhfLzMQO2ds6tULAGyWMXWULl8yk39CUoCM2W6b4+GInK
 P36APDnE7E28Ny1ff6WHFk0JAZiO7HIg+rikHp4CFpoUIgKpE42dVWfkucamER0b7dZg/
 3xZYznNFjAJBAEGDKwqShfNLayM6FW2yO4+b+KMfKqwAvQKVRlC82PCl9KgaWWAYuVQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmx.de;
 dkim=pass header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=gJ6tzpjg; 
 arc=none smtp.remote-ip=212.227.15.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.15;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de
 header.a=rsa-sha256 header.s=s31663417 header.b=gJ6tzpjg
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7F95E40042
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 06:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1791700377; x=1792305177; i=xypron.glpk@gmx.de;
 bh=EqTk/eFvkirLhBTTTO0GAZNNUc+Zq9BYUIAAXazBWa0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=gJ6tzpjg1rDLPyv64S427JGs00howpfFYvCm1VsnhNptmEtmPZwI4o3A9VpzyGEA
 gzXANEztsWDRi6ZrKOWKvfYKcb9WUMNx8zEs6DV8D+qj8/asBJhY/jbcCpF+oscZv
 B6Kd0mxJ7i1lby681SADTq1zpNsLwbLwCDJsJ0YsgfAef/npVsMatA1OkF0I8doCb
 rdEUvUnwzudw8FGuzwiWNXiRlLy3M3u2GNnOIVAGnO9hhBiHZPNIrz4UQy/g69Jxc
 SoKvTEBaQ+1wdkz82yAReazWuJSFJyaG+nax+W3eA5ruErwKMwHhDD+zDG1Fy2Al1
 MXfy66Hb21vuD8Q/IA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgNh7-1wjD780nK3-00mxyN; Sun, 11
 Oct 2026 08:32:57 +0200
Message-ID: <2b62d2f4-5ee6-4401-84d2-421cd36b1729@gmx.de>
Date: Sun, 11 Oct 2026 08:32:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] efi_loader: fix string table reallocations
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Leif Lindholm
 <leif.lindholm@oss.qualcomm.com>, Rob Clark <robin.clark@oss.qualcomm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 u-boot@lists.u-boot-project.org
References: <20260922-ptr-v2-0-58817a31c67f@arm.com>
 <20260922-ptr-v2-1-58817a31c67f@arm.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260922-ptr-v2-1-58817a31c67f@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yJA/EcyMiBzZWjnJtuUKgjZ+X36cjrEAXMYkxLAVyeKzI+gij9s
 4OywJj162q6IFzyBSfIdsEHWShMZdgmELHD6D6WlOuEAfn0SQMcBvMBB5W4drZx/9g9ichJ
 vNvwEplR8CZUOaIeoydbCXMHa1DWAcYDyVfBg2P9rhqz+adHN588uiRajkO4v3kXiBJ+r+h
 aJPddt5VhcnQ9AmBZ76qg==
UI-OutboundReport: notjunk:1;M01:P0:LOzOd/BU+ms=;rooPuKsNtFy+BOBBVZK6UsKaNwy
 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
 =
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 9/22/26 11:15, Vincent Stehl=C3=A9 wrote:
> The new_string() and set_string() HII string protocol functions keep
> using old pointers after calling realloc(), which may have moved.
>=20
> The set_string() function also assumes that reallocation only grew the
> array by one element when computing the start of the memory to clear,
> and forgets to update nstrings to the new table size after reallocation.
>=20
> Repair and factorize the reallocation code in a new grow_string_table()
> function to fix those issues.
>=20
> Fixes: c9bfb22296b0 ("efi_loader: Initial HII database protocols")
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>

LGTM

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   lib/efi_loader/efi_hii.c | 64 +++++++++++++++++++++++++++-------------=
=2D-------
>   1 file changed, 36 insertions(+), 28 deletions(-)
>=20
> diff --git a/lib/efi_loader/efi_hii.c b/lib/efi_loader/efi_hii.c
> index 7bf51ad43d1..90dff91e5d4 100644
> --- a/lib/efi_loader/efi_hii.c
> +++ b/lib/efi_loader/efi_hii.c
> @@ -822,6 +822,37 @@ static bool language_match(char *language, char *la=
nguages)
>   	return false;
>   }
>  =20
> +/**
> + * grow_string_table() - Grow a string table if necessary.
> + * @stbl: String table to grow.
> + * @n:    Minimum table size desired.
> + *
> + * Make sure a string table can contain at least n elements.
> + * If the table is too small, reallocate the memory and clear the new e=
lements.
> + *
> + * Return: false in case of reallocation error, true otherwise.
> + * In case of error, the original string table is left untouched.
> + * In case of success, stbl->strings and stbl->nstrings may have been u=
pdated.
> + */
> +{
> +	void *buf;
> +	u32 old_n =3D stbl->nstrings;
> +
> +	if (old_n >=3D n)
> +		return true;
> +
> +	buf =3D realloc(stbl->strings, sizeof(stbl->strings[0]) * n);
> +	if (!buf)
> +		return false;
> +
> +	stbl->strings =3D buf;
> +	stbl->nstrings =3D n;
> +	memset(&stbl->strings[old_n], 0, sizeof(stbl->strings[0]) * (n - old_n=
));
> +
> +	return true;
> +}
> +
>   static efi_status_t EFIAPI
>   new_string(const struct efi_hii_string_protocol *this,
>   	   efi_hii_handle_t package_list,
> @@ -847,23 +878,12 @@ new_string(const struct efi_hii_string_protocol *t=
his,
>   	list_for_each_entry(stbl, &hii->string_tables, link) {
>   		if (language_match((char *)language, stbl->language)) {
>   			efi_string_id_t new_id;
> -			void *buf;
>   			efi_string_t str;
>  =20
>   			new_id =3D ++hii->max_string_id;
> -			if (stbl->nstrings < new_id) {
> -				buf =3D realloc(stbl->strings,
> -					      sizeof(stbl->strings[0])
> -						* new_id);
> -				if (!buf)
> -					return EFI_EXIT(EFI_OUT_OF_RESOURCES);
> -
> -				memset(&stbl->strings[stbl->nstrings], 0,
> -				       (new_id - stbl->nstrings)
> -					 * sizeof(stbl->strings[0]));
> -				stbl->strings =3D buf;
> -				stbl->nstrings =3D new_id;
> -			}
> +
> +			if (!grow_string_table(stbl, new_id))
> +				return EFI_EXIT(EFI_OUT_OF_RESOURCES);
>  =20
>   			str =3D u16_strdup(string);
>   			if (!str)
> @@ -957,20 +977,8 @@ set_string(const struct efi_hii_string_protocol *th=
is,
>   			if (hii->max_string_id < string_id)
>   				return EFI_EXIT(EFI_NOT_FOUND);
>  =20
> -			if (stbl->nstrings < string_id) {
> -				void *buf;
> -
> -				buf =3D realloc(stbl->strings,
> -					      string_id
> -						* sizeof(stbl->strings[0]));
> -				if (!buf)
> -					return EFI_EXIT(EFI_OUT_OF_RESOURCES);
> -
> -				memset(&stbl->strings[string_id - 1], 0,
> -				       (string_id - stbl->nstrings)
> -					 * sizeof(stbl->strings[0]));
> -				stbl->strings =3D buf;
> -			}
> +			if (!grow_string_table(stbl, string_id))
> +				return EFI_EXIT(EFI_OUT_OF_RESOURCES);
>  =20
>   			str =3D u16_strdup(string);
>   			if (!str)
>=20

