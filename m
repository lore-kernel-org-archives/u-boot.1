Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5970AC27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 21:01:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0F7788717;
	Tue, 11 Jun 2024 23:01:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="NfrwYyRr";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="P0muY1Kk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AABE88717; Tue, 11 Jun 2024 23:01:02 +0200 (CEST)
Received: from wfhigh4-smtp.messagingengine.com
 (wfhigh4-smtp.messagingengine.com [64.147.123.155])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCE5C8870C
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 23:00:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfhigh.west.internal (Postfix) with ESMTP id E22A91800159;
 Tue, 11 Jun 2024 17:00:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Tue, 11 Jun 2024 17:00:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1718139656; x=
 1718226056; bh=x1cm+iaWsv6/CWdCzyJZbddTU3UzljXeO2HluK860UQ=; b=N
 frwYyRrNOvC+MKzzU+vFz2byXIFgjl4F+La3jfcEQ1AYBzxkLO02BQDRk3n0PkW0
 KLOTI5wejdwJQqdmskQwmHBK6ejWOEruGpDs5GvvSOXfmiSjqyNfm8FyMZAKzAXM
 ATsx0Y1Lriy6t9urAJoZwLCDQQV9ED5evWL/e2gpk1cdVYjFVTduwsmyOCjBqEkt
 +XyuWx6VP+e68tq+ffnZPfdhnTKshf9veHc9KKNE9jl3x08wuiaUHL+pewVx7vPC
 GVSXvPFlx7R/s4J1K+uUZ/4/wO4Yr5g75ie/kYNykg/pv6q0aDAadaF+nqSjsMWl
 qq8lHveGEWGJ4WSk+Kb9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1718139656; x=
 1718226056; bh=x1cm+iaWsv6/CWdCzyJZbddTU3UzljXeO2HluK860UQ=; b=P
 0muY1KkBeu6ak58I6hzb196Fv4nhVy/vSz3e0peUOPo8QNXp9HN76YAMigKLNjTo
 rDPW3LcGV6dew5NUb6qMKWfTZg+vzKuad0BRRyus4/UZIREn7qE9Xmsi7Dz0cBms
 QLbrjnWnOhpExobgzzensgGWZuTVT7ytqJgB87788BWqHw3lcCSvfFH5ddk3PBQS
 1FhqoQUhyBH4D7Va5jD8pZFXTlLz52rvvoleL9cm3BhwYuwjeqZpONTB92Oup5nm
 iu/H8eR3VSDuIZxLfDonbZYi69BLQVUisYU2RroVI38ftePcWrLd6QTy+ioqIL8R
 m58zIarvYUqLeYyzFPSRQ==
X-ME-Sender: <xms:CLtoZlGDg3h5k-5uXak4qpZsh2R6gpo_mx63vtCUqY186UB3EohsBQ>
 <xme:CLtoZqXLmwxT4AaLEXTgz2qCEg4RoDF914G6BErUhVhBkF8fwQnTorR2c0x7zxu-1
 n7u3SVScT93aLf_Qw0>
X-ME-Received: <xmr:CLtoZnJLyCB0vnikGM1ye93KlGbhyCGQgqQe6ywKa4WNaGgpqWBR3e1fwQM85kN6P7zrKn1l6_s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudehgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestd
 ekredtredttdenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigr
 nhhgsehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeefledufeehgedvue
 dvvdegkefgvddttedtleeiiefhgeetudegkefhvdfhjeeftdenucevlhhushhtvghrufhi
 iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflh
 ihghhorghtrdgtohhm
X-ME-Proxy: <xmx:CLtoZrH3C5fxVMNV-q8hqb3JrlbMcKO6rQc2Qr9r2h00hQOpncKX1Q>
 <xmx:CLtoZrVAESKZdsKS8NSMgZ-_6eaI6F8r6s5R329RDZM2xBXoTbB62Q>
 <xmx:CLtoZmPHPR-E4ryqSexAvCYPBlHHTVh471oTnf8znvqULxiqpE6-hg>
 <xmx:CLtoZq1oUurAkPtRs1dEouaJHXTJXHEWBBXu-vtUG1u3bbD2qCCCOQ>
 <xmx:CLtoZmSWxJmc5imDOuuQDBbkVMzORc2wCJldoVNolfY6WjW-jTN9gJw7>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 17:00:55 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [u-boot-test-hooks PATCH 1/4] qemu-vexpress*: Pass -audio none
Date: Tue, 11 Jun 2024 22:00:22 +0100
Message-ID: <20240611210025.798978-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240611210025.798978-1-jiaxun.yang@flygoat.com>
References: <20240611210025.798978-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Those boards have build in sound card which cause
problems on CI runner.

Pass -audio none to disable sound card backends.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 bin/travis-ci/conf.vexpress_ca15_tc2_qemu | 2 +-
 bin/travis-ci/conf.vexpress_ca9x4_qemu    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/bin/travis-ci/conf.vexpress_ca15_tc2_qemu b/bin/travis-ci/conf.vexpress_ca15_tc2_qemu
index 83d703269377..55e40038b379 100644
--- a/bin/travis-ci/conf.vexpress_ca15_tc2_qemu
+++ b/bin/travis-ci/conf.vexpress_ca15_tc2_qemu
@@ -21,7 +21,7 @@
 console_impl=qemu
 qemu_machine="vexpress-a15"
 qemu_binary="qemu-system-arm"
-qemu_extra_args="-nographic -m 1G -net user,tftp=${UBOOT_TRAVIS_BUILD_DIR} -net nic"
+qemu_extra_args="-nographic -m 1G -audio none -net user,tftp=${UBOOT_TRAVIS_BUILD_DIR} -net nic"
 qemu_kernel_args="-kernel ${U_BOOT_BUILD_DIR}/u-boot"
 reset_impl=none
 flash_impl=none
diff --git a/bin/travis-ci/conf.vexpress_ca9x4_qemu b/bin/travis-ci/conf.vexpress_ca9x4_qemu
index d07be2b12984..b5ed72934c3a 100644
--- a/bin/travis-ci/conf.vexpress_ca9x4_qemu
+++ b/bin/travis-ci/conf.vexpress_ca9x4_qemu
@@ -21,7 +21,7 @@
 console_impl=qemu
 qemu_machine="vexpress-a9"
 qemu_binary="qemu-system-arm"
-qemu_extra_args="-nographic -m 1G -net user,tftp=${UBOOT_TRAVIS_BUILD_DIR} -net nic"
+qemu_extra_args="-nographic -m 1G -audio none -net user,tftp=${UBOOT_TRAVIS_BUILD_DIR} -net nic"
 qemu_kernel_args="-kernel ${U_BOOT_BUILD_DIR}/u-boot"
 reset_impl=none
 flash_impl=none
-- 
2.43.0

