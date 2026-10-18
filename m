Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC114CCA490
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 08:35:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 89F8C40A60;
	Sun, 18 Oct 2026 08:35:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lJsnDReyOZMo; Sun, 18 Oct 2026 08:35:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B2DEF40A7E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792312554;
	b=WDEJvtozHt3gZJPMdo8c08qqhNHY7yy2klji+sOlMCTAntiEGjSsfiK9KFalnDxQeG1T
	 YVijb4cI2REHE754OhPnM0ZOS0UtRX9HeNiMkzcQrjFADA68o+EFaBKNtOs1iZI1YUMzq
	 BBXhwpa+DYLFsirvXxHeRqT+AFhqgK4/Ef7oexeGupQfRhTlK9s/q/rPqQCzjXAcVRPiX
	 4jvMJxG0eUqwFfi+dutDw9ghH0nAHXAkcYpxyCDmGlvrNZXOpKPY7iHcWTbDNI6txbteS
	 QukHWpfh7tBxMeW0OdQ5PvQ+aHoR+xB/f+xfWRDATqg5HYW/qt90KLISU9KYJTM5Fnw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792312554;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cFsJ2ZM7H5Wh+dh9ytqyCafUL0TBjqbgXtQoDOiZtTE=;
	b=iq+9OFWQLx9TQZdNbazs4nWrK3c76d0lQbodllJYuh0IiHMsQ83t7TXCrOfl5NkWMibx
	 6lAxoeYtEGxPMC2Gix6jJNeOxh3QVv8zyEy7KNdbmLEtC4yHlihwcRt4fLNCGHF95Qowm
	 V8CtXSzoewwAd8p8UVi0C+Qa/Gx+cjH4O5xooLcLP2RfXBHuMcr/QcdetzxxCSGTgnr/b
	 gZqUc5ZIlWNUoVPAoZAD8ywxkU9gZiiM6qG6JgNPtRvK65SIi797Ls9t7ZTiTo5ghiZYX
	 6elO0xhj9G0VmsnlwIAml5hvySFOe/ZyBpJzekX993ioL/eF3Bffl8CNb6zN5f0Bf0w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792312554;
	bh=cFsJ2ZM7H5Wh+dh9ytqyCafUL0TBjqbgXtQoDOiZtTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XJHEZHGSb+L3Wx9HqIBbjXD2EtmEZXk15rmkKxLi7gBmJh0oP5lxTEP+W/JuLOLvs
	 2l7SdIZAuM7TgTPZFors8lK2PGxy2nq4MH1ylz5MwVURdgofmHkBKPBCWyxV6caaIo
	 gXULah3rhD7Q7bLjyvijnwW3FjON9dCIesTmm5nsDesylia+HOep345yibhMIGsWdk
	 9FrMBtgmd69knRE27VShS5fHp9N8LFmX18rOtyjz4+besHUEu56qkNZdXKRlvZCQap
	 6V52f6UDgeNRrTwTSjbyiHc088TANfRd1MKiqnFIrTinyqKQa7OWKhkq1DQW5J3Ckr
	 hKab2/YyhQrVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B2DEF40A7E;
	Sun, 18 Oct 2026 08:35:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 351B375
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 08:35:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 15BF4400DB
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 08:35:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rj1whesM0jgn for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 08:35:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 22FDC4008E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792312538;
 b=cibHGWFVhBXVoP9DbHvlxL2BKUAPOoAxrCbhv1KBw0xdZoEJtbr6fGWpMQiP1+y0cQfr
 F1rWnOPRg9yELCa9RZzWCdXJNhauOuzi3XJYxeOuZBUwlnK0MAVaLBLop1JXnRXD73Vye
 a3nXRrpVIQdMzNhX5wK5LXhTXsegQSDZWHPPV/WteBxwd+lots5kiZxBBnvVj6UbcVPmW
 1vBneEI90R+lFsAJu3FvfrQB6ute6goGom/kPk21D11MNj5dXeWNRANLrG+mvVyiMg4wN
 ax9IIYtkRA8JsIO/gnN3uTtqENWFzp5dmH/UWLGTvtVLpFnRDgJt9PyqDizBIR7a+cQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792312538;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=cFsJ2ZM7H5Wh+dh9ytqyCafUL0TBjqbgXtQoDOiZtTE=;
 b=ZeMFGMMJ4ZNZrTJOAxbT8HcPy0XGjNadiDB1BdjzMD1YeLUiOdFPFqxmXw0qYnbUC/QD
 TyMb8Ibe1WeGdi1xUF9H9jTOKMZP8XmeL2qXXwAzWR8PJeG3RnFd0lxypveRKEE8Ps+li
 eMttW3FQLVF5x0jh67GFQxw98eDpX0viplkVTQPVSaH3tAV3f0uj1i7vfeyBM5p+aiLqX
 fyaUvO5hFDZ8Pat05+udSx6Kw+nUBLtAuf9c6mlwnOZ8eVi4ejm1mkZyI1eFLaSEQOp3V
 ftZ8K0lyl+hX5L2zrixmYciqNwD3G8+fWR20jwS9uxprRf3GNId5w5tzJIeGBocrexg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=tAws92+y; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=tAws92+y
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 22FDC4008E
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 08:35:37 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a1e3098ee2so2623545e9.3
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 01:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792312536; x=1792917336;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cFsJ2ZM7H5Wh+dh9ytqyCafUL0TBjqbgXtQoDOiZtTE=;
 b=tAws92+y4BkFSHJqh5QouCjfRDRanFf2Bs74OmoDkqScZHUIJMTCcsc5Bz1cpI8PMV
 ixQMp4mbxlwRImvIwhjcRm72FPKkEARDq371ov2Lo+6ca6HXQtq0X5xBgqLSvBcIfO3W
 kA+YB07W6Ib/GTYgOQi9Y09DzINiC59F8CYPY7doeTDPp1bVt5oJzLsr3rx7+W2pL5Ib
 h29w81ghk+A9ypKuLLbhhhq9rvJSx4HVcAzFmC42j7kx9D1hh0X7+2F88v5ijDMvUHeC
 y/sgq52aej+UxO1mMguhIfQEdcFewsSw9YBKvFE3oQadvkwXqF5f2swo1DuN8XRCLyXl
 0ddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792312536; x=1792917336;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cFsJ2ZM7H5Wh+dh9ytqyCafUL0TBjqbgXtQoDOiZtTE=;
 b=Wo8C6v4gPWtkLIMWQ9qpyXWEVq6+6+P/sHmMwhpYQ+vGC9ehw2Rd3X+/a66J2UqQUg
 AOLYA4A9znKe3op4JbzTeODBZqeb+eETZ/UnW6dQUQkR6WTZtBUQGskOIR275B7ZqP8E
 XNcEry985fdUGLChqnajZcdjR5bTqSLkel3RZVTOcCREe75EfXhu2ah46XCfG6Aufuz3
 kJKZcTWygFJIVAbKU1iU8/dVYywLbeDNGWvreZ2gpkAtChfx0fGBANaRvrEDIH+tNvii
 KeJ5Ng3wKnyX6BBJvYsVe0sjeDZgmC30E9jWFRbgsY+7fCmoQql05PJWP1T4Z0TZSldL
 HLhg==
X-Gm-Message-State: AFq9FYKyoLoFqZtqKbn6hEXX8AzPC6vfPOWPgNG47RMu9hcrjjoXlTqv
 54tjlMsKlbr2F9lLukAZwty+ZUKzLpigMR3fJ+34yqDayD69qhXkdJefAkmsB7iH
X-Gm-Gg: AYBFou0MEbVMm/VPTySliTrYGrwaz1pgr8bBd/uq7dLpcLa/eYyY50KuBnrrL1rEDKw
 bvmvb61uETLzY0nydyKtTxSPFXhd6BSTH7ZL+HzHs4IgbHDYwpK39DxGsElIDzKSllhdOrv253N
 fCeI9n1hbZPogjoLe3ul+tPtbGJruV1XoMcJKFK7RVdoEgBeMpisTyA/vtv6N2HaiuuY6VFNdED
 CpbqkBS+K0IclIDVWag8KFg8UwJu9QNBLOCku3ygcxWkLUXdxiMtrtmh0ViiIyJ4KvFa1lC4XYJ
 OGLmvEzBKHw2S4pQQT071LlHe8ZNZFcvjqGH224+LphQiprM3B7lsCchMwNQpeWUzLkKXQy76MX
 YCMeeEmtC3jv6QwhXbzEn4t3Wm8NIEmDVPpviQKWYMf2W9gecRL3a6RMRMo4WbeEgT0GyhDXFjI
 KVQtNyuNu30proGTrO+El1dRw1QqV0GCHwj86HN0ydmdKN9NsroCntL6mpgaE4Ckc9+m/+KkD/3
 YA0RaJrDOV7fR8SBI8sy3rON9YpBspKv7mljeGpKrKpwcNm9cH9+0H4uUhlCrA7ywlHk5DUT6RH
 HPWGHS/7qfzK+6cgRFJhAsbbmpIR8YPLu4uzgISuxy2NN3p6GTO97vlkV3KvoBvNbGDiTWHgpOk
 eT/ieML0QxPyJ8JM0gGZS3Do=
X-Received: by 2002:a05:600c:8b6f:b0:4a1:cef3:fb3a with SMTP id
 5b1f17b1804b1-4a1d75f23e2mr78624875e9.9.1792312535542; 
 Sun, 18 Oct 2026 01:35:35 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-318a-f58b-5e43-a2b9.ipv6.o2.cz.
 [2a00:1028:8388:a84e:318a:f58b:5e43:a2b9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1e3ebb3aasm43589595e9.0.2026.10.18.01.35.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Oct 2026 01:35:35 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Qiang Zhao <qiang.zhao@nxp.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Christophe Leroy <chleroy@kernel.org>, Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 11/14] mtd: rawnand: fsl_elbc: Select NAND_ECC_BCH
Date: Sun, 18 Oct 2026 10:35:13 +0200
Message-ID: <20261018083516.49229-12-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261018083516.49229-1-pepe.schlehofer@gmail.com>
References: <20261018083516.49229-1-pepe.schlehofer@gmail.com>
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
Changes in v2:
- reword why this comes after enabling LTO
- move the note on BOARD_SIZE_CHECK to "configs: turris_1x: Enable LTO"

The Reviewed-by of v1 is kept: the diff is the same, only the commit
message changed.

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

