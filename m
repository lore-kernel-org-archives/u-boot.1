Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E92D3E1A8
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 02:21:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47DB388E88;
	Sat, 19 Oct 2024 04:21:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PiLlmPyK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2785A88ECB; Sat, 19 Oct 2024 04:21:39 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 246E188E33
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 04:21:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6cbf0e6414aso13044476d6.1
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 19:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729304496; x=1729909296; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=m0Jrmm7GhK6bkwxd3q27T+23zWOPpwvJsFL10hK+jVY=;
 b=PiLlmPyKygbLWXkJVZgAtx4jRaWX8ylLRou/RwsrKtNRlcjDFjFvb3lVoWPQwADhO6
 pKk3nn1/YqYi3JJcBJ+UKMXuO6nin/xcK9BTMUwX8i2yrUwi9tbh3SUjpAVV3/sBfq73
 SYPM+o03z/xqNe+H5VokFNl7IxJq5pU5nnyBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729304496; x=1729909296;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m0Jrmm7GhK6bkwxd3q27T+23zWOPpwvJsFL10hK+jVY=;
 b=Iw3PqGuWrAy/yll2FPGdv2s3OulLuN4zq6qMbEgOqzuDfhN4sCBjXDgkTLD6F0U+0o
 QqgstbF5CrlCiqFhEQrGniVCl2ZswDWq1PVcQ/K4Vo+UaLBgqHryhaZMQ5wDTlLHIfx1
 WQnvNYxAsGi8jqkhyhp97BTJHVBBU2QrA7Xqm49cvrz1i7jhgH8rLnmSWaVsBKZws+ao
 zFKoV3MaSLvb5hgAIgi4Wxur9w46rquiiHUlN1A46Bc6clbi51mpPpTKiVjmh4DZB4it
 sHf2AoSLALv0s2O0gWU5qwtrXMwU2fTiC6eyKnfbPi/URWiB/Brs2G2GCLTojXre0jmP
 FjOA==
X-Gm-Message-State: AOJu0Yz478HKx/eGWQ8Y4KfP+MKlZOlIHUW1kQWiZP7wCzsMMoZKnWFX
 iMzcttAKLE7ouP2RO0CfgEzFGDH5d3B7BlSAwRoGvMPVz+0AGWmQ43cgsSTm4XoHi+QmzZeirzd
 LLQU=
X-Google-Smtp-Source: AGHT+IHtJyVClqmToe+tRuzzCV98V4ZtJeTzgKuXsPH0zFk+W+FAAalQidtLBFcwnuLLA2waATiH5g==
X-Received: by 2002:a05:6214:4685:b0:6cb:ced4:eafd with SMTP id
 6a1803df08f44-6cde15ec4a9mr65387106d6.35.1729304495986; 
 Fri, 18 Oct 2024 19:21:35 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cde138fde7sm12521016d6.143.2024.10.18.19.21.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 19:21:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Raymond Mao <raymond.mao@linaro.org>
In-Reply-To: <20241016234829.3836359-1-raymond.mao@linaro.org>
References: <20241016234829.3836359-1-raymond.mao@linaro.org>
Subject: Re: [PATCH] mbedtls: fix defects in coverity scan
Message-Id: <172930449470.2505436.13436740453794923291.b4-ty@konsulko.com>
Date: Fri, 18 Oct 2024 20:21:34 -0600
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

On Wed, 16 Oct 2024 16:48:26 -0700, Raymond Mao wrote:

> Fixes of unreleased buffer, deadcode and wrong variable type detected
> by coverity scan.
> 
> Addresses-Coverity-ID: 510809:  Resource leaks  (RESOURCE_LEAK)
> Addresses-Coverity-ID: 510806:  Control flow issues  (DEADCODE)
> Addresses-Coverity-ID: 510794 Control flow issues  (NO_EFFECT)
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


