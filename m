Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93EECC36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 15:03:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1452084144;
	Fri, 11 Apr 2025 17:03:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lhvMdh4l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD43984148; Fri, 11 Apr 2025 17:03:43 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74C1284107
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 17:03:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-39c266c2dd5so1729916f8f.3
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 08:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744383820; x=1744988620; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bo4WFpYmlvS4V+xunHdmQ9QU9WR2rtXFyZkvEqHMmZ8=;
 b=lhvMdh4lk2FHxQ8/O/lnsG5plwPjIL58VfTrAGRIUJc+7hO8SXeGY2pAj8ahRGewU0
 b8IEto1hcrOdaKgpm1R7pBQ1eF3vpbwTz9Jyg0ltLJjNUaevjQo8nhpHLgnrZp7+4YJj
 nlawSfrj4Th2WY3u7mqTxnPw5NbxJom7+W/wKhszn03e23TFNQaIMrl0Ew1BPnzzjElh
 NyjvVMdRsyj4nBsysBAusGBff31JacXf8etuKo0+vb3ZAJ2QN47O2wjBsIWAZoRRKC6H
 wmUSOJ/zde4veULLPBqxqq/mW1FR0ELxKsZfGmSzBa2oW3uTSIKmLmc36Z/NKOjR0z3q
 ToRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744383820; x=1744988620;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bo4WFpYmlvS4V+xunHdmQ9QU9WR2rtXFyZkvEqHMmZ8=;
 b=cLseX4Ixtx7h6ggpNo2Hxk52Tgkg/4VldgS8Q+9DZhxpq9uCOHnKNSB2Ot5TN90JvW
 fJwt6rk3LgTKq8eGsr3toDsyevUj6dnVp+6qKi2NYvSF4Mnt/OhbkcRq5BRxhy2CkeS6
 RZx/JOrCwQmgPfu1JrPNUOr7Ht7CbLj4DO3HdHemTbsrlS18GxHxsdMlbrlJlNe/bBfc
 ZDIwssPJhrx07LA3TogoqCeqQXbPmfghkE5IVZciRSBrguPa47bIHJb6xpj8Mo6buwCj
 01NLQc2r6kfDQt/cxpG+KGDAUtvQs/utFnUlpRqKehxLV7oAQPw3pML6oO/zy4DMukhu
 WNWQ==
X-Gm-Message-State: AOJu0Yx1p8yQYEIvpRX492AP/IYcYxWRu4YQNtYsogPtv3c2QHS+P16A
 7ocaUnmNHjRnlkX6TPTN5fJyH6z2BysqWvJ2MrP25kHzjjsLsTfjlVv3hzUZfPlTCGW/quTCsiR
 UH24=
X-Gm-Gg: ASbGncueTVd34F8IDnjMMXmoTWuK4xsRralLtwDSWhXaQl/ESpe65gnXruLP9D5YZJd
 diTOKuPFomUXOM8RB/A4wnWQPdg6R5pTK/75T3HQMl/xqoCXxAVBI1arg06Js5tCq4XYQIG7G72
 vYKQIXLRw4Z1zfPbqaldnnTF7+ZeDqGQ0nuXHZU2oOinvtaaVxbkYzacTYJKg0rHrSf0PfB/l++
 xlSGn47Bxw5jGaaQD/djTio2ZOYLcJCLvlVQs5nfbhMtXtaogyTI2KliZmioy3HL6sQLbnIfxjl
 9ZOVRWoc+U5ooMAoBzjt2X9HFqd5JFpvusQ7hLZFprU78hC0eCtPRmwCJaWzKdvCKD9Es4Uhb0H
 ETInyr1HrL5hlt59WKw==
X-Google-Smtp-Source: AGHT+IEn9wZ3tdxTMjDU23vAgKFB3kyVNddfp2lz5mzoNyousfWtmCTS34vUEIutSHdjw/B1QzBgFA==
X-Received: by 2002:a05:6000:4285:b0:39c:1efb:ee8a with SMTP id
 ffacd0b85a97d-39eaaebdecfmr2616617f8f.38.1744383819557; 
 Fri, 11 Apr 2025 08:03:39 -0700 (PDT)
Received: from toyger.tail248178.ts.net (35-60-142-46.pool.kielnet.net.
 [46.142.60.35]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf445270sm2201005f8f.81.2025.04.11.08.03.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 08:03:38 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v2 0/4] Qualcomm: expand capsule update support
Date: Fri, 11 Apr 2025 17:03:33 +0200
Message-Id: <20250411-b4-qcom-capsule-update-improvements-v2-0-27f6b2fcc4a9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEUv+WcC/5WNQQ6DIBBFr9Kw7jSCFdOueo/GBcKgJAp0UNLGe
 PdSb9Dl+/l5b2MJyWFi99PGCLNLLvgC4nxielR+QHCmMBOVaKpaSOiv8NJhBq1iWieENRq1lNc
 cKWSc0S8JuLS27bUw3AhWTJHQuvdReXaFR5eWQJ8jmvlv/c+fOVSgLAqs5U3KtnlMzisKl0AD6
 /Z9/wISKMhH1wAAAA==
X-Change-ID: 20250326-b4-qcom-capsule-update-improvements-16ff7bc2d1d2
To: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2510;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=jzym53EOTdW5ol47c2dfDkyQ+qA3CMyzvsIBAoDyXoM=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn+S9Jh4jj5b9DFE+TSx6Agq7gg52p1/+dx4p0G
 xgezc0w1pGJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ/kvSQAKCRAFgzErGV9k
 toteD/47R5bzgiV/hli+TgYIZNWN3jU3OGikTbUc1lbAO0W2FbzQDD92putOabKhtU2HzEGu9w/
 WfoSoMUfeNsNmM23l6TfUR+X8NMyeSm74/n7B0gyr0DTEeibJyVFaMQ7wS55/ebbCPbFwwc7eX9
 IL/g9TEtMDjfthyi0GeCnV4il+GQKFjDaLPec9Hz/68R/mvteLz457y61vyxn1KuaHx0UXS9FVS
 ow3zEE4ppRS8ZKfDRDCnYPhSt6dYq8jtWUCRrTRKR/vvwVCBwN2LJLIw6JP3dv0dfimNlyk+tG1
 K6GZm4SPBDdruePDjtZ31upH+91m7qoixWfcN7nISGEtc5pylgjUAk9PtWq5DBRzPTSQ3M/hbiK
 aWlbcH78nwrPA8M97dVyhNR6y5y2IFBhwnCLUCmm2h0joLBqs77kKANspdGBWuh3e9PyUbteY2U
 t1GtfunoQHqGh0tZyZWl5CLFHNwyngabbKzhFlJpbMZcUCzIL82c5+lAyk9U2GSFJ0to0VQFg1W
 rfwhXZP4edt4E6T+TtZnFJLhCrAuRAg1PCAmVmRONbvXrsUbj0J04PlEfxOTKSFmABhNIUBt9Be
 LgSSksZfVXSmoCAxmR1F/BgsVCgkB07R34vgfLlktVK5/wuLrDT1Q3YxkhndmM2TrjzJ2ATDw3N
 a8s4tov/FjsNpyw==
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

The initial capsule update support only worked on the RB3 Gen 2 and made
a lot of assumptions specific to that board.

Implement the logic necessary to update U-Boot no matter where it was
flashed to, independent of any particular board.

First, we keep track of how U-Boot was loaded, specifically if we had a
valid external FDT (even if we didn't use it) this indicates that we
were booted via the Android bootloader, in this case the target for
capsule updates is the boot partition. Otherwise, we target the uefi
partition (if it exists) or the xbl partition. We handle A/B support for
all 3 (currently we always flash to the currently active partition with
a minor exception for the uefi partition).

We introduce two new fw_name strings to differentiate the GUIDs based on
the target partition, this means one board can support multiple boot
methods with capsule update support for all of them (typically this
would be chainloading OR flashing U-Boot to XBL).

Lastly, the call to scsi_scan() in dfu_scsi.c is removed. Since
scsi_scan() unbinds all scsi devices it breaks device handles maintained
in the EFI layer for the duration of the capsule update process and
causes the EFI filesystem access to delete the capsule file after the
update to fail.

Boards should instead be responsible for calling scsi_scan() before
initiating DFU.

---
Changes in v2:
- Restrict the partition hunt to either UFS storage or the first MMC
  device so that we never accidentally write to some external storage
  (like an sdcard) during a capsule update.
- Fix typo
- Link to v1: https://lore.kernel.org/r/20250326-b4-qcom-capsule-update-improvements-v1-0-afe2e3696675@linaro.org

---
Caleb Connolly (4):
      mach-snapdragon: track boot source
      mach-snapdragon: CapsuleUpdate: support all boot methods
      dfu: scsi: don't call scsi_scan()
      qcom_defconfig: enable capsule update support

 arch/arm/mach-snapdragon/board.c          |  26 +++
 arch/arm/mach-snapdragon/capsule_update.c | 274 ++++++++++++++++++++++++------
 arch/arm/mach-snapdragon/qcom-priv.h      |  14 ++
 configs/qcm6490_defconfig                 |   6 -
 configs/qcom_defconfig                    |   3 +
 drivers/dfu/dfu_scsi.c                    |   5 -
 6 files changed, 266 insertions(+), 62 deletions(-)
---
base-commit: 885d68280c29b8011731b6a7cdac32b8d9a4e6fd
change-id: 20250326-b4-qcom-capsule-update-improvements-16ff7bc2d1d2

Caleb Connolly <caleb.connolly@linaro.org>

