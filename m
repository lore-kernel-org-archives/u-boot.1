Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F6BC072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 17:24:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 569DB86EE0;
	Sun, 19 Nov 2023 18:24:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="h3cPZaN5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9989486F1A; Sun, 19 Nov 2023 18:24:24 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3D1E86E95
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 18:24:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-332c0c32d19so684398f8f.3
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 09:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700414659; x=1701019459;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=x49lQAjUAwMsm96CP49oKu2PYolG181AAvAShBDJ3Wo=;
 b=h3cPZaN50+6XUN2k4d2lb6nDqPsjEJmyMCTvrc/cRSO/EbqNFUW+Doe6vejexYumoa
 d6SfivVUIA3EPAnT94YdVYXcihjo0JMUYYLHyy7Sc7Iw58hSMxcKNbPczQiYJk/e1nUx
 WgGnodk6aYj6FdOwgwc+W6ckpY+J+lVByvwbreFMV1x6FvUDR2Q2TpXYeOEw5/idAcr9
 I7hUa0F69GDYZF5cs96GuQkrjas5ptvpByjCNYKC2m38NLsYrMJECeumuIm1JFfI/Kpf
 yebA5+KUmFsvXj5bf9bPpBJfhFTBVPtHFoPYa/CBGFlS7rNRv5/sfCz2+U60ghVv6gC6
 9/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700414659; x=1701019459;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x49lQAjUAwMsm96CP49oKu2PYolG181AAvAShBDJ3Wo=;
 b=cMzTdbs1na/NPYEg7Hxs+Vtn4B1w/1bYz3lkqB5wcjrot2rC20ZS771epDWLXbGMRs
 4ipxaCwM+4N70qUhSYb5RUTvZY6nFjrAeYfDyA3ED6OnJDx7wPudnMlOLlVAL6wSIpfe
 zfDvK5RQViVRQssJ73g6o42pzKrKaCbq9lwR1IGIIQKFSJ5WgxyYpdwvitd5muzWE+up
 w6zvnKPTvMb0dmTLrK26qp7qahZTV8kG17jaxafBV7L/AlwglSh59h9iM6Sg7zPugW68
 zwSqrbJNpyJBDPsabcP/fq4rrxpIpx5WB4sIkrm5sjLXslSXBIC8dTVDZRV1gyPcumap
 LHtw==
X-Gm-Message-State: AOJu0YyJilpaVOdZ4z9NJeV5kjgrWV0UcDaWUYjYuIZNYIkTJOstZxb3
 Cwy684jYhWt7wWhHWOyBpHLRdxXUVGytmqV5smhIPlzc
X-Google-Smtp-Source: AGHT+IFFal3GMPIdH2oVyL8CKwl4MBgkYkmjBYflVBnV0K8Hpeavc6pBypmXEN8gk6dCniFdqznXgA==
X-Received: by 2002:a05:6000:1568:b0:32f:7c1f:bf73 with SMTP id
 8-20020a056000156800b0032f7c1fbf73mr4686737wrz.47.1700414658769; 
 Sun, 19 Nov 2023 09:24:18 -0800 (PST)
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 a2-20020adffb82000000b0032dba85ea1bsm8589599wrr.75.2023.11.19.09.24.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 09:24:18 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: u-boot@lists.denx.de
Cc: Shantur Rathore <i@shantur.com>, Simon Glass <sjg@chromium.org>,
 Bharat Gooty <bharat.gooty@broadcom.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH v3] arch: arm: Kconfig: Enable BOOTSTD_FULL for Rockchip SoCs
Date: Sun, 19 Nov 2023 17:23:10 +0000
Message-Id: <20231119172310.1307942-1-i@shantur.com>
X-Mailer: git-send-email 2.40.1
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

Rockchip SoCs can support wide range of bootflows.
Without full bootflow commands, it can be difficult to
figure out issues if any, hence enable by default.

Reviewed-by: Simon Glass <sjg@chromium.org>

Signed-off-by: Shantur Rathore <i@shantur.com>
---

(no changes since v1)

 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d812685c98..fca6ef6d7e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1986,6 +1986,7 @@ config ARCH_ROCKCHIP
 	imply CMD_DM
 	imply DEBUG_UART_BOARD_INIT
 	imply BOOTSTD_DEFAULTS
+	imply BOOTSTD_FULL if BOOTSTD_DEFAULTS
 	imply FAT_WRITE
 	imply SARADC_ROCKCHIP
 	imply SPL_SYSRESET
-- 
2.40.1

