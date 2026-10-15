Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA7FCC6B34
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 13:55:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 96FCE60AA8;
	Thu, 15 Oct 2026 13:55:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AnMvYkSZ8gyk; Thu, 15 Oct 2026 13:55:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CDC4E608ED
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792072541;
	b=ARhbOCSjpE/Qb1LGSsndxgZNF+FfGKiQ8/GUI3PmG6B58erE+tx3pwxEbuyOUfKwpwmI
	 6M67TXTf1SsY1sNamjq6kP17MRRl9UZWvx77SfOFECpgZD6lzigMV1Mxt6wfJElczdSZX
	 FOFBoUOX2zde8MBTzQvi8EyyOlxS53uy6iNeH4E3yGCz5z/6itoHC92SH98VJTRCX+vqy
	 MAg5kZviwrb3wBM515jgQxI3RKf+QK/P6rd6LVNc1vZ4EICsWkN1TCyFkwMvd3Hxb+NrN
	 ESDyF9/i4lFTEEB6wge5Y8hKc7unF+8BtgrVunDhA7P4LYeRf6lt5/DbaGcFjc6jQPg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792072541;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1FpOtIvvhbXzk1Up6LwkdI4sZw6RbrX4X1Bt7E8gmbg=;
	b=jIBKY/NbOlg+Ord7/0oAdwW2t5KhZ6ZD5PQ31KofSTIhur9jre6IzMsgmyqPvyyNotpe
	 ZO9pwuC/PBP0yh/JsmXIqGvtDoaf/26Fdvc0UN4CJ6Uxhrwi7qEwZPvCZ4Cz2ShiwExZx
	 2YG//f/YGdaDvbbpvTTsjeJmaBNjoOSe4i9/1MjhUFAfo7iO/DceQba0loXc4AEUM+NwS
	 eMUV9VqAH2Er9uF8bGqUgEQyE+Eod+Y/LRATl2RcP4Tbvv+Pc7Lt4MJnXBn6/cUNYwn2q
	 ebSZxeSJVXy0oqi/Nwjkkr70iOKJjDpS1ZX+RGIxSK7FnPZ2N6z9wj/FuCNeJFrIzpA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792072540;
	bh=1FpOtIvvhbXzk1Up6LwkdI4sZw6RbrX4X1Bt7E8gmbg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BexdJRH5k+aGxa7XpM2RmVPZsLDirmAetbODCM3gtqpaGaRbGzSCLxHzolwnGpg2s
	 hsM7SHgFMuYug9bWGH3fW/ZZQSEZfqizPxZqJlupGodFsA60GphJS8wyOfR8H37aA+
	 nzhUEvYvaDKWmyaGdTO9/98KLb0kDpcyin5cxTeDInBKYr8UvBobTkqh2qy3VnXe8J
	 XohKrSJVJEWbMqo9fssIclnFIpR8rnZIvW4jxyIx9TzNFSYkRFVNfP63dYkovmdFwE
	 RiXEI4wGfVtWoB0SzJqQSU1T/8mAjQXYPbNbIKL3HRrCCk4Kq26j1n+O7Q84Ue2YKs
	 S5DVHOtWMwbOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CDC4E608ED;
	Thu, 15 Oct 2026 13:55:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C5BDB2E0
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 13:55:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B7BBE403B0
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 13:55:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sEmhxA5n0-5G for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 13:55:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0FFD240098
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792072539;
 b=PKRA8mfTsCddDdzWW+N2kw3xzI88U+k2oC3O6icsiiqBsCE5/rrcwnOAtnqoYzegsNnz
 ovcN02oPSMyjwcTUeYi57ednxC7A4zGlmbSM4+qwiouKL1A8KCWRce9dpOBgBuiEcjUB2
 7S2cce9oQmdDfsVCxX/wduiNGp7jtUzSmBodbs8ek8w53NlrGNPs5MlZZRpvycr4bXiRu
 8naV3FQ6AiGZNXjjUXYGc90C0iBAbibopiPaGwhJ5aPoJ5Dvzu5BsMqjG5YEy8Z0QGrBR
 DZwMa1UHSvyn3KbzDutGGudhPHJLCagk+mAaI7Pra2dPnChjXCPQ5+juBQbkbXFqnAA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792072539;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=1FpOtIvvhbXzk1Up6LwkdI4sZw6RbrX4X1Bt7E8gmbg=;
 b=Sb27raJL+d+XMvD/TTqzj8WAhb2BGXQqDHrHHKc1yNQTdMteFVUcLFJQjfKDgwrSWjia
 PUdIiLRdhovAWFeia68KOpAHaq9Sc/goe7mEdtZv7/H3LmsvfBpWhT464sDAHdc9uxGS9
 W0WlTipRNhDL6/tE9NCXwEG5AjsXyQgHjNxsMfiX2V08iFOaAfRUBrOpbOF+nJ6RojPqf
 QrkgyUb4tT3C3ktwvAQd/OI26GbEQmTRRPNU3OVB2LSY8suzph1mqgCJl2knsLP21Jrt6
 UwERk/LTufNgZ2I7RCs9NSPEydJD1q6hbRVkLUWav82jzSoqrqzjnrQY0RD5enGoB+Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=aRAq4grC; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=aRAq4grC
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0FFD240098
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 13:55:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8F95F40DB7;
 Thu, 15 Oct 2026 13:55:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C7E1F000C4;
 Thu, 15 Oct 2026 13:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792072537;
 bh=1FpOtIvvhbXzk1Up6LwkdI4sZw6RbrX4X1Bt7E8gmbg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=aRAq4grCN5yYlcJTK2z6nSJE2z4PFfPHX9AbE5Zhu0u6HaiOSfcfjn+U+6PtzBk8G
 wCiMLPAMyrBi8GG6/qz8aGoHGI/MaLClmoINewgjJbvKJzkU+r/xto2rES/2RjfpZd
 nS+kVegiHyeLKBWrBIu+SJ88VGrMcGxRw+LKOORJIQbA4dy4r9OfT+Wa8t06QbU9vs
 9wpwDScW+HXJpiJ5iK0rYooWVtpWId+WZB8k44nmUk/DYi769bZVonrmxHBrBvv2kI
 8eZWYPVonp73iL5K8W1zpQ0yzLdXHw6e+7NLlv3YZyi72Yu8HCwzAFFbXJUGlY/Oel
 2p6Q9OQE13V0Q==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Thu, 15 Oct 2026 15:55:00 +0200
Subject: [PATCH 10/10] test/py: avb: Fix find() logic when matching
 response strings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-test-avb-fixes-v1-10-9e5b82644359@kernel.org>
References: <20261015-test-avb-fixes-v1-0-9e5b82644359@kernel.org>
In-Reply-To: <20261015-test-avb-fixes-v1-0-9e5b82644359@kernel.org>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Jan Kehren <jan.kehren@emteria.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2639;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=iYAQnErlKdjIT6xkUVzv0Vcsg97szffyJYK42hkRZbQ=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq0NtAwzik+fjBT0GTXenFQzEiTivNUqe+hILGW
 J/fZA2Nhv2JATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCatDbQAAKCRAZDR20Zk4Z
 NeYRCACU3qbrH3AehJ0SnAIkRQU4cLGuyJFKdJxOuIaqnfX/50Z77OV6OS2EuhECY38rzEYR0Jh
 OF1i2d/jykJUUG/k2YbNy8jFw5Sk3pFAT/BzL8yvLHE4MkIRYUes/48MdVtBV2L1gX2psc7w0aY
 a0mTlg4ietTJxE4GXifohKw16rCKxqB4auLK2WPgxC4nUGnGK5DThFSe9qHJjKUT1yhBRdrxku8
 SiUR9GqEWcgI7gJQeFmO48yt+zKhVa+l8KUdN5I0l0CL/wby5GiVC4f/yryEALytJ4r+ChHEjfl
 q5FNKxv1Kn0EQGIq1MyLAQOS0BQc9pqwOY7fGd1nrnZA9dUY
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

Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 test/py/tests/test_android/test_avb.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/test/py/tests/test_android/test_avb.py b/test/py/tests/test_android/test_avb.py
index 75abf5d1b1c7..fbab5fe6c471 100644
--- a/test/py/tests/test_android/test_avb.py
+++ b/test/py/tests/test_android/test_avb.py
@@ -58,7 +58,7 @@ def test_avb_verify(ubman, avb_device_id):
     response = ubman.run_command('avb init %x' % avb_device_id)
     assert response == ''
     response = ubman.run_command('avb verify')
-    assert response.find(success_str)
+    assert response.find(success_str) != -1
 
 
 @pytest.mark.buildconfigspec('cmd_avb')
@@ -127,22 +127,22 @@ def test_avb_mmc_read(ubman, avb_device_id):
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

