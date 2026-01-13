Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F492D2D0ED
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 12:59:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 129F182C7F;
	Tue, 13 Jan 2026 13:59:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K69QL1k0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB245830CA; Tue, 13 Jan 2026 13:59:09 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAEEF82B20
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 13:59:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=max.oss.09@gmail.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47796a837c7so51675685e9.0
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 04:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768309147; x=1768913947; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yFTCMkSqswe7ekUjomFwURItAXMgaHJ0QpxCqi5L8qk=;
 b=K69QL1k0WtPCHz/FJlKV+gxmDkkmNPp8IqmyqlMjSNV3DWie3m+2+hQrnJAoIY54Er
 Rl6OR85rKZMf3jHu+brChP+tWXFD8VBpi/zKgw5qf7hlToMhNlKHeLfCtKJ/t1ojTY5F
 /pcPp6txbQveO/H1MA42/fqmbQ631bIetXBs1Kxocj+6l+Awzr1lcg9VZy722xeKKUK7
 r3Y97Aslbkbed7X9a3Ex2OtDed2KW0WY+19R1wNYtQleVK7pgASRp9ytdofWjQjpLOxq
 x+mftXEEYX3nZwbRHUh7pJPzftEvHZL9ssiFGBxHFGU7itZdUOFx7q9p+xxXgr/favMu
 VbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768309147; x=1768913947;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yFTCMkSqswe7ekUjomFwURItAXMgaHJ0QpxCqi5L8qk=;
 b=pJb6iAOFVElp0faaWo8r4Rx24AsTFJMsMw3Lx3EAJSJzcUfj054K/S2st1/IvGRcHI
 kMxU7GODhPHi2be4UfdI5D75nBA8OWvf7S0lsJFCrQ91DqLnNzlEUDib4UGxlNMZBczs
 8R/DnHFPlxjztn13ovDrJ/2RHaLyTcBgYYxNx2NGwlO3NvBvzodk2ZQuzW7mvyhjR8bG
 6Bj2NL29VRm5IIknvVc+aVv9yRgJZxE2m0Mtxzx/iksKXrHOJcIkg8ryK6sjtiLZF9LR
 J9c+hbmrIMe0jYW8pWaaTC06VyNtwrVd5mScdmBZAWjtqYI2NSNZXvAyu3rBDqlrFA8Z
 wnwg==
X-Gm-Message-State: AOJu0YxURLlL1ky/NrzCcWyzLyG3VEK9eDMQ4+0jXH1eGeU9L4Fu5Jh6
 282PGiKIjH53nk5tY84U+ohUCPanMHHLsVbiXSg/VUpo4MEsA87a9ZhM+dHMqA==
X-Gm-Gg: AY/fxX6P9ct3MwCZFv9FcKGICA2N0SHZzYeVrVCIv7P/yZKmtwWmYOmx8NDykc/D+4K
 mpBi8aZ9VBN4yroJ4lfiQcApFzs6vU7vepaRN37+e1h0pRNxpFcJKpGurKYvvgyT4FFXoYSyOSB
 wTXLc/EcicmqeiSm2zDpySqZxk9rssxzKoNNQMVV0Y6D/kM2jj/5SHuImbzo//838r5DOvgtH6s
 Wp48+SMmk+vSZxwdRJrz7fk4HIyr74QieJmJtd36dHHAuMtIjlDpzKP+CEp3K6LLNQO5X33PLYU
 GShoOiNsTSTH7GjaMHwHTTmPxgSeZGfZMPlBjMnGylgjpW82fG5y6RC1PQjq4PbHcODT9kp6awU
 zJmHx1ky1Lq8ZQeA1Q3qdu3B6sTpTyKrZ0YIXXlnE1j8h1/xgFaTwJqz4iLP7bEMDRu+SeZUivD
 xoyx0+RSmjdBU4dKhWFkY+HXkLnlf/O1dgFMq1mKAE7tyeVUUcLHKyCZInC2Zx54yNseaSln8Vj
 dBU/UaluCFcpZno
X-Google-Smtp-Source: AGHT+IEbAu0+1kHR3XFVYU7UrqNMKmmQ/c0uLQf5d6/EquuWPDBXKjNn8tQpnOqr/lcoEaI6/16pvg==
X-Received: by 2002:a05:600c:4e86:b0:46f:b32e:5094 with SMTP id
 5b1f17b1804b1-47d84b5b4fcmr236765235e9.32.1768309146748; 
 Tue, 13 Jan 2026 04:59:06 -0800 (PST)
Received: from toolbox.int.toradex.com
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df939sm43781816f8f.21.2026.01.13.04.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 04:59:06 -0800 (PST)
From: max.oss.09@gmail.com
To: u-boot@lists.denx.de
Cc: Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] toradex: common: handle third MAC address for SMARC i.MX95
Date: Tue, 13 Jan 2026 13:58:23 +0100
Message-ID: <20260113125853.3970525-1-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.42.0
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

From: Max Krummenacher <max.krummenacher@toradex.com>

The toradex_smarc_imx95 board exposes three Ethernet ports.
Set the third MAC address equal to the second MAC address.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

 board/toradex/common/tdx-common.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/board/toradex/common/tdx-common.c b/board/toradex/common/tdx-common.c
index f01fb369b4bb..81f7fa09002e 100644
--- a/board/toradex/common/tdx-common.c
+++ b/board/toradex/common/tdx-common.c
@@ -179,6 +179,18 @@ static int settings_r(void)
 		eth_env_set_enetaddr("eth1addr", ethaddr);
 	}
 
+	if (IS_ENABLED(CONFIG_TARGET_TORADEX_SMARC_IMX95) &&
+	    !eth_env_get_enetaddr("eth2addr", ethaddr)) {
+		/*
+		 * Third MAC address is allocated from block
+		 * 0x100000 higher then the first MAC address.
+		 * The same as the default for the secondary MAC.
+		 */
+		memcpy(ethaddr, &tdx_eth_addr, 6);
+		ethaddr[3] += 0x10;
+		eth_env_set_enetaddr("eth2addr", ethaddr);
+	}
+
 	return 0;
 }
 EVENT_SPY_SIMPLE(EVT_SETTINGS_R, settings_r);
-- 
2.42.0

