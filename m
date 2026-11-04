Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017AB606A328
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 09:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eIBNOZTt;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=M1tgr8FM
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CD612606FA;
	Wed,  4 Nov 2026 09:41:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aactt2jHKP1w; Wed,  4 Nov 2026 09:41:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D92A2606FD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793785262;
	b=MjEsTQP6o11gyxkYU7ZgkWjgHe8ruYCOV9PGoxGhmBcuAxG6tJLyR1L4EJC+rhl4PQJv
	 kGL8OuP+tAxeDKiZht8afKNACN2DzLJQx9wRjFZEgreZmdbrFw6CuxmsdJ59PFte2C8I1
	 dGhvoF2drJS978TJyM1Mr0tHzs7oN7U5RO25uNzuTbcgLkHdsWqqUeLM4JfgXql/Whhuj
	 5ivhxFI7v+ytIkEe8Tky9XkAu0BhehoeOkNQnB1LWJiYXEa3KYIaqOL1OVuydDUgoA9uq
	 LgjWs8oHSANmPL0Ub8ETCx5GvDX7+TJ2s0eejk+/0JYjnQhTLtRp/GNAoHDXgwpBeYA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793785262;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=80mPe+Om/X0CXkbvqltCDRL3OI1nx4r/YymO6nHy30g=;
	b=Biv/lEjdE/HkLcdle4Ud+OQnHz3NV88SKD6DAetfh4BXj3NGqkMa9I6Ml/YQWTD69c28
	 knLHFZTJlGDAjVCnB5pmMuzc1o4/rtmrLC8XVnBTYxCA4BRKgTkbAwgWHQ68zi9SSsVpT
	 53e6odIKw4ahxi3xx8sf3Ueph9Vj3qiPhCGzGXhgP7iTKDLH4B/TTN4aSbyYSMqn8MXg9
	 jHfll5MBUHj0V4HPESlkCnaAkYfiiKp59wBMMbmAgPs4JpLLXjNufT43rnb6lsjyERQEq
	 2/D55Y0i3ltAaNK53stwnDrIhoZwARpqNRM6uoKw3rWYjIMSY9Pofhr5YzMXgfZ4Kxg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793785262;
	bh=80mPe+Om/X0CXkbvqltCDRL3OI1nx4r/YymO6nHy30g=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=eIBNOZTt5pkF9gPZuEqVKNbbaVpmi9Sz7ceu2aNrMrSytPrqykqYS++AF36LtOivr
	 c/YwARrdnBhQ/c21XTb01KZBmQ7jQ2GXIw4z/Ws0d+Z6lS9b1m/sCFT4flm7Sr3EyW
	 5UqReyurHE0EvClchQckybAXspjGkTkD7MDQnnlm0Q+vN9umZZDSDFvhilUKHzMwZ9
	 RtC6eudkqAcYoyZXPS15VBcvMCdp66cZu9AUusrbzUdYxQ7t5Htk9xVSYXYJEm5HVB
	 hatUkArpSm/Yrx5ukQE8lfJ1QXGE2gjFWs60MUST7hR8gDzhBEv8PGnuiJXgeZIPAO
	 JyOoIp5XQkqtQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D92A2606FD;
	Wed,  4 Nov 2026 09:41:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 304EA411
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:40:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2D8F540520
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:40:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DvUEUaodaUgD for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 09:40:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C2E8540478
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793785258;
 b=p5EpT1cdcpQWh2cx+yDvOwqTL1BuhTf82k17b8rUa0U2cD+x12UAmPJ4qOgFazA2GrZa
 AHHyWsHR2pQxZCFyfuqgpN4sbvoT6P5zGWtbyGWo2hKszTAgxrZ6SXulYOs37WPN2/7zK
 W4OLZuytjLv+coRgEiRLN5S1Nud8Y981Glh3/vhuRwR3h7bhYFRMwSO5g5Cv0WfjitYXZ
 m2rnmV8sepYc0JWyAQYH8suh7LT8DXo4uRzgLtyzDHc+DHazUa3/sP0XqDX/U4xt4DjKW
 ZAmkMeMJrl7k5EC+Hwbs7OnQdckvi0Melc1rrlZq9+++Eh/4qtKFiayR7BtDKorJAqQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793785258;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=80mPe+Om/X0CXkbvqltCDRL3OI1nx4r/YymO6nHy30g=;
 b=LUL3ny4TpPO4aR99uat5mSC8ih/qld1mK3hq0fRl26T07CEhcffNWFRTozJe3FVUU1TM
 S1ORpnML8V7eLraffHg4Y5Dbr/SnyJfz9haAv48W4Ay4IW2wdQcSmhrmgIldA7HNeyJhw
 iQhlMyc7ggbYMOWdBE7BKbEnL1Yv5QS6KCPPsOV8RKaZkApwiNv2s0bMvq5MgX2UYF9xS
 jwUlgMcGCUaOrY8zY+Poyt3CQEaSzNeGeyw9/upulIL4IUoW904iPCNlIiz0AD79bxCku
 voPt6FO0NX3YpOUMNvF4J5yVyvAfvtl+549jCIYB+sxqeAnyQPicpTlev+/392gyF3A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=M1tgr8FM; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=M1tgr8FM
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C2E8540478
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 09:40:55 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so2776065e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 01:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793785253; x=1794390053;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=80mPe+Om/X0CXkbvqltCDRL3OI1nx4r/YymO6nHy30g=;
 b=M1tgr8FMNi9qUolnW5kzJIq0tjTtPzbHBDjXvqcrDM0/UFa+skYv+P8iU+aTNIVcUn
 AJY2QkLQtdbQTz24IkcKjtYf/03i70SWf2Kb+Y6vyvpZUl5nJRvbi1sq7gdpZW/an51k
 goT7fz3bUjYZDtYmhwYNUyjDMCAFn5YoggJYNfVWXjUm335C15QlkDkUvE8b0LFFyWsk
 JSTj+TeRGSkYR6tXyIEIYXx+rpo9/ZYlDgl/SPp4RCzZDr1ARGMBBDchXJ2Rg3ruoULl
 MyfuJErr1tlJTM1uR55PQrM8Q7YtkCewqnm7rVtjXhRz3p+jC4x63TEuzTqA91fxqtL3
 MdhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793785253; x=1794390053;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=80mPe+Om/X0CXkbvqltCDRL3OI1nx4r/YymO6nHy30g=;
 b=VtqnxynjhfNEhvth0EkNMjXrLa1msq6N4o01Ya/7nhNBlAXDYBGr+nZY7JxuIY3uqa
 c/7aRNY2yGTwbsxjfUKf0w3UX6kVuRfa1QyQ1XAGXZQM42ddtETMA9fPeL3HjACQfDb8
 lL18Aq2fgXcD9APRooh+73E5SMe6BmZ6YW4fqlKR0LgWFpPKX5JbHn3Y2pX7R/hbKwXP
 8rGDmEfdvIvsf959QdR+qySdtoW1FNtHKOVyXEfll3A6k7mOoszDZVgRGOjoq6kkv4wA
 VksVgk3XbY60ilMOnKMoY+7K+8JP+ESuhKS5VTQnX+BDUSp/zEtyaKPxLE0FKY0E9srx
 wqsA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw8KynshBEAco37pPAtfAL1E+2hVgpqkgaQuPwrbr7LcPhDXcrwTPfltdJzNANtQ8m2Hg3L4rA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z++5VfNy8goJxGYoVp7r/4+nydrPo7pk0mTGhQ1pCudHZiG3Dtv
 XlMbKg7g17bideeGp/0gvjd4LzsvKoEaSbHOWEqpOicnk0HmhjmWw/ZinW6N98NwB6bStb2laQt
 Rfz5l
X-Gm-Gg: AYBFou3w2KS8zHJby6fZCro+5MZmOm91T3j5L1XTqZ2B2kuWwbtbmiUOZZUb+hi1S0l
 PGamqH5j3synlmitaVUWtWsV3HSL9kS3QX6jOYB6AvHh8tlZAhMl9mnxhzkIc1QicGFD8iEiGEu
 utTxWKgU9uMhsgFU6fMsg/9GAd//yLLFpzRnQyBMIQgFPTSUme6zhF9V23gQMmGvkK+c0Hw9ICu
 8nghWWv77YXauj3QzgCcpfF5CGidaCMTkLVk3C/67j+0NpIlxeH9I9dI3po1+q7OaHR1ThNBf6B
 uE5++SSuoEZC9VWxiMbDZAAflsDeeic3WD4cYMERwGBEKTVJrS4QjeRgQjI3yEzq09pbRB2dOJq
 tBfa2yDAygRwgcjlDC3Rq1bsTaLkD8BOoFxs/VWXjoseYRPbgjAZb7EwEMi+qqPnyLlPy9IHQCN
 nPZcl/AIgDz1io/Zs1KT8ejsyc0U0ezVI2jJa/9qYwK1PHlslT2IxTThNu1JoEVbJWyAMdunhZd
 a5Sq5wFYsSpFqhVe5wAC4gdW+2ajG8FE/6xPNOPLk0HlOgsSCo7Iz0teUk4/E7quhCJtbnmWoDj
 6dArlUst4LI4X9YdntAzGJUeDQ0cWorfzzJk7m0YVBNQMGSOMNznycKJ5dHDj5wvdEqcMVoDLmk
 B9Uwapf8+0qKmmmwY17dsO2oCq5RrRc87yvtgiFB6DtMg4A==
X-Received: by 2002:a05:600c:1c23:b0:4a2:47:b79c with SMTP id
 5b1f17b1804b1-4ac180f2addmr411958305e9.32.1793785253430; 
 Wed, 04 Nov 2026 01:40:53 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b4527fed5bsm49856945e9.3.2026.11.04.01.40.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 01:40:52 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Subject: [PATCH v2 0/7] Support fastboot boot in SPL
Date: Wed, 04 Nov 2026 10:40:20 +0100
Message-Id: <20261104-ccaione-upstream-spl-fastboot-boot-v2-0-cf9781441ed5@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WPQW7DIBBFr2KxLhVMQgNZ9R5VFjMwNFRxcAFbj
 SLfvcTpBboZ6UtP7/+5i8olcRXH4S4KL6mmfO0BXgbhz3j9ZJlCzwIUvGml99J77AjLeaqtMI6
 yThcZsTbKucntmGAZLB6UwiC6aCoc089W8nF65jrTF/v2MP8Rhb/n3t6emCCsLH0ex9SOA9I+e
 IPoozMHuzMenCHjOEIIYMFqu3OeQImH/Zxqy+W2fbToTfaf8YuWSgZwIWoTyZF9J7xdEhV+7XP
 EaV3XXxGAh5U1AQAA
X-Change-ID: 20261014-ccaione-upstream-spl-fastboot-boot-5d8e28a700ad
To: York Sun <york.sun@nxp.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 u-boot@lists.u-boot-project.org, Sebastian Siewior <bigeasy@linutronix.de>,
 Rob Herring <robh@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Petr Hodina <petr.hodina@protonmail.com>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Daniel Golle <daniel@makrotopia.org>, Sam Day <me@samcday.com>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Test farms need to run successive U-Boot builds without rewriting boot
storage. Add optional fastboot boot support to SPL so an already-running
SPL can receive U-Boot over USB and hand off to it in RAM. U-Boot proper can
then load the operating system using its usual boot methods.

The standard host command, fastboot boot u-boot.itb, accepts a FIT built
for the target, including any firmware required by its SPL handoff.
Uncompressed legacy U-Boot images and raw binaries are also supported
when enabled by the board. Raw binaries use the board's configured load
and entry addresses. Legacy and raw downloads are rejected when SPL FIT
signature verification is enabled.

The series reuses the SPL RAM loader and normal SPL handoff. It also fixes
ignored errors when loading an explicitly requested FIT device tree and
invalidates stale or incomplete fastboot downloads, so neither can be
used to boot an unintended image.

---
Changes in v2:
- Split the USB boot acknowledgment fix into a preliminary patch.
- Explain the FDT output initialization when a missing FDT is tolerated.
- Keep the RAM reader's sector argument name and debug trace.
- Collect Reviewed-by tags from Mattijs Korpershoek and
  Guillaume La Roque.
- Link to v1: https://patch.msgid.link/20261014-ccaione-upstream-spl-fastboot-boot-v1-0-d29df15fb9b8@baylibre.com

---
Carlo Caione (7):
      spl: fit: reject failures loading an explicitly requested FDT
      fastboot: invalidate stale and incomplete downloads
      usb: gadget: fastboot: do not boot after a failed acknowledgment
      spl: ram: allow loading FIT images from a supplied buffer
      spl: support booting FIT images downloaded with fastboot
      spl: fastboot: support legacy U-Boot images
      spl: fastboot: support raw U-Boot images

 MAINTAINERS                     |   3 +
 common/spl/Makefile             |   1 +
 common/spl/spl_fastboot_boot.c  |  76 +++++++++++++
 common/spl/spl_fit.c            |  16 ++-
 common/spl/spl_ram.c            |  98 +++++++++++++----
 configs/sandbox_spl_defconfig   |   1 +
 doc/android/fastboot.rst        |  56 +++++++++-
 drivers/fastboot/Kconfig        |  16 +++
 drivers/fastboot/fb_command.c   |  43 +++++++-
 drivers/fastboot/fb_common.c    |   3 +-
 drivers/usb/gadget/f_fastboot.c |   9 +-
 include/fastboot-internal.h     |   3 +
 include/fastboot.h              |   8 ++
 include/spl.h                   |  25 +++++
 include/spl_load.h              |   2 +
 test/image/Kconfig              |   9 ++
 test/image/Makefile             |   2 +
 test/image/spl_fastboot.c       | 230 ++++++++++++++++++++++++++++++++++++++++
 test/image/spl_load.c           |  46 +++++++-
 test/image/spl_ram.c            |  48 +++++++++
 20 files changed, 668 insertions(+), 27 deletions(-)
---
base-commit: ab4dc5aacf957835c295b59ef2dd28281839cb20
change-id: 20261014-ccaione-upstream-spl-fastboot-boot-5d8e28a700ad

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

