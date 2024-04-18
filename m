Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB98C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 03:40:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB6D48857A;
	Thu, 18 Apr 2024 05:40:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="B//8Gs1m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 344FA8856C; Thu, 18 Apr 2024 05:40:17 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4246B884F1
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 05:40:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-78f02298dc6so39626385a.1
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 20:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713411610; x=1714016410; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2+NJTZF7YAz6jrCurXtglE/2h0Ovk80GRHTaHsqBFrw=;
 b=B//8Gs1mIXS+oEwKS0u7JzhgYpByaMtcZ81eZi9zfaOpj5xOk876XPf+nZVlm9K7+M
 6dhL6+jpVakhwR/0CWeospJ6gEDZ4firYFvhn3PXUEfgh2YeVSeAV9apeWslB+hLT2T/
 Qt3udseCrJGV5fnkA8h4aEN8/EEFMGkC4+NXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713411610; x=1714016410;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2+NJTZF7YAz6jrCurXtglE/2h0Ovk80GRHTaHsqBFrw=;
 b=SKVL2NYS057hahLyMcOR0zNF7gmolp2s26jllXmQdBj/wuwlB5DW6DxnoByIKwksNZ
 uDcN7tFhDpn/swBy8tEPrILtz0JygCsp76F3xLSwFryqL+I9zYrZTyrNEgQnZhRuyFDt
 OJXQ60T1HupkWhECos/tgRxY3CYky1hPWUWNIiyoL/AaBn2gqJXM+lXvDG5NhbaglM5c
 Q0Vhc5i5YCT3gsPkiz0MDbhqjHEcOPlErNXrRQxKxmVluLaOb4OUwxvjqdKCQCJDk9tc
 FwXce0pkoQvpjSP5NmpAo8hx8J9725PSHKY8J+6W7/nSw3P5nuYGce6iZDQT2YNELkdr
 GU7Q==
X-Gm-Message-State: AOJu0YzfgN/hI1vHDmmIyCgBiPp3CJbUBjMTp9n9w0E21S3G7zkHS0YZ
 qQa7MRNaiarVit3KNT4L3QFoyGcAMp7s2qskqtm4o6nm2a+fx7bSMFs+sGaZwYA=
X-Google-Smtp-Source: AGHT+IGYMBtC7/AA6RSus4t42umB1gqkgSac/ZNveGa7QYz2qgOS0LGAnXdLn+egKRQiwLsqz/dvZw==
X-Received: by 2002:a05:620a:24c8:b0:78e:f284:dcde with SMTP id
 m8-20020a05620a24c800b0078ef284dcdemr1752653qkn.22.1713411609993; 
 Wed, 17 Apr 2024 20:40:09 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 du33-20020a05620a47e100b0078d68b23254sm259041qkb.107.2024.04.17.20.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Apr 2024 20:40:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Jonathan Humphreys <j-humphreys@ti.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240408212843.95871-1-j-humphreys@ti.com>
References: <20240408212843.95871-1-j-humphreys@ti.com>
Subject: Re: [PATCH] Makefile.lib: find capsule ESL dtsi file with
 CONFIG_OF_UPSTREAM
Message-Id: <171341160868.1250683.16300671487202978592.b4-ty@konsulko.com>
Date: Wed, 17 Apr 2024 21:40:08 -0600
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

On Mon, 08 Apr 2024 16:28:43 -0500, Jonathan Humphreys wrote:

> When CONFIG_OF_UPSTREAM is enabled, DTS files are in SOC subdirectories (vs the
> top level dts directory), but when CONFIG_EFI_CAPSULE_AUTHENTICATE is enabled,
> the dynamically created dtsi file containing the capsule ESL DT node is in the
> parent directory. This results in a build failure because the #include inserted
> in the DTS file is local to the current directory.  Update Makefile to have the
> DT preprocessing of #includes search in the parent (dts top level) directory
> too.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


