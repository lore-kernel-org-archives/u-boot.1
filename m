Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C99D1F9C5
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 19:44:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A61D88B0C;
	Tue, 15 Oct 2024 21:44:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nrWZ+q69";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70C6C8888F; Tue, 15 Oct 2024 21:44:05 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 609F488B9F
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 21:44:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7afcf50e2d0so292751885a.3
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 12:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729021441; x=1729626241; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=un3qUb+Dgw2qb9GPKC0xTHPrlk4mBDeL6PIMoKPtpaI=;
 b=nrWZ+q691FiFld4aEkhMDqI1WU6nusP8fD5ZHCu7oEmhMADqE+qG17PdnJGZKu34W7
 3AdmhGpFW/tlmKhpIDsX46kNWuJvmG7CJ4nXKqbVHvtA7cT8EDuM4Akiw7VqJuyfSGEx
 2I/uTlFA2lTQpT/2J+PsN12pW6dg1OjoFaGBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729021441; x=1729626241;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=un3qUb+Dgw2qb9GPKC0xTHPrlk4mBDeL6PIMoKPtpaI=;
 b=B1kMhZNzq3kpVA6K0AlMHQQBX2dQsHGqf8L4wWeRS1T/gJ2UojOa730I5pYlkgIZOZ
 8X/21ZzGiQro5dS0ZPQwj+1EoQ63hl3vyZVkZvy9Oj4yXGeP3mZ49NXbjbThiCZda2wy
 cpdazwfGzHvD7uZG7lNNRpNU7R4WjnbgxB5UGKXNN4iBVNtjZcYErK1ZqYOVFPjbzisA
 sfaQGDoo2XZwWl4hNe0UnoQxBJvnO49vO82OQZB+9HVA35RLIq9qc4ADUdNc5DJS1FS8
 FPhR5NoAXHE6pacuUiBCR3JaKG8sWhXvB+P6fMqmVR3RSH/wu7GFtIVqTDeWISGJfdSZ
 xkjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZu2Yg8B4VWrO7J8GQD/e6ob1VG9s7/zXSH1Y+Du//EDD+cnO/k7xYLiO7TizPxPBB5nRb9WQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxRa9J0kiS0Xe/C580EKpHJQVtO3Wq1Ier2PregUH3iU9o+pvAB
 wrKb939lP0b5LS91aLUbc2JMU7ESZ305Do9eTwgjJBhwrip1jHPX5qGjd/oXZRI=
X-Google-Smtp-Source: AGHT+IEG2McNwmjQzVoKDi2Io5mWUwxi98KWj0EbsBes0twy8/YjDHGUGIHw0cShWWxyadUwYnrsQg==
X-Received: by 2002:a05:620a:17a9:b0:7b1:11ea:1f62 with SMTP id
 af79cd13be357-7b1417b3244mr146582585a.8.1729021440825; 
 Tue, 15 Oct 2024 12:44:00 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b13899c31esm94873385a.99.2024.10.15.12.43.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 12:44:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Martyn Welch <martyn.welch@collabora.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
In-Reply-To: <20241009131548.929439-1-martyn.welch@collabora.com>
References: <20241009131548.929439-1-martyn.welch@collabora.com>
Subject: Re: [PATCH v2 1/4] boot: pxe_utils: Add fallback support
Message-Id: <172902143987.5381.8345661441391925961.b4-ty@konsulko.com>
Date: Tue, 15 Oct 2024 13:43:59 -0600
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

On Wed, 09 Oct 2024 14:15:38 +0100, Martyn Welch wrote:

> When configured correctly, we can detect when boot fails after the boot
> process has been handed over to the kernel through the use of U-Boot's
> bootcount support. In some instances, such as when we are performing
> atomic updates via a system such as OSTree, it is desirable to provide a
> fallback option so that we can return to a previous (hopefully working)
> state.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


