Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B07D1CDC6
	for <u-boot@archiver.kernel.org>; Sun,  7 Dec 2025 14:04:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3580583A83;
	Sun,  7 Dec 2025 15:04:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uafuBdue";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74B5183A8F; Sun,  7 Dec 2025 15:04:35 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52F41800AD
 for <u-boot@lists.denx.de>; Sun,  7 Dec 2025 15:04:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7c765f41346so2090020a34.3
 for <u-boot@lists.denx.de>; Sun, 07 Dec 2025 06:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765116272; x=1765721072; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VSpzIscPD5qnLa5QAQrGvBWLZeqwoSh8j9U3HLam/6g=;
 b=uafuBduehUk4Pwhd2vVUvNJQElKptmDTD+hnyW3D6n/LqZD13d7n35kgHh81570mUx
 zZ2It1tuVjQuXpUSVNvAoYvx91XTPKZaOQJHauD+JaRFGaiiOCH4pNywR4UcuIah8ixh
 HjQL6SRytJU1XiqNH3riszj79l2rppW+PbIfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765116272; x=1765721072;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VSpzIscPD5qnLa5QAQrGvBWLZeqwoSh8j9U3HLam/6g=;
 b=GT5dRJ9xVewUMA9o3pSc9ZEGnNx0wpqTCl2iFf1/oaU2VPVIMLkuYuwnYaSZnwTYUe
 B9Igndx6ucrY4BK3JoWcjgQgoVdjhtBLIPUXzCDnQxwAgCyiVA/49LlNRkZjY0aYOy8N
 /NBPyIeXG2HoPfHC/D3E1fKqN3cT3FtHtgBVc7NI6rJfkSAfJKQiroby7PgY9YFXQYSv
 13sr4tZyvL0LLDQFDVNNlzz751OA2XjkFlPquoKRfgyRdBaa9sYFgIXPdbduITkJ8UcR
 cjQz+XZLnIAvbaQa2zOIsUES4yZoaikC5pVQTO/1g39kNvCtMDItFUus2wqOfvzxLgDm
 iPqA==
X-Gm-Message-State: AOJu0YwD2s2yrMyst6nrI6Q2hRGcyTPb4cF+KRABEekje1AiFMuLieEm
 8shFxVbVsrIzGLlHe+Z0kX1DpSwuIug5ppiJyw/KYbuKMhJW01YyneC8z257aDwlopk=
X-Gm-Gg: ASbGncunmfchczjgtsfETZchXMSEwdLKb/XLr/ghnFedczo9TUmGQKqMFIkmwCp8+QJ
 yGZ374VIyv9AH+Kx1p7/NspjsR/FYowErYRiwQzc64df55CGGqutM8HxmiuGkU7Pt/tuGA+w+IR
 0RdLTKnx3JzvCnVuiaZrnsB7HKeSTolWfA7u3tSKEqsR1HpxxF9LTW6gAK//9YHELKKWYdGf01A
 IhNBDxxyQK1+lwtiDw6124H5eUXmcY/47rqJccoau9PVjcwdO9zCxlNM8EcY5s/5QYzDnHtRN5D
 +jOZHmbPA6WdaXnkRoLjCP2Fcy0lhE4hVN6Mrf1UA7cezVkm+qfhLXAYN+kzJoqs2XHSfjGJf2E
 PZShGGowZdOpIhpnI1UTeJ5jt29Xl8PmeStopLAVr4NfGY/kaNAe03MLBgbVZqvS/1/TeZFGD2N
 2RyqzYwevlFwdVvmipyO1IKLbzFcV8aV6ecQh1ZSJIJOV1+snk
X-Google-Smtp-Source: AGHT+IG3PTdDbekuc0Waz6g2V4mk0hSc8pU+FZIhZcgL1Z6tIp4FJhCQo6aFIjSHuKgnu39P3OCd9w==
X-Received: by 2002:a05:6830:439e:b0:7c5:31b6:435c with SMTP id
 46e09a7af769-7c97082705emr1940111a34.29.1765116272010; 
 Sun, 07 Dec 2025 06:04:32 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95ac84d2bsm7892068a34.18.2025.12.07.06.04.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Dec 2025 06:04:30 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Quentin Schulz <foss+uboot@0leil.net>
Cc: Aristo Chen <jj251510319013@gmail.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Shiji Yang <yangshiji66@outlook.com>, 
 Anton Moryakov <ant.v.moryakov@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 Bryan Brattlof <bb@ti.com>, 
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Eddie Kovsky <ekovsky@redhat.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Yannic Moog <y.moog@phytec.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251121-binman-engine-v3-0-b80180aaa783@cherry.de>
References: <20251121-binman-engine-v3-0-b80180aaa783@cherry.de>
Subject: Re: [PATCH v3 0/4] fit: allow signing with an OpenSSL engine
Message-Id: <176511626899.2893301.2583109659075084831.b4-ty@konsulko.com>
Date: Sun, 07 Dec 2025 08:04:28 -0600
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

On Fri, 21 Nov 2025 18:14:56 +0100, Quentin Schulz wrote:

> I have a couple of products whose U-Boot FIT is signed via a proprietary
> OpenSSL engine which only expects the name of a "slot" to select the key
> to sign data with.
> 
> Currently mkimage fit support expects either a key-dir (-k) or a
> key-file (-G) as a toggle for signing, however this doesn't apply to our
> usecase because we use an OpenSSL engine (so no key-file to provide)
> which doesn't mimic a directory layout like key-dir implies. Moreover,
> binman really expects private keys (.key extension) to be available in
> this key-dir directory, which we of course cannot provide.
> 
> [...]

Applied to u-boot/next, thanks!

[1/4] fit: support signing with only an engine_id
      commit: 5207e1ff20ff26e0f3969b13701bb38610183c6a
[2/4] tools: binman: mkimage: add support for passing the engine
      commit: 9f9de386c1e54e6b009e5510ff335ab339a89a62
[3/4] tools: binman: fit: add support for OpenSSL engines
      commit: fc75d216f0162d4a85b60fefa9938b8690480e27
[4/4] tools: binman: fit: add tests for signing with an OpenSSL engine
      commit: 564c6682fa9689e408e6b795cc8c8c40e5e60e81
-- 
Tom


