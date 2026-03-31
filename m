Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E096A109B481
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 15:00:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D38E684010;
	Tue, 31 Mar 2026 17:00:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JUoEHP7q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EB5B84020; Tue, 31 Mar 2026 17:00:37 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF4F783A41
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 17:00:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-66b941ebe79so4913278a12.1
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 08:00:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774969234; cv=none;
 d=google.com; s=arc-20240605;
 b=h4LD+3YPg4XVr9lOMod6QnUG7cUDXhCesqB4HQLF1hj8bLlWD3WlW69ruuoWJ3eyPj
 Yl/HNlyGLzo+I2gf4Kn2nPYfvtTOVBNqmHUhtOtwjWbahNJuH0+DTSidCXWNcQfCENST
 XtKNqhkHVQYMVzmm5C0ftf2h/op1i0y+ElbQgsTXnMmw1BNg3AI/boW/bKilovo6mFBE
 g4G4y8Ob57T2NMx550kH5FGmSDanFGnVFXANYL8KcEgd/r6CHwXJ7D5WPA44pujWTUGB
 zA/1UtkzH0+QlgU3UjdFQWbh74XbkudApIySveHOc2cSvkRqemePHHUiXOrs0sZJA3mC
 gDsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FolwNpe/ig2VLeV4Xp5J6ZoOXRsEmsZKK3YzGzTIkc4=;
 fh=KyqqMVHoOATPJJUJrgL0MX+76c8wowopIm454Fh8ALE=;
 b=KNiWy2N1DcgmltKF8uC2y+w8Ck4xUpiHbPVy5HuN+6bGzHjpLb9fYb4Nd21hG2rR66
 dScuhGhM/D6EV4wfiz/FnamGBi5ZChihuTrT6gtvvstxSaluBs7X9Xc9E9UCLtZLJgvc
 UTl7/0LV/uacvpPsAj1rB4tYX0vArvEJd0S7Q9/Wq95g+dB9TT8+OqDM7Hl3nUfQ8fBR
 CeFl2ebK6IOMkZCKabLCfW+KC7epuFuFVliKL9Cw+Q7w1kpgxmo7exjYaRAda3zLukTh
 WWe3W8PhTopYUQ+t1nvmwT0a7Q3xF9wom/7q8s5AF1ph2ccqkBkOUSv7FhK4MpLhxmQZ
 V7ew==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774969234; x=1775574034; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FolwNpe/ig2VLeV4Xp5J6ZoOXRsEmsZKK3YzGzTIkc4=;
 b=JUoEHP7qlmlOD2i9SvnpmVo8mKRL1XMwl0+mEQUDTmIA8ihYJacZ0PArjuauslWDA5
 j/w4Hqkv7v9yFZfyQh0MrAGl5jMeNXLgLh4A47zwzXFlET1fbQM9T8JuCmP6NFODK5L0
 A0TxE/GcVLd6256/wSQynyZVOgx1uq1lqjTD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774969234; x=1775574034;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FolwNpe/ig2VLeV4Xp5J6ZoOXRsEmsZKK3YzGzTIkc4=;
 b=Ic0PXG/bWmSeNoieqTaEybcmJFFdR4oaKMBK3KVDy9+L3yGF5yxQF6DB4PEHT5vqdg
 ewMqbMnA8xd2KQ88sT3MaxDggl7RooAVL8yi6+3LZ1A7nNFfXrZ+o056I+UVfRPLwOgG
 surOVw6eOcpmEefReZ33tKx6dkrynjjvEZYiFyQ03UQ4ynIBNtsN1vHnJwMybcqnYR+p
 62iYS03tANK3NRH9ZsUZdaCIcyvrMbGntTVbxs25DCLDdN3nlsAYPcUYtq8DAEiTS6Xy
 HmU6KYaIXzv/mBfb57UMMo4WmkYNLp4jPthJlUvWQIIUgupTgfbf45OmlhIrUCpJXytL
 RROQ==
X-Gm-Message-State: AOJu0YwGUpukmAu5rZSxKyZEh6AqUZmesKieItmvTxQK1F1lCSBvOGwC
 kwturH0fO2tXaF8cHHavJkGxcBnsACWA5Mn9CQDIQLynjVGbojrRwQcvP6u8ey0M4eCymNNxij6
 a00z8vpcOUMwFVG8VlqV1hjQPIYl+tBroGD8vJRb2
X-Gm-Gg: ATEYQzxafy+s9iUpcLOi0cG1pX8D4+l+tJOIoyPm8EEU9Y/Aow+st4zDHgPpqrjH/S/
 ni0G6KrVBeRKTCRoFYE/w3GqcsS72YbU0T9n3P0V9GPeOGF+rCpdYmTlDH49ozLEsnqeM4CBr0c
 7NHpouY/XOf4T+LZPmk86gWl3VtcCjdoamlt//u4WAlDy1Sz/pDBe6O4u7DUmeMxy/FiC3JQpJy
 rQOVqG+W1lf7+45KUPBVW2OmQKlA6DxMfDj0aJM1+ANR3WQQqpMXniOeE0UVdySr+AD3XrOCmlk
 HuJwsg==
X-Received: by 2002:a17:907:3f1e:b0:b94:3836:1678 with SMTP id
 a640c23a62f3a-b9b507b20d5mr1000376066b.26.1774969234076; Tue, 31 Mar 2026
 08:00:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260328171624.2377527-1-dario.binacchi@amarulasolutions.com>
 <20260328171624.2377527-4-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20260328171624.2377527-4-dario.binacchi@amarulasolutions.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 31 Mar 2026 09:00:21 -0600
X-Gm-Features: AQROBzDuIj3fdWZrSX6cGyiwswScR8Wf4AvrfzLkU6KVN5lFo2sKLdRMAhey4N8
Message-ID: <CAFLszTg+r=OfXTfb8m05P6z5=XM04HjxVO0o86hnB7r-Z6WLhQ@mail.gmail.com>
Subject: Re: [3/4] fwu: add helper to get image GUID by type and bank index
To: dario.binacchi@amarulasolutions.com
Cc: u-boot@lists.denx.de, linux-amarula@amarulasolutions.com, 
 Michal Simek <michal.simek@amd.com>, Padmarao Begari <padmarao.begari@amd.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
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

Hi Dario,

On 2026-03-28T17:15:13, Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
> diff --git a/include/fwu.h b/include/fwu.h
> @@ -394,6 +394,9 @@ int fwu_get_mdata_size(uint32_t *mdata_size);
> +int fwu_mdata_get_image_guid(efi_guid_t *image_guid, efi_guid_t image_type_guid,
> +                          u32 bank_index);

Please add a function comment like the other.

Also, all other functions in this file pass efi_guid_t by pointer. How
about 'const efi_guid_t *image_type_guid' instead?

> diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
> @@ -243,6 +243,30 @@ int fwu_sync_mdata(struct fwu_mdata *mdata, int part)
> +}
>  /**
>   * fwu_mdata_copies_allocate() - Allocate memory for metadata

Missing blank line between the closing brace of the new function and
the doc comment of fwu_mdata_copies_allocate().

Regards,
Simon
