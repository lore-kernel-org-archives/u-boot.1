Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E109C369AF
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 14:55:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55FC484118;
	Fri, 11 Apr 2025 16:55:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GM7W9bgy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15FF3840D8; Fri, 11 Apr 2025 16:55:40 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 489B184118
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 16:55:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cf257158fso16032055e9.2
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 07:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744383334; x=1744988134; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=i1yF/wHQWcgbug6MjKme3HBljHMVNFih9QiwQnDpYAM=;
 b=GM7W9bgyVHPdC6OwXKQHfijKTcONjA+pgBtx2SSuKgRZypLqc3CZE7fKw67l+Q+cmB
 +eAQE4C7JaLt6Qn3283yXokB9peub74yZ8xsJx6+RsS8DqA+EH3a/Ixm8e5/1YF9fAi6
 5K8w1IUKykus/x4DT/K0TnCUWJE3l04cW/nmo059//6d8dK2jyk/Jhwj2lBMunZApSUx
 KGaZnzy5MgEjv166KzFgqgNsFfRQAeVOcCxWTsgsGlk6Kqs0//SKpIgDuEVPWW0kwCqB
 mULibBGizsM7wpGTJGdLH+pGb7loZxabBZRTXvM7HFLCawzvOnJN11IsIVFn//5GUlO+
 5BDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744383334; x=1744988134;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i1yF/wHQWcgbug6MjKme3HBljHMVNFih9QiwQnDpYAM=;
 b=NTUGErvua4DpQ5Dr1Gqx77wKidH76ZEhAs6hTW9dG7IPOQpBneww7ucqqR3Dqp/8/f
 /6UpYADi2qqnA9XK1HlSmMYJylrbpwuLKyXAG4Qp9OmLQVX68eST8mAYOa6gFIkjqZco
 /Z3T0UGskEEvzWH6TStDK/qOnM2Yv2pkzqG2nQ5TzNqIs16D0298QQgpTHGDz7MdzD8M
 JbA28X9W0g2BCBesfg5uliRWjMaNbDqYdb0eM1r04AuI1gUnPcXDIz7GTPDKOeB/0WEB
 /zx6erS379Bh2KymzUe/ptdFSH70Kv0osEYAqvDiRDJrTXnmSgiKkr7GGgeF3euPr/Tl
 N60A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVP9qTgNsY0KsUPNJ/i3nt5CLUdXUsMeH5uBGbWGwMPy4C2P0YKyiK0/FOusEgcBCVxASZmsvw=@lists.denx.de
X-Gm-Message-State: AOJu0YzIoMVGEvcLsXXLq6tyBX2yFV9YkEP30MBXrG4a5+KueQvIvXda
 9bDjgzi9n0U7beDpLSXSTuxQbbkMc9ZtAmN/HXS3nvEBUIKE2G+wt1AF496Hj7M=
X-Gm-Gg: ASbGncvCjoOrYNFSO/nVAC8zT5YQHiKMttla1Se5Lzbe1rSCjzJKvGHRxaQuOWMfeXj
 qy65JA1K3vCE1aFWNcku2M/tqd8j7V1VIcpv+9ljTrkum4tf12HXrwQgCr5qaCk9OAf6SXJF7+O
 Cd+syzkgKwC5BdIp+8S/1kAI1yh1PU0gdehwwFYSfVTOpOUGYvGkL3lII2SQFFjcah4AGdR2ynD
 JS8+G7YKGv0LGYQhIE83duMNOZL1SDElYKc40dyiu7eZOha+lNkJUOM2+pZlCcT2EnvjbzWl24E
 UCuUNbxTr+CaD0YEMu8rkJl819gGESghLASSSoV+r+D89QlEOzrHKDS4VvgbGg==
X-Google-Smtp-Source: AGHT+IFjIf/8nwdAdGUu2gCTUJ2UI9ep7vra6M6UsoDHghSw6BXCChT94UhcXyBv3SPIgWGcRXupqQ==
X-Received: by 2002:a05:6000:144f:b0:39d:724f:a8cd with SMTP id
 ffacd0b85a97d-39eaaea6819mr3002957f8f.35.1744383333780; 
 Fri, 11 Apr 2025 07:55:33 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eadda64ecsm2279119f8f.0.2025.04.11.07.55.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 07:55:33 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 11 Apr 2025 16:55:31 +0200
Subject: [PATCH 2/2] ARM: mach-meson: use livetree by default
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-u-boot-meson-livetree-v1-2-ebe31909cba5@linaro.org>
References: <20250411-u-boot-meson-livetree-v1-0-ebe31909cba5@linaro.org>
In-Reply-To: <20250411-u-boot-meson-livetree-v1-0-ebe31909cba5@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=702;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=eaNAaSCSSQ7imWYnetLb4wl500/wRcYjbd6Y9zLhhBY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBn+S1jy0t+bwPwh4VtwaIYIHDHtLtL76yUIvBFqe7I
 ngaQ1f2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ/ktYwAKCRB33NvayMhJ0RluEA
 CTAKb/9dekoH2JirX/qzfjw9fP5Mee6tEDeAZPCetaGLzu/VdLUD29/zOoFwT+qMNoyM0E8Z7dL3kM
 MaF7trG+pd1okg5WW2wE9OS8ddzbQKh9llVStK3CNrlUSoDyX7hdBKF4AocmwWOSHzEHkqkyXuG0kh
 Jw0jAC1ooJD3dZw5sIzNrfwZsBjyc+NQRtkuFPvOqoXu+nXRLcywm0EGeyWJ1qrd/1ykW6KSOmKWAS
 h11ornsrtqYMnq8OERwJR0oXxdakfh0UtwX0CfvY+OQI+WBO7EgTkW/aEVi3fQA13KTm2z5rx6k5CV
 hKO9WaWAC3HBp2ZOvopMap28AVKQgAQdsSyTumbSSCkIuo1tEMWNp958JsB58KzSdZR4V5Hgi/nDxR
 GpV0iigHIEKC1e3yVa0cvoySpFqv/gsoJfeEf9LV+37ugA6bNCUMZLllf5QVQqNbJNS3thCa5wF4yl
 hHliGtBpLU2TRFu5Vz26kFjqTzNW2FLgAmyQC4N7APT40TF33nrLOAH7yGGcX8T4VS6jhhyOoCZ4dT
 o/WB8NGvZVMiw/4KZwc+GGyAtT6NM/RoNT1GhXh0Q3bjfBRGzhxJEa9rrDzSkyoLPUgXDRNkrQ88xE
 V0H+E52bJs+oN7x7Q4U+9lccqRVKyOseMAAge47Dc/krUA3+SGAOvdy46yxw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Finally enable OF_LIVE by default on the Amlogic support,
this add some cost to build the live tree, but makes DT
parsing from driver much faster.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/mach-meson/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index 7570f48e25fe477ce4dfb1eb608ed07b3a83d27f..10cef2ad6623180e2ff1ed2802543f3ba0714bd3 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -12,6 +12,7 @@ config MESON64_COMMON
 	select MMC_PWRSEQ
 	select BOARD_LATE_INIT
 	select MESON_SM
+	imply OF_LIVE
 	imply CMD_DM
 
 config MESON_GX

-- 
2.34.1

