Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296D6CD13D3
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 22:16:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65E6D83BD2;
	Tue, 11 Nov 2025 23:16:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cUMYaiT1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6412483AB4; Tue, 11 Nov 2025 23:16:37 +0100 (CET)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4548783B8C
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 23:16:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-3c97709a4fbso85020fac.0
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 14:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762899394; x=1763504194; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pEZ4Ycix8Qx8H6C6YJE8ME2XMdFLamVMbHOm1xrEU4A=;
 b=cUMYaiT1NPhrmr4NEtrjG7TKB2u8yMa7qQvKOPmVmFXXqvyzqUvP7Zvz3gALqiHkYW
 GQ94vwIiJgiTl5R88flPjsfx+1IflW/MF2J91fWskVmLo0cS7SGn/Z42CVWmU3YlFKzw
 VGgtqKoQB/7HjGj9vK5oQY17UuNCiSGc+dJkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762899394; x=1763504194;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pEZ4Ycix8Qx8H6C6YJE8ME2XMdFLamVMbHOm1xrEU4A=;
 b=HMmj8EDT0IJrtVxJuTTyAGqHUJr5RMp3R5L22eg270bkfx/xR62eN4/wmVna71udaW
 Gaeno+AoLZHC6zca2efJdakMUXVEP2z5huvzkvAWL/aieKO02KCLPsT+fiw2iKNkAQJp
 uZJKDIo1K5zNvKbAWJEb9hQ1SQVywffBzyUKHzDBTrIl9id+TnjLjEz1QK5gZ9D6N4NA
 h7fwaNOdkeJlfUT5JQoXAN0aJx+tLk8Y789mnEhrpkVclWZosSypMqKLSnzikG71mpZN
 mrv8lRhDQSVHrtOfCuFTn8EVIeNTKq5bUiprWity6h4fem4Hir5k2MJMjy8dmtnoKAaH
 3OgA==
X-Gm-Message-State: AOJu0YyWYPl/HrSThG/WWldJI1LzhKz9BPOyfV8s1hqDJyuHN1fdaH41
 qlx5k+yXHYZjzzw/NLL3KzXaLTNb1D4EZBkS+VQP6NSEBYVYMuHGjmVYVs4Y/Wr2AQk=
X-Gm-Gg: ASbGncve6gk+F179SeK/3FAzh7UxmLGVIv407faXI3CHJ0sZCq1doBbwoISA1bz3Ncf
 7EWzvFDqfgc4L0Jl1TI1ghvvfxvjn7Pdq3phrxuMGDGgKjkeVzlRSkJ9a4jltxg3otU2yXvyLvO
 2A+7KD/aBzlGrRCLZW/uyKKjQuVnb9vJ/WfkPoupH4jiMMqN5o8dcs4sU2/yKgUFbkSh7FCinY+
 Xv6W0c61LBM3GlDQ7POXeKI7zPSOLKwVv0w0eFt7BDEHXsyJRBMDHEbWo2Gq9qZIGSSnJRdHabP
 tT4NsCsLwsZ6IQ0D7lN/l+cuZj+U7Ai/yzF2gnQPDpOo1dbL2ueicfcQVk0xrPOwX6r6qAhQYc5
 B4T7NflJ1gFmPQLEEbozmeYgYh0o/nyxI6a12CP9pTiLSlQmJ34+MtOUC6ZMCgehvchbqEF4s9y
 2uT15EIRyt4r6Tc3A8nVB+I3ivHGYSyOSK9teLiEHDbjg5oDxUukgOhJqT9YE=
X-Google-Smtp-Source: AGHT+IEppffCMndZJSJrHtJjM8oq1GqGtlbu5MzqhYyFNrdQyyB9GTXTzAKDAVO4t4lR3SsiRt0p2Q==
X-Received: by 2002:a05:6808:4497:b0:44d:b7e9:2067 with SMTP id
 5614622812f47-45074626febmr385674b6e.65.1762899394013; 
 Tue, 11 Nov 2025 14:16:34 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4500253ce65sm7448872b6e.5.2025.11.11.14.16.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 14:16:33 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Rasmus Villemoes <ravi@prevas.dk>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20251104174458.3385564-1-ravi@prevas.dk>
References: <20251104174458.3385564-1-ravi@prevas.dk>
Subject: Re: [PATCH v3 0/3] reenable dm_gpio tests, add support for
 gpio-line-names lookup
Message-Id: <176289939326.812914.8693428012068189486.b4-ty@konsulko.com>
Date: Tue, 11 Nov 2025 16:16:33 -0600
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

On Tue, 04 Nov 2025 18:44:55 +0100, Rasmus Villemoes wrote:

> Hopefully third time's the charm.
> 
> I merely wanted to add support (mostly for use by the 'gpio' shell
> command) for looking up a gpio via the gpio-line-names DT property. We
> already have a "gpio_request_by_line_name()", but cmd/gpio.c does a
> separate "lookup + request", so it felt more natural to teach the
> lookup machinery this as well. That ran into
> OF_CONTROL-but-not-OF_LIBFDT being a thing for SPL, so here's yet
> another attempt.
> 
> [...]

Applied to u-boot/next, thanks!

[1/3] test: gpio: include in build, and fixup bitrot
      commit: 23908d8f248f0aa912c7f05e276722e5caf4dc02
[2/3] gpio: search gpio-line-names property in dm_gpio_lookup_name
      commit: c92c3768b61aa84dd6adc214308d69814a8c0af0
[3/3] test: gpio: add test for gpio-line-names lookup
      commit: e5e4b60c55e448e6a9a6bf6f7e9cfd01fe3103e1
-- 
Tom


