Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36DFDD3F064
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 14:03:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8DE083F2E;
	Wed, 28 Jan 2026 15:02:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tvh1Y7yQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C923983EB3; Wed, 28 Jan 2026 15:02:35 +0100 (CET)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96BDD83CEA
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 15:02:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-40429b1d8baso1843034fac.0
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 06:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769608947; x=1770213747; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RdjBJkk0t/QEacQQ3Us0bz5TXCc+jDwXebs03gnG5uo=;
 b=tvh1Y7yQYFupy1EKHEYSphm8O70rAiTgVh0wpJ4ddrR7ApMHDqAQRzHQhdecuwes0Q
 tBdJkXgiJ1CZYh6wqcr5ZzS8WgjqFQ3B87HfBmFWABNKtqcjdrMMkFKSFd8SZjutmiUF
 5vZkDlU29BMu7YKf1F4cYx/ZvmW3qi3QflA9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769608947; x=1770213747;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RdjBJkk0t/QEacQQ3Us0bz5TXCc+jDwXebs03gnG5uo=;
 b=rGyKZd8SNCynox2sgVFVOWojlODIuGvIrYAOKAEhmU6e4eV2c3voZzQ7rPSkC6i/dD
 XE0Bu8aw6t4tW58LEH+g2D5uIwhXA9UTg85Jzxea17UlsMocLucP9b/z532baPQalpyW
 gRTx/yGtbuwyd4F6K+Gk0dPRDIospTvsBZ/ln/7IuDfKgJXJsJygA/GMhRaIxoSM7ms9
 Bs+2cwWKiHwf6PnEKZQQ9pBrFTcvBOCRM13BaFFNANX1rgBhLnXpKLrAHawUqWWHqMvz
 /VdUGpu9fAuDRcOowgs4II+PAP+ZeNMkP64mx6a8stt8FrDVqwFzUJYYfY2RrlDJkqpn
 +SQA==
X-Gm-Message-State: AOJu0YxBVSJgv0O/zORlswSQ2LwHict5b/4JVcBSXVViLhkf62Cni5zX
 n7KIWKezlkrBHpBI/nI2vNRZtIokhueglytcktA/lbI2xUmU4KtMXSUJ7brmL20Ky1f6IrC90Dz
 k5zNy
X-Gm-Gg: AZuq6aIPJCdXyN0T7ZES0+8WIOFG56qo+12egv4c7h5rLXpa13aM7tpth8N1GGCnNbq
 X+2DoWtFH7qvOZmily1daG8cX1d1VwmIGYAdY4LDAR2hY6e/y4U0bpB5L+ajftyXDjfLNrBhU0I
 92syVFoDbgCgJVWYCKtVlz7issP9NxXxBDLzqsKEwnahy0wtZg3ON7XlB5+xqwt3xrsqHpYqEB7
 1yUOGzcdYAkLUpR5EPJWxglnw9VX3LYdeFPOP5GMAAAkvjenzuBgpnFgLaTeb6z+mBG5K3RHK1a
 LicMBmxryYNmzFDQ+jl5isNmtozYm0uOjfeD0xhU+mM5pcULvqWT920A+DljXux3EFfTscmBoOw
 0wV2xNHb0rwppyj4Dmd+6yoAbM2XAofWid9CSQU3N5tmF368mLb4GUw71XCgAKUKEIEZ4gtUsfq
 HX5a5JIF4bOubNz/FXfjEZWMA3jzBXQE0tLcFg3byu8hOMbEoCif4+kbM0hsRrspJh7v8zOf2TO
 lGhp9WOUUa2DAuaigLCg4gz+ggAmJPZ7gZ3mjoQDr9mPIJt
X-Received: by 2002:a05:6870:4688:b0:404:2f23:c63 with SMTP id
 586e51a60fabf-4093ffc78b2mr3365043fac.42.1769608947109; 
 Wed, 28 Jan 2026 06:02:27 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4095749f332sm1751438fac.11.2026.01.28.06.02.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 06:02:26 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Martin Husemann <martin@netbsd.org>
In-Reply-To: <20260112170511.1856525-1-trini@konsulko.com>
References: <20260112170511.1856525-1-trini@konsulko.com>
Subject: Re: [PATCH] bootm: Remove BOOTM_NETBSD from defaults
Message-Id: <176960894610.1640006.9201032820406089507.b4-ty@konsulko.com>
Date: Wed, 28 Jan 2026 08:02:26 -0600
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

On Mon, 12 Jan 2026 11:05:11 -0600, Tom Rini wrote:

> After talking with someone from the NetBSD project, platforms that do
> not boot with a device tree (and so would be using our BOOTM_NETBSD
> support) a very few in number. So we can remove this option from being
> enabled by default and save a little space in most places with platforms
> that need it still being able to re-enable it, if needed. Ideally, in a
> few years we can instead just remove the code entirely.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] bootm: Remove BOOTM_NETBSD from defaults
      commit: 0fcd1548596a5d9358bfeb96bc7863f6fa17e15d
-- 
Tom


