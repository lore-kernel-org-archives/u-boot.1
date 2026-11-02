Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EE4606ABA6
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 16:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Jb4fcFvA;
	dkim=pass (2048-bit key, unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail header.b=iaFVIMdK
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BEEE281197;
	Mon,  2 Nov 2026 16:21:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tvd4DLbxMqFm; Mon,  2 Nov 2026 16:21:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6696C81154
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793636476;
	b=AT0k/LxvyHuAdjIsYwAuGPJCTZJRThNoOiGbFj/IZ7MjAhQmVZpZjg3tuOcL5zhiZK2k
	 q+aozb85Km1l9TJOg92dzLKgin9ZbFLFF4OL++KkC9SVlcwo7c3MyLOLpKbf8By38j0bS
	 OO1YfVnmBh4NBxXF8X3tJ0LEGR7YuLUVgMWWrdAACWsVWwj6oWPNmEIjLnIMw1YwLCFrp
	 8Hnyc1+PS8yH3LRwTDfuJceMF46J6u1WyhVypq7TiG9gpxjtegVuJIVfRtcJALLHs52f4
	 uLnzeMcF2BNkaZX9eya9Rk2rhX+bUP9MRgAs/pQuSMzjJFhHbt0RcQVlfSqroPS3X4g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793636476;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:From:
	 DKIM-Signature:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uIuD1MQ7ho09IWfqJC5fLmzB/Z6wGHWKwdTSqfBJX/A=;
	b=ADE0X2S+nsOxU00NGOShF6LyevxLXn6kubJdAikTC/KDCT8xix8pzfO98iPOb/scusJP
	 STF8W4qios09W+fV/yUv5jQ9xhFu9sR0666PgOzv02KfwVu/gZuvemybIcCoJusLG80Tg
	 dCcIYzAvQkXKuFr37uIrB+l3eZ6ifAFkISsLIGoGVBEE5JJE1eJkzfQjH/BFcLgdCyAcq
	 AQkucEf30PY2rJ2raVW92vEU59ePik6+pbkggVk8C/6PUy04K03ChGfs8yloE419jEmbG
	 0qRltUp4j3NszLYIowhD/IG4yolXC+qPN+m8KuryaFtasRh54D61mVapYUkj+kTJ34A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793636476;
	bh=uIuD1MQ7ho09IWfqJC5fLmzB/Z6wGHWKwdTSqfBJX/A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Jb4fcFvANzOo9xLnbhVrYUVTxW0UWeIdtxP44kekIU2lVof2NO/bx4ww0O1dn9965
	 5S5f9Z183K0gK9kxLHP075fUZ836zIefuQ9dY7RctzyYdS8+g5fuiCAvv2TOue4bn9
	 o31OFPQxE+5F8rIlaR0yndXFzzVmG5FuKIShIi2cKM3n79pQwmVda6B84zsPhrwvIZ
	 IlfOJDOueAZU1OmX2cLQ8g9lCeV3kpHN+KtnTVMIgBWcB5T4jwd2+mRPyFdQXiarQG
	 ap6m2cf947rgG6y7UjVJh4CJbn+RFr5qJlRS52so2GdkJkO3bFrdldTNd9gsIoSqOC
	 M05d0Gno/tlTg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6696C81154;
	Mon,  2 Nov 2026 16:21:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 49B5C2A8
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:20:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2D7034009E
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:20:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yGf_U2yoLPxk for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 16:20:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 593824007E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=116.203.77.234
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793636455;
 b=A9uovNemlmebL5h10pulYCw2NBDQnD1FnA2K6z3g5OCa/5bKSSOgdwjCnTHSJYiqiXAR
 /N2dH19CHD6JrzKhgf9Kx6O+jn0RtU5EryXGnuLMlckXEJY3JRWICGEr2fdyg4N6Bw5B7
 jMv2QaoJA8NK3hoYkVRkxLsTXfCxmup9NTtRSdW3qtu6jUde2PdSVlxZP72WrTYzfNVRi
 +sRIEkhWlv3BBqTlfuIDDeLKOPMoH5kBHfvTSzi/HRoRhlE2QFAEUWTPBG/WA2ao+/C54
 v3P5Q9KE1xeU3Z/h0AiQKHu/n5S/uJYX0eSdTwiND53E3r1bY7Q4dGrSlScda1mkWmA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793636455;
 h=Received-SPF:From:DKIM-Signature:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
 bh=uIuD1MQ7ho09IWfqJC5fLmzB/Z6wGHWKwdTSqfBJX/A=;
 b=P00O9ZgV692XNm79TOvSsIQCKuHg2RrxrUCTOTg+ct4S98ZjI8jraU730LRyyVNYO5ut
 h/r4DSs8fpqXtktoIngthRn8uufraCZoEfsGuQ8rAzk0nNn/GjvIx3fW4Wuvr2PNYG1FP
 m7iJ6jRxhngEKHVWFCuPNztSqoDQNH03+QT1WiGR5ZTaJXTqGX5rZjcrGOdemQagqNYKE
 tY++PWUk9eQvxgv6FYDaKbAdjvZF5zKLn8VoLjgr8DqfZbxF4XicrXq36Qg+Z2OX89BI8
 CskMlLBtINOyWN6A+9jHNx+Eh9flqvrFtusSv4dYa52frMxOU85GJL8+xOfcErpd2dA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=fris.de;
 dkim=pass header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail
 header.b=iaFVIMdK; 
 arc=none smtp.remote-ip=116.203.77.234
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.203.77.234;
 helo=mail.fris.de; envelope-from=frieder@fris.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de
 header.a=rsa-sha256 header.s=mail header.b=iaFVIMdK
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 593824007E
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:20:54 +0000 (UTC)
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
 t=1793636449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uIuD1MQ7ho09IWfqJC5fLmzB/Z6wGHWKwdTSqfBJX/A=;
 b=iaFVIMdK4xGad4qZFQw8UiOLgwfW8TGPCOs6JnYdaRaM8kx4ItRq6uM1T9HymM5O9fsZWI
 1QX2Hw4ITH6AOHHxLKy5bvYqWlBf7PlbS1kOOz+IKFz64sgwtfx885frXDJenQp6GahW/u
 eQ62WFvHUvYXs71ZTP2Lee/vR9ig2FStb55aGMtuy/5D2twOgWGJMHKqM6qJMicUSl7FvO
 0Y0tLriLviA1l8hXX5/J4r14UdTcBBYWUDSBX3g1KPzmuyYM/H7lYGk3iZIAoZ9UyojJgY
 LRTFpDWFxSNP/vRZbL3zcO3LicUeiT0CPyJhNOb3J20AqbusmS+HmqV4Ie9Wvw==
Date: Mon, 02 Nov 2026 17:20:24 +0100
Subject: [PATCH v2 07/12] bootstd: rauc: Only set the RAUC variables for a
 RAUC device
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-main-v2-7-4537bcb19d66@kontron.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4021;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=fvI2LQD6t+MYQn7E/Tvv0TGJCS0kQ5NyFPer2IStn4Y=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIevFjtiq9b8DHj3+HuFwJ7VoT1swX+jLyhn/1mg/uzz90
 //j235/6ihlYRDjYpAVU2SR4rd4bWsW6yN/rDoKZg4rE8gQBi5OAZhIMycjw6Pyc8aW2w+lm+yx
 TbOfNu+086Mz7H9LSv/oyWXcu+d8wZiR4bLuIYbGeWc63zlqykQt6DvfVKVefTlsauGFj1eMhG7
 uYAMA
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

distro_rauc_read_bootflow() sets BOOT_ORDER and the BOOT_x_LEFT
variables to their default values before it looks at the partitions of
the device. Every MMC device that is scanned therefore adds them to the
environment, also if it has no RAUC system on it, and the next saveenv
stores them, for example when another bootmeth saves the environment.

Set the default values only once the partitions of the slots have been
found on the device. Until then, use the default boot order if
BOOT_ORDER is not set.

Assisted-by: LLM
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes in v2:
- New patch (Simon)
---
 boot/bootmeth_rauc.c | 57 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 18 deletions(-)

diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
index 52d5be388cc..a32f19303a5 100644
--- a/boot/bootmeth_rauc.c
+++ b/boot/bootmeth_rauc.c
@@ -121,7 +121,10 @@ static int distro_rauc_scan_parts(struct bootflow *bflow)
 	if (!priv || !priv->slots)
 		return log_msg_ret("priv", -EINVAL);
 
+	/* BOOT_ORDER is only set once a device has been found */
 	boot_order = env_get("BOOT_ORDER");
+	if (!boot_order)
+		boot_order = CONFIG_BOOTMETH_RAUC_BOOT_ORDER;
 	boot_order_list = str_to_list(boot_order);
 	for (i = 0; boot_order_list[i]; i++) {
 		const struct distro_rauc_slot *slot;
@@ -150,32 +153,27 @@ static int distro_rauc_scan_parts(struct bootflow *bflow)
 	return -1;
 }
 
-static int distro_rauc_read_bootflow(struct udevice *dev, struct bootflow *bflow)
+/**
+ * distro_rauc_set_defaults() - Set the RAUC variables that do not exist yet
+ *
+ * This sets BOOT_ORDER and the BOOT_x_LEFT variable of each slot to their
+ * default values, unless they exist already.
+ *
+ * Return: 0 if OK, -ve on error
+ */
+static int distro_rauc_set_defaults(void)
 {
-	struct distro_rauc_priv *priv = NULL;
-	int ret = 0;
-	char *slot;
-	int i;
-	char *partitions = NULL;
-	char *partitions_cursor;
-	char *boot_order = NULL;
-	const char *default_boot_order;
 	const char **default_boot_order_list;
-	char *boot_order_copy;
-	char *boot_order_cursor;
 	char boot_left[BOOT_LEFT_LEN];
-	char *parts;
+	int ret;
+	int i;
 
-	/* Get RAUC variables or set their default values */
-	boot_order = env_get("BOOT_ORDER");
-	if (!boot_order) {
+	if (!env_get("BOOT_ORDER")) {
 		log_debug("BOOT_ORDER did not exist yet, setting default value\n");
 		if (env_set("BOOT_ORDER", CONFIG_BOOTMETH_RAUC_BOOT_ORDER))
 			return log_msg_ret("env", -EPERM);
-		boot_order = CONFIG_BOOTMETH_RAUC_BOOT_ORDER;
 	}
-	default_boot_order = CONFIG_BOOTMETH_RAUC_BOOT_ORDER;
-	default_boot_order_list = str_to_list(default_boot_order);
+	default_boot_order_list = str_to_list(CONFIG_BOOTMETH_RAUC_BOOT_ORDER);
 	for (i = 0; default_boot_order_list[i]; i++) {
 		ret = boot_left_name(boot_left, default_boot_order_list[i]);
 		if (ret) {
@@ -195,6 +193,24 @@ static int distro_rauc_read_bootflow(struct udevice *dev, struct bootflow *bflow
 	}
 	str_free_list(default_boot_order_list);
 
+	return 0;
+}
+
+static int distro_rauc_read_bootflow(struct udevice *dev, struct bootflow *bflow)
+{
+	struct distro_rauc_priv *priv = NULL;
+	int ret = 0;
+	char *slot;
+	int i;
+	char *partitions = NULL;
+	char *partitions_cursor;
+	const char *default_boot_order;
+	char *boot_order_copy;
+	char *boot_order_cursor;
+	char *parts;
+
+	default_boot_order = CONFIG_BOOTMETH_RAUC_BOOT_ORDER;
+
 	priv = calloc(1, sizeof(struct distro_rauc_priv));
 	if (!priv)
 		return log_msg_ret("buf", -ENOMEM);
@@ -257,6 +273,11 @@ static int distro_rauc_read_bootflow(struct udevice *dev, struct bootflow *bflow
 	if (ret < 0)
 		goto rauc_read_bootflow_err;
 
+	/* Only touch the environment for a device with a RAUC system */
+	ret = distro_rauc_set_defaults();
+	if (ret)
+		goto rauc_read_bootflow_err;
+
 	bflow->state = BOOTFLOWST_READY;
 
 	free(boot_order_copy);

-- 
2.56.0

