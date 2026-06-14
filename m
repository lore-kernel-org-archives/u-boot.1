Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F4DCD8CA8
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 23:02:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92CA2846B0;
	Mon, 15 Jun 2026 01:02:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gRQ3qwCD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66C3884704; Mon, 15 Jun 2026 01:01:59 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48AF5846A4
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 01:01:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-43fc82b52afso1726664fac.1
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 16:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781478116; x=1782082916; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JhMiko4L2E46drSS9++8SxCEwOlEaDiiPtW2oinG6tA=;
 b=gRQ3qwCDXZoJ1pRE6L8ich+2TWER5ysTOMJWPfJuYW1mjdGv6R2XpItrkFS9mLnGVm
 4aWdU/CoYiDWdf+pNPgAoz4jghklps1lTmCydYvw3gEb1QJD8J/YRocZdrMINF/kkjFf
 F3x+Cme8wQg5fUMvD3Ndg3Ni47CaAPFxlwM4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781478116; x=1782082916;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JhMiko4L2E46drSS9++8SxCEwOlEaDiiPtW2oinG6tA=;
 b=MAdlYDV7Z8gmL51bDYSJkXI5S4NQgdWcInG9O14cTzeHKNplEX2LrmSQJzK8Djc1dU
 EjsawNNUX0tmL+8sJLjoP21R2EZanBCnzIZUQpXWFi+XRK7XuNalY8NDt9uDNp6VG9b0
 gCEZjNuG8jCC72uEiI8pqDKe8OllORWOee13x9nMK0STthQ15EaRJYqX1AhyJ8PZClRP
 KY9pa0JYr8RHpFYBJuBEjXe5YWG4rcuag6leLCq+8k8BTOrIKprD/4ICLbxNwAtvy+FX
 eRv0MDvpU5U8iGfR/NsjrETcIIxO+WSTvWsIhrjcb5PZjQcbWIKmRj+p0cGdDg7l1AiY
 MjLw==
X-Gm-Message-State: AOJu0YzrvlfPAfRl1PdSx0oMKBCI4MUV/hTiwiBbD/0/bX+vUMSaGVrB
 SYlLy3DuNYcaPbR3isYa14iADEbiJmlR9Tw3k11mnzlNiiObz7t5EdfDHrCPulKOmvs=
X-Gm-Gg: Acq92OFgOEI22LDYgIq/a6Gl/+Lcmg2QnAm3kNwmsOwLY7VXlfbbC5Gu3yRAyr4UC+h
 orNHkhJFTsMuLF6/6KaFa/qQAWOEUo2l5u7KvJ7vmlniUbGdn1Ji0KGOa88Q+hVRkBMyk8N9FRh
 ZkJyJy2MogzPYKYzFMNHujZ3mhZGrtzmj+08kM8wEFZrI+HsSuCIe84KxlF/F/KWgWyq8KWsSYE
 iwvWMNvMsl1R10ktiMWndPGjZwTpEZXoaPVJJH5gRamS35CCRqaw75hGwWt748BR1zccHwGRxuh
 DgeuYhhJf0gjcAcSHEA+t8k23PdZ1TQU5N0hEJ4JhrpVrBhCUVSRWmI2ck38LOx0u99RKUJUNZ3
 ywS0hH3w6bP21kpHM97XMGmqTSgWfnvqWtR3XY5K38zl7VFVBGS9ttyPieL1Qvur4jIl/DjVmV7
 kS7C/lupNGic9a7mmc/UnCFn56X3bNsi82cibSLlq15aLXIjGeylDi5KUCMIBCbDADLrrEjjgSB
 +AG2amE/uPvqT17ii5UpetQkDn5qkhsvcePGrlC9MKOlJ0=
X-Received: by 2002:a05:6870:709a:b0:42c:2042:1652 with SMTP id
 586e51a60fabf-4428c7a5cf7mr4881203fac.24.1781478115749; 
 Sun, 14 Jun 2026 16:01:55 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-245.totalplay.net.
 [189.203.97.245]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4426a449e79sm7357623fac.0.2026.06.14.16.01.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 16:01:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260614160944.15932-1-marek.vasut+renesas@mailbox.org>
References: <20260614160944.15932-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PULL] u-boot-sh/master
Message-Id: <178147811452.1433281.14799134505086254937.b4-ty@konsulko.com>
Date: Sun, 14 Jun 2026 17:01:54 -0600
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

On Sun, 14 Jun 2026 18:08:30 +0200, Marek Vasut wrote:

> Two fixes for R-Car Gen5 RSIP, one to surely build u-boot-elf.shdr and
> one to make u-boot-elf.shdr compatible with tooling.
> 
> Two fixes for R-Car Gen4, which could hang in SPL without them.
> 
> The following changes since commit 5ca1a73c7d3064582498a8aa96c29e714402a6d3:
> 
>   Merge patch series "configs: imx95: enable PCI_INIT_R for Toradex modules" (2026-06-12 08:45:32 -0600)
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


