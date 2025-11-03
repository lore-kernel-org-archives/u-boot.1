Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22BA1CCF9F8
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 10:29:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74B7E83642;
	Mon,  3 Nov 2025 11:29:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LD7mLZlh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FAD8836D1; Mon,  3 Nov 2025 11:29:35 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC2658331F
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 11:29:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7c5308f6aedso3062827a34.1
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 02:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762165771; x=1762770571; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3Fm/JFbWWoxAHhevdkcfchDkctKFOyfGpDZOAmXLPTU=;
 b=LD7mLZlhL106W8zfnoQO0Aq124oCylX03WxGDJf7wM55vrStp6NzeYs7lg7gqjaWTK
 6XeMuL8M16kGlCAce051dTNcw0QlAVEJO0eoQlPqqep7sHDEo9XqzTK2GeUsqnulxtN8
 asGe/Drt2Wl+lCGQQc620l+6GGfkBtN/CnVWJfeq8sZR6XTgfBAO5JxXgxoiORF38aaz
 oWozfBtmAJUcGJSW0kiCwP9D2m1jTcAJ9ZYSORKyixZLBz72CwtPIxDw0TpFsHOUHd/y
 GS/51ui/fkr8qNGXcnp2a28khfpWQfGQ50pp5NeovTFusCq+CDYUpNTmlXZsxLFfnziD
 736Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762165771; x=1762770571;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3Fm/JFbWWoxAHhevdkcfchDkctKFOyfGpDZOAmXLPTU=;
 b=t1Y90jqbRATc+FuUAnLXaISrlq/MUYfbuYFRaci7DH+bXkO9omuZflh8B9vcLjJU9F
 EwPR32Bz2HCKOtYG4OdjLpcpZQvoMb6IZAl65UjbbclqsZTTU5lxLTY+h7vqhu8jzkSu
 yds/2KdZwENlcEq128oxL7Wf6B/37L0nOC78WPc0P4Ua/DFNAcqH4YNSEOo+Wh1xwWS0
 AIy7muZ37IMlQGqVfnfkpjTp60ww3b9eFvoKRncPBaeQmUE711rj6CQEbNgS8AhFSJjH
 STsTOFG7Gmp8iXmUUzfCE/j8XKOTcdh2aIxtnX9JD0tNNQoY7EkxqklWCwdn0JrRJENS
 97Gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvePykssPyyiIkU0uSGuc7EBfap1RmhbBXA/jzmbYu/JRVg/8WqF7RpBU1Twp9zuKv1rWUZ9E=@lists.denx.de
X-Gm-Message-State: AOJu0Yy2BqRSgfttKHR8OfZNtKLryYSqOT9VjPXUrZ9HJn9D/LWNiZnW
 UQTmX8VDkQeaET7pS3trq2bOnHQb9gq6BGavPpfnW0m5ckbQgQZRO8+qWZVRfpIm2r4NFWgN1qz
 TJsLRwRfvTRsTLwCBaI3jwad8vPZtnRs=
X-Gm-Gg: ASbGncucwlsnPRi6VQeNbV033TfaCHNOPRwN+J+zTKiBffp9efpReflnNyvCeUFiOxv
 mI9Snr9okhLRmFIC7J97PGq2cQA9bsX6JHItZKST7D0OdSZo2G34tc0dvoPDyyy2+MrNjUR1kAQ
 N2ToiGQrKwveg/k+MyVrxO0Di1XyhLqxHbLtGGru+RuPaCFjBhdi+ta4A2TFs9xIR7b0ofJSMnn
 2kvJcJqXJ77BiAg525erKSyxI92ahnEpm8Vc1XkrRmH6a0qR1h0431gjtwrzQ==
X-Google-Smtp-Source: AGHT+IFM96tYwvW6l/YXTqCoeemfpRIjvAg/3XlBbjbZlz9uyXNo+5Te3bNJ1gWgZ9CO5O2JSCiySz00X6wJxsCuuZ4=
X-Received: by 2002:a05:6830:838e:b0:7bd:bc5:fa9d with SMTP id
 46e09a7af769-7c6967bdcc7mr5962661a34.29.1762165771440; Mon, 03 Nov 2025
 02:29:31 -0800 (PST)
MIME-Version: 1.0
References: <CAN7C2SArdbhag_56MwOMGoaEYSLiHbHHo3KFhUS5U03ntEJbGA@mail.gmail.com>
 <0f8fa8d4-3cab-4555-af1e-03feaef81ca5@cherry.de>
In-Reply-To: <0f8fa8d4-3cab-4555-af1e-03feaef81ca5@cherry.de>
From: Sune Brian <briansune@gmail.com>
Date: Mon, 3 Nov 2025 18:29:20 +0800
X-Gm-Features: AWmQ_bljcvfm30JKEOFkpwzB12bo06xJ8rilEUP5FfwY0-i1_unRdh8Pwpd3ny8
Message-ID: <CAN7C2SBiONLZLy3jwUW8OE2QkvJ+N2Av8zcu5PEPa0zZmPNOpA@mail.gmail.com>
Subject: Re: [DEBUG] rk3399-nanopi-neo4: SPL SD init may report -5 due to SD
 power-on timing
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

> the vmmc-supply always on (not configurable by software) so I cannot be
> impacted by any change.

Comment on this.
The nanopi neo4 has an sd card slot and mmc slot.
The initial debug mail is only targeted on sd card.
Where the MMC do not have any issue and this is
why puzzle me at first place and yet this SD boot
issue is having trouble for a long time and not been
well investigate due to different works.

w/o reverting the regulator patch the mmc still able
to boot w/o any issue. And if I read correctly. The
NEO4 board EMMC uses main power PMIC rather
than additional power regulator [1]. So this is a huge
difference in timing and boot stability.

Brian

[1] https://wiki.friendlyelec.com/wiki/images/b/bb/NanoPi_NEO4_2008_SCH.pdf
