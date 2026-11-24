Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B916606A32D
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 11:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bXWPOvUh;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=EZf1ayER
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0AE3A607C7;
	Tue, 24 Nov 2026 11:53:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8w4hahIAYKe1; Tue, 24 Nov 2026 11:53:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4D299607E0
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795521187;
	b=G8RgnIqGXyQs8QMcRtELPg+a5KBSLfxdM/GgBq6eQSIfvY7AlKzedtnh8+lgqELSJPJN
	 jl+C/tuEZlwzVMzV64/Ic3Dxjc/fmvfOIvy9q5Prs+l4aI2wppVxUhjZ61Kk59Ru1xX5o
	 /VWAGLpxLSB7bw0RRUeGXgTBibH3/xV6FYuua8kQLYQ0rjMF1zbzp9DUVnv0Zb15rVn5g
	 WeQtrsyJRh9M/lb30H6qPAbb+1IxelEmjBOYtjQIHIzNmJJWQzKryLWxxphc9T3qCMTf9
	 mARq89MAHyWJ6PdA9BQoHqQjQZphr3ffS8fg9+izDcvqfDrm7RhEn+n4zb0/GvEHFRQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795521187;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VBQ1EQCUHYju3fgEHPgDVIbWWR/rwMh5zInFRHbvU5Y=;
	b=bjsnNZmPamu6HAvHIgrtRrnavU4uoteixng4B1p1zfdOAteMg58yc5ZDQ0gwbLRpJxgC
	 REVObp3bcXtX7LDA6fcyxPqsmUfOTmPNKT3zgCz4gvIa9tX0OwW6f/6INnVEFc4NhQ+hR
	 Gmt7KgfnLWp9G0A/mQqpqRqgHw5bhhQh0tXV66+0bNnu2ExyHZ+c9LJbj+SC9wMBwhLiJ
	 WPfcYL32YxgAMv7qzHocXWvK4H8VSoa+Pc2fwMkyzAbYrCADGUvdBW1CeqEI+d5TcDnyc
	 9+qjy4FPYUrlUT+5O6np2LHN1q1gbrPhLo1nV4ZCcJrxe5TEnUTPKwAUADaY73dinFA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795521187;
	bh=VBQ1EQCUHYju3fgEHPgDVIbWWR/rwMh5zInFRHbvU5Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bXWPOvUhXcIQn6RXvMgq8Xdosm3XzIq30k7snjahTnY/hMya2XzN34h+AhBRKyahA
	 1MvdgtyXk6pNB3IJbCbREAjhBe+hnF51XKaGx0QAPO+G+R495txyaUPGYRlOQ7jMPF
	 YwMeGtvrG699EBjJhdNwBi6t+9gh1Arww1oCavYHuPd06D0oghqzxrGeuR49dORrGp
	 QqaAiMGCbippe1QAU/+O0K71X5Jwc5V9H+heBJJY0Bk9EemvKxpvJNAaLKo9R5QUe0
	 BtxauXrVERQkNjmbn+iZ6zVDZ5XkKnniRFc4Nct1rcQ5LDnuasJGrMQtsVGIKqXvX7
	 ozqa5lwQ1G/3w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4D299607E0;
	Tue, 24 Nov 2026 11:53:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5FF8D1C9
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 11:53:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 45A6B40603
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 11:53:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B5tx3qDHxyPZ for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 11:53:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 81DEB405AA
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b129"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b129; helo=mail-yx1-xb129.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=EZf1ayER
Received: from mail-yx1-xb129.google.com (mail-yx1-xb129.google.com
 [IPv6:2607:f8b0:4864:20::b129])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 81DEB405AA
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 11:53:04 +0000 (UTC)
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-67da3d03263so4490023d50.1
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 03:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795521184; x=1796125984;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VBQ1EQCUHYju3fgEHPgDVIbWWR/rwMh5zInFRHbvU5Y=;
 b=EZf1ayERNAUXZhq/4D3bK48+0txfERKjZhP3EnuO+FKHaTR74rAvvtOFkJZ4joo9o4
 KDEfzFNTHfFq56+upZR9AtSUhexLTMiJ95BrG530rioSINHN1q9WFqmEgzx7JGObH9Pz
 k4ybDZS9ECyn47EIXl7muON11swiF9FQ0VesDCPegjkZW+lZVPbRr7cLD0Xkd2sXtjU4
 2GyK9dkIsPnGpwy9iCOEtXjyZIPnWNOQw9S2fDiZzuuulH85oSiUqNskJg5IA2+wHOB3
 n1jB54q1eF9ld2iQcCsOnPHBL6aqlX45lYfPZUsfmb7kn56cjDW2r9SOYDQG5Apq3hNT
 EO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795521184; x=1796125984;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VBQ1EQCUHYju3fgEHPgDVIbWWR/rwMh5zInFRHbvU5Y=;
 b=FjQ78JQGjY5bZkw10IL0a1rqYSB2cboyUwjfWR4tJ3d2ZsLKzdxqKgGmgQmA+D4aUD
 1smDGFaVwNiCrqzOs3mc4A4HHPWSAYsXbHLHj9LAYx+EWG9AKxfFx2E7vUUMeoaKRmZN
 JkeD7iunhX2eIxW+Im1AH3BVJCB1fW5kI4mgRpEHxsa9Jj9nCVJ/AQyPfXfbOZY+N5ah
 aYnbM0jXAJloSipHRSZUFVOv9ud8QHIenPoBMgfMcH9JWYLqsGNriDZ0jDHqiJJkaOu9
 KYXjk4otHImitn0yEynrIwmiAh4MPTALKzFfWTjsKdkV7UeIUBVQO67K1gBpzWqk86c1
 Nd5Q==
X-Gm-Message-State: APuU4Z+CwunH8Vdz0JXqnAiTvgFKmK4SeF5p0ABroaFib8zjF1QlmAmt
 89QEsaG/7UOLh+TBLzJQA/imDsN/2i5gqreXV5qsBlDR7+TKB3WautuTN4N2FiwjePeJgcxLoed
 kjd+kdCHw3G4LTLNzO8MdR9FyhuoT/ffgyVd37BF530HYe9YVZ1buiHjJqg==
X-Gm-Gg: AZFdTZfg7U3U8YJovBrWH6eJeKf+HExrEDcnZ6DWUCPCU8BtSjkW4xvO4WmsHO33Vwp
 fuwdI8+c8I6jE6QcA4SKxmR4dQsJbafzgN3mV27929fKEhQiHzj6rm2c0roahhHvw9V93Atyp2P
 oWg3a5hI8ESBPBxGnhbcW7mVYgqgfiYdc+Dl3DGISC7dZ8mvJu9vnFh2WVNHczJyStTxTHMeeAK
 dav8fsP4a842ROAjb/b8bM/zQfo6JCA6jl4Phy1SBbYksdI4y0mw+yufPvIBSz55h8f3hknXVKQ
 Yt9bKM/g6wQjONIMhQT24bvywxnTMWQ/ONY2s8Tgt1hc3EJ8VsPOOu572rY6x9128wGaH73GFUu
 RyIRSJWp7uZIY/ceGfVx4Q6Tk8Zc58nvAEtjgAxBtH4lPaGlQ5AVVJzMSgF/SDrdNDvN6OFyyTG
 ZlN6y1xo00uJvQCKHAcEYxLHDZ+R4jP8AMC1PzgHIY11h5TBCXP5sbxQ85TDcDSxvbk01oYY8OG
 La7fvbhHDti7+UwCtPiDfMx7HW4WlP1+1pFcOSkedgQMxbzUXEqwT0RG9ZKyqQMJ3GBrYphVBpi
 lYv93gmj5Kx1e7r6SMLlvQP3j1SddE9wSoWTFKANOEVYgzaG/Hq3wXaTWQRASXDf/Y7DItAcyZC
 go47zlR2aRsfYW2tL+8HH+tvD5BZf+2B+VN8tmh1QTuMBwiAlNIehrSAtjbVz0TM+OcXUYbrU+j
 fsC9EuBpP5cYRb1bAzhfCiZLdAUTc9jvXTKtpxT4Yf3wIz9v2tD1gjjS2UUrImNT22AbCC1pE=
X-Received: by 2002:a05:690e:1697:b0:67d:a31c:4f8 with SMTP id
 956f58d0204a3-67df44162dcmr4449314d50.58.1795521183619; Tue, 24 Nov 2026
 03:53:03 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <dacef858-56d7-4708-b784-16b0133bb6aa@gmail.com>
 <c997a5e1-d8de-44db-bd02-9b926c962625@gmail.com>
In-Reply-To: <c997a5e1-d8de-44db-bd02-9b926c962625@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 24 Nov 2026 13:52:27 +0200
X-Gm-Features: Aa3M54pJNl7m_iKlTvk0eme4c_39g1_3ozbXfvr5CY2myNRH7B3cKOe3YJ0eVbw
Message-ID: <CAC_iWjKEEdvmg8-Hj+9O4+N6HhpuwDMZbivuNKPUx6NyX7wEeg@mail.gmail.com>
Subject: Re: [PATCH v3 04/11] efi_loader: check PE section raw data against
 the image size
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 6 Nov 2026 at 23:56, Ana Bobillo <anabobillo3@gmail.com> wrote:
>
> From: Ana Bobillo <anabobillo3@gmail.com>
>
> efi_load_pe() copies each section from PointerToRawData in the image
> without checking that the copied bytes lie within the image, so a
> section pointing near or past the end of the image is read out of
> bounds.
>
> Reject a section whose raw data does not lie within the image before the
> image is allocated, also when VirtualSize is smaller and only part of
> the raw data is copied. barebox, whose EFI loader is based on this file,
> checks the copied part since 552a54e4d357 ("efi: loader: validate
> section raw data bounds against image size").
>
> This runs before the image is rejected when Secure Boot fails to verify
> it.
>
> Fixes: cb149c66342c ("efi_loader: Add PE image loader")
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
> ---


Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>  lib/efi_loader/efi_image_loader.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
> index b21947e979a..c6e7d5fc599 100644
> --- a/lib/efi_loader/efi_image_loader.c
> +++ b/lib/efi_loader/efi_image_loader.c
> @@ -1062,6 +1062,13 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
>                         return EFI_LOAD_ERROR;
>                 }
>
> +               /* The raw data of the section must lie within the image */
> +               if (!pe_range_ok(efi_size, sec->PointerToRawData,
> +                                sec->SizeOfRawData)) {
> +                       log_err("Section %d exceeds image size\n", i);
> +                       return EFI_LOAD_ERROR;
> +               }
> +
>                 virt_size = max_t(unsigned long, virt_size, end);
>         }
>
