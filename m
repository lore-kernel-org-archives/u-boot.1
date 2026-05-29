Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B72CD4F54
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 22:47:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 334AB846F8;
	Sat, 30 May 2026 00:47:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Jybzzuml";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94F5C846E2; Sat, 30 May 2026 00:46:57 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4E67846F8
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 00:46:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-69e06aaf0b2so772883eaf.1
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 15:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780094813; x=1780699613; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mJ6T4L23mda07bXlXFZPGGa4qCoyqbycGbAJ+0gLv7w=;
 b=Jybzzumlvy/H4AG6cUuU9zlqsUIbN1nmOj0meOu3CWM+ducwXqp8LbSh28LXYOuhnQ
 /KEzsdiz1KUarXKunavUhkJCIBHgDj6zHiIwy6K3Uevxtcnt431/u98XLEUu6/goPo6N
 hzktBYq4kL6ootYvouUd8y6S6jA3CzBgVPE9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780094813; x=1780699613;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mJ6T4L23mda07bXlXFZPGGa4qCoyqbycGbAJ+0gLv7w=;
 b=F4nwrHMD+nRFwaCkJoQTJ5LHLccxIcOruAa5a8+aYLFtJ2WcKUJRE//yBYm2rCMkLF
 Bwl59TTI6x2ieOzEnvX3RqiwFu6uNkUoE8p4wSarGanVmS2dQGzNqN0UNH/8r9RREkRY
 4iskr9bhBd/spqGwtpTr3iDpTXBdxiQlncTtsVdLWKARAe4n07rkPyq+699zQonqX3nu
 2Bb/EMduGv2Cr8aL36fcwgrGLr/WcwvWsjiuzOpWhIEI7zbIdk+dOxuh2vmzGJlJG7+r
 9nSMy+vzrpM8P9r69smosL/zjCIq+YF5mDWa7owAWiMgyDbVNhuasunI44AYE6VHktZI
 HfVw==
X-Gm-Message-State: AOJu0YxDOemD4bkkc/szOJZpqWX3blzuUy5PqSOaSKtjRSv/ZqTJ9hKy
 Y5PZXelPXPIQPvOHdw17vPbaVhJyFn1YgshrYnM2C60v9GCP6wbs2BCn9I9F5zbDQ2o=
X-Gm-Gg: Acq92OFLAb1H8e0MkjoSzyk+PSqBmXaHgj0DnCzR/RhAI35lHBBUDOIYRW0ImmmW/Hs
 NtHPBU15aKS8hNt8TqaGReNK0q8gjFLQgWEbFLYAUBDuRiBFPX0t9qdD7wzj+GBYR2z4nj2yOBS
 +rw2TBIy5S8ErztVwOMB79UFZCwmP2ITgbhdMLUDLibbMddoDjKF0u1X3HmaQ4iJjfE1zRj0esj
 KMbm2mDxarjQR/IrwGMrlotMx/YEG6bYYENwrNPpk8Xu97ZCdCdNFBLvVYuF+IGkiXWqLuzLomQ
 sE/yWFbGO+ly9qigt0F4vnuM0UKUEvNrFeFnd5brjjRuQUrRMpR5zU+fmdP3EcE2hJ0/3wv8+cP
 LPnvVK1yRMhWqCGU0uP6urRm/LqXrMpjktoLDXweRzTxWbzEJ9WeT3RTmsoMIYRvRjXC97OvPhT
 1w6GfAwoF4X03NDqzms/6xLEd4GczuK8RqsgHgGUDu97A+zz7Ygt01AzHcIZ36iidKt717wlbda
 2fZNe1xIlggqp7/ybmsixJ+ec7fGqgrm8cglatBtg2jocOm0F0yBPq7oMjB6Nrh4Q==
X-Received: by 2002:a05:6820:1ca8:b0:69d:7b82:3ce4 with SMTP id
 006d021491bc7-69e10384dbfmr683787eaf.31.1780094813630; 
 Fri, 29 May 2026 15:46:53 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69e0696923bsm2112441eaf.11.2026.05.29.15.46.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 15:46:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>
Cc: Bryan Brattlof <bb@ti.com>
In-Reply-To: <20260518-env_to_kconfig_migration-v1-0-24c8fba75ad3@ti.com>
References: <20260518-env_to_kconfig_migration-v1-0-24c8fba75ad3@ti.com>
Subject: Re: [PATCH 0/2] Update envs to use Kconfig values
Message-Id: <178009481304.728062.5280109409712355356.b4-ty@konsulko.com>
Date: Fri, 29 May 2026 16:46:53 -0600
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

On Mon, 18 May 2026 13:52:51 +0530, Anshul Dalal wrote:

> Some minor fixes to K3's env to avoid using hardcoded addresses but
> instead move to Kconfig symbols.
> 
> 

Applied to u-boot/next, thanks!

[1/2] env: ti: k3_dfu: load only the next stage binary
      commit: 2b6d243be22885e6f54eb79724c9d54db1ad03b4
[2/2] env: ti: k3_dfu: use Kconfig options for addresses
      commit: 1ea8b3e8e2d6c80469b5f082cc5f2b9287a7ddf5
-- 
Tom


