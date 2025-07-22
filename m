Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F4DBC83F1A
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 21:48:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57E0083444;
	Tue, 22 Jul 2025 23:48:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZB9I+x7i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04A848339C; Tue, 22 Jul 2025 23:48:43 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E22BD83438
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 23:48:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-615eb598b0fso1084769eaf.2
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 14:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753220919; x=1753825719; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GyxyfaF0jBaZ4Eez14o0OcDVeyaOmCv1Ekmi7o4lx3g=;
 b=ZB9I+x7ibYQOi4l3FArpEKFh/8HfVr4PJqgkXKecZiUsZfssFSYonnQLNRuwIvN317
 UCR184zdpwuH/dOqXm4x0Rkm7z1jPy+dgn0EnX2MZjpSizmgYSH68jf0LnB42Yx4By96
 9B/4OMaDOnVSKJcdPZYZqwTHysg2yMRoCq9JU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753220919; x=1753825719;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GyxyfaF0jBaZ4Eez14o0OcDVeyaOmCv1Ekmi7o4lx3g=;
 b=CBuRaQLp3JqyZJ/ghgLlcUXxWh3ynXxv/R7S8bmJMKUmvqq1vOCgcQ3/o6bGeCui/G
 rVbPiaQHdjBwcC1FqtM1nuB/6LByRTn5g1Dq19ERShOl2FJYN09MUhG73w3+CeNN3YFL
 3kasHHij9awfvmHRE/WV9lFMonViEM2p9blYRwzy9R+JI92SrPyLMnoMUsQIzcNc+XSh
 DpYKxzxTaxg06FUH24XycxxiYNxTfE2lssD5ygz0DqZ/aBGLpQ67y/hP3F7ASkreOxc2
 IpcWE6z690XHCBhIgyscm3qnxgTjppba+nIudeLzTm6dc9Q+15Gf9Algkok0VbI3SpDw
 VWNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfCWSk3FEQQwpEffPk8UjiPtk8fPswOb3hlmcRlpJP5RLo606Tyx6Z1s9IRcsfW4WFHQT8n2w=@lists.denx.de
X-Gm-Message-State: AOJu0YysUIqfCAj1GBmbvne/HJTwtBocgpGk1mU9EuAd9FEJu8sCx4H4
 jQMaJ+Qddx7XcrP0DMFSYVYh5b92+5G/cY8FSMpnZLIDw2jhP9r2XjVVbZdYkFQa06A=
X-Gm-Gg: ASbGncv6HqnbXqOAxipKqAyrUXpa2yrh/QC7ZAW372sQLeCk4zIabuVWwGEsi2xMfCn
 AqQPPGTAbhZB4NyrrToEXmIRpD/08h0elAEp5BUXm2BkQ51W7f1qdoRsqK3lXXRCOgZrqdW30ty
 TxEdqMa7cPe+PwzoSh1SqxQjBkW+uUxPctEG+6pKPnzx7CXCAv/HrK+7Fw2Yx+V4xxIzsoMw140
 bleBJa23uetkyEuvFZrlCq3nWD88Qyf/pEvPFqAHmtdUYxocvjXbtlVRqfkRrcubqZhGit3HfWZ
 Y1pk6UAAsgOfGiskPdTi+UO4tZnL4E+PlgVh1m0H0sgLDzwBP8s1jgQVeSchSEkEHmOD2JmwuhD
 OvVS9/VmCiNQrH+AuW0WAoKKKbyKUyRMEUJUlJWNFrnyBJBaEDBwAwUI=
X-Google-Smtp-Source: AGHT+IFvbwXOtRreM1HNnPSNmeVtJQrsQ4jgqoNyaIFewpGGcWPOnZP09BSd+1CvaVpGDOMPEGvT7Q==
X-Received: by 2002:a4a:ee19:0:b0:615:b219:bfd9 with SMTP id
 006d021491bc7-6187d8f5f15mr419747eaf.6.1753220919586; 
 Tue, 22 Jul 2025 14:48:39 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-615bcdbbcdfsm2248906eaf.31.2025.07.22.14.48.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 14:48:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Wadim Egorov <w.egorov@phytec.de>, 
 Martin Schwan <m.schwan@phytec.de>
Cc: Leonard Anderweit <l.anderweit@phytec.de>, u-boot@lists.denx.de
In-Reply-To: <20250714-wip-bootmeth-rauc-fixes-v1-0-69d2b80e7606@phytec.de>
References: <20250714-wip-bootmeth-rauc-fixes-v1-0-69d2b80e7606@phytec.de>
Subject: Re: [PATCH 0/3] bootstd: rauc: Small fixes
Message-Id: <175322091862.89342.4001102443533044677.b4-ty@konsulko.com>
Date: Tue, 22 Jul 2025 15:48:38 -0600
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

On Mon, 14 Jul 2025 15:30:07 +0200, Martin Schwan wrote:

> Fix some small bugs that I noticed during testing.
> 
> 

Applied to u-boot/master, thanks!

[1/3] bootstd: rauc: Fix potential memory leak
      commit: a7d1214d2c9a38af3a9a1271dd8388068cba904c
[2/3] bootstd: rauc: Fix segfault occurring during private struct access
      commit: 84cef694e73cc820fbc7131b1a25b79e17bec609
[3/3] bootstd: rauc: Only scan all partitions instead of boot files
      commit: f271b0627001b444e00b8379a069ce8d8860490e
-- 
Tom


