Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 925E3E77198
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 14:34:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BEDA80619;
	Mon,  6 Jan 2025 15:33:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Gz3ryZRG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0029780619; Mon,  6 Jan 2025 15:33:20 +0100 (CET)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5F41806CB
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 15:33:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3a7dd54af4bso55886975ab.2
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 06:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736173997; x=1736778797; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T+JdbhlG2S2KYjPUolNvLkHc1q+SGnKUdkVYQ/ADS2o=;
 b=Gz3ryZRGg0bEdgmewkgtrUIu+NOzVxgR8uLmmv8kIJLS/M3Az3sr+Si8y/XS/7Q5QS
 GEIcn+RKW3Std7VPlk7ML2kkkLTWpv3dBJ/1lnT4mPIPQIJ8dtNKOzmqLGi4U9dgNNN9
 v+0m5ejbWGR0SOQnf0xz7NTd3V/sdvl+c88ms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736173997; x=1736778797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T+JdbhlG2S2KYjPUolNvLkHc1q+SGnKUdkVYQ/ADS2o=;
 b=fsI8ZWnYZUFjUoDOvah2819Rdq3SsPZqcBVSbQKKqfEGvPZanuHskEN7PILYkHn+Ox
 Reyy0JPHh0q/5BBcilz+9Q8MjASGTPGwqWH72qAUkkArRhTWjMk46+ANA3gSTPxh7Utx
 tfTIY/8/qxRWBJBt/9LFny2XTXZE1sY+BtVIkEzEgkuo02VG44HhTmrabuYelEzR3GBU
 PIsBEUn5IkcGUFtY3oacJWLTNbSZemB/KBZeSZBDwl2jCaesxF8pP5EYbxq/ZfM06rVj
 aYQmD/Swr2/JFZTCXyo+gHG+VaRvdQjEjlo0a++wAMpJgHqZ1jdVuNCq2AaEhXWCv4Ki
 YqjQ==
X-Gm-Message-State: AOJu0YxkwcARc1fVTXG+1iJGHLaL6KSa9wu3pWAzVsM5uRWASdT1hsFP
 RnzJpeV24xsjevdgbi0tTW2pINpDeF7IjfSqHPDDuLNWFmsgy0g1A4K8zQryEYdrxMY/E0PS6BU
 =
X-Gm-Gg: ASbGnctGDFfeGIKXdh8tPi6u1yBikAhvSNMVSjmPNaJ37hUlTC1bqSHLhFBwgPbtNtU
 y/RdOPb1aP5q3F8xVxng7orzsK5bkq7UKwJgZjETLZreHPckX67CdBpLBeIYrrYoN1xfzFYmlrO
 NzEoDmoZR+q9cL+IAhbErxa2ULhZIy1X2RIA5jPxbPVgyGHMlp2exDksZJHrg7jymEnU9Sr0j0A
 grrbxp8SHocvCypxwW3IjOySjzxX293Mgxx2w4G0IGVM0YtV65eDZAnHCfISFoAf71jBWnhCF5o
 9cIh/K1OmjaNpKX53A==
X-Google-Smtp-Source: AGHT+IGz5DVjHhnoyNoq3wOL7ejeULbdlvYz34dPiLp/6qspb1B5IjFtCyPf+VAPPQR6JlywUUOY1Q==
X-Received: by 2002:a92:cdaa:0:b0:3a7:fe47:6228 with SMTP id
 e9e14a558f8ab-3c2d256679amr547042635ab.6.1736173996853; 
 Mon, 06 Jan 2025 06:33:16 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c0e47d6ef2sm97200805ab.78.2025.01.06.06.33.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 06:33:15 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Christian Marangi <ansuelsmth@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 14/33] ofnode: Update of_add_subnode() to indicate name is
 alloced
Date: Mon,  6 Jan 2025 07:32:10 -0700
Message-Id: <20250106143229.3023771-15-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250106143229.3023771-1-sjg@chromium.org>
References: <20250106143229.3023771-1-sjg@chromium.org>
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

This function allocates memory for the node name, so mention this in the
function comment.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/dm/ofnode.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
index 0787758926f..024ae4cd289 100644
--- a/include/dm/ofnode.h
+++ b/include/dm/ofnode.h
@@ -1702,7 +1702,7 @@ static inline int ofnode_read_bootscript_flash(u64 *bootscr_flash_offset,
  * of_add_subnode() - add a new subnode to a node
  *
  * @parent:	parent node to add to
- * @name:	name of subnode
+ * @name:	name of subnode (allocated by this function)
  * @nodep:	returns pointer to new subnode (valid if the function returns 0
  *	or -EEXIST)
  * Returns 0 if OK, -EEXIST if already exists, -ENOMEM if out of memory, other
-- 
2.34.1

