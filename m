Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67ACDC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 15:36:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D74EF81F66;
	Fri, 28 Mar 2025 16:36:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FukOyehM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B593881F54; Fri, 28 Mar 2025 16:35:59 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 579DB809A5
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:35:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-85b4277d03fso78280939f.1
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 08:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743176155; x=1743780955; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vKiPpuow+i6VQZ5nOVplprgx7RjxO6Q/4o//r5vYFnc=;
 b=FukOyehMTps+qvZAb0YrwzHAf5fwP2W00xctSHCxpy7YTAim6oObnqsmzEO18bqsoq
 nvJTdPeYn/lIdBn2A3wSD7n6Qn2/0yt3d0qxqp7jM/+/yH3hsbXKJdai1CcAlNbGlJju
 4X9H0gyqaOtaCAvM1d8JHqWbLJj9iNA59aaOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743176155; x=1743780955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vKiPpuow+i6VQZ5nOVplprgx7RjxO6Q/4o//r5vYFnc=;
 b=CYh3xaJgg25Ml3741D4gzqdm1hvzTUcO2MZM5dF1P+OJeg6r3cHTDh3CQPNrBRza0b
 afo7cbuo75ZzWdgjw8crtsbFyD02ZHLRbwAEcVOjuJ9pgwW1Q/FoUIH+GlgZl1NBEKo1
 CoNb/q/86Id3xKKqgGtKk8P4I8pZvFoZflwbaGuDSdlkPzWqOwyBrqSiqi4PhekhNAKm
 4aZOSgnqpUYegBf28xho0WfkdC2dPpAtVaIK+apn3ZopZCFE9LBcV4zuA/SZoeAa1Vic
 sALTkfyBZQBmt7AP2pI/svvXpwPRwFZ0zzK54i7ptk65WSqxm4320vhrnkab93EWJ0WM
 XsyQ==
X-Gm-Message-State: AOJu0YxRz0Ml9Qll6XDA/1hPxjnXWHpTfvWRMNLt7K1S94AXUNTaGRJb
 drTPdaec7dw1AaaIhKyUp+WFN9RaLiknNNUi1Sq+xOFE0bcG+CkZTzDoj3V7T6ElAZOkPiMe6UI
 =
X-Gm-Gg: ASbGnctma7wuoPQTp5TZXiOJWNPW3js9GxAzEn2VGKB2qMESFJRDpqFpwXJZdiD3s7a
 +JzXHsMSlHBWRJT747+2UYMjfED3hYmvZb4ZlmFA+w5TjIN1WGcad/tTm9K9P0hZbJ/uR3zh6x9
 5d65eisrBAsQgY5/lA4SXm5cxZk7d66SGTsSy4TDsJHln93j67orjPAI1RSNIBFa41JZlAXx7f2
 ZICyI5X7mPQ1ArrhjOyLM/JlFRqV26WpbskocBYJOkmBXQ7MG0JXC6eAgUak6zkszkLP3gXa2na
 qEAv6YDtF5wxqYbzX5uoe36jvCR0ceaBXrvdYIhZ2+cZ6jYh09vW2kltVsHv9/wxg/waYcOxqJs
 ehjyYuNZvH0cujbJx
X-Google-Smtp-Source: AGHT+IHXWgwXNXKEsKgP8hv1JQzl3gu4cnErtlcvHccXAPjbT8ETeDnL0CXzz/rItmW/fU2pmzNd2g==
X-Received: by 2002:a05:6602:380a:b0:85b:37eb:f466 with SMTP id
 ca18e2360f4ac-85e820550camr893763639f.1.1743176155274; 
 Fri, 28 Mar 2025 08:35:55 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f4648714b4sm484922173.87.2025.03.28.08.35.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 08:35:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v3 07/31] rockchip: dts: Add an fdtmap
Date: Fri, 28 Mar 2025 09:34:47 -0600
Message-ID: <20250328153522.3555472-8-sjg@chromium.org>
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

Add an fdtmap so it is possible to look at the image with 'binman ls'.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
---

Changes in v3:
- Add blank lines before the node

 arch/arm/dts/rockchip-u-boot.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index 2b01dc66056..8aea2e6f571 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -170,6 +170,9 @@
 			offset = <CONFIG_SPL_PAD_TO>;
 		};
 #endif
+
+		fdtmap {
+		};
 	};
 
 #ifdef CONFIG_ROCKCHIP_SPI_IMAGE
@@ -203,6 +206,9 @@
 			/* Sync with u-boot,spl-payload-offset if present */
 			offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
 		};
+
+		fdtmap {
+		};
 	};
 #endif /* CONFIG_ROCKCHIP_SPI_IMAGE */
 };
-- 
2.43.0

