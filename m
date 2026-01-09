Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBAB6D1A63D
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 22:03:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7138C843E3;
	Fri,  9 Jan 2026 23:03:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PBocViCN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB78A843EA; Fri,  9 Jan 2026 23:03:39 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96A91843E2
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 23:03:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=d3dx12.xx@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-64b9230f564so6729994a12.1
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 14:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767996217; x=1768601017; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/N9NTI/QdgwF6W2NyTiRCbI9ssrENmC+vRibncvRwVA=;
 b=PBocViCN+UpS8n1ggiHynKNupe0S81YIQ1cPID11a+V3jBKFdK4XcR1ECD2q7084cL
 dzTDtUUGGyTu4CU/Dqxn2z7V1JByQWQoOpijSCFAUkTADRXF8w/vP4VaDjC1hvx9eI9M
 CETBJe436IlBEAAXw6HHCxkl+A2PJErwz6cPrn6rqoeQPh1+Tre9Sg8kwuRbb8aIXjyg
 dPvjnY81YS3GcpY936ETXom6+k9x9jAyaNZmcTlx8RTc+Zu+sg8vZTTuORmD1GjrpY7Z
 CvCnvgPNRtSWEUugWPVQ8X919hIBrdWdr7rwfAEUw+2tep5bIMHySZ/h2Xec5F0yifYT
 f5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767996217; x=1768601017;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/N9NTI/QdgwF6W2NyTiRCbI9ssrENmC+vRibncvRwVA=;
 b=W7PMG7yxMTvaXsETdAw0eGe/nZcMoBPZzOvtfsI8Jfc6yPmp9oFWX8FGJX2+L1zc64
 MsBO+wI5sXd9na0Hlj/E9oId991dN8bm7/IFP615jY2oulS0VTvOE+2sXF8GRJ07pElz
 v9aS7wj+l/KXlTLKdElsmn8Ud6nmx17wDs8Z+DBfjjO2HZSD/x2NFjslaF9oMgN4FBb7
 cBk1sRZzN6BO8zoWoHzkCicBgTlhtA0ylpUPuj0q/zs6wRxvwe9RfjkDNKp7r8dnD2b/
 LjhkilWo1i9Orlf72DpjASEiMeAC8cdFfWedtCx3HIMAmTlunFyXoLBGzT8NnKLa6voC
 WX2g==
X-Gm-Message-State: AOJu0Yxo7uDSMKoEcuPgvBZLmUZYrlDTN4nNOUl3xA7ob7wd8fHPJL3A
 Rx5gsmRipfL5uSPHl1ac5DcymSDHLyw5HRL+8CVh01cAb4ctSOESYb6R
X-Gm-Gg: AY/fxX56IPWA0MUZcbDL6i48R+odCOTENnIKem8xNP63PDrYSR7GY4DpcU2/EL9P7Sz
 8rhKaLF/5eLEXD5EIjDhNTCHISFRiHLJDiCdi1JrbwJv7MPLbJM0EvYwE89iGUanldcxv+Vc9XB
 w0bvHEct2viMFYJgkJ3R5noi8GWdflg+q7qOAbxpIFPgxRvHRlWj5kwNC6Ek3M9bMFwI1GG+TPq
 qT7SuPMbq32sRirX7NZDtVTRUA0phESJSbsp5Q3omy7oxAhBEzLoSl1uDV29b3LakyL8zpb9etx
 wbcED0Zu1wZqUL86Ak3PrGNr9kpBZhXHatHRz/t5wFIK7teL6iswIsXx6mEb8fg82PebusRabbO
 NQAPiTQr0QtBr7GSl3FZ/roI61/l5LbLgROeh0xLigaBStWLcWKQHo7akM04Q3kTq1N1tocZpye
 yUOHm0lgSX5PVCrymLTP3yIeR0+2aaA+gOUGgZi7uNwBjLwWELoYJW7Q7/0hBZ8GHu
X-Google-Smtp-Source: AGHT+IE1g2PjwJI6+0wJFglwHQW6azWbI1TgGErygDuu1XF/VTlN2N3FEHwVNLbaptNoHUbNanIVjg==
X-Received: by 2002:a05:6402:270c:b0:64d:65d:230b with SMTP id
 4fb4d7f45d1cf-65097decd6fmr9924953a12.12.1767996216772; 
 Fri, 09 Jan 2026 14:03:36 -0800 (PST)
Received: from hyperion.tail59961f.ts.net
 ([2001:4bc9:901:a004:3351:3c64:f0a:552d])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507b8c4484sm11461305a12.7.2026.01.09.14.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jan 2026 14:03:35 -0800 (PST)
From: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
Date: Fri, 09 Jan 2026 23:03:28 +0100
Subject: [PATCH v2] binman: elf: Check for ELF_TOOLS availability in is_valid
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-pyelftools-warning-v2-1-e27784f14c56@gmail.com>
X-B4-Tracking: v=1; b=H4sIAC97YWkC/32NQQ6DIBREr2L+ujRI+mntyns0LhBBf6JgwNAaw
 91LPUAzqzfJvDkgmkAmwrM6IJhEkbwrIC4V6Em50TAaCoPgQvKaN2zdzWw37+fI3io4ciOTg0W
 Ld62wf0AZrsFY+pzSV1d4orj5sJ8fqf61f3WpZiXq1kiUvOkR23FRNF+1X6DLOX8BN/gdF7QAA
 AA=
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

Check if elftools package is available before running DecodeElf().

This clarifies the error message.

Signed-off-by: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
---
Make the error more informative and indicative of environment issue and
not a code one
---
Changes in v2:
- Reword the commit message as suggested by reviewers
- Link to v1: https://lore.kernel.org/r/20260109-pyelftools-warning-v1-1-1a4965609b55@gmail.com
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

