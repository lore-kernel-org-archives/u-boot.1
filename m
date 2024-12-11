Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C60E77180
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 02:26:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6940C80200;
	Wed, 11 Dec 2024 03:25:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DlR9IGb6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 768B980212; Wed, 11 Dec 2024 03:25:57 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC5E980219
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 03:25:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-71e17de2816so232627a34.0
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 18:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733883953; x=1734488753; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CX6PD4cNnpNfjYBZCnKJCMA89BiMVHR+VdvUJYthjPE=;
 b=DlR9IGb6+Bnh7apSBKlcuk1Qvo0HAX4ozFaarMnXrAy1nMIYJ9g9E5rSmrvW+RiZgp
 4H6qK+eLTPbnFuXrTSLuF6X1XgzIDMWctTXt7wHjtLUJjGVG50ABT+ylQfg0euKhQ61g
 S90ad0BwaIpJ/FAOhhTkZIGZgucX/9UEIzzay3bbI7RX3fHyix6eR9m1mPNCghpiSnSt
 nloitb2JcRG93mBKY8Soy2yoe7vTGWJA9pE5SIWK0LIo0OfS3gxELJCg2fFzd8o1zvVt
 9g0UZY6QOxGWHgtIA8DCSR42MLPxD0RuCXprGvapNv1YisLJfU7J5veaLYajOaO70yKs
 ISIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733883953; x=1734488753;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CX6PD4cNnpNfjYBZCnKJCMA89BiMVHR+VdvUJYthjPE=;
 b=RAM9DKQyqszYXLuaW8htFSTEQbir5sB+0uWyjLcFFJyh++5F44h5VQMwvR6MemXcue
 9tvkMXIEmx5x/nv4DprPCJJnqFALtGrrqjNPEmeRWAISsUAFjWWrYYW+7Y4THWlv6wJ1
 XtFmjRza6PUyiqNWEYeHcic2gbTX+pe6Spn7R2+XeXS2TsLstfi/5U2amF++b3KNPLSv
 ACJ9hKpIDCXCFfE14bDUjKplaiJmrK7oYEwffn2hZgdkOFN0vgY5/fUHe2Xu81LSRKZ5
 iXeXr5PtSxsRxs/AnP0G5f/tJVrQMbApC1kywtHhKPzcbpVqcDUat9iDB8vQHKRARzls
 epjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+r9w7V+wEwU/3ofhIZUsGVgCFROxeKDAJowBL3veQ/G88DyrqiAhnCIyxOR8xmUMZMCEOeAQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yyi3tstJYAA/fhBfsQYDcj4PKtH+HzgR0FEbssD0TQO37SvT6vU
 B2iDgq4jJzAo0JG+KnR/y3ywo3im+LTFo7y/CzU30JKC+EnpHIjG0fCW7nE0pXU=
X-Gm-Gg: ASbGncuVRpPgkWWvRdaN7/wf+g7ekP0jkxShLnxesJrP3LKeV6CbyzpXOrNF12EzzW2
 VSP5Xo+Q+Df6+sQvk80EdTn9vxLOXyaoN5OZxaL5sIWdj4X4I1SVfL2RyvMz6DRJG5GbqfntBPd
 WpSSTf68Ebl0Whqza4M4fBGa4CeTSdIb7s173U/lY5YQ6axgij22jGf6pM2ibPGjIB0BqR7st/T
 AJrF42vQiGfTNdrEugcCvFvWs5AU+R8KPxXytNTWJmEFvnvzro5DYL+d3w=
X-Google-Smtp-Source: AGHT+IF9jV/2b6K55Z+n1HMsDtejgEttEqJzFJEmZv2iVBqpecROcsNFNOE2MqUH0EZngQ9qwel5/A==
X-Received: by 2002:a05:6830:4888:b0:71d:e900:2322 with SMTP id
 46e09a7af769-71e197c959emr514454a34.8.1733883953569; 
 Tue, 10 Dec 2024 18:25:53 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71de723c753sm1931257a34.72.2024.12.10.18.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 18:25:53 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
Subject: [PATCH v2 2/4] lmb: Make const flag_str[] in lmb_print_region_flags()
 more const
Date: Tue, 10 Dec 2024 20:25:48 -0600
Message-Id: <20241211022550.2995-3-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241211022550.2995-1-semen.protsenko@linaro.org>
References: <20241211022550.2995-1-semen.protsenko@linaro.org>
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

flag_str[] is a pointer to const. Make it also a const pointer. Improve
a style a bit while a it, to make this line fit 80 characters limit.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v2:
  - Added R-b tag from Ilias

 lib/lmb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index 1d57f48bff67..0f9de26b64af 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -472,7 +472,8 @@ static int lmb_map_update_notify(phys_addr_t addr, phys_size_t size, u8 op,
 
 static void lmb_print_region_flags(enum lmb_flags flags)
 {
-	const char *flag_str[] = { "none", "no-map", "no-overwrite", "no-notify" };
+	const char * const flag_str[] = { "none", "no-map", "no-overwrite",
+					  "no-notify" };
 	unsigned int pflags = flags &
 			      (LMB_NOMAP | LMB_NOOVERWRITE | LMB_NONOTIFY);
 
-- 
2.39.5

