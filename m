Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85CEBE77188
	for <u-boot@archiver.kernel.org>; Sat, 11 Jan 2025 00:01:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBD93806CB;
	Sat, 11 Jan 2025 01:01:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M487xrbi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AC48806B7; Sat, 11 Jan 2025 01:01:04 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02A19805E9
 for <u-boot@lists.denx.de>; Sat, 11 Jan 2025 01:01:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3ab37d98dd4so7346085ab.3
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 16:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736553660; x=1737158460; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=avW9jpHTYAW9DV1eINQViBYfSM2C/e1G/P0jUkojUtE=;
 b=M487xrbiz8VWE8hebh1qo8ZeOBwtYs6w3mgjFTWkUnPKQfqrFk69uwgRsnpqg2Ce+V
 Hg71eWQ3hOwU/0QdDJWmPk4CD3luXMpiLlyYPlZZsQluu/eFfRKyZFi8IffolI3FIDht
 +Bm1pRPv2BeziEEwXqPjVFQmRcNk15MVl5qoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736553660; x=1737158460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=avW9jpHTYAW9DV1eINQViBYfSM2C/e1G/P0jUkojUtE=;
 b=sGh8uQXpEFuCYslVSVUA3JrhrDldP/9WHo5gPszvJHwRg02N9p8nmcol7dCe/RCwFo
 OeIofmVSxer9Du/oIcwihKf6EUSb9i80afwRXhAW7mDNc3JQWv1kUnoFwQrFyVqSoToM
 qVGDMRSwMercqrxfDZOn3GwDP1PfmQ/MlpRXrCzXDPFzNp9+G3eAsN5Uusu2u6u0DxrF
 AOFuUvFwJ5DHTddAzQdTf4kRY2weyF+KnBj0uP6W7kuw6V+JsqlWU0prQcVEdtNVXlRW
 dOuxPCH7ALjePYpdN+1sd2KG615a1ZNObayDbR8KgXnt7vijMjx3k8YOi0zLeU8DDa4I
 zHQQ==
X-Gm-Message-State: AOJu0Yyr2GHX2IfX3B/OVI9s5Yu8PlkqenXnu9CcLLGIuYO31dYq2F5o
 jLbrXL/OX8/d62pAdEaqTWfMqxCSWjKlaXNixmXKQbGbv9rFJ+QD2JkJBasmDR1RaAb11j5BgIw
 =
X-Gm-Gg: ASbGncsB+uGMvfYmrRfkSxGNruU6ValTkI+ZT3HOI3dqsgdLPR7NXxI4TKA4D2fmJcF
 Rml7eo5NOpWuTxeHit1Lz034wqGmS9F9osnYlg7l4KzzHj8VXaBiaIxiUfN1CW3xIxkQ4fUE4ec
 sDYNEB01yqPrZgJTDHhNzJZFWFKM39OYrY2MjxAMEOMNYVPVqEwAr7CpXwph/UerYF1p/y3VXY2
 iw5C9xYybbuVtr9a6xF2o0/o3zqhfS8b4ja1tFSQHX0Eq5yzWxJuik2XMYXsApDJLaCU6SlaW+I
 JHGpooDRPmO5cLzKPw==
X-Google-Smtp-Source: AGHT+IFptKtlRYMyEsf0jP3NZyqumRumVhC6d41eVMJUNFku5U9JIRLP2pUJmnSMDejnvcMJHccFQQ==
X-Received: by 2002:a05:6e02:18cc:b0:3a7:1c73:e18e with SMTP id
 e9e14a558f8ab-3ce3a8e0a69mr107733225ab.21.1736553660177; 
 Fri, 10 Jan 2025 16:01:00 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f93desm1171884173.14.2025.01.10.16.00.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 16:00:58 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marex@denx.de>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 07/30] mkimage: Update map_to_sysmem() to match its
 prototype
Date: Fri, 10 Jan 2025 17:00:06 -0700
Message-Id: <20250111000029.245022-8-sjg@chromium.org>
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

Update the version of this function in mkimage so that it uses a const
pointer, as is done in the mapmem.h header file.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

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
2.34.1

