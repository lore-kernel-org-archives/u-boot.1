Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B705BC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 11:36:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1159E849F0;
	Tue,  7 Jul 2026 13:36:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ROqLjW2N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 810B1849D2; Tue,  7 Jul 2026 13:36:17 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37866849F0
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 13:36:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6a364f76a46so56211eaf.2
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 04:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783424174; x=1784028974; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5/topJ67Yd74mo1+6KJE3s8VDK4aasO/B2GVIZAmMlk=;
 b=ROqLjW2NMVWgDDIClV98qOr3PRUhyYuYl92C+wlGFzTv7X//xjvjCPOdKl7ZuR8O7O
 gh90sPRQoeFQxpCe1lmrQTRdqDuQyAMdSG499Xfctss7dDdvFelW3qCeXzLCRmbIsdcu
 RfOuJ+oIEQSJQ1DNtQxckVmyY9Xw+zrstVjhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783424174; x=1784028974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5/topJ67Yd74mo1+6KJE3s8VDK4aasO/B2GVIZAmMlk=;
 b=Cu56ZetT0RYehALGih2Nc+ZMj+fh38EoCF/8AnGlcn6gtjyjIJYvzL/VY3OO1BSlxg
 KkpHqAjZ/TaNlZdx2ux56qZyyJ9jLrutNq9nbG7EkmvK/CThwKgkNbNeXWWHs3nUAPv0
 cP+jDOUBOfWQ9Ow3L0LgKw19Lb8mKzc//zhzk/Sm2HRYPi9WMrvwtfz+PfmWyclNNJFy
 PpvrtsxvS4pxWYBaR3pBwZ1McdHTUmpglSU8gKZ19UEiOALM1OAikiSeSidXvI4EHuRh
 7oIb5dlzzeKsgAdKHTChfLTkaWwRaXwdIcax/PWRR5Oh9Mb6rRzxeJzzPtnBQ250m/bH
 VqIw==
X-Gm-Message-State: AOJu0YxhuPAwIs7K8bNLAhixqMHYHqhpvQAgeVjfHDY+4E8jLDgMQo83
 ZHVRZndLlzJZI1PaMQLf6fCfrfCIhJV4XHjIuL+mqzz5piVb/nOe5Lvncg1ToDxq2jKodSv88Cz
 9TeZsMw==
X-Gm-Gg: AfdE7cmnKA0lxl8xqFdHIcZF2QdMKw+4Xhhg8GM/SJ6HTyuRPnb7gcUpLdTeTpDoVua
 TiZKK2StLHW3Ua7HLd/ftbEPu8eIGkYgECObpBNonFU3U1wI+PwO6qVJQPEHBAw4wburqDai4Am
 UaBfzm7trllTdnxr2g5g3rV0yt16CyApClhrNZ92KcfB8gjJrv5SaO8Pn71V7rcZ2ZpiJYK6UGG
 dDxRZxzaTgMVHjxu/6ZKuHWczZ8Lb5uZxPC5gnJlJ/pd4eSdb6zcd8Fkxlwix4QKPvlXc7AfHGv
 qIhR45iyzEyS6sNtwA6Qc7iUi7N4Fa2igqA0TqU6EeOVHLnK4UF7oXseme1pjxqY2oj7+QOg2SK
 eBHQdM4AQivjluaTBLEtrmWepXnA5hyQuR81ciVYneWqWlNCrigGPHAs0s6XhXOD45atgNA2QE2
 8dx6pKyvU=
X-Received: by 2002:a05:6820:a289:20b0:6a3:fe4:956b with SMTP id
 006d021491bc7-6a3555321e1mr2191524eaf.37.1783424173973; 
 Tue, 07 Jul 2026 04:36:13 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb6691d1sm13440825fac.17.2026.07.07.04.36.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 04:36:13 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/13] qconfig: Drop args from KconfigParser
Date: Tue,  7 Jul 2026 05:35:07 -0600
Message-ID: <20260707113538.3382145-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707113538.3382145-1-sjg@chromium.org>
References: <20260707113538.3382145-1-sjg@chromium.org>
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

This class does not actually use the program arguments, so don't pass
them in.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/qconfig.py b/tools/qconfig.py
index c60cf5c4d1f..077d2fa4742 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -290,14 +290,12 @@ class KconfigParser:
     re_arch = re.compile(r'CONFIG_SYS_ARCH="(.*)"')
     re_cpu = re.compile(r'CONFIG_SYS_CPU="(.*)"')
 
-    def __init__(self, args, build_dir):
+    def __init__(self, build_dir):
         """Create a new parser.
 
         Args:
-          args (Namespace): program arguments
           build_dir: Build directory.
         """
-        self.args = args
         self.dotconfig = os.path.join(build_dir, '.config')
         self.autoconf = os.path.join(build_dir, 'include', 'autoconf.mk')
         self.spl_autoconf = os.path.join(build_dir, 'spl', 'include',
@@ -392,7 +390,7 @@ class Slot:
         self.reference_src_dir = reference_src_dir
         self.db_queue = db_queue
         self.col = progress.col
-        self.parser = KconfigParser(args, self.build_dir)
+        self.parser = KconfigParser(self.build_dir)
         self.state = STATE_IDLE
         self.failed_boards = set()
         self.defconfig = None
-- 
2.43.0

