Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32684C83F17
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 14:47:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40A9C82F14;
	Tue, 15 Jul 2025 16:47:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jVui0Aj3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95CE982BF6; Tue, 15 Jul 2025 15:03:46 +0200 (CEST)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72AC482F8E
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 15:03:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-74ad4533ac5so5149282b3a.0
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 06:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752584623; x=1753189423; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mhsE9gyt2m+8b2LbET+maVPmcRuBYctvwpciJPbtwz8=;
 b=jVui0Aj3oPmRQNt60em77VmKIH3U5l+9auZj/6uLLc3vUGyiGn9meHpsu2xNMA32Z3
 Am9i0yv0QPeKRebiTY6c/LUnItI+waFrc566L0Ad6f+EKTZ6E/LkqCpXC8YYKCh4+mQY
 f7I9dvEyWxnx9eDnWPcRck3J+tduIZEazDoyk6RKMDDSxJaa+r4VOjeozH+3Iqilx8uO
 Bk0g+dQ5rkpEsuLusR4jnvAHEonSVQk2IH3WP5AWD4eFSuiuQGRDC4TFqtnSw6LKEB1t
 B4plbUk7SGMEtgKcTa/G4G0uYCp0CDSOc8Qtdv3fs2iaLIO70/htDnzTCs8McpsFgOs0
 bPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752584623; x=1753189423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mhsE9gyt2m+8b2LbET+maVPmcRuBYctvwpciJPbtwz8=;
 b=lJZl5+sHQdWjmWIlC9W6Vr4WZXs4Tkp6gwSOnmuiPXMxAIuauL6lAGAyaesuEZdwnz
 Bzn7XqgS6vMR1FtTGJGeUyiRu7MX8GPlOZJrQEqO1OBgl6nueAM7Rcj1LDgrZG7gVrId
 g2PCBSFsQ2pqRbQ1dSmS8NCXzjMMbWFwkpqbgl9fawbQkr/yqEg8kes9giZcLkZskbON
 cwZsTURhENagJeDosUhZNXuXcFbrXGm3nO/ru6SKrPpHpoA6OZDChNWF/5OwehpLwwo2
 dfR0qW1FOpA5pftvN3cslq6NTRcMVgyrQrfIEm5xv8IWLdc/FRLiVZPD7n7pR1H/T/KK
 V75g==
X-Gm-Message-State: AOJu0YwC/fVUzuJznaAimX9KR9qd908Va8/yYvc0U+qWOLNzsuIAxI+0
 /ID40nfHkEV6HcZdTtzGRAmLWJT5QYdhhAci0oCDov73OHPRudBuDLsBW6OZjg==
X-Gm-Gg: ASbGncvKd3WvDMfRwqpXPbg9X5PuhHZQA7dgWHtz27b1KbkB56lsK7PGCjv2+uiQoBR
 AGkFt6PY8f+JRWoLk3SnJZYy1E6rO92i8H9of/oQg6YbpR5PAZseM5KHv5QV3WYSMfBouj+SzO3
 np8x9oiGpzae6oBCuVLZ7DyGKchvVhRWEqio4Z2j9aJ57XpY3Y9N38114f7l+fH/8Fv/oeZZJKl
 i+IWXBhelUMRSg8G+RW0KMaqdIvc6qXfnCeMPIyhXWK7C+5UZOSn34uE3D4cAcr+Zwtzg0JxZgJ
 9pygwK2v2y/1hgvr/ENRPEW0hMr6Q3wSCEbH2D4ovJoFgo8+c4GToNoEhMHcMB0frzbG3VjaKPP
 sQsEXn0gLAmouuDcD1uu2ISsvHJ/FfWDjb4PUpp2K3E5qsVU9Pn/qT56e92TrFwIGBPVeM1YoEs
 aD9LuNjg==
X-Google-Smtp-Source: AGHT+IGlgRJ/eQlAMIvzuRdV2BSPaWlGBHVV5EVdvPVbfwJnKHxHlzhIPwzYbBLngGAJepP02kB9iQ==
X-Received: by 2002:a05:6a21:58b:b0:222:ca3f:199 with SMTP id
 adf61e73a8af0-2367110ba02mr5924807637.18.1752584622389; 
 Tue, 15 Jul 2025 06:03:42 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9dd5fc9sm12392356b3a.2.2025.07.15.06.03.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 06:03:41 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, jan.kiszka@siemens.com, baocheng.su@siemens.com,
 sjg@chromium.org, ravi@prevas.dk, quentin.schulz@cherry.de,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v2 0/3] mkimage: validate default configuration reference
Date: Tue, 15 Jul 2025 13:03:04 +0000
Message-ID: <20250715130317.3886-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: 20250715025307.2013-1-aristo.chen@canonical.com
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 15 Jul 2025 16:47:06 +0200
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

This patch series introduces a validation step in `mkimage` to ensure that
the `default` property under the `/configurations` node in a FIT image
references a valid subnode. If the referenced node does not exist, mkimage
now prints an error and fails early. This helps prevent runtime failures
when U-Boot attempts to boot using an undefined configuration.

The first patch implements the validation logic in `fit_image.c`. The second
patch fixes an invalid default configuration reference exposed by this new
check in the `k3-am65-iot2050-boot-image.dtsi`. The final patch adds a test
case to verify that mkimage correctly fails when an invalid default
configuration is present in the ITS file.

This series improves the robustness of FIT image generation and helps
catch malformed image trees during build time.

### Changes in v2
- Modify the order of the commits, code is not changed

Aristo Chen (3):
  arm: k3-am65-iot2050: Fix invalid default configuration reference
  tools: fit_image: validate existence of default configuration node
  test: fit: add test case for invalid default configuration reference

 arch/arm/dts/k3-am65-iot2050-boot-image.dtsi |  4 +-
 test/py/tests/test_fit_mkimage_validate.py   | 45 ++++++++++++++++++++
 tools/fit_image.c                            | 10 +++++
 3 files changed, 57 insertions(+), 2 deletions(-)

-- 
2.43.0

