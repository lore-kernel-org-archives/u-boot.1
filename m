Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DBE9C02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:32:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1317800C2;
	Wed, 15 Jan 2025 14:31:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="D7ZMtmrS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C904807E0; Wed, 15 Jan 2025 14:31:26 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AF2A807C3
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:31:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-844e9b83aaaso528241139f.3
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 05:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736947882; x=1737552682; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fVK8GMQBac3TRf1BvvaAPbNxEhTw4Ikh7JPzyw1ByjY=;
 b=D7ZMtmrSGor7RDi7N3Nz9rTeRBjfLlYMovSijxCp2u9DPOJC+yZrwt++eUn+r8RD6F
 dxP0NOTYnAzfb56tEC6HrMEXtY/7uK2pv6PBf7cNozCySTm9CKFZeEDezqkT5Wzdncbq
 P30tURhk1nnGe0UeIeduyqhnwmOFxHkGr69kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736947882; x=1737552682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fVK8GMQBac3TRf1BvvaAPbNxEhTw4Ikh7JPzyw1ByjY=;
 b=f5MooFWR8FzPAEEUQOnfov0lFh1ws8lX0Zsk43dV3DfzunW/XEzmlPiR50Cs2ZqMGw
 jsoN5T6xkD4dts2upSqCUXmeAcDHJDGFp2IlNWw8OuerZWYHF1QYM4fKOjFWHXxTfEsp
 rfn4erHk4E+uwZnqOwyyM3VWRuSNIwcxesjzO2QQzFhGAA9r0FyNnYgFpPqqy4anBthF
 6TBoylWoN8FdjucMkxhxOlFMropY/bFwdTIUkoycmW4QPWMosMc2bKzTq6WOUiO20RPV
 nbTq3ogJahlMsSV2FCKPy9zL7PISRJQbIA9/tuivyR+Kp+bHrMCTT4jPeyc4PVTCebnN
 Yc1w==
X-Gm-Message-State: AOJu0YzvghevjXGnEXcx+81+RtXSWFcg/CRv0axMD/SE7TLOiyYi78u0
 KGHjaOpLPlOBfxG3GUB85ri0CiFB/kzXTk5WflzlUqswKtcBnjgYFABIonxPMx3fz18dwJQz4sA
 =
X-Gm-Gg: ASbGncu43od0jIXX/cXBCdCYv0986oUlZeTvbNPgm8/TnE1AaHa7WF9xGWTVQtjKkmP
 WZqPzljiPvz0crNkM6gwoA9G9Ygmx9NItWcYyPbHM2x7pvE8SVB4RCKXrWROqExDTebJEUZC547
 5eMp3/yhfolwPJ1xYu6/6+z0ap+4r+FT8wD0PwixI8T8y1Kn1shR8RY4vY2axsB0cCSjIusemww
 Q3Ki85jK4keCzZC77BTvO9b1xJ+bvys5I1G1tw1TvWnM/NCmwEpnz2GXSNIB2QvkcBH/7j1whPx
 sCwEv0Kh/w9ycplqdg==
X-Google-Smtp-Source: AGHT+IGZDJN2B93NsFpLt9KuOlVG4mkQF+ro95Ml67yPw70C7u3lBEcsYOR2d0rA2iU5yE8I47lnSQ==
X-Received: by 2002:a05:6602:3a0d:b0:84c:dab3:4194 with SMTP id
 ca18e2360f4ac-84ce003c935mr2660469339f.1.1736947881785; 
 Wed, 15 Jan 2025 05:31:21 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm4091248173.20.2025.01.15.05.31.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 05:31:20 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 01/43] test: Drop unused suite prototypes
Date: Wed, 15 Jan 2025 06:30:31 -0700
Message-Id: <20250115133114.590375-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250115133114.590375-1-sjg@chromium.org>
References: <20250115133114.590375-1-sjg@chromium.org>
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

Drop some the prototypes for functions which were removed in earlier
series.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/test/suites.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/test/suites.h b/include/test/suites.h
index 2ceef577f7f..e40ad634702 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -36,8 +36,6 @@ int do_ut_bloblist(struct cmd_tbl *cmdtp, int flag, int argc,
 		   char *const argv[]);
 int do_ut_cmd(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_common(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
-int do_ut_compression(struct cmd_tbl *cmdtp, int flag, int argc,
-		      char *const argv[]);
 int do_ut_dm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_env(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_exit(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
@@ -55,14 +53,9 @@ int do_ut_overlay(struct cmd_tbl *cmdtp, int flag, int argc,
 		  char *const argv[]);
 int do_ut_pci_mps(struct cmd_tbl *cmdtp, int flag, int argc,
 		  char *const argv[]);
-int do_ut_print(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_seama(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_setexpr(struct cmd_tbl *cmdtp, int flag, int argc,
 		  char *const argv[]);
-int do_ut_str(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
-int do_ut_time(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
-int do_ut_unicode(struct cmd_tbl *cmdtp, int flag, int argc,
-		  char *const argv[]);
 int do_ut_upl(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 
 #endif /* __TEST_SUITES_H__ */
-- 
2.34.1

