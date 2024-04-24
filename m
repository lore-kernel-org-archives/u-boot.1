Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED2FC4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 09:47:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB2D888CF1;
	Wed, 24 Apr 2024 11:47:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="l9ycxykN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78EEE88BEE; Wed, 24 Apr 2024 11:47:09 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 972B4886F2
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 11:47:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-56e1f3462caso8425499a12.3
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 02:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1713952027; x=1714556827; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fokHsl+eIcTZ/Cs7BeQ7RbtBPqxVTZaLUjSv0vR1kOo=;
 b=l9ycxykNdiBBwSbK0koK1tLSUdXGncowDBDjutkB0lBdlwxNXjh67dbzmczTvV/nl9
 PDUIVLn077TMKsI4aT1MTU0l39T8I2m1FetPOEI/5FrEVesunly9eC7UlyflGWggH/VV
 Vgnyo5Biep5UOt5w/VFoupjBGUprkS/y5cYaieFL9RBTWQJXvO2rJaP7u6dJt8dZmOEh
 jQD2vr71h1hciyk388ifq12SCJaqyvmf6zwHG0ziXNpV1EI/LF1MR0xv9GBY4ZdCWQMM
 2p1qY06PamGKMVzdkUnG5rPT4CSyXwbPbLPGV0nX37zafKk83TQEmbeu0Qyqt+up73xz
 64Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713952027; x=1714556827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fokHsl+eIcTZ/Cs7BeQ7RbtBPqxVTZaLUjSv0vR1kOo=;
 b=scuIbyKoeXXijEAou4AMIjd60q+9raSLQepdkbGw1IOpBC4OJdnaZRmb6cxNy1AAQe
 k/AIKBd8jrKYhRSFK3oqNMbMZ6uXHGRHmv3sd3nZXNFV0+Qw9J3itnx/SXRyAOvDdVkq
 gke7E5VdEWy9oRmAVEyQbJZ8ud3r1LokxZrMKCBgbBfF/SeUUHbuW/SiGSLKIgu40Lb4
 tC7L5QZWI4gtPng9CTxwGCHdUTUdVIO0GgIhMIOzhg/384sFb/riBsar/2EzkzzpnzFb
 tN6E/qZNyrdCAMvLGrroKwUie9bgLrtiVyfGf0onzhGc4BMfvTMXaRsv/Zox6iJ8lTHt
 zmNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQR/9/vjW8NWg/HibKcuthrEhhGwQ4Lom+YVRGStD8M/vdh5jupODUMBex+vWvUwEXi5YsplW03929+fSkqgND05BQUQ==
X-Gm-Message-State: AOJu0YxgIITdEKz8MDjGGQtk5TFEACJUlq0tnV/UvY4BrspzXXdc2fOi
 JIMFWF6LLGVwy37Q0ol7TMPWzMErQ/QfozWTXHuYHaL/i3zJwk1mgM8qFpQ/fFw=
X-Google-Smtp-Source: AGHT+IEcWZV7GG+0hMzDF2dG/hpjea/vUNyvPT61lKm6cFIPr36681wLLYU0O5O/0uylgWOPQ8d0cA==
X-Received: by 2002:a17:906:d206:b0:a4d:fcc9:905c with SMTP id
 w6-20020a170906d20600b00a4dfcc9905cmr1084565ejz.20.1713952027020; 
 Wed, 24 Apr 2024 02:47:07 -0700 (PDT)
Received: from fedora.. (cpe-188-129-47-121.dynamic.amis.hr. [188.129.47.121])
 by smtp.googlemail.com with ESMTPSA id
 lo27-20020a170906fa1b00b00a588685d769sm1274598ejb.32.2024.04.24.02.47.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 02:47:06 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: trini@konsulko.com, sjg@chromium.org, sumit.garg@linaro.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, u-boot@lists.denx.de
Cc: Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 3/4] MAINTAINERS: IPQ40XX: add clock-ipq4019 instead of reset
 driver
Date: Wed, 24 Apr 2024 11:46:24 +0200
Message-ID: <20240424094701.21198-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424094701.21198-1-robert.marko@sartura.hr>
References: <20240424094701.21198-1-robert.marko@sartura.hr>
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

The reset handling was added to the clock drivers but the entry was never
updated, so add the clock-ipq4019 driver instead.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fdce7c8334..207c8b763f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -338,7 +338,7 @@ M:	Luka Perkov <luka.perkov@sartura.hr>
 S:	Maintained
 F:	arch/arm/mach-ipq40xx/
 F:	include/dt-bindings/clock/qcom,gcc-ipq4019.h
-F:	drivers/reset/reset-ipq4019.c
+F:	drivers/clk/qcom/clock-ipq4019.c
 F:	drivers/phy/phy-qcom-ipq4019-usb.c
 F:	drivers/spi/spi-qup.c
 F:	drivers/net/mdio-ipq4019.c
-- 
2.44.0

