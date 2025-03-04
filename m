Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CCE2C282D3
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 13:10:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 190358171B;
	Tue,  4 Mar 2025 14:10:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QClVEw0D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECBEC81877; Tue,  4 Mar 2025 14:10:10 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CE3C8197F
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 14:10:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-85ae1c53da7so154771639f.1
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 05:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741093806; x=1741698606; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pjoi7WzezIcTPfjmihLdxy+uWLQGHRUBcHuy9zd8k0w=;
 b=QClVEw0DEPOXOthym20dE9ttr5aBWU9SK38TtyIrM5vnRpePCIu3lnUS7Q9+Rfd0pN
 IMPdoFbtfbe9btg152nKxEl9fPPG8OxjuF3eCBnQdNnWn2wK+1rQlBfa6VNoZ+MbW8l8
 xDfSxAY7fWcFF4zyC2nSGZpLrNRwBWq+1+lP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741093806; x=1741698606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pjoi7WzezIcTPfjmihLdxy+uWLQGHRUBcHuy9zd8k0w=;
 b=G6OsLQCDIx+nuj81uYHlbg1/TqGm9FjkwVzmSc35d0Yg6899BFcKZT3o+s3C+qG3oP
 V/gO7SWN2zBb7bBq807R0U+DY99dHM+f6Wz726F68zb12ifgV4VM3iYKCLtTxdm48lkQ
 2Gd5t0rlRpWVVWonT9XqSDE7/oJQ4/DTt/voFnGvSFd93Oc8x0cZCfibo2SbtseDdKQl
 vqV4RC3wAt5ipDhSisKjy29qFTUSPgebSqxyi9zq1ppviF196K8io//lWcziBFlAClcs
 KL9OSxmceUbw9yrhkN1Rdy5uyFGA25nQDwWt8XqMjbJ10dNR+3U693ZF/J3eLc5Fgr3W
 H57g==
X-Gm-Message-State: AOJu0YyPzwXAGbPDjbErUKKGPEnhTAZ5HB+/vMv+1GDHMjF9J3IZ14Es
 hnCRFQfRY/AymByxLsoZY0YF7AcXeh+47Q5Nu1dsjBEpWO8Wat/yPwEvHmtROLphCjITUbwjXxY
 =
X-Gm-Gg: ASbGnctClG+QePP4cXQAi87auHoGkSBmX0vbjWbCi5dKuGyqGpJPSowrPPyboT+miQM
 s3Vg7A/klX9t7L+sFZO/5QlVm7NDEW2tpqX6WdRzU2dzht1wWo6giGBuoEyZAMGdRCI8BVBtMsk
 gx5u+g1pnIB2VgWdCwbypEeo4VyFsZhYzcyKpK9ALSEVtVKk2rmlNrCBRjSsjruPQBYYiV26W52
 M7IVWH0GKXUtVeOajgVDy0BiKdxqU0jum0ZtF4Pmh6oC1nBR9/Fb8smlbIwOEQNO74xkEE2uOZf
 fZHLJgY2UChTuJ+4DyEoGu/niveqwA4d2k8eWgCP9s66Qpu+R9SQkju0Cv43s+y1Rva+nLxxpUg
 wCbI46A==
X-Google-Smtp-Source: AGHT+IFptfqYMFce+axIxAnD2E+YuvfYgdteIlgEF9LzM3QdIHj62k/AiEoceGr8azQ+X8UkSyQHtg==
X-Received: by 2002:a05:6602:4818:b0:85a:fd37:1c65 with SMTP id
 ca18e2360f4ac-85afd371d48mr22582239f.5.1741093804690; 
 Tue, 04 Mar 2025 05:10:04 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-858753cd304sm287383839f.33.2025.03.04.05.10.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 05:10:03 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/7] binman: Drop algo check in CheckSetHashValue()
Date: Tue,  4 Mar 2025 06:09:41 -0700
Message-ID: <20250304130947.109799-5-sjg@chromium.org>
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

The CheckAddHashValue() function is always called before this one, so
the algorithm check is never used. Replace it with an assert to avoid a
coverage error.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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

