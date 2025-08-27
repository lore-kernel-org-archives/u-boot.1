Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3DFECA0FED
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 14:41:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0B81831BE;
	Wed, 27 Aug 2025 16:41:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="V5VqUNtN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3025831EA; Wed, 27 Aug 2025 16:41:09 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0CB7831BE
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 16:41:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-74523a19fb3so2335326a34.0
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 07:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756305666; x=1756910466; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QLnk4nyxeSMyAafRQkIzdHn2CwutnkUNzIzG32nGLfU=;
 b=V5VqUNtNb3zzNxJSmbquRx8bsLAEatXJCiNw5qA8oYVm5GCgbN9punhtBu6zw3D68y
 dLvZIlk/5xl9B8MpXZmuyR4AeJBVmWQyJCHsfnVlZPIzdwmmXBGylgvA/L4jBIbvYtmR
 pHUNOqmW9tCBtWhu3TE5jdadej9sItG6wrblc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756305666; x=1756910466;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QLnk4nyxeSMyAafRQkIzdHn2CwutnkUNzIzG32nGLfU=;
 b=HEt2EoCQOEFjII4OFTMuR5l3NpKb/WX27DeZJLIIPtS223Hli8yDb1diuYzYWi7Iwz
 8bWujMw/Ht+TMadO9q3ONG8T7WKC8hIxwPmtDZVsaGOKJlVCMABbHJtAOE1dIHbrawnm
 26X5WH9hGFsqKx3R803awG9zwBTXoUjyKo5OgtHAOuS8c6CSw5+0azUaTV8gX1gYVhDA
 IESI+w6G8uLHCrBugPef+zrfAUldyTvhoyXN666ZdHlMgJ+R5UEmx2uZuJAsWh6/hvPj
 ngHQS5AFpxTFFbSKgOX+gXaS3L5Mj0bH6TvcikzNNQk08EZtbI13VJiUrIc4+/DZH/FC
 DD/w==
X-Gm-Message-State: AOJu0YzOVmGXkMaoZG065LApgcelJVQzve18aKyiDfUsHZ1CXfD106u2
 4xA9apFjXncCtF7TR+vlDJD85U5RtTOlECxeucuoQZELAqGReFbu1KB8pA53BmttgdE=
X-Gm-Gg: ASbGncsxKw7bTWzmUwxyqr5umhcz0Z3W3x14Biwr+9FkZsSVsDKF9XtHYM/NMnJf3S0
 bnDXBNbrCBazYiT2VJFbX1dp/f+y7veMNuCfU9j/E2RjefNjmbVgaV2QXW5jpc9Y2Tm/fpmr3r5
 zsfvKI4O/L+cQouXRsMq9fqgWsW9HBWoresIU7ATmfSRibQRQ+BNXaEzhKuCrHCabYfsHO1HYmw
 ZSoD75eCWRKWJ5FhDUkvss7j/zjipeSnE/wFcQkvZIbwuzXQvp8W6GZLMn0TGqgeab3ARyNSLpX
 JqyFWp9lzcW1rGLdE4crcSPDr+0LptrKcqqKOU5KgMguixGalSDDutcVCB5aPt57FWajZMn4Azp
 PR5j2jYy23AhqgSsr0PsuDBn9P+xQN43gnjQqicEj/9DF5XMMG+7W+SQ=
X-Google-Smtp-Source: AGHT+IGFBordYdJ6+aPi/F+zh5a2xcvXkxVmxbclNi9FKMi7qSIcdWBiIHKbo0qjouJmNayfWBWoHQ==
X-Received: by 2002:a05:6830:4989:b0:741:aa6b:8afc with SMTP id
 46e09a7af769-74500a6d2f2mr10163809a34.21.1756305666509; 
 Wed, 27 Aug 2025 07:41:06 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7450e11af87sm3029411a34.0.2025.08.27.07.41.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 07:41:05 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, marek.vasut+renesas@mailbox.org, 
 tien.fong.chee@altera.com, sjg@chromium.org, xypron.glpk@gmx.de, 
 seanga2@gmail.com, daniel@makrotopia.org, 
 "Lucien.Jheng" <lucienzx159@gmail.com>
Cc: lucien.jheng@airoha.com, frank-w@public-files.de
In-Reply-To: <20250817150203.52850-1-lucienzx159@gmail.com>
References: <20250817150203.52850-1-lucienzx159@gmail.com>
Subject: Re: [U-Boot, v6, 1/1] misc: fs_loader: Add
 request_firmware_into_buf_via_script() for flexible firmware loading via
 U-Boot script
Message-Id: <175630566496.642307.11208800419864665082.b4-ty@konsulko.com>
Date: Wed, 27 Aug 2025 08:41:04 -0600
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

On Sun, 17 Aug 2025 23:02:03 +0800, Lucien.Jheng wrote:

> This commit introduces a new API,
> request_firmware_into_buf_via_script(), to the fs_loader framework.
> This function allows firmware to be loaded into memory using
> a user-defined U-Boot script, providing greater flexibility for
> firmware loading scenarios that cannot be handled by static file
> paths or device/partition selection alone.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] misc: fs_loader: Add request_firmware_into_buf_via_script() for flexible firmware loading via U-Boot script
      commit: b5da53046c303d7cff586b366f225dc4c3b64686
-- 
Tom


