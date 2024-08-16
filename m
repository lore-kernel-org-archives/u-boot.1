Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3485C52D7D
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 03:47:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A41488B31;
	Fri, 16 Aug 2024 05:47:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fSU0BCnZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3871D88A82; Fri, 16 Aug 2024 05:47:31 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2101E88AF4
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 05:47:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-70936061d0dso1093955a34.2
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 20:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723780048; x=1724384848; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5bleattASWdW06lWRa+h0ZGl2aRT56IOQAGuhx8F4ZU=;
 b=fSU0BCnZkrsAfWoXyclK4NMsrB21ObyFXtPXOMv6kY77WvqKgrH5JlKwKV/1+SaDPW
 lfOMuXOWE+CRcnSS76AIQpmDzUY3qld+sv2lVJSol84dqCwWlmvphmSPYm07ndm0qyX5
 XEFr9Xcct9Sic1Afk83R4jlQgJ7RUVDeAiiCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723780048; x=1724384848;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5bleattASWdW06lWRa+h0ZGl2aRT56IOQAGuhx8F4ZU=;
 b=GE3LubONZDauwrvbah1LKcJdXHZHd2vN7ugz10pEIWdXCBeK3SZwh3O7YIcLXyiy4r
 SZwt0rLhMwOTiVJjxXfRNvXoSPyVoOyixfl/XAVSuQSbjtx24DWXIAh3W1euqBjQLL0t
 fYBjR8SW1amZY6Rr1TD7WPqqqntaUJehdOIdq3nExR6ax1R0Yyu5LkKvY0yhmzzkbks1
 PuRfsD45eZecdXKMVARukdPbRD0DLvpgnMr6nxtb8NsbEIQ/Wl4PxONkYjJDQCPMMNdU
 FIW8pMqojfR7yuPNU2vKGQhUU/nSlmWjMhIVpVlps8KSqy8BOppT/i5McaRRz0PhqeOH
 hfiQ==
X-Gm-Message-State: AOJu0YwJWB/KD9iaI+9JMjr/4D6XiipRwUj3OGmzgUklMZ0R6OhPVwm9
 hyUudJbBhI/E6ImbrEC+qEwGDXVAYU60xoDByuijGVlbNY4jF5p/n2Je6u2DQIsxg8QE3qroyup
 LboI=
X-Google-Smtp-Source: AGHT+IFfp9KxKxXJXfrhy+lFoFT0iGfhBhdeOS8MfXOT0zcN6pygAC/JHJAog6r55Tb43TWHGKkYPg==
X-Received: by 2002:a05:6830:40c2:b0:703:64cc:a496 with SMTP id
 46e09a7af769-70cac88fc7amr1854463a34.23.1723780047704; 
 Thu, 15 Aug 2024 20:47:27 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5da8cd69811sm541522eaf.4.2024.08.15.20.47.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 20:47:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Richard Weinberger <richard@nod.at>
Cc: upstream+uboot@sigma-star.at, miquel.raynal@bootlin.com, 
 thomas.petazzoni@bootlin.com, jmcosta944@gmail.com
In-Reply-To: <20240802163647.26674-1-richard@nod.at>
References: <20240802163647.26674-1-richard@nod.at>
Subject: Re: [PATCH v2 1/4] squashfs: Fix integer overflow in
 sqfs_resolve_symlink()
Message-Id: <172378004680.3540666.3594291040129408266.b4-ty@konsulko.com>
Date: Thu, 15 Aug 2024 21:47:26 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Fri, 02 Aug 2024 18:36:44 +0200, Richard Weinberger wrote:

> A carefully crafted squashfs filesystem can exhibit an inode size of 0xffffffff,
> as a consequence malloc() will do a zero allocation.
> Later in the function the inode size is again used for copying data.
> So an attacker can overwrite memory.
> Avoid the overflow by using the __builtin_add_overflow() helper.
> 
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


