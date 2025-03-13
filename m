Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB940C282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 22:44:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C940880FF7;
	Thu, 13 Mar 2025 23:44:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="M7g2pGMk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A37658175D; Thu, 13 Mar 2025 23:44:16 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBE0780756
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 23:44:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7be6fdeee35so254429985a.1
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 15:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741905853; x=1742510653; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0LifQrMOKSSxWOyo/y83/Yc08C2LHdvGHz7eoVZdW4c=;
 b=M7g2pGMkxpYPJ9SfgYHIKonon0BiqTyEW4E7oFO0nih9XGR7t9zp0sEJpVAc4hr4Wa
 quchiMG3JCCEMbbAnIj1DV5XAUB9C67vDGkbX5SevrECYrm/K10VSr92xr6GjTe/TYdx
 2aOWJjPQeAbrDxrUBEy2aUqe1IUVf9lxhpwOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741905853; x=1742510653;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0LifQrMOKSSxWOyo/y83/Yc08C2LHdvGHz7eoVZdW4c=;
 b=fiYE9Y2Xn6DUxPVeVQGpnCO6hOrmY4CT+/hTgogExsjk/y5F9nH0jwpp+UoOzQNt20
 X7s0nymo5MTEToKdifzxaNkqlqUFAwXZlTt8oPLUhr3n9aAKYTSZNTOR41MeFPXZgZZb
 Ruj5ZdN7JKCydp7fitVWyS+DTbKJgpNF6Bnzm88xbRKy+ZU/EfRF+3qsjRY+J0j7K2+e
 ek5rD4cZ4ZgRBG+nlUAQMey5oncoc4agm7BytY6q7aCDvukx+8+EJnq/QN2U5xUsaqGy
 OmhmVk/zK2e4Q43yofd6iWcRA6TDIqJDajBfdGhziMjZlUhNMbYrKFTgG72kKAuE/FhF
 pLcQ==
X-Gm-Message-State: AOJu0Yzf8Hppa2k2GZFDDtBdKi9j0chSLVmSOujdWEol6lxKCHtYtcEs
 ILGePBqywhzoQ0fGKiNWfAHQBngfpr/i3DYQShc+IAgGCdDvkCCZentlbZ04O7B7ZNSz/NqBi1o
 1
X-Gm-Gg: ASbGncsgAsHiVN3nHnfvqXs1Otpj7a7B3HlOUsjMeVzHgQQqmbQRVjdR0snay+xBhCL
 lM6wBiMoZNCrARxF8rD1fLqHk2rDKB1r1vFbDK7BTXMeuiztu9R6T04mojF5Pgfu3khO0mH459N
 K/SA5dbkgYQBh2/CLneFQjnNxfT70sjAD463ZxUbDXirsIxNRp0z0GDb1v9TwT9I28hWr5cQU+y
 1eFTV4pyylWvqOiaskLwzsVqze8BCKYjMCYjZ2vLrLWAn5ZGPY9tciMRC9cgoovluhAOEqTjkii
 NNPhdU/bro+SiiVqoWhPUKos+LQN9DZYDrpIVj6U5SGt
X-Google-Smtp-Source: AGHT+IFXg0al/bJrlCGyxwvaHnMf1kuBm2xa3o55ZTJ69nxyDzIF+WD0+Gor/3fcn9RhJMuaIyfXzg==
X-Received: by 2002:a05:620a:4725:b0:7c5:658a:e584 with SMTP id
 af79cd13be357-7c57c919d63mr14879585a.53.1741905852790; 
 Thu, 13 Mar 2025 15:44:12 -0700 (PDT)
Received: from [127.0.1.1] ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573c98225sm154508585a.49.2025.03.13.15.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 15:44:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250212222415.684601-1-trini@konsulko.com>
References: <20250212222415.684601-1-trini@konsulko.com>
Subject: Re: [PATCH] Dockerfile: Add missing 'rm -rf /tmp/coreboot-24.08'
Message-Id: <174190585094.2150240.7332909843495971863.b4-ty@konsulko.com>
Date: Thu, 13 Mar 2025 16:44:10 -0600
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

On Wed, 12 Feb 2025 16:24:15 -0600, Tom Rini wrote:

> We had missed removing the coreboot directory once done, fix this.
> 
> 

Applied to u-boot/next, thanks!

[1/1] Dockerfile: Add missing 'rm -rf /tmp/coreboot-24.08'
      commit: a920169b4c7446702f3fbf3a61cc55069ee128f9
-- 
Tom


