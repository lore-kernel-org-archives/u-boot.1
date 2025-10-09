Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA2C8CCD184
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 14:20:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F58584552;
	Thu,  9 Oct 2025 16:19:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uQvGCqYt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86F3A84531; Thu,  9 Oct 2025 16:18:59 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79DA384528
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 16:18:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7bc147fd11bso748751a34.3
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 07:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760019536; x=1760624336; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JHPpnlkD5XW4bGuZvpUsWpSNVgnRG9fG3i7+KLw+Zuk=;
 b=uQvGCqYtichgJA0EzaCyfdjxroxaHCbdR+gMx5iN+JC5esLNo6jnJ00aw1/HueTepg
 n7n7kpYO+xOqtqpYngo+tt65IYxqP/fTnMx2EvyNhGzbHEpBk4Botk4zygM4ufLdRWD9
 0vHPNwMjDd56KZ84FnptmmobT09bqp9AnfAJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760019536; x=1760624336;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JHPpnlkD5XW4bGuZvpUsWpSNVgnRG9fG3i7+KLw+Zuk=;
 b=mI7L1FwyobvfG6VQJQWfXFMTR+wovYvUzR1WzWjWa2e6ZbEWZz+nJdbLnUeQzGQdL7
 5PODIgQ+kpPN8ehNmyj4zFIK9BgTWrzNjMEwbHGRP9O0cys/mKno5tgI+3rp6kbmS5n/
 lAENV25E+gLtD/82xFfXf2gf4wX3BIZ5A0OnJCgXzCLTCBAm4QlAO+qqwBX3qJmlVqr3
 1VqtTCE9qWchqhaNzMJJCXieMcBp6vbvLgBlLtPztUF4sLp9HBhIl0RHKYu1/4IGA/CY
 D1TjvbcKHVS02DXXSHPCGwR5XXqCrPQvaNJuyA0h2b+Z6TjNcll5LFACxo6OjA5ROud4
 Ud2w==
X-Gm-Message-State: AOJu0YxtU1Q13SC3sTZlUTFFHoJYIFwk+L9QV/znqWkOOfq/svblfZ2M
 80iKq7Z3LrL2TCBZ3DRFgK5surLfRs/Qgydl8cNybybv1Dtx6PM0XgoXp4Mfk3JdynXfbJ/hQhu
 PoTamHb8=
X-Gm-Gg: ASbGncvAVSdSSrVHaXIDM56/zqNfTdpVlC88H/0s1xXtz8YvekKzF/J5WheNvmuIFO6
 Ie9R6FCRDrHb7edV080cY4ENci7SLbx4eNDzWig3KEv535U4pE0ZA5GL8oPdM7Qitz1LF5I4gQA
 /nHn8/UkCm8P5S6N5OCO27IIXYDluTOvEdAmtE/f05/4Vw7HJm2LRYDcvOBoDgBTEs7TYPLz7zX
 OhoUTVwcjTd5MDdhWS8ygOidKxh+ZGZ7YJtW7hCa+YidhWBEf/wGhq68KM4pUE6LPSnfzYitTXC
 mSuas/Vm6xxf1jDKXplydMrvWrfeQN34kRYdVLaerpWBEZAbGGZrPcd0C1Tb5Mdlq9uotD2WQhK
 eQh/sl+/gC+5EtAcblZWkLBJI8ljAPzreGKJNbWtAVInsxn9qMBoU4EtCkptvqi1dSjTVtdpHwh
 rkP2mZNdSu
X-Google-Smtp-Source: AGHT+IFFk+pciShb42nNakIuHaRk/PjEWb807HwIzEtFdip7a8krt/YbOvAIdEWBWkPI2TpTHUXb9Q==
X-Received: by 2002:a05:6830:3741:b0:78a:8b0d:cd29 with SMTP id
 46e09a7af769-7c0df706b70mr4645449a34.13.1760019536244; 
 Thu, 09 Oct 2025 07:18:56 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c0e333b875sm1221258a34.17.2025.10.09.07.18.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 07:18:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250925205132.3561964-1-trini@konsulko.com>
References: <20250925205132.3561964-1-trini@konsulko.com>
Subject: Re: [PATCH] cmd: Update dependencies on CMD_IRQ
Message-Id: <176001953543.3159859.11089896257527459167.b4-ty@konsulko.com>
Date: Thu, 09 Oct 2025 08:18:55 -0600
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

On Thu, 25 Sep 2025 14:51:32 -0600, Tom Rini wrote:

> For CMD_IRQ to function, we need enable/disable_interrupt functions as
> well as do_irqinfo functions to be defined. Only NIOS2, PowerPC and X86
> implement the latter, so correct dependencies to be opt-in not out-out
> here.
> 
> 

Applied to u-boot/master, thanks!

[1/1] cmd: Update dependencies on CMD_IRQ
      commit: 9d42a06019178ccd0fff37864ff09c2335c68308
-- 
Tom


