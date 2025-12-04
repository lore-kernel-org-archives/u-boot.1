Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B715D2A520
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 20:32:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDBF58419C;
	Thu,  4 Dec 2025 21:31:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WRpiEj0M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52F418413A; Thu,  4 Dec 2025 20:31:57 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E813B84083
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 20:31:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7c77ed036c3so1519802a34.0
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 11:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764876713; x=1765481513; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wRJIfc0MklaPJd9LnYWtMb8W9d7Xcg4wf/+jzrQvj/g=;
 b=WRpiEj0MjBwI7riIp4sCVNpYuaEbgozeVEtuD3dl6QOj8B2rPeMYXHd7zBiz/98me7
 0M7HP6Uk9NZyC2ue0TFbSX0aQ1keqEQzOJOUBTzeTJ+wZPSgSbX2qcBxvT92W+p037Yi
 QxtdrBnbJXRiaOl3YDS8IybiY+mxYB+E73Nbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764876713; x=1765481513;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wRJIfc0MklaPJd9LnYWtMb8W9d7Xcg4wf/+jzrQvj/g=;
 b=PZzUmIu3jypsYLgEo5SsG5OvxJLGFdZt8W75ewpDE9/oZ1nBkt/M8g9crdlWhcvTB6
 naSCYXJQf+KXkXAcqctp5oHJKPSg3jWBnR9fHXcRA68x4VvCzfDfuidyMyAdijr4pLLN
 N6VOErAQVQb3/NCmWc38nSEAunB6Z2IfA7wJF2bNgSDwC6hVqCLyPy7GZVpJ4TmqO0Xf
 Uy/rnM0zLDIgltpL6f0Lj/gaZsaza3TOe1sqgy74kvxnvsnfdHuhew4eyTidLDfvn0Ab
 bvt8NZcX5XhaBkeF5T0ckYfRDnyOwLF/KIehlO/7/+fcCyDnW9bZzud7stRRwUkH7M3X
 EClg==
X-Gm-Message-State: AOJu0YzAv+jzECT1yYydN49y9ZVySubz6cZhXNwgDWn+HE8rOq9Lxca9
 A3OSZ+FbLJKsLtm7RRxXqGtlWLxXVlO8y26P9+D80AjhEPXlKOWp29FLPY6z3P2Vcg8=
X-Gm-Gg: ASbGncsKeNqCpzuBpQA1/8uUZRyEEuBPEGbUCCVapJWw3CCDd0vzan89Q8qNgSdfVqo
 O1tjjaEQ8JAheakchBaLgaT/+GogyEKOn48U7kM7Te/QQ7vY8WgDwP7IUHIWtQILAATEqD5hcDE
 tGul8L2Q5T0tkOMQwOEeeL9/34YsaKZMPs9TZUBYHFqtjv8e6kgRuM0uU3jEc9UMqzQ0Nx3vG5u
 dqz297p52Il1cLf43k35KI3hgavWX0Bvt4LFt6M1xjrNFRZfonkIynH9y0NH2bsSpkK/q9XCr6o
 kFlQRqO+DyfoGZJLGNOK2irmNSs9a5Ucsg1WG89s9D0kkfbBGduJQAUg29ikpmauYqmHyzffCaw
 +2pDGHwkJXzdJhyDWNbuWB/c1a3IxhnyOw8opL0UbGQN62arsdqwVLJxAjcl7DCE9SZTGXflXCS
 3dpeuQPuD4Qp/aNBFdWWpoKqJx0q9VfimoIn9MNXwzyEC324Ru
X-Google-Smtp-Source: AGHT+IGXO04nXBtpC16Aj4reJzU6KbTTTepmLDLf8zFydKfpp2tixde4CrYgR//4Topqg21ASI8B1A==
X-Received: by 2002:a05:6808:c194:b0:453:74a1:7ec with SMTP id
 5614622812f47-45378e244abmr2798034b6e.13.1764876712697; 
 Thu, 04 Dec 2025 11:31:52 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6597ef0c840sm1147095eaf.9.2025.12.04.11.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 11:31:52 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Heiko Schocher <hs@nabladev.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Anshul Dalal <anshuld@ti.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Greg Malysa <malysagreg@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, Martin Schwan <m.schwan@phytec.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Raymond Mao <raymondmaoca@gmail.com>, 
 Sean Edmond <seanedmond@microsoft.com>, Simon Glass <sjg@chromium.org>, 
 Stefan Roese <stefan.roese@mailbox.org>, Sumit Garg <sumit.garg@kernel.org>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 briansune <briansune@gmail.com>, Raymond Mao <raymondmaoca@gmail.com>
In-Reply-To: <20251118043042.27726-1-hs@nabladev.com>
References: <20251118043042.27726-1-hs@nabladev.com>
Subject: Re: [PATCH v3 0/6] Add support for SM3 secure hash
Message-Id: <176487670995.2050783.17410258029578449020.b4-ty@konsulko.com>
Date: Thu, 04 Dec 2025 13:31:49 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Thu, 04 Dec 2025 21:31:31 +0100
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

On Tue, 18 Nov 2025 05:30:36 +0100, Heiko Schocher wrote:

> Add SM3 secure hash, as specified by OSCCA GM/T 0004-2012 SM3 and described
> at https://datatracker.ietf.org/doc/html/draft-sca-cfrg-sm3-02
> 
> TPMv2 defines hash algo sm3_256, which is currently
> not supported and prevented TPMv2 chip with newer
> firmware to work with U-Boot. Seen this on a ST33TPHF2XI2C
> 
> [...]

Applied to u-boot/next, thanks!

[1/6] lib: Import rol32 function from Linux
      commit: 6a0c939b88fd42c6b0a374f7c87317f292df46a1
[2/6] lib: import sm3 256 hash parts from linux
      commit: 41c0131b950a16747929ab310588cf5db8e38123
[3/6] lib: sm3: implement U-Boot parts
      commit: c4ab316269debc321907acc4f8f02dfe5653aeaf
[4/6] test: cmd: hash: add unit test for sm3_256
      commit: 213601a600f1e8894cea76b0bfc131f038882407
[5/6] tpm2: add sm3 256 hash support
      commit: 7c3f05ad51e4bc23dd4f411f28968f1d8f43099c
[6/6] test: cmd: fix a typo in md5 test
      commit: b30557b3b46c5162cb88a57907c517ed95557239
-- 
Tom


