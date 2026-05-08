Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDC9CD3445
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 00:42:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0344B84E3D;
	Sat,  9 May 2026 02:40:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="bMmr/m2b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD2E284CF1; Fri,  8 May 2026 23:32:39 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E115184CE5
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 23:32:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 92C233F9C1
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 21:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1778275957;
 bh=P9bxS7ZvW/jWs2zPFQZl6n2TtP559v11PvIFdtyhLAk=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=bMmr/m2bPTLLlzLtf5Gja6RTNEeIizBsm32hvP9oICmJAYs4pOyUBI/LxaL6l78Jq
 X4WFGvdnxjni3n+qZXXfhqEA4mcQ57QPajWTUZKlQKx8/Ic0I4xafCc4GfIOAoQpvw
 Lc0HtyFltdT1fAtaFRfLmbO1+5q/PBFaycIf4RB4GOzL1cVfmiwbUU8AlhQj3lBcSw
 3clC04yPqUi1AAN7xYphHPlzk1eXngeJI3sCK3IDysaE8Mn/InVcEVQyPAzo0xEsXZ
 OdUNFOlbkK+0Iy0tfJm1Z6TVLFUertgB41Y4pZ5KoMpIF/9thMJcolp9wVDd+lD2He
 9bGaibovyDbO7KyXVAsEXvuGHA5qYeJC94fRvMANeVAKYtl9XiZ86oYYOqmYjI0bjk
 TRnHKmVdgyO1zbh3EFKbq1hfJogIQRUcV4CJwqAZxrg3O5CRyotpRsjqOklvK8WB2a
 En6+GlmLrhZfOltEQTUywhs/kKsmsifxh8np4q4xh8yubGz9rvp3B3BC40nf9Byh8h
 17Gm20msDXEP4CdK7KpVUFio18Z+4uYhkPJLQxzeV7mMGw4z28ES9/tKalJtOhDcqJ
 voryTC5lzoU0XNnsSHV5tS3g1V2MmL/+3rAIQpVMnrxIafejA6+qwb3ZmGPlHiriTk
 +x2YzyiEdWoX474MjQY6ePOU=
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c70f19f0f37so1403745a12.0
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 14:32:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778275956; x=1778880756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P9bxS7ZvW/jWs2zPFQZl6n2TtP559v11PvIFdtyhLAk=;
 b=k9ZyohByhqwyJDmPq/RRQbEQu7MsMAlas1q8QOBTFkbWIQKt0iivrs3v2WPJ066cYG
 a9ne9H8x84huG4p88dwr9Uy14oUdO2UUH8JYe9UxWnAkc4TKAdwatEnDZai1n8cLQRwj
 sGcs2IprIMkbZaDSFcBeSXwBUkTIwGnyRJtJphdWRwTbTB3Nvjvz+h13ooKQWPpZpDmO
 poZn2NGDNETQLUdFJasWgeb9cYSpAEE2wLQTkzx2lgt48VaIl2THGJS1olfq0ZhJlSV1
 plemTCG6jpfyAEhEMjkYwS4UQaszYxMUFqyyjOkyNH7O6IkTa2PuesBEUhjAAj+PCwml
 FNVw==
X-Gm-Message-State: AOJu0YxWlXVHLd2aoARKHfwNag4HTEhaaWRtqUkyUXCXfd+Zj00iki8o
 AI4RaH3QOq7a7Zvpc9RecupwKxq/UsJRjVAI9zO9WyfoUdRK51m5x28M9Q++MnJHOotlU9GqGsb
 m2ersYmi1VyjqHVz5Rg191j4C/aNw4x8yu2vgf8t5XvVi3eox8DmiHJKx5TNDH0vN/SHkXPoRs4
 vPU35x67Pf5ak=
X-Gm-Gg: AeBDievVvP3OA/V2akIyxlhALas9lSEbyBiX7AWTkuOEvQdUWvdKxDX1vHjsTwtUrMV
 +a0/KJ9Z6alXN7UWvpUVLuzFrg+b3iIqqfQdmmR0ux3UPNgQZ0m8yAmh0hwUFIrK3hmer6v7q0l
 XeW7YR2nunC3phw4+pboZg4DfSFMpwq0MLV9gq05vXvLMdVfEQbWcd6GT/OauIQJQbiZcWV6NX1
 sIw45YNnQ39tOT1nglJmdR+8cPNs3+la+IoaiIMb6XhXvUQ4tMN0NtqU73woR067F+A9F05jfyt
 dVWhRa23XLKbkPBgVaInF2yZlrY9E2HNphJYT8yrgLVYlnzSToIKALCZberRqAKoSpWefXoxlfY
 dEVZ9r1WHanK53DlemuQX8KslwMo639RDWDV5NS9c/DUJ3PKeQwFHw3KVEVAixE7QL+thplfziw
 Q1F6TZWdYEYeSKVTY=
X-Received: by 2002:a05:6a20:3d1f:b0:35d:cc9a:8bc1 with SMTP id
 adf61e73a8af0-3aa8c1edb8fmr8476538637.27.1778275955689; 
 Fri, 08 May 2026 14:32:35 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d1f:b0:35d:cc9a:8bc1 with SMTP id
 adf61e73a8af0-3aa8c1edb8fmr8476518637.27.1778275955271; 
 Fri, 08 May 2026 14:32:35 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83962e7e3fcsm16196751b3a.0.2026.05.08.14.32.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 14:32:34 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 James Hilliard <james.hilliard1@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v1 1/3] boot/fit: read default-config property from the
 configurations node
Date: Fri,  8 May 2026 21:31:59 +0000
Message-ID: <20260508213217.3807786-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508213217.3807786-1-aristo.chen@canonical.com>
References: <20260508213217.3807786-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 09 May 2026 02:40:19 +0200
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

In fit_print_contents() the default configuration's unit name is read by
calling fdt_getprop() with noffset rather than confs_noffset. Today this
happens to work by coincidence: the preceding loop walks /images using
fdt_next_node(), and when iteration leaves the subtree libfdt returns
the offset of the next sibling in DFS order, which by FIT layout
convention is /configurations. The depth counter then drops below zero
and the loop exits with noffset still pointing at /configurations.

This relies on /images and /configurations being adjacent siblings and
on the implementation detail of fdt_next_node()'s post-exhaustion
return value. It also blocks a follow-up conversion to
fdt_for_each_subnode(), whose post-loop loop variable is a negative
error code rather than a valid offset.

Use confs_noffset directly, which the comment immediately above the
call already names as the source.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 boot/image-fit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 2d2709aa5b1..5a502e93106 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -449,7 +449,7 @@ void fit_print_contents(const void *fit)
 	}
 
 	/* get default configuration unit name from default property */
-	uname = (char *)fdt_getprop(fit, noffset, FIT_DEFAULT_PROP, NULL);
+	uname = (char *)fdt_getprop(fit, confs_noffset, FIT_DEFAULT_PROP, NULL);
 	if (uname)
 		printf("%s Default Configuration: '%s'\n", p, uname);
 
-- 
2.43.0

