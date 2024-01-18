Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64036C4707B
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 14:05:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56EAB87B5F;
	Thu, 18 Jan 2024 15:05:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cbVKvlSK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2A1D87B9C; Thu, 18 Jan 2024 15:05:17 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE1C387835
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 15:05:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-42a12b8db9eso9685661cf.1
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 06:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705586713; x=1706191513; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1OLMHilkZMeIJiEsDuAzXZV9UXOdvRICpng6BbVlwtc=;
 b=cbVKvlSKAaC/J34dzXUgO4fTF6y4eGmhseHqLwuziHdAdWMQH5gipCr+6GcwUTbqTW
 0tPtSSfIZnrdw9lsYtA4KUcHhIW+Kxzs815dpsBj81v1cJNEx1/0+y/KV35xITVxJ3qP
 OI6YX3vh19IaHZE4+9EBgQVqPPaSQ3g9Oy9Aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705586713; x=1706191513;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1OLMHilkZMeIJiEsDuAzXZV9UXOdvRICpng6BbVlwtc=;
 b=OCVu7GKcfX5wzYQsl4LLlxX1Zrc0gHUpa40u0DctCvoESWqQXfdljAsdFNAdcp7ujm
 4r37m8FPEWMD+GxGPoFNmwZd3bdddRjxFqzxqnq+mJ3XckgguAE3gkgB0KEbzppivD9l
 C17zXv5mwSC4GyBEEyWFdmDDiCMZr+mo6oKWqJ81S+Vc+k88Dn1fR2qYNDkCmcGKqT6V
 EIpz87tuEyqbvNd9r7jZtqqM4JFLhiI5DOjypWwNy5a6NNVCfuMHY/b4XSV5zpOKm57Q
 FQJcVLyLxvwJjERDDPpP7NZ750ErcI0pbm57CfmCWO9qy2VMwXszh0qtD4W39poUYwWk
 NdAg==
X-Gm-Message-State: AOJu0YyqVI2aggXWc+EC0fAw+Avsg0YEoZCN6WwriYM9xbUcWlxebGv3
 lCEaHO1ICXALDb+QhkQSULccOmL5eXZI/YTeHUlTo7D3s3eHEM9opBwAOySgJco=
X-Google-Smtp-Source: AGHT+IHVppfkC21CTOQijaIpDme7OZbdDiiDogyvqJW6lu4He25oUGpHTDQOyZ93PCFIPZdwxBTdcA==
X-Received: by 2002:a05:6214:301d:b0:681:8bb5:a30d with SMTP id
 ke29-20020a056214301d00b006818bb5a30dmr634660qvb.28.1705586713566; 
 Thu, 18 Jan 2024 06:05:13 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 mm21-20020a0562145e9500b006817fd532absm1246316qvb.82.2024.01.18.06.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 06:05:13 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Alexey Brodkin <Alexey.Brodkin@synopsys.com>, u-boot@lists.denx.de
In-Reply-To: <20240112021757.8719-1-heinrich.schuchardt@canonical.com>
References: <20240112021757.8719-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] docker: build QEMU v8.2.0
Message-Id: <170558671299.2400148.409081470004415672.b4-ty@konsulko.com>
Date: Thu, 18 Jan 2024 09:05:12 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

On Fri, 12 Jan 2024 03:17:57 +0100, Heinrich Schuchardt wrote:

> ACPI support for RISC-V requires a recent QEMU.
> 
> Upgrade the used QEMU to v8.2.0.
> 
> QEMU commit 0c7ffc977195 ("hw/net: cadence_gem: Fix MDIO_OP_xxx values")
> is needed to fix the Ethernet PHY driver used by the emulated SiFive
> Unleashed Board emulation.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


