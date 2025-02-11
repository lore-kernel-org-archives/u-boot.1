Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 517F7C0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 16:05:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D80E80842;
	Tue, 11 Feb 2025 17:05:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bq0dj0cZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFF2C80AE5; Tue, 11 Feb 2025 17:05:16 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE156806FE
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 17:05:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ant.v.moryakov@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5450408455dso3916120e87.0
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 08:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739289914; x=1739894714; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZKXzuxunOTVzXXnL71jDLohdkQFXqmscQJlncliKwIE=;
 b=bq0dj0cZF7w29vPdNvtwsWjRu5MIUTr94DWgR6NrJYO4lrP0yuE+U1akZWhwtB0NIU
 eobx6mQNo3L8EGIRS1Xt6xZ8n7rsJt5zazq0SDFu+RX/OA4q3UJVIQcOMcaQRxB7Gb0o
 dU/w6yBAa+Ox1VN4zqQJvONsABO8NEyTCGyi9wq/qOjN7qIrQvb0731HDCIipfCi+8hX
 pewq2vSNvygpWjpET48lHn28Z30mPY6bq+78jyuxaEeJ+SRtEkZtfoNgDNjc1rPnNooE
 GxSd366qh+djyEzdobsG6oD7iIdS2rOdclNj2JlgON4ox1Uzu0Yn3DXmirOSGJGQk27V
 NYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739289914; x=1739894714;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZKXzuxunOTVzXXnL71jDLohdkQFXqmscQJlncliKwIE=;
 b=lcyAlAbAzf5GHat5RKuHb0ekgVPMaLxhImX/b8pGKUxvxWunQISitNnEzN9to/Kr/A
 KHvbdzCuyU/QYY37GUeRRMM7kF9Nq42iK8OG8Cajj18DrmlTPeGL4eLcJIItP09bFxWP
 ljg+P58TH1z1i+LI6ekvJLloH+q4f2H5OG4oAm+ZwnhnNWVoZqPA0Su3uyHlJ+rp613J
 t7iZkxIyjWx1TSM0DO2UtYFrf6mlA0mDbcq5saDwIqksQyHuYbGHehJnTl1cWkBsS48P
 OlVtAMiEFNkM3w2/uVXu/bpsSIHArMQL2u+R7UWVqTN+Bh5G3MElcaSdl+98mFXpRz0j
 sbWg==
X-Gm-Message-State: AOJu0YwaNOSDb4zsjp43zekMjVOOXtRtazbKDB5g4i21n93BFROBaJDD
 yjFhBUDgupByILgyWr/VTdC/9iU3wCzX01xAPZeLDdzrZob2KiO3LUSML3Rn3VQ=
X-Gm-Gg: ASbGnctedkZBT+7Qd+IJztfNRK6f/wLeY0gRbqYijhufhsLfuiJQNa46uSyAdBpWq1v
 IMelInjuZfa7gQpMf1mq954CtPtdzmykW6c5V5Yd/NzX4kwcjTwTo0gTJuO7Uv8dBgGnr3WWe6t
 +Py7XnLTCZ3ZcpxRyeCNd7u5v7xKew6FfifHAh6bBBhRYvvotFQNfNXxeLec5of+3rEIsK8EPyY
 nI6/i4nWC1ESszd3D1rf36U2cn88+s7AF/jFvegsEEpo2hS1Vz/Ahk6v/mukQ2zQkC6KBN9nqaX
 k1Sxdvg5GaDlISVlawfkOPQt01V24TeDDkAMGpU7ZzSKbkooscFLx49xstNABliDpxyoorlF
X-Google-Smtp-Source: AGHT+IE3cgE6Z5fcabW9gYZiMPcFnGWJrIhjeWOkAHOU37/3n4Dj0v/+O80H7UfpfSCRRCThjJeG7Q==
X-Received: by 2002:a05:6512:4006:b0:544:138d:4b7b with SMTP id
 2adb3069b0e04-54414ae63fbmr5939110e87.52.1739289913270; 
 Tue, 11 Feb 2025 08:05:13 -0800 (PST)
Received: from astra-student.rasu.local (109-252-121-101.nat.spd-mgts.ru.
 [109.252.121.101]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-544105bfd35sm1588805e87.115.2025.02.11.08.05.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:05:12 -0800 (PST)
From: Anton Moryakov <ant.v.moryakov@gmail.com>
To: u-boot@lists.denx.de
Cc: Anton Moryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH] scripts: kconfig: Fix potential NULL pointer dereference in
Date: Tue, 11 Feb 2025 19:05:09 +0300
Message-Id: <20250211160509.115328-1-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.30.2
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

The function `prop_get_symbol` may return NULL, which was not checked
before dereferencing the pointer in `menu_finalize`. This could lead
to undefined behavior or crashes.

This commit adds a NULL check before accessing `es->rev_dep.expr` and
`es->implied.expr`. If `es` is NULL, a warning is logged, and the
operation is skipped.

Triggers found by static analyzer Svace.

Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>

---
 scripts/kconfig/menu.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
index 0fe7f3255a..3fb3ab4637 100644
--- a/scripts/kconfig/menu.c
+++ b/scripts/kconfig/menu.c
@@ -400,12 +400,18 @@ void menu_finalize(struct menu *parent)
 				 */
 				if (prop->type == P_SELECT) {
 					struct symbol *es = prop_get_symbol(prop);
-					es->rev_dep.expr = expr_alloc_or(es->rev_dep.expr,
-							expr_alloc_and(expr_alloc_symbol(menu->sym), expr_copy(dep)));
+					if (es) {
+						es->rev_dep.expr = expr_alloc_or(es->rev_dep.expr,
+								expr_alloc_and(expr_alloc_symbol(menu->sym), expr_copy(dep)));
+					} else
+						menu_warn(menu, "select property has no symbol");
 				} else if (prop->type == P_IMPLY) {
 					struct symbol *es = prop_get_symbol(prop);
-					es->implied.expr = expr_alloc_or(es->implied.expr,
-							expr_alloc_and(expr_alloc_symbol(menu->sym), expr_copy(dep)));
+					if (es) {
+						es->implied.expr = expr_alloc_or(es->implied.expr,
+								expr_alloc_and(expr_alloc_symbol(menu->sym), expr_copy(dep)));
+					} else
+						menu_warn(menu, "imply property has no symbol");
 				}
 			}
 		}
-- 
2.30.2

