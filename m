Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8CE606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 20:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Oh5EDFZV;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=F9Wrdu50
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E069380D88;
	Sat, 24 Oct 2026 20:50:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5Vd9gvOOhTaD; Sat, 24 Oct 2026 20:50:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1EDC580E0D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792875039;
	b=qBK/SvZeoz4+rAaoHoKZpKqh1grP3Yr0FUUW9CFLeAUDpUOsq3gtSHjXdBhefuZmh8Mw
	 DM/jdF9yqN/nUIebAE8MxjACcDb947STuWbuESTvUVbenDWVIimvRA4XnaJKtk6/Q0GE0
	 oocRKRE0qdRNVmdboiJFMBNh6ABM9zopv3KZe9bX0TvcPoUkf+NEKiY31BEhlFNxU/R3S
	 8O2cvKOtQ0HN1j4qgaABhMqkTD6yg4oSzBrx+pfBfdrgEV9BRZ2iSlO4hxZMeA3LKqBKF
	 HsZrsJawm0XrfxWf+fsgpV842XvUR7EG3Nwyf2GbUrjzjxtcQICCg3VKcuykCM1IO1Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792875039;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fT5+fUPHD+IKrp4rjmK2QjIkaLUx7TZTew5OHYdR9Ic=;
	b=YCPfvoPIS1cYDjdM5W45WBUwBZOTi9fA3ycYJlqppPiGT83iFAx8iz9Kd0N7urq15Pjc
	 ngP7E0m+92LG8HfXkR4xrskfs00cq+10nCqNBTBBwdXmnVF/DBf/kE26gcgLHZ/DK1/cB
	 rrBpONN6eVcmntrs+gswNUENm3uzUX0/UPCJ8mOFFVLgpicEh67DTs68JiR5VQQoXVgWl
	 huQgaFMyWTYay0JxzrETbCb57/QFwJTlFq76G3YeD9F1ffI+7ulrfVYNRZdsk08NdJ858
	 IokhQW76fWD4iib6j0EdSdGpaNbv1UlkiTYqAK/f/Ta8gkz9noHJ2pbpQC+fcD38MuA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792875039;
	bh=fT5+fUPHD+IKrp4rjmK2QjIkaLUx7TZTew5OHYdR9Ic=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Oh5EDFZVFMch6febvDhFfnwoxjhXvbpET5Eus7OVa5f4Cwm+Hetxe3pNG/QvPCg7J
	 fnirK4OilPKxjDX3fiWffPpy2guMKztgNlnIH5Jdqb5pWX9BDbKKJoQNAssNoTOGnm
	 CAvQ4ZOUAHvTB6yX4ONIco9MKQlETRAfXRzf3Xy8hw2MuYOMeknktfbWcHN3JGCItl
	 BA3z0TigePNlOKrlubZJS1diG9e5QydsxBomKr6d7LoKwrQPH4PfKTY0DKZ93llyss
	 jz4g2tzDFiE9RayR+GjkHfmNT+/o49ne4daf5C1vYd2e7w9t79ir4sBSeL1jB9b++S
	 uyw8+3PCpHq6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1EDC580E0D;
	Sat, 24 Oct 2026 20:50:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 76873380
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 20:50:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 653CF406DD
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 20:50:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BKj8-mGzkbdv for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 20:50:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C980F406DA
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792875036;
 b=sEPJXIesxp9gqjppFYtWV1F0oYbhyM3oOFwEiEtLC+Pi8UCyf5hC2lEmfOHhK1GHtcp2
 gMxnCtI16Oy/GOfZdIPlT4j1S+gmhduQJ7SdsDzUezq6VhoTS6PIUpEXwAuu6lxov7lL/
 W9lkb+CcmFUUVx2bo4BivPJAOZ1+Uqk1IdL5F7jZQ+KiCCkbZldXAqYsMMzT6oxp26qgL
 F8JPhzkNahvIXxFw1873ZNtCkQWG+8hxZtOBSKANANEAolGDR4HupP7jgeZbrSWxpyoPf
 iAxrCIb8AzG6gmnzxeYYFrgBXvKaFmeQCunK0qhdTLQaGkukJuodi8AJeN4TnoOUCsg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792875036;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-Last-TLS-Session-Version;
 bh=fT5+fUPHD+IKrp4rjmK2QjIkaLUx7TZTew5OHYdR9Ic=;
 b=NQw5A0RAcjmeNsKOhLSCNEj9JphWBHrtXDLUQTwcwoWtijeMnMInqT/Tzn0acpEcFhYI
 vTOW6FlQlsZ2IUqBjIPNy4ch4lfzAjfIhh2+rcg3zYJejRp3EqPYo3iHJ9JGTlsCZZ8Fb
 /tWDpnAdrIljOjNlXCwHm49Nw8QLLZbByXqaRiCo6/OXQKepZ8Ys5U5Qi7EQaYISzQI6F
 hCYWBpqRtnTWKi05ivazHZucODmH6WQfShz6uIuOH9cMMvi1PlVUqAAtBmwim8uSFjTDZ
 y8UqeMAFBgmwhK8Y1BP9a8IJQ9CYV2kHXRktBw1j77CQPpzbCL1br6tQhd62ytlGwIA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=F9Wrdu50; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=marex@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=F9Wrdu50
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C980F406DA
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 20:50:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CF6BA1064D9; Sat, 24 Oct 2026 22:50:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1792875029; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=fT5+fUPHD+IKrp4rjmK2QjIkaLUx7TZTew5OHYdR9Ic=;
 b=F9Wrdu50QkcTrqNMsj6CGyjSCo8Yp0vHmXg7nYLzL5WYgPgnHJV4HAdHze88euYVTZXfqD
 W58pvEh/9omUtW8HYq4CHKbVQaBx7r10LNsrlLedk5Nj5Q+dCHp16MHRp06lhGTbLEMHoQ
 bHZsjDlTWlKpO+KxrWx6juXUT+zN1QFNdw0fyjYO8NWIuuc+pnGQvkdgzZB7BysvL5tNoG
 YX5kRcKqhd4IQtNsEb6OLj1x4vhdhpPWUxS1v9xtpMV4ePk5EEJfUDwFywW+y8aUGOShWM
 XNM9IwrOSn8ycA15uKxiW4d6ROPdWZZWBdqFqzNymvd42uX2tErMfG8D9b22Yw==
From: Marek Vasut <marex@nabladev.com>
To: u-boot@lists.u-boot-project.org
Cc: Alexander Koch <akoch@initse.com>, Marek Vasut <marex@nabladev.com>,
 David Lechner <dlechner@baylibre.com>,
 Flaviu Nistor <flaviu.nistor@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Tom Rini <trini@konsulko.com>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Vignesh R <vigneshr@ti.com>, u-boot@lists.denx.de
Subject: [PATCH v2] mtd: spi-nor: Indent SF: just like other boot time messages
Date: Sat, 24 Oct 2026 22:50:09 +0200
Message-ID: <20261024205023.257638-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alexander Koch <akoch@initse.com>

Indent SF: just like other boot time messages. Change the original indent:

"
DRAM:  3.5 GiB
Core:  310 devices, 34 uclasses, devicetree: separate
SF: Detected w25q128jw with page size 256 Bytes, erase size 4 KiB, total 16 MiB
"

to the fixed indent:

"
DRAM:  3.5 GiB
Core:  310 devices, 34 uclasses, devicetree: separate
SF:    Detected w25q128jw with page size 256 Bytes, erase size 4 KiB, total 16 MiB
    ^^^
"

No functional change.

Signed-off-by: Alexander Koch <akoch@initse.com>
Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: Alexander Koch <akoch@initse.com>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Flaviu Nistor <flaviu.nistor@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Takahiro Kuwano <takahiro.kuwano@infineon.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Vignesh R <vigneshr@ti.com>
Cc: u-boot@lists.denx.de
---
V2: Fix tests
---
 drivers/mtd/spi/spi-nor-core.c | 2 +-
 test/boot/bootdev.c            | 4 ++--
 test/py/tests/test_env.py      | 2 +-
 test/py/tests/test_sf.py       | 2 +-
 test/py/tests/test_spi.py      | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 3556af3e77c..eb022e577a2 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -4758,7 +4758,7 @@ int spi_nor_scan(struct spi_nor *nor)
 	nor->sector_size = mtd->erasesize;
 
 #ifndef CONFIG_XPL_BUILD
-	printf("SF: Detected %s with page size ", nor->name);
+	printf("SF:    Detected %s with page size ", nor->name);
 	print_size(nor->page_size, ", erase size ");
 	print_size(nor->erase_size, ", total ");
 	print_size(nor->size, "");
diff --git a/test/boot/bootdev.c b/test/boot/bootdev.c
index c2eaf0b2c55..c06c47a0633 100644
--- a/test/boot/bootdev.c
+++ b/test/boot/bootdev.c
@@ -742,11 +742,11 @@ static int bootdev_test_next_prio(struct unit_test_state *uts)
 	 * starts looking at the devices, so we se virtio as well
 	 */
 	ut_assert_nextline("Hunting with: virtio");
-	ut_assert_nextlinen("SF: Detected m25p16");
+	ut_assert_nextlinen("SF:    Detected m25p16");
 
 	ut_assertok(bootdev_next_prio(&iter, &dev));
 	ut_asserteq_str("spi.bin@1.bootdev", dev->name);
-	ut_assert_nextlinen("SF: Detected m25p16");
+	ut_assert_nextlinen("SF:    Detected m25p16");
 	ut_assert_console_end();
 
 	/* keep going until there are no more bootdevs */
diff --git a/test/py/tests/test_env.py b/test/py/tests/test_env.py
index f8713a59ba9..16b1c4b26a4 100644
--- a/test/py/tests/test_env.py
+++ b/test/py/tests/test_env.py
@@ -595,7 +595,7 @@ def test_env_spi_flash(state_test_env):
         spi_flash_img = mk_env_spi_flash_single(state_test_env)
 
         response = c.run_command('sf probe')
-        assert 'SF: Detected m25p16 with page size 256 Bytes, erase size 64 KiB, total 2 MiB' in response
+        assert 'SF:    Detected m25p16 with page size 256 Bytes, erase size 64 KiB, total 2 MiB' in response
 
         # force env location: SF
         response = c.run_command('env select SPIFlash')
diff --git a/test/py/tests/test_sf.py b/test/py/tests/test_sf.py
index 5b4ba80f18b..24447ff5e8f 100644
--- a/test/py/tests/test_sf.py
+++ b/test/py/tests/test_sf.py
@@ -70,7 +70,7 @@ def sf_prepare(ubman, env__sf_config):
     cmd = 'sf probe %d %d' % (probe_id, sf_params['speed'])
 
     output = ubman.run_command(cmd)
-    assert 'SF: Detected' in output, 'No Flash device available'
+    assert 'SF:    Detected' in output, 'No Flash device available'
 
     m = re.search('page size (.+?) Bytes', output)
     assert m, 'SPI Flash page size not recognized'
diff --git a/test/py/tests/test_spi.py b/test/py/tests/test_spi.py
index 09174f91e98..5529b85941b 100644
--- a/test/py/tests/test_spi.py
+++ b/test/py/tests/test_spi.py
@@ -112,7 +112,7 @@ def spi_pre_commands(ubman, freq):
     bus, cs, mode, part_name, timeout = get_params_spi(ubman)
 
     output = ubman.run_command(f'sf probe {bus}:{cs} {freq} {mode}')
-    if not 'SF: Detected' in output:
+    if not 'SF:    Detected' in output:
         pytest.fail('No SPI device available')
 
     if not part_name in output:
-- 
2.53.0

