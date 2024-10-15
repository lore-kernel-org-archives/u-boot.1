Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B2F4D1F9C6
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 19:43:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 736AF889B3;
	Tue, 15 Oct 2024 21:43:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DhdAG9ed";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DBA8889B3; Tue, 15 Oct 2024 21:43:54 +0200 (CEST)
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com
 [IPv6:2607:f8b0:4864:20::92d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAF5B88966
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 21:43:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-84fb56d2fb2so1530059241.3
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 12:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729021430; x=1729626230; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZX0Tw0kr/Zh3Y5pZjXeSaPoVRd4vR+D/9i4s1KlHj3U=;
 b=DhdAG9edkN036HHSWqS4d7jJ91FrFgRyB4EpfOwRLSUneOJMBy6CVU/CKGqeFCDitQ
 6dZ3nXpm0vRFp8mpkZJ1Y5qj/nlNUua3q9ZXZswcqQjSrSF/GE9H5UCfCCVh/ASh5wOG
 lbqbab3Ue0p1WWaEKzYowm6jVRJbADbkxWlF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729021430; x=1729626230;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZX0Tw0kr/Zh3Y5pZjXeSaPoVRd4vR+D/9i4s1KlHj3U=;
 b=u9KOO+KcEAScZkrOBw3elxW3XTVdUNn4ULcuV0Ubs/LjtzdGPwVcfWGHXi1NkSPzoO
 LL/7EnyDZytc5u1kMENYgECj3OHe3K5P9CHtpmMIKRLuUFVjK3zIZc7EoArL4fBz3WTJ
 ls0pvTWu8llhRGD2r1SdJz6PK3PUHVQgD0wnq7dJSBpUxVPkhA05+Qayd3pZcqkc/37s
 qAj9Gb94hXvk0lYYkO6+2BraBKlCxnmlteahx0UxjqeCZzkPA3nDwGpUIhK5MByNNz4O
 gh3iclXOhodsnOBOKLnov6Qi6mGM4w68cZWDPogMEvGBcZLnZdojeoRx/sy2Zj8VJcf5
 nYSw==
X-Gm-Message-State: AOJu0YwA5Jh8GEiEFNzXKQXkRNplIRBj6Newpko0t5fFqJJ4RrjpwrVO
 eRa6nwDmpWs/tQwopGQrU5wTOrQp4ge4/7SP5ObefjF8lawu4adUHM7Fn28sgJ8=
X-Google-Smtp-Source: AGHT+IFMdqFqBKXuc8h6GxkDWqVv6r3y6LW9Ks+iMD4nTU8nLEPpuU9HuY5IWN/WCy7HMtA8LbSQaA==
X-Received: by 2002:a05:6102:292a:b0:4a3:c6f3:89c9 with SMTP id
 ada2fe7eead31-4a5b596adc8mr1916782137.11.1729021430552; 
 Tue, 15 Oct 2024 12:43:50 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b13899c31esm94873385a.99.2024.10.15.12.43.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 12:43:50 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, tkuw584924@gmail.com
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org, 
 pratyush@kernel.org, Bacem.Daassi@infineon.com, 
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
In-Reply-To: <cover.1728964655.git.Takahiro.Kuwano@infineon.com>
References: <cover.1728964655.git.Takahiro.Kuwano@infineon.com>
Subject: Re: [PATCH v3 0/6] mtd: Make sure UBIFS does not do multi-pass
 page programming on flashes that don't support it
Message-Id: <172902142883.5381.6938089868290004369.b4-ty@konsulko.com>
Date: Tue, 15 Oct 2024 13:43:48 -0600
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

On Tue, 15 Oct 2024 13:08:30 +0900, tkuw584924@gmail.com wrote:

> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> 
> This series is equivalent to the one for Linux MTD submitted by
> Pratyush Yadav.
> 
> https://patchwork.ozlabs.org/project/linux-mtd/list/?series=217759&state=*
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


