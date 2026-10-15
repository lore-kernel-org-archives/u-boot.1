Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAFA2CC6B3D
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 13:55:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AA1938122B;
	Thu, 15 Oct 2026 13:55:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tYstiAcuDKeV; Thu, 15 Oct 2026 13:55:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EB7118122C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792072529;
	b=BaihN4rdK7GhGLEbgUngqW6L2514qzwdBEWNEBnNmG3G09FxMj4bikEdBNsTcKd3W4Us
	 MVoJuMC3ONBfXghceJgLOoxZoQQiC5SXAo3IYM4QImHCMSgrW/zpy86B/RnmnaFZA0gNn
	 MLuCTjvGHCPH3Y50HzM1J4TmgYzYDviHsW3OjQpo3A4+CTFVwR4z++oCk/eL1N5WzYu5t
	 SlhHUqYI6N5RFZhY7P5TgcGWL7xdcWeydf04ISPAPN6/7A/L01TVC8XXp4pMsnLv1WjEJ
	 dlxBgcdp1QuBoXEwWjKwekUTaExmK3oUPGl3T4yrPdMgPLtcGWGNtdj4kIL76PIn8Xg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792072529;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Fp/gQvGB1uQdzhPot5BvT53FqiQl11XqzQyzROpY8Vw=;
	b=AafhOKfxj3pZrAp/Eto+HVY2p2LH4msD+MU5CC6ynWM2kw1vSLfUinXEejN4MBThXsAX
	 E8neCTgRGcaVdto4adOnokKo4/1hpiEnft4XTLSqWSrXDgIVsQ89kzMyA33Sesljq3nC/
	 ogaBI2UhNNPm+zalOjIxfuOmtPfLcEWVUogwk/NOSApV4/54xxzepjjzFoUWGhF8a2QIT
	 r9S7l9zAQVrgoFf+EVpPZi7GNEpDf0unPZGbG1bGD8Vp18OJYc+YssY6KgF7ShTmflDmO
	 EnrmtXiybhSh7tFjOkOV1Vds53O9v6nnZpCSOT4/xX4mB1iCzeGXUpCn52gxnDmTN+w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792072529;
	bh=Fp/gQvGB1uQdzhPot5BvT53FqiQl11XqzQyzROpY8Vw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AZlQPWbhD1zax0vMTjVliNAibsATMN1l8PElsWkVa5yNPlxZHPt0CgZsid9jx4xqP
	 7cm73EbAoO6YLtgQMrFLh+CTCJTSuR6paWOgKjnYC4ZbGUQXkKkBP6bDSZCptXjrgG
	 G4w/QpAqOI8baH0Odl6sU7djMq+6vrRcl9YJT+plLjr2sxoxuDjTbw931WgBGsVqj5
	 LXTYKMXWdPpmVKXpuVdFNmjYu/udNlnTZNfklePCTy4xdMfMxlt8dSFM1kKsPUPgIs
	 PICMnTFEiO8DxVsUlVG5c4PhbizVksyiATHgIqsjhA4i0XN3chaIf01DHrsnNk5cv2
	 kokmDErPI1f4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB7118122C;
	Thu, 15 Oct 2026 13:55:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 11506105
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 13:55:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EAE6A608D6
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 13:55:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J0X3QPrOMVcX for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 13:55:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 446DA608C0
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792072522;
 b=FeIvTNsW6mIoUWIk2It+KRg21pb9nX1Ze40l+oFeUY/KkKZg4bI9U4hEmFzL48xGEcCd
 KRtjgpPWr43/tY8C7BEPfsEAo5cugf8OWUXM0KKJo47jqBY7VvEnclnpRFK0XRgSWzK1F
 dhsiNIT1DsEV+g8y8rGfVFJpKL/26071Bp2UIRUDJZY4WUv1m0LO0XXd8V+QSfbrP0VsI
 J20kvbb+ngvZZj40jpDYnplhpCF1kqLrEXRIKDJp6RaUHYr4WvG13JNf+D0fAnJ/xvVMp
 kNYINmHkgFsm3mee9cULZyOll5Fu49SfrrU/Y+qh5yVFcdkhh/dPrvpX/xCTn0QHa1Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792072522;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=Fp/gQvGB1uQdzhPot5BvT53FqiQl11XqzQyzROpY8Vw=;
 b=SrPT6xWi066jm5vl7Xu+XmNu/iE3BlB+YkvGOAZ7JcLBVKSJvW82fQS27VYJrRKIRReW
 Swz4mzyntLrPffjtPjnyB8oGWMV02cjNHgrftmLOoYgTQIt3fbn8r+Z/FrataYBhtVE/s
 y6IDNbp729d3SXJMFUh91P6mUsIwe25oAgVmuJrdlkJuXkHF4NYi25PNKPA4QxlmVSFKa
 ozcZdDYFwAznZn0PRmFkcHyp5W8+Nlrr1zRz3PKXLEoYXTYeRiUrQ/thwN3am0kXyiK8c
 DF2Q3FH6ODrrfrljZACohbxXHWStGMWFr8NqE1u1BqrDeHWWgiSDlwEAeeXDV8d/l0g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=oOdE8rBg; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=oOdE8rBg
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 446DA608C0
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 13:55:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8C83443F05;
 Thu, 15 Oct 2026 13:55:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1EA21F000C4;
 Thu, 15 Oct 2026 13:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792072521;
 bh=Fp/gQvGB1uQdzhPot5BvT53FqiQl11XqzQyzROpY8Vw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=oOdE8rBgcEdqiuvs5hHwxL2BNzJjpm2PnZBI6EtNi/Q3jEoYHij63h0svZD1CNjEz
 dhCbcErIRHVDwFNPBHZJniFgq/NBptYMCZsyra6YxCPxHIvqvrWHUo7XlFL7+9bu/k
 U75zdOrIgAlkaqVoFneXCfMLrEriDCaLinGpBnHnYXwCHHlw6uDw+TIPuBdW0hxFSa
 SPyQfNugX+Ii3Sk5wTZFKK1WuafGQzhKpt9xFT+SR0SSI9oP1gDLMaSCyBaX9sii85
 Yy/DMzI6mrACBtJNiFHFma+DrpR4UNgfEep6WQEW0gvlxErfLWciChkYmB0NBXmrHJ
 AH575wQBsinmQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
Date: Thu, 15 Oct 2026 15:54:53 +0200
Subject: [PATCH 03/10] test/py: android: Drop verbose printing and unused
 return
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-test-avb-fixes-v1-3-9e5b82644359@kernel.org>
References: <20261015-test-avb-fixes-v1-0-9e5b82644359@kernel.org>
In-Reply-To: <20261015-test-avb-fixes-v1-0-9e5b82644359@kernel.org>
To: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Jan Kehren <jan.kehren@emteria.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1087;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=9nFbNXWxi3U2f+0GKBjfQqv+ISinB4xXa0ZHGdTbhg0=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq0Ns+v02lv0dnwYmR9dzbUISyZupetmQE0UYOT
 zH6aFMin/CJATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCatDbPgAKCRAZDR20Zk4Z
 Naq4B/4+juxDuyXKlE92dgaJAubDH4cYPtXAr3dbBwMKVSJSAU2HKLb69mPkqLuHz/EVWvySwiH
 2cHAHYgQd1uJopbjewzUAq7ZwmeD/WL689iX3Hniw9Y5k5PhyzCI6sj3EyQCUXYvq43/4bViWeE
 CixOM6c+hjFa+b/TMD5/9V3m1zY0KfsqrJ3njnGqy5ZO23mDbJs85UuhTa7HQa2P8VEkdsC7qLW
 P7dYYKGeJlXPVsWHmhbWGTssugnCw2hSGs0zK8F9BTeYWuCX9QOfiMdsz4twkItE16eaqBpZztF
 8ENLiwx8/IfeSZSwGq8JIv4/4EkRNbl96m9TTrduNWdam7R5
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

The setup_android_image() is only called once. The callers does not use
the return value.

Drop the unused return. While at it, also remove the verbose printing.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 test/py/tests/test_android/android_image.py | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/test/py/tests/test_android/android_image.py b/test/py/tests/test_android/android_image.py
index 3bea311586bf..8b536754656e 100644
--- a/test/py/tests/test_android/android_image.py
+++ b/test/py/tests/test_android/android_image.py
@@ -81,8 +81,6 @@ def setup_android_image(ubman):
     with open(fname, 'wb') as outf:
         outf.write(disk_data)
 
-    print(f'wrote to {fname}')
-
     mmc_dev = 8
     fname = os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
     utils.run_and_log(ubman, f'qemu-img create {fname} 20M')
@@ -129,7 +127,3 @@ def setup_android_image(ubman):
 
     with open(fname, 'wb') as outf:
         outf.write(disk_data)
-
-    print(f'wrote to {fname}')
-
-    return fname

-- 
2.56.0

