Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC8FC6FD1F
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 18:20:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE97A88063;
	Tue, 19 Mar 2024 19:20:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="eTXgGZ1X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F56388033; Tue, 19 Mar 2024 19:20:01 +0100 (CET)
Received: from mail-lf1-x14a.google.com (mail-lf1-x14a.google.com
 [IPv6:2a00:1450:4864:20::14a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A53A787FEE
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 19:19:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=3Tdf5ZQYKBho10HD0I6EE6B4.2ECK-1EEJB8IJI.34DN.34@flex--barnas.bounces.google.com
Received: by mail-lf1-x14a.google.com with SMTP id
 2adb3069b0e04-513d3f026d4so4484010e87.3
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 11:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1710872398; x=1711477198; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=7k8CN9F1DKhqtTiEqCz/IrvWIRp1NiKdu7OQH0bGUFY=;
 b=eTXgGZ1X1BgBMvQKk95Yh/ISGpx+XtNEIZb+eN4sOsvhAlUfgvntZgl3H8TSujeEtf
 G6qLu5xqzcypRT1hSQQ7XCm9EdCaO8BNt/QYhwYBly+V2BAefsUE+Trhp1U0546QmD8O
 WZ50A0ENFEpPF/x5PsZzUDFum4MEL0CRy9hp9RtrepgVurbQdVG+7r2s7qk6cGaJQBsz
 qqn6GUwpWSl8YBWIyv/RUbEI9XkAy2dDuIZDwFmNy4naPnPrzFOjK3Y3waHW71SjGOiY
 Z8KD9+syPmYz/yYNHUr58ipYFd/Qa7znzjWSwRDNlYYDkhJXjrHE+D8YlJnMvmSfUtyd
 HUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710872398; x=1711477198;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=7k8CN9F1DKhqtTiEqCz/IrvWIRp1NiKdu7OQH0bGUFY=;
 b=IfyhEtMjiRnf/jDGyGqaE6EhNsrHM8BVniLOV1FyKEiyTfkVbenWAP8nCSTORRK+FT
 SpwxmSHotvZxrHXkESBNCP/forCbW/MqqWEii0IgzxBLjFhoBKvEsI/ZPQoc2OfJJbi1
 6sEZxgkFsLy1G32sdgdCPYOk5OpwSDa3rwpfuZPji73pZRbMsX7NfTUBBsYWntQGRX5F
 eGInOSjMqjIlbn0j0boCiGJ55xEKPRevHsH91yyDaHERQcoM5jF4yODvAJ36sPR7XaJq
 JORJlmkAVX2UGIdUZEG+/BpRAUfduxalAC7lYdm1Srf1JJnjbfzawJ/LcilFW/rR4oLW
 UyEw==
X-Gm-Message-State: AOJu0YxBgtFFfd4QkbZnBj3yB1ai4aMQF5ISu9pNRc9p5B+eBZGYyygf
 2Dnwna6RL5x4eVMFESLb9++wDngoAQk+/O2Bsbego10PHXTTRyB1vNHpOqbR2OjbGxTVTcWd0Hu
 ixFabq76gq8XIWqkIodgXhw/oPAWOcE+FiDmllxw0yDBGLobdaVVc6BMkX2hV7VYG0lbweIraDc
 L8v7w6TbDQXFyhUhI0jPO0QoTYjHvsJw==
X-Google-Smtp-Source: AGHT+IHwWVbU6sRuqjjXk3RqwKo91s6gRFPsL4X5XFN2f2waKFlU9LejRNFv8qc+kONOZhv0+lNWhSg59VY=
X-Received: from zombine.c.googlers.com
 ([fda3:e722:ac3:cc00:68:949d:c0a8:7f3e])
 (user=barnas job=sendgmr) by 2002:ac2:4f07:0:b0:515:8625:1eaa with SMTP id
 k7-20020ac24f07000000b0051586251eaamr1595lfr.2.1710872397403; Tue, 19 Mar
 2024 11:19:57 -0700 (PDT)
Date: Tue, 19 Mar 2024 18:18:12 +0000
In-Reply-To: <c0cbfa06-9206-4ca6-ad51-ad7b0e54cf1c@denx.de>
Mime-Version: 1.0
References: <c0cbfa06-9206-4ca6-ad51-ad7b0e54cf1c@denx.de>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240319181949.3083508-1-barnas@google.com>
Subject: [PATCH v3 0/2] arm: socfpga: arria10: allow to reprogram FPGA with
 warm reboot
From: "=?UTF-8?q?Micha=C5=82=20Barna=C5=9B?=" <barnas@google.com>
To: u-boot@lists.denx.de
Cc: "=?UTF-8?q?Micha=C5=82=20Barna=C5=9B?=" <barnas@google.com>,
 Dinh Nguyen <dinguyen@kernel.org>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Marek Vasut <marex@denx.de>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 "=?UTF-8?q?Pawe=C5=82=20Anikiel?=" <pan@semihalf.com>,
 Simon Glass <sjg@chromium.org>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@intel.com>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 19 Mar 2024 19:20:50 +0100
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


By default, the board requires power cycle (cold boot) to program the
FPGA with bitstream. This change adds Kconfig that allows to enable
reprogramming the FPGA with every boot. This makes the update process
of the bitstream on the filesystem to be applied with simple system
reboot.

Changes in v3:
- Rebase on current master branch
- Drop the TARGET_ prefix in Kconfig
- Remove #ifdefs and use IS_ENABLED
- Update defconfig to use renamed Kconfig

Changes in v2:
- Rebase on current master branch

Micha=C5=82 Barna=C5=9B (2):
  arm: socfpga: arria10: add option to reprogram the FPGA every reboot
  chameleonv3: set in defconfig for FPGA to reprogram every reboot

 arch/arm/mach-socfpga/Kconfig         | 8 ++++++++
 arch/arm/mach-socfpga/spl_a10.c       | 8 ++++++--
 configs/socfpga_chameleonv3_defconfig | 1 +
 3 files changed, 15 insertions(+), 2 deletions(-)

--=20
2.44.0.291.gc1ea87d7ee-goog

