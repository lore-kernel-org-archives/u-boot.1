Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5001FC021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 13:10:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B72018193A;
	Tue,  4 Mar 2025 14:10:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="n6CvTkDr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 825FC817EE; Tue,  4 Mar 2025 14:10:06 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BACB817EE
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 14:10:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-85add719f7aso57545539f.3
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 05:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741093801; x=1741698601; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DOjDVskvdxXCpbR1p1iFsDCJyH7cDma40eCTKJLDxuA=;
 b=n6CvTkDrrHl9ZQw8My9tss2JTngeWPKvDys/NPS+5/RV4m9ZuHbY09jfdlRAyMwf8G
 ARfClJia9w/XD3VwB02VTFU/ndJ7rLdbG1gZpD6mpS3D8xfKmdFBt/6GUJcraWLv5Q7p
 d5ZaHktD0c1O7TItr+Awp5Nx9Hxz8QYKd1hR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741093801; x=1741698601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DOjDVskvdxXCpbR1p1iFsDCJyH7cDma40eCTKJLDxuA=;
 b=MUOJ1YEmwXdg1r/vFFJIsHc+wnIxtv7CEumrUJL0+vTypsFCI+vBxkMxQMMcStPC+O
 Y7bxG+lU8MgViUH9JisyvKKdngtMZ9S810nhG1raHmgd6+Tx/lrkQHa/TY1kQt4ZV8M+
 oloy0FL6WaR8c2Th3tfvQ/bptAhwiDy89r0+r/r5HNIOjK7QeVsy9R9IAVROSrfePouZ
 A++0rdUyF2kI/Z/BusBRAteAH6PuTXhX2VZgKY1Yxz8Td2P3O9TnEyW0J91lTpoSUaNU
 ouG4H04rStLryl5vu61aWiJ3SOSP70RA4tnLiF7T2B3kxsh0eE9ROEtjQ2F1Ln6u1oQ4
 LbQg==
X-Gm-Message-State: AOJu0YxlgNyvdx3wDtER1FTFOcsiVzo3amBk2XKFquEMXu3dc1Z+m2t+
 KYn4UE934gIvistmK146ExBLZ9PCOVLKk/CJw9uKxFeJwC9F8Mm9BsRJDqR/IIgEf+butDkmPQg
 =
X-Gm-Gg: ASbGnct8ax7Mns9hnGaqcSKV9xyeYV8yL9KHbuG08kq+X5ui2nfNY+P2trnlS6/w4na
 YAsmHVusqfSRQT85LBKP+2Dtk1jRuG1lTOmMl/YTh04T9lE/9R81CA2idscICn12lGmfLJTxKQc
 G8qXPDfCPs0QzWyvlt0uh9N/tHH/h3CqPc7ABE/88V23s5pVMbbb/6o1y/KDgYuoOqAQOi8O15m
 C/y8zZ918egS3WGCarDI0wOPlYr68/wv65yEqRz+rryYDRtiL/neDmfkJ0nqIRPARolh6+K/xNN
 iCvcRlWl1uOQkXeDzp06P4prGVXWK82JbCvTBVOBJ1Q2VGIIj37XLQM72dgfOB0X0AAqVKvwfRx
 Qj/eRqg==
X-Google-Smtp-Source: AGHT+IHtDtYiBSVrziThbcwMr15+eaIy5ZkUoU9JuQ86yMkbXUbHE1dJ11DJ9JQhw8bpNPWQ+veHhg==
X-Received: by 2002:a05:6602:4819:b0:85a:d71d:b2ce with SMTP id
 ca18e2360f4ac-85ad71db698mr878578939f.14.1741093801623; 
 Tue, 04 Mar 2025 05:10:01 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-858753cd304sm287383839f.33.2025.03.04.05.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 05:10:00 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Kochetkov <al.kochet@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/7] binman: fit: Drop unused code
Date: Tue,  4 Mar 2025 06:09:40 -0700
Message-ID: <20250304130947.109799-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304130947.109799-1-sjg@chromium.org>
References: <20250304130947.109799-1-sjg@chromium.org>
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

