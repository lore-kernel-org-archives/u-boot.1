Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6674606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=a0mPR6+w;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gbAbHw7y
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9066D40737;
	Wed, 28 Oct 2026 14:46:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ypAUJIAYCf0F; Wed, 28 Oct 2026 14:46:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C5FE64075F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198818;
	b=bftHKIBZXvwF4LkVnhLLO0inv5eJjeCHsj4U4MvhDot8l2nXBFgwJ7MY6aJG5UM6E/9B
	 ktdFjoFu3Q/h1p9YAaLvFkUHPHfeERk5krRrNFPtaNNJjxGPuuom/CBHgCF/ic2+b7LiB
	 FBH/d9hp+YtUCLZ/rvlTbEa7kt4YnNc6NUWtyBaT/8OkC3nekL1C6oO3hRka2Z4ZYyMgP
	 nn1Ovp9SKxWggRikghJMrJKj6PloGl8Z/w/nTUl3JWo8Ji7uHqC7nwth7qNj9SyKAH02J
	 4nkJ2vy+aVM0H0hQTYpqhb2HUcSmiQFTvJHu7uKZgCRpOM2tJs1rgnzIpzu3TwJvnTQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198818;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ETKhTye6Ys68kpThf6YPzOkW8RrPsNqqHa77K+Kn6tQ=;
	b=GPSzFzrr0/8lusF+9AXFDTXmcgshx2hApHTQioVEBKrXvWMuF13M0t3zw0e0gIX97gar
	 ASozUy1ZnJO53ySM8pD/hg48Oo7VfIHAwwa9ai5UlmjvFaztgnxghz94dqll4W+6njvJe
	 fcKGD13BQsVdoZHvtHJbgufg9vPK530VJXUCOzxPexuxSmBtH/rnn5M1VrlhHfM6gEvoC
	 96yRO2O2ZgfdkF3+vdEk6XQCbJQ7Jd1gC2Qj5bdUuCiI8twrGG2aPVguJ6dhIQuvnCJgG
	 7JGY9tD1hHnsBvnOHl4x1xxyYuLuR3oR2ckmwskCtp1a9zNifnU+GEKJFtQYYEntaOw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198818;
	bh=ETKhTye6Ys68kpThf6YPzOkW8RrPsNqqHa77K+Kn6tQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a0mPR6+w53k3hhdR05VCQ2G3q34OC6iPf0zaalJ309viAt5LlX6lQ01BvBIq7HlfK
	 mCY2tSFy+OaTWgKIUZ2eJdcmeIXUq7uZjMzmgTnlh6zWjH/bKGvzpy97vhsWucEAfX
	 M73KJPH8F0S3IuRrRA7l7Mz9dcVpWlLV/E8/xsWCAfSb7fVn3QBTDcjStEWif4sJMo
	 utAkgwpAtUYYowIrVYAN+MfyXv7sPSmrPEXoKpsQghbfzNz/b8qDJgORfa6xPjfbd1
	 kO4DrzgUSqBFEPSFeEOJC3eJQpisIY3p5XcaNNJAPlWHKXq6InhTjuk+2Yv8NI+G93
	 cD0psnbTo67mA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C5FE64075F;
	Wed, 28 Oct 2026 14:46:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 402004D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:12:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 31F1B605EB
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:12:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fcl5FgXID-1D for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:12:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 46815605F1
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::52f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196750;
 b=HSfNTjLi41lko8u07mCQLc798rkuhzfniQXlu2lOokOoUkxuDmQuMbduCtJsGc7s578i
 IydBNxk+1tSTOQsJcDnTMrikTP9kohH+a8a5UaFU2nf+D1MxqCNnXAxRxqfH2man6POP/
 QyaozU+a4k3WeOkovbXlk7g0UyGAPsXrlChP9UZESjscBpWoAhhWCN0m4a5CeOhA6C0TV
 p6Dg3kFSzYrNLlcQWCJQ4yqOEAsG78H2+ZiN4AQdfwUMKcc0EjpzumLvHFv+phNMXMv7L
 55uV75vE7x+gsRU0YEv1V95UVAlzUOPQ3A3WHZAL05WrTT9T1cWeeZbQBdKHwpJ8a5w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196750;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=ETKhTye6Ys68kpThf6YPzOkW8RrPsNqqHa77K+Kn6tQ=;
 b=EGLFxNTs9YgxIz9zDp5sHjtXYfshmK7fOjSpWTygyghGkUENE5N3+ECL3pZNrSXih5T0
 z/ucO0D/x7GGkpsZp5/AXA4g0ybfN+y7TdjXmKFVHYiQYNjlGmc2M12nZk2HvM6I5VsWX
 9AExyTLIi9vQuY/kPxr2m5F2VJkl+XnwenkprMrSAF5eI/OvJyM9S2CyCz7zXTCCUq1Gi
 gB+GNGRH7WufJ8KBkOAkj5HWMC9qO4j1YYGX005OPVW4LAu8miUgGmRWwPEXcc4+461nS
 xPsZGPKA8dRyqtRE8do+RPKDtUjEJcFvHFwsMzVeAgC7VCDKwnm3AJL9W2U1MATDTBw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=gbAbHw7y; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::52f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=gbAbHw7y
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 46815605F1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:12:29 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6b4584287adso184663a12.0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196748; x=1793801548;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ETKhTye6Ys68kpThf6YPzOkW8RrPsNqqHa77K+Kn6tQ=;
 b=gbAbHw7y6sEgBPhbaXpx/ZX7Rc9J03aIu2oSIrY/XI9vTiLWOl2BjodQUk4t4OYc4m
 24/1P5WgAk91ya7ElE8V0TIOqphJGcF67R5qwjHJ+uFkqhfkBw6XH/Ot6ExcwS6ry9HK
 lHJWqtGSSGoZmRSYs0H0fMXU1EevuME5MttrCArExhT//78WOD/TwBy6SqevtcSHfPVq
 mbs0vrbl/yfeq02pyw8hvMAeqYOamcyF2I5gmoFnEeiOvRTlEsp39aK2AZui5H9ohW7e
 aGZO+Hm5HBr2Ro1Rk7QuN/U/LQEGqbqPzryYA7rVFkl8TXGvZtE4UCpCyaBOGmYZGfjA
 0fBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196748; x=1793801548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ETKhTye6Ys68kpThf6YPzOkW8RrPsNqqHa77K+Kn6tQ=;
 b=tLg5EbWZ5Uh66BUwDyjcLXXwoNxxep1bBnzVRbpfwGYsNVECXiHFiHg8OEssL+7E/n
 8ldXrbGGLIUJ/CPTLuPoR/0kx7buQsM4hSiEi6e323v+xX6iwYfYDhCRSBhtXp3m9lRd
 h76CsZkSbZNGVQlcxyg3RZNGfr+jgRS4fHv4mVMySm9f2fecK1vyP0SOTXkiJ6T/AIBp
 BlICN2+EAgh+DylxImas0gx3Mt76Oqf9bDHl3fLYCFir2llz6sivRZnMOWVBSDg2YfDR
 2L1ASkLSfXppufDaGsyFeWYph/+/KBsFoEAaJSJcKD4ZSE0wl2DzKnNf+0QtLHyFtf70
 /hIQ==
X-Gm-Message-State: AFq9FYL0awtHE1uDIaTaYVih04KATNXNQzb6+/TsNihc4R3PL3NJe2lG
 nIr9AKTqTumHaMM7cYJ7J0mDJO2MUOCZwVTzNspaIwca697o3b+RghKsQ34ozRHncODDp9phSyz
 qADcn
X-Gm-Gg: AYBFou3AqISNFs4wQl1kXp8DlNYNvWiOLJDslRl68KXx3TRDI76Im4bLi7lBOGSDsvA
 HvuC01hgKIf0GECu4NxSTDFzpaiacyI/UZioiLxw4wBr+kzs3dcHNciQ8ppRnz8ZCqA1WoNFGvf
 zgKdxh6P9/QM3MhaEUSgwVHruzWSala8W9FXmltPojc5vPvr7PIiawkR8BI08UgepFksGCfkVLY
 9Ls51aEB5lj4hW/IkdDr+IAYUSoglZc/N5ZBnSES18NJ9ptilz+sPOVbbVKv5DrpCujldb/l0Cw
 6f3+DFtwU5oQIRo8IpE5koLsINODSt+9W/f7panzwr7l6XINnDLcBlC7whbtgzE/VBSwzww3s4Q
 IKY2LnrRhzAdwemtr2HVTLGatOt+qzee/6BwLxNDiStZrb4pMZLLF6G48l1/WWrq1z5bncpgVML
 IsCuma5Zqj+Fx73npfTFFFcng6Kl5NCnDkaRuizInpWUGdVnbnyrPyYQ+eadOvx0vd7fUcE+J4n
 S3+t/8iYlXUBoYfSoB2bEEl3bP5Ak+3icVNeqmHzTv/ZFgCqJAsGg6sbwIA9wLu3Wnhg9oy9/Gd
 wVR4vaFfkxF4eoYcehu5iKvrrWq20E0mYeOGnMV2yyBtaMSAA8PJlrPs0vh7xkqMr0d3yPHznmc
 HY6eqzh5oUg==
X-Received: by 2002:a17:907:d645:b0:c34:db91:aa1e with SMTP id
 a640c23a62f3a-c49bdfbbe19mr309648766b.4.1793196747864; 
 Wed, 28 Oct 2026 07:12:27 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd4ea351sm606060666b.28.2026.10.28.07.12.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:12:27 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 34/63] usb: dwc3: import from kernel v5.9
Date: Wed, 28 Oct 2026 15:09:00 +0100
Message-ID: <20261028140930.3025368-35-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028140930.3025368-1-anders.roxell@linaro.org>
References: <20261028140930.3025368-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 14:45:46 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jens Wiklander <jens.wiklander@linaro.org>

Sync Linux kernel dwc3 changes from v5.8 to v5.9.

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

List of commits: git log --oneline v5.8..v5.9
Commits imported:
df561f6688fe treewide: Use fallthrough pseudo-keyword
bc9a2e226ea9 usb: dwc3: gadget: Handle ZLP for sg requests
d2ee3ff79e6a usb: dwc3: gadget: Fix handling ZLP
5d187c0454ef usb: dwc3: gadget: Don't setup more than requested
f5e46aa4a124 usb: dwc3: gadget: when the started list is empty stop the active xfer
c5a7092f4015 usb: dwc3: gadget: make starting isoc transfers more robust
ca14378560db usb: dwc3: gadget: add frame number mask
10623b879da3 usb: dwc3: Replace HTTP links with HTTPS ones
62fb45d317c5 USB: ch9: add "USB_" prefix in front of TEST defines

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.c   |   7 +-
 drivers/usb/dwc3/core.h   |   2 +-
 drivers/usb/dwc3/debug.h  |   2 +-
 drivers/usb/dwc3/ep0.c    |  12 +--
 drivers/usb/dwc3/gadget.c | 149 +++++++++++++++++++++++++++++++-------
 drivers/usb/dwc3/gadget.h |   4 +-
 drivers/usb/dwc3/io.h     |   2 +-
 7 files changed, 137 insertions(+), 41 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 25c686a752b0..2eb34c8b4065 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -2,7 +2,7 @@
 /**
  * core.c - DesignWare USB3 DRD Controller Core file
  *
- * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2010-2011 Texas Instruments Incorporated - https://www.ti.com
  *
  * Authors: Felipe Balbi <balbi@ti.com>,
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
@@ -646,9 +646,8 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 			if (!(reg & DWC3_GUSB2PHYCFG_ULPI_UTMI))
 				break;
 		}
-		/* FALLTHROUGH */
+		fallthrough;
 	case DWC3_GHWPARAMS3_HSPHY_IFC_ULPI:
-		/* FALLTHROUGH */
 	default:
 		break;
 	}
@@ -1411,7 +1410,7 @@ static void dwc3_check_params(struct dwc3 *dwc)
 	default:
 		dev_err(dev, "invalid maximum_speed parameter %d\n",
 			dwc->maximum_speed);
-		/* fall through */
+		fallthrough;
 	case USB_SPEED_UNKNOWN:
 		/* default to superspeed */
 		dwc->maximum_speed = USB_SPEED_SUPER;
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 013f42a2b5dc..2f04b3e42bf1 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -2,7 +2,7 @@
 /*
  * core.h - DesignWare USB3 DRD Core Header
  *
- * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2010-2011 Texas Instruments Incorporated - https://www.ti.com
  *
  * Authors: Felipe Balbi <balbi@ti.com>,
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
index d8f600e0e88f..3d16dac4e5cc 100644
--- a/drivers/usb/dwc3/debug.h
+++ b/drivers/usb/dwc3/debug.h
@@ -2,7 +2,7 @@
 /**
  * debug.h - DesignWare USB3 DRD Controller Debug Header
  *
- * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2010-2011 Texas Instruments Incorporated - https://www.ti.com
  *
  * Authors: Felipe Balbi <balbi@ti.com>,
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 6dee4dabc0a4..59f2e8c31bd1 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -2,7 +2,7 @@
 /*
  * ep0.c - DesignWare USB3 DRD Controller Endpoint 0 Handling
  *
- * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2010-2011 Texas Instruments Incorporated - https://www.ti.com
  *
  * Authors: Felipe Balbi <balbi@ti.com>,
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
@@ -425,11 +425,11 @@ static int dwc3_ep0_handle_test(struct dwc3 *dwc, enum usb_device_state state,
 		return -EINVAL;
 
 	switch (wIndex >> 8) {
-	case TEST_J:
-	case TEST_K:
-	case TEST_SE0_NAK:
-	case TEST_PACKET:
-	case TEST_FORCE_EN:
+	case USB_TEST_J:
+	case USB_TEST_K:
+	case USB_TEST_SE0_NAK:
+	case USB_TEST_PACKET:
+	case USB_TEST_FORCE_ENABLE:
 		dwc->test_mode_nr = wIndex >> 8;
 		dwc->test_mode = true;
 		break;
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 80c3ef134e41..c2a0f64f8d1e 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2,7 +2,7 @@
 /*
  * gadget.c - DesignWare USB3 DRD Controller Gadget Framework Link
  *
- * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2010-2011 Texas Instruments Incorporated - https://www.ti.com
  *
  * Authors: Felipe Balbi <balbi@ti.com>,
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
@@ -46,11 +46,11 @@ int dwc3_gadget_set_test_mode(struct dwc3 *dwc, int mode)
 	reg &= ~DWC3_DCTL_TSTCTRL_MASK;
 
 	switch (mode) {
-	case TEST_J:
-	case TEST_K:
-	case TEST_SE0_NAK:
-	case TEST_PACKET:
-	case TEST_FORCE_EN:
+	case USB_TEST_J:
+	case USB_TEST_K:
+	case USB_TEST_SE0_NAK:
+	case USB_TEST_PACKET:
+	case USB_TEST_FORCE_ENABLE:
 		reg |= mode << 1;
 		break;
 	default:
@@ -1054,27 +1054,25 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
  * dwc3_prepare_one_trb - setup one TRB from one request
  * @dep: endpoint for which this request is prepared
  * @req: dwc3_request pointer
+ * @trb_length: buffer size of the TRB
  * @chain: should this TRB be chained to the next?
  * @node: only for isochronous endpoints. First TRB needs different type.
  */
 static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
-		struct dwc3_request *req, unsigned chain, unsigned node)
+		struct dwc3_request *req, unsigned int trb_length,
+		unsigned chain, unsigned node)
 {
 	struct dwc3_trb		*trb;
-	unsigned int		length;
 	dma_addr_t		dma;
 	unsigned		stream_id = req->request.stream_id;
 	unsigned		short_not_ok = req->request.short_not_ok;
 	unsigned		no_interrupt = req->request.no_interrupt;
 	unsigned		is_last = req->request.is_last;
 
-	if (req->request.num_sgs > 0) {
-		length = sg_dma_len(req->start_sg);
+	if (req->request.num_sgs > 0)
 		dma = sg_dma_address(req->start_sg);
-	} else {
-		length = req->request.length;
+	else
 		dma = req->request.dma;
-	}
 
 	trb = &dep->trb_pool[dep->trb_enqueue];
 
@@ -1086,7 +1084,7 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 
 	req->num_trbs++;
 
-	__dwc3_prepare_one_trb(dep, trb, dma, length, chain, node,
+	__dwc3_prepare_one_trb(dep, trb, dma, trb_length, chain, node,
 			stream_id, short_not_ok, no_interrupt, is_last);
 }
 
@@ -1096,16 +1094,27 @@ static void dwc3_prepare_one_trb_sg(struct dwc3_ep *dep,
 	struct scatterlist *sg = req->start_sg;
 	struct scatterlist *s;
 	int		i;
-
+	unsigned int length = req->request.length;
 	unsigned int remaining = req->request.num_mapped_sgs
 		- req->num_queued_sgs;
 
+	/*
+	 * If we resume preparing the request, then get the remaining length of
+	 * the request and resume where we left off.
+	 */
+	for_each_sg(req->request.sg, s, req->num_queued_sgs, i)
+		length -= sg_dma_len(s);
+
 	for_each_sg(sg, s, remaining, i) {
-		unsigned int length = req->request.length;
 		unsigned int maxp = usb_endpoint_maxp(dep->endpoint.desc);
 		unsigned int rem = length % maxp;
+		unsigned int trb_length;
 		unsigned chain = true;
 
+		trb_length = min_t(unsigned int, length, sg_dma_len(s));
+
+		length -= trb_length;
+
 		/*
 		 * IOMMU driver is coalescing the list of sgs which shares a
 		 * page boundary into one and giving it to USB driver. With
@@ -1113,7 +1122,7 @@ static void dwc3_prepare_one_trb_sg(struct dwc3_ep *dep,
 		 * sgs passed. So mark the chain bit to false if it isthe last
 		 * mapped sg.
 		 */
-		if (i == remaining - 1)
+		if ((i == remaining - 1) || !length)
 			chain = false;
 
 		if (rem && usb_endpoint_dir_out(dep->endpoint.desc) && !chain) {
@@ -1123,7 +1132,7 @@ static void dwc3_prepare_one_trb_sg(struct dwc3_ep *dep,
 			req->needs_extra_trb = true;
 
 			/* prepare normal TRB */
-			dwc3_prepare_one_trb(dep, req, true, i);
+			dwc3_prepare_one_trb(dep, req, trb_length, true, i);
 
 			/* Now prepare one extra TRB to align transfer size */
 			trb = &dep->trb_pool[dep->trb_enqueue];
@@ -1134,8 +1143,39 @@ static void dwc3_prepare_one_trb_sg(struct dwc3_ep *dep,
 					req->request.short_not_ok,
 					req->request.no_interrupt,
 					req->request.is_last);
+		} else if (req->request.zero && req->request.length &&
+			   !usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
+			   !rem && !chain) {
+			struct dwc3	*dwc = dep->dwc;
+			struct dwc3_trb	*trb;
+
+			req->needs_extra_trb = true;
+
+			/* Prepare normal TRB */
+			dwc3_prepare_one_trb(dep, req, trb_length, true, i);
+
+			/* Prepare one extra TRB to handle ZLP */
+			trb = &dep->trb_pool[dep->trb_enqueue];
+			req->num_trbs++;
+			__dwc3_prepare_one_trb(dep, trb, dwc->bounce_addr, 0,
+					       !req->direction, 1,
+					       req->request.stream_id,
+					       req->request.short_not_ok,
+					       req->request.no_interrupt,
+					       req->request.is_last);
+
+			/* Prepare one more TRB to handle MPS alignment */
+			if (!req->direction) {
+				trb = &dep->trb_pool[dep->trb_enqueue];
+				req->num_trbs++;
+				__dwc3_prepare_one_trb(dep, trb, dwc->bounce_addr, maxp,
+						       false, 1, req->request.stream_id,
+						       req->request.short_not_ok,
+						       req->request.no_interrupt,
+						       req->request.is_last);
+			}
 		} else {
-			dwc3_prepare_one_trb(dep, req, chain, i);
+			dwc3_prepare_one_trb(dep, req, trb_length, chain, i);
 		}
 
 		/*
@@ -1150,6 +1190,16 @@ static void dwc3_prepare_one_trb_sg(struct dwc3_ep *dep,
 
 		req->num_queued_sgs++;
 
+		/*
+		 * The number of pending SG entries may not correspond to the
+		 * number of mapped SG entries. If all the data are queued, then
+		 * don't include unused SG entries.
+		 */
+		if (length == 0) {
+			req->num_pending_sgs -= req->request.num_mapped_sgs - req->num_queued_sgs;
+			break;
+		}
+
 		if (!dwc3_calc_trbs_left(dep))
 			break;
 	}
@@ -1169,7 +1219,7 @@ static void dwc3_prepare_one_trb_linear(struct dwc3_ep *dep,
 		req->needs_extra_trb = true;
 
 		/* prepare normal TRB */
-		dwc3_prepare_one_trb(dep, req, true, 0);
+		dwc3_prepare_one_trb(dep, req, length, true, 0);
 
 		/* Now prepare one extra TRB to align transfer size */
 		trb = &dep->trb_pool[dep->trb_enqueue];
@@ -1180,6 +1230,7 @@ static void dwc3_prepare_one_trb_linear(struct dwc3_ep *dep,
 				req->request.no_interrupt,
 				req->request.is_last);
 	} else if (req->request.zero && req->request.length &&
+		   !usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
 		   (IS_ALIGNED(req->request.length, maxp))) {
 		struct dwc3	*dwc = dep->dwc;
 		struct dwc3_trb	*trb;
@@ -1187,18 +1238,29 @@ static void dwc3_prepare_one_trb_linear(struct dwc3_ep *dep,
 		req->needs_extra_trb = true;
 
 		/* prepare normal TRB */
-		dwc3_prepare_one_trb(dep, req, true, 0);
+		dwc3_prepare_one_trb(dep, req, length, true, 0);
 
-		/* Now prepare one extra TRB to handle ZLP */
+		/* Prepare one extra TRB to handle ZLP */
 		trb = &dep->trb_pool[dep->trb_enqueue];
 		req->num_trbs++;
 		__dwc3_prepare_one_trb(dep, trb, dwc->bounce_addr, 0,
-				false, 1, req->request.stream_id,
+				!req->direction, 1, req->request.stream_id,
 				req->request.short_not_ok,
 				req->request.no_interrupt,
 				req->request.is_last);
+
+		/* Prepare one more TRB to handle MPS alignment for OUT */
+		if (!req->direction) {
+			trb = &dep->trb_pool[dep->trb_enqueue];
+			req->num_trbs++;
+			__dwc3_prepare_one_trb(dep, trb, dwc->bounce_addr, maxp,
+					       false, 1, req->request.stream_id,
+					       req->request.short_not_ok,
+					       req->request.no_interrupt,
+					       req->request.is_last);
+		}
 	} else {
-		dwc3_prepare_one_trb(dep, req, false, 0);
+		dwc3_prepare_one_trb(dep, req, length, false, 0);
 	}
 }
 
@@ -1403,7 +1465,7 @@ static int dwc3_gadget_start_isoc_quirk(struct dwc3_ep *dep)
 		 * Check if we can start isoc transfer on the next interval or
 		 * 4 uframes in the future with BIT[15:14] as dep->combo_num
 		 */
-		test_frame_number = dep->frame_number & 0x3fff;
+		test_frame_number = dep->frame_number & DWC3_FRNUMBER_MASK;
 		test_frame_number |= dep->combo_num << 14;
 		test_frame_number += max_t(u32, 4, dep->interval);
 
@@ -1450,7 +1512,7 @@ static int dwc3_gadget_start_isoc_quirk(struct dwc3_ep *dep)
 	else if (test0 && test1)
 		dep->combo_num = 0;
 
-	dep->frame_number &= 0x3fff;
+	dep->frame_number &= DWC3_FRNUMBER_MASK;
 	dep->frame_number |= dep->combo_num << 14;
 	dep->frame_number += max_t(u32, 4, dep->interval);
 
@@ -1463,6 +1525,7 @@ static int dwc3_gadget_start_isoc_quirk(struct dwc3_ep *dep)
 
 static int __dwc3_gadget_start_isoc(struct dwc3_ep *dep)
 {
+	const struct usb_endpoint_descriptor *desc = dep->endpoint.desc;
 	struct dwc3 *dwc = dep->dwc;
 	int ret;
 	int i;
@@ -1480,6 +1543,27 @@ static int __dwc3_gadget_start_isoc(struct dwc3_ep *dep)
 			return dwc3_gadget_start_isoc_quirk(dep);
 	}
 
+	if (desc->bInterval <= 14 &&
+	    dwc->gadget.speed >= USB_SPEED_HIGH) {
+		u32 frame = __dwc3_gadget_get_frame(dwc);
+		bool rollover = frame <
+				(dep->frame_number & DWC3_FRNUMBER_MASK);
+
+		/*
+		 * frame_number is set from XferNotReady and may be already
+		 * out of date. DSTS only provides the lower 14 bit of the
+		 * current frame number. So add the upper two bits of
+		 * frame_number and handle a possible rollover.
+		 * This will provide the correct frame_number unless more than
+		 * rollover has happened since XferNotReady.
+		 */
+
+		dep->frame_number = (dep->frame_number & ~DWC3_FRNUMBER_MASK) |
+				     frame;
+		if (rollover)
+			dep->frame_number += BIT(14);
+	}
+
 	for (i = 0; i < DWC3_ISOC_MAX_RETRIES; i++) {
 		dep->frame_number = DWC3_ALIGN_FRAME(dep, i + 1);
 
@@ -2649,8 +2733,17 @@ static int dwc3_gadget_ep_cleanup_completed_request(struct dwc3_ep *dep,
 				status);
 
 	if (req->needs_extra_trb) {
+		unsigned int maxp = usb_endpoint_maxp(dep->endpoint.desc);
+
 		ret = dwc3_gadget_ep_reclaim_trb_linear(dep, req, event,
 				status);
+
+		/* Reclaim MPS padding TRB for ZLP */
+		if (!req->direction && req->request.zero && req->request.length &&
+		    !usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
+		    (IS_ALIGNED(req->request.length, maxp)))
+			ret = dwc3_gadget_ep_reclaim_trb_linear(dep, req, event, status);
+
 		req->needs_extra_trb = false;
 	}
 
@@ -2716,7 +2809,9 @@ static bool dwc3_gadget_endpoint_trbs_complete(struct dwc3_ep *dep,
 	if (dep->flags & DWC3_EP_END_TRANSFER_PENDING)
 		goto out;
 
-	if (status == -EXDEV && list_empty(&dep->started_list))
+	if (usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
+		list_empty(&dep->started_list) &&
+		(list_empty(&dep->pending_list) || status == -EXDEV))
 		dwc3_stop_active_transfer(dep, true, true);
 	else if (dwc3_gadget_ep_should_continue(dep))
 		if (__dwc3_gadget_kick_transfer(dep) == 0)
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index 24dca3872022..bd85eb7fa9ef 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -2,7 +2,7 @@
 /*
  * gadget.h - DesignWare USB3 DRD Gadget Header
  *
- * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2010-2011 Texas Instruments Incorporated - https://www.ti.com
  *
  * Authors: Felipe Balbi <balbi@ti.com>,
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
@@ -54,6 +54,8 @@ struct dwc3;
 /* U2 Device exit Latency */
 #define DWC3_DEFAULT_U2_DEV_EXIT_LAT	0x1FF	/* Less then 511 microsec */
 
+/* Frame/Microframe Number Mask */
+#define DWC3_FRNUMBER_MASK		0x3fff
 /* -------------------------------------------------------------------------- */
 
 #define to_dwc3_request(r)	(container_of(r, struct dwc3_request, request))
diff --git a/drivers/usb/dwc3/io.h b/drivers/usb/dwc3/io.h
index 9bbe5d4bf076..76b73b116862 100644
--- a/drivers/usb/dwc3/io.h
+++ b/drivers/usb/dwc3/io.h
@@ -2,7 +2,7 @@
 /**
  * io.h - DesignWare USB3 DRD IO Header
  *
- * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2010-2011 Texas Instruments Incorporated - https://www.ti.com
  *
  * Authors: Felipe Balbi <balbi@ti.com>,
  *	    Sebastian Andrzej Siewior <bigeasy@linutronix.de>
-- 
2.53.0

