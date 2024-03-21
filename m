Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D21CC54E58
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 14:57:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58A2B8811E;
	Thu, 21 Mar 2024 15:56:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MsQAqG4H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3407880F9; Thu, 21 Mar 2024 15:56:36 +0100 (CET)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81CFC8811D
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 15:56:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1e0000cdf99so7638025ad.0
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 07:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711032993; x=1711637793; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DE3g6t51eUKFdWjCnl+qh3aKrNAc8k4gkwbwvC1c8Gs=;
 b=MsQAqG4HyqA7zW4dRFoWdO3S4QzLcTA7NK4irhvDwp+/uMnetRldGYYQO8xzDvvYpR
 qjH7I4vN09AdxhFa860JlZK5zGm3pOHZIkCUtQkd2/6gFFrXzocFw2aow9o3VoVgOooP
 Yl3Bh9P7BGNDANZVrK4EWhahqQNjqcUmR5ZZtR4dJu/CC9I/UHvJkG1Nv+El/8dA0Tiu
 GaIJ0vUQ5MtGLgRuiHsyxQcTF9Ii94QxS9kO0zFF2I3MD8/39J3/jY4FQPzar++mLQep
 v66nTiTzvd09QnfWP0Zf89E6pLeAdXt3HFd/9k7B8SxAL28EplT9j7/NMcQXEYT5BMC4
 SbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711032993; x=1711637793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DE3g6t51eUKFdWjCnl+qh3aKrNAc8k4gkwbwvC1c8Gs=;
 b=p7ZAaSZ3lVEqiRkADgny/ulS80vXjIhv02JqfGjKC4mqWor/oSKtEDKANKooYcXX1L
 67tgiG/zQkN7gGp4AA9cS5PHdz3PKNraQdXScvQgwTBQL+c2tzJjWmR8KTNtozojszAj
 hxb1sNWDdDQiNpEGv1M8RcLsm679CPDaHSQDjwk0NA19nBXL2qd0ew4jUpM7yMZCASo5
 xrPg86kGQ9rVKMl+CzBy+X8NrOPSBydVkWqPpzpGLrXdUy+qeTsezex90tneQy6sSZ8r
 O50f6U5Ej/Ld8RbIMgegeW78K/cegUyX1CGmMJ2R1O5TUV+wU8C6auxEXCHnHgZ7E3rZ
 MhsA==
X-Gm-Message-State: AOJu0YwTLZehYDWmYyMJ3sTeH2ys2EGMEDtPJRKvBPWMscxZ18s5jEfL
 VSZKjRyNfecQYPANrmw8rutHEL7Y9y/LDZwc2holiG8HXZcF0btiCyVOMJwF0cLFnFy+F37ysKw
 1
X-Google-Smtp-Source: AGHT+IHsLNMsmh+t75WsWkblCSQtqf4b6NJPMRjKkrjS7KHCQCij1jPVy+UBUndd0D7FRjVIHZj3Lg==
X-Received: by 2002:a17:902:ea0b:b0:1df:fbc3:d131 with SMTP id
 s11-20020a170902ea0b00b001dffbc3d131mr2721436plg.27.1711032992704; 
 Thu, 21 Mar 2024 07:56:32 -0700 (PDT)
Received: from sumit-X1.. ([223.178.211.159]) by smtp.gmail.com with ESMTPSA id
 j9-20020a170902da8900b001dddb014624sm11751668plx.54.2024.03.21.07.56.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Mar 2024 07:56:32 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, tharvey@gateworks.com, marcel.ziswiler@toradex.com,
 francesco@dolcini.it, lukma@denx.de, seanga2@gmail.com,
 jh80.chung@samsung.com, sjg@chromium.org, festevam@denx.de,
 andrejs.cainikovs@toradex.com, peng.fan@nxp.com, aford173@gmail.com,
 marex@denx.de, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org, pbrobinson@gmail.com,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 11/11] MAINTAINERS: Add entry for PCIe DWC IMX driver
Date: Thu, 21 Mar 2024 20:25:07 +0530
Message-Id: <20240321145507.619448-12-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240321145507.619448-1-sumit.garg@linaro.org>
References: <20240321145507.619448-1-sumit.garg@linaro.org>
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

Add myself as maintainer for PCIe DWC IMX driver support.

Acked-by: Marek Vasut <marex@denx.de>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8b316c8550e..83fd68e3f39 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1371,6 +1371,12 @@ M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
 F:	tools/patman/
 
+PCIe DWC IMX
+M:	Sumit Garg <sumit.garg@linaro.org>
+S:	Maintained
+F:	drivers/pci/pcie_dw_imx.c
+F:	drivers/phy/phy-imx8m-pcie.c
+
 PCI Endpoint
 M:	Ramon Fried <rfried.dev@gmail.com>
 S:	Maintained
-- 
2.34.1

