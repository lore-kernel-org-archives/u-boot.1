Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7671EE77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 14:39:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C077B8069D;
	Mon,  6 Jan 2025 15:38:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O00gvu5e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 440B08066C; Mon,  6 Jan 2025 15:38:58 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D3A0805E1
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 15:38:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aaecf50578eso316348066b.2
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 06:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736174336; x=1736779136; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Egi7Rjpvca7oMRyHEUHLFF0tJunye9DnvGNGuL61NSs=;
 b=O00gvu5eG9f+W6eYReZzPmLGexgkRq2I9L3ifpN6AcZDpZ2GvOqqlFSL6/zqyYr2fA
 YMS+PXYNNW0kbcGmnDETVq3Eijnan/flviGVGVQYSpIeQylDonE8YMfcHZEmr9ePSO9S
 4ohOM9Nt+YFwq7remAXAMLwtMyQIed9qVmFFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736174336; x=1736779136;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Egi7Rjpvca7oMRyHEUHLFF0tJunye9DnvGNGuL61NSs=;
 b=B9ajeUwfXBVEnD4OcbevyHYLc4s/Q5uPf/GAkSYoOQBKFktVCTKuXLAiHJRDPHMv99
 OYMuiEnH+FoJzVHxswpuxCBq0YydmCJ4LNu6sL81EMe8e0dFm0NURtKDQ859wRpTyrr2
 +9jPW9Echo3cTdcYFMslKzYxUf13NBo2mC0k9fEOJFXbKthn57hL7u/0k/GKhuEDw8Oo
 cwNjYna6mhBSorJRzo2p0HJFDPGyMwSgZMAy9p4fSJ4Mnhr+KZewOCANC3Dg8Md/bj6q
 6BMb7Nav9/KHjAgfqMh+RkvNCs47e81SWNIqu6EyH8P4x5e1gbw9Jvu4wJB87eSh7uDZ
 +9CQ==
X-Gm-Message-State: AOJu0Yxghq+8F8kxK2lbqdMJF7YOOGKzMqhxubRCYukX8t1bjZutm8Ma
 ta1UjvP5DgXOWeXkncoSY/nLyxqpaKukPu4zKbQkTF+VMGwFzT6sfe8mM0U3dM7seypuJEzjETS
 gxVqtODW/udgA9mTGIXrW1Vaev9ick3lwfs99Dbv9+cJNIuw=
X-Gm-Gg: ASbGncvLmLw2fDcNx8uWImZPyrJnaOPuHaPs/+u4SLzPqr1Djm6wttrCDFI9JQex55f
 4qGDZSoRQb0PKLnJVfTLIN6Y6WOFGSD5XKOSBYmA=
X-Google-Smtp-Source: AGHT+IHtqdQop7muCSQDO5Qp/31PRlOoH3wO0VFoEDRU6Zm0t2avPYM0WWZDSQcw2D740Hnj64x0qqQLYGuqjgXw+DE=
X-Received: by 2002:a17:907:a4d:b0:aaf:4008:5e2d with SMTP id
 a640c23a62f3a-aaf40085f9dmr2411687766b.0.1736174335725; Mon, 06 Jan 2025
 06:38:55 -0800 (PST)
MIME-Version: 1.0
References: <20250106130405.220369-1-mchitale@ventanamicro.com>
In-Reply-To: <20250106130405.220369-1-mchitale@ventanamicro.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 6 Jan 2025 07:38:44 -0700
Message-ID: <CAFLszTgGizN_0nRfxXhUor2j7imBPdBg16NBu25cO16529-+uQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Risc-V ISA Extension Probing
To: Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: u-boot@lists.denx.de, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, 
 Tom Rini <trini@konsulko.com>, Conor Dooley <conor.dooley@microchip.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi Mayuresh,

On Mon, 6 Jan 2025 at 06:04, Mayuresh Chitale <mchitale@ventanamicro.com> wrote:
>
> This series aims to enchance the ISA probing support by porting the
> corresponding code from kernel and using it when probing for CMO
> extensions.
>
> Mayuresh Chitale (2):
>   riscv: Enhance extension probing
>   riscv: Fallback to riscv,isa
>
>  arch/riscv/cpu/cpu.c                | 600 ++++++++++++++++++++++++++--
>  arch/riscv/include/asm/cpufeature.h |  37 ++
>  arch/riscv/include/asm/hwcap.h      | 105 +++++
>  arch/riscv/lib/cache.c              |  26 +-
>  4 files changed, 710 insertions(+), 58 deletions(-)
>  create mode 100644 arch/riscv/include/asm/cpufeature.h
>  create mode 100644 arch/riscv/include/asm/hwcap.h

Somewhat related, I mentioned some time back that we have
IH_ARCH_RISCV but need to have 32- and 64-bit versions, like on ARM.

Would you have time to do that?

Regards,
Simon
