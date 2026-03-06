Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC86F513ED
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 02:39:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DFA184047;
	Fri,  6 Mar 2026 03:37:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JAuff5e+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1E0783FEC; Fri,  6 Mar 2026 03:37:31 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EA6083F9D
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 03:37:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-89a0ecbc713so44506596d6.1
 for <u-boot@lists.denx.de>; Thu, 05 Mar 2026 18:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772764647; x=1773369447; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EiacIvC0Fm//vkRO5pK/TGhY7SGPq1/rhwoBtj6942A=;
 b=JAuff5e+2fvZBZ1OXP1D40N8FtUW3zPhWwVxNU3xxoXSbrdA6+kzopZgDVTUsqhfJr
 ZwhaVhhYFnZLy4KPJO3jq6W+NS1PqZftwxx6zciuVKpqt/M38krbXBau4mu9Vw85J7kR
 IBCpjCLAmJ7yy9cfZwXe6RJgpiuv6/EWXAsZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772764647; x=1773369447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EiacIvC0Fm//vkRO5pK/TGhY7SGPq1/rhwoBtj6942A=;
 b=OmgE4GQp+NQOmuKEsf/JRlSlY78qj3fJ8XXBs7mDo6T04z6ZajMLw4Uuac2oDX5G8f
 JfW2GXRD0k3zmPDt+vlImmWUKVq5zxxrNLccODAkkc3oFvgTC33R9S1OD5X7ICo5/sQN
 pt5LQBKdMwWTmyIX7JSPbiXt4cK3J8vupjlgRqxmVe+/dE5Lix61If1+mtyuBwfHNaEM
 2kbsqx7wwK2bzYA6Mfsu401FengRUtcpMb8c2UfIe3StboBgl70XbPYCbhx3OY6p9N7H
 iVrckUlm5tBkwjCUVTjf/SesROtDQXHyePXXgTbLRBboPR6J/i2uhHGQIN77EfHANn5+
 bntA==
X-Gm-Message-State: AOJu0Yx0QL9Pe2w/i9FHo4U05vvvrMXFf5/ReD/a5ocrBn1PUcEeYoRm
 39eZJfWil30lhE8OhcVk/NeqPHHHC5X+55uKqd7dmBcowczbdSgG0InhlHITuSuaOfbsHUFmzD0
 HFaM=
X-Gm-Gg: ATEYQzz4oc0gQxPdFSbFW1WvjVSGgayRMj07DXN6kZ6R8mjP/761oV9BWeO1xz7CTEQ
 7Hr0IJYMkuhOt88R3AkWb3smr7KprytPrSX+OeB3IgeLyt3N+zVEKb8zu0Z5tWcZytWcrocbrFn
 Xk9UA2TU1EiYaQCiutYuv99q6UZRQdpqGIlOvYtkc76gsAIMOblRhJag2kE1KU0SrmOIS9Sy+T6
 pz/JTmefDIUIZ4E7Yy9L3UqYcwdcq4Md/JH2QKBVIm+A9oBo4KcOnL9WH4PKEobYjsBoJx/C49q
 rV6zwR7LGZKJ5C7+/Utv4gb85ca4vkodvBkur/lyKlN6ph3dLrj0GjEe4Bnc5Xg5kAfgaMi2nYC
 2JJ8wbqzBKhnqFsEHN11DARaMSYn9XEtv0RaX6WmQA+L55c/oOjQU6Ukbxd8L0IzhxGd0hiiD1/
 1cwvkSPec4Ea8BH9h5rw==
X-Received: by 2002:a05:6214:e6d:b0:88a:355a:8d1f with SMTP id
 6a1803df08f44-89a2457f7b2mr61849886d6.8.1772764647652; 
 Thu, 05 Mar 2026 18:37:27 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a316e8eb2sm1063436d6.35.2026.03.05.18.37.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 18:37:26 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Marek Vasut <marex@denx.de>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Yao Zi <me@ziyao.cc>
Subject: [PATCH v4 15/17] sh: Call bootm_final()
Date: Thu,  5 Mar 2026 19:36:24 -0700
Message-ID: <20260306023638.2678886-16-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306023638.2678886-1-sjg@chromium.org>
References: <20260306023638.2678886-1-sjg@chromium.org>
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

From: Simon Glass <simon.glass@canonical.com>

Add a call to bootm_final() before jumping to the kernel. This adds
the "Starting kernel" message, bootstage tracking,
board_quiesce_devices() and dm_remove_devices_active() which were not
previously called on SH.

Signed-off-by: Simon Glass <simon.glass@canonical.com>

---

(no changes since v3)

Changes in v3:
- Add new patch for SH conversion

 arch/sh/lib/bootm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sh/lib/bootm.c b/arch/sh/lib/bootm.c
index 1c118870dad..81d5957edaa 100644
--- a/arch/sh/lib/bootm.c
+++ b/arch/sh/lib/bootm.c
@@ -92,6 +92,8 @@ int do_bootm_linux(int flag, struct bootm_info *bmi)
 			images->rd_end - images->rd_start);
 	}
 
+	bootm_final(0);
+
 	/* Boot kernel */
 	kernel();
 
-- 
2.43.0

