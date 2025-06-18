Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E5CC7115A
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 17:54:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FF2082BCD;
	Wed, 18 Jun 2025 19:54:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OhAIzgnJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90A5F82C55; Wed, 18 Jun 2025 19:53:59 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EB3182B18
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 19:53:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-40a7aa38b2cso3129396b6e.0
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 10:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750269236; x=1750874036; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OfPuEgkiTlfFDnxHfIUkbMK+h8Yqglthm25JWj4BLPY=;
 b=OhAIzgnJUsKJPtq6YRaz1IpJt63v1Wg/HVAO0UCl0xtsRvczC49e9AFqpXumW7WYpV
 9HDYQlk44IEZ8npc7xCzA1O9dPHwjzblL5nXKVHU+Ew5VlQHDeNGPsJw5dmurJ0AOJ+t
 cp/YUuCsoVBLLQHIFvZaSMMpSi7ZDEG+KBucs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750269236; x=1750874036;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OfPuEgkiTlfFDnxHfIUkbMK+h8Yqglthm25JWj4BLPY=;
 b=HCW8DAiLEY5aXbO5l0FccHNDojOzWr909cbzop5CuT57FMiURe4w3hj3Io5m29VCUu
 CDz0ndRy6R3kAlp0zfCvooqLIqqXqAxFpWByFVbm7sKKkT08xXYCKFsWuTQ34/UM/Oot
 ND3+FBEcHxYo03kqkGES+d3LUeFdko8lsbp0Vm8LbqYZ9IJb1oBXAy4HJsaqIk2BBb5g
 pQ8uEuvplZbXyV4eVB18vnysIMILig/8mRegog1xMoyeoOe4c/FdaSHy59PTbHfxVEkB
 eFRq3e6bpDVsdW5Dnm3P2DgLuXh5tD5GuMd36Av4XN63GJuSlYogeB3PumjMZU2gb9DX
 jYQA==
X-Gm-Message-State: AOJu0YyONhL/MYeVUaEiGd0UgVCWL34xlW9wf9ZTYtpqNCEH5cb13DEb
 ihF6+IH8wUsaB/iBTxb99jlk8JNIwabFVlXB2LbXdruld09ndCSdAN9HtzFdcKNImhYtA8UgI+d
 DX/4KyxA=
X-Gm-Gg: ASbGncvx80W6d8FZV0P498diwR5UaCWQdQQpN2r1cUbMzPJSfsqvZp6Cb86GacLxt/h
 vH9dUhC5iQ/XLL4Vsojx2JD2sqk5AJ1WHBUrdwJgg9lT2OQDGM4GKQ/75cqgD71MZZBdU1wnT3c
 qZSX1xmHAhwlLIs52SMFanptAjDt9VMYu4+uPtBwy2WrMl3ULjv/oN0VcQ9wgU49X0aylZUTWO2
 EAWEkfDMVFNSwytgcVRFZy8VxtGzesZdb0gbBrNxlnUzEGiU1FOGwZBguypSs+8JiycQhjdIF5f
 IvR/FPYEmhe0TUCPXvP6h4RvOwQoNFKOKvfx/wMjBqQZeXbPekOauwXtrkyR9wr7pDIythjr614
 HnhhfsWK64N2GE2wibf8d6w==
X-Google-Smtp-Source: AGHT+IHnnUGQkI+evN+qAMt4TtPMG/akhAlI8l48gnKCrEWiQXYIkrYxDjRK6Y6usUfJzRJRnEZcGg==
X-Received: by 2002:a05:6808:16aa:b0:409:10a6:418f with SMTP id
 5614622812f47-40a7c1b1f73mr10349143b6e.7.1750269235913; 
 Wed, 18 Jun 2025 10:53:55 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40a7418a394sm2454965b6e.36.2025.06.18.10.53.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 10:53:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Rasmus Villemoes <ravi@prevas.dk>
Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Joe Hershberger <joe.hershberger@ni.com>
In-Reply-To: <20250507121246.518691-1-ravi@prevas.dk>
References: <20250507121246.518691-1-ravi@prevas.dk>
Subject: Re: [PATCH 0/4] list.h/treewide: get rid of no-op prefetch()
Message-Id: <175026923468.79778.751326866458072610.b4-ty@konsulko.com>
Date: Wed, 18 Jun 2025 11:53:54 -0600
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

On Wed, 07 May 2025 14:12:42 +0200, Rasmus Villemoes wrote:

> While looking through list.h, I saw that the regular list_* helpers
> (and one of the hlist_* ones) still contain the prefetch() that was
> removed in linux 14 years ago. It doesn't do anything, but makes the
> macros harder to read, so get rid of it, and the fallback, no-op
> definition that they relied on. That requires removing a few uses
> outside list.h as well.
> 
> [...]

Applied to u-boot/next, thanks!

[1/4] linux/list.h: drop use of prefetch()
      commit: c1c2b5c6a4c09fe57933b70ec6289795f732ac83
[2/4] treewide: drop no-op prefetch() calls
      commit: f5fa73a625f671152aa65be4b039060f8baed4cc
[3/4] mips: drop unused prefetch code and logic
      commit: f0ba1435a8eee45138353f6114ae658e3802dc9d
[4/4] linux/list.h: drop fallback definition of prefetch()
      commit: 1d19bbcb68280814952bdc18d7dec6d083b2c0ef
-- 
Tom


