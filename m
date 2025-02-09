Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9970AC0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 21:19:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 102B080F1C;
	Sun,  9 Feb 2025 22:16:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y6i6LB3/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA0B980F5C; Sun,  9 Feb 2025 22:16:41 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDD9680EF6
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 22:16:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3d162ecb2beso699245ab.2
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 13:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739135797; x=1739740597; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S1dV6h166WwjHQIYAfFW82dkT6NYQ4p1bW6Vdr+jEPc=;
 b=Y6i6LB3/Px/UJQQmGt1J0+la7rk5GxNI/qw/ta4zxXvQOgkH/vVRGo+IWaFkHk94Yt
 CDKJSGXyCF373mOJeXK+OMFplgdO37IQPdLrc7IwnY/XyKXz53NArJlC97aWMCX2wJfx
 KYeqOA+8MaCPeezXI/Fi+Td0WcUQe+Yo0tspI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739135797; x=1739740597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S1dV6h166WwjHQIYAfFW82dkT6NYQ4p1bW6Vdr+jEPc=;
 b=jknpri8m64gPPxmQge88IJuM59rp6fFYq10ki1ISRkMgtZXEddctexwmpGNeFLjt5x
 VbVMmdlxLB0imeYTvcgOkVJH1t1ie79gY6ITmGc81GrooMIzR7EO3jPl4zaQxZOAfcSb
 IvP9ZyISJsTlufKU76FW8QcdNni6WT6JERaob3+SoM3TdailhzFwx6GDNwdtSXXu2waX
 dD5GWJKYqeba4OkYBrh9DBG3jHKGgU/HXFD4z+Q7l/7ECqIoGvp4BOKKWRzvm2/ehrwe
 egiyV/mH349nPJOx+C39B0z7Dy9F/6ErUsr9QaaFVQJ7zu/QANN73UPg8z659FVCvMod
 9rfw==
X-Gm-Message-State: AOJu0YxplCe18dj48XZRznPQqvnbaTCk+xmNEzNWG886RuEfp6aSX1Bo
 KhJPhXHEXKYv5DoiLC6AV8pAfBwsSs4atRjkgGVI66SO+HIcWabP8QG3hD/gdI9st8yT5fNjFbE
 =
X-Gm-Gg: ASbGnctAb/N99fiGpejA0/xgeR9HHtbOxGjfPkIl5TcstE9UKC/LmAsVTWeU0Fre6Nm
 hu4lIVsMToose0OVUfgGR3AoMEhQKbWHIxMMPFT3/ssp0sILry1U1vURnMvTrmHRIinbsU+etGl
 k5Nvt/823Vp0rdg1u06+3hN5VVPIlKwuysfPE04l1OYMTYmffpdIKNsE5K1yCYdzc+HA02gt8qK
 iJHLnaw+ONrUcuPosdEs/W73DC9e+MjrBipiJNVP8RPO1RuwgpcQWccWmLR/kqZq3jJh6x+E3ZE
 IW/NDM3NY3j+GU8Ry6jcJbIyhiZrjAqCTW67klrPhF5ViIu3jWWb
X-Google-Smtp-Source: AGHT+IE9QgnCMrH4xfNCNHb4vDKFIs7iwKPwrQOf3cj8BLZL/E6WV8xG9OYtK6Hkuv2PrrZNQDh6pg==
X-Received: by 2002:a05:6e02:1b01:b0:3cf:cbc0:b401 with SMTP id
 e9e14a558f8ab-3d13df551d8mr81972105ab.20.1739135797281; 
 Sun, 09 Feb 2025 13:16:37 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d05e96f245sm18978655ab.51.2025.02.09.13.16.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 13:16:35 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 29/35] gitlab: Add an VBE board to the sjg lab
Date: Sun,  9 Feb 2025 14:14:50 -0700
Message-ID: <20250209211502.2299245-30-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209211502.2299245-1-sjg@chromium.org>
References: <20250209211502.2299245-1-sjg@chromium.org>
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

Add a rockchip rk3399 board which runs Verified Boot for Embedded.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 .gitlab-ci.yml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 8c49d5b0a79..a9daa7bb84e 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -745,3 +745,9 @@ zybo:
   variables:
     ROLE: zybo
   <<: *lab_dfn
+
+# Firefly-RK3399 board running the rk3399-generic build
+vbe:
+  variables:
+    ROLE: vbe
+  <<: *lab_dfn
-- 
2.43.0

