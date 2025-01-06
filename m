Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612E9E77198
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 14:36:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52C73806D3;
	Mon,  6 Jan 2025 15:33:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I0gASC+G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5F96805E1; Mon,  6 Jan 2025 15:33:41 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CC7880710
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 15:33:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3cdd57060acso8496745ab.0
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 06:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736174017; x=1736778817; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QTq4Nu1nLU0aRkZgwhT9OHzhV9lx2DuJeDupSO7iZJs=;
 b=I0gASC+GLhAqvILQDAwcBWHsI1PX4OzfvGUbqs3gbYJm+E99HKSvA5bjb2BeSiw6Ci
 KmVHq8WsLvUT7X1VyC5Y+HrEGTL45rRlxn6RvZ4Ei43ysddX0fCXgw+y5C/MiX7H1en6
 thTSMjKYRKB7ip2ArzXIP/iI0R89hvRnvbp7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736174017; x=1736778817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QTq4Nu1nLU0aRkZgwhT9OHzhV9lx2DuJeDupSO7iZJs=;
 b=dj9f5897scdhjCkOhsMxrsRwfDmfwrqtfhYGUeXkjxuMYthg46SwubZbyGQ05qUZo8
 wkvxaDikkHKIKbMVVYfgtnfsp6Snta6QxvtNh5ZPOQTXVLwWnKXYV5xGbpDEnaPt2BIV
 25r8+YojiSWzpJMyXwMyzZOPY3GXANQ1qXBayk1GoV+OS+RBUHc2j0t4ClZB8CEKZOVd
 jXqLu09kAgHMVPdjDHSMB+HqXbdzu767j0434Eu/XTw7eE9V+X2oYpQN97Ekmj3fEs+H
 ckFcSN5laECYaKl2k4jnwEtEP0EJMn7ZktkpEjf63E3BhD98fg1/21Cp8jwVTVC2kN+I
 E85g==
X-Gm-Message-State: AOJu0YzryKOOZD8x67/yUUNt7eO0jAOxvuQDTq3q5CYjtJLZyPkDGg9p
 TCVaE76eeEWChz2JVSD5YDRens+ILWAYX8s7Yu87nKQv2pTo8mRVriDbQ422Jcv0+/nZGMEI8U0
 =
X-Gm-Gg: ASbGncu5OwxzqJ6sfQBIL2ZDeSkkL96WWJ/LAkxYfZAXQrnsR4G+ajReCE/joTtCCEZ
 EFVcz8VWak/JLcyYOlEMq8RVT6wN57Bm3sfHwDoiI3uqiCotskBG0VUrklho8drYfQbr7aSO6Ma
 G3EHFCMTB67Ka1OAVNMSIhGWKABUCdjTdhW7nJIrRiBo+Fh93xXtd2c0fLikC5rb24Kf1+xvgFO
 Rh+ygMNKfILD6IhMKYSfKVTm3X9CwFGBYo42NmbVdni8l2HCyR+22P03PuDNVfQfKFPQi3dCT9N
 duQQZEJSjvCn8hkTYQ==
X-Google-Smtp-Source: AGHT+IFkJelnYjzaicf24x1j53GFbedZQvAWIYMJwWBCxTTvxdYA6wh9wAWQjBCKfdYY6hljnwVKtg==
X-Received: by 2002:a05:6e02:1fcb:b0:3a7:dec1:de55 with SMTP id
 e9e14a558f8ab-3c2d59199dcmr338344995ab.22.1736174017623; 
 Mon, 06 Jan 2025 06:33:37 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c0e47d6ef2sm97200805ab.78.2025.01.06.06.33.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 06:33:35 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>,
 =?UTF-8?q?Marek=20Moj=C3=ADk?= <marek.mojik@nic.cz>,
 Marek Vasut <marex@denx.de>, Raymond Mao <raymond.mao@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 21/33] emulation: fdt: Relax condition for
 OF_HAS_PRIOR_STAGE
Date: Mon,  6 Jan 2025 07:32:17 -0700
Message-Id: <20250106143229.3023771-22-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250106143229.3023771-1-sjg@chromium.org>
References: <20250106143229.3023771-1-sjg@chromium.org>
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

QEMU always gets its devicetree from the OF_BOARD mechanism so we should
not depend on !BLOBLIST here.

The logic of PRIOR_STAGE is quite a mess, unfortuantely. We should rely
only standard passage to receive things from the prior stage. QEMU
should implement standard passage to provide its devicetree to U-Boot
However Linaro has blocked my patch to provide devicetree additions[1],
so little breath should be held in respect of either change.

[1] https://lore.kernel.org/qemu-devel/20210926183410.256484-1-sjg@chromium.org/

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: 2b71470628c dts: OF_HAS_PRIOR_STAGE should depend on !BLOBLIST
---

(no changes since v1)

 dts/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dts/Kconfig b/dts/Kconfig
index 41a758e83a6..fc25a854708 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -191,7 +191,7 @@ config OF_BOARD
 
 config OF_HAS_PRIOR_STAGE
 	bool
-	depends on !BLOBLIST
+	depends on !BLOBLIST || ARCH_QEMU
 	help
 	  Indicates that a prior stage of the firmware (before U-Boot proper)
 	  makes use of device tree and this board normally boots with that prior
-- 
2.34.1

