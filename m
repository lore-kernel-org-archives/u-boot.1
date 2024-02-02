Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF73C4828F
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 21:44:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F11F587E62;
	Fri,  2 Feb 2024 22:44:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="l5eS5mBS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2EBA87E63; Fri,  2 Feb 2024 22:44:45 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9894D87E60
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 22:44:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-511234430a4so4292508e87.3
 for <u-boot@lists.denx.de>; Fri, 02 Feb 2024 13:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1706910282; x=1707515082; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Oj+iGn78cjAQBHLPVWNLIsuKYVTwtd0jypevBMVn8gY=;
 b=l5eS5mBShd0QmUNCVpDEDhius7YF5YJs0OiZ9ohjRFKz0C5kZs6I5WVm8nDELWqVzk
 3ey7Nmqljh1etHUcxuzjoiWaHw1FL/6Xgoni+OlP0iAD8+918SKyouc8y3ikmvUcREn+
 12qWAjjAr//AZdGk62v2T+lEj7Z17oqHW78J/73V0zJw0JBSS0D3yDLxhLox4xymzsSq
 OxtKKKzDLBZM6pWGANp/+zlebXC2vPCU3xp/i5yuLTrvJAq/jF9Yjfe8I3Ik3EnyAr5Q
 2wL0KCII7WE01m2c/yzbqC16tdU14IYrsaLOupcjxvES83L/7iOzrskK2pxG8ZzGTlqO
 KZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706910282; x=1707515082;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Oj+iGn78cjAQBHLPVWNLIsuKYVTwtd0jypevBMVn8gY=;
 b=Bhea6FYmloKqTURkWW4ATnjvhD9RY4033G9HbQEpX8r+CLrzlCXxXk93W2pIZ6ntSx
 sxHV+DSehyD2WNu/Y+NqxXyzi/GnZDD7InFzvXHioN997E+QME+4JxpGTna63SMGb89L
 G8XujKvBmAFMoLwl7x/WCYyQe3hEnCDfPsnares+THmnzdvX6Z8a4vL4K0HTkxbYGr2n
 vQkTZbuKcHhzTj0A0Ig2NVnu4BfTiPXSCGECPn1K7f0JupYlaeDjhqtVtRT0XbBF9JBR
 /rFxIwKIQt+7dYsA5SiUf66We/v3f2oZZKYN4MWuavYnVz2v9wVcAauN/IsfULKD9gst
 MLGw==
X-Gm-Message-State: AOJu0YwkgWpzVzbbrdW+7so5Jh+XzuNkIjF0fvyzLpLQNLlBc6hR5B89
 ZVxNNPlid53uZ7nqHj75ATCFIYZ0mlDhrgXlvEDlTD8XgPMT1qSsDXl8ZRwsPMWY8/C6xFS1d0g
 J+MA=
X-Google-Smtp-Source: AGHT+IFWyZY1qdCkMfmGLkrXiRuTm/tE6fbHepmFfugTjBqvUBz5EjuExCPzHsK8E9KHgcsZYe1vTA==
X-Received: by 2002:ac2:546b:0:b0:511:3620:21ea with SMTP id
 e11-20020ac2546b000000b00511362021eamr2211089lfn.41.1706910281637; 
 Fri, 02 Feb 2024 13:44:41 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXkvZY99vyBtFz8/LCdeX1LPvYRzQJmmDxEVmlyZrMveGEtjphkrBw70eVT4+6haOjCzHR08oCzA1EeE/LW6UHXh6My6kW5gxHCDfxwApy6kvvUpJFt8WO2zGW9TQnWNF92yDEUUmSAzSBJdpgrnmtWxI8uqQfOFZrucmS9ry60iGLRKQ+OKqW3aYDnW7+JDR6ocJ7M3gHkiOv8+cYPVBWEBTTy
Received: from localhost ([109.108.76.111]) by smtp.gmail.com with ESMTPSA id
 c20-20020a056512075400b0051134df117bsm375993lfs.138.2024.02.02.13.44.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 13:44:40 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@foundries.io>
To: u-boot@lists.denx.de
Cc: Igor Opaniuk <igor.opaniuk@foundries.io>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Shawn Guo <shawn.guo@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] poplar: add myself as co-maintainer
Date: Fri,  2 Feb 2024 22:44:29 +0100
Message-Id: <20240202214429.2185563-1-igor.opaniuk@foundries.io>
X-Mailer: git-send-email 2.34.1
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

Add myself as co-maintainer for Poplar board, as I'm currently
working on it (re-testing releases, addressing issues etc).

CC: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
CC: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Igor Opaniuk <igor.opaniuk@foundries.io>
---

 board/hisilicon/poplar/MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/hisilicon/poplar/MAINTAINERS b/board/hisilicon/poplar/MAINTAINERS
index bfd4a9be66b..01efc96b0d3 100644
--- a/board/hisilicon/poplar/MAINTAINERS
+++ b/board/hisilicon/poplar/MAINTAINERS
@@ -1,6 +1,7 @@
 Poplar BOARD
 M:     Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
 M:     Shawn Guo <shawn.guo@linaro.org>
+M:     Igor Opaniuk <igor.opaniuk@gmail.com>
 S:     Maintained
 F:     board/hisilicon/poplar
 F:     doc/board/hisilicon/poplar.rst
-- 
2.34.1

