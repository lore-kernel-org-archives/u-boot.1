Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2537606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 14:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dmBfiIfm;
	dkim=pass (2048-bit key, unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail header.b=KXdHK4jO
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 34C6160794;
	Tue, 27 Oct 2026 14:17:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RR9qcuxxq2ub; Tue, 27 Oct 2026 14:17:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 64D506078A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793110634;
	b=fSp68IuzmmBJnrmEe6t7HnW3bOKhqPp4JOXWcLn6WJNun1MyIps54jX3j+OMD19CpI8D
	 VMaemIVweQ43eI1JGmHZQ56mSZzUmBFwkm3L+FffKfxQbe74vY5dLNu+EetdfRm5vbS4I
	 nLJ51FJ99HRIv1zXF2m9d3nLA+DMjh4vUvqxuP0RaytvJO5m9DXfoHS50raMQeeawxr4X
	 g+M+2SXgvcGcAT5aTAOEfjiZiDtQSTpeMeLmZye9Hj5t2tsh7tdhGedSRWDnIoBxn4+/g
	 H4+I6oVE9+Ic7IRJ4b362A/Dez1mnQWndXbMPfOOiJhLPxc9Dqsl3iWuHI7G9HSG95A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793110634;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:From:
	 DKIM-Signature:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ynLlHUhj/J0awqxVLCLBnIT9Yjixd2k+7aZKKtXzX/0=;
	b=GvKKM2etvG3basCcUOlXSjd3bTeW2ssMYBfRI0HgrYHpL6lufKgeSigUCuC3en8hYHX8
	 PHPfJdYGCKkyVoBN6hdq+vwoRnOnUnk+DZAiVAyjiLj9fhDF+q7lpf4olxjVM77GPw/mJ
	 6qGkjJA1M2834uw4zfrx7RY7lI7ceAQOIcnJpCvnCJkbaGYx6UaZQf5O7pHbBHaLyh/9N
	 4HzTuduNmMq72OREvq6S5REejy7KvoJLit3+QpHtDjVG9+LfigyOwqkHprxnB/Dzdpe5m
	 JY5O/pwGWmDbQcjzyJezb9fGcXLrae5N6Itx6oHQiX1z32vpajZl2TMTSHdh6MgV2zw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793110634;
	bh=ynLlHUhj/J0awqxVLCLBnIT9Yjixd2k+7aZKKtXzX/0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dmBfiIfm43Fr7qPdYBJPyyrwUu4yG3N1kb5kA+WlNZJpMvWSMYCfpMnQ8gVCQD2X1
	 qAVKo75Rawcqq9Oq5eu3S5x++REnffiR0eS5sS7xoX5LozJcXnV0Bvnajo2utBg4h6
	 UyGkeWd7OIamVyheUE6Ucow1HEWFmKAEltnfDQk5iyT8+t6BNJzYsfpEHj5sqcKDCR
	 Xj7RzHJ7O4dXOIkpmXBBoy7y3uLpu0+rh7LDTolO/fZRqv/pctkf5aNTloOObVAqCU
	 WPrXmLyXJ5OpmVHSqGm5fhvi7K6A3gnNJVEci7CO0UiQAigMcnpmKo1mtnKBgB2LsB
	 qYc7fdn4M2DwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 64D506078A;
	Tue, 27 Oct 2026 14:17:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E36A5B91
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:17:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CA16F4063A
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:17:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OGKDYLrsGIYk for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 14:17:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 69E42406CD
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=116.203.77.234
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793110631;
 b=ifO9JO382moEDrcw2tDj9EOD21BcKY7Q+hnMTr27h2BvbfeItk0kVd5Xcz06xjgGhg6o
 9rnIWZbY4C7wcS1wA3ftF51crOn16aP34PkVnotsc8mGSNEJ6p0H8hOhmPU2F/CZ7rdQt
 mzLgpqlyRIXCP/aN0jpQmIaSFYgLAg3bd/7Uu3VhHQyFAOweUjXaOETlLODiYCnhG4WoS
 n8fmqE1dmolQTrsyPQ5ESu2NM6qRRWlF267F+j0Z3kwrmJ72b2UzrggJOppq9rqM8vRD9
 OBnYO24ruotD/15X+UF4wyAyDTyfLcn2x8wyVmYKNTmyhdGsqPbWK+YS2b3wfmEFnHQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793110631;
 h=Received-SPF:From:DKIM-Signature:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
 bh=ynLlHUhj/J0awqxVLCLBnIT9Yjixd2k+7aZKKtXzX/0=;
 b=DPOXEI4UUC4v2Ou8ggcBekQgTJdlJU43FWJciNx/yeOPjnJWDuO4/qQBOfdoP+qTOuGA
 7dE5jZ7KY6+h2G9MIqlrgEG6kCCyiEU2MQfNt3qHbmV4G6btRbrtn43oU7MNdgf1cExMk
 dGpXTPPwYRAYulmjoeV7vTrvHXtXQeNIORpJzQ4Id/gR8n9UHsMqVqWSy8FToMnOQh0A1
 qmNbrCcFrJGV/NEF/B8GvGTLMueH0G8P+gVQIaWnJQZcHRB2QqF5xQfUrpc/g5EH/DPw0
 1eyNPjdW94lF33gtKmmdjh8QmOK0kC0/qIyOdaSbXiKiAKCaejscSC6aDQDBuZ4hq8w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=fris.de;
 dkim=pass header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail
 header.b=KXdHK4jO; 
 arc=none smtp.remote-ip=116.203.77.234
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.203.77.234;
 helo=mail.fris.de; envelope-from=frieder@fris.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256
 header.s=mail header.b=KXdHK4jO
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 69E42406CD
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:17:09 +0000 (UTC)
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
 t=1793110626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ynLlHUhj/J0awqxVLCLBnIT9Yjixd2k+7aZKKtXzX/0=;
 b=KXdHK4jOdP2EziR2t7dTYbfQ12uc8ToMCy/kHz9SVzTpmOr0QBMj31QsvsiDfo6E5gd4YL
 TPnfGlJMyxlCh4dLx6j0FuRx7Tp8ipKMZQ6HObwUsmIIpMix+/kQ1qMbpJhLrErx1ck+ZT
 Dep+CoUGYIG4Ltk4A9j0H2ynsToS0ykNeTCdWOhzwum4T2EWPNvJnUa+6Jq3l2DlCtyM3V
 IaoNh4ZdjyHSdg/kzY8E7lqKxCRuGq5QOnZvOFDcbh6ApVH+JVxrg857P7Y993J54z3Cw8
 aFF4T2xUh2Jrl6aqVs/AVLz4h+lV0eq6CzMmrBoMM5njib+NsMkrQYttyKclIw==
Date: Tue, 27 Oct 2026 15:16:39 +0100
Subject: [PATCH 2/2] test: blk: Check that partition devices are unbound on
 remove
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-blk-part-unbind-v1-2-e44d2b48ced0@kontron.de>
References: <20261027-blk-part-unbind-v1-0-e44d2b48ced0@kontron.de>
In-Reply-To: <20261027-blk-part-unbind-v1-0-e44d2b48ced0@kontron.de>
To: AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Daniel Golle <daniel@makrotopia.org>, Jan Kehren <jan.kehren@emteria.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2795;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=LrXN4LSZkz8dCT+xdqlFcNKpplvSjtRqSqI5LVBzp60=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIevBpkTn9dmvn1m8OynttPkAf25YiNcek2/ndaX/x17n8
 tBTCHXtKGVhEONikBVTZJHit3htaxbrI3+sOgpmDisTyBAGLk4BmIjVSYb/mev0v/N/WjzHl+GB
 XY8IR/LrH4F+50tj7kmJiyr43d99jOEPz5dtrkHB3KkL1Aw9jNpX3FuWu3Nu/B3LjzmP2mMOaAt
 wAAA=
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

Add a test that removes and probes a block device with a GPT several
times and checks that its partition devices are unbound on remove and
bound again only once on probe. Also remove the block device with the
flags used before booting an OS, which don't match the partition
driver.

Assisted-by: LLM
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 test/dm/blk.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/test/dm/blk.c b/test/dm/blk.c
index f67869107da..f952a650a47 100644
--- a/test/dm/blk.c
+++ b/test/dm/blk.c
@@ -9,6 +9,7 @@
 #include <sandbox_host.h>
 #include <usb.h>
 #include <asm/state.h>
+#include <dm/device-internal.h>
 #include <dm/test.h>
 #include <test/test.h>
 #include <test/ut.h>
@@ -291,3 +292,66 @@ static int dm_test_blk_foreach(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_blk_foreach, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+
+static int count_part_devs(struct udevice *blk)
+{
+	struct udevice *dev;
+	int count = 0;
+
+	device_foreach_child(dev, blk) {
+		if (device_get_uclass_id(dev) == UCLASS_PARTITION)
+			count++;
+	}
+
+	return count;
+}
+
+/* Test that probing a block device again does not duplicate its partitions */
+static int dm_test_blk_part_reprobe(struct unit_test_state *uts)
+{
+	char str_disk_guid[UUID_STR_LEN + 1];
+	struct disk_partition parts[2] = {
+		{
+			.start = 48, /* GPT data takes up the first 34 blocks or so */
+			.size = 1,
+			.name = "test1",
+		},
+		{
+			.start = 49,
+			.size = 1,
+			.name = "test2",
+		},
+	};
+	struct blk_desc *desc;
+	struct udevice *blk;
+	int i;
+
+	ut_asserteq(2, blk_get_device_by_str("mmc", "2", &desc));
+	if (CONFIG_IS_ENABLED(RANDOM_UUID)) {
+		gen_rand_uuid_str(parts[0].uuid, UUID_STR_FORMAT_STD);
+		gen_rand_uuid_str(parts[1].uuid, UUID_STR_FORMAT_STD);
+		gen_rand_uuid_str(str_disk_guid, UUID_STR_FORMAT_STD);
+	}
+	ut_assertok(gpt_restore(desc, str_disk_guid, parts, ARRAY_SIZE(parts)));
+	blk = desc->bdev;
+
+	for (i = 0; i < 2; i++) {
+		ut_assertok(device_remove(blk, DM_REMOVE_NORMAL));
+		ut_asserteq(0, count_part_devs(blk));
+		ut_assertok(device_probe(blk));
+		ut_asserteq(ARRAY_SIZE(parts), count_part_devs(blk));
+	}
+
+	/*
+	 * Removing only the active devices, as done before booting an OS,
+	 * removes the block device but doesn't match the partition driver
+	 */
+	ut_assertok(device_remove(blk, DM_REMOVE_ACTIVE_ALL));
+	ut_assert(!device_active(blk));
+	ut_asserteq(0, count_part_devs(blk));
+	ut_assertok(device_probe(blk));
+	ut_asserteq(ARRAY_SIZE(parts), count_part_devs(blk));
+
+	return 0;
+}
+DM_TEST(dm_test_blk_part_reprobe, UTF_SCAN_PDATA | UTF_SCAN_FDT);

-- 
2.55.0

