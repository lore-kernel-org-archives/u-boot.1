Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64976C71136
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 12:33:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C390082BA1;
	Tue, 17 Jun 2025 14:33:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PZUo9gAR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DEF382BCD; Tue, 17 Jun 2025 14:33:31 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C28082977
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 14:33:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-23633a6ac50so80428765ad.2
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 05:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750163607; x=1750768407; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gIIyZHr+9RsDFmxHGEN0RPKXRXHMoYd/0G/iy5Z8Z1k=;
 b=PZUo9gARgrLrUZuqDlD49IF9xvqzNwTzASYObaEKgUjDKKl4UsZ2rnyf80HcXs3QEz
 SNflPZPEE+j7Zo5tRiNjauMc++jO86QA6KwoAqYRDCW0ckpfGiFdAQxRz7NQXtbE+5EZ
 a2KW6KM4wwWB8Vjhs+h3iN3KWHdGzxpmvQ0QX3c5Jn8+koW7jn5ZjdFS/hlK0VZabLHJ
 q0RUq26daEZ3fAS1OGaaMsMFB3lVnyjWAydAv8yTsWevsYNwgFVQ5zFmZTqM8W/wLB0u
 X06DdrdLhOdOPvVswVOc/ZpJUbfH4NSzyYgph2K0jJDwZB1aQxV866+rwWrNHqjM4umH
 kvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750163607; x=1750768407;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gIIyZHr+9RsDFmxHGEN0RPKXRXHMoYd/0G/iy5Z8Z1k=;
 b=pMtLaJAAcOGOeM5+eV+gyL20kzT4m1jd2UnENOzGvkWoYWdhpsq3XH2r1NfNEGG+o8
 hUx1JoWBFSdmL1Ov5BZtQZ78/xkuDVUvoLbSQI2erJidbxThgTbu5O53+Qhm8u8Gdviq
 B+WjNKRunOvkwWKsL0hvWlGNtxYdy0sm2OOM9qkDm2dCD1170j9fvJDci6jPW7NARdLd
 xKk8Q9k3Yurz86/SRb2smcGJwcJD/yXQxCjOwOoEYs5wXzU6EH4GR6eRMt2mtPAV6bJS
 RmmhBazbTsttW9AEK2t4VzNz/eokrIAuzm2CDXrsa+QnKSSnQYoLy+UyxKrWM0q1OVMx
 jIDA==
X-Gm-Message-State: AOJu0Yz6MX9Duy4tJNs5lYb5WY9ANvHEG1rTkz+Yvt3Hz/nq8qNnxAtH
 aYZRt2oUEqE4VoB5luWKN8oYoSK8MYC9ccxlm8GZa417OVnzBMrdniJbVX9Rag==
X-Gm-Gg: ASbGnct7wM2zWaQ4mAc7Jd7YT/lHJc/3oxGxi1SFXXONl4teTWskWuhMvHtKiK8ezJn
 P4v2Q2xn+hiri1oAmPXihgp31Bh2SQNXnZlslpNHJti2jlNsHvNI6Lhih/395KVOqg7r5FoLow+
 E0q153RZHLDROwG63TrCJllvL3SfTtZW30P964dinnFqVIvmEzwc6RJNuhjPPhn7eNq5s4IzL4U
 R8Q6eKUERi3rANP8mE5pJKxDn4r8aNby2tCkb0O1yUStTH3DI0SKzz42syRpr54SAk3amMXlm46
 +U1r7OhQLIH07T0+hwDJThyX8gJrF21c1VeKYEb+GmxWAjbGKDFuImfHgw==
X-Google-Smtp-Source: AGHT+IHkmz8Pfwv5WW2xzn3jBWKprcrZWzPCnNIVW0iKgkWz9kK+2BJJzVoPtpda6zKTby2lwCVA+Q==
X-Received: by 2002:a17:903:2983:b0:233:ab04:27a with SMTP id
 d9443c01a7336-2366b40ba84mr205079275ad.53.1750163606675; 
 Tue, 17 Jun 2025 05:33:26 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61::1000])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2365e0d22edsm78337615ad.240.2025.06.17.05.33.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 05:33:25 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-imx-next-20250617
Date: Tue, 17 Jun 2025 09:33:22 -0300
Message-Id: <20250617123322.1020714-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Hi Tom,

Please pull from u-boot-imx/next, thanks.

The following changes since commit 9de873b4c3098c0662d4adaeb1cc31be4e6d2688:

  Merge patch series "linux/bitfield.h: sync <linux/bitfield.h> from Linux 6.15 + winbond" (2025-06-14 09:13:39 -0600)

are available in the Git repository at:

  https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-next-20250617

for you to fetch changes up to 9d7f90782d0a768af76718e0cbc17c954d6731e5:

  ARM: imx: mxs: Add support for imx287 based BTT devices (2025-06-16 14:40:27 -0300)

u-boot-imx-next-20250617
------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-imx/-/pipelines/26728

- Add support for imx28 BTT boards.
----------------------------------------------------------------
Lukasz Majewski (1):
      ARM: imx: mxs: Add support for imx287 based BTT devices

 arch/arm/dts/imx28-btt3-0-u-boot.dtsi |   7 +
 arch/arm/dts/imx28-btt3-1-u-boot.dtsi |   7 +
 arch/arm/dts/imx28-btt3-2-u-boot.dtsi |   7 +
 arch/arm/dts/imx28-btt3-u-boot.dtsi   |  90 +++++++
 arch/arm/mach-imx/mxs/Kconfig         |   6 +
 board/liebherr/btt/Kconfig            |  24 ++
 board/liebherr/btt/MAINTAINERS        |   6 +
 board/liebherr/btt/Makefile           |   9 +
 board/liebherr/btt/boot_img_scr.h     |  27 ++
 board/liebherr/btt/btt.c              | 451 ++++++++++++++++++++++++++++++++++
 board/liebherr/btt/btt.env            | 139 +++++++++++
 board/liebherr/btt/spl_btt.c          | 347 ++++++++++++++++++++++++++
 configs/imx28_btt3_defconfig          | 140 +++++++++++
 doc/board/index.rst                   |   1 +
 doc/board/liebherr/btt.rst            |  34 +++
 doc/board/liebherr/index.rst          |   9 +
 include/configs/btt.h                 |  18 ++
 17 files changed, 1322 insertions(+)
 create mode 100644 arch/arm/dts/imx28-btt3-0-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx28-btt3-1-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx28-btt3-2-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx28-btt3-u-boot.dtsi
 create mode 100644 board/liebherr/btt/Kconfig
 create mode 100644 board/liebherr/btt/MAINTAINERS
 create mode 100644 board/liebherr/btt/Makefile
 create mode 100644 board/liebherr/btt/boot_img_scr.h
 create mode 100644 board/liebherr/btt/btt.c
 create mode 100644 board/liebherr/btt/btt.env
 create mode 100644 board/liebherr/btt/spl_btt.c
 create mode 100644 configs/imx28_btt3_defconfig
 create mode 100644 doc/board/liebherr/btt.rst
 create mode 100644 doc/board/liebherr/index.rst
 create mode 100644 include/configs/btt.h
