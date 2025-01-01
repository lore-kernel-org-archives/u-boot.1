Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF375E7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:11:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B4A4800D7;
	Wed,  1 Jan 2025 23:11:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eDPtRxi5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C869803F1; Wed,  1 Jan 2025 23:11:10 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C897280317
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:11:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21669fd5c7cso148344845ad.3
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735769465; x=1736374265; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OJplwq3gSjoeHS2oWsw6Pls+LGZ9OxvKceSX4WLBU44=;
 b=eDPtRxi5PkUmSuDSvfEXXc9ClokOus72waPRLtRl1eZmOIK4lN8S7FrPv8hIeSQkEE
 yETyijItsni2LlFXh7e9Jv0gGSupZMVeCxR/PbNZUpSwf0nai7eZHXg5OrfSssCJEHV3
 s4XLthVENL+MGtq8cjW4K1HgEGcvYIrd8mDBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735769465; x=1736374265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OJplwq3gSjoeHS2oWsw6Pls+LGZ9OxvKceSX4WLBU44=;
 b=aISp++mwlxFEqPj2KEZIYDpQ06XAnS41Wlka8Y+1+jN4dV7ehcxx1/aHIhPD0Sq9PT
 Qu8KR5IKbREY5di7HE5WWHOH7G7YEDlKDo+p0EVny7hSdiBDus3jaiaJOhHzDMDXxA9Z
 m/y1QNxZMy2/E8H8s9sI7R8IiXSOgoCU1E3Gtx2fjECt5bjNrozQoKHTk+48jURnzp0D
 kMk1r3QEyyZ0jU4S++fvELvYDoySFky2yFYmhtUiY1RBYgAxR3SETUsRPuosoNJizThu
 WS0xtimu4TrKQnanr+44fv1djBXXFMnf49fOjNZru7ppUZYNrm+5qyJBZDMjqK/5DWcg
 yMdg==
X-Gm-Message-State: AOJu0YxE3nyWq+eJRI2Hw5R92WTIZAT6LqlccSG7dURFSPhFpqELjF6Y
 qNAMcHZSMsJcL9IKxRglhQTMMvW3pFrkro5DaatLig4LYt7YN2otFdO5ldCOHVRFOozP5Tdil1I
 =
X-Gm-Gg: ASbGncuj4YY8YshHWkANy+94unrk5wVxMLalQtd0z3h+qjM6NwlpC4cgVmtctM4WHmf
 gaTS3vs2Gq0Ml1u+Xb/4leFASFh8em0Z5g+NAgL2akAZI5vLRjdhyV0d6zqXYGa9VFOPj6yOF5D
 7CQmRRjDDHynvPJF01EuW+CLBa2W3mh5lbNAKUj2YoRmmTD0Bu+dca1rbNiHbS1ObIGR89xqesg
 zoallYujq/pgt3D/tUSK/QILEXpqI101JJhLXceUygA4GSnry2BQmg=
X-Google-Smtp-Source: AGHT+IHsJBIU/zWSoAiWqZoKrekiyWKVcKRFnsc+FAdL9bvIuTEWsDeEYKrPLgTVs1x/zmJA0F9dbg==
X-Received: by 2002:a05:6a00:430d:b0:728:e906:e466 with SMTP id
 d2e1a72fcca58-72abdeb4793mr61306880b3a.21.1735769465406; 
 Wed, 01 Jan 2025 14:11:05 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.11.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:11:04 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marex@denx.de>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 07/67] mkimage: Update map_to_sysmem() to match its prototype
Date: Thu,  2 Jan 2025 11:08:53 +1300
Message-ID: <20250101221003.1944600-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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

Update the version of this function in mkimage so that it uses a const
pointer, as is done in the mapmem.h header file.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/mkimage.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/mkimage.h b/tools/mkimage.h
index d92a3ff8117..15741f250fd 100644
--- a/tools/mkimage.h
+++ b/tools/mkimage.h
@@ -37,7 +37,7 @@ static inline void *map_sysmem(ulong paddr, unsigned long len)
 	return (void *)(uintptr_t)paddr;
 }
 
-static inline ulong map_to_sysmem(void *ptr)
+static inline ulong map_to_sysmem(const void *ptr)
 {
 	return (ulong)(uintptr_t)ptr;
 }
-- 
2.43.0

