Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE11CCA490
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 08:35:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9E94640A12;
	Sun, 18 Oct 2026 08:35:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mQmQF2emaFeH; Sun, 18 Oct 2026 08:35:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D0BB940A57
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792312552;
	b=kFzD6HEVsi0sQsw7+klFYA5f11f9dhV52wfBE8aKjrzDGfCD9uc1IZm9MoFiAzkfW/Mx
	 LIUc0jttnjbsZu4YcYwRJF4T7+YniG/VABiFieoTR8E1RuBxTiBiDiGSwleIiNDl3fYxL
	 oRxQWDWIjTt2Bv2T5i4rp1xL4TrouZZiUnQF+Q7wgnPdTkZEfrzBZ53/T1by1Of7OuK8K
	 fjRQpcQks6NuHEMpzthUJZeY3EavDy2FiIRfEYsaOcn69QVyXTLU6A1ki3W8ugvt8qCB9
	 rIauSbUSI+5upGtFlJ8alD3DSCRfc5xeZz6dAyrssfnIABRXpKGsjBW4jcimvsUw5WQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792312552;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=HC2ZBvajkqof28wg5lEXV5vUyuEkQorJpv7K5lkIKlA=;
	b=DE47l34ummP9RNFufipCsiV57RjHgtMI2Veh9toAS8nH3kMgqBu9PpWDbicTdYLJ3Ky8
	 nzAlbulXQlJYfVO56sM8U4NimPQpQ3k8nVJz5wfliNl97Jd2Eipkw5LxYou+OFFc557SG
	 ZDmX71502msXTxVBpXvHd/aLToFZEot9SXY2pWf++oClCS34NxGJkoytLOuxaAHEgD4Ny
	 ufmwOoq5v6tEW+atp6fB+wtLOePaGslHYCz9x3WrtF1jl3H8bo/9Iov1+W+ExA1EOi+1d
	 3IxssAKQAo/8zloUx26AQVjmrdhkcgSdlfkiJ7Wd9fnfsLH/NYARUqys2lFF52iVWxg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HJ5GDr13;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792312552;
	bh=HC2ZBvajkqof28wg5lEXV5vUyuEkQorJpv7K5lkIKlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oLyZtNM9Eqn81yjLBcyTT67FjPFwaCGOBeSPnO8QJ7lbxRRbFRpEfWQLz6a0wHPhq
	 iogDVtxcLB16X4IWo4bKvIkQrmXnOZQ/dzmZVmKChKwsgDybLOP1nZ9pVYXZrZwNi+
	 JLavrKVQ3++7yvSNj21UQN5FsIl3niyiol0LbE/7KuMeWjtsXO5BTmnXaktzESIUHB
	 jzQkTf5aqQhQd/lem2DPv5mDaU4KAXKjHiTrELf+L53Zn5a4euy7hBeQIAuoWFF+xY
	 9meU+Z2gt/+7AccExy4ided094oPr6g7zshMcp/uO9poY32B8rf28iS5W5OiaNfBwn
	 5i3FrG5o0Gd/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D0BB940A57;
	Sun, 18 Oct 2026 08:35:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CEC722A8
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 08:35:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BE19E40966
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 08:35:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tx0rAl9u2WlO for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 08:35:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C4C1C409BA
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792312537;
 b=QWiBMLKxF16EZxIwmudF8F+kTrx61uCWf2ymLk2bfOKrHiAb57W0H+9cWO55dHd8v4BM
 DIP4WjB6XoqMgF1MB5vR3qmZ/aT1OAqMner+5PxqBIInRaPUdlREB8fdXMVHVhvwn5WZH
 ce6rCBules2MU4Oe3FiQF10zanXOfrPP/dQk4gjq6dg360M5hb5h4oHiCQldQrYyvT6Te
 OGt2g0pyyCwhdHYGfA9QzRSpMcyh7ZOqIPKa6wIPpQGRvxOiJNIPKta5dxhUFTXY3s7m6
 CWfXVkhhAsKHR+OaWfN7Ck4TeyBaLGXn+LdTNrvbk99yJS/UCtOL2A6afJ4g4U4dcgg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792312537;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=HC2ZBvajkqof28wg5lEXV5vUyuEkQorJpv7K5lkIKlA=;
 b=ZW9W6j+DcJo2RIMhQM92sHzE2aQ+Xl4ULwI3cgUtJ0ziCXZv0Jy+nY6b6YmExONty2Pz
 g9X7evlkzo2udYU3sR1sGhjP4k1kn/so90ONHT6O/tYssDzgqHQy/jNq/kWV49I8sSJWO
 69iReoy/P/kDIXvtORyRtNhqehRRlvQC0J7kreUOurAosVOvqL8/5OZpv81Aa5AyDL8fS
 vmrDlUyfkrTLvBMBBQAnDFoRBd1SMkCjz+wHu6b5MTGwKd0OvzeCvEhIpmVTiE/EEyJIo
 8TF8aWllT0n7uTNasxhJIyMnG3vD/RD4HBa5ORqvywYFRy281Ng1oHtmTbVY7jANyHw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=HJ5GDr13; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=HJ5GDr13
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C4C1C409BA
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 08:35:36 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a1ddc7c9beso3554735e9.1
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 01:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792312534; x=1792917334;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HC2ZBvajkqof28wg5lEXV5vUyuEkQorJpv7K5lkIKlA=;
 b=HJ5GDr13OAdGnjrXG57wDLCuuntZzTGPYIVWAttxTzXFC+PBdOOqqUlJO/CLBzvmy4
 n9gkY1oehWyIJDHgytbzlKtxdSL/m2WpDepg0hHVinFDoWej7jgC78d6QDVp7nSv7vdp
 EEhRCxmjGS3F0A9QXQ7EmYlX0n9o+Lkv/+YZGW+7MKfmYhcBQFO8ogaCQFiYvBgebOg/
 mezmjt9sOUGXUQdM48ZOzmphY7exs/N6X7qmB0gfDBOghbqTTlD05YSAmJTOE7K5Vd1+
 qQs12pObpEfeNa+350nCjKzhJpBCJ+17Zr1DiHxS84EeOM45KtiJY6xMWdIXohs/ASk7
 fGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792312534; x=1792917334;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HC2ZBvajkqof28wg5lEXV5vUyuEkQorJpv7K5lkIKlA=;
 b=oONOzm89B79zm63Y0xXxng0cu6EaILzh+WmGquuTq03/l/DpVN+BvfLJymbr45acmq
 rK1d2rgbkPpzOfbBw9Fq/KSiZMJIJUdZwZVVfHvqFiV+8I/vZO1kk4QIp7jy1ckKeeQl
 Erpgzg1cOPdUIrx/vE4e/ouUVwgSB3LlwP/cznHj4QYvZ5gIURDqE6YkGROAs8N7I+tB
 BNV1oK/+8GkxHIFZ2IL4Fkvdvu5n/+bYWXWpoaqw6VqQHSwOBeSJujk+77JsXWPm5vZm
 yBO5Bxupw4VCeSIq7FnYnVStZqWwoOk7STccnlQKf+1sC2nJAN5bOsxt/YtCQcd5845G
 KaJQ==
X-Gm-Message-State: AFq9FYK/FkdAJaLIt2056DUJdL+Ekg+Z5Tj5PQkNobt8c+a4S5DvIURQ
 m5j2KpGdDB9PaTy2P7oEYPRROSplJ+td/qp0zaHPU413arE4zDxIeZSZu6Bdijp6
X-Gm-Gg: AYBFou05JnlURh8JjDaNeXt7wp+9KNiNsXYxqwytI3I7u5XUOLqQ/fSLY+HJuFXCNub
 uBxBPx9ZrdPIgUo8SY8gnEggF/NMQZ52Wr9qewguqNwJKV8sAwyrfoWIeU3Muu9ZegDdEkoJp3w
 lGiwuX1RswJfFnGi4Wg+I+h5DPzYF6jKy1P1l1XWUs418D7e0q5gpqP+9wn5C0Hz6JvlKsd48ou
 t048OjeO8MADi8eQ02wZoy/8LV5xSFYc6OTS6PawmL5uCR5uAgWpgXpZHoFmmNeS1MHujOzhC4s
 WMzXeC3FwLxGv9cMVrvusiEkBt3QDyIDq7qypAvG6vIqUTY0SXsPaOsBGG75haznN6k8VokxFQq
 Ek7y2izeGVYt+Z4o+L8gImNIf7CcPTldTe/rOpvhDdon4ddJfZ3hwgi/JvHViJiEE0o1zfv6LDp
 zlBx47mEyiz3pZkOpMdx/J7lVTbe3/uUz3xVhcgRGv8zIPYAoBbm5MSVbnTb0PKrDo2nJwjVPew
 tubXuuqP0IWtWYJy5ClNay2N5XwjszL/ccOeyLXYMDpDsPBdBop21fDx9Sqt6Ld+Qq2Qm8ToHaE
 Y5rFUuJbaBhGjZWsVlcY5sQlzUWpTGPtlJESA5mOHE5i1iMlREXptUZSYFIuqiPV6G7tUG+1d+w
 XcLhiy/REOxHGjYovDVJafkg=
X-Received: by 2002:a05:600c:3d90:b0:4a1:df30:bf1e with SMTP id
 5b1f17b1804b1-4a1df30c068mr64876785e9.2.1792312534476; 
 Sun, 18 Oct 2026 01:35:34 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-318a-f58b-5e43-a2b9.ipv6.o2.cz.
 [2a00:1028:8388:a84e:318a:f58b:5e43:a2b9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1e3ebb3aasm43589595e9.0.2026.10.18.01.35.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Oct 2026 01:35:33 -0700 (PDT)
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
Subject: [PATCH v2 10/14] configs: turris_1x: Enable LTO
Date: Sun, 18 Oct 2026 10:35:12 +0200
Message-ID: <20261018083516.49229-11-pepe.schlehofer@gmail.com>
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

Enable LTO in both Turris 1.x builds. The NOR build needs the space for
the ubi command next to the BCH code. The SD card build needs it even
without the BCH code: with Debian's GCC 14.2, its u-boot.bin, device
tree included, is 1049419 bytes, more than the 1 MiB
(CFG_SYS_MMC_U_BOOT_SIZE) that its SPL loads from the card. With LTO,
it is 984523 bytes.

Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Reviewed-by: Marek Mojík <marek.mojik@nic.cz>
Cc: Marek Mojík <marek.mojik@nic.cz>
---
Changes in v2:
- give the size of the SD card build, which is too large already
  without the BCH code

The Reviewed-by of v1 is kept: the diff is the same, only the commit
message changed.

The build does not catch an SD card image that is too large: here
BOARD_SIZE_CHECK covers only u-boot-nodtb.bin, while the SPL loads
u-boot.bin, device tree included. That is left for a follow-up.
---
 configs/turris_1x_nor_defconfig    | 1 +
 configs/turris_1x_sdcard_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/turris_1x_nor_defconfig b/configs/turris_1x_nor_defconfig
index 070428ae25e..d8ce4aed4a7 100644
--- a/configs/turris_1x_nor_defconfig
+++ b/configs/turris_1x_nor_defconfig
@@ -19,6 +19,7 @@ CONFIG_PCIE1=y
 CONFIG_PCIE2=y
 CONFIG_PCIE3=y
 CONFIG_OPTIMIZE_INLINING=y
+CONFIG_LTO=y
 CONFIG_ENV_VARS_UBOOT_CONFIG=y
 CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=786432
diff --git a/configs/turris_1x_sdcard_defconfig b/configs/turris_1x_sdcard_defconfig
index dbeb34dacfb..982a6cb0703 100644
--- a/configs/turris_1x_sdcard_defconfig
+++ b/configs/turris_1x_sdcard_defconfig
@@ -29,6 +29,7 @@ CONFIG_OF_BOARD_FIXUP=y
 CONFIG_PCIE1=y
 CONFIG_PCIE2=y
 CONFIG_PCIE3=y
+CONFIG_LTO=y
 CONFIG_HAS_BOARD_SIZE_LIMIT=y
 CONFIG_BOARD_SIZE_LIMIT=1048576
 CONFIG_MP=y
-- 
2.54.0 (Apple Git-157)

