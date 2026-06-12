Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE35CD98C7
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 01:59:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C8E9839A8;
	Fri, 12 Jun 2026 03:59:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EnwLoJyF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 902EB848C5; Fri, 12 Jun 2026 03:59:17 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 793A984894
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 03:59:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-43d1470491aso277733fac.2
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 18:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781229554; x=1781834354; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3QvhcRDnXGeFPYGKGDjdkl47/K8VzrNjrtguCtfcFPk=;
 b=EnwLoJyFH5IoUhYOPdndCUiLW5N81bvuZKhZtrT9gybg59TO5qA/0ScImXoaZb3qp/
 vQ8UTcyB+FUuYg4RcWIwwLZVW/fkdSPn6cjT+lnsxhmw7mgD4aEXIj2xIbR7I7ERgl2W
 Fwyi1MMr7c5ixyP+fWg+NXESRdhQCUYGlMQkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781229554; x=1781834354;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3QvhcRDnXGeFPYGKGDjdkl47/K8VzrNjrtguCtfcFPk=;
 b=pKRATvLLAMPS1hLH4rYDRcO3jiWsRu2ozWI3BMgOul7NA31+/0/Av4nwn3iZcZd8Wg
 zhOZZou1TpOTcjV393CRWDq/h7KBtpcyU0Y1fboIznhQR88Qy3oC7YDwmHxeaZV3Kc6P
 UcGDZ6q+J0cRuOFoHhCpY4M0YKPWS6L1Uh6HgVIJjrvnkLGSf8FfmJfPX+uC9Lz/3COC
 EvXltnJK2Svqb+oxT/X98fx9tEmjv1br7sx4PALXmrpVrXBYc7V4NgKJx4nX3IYLrbbJ
 nAJSSwcpggjAykSMFjn2Jp3j/K2VS9kNYg9F6Lt9LqOJGjSOQpwzwVcKfiKL5rhqkQLT
 VkVw==
X-Gm-Message-State: AOJu0Yx9daevvWcla7NDzuwMIl0sScuSd9Juxebw42snz7NllmLVz6lm
 xtlPvtXnWCrRTFyweQry/PYxG+tuEs32aASCxu7g3QgTMatnyMIlIJvSdMEOg65bufhUT1sP8ax
 KfOTHRz0=
X-Gm-Gg: Acq92OGQLNpCl0Xe5bZDik+xpjRDNpAWCOnSF+2raXx2zpmYlsTIbnM3gnusC7nK79E
 MVxaOSBFiPYRIhzzqTwCW0Z3GsUl6Kvf2eJ4JUBRa7pGHMcRG9VjfMpISe6VI0Iu/NC1VE/8o8b
 XhnopxRvOdbrngr+go0jOkwhCDjiIkNwAba/N/BDQ1XxFlQJsmLPcTdxDqu2J7ngunnz5zPzgsO
 3j2Wvsfg7c5TM4ejiS13L6SmznkLbKkwR+n9SfJn7F3q0pKWq6n9Vu7Iil7mf+3hS6tPLWfYtYM
 QQywN793s9mKWHIaZoHocDwlXRHK+p4sPA6dHICWO8YxoAMNzrF3PEyeu9Q7rL61esR7x0gPUz5
 we/gzSn+raJQMFchG73WWTPFHXEMbDp5tVK6Lnz9CmrysBepCnHLMh0w1uURgqSwgAifms288s+
 0VFU4xxaCbtgDRWl23QN8IHqBx8fSNHaPpmK2Us00Ohnivw3twKMNKxgDSa+qdU6Em+wyTZ/c6s
 evErW6rh/g8UGFb4zlVfoi3MttjPaeAcHCWhzzl/9pUfjc=
X-Received: by 2002:a05:6871:ea04:b0:43d:31aa:f1a with SMTP id
 586e51a60fabf-4426e1eb325mr441410fac.23.1781229554220; 
 Thu, 11 Jun 2026 18:59:14 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-245.totalplay.net.
 [189.203.97.245]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4426abf184asm534734fac.5.2026.06.11.18.59.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 18:59:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Aristo Chen <aristo.chen@canonical.com>
Cc: =?utf-8?q?=E7=89=9B_=E5=BF=97=E5=AE=8F?= <Zone.Niuzh@hotmail.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>
In-Reply-To: <20260524151431.72296-1-aristo.chen@canonical.com>
References: <20260524151431.72296-1-aristo.chen@canonical.com>
Subject: Re: [PATCH v1] bootm: bound-check OS index in bootm_os_get_boot_func()
Message-Id: <178122955310.605671.9096635940891216536.b4-ty@konsulko.com>
Date: Thu, 11 Jun 2026 19:59:13 -0600
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

On Sun, 24 May 2026 15:13:16 +0000, Aristo Chen wrote:

> The boot_os[] table in bootm_os.c is a sparse array whose compile-time
> size is set by its largest designated initializer (IH_OS_ELF), giving
> it IH_OS_ELF + 1 entries. The accessor bootm_os_get_boot_func() returns
> boot_os[os] without any bound check, even though the caller in
> bootm_run_states() passes images->os.os straight through. That field is
> populated by image_get_os() from the raw 8-bit ih_os byte of a legacy
> uImage, and by fit_image_get_os() for a FIT, neither of which clamps
> the value against the table size.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] bootm: bound-check OS index in bootm_os_get_boot_func()
      commit: 103b1e7ce8cc0b559dfce4585e403f18685aeda8
-- 
Tom


