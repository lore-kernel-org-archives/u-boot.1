Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8348C369A1
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 07:58:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33CC083564;
	Wed,  9 Apr 2025 09:58:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QDkYPjRV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FFF8835AA; Wed,  9 Apr 2025 09:58:31 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1000683560
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 09:58:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cfe574976so44018805e9.1
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 00:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744185508; x=1744790308; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+2ThxQIZp5JXHMbpuLEV2JaCr6Bcy8cTWQpxAe7b86Y=;
 b=QDkYPjRVKl2Gye/0QX/i495ldvmrSk9XFZ+lhwd9m0DAeNDVryAQHo2PKkrPOU2yiK
 jMpAjLahebZnMB2M/HRP8kbgtR7OIg4vLp1kFfPuygWOZjbDXkNJ6yIDAmr53C1vH0PI
 6Vkc7QELashxB8P+uvJyt6BYxkmQ+dLsdeGeEEzuxGSSNWqHpOzhddm9mMLKKBgtEx7f
 UcbQ7/HtvWu62nP9ze/cYrZ20NckLLdDyc3zMUkx4cuJjldJbZi2XySNMZLV6K+M4kuN
 hovpSwN+xWp2X/4WR7oldHj0vGn/Rnpdn6aFc5NprbT43MYA3zTIwGWyQX4Qi6f6eJiu
 J//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744185508; x=1744790308;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+2ThxQIZp5JXHMbpuLEV2JaCr6Bcy8cTWQpxAe7b86Y=;
 b=wN0eL0P0E9AQ4x7jPNfC4pcf0Uc3HEUVhiDRFVJ16rbMj7keGU+N6+jGzDFkFHn2Qf
 KbcJcoqNK2/kwx2zyVdoFwHvcXvefDH4qoFf6QYeiyJ9U62L4JMz91w+cFcUXTK6wSDF
 1QiRPNBnpQ+wXKXDF0/PEwcOXAaweWLk8DrTHT1lAUCO4V6eRjwOvq2A62RGtcCqaHcw
 SGs6ZpBRZQ1UO/zP7S29YiDsD3rU2Y55kHstfAjbKRSlORxk2oSfr3WI2Vp7LUFCQsEj
 TMD70GrQdwdGrCB6mICCpkbXFUlHUtMmXwZie+e5x2CnnKyEeOvULqil4/XbAmn+5vyp
 1EOA==
X-Gm-Message-State: AOJu0Yw3kMf2rAC6CwRIlVYtVJDKuklxpV/b9OmO1PJvihqM6cWA+eBz
 unNxn5vpkMQtGyxxb5x+ZOLE34XFdaKpgEKkA3bbrMPTRpeYhiyqqJE7+C4IUIk=
X-Gm-Gg: ASbGncs839FGnIc9DQ4EMIVlwNLUtvwzLSIHsulH7MpG0HF5ZyJ/Rq3vA1j6r+hHJSq
 A6pKdMeB74/vvHPloiCiC9ag2WIVa6kl8EZK9Xk+FGivv+olKAgFkPI6SLoPuff5eeG+uXuzdrd
 +AKcYe1doCqujEwXGeJVPNuslGVaAuOyPJZgxgmoRAb/XC+LeiPoS60Nu4Cz199Krxt3WyqOxxB
 bId5WfK06PVFQXrCV+K03gcrfxYqz/U1N8XULjDNGApVkRnmHblc4oqyAK+KzYpG3HPYtmQcu+a
 IxxWHoMg7XrWzmBM37MaNkzK8GH9S+mElUCSYt/ZANX+4kXV8wHOVnmftE9ihQ==
X-Google-Smtp-Source: AGHT+IGwCGBLt2mFe0qz8RiHXsQpB63Phr6Gc7QdwMjugLODIXtiiFO3wjr9EkeY/x2IkakV+rLUoA==
X-Received: by 2002:a05:6000:40cf:b0:39c:1257:febb with SMTP id
 ffacd0b85a97d-39d87ce5bc8mr1731270f8f.59.1744185508421; 
 Wed, 09 Apr 2025 00:58:28 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39d893f0b82sm842878f8f.66.2025.04.09.00.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 00:58:28 -0700 (PDT)
From: neil.armstrong@linaro.org
Subject: [PATCH RFT v2 0/3] fastboot: add support for generic block
 flashing
Date: Wed, 09 Apr 2025 09:58:24 +0200
Message-Id: <20250409-topic-fastboot-blk-v2-0-c676f21d414f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKAo9mcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDI1MDEwML3ZL8gsxk3bTE4pKk/PwS3aScbN1k01RDk+QUU0sjIxMloMaCotS
 0zAqwodFKQW4hSrG1tQBmR47DaQAAAA==
X-Change-ID: 20250408-topic-fastboot-blk-c5e14cd59224
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitrii Merkurev <dimorinny@google.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1660;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=z42TkWnwFWpIiTCh3nw0ZCjomqO7NaB9aAgkow6YIWI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBn9iii7imgH0LFdJt97NzhYC7rzW5zfCNhUxR7c9K8
 LY3UBRGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ/YoogAKCRB33NvayMhJ0cf5D/
 4rN5pV3P35ZCku8LtZgiMRxAEIQjSP9zgGbEt6U0Pv8GZpcaqisbpW0g+cY6q6RVNb4WgaP95r1YBC
 2INve/pDNhqT1MoUFFtFQST+ulr2C9CzF2TAjmdwzv6rQyTe/rLxB5juC9dPyv3DND5lRmVk0x3zii
 pLbjv7Genkg9DOaUZPQptGkTdAlFnBDaO+96thoRoWJgRkz0ywg4aiiJOsQL8a6z/F/cuw5Xk5Sryg
 /zc/4Uy7ovwdKS5YmGolxe8wnFG5KpQfMf6iOXTpYQzuNkmvTaPcYvZm3rjuoBfXsZALBUHawgJNkO
 6bsGvBeZUBx4kLlt9pJ5rNqZClX1V9rJN1gj2mFpejWjfSqcRZUN8VjRElaouKKkAe2zSMIEty75je
 1vbBhM96vRIq+mxpvO/NTFpThk2gCI5qjIeyrr5P7hocSzY7z6xIWrDdlokqqSEsGaIKYVuYFjIAdi
 oa7NjZWt0KL6Ly7Jpk+50mo0tvBCzuPdxaGCzvyKXxXciYfd3Nqq4sbb76QN3/+shTSUrPkSxJ7jlE
 IU9Ufr4k/t0TafnbodzBANmll7kRjjOGjQsWAcqAiO+udi7Tbgn0rUwbCdog1yuQee7O8Ni50XTGQt
 zTgMOJSNJmSD6nYaoCxdJhuls69o8XVhO9ez8dTCim7XhRY5LWO3wTmWBJqA==
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

This serie permits using any block device as target
for fastboot by moving the generic block logic into
a common set of helpers and also use them as generic
backend.

The erase logic has been extended to support software
erase since only 2 block drivers exposes the erase
operation.

Tests are welcome to make sure this series doesn't
introduce any regressions on the emmc backend.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Dropped applied virtio erase patch
- Reorganize patches, introducing helpers first, using them in mmc afterwards
- Added soft-erase logic
- Added move helpers to handle the partitions erase & flash from emmc
- Fixed const var on last patch
- Link to v1: https://lore.kernel.org/all/20240306185921.1854109-1-dimorinny@google.com/

---
Dmitrii Merkurev (3):
      fastboot: blk: introduce fastboot block flashing support
      fastboot: blk: switch emmc to use the block helpers
      fastboot: integrate block flashing back-end

 drivers/fastboot/Kconfig      |  20 ++-
 drivers/fastboot/Makefile     |   4 +-
 drivers/fastboot/fb_block.c   | 313 ++++++++++++++++++++++++++++++++++++++++++
 drivers/fastboot/fb_command.c |   8 ++
 drivers/fastboot/fb_common.c  |  16 ++-
 drivers/fastboot/fb_getvar.c  |   8 +-
 drivers/fastboot/fb_mmc.c     | 210 ++--------------------------
 include/fb_block.h            | 104 ++++++++++++++
 8 files changed, 477 insertions(+), 206 deletions(-)
---
base-commit: f892a7f397a66d8d09f418d1e0e06dfb48bac27d
change-id: 20250408-topic-fastboot-blk-c5e14cd59224

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

