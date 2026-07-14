Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE49BC43458
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 12:17:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E220884D11;
	Tue, 14 Jul 2026 14:17:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DI1xpEB4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3166584D0F; Tue, 14 Jul 2026 14:17:36 +0200 (CEST)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8D6B84CEB
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 14:17:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-38dc69c74b8so2550467a91.0
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 05:17:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784031452; cv=none;
 d=google.com; s=arc-20260327;
 b=bivF5yO89+B94BLrL2m9StH9xqFVSTOG+dHOSG7y+IzxlUV2t41ettYPWLSkK16j1w
 YG+d3/8NsztvnkpzK+pjCHwZJl/Zw/f5hBLydkMwxk/7nqB2hcFc2BizlVK4AFTmC6oT
 Z3qN8OhzG9QraTe8Nl/1snrdjpyjKEoCAxGGekD5jNuYucLxu2Aq23MpjDwgtnKyfz/q
 KyqlexuN9NtjKaK6eCRTHiJmknJoNFWD0PXnoRc2Z5Rchutr2VVr+BhOd/yN7RxaLViC
 yKbbagSN6VT+hIsLLu+EYr0ZTRFN8bUMi+QnU+WBwauPsLfw12R1GosVZaPVTwNuMTDs
 KZWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=NpGfxDLcdxIUtxBiJD0Ce6OuBeE+8NUgTLz9DTUyRc0=;
 fh=og+o5kBITe9AIUuiCiDU48TccAC6p4JUUdx+LCo3X50=;
 b=KEZjfqaVVZyVFtQ/L4ZlcxKQQj8GH0BLpkXQRlxOzvjprVTJfpLDuoeeusoo95Vti7
 VSPOKXW0qLiet3Xtkty/mn8cAzq4SluV6tnZ9MJBalPSqfJtob/RiF86xXMMDcjFt/ry
 SqYkXLPUv11/UY/nVIEdiOaLxy3gTvUZx0YjyCdlb5vzTCeiumOBHEreh06p4PKw1fgi
 vHaPnH+G2wsMjKEqOYynEov/XxUkecuZ3Tau5E1GvmrrzEiP+bLvl/aXSI3IvpMi+Fpj
 +odkoVpEDEo1v3wsXnPS/dT/Tb6sksMQgFHc+ewPv7di7IW31kQ62QwcTwOaCp3QNzI7
 QBkQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784031452; x=1784636252; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NpGfxDLcdxIUtxBiJD0Ce6OuBeE+8NUgTLz9DTUyRc0=;
 b=DI1xpEB4j0Cx9R4LzJUdtVVzqaH3u1QsJsBVFa5KiUYfMtHuh/T3ZLubFXD1qyISuY
 BNtc5CYkKPV2YG6XCsH8ojwqn0Pl/BLkkeuuTTCutp/r8PkhEyTEj2DIj16XYmCj4xu8
 CGHlfgggtSou5tpkug0so+ju1zgHDGlheRiRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784031452; x=1784636252;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NpGfxDLcdxIUtxBiJD0Ce6OuBeE+8NUgTLz9DTUyRc0=;
 b=rKxStoU/ipzSomTedwakMqOHwHYLKLlfSTIte3g1poQNb7RYrWrfzGyyMAChqvIibt
 zOtEAg3JUqrFwMghlEa28sgzgFtDBR5gprVxD7ifFUtNdfL/NzRtrxnyRoI3TwwNkGGi
 6psueyIQ5bv2WJ/s54yhMw1NCWtbmTiSh/y1ssNMI9CVNNF0/VdHP97QwsTAfatcxyMB
 67GEJY4NShAarwVWK7Zht5E7Mp2aGfiuuwjCmtfJAzwDIhKIGlTcgP+R4xyfNnWNIuDI
 hFojCDze8dABBE302lxhee6ZG8YSTEvuDaedqdv+2kycV/siCGw1WgBJC8AJXSh7kNfu
 29mQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqnHkTXb5Q5lMwOFmnu2w1xzTJFHonDO5jFikUt7h66OgxlmrzLc5lWTK2WFeYEGtWX1XtU8Vc=@lists.denx.de
X-Gm-Message-State: AOJu0YzOsw1/EvuXV1Tt2a09olZUv7C9NoI9dAMyRAFdLO4CdrAmiTYV
 s2vB44pYa//iGwixkbRLTGs0F2WkN+guzKobGlMkIATV/wWoAxXxfZ1farQBfaApv8ArGGUbv1h
 etA0HrLp+0/Fm3rF63bUecu89nHhWGKojqxv6RA3h
X-Gm-Gg: AfdE7clYECPnAg1tT1sIpaNSkRi9rJJ4dEoWzJnq3bKNRFsgIIyXMJfegMyYtNuCkmx
 uBd7/yjyYL6DuZJ+ve7TmUVc9TDaQVa2Eg1hMJI2oMhsWnb2vsPlH648ZVIMtt8saStCV/Ug+MK
 QFOm4Arus2skA2QDB0rnCI+OILZQJPMBGOXkeoDXI6TUXwwTY5Xt+CexllEMpcvJKNQwbLGxzZc
 px/hUiLCnLDdhA7pWbNjRgtPMNLvjO76V4vY/sWs3XVmIoGcD3HMdgI667C0K0QsI3Z5nw=
X-Received: by 2002:a17:90b:3e8d:b0:37f:be6c:f3f2 with SMTP id
 98e67ed59e1d1-38dc782279bmr11274506a91.2.1784031452270; Tue, 14 Jul 2026
 05:17:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1783816074.git.daniel@makrotopia.org>
 <81cb6eed897871b3548e81ee63502b65f797c44a.1783816074.git.daniel@makrotopia.org>
In-Reply-To: <81cb6eed897871b3548e81ee63502b65f797c44a.1783816074.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 14 Jul 2026 06:17:05 -0600
X-Gm-Features: AUfX_mwNDVZ4cJ5zcd2FenCIOZPgfaX5tamkDowD-p5d8Te1o5wGSAhagmfDQ4k
Message-ID: <CAFLszTgZ7Vi0OL4jqE7QJCgg9g4-F9gc71wu6QCJN1D7jACwsA@mail.gmail.com>
Subject: Re: [PATCH 2/3] boot: fit: cover the dm-verity roothash with the
 config signature
To: daniel@makrotopia.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Ludwig Nussel <ludwig.nussel@siemens.com>, Anton Ivanov <anton@binarly.io>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marek.vasut@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Randolph Sapp <rs@ti.com>, Francois Berder <fberder@outlook.fr>,
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

Hi Daniel,

On 2026-07-12T00:33:05, Daniel Golle <daniel@makrotopia.org> wrote:
> boot: fit: cover the dm-verity roothash with the config signature
>
> A dm-verity protected filesystem image is not hashed by U-Boot when it
> is loaded; its integrity is delegated to the kernel, which validates the
> filesystem on the fly against the roothash taken from the FIT dm-verity
> subnode. The roothash is therefore the sole integrity anchor for the
> filesystem, yet fit_config_add_hash() only added the image node, its
> hash subnodes and its cipher subnode to the signed region, leaving the
> dm-verity subnode (roothash, salt and block parameters) unsigned.
>
> An attacker able to rewrite the boot medium could then replace both the
> filesystem and the roothash, recompute a matching dm-verity tree and
> keep the configuration signature valid, defeating verified boot for the
> root filesystem.
>
> Add the dm-verity subnode to the list of nodes covered by the
> configuration signature, both when signing (tools/image-host.c) and when
> verifying (boot/image-fit-sig.c), so the roothash and salt are
> authenticated together with the rest of the configuration.
>
> [...]
>
> boot/image-fit-sig.c | 23 +++++++++++++++++++----
>  tools/image-host.c   | 22 ++++++++++++++++++++++
>  2 files changed, 41 insertions(+), 4 deletions(-)

> A dm-verity protected filesystem image is not hashed by U-Boot when it
> is loaded; its integrity is delegated to the kernel, which validates the
> filesystem on the fly against the roothash taken from the FIT dm-verity
> subnode. The roothash is therefore the sole integrity anchor for the
> filesystem, yet fit_config_add_hash() only added the image node, its

Please use present tense when describing the code before this patch
('only adds ... leaving'), since the code is still in that state when
the commit is applied.

> diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
> @@ -329,8 +344,8 @@ static int fit_config_add_hash(const void *fit, int image_noffset,
> - * node paths: root + config + all referenced images with their hash and
> - * cipher subnodes.
> + * node paths: root + config + all referenced images with their hash,
> + * cipher and dm-verity subnodes.

You update the comments here, but doc/usage/fit/signature.rst (in the
'Details' section) still says the rebuilt node list "always includes
the root node, the configuration node, each referenced image node and
its hash/cipher subnodes". Please can you update that to mention the
dm-verity subnode as well? It would also be worth a sentence in
doc/usage/fit/dm-verity.rst noting that the roothash and salt are
covered by the configuration signature, since that is the security
property people will rely on.

> diff --git a/tools/image-host.c b/tools/image-host.c
> @@ -1256,6 +1256,28 @@ static int fit_config_add_hash(const void *fit, int image_noffset,
> +     noffset = fdt_subnode_offset(fit, image_noffset,
> +                                  FIT_VERITY_NODENAME);
> +     if (noffset != -FDT_ERR_NOTFOUND) {
> +             if (noffset < 0) {
> +                     fprintf(stderr,
> +                             "Failed to get dm-verity node in configuration '%s/%s' image '%s': %s\n",
> +                             conf_name, sig_name, iname,
> +                             fdt_strerror(noffset));
> +                     return -EIO;
> +             }
> +             ret = fdt_get_path(fit, noffset, path, sizeof(path));
> +             if (ret < 0)
> +                     goto err_path;
> +             if (strlist_add(node_inc, path))
> +                     goto err_mem;
> +     }

This follows the existing cipher pattern, but with this addition the
host-side fit_config_add_hash() has three copies of the same
get-path-and-add sequence - exactly the duplication patch 1 removes on
the boot side. Please can you add a similar factoring patch for
tools/image-host.c, or fold it into patch 1? The two implementations
must produce the same node list for verification to succeed, so keeping
them easy to compare seems better.

Regards,
Simon
