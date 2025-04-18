Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40831C369C9
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 08:20:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A139A831C2;
	Fri, 18 Apr 2025 10:20:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BkMytGvg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18E4B8312E; Fri, 18 Apr 2025 10:20:14 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D8FD82D57
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 10:20:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ant.v.moryakov@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-54b1095625dso2035865e87.0
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 01:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744964411; x=1745569211; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8XtgUSciFhgm8sfqMigW8j/a92+qgcjCXmb+2tNiveM=;
 b=BkMytGvgRqeK6i0e08JRTub4iq6J28KJ0gUCjDLzYnq7F00Qw6Sgf33yNkRlrVaXN2
 NkEJ1rTlawgD6vfzbFQwl1Pm9qb/OrnZYfdh8jmTpfIPRdhnVRhB6Rz+SJYGEuUNVrQ6
 UMAilVABM9G2N6+y/dE7Esc0U0BWhKXBPPIOeWFJJftUf+0X81/p+UrtyodBM8HJnVZR
 1cPjCrzgFCyiQGVGDTOCrDdHLYdcSlgZVbgTlX6kP7XuymhISDcD+dfOfgH7KswoDmoQ
 mkAg4+myT1haufwOFVXnkCvNdpZYxDDis9Lw6pJwU+0uvYKe8VWQTYPKE1N/hLEm1Eqy
 poQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744964411; x=1745569211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8XtgUSciFhgm8sfqMigW8j/a92+qgcjCXmb+2tNiveM=;
 b=T8NZqoIKqu/GqIDLrFQQkAJRGlTOIy/H+2UrTy9jdbu7MH2yBqraybztNXjfx1B4e+
 ITfluC80yfX6eN5t+sLQlYuLFfiIEOjwbSgXmgJIP4vQYIXDarGSHJuKEOvvaqXrXv3L
 WZ48pZs0AI7o38ODFrvCdMNwzPadX5anOMClpIA7JvueYrIxDGC9RvtkgVKzFi7SYIMY
 H+JuKGpZ+9htnE26CJGtNmcXCvuKrjaO0RBTQHRUJtiU56sSzYgcPeBUNsOuAtVSV/lk
 9X4r9GF8fjW6xs5pWUbMf9x9ZOZadVFX3POZQl0e35BH4W+tqmjuZz3JewtHSeQDqQPr
 lTuw==
X-Gm-Message-State: AOJu0Yxp94/8tQk6BUZCkyfyGaR5rte9douBiMpNahwRSeraHuqVW+Z9
 5akSfLuOwg6rsLtF1uV38AtnaCs5vtPTZP1deiR6i+Ucrd0O7obJ+cIebQ==
X-Gm-Gg: ASbGnculXmjNHPqIo4EK7nx+Gchhb6wKE4nYJ6reHgMP/q+M42PVc9XBSFDUd3HXSbO
 B2Lgnb8DyUKi950TYe2jsnWEnS0zEZOlOq8QGhT2PwyL2Z0P5zMOBdrctmgqlw+RFz4lmi7/2Qs
 MfIFYU3DZv3QNi4lDBEofuT8Hm79/YYX7KYzhl6VbmirguU2g07SKPuSk6X44K9vJmFqHSMQ408
 dX5qafLCr2NeRz5jH0wJSDyLsz0vtSt8ZlNkT3NlpgKWNZ0Fr94vXh1jUSGlITiGijqjq1MQA//
 Ww1Hfri0xYOyfk5CD+AngvI7dUFQMG6J5I+Y2nlp2lgt0C0xyYMLLb4Uzl0dZemFIJfy+PaL9xn
 siNUQxFBY
X-Google-Smtp-Source: AGHT+IEjomNza0ZD6IUe0EzX9ak78oBCxGhlFsGj9rJVQ+PWY+KKiNecz6wRClBcbahKmmYdUuzKDw==
X-Received: by 2002:a05:6512:15a4:b0:549:b28b:17bd with SMTP id
 2adb3069b0e04-54d6e6631afmr531726e87.35.1744964410951; 
 Fri, 18 Apr 2025 01:20:10 -0700 (PDT)
Received: from anton-desktop.. (109-252-120-31.nat.spd-mgts.ru.
 [109.252.120.31]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54d6e5cfd4fsm128795e87.114.2025.04.18.01.20.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 01:20:10 -0700 (PDT)
From: ant.v.moryakov@gmail.com
To: u-boot@lists.denx.de
Cc: Maks Mishin <maks.mishinFZ@gmail.com>
Subject: [PATCH] tools: image-host: Fix potential memory leak
Date: Fri, 18 Apr 2025 11:19:58 +0300
Message-Id: <20250418081958.12818-4-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250418081958.12818-1-ant.v.moryakov@gmail.com>
References: <20250418081958.12818-1-ant.v.moryakov@gmail.com>
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

From: Maks Mishin <maks.mishinFZ@gmail.com>

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
---
 tools/image-host.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/image-host.c b/tools/image-host.c
index 4a24dee8..6b17b810 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -1024,10 +1024,13 @@ static int fit_config_process_sig(const char *keydir, const char *keyfile,
 	int ret;
 
 	node_name = fit_get_name(fit, noffset, NULL);
-	if (fit_config_get_regions(fit, conf_noffset, noffset, &region,
+	ret = fit_config_get_regions(fit, conf_noffset, noffset, &region,
 				   &region_count, &region_prop,
-				   &region_proplen))
+				   &region_proplen);
+	if (ret) {
+		free(region_prop);
 		return -1;
+	}
 
 	if (fit_image_setup_sig(&info, keydir, keyfile, fit, conf_name, noffset,
 				require_keys ? "conf" : NULL, engine_id,
-- 
2.34.1
