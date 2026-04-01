Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33CC7D2ED0A
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 14:16:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC80784129;
	Wed,  1 Apr 2026 16:15:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tnUIeM2r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8671184120; Wed,  1 Apr 2026 16:15:37 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A33D983D8A
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 16:15:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso10623155e9.0
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 07:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775052935; x=1775657735; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ta7Tj8NqXyER4Q7mkz0A0OEdacbDVtJaec0R0jQ3J34=;
 b=tnUIeM2ra5TqT9eDbLcl4KNdZxu7pQU2zPPsKlmnIJYncNGd7Bkc0hXTLnsoC49Cc2
 DGhx2D61Qwc1Jb3GOsQMFdCCbuc5n/w15UdCMDn14mmcELUjsW/+iZ3QJGbAH1OmUb99
 XgFXrGyo2b3Jagj+DUp+vGeSVHfD71UksehIohsBmiFz+Vl1auJ3dCgmIKyT2lbKIxHd
 CLw95AiikMrKrejj21QieRRYuPmsTqNsF/dVHdx7lB0I5FrDkj9guGDt3OzAeL/CiiKW
 VTAJTeLqx6z3kwDG+bmA6L2DLCyLdoN13R9AhbJcMLJn6W3w58k4bxHfLtH+Vmx9tFsw
 xTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775052935; x=1775657735;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ta7Tj8NqXyER4Q7mkz0A0OEdacbDVtJaec0R0jQ3J34=;
 b=YPlfF+e6/7wsPqGbmXxGR4HZMhoGP38ldIRDGgtcaxCaKkSw5QQlvNAvhmdiZrid60
 84nx2G/F3sUepWESXvEyx28K6m199W+3Za1oHRN0kO7G7Ybk/xQgB8VnxvGnW9wzo6wc
 FreQgRKb8WktoouaSsEqsH37L+Qg1rLwiavd//OvhLSc9MGUV62XXppWdPSGnyIpE3rI
 on47jcWArlW+nlQBbkIZFeW6YIi79TmlFhripJdKyY8oOLwDcrAGeDqeHbKgerKUfUJm
 lZVi4w1fExr/OCTg/gxG1p2TgR8VZNr26BsloikEB/xpmxN0RTS6L/sMG6aFlzqrpiwu
 SXQw==
X-Gm-Message-State: AOJu0Yywg7f1b6gkQFtxCUzNy/gVN/2kQJlN/DHuYGgTotXB0RD1LQi4
 36595BzsBICqQuhBQ9t0qLB/PtSQqNJMNqf8KnZwfho+Y+xXtzcbRDirQTRkrBOKla4=
X-Gm-Gg: ATEYQzy4wxmjIwPy8TUi/fk+SDDPPMAHbleu3JNKl1gP/lNsBX4drfKWQMq+C1c/65s
 BZNzoToprmNH9Zj972AamkUbUaY0AOGQlZIPVbjNjClfEUsBGjb7SGoClX/YV3SY+ifVEtufFzw
 SMGnaB60uLIwNt79mVk5UbVLkcQzmFMJc8gP5PXui69YQ4NXYjLvQjwkMPv8M3ph7GVww//bTyz
 pFey1Kfn2w5OFqLbFFD5o8XtRpu9jO1NvJMaVpkCWUp2/gCaOsqdQ8S8z27GO4Sycf2X2uf7B0n
 NaHIV8yC3/6ei1cI34pC44pYwL7UzmxUKdOhgmGmvEJ2eoNBiyimPNds8vEUcWjpyxl0kKLRVf3
 e1spKAKSTKxEFo7a90t0RRtceKK5mjmxBGgOukH9QCekOzehQjWJPDhQtVs5QSG/tQlOc21SQn0
 OpVIgLqzIdiK5x5WmBMVy749Vf7kyCCKuOOsmOWJblkysege3iEisjOE8bRqY7Hf1ISIKXLJwoC
 Ax8LUw=
X-Received: by 2002:a05:600c:4f12:b0:46e:59bd:f7e2 with SMTP id
 5b1f17b1804b1-488835a168fmr61932405e9.11.1775052934783; 
 Wed, 01 Apr 2026 07:15:34 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887c8bcaf8sm43224135e9.27.2026.04.01.07.15.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 07:15:34 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Wed, 01 Apr 2026 16:15:24 +0200
Subject: [PATCH v2 08/11] compat: add linux/regmap.h symlink
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-casey-ccf-compat-v2-8-414d5b7f040b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=517;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=NdKEp6PPPnqzQwS5HXhBfSnvR7crR5H9OW0VElgSIaM=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsyzGlXT/a1uqZfsX7JQVe1LA2/U9nniTp+KTxha3tjDF
 XXFaG5jRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZjIFH9GhtWB0unn1Fa0dXdb
 FvH999qgp+A754ssk5LrFwYLSb2S5Qz/PcweLeKV+7Zy4gQD27aF63Z/dZo4t7t1jpDLnwtRej+
 f6wEA
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

Add a symlink to the Linux regmap.h path so that drivers ported from
Linux don't all need additional changes to include the U-Boot specific
path.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 include/linux/regmap.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/regmap.h b/include/linux/regmap.h
new file mode 120000
index 000000000000..8a3780b5cebd
--- /dev/null
+++ b/include/linux/regmap.h
@@ -0,0 +1 @@
+../regmap.h
\ No newline at end of file

-- 
2.51.0

