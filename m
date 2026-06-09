Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC64CD8CAD
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 22:28:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05804849A1;
	Wed, 10 Jun 2026 00:28:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kCAMJDF6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3EB68486D; Wed, 10 Jun 2026 00:28:23 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 790FC84962
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 00:28:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-486badc02ecso1519244b6e.3
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 15:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781044100; x=1781648900; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YqQgdJUnSOajg/ypG+ddzOhm1l7Bw3AyuLEpD9whg54=;
 b=kCAMJDF6o5xGuSHmOa54EIGOxGQM4mIexVJSiBAjW7xeEPXSlyAP1Qw3hcEuiXGeI1
 YcffS6tWMYFXS0oUT8YCSTZjuFb7STTzIIhhoOn1SKnChWGnwzfOKklEsQvuSWfvju9z
 Xtjf7MuhJiRrkxS3vTAHYvp2WMrA92DplYbU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781044100; x=1781648900;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YqQgdJUnSOajg/ypG+ddzOhm1l7Bw3AyuLEpD9whg54=;
 b=awjiLcir2xzHuqXV8RNjA/mfFiJktQXeciuWJav5YCozHEM1l0g0qNr7ZksBVdxHPL
 buG1nGX0tafsrd0YNmc3/fPE/qKATEJd/1TPQe9dwJaplpyO09decuj3l0BHdrpEWAcO
 fLn3iCJjQSlF6itX4Tp3FExQnLZn2KK/82FMlEbI2dbLzruQ89FlLQbbIuElqh++j/GL
 WuC3JX5yK6CtaY14odA2ZaYVn2xNKbgtKP+lVhKDgPIHCi2pJhN7qBnBewcpI9Iw+hb3
 dzy6e9uJ/Ne2l16pQ/iNoiC3E341FBbhrp81Q3skSLmtw2wpIkhp+42I5LD1KVqbHJ+I
 fVsg==
X-Gm-Message-State: AOJu0YxzyULk30wLBXVEfKOqDKCB4Ob8n+tmuUQs+w+rbGriXWZ1E9pL
 KoVFZzk3Kvn0Vqxbljxlf35/gaiqrSFWQz9Uf1YjyjXTOQzYEbe/Yz97dEs/7hzpWDY=
X-Gm-Gg: Acq92OGRF6vc4deTTYJdtcxm7uKE3rBq8nHc6i//XHokzdRuNag0NBH0yJY5QTz9MNu
 4TTkdLADW5BgYGgSCYwkWmrGnk6otetsGzxkp/9NDFZLYu9oeGkIOam3cRQQPA2WiD53GjK8Gnz
 AI9QsUuwIai5iuuvX6GlMD5uZQwyfI+UHmvGqJe8CW3K3Ts5k0jGNgVSrkF1D567V01QqQIoKJC
 I56R98H59DsM1tX+gTWOB3HjGfX4SGnkXW2bYg+ehUXOKUTjIz6UTk5I7gofTUvN8vlPi2vtj8e
 10qB2CWUkV62w2QcO8bbynSz5HgYphxiWcBP5gagmPsNIMCMb/QoHvFx8ZEwdvcu++HBJG+F3Ad
 KGMSN5k3mz8JbYq2gAV8cvJ/Db/nsZpaPEBL+kkoaz2B9w8155Kb3eyN4vR/CMLhvCHVpECN5hC
 xl3liID1Zy6OQB8T51A4uuG2TgUbrfU42xq5SnSDo47D7DtTlNI9csiEpwWzd+70L/MV+6UFDcY
 qhMYgMRDyGaq7Xj3DAjGdRGeI8t350rbAozxvda4Lt0Zf+KDSHSc53eBaJn
X-Received: by 2002:a05:6808:3509:b0:482:4741:5f57 with SMTP id
 5614622812f47-4868deb1f64mr11711263b6e.40.1781044100075; 
 Tue, 09 Jun 2026 15:28:20 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4865b7ad946sm16790962b6e.8.2026.06.09.15.28.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 15:28:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: peng.fan@nxp.com
Cc: u-boot@lists.denx.de
In-Reply-To: <20260525042404.2372280-1-peng.fan@nxp.com>
References: <20260525042404.2372280-1-peng.fan@nxp.com>
Subject: Re: [PATCH 1/2] remoteproc: pru: Use dev_read_addr_size_index()
Message-Id: <178104409912.79918.569022199896704366.b4-ty@konsulko.com>
Date: Tue, 09 Jun 2026 16:28:19 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Mon, 25 May 2026 12:24:03 +0800, peng.fan@nxp.com wrote:

> Use dev_read_addr_size_index() which supports both live device tree and
> flat DT backends, avoiding direct dependency on devfdt_* helpers.
> 
> While at here, drop unused 'node'.
> 
> No functional changes.
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] remoteproc: pru: Use dev_read_addr_size_index()
      commit: 8918af1c0ce56d5dced75b97b737849ae525dacf
[2/2] remoteproc: ipu: Use dev_read_addr_x()
      commit: 8e8e624abc1f842c9afd8be5fafbba82adf426a7
-- 
Tom


