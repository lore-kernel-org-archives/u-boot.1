Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF219CD5BB1
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 14:47:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B690F848F5;
	Tue, 26 May 2026 16:47:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="umP7gGr6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02511848F5; Tue, 26 May 2026 16:47:23 +0200 (CEST)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C729C846A5
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 16:47:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=guodong@riscstar.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2be75f658f3so54623715ad.1
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 07:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1779806839; x=1780411639;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JaNegvWpQcfZpX+cVGIv3kBQRVg0+VXYPMQyPAaBBq4=;
 b=umP7gGr6ra7sMj/F8ALx7PFUNKmNnEwjrpMJ3vfn6XCHNSgabsTDuFNM0ka2kxZ2SZ
 4CUWL9Auq3Izmq6momP4Ypg/TivOoFqNzzl8rvZVKvJEFNiu5kD6ANAka631Yy9BXH7D
 1XGiNQzDvsdXuCl1Cv+voOI8cU1u71UCCS997EOrzEuaMkuuh/GtgWgtvAK4Hwp7hjq2
 l+rAyfF9+W7XcXrtOLUbnrX4fjnMYeCDe2/kkz6/jaIThupHIjzMxQ0ushQsrmmKfrVy
 MbkrRWJNT+1zhT8TQVJwprcIaKqUNGFsmFlr4Eas2hUGbJi6BYxViDJsn4CmrJO6IfqV
 o4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779806839; x=1780411639;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JaNegvWpQcfZpX+cVGIv3kBQRVg0+VXYPMQyPAaBBq4=;
 b=WkEXqIHNnbLM9H/C+km9DGgAZ2bsjJfPvP+pWOXgU2nMQ1CRGO23AVSbnkdUjES17N
 XBqwE464ZLf6Z+HAYTcm4/7czlSwRNV5qVd+8dt+Ts+BxdmJdagxKKeIbgQOeBOQzMQ6
 C9OoRMIJzeJIJD60aJfMa7BPsK1vvCN+wx2/HpX4QcmiAOGqT6RUctJwDzqU8nuXjUn2
 sg1zGftIokTATLiN6fIl51hcKzHJnN0yCnyR/TUfLjKtgJ7VeaRr0SlRknJHgrMBdJ4V
 AxMUZiET0UrOw9n8yQwc+thrng11VFoWPmhNgQ7LX/BjRcYARCYApwYTUaoMKwGzOHgv
 wcVA==
X-Gm-Message-State: AOJu0YxTk21iMQvUuqNPV0/plEb7D553k1Ui/BxBeqZ7St5mlhvDL/kh
 ubIuBEOgMmNEi86NxG94rz53x5dPy+nPpFR4IL5i16L9rb+Ydmrwz2uHFxdULzpEpKA=
X-Gm-Gg: Acq92OHgJUefxmL7I0NR7Mqmz1xqEGQgA/anan3Dv4LmQF5Yhimz7ksAuL4BsMOUSvW
 wDZNZlB7ceO/VW2sf6bAgeEIlNfEFeow878OVweZKmVY0fCVnViLFmq3AyaRi1qj09HbFC/e96a
 u9HVfQQY4ddBlWVmmPBj4P3xB7wnYba70jJA7XtA3wakVfkZXdxtU+hukk2DX8aMRwSQRrlNFUQ
 vOr8iYN7uosp6yJlPkfNiYUV042+I+JgcJxQSEjKiPwhalMSSQQWsnZRXXoEOYF5Leh2ArFHj+6
 aSwJsqVpXXjtPHu6448+tJ15JfPtY5s0dkYkbZxx0WudH5WwjQAWzFMh/XVadc/J30yLLmzoLPd
 lhGEEw6jFCEB4SYQn3Zr1L8p22S0CljvrvQf845B0QimZxp8BxxeJtJIch+p188H76Av6zE20vq
 88hQr1FA4k/Ba6FbWBiIMvUl4bXiEXCNp1ruGLVUsEAfs=
X-Received: by 2002:a17:902:f552:b0:2be:1c3c:72ba with SMTP id
 d9443c01a7336-2beb0794f96mr211665565ad.32.1779806839325; 
 Tue, 26 May 2026 07:47:19 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::40e3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb56f4343sm169559915ad.36.2026.05.26.07.47.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:47:19 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Tue, 26 May 2026 22:45:44 -0400
Subject: [PATCH v2 4/8] configs: bananapi-f3: enable Spacemit K1 clock driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-b4-k1-clk-reset-upstream-dts-v2-4-af815e362b0c@riscstar.com>
References: <20260526-b4-k1-clk-reset-upstream-dts-v2-0-af815e362b0c@riscstar.com>
In-Reply-To: <20260526-b4-k1-clk-reset-upstream-dts-v2-0-af815e362b0c@riscstar.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Yao Zi <me@ziyao.cc>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Peter Korsgaard <peter@korsgaard.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Finley Xiao <finley.xiao@rock-chips.com>, Rick Chen <rick@andestech.com>, 
 Conor Dooley <conor.dooley@microchip.com>, u-boot-spacemit@groups.io, 
 Vincent Legoll <legoll@online.fr>, Guodong Xu <docularxu@outlook.com>, 
 Guodong Xu <guodong@riscstar.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.15.1
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

Enable CLK_SPACEMIT and CLK_SPACEMIT_K1 to compile in the K1
per-syscon clock drivers.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v2: No change.
---
 configs/bananapi-f3_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/bananapi-f3_defconfig b/configs/bananapi-f3_defconfig
index a726ce84775..9f9424adc9f 100644
--- a/configs/bananapi-f3_defconfig
+++ b/configs/bananapi-f3_defconfig
@@ -17,6 +17,8 @@ CONFIG_SYS_PBSIZE=276
 # CONFIG_BOARD_INIT is not set
 CONFIG_HUSH_PARSER=y
 CONFIG_ENV_OVERWRITE=y
+CONFIG_CLK_SPACEMIT=y
+CONFIG_CLK_SPACEMIT_K1=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_RESET_SPACEMIT_K1=y

-- 
2.43.0

