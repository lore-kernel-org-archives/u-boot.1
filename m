Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE26C5DF7E
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 18:17:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 34C5F810C5;
	Mon, 17 Aug 2026 18:17:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ol8bG28J1Crk; Mon, 17 Aug 2026 18:17:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0B985810FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786990657;
	bh=mTPbFoyA3t3S6oeZhs0Xhv7J45/3gq46lhnRwUHXSbk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LN6g8UVIuzxeMFTNF9ZddrikUojIaY6I8pPCvCZhm1+MrFSHug0qTd7k1KuTq7YgV
	 Rt60kDPxmzbM6BaJdrbHstbss1dQpbc4qpWDIE7iF8+nTLtPH8x0NJn4cR5Kr6jK9t
	 LgrAik8aXJvfULZkD4f8pD8eUQA8C3EEzdf5wWKO8Ev+79ri6O5xEQHJRuL5NiOLCd
	 cYrh4gMTRN2bgXMR6FtaEoG0B+yJcLlaEry96PcIWQu28fxHTcikaqgfR+4vdsdQct
	 Q0tQkBaq6MF20XLhIoRhwvGf8j3ZUf49Xo1nj5aQcsSYDGNfSYbcq/VqOpO5Vc70bp
	 6vT9r7xUQ9vdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0B985810FA;
	Mon, 17 Aug 2026 18:17:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C497F282
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 17:16:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B687440204
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 17:16:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8TzZqkmREqs3 for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 17:16:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f2c; helo=mail-qv1-xf2c.google.com;
 envelope-from=sanderson@brivo.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org ADBF8401E5
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=brivo.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ADBF8401E5
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256
 header.s=google header.b=avJP2qZP
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ADBF8401E5
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 17:16:27 +0000 (UTC)
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-9034b6b7674so22681206d6.0
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 10:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brivo.com; s=google; t=1786986986; x=1787591786;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mTPbFoyA3t3S6oeZhs0Xhv7J45/3gq46lhnRwUHXSbk=;
 b=avJP2qZPhQKqd5f8uc+CkKu1Lbz+Syy831yq1cNBti4+Km9M/+lDgckcxURB4BR5Ug
 3OPze09xr5NVAx4YgxMuPcQWH+00MbOQ2vy2ceBPmQf9/XUqMR5MGd9UwmFgMtBJptg4
 5m73xWAHueoU53T1McA0BDfyahLoQjJGKzp6F/RSJ2mjPkgag1Jm2drr+3z+NVfae1+i
 JhG1Gmrag5Tw9hfaQ2XpgFzupcjUiHZBcbwC4kQ5mpGSU0MJifx2nBqA/85SrPxjZc0o
 5Zr5MXZy7/zzJXoAak7Iba9H6VyEatfznj2Cjk2SBpyNtnjHDTwfDxumH6WAc6I+OTwr
 KkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786986986; x=1787591786;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mTPbFoyA3t3S6oeZhs0Xhv7J45/3gq46lhnRwUHXSbk=;
 b=tPIWZvcfp6w10tBS9TKec3h0rg5B5g7YntqVfpxBhDskG5MfrM159Zw5qqCEIysZ7N
 alFORP6JOb98V73h2DlG+gKS1o3Pn2bm1dfzwxNRtof5TtTpYwIToDW373Y8dD4m+dBx
 FqtI6bE7FUe4HfY8K+WWKCXB68hWDtslS5KtFGkDCHEov25yPBKRTdjcfc0D5zVNeCV3
 8XuJSmF9s+8BHHSggr/3lvtUMhCn/jBYzQ2MIDQYerPfMeVKru3EAlqT/i7gumUJTHU7
 UZU+JvGEB5zzo4SB1aWVx2B+HPIZuC7yNdUmM3CDY2soE/Lk1V9VWOOa+1aTjFtx1IkW
 AJ9w==
X-Forwarded-Encrypted: i=1;
 AHgh+RoPU9/hALyOnSJzxRlpiivDg1z4WlbIiLNPTHAUvUirC18R2k2BJb2YYK9RHFZXjAVJuyPpemA=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yx1QX9kSMmyAf22S/GXa+FDQ8D7j3aGcMJu0f3haa7TrzBL3HAw
 XhlQIgFhSr3cYNHy3u00Qav3+T5myd5j/b77A6wur1ws0kB36JAdE5y6RBzKfvUzouPA0WzzAry
 yYPdu3cdM8B/49HJgekBSlreTOmtGqyfm9lQHnoOvyjQqHR6nN8WNXMu+Tf6/DLElxOpteb4qTO
 4nwlo=
X-Gm-Gg: AR+sD13Qv39GdBflmkl+Lpb71IghVydfXDTmWZYUUO5008vVNpG8GAPIYO2F9zhwmCV
 GmxW/qGq6ZfjH9RTY7Gzrrrt5bj+MUte9bjlyyOosLpbTc+piRvAzEefkL1pdDpBX6gnPy9ZZhk
 P1xLJS8T3RMCMnNaGoKMLU8VrJKg4I1mQQcOJiP1bkooLsiu493RvvWoLOagZ4eXQXTrQVhQq2y
 x/B3TEESJGC5hVfM/oEDigfLsGZDh7v7pmEP88g2H1ZWoPmhG9ocwSnV80wjW7RztPhslQgJNmb
 v5qcqe1tl1O4QFcYiJ0EqDfX2f9gEXrMvaNGLclebieC/57Cxh6CwPB2Nr345zlN2J5DMPDgxNV
 QjvcLCKr2ghzgrjE941Jh7AELwxj00veURwIAhnpYp4YZdlVpGL8upHfzaGxxL8F/FPP1UAwXes
 4r+MifB+nSxGnW1dVz5srhHBiIWZrzDXPhc6SYQZ7oFmdCBkIkVFAMJ74dvQnD+1X/Z0/uEFsIl
 60sSkTK96/4GUvtaVT8vSEPgpA=
X-Received: by 2002:a05:6214:3f8f:b0:8df:1814:3a1d with SMTP id
 6a1803df08f44-90c4b3ded05mr25865496d6.22.1786986985957; 
 Mon, 17 Aug 2026 10:16:25 -0700 (PDT)
Received: from strozzi (ec2-54-236-161-35.compute-1.amazonaws.com.
 [54.236.161.35]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c459783a9sm13637976d6.43.2026.08.17.10.16.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 10:16:25 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>,
 Sean Anderson <sanderson@brivo.com>,
 Christian Hewitt <christianshewitt@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 0/9] arm64: meson: Add s4 support
Date: Mon, 17 Aug 2026 13:15:11 -0400
Message-ID: <20260817171623.1943847-1-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 17 Aug 2026 18:17:15 +0000
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

This series (along with several patches submitted separately) adds basic
support for the amlogic s4 SoCs (S805X2/S905W2/S905Y4). My tree with all
patches on it is at [1].

I developed this for a custom board, but I believe a better candidate
for a defconfig would be the publicly-available Khadas VIM1S [2].
Unfortunately, I don't own any VIM1S boards, but I have included a
sample defconfig in the last patch. If anyone has a VIM1S, please test
that patch. You will need to use AMLogic's FIP [3], as I have not yet
gotten around to submitting a PR to LibreELEC's FIP.

[1] https://github.com/brivolabs/u-boot/tree/meson_s4
[2] https://www.khadas.com/vim1s
[3] https://github.com/khadas/u-boot-fip-yocto


Sean Anderson (9):
  arm64: meson: Add s4 SoC support
  clk: meson: a1: Eliminate separate id parameter
  clk: meson: a1: Use clk_set_rate from meson_mux_set_rate
  clk: meson: Use soc-specific naming for common functions
  clk: meson: Export a1 functions to common file
  clk: meson: Support fractional fixed-factor clocks
  clk: meson: Support power-of-two dividers
  clk: meson: Add s4 clock driver
  [RFT] meson: Add Khadas VIM1S support

 arch/arm/include/asm/arch-meson/boot0.h |  14 +
 arch/arm/mach-meson/Kconfig             |   7 +
 arch/arm/mach-meson/Makefile            |   1 +
 arch/arm/mach-meson/board-s4.c          |  50 ++
 board/amlogic/q200/MAINTAINERS          |   1 +
 configs/khadas-vim1s_defconfig          |  80 ++++
 drivers/clk/meson/Kconfig               |   8 +
 drivers/clk/meson/Makefile              |   2 +
 drivers/clk/meson/a1.c                  | 495 +-------------------
 drivers/clk/meson/axg-ao.c              |  12 +-
 drivers/clk/meson/axg.c                 |  16 +-
 drivers/clk/meson/clk_meson.c           | 376 +++++++++++++++
 drivers/clk/meson/clk_meson.h           | 149 ++++++
 drivers/clk/meson/g12a-ao.c             |  12 +-
 drivers/clk/meson/g12a.c                |  24 +-
 drivers/clk/meson/gxbb.c                |  24 +-
 drivers/clk/meson/s4.c                  | 587 ++++++++++++++++++++++++
 17 files changed, 1318 insertions(+), 540 deletions(-)
 create mode 100644 arch/arm/include/asm/arch-meson/boot0.h
 create mode 100644 arch/arm/mach-meson/board-s4.c
 create mode 100644 configs/khadas-vim1s_defconfig
 create mode 100644 drivers/clk/meson/clk_meson.c
 create mode 100644 drivers/clk/meson/s4.c

---
base-commit: d3e8597e46b635ec556a057bc42f0b0859654bdf
branch: s4_clk

-- 
2.53.0

