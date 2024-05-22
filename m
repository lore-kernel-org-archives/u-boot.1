Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 054FAC25B74
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 00:17:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D9A388441;
	Wed, 22 May 2024 02:17:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iE7LslQF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8005488441; Wed, 22 May 2024 02:17:47 +0200 (CEST)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7159288335
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 02:17:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-792b8d30075so366551685a.1
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 17:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716337064; x=1716941864; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aByHzrbbP9VdhmqgahArQoJQx1fnsN0uwpVFR7NAlrA=;
 b=iE7LslQFamwU3OnoSTGaIH1/Zc1PWly9KtNzBK4cAGmPgVkd9B+q0et4aPmFKver2b
 3mqm2IVcFZzsRm87Rykyp0BeF5mBN4S3JSCMK0x/JPWtTjDcLyKeFPeYC3g+75Wqg2YH
 v6cSKpS35goEYpwXtqv7G7nqyTYy5LZd75M9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716337064; x=1716941864;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aByHzrbbP9VdhmqgahArQoJQx1fnsN0uwpVFR7NAlrA=;
 b=EPTDVUdLJ+t63mMs1mIPLteaB0M5HsOfpz9mU0UQ+xF1DtGLxiM4/9XEmnAVyXOmWL
 kLF+N1ZcZas+ItMXfxpurV7vg80KUG8Hy0piZ73yAjjH5TP5fm5lqMJF5vj6fZta2Vhz
 q7/+6hQEh9iyKY4N0uCIr+MFDQcPN4lIMyCP+1KmlpZHl6IjWpRg+w6RRMCazpMHnDgS
 7AGtsGsoJxIwHXEPnAOrjXivnf1Gqjbh44FzBIalIdpoCNmnv3iMC4Ml6dFSESfp26Of
 nd/PSQlZpLrho3fzLFDt46eptydHpfBNPMnSN7Ze0Dmgfh/f/k05Mf5Ub8Sc+E6m28a4
 ECJA==
X-Gm-Message-State: AOJu0YzeuknJqT7ZQtq+XM9NdfPFc76zsAYm6Ntvf9UlgW6MDf5DrouT
 U4Are82bE5ZHTRmWFHb5ZAjcCg2xXIfk+SqtiL6fa7RNNFw1ZzzaA37CYxPJhDRyYhNdPcqBRcN
 u
X-Google-Smtp-Source: AGHT+IGfACik5cuhdy1Obkkxk+8bJDH3Fffkkl/OIGdlFAqqeM0tYzWN5uvsR9QCTVo3rkrqMf218A==
X-Received: by 2002:a05:620a:294b:b0:793:116:55f0 with SMTP id
 af79cd13be357-794994424cemr71498685a.26.1716337064126; 
 Tue, 21 May 2024 17:17:44 -0700 (PDT)
Received: from [127.0.1.1] ([189.178.170.52]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792ff89358asm670250385a.50.2024.05.21.17.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 17:17:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20240515073612.1511149-1-rasmus.villemoes@prevas.dk>
References: <20240515073612.1511149-1-rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH 0/2] scripts/setlocalversion sync with linux 6.9
Message-Id: <171633706301.1865062.11498265331779113962.b4-ty@konsulko.com>
Date: Tue, 21 May 2024 18:17:43 -0600
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

On Wed, 15 May 2024 09:36:10 +0200, Rasmus Villemoes wrote:

> The first commit is trivial cleanup. The second syncs
> scripts/setlocalversion with linux 6.9, with just a one-line change on
> top to account for a Kbuild change that U-Boot has not yet adopted.
> 
> Rasmus Villemoes (2):
>   Makefile: refactor ubootrelease target
>   scripts/setlocalversion: sync with linux v6.9
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


