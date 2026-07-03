Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E01C43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 20:32:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 654A684A76;
	Fri,  3 Jul 2026 22:32:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="T+NWM3Xd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C5E384A48; Fri,  3 Jul 2026 22:32:08 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3BB384A48
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 22:32:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-44865cf3010so597552fac.2
 for <u-boot@lists.denx.de>; Fri, 03 Jul 2026 13:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783110725; x=1783715525; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+yW2dyH2vgXyc7g8drDf9Fw4QRNFXThWB/eM13znzvw=;
 b=T+NWM3Xdhwe+ZnQYDsGv7mzRxRoREh1QaRZv8Zyx2jfj1LgEuhr+fNNsBhQnbcvJR6
 bYRfpAjPxOQM91uAQ2Qs6o22eRXvlUb7JGF7C9x0DeDS4X34Vk8jJowRWfvQ595HBg2T
 c86eCcoZE7OxDZ7zpcPQ5rjInt9wnqwJlyxQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783110725; x=1783715525;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+yW2dyH2vgXyc7g8drDf9Fw4QRNFXThWB/eM13znzvw=;
 b=JHk6BYS7KyJ9zUG2E6hLnxtFhTQhLSszLE/W4s+Ga3Ls8SHpvHVaUGgDOgvSecs4kj
 +ziH74PEK7WtPdkJlk+/84czBE4n57v0jR+/cHPX6c+7Oq3TsjVhs61ZA2I2Jt3qt/Id
 Cen9QFocnUDr6COYPqyv2VmQ3upZHVgM28PVLV1JMSONS+NlpXGO4zVt7pSbULf0uApG
 9j13/UlPwCg2AfG3dcWOH73gqvi1z70SAg1pjfof1ug7ZncGqODdGzFl0QJcmYv13oPZ
 o0vz13boG2uAOcKAlzwCmHGtb9LxN+ZCtEeAl/ioh8T0qBzfZ5ggg/E2evLautWpLFJ5
 i2dA==
X-Gm-Message-State: AOJu0YzwKKuf3ZQfnF1uZnGQ33hij8aNFameL0wryKzAoMYvYPSsqoHj
 +Ifg5L95waRGE6MdDJE0cy+0iMJ7VSCxcUOLxveFFZRdh2Bbe8WazJnni5xewt3Y61qbvqgxX8z
 5toekLdQ=
X-Gm-Gg: AfdE7cmVAttC69XB976twxk6nLjOCvM+X9anFjYCpnFM1lFkOtpGfyPNr08Ph/+CbdM
 MdoyB76UeQGZFMF4K9k6wJv2aZ/eaKMkHTaifVdv9xcJaw7Rb6CWeoPPa5RcVE5Qc4swKz5uESj
 gbRTcKEqDO3woxIemdBWtZpyrKWHMDVuSL5Iea2D+HNpcGR9FRGIICd3+9sZjCHYoDu3AXcLr70
 egY32OHtDu4uBJVB7dzYT4X+4WCo6pTziH61ucUCEH4EGxFRAkrgfKzy5jtwIbPqHvqtyxW3SUE
 didLeV8cZx9vUY+mErF0XsK8F5qkLq7i5zUfGw3wLOP6t4qRuvxIeANuNrJJiZCTL3brnlpS1P3
 fsSFBBcgyUc4gT/RQimatqv3Q6zL/pP1lK1vP2icXBlaUrpnap5noVqCnlYPAVT+tQK6GcRLYvX
 jTcAhAJuTKw4sXZ0JcMB59z7i/LopoAE10wbGyWTnhEuSATBnFh4fQKHCNugD2Yynv7SVmflasU
 7Q3ph10PSN8LMtDbgDVWxQC7v5xCA099NPP
X-Received: by 2002:a05:6870:d8d3:b0:43d:1ba2:4335 with SMTP id
 586e51a60fabf-44d18347631mr548570fac.26.1783110724722; 
 Fri, 03 Jul 2026 13:32:04 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb1bb17fsm2917874fac.5.2026.07.03.13.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 13:32:04 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, dmukhin@ford.com
Cc: sjg@chromium.org
In-Reply-To: <20260623220630.2828767-1-dmukhin@ford.com>
References: <20260623220630.2828767-1-dmukhin@ford.com>
Subject: Re: [PATCH v5 0/2] bootdev: few fixes for automatic boot
Message-Id: <178311072388.3138827.1069070795509510122.b4-ty@konsulko.com>
Date: Fri, 03 Jul 2026 14:32:03 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Tue, 23 Jun 2026 15:06:28 -0700, dmukhin@ford.com wrote:

> This series addresses few findings in bootdev code.
> 
> Patch 1 fix for automatic boots in case higher-priority bootdevs fail
>         to be hunted.
> 
> Patch 2 adds unit test for patch 1.
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] bootdev: scan boot devices at each priority level
      commit: 264ba13f14767fbe7a881d25167d305fa5d7f6b6
[2/2] test: bootdev: scan with a broken high-priority device
      commit: 93e9af685fefc454580dcf567b03c139a2fe8ebc
-- 
Tom


