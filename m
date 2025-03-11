Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 508C0C282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 17:56:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 648438198F;
	Tue, 11 Mar 2025 18:55:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Hd8R/RR1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 243E581870; Tue, 11 Mar 2025 18:55:53 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2865C8175D
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 18:55:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-30bf8632052so44222121fa.0
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 10:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741715750; x=1742320550; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jf1YQUmbSggfz/i4bgUEtv/RDb5+VnIeiUd5TD54XNE=;
 b=Hd8R/RR1b4OCm8FA46Pls4PBr27kWFNyhyBlOkgawpMUzq/xrvAHjOj3DficaXgejM
 mzsN3SLz3xYZC7CSygiaa8r9MAIu0954fhaAFlmogU3Ck0Bxou5cFxaqTFYw8RdAop5F
 ibEsfjYEab60tlrYToTz/58WAk65qRS0KiXKI7IUHmi/zlCL7s8tLN9K1dQlruAxSnBd
 wdk1B087PoCX5FFdAyxdJlg3LUP/oG9Q8cgN0nOhMhS9MqMX/l8RCq4qDo9pvwGQEFS5
 Ob2W8A5lSIJob/xof0YgpgIX2on7BzgwFZlnbCOxgl7ILE+5Ftfb/XsWDuCLPoX30puQ
 NWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741715750; x=1742320550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jf1YQUmbSggfz/i4bgUEtv/RDb5+VnIeiUd5TD54XNE=;
 b=cCEG+VBbetaLflHlOvCdG6wXV/KxasBx95Zi4MX5osqWJle/VqxBoek8BeySjGGInD
 sAFCNYSzt1SQ28PZNzbModRSxq2zzfd0PQIocO+ih7qEoCGRjfMLf6GcLyA6iW4+OJX9
 Rk2atCxhmHMaE31QUdSaipcxyi0F2RGNIGlafAc/oIpDLBDagFSWTyKy+LejuCVyT8At
 c8u1sOYSR2sP3NHsci3G0p9fudMsASpN0dztdTCOS4zdYW1JhFpyR4jfuAI6rx33L1GA
 XWVHfzflxghuRD0ar+vd1Jti3LW2zdiqcOxb2d38UaACGmcn8HkRGLDJyQmc36esYZiz
 j6ow==
X-Gm-Message-State: AOJu0YxcnqT+M49Wd2b8f2M6lF1YRSoGLN49uxN64UXHAa1DY5I9zi+6
 /FvQiKyDDl2TGrMHHhnWhxWqI/ObDY1miL40j8NEda4dCiOH+oXK
X-Gm-Gg: ASbGncsHkEluxWY7LDDzMud9+Q2bVXzRXZr3+bxGM+8FuDSX4dyPqLNcT6NM/0+jw6x
 mqrVo3KeTUwS8J/4FPDKgumfl+9r8hm4aMGRfSaK5DiCie0cNRQBtwsjRJVi1zi0oaUbODFoKSy
 AcV4gCm2d2NcVH4Jc+gqFpRTZ0vD/D6aWTIvuJK6H5ipjzWNsErYz383kSxmcd65rAfZshOMT+y
 GpaNA9wpm4ywt+qjx/GrqtnkP2tr5IHFB3+bZsttoRXApVlEh4Dm6kCYETW/4AvQS30xwGx9vIK
 AcepzBxFmjgTuWZaZkEhEYLECS5cfAh0ud99v4XU5jLsBhA=
X-Google-Smtp-Source: AGHT+IElDVxmngCAxExIIL7pxrz6Ir0a8XM2agxEmISNGeKHiuPTKDi59zafqvDWt/bN4tOwfohriA==
X-Received: by 2002:a2e:a985:0:b0:30b:ed8c:b1e7 with SMTP id
 38308e7fff4ca-30bf452d883mr63306331fa.18.1741715750266; 
 Tue, 11 Mar 2025 10:55:50 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-30bfceebd49sm15542811fa.60.2025.03.11.10.55.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 10:55:49 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 5/6] configs: x3_t30: add 3 second delay before power off
Date: Tue, 11 Mar 2025 19:55:21 +0200
Message-ID: <20250311175522.120018-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250311175522.120018-1-clamor95@gmail.com>
References: <20250311175522.120018-1-clamor95@gmail.com>
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

Introduce a 3-second delay and an informational message during boot to
enhance user experience.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 configs/x3_t30_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/x3_t30_defconfig b/configs/x3_t30_defconfig
index c8da5b4ce35..2d72a3bd56f 100644
--- a/configs/x3_t30_defconfig
+++ b/configs/x3_t30_defconfig
@@ -21,7 +21,7 @@ CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_KEYED_CTRLC=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_BOOTCOMMAND="bootflow scan; poweroff"
+CONFIG_BOOTCOMMAND="bootflow scan; echo 'Boot configuration not found... Power off in 3 sec'; sleep 3; poweroff"
 CONFIG_SYS_PBSIZE=2084
 CONFIG_SPL_FOOTPRINT_LIMIT=y
 CONFIG_SPL_MAX_FOOTPRINT=0x8000
-- 
2.43.0

