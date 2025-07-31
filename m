Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1AD9C87FCC
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 16:05:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7181C800C1;
	Thu, 31 Jul 2025 18:05:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XHke33T+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 095CE838EF; Thu, 31 Jul 2025 18:05:12 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AFA18383A
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 18:05:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-30063371404so289675fac.1
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 09:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753977907; x=1754582707; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S6NfXYV2/df1XSXgKQ4+ofzOqIkwKBIw2vTlP/1asQE=;
 b=XHke33T+R1UbDeWLym4KmoNx8LsUtgUR+bAO21CtRnMFlknZhlaIxrHvacIYLtPKLy
 Nh0h0u9UNmkmCayuWbk5Ub/ICn73iYfIa7uYuIfMEP6D+uHFEKwBBnNiFBeHm8obAAp8
 kWPzVKwIby7976ETB0UfrwHG1HRKk/Jt8QJLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753977907; x=1754582707;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S6NfXYV2/df1XSXgKQ4+ofzOqIkwKBIw2vTlP/1asQE=;
 b=wlzRpS/rOCK9J3VwB/yPwU0V7wDkdJmUei6IKt5gJYYOOv/ZD3soH2MF03J/WxZJkl
 2Geyd5UDfqXDqrF4LMqyVIAjJxD1MEJ7xdnkliCL2TbFdX716YclREJ0atLDi+07fFJy
 YxziRnkA8veS6SPDnfYGkX2KL1Hri4+orlJxIc2/N9gQdy9EEqEIjTxtpJ+zHRwSU8ku
 yNfPQapGIi6Cd9C9x8suNWEDuTcI7Chr6uerr/YopeirJGpumdDiS6ElNJdSKvprfruu
 E6dH9He49wwefjYdDmQDCyf06rh99VEP++v4Hk6cZgs+tUK68gLZLlvW2owZ+XfVgToV
 V80A==
X-Gm-Message-State: AOJu0Yx1+W6Y/1or375ms5SRzj3QsIhy2v/y9r/yngBH80XDGLAOmAd3
 H9AT3Zkvr5dt/ye7+MlZLfwpqFKe9kGV8X/Ij9ypCiHL8lh9lytWys+9sHZakPApGvvksjIrax+
 OnpMyRcA=
X-Gm-Gg: ASbGnctMcqI/K2Z82KcJeVjW6nytFuskTjbnfMLki+KXVhlcVhJLZ+pxpVa5FQLuXou
 UQI4uHy9XbinusDeKl4EFHhMjuH+ExCP6u9uLwrIAU8oj9RjUzwHMOPFmnjSIvGvJrv5xHxxwsz
 HYM/+rS6YKuX4aI6KBcwI4wIk7wwqwqIvgjB+khGSHFv6P0JF3HnzfKbWA8QHnlKqkPN7tq8dGl
 8O5uuDuvKDMLtCpPxiW4ClxK77IRb289zRauoc9nj0NCkyFYp2QKUimT/0EYmPc1P3xFKx5lJQH
 3eGWYo2REgDvBtO8tidyOKD+Gb/v2FUQexp/QJ5unI84KueH2vwqO3ECzNO3kCw0bE7q2iOjcaO
 P7Nt90+fvksiTkNaifC1hetz/uFYEs326HkJ4LpWR3s4Xfg7BMYwVwxk=
X-Google-Smtp-Source: AGHT+IHE4nnphvpPMJ9HLigyV5szTD11VDok+/4vnL9B0cBzWDZCYVv87hFwRnUfHdMyqctwOFarEw==
X-Received: by 2002:a05:687c:2f8a:b0:2ff:8852:da88 with SMTP id
 586e51a60fabf-30785c8b1a4mr4710795fac.18.1753977906478; 
 Thu, 31 Jul 2025 09:05:06 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-307a739b349sm441312fac.22.2025.07.31.09.05.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 09:05:05 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: Alice Guo <alice.guo@nxp.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Cheick Traore <cheick.traore@foss.st.com>, Marek Vasut <marex@denx.de>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <dd84eff8-cbc6-4ae5-b19c-0ae52f09e363@foss.st.com>
References: <dd84eff8-cbc6-4ae5-b19c-0ae52f09e363@foss.st.com>
Subject: Re: [PULL] Pull request for u-boot master / v2025.10 =
 u-boot-stm32-20250731
Message-Id: <175397790503.3826277.16367529589821429028.b4-ty@konsulko.com>
Date: Thu, 31 Jul 2025 10:05:05 -0600
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

On Thu, 31 Jul 2025 13:53:35 +0200, Patrice CHOTARD wrote:

> Please pull the STM32 related patches for u-boot/master, v2025.10 = u-boot-stm32-20250731
> 
> CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/27236
> 
> Thanks
> Patrice
> 
> The following changes since commit 182cb30084516c3085d2ca5dde3f105f7625d774:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


