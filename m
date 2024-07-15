Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA622C3DA4B
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 13:34:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE8F28882C;
	Mon, 15 Jul 2024 15:31:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ayr08ull";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B068F888EA; Mon, 15 Jul 2024 15:31:45 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9650488913
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 15:31:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6b5def3916bso25865496d6.3
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 06:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721050300; x=1721655100; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9O773S49OAeKAhYY9Ukr8menHjU29Kbitzt+N54cN/k=;
 b=Ayr08ullhIEVfS59p2gvN4NGOfbH4X2H0UvNFVsvo07EJxZYEUXEf2bIjOwXL6ZFyz
 rS6KQtIBuQiqCKQ4ELqY1N8GSMY06tBvF65pM0mvjH6wqj0qY4pHhYeCbatz24MGinR9
 JkaHfuVbT2Y2OtgjkjDv/TdQUbe7clgq4CYOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721050300; x=1721655100;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9O773S49OAeKAhYY9Ukr8menHjU29Kbitzt+N54cN/k=;
 b=lJbw2Foeg/9n0noXTevkoegSF0FMLJYbHzjnVoVALbe/s0fCTGSEDchAaqu6U94Wv2
 oer5C/a7KCvZyekupb3jXVUUikw37RvPPZkNq82/kGHhTTqOMQRBlHZbdNF1wse58iV8
 PoIMJEjwGp+j2VmjexrjnBqWTU1jdLNF8RnesxLCrTv3BJ47JucQeRu9qzGVe9yaxBE/
 XZVQBn77uS/wMKhibeeEdexhE6cAf9d+tTz+cHmShjiiLGadaIkPgFTl8C5WRpu6wDQA
 3YOjM1AUjIITAm2uyAkMnemD0x7FuPv6onEOBLUqmvILqRBU1ocHt8OuEjDhWkukpHew
 K9jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxt9C3wLWWX3wlNk1yZVzl8cjKj+ZFyh7WSDUhZa/4ooBqjKeT+kx+v1NQSzRsBlcrMWrzSnZPRSvxEV3iBYYB6D5A4w==
X-Gm-Message-State: AOJu0Yw84rmz4TZf0JDHCp5c3ykNzYebhUf2ayowLKKEqmf3FSwXIYCR
 bGc4v9NDbjbc5wqqLA94F1xfCn5GaXiOSlkThnOOAeTkJKYQvasHDy0tzqTP12DOlsc0arhYnXx
 BO3l04mAfTsLR4xFOIp2aAXMFKH/5Fa8kHmwZ
X-Google-Smtp-Source: AGHT+IFAIgED0hujPVoYW+/Msp3E+SGTtPDav1A11CbAIQoSroRUlcX940Sp+UdPvaXqw1D7QxlKnRmaNK2oJaRKzsk=
X-Received: by 2002:a05:6214:1ccc:b0:6b5:dcda:bae5 with SMTP id
 6a1803df08f44-6b61bced877mr227629386d6.25.1721050300556; Mon, 15 Jul 2024
 06:31:40 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Jul 2024 06:31:40 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240623175515.1466908-3-sjg@chromium.org>
References: <20240623175515.1466908-3-sjg@chromium.org>
 <20240623175515.1466908-1-sjg@chromium.org>
Date: Mon, 15 Jul 2024 06:31:40 -0700
X-Google-Sender-Auth: pY6TjFoaZVEyh62yDhNfppjyFjA
Message-ID: <CAFLszTgdvYXO3PokEJn7PfFN4xLASws8wDKN8U9C8KE+79Jhuw@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] binman: Regenerate nxp docs
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>, 
 Lukas Funke <lukas.funke@weidmueller.com>, Marek Vasut <marex@denx.de>, 
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
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

Regenerate the entries.rst file to include this recent addition.

Note that more docs are needed here, to actually describe the entry
type.

Note also that the entry type needs Binman tests added.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/binman/entries.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

Applied to u-boot-dm, thanks!
