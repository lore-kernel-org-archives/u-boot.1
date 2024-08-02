Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E0B5C52D6D
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 13:17:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CA2E88C04;
	Fri,  2 Aug 2024 15:15:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="g0ZbFUPW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F81988BE4; Fri,  2 Aug 2024 15:15:15 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CC7188AF0
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 15:15:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-428e0d184b4so13287425e9.2
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 06:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722604513; x=1723209313; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sKlcmRfoniWXVhSWmoK6IZWIj0OZ5n4IXqkHVuJswJk=;
 b=g0ZbFUPWNK79zdrFekt2Df+t3eI6uwtblMSV/NZLbf0k8nRW0eU3aSmn3W1mSjX2h/
 60a4O7vRlZzQaDDmpaGtdy21dkBHwsl6+oyUFHEtAla+eF2POlUg318cqzKZdg9u+Psj
 tygYirDY89B1a44fwIyQrE00g7JsoVvW3cwWJTGkqD4Jw+0YUvtp+csm3UukT4T6bCO7
 yPiVAeVYLfqh8N6MzglaWoSJcrzOHRAJsmFQAHDokXE76gjbJgeJV5CqIZy4m26MS+1z
 pDi/Fw4bPqOMag4xi+NqS5vtEmWHObklTECwbj4k9Zya95Jw5aIegvfmrGoc1MNhfAdp
 ztaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722604513; x=1723209313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sKlcmRfoniWXVhSWmoK6IZWIj0OZ5n4IXqkHVuJswJk=;
 b=drCSk7WGMvS0E2RFw1xuqYSui2ZVNb8ZEKWNJ0InlrBW6cSwpHvQJYGikcUD51zzZx
 qM73OOuIbwzSaUp43l+Wpl45WQ6oHqwAeLYCd6SyOQ+qqLrjyMqU6dFIG3hX2KwtFLNo
 ct/crM1654Wu9U1s0D03Gv+ZBU5AFsGYtoPFxYOnTy7Ote763TGUa8typisY/NtiQa2Y
 UbRZ5UPVKaAWHnNBaA2nJsG6DH0QGaL/sg1qstw0k1I9JM/BNWz6dVD1CKRmbU3ineQQ
 8vCi4ma9psfkda4k2IfR4DRNcDP22Dex04bQ/VbT9ZULm8qFlK27JHS1ZilcX2csdDzW
 kT7g==
X-Gm-Message-State: AOJu0YznMWBtKhdYQ0i49onEJ+haKQQiS3RrLJPnkfG78Wtb/zUtV7Ee
 hfP+UR3BkpZpk3pBh1SRnMi2qDdD8e3TQwWKudB7IQNNE2MEHcopyDi44+qIQoOiAZN3eMb/oNe
 E/rWv4bxi
X-Google-Smtp-Source: AGHT+IFAHFIfqMvJR2H+kjI9wNN8B1KcdXKQP/lQmr93ghz/8O9LA7T+Sygfzg4bOfclrLW7FZIrzw==
X-Received: by 2002:a5d:5c85:0:b0:36b:bcef:b38e with SMTP id
 ffacd0b85a97d-36bbcefb4f5mr1753787f8f.38.1722604512331; 
 Fri, 02 Aug 2024 06:15:12 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:4fc9:a3ab:c134:cdf4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0cc58sm1970304f8f.2.2024.08.02.06.15.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 06:15:12 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Marek Vasut <marex@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v6 20/20] MAINTAINERS: net-lwip: add myself as a maintainer
Date: Fri,  2 Aug 2024 15:14:07 +0200
Message-Id: <f769f4356d3ccdecea0aaa0686f90da168cc936e.1722601509.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1722601509.git.jerome.forissier@linaro.org>
References: <cover.1722601509.git.jerome.forissier@linaro.org>
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
index 6b32a6d9464..10323efffad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1336,6 +1336,17 @@ F:	drivers/net/
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
+F:	net-lwip/
+
 NIOS
 M:	Thomas Chou <thomas@wytron.com.tw>
 S:	Maintained
-- 
2.40.1

