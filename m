Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA2E1CD98CE
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 13:48:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C89984717;
	Thu, 11 Jun 2026 15:48:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QhTaEhU0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8C5884704; Thu, 11 Jun 2026 15:48:30 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73D3B8466E
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 15:48:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7e6d14aaef8so3721516a34.3
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 06:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781185707; x=1781790507; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BUp936EiMPWXbUbQyi6OQYJ3q6afd2lDqbTxkDuPhus=;
 b=QhTaEhU05X5TfM88JaNry0ixaj8lgQ3IGwQEfKyHXpRYDr3/TlFUkD+913zrnrZ9PO
 ftQvlYVO+6rdd3MWFkP/WPGbU3qOR5BMEZPXcF6Sya8QRRhpKaQzUEevP7Ssv5m8vzGv
 WBRvdzuAqAJZ37vHtTLnGLRjC+08ce15B50Ug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781185707; x=1781790507;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BUp936EiMPWXbUbQyi6OQYJ3q6afd2lDqbTxkDuPhus=;
 b=H+HMoiLM9lgtxx7r2wg7biDnVw0NJs9eq87O8SqC6OwYF+0eO8xENjtLiYIEOpJpZ7
 PQWdj0REQfGammnUjz0awcdn2OGsBkgL8hIWehsJFwbsSO42028P7XToVGG6eILn6acg
 Oha4sP+K3kygtZbznrXdFKvBj8Cd0OFuqoliUci1XlSkgNwZhos8+XNHe+9T4ftmmrdc
 9KaOLjBYk/unSxJukJ8c3yLG/XhmmWZxLq8OueRsu+DlFzh7iEQ94e/2LwVUPhPytM9Q
 fgREVx1q0qf/wY2/VqMqQxfrdnmm4oLEOnw622Pkxwojns+KQlTO1VikLQAbEUyxkHnV
 uqPA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9sqkxUF6aaPCzslTjrMJI6KXJj4N1A1HtgdHq+dBtJZq1TFPDKUJV49SGdxuoQSaMhYBKTPQ4=@lists.denx.de
X-Gm-Message-State: AOJu0Yx8GtkimRBU0y77QymeGIOAvd5cLpm733NdJJf8S3LpIXxCaHFz
 r6aDerkq/572z3pCvBpVwblHtFiAYFNdPo160c0+nyl9GjONxWzj50BpAXd+vm34RVE=
X-Gm-Gg: Acq92OHhuC+TPKpEe48Z1otV+hi/XFyaqdlBzxjAtQaGCpuaKpCMmMEEhXOHxG9MuZw
 UFfj4XiN6Dhzq7TngNeYjffL+SN+pKbLxSA6kOG6A6UgcqjJi5Y5B8NdYazuq0k4pGOCePLj0lc
 XXWCmufaRvut3q4K0Y3iQA6npDEKCI5VfJopNxAprqQ2tTv/n3AHUuXFxcxaHrIvAhXfUv+TL0Y
 EGxBZKpEz60LDmaNoxHfJLdjWNyKSLrX1VLSDbq1XhDKB3GAXjS4+GDqj0Z5I9++qLxzVNfeUdl
 Qumvbe84PCvIlWu+oUrjJeCZT5OisA+FudUGGWKWp8kHSaWGairCoOeW31sJvTQXF1+uWn47+V0
 mQsmAPr5h4PWzE0HSXccHTslFnOpnRGlyVeGw4rmCI0zj6Nv7Dfk6NWDxD78MLpVC2Ah0cGAvog
 jhKWrNpjH82D3C/wgCnO97mCbbTBFjTLcZQMyO+1iNMgiZGR2wozWmjhhHJmVc8j8B7kC9/Vo2d
 CeiztdTUtoCVP6pG0QQsO7TJ8SpYEFPNn3ph6jQGZY4PHE1UMCFKkVIeQ==
X-Received: by 2002:a05:6830:6187:b0:7d7:fb03:f6ba with SMTP id
 46e09a7af769-7e77356bd35mr2116397a34.21.1781185707124; 
 Thu, 11 Jun 2026 06:48:27 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-245.totalplay.net.
 [189.203.97.245]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e774988094sm1368249a34.1.2026.06.11.06.48.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 06:48:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@oss.nxp.com>, 
 =?utf-8?q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>
In-Reply-To: <20260528134919.10031-1-ghidoliemanuele@gmail.com>
References: <20260528134919.10031-1-ghidoliemanuele@gmail.com>
Subject: Re: [PATCH v1] serial: lpuart: Fix RX FIFO Enable bitmask
Message-Id: <178118570640.472730.5630937898780467690.b4-ty@konsulko.com>
Date: Thu, 11 Jun 2026 07:48:26 -0600
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

On Thu, 28 May 2026 15:49:06 +0200, Emanuele Ghidoli wrote:

> The Receive FIFO Enable (RXFE) field in the LPUART FIFO register is
> bit 3 on all supported architectures. The define has been wrong since
> it was introduced: for non-i.MX8/i.MXRT it set bit 6, which on LS102xA
> is read-only-as-zero, so the bug went unnoticed.
> 
> NXP confirmed bit 3 is correct everywhere, so drop the ARCH-based
> selection.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] serial: lpuart: Fix RX FIFO Enable bitmask
      commit: e65a87e959166e250a486b67ca23270272741643
-- 
Tom


