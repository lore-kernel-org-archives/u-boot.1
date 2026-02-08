Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF85EF06E2
	for <u-boot@archiver.kernel.org>; Sun,  8 Feb 2026 21:27:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7887183BC9;
	Sun,  8 Feb 2026 22:26:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zh1K0S//";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4711B83C67; Sun,  8 Feb 2026 22:26:48 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3995783642
 for <u-boot@lists.denx.de>; Sun,  8 Feb 2026 22:26:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-7950881727cso24400117b3.3
 for <u-boot@lists.denx.de>; Sun, 08 Feb 2026 13:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770586005; x=1771190805; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SpSPDKlHQ6vZ4FsToLXx1m7vLi9NL7UCX+28v9VAIzc=;
 b=Zh1K0S//RC+1SolPUqN7nVpayw0+znFnO6sY7JNJTZkdV1Mmpmon8dG3+FelZ2yhKQ
 FxsdUgdBgFDOETTvUMCEtPuMy0bnsESMtXKzR/xg0sr14t39zC6phPBDyOcJhkNM7I/f
 yE5VGv1wjHCZ8PXFIxG/bzWJx96Xae6jOhhFdekM75ZRj/m3+TsnRVAqZG93sxZRCvEZ
 Mbc3+0tY5uhll8r4ILn3tOfj2sI8bOKAyvNVOK534DTyLv6YWkD3hRT5UPXweqW1NVJv
 NZ51zsH8mrEWKTyeh1upFmfD+Mxi5ld4t4RFpaX2hd2f8jyhLabnraTChW4vtrryYXir
 mDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770586005; x=1771190805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SpSPDKlHQ6vZ4FsToLXx1m7vLi9NL7UCX+28v9VAIzc=;
 b=gs4N1ao+8nHqRh6/i6GhnN/SMoTvbnWW4ewxhdgeSE75jgLReR09cLV39lC72rHOJe
 7+atirmHdclmdGk/3k1PvNRXYOfooyAB63Ilh0++LB2RHzcwCH1IwyyaLtRDzBXINKFh
 potmExSZPhMufrR3rRUQt4zMjVFKeZyPMjYZqaxEsheHNCeeHEcBeFHb7feiRpPpciKt
 +ZasRIFO9qSEYMr+Z/RNekARWUf44utK9ureQFlC3KyKRCSrqGJpW6fs90zI9nMSzzaa
 UtZev35Y3660ZeWMMd4HeHozao+kplTzKZeosvB5dpNA6IYdJqZPJ+pTtGjzg8EgBlpO
 VrKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQWZyflQTzvKLcAOulL6HOOLwWRkqe8B7SRVEgI/lXn0V52ySj3UHEYEklcWH+RuSrxnP7sTE=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+lgjl8utEGJaSP5vp1lHRoXmySSMTY8XQJ9980M6lOw4HZ/zu
 +Bp2w8Cp1AwSpEdvdpiOYHuFkblBqHQMXELbifK2boGMmOf6RPEZySpPioHXlg==
X-Gm-Gg: AZuq6aI7UBOdrZyscGeSzbdh+2hMbgA4gXN0uqumILuh4yckQ82J5j0cDmoDF42Tp7n
 DTo7ZnVYJHPaEYvVesm2f2rb9BCuL04E36BKLpx579/9BV0licP3HtcvUdmFYO5Q2BW2bA71jZd
 e8vu0pLNvxAYBM2dVPwo+X/Sy0ypcRW+T2debsmTltTQlr9o1t3DV//ykEjFp499bzHoikIkkVR
 TnAfjxcRv3HDlNZQ2vvogYQzQJxplc2mDK1UU7XCD2Zxd6uZZmGno0+yHL2ROoXKqqNXixw/FzF
 LlcajJWiblYpGWpVgWXquRJ5XNWv8uQ8y1KouhOHM+nd8omgEWxbsIWbmczIdUd1Ibz8BEr66hW
 xlf2x4TSpFN+WeAiCwJR3/meKYTKz7aW3gUykhzOi1/IEvjmnfT97Yy9F4t32Vh4RTOuRCXfECV
 VmC2TiYZgViZsZAK90U7rqAN771TyIFWcWH/I=
X-Received: by 2002:a05:690c:9c04:b0:796:1eee:b8f7 with SMTP id
 00721157ae682-7961eeebef9mr146019937b3.58.1770586004962; 
 Sun, 08 Feb 2026 13:26:44 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:5d9f:efd7:6c6a:abf8])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7952a085999sm75229377b3.25.2026.02.08.13.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Feb 2026 13:26:44 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: kever.yang@rock-chips.com
Cc: trini@konsulko.com, jonas@kwiboo.se, u-boot@lists.denx.de,
 Xuhui Lin <xuhui.lin@rock-chips.com>, Fabio Estevam <festevam@nabladev.com>
Subject: [PATCH v2 4/7] tools: rkcommon: Add RV1103B support
Date: Sun,  8 Feb 2026 18:26:21 -0300
Message-Id: <20260208212624.3413494-5-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260208212624.3413494-1-festevam@gmail.com>
References: <20260208212624.3413494-1-festevam@gmail.com>
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

From: Xuhui Lin <xuhui.lin@rock-chips.com>

Allow rkcommon to generate an image for the RV1103B.

Signed-off-by: Xuhui Lin <xuhui.lin@rock-chips.com>
Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
Changes since v1:
- Use the original author from Rockchip's vendor U-Boot tre

 tools/rkcommon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/rkcommon.c b/tools/rkcommon.c
index e7e78ef7e5b7..15aaf8f890aa 100644
--- a/tools/rkcommon.c
+++ b/tools/rkcommon.c
@@ -148,6 +148,7 @@ static struct spl_info spl_infos[] = {
 	{ "rk3328", "RK32", 0x8000 - 0x800, false, RK_HEADER_V1 },
 	{ "rk3368", "RK33", 0x8000 - 0x1000, false, RK_HEADER_V1 },
 	{ "rk3399", "RK33", 0x30000 - 0x2000, false, RK_HEADER_V1 },
+	{ "rv1103b", "110E", 0x40000 - 0x1000, false, RK_HEADER_V2 },
 	{ "rv1108", "RK11", 0x1800, false, RK_HEADER_V1 },
 	{ "rv1126", "110B", 0x10000 - 0x1000, false, RK_HEADER_V1 },
 	{ "rk3528", "RK35", 0x10000 - 0x1000, false, RK_HEADER_V2 },
-- 
2.34.1

