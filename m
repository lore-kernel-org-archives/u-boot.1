Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA739E7718B
	for <u-boot@archiver.kernel.org>; Sat, 28 Dec 2024 00:53:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30C4C8036E;
	Sat, 28 Dec 2024 01:53:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZJkeH75e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16ED8804E7; Sat, 28 Dec 2024 01:51:09 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8CC980462
 for <u-boot@lists.denx.de>; Sat, 28 Dec 2024 01:51:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7b6ff72ba5aso631926985a.1
 for <u-boot@lists.denx.de>; Fri, 27 Dec 2024 16:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735347066; x=1735951866; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D5R9GDpHbv6tDZNZRyGJ7LhdBZjubgj+iMVu1p1ux4M=;
 b=ZJkeH75errbgX5BkCu9lm0ewl0N6dpYDVKgS0GlfIhWEg/YVfQ/QnpR+bPRSCr0JRj
 t/pJkh/wuewt/CVeKKAF2s7bSdPvJqc8Czm3wLQJXjOn0av2GOiOH6U/5yY1NvCzd3UP
 d4ahE9lHaiL7P9WXAMO+rEKqtFk3Bd2rYE1mI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735347066; x=1735951866;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D5R9GDpHbv6tDZNZRyGJ7LhdBZjubgj+iMVu1p1ux4M=;
 b=Z5h5mD8rLoZa0Dlq/y3R0Js7B+Bp1KiZFuoTA0kHVUBHb3edBN2pvHNXPTpIsShZ2l
 zvnbnlHJ25TQv7pavmWF2rhqo2nPnwhoFh564nn1RD/SVhhqb8SRpFYHPiXWOdV+NJrf
 MR0HpscytjYrHFPOy7VNY9zI+LJGkxvrXUtV0rieXH1TSW4+0oF8wvWXSNXHOrFbCIJw
 dWGQ3ggaXc4KaA9mr/Lp+mjz8RV+N+iK1zrJDtySzrSbq1ly8OF/fXGbBUgKUoC0JWBD
 pIIxW+QE9u9welTjKrYanmmj5oQNQvJi5+dFdNO128REaSjiB0/DjtoApU/GjlpQnlMY
 8boA==
X-Gm-Message-State: AOJu0Yw9aDgJDUoZb5kg2pIB08Wn9QC7J/VKPPXHQIKs7VMLRahvmG5v
 UpC2p80KUNvvscSe2N73BAeqRGQpuucW4KBd4OvRdgM28iLYZLpwUhj58Znd83c=
X-Gm-Gg: ASbGncvh5Rft/yMYRY4nVPsFnMBA8VzYPf+YJbUmHfEKkp9MllKuPGC9SSHcRdVRDBv
 PZNY4EyV+kDWZAZhJdgndb+MPLWRb7Jzg8qEedJjDdUhR5wsuyoruyKBcKCKFLaFuD490iPAYM5
 gavhqInDMNjodEGKlSRWxTxvDXIMYp8qork1PrgBjinmJwe4ZfE8Is/WpRNr2IvUmkz31/OOszQ
 zadyFbukxRlmBD5YBdpJKCLW8frccnRnTZeVzVRR+az8XCTaNYMHmJ8
X-Google-Smtp-Source: AGHT+IGg9lSiSvYyBI0NKwYeg9XbBl02j7PO4M2u+N6ivl9D4jPrlnuvgXMXnQd9nGtJx0QlOPGrNA==
X-Received: by 2002:a05:620a:28c4:b0:7b6:d4ea:fe8a with SMTP id
 af79cd13be357-7b9ba71694cmr4182326285a.12.1735347065889; 
 Fri, 27 Dec 2024 16:51:05 -0800 (PST)
Received: from [127.0.1.1] ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac478d9esm743669485a.77.2024.12.27.16.51.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Dec 2024 16:51:04 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Alex Shumsky <alexthreed@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Devarsh Thakkar <devarsht@ti.com>, Dragan Simic <dsimic@manjaro.org>, 
 Gary Bisson <bisson.gary@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Joshua Watt <jpewhacker@gmail.com>, Julien Masson <jmasson@baylibre.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Lukas Funke <lukas.funke@weidmueller.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Mathieu Othacehe <m.othacehe@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Maxim Moskalets <maximmosk4@gmail.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Michal Simek <michal.simek@amd.com>, Nam Cao <namcao@linutronix.de>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Paul-Erwan Rio <paulerwan.rio@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Raymond Mao <raymond.mao@linaro.org>, 
 Roman Stratiienko <r.stratiienko@gmail.com>, 
 Sean Anderson <seanga2@gmail.com>, Stefan Roese <sr@denx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Tim Harvey <tharvey@gateworks.com>
In-Reply-To: <20241219182907.2609704-1-sjg@chromium.org>
References: <20241219182907.2609704-1-sjg@chromium.org>
Subject: Re: [PATCH v4 00/19] vbe: Series part E
Message-Id: <173534706106.3688152.3160349170861076093.b4-ty@konsulko.com>
Date: Fri, 27 Dec 2024 18:51:01 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Mailman-Approved-At: Sat, 28 Dec 2024 01:53:30 +0100
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

On Thu, 19 Dec 2024 11:28:48 -0700, Simon Glass wrote:

> This includes various patches towards implementing the VBE abrec
> bootmeth in U-Boot. It mostly focuses on SPL tweaks and adjusting what
> fatures are available in VPL.
> 
> Changes in v4:
> - Add an option to avoid code bloat with rcar3_salvator-x for example
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


