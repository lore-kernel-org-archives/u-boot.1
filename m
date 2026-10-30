Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0BE606A31E
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 13:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=KU9JIW6k;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=dV4CjwGy
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 629AA60A41;
	Fri, 30 Oct 2026 13:09:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zByS0EdrW759; Fri, 30 Oct 2026 13:09:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 94828607B6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793365782;
	b=TamtYYLoAV2FmZe/2WK2Yo3Z42EBsean3bL7pwxjn6AeXeOvz7T4Y/zdyXmQ37HLQ18f
	 nTrQ3bO+yi3KodO/dIdIeFJ2uZQwccHgTbrv/BcEeZzf7nuTXZyMDvxmDlk6iKdLxAa8a
	 AkvDgCg2wL/B++TMFWdTzSpInh/gHvYesqwXo1RaNbS3yF+3Bx6g8EpNw75Qn9OsUq2Ym
	 bSeWs9Wst7AMpH9Vp0N4LWeN6o7ZYfGemlPXLSTxz8gXWupSHU4Q//brruYutAUecXa2x
	 RrkJr8XLa9+liXkwDNjF+nGZY/P+/gzwlNPuLgg5BqbfWF38L/LjDjVdR4bFa3+nyDQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793365782;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Provags-ID:
	 UI-OutboundReport:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=vekBWxQhK3Wm9dQSa4FUVVLSa/FiTZAKJU2XwwS4f6g=;
	b=FjKJ3UTg7j66c5aBuoLn55720Jne0BNV+tbHYz4kXImZz+DDwb+pxZB+svkT32Uob2ad
	 LHmV4xgYmr+DKjWGszk4Nig9I5LoeGF8Hj6WEzWipSRtAMRASxcWNE3dpTWH4HWQAtXKF
	 9iGeUrlFPue8gdwDjnekOZFnC2ILBQ5koKb+XkJEsHKTy+MdwCjU2qoqxSTs1ayVZrsOX
	 4KU9JheqtPi3zT8vqqIcsg53LymweqNbNJNtaLbsGjVSa7aEwY93zXhTeDd8bGLaNQqL+
	 U0rcpDItfXxkbfBbc8kwb/5BGT3WH8vE4B6y07lCnBPkMhS49JwOloblcHBluOJ0oWw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793365782;
	bh=vekBWxQhK3Wm9dQSa4FUVVLSa/FiTZAKJU2XwwS4f6g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KU9JIW6kxsQ9t62Nqg+muX2T+Q7SCmTWG5ltKdD0pVUX3uD7tCsX0O4qNAbjd+VFg
	 Ij9bMCjoRWx03hNrG/Jprz1ZjI12Ct0pdmX5ReXvCD4FFh6tUWAE7JZ3rruFPgTjaO
	 QQWQxeb4rw5QPOkazgwhSZnpDK8OgfTWZsLMBXLh0X/jaDswEM/m8HmtQ+DVtw2DcL
	 LTwpfZbN48b9jhUzp9mezXtMO3SA5z5glmD9+ZVoX/QD0jsEEfZWUqnnxEbpHAoD27
	 eIrKtxtCcEWUxPOZGk0WVRM5a4c009HtcCqOwgbv8q3F7q30En2yPwR/t+QTEhT53H
	 f2c0UAlQBlvsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 94828607B6;
	Fri, 30 Oct 2026 13:09:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A74ED38
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 13:09:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2019A80F76
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 13:09:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XEi8fVIasjmJ for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 13:09:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BE30080F0E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793365779;
 b=MgpMpeAED1WMPt5ZZGCFQpyTvRabBTqGoTexlaRzZ4g10mGtkLT2DNhTgXAvkHTMg64M
 vBPeTQRlN/E4f4u+eG5T/A4WzTvIqIGJv859J+dgNBkEuFQ+AFMDoWlKNGJzDlSbFq6Kb
 1kblgb+RVNWt7OnWcV+B9XLf8EaIFqjdTElvc5juLBxyTzSQZDwNOiUQbCU5/f+xK8Z9D
 uSXD2K+M1OgOPgL0LYnLSR3ZqR+aUiHLJU0qLCJp5hbeC8mzx4lfdkBEfGyvevcKuaYB7
 1hJs3rTgOJzEDofXieQ0jvHAurnF8Y6wWjgE1hoGyEbXh3/IMMFhGRJREKu8KCJkGrw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793365779;
 h=Received-SPF:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
 bh=vekBWxQhK3Wm9dQSa4FUVVLSa/FiTZAKJU2XwwS4f6g=;
 b=gBnzZUzGQW6VZWaV3HeUma0XPACrFeP2yk0ImiGLwXL/4Uf1awlB7UYl2+QLSuBJvD3r
 17eC5Co+ummhb4CIU0H8YDphJTbmBch5ns6x/3ZASwO3wlNNeLFvwHbNXUCMIz845Jozw
 zvAbE/G2uTwAZPBfiMwdzl5XU5EKDhNhhhreSPXdyNxQ8wJeYDzEGudBzhYMkvhugy2uh
 fcGx9CVdErYzeG6/opBiO9ri2vIyvCQIc3Uw+yTTz5PnjuLJzHkTt2bhaNRG3q1t8xKNz
 eYXttwfyTbt725fERf6CLDC14jd9+vW6aKyaT2isDfvoBgGrhObTYoni+LAfkzb0giA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmx.de;
 dkim=pass header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=dV4CjwGy; 
 arc=none smtp.remote-ip=212.227.17.20
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.17.20;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de
 header.a=rsa-sha256 header.s=s31663417 header.b=dV4CjwGy
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BE30080F0E
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 13:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1793365775; x=1793970575; i=xypron.glpk@gmx.de;
 bh=vekBWxQhK3Wm9dQSa4FUVVLSa/FiTZAKJU2XwwS4f6g=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=dV4CjwGyqhQXg+9kdlVAbC1SwFkEsfS0zywFf6et6LEfoBEPFWdceHqmO7yt3XjT
 wYE/390t1Wwq640X3RWUtiUIyafYm8Ya0OZRTldwnUmA57sleFt/qjUHoyQie+XRL
 bPnStPTAuy9hvr1VDETWNNlmJmkE31Ddw7DUK8+wJs65tfotyB0I9xX+07W9Bmaf4
 yiV9yCy/NBqP34MsW+88dLcKIiGpwc6OutoArYen9rk2lFZP1d5BW+qURvXgzWUjB
 fQGjt1vz4htXrxvC7PH+4IsrwjQri00NbMU33ZAlJGWNGW3TEfdsRl1pnfqKsw4pi
 WCgWZIBhtro2P8Kjag==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMGNC-1x4h0j05kE-00OW8a; Fri, 30
 Oct 2026 14:09:35 +0100
Message-ID: <0488b054-751f-4de7-9cfe-7626e5444eb1@gmx.de>
Date: Fri, 30 Oct 2026 14:09:31 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] efi_loader: check that the PE headers fit into the
 loaded image
To: Ana Bobillo <anabobillo3@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
References: <633dddd6-ee22-4cd6-a8b6-cb7df0650fae@gmail.com>
 <07737350-49e9-420c-992d-6a290c2e0d76@gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <07737350-49e9-420c-992d-6a290c2e0d76@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1s9cbZAtK1ceDTb4WDjbHSrcfNpK2kDnZhUZ72cRdg42th0NeXn
 xrKa+BCp0KnRaf2UXFgrSzkEujIbbxKM5fARYlFuR5gYj4DIASZCG8vsNaMwBov6fy/waMw
 V9TQwf7GZerYRF5A4a4xIxY08YjG0qbCJIw8X/wddNB8ZZTQi7+/I5dXpHlUJRBGiqAyI7s
 9HXW5OsJOR0p/BaM4Kbaw==
UI-OutboundReport: notjunk:1;M01:P0:J1nvdg/S7SY=;v768uPgP6BqGLPYiRnOQLKO8Cq6
 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
 8Ic1qj/Txp2gM7n0OJ1CVY9ZDcg==
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/30/26 07:14, Ana Bobillo wrote:
> From: Ana Bobillo <anabobillo3@gmail.com>
>=20
> efi_load_pe() copies the PE headers to the start of the allocated image.
> The size it copies is not the size of the headers: it adds the size of a
> whole 32bit NT header, which already holds an optional header, to
> SizeOfOptionalHeader, and assumes that the NT header follows the DOS
> header directly. Nor is it checked against the size of the allocation,
> which only covers the sections. An image with many empty section
> headers but little section data makes the copy write past the
> allocation, and the copy reads past the end of a small image.

For secure boot we are looking at all regions. Shouldn't we make

>=20
> Copy the headers up to the end of the section table, which is already
> checked to lie within the image, and reject an image whose headers do
> not fit into its virtual size before allocating it.
>=20
> This runs before the image is rejected when Secure Boot fails to verify
> it.
>=20
> Fixes: 8458bf648fd7 ("efi_loader: set image_base and image_size to corre=
ct values")
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
> ---
>   lib/efi_loader/efi_image_loader.c | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)
>=20
> diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_imag=
e_loader.c
> index 7fd03ac6211..f9cd2cb274c 100644
> --- a/lib/efi_loader/efi_image_loader.c
> +++ b/lib/efi_loader/efi_image_loader.c
> @@ -1010,7 +1010,6 @@ efi_status_t efi_load_pe(struct efi_loaded_image_o=
bj *handle,
>   			 struct efi_loaded_image *loaded_image_info)
>   {
>   	IMAGE_NT_HEADERS32 *nt;
> -	IMAGE_DOS_HEADER *dos;
>   	IMAGE_SECTION_HEADER *sections;
>   	int num_sections;
>   	void *efi_reloc;
> @@ -1020,6 +1019,7 @@ efi_status_t efi_load_pe(struct efi_loaded_image_o=
bj *handle,
>   	int rel_idx =3D IMAGE_DIRECTORY_ENTRY_BASERELOC;
>   	uint64_t image_base;
>   	unsigned long virt_size =3D 0;
> +	size_t hdr_size;
>   	int supported =3D 0;
>   	efi_status_t ret;
>  =20
> @@ -1085,6 +1085,16 @@ efi_status_t efi_load_pe(struct efi_loaded_image_=
obj *handle,
>   		virt_size =3D max_t(unsigned long, virt_size, end);
>   	}
>  =20
> +	/*
> +	 * The PE headers, up to the end of the section table, are copied to
> +	 * the start of the loaded image and must fit into it.
> +	 */
> +	hdr_size =3D (void *)(sections + num_sections) - efi;
> +	if (hdr_size > virt_size) {
> +		log_err("PE headers do not fit into the image\n");
> +		return EFI_LOAD_ERROR;
> +	}
> +

Shouldn't we ensure that we always allocate this amount of memory=20
instead of failing here?

Best regards

Heinrich

>   	/* Read 32/64bit specific header bits */
>   	if (nt->OptionalHeader.Magic =3D=3D IMAGE_NT_OPTIONAL_HDR64_MAGIC) {
>   		IMAGE_NT_HEADERS64 *nt64 =3D (void *)nt;
> @@ -1141,11 +1151,7 @@ efi_status_t efi_load_pe(struct efi_loaded_image_=
obj *handle,
>   #endif
>  =20
>   	/* Copy PE headers */
> -	memcpy(efi_reloc, efi,
> -	       sizeof(*dos)
> -		 + sizeof(*nt)
> -		 + nt->FileHeader.SizeOfOptionalHeader
> -		 + num_sections * sizeof(IMAGE_SECTION_HEADER));
> +	memcpy(efi_reloc, efi, hdr_size);
>  =20
>   	/* Load sections into RAM */
>   	for (i =3D num_sections - 1; i >=3D 0; i--) {

