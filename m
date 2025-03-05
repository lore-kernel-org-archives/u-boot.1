Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC92C19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 04:35:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6098080BAA;
	Wed,  5 Mar 2025 05:34:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Z1lup58v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77D7380F9E; Wed,  5 Mar 2025 05:34:58 +0100 (CET)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 590FE800C1
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 05:34:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e5372a2fbddso4492617276.3
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 20:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741149295; x=1741754095; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jslp0zdCBBaRSRAnZ02BSGctzVN26CUsn/AyRQIUdHQ=;
 b=Z1lup58vZhgcTUeMciwqs1bn7CkQG++YjbKogJPmGYFLTmBdrDvNW3O7iuqjOvjVva
 a/DWoTT9WTUOltbZk6fTdJumEvEh7c4NokRezo8HOz9/G9IDGGGfaooH34vfrcGBhMv5
 pP2dXkZOGQrN037CVK40kcNaDtPcBGy0ap6oM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741149295; x=1741754095;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jslp0zdCBBaRSRAnZ02BSGctzVN26CUsn/AyRQIUdHQ=;
 b=XsZRS9oSX1jDmbIU5K8T3hnkyGqNz10OtHzQjmJwunr0BQpW1ry0VxyHt6YME07eI/
 +2FnPruqNTMzf8ayGIiRXcKEYtdgKkh3QKVQKjbgKokTR7akNzzwEQ/Fp3jCA26NgUwE
 YfVngHnOr1lKJTnJB0DZAH1PPiFPEQhfNnvJVxXk/fu5T7tjdrczN2gIdkmkDQ/00Q23
 DCYyrhTna1QEDpyGahZiQizUT6p4QeqDGYYjpOR2qqI9DiuOMzTMWY7luNi10n19jhAC
 LFgYWpHnoZpsQ9iHuPGcxuVtzEjPoUsnlIZh/pRIKI06d9VhYJoPsiwkj1dSHurf/tiP
 Nahg==
X-Gm-Message-State: AOJu0YwZC2ewNAzb/wJ2tnzd5iPpo5ex2LgQoKYIMFwwLzLCuhFbtDjM
 9ob47P7N+wdyho60NwhJHaWXNRUcT5hzI4qxycjnH0VtzdieMsawn/IYQXNh3B04dxDDDUdl3IA
 YeUA=
X-Gm-Gg: ASbGncv/G679psPBbyOk1fJvtOtyzFhtrgvgCmQFCJXlQOQAAhxVqG9CdV/vaJAGIRZ
 c18kzmq+u+6qDzQbdEuo+4AUExt1hKtwK4ZLF6pZNRs9ur/vX9betF5tk75wl6QLXZZD+ALnDpv
 KPtIWgQfT8PMxwfMnCdbG3TmLeABPBip1uBW14HGptTMOcon2W6LtfrE89Tyq/xOFnmyxsrg5Zr
 yLNIRvf2PJsabh4SF9TnaPZGEKGLT4sbtyY5Jx4cDBXGq5nHmm7SW7PZsy6uFlkWgQrinmnp73r
 8YIMY7jh1YxII/h6rtDE66uLFX8ZYgzhY1V8q97YGA==
X-Google-Smtp-Source: AGHT+IGxr4TgBmhzru7bPVJyN3hWl9hacx/HNBj70nil3li7Bmg+82JZiMdyf6ZhC+O1VT41wEVoPQ==
X-Received: by 2002:a05:6902:2386:b0:e5e:758:10e1 with SMTP id
 3f1490d57ef6-e611e2f93d3mr2359452276.23.1741149295103; 
 Tue, 04 Mar 2025 20:34:55 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e611fe84574sm224657276.46.2025.03.04.20.34.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 20:34:54 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250217-dmspi-v1-1-58d2a71dc9f6@posteo.net>
References: <20250217-dmspi-v1-1-58d2a71dc9f6@posteo.net>
Subject: Re: [PATCH] gpio: 74x146: depend on DM_SPI
Message-Id: <174114929380.2897264.4603650925414567326.b4-ty@konsulko.com>
Date: Tue, 04 Mar 2025 22:34:53 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Mon, 17 Feb 2025 12:18:03 +0100, J. Neuschäfer wrote:

> Currently, Kconfig allows building CONFIG_DM_74X164 without
> CONFIG_DM_SPI, which results in linker errors because this driver
> actually uses dm_spi_* functions:
> 
> drivers/gpio/74x164_gpio.o: in function `gen_74x164_write_conf':
>   undefined reference to `dm_spi_claim_bus'
>   undefined reference to `dm_spi_xfer'
>   undefined reference to `dm_spi_release_bus'
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


