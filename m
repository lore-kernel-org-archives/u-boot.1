Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAA1606A335
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 17:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Pxrq0UjG;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CLs5Wb4G
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 73F458109E;
	Mon,  9 Nov 2026 17:28:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mjhLv3SVoX25; Mon,  9 Nov 2026 17:28:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 79CD780FF8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794245324;
	b=iE7M1yFxJL4ppH/IzbMrBqqvWI2rzkS/+b2fqPHGfEn27mL2vq3MBkWRTxOFC5RJeZhr
	 qtLQvEp3dP56S+AoR6jXjTnITbY2QzNvmSwGAIHsif4iA8Ebm5/qgU/cDX0yA+OqcU0Z3
	 iEX065fcououze8xpkG70dfC1WDHnrYMQfd9Y9eLeg4ZCpjg4XnPG04W5mj5oI9ayn1Mc
	 yOhZWygoOsFfHUKP6Gz8NpcP3x+BodrIT7UgNnQXrediEkkMXgxqzciKkZtaiVtFUj6Re
	 uIIqmtdv7jGBivyexbht62gy7bwTP8kjRNapRWIQHyA0ljwlPObHLXu5ERhD7ufwOcQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794245324;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4xiYMOSkJ4BYWvJGwj3gwlFz/uHWcUlg9b3neObuZuE=;
	b=pcswlZb1DSFq/RJuOeZM5jias8iLyoQD2AZ1dpcAGepdv4LCTy16L6VEVHlYcQ6s+T9w
	 obt2vrc3rNHNDzKyfADOg4oNCRwv0bNW06dyixTq4M/7i35pgTnV1WQlmwTXfeoLoPrsv
	 JarDT0KnzpwGy+V2kidg5SoA5P/VoYWT5XUDogXlSLT8ostfW2wLOqapJboLKFU8rN2YE
	 AP7M4VtYxIZQuAfwj0aFf8Dvq/caa13ztj6t9U6kxi4PaSTbiFun2RgMW7/Dte8B0OaT1
	 AI1GctHYDIh0bf8eVJgANfJQDb1dkYepybIqZziWjuAyTkKZV8iBf9UHs/8wCgQuFQg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794245324;
	bh=4xiYMOSkJ4BYWvJGwj3gwlFz/uHWcUlg9b3neObuZuE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Pxrq0UjGKF9rtPkMU9CCF5EmDPeGWz52jqBnb/0X6fMIVLHw/Auxpc8oUNR0/1BTQ
	 DUMLMEL+wJPYBRUovTjfMfT+31iIv8dFX4mb73TaAtYxsOnKBORVi0dDgu6slPW14g
	 vXe7FSYGt9LozmgXbxxjl3vHhSrg/UccX7vwKcXOjWFr/9R3XJLFqEPvIIw6BostSJ
	 hT94cuZW/vhRoMO8rQuR3EKQfeEaT00fL5qtJeeoAeGlYtOhVWjF3OoNqGVAFHkaM/
	 XGUn/bOukjVY/1lfIwm0y2HVMNtaz4j2PM7KDv+qTF9R67hRvJWXH8nO2xsUN0F66i
	 xf4R2pjOETiZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 79CD780FF8;
	Mon,  9 Nov 2026 17:28:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 84BD4251
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:28:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 81EBC606EC
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:28:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZqR5njCVWvjz for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 17:28:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3E55D606B0
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=CLs5Wb4G
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3E55D606B0
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:28:40 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-491f34b4e0fso520321f8f.2
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 09:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794245319; x=1794850119;
 darn=lists.u-boot-project.org; 
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4xiYMOSkJ4BYWvJGwj3gwlFz/uHWcUlg9b3neObuZuE=;
 b=CLs5Wb4GaeYJtV5Leu+MrFr0uT4m/TiEMWtKmFpF+TgoSs67UYX2QNrExUf9H3sYGW
 tGfpgUODAkyAKEBuxdTuICUd4NCiUKL9oOmRw9ddp26RVHJBHHfC89GxAt3uG/N6U1uk
 53U9m3v0T77IQZJ9oBQCOT22nIaefHSZtdxvE7IdWRsfPaaaRn1/uIyMWQtKmSCyxGZm
 lTYWtU4rIjDCH0AG0y2y7icnJ1+yg4esO6nIoIjtirp5JqRd+t2u2bfkGOEuFgLX0Mt+
 pCdwkCjO+kXXmbjUiNTfxfIMHGl5N4TG+PwrbYRT9lRBMJ/AZucIu1UvSzUtZA2iyoI4
 dCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794245319; x=1794850119;
 h=message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4xiYMOSkJ4BYWvJGwj3gwlFz/uHWcUlg9b3neObuZuE=;
 b=Q4HBLp/Pw3ZqiCj9Atc0tqq+0ZEMTSzUbRTmXiAoMXoP/Sdfq2rJVbNKzSCD+9FkF1
 qvhK1bRUBcZzidR0VUV/SYGXI26wqEgwCwEUx9dhsR6OGnvNMsg0UDBDLqW64vXKxe0Z
 hfmQAyouUxdjzc6uXjsHIMznap3UxGBVPyEvdW4qzKBh3TcZ8ihadXjhGvC6y5GwAWOy
 EHU0dmt5ojsSDDWfH1ih02cVaiAICnV1pL9T2DeFAO40XWjHlaLS7VCDnukuyxrZy5m+
 TcjazsLuFf9/pxAeA/UD1vOwktwc8/UbsnYQWqqkycXOLGjiRpS+b+c4g4NzquJdYipY
 LfDA==
X-Gm-Message-State: APuU4Z/fSkMaXsvDsdHjPL22a/zmQf5NHs2ChdBDwi5tuTUlNyaGcFOY
 qK8NXSoF2o9NDrKNwmy53Mk/HDED1s/i+RW+5DM+KV/ioj3jKs+X97cSnM14yJLCjxg=
X-Gm-Gg: AYBFou1VNEsho0o9D/P2T+ads/m8dIRTWsDZpJsWa8W0rWfs7CJLGr4aymPn/S2W3JJ
 JTNQffGl5BJ1lQrqV7H8yS+PNtH35cYCVs6axS2HbjwD25SOIgB/liff8WK0pgqwlQYbNnCxiq4
 J6yqzp4KixwpOMXXGTeP2dbQZGoervK8zvQmHtmGhR3MbzPeG7xdr6qh69rbymJtMyDLQsJs2WS
 2KRP32L9aK3NjvROmcVgjyiCQ7hdGweLCGqPIQlnw/Np5SSlErujVpCBhVVJtGvtnZVzajLUT4T
 sD+OmNmRF17YbjO3uefIZ+9H9ug3HPhklQfWz2N0rolGyQpU2h0nisBEzuOO7Rgr65LN3jv68ED
 Y9F7DvzKGghfNEEdQzHP2fuXZEuuczZ+kEjgDk7EsRwJdWmBsBqUt+7ZJffM+244uRq/NkMJrWw
 rVAbHDgMinMVlN4pvcm4GQeR4By+i+m2tBjBQ+pYojGmttEghOYinPEnNFg5ZYF5OXIRpz7QABe
 kZTT9pahLB7yBcEX8geEx2N5YBv00MO8umqYdS/B9O5MxwO/GD7YSyOnX10Vnxu4+MRUAT8bls9
 XUOwHWtO5WfdtdFe51dqnAhHhMR6W00=
X-Received: by 2002:a5d:6f14:0:b0:490:c80e:8e4f with SMTP id
 ffacd0b85a97d-498305daa81mr223632f8f.37.1794245318477; 
 Mon, 09 Nov 2026 09:28:38 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49835c377fdsm86774f8f.21.2026.11.09.09.28.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 09:28:38 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Simon Glass <sjg@chromium.org>, Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <u-boot@0leil.net>, Andre Przywara <andre.przywara@arm.com>,
 Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Warren <twarren@nvidia.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 uboot-stm32@st-md-mailman.stormreply.com,
 Neil Armstrong <neil.armstrong@linaro.org>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Subject: [PATCH 00/11] video: Keep EDID modes and DP lane counts within what
 is reserved
Date: Mon, 09 Nov 2026 17:28:36 +0000
Message-ID: <2399d63c-ddd0-44b0-bb81-d5d9d2a8a8b4@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Much of what U-Boot's video drivers set up comes from the display: the
mode from its EDID and, on DisplayPort, the lane count from its DPCD.
Several drivers take these as they come, while the memory they use is
sized in advance: the frame buffer is reserved for a maximum resolution
when the device is bound, and the DP link training code keeps its
per-lane state in four-entry arrays. A monitor or panel announcing a
larger mode, or more than four lanes, makes U-Boot write past them.

Patch 2 makes video_post_probe() refuse a frame buffer larger than the
memory reserved for it, for every video driver. Patch 1 first fixes the
two STM32MP2 defconfigs whose panel is larger than the maximum they ask
for, which only work thanks to the 2MB alignment of the reservation.

Patches 3 to 9 have the drivers which take the mode from the EDID skip
the modes which do not fit, so that a smaller one is used rather than
no display: edid_get_timing_validate() no longer hands back a timing it
rejected (patch 3), the display uclass learns the size of the source's
frame buffer (patch 4), which rk_vop, sunxi DE2 and Tegra124 pass to it
(patches 5 to 7), and the sunxi DE1 and Tegra HDMI drivers, which read
the EDID themselves, check their own limits (patches 8 and 9).

Patches 10 and 11 limit the DPCD lane count to four in the Rockchip eDP
and Tegra124 DP drivers.

Tested on sandbox: the two new tests, dm_test_video_fb_size and
edid_test_timing_validate, fail without the fixes (the first one
crashes sandbox) and pass with them, and ut dm and ut common otherwise
give the same results as on main. Built for chromebook_jerry,
nyan-big, transformer_t30, Cubietruck and orangepi_pc with no new
warnings.

CI: the series passes all 91 jobs of U-Boot's Azure pipeline, in build
13732 of my CI-only pull request, on main d1d45c926a5.
PR:    https://github.com/u-boot/u-boot/pull/1064
Build: https://dev.azure.com/u-boot/u-boot/_build/results?buildId=13732

Ana Bobillo (11):
  configs: stm32mp23/stm32mp25: Size the frame buffer for the LVDS panel
  video: Check that the mode fits in the reserved frame buffer
  edid: Leave the timing alone when no mode is valid
  video: display: Skip modes which do not fit in the source frame buffer
  video: rockchip: vop: Tell the display the frame buffer size
  video: sunxi: de2: Tell the display the frame buffer size
  video: tegra124: Tell the display the frame buffer size
  sunxi: display: Skip EDID modes larger than the frame buffer
  video: tegra: hdmi: Skip modes larger than the DC frame buffer
  video: rockchip: edp: Limit the lane count to four
  video: tegra124: dp: Limit the lane count to four

 common/edid.c                          | 10 ++-
 configs/stm32mp23_defconfig            |  2 +
 configs/stm32mp25_defconfig            |  2 +
 drivers/video/display-uclass.c         | 10 +++
 drivers/video/rockchip/rk_edp.c        |  4 ++
 drivers/video/rockchip/rk_vop.c        | 35 ++++++-----
 drivers/video/sunxi/sunxi_de2.c        |  3 +
 drivers/video/sunxi/sunxi_display.c    |  5 +-
 drivers/video/tegra/dc.c               |  4 +-
 drivers/video/tegra/dc.h               |  4 ++
 drivers/video/tegra/hdmi.c             |  5 ++
 drivers/video/tegra/tegra124/display.c |  3 +
 drivers/video/tegra/tegra124/dp.c      |  3 +
 drivers/video/video-uclass.c           | 12 ++++
 include/display.h                      |  6 ++
 include/edid.h                         |  3 +-
 test/common/Makefile                   |  1 +
 test/common/edid.c                     | 87 ++++++++++++++++++++++++++
 test/dm/video.c                        | 29 +++++++++
 19 files changed, 204 insertions(+), 24 deletions(-)
 create mode 100644 test/common/edid.c


base-commit: d1d45c926a571fb6c1e6d7105c280833646915ea
