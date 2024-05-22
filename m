Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09272C25B79
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 16:06:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBF6D88870;
	Wed, 22 May 2024 18:04:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="B3dzPc20";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F30B88867; Wed, 22 May 2024 18:04:50 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F05E8888E
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 18:04:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a59cdd185b9so229839066b.1
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 09:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716393887; x=1716998687; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N+mdUKa52Vy+S0zIPGjyhDHqMk36s/pKwTQJhpaNNc8=;
 b=B3dzPc20lFoDFxnp4fUkewXQvSNN8zgQh16CkuOQIAJ3CIIRwAd9QtjacfY8Sbe5nV
 /M+O7j57jOoesCTkQMxpDtrdNBR1DKY6V91iADg/M4BODhbE8jU2+9KTOdTqOEFST5tt
 c1+MnnAtDOsRFibvi4I14bx8M2CgrDYPzmes1di+N/WqGSjMt8PTgb46S8h6jAxOpdUc
 RS8Ky/X3PK2K0CBdbhOgs2i4W5SY+5odgchtohvSnJSqae0waIvebOFa3sJB0cNrmJb0
 Xny6CngUIXnwHWF8u6nwUiX4wi1J07zv3dz0ZavjNEVQqyxt+j+4Vv24g2cwkiDE5CZR
 WQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716393887; x=1716998687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N+mdUKa52Vy+S0zIPGjyhDHqMk36s/pKwTQJhpaNNc8=;
 b=Ib4GBGzHW9UdPHSD0wKPCXWldfMLh5J/e8cS/r+yhManLoy4oWitO3Ud8ncm8v/C4m
 LvpZLI9Z4pPVTB5TH35DjfqOnZ/qo2iBXKrsDaDT79mNJ8J2DS0f8VdtO8Ls9AoKdynj
 +8P2OZ2LAUluNCwvxpnprY7CnaJGOYUBJfGz8C8HvjuOcGOHJ1nHNnCaDpZ58jyBXjAW
 k7gxEWV1n0oA6v0sVsl4Nwo65hws5V6z1Rolhp2sHo+ji3KD4TtVEaoDkWYN07mSzg8g
 bQna4r519f84ffjWk1MMRLryVUHlBepbZr3GUJkpMqR6dxoo1bGctIKw3Ur2ggCM15Cq
 mHsg==
X-Gm-Message-State: AOJu0YzFXKqjkhHjWpnoPPE/xEkN3GsjHwcLSLoeXT/miEIVEijGw63D
 QuX49iaAeD4IDSHUyLl6XFC6IWUqTjOlKs0cIRpwRaNikjlzZdLafd3Vmvzm1bjK84zFzurbJgf
 72rtBmGFr
X-Google-Smtp-Source: AGHT+IHCA7gwkc00e68t7a0Y5w/DP0xHfb+Cv5fL8aBZ5B8m8pe1GsKEME8pAKJufyVh+1ZGdQZV0A==
X-Received: by 2002:a17:906:4ec1:b0:a59:c3a7:59d3 with SMTP id
 a640c23a62f3a-a62230f7b42mr228996866b.13.1716393887673; 
 Wed, 22 May 2024 09:04:47 -0700 (PDT)
Received: from jerome-XPS-13-9310.. ([2a01:e0a:3cb:7bb0:d6a3:fbd6:c45b:172c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6209f64ba8sm367670266b.210.2024.05.22.09.04.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 09:04:47 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 14/15] MAINTAINERS: net-lwip: add myself as a maintainer
Date: Wed, 22 May 2024 18:00:14 +0200
Message-Id: <b3f3d3eb4b8f508b6b63e353af4aafd63779ed6b.1716393035.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1716393035.git.jerome.forissier@linaro.org>
References: <cover.1716393035.git.jerome.forissier@linaro.org>
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
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a3b4d3712..0131f89ae3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1311,6 +1311,17 @@ F:	drivers/net/
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

