Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2379EC0219E
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 11:53:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02EF180885;
	Sun,  9 Feb 2025 12:52:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="uZd+sB05";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB5EE80819; Sun,  9 Feb 2025 12:52:42 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AF3C80819
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 12:52:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6C3193F866
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 11:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1739101958;
 bh=0sU4oiRXyv6h+IqzHP3ly6NXdxRro0WcL8j2EVveVjE=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=uZd+sB05TiQ1jbr8IR2kDsnaoOJRBd3ueC7/mrcCgF7GcY3maY6W3MDqcppx86H/e
 ztLxTIqQSv4LNbwLMIFIeuJ/YT/1xROL/HWdezDHChTfLoIUJt0JsIKcuGEp+DECz/
 t2qttWE7RRZK5sTYEVSGeB0cuwnCOcRkB81ZkYdcXPEVsYEKvXbOmzQh9Oyxa4eou0
 MSrtchjCBZsfgWDTGJ0e8fS4Rt4i46dua3LaLdKmTcMhiunhKtUqL3/YcJRIDOrZ83
 HEYJie2PLIcO9JkYW4AgGR/4C/gO6VzTbj1HGlp7/6KKfVoo65ohxkrvPWilmcVn+d
 xkuB62Xn8/vDw==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43935bcec0aso6413235e9.3
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 03:52:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739101955; x=1739706755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0sU4oiRXyv6h+IqzHP3ly6NXdxRro0WcL8j2EVveVjE=;
 b=awa/4lsYKszsfKeH8QaiSBW6Zemu1nUFTOIADRQkvV+TkbZOIoLM/vXShK16d7lprr
 L+3XfZUsS1GkLyrCvtXK1nwIyLaDXqi1dQdBY2OeVZcqIeB557F46ilZ9hkuWB59NGhd
 DychW1dm05gYXhfshnJuEW6YLZkQzNIdtqTB6Av9FyhjRpBJqhEbbChgzmdMBYBor+XC
 /lzHlJvSiXKYKRPzjo9q/Pjt82bdFRSQwVhLOgczgtmt/YHfdKCjAAPvBQ9uURaWQOTp
 Mww1Rf6bAaDsM7hZCoo26BW48jlGphoadeRhtDSwdF3AhMtMUFPWaCUe0JYhZ6EOpeB9
 jwjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcjtp3RfFSUhE7ITgA1pXm1CFzX11eolvxdassuGyT8uqWrhmHRjY53csg0bxRxifbnQ72NNM=@lists.denx.de
X-Gm-Message-State: AOJu0YzJrTZTCEHZ/21byjuSKJwI0h+YcDGOeTJ3TAdmBy8mJHFCsBS4
 Jw3yxfJRJliE55D9tmYFScFSnUn3/99h9zCX1i/1XBfAUzCPcANnitb6zn/NobIfx0BSQes8sYY
 sgi1N5jCkNfAPU1XUuJYYmZ8r1w6iekt9n48SN7sBhrWlYB3oWTajdZ/GgY3XJ+h2Ub4=
X-Gm-Gg: ASbGnct0va0WWK7i/SpS1KlYR8Ymp3dhzxYINI9IKXqW6BB+L8G6tw0s4GyVAoBne9I
 HKYwQCgXlBMyYBcDfuvXkCbCkjtBP7FlP8qrqMazRs4Jo5oFzFmnIBznzAoJCl0v5YoyBVlPvd6
 T3cYsPV1WzdNlD/qp+oMRlfJBkDEiGttRINipMAdu4Fb1ujBLZpoSLnaU51mkwdeQ+/XV4YwhOB
 vv/GrSAHLOUIQiYRBb1gVLzdf8EmU+yCO57FaIN+FCb252+kUKjuJMBknkwELVcDRvv73Rk3pfX
 BqlMBQGcyWBxPD4r6w1ua0/cDMAadPtguPCqkdaw4/sKbqlpXx8c8za2SSimVEw/FvzIz4sEMG2
 fEZldbqw=
X-Received: by 2002:a05:600c:5114:b0:436:6460:e67a with SMTP id
 5b1f17b1804b1-439249bcdb4mr68491125e9.25.1739101955576; 
 Sun, 09 Feb 2025 03:52:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/u1Sk+jx5PaZDGxAEKrscS6/42btp/OwC3VfA7/3ilZ6GdCESEHO64Oty2WLAsbgBZJXLVg==
X-Received: by 2002:a05:600c:5114:b0:436:6460:e67a with SMTP id
 5b1f17b1804b1-439249bcdb4mr68490935e9.25.1739101955262; 
 Sun, 09 Feb 2025 03:52:35 -0800 (PST)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391dfd84b9sm111772795e9.39.2025.02.09.03.52.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 03:52:34 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Jean-Jacques Hiblot <jjhiblot@ti.com>,
 "Franklin Cooper Jr ." <fcooper@ti.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/2] boot: continue in fit_find_config_node()
Date: Sun,  9 Feb 2025 12:52:16 +0100
Message-ID: <20250209115217.85250-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250209115217.85250-1-heinrich.schuchardt@canonical.com>
References: <20250209115217.85250-1-heinrich.schuchardt@canonical.com>
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

If a single configuration node lacks a description, this does not rule out
that another node with a description matches. Anyway we have the default
configuration as a fallback.

So continue if a description is missing.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 boot/common_fit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/common_fit.c b/boot/common_fit.c
index a2f9b8d83c3..4c134e0e86f 100644
--- a/boot/common_fit.c
+++ b/boot/common_fit.c
@@ -57,7 +57,7 @@ int fit_find_config_node(const void *fdt)
 			printf("%s: Missing FDT description in DTB\n",
 			       __func__);
 #endif
-			return -EINVAL;
+			continue;
 		}
 
 		if (dflt_conf_name) {
-- 
2.47.1

