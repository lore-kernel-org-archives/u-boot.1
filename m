Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA26CC25B7A
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 16:23:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20AB4888D2;
	Fri, 24 May 2024 18:22:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FyZQOz/N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C048C888C6; Fri, 24 May 2024 18:22:30 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05B5B888B9
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 18:22:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4202cea9941so66065475e9.1
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 09:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716567746; x=1717172546; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kT3oU3/pHxg3AWot0a+7qppqiU0nm7SvBEuR9n3PDyM=;
 b=FyZQOz/NZ6+wVytt29/Yf/Lli60zSJaWSq+rO0AXLB0sCeTOl6e/z5ByLGLva3PN1X
 krrFPcKcnQFfaBNNd4DRpi5minRdoULayEMd4RPVT5h+cKETskyKyiKmQQnjvdWLR0oJ
 aoTZBhXZePK3UIypWvg7HME4FkkpWY53qXpr7qhWJySzsMaC0PBR/Tm0DNxCl324vSae
 f2jgU29wpd1Vrbt/lcItxQcPHRu7P3Ha5o4dsxGt6BEBQbfGqobVtyeREYBwl6NvQSlr
 Un8C2Gp6yToixzMwtfhvaoyBV/HxkSA73fL83casjwy5Bba8dr8AV6MT0H5tIeM0p+Xa
 IwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716567746; x=1717172546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kT3oU3/pHxg3AWot0a+7qppqiU0nm7SvBEuR9n3PDyM=;
 b=wqE2xDOr0CqE4abNXtbjFtYtvNbzHpOs9TvLAX57LWP997Vx/8dQlc23Dbn8PkGcUL
 O+TkdgQXPkew5oKCqlY4/ZuLMNxmVmA+Jnitbl410lUM7k2xQysQ1SeiI/8QfBIXzlmO
 q6+Ijeyh2brRNUvDHTECQQ7lkw6ugX4mpdW5aj7pqQvb2rqvFZFbDhrxTTIbKC4YM9kM
 XZ/24HJQc22sWg/5KxadpVrcAWwSk92ZlobkV8682eNUKjgRVveTVv1cvmY2W/WvOY13
 e9oZcZTmD8F8iawBIC5tYituLveLKdM36RqROBub3oSI3Kq11s57P3788IIrke3VZ9I3
 I/Yw==
X-Gm-Message-State: AOJu0YwWn5tm9s6EX3IugTNYThU29utnmCjW6qzk4oKP2EJ8QLFlputK
 dv/wocRJfDjW8405UNWTagMN3iKD4Qla8EOWW97dyQ9N4HJxCDLPxfPJx8Y5rMoq0O9wI3nLse+
 YEAhA9Epe
X-Google-Smtp-Source: AGHT+IHyM/xVuBXfhWuVXppwab1OlPxDynijvBvaGUVMHQpMPKQVLltxjKc1r3os8kn9eVqY9GJu+A==
X-Received: by 2002:adf:e9ce:0:b0:354:dd23:9dae with SMTP id
 ffacd0b85a97d-3552fdfa2ffmr1898547f8f.62.1716567746316; 
 Fri, 24 May 2024 09:22:26 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:80fe:af01:c137:b43b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557a1c918csm1928465f8f.77.2024.05.24.09.22.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 09:22:26 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Subject: [PATCH v2 13/14] MAINTAINERS: net-lwip: add myself as a maintainer
Date: Fri, 24 May 2024 18:20:07 +0200
Message-Id: <41c1758e85e90ec4fb34d56ee4c5434ccf26750c.1716566960.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1716566960.git.jerome.forissier@linaro.org>
References: <cover.1716566960.git.jerome.forissier@linaro.org>
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
index 638b2fdd442..737c73cab34 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1315,6 +1315,17 @@ F:	drivers/net/
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

