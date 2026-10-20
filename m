Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6384606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 09:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sCS/Hzx2;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=erEs72oO
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B6CCD811B4;
	Tue, 20 Oct 2026 09:26:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fb69yC51MjvC; Tue, 20 Oct 2026 09:26:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DD7B381175
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792488399;
	b=FC0d0atVHGI+lMyFo2Sy4VrBGHm1oNcawLjJH+qajKQH0bXgQOPZ16w9hYtuuOiCBkZG
	 3HZYFfcpT2ISKllIYxtwgRA69K4D2hXt6WaR0q6y9VINPcJhLw9ot8x9vRWm1TIo5yA8i
	 kTbQkmsf9FoTXingA3M8iP4T/8LP36AJXbm1N8gUFHRO0bBDUF40IdkZZWdzJm8dEoSKl
	 EdYNHEyJ6er2DfY2JKjpkb0EYUHbkOrqnEAO42mFg99yI0Tochj9X+fgkBL2NHZ03D3s5
	 2TFp2aIWJFY2M1bZ3wNPlQTrq/uuQY7lTg33JN6C7CQyzcR4DMUvbpXAaE3Fyhi6tZA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792488399;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=i1mspC66eksRIUcLa/DwY3PoZAF4n3N0O8ag3Ghnrb8=;
	b=bth4RyZWB2onMFtONg7tm5hAZL4rNaL930CLTHlgOJzbeXiRF0dJOUyA1ukSiY5rEr8m
	 hYc3pnUsOToHclD/Z4Xacz6GqTBU51ukT7cvaFb5THxVXPe4pcf3i3QWhzy3aNw2te5Ot
	 zWdWDZVu8dSTIDOFy0HeoddqdJTfbkAeMhD6jGKcPCD+b/XTmkrOTiV3+ymhsNiu4gM6P
	 bGgC0PLFTqKn4Ln91/cQ13q0zz4GcbM8h7QM31MVRnn/PgRz3B1mEAzmXEYbwDTUcmYro
	 nLWiHtqcXyvPm0izUd7CDW/4LzOxkMcc2zslbkzEZAeJFaAGi2PAGS536JTuorY9A0w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792488399;
	bh=i1mspC66eksRIUcLa/DwY3PoZAF4n3N0O8ag3Ghnrb8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sCS/Hzx2KLpP/z3yHZpXzhScuYgHDMqydNacJI9UNxv7ku7KsSvzeavVoH4TPAgvs
	 8QqMpwNUgHXmtv98Qt35ORp00KvVjWIppNFwUCTitIc9ipFz4/gqqnMiQM58FPJKPi
	 TJEBxZWHvBL+pCwAXzRE4KB5yxheYXAosCYT5FXu/qMx/hNpI6vpx2QD5wllG2HSsD
	 4O8vk9b0RuU1UvLM6fYDfr4vcCahsD3J1BX4wqommnr2N9YdWS3gHzG5Pf836pruNI
	 ps/l7ZfmG7eDbKU+JEh6d95NHR1uck6PWzc8c6YaxjajXU9m3UpU59TBvTTZfquj6q
	 Q/JXwJkY5GnhA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DD7B381175;
	Tue, 20 Oct 2026 09:26:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6C0F71DE
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:26:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 524E640328
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:26:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zxmpAWl3QrgS for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 09:26:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 98CBB4016F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792488393;
 b=d2p4zoPlByn0e5wwRSr4A2GBRhXOHxQHfOY0gQJz/SQ3Xk3CAUROEbIo9y4f4ytc5zBb
 oWKzNFoDAMtLdTNwiXl7WRUd/S736A7nrImVoerV0HeKI/CIbJA57v2baluMaWEw81Rw3
 oLCX2ze7HKuJv1Ud5dtTk+sbvS377tx3HHRGLuLPQDFJJEVkdzdfWy2c87g/JDMxRFDWx
 3elNvtOXaJhZQXZM84yWSkkmZO5SfObDoJS3UiVkDoGIEfACNKupS8rwLOsR8CtnFhAuF
 OKU6MTiS6PJtXUMxvmAFhp6ZbV5rBL0Lg3qQSDaU/yKcEcff9TgHxgHYc2/dBy60AqA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792488393;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=i1mspC66eksRIUcLa/DwY3PoZAF4n3N0O8ag3Ghnrb8=;
 b=tUQ9ag1qbIh/dyWGaMpNRjyJF7fj9vausDpcVyAZXNkLU/DvZdDWGF1y45yAzA9TdcwC
 hM0cDiMjMLqqFUE9Sb+B1Xg1vosF6MKlqY4TbAtPlJzGF47juHfvTr0Zn17tu6MiThRTe
 qXmD6ONOux+N0tn/FTEH5K1ErReLoj8ZJ8MhMXw3ccSCFBIKdPF77Nm3k8p7CKUL8Q/AK
 A5GA2pPYoMYF0vY0+gD6nB3wQjYzPqriNW6MvCJA7o6KBQRNkv5vZF12WJKni7cgckhWq
 LoXRYOn/x4Kga1zrK7If3vtwSmgkFtyPOJEcY0N1EPedzVE5w7tnjX8+IvLYrlE3h3w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=erEs72oO; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=erEs72oO
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 98CBB4016F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 09:26:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6028743E28;
 Tue, 20 Oct 2026 09:26:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52741F000C4;
 Tue, 20 Oct 2026 09:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792488393;
 bh=i1mspC66eksRIUcLa/DwY3PoZAF4n3N0O8ag3Ghnrb8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=erEs72oO9V70hmgiR4l9zWrNId9SyV2Suc0ROo4ZUHoSmRTKwwRYTNnRe0+CDQ63p
 nrfyafYn+aj9KGyQ6DIqJjoyAd/8QsVqRvqlaac+eyTEq8LMKRlQPbL+eNkKuC6B3k
 BDLTAdq25CH4TnbrAiozZSVUJzifePo/qWK5U0qW7XhvvfqdEqvcciCsghlGaSkQyM
 oCb1DnMCrv6yGdwWGOi2gzUVxPyptrksxeuIoWoycLSaOo75q6BX2lFAhE4wFym9aZ
 h0fhG9YF9iVQva9IdCvj0qU2ZlSvkwa3/RGTYGBpHBoQGzr+hsFv3AiyZDA3dOyKbq
 7zzNHikNMZA3Q==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Tue, 20 Oct 2026 11:25:59 +0200
Subject: [PATCH v2 10/10] test/py: avb: Fix find() logic when matching
 response strings
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-test-avb-fixes-v2-10-997f8f04fd3f@kernel.org>
References: <20261020-test-avb-fixes-v2-0-997f8f04fd3f@kernel.org>
In-Reply-To: <20261020-test-avb-fixes-v2-0-997f8f04fd3f@kernel.org>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Jan Kehren <jan.kehren@emteria.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3113;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=F7PSW4AEQrvUskMS1SGvB/ILLTEpe5p2TE6Uzy6jSIs=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq1zOwWPj4MCQYdBO4WtaXjFPR8kQf6fbAyLJdp
 OpTHn5/k6eJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCatczsAAKCRAZDR20Zk4Z
 NVUaCADdlk/O56HENJfphepV3fTU6VfyUMB+glXzb2tQBzz5E3FvzqaPGgph4oKAbhkLYVFawiC
 iTwzlkdBck/GkgmRS9aXrN9n/iHsdQWJKdJuauzxNVYYY3riuOfzPhI5vsF6H7XKewuQVW6OlOX
 Ly8ZZG5sBxifqoEBSgsBHJ14g1NcRinJ4/4umq3o3C/QHmXQlJUpKW6JV8hoQitDTSdJX1X/cF9
 z81NgFflNZXtPT2XfprESuk03EDMboCagtdNKzslVCnDLSlGwHrTxNbgJJlIvCBPTDRIUj1DJTh
 yFPMqj62Z1cloV3dxZSf83l/ZIM6Q7+dXXj7sosYiL5cFS91
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The AVB test suite runs some avb commands (such as "avb verify") and
then parses the console output for success/failure.

It does so by using the string.find() function which returns:
* -1 when the subsystring does not exist
* 0/a positive number when the substring exists

For example, here is the output of:
$ ./test/py/test.py --bd sandbox --build -k test_avb_verify -s -v

Hit any key to stop autoboot: 0
=> =>  avb init 1
=> => avb verify
get_partition: no MMC device at slot 1
get_partition: no MMC device at slot 1
avb_slot_verify.c:644: ERROR: boot: Error loading footer.
Verification failed, reason: I/O error occurred while trying to load data
=> PASSED

Here, the test is marked as PASSED because assert(-1) will return
success.

Fix the logic to fail these tests when the expected string is not found.

Tested-by: Guillaume La Roque <glaroque@baylibre.com>
Tested-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 test/py/tests/test_android/test_avb.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/test/py/tests/test_android/test_avb.py b/test/py/tests/test_android/test_avb.py
index 48fa6ee7cf0b..b0ecb7deb1f3 100644
--- a/test/py/tests/test_android/test_avb.py
+++ b/test/py/tests/test_android/test_avb.py
@@ -64,7 +64,7 @@ def test_avb_verify(ubman, avb_device_id):
     response = ubman.run_command('avb init %x' % avb_device_id)
     assert response == ''
     response = ubman.run_command('avb verify')
-    assert response.find(success_str)
+    assert response.find(success_str) != -1
 
 
 @pytest.mark.buildconfigspec('cmd_avb')
@@ -79,7 +79,7 @@ def test_avb_mmc_uuid(ubman, avb_device_id):
     assert response == ''
 
     response = ubman.run_command('mmc rescan; mmc dev %d' % avb_device_id)
-    assert response.find('is current device')
+    assert response.find('is current device') != -1
 
     part_lines = ubman.run_command('mmc part').splitlines()
     part_list = {}
@@ -133,22 +133,22 @@ def test_avb_mmc_read(ubman, avb_device_id):
     """
 
     response = ubman.run_command('mmc rescan; mmc dev %d 0' % avb_device_id)
-    assert response.find('is current device')
+    assert response.find('is current device') != -1
 
     response = ubman.run_command('mmc read 0x%x 0x100 0x1' % temp_addr)
-    assert response.find('read: OK')
+    assert response.find('read: OK') != -1
 
     response = ubman.run_command('avb init %x' % avb_device_id)
     assert response == ''
 
     response = ubman.run_command('avb read_part xloader 0 100 0x%x' %
                                            temp_addr2)
-    assert response.find('Read 512 bytes')
+    assert response.find('Read 512 bytes') != -1
 
     # Now lets compare two buffers
     response = ubman.run_command('cmp 0x%x 0x%x 40' %
                                           (temp_addr, temp_addr2))
-    assert response.find('64 word')
+    assert response.find('64 word') != -1
 
 
 @pytest.mark.buildconfigspec('cmd_avb')

-- 
2.56.0

