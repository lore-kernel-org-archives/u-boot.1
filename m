Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89F6EE0ADC
	for <u-boot@archiver.kernel.org>; Sat,  7 Feb 2026 14:18:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30DC283693;
	Sat,  7 Feb 2026 15:18:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SPfNoPkr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A737483AA7; Sat,  7 Feb 2026 10:29:35 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EB3C83642
 for <u-boot@lists.denx.de>; Sat,  7 Feb 2026 10:29:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nathbappai@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2a9004e4239so14465395ad.0
 for <u-boot@lists.denx.de>; Sat, 07 Feb 2026 01:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770456572; x=1771061372; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f5MaoAfDb1DevlF2gA8VOmGT0SFTvTd5xYVktDrFsWU=;
 b=SPfNoPkrliZZBJrOBuge79vbOOsLbccvJngiUpmDBl8RhK+lKwCL2mqIjwcFhGoWHE
 SfoO2MRkhYRFKDst5vcqb/IQRulQqtpR3Hi5YDt2Hq4CMExnDWKoZgEcoeggSokd+neW
 OwKRc7kUKfyha8BQBc/EsEgrV1uoPLFJ1we3SuUPAnWnFhIWg7Oy0BJasIWzcHh1fDjD
 MtakCEPxeGdgoQf6JbxTJB7weKSeYEYE3Y52gg0QQEmCYuzs4QkFdoiN5DZM8X+GrxPJ
 EqwPQYtA9NJ8SIm/CsN/g4B6rEbM0NBC7KADYkgEoIr1SRdUEeWIOr6qdeAKxaNWEgkh
 w1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770456572; x=1771061372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f5MaoAfDb1DevlF2gA8VOmGT0SFTvTd5xYVktDrFsWU=;
 b=uGAqT2yPpNa1y/4c0umYKydmCnHDzDP1ZfnjqogSCzARRQBLimrXcvwb1EPahRbpjG
 wAtvGzApXT+jlo7SxXv8mrzSXKdMqc7BMo+4WrjyV75dau5ooS9NMpJv98E6m19da16b
 bRT9lnFPFHEHqYxjxxeWXv1bofSYmOAyvxY8OcJQIqFDqOqtGEnKz6bvnObPNP20E04p
 1pmhrSoRvLy/rTpFPWqhYuXHZHysDdYT7Hm1UgCQpv+UiEcDxuPn7qlMMuaVMHH0nUPb
 ZqGNsPvCMnB9qqzdGwfSdZ+uG2OevB+BybiZIBn5gw+3R/pBL4LS7tKV3DdhvDFO/E3j
 NB9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4mc9SQ/axIY0iGQ6ICoCWRFnuDPAJx78/gIr0xefo69Fb3/BkTcTGwU1RzRxn+uykIacmOzA=@lists.denx.de
X-Gm-Message-State: AOJu0YwGsd8I7wB+IUUJvRicIsPKGa5M5ajaM3SYJMmn85X18B3eELeO
 8SGZDI9GKLvgu6FT6gBHV43akevqg3ihjZVYy53lpuGe3LtQ1EHQf/+m
X-Gm-Gg: AZuq6aJKysb4mH/3KDbAYMNPoFhDkCgvh3g1Sui1LsXZXKqCO9FsJs+4mcAkkrHKBCP
 lD0By555atsNeVMEsJ2NizIWCzAF3yzXDfkmxfJmPPXzaL0hMWmszsF4HH85Tu98a8VPyCXhJUJ
 Cxhl7hQfaTJ3bzZup3i8soQkZG6thZnW9NQBEg3ir5IYev0VEOmEvwKtZUUXaWkFDx/0bGm5naO
 mGYIpLLglZpYRLs+thVqCbnhlAhmY22wgWSKhm/JeHv2I539zCKRcBDgsbR2LEWayGqirpPkzIT
 +spxfPuu8iFLnWAUFltGSv5AtzrcmDOxlFzg77L/kjPNwP3N+2R+a1xFNtFehJbXpAWfN6Yu9yv
 pZNAcg/ju9zBBPwg1z/+Kbat9qSOZeZf7gxJbmRMDnSk20+OPac5VZUg582XW3AxgNzTg1t+gn4
 dDX856pMQS
X-Received: by 2002:a17:902:da8f:b0:2a7:80bf:3131 with SMTP id
 d9443c01a7336-2a95196c7a7mr63574895ad.58.1770456571873; 
 Sat, 07 Feb 2026 01:29:31 -0800 (PST)
Received: from ArchLinux ([43.251.89.233])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2a951c8b041sm44970075ad.34.2026.02.07.01.29.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Feb 2026 01:29:31 -0800 (PST)
From: Biswapriyo Nath <nathbappai@gmail.com>
To: Biswapriyo Nath <nathbappai@gmail.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Bryan Brattlof <bb@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH RFC 0/3] Add clk and pinctrl drivers for SM6125 SoC
Date: Sat,  7 Feb 2026 09:28:38 +0000
Message-ID: <20260207092845.10421-1-nathbappai@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204-sm6125-clk-pinctrl-v1-0-9cf4c556557a@gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 07 Feb 2026 15:18:52 +0100
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

On Wed, 04 Feb 2026 16:10:51 +0000 Biswapriyo Nath <nathbappai@gmail.com> wrote:

> This is still RFC because micro SD card does not work with u-boot but it
> works in Linux. I do not know how to troubleshoot the issue. Any pointers
> would be really helpful.

I forgot to add the error message. Here is the output from USB serial.

=> mmc list
mmc@4744000: 0 (eMMC)
mmc@4784000: 1
=> mmc dev 1
Card did not respond to voltage select! : -110

Thanks.

