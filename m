Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33169606A31B
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 13:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Gz+zzEBN;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dpW7hEMS
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C737E60A44;
	Thu, 22 Oct 2026 13:31:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4n5PUVuAAnB0; Thu, 22 Oct 2026 13:31:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B182B60A6F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792675866;
	b=Lcr6bjRTtk/cmgMNWBRx2tHORxM8HueC94FfHEP+JkMNhhDOyKzyblBXqrDdIp2IqzUC
	 7fivH56LLYINeuvqID5HrM8Rey+ADrm86GveoW29e4uF+jSQQttfZNwAgrbeT114/S8Fk
	 9xJx/PMO3LA/Lq/we6PQyhnF1YOF8MkrzOg3dXhSXjLkRFdKbGu5kluttl2c9SbAWySRu
	 +aOvqEF+lfE8H+1+cC6sEHIlgHxa7RKFvse/4uBphT4bBWoWFa7mpt8//f4LcvjyqV/25
	 Vmamyv+stahW7UntSHMb0XqBOSkt5uNRIIGgsqpTkjFdhOawgqHVC84jvSJh+D/eNug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792675866;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=A8GWsUeMs2BXowp8Z2T0AK/3ieQvXTdItTbW0Xi1WSI=;
	b=ADNib0RWss+11ubZ8K28n2TRf33oFC3DuLZOGzufRZLymSKDMxfgzS/i3gqpPe1iNgMp
	 GUug/F4MAmF83fUkCzAGCzzTYIS9zz4JtYU4Hj2t/27ltjsCsXjj8VvD2r2vTa9FIUrCI
	 1gEr5kHmNfZdnRwapE83zE5G5QkszlNV14PB0C/qOrAdGfnh1ZjxeRi9Bj3kiylDAqhC5
	 cqE+ozjm4XZ4ar62mVcs0Rvr7m569tF9TK+GwoFRLvjmFIr4jmbnwsP5gSzeiC7GRMw9/
	 wBwek6Zk/iCWuCOcn3U+wQm1bvF6qTH8zKysKxMGaPmNmGrk9m0vnv3yjqPO+IMLHoA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792675866;
	bh=A8GWsUeMs2BXowp8Z2T0AK/3ieQvXTdItTbW0Xi1WSI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Gz+zzEBNUKw8u9xZQsV61hLIXJcg8Wy6OqLySZOue1npS1YsLs/h0T5Y4K8SIoM4A
	 CXlEFUcvcajvjehl2x20+e/ifbLKESP73l02FvtbwPAS1bjS+tSI0BkrMuz4sCztrJ
	 GcoOl1hqBAVd8LBjTPYroZVNQEo4Yqu6/tMGk7tgkzmm8j3h5NhK5TsR8rBainhroF
	 2qByv45zaxzVUs6EFXUdAKrpcEUHcG0i5bddbT49H4jyoYmUiHEBDgaDlXMCXMMh/h
	 VjSTkBemGQQ2GRAbz/Mc2uhCt3XZfHfsXIAS9vBhrqBa+zENIsr7WGeB1z1eKHLW3L
	 ugCjdyo5pZtgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B182B60A6F;
	Thu, 22 Oct 2026 13:31:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 058423C1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:31:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E06718121A
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:31:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d_UaZsxWq4D0 for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 13:31:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 33E1D81176
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792675863;
 b=rB3dZ8Rmpa3mLNK8NN9UOX8cd7U9Hwt62CnGxHIaV4GMcUiw9N63FhJDh3Sme22Cgwcj
 KjozVy2jd9sYMbwnoxaf175mFv2VSaRfKRyZ9oGVgtIPBsIUtVzJLit9wjuv9G375x5Jg
 362prE44FS1lbp6kaug+p83hsJvqiHN/1zxuWrA9sPSFHFfu9CxCfQQagz0UpofM7RhBw
 U7IFc9NPC6TMWBZWP5NA26E/aGWzMtTtT6tDBTrUxtskQBcFxUDdvs0zH73YLFWZLk6Yz
 7YE4Pns2oR+48toAnWSgV9InZo1oFVwjCC42vZ+H59rv8Gu02c2MOQP1gEvQL0WAsuA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792675863;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=A8GWsUeMs2BXowp8Z2T0AK/3ieQvXTdItTbW0Xi1WSI=;
 b=YerDif569lPaQt3bqRAlGPowSDjNxBnfehkYxCPsivLVa0S8LxqBF3FH7yO0EBLHmpBy
 RMn97RDV+GlOb7pvKpNta1NdEDkPBhdPQcCQQ2B1YJo8lOrPEtvK4aLr9h+yRxQVbd6jy
 mLnuXfbKTW1IatwmktJb8GLhN0dS8GehLKsn+P2K1VCwV0FUNKds4wjER0Tkd3fwHmMNa
 6E6fQmMI7HKoQf0rrTUYPAvry5JCiE0xeTsg5gG5zNQaMy8tryi2tFvAtyTvhBKf99MFs
 XKMvPsMLqDlmzyg6SI7H5TQ86QZh+4FH4Q0FC28ZvGOl3lpsr2xEELSvjvBDoDu066A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=dpW7hEMS; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=dpW7hEMS
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 33E1D81176
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:31:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0446643834;
 Thu, 22 Oct 2026 13:31:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 670991F000C1;
 Thu, 22 Oct 2026 13:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792675862;
 bh=A8GWsUeMs2BXowp8Z2T0AK/3ieQvXTdItTbW0Xi1WSI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=dpW7hEMSpo+CG3OGkHPhqQj0zS19YO2IAst6W7u1Y1TexsmUyhrnH2RtJpvn/HPa2
 FRMD5LGMePtIWOJOYK1cMsPTT1Ayg/oDW1TabD7Bp1Fu2T7heg2v54/19YagGNXZEK
 6sUCGjwGhbTUJ9yop0u3lkA+Nddpnq1/F8mQdh290xQAECmEi0W4yIzmlVwQicogdN
 i1fenuEn90Is9nKJYj9Rjft3xhRgl8nbtw7kkTff4xSv8PBn8wxR9Q8v4DN1W3Bk+5
 G8rZdTkh2OJEeF2jEJEHFPi2CoCT6g+2v0x3kdU8DwSY/V/14mOaX2gO47gneO751d
 r58vw0kWRQkfQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Thu, 22 Oct 2026 15:30:39 +0200
Subject: [PATCH v3 10/10] test/py: avb: Fix find() logic when matching
 response strings
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-test-avb-fixes-v3-10-d3a6ff9ba097@kernel.org>
References: <20261022-test-avb-fixes-v3-0-d3a6ff9ba097@kernel.org>
In-Reply-To: <20261022-test-avb-fixes-v3-0-d3a6ff9ba097@kernel.org>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Jan Kehren <jan.kehren@emteria.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3114;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=LDFjlfvlclvFr6O6/tshc55XG9EMCdbRUEZ30mjozaU=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq2g/9JPg8YTaENw9Jinb1Ubsiv2NKWi7qB/p/m
 2ZXM0PdsZeJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCatoP/QAKCRAZDR20Zk4Z
 NbJzB/4pXsGRMEThjioPCj/O4+wSfEkxoaBHuGkh48PYnMI1GU+kqUQzDGPagTS+Gc8z2XouJcz
 cEtW0wSFGTyGU04nvXoL5n/yP93GA6xy9T9sTFz0ySbwwjCq44ppoX+WAP3QUpUW1LsJ92ipyj8
 jLOky2ZUETfNa2pGa5qp+NYyQlxGXsyfiuWENohwZY5SoWCwbYAqHCHvvO3INPvHHekEUne3QWc
 YXsQTFH4IOo7ZNjmxxXJxmpGcFhDw1P4oy1MI+jvvtVw++wR8ODZIDIsdRLFnO9gXsJZneSjufS
 9gHTQRl/ku1m5NhwkAQoI4DZwJOBjMk7xxPrIXq29miIK45a
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The AVB test suite runs some avb commands (such as "avb verify") and
then parses the console output for success/failure.

It does so by using the string.find() function which returns:
* -1 when the substring does not exist
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
Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 test/py/tests/test_android/test_avb.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/test/py/tests/test_android/test_avb.py b/test/py/tests/test_android/test_avb.py
index 9104cf6f37a8..70b2fec5c552 100644
--- a/test/py/tests/test_android/test_avb.py
+++ b/test/py/tests/test_android/test_avb.py
@@ -67,7 +67,7 @@ def test_avb_verify(ubman, avb_device_id):
     response = ubman.run_command('avb init %x' % avb_device_id)
     assert response == ''
     response = ubman.run_command('avb verify')
-    assert response.find(success_str)
+    assert success_str in response
 
 
 @pytest.mark.buildconfigspec('cmd_avb')
@@ -82,7 +82,7 @@ def test_avb_mmc_uuid(ubman, avb_device_id):
     assert response == ''
 
     response = ubman.run_command('mmc rescan; mmc dev %d' % avb_device_id)
-    assert response.find('is current device')
+    assert 'is current device' in response
 
     part_lines = ubman.run_command('mmc part').splitlines()
     part_list = {}
@@ -136,22 +136,22 @@ def test_avb_mmc_read(ubman, avb_device_id):
     """
 
     response = ubman.run_command('mmc rescan; mmc dev %d 0' % avb_device_id)
-    assert response.find('is current device')
+    assert 'is current device' in response
 
     response = ubman.run_command('mmc read 0x%x 0x100 0x1' % temp_addr)
-    assert response.find('read: OK')
+    assert 'read: OK' in response
 
     response = ubman.run_command('avb init %x' % avb_device_id)
     assert response == ''
 
     response = ubman.run_command('avb read_part xloader 0 100 0x%x' %
                                            temp_addr2)
-    assert response.find('Read 512 bytes')
+    assert 'Read 512 bytes' in response
 
     # Now lets compare two buffers
     response = ubman.run_command('cmp 0x%x 0x%x 40' %
                                           (temp_addr, temp_addr2))
-    assert response.find('64 word')
+    assert '64 word' in response
 
 
 @pytest.mark.buildconfigspec('cmd_avb')

-- 
2.56.0

