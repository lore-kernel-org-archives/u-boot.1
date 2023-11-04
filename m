Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09DDBC4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 20:53:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EF4586FC9;
	Sat,  4 Nov 2023 21:53:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q72sJIQi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B97DA86F7C; Sat,  4 Nov 2023 20:18:21 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D937686F6C
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 20:17:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=worryelectric@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4083f61312eso23993775e9.3
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 12:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699125476; x=1699730276; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Tyh4t1uim4lgU8yNQ4KORWf4JNxmi+/dY0uMuuvSfBk=;
 b=Q72sJIQi6Ja7vXADlqO7ybCyh5DcoW+A2v5QT+Md/XHZor05tQl0Ng/TygaB5SSUlu
 27kLRc1d4V8aeo6y60xvr3ww51RCH60ELe11ltEVvDhPV7g55jwQmKQOXwEsgoVA/DPH
 kw10+ebWSgwUo9Zil/xCAthtcgS79aKym/jJHrKm45hD2Ohx40iDSX/NKI6kXouDHd7j
 zB9OudLZBbHQnIPkhGDb4Vc8iBkYSjAq2OEn3wxla12oicOXDjBcW8aOzPc7Sv+RUs8F
 NimwLpV85MJKLYjwglw59r/916u7qXsHci57CiwtFCLvzzW4vamEQFv/uZz6C94KjPxh
 Qx5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699125476; x=1699730276;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Tyh4t1uim4lgU8yNQ4KORWf4JNxmi+/dY0uMuuvSfBk=;
 b=EP4J7f1hwvx7+6B9BWTZLdUwOH0BA0HgsmAMT0OpnfwG9KGa5Qfyp4w35T/QZtJlhY
 CrqcCF34j7pSIz5myiRGKEfQJUMqINboLaBxueGqBoWOV5nVWJ8xX2v+1jYa8dbosxM0
 U9+kdpNohvF8kJu0989YwBQSUbmouXxJ7+vZ5mhbzjf8RdtBTOGAWcSGnA+FEGy8YOHb
 lR2iHAYU1DkoqD1RVHCPiunoHrOP4njD3YlobmwQ95tsD0RD3M52TMSqGmbA7d3cGSAZ
 NGn+eJMdjmGNLgGHC2zxstk08XoJQzYW3TUopNwzE7wgCRfTs+nB5cz6GbYx3RS8P4d9
 xUZg==
X-Gm-Message-State: AOJu0YwDZ1YSY+ZWmkt5jZSOaqquLztw3yuEGXWCmphzYRifSp8mByfe
 RLQWdZc6aZO+f57r7CdDZcqkM9JYf8KSonNIvKhBtHbFLHw=
X-Google-Smtp-Source: AGHT+IFHGsVwnQV3EXUP0U4DXynA6UReOQL9Jbfr3OnFt5UQ9qrcigy9oVlhSrAAbmXj+Za9t582SrW0RWwAJfGuylk=
X-Received: by 2002:a05:600c:4f43:b0:3fb:a100:2581 with SMTP id
 m3-20020a05600c4f4300b003fba1002581mr21064187wmq.14.1699125476054; Sat, 04
 Nov 2023 12:17:56 -0700 (PDT)
MIME-Version: 1.0
From: electricworry <worryelectric@gmail.com>
Date: Sat, 4 Nov 2023 19:17:44 +0000
Message-ID: <CABZPTZSQHhcVuqLmg6nEiKBfF4p+R+y5sDCGaa19qztSEs54BA@mail.gmail.com>
Subject: Adding support for Orange Pi Zero 3
To: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 04 Nov 2023 21:53:23 +0100
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

I would like to contribute improvements u-boot to enable support for
the Orange Pi Zero 3 board. I have already gained a good understanding
of the project and the standards for changes, and so I have made
modifications and tested them on my board.

Before submitting patches for review I've got a few questions I'd like
to discuss.

The board is an Allwinner H618. From what I can gather this is just an
H616 with minor changes. The changes are so minor that I've been able
to implement the support as changes to the existing files for H616.
For example, to add LPDDR4 support I have been able to make changes to
arch/arm/mach-sunxi/dram_sun50i_h616.c and done so in a well
configured way that won't impact anything else. Is doing it in this
way acceptable or would the preference be to have a separate file
(e.g. dram_sun50i_h618.c) to keep H616 and H618 separate? The way I've
done it feels right because it really is just a minor upgrade, but
there might be other opinions I should hear first.

Further, with regards to attribution, all of my changes are based on
code in https://github.com/orangepi-xunlong/u-boot-orangepi. I've not
been able to cherry-pick changes because that codebase has departed
severely from the u-boot master branch and it's not as elegantly
maintained, so I've had to surgically move just the changes required
to get my board working. Their repo is correctly marked as GPL-2.0 so
compatible with merging, but the exact author of every line of code
will be difficult to attribute. Is it sufficient for me to cite that
downstream repo as the source of the patches?

Thanks in advance. I've not submitted a patch here before so I could
benefit from some hand-holding to not create problems for people, but
I'm pretty confident that the changes I've made comply with the
standards of the project and that there won't be much of an issue
having them accepted.
