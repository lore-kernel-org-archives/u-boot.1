Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 144DAC3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 12:44:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37E1483C35;
	Thu, 10 Apr 2025 14:43:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J3q6ier3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6D5583C5A; Thu, 10 Apr 2025 14:43:52 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B1C983C23
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 14:43:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-85b40a5120eso23644339f.1
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 05:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744289029; x=1744893829; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M0FEHQrr4FK+Tdl3RcElOVtnhayERnuYbINL8D3PeE0=;
 b=J3q6ier3c1EAQNA3+oS5M0H1uS2OHrZQfHhxBVdCOS2PjbXa7Z5/Vpvk1q7avhqVoR
 KhxilFPqPHPhPmme6Ptcrjd0beWm+l0mk/QZrsR+uLPr+8xgFRYut2e3kZL11NQ/dE4q
 BNDJ2IHxoA47lGjhr3fBK1t3rd5dlHFlVaSZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744289029; x=1744893829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M0FEHQrr4FK+Tdl3RcElOVtnhayERnuYbINL8D3PeE0=;
 b=VawebVcvDo8n9HPwrUygiC6n06gG3BjavF38z8jxjHo3U4NStKyZ8bk2Ec16u1/G3z
 tRwRDG5sUqTso39cbsyV2BCTzKEOsnA0MpFEO0IEr3GleBLI+UiQfzHRGEHIDYOZF4mP
 WRlJXcT8sdsOOgx2WgW7zHrEEvLW87mubNq/n5IQ+CjI5F+5HfrVns9DjU69I8hylTZv
 FtPm9AdhNU8lOuTk9rKlHJkGSR6CbS3q6UjZZKiXdRD5uOPbPB93SG/CqUPh2c2hgFdf
 jbZFRhb1DFyPTwnwjnsuB08jrRebeSMYVIpMIaF5gwVMEcCGcI2Pzu/HOjwvAHcGFzy6
 BPtw==
X-Gm-Message-State: AOJu0YylLqMma0hqyZFscLw+GSsrbxXEBRApRZhHfCbM3fhr2TuhlAJ2
 RwL+XvkGyMxyqW5y9Ba/w0kQmhSK1+h4+JXUUtfbXdsFwHi3bsZGoiNk9GAlECRiyug/c6f1T38
 =
X-Gm-Gg: ASbGncsxaNth+JpX23FE9TokBmbj8ZMFxelUMA4F2Hv+jcf8nu7b6gW3/g+lAwtoxDt
 vPbEGTEj7LxTgrLKvTN/+vd7y64aH+y2FFAXu0jOuGi6oXB+V9lHy6Umyzm4KNzV0FOcaUuWTGI
 vPPJLWQ1pT3x2FCQbTpjjNZfFpwR+LmJKehMNZwELZ2vH5mZ+uQi6fbeCMbIzgWzGoBhhhz3iNj
 +TWyQMICVRMhxKnrVTvo5Q8Z9WIbkWplL9Sjl5Q8nYdTYyyHH4RodtzYptEKdCUXVbyrV3Sy0l3
 3K6BoW2xdUyHJ3f7iwcQ0i99LnYR/BMwGPrkPxuE26qHBJvFclEib37Ig49x7tdRT7ll0x7eO9V
 s3g==
X-Google-Smtp-Source: AGHT+IGvshyLV/aDmjUuFTiSqphQ/nf7amSN/Jsr3m0Nag0jUi+kifMct2dlei1DOSuI1yOpAOc1jQ==
X-Received: by 2002:a05:6602:7217:b0:85e:8583:adc8 with SMTP id
 ca18e2360f4ac-8616ecec3camr277514739f.3.1744289028767; 
 Thu, 10 Apr 2025 05:43:48 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f505d170e7sm729471173.32.2025.04.10.05.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 05:43:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Kochetkov <al.kochet@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 4/8] binman: fit: Drop unused code
Date: Thu, 10 Apr 2025 06:43:01 -0600
Message-ID: <20250410124333.843527-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250410124333.843527-1-sjg@chromium.org>
References: <20250410124333.843527-1-sjg@chromium.org>
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

The key-name-hint case is not tested so is presumably not used. Drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/binman/etype/fit.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
index 803fb66ea83..ed3cac4ee7e 100644
--- a/tools/binman/etype/fit.py
+++ b/tools/binman/etype/fit.py
@@ -562,8 +562,6 @@ class Entry_fit(Entry_section):
             for subnode in node.subnodes:
                 if (subnode.name.startswith('signature') or
                     subnode.name.startswith('cipher')):
-                    if subnode.props.get('key-name-hint') is None:
-                        continue
                     hint = subnode.props['key-name-hint'].value
                     name = tools.get_input_filename(
                         f"{hint}.key" if subnode.name.startswith('signature')
-- 
2.43.0

