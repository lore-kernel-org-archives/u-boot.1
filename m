Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 347D2E7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 16:29:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82B3589711;
	Mon,  9 Dec 2024 17:29:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PFbmBkDJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAD2089719; Mon,  9 Dec 2024 17:29:02 +0100 (CET)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7A928970E
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 17:29:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3a77bd62fdeso17744025ab.2
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 08:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733761739; x=1734366539; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ebyfpmHDy5VYyKCJw8lLa8EK5OJ3MqWeV1NKRq+33k=;
 b=PFbmBkDJrmZsOuHgg2hFjA/kTsU6DHuKhklLLOpKk2Ww7I/fm6zxFmQGwnm6H4DZjB
 6ju3fwRrAEP5+FhFNTkGpADzdlE1oK3cwUfKPdgR0rD4J4DoCigT13BMA5Zm9kUZVBp2
 TGOpot3dKIh217XAZMsHb0dP8Fentw76JXy7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733761739; x=1734366539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+ebyfpmHDy5VYyKCJw8lLa8EK5OJ3MqWeV1NKRq+33k=;
 b=nwwDN92iX7+MrG5onSgNWSL+eFP97hT9TDn/kL4iS7U65VXHFUOVSpswhhZDLW5Qd/
 eZTKAdpMXIR1UJ8FcPkQc9BghwejCN8p35ogzT8zM4e8EV1a7MM7MdtHFptBzBPpWGWN
 fWOAHK8/ZqmWYRtq7fnWW+bJbTj5HoArBtF+G+IFbtnKh/l3GaHya1MRunVm3ZdJeXug
 6NnuY+GHaedOzIBoLnQ/F5+VCgWd+bS/hrxna5i8LWmq0aik8B37OSw2hEygxI5GRfPV
 EEdxITKPD6hepwm5pJMPKCfjjLAG1+y0j+zzwFli7i6LaqxYmqu1r1T5XiViTm8S690h
 8cZA==
X-Gm-Message-State: AOJu0Yx6E7GUUc71QKlp0MsXNuC+1MQs9YKZcXEIFqcOF81vCld8239t
 Eza3ZOFUjvdfKLfLV8GhD1S0ZBnQ5DrYwR5ok1jP2MxC3AQi1Qzfjd6qjnNRlgjOkuTLVJjUlgs
 =
X-Gm-Gg: ASbGncsaMCPXssCeUycJy73ckmY0VVC4q107JB8lC3o0PHgZfmIMhW5Jy17WSoFfq6Y
 6vO+LzUPm09cGw3FtL1nusnQTqNMtK4h6wDHu4uLdApfTx/8SqLunMvRWqObW8l3fS2WHhIP+c6
 fxohpcUI01SYxWu2ZuFOtUIQLPUeOWcYShhZrc+x0FBB9Kez7+auXja8Qn2rr6Uad1NN563mKaW
 5K+55oB8ywht3DZYYhPYfmsPhdbDaiXHSWEj9yWFu6/CeX0ibZZ6Jk+kF60rgyjE4CpTNpRw7N/
 hd77qGFCi5k=
X-Google-Smtp-Source: AGHT+IGdAPF/pRpmK96kbDlI23LwWNNeKJwSDEeQlo6jYdUWedEK+IeDO+zYA3L440LGYMyThHTtbg==
X-Received: by 2002:a05:6602:2b85:b0:841:a9d3:3b39 with SMTP id
 ca18e2360f4ac-8447e21bf9cmr1791536239f.5.1733761728623; 
 Mon, 09 Dec 2024 08:28:48 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-844737bc549sm272432339f.2.2024.12.09.08.28.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 08:28:48 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Matthew Garrett <mgarrett@aurora.tech>, Simon Glass <sjg@chromium.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/8] fdtdec: Correct devicetree symbol for EFI app
Date: Mon,  9 Dec 2024 09:27:54 -0700
Message-Id: <20241209162801.288363-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241209162801.288363-1-sjg@chromium.org>
References: <20241209162801.288363-1-sjg@chromium.org>
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

This should have a single underscore to match the declaration in
include/asm-generic/sections.h so fix it.

For some reason it was not picked up in CI

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/fdtdec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index c1eb1c9f825..e87e537f0c3 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1238,7 +1238,7 @@ static void *fdt_find_separate(void)
 		fdt_blob = (ulong *)__bss_end;
 #elif defined CONFIG_EFI_APP
 	/* FDT is in a separate section */
-	fdt_blob = (ulong *)__dtb;
+	fdt_blob = (ulong *)_dtb;
 #else
 	/* FDT is at end of image */
 	fdt_blob = (ulong *)_end;
-- 
2.34.1

