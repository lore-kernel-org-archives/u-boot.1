Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A53A9C4345F
	for <u-boot@archiver.kernel.org>; Sun, 28 Apr 2024 14:40:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4159D882AC;
	Sun, 28 Apr 2024 16:40:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O7+FcbND";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 953138829C; Sun, 28 Apr 2024 16:24:25 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B51A882A9
 for <u-boot@lists.denx.de>; Sun, 28 Apr 2024 16:24:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heesub@gmail.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5aa1bf6cb40so2607019eaf.1
 for <u-boot@lists.denx.de>; Sun, 28 Apr 2024 07:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714314261; x=1714919061; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0TSqizTn1E7xxYKBv06WkdANLy/1PEw+1YF0Au7Xfmc=;
 b=O7+FcbNDDRqLBv/SUnMgivtAv9s7eXUIT3ZTn6+SyHp1gUfJ+fw6a9KxP2mAbNFRIW
 mvaa6XAHzpKcnTzUCGJCVDxEAwU6O9X98Q/YzXU8+ERQ377l1WKXIUWWkkmZ2dUnVPs+
 4vBPwU7irA5lH/winJuMs/BOUUNFmu6gqY0hKOi+XF/bFxGkjCkbTen9KPHRClYMlLty
 8xeotw3Euel6ANVtsoEWB3pkgtXaQPefw/JcwYoFvB/MvcqJxUM3ALpPoDAKESVCJUCy
 XQLedYE3Dp3dJofL7HR6vZRwFb3/R28CkdCbCqdK3NtLrC1dab0AtzfyLqVYD5T3eH+X
 Sa1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714314261; x=1714919061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0TSqizTn1E7xxYKBv06WkdANLy/1PEw+1YF0Au7Xfmc=;
 b=B0gTfoXpfB42GL+NhaHKVM8z0mLtuvG563dn9Qs4sUsijf9lIctELPVtwBo8/V+sA/
 Wo6z6hHOnm7KOW+y5ZNTFep8B/Ko2Z43ZzS0G4DjnYn8omgd0fY3mmmY04Dj8RiTk8GS
 q1znQoglMJFOaK1cS5iqV0V2WxsmyVnsljoHmeURcStJMB5zRdfh/twdUWcOgwEx9yYx
 vtV2eefJqNNf7/Dh+cu9OWFkcLbjf5EtSoDmCN6D97buT/0B4DRlPUITxtoPMA8B1jJJ
 iwyy7fn/yXt6SEIWAaz/9fnj2xnL2r4hlkNbgbtBaoZ4zDmChS4HCkc3HM5ZW51DQpan
 hZpQ==
X-Gm-Message-State: AOJu0YybwzRhqOeaFSJ0Fi8M5NCH6QBJwMoL7Sedcd4fNiSoU9l6vaJj
 t5VG6C054pj4I1fNGnQINfZ0Kq1EOQIk8ssnNIF9q+AxMXKrzfwaqFzgWQ==
X-Google-Smtp-Source: AGHT+IH/iH23T2zPQPVEyOuG3FwiPRy509lqC/R+tdl0i4PZlJbsxy8kJK6YBK/wVDmAwBKsx4sB7w==
X-Received: by 2002:a05:6870:b488:b0:23c:7b1b:dea2 with SMTP id
 y8-20020a056870b48800b0023c7b1bdea2mr1078208oap.58.1714314261591; 
 Sun, 28 Apr 2024 07:24:21 -0700 (PDT)
Received: from heesub-ubuntu.localdomain ([58.229.217.38])
 by smtp.gmail.com with ESMTPSA id
 t3-20020a635343000000b005f077dce0f6sm17568744pgl.31.2024.04.28.07.24.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Apr 2024 07:24:21 -0700 (PDT)
From: Heesub Shin <heesub@gmail.com>
To: u-boot@lists.denx.de
Cc: Heesub Shin <heesub@gmail.com>
Subject: [PATCH 2/5] dts: stm32mp157c-odyssey: use internal clock for Tx
Date: Sun, 28 Apr 2024 23:24:03 +0900
Message-Id: <20240428142406.28445-2-heesub@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240428142406.28445-1-heesub@gmail.com>
References: <20240428142406.28445-1-heesub@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 28 Apr 2024 16:40:40 +0200
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

In Odyssey board, we should use the internal clock from RCC as the
transmit clock, instead of the external clock from ETH_CLK125 pad. This
commit adds a property, st,eth-clk-sel, so that the ETH_CLK_SEL mux
selects ETH_CLK.

Signed-off-by: Heesub Shin <heesub@gmail.com>
---
 arch/arm/dts/stm32mp157c-odyssey.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/dts/stm32mp157c-odyssey.dts b/arch/arm/dts/stm32mp157c-odyssey.dts
index 17bcf56f74..53ba018197 100644
--- a/arch/arm/dts/stm32mp157c-odyssey.dts
+++ b/arch/arm/dts/stm32mp157c-odyssey.dts
@@ -75,6 +75,7 @@
 	phy-mode = "rgmii-id";
 	max-speed = <1000>;
 	phy-handle = <&phy0>;
+	st,ext-phyclk;
 
 	mdio0 {
 		#address-cells = <1>;
-- 
2.34.1

