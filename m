Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30AF6F531CE
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 23:36:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98EE5839D5;
	Tue, 14 Apr 2026 01:35:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jelEp6PD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3562B841A2; Tue, 14 Apr 2026 01:35:56 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD47D838BB
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 01:35:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-4795222965cso877747b6e.1
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 16:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776123352; x=1776728152; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qCqUl/nuc4wLtAwvlqmh/KpXHMkvdgqJMNRi6np4iRc=;
 b=jelEp6PDxsbOt/uKnDa3Rg0VNw7SgYrVtc87kCoef1xs0uDhBk8WVd8PvJ+8iRVoDl
 vvgnB51kqr9UwLr4vE2LYuWLcQBy0M8xNc55ziigAeQC9Vu/kXnySAyZ8/kfia37NTVr
 lYkoI5aytvqln/bRfk/ofhIzy9NyPgUI+U8Ak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776123352; x=1776728152;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qCqUl/nuc4wLtAwvlqmh/KpXHMkvdgqJMNRi6np4iRc=;
 b=Sq9ERDlnpXtWQN/9r1DrkjYecW6RmESSDqkI/zr6S5SmBr7+a6RLePAL9ivBRwRS+4
 y7Z/9hW9cbTJ/7kjwP6MX/8w8wrd3X8sC5s2Eq4FqDsSDKTkI7JBJ6JfZl3M48lbKUoh
 dHMGt9oRdsrgue7O2b5Iw8aJSSjVanpC8VIhiVnYuePETJBelxiHPn8rfmkKBmDr5EXM
 KjutaF8nTVOtEIXNf3XmanZs8vHbt9BkXmhs1+AZYvkuipnJo4k6WRdlBKtAhESOfADp
 1Zq73+AuuIkpsf89JEhG7MK62eyYp3yS6Pk7OO21Hxek7cGs62Ov0YnLwjrThMavJKsU
 ulkQ==
X-Gm-Message-State: AOJu0YzFo2TTbKswCKD1BZgtOCkswQUu8bet9Y9WGxP3IwhoFgFPhjfQ
 8n4nHA4JpMj1ngO6MRQFiTzU8LMrnoOlBsSngwcvdd1xxEyor956nHfDSwtusmC4LpQ=
X-Gm-Gg: AeBDieua19fjacZJ0WnJS237pBZEMyg8pAsVoJ/DxdJsQlg3BcM2NXHG3iVsg0/ehOg
 MREy6oYfDHUrgxcepgC45Z/UW4g6HovYvNp/iEkLzrb7gQDLELZE1t3OYf3dlROlK0IwN92Ilvx
 vfNq1gn786GfdgghQ2mCh4i03VxR4cEZXyVFeHoVQx0OmBKwaWio3G4kdncCI2+0aUcTK1ZZSLX
 O+kAkuK8c/+UwI48/gHefISsSOUPi3+oXK87UIYabXoqaFePQv3H1qtiUtekKnH2cj29qn/mjMa
 VJB8peDGmp3nV2/zKfCYUFrUcpfvaBo+gFNb2vVg3wJaYmSTuMJXx+KjoSuASCUgLPiMX5h1Q7J
 WmX5TV8Kkakwb2CX+CLQMFi5PYhLF0vEy24aRMbqd3MC2YgntcWuD2GgoOFG2P7YmbFnSKSZEDE
 mpnkTyYOJW6Jwn0+ap6sP74ZJ7ycz8x8lnrxZpshr7mJbTy9b2ugQWLLzz90NCMJzqvZ9Vfayjm
 WwKP4fhUY8/JsfmLtWVCfAn8GMA/dip2zLEtbSfTOP8kU9Cxg==
X-Received: by 2002:a05:6808:2394:b0:472:878f:347d with SMTP id
 5614622812f47-4789e722842mr8069986b6e.26.1776123352483; 
 Mon, 13 Apr 2026 16:35:52 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423dd396960sm10227910fac.2.2026.04.13.16.35.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 16:35:51 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, Udit Kumar <u-kumar1@ti.com>
In-Reply-To: <20260329231442.332359-1-marek.vasut+renesas@mailbox.org>
References: <20260329231442.332359-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v2] arm: Add ARMv8-M aarch32 support
Message-Id: <177612335149.2487918.8100707687730110063.b4-ty@konsulko.com>
Date: Mon, 13 Apr 2026 17:35:51 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Mon, 30 Mar 2026 01:14:12 +0200, Marek Vasut wrote:

> Add configuration for ARMv8-M aarch32 core, which are currently
> Cortex-M23/M33 cores. These cores are treated similar to ARMv7-M
> cores, except the code has to be compiled with matching compiler
> -march=armv8-m.main flag . These cores have no MMU, they have MPU,
> which is currently not configured.
> 
> Unlike ARMv7-M, these cores have 512 interrupt vectors. While the
> SYS_ARM_ARCH should be set to 8, it is set to 7 because all of the
> initialization code is built from from arch/arm/cpu/armv7m and not
> armv8. Furthermore, CONFIG_ARM64 must be disabled, although DTs
> for devices using these cores do come from arch/arm64/boot/dts .
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] arm: Add ARMv8-M aarch32 support
      commit: b0d731d9563cd6fb8bd6c8304065e550d97a22c7
-- 
Tom


