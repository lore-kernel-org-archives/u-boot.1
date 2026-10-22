Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ED3606A31A
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 13:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DA1GikSF;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IW61BP7T
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 32EAE60A3C;
	Thu, 22 Oct 2026 13:31:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yNX_QDVCfVkg; Thu, 22 Oct 2026 13:31:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EA85F60A55
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792675861;
	b=ODKDZ113qDAeR650CoQ00rw+1hRwtzzZscM2XRhT1NeOKC5gX4KKqWxvkKqfS1wKs0Ce
	 6oj9P79nKZHksnQrWm3ncuslnEpIhzVvbF2j6JCwdl0GYFn8uYOu0vlyRlDMFT7AtHOnN
	 V4ZT1ccrY702pQbPNqK4SnPFg1IF3aUTYo8uhTe/J7UjIbJG2tPfCi/YuaZLyJ6dKra85
	 DuL/2KDqq8LVFTjqXG8fJS/A622vSNbg9FFKhY7RGAH1VrOgZBLJ8sordV2WkVusqISFA
	 HSKIxZyzryOM53eoNYkcNzzH6k136RkXFh18/WNrxvvTWTsvl1MB8Oltq6/PK/chEtQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792675861;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zX5tcWxYl0EZsxONCmcd1h4mB0/EbJm2IgG2ub/tZ4Y=;
	b=HhOsKiQs5byb5W6UmMwd+62e5IojhpYw6nbQBfJPRiTBUmd6JeBL+ykZlixMpQu2P6Sl
	 goqfiU5E/1WTiz7fy6giZB7qExqgqOrC4mwcpQZ3iFA5NVT/5W4KSFKh5qdXl+Ja6nlxl
	 11pEQyK9dFNrxsY5xSr5tcWIyGUXPgDQmp2zDQdYCWGWD3sx7Aa/eD3hzh8vS1k9GgZx2
	 Ac62oxzwXS4qgBNR/h9jP3umdId4Yim/U9RQxMaPGNOdmevHAwzbeWuhxyTiR5mX2WeuP
	 WD6Zl8dKod5PCbPplZXg+eR/NKtHjwTFjexNiJ8+kyrrABNuihh0DB+Bw8VJZyzq9Gg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792675861;
	bh=zX5tcWxYl0EZsxONCmcd1h4mB0/EbJm2IgG2ub/tZ4Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DA1GikSFlL4UUct5Hwkpa6k4qnOPL7FDlnAOVHwIlq5OM+khByG2v7s3AMnrZNDp7
	 SVREAizwz13aG2Oq+vqmQE2i2SwYKfK//8RW3QrNotHDuUCcdfjDHtXNtoBe0OG2D5
	 k1kza1uozSsamILU/p59Bh37PYMfIRDbBGk/b5JJMEMm5BBwHn1wXMJ/XDiXyop7VK
	 5VC0hOdXxRpI2KCDXrOYJnq7v6NrE5gEhXMmimhHODuXSLLtGKjMStypMqYp9itUlz
	 SazEy6s8YrgWck8JmYmPWKPSp69RYsIRzEBzPp7ZF7MeHYYfQr+5qA61PDbTL3pUzI
	 8+S2nOqDH2zXQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EA85F60A55;
	Thu, 22 Oct 2026 13:31:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 58B7B3C1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:30:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4AC1340086
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:30:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tBqcijKHqRBk for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 13:30:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8B16C40421
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792675856;
 b=tbEVoceiAWVdsa36nz7Iay2oakFNWP1VmIAtD/CFtzy3WMEUYy4ysAhJPjZ0xcCcfFxJ
 w2wvAJSf6SweVq9uRkxFzYR1aeg4YRDCOZVKxr9750aJCHLeV4sYYyGXxES3/nf8bwuC7
 WE7LeQKRycWOrVZ9kivSQL668TL/haJlQpzRp4HZsBEXBGZhBzI45Z1/Uof6O0Nj3Ph/1
 UHcGfINx3iU1KKIxxHxLQvT+HJH4EYQLkYwMYLBPutEoTGNI+BMZL5syczq2rfG1CywmB
 KCsEMe25WG5mjs3jzZhoJb9rSJ2dpW3Abn/KzDSe1LU3LKH3efJd7X23Jv9CPntHE4w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792675856;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=zX5tcWxYl0EZsxONCmcd1h4mB0/EbJm2IgG2ub/tZ4Y=;
 b=r5lSpPtps7CtKa6/WAICmGuwNIu8xg3v6/sqd8JDJ5lki4ALoZ6KHGfyZCURBohJdx4M
 Rm5w1zGO70S3z5Erv2QqEfw/3W7GjR9w3cIfdMhI1CdN2TQ3g9ycdP12QXjpWUXskxuY7
 NvYHyECM0wKWMkFrXmVfzHWkSYZVXGUutIR9JnLaxcYZaGcUXbA2G1JEFmypm4VbjEA6K
 jCgWk5WoPYv93S+/mITOirCGauMAj2oyTO3s8s4DzRa1FY5/p9eq/a3487H18Ju2TIbhw
 Y5OMvNXSdW1dag8j6ecTHTNG0kifN7QDbo5/4DRCFH/MfLe14QBRpVqPGVxM99HKF4A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=IW61BP7T; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=IW61BP7T
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8B16C40421
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 13:30:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 268B940944;
 Thu, 22 Oct 2026 13:30:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB121F000C3;
 Thu, 22 Oct 2026 13:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792675856;
 bh=zX5tcWxYl0EZsxONCmcd1h4mB0/EbJm2IgG2ub/tZ4Y=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=IW61BP7TFrShXZgnnDrmvxWWllyPOy/h/42oh+aUe9PXIv3vLqTdsqEj8D41Nxrpy
 9yQ17xHIKuNkQoKmgcql5fVvBv575cgfO8JAExtfBngp5hSn/e343+w4GvN1tIA9o3
 9UK98NXMmPkERUWnRKa7+6zWpItSzLlA9ahzCOcpTmiepnw5050GTZLVECp1oMTT5c
 soLZ58vWYIPaMo4q9JcjMTn4QA4ac5JKxa6J4RrxNsQxDfIXf3tvyyYyw0Mq3x57J8
 swKEZ0tMJeNepdDIGOJC6q9Bv5mK/TiH6N/m45g0F4duWreaDmxz/P0I+Fikue73ZT
 o+SHMC/ikTw/w==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Thu, 22 Oct 2026 15:30:36 +0200
Subject: [PATCH v3 07/10] test/py: avb: Use format specifiers instead of
 str() for mmc_dev
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-test-avb-fixes-v3-7-d3a6ff9ba097@kernel.org>
References: <20261022-test-avb-fixes-v3-0-d3a6ff9ba097@kernel.org>
In-Reply-To: <20261022-test-avb-fixes-v3-0-d3a6ff9ba097@kernel.org>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Jan Kehren <jan.kehren@emteria.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3720;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=iFJfoi6kRluDPTW6Dw+Rv2aFyi9K17kT0wphei8egyU=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq2g/9rYE1Zv3xrWsE1OPPwh1v/UJAT9PKcM+K6
 FoIpVtWIaKJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCatoP/QAKCRAZDR20Zk4Z
 NSkwCADKw5g+BYfino8xRlSYgwDXvISEw7FUGJo3SYDV2xK2G4Th+/prnOjQvV7xMHfAvQbWqx9
 rIexmbkv0h7odjgsSTj1iAP9xKGHFch+0TxmCGH019VtAZ22/xFzQpzeOG1gIJOH59j3bOCTWYt
 hmGsQyrVmjY28ZvQYVN0Y2N4PnXkWhFXqLzmQCQw1yXlOKvFExRQFZJSkyxGCBfR7nFewDWxBX2
 ZH3qvOYu3Snxz3LG2iFbcS28CQhuqNfx83UH1pxt7MqlM/ilKHfs8S6uPQmkBReYhgj8iMCRO/E
 B2Sm+kgXxJ7vqO6XLnwLFt71tg1rhhQuPhLXijTzHjhBhgSP
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The tests format mmc_dev using str() conversion, which produces a
decimal string. This works when mmc_dev is 1, since "1" is valid in
both decimal and hex, but breaks for other device numbers like 12
(0xc): str(12) produces "12", which avb init would interpret as 0x12.

Use %x for commands that parse hex (avb init) and %d for commands that
parse decimal (mmc dev) to format device numbers correctly regardless
of their value.

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
Reviewed-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Tested-by: Guillaume La Roque <glaroque@baylibre.com>
Tested-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 test/py/tests/test_android/test_avb.py | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/test/py/tests/test_android/test_avb.py b/test/py/tests/test_android/test_avb.py
index 137d83e1deab..c66ef0cc52d5 100644
--- a/test/py/tests/test_android/test_avb.py
+++ b/test/py/tests/test_android/test_avb.py
@@ -29,7 +29,7 @@ def test_avb_verify(ubman):
 
     success_str = "Verification passed successfully"
 
-    response = ubman.run_command('avb init %s' %str(mmc_dev))
+    response = ubman.run_command('avb init %x' % mmc_dev)
     assert response == ''
     response = ubman.run_command('avb verify')
     assert response.find(success_str)
@@ -43,11 +43,10 @@ def test_avb_mmc_uuid(ubman):
     'part list mmc 1' output
     """
 
-    response = ubman.run_command('avb init %s' % str(mmc_dev))
+    response = ubman.run_command('avb init %x' % mmc_dev)
     assert response == ''
 
-    response = ubman.run_command('mmc rescan; mmc dev %s' %
-                                          str(mmc_dev))
+    response = ubman.run_command('mmc rescan; mmc dev %d' % mmc_dev)
     assert response.find('is current device')
 
     part_lines = ubman.run_command('mmc part').splitlines()
@@ -75,7 +74,7 @@ def test_avb_read_rb(ubman):
     """Test reading rollback indexes
     """
 
-    response = ubman.run_command('avb init %s' % str(mmc_dev))
+    response = ubman.run_command('avb init %x' % mmc_dev)
     assert response == ''
 
     response = ubman.run_command('avb read_rb 1')
@@ -87,7 +86,7 @@ def test_avb_is_unlocked(ubman):
     """Test if device is in the unlocked state
     """
 
-    response = ubman.run_command('avb init %s' % str(mmc_dev))
+    response = ubman.run_command('avb init %x' % mmc_dev)
     assert response == ''
 
     response = ubman.run_command('avb is_unlocked')
@@ -101,14 +100,13 @@ def test_avb_mmc_read(ubman):
     """Test mmc read operation
     """
 
-    response = ubman.run_command('mmc rescan; mmc dev %s 0' %
-                                          str(mmc_dev))
+    response = ubman.run_command('mmc rescan; mmc dev %d 0' % mmc_dev)
     assert response.find('is current device')
 
     response = ubman.run_command('mmc read 0x%x 0x100 0x1' % temp_addr)
     assert response.find('read: OK')
 
-    response = ubman.run_command('avb init %s' % str(mmc_dev))
+    response = ubman.run_command('avb init %x' % mmc_dev)
     assert response == ''
 
     response = ubman.run_command('avb read_part xloader 0 100 0x%x' %
@@ -127,7 +125,7 @@ def test_avb_persistent_values(ubman):
     """Test reading/writing persistent storage to avb
     """
 
-    response = ubman.run_command('avb init %s' % str(mmc_dev))
+    response = ubman.run_command('avb init %x' % mmc_dev)
     assert response == ''
 
     response = ubman.run_command('avb write_pvalue test value_value')

-- 
2.56.0

