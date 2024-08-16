Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 352DBC531DC
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 15:48:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDA4D88BBF;
	Fri, 16 Aug 2024 17:47:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d1KRVAS0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D6A3889A6; Fri, 16 Aug 2024 17:47:52 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BE0B88BFC
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 17:47:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7a1d3e93cceso305738485a.1
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 08:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723823266; x=1724428066; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QSlUDShnCGIL++aHPXqIoOA6M2rNXeGB6ISTPLOuRz8=;
 b=d1KRVAS0YlWOwOmsnc6U03/+O4fxl5+Ey//FyWN5sG+2soqRKVTjIcLPTlHJqrNRBK
 bFp0OWrmwCKeK6xM3XW34LUzsMZWVw1QRZnslYjcn6AtlBN/DAIZsBkanrIUMAqeBFUp
 uZQVkr+5N+Tu0MEhLJVxLo2zdv31CypA/JDo+GCLyl30VIrVLRTZj7v+9zQkMOYlje0W
 1ZX+SyRzAPjcAqKtnTNi5pJ0va4NJnO31vo0J0aR33U1cZQJiyx4OP17N7AfECeciTK8
 qL3FzmTeNQEnIDEC7DhkdIOFRV+4rgnzf/I5Wk4Y12ZCnRixKd9Y+mbahj4lRmUGImbj
 E2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723823266; x=1724428066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QSlUDShnCGIL++aHPXqIoOA6M2rNXeGB6ISTPLOuRz8=;
 b=VLB0ampJv1EnTF6FdZk6fo5wqji7tyvhbBMaTfcvdiG0j7HPDrkv8CuALSxJLolA8w
 MTND5m6JYoxIi5S8qDMPuVFsJE8hdr/NpZZ1JIAAiXGTeCypGsPjoxGguyvV2FsRwxRP
 AAtr8urvtN+PDXv4x6sMRp+Q3pDVY4BKj7BDcT8SisXJ/jg2a/1UOfErHP2dQKgV00XB
 9+wWQPJWMZ/poM1HpL3cSoxft/8udFeWvJtAU+dZP0XqCnElySNFSdrdFfeKh0PwHRvH
 XR14+QGemXh27rOXu4d+H1H2TNl1n7os8V8doqvIQdjU1pQhGI74Zzi0bZEmJ75ZJUn/
 W0Sg==
X-Gm-Message-State: AOJu0YwmV+bTYaPUQyqBJ+LW4VztjYr+EDxsWCuUYBAZbhEsJ1jX4uYQ
 56d2fSKgolSuuKp+ld9q16eeWmIvwTxkvn9G1Y9+B3xSEFYT9bqiPxjvaIfbtWU1gjXQlyaeJb+
 MG9s=
X-Google-Smtp-Source: AGHT+IHqusTyrvRoanLl0/Q63qzkMw18bMg1+m+8wwrF1bu01efngGIj59CI8AkSNxigLQSdMMw3LQ==
X-Received: by 2002:a05:620a:46a2:b0:79e:fd1e:6fc4 with SMTP id
 af79cd13be357-7a507556903mr481661585a.34.1723823265726; 
 Fri, 16 Aug 2024 08:47:45 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a4ff0e53d8sm187041185a.85.2024.08.16.08.47.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 08:47:45 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Stefan Roese <sr@denx.de>, Bin Meng <bmeng@tinylab.org>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Wan Yee Lau <wan.yee.lau@intel.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Alexander Gendin <agendin@matrox.com>, Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH 04/10] smbios: ignore the non-existence of platform sysinfo
 detect
Date: Fri, 16 Aug 2024 08:46:47 -0700
Message-Id: <20240816154658.1866186-5-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240816154658.1866186-1-raymond.mao@linaro.org>
References: <20240816154658.1866186-1-raymond.mao@linaro.org>
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

During writing SMBIOS table, implementation of sysinfo detect
function for a specific platform is not mandatory.
Thus we should not return an error when platform sysinfo
detect function does not exist.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 lib/smbios.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/smbios.c b/lib/smbios.c
index 8e481365165..2f1759d419e 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -825,10 +825,9 @@ ulong write_smbios_table(ulong addr)
 	if (CONFIG_IS_ENABLED(SYSINFO)) {
 		uclass_first_device(UCLASS_SYSINFO, &ctx.dev);
 		if (ctx.dev) {
-			int ret;
+			int ret = sysinfo_detect(ctx.dev);
 
 			parent_node = dev_read_subnode(ctx.dev, "smbios");
-			ret = sysinfo_detect(ctx.dev);
 
 			/*
 			 * ignore the error since many boards don't implement
-- 
2.25.1

