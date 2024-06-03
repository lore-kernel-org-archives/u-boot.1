Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E88AC25B75
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 12:07:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C90A788292;
	Mon,  3 Jun 2024 14:06:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="NaGvancF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67B89881B8; Mon,  3 Jun 2024 14:06:57 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E889688245
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 14:06:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-57a1fe63a96so3698230a12.0
 for <u-boot@lists.denx.de>; Mon, 03 Jun 2024 05:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1717416414; x=1718021214; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8Ix17QsGmzKR336WObtj0CcLYsrQkBhn6IMG/hGK/4w=;
 b=NaGvancFlamcSQIecoPkmBkTwSApa03sOVOOMyKwh0+YBPETt3GX2VO8QQ7BKndn8C
 7WOXHoCKx1OHcJ17fTJcMb6yo5qg8twmYdlff9AancFPtz9Cp9ja+Zgb6AUCTH/6Ia42
 AXyfpTPan0bPs5J8fxp8LcEH/a5vRs1p2WxK0xbaqqMUKnS0KnW/0tvyLCJhW9LdTtfm
 9Ww3ZLQsZUHz3G6vUyHpohyl2Hxib028XsH7OhHdsbASmugSQ2U4SmEWO2SdoO8G+o6p
 fc6Z6M3jUd/xLHdRy8LUjQRm3NKfl5g+pal72m3e824Nbxk3LoBTNku5tFsBZwqrcCpL
 uaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717416414; x=1718021214;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8Ix17QsGmzKR336WObtj0CcLYsrQkBhn6IMG/hGK/4w=;
 b=Q3ptezk+JoSYBOzp2rzwd59O2JEXZT21s4JxQxwtSBejr+XoeS4h2rSA1qGlaaFJey
 B3bb2J8SqJj2ZB8jFdm1jBi4NWSHdjehNQtx/xHK4y0m8rnijUnDK8vblrGGqVweZMgz
 0fi/tJpatX3AMiPK2QSTvg2gHY8O+PA+jIyrBnlgrq/9LkZr4qq63q8GIq2cgG1fcTA8
 0pUQ4eYs02eHhhNEdoSItr2E5qZhDIv9n7hjQqMdPtDjmlJ9rSNiYKKFHkTKaTuV41CW
 gBgwCbtfgC5sD0QVUrqR3F9EcJNcFYHFRLzLPViv9SzO5bTXBPfrPKmtPgWZ9e74+HWz
 5Nbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnTQ1LNXgtkhcpETYcfODFvbsX1JiTiBKRYXZbjdG/Jf8JtHJc7AiT8Qz1p/0h9DXwnR//RQcFhMwe5C/hjTjbcYVxHw==
X-Gm-Message-State: AOJu0YyZuBYqW+mROlZT3OC71bM96z7RgmiSsStmITiwcbeVIED7Nawa
 fkgE3AIblum40ZzCB09izlI2W6BdSUZH1HnaHAHiu4tAilq067w2qkoDoqEgzRo=
X-Google-Smtp-Source: AGHT+IEpZbW/PubO2JGSEx4oRa1dI5e+/k2jS846YyplQGbSFbP/4I98JqlFv9XZQp/zNwUjNPdFTA==
X-Received: by 2002:a50:cd16:0:b0:57a:7585:bd4d with SMTP id
 4fb4d7f45d1cf-57a7585c12fmr117735a12.42.1717416413961; 
 Mon, 03 Jun 2024 05:06:53 -0700 (PDT)
Received: from fedora.. (cpe-188-129-45-221.dynamic.amis.hr. [188.129.45.221])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-57a5cbece23sm2380391a12.61.2024.06.03.05.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 05:06:53 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: trini@konsulko.com, caleb.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@linaro.org, lukma@denx.de, seanga2@gmail.com,
 joe.hershberger@ni.com, rfried.dev@gmail.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: j.beck@linefinity.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v3 1/5] clock: qcom: ipq4019: add ESS clock
Date: Mon,  3 Jun 2024 14:06:12 +0200
Message-ID: <20240603120651.154670-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.45.1
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

ESS clock is the Ethernet Subsystem clock, so lets add it as its
already configured by SBL1.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/clk/qcom/clock-ipq4019.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/qcom/clock-ipq4019.c b/drivers/clk/qcom/clock-ipq4019.c
index 72f235eab2..09be203d4b 100644
--- a/drivers/clk/qcom/clock-ipq4019.c
+++ b/drivers/clk/qcom/clock-ipq4019.c
@@ -44,6 +44,9 @@ static int ipq4019_clk_enable(struct clk *clk)
 	case GCC_USB2_MOCK_UTMI_CLK:
 		/* These clocks is already initialized by SBL1 */
 		return 0;
+	case GCC_ESS_CLK:
+		/* This clock is already initialized by SBL1 */
+		return 0;
 	default:
 		return -EINVAL;
 	}
-- 
2.45.1

