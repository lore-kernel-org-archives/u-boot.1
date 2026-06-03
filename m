Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6819CD6E57
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 17:06:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF8568486B;
	Wed,  3 Jun 2026 19:06:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iLe6W4vs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08884848D1; Wed,  3 Jun 2026 19:06:14 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22E6B83FF5
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 19:06:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-bec441e4018so465997166b.2
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 10:06:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780506371; cv=none;
 d=google.com; s=arc-20240605;
 b=jP45eEJb9u1o7vgv7DZ9/bE2GCLZHHOD60X5coKQOd0ebAtJRvFG8y+KzWUa/3P/vu
 /5PsdIdLCs1GNkXnOfiZmPJcwQCfzPv7gr0hPthoLMrddic3F259gJBDe0hdiUVBhrB9
 OshriBmSFzmyFgyIKVERpw140wsE+4iDHzk9hmD30aUoWRdDSySBNTSuJW/kYw/1u9MI
 Dh+JNy8pd6LzgL1wM7eepDCQlU/uvy89RhDc6C127w4PG/4b8KgbvNUjjujI178bH4uf
 yd4MH8fVL62tKzpTOi3oQllpf+E6o+8m1eQoWBEXCrb6uSfvIYQ0oV/tqQ0ts46QqoPo
 ST4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LKozdYp6NmXL2F1YasNkPrpW0nYxNoRZNO0U7REBrFA=;
 fh=gwzjD4vGZTGHEaLwDxs9dwIy/caB4c3esm8RkfvnusU=;
 b=Yv7iTdtH/6+oWXJmIGhJwxDjXGA0ZMprWNjzM2wwzSAiK/mNVcayv7ubQd0+8XE80+
 zMXqODfR6sne8dNZhxUplb9CdwuzBi3lxqw1CykLrLJ5mneaHogPQdVZlpgVtWkVBTy1
 SW0RefCxqsIoWcF7137yfK9ekBmGs49sB/URLwJf0cBZ1/9Q3mqWMXRak8zCzqrA3rAf
 yGbxRnekeRaOq8eei5M4cB2IqXXaDn+b50FIzUGauKblNdda3pP4tOEXH8SLFIfYiD3h
 Dkux/V8Tt0mpK6cW10NRwYw14qcZzp4HMNnHhE1KX7XDKTZH0FWPbEs35tjej89DonzZ
 S9SA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780506371; x=1781111171; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LKozdYp6NmXL2F1YasNkPrpW0nYxNoRZNO0U7REBrFA=;
 b=iLe6W4vszpW1JElJ3XQXRol1CNwT2abX3ack3Lxus4cuaxtN4rAYYKOxS6AZeNY3PL
 ETSkXkIfOm71B1RjbKeL0QZfQowKm6dCet9RNnwsjngNIJOPaHJW/U8xJeRZgFWAl7E9
 H7eGFqMzo1bDLjQ+49MQKH6UXM/FGy72Ebv4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780506371; x=1781111171;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LKozdYp6NmXL2F1YasNkPrpW0nYxNoRZNO0U7REBrFA=;
 b=oT+VOQyALQjxosuu7GabgmSAGu6byU5VcOY8OzTxOyFcFHSjMKz0QhjynP0Vk2ve1W
 CtCDiLvTu0WdKXqqqN/OolnFjDC0rD6+ArOdSfaZ9RJgTQdKnIjXy1Yj5SjYXoGQx9RS
 587z1PlzMvq5owCHNzTmh+42Cre+lWAKs8eudCr8rX915boaCfdwB1Fdb7CG+dMhlhHO
 uaJX0DzlyqYm19zdkCrAw46GcRVKsg/5w5rNrYxHVQztdAlgDoa5nUXakAgcsQi2QuK4
 CwsuNGla6hHxg72yFKv298B88mt9WWSzgI6yj3+p8FcyIhdrFwLro0uK1ClRr93WjBfn
 OubQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ97BrNePigkAbvp7EAxxBhhWL1D1TVhBH6bW/A2qV1tQDT8GwxTIptbFbR7nj8AUilCG0WriNA=@lists.denx.de
X-Gm-Message-State: AOJu0YwYKWsZPsE4eSsdrfsSvSxHdw5DADgnUTG3Zb7EFek6FVPtt5Tl
 muWFgshm8YCnE+ysoj1310QPP49uolgmqS2H8R8LQa7JH9+JqxzIcsfPMU5MK52umQiFlvyo9vl
 J6igs0SSqMmsHQSzk3vd9rAQHjHFro72LVIdlJHD0
X-Gm-Gg: Acq92OGeC/m0uczOEEM8aA+T+L5DPz5kO0oz9GCns0JkazUFxHyMnVWYBwKEVN/lgaD
 j36XPKVloNKiOwb9csWZvhTzlRcbKcdpfK+2fGNdvFc13x91Soh51wfqsq8I3x9YyoiLkj8SEq1
 Mv4oks7rrt5LfA36oPiOg/tFd2bdrnuM5vmNZlcPhA8l5fUFOQDIcFT27HFrs+FxlSSKfA+H6VU
 jlsqWfktN5DOCv21zwJN2J6zYAIMONCN1dbiy/pjnvgY9Nz8yUUclYTEUTJX7F6vDMt5OibI8hB
 OuKKGq7OEOPTbFlE
X-Received: by 2002:a17:906:6a1c:b0:bed:5a4f:9fd9 with SMTP id
 a640c23a62f3a-bf0ac306a7emr220725566b.6.1780506371577; Wed, 03 Jun 2026
 10:06:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260603095449.2089514-1-richard.genoud@bootlin.com>
 <20260603095449.2089514-4-richard.genoud@bootlin.com>
In-Reply-To: <20260603095449.2089514-4-richard.genoud@bootlin.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 3 Jun 2026 11:05:10 -0600
X-Gm-Features: AVHnY4LpB7Ge31lqab1ymOmON3nqDCDHtxZnFDunXP4eyDq2UPxVpalo7Zvsvy0
Message-ID: <CAFLszThMWvrC69PkQOaHwGDjBRagTLSDQ0FHWPN27czz9zkzig@mail.gmail.com>
Subject: Re: [PATCH v2 03/16] global: k3: use gd to store the resume state
To: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>, 
 Apurva Nandan <a-nandan@ti.com>, "Andrew F . Davis" <afd@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Bryan Brattlof <bb@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 Kendall Willis <k-willis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>, 
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
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

On Wed, 3 Jun 2026 at 03:55, Richard Genoud (TI)
<richard.genoud@bootlin.com> wrote:
>
> For J7200, J784s4, J721e, j722s, j721s2 SoCs, the everything is shutdown
> at suspend but the PMIC and the DDR.
> In order for U-Boot SPL to know that it is resuming from suspend and not
> booting, a flag is set in a PMIC register.
> So, at startup, U-Boot will read the PMIC register and deduce if the
> board is resuming from suspend or not.
>
> This state (resuming or not) is consulted at several places (in
> board_init_f() and in k3_ddrss_probe().
> As it takes some time to read a i2c register, it's best to cache the
> information.
> But, as stated by the README, in board_init_f(), the BSS is not
> available, so we cannot use global/static variables, only stack
> variables and global_data.
>
> Thus, we use gd to store the resume state of the board.
>
> Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
> ---
>  arch/arm/include/asm/global_data.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
