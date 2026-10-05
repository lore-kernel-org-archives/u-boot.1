Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A8E3CA5FF0
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 11:56:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 82B7E40609;
	Mon,  5 Oct 2026 11:56:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TlEoyhWP6zke; Mon,  5 Oct 2026 11:56:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8C8DC40552
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791201366;
	b=tWzk0rkZAKxMnGS0knaf5R50VA7Fm9z5LLxKwxDZbfQ8VM/6Sxqhx9cRGUzrBHtdMQhH
	 ODKkl+vDgqIsmzTLSp2cGSfkNWK2HKzPD+1Da+EsFAFypuYKEhSJigJv8vTTbe06Qn97W
	 IyNM+s+cLleftJjTrPWQsRPxsquWIKB4VG/wCd9VulZxRH1BrGPZp/PCO0fltTmfC94wQ
	 8JvyakXFiZhBtugOUwpf0WwyFTvglIcULG2S2oLHEetlisg5zfNhFj7BeVZv7OEZHdZL4
	 9Qmqbwp93eki/oNwC1XnvTKniMcPV359mKTc4uDdHsXl+UdqV/R+G8Usxgj3X4v7biQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791201366;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3M3+wLNh/61AJsDgIAGoHg+92Zgolkr0Q55DbUOZb90=;
	b=I37rA2Gm3LCob0k3djJYKidFB0xtYk/ufzd1q7QCvu/wpaYbjM1/Sza9zDdAbnW+4wzO
	 uxsDO7ri2AOrrPUt4pPPpC74G3L8OKZNog+AFL+0EuFNts2BRV5l8l/TBv4JVXUigmaBW
	 NkP9R9Oiefv2ZdK1sULpWrxNVKL52xUnZ61h5e29UFLeWQI3IiZNXxlHDSbm/ZaE8SnGm
	 rN8/u0g6q2XhxRSPnigN0K14NbEvJl/knthFZAygJprz8N3vp6dptp+ntAte2FeuP0c0o
	 TqocP1sjooYinlABlixTfLp5ZVRRnn6KwNb7L7SnIF7F+EbV2ZYHopuJ01JOCG+7IEA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791201366;
	bh=3M3+wLNh/61AJsDgIAGoHg+92Zgolkr0Q55DbUOZb90=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hkTnLVTv19tUEeXg7+RsleGZS5nW9OxI68hmR4zZjzOqb5NvzVq4soqLmaRha8FKO
	 HYJZOgbAn4yJXAgD6UBuiMZrSNsJdCyzVFE/IDRJ2iLkqwBqZjmBzG5zuhWUVJ3HhZ
	 iqAfzfZU6N9j0hDx4PK0vHO+QUatUwnqiZG+Q/4SD06pX3Y4EMb4NVOyds4D8ZhJty
	 bY9AJdq25m9krF9lx+VrJgPQCc7A3jO4IcMqSGc+6D1FfYm6Qivf3TOFzCZZo8esmh
	 3bVpTgCejWSomc6zFe9xfkQ851nP6x+qindNlVbOrGNT32Onyh0W8M2p4VPkF7RwHw
	 mW+8LQrHoe2Lg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8C8DC40552;
	Mon,  5 Oct 2026 11:56:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 00A9134E
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:51:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D45A660613
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:51:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iumNnmGvwoD1 for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 11:51:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6464D605DE
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791201069;
 b=cKrnUu0IB7DvZ2fMyOaQ+xbZmuypjCDkBWHnkQ3HtR6RDCy8XAV7OUeclXwvAufl0tt6
 b7RBkCaIljwmahFtQuCYAWsHi0riVTctuCHRnKlIof0RCBROZP+wIWaNS5iopmne9kjAO
 jps9h1upOl+rn0NcbGJ7C/36UnYwp4Fm/nrhtT6meGVnSiM8mB6mJvS7gr81OsSHHJUey
 XMvSIPAXo6ru8lF2+H3SDbKJaoLcCB+QT7C8r7kLZ59e2S/XLSWqFpggyakGWVjEEWeuC
 vcsX2dwcGLz9Po/J4GKLMs6qdDQLJXEXhKmcqhZK9CYQ2pVanJx4sxZ+19g5nrZMuRg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791201069;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:Content-Type:MIME-Version:Content-Transfer-Encoding:
 X-MBO-RS-META:X-MBO-RS-ID;
 bh=3M3+wLNh/61AJsDgIAGoHg+92Zgolkr0Q55DbUOZb90=;
 b=VdhD+LbXGtJxr6FJWleJvaLvy4+GL4BUKsAnoU5ZmvFXMhixWUO0292F3Noidhl7NJRt
 SNEcZcRUt8CRHNFUFKtAueEXSY2KH8/jGpKUxig0FLDNeJeIUOaj7UC9pXxIyAY426knx
 L6F0WbNCeyUhhh5F7gxa7qx1Uy/HTaZH4xSzqjLmN2EhQriRmKF8Xts8bka8SWym2Zsuq
 tJyZKEedHb38NlMyRa33TdAYa1tqkothP1yNxlj6iij/WbOXm7oiItVfNJdRlYI00+956
 YwiWTZDGtV8Yau4ztKc/7RsKKmnJdK8oHMzf9f/IKXHVAKkh95jrKcSSaBbb2XwtxtQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=NoNKhQqK; 
 arc=none smtp.remote-ip=80.241.56.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=stefan.roese@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=NoNKhQqK
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6464D605DE
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:51:06 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hyyQH1WQSzMlJy;
 Mon, 05 Oct 2026 13:51:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1791201063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3M3+wLNh/61AJsDgIAGoHg+92Zgolkr0Q55DbUOZb90=;
 b=NoNKhQqK5ze0xG0a++Mm67ppUcgxywNmpWby47wG9qMXXFYao3BpEY1HMk0DKGbDoeursE
 hjMDzBimASh2tIdaEbQ7ajSfO+ztq9AMwPSIadSQRulCXGbAIl0nA2EnoCT+/z0r5yTnEe
 tdcG0bqXVRYyI4FhyQ0loKDWCtpgBUK0RkXu5wEtARri5qT0rpKewM55fWvOVKH9cmMaA/
 EKDXz4oxBxcOVcF07pCf22H0KAzMY/8daiHhY6QTwIRLxiMcsKe0lWfc09hptVmpnxJncv
 tYvNMqBvGTZBZmK+MsofqhRRh8s2jsAVy0xHCJFozzdbGE0dMfa1uHEUkbgxCw==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
Subject: Please pull u-boot-marvell/next
Date: Mon,  5 Oct 2026 13:50:57 +0200
Message-ID: <20261005115102.747237-1-stefan.roese@mailbox.org>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 1h7hshb6pb6wrx4r4mgsjzrigckns43y
X-MBO-RS-ID: e1c61e80ff628df7fda
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

Hi Tom,

please pull the following marvell changes for the next branch:

- lmb: enable LMB_LIMIT_DMA_BELOW_RAM_TOP for ARCH_MVEBU (Bruno)
- ddr: Fix the SPD EEPROM dependency for Armada XP (Pengpeng)
- arm: mvebu: turris_omnia: Enable the `mmc reg` subcommand (Marek)
- arm: mvebu: helios4_defconfig: enable the RTC (Igor)
- arm: kirkwood: remove obsolete configs for Zyxel NSA325 board (Tony)
- arm: mvebu: helios4_defconfig: enable device tree overlays (Igor)
- MAINTAINERS: Add missing file entries for some boards (Tony)

CI (GitLab world build) is passing:
https://git.u-boot-project.org/u-boot/custodians/u-boot-marvell/-/pipelines/1455

Thanks,
Stefan

The following changes since commit bd2f5794b7e24c62042abb1921f9c2039b920e02:

  Merge patch series "Add support to auto-probe Torrent PHY driver for J7200" (2026-10-02 16:27:16 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-marvell.git tags/u-boot-marvell-next-20261005

for you to fetch changes up to 62ce0b812da1492c0c63f8c377301d3c4dae6dfa:

  MAINTAINERS: Add missing file entries for some boards (2026-10-05 09:52:39 +0200)

----------------------------------------------------------------
u-boot-marvell changes 2026-10-05

----------------------------------------------------------------
Bruno Banelli (1):
      lmb: enable LMB_LIMIT_DMA_BELOW_RAM_TOP for ARCH_MVEBU

Igor Velkov (2):
      arm: mvebu: helios4_defconfig: enable the RTC
      arm: mvebu: helios4_defconfig: enable device tree overlays

Marek Behún (1):
      arm: mvebu: turris_omnia: Enable the `mmc reg` subcommand

Pengpeng Hou (1):
      ddr: Fix the SPD EEPROM dependency for Armada XP

Tony Dinh (2):
      arm: kirkwood: remove obsolete configs for Zyxel NSA325 board
      MAINTAINERS: Add missing file entries for some boards

 board/Marvell/dreamplug/MAINTAINERS    | 1 +
 board/cloudengines/pogo_v4/MAINTAINERS | 1 +
 board/zyxel/nsa325/MAINTAINERS         | 1 +
 configs/helios4_defconfig              | 3 +++
 configs/nsa325_defconfig               | 2 --
 configs/turris_omnia_defconfig         | 1 +
 drivers/ddr/Kconfig                    | 2 +-
 lib/Kconfig                            | 2 +-
 8 files changed, 9 insertions(+), 4 deletions(-)
