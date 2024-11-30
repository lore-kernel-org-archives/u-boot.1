Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E56ED7360B
	for <u-boot@archiver.kernel.org>; Sat, 30 Nov 2024 17:25:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4A5688E63;
	Sat, 30 Nov 2024 18:24:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gtE1SQ0N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 470EA89628; Sat, 30 Nov 2024 18:24:58 +0100 (CET)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB60488E00
 for <u-boot@lists.denx.de>; Sat, 30 Nov 2024 18:24:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-4668283eaf7so28793211cf.1
 for <u-boot@lists.denx.de>; Sat, 30 Nov 2024 09:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732987493; x=1733592293; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s9rNHgFRFpFiIR0iGB+FuzTEB7Vhg6fmvaBV3nd/26U=;
 b=gtE1SQ0NlBIcGzof9Se1g5C4uREnmzT+YihaOBj8JRHMb9cxd7g69tIfk7+wfsssLt
 lvy4xqJxgF1QjHRcDMFfpt0STKUbxVnMAXfeTRXQGtS/bcsi76j33GCqmWVqvQ2uvBzK
 ttdOl3TZFCulJ/fvGNQGeFUOkwfTMqeRhC7kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732987493; x=1733592293;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s9rNHgFRFpFiIR0iGB+FuzTEB7Vhg6fmvaBV3nd/26U=;
 b=UFYbrtw087dvLVByVXnlkyJL5lFOnSPo1MoVBWiwxLgZ1cWFRptlnLTwl7YDCRtEd1
 dyx1wLAppU2A3HjF00QD6X74+RzphtdScCtL2GWXYvbvEAtenXHlj2EA01XyyF6O3hN1
 KfwWu+gmI0QQLbimfd5/6MwJ+KiC9S4Xwi/CIwgKbmsRryFXlkVgTDKpumQ6b/oDQbD+
 3QieKjH7MUsWRvIapfiluXot2eSaoxxNPxLHbxaC8HaKwuM0ZMTK/UpfIl6GGB4CfRRT
 MGjPfCtv9vT5eSY6cF2Od2ANNAXP5F/99pHvNbMP2kyrqFhOUONKOEZdmRrNv7H5pUaX
 b/Ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8t/LLCygVmL1LNEB4TtPL5ZxxrXsT1ULBuLDuEW5jHBaf3SX46b+Lk3j7na1GkZx12zCLwq4=@lists.denx.de
X-Gm-Message-State: AOJu0YwObDe/wV3dGXmFlHrsIFd7Oz/ozYt3jO5nlG0m/u7Z6T9FzrNu
 WYbT7P82GbwQ5JLfkZR6AQt77PM9ghhPt64dIRpU3/Wjw1Q8gbVLxDHEo5rZst2AMwQ01NxQ3aB
 gnHw=
X-Gm-Gg: ASbGnctaXfHh1FzMmwkGDUUUZHe71+X95wL946JHXr+Kr6l7sRWguDELF04rWJCLQji
 Q0OqUs6Illw4RjqAyCuqpI6sOiydz8JNpKpMmaZoCBZSp0KqErVIfjmOz0XRMwx0ujGDh+aaDBT
 Rx6vWsLrY+jBdoSTp/pCR3zq1971OdaY6KiOfxN70NOS63kXhajAdLWubRA5iR3UTr6ySwmPDrY
 vGJwv45B8sorv5fNSxHY2+SPkIlcer0SixjiqcRDrcbKXBz
X-Google-Smtp-Source: AGHT+IG1QG5K49HGBrXk0cS9lC6lCpzFZlSb1OYZh1JfCE1O1fRiBkwZ396N6X77Vb35hwH7kz6Nnw==
X-Received: by 2002:a05:622a:14c:b0:463:1257:86f with SMTP id
 d75a77b69052e-466c1c2c693mr161001941cf.28.1732987493535; 
 Sat, 30 Nov 2024 09:24:53 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-466c4055023sm29115341cf.12.2024.11.30.09.24.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Nov 2024 09:24:52 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: xypron.glpk@gmx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de
In-Reply-To: <20241129170814.768438-1-ilias.apalodimas@linaro.org>
References: <20241129170814.768438-1-ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2] efi_loader: Add U-Boot memory to the EFI memory map
Message-Id: <173298749141.2254927.18105597727803945756.b4-ty@konsulko.com>
Date: Sat, 30 Nov 2024 11:24:51 -0600
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

On Fri, 29 Nov 2024 19:08:13 +0200, Ilias Apalodimas wrote:

> This reverts commit ("commit a68c9ac5d8af ("efi_memory: do not add U-Boot memory to the memory map")
> This code was removed when the EFI subsystem started using LMB calls for
> the reservations. In hindsight it unearthed two problems.
> 
> The e820 code is adding u-boot memory as EfiReservedMemory while it
> should look at what LMB added and decide instead of blindly overwriting
> it. The reason this worked is that we marked that code properly late,
> when the EFI came up. But now with the LMB changes, the EFI map gets
> added first and the e820 code overwrites it.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


