Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21F6C2BA18
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 13:33:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DC448852E;
	Thu, 20 Jun 2024 15:33:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OvjyYHM6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17C318853F; Thu, 20 Jun 2024 15:33:52 +0200 (CEST)
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com
 [IPv6:2607:f8b0:4864:20::d42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E11F188288
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 15:33:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd42.google.com with SMTP id
 ca18e2360f4ac-7eb75c0d0a7so26689539f.3
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 06:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718890428; x=1719495228; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=M0tH8tqPiFESNdfd4zp7jQF+EEprRPtTwpJZL01S61M=;
 b=OvjyYHM61lDIB4utM82yhGQfFEdV083ZH0+XLamTrEIyYEcj4+Blz8araNFgRgKx7v
 zIblLAkn57zT90awmOTt7OTlMHx0ZsCWYhz5LLEUSS5v704gPY+Ue/NPL6xvTicvEiwL
 cK0dkUB7wgSlrXAYoFfTyPohZH7324+URkvqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718890428; x=1719495228;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M0tH8tqPiFESNdfd4zp7jQF+EEprRPtTwpJZL01S61M=;
 b=jRnttctUlF160hIkycT/uRDIrnYCfrKsDF1CeWK3cAZRo6yju/5ApMPB0wowDlQhou
 Pyunzm1zoIN/rD9F+w69Z2eSGiI4YfgA8uMzN2OmNri9clvV/FGe6wr3NUlBVMXuuH+I
 N9Fe5kq5iACKdXAC8R7QOYaBiotWvw9K0/aGcDtgSFhIYHPDqAZqT9yLWcjBQ0P+ZLHq
 kwcFC9YSN5KpAbxG2CZky+DNNI9nt8HfVuGMHww+utFVdsciHlLw+ReHXAuR+G6dF+DB
 JfkVMKBQ8knVs0rlF9zfyEbW6OUsfy/jkuC1IknvnQFbCi88BgVBF0MZAXHQyIulr/9e
 IcUA==
X-Gm-Message-State: AOJu0YyluCEcTX/0JyPKIpVbcmOBrOmursnGL0B41h0hQWs23dmjKLPH
 7CO68OM+IPZ1vRiuOhab+2Hzs7YiABxL7lVhIiIE5HAS2l0Tx22db4Gd8yaeYW1IczFT5lRfRCv
 j2n7d
X-Google-Smtp-Source: AGHT+IEAsEdRM2YhZM5Lo1qkf9rLttMQ4SEkprxVNOFkcra/WKHXrTsRSgaHlNLCpXVn/cgP3Wouqg==
X-Received: by 2002:a05:6602:1488:b0:7eb:89ba:44fe with SMTP id
 ca18e2360f4ac-7f13eea39d3mr545226639f.17.1718890428485; 
 Thu, 20 Jun 2024 06:33:48 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7ebdba3cf47sm371112139f.16.2024.06.20.06.33.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 06:33:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH] RFC: Add a tag for the world builds
Date: Thu, 20 Jun 2024 07:33:46 -0600
Message-Id: <20240620133346.1135479-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

Currently the world builds run on all runners, including faster and
slower ones.

The difference can be quite dramatic, with some builders 4x as fast as
others, resulting in just one world build taking between 20 minutes and
an hour and 20 minutes.

Add a tag so that we can select which builders run these CPU-intensive
jobs.

With this tag we can also increase CPU utilisation by running multiple
QEMU tests in parallel. Currently these tests leave most machines fairly
idle, since we cannot run more than one world build on a machine.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 .gitlab-ci.yml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 165f765a833..750c4ff5f4d 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -2,6 +2,7 @@
 
 variables:
   DEFAULT_TAG: ""
+  BUILD_TAG: "build"
   MIRROR_DOCKER: docker.io
 
 default:
@@ -92,6 +93,8 @@ stages:
 
 .world_build:
   stage: world build
+  tags:
+    - ${BUILD_TAG}
   rules:
     - when: always
 
-- 
2.34.1

