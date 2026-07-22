Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C0BC44536
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 21:36:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9D123608C2;
	Wed, 22 Jul 2026 21:36:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pfFLxAGArrZi; Wed, 22 Jul 2026 21:36:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AD81A608BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784756204;
	bh=m0fVem0bQYeNu29SF91MmnfQzSWU6YxQN9h/lS008mQ=;
	h=Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=BJtpFIChaAaYomztsnphWN5a3Zcmuz2mUgknhkM3QyneWSo8Ez8yKGP7MLi6fKR2j
	 mCvC15mk2XlXQIonRvlX0fqZgTC2HAZMa4vYnDWpB+sifdnbICIPTujiEljOhgXMAN
	 lUVCZi8+wgB6xcQBXP4iLPRb3yC3NQeVNbIizQjnE1uyVpQcmA6eSkO03cJnE06iTl
	 rUHaP7lgpkxRJnB7chzfsx/eay5Q/tzzICj5kQgQE0sm3DlZs/hTUW59PWwBSFJTG1
	 Wdetj4OetIYbjv/ieEAL9YY1jvY9GJyznwmiO4uXjCWzoQW9qNzDvLujKXe5inW3Rs
	 G57U3JRqjvM3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AD81A608BD;
	Wed, 22 Jul 2026 21:36:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 051671B8
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 21:36:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EA0EB608BD
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 21:36:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 79q0QQC8yytu for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 21:36:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:31::9;
 helo=mail-wm2-x09.google.com; envelope-from=ccaione@baylibre.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 779B0608A5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 779B0608A5
Received: from mail-wm2-x09.google.com (mail-wm2-x09.google.com
 [IPv6:2a00:1450:4864:31::9])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 779B0608A5
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 21:36:41 +0000 (UTC)
Received: by mail-wm2-x09.google.com with SMTP id
 5b1f17b1804b1-493e55619a2so26668255e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 14:36:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784756199; x=1785360999;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=m0fVem0bQYeNu29SF91MmnfQzSWU6YxQN9h/lS008mQ=;
 b=ectDqlw5G305myTvrtTJQIhcg3jkptX8/BHPoW2tzK+trwvZJuI6zPODENne3F270C
 Vf0YBH1q8KT72UlTU+n24VcqS7wp7+/CV19eCFzsb988G9U6gGSvmdWV5TVpHM+X9t4a
 v7lD1Fzp97KpLVFvw/3+BOVTRX2BNywd+X/bR317o8p5GTUG5Un1nsY+FDUUNXl8ljOS
 gak4cx2nGFCHYsdxRhB+p4mdtwsdDiDgNWqI4+y3zfAO6wRoARzApQc/pnF/jf0gHKO5
 32JRTLuY1LIVtSsSgvNzoUvS53jpyjB51R1ftsFy4ZaTAGaTueY40co8qgtBfsNhn5gY
 O/uw==
X-Forwarded-Encrypted: i=1;
 AHgh+RonqBoZTg3xZKzmQqrxaOvk1RgjZE4e9ojr/yaYz4QaQrrrC0AlyuW5wujfpHMdqgbSYfkW7cI=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yx7E7nZPLuH0oGtfi9+KuTfjNVJhfmlEnLBep6Cq6bMnIDARFDs
 7/yNMi4tR1DJf9M0iaTbgGxIToY4/qHkyI8lAJJ7BWtHOqIWMmTIrFGPBa1rt5kySi8=
X-Gm-Gg: AR+sD11hM7Jpdr21Ui3qkJQEUzv/7jYAYRmz9bRBp5QgpYHTNvYZj0c+rV9ohosZ38G
 pTb0R5BnV1PIvuIBn/Nke5LiXtADWQWp1Yy8ibQG0sAXRuckC7JgWWzJ7iI6ArrwWKyI+qiANz/
 WJdbtFZAT1BWOnU2BybJdm478Us+j+UcnG4TSHypMTDxD1U4zlhPRcCJmCFTcFb2dj8nUTzv7kK
 OuRQ0Kc6yjuAMhU0F+ydUvznetcTqQawS9YuVPsxtip/fedPOXwUzrHR10R1ZkdRrNNhAmn42zS
 8q9mqRsWsuTHUV2Aq5R3oIn0FPvc1QPvFFMi6dn3l7dtjsMHNaaiW+RTI7jpKu8vRehsysR9Qad
 xs+vdew4PdeCRyJzBEBX56FBUtOHIL8PBbyQDSvJMNUEdMzIdKA1Ux0izlC1TLU7RELxzetIahB
 1mXSnrWKH1vLT6qA/R6GkJJNLgX8fuhrHDKyLVybmilHJE5pJvRNmqB3FHsMk=
X-Received: by 2002:a05:600c:1992:b0:495:4f88:598a with SMTP id
 5b1f17b1804b1-49573cc7213mr4146925e9.13.1784756199144; 
 Wed, 22 Jul 2026 14:36:39 -0700 (PDT)
Received: from [127.0.0.1] (host-87-0-90-136.retail.telecomitalia.it.
 [87.0.90.136]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956a509901sm174954605e9.8.2026.07.22.14.36.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 14:36:38 -0700 (PDT)
Subject: [PATCH v2 0/4] Add Genio 700 SPL boot support
Date: Wed, 22 Jul 2026 23:35:47 +0200
Message-Id: <20260722-ccaione-upstream-mt8390-spl-v2-0-7aa005345711@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NSw6CMBQAr0K69pm2aEFW3sOw6OdVavilLURCu
 LsF49blJJOZlQT0DgOpspV4nF1wQ5+AnzKiG9k/EZxJTDjlghasAK1lUhCmMUSPsoMulvmNQhh
 bKKy4aMm4scqQVBg9Wvc+6o/6y2FSL9RxT+5G40Ic/HLsZ7Z7v1P59zQzoMD4VShhrJG5vSu5t
 E55POuhI/W2bR+cJFSO2wAAAA==
X-Change-ID: 20260717-ccaione-upstream-mt8390-spl-7f64ca12dfbd
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Johan Jonker <jbx6244@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784756199; x=1785360999;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=m0fVem0bQYeNu29SF91MmnfQzSWU6YxQN9h/lS008mQ=;
 b=KnDyDYLsqenLTs+u+YSbGtVGZ65DZjs/dfWkxlV3UwLPFQkAYKAK+JIu8qyocNp8py
 xjUyAnZ8TU5+lSWD/3aCA/aGJozn79CTgTof7WzJQwckeOZR2L/KaL8YLYBXNr7H7zoN
 VnjVI48edpYViyEmbddYDHyKO583eQRGYTOLTTibMVouL11jz/ATavnkhGfMGmAKiZJW
 HjZN/4wsNJ0d+K6Bz6th6XJYSM1tZ+sLiGd0W3xn9mTmhQjPHoyI+am/6jFYAXFlppWQ
 dkAIqN+MJaMJjJs01B/MnrDOzg4+2u5i8vNuUY0uYiBbXJtb8eCsa+E7c2KhDhzms/PD
 qMFA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=KnDyDYLs
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
From: Carlo Caione via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Carlo Caione <ccaione@baylibre.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The Genio 700 boot chain uses a platform DDR loader built separately
from U-Boot to initialize DRAM before entering U-Boot SPL. Add the SPL
devicetree and configuration needed to initialize the debug UART, watchdog,
pinctrl, and eMMC, then load a conventional FIT from the bootloaders GPT
partition.

Add a binman description that generates the two images consumed by the
MediaTek flashing flow:

  mtk-boot.bin
    MediaTek BootROM wrapper containing the platform DDR loader and SPL

  bootloaders.img
    FIT containing BL31, OP-TEE, U-Boot proper, and its control DT

The DDR loader, BL31, and OP-TEE remain external build inputs. Document the
complete build and flashing procedure.

Tested on a Genio 700 EVK using a full genio-flash cycle and a cold
boot. SPL loaded the FIT from eMMC and passed OP-TEE as BL32 and U-Boot
proper as BL33 to BL31. Linux 6.6.37 reached the RITY login prompt.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
Changes in v2:
- Clarify that the platform DDR loader is built separately from U-Boot.
- Fix the SPL copy-window wording in patch 2.
- Keep the SPL annotations board-scoped and drop the unused pericfg_ao tag.
- Normalize the firmware-stage names in the board documentation.
- Simplify the documented build commands.
- Remove the redundant MediaTek documentation maintainer pattern.
- Add links to Genio Tools and prebuilt images.
- Link to v1: https://patch.msgid.link/20260718-ccaione-upstream-mt8390-spl-v1-0-1256b6dfda3f@baylibre.com

---
Carlo Caione (4):
      arm: dts: mediatek: prepare Genio 700 devices for SPL
      configs: mt8390: enable eMMC FIT boot from SPL
      arm: mediatek: mt8390: build boot images with binman
      doc: board: mediatek: document Genio 700 SPL boot

 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi | 206 ++++++++++++++++++++++++++
 arch/arm/mach-mediatek/Kconfig                |   1 +
 board/mediatek/MAINTAINERS                    |   1 +
 configs/mt8390_genio_700_evk_defconfig        |  28 ++++
 doc/board/mediatek/index.rst                  |   1 +
 doc/board/mediatek/mt8390-genio-700-evk.rst   | 164 ++++++++++++++++++++
 6 files changed, 401 insertions(+)
---
base-commit: d0c49353a648e135f269a2953dc9326505ba87de
change-id: 20260717-ccaione-upstream-mt8390-spl-7f64ca12dfbd

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

