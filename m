Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA0DEE74ACA
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 19:41:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DE9689681;
	Tue,  3 Dec 2024 20:39:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JOcSqU+b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E40D488FAF; Tue,  3 Dec 2024 20:39:49 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0176B881E7
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 20:39:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aa530a94c0eso955341866b.2
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 11:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733254787; x=1733859587; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lnhmcxjJ5aokQM/DUCqGwP2qwjv5hF2XgwBOEj9DaJk=;
 b=JOcSqU+bQrN+9/UpvqkgTIewMzfgFtlJ8mzagyXYzcubm77hDaOM+6cFR3x90nRCnP
 N0xFhxc+KMBC+7deNgqF3v3TSvWcYeGIft13oU61m9gheaYIqBBgG0zhm5NdqKdAAViL
 E1fjNNfmeVVgY3nIrQQ8HQ/rRKiBd1R6glnRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733254787; x=1733859587;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lnhmcxjJ5aokQM/DUCqGwP2qwjv5hF2XgwBOEj9DaJk=;
 b=oGf3udOamJ9891uY+IVrxQVlCXxOPmL2RkDAFcBmd9IJsWw9It49LIkyeF95Rq6Ws7
 8cibia1wBQsRjJmt/inYADjoj1FfnnRF7+4iHzt7gpKPHYxn9kT3ODd+iKnAFRs99mXU
 PwVYdd2K4QtuoyK9WNxjM/l6JjYU0Qndjp4dyHHSqYby1eV4TAt935lbjjUEQrA+kPVZ
 dJGBuce/00qrr5sW0kEMU/w+ET3UPdBKOXMq01yattfXkSvrcUX19wqbwfzeDzthh2Hb
 4AoBtfgGyPxTlddzuZEm0kdvozxZBFPDicLBJEEcSbsJYU51Ab7AljEZ8S8RBqTpKClf
 zO6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+HJ/NWfSRIXU/0CQdnUZhEJV5xRzqYQ1slH3mNZFKn4/ESMWB0mhx2Vs/xS9dbYPVHpCk8Mk=@lists.denx.de
X-Gm-Message-State: AOJu0YyUUtWTQiWysz68KMwIOgiGPQmm7o7MieZsouCshKCcW0E2ApVb
 Gh41b1rOnKqqN5ySgZPAlOPz/pO0HazF9Uj8i6YbGhHHTNDamrfaoZpyRnPKUf1cz1kLeEVM1p1
 GsyjVMG1qkxARL2rhtFkd7TCVw0xbStCQQ3pR
X-Gm-Gg: ASbGncuVYuFYTXJ8RUztCAMzzDJq/y0QiHW+x8Kk0wIJ6N7npX3SIYWiYhiBN63rnBb
 Kghvagf/iGHOMEe3noNnwRvdueGfvRzQn
X-Google-Smtp-Source: AGHT+IGKSeq3x0vpZXEs5dSlW0gHlCtWmTBNpWTVMeHwgmMFJFKVnD8BXTWCQPITfIGwSzdUBQNRwQg19dxFxSJo75o=
X-Received: by 2002:a17:906:2932:b0:aa5:274b:60eb with SMTP id
 a640c23a62f3a-aa5f7eccf81mr270324966b.44.1733254787547; Tue, 03 Dec 2024
 11:39:47 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Dec 2024 19:39:46 +0000
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241103003322.626036-14-sjg@chromium.org>
References: <20241103003322.626036-14-sjg@chromium.org>
 <20241103003322.626036-1-sjg@chromium.org>
Date: Tue, 3 Dec 2024 19:39:46 +0000
X-Google-Sender-Auth: zklszXHoyWQ3Fwo_xRRvwBXmQlI
Message-ID: <CAFLszTgDLQdAOarABd+YqfvdHyYENZJRLgY=Ef4ynja-yy+Pmw@mail.gmail.com>
Subject: Re: [PATCH v3 13/25] pca9551_led: Delete driver
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Alexander Gendin <agendin@matrox.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Stefan Roese <sr@denx.de>, Wan Yee Lau <wan.yee.lau@intel.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

This driver is not used anymore. Drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/misc/Kconfig       |  13 ---
 drivers/misc/Makefile      |   1 -
 drivers/misc/pca9551_led.c | 170 -------------------------------------
 3 files changed, 184 deletions(-)
 delete mode 100644 drivers/misc/pca9551_led.c

Applied to ci/master, thanks!
