Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF84606A329
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 12:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kLRPUMW/;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=W/9u2Bfk
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A9C834097D;
	Fri,  6 Nov 2026 12:48:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MwVZ6zBaFsdb; Fri,  6 Nov 2026 12:48:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D23A94095F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793969321;
	b=DpS6ZSl+7cq66WBl3wqySTmwIPIzNpC6qMoLzlS1769qw4+ACP59IHIfFsrlCmA8/P5t
	 92izfCWBiHUaf4jDP0IbR0ox/MTWdfRBjzdObfw8NskC8uSVxliOkU/Ow9VNJGnenqrGi
	 KNT5yS3lHrJdcEcMibEnjlkzQrYUswLCh+gotekw+8jqxMhx3fzTzpwLD2/sKU5lvcR89
	 RV/IGxLgA7zHQ9ClMonT0/k62FmHb8jz9GoMT129qHw7gxMvtKehMP2GgZhxKSewF/y7c
	 tccltKO+cmdKyxBUb1Y7d8Vi4sXYiUsl+tDZYQPZ/UcA9w5rQIoQx+17gYBvz74xxkg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793969321;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=N7ItCu/FRFqGuR90Hv8VxyxxTFh3qNxVLxDDZPbwuxY=;
	b=SxwN4TcTbuZI1/+DR2IRR3Nc8kHTh1TNNNKmgsXxPluxU9aZ5COob0hePKzPNNh7odfc
	 qUFYjHquWxG3BngI6FmjmqLmJQGBBz0z4xiyGB6kEdcvbroZKDckvPqqIk7M9Ofn4K37N
	 AEk6dhM3t1s+1OcFm0qi2mAEVpdtlg04n44EirhJm+bU7tHBKWyv/9CZTbgorFuWul1H1
	 n5m6cQ9UWo7wZpBhaHLLuF3aJFTIOmJV8nrCmPyTrCMadgI5WpngL00Ngd4LwWDNGOxdL
	 FkmCVCG0nZfX4yanV4kz9oowfPYIp7Bg/m3j5kKMhhNUe//dPwGjMr7qtHy33V3/37Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793969321;
	bh=N7ItCu/FRFqGuR90Hv8VxyxxTFh3qNxVLxDDZPbwuxY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kLRPUMW/2ENnicN5luCBQfg3P5htXgYnmqx3BKMj+joKx7VA3PlEbPRH3JRC3xlbt
	 oXI4rF9c25PECebwDQGGTD7Hf/w9agVaLiUEFiSWbKirhSC43EBkhqp1mGU5tJCahh
	 XYksFcLww5aSSI4hpQ9UxA28QfXKsAa3W93c1p+N5tDqif6L+Kumbo49Qf5fBbYrRb
	 ltZeOj4RXjs9wobNJpx005zA69UgtC9aCfGNvxVn/Rs4wDJ5fJj8ujoiYqPTH2IdYj
	 MRwwC6RQ8tBnocJtKHR7JC+fnGcLXzP2HCWJnXqWulGG3MAh9x+aMxww6Dh4iMTF+J
	 hCGS4dculpURw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D23A94095F;
	Fri,  6 Nov 2026 12:48:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8298032A
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 12:48:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 742FC607C3
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 12:48:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nwfrEXTPYOsv for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 12:48:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4DDC76064F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1129"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1129; helo=mail-yw1-x1129.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=W/9u2Bfk
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4DDC76064F
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 12:48:37 +0000 (UTC)
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-8b305e10ac7so4288077b3.0
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 04:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793969316; x=1794574116;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=N7ItCu/FRFqGuR90Hv8VxyxxTFh3qNxVLxDDZPbwuxY=;
 b=W/9u2BfkkSnd/2htWK3kJC6n4jkRHHWwwaDzfXXYDiBXfIRzYjdLJlt1kuCrQpvWY9
 rpKAJwbumiB9m0stBG6xsbm3bXHmuQeYwJThK4IOZ+fbwllc5tsFN8EmeMkkvXPT8bvj
 JrmQK2rSgkZvkQvO8BR7TjMe2LIWQfFWaIP9VRkV5D9oZNfzNX0t7zVkhHQCNxI7thBX
 EHH4QeOstbtf47LIliEcXENd17lOT0ku7JqTs1dvyYNoOSCwvN/AHZJp/Tv7oupewXMl
 +sCninvSRjbr5XJgGDFHH9o0Uy6eTrbohv4B1i96rNeE1obgymZ8Sn2q0rh0CRUrklfX
 jmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793969316; x=1794574116;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=N7ItCu/FRFqGuR90Hv8VxyxxTFh3qNxVLxDDZPbwuxY=;
 b=wxDzIl+Fu0yuUerU7lDV1u1ytVrg1H2YfHKGN03cKJ1/rVamEFXrsIWC1NR5NVJV/H
 g5ilZMmkhdv8dXfyRfE+f9d786YJ7QcW1UpP9gHEf7G+EdNaIKW26vVynzxFMlGQVYEt
 ftB9a3ZTyOwI0A2fAqSfNsf1CXTrDudwLJiaCJk+YsT/d/EshtFmw+KOHRjB5ilNiGP8
 lRGAg5sjEy70OtV2xDgShTLtqYC5NH6nknaA9nVPbLi+WQwTyXrX7hAa+PI88pZ3uNBp
 r6SBQe4vDttMfsdMvAx63frOlejYo0LSnIV+DZP5cxZlh/L5u8WdExRl/x1rqnbHSJOR
 3FgA==
X-Gm-Message-State: APuU4Z/Mxab2VZY9VjkD7QnHjDbUpUXMW5nA+ttt+nZmNbCRow9Ly/WC
 O/AhquENXAhQ6dgd8fJrlXxdEcUWUtkHtlIl+gMsjeJxE6Zmc9QNpTXIZsq+VatMlgpQr6nQ6TN
 PKHuSSp9rMQo02xaRNTlnO3rCj/mfbUmatKXyW3gnHg==
X-Gm-Gg: AYBFou298cEjDMesFE7cQNTQBSKUcAfFdMVsT2UmQRK1PAyBrY2H1sgpExgh6uwdKjt
 82hSui90tY5XOrUQuIjMB51YCvNtNfuNyhuUsBX3lY3LlFpArgwniTYDS9NuRv/itvmut7Pr88o
 4W+tPdCYzrRFCi3h61WAWem/wGMLXe9IpT6syPJy35iPP7LfdXZYS6ISdUHd8IhCg7XIy0LCAWr
 1LOa7GJnZSIqRNZbs5plp+ftjBNYmQgutyoLvZca+7ABRs3ZWlhN5tY5lIwwS0DcfmC6M9d8dxl
 hwycNxWsMka4CnaGsS5+yi1hQEtmHB04r3B31tRYYLqTHzUvyLGXFrkF6rvK6GxfWuRY4oVOV85
 ZPIwXaTr5xd6eo5bFuXXkiPfLtZpcvFOxTckmQcxZJe22d+6nve0Ex1ODJ7l+vAmgmBjNB5TIgj
 M15jjN44cWOhzHAVcYsv2A51h9x9XUYh2F2LqX8AMaUdtCDmEi8VyU5ZDs/CoWqaNIk77wCwNIV
 jFKn7Hyiq/VxJzMRxEuotfFWI2yBAgWt24u5buGOFUvcfOsRFULgMvdGjgovCQM4AXq2hZJ+aRc
 7eZkYKVPlASBmd4jdGJ+IYF25P0m5jk3725qaVy5LvoM0pbSgOOVuXaI4PRpeQiyaUAB1ikCWRR
 KujvKfm3Nju5s1YP4so3iBIa3S14YLRbDFN+v0CVQfYM9km/3qhWtCyfDspU89LdMvmThZKG5eH
 nby1Gy9UXUHt/XeK/Yr7p7yPYaV4JUwhmIpvQ=
X-Received: by 2002:a05:690c:8e09:b0:8b1:33bc:edf0 with SMTP id
 00721157ae682-8b341b8938fmr11187977b3.69.1793969311719; Fri, 06 Nov 2026
 04:48:31 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <ad3fd084-d61c-44e2-980f-c978ca1e1dbf@gmail.com>
 <b509d1f3-50f0-4b3f-97fa-724862cc92fe@gmail.com>
In-Reply-To: <b509d1f3-50f0-4b3f-97fa-724862cc92fe@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 6 Nov 2026 14:47:55 +0200
X-Gm-Features: AclHuK_6GVXlpHosS3_oT6-4HwfCSZrqYcKzZU0yNZW19VbKH2isjWCmbaARHWk
Message-ID: <CAC_iWjJg6aK1zy4ujOg-OfSK3Qt_NkTpgW3JRL08KaoYBTdzvg@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] efi_loader: check certificate lengths in
 efi_image_authenticate()
To: Ana Bobillo <anabobillo3@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 3 Nov 2026 at 18:13, Ana Bobillo <anabobillo3@gmail.com> wrote:
>
> From: Ana Bobillo <anabobillo3@gmail.com>
>
> efi_image_authenticate() walks the certificate table of an image by
> dwLength, rounded up to a multiple of 8, without checking it:
>
> - a dwLength of 0, or one that wraps around to 0 when rounded up,
>   does not advance the walk, so U-Boot hangs on such an image;
> - a dwLength larger than the rest of the table makes
>   pkcs7_parse_message() read past the end of the table and of the
>   image.
>
> As EDK2's DxeImageVerificationLib does, reject an image whose
> certificate table holds a certificate shorter than its header or
> longer than the rest of the table.
>
> Fixes: 4540dabdcaca ("efi_loader: image_loader: support image authentication")
> Fixes: 1a44b7059c18 ("efi_loader: image_loader: add a check against certificate type of authenticode")
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
> ---
>  lib/efi_loader/efi_image_loader.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
> index 73e96b63671..5a784bfb43a 100644
> --- a/lib/efi_loader/efi_image_loader.c
> +++ b/lib/efi_loader/efi_image_loader.c
> @@ -808,10 +808,27 @@ static bool efi_image_authenticate(void *efi, size_t efi_size)
>         for (wincert = wincerts, wincerts_end = (u8 *)wincerts + wincerts_len;
>              (u8 *)wincert < wincerts_end;
>              wincert = (WIN_CERTIFICATE *)
> -                       ((u8 *)wincert + ALIGN(wincert->dwLength, 8))) {
> -               if ((u8 *)wincert + sizeof(*wincert) >= wincerts_end)
> +                       ((u8 *)wincert + ALIGN((size_t)wincert->dwLength, 8))) {
> +               size_t remaining = wincerts_end - (u8 *)wincert;
> +
> +               if (sizeof(*wincert) >= remaining)
>                         break;
>
> +               /*
> +                * dwLength includes the WIN_CERTIFICATE header. A shorter one
> +                * would not advance the walk, and one longer than the rest of
> +                * the certificate table would make the signature run past its
> +                * end. Like EDK2, reject an image with such a corrupted
> +                * certificate table.
> +                */
> +               if (wincert->dwLength < sizeof(*wincert) ||
> +                   wincert->dwLength > remaining) {
> +                       log_err("Invalid certificate length: %u\n",
> +                               wincert->dwLength);
> +                       ret = false;
> +                       goto out;
> +               }
> +
>                 if (wincert->dwLength <= sizeof(*wincert)) {
>                         log_debug("dwLength too small: %u < %zu\n",
>                                   wincert->dwLength, sizeof(*wincert));

The code you just added above rejects the < case no ? So with this
we'll print something like "dwLength too small: 8 < 8".

Also the new check is similar to the old one. Combine them to a single
check that makes sense.

Thanks
/Ilias
