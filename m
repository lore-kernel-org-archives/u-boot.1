Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4CC3FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:43:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46189841F2;
	Sat, 25 Apr 2026 18:43:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="elLRf6Zg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A306C8428C; Sat, 25 Apr 2026 18:43:34 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EBA584011
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:43:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-8f0a87e23daso412620085a.1
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 09:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777135411; x=1777740211; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MtG76JD89sSjwsMSdx0odsY7RxM2u7Vg+HucjAuTiA8=;
 b=elLRf6ZgCwFhj4ThLen0tDCa7ZDj9a5/uceOo6nQMx0e/pivs86rZ3dACFTwPrrCAX
 CBjhEQwsZsmSOi+/SLjKtd6uriWXNq75al0eecDoBZMzuJdPLPS4Nl/Mig/46e0DLbQL
 nwtc/qvuqCRjiqdPL+LCT5RzrNUVjrdNEV+qA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777135411; x=1777740211;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MtG76JD89sSjwsMSdx0odsY7RxM2u7Vg+HucjAuTiA8=;
 b=X7uhkgBq6xeA+zHp9najAnjVBnVpi8/ZmC7yOmxfbxS8bumpxkj0XY+Lf/RjBykWI1
 J4+2bOFeFnwDzQqC/y8Bx/MHxLX4XwP087jZJBHW7zJAiIts4qOpsI6C+Scs6ZOKuwlt
 XrFlahXmqwVlD7w5aj5XCyiydMbJiAuiPcAc0oQH1Bdx/U4ZWzmz9PLcwC9oLBGjkjOq
 LJ+Kc54uDMVQg1p9o1luJuzf5TEQtEfcjsY0G6xKZQH72zQ7Yqs21myA2VYC02wXCPUC
 fwuMGVQ8Bik3rzN1yKMlq3X89HUeO9akZL6mYe4gc6ET1sE3w3o5QhYMXHc9cl+21ett
 Ft/A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+XtuujpoIouqHDh4GA/SwLAvI2MSA8NBm0BBYYNn5K4czmW9Arz4uY7StYz3X2AFF4IEDi0yQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyXPh5u/36ekFhYJIMOyzhx7qCgOfWHYw2AfSX5i/34VrJYGtg9
 oPx8bEbxunFeGVRyk2zOvrm+W7CVcQ8zu+cNCowDgri0Bdt1QvYdtBmrOtHbDQEo8xtcNsOWfEI
 d7Z4Wvi1T3w==
X-Gm-Gg: AeBDietrWl/jHPqV5293xgTcgViQPRwFnD1tELI1RxyxCaYSbmWIIgdwH5HKok28Nu4
 5VKN9tLYh2EC7G9JmlcrsQKJKL4DgME5htb+YSvCqYshOdYBOL8F3e6ZJP77A0IUD6he512+5bf
 ivfW8WHCiqAhKfY0w04FXEOSkpxY5Z0DCrpkJEGtf3ehOv0eHeDS5g2Kpn20dHDROOSH8r/aBZj
 LNtwxQKJ8AzADZUYuNPbhmyzcz5+QRMPtMcn3r6RyD4PZXJQgQcrYLt+jH4QMPly1V9ZrnEjksa
 kbbvZMb8sbuCPkH10t6fKU2tRYAMZfOpJH0DM+508/h7z8YMxTK8G5W995JnYGeLu0W59HY1ek+
 vzzdxDyKMyHMezoxnNf7eMv8AXKK+CwZ6xegnbPUGbYx0opz/d6uFeRbwCkcA5vl9CjT34OLN65
 JxmiNpkwh3t5IJrtE9V1cNwv9CSTqK1/dgIydi1hEfc8nGzR4s77OikM02bieqDmHM/BnTTcRSN
 pJ/yvRCFELFPPdEVE3A9mp7j54lD9gURWw0b7RdvLVPLvway3JT5UTytZUd
X-Received: by 2002:a05:6830:33e3:b0:7dc:cd0b:58ac with SMTP id
 46e09a7af769-7dccd0b6c4cmr9358382a34.9.1777056650260; 
 Fri, 24 Apr 2026 11:50:50 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc975034e7sm19832464a34.6.2026.04.24.11.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 11:50:49 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 Weijie Gao <weijie.gao@mediatek.com>
In-Reply-To: <20260415-lib-fix-supports_fw_loader-v1-1-3b27b4034981@baylibre.com>
References: <20260415-lib-fix-supports_fw_loader-v1-1-3b27b4034981@baylibre.com>
Subject: Re: [PATCH] lib/Kconfig: Fix SUPPORTS_FW_LOADER option
Message-Id: <177705664950.2527258.4446683339179876270.b4-ty@konsulko.com>
Date: Fri, 24 Apr 2026 12:50:49 -0600
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

On Wed, 15 Apr 2026 16:37:27 -0500, David Lechner wrote:

> Change the SUPPORTS_FW_LOADER option to be enabled by default.
> 
> This is a dependency-only option intended to be used like:
>     depends on SUPPORTS_FW_LOADER
> 
> Instead of having to always remember to do both:
>     depends on CMDLINE
>     depends on ENV_SUPPORT
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] lib/Kconfig: Fix SUPPORTS_FW_LOADER option
      commit: 2d0de938571ebde6bdce93b0c6272d8943011d95
-- 
Tom


