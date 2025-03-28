Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A92E9C36011
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 15:39:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B562282033;
	Fri, 28 Mar 2025 16:36:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kr2J4qs4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F6FE809A5; Fri, 28 Mar 2025 16:36:33 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BE1F820B7
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:36:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3d4496a34cdso8330635ab.1
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 08:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743176189; x=1743780989; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XmSxKOHlRMcnTtY1R/VUdHG6Qkw+nbjndHwZP+FBuHQ=;
 b=kr2J4qs4JtlnKrE1o0XzfrFd2/ZIkNGzY/E9mCRCJHimqFJcUbY04Ujy9NHy1p76F0
 lPm/Eu8YrMrClKlLxe/rDZNL6XuIloXC1TbegUsv/BHUdDTDs51ni47JUIiQSBi4JwWz
 saWTCfVVJ9kHRN1zKSdC+atNg6EzwdRsB8H6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743176189; x=1743780989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XmSxKOHlRMcnTtY1R/VUdHG6Qkw+nbjndHwZP+FBuHQ=;
 b=Df7ZgJeh5t0RG50IT08ezh1lDtd+CPesgD8HP6CwdEJPo1gm61psgRGz+y9Z3L3wq0
 d/EaMDa9jPoBeq57p3S0i+ZUnVIsWDyOen1uuk7C7Mw3Wd3tg6PzW9CGL/Vv0Mm0LvVE
 BpWTAdzk9X7S6Gh6vsV0VKLxVbi5hzvCsbwEpfawtwzPonGKvTCTrxOgqEJMXMG+EpDR
 V99Ys8MAB5DfwsrGFxtTsqh+XyiXdrSqMT3BIixojDo05ACapjEtH9N4akoSYy73HNnV
 4BfqxzJQ2yFw6721fmWJOqf8ib/LqMIzMJBvhGxHpQgL7GE4Fg85voiEzRLhZx7I9Vdz
 hUbw==
X-Gm-Message-State: AOJu0Yy2syOvcEEFeTWlJLGA72d0d+E6TGHqUiFQZdMTumwRP6fZDK3K
 JP/7/V7KnzPWoKrj9LliG92muCSv18cpaf2GYcSLi3t/fY82UJcU+TuzhOaKVVKwOze8P9nwU8E
 =
X-Gm-Gg: ASbGncunyrdaC+g8t6T1Y8LtaIvnOKFqR59pTsN4oF4KaMUg62B37P0INbNjXdbsuqv
 f6/3DNYMzc/KPY2jPUJ+/q555h1waQBxOTot6Z3hyLMcv0ArGoXkI+dkr8cI+jcxmHiMrK1ov/x
 rvpY/DAdo88XWMZVhHEw8JMpEaNpBwHXjJZwlXB0jsFqoEc6TFOg4uHKsO0Z2/hB8/w7RTdkFwZ
 3m/Q9cQRvb9VbMahKWh77A0i9mBL6CoGbCc+uRy5C36Du/I4j3pZmMOGZOUmsmifNEBDCyLOeh8
 fsT4O8i6kfm/+Zo0wtxpgCdv77tXQvtZoZmiziH0l5foWRXqdQmEBtWzJnbcp49KF9iAY767YEv
 U5Bhy/Q==
X-Google-Smtp-Source: AGHT+IEILmGPQhT1mEZVJ6WGyYgT1x6cBhqf4mkcyFgg78H+BUJzwFBuyCwKZ8zN+EQpy7zawYWTeg==
X-Received: by 2002:a92:ca4d:0:b0:3d3:e284:afbb with SMTP id
 e9e14a558f8ab-3d5ccdd4460mr82271215ab.11.1743176189176; 
 Fri, 28 Mar 2025 08:36:29 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f4648714b4sm484922173.87.2025.03.28.08.36.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 08:36:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Chris Morgan <macromorgan@hotmail.com>,
 Heiko Stuebner <heiko@sntech.de>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sebastian Kropatsch <seb-dev@mail.de>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v3 24/31] rockchip: Add documentation for VBE
Date: Fri, 28 Mar 2025 09:35:04 -0600
Message-ID: <20250328153522.3555472-25-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328153522.3555472-1-sjg@chromium.org>
References: <20250328153522.3555472-1-sjg@chromium.org>
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

Now that VBE is running at a basic level on rk3399, add mention of it in
the documentation.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 doc/board/rockchip/rockchip.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 1407080f1f4..73d7c7de923 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -490,6 +490,19 @@ config-flash.ini:
         [OUTPUT]
         PATH=RK30xxLoader_uboot.bin
 
+Verified Boot for Embedded (VBE)
+--------------------------------
+
+VBE is supported on rk3399 at present, with SDRAM being set up in SPL. The full
+A/B/recovery flow is supported in U-Boot.
+
+To build this, use the rk3399-generic board, setting CONFIG_OF_LIST to the list
+of boards you want to support. All boards must use the same SDRAM type.
+
+VBE uses internal SRAM (IRAM) for the TPL, VPL and early SPL phases. The stack
+stop is near the top of this (0xff8eff00) with the 256-byte bloblist immediately
+following.
+
 TODO
 ----
 
-- 
2.43.0

