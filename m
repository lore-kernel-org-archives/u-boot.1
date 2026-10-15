Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E340CC6B34
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 13:55:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4736A4092A;
	Thu, 15 Oct 2026 13:55:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i5LkGc6HdjUo; Thu, 15 Oct 2026 13:55:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7A50F40927
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792072537;
	b=p27plBGTfYsJZCk4QAIBK9/ljapBx7q4Ciw/LRrLCsXbLRDSmUBzUIRWRVlprIrp3ZxI
	 qJIIiU+aTBK/EUMOMn1SoSB3qlbXbPgupraa33d3c442IVM/NQhNQ+bTYcNJ0UZcHTyzL
	 a9a7Bt31e/Ez9HzSKG9mchlXfYPiBTX4SBdOxOLA6BttI+KefqKRdaTvQUc6Io+KPBlGZ
	 yaNT/5b/VDW1jEhKymx5t3D6a9bI9/HlWam235YB59FFC4hs1896PlBZl9fs+vb9E2ssY
	 jXYeEDQ5hLa6eu2l7M85N83f9KJzQnS0VP8eo2xsuq8etyAFVzz5PH4PS6GAjfM7uYA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792072537;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+GAxqWkRZd/gFE+OQP7u5uRf1Re723IBOpjuO8UYFSA=;
	b=RC3edg4UsYJirt10kPwVq2VjC6VxoPeKtNmDbOsrqFLMl/P2Z9RCRFpEpbVrmZVbjc6O
	 iMEYXb2Ax0BdcWP7OIOvhIzJPPstj2hsVIfub2HowCIBUod2A1Of78Pks6cONqKqBgI9F
	 XrdOcTMLfNDIocU3LYvgBZxFM3148VM9rikMVOduJIXePYBRgsio/elmwHFQU95qmKSMa
	 WnBNXZnW0paPuB2wOvWSK7sWAjqjxGCbvSdewY0qM32aIrc1++BJS1zNv+hLsVeKEo37s
	 5xW6XITiUuDcBuk6yD3pnSWHUU204PN75y0ds0YVrNs+U/cYra3R7lLgZlPZQn3wbtQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792072537;
	bh=+GAxqWkRZd/gFE+OQP7u5uRf1Re723IBOpjuO8UYFSA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FNoPvUOcrtkk5OFiJx8LGPzAirFXKZxdFH7qgqq85ij9KEHt4XshgEgbzmAQIRe/f
	 Gu04BI8jzNdYLiyXD4tlEXULYG4fv+ra093liaTNJfFonIHxQgDiUlRdIEqH+5UwZ3
	 291TETpCMv7MamQVCsdoT8smw5MDCmdzWLtViJBOsDLI7NVy4GCALenf2DXm4KQd2P
	 mQWxpGMQqR9tKkMBF/+IFp+IqT+5wAO3D1ZGHe5sGza6SREpRI8vCzlPtr8i632MqD
	 jCa7PbJ8cmrl+UZ9LxbChlFR0jWhWX8GZPr6nI3u7LK3nNCuYolnFIq4oG7yH3MuSD
	 pN490QbN1dB5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7A50F40927;
	Thu, 15 Oct 2026 13:55:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5DF35235
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 13:55:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 43E068125F
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 13:55:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sqhfGdKbMquE for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 13:55:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6B13C8125B
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792072534;
 b=fY2HiSwNWa/wyeowwFHAO9sUFGS/Qf9WzhnwsJFET7uhZ0Eoe2s5Q8c7PInUAKf+0xj7
 VkEPmD3pHUXVErWfaC43q4R6Zo8oUSmK1/q1lNPBo7K+VUh275K586w5P14WlkpUOD3Hv
 xsK6WZWkaNDzbQTqVAY9/6D2QaVhITFtxug/AUEnRknjzcxfhET7Cat1GE8UX2J7yJf/K
 bvGI/cR1sK/+AKzkpNr6uR/N+l0VIc4GgW2+YnhiySpmyHZxQNFV7uud23WnNyg9urYo/
 A6Xhfv1u4hjfBoU2zfNfXUXr+NF0UQb8ZxQBXlTzcgDfW5UkJJo1bqThilzqOo7Xhbg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792072534;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=+GAxqWkRZd/gFE+OQP7u5uRf1Re723IBOpjuO8UYFSA=;
 b=Vrkk+TQTYIyhlxVzLnFaol0ZWBwacvIOtJ1HitRDSVYL2+rm5VfmXJC2LxZF0SWBxHNe
 I9GkuJhc8ClI76zJwLsEa2dT9UK6OFRbBW/+5hDJOXhV05JaIPNV3eFiulx0Qp++q1hy9
 +ZTQhDG7cRKuqZpyv8t9j/zDr7m5yZEQEX6/S1fAC2Fg8s55gK3yiqx/vjSwcWN1Fyg10
 yquGO9PhuCokR5KDNSse2Q3B8WQxhUm1Y6MPKl2jGKnoNjbBw5qC7jHYuX9ShHmiYSiRb
 9kcK+o1yIvHoOTXpa8J4BrtKpiYEoKETz0yRcUr65M6KPKULcUi8n4yVHuuOVSzcJHA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=WzEDnFwI; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=WzEDnFwI
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6B13C8125B
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 13:55:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2EC9A60200;
 Thu, 15 Oct 2026 13:55:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B831F000C5;
 Thu, 15 Oct 2026 13:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792072532;
 bh=+GAxqWkRZd/gFE+OQP7u5uRf1Re723IBOpjuO8UYFSA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=WzEDnFwIqiMg2R3ouOI6e0QmiR6If67c1TNR/LyubId6gUgbbradjZL3RMKj6UIc7
 3W289i5zlpAmtyTmmgcHz4H2DPUBISMJwwhsWYNH8m6ub04fPUAYpKO4Y7wVZ3YNm6
 /3lGCaf4d/lA6IcojkGL6EoWOif/PauDIwXHWiABXY/Brcl9zbCwLYCthEq0hLvhL+
 BvG2TItZDeO+jEpD3IwmNWrmKAORx+bSe5hWuY/xd71IlB+dUy4IpNHLRMY/Kh0Rxx
 7tUdzuEqCAF6IO4Jah9y0hlRLCm/nXgckUO0LkF275UuWZevmD176XMsepttiVWgSr
 1rG2CqathLn7g==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Thu, 15 Oct 2026 15:54:58 +0200
Subject: [PATCH 08/10] test/py: avb: Move mmc device number to a pytest fixture
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-test-avb-fixes-v1-8-9e5b82644359@kernel.org>
References: <20261015-test-avb-fixes-v1-0-9e5b82644359@kernel.org>
In-Reply-To: <20261015-test-avb-fixes-v1-0-9e5b82644359@kernel.org>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Jan Kehren <jan.kehren@emteria.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4695;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=KxfpSJDFsLh3XA5uqU/bP4cs1vSgYJmFemJchFaM0yA=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq0Ns/1InKzFQ//QwY762Nv9WRITxkqh7OjDetJ
 lXCjlR1Jf6JATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCatDbPwAKCRAZDR20Zk4Z
 NWviCACpwM+i9yfUGBeZtJFOmIIBA9i/s4wxPMV0dViJM+AwHNaqgkrDdYgih3m4EvZqxyyLPHD
 pkyCtaQGLfIuJdKbdiRQ8lxHcv68t22xSL2zqqGSCh0m40S6Qa+lLz21SDbVUlAORK9zW5PKJte
 IKyQ8cfteywoMjU//XqdkePAOPdq4bRXM1PD0eoQb67tLR16hRvMZB+JR1kJK2zWaeNAUQ7TiNN
 n3huhh/E2nZ2WtsyuR8LewXbmrcYRnxaAIHQTTZQgiKDacY0/WQP+NUzTlfn/n4teTEs2oTltp2
 dzTvvYSC2DEHudRk/feZhxaTN/iQpuItzcwqA7Kp+kfI8Ijk
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

The AVB tests hardcode mmc device 1, which is usually correct on real
hardware. On sandbox, this is not the case because mmc1.img contains a
fedora image.

Replace the module-level mmc_dev constant with an avb_device_id
fixture so that a subsequent commit can override the device number
for sandbox.

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

