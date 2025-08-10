Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D230C87FDA
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 05:04:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1CE8835C9;
	Mon, 11 Aug 2025 07:02:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nSoQyjVi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0553D8329B; Mon, 11 Aug 2025 01:38:38 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 029AE832C8
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 01:38:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3b7862bd22bso2382920f8f.1
 for <u-boot@lists.denx.de>; Sun, 10 Aug 2025 16:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754869115; x=1755473915; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X2lSDuoevio0lIkCMveF2BioB4SD5HBqj34XLrmJCwE=;
 b=nSoQyjViIrAaVJVGIfGpa8vIZgVg8VuTnhpG+e2WSBFElXCp4zO+fn8l4aausAXQTi
 XDU2R3DOoWX/ObyTcDqkB6h+t9pDZddYHvSRsY+7KHrPErbwZt00jw9yGZZz4EhKyZa5
 LqCOfdzbZCWa8898mACOaphv/HKrBmLHQ1TVGUTFkJ4p3Wxe1nDgp0dffHcml9vP4omK
 RAR2SD+xUnai3TcBBMYtkEUkCATpxGm9ZCCdFOREHYSyZAbm2bmBu4X/TJhY3ehakpcL
 VHGVi0NVWZnm6bZV9b0GZRJCMalBIuPtACqtP8n2vVomfeFlThG9pwjNeuU9L4FTyuAD
 UD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754869115; x=1755473915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X2lSDuoevio0lIkCMveF2BioB4SD5HBqj34XLrmJCwE=;
 b=KaGp5l86ZXPq+dFGYPOJ8XLosr4frwhwAWTrpdo48TbcvwpJEBTaYJSEhfo8c/GzB6
 BdJBJRaBBmJlij54VfS40HLVesJDyLFmm59SeBl/7HTannkSzzBr3b8UikLAYVXhfCEL
 TR/h/0OhCxy/SBhIJUCEF5wnG+7XjWvrnwH8SquentWPdVfyYHWQQzs/1g9xLeEXTVb9
 gTLZ2P17a8Uk2k34/ATqQ384dsFCyfk2dNrN8v+Kanvz7o/HA8xWTvanv1MXj7QPy2uL
 6irGZ/ytnwpyMTQVZI6O3WGHOpWaFmulUpsZ09saEGQGY4yiHGMjeQASZohrSSW70fHU
 77sA==
X-Gm-Message-State: AOJu0YzZfTtZVp9JMTcz1n+EdjnW7Nx8fydA7vU3qldgZOks3IsDfwrE
 59f4VnVMJkSak6QWz0NgVBFblLjHvUSV/yaxZMydhddfX2Y2ZfNZ7TlnTWtLzQ==
X-Gm-Gg: ASbGncsc8SiFdX5ZHikXhjmLtL6/Qd/ZeNmUgKUsD4FP/kWBJuMgtOmCF+MIbU3Q37C
 mJj7tcZOCXeRKYIKzjzyiUVxU2u3i2dvhM7xHXBtIDMwK2wQRNAXGcJA4soWzMw0F1AfhQD3OYR
 oz/TdUpdFXMGK/l2QUJd+kuA5ak/k16NSXGooeUzaoPm907V1SP1zDPFKU+e6bgNQl5dIvGkSgR
 EDnbC2jUQtxRFa4rNv+JZI5/PxyczylzoI0QbBddlrAEiJ61AXhVSiTztU2X11GYup2jGG/+Gac
 ek+EK5/xs9ENH2NyyyiWyPnK+whaeihQeMOoHBgCW5GKiez9kqipWYfoD4HNwCVdwMgnBxNZKE4
 TDJroeMTjGtFOYWT3zGwyb/RbKnN8YA==
X-Google-Smtp-Source: AGHT+IGem4G+Fb0ewkrOeNhzNdXsxD8q6oK4yeM3svC4HOarEmELSDN0ArSijSvwxV8f299Zsibp7A==
X-Received: by 2002:a05:6000:22ca:b0:3b7:8aa2:9fcb with SMTP id
 ffacd0b85a97d-3b8f97e1c0bmr12452400f8f.14.1754869115155; 
 Sun, 10 Aug 2025 16:38:35 -0700 (PDT)
Received: from N580G.. ([2001:8a0:c46c:a000:d911:da6:779c:bd3b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e585586esm242339815e9.13.2025.08.10.16.38.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Aug 2025 16:38:34 -0700 (PDT)
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
To: u-boot@lists.denx.de
Cc: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
Subject: [PATCH 10/10] doc: Fix typo in tools/buildman/buildman.rst
Date: Mon, 11 Aug 2025 00:37:41 +0100
Message-ID: <20250810233742.51902-11-adrianocarvalho.pt@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250810233742.51902-1-adrianocarvalho.pt@gmail.com>
References: <20250810233742.51902-1-adrianocarvalho.pt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 11 Aug 2025 07:02:48 +0200
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

Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
---
 tools/buildman/buildman.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
index 3e41d6ec304..2f365ae4ec9 100644
--- a/tools/buildman/buildman.rst
+++ b/tools/buildman/buildman.rst
@@ -1364,7 +1364,7 @@ regeneration of the file -- in that case buildman exits after writing the file
 with exit code 2 if there was an error in the maintainer files. To use the
 default filename, use a hyphen, i.e. `-R -`.
 
-You should use 'buildman -nv <criteria>' instead of greoing the boards.cfg file,
+You should use 'buildman -nv <criteria>' instead of greping the boards.cfg file,
 since it may be dropped altogether in future.
 
 
-- 
2.48.1

