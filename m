Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42981C61CE3
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:44:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C281606D5;
	Mon, 24 Aug 2026 16:44:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z-86SkasOoUm; Mon, 24 Aug 2026 16:44:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787589865;
	bh=Z/XSFvz+BpEp3exlTwvYDve6FFo0jOKQHaZWopIeGc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DXLODdZH8jd4azfuIfba7e9DVpKMyOuP7XHKIb8nYEI5nnnTNNwz5tXCCJD1rJic/
	 hzVcBRhFHiQ8GPCv4GJSVXkM7nKUdsdX4wozWLUSrBuoPEuZpWouNvn5ELGaurXebf
	 s5nC0INqRy7IWe5mx5ExKij25PZpOitMbx8WUbK6DrVHsw9Xa1QRACcA8bDTh2pwbx
	 bLjBS5Zhpu1nK/sg5eKYEW0a8S+03LGnUq6MDwOJevPaE2NH2bijpCHV9JDrDN8lVI
	 EEmyFv9Cb6lqTSIcTUcLGMCTAFRgo5OWFReAYmIGW7VcwkF0yde7jFafTNHyryDzHg
	 4a79K+3Zj5Bug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 74FD560693;
	Mon, 24 Aug 2026 16:44:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C73E9279
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:28:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B928C605EC
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:28:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 87KqquZ7IwUt for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:28:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=BnuZjCx7
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BD05F60667
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:28:57 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6a59ec8f530so204546a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787585335; x=1788190135;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z/XSFvz+BpEp3exlTwvYDve6FFo0jOKQHaZWopIeGc8=;
 b=BnuZjCx7pegXnce0d2vqAPiLmR4y5NYX9UAA+SVLM1V1Dnj26zc25NpkubpYM2PKvS
 U10/U3p8eNcZNxLhmJf7AfLRmU270ZyVkQQUen/bg7uiLAF2oty6g2+ilzHvtrehh4P0
 lt09HwoUaFHP7wEI9fjmhdbCWxIcAi90rHsExurDP1j8817jzjRHsZo8OHqkXD46qR9G
 aSxuynLQUd/u+PRa9wsvH0fY2jsOTbZ8M3thxi9Tht82TZjDopZuDBF9fY02wuEbw5Kx
 TSgLpyxMELBi2O9TWgpzT9g6a8AzPT6tJaHLwgbAJgr4layA25pRaH7HdFn+DqUK4OeH
 omjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787585335; x=1788190135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z/XSFvz+BpEp3exlTwvYDve6FFo0jOKQHaZWopIeGc8=;
 b=fRn3GWg5denmq/QXfFsRCg6EpiINH5GJMD1efMbcn1Nh+cz1cnwJCP+IxmVD0Bg/b8
 tuR18elJ0eFix39zn2nTEpd/FlEYZ5zAf8dKDUZYwhzh+8RybsQo6OFFdgP+/pokYran
 VaR1QY/XPYWBzqI5Dv/25BzLMIuPkf67W6w9O3jnjKNWudxkVxxfDCJeYMP2xKLP2mTr
 b6BVkXO/9jV2dYEnWVfOQyYcXTGOhz/E0L6SR/ps1OL/WKKM1dGlbbS1pXfE7zs0AFuJ
 fhKMybhOnr+dhd4GlgUw7wovzZqTt75wN4eEZyRCNV6VPdcgV/JCc97Y093ov6zW5JRg
 lAVA==
X-Gm-Message-State: AFuF++mUqs4eZ+oNUvZGUekMXS2VisxdfTLZ8J/OtXEkfuyOIsTrweWR
 hr2S5ZqtK53j+mUuQ/Kd//TB/fGPn9627mBOV6ci7ZSrVXK0lD0fzsV4yRPbDY0XtLIVw2Z/D7d
 5Cumv
X-Gm-Gg: AR+sD12yVzgastJr9kKrKOZfhYI0is7uf32qnaGK3uEcHWdRH7wm3p+nV0DlJ4w/juZ
 fiotm1MW9E7uk3As7Mikq7uGZDJtnR3lXRpgcv6VnMv4hNV81sLXa10xNV3/5gKH+C7EY6C2Aak
 VrcAfu2d+9V96cb0gzRuUgzGxYFM0SzHrXW8O/+NE6hv3E9TQPw3FEEgnUOwCSmtIbxrqncmmCT
 FezgHWfP2Cds7hPImL4feOmkK4BLxzlVipVWiUb6kGm3ceZd9sJTH9Fz1P9uBJlAUtEq3tooPLY
 YIjSbxGHg2fmUv4dVjI38C62/+yUOa5i7DnUbp23qz+wP2gxwd3iR9QWLrbq37J/YuukgSp3qUj
 TcOa9PBTKnw1Qj9HBJSeiDomWCFM1V8Ja3vQJ06Ofq+vP0dP9Vcm9G0zYLH/S11HXu1ziWpYmMh
 Z4w3NFjIkqTwsyNp+JttOZctXi3sUVTVnKaKAsowufalB8ckbpUYgdFkrjLm1yQmqppLS7Bfj74
 zgyr+XWrqkBR2cvAWib/rsHAU2So0r4
X-Received: by 2002:a05:6402:5d0:b0:6a1:d68:338a with SMTP id
 4fb4d7f45d1cf-6a42eeaf432mr15901052a12.0.1787585335413; 
 Mon, 24 Aug 2026 08:28:55 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e1cdbe9sm9209455a12.24.2026.08.24.08.28.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:28:54 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH v7 18/63] usb: dwc3: import from kernel v4.14
Date: Mon, 24 Aug 2026 17:26:49 +0200
Message-ID: <20260824152734.159794-19-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824152734.159794-1-anders.roxell@linaro.org>
References: <20260824152734.159794-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 24 Aug 2026 16:43:55 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Jens Wiklander <jens.wiklander@linaro.org>

Sync Linux kernel dwc3 changes from v4.13 to v4.14.

The following files are preserved across the import:
Makefile Kconfig dwc3-meson-g12a.c dwc3-meson-gxl.c dwc3-omap.c
dwc3-uniphier.c dwc3-generic.h dwc3-generic.c dwc3-generic-sti.c
dwc3-layerscape.c ti_usb_phy.c

Skipping unused files:
debugfs.c drd.c dwc3-exynos.c dwc3-haps.c dwc3-imx8mp.c dwc3-keystone.c
dwc3-octeon.c dwc3-of-simple.c dwc3-pci.c dwc3-qcom.c dwc3-qcom-legacy.c
dwc3-rtk.c dwc3-st.c dwc3-xilinx.c host.c trace.c trace.h ulpi.c

Note that this is a raw import and doesn't build.
A fixup commit at the end of the series fixes that.

List of commits: git log --oneline v4.13..v4.14
Commits imported:
551684708356 usb: dwc3: ep0: fix DMA starvation by assigning req->trb on ep0

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/ep0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 827e376bfa97..75e6cb044eb2 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -990,6 +990,8 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 					 DWC3_TRBCTL_CONTROL_DATA,
 					 true);
 
+		req->trb = &dwc->ep0_trb[dep->trb_enqueue - 1];
+
 		/* Now prepare one extra TRB to align transfer size */
 		dwc3_ep0_prepare_one_trb(dep, dwc->bounce_addr,
 					 maxpacket - rem,
@@ -1015,6 +1017,8 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 					 DWC3_TRBCTL_CONTROL_DATA,
 					 true);
 
+		req->trb = &dwc->ep0_trb[dep->trb_enqueue - 1];
+
 		/* Now prepare one extra TRB to align transfer size */
 		dwc3_ep0_prepare_one_trb(dep, dwc->bounce_addr,
 					 0, DWC3_TRBCTL_CONTROL_DATA,
@@ -1029,6 +1033,9 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 		dwc3_ep0_prepare_one_trb(dep, req->request.dma,
 				req->request.length, DWC3_TRBCTL_CONTROL_DATA,
 				false);
+
+		req->trb = &dwc->ep0_trb[dep->trb_enqueue];
+
 		ret = dwc3_ep0_start_trans(dep);
 	}
 
-- 
2.53.0

