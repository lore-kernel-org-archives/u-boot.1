Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3390606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 09:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HaP0tzy2;
	dkim=pass (2048-bit key, unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail header.b=H9ErjAww
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8F4D060792;
	Mon,  2 Nov 2026 09:04:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4P9zHoIb_bC0; Mon,  2 Nov 2026 09:04:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1722160758
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793610253;
	b=GRH1BWOVIfbkvJmw9CPJvMzcAYc07/opwtqH+G/UhdApTLZV7ZSYZnOhrWtFhPIJBHmf
	 tNjcSr0uI/CKjlJeDMqAL0AD2zO5Z/rd2rjBh+uDKzfa6Ry8Qchqe4CfHH5TRUsIUelLq
	 WB50Fx99YQsV/aY8k1GP/TJul3iSFzg1ZpNzz+X9cm5osYH1CVKkKUuL5z42WRdW9gQVS
	 rvmiPsJfnlsuzx4TBfJUNOpCHeTidKeHXjTvEzXNjc9ehZkH85XNJmblq1IQ/pVZSs4Qk
	 mp8ySrgcm2A3G7TqkBBTIoRMkSmkliMhnQfzeVAfMIOk753vteECW2AIYr+JZO3k//g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793610253;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:From:
	 DKIM-Signature:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=m8Hj9Mimjoot1GUxPWLdy686C8VVK4+i3GjInv6aEaw=;
	b=D++zxPjF/HmcsYm3TSYAG4X1b7wnkEIxKC4mivocC59AklQHWavlvAUf+Pg3l1bhlVaz
	 zstws/3LVGC9iZWKKn/DlHQDC/i9ruU12Q4nv1+Vf9FWjvyr9cKGe/lsY4e7khCQdpyC6
	 KQfAkmpgJc54p8XuEqUAB9RO6F/EWATZGaRNt1sm2rm89COZuc6XBhKfWhOYhDG57d0i6
	 nABgxAzh1Eysvc5ZrmuDjNv7L6Po0txkMFAB2uW7bfdVS8kOWTd9PSJi59kZe75+awX7e
	 A6lu7o3DT3JXWmC37j/q/G8/f3+s7CRJY7OB90Gu0RfIZ4DLY9iNQEd2GnzhU0JSmww==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793610253;
	bh=m8Hj9Mimjoot1GUxPWLdy686C8VVK4+i3GjInv6aEaw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HaP0tzy2QmUIU9NqMCErc1Mk0p9IIc6GnYT7OTUYRNc6Q6fB2ilU6W/8aLqtHlSf9
	 +/12VWVkJPPVy7vAFyUBC25sxuJRams/qZyoeBI6ir9JPkCKj6O3EaZsSpkh9QszHB
	 ziD1TIUEw13JyeezcVxMtaqk8Wj4PenhAv2LvKcmYUmcKNYrZ02GcwF3xFkMtKzuw7
	 ucCrEpRanUesAhl7UXzT/XxBfsJ5CNOjuXxgfQzQWRMGBj/Uwcr4ksUA9cTFs0tnyp
	 M+icx2BqZl05t2vj5x2xnf/mdz6l8b2/IJ4GhSdIcSu0NOfpNEjLvOJIkWbvjJXAxf
	 gw3tXyqTVBgrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1722160758;
	Mon,  2 Nov 2026 09:04:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A1670362
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:04:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 92D3580CB9
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:04:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vZS8dtTjkRCD for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 09:04:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CC53480F1C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=116.203.77.234
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793610250;
 b=ea9Ffl1Pyg94JeVaqJmQqh/LF51lSpbRyTfQelK24Zs6h6yjqvzD8p8UtbeSUXf/aLLn
 n9Z09t9qSyluWkZPXD7OETX5idD+UFJj505SH2QJBpYTDOno2AhCiXY4Pw+txhJe9PP2R
 lYHwQGDbhlLWssBnaiMsP9LpF9InjC3l5VyQD/jNRdVKHavO2STBiv6ItC7W3fOKk5IGX
 ZblNTZCCuHHarHpRu3IfUTeJvfLKLhZTfsQqQYRrO0Gmg2JGY8GWCyPWHLDouDxi+CI46
 ScERa5n+kuIovRQojPzlZ/7tVEF4CcgGU9wL+G6CCsErrbcPfBQkCMzPitCh2zkFffQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793610250;
 h=Received-SPF:From:DKIM-Signature:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
 bh=m8Hj9Mimjoot1GUxPWLdy686C8VVK4+i3GjInv6aEaw=;
 b=FaUfjbeKzwgGUnBxQ35KwDSYvCL2vUPAxW8aM/r8bCCCZ2woT5m07OjC7/qbdc+V8Pcy
 1KbB0Lh+6aUmFULA9n/QlA+mUvKPJyzjKVqAK/yEB8Fl2WcQpLzIXS+eo/Svwwac+mcTC
 baB6U4o+C7Kp3vW5m+t1QYveZs1nnFw0Y/julC4MrsxHDMj9kgWSvbDNSplOsDx8r4vcA
 fV3ap0VG6LdaOjWBCxy8o1Rn9AC222DglHDpuwYXqZ5+BJ7lWAeN9HtpQD/L3aKGbUzd2
 OPrnEtj0mZDnpMTl2Thg35pJ2OKKDoxXFIEPvy/5S4JC7KkQgOxYAzbxqjt+Gyag44A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=fris.de;
 dkim=pass header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail
 header.b=H9ErjAww; 
 arc=none smtp.remote-ip=116.203.77.234
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.203.77.234;
 helo=mail.fris.de; envelope-from=frieder@fris.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256
 header.s=mail header.b=H9ErjAww
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CC53480F1C
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:04:08 +0000 (UTC)
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
 t=1793610245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m8Hj9Mimjoot1GUxPWLdy686C8VVK4+i3GjInv6aEaw=;
 b=H9ErjAwwLUJBp5dZj2av8ILx1YVD5syepM+QoyJRh9dftXw9dtWuH2i49VewB+ObxQTFWm
 8XbwKeI8YWom5EwdKfPD7i7mQTo+zv8K1Qm9kMHTIGtgeraAaZubjmU+xPBBWK9BcHdkTV
 s2qq65bMVU8YwnblunlqXIlaaQjp3m6I918g//dR7oo1eoZnaJo2zj5R53Tpc7Xa72vBMB
 F/c3Aw6Qg1L+44q5TYDex+/v95gnEndw0b1t1lBeGW8HaLZJw3Fjg5ibzHQk9EAihsmT2x
 xVAVQUjH4ctmn/RGtIqXg6TSHzmAOE7ulPodK6BDyJkurFtp6d/zHfKtZrjW1Q==
Date: Mon, 02 Nov 2026 10:03:48 +0100
Subject: [PATCH v2 2/2] test: blk: Check that partition devices are unbound
 on remove
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-blk-part-unbind-v2-2-d0319d20fbfe@kontron.de>
References: <20261102-blk-part-unbind-v2-0-d0319d20fbfe@kontron.de>
In-Reply-To: <20261102-blk-part-unbind-v2-0-d0319d20fbfe@kontron.de>
To: AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Daniel Golle <daniel@makrotopia.org>, Jan Kehren <jan.kehren@emteria.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2989;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=vux2vYvkM57NjXk+8gDelDNR2eOVByqLkySNpsv6I9w=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIetFEMu+0An7FJdaJSd8cz3TEzolZHKS/bZroZeM3v5aq
 X8kXulJRykLgxgXg6yYIosUv8VrW7NYH/lj1VEwc1iZQIYwcHEKwESU2xkZGiOvhWjPn7C/v2na
 Xs2iW5MjFv1w8/4TYTBJ24KfY/p/XoY/PFHpWbOnbJ/CbNl0b5feXMOHZ15In1VZ8rS67fHmoG3
 3mAA=
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
bound again only once on probe. Also check this when removing the block
device with the flags used before booting an OS. The partition driver
doesn't match these flags, but the partition devices are removed along
with the block device and must be unbound as well.

Assisted-by: LLM
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 test/dm/blk.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/test/dm/blk.c b/test/dm/blk.c
index f67869107da..0abf032b392 100644
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
@@ -291,3 +292,67 @@ static int dm_test_blk_foreach(struct unit_test_state *uts)
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
+	 * doesn't match the partition driver, but the partition devices are
+	 * removed along with the block device and must be unbound as well
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
2.56.0

