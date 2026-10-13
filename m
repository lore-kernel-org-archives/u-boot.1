Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4DAACC6B0E
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 14:30:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D1BF440533;
	Tue, 13 Oct 2026 14:30:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VFGOKGDQletE; Tue, 13 Oct 2026 14:30:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6E23D4040E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791901847;
	b=md7YRHUo4hDNf1VSENZ/qyULL5BOiKVd1FGvTLzKkwTuf/ihUMTMtV2BlReTkspNx0Ce
	 iqMUnSr0UzP877cnJvB3r2iz/yD12g6XN+qjFUJpmxoFR3KhToKKkd0Ia1nx+nJLMnANd
	 hgWsMGLJY7hD5MV14UYjQoc9yy22FNpBUnj4QnqVQEeZOU7QKS/ulOvO1KPgw5IyN/7Ig
	 lVI4u+sChfgBUHNkc8iAy4D5m01IhEvWz9kYuWxYfv7232J30tKD8/d0a/xZtBSCGVDsA
	 598igFgjX5LfqnuZqZFWEgnt9FTRdnOvLjU6BpWD5wg4eSpmpJmzxd1ZZNpqJjyWamA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791901847;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SIOPKR6eMRqetGfg7x2KMpP6Q3mce/vq8qDg8NRV8cU=;
	b=rwsKAG6DBCQGb+5L7KpdyR71uS58fVvADH5RFkPF/Ir3wrT5ChH13f8AxoJIaE9pvB2k
	 CIFi9BSIJv1ZjI4NbrrJMrLfS7NeVyKmUUIZ8uvuDBCUhrdnNSg8p+jIz0IXvAbLLVSqZ
	 fWs7IMOofFz2+qYD+rGPK4uWyYWxIzLer7f1ImY4+cKkjLZGnHiq6Qy8YIa9FH2k0c714
	 3t7nIaXPaQ5P9dZ3H/hcs4PDHFxpELuqN0mr6vn+p9Hai7CCERXPH7Tv2IVLuVxADMN5O
	 gPVyDm1HY+Eb8HovderpfXlTFN/4IzuqwFujqih2Zp+j1MIdQvuwTSFwVIBVxzEln3Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791901847;
	bh=SIOPKR6eMRqetGfg7x2KMpP6Q3mce/vq8qDg8NRV8cU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oPHi7aG+vmyAk5Q63YonQ+PkLkydjU4Bl6XgGRB95RKUZUP+bFbWHqON/iNbRBTIQ
	 BgckxsXNVKztu+m57O1OfCaUNJlft2wlJ0Tnn8In+fALe5ba0aWAF3W/dJkHZGT3vZ
	 2JicC6P1sBVLxkyIayoHxKIAWG9z5XtpvBJ7Sw3uJPJRLWCOXySfv1paatflHSBWCK
	 8JinLtytITRLdTpQKjHhtpezGPRWB+YgV4VjojruYxBIm319/v6kkwnkiN/RdQZDoe
	 Qmk5YtlNJTaSKBAU3ZIKPhTjZ0ZogdbxBO9j6XDmp7Szu3Qvs5F1S7rJFs7/Q91Iwx
	 HAUlmcY0P1fKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6E23D4040E;
	Tue, 13 Oct 2026 14:30:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CB24175
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 14:30:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B0C60809BB
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 14:30:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CMXcHJihTgJS for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 14:30:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CB54A80989
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791901844;
 b=popNswAdBlZaLEC7Wuxb2cd8dKJ5xcGNKeyWD//RGgInGxsWTyUKJKNLm/66Ag9G4Eo4
 ND78t6Y5s4oiY2b53GkPQYXEhHsptHxBVYM2Ye5fnZZuPg2GmcypFMoQT6RyTb5ivOVTJ
 /PwssIaX8LNx7TgYHi1OBxT8q6cxYys43aqBWtTN+bPl1BVe7AAFxJMp+ji266qrTWNXf
 4BVb4gO5TYLG1ZgYvz+YPiassB8Z7MMLb2KYQb4XLPKKINfY0J0CEqL9Nc82CLqdnWXB6
 DLejioWNACM1SqaYy6GsshI4wAPKKdwJZ1nVjLyfhBRmEyPFW48sdlnS3RdWs86JI7w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791901844;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=SIOPKR6eMRqetGfg7x2KMpP6Q3mce/vq8qDg8NRV8cU=;
 b=BIPgKcFetXMShW12YKE4M5B5sYYXnGPyulq+k6VeyIDXoGHnhejd0PF1L9aHwGEjA2Gm
 5JHlvG/ppKL0GI5tM1/O5Ef4FzXg9/CnGLLR7qqGy9Q94k36TTTUnB5Kc3hsiOaM0MXOw
 cWijjS7Djxz4hwPJP6xGQ7b+LfFa9+U3y77NIarsp6hf+O+40V6z7XCoO/5kYci+lZ/1n
 zuPd4iH+QLT5QmloVy+iCvJpZqTH49h4ITwylmh+P15xGKxdh9KFqZ8dm2KcKZwTq5DTn
 iiOhESC9d3nzORZyKFaB9BZZmSGNPc38x8p1H6dn8h9xC5qqcZl0OI3TjVklV/lYWMQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=REWPNx4H; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=REWPNx4H
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id CB54A80989
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 14:30:42 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEA52169E;
 Tue, 13 Oct 2026 07:30:38 -0700 (PDT)
Received: from debian (X72Y076X74-2.nice.arm.com [10.34.124.254])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3AC153F673;
 Tue, 13 Oct 2026 07:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1791901842; bh=GJQJA7OqgwgeABIFoMAD0+DrnLRrJDd9y/KtxjaOycQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=REWPNx4H8vE5Bsl8As/878CSF+G9DxuwqVH+QvROHk5od4f/HdEOXaNm9Uzp21xgh
 xqoatTH+Jyv2KmwzCzb8nlwXHtqdbmfx0bzV6gTzhLRTZ8H+5wAQV3JF9i5qraVs2s
 gyosmmfPaLkuU6CSyOmrTPG8ON9jidO7SI6hYGTg=
Date: Tue, 13 Oct 2026 16:30:38 +0200
From: Vincent =?utf-8?Q?Stehl=C3=A9?= <vincent.stehle@arm.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 1/1] efi_loader: fix HII GetString()
Message-ID: <as5AjpXoba_sO57O@debian>
References: <20261012191053.16783-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012191053.16783-1-heinrich.schuchardt@canonical.com>
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

On Mon, Oct 12, 2026 at 09:10:53PM +0200, Heinrich Schuchardt wrote:
> * Add missing conformance tests.

Hi Heinrich,

Thank you for continuing the work on the HII protocols.
I do not see those additional tests in this patch.

Also, one comment below.

Best regards,
Vincent.

> * Return EFI_INVALID_LANGUAGE if a string does not exist in the requested
>   language.
> * Handle querying the string size with *string_size == 0 and string = NULL.
> 
> Fixes: c9bfb22296b0 ("efi_loader: Initial HII database protocols")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
> 	string_id == 0 is not used by our code. Return EFI_NOT_FOUND.
> ---
>  lib/efi_loader/efi_hii.c | 34 ++++++++++++++++++++++++----------
>  1 file changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/lib/efi_loader/efi_hii.c b/lib/efi_loader/efi_hii.c
> index 90dff91e5d4..dc02d7d2ba6 100644
> --- a/lib/efi_loader/efi_hii.c
> +++ b/lib/efi_loader/efi_hii.c
> @@ -910,41 +910,55 @@ get_string(const struct efi_hii_string_protocol *this,
>  {
>  	struct efi_hii_packagelist *hii = package_list;
>  	struct efi_string_table *stbl;
> +	efi_status_t ret;
>  
>  	EFI_ENTRY("%p, \"%s\", %p, %u, %p, %p, %p", this, language,
>  		  package_list, string_id, string, string_size,
>  		  string_font_info);
>  
> -	if (!package_list || !efi_hii_packagelist_exists(package_list))
> -		return EFI_EXIT(EFI_NOT_FOUND);
> +	if (!language || !string_size || (*string_size && !string)) {
> +		ret = EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +
> +	if (!package_list ||
> +	    !efi_hii_packagelist_exists(package_list) ||
> +	    !string id ||

Missing "_" .......^

> +	    string_id > hii->max_string_id) {
> +		ret = EFI_NOT_FOUND;
> +		goto out;
> +	}
>  
> +	ret = EFI_INVALID_LANGUAGE;
>  	list_for_each_entry(stbl, &hii->string_tables, link) {
>  		if (language_match((char *)language, stbl->language)) {
>  			efi_string_t str;
>  			size_t len;
>  
>  			if (stbl->nstrings < string_id)
> -				return EFI_EXIT(EFI_NOT_FOUND);
> +				goto out;
>  
>  			str = stbl->strings[string_id - 1].string;
>  			if (str) {
>  				len = u16_strsize(str);
>  				if (*string_size < len) {
>  					*string_size = len;
> -
> -					return EFI_EXIT(EFI_BUFFER_TOO_SMALL);
> +					ret = EFI_BUFFER_TOO_SMALL;
> +					goto out;
>  				}
> -				memcpy(string, str, len);
>  				*string_size = len;
> +				if (string)
> +					memcpy(string, str, len);
> +				ret = EFI_SUCCESS;
> +				goto out;
>  			} else {
> -				return EFI_EXIT(EFI_NOT_FOUND);
> +				goto out;
>  			}
> -
> -			return EFI_EXIT(EFI_SUCCESS);
>  		}
>  	}
>  
> -	return EFI_EXIT(EFI_NOT_FOUND);
> +out:
> +	return EFI_EXIT(ret);
>  }
>  
>  static efi_status_t EFIAPI
> -- 
> 2.53.0
> 

-- 
Vincent.
