Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A8BC56208
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 13:05:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5DA4440613;
	Thu,  6 Aug 2026 13:05:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ptjYrz7wW2xJ; Thu,  6 Aug 2026 13:05:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DC24C407D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786021528;
	bh=q7AGCvCq0CIpFMk2Ke81jKBSW90cpDnl1GsTvWYw5Kg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l2A2MPIlXYcNiNTsx97bRzarQ2oi9ziH+86m43dgcODsXV1rPT/ZwaZIb51eukmhT
	 G3B8x0rnoz4/cdU4ZIle0wKEI2TIkK1yOICOGNXT4DrdEj9o7GhHHGRxKKA85T9WDW
	 s3jOtdCqUTd5QRIplT+FVs8GFnIvRWILBwqM8uz3DzdoJ/c3yeezEApQJzTOszZMx8
	 w5FGFMYPNHHFNkOdJs9wBJHIsid2lCz8Z9ZthlXDT2nSnvKABONiBBuJnm5wQySQEe
	 riYensEDE/VvlS2WDZ2iXPJsYlOiC6YV0mkMlELI9DXuiik9goQj7G1QRKtdXVvjeu
	 YADEcFrHThCeQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC24C407D2;
	Thu,  6 Aug 2026 13:05:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7CCD2194
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 13:05:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 62A5C60763
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 13:05:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kykKJcd3WhPV for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 13:05:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 8919A6080C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8919A6080C
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8919A6080C
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 13:05:22 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49553515a8bso32540965e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 06:05:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786021520; x=1786626320;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=q7AGCvCq0CIpFMk2Ke81jKBSW90cpDnl1GsTvWYw5Kg=;
 b=KiXNy0fxy7FP6sJPWBwwnkv2dIX5/oq67JdbJLTPst4PdyoXMbC9Pusew1fRtI6XI0
 1vk4lThXRLaqn6gHVeVU+E33hr/ro5rCsvoP0QXYWDw+CyxQoNsM5pO9vr8wHTHcZwk6
 dAmMNSvKvA9pBjR/vCXpyBlkt/c2kdjH992+K9AxwqCO+/pXgVuqnZvr1QYzmbhnxt0H
 nsB4rBkyjARgADBikd1qC02/zN4Dt2XZfHwIL4Zl/houfY+GbSC3FxZQhQ95XugFblsd
 grUUXK+jjYlqqSBmAlI/I+2l4/Ruo80UlvqGNgKxYDHN/WTJvJN+kAa4rolF7SuD1Shf
 yEpg==
X-Gm-Message-State: AOJu0Yyk0oVA/O8w6c5KRoX72znZJq9mIZcFDIWoeBWvPRTIX+l4Zh/l
 s/c3ITktOCjfgitMf62hoQJOmuKnSOcXOFmkRJmJrPWV/PpQeVe+e8Gj5FCYv3a7UP0=
X-Gm-Gg: AR+sD10mAQc5snyrnhY9f3tGo0ggdZ4W4MOwdwxNLE49Y9Lk3X2IP7/9Jhm6f+btbTK
 f5Dbg8kmkdhM8Xbea8ZfbuA+0boksa522ji2AC2DJkCkTlBrz3i1vTkW0Gve30U95CmAXgTpiUk
 +XOJV+0qXEvCZcMHEonVVN0h3dlXI8y9Bj80xnwigAXQLiuuVgQ80pY7n/vHChwTDOqwx8JxNTW
 Mbh2jdNcaANML3R0G/brh5ADL99zxUY74IPJJgmw9sG/GkoGfzRmYPCAgL9vHvU0onUCWe3JGFk
 2OJa82VEueGIHQdow4kZ6ui5cCH5RW4h592iAGg6qKR709mOswFCSPkpck83+vgM3y2ICb3qoRq
 Z219//24UON9wnOO1Ls3GcCbwBKKw/dEyPmLq7RzgHG4teu1qeeY3AAgXKLf1hv/szw26/FFqjH
 CL7Jcu2BY5pmr0PUq9gcrNyLrpF5ZHFN6C+p5ekzneF2r+PFGU8YpS2DIwklas9o4EF5OSwThOf
 T9xuZgeQumfi7p/FMGpS5vqCyayWlSWTwYXmzI7RPAywblgyEGM+Nq0BMaK7HQX61Mo1aR5gZZL
 gIWTT5M6fTTAmD2R8kYIzW9LA/uX9h2NZsViNPOxB6I24Q==
X-Received: by 2002:a7b:cc0b:0:b0:496:cb48:5eb8 with SMTP id
 5b1f17b1804b1-49959e38ecamr17234115e9.15.1786021520389; 
 Thu, 06 Aug 2026 06:05:20 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499542241c4sm58739975e9.11.2026.08.06.06.05.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 06:05:20 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 06 Aug 2026 15:05:20 +0200
Subject: [PATCH 2/2] initcall: display error code on error
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-improve-logging-on-missing-uclass-v1-2-d477f0054f48@baylibre.com>
References: <20260806-improve-logging-on-missing-uclass-v1-0-d477f0054f48@baylibre.com>
In-Reply-To: <20260806-improve-logging-on-missing-uclass-v1-0-d477f0054f48@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Julien Stephan <jstephan@baylibre.com>, dlechner@baylibre.com
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786021520; x=1786626320;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q7AGCvCq0CIpFMk2Ke81jKBSW90cpDnl1GsTvWYw5Kg=;
 b=R1JMIjc+0uE4CxCY/l/oNEKWDeM9lsyx55WmKH3CEOJmgr7i1s/oUhUETw2LuTZ4wb
 z1FYLeq92LG3lx192r8Vckd95pgXQn6b4fafVhiORQ1nVLoLQsY0xHxM+ZiCTaIVjSmW
 r7jAQ4ga1UQDIzO20+OUQQ2mETcI0wUT5xs48PFsPM03e7qR6hL4Yelc6PQLkXm12ypN
 C3pvgJnUSsirYigd13RzbST23m1AYxsq9Oc4r8P210uIgvLMQauMaEdJVT1tr3jkhTNx
 ELYUNMom323rkcWxKdFZS1WSrVlLyONGXpo9skQDDTHVPchuw6jH0QqqfZLLBXSKiK+X
 zUEw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=R1JMIjc+
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Currently when an initcall fails the error code is not displayed.
Display it, along with the corresponding error string if ERRNO_STR is
enabled.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 include/initcall.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/initcall.h b/include/initcall.h
index 220a55ad84d..f1f3c2fc088 100644
--- a/include/initcall.h
+++ b/include/initcall.h
@@ -7,6 +7,7 @@
 #define __INITCALL_H
 
 #include <asm/types.h>
+#include <errno.h>
 #include <event.h>
 #include <hang.h>
 
@@ -14,9 +15,10 @@ _Static_assert(EVT_COUNT < 256, "Can only support 256 event types with 8 bits");
 
 #define INITCALL(_call) \
 	do { \
-		if (_call()) { \
-			printf("%s(): initcall %s() failed\n", __func__, \
-			       #_call); \
+		int _ret = _call(); \
+		if (_ret) { \
+			printf("%s(): initcall %s() failed (err=%d: %s)\n", \
+			       __func__, #_call, _ret, errno_str(_ret)); \
 			hang(); \
 		} \
 	} while (0)

-- 
2.54.0

