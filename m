Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0455C4345F
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 23:05:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83FA9889D6;
	Tue, 30 Apr 2024 01:04:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qVM9I1DJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2187889CC; Tue, 30 Apr 2024 01:04:15 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D63E18899F
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 01:04:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-78f05341128so362359685a.0
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 16:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714431852; x=1715036652; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bka4GKQ3P8rmhWWbUVZCiB33zGSXKyBnEPU8nv4nkLE=;
 b=qVM9I1DJoaUZI/nCLm4DZ3VZZszkIn+PjTRO49/tUKHbv0cIpHPKphm0CG/cLFk0by
 bkC+ryvePwtGaVZIeCJjIvkl+FboT3o5ABI65WZx4IlGJSX3bVb7psQYn2V8LPs8BpYn
 M/p9xs4JbBfu22vpQYGLiG9sVdWss2Bde6h3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714431852; x=1715036652;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bka4GKQ3P8rmhWWbUVZCiB33zGSXKyBnEPU8nv4nkLE=;
 b=TFTXmKCywTJoPYGbPSEE/+ugouaRygyOApjfpr9cG24hADD9FO7Ts6prjqXooy1mM9
 0rs/bfkCL83NHcKn5qKPM1ATmKSosr8SMFqA5R/PRsAMIYQo+dyPYx7kw8Nok3ATpbIT
 e6e+BE7jnaFw5+ymhVemZkh1c5RrKlgceAJ9GVTnf3atdCCdF+am0XHvHqNa1cslxkXC
 PmO9jaDlxIE5TKl7gVFNklgAK4uMhQEJDK0/OZHpJYV+LH0Qxkh/jDWVwV+AIbqyKY6K
 3NXhBatcM4ZasFsaOHiZ2afOo4l1ZHTIor0ls0V/Ug6mreeVf0pRtkkHM/P55dBAnKax
 Hgfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUscTt0NSDpyY32pX2w9/rlmwuygk/oQftBNWibLBEDj/v7moIibwgK5rJQo/zzAG0KYc4/oKWn2s1F0O+28/3lPAz0Dw==
X-Gm-Message-State: AOJu0YwXRLt6q0kz/oIAhiKFM+mjKaBMRUcVW9SlyvSJ9BrS08kShud6
 FhcdtRvrnXWYvg6mbD2Zt9tgAFWzpsTKVmgxSIfVNevHQLcjOcOA07ZgebKPTYvTIuUJ28GOkWD
 q3Pulag==
X-Google-Smtp-Source: AGHT+IEfNxHNyp2SHcqXHDuRRa0wVfmlKepBFJlpk400SBaUGf5sgtcAAFXhgk/3DFneaU1zUXC+7Q==
X-Received: by 2002:a05:620a:1650:b0:78e:e432:3f0f with SMTP id
 c16-20020a05620a165000b0078ee4323f0fmr12326665qko.72.1714431852037; 
 Mon, 29 Apr 2024 16:04:12 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216]) by smtp.gmail.com with ESMTPSA id
 h6-20020a05620a13e600b0078f044ff474sm10967156qkl.35.2024.04.29.16.04.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Apr 2024 16:04:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
In-Reply-To: <20240422135010.176205-1-heinrich.schuchardt@canonical.com>
References: <20240422135010.176205-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] cmd: CONFIG_CMD_BLOBLIST must depend on
 CONFIG_BLOBLIST
Message-Id: <171443185125.1749944.16509981958522926145.b4-ty@konsulko.com>
Date: Mon, 29 Apr 2024 17:04:11 -0600
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

On Mon, 22 Apr 2024 15:50:10 +0200, Heinrich Schuchardt wrote:

> With CONFIG_CMD_BLOBLIST=y, CONFIG_BLOBLIST=n linker errors occur:
> 
>     usr/bin/ld: cmd/bloblist.o: in function `do_bloblist_list':
>     cmd/bloblist.c:27:(.text.do_bloblist_list+0x6):
>     undefined reference to `bloblist_show_list'
> 
>     /usr/bin/ld: cmd/bloblist.o: in function `do_bloblist_info':
>     cmd/bloblist.c:19:(.text.do_bloblist_info+0x6):
>     undefined reference to `bloblist_show_stats'
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


