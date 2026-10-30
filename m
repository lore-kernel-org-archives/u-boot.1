Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1995606A333
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 12:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SM3UkGgH;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=jcQpkE0Y
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AB1A6607A0;
	Fri, 30 Oct 2026 12:14:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xteAyBt5OpD2; Fri, 30 Oct 2026 12:14:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DFBDA60633
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793362485;
	b=oo7Sh4tz7Z/0V6jt8bMiwrgq3PyybLelFjcxqK9gK9rwafbBh471KWlfcRM8IQtwt5+j
	 Ux4U72tVjWgz5koR6RMToqr4C9l06k5PJ6Ef4BR5haACWRtOTkXvlyBdg2a0eRjoymKIG
	 /UXhhqX7i9HWcF1smO0oZr6U103wSDT5MAZw4HDfDKSRwjh2+vs2Tpj5uI5aEBuwtdg0y
	 He/dbSO4SoNRZepRRjz7znFjE23Usg9sDdwpAMNOK62cfQq3ETEsUPQRePQnhHTpzEoGn
	 O1bX0F/0MPdGn5d5q8s/LPAz8ZfAkLQZh/FNIEVaAkF8nsPAvIill6IWNkWJYGuZQQg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793362485;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Provags-ID:
	 UI-OutboundReport:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=43GgOipTg7hjORhGafPJk3ZVRT4K8MB/+KS2EFNYZ88=;
	b=BgGuHCTsb1Fx8FPBzAsypkuKQeD2C/tGaJLBzqdrt2skbr0odjHR7yAtPMM66UlZY4J+
	 urGaiUQqceAj2iRe+ADRqupvt+SczRlOwT4CGWqpabv+yO9qCNo3kLaFGYtbscPFK2ZWd
	 dvV3nBoyUTEQVBdspnl8x8Q1PdyMiSoK49W0zPdHzKzNbo4slaf+AS5NEbeGrccoWlGTe
	 98y+AFvRLiLHLl8E0CYS1lguuuoqTh0/ZlrmiayTko56Au7ojK1T5TqaTo+zFuC3sRfMp
	 bxPXXHf2B8uGPVAKD3bJATZ8+atRU633gxOgLIb5rE6vs19OYyad3yBVE+NZsSzetIQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793362485;
	bh=43GgOipTg7hjORhGafPJk3ZVRT4K8MB/+KS2EFNYZ88=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SM3UkGgHi0nsuPI+J5h2ArHCiS5RAshuD8qocpNYkgWgFmHu+q2WqvG0Bsp3gfc+G
	 BvULib5VHXsTdnCFTk9SuvP8rdw8CAbUhqWaMRcshA8hkMfTCeKHvUppZZVllyamrP
	 hqC8O7Yv7FTXJ4K/tUB62hyXmDkAQgdD41M8/Rk80ZXvSitDLSn1FGxFZ+MDZddGAh
	 dD54QGknL7X31ZSgsa4WvA4hlvhlQJqNN+b0w9qT4pTL+/deM3kORkMm6GEMEWdsXb
	 BOQ/fD0QNpVqkQhqp9QqlSEn7O8trf0Xk2ZbzBy+wko1vxvlQRMguXEmSz6x1zOSY6
	 WrK+kaJyWvhrg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DFBDA60633;
	Fri, 30 Oct 2026 12:14:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 56283D38
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:14:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 47592810F5
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:14:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OkFfqiVyLWCB for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 12:14:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0FFE68108A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793362482;
 b=S9NR+PDy1L4p5JWiurlLU5eYPDSeRndhqt6CaJV1T9UkY6MiRI9hYXIgMxACom1JQvEb
 1F+qa6lnUvBs5fwLF9h+OkNSlO1LGh31f3FVe0+RQg5skYTMXX6iEk/p5ic7dNjspIxqb
 5WuqfwA9JOqBgvr5vC3skdXqpO2xH/+FXnqKSf+RMzWYR+bGBJK+S4/fpWVTlhU/Pc4Bl
 JnCe6aP5WWAYuL7dMS7FogPMiIw73DWsOsJyQct9tKNSlSbw4bEGXLlu15s1nk7QpKkM0
 TqLhVXcTApKY8hBNGhNP7+8z0ig4+b++erS7aDwx+bvpHPeIKRdiz4PesJTvTRn9pfg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793362482;
 h=Received-SPF:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
 bh=43GgOipTg7hjORhGafPJk3ZVRT4K8MB/+KS2EFNYZ88=;
 b=YKyl9J+CngJqUGi29MbChPxv0VxOkc6Pyxl6lI89a3IfJh7nzfbj2q/gt2DFPWI77CLp
 bdT8Cfj8q/7zvEByPadjRorGjkCdov7RKhTjCkxUB72HAvZPysLDYgmE8aJR+D0FgD9c/
 +R1Bg1xOmRF1Rd4nDrSFDYOmvL+CUh3MqzQS40WxhFDMePmOamRyfJNEfQocfBN+MfKYL
 WgztFAMMf0GIbkYM7yG3B3lpwpvbfZj15nzt2Eg6Wqx6Mc55uyf/BefgUZIqySMDi056X
 DFZDwrm9YY1eyzA1mucu3UTAkhS13D9pt5YVUwG2OmqBuEsaGa370YJ6T1CR5JwfPrA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmx.de;
 dkim=pass header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=jcQpkE0Y; 
 arc=none smtp.remote-ip=212.227.17.20
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.17.20;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=jcQpkE0Y
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0FFE68108A
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1793362477; x=1793967277; i=xypron.glpk@gmx.de;
 bh=43GgOipTg7hjORhGafPJk3ZVRT4K8MB/+KS2EFNYZ88=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=jcQpkE0YJ1lRXCjEd3Dw+3J0WwpREdeCpMAsgSMbRGjc1hVw+B1Zx08FY9BAe6xu
 LQkABl6YeVwKh9Q5mmOr6JjtBkAasGVsG3ouG3iNgssSHG8BJ0UMSEK17JbjtWYcl
 RlAbNKnKRW/QswrJjq/TAR5DgmFaygBBRT72hIc+IaLrQsapmeP08lQD70x8Pgm9X
 ogzhEfGLwbWFFasYRVpUGWqYKp8Qq2V5eo/TRFi+4kQ4wPXTJKEEO5OAs8iWAcEyq
 UPsbi+qi11uli2KIshYVZ3/eAGM43HOTEnPz0BBHG5x20F48KKOsmtt8EIKc3P+DY
 3LKlVKbwwm1yW0VEig==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7R1J-1wSvLt3rwr-010J5J; Fri, 30
 Oct 2026 13:14:37 +0100
Message-ID: <35841cbc-a276-48ab-b5dd-1ee44340eb62@gmx.de>
Date: Fri, 30 Oct 2026 13:14:33 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] efi_loader: check the PE image ranges in
 efi_image_parse()
To: Ana Bobillo <anabobillo3@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
References: <633dddd6-ee22-4cd6-a8b6-cb7df0650fae@gmail.com>
 <fd7c9742-f369-4877-9a14-665b6b8afc2b@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <fd7c9742-f369-4877-9a14-665b6b8afc2b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gduU/pidPimeHXzWXV6k0PkKFy0uwKSVRIZfaS1yvQdp08+8bKi
 sOqe2MpALYnSUoJkPRAeJvIbNFw5nb1vm3u4gCcpjVIo903hrdkfyUpaXwL3GvnztD7aUJA
 dydjK+Z5IijMiR9+VLuUacvu9WPbz6OgxkAuo2WaYghlCeR9Tu96EHyaZ9Cq0Saku94FW/3
 tlk5OyiHjF69S8mxxTfiA==
UI-OutboundReport: notjunk:1;M01:P0:Ei+1Ejlrg2M=;/JTQUZNd6AIxlZKSJhMQW6M16Ur
 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
 ZCjIN
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/30/26 07:13, Ana Bobillo wrote:
> From: Ana Bobillo <anabobillo3@gmail.com>
>=20
> efi_image_parse() collects the regions of an image to be hashed for
> Secure Boot and for TCG2 measurements. It takes the header size, the
> section table, each section's raw data and the certificate table from
> the image without checking them against the image size:
>=20
> - SizeOfHeaders and each section's PointerToRawData and SizeOfRawData
>    are added as regions even when they run past the end of the image,
>    which is then read out of bounds when the regions are hashed;
> - the section table is read wherever SizeOfOptionalHeader and
>    NumberOfSections put it;
> - the end of the certificate table is computed in 32 bits, so a large
>    offset wraps around and passes the check;
> - errors of efi_image_region_add() are ignored.
>=20
> All of this happens before the signature is verified.
>=20
> Call efi_check_pe() first, check each offset and size against the image
> size without wrapping, add regions only through a checked helper and fai=
l
> on its errors, and require the file alignment to be a power of two. The
> padding of a section to the file alignment is hashed only as far as the
> image goes, so an image whose last section is not padded is still
> accepted. Check the certificate table against the size of
> WIN_CERTIFICATE, not of a pointer to it.
>=20
> barebox, whose EFI loader is based on this file, added the same checks i=
n
> 4ec1f7166778 ("efi: validate PE parser input ranges"); this is a port to
> U-Boot. Unlike there, an optional header with fewer than 16 data
> directories is still accepted if it holds the certificate table entry it
> declares: U-Boot's own EFI applications have six.

The PECOFF specification does not require any table. Six are needed if=20
you have a .reloc section which some non-compliant software assumes.=20
Aren't you describing a bug in barebox?

read_header() in=20
https://github.com/rhboot/shim/blob/e794a714339b1277abe9f890fc98de6e415681=
b0/pe-relocate.c#L376=20
has rather strict tests for PE files. It might be worthwhile to compare=20
their checks with ours.

>=20
> Fixes: 4540dabdcaca ("efi_loader: image_loader: support image authentica=
tion")
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
> ---
>   lib/efi_loader/efi_image_loader.c | 268 +++++++++++++++++++++---------
>   1 file changed, 190 insertions(+), 78 deletions(-)
>=20
> diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_imag=
e_loader.c
> index e31493d5135..35cf3cd268f 100644
> --- a/lib/efi_loader/efi_image_loader.c
> +++ b/lib/efi_loader/efi_image_loader.c
> @@ -393,6 +393,69 @@ void *efi_prepare_aligned_image(void *efi, u64 *efi=
_size)
>   	}
>   }
>  =20
> +/**
> + * pe_range_ok() - check that a range lies within the image
> + * @len:	size of the image
> + * @off:	offset of the range from the start of the image
> + * @size:	size of the range
> + *
> + * Return:	true if [@off, @off + @size) lies within [0, @len)
> + */
> +static bool pe_range_ok(size_t len, size_t off, size_t size)
> +{
> +	return off <=3D len && size <=3D len - off;
> +}
> +
> +/**
> + * pe_align_size() - round up a section size to the file alignment
> + * @size:	size of the raw data of a section
> + * @align:	file alignment, a power of two
> + * @aligned:	on return @size rounded up to @align
> + *
> + * Return:	true on success, false if @align is not a power of two or
> + *		the rounded size overflows
> + */
> +static bool pe_align_size(u32 size, u32 align, size_t *aligned)
> +{
> +	size_t val =3D size;
> +
> +	if (!align || (align & (align - 1)))
> +		return false;

FileAlignment and SectionAlignment should be checked once before the=20
loop calling this function instead of checking the same value multiple=20
times.

> +
> +	if (__builtin_add_overflow(val, (size_t)align - 1, &val))
> +		return false;

We are already checking for overflows in pe_range_ok(). Why use=20
__builtin_add_overflow()?

> +
> +	*aligned =3D val & ~((size_t)align - 1);

This whole function can be replaced by using the ALIGN() macro.

> +
> +	return true;
> +}
> +
> +/**
> + * efi_image_region_add_checked() - add a region of an image
> + * @regs:	pointer to array of regions
> + * @efi:	pointer to the image
> + * @len:	size of the image
> + * @start:	offset of the region in the image
> + * @size:	size of the region
> + * @nocheck:	flag against overlapped regions
> + *
> + * Add the region [@start, @start + @size[ of the image to @regs if it =
lies
> + * within the image.
> + *
> + * Return:	status code
> + */
> +static efi_status_t efi_image_region_add_checked(struct efi_image_regio=
ns *regs,
> +						 const void *efi, size_t len,
> +						 size_t start, size_t size,
> +						 int nocheck)
> +{
> +	if (!pe_range_ok(len, start, size))
> +		return EFI_INVALID_PARAMETER;
> +
> +	return efi_image_region_add(regs, efi + start, efi + start + size,
> +				    nocheck);
> +}
> +
>   /**
>    * efi_image_parse() - parse a PE image
>    * @efi:	Pointer to image
> @@ -401,8 +464,8 @@ void *efi_prepare_aligned_image(void *efi, u64 *efi_=
size)
>    * @auth:	Pointer to a pointer to authentication data in PE
>    * @auth_len:	Size of @auth
>    *
> - * Parse image binary in PE32(+) format, assuming that sanity of PE ima=
ge
> - * has been checked by a caller.
> + * Parse image binary in PE32(+) format. Each offset and size taken fro=
m the
> + * image is checked against @len before it is used.
>    * On success, an address of authentication data in @efi and its size =
will
>    * be returned in @auth and @auth_len, respectively.
>    *
> @@ -411,97 +474,135 @@ void *efi_prepare_aligned_image(void *efi, u64 *e=
fi_size)
>   bool efi_image_parse(void *efi, size_t len, struct efi_image_regions *=
*regp,
>   		     WIN_CERTIFICATE **auth, size_t *auth_len)
>   {
> -	struct efi_image_regions *regs;
> -	IMAGE_DOS_HEADER *dos;
> +	struct efi_image_regions *regs =3D NULL;
>   	IMAGE_NT_HEADERS32 *nt;
> -	IMAGE_SECTION_HEADER *sections, **sorted;
> +	IMAGE_SECTION_HEADER *sections, **sorted =3D NULL;
>   	int num_regions, num_sections, i;
>   	int ctidx =3D IMAGE_DIRECTORY_ENTRY_SECURITY;
> -	u32 align, size, authsz, authoff;
> -	size_t bytes_hashed;
> +	u32 align, authsz, authoff, header_size, num_dirs;
> +	size_t bytes_hashed, opt_off, opt_size, min_opt_size;
> +	size_t csum_off, subsys_off, dir_off, dir_end;
> +	size_t sections_off, sections_size;
>  =20
> -	dos =3D (void *)efi;
> -	nt =3D (void *)(efi + dos->e_lfanew);
>   	authoff =3D 0;
>   	authsz =3D 0;
>  =20
>   	/*
> -	 * Count maximum number of regions to be digested.
> -	 * We don't have to have an exact number here.
> -	 * See efi_image_region_add()'s in parsing below.
> +	 * efi_check_pe() checks the DOS and PE signatures and that the image
> +	 * is large enough to hold a 64bit NT header, which is longer than a
> +	 * 32bit one. Every optional header field and data directory entry
> +	 * read below therefore lies within the image.
>   	 */
> -	num_regions =3D 3; /* for header */
> -	num_regions +=3D nt->FileHeader.NumberOfSections;
> -	num_regions++; /* for extra */
> -
> -	regs =3D calloc(sizeof(*regs) + sizeof(struct image_region) * num_regi=
ons,
> -		      1);
> -	if (!regs)
> -		goto err;
> -	regs->max =3D num_regions;
> +	if (efi_check_pe(efi, len, (void **)&nt) !=3D EFI_SUCCESS)
> +		return false;
> +	opt_off =3D (u8 *)&nt->OptionalHeader - (u8 *)efi;
> +	opt_size =3D nt->FileHeader.SizeOfOptionalHeader;
>  =20
> -	/*
> -	 * Collect data regions for hash calculation
> -	 * 1. File headers
> -	 */
>   	if (nt->OptionalHeader.Magic =3D=3D IMAGE_NT_OPTIONAL_HDR64_MAGIC) {
>   		IMAGE_NT_HEADERS64 *nt64 =3D (void *)nt;
>   		IMAGE_OPTIONAL_HEADER64 *opt =3D &nt64->OptionalHeader;
>  =20
> -		/* Skip CheckSum */
> -		efi_image_region_add(regs, efi, &opt->CheckSum, 0);
> -		if (nt64->OptionalHeader.NumberOfRvaAndSizes <=3D ctidx) {
> -			efi_image_region_add(regs,
> -					     &opt->Subsystem,
> -					     efi + opt->SizeOfHeaders, 0);
> -		} else {
> -			/* Skip Certificates Table */
> -			efi_image_region_add(regs,
> -					     &opt->Subsystem,
> -					     &opt->DataDirectory[ctidx], 0);
> -			efi_image_region_add(regs,
> -					     &opt->DataDirectory[ctidx] + 1,
> -					     efi + opt->SizeOfHeaders, 0);
> -
> +		min_opt_size =3D offsetof(IMAGE_OPTIONAL_HEADER64, DataDirectory);
> +		csum_off =3D opt_off + offsetof(IMAGE_OPTIONAL_HEADER64,
> +					      CheckSum);
> +		subsys_off =3D opt_off + offsetof(IMAGE_OPTIONAL_HEADER64,
> +						Subsystem);
> +		dir_off =3D opt_off + offsetof(IMAGE_OPTIONAL_HEADER64,
> +					     DataDirectory[ctidx]);
> +		header_size =3D opt->SizeOfHeaders;
> +		align =3D opt->FileAlignment;
> +		num_dirs =3D opt->NumberOfRvaAndSizes;
> +		if (num_dirs > ctidx) {
>   			authoff =3D opt->DataDirectory[ctidx].VirtualAddress;
>   			authsz =3D opt->DataDirectory[ctidx].Size;
>   		}
> -
> -		bytes_hashed =3D opt->SizeOfHeaders;
> -		align =3D opt->FileAlignment;
>   	} else if (nt->OptionalHeader.Magic =3D=3D IMAGE_NT_OPTIONAL_HDR32_MA=
GIC) {
>   		IMAGE_OPTIONAL_HEADER32 *opt =3D &nt->OptionalHeader;
>  =20
> -		/* Skip CheckSum */
> -		efi_image_region_add(regs, efi, &opt->CheckSum, 0);
> -		if (nt->OptionalHeader.NumberOfRvaAndSizes <=3D ctidx) {
> -			efi_image_region_add(regs,
> -					     &opt->Subsystem,
> -					     efi + opt->SizeOfHeaders, 0);
> -		} else {
> -			/* Skip Certificates Table */
> -			efi_image_region_add(regs, &opt->Subsystem,
> -					     &opt->DataDirectory[ctidx], 0);
> -			efi_image_region_add(regs,
> -					     &opt->DataDirectory[ctidx] + 1,
> -					     efi + opt->SizeOfHeaders, 0);
> -
> +		min_opt_size =3D offsetof(IMAGE_OPTIONAL_HEADER32, DataDirectory);
> +		csum_off =3D opt_off + offsetof(IMAGE_OPTIONAL_HEADER32,
> +					      CheckSum);
> +		subsys_off =3D opt_off + offsetof(IMAGE_OPTIONAL_HEADER32,
> +						Subsystem);
> +		dir_off =3D opt_off + offsetof(IMAGE_OPTIONAL_HEADER32,
> +					     DataDirectory[ctidx]);
> +		header_size =3D opt->SizeOfHeaders;
> +		align =3D opt->FileAlignment;
> +		num_dirs =3D opt->NumberOfRvaAndSizes;
> +		if (num_dirs > ctidx) {
>   			authoff =3D opt->DataDirectory[ctidx].VirtualAddress;
>   			authsz =3D opt->DataDirectory[ctidx].Size;
>   		}
> -
> -		bytes_hashed =3D opt->SizeOfHeaders;
> -		align =3D opt->FileAlignment;
>   	} else {
>   		log_err("%s: Invalid optional header magic %x\n", __func__,
>   			nt->OptionalHeader.Magic);
> +		return false;
> +	}
> +	dir_end =3D dir_off + sizeof(IMAGE_DATA_DIRECTORY);
> +
> +	/*
> +	 * The optional header must hold the fields used here, and the
> +	 * certificate table entry when there is one. The section table
> +	 * follows the optional header; it and the whole header area
> +	 * (SizeOfHeaders) must lie within the image, as must the certificate
> +	 * table.
> +	 */
> +	num_sections =3D nt->FileHeader.NumberOfSections;
> +	sections_off =3D opt_off + opt_size;
> +	sections_size =3D (size_t)num_sections * sizeof(IMAGE_SECTION_HEADER);
> +	if (opt_size < min_opt_size ||
> +	    (num_dirs > ctidx && sections_off < dir_end) ||
> +	    !pe_range_ok(len, sections_off, sections_size) ||
> +	    !pe_range_ok(len, 0, header_size) ||
> +	    header_size < sections_off + sections_size) {
> +		log_err("%s: Invalid PE headers\n", __func__);
> +		return false;
> +	}
> +	if (authsz && !pe_range_ok(len, authoff, authsz)) {
> +		log_err("%s: Size for auth too large: %u\n", __func__, authsz);
> +		return false;
> +	}
> +
> +	/*
> +	 * Count maximum number of regions to be digested.
> +	 * We don't have to have an exact number here.
> +	 * See efi_image_region_add()'s in parsing below.
> +	 */
> +	num_regions =3D 3; /* for header */
> +	num_regions +=3D num_sections;
> +	num_regions++; /* for extra */

Please, avoid this increment by starting at 4.

> +
> +	regs =3D calloc(sizeof(*regs) + sizeof(struct image_region) * num_regi=
ons,
> +		      1);
> +	if (!regs)
>   		goto err;
> +	regs->max =3D num_regions;
> +
> +	/*
> +	 * Collect data regions for hash calculation
> +	 * 1. File headers
> +	 */
> +	/* Skip CheckSum */
> +	if (efi_image_region_add_checked(regs, efi, len, 0, csum_off, 0))
> +		goto err;
> +	if (num_dirs <=3D ctidx) {
> +		if (efi_image_region_add_checked(regs, efi, len, subsys_off,
> +						 header_size - subsys_off, 0))
> +			goto err;
> +	} else {
> +		/* Skip Certificates Table */
> +		if (efi_image_region_add_checked(regs, efi, len, subsys_off,
> +						 dir_off - subsys_off, 0))
> +			goto err;
> +		if (efi_image_region_add_checked(regs, efi, len, dir_end,
> +						 header_size - dir_end, 0))
> +			goto err;
>   	}
>  =20
> +	bytes_hashed =3D header_size;
> +
>   	/* 2. Sections */
> -	num_sections =3D nt->FileHeader.NumberOfSections;
> -	sections =3D (void *)((uint8_t *)&nt->OptionalHeader +
> -			    nt->FileHeader.SizeOfOptionalHeader);
> +	sections =3D (void *)((uint8_t *)efi + sections_off);
>   	sorted =3D calloc(sizeof(IMAGE_SECTION_HEADER *), num_sections);
>   	if (!sorted) {
>   		log_err("%s: Out of memory\n", __func__);
> @@ -516,14 +617,26 @@ bool efi_image_parse(void *efi, size_t len, struct=
 efi_image_regions **regp,
>   	qsort(sorted, num_sections, sizeof(sorted[0]), cmp_pe_section);
>  =20
>   	for (i =3D 0; i < num_sections; i++) {
> +		size_t size;
> +
>   		if (!sorted[i]->SizeOfRawData)
>   			continue;
>  =20
> -		size =3D (sorted[i]->SizeOfRawData + align - 1) & ~(align - 1);
> -		efi_image_region_add(regs, efi + sorted[i]->PointerToRawData,
> -				     efi + sorted[i]->PointerToRawData + size,
> -				     0);
> -		log_debug("section[%d](%s): raw: 0x%x-0x%x, virt: %x-%x\n",
> +		if (!pe_range_ok(len, sorted[i]->PointerToRawData,
> +				 sorted[i]->SizeOfRawData) ||
> +		    !pe_align_size(sorted[i]->SizeOfRawData, align, &size)) {

The PECOFF specification defines a default of 512 for the FileAlignment.=
=20
That is the value you should use if FileAlignment =3D=3D 0.

> +			log_err("%s: Invalid section %d\n", __func__, i);
> +			goto err;
> +		}
> +		/* The padding to the file alignment ends with the image */
> +		size =3D min(size, len - sorted[i]->PointerToRawData);
> +		if (efi_image_region_add_checked(regs, efi, len,
> +						 sorted[i]->PointerToRawData,
> +						 size, 0)) {
> +			log_err("%s: Invalid section %d\n", __func__, i);
> +			goto err;
> +		}
> +		log_debug("section[%d](%s): raw: 0x%x-0x%zx, virt: %x-%x\n",
>   			  i, sorted[i]->Name,
>   			  sorted[i]->PointerToRawData,
>   			  sorted[i]->PointerToRawData + size,
> @@ -534,25 +647,23 @@ bool efi_image_parse(void *efi, size_t len, struct=
 efi_image_regions **regp,
>   		bytes_hashed +=3D size;
>   	}
>   	free(sorted);
> +	sorted =3D NULL;
>  =20
>   	/* 3. Extra data excluding Certificates Table */
> -	if (bytes_hashed + authsz < len) {
> +	if (bytes_hashed < len && authsz < len - bytes_hashed) {
>   		log_debug("extra data for hash: %zu\n",
>   			  len - (bytes_hashed + authsz));
> -		efi_image_region_add(regs, efi + bytes_hashed,
> -				     efi + len - authsz, 0);
> +		if (efi_image_region_add_checked(regs, efi, len, bytes_hashed,
> +						 len - bytes_hashed - authsz,
> +						 0))
> +			goto err;
>   	}
>  =20
>   	/* Return Certificates Table */
>   	if (authsz) {
> -		if (len < authoff + authsz) {
> -			log_err("%s: Size for auth too large: %u >=3D %zu\n",
> -				__func__, authsz, len - authoff);
> -			goto err;
> -		}
> -		if (authsz < sizeof(*auth)) {
> +		if (authsz < sizeof(**auth)) {
>   			log_err("%s: Size for auth too small: %u < %zu\n",
> -				__func__, authsz, sizeof(*auth));
> +				__func__, authsz, sizeof(**auth));
>   			goto err;
>   		}
>   		*auth =3D efi + authoff;
> @@ -569,6 +680,7 @@ bool efi_image_parse(void *efi, size_t len, struct e=
fi_image_regions **regp,
>   	return true;
>  =20
>   err:
> +	free(sorted);

Here you are closing a memory leak. But this issue is not described in=20
the commit message.

Ideally for each issue there would be a separate patch. But at least=20
mention it in the commit message.

Best regards

Heinrich

>   	free(regs);
>  =20
>   	return false;

