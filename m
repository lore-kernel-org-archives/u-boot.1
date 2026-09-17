Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E96C982D0
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 22:33:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E43288111E;
	Thu, 17 Sep 2026 22:33:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BIInGWBER_00; Thu, 17 Sep 2026 22:33:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C3DE881113
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789684402;
	b=ac7+ZWwq1aeJKKHqLJteDiZpZAPgGAt7yporezBw9sXF3/zst3eidhRNhI9agE8Dk6fy
	 AnePmMa8BafB+fBJdfYXCOC7JvKMpZEBArvdjQqMiFbLnW4x0YHLhUpOpNL0QHrqAYCel
	 72RaqV5mGd4iJ6MDnuiC3D060142PZeEsLbsnaHwujbvJrBmF5O5FeYPpJzM7FT+G4wlb
	 cKG+OM5y2FvZjZsZDk46h33ZZunINi716Bd/7ArXIHu9bx3nH7a7tIWP9aIU5qsQgN6/B
	 42fRbkap1AO+FxQ38L0rhTbLzcjBr9rvDcKWP/M+Ng1yvsdRSckVb3AqF31kWqDViBg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789684402;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KXWYSP/ROJMR8ZrSrxkbBz8P932/3FCLYmjLflmPFsM=;
	b=PUxqaFVbcaMtO1MthxmgmKkJLHsYA6ZYD9WRszUTS+Dv2C1dy+PlnnOCL/hqIX0EBaRo
	 QGWrQKR4nGvZMD9ukIDIEW3c2zquz5XG8Hibq4KJ/B3okqMw1KiP5C5L6t5j2P5bw85eB
	 XSpkC9WpNRGtugQf2Xbq2RKy7/ejDW82MpnSYUNSEuRM69+nhq0vSQr3kocSyA7J2VVUP
	 S7KIRotUZYib4uKk7AzyCm+AG0CsVWkNenOEVcbjP6tlS8jg6KUIBvvyQCJwkoI9nD102
	 tdlSHivMPGZ+ER1UKlmy+WhdJUXn1itpyhYQ3T3Xh4ik2fV2ROD2jwoLF3K2sRRoNQw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789684402;
	bh=KXWYSP/ROJMR8ZrSrxkbBz8P932/3FCLYmjLflmPFsM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MbZ2mdldG+nCqHR8gKpDCDH/UfjkICRpsdgHCN3w/C9VB//X9UWe163Xo6vDLZcS3
	 QoVsU01F6VrFZGdNV+Fm3QUDCquGUVSVnx1csPdoIdneUxzwpkAiiRXjeHSzU4P+bE
	 NeOzOXvzINGsxlsyQXQstgWXZflzG4RcadwoQgoBin56bIa/vRVKV+oQyUly6yQuVl
	 qiyO+TM+GbFxLh7pV7raZikLCRXEEEZe7Ae6Fn7ZNeg68sswmOgYA8gIsIO1I/7WwZ
	 XGSh0tZw3Knl/D9VqDvdT6kQsa/fxKWINlfg+hilSUBH51QMrAy/8urqwdeA3/kc1n
	 1y0QAhtGuQruA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C3DE881113;
	Thu, 17 Sep 2026 22:33:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E1E9A3B6
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 22:33:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DF70B40460
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 22:33:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9X2hreSLXnv2 for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 22:33:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 1BDE44045B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::2"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789684399;
 b=iQHo+h3YE7sJVjjugj5FwCYKp7+RfFag8+Pb5quJWqbmLS6LhujUOCHONMv+6BaifKcQ
 VJvnLW1gCHSUBs6oy99zEt6AxWowqSZSNXDX05/Nzs2sFOgoRuG109655hpIo8+MRmoMs
 lZSIjhuyOJ4cQsHulD/GbTApXgppLU67qgDr5gi2vrZOQG0JVYpRv9b6EJ2Pi0BcvqSd/
 bxScbC2D8FpZ3P4zV19SzXGNIa4uNYhZU4rZCiEL5JbnXiD9MJ79zIuayMmpAt+0ap5E/
 Jxw1Az9fdnAYnw+5uRjW7JVvTA9tFndAoWiNFlDk5KUjTKL4sRc7rSj/oS9YVKviBbw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789684399;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=KXWYSP/ROJMR8ZrSrxkbBz8P932/3FCLYmjLflmPFsM=;
 b=R8PlRiQ8A+PPGrN8dYubtHp/D+B2aJZm9Z5QpB3CX53JLg9bnV5P/ZA47nyd5O57VbmW
 vlUDAtIyi2m+wbvhlzS3kqGISd57RzOKquDLps6fNd3meg+7kPhEYPINP80051oj7LaEb
 qIjkRdxk9lEIK/7+oqEt9+L9TfaqgdmrVsP35oapgnI2GEeXxV9STMw6lz61yh7rXR5ti
 0krLYgknvfQqB6w/kjmd1KYCHErrC6qZyWzyLZ+FhhCowtjcw/LXWgsXRPMg/Q7k01qH2
 WLdTJPWt0J47R913u06q/3UUwO5TF9aAVc0KsHpolL1wsYhCaokk3TnAnPdwBfMAxPw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=e83Rnl3v; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::2"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::2;
 helo=mail-oi2-x02.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=e83Rnl3v
Received: from mail-oi2-x02.google.com (mail-oi2-x02.google.com
 [IPv6:2607:f8b0:4864:32::2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1BDE44045B
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 22:33:18 +0000 (UTC)
Received: by mail-oi2-x02.google.com with SMTP id
 5614622812f47-4ab2d72ff13so69951b6e.0
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 15:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789684397; x=1790289197;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=KXWYSP/ROJMR8ZrSrxkbBz8P932/3FCLYmjLflmPFsM=;
 b=e83Rnl3vy7pqkeqVSKaoEGSzDzLEmW28i53Qr650g5HL4V38tV4GIvO1tmkDUHdHLI
 zMMxt3OfcvnHpOPK8gPbcBjOD+Dm70WnHjIqo9JknCkre4XChn7mXJli/gp10DAzgbuQ
 c5eh2AbfeBKEbmWEjul0IRPMmxKuA4a2hcv7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789684397; x=1790289197;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KXWYSP/ROJMR8ZrSrxkbBz8P932/3FCLYmjLflmPFsM=;
 b=VnHe2FATwnstyUTXhXZUyNUE4JXl+NuKVMZqnncoHXw/Pl3hdYbySm9F0ZeX/gUIvn
 BGskuqUfj+O/+Sk2Sk45g3Y7/3SPFiLyZC9CeFNp76uQCOJvtZs/7AUChU7i57q+WWTs
 2LiN+nWFkTb1WeMUx86YPmxgZlYV1DNzadpf2GMDYCVGizXjCuwzjvAZ1xw3ORQXwgbH
 P6D8NbzBsueWL3iBA0uISPyu672cJcR8O518H9qMGvndkw5SIaiC2kG0zWCAQoqZ2ikl
 x/WSbrXZJNdxShKF+Rjd80zETO2Y//Qx/UlKC60H5QDu/MacJstTgz6kzaPSQ0OEqlzz
 r7qw==
X-Gm-Message-State: AFuF++lQHc5zcpy+WHNJjV8KuKmmlT5FjwveXq882Ajlu0D7QN5Ulo/q
 P+XGr2gcS83Ir0XXji9sTnwPzYSPlHXj30TV1G93Q0J0qlVYs5xxGBhFTXVnh8nWLouJDTVk8qg
 YkJQ2T27qxh85yI8=
X-Gm-Gg: AYBFou2MGUtkFTGQKlDyXi4CsEUSGwbPXKb0pozXf94BPLrrTr2KuucZhQ9IOLwIEzr
 WN6pv3ZeEWVn4+AVfaWvOKHyvtMF4vzOUD+DRpaYJnMwR2oEM0+nlevxbGek5W5BjUGt2uM/mxR
 9EPQYqpWWezJKDKGLGAHybJa5F9UMX2DoP0cVLukMTWfxz8rs8MsmPStLsm8TYWxDZyzzdyLLZk
 qVRKnrw8A4aDuAKGUck8SVpfepzXS6tNb6xWQ0ObXzapA18EbrONBbM4NwQKfPHfWE3vJv0suX7
 LfBXZXrzvASC/aowbaQUlHaOk0yUbzrVFMY7NUURWCW69mWVXUoRfKz4k28Ai0B0C6x2bue8Evr
 s/6E7CTmjBCUUbvHcG0djRNE8nIildCKSvBK7qEWlUSkULjCzMXcXW/ec0ASNpUUjbO/ny3MPeL
 gtGleYofnrcSbuonli4ps6Gx5Cb6jwuFLvBeec1CYsb0yvpUpktZFzxDh3OtlmKZUfprEDBLBE3
 hg6rF19htkPIjZ7/AuYoOoM+mEX7Lg+xKNosoeA54k9XfBQ1zc2ijbTwe90K15wq2jLLXMCfYDG
 0aqiTZb2PslrGqxEHgLLK1hHzInNtL3GIoYMeN48UjXr
X-Received: by 2002:a05:6808:16ab:b0:4ab:230c:5faa with SMTP id
 5614622812f47-4ccf6647177mr875393b6e.18.1789684397261; 
 Thu, 17 Sep 2026 15:33:17 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4cb6d99ae78sm3992369b6e.18.2026.09.17.15.33.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 15:33:16 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Cc: Michal Simek <michal.simek@amd.com>
Subject: [PATCH] Revert "Clean up emails from non-existing domains"
Date: Thu, 17 Sep 2026 16:33:14 -0600
Message-ID: <20260917223315.1569767-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Marking boards as Orphaned and not having a listed maintainer causes CI
to fail on the check for defconfigs without a maintainer. So these need
to be removed, first.

This reverts commit 7dd0d23b9c27605198ac9aaac5b62a3a352bf5eb.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 MAINTAINERS                                          | 1 +
 arch/arm/dts/sun9i-a80-cx-a99.dts                    | 2 +-
 arch/arm/include/asm/arch-lpc32xx/gpio.h             | 2 +-
 arch/arm/include/asm/arch-lpc32xx/mux.h              | 2 +-
 arch/arm/mach-lpc32xx/dram.c                         | 2 +-
 arch/arm/mach-lpc32xx/lowlevel_init.S                | 2 +-
 arch/mips/dts/ap152.dts                              | 2 +-
 arch/mips/dts/qca956x.dtsi                           | 2 +-
 arch/mips/mach-ath79/include/mach/ath79.h            | 2 +-
 arch/mips/mach-ath79/qca956x/clk.c                   | 2 +-
 arch/mips/mach-ath79/qca956x/cpu.c                   | 2 +-
 arch/mips/mach-ath79/qca956x/ddr.c                   | 2 +-
 arch/mips/mach-ath79/qca956x/qca956x-ddr-tap.S       | 2 +-
 arch/mips/mach-ath79/reset.c                         | 2 +-
 board/embest/mx6boards/MAINTAINERS                   | 3 ++-
 board/embest/mx6boards/mx6boards.c                   | 2 +-
 board/phytec/pcm052/MAINTAINERS                      | 3 ++-
 board/qca/ap152/MAINTAINERS                          | 2 +-
 board/qca/ap152/ap152.c                              | 2 +-
 board/sunxi/MAINTAINERS                              | 3 ++-
 board/work-microwave/work_92105/MAINTAINERS          | 3 ++-
 board/work-microwave/work_92105/Makefile             | 2 +-
 board/work-microwave/work_92105/work_92105.c         | 2 +-
 board/work-microwave/work_92105/work_92105_display.c | 2 +-
 board/work-microwave/work_92105/work_92105_display.h | 2 +-
 board/work-microwave/work_92105/work_92105_spl.c     | 2 +-
 cmd/dfu.c                                            | 2 +-
 cmd/gpt.c                                            | 2 +-
 common/dfu.c                                         | 2 +-
 doc/README.dfutftp                                   | 2 +-
 drivers/dfu/dfu_alt.c                                | 2 +-
 drivers/gpio/lpc32xx_gpio.c                          | 2 +-
 drivers/i2c/lpc32xx_i2c.c                            | 2 +-
 drivers/mtd/nand/raw/lpc32xx_nand_mlc.c              | 2 +-
 drivers/net/ag7xxx.c                                 | 2 +-
 drivers/usb/host/ohci-hcd.c                          | 2 +-
 include/configs/ap152.h                              | 2 +-
 include/configs/bk4r1.h                              | 2 +-
 include/configs/embestmx6boards.h                    | 2 +-
 include/configs/work_92105.h                         | 2 +-
 scripts/get_default_envs.sh                          | 2 +-
 tools/lpc32xximage.c                                 | 2 +-
 tools/vybridimage.c                                  | 2 +-
 43 files changed, 47 insertions(+), 42 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a23a4fbe259c..eb4209bdea67 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1441,6 +1441,7 @@ S:	Maintained
 F:	drivers/net/phy/nxp-c45-tja11xx.c
 
 ONENAND
+#M:	Lukasz Majewski <l.majewski@majess.pl>
 S:	Orphan (Since 2017-01)
 T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-onenand.git
 F:	drivers/mtd/onenand/
diff --git a/arch/arm/dts/sun9i-a80-cx-a99.dts b/arch/arm/dts/sun9i-a80-cx-a99.dts
index 0642161ec969..cf126bbd2c57 100644
--- a/arch/arm/dts/sun9i-a80-cx-a99.dts
+++ b/arch/arm/dts/sun9i-a80-cx-a99.dts
@@ -1,7 +1,7 @@
 /*
  * sun9i-a80-cx-a99.dts - Device Tree file for the Sunchip CX-A99 board.
  *
- * Copyright (C) 2017 Rask Ingemann Lambertsen
+ * Copyright (C) 2017 Rask Ingemann Lambertsen <rask@formelder.dk>
  *
  * This file is dual-licensed: you can use it either under the terms
  * of the GPL or the X11 license, at your option. Note that this dual
diff --git a/arch/arm/include/asm/arch-lpc32xx/gpio.h b/arch/arm/include/asm/arch-lpc32xx/gpio.h
index 103c0219c194..93e7a8875215 100644
--- a/arch/arm/include/asm/arch-lpc32xx/gpio.h
+++ b/arch/arm/include/asm/arch-lpc32xx/gpio.h
@@ -3,7 +3,7 @@
  * LPC32xx GPIO interface
  *
  * (C) Copyright 2014  DENX Software Engineering GmbH
- * Written-by: Albert ARIBAUD
+ * Written-by: Albert ARIBAUD <albert.aribaud@3adev.fr>
  */
 
 /**
diff --git a/arch/arm/include/asm/arch-lpc32xx/mux.h b/arch/arm/include/asm/arch-lpc32xx/mux.h
index ec69a5da2feb..d661e8236f32 100644
--- a/arch/arm/include/asm/arch-lpc32xx/mux.h
+++ b/arch/arm/include/asm/arch-lpc32xx/mux.h
@@ -3,7 +3,7 @@
  * LPC32xx MUX interface
  *
  * (C) Copyright 2015  DENX Software Engineering GmbH
- * Written-by: Albert ARIBAUD
+ * Written-by: Albert ARIBAUD <albert.aribaud@3adev.fr>
  */
 
 /**
diff --git a/arch/arm/mach-lpc32xx/dram.c b/arch/arm/mach-lpc32xx/dram.c
index a311455cd4d7..ab7c13512a5a 100644
--- a/arch/arm/mach-lpc32xx/dram.c
+++ b/arch/arm/mach-lpc32xx/dram.c
@@ -3,7 +3,7 @@
  * LPC32xx dram init
  *
  * (C) Copyright 2014  DENX Software Engineering GmbH
- * Written-by: Albert ARIBAUD
+ * Written-by: Albert ARIBAUD <albert.aribaud@3adev.fr>
  *
  * This is called by SPL to gain access to the SDR DRAM.
  *
diff --git a/arch/arm/mach-lpc32xx/lowlevel_init.S b/arch/arm/mach-lpc32xx/lowlevel_init.S
index 55c47c5a433b..d42da2bc5672 100644
--- a/arch/arm/mach-lpc32xx/lowlevel_init.S
+++ b/arch/arm/mach-lpc32xx/lowlevel_init.S
@@ -3,7 +3,7 @@
  * WORK Microwave work_92105 board low level init
  *
  * (C) Copyright 2014  DENX Software Engineering GmbH
- * Written-by: Albert ARIBAUD
+ * Written-by: Albert ARIBAUD <albert.aribaud@3adev.fr>
  *
  * Low level init is called from SPL to set up the clocks.
  * On entry, the LPC3250 is in Direct Run mode with all clocks
diff --git a/arch/mips/dts/ap152.dts b/arch/mips/dts/ap152.dts
index d0812a394817..1722290c731a 100644
--- a/arch/mips/dts/ap152.dts
+++ b/arch/mips/dts/ap152.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2018 Rosy Song
+ * Copyright (C) 2018 Rosy Song <rosysong@rosinson.com>
  */
 
 /dts-v1/;
diff --git a/arch/mips/dts/qca956x.dtsi b/arch/mips/dts/qca956x.dtsi
index a7a358bb854b..6cb360b3f860 100644
--- a/arch/mips/dts/qca956x.dtsi
+++ b/arch/mips/dts/qca956x.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2018 Rosy Song
+ * Copyright (C) 2018 Rosy Song <rosysong@rosinson.com>
  */
 
 #include "skeleton.dtsi"
diff --git a/arch/mips/mach-ath79/include/mach/ath79.h b/arch/mips/mach-ath79/include/mach/ath79.h
index 8d65d05bd45f..2eda38885e36 100644
--- a/arch/mips/mach-ath79/include/mach/ath79.h
+++ b/arch/mips/mach-ath79/include/mach/ath79.h
@@ -2,7 +2,7 @@
 /*
  * Atheros AR71XX/AR724X/AR913X common definitions
  *
- * Copyright (C) 2018-2019 Rosy Song
+ * Copyright (C) 2018-2019 Rosy Song <rosysong@rosinson.com>
  * Copyright (C) 2015-2016 Wills Wang <wills.wang@live.com>
  * Copyright (C) 2008-2011 Gabor Juhos <juhosg@openwrt.org>
  * Copyright (C) 2008 Imre Kaloz <kaloz@openwrt.org>
diff --git a/arch/mips/mach-ath79/qca956x/clk.c b/arch/mips/mach-ath79/qca956x/clk.c
index 84be2e485715..6138a915efcd 100644
--- a/arch/mips/mach-ath79/qca956x/clk.c
+++ b/arch/mips/mach-ath79/qca956x/clk.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2019 Rosy Song
+ * Copyright (C) 2019 Rosy Song <rosysong@rosinson.com>
  */
 
 #include <clock_legacy.h>
diff --git a/arch/mips/mach-ath79/qca956x/cpu.c b/arch/mips/mach-ath79/qca956x/cpu.c
index 01c850b8df3d..7da8d0e60f19 100644
--- a/arch/mips/mach-ath79/qca956x/cpu.c
+++ b/arch/mips/mach-ath79/qca956x/cpu.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2019 Rosy Song
+ * Copyright (C) 2019 Rosy Song <rosysong@rosinson.com>
  */
 
 /* The lowlevel_init() is not needed on QCA956X */
diff --git a/arch/mips/mach-ath79/qca956x/ddr.c b/arch/mips/mach-ath79/qca956x/ddr.c
index 462fc87b5a23..754e2573e37d 100644
--- a/arch/mips/mach-ath79/qca956x/ddr.c
+++ b/arch/mips/mach-ath79/qca956x/ddr.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2019 Rosy Song
+ * Copyright (C) 2019 Rosy Song <rosysong@rosinson.com>
  *
  * Based on QSDK
  */
diff --git a/arch/mips/mach-ath79/qca956x/qca956x-ddr-tap.S b/arch/mips/mach-ath79/qca956x/qca956x-ddr-tap.S
index 621c9529dcc3..db54b575fbc9 100644
--- a/arch/mips/mach-ath79/qca956x/qca956x-ddr-tap.S
+++ b/arch/mips/mach-ath79/qca956x/qca956x-ddr-tap.S
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2019 Rosy Song
+ * Copyright (C) 2019 Rosy Song <rosysong@rosinson.com>
  *
  * Based on QSDK
  */
diff --git a/arch/mips/mach-ath79/reset.c b/arch/mips/mach-ath79/reset.c
index 5748b36d535f..62da8b92a7d4 100644
--- a/arch/mips/mach-ath79/reset.c
+++ b/arch/mips/mach-ath79/reset.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2015-2016 Wills Wang <wills.wang@live.com>
- * Copyright (C) 2018-2019 Rosy Song
+ * Copyright (C) 2018-2019 Rosy Song <rosysong@rosinson.com>
  */
 
 #include <linux/bitops.h>
diff --git a/board/embest/mx6boards/MAINTAINERS b/board/embest/mx6boards/MAINTAINERS
index 46c17462e808..02756c58b3c8 100644
--- a/board/embest/mx6boards/MAINTAINERS
+++ b/board/embest/mx6boards/MAINTAINERS
@@ -1,5 +1,6 @@
 MX6BOARDS BOARD
-S:	Orphan
+M:	Eric Bénard <eric@eukrea.com>
+S:	Maintained
 F:	board/embest/mx6boards/
 F:	include/configs/embestmx6boards.h
 F:	configs/marsboard_defconfig
diff --git a/board/embest/mx6boards/mx6boards.c b/board/embest/mx6boards/mx6boards.c
index 0269259269e5..5ed41d01d9ba 100644
--- a/board/embest/mx6boards/mx6boards.c
+++ b/board/embest/mx6boards/mx6boards.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2014 Eukréa Electromatique
- * Author: Eric Bénard
+ * Author: Eric Bénard <eric@eukrea.com>
  *         Fabio Estevam <fabio.estevam@freescale.com>
  *         Jon Nettleton <jon.nettleton@gmail.com>
  *
diff --git a/board/phytec/pcm052/MAINTAINERS b/board/phytec/pcm052/MAINTAINERS
index 4883e2ff4d6e..66fe06e49c0b 100644
--- a/board/phytec/pcm052/MAINTAINERS
+++ b/board/phytec/pcm052/MAINTAINERS
@@ -1,5 +1,6 @@
 PCM052 BOARD
-S:	Orphan
+M:	Albert ARIBAUD (3ADEV) <albert.aribaud@3adev.fr>
+S:	Maintained
 F:	board/phytec/pcm052/
 F:	include/configs/bk4r1.h
 F:	include/configs/pcm052.h
diff --git a/board/qca/ap152/MAINTAINERS b/board/qca/ap152/MAINTAINERS
index aef8207010c1..785ec2766d16 100644
--- a/board/qca/ap152/MAINTAINERS
+++ b/board/qca/ap152/MAINTAINERS
@@ -1,5 +1,5 @@
 AP152 BOARD
-M:	Rosy Song
+M:	Rosy Song <rosysong@rosinson.com>
 S:	Maintained
 F:	board/qca/ap152/
 F:	include/configs/ap152.h
diff --git a/board/qca/ap152/ap152.c b/board/qca/ap152/ap152.c
index 0647656c4300..53587288c939 100644
--- a/board/qca/ap152/ap152.c
+++ b/board/qca/ap152/ap152.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright (C) 2018 Rosy Song
+ * Copyright (C) 2018 Rosy Song <rosysong@rosinson.com>
  */
 
 #include <init.h>
diff --git a/board/sunxi/MAINTAINERS b/board/sunxi/MAINTAINERS
index 8a746af6baa5..775d0f7ae83c 100644
--- a/board/sunxi/MAINTAINERS
+++ b/board/sunxi/MAINTAINERS
@@ -574,7 +574,8 @@ S:	Maintained
 F:	configs/sopine_baseboard_defconfig
 
 SUNCHIP CX-A99 BOARD
-S:	Orphan
+M:	Rask Ingemann Lambertsen <rask@formelder.dk>
+S:	Maintained
 F:	configs/Sunchip_CX-A99_defconfig
 W:	https://linux-sunxi.org/Sunchip_CX-A99
 
diff --git a/board/work-microwave/work_92105/MAINTAINERS b/board/work-microwave/work_92105/MAINTAINERS
index e81a90cb7be9..29a92c5ffe26 100644
--- a/board/work-microwave/work_92105/MAINTAINERS
+++ b/board/work-microwave/work_92105/MAINTAINERS
@@ -1,5 +1,6 @@
 WORK_92105 BOARD
-S:	Orphan
+M:	Albert ARIBAUD <albert.aribaud@3adev.fr>
+S:	Maintained
 F:	board/work-microwave/work_92105/
 F:	include/configs/work_92105.h
 F:	configs/work_92105_defconfig
diff --git a/board/work-microwave/work_92105/Makefile b/board/work-microwave/work_92105/Makefile
index e63901a0c2b1..a96098d0f2a5 100644
--- a/board/work-microwave/work_92105/Makefile
+++ b/board/work-microwave/work_92105/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 # (C) Copyright 2014  DENX Software Engineering GmbH
-# Written-by: Albert ARIBAUD
+# Written-by: Albert ARIBAUD <albert.aribaud@3adev.fr>
 
 ifdef CONFIG_XPL_BUILD
 obj-y	+= work_92105_spl.o
diff --git a/board/work-microwave/work_92105/work_92105.c b/board/work-microwave/work_92105/work_92105.c
index 641c1cd0e6fa..9a236880e3cc 100644
--- a/board/work-microwave/work_92105/work_92105.c
+++ b/board/work-microwave/work_92105/work_92105.c
@@ -3,7 +3,7 @@
  * WORK Microwave work_92105 board support
  *
  * (C) Copyright 2014  DENX Software Engineering GmbH
- * Written-by: Albert ARIBAUD
+ * Written-by: Albert ARIBAUD <albert.aribaud@3adev.fr>
  */
 
 #include <config.h>
diff --git a/board/work-microwave/work_92105/work_92105_display.c b/board/work-microwave/work_92105/work_92105_display.c
index 0cc4272e8841..d4ab2299895d 100644
--- a/board/work-microwave/work_92105/work_92105_display.c
+++ b/board/work-microwave/work_92105/work_92105_display.c
@@ -3,7 +3,7 @@
  * work_92105 display support
  *
  * (C) Copyright 2014  DENX Software Engineering GmbH
- * Written-by: Albert ARIBAUD
+ * Written-by: Albert ARIBAUD <albert.aribaud@3adev.fr>
  *
  * The work_92105 display is a HD44780-compatible module
  * controlled through a MAX6957AAX SPI port expander, two
diff --git a/board/work-microwave/work_92105/work_92105_display.h b/board/work-microwave/work_92105/work_92105_display.h
index be67d929c750..17a9aa04e022 100644
--- a/board/work-microwave/work_92105/work_92105_display.h
+++ b/board/work-microwave/work_92105/work_92105_display.h
@@ -3,7 +3,7 @@
  * work_92105 display support interface
  *
  * (C) Copyright 2014  DENX Software Engineering GmbH
- * Written-by: Albert ARIBAUD
+ * Written-by: Albert ARIBAUD <albert.aribaud@3adev.fr>
  *
  * The work_92105 display is a HD44780-compatible module
  * controlled through a MAX6957AAX SPI port expander, two
diff --git a/board/work-microwave/work_92105/work_92105_spl.c b/board/work-microwave/work_92105/work_92105_spl.c
index bc841e979b18..3f91221ce8b1 100644
--- a/board/work-microwave/work_92105/work_92105_spl.c
+++ b/board/work-microwave/work_92105/work_92105_spl.c
@@ -3,7 +3,7 @@
  * WORK Microwave work_92105 board support
  *
  * (C) Copyright 2014  DENX Software Engineering GmbH
- * Written-by: Albert ARIBAUD
+ * Written-by: Albert ARIBAUD <albert.aribaud@3adev.fr>
  */
 
 #include <asm/io.h>
diff --git a/cmd/dfu.c b/cmd/dfu.c
index b571137c1aa9..46f0190588e0 100644
--- a/cmd/dfu.c
+++ b/cmd/dfu.c
@@ -3,7 +3,7 @@
  * cmd_dfu.c -- dfu command
  *
  * Copyright (C) 2015
- * Lukasz Majewski
+ * Lukasz Majewski <l.majewski@majess.pl>
  *
  * Copyright (C) 2012 Samsung Electronics
  * authors: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
diff --git a/cmd/gpt.c b/cmd/gpt.c
index abbfc0fe46ae..205f696c8072 100644
--- a/cmd/gpt.c
+++ b/cmd/gpt.c
@@ -3,7 +3,7 @@
  * cmd_gpt.c -- GPT (GUID Partition Table) handling command
  *
  * Copyright (C) 2015
- * Lukasz Majewski
+ * Lukasz Majewski <l.majewski@majess.pl>
  *
  * Copyright (C) 2012 Samsung Electronics
  * author: Lukasz Majewski <l.majewski@samsung.com>
diff --git a/common/dfu.c b/common/dfu.c
index 341fd7ca7812..1af8194139c3 100644
--- a/common/dfu.c
+++ b/common/dfu.c
@@ -3,7 +3,7 @@
  * dfu.c -- dfu command
  *
  * Copyright (C) 2015
- * Lukasz Majewski
+ * Lukasz Majewski <l.majewski@majess.pl>
  *
  * Copyright (C) 2012 Samsung Electronics
  * authors: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
diff --git a/doc/README.dfutftp b/doc/README.dfutftp
index 184dec50f975..b25f398ee2e0 100644
--- a/doc/README.dfutftp
+++ b/doc/README.dfutftp
@@ -2,7 +2,7 @@
 #
 #  Copyright (C) 2015
 #
-#  Lukasz Majewski
+#  Lukasz Majewski <l.majewski@majess.pl>
 
 Device Firmware Upgrade (DFU) - extension to use TFTP
 =====================================================
diff --git a/drivers/dfu/dfu_alt.c b/drivers/dfu/dfu_alt.c
index 8d2e85856e5d..e9132936a90b 100644
--- a/drivers/dfu/dfu_alt.c
+++ b/drivers/dfu/dfu_alt.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * (C) Copyright 2015
- * Lukasz Majewski
+ * Lukasz Majewski <l.majewski@majess.pl>
  */
 
 #include <log.h>
diff --git a/drivers/gpio/lpc32xx_gpio.c b/drivers/gpio/lpc32xx_gpio.c
index 9c35f45d5487..2b537e007ba9 100644
--- a/drivers/gpio/lpc32xx_gpio.c
+++ b/drivers/gpio/lpc32xx_gpio.c
@@ -3,7 +3,7 @@
  * LPC32xxGPIO driver
  *
  * (C) Copyright 2014  DENX Software Engineering GmbH
- * Written-by: Albert ARIBAUD
+ * Written-by: Albert ARIBAUD <albert.aribaud@3adev.fr>
  */
 
 #include <asm/io.h>
diff --git a/drivers/i2c/lpc32xx_i2c.c b/drivers/i2c/lpc32xx_i2c.c
index 31fdea7c4054..a4e42e64a9b8 100644
--- a/drivers/i2c/lpc32xx_i2c.c
+++ b/drivers/i2c/lpc32xx_i2c.c
@@ -3,7 +3,7 @@
  * LPC32xx I2C interface driver
  *
  * (C) Copyright 2014-2015  DENX Software Engineering GmbH
- * Written-by: Albert ARIBAUD - 3ADEV
+ * Written-by: Albert ARIBAUD - 3ADEV <albert.aribaud@3adev.fr>
  */
 
 #include <config.h>
diff --git a/drivers/mtd/nand/raw/lpc32xx_nand_mlc.c b/drivers/mtd/nand/raw/lpc32xx_nand_mlc.c
index d9b05aa42fbc..7779e63fa5d1 100644
--- a/drivers/mtd/nand/raw/lpc32xx_nand_mlc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_nand_mlc.c
@@ -3,7 +3,7 @@
  * LPC32xx MLC NAND flash controller driver
  *
  * (C) Copyright 2014 3ADEV <http://3adev.com>
- * Written by Albert ARIBAUD
+ * Written by Albert ARIBAUD <albert.aribaud@3adev.fr>
  *
  * NOTE:
  *
diff --git a/drivers/net/ag7xxx.c b/drivers/net/ag7xxx.c
index 5c853fdded08..059a65d46610 100644
--- a/drivers/net/ag7xxx.c
+++ b/drivers/net/ag7xxx.c
@@ -3,7 +3,7 @@
  * Atheros AR71xx / AR9xxx GMAC driver
  *
  * Copyright (C) 2016 Marek Vasut <marex@denx.de>
- * Copyright (C) 2019 Rosy Song
+ * Copyright (C) 2019 Rosy Song <rosysong@rosinson.com>
  */
 
 #include <clock_legacy.h>
diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
index 761da36acb23..3fcf9d53d598 100644
--- a/drivers/usb/host/ohci-hcd.c
+++ b/drivers/usb/host/ohci-hcd.c
@@ -16,7 +16,7 @@
  * (C) Copyright 2000-2002 David Brownell
  *
  * Modified for the MP2USB by (C) Copyright 2005 Eric Benard
- * based on s3c24x0's driver
+ * ebenard@eukrea.com - based on s3c24x0's driver
  */
 /*
  * IMPORTANT NOTES
diff --git a/include/configs/ap152.h b/include/configs/ap152.h
index efc281bd18c1..c56b35150a5f 100644
--- a/include/configs/ap152.h
+++ b/include/configs/ap152.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * Copyright (C) 2018 Rosy Song
+ * Copyright (C) 2018 Rosy Song <rosysong@rosinson.com>
  */
 
 #ifndef __CONFIG_H
diff --git a/include/configs/bk4r1.h b/include/configs/bk4r1.h
index ba81c04eee55..4a0b9edf4579 100644
--- a/include/configs/bk4r1.h
+++ b/include/configs/bk4r1.h
@@ -4,7 +4,7 @@
  * Lukasz Majewski, DENX Software Engineering, lukma@denx.de
  *
  * Copyright 2016 3ADEV <http://3adev.com>
- * Written-by: Albert ARIBAUD
+ * Written-by: Albert ARIBAUD <albert.aribaud@3adev.fr>
  *
  * Configuration settings for BK4R1.
  */
diff --git a/include/configs/embestmx6boards.h b/include/configs/embestmx6boards.h
index 1d398a4e4a02..61c0d755a8d9 100644
--- a/include/configs/embestmx6boards.h
+++ b/include/configs/embestmx6boards.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2014 Eukréa Electromatique
- * Author: Eric Bénard
+ * Author: Eric Bénard <eric@eukrea.com>
  *
  * Configuration settings for the Embest RIoTboard
  *
diff --git a/include/configs/work_92105.h b/include/configs/work_92105.h
index 6c4f57f61b5c..f1a7853a80e6 100644
--- a/include/configs/work_92105.h
+++ b/include/configs/work_92105.h
@@ -3,7 +3,7 @@
  * WORK Microwave work_92105 board configuration file
  *
  * (C) Copyright 2014  DENX Software Engineering GmbH
- * Written-by: Albert ARIBAUD
+ * Written-by: Albert ARIBAUD <albert.aribaud@3adev.fr>
  */
 
 #ifndef __CONFIG_WORK_92105_H__
diff --git a/scripts/get_default_envs.sh b/scripts/get_default_envs.sh
index b2432bb88d28..fedf7206fe12 100755
--- a/scripts/get_default_envs.sh
+++ b/scripts/get_default_envs.sh
@@ -1,7 +1,7 @@
 #! /bin/bash
 # SPDX-License-Identifier: GPL-2.0+
 #
-# Copyright (C) 2016, Lukasz Majewski
+# Copyright (C) 2016, Lukasz Majewski <l.majewski@majess.pl>
 #
 
 # This file extracts default envs from built u-boot
diff --git a/tools/lpc32xximage.c b/tools/lpc32xximage.c
index 52e96bb3df42..715a55a5b5b3 100644
--- a/tools/lpc32xximage.c
+++ b/tools/lpc32xximage.c
@@ -3,7 +3,7 @@
  * Image manipulator for LPC32XX SoCs
  *
  * (C) Copyright 2015  DENX Software Engineering GmbH
- * Written-by: Albert ARIBAUD
+ * Written-by: Albert ARIBAUD <albert.aribaud@3adev.fr>
  *
  * Derived from omapimage.c:
  *
diff --git a/tools/vybridimage.c b/tools/vybridimage.c
index 7177e78d74c2..c38886fa9039 100644
--- a/tools/vybridimage.c
+++ b/tools/vybridimage.c
@@ -5,7 +5,7 @@
  * Derived from vybridimage.c
  *
  * (C) Copyright 2016  DENX Software Engineering GmbH
- * Written-by: Albert ARIBAUD
+ * Written-by: Albert ARIBAUD <albert.aribaud@3adev.fr>
  */
 
 #include "imagetool.h"
-- 
2.43.0

