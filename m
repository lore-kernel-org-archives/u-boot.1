Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC66E77170
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 02:41:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3398B89774;
	Fri,  6 Dec 2024 03:38:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lK6/r7ne";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 225DD8975E; Fri,  6 Dec 2024 03:38:07 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DBBE8975F
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 03:38:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-8418f849466so55617039f.1
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 18:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733452679; x=1734057479; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZqrsMmPwPo46XJn92V2eHwp/JJbrP7PGh6pnbvICI1A=;
 b=lK6/r7neCATuwWtmzNRZdlEIMsSRDN5LAp/rOC+n40bGrn/YK9qAiR8xeU3h24ekB/
 a/80h5Yh8Yz4OnAcALa3BVJ1yCPXDwyGZT1v32fa9x//JnVqb37D6k7glPkFcSC4stcq
 8ThHH95ohiAAmw9ohQIjUQLkyRtPwKi3NqXcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733452679; x=1734057479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZqrsMmPwPo46XJn92V2eHwp/JJbrP7PGh6pnbvICI1A=;
 b=u4I4ltGjhsNcyB7MudjqoYgfQkh5P7vmOXP+IqcW3Rf7vr29MPRxV+X4Yvkmn873lO
 Alu1ThhYECg1MzvLRSsGPRmRFRUxIeAcEJbB72PrtBuF4EBX9acUs+6+ZFn7dKO3cz3Y
 bsunI4fwT/BQA2cVdghTFTcWSH/ZpafkVT95USe7YrenbcQK1uDKppJR4RTeDxHz1mTn
 0VccSi9X6ultvMXV7qqV0xhnFMjhxMYXH2N81ZD1oPMnDhD/+FdqK4tkP3Hoq2YTv8Hz
 NYwQQBFzi1KXZg5lJoqvZwVL/JRjVDvXLqOPaSYfs0jsF8cUtXPElz3Gjpi5SN8Vc74n
 bCaw==
X-Gm-Message-State: AOJu0YwIgEM+bd7cBZz6dTj1GhpERc5/+heao5fpzPbkQsFqevdi4vr4
 vWhlUT+oTDXoRw032vbtCrJ1y0bMQL5RGQcjva3jfcEZ84/pD0JwuRrme7OF2iBb85VvxTmkKEM
 =
X-Gm-Gg: ASbGnct17qKCtRdqNAGGLlLtXIO6Wp/P2MV0CbbQBaqQ9b42M1VCPeQrI1NFBa4p6zM
 /zYs+9qyhtO/HAjPlNPQhfTDM7lYIdgSAOhhrMIZNDCD7d19IQF7WDbcbuzq24qgRDuHc7vNfcZ
 U+TNvDaoERwGpwgmxIiFsypwlIQP53Ol1JB/WvajYQ6qgN1+cb81GVo8X+e+hVuQC84dorUnd9F
 czcelbUZxGYi+4YsGipt5HBhBgdffINTs/Vxw8xUpLhA8EXSIQrQadR318wpMppbmoZHxT/chCK
 C2YyqkO4oIo=
X-Google-Smtp-Source: AGHT+IGMiae/08z5le6251noICsxR9tvxmzrFoKPLN7iwzDO+PFvWT9xXvRq0IdM50ZnLCzl2T6v9A==
X-Received: by 2002:a05:6602:2b09:b0:841:a9d3:3b30 with SMTP id
 ca18e2360f4ac-8447e200cdfmr220917439f.1.1733452679302; 
 Thu, 05 Dec 2024 18:37:59 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861f51bfsm575506173.112.2024.12.05.18.37.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 18:37:57 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v3 33/46] pxe: Allow skipping the boot
Date: Thu,  5 Dec 2024 19:36:12 -0700
Message-Id: <20241206023626.2456858-34-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206023626.2456858-1-sjg@chromium.org>
References: <20241206023626.2456858-1-sjg@chromium.org>
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

Provide a way to skip booting the OS and just return. This will allow
bootstd to read out useful information.

Add debugging to help figure out the flow.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/pxe_utils.c    | 12 ++++++++++--
 include/pxe_utils.h |  4 +++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index f7bbc1527af..3531ab1c71a 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -782,6 +782,9 @@ static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 		printf("append: %s\n", finalbootargs);
 	}
 
+	if (ctx->no_boot)
+		return 0;
+
 	label_run_boot(ctx, label, kernel_addr, initrd_addr_str,
 		       initrd_filesize, initrd_str);
 	/* ignore the error value since we are going to fail anyway */
@@ -1566,11 +1569,15 @@ static void boot_unattempted_labels(struct pxe_context *ctx,
 	struct list_head *pos;
 	struct pxe_label *label;
 
+	log_debug("Booting unattempted labels\n");
 	list_for_each(pos, &cfg->labels) {
 		label = list_entry(pos, struct pxe_label, list);
 
-		if (!label->attempted)
-			label_boot(ctx, label);
+		if (!label->attempted) {
+			log_debug("attempt: %s\n", label->name);
+			if (!label_boot(ctx, label))
+				return;
+		}
 	}
 }
 
@@ -1621,6 +1628,7 @@ void handle_pxe_menu(struct pxe_context *ctx, struct pxe_menu *cfg)
 
 	if (err == 1) {
 		err = label_boot(ctx, choice);
+		log_debug("label_boot() returns %d\n", err);
 		if (!err)
 			return;
 	} else if (err != -ENOENT) {
diff --git a/include/pxe_utils.h b/include/pxe_utils.h
index e8e03430a81..beadd221475 100644
--- a/include/pxe_utils.h
+++ b/include/pxe_utils.h
@@ -109,7 +109,8 @@ typedef int (*pxe_getfile_func)(struct pxe_context *ctx, const char *file_path,
  * @use_ipv6: TRUE : use IPv6 addressing, FALSE : use IPv4 addressing
  * @use_fallback: TRUE : use "fallback" option as default, FALSE : use
  *	"default" option as default
- * @bflow: Bootflow being booted, or NULL if none
+ * @no_boot: Stop show of actually booting and just return
+ * @bflow: Bootflow being booted, or NULL if none (must be valid if @no_boot)
  */
 struct pxe_context {
 	/**
@@ -130,6 +131,7 @@ struct pxe_context {
 	ulong pxe_file_size;
 	bool use_ipv6;
 	bool use_fallback;
+	bool no_boot;
 	struct bootflow *bflow;
 };
 
-- 
2.34.1

