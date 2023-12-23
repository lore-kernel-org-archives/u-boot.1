Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2F6C3DA6E
	for <u-boot@archiver.kernel.org>; Sat, 23 Dec 2023 06:53:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3F9A86777;
	Sat, 23 Dec 2023 07:53:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="zDZ8RjyI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3234786777; Sat, 23 Dec 2023 07:53:10 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FD8086C67
 for <u-boot@lists.denx.de>; Sat, 23 Dec 2023 07:53:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-336788cb261so2014421f8f.3
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 22:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1703314387; x=1703919187;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MVDkpFXm53xWnKf1rvBn5opKRojlaSlnJgXReRK/pQo=;
 b=zDZ8RjyIizundleC38z3XXWK155UuroPx7gyj1vHuqAeiOaA+r48kM2GRv48aVNT2J
 I8VVnQdrQhXsucyG7rV+JuAw0AqD7p7My9EBnHikbtwYsISp7FrJU5e1djybGJtQFPYH
 F8cS+9F3q7XyZlMTIM6otcaJFvHM/x6OLEiWoO76nffy7Up6tjcgjxXw5eUU0aSh+Q8B
 0LvvHBTIrPn408DiFOV6lSv3iGIlrWv2r31cEiwmCjA4646Wg0Dzy7endt6Os9G/1Bhw
 J0TnI8bn8cCN5PFnSjHBYVp5Dh0IGeEVRA9av3RthHIIcboaVVmzay1gjiFnpN/xEqGe
 biIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703314387; x=1703919187;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MVDkpFXm53xWnKf1rvBn5opKRojlaSlnJgXReRK/pQo=;
 b=JT8e6e8ktx0abMLzlKmyLf2cPHSYFmlZ9rx31gG3km+d+snMCMnOD5tUFW5YxHUHam
 9OWSGMkBGv2v/cLtUZ3Xl39Pcwc6l3jyhgY/Pd+NZx6r9eaPFyAByC9DjtI+tDP4oSfj
 VredS6GG1Dez/QGr5wO9GEQqRWSImuOOhzUaee9dcRN+iCMQC16wwYRQqEhjHp6dSgde
 M3etHUxjz3BHmUyvNjgmI6J3b6mgzRCjOghiYSZkCNMBK7rPt4+zrVkLL+QT43O0cpfB
 QAjUvUVj+9WF/EvBLRP9WFVGz9F7j8NLrQU1sKkjyvpN9SRlsnQ/hWOr4B5F3CNKCxRV
 qTJg==
X-Gm-Message-State: AOJu0Yy9EJdaHgXT4p6XxLduaNRYgcs85huLvgHzIaD89Xe3jsuiihRW
 JSqSLpqAsSzn2arzTRw8obXJqF6kVFl+1IhEVLXU9tgET/c=
X-Google-Smtp-Source: AGHT+IEWy+PTXtzmM2RjbLyOIEJYs6SRYsXidmTDzBUljgi9wjGozWqKspqMm+b5H4dWzbuauo/aPQ==
X-Received: by 2002:a5d:5005:0:b0:336:8242:3803 with SMTP id
 e5-20020a5d5005000000b0033682423803mr1221631wrt.11.1703314387165; 
 Fri, 22 Dec 2023 22:53:07 -0800 (PST)
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 k16-20020a5d6e90000000b0033667867a66sm5763186wrz.101.2023.12.22.22.53.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 22:53:06 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: u-boot@lists.denx.de
Cc: Shantur Rathore <i@shantur.com>, Eddie James <eajames@linux.ibm.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v1] Kconfig: boot: Imply BOOTSTD_DEFAULT when BOOTSTD_FULL=y
Date: Sat, 23 Dec 2023 06:51:59 +0000
Message-Id: <20231223065159.580100-1-i@shantur.com>
X-Mailer: git-send-email 2.40.1
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

We need BOOTSTD_DEFAULT when BOOTSTD_FULL is selected.

Signed-off-by: Shantur Rathore <i@shantur.com>
---

 boot/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/boot/Kconfig b/boot/Kconfig
index 9f5b8a0cb2..fc96aadb27 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -426,6 +426,7 @@ config VPL_BOOTSTD
 config BOOTSTD_FULL
 	bool "Enhanced features for standard boot"
 	default y if SANDBOX
+	imply BOOTSTD_DEFAULTS
 	help
 	  This enables various useful features for standard boot, which are not
 	  essential for operation:
-- 
2.40.1

