Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 186E9F3ED67
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 01:03:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AFF8840D8;
	Sun, 12 Apr 2026 03:03:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=0x0f.com header.i=@0x0f.com header.b="lnPg4SCW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99F7384119; Sun, 12 Apr 2026 03:03:21 +0200 (CEST)
Received: from mail-dl1-x1230.google.com (mail-dl1-x1230.google.com
 [IPv6:2607:f8b0:4864:20::1230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A04DB83B99
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 03:03:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-dl1-x1230.google.com with SMTP id
 a92af1059eb24-1271257ae53so10715912c88.1
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 18:03:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775955797; cv=none;
 d=google.com; s=arc-20240605;
 b=b9kjFk52zsvwsLB5Wn95xozJusHe1776RqxUjucEDZkxfI+TD5GNjDWDfyf/l5/nP7
 LmINPmESlGFDQMbE0v0f+hhM/csvUZ9krBZPcKB7GjU45lGVis9Yzc24ecSd9tOmhFhb
 Qz9U9zTfIesDC1XjbqofHcToElrEqKtKI6r0rcPk8lCoTIQMJVg2eEt7K8DMZ/CLLFLZ
 b7OFNY1U/2m6QxMCh/MECslB658swH+ztSOu8+Vv7CYqcMdGeRvkYZoL7EmTgJFvqXNf
 KNYWIobZnrrLsfS+PcClZQIJOzNktjzH6yrTLwmH7ka8EP77Y7u05cAbQE1mloPJLGVG
 n7Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=pmF4IZ7ic50+s7xzF9RYEl31EVWqjW8pGMTSm8FFmVU=;
 fh=eZ6IlrSom3HSAjlBd+7yT11s6lqFz4g2SScpur249K0=;
 b=dNXWCAMX5Mv9IRD/U0eKfyT60bfOgFAkIt013YjLMyM/FQHhBOsDuiftwTfK1t19uD
 ELNqqJtHT3R3ekr2MkpLM1SPB1tCoPbWo838+nh3dFBA8uiumJ+fEeMFb6gn0LoAljho
 RaDTFAwK4oZ8bhC9xVLT2XOnHipMgOddmZAKz4vay4dAPBmu3R8jOMzf+HJtpZ8YGtHI
 xsAjws5BIX15XVXM/RUq9dzC/soBIlVbDFI3SQYEdGbbWbquyq2oDvSYwvLNWe879gY2
 pPR/aftq5DlVUBMKzrlcvNCXQzoeoyB8XN6nJ2a2W1Ep4X07WrHc1Y7vCu/mzGShlkOb
 MCkA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0x0f.com; s=google; t=1775955797; x=1776560597; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pmF4IZ7ic50+s7xzF9RYEl31EVWqjW8pGMTSm8FFmVU=;
 b=lnPg4SCW8MnrasPCL7qwR9Jq82olmnshuF0PCZbwjNW55qNSyz5sB1Nh8BqsaBARNC
 qo02lCc8O9B9TEi2qkUGqJQGsM21etO7VR+jfVbLwu+uDNlRGt7s5CWl3W9pzcPWd8xx
 hciuHY7c9d+f851WtPxrIjlA1ERY70nYe89gw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775955797; x=1776560597;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pmF4IZ7ic50+s7xzF9RYEl31EVWqjW8pGMTSm8FFmVU=;
 b=VEn56aT9upttdA7Tla3lx0r0T28neWcn0aO40PngDgm5x7OQnus6yaarKABWKGwef3
 kOy9cbDzd3T9kZnIvZXPAWq1OiMH/dKGZksRHfEx/z4DDhfYWgaxw7khOAWXXqXKV3rJ
 7qNO7O1M4L3KF43KX+rGS68Og/scaRy7/HNDfl7eqyCY6TPtN09yUjP7DwOq38XVwref
 CS8o+c05iCkogm+dFwYxgvLCdCNfrehcH7k4sRnJZkbpnfpnwPFPXynMmJ897nA7ds2I
 IAVHqnwPtBDfivNq0NBRPwG680Ppdv7ZK3D/fnAeSftC5KNNVRUPTtaLfc0r2grRCbpC
 agxg==
X-Gm-Message-State: AOJu0Yw/cSxYrrW4l+/JVpjXlCpUXuD3Z0WuByuFLBg/NHUbxmfE+sqz
 Yq9dI0X7SVSeHLytR7zbCEsT0+uR/xh457wDHpOHBoH7vEK3lDeBBXva0l+L618F/Ebjvkw8t3G
 3ZexAwDKUeuAdl696N1c36Z8RPBknycso6ak60tOY/7pmBRuKi9hI
X-Gm-Gg: AeBDievR+obG8oecjDDWjif4lKU7dgnsZ8d0xP+1UA3P3aWVNib6vfieBLwttNfohAq
 QIcK2jud4vVEPNdBK4JulnNxbGAuAZ8VEZ+3BA0Oygdmcz0qVvTo0FER7sLl9OYsN7RgFCaPhsE
 lqMaXzBLJMDE0dwiOKnSuP2DZxsK5mCzWf6CVq+3eQghBb3uRDP468XA1Ld46L3MnxEBfpNDxky
 r3jhhHfgm8lHI8MWyxj4eyrfSJjCqSeuXmPH3wKaYtIY64vkmmUO6t0cH83+psaNURm46WmOj2w
 Octv
X-Received: by 2002:a05:7022:327:b0:12a:6c4b:9cf0 with SMTP id
 a92af1059eb24-12c34e68d9cmr4875442c88.3.1775955797019; Sat, 11 Apr 2026
 18:03:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260309023234.640209-1-daniel@0x0f.com>
In-Reply-To: <20260309023234.640209-1-daniel@0x0f.com>
From: Daniel Palmer <daniel@0x0f.com>
Date: Sun, 12 Apr 2026 10:03:05 +0900
X-Gm-Features: AQROBzBYlDvziBOzr1miyoNTwyTVPbM6hvQJ2yknaCsP5zfxN-e-Sr7a4cLXz-M
Message-ID: <CAFr9PXn0EGkTT02b5BSxeV7dxTwOuEq=wMdO+bVGezJjq1L_ow@mail.gmail.com>
Subject: Re: [PATCH] serial: goldfish: Add DEBUG_UART support
To: visitorckw@gmail.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Angelo Dureghello <angelo@kernel-space.org>
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

Hi all,

On Mon, 9 Mar 2026 at 11:33, Daniel Palmer <daniel@0x0f.com> wrote:
>
> Add debug support for the goldfish tty so it can be used for
> early debugging. This will be really useful when adding support
> for relocation etc.
>
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---

I think this has been reviewed and out of other comments for long
enough now? If possible can someone merge it?

Thanks,

Daniel
