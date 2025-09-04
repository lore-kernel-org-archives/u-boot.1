Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02CFBCA1002
	for <u-boot@archiver.kernel.org>; Thu,  4 Sep 2025 09:57:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A09EE83829;
	Thu,  4 Sep 2025 11:57:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qJ/+MC5e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E05C83A7A; Thu,  4 Sep 2025 11:57:36 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17FBE83A7A
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 11:57:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3d3ff4a4d6fso670885f8f.0
 for <u-boot@lists.denx.de>; Thu, 04 Sep 2025 02:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756979853; x=1757584653; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G2UswoCgddvlGcR9+Xfr5ukOpj5bLKzFXFzWUra3lT0=;
 b=qJ/+MC5esv9+faMNksFPm4pJItJglifTexpvNHgBwispH0jFtHaHsplvlXrVnHw/NY
 PIwiW/Fq56IyCuHobgIilRb93QA4Cos6JfnHv+Di2lh3x5cS3WK/MNb0YdDZ/sLzqyES
 /vU7+ybP/0Pk6+0VldMWDN9hPd5tiLgW+20rHKJ+UhQV6TKvH27EI0ZcfU2FDfafBJYl
 iZHBIF5Kc1ItWi98ehjQmIzPczTC7Whi6b7Jq2X3djqcxZgz1t4AHj0lTVVYFNM5bZ4c
 dsbhK+zuV0sNV/u33Qad5ggLeMCqfmFRjHNLS2V80a7Z2CaKZquP+rWcRVJEBYNPDVjG
 E/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756979853; x=1757584653;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G2UswoCgddvlGcR9+Xfr5ukOpj5bLKzFXFzWUra3lT0=;
 b=FJF7WPWaH6a+zFO2IQ3noIS3j4PbEwRZB/l9cAZ/rFZh3X3MhT1yDx1Uc4by9EnRGC
 pdde/rafKbm1hONIA/kuS1yGzvHWrjAtAi49DzpdkrkxvtNcWfFub/wPpladye4X/Vax
 V9DfpYCiUzYC+J16bGAxyEfqnRDuZM+uFdRs4kslHsEQ9SY1rinVEQ2UtddnNjt7azxn
 EEaLinQzrUsEgaUhmKlcsCd0MJaQH0e7Oc++TloFce8dKFK8PytKRNRxk8wejxO8CN4x
 XaLVFG7G7N+XyN9COeUZzfhr6MAlKf1DGlDn60/yE9kG74UH7RHP68LCS2m1N+6td34O
 c7bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSK0mpLMIH9anfaDJY0LlqoPttBkIgSd6hzKcY6ewmmg9NqWeMW7z9vxFt9/nrvKg6jWLso70=@lists.denx.de
X-Gm-Message-State: AOJu0YzOT2hjIOesVeONkLQuDah72ykZy2yNM92G3hASN7iT7FIemRCS
 i4aqeNgxNltgr33oonwpJtTDzwRSUeEwCCY7v6KBI0yHKW0SeJYpSFJQB1lDDGVnG70=
X-Gm-Gg: ASbGncuk/Ud81wNylbJqpIz7NxfX+qQgCDNjBM7osci5dia6q83dLMGMZNFP6LmTcrz
 QUAkuQgcgqP8kfnKqcmYvDGLQjQ4xfuqifXvkiPcjXJpmUU3M2/Lv1VhTYcWYHQRGSa55MVsyoc
 +JdktW0B+xE8MiD03c6Xl3hTRRe1M21rWJVmfJwtmJIezZVCTjSR/Wz0jm9IOasRPCZIwmio9A5
 OYG+d2gkbP1Fx5s6GHhKWF5SsaCcugCGeDWBYemA/CWct0mhbytCsTOVzgHVCe0lzOtJ77dlScA
 Pk2BiufZMPUoQrzMKkVSHCIqlFrCM+S+gvIusTrt6USBQVuZGXQDicWn6eq1G3GIj1YyrB6SJVk
 LXGSR9awo9wWtbDITXsv78uRXwCuWOw5RE3JVOyr4JPnwFa6moGpdng==
X-Google-Smtp-Source: AGHT+IHPEY54lbfVYVFgJjUQFyGmOaplufleuH58d+hZfQ1VzD4iDODmJ8BUOIvxwiUdhj1jqC2E6Q==
X-Received: by 2002:a05:6000:2185:b0:3d1:e1b1:9645 with SMTP id
 ffacd0b85a97d-3d1e1b19cd7mr12386791f8f.43.1756979853412; 
 Thu, 04 Sep 2025 02:57:33 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f0c6b99sm359057585e9.4.2025.09.04.02.57.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 02:57:33 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Tom Rini <trini@konsulko.com>, Beniamino Galvani <b.galvani@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Yang Xiwen <forbidden405@outlook.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
In-Reply-To: <20250617-meson_ppinctrl-v3-1-218d9321a8d2@outlook.com>
References: <20250617-meson_ppinctrl-v3-1-218d9321a8d2@outlook.com>
Subject: Re: [PATCH v3] pinctrl: meson: support gpio toggle command
Message-Id: <175697985281.2904655.15316444778435911414.b4-ty@linaro.org>
Date: Thu, 04 Sep 2025 11:57:32 +0200
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

Hi,

On Tue, 17 Jun 2025 01:01:17 +0800, Yang Xiwen wrote:
> meson_gpio_get() always assumes gpio is configured to input mode. This
> is incorrect and breaks `gpio toggle` command:
> 
> gpio: pin aobus-banks2 (gpio 2) value is 0
>    Warning: value of pin is still 1
> 
> Fix it by adding the logic to handle both input and output mode.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic-next)

[1/1] pinctrl: meson: support gpio toggle command
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/879cde9383621ea05f73d1103e4e0eaa8346a562

-- 
Neil

