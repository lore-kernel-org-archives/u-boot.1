Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C88C8E7849A
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 07:45:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26DAC86587;
	Mon,  2 Oct 2023 09:45:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KTITKSWT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8F48870E4; Mon,  2 Oct 2023 09:45:00 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8661D8646E
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 09:44:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31427ddd3fbso14863361f8f.0
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 00:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696232698; x=1696837498;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=VJ8TwVIm45hDSutmESkhoFcRWNxtZpNFg3xHwBf7CxU=;
 b=KTITKSWTBSySqW7Wf9uk162XJVw2k4CWrFC38yUAcvx7rr1fJHFzr7JfjpX1MgBOOw
 /zSS3Evz5ZcUBmgCNJYDInsUckf+If1O0QsU89VVrIr9kqizAn5I5li+K1ZP/D9HTcHG
 C6JsyQRl327CfepUr3ybZ/umryKX0sumIB7wNwNInqjaOwm9fAVhmL8pKOOtwCYNIw55
 dHZBuhKqgH284k17PO0t7VXcz3cc0ZyhL2Zc+OEQTM6N5bup2igsax8AQWcyl8JovW+9
 mG8XKDBBW/E3v1sfWM4ASblfbtV3KzHLGg/PCwYF6KHghkbPCNLsSz6ucM1RSsvnRzKc
 rm/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696232698; x=1696837498;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VJ8TwVIm45hDSutmESkhoFcRWNxtZpNFg3xHwBf7CxU=;
 b=tQDN1skVOOWKTLB0csOoDeHQ+XBFBHdpu4FnZigpddXufHaO0AqWu5Z49k1sL5P+I3
 +EY32H3EwsdMFuZSMkRvIV7mx6Nl0LrN+lJ5Uqc0YT+MWqLQVL56SvEP6ZPGle6+FZAq
 SKb3PzshFdW0Fr2yXnzu8aLc6BbXMA4q0uQSiTI8Y0fge/wNnLWeXnXGi3X9DWOK+LPw
 BcpmXcCd7ecmBk+FMZfeIl5DfaFoFl3TzhYs+55jWAFMJi4ID//50U/q3AENcRXu8oGN
 iq3kp/0ztvrPnYEZpGzdYpioZSHLq0GaZL95p5v6ssn7aUeED1NNwyoJFGzT9MqHyOlD
 jF0A==
X-Gm-Message-State: AOJu0YwGlCpLL8ttERU0bgw9QdbknhGYQe+msg9YzbDYCUHZDBddd+/B
 SshclHksnGdaKk0diRYrz8FdB9YrvFDoBaPhFB0=
X-Google-Smtp-Source: AGHT+IHl0u+JeWqxDyoEBrAZ7uo7IqgLoJZ5l9lQJq98SSICtz4rDZHuOQBAnWo6WQVrzJWiYJetLg==
X-Received: by 2002:adf:ec82:0:b0:31c:804b:5ec3 with SMTP id
 z2-20020adfec82000000b0031c804b5ec3mr9380462wrn.67.1696232697681; 
 Mon, 02 Oct 2023 00:44:57 -0700 (PDT)
Received: from localhost ([2a01:cb1d:78a:c00:357d:97d4:b439:b35c])
 by smtp.gmail.com with ESMTPSA id
 a13-20020adff7cd000000b0031ad5fb5a0fsm12553429wrq.58.2023.10.02.00.44.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 00:44:57 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Wojciech Nizinski <niziak@spox.org>, u-boot@lists.denx.de
Cc: Wojciech Nizinski <niziak@spox.org>
Subject: Re: [PATCH] fastboot: fix CRC32 chunk size checking
In-Reply-To: <20230925103714.4153612-1-niziak@spox.org>
References: <20230925103714.4153612-1-niziak@spox.org>
Date: Mon, 02 Oct 2023 09:44:56 +0200
Message-ID: <87o7hhlb7r.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Wojciech,

Thank you for your patch.

On lun., sept. 25, 2023 at 12:37, Wojciech Nizinski <niziak@spox.org> wrote:

> genimage create android-sparse file with CRC32 chunk at end. When
> U-Boot's fastboot receives this chunk it returns error message:
> `Fail Bogus chunk size for chunk type Dont Care`

I could not reproduce this, probably because my sparse images don't have
crc32 chunks.

>
> According to reference implementation of Android's sparse file format:
>
> <https://android.googlesource.com/platform/system/core/+/refs/heads/main/
> libsparse/output_file.cpp#513>
>
> the chunk_header.total_sz is CHUNK_HEADER_LEN + 4 (CRC32 size).
>
> Signed-off-by: Wojciech Nizinski <niziak@spox.org>

However, the change looks fine to me.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

I also tested by reflashing a super image from aosp/main on the vim3 board.
Base commit: 2173c4a99066 ("Merge tag 'u-boot-at91-fixes-2023.10-b' of https://source.denx.de/u-boot/custodians/u-boot-at91")

Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # on vim3

> ---
>
>  lib/image-sparse.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/image-sparse.c b/lib/image-sparse.c
> index 8f8a67e158..323aad981c 100644
> --- a/lib/image-sparse.c
> +++ b/lib/image-sparse.c
> @@ -289,8 +289,8 @@ int write_sparse_image(struct sparse_storage *info,
>  
>  		case CHUNK_TYPE_CRC32:
>  			if (chunk_header->total_sz !=
> -			    sparse_header->chunk_hdr_sz) {
> -				info->mssg("Bogus chunk size for chunk type Dont Care",
> +			    sparse_header->chunk_hdr_sz + sizeof(uint32_t)) {
> +				info->mssg("Bogus chunk size for chunk type CRC32",
>  					   response);
>  				return -1;
>  			}
> -- 
> 2.39.2
