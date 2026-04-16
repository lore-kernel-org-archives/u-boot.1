Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C6AF43697
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:51:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01CD5844BA;
	Fri, 17 Apr 2026 14:44:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lUgt+FYn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D31B840AB; Thu, 16 Apr 2026 17:20:31 +0200 (CEST)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 023A48420C
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 17:20:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qv1-xf44.google.com with SMTP id
 6a1803df08f44-8acae26e564so55640296d6.2
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 08:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776352828; x=1776957628; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z2DYyt7uEVwCnP84l5G8RvHRS5XSBJMzriRwtU/iMoI=;
 b=lUgt+FYnIhiXWzBfz/2s3y9jDLmcJXR+u7Aa+7DUCbHAODbIER+a23KBar3NQWq62y
 g9kUA9RfSyFfUfamoOi+CnQU45Dw0i6eUSL4g4K4B9th2DAZFK6qv6QCLJ5ai08k5/Wc
 liK3aCxc2HGcm8QO8OCceVVQMqN9w9ACYTZnIuVM94cOl/Uz5iSErvHEweh2kUjSzGS5
 N447cNB9+qA3oyUKs3zvI7pmR7bwlxkDqZol4zD1rYBwL2EljYwLOkoLfLRNlOLjy5/z
 Ct6579FobXAVUvjQq2JEVi8HuZxbn8PDlGJ3eJc0+MCOs9EyH0OJ6HUbG8kKasRqgcVq
 CuMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776352828; x=1776957628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z2DYyt7uEVwCnP84l5G8RvHRS5XSBJMzriRwtU/iMoI=;
 b=dweFHP6nQTqxoWc/6oIzZ3kRhgfc+htgvBtWJaJTZ7Eui9gjil5VFx3SCdNU4cLlmQ
 9bvOEDDO+KHU4VsHc7XEjBAI4Z5fMQUvFcVbey2shD62yLyyvh7Q8GffcgZl6bSfUCoI
 DWcq/LsE4T9QzBmDhb4syWWrVseLvaxqnISLvMcktdTmCmFtvUiE7wuROYP5fKSokOzt
 cc/hIrnR0hVYyWQFQUd3MVR06ppxLY5KoIfyDaYVuhle5lLwSwYZz6iYcFuV57/V8Gnm
 OpnWNEg/tDsITnSSZmTpjUBqwfGAJMaCI2fQe6YApNQwdtIX0KKRzdYH+YaNR5CQvGLV
 IAnA==
X-Gm-Message-State: AOJu0YxYHC6ECAHOCgyUOGqub0iF9NByGdlXCZy596d2C/xGC4Gnk5FB
 i5Epz22vrGBwlxVtoBwFd5HlHMf9F/HnekqT6u3W/qxdQLoCs9Bm14DIzz3EKNiL
X-Gm-Gg: AeBDieuupFAb0i5Oob9SsbFjLpp8wOHGG0UNY3g32jdShMjRjAVf224awfdrYLcwcdD
 /niWUbBNmDqWhloOjRY35/yacbLpFcnX1hEGIuMHKX1auzURzyV6UpzHCAIGCgfK46J+eAn7nop
 zjBljV72yawnWquJvc7T/3d7qr5SRgj87XX2Er3fuBr15KOXqaNExzQqP3F4NEeKEkuyuCA9B2c
 nzTDLnYyVyezK88D/4+/DwSnDd3QIDsCxA8Sfe+eE8LpZEpeOuGMYdKmA9waUkwk//+suIMHOa8
 34quPMty3mRlIpVftVmkeIGBsod4cQwyLvOAOesqHyB8Ffp+HyZq2t+/mwnZ69nHUo2lXZvB+P+
 TXMzUhUz9VH/lLH7GZ3hPW6HMLrr78A7Bve5Fxp9pJhOho/Y0t93jKP+gxQ6F8H+0kZ2vo0/y+K
 UCPfPpxZiijBhdYgx9DeoTofdQGEx7SeXzwg==
X-Received: by 2002:a05:6214:2422:b0:8ac:a8df:639b with SMTP id
 6a1803df08f44-8aca8df6733mr306226466d6.39.1776352827628; 
 Thu, 16 Apr 2026 08:20:27 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ae6c93b7e2sm38561586d6.8.2026.04.16.08.20.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 08:20:27 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Ozan Durgut <ozndrgt@gmail.com>,
 Ozan Durgut <ozan.durgut@analog.com>
Subject: [RESEND v4 13/14] arm: sc5xx: add missing boot env selectors
Date: Thu, 16 Apr 2026 11:19:48 -0400
Message-Id: <d92e6e885515ddc3c205623d6edc56ab7c53aa19.1776344788.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1776344788.git.jcethrid@gmail.com>
References: <cover.1776344788.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 Apr 2026 14:44:25 +0200
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

From: Ozan Durgut <ozndrgt@gmail.com>

Define the boot options for SC598 SOM EZ-LITE so the shared ADI boot
environment includes the expected boot commands for this board.

SC598 SOM EZ-LITE board environment utilizes the shared ADI boot
environment, but it does not define any of the USE_* boot mode selectors.
Without those selectors, the shared env does not generate the board boot
commands such as `spiboot`. This leaves the default `bootcmd=run spiboot`
without a matching environment command and breaks autoboot.

Fixes: c9e893d ("board: adi: Add support for SC598")
Signed-off-by: Ozan Durgut <ozan.durgut@analog.com>
---
 board/adi/sc598-som-ezlite/sc598-som-ezlite.env | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/board/adi/sc598-som-ezlite/sc598-som-ezlite.env b/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
index c7d7932064a..ab1acabef53 100644
--- a/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
+++ b/board/adi/sc598-som-ezlite/sc598-som-ezlite.env
@@ -3,4 +3,10 @@
  * (C) Copyright 2024 - Analog Devices, Inc.
  */
 
+#define USE_NFS
+#define USE_SPI
+#define USE_RAM
+#define USE_MMC
+#define USE_USB
+
 #include <env/adi/adi_boot.env>
-- 
2.34.1

