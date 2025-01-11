Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3118BE77188
	for <u-boot@archiver.kernel.org>; Sat, 11 Jan 2025 00:02:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E45FB80710;
	Sat, 11 Jan 2025 01:01:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="a2RTIlvw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 289DC8070D; Sat, 11 Jan 2025 01:01:18 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACBD580719
 for <u-boot@lists.denx.de>; Sat, 11 Jan 2025 01:01:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3c6b0be237cso19369755ab.2
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 16:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736553673; x=1737158473; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T+JdbhlG2S2KYjPUolNvLkHc1q+SGnKUdkVYQ/ADS2o=;
 b=a2RTIlvw/hxYxUimfGG72nX7FVa6I6h9GpC/WV/Tw9Dc49KoYMfTKuCApLY1STk82k
 xF2UtMckTyhNo5BdfdWFsERQkd+f19jnWHBaMnls8PEnL08iqU3JS689T0/pkgdDOLaL
 kt0MYIOMYpbS14zh03K4uku1VtFY5fyLu+JEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736553673; x=1737158473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T+JdbhlG2S2KYjPUolNvLkHc1q+SGnKUdkVYQ/ADS2o=;
 b=Ejw+XWOxx3sy5InJTio7kryaogGPmUFPAa4mDoofS+2/Q6yjfapg8Xb/acAAXp3bV8
 21KVggXfZTBXPK7tVJ7GaOxMmbyHhj75SrUDYQGRI8tZyIySpNaildandruJPVaAIXN1
 +0bz40dlemKDj3//GlQxLaTe0ea09FMimZSxNM48HxoZIUTduGVcGqd9vGB1EyMWQA0w
 gmRdYjCgt56CiQSriI3KBPVNq5P1mx1nD1tGbbTWCVM+HZStBvlTFBZZZ5xfDJ6lmN4Q
 U6f5Umaqh0kWv5vxDSPItx5hA2OB4E/0iqfcStz4C6s04qqETflfbJZuKdiClGnvxlqH
 21xQ==
X-Gm-Message-State: AOJu0Yy/W8Nec4zQMvrmnBqN7v1zADYSH/RYGpOMm7knoADK2uOqpH4s
 kFL4OZ51yWVFq3UGde/PKM70bbGvM0SP2n3YnQxhhIyN18eHQX3yoifVEmwZupJ5QWGaNNO6ktU
 =
X-Gm-Gg: ASbGncstmDE8vNBt80ATPC1jsWXCmJupUWf9HRe0i3BE8qNV5zibjOe/Kg+bqIx+xM/
 pTnmGCNIi76tGHBuldKaugrwrYnSNtSYbLdoJPkLJ+U+r9YQING9YRSAGEVIleG2D/cfuIaS2GH
 QwRTTaTdMGLY8gosbTPyow+EsCOGYjrgYXyy8KKm3O9kxVSZsBHCgyNMWnXiVtY1abalw5ebLJk
 ApR9XhSXQaxzVLHxnrVzZ1Vn/rLlTfTcb5KU/wtzAMchDU3OuHcgAVcc2Ork1DTeR0j7gACD3G1
 Pig0Inpa5Lqo47REpA==
X-Google-Smtp-Source: AGHT+IG31Q+w7ymYAMgtUQnj6YQUHg9xXmipJ+yc6/1Laofr2toHX79NJy3X6aMcpVwSfkub1D0Rvw==
X-Received: by 2002:a05:6e02:5ac:b0:3ce:46e2:42a7 with SMTP id
 e9e14a558f8ab-3ce46e24630mr54613545ab.9.1736553673458; 
 Fri, 10 Jan 2025 16:01:13 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f93desm1171884173.14.2025.01.10.16.01.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 16:01:12 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Christian Marangi <ansuelsmth@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 12/30] ofnode: Update of_add_subnode() to indicate name is
 alloced
Date: Fri, 10 Jan 2025 17:00:11 -0700
Message-Id: <20250111000029.245022-13-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250111000029.245022-1-sjg@chromium.org>
References: <20250111000029.245022-1-sjg@chromium.org>
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

