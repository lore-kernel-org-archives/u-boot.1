Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D31C43458
	for <u-boot@archiver.kernel.org>; Sat, 11 Jul 2026 00:17:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3883D84B14;
	Sat, 11 Jul 2026 02:17:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XpOllBST";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F97E84AE6; Sat, 11 Jul 2026 02:17:25 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E84884ACE
 for <u-boot@lists.denx.de>; Sat, 11 Jul 2026 02:17:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7e9ed64d490so745417a34.3
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 17:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783729042; x=1784333842; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qQFVXiHevYOm4GKXP3z9ASMk1UJcqcB7QvYUrqoD3Y4=;
 b=XpOllBST9vnHavWl+2sjeSdUCuOIFNEe1IZhMSJAvhMObUWTyAujycGCSkelJxddBT
 9PU3Shj5T2lVwvm9NlkodKBQF74pwK65Yqv3bfJfFBlwyHKNs0RKLLt4szmgSB7V5ltg
 J0M9enR6x7oWcWcgr9Q3DS7P5MY/vWeVH3F3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783729042; x=1784333842;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qQFVXiHevYOm4GKXP3z9ASMk1UJcqcB7QvYUrqoD3Y4=;
 b=tIdAvwtzeSFyAB/C+ZLN1YtaUro5wA7kSK8vPi8Borz23nTRqzXkufiwNdsKFeNmMi
 ALciNNX4tKBoYqIuMQ04duW81sqwlBWzFRm0vbYqSi0qSkpKUHLCRi8ipdRxJovx7lHU
 R0CA/PQRw1wVGxrP7ljI2YwAplWsHHP+TuRj4U3gdItbt1tA6dhGBnjyJBggc/fm4pPi
 GVtYYvKir1gOx7RXSG44mLGpmA2UYw5dJe4mS/nWX1KFVFwJOrYBa2q7IzJhvY52aztI
 u70Mf65G/Yg6soOxrlKJFUvXBkyjbg9/02Euo+IrWHDQy5wDvutBLNii3sCVx9GZv4+U
 bV8Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/w7+lBtIIhFusVmdcdjqqMzgKsuCYeIiJa8rQNXXW8fTuVXOm/bQ6UkxDh3aQv++Dg1m+ZSoA=@lists.denx.de
X-Gm-Message-State: AOJu0Yy478OyUE6pIsLQJ2htPPpGB4yK6rf46dS7FL6yC2f2BAeo/dC3
 OoVTavvYFz2ie3Qtt25+5YdT/egABHKgKgzAQfm3XPRSp6yY4+9mD3RYnKx5Fy5JbXA=
X-Gm-Gg: AfdE7cndWabTuaYwE2ZVnSReYgl6lRtdR1o5fktowoPj65Xnks+iCswdO6KdjGsxeIq
 aJp1BGIxPdmcvDtOiEMdkRltCoq8nwaOfts+748hWeVAJ61VPEMtxsn+4LroZjxziex8e61gwzQ
 MXLR2t2tMfSUM21XoU7O4WHQTCFwCA/pLkYeVSJ5nzSkg4r2tU51wi/y7M1Bhl8mJMylq46nHnr
 XPlviRtj8K7W6cmne3QDMjkK8w4nBLZOlpF6oL336DumMm9FjDVF/AiWHLsHWklkhpZ3AVvAkvv
 E8fzhz4FrREoD/aZw3qbWozs+Eu8EhTga1FK5mf0uFRv9k9yXcFsPKOTY2iAt/vuUIiaUyevt7f
 1smv41AesPOjcqn3ZmbDfiiaehrvcKg5VT4ow2aWfu6vaCE4RTMcyAQks4CiSMTsBoQgpvTeNLr
 BusJBMRgIae0Aa8NLO214nCB9qqbJxj/+NLm7w5D8ZhEKl//2VzwDAhtLXX+vOBIkMC9MNDmcuZ
 47DfpqqYAjECqPJKQiJCwU3tDV+UQWg2eQP
X-Received: by 2002:a05:6820:190c:b0:6a1:1a19:3f9a with SMTP id
 006d021491bc7-6a39a82ec32mr811478eaf.52.1783729041907; 
 Fri, 10 Jul 2026 17:17:21 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a39af0e953sm651312eaf.3.2026.07.10.17.17.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 17:17:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
Cc: Andrew Davis <afd@ti.com>, Hari Nagalla <hnagalla@ti.com>, 
 Beleswar Padhi <b-padhi@ti.com>, Neha Malcom Francis <n-francis@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Udit Kumar <u-kumar1@ti.com>, 
 Abhash Kumar <a-kumar2@ti.com>, Thomas Richard <thomas.richard@bootlin.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
In-Reply-To: <20260625133006.365756-1-richard.genoud@bootlin.com>
References: <20260625133006.365756-1-richard.genoud@bootlin.com>
Subject: Re: [PATCH] remoteproc: k3-r5: Fix crash when issuing rproc init
Message-Id: <178372904034.2905849.3003684456119646856.b4-ty@konsulko.com>
Date: Fri, 10 Jul 2026 18:17:20 -0600
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

On Thu, 25 Jun 2026 15:30:06 +0200, Richard Genoud (TI) wrote:

> Prevent NULL pointer dereference with lockstep mode.
> 
> Since commit 21d03d60e909 ("j7200 defconfig: add rproc commands"),
> issuing rproc init command with cluster configured in lockstep results
> in a NULL pointer dereference.
> 
> This is because ti_sci_proc_request() is called on both cores on the
> same cluster, without checking if they are populated.
> To fix that, only request the core being probed, as there is no need to
> request the other one.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] remoteproc: k3-r5: Fix crash when issuing rproc init
      commit: b1d083e444798e5dd5cbb703eabfdeaf5f9294c7
-- 
Tom


