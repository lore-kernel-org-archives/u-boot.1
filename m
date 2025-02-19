Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3744C021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 02:05:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F055C80F56;
	Wed, 19 Feb 2025 03:05:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="m6Vp+X3X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B67CB80F67; Wed, 19 Feb 2025 03:04:54 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5455580EC0
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 03:04:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-220e83d65e5so98951675ad.1
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 18:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739930691; x=1740535491; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IQamPel1OrfzNkCTQ2gl+x6Dc+k2Bkq4JSShGpojLRo=;
 b=m6Vp+X3XxKKFRSHgeKqs2/47YtUDLXoPqZVlPn2CFYSe3fJoKHnH8OutT9NDCiNYOy
 lzuHQkZtY6qV5RG4IDnsbmbe1qBkjez5ESbCmuGQEliqW81MnW31Bf3k8DMu3N2PI7NQ
 Pk5jr/YAvIHRRTVws2CCMHX/xA8DSD6xtgCIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739930691; x=1740535491;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IQamPel1OrfzNkCTQ2gl+x6Dc+k2Bkq4JSShGpojLRo=;
 b=eUQgzOzNLKITdo/nWGgSTvQBqVoFKg27Ai2uDtAXadbqw5T1kWRpl13CyiZscm8nOp
 EYScYEcrJjASpMHL6ucOmQu77dH0t9fRb06jwpFh8rrvJYnoA4H8cvQlgwrhf97f9wgx
 Jg1kmFGeRxzV2l2KRal4o1TtwaZS87Sv1amJHwRqlrEs/X+SUtVLRjdAtouo9AbonRxo
 ibS8SUqQ211rHtVeyHqkLd64PLwG87Bda0SrKDT7X/K/MASRyaYmuOVZyFazMIkzu8+O
 W+yhgwYW9HqOWUjAMmnSD9AIQMCm8Jt8mhj8I/GB+AjOOasSsjqWj4RZ+eOo9BAYFjCA
 bgIw==
X-Gm-Message-State: AOJu0YzriWBvByltjj1SflTqMhc+OUIfhAKmBiUjxY6UKhIJLJ/8jTfa
 VLblAoIxe4S//aNd4hrtm9YrXVWArFL7z0UZOfEHV0xYdTgiu0rZNKnZ6xonwqY=
X-Gm-Gg: ASbGncuXw5BLwyoBPmTMiz7MKxDrYWUWA3BlFfCw3khdOlKdOYLZEOGyqe/m4bTCFD3
 qn3tfG37AMTlpYvz8PqBATAtxjjXnJ59VQlNV2gi8McfVp/J71qcG7W79SEv14hPibVqQri8AEs
 SIZN+C0OXLpckWx2RqE229gaS/DvuIc9nPoIaYi2WMx11aI9V9TRaeFld7m/JuBvDamgTvIjeaB
 mYNPvbitt81QVJtQT202Xt9fEFSL8pyJQSsWxtrs2BOBlL2auTJOntryFxr8PstvwFoNJUz+eHe
 OC5/J1+XCXCT
X-Google-Smtp-Source: AGHT+IEJ679YiNGXgabupfZo35i/T8RkEaexYzl7V0g6Jw6E3LNAxgdr3LP+GkkDlrxbosH99T5lfA==
X-Received: by 2002:a05:6a21:788c:b0:1ee:c7c8:c9d with SMTP id
 adf61e73a8af0-1eed4e3f2f8mr3029880637.4.1739930690849; 
 Tue, 18 Feb 2025 18:04:50 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ade1c7a675asm6365064a12.48.2025.02.18.18.04.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 18:04:50 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: francesco.dolcini@toradex.com, s-k6@ti.com, w.egorov@phytec.de, 
 n-francis@ti.com, Stefan Eichenberger <eichest@gmail.com>
Cc: u-boot@lists.denx.de, 
 Stefan Eichenberger <stefan.eichenberger@toradex.com>
In-Reply-To: <20250210072834.9135-1-eichest@gmail.com>
References: <20250210072834.9135-1-eichest@gmail.com>
Subject: Re: [PATCH v1] board: verdin-am62: add dram_init_banksize
Message-Id: <173993068966.1662848.15295577849807842145.b4-ty@konsulko.com>
Date: Tue, 18 Feb 2025 20:04:49 -0600
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

On Mon, 10 Feb 2025 08:27:47 +0100, Stefan Eichenberger wrote:

> Add the dram_init_banksize function to the board file to properly set
> DRAM memory sizes during boot.
> 
> The commit bc07851897bd ("board: ti: Pull redundant DDR functions to a
> common location and Fixup DDR size when ECC is enabled") relocated the
> dram_init_banksize function from architecture specific initialization to
> the TI board initialization code. As a result, boards relying on the
> previous setup now require this function to be defined within their
> board file to handle DRAM sizing correctly.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


