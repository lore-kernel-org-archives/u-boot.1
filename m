Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3303F606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 13:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=STAD/+xF;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KJWk6O2g
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0BDBB409BC;
	Thu, 22 Oct 2026 13:31:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Honuv8k0xgyM; Thu, 22 Oct 2026 13:31:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 39567409ED
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792675863;
	b=JRW4YHHBGtJyxUbPsJQqmnm81mGbs1I3YjOylocK1qmIUch2EzCz+XAOsZr/25lfDW1b
	 Zy1GvOVEp5d2NFQ0Qam8Ni+hyVjCDNhJCqif7ow1NNKNtW0/9rGNyIQfJJqEVDwijQcRv
	 cgCu6gctIjKwS1DK4TNPJqJ/8Hx/0udrYEJxZCw2K/xhyrBLYuwW/XqHb6MUdqzvA/zBR
	 kEmm9QL21Eg4dtAf6FA/k/5RsQuPTIcNM9ctEz6GLZeMdqyAi22i/eqY2l3jFob9lAp/D
	 GCRemLyBDpUojKGLN05FAyNgCIeZTl42VhQMqH2GAASoh/QUgkSvTilNz2MlTkoF/cA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792675863;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=f4T3kA9EGE84oLd3aK2bxqQnfKXNj0e9AiOkkAFZFXg=;
	b=OC57LrhDtcSCpN6433VWSTamp5BoOszLRPvTNmw7MKHpNTwuzGID7gLG2n7Il+UCyY1g
	 eRPSsQu0J7Eq48iOUR4JLnyAQ+2L/xBykNcv1CChNxNQ0CttPVOLwUJfACc+e1dHKT6Wx
	 iDcRlZCqly9cICQ1R3j4P/Ted7g30uctFtZ2EgNng0t+DlLBfMpVUVtCiIYTg7pzQIKma
	 CqiQhr7vm7WlPik2K5g+zdJUQvyi7NXaRBC6wx1FEfj1EqTkgKyaSoiTbvncTb8VyJpYv
	 T0Sm560r3EkHbQRsGoXChbOrSE3Pm9fcXOIxFSecn7My6VCQHWtgqOnLT7Tz1xugBNw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KJWk6O2g;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792675863;
	bh=f4T3kA9EGE84oLd3aK2bxqQnfKXNj0e9AiOkkAFZFXg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=STAD/+xFaetf9Lmc0WFSNQ6uIrjfTR5DjPUqFoAbyvi2gEmad5QkHdeJp9Wh0MF3T
	 IZ8HVyYXIpn86vTdKFqFtpWPi+AeRAlP2X1s8Oexbv2JIC1tmgXvu+LpaTVa9KtMO/
	 8u0EJJR063xpdth/IZbggjlapxeekpN6eskFd9OZfKSVID/jIjRB8Y4FhdiI541lfp
	 67+R/K8HMJF8brRoJVVDHTCcTRzJndyTeMdUXPRt++2WwbRAdwXUSTGzc8cMeoiGcM
	 UJwbHqzlCdRJfWVxpxukvkKntGEDN68iAH+bVMVQZdCJEJ6EWBDbYxCIvwJwn28+4o
	 1fJltNTaBKjIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 39567409ED;
	Thu, 22 Oct 2026 13:31:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 98B912A8
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:31:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 89B98409ED
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:31:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xke_Q-pRL_9n for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 13:30:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 06AEF409D4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792675859;
 b=tIYLpbeWbWwvAEEaKpBS7JArRGZINq/UCKfRms9Y3upQFPTOVOvaMFacjz1jgwR5nCx6
 b2SS/yo4fJJgPzFudPJG39r+yiyDoaaB0eIv6TktiTF/uCuCfi/HnM4mDvBC+sCKjPS6t
 m307Fv24l+LREFP4Gg+MA42m1p7g/XjXPEWRTj9CCxfXLK6JuVEuJHyEgd5AE/H01eGZc
 Q0oFuCaSyIXsNbCDHyUspM22+7W2JQZ2ss5NX5nbuqcV3xk4QhS0fVo6QMqRgAJxnXoFN
 us2FRAxu7S8I83f3f5oq3qjhMaBAn+XdJggBlwu+P4/D26jzrpwf3QZiJ0wZF+MTqHg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792675859;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=f4T3kA9EGE84oLd3aK2bxqQnfKXNj0e9AiOkkAFZFXg=;
 b=sMb9A5OG1Zn0bXhMvUrM47fCI1w7O60nl1Y55NwyZQv+kGEzi9SPD0FWit4T4/VjPhWN
 jLCwbQTPIsLFS2tzhKz7v9Fjh9GcEwQyXvvzuK8jEFrnUCunTbCvAbKutlKzbAuR1Jos0
 kRI+xHfkFR5YTFAEH/ilJzqkyKyOYBSKJrgWT1BaOcKdujGfuxo3b6xTOvMAbLDLzjs+I
 Ab1DPmnoM/R7ZCPqBh+OIjjNqTVE3Jn33vCFfgaDtBzXClwMMhpe/l+xVwYmZ6v8N3hqp
 LudYkrgu62pP2IONDcqzTpVh8EcszQN2VOfI6K7h4++UbzzINt/kj2Bh3Ay57/Z6HUg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=KJWk6O2g; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=KJWk6O2g
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 06AEF409D4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:30:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 721394484A;
 Thu, 22 Oct 2026 13:30:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6B71F000C5;
 Thu, 22 Oct 2026 13:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792675858;
 bh=f4T3kA9EGE84oLd3aK2bxqQnfKXNj0e9AiOkkAFZFXg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=KJWk6O2giOKopYl48a3zxpnn3GZTd09qWcrTaJndNBKBTkGQvuQvQ/JP5Vl7YUMxF
 YLQQ+GGwX7kBdfu7A19mj86NOeT3GzS/GkLXo1jO+yxiGuwD/4xTFbZEVL4xsHdGm5
 EUGKJLvulssDxVB9ClK1JSPmQcK1ceBRQDakTPcdf0WpnVVy5znVZnbIUTmgl3NaWg
 jsx2FTlhJdw0RB2H3zjWu8asZFcYkm5ZYrbstIrGthdPRpCeiK2Q3Iamy0IPoESxxE
 +NdXhobdZYsjj0Z4pXDW9swEmcCORJEPS60hxaqXGIp9yhaBuiHjpG6g8DhWr6fxJY
 gh0ommIVwTcgQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Thu, 22 Oct 2026 15:30:37 +0200
Subject: [PATCH v3 08/10] test/py: avb: Move mmc device number to a pytest
 fixture
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-test-avb-fixes-v3-8-d3a6ff9ba097@kernel.org>
References: <20261022-test-avb-fixes-v3-0-d3a6ff9ba097@kernel.org>
In-Reply-To: <20261022-test-avb-fixes-v3-0-d3a6ff9ba097@kernel.org>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Jan Kehren <jan.kehren@emteria.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4968;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=MwVik6EzvttZvytan1BkH1jRBBjcvviIKzz0rjqlJiw=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq2g/98Q6pKjv2F7r5nxQd4Jb7JJ0++9zKiRvlA
 Z7qsXhfOcSJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCatoP/QAKCRAZDR20Zk4Z
 Nd/JB/4qRgJedNZHSLsR/GclwFykdEkSY8wc5IR6COX5Kg0yYsMe7GDbo/LnEyGvzAWviwqY6zK
 OBlpc1VMS71ruQnb7ZKTkaAewlfmsKWBil7OwQGGsQ9aWcD+AbCJVkXMXAvpvynRezEzNfmiGlx
 6j1L4pPo3ftTVgJT4OwX13vNWblqRKATJV5NKVpRlZe7eLVkGZMhOBxWAUcLdg+xyqwDAcf/yLs
 WBbE++5Cbnx2Y3dlwUDD2Dbi28aY1mIGeqNlNOldWqvh5lRTpzC4GpO4MTBrzx9U4obGb/CfjZd
 8RNMLwVFZJo+OPrKdOxiPFg2QrSZ9BhyB0X0X3d6lagRaXrl
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

The AVB tests hardcode mmc device 1, which is usually correct on real
hardware. On sandbox, this is not the case because mmc1.img contains a
fedora image.

Replace the module-level mmc_dev constant with an avb_device_id
fixture so that a subsequent commit can override the device number
for sandbox.

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
Reviewed-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Tested-by: Guillaume La Roque <glaroque@baylibre.com>
Tested-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 test/py/tests/test_android/test_avb.py | 38 ++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/test/py/tests/test_android/test_avb.py b/test/py/tests/test_android/test_avb.py
index c66ef0cc52d5..34cddc485ebc 100644
--- a/test/py/tests/test_android/test_avb.py
+++ b/test/py/tests/test_android/test_avb.py
@@ -16,20 +16,26 @@ For configuration verification:
 
 import pytest
 
-# defauld mmc id
-mmc_dev = 1
 temp_addr = 0x90000000
 temp_addr2 = 0x90002000
 
+@pytest.fixture(scope='function')
+def avb_device_id(ubman):
+    """Returns the device id number for AVB
+    """
+
+    # default mmc id
+    return 1
+
 @pytest.mark.buildconfigspec('cmd_avb')
 @pytest.mark.buildconfigspec('cmd_mmc')
-def test_avb_verify(ubman):
+def test_avb_verify(ubman, avb_device_id):
     """Run AVB 2.0 boot verification chain with avb subset of commands
     """
 
     success_str = "Verification passed successfully"
 
-    response = ubman.run_command('avb init %x' % mmc_dev)
+    response = ubman.run_command('avb init %x' % avb_device_id)
     assert response == ''
     response = ubman.run_command('avb verify')
     assert response.find(success_str)
@@ -38,15 +44,15 @@ def test_avb_verify(ubman):
 @pytest.mark.buildconfigspec('cmd_avb')
 @pytest.mark.buildconfigspec('cmd_mmc')
 @pytest.mark.notbuildconfigspec('sandbox')
-def test_avb_mmc_uuid(ubman):
+def test_avb_mmc_uuid(ubman, avb_device_id):
     """Check if 'avb get_uuid' works, compare results with
     'part list mmc 1' output
     """
 
-    response = ubman.run_command('avb init %x' % mmc_dev)
+    response = ubman.run_command('avb init %x' % avb_device_id)
     assert response == ''
 
-    response = ubman.run_command('mmc rescan; mmc dev %d' % mmc_dev)
+    response = ubman.run_command('mmc rescan; mmc dev %d' % avb_device_id)
     assert response.find('is current device')
 
     part_lines = ubman.run_command('mmc part').splitlines()
@@ -70,11 +76,11 @@ def test_avb_mmc_uuid(ubman):
 
 
 @pytest.mark.buildconfigspec('cmd_avb')
-def test_avb_read_rb(ubman):
+def test_avb_read_rb(ubman, avb_device_id):
     """Test reading rollback indexes
     """
 
-    response = ubman.run_command('avb init %x' % mmc_dev)
+    response = ubman.run_command('avb init %x' % avb_device_id)
     assert response == ''
 
     response = ubman.run_command('avb read_rb 1')
@@ -82,11 +88,11 @@ def test_avb_read_rb(ubman):
 
 
 @pytest.mark.buildconfigspec('cmd_avb')
-def test_avb_is_unlocked(ubman):
+def test_avb_is_unlocked(ubman, avb_device_id):
     """Test if device is in the unlocked state
     """
 
-    response = ubman.run_command('avb init %x' % mmc_dev)
+    response = ubman.run_command('avb init %x' % avb_device_id)
     assert response == ''
 
     response = ubman.run_command('avb is_unlocked')
@@ -96,17 +102,17 @@ def test_avb_is_unlocked(ubman):
 @pytest.mark.buildconfigspec('cmd_avb')
 @pytest.mark.buildconfigspec('cmd_mmc')
 @pytest.mark.notbuildconfigspec('sandbox')
-def test_avb_mmc_read(ubman):
+def test_avb_mmc_read(ubman, avb_device_id):
     """Test mmc read operation
     """
 
-    response = ubman.run_command('mmc rescan; mmc dev %d 0' % mmc_dev)
+    response = ubman.run_command('mmc rescan; mmc dev %d 0' % avb_device_id)
     assert response.find('is current device')
 
     response = ubman.run_command('mmc read 0x%x 0x100 0x1' % temp_addr)
     assert response.find('read: OK')
 
-    response = ubman.run_command('avb init %x' % mmc_dev)
+    response = ubman.run_command('avb init %x' % avb_device_id)
     assert response == ''
 
     response = ubman.run_command('avb read_part xloader 0 100 0x%x' %
@@ -121,11 +127,11 @@ def test_avb_mmc_read(ubman):
 
 @pytest.mark.buildconfigspec('cmd_avb')
 @pytest.mark.buildconfigspec('optee_ta_avb')
-def test_avb_persistent_values(ubman):
+def test_avb_persistent_values(ubman, avb_device_id):
     """Test reading/writing persistent storage to avb
     """
 
-    response = ubman.run_command('avb init %x' % mmc_dev)
+    response = ubman.run_command('avb init %x' % avb_device_id)
     assert response == ''
 
     response = ubman.run_command('avb write_pvalue test value_value')

-- 
2.56.0

