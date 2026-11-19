Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C93606A326
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 13:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mR/p25Wy;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k3F/8tfD
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ACC3040AE0;
	Thu, 19 Nov 2026 13:33:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mFjaGZEwd11p; Thu, 19 Nov 2026 13:33:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E14E140B1F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795095223;
	b=IzfbIcIPuy8MAng9McfJ2kazZm5WfSRgn284CQUO3z/WrNczuYxGPn7D6S/s/XjP/s2M
	 k/yCodMj9j95Z+OCgeJLOrq8Kaoafd7fsUPbqSVN+RwlcoFpXC3modLM5q5W1qDacvzLo
	 xlYpf/J+K3LnO3Rl7y+RvxLlibzC/jvqIDNu+dhpot3dyHQ0m3Ic2rzGAdptxRbwDGdsJ
	 OVWQObltyMBUzr2NSc5Za1b7u5bOsuToh/gU4eC54R8VKovcvXzS9A86ZApxjuKtIiCA1
	 TdQxjNzgN++ChB08xDZscaUxcQggOeu02D5wnr3S/JwXrW4nAD4QfXv5qi0QHVSwnIA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795095223;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=epXrltEfHo4MbufDAY2YDsqYNkQYgQFruqSrEi7sAwo=;
	b=MxwFPC0vOvtiLuRwqL0Xfo76Cdv/ejo0DVKWHoJfndh1ByQuZoqe3bJMEKbxGtJJkDqb
	 VWRXxxHkrXkKIHkB5peWtAcGPEYEo89txD0kCOtUxmxQRwaIwGn07blbR/yKK2hsrWGkt
	 jZqEJ2L1FXmD6s3B95dXBTEGyYG5R9uyQEQLo+phtvXvS76LdNrkSZhnuUfDLvyfGrOid
	 QRoIyATqam4+itvuc0UubpoHseZ0nqGQ0+G1Nue1j2OlQZN25CeujnmgdnKf9c2nXVp40
	 YYcsuzWdFvjvcVfs5QBwrq+ffKrORNMmwCL3iISCY2+Y2CyVtF9UxSW+6n6Qj6TQshw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795095223;
	bh=epXrltEfHo4MbufDAY2YDsqYNkQYgQFruqSrEi7sAwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mR/p25WyPsmz/BM0s62PgtewACcMJgS2Scf4E7+PgGhaA9OLPz7q8mL6tL7ojiFjN
	 L37zswZRVDLNgtCuXhrSpum2eg5GOrFCr/FR674AlpJ91SjivNbJyl9KNo4fUSwRqd
	 0P2PZnwxzPF69kwt6Po5qtmnS1spCIHjud35cDYMLOUuBj0FS+kauZSXx1R+NlHv6I
	 LF59i6VTwvzYDOyowfWrSCZz6HazaU5EpZVlF5uCqV5Dpb5nuAOl0TbiCbC55399Mr
	 VwR4RZAGC1S65ihT8K8BuDj9Uy/361vya+v2zWVeYIDzyi+ufJrlVz6NgvrtI28uCG
	 BwGh3cCkCNSEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E14E140B1F;
	Thu, 19 Nov 2026 13:33:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A8FDB9F8
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:33:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8F7194052F
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:33:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5yxO25wlKbOZ for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 13:33:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8E16140527
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=k3F/8tfD
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8E16140527
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 13:33:30 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-490c3ae81d3so1499902f8f.2
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 05:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795095208; x=1795700008;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=epXrltEfHo4MbufDAY2YDsqYNkQYgQFruqSrEi7sAwo=;
 b=k3F/8tfDxN6YZEezsmECXDYzqV6mGAgdle1WKmHE0BhQq24ZLVwbw2jKp5VnlWTIyC
 u9HVplQMnscEsWWAJH2Y0fm3G/B9M+XKCGMPaeF7B8afH3stUkmisgNBKBtdAdHmbLHI
 GourdnSu9i9JTqkJhM0l85lrMw/sddYvREIylX5wulaU5fWemgu4fCDSzT6w4+VdXbHk
 WskyT1UTaKJo+i8UYa/EXYLimWQFQ9ZFxDMu7c0IrwzgNZwRCThsBadxvXesw8PwAmPs
 +Ny0Tc5hAMC6uwqPDo6bSzh7nrmPQJGIwRUamr62IWHEYUfVu8DyFzB69r9p2PvgnR+A
 bhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795095208; x=1795700008;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=epXrltEfHo4MbufDAY2YDsqYNkQYgQFruqSrEi7sAwo=;
 b=pl1/JCI/PuD0G6EUIN6c3r200YDjQ7+EswWi1xJpRvPC0MbnwHTOraxBUavfaFFfIG
 3Dg1UnhVO/w/aij28TJE926EQfz7/w61bSrHu/RDwSSGKdRj/J4bMWThukAWlAXd/0rY
 bG4bASdkffU6MpPwGTxqpxkfI4KKx48zrecYKxVWOrxisQ7c4C1YHZ9o1m6yMJqohQst
 i0RR4yf14/P8M2Pa4lbbskCy59rlYuc+wiRpOjTlACAy8gYG69dt5a2Cb6xtOjTjIBSL
 CEZNEd2jAxcWDXyNdGaetLkBlZb0JAvtQQLU1jyACoLVFbfE5CGGbomfbt4X6K83XywV
 5+sw==
X-Gm-Message-State: APuU4Z9JGSTrN7EP9tn//12USEE5A8TH+E0yg/T8NYladHOLhh2xwJ06
 BtnBZKuv8ktiJfgvDVeaACDYBF4mpMVw2AYucjkEU5pCAcvnt76w0HcgiM2CjQDI
X-Gm-Gg: AZFdTZep6Sqmr3o9FTT+ZDEoASsKRKOxMuUfNrS2gtV8Jt0XRPlArHvQERa3ev7vA8f
 gOH36OXj9eLM71pMEUeZpNl/1DZy8Kkq3tWdbzuJ9y3HqW/4kL33724zGFyRBJm/7YcErF0XvQe
 8AjHVHw3HJuz2UtVtDvw0U2DsxS3DL16ID6+iw4FpQkYZNcxmrrqDTUDb9ot4kkFYmGCsShk/FH
 xCTG+bPPAYdgb0x27iuXzdZylnLFBHGqTt4Jkw3I82ldQ3wFQbt/dVizUBuDgFXcH6xiv5ax3JC
 JH7CDiFOe3AuYX34SaTCPIO+h2m1ckEmSwHFda1ifiLvWpnSH/s0/KYWeKXEvu3vRBMM9H4AyF3
 98ooYSXpgLukQth1VCPcgpIF6PktHtTlhvefe6Oe/cu3dlJHkrzzkaASclIZS8iO06ifu1VGYHi
 sWRMPGP2WUFKIggctttCFRNTIQlNM9idvJBGpH9qQ9E57KPS0kSYEr9SqaTDuDvX8hUIJslnWoL
 TD+jc6a/3rRJVEjReHyDBFXZdzsmhcLnmGtvYn26jMfYV9Ls7UGhgyPfszexBJVEheqdfxCW6gm
 XHNEi6DaHmCR9XVrBpfH+CEqCk9XA4z/E6mZJ6fy22TlfbreKgn1Zn7eL8Xzeba8pzYodwKxPni
 YLpRVoBfxds2JqRrGU0/ghDdjlf6MHbTpN6byzZmcsBzBLGsy2xm4ePtkGJdznI8BHESogeBuI9
 7daRGjpEFYpRUdqSz1aiUK9pS4Z1BKbPGBCad31BHOSyOaZoATDjq6
X-Received: by 2002:a05:6000:4a17:b0:4a9:760f:1824 with SMTP id
 ffacd0b85a97d-4a9760f28c8mr3838896f8f.21.1795095208326; 
 Thu, 19 Nov 2026 05:33:28 -0800 (PST)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-0199-55e2-7041-f103.ipv6.o2.cz.
 [2a00:1028:8388:a84e:199:55e2:7041:f103])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c3a7sm11278889f8f.9.2026.11.19.05.33.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Nov 2026 05:33:27 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org, Bradley Morgan <bradley.morgan@linux.dev>
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Qiang Zhao <qiang.zhao@nxp.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 11/14] mtd: rawnand: fsl_elbc: Select NAND_ECC_BCH
Date: Thu, 19 Nov 2026 14:33:07 +0100
Message-ID: <20261119133310.22732-12-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261119133310.22732-1-pepe.schlehofer@gmail.com>
References: <20261119133310.22732-1-pepe.schlehofer@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The CZ.NIC Turris 1.x device tree asks the eLBC FCM NAND driver for
software BCH. Without CONFIG_NAND_ECC_BCH, nand_scan_tail() reaches
BUG() while probing the NAND chip and the board resets:

  BUG at drivers/mtd/nand/raw/nand_base.c:5074/nand_scan_tail()!

This broke with commit b182816c1fb4 ("turris_1x: Normalize Kconfig
usage"), which moved the board Kconfig defaults to the defconfigs.
NAND_ECC_BCH has no prompt, so a defconfig cannot set it.

Make NAND_FSL_ELBC_DT select NAND_ECC_BCH and NAND_ECC_BCH select BCH,
and drop the now redundant CONFIG_BCH=y from the turris_1x and
kmcoge5ne defconfigs. This comes after enabling LTO on the Turris 1.x,
without which the turris_1x_sdcard u-boot.bin does not fit into the
1 MiB its SPL loads from the card.

Tested on CZ.NIC Turris 1.1.

Fixes: b182816c1fb4 ("turris_1x: Normalize Kconfig usage")
Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Reviewed-by: Marek Mojík <marek.mojik@nic.cz>
Cc: Tom Rini <trini@konsulko.com>
Cc: Heiko Schocher <hs@nabladev.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Holger Brunck <holger.brunck@hitachienergy.com>
Cc: Priyanka Jain <priyanka.jain@nxp.com>
Cc: Marek Mojík <marek.mojik@nic.cz>
---
(no changes since v2)

Changes in v2:
- reword why this comes after enabling LTO
- move the note on BOARD_SIZE_CHECK to "configs: turris_1x: Enable LTO"

Only the two Turris 1.x defconfigs enable NAND_FSL_ELBC_DT, so the ECC
of no other board changes.
---
 configs/kmcoge5ne_defconfig        | 1 -
 configs/turris_1x_nor_defconfig    | 1 -
 configs/turris_1x_sdcard_defconfig | 1 -
 drivers/mtd/nand/raw/Kconfig       | 2 ++
 4 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/configs/kmcoge5ne_defconfig b/configs/kmcoge5ne_defconfig
index 69ef6cf3b9b..ef03f02d1e5 100644
--- a/configs/kmcoge5ne_defconfig
+++ b/configs/kmcoge5ne_defconfig
@@ -200,5 +200,4 @@ CONFIG_QE_UEC=y
 # CONFIG_PINCTRL_FULL is not set
 CONFIG_QE=y
 CONFIG_SYS_NS16550=y
-CONFIG_BCH=y
 CONFIG_POST=y
diff --git a/configs/turris_1x_nor_defconfig b/configs/turris_1x_nor_defconfig
index d8ce4aed4a7..35df37fbc70 100644
--- a/configs/turris_1x_nor_defconfig
+++ b/configs/turris_1x_nor_defconfig
@@ -119,5 +119,4 @@ CONFIG_USB_EHCI_FSL=y
 CONFIG_USB_STORAGE=y
 CONFIG_WDT=y
 CONFIG_WDT_MAX6370=y
-CONFIG_BCH=y
 # CONFIG_BINMAN_FDT is not set
diff --git a/configs/turris_1x_sdcard_defconfig b/configs/turris_1x_sdcard_defconfig
index 982a6cb0703..5e99d895b2f 100644
--- a/configs/turris_1x_sdcard_defconfig
+++ b/configs/turris_1x_sdcard_defconfig
@@ -151,4 +151,3 @@ CONFIG_USB_EHCI_FSL=y
 CONFIG_WDT=y
 CONFIG_WDT_MAX6370=y
 CONFIG_FAT_WRITE=y
-CONFIG_BCH=y
diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 6084b614358..b0ae441900b 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -240,6 +240,7 @@ config NAND_FSL_ELBC
 config NAND_FSL_ELBC_DT
 	bool "Support Freescale Enhanced Local Bus Controller FCM NAND driver (DT mode)"
 	depends on NAND_FSL_ELBC
+	select NAND_ECC_BCH
 
 config NAND_FSL_IFC
 	bool "Support Freescale Integrated Flash Controller NAND driver"
@@ -259,6 +260,7 @@ config NAND_KIRKWOOD
 
 config NAND_ECC_BCH
 	bool
+	select BCH
 
 config NAND_KMETER1
 	bool "Support KMETER1 NAND controller"
-- 
2.54.0 (Apple Git-157)

