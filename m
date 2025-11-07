Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 986C9CCF9F8
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 21:35:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9AE783E57;
	Fri,  7 Nov 2025 22:35:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lP1vR9je";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4482783E42; Fri,  7 Nov 2025 22:35:01 +0100 (CET)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CC7683DF3
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 22:34:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-3c9789ea2efso402559fac.2
 for <u-boot@lists.denx.de>; Fri, 07 Nov 2025 13:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762551298; x=1763156098; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rtS4mHZ04UWM2zhElfyn2nQc/KGbY9kv4M+VHZiSNSI=;
 b=lP1vR9jeCuS77o0yOrcj2qyZTBytRlyvYhIzLZ/BlKs2m2WI9Y2rNeMKH47NypldeU
 ykfUV4AkgP/tXe3CwEuf3dZ1B7EDcqbkZEad2umukxkcoKu9FrfrOy4dVTSOAMnAjP+O
 xrgGUN5+1LcTEj9mASiT4emjkxrUXNYH+JHUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762551298; x=1763156098;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rtS4mHZ04UWM2zhElfyn2nQc/KGbY9kv4M+VHZiSNSI=;
 b=I3gDexkXL1L/I4Kleg9GrqB6FhJ79DDzBwudpBzuRShFdbmEQhvKXMik1vXtPfhpi3
 odRT8hLnO4v/tldfCsb5taHrZtUV0pBjSHTwBgGQIm7yKBDNnQpCjDl6t+XQ+WUQTUoP
 p9ARnjU5oj++AcS6yha2hDB+/bv9r6ScXKCEo/rFaKfXayvv3AZ0TNBHHgmL8ztugzVU
 ippHYdydLq84X14goJyGhLuek5iIK614zcXcQXGoRz3mSCZf2RhEn1RblP/H0kY/CR1P
 OmcYenDbDFAIb22932IKoxXsskUw6YUFQjNb7dL+aogSsD6ov4UiQBiKIdqDrArNZDnC
 /PWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvmlPH+BGcqtN7khcMN4s+nuvfAX/4vwySTNYbm/2SKOJhuhswVAXwPY/Ff+PJqJ92L/eBXys=@lists.denx.de
X-Gm-Message-State: AOJu0YwCuN3zTMp/ii9aYLjanySoyKWtqIZG1AqIGWyH70rvQnNBi8zY
 wt0W6vqeagbw+v/pUGIwqbH3w3FzJwocUFl+T6FqVqaEhuLU90Q9CJ9lTdKjcf2HCgMgvu6c1cQ
 LO6WqUfqsHw==
X-Gm-Gg: ASbGncsBUnKhDaUUEN7ItknOpOndkP9KBEzXJeuEPfsPWVk06VjFIa9W4cC0kLTy96z
 8PqsiOp+26g0YDiKSMh2xUlow4OOUuNhdpGzC6ZiugNFYn93a06NNrwdCUL/3W7MCNphvwjos1u
 2Pm7/DLLJ2AA9rwf2azhpwPsO1dFFPcdlzyvGB8pXn9ZZQmsA6tjXmkCcvOcB8RetK1q47XiPP+
 VkBJVfi65n3KOlMKtUozkuF/o+gHd8bHHA0kGscdsnWzVR1ywktS89gsLiABhoDDvdYiumOnU+t
 U8B3OLId79GSioyNJkLEugLnADOEJ150CtTF1vO4ITR0gSI+gMX4ZDdKGPBmNYZfo5IYymmSVIX
 kmu9mg/u0JmiqFazQWdurrmsh0PtgVCY4S3EHxMjrLk76doZ3MXTsK9Vc4UxWOzoGmbDpUjgy3Q
 VF8uYLHO9GsBHJAdtRsJq+D0+L1JhEflYjcPmvlg==
X-Google-Smtp-Source: AGHT+IHO7uZ0rW4T0cYe0AnZtBEjCrqgtv0ruYTQo+q8P1nheMOM250S78teZBlUtaFm9+Jv0M6DlQ==
X-Received: by 2002:a05:6871:3282:b0:345:862b:7190 with SMTP id
 586e51a60fabf-3e7c27b0a86mr654788fac.18.1762551297966; 
 Fri, 07 Nov 2025 13:34:57 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e41ebb0fc6sm2507000fac.2.2025.11.07.13.34.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 13:34:57 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Vitor Soares <ivitro@gmail.com>
Cc: Vitor Soares <vitor.soares@toradex.com>, u-boot@lists.denx.de
In-Reply-To: <20251028151012.126588-1-ivitro@gmail.com>
References: <20251028151012.126588-1-ivitro@gmail.com>
Subject: Re: [PATCH v1] toradex: verdin-am62: sync rm-cfg with SDK
 11.01.05.03 baseline
Message-Id: <176255129730.3424353.11579191105070590637.b4-ty@konsulko.com>
Date: Fri, 07 Nov 2025 15:34:57 -0600
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

On Tue, 28 Oct 2025 15:10:11 +0000, Vitor Soares wrote:

> Update the resource management configuration (rm-cfg.yaml) to align
> with the default configuration provided in TI's AM62xx Processor SDK
> Linux version 11.01.05.03, generated using the K3 Resource Partitioning
> Tool.
> 
> This matches the configuration from board/ti/am62x/rm-cfg.yaml and the
> notable change is the sharing of MCU GPIO interrupts between DM R5 and
> A53 cores, and reservation of an additional virtual interrupt and event
> for TIFS usage.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] toradex: verdin-am62: sync rm-cfg with SDK 11.01.05.03 baseline
      commit: 7f11be48db6a328faf59bf5f7653f469208ad03b
-- 
Tom


