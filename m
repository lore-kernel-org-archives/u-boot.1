Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A11CEE49A5
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 14:26:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13FD58705A;
	Sat, 19 Aug 2023 16:24:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1692455087;
	bh=qlcaB0WfkiwpusCegZQinz8CBH119uvhclQ/zGkTHec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=panSGNqdvkE+3JL7Ojyd7RzoKRedIFWs3M4Y3EU2QJ9UVfAOpvUkOpXowvGA1FvqT
	 tt0q7+XGBFVxcLIhrnOOVUR6jJmJS7VBzCPMAssr63hPYsXP4HIfTRAmDKWKDuaHZP
	 Gxo/m+iuFT3k6FFTpzkWE1LoZI3uD7vgZuE9uU5oBekIZUpKZPfql1qrg/1u6o0nf+
	 C4ubl1FOf0rVlrUkYQzwhGNOARGIlOUu6QBOoHAd490RpMzdhwGcVJE1C2JzZfn1Zx
	 t+7cbC4OXZxpXzy5hH77Q02/022lRn68MaJlqKyDLJAuSv28V7R/ByyfSakTf9DDB3
	 BoQVZ4BpLLKew==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 1ECD58700A;
 Sat, 19 Aug 2023 16:24:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1692455083;
 bh=qlcaB0WfkiwpusCegZQinz8CBH119uvhclQ/zGkTHec=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ooubjMrmDisoPD1DnHol6YeXzrkzGxGKwRYam5TYiBGj+NUDMX8hGWH/Rydq7vRkF
 R3sxMGd09kTY9BCRV7vCuMdcLacsOsziQrLDgBXJdLiPsUnNvOg9SG2PKJjh0QIKZo
 ADNu9s9wUR6UqwpIibboy1u3lBHQmdVLufviCLDHxp0V14dk6Iqk/cFRAVdAmrHb3d
 OqGCxzTCOhb5Scx3qGIh64zlLhJnHXdQkN/13kOCGt3G8Bbx/P1mKZp3Nmfvf+sPCG
 bqCTzoVu7xdsgGMCAOAKg8lapFKpJcCrAaTH6dr+dKox0sy0eSjTh8bgX7sjd01QOx
 DzmpEGXGtBcQQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Angus Ainslie <angus@akkea.ca>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nishanth Menon <nm@ti.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, kernel@puri.sm
Subject: [PATCH 11/17] spl: sdp: Detach the controller on error
Date: Sat, 19 Aug 2023 16:24:01 +0200
Message-Id: <20230819142407.49632-11-marex@denx.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230819142407.49632-1-marex@denx.de>
References: <20230819142407.49632-1-marex@denx.de>
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

In case anything errors out during the SDP transfer, detach
the controller instead of bailing out right away. This way,
the controller can be reattached on next attempt.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Angus Ainslie <angus@akkea.ca>
Cc: Dmitrii Merkurev <dimorinny@google.com>
Cc: Eddie Cai <eddie.cai.linux@gmail.com>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefan Roese <sr@denx.de>
Cc: kernel@puri.sm
---
 common/spl/spl_sdp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/common/spl/spl_sdp.c b/common/spl/spl_sdp.c
index cc4fb4f7cca..f6b99c1af5a 100644
--- a/common/spl/spl_sdp.c
+++ b/common/spl/spl_sdp.c
@@ -25,13 +25,13 @@ static int spl_sdp_load_image(struct spl_image_info *spl_image,
 	ret = g_dnl_register("usb_dnl_sdp");
 	if (ret) {
 		pr_err("SDP dnl register failed: %d\n", ret);
-		return ret;
+		goto err_detach;
 	}
 
 	ret = sdp_init(controller_index);
 	if (ret) {
 		pr_err("SDP init failed: %d\n", ret);
-		return -ENODEV;
+		goto err_detach;
 	}
 
 	/*
@@ -42,6 +42,7 @@ static int spl_sdp_load_image(struct spl_image_info *spl_image,
 	ret = spl_sdp_handle(controller_index, spl_image, bootdev);
 	debug("SDP ended\n");
 
+err_detach:
 	usb_gadget_release(controller_index);
 	return ret;
 }
-- 
2.40.1

