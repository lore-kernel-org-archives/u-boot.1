Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46503EEF32A
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 08:49:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACADC83FB2;
	Thu,  5 Mar 2026 09:49:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="E5WQp1yL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76A1F83FBE; Thu,  5 Mar 2026 09:49:24 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9BBA83F93
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 09:49:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-439b9b190easo2780385f8f.2
 for <u-boot@lists.denx.de>; Thu, 05 Mar 2026 00:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772700561; x=1773305361;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LvkrnfHdoq1uQDBRF+13G9JrK8OOmOzGPtU9OQbl1p4=;
 b=E5WQp1yLpCQConyuPuW+ap/7tPF8VNtq+OtoLXWY8VZdjqZ/1Zuaj+VS8yPuCKP55z
 dtksr1eiyn9fWXitUcB1pykje6D+xGjx8ZCk4dSIVAUeasmBE3Iybx8njRH0JG8HWFSn
 qi9ag0YPWoUtLTPYnNxMFugs+S8vYhpCjS+IxWq3KFHXo26d6MMCvzjvvnu7wrf6uqEL
 pEjlmKeXzqerzzneC1xmC77ljLHr7NgcEivN5k7V6tYj33yn4jcsxy4It/91oAhjcy9k
 cYKOhWh47xyFt/wIZptW6BG+gMHOLUdflFh+guvOZ5JcnHyK1ewwXSEiGvuCOYHRZeHg
 wpxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772700561; x=1773305361;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LvkrnfHdoq1uQDBRF+13G9JrK8OOmOzGPtU9OQbl1p4=;
 b=AD4aYJ/lNlcx2q1JL9ImHesVQr8nS8hPMF/HeTYsHyoJ+qX7r7R3v6+CN27hHAiIwz
 6l92tuw0XLkq1Xpz4SG04ZVLAuXG3VByWtDxvS94juXzfOFrxatVFj/QGNfReUxQAfn9
 Qv78YuubmLVFpZpRftKT0QeGBdj/daSGWyyGEWwA5LOyFX/Tb9WiKGPaVeksFycUSEdx
 I7PBNa+4y8g5z9NMKmWeV5HiQ47Y3FcAaGlOOMnzC2fmZrI9KP1M8OwOPghsp/CM25Av
 0XU3DJOFsHFp5FpRqU59ujBq9tr4xapQBYcxC+8TjFjpDf1tB4/uIkRAL6qc+tQOO420
 vh/A==
X-Gm-Message-State: AOJu0Yz7Crk7GY+d418P7Nk61lOUWq0v7i8tjdBVREx51zdNy0oMz8TU
 TAU8xpTyHeMFIzMQ/V4/B4dMqHplfkrQQ5VmfDlHeLb9Ne/WteXq6vE9bKA1doXF8irbhoZs9Ps
 6Qdp2JGk=
X-Gm-Gg: ATEYQzzIg9AYvnlMzfPmCXdLMI4V7StQB1NX1IzprkhoIDDqMjwl6R5QMIkt70qgzr9
 08vhoxwVu3QBcrFWh01Zk4F4mgo+NLJz67c8QzSpw0SgFJ1rVFNU7JTcVddOSRWwVcMN2no2rnX
 Wtbe1MJ1hnVSG42lVNzsGE/Ydsu9QkLMuToiDu+XEkCAVlqMWJPCvtpXZJ8Gjl/6wijnKQ+mILw
 1cS8Obj8KN/XgGWkgFEn7G0G/LWizKHCdEVaB+Iiy0q1kTkQzh3m7Xl+TNcgAURJcoCIUN8mQg1
 Oa31f/R+1uVSGwVe5dieZIn9LHai3N5sD1pDvfnoEM8AcrvQLEx1uoO44pOCTAsHtisX6GWPFtb
 Ei3HSKNB2eirRW95IKnsUgOLAPUaiCt4j68NEYAtE6vENwBEAwz/sNZRsCdVJd2mkkFAw9R1jqE
 j9td2t5GnE21ZzVmrCMCYSBuywj3ycx9Cv48OHYSKSqIMTDDPQyCnIaNAiFbeZsWn1qVDb80mRJ
 baXlVHP7OwsR4cMVwOk4Q==
X-Received: by 2002:a05:6000:22ca:b0:439:beee:43aa with SMTP id
 ffacd0b85a97d-439c7f79af5mr9648997f8f.16.1772700561311; 
 Thu, 05 Mar 2026 00:49:21 -0800 (PST)
Received: from [192.168.1.64]
 (2a02-8428-e55b-1101-1e41-304e-170b-482f.rev.sfr.net.
 [2a02:8428:e55b:1101:1e41:304e:170b:482f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b03db76bsm33638231f8f.18.2026.03.05.00.49.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 00:49:20 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH v3 0/3] drivers: ufs: ufs_hba_ops callbacks cleanup
Date: Thu, 05 Mar 2026 09:49:01 +0100
Message-Id: <20260305-ufs-ufs_hba_ops-cleanup-v3-0-e153ffab98f5@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43NwQ6CMAyA4VcxOzuzdQjBk+9hDOlYJ0uQkU0WC
 eHdHRy96KGHv0m/LixScBTZ5bCwQMlF54cc6nhgbYfDg7gzuRkIKAVIwScbt2k6jY0fI297wmE
 aeaXqApUw9lyXLF+Pgax77/Ltnrtz8eXDvD9Kctv+NpPkgmsrgZQ0VGB91Tj3Tgc6tf7JNjbBn
 xRkyphKGQSJWMMXta7rB+bxNo8MAQAA
X-Change-ID: 20260210-ufs-ufs_hba_ops-cleanup-7394a30df596
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Bryan Brattlof <bb@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Jared McArthur <j-mcarthur@ti.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, 
 Michal Simek <michal.simek@amd.com>, dlechner@baylibre.com, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
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

Hi all,

I am currently writing a ufs driver for MT8195 and I noticed that return
values on ufs_hba_ops callbacks are ignored. Fix this.

While at it, I also removed a useless wrapper around
ufshcd_device_reset(), added a wrapper around
ufshcd_ops_phy_initialization and fixed a typo.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Changes in v3:
- Rebase on next branch
- Rename ret to err in drivers/ufs/ufs-rockchip.c
- unwrap line in drivers/ufs/ufs-rockchip.c
- Link to v2: https://lore.kernel.org/r/20260210-ufs-ufs_hba_ops-cleanup-v2-0-dd73da21aa92@baylibre.com

Changes in v2:
- Fix interactive rebase issue: add missing "," and rename ret to err
- Link to v1: https://lore.kernel.org/r/20260210-ufs-ufs_hba_ops-cleanup-v1-0-bf12e31de4a9@baylibre.com

---
Julien Stephan (3):
      drivers: ufs: handle return values of ufs_hba_ops callbacks
      drivers: ufs: add helper for phy_initialization callback
      drivers: ufs: fix typo in struct ufs_dev_cmd kernel-doc

 drivers/ufs/ufs-rockchip.c |  9 +++------
 drivers/ufs/ufs-uclass.c   | 36 ++++++++++++++++++++++++++----------
 drivers/ufs/ufs.h          | 10 +++++++++-
 3 files changed, 38 insertions(+), 17 deletions(-)
---
base-commit: c0ca147ac6228949a6d6497531c9f2f4a0dc6c67
change-id: 20260210-ufs-ufs_hba_ops-cleanup-7394a30df596

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>

