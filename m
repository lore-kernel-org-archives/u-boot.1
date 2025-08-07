Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 196B6C87FCA
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 08:26:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 076338446D;
	Thu,  7 Aug 2025 10:26:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FmgypMKd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF21083AD5; Thu,  7 Aug 2025 09:45:35 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9489483A43
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 09:45:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cn.liweihao@gmail.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-31f3fe66ebaso1534202a91.0
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 00:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754552732; x=1755157532; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=izkyDfvFi5WvBMolKWBV+txOJl8xAOHCp3CENAsa9l8=;
 b=FmgypMKdOJBvP17AVAh2JZKkWxJDc/Z6IZESbf2qHl+xYExIGmg2r1Xkbgj96m0ium
 9x69Pv9itEFunYQQ6Ess6+BcC7FRxTfVLGfGoUu14Dm8O/6uasNdNyBLXXl6XWpQyWSm
 JOmWiytszneRugvTcEAiwUwAYoklE56d5FMIatRTMWSeWaxOraXDH6Y5nMnp2EAIkfts
 2n9eNjDtSUZaClpVGwtnYh02XqJ2D7gGYchs6eGpZAAf4lBGitCWMLKSOw03oE4Qy9hx
 q+fzwKf9Dpwm9WSh4JwTLyHSQy9FOpv783Fnu1PrLdPrrhzdKwmWFsfv1L6zFz7Eh9dJ
 lepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754552732; x=1755157532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=izkyDfvFi5WvBMolKWBV+txOJl8xAOHCp3CENAsa9l8=;
 b=Fley8s2v71ADMQq/VbubMQJxBDd8ZqR9MtSPMexPQe7NAVcPRNj6GiwJbNwCzDxS4/
 r1Kf2VlOeVqH+DkM48BxA0AenGylZUJ3u19oWGkhvDfXAbEhT7TLIn7+6qW0QXnJeROd
 kGh8WWayVMqVYtuy2TQExyvYs+4Oe6YJMLhxITARRpZyfOhTFCSTrtlWMgHq87oFhiQV
 7/tifG/osqqZZl70wbZyZgL5cPJct2CwdlDeq6hMttITYea/3paZW17nAy3DRJFfBukg
 9IBzBadSURYiz4T+lh4nz3A+xypLVZqEQgYkFB2CMemXM1+lfYTYx0b6QaCZtBtcl7On
 hIVg==
X-Gm-Message-State: AOJu0YwmlIxW5gSb4bI4TEA1rpzQOW1j04fXqY48/DlWnhfMgeYdyFLF
 k6TwWuPElJY+piwM5KvNWHDfrhty1hNe+qEh62cKyUWXqlBaHItYHuTHloUW/4Zb
X-Gm-Gg: ASbGnctTpY6IarbdytVMRMKMKG/IaS64MlXMcjlqr5XhS/Oq5qnH6s83a6CC+IcuJtY
 k0aM7ArKAez2NcHtvWX5DrsSzRVuHGy7ntZHdS7Nw82o5QDYckMWbHoPY9qLtrH134bfdcoIlZ+
 LkN9jNs4CN7KsvNBTH1niNMFaTvf2Ejy89Mf7puUGyglPpnwCjWKJs/PnlGkB/umoYfWG8b0Yho
 BrPdzus21EZUg9SZUv3w0zvYDrYbXvIqxxKjQgcDh7Avn6zb/V8RCgfugV2XtZnQOnwGNqC8TnF
 9LJOZUZRcTIPigPHtjqWkVzS7725ue9KDwfVjQHaXL9uI262Z4Afvoc74HmmAMvFimgTSjeydmw
 U6EqqLZCvASyhqv22ZS4XZTDW5sxZiHlHW8Uo
X-Google-Smtp-Source: AGHT+IEnTng/C36jy8n7FoNhAv0slZqy/mr4rU3evE2PKFMU4DolLxsgeAZozy6CgpnfIo43stgvRA==
X-Received: by 2002:a17:90a:c88f:b0:321:2b89:958b with SMTP id
 98e67ed59e1d1-321752f45demr4230242a91.0.1754552731595; 
 Thu, 07 Aug 2025 00:45:31 -0700 (PDT)
Received: from localhost.localdomain ([218.90.41.167])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-320f4909b8bsm16809202a91.16.2025.08.07.00.45.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 00:45:31 -0700 (PDT)
From: WeiHao Li <cn.liweihao@gmail.com>
To: u-boot@lists.denx.de
Cc: antonio.borneo@foss.st.com, mk7.kang@samsung.com,
 gregkh@linuxfoundation.org, semen.protsenko@linaro.org,
 mikhail.kshevetskiy@iopsys.eu, bb@ti.com, justin.swartz@risingedge.co.za,
 lukasz.czechowski@thaumatec.com, robh@kernel.org, tharvey@gateworks.com,
 clement.legoffic@foss.st.com, marek.vasut@mailbox.org,
 dinesh.maniyam@altera.com, patrice.chotard@foss.st.com, festevam@gmail.com,
 jerome.forissier@linaro.org, quentin.schulz@cherry.de,
 andrew.goodbody@linaro.org, sumit.garg@kernel.org, ag.dev.uboot@gmail.com,
 rfried.dev@gmail.com, joe.hershberger@ni.com, jh80.chung@samsung.com,
 peng.fan@nxp.com, seanga2@gmail.com, lukma@denx.de,
 kever.yang@rock-chips.com, philipp.tomsich@vrull.eu, sjg@chromium.org,
 trini@konsulko.com, WeiHao Li <cn.liweihao@gmail.com>,
 WeiHao Li <ieiao@outlook.com>
Subject: [PATCH 02/10] mmc: rockchip: fix clock get wrong index
Date: Thu,  7 Aug 2025 15:44:10 +0800
Message-Id: <20250807074419.336752-3-cn.liweihao@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250807074419.336752-1-cn.liweihao@gmail.com>
References: <20250807074419.336752-1-cn.liweihao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 07 Aug 2025 10:26:22 +0200
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

Signed-off-by: WeiHao Li <ieiao@outlook.com>
---
 drivers/mmc/rockchip_dw_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/rockchip_dw_mmc.c b/drivers/mmc/rockchip_dw_mmc.c
index 7a72abaa38..a3f001d7e7 100644
--- a/drivers/mmc/rockchip_dw_mmc.c
+++ b/drivers/mmc/rockchip_dw_mmc.c
@@ -132,7 +132,7 @@ static int rockchip_dwmmc_probe(struct udevice *dev)
 
 	ret = clk_get_by_phandle(dev, &dtplat->clocks[1], &priv->clk);
 #else
-	ret = clk_get_by_index(dev, 1, &priv->clk);
+	ret = clk_get_by_index(dev, 0, &priv->clk);
 #endif
 	if (ret < 0 && ret != -ENOSYS)
 		return log_msg_ret("clk", ret);
-- 
2.39.5

