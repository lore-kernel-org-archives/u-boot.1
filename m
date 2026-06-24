Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFDE6CDB479
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 20:49:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DA4C8460E;
	Wed, 24 Jun 2026 22:49:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CvDYTSc7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D06E849F0; Wed, 24 Jun 2026 22:49:27 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05D4E849C5
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 22:49:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-4871618372cso899433b6e.3
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 13:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782334163; x=1782938963; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ckHq9o0ORJkHqZmeLq/WqxfBxUwjMBGlw71IOb7mR8M=;
 b=CvDYTSc7dc7ogwXfsavQtihImNiAuZiNss2VTm/1e6PhbcZsUnQAYLaNkjkISdNNmP
 2B0XnTE96/j3+h9nQ4IZ6l0XqdpXlYtM0eGKIZXPz9x4+gWfTwiCQWgCbYkcq5IQBVhM
 TxTYPaK3L6/7r4nIzhFdwhqLPPKjmsxHTtQ8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782334163; x=1782938963;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ckHq9o0ORJkHqZmeLq/WqxfBxUwjMBGlw71IOb7mR8M=;
 b=HHPfFxxVvkZ10mf27PMIJ5Q83S2e/EGTP7ykFrAeYjc47K/7/B7G96GkS8Vp4F77qH
 z5LOresYTVEUpvH4Gd3IktzpPvUhD/34PsYluxE/VYI1yJF/ik9SxRtL88WSxLmoya3C
 W2o3RSpAaBr0yuE68O6VW4GUdUx8rGgOGs5RNv+Zwyx+UepSgEQplulRYg5F3pal7O2T
 UbXD8ZUlUYXclx9eb+ybKnnkIsPDPyK5dhHxOGDgwNtHiwbqNtFNR/AKy5PURL6QG5uU
 cCySylI2ttAkmotga4uQfZP/IY+6uef5MGTpk/zyIU3JjP8ADB7NWXQu3+wvRlRefiIt
 YwWw==
X-Gm-Message-State: AOJu0YyMJNheqCLrUZ5K+sH2SmDbEKFtSVpyoEXjR036if5+mvRbtRiI
 P7/L4c9LRYWH87ohFTI02HZm3WCKtClAuhXVMHR2EUQlAAchERzr0rHb6LEwM2N0ym4=
X-Gm-Gg: AfdE7cliPbnHkZbCfoKhRfuYSZXxVA5hj7kRauXdfZzmK/wk1+r58/AsSA1PDTMjoM1
 MhBFEwxqcqEiV5Z/QxDwpi2c4R1vHu9RAi3zYxLK2PTxrahZ6jJR4DU5cQV1hOfAqgyPRhDSOYC
 CDjRb+kO3V4QQjD/KC4qLWY5vTtfw7RR3HMdFkrBwFmcKu+WqFBdFQ7xA/5juCGJ06o93lP/5pf
 ceCtxXXhmyo0ve7bWpNqGD13vkrqEbuYfKSvTBz0pzwH9Q+ZFsk05icM56E/l5SqdLAHvyXYqci
 YAZskUFpm1jWaDl0Wfl3Dl5Ybk2/V53yl4pTGEzpXpEw43wPlLl3LvachmeIzv42QXctQbMlwZ5
 hnCbcF0+2KdtHO7vtNzfYp/PmftHmTW3R0MwX4AXamIaubD7v3NI0jzcJd965rXKkKifma35ZMa
 njbFKxmVqNyWp8O3M4NgrAp2dmjZYIz4P6OdD424+e7emytgoX4m3rKI3xZAgrFPUhKSlpn9U=
X-Received: by 2002:a05:6808:181e:b0:489:34da:f600 with SMTP id
 5614622812f47-48abec3dd01mr16245636b6e.11.1782334162786; 
 Wed, 24 Jun 2026 13:49:22 -0700 (PDT)
Received: from [127.0.1.1] ([145.14.135.239]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-48aec0e5e53sm9020733b6e.8.2026.06.24.13.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 13:49:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: visitorckw@gmail.com, Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <vgwnt6mnls3lf3zdm6mz5siztzkvppte4ykszbvifjzukvmksf@maaxe5agqpim>
References: <vgwnt6mnls3lf3zdm6mz5siztzkvppte4ykszbvifjzukvmksf@maaxe5agqpim>
Subject: Re: [PATCH] serial: goldfish: return error when device address is
 invalid
Message-Id: <178233416195.3662130.2751510126464205417.b4-ty@konsulko.com>
Date: Wed, 24 Jun 2026 14:49:21 -0600
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

On Sun, 07 Jun 2026 21:15:42 +0530, Naveen Kumar Chaudhary wrote:

> goldfish_serial_of_to_plat() returns success even when dev_read_addr()
> fails to find a valid address. This leaves plat->reg unset and defers
> the failure to probe().
> 
> Return -EINVAL immediately when the address is FDT_ADDR_T_NONE so the
> failure is reported at the of_to_plat stage where it belongs.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] serial: goldfish: return error when device address is invalid
      commit: d73aed0b0571828c7ee308adcb1bb1145892dfd1
-- 
Tom


