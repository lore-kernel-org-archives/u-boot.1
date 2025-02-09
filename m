Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74243C0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 21:16:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95C7B809D4;
	Sun,  9 Feb 2025 22:15:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NuEXdHrZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E06F080A0A; Sun,  9 Feb 2025 22:15:52 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B650D80C83
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 22:15:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-85521efa9b5so9324039f.3
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 13:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739135748; x=1739740548; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bq1M2tORHPW8NglIv7u2HSOnXlP7PisA3YyWOD5zsPc=;
 b=NuEXdHrZrR9QWj2G3jhwOfJwQha5SSLt4BHLWwQohIaqXOs8UJzn80D0KU7ISBi4X4
 9eyISrgHqlgAL4/oJbVoWaS+D9Bm3tNpCRWDePC8M/P7Y2ke10DSB9mGLUbIi+rDry08
 Xd7F9BfF271cBxcRxLMLEZvlKkrf5eUEd9Eds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739135748; x=1739740548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bq1M2tORHPW8NglIv7u2HSOnXlP7PisA3YyWOD5zsPc=;
 b=r0fJ6+w8isGzUod22x4Pk31C34kQuJtAHLtHvdtbUPztqFnk7G0THbvQ9/Gt67j5qJ
 A5vFWNiWcrKPUkhnRBBzpPve6C+s79uEIiUktC3sPsFweUjfGHAQ6ldjxLOraPxhlj45
 8B7nSSHbk3Qly2Wts59ExT5qGo4wtd/3xogyx93Z/HWbv4TtfNpNt4Y9jave35sbCZMw
 rAbnV4QudkBfRWAi95ET3DR7C/ZikG/nN++ZomOVf3KM2UQEAxecn39n7XhXvy4uqzdL
 m2y7vFjO7490vNLwfiHuIqXuOWbPxkXMEuoi4/3pOMr4PCiQtU0z+eeHXbW5hO37OppY
 J35g==
X-Gm-Message-State: AOJu0YwT8OMowjTF9AZuJyqQKS1785lRyehN3Bm6umypjRl2PNtDeYhQ
 59tbNJ7J120g6i7JShxY3BieTjqaf/6VmpuwoH6g/lf2hSqODHLCJi7+hsanwzJUnUQtpwZuOcQ
 =
X-Gm-Gg: ASbGncuEy6mAq9pmhHjQFbTzLKmQ9ly4AmusIn7hbUrNfmIgyoxaKvkVRXmw7RD/yZf
 poCmTrdloXCge/fSHLWfNKlUCyBgfm7gBpUrniILdTgrbVxTyd8zOzgLKJszrldUFAfN1EkU9c1
 8G/D0a/YmB2D/CPOvbwnQ8lw+gvO+/5eSaKatx2m3lAMaJK2AuhjKxFppqfveLDzJBHO/xwlAbm
 ++dQDn5+18m+qajOcwPCQ/eQpb/hQQb8wJ9UOs/pcCb61oPCT6vyzsvawiVqQknr55dRlhNGZ7H
 2F0w3qyUzLDk22qNvTF8TMD2rQyuvwvNk8wtfUTlRypaIE06zQLX
X-Google-Smtp-Source: AGHT+IHGFXES1+x1KIOescnVYJiz0urSNTb3D3Hq91rDcEJwl8VWwqr1kSnWn7L/a02yNU8Z9ebr8Q==
X-Received: by 2002:a05:6e02:218d:b0:3d0:27f5:1b6c with SMTP id
 e9e14a558f8ab-3d13deeb34emr66057005ab.14.1739135748550; 
 Sun, 09 Feb 2025 13:15:48 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d05e96f245sm18978655ab.51.2025.02.09.13.15.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 13:15:47 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v2 11/35] rockchip: dts: Add an fdtmap
Date: Sun,  9 Feb 2025 14:14:32 -0700
Message-ID: <20250209211502.2299245-12-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209211502.2299245-1-sjg@chromium.org>
References: <20250209211502.2299245-1-sjg@chromium.org>
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

Add an fdtmap so it is possible to look at the image with 'binman ls'.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/dts/rockchip-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index 2b01dc66056..64a6b57d5fd 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -170,6 +170,8 @@
 			offset = <CONFIG_SPL_PAD_TO>;
 		};
 #endif
+		fdtmap {
+		};
 	};
 
 #ifdef CONFIG_ROCKCHIP_SPI_IMAGE
@@ -203,6 +205,8 @@
 			/* Sync with u-boot,spl-payload-offset if present */
 			offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
 		};
+		fdtmap {
+		};
 	};
 #endif /* CONFIG_ROCKCHIP_SPI_IMAGE */
 };
-- 
2.43.0

