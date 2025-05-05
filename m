Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9090C3ABB6
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 23:36:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0296782A65;
	Tue,  6 May 2025 01:35:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IVLhJu+x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D138F82A2F; Tue,  6 May 2025 01:35:34 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB75780079
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 01:35:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2db2f23f174so376902fac.2
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 16:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746488131; x=1747092931; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z20rDULBWdPylzWNYe0aNxK7JbjNYoaYQ65mjSzRe3E=;
 b=IVLhJu+x88njsNUepLwfKGB5IhWWrw0JDcWNCrkBBVc5R5+USaLip1V4sy+owOptJc
 HoMiHwXZezjC0zieN3cw/IP6TP0F9DCrFQVQweL/paaBlS1Nk1XbbJtfAOZLVs21zNeT
 wrGEkMWlCVmQ7DzZvyBMfxKUQ3yybQIYhja6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746488131; x=1747092931;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z20rDULBWdPylzWNYe0aNxK7JbjNYoaYQ65mjSzRe3E=;
 b=FgG+bZQpcbDgp5Ud5qv9qOIVylRk9bamjXOacyMMZ0MzEH8ZgmcufC8RGDv9ifSLWI
 m5zo1+97B7qCgdD+oNI0JNcFcS0zaXFl8hHxj60veLMSCVS1wlYkKEfe1J+H6rfmXZpc
 8lP3Huip4sgcGBhpDnoaG0X3mzWUgCSonerk9XKai1VBffyUNnxGlSc2+2EbAnpd9a/t
 xgHW/jr8hwMohyLsPw0BrB6LUmTQs+OK2CH5Xl8p8lE2HspX7KmKsyLiN+qdAjoRA33i
 fFfAXWrWWOtEhxRrYUB9SdLtfAEnc2VUyn0cLO+IiAi5Vqm8iZR54mAv7NMqLMx4j0ot
 F+uA==
X-Gm-Message-State: AOJu0YxL3+B6qY9uqPLsaFoE81r1FIUn1GUeEY4P53+rWi7ZIH45vzsI
 SeTPZZ/b7aJsGbmk14gpNMI/MMpCpneq1z/gMQNIJefL6aWKZ2U5wJ25UK8/9yQ=
X-Gm-Gg: ASbGncu+kp02J55h6jYMMt90l4Mk8r6DVYXbW0cqDfjGtfqhYmH1+ngSP7amMrn7Cgi
 uMr10q9A3x8zg/By5L/ofnRr8PVmQZ0HIdMuBD1ozGWXFCZjdP+Tu6elPYZZ00EoxGjgHI+L4S1
 pqb//tFCEA+hK9b1YPK1jODJCxBsFuQnERtriouNfyO2y+++XUmpVGR8Y6tCBv79slATlUFN2k1
 x5CsXmQSCPsVh7F8B2MO6U4QH1a7bJXmk8mtpBq4MnOBRXKfDHrxHDEIokVt3D9OVQhLS2fpd2F
 DlJfPfJvLPzmcauqfHjMaPhAAMTP1iaAt222gVMeidjgdWKz8mLEcBvf3kRg3urfjAnRPFn3ro+
 D
X-Google-Smtp-Source: AGHT+IEZ0Nj1j2za/Ai4Vfk8VXp02TGICaZoMq0SVrz96wwrPjlPjCtyiDML/oCoM9Ghlur/QCpLSw==
X-Received: by 2002:a05:6870:b01f:b0:297:24ad:402f with SMTP id
 586e51a60fabf-2db3cd86c27mr416758fac.12.1746488131432; 
 Mon, 05 May 2025 16:35:31 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-607e7fe85a4sm1913408eaf.39.2025.05.05.16.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:35:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Anton Blanchard <antonb@tenstorrent.com>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Christian Marangi <ansuelsmth@gmail.com>, Andrew Davis <afd@ti.com>, 
 Nishanth Menon <nm@ti.com>, Yao Zi <ziyao@disroot.org>
Cc: u-boot@lists.denx.de, Nathaniel Hourt <I@nathaniel.land>
In-Reply-To: <20250427145011.17331-1-ziyao@disroot.org>
References: <20250427145011.17331-1-ziyao@disroot.org>
Subject: Re: (subset) [PATCH 0/2] Clang compatibility improvements for RISC-V
Message-Id: <174648813003.69658.8243788100199933751.b4-ty@konsulko.com>
Date: Mon, 05 May 2025 17:35:30 -0600
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

On Sun, 27 Apr 2025 14:50:09 +0000, Yao Zi wrote:

> Originally reported by Nathaniel Hourt[1], U-Boot fails to boot on
> JH7110 platforms (starfive_visionfive2_defconfig) when building with
> Clang.
> 
> This series fixes configuration generation with Clang's preprocessor and
> add an alternative codepath for RISC-V to access gd to workaround
> misoptimization of Clang, which is sufficient for building images for
> JH7110 boards.
> 
> [...]

Applied to u-boot/master, thanks!

[1/2] Makefile: Strip leading spaces when preprocessing generated_defconfig
      commit: 252cd205300c1b9945079c0ae1fe5980ef9dfa56
-- 
Tom


