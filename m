Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A9DC27C4F
	for <u-boot@archiver.kernel.org>; Sun, 30 Jun 2024 14:47:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 234848845A;
	Sun, 30 Jun 2024 16:47:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Fhlsg7PB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 331D38842C; Sun, 30 Jun 2024 16:47:28 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30D5C8845A
 for <u-boot@lists.denx.de>; Sun, 30 Jun 2024 16:47:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-701f3ca4c8aso1242266a34.1
 for <u-boot@lists.denx.de>; Sun, 30 Jun 2024 07:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719758844; x=1720363644; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UU3slyRU/C3hvdykulC48HR1Bw9+tlXPjesQIVJam1A=;
 b=Fhlsg7PBisTAcphW8rBP0PEfZDvPa6avL00Sx9ZoEuGHoUBUsgxNise2THwv+7KbEN
 YHJ75TawiXF98YbvODchNYAvE9gCJgSp0rttg7ICSX/y1wOfoNGD3qQQMme7XBMpT8Gg
 Tk8QJPDhPhgAWEuCDS1nzIjUA+SJJeXEi7p28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719758844; x=1720363644;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UU3slyRU/C3hvdykulC48HR1Bw9+tlXPjesQIVJam1A=;
 b=LBRcEaxDsWV86W7Sa227eDpbeNRjhCEuutP1Af6LBMNl09wU3/c86ViDtsWnwxP9uo
 UAh6vGx+BmH1L2ng0kWtc9e6MkP9lFiH8keBi6b+4xQTUTbDqDXOdb8GPhH8LsiiFVy5
 I+qKjiTtPFnAivUgnanqBWNorZcLYf/ykGzCrn1rEdd8RJFfRYSCJ4ZA/oN3RI7JiC1j
 ndQZyH/2NH3EPi69QMYklTLmM0oYA4yUyE0U1cq/PJpHIB9NkTCQ0BTgUiFX7+aDdyNN
 5AC0fMbQAckK5XhYfpTuim2F7GH2ta+Dqr6i7qsuhO4tc/CY2BbMrFPxRiJ09VD7SD3E
 zUKw==
X-Gm-Message-State: AOJu0YxMCASIXyAN8FMSJ+LouQCG1UGcQZuqU7QH0dOkASF1yj1zhRrc
 AjowA2nAgImoofwp0I8PszrTuaXU+nh7zTMV1iZalC1c7oM1dp/d54mbbYa8M6I=
X-Google-Smtp-Source: AGHT+IEIsMbPKKnJ23uviiZoyBgY3TocvzJup3Db7q+w7dnUim9WhuDCbdX9ZWAktNd0ojSU+Nls6w==
X-Received: by 2002:a05:6830:328e:b0:702:738:8b71 with SMTP id
 46e09a7af769-702075e40e0mr4032909a34.15.1719758843851; 
 Sun, 30 Jun 2024 07:47:23 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-701f7ab196fsm988913a34.23.2024.06.30.07.47.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Jun 2024 07:47:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tim Harvey <tharvey@gateworks.com>
Cc: Simon Glass <sjg@chromium.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Devarsh Thakkar <devarsht@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Marek Vasut <marex@denx.de>
In-Reply-To: <20240618210609.1744727-1-tharvey@gateworks.com>
References: <20240618210609.1744727-1-tharvey@gateworks.com>
Subject: Re: [PATCH v7 0/4] automatically add /chosen/kaslr-seed and
 deduplicate code
Message-Id: <171975884247.3779922.2683904121917040671.b4-ty@konsulko.com>
Date: Sun, 30 Jun 2024 08:47:22 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Tue, 18 Jun 2024 14:06:05 -0700, Tim Harvey wrote:

> This series will automatically add /chosen/kaslr-seed to the dt if
> DM_RNG is enabled
> during the boot process.
> 
> If RANDOMIZE_BASE is enabled in the Linux kernel instructing it to
> randomize the virtual address at which the kernel image is loaded, it
> expects entropy to be provided by the bootloader by populating
> /chosen/kaslr-seed with a 64-bit value from source of entropy at boot.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


