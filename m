Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E7CE7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:12:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF1C180488;
	Wed,  1 Jan 2025 23:11:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kgtlvpRl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3641803F5; Wed,  1 Jan 2025 23:11:53 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 680B580317
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:11:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2163bd70069so47507855ad.0
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735769509; x=1736374309; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8npHRNNjppHRL6LvZwpi+eDEz0fJEpIJrRuwOZcKKHk=;
 b=kgtlvpRlyHy7S/uOplrqU+LJsRypdcH24tWdX0YtYAjQXnWKllCyO0QO+W//6LYfIk
 P1rPu2Uop6fb8WcUvJcw0TbgDxsiFKQ7//ea5c4oSJupnUKGDTHIgt4nS/Mn6YxLO5t6
 s91ytgljm5cwzS5dRxs89Py2CycWvi5B6E0hA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735769509; x=1736374309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8npHRNNjppHRL6LvZwpi+eDEz0fJEpIJrRuwOZcKKHk=;
 b=FUimte5bEVeO5kyUSUtn1PVMckAN/swn9q+qXkXTI+6b5mDMfDYhA1eMcIZhzNiqar
 gnHiYglMQle3hGskMiu5kHHYb+bqb4BtdQaQp7XhfMknMHSuxlteb3tcqkN8XZUu6tP+
 xJxLD/arQ7VShqbJh7vK924ojByl/GRfBauVnPBN2NRw18gbtooCsGoHfRKHGMiZ35/v
 H9k/biOw7AJJYUn5B6NdCUBhdwcTwvKUkfJerRwFfK6u63KuHwxGl4uPag+YB5qvUe0m
 aY+wPOqWhIpfpn+W5PLg2R/ro04T2oWcaO/YqKIv05B64TlcUYG7msx9zY5QuFhIn+i+
 vstg==
X-Gm-Message-State: AOJu0YzYrLnpfYN6rXDsjHgOil/F/1cetqBfXx/5Q0RoPLbdWYMj3zCk
 XNINUv0tVyVURQOImbCohQzpV1uMq2pZ+TjT5NtgEfBkpib2IpJANOkHaF2kHjw1Uo3tZBW/p4Q
 =
X-Gm-Gg: ASbGncsb4GTPgr+i2+6+1Xqx4hJ4kuMybKIHnCP181uHl2r5PessTb3GuZDtAQOxGsr
 PbDlcajQN/03myWV3UbTIuibqgrulGxIALlY/Rq+IlpSQ7cxhJceSz6fI79HAspCfx75KmW1jCp
 zaqDtrFodIs4DrRbB/7yD6EJF0eVTf5fDGjDB+VShYPiIhLnNx0mGbUDI/GzGaj+vhzyeGxO1PX
 F6qXWKhuHSp/WIPL/KxlzszJLiZ9b9fzzRalpBhy44c5TN1nMeQxtA=
X-Google-Smtp-Source: AGHT+IGXszeuwAyjONXcXyYWZWzPwrVcf8lY0p+XT9NlcCIGa3bVNIoFboqcPs90m/eSvi6nFBF4Tg==
X-Received: by 2002:a05:6a20:1584:b0:1e1:b727:181a with SMTP id
 adf61e73a8af0-1e5e0799709mr66939965637.24.1735769509011; 
 Wed, 01 Jan 2025 14:11:49 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.11.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:11:48 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Christian Marangi <ansuelsmth@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 12/67] ofnode: Update of_add_subnode() to indicate name is
 alloced
Date: Thu,  2 Jan 2025 11:08:58 +1300
Message-ID: <20250101221003.1944600-13-sjg@chromium.org>
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

This function allocates memory for the node name, so mention this in the
function comment.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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
2.43.0

