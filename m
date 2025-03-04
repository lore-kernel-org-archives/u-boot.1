Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC63C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 11:51:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 606B281436;
	Tue,  4 Mar 2025 12:51:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iwY880kg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6B80814BD; Tue,  4 Mar 2025 12:51:23 +0100 (CET)
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com
 [IPv6:2607:f8b0:4864:20::a33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 825E881429
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 12:51:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-51eb181331bso2642254e0c.0
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 03:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741089080; x=1741693880; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dEjKy7JXVQKrQDmXozGNFT+HP3f4Q6GObpkComa26X8=;
 b=iwY880kgAPtch1EcXWCD6LT6VD/rI7ZOH6+6hfqxcQdifA+WG/uR1Hz4M3d5F6Zy5S
 wCD5P6MX77yk9XsDgrq+4FLf7vuftXfSvYn+XH3jEHoDemKBIuxttXNSxNajjoyiS3GO
 +jyISrVYTJX2jqaM/iFQEHR+WkEQoP05FuqGl6X5Zlv1eq6pJWfBjAC/9Ks5HT0wafYO
 gw6fsm9qoYuxAhSORpkej2KcCJpb/LnEyGixsKEvW1PPdvFtqkL2zD3vz0zMwZlTamDB
 bJ0UiWSs9U71kS3JD/kvYQ1Ycdcaqlnx7iFAkOfOR9L9AtB1uthPNrWxjU9xKpL+Jonf
 kagw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741089080; x=1741693880;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dEjKy7JXVQKrQDmXozGNFT+HP3f4Q6GObpkComa26X8=;
 b=nbcN8qjlljOn5tp8H38sXlQfaYt7tUXXhspWlw3Ls6Ap25q4o2svPp++EbH3GZCUYI
 eG3MzjoaOOAxsguoIbcHtVcEbV2omUv5SGrdsL8LqeVGbCYwsDd0TSIF1acCYwvF0sbn
 nLCPqQ1RjDG1Kfk3HrKZxMcBboety0r5kG8+R+a9bVztCCFoMqgJdBde2yNYDkaKHiil
 wXZFH3IWIa4aDCoSw51AQOj2Gu92tA32ESBNsEOK5mZKC51jOFI5w6tIhjNwteYPOjE3
 I1UekJBMe25LXCXhd6hQpubxP1XIuk0CBBKxWdiwc+9yzDaI/MnlD8U7KP89XkHBa7nr
 ZTFQ==
X-Gm-Message-State: AOJu0YztgEDX9Ti2PrPorZ4MFVpGLjDS+YOPte3iNsy83kYl40VGOIYB
 RH2QcBtUoYi1GAeJhEsfdn/iKoDzhdSGx96jm+DPtBlJTadODH/CWAukWSXOKbCIwI4e8Pr6t9Q
 z2GM/y6klHY+LNdBJBRGiOSAOiTV1egIL6UgezDPP5xkUVxV+lvqBDw==
X-Gm-Gg: ASbGnct2I92RHBeF2SkkKjc1GNLRDbJIiKC9nmXiTJL9f13Z5bvDCrA59KiL5KuLNi5
 +sffEWOF46kPJRGRV3uu7tDeAhSVtuENBKXmNJ061sqwWc384lSixPmB5YpnJG0ZHkidmIbWZzc
 7OIBoX4MAb8vpNGv10g5/77Om6y2k=
X-Google-Smtp-Source: AGHT+IGS9tDqVGIzEXnpEziG5gNyjBQBY17JQaTdmO9AYY7XqUt/iAaAEhDtQgrCICK/r5dtRAo3t6kayZZ3XN89E7o=
X-Received: by 2002:a05:6122:3b8d:b0:520:4d95:1319 with SMTP id
 71dfb90a1353d-5235b7796a3mr9736753e0c.4.1741089080118; Tue, 04 Mar 2025
 03:51:20 -0800 (PST)
MIME-Version: 1.0
References: <20250304105741.489938-1-sughosh.ganu@linaro.org>
In-Reply-To: <20250304105741.489938-1-sughosh.ganu@linaro.org>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 4 Mar 2025 17:21:09 +0530
X-Gm-Features: AQ5f1JoRANa2Cjhlq1H-jh6NupX-3FL3siANR7KBcWJE7_NtnFTQO2ZHk8tJdPw
Message-ID: <CADg8p94tggd-33Pxm8=kAfRpZR6XL-5dfYq=s0oJ7ZDogSiFmQ@mail.gmail.com>
Subject: Re: [PATCH] wget: check return value of store_block()
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ramon Fried <rfried.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 4 Mar 2025 at 16:28, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The tcp_stream_rx() function calls store_block() to check if the
> destination memory region is available for the chunk of data to be
> copied to it. The store_block() function returns a negative value in
> case the destination memory region is already in use. However this
> return value is not checked in tcp_stream_rx(). Take the return value
> of store_block() into consideration.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>  net/wget.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Looks like this has been fixed in master through 32a6c5eac000. Please
disregard this patch.

-sughosh

>
> diff --git a/net/wget.c b/net/wget.c
> index 0b082c61947..847097a0e3e 100644
> --- a/net/wget.c
> +++ b/net/wget.c
> @@ -227,7 +227,8 @@ static int tcp_stream_rx(struct tcp_stream *tcp, u32 rx_offs, void *buf, int len
>         if ((max_rx_pos == (u32)(-1)) || (max_rx_pos < rx_offs + len - 1))
>                 max_rx_pos = rx_offs + len - 1;
>
> -       store_block(buf, rx_offs - http_hdr_size, len);
> +       if (store_block(buf, rx_offs - http_hdr_size, len) < 0)
> +               return -1;
>
>         return len;
>  }
> --
> 2.34.1
>
