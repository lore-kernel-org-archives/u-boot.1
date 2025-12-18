Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1498D711CC
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 23:37:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4E3283936;
	Fri, 19 Dec 2025 00:37:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LxlCjNDF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2C7183936; Fri, 19 Dec 2025 00:37:04 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 924FD8309A
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 00:37:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-3f9ebb269c3so455224fac.3
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 15:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766101020; x=1766705820; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=06mTdBxgZI1WY6M1Jvv+OTZnzc1KVNR8sqbPhtZ2/b8=;
 b=LxlCjNDFmk379w58xK9uUTFKNac90RTqB39iZALxlrXwUfLDKJ9vvMM1csYB4D5glB
 9L+L/Plo+nO7IDPSBYRArYxACDKWIKi7oO1A1XLW0mBVE8CU6oT7yTA0j7SnF6Rjiue5
 rpR6+JdigFu1Isv/Al+dWzcSwn5XYLHMF6SiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766101020; x=1766705820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=06mTdBxgZI1WY6M1Jvv+OTZnzc1KVNR8sqbPhtZ2/b8=;
 b=smhECFqGeMioe9wrLQvSlHFKFe8G17mS6xMRY9I5R0qxALeYHIs5w2P5G7gy7Ney0q
 +2Jx4007xu9GbpcFF51xGGrnTdCfCB2UAxKDFiSpPSzf2IceT+sEps/SOosY5xvqRhi1
 lma4KXhBTZ0iXdtSkUtCR8WfqSWczMHYtqSaE5rQe9o1N0eXIQE4rvEnh3MPLaYBzvBd
 TtFk1cHw6e7gk3AkqeitfPUUf7DPMhRyErKc55gZlwdg5lKEHqcKWz+UmNRRlAA/Weoc
 xHaFHfaue0liFjTsD7+2nkoaIh5ZdiMJcsNv3Q+9Suiy4E3TKWpBc2AWU869OVWIUszs
 SvHw==
X-Gm-Message-State: AOJu0YzZDkorTxhkAc8XJUoPZRnx2hibi+4zhLKW0EMMoTPAjilBPwfU
 4YXeyppBtxsgclsTMLgsDXSklKSFPetR05UCc4PhCyl+nZkVOQTX6yuQSsS8Bo8WwQ/braEQ7/b
 0Cl60vCE=
X-Gm-Gg: AY/fxX7yAIuCRiqRQwi2wyYpxLMWC1rHtt+aKW5ZJbHKziYaFbJVP3xXZfXfcCyioeV
 IFmI4QPsd0aw7XNQt0qBVTZfqFvynFCHu/tlaZOKjanxZEBZodmGQhYavYHLvhKz7y4mo/Q9V2O
 xk9UWFsceWV96HYW5y5gxGDwiQ/FDiUZQlrbPOQE01SxlzgSUbFenL93PGPDt+/ytRZMqIXDwbt
 AUtW9TuBE7zOhi2gOe5P4BbgVVvdFxsYjade8Im9ljyfJLdqbvVfasfQC6YZTZMD+u9RsRc1jf6
 cFDHuAMyA6xQkYG7dzv/MMGz6W4bwX+aj9dMVCxJX4Hc9CRaY1RZoAO3Bj9yUKQrpwHHCLGEFpp
 UQBgwbZjDSBwStU+W1EoKz9iUDXtPWHJ36r5PzduX54ove45Yd912nro95Stvujc+2LVckONsUa
 fRW8/jU+PVY1BNfoHW3o/Utlf8l8ynoS6lMrkp5ypXAgRBdkTEfbX2
X-Google-Smtp-Source: AGHT+IF16fBGNxaB8nFeHOdZc5YGRPSDkvD6p9B6kFhVMdZCv8LFyzjaza1Bh2nyFbuuxAxN5jwM3Q==
X-Received: by 2002:a05:6820:160a:b0:65d:30d:eaf3 with SMTP id
 006d021491bc7-65d0ea624a0mr528422eaf.42.1766101020348; 
 Thu, 18 Dec 2025 15:37:00 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaab5ccb9sm449605fac.10.2025.12.18.15.36.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 15:36:59 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Darek <x64x6a@gmail.com>
Subject: [PATCHv1 3/3] lzma: Add SPDX-License-Identifier lines
Date: Thu, 18 Dec 2025 17:30:58 -0600
Message-ID: <20251218233654.3938385-4-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251218233654.3938385-1-trini@konsulko.com>
References: <20251218232255.3934258-1-trini@konsulko.com>
 <20251218233654.3938385-1-trini@konsulko.com>
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

After consulting https://spdx.org/licenses/ this code should be tagged
with the LZMA-SDK-9.22 identifer, so add them.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 lib/lzma/7zTypes.h  | 1 +
 lib/lzma/Compiler.h | 1 +
 lib/lzma/LzmaDec.c  | 1 +
 lib/lzma/LzmaDec.h  | 1 +
 lib/lzma/Precomp.h  | 1 +
 5 files changed, 5 insertions(+)

diff --git a/lib/lzma/7zTypes.h b/lib/lzma/7zTypes.h
index 18c804cf3b29..89f40f2a66e6 100644
--- a/lib/lzma/7zTypes.h
+++ b/lib/lzma/7zTypes.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LZMA-SDK-9.22 */
 /* 7zTypes.h -- Basic types
 2024-01-24 : Igor Pavlov : Public domain */
 
diff --git a/lib/lzma/Compiler.h b/lib/lzma/Compiler.h
index ee9afcee4dfd..b1d682e19aa4 100644
--- a/lib/lzma/Compiler.h
+++ b/lib/lzma/Compiler.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LZMA-SDK-9.22 */
 /* Compiler.h : Compiler specific defines and pragmas
 : Igor Pavlov : Public domain */
 
diff --git a/lib/lzma/LzmaDec.c b/lib/lzma/LzmaDec.c
index 9cbe36af7182..f509afcf31fd 100644
--- a/lib/lzma/LzmaDec.c
+++ b/lib/lzma/LzmaDec.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: LZMA-SDK-9.22
 /* LzmaDec.c -- LZMA Decoder
 2023-04-07 : Igor Pavlov : Public domain */
 
diff --git a/lib/lzma/LzmaDec.h b/lib/lzma/LzmaDec.h
index 9e0ef3ef5835..6f1207488b28 100644
--- a/lib/lzma/LzmaDec.h
+++ b/lib/lzma/LzmaDec.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LZMA-SDK-9.22 */
 /* LzmaDec.h -- LZMA Decoder
 2023-04-02 : Igor Pavlov : Public domain */
 
diff --git a/lib/lzma/Precomp.h b/lib/lzma/Precomp.h
index 38f3d1eb6fdb..bcdf3d57b6c8 100644
--- a/lib/lzma/Precomp.h
+++ b/lib/lzma/Precomp.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: LZMA-SDK-9.22 */
 /* Precomp.h -- precompilation file
 2024-01-25 : Igor Pavlov : Public domain */
 
-- 
2.43.0

