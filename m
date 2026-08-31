Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A44C624C6
	for <u-boot@archiver.kernel.org>; Mon, 31 Aug 2026 15:57:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F399680BBD;
	Mon, 31 Aug 2026 15:57:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nQsE4bewaRPt; Mon, 31 Aug 2026 15:57:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788191865;
	bh=gATDeTdmIzqpQW07QUg7qSjtMFpctnhc7u+ZQEdemCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vgE3zT2t79BqywUHrHjeEpvB4ja6HH7vNwbTgeDwH6qHLnBkv9rnUOkw6a+vWVajv
	 ndQxEnq2PiHNMwVtYwa27JwAhYuCZdf9XLnjS2xcjQgQ+RpIpqv7O4YoxWwCBjM1mL
	 PlvTHkGrVQSsJu5WegiKJAA1u2gz/CZK1QWYEDRtX570xfR9f1WQK6QDpTdGAajScv
	 VotZjqVXHl8LULNxrl2suldO4b9/hRUCsSN+RVgBJaUrOd22e3vYnnetm6Ei3kw7h6
	 QxEdmsuCaV0cbW34BVU1odNDiNU4VQj37EBLAgBNkvSsy9pIP8Oj6TyC9by6al3iNZ
	 lT8yUPbVku5dw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D633480D17;
	Mon, 31 Aug 2026 15:57:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8B8AC23E
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 14:28:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 71D9B8086C
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 14:28:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OA492hUQp3fs for <u-boot@lists.u-boot-project.org>;
 Mon, 31 Aug 2026 14:28:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=aN43+yzW
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B664A80B1B
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 14:28:32 +0000 (UTC)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 343633F618
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 14:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1788186511;
 bh=gATDeTdmIzqpQW07QUg7qSjtMFpctnhc7u+ZQEdemCo=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=aN43+yzWDhmgyYwrlMZ5+iwfneQuSm4V5mjBWw4fBs0oqVbVsmGswMng9l8iGfjtP
 BM3mGju4WVlhDqB5UnHhNKClpEK4lMFY7Xs1PYqpi5e3qJ94LDd9exVMS7tjLKtlun
 B+gPXu8Qaj9lgO4eyPx3+r0/5H8StepWp0gTQ546gNdDmTB3PoUyavFT92JK4ZHVHM
 qnJOMWz9Fphi9k8sADaRAAGyMChaGALXmxQXxckFrnrJouhmPahq9Lbpju83nYq+tv
 oyiAId2/25qumW1Hb28s5nU3vqGhuuRLRPQqPIa+RIZvanQ0LLD2lbyH24q7gHe1qB
 06lsBhHUUSajYaOpOQFjk0BjDG8g89B72kbFToE2RxtnRB248IV9D0uvjqlIlHmQwP
 yF/+0RXNoQ18oZSvCQAW9ixXPYBGiUK2Fse/Q5eaF8x1sRJcb7vZQumGg+yarHb8iF
 pLkDJS6g1RkTX6YkbC542yH2ildVnPndr9DCQSO29WGeqaTyq8iKuRSzYQo/H7vDKv
 Jb6boStseVMTm28t+5/i2QoTBtlkifCKAWIIunhLYrnSMyrnLgEaeHx0+t+SN7iE6C
 bcMhu9uDIvR2E0gQpwZUv1wl9AgvOkKGV19Y4is19Y8FHg92uwclXm7xqYbzjUHlKX
 BJqTXPgMd+f8qQjj1RwWRMvw=
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d932ef41c4so12366375ad.0
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 07:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788186509; x=1788791309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gATDeTdmIzqpQW07QUg7qSjtMFpctnhc7u+ZQEdemCo=;
 b=gjDeG7jN9Zq2WzXx5ucZ4CzAUP7tkR/IgCCO95WcpnnpT0YdCci0o8fjPXjxjDrs7n
 PxEJ8eUyUxNuYtV89VnBIj3FgG8Ssk4AXIr4wlyHHbEIo5Y0kBu/Hr46PsxqExDYxbsF
 qyW8EpWYF/eAwjHOTkBGqEadScd2Qr8RjmfDOS0ZWpzz2kMzkQnLs1+ekuKSmKozaZDV
 KirKrHrnrGr4uUFv5VLvEM/AIXDcckyKJfdEVLYZEvVRfvXZCrW4IEC645VH8AFwUoVJ
 oQkpCEhngdquSJarCZBsNJ23EOmR63I4fDyr8wkt0Mn4v8a/2+7X783lfrOIjyZ7u7B2
 SX4w==
X-Gm-Message-State: AFuF++lqe7n7pACukYc1x6oNYtoQxewZAZp44Zzj8vsqAtMk0E9uhNy1
 B+4qNnlQcSbuHkYAcHQQftBmoKGSx0aZl/hRxLLXPKOKy+OfcUWvJdpxyvc9VWIabROF1p5Zh8d
 PEDvlBWcnkXmCsXmC36dqQZFWIKLU2JCzxpkf8KQOXvf8A33ZWKYW2wVrdXuCubpbyuRXq0N52C
 bkO5X3J0oYK94FkHyniQ==
X-Gm-Gg: AYBFou0F4IDh7/ZjJb8tzk4aWDSUbjnywDCSDjj14tveQvqB0jZIn2Y1u9neQ1VLnU1
 Hqh2ZoR7vLPGsSrkseJ5KeXVly35j3S4c4YuGbKxKQ5ZRzpiPjO+M0QJOhByDgXbEQrvXy52ASq
 qsbNIPbKtLY403Pxa85958ERUgUKDa20LrwVhoEiRxWw62gdjP+SGD0GnYNCuoXKIBawwzkfvVX
 YpGmsIR5SCg5e+tZAMeXoasagH8SPU0XFN1fUxIy+zcvER15bCStrchYHUpsq4s//KJ2+v0Wu0C
 UhJROanqwkp0boVD+atYQgZpxe7JJPNx+Xr1ev8Fe0oaG2U+6ibnhN8pR53lMaY7hAma0DZSfy0
 rl4oIU4if7hAnSvVF4WTrj2wxy4R7ARIiPgFv99dnM+8ha2Q=
X-Received: by 2002:a17:902:e949:b0:2d6:dcf3:b754 with SMTP id
 d9443c01a7336-2d91afa062bmr74089955ad.7.1788186509505; 
 Mon, 31 Aug 2026 07:28:29 -0700 (PDT)
X-Received: by 2002:a17:902:e949:b0:2d6:dcf3:b754 with SMTP id
 d9443c01a7336-2d91afa062bmr74089665ad.7.1788186509121; 
 Mon, 31 Aug 2026 07:28:29 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d8ffb0d341sm22798805ad.47.2026.08.31.07.28.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 07:28:28 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Martin Schwan <m.schwan@phytec.de>, Denis Mukhin <dmukhin@ford.com>,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH 1/2] bootstd: rauc: Reject slot names that do not fit the
 env-var name buffer
Date: Mon, 31 Aug 2026 14:25:39 +0000
Message-ID: <20260831142800.25966-2-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831142800.25966-1-aristo.chen@canonical.com>
References: <20260831142800.25966-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 31 Aug 2026 15:57:41 +0000
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

The names of the "BOOT_<slot>_LEFT" environment variables are built with
sprintf() into fixed 42-byte stack buffers, and the "rauc.slot=<slot>"
kernel argument into a 64-byte one. The slot names come from the
BOOT_ORDER environment variable in find_active_slot() and
distro_rauc_boot(), and from CONFIG_BOOTMETH_RAUC_BOOT_ORDER in
distro_rauc_read_bootflow() and the reset-all-tries path. Nothing limits
their length, so a slot name longer than 32 characters writes past the
end of the buffer, and even a 32-character one overflows it by the NUL
terminator.

The BOOT_ORDER entries are checked against the configured slots when the
bootflow is scanned, but the variable is read again when the bootflow is
booted, so changing it in between (e.g. from the command line) reaches
the unchecked sprintf() calls.

Build the variable names through a small helper that uses snprintf() and
rejects slot names which do not fit, size the buffer for a 32-character
slot name plus NUL, and use snprintf() for the kernel argument as well.
Its slot name has passed the same check by then, so it always fits.

Fixes: 7e5c2c782fb9 ("bootstd: Add implementation for bootmeth rauc")
Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 boot/bootmeth_rauc.c | 42 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
index 844df7576bb..123ec913cb5 100644
--- a/boot/bootmeth_rauc.c
+++ b/boot/bootmeth_rauc.c
@@ -22,8 +22,8 @@
 #include <linux/stringify.h>
 #include <asm/cache.h>
 
-/* Length of env var "BOOT_*_LEFT" */
-#define BOOT_LEFT_LEN	(5 + 32 + 5)
+/* Size of the name of env var "BOOT_<slot>_LEFT", for a 32-char slot name */
+#define BOOT_LEFT_LEN	(5 + 32 + 5 + 1)
 
 static const char * const script_names[] = { "boot.scr", "boot.scr.uimg", NULL };
 
@@ -79,6 +79,21 @@ static struct distro_rauc_slot *get_slot(struct distro_rauc_priv *priv,
 	return NULL;
 }
 
+/**
+ * boot_left_name() - Build the name of the "BOOT_<slot>_LEFT" env var
+ *
+ * @buf: Buffer of BOOT_LEFT_LEN bytes to write the name to
+ * @slot: Name of the slot
+ * Return: 0 if OK, -ENAMETOOLONG if @slot does not fit
+ */
+static int boot_left_name(char *buf, const char *slot)
+{
+	if (snprintf(buf, BOOT_LEFT_LEN, "BOOT_%s_LEFT", slot) >= BOOT_LEFT_LEN)
+		return -ENAMETOOLONG;
+
+	return 0;
+}
+
 static int distro_rauc_check(struct udevice *dev, struct bootflow_iter *iter)
 {
 	/*
@@ -167,7 +182,11 @@ static int distro_rauc_read_bootflow(struct udevice *dev, struct bootflow *bflow
 	default_boot_order = CONFIG_BOOTMETH_RAUC_BOOT_ORDER;
 	default_boot_order_list = str_to_list(default_boot_order);
 	for (i = 0; default_boot_order_list[i]; i++) {
-		sprintf(boot_left, "BOOT_%s_LEFT", default_boot_order_list[i]);
+		ret = boot_left_name(boot_left, default_boot_order_list[i]);
+		if (ret) {
+			str_free_list(default_boot_order_list);
+			return log_msg_ret("name", ret);
+		}
 		if (!env_get(boot_left)) {
 			log_debug("%s did not exist yet, setting default value\n",
 				  boot_left);
@@ -333,7 +352,11 @@ static int find_active_slot(char **slot_name, ulong *slot_tries)
 		return log_msg_ret("env", -ENOENT);
 	boot_order_list = str_to_list(boot_order);
 	for (i = 0; boot_order_list[i] && !slot_found; i++) {
-		sprintf(boot_left, "BOOT_%s_LEFT", boot_order_list[i]);
+		ret = boot_left_name(boot_left, boot_order_list[i]);
+		if (ret) {
+			str_free_list(boot_order_list);
+			return log_msg_ret("name", ret);
+		}
 		tries = env_get_ulong(boot_left, 10, ULONG_MAX);
 		if (tries == ULONG_MAX) {
 			str_free_list(boot_order_list);
@@ -359,7 +382,11 @@ static int find_active_slot(char **slot_name, ulong *slot_tries)
 			log_info("INFO: Resetting all slot tries to " __stringify(CONFIG_BOOTMETH_RAUC_DEFAULT_TRIES) "\n");
 			boot_order_list = str_to_list(CONFIG_BOOTMETH_RAUC_BOOT_ORDER);
 			for (i = 0; boot_order_list[i]; i++) {
-				sprintf(boot_left, "BOOT_%s_LEFT", boot_order_list[i]);
+				ret = boot_left_name(boot_left, boot_order_list[i]);
+				if (ret) {
+					str_free_list(boot_order_list);
+					return log_msg_ret("name", ret);
+				}
 				ret = env_set_ulong(boot_left, CONFIG_BOOTMETH_RAUC_DEFAULT_TRIES);
 				if (ret) {
 					str_free_list(boot_order_list);
@@ -416,7 +443,7 @@ static int distro_rauc_boot(struct udevice *dev, struct bootflow *bflow)
 		return log_msg_ret("env", ret);
 
 	/* Kernel command line arguments */
-	sprintf(raucargs, "rauc.slot=%s", active_slot);
+	snprintf(raucargs, sizeof(raucargs), "rauc.slot=%s", active_slot);
 	ret = env_set("raucargs", raucargs);
 	if (ret)
 		return log_msg_ret("env", ret);
@@ -454,7 +481,8 @@ static int distro_rauc_boot(struct udevice *dev, struct bootflow *bflow)
 	log_debug("BOOT_ORDER: %s\n", boot_order);
 	boot_order_list = str_to_list(boot_order);
 	for (i = 0; boot_order_list[i]; i++) {
-		sprintf(boot_left, "BOOT_%s_LEFT", boot_order_list[i]);
+		if (boot_left_name(boot_left, boot_order_list[i]))
+			continue;
 		log_debug("%s: %s\n", boot_left, env_get(boot_left));
 	}
 	str_free_list(boot_order_list);
-- 
2.43.0

