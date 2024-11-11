Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD05D2E9E3
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 12:35:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5010B8935B;
	Mon, 11 Nov 2024 13:35:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wMy67dhp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A54CC8935B; Mon, 11 Nov 2024 13:35:18 +0100 (CET)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 242778932C
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 13:35:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7ea9739647bso3080295a12.0
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 04:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731328513; x=1731933313; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Kf2VLz25R+7RU/J0SLUF+QekMpo3BSrqK80q0axho5E=;
 b=wMy67dhpesckfO0caERJb9eDlFYtcs+uy0Zp8M+m+bEoOuFmx9lpprEtq46bVA/A6I
 LzBN4VNMvMD4PPbelIQAeOLuPFaAhj5bIVQtuqXz3unmPoOFOxAUhdtrzDIThUbO0r6+
 1D2pdO+1jo3ofmU3TmmZsSUQQ5ezVuTxaCFgE5dV1WFpv+puJA+Av/WUyBrQ1D0R+mq5
 WTdN4Tu7vxlwHTabfCS7vt/oLjC6tlHs/moR6dVn7zbmAEuBeILo8UYFKgNu6sRdKXZP
 LWdp5KN0zR/ReRoagNaOIR+i2/iRZFg6IudwZA0X+rG/JVFWYrsOdZqoyfnzqvd2cydX
 oHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731328513; x=1731933313;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kf2VLz25R+7RU/J0SLUF+QekMpo3BSrqK80q0axho5E=;
 b=lwNWdyny/nP7Lq2bG27afth0MhXYFqhzkP0+KOUvMez8lDRPX9C4/rsCLrWNpbxNac
 1Rta5NpES0Qoh4j9nM8ILgwsBHr6rIj0gOQfrjtbDjyE5iZdOuAuNhBaK8R5xl2sM0a7
 2x64GeBEap8iVLpCbbrsU2icwwR421ABiqTpEbv2Nn9MD3wgmnasKM9Zn3U5kr9DbH9Y
 RQx4B98F0Q2ooaorN9YaJaEMhf158wEfM+i0Uqo51c6Xd/gXnGGRwSiKCxePqEygWJsQ
 w1OjE3oOArwaql9+ma5GGUSg8EkJmYLQ/DZMOFq3qslMEUCZbV12vlNcJLtCyVQpcCnj
 VdoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+9kynWYP56HAtIN9Vn5C8X2QMTVsQsdf1uHXHngwnE3BAbnFbCmyBZaXvcPqAfySm0mgpgrw=@lists.denx.de
X-Gm-Message-State: AOJu0YwX62Tog/0CL2nUxCU3MYa3+5pAN7DN45Bg7FbxKAjQ6V7GwK1w
 4fQgPeMd1b3awL21so3aYR/ZkQc88Gf8lu6XzmMfvhu6uD7Q5S0JL2rO2MmvMttWynlBM+FEAZj
 deBlLL71/63e0tBPIJ36e5QtCdDaTNN6Jcd+ANQ==
X-Google-Smtp-Source: AGHT+IH8yckGgE+CX4Lco56jtj/marCcO6tbEWuEKJ2z5A5Y1Ly77I4rSY6HydcnV0JRCaXzvY1IBM2sJk5HMnJUng8=
X-Received: by 2002:a17:90b:2744:b0:2e2:af88:2b9f with SMTP id
 98e67ed59e1d1-2e9b172005emr18831829a91.16.1731328513691; Mon, 11 Nov 2024
 04:35:13 -0800 (PST)
MIME-Version: 1.0
References: <20241103224223.195255-1-heinrich.schuchardt@canonical.com>
 <20241103224223.195255-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241103224223.195255-3-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 11 Nov 2024 14:34:37 +0200
Message-ID: <CAC_iWj+dy20suoiApc7_jDry46LZcocmiR5VT2w=Rxma0sfWeQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] lib: uuid: fix uuid_str_to_le_bin() on 32-bit
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de, Patrick Delaunay <patrick.delaunay@foss.st.com>
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

On Mon, 4 Nov 2024 at 00:42, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> hextoul() cannot convert a string to a 64-bit number on a 32-bit system.
> Use function hextoull() instead.
>
> Reported-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Fixes: 22c48a92cdce ("lib: uuid: supporting building as part of host tools")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         no change
> ---
>  lib/uuid.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/uuid.c b/lib/uuid.c
> index c6a27b7d044..19f33dd1477 100644
> --- a/lib/uuid.c
> +++ b/lib/uuid.c
> @@ -35,6 +35,7 @@
>  #ifdef USE_HOSTCC
>  /* polyfill hextoul to avoid pulling in strto.c */
>  #define hextoul(cp, endp) strtoul(cp, endp, 16)
> +#define hextoull(cp, endp) strtoull(cp, endp, 16)
>  #endif
>
>  int uuid_str_valid(const char *uuid)
> @@ -339,7 +340,7 @@ int uuid_str_to_le_bin(const char *uuid_str, unsigned char *uuid_bin)
>         tmp16 = cpu_to_le16(hextoul(uuid_str + 19, NULL));
>         memcpy(uuid_bin + 8, &tmp16, 2);
>
> -       tmp64 = cpu_to_le64(hextoul(uuid_str + 24, NULL));
> +       tmp64 = cpu_to_le64(hextoull(uuid_str + 24, NULL));
>         memcpy(uuid_bin + 10, &tmp64, 6);
>
>         return 0;
> --
> 2.45.2
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
