Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B4AC531DC
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 13:54:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 978D788C9D;
	Fri, 23 Aug 2024 15:50:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="h+4AdGH6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1A7488C6A; Fri, 23 Aug 2024 15:50:15 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8927E88C70
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 15:50:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-37196786139so1035574f8f.2
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 06:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724421013; x=1725025813; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0tGrz+fyPkE3vdcLjdOdpujgl7dYrT2sQnfYMflACoQ=;
 b=h+4AdGH6jszR5YoutpkFbgGFxuX/BruNyHkGgXzbv13l3O/UVmPf4yHIP2Lr71dyiy
 WyJxrk6yb4fOeYnvixDafpXf43bVRuMRaGEHjzcgyB8gM4BvQfxl0LwUeFC8TXdpHk55
 c8In8xiqEPap5GuTH1TRXLt3wKtH/SoSrafQ2Yx2uD8zDiZSRbOKYQrhvhDDz75T2mlH
 2HkJISredVdjpTKnVRIrPPqPTSdfeZRnR6sQGRIwu92zw8D41WzOEZUQ3CpbD077H6nm
 L6JLS5kjIo4qlm5VO5+aO+TLoGuyHiWRjS7dmYid3Xke6WJ5hbN1jVWOw9/uNE7nS/gy
 ZUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724421013; x=1725025813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0tGrz+fyPkE3vdcLjdOdpujgl7dYrT2sQnfYMflACoQ=;
 b=aVOWahkXcbK6eHU3dgU7r4ISshJqae01ZsYZSXWJ9kSSVOAwr8L/BRtL3IpyC3if0g
 byN2kxb/fxzLhVCUbGP9Ymo+yxJFHORj9PRFlsrCgHQE52/Jv6xMnDtDRSDT0xqWhMEL
 N0BhqkoEVdYXGsItRlHX89cNDRv6XqIbCxooFZvTOGa7BTSN+NV20Ci+iPlY9+xSI5Im
 /8xo81nTyUjC7CEsqJh7f5q6CGqbjh1jYqLazbVHoqPXaaD8dIJflsXCulc5o6bWBhUG
 LoobS0A/Q5l1V8/Fj2GtsLcH1gbVqQwVNKHs5Pjkb4TKQ8QQ8BsDclDVraCXhtKj0Um+
 +fmQ==
X-Gm-Message-State: AOJu0YzpbagZGycY1W0mvm0paB4neQjb3BJ/ySbKHc2aolmYQlv3jTIl
 ohg6M1/Eog4g9nJYvAEbcx/u3AJcDnH8DYBVAiOqnHvH8grlKcB77uiZRal5Ii+ljfg7Qpt8hnG
 WNMgVvUDs
X-Google-Smtp-Source: AGHT+IEeRd1aV6wIarSU9SNmbvP+szku0cK8mWqLSYzXpRXx2oZcIy6IRzjKyIJdqLAtb1bMovfjHA==
X-Received: by 2002:a5d:61c2:0:b0:368:3f5b:2ae4 with SMTP id
 ffacd0b85a97d-3731187db65mr1528871f8f.36.1724421012659; 
 Fri, 23 Aug 2024 06:50:12 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:e668:dc94:35c7:8064])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-373081ffb40sm4201665f8f.76.2024.08.23.06.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 06:50:11 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v9 32/37] MAINTAINERS: net-lwip: add myself as a maintainer
Date: Fri, 23 Aug 2024 15:48:36 +0200
Message-Id: <dc82acd262bbbb216f8623643ebc2d806f05e26b.1724419624.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1724419624.git.jerome.forissier@linaro.org>
References: <cover.1724419624.git.jerome.forissier@linaro.org>
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

Add myself as a maintainer for the lwIP network stack integration code
and network commands. The library code itself (i.e., most files under
lib/lwip/ except README, Makefile and integration files in u-boot) is
unmodified from upstream and therefore does not need a maintainer.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2050ae24df8..cbd59d17e4f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1351,6 +1351,17 @@ F:	drivers/net/
 F:	include/net.h
 F:	net/
 
+NETWORK (LWIP)
+M:	Jerome Forissier <jerome.forissier@linaro.org>
+S:	Maintained
+F:	cmd/net-lwip.c
+F:	configs/qemu_arm64_lwip_defconfig
+F:	include/net-lwip.h
+F:	lib/lwip/Makefile
+F:	lib/lwip/README
+F:	lib/lwip/u-boot/
+F:	net/lwip/
+
 NIOS
 M:	Thomas Chou <thomas@wytron.com.tw>
 S:	Maintained
-- 
2.40.1

