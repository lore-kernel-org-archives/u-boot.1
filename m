Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46675D74948
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 22:28:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CDF689003;
	Tue, 29 Oct 2024 23:28:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F36RtAPL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33950891A3; Tue, 29 Oct 2024 23:28:18 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26DE387BF4
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 23:28:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7b152a23e9aso455772185a.0
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 15:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730240895; x=1730845695; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pRSbd+x54XEvikmZ7MsqaVWLEMuKNAAOZM8ppvxMZMY=;
 b=F36RtAPLpZIE9rhstoETQzFgQ5zR2Ao34v8tRB/Z9J/GuxJvoyyKEq91QHPvNV1OBd
 JRw0TsxjudaMOtuzA9gC442W4Tf+N8VO/+Xp4m2yrn/ppFAfafP6QhUdCvhFhF4X9JVt
 Z2fqeJv0miZ20C8CPGSIzPKGzYjqJZw3Yb7wc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730240895; x=1730845695;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pRSbd+x54XEvikmZ7MsqaVWLEMuKNAAOZM8ppvxMZMY=;
 b=QhQrso/N7wdtSCbjdVo985hpMYGfosPVm3SBog8bnLYoVyVBHre7+NkJMzfigV8pSe
 paSO640UjJcAUN+a2mmlzVgsodqD4WT7nP/ANz+3YZ1zD21Wo9XqIqcp2txCeCd6OYTY
 D/582/lJvaSDYJEWnnqwNTmfP7OtNCH3vcfEDXSm/zGUgmAPFrBP8cRMlhb3JZpTnlAI
 rAfEJBpiHmYIe6Tp2UhcVCgelpzULUvS8m8NLkN9FCDjz84qrvwOyXvmLymy5x4RnhKU
 TlgfiZFypbmM5KlfuAEJGQpvHh9HasTueDHuVmrihRSk625jRbflXdDCaHcS1waYFpQq
 7ZJA==
X-Gm-Message-State: AOJu0YxPNeF4JYDDuwMJebiX/s5De6/VcA7+U3sweq05DNFaOOiXjtSc
 tSkibxxMmZJps7cIqncCKA2OP9sE/xfWDXlke5yVKws5LmhtHOJWL5HkOBkwBSU=
X-Google-Smtp-Source: AGHT+IEqPUK6wrQ39S9A51CgFio6mB9j5L0qDXL94NXF6TylE+Mz4L6uxRJDsK0t2Si08dSYuJ70Bg==
X-Received: by 2002:a05:620a:1a02:b0:7a9:b250:d57b with SMTP id
 af79cd13be357-7b193ee15fcmr1944308785a.5.1730240894985; 
 Tue, 29 Oct 2024 15:28:14 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d3480d7sm459351285a.123.2024.10.29.15.28.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 15:28:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>, 
 Alexander Dahl <ada@thorsis.com>
In-Reply-To: <20241015-dm-debug-less-verbose-v1-1-366e8f00b556@cherry.de>
References: <20241015-dm-debug-less-verbose-v1-1-366e8f00b556@cherry.de>
Subject: Re: [PATCH] dm: core: downgrade some dm_warn messages to log_debug()
Message-Id: <173024089379.2563570.4119777655247715609.b4-ty@konsulko.com>
Date: Tue, 29 Oct 2024 16:28:13 -0600
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

On Tue, 15 Oct 2024 16:32:14 +0200, Quentin Schulz wrote:

> People complained that enabling (SPL_)DM_WARN was now totally unusable
> due to the amount of messages printed on the console.
> 
> Let's downgrade the log level of some messages that are clearly not on
> the error path.
> 
> Note that there's one pr_debug in there, because it is followed by
> pr_cont so it made sense to reuse the same family of functions.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


