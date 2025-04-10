Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FBC6C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 12:44:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C62683C40;
	Thu, 10 Apr 2025 14:43:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CNi66y0N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D918083C53; Thu, 10 Apr 2025 14:43:54 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1606083C54
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 14:43:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-85e46f5c50fso80338339f.3
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 05:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744289030; x=1744893830; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GziraCwYVPN4fSdEvijBS2p1ScG6k38NLi3uUn91hno=;
 b=CNi66y0NiXzb3IYxufyrLawGWo/xDDkKPj6NQkCPmK/vmshPJAN2qDNkucTjBrVue1
 F0otC9OOs26dBVgvOFpU5E7QetDv5MTbeDuTsRqi2inkhlF5IzOy6PGt+hZ5NCwtCi03
 Eh2SNwXyOjU0JEjMQOb9b+UwCnkbTZxnzebro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744289030; x=1744893830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GziraCwYVPN4fSdEvijBS2p1ScG6k38NLi3uUn91hno=;
 b=rhWbZF4gi1bqAOG/eZHiIuB5d/IRiDRCpB+RDtJ9UETknmHBkAUgq2EJyVHHRm8m1V
 5uy38GoFbDzVIuFC+WNu/Hyhugdu8bwr9naMdbEsOtupNpIoRHeCS0CJIdv+9SC7Pk0k
 nlNqk6BwTgdrNrXfxdz3EtAghAzQp2ktzbEkCKuKj3gh8x/0xvNqkPAU8A8Udqxzz93I
 8oAv+6alnwgAV4UIG5pttKDLf/TwdhlV2Sx161N0XK2MOX/+vhVPOYQnPA5Rq+gBeAIE
 3R7G+HwlaK+XfjtRmz4wYYNBSqvApwE38cgCBr9Uu6xscEjx85Kxt2dRCKTmjxyFwDKs
 2qYg==
X-Gm-Message-State: AOJu0YxkJOa7/49E3tOCBtDly8ciRzE4v4NMpSD/z242mWZ6wRWLJPmH
 q5AfIb747vwXfn0USn+Ady6t47DOhLwA2/8UqTyroHCFH1JN+UvsSCFSlOoyQr8Ea/pw/yRuhCc
 =
X-Gm-Gg: ASbGncuGVZvdBkCiQuMwcqvK7tG40F81Q23djfEczUBDBVhhyFcqGbDbMvj5ucLVpkF
 8d5ZXFzZBJQrQmCTHDwS7b5Fan4rMSLCuHvbOSmjqaEgMAhob2+wa2ooJ2GMaSXv2D2GfANfYxP
 tLjPxWV9UL8T8ZXOQ2fxN3axjN1HSBsVCdm+wz0BL7dM6ulnbs1BTSGQ51mgpaj6Y4i6kUINvxB
 6wjZHdZlDKXH5Sa5OKcjzWXa1CppcZlkmwaNyeqq5S9uGQYOYRD9uhK+1662VEsjEF5GvWbL7vQ
 +sBxebGMJzQCEHf+due1X3M1+hAoM/BDqSk1u6EWLHluB2Cx7spIeN/TD5sHqrPMfmmjN5qLAr5
 RAw==
X-Google-Smtp-Source: AGHT+IGdcT78n0maf7+Fco5UB2w9ERV9gjQzuBZKtSj1hxed+UI7hYaBnLWP0upPWLDXoKo8YuCntQ==
X-Received: by 2002:a05:6602:720e:b0:85d:9f44:4421 with SMTP id
 ca18e2360f4ac-8617071b8ddmr213811539f.8.1744289030275; 
 Thu, 10 Apr 2025 05:43:50 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f505d170e7sm729471173.32.2025.04.10.05.43.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 05:43:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 5/8] binman: Drop algo check in CheckSetHashValue()
Date: Thu, 10 Apr 2025 06:43:02 -0600
Message-ID: <20250410124333.843527-6-sjg@chromium.org>
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

The CheckAddHashValue() function is always called before this one, so
the algorithm check is never used. Replace it with an assert to avoid a
coverage error.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/binman/state.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/binman/state.py b/tools/binman/state.py
index 6772d3678fe..f4d885c772a 100644
--- a/tools/binman/state.py
+++ b/tools/binman/state.py
@@ -411,8 +411,7 @@ def CheckSetHashValue(node, get_data_func):
             m = hashlib.sha256()
             m.update(get_data_func())
             data = m.digest()
-        if data is None:
-            raise ValueError(f"Node '{node.path}': Unknown hash algorithm '{algo}'")
+        assert data
         for n in GetUpdateNodes(hash_node):
             n.SetData('value', data)
 
-- 
2.43.0

