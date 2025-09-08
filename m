Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F679CAC581
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 16:18:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DD6F82AE9;
	Mon,  8 Sep 2025 18:18:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HefIfMr0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0205283071; Mon,  8 Sep 2025 18:18:16 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C90F809A5
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 18:18:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-30ccea8f43cso4144361fac.1
 for <u-boot@lists.denx.de>; Mon, 08 Sep 2025 09:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757348292; x=1757953092; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4GviYdqXgYaNy3wDVBgW/NxgsmsXBiYvsWthq8IZLFg=;
 b=HefIfMr0ZaVgAcIE9sC0K/EJ1FB80i+JFnxPN7AdBVhCBfqAuSRMbCCqiqUn788Ujs
 BRBcmVStOsfTd5MynKqO8N+vXyN2azlXw5v56lF6WlCkapPWJhQme90we8bFOHC6cmse
 NMrB2o1wCF0spmTn8ocny5GqbKavX4/PCpafY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757348292; x=1757953092;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4GviYdqXgYaNy3wDVBgW/NxgsmsXBiYvsWthq8IZLFg=;
 b=CWJ76OQAzcwB9f5BS/ls3aidG+3lrHPS2vMSfXjY/OKY2cR9PkXFhhYEWLjMkIWdk3
 ZKJzK9rAiWXvBF8WHiAZeHMC7qPlIqnDXqWKbrXGfrKypEQCTS1ckZOA2gPmW7HzyjvG
 Os2VyF0UDvK4rvACs1a9VRM23Ppxn+rcuDltmwiNuwn+u+G7N0UWT9yalFVvRSuxwBlH
 m2vJRNUMBxB43glaChiWxSWomoe7MPRm4tPQrjCVT52siI5eRdaqEn2NAlir09djlBbg
 jR+XskqkUc+y0vBi9XrJtGQgd0tXhO5Cmo2wP0wWe6px4fhMMnHoW9Pkb5BSXBDXUo6M
 ZnvQ==
X-Gm-Message-State: AOJu0YxMCXckUAfyCrDJpMqcU3Ghnhxc4K/F1XcHd9bCAhiz3CiFxnn0
 khFvM0QXgOnGPsf8jtlRYnuE8u9r5KkHH2R0Ze5/SJxdbpDaSQnwPuO/3KgirueevnU=
X-Gm-Gg: ASbGncv/0ta0Spkbg4wzB99UR+qxNg24rC6kHo4+m7P+QW+ugCfFW3KbkyABQ+aI/ak
 557uP45/SVd7Ed7vPyBpJHvSotd/j4j3qzthRBy/WcFF3zKkDWFK42LbhjgLn37TsUvSAkDlpyO
 agYbHouSv5MLT8r4QxfTgu5qfn9TPcBQ4tKHvPx1d3cu/I8fbys6faDB7KigHL6Q0COOmRsSJMZ
 977hTEsFfVxceOSxUEss/3pTELzCGiwkyHsmVdnvzYsEtOAMz6rSuI4WLcSgo/ZFy3YR0YWn6Rc
 ZokjAWGRt4XP2bnjdYryaQztFIFf9GxlcBKuJODCjQou3gCaILd5o/bIhkirxt8ro/zZU2365cR
 nYN2UtwJWvKcp5Nmy7D+mpPXMTcCBfKeTDg9+dJ/xjTVkT1QeDsfvMbHFJOtsoLpTPQ==
X-Google-Smtp-Source: AGHT+IGQF8jcy8t9AgeO7o0Sny1pMo9f/JwOOs5D+ux7Z5VzhgYHoV6+HCnmnaJNuhL0OBJnpqd53Q==
X-Received: by 2002:a05:6871:a688:b0:31d:8cea:e9b8 with SMTP id
 586e51a60fabf-31f57927a28mr6213564fac.21.1757348291998; 
 Mon, 08 Sep 2025 09:18:11 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-31d87e05270sm4597371fac.28.2025.09.08.09.18.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 09:18:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250907202229.385685-1-marek.vasut+renesas@mailbox.org>
References: <20250907202229.385685-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PULL] u-boot-sh/master
Message-Id: <175734829118.1435428.16538092920308023704.b4-ty@konsulko.com>
Date: Mon, 08 Sep 2025 10:18:11 -0600
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

On Sun, 07 Sep 2025 22:21:57 +0200, Marek Vasut wrote:

> Trivial last minute fix ups.
> 
> The following changes since commit 328747974a0620d0996113fe2b3906b06e96de00:
> 
>   Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-samsung (2025-09-05 08:15:16 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


