Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 072FFC369D5
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 21:33:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42CF58209F;
	Thu, 24 Apr 2025 23:32:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eFLDpZeH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B622382075; Thu, 24 Apr 2025 23:32:44 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F6888082A
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 23:32:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3fe83c8cbdbso531669b6e.3
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 14:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745530361; x=1746135161; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dZUvRpVsvXTpYSoDOyTyvrhTtCdoFARTnHnj57zdL/E=;
 b=eFLDpZeHQPld0OSxilvmq5fGHOYXCbtDy1dRJ4UtMqfsiWNU2ilX9BAvK+Gy/rV2Dc
 eynZFjwFvPy99iKmA7gZozC8ej5JKEZvxoYFrYyIC/PjuyEVuTPY81gDDYk5uuT4UUQE
 ZrcPU1XZknpmSzLrVm4gDZpE7Vm0kqfo1o9oY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745530361; x=1746135161;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dZUvRpVsvXTpYSoDOyTyvrhTtCdoFARTnHnj57zdL/E=;
 b=k31m5vvU6pXhKtGg41sVChPLEgWcEJfHQ6+EK3LVKFv2SVckRG0swxD0rJO/5SYEKF
 kjLwm+9sNVh0hNaT37MWZKWlXWlXUXmZFXXLi3xTedi700pJ9JNqWfz04AfaxEJfpgpl
 EFFsHIuCDTVE/HqUYrAIGbrt57/sbVyUtpfjAbDSDvF9bzMcLmILAw17aX97Iz+wsvV+
 Svi1zbAISV47sBD086AuVlr9SEEAQSAILl7i0O2kn3MpU0GkcF/ihW6XhlhrbiO+j81L
 ySFyjvXeNcq/m1qiG5isD4jR75jufWFPY1IkNleXX9x43GO6+25s54lt+GkZGXHJOEzG
 ml5A==
X-Gm-Message-State: AOJu0Yx4DZcqCTw93QGIb7jtCoTCEAupUZ0q2Z4FOC9dxQfTHJYEg7rV
 OiDcGbpSfFyff9jeer6fa8V2kqppWW/wgdyZTvJOQncGRgg5rWgefXkrqQxEMqo=
X-Gm-Gg: ASbGncvjNA2rMfqKTl4T2T15yUR5XEe2CI7yHJbGIcosYhLYJCrCa/KIsi7Yt4Kz5J0
 5fLqMzm39Ua3aARNBaHVCT5qhOSiidLHJoIPjOsMNR5DwAeCn8kuCMqpfZaz57dwIT4iiYSe9Kx
 3HmbozIUXq89EVYLa2VmwKqfPKCS6lQI8YoRwGBO7oT1BwzP7uvAHZk1/QFe5UgBlaW0kYzZ92W
 EGBx64FKH4vuBQvX6Lu+pWmRm8dMu9acVjRniIqHLOxmwdMEjjtm/LTqTmMWtU8YwBTFIYnrrN/
 eN2TtNQevxM9ySp4t6hla9rFO/JltDMG3WG+cmt15zW7Lu0UbMUS6HVef1hsbaR9cJfIOaJq8eI
 5xJfv6R7SQ8o=
X-Google-Smtp-Source: AGHT+IG0sjeKXNNqGo4czQOoSVeUyAnIYdVIFK6V6righkHqSh6zdtAdiduiDhajA7fP/xsT1tQ+6g==
X-Received: by 2002:a05:6808:3385:b0:400:8252:a657 with SMTP id
 5614622812f47-401f116415fmr632353b6e.5.1745530361307; 
 Thu, 24 Apr 2025 14:32:41 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d97364d9b6sm489419fac.8.2025.04.24.14.32.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 14:32:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: vigneshr@ti.com, j-humphreys@ti.com, jm@ti.com, sjg@chromium.org, 
 s-k6@ti.com, n-francis@ti.com, rogerq@kernel.org, danishanwar@ti.com, 
 s-vadapalli@ti.com, Hrushikesh Salunke <h-salunke@ti.com>
Cc: u-boot@lists.denx.de, srk@ti.com
In-Reply-To: <20250416120830.138965-1-h-salunke@ti.com>
References: <20250416120830.138965-1-h-salunke@ti.com>
Subject: Re: [PATCH 0/3] Add PCIe support for TI AM64 SoC
Message-Id: <174553035979.4093791.9500970934788936190.b4-ty@konsulko.com>
Date: Thu, 24 Apr 2025 15:32:39 -0600
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

On Wed, 16 Apr 2025 17:38:27 +0530, Hrushikesh Salunke wrote:

> TI's AM64 SoC has a single instance of Cadence PCIe Controller. This
> series enables support for PCIe in AM64 SoC and to configure it in
> Root-Complex mode of operation.
> 
> This series is based on following commit in U-Boot next:
> f892a7f397a (origin/next) Revert "Merge patch series "pxe: Precursor series for supporting read_all() in extlinux / PXE""
> 
> [...]

Applied to u-boot/master, thanks!

[1/3] pci: pcie_cdns_ti: Include linux/sizes.h header
      commit: 29602a52903f34653081e6ecbaa4a5ab056409b9
[2/3] pci: pcie_cdns_ti: Enable PCIe root-complex mode in AM64 SoC
      commit: a478d0f05b20b96e0911d78ddf1751ba94e171fc
[3/3] configs: am64x_evm_a53_defconfig: Enable configs for PCIe support
      commit: f4baa55c5bee5a2eaedf80c8a84cc839230a9a73
-- 
Tom


