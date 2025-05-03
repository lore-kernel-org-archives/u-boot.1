Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7428C369C2
	for <u-boot@archiver.kernel.org>; Sat,  3 May 2025 16:32:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6700482905;
	Sat,  3 May 2025 18:31:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="M22aJ+r1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 089F58283E; Sat,  3 May 2025 18:31:40 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8FAA82937
 for <u-boot@lists.denx.de>; Sat,  3 May 2025 18:31:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-60658e1fedfso1528326eaf.2
 for <u-boot@lists.denx.de>; Sat, 03 May 2025 09:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746289896; x=1746894696; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RvHM/RPasoGAQyjvK2THpgcGufIUao9OQIDKzrTyRjY=;
 b=M22aJ+r1LI/zrO15WDLLtw0WKad2//2y7b2LwuWv6EBPZ8/haKFSxHBKRHXYj2ADNc
 U+gug/ghkJgs+BQdl2ANdhSDg8JFWrIAn/04WlvoYL2xfthHV8KJTqaeE8ZIPv4I4wfX
 +DqLXY3L2MNKyDK2CwpCQGdYu56rGDP9thjyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746289896; x=1746894696;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RvHM/RPasoGAQyjvK2THpgcGufIUao9OQIDKzrTyRjY=;
 b=DOokp1zGeujQeveDl/3LTyn/WBRnmGUFeKL/M8MX5Gd24NLTXweN55n3Xcnf/ANj6o
 b2VwpRaN1PrimXytsSoou3wmKGI0KzwR2L/i6j30g7wYOomW5KLT7qX5Y4A3YQAdHSm2
 m5Thn4iFsK8/GZXVQn/zvFL7pErT52P0t1Hfr6zNzhur/ZjBJYpHF/+58FLoxO7cEKH0
 auFzpBnQ7PO9TRCWlCw/VXrBpv0nGsLxWkhJOst2Bms2UeXDpIS4/IbPzT86dXzpRzeA
 ydNcS8rww10oDaBKDmMDro2KII1c0IfZD1J88p33ahdhY0xebewSg/7Svx4oFyk2ORFg
 eykA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUn+CMBUsjSt5pbwuWH42ALC/woF/AGd1JAdwyEPS2J7UwVyM7AjO244Riri+Fr4Md/ag8lAA0=@lists.denx.de
X-Gm-Message-State: AOJu0YxgMX5SVwiQZaZhsOsGZnSM38IYt+FpL++lgejQftlgJG/ZR+ts
 w2rdqBjkucGoYuWw3/5+L9f5Gk3V+dRmr3jHI29IINrvJ4PnNqcUTrmHbPu1XOA=
X-Gm-Gg: ASbGnctzKu1+awB2q7SGzid3+Pr181H/eYoA4qX3hOENTCtbm9C3ZJyS4hGhBDWnrbd
 doiYxH+1Ev0IuAES3/IUViImMpzzH7MSdWVsfgceEveM6hoUQKL5LS0kVxaH20PUn3JB2pi6sQL
 6s1dWQ6HLQEarDOFlNZgU/DXOXutmbUynCBFRTWTx5A+4XzNi3/qf/BQ+Ye/7WSqUtWHrukfPi7
 z/jxSBNWwEFMjCLNf0NJmfNeZBReFGUB3DnGW5RWJuPFW66WAqYssn6MAJLb3yyUt7ZRreVmUfO
 0SCOdYnJmf3H0LH3OjbYzviOV2E7INhKGnBkS9NUYk8osKjFMCVZg97iQVhdpSwwYRl+U0YGzXJ
 n
X-Google-Smtp-Source: AGHT+IEQmFSasf8lzTGd/B408bKPzXH7ebIdcs84YoLs6c4dqybw0AaLUovGiMz3U6hiiFVduVM19w==
X-Received: by 2002:a05:6820:811a:b0:606:85ad:881 with SMTP id
 006d021491bc7-607ee5132dfmr3428120eaf.0.1746289896619; 
 Sat, 03 May 2025 09:31:36 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-607e7db25f5sm970991eaf.17.2025.05.03.09.31.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 09:31:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: eballetbo@redhat.com, u-boot@lists.denx.de, Udit Kumar <u-kumar1@ti.com>
Cc: nm@ti.com, b-padhi@ti.com, n-francis@ti.com, vigneshr@ti.com
In-Reply-To: <20250427070323.590449-1-u-kumar1@ti.com>
References: <20250427070323.590449-1-u-kumar1@ti.com>
Subject: Re: [v3 PATCH 0/4] k3-j784s4*: Enable ESMs and related PMIC
Message-Id: <174628989507.1571566.15076405985938884410.b4-ty@konsulko.com>
Date: Sat, 03 May 2025 10:31:35 -0600
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

On Sun, 27 Apr 2025 12:33:19 +0530, Udit Kumar wrote:

> This series enables the ESMs and the associated PMIC. Programming these bits is
> a requirement to make the watchdog actually reset the board.
> 
> Series supports WDT reset on all TI platforms based upon J784S4 SOC
> including cut down (J742S2).
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/4] arm: dts: k3-j784s4-r5-evm: Add the PMIC ESM node
      commit: b011053450f8f196c78717956cc0dd25e388f9cf
[2/4] arm: dts: k3-am69-r5-evm: Add the PMIC ESM node
      commit: 29e1d5f93826251a61a9b5640727d5b4d3e7fd9c
[3/4] board: ti: j784s4: Initialize the ESM & PMIC ESM
      commit: 61c6d134868a7c888a90c9d5612fd18c0274b01e
[4/4] configs: j784s4_evm_r5: Enable ESM related configs
      commit: 8de75de3e4529803030e2763d98db3e5aaf6b956
-- 
Tom


