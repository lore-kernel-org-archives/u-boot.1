Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E598C0218B
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 14:38:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D63F180780;
	Thu, 23 Jan 2025 15:37:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BOh5Ll23";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B318080780; Thu, 23 Jan 2025 15:37:53 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58A4280137
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 15:37:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43624b2d453so10484795e9.2
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 06:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737643071; x=1738247871; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RTypGKcr4IfMm3UuzJcixN5lvXVssxwxE5knCSm+Y0U=;
 b=BOh5Ll23/yWv+Zz8exoPuUfp0jKtbn+CpcVhawnOrtTknp+G8muRV+l0+wu84TBN5j
 eTz6yRCUY/7s7K+cQCkDRbaD6O0WkK+joy8iYg5w0r3AGdOLzgfhDxcB0WAxSuF9eORh
 T/71fJRVb8cKP0Ia9To0YT80yAVL7v6iBbxDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737643071; x=1738247871;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RTypGKcr4IfMm3UuzJcixN5lvXVssxwxE5knCSm+Y0U=;
 b=g24gTqQGzC3u3psTcolI5uBXchR+WM7HNxfMLIDWtWyNzKwPx0+DuZzrklOYkODciR
 YjoANR92j7qu594PXWtSiLIpuzAmfkdpILuH22K/g0EmybmvtuqLUyNJuAe1B4Y/eXsW
 Cc5oYlGShSi6RazAT1i17yltJQ+3M0LPGfk07AZFA2d9+KMRtLI19pageh5wdGLe54O9
 ARRicMeVPPdP3zJnPofvTuBvH+fHqY6d8j8PI//cl8ICVjnefVVXsnxAXPEDRhU/9mLk
 TcmmA2syeR4qTcS2ZIKyC1vAdTUyWeG/Q74oVZdtVgjCCskONZas5oOT8LvMLpmL5S9e
 jSCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGFwa0Ex4hW527F1SVhbNZkhgZir52quSYpKPSftTugzgzVR6dLkqb3i2/oGnWHfJiIV7fa6U=@lists.denx.de
X-Gm-Message-State: AOJu0Ywptm6Es3w5twR4ZG7viJGaaLxZnILsS08KlwbLUrusZH4ZwlAW
 XbbfMrhuWkk1RFUvP/uIXkFUqPMZqnVRCiQhFCCIKPR3lYYKy2oLWPWsjYHFsg1QAo7RbHfFsVP
 RBFEtCuJk/ff68LJFK1wYm2dG6VuveKG3iMs6
X-Gm-Gg: ASbGncvcpax2VymTLNKVyKOKywN8jf7YqKcts0TzCI8YXUYGzgVX1ZxGHwYLEoyHXew
 COzaZqL86q0VH85ByMzSUE2U5WowcbBJYjJA8NI4NQWSzFrCHV752ZxkyfQK5w2Yj6lz8jMbCsQ
 ==
X-Google-Smtp-Source: AGHT+IH+rHdODYyf7k7nBJTLrSSMnLjYXkgeKCk0F510st3H7/2RiO1PhQdUmaL1p4BfF4lSf2mA2VZWLgNAwUs4sjU=
X-Received: by 2002:a5d:588f:0:b0:38a:418e:1179 with SMTP id
 ffacd0b85a97d-38bf5649b27mr26377337f8f.2.1737643070673; Thu, 23 Jan 2025
 06:37:50 -0800 (PST)
MIME-Version: 1.0
References: <20250122-qcom-parse-memory-updates-v2-0-98dfcac821d7@samcday.com>
 <20250122-qcom-parse-memory-updates-v2-1-98dfcac821d7@samcday.com>
In-Reply-To: <20250122-qcom-parse-memory-updates-v2-1-98dfcac821d7@samcday.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 23 Jan 2025 07:37:33 -0700
X-Gm-Features: AbW1kvZKspyW64bPIhhi98kvD1v8nnathDpJQaHEjkPBWjaGK0-Xs2KS2GMtOho
Message-ID: <CAFLszTjcgo3z=4rSxZt7b8Gojy+YvnPBxP=09mrZDB6GJgjQnA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mach-snapdragon: pass fdt to qcom_parse_memory
To: Sam Day <me@samcday.com>
Cc: Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Matthias Brugger <mbrugger@suse.com>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
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

Hi Sam,

On Wed, 22 Jan 2025 at 03:27, Sam Day <me@samcday.com> wrote:
>
> commit fc37a73e6679 ("fdt: Swap the signature for
> board_fdt_blob_setup()") introduced a subtle change to the Snapdragon
> implementation, removing the assignment to gd->fdt_blob partway through
> the function.
>
> This breaks qcom_parse_memory() which was also called during
> board_fdt_blob_setup().
>
> The underlying issue here is that qcom_parse_memory is using the of_ api
> to traverse a devicetree, which relies on the fdt_blob in global data.
>
> Rather than relying on this subtle behaviour, explicitly pass the FDT
> that should be consulted for a /memory node.
>
> Using the OF API is typically preferable because it's easier to read,
> but using the lower level fdt_ methods instead here doesn't add too much
> complexity, I think.
>
> Finally, a minor tweak was made to board_fdt_blob_setup to use the
> passed fdt blob pointer instead of gd->fdt_blob, which removes the last
> of the references to global data in this area.
>
> Fixes: fc37a73e6679 (fdt: Swap the signature for board_fdt_blob_setup())
> Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> Signed-off-by: Sam Day <me@samcday.com>
> ---
>  arch/arm/mach-snapdragon/board.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

But I'm looking forward to some form of Caleb's patch landing too[1].

Regards,
SImon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20250117102734.3725009-2-caleb.connolly@linaro.org/
