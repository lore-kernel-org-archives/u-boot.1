Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 403CCCD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 13:54:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1655C846B4;
	Fri, 15 May 2026 15:53:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Tj2CYlxb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 666D784707; Fri, 15 May 2026 15:53:16 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7474580086
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 15:53:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48a7fe4f40bso105742825e9.0
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 06:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778853194; x=1779457994; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w1pPiJxYSBR7uOhsrOEauZ6bnsK/ZKpZyZak9BiCiiw=;
 b=Tj2CYlxb0Ot5cFYG8FyjlR/3UGdlabHKOjrP79NzIsTyZBWewtIvQKP8zQguuhtjs0
 +fyUvO15bNNi1HARu33NtjfZToK7rwzNh+f+MGB1RCAi9o+bSKegaaB465Hkivzqzg/x
 8jadbvbOSgZWSgcK5RjG9XEVilGq9ompjZwWbSo5Mahv1UAQqL2XVZPK31QzDdgHK068
 ajEbEwfg/ahU5Ygfva4oL0nZCYV6eeF8OSYDQ+T2zq8IH6H4kU4rWYICj38wE1cOdObh
 fK70gOI7LTmweLLGdjhWD9u02E5QN0DI+iOnKSQEDa2Zn3QVwzPOLOGhPFt9UfTEhrr/
 MZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778853194; x=1779457994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w1pPiJxYSBR7uOhsrOEauZ6bnsK/ZKpZyZak9BiCiiw=;
 b=VufXuD1Khzu4xbPbWPydaoZUhsynKr41tymmxA+YUwzGOQgwQ8FLnXC4+IXPTw+SQI
 pJ+OoGy4TZ2B5+pVbJJ99Bkyb1+/6KY02jQfHhU7X/27bnJfwtEy5AzfKzqBu9hEveaM
 Pe2D06B3ZfnRaX3dskPYvc5JJY+F33BavalcvllkZFKrMQm3CmOEmdLSx8ws8ZPCsLVa
 ARk8F/V5k+Nysmu0EcIj/h/xmJn0e+LNdzg/AO7OvBjoijHMlCiShIOThdlLl6129u6S
 CcPTfi+bRWf7fFOf8adm9ilcQXTolVs7BrG9DoETcgymQMKbBZWnvnOY4EwIZjp+cQHP
 sbTw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/znId2FtSZCYzAu1EENsQJYs0vsbCFEKTSbdLEfOu8wVohKhzzOwHTg1et9Qyd6bdEDeGengs=@lists.denx.de
X-Gm-Message-State: AOJu0YweacqfiLlLv7xWuq9CmiqypeVldY9vQFf8BlK7gFjG/lxEXNA9
 gZHR62NnxGw/dZ/77qoojLVV042NC1/gaDzThNvO5JUrd1rP9/BgnuzgEuLkwli/wu8=
X-Gm-Gg: Acq92OH/dg/hxYZLObfLLMCW2QVOSdCS6GxrZXOTnY2zhdy+7YOJYBEZ3jfXBWQUdAM
 oM2TWPtX4hxbvzNcsZSWQpOCMWASxPKvkLBo51FHFfvyF8H3INaIgOe7s4Ed8rLN0dVlNercAIw
 8rx+Luc6iY3QTZdOg+jMQuN1H9T6X5fv4CNhWy7c+i/WnITHnMHF6q+X+1ZWxu/hqdKT3mhqpJh
 eXv44Yx8riFbj3LLB4BwX1pnPhFE2VpLJpAbmfFocNmPIeoG58rlFlydezVtMWFMIpUNWIyBPhY
 aZo3/l5CtzZYGP0Ni4qTiDKwK0ouPtOJhqiA4xDm9odq9sr1IuYoJ2NqIbc7HgFxAEU8vwHu+iz
 l+uToohSadzUHEX/8dng5pTuJtPvBqDPqeE0Os5GvF2GNprJPI0/RbWXuuBluQQhdOs/uIx0J7B
 yjQ/vXfdS9/IHw5NGjXLBr1eukGRiYsepSL3dd8Q0w8NmR82Ve42YriDM6yrb2DY8m8u+lwCJ4o
 4DreHQJ89GMfMP0GmU7GlNHo2txB1zmG6skz2gCq/gom6Z/3J08ZzEZZkc30BedrkxMvIKLis0Z
 BmSFw69fPPj+/3UHHdfaRCOCh9hRZ8Nu5XWqDCC9U8TVHf737CLUK4Wxenxr6Ln3FEMJUcrMAMW
 p4gF9D2k0aCuaqJ/yYSCbjzCaDqkXe0mcN6CQtkKyyL6JCE5kI20s8KjdRQI4uTO83/S/aSglI6
 3mrU4hMiJ0m5U4UZjZ9znAxqzHMwjnr7WMNSpy653tkwPVf18FTWdhPHEWxp19ks+H4HQlUOiGE
 Ebqb4UEsC0Idqgw/GYGj9Q+tydY
X-Received: by 2002:a05:600d:8:b0:48f:e6b9:c740 with SMTP id
 5b1f17b1804b1-48fe6b9c811mr55098855e9.30.1778853193958; 
 Fri, 15 May 2026 06:53:13 -0700 (PDT)
Received: from hades.. ([94.131.143.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4c88e5asm65854525e9.6.2026.05.15.06.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 06:53:13 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de
Subject: [PATCH v4 6/6] doc: Add a warning about using RELOC_ADDR_TOP
Date: Fri, 15 May 2026 16:52:27 +0300
Message-ID: <20260515135245.45067-7-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515135245.45067-1-ilias.apalodimas@linaro.org>
References: <20260515135245.45067-1-ilias.apalodimas@linaro.org>
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

Since devices that can't DMA above 4GiB will misbehave with this option
enabled add a warning on the documentation.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 doc/develop/memory.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/develop/memory.rst b/doc/develop/memory.rst
index 5177229630d1..ffee06c1530c 100644
--- a/doc/develop/memory.rst
+++ b/doc/develop/memory.rst
@@ -110,6 +110,12 @@ U-Boot Proper Flow
 
       This follows the same as in SPL flow. In board_init_f(), a part of memory
       is reserved at the end of RAM (see reserve_* functions in init_sequence_f)
+   #. Relocation address
+      By default U-Boot will try to relocate below the 4GiB boundary. If
+      RELOC_ADDR_TOP is enabled U-Boot will look into the dram bank config of
+      gd->dram[] and try to relocate to the highest available bank. Use this
+      with caution as devices that can only DMA below 4GiB will misbehave
+      since their buffers may be allocated above the 32-bit boundary.
 
    #. Code Relocation
 
-- 
2.53.0

