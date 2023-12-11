Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC30C4332F
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 22:07:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AA4C877DB;
	Mon, 11 Dec 2023 23:07:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="fO4sJm5T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84184877D9; Mon, 11 Dec 2023 23:06:59 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78460877CD
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 23:06:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a1f0616a15bso557760366b.2
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 14:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702332416; x=1702937216;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8kCgG58/2CGYcP5BXXvCFQIN/zvR8qVyaBNkYiWH0cA=;
 b=fO4sJm5TkbOVzXE9k3bw3T2iERAUGgjItbBFBYEcI2RyC8rMdYyai/cJAYcrge8etM
 8A2UHxEnaaMfw0zZW9+ypMARqC4z3iFfh0c3fuoQ65Mu5ke4hDBLQ5mtAij3LxVZpSGq
 39m+3PNa60Hifa7rEOlXzRnhH8lDvISu9oq/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702332416; x=1702937216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8kCgG58/2CGYcP5BXXvCFQIN/zvR8qVyaBNkYiWH0cA=;
 b=XEqosX4CF5GuHp9MYyBcfy/afisVWCwbh5Q9xnZVQ40F0PqyY7xJgYojTML3kShpiS
 mjk/zsa7GZSCF+Lc4mnFchw/9DSZnNdiZ+aXgnEaIylxCuyCuTYDYKh3/CpYnDYpjf+v
 Da/K5Jy1PgX96csLTb6ddqJUsg12bUGiN9q78FN492VaL/dfqQ3djfhQvVCNx4uVpg2I
 FsckGqXW0pd4VEtlGuFuHlC9Ek7hoVxKUp6smsP0Ttbkhz2NT/mdetr8C4NVWYlhqOKY
 VShJMuYvR5TZYS8cMCUNL3PjnMEaWKFZvaKWnm4Xsw6jC6eSSKecY7vk8UONvBEi2eZ/
 kxYg==
X-Gm-Message-State: AOJu0YybpifLnmwqIdHXaVIAYpMSZpfkVNYdgWRbt5Qhv9f1XjLlCz8w
 Sx/JmW0J6px2YdzMWaTLGiK5yFPpHHD+YHWVJs6vVg==
X-Google-Smtp-Source: AGHT+IEREHOM4hTosT3tw4TM39OvOB9OXaDC2Tym6j1JqjFmhtBgOcjOfbLPSXm5xEF1O7+FD76pjQ==
X-Received: by 2002:a17:907:944d:b0:a03:6fd8:f14b with SMTP id
 dl13-20020a170907944d00b00a036fd8f14bmr3416089ejc.28.1702332416666; 
 Mon, 11 Dec 2023 14:06:56 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-82-54-95-129.retail.telecomitalia.it. [82.54.95.129])
 by smtp.gmail.com with ESMTPSA id
 se13-20020a170907a38d00b00a1f78048f08sm4568276ejc.146.2023.12.11.14.06.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 14:06:56 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v3 3/6] ARM: dts: stm32: make the DSI clock usable by the
 clock driver
Date: Mon, 11 Dec 2023 23:05:53 +0100
Message-ID: <20231211220643.1073606-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211220643.1073606-1-dario.binacchi@amarulasolutions.com>
References: <20231211220643.1073606-1-dario.binacchi@amarulasolutions.com>
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

As described in [1], the "clocks" property contains "a phandle to the
clock device node, an index selecting between gated clocks (0) and other
clocks (1), and an index specifying the clock to use." The current version
of the clock driver, unlike the kernel, is currently able to properly
handle nodes with "clocks" properties with an index set to 0.

This patch is preparatory for future developments that require the use
of the DSI clock.

[1] Documentation/devicetree/bindings/clock/st,stm32-rcc.txt
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

---

(no changes since v2)

Changes in v2:
- Add Patrice Chotard's Reviewed-by tag.

 arch/arm/dts/stm32f469-disco-u-boot.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/dts/stm32f469-disco-u-boot.dtsi b/arch/arm/dts/stm32f469-disco-u-boot.dtsi
index dcc70369cd0d..8e781c5a7b23 100644
--- a/arch/arm/dts/stm32f469-disco-u-boot.dtsi
+++ b/arch/arm/dts/stm32f469-disco-u-boot.dtsi
@@ -90,6 +90,11 @@
 	bootph-all;
 };
 
+&dsi {
+	clocks = <&rcc 0 STM32F4_APB2_CLOCK(DSI)>,
+		 <&clk_hse>;
+};
+
 &gpioa {
 	bootph-all;
 };
-- 
2.43.0

