Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34DBEC83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 23:13:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B084E83043;
	Tue, 15 Jul 2025 01:12:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hT5mghKQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1E2883020; Tue, 15 Jul 2025 01:12:12 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D687882E37
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 01:12:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-735a6d7c5b1so2842744a34.2
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 16:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752534729; x=1753139529; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w5I6vuqONv7ytdju6STOiNtKJIfc/YDlKhq1923kJDo=;
 b=hT5mghKQeRP/nLgO8w9HVB1heW0RIMKm8S+U5RVdNIPjJTKpG1q1PDTMA/nCOqqExe
 K1FIALklBSKhEdqJk8MtcPzIJjf1AV3zRpiv0lIdlle2Xs9eUoKUU0J9v44J9I76ztyu
 crnBgkbEL4pLVDfK28X4uVSxoN5wpsajLlVtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534729; x=1753139529;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w5I6vuqONv7ytdju6STOiNtKJIfc/YDlKhq1923kJDo=;
 b=hA9a7sfYjrL6IskzhLGYL6lkLX0gQNwmkH0BtL4W0iZVDi1M0urnpowctYVccFaL5y
 HiTRiBhSxymuopxmD9FS5IafP3PkzwFUDEXcYltvKvsbNw21C/kTtHcknB2fUP6k7ps5
 hxAzNvJlss3dN4/R1E/FAXf4udcjxHWpa1djiZ3pL6A6MbW/uzNSoKGZhVT8YXdW2TuR
 edbKWN+CeM9Jg2O9ddGjKUg3eQ0HLUu9fa9HW5ThLdNUKwIxuC7QC7DSLRaP8SYkVZsT
 Xc3vU+4hcQhc0fF3Hwz9otplsSG55+uKupCetyHX6STKEEJIhCPW/6CzCyK2qCBSfwp/
 LnjQ==
X-Gm-Message-State: AOJu0Yx2kMaYx/McN85YQq61bDnq+PGyYqWFpIxKzvGoaUdR6H8dJB3r
 y3XE8aDG5IUUcaP7m2LVtbnKkqvFlAIRqD7/4779cjgE6Eni8Yi2BeTciBb1lYe5LeQ=
X-Gm-Gg: ASbGncts/bmsupGTiQCHrJ0AT/Q8YkTU1n9EfvPMhcG0kfbTqxJGil7+0NUCC96UY8F
 ioBuKBicqR6rzkxNnASFV/udpQG2kcKKPFeCNpN9eBAJmHUTL1bPQODe1Isco18bvL4AigO9axl
 kOusqYYK2QR7WyV6STtZxFtWs9KjtUmL0cNtwNpntVQf968jQM1qAkev9AcSSDAgOmK0Bh2BuBm
 KCDTsTe79N49MlankX3n3eyMdjRjYfmA74fszRQmFsCeIkV33lTPuJN4+6uG1bfruEPDSLR12Gc
 Z+xJucV5im9h5+q5RQgcaJDCl5jnRKB2EOHwZBFa2dEjjrSBr35yF2S3kuTi9qvIic/z/WEbTMR
 rzphsISasuX97fP9Gc2CC37nu7VjhMMhCg5SfVwtf9Gh6D7veXrlPB10=
X-Google-Smtp-Source: AGHT+IFL7OQi7boDEFGJSKqeqt48bjOR2Ylt0TmWmknPRMTUjV7ogyQRIucwqTcQiDbnL8uzgmsuYA==
X-Received: by 2002:a05:6830:4907:b0:73b:2c88:8ec3 with SMTP id
 46e09a7af769-73cfc4a31c3mr11138566a34.27.1752534729613; 
 Mon, 14 Jul 2025 16:12:09 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf108af60sm1729410a34.21.2025.07.14.16.12.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:12:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>
Cc: vigneshr@ti.com
In-Reply-To: <20250703130227.4106816-1-anshuld@ti.com>
References: <20250703130227.4106816-1-anshuld@ti.com>
Subject: Re: [PATCH v1] configs: am62x: fix CONFIG_NR_DRAM_BANKS to 1
Message-Id: <175253472881.280771.84712494243852465.b4-ty@konsulko.com>
Date: Mon, 14 Jul 2025 17:12:08 -0600
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

On Thu, 03 Jul 2025 18:32:26 +0530, Anshul Dalal wrote:

> CONFIG_NR_DRAM_BANKS defines the number of DRAM banks on the
> device. The default value of NR_DRAM_BANKS for ARCH_K3 is set to 2
> (arch/arm/mach-k3/Kconfig:199) but should be 1 for am62x platforms.
> 
> This patch updates NR_DRAM_BANKS value for all am62x platforms to 1.
> 
> Fixes: 2969ed31b893 ("configs: Add am62x_beagleplay_*_defconfig")
> Fixes: 2d257d9279e3 ("configs: Add configs for AM62x SK")
> Fixes: 085cd6459dae ("board: phytec: am62x: Add PHYTEC phyCORE-AM62x SoM")
> Fixes: 7d1a10659f5b ("board: toradex: add verdin am62 support")
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] configs: am62x: fix CONFIG_NR_DRAM_BANKS to 1
      commit: b7d70fe68b9ca8f04ba3917d71ec4e84058b9948
-- 
Tom


