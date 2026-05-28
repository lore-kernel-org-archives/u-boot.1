Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA5DCD4F54
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 17:11:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87776846F4;
	Thu, 28 May 2026 19:11:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hSwpCf7U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E7BF846E6; Thu, 28 May 2026 19:11:09 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB100846E6
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 19:11:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7de46b8e432so11469498a34.1
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 10:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779988266; x=1780593066; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2pusd8LtiJk86xviuHO8XXo2W8I1zdC6p+B80Iarjwc=;
 b=hSwpCf7UE8yh56fLrXLoAhsAMQyMMlX5hwW/3ro+7CW77EQkQ8LcrONNC5zxmZ2GT6
 bGwJ4G8jLhSYZj8odCXe9hyWCuASjllAOqr9XC3wcXdE5D+rtzdm4dJnf6Lr7TIdz7v3
 35dx3vFlfl77lv3qjOGmnpY2sG56YjcC8NTP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779988266; x=1780593066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2pusd8LtiJk86xviuHO8XXo2W8I1zdC6p+B80Iarjwc=;
 b=e7YjagdZdAMIMFWtpdlnrtr/PJnorCHJwGRjQX3empisJe1+P/D/H5NEQw4U5ksEQj
 ClWrT4y0oC1k7xcR5av3wruRpMJEwOcBnE0JrnMlOZ9isdJH+h5FmgX96CEv+vO2sjrW
 1ObwTKWmPm0vCAzyL+YPlW8Ayp36/2LtVPw0yHpFdKF20vh/CvbksLywNiIW8WcqPkkl
 ZNIhL6+s/Xmb9LvmYjYQ5nEb+rEaelxsnTZ8HKngAfWsLc1Lzex5aNYlEaQKelgLXnq/
 KQXfctbFYbCQNfDjCLTvsBkazPlelOUH1rl3Vp4xLj7cZd0lD27+BlQQt42wPXRjtTh2
 /wXA==
X-Gm-Message-State: AOJu0YysUIpO0r0OOa9nGzbNL93QEW1pPoTeDwrFbCsY3XkU3tZgJAIz
 QHrq9+ewRoAGAAiZYDLVvZj5ewQmZ1bp2Pgd1lftqfrn3M1zyZXe7TKvrDaYvAvGthd+NO/Dohk
 l/8bamFIfM+8=
X-Gm-Gg: Acq92OH6U4bzYhTJyTQGRiQ4h7aCMhmPPsUA+iFHV7/zFDGSAJTsTSycxBCkny+9zkN
 2tcyP+Bn1PIsoi9DkZ0+LDuLd2dtoVm7UaLPEErZ/aR2zDNtCqG0YNJeyGh5eOQkkWvMpFu0GKl
 vzwFnFbuXsKJUOiSELVvOH4wKJGUVMH+gOmEX+Vx+t1pJZ7FnjzWI5TOQymT2lfMES9HesXnzep
 ts6eV9miOOxovvDiBRa4ug4Ep+QD3DgFr/bIoXH1SA+eR4/mxkhJCiuNz6oFZb4PFchGxBztY7C
 3gndlCG+28UsTzaYE3c1e//3rxk+tuLPTm8F5CYiI+r4uhTWuchwS7Ww770I0ApZAnG0kL9+8r4
 rsgoVW6PsqYKN+Igz7pj46nvI9zo26P8zvuqeEy+3j54XM1D7OE1ujiys+YQVRfNP6YdK+gxsem
 w8BI8frlFI/924rCIkPdOfv8NZP1dMYjClRp/TsSE=
X-Received: by 2002:a05:6830:d01:b0:7dc:d2ad:fb17 with SMTP id
 46e09a7af769-7e5fef08d3bmr16358026a34.20.1779988265699; 
 Thu, 28 May 2026 10:11:05 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e606459dadsm14461068a34.4.2026.05.28.10.11.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 10:11:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v7 05/22] rockchip: dts: Add an fdtmap
Date: Thu, 28 May 2026 11:10:12 -0600
Message-ID: <20260528171043.910264-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528171043.910264-1-sjg@chromium.org>
References: <20260528171043.910264-1-sjg@chromium.org>
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

(no changes since v5)

Changes in v5:
- Drop stray #endif

Changes in v3:
- Add blank lines before the node

 arch/arm/dts/rockchip-u-boot.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index 4ba6a87e78a..ca2003fe5c0 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -192,6 +192,9 @@
 #endif
 			offset = <CONFIG_SPL_PAD_TO>;
 		};
+
+		fdtmap {
+		};
 	};
 
 #ifdef CONFIG_ROCKCHIP_SPI_IMAGE
@@ -224,6 +227,9 @@
 			/* Sync with u-boot,spl-payload-offset if present */
 			offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
 		};
+
+		fdtmap {
+		};
 	};
 #endif /* CONFIG_ROCKCHIP_SPI_IMAGE */
 
-- 
2.43.0

