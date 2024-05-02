Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49719C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 19:34:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 667A688373;
	Thu,  2 May 2024 21:34:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ato13crf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 886BC88387; Thu,  2 May 2024 21:34:17 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75D1C88313
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 21:34:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3c730f599abso4847663b6e.0
 for <u-boot@lists.denx.de>; Thu, 02 May 2024 12:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714678454; x=1715283254; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CgRQqvP7o1ReK8WZqcBj0kzZMRFLr6JvB6d5YnIKX6s=;
 b=Ato13crfY0FAV4NBczI5J0rWGCMuDLfv1KqZ52bLpUImJK9kI6qwVTz7ZxkL34IBZT
 1oq/vwSjtcSFvjekrn6NT25GVYn+TfwQejc8kz6cVJXAhE3GAV79rWituVrRRNeF0F6Z
 Vbmn7fd7W4cUiTAcoJH9GiNbOfV4udy1NcJnLiOgm7GFvWItNXrYSWC9niI3WkYSFHow
 jbhG27lYmtOEKmihtL0j6RSAok1vT/KQ5ytExb5knHIrsxe2mFPmXpwF1deCWbHU4HSJ
 1EXJAsIU5HCnHhiDuu7zi73JVM47Z3bQeil3AW4EUPnDNtXop5ouT0+uLHBLIrd7GCZk
 i3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714678454; x=1715283254;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CgRQqvP7o1ReK8WZqcBj0kzZMRFLr6JvB6d5YnIKX6s=;
 b=MJDMtUQEykfNy0lHTqrIltWGvo5pR8PdAPmHqtbDMR8XKNjdqLhvcNdb1i7g4vzFrS
 7HLmEGBHL570tn4PaIEa+AfwQ3ZzKvKnquEjCZZjj26kEjsqXAOtZ+eJOhwR4Q9eRFsw
 yBq+hER50YympDlIsyl2pGH6raBt6YaNnzyOATPBJc0RnG3BTmnMLovGPbEgWenAK20M
 cLo3/xICdtZ54FHqFPBTWHlgLThgebzlOK8S0diIotAIqGHPmp3/gpVvCSr/gvTP7KHR
 TQWtzhjbf/oi37RCAAL31EPfq5XTan3I1Qy/6RQxgHciErln1joHOlPwA58MU4H1yJVb
 lVdw==
X-Gm-Message-State: AOJu0Yx3Dg032Pikl8CmPT3zQKe2rpkTGJ1OsbuO8IHQs4oEq91Wysec
 cUaL/plcn8HkG3wt37GkRBkBC/nav/mrzQdztmX18gmU2Nbi6sAGLww6KQ==
X-Google-Smtp-Source: AGHT+IEB6scVWZ0UbWmPan9g5f38vQ+cGKirb+hcwSmPcQCcrrWdVQmUTCaQGysia7A+QgM7mYBhDQ==
X-Received: by 2002:a05:6808:23c3:b0:3c7:4941:6b0a with SMTP id
 bq3-20020a05680823c300b003c749416b0amr1035136oib.46.1714678454075; 
 Thu, 02 May 2024 12:34:14 -0700 (PDT)
Received: from localhost.localdomain ([75.28.21.198])
 by smtp.gmail.com with ESMTPSA id
 ck9-20020a056808250900b003c4f39fb9e7sm252340oib.36.2024.05.02.12.34.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 12:34:13 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: dsimic@manjaro.org, jonas@kwiboo.se, trini@konsulko.com,
 kever.yang@rock-chips.com, philipp.tomsich@vrull.eu, sjg@chromium.org,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 0/2] RGXX3: Set boot order for mmc0 first
Date: Thu,  2 May 2024 14:34:08 -0500
Message-Id: <20240502193410.1080938-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Chris Morgan <macromorgan@hotmail.com>

Set the rgxx3 device to boot from mmc0 first. This serves as a fallback
to allow us to recover from a bad U-Boot (or later) stage in a worst
case scenario. The code for an ADC button appears to have broke some
board revisions; this solution is much simpler and allows users to
continue to program the adc button as they see fit.

Chris Morgan (2):
  Revert "board: rockchip: Add early ADC button detect for RGxx3"
  board: rockchip: rgxx3: Use sdmmc0 as first device

 .../arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi |  2 +-
 board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c    | 64 -------------------
 2 files changed, 1 insertion(+), 65 deletions(-)

-- 
2.34.1

