Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86829CCD1BF
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 19:55:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD778838D2;
	Fri, 24 Oct 2025 21:55:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WDEsB+O7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7406D838CC; Fri, 24 Oct 2025 21:55:14 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C70E83677
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 21:55:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-64e5f669511so1278584eaf.2
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 12:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761335711; x=1761940511; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sHwhZ6g3EbxCfOsU+6ay0jxDz06kRTuvkGBcQVNJz8o=;
 b=WDEsB+O7VKcPUrARE/V4uLmac92/LZUfmKIzXYPqOg34VQbXCzOMzH9EkSlPuHQ6T3
 1slTyCDY21LCmgyLptF3gspACzNSaY24LIqFYDd6YHXDYRNg2EWmd2Skvk/AAWjQPyRN
 cpKhFaSoMhVMaV77hy4222IzUeADLWts8bhIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761335711; x=1761940511;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sHwhZ6g3EbxCfOsU+6ay0jxDz06kRTuvkGBcQVNJz8o=;
 b=DRqzKZWF7y2MnHUBzKlHVHmabj1QJ+dRRtm3Cci9lbXZTXBULZciZ+/xJUmpF+o0Do
 VJ4ez+XdRzFaVeKSGiMasNsqyLlhc30zeW+7xE3JhmSn9FVVcFRTU62IKrMAUzSMT/FP
 M0sGX5jrpDxYtAbmUSc7KAggNrx0sXfm+N6xzfHQaWMLhE3a69Ow9Xe4xpOxnNB/wos3
 6IKs2laIPgCh879as3gYE3WXXmYLt7FU1r6ShlDpCvXze7i7HTCDvq/6lb3psdLRhRxM
 UokVhcCWS5dsQJZGT/ZnOy4t0OogZlHNy59+mxER+vqwnRtk0MCu9gqLZ6gPz2yfGP30
 FO8Q==
X-Gm-Message-State: AOJu0YwvDepiywmU1Y9BR7njQWl+PgZuVKvJWvISQN97kYjXn9EUYBbH
 PXBYe8WWjtaZeKzwQFg97z8DQ+C9cfvyS9VK7yMx4UZpXVG179BreOi/6W/0gv12f7s=
X-Gm-Gg: ASbGncvaXIsvtNTY/VseWOHZ+HkNarqgzXsx0rxJ1VKLuhaECg8K+chJ4lcvWvPV6yG
 fJcyKUjzUzH13fbSzxbbvB7Ghf+isFJNYVkLIH5x4PM9jJN+9J9sj37wdhTY6lcEyKAwzigZQBB
 JBg5tXkKy+E92/WAdrOLzsSeccBlETRJgxSugCPE4iM2akT+nvaj5TNYAby4Mx9vUrpRyotsYDR
 Re1O/58wrkr4d2uF6Jqkf+VRvUQX3A2OqAPT1kMXOn+HTEYJiwZGaN+92atDqGmuDx/HzNRw9iC
 bxxj8A0TFdUaG1OjVmTRfEZuzxnt9NxKaSFb8UzyMY2IczbCltnMKwC7LbzOlXQWPUWDmuUBsUJ
 F1rsYXClRf9gkT/D0J/n0hi/CEeORKaWnZ7ns9fRaQGsAuQcN3epvgP3PNHx3A0nazaFpHfasqd
 lGrSEQxqQbWk3xbTq3kbdihwYo8l179Rn5pHTUpiEvGr3R2uhn
X-Google-Smtp-Source: AGHT+IEeeMcSRV2WqzvrN4uU0wpFkd/oX+umiAL+6re77DCSkSHjlkR9gqk0vljOplpMSQl5ysjHdQ==
X-Received: by 2002:a05:6820:2019:b0:64e:ad23:bfa2 with SMTP id
 006d021491bc7-654e1dbdfd3mr1585149eaf.3.1761335711120; 
 Fri, 24 Oct 2025 12:55:11 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-654ef2eff7fsm10013eaf.17.2025.10.24.12.55.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 12:55:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: andrew.goodbody@linaro.org, Hrushikesh Salunke <h-salunke@ti.com>
Cc: u-boot@lists.denx.de, s-vadapalli@ti.com, danishanwar@ti.com
In-Reply-To: <20251017052519.2632922-1-h-salunke@ti.com>
References: <20251017052519.2632922-1-h-salunke@ti.com>
Subject: Re: [PATCH] phy: ti: phy-j721e-wiz: Allow reinitialization when
 SERDES is pre-configured
Message-Id: <176133571008.2586772.8968664889545193557.b4-ty@konsulko.com>
Date: Fri, 24 Oct 2025 13:55:10 -0600
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

On Fri, 17 Oct 2025 10:55:19 +0530, Hrushikesh Salunke wrote:

> Move the SERDES configuration check after clock and reset initialization
> and change it from a hard failure to a skip of WIZ initialization. This
> allows the driver to probe successfully when the SERDES has been
> pre-configured by a previous boot stage (e.g., ROM or SPL).
> 
> This approach aligns with how the Linux kernel handles pre-configured
> SERDES, where the driver gracefully skips reinitialization rather than
> failing to probe.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] phy: ti: phy-j721e-wiz: Allow reinitialization when SERDES is pre-configured
      commit: 8506cf58ffa2029f168cc64089763084b408051d
-- 
Tom


