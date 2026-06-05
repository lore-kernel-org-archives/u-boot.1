Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06508CD6E7B
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 17:32:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73729849AC;
	Fri,  5 Jun 2026 19:32:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SdzbhLz5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3423B849AE; Fri,  5 Jun 2026 19:32:51 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D549984995
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 19:32:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-486621f0adbso1629513b6e.2
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 10:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780680767; x=1781285567; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NFqTQMDH6SW1QWAe9f3x7xbuhhW4OnxonBIJ857c7xI=;
 b=SdzbhLz5rL/ScmW9FLXiLUFfl+9gXOyPNxRPRw89211ycFV0YyeAy7XjIB2fJbe34q
 taQV7ONe+GOA03WrtN28uZ1dinLXE3vc+00TNnWc1dNlfgw0SpedSkm7+RP5+Zz11Xs3
 sGMoSMTbamkj1FKbjxapAtsc1A8kEyNiLFX5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780680767; x=1781285567;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NFqTQMDH6SW1QWAe9f3x7xbuhhW4OnxonBIJ857c7xI=;
 b=Z4BqJuJfPhrwfYpeYqbDWZJe6ShU3ufgacfEN2fYGlT04Os1q1thrOqyIG9d8NWfvK
 EjYjhpbn3eCV+/H7BCAzTGOT7dg9gcow89PoRV9LGdVu8ZPFrh+o1sVuGslCdybk1a4Q
 BEOv0gsEl4nV9/41B+5sDZP1Ue3srzSoZ75E94e/sYoMzv/2+lWnr25Vhse1KloxS0ik
 6I0K/S4c6v774nBtY58Tr3C5SnAKYweUN0KJ15CqYr5oHBwfPgeejfFIypkKNeBpOq5F
 Ki+55aqS2upE3JFsGza+AWlIm31/Wc68SJ7LEXBHfil40kUZi6iGCUa7vBAFG3IfmJfk
 qk6Q==
X-Gm-Message-State: AOJu0YyevG+1jFombDRpQEeA9SQwpGtlGgkzyHIcSOxUG1sNnfegFzQQ
 u8VxJM7kLVX/Rhemfw/hNn0pPru+JPNniOAyAOvTlAGIP2HcLujlTCvzSsrobDctldHU+pU6x49
 b0o+9sOw=
X-Gm-Gg: Acq92OFtIY1la7hjcjA0kuT1pWUOw4IVZ7O/OGaNkM8bqPoBKpjOi0LEX1WH9q3voTB
 kZ4MpFPMy0Ndt6R55LR8ti+FNpCMF/JQ5LT++dw/O7R88XAXE6o6cO35iK7QVGCdtXPuDsbmbBd
 dYwDG+iov/ziCT0j6lqaLYKbEtfP7ip/d1IP6mwdCwGNQ0daMUMnx1L0brmU0BpvTLTtdZH1rvb
 RXCEdUzU4YeuP4FR5QXMHy8cDq7s/5EpAkFBm9rHGC3FEFUp9lY6IxYE36em1D2TB547k32G3PY
 41vH8pVwmZcoCwbwjY/lN6o1toCeCSh+V6nrAeWjEemI7DcwXGtOOEiRJ0QPUUpvffXdG6Lm5rp
 cJE++yYQly7sS0m1ssD1OF30l9acxuOK/MqOXi7mjyBHy/bPisRW5VV1aJX5YeBrZlNgPP0YO5C
 GUC1aIwAukAWiKcKW6gqYUNwbYStPY3eERMOKBwXuoXOePyPq8nw4O0UTcYBtTc8B0qntVSk9Xh
 05B/HkRv3Ppp5oBdK/1iWdryRXBvCSULEMvACn+wv/zU2ih+xj6RrQHfTAB
X-Received: by 2002:a05:6808:2388:b0:485:48da:132e with SMTP id
 5614622812f47-4868def1ee7mr2682604b6e.27.1780680767587; 
 Fri, 05 Jun 2026 10:32:47 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4865b5a5a64sm7286692b6e.4.2026.06.05.10.32.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 10:32:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20260605000930.542278-1-festevam@gmail.com>
References: <20260605000930.542278-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20260604
Message-Id: <178068076701.381423.1292884578088564736.b4-ty@konsulko.com>
Date: Fri, 05 Jun 2026 11:32:47 -0600
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

On Thu, 4 Jun 2026 21:09:30 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/master, thanks.
> 
> The following changes since commit 74007f24a3aca13b70da6a2c098b830ad9e60804:
> 
>   Merge tag 'u-boot-nvme-fixes-20260604' of https://source.denx.de/u-boot/custodians/u-boot-ufs (2026-06-04 10:06:42 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


