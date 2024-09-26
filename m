Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BCCCCDE00D
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 14:37:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4966B8860D;
	Thu, 26 Sep 2024 16:37:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mx6+gDF0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A2EA88C91; Thu, 26 Sep 2024 16:37:12 +0200 (CEST)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1811B880F4
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 16:37:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-4583083d05eso7156271cf.3
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 07:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727361429; x=1727966229; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8aCPIvQ1YGA7VLjCu3DijmwgR0ILzUjoQg7ApskON9c=;
 b=mx6+gDF0PrphIAW+PVdztuPgcRVbsZASkAq96a4ZmN5OfL7e3qiRTfWFIN7cduN2yO
 gxOQ/zyBwJP+ejmeb5mYHNt35QFM7bHXYDmVCVMRvPopNoM05Nut1yoFkgnJ8+jpuJge
 5rD+CwSv2CBf5kUC+tqX8ovOE416nL0Gjpob0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727361429; x=1727966229;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8aCPIvQ1YGA7VLjCu3DijmwgR0ILzUjoQg7ApskON9c=;
 b=o2Ll9nZQsybHFG+5fkPgJQ8rv/bNM2w6ygDGdcrLEL+nHQUob+d2chcDvGn2td27x0
 ODsSHa8DJDZxffoHLaZWfIltBvokp0m6tjLiL0nBFht7UjasW3uVKjU2l+gdBmhBbvNy
 jCqeNQdKXZ5jxWZc4nMVXO9guqdUM8YAccJRyu/zrs8pMg9c/1BLCW4Kb+q7QmwT3Da5
 AmSHd0Qv9m/YUjF4ZwX5i3FPaKYpQS2UZUJZQOvdyFhtKNqL+T1t0DnPAGExUADZashj
 0QMgZhFtAn6O0m64Y9WS31IBOLxSCyIb/z6JoyGnxYYvU1jFU2PWqJzNDG7qw/A8RJRT
 xjRA==
X-Gm-Message-State: AOJu0Yz58z3xZ7zU6PIiA8d85kKN20LsHn1eR5ea3yYmYx6kiElnnMNH
 mbBOCMA9n8GDuzVCHy+HQsM/2c5arvWbu/LHTZ6aUzBo7JIxMxiPmU47806BOaA=
X-Google-Smtp-Source: AGHT+IFxGqbXHQ9F8crD2L141WEcGZBjNm+e3Hs5ESVfZtHEw0UWeHW+rDRGKeWiOFEoFQr190U8Jg==
X-Received: by 2002:a05:622a:20a:b0:456:61f0:810d with SMTP id
 d75a77b69052e-45b5dece4b8mr94430361cf.10.1727361428598; 
 Thu, 26 Sep 2024 07:37:08 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45b525b193asm26344721cf.49.2024.09.26.07.37.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 07:37:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
In-Reply-To: <20240925094745.37922-1-sjg@chromium.org>
References: <20240925094745.37922-1-sjg@chromium.org>
Subject: Re: [u-boot-test-hooks PATCH] qemu_arm64_tpl: Add a new board
Message-Id: <172736142733.606809.2517380252705522662.b4-ty@konsulko.com>
Date: Thu, 26 Sep 2024 08:37:07 -0600
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

On Wed, 25 Sep 2024 11:47:40 +0200, Simon Glass wrote:

> Add this new board, to support testing the relocating SPL loader.
> 
> 

Applied to u-boot/u-boot-test-hooks.git/master, thanks!

-- 
Tom


