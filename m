Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B5C5E67819
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 23:25:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACFC789102;
	Sun,  3 Nov 2024 00:25:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="S5gJznLR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D7D2890FE; Sun,  3 Nov 2024 00:25:20 +0100 (CET)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31D5F88C86
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 00:25:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-4609c96b2e5so20587661cf.0
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 16:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730589917; x=1731194717; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5Snr1eW6Zth2h8uvleRHRUpKm/WCWcpbuoBVnxHjXbs=;
 b=S5gJznLR8vXm2pvngvDKrrPwYfATzoYrGh3mleI9SKDR8xi00axKRWIOf/yPyENAIx
 SQpvDTH06zTw/RoK2CZmK8wXFzVFhb96/WX+pGOXMWjCvdFH/7xb2sFGZeft4Due8i2I
 VZ2RCOAlJUSwfl2JMAdWrQthH4ZOkNhjzahos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730589917; x=1731194717;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Snr1eW6Zth2h8uvleRHRUpKm/WCWcpbuoBVnxHjXbs=;
 b=p3cDkUqr5ERwce+5xkBGAyTUtc1mJXPS2aqHWUXk2FoKkAPLbZA3RIeSwmlKJ6t+aQ
 F3dRFBCrPNEF8D3CEUeDrYdONBzTPO6fxtK1RBSdMhZalDiAK4O5ijncS55RkPveMETl
 G0L3v4C1bIwv/Gx8U1Vk7HpfiUIcc8IoqT+ltK0dWaXtyefCMXDnOOOYAEuMC+hp0GLC
 TmH+uSJ5ICjzq9SJeME31DXKr2Dx32Pbqr/AyRwXgGS91iNmxaqNs1BJ0xx8R5ed1QUG
 o2aUjZaepg5ECOFtGsl8eB0jk0rDPzG7jlQZWw8FxCHR1TW35P4538IiCG5kA6Oc1kkF
 XBzg==
X-Gm-Message-State: AOJu0Yy2HDxKunCWTBxMWmDF4vn/ijXi1axP5HDvHjry+UHN5JBf6O2E
 yqZ+kwvbE/yjfAfmkhVyke61Wx64vxEiK0fOYl8WgZXygIlhilKp5OcEfLBEEsXdJWQHSmFDsZT
 1
X-Google-Smtp-Source: AGHT+IG64fpmiXP8cBI7INFvT0VAE/Fzx+ooQdEznHexnMKQfJHqFIlK8ePHt5Pr0cp9TkW6RFjMhA==
X-Received: by 2002:a05:622a:20c:b0:458:5716:fbd8 with SMTP id
 d75a77b69052e-4613c0542d7mr410280731cf.32.1730589916941; 
 Sat, 02 Nov 2024 16:25:16 -0700 (PDT)
Received: from [127.0.1.1] ([189.177.125.149])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-462ad19b4f5sm32412141cf.83.2024.11.02.16.25.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 16:25:15 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>
In-Reply-To: <20241030131149.3005320-1-patrick.rudolph@9elements.com>
References: <20241030131149.3005320-1-patrick.rudolph@9elements.com>
Subject: Re: [PATCH v2] acpi_table: Fix coverity defect in acpi_write_spcr
Message-Id: <173058991496.1044919.10163924752036565749.b4-ty@konsulko.com>
Date: Sat, 02 Nov 2024 17:25:14 -0600
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

On Wed, 30 Oct 2024 14:11:46 +0100, Patrick Rudolph wrote:

> Fix "Integer handling issues  (SIGN_EXTENSION)" in newly added code:
> Cast serial_info.reg_offset to u64 to prevent an integer overflow when
> shifted too many bits to the left. Currently this never happens as the
> shift is supposed to be less than 4.
> 
> 

Applied to local tree/v2-tidy-test-dir, thanks!

-- 
Tom


