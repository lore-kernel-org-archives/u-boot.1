Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A28C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 21:48:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 360DB86FF4;
	Sat,  4 Nov 2023 22:48:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ExAtMeCQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4700286958; Sat,  4 Nov 2023 22:47:58 +0100 (CET)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1885086FF4
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 22:47:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5841a3ffd50so682795eaf.1
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 14:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699134470; x=1699739270; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=thNHXFDCOy74ASmYjlWVtIHoZT1+RIJPiBm3KcI4ZEk=;
 b=ExAtMeCQeaUWc7Ypj/m/hYWaaRUT942RQVrELE+55h7U+fv3PRjl6wvzUs6TElxRxe
 eQULdcQkxisztqhI87C9nrLiVz3cjZr6AsbVYlvNQyiKrScyCGC3Y76sQOU3Pyu8k5y2
 vweAiCg4iFlMSlvyG6UqNsSw9UfLUIDHip6jZ7R9q2FLiQUm7SYv9zHUElsQmzC7joQh
 Qxdl//DG1532+P97bZyhAupH4LkrMFp7/Njnn3Ys5FokYNBjqv51MRN1QDRBMSZQlDmf
 UMTAROuv2ozL1PjNnM3qgI3VAmxXamyNh1s/od97uyBOILFsGU1CuJsDQH1Kfbw/t4J/
 eYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699134470; x=1699739270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=thNHXFDCOy74ASmYjlWVtIHoZT1+RIJPiBm3KcI4ZEk=;
 b=N/BUm0nRjB1xOE8kV9e5lhrXaJouF71JfuTWdTCS7CZACb3iFCU7eAmcgu4gtaWARS
 RFe2CUvSR89zftCUOxv9l6G/CgY5Sk6ELOYvr5HCgzwYiAer9heLrr9LH3o2KDVw0Epg
 hFRE2NvJbYNt7T6Sd4hraLeV56dgA6srlb+QA9WTw6q3ElQwcMXyd9c8Rs64fWexnDND
 oMuHEpcZ+6DFkZv7MTYlybQ7oSxbcukKxQVrrLIIjNuU5HeepG6tGmucSYwUEPTWurw1
 XqPupDinFZJ/1NEkT01ufyd7k+ktr/evTE6Pf1REub1jdgPkce3fn0vw02hEVztLeK8o
 F+GA==
X-Gm-Message-State: AOJu0YwHuRDans72mex+Jj81s4/r//9c0+txbisig9jdYli1eGFbbkkb
 3MJfo8GKzTgvj9n6YmcDRhm4Y25P0hs=
X-Google-Smtp-Source: AGHT+IFYO8Fb/UFAVC2PxjdeyyxFLj/RAKTv6Oap94V0A7rSNXqEw7oiyu5GkchK40skFTAEDZlDWQ==
X-Received: by 2002:a05:6358:7c13:b0:169:4acc:ec06 with SMTP id
 p19-20020a0563587c1300b001694accec06mr25362196rwf.2.1699134470084; 
 Sat, 04 Nov 2023 14:47:50 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:b4e9:3424:1f72:d6d3])
 by smtp.gmail.com with ESMTPSA id
 w8-20020a814908000000b00583e52232f1sm2462269ywa.112.2023.11.04.14.47.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Nov 2023 14:47:49 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: u-boot@lists.denx.de,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH 2/2] pico-pi-imx6ul: Convert to watchdog driver model
Date: Sat,  4 Nov 2023 18:47:43 -0300
Message-Id: <20231104214743.308722-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231104214743.308722-1-festevam@gmail.com>
References: <20231104214743.308722-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@denx.de>

Commit 68dcbdd594d4 ("ARM: imx: Add weak default reset_cpu()") caused
the 'reset' command in U-Boot to not cause a board reset.
    
Fix it by switching to the watchdog driver model via sysreset, which
is the preferred method for implementing the watchdog reset.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 configs/pico-pi-imx6ul_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/pico-pi-imx6ul_defconfig b/configs/pico-pi-imx6ul_defconfig
index 3af968d55128..604a213e1ea4 100644
--- a/configs/pico-pi-imx6ul_defconfig
+++ b/configs/pico-pi-imx6ul_defconfig
@@ -72,6 +72,8 @@ CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_USB=y
 CONFIG_SPL_USB_HOST=y
 CONFIG_USB_MAX_CONTROLLER_COUNT=2
@@ -82,3 +84,4 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x0525
 CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
 CONFIG_CI_UDC=y
 CONFIG_SPL_USB_SDP_SUPPORT=y
+CONFIG_IMX_WATCHDOG=y
-- 
2.34.1

