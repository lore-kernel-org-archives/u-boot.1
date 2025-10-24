Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEDF3CCD1BF
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 16:06:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31CCC836A3;
	Fri, 24 Oct 2025 18:06:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GmzGEigS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8208B83700; Fri, 24 Oct 2025 18:06:06 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE1E882A9E
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 18:06:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7c2766675adso1337711a34.1
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 09:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761321961; x=1761926761; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=m9hznULe8dAVJ8OKZYgMz/FcyHtlT2/Wcg6rm5dUBoA=;
 b=GmzGEigSrH9WGqw952XE95TjB6oJJ0p+nlFyFf3F1WFxXdql5MA52SWLye08J0Emkm
 jemXUfKcnsM5yJZdEuP3QW09nhNKM0h3HLuXhIonc0uhqevQrSVX3bP5QYdvA3PQThCb
 fTd39AFG+Bd85LQhkUGm2SvH81qaJoyOGOyG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761321961; x=1761926761;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m9hznULe8dAVJ8OKZYgMz/FcyHtlT2/Wcg6rm5dUBoA=;
 b=MIq75sIslDjAO70ylTi+wa3O8gZ6TjCQWsD+hzjMunoeBTvMtR80Jqhix5K/ut2LEO
 zU55dg8Dx0m0ElwV55DI0en5WIHaG5qkfEwO0GnmwdhgwfKGXkGBU/ecF/leFNZVi9n6
 Gnaltt40nCgR5MZN70rhGkTwtHgYhjbfCYc24IYqhyPND8aEO6oJtXMOcuZrejcz1fPY
 AlN3yRRy7kG2V4cedcngcngPIWPkZLJ4AYGY1Gl0MZlecqtYSt9V8tzbNSc6hep9eHS6
 RUHrjhK7DU9acM03CCP3k/pvBIWh86GZiIajeRL9KgyksqJbqtpNeS7n2+2RqsJSJMEw
 YFOg==
X-Gm-Message-State: AOJu0Yz+T6Mdz9MfMmAR4yQWD1yrA73vRzDad0Mdd5DETlgvJtDkmJN0
 n+/00KI+dDWu53Uk1BrM7CBe5k9K9Y2BI7MpLmElp+iYNTpcvpU2/CaBUW0Mem4ag4qk3qeL14g
 bpp+5BB37qQ==
X-Gm-Gg: ASbGncuEk5eETPH6FwHE0xJGDBcQ/CM0Q2pITo2gCcD06StxOxrWVK/CXB+EqoSQi+m
 Tfu6gJckZjmFa6FHNbRFDh4BXH1VgGcfB1VMOoWV1pIe++dUs1Ig5CaKkwJnpfo0/Hevgwmeo5e
 9fl9+GYE5ITz0mZQ6HjLUV6YXVfKBXS+yv/n4njHdEleNl+XKe8NcH7hzOTUP9e9/j2/OofwX0/
 3OWiMAuAsi3FfeJsyMv0UPdHrKTELW0KK2lLZAd7gMEFP/MsIo0NNBswlF8M2Q/qPHS0NjEbrML
 yhTY3F5VRCBli0l8HDFIvTrZX+pRrkxYQZr3PzlU7yCpMj13OXKf2T7cCDc71GFPA2Gva8itUvg
 5WbAd8i4xL2+D+XKrVfq4c1wDSo4PYKJdC1ZWbtviTjmNDZo6hb9VaIFdvHnmj5lL/EI9UeEFFv
 HzdfNb3DIKHYtpLQHsRRm3RH68dXMC8oZKjqz9eetVjY/RisSQbNob
X-Google-Smtp-Source: AGHT+IHf03W2ACMQkyeJG+qc6PPSrSz76s3Pps60SieH2wLNi6RpdI/YxgbW/q62KBO4W7AltRLC2A==
X-Received: by 2002:a05:6808:1514:b0:441:8f74:f1e with SMTP id
 5614622812f47-443a318172fmr13523954b6e.56.1761321960220; 
 Fri, 24 Oct 2025 09:06:00 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-654d7fb99d1sm1250225eaf.9.2025.10.24.09.05.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 09:05:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2 0/3] doc: Add a general note about $?
Date: Fri, 24 Oct 2025 10:02:56 -0600
Message-ID: <20251024160557.2317081-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hey all,

This is v2 of a small series to first add a general explanation for how
$? is set by commands to the cmdline documentation and second remove the
redundant information. Changes from the first version are adding
Quentin's tags and rewording the added section as I was incorrect about
how invalid syntax is passed along to the user (-1 is used in the API
only). The first patch adds this new text while removing the identical
(and sometimes incomplete) information from commands which had it. The
last two patches remove the information from cases that were not quite
as clear, to make review easier. The commands which either do something
different or provided additional information about what counts as
success or failure have been retained.

-- 
Tom

