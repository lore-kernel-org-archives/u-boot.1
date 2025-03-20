Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA26FC36000
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 14:01:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3659C81A0E;
	Thu, 20 Mar 2025 15:00:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qoQRRYIK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74C3C81D25; Thu, 20 Mar 2025 15:00:43 +0100 (CET)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10DE58198A
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 15:00:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-301918a4e3bso1512328a91.3
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 07:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742479238; x=1743084038; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lhix8ue269ZQvpf/js7AQOKKx1zlsWcrWtgLhPvlOXY=;
 b=qoQRRYIKjUlTavTZkarmPC1zkbtzScn0r/oWkWuGwCyylMVY3sbGSuBb2nih+fz56r
 cBgBo2QHLNmbfqlHMUFg1FxlrAeQgt9lt6fjMeLSzXmdSz2t6apbg1/5kxkD8lhrKrxR
 ZDgsIo0k9T+J4fBV3cH5j7RkpSpu+dMdSLRMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742479238; x=1743084038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lhix8ue269ZQvpf/js7AQOKKx1zlsWcrWtgLhPvlOXY=;
 b=FeV52S9UgL9e+jHzHXW9ZkkPFBZuvDUa3y/CN+6BjN6FPsFrJBQ7cKKZoJWrlbwq2y
 iKkz0xbIsKY5Iop+MoTQ3oVrTWhfZ60+Cni+maTbCwTtSGWgpHtw0EOR8Rspq1V6Zvce
 RGyydE/jBX73PwSrTOGCQMS+UgM2wgCMaABq7o/J1y/LDLS/RXPGr3T3lQKeg/dLjvoB
 9fjMoOtp7hT0zybVfdPubFPj5+fL+gJ3CJ76tSq+SKyTxHT36dXafayI42wY5kiFfuoG
 jVu3v1ECYa9j9ENekT+zdfCrXgkaBZJqIVyDDkqlAeUkZ0o73KYJQ+6rHS5pGLQS3bC7
 p6Sg==
X-Gm-Message-State: AOJu0Yy3HDSlczYZXRb9uCBrJW7D6+OySRznsPO+Vuz6b7xcMmyX5oPq
 mz9LyhDH5XMAU39QJ7KAgLscZHcW+hr/5wF+mcUGI4GPjjL9U9YtLrICXGPx0UVCF3FGENgEKbD
 t
X-Gm-Gg: ASbGncti0JqG9xYycB6vT1pc317QGjyDPbTNI0948JN3Vet4GKNWokXoDBrs2lb2ccr
 nIaIDrMO1CzhNczImNYIlQQgijyXmSXgOQjwB8mKbPShwXCsmOC1kFzjvWczDe2MBxs1ss3Q9iz
 b3fqNs4n/k7/06w6lfjAzPK9kcq95hW/94//qXBjh0E4Yahu6i51ZbGq27UGLTQ6kgePAShZKMg
 jQUjeh0fCfxZPa9s9eht9gmtml5PfUBT4/XKYAusxh191J2apZ8mHAE+01TGLpkCv+v6mdyZsML
 DQulYDZnyPAJHKeXy1zjSRMCQBedFg7GXiJ/yfQRUyRKwmc4
X-Google-Smtp-Source: AGHT+IGL3mEjriUSu9TWIhVN5ovYFwJ20mppu9kaa0Naf86yGNExq5PBUagq56h4hMrL606mIrFSTg==
X-Received: by 2002:a17:90b:2ed0:b0:2ee:edae:75e with SMTP id
 98e67ed59e1d1-301d50b4f3emr5066603a91.13.1742479238398; 
 Thu, 20 Mar 2025 07:00:38 -0700 (PDT)
Received: from bill-the-cat.. ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf59cd49sm3857532a91.22.2025.03.20.07.00.37
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 07:00:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH v2 04/10] test/py: Fix a problem with setup_image
Date: Thu, 20 Mar 2025 07:59:25 -0600
Message-ID: <20250320140030.2052434-5-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250320140030.2052434-1-trini@konsulko.com>
References: <20250320140030.2052434-1-trini@konsulko.com>
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

While we can be passed an image size to use, we always called qemu-img
with 20M as the size. Fix this by using the size parameter.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- Rebase on next after the ubman series.
- Only the image size parameter not being used in all cases was a
  problem, drop the other half of this patch.
---
 test/py/tests/fs_helper.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
index f3e81b6bc61b..2faab21509fa 100644
--- a/test/py/tests/fs_helper.py
+++ b/test/py/tests/fs_helper.py
@@ -95,7 +95,7 @@ def setup_image(ubman, devnum, part_type, img_size=20, second_part=False,
 
     try:
         check_call(f'mkdir -p {mnt}', shell=True)
-        check_call(f'qemu-img create {fname} 20M', shell=True)
+        check_call(f'qemu-img create {fname} {img_size}M', shell=True)
         check_call(f'printf "{spec}" | sfdisk {fname}', shell=True)
     except CalledProcessError:
         call(f'rm -f {fname}', shell=True)
-- 
2.43.0

