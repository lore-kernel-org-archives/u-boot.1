Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C018C021BE
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 09:49:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5A1F80FF2;
	Thu, 27 Feb 2025 10:49:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aWpjweRe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BB7E8083E; Thu, 27 Feb 2025 10:49:26 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7299E807FB
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 10:49:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rui.silva@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43b5859d1f1so3644045e9.3
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 01:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740649764; x=1741254564; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ly9fgOWN/zKgTqYaxd/BKSe3FimxHCcDsSm4Toed/lY=;
 b=aWpjweRedS431sICF/ENsxdeuA2+U1MdYDHYnNYHBTICa+nkPYVOqt3tXQMzOhF30Z
 ejb583zpn/I0Vzsn5Ybgj9OZM8rZozwh9NguUawCcvaSeHLHt78RpNxI+u4rtMHcA+cK
 07ahvGKn911WO9h+ff912WzriJDOhMrzV0qhG+jlbJKSfJA36sdBwsxKZkJUtYvf57DG
 CMjLyNOeAtYk/QNoNV+Hma1JqLdreRw6L4HptdII9mk7JxgiQLnHGPZG/GfImgtdxiQk
 wYGa+VIgQ9hHpF6ZnikOZGn2UJTxeVqIjVlgyHoYP8p960yG1u4M78iDB2Ei4gmG9Kbr
 8UEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740649764; x=1741254564;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ly9fgOWN/zKgTqYaxd/BKSe3FimxHCcDsSm4Toed/lY=;
 b=mRQVT9OB4ETXzZ/D36Tw/OwiEqUqE4gkG4MJU9r+8XiXqOp0mo1PVdz3h8URusCZ0t
 iuSM8RK2adrIORh/Qn+XNHHzDyhiPXDVqqig35SVChYNSkeYAm4CmX0uJ4AP5oj5HEW+
 XsgsZuSesqvunTDXWPwrnKT1r60yPd62B2UjlqZb9XSDlVDFFDTF+dW5vo0Lj7ltlo87
 eIDixglZlsM+G83PepeRubaDeCnKoHjnU8p22dO5DlyP7gsKusQGXgXVxd6i2BpfnWQw
 lternaKIxBn+92ArS1DRKTgB5U+NAQO2v4nFv54Lzme0MPGTul0Pu8O7NPM0ZP6Lun1I
 jDNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhejURVd5m9YCRzH5ZlzsqhGoIOOATtZz0DKHvDUyINXabOYI8ADZ7Q/Kd8Lr38nelVqL9Ss4=@lists.denx.de
X-Gm-Message-State: AOJu0YyyoQ8gI2YPziCXxdkUMqpWmHk6esk8WKP0fhNt/H2cMQ9MTxVA
 aX6AHiifg1mIIqNDwHzz76VHPD1lr1Rfl71BTur9H/bNomFirLEPF9IC2ycwWcM=
X-Gm-Gg: ASbGnctRPls/0CGbFBsb5ZbjNlFA3OeMFaFlQslkCWwYV3v1zG9AdHbl2zJCyoZF9pz
 +X2fb/XUkzbgO/wU2zTGDznHWrimo06Csni3glYuaFyI9nweOu2OfRi9JY5JkRLjDTDM+0uMY88
 P0Fw8w8lzaFnPBL6ezTqTbDZhXuRhOWlamMrnoij1hSFDauF9erTtNxRCeW+yDJ4RRucYsYN06z
 sTwmpSLQCZXVNog2CSdzcjznjOlfnQCo7pyJTiq7l37dniyhi3rua7Y95fW97+MHvoStYB+iIWb
 urqQ4uRvz/KqYNklj6z7DSx4UVSWH9a3TR8EIRXNNIhID1Lk+VBSGOgFo/2nVNQ=
X-Google-Smtp-Source: AGHT+IHZkzb4HLKy1Qp2Ez0rGj7Xu5BitHx/bdrqiN6UdNgtAzVlsF5PHIYnlFdD6Hnb3H0c/8r4kA==
X-Received: by 2002:a5d:5886:0:b0:390:d6b2:c74d with SMTP id
 ffacd0b85a97d-390d6b2c8e2mr4550621f8f.35.1740649763884; 
 Thu, 27 Feb 2025 01:49:23 -0800 (PST)
Received: from arch-thunder.local (a109-49-32-45.cpe.netcabo.pt.
 [109.49.32.45]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47a6a4asm1506162f8f.34.2025.02.27.01.49.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 01:49:23 -0800 (PST)
From: Rui Miguel Silva <rui.silva@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Rui Miguel Silva <rui.silva@linaro.org>
Subject: [PATCH 0/2] power: regulator: add qcom usb vbus
Date: Thu, 27 Feb 2025 09:45:48 +0000
Message-ID: <20250227094911.497219-1-rui.silva@linaro.org>
X-Mailer: git-send-email 2.48.1
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

Add PMIC USB vbus regulator driver (bindings already present);
and fix related with property overwriting found out during
testing of host setup.

Cheers;
    Rui

Rui Miguel Silva (2):
  mach-snapdragon: of_fixup: fix property length at writing
  power: regulator: add qcom-usb-vbus

 arch/arm/mach-snapdragon/of_fixup.c           |   4 +-
 drivers/power/regulator/Kconfig               |   7 ++
 drivers/power/regulator/Makefile              |   1 +
 .../power/regulator/qcom_usb_vbus_regulator.c | 111 ++++++++++++++++++
 4 files changed, 121 insertions(+), 2 deletions(-)
 create mode 100644 drivers/power/regulator/qcom_usb_vbus_regulator.c

-- 
2.48.1

