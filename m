Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 469A3C5DF9C
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:44:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D9A7860618;
	Mon, 24 Aug 2026 16:43:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vMOtTI41BBk7; Mon, 24 Aug 2026 16:43:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787589839;
	bh=+EVoh8XxOEFKgm1TTfgZtymBd7LymCMMMb5c9KyxQVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1GwwzfG1jXQDaBLRH2+TfNrAbdX+qMol3vOv1/XGF5n5dCAI/aL2c6roAuWKFVr2w
	 XYZ+suNYmR5f5yvbOlakBv5Oa1PIWEQ0ZvB34Wj+d7bZIDxM5dr6j0K1Vje3Xojo9i
	 O+1FnOH3vKFbo9GUq5fq6lq4ii1jCqCv8dxKL8OKjXtx9xpCsdaDoIjJRhSa7TCnk1
	 /6GRjxT1e8ofnNK/K0PBRqKzX2WXOImymOg6nlKGh5iPPPN3/4lQjtTHvpA/57JAcR
	 T6Pb9RxKJhP27AoAPkyY+XiKi/+gmtTIEDdKSVT3/Wd2LltdtdbvAEAkXPgET/QJTC
	 WTYLOziZKSg8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2959560606;
	Mon, 24 Aug 2026 16:43:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 22661279
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:28:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 15142807B8
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:28:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J0rcAbunmtXE for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:28:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=LjxFmnIA
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 16C1880845
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:28:05 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c166ec26696so31566066b.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787585283; x=1788190083;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+EVoh8XxOEFKgm1TTfgZtymBd7LymCMMMb5c9KyxQVE=;
 b=LjxFmnIAyHG2xLvNR73ylgpnFNJ0fZVC6JlG8sPIZp/6AJbBk0EkvqSLcP6uvzlKAv
 4qa8h4HIaV6cH6wov9924RX5+FeDjWJNgDIP7S5DUZDk1n3GdhB56rZbw/wFJSZasS/C
 bltvKmfUfruE2S62bHbZeSVJucU49broqSPjxroRb7e61FeeyBlso7fCSdisGUKm5eqk
 PTlZDGk6yDgVRvnHoSTzYucBErocTG09rW6qLvuIF+IrcSUmTCothD6dhCnk+mlPFU9u
 nV8Yx7sU/i7I/oh0t+e7sBMZQx7lcbWIob3DcAN7MA/K9GzlfT45sAamusboOFITz0NM
 Sb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787585283; x=1788190083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+EVoh8XxOEFKgm1TTfgZtymBd7LymCMMMb5c9KyxQVE=;
 b=L1NJ6cG1Xc1VrdrfoxXl9ugw2vq0+bTppoIlKIFNQJCLbmODwJvbrJEYh21PPjQjJk
 X5paUQJ+nt5m3J8dI6OeyEUJtUEhUcH1bXsD2uj4sW5y7Lz/QmNfx+y5Dzsu3MNbCJHE
 hbS0ln7iJvo+KLonaBEV4Pw9zNyl0VqqJA3aWmWHTUsuWk6B0C0hsJRhJKqFWQaoV6HF
 lv4qYb3O9kRWWGbDiRnyovUYVIdUWWx6biWYZiJzpDjw2vSPSxwZsXTJ8Yb/sB2ynBVv
 FoCXJCsKfrpGjqL/YhCkPd2wbqQRqPLOa5Y4qI9mcdLy0PyV/0PChz79Rz/xGSzGXA3g
 8o3w==
X-Gm-Message-State: AFuF++lM8C7NdyLkduQVmih4vn8Kt8paLZiHSdHxGfZTPLpEeFqJxKU1
 Kc0zEOiSpd896Z3yAZdKTsagYMpdzSBzt4eWR3xQr8/LfS0imkLHuGtG4d/Ux5PNLiSwwXsFh0z
 pVe07
X-Gm-Gg: AR+sD10dMMNQrDQ5epkjgesVRKIoiga5a+PodEYlnSDcLnPVgp4mHXCDaq01me9rHiS
 pjlrd5np9fNepq7Q9H15nd7+7Sj9ztLtn7I6uLO400JGVEra2mUpqQro4EqKg7V+brDnsx9BLen
 rfIKfuuYrG89eO8kZ3w3fafHn2XWSJ+9WM2f4whPhC4dLP0NPq4en6NyBdlfBvttYMn0xwbauTT
 cqDg4/EUHswOlqgEl6FkIYqjkv2PLAcwCRq+pSXvT3l0tpqHDvSk3XZ2vyvfxfXXMkTayVcUccH
 xLJK9efY+wUaa+Z1LHOH8xZmkSBh7VSCOIhPUTCS7a9c79r9fzy8Aezpcc2RVF4N9+bmgf3dGI4
 FhP4Rw0EcGrnIEpPlwmjekoqp8DX/CKFAuMudrMqd0U3FHUimHbiWvxdgRJ50l/eROHS91FH/qr
 4/na86lG70ip6Aqv5hmDtqt4HeNQRbelNG0FGsZ3s7cTWqOHwLDzkun4XMahuHyEPxSjZgRrCkY
 6/hFVX4YU3uEEaXzGHcPjk=
X-Received: by 2002:a17:906:c144:b0:c1f:e0fd:1140 with SMTP id
 a640c23a62f3a-c2469f92425mr1416152966b.0.1787585283556; 
 Mon, 24 Aug 2026 08:28:03 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249689fa1dsm1247744766b.56.2026.08.24.08.28.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:28:03 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Simon Glass <sjg@chromium.org>, Anders Roxell <anders.roxell@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH v7 03/63] usb: dwc3: import from kernel v3.19
Date: Mon, 24 Aug 2026 17:26:34 +0200
Message-ID: <20260824152734.159794-4-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v3.19-rc1 to v3.19.

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

List of commits: git log --oneline v3.19-rc1..v3.19
Commits imported:
39e60635a015 usb: dwc3: gadget: Stop TRB preparation after limit is reached
ec512fb8e561 usb: dwc3: gadget: Fix TRB preparation during SG

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/gadget.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index f03b136ecfce..8f65ab3a3b92 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -882,8 +882,7 @@ static void dwc3_prepare_trbs(struct dwc3_ep *dep, bool starting)
 
 				if (i == (request->num_mapped_sgs - 1) ||
 						sg_is_last(s)) {
-					if (list_is_last(&req->list,
-							&dep->request_list))
+					if (list_empty(&dep->request_list))
 						last_one = true;
 					chain = false;
 				}
@@ -901,6 +900,9 @@ static void dwc3_prepare_trbs(struct dwc3_ep *dep, bool starting)
 				if (last_one)
 					break;
 			}
+
+			if (last_one)
+				break;
 		} else {
 			dma = req->request.dma;
 			length = req->request.length;
-- 
2.53.0

