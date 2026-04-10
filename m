Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F6BF36BA9
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 05:08:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B39E283D8A;
	Fri, 10 Apr 2026 07:08:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TMAyhhAw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 672A883DC9; Fri, 10 Apr 2026 07:08:47 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96C14839D9
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 07:08:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-7a17bc5745eso16994977b3.1
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 22:08:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775797723; cv=none;
 d=google.com; s=arc-20240605;
 b=fWfNpcGdQkKj6XVF6BrehKeqLk6Avu3+AgGVeeM7zOYjFsdr+DF+zqqEKYLWGtiJv7
 vZ1oglPhnYI3BUMLZNvRy1AZ0FEddfNcgT50RNaTBTMFG9NfG6JIB+TCc5+iq2d0qBUn
 x5ImfL4S1O6dk7A8yzmqwv/Cf8MWz7aNJqq4A3u2vdFEun9f3qf+UkJA99g0pRAypd/H
 YLJ+VXk61Y90U1dcevv/BFNeBWTMr5PLt/JsUx80M+pXP31JSGZuepuVfv4Vg/8RavKS
 DEZhTZ5A9mz4dpwmATkUrRpm6MoOQxXcK5x6OSZtU+z6ktNqpUQ2Xrugp9Tp0vRuNcvR
 TKDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kQ4aHHqCQ5CLSXWgRnusgG+EixMbIOKD41vUmWKYsWY=;
 fh=JCHq/MUNoDxHsSfQxfapI8GOBeyIv+Th5kRpu3ND2wg=;
 b=YHZLFvtRB1lK9pDNFufOdLYSfxmIxbzRpVhsXWRk8RZ4B7GPRtEBWg1pzuRwxKIkyc
 yKo1g4x6q5KwSG9fYo2HzxMQPDVfzkaJnJq+/aaVFe9wwWjdgWtP1BedtAAyno+uHr4/
 9dFkMR2Pr8APwkLo7CSg8r8J6l7DUZTbtOrd/siCvMFyr7lRO32CoN3lt+gCjOzS1+K5
 bImI8maNXE2EndtiBRT9fhDoTnXQcp4LqNO3Sw9Gt1DxzoA8WU7xNDFIeFWuH8rVbs6H
 sUENxzl6LA4br7fU/ImnV39KQW5K3V5ZJ8Qoc4XdtqM0GCnRFyJzJYSAqf8J7O6OevXI
 sjzw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775797723; x=1776402523; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kQ4aHHqCQ5CLSXWgRnusgG+EixMbIOKD41vUmWKYsWY=;
 b=TMAyhhAwQ+m2NdAlWzvwWwFEQXq5bnZjifM3RyCavIial8qFq4ljGa/4NyOD6uoIRS
 q5uZstZ3n+vb/ZVmGPNuFOf6UrEWdyUU2TV703e1rxgZfGKfKt/Foy9S2OG2n/ARE3yw
 pxIVn2nFz0Obypr8AJVdHO/zOzdXlCzPYPuedWqkFNSwH7uKcwoaRsI3DCt8perCOx70
 cBbavg5ZZPehJc2zVkXDB7Wcta37n4XxqbAqORuY0xnopIwLhIdfOE15zkstaZOW4mCe
 iKQnec99LQ9ztdHIU4QxYJyeiVLQ4kr80olGX8hcIKuwEZ5RfGZESzdZm7XFszb9xbvX
 QiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775797723; x=1776402523;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kQ4aHHqCQ5CLSXWgRnusgG+EixMbIOKD41vUmWKYsWY=;
 b=nVgP8KM8/kLVECWCXPvuhre67LfWH/vx+aaeasEx4kjQ4+jqFj99VBonngBz9KYwpU
 FakY1/La1mWI54Hwr3aWJor4JAgHFf9oMLeyWh6KNMzEaNZtaHZ7oD1H+a2VK7rfM9Hf
 Sct9VGgxDpyGEKBPVrm9YBCcMotGq0my7icWCIsYFML1qmyJBnRR9c0AMmryoaCBsyLq
 BCnkr9tkf2vSXnT/SmCWZtIid7OUcjmxEv7QCdYftwU4uoxu+stF6sj6GSsfWKsxUGE4
 cJhmPtgHCuW+/rcT6u7A4oJ6nB/+bEi2BbugVgMNxJjh79GSwx69xl6zr7YxuAtJieVK
 41qA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2tEHCKus0Zrj9bRe3l+vXtPvsfsascRHHD67cUy1yAcyatcqFDwwgmE4c+KkWUx2u2CC/YQg=@lists.denx.de
X-Gm-Message-State: AOJu0YzPFb7JE/t0WgqLiTVhGiEGrbVgl2y2Ej+X/RD6hazZjSnZek3q
 M5MXBh7skYfHxsArvS/vprW9rcfkbKpaKRFJgHikkB9MpkxUeAbF4zvKEUuEwUa5PY2VQDTtIBX
 jHedWEyJHHN22SKVffyausN/5lpWqaRjNkrGA6oVR5w==
X-Gm-Gg: AeBDievqGbnBaUODydhD8a5zMp8eKPPTzI2HIkHfzRoZ3/XqGN1lv/+2IwPYgpRITiU
 uTzNCSNdQd1JB2Ioc3BH0m5he9nAUqXMEz0RiKKcRy4D46/wQrHPXeiw5ih2TwBI75VGun3NtRX
 TIo9B12gE0AIYEmU/f5Sa+k1onWvrv/ANenstAh+iDc6IQGg4T2Zsb388V60D3KvEX/uesDlU1q
 ML5FDl9iwroHOanF43evea/5qZQFFqxU5srYzJZShbqTxxLLTRFS+S3duOiiXwMnBVmYJgLSibo
 q1tgYYuFYozOeyzw28D5iCctchoPVotOITzOeVsRcA8TVnSP7gqmn4xdzQhyb0ENJ3L89Pmsp57
 957AlFpn1Eq3vP/AMmjOqD8jfwpOjBGUP2A3Fvy+S7irmvI7A8tCfhhs6X9XVK9TlHB9X79ifzD
 lEVW0QhF+CCB0Fzrn+hlbgyhSKVzN8XJwlpaO7LCaPW4VpXtnbYIyK3ArqQ/3bp4zw9ghorM0Kc
 v6IK2JJaZkqLhlG2XN70rlyy7XPnXGB3XGX2Qhz5FZl18RObk3BvHqaugY6F7KVtP+Scecl9dd9
 G2jOowLHVLDC2ONSOQMoQ7Jt5G3GuO+OQYR8NFFmGQY=
X-Received: by 2002:a05:690c:6309:b0:79a:b0c8:da68 with SMTP id
 00721157ae682-7af6f32a538mr20287777b3.10.1775797723321; Thu, 09 Apr 2026
 22:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260402205038.4005350-1-rs@ti.com>
 <20260402205038.4005350-3-rs@ti.com>
 <562280B5-5E46-40E4-85F9-8FBDF6B336EF@gmx.de>
In-Reply-To: <562280B5-5E46-40E4-85F9-8FBDF6B336EF@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 10 Apr 2026 08:08:06 +0300
X-Gm-Features: AQROBzC6HdDFofqKOhwlVNiIe0ZCfx_IJFMrAmUUOfHbrH9ehQW9twZFAV9V5LU
Message-ID: <CAC_iWj+4oAaPegC=Wfp2v6prC=omNSa54jNeNPVd0fBMiVeP9Q@mail.gmail.com>
Subject: Re: [PATCHv2 2/5] efi_dt_fixup: use fdtdec_get_bool
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: rs@ti.com, robertcnelson@gmail.com, ayush@beagleboard.org, 
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, trini@konsulko.com, 
 afd@ti.com, u-boot@lists.denx.de
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

Please carry over the r-b tags from older versions

On Thu, 9 Apr 2026 at 22:22, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> Am 2. April 2026 22:50:35 MESZ schrieb rs@ti.com:
> >From: Randolph Sapp <rs@ti.com>
> >
> >Use the more straightforward fdtdec_get_bool instead of fdt_getprop and
> >a return code check.
> >
> >Signed-off-by: Randolph Sapp <rs@ti.com>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>
> >---
> > lib/efi_loader/efi_dt_fixup.c | 3 +--
> > 1 file changed, 1 insertion(+), 2 deletions(-)
> >
> >diff --git a/lib/efi_loader/efi_dt_fixup.c b/lib/efi_loader/efi_dt_fixup.c
> >index 544e1aa9808..333711b9957 100644
> >--- a/lib/efi_loader/efi_dt_fixup.c
> >+++ b/lib/efi_loader/efi_dt_fixup.c
> >@@ -123,8 +123,7 @@ void efi_carve_out_dt_rsv(void *fdt)
> >                           fdtdec_get_is_enabled(fdt, subnode)) {
> >                               bool nomap;
> >
> >-                              nomap = !!fdt_getprop(fdt, subnode, "no-map",
> >-                                                    NULL);
> >+                              nomap = fdtdec_get_bool(fdt, subnode, "no-map");
> >                               efi_reserve_memory(fdt_addr, fdt_size, nomap);
> >                       }
> >                       subnode = fdt_next_subnode(fdt, subnode);
>
