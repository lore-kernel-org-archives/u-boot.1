Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4944C606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 06:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=H+Gg+v+K;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=sEr708LB
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 182D04062A;
	Mon, 16 Nov 2026 06:35:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LY1WYC2IqEja; Mon, 16 Nov 2026 06:35:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E3E604062C
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794810927;
	b=IS/hHX7tiLD7CfWbRlIeUKICpqmIb2LEV/+qphd86dGyaRIEfDjDRNS+ByClqUGM/2rX
	 VLqSHE8FVb1CiYRHTqb1nsjoIzeix3fSA6DFhBSWvNiClQfEv73gtg3To5TJS6KxSNlg/
	 tzXDdKHtvo0xq2Rj2DV0ONzGA0fw+DhRZnP9QTGHz5bMmqy2XYyAqd8zj3ToBM3UxNEzh
	 03OW2i5H3/9WHjEvVGPnNHOo4CSRnCjAFKVgVstQzvFZZZpKvC8jTpyXkdSeS220frioj
	 bNyPzzUwi++xGFGGIlxNpv9kNtE/u9vMmUPqvuVwKmenQ3cCgjdGjqtB0M+jFOGxAcA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794810927;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM2-Signature:Message-Instance:DKIM-Signature:X-UI-Sender-Class:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:UI-OutboundReport:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KyR7u7r7ewCm0wRmwl0Lj9SWbqnzoMsJXXvKt7Rjq9U=;
	b=rR4Zl2mH/KdBs7Dlt98owLUAfg/kNwqU0Axp2HG5BbD1wcm9zTGW4S0oUSnfD/xsje8Z
	 g62b+O56Ya65k/UTk4GMYzlMHkOqdxonLgsJT+cYiSidmAY7LdpQC02Ghri8Vsb5LRQgp
	 7p5SYE7SM4D84nBQuY6YIAMM8VbeanRaKWnHOMU6BMcncQ7Qkhy0rKDP/4vnXzeSPQHar
	 YQKsIDG7+OfewFzYRL6+KUY4/pXyHg9LAG42a7FcqIFy+hpg3E+MHtcO68yVCSXH+b/vo
	 y59ruz85QNN7k0jX9Oe9P/cTMEhXZVniJRmjPZvrmpvjkZO+yR/GiPgg6WMPxtYE7Gw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794810927;
	bh=KyR7u7r7ewCm0wRmwl0Lj9SWbqnzoMsJXXvKt7Rjq9U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H+Gg+v+KWSrWrrqntRH974Z+lH9B1a4hmSJlr7kPLAZjxQiK/GdWMfrQkVkwP/Hu4
	 +uEzm0et8f1shy3lq/F761IbKlyCKs+wNpZFNi6jmHjreEjRjfHZaWnFNUC4CASTYm
	 9Tw0ACMNmnwwG5Ce7xMmQPmwN8U0fnJ0w0pZe66uD4jLa6z84hjtFy7V74j4OrfYif
	 fJJ8t8dWKX+/gGXstGO5r5k2bDLokSMbRX2V9cHCLfF6A3X3JG4bVJ6qSOs9xt/m+x
	 marNvNLq5dEgqy2ejLzNxawMOMZEIP8TnjMj/LxedxgIOQRQNwG4u9mhYmyXivf1pk
	 f9JxVjHbRljXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E3E604062C;
	Mon, 16 Nov 2026 06:35:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9ED7D4A0
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 06:35:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 908874006F
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 06:35:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0snAM9I9t4qf for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 06:35:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9622040012
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=212.227.17.22
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.17.22;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=sEr708LB
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9622040012
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 06:35:22 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1794810921; mf=PHh5cHJvbi5nbHBrQGdteC5kZT4=;
 rt=PHUtYm9vdEBsaXN0cy51LWJvb3QtcHJvamVjdC5vcmc+; d=gmx.de;
 s=s31663417:rsa-sha256:YVU+/EpMhaRyVdR3ufg4P58uDKYl
 Fima/7X4Ctj5qvTbNV9uWrk0QQ7NiT3ibD1rVLfmRG7ZkfJBU727zSQptd/6u35xFcArQMdklHF
 7rH7/drZktClKTwuvJFedM/Mc0GdEqFlJ/JtVf5iTw/yy9gICbwstBXulcrlnQGC+15oxATptXi
 iaBsaA/D+XjRpxtKopLe2uCFo0/TvQ1P627VqcDxCQGlHiJq/wUdnkRX3ejvFWy1BTjN7MBE+/6
 vkU/oC3rs4jaPZxMezrRUthpX3db2jcZoYYChSxnY8/lwUncvaH0iYr9EnXepszqcBzCCG8YfCl
 96KKSunMfjTbBA==;
Message-Instance: m=1; h=sha256: 5fYWNKZANgeBraGp+NbN2pbKnDOFyZkK/B/fH+FXCOc=:
 zmkoxl6Q10uAIoWNZrA7RTKQ7h8BURJ/6YJ0ytyRkIM=, sha512:
 J9Tyk2AEZNVhRZW3RrykJ0xmjfSrc5AtECU6sk3wy8MiNneQsJWHEMIpSghMndFLoXdbQgSV5Oje+tGgBRG/Wg==:
 E04QnWeKGFmO23aNl010xIrz7ywwbNDbdn0oaq2yT3fZC15/mihhsesTkyVHmZGI54HTU4VMlWSE0qgb0SSW0Q==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1794810916; x=1795415716; i=xypron.glpk@gmx.de;
 bh=KyR7u7r7ewCm0wRmwl0Lj9SWbqnzoMsJXXvKt7Rjq9U=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=sEr708LB2HJVySqBHLsXcLcnkQ9T8BULZbzeeWSfHRiBDOQ2lQr/Adb57kKaa/OC
 dbYhb94kdgxESYB3iiwdO1qe0vNMXHXAIg3x/XBHcW5T7u6bssbh+1YSKOirMFL5y
 oyiohzE/oWadbG420tQL0ltjqrABzRhGrKVPKH8Xne7Aw+Wol5ma00zaMa/2alarS
 e5z8OjQPedcB5n36+LOnkmcWQQLpfjqJrkSh+OeQyRm9P0Sy6WrMWvyx0q2olBI2l
 SUYhaDnMiOCBxFpDjRzUGIzlWcWtbWbt2tGQHkFWZ018G0HTaB+nDCXUD+CAU5jvf
 lsZdxAjKRglpAEKzzA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMXQF-1xC8XL2IXH-00INAC; Mon, 16
 Nov 2026 07:35:16 +0100
Message-ID: <ca575a50-58f1-4318-ad5e-611dc7907232@gmx.de>
Date: Mon, 16 Nov 2026 07:35:10 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: http: prevent stack overflow in URL conversion
To: George Kola <georgekola@google.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, =?UTF-8?Q?Vincent_Stehl=C3=A9?=
 <vincent.stehle@arm.com>, Adriano Cordova <adrianox@gmail.com>,
 u-boot@lists.u-boot-project.org
References: <CAOTQ16L9__jZh-oVkY0xa_tUvh_x8xQE1tsHdHOAQRYv-XXO+Q@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAOTQ16L9__jZh-oVkY0xa_tUvh_x8xQE1tsHdHOAQRYv-XXO+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:r8c+fPZX4oM/w29InChqLi91LDlcQPhAL5x0yYN/cSfmUKJCUNQ
 bHltPD8TBr1cA3HlBzRwN69r07wkIO2Oecv/p0FwH0ereP5qfD4+KQDhtUXytMh2Giy3EmI
 J+71TkujRqvtK9BpMHO+L70M4U9Jwsb0udzQ/28GKch9zGLluDfMNp9DRxm9RKAS5BgFHvK
 KtDXUVTkPef8MZZnhpq3A==
UI-OutboundReport: notjunk:1;M01:P0:dTccc5BkkIE=;UxRgvEVU+2s7bkbgb4lgnT9fYZ1
 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
 PO85orVsKiIes=
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/15/26 18:12, George Kola wrote:
> efi_http_request() converts the caller-supplied UTF-16 URL into a
> 1024-byte stack buffer url_8 using utf16_utf8_strncpy(..., 1024). The
> count argument bounds Unicode code points rather than output UTF-8
> bytes, allowing multi-byte code points to write past url_8 on the
> stack.
>=20
> Validate that url_16 is non-NULL and that utf16_utf8_strnlen() fits
> within sizeof(url_8) including the trailing NUL byte before copying.
>=20
> Fixes: 238e0269d82f ("efi_loader: efi_net: add EFI_HTTP_PROTOCOL")
> Signed-off-by: George Kola <georgekola@google.com>
> ---
>   lib/efi_loader/efi_http.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/efi_loader/efi_http.c b/lib/efi_loader/efi_http.c
> index 5c6367a9e5..f61b99685f 100644
> --- a/lib/efi_loader/efi_http.c
> +++ b/lib/efi_loader/efi_http.c
> @@ -237,10 +237,15 @@ static efi_status_t EFIAPI
> efi_http_request(struct efi_http_protocol *this,
>=20
>   	current_method =3D token->message->data.request->method;
>   	url_16 =3D token->message->data.request->url;
> +	if (!url_16 ||
> +	    utf16_utf8_strnlen(url_16, sizeof(url_8)) >=3D sizeof(url_8)) {

Hello George,

Thank you for addressing this issue.

For a URL that cannot be processed due to an excessively long URL we=20
should return EFI_OUT_OF_RESOURCES.

Currently we use a 1024 byte buffer for url_8. I don't see a basis for=20
this specific limit. Firefox for instance allows 65536 characters.

EDK II keeps a pointer to an allocated buffer in the HTTP instance to=20
which `this` points and reallocates it if it is too small. See=20
EfiHttpRequest() in NetworkPkg/HttpDxe/HttpImpl.c

> +		ret =3D EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
>=20
>   	/* Parse URL. It comes in UCS-2 encoding and follows RFC3986 */
>   	tmp =3D url_8;
> -	utf16_utf8_strncpy((char **)&tmp, url_16, 1024);
> +	utf16_utf8_strncpy((char **)&tmp, url_16, sizeof(url_8) - 1);

The size parameter of utf16_utf8_strncpy() is for the number of UTF-32=20
characters. sizeof(url_8) - 1 does not avoid any buffer overrun here.

RFC 3986 limits the characters that may be used in an URL. Any character=
=20
outside 0x20-0x7f is definitively illegal.

utf16_utf8_strnlen() and utf16_utf8_strncpy() do not consider this.

EDK II just truncates to the lower byte in UnicodeStrToAsciiStrS() and=20
crashes in debug mode due to an ASSERT() if a UTF-16 token > 0x100 is=20
encountered. This seems completely wrong.

EDK II further returns EFI_INVALID_PARAMETER is the URL is not correctly=
=20
formed.

As this usage of EFI_INVALID_PARAMETER is not described in the UEFI=20
specification I have opened
https://mantis.uefi.org/mantis/view.php?id=3D2639

George, please, resubmit the patch with at least the return value fixed.

Best regards

Heinrich

>=20
>   	ret =3D efi_net_do_request(url_8, current_method,
> &http_instance->http_load_addr,
>   				 &http_instance->status_code, &http_instance->file_size,

