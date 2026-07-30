Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF25C54FDF
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 09:32:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B75AC80F38;
	Thu, 30 Jul 2026 09:32:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BZvFJ-6jpjLz; Thu, 30 Jul 2026 09:32:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5724680ED2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785403932;
	bh=ckRFjDKJXDZQoqBlsLVxKuLo1Id+PNGtgN783RLJhnU=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=AJEwmrYszNOKV9QqscwoR9c1ylV4sVHy1j6DXVxzwTK5loJN2RW0K97DduSA7FhAO
	 lpTPEajwR/Ow8cwAUKtzH8p2+2tc5Ar01J2F9fANoEYGZ1K93V3L9DXJmrY2fag9AM
	 ffZ1OMK5A4eDEJiZ2eeyhUB2+JQBF9l5lYsxpJ9N22h6YU1T1gg1e4+gerEIzvUdB1
	 UhR/tbBbZoRWlJGHQ/Jcqd16yXtwMFMoTDcDhKARJariYaA+zYkLAjCU8IY65QXN++
	 iLXhJmpvGp5K58depNkCTGvrt3nvjnSCVCq+F3A1hbwvzNWiN83E1YP9QDKEKly4M5
	 ToRyUk20QxOdA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5724680ED2;
	Thu, 30 Jul 2026 09:32:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E32769
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 09:32:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 645AF6067B
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 09:32:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1vVAVNRj4LhA for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 09:32:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1EDD260794
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1EDD260794
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1EDD260794
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 09:32:09 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-471eeac43bfso1737302f8f.3
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 02:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785403927; x=1786008727;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ckRFjDKJXDZQoqBlsLVxKuLo1Id+PNGtgN783RLJhnU=;
 b=qApcjcUvTMR3BgbYD3QBIPKPzLEFnBo+RkQqYaBQHwyfBP65t5nr8IO0i+Q/Aj7ODp
 MChQE6dpBkg9JWWfi6HXc9hMStFT0gDAFiTtsPPxLizh9Fktq9KLZw8JeYs8hF1YONil
 Ah0iQinrT14KaTLTtxz8oN1ldxkaOiATiFF1Fvpz85xgCFKuttCoykuj5Baw6bxc5hHO
 gL49yOdnqt6M+WQ66dShepOfICU4DGg70qU5C1IzoT6nr4dPraFVqa8kb7Q7m5PBPBJK
 s9yvYv8992VHx+7MrlAnd+AIZDzi4l56CrKS3BsDWOqRD0lgsvAi1bJfjdrZvvSthqga
 T2gQ==
X-Gm-Message-State: AOJu0YyyXquTaKas7t2qLwawUi3LABSgu0qP0Sq2LjN0XJbOcRwDx7vT
 E2OgSEoa0SftN7ycax+ECCxmwFX6nIPhVznMyt3srjn+lxo1DAsyDTV9HIyon4iTugDrh0//W0j
 4EbO81HWfsA==
X-Gm-Gg: AR+sD10Rghc/XuCFva8aZPq1uJ2SVJ6c8erHXGBZMEgTmfOnbLA2KVbHaWwOKdzwJUK
 1BxzFXeArYH8TwTzTz2DjtqE5bmKJ5E7iK3ZcENRNVs9j7P9boznQMEt21/Ww3m7jz/RxaLMejj
 s4O1N44gLMz8LJSE6nYZfoLjQfnfv6Cm4EBGMFzBhTBCo5hFEOE8bQOKlyxIw3Fuxiw9l0qv60W
 2nXhURqVYQrDOaXvbiuWuyu3RJGIrf01hg0hh/dmHYIQpVrslIHMeHVgQC/5sOQcyfHjkTec9te
 xajpkbu4wYHQ616TV80DVaiw2w6I0E4L+BSTI6WXUdqBQQgM95R8M58iFdPJc8LRX2//stWGG0k
 UAbTzooAWYFIT/dUy7zOxdILdA3lWMWqWooslXlIjuRpWygwcW04ve5Kal0XR4EfH8wxVRUdoYn
 H4o6qlLZ8iIoptAiaOx1lS6qLuX/rFIf3XlV9CGxOIZjQTsywMiC00CmtO5jqimmYu3uLHwlUP6
 ekgdrlZTanqS3jk4ZblU7ZjOP2tSwXVQgyOlC499Ea85dojFPj9
X-Received: by 2002:a05:6000:2386:b0:47d:eedb:ee62 with SMTP id
 ffacd0b85a97d-47fc80cfc95mr2550981f8f.14.1785403926447; 
 Thu, 30 Jul 2026 02:32:06 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae.
 [92.99.174.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc89351e3sm4837679f8f.29.2026.07.30.02.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 02:32:05 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 30 Jul 2026 13:31:47 +0400
Subject: [PATCH] spl: Fix link when LZMA is enabled without legacy image
 format support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-spl-lzma-link-v1-1-03bb8331029a@flipper.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDc2MD3eKCHN2cqtxE3ZzMvGxdY5NEs7RUE2Oj5LQUJaCegqLUtMwKsHn
 RsRB+cWlSVmpyCcgQpdpaAMHHAdxxAAAA
X-Change-ID: 20260730-spl-lzma-link-34a6fe432cfd
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1442; i=alchark@flipper.net;
 h=from:subject:message-id; bh=uyTK4Jrqvf+saE1QCEGXgbPOonEN4OnFw459V6S1h4M=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRlS7G9qU8u7zjgcDNise/S1S6nxPV3ui4yPMmYElp5/
 Pfzm3U2HRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oZGOsY4RAxenAEz1xZMM/zN+5Kfoez94UyV8/D4X57lz00tMtJZHJ3+UfLNtl4XADQmGP9wPuac
 H+zB1Hcv/fHfJQS7GsOIJvaefbznPy5g+2fnURH4A
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785403927; x=1786008727;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ckRFjDKJXDZQoqBlsLVxKuLo1Id+PNGtgN783RLJhnU=;
 b=TcpFbCXxcvC3rko1hE0z0FcVF8eLyzovJWBjn56YEnW6J5il3JFLBkUVk27nnRZTx5
 7VXRY7z8pV75wP47qMhWkrgT2s4te7nX9uvkB3wefMmT4IMouVTWXC3kuHMsExS30XaR
 COBLL0N573q5qdBSiyLcoETn0LihKDJVSvq+UGegXyWPPBQo8/Q/NZMZdl04SA/cD4EL
 x7IggnBttZq9uTNVBUZL2wF0TQa9tfxK0oWee1v1a5hFd10coxZtu8G8iytOdOjE/FVM
 yzShGZoFYc16bvXLKNuzPnWFjD0+i9p9UQapymJFzMWoNwhaT+ncY87Z/9W54MyHjjwQ
 y4bA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=TcpFbCXx
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

spl_load_legacy_lzma() lives in common/spl/spl_legacy.c, which is only
built when CONFIG_$(PHASE_)LEGACY_IMAGE_FORMAT is set, but the call site
in _spl_load() is guarded by CONFIG_SPL_LZMA alone. Enabling LZMA
decompression without the legacy image format therefore fails to link:

  ld: common/spl/spl.o: in function `_spl_load':
  include/spl_load.h:73: undefined reference to `spl_load_legacy_lzma'

CONFIG_SPL_LZMA is also needed to support LZMA-compressed payloads with a
FIT-only SPL, so add the missing condition to avoid including the legacy
image related function call when legacy image support is not built.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 include/spl_load.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/spl_load.h b/include/spl_load.h
index 525e0c9e86c6..31ed5651f7bb 100644
--- a/include/spl_load.h
+++ b/include/spl_load.h
@@ -63,6 +63,7 @@ static inline int _spl_load(struct spl_image_info *spl_image,
 		return spl_load_imx_container(spl_image, info, offset);
 
 	if (IS_ENABLED(CONFIG_SPL_LZMA) &&
+	    CONFIG_IS_ENABLED(LEGACY_IMAGE_FORMAT) &&
 	    image_get_magic(header) == IH_MAGIC &&
 	    image_get_comp(header) == IH_COMP_LZMA) {
 		spl_image->flags |= SPL_COPY_PAYLOAD_ONLY;

---
base-commit: 44f0dcf476140c1077ee3dbe16a80fdb6f8265c4
change-id: 20260730-spl-lzma-link-34a6fe432cfd

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

