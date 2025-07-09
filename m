Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB4FC83F03
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 14:23:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F391C835AA;
	Wed,  9 Jul 2025 16:22:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WmbhnTiO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35A7B83559; Wed,  9 Jul 2025 16:22:09 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16D3D8344C
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 16:22:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-40a4bf1ebb7so4959b6e.0
 for <u-boot@lists.denx.de>; Wed, 09 Jul 2025 07:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752070926; x=1752675726; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VzoK8NKxCakKEct/n/LlPMbGbTfN+2WEH5X1s5a3Wl0=;
 b=WmbhnTiOjq/WsNxtLPmR4oBUIToll8gVOE1WmdnzTXmh47dWm5kk3OC8f5UHHetX46
 pZqIVw7/pY831ru+cfKfajA4v8uQIz4e+EzqgELk4dwWxTKjum27/1E1HRfyH7krVY5D
 GcVEoYVUSifFa69ec3NUiyivThvCCp8WF8VuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752070926; x=1752675726;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VzoK8NKxCakKEct/n/LlPMbGbTfN+2WEH5X1s5a3Wl0=;
 b=s8IJtWZYHsqaDSbaVrHNIw4EYWxow7VA8IHRxoZuSUItzbH3K0vACv0UQ4/pQ7xwp+
 dy+dLzBVhgh5LnFzCQbbteKDJkK1UR7r11Yd2BxOleld/Mf2wPqTpwLA4MPB139AA5B3
 ghl6UEAOOvr6+J+O8o8Y/OLkcplXIin3RXuEzf04Rdl3B48IJH05/pS6HGp9v6ro+kDU
 Sk3dXzgyDk/fwcWGWAB4i7WwpgMtWpApBknq/4SV3lmjXqLftg9bjT+df/SHkCPKFEMG
 187PoQy2PV/sxXYE1v1QwHghueuDw+cFpWrXTv5/veIc6dG+sj7WUKvnVOVdgw42LwAk
 pYBQ==
X-Gm-Message-State: AOJu0YxlOl5sAFUvCGFngsohUMJXFyEFgeH5nZoqjzn56aQWntenhZUT
 rNFZhmh5p1J8vJX5PwhgwLfZD5T6E0SrlHWqvA57pbv6CmS5ObPyrktvfP9tNdC3Jgo=
X-Gm-Gg: ASbGnctosf1ESpRs2YNWdohk7zjakPvPjlmf1qgad0edYrIL7TZ2CHBp1YvdaM+XM2p
 8DsdekRlWhTKmFbvSmPk8sxyODYWUFdxiv7p6D4j3mskioqJQZA+W7uIGUcl7w5xGYAyAr4kI3M
 VkpfJBmOW51mAUKZCvC3DR1PziCKqnVEhP02bmRRp1Q+LPJWIAdWEkmADenIc32UQW49WSId446
 9ikWX+sN5qga9DOvqg3gqtlSlRK8wwb9iIGMq6rjnKzlZFKTQ5cN5yIhSQRIu4pEf250rySQ0rs
 l6Aq7VKDHiqgK7gNsqrDgfboSuSTzJo46QHfaxQh724F9+GVSnKdn6XD7WcOU+4fpyDrRnpbf9+
 /N9V3gElZg/n+Pb9+iS0=
X-Google-Smtp-Source: AGHT+IGoHteHygA7RpkUIuiieL4KZHBVUojCOV2tlVYieRyIQ45K4f0KUxTck/8GbJPOweV+gx3syw==
X-Received: by 2002:a05:6808:23c1:b0:3f7:28ac:8068 with SMTP id
 5614622812f47-412baca2db3mr1967012b6e.13.1752070925762; 
 Wed, 09 Jul 2025 07:22:05 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6138e5ac83esm1919975eaf.27.2025.07.09.07.22.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 07:22:05 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250630-boot_pxe_fix-v1-1-e1f077dd4e58@linaro.org>
References: <20250630-boot_pxe_fix-v1-1-e1f077dd4e58@linaro.org>
Subject: Re: [PATCH] boot: pxe: Prevent evaluation of uninitialised
 variable
Message-Id: <175207092521.1813324.2490614442203203305.b4-ty@konsulko.com>
Date: Wed, 09 Jul 2025 08:22:05 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Mon, 30 Jun 2025 12:57:10 +0100, Andrew Goodbody wrote:

> In the case where parse_sliteral returns an error then label_name
> will not have been assigned to. In order to prevent evaluating
> label_name in this case add a check for the return value of parse_sliteral.
> 
> 

Applied to u-boot/master, thanks!

[1/1] boot: pxe: Prevent evaluation of uninitialised variable
      commit: c3b43eeaead77beef53a224c7d13346a0462b34d
-- 
Tom


