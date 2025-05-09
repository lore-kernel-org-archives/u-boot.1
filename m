Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F30C3ABC9
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 22:50:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1667682A25;
	Sat, 10 May 2025 00:49:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZwDg99Sv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6128782162; Sat, 10 May 2025 00:49:56 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E18C82935
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 00:49:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-2da14a6f89aso1123129fac.2
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 15:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746830993; x=1747435793; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bdDybVNBuUmhFOIANbAUSFBLH0ryP5al1XRQIWuCZ1c=;
 b=ZwDg99Sv620x7A4x400bc1jh9zIQemQgt/O6CfOn6kx3HyNBd7QCEAdOkop5PMU7Sm
 ia6wjN7c+LY5D1W2hA4t+7U+a3XPAB6GLv/cypl/cFFS/X5jbzm9vF5fUBDV72h17/3I
 0qJA927EE0/ItnQEXGbvQUMpkDuGkgyL3i584=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746830993; x=1747435793;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bdDybVNBuUmhFOIANbAUSFBLH0ryP5al1XRQIWuCZ1c=;
 b=hsbtv3+DfUZBppctoKCSWHENiM0TRIK8Gp0QFbWJER7sqYn/TIolcckZ0CnncFk31C
 2oKJ9PS7Onde6IhDzb0fGvKeLd84XuWH9WMrRW6CnyFAABNrYkpLVXj8RLQDfMWSiqpA
 N/VUCJvMd//G2Ix+G4Rn0ovLL71O8M32cb6t6RdiXC/ssISoKx5H/4NBd1IDC1FZiTuo
 iOAbrwRtqTesyIjvT5GEui4fCMBjtGYZWTUxAFIvl1H9sD3uUu+Q+QEwQCUqr1tJuGQt
 CITZ1mkZNgqqxXvN49U+x9EVbKLmGWX9ZfVtjn5gYI90DmKfRYeJo3UatGsz3wBVeOVl
 ZyqA==
X-Gm-Message-State: AOJu0Yw6KCTSf7sUQuCM+fiqEY/7n9+NQmhfK8JYsoar1kEA5mEQeoaQ
 4YrdvydYQlcmqVgDcs6kRcKmgvubqgbZhNeLYgjXQ17R2Ahgy/BodcI67NJLb+NcZBH6CILlGjC
 b
X-Gm-Gg: ASbGncv7uP6nmut5dvOpRn5sKY86W1mTBsokb83lWGMYz4au0tTIl+ILkmTRFQAPDqQ
 K1bduevzHoaKNWfvYUz9ePd5t4Fenen1936xQIx2dgcbU/5CryVgT9aBp3fJSbzgZZH5X4auySf
 AyXrVFzU3xfBmLoC3Qc4Ta3xtnJ4X0BB1VN3K7zUEiYhKu5fRyEGlS02WwPbZvx0PpzqOJFlP9J
 D8OwGNbUfIEf7bj14sMg+zgFzYhJI3mwVxGXpWK30lkoXqEblkm5iWU5CAOm31pYKzwU5iWmIDi
 mWKTBOEegpKOwHByRkxMMysnO8vtZnqoZkaqRQVjKGqbCj2eVzmTxRYIOMi96RSOG6r6H28uBv7
 oK6fnw2xA1D4=
X-Google-Smtp-Source: AGHT+IHCmav86ZzZmcCXqgF1rsalNDHQs5hhaGqRvZSpBWj91MZpyHwDbNVrR9eduWsMTbXd8MM5gw==
X-Received: by 2002:a05:6870:8894:b0:2d9:3868:b310 with SMTP id
 586e51a60fabf-2dba42aee29mr3082222fac.11.1746830993063; 
 Fri, 09 May 2025 15:49:53 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2dba0b82571sm801403fac.49.2025.05.09.15.49.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 15:49:52 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>
Cc: vigneshr@ti.com
In-Reply-To: <20250502050517.3724756-1-anshuld@ti.com>
References: <20250502050517.3724756-1-anshuld@ti.com>
Subject: Re: [PATCH v1] board: ti: common: Kconfig: add CMD_CACHE
Message-Id: <174683099164.770062.16399822226435925252.b4-ty@konsulko.com>
Date: Fri, 09 May 2025 16:49:51 -0600
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

On Fri, 02 May 2025 10:35:16 +0530, Anshul Dalal wrote:

> Add CMD_CACHE to list of configs implied by TI_COMMON_CMD_OPTIONS.
> This allows the usage of cache commands from U-Boot prompt.
> 
> 

Applied to u-boot/master, thanks!

[1/1] board: ti: common: Kconfig: add CMD_CACHE
      commit: 7b03df1b2ba2be29dde32dbbb0df3228d6a961cf
-- 
Tom


