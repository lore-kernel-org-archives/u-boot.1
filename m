Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC72606A31D
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 16:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JnOtvMiZ;
	dkim=pass (2048-bit key, unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail header.b=knT6y8Ih
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BA79C6071F;
	Thu, 29 Oct 2026 16:23:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R9f0zZU8bwFz; Thu, 29 Oct 2026 16:23:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EFE2060721
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793291030;
	b=ROX6avt74EsJy2JXtCsCCoNDqHHBnjMylL3Ba8dKIPCX+GFrvGz6gyXw3luiJzuJQlnj
	 f100bt+hzmjJd1qD6WQI1/+El4Duk/XDwtFyIVepviTSAOXd4GXjfI75/mIV4Ek9Za4Ja
	 BjgrtFBPAVeadDq5OY9mbNcieTXXck0DSynWi8Bfgl/a0tn7ZMsX+UZOwVHc5aEWIiDUz
	 Mknpdvx5dEiM26U40kYTX6ONNrxoLGsFw7ABfodITtS2XMNjlwjvw6aipj5QsrTwBX7yW
	 EQ4MrmYV7MyDU0gwuZMipfYlB/jsZsbassGe/1DeLiNr4EK7gVjJ+gPoJ20A4lVjrLw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793291030;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:From:
	 DKIM-Signature:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=DX3NX4IkFQNj/PKzxI99xUWYOR/slqSHTdYAzCkdAxQ=;
	b=ruK6fF9o9rk3/ZH9f8yakNRbEMHpHdNYGJFHz32CnGlNJ9bTqKFpB67uizi5o6Gu5tmw
	 AM8zhlYM0arc3K63SeVazl8xm99yTbAsCcyEA38r4LfnowWab+L0f97oKD4qh8WFtq9yk
	 UiT00I+XzPH9G+hllVSgz4PudJx8dD5IScj4AbPjeeZAxfSsETF6Wbj9ivZlG01xUb2Yr
	 s41PsQM5pWiY2L172adNz+RXX4ERxlCe51bhSZ7iIWSk7vnyvRXayJMuOicOKLLgeUcAm
	 m2vU+idzqycapAJjyYTYtYnHA0r6UKMTtvnKwYpWAFtICuY1QVFh8d+BrZqJFOBOZQg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793291030;
	bh=DX3NX4IkFQNj/PKzxI99xUWYOR/slqSHTdYAzCkdAxQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JnOtvMiZrnXQHt1P2uvR5bTLt10uVujheWFA4CtgTAGwZwB5l2OSeRZMROc6axey3
	 JQD8LDZ2w0S0KZ4Es49idpr0Xa5QD0TeoDIhRSNCgS+/83QYwq2Bb1eLzGhXVCGwtT
	 uKapGqAK+9dbTLd4f4jwoaB0UevdT2R977WlzLLcq8nDkleNZa9tuYt1HeacJJ5feZ
	 fSMxwBR9YGbqkxy12EsApSyRFkyW1B3FU0eNXyphKTsi8rr+2lWOJu5OpuJfOhms/S
	 Sq5MavwuKcX1cP5kweqD88jBCgoolyn8Sa2eKvIkb8TeRU+56bKgCpudyUTkbkGsB2
	 Ego/fLS5VCsuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EFE2060721;
	Thu, 29 Oct 2026 16:23:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 991A2DD7
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:23:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7EC5840744
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:23:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RZhUNbeW78WN for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 16:23:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A560B4075F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=116.203.77.234
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793291011;
 b=JNrkB+xd9v0Zm2LVqJp+ENAlD0mgYtfIKoFbAV4jlsf+D3Fi3NapVfLmdRuz73obZwVy
 aea0MLHIKs3v+qRnAhib2uxCCnsKJboLfI9Kuqs0h0iGZKRw9ExX60TLlM9zgBK2tiQlb
 qhBiE63w/Fy3BmRhGKxK8+vtEP4DJQ02CxltrSZZ8QOEdwqbqIyUWkWht7a5WFe1uOuO9
 6bpYHRVyp8BKBSQhBVyFP8lY9A4KDavWXIjXxL4CwwRbuWSgAwLoW20CMW1btmxk9eYF+
 eLf9C8U3MxKt81giyajfEx6/gsAAFwG6MA2dOkP+/3ftR1AyZ3wQWtdkrbMQ7zDO18Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793291011;
 h=Received-SPF:From:DKIM-Signature:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
 bh=DX3NX4IkFQNj/PKzxI99xUWYOR/slqSHTdYAzCkdAxQ=;
 b=BVXeCoCqOXn4bWC+444Ks0iKs99WVqIFN3WqNeZnIfVRzyq+tHQTsXxV7EvPwsWX7cXS
 yqc4pxQ4oeh/9P9dCg56jL9hrTpkqIanplcpyEKDTWiw1Qc9PnAyLflRujaD+RbzDKWPm
 ldFeJcUMz7yIIMpIMNniGEhvEKBCBbRrXWggeLATEfp1NQ0emd+T7D2smywCCsSkSCGZX
 F1yo0ozVkDIoL9HiPBEE+WryyrFFHPQcMuAzCuUlA5nVJk0aih2S4seNiwJixI/1F5JsX
 TPTjtSK1g28d7/9q991saCZtJt7B9OujgXdRhr6Zg2r/nR0OMrKOhK4sfznwBQqpCqQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=fris.de;
 dkim=pass header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail
 header.b=knT6y8Ih; 
 arc=none smtp.remote-ip=116.203.77.234
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.203.77.234;
 helo=mail.fris.de; envelope-from=frieder@fris.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de
 header.a=rsa-sha256 header.s=mail header.b=knT6y8Ih
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A560B4075F
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 16:23:30 +0000 (UTC)
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
 t=1793291005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DX3NX4IkFQNj/PKzxI99xUWYOR/slqSHTdYAzCkdAxQ=;
 b=knT6y8IhzK7AMD7lrLq131ZzEm121jPSarxs92iSSDOSwIN2M0eJrrm5l9+pnOBL+uBPLq
 RK+y3plNO2T1j27iXqnI1wCO70MesWFfWfX7PyVxC7qgOC7EDBrqZC0LWgfVJ61IlfHYc6
 I1XAL54ANKeZ5ULkqLiI4d9n/zhfqN3i/7XHsDzAtoX9BJI0+L6Yo9R04ng5p5YiPhL1bm
 3ofq24AqaYHZsHUE9RG9hvjpvqGRNvoSEntMylmS44M4t9YwVZjhMEbQAwVanaq/tdVlON
 7RGTNVkDXiWXCHUk6vrfNsE3/Qq10mtIkFnXtwmgeOCU0xR5diEAw9aIz7T8zw==
Date: Thu, 29 Oct 2026 17:23:11 +0100
Subject: [PATCH 05/10] test: boot: Restore the bootdev order if the RAUC
 test fails
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-main-v1-5-b5a878627107@kontron.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3646;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=6FYZc+mgmcbj/72iGs9/r2P94qtXCJbnLIniDa8AUXo=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIetx0a8I3fesTv+4HObcCpno4GGdoKobEnNUcO4EPYZDz
 +bVvF7XUcrCIMbFICumyCLFb/Ha1izWR/5YdRTMHFYmkCEMXJwCMJE+cYZ/Jr/MBHmDPe8dCdk4
 U34q8/yfl7rq4mTKjn1ZKae2cousHyPDzY02d5cLy+pOU8rIa+WxuKi7Tv9yYfBxkz97Elr6y6I
 4AA==
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

bootflow_rauc() points std->bootdev_order at a static array and only
restores the original order at its end. If an assertion fails, the
test returns early with the static array still in place, and removing
bootstd then hands it to free(). This trips the dlmalloc checks and
aborts sandbox, so the failure of the flat-tree run is never reported
and no further test runs.

Move the setup into bootflow_rauc_run(), which restores the order
after running the checks, whether they pass or not.

Fixes: 36add050eea4 ("test: boot: Add test for bootmeth_rauc")
Assisted-by: LLM
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 test/boot/bootflow.c | 48 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index d478fd575be..d2d4edb0add 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -1619,23 +1619,31 @@ static int bootflow_efi(struct unit_test_state *uts)
 }
 BOOTSTD_TEST(bootflow_efi, UTF_CONSOLE);
 
-/* Test RAUC bootmeth */
-static int bootflow_rauc(struct unit_test_state *uts)
+/**
+ * bootflow_rauc_run() - Run RAUC bootmeth checks on an mmc bootdev
+ *
+ * This binds @mmc_dev and the RAUC bootmeth and makes them the only bootdev
+ * and bootmeth used, then runs @check. The bootdev order is restored even if
+ * @check fails, since bootstd frees it when it is removed.
+ *
+ * @uts: Unit test state
+ * @mmc_dev: MMC device to use, e.g. "mmc10"
+ * @check: Checks to run with the RAUC bootmeth
+ * Returns 0 on success, -ve on failure
+ */
+static int bootflow_rauc_run(struct unit_test_state *uts, const char *mmc_dev,
+			     int (*check)(struct unit_test_state *uts))
 {
-	const char *mmc_dev = "mmc10";
+	static const char *order[] = {NULL, NULL};
 	struct bootstd_priv *std;
 	struct udevice *bootstd;
-	static const char *order[] = {NULL, NULL};
 	const char **old_order;
-	ulong mem_start;
 	ofnode root;
 	ofnode node;
+	int ret;
 
 	order[0] = mmc_dev;
 
-	if (!CONFIG_IS_ENABLED(BOOTMETH_RAUC))
-		return -EAGAIN;
-
 	/* Enable the requested mmc node since we need a different bootflow */
 	root = oftree_root(oftree_default());
 	node = ofnode_find_subnode(root, mmc_dev);
@@ -1646,13 +1654,21 @@ static int bootflow_rauc(struct unit_test_state *uts)
 	ut_assertok(uclass_first_device_err(UCLASS_BOOTSTD, &bootstd));
 	ut_assertok(device_bind(bootstd, DM_DRIVER_REF(bootmeth_rauc),
 				"rauc", 0, ofnode_null(), NULL));
+	ut_assertok(bootmeth_set_order("rauc"));
 
-	/* Change the device and bootmeth order */
+	/* Change the device order, and restore it also if a check fails */
 	std = dev_get_priv(bootstd);
 	old_order = std->bootdev_order;
 	std->bootdev_order = order;
+	ret = check(uts);
+	std->bootdev_order = old_order;
 
-	ut_assertok(bootmeth_set_order("rauc"));
+	return ret;
+}
+
+static int bootflow_rauc_check(struct unit_test_state *uts)
+{
+	ulong mem_start;
 
 	/* Run scan and list */
 	ut_assertok(run_command("bootflow scan", 0));
@@ -1705,11 +1721,17 @@ static int bootflow_rauc(struct unit_test_state *uts)
 
 	ut_assertok(env_set("BOOT_ORDER", "A B"));
 
-	/* Restore the order used by the device tree */
-	std->bootdev_order = old_order;
-
 	return 0;
 }
+
+/* Test RAUC bootmeth */
+static int bootflow_rauc(struct unit_test_state *uts)
+{
+	if (!CONFIG_IS_ENABLED(BOOTMETH_RAUC))
+		return -EAGAIN;
+
+	return bootflow_rauc_run(uts, "mmc10", bootflow_rauc_check);
+}
 BOOTSTD_TEST(bootflow_rauc, UTF_CONSOLE | UTF_DM | UTF_SCAN_FDT);
 
 /*

-- 
2.56.0

