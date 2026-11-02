Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE006070CBB
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 16:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PC3YJprj;
	dkim=pass (2048-bit key, unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail header.b=jHqckxfW
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BBD0E810CE;
	Mon,  2 Nov 2026 16:21:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6vY3xWUWvYyF; Mon,  2 Nov 2026 16:21:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C837A81111
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793636462;
	b=ENAwcaMpbo1URcE0jzK6F7VuL6wP4rxx/lytLt5Em2IDVSe8DLhxzfZsBHQ4g+8gjEKb
	 3cUqwF2JrSHufslDjHXmuM3R2dAkysQUrAkAmYhO3xhplxZ2ngbcOoiZM1BmlSoEMsRAX
	 fKxBm2hiWMf5NxHSpnuqpR14rLyV1mavK0+sNbBpW+vrn++OCulMaaX5+XDpHbO6YrlEY
	 SLVXOrFCukzvCCkqI+scIpz4MTW8sBt2UKzaBDBcjQrbGwDsECZr97XCKCyIvn6b4L7fn
	 +MQFdbGFKcmWhZW0F5ZOfwG2qNEz0AMQpmaaW4rpi8uvG+latasycPNDCys+Vyp6jsw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793636462;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:From:
	 DKIM-Signature:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BurEPpQijW94WcEW9kcrkVB1meUQsZsw5Ntb8IY/l/Y=;
	b=RtqqUi3XBL2neIXGFmcDvfX1OKFyxanugo5vKNdmHpvv7cc26SiIuAaXhOpd1Ege4JQO
	 VrwTbWf7B0wuSzm6UPfa6ZahmDMekWjlKPm8DaJMuqudSgybo2/KXjtxlov+gaxmyguPQ
	 NQ6OJSs7XyVRn/gFelDz96DthZFc4Yde3SJk3JpnuhtFwm9LFawfNB8FuVs0KDSamNPjd
	 7TMqJdbmYHafA72A/QOzvp+wwN7cQVNDpHrnpos6SRmUbo5gI2F4uMzuF1eh11BYeVNBu
	 xz1qttSU+4+xYPtqHhb/VK7NK7UTO444EOShC0gG0BvrVMBu0Z/LjjpV3dCQX/TcnMg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793636462;
	bh=BurEPpQijW94WcEW9kcrkVB1meUQsZsw5Ntb8IY/l/Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PC3YJprj1e8nu0WNFIYw2578giE+cf0NNWlnqEC3/P3BjwQKGkPoiAYrPlyY/775O
	 1dL+jG665rTyDd/yFv9MDAkIdhNQxFDb9RZEUsh2xDQKEWZqzTMQ0LTFZKb2uy/ctK
	 10N0GmShJa2tV/ms/v0KPU6UoNv5tdPMbZO7cUPBCVG3ARQg1tZqlm5VFIkpcPVjmG
	 vvH10qM6YTvuokM/R1OSLVWZjrkqA5xb8oLvyJrT3sH8+2aYNVXsQ/qALP97gkk+wM
	 Lj59qDj+hexMgc0IoU4VVlXd7hVlGahDBIrDyS6wUJQ/XbJqMBTDGk44iRA6aFtt+d
	 Oos0QvkRhFvDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C837A81111;
	Mon,  2 Nov 2026 16:21:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9C807411
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:20:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 82C5D607EC
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:20:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W2abjY0c-2FQ for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 16:20:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 24AC96060D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=116.203.77.234
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793636452;
 b=aR1rm6OPpYOXIuMO1ao3jb1pTwceyqSSXqjcxJFhaAu9e0umhQGvspvtCNV4cCIT2zga
 7gREMSoFZKjVKlyZznvwAtZQ5PqUnLVGiz+wCLhSj+5ERG7urfUPMtQ/2mAUrSrHoF1jr
 2qhrp8OJzHNfVGMp00yPuo0NW8MxSqL97XUAzFiu9XD00G2KZQoOznQuxCXZCyG2CHjE8
 TU/oDqiR7Fe5twU4w39hImwo0G1+/PnggAx3pTsGLdnMZGCZAlgl2u2YhPM/RsaicUIZE
 VCIiMx1UrsN3t5SuqRaFl6GzgO4gKqYQMLxo2AnhUH1o5Dxd5k8l4a+7umhs5jIbCeQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793636452;
 h=Received-SPF:From:DKIM-Signature:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
 bh=BurEPpQijW94WcEW9kcrkVB1meUQsZsw5Ntb8IY/l/Y=;
 b=DQUf1lfi8+if7p90bdqYEkErty7D8KpIGcTL/cYzDbRFGoDxd08MDVIoplABd8b9Pq31
 +Zavt/CqWiegXiWuoLPcRuPzNDnB4PegQvtkxjRp1GySLl0mCtNtOUIhZQcU+4h+v62ph
 if2Q9sV4BWanveUjhicoAABVNCwuqhOy2yJZi2mqanNRK77h3qSwCK8X4u4eqxmctJgKz
 GpdWlPnKUyr+G0+T/kDh5k2TN7B7IxM+t+yMkYtC/AArdjO9nepuhVOgInDZRk3ImuOwt
 iTQsUgJj6owZywL4vhzQI1+el1RYazX3RHKNCVOgmCufEqifXKM4QFoMgf9KqZdS2kQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=fris.de;
 dkim=pass header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail
 header.b=jHqckxfW; 
 arc=none smtp.remote-ip=116.203.77.234
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.203.77.234;
 helo=mail.fris.de; envelope-from=frieder@fris.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256
 header.s=mail header.b=jHqckxfW
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 24AC96060D
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:20:50 +0000 (UTC)
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
 t=1793636448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BurEPpQijW94WcEW9kcrkVB1meUQsZsw5Ntb8IY/l/Y=;
 b=jHqckxfW+iLLR3bwGJydH5QqRjNtQI/pIPAg1IUyRZZXJ32S6d2356X5xI+tohPNtcwfAQ
 zISydWpLRQQTkcwOUTyXXhO2IO/5KhIEo2ITf9j4sIfVmgD3+FQkkZ88nrc1zeua6soxQ9
 qJAEorQWD9duwlm6PJBSIrAYXKndD+XTMgaz6ZiY4shQFPKAa7TpQuyj7KZsAEaUSjA25p
 4BuR2MEWCgY992CYA7jxnkoNX3LUR2sbstrgG0MIFwamMz7zB9HXKNMO+StePteyZ7cAGf
 RbcUtLA3xzr+3sxvobJJVHtqb3At60hYw560FHpqj88Cd+y2kFL07bOg76XCtw==
Date: Mon, 02 Nov 2026 17:20:20 +0100
Subject: [PATCH v2 03/12] bootstd: rauc: Fix overflow of the BOOT_x_LEFT
 name buffer
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-main-v2-3-4537bcb19d66@kontron.de>
References: <20261102-main-v2-0-4537bcb19d66@kontron.de>
In-Reply-To: <20261102-main-v2-0-4537bcb19d66@kontron.de>
To: Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Francesco Valla <francesco@valla.it>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5374;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=Oe+S5G6ld3JwlJbiAzOrgvl6Byr8UPsXQdbwWmUTyX4=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIevFjth/hyObudNvzL2ptaaKpfq0WUvohnPlu8pn3dfyc
 O5cGanWUcrCIMbFICumyCLFb/Ha1izWR/5YdRTMHFYmkCEMXJwCMBG9pQx/RdjynFdUqHbn3T9Y
 z/3Ss7k9csMV+wufllQxRB6vOVM/n5HhMNMCs5Ss5mTzX6mG1ro11/c8ajW3Ohm+rf2r9N8TU0S
 5AA==
X-Developer-Key: i=frieder.schrempf@kontron.de; a=openpgp;
 fpr=1A0F38EB3D365D4C1FC67B5A69761B25107C8216
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The name of the BOOT_x_LEFT variable of a slot is written into a stack
buffer of BOOT_LEFT_LEN bytes with sprintf(). BOOT_LEFT_LEN leaves room
for a slot name of 32 characters, but not for the terminating NUL, and
longer names are not limited at all.

When booting, the slot names come from BOOT_ORDER in the environment,
which is only checked against the configured slots when the bootflow is
read. Setting BOOT_ORDER to a long name between 'bootflow scan' and
'bootflow boot' therefore overflows the buffer in find_active_slot().

Make room for the NUL, and write the name with snprintf() in a helper
that fails with -E2BIG if it does not fit.

A slot name in CONFIG_BOOTMETH_RAUC_BOOT_ORDER that is too long is a
configuration error, which would otherwise only make the bootmeth fail
silently. Print an error for it and document the limit in the help of
the option.

Fixes: 7e5c2c782fb9 ("bootstd: Add implementation for bootmeth rauc")
Assisted-by: LLM
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes in v2:
- Print an error for a too long slot name in
  CONFIG_BOOTMETH_RAUC_BOOT_ORDER (Simon)
- Document the 32-character limit in the Kconfig help (Simon)
- Pass on the return value of boot_left_name() (Simon)
- Rebase on the changes in patch 2
---
 boot/Kconfig         |  1 +
 boot/bootmeth_rauc.c | 37 ++++++++++++++++++++++++++++++-------
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 8fcdc36c931..d4d2a77f15a 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -958,6 +958,7 @@ config BOOTMETH_RAUC_BOOT_ORDER
 	  Sets the default boot order. This must be list of space-separated
 	  strings naming the individual boot slots. Each entry in this string
 	  should correspond to an existing slot on the target's flash device.
+	  Slot names can be at most 32 characters long.
 
 config BOOTMETH_RAUC_PARTITIONS
 	string "RAUC boot and root partitions indexes"
diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
index 7273156c4dd..32e1de886cc 100644
--- a/boot/bootmeth_rauc.c
+++ b/boot/bootmeth_rauc.c
@@ -23,8 +23,8 @@
 #include <linux/stringify.h>
 #include <asm/cache.h>
 
-/* Length of env var "BOOT_*_LEFT" */
-#define BOOT_LEFT_LEN	(5 + 32 + 5)
+/* Length of env var "BOOT_*_LEFT", including the terminating NUL */
+#define BOOT_LEFT_LEN	(5 + 32 + 5 + 1)
 
 static const char * const script_names[] = { "boot.scr", "boot.scr.uimg", NULL };
 
@@ -67,6 +67,15 @@ static void distro_rauc_priv_free(struct distro_rauc_priv *priv)
 	free(priv);
 }
 
+static int boot_left_name(char *buf, const char *slot_name)
+{
+	if (snprintf(buf, BOOT_LEFT_LEN, "BOOT_%s_LEFT", slot_name) >=
+	    BOOT_LEFT_LEN)
+		return log_msg_ret("name", -E2BIG);
+
+	return 0;
+}
+
 static struct distro_rauc_slot *get_slot(struct distro_rauc_priv *priv,
 					 const char *slot_name)
 {
@@ -168,7 +177,13 @@ static int distro_rauc_read_bootflow(struct udevice *dev, struct bootflow *bflow
 	default_boot_order = CONFIG_BOOTMETH_RAUC_BOOT_ORDER;
 	default_boot_order_list = str_to_list(default_boot_order);
 	for (i = 0; default_boot_order_list[i]; i++) {
-		sprintf(boot_left, "BOOT_%s_LEFT", default_boot_order_list[i]);
+		ret = boot_left_name(boot_left, default_boot_order_list[i]);
+		if (ret) {
+			log_err("ERROR: Slot name %s is too long\n",
+				default_boot_order_list[i]);
+			str_free_list(default_boot_order_list);
+			return ret;
+		}
 		if (!env_get(boot_left)) {
 			log_debug("%s did not exist yet, setting default value\n",
 				  boot_left);
@@ -335,7 +350,11 @@ static const struct distro_rauc_slot *find_active_slot(struct distro_rauc_priv *
 		return ERR_PTR(log_msg_ret("env", -ENOENT));
 	boot_order_list = str_to_list(boot_order);
 	for (i = 0; boot_order_list[i] && !slot; i++) {
-		sprintf(boot_left, "BOOT_%s_LEFT", boot_order_list[i]);
+		ret = boot_left_name(boot_left, boot_order_list[i]);
+		if (ret) {
+			str_free_list(boot_order_list);
+			return ERR_PTR(ret);
+		}
 		tries = env_get_ulong(boot_left, 10, ULONG_MAX);
 		if (tries == ULONG_MAX) {
 			str_free_list(boot_order_list);
@@ -364,7 +383,11 @@ static const struct distro_rauc_slot *find_active_slot(struct distro_rauc_priv *
 			log_info("INFO: Resetting all slot tries to " __stringify(CONFIG_BOOTMETH_RAUC_DEFAULT_TRIES) "\n");
 			boot_order_list = str_to_list(CONFIG_BOOTMETH_RAUC_BOOT_ORDER);
 			for (i = 0; boot_order_list[i]; i++) {
-				sprintf(boot_left, "BOOT_%s_LEFT", boot_order_list[i]);
+				ret = boot_left_name(boot_left, boot_order_list[i]);
+				if (ret) {
+					str_free_list(boot_order_list);
+					return ERR_PTR(ret);
+				}
 				ret = env_set_ulong(boot_left, CONFIG_BOOTMETH_RAUC_DEFAULT_TRIES);
 				if (ret) {
 					str_free_list(boot_order_list);
@@ -453,8 +476,8 @@ static int distro_rauc_boot(struct udevice *dev, struct bootflow *bflow)
 	log_debug("BOOT_ORDER: %s\n", boot_order);
 	boot_order_list = str_to_list(boot_order);
 	for (i = 0; boot_order_list[i]; i++) {
-		sprintf(boot_left, "BOOT_%s_LEFT", boot_order_list[i]);
-		log_debug("%s: %s\n", boot_left, env_get(boot_left));
+		if (!boot_left_name(boot_left, boot_order_list[i]))
+			log_debug("%s: %s\n", boot_left, env_get(boot_left));
 	}
 	str_free_list(boot_order_list);
 

-- 
2.56.0

