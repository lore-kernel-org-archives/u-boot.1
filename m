Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09433FD45FA
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 22:51:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52D4183EB3;
	Wed, 25 Feb 2026 23:51:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fSHBbi+j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C2D583EA6; Wed, 25 Feb 2026 23:51:30 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D836283E61
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 23:51:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-8954c9daaeaso3095886d6.1
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 14:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772059886; x=1772664686; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ffhJLoyGZhoU7jTA8W4RQB2ywigF+xIio76ODl6NPeY=;
 b=fSHBbi+j91Xhb3EXi+jBHNOQmxp0sVGjcDoSXMjFBH20Bqe8T4KFShmAtRMDOEAeif
 KRgSJ4SL2pIfBYZgGT9gNgG9m8Xx0B2faID1O7lvgZVzyG1vttHE5xPk9W7fadj6OH2F
 B+rUFMi6gmOaQVrJig2GldvN5BXj8Wro/9esk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772059886; x=1772664686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ffhJLoyGZhoU7jTA8W4RQB2ywigF+xIio76ODl6NPeY=;
 b=meFKhTqp0R1NE2+Weg+4TrPOFTy9C6SdYOaU/XMBvIdHubYGoJ4Xz2ADmy3yZQ/XPD
 kvy6rol97R/cq5h0pfof25ssRMDudD601X457sy2mv8JZ8w7yvuU+nrn3umxm/nD1zb3
 hnYTgalsxq9REk0XYStIqONAB1TGlOjtF2+VuMowFrIQlEMug1PFme2HrlxClQMuAa5s
 ytOs+4NDlOqv2JsmqZUu4AFiNSWbKi5hluR5rHdNvbkLSlt76i0CQEKrkAA/eDFEDpNT
 +b9FWAAaRF3imncA4yChs77lbe70f6OsSTvchXo3K5JRrPbbUjH3XLRxLl0elgZ2kYhg
 v4sw==
X-Gm-Message-State: AOJu0YzVCp07uHZD7Ueo2IjzapsMWr4zvYZxg1k886tZrUverjROLSFC
 bWrh2GXBnG2+8CF46Pe8rWWDHQp8RG9RG6aiCslomU0BgNO3VYEix6WF9n9EMcL95PRPLNq1o9F
 y0hs=
X-Gm-Gg: ATEYQzxT4zs1QosioW5YzK9q2lylzorCKX+awG3+fNCLuXqd2wZTY8+tRqPJ8Qco4oN
 OPcEqFNaISKeOhylltbvqS/dF4AdLSOo9D1OEHQ4feej6uf8IA+dh+dUsgZilrQKQ/pR2dbc6AV
 sNcDxmnWv/g+2VoerSqRcom1bF8a6Dp5DqjD7P9NJl7kitabqB9p/nlTKNfZborrrGDZ7W3vftu
 dna/22bZ82yQlsMGYJgrt9rqQaGjbJAUvUdcHX7v1XfvMf1DMhJwShCaXhw9X+7ARkOdXYl3jAZ
 U97E9eC1V5IlV8i4Wn+KTY0H5NHnjTxkDuNnOI4VTtsMI9e3BVVIsiEsCTqu4sKqLrFfVErSfBM
 PQmeAPJNn04/MrwcOFzEm1bvrr48jwC+IT9APFE6nUeWns2Iqe/NGGpEjT3Hua5SrRfE72dn7dh
 +jPg5wtw+ttYYsmKxi0A==
X-Received: by 2002:a05:6214:1d04:b0:899:b7f4:6fe7 with SMTP id
 6a1803df08f44-899b7f4719bmr59891166d6.0.1772059886065; 
 Wed, 25 Feb 2026 14:51:26 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf72e21bsm43730985a.44.2026.02.25.14.51.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 14:51:24 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <simon.glass@canonical.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 5/6] binman: Remove the coverage allow_failures list
Date: Wed, 25 Feb 2026 15:50:34 -0700
Message-ID: <20260225225040.2568118-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225225040.2568118-1-sjg@chromium.org>
References: <20260225225040.2568118-1-sjg@chromium.org>
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

From: Simon Glass <simon.glass@canonical.com>

Now that iMX8 has full coverage the allow_failures list in
RunTestCoverage() is no longer needed.

Drop the list.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

 tools/binman/main.py | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/binman/main.py b/tools/binman/main.py
index fa5ad79ca0e..a0c775fd629 100755
--- a/tools/binman/main.py
+++ b/tools/binman/main.py
@@ -95,15 +95,10 @@ def RunTestCoverage(toolpath, build_dir, args):
         for path in toolpath:
             extra_args += ' --toolpath %s' % path
 
-    # Some files unfortunately don't thave the required test coverage. This will
-    # eventually be fixed, but exclude them for now
     test_util.run_test_coverage('tools/binman/binman', None,
             ['*test*', '*main.py', 'tools/patman/*', 'tools/dtoc/*',
              'tools/u_boot_pylib/*'],
-            build_dir, all_set, extra_args or None, args=args,
-            allow_failures=['tools/binman/btool/cst.py',
-                            'tools/binman/etype/nxp_imx8mcst.py',
-                            'tools/binman/etype/nxp_imx8mimage.py'])
+            build_dir, all_set, extra_args or None, args=args)
 
 def RunBinman(args):
     """Main entry point to binman once arguments are parsed
-- 
2.43.0

