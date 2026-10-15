Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17323CC6B34
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 13:55:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD6738125E;
	Thu, 15 Oct 2026 13:55:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6KGnX0mSgoHF; Thu, 15 Oct 2026 13:55:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1FA568124F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792072534;
	b=hUIyaxE9R+9vsuVUJne6hEtoGvMMNb0u+OVGTj9lj5ukrdRt5nFwHaN5nHW4u/ZXxptC
	 TY6Q2FgaJykyFfLmE23F3Qe8Nib4SZFUZ/U96Em3gbhVHrwp/5zn7349h2HK4b8T33b5l
	 GWwl+OfzLPHv+r5fqE+CHpwIx1HipUOyMlOzEDC2Bc7+NJvulo8ZtxD+WOpdCkdJMahKL
	 DRZivHiDnGexo/C8YPc86aziJkdC49WCvTT2ce8po+ngPQanxhQcmbmuXQsxrEp2X+UxK
	 joxD+s0wUJmVAmBjse8r29szDMLIgUWrYciWSe5be8YY4yNRS/0Sy5CcIvVeYRu+5bg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792072534;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Te+E7vsWWh0fcPxtgGey2X2ybSJFmOvumTpPoaLZltQ=;
	b=SQkHU/9miZ48ctbPKrNFEXJxw324wRmHWUpZ71F0A3pKMOqCSght2a1SUlvzY3F43zbi
	 Sycbz5uJGN6H/jKc8im8zNUbhxXAyQ5sf3QAJcHGsZgihIQIv+e0RvH3sJLi3ToawsT0+
	 TWgnREZ/BM6KKL/X9S4lQyb7oBVfpw9VA6oVolzV8Ez/JVvWuFyQbvdhWPOmUFJlv5678
	 R/HZfCxO/IIVPAD5Mj9VDcvadPXEe+ucVpZL+MsdV8XiwRCfsQ4aVdx5/nucXZiNFDbP4
	 y1vkUdFWiTlMDzFI0nRYIyuBGbDSg1xEwK366ZkX4ECocvmK6iuaXqTQC1pH78RcP1g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="VqMsvlJ/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792072534;
	bh=Te+E7vsWWh0fcPxtgGey2X2ybSJFmOvumTpPoaLZltQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NXAE/f+HidH8DKVoIGKQ4XHc8qmn+IjwaayA/Hc2oHQjJQDzRhVOMXCbDdB/CR2tL
	 VnnQWJvfFTq51sDS1QUSnD0DtJG4O0SdeXsUB7r90QtHBV8O30YDqVIO4O6eNncxnF
	 DrIJFN0ewH//2Gc10mqrmswXjhNuEdkABKQEjg4rzxXqd5PTLlaOh11SiQLdOm3vwb
	 ypKm76h1G3GoHdh/g8GlpTPMld4+mLSa0qBqBXxDeivZCmLNFjDQtmJomZlUwbdpGL
	 sJbh6XGRBGEnSNEnMvoZH07zxyjHkdEamKJnnIV97B28hDM6MTzt2bRzqlekm26UmP
	 k5IQLWz3t54Lg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1FA568124F;
	Thu, 15 Oct 2026 13:55:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 46A242AC
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 13:55:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 318C681258
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 13:55:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fEOOgNWHRf-0 for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 13:55:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1904F81232
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792072530;
 b=FFmqKZ5y9HzveOyNJNrWJoA/PsXb2CMq+3DvCfleCd+Rzk/DmbFTGL8J9TpPmEkS+SPy
 RqMisNth3PyS0440lYJvA1mlD4Zk4RcqmarTVV+LfxVP9VOgjE6A094vlQm3csWg5MtTY
 H52Xli9sUoJSqyeKhFu4Qy6wIo5HdBG1335oSt+7tZb8p2nE+m5DLnGpbpyxI/7UkLPhI
 SB4ft+9kUOFcUUQeMmBL4fdQjhLyjTfewOrgg3Vfhe9tCfuCHXnskg5zYk8zNsa04Ryo1
 WhQ67hLuJkk2tOqM9oa5TM0ljwo4ApUxeG2qd6/vGHmFgCzULcdPPtc5eTCcf5lQE0g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792072530;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=Te+E7vsWWh0fcPxtgGey2X2ybSJFmOvumTpPoaLZltQ=;
 b=gZf7znRncHuEmXASs6mCTRE51TsCDl8l/Ktie8ifaprdkHAtpeNhlUiyrajSa3ZBSC+v
 ppfe3cKTA5VlK0ol4s8UxUaYW6fGGE52SHPUlk817DyhVpRxLH/sBrwRVmqQt7FrpdSFq
 TpopBDpNc7M6p0SNU8NRGUmrdiauJZmNA3rOyGxe1QsjSsJ45/NTHrfgQVcuMnBdnai6N
 ubn5RyadPoQK87qtg3pYSMt3o/7uCOkPqIjC61mPGqc2GgMdoHJCuz5zdL6SOoZcmBnfY
 M7BskOaVKrL1JIJUrFP7VrVXnb7EyX8/jJsTtQW//dYBb6hoCa3cG9QQZkHdSBSWg6Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="VqMsvlJ/"; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=VqMsvlJ/
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1904F81232
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 13:55:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 94C346020C;
 Thu, 15 Oct 2026 13:55:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3BF1F000C4;
 Thu, 15 Oct 2026 13:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792072528;
 bh=Te+E7vsWWh0fcPxtgGey2X2ybSJFmOvumTpPoaLZltQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=VqMsvlJ/L5PSLzz355LAxEGSvmu5ERQlOfBy3vg6UC0NwNiDi6ZjAqh5z9uwRVDn0
 iu1Ic28FRvHk1aK2VGHCzAa7cE3WRyr4gD5wIPYXEsV+ZFhMd3V7lGIgx2dS21PeG6
 zdc0+fgyFzK5rKSk0XqDs5tKinvhQQcYy70m3ddHrCatUueRSy6Obz+h7QnYocXpVI
 OPYSU9oDS1ixXSsrDA3k9qsDpRNkliA1hvrsSDitwDtx1v6EPF5xZ31P0RfcB6dJEZ
 QHTtBnXRNhwJtxfh/ir8i1nlYpru3VZOSI5BI2wOEWauB+co7cBlL4u0I3sWAlWWxK
 AJDOk+CjScwjA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Thu, 15 Oct 2026 15:54:56 +0200
Subject: [PATCH 06/10] test/py: android: Add setup_android_v{4,2}_image
 subfunctions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-test-avb-fixes-v1-6-9e5b82644359@kernel.org>
References: <20261015-test-avb-fixes-v1-0-9e5b82644359@kernel.org>
In-Reply-To: <20261015-test-avb-fixes-v1-0-9e5b82644359@kernel.org>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Jan Kehren <jan.kehren@emteria.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2007;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=PH7LW0SAq2D4VTXMr6wcbedcN9gLKea8E2MOvNL/jX4=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq0Ns/2ouKWf85rvt5VPpQIHJxo/fZSwTJaUyut
 KWCrONzF3eJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCatDbPwAKCRAZDR20Zk4Z
 NTnHB/47ZIHRDcFyUyZvW5GslXO6uYTsEQD45jQTFQ8FzuVN2QMsdg60dYWow5Ao77VvWOyuUe7
 vdUyN9+XZQNO2xfXLV8Z56jv2FxJ+qVTzSpewaBiaNEO3jzW2XtTJNC/Gp2uzT9a8EPh4k2BEO7
 rj/KCIx6+cKeYO3hzDixhmIE6e0rfFEDk5VokkuW93XthGmhJqQCaZnTW9sKV+hvvetxreUEnDn
 taBbrgL3KFjg7G+wkB1eZqjdoy2fhQ2mVh4kTA/1R4FubNzGAbDfRYiHZs9FxYhCoLltlb1169A
 Yv3kwwqQstEOCKF0Y2Cj/6BZoQuXhA5usCHA99J44fM1hTPt
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

To split out the logic even further, do each image creation in a
separate function.

This will make it cleaner to add future images as well.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 test/py/tests/test_android/android_image.py | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/test/py/tests/test_android/android_image.py b/test/py/tests/test_android/android_image.py
index b5fede8ebf0b..abdc6cd28744 100644
--- a/test/py/tests/test_android/android_image.py
+++ b/test/py/tests/test_android/android_image.py
@@ -56,8 +56,8 @@ def create_gpt_image(ubman, mmc_dev, required_parts, images):
     with open(fname, 'wb') as outf:
         outf.write(disk_data)
 
-def setup_android_image(ubman):
-    mmc_dev = 7
+def setup_android_v4_image(ubman):
+    """Create mmc7.img: boot image v4 with vendor_boot partitions."""
     required_parts = [
         {'num': 1, 'label':'misc', 'size': '1M'},
         {'num': 2, 'label':'boot_a', 'size': '4M'},
@@ -69,9 +69,10 @@ def setup_android_image(ubman):
         (2, 'bootv4.img', test_abootimg.boot_img_hex),
         (4, 'vendor_boot.img', test_abootimg.vboot_img_hex),
     ]
-    create_gpt_image(ubman, mmc_dev, required_parts, images)
+    create_gpt_image(ubman, 7, required_parts, images)
 
-    mmc_dev = 8
+def setup_android_v2_image(ubman):
+    """Create mmc8.img: boot image v2 without vendor_boot."""
     required_parts = [
         {'num': 1, 'label':'misc', 'size': '1M'},
         {'num': 2, 'label':'boot_a', 'size': '4M'},
@@ -80,4 +81,9 @@ def setup_android_image(ubman):
     images = [
         (2, 'boot.img', test_abootimg.img_hex),
     ]
-    create_gpt_image(ubman, mmc_dev, required_parts, images)
+    create_gpt_image(ubman, 8, required_parts, images)
+
+def setup_android_image(ubman):
+    """Create disk images with Android partitions."""
+    setup_android_v4_image(ubman)
+    setup_android_v2_image(ubman)

-- 
2.56.0

