Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC77C282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 01:14:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BBA8805D7;
	Tue, 18 Mar 2025 02:14:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WWhp3Kd0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56F0D80F70; Tue, 18 Mar 2025 02:14:43 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 498FA80107
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 02:14:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e3978c00a5aso4258715276.1
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 18:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742260480; x=1742865280; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZGJ7g9UXuKAjuyk2g7PGzvrWVWulvpU9feDNQ1E3H3s=;
 b=WWhp3Kd0Ha/gX+JjUK85uO3FzuqMb6Nyy09VB4xEagnzTCs3HIamEi50GsUO2e23ss
 6SQ8ZjMwQev8CmPGwaGnZ1NrZVz2x/fikXkgj9tWPHhUha7DKgNwNfRm/qTn3NECHcRa
 4DnN2jwwVt8HccZ7x5Y/uXeLVzJuRLqXLQ840=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742260480; x=1742865280;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZGJ7g9UXuKAjuyk2g7PGzvrWVWulvpU9feDNQ1E3H3s=;
 b=Sv4MBMvniONIQjUCcO6YA/J8e+GwugSCRRxqA6s+xB3AEqjNegsDjNpInx/Y93vIBm
 lu5v1tRyOGmLDEhMqggW1Aqz51p2v9HfsI5L4szaZTx4rTGlYQMCyd/uQgL6ZwmLffvs
 eXiGCduvTObG6i7AKxzDe2L8ALPEyrZbkgeYjIXLn5yIzUxH6zqI66STeHhCJcGiTlAg
 hLh45UrLd32WoFR6KyAcjEXeXhRMj3ZbBbQqDr6R4nNj/d/iZtg7cejxa/592kXraoGc
 0oOE2K9dKLOUh6r+GSvI+fK+KaWrtSar2NWglDTLBEe7EhFrtuzzsKFPh724rEnLLw97
 qYmw==
X-Gm-Message-State: AOJu0Yw2UIASkta8DS1NHmhcwEJ3Sz7glxs6OkMXHj5JH6bptWEgwwtv
 aD7u6UMb3pbz6mn6YQjXyOiidx0pTkcFxmzrcA3k8X7NhLWJaJ6zSNmRwITzY8bvs421Bt9/UFS
 W
X-Gm-Gg: ASbGncv7II+xWacayynN4ZDijnbVoJlFiDnQg8Z/T2maoAb/Iz1MB3rFg1gMhNPeVOr
 IYIFBZUKO1RGDnKagp1eSdlNu7WLQgpUZ2viTNsI+6WqfMlGn8t+h9bvmqkf0JttFGRS1sw7JPV
 PwT4WN3V5c32h6+Xk4Or7lu5Ch+f0DvA2cigIa/RPVyTJ8aIDNSTwdgT3GOs/mQ+pC5hVDeFJfR
 5I3yo/v3VXIu/aLv/RqoT9Wm39SX6yGkJteGyg6ZtOlPLK05KxwLn3hDkA/9sTPk2ODoaxQ8TZI
 9Tgcz9kgDdXlHmsxfbLUgYlCxwK+wEeSIJrh2nKWYHBb
X-Google-Smtp-Source: AGHT+IG47cGVjDjSLFWcggSN0OuOg3ut7Dw2L+HfdFxNbQvMphGSNnibWPmxNbLpDX02xCzrfEpQwQ==
X-Received: by 2002:a05:6902:1606:b0:e63:ebc9:64c with SMTP id
 3f1490d57ef6-e63f65b87cdmr20305266276.33.1742260480109; 
 Mon, 17 Mar 2025 18:14:40 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e63e541a8dasm2496876276.13.2025.03.17.18.14.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 18:14:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>
Cc: Minda Chen <minda.chen@starfivetech.com>
In-Reply-To: <20250317031542.223248-1-marex@denx.de>
References: <20250317031542.223248-1-marex@denx.de>
Subject: Re: [PULL] u-boot-usb/next
Message-Id: <174226047906.1689015.12946393324630573372.b4-ty@konsulko.com>
Date: Mon, 17 Mar 2025 19:14:39 -0600
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

On Mon, 17 Mar 2025 04:15:23 +0100, Marek Vasut wrote:

> The following changes since commit 0e1fc465fea62ebae91f2f56cb823e8b37ee1077:
> 
>   Merge tag 'dm-pull-15mar25' of git://git.denx.de/u-boot-dm into next (2025-03-15 08:19:31 -0600)
> 
> are available in the Git repository at:
> 
>   git://source.denx.de/u-boot-usb.git next
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


