Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12962C982CF
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 14:02:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C4E4A608C6;
	Thu, 17 Sep 2026 14:02:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rzYufI1PTqY4; Thu, 17 Sep 2026 14:02:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D06C260889
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789653767;
	b=nQim7ToezRkqBwpRB+r1FQYLOIvYxXtlG1SRrZsJHiKMf3fNThwo2JBoErK7kKdtwE+6
	 XO1ffVBJsq36kxR++oqKWXRVTqIufTqphZ8hon/GHq2xu1Hdh+HH9HEN6mWGwZH0HMaD5
	 bWP5o4iDbA/YF4FiLJ5xH/sEsRBUKCxHe4WEXUuJJkNpmLg4KgJWGqs4Gv+jgRpzhokB8
	 x2lsBZfaxyvBOfcIbg1JqMENkg3hvxwTKCBl7eDA+3STA5WLY5ZL60RVz0yCWHLbNBD+m
	 ZfqUEZwn+fpXmmV5OvNLHn3oifK9iaAxAqsSHP9/hw7Zad5Uae/MTDZ+WThqm1rxoAg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789653767;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=h7DWsz/FFzyUxsUbWfWV6BFgJYAeyWVxJEzAGGnpZWQ=;
	b=NzjaZzNGHqArPb2VEQqy34aUllju8up9kam+d0UjdUKebnsxF34P5R2QpXiF1yr7ZGP7
	 jR3EEMcH5c8jpP94CC+8MNpXwZf0ibWwX4ODhjYFsQPCnjCDXHkKO3K+K7b4Tii7GjqYM
	 iodpxTVFoMDQmD4e28dQ6bPT21JwV+V8jbMXKYk7tb3DxZJqrhInMyJAXbo6L/L/BFof2
	 TAA87JrryGYsW224BfrNd02p+5xOGmYwewHbv7DMnoqJuWSvzDLxXi14wHTOxwA2LmFCv
	 hlcjUMjl92JPGcKK8GhGtTCoPnmCqXAvvP1rs7pHALueIG18ROuxcusVm9sl2BgZVKA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=eDTiyPcY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789653766;
	bh=h7DWsz/FFzyUxsUbWfWV6BFgJYAeyWVxJEzAGGnpZWQ=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ouFAC32lbxi/hBNBOwf11f2qqV5UjR3J6yO00KppUkCIi+NLlY8JUvwtAVh1BH9Fr
	 CwIu1ZVJRFUhp8r6BWgPEyj+BdVUSoZeuEtqHwjYTeRaKNncwsSU7561x+3zopRXpO
	 L83q8r1uHFpCRWnR8sr84Rzezm0BV26kSy0RrtRgQ4OOTgjSVJTXlnpbrNE0RqrLHP
	 ykOn+bM0Cv4c6ozHODUu4q0K8jPU3vtcJ8rg3OnWR7E1DPpexh2FQNK7NbTenu1WsD
	 Q8pYW8mveCVmTkjgyLaN39IeCmSE1Y0j4MGtVqjpLZwnC3jf1QfEt26/MtgU6tGoeS
	 8JS3WMMkarRDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D06C260889;
	Thu, 17 Sep 2026 14:02:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C85CC13D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:02:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AE7E460889
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:02:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CA5Qt7rAglPx for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 14:02:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 70C9E60874
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789653764;
 b=AmUG5QgE4KYxIi7LmhOrb0ejrE51FzESDu2fewnJVV9IHIdhS4i6Xf+AmeyCE7KyGPS/
 +JBQ0z9UJW6JVS/dzgWr6xiKpqiyfR9sCNq1JnKzS6bN7oJJkkB8md/PBI8D7Pu3k7m+g
 cqBRHEGUEt62Jt5OW6gor8PYKMsbe1hc0O0c4LUgqhLGUkE3Wez8ONjKrVYXalIc8CBZj
 KGX8HSgLW2eVqv3xQTZs9wLk3983Vre/ev8/mX+SbwveyyMD46afBH4Pqo4qq58SOGyHV
 lnhMtuiFtjy0uOHxjcOizSHGcImavf+UnjHwvfRpxLTYiKqzL3683lm45LJ1XSFDB/A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789653764;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=h7DWsz/FFzyUxsUbWfWV6BFgJYAeyWVxJEzAGGnpZWQ=;
 b=ae3abGTvMdbWBAb7jv9sNAvEDyknFVLytgdX99ZOynxK174xkZfJel12h2+oOVrobROI
 deIUrmCs/ty8sNDAlIIdRSrD3GdBQN5vfoiGBRGYTs8+fGjWWWPFlUuX8oee2LNdSsFmC
 buOmURXSOpuQjz+831XRwUd+ID1CyKkdttC2KhsG/abfBGkdkLnJI9nVEhsGWaCI/pGmI
 d4aMv/P5O5JY+EfdsQdtmo/oOlrFdtkVXzykcIGws+aIIwhTCCXnMRe1KUU0uCjoBM1Zv
 PUFKPYLMQY0efzCF3QMC8p7LBtbjfi7NZzH3hdKVTFTE3Q3rRR5TDuUsKR4KdZOKh2w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=eDTiyPcY; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=eDTiyPcY
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 70C9E60874
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 14:02:44 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f633ece3so682374f8f.3
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789653760; x=1790258560;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=h7DWsz/FFzyUxsUbWfWV6BFgJYAeyWVxJEzAGGnpZWQ=;
 b=eDTiyPcYwXS0KzsYXX+6PT/H/0wVuoKPSyz1boXZqX2LMiAtJB3MUOt52ontJ4rD2s
 oWVtB7i3rYh67XBcGyqOByzpt8fqcp7ecPwZ2HnyqQFnOhWGmH5jcldHBnf8Dc1uMW/j
 tux6yLrsO0MuZ3KEn0/8ErCiIeQ+UPZcjEg7H3NhrMKzUDAULX6L+TbJk8av/cPIgar5
 V56/K0Oe0J5IodvszS2aC2hR0eUv6p3gL8LfcsLL3BX4XZta4PXw0HfA2arJYW+/qYCg
 FRdB/aIUtBbvP8cnNbvH9ukgY9v5SlTbt0ZjpYCgRX2jLX+noiy/uMCuJC3Mxj0YO+hi
 ShIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789653760; x=1790258560;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=h7DWsz/FFzyUxsUbWfWV6BFgJYAeyWVxJEzAGGnpZWQ=;
 b=JEAK72zUha9wN3cL+0nGMtfnJFjNYLLw39Ez3nGpyI6afvBEqj8lC2psMc5PnPO1Pn
 RqmGA6gjpTyFTy+QFEQpn1yOwrN74VBpipuqiXwFNTGTFop88CTZR56QXikIZ/nt9+Eg
 ryb10A+jp50wfAWfW6ul23xpFOpgAhsaWypE6DIFp8u2Tqt6ZUUb0mMxIwdHaesrdTa6
 ulPTd/SEQ1uORXHto7TCkEFHvWkOhgPhOsf7U0kW+cV6AdQF+fiJ3XsnkYMduToLjUvn
 SFXAW4EnBgrvdHG6Dnoa2VYY3pBYh+lHv70V9ilR/L6hxgeWWUGtv6lepxHdNt4VL/HA
 pXcA==
X-Gm-Message-State: AFuF++moUjjF4sahVCYRwZRaPjgBcBGEIcx9Q5auGr3cIE3fPtyIoInP
 AcHHD3nYERcgJodXX13wTwqFI92IGONT6YGqYhrYzMbxhkRrAnMsgS3IbaX1AscfXMM=
X-Gm-Gg: AYBFou0h/OBByhU4Oo2uDbXFy77MZ7xfpbzuAS82UsQs4kzg0WJxRBEKmUklSOjg/CI
 Ud1nyPQtWnc4NJ0pgsvw14DSYNxYrlvrzDVDNyYGnie0uC/e/86cEnUo5sN0GqGlJk6W+GW1031
 5tFXSJWknFHC+kbzFxBPz89BY8N/dszmV09TflmhdQp6OxYg2optxcq2/ylJ4+xfMNU22Vnu8fJ
 wMrvyPSSeLc3/y6mHBm4Ob8TTC2GWaj5UpB543wJHTTyniuvo/kphvc59Kltbzkq3fQwMBo1ObE
 y6YcMq4+LaDR5QSyUuJcjr0hCpphRrLMHNTubJHef4c+1B+XBmvBdOLYV8eFGOXaPGaDSWXy/12
 3MYIPGaAMTkx0r28V1mSPrThce0+6CNTrSM+U/QuWfrnvTOr+hczQMTTRef9QiTzlVZ1WH+A1QK
 n6TXV9RxWn8dAbV5E4sQbTjYBPH3ne5lp/zBqfoICjVLhtiPu1bM5LYFa6PQrqIsV+vkJOO5OIx
 ibN0zkENWy9+6BfGw6/RYomLwNKcVx0H22+76x06/d2OJmpFIhLqkO8XXxPRLM=
X-Received: by 2002:a05:6000:1868:b0:487:62d:37d1 with SMTP id
 ffacd0b85a97d-4870d067b4cmr8334657f8f.29.1789653759875; 
 Thu, 17 Sep 2026 07:02:39 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf344fcsm16893905f8f.26.2026.09.17.07.02.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 07:02:39 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Subject: [PATCH 00/11] spl: fit: Generalize compression support
Date: Thu, 17 Sep 2026 18:02:21 +0400
Message-Id: <20260917-spl-fit-compression-v1-0-7985ac56ee9e@flipper.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0Q5EMBBFf0XmeSdpKxr8iuwDNWVkF+kgEvHvi
 seTe885QCgwCZTJAYE2Fp7GCPqTgOvrsSPkNjIYZawqdIYy/9Dzgm76z4Hk/qM1WuVplrfOeoh
 mHDzvT7X6vixrM5Bb7hSc5wW+nhkHdwAAAA==
X-Change-ID: 20260915-spl-fit-compression-62108358dc6f
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, Cole Munz <Munzzyy1@proton.me>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Johan Jonker <jbx6244@gmail.com>, Aristo Chen <aristo.chen@canonical.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3116; i=alchark@flipper.net;
 h=from:subject:message-id; bh=myBqZ1oPtHAMiBwnpfbo7/hIdebzDWuljgbvkazNceY=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSt/vTpjrWsR1vl9/sHPc6L6B7QFlv5Ipf9RYLllpraR
 Zn72V71d0xkYRDjYrAUU2SZ+22J7VQjvlm7PDy+wsxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6
 hkY6xjpGDFycAjDVRycy/A+R0Nhi6yBm+7d33XIWmfMmjFfMu4SX2NtMuvL5+KlnMuGMDJcP381
 a2pgnZdq5enZCX4FtR2HFRr1Hr+tqnsx5uq/8Nz8A
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

SPL knows about multiple compression algorithms, but only two are
hand-rolled into the simple FIT loading code, in spite of a nice ready
made helper already being available right there.

Generalize the compressed FIT handling code to accept any compression
algorithm compiled into the SPL, and fix up the SPL_ZSTD linkage which
requires xxhash in the SPL but which was absent to date.

While here, also extend binman to support passing a compression level via
its image templates, which helps squeeze additional ~15% size savings in
my testing with Zstd level 19 without impacting decompression speed.

This is done with Rockchip RK3576 in mind, so a small Rockchip image
template refactor is included.

CI passes all green: https://git.u-boot-project.org/u-boot/contributors/alchark/u-boot/-/pipelines/1289

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Alexey Charkov (11):
      boot: image: Keep the image-type table out of xPL
      lib: Build xxhash in the SPL phase
      lib: Let SPL minify zstd on its own
      lib: Track whether a phase has a decompressor
      spl: fit: Decompress any supported algorithm
      test: spl: Keep the payload create_fit() is handed
      test: spl: Size the FIT properties for the image name
      test: spl: Cover FIT image decompression
      sandbox: spl: Enable zstd
      binman: Allow choosing the compression level
      rockchip: Choose FIT payload compression via Kconfig

 arch/arm/dts/rockchip-u-boot.dtsi                  | 16 ++---
 arch/arm/mach-rockchip/Kconfig                     | 78 ++++++++++++++++++++
 boot/image.c                                       |  7 +-
 common/spl/spl_fit.c                               | 27 +++----
 configs/sandbox_spl_defconfig                      |  3 +-
 include/spl.h                                      |  6 +-
 include/test/spl.h                                 |  8 +++
 lib/Kconfig                                        | 54 +++++++++++++-
 lib/Makefile                                       |  3 +-
 lib/zstd/Makefile                                  |  2 +-
 test/image/spl_load.c                              | 84 +++++++++++++++++-----
 test/image/spl_load_nor.c                          |  2 +
 tools/binman/binman.rst                            | 21 ++++++
 tools/binman/bintool.py                            | 10 ++-
 tools/binman/btool/lz4.py                          |  6 +-
 tools/binman/btool/lzma_alone.py                   |  6 +-
 tools/binman/entry.py                              |  6 +-
 tools/binman/ftest.py                              | 34 +++++++++
 tools/binman/test/entry/compress_level.dts         | 12 ++++
 tools/binman/test/entry/compress_level_gzip.dts    | 12 ++++
 tools/binman/test/entry/compress_level_lzma.dts    | 12 ++++
 .../test/entry/compress_level_no_compress.dts      | 11 +++
 22 files changed, 361 insertions(+), 59 deletions(-)
---
base-commit: 37bbe6e3ed205037fbca390f239eff9899639e39
change-id: 20260915-spl-fit-compression-62108358dc6f

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

