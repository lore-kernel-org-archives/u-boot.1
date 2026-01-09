Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 644F6D26D9B
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 20:26:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4C79843D4;
	Fri,  9 Jan 2026 21:26:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C3Ys1RMc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85BC9843D8; Fri,  9 Jan 2026 21:26:12 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C270843AD
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 21:26:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=d3dx12.xx@gmail.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-430f57cd471so2421833f8f.0
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 12:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767990370; x=1768595170; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DSzJEJ3cfd0+VhS3o68nTw+73E4SLe0zCbAhIOPr1a8=;
 b=C3Ys1RMcsWpBoVg/E3L7qzXA3s3TsXHlPahr1MfrfOiNN1zDJq3P1XB5Tf7D/hNa7k
 k9/SXYYmnrFlsgOxZyo8ZaeklCcBu4145R6ulI8dlerl07GvH6+P0uRfoy/uzA5p5nkb
 gZkfPjnlMnDI7nCEGp6xjIKasjU07LUo9hQyaN8y4rkHN8EegddZlOnLuzaGkVwDcb6+
 VGFQpco/Kvrij6tCOUzSBtFkABYldJ4b42TPnRJGvSedeynr0ZtpBtF2+AL7KNVTk9T0
 EnA/abRFHsNNPDs4VdnFmsdlh9bhXNpl5qK7DjMFMB2VLE2CYrmLHaI0csMciG8isY3e
 HAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767990370; x=1768595170;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DSzJEJ3cfd0+VhS3o68nTw+73E4SLe0zCbAhIOPr1a8=;
 b=FkQfcdpTgs0Us1qc1Y1UsNRUDF5vL3s7bXztFdnmbDmGGFsX0ZCQlDTpPiyt4N1a1X
 fkECSVeHB8X31KahCoqM/+uaTyWTMdJeRRuAjz+Llsj1GKcHau3w2Pvapz9vNSmV0Equ
 thy6hKcMpleyOX0/RbwJtb+lIdYbxPIlJlPcYvh6zxb+eEpz7Bf7VTr7b2CoQuEJcJ63
 brEDszBhvidhxXc0k7shC75zrC9Blk4c2mD4hXjN0mZtF4qA+NtqU2YTwDx43Cbv7y17
 JtkdTm7SvtS2L9Y2SEcclzIMjfw7Ucft8adR3DuxcpClrcqsjGqi0WiawWZ4oVWurfE5
 tPwA==
X-Gm-Message-State: AOJu0YxA20Y6gIDf6uQWzdfarocY59gDfcTmpt/W412z0IHhs6ly0cOA
 KEL0/OzLchGhHVd+S9JxvbsYqXA0VQSmHllHjoiQbjTdlZgDSqyT1P+G
X-Gm-Gg: AY/fxX6WEFZg+gHCGy1KG7/ZjFAvc0tuEoVis8GbCBr0N+nBYCInI532d9TrDgwzV+b
 XC4osAKcTPaYe+5ApZP/mR4K3BCFiaLcmoCA1VGoQnvcDXh8yde2/mlKl8bX1em6KLbYrc6h6Vp
 bfsrH2OcEqyzVXgr1isVTu7QCVurwaKpB0Jyr7jHbGrJn0PrARCkl+9181c+bBJBPNGPVxhTyvx
 IRiEH5TVimMfaSuPDqSkJo1/ZTlZSbijLZaySSTag9TBeDeXTdwNmBgDKFkf1BQ0U8ihmXSjYQl
 hBthBSoxH+CLLyhcggQx/lMK0nZLNNkpcUJLXAOq8tPy/AYrDcnBwW29FgiXoYnITF1v/ZeGHxM
 YPLTuD6SARpbcavMC43LyvmDpELjjnINw14RS50jWr0FH2jeVwwgXLUyKGmBB4PZX2PRjHfjr6a
 1EO0s/NXWesaqLa0wZfkg+GRSy8xEtWF2YNck1z1JSKD4C9L7YEdOmgtVwOftcaxWd
X-Google-Smtp-Source: AGHT+IFdMe9AFo3m2sr3uzHKoRGRwJ2NkkW4bAQZ9pLWGfrZZh/X4/h/+dJapwWsFmf0ucqmsEvfug==
X-Received: by 2002:a05:6000:2209:b0:431:266:d134 with SMTP id
 ffacd0b85a97d-432c37617f6mr14287746f8f.53.1767990369864; 
 Fri, 09 Jan 2026 12:26:09 -0800 (PST)
Received: from hyperion.tail59961f.ts.net
 ([2001:4bc9:901:a004:3351:3c64:f0a:552d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ee24esm24160730f8f.33.2026.01.09.12.26.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jan 2026 12:26:09 -0800 (PST)
From: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
Date: Fri, 09 Jan 2026 21:26:04 +0100
Subject: [PATCH] elf: error out if pyelftools could not be found
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-pyelftools-warning-v1-1-1a4965609b55@gmail.com>
X-B4-Tracking: v=1; b=H4sIAFtkYWkC/x3MSwqAIBRA0a3EGydoYL+tRAOrpz0QFY0+SHtPG
 p7BvRkSRsIEY5Uh4kmJvCsQdQXrrpxBRlsxNLxpueADCw9afXhvE7tUdOQMazcttexWJZceShg
 iarr/6TS/7weASsRdZAAAAA==
X-Change-ID: 20260109-pyelftools-warning-6df5f57ca5b8
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Dmitrii Sharshakov <d3dx12.xx@gmail.com>
X-Mailer: b4 0.14.3
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

It is not possible to validate an ELF file without pyelftools, make the
error more clear and informative to the user:

> binman: Python: No module named 'elftools'

rather than:

> binman: name 'ELFError' is not defined

Signed-off-by: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
---
Make the error more informative and indicative of environment issue and
not a code one
---
 tools/binman/elf.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/binman/elf.py b/tools/binman/elf.py
index 6ac960e0419..899c84ad36d 100644
--- a/tools/binman/elf.py
+++ b/tools/binman/elf.py
@@ -570,6 +570,8 @@ def is_valid(data):
     Returns:
         bool: True if a valid Elf file, False if not
     """
+    if not ELF_TOOLS:
+        raise ValueError("Python: No module named 'elftools'")
     try:
         DecodeElf(data, 0)
         return True

---
base-commit: 1bcb2fe324180d0a8cfbdb0511737eba1d5b8550
change-id: 20260109-pyelftools-warning-6df5f57ca5b8

Best regards,
-- 
Dmitrii Sharshakov <d3dx12.xx@gmail.com>

