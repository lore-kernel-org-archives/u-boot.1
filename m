Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58664E668BC
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 19:17:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D1CD89580;
	Sun, 24 Nov 2024 20:17:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JEbY1p4D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB4018958F; Sun, 24 Nov 2024 20:17:49 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EEE989574
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 20:17:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a9a0ef5179dso564264266b.1
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 11:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732475867; x=1733080667; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AkS16PdFl146Kj58iM4khx1LEGiCxpCttDd/fCzxI7o=;
 b=JEbY1p4Dvr74VuvvKcfndo2I/nJZZ8B97FQxggLrJ8kH/kLkR/K2wPymmIQiBNmMjq
 XABxhk+KBZ8sOGsM5zmQskZ5ExmDuHvwDC9/G/bc3/Q9LugN0e7Z3PDyunSclTbkEdit
 zga7SwbPoUn7TxTLWxqzHDZ93rUnXRyZ4Mx69aOACLUq9tSmFr8uYvUzIEbDDy2ho4Rs
 oe0e10zt7mzEElHJ7W3dbVhhl3c/sbuh4W7p1LiIgjnPiZeLtc7QkAHKcHQ8QwSRGWvr
 Drf8/CNLFVzSwox+EFQ3q9elnUF4wUS+yZ31drgSlwh3Sz4wXwDdU4np7r5rFehuC4c4
 oD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732475867; x=1733080667;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AkS16PdFl146Kj58iM4khx1LEGiCxpCttDd/fCzxI7o=;
 b=wn5Jw1GmgyYsCyeaCXbD03Bwt7e3R9bAVM77sTry2ccqVN9dX249U5h4dAm8GZM87N
 aNNcGCZXwEoDgY95AxNUKnTJKZqGI3/bRtdp0uNyzvwNTlhqGQkmsPS+NKMSd2gjLBhe
 Cc+0nXTdLC3UtH+6wh18oBemXyrXAodBAC4bTAEuElVQ0u7DNWTt4wLj266ZqlZzhoZK
 dczFZOUelEcOKCYmn5Qvq3iUVdBTn5MeamwBLjgQbyouXFQET2X8JkQ6xJzRK5fc2jeN
 9s8yr6RSGEzk7muI2Fu+kUPGT8QHpfToQhmzTTs58YyPbuB08EnGY0P4QjYHkXheFsou
 G6XA==
X-Gm-Message-State: AOJu0YzYl7VldJy82i/8H7xI3KF1DA7jvHfY/Zb3TcEH9MrBOXxNwYO+
 WYHiHWjxe0R3oSjHWtpyNwo7ZLMRV0iztM65xG6OYTAJoAobgQP8zoUwc56sLus=
X-Gm-Gg: ASbGncuuZtHd/mN+lNel/1xMRcSeX2pFrk1HWoom6Z+7hdXBhPH2mzxeDAT71dqLNEa
 izmXDxSC3plB3kPjLhuFyQX9YjgSOA0BmMkifC7gXg+a0ksGKkPL5qKnWiOGaKk/cGNgVIzqwKb
 sjiIyYElwCJDB1tlGYaHeSbgf+vkhDUGt3Opw7rfoW/Wy7IcoHV/721oGMcCjoEdC+AFdoSknZi
 uaZOZwLwfBmcIh6ryyWTTGXwIds+BqB4/8cyqG9cy9c5qLzGqWTLMlkLMtm6L97qUYT
X-Google-Smtp-Source: AGHT+IG95rHOTS9ZxFJcQ7IynkGhQdFEKNClRu3UcKiwuMvxfLHacsNA/qt8qjdsA7C2VBzowq3RrQ==
X-Received: by 2002:a17:907:7784:b0:aa5:3f3b:31dd with SMTP id
 a640c23a62f3a-aa53f3b323fmr334291366b.19.1732475866690; 
 Sun, 24 Nov 2024 11:17:46 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa50b28f848sm371874566b.36.2024.11.24.11.17.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 11:17:46 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH 00/15] qcom: smem: modernize SMEM in U-Boot
Date: Sun, 24 Nov 2024 20:17:42 +0100
Message-Id: <20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANZ7Q2cC/x2MwQqAIBAFfyX2nNBKRfQr0SHzVXvQwoUIwn9PO
 s7AzEuKJFAaq5cSblE5YwGuK1qPJe4w4guTbWzLbNm41oTTI0VRGA0IxXS9G2DZ945KdyVs8vz
 Pac75A6Y74pNjAAAA
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Mario Six <mario.six@gdsys.cc>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3589;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=km2revj1f6xG09fMv4sBaaaQ40UoL0ywYbO1ZWSE4Xs=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhnTn6htzv8ZrKypzMKXUiMxYPNPX32CR4Wfx7RYnDmVY7
 3F5cflSRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZjIlQhGhi619Dz1D4pTutk/
 nOF2kqg2VEw7Mp/r1fW7Cx44tVgFnmT4xZzVEL7/n/GhrGmXnu72unox7ve+EzFnWxbrl1mpr9Y
 /FgQA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Smem is currently implemented a uclass in U-Boot. This carries with it
some implicit limitations about how and when we can actually talk with
it, since its modelled as a device.

The SMEM uclass is qualcomm specific and has no other users, while it
was originally proposed as a platform agnostic abstraction it seems
clear that UCLASS_MISC has served that purpose better.

Let's drop the old smem code and replace it with a straight port from
Linux, providing a familiar interface and enabling us to access it much
earlier in the boot process that would be possible with a standard
device.

Additionally, this will be easier to maintain going forwards since any
patches from Linux can be more easily ported over.

With this new smem framework in place, we can now use SMEM to parse
the memory map when it's not provided via some other mechanism.
Additionally, we can use it to read the serial number of the board.

Implement this functionality and split the snapdragon memory parsing off
to its own file to try and organise things a bit better.

This depends on a patch [1] making malloc available in fdtdec_setup() since
malloc is required to initialise smem.

[1]: https://lore.kernel.org/u-boot/20241124183832.2476928-1-caleb.connolly@linaro.org

---
Caleb Connolly (15):
      Revert "dm: SMEM (Shared memory) uclass"
      smem: drop drivers/smem
      Revert "test: smem: add basic smem test"
      Revert "drivers: smem: sandbox"
      soc: qcom: import smem from Linux 6.11-rc2
      soc: qcom: smem: adjust headers for U-Boot
      soc: qcom: smem: adjust for U-Boot
      soc: qcom: smem: get serial number from socinfo
      soc: qcom: smem: stub functions
      soc: qcom: smem: add build infra
      mach-snapdragon: increase pre-relocation malloc size for smem
      mach-snapdragon: move memory parsing to its own file
      mach-snapdragon: support parsing memory map from SMEM
      mach-snapdragon: fetch serial# from SMEM
      qcom_defconfig: enable QCOM_SMEM

 arch/arm/Kconfig                             |   2 -
 arch/arm/mach-snapdragon/Kconfig             |   2 +-
 arch/arm/mach-snapdragon/Makefile            |   2 +-
 arch/arm/mach-snapdragon/board.c             | 107 +---
 arch/arm/mach-snapdragon/dram.c              | 214 ++++++++
 arch/arm/mach-snapdragon/qcom-priv.h         |   4 +
 arch/sandbox/dts/test.dts                    |   4 -
 configs/qcom_defconfig                       |   1 +
 configs/sandbox64_defconfig                  |   2 -
 configs/sandbox_defconfig                    |   2 -
 drivers/Kconfig                              |   2 -
 drivers/Makefile                             |   1 -
 drivers/smem/Kconfig                         |  24 -
 drivers/smem/Makefile                        |   7 -
 drivers/smem/sandbox_smem.c                  |  44 --
 drivers/smem/smem-uclass.c                   |  46 --
 drivers/soc/qcom/Kconfig                     |   8 +
 drivers/soc/qcom/Makefile                    |   1 +
 drivers/{smem/msm_smem.c => soc/qcom/smem.c} | 741 ++++++++++++++++-----------
 include/dm/uclass-id.h                       |   1 -
 include/smem.h                               |  90 ----
 include/soc/qcom/smem.h                      |  36 ++
 include/soc/qcom/socinfo.h                   | 111 ++++
 test/dm/Makefile                             |   1 -
 test/dm/smem.c                               |  26 -
 25 files changed, 842 insertions(+), 637 deletions(-)
---
base-commit: 7aad7833323aa9260935d172744a50f56356d52a

// Caleb (they/them)

