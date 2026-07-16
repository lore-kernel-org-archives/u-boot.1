Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B00C44511
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 17:12:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 637F084D74;
	Thu, 16 Jul 2026 19:12:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hF2pARpv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C64C684D88; Thu, 16 Jul 2026 19:12:26 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F85E84D32
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 19:12:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-6a17e36fa79so2598873eaf.1
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 10:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784221943; x=1784826743; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HDm+SKqx/yqN8lNBffeJ9uTruVBbYAjh4Axto2SVEKA=;
 b=hF2pARpvFdyu1KTfqYPWPHh/fdTYYXu6br6BFqqgB7EqAzwr7yEe2UIr2qMu5HUStZ
 LE567CmQi0uqRS8lBoq4iPtMUCybtm2Jm+4RlqrEd3J+yn3zA5vdedglddMNyC/MJfSq
 7J5r1aYG4/WKiTLiEdMXqbds58CTmrQE7VsEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784221943; x=1784826743;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HDm+SKqx/yqN8lNBffeJ9uTruVBbYAjh4Axto2SVEKA=;
 b=iEv5G9vvZHcZZ6UQDmbwQv/dWAUiwJRyvgE/nWxomuw7laBz5kVFhd+OiaOfmT0Bma
 /k90MoZyu773Em2VzllB72tw3K97HTYdaUqvNy9cJVx19UCSQX+bBCt+8wOwyD86lTWq
 ux4K/IoBuHL1Bj+ZndDxq/sXF05SIPojEv6mrkmZCXZlEoXlDatGAihjf39CAeeBlGmN
 DZ6SPz3JexM/U1WMJtMwGFZNoqTShytFaTojZsq27iAEItWf6+Ehzy10IXDVLECiXGcE
 v3+hVuTYYG954oe3Lw8+iZnMmmQvF3hikeiib8X3PvQkS+6hvgZjLzEZ7GMXzC0CG3Pj
 xBNw==
X-Gm-Message-State: AOJu0YxVaFR0/bKSfJJKr6kdx6WUYbhrZVbAU6Vpn0tTV+qicYmfG8My
 H1EE3bxDm6n8swMdNSJMD3auOeT2EXxkTDbY/4YiB4N978zzMcjJ+yAJguQ8xowhOVM=
X-Gm-Gg: AfdE7ckdoZRpomz79UZqrF5v4w4w1+/ebFycslyxUFnAyJDaZx4u3djdpj3zP2vLU27
 cI9i+uosw3lEfHgY28L9ZL1v4cgPDiExhCDEclkr/u+m285JFVvY3ny1sgeAcUaBwWaVnLMPR9Z
 iJkROFOUDZPaX8fX+QwB14efA6p222NDpbRN21XvtXvkasC8+5wAOmcKiCXmC9+Sx4BITFQVu9F
 o08mF1LepdmzfPz6FjJgrFlYaOmq+tcM0vJ/jbZo4BLeqDYd91RxcRS+zW88k/iULf1KUwgFom7
 gM/kTWzgNYzHNy+CXkPM3br3f5BQeibGBfGMNvhbySqMMnyl9Hlq+uG/OrkzBO8BZ2exbo/Ol2Q
 g/gZ3Anddp3OktzAvbHo+dHNE6h3J5Y0+q7PfT+ve7K/0pXpAgVWGZV/Yk3E+qc4RBjZxRXCqjg
 /hfK5aXGpp3XqxcggWDgPBqHAQXuo486ehRUKJtSN4dUwD7xzT7pvsr+IQfW+chIzCImg3iC76V
 urtNKStWWBF3/BdH+TvdetLVC4i8tEjLO0Q
X-Received: by 2002:a4a:e90c:0:b0:6a3:81a2:746f with SMTP id
 006d021491bc7-6a3cb9f8475mr7214560eaf.33.1784221943141; 
 Thu, 16 Jul 2026 10:12:23 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-93-175.totalplay.net.
 [187.190.93.175]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a39af0e953sm10664566eaf.3.2026.07.16.10.12.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 10:12:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Karl Chan <exxxxkc@getgoogleoff.me>
In-Reply-To: <43faed52-0d4b-4549-b2f9-4fc566f71068@gmx.de>
References: <43faed52-0d4b-4549-b2f9-4fc566f71068@gmx.de>
Subject: Re: Pull request efi-2026-10-rc1
Message-Id: <178422194170.333700.15797622094445855703.b4-ty@konsulko.com>
Date: Thu, 16 Jul 2026 11:12:21 -0600
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

On Thu, 16 Jul 2026 06:47:40 +0200, Heinrich Schuchardt wrote:

> The following changes since commit 8dbe57ba648648c4897717cebbc4505a8e0a8c23:
> 
>    Merge patch series "tools: qconfig: print a proper error when
> database is missing" (2026-07-14 15:42:08 -0600)
> 
> are available in the Git repository at:
> 
>    https://git.u-boot-project.org/u-boot/custodians/u-boot-efi.git
> tags/efi-2026-10-rc1
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


