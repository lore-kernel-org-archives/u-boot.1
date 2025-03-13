Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470FCC282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 22:45:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEFD88193A;
	Thu, 13 Mar 2025 23:44:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rT/Tu+2T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6706181B5B; Thu, 13 Mar 2025 23:44:32 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A69880756
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 23:44:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7c089b2e239so162689185a.0
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 15:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741905869; x=1742510669; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wTRqIDJKmpbPSQIHDhrNdodBkXXRQD8+jFlyDDU2juY=;
 b=rT/Tu+2TgtaHmqj1JCB/iBHDJHeiYBylgZQ8pW0t7brk/p9RZjTSVw68uttS5+vPH/
 TmQAo15WCudzCXZVF6fiQv8sIIPlJxuuPd2qWEgRlELB5KffFbI/yXknx+t56HSX9fFH
 Ka/WY3BCAQVcqg+9cpqecc0lGmZyhT0yiA58Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741905869; x=1742510669;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wTRqIDJKmpbPSQIHDhrNdodBkXXRQD8+jFlyDDU2juY=;
 b=iwYwHUUf/d1P3bB6CRK+MYDq757us/7zGT5CFAuvy+4G5y1xx/FXGvs29pGr+hBKgB
 jh+djKVC0AtWy6uT0IPiBpqpn/OcqMbUhiAUFburH313jQ8pU/AjSexho6JynCSuBQZb
 KxwyrOnD28o8SKQDdHV9uIaDgwNwA8/xpF9VsebWCH4sPaNF5AeWYE/uD0LWkuf9MR0O
 QSkUKH4d8CJHVQN7EKl+1GYrQtisGLxwCHz4Hhiv3vCsLLOWmnwgPQpfqOB7LRlLE7cZ
 hC11AV7wUO0zZb+Gh/VbsbEJO56T0LW6WVVZtHcpJ5uL+lpxTxNaSMyaLKqyUfgcm561
 1JIg==
X-Gm-Message-State: AOJu0Yx28euEDh2iUUQVg7QXCAi60JrJeCaqtJBDo28GGdPxrs0YVNor
 nS10cFUy4qSjgeTAtAin6tQJq01PtuRW1vVfT9jGEopGkvcPDXVzw+TgRn+bL9YerBFOPnId5Mj
 C
X-Gm-Gg: ASbGnctSXhaNee2Zj8vA3KH9DoZ/hsnnZj/0YHtSHuIe+HL6qTBl3mpCpbWF6RqMIUC
 FsTMpQd6tHA32Odii0V4j5NeeXhXP2lSrl4SL7MUzakMseeRr89nVluqnRogaegfTCsCWuaPPnO
 BZjY9y6lNVFRpHVrTJ8aALSRXr4Qomwe9ibLtJWLjZCaFzvgBZqqSr+TStXgB/dXIzfiz17/HXR
 /M8UHgJTLleRLabdblZXr0aY61gKGdRqzQoDul/1YK9e/oZF2S9RYxL+05TThloL59RI4EY2dzB
 Kcjc/S3n0qTYVyr4per5SdHuXNZHuvdSPv+MQRtbou8Dcvaoda+gFQI=
X-Google-Smtp-Source: AGHT+IFjC7mAmadZTDCfKZMGWc4zIxIQ7+vfQYzPKY/HQ0619pQ7gJQuqCBmgx1e0VuZ071SdgBBQw==
X-Received: by 2002:a05:620a:2181:b0:7c0:ad47:db3d with SMTP id
 af79cd13be357-7c57c6aadb8mr14550985a.21.1741905869249; 
 Thu, 13 Mar 2025 15:44:29 -0700 (PDT)
Received: from [127.0.1.1] ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573c98225sm154508585a.49.2025.03.13.15.44.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 15:44:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250228100434.56442-1-paul.barker.ct@bp.renesas.com>
References: <20250228100434.56442-1-paul.barker.ct@bp.renesas.com>
Subject: Re: [PATCH v2] Kconfig: Introduce CONFIG_WERROR
Message-Id: <174190586730.2150240.17533866269563373622.b4-ty@konsulko.com>
Date: Thu, 13 Mar 2025 16:44:27 -0600
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

On Fri, 28 Feb 2025 10:04:33 +0000, Paul Barker wrote:

> Add a new config option under "General setup" to enable the -Werror flag
> when building U-Boot. This is useful during development to help catch
> mistakes.
> 
> This is based on a similar config option added to the Linux kernel by
> Linus in 2021 - see Linux commit 3fe617ccafd6 ("Enable '-Werror' by
> default for all kernel builds"). The modification of KBUILD_CFLAGS is
> done in Makefile.extrawarn, matching where it was moved in the kernel by
> Linux commit e88ca24319e4 ("kbuild: consolidate warning flags in
> scripts/Makefile.extrawarn").
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] Kconfig: Introduce CONFIG_WERROR
      commit: 9805321dfdeb5225fe5c5e0721abf49c0875637e
-- 
Tom


