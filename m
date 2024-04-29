Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD0DC4345F
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 23:04:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F6B2889BA;
	Tue, 30 Apr 2024 01:04:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KgNkX8L/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AB93889B2; Tue, 30 Apr 2024 01:04:06 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 488B3889A7
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 01:04:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6969388c36fso20882886d6.1
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 16:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714431843; x=1715036643; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m9j7tKFcPVgeBV1H/vEGmmtdvgtLww7mrsCrZlHCKog=;
 b=KgNkX8L/7kM3m+bg8nyLRnCSihH93IvQCjlid647bP04DaFU57ug/h54cojfhcAOTD
 FWxnoq9okvJ3tOxX/398Wv1D1U6xzYmmWk7VBevZsPtSF64WYty1voFuS+3YoVLzwONi
 QdukwnV9Ub6nJ31rE/wqkCHN4NvmoIxkeLpjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714431843; x=1715036643;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m9j7tKFcPVgeBV1H/vEGmmtdvgtLww7mrsCrZlHCKog=;
 b=mELTxMZVTa2HmOnq3qtf00H6Xq347PDmYvo2IOKYM0kER47kidEDdJwg2n26lP/jvd
 N15AkdiEJRneg7zag0D5vynxMXBQv+P76Oamu1R8t20T1z3lGkmeCzDzZXhI/9p4fA1t
 uflrZBEDEM6DdechiED9Fwa+4Y+f4WBWKyRMnHzGRcZTXzUcj2l5mFuI1di5Zwu8adek
 Jf0TdWCa4Aj6eNl4zPFns4sB/thubOUDOJmQMFj5WB4KWFZ5ydxDsf5uz3VG8jnBrbK9
 mY5jg3OQRLA6HzRaLEPKzUEfTe3gobNxIUAMntLrVDAXBl83LQ1lmgHuTYqujfArYqKg
 EQbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUC8pcqdkH/59lvWwWXuM/QopPRyzG0IBAWZsKycAUw+gby7taN5mNS0Sx67jMAuiRwhVhAmqORmvCKdcwL1OjPQBabrg==
X-Gm-Message-State: AOJu0YzNi6KCmegR+0yF9R8gIeU0bp2LvQUVG3KWoD+uDL/WtUGnBdzv
 UwLSv2bH66Iqeo+P5Qpa9R8iap6VTEJS2R0zD2y7uF0aUUjui5LM1JsRYQ0NvZE=
X-Google-Smtp-Source: AGHT+IFrjI9MF0QcD/VbXV4R8UBW5Wbrl6kcEkpRBPE6myr0zcS3D4wzpjG8ohJCPojBlLKoo/YOUQ==
X-Received: by 2002:a05:6214:2629:b0:6a0:48f1:6148 with SMTP id
 gv9-20020a056214262900b006a048f16148mr965219qvb.27.1714431842742; 
 Mon, 29 Apr 2024 16:04:02 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216]) by smtp.gmail.com with ESMTPSA id
 h6-20020a05620a13e600b0078f044ff474sm10967156qkl.35.2024.04.29.16.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Apr 2024 16:04:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: n-francis@ti.com, afd@ti.com, j-keerthy@ti.com, 
 Udit Kumar <u-kumar1@ti.com>
Cc: nm@ti.com, rogerq@kernel.org, christian.gmeiner@gmail.com, 
 sjg@chromium.org, u-boot@lists.denx.de
In-Reply-To: <20240417043650.3743061-1-u-kumar1@ti.com>
References: <20240417043650.3743061-1-u-kumar1@ti.com>
Subject: Re: [PATCH] board: ti: j721e: Add support for both esm probe
Message-Id: <171443184122.1749944.14631410142041013825.b4-ty@konsulko.com>
Date: Mon, 29 Apr 2024 17:04:01 -0600
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

On Wed, 17 Apr 2024 10:06:50 +0530, Udit Kumar wrote:

> At present only MCU domain ESM is probed, this means errors
> occurred in mcu domain will be propagate to MCU_SAFETY_ERRORn.
> MCU ESM accepts SOC_SAFETY_ERRORn signal as Error
> event and propagate to MCU_SAFETY_ERRORn.[0]
> 
> Therefore adding support to probe both main domain and mcu
> domain ESM.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


