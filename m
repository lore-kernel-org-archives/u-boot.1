Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93DC6C27C55
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 22:04:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2947C88489;
	Sat,  8 Jun 2024 00:03:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BPg2O34s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BB8A8850E; Sat,  8 Jun 2024 00:03:50 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40581884EA
 for <u-boot@lists.denx.de>; Sat,  8 Jun 2024 00:03:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-250c0555a63so1283628fac.1
 for <u-boot@lists.denx.de>; Fri, 07 Jun 2024 15:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717797827; x=1718402627; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+CyopHEo2D28HFr0yY4XTo1OLcixpgU04Qb+NIvtNSA=;
 b=BPg2O34sqH/VpZRgnZoht0n4EFIRHTvVT8ItWpHftQCMPMEO/bRo9VX/pWEP70/yzB
 EIpSsrVCyNm7s9rg5hidxzR4vSMhLZh6vPHv4iiccs+W0kdznMvQqKlDpggN4moxX2CQ
 +RbZrUrw1/HZtLpcK9DqyBjDXZpABotsNyUow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717797827; x=1718402627;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+CyopHEo2D28HFr0yY4XTo1OLcixpgU04Qb+NIvtNSA=;
 b=FH29PhjUdDb4X3ihgH0x4awQ4ipX9sR9mjVgQj9q5yd39N7Zbt05cDeOiw4Z/T4SpH
 fKSM+GBPZ4F0j//j1p3rt70kO9Uc5MKQTImp0a00RNWvDOskAq23RTPa6d6kJd/qrzkb
 bY47rt+Ax7o2YqBBzcertknEcCAdW+l6OymXzQ60LlYi4d5uQDStKOED42PpaRy6xJ3o
 smj4W8Mf5U2+jEPRUUmAi1yTXEaV7K3nsVoE5s+FCDUJjOA5qogmpCjfA6NchMZ6PqQj
 Zv3/W5UlP5Z5p/B/IgPANXY3QFhnCBaxVcqw5QLUjrRhNq4TxUaPy8u352AaWtaiA2XK
 WBJw==
X-Gm-Message-State: AOJu0YxLM/mvhZVNzsoE4YK2PPQciyU7FSm8tGWn7qXQGDQl3xuky//t
 pCLGnhdm2C3ik8i9WWiOdBq1I3SyckGgrydE9hpJe8ZoSfcDjoYVvDLT5/mvMew=
X-Google-Smtp-Source: AGHT+IHPXjPdIoaMhpsC1Ip5NglbS3PTXqx8Rn1Cs6ci/E5TiXcvFW+uWJnMtLtaZ6f77OC0RcBOTw==
X-Received: by 2002:a05:6870:1650:b0:250:febf:3c6a with SMTP id
 586e51a60fabf-254644e1bf3mr4109964fac.18.1717797826972; 
 Fri, 07 Jun 2024 15:03:46 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-254951da4d4sm58415fac.47.2024.06.07.15.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jun 2024 15:03:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, upstream@lists.phytec.de, 
 Wadim Egorov <w.egorov@phytec.de>
Cc: nm@ti.com, clamor95@gmail.com, d.schultz@phytec.de, bb@ti.com, 
 jma@phytec.com, mkorpershoek@baylibre.com, d-gole@ti.com, m-chawdhry@ti.com, 
 n-jain1@ti.com, afd@ti.com, joao.goncalves@toradex.com, 
 michael@amarulasolutions.com, festevam@gmail.com, sjg@chromium.org
In-Reply-To: <20240522075505.3339347-1-w.egorov@phytec.de>
References: <20240522075505.3339347-1-w.egorov@phytec.de>
Subject: Re: [PATCH v2 0/5] *** phyCORE-AM62x: DDR detection / Inject DDR
 timing deltas ***
Message-Id: <171779782558.4156831.11957287906130163867.b4-ty@konsulko.com>
Date: Fri, 07 Jun 2024 16:03:45 -0600
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

On Wed, 22 May 2024 09:55:00 +0200, Wadim Egorov wrote:

> Changes in v2:
>   - Reabse to current next
>   - Add Tested-by: John Ma <jma@phytec.com>
>   - Add Kconfig option to select RAM size statically
>   - Make board/phytec/common/k3 always compile for CONFIG_ARCH_K3
> 
> v1: https://lists.denx.de/pipermail/u-boot/2024-May/553057.html
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


