Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B808ECCA490
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 08:35:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 776AC40AA9;
	Sun, 18 Oct 2026 08:35:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BBoOwIeFN1q8; Sun, 18 Oct 2026 08:35:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 94A3F40AC3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792312558;
	b=XY17qgYIfxjftqkh9qukhqQN/QAajhAQ2pv8wy8ZwkFVptvwZes4OaZVQ1HKRxTqEodM
	 u1TkrRSa5neORVASfXlMXox6XqHDTs4LLGhVkt7vy5Ixp2qHfivbQRk0lpv/o8kk++2h1
	 hCFn7W9Sy01bP+ftFrYvSkylKoCgeqC5dj3KzxUE8zp/mTvPC0OwhUTe5STh0Rqy/asvm
	 eX56PDZ0seJRVaXeLuI3op7SsKDAbnrInZo3s2SHu5gB7O/jo91pFkI+rb3twsRAE1E1Z
	 5i/HC3KXGfkHn1f/zla9Yz0/IUXGkCl2dFDkyChwAjyr23oobR+TcyC3lAzUW7ejqiQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792312558;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=3Q12fxqQCPrmG5sMb2IycoQRH7xhkG8AqmCDqosJq4E=;
	b=oUd/e4ASIBR5o/XfPgNKm/iU8u2Nf2PzRM7bTadV2Pe2RMoJvbiQlPM3qLa1+rMIX4Nt
	 T/ce7kHAVhVKRVZrXpI7VBpAYMxCHz57HzhRyPMt+l52zSZBmL7wbBHQZUkiuwupyouJz
	 neIJSw3jHuVfEeduZjwlK0jEIvjTvotK5bbhlSM765sowIE+VAhdA5Lm0+6VDmCOjCDMt
	 9jxCozzH1LN3a5GHF0kBskPRlByjCahyNmyK4B3wwErOHim+Xp6EI+V1qLmcMnKXoySvI
	 Qm98ut/phxKciSsipAj9gHiGUOTG6aYSxBRp/+k29ZFU4OOjWbfTC98eaxillxdaujA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792312558;
	bh=3Q12fxqQCPrmG5sMb2IycoQRH7xhkG8AqmCDqosJq4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P6frCYM4HHlGlUgoDK20u4+Td21zz5jZZmNe1zSsStSGjeaCGyutcxFdjTwj9jch9
	 tt7AOq2RuFda9IBt3GcyqbwxTaSAhmsivzfTdnzEiTAbGzT8n7S+cpiR+CNX8enHcn
	 H2LmAPVk0BnUTziTanyn580O2x3Xyiitt9k87yD/yoePyaCZf06Y8qh4Dpk8DYec2L
	 kWveM6K1G+u5ixqnQ8kUBFqEpBV388czdwXyCQy04w8KwmJ6ebnww6yi0q+Q1/Qjbv
	 /PVA+/V7T+3sga/jVO6k4760/HZs1nQqj3un/ZzlheN4rmqTwFHz9nWl7wHCmzhmwX
	 5wuW9lzSfTc2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 94A3F40AC3;
	Sun, 18 Oct 2026 08:35:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6DDB8263
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 08:35:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 53B676072A
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 08:35:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ldSXGhRHN5Jg for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 08:35:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 58F9A6068A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792312540;
 b=k9Sx6gFkLk8K+3zeeGYsyP4b7qZ93qZJ8AJdLjL529AHecqxR5GjBQ4nWhSLSKUgvBSW
 ecKvhwzQ4f5BI6hiG1US6+g4Uppdmi6cHGEkIzJmAj7YUTiE9lG/6ufiuCkTGI8vgkilw
 pCwtFeJ6SVDF+a/a3pZgt/h7SO8sDlxlPhYXFtp6xPg4wi9AhSAdyimL9Ge+8eQVsgnpu
 IM8a3BR9/TmhihXDpy0kzdf5d+RZREubDwwlpG0aWSBtruzMninfYneFPZnJCRs5zVqGN
 Nh7O4yW6ptgYNB11dPwNhrgMaKoB+hdJRJib4iR3sl7e5DnGoi7XfbHSkLeFgFoDd9A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792312540;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=3Q12fxqQCPrmG5sMb2IycoQRH7xhkG8AqmCDqosJq4E=;
 b=ER+NTDjgH/sxU+zWUaOdTf21b4lQBnekIdbejvVjYoMYATIcb/b1MeLpohlr3szmkM1x
 P2ywqgl4g84K0hkwl/WiCivKCvyIDc4kOe5oweeLqguXCYZ5lgqNk9ZLoWqM3DLTx9Hu8
 kXWTKnCy7eSOlw1mX4n+ZVmMCh1Sez/eUr51SdTscDBV0Ts+BfsIkA5ftQBX4Pmu9eVUh
 64VGJA8cFM3wkojFau0EstSwAljuDXvDyEtYzsA045soIA0mwmUMmCksHVXCzoiedbkGf
 JOu47FST2tbNVtJmJQljQjZ9Cf3TQrlZPSJCB80tZVlyaMOu4pdEz7Ut8dVoqKN1EWg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=HPOdXOeE; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=HPOdXOeE
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 58F9A6068A
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 08:35:39 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-49e73611928so13058345e9.1
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 01:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792312538; x=1792917338;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3Q12fxqQCPrmG5sMb2IycoQRH7xhkG8AqmCDqosJq4E=;
 b=HPOdXOeEKehtLifliGrUDTIgYTi1wPYZwZR645S4Wt1msCyKYa+Yj/xYDLjgA9+MIn
 17zmZJa/C1sImNZnrBuqb7qjcbGBxILL6e4b5L8r7gJZaVox1Y3Vmqiq/opvqiRwre6T
 Qz8YLKEvdWM4ElWKhdlA13AzJxUbmHfUgcMjF3+EdPZqF9sum5Cy9bf9fMGe41ksCMGK
 TjB98Hlf7jB2cqwVNlz4QP6+n6A/pfvqkeu9ToxvO2eOAKt0btN4aPClgfhO0xj49Gp5
 CAF16sgYLfBLKhhie000gpE4fnnmnePnCyiVbQfuRVu0sNCv+rSeGw+t3JFTAdBggfiv
 6y4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792312538; x=1792917338;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3Q12fxqQCPrmG5sMb2IycoQRH7xhkG8AqmCDqosJq4E=;
 b=h+LHRaIqbGfUZSelBvvx6Fu1QANTz6pbox5IY3vMi6ZNMi0zQYFDXOXQOPi6U6AuFT
 G/pwS+rjFmxPrVU2TBK8QKxkdQekRDz6ixSbLg6DXBaDKqK1J62F5L2T7j12phNCTa0m
 3swDEMaH7vtSBLHOvBVKKQyUglDOf+GUlwJMeDwc0YkvOzukClkDUcjc191RZ+grMpXU
 V1YtI+kVtLkrkMzzFMNZei70HqS+hNQKtvj5xZ21boi0dKjdnb4srKECQIFICIQsyKKH
 Eo7yijVSM841YSlByNgouN/eA6eAhdXiaWNB2yUbGpoYXWm3Udrv4VzCfaLhzHoKRwZB
 GLXQ==
X-Gm-Message-State: AFq9FYImGoDBYJRxW00Nccts3MjphLYeBu/R0ehiHIIav7oqpQAqkPzR
 /pV4TSYk+xY/qVyGd6BoPlAjh9zmhdlDexRZO9YsFinBjW7YK0mJ85yhCRNqsL8P
X-Gm-Gg: AYBFou3W/Gun8E9xUVlv+b/BM1da9+MkGf4Tsd1fxBMksmS1XrTL2uX8P/q+Hx+WWxq
 ASbuSnNfHq5MGipoxEACuoGnxjzf9t0iYcjCa2OK1rdJHbScyEVnhaRiMeH2KVTnIiwQHRkpoaJ
 aiW32UBfzFfW2iG756xaYS896DZo9BCb+kzZaMi9SoSkF99FoZiEjiOS+hRb8p5F739FpBADQTK
 IuEJCWjXZqGS9jyCJMIMkrDjOv+bYwXXqAfRsT1anHn4xGmKJAFkEy4blB/S8AuFpYB3s5efuG3
 OuvLuvePeFRjAxSY5Awxo0z2SeJruyBKzXaTPPw2/Bj2ZKChPKatvrRocVU+uI8bhIzLJSAuMku
 sfpBEtUbrirBa7Odw2SBm3E3XFQm6cE8ZXq52WeOO3DkoBXAlBxJ4mw2BtzBn9PDKR5BL3FNuPx
 Og2YCVRQcEJ+qV/3wJAHH4rUo5jOTAAsyowaGROfk3rvGdvutBP9eZkOnTbbVD7fQ16p9eXDkbA
 jh0NkzXHzuoZb9wZxjpW2O2jXOCT9/p0IpJZalWY+V1vxvqGwOvA/LOHjJvHqpYJuPVW86ddGEk
 cKOe61XFpXG08A/3LIhwdPKR+q/RBqQ8Tqu0Cby77Yp/z/iNqoCmP0YOs+2TrEHpkfejXC3cqwf
 2zKwe6CmapriG7e0Q06L6a+Y=
X-Received: by 2002:a05:600c:3551:b0:49e:6581:7baf with SMTP id
 5b1f17b1804b1-4a1d75a4653mr98581415e9.2.1792312537637; 
 Sun, 18 Oct 2026 01:35:37 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-318a-f58b-5e43-a2b9.ipv6.o2.cz.
 [2a00:1028:8388:a84e:318a:f58b:5e43:a2b9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1e3ebb3aasm43589595e9.0.2026.10.18.01.35.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Oct 2026 01:35:37 -0700 (PDT)
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
Subject: [PATCH v2 13/14] configs: turris_1x_nor: Enable CMD_UBI,
 drop NVMe and SCSI
Date: Sun, 18 Oct 2026 10:35:15 +0200
Message-ID: <20261018083516.49229-14-pepe.schlehofer@gmail.com>
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

Enable CMD_UBI so that the NOR build can boot a kernel from a UBI volume
on the NAND. CMD_UBIFS, which defaults to y with it, stays off. A kernel
inside a UBIFS volume would need it.

Even with LTO, the ubi command does not fit into the 768 KiB NOR image
next to NVMe and SCSI, so drop those from the NOR build. The SD card
build keeps both boot targets.

Tested on CZ.NIC Turris 1.1: with the MAX6370 watchdog stopped first,
the NOR build read the OpenWrt kernel from its UBI volume on the NAND
and booted OpenWrt.

Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Reviewed-by: Marek Mojík <marek.mojik@nic.cz>
Cc: Marek Mojík <marek.mojik@nic.cz>
---
(no changes since v1)

The default environment does not call ubi. The boot above used:

  setenv bootargs ubi.mtd=nand_ubi,2048 rootwait console=ttyS0,115200
  wdt dev watchdog@2; wdt stop
  ubi part rootfs 2048; ubi read $kernel_addr_r kernel
  bootm $kernel_addr_r
---
 configs/turris_1x_nor_defconfig | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/configs/turris_1x_nor_defconfig b/configs/turris_1x_nor_defconfig
index 35df37fbc70..c5aaf55a75c 100644
--- a/configs/turris_1x_nor_defconfig
+++ b/configs/turris_1x_nor_defconfig
@@ -55,6 +55,8 @@ CONFIG_CMD_EXT4=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_CMD_FS_UUID=y
+CONFIG_CMD_UBI=y
+# CONFIG_CMD_UBIFS is not set
 CONFIG_OF_CONTROL=y
 CONFIG_OF_INITIAL_DTB_READONLY=y
 CONFIG_ENV_OVERWRITE=y
@@ -63,9 +65,6 @@ CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="eth2"
 # CONFIG_DM_DEVICE_REMOVE is not set
-CONFIG_AHCI=y
-CONFIG_SCSI_AHCI=y
-CONFIG_AHCI_PCI=y
 CONFIG_LBA48=y
 CONFIG_SYS_64BIT_LBA=y
 CONFIG_DDR_CLK_FREQ=66666666
@@ -101,14 +100,11 @@ CONFIG_SYS_MAX_FLASH_SECT=128
 CONFIG_MTD_RAW_NAND=y
 CONFIG_NAND_FSL_ELBC=y
 CONFIG_NAND_FSL_ELBC_DT=y
-CONFIG_MTD_UBI=y
 CONFIG_DM_MDIO=y
 CONFIG_MII=y
 CONFIG_TSEC_ENET=y
 CONFIG_PHY_FIXED=y
-CONFIG_NVME_PCI=y
 CONFIG_PCIE_FSL=y
-CONFIG_SCSI=y
 CONFIG_SPECIFY_CONSOLE_INDEX=y
 CONFIG_DM_SERIAL=y
 CONFIG_SYS_NS16550=y
-- 
2.54.0 (Apple Git-157)

