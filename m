Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C93FAC36014
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 22:40:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CBD981E5B;
	Tue,  1 Apr 2025 00:40:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NNpX5tdr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CA9181F28; Tue,  1 Apr 2025 00:40:31 +0200 (CEST)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 098A780FDA
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 00:40:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7c5e2fe5f17so483604585a.3
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 15:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743460827; x=1744065627; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gKyU6DCfF0luprG6coLsJnF9b8mpDFgBAoXPeNRBiEU=;
 b=NNpX5tdrtxoX7O+kbSZRxJ/rx568tNjMZmF/mpEIq5O3LoSPNRKHqTpFauWrIBhR+H
 P/2/VX7hhyiNnJ8zk/CbPfNWkgzzdTs18U7heZDiK7A4HPv0NIDAssGHTJdnegULAN1P
 NdNQ3eqvM6Bgp9ODT2vuCtw/pC6XbeKXANRTOTJx+qXcr6jCuvDxS0viFux6BfNO9SOK
 xOV3S8cOx/Lw5Pi8BP+m/aldBKtFa+lRdzfS+nTR3fhKhSfJj1JwfgY9xk7zEqbTwbY9
 YsfaUgTxHaTuiCWfB533tG0geZGck7kFTd98Qr1d68MsvBafxa1f7y+iHVn7hQVQOaWu
 0cRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743460827; x=1744065627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gKyU6DCfF0luprG6coLsJnF9b8mpDFgBAoXPeNRBiEU=;
 b=LQ0DAlcIfhf0vGd3AxkaW2uwHQ9qpnfQAxZqrNWPIqAH8BhtFIeQJmq8RPIewrNdCY
 GyE+Xqw8csDtmrCAgwxF9klC6U+4PRL6r9jzZFfwRK6h9T+EFLaK1OCUzSIRjaWWLlgv
 sujxx2eI0mXkAFK6UerbSY3YeyWLY1+xUAO04aFWQNaPYYEE0H691+/94iiCZ7NkpdOk
 i5UTrtdqoCzdopVP4xqWrp4g/dsPfjpfMiECN7GMBc/hZjdAepsd91msN1EomEahYxx5
 nuzjXbVM3TkICdQ78450MqW3gIA4CeMbqUPZKcwp8kIAR05MZ+K5ijY02roePL6KdnYS
 nHlw==
X-Gm-Message-State: AOJu0YzyRfnpn+20wLHd3xLToBqzgIht321gwmcqJFMAPuyq0jNXBvXj
 XotqPFtifs87tfuCmdLXK0+oRZ16o+Dpr8laPKPFdqipsVzFQrkk3eVUkKpU7x5jI7CZMjb72bx
 7
X-Gm-Gg: ASbGncvOKOaRAILB1j8ZtsyWvwU2RfbK8qd1A8fUt8TWA+Swl0KcFmTZDstBkQImKA2
 VXrrAFxdn0zNU7LsLNTUfqC49w/OJzFuwZELocAS3e2g8EgjRSq23cIHdhFJcLNTLJZsBseFG91
 Lyfz0YOudoMJ7WL0PZj6uNVHQxXfFsCwjpU+F9wS3rgVvPW+JgrQ//3jrNtpxrZtsAR9AAPJ8Ew
 9JPQ+LutzVYTXE/AZsTqairiDebeegcwglTX2ma2UQXb2Q3s1xA+p9xcczzh67w4XqXyuCOwi6u
 NnXcHO7SmBvynTBKX0w9ZG9t9h6FBZr9wwcLLXiipAkLh0wWCnuW99rjpqitkCsqTa4V+ZIjcwm
 /uFlcgf2nK+slHyxDGDvmDnr9QBekNg==
X-Google-Smtp-Source: AGHT+IHWiTR4UZnf6IvRXbKG4JUfxGGTCdEMNUxgzcaRd9RYrrGb91s7Y75dCJpTtHvht/9+Am2ngQ==
X-Received: by 2002:a05:620a:25cf:b0:7c5:4711:dc56 with SMTP id
 af79cd13be357-7c690892343mr1562325185a.48.1743460827357; 
 Mon, 31 Mar 2025 15:40:27 -0700 (PDT)
Received: from ubuntu.localdomain (172-97-139-107.cpe.distributel.net.
 [172.97.139.107]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c5f777eee6sm553088085a.108.2025.03.31.15.40.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 15:40:26 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Ravi Minnikanti <rminnikanti@marvell.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Matthias Brugger <mbrugger@suse.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2 2/2] env: point fdt address to the fdt in a bloblist
Date: Mon, 31 Mar 2025 15:40:10 -0700
Message-Id: <20250331224011.2734284-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250331224011.2734284-1-raymond.mao@linaro.org>
References: <20250331224011.2734284-1-raymond.mao@linaro.org>
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

Point fdt_addr to the fdt embedded in the bloblist since fdt_addr
is a default address for bootefi, bootm and booti to look for the
device tree when launching the kernel.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2:
- Update the fdt from bloblist when importing the env.

 env/common.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/env/common.c b/env/common.c
index a58955a4f42..86122582bc1 100644
--- a/env/common.c
+++ b/env/common.c
@@ -16,6 +16,7 @@
 #include <asm/global_data.h>
 #include <linux/printk.h>
 #include <linux/stddef.h>
+#include <mapmem.h>
 #include <search.h>
 #include <errno.h>
 #include <malloc.h>
@@ -368,6 +369,18 @@ int env_get_default_into(const char *name, char *buf, unsigned int len)
 	return env_get_from_linear(default_environment, name, buf, len);
 }
 
+static int env_update_fdt_addr_from_bloblist(void)
+{
+	/*
+	 * fdt_addr is by default used by booti, bootm and bootefi,
+	 * thus set it to point to the fdt embedded in a bloblist if it exists.
+	 */
+	if (!CONFIG_IS_ENABLED(BLOBLIST) || gd->fdt_src != FDTSRC_BLOBLIST)
+		return 0;
+
+	return env_set_hex("fdt_addr", (uintptr_t)map_to_sysmem(gd->fdt_blob));
+}
+
 void env_set_default(const char *s, int flags)
 {
 	if (s) {
@@ -392,6 +405,10 @@ void env_set_default(const char *s, int flags)
 
 	gd->flags |= GD_FLG_ENV_READY;
 	gd->flags |= GD_FLG_ENV_DEFAULT;
+
+	/* This has to be done after GD_FLG_ENV_READY is set */
+	if (env_update_fdt_addr_from_bloblist())
+		pr_err("Failed to set fdt_addr to point at DTB\n");
 }
 
 /* [re]set individual variables to their value in the default environment */
@@ -437,7 +454,9 @@ int env_import(const char *buf, int check, int flags)
 	if (himport_r(&env_htab, (char *)ep->data, ENV_SIZE, '\0', flags, 0,
 			0, NULL)) {
 		gd->flags |= GD_FLG_ENV_READY;
-		return 0;
+
+		/* This has to be done after GD_FLG_ENV_READY is set */
+		return env_update_fdt_addr_from_bloblist();
 	}
 
 	pr_err("Cannot import environment: errno = %d\n", errno);
-- 
2.25.1

