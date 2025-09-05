Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6FF0CA1017
	for <u-boot@archiver.kernel.org>; Fri,  5 Sep 2025 20:53:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3606283939;
	Fri,  5 Sep 2025 22:53:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ldCBToms";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EBD883936; Fri,  5 Sep 2025 22:53:55 +0200 (CEST)
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com
 [IPv6:2607:f8b0:4864:20::92b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D3FC838C5
 for <u-boot@lists.denx.de>; Fri,  5 Sep 2025 22:53:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-890190a3579so798048241.2
 for <u-boot@lists.denx.de>; Fri, 05 Sep 2025 13:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757105631; x=1757710431; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=J4tP0DAKoI5Hb/Qu6S8WXM10l8eWmKAUeLeHhRrGovE=;
 b=ldCBTomsFnjpmVmqIESDlh5v+2s7jXx7jMRoxkWbYlm/5MOfc1Tzho/YUebaGZG6XS
 C7Lhfo7nYPTQUi0JLRL5eUUcRytCDr1ugqMiVm6VRnrbrAMkgZt0djdesuLV6XfM5f01
 9OG8MDwDfmmnUBW6XB105fv0TMnkZ8ALq1EwRd+Jc7289g5HywB7/9PAd3qBlnQj8ca5
 qaY+XJlCz8Tn3Q5x/fXfxl3aJPpTmKNFK+f3mGlpGwNu7bZin94idR/rNkEfxWBBjKzr
 XrP8M/Ur9qOGzrsH5hO9lzzEfa9nzpBxRKLHx6Lj4l8QKc25S6NEx027/oFEASAnSykT
 uTtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757105631; x=1757710431;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J4tP0DAKoI5Hb/Qu6S8WXM10l8eWmKAUeLeHhRrGovE=;
 b=OlN9nOjDiezNzDV60r4gVwM/eFbnRjApBej3QxBwapFEqLDkkZ874KJpCe8hPhYY3o
 8S93G3BuqAfvfWkJdRHORTYmIl5m0nLbQOmvvqSSPwgNrB92ecQ9KjBQuLXLxUVDUrIG
 9naZm4pi+20teRRw6OWB0IMD3mjCn0E5SyGiTm+XDPFWibHtNKv9ZUXDzo6D6nr064dy
 KYAOs7N3unuFv6tR985TQ99NG4RSh4HEb2RCJDI/eN1tANYwqHB4RNsW6gFVE6AAZYFh
 AfHCIRK0bwWLEYjPLkgTJmAvq0xd2VFZI926eoWpVgIIFXMmk+z9gbzezwbHb8PgrA4U
 nO/w==
X-Gm-Message-State: AOJu0Yx8g9s5gt+C/F2iZ6aw316aIq6YYTQToM3hAE5Lwi+4FgnddFuN
 NYy0w/LcMF9W84rqDAsPL4jU6RfUAfspMIcT4O3rM+dmPa7bDswjdVvOxH5BgRIXYkbQ4H8LXyU
 t/6og
X-Gm-Gg: ASbGncuYEeVTF0iOhVOvj93t0MKKtajR0SGI4NrIidX95DNsfl4x1wMIwxbYcSN/poO
 pgaP2vhhdFavzbJADbtywFdc+FtATjC7t64Hjjw6ja2rP+xY/K9PkdBw5s6pRubHG+l0EqwQQU1
 lH/gVldkytaoACBKIHO9rgX7qihncub4bJq5AnfejeDBAV2Gz6jjuYrwXKaP0jD4ACoLpFxNkhr
 rqFUJYgrI53I5Vgmhp34tqzpMPLIglAxoszcTZyCUAjZ7V0s+a0/6mwfOpuM+eLtoyKUHwZH5PW
 AtLiFll2YVyI32XTdoLVr39evEhpwW3eu5WyXilGB2BtaaOWl0agyFh5fKvHF+VlHDnHIcH/WVt
 7lnoHDWA2Zt3tVYVaEk9AAGsHaApgQfMt4hGfnHsAPiRA5qnu
X-Google-Smtp-Source: AGHT+IEn2h4VvD4X+ImWm30e2v96qMk+gHuZNLnfyrHQvZCl9iyu2xf6OvAOfDK7yvkcUjyYzIuoaQ==
X-Received: by 2002:a05:6102:8025:b0:4fc:1a18:aaa2 with SMTP id
 ada2fe7eead31-53d0d61d136mr106205137.5.1757105630766; 
 Fri, 05 Sep 2025 13:53:50 -0700 (PDT)
Received: from jetm-rog-crosshair-hero-x870e ([177.93.10.181])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-52aef459c9asm8395330137.1.2025.09.05.13.53.50
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 13:53:50 -0700 (PDT)
From: Javier Tia <javier.tia@linaro.org>
To: u-boot@lists.denx.de
Subject: [PATCH v3 0/4] Modernize U-Boot code formatting with clang-format
Date: Fri,  5 Sep 2025 14:53:43 -0600
Message-ID: <20250905205349.127333-1-javier.tia@linaro.org>
X-Mailer: git-send-email 2.51.0
Content-Type: text/plain; charset="utf-8"
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

This patch series modernizes U-Boot's code formatting infrastructure by
with current Linux kernel practices and providing a more robust and
comprehensive formatting solution.

Changes in v3:

- Extend clang-format documentation with additional information. How to disable
  formatting. Explain controversial aspects of introducing a new coding style.
  Clarify the origin of the '.clang-format'. Add code formatting best
  practices.

- Add Michal testing tag.

v2: https://lore.kernel.org/u-boot/20250903220942.473282-1-javier.tia@linaro.org/

- Replace Lindent with clang-format before remove it

v1: https://lore.kernel.org/u-boot/20250829233951.547352-1-javier.tia@linaro.org/

- Removal of the obsolete scripts/Lindent wrapper
- Documentation updates for the coding style guide
- Migration of existing tools to use clang-format
- Copy .clang-format from Linux kernel v6.16 tag

v0: https://lore.kernel.org/u-boot/20250829190058.GY124814@bill-the-cat/

Javier Tia (4):
  clang-format: Add configuration file
  tools: zynqmp_psu_init_minimize.sh: Switch to clang-format
  Lindent: Remove wrapper around indent tool
  doc: Update U-Boot coding style guide with clang-format usage

 .clang-format                     | 804 ++++++++++++++++++++++++++++++
 .gitignore                        |   1 +
 doc/develop/codingstyle.rst       |  81 ++-
 scripts/Lindent                   |  18 -
 tools/zynqmp_psu_init_minimize.sh |   2 +-
 5 files changed, 885 insertions(+), 21 deletions(-)
 create mode 100644 .clang-format
 delete mode 100755 scripts/Lindent

-- 
2.51.0

