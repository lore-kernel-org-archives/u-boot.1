Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C34FC43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 18:36:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3436584C71;
	Mon, 13 Jul 2026 20:36:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="hdQjK88n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 468F084C70; Mon, 13 Jul 2026 20:36:16 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55BCE84C6D
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 20:36:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-4728c12ba97so1509269f8f.0
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 11:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1783967774; x=1784572574; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xKoYzBp9qUNcuV+/NtOxSmeYsdo9KCqwAXlGEH2FzA4=;
 b=hdQjK88nNL7+iEOw/F2zJAxz7wIicouKJs8EJXx0KtfQho4hL/AZn8A1LyN7gO/CCS
 IpyuH8bS0yF0VP0e0bx0QSrr83fXc97lQWYLJvW3U2CaBUz8Tg6p0aDAwQY37Odscjss
 Idjh+9Pxz1HYtrlX+3+UQsCvLf2blZ5DLwRM2QclJ//j2gRaBaYGjnxV8/BmE1T2IYrg
 Wm92yyyW2hnUX+Hzwwh9dMTQmAOQv4QcjcIPVS3QJPAG4pK2TYyrNBc57/aZdDZjFxHy
 ZvSggtLag1r3rcMtbPKAs8cQrYRFXzrwH76Jj2QyPSKkviJZJnkULESx3Xbl7gdKFY5p
 N3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783967774; x=1784572574;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xKoYzBp9qUNcuV+/NtOxSmeYsdo9KCqwAXlGEH2FzA4=;
 b=i4XTpn9tir6BLFYgWmUko6eVhxroibvVQZpNm7aKBe6jFUBSiJXRfaQ1E3wS/13ueM
 rS/DKetiNUFtmv05dhahGDb7l0HTvab5r7BVol7EAPMhDd3vRYl2R6NttP/UcCTU9EKz
 8A3D/WQ7Ngsg/DLLft1FsnmOjyhhn0Xh8+9ddXgfgr/rLkxNDt6W7EibGpTcgbMQ/3dQ
 6EkLNp2NsGMmbt8aMPqAjD5v3ctt8nxav8gE0NtRQAW2EQIdgwfHbPAQI17FCS+2MS1K
 zeUUnl+hrGIWrZuut0fQTaH+Z4pA0A5F3ZzT5su/BGy0932cvJ8sSSJzM5xLX5nABs2b
 Hd+w==
X-Gm-Message-State: AOJu0YxaWwDgNstSVtDV1w3eax9VpkE2Pwwyp2FhWFeJ8Zka//a7piyM
 Jfnhvks5rGDv/iHNtteb1x82nui+PCddnFvB7Po7YrVBdqHJ6TDeDwARUZJCSM8fB6k=
X-Gm-Gg: AfdE7cltkN/7XpQicfrO/mHXMvMy1X85m6hg6Dbzow832SPKLzXXuLDV3/9SXtF+iY2
 sYtOVrlBZyoAVP0dkh4I9iY0Tgd2UaeRpO/uVqjxbv+mhN7jMw0P6w4AqPS2zdGYRtC3G75D/EJ
 z9eai7GuYoceggURQUv5KyJ2nzCGlXOihYKjI5VoJer4F8oXBbYHXgp1IZ3srSMUcgtFk4RaQfd
 +DLXuxmxGAPl/hSTif6zZZf4uRrpfgawfoH3IGHx3ruJHEVpCn76EWuN7E70TIUbZkWXuCT7XOT
 I57LH1CRGyjNRE/EfelQIUL1d1q2BXLU53iOvmuR7E07p3gwGOFDzRvPOLMUqBNlBMuJ7m/WtFU
 XV85bBrwB/7hqXjGgdDB4jiiRwkcYRLZ3GVe9MhL4JZwziuRIGAV+ABI19HajPynUe3A0qKfup5
 fwgkROXGUIWnd797ZThbsxKaRJ1usISMxRAzXUFnQbbpdzeZHuSEEyPn6SerhM5lBb
X-Received: by 2002:a05:6000:3101:b0:474:3708:b7 with SMTP id
 ffacd0b85a97d-47f2dcada52mr11419841f8f.3.1783967773635; 
 Mon, 13 Jul 2026 11:36:13 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae.
 [92.99.174.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464c1f84sm1434703f8f.29.2026.07.13.11.36.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 11:36:12 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Subject: [PATCH 0/6] clk: rockchip: pll: fixes and simplification of maths
 in RK3588 frac PLL
Date: Mon, 13 Jul 2026 22:35:16 +0400
Message-Id: <20260713-rk3588-fracpll-v1-0-cdf47f2ca0b8@flipper.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5AMBBA0avIrDVRDW1cRSyoKYMgU0Qi7q5Yv
 sX/F3hkQg9FdAHjQZ6WOUDGEdi+njsU1AZDmqR5oqUSPKrMGOG4tus0Cd0olM5IbXULIVoZHZ3
 fsKx++70Z0G7vBe77ATk5i6ZyAAAA
X-Change-ID: 20260713-rk3588-fracpll-7b3e1f817c7d
To: u-boot@lists.denx.de, Elaine Zhang <zhangqing@rock-chips.com>, 
 Jagan Teki <jagan@edgeble.ai>
Cc: Lukasz Majewski <lukma@denx.de>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Finley Xiao <finley.xiao@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1808; i=alchark@flipper.net;
 h=from:subject:message-id; bh=7NryY0+twb8m6Tmmwxd+gwh9B7OIvRZqYlG+kFLuWfU=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSFGkhdvpiybAbT/fcTPSI1bsae9FxvkrzfK8COT3yBw
 ay1/O/MOyayMIhxMViKKbLM/bbEdqoR36xdHh5fYeawMoEMkRZpYAACFga+3MS8UiMdIz1TbUM9
 QyMdYx0jBi5OAZhqtwaGfwYukrJdFVLTbjjn63+PC7sx1eXCz5cfLea8W2R5oF1nwxaG/zlZTOf
 upN001g0u3PXp/eUSV2616p4Ducb3xI2Mv/w/xAYA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Current fractional PLL code for RK3588 (also applies to RK3576) has two
issues causing it to overshoot the requested frequency for some negative
values of the fractional coefficient: one due to rounding, the other due
to treating -32768 as an invalid value where it is actually valid. It
also overflows the calculation of the fractional PLL rate when reading
it back, causing the function to return wrong PLL frequencies for non-
trivial values of the fractional coefficient.

Fix all three, and also use native signed integer arithmetics to avoid
manual bitwise operations on the unsigned representation of the fractional
coefficient, which simplifies the code and makes it easier to read.

The commits are deliberately split into excruciating granularity to
ensure each step is explained and easy to review. The final diff is not
too large though, so I'd be happy to squash as required.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Alexey Charkov (6):
      clk: rockchip: pll: drop misleading fout in rockchip_rk3588_pll_k_get()
      clk: rockchip: pll: fix rounding of negative k in RK3588 frac PLL
      clk: rockchip: pll: fix RK3588 frac PLL result for k=-32768
      clk: rockchip: pll: let rockchip_rk3588_pll_k_get update m directly
      clk: rockchip: pll: fractional PLL coefficient is two's complement
      clk: rockchip: pll: fix overflow and drop manual two's complement in rk3588_pll_get_rate

 arch/arm/include/asm/arch-rockchip/clock.h |  2 +-
 drivers/clk/rockchip/clk_pll.c             | 70 ++++++++++++------------------
 2 files changed, 29 insertions(+), 43 deletions(-)
---
base-commit: 6741b0dfb41dc82a284ab1cff4c58af6ef2f3f9c
change-id: 20260713-rk3588-fracpll-7b3e1f817c7d

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

