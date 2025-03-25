Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 432D8C36002
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 02:55:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DC938186D;
	Tue, 25 Mar 2025 03:55:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OnDaa65x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 629E081D0B; Tue, 25 Mar 2025 03:55:20 +0100 (CET)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E82A81D25
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 03:55:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-47690a4ec97so52599251cf.2
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 19:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742871316; x=1743476116; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nUaglnnKg0z1MG72J0K0/SqHkd5mYMgY1w+MP2l0n3o=;
 b=OnDaa65xxesYaOhSo/8bWTCrRJlzSlzh3mnZBeGo0YkfAGaLYjp1t/i/KC31Uzb7Wp
 V1vzF00O0OgLVfR0TVg+VxXwGcl0uCl0sOoUqX7ZrQBZPKCLYpMNHcuPvEWs2uUoM/a9
 7Nln4jgOiXSOWcVdlXwZ3Peeah/RZ0m+nZVy8S0rnKbfQc+dBSyinjndLHKbQx35o+HI
 S7DdC6tuGdWqbVmW+H7STDkgItM8kNrKz18YyVN8MK9mgAIl9bteTJHJu9oaI0UQLIbG
 OP0H7sCUjML0G/8xcebQZjCQ730mht23obqIlqeweeFMFCp0jjS9cSONiQIDRFDWZTQ4
 2V9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742871316; x=1743476116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nUaglnnKg0z1MG72J0K0/SqHkd5mYMgY1w+MP2l0n3o=;
 b=qVJ4zDSjXzKjIXICb+8jQBLVv3LBQdQopy2eY1g47+kbp6qwyHddUbABYhgwPEqL+w
 Sw4/BVEuHiMdNtF5YfaQv9AFwXJ16CRRy1DArr4xGbZbfzkUcW9xO6g+1kcoZ0yUFbmZ
 7Aj4psJu+aRG9diDkUypEGSD9Sgb97WjH0aQi7jkNFMmRTmAw3jsgg7RAcXvku6dQLGe
 dd0CMx4oX/splX9fSFr65E1BAqO6TEYi3/IAXL1p3UmbY4sZBE1q4pNgDcJZn3gI5vcI
 gJBGKB4XXINRQO/dyGnbAcT64JdpRC2tFDhepmGj8lGqVK/ctDAU/qaWWqI9TwKRlALw
 JFMQ==
X-Gm-Message-State: AOJu0YzaB/Ol2H+oXZX4qEU/Krx41dBO1tstw0q8aB1xWGnAej+mrmlM
 6SLiTvKLWLHx1W0wWeY+/52bliJV6SKx+MHMSHNHXNjTy9xl9FIWaloiOA==
X-Gm-Gg: ASbGncu1hHK8md8MKdHUll5FWJzZhib1DPXH5EwD8fkB++Z3cYDukEEfs1u2LdkHGny
 24SUH1PDVxKUaRbKngkfk8GjwuDdLd6BPoo0Cabq4AH6thP7mgecNTevbFt8MNc1zQYLQjVL+YI
 9nj21lcrgAua5LfJmIKQqzq5HBOEsFOqxhsSHOravKa/sC4zy2y7ki1ULHLyBAI1fMJLTkd/ety
 Kdf04Yb3TiLaq9iEdjmUAbgoEMn4+7UFI8RuevmeYzHGRuwWqB0uGIKC2W4k4XxfCJl1HOjcF8k
 zghWyqHe+pijWCh+QMHsdGvf/p7ic37h8dm3amae20GiUx7ZNdrwEmxBqnNRbxcXpDhCIh6a88P
 pfhqKoFbcZ31O3LSccmg=
X-Google-Smtp-Source: AGHT+IHjahHSz6XfjE0eoINrvCp/QPd+e4+fInoJ7CGvZoWFP242QEh+sRZyOvm9H2RCtQ52VzYzJg==
X-Received: by 2002:a05:622a:4cc8:b0:477:ca3:4b66 with SMTP id
 d75a77b69052e-4771dd8037amr241506631cf.12.1742871316344; 
 Mon, 24 Mar 2025 19:55:16 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4771d176113sm54712021cf.17.2025.03.24.19.55.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 19:55:15 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, festevam@gmail.com, marek.vasut@mailbox.org,
 Adam Ford <aford173@gmail.com>, Stefano Babic <sbabic@denx.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Enrico Leto <enrico.leto@siemens.com>, Heiko Schocher <hs@denx.de>,
 Peng Fan <peng.fan@nxp.com>, Yannic Moog <y.moog@phytec.de>,
 Teresa Remmet <t.remmet@phytec.de>, Gilles Talis <gilles.talis@gmail.com>,
 Patrick Barsanti <patrick.barsanti@amarulasolutions.com>,
 Ye Li <ye.li@nxp.com>, Wadim Egorov <w.egorov@phytec.de>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH V4 5/7] imx: imx8m: Imply CPU_IMX by default
Date: Mon, 24 Mar 2025 21:54:46 -0500
Message-ID: <20250325025452.950303-6-aford173@gmail.com>
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

The imx8_cpu driver is a CPU Driver that supports the i.MX8M
family, and when it is enabled, it acts as an alternative to
arch/arm/mach-imx/cpu.c, but the imx8_cpu supports the driver
model where cpu.c does not.  Imply this newer driver by default.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 arch/arm/mach-imx/imx8m/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index 8ee699a343c..31f2f003d35 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -8,6 +8,8 @@ config IMX8M
 	select LTO
 	select ROM_UNIFIED_SECTIONS
 	select ARMV8_CRYPTO
+	imply CPU
+	imply CPU_IMX
 	imply IMX_TMU
 
 config IMX8MQ
-- 
2.45.2

