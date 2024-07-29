Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5382CC3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 16:20:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1C5688842;
	Mon, 29 Jul 2024 18:19:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gofcuCX/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 906C2888CF; Mon, 29 Jul 2024 18:19:33 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8987D8881D
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 18:19:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6b7a4668f07so18469256d6.1
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 09:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722269970; x=1722874770; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jv7aK9RT9KUyScZgkl5/5hDUbtwtai7DGuEY1vGGuIg=;
 b=gofcuCX/WHAhL1pQUonjs71AM4ZGFExZpatZCkJKHC2qbHXpT8UCmVciLLugSeeVGg
 p//HgGg0JBnVnA1Iv3HCnH7XY9JP0GQ8hv+lM/ZIEMPO3p3mhfKT49ODd6lhExieondP
 z+qzsl97VvDo/ZYuPwN/Cutqdi8rJdlgi7Unc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722269970; x=1722874770;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jv7aK9RT9KUyScZgkl5/5hDUbtwtai7DGuEY1vGGuIg=;
 b=FrKvdE5d82R+rsUHu+KOA6XDO4i5zhOw8VR30zFtVoBUvbWKjEeEweWyfb4ho+vh8X
 ak2YK6pt2rJso577XP7CAbaRiKbsaWGsg7nhQj5WsaQQVEPwx/fJaUQKAK/CxNeJDn7O
 7sjk/xCKKWBYoW8Glh2BoBsfxlp4vDp1hRKw8TXNuIWKDqeRmi03RjVPKPp4ics5FTR1
 2E8Ao40wUjXFEvvLQNttMRCg/D3tbSB+Tm1/ScECmMLCJPWFCurm1ePs4MqR2LTaI0R0
 Hmz/s4lvDHx/NOzH1Rl3Qs3ItSRnEZlUjD1IGxcDMXqh4vOVMFV2u44d6FAhGmvTi4hT
 9gqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKnsLnDGFKqS18Ci7z/1TV9+Dh8gEXNK0u+WgpVhcwEhUsBN21J660z/H6XHDda7b6+PkvymPmiXG/6EPoXtT9htjT4Q==
X-Gm-Message-State: AOJu0Yz1MCsvixoQWK+UEoPoTPPAT1U1MDvncApnfkJlZgZLjCsFaDZL
 pxLWOw0+UyOp7yTOO/dBSBBYaPpQY0IlFXszTBe0gvHlcEfwkPI+dejSDw5KHrqTw8F2WfC4WSH
 UKMsE3YjzApe5Om7HCpqTvVfWnwAm8T60b+QC
X-Google-Smtp-Source: AGHT+IFzCZlDFPyhaKPPjKhUM9BwoyIJ9fNadgh+fVjnzUpVnKo2BysiTYN/pEYx9VcageamTetqYCh4EuKlHhb2kyQ=
X-Received: by 2002:a05:6214:f6c:b0:6b5:4e07:2a55 with SMTP id
 6a1803df08f44-6bb55a74f68mr111447606d6.29.1722269970440; Mon, 29 Jul 2024
 09:19:30 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Jul 2024 09:19:30 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240720104950.2730773-13-sjg@chromium.org>
References: <20240720104950.2730773-13-sjg@chromium.org>
 <20240720104950.2730773-1-sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:19:30 -0700
X-Google-Sender-Auth: fjQvak5x5UpnarsTssQS4IFxaBY
Message-ID: <CAFLszTh6LMmYpWmjXQyREoGWQbh5o505OO8HrjCKKWCi6ZV-_g@mail.gmail.com>
Subject: Re: [PATCH 12/20] binman: Add a bintool for fdtgrep
To: Simon Glass <sjg@chromium.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Binman needs the ability to run fdtgrep to prepare devicetree subsets
for use by SPL and TPL. Add a new bintool in preparation for this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/bintools.rst     |   8 ++
 tools/binman/btool/fdtgrep.py | 137 ++++++++++++++++++++++++++++++++++
 2 files changed, 145 insertions(+)
 create mode 100644 tools/binman/btool/fdtgrep.py

Applied to u-boot-dm, thanks!
