Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B60BC46CCD
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 17:46:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D8DE8774D;
	Tue, 19 Dec 2023 18:46:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jPmzKrX3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB48B877D9; Tue, 19 Dec 2023 18:46:27 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63D958709C
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 18:46:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5e248b40c97so40159657b3.2
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 09:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703007984; x=1703612784; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vZGOjwqEz6XovTNxd65KtJnx2/HYeyTD8ZyXPfsctrY=;
 b=jPmzKrX3vTot4L/llLLt85vMfgReM/gW0Dt6Ii2YzsEs6JnXX1wElzoDZrEFTYOG6D
 K9ul6tcVmeeIzTKl0cthyicMEw1m10cpgSZp0s9sO/2vj2OAL5ODKB/l9+C/AY2CkETs
 Tf+/KCXJvGP0YhU4x/hHHhDiw3OsiU4tfWps8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703007984; x=1703612784;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vZGOjwqEz6XovTNxd65KtJnx2/HYeyTD8ZyXPfsctrY=;
 b=gWTZfo19LQfCBgUYEEJZW8C1IWn+qfUanrtoxT7rlKHby7XnMGhDlB8Vw8j0sHJXNU
 Kj8B4EEV3BAUhg3V9iuF+7WtPhSZvFVWlwnQK/BZoXng2xOm4v9AsGdidsU2FCl6r/r3
 GQqi06p4RThoi+cmNPs6oMwId7eaZIdL4eprnppA4dXRZYCRJFp/DsFoKMNz6rkbpj/c
 NBtVoOOEJipLFvflYKswh5aRPMIrfj9HRZpO4dXu5ADutxZYA8TfZhByWRJ9brEKG2To
 SboGjzMZeP7hxXTe59tzFhD4vvqi7c9Pzf//+1qEP98/hSoAXQ5DQAHi5Ei442c8gc0N
 Mvgw==
X-Gm-Message-State: AOJu0YzmyrKu1/0lnyJCOPoDK8ISHvJCkTy3Cu5TO7+0kl6PflB8Zs5R
 SBURa/U9lVmMnPeoj9qA7AHEGQ==
X-Google-Smtp-Source: AGHT+IEFSF3GxImDQDTkBADqmy0pk3Z6/R3j51zDb+PUn+hxvrXYqI10pwnL4LJLkAc5lLkf8AgQFA==
X-Received: by 2002:a0d:cf45:0:b0:5d9:50cc:b901 with SMTP id
 r66-20020a0dcf45000000b005d950ccb901mr15342475ywd.95.1703007984167; 
 Tue, 19 Dec 2023 09:46:24 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-6400-923c-ac63-6854-a688.res6.spectrum.com.
 [2603:6081:7b00:6400:923c:ac63:6854:a688])
 by smtp.gmail.com with ESMTPSA id
 m7-20020a81ae07000000b005e79f80959bsm716585ywh.112.2023.12.19.09.46.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 09:46:23 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Reid Tonking <reidt@ti.com>
Cc: nm@ti.com, m-chawdhry@ti.com, u-boot@lists.denx.de, u-kumar1@ti.com, 
 bb@ti.com, a-nandan@ti.com, vishalm@ti.com
In-Reply-To: <20231207165211.2319475-1-reidt@ti.com>
References: <20231207165211.2319475-1-reidt@ti.com>
Subject: Re: [PATCH v3 0/2] Fix J7200 kernel boot when using upstream
 u-boot
Message-Id: <170300798312.2765809.17291482154454714818.b4-ty@konsulko.com>
Date: Tue, 19 Dec 2023 12:46:23 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

On Thu, 07 Dec 2023 10:52:09 -0600, Reid Tonking wrote:

> Since the 09.01.00.002 release of ti-linux-firmware [0] upstream uboot
> has led to the kernel hanging during boot [1] for the TI J7200 S0C. The
> issue was found to be a few patches that had be added to ti-u-boot, but not
> yet upstreamed. This series adds the missing two patches to allow upstream
> u-boot to boot the kernel properly [2].
> 
> [0] https://git.ti.com/cgit/processor-firmware/ti-linux-firmware/commit/?h=ti-linux-firmware-next&id=952fd03e36a50ec070e73560dc1060102d637ce0
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


