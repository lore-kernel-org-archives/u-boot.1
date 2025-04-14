Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F55C369B2
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 20:07:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 889C282102;
	Mon, 14 Apr 2025 22:07:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pqBnbw1P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 142F18214B; Mon, 14 Apr 2025 22:07:56 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D828A81F6B
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 22:07:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2cc89c59cc0so3392864fac.0
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 13:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744661272; x=1745266072; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X5+WqlDr4J36a2VSEwSSanxOn+YGg0jAMtjPZzGe95o=;
 b=pqBnbw1Pd/l4whR1AM31RWk9xRsrfIrXNb0UAiD/J6Wf3Z/G2egarGAjtduaVpBDq3
 XauRfTObuMuzj9PIthVjLrkAwmlAaZk8Ek1XPJp9X/17XdDw65NQxkbvPDqjNiO+lyda
 TLOHgR4HVAcrhVvpOOydmuHyUiM0om7J2i0sc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744661272; x=1745266072;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X5+WqlDr4J36a2VSEwSSanxOn+YGg0jAMtjPZzGe95o=;
 b=xDVYGxk5nWLJXdlmwkihnISgNxaJt5driKyPllRlMqjENkTGCb5r0K5FM/4/jJeaRm
 uvGPAUaXtbRw/Cz3z2OrmMwS9nt8zg94FNbnDrMZ6sfwSzOKtSa1YsUbuBSv2D099n/Y
 HWkGGJmFiMNr6/vTm6g0uIMR17KT9yveewgFQVJNCKK7UkmKPkxegCXmu/Du+ThLjyti
 Gkc5KNHfESbFjVIOfkZcRF/9WOwiGL9DG2RKhgh/fxb4O9gREsWfSMzkj20PLaEOk7XT
 VmjpZmaPMWqXGSUKlKPBlI35GAz5u5XAtkz2m3Mc6aY8d5rMURJYhR1iyo39rjJ7+INX
 F2RQ==
X-Gm-Message-State: AOJu0YwQW+2lDChVT0Pl4BoBwPVE/H+uxcHsmdCJgQ1b9w2fH+M12tpv
 YGljkrReFrUEY8r8vHhs3Gpnb7DdPhC5qZYVTC4xZeZLBbngU/cKKSP4OBjy6UIQfzkGhk0qS4G
 y
X-Gm-Gg: ASbGncuEioTH+TyS7dOaC/wt5rDvpjSQcs2Z0VSHMoHCvWIzAnCOsqdPUnyzJWHevV/
 IgzgbxUZ3KiobpQfztwgQPwfgbHvZfwI8dyG2Yg0n/qV+SQkhpsa9TTnhz6LAeQYdGP1j0dEN6H
 v0XukaJDTLgno0fg/6FaA2qTt27bAz7LZkmTVNBp+zJRoIuCFtyzO1p7h978ZHsD9A310TgwzZE
 aQ/sfHUg/s22N5uZNEJAZFpNQRikYVN8bngqxdAiMh9PqIDGriam6JUJ1naamG/KOiK7PO58CmL
 iWxmm6zvTxcqgkElXa9h8P2kaTlImiOv8kW90T7awYaSThoHhnx6vI40MZgi3MPSslZEPsOpESB
 R
X-Google-Smtp-Source: AGHT+IEOmj3W9pxzaw5UzDej+mWGBZ5AfEMY2yxQD3A6dZp2hs3MdpN6P7xymVPfpwefrFfBlwAZAQ==
X-Received: by 2002:a05:6871:a601:b0:2c2:4d73:ec43 with SMTP id
 586e51a60fabf-2d1da70fc82mr528734fac.15.1744661272460; 
 Mon, 14 Apr 2025 13:07:52 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d0968ea1c6sm2531169fac.5.2025.04.14.13.07.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Apr 2025 13:07:51 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <20250404135038.2134570-1-jerome.forissier@linaro.org>
References: <20250404135038.2134570-1-jerome.forissier@linaro.org>
Subject: Re: [PATCH v6 0/3] Static initcalls
Message-Id: <174466127133.517851.4201251191294861772.b4-ty@konsulko.com>
Date: Mon, 14 Apr 2025 14:07:51 -0600
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

On Fri, 04 Apr 2025 15:50:34 +0200, Jerome Forissier wrote:

> This series replaces the dynamic initcalls (with function pointers) with
> static calls, and gets rid of initcall_run_list(), init_sequence_f,
> init_sequence_f_r and init_sequence_r. This makes the code simpler and the
> binary slighlty smaller: -2281 bytes/-0.21 % with LTO enabled and -510
> bytes/-0.05 % with LTO disabled (xilinx_zynqmp_kria_defconfig).
> 
> Execution time doesn't seem to change noticeably. There is no impact on
> the SPL.
> 
> [...]

Applied to u-boot/master, thanks!

[1/3] arm: asm/system.h: mrc and mcr need .arm if __thumb2__ is not set
      commit: 6fe50e39508043f386fc1bd40bbc02b8a75c1940
[2/3] common: board: make initcalls static
      commit: 6c171f7a184cc2815b736c48aa6ac02367bbb67f
[3/3] initcall: remove initcall_run_list()
      commit: bbee3d41b33f5b8c88ae3707dc8af105acafdd55
-- 
Tom


