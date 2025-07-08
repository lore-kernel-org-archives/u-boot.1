Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D8EFC8303C
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 21:35:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36FD483371;
	Tue,  8 Jul 2025 23:35:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DtgO6Mks";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3C35833C0; Tue,  8 Jul 2025 23:35:29 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBD6B832BC
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 23:35:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-61208b548e8so1293267eaf.3
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 14:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752010526; x=1752615326; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jAqSpSreN7k0eCQqrOVWgcU9Zo3/uYzqZkvtdabZr5U=;
 b=DtgO6MksqeHhM4Xhi8iRd3d44uiYR+vqRaO5NHa2aEKBZJapVekHQU7d8GGKaG9N1e
 /v/A7FfEtgsPPEmcJYO7ThXQhRmoFlvRfpE9DXoieVw/66Xfu8DmN6ZGo83O9zKQFG99
 bsyk73yuG3SBxZmfJv3xJzGtmsiS1jRjqmBb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752010526; x=1752615326;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jAqSpSreN7k0eCQqrOVWgcU9Zo3/uYzqZkvtdabZr5U=;
 b=TX6PDs78QYhl4Jv30PokuaNAM51tBo3gfiMC2mLRcf/BJpk0H29fo4uA1YImOFSYIh
 Yyi1vT3B/m3J/1vDIIytsobk0x4/Bo41ZqHS4Pss6ZQtfGAdlGxNy67aMEcRZmX/CNTs
 yEd7NdlfkvGJijH+kQtTjruB6k2GUW4TNAFj322A8ZnVgieQJfGvcwf3GRqkLbTd7U5R
 9v0Vy446OGgmwsIQ3Klx/YdzgIEZQx8F4hhZLX19vDjlfgWY9xxrzJZSG15CRPAAtxhC
 z2pHyCto9j7p/RCmx73CAwCB0xpRWD35IRWqyyTaAtbjMLfgFRWiziubn13ELaCgV6CY
 RDlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVc0wmSs7hJ/wa0Xs/UiUVf+G01V42mH88Xri/CAIQZgf5ntnr4eMzN1QObuORepsvuGLGiqRk=@lists.denx.de
X-Gm-Message-State: AOJu0Yy6YmZDLvOxOQYV9S4i2c3VZ7jI0Yp9MRN3JCPpbUT6vWtRn4/z
 YgtrVk7rbBMd1+SrKq/GkPEyFiOltit0h1Jv72LnM68Z86PHKbFM1ALuSnupgJ6+Vn0=
X-Gm-Gg: ASbGncvI+6O+lwLxAUOnY50XdtlG+lax9FyRv0HQetiDSBjsyNi3HJjmGh/Xt+5KzIQ
 n72OOyVywhvgNX0YYt4kxDM53wp+P8Aq3Cznj+8Wg8O3fPPTK0qRU4USi1XoH1p/HeOxh61vlHQ
 4VFifej2BslSGYewxXWUe7qfnV8MWnmai6JIU+2Ud6jC5DoSmQq9/c5iyrpYwsZN39OhIPPaGd/
 JoKNvoP/UoUwk4fQ9Vmwny4nC4GowpniaXv24U5/qXoIGTZWVgRwZ7XCmsDZrMkqa1oWhwx4x8/
 /nH/erdhomOEMZ0ak4BrRJ+uc1BMaS+siI9nZw88F0bDiyjvt4BLI7lBBvHzSSjnTM4eAxmgmGG
 8XmNAwcM3aE23pNw5ErZAA8ooJ1ICEQ==
X-Google-Smtp-Source: AGHT+IGaBVUF9Cj4PR5vnTHY49tqbXGN/ufrny7LLQfV6cShnblcp/3bqsTLoxnvuYmM1/TLGp+iXA==
X-Received: by 2002:a05:6820:308b:b0:611:86eb:ac75 with SMTP id
 006d021491bc7-613ccc14f46mr57911eaf.0.1752010526546; 
 Tue, 08 Jul 2025 14:35:26 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6138e5ad1d5sm1680604eaf.32.2025.07.08.14.35.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 14:35:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: sughosh.ganu@linaro.org, Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Marek Vasut <marex@denx.de>, 
 Olaf Mandel <o.mandel@menlosystems.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Yannic Moog <y.moog@phytec.de>, 
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Prasad Kummari <prasad.kummari@amd.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Sam Edwards <cfsworks@gmail.com>, Jonathan Humphreys <j-humphreys@ti.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, u-boot@lists.denx.de
In-Reply-To: <20250627185723.342553-1-ilias.apalodimas@linaro.org>
References: <20250627185723.342553-1-ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 1/2] kbuild: Update Makefile.extrawarn to 5.1
Message-Id: <175201052426.1302793.2601391504635958963.b4-ty@konsulko.com>
Date: Tue, 08 Jul 2025 15:35:24 -0600
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

On Fri, 27 Jun 2025 21:57:15 +0300, Ilias Apalodimas wrote:

> Since we are updating our kbuild system to 5.1, add the relevant
> clang changes from upstream
> 
> 

Applied to u-boot/master, thanks!

[1/2] kbuild: Update Makefile.extrawarn to 5.1
      commit: 22595e7430b878fdc769d7cd126828cf6a385b83
[2/2] kbuild: Bump the build system to 5.1
      commit: 5f520875bdf0ff1269e535fe215ec0ce481c7792
-- 
Tom


