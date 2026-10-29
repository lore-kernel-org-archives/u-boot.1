Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F13606A31D
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 16:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JIApIj/G;
	dkim=pass (2048-bit key, unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail header.b=t0GsNW4t
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E7D538100B;
	Thu, 29 Oct 2026 16:23:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bZ3aaB3in4_6; Thu, 29 Oct 2026 16:23:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2C5878104B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793291020;
	b=nSJg4UIMJyQeFRnM9tWOb//Jrnxf8hDC2iKGSMMi27XKuO67i3vIV/zs5NoBvL3C35SB
	 iLDSHoRSDJL+9ZHX7UkWU+E5ZV9G+qbz16bhWSv17Wno08q44BnTpRcLVkTRe9eAQiv6W
	 wNrDBI76s+vD1pz70Cguh/XwwbCGRrEgEOWR0fgqUmTHjW3SAh9GU5RFWxuxrx3pVtv38
	 U75uysmQrMKO3fRKVF1DlKkk7xUUBxEjvezgRR1se+TwLmwqjP5tgKh2tBIbhs6zo8aht
	 c4UUsvZxEqrPWtaaF074xideAHEbyTi5UqSTllvnHv4l/PDZiNkKaf1zt5sx+tJwolw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793291020;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:From:
	 DKIM-Signature:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6idwbF5iGlNwncZDmLY55PYdnJEnrWX04Na/UBUMQ2E=;
	b=bjpSeX6pfM0E3e2Tnh/GLgmw8ugvyOMhEgc0NBpibOcpCdFC/obCT1DOLA5OkFQ1be8i
	 suprbUyz8RH7znbXij3HwzJ5XMWGsPp7SuiT8UsWY/FSwNkgkNibY6r8n39BaHCNtqEMH
	 DooKaMqUmkdaRufjSauV+pAH5EfICQr2Z/3L83ErI6d5xh0i38HUTV0b6T80cMxUTrSEZ
	 mwKewahCZVGq7VpbCJ18d/7eKZFO0lwIv98eGDqx7GXEDLK2yDFXIgRDf5Lxhpu6V9VUM
	 mNKHCgdJZLy6PphgIjjSrG3jCagKM5RHPLseGn4lMk3wabJFgzucSV41ql/P8M2e4WA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793291020;
	bh=6idwbF5iGlNwncZDmLY55PYdnJEnrWX04Na/UBUMQ2E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JIApIj/GjuquzIb769zjqpMiKFkV8zNe1ZCiQyhYIwF/Otf9i8Enfw6wFdVz4rjM0
	 eUQ3gxJtJPy43w9ye6Z+UibOXoI1jFqJ8O2yiYWSQ5f5Q1VGZ7lTHSiv5g+AvVzrI1
	 0pW88WYFIikZFq/6aHwZf/G2YRwyp70JrCegcHwiuevkidp0+PGIl6h6gYOHohzYRR
	 0s5r8aT3erHJvEjr/33Q/5d1xrRDBNhFnmDeSQ4XZ099aU7ilklKYtalRF3qslYo04
	 U7q9DKc8uF3SwtdCON8T6vnsqcomEorGRJRJCfus6Yd6pXGzDAUyorGyEjFjZtKzA5
	 HR2h1de8uoGdw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C5878104B;
	Thu, 29 Oct 2026 16:23:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E82162E5
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:23:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DA7FA40012
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:23:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hgVr0MTB-bdV for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 16:23:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org ED8B04008A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=116.203.77.234
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793291010;
 b=WXlDKEeAr35s0dFBoZqPhlsL1KsydyZuT6IQiBDig+NbNEPWVBdqUQuWo4FRM9Il7NHE
 iOlOtqh6M0ub5LBR0BAa0sUGluX/TBfen0pOlYcPztiizOHL6E3hrRLjijzHdMP4Nkq4Y
 vgCOZ1d0GGwMM0FP/Y2j0Em0OBshRK7zIVCMwT9dt01qXO0Pc0EFGqm8ZpOHu6ALFNPit
 c/Qqxslz/+NW33OQiJi3xjkjw5b4lLdFKBRKPe6x5YsGhjwUgZJsx9WfqYO6Ot7rDHEhJ
 B0f7+PAYAYvSD5uLF1rf33ua2gbFR9jSRH6wC84ZM0ndw2WsdmRYnBtJdpQLvmHAIJw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793291010;
 h=Received-SPF:From:DKIM-Signature:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
 bh=6idwbF5iGlNwncZDmLY55PYdnJEnrWX04Na/UBUMQ2E=;
 b=WJHFBK33jH0NJlg2hCyfP2X+qjGPTCkUV31xHziShw8j44ctD4dGAkbwO0r1+ZmuNzCo
 BD9lgVhcPBhECaP5HADT+4JzGDyZKnGvxF7eCQsl0LXynW6GEvC54ugvc5Zv7qOkZEEJK
 gggZtdJBP2scVwCzCvE+5ERn+8oxIiDDnnhOAi21DaVkXJ8aFhykP6qGHQdz5p0FkHO/1
 rqWV0R2R72FuipCV6kZkjjVDtidJwlstiAJXCrtxGZUiOn8FTJPTSPouAHnR8qZLqC3kB
 Tehk5316rkRAVenbajX7D9JgVDW0CsS2szp08+O+U3Uai5qcxJajmYDfu+xOXpDtitA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=fris.de;
 dkim=pass header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail
 header.b=t0GsNW4t; 
 arc=none smtp.remote-ip=116.203.77.234
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.203.77.234;
 helo=mail.fris.de; envelope-from=frieder@fris.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de
 header.a=rsa-sha256 header.s=mail header.b=t0GsNW4t
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ED8B04008A
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:23:27 +0000 (UTC)
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
 t=1793291005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6idwbF5iGlNwncZDmLY55PYdnJEnrWX04Na/UBUMQ2E=;
 b=t0GsNW4tLbmkRKUPCvnU98iN5TznutTMx2YKhzZ25uVk0hEXa96GWvAtoXhfnuzBqRCk0A
 +vNGhdvUrgYmYvErntK0AG6JJ2KZCj8u0HJjPYpyhGpj2WxShzyRJVoJAnMoxO8u3at5BT
 If2oqEz3w6bzyID4Omd0nsrzw0sOoACt+GCiqvbTuEK1DEDcC8UudaesJmoM7SriXhkKXD
 YBENdo4hyjQPS8gH4E42JK2FrX5x5L1W4qpFp+CQh3FzXFevAX9gqENtcxHiD7zgJJO7+f
 NK90GMpUeXDKUQOWShApZkbvMd7HKXsXvcwqYocaFkIV4MCuz6YHTXbaDjtNgg==
Date: Thu, 29 Oct 2026 17:23:09 +0100
Subject: [PATCH 03/10] bootstd: rauc: Fix overflow of the BOOT_x_LEFT name
 buffer
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-main-v1-3-b5a878627107@kontron.de>
References: <20261029-main-v1-0-b5a878627107@kontron.de>
In-Reply-To: <20261029-main-v1-0-b5a878627107@kontron.de>
To: Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>, 
 Johan Jonker <jbx6244@gmail.com>, Francesco Valla <francesco@valla.it>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4188;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=25u474FIkCNJuOz1FsMqGW4R78ZYoG5bNjrPtSFiPpc=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIetx0a/kY5Olq9hsb3sHbnYr8eK8MrukXrrPaWOJtuaGq
 85b9Pd1lLIwiHExyIopskjxW7y2NYv1kT9WHQUzh5UJZAgDF6cATKS5hOGfuatN+qr1HifTTqrd
 Upww19QhJCF986+fsmvL9Ne9Oj8xkuGfxaxLLdd1DpwRDX2QF/Bpp+TCSYqrTudnZOZarNZkvLm
 LCQA=
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
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

Fixes: 7e5c2c782fb9 ("bootstd: Add implementation for bootmeth rauc")
Assisted-by: LLM
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 boot/bootmeth_rauc.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
index 3442b9e99d4..fc073aadd21 100644
--- a/boot/bootmeth_rauc.c
+++ b/boot/bootmeth_rauc.c
@@ -22,8 +22,8 @@
 #include <linux/stringify.h>
 #include <asm/cache.h>
 
-/* Length of env var "BOOT_*_LEFT" */
-#define BOOT_LEFT_LEN	(5 + 32 + 5)
+/* Length of env var "BOOT_*_LEFT", including the terminating NUL */
+#define BOOT_LEFT_LEN	(5 + 32 + 5 + 1)
 
 static const char * const script_names[] = { "boot.scr", "boot.scr.uimg", NULL };
 
@@ -66,6 +66,15 @@ static void distro_rauc_priv_free(struct distro_rauc_priv *priv)
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
@@ -167,7 +176,10 @@ static int distro_rauc_read_bootflow(struct udevice *dev, struct bootflow *bflow
 	default_boot_order = CONFIG_BOOTMETH_RAUC_BOOT_ORDER;
 	default_boot_order_list = str_to_list(default_boot_order);
 	for (i = 0; default_boot_order_list[i]; i++) {
-		sprintf(boot_left, "BOOT_%s_LEFT", default_boot_order_list[i]);
+		if (boot_left_name(boot_left, default_boot_order_list[i])) {
+			str_free_list(default_boot_order_list);
+			return log_msg_ret("env", -E2BIG);
+		}
 		if (!env_get(boot_left)) {
 			log_debug("%s did not exist yet, setting default value\n",
 				  boot_left);
@@ -333,7 +345,11 @@ static int find_active_slot(char **slot_name, ulong *slot_tries)
 		return log_msg_ret("env", -ENOENT);
 	boot_order_list = str_to_list(boot_order);
 	for (i = 0; boot_order_list[i] && !slot_found; i++) {
-		sprintf(boot_left, "BOOT_%s_LEFT", boot_order_list[i]);
+		ret = boot_left_name(boot_left, boot_order_list[i]);
+		if (ret) {
+			str_free_list(boot_order_list);
+			return ret;
+		}
 		tries = env_get_ulong(boot_left, 10, ULONG_MAX);
 		if (tries == ULONG_MAX) {
 			str_free_list(boot_order_list);
@@ -363,7 +379,11 @@ static int find_active_slot(char **slot_name, ulong *slot_tries)
 			log_info("INFO: Resetting all slot tries to " __stringify(CONFIG_BOOTMETH_RAUC_DEFAULT_TRIES) "\n");
 			boot_order_list = str_to_list(CONFIG_BOOTMETH_RAUC_BOOT_ORDER);
 			for (i = 0; boot_order_list[i]; i++) {
-				sprintf(boot_left, "BOOT_%s_LEFT", boot_order_list[i]);
+				ret = boot_left_name(boot_left, boot_order_list[i]);
+				if (ret) {
+					str_free_list(boot_order_list);
+					return ret;
+				}
 				ret = env_set_ulong(boot_left, CONFIG_BOOTMETH_RAUC_DEFAULT_TRIES);
 				if (ret) {
 					str_free_list(boot_order_list);
@@ -459,8 +479,8 @@ static int distro_rauc_boot(struct udevice *dev, struct bootflow *bflow)
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

