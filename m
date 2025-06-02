Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D59BC5B549
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 22:38:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6E1680F9C;
	Tue,  3 Jun 2025 00:38:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eEbb+MBZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44244810EB; Tue,  3 Jun 2025 00:38:21 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AFAB80F0E
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 00:38:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-735b2699d5dso2623486a34.0
 for <u-boot@lists.denx.de>; Mon, 02 Jun 2025 15:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748903898; x=1749508698; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9v/EABmZl1N5dRyKNJEJIorpuCX2nfqiTJVOIhpo2Kw=;
 b=eEbb+MBZp5zcaGy1/RHhSD5favgUAA53a2lv5ajQA3gg7pxaRAa2DqE7Ehi4xM9UQ4
 5bySAk1U84YDYJacQXyp7Ezx4wDlXL9T0zB+l8r1nsTURaH9aCFn2umNjA8gCKVcCehM
 xt/O+DMzCVVHbZ6GoHi3kZmc/n7gmxcr3p/mQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748903898; x=1749508698;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9v/EABmZl1N5dRyKNJEJIorpuCX2nfqiTJVOIhpo2Kw=;
 b=ZGxCyHYh7XOgI9SKYOikbwK5jPMzMXI0K9wgGpW51/4qHajwb/bvTF/LRJgn7prbzz
 9q/1ZSFSHNgF3R8I/Uc0V15vKLpW1dVHPHtKw2kziRpIubC2y7yYjfGEw/1x6ZO5mX0Y
 BTrIPX4/vFTNYE15GBUpBSefD2t6js0+vdxHpEcGIfnk4QrqH2OyEcamVyk6JeeyWsbf
 xKFlrySssnx9yvPNtj0jFr6CoDwwotzVsvzYE8/vaA6VQPZ/kdnpGc4i3rjjTWRPpP1M
 s2DFpp33LSlSsfYa4JavGR59cUiwKZPBVMbsFzSkJI+LepbGY/q5HuiPjhzTUlTm6+pF
 7MJQ==
X-Gm-Message-State: AOJu0Yywz1E2BktHZAsjE+YPfguDwb6l46sQO2ZOtseFd+JNiUVab1Pt
 Ybv3B2enGzWyaXnBV6y2fZyBo2IdxR3TK4eNJQxWRyfQhQN9Tl6DIpXtOJZuFouCiWs=
X-Gm-Gg: ASbGncvnAxrTGKgQHy7oRsF1RKR5ZL3BeahqCaGNpIdRUE7RCnAOQt98iw8EJyfUDrP
 qgAoGqAkPl37laH2XE7kvePsRMwdM9rvcvPweu61ufriynMQ2K9STrUKs+qltHNPtRlkTQmsOJG
 aqtGB2Ufn75N4ASEBXOu3SZeD2xLOPeWtJeNLnVsoiXr/5RBIYn0AlbU4+5V9mLlUc9eHDt7Lyz
 Bls7WfV6kQsNc8xbmRXZLgprSbCKHqMX0XgnxEukNv/Qe7AShzfqY9Den/hMUEp4w6M+l8Yb4t7
 ygYAJVL8Rd4bRzrBosm6QdvzSo8k236H3nouJXI6uCkXFK+NvPzPOJPmSQ/N8IHRJj7F/Yb2JUS
 ZiLbEKZpY7FrlSLhvyPfCYA==
X-Google-Smtp-Source: AGHT+IGI/hQjPSRFGqgQzgyG9q+7Q0VLX4IypT5jZ1fFgji76S7urqQsYG97atYgGXv6+kqCItQweQ==
X-Received: by 2002:a05:6830:368a:b0:735:b29a:cac1 with SMTP id
 46e09a7af769-73758b8af88mr6536778a34.1.1748903897769; 
 Mon, 02 Jun 2025 15:38:17 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-735af9f3bc5sm1677631a34.63.2025.06.02.15.38.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 15:38:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Lukasz Majewski <lukma@denx.de>, Junhui Liu <junhui.liu@pigmoral.tech>
In-Reply-To: <87ldqamcqk.fsf@kernel.org>
References: <87ldqamcqk.fsf@kernel.org>
Subject: Re: [GIT PULL] Please pull u-boot-dfu-next-20250602 into next
Message-Id: <174890389684.1382550.12707390201312505395.b4-ty@konsulko.com>
Date: Mon, 02 Jun 2025 16:38:16 -0600
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

On Mon, 02 Jun 2025 16:36:51 +0200, Mattijs Korpershoek wrote:

> Please find the following developments for next:
> 
> Usb gadget:
> - dwc2: Fix incorrect ULPI_UTMI_SEL bit setting
> - dwc2: Fix HBstLen setting for external DMA mode
> - dwc2: Various refactors to get the code closer to Linux
> - dwc2: Support reset logic for v4.20a
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


