Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCE6C7115B
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 14:06:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEDBF82D2B;
	Thu, 19 Jun 2025 16:06:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JT9x8Rmt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6D8482CCE; Thu, 19 Jun 2025 16:06:06 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B96C82BA1
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 16:06:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-4067106dd56so554368b6e.3
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 07:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750341963; x=1750946763; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K22WBKHpuyz/fyZ31ry8yNR6qZN9dTs0IHflBEbljI8=;
 b=JT9x8RmtWCpW+9GhJURBXXebYRoI+tSePU2ZJJxgaudh9Zko2BcNnCUrPU6XEo2Qo7
 08v507DSmzjhHMAxsMjvFrudJKuyN6X7YgNaQJIoJjtxwAc0f5NUMZsooUOqJJqmt5A9
 R3jLq+SLWNvihLTZr4bpruaZ7t7SzhrT6k7Xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750341963; x=1750946763;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K22WBKHpuyz/fyZ31ry8yNR6qZN9dTs0IHflBEbljI8=;
 b=i/q6ouzc3wtG5BnZ/fqy+tirQm29S95w2gYw1ntmZuyq5R7e4Cv3fArc/UYkMQm4e9
 nz/pl+BDViaUrCDwVhU/IGtwgiVCbAjbM19unURdw30sJOn6+mbqwPE2ceIeuEhNG0n9
 v68qV3x+VeV2FhrSkRHepT9fMhk9Nno5YybbQyUu6WCmXELnFKY6/k0iAr/fQo0SQXot
 k04Lh/xh7JyoUGhUOtq8s1OerXprqeN1oCX6Yk4loTpewoz3TU0MnMjZpaSw7GTvn6uL
 JdhBz1Nn7SqneRYIeDXd/OsEfkpXX3Ye5kzeQiuQMEHUxDw2mPnpJ0DbStGEE0urLVah
 e3rw==
X-Gm-Message-State: AOJu0YzY6IGckTrNPOtEVGuiB17+Y5xyrhXHDOmaqxrM93P7gfgGKpud
 z6z0p7aC1aRSzRsJya6Sg8Ku23WabbeAs/rdF8pn8Drd81+4N5ZBm9jO0gzhk0k7Pm8=
X-Gm-Gg: ASbGncv0l8VxwNlHLBiDdsQRORmrSpRduVFg9zyQouTqTIXdc10Kd9sUlKXlKMk8uHG
 CO+l9tzpFXAkAyIzWf+UBoNUoLRo3ipFsqorhvgqudjjNF0c4qb4dBuxJHlVlZmwp6YWv5PlUsl
 qiU50cufKMXPNy0f+DVgZa0fhtXhI58OuwB92lAoVUkKzdnG0J2IEo4IDRrONaF6DDXMBPcsg98
 +ltM5v4hYNa5CYF6GP5nr6hTu/QKqrZydLtq99ta6vJf+LOXiUfnpsAKeF/K66HSjY5sgJTsFXA
 DzUnMX9aw+iXFwE60cl2dyr5qHg+dlkXAo4V0r5q60x5V0BCsSDKbqAh41dUUIuZd6cwH/5uiFW
 vlVlkgpAEFgwmtXn9uYjZVQ==
X-Google-Smtp-Source: AGHT+IGmTDRXckhybABDcSuIQ9xgf2MrzkioykiSzVP7hfho5NkidLXHC1MUSr7pftJCGmb/qQgAfg==
X-Received: by 2002:a05:6808:3087:b0:401:ea47:2c4a with SMTP id
 5614622812f47-40a7c1be8e2mr15673613b6e.28.1750341963351; 
 Thu, 19 Jun 2025 07:06:03 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61108d73d75sm1610633eaf.5.2025.06.19.07.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Jun 2025 07:06:02 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Moteen Shah <m-shah@ti.com>
Cc: sjg@chromium.org, d-gole@ti.com, m-chawdhry@ti.com, n-francis@ti.com, 
 vigneshr@ti.com, u-kumar1@ti.com
In-Reply-To: <20250609081434.1000377-1-m-shah@ti.com>
References: <20250609081434.1000377-1-m-shah@ti.com>
Subject: Re: [PATCH v2 0/6] Print version of the DM firmware
Message-Id: <175034196193.205241.8518480298823373607.b4-ty@konsulko.com>
Date: Thu, 19 Jun 2025 08:06:01 -0600
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

On Mon, 09 Jun 2025 13:44:28 +0530, Moteen Shah wrote:

> This patch series adds the functionality to print the DM firmware
> version being used. Before requesting TISCI for the DM version we
> first check if the DM split mode capability exists, if yes, we proceed
> onto making the call to TISCI for retrieving the version information.
> 
> DM split mode capability[0] indicates that the DM is a separate binary
> altogether and has its own versioning information similar to TIFS.
> 
> [...]

Applied to u-boot/next, thanks!

[1/6] ti_sci_*: Add utility to access tisci firmware and SOC capability
      commit: 3bc174031d3cbcf176b22fc2869b486011fa194c
[2/6] ti_sci_* : Add capability to access DM firmware's metadata
      commit: 33fc7751b9adce0bc76989f399107078b2c21fd8
[3/6] firmware: ti_sci.c: Add a function to query DM firmware's capability
      commit: e1252194b622284ed941c83e55a2277c061e5a95
[4/6] firmware: ti_sci.c: Add a function to request DM metadata using ti_sci* calls
      commit: 60ee94585565bbfde4c828a9f464d9c4be5f041f
[5/6] arm: mach-k3: Add a function for printing DM version
      commit: 7bdbda262c1c76a4c5800e1f105e2473d5ead2e1
[6/6] arm: mach-k3: Print version of DM firmware during boot process
      commit: 003e7d70cd59e2221a463faaa9e8d1bd8e8e054f
-- 
Tom


