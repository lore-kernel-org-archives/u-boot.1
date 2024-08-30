Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D90CA100A
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 23:30:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 277ED88D56;
	Sat, 31 Aug 2024 01:30:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pS7EgNdE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E387888D3D; Sat, 31 Aug 2024 01:30:24 +0200 (CEST)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com
 [IPv6:2607:f8b0:4864:20::92c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B61088D27
 for <u-boot@lists.denx.de>; Sat, 31 Aug 2024 01:30:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-846c4ec2694so81923241.2
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 16:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725060621; x=1725665421; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KMHKtnt+pbjR3WVObABd7GUwaQ9olqPbGJjYOIC0cyI=;
 b=pS7EgNdEfEUMRqLj5ZrUnU+IwjpvNsTbYJhrSn56+cvdPXPL9rZVwMbR44ucLDc/5z
 VvkQl1qUMF4Pi/6BwMa+nnLbX/27BnysXjqO+8+Ccc8e+DI6FDfJQATyeSFwgaTDtgE5
 a1FywhG9XnVSnrBArCdC0I6xeH6SUMIQW8v5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725060621; x=1725665421;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KMHKtnt+pbjR3WVObABd7GUwaQ9olqPbGJjYOIC0cyI=;
 b=iaNsK9j9BXI1TIQXFXuCs5m2eozqToDrUx4DFeRnmEro5kW1441h13oZHv65d0DAaz
 y8pdStJe0Mm2lgibeMbq+TCQhzSCi8h35XO0xRu/WLXq9Jb8EjytIH102929ca2YaK9/
 N07r5RM+LLyDnGXfaNOsVJ9XjvTHIK7MK5iXnrXC1r4zpN2K30Ckx2Ob/7cOM59z74H2
 AdpGVmIyAx1GwD8hhN012v0CSuzyGS5Ib+mBd99h6AOiD28ccLcdoj8kvyHLYoVtD8VB
 aLZJjnkuhhcO3thKHTQD1Q5vd7K17frVGgndswVJhteVL+CRI/AjNafeyrWX4fDM6N3I
 lo1A==
X-Gm-Message-State: AOJu0YwBXDprMccsy0CILzw06PDSt4jW3zelevs9uG+6K0vChSYci2kM
 mMyqUKZ2WODGV45vkMA/F3birud68wFEuHKzZchSSAGhcuHt1+PenwsL7pN8PUo=
X-Google-Smtp-Source: AGHT+IFu5pG4sPlkhI406mMx+BEtGZNkdOXf3RB6DhTkeLRox2Ulh01amIKzkJsEey1HJ13FxrXL6A==
X-Received: by 2002:a05:6102:e12:b0:48f:e6e0:7c04 with SMTP id
 ada2fe7eead31-49a79799effmr421389137.0.1725060621233; 
 Fri, 30 Aug 2024 16:30:21 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a806c1f974sm193224085a.37.2024.08.30.16.30.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 16:30:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Dhruva Gole <d-gole@ti.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Udit Kumar <u-kumar1@ti.com>, 
 MD Danish Anwar <danishanwar@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Andreas Dannenberg <dannenberg@ti.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Devarsh Thakkar <devarsht@ti.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Kishon Vijay Abraham I <kishon@ti.com>, Andrew Davis <afd@ti.com>, 
 Joao Paulo Goncalves <joao.goncalves@toradex.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Wadim Egorov <w.egorov@phytec.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, Nishanth Menon <nm@ti.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Chintan Vankar <c-vankar@ti.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240826102515.2774296-1-c-vankar@ti.com>
References: <20240826102515.2774296-1-c-vankar@ti.com>
Subject: Re: [PATCH v6 00/11] Add support for Ethernet Boot on SK-AM62
Message-Id: <172506061826.3280213.11330102105578526992.b4-ty@konsulko.com>
Date: Fri, 30 Aug 2024 17:30:18 -0600
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

On Mon, 26 Aug 2024 15:55:04 +0530, Chintan Vankar wrote:

> This series enables Ethernet Boot on SK-AM62 device.
> 
> This series is based on commit 'f4f845b85926' of origin/next branch of
> U-Boot.
> 
> Link to v5:
> https://lore.kernel.org/r/20240813105400.4054657-1-c-vankar@ti.com/
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


