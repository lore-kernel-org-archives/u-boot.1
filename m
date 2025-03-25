Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AFEEC36005
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 02:56:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7195819B1;
	Tue, 25 Mar 2025 03:55:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="af92Di0+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6775A80F70; Tue, 25 Mar 2025 03:55:22 +0100 (CET)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44EF281CAF
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 03:55:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-47691d82bfbso101778541cf.0
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 19:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742871319; x=1743476119; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sir0FUv0xPJ+DDY9BCOswbpmFgvsHYbytgH2UQU40h8=;
 b=af92Di0+j5vsxojPRsTcXVzxUCu3qBU2+WstZEWvcYXpFvWeZQ7OjRiIZ8cPpO/gIA
 qxrmeLxQGOpJi7CEmfcoyCijSvvc1Q+5ZhHZGT9H1RnLEEnMUm47xKIVgXeWc+R0iquc
 AayLXgj/18zaqDhmTLU3UUrcsndX5eekCdqdCuJE3xdY03Mk1g8kFK7+ACec53W4KNK+
 uBgoor70/kRotuMKtWwvAjwC7m6iiG/uWbTltUmQrX5dHmYyoYOAd1vWnI6kH8vhBp/b
 Ez1xrOjbeFuni2P42gJeWcLmlNG8EgdZxFTqsZjY5fof4nqL0OOzyWZrOWb/Z6QU8+vV
 6YsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742871319; x=1743476119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sir0FUv0xPJ+DDY9BCOswbpmFgvsHYbytgH2UQU40h8=;
 b=nKh/XKTGACVyJu9imCSsGk0m4enE5jdaZquEcjwdiTEEAUbWLcDMBmu2HAf8MohJtW
 I783y2+puVdHkxF6pZMNgljogy3q+VRz7z8NDUNXl8knzBB23cdgAE+sdd30W1BJUN6i
 0UTvZ5JcJ4DLkbd0J+qWzXHqjCRC9LDG7rkk7HV6UIpCw5WxGebmhhu6YazY08dcMnuh
 5wSILbKN540VbpJwu8R7pQDSQ97CLalUQ1PwHfhtyqUSOv1BPFaY1V6CRhBegdx7/Tku
 mrdQ6ImhazMJqLRTyT7OK77JuFclq4+iFmazyY/s+kySnsaX45kEM3U3EOay9JLoaVxs
 nBpQ==
X-Gm-Message-State: AOJu0Yy46Mmkszmdn+Bg869RMYSTvxTnMNoComxhy4PxHhf1N32uPgTW
 kqIgcT+forG++cQwLGyh/RoKRIWcEk/pcWadeU5GxdwnG4a8uOV8ABX5zg==
X-Gm-Gg: ASbGncvmXwhSrOJ7xtFa+40GC/52A8iprnqdO/Rtx2PHX9sbp5GQ358D5OXMVCiXKDy
 UTuYtMU4EswNDtQpooUGmynd4tkHierw13qCkdQjkYFiAXc1+/CC8lGRzJyNNaiXBLj0WBPrbrD
 k8BjT0oYFTBvPFYZKRR9gpo8JsvzrbLL5pA3Ea4sIzuoI5qVe+ZrG6LY394/Oq/tu+xfWue+VXK
 9tN8cvxkRN48z3U60jHuLHPo3afRxMq2zDJFh3HrsCVdaEuvHWSgIlFMuVApvgTv29RnyPXrXRk
 BWqzK4KKI1G9tC7SLUtJ0GFPo4OuPZynsG1yHITP2jPzNXA0OoQ5Be7YbGlLK7/N9+JmaU2qMMP
 VYDdC7NJwh6HIkb3xvDzxpcec2kI3Sg==
X-Google-Smtp-Source: AGHT+IEzm5FVyoe78aTpPqgZx8nCpF1jxBa4paeVbtHS9F26xCIdJcrTA/zMv0uQ0VmoJmOwoYd98w==
X-Received: by 2002:a05:622a:1f07:b0:476:af21:9d4b with SMTP id
 d75a77b69052e-4771de48d66mr235107511cf.37.1742871318795; 
 Mon, 24 Mar 2025 19:55:18 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4771d176113sm54712021cf.17.2025.03.24.19.55.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 19:55:18 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, festevam@gmail.com, marek.vasut@mailbox.org,
 Adam Ford <aford173@gmail.com>, Stefano Babic <sbabic@denx.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Enrico Leto <enrico.leto@siemens.com>, Heiko Schocher <hs@denx.de>,
 Peng Fan <peng.fan@nxp.com>, Yannic Moog <y.moog@phytec.de>,
 Sumit Garg <sumit.garg@kernel.org>, Gilles Talis <gilles.talis@gmail.com>,
 Patrick Barsanti <patrick.barsanti@amarulasolutions.com>,
 Ye Li <ye.li@nxp.com>, Christoph Stoidner <c.stoidner@phytec.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH V4 6/7] imx: imx8: Imply CPU_IMX by default
Date: Mon, 24 Mar 2025 21:54:47 -0500
Message-ID: <20250325025452.950303-7-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250325025452.950303-1-aford173@gmail.com>
References: <20250325025452.950303-1-aford173@gmail.com>
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

The imx8_cpu driver is a CPU Driver that supports the i.MX8Q
family. When it is enabled, it acts as an alternative to
arch/arm/mach-imx/cpu.c, but the imx8_cpu supports the driver
model where cpu.c does not.  Imply this newer driver by default.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 arch/arm/mach-imx/imx8/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-imx/imx8/Kconfig b/arch/arm/mach-imx/imx8/Kconfig
index 9a43beda6fa..257c14e61b6 100644
--- a/arch/arm/mach-imx/imx8/Kconfig
+++ b/arch/arm/mach-imx/imx8/Kconfig
@@ -9,6 +9,8 @@ config AHAB_BOOT
 config IMX8
 	bool
 	select HAS_CAAM
+	imply CPU
+	imply CPU_IMX
 
 config MU_BASE_SPL
 	hex "MU base address used in SPL"
-- 
2.45.2

