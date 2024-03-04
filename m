Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A129C5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 14:44:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62DE987FA5;
	Mon,  4 Mar 2024 15:44:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oBpFIN3Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAE7787FA5; Mon,  4 Mar 2024 15:44:16 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C065387EBB
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 15:44:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-68f9c01a148so22826776d6.3
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 06:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709563453; x=1710168253; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V3JIzI0Z9qrflLSiweTb00+BlWCMvti+PrbWdExKeXA=;
 b=oBpFIN3ZKyRzj7NFR34kMid1qmWkn3o7apdIxBLu4lxZHTLkPpwLhZZSj9vxIehs1H
 aaeJB5Wbgc8B1GpnN4HNUt+IObsK/qOx8J96zzhg/17XwTyqAI66WqIS/qSSXtDpBYaF
 HRG5ioURQaqH02vsp4QoMGZO0m0/MW18kWCgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709563453; x=1710168253;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V3JIzI0Z9qrflLSiweTb00+BlWCMvti+PrbWdExKeXA=;
 b=GEgr+FTY91X9h19Xl0TfbObGEiJNtnXX3uP9vrmxtAGyb2iEVubUrQnnKerK+MTMv3
 utUrXmHWrf61ev43JcU/mo+UE6777MICv9fH2dg2cgg0j2mbuLbUSZ9zeZaowqsOqBjj
 0/EwVxXK+Y3D5HNFflB2FxlrKpuj1RkDIoe2H7zLbtbKsJvudDb1/jy7cAi58A8kcDOG
 2DRsfshfV3qBhJbCrOHImdOH3vx4PImcKEtqKL3Hp8ltitS2vYdQs5HuZIfwrCBXNIwj
 pje8y4n4UK2p35R/P2zEOjlzNHwTtN7aF01fD0PO++kPag5E8aFoprietzjr64rOUh08
 VaJg==
X-Gm-Message-State: AOJu0YwcXr6qMKq4raIaXDSlVJW6kOMCXL1QLWGM8JmYeJx1Evn59Xf5
 vSCtfFmZYEMl5eKB9GpDV9U1cST5KNhfwLjP8ZzMZhV+8xjuagzt0MyQKHpF6lU=
X-Google-Smtp-Source: AGHT+IE9pF0dEkRXqxVW87G8CLVrNa7IAimnemqQPw7UNQfQaIyJupDIchKMqEjapS2b7+oDaIQh8A==
X-Received: by 2002:a05:6214:10e9:b0:68f:d852:e9c5 with SMTP id
 q9-20020a05621410e900b0068fd852e9c5mr9120076qvt.17.1709563453385; 
 Mon, 04 Mar 2024 06:44:13 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 s2-20020a0ce302000000b0068f6c496656sm5102922qvl.139.2024.03.04.06.44.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 06:44:13 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@linaro.org>
Cc: sjg@chromium.org, bb@ti.com, nm@ti.com, festevam@gmail.com, 
 n-francis@ti.com, a-nandan@ti.com
In-Reply-To: <20240304121257.3551104-1-sumit.garg@linaro.org>
References: <20240304121257.3551104-1-sumit.garg@linaro.org>
Subject: Re: [PATCH v4] Makefile: remove hardcoded device tree source directory
Message-Id: <170956345258.1989490.4554941764252889081.b4-ty@konsulko.com>
Date: Mon, 04 Mar 2024 09:44:12 -0500
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

On Mon, 04 Mar 2024 17:42:57 +0530, Sumit Garg wrote:

> Some boards that choose to utilize the OF_UPSTREAM directory for their
> device tree files will need to specify that directory instead of the
> traditional arch/$(ARCH)/dts/* path.
> 
> Include the correct path to the board's dtbs depending on if OF_UPSTREAM
> is selected or not.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


