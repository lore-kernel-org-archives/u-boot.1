Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3804BCCF9E5
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 05:01:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C73D5838AE;
	Thu, 30 Oct 2025 06:01:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BotTLoRL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F266E836D1; Thu, 30 Oct 2025 06:01:51 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4D5B838BB
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 06:01:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-63d6ee383bdso1156091a12.2
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 22:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761800509; x=1762405309; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XxR7bUfKf5lyaEkqS9EPYB95F5+7ySXMoWH834EAPW4=;
 b=BotTLoRLybHq5K2Cg4ocuJiolYBb5dF0g0lnz4wnvFghYgu5qoSC4OwlZKTq9JeR6F
 +cMEmfKwowzNlT9vqywXBgoxVlxxOhVJGE94Zvyo+LhtwVzqnYRdIkWiaqqcEndqV4KK
 80pkH+6/w2n5pv8EWlrjuuCmgjaRKBG8CKIugYq9kk9rLfn7mURV0fl6F3Vm6+wxwdz7
 rRcHhnak7XH1HK/pOJnQm0+BCpu4w600WCxHIUQqqBhRYK2nqgw5Vp8crO5YBnP3pm4+
 6ZMrZTPphgF51pgcvQRX/e8MbEoJW5KzCzMULJQ7TITtI0VQmKr3aiVUcQ9NC0i9WFbK
 9qSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761800509; x=1762405309;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XxR7bUfKf5lyaEkqS9EPYB95F5+7ySXMoWH834EAPW4=;
 b=USwa9ndFkna9KwuPwj2kUx5DY1iHidNbW//VS72MDfllSh18N2tyAd5RxNTnI3/dJk
 KZO7qX+nYyjjXVjLO9XpM8/IBm89ObgPlKQY1Q7i3Y1pkiNeTzhvh6lr7mLB6xOI+Tws
 h11jF16hqkqPhMFrt6Vf9noh6k36eq5+d43CDrnYvPWGe6Aju/uQyhiDGayQ56vF1PJq
 1R0tGZpm8BuaiqdCjpmpYgBJRMQMpIZ/GMOZbQaPp+dnSJcogL1+bxpblBbtFID2XoMv
 HJ7gdfaQyQ3jgeHSUwu4eY5LuzCfJdEQ0LK7TslOW48pd15VcDww5iakw3cfVlZYYzLi
 K1Rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXu4oVb+fnzCGlBnQSygt0l1T11vZc+YL9pLzPIPKWIUq189APVmC5HzVjNGFLL+6mZ0Ki+dRw=@lists.denx.de
X-Gm-Message-State: AOJu0YzyjUc4MH0hBsaon4dLj+KSCjBmhCV00St76EodCt844HC5onJl
 CnDWM3HsaEhP91FUTR7fiELnGpp5XXHT/qfNA9NvXhXG5dSALbvFHOcGZ1frdA31d0TO0WAhKci
 4mmbwP+GHIIcT5qHkTC09EUorjM+c2pq/kg==
X-Gm-Gg: ASbGncuNEoa3/MRMvVULIBqQ67w3l7Y9RQjaS6O8iuPEY9Ve+rHhehD6rSy9YHIq3Sv
 4e6I+Prxg6VAmfDULYee5L4CN0y5Em2OfaI3FqsI8V+G4kMHRFazRhY6n3ujvj+kYmsVuZmIg68
 vkJxFXmqbpmwDPVNvTcc8f5Sm26zw1nJnQwNXCNetDQyR/9OUfQiYonLXS1uQcziyZRYvKAlMxU
 ib1q13Rs8ulZ/AuQE/1nx5m9drWJPwJMpqNW425d5dTq5YvYXq2T7bBd/oD88clbCOVMg==
X-Google-Smtp-Source: AGHT+IHPmHw4TOY9zIG7LA2SJ+5HrF6VDb8S8ugclnKXe3wvDjZvTGaJFwgyKgKFfhu3XVr/wWxhayPvzktkXR9WV3A=
X-Received: by 2002:a05:6402:20cc:10b0:639:ff5f:bdfb with SMTP id
 4fb4d7f45d1cf-64044254d90mr3336069a12.19.1761800509182; Wed, 29 Oct 2025
 22:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <20251026010658.19271-1-semen.protsenko@linaro.org>
 <20251026010658.19271-5-semen.protsenko@linaro.org>
In-Reply-To: <20251026010658.19271-5-semen.protsenko@linaro.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 30 Oct 2025 10:31:31 +0530
X-Gm-Features: AWmQ_blVgwHh8FhzIFNCIZhWhnVzJaCc_H-TaRtLVLHWeZhCWXWLbXkIJdoeM8M
Message-ID: <CANAwSgRzCjdQ46=bkO9r_wDBYdupFbUeOTj+TM6KLV0tG7LomQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] mmc: exynos_dw_mmc: Add quirk for disabling FMP
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Minkyu Kang <mk7.kang@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, Simon Glass <sjg@chromium.org>, 
 Lukas Timmermann <uboot@timmermann.space>, u-boot@lists.denx.de
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

On Sun, 26 Oct 2025 at 06:37, Sam Protsenko <semen.protsenko@linaro.org> wrote:
>
> Add DWMCI_QUIRK_DISABLE_FMP which disables Flash Memory Protector (FMP)
> during driver's init. It's usually done by early bootloaders, but in
> some cases (like USB boot) the FMP may be left unconfigured. The issue
> was observed on Exynos850 SoC (the E850-96 board). Enabling this quirk
> makes eMMC functional even in such cases.
>
> No functional change, as this feature is only added here but not enabled
> for any chips yet.
>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
Reviewed-by: Anand Moon <linux.amoon@gmail.com>

Thanks
-Anand
