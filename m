Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65201CAC587
	for <u-boot@archiver.kernel.org>; Sun, 14 Sep 2025 16:04:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A47D482A9E;
	Sun, 14 Sep 2025 18:04:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TrYnALOA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B37582AE1; Sun, 14 Sep 2025 17:27:34 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F36980B9B
 for <u-boot@lists.denx.de>; Sun, 14 Sep 2025 17:27:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=osama.abdelkader@gmail.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45f2c5ef00fso2733865e9.1
 for <u-boot@lists.denx.de>; Sun, 14 Sep 2025 08:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757863652; x=1758468452; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=p3y3A1UdRRuNYf/F2gPo5Za1hnmkOqlluqLyBLAjSuA=;
 b=TrYnALOAlpif5wQilfjvz1z4RGnuh0RHXYYE0gM8tH8XTbhppXNeocRlueeL8Gh6nx
 u4NJWwEB0/g/1dNlX6Pt9t1VRdyB1GUTdNP6i0mOKXgjsf2s3MC70Rk/Q3QvX13TjNdH
 aggBTp1KBzfyDFx5dHPoHoTiCjolz+ynCC4v1yfdN66JMReTrAp6ifrQglfcdUNQo7GB
 ibY/sNAgY2DsRasKd8K7yFTwgKTulrXWbowkLlz+gXx6EOl/FkbExA+qXebftJq+hHYN
 co8Xkq0LexcrrEXK6BaPmX38im26OGTh+EdjO2+X7k4QqVvvzHGzW0+p4ReX/Y0xI+J3
 V8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757863652; x=1758468452;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p3y3A1UdRRuNYf/F2gPo5Za1hnmkOqlluqLyBLAjSuA=;
 b=ljK/LTqZvhH/B6MljMqoD8NLSR7awm9VcaOX7Eq/D+5zF8Itwh69bHv/8Vbcq+qopa
 Q2ozeZb6uo3k/6hoCWDaElYa4hTUMd45IdkNPmxtnvZiA+1Tj3V7vOB5o+Ss4WCusldr
 fvXgoYJpY466gyNynQFgSf18C8tzodFBfSSZ/9fhykc9ZNMXYl1g7L1p0UhPfwi5bTX0
 2pSAU8KVajaWDsjhTp1CL/MNO5yPTL0xDRSG138iqpdeSJQoZl3xeT2ERnUxvT0F5PD2
 RyV1lA9hzOXufqroxiLzeCJ+cI/eaRLDVfvOvJHxyjqdz2GlEUrZmWDtwz39Ino3lAzu
 cLWQ==
X-Gm-Message-State: AOJu0Yz6lIcr4MX0cHr2MVH+rbUIh8oV2NPtQK4A4DraTAELPhpwxXIu
 lzf3tu919NFg6Q96tmVkB0P5fZWS6HrNe6ALfRIjjbI+na0pmFzkrS4u
X-Gm-Gg: ASbGncumIt70Ph9YcbWs5KRJiLjJbuAeM1gWu2NnaD1RRo9CFZpfworhJR4+1CtnSfr
 H2ifLL3FbsV+vXIqXqOzJXNKnnZUG8DXrclxjs/biRc+40utdCcL0ZiC5MDETSdsjDaf43sr0WL
 5kNXVH8SKsseAXKgSSn+Z/uqisicSGhgRzKpflzPb/YQ60xSnMVOrK/pA0ROz6zeXCZE1MuemQp
 kImVrLhOHGRofs5GGO/7wXm/SvkFUmtbtQAwTvM8CjIMhyQZNaztNaJ7quh/bT2HbIXgiclBJx3
 g2PlPcqe6xip+eW1hQxXQ6/d/fEknX3kciIzdqUf9wF8y8Ou0ohRpcSh+3Uvrt2FWgHRUe8FLXd
 1Q78ubgSWORtAd8VBwinOas5LumdHtSnOznYFbbfWG1lfffp6dK2JskDi+JyaY4cJ3jA3akbbDs
 FPMhuVaBKqT296lw==
X-Google-Smtp-Source: AGHT+IGZCicfedmvb3Bjjh2WrgJ2BCCckae2vbhyIF2+OxmJPLipafSiVeZ/JKY8n7olpukyv2zaUQ==
X-Received: by 2002:a05:6000:420f:b0:3e5:955d:a81b with SMTP id
 ffacd0b85a97d-3e7659c4248mr8096185f8f.34.1757863651651; 
 Sun, 14 Sep 2025 08:27:31 -0700 (PDT)
Received: from osama.. ([156.223.20.4]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e017c0643sm138106025e9.23.2025.09.14.08.27.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Sep 2025 08:27:31 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: trini@konsulko.com,
	sjg@chromium.org
Cc: u-boot@lists.denx.de,
	Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH] sandbox: use env_get() for time offset instead of getenv()
Date: Sun, 14 Sep 2025 17:27:27 +0200
Message-ID: <20250914152727.784016-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 14 Sep 2025 18:04:42 +0200
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

The sandbox time offset is intended to be controlled via the U-Boot
environment, not the host process environment. Update os_get_time_offset()
to use env_get() instead of the libc getenv().

Leave other getenv() uses (e.g. U_BOOT_PERSISTENT_DATA_DIR,
UBOOT_SB_FUZZ_TEST) unchanged, since those refer to host environment
variables needed by sandbox tests.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 arch/sandbox/cpu/os.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/sandbox/cpu/os.c b/arch/sandbox/cpu/os.c
index f5c9a8aecf2..e48eb23cdc0 100644
--- a/arch/sandbox/cpu/os.c
+++ b/arch/sandbox/cpu/os.c
@@ -35,6 +35,7 @@
 #include <asm/state.h>
 #include <os.h>
 #include <rtc_def.h>
+#include <env.h>
 
 /* Environment variable for time offset */
 #define ENV_TIME_OFFSET "UBOOT_SB_TIME_OFFSET"
@@ -1014,7 +1015,7 @@ long os_get_time_offset(void)
 {
 	const char *offset;
 
-	offset = getenv(ENV_TIME_OFFSET);
+	offset = env_get(ENV_TIME_OFFSET);
 	if (offset)
 		return strtol(offset, NULL, 0);
 	return 0;
-- 
2.43.0

