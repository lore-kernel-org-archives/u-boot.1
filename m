Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25413D20681
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 22:26:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82E4A889C3;
	Wed, 16 Oct 2024 00:26:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jW52BWvM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EB1188966; Wed, 16 Oct 2024 00:26:13 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89A81889AA
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 00:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6cbf0e6414aso22118306d6.1
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 15:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729031170; x=1729635970; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LBmde6HPvFg3wkQvB7f/ymMqVTsD1t5AR0XgOYmyL2Q=;
 b=jW52BWvMBUtbAaaTedF1bQViqUELFPaRqUhzJvrst/LXGkgFCAx1sH1Q+6whHQGt54
 zj9jCLT3XKgch++tOawpZny57v95vkY4wNMwmEZybaZiF/wvn2tt9tZ4FTGCHzJ8g9g8
 zLXkkyEvVRuaUYl+NFltTC+74rSd06f0EA3VQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729031170; x=1729635970;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LBmde6HPvFg3wkQvB7f/ymMqVTsD1t5AR0XgOYmyL2Q=;
 b=rj2V7zsoysGjGH1Wxcqq0Una2N4YbWeexD4PChW58CsjV06C7gYZ6DSnaNCjtRpXjx
 s9uI0YvUvF5jOWxc0f6DCfJgd0hZI0kl0882G5loxb28bpeCZn3aNLL8ICuesQDzGjxi
 S45rplMiTr3RI0YZT6a26lOFxZ4HYljZPeYk9yDxiJNz3DJLvPNiLiLN2XtGiUdJvUJL
 jdRDAElI0SspTVIVjOEdGjUhfibA/npBEeMF02Qe4aZisy/Ne8dK3GYgbeQ4rnc9GWfa
 VLrkCOojKrbI1fV4bTbQNTf/+rRt+KFHMHUuERrBDZA3YC1VWR/BaBSQXpDQAW5htPnS
 CLrA==
X-Gm-Message-State: AOJu0YwCNFnPbvVN3KRrx5TlRyuILNh8GjhA+gQh2h0Gg4vP7JkpYe8E
 dq+GpVt/dCLLNfONWJ3GE27Z5srWGhAZ3tD0xgvXNwewFiQZ+WdeKkgqzbR9cv56egp5iNhz9Eg
 t/Es=
X-Google-Smtp-Source: AGHT+IG7m58jEkJjs2aPnV3w3Cm5VXJf/CPyMK6UwQ0Ex2qRonDFXDIaFSNlH9TbMDqfH6YmtiKiKw==
X-Received: by 2002:a05:6214:328d:b0:6cb:c905:f380 with SMTP id
 6a1803df08f44-6cc2b8bc925mr26590466d6.2.1729031170200; 
 Tue, 15 Oct 2024 15:26:10 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cc22959ae2sm11381076d6.93.2024.10.15.15.26.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 15:26:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Mark Kettenis <kettenis@openbsd.org>
In-Reply-To: <20241015153717.401371-1-sughosh.ganu@linaro.org>
References: <20241015153717.401371-1-sughosh.ganu@linaro.org>
Subject: Re: [PATCH v4 00/15] Make EFI memory allocations synchronous with LMB
Message-Id: <172903116836.20251.11081117115298191100.b4-ty@konsulko.com>
Date: Tue, 15 Oct 2024 16:26:08 -0600
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

On Tue, 15 Oct 2024 21:07:02 +0530, Sughosh Ganu wrote:

> This is part two of the series to have the EFI and LMB modules have a
> coherent view of memory. Part one of this goal was to change the LMB
> module to have a global and persistent memory map. Those patches have
> now been applied to the next branch.
> 
> These patches are changing the EFI memory allocation API's such that
> they rely on the LMB module to allocate RAM memory. This fixes the
> current scenario where the EFI memory module has no visibility of the
> allocations/reservations made by the LMB module. One thing to note
> here is that this is limited to the RAM memory region, i.e. the
> EFI_CONVENTIONAL_MEMORY type. Any other memory type that is to be
> added to the EFI memory map, still gets handled by the EFI memory
> module.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


