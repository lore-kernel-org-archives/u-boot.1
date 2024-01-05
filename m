Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C2DC47074
	for <u-boot@archiver.kernel.org>; Fri,  5 Jan 2024 01:37:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B897C876F3;
	Fri,  5 Jan 2024 02:37:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="daEe+6ir";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FCA987756; Fri,  5 Jan 2024 02:37:14 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 057C887575
 for <u-boot@lists.denx.de>; Fri,  5 Jan 2024 02:37:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-680d1908fb2so4905216d6.3
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 17:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704418631; x=1705023431; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AmrdpnMgkA/LOYkPGRYxY2cQLSow8Fc1xtaaO6+oxbM=;
 b=daEe+6irVJUE5BqPSgRM8ZZ5J3sdMOovNZaH87rMi0E4tPzgthS9ZhFtrI11UK8Trs
 pfyFwFsV/txtRhn41r9yXu8pr7K2iYNDIPe7mQdclf7tS0Z9/k9c0Fa70q6mJl2T9FKQ
 0NhfjdwxK2L5GtUNgSFbIaWiYyRXfwAdRStxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704418631; x=1705023431;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AmrdpnMgkA/LOYkPGRYxY2cQLSow8Fc1xtaaO6+oxbM=;
 b=OvYcHQ1gNKbgLSwU6SzD8Gkt5Qmg1UK1570CYloELUWOl7a6hOFbOwKCiM+p8McAwl
 Og/bgFlwjVKCdAZiKQih/2IWRJ0At2AxuzAHDXULlEo3c2mn8RMUmK9o8reU5UA3rD1j
 Bu8zmaQncfzoqVrLeeboCGR5CVFODOFhK8Rpu0bLVFWI1gK06bZSXRCJl3PoMTQVxMRD
 f+f55764Ey71hpyY7zjQgcPEQNuNa0iszuym+1cmaAX8cfMnEjYaPxgI3EW4/5lRMeEk
 zxPLJb0w0x60Ip9+9xUQ3/FzGEnXrw78PKRuc5zFFEiPjuv/Cb1CAlgCcvmAb7NAbdtg
 irhA==
X-Gm-Message-State: AOJu0YzT/tjflgaAEqjqeQamF+eXzgEZjbM5jEm/tBXT/K09Qr6wOXAs
 C13fpQB+xITXrI3CpZjAkFG2ZSlPUUfRoA==
X-Google-Smtp-Source: AGHT+IHyO2+pyK/8oXX7zzzGfM4Bo3JTLdRtuML43bM9chm9MA0XLIXMJXf2LYWZesRuXp06w9D1HQ==
X-Received: by 2002:a05:6214:1c45:b0:67f:c4ab:dd with SMTP id
 if5-20020a0562141c4500b0067fc4ab00ddmr1588256qvb.70.1704418630771; 
 Thu, 04 Jan 2024 17:37:10 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 jh22-20020a0562141fd600b0067f9ab3564asm234573qvb.68.2024.01.04.17.37.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 17:37:10 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
Cc: u-boot@lists.denx.de, Udit Kumar <u-kumar1@ti.com>, 
 Praneeth Bajjuri <praneeth@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, 
 Nishanth Menon <nm@ti.com>, Thomas Richard <thomas.richard@bootlin.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>
In-Reply-To: <20231229-binman-firewalling-v7-0-47ed4af303fe@ti.com>
References: <20231229-binman-firewalling-v7-0-47ed4af303fe@ti.com>
Subject: Re: [PATCH v7 0/9] ATF and OP-TEE Firewalling for K3 devices.
Message-Id: <170441862950.1760516.17763206127183556188.b4-ty@konsulko.com>
Date: Thu, 04 Jan 2024 20:37:09 -0500
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

On Fri, 29 Dec 2023 16:16:24 +0530, Manorit Chawdhry wrote:

> K3 devices have firewalls that are used to prevent illegal accesses to
> memory regions that are deemed secure. The series prevents the illegal
> accesses to ATF and OP-TEE regions that are present in different K3
> devices.
> 
> AM62X, AM62AX and AM64X are currently in hold due to some firewall
> configurations that our System Controller (TIFS) needs to handle.
> The devices that are not configured with the firewalling nodes will not
> be affected and can continue to work fine until the firewall nodes are
> added so will be a non-blocking merge.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


