Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3127EC3ABB2
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 09:42:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F2B488EBB;
	Mon, 16 Sep 2024 11:41:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tN79jxrs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEA7F88EB6; Mon, 16 Sep 2024 11:41:56 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABDB888EB8
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 11:41:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-374c180d123so1697183f8f.3
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 02:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726479713; x=1727084513; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SOcbqruUmWrhLZkKK60QRhwvF+7jnUdOWYFnWYS9Cqk=;
 b=tN79jxrsWuGA4j5jSm8era9Kbi9Ie31F9G9Gds2x+qTsr4Ex4rZ4SjybivaRlXVX+5
 jEp2TZ+5d4by9EdWv0E6VBtbG/sqeetNxzenqDYyliCFy3vE3ZSGb6oho+iWXW9djKDn
 bNWLFYYsMoouai1Uqp33rv0Fqnzbvmeytks22p/V4zOrm5X4HhwrI7FJy4P99XkgB7AR
 Wf7C0/M/S6h0hBdBKxSYZ981WvXE9qOoDDtLK9r64PC3wlwZW44AG4g6kx0vH0ztekRz
 q3FuQkUslLffIiHV5d4b01nmRGvoQBzsrw0mW4evbT0QlI+LfG+yuOFIhbUZ/kwO81a/
 MMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726479713; x=1727084513;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SOcbqruUmWrhLZkKK60QRhwvF+7jnUdOWYFnWYS9Cqk=;
 b=W0HcN5CgMmawwTL+re+wsTfyrr3huGZyTZaAuSxuGpjqhmF2Uoa3fLQIXesdiiMKKA
 ylXjJIIP4kqoWwySvn7oJUA3Xb7Nc6I6RxBnZm+Knz5L55DsjtHRRv4iixktwu65ZXIT
 l6ueuFud9hCBRWcJzjPOIZlajNRM9ZJCc1TFnti4kRpmUI2zUZrpmPr9GuzNvGtKrxnJ
 4IktE6OvREdklAB1nTX+DqlJFhKWR/HqbMU686Ln8tVpPhanKgXPaOcTiQ7pMWL6wrBc
 rwXvJtDZM8mbKONioc3JF2ykuPcu1e3HjimGAeN+rgZiXr4BlAgJMdEC5C5LIBhW/o40
 7O3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEvF//GxNRqXLO7Z9UUGdkfj+NPh9XCd0T2DM0PBmmX01LTBlzNoWdDGSdXD++7BVXzhuZ6FM=@lists.denx.de
X-Gm-Message-State: AOJu0YyVsdCZVvWT3K7GtQCFywIFhP3vbHfFH2HIGP/3nMtxV8WWCdd2
 oAVAR/6bCUxJgPycNme9tPvNtXoz/kHyiioAcsGyq5gf0tMsvBCJQ+2B6onMblA=
X-Google-Smtp-Source: AGHT+IEkZCtMyHm30PNKdgkVipJTmP4B8zHKvi8kWamYZKZgZ6BsSHp1V7TJ3pLf+bTR2U3LRpK7tQ==
X-Received: by 2002:adf:f68a:0:b0:374:cbdd:4813 with SMTP id
 ffacd0b85a97d-378d61f12e3mr5352421f8f.31.1726479712789; 
 Mon, 16 Sep 2024 02:41:52 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9b05d4e1sm106398555e9.12.2024.09.16.02.41.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 02:41:52 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/2] ARM: meson: libretech-ac: add suppor for EFI Capsules
 Update
Date: Mon, 16 Sep 2024 11:41:47 +0200
Message-Id: <20240916-u-boot-topic-dynamic-uuid-v1-0-7e4f48542a0f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFv952YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDS0Mz3VLdpPz8Et2S/ILMZN2UyrzEXCBdWpqZoptoYW6YbGRqZGyWaKI
 E1F9QlJqWWQE2Ozq2thYAdG2S2GsAAAA=
To: Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Da Xue <da@libre.computer>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1053;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=vaGeJyXX/kpSSEtaYVEkfIDt/XINxBru0wwGOH/N5fc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm5/1eFGVqKIdgQSVJqvwbSQUy4MKe4lnRQCcN73ww
 QBhOmUKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZuf9XgAKCRB33NvayMhJ0RUxEA
 C2GkdY6Y7eBVYRMDG8ufdYIutpvrgVIUddVEGuStWXXuMMVD/xztPRmmtBt82/TOCO9z1jmTvMky94
 685T1Z5tDQ9WSbqYAUSAv5LxGHx1+u+tH/JKyz3K2qHRANR9F4NVUEK+UkKU7YyJL6Su3Hh3XJlJfj
 YmOj3pOnkX9ogw0p7lFXMfLEC1zZmopdxQUvSKI4lvlwNfhUQdaBfH3Sc46p1ZWLS0fRgYKVxeUVyf
 RbWb3Cs506o1EsG0LO5LtiDJ9dCFCiCB5JmDI9s97Mx6hCoIY3g0Y+A9tMYDzhBq3quHmm7Lkc2O8N
 oYFtt60VgHAAyS8CDEQwe87E6l1OA1Xra/MP31G1e2flaWEgyJJhhyw8960twUUKyJ+BFFTLNnQK/1
 9/B0ts/1wiOIRzPCSmu9MzeGx4zifAlCAVI4owNIoEuUIlp+nDD6cZ7XtZOB7yVFzfwWrS9VOt86Q0
 I4qM1VwK5t2F3qBb6036gXKI9RqoLIReOy4uRv1SSka3dk6LNeYspJIuz4agYD8D2tFcP4hgPwunHq
 pz4bJ0o0uswdaxvMOg0VUissHYN8qF2VxbTrrRv4RuXDS6ZblScNmoAxGN/s366+fj5nJ6C85sKjO3
 6dKgC31p/AgutUMiFj4xCSHVPBQwbAT9bBJ2kEhtZOrpH3mgrfakNPVbr3JA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

The necessary changes were made in U-Boot to easily support
EFI Capsules Update and be compliant with Arm SystemReady SR.

Let's add support for the libretech-ac/AML-S805X-CC since
it's an easy well-supported target having a dedicated SPI
Flash to store U-Boot.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (2):
      board: libretech-ac: move board support into dedicated directory
      board: libre-computer: aml-s805-cc: Enable capsule updates

 board/amlogic/p212/MAINTAINERS                   |  2 -
 board/libre-computer/aml-s805x-ac/MAINTAINERS    |  8 ++++
 board/libre-computer/aml-s805x-ac/Makefile       |  6 +++
 board/libre-computer/aml-s805x-ac/aml-s805x-ac.c | 61 ++++++++++++++++++++++++
 configs/libretech-ac_defconfig                   |  7 +++
 5 files changed, 82 insertions(+), 2 deletions(-)
---
base-commit: df84c019c46e6833cc79385bdb23efba4882c09d
change-id: 20240916-u-boot-topic-dynamic-uuid-a871c25236a4

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

