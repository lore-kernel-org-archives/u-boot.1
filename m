Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A415107637D
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 14:17:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3720B8412A;
	Wed,  1 Apr 2026 16:15:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ywuiYo5l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90A9684101; Wed,  1 Apr 2026 16:15:38 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9FD284020
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 16:15:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-486b96760easo77001265e9.2
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 07:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775052936; x=1775657736; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=D76RHHt3ck1rSasR55eeHf8+THJxMze9S85PZjvQ1eY=;
 b=ywuiYo5lycrQuAp75VxytiGcu9wAaKTr7q1MiD3rDU5Zo8r6T/LsFQSJKCxQubeMoN
 vbNTCBzz5MlCfDKwxx7O9pWdpDmTf/FfuOZKkmURab2WvyNbCC9eV6iaLOEMUYXZO9xl
 AS9bunf8kl2nWjV3KLnTfUs3MtN2yQbyr1AQHrv5fDdvJttimDIaKVUxSfNMzrWrnOtd
 A2iRJ/HXMw7ECQUKgk8kYaOzA4uY6Xw01NoFsRQ+XHNXSLmNVhSRtxFBhL75OQFEpKIM
 Tbx0uAT6+GoJvc3362vw6Xd5sGZoYlG62E0KxvpPpQqynqY1H5ujC6U5nhqq7TuiHiy6
 bNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775052936; x=1775657736;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=D76RHHt3ck1rSasR55eeHf8+THJxMze9S85PZjvQ1eY=;
 b=i2G/SFsKjfICNg00wwruK4SoRWslVl17pDJuey4T39e2z1i8FiGLON1Fq8oq6Iiebx
 WYXHUXmCmVO3B2OII+l5EGcf2KkUKAtbDVb/96TsyDWYd6BUH1gSU6Fqa7NPEEtnKcJd
 Xdy/fd3j/r7QxRRn+VuFSPVRn7CE/vlFbvNH+1CAWgD2SkwG6P8Ly4SVCU/D+g4xh2UT
 2SmhlMZ09FZn3PCMSBJ78TUlvF5W7FwztKLggrBXjf+9LlD/IT8h7NZJJrFRP7SX4kdw
 uWo833w9ZYtCkhuLLNIDTNLyHt3tqsikYPHeiHmcy4Yb8qBLOwcEE5O1RFqUhsbuRjRi
 MW4A==
X-Gm-Message-State: AOJu0Yyf1XPRYAeiGPoQs2yUhfm25hVhD8p/n/Lch11fRckEDG7LlF3J
 tEj1gCTBEGNmmAJTcdfdcwBowr3TDpO/Fhfy458Xn9ikaQszqss6emopePSlpD1zFow=
X-Gm-Gg: ATEYQzwlNYxUSR2O7ezNZm3ikdUgcosAM6sGDHwwGn3ZW5wZFPCQCgwYgfPqjZlXcQL
 bNMaRdtTov7COZFIhoz5TOkEDWPkEMc+DNvUjQTWykQi4YB/SL5a6tOucyIqTMWF9B6Vo/1eYAW
 Lbv/67JCWjAgqnMVuI5oHHQtoSOJEU1IsVPknOeSBdrQAmt//qnw/nGkvyng0Awj11aqlR63+Ob
 LRnxRF7muYNdra7G+g93P0ylUQo8+fLh71zf0vFgutIEkuO0npNR6lYz/ZbKJx+XpwXJr8SsODT
 eJ7shRRihZt0BE+ypIDT+ZzVxJLiSS9Kwq6zhLyH1zRS4JvxYax8uoeDmZfGvizAIs9gf07EpR5
 tcJ5q1jU8OlV5nMYh39OmxmN6pfKP7gReRezzeAcaNt1GZHnKhVkca3AQAX1eEgC98LIJsBVGrn
 hF7N7OGFO/DANooEGTznu4Ws6rzY0wqIeW1KJsQ53CSN+QFyUHz4KBY3XgfsAS7SGEDf1U
X-Received: by 2002:a05:600c:34c4:b0:485:3b9e:caa7 with SMTP id
 5b1f17b1804b1-48883597b55mr69962935e9.23.1775052936035; 
 Wed, 01 Apr 2026 07:15:36 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887c8bcaf8sm43224135e9.27.2026.04.01.07.15.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 07:15:35 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Wed, 01 Apr 2026 16:15:25 +0200
Subject: [PATCH v2 09/11] regmap: add regmap_assign_bits
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-casey-ccf-compat-v2-9-414d5b7f040b@linaro.org>
References: <20260401-casey-ccf-compat-v2-0-414d5b7f040b@linaro.org>
In-Reply-To: <20260401-casey-ccf-compat-v2-0-414d5b7f040b@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=959;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=R70v3bfUMa8es6EMn7gwODOUxcvSL29PsRM99C/5PHE=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsyzGlX+BkdLVrLGXrhrPD9kaTEXZ3Rp5N/wUGk2Q6cte
 kye7452lLIwCHIwyIopsoifWGbZtPayvcb2BRdg5rAygQxh4OIUgIkcf8LwP0P5wb+vzfz9Hopd
 6zdt+Fd4IWz3xiPnWbKKnjgFCBfJyDP801nYZzr9kux9hRPuWa8C5+znUFJIiRMIkDlYcbzCQCa
 0DgA=
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

This is a simple wrapper around set/clear bits used by drivers in Linux.
Add it here so it can be used by Qualcomm CCF clk drivers.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 include/regmap.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/regmap.h b/include/regmap.h
index 8c6f7c1c9b1a..eeae843bfb74 100644
--- a/include/regmap.h
+++ b/include/regmap.h
@@ -388,8 +388,17 @@ static inline int regmap_clear_bits(struct regmap *map, uint offset, uint bits)
 {
 	return regmap_update_bits(map, offset, bits, 0);
 }
 
+static inline int regmap_assign_bits(struct regmap *map, unsigned int reg,
+				     unsigned int bits, bool value)
+{
+	if (value)
+		return regmap_set_bits(map, reg, bits);
+	else
+		return regmap_clear_bits(map, reg, bits);
+}
+
 /**
  * regmap_init_mem() - Set up a new register map that uses memory access
  *
  * @node:	Device node that uses this map

-- 
2.51.0

