Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8415CF9C71
	for <u-boot@archiver.kernel.org>; Tue, 24 Sep 2024 23:41:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46F1388995;
	Wed, 25 Sep 2024 01:41:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uhDLBx+Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9A4088B89; Wed, 25 Sep 2024 01:41:03 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF28C88995
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 01:40:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7a9a23fc16fso644999385a.2
 for <u-boot@lists.denx.de>; Tue, 24 Sep 2024 16:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727221242; x=1727826042; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4OhjIoweVa10pV8yJPTuPPySddcuJ2n8hvuqgSxUzWk=;
 b=uhDLBx+Q/7ISQQcvv6b+KdN0iQ1Dz+AA/p64YbeLJ7JhXpAag/i5DduNDRhoI5dFFc
 coIoKmPyf7ddH9lX0OESvITJjsruf5SSWdl9mfPW446kEZW1xkHtxAJf46zW/6ADdLdb
 JJnJ4Fhq7tn8mQ9IJAmEbdzo6byS+n9cYFJMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727221242; x=1727826042;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4OhjIoweVa10pV8yJPTuPPySddcuJ2n8hvuqgSxUzWk=;
 b=FO76E5+LVL2kD/wSDK8SN1z1kQhYdKWTHYCYJkWfqkTxbH4uQgADMxBgPJ4nmHcaEw
 gVaW+VDdpwhxUwCF5tzW75ix4JMs6OgDTUQarMcXfIX4sirRK76b2zrPx7xA+LLMJZbI
 ak+ZWjfbw569Tuuamip2zP6PWbL1tSWNtJEr8vKtGMCrcy3Vr21H3f7dy8ZKqkPT86O9
 o4mSS1v4F9pm06DuPxM/fOutJTaoCrDrMo+TwvYEZKud5a8d2/cfxRptqHbxn8oIjxA+
 UPkSo/mouwaiJVv6c5PSGLq7wdX4JgZc1mw/kOF6xdA1jKgVXOPRdFrfz30cgJompzAJ
 n9dA==
X-Gm-Message-State: AOJu0Ywv7z9gChv/UDU66kkojN/r4OLcVpxzulQU8us0XYu9HtAbUUId
 /nEIMsgJNz0HZhdQuyblfsmry2WmTCy1XJ/ePpTfHhcahoYso/AEiTd1l8LR4eM=
X-Google-Smtp-Source: AGHT+IH1bMwVuf8Q13LRujMBAtwS98ToI8YrAMjMYlz6+XD0EE/mFrr/Nbv7raNTHkvT4YvFzc4mOA==
X-Received: by 2002:a05:620a:4005:b0:7a9:b839:1e87 with SMTP id
 af79cd13be357-7ace741361fmr148586985a.39.1727221242578; 
 Tue, 24 Sep 2024 16:40:42 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45b5257698esm11147141cf.26.2024.09.24.16.40.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 16:40:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Marek Vasut <marex@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Lukas Funke <lukas.funke@weidmueller.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
In-Reply-To: <20240910130019.3211647-1-jerome.forissier@linaro.org>
References: <20240910130019.3211647-1-jerome.forissier@linaro.org>
Subject: Re: [PATCH v2] spl: ram: hide SPL_RAM_SUPPORT
Message-Id: <172722123988.127252.13444418981332836063.b4-ty@konsulko.com>
Date: Tue, 24 Sep 2024 17:40:39 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Tue, 10 Sep 2024 15:00:18 +0200, Jerome Forissier wrote:

> Make SPL_RAM_SUPPORT a hidden Kconfig symbol, automatically selected
> by SPL_RAM_DEVICE or SPL_DFU. Avoids the situation where SPL_RAM_SUPPORT
> may be enabled without the other two being enabled, which results in the
> following build warning:
> 
> common/spl/spl_ram.c:19:14: warning: ‘spl_ram_load_read’ defined but not used [-Wunused-function]
>    19 | static ulong spl_ram_load_read(struct spl_load_info *load, ulong sector,
>       |              ^~~~~~~~~~~~~~~~~
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


