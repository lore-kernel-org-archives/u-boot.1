Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4DFCC6B3A
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 13:55:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B5DA760A9D;
	Thu, 15 Oct 2026 13:55:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QRN8qsQJrJue; Thu, 15 Oct 2026 13:55:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C1C4D60A98
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792072535;
	b=Z5EG5ZFmNKEU4E9NK8lO+Y36n0dEE+IGPL2a6kAXDtFELMRhW8ea91i9k1t8Laxu7xo8
	 n2F0YfGbLXdp5CTbQUxDmvoSvBA6Nhx44FXvmxpgFtZgkzaBzWdn2SKzMmRieazLva4dA
	 1fRwj3Z37lNm+br6+X3tGrHZqK8IpmXu6lmULasTJoJprm0E2l/OVYhPQZTsHWVu6WQGJ
	 V3hdfWRBE6NAH7Ikdq7d+UKVC2EZowkkIhfPaa+6RpA0F9NoWE/OhM/PiBz7LzT9EO2Ze
	 VwTEBbysPbOyppY1NwuKPtTxLtJg0DrhQhwgXC44X2e9P4bTjUi6JqnQUU21EzEltVg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792072535;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=afPwSjPNEqKRCvLKTWiG28yKbjGVnekRIO4Q7EhOXRA=;
	b=SbPQwRpSP9vZBtKxw85UfKAaVykzyTOct+kKQGEsNQu6ZrS75ffHJrcKe2cS+bd3Dekk
	 GqgA/5dCXiIgZbhtUxpzaOpb6huFxPuq0UZoXsCHTnJAdq8GOSCQBJR7lnJsdYFzuThSj
	 QMs8+Uznw0RGBYDw3R0xr8Bf/5G0na6HfOWLSABQSUeVPsrL7fa2SAe61DvnCerMWxygw
	 C9rg8JRxi2qUG6s8vv4r/q7iU7XPedo3jgK+iJ12LCszN/YcKP+UPdW8R5nLA93VfiTSa
	 JZy8dU9vZZFu6LVEelYuQ7HoZXeDlWA2tMmFjRP3VG2Nfl7erbvkGqiuTQMTAqBJesA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792072535;
	bh=afPwSjPNEqKRCvLKTWiG28yKbjGVnekRIO4Q7EhOXRA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AFu9JNL1S12o1MdqgpSD7zDkFllwJEfBS/nVVuMSxg249Jq9i8hCxBjJp+2GMlcHR
	 JMInIYcY3v1JFyFdRhn9QyqO7SCuCI63nWD+Jvyqb/mJHwfqSI628G3HVJkMQVmuop
	 HCmhI2tL5DGFjIP0MJOX7eECf9lAqAxM07UVCAZOuF32AFM2umPtBtkedG25KyC5cp
	 /OoHiqruxidvy3gBzuwVWa56kxzZH3uzq7fgjdZi8hvbHAaEbm1g0qpKNAXAx6pvar
	 aNGQR2707K+hkR1wGQzj7UOJp6/qpHDQmJPWRvyUrdGj/G4vNVMUWd3swD4R2vXizf
	 iISHsgvsixn5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C1C4D60A98;
	Thu, 15 Oct 2026 13:55:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1455D2E0
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 13:55:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EE6D540404
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 13:55:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wb_bKzLrzAJW for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 13:55:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4B2A1403B0
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792072532;
 b=UL0a/4axywV/gqnnLPzdYK/db9W4/PEOq3wobNYBeUpsmFpv0IuW4tv6sLt8JaqKAZUz
 xzNUNg2v2RZW9lwGwboJvPY0JBtVXVnjweSELoGEARcKyQ1j0R1wksQoS7G0y6PMdFtGh
 Vvh0lEMws1z2sCTncY++EwUohf4jc2ya4zK7Hhdc8c75fehwQ8DJTum1qDze8YXN8heQ+
 YGLtSG6FNpviuWy47iapDSFirHs0Cfd5MiMoG4TS4JQkC18Xs+962GMTLlxNOJh2c0rdK
 Qqd2jwXktNtdRZZVksF5SBoe/dlp9NB/d1fP2hAyyC8h54AZRA9RGeX82mcIivLIqOw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792072532;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=afPwSjPNEqKRCvLKTWiG28yKbjGVnekRIO4Q7EhOXRA=;
 b=Ixu6vSB/EWft+6N2qfIbLkcWXwGdPRYZAN352FmLLMvSwl910KuMBA8aZyamVpp5co6f
 tdbiNCZ4JJXXRCv+DeT79wAmqAyknQgq5WOofH2sYlRI6iWj87SkiuRF+0eBeQrgN45pw
 8kj0BSeDQ6fB/0zIvDjIH6/t5cEhpC09m4SUdXq9KqIleuqEvD8OGBC2fCFpYtqP2qJbP
 HbgaKh/08QtJDc5M2p2i5/tDW9Xu/6upwhkFKXZWL3+i1bFs8bAJ+LgzuDBecNadJoU2T
 H8DcaNpmh+K/MlP5ZKssMIk43HtEu9xEHV8GqfXF644fPwUks1geLVPu9brz0qdyE3g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Yds2d2wM; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Yds2d2wM
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4B2A1403B0
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 13:55:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B623D41E60;
 Thu, 15 Oct 2026 13:55:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 224471F000C5;
 Thu, 15 Oct 2026 13:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792072530;
 bh=afPwSjPNEqKRCvLKTWiG28yKbjGVnekRIO4Q7EhOXRA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Yds2d2wMTqZxoy1YBE942TvkmoG6iqcESJGUdz3Imknhe7fPiiubVBgjqzHEDPum6
 rddOnFwLc1shKVr1VZu1S63Db1r6SEP1BQ0I1WZ27mL9Wq0RMRuKS+8DRRzNAjUU9i
 MIerumxXJIgNsNGpcyn8wdOfrFAD9/dx0eo9a6y8dBQQGnmiGl+4FbPIGpsDVktEE9
 VkGXQKgDozEQlRZ6I9P7NPvOn7VX4eSfIbDfxFU0wOVnkGogm4RjWtWTlFXQGfdV56
 bAWwb9oHyU8bWWi8fXiwxyT8ct1H28i1JK30Jtj9SKwPg1BW1loOdwleaxPqa8L0Pb
 +FG7rfr9CC2Vw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Thu, 15 Oct 2026 15:54:57 +0200
Subject: [PATCH 07/10] test/py: avb: Use format specifiers instead of str()
 for mmc_dev
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-test-avb-fixes-v1-7-9e5b82644359@kernel.org>
References: <20261015-test-avb-fixes-v1-0-9e5b82644359@kernel.org>
In-Reply-To: <20261015-test-avb-fixes-v1-0-9e5b82644359@kernel.org>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Jan Kehren <jan.kehren@emteria.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3447;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=jwSQqx4NWinM/E6e6Da0QTQ80L9QLl5OsdOhQYG1Qmg=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq0Ns/6Cj7OLqSSetHUs8M7wnIAXJA22zOXCFtT
 6te35/Y9bKJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCatDbPwAKCRAZDR20Zk4Z
 NbqnCAC17T8Caidb9fpMcii2h+TjMAA5iifjKe0y9LWSHXYo1eCQd0NgqnMMyQQVPWTPZlJqgs+
 dzxyWohVlK0xnIGoK+Uxe6JWcsuv/XUG9vB03DfGmTBuErKyyaZuY/L6gDNfwSLj+SKOHROyCy1
 2Atj4Ku/OtYZxKoRLUQ7stmn6vsuW1y4sL8bZMPJS7M13MQGVWWzJYZquBxAu440vvc7DyMEItu
 pS2MxRHJOxrMoMSZBWX/VSiC6u4upiBZ6qqNDz6kDhkHOu6J+Apn9y6KhNtBCslcVHphDeAyAA1
 H2xG2y4R5wsxb1ABzadS8YCYVO6kr8QpYlUJBY1qE33M9Eco
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The tests format mmc_dev using str() conversion, which produces a
decimal string. This works when mmc_dev is 1, since "1" is valid in
both decimal and hex, but breaks for other device numbers like 12
(0xc): str(12) produces "12", which avb init would interpret as 0x12.

Use %x for commands that parse hex (avb init) and %d for commands that
parse decimal (mmc dev) to format device numbers correctly regardless
of their value.

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

