Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A71CA0EDC
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 21:00:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8EEE83A47;
	Thu, 14 Aug 2025 23:00:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="cEtC3fWg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B514883A1F; Thu, 14 Aug 2025 20:07:16 +0200 (CEST)
Received: from mail-yw1-x1163.google.com (mail-yw1-x1163.google.com
 [IPv6:2607:f8b0:4864:20::1163])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2F1983A13
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 20:07:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=broadcom.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=dregan@broadcom.com
Received: by mail-yw1-x1163.google.com with SMTP id
 00721157ae682-71d6059f3aaso913037b3.3
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 11:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1755194833; x=1755799633; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=etbuUdpypO6/LfP2tknlT8HDcNbEz5Ub0dqWkAhy3Fs=;
 b=cEtC3fWglN1sjIW0MJimZWgJRvBLX6dE7CdYsPTlJ7ZLPBNEmnmNBpebr0GLvtmfDz
 cUnFsK78diOHd8m5apYt9ExZ1S/Dh8ecunzgD/fyBJ5r5IA89+3Mif8HkWnIAmJbxNBP
 N8MwVcMfD6ExLPwQScdw1cSD+lDSQRWaCyL/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755194833; x=1755799633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=etbuUdpypO6/LfP2tknlT8HDcNbEz5Ub0dqWkAhy3Fs=;
 b=r1cW8fjfLbexZ3h/DFlTwsP5vqKUArBSZFe75C4FWclIU50TpmytMY/VcOHRw/gaPg
 xksrhEsVtb4Dz7LnDrzsQtiZtu62yqW0yneKCNNjYsG3MzkB16snvxm5qBEqxbx3Xnf5
 7pZ01XTFnlI1z8dRSrqUeQuDd1qFexITH9AJ8uzuNcpu15/c8IFfnsH7Ty0PaLYXLE9E
 Dte19PKVjpBn9TS4F6oaxov+QcN5OxHS24/lyB4SMdoDBk/IIQNvY+pkrxH8bDkOrQs3
 KZcoHQ+p3DGT/VUReQ5C3bwflsTyiJ5krpzitPCyVu4s+ncR7OcGnKMK66Xz8Gc5CRxG
 jqQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBTQQefgC0hS38ACsX8kbeo5DhMhHz1Ou16fuiahohCJt8f7t5yqK0Mccf3XFG2Zu4EYOTlHw=@lists.denx.de
X-Gm-Message-State: AOJu0YwcjsJLCIK57FpYaIhSLZxoNIyNQjXygv3OpVMmj9b99Dpq4Ye0
 P+Vg7GrOxikFfP87vACq680DCvkQWdgHJky2qd/8KO/Jc5BmmT/Te9h1n+4bNEJSWvJIH4y1mTo
 t6Mt1eBKf/n3znT1yCV2m7U3nZmUAYOwz9w==
X-Gm-Gg: ASbGncsOszdD/Xm3oPKWyVY4sDVdVQp7oJwPfNJm9ifW3I6BNDpcrB3wwt2W/LqLSK7
 ekTLFyVWRqqQgnzGU0M6FeiKq33DvQyGLBwKJsLUkDPXqGhI3fonvRO9qAXKOV0t8UxLe7NN04M
 TPAq8/gIm2U/rPlbuQRgBd5FUlKBtWfKCcTuAATFVwaGbwiHmrgldLkPYNDcRJcZzl4h4wlYqT1
 UImkhu6+2ttv650uLZ5p5KU8nQYAEIm8YA4UbfM/5PVNUvqm5ksvtjzm9XM2ygUU08vGpdyz12e
 +eyoFDYy0gU/+zk/g99NHZzw2ykSy1uLE6rL2Msgtcvyzeko2BjffnfPy9g3EDQvcnV17gOE+3Q
 1EtiLRTplqWlFZw==
X-Google-Smtp-Source: AGHT+IECmkwawMyRCiEffxj/cSuHzL75dThYpQ4zvSf/XYCPGX36uzLVI11d+UxxzAguDbavlUtyM8q8KqZc
X-Received: by 2002:a05:690c:a591:b0:71d:500b:d255 with SMTP id
 00721157ae682-71d500be1e0mr35953447b3.0.1755194833356; 
 Thu, 14 Aug 2025 11:07:13 -0700 (PDT)
Received: from bcacpedev-irv-2.lvn.broadcom.net ([192.19.161.250])
 by smtp-relay.gmail.com with ESMTPS id
 00721157ae682-71d60d6b387sm1970937b3.5.2025.08.14.11.07.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 11:07:13 -0700 (PDT)
X-Relaying-Domain: broadcom.com
From: david regan <dregan@broadcom.com>
To: dregan@broadcom.com, dregan@mail.com,
 Quentin Schulz <quentin.schulz@cherry.de>,
 William Zhang <william.zhang@broadcom.com>,
 Anand Gore <anand.gore@broadcom.com>, Tom Rini <trini@konsulko.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
Subject: [PATCH v2 1/4] cmd: nand: bug fix MTD_OOB_AUTO to MTD_OPS_AUTO_OOB
Date: Thu, 14 Aug 2025 11:04:55 -0700
Message-ID: <20250814180647.1805196-2-dregan@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250814180647.1805196-1-dregan@broadcom.com>
References: <20250814180647.1805196-1-dregan@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 14 Aug 2025 23:00:20 +0200
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

bug fix MTD_OOB_AUTO to MTD_OPS_AUTO_OOB since MTD_OOB_AUTO does not exist

Fixes: dfe64e2c8973 ("mtd: resync with Linux-3.7.1")
Signed-off-by: david regan <dregan@broadcom.com>
---
 v2: applied fix to env/nand.c per Quentin request & added Fixes tag
---
 cmd/nand.c | 2 +-
 env/nand.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmd/nand.c b/cmd/nand.c
index 2f785deeb7f6..e09e145bc2d8 100644
--- a/cmd/nand.c
+++ b/cmd/nand.c
@@ -412,7 +412,7 @@ int do_nand_env_oob(struct cmd_tbl *cmdtp, int argc, char *const argv[])
 		}
 
 		ops.datbuf = NULL;
-		ops.mode = MTD_OOB_AUTO;
+		ops.mode = MTD_OPS_AUTO_OOB;
 		ops.ooboffs = 0;
 		ops.ooblen = ENV_OFFSET_SIZE;
 		ops.oobbuf = (void *) oob_buf;
diff --git a/env/nand.c b/env/nand.c
index fdaa903cd612..709f8411eb6d 100644
--- a/env/nand.c
+++ b/env/nand.c
@@ -275,7 +275,7 @@ int get_nand_env_oob(struct mtd_info *mtd, unsigned long *result)
 	int ret;
 
 	ops.datbuf	= NULL;
-	ops.mode	= MTD_OOB_AUTO;
+	ops.mode	= MTD_OPS_AUTO_OOB;
 	ops.ooboffs	= 0;
 	ops.ooblen	= ENV_OFFSET_SIZE;
 	ops.oobbuf	= (void *)oob_buf;
-- 
2.43.5

