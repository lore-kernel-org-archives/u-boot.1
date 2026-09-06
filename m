Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB0D4C79F9F
	for <u-boot@archiver.kernel.org>; Sun,  6 Sep 2026 07:08:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 92F7740642;
	Sun,  6 Sep 2026 07:08:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CJ7vUhyxZkVt; Sun,  6 Sep 2026 07:08:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 35B2C4063A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788678531;
	b=O4mRyvMANLawbWrphCKbvqhaF1m/9qzDoStHJ8iYxiztKvTWpd48LeBtD1Ygc9V2/TJP
	 Pwxrfti+WlbW8wy1lmP9eRUpV5aPoUJ4QHmq7Vzl6OGngx6algVplKpI5kn9Gu3mahrbg
	 D/L4WZntKsAmosK/5jtxYJ7XXl7o4fdNgYok4NcuKuksfs0uuDkv7/g4JSDvGg9wFzIvf
	 PqQH4zpv1zDWKj3HhsGwwTvAfWkTiSCgDpb6l+kvviSNVTlvwYE3xSv6wtkjRv+x0gaoA
	 +N8ettESIPnAMhiSnfNRg6Llz+VlUuNuUSrpXOAggQcQsmSfH3oLF38GNCkpKa+p/8w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788678531;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=JjVtTPHD7MVKuGH9dAMC0moiukhgZkeJnnSO39VhDx8=;
	b=LA/u/beWJ1hCUBByl7VBIJSDMxRA9HFmOS28QfkL1Cfg5a6pRBo3Jk/gnmdNeOpJQ+vG
	 Zz3XQu0+OIwh14zspHqsY2LEjz3CztosyT5reCajxRwkT2q/65r3ZKrt9tTHGqp1MsNWq
	 rRyB/4rdeYOz7CKri4dRrcimB1FJLnrwgwPN8bPGoiLSChs1NIJA8GFEkdnjdFKtGheOA
	 /c5O3rzNgmlr9yHNiC36nm2EyrVFgkdh49VUaHkJm2bS4QJQlscja4xK7hjvd6Q6wkteo
	 JmVh3TF7J4Sa4iGwfVyej7TGKhoM+KxcaltQSpoWMWu2pBjLM7kUB4NzkLBzsqXh42g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788678531;
	bh=JjVtTPHD7MVKuGH9dAMC0moiukhgZkeJnnSO39VhDx8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sKinu8qUeFbxYSIPeKgD56uWE6BCykGDFu7/C7EU+lnIpgvg/5ViLB9/3hIwqJFuH
	 buURLaO0/oyA3732BPU+6+4w1kjHPjASowvALeDTP4Lcv2Y4mbr2TssI4mQSJ9yvaq
	 geQDp0o4Xj4epNpExdWTIPV+ih0Csz6PmIHwxdwlWu3SWwbZFLnQa71eUS6vo1344v
	 +S1bxewyr+WR4uPcuTl6qJh1oP5Jpn/xJEit3ZP3gkm/n7zsJs+xOvw4XU5NscoczH
	 UjvfS4XeGGR4uFt1dtTjic2ESdKfHBs+AQ3fXxsREkGCWaYMsRi1GQ6AB5+N0nndGK
	 PQLVez+1nPVMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 35B2C4063A;
	Sun,  6 Sep 2026 07:08:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A384D372
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 04:50:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 83D3F80EB4
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 04:50:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kSJWcBN8UySe for <u-boot@lists.u-boot-project.org>;
 Sun,  6 Sep 2026 04:50:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C189280EAA
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788670235;
 b=ST+KQbz4bryPt6bAg6IpEGuBPwkeybkzVDYTi3XekwqDbwmsuekMzXFu+pJV6GcHJ15e
 xdl5XUEmgqN+X3xOaV0/+9N88ULftAYoNJeIK/ghb3cQ20+kLblc6gOXnjPAWqNUYRRxj
 kCVfSDndOX+djyFn7I1W7OFc0Hy3hgrCY636JHEF7Bw8nzjUhB3CyLRfZHxXrupjdyTU8
 +T/Qm4bCITNB2fL3zC3+ipJ/7SlHX7ZgdlbbTRRIf5qLXchgDRw23i1uqZRcQcqTVwZ50
 fKvJRIwbInV8Igr21yOhMV5OnUTv/3FukyYP7fUqHpcLMYcrBX9MYUhtZseKdO4QlrA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788670235;
 h=X-Greylist:Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
 bh=JjVtTPHD7MVKuGH9dAMC0moiukhgZkeJnnSO39VhDx8=;
 b=Qyy8LFZUkNA1Ir/2VC+qK01TN9U5L+ftYAJ7a8Q6YCNDX0xeFIOQCRiINoy7C+zlIT60
 aYeydlr6/T9REEC98B/P16XUxWOm2hLrCMf/jKfEcjIbEsdDeq1NJ1SkUnSLmtj6pLgQq
 Ac3MkDH+lVCaf9QWkqrvUdJGWtHdzUYY611qA/D6sjF73k3P5k7AbkLejiyaQjbLzKBok
 4kr2zyn0uTqfXkSqU3HTr22TAOYIurxDNI1kFLxloI5nEDUcZyNRXn41bwSO0EIOV/n8z
 CI2xyqJilqxCtpTa4INNZA/dgKThUwMUE3EpdMRJJ3ldOIiVFoC6/a+hZ3GTmTGW69Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=163.com; 
 dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=gqr8MC05; 
 arc=none smtp.remote-ip=220.197.31.4
X-Greylist: delayed 70 seconds by postgrey-1.37 at util1.osuosl.org;
 Sun, 06 Sep 2026 04:50:33 UTC
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=gqr8MC05
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.197.31.4;
 helo=m16.mail.163.com; envelope-from=hppiscas@163.com; receiver=<UNKNOWN> 
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C189280EAA
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 04:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Jj
 VtTPHD7MVKuGH9dAMC0moiukhgZkeJnnSO39VhDx8=; b=gqr8MC05fvxsA9OYiB
 T2uj07ElEwDcV2nwE6zfUD/Sv0e2Wy3Vq5liefMA+qGxz6/LZZk7DJ7m1UZIvU/6
 Fom/BI961IOO9pPpZk75mM/U7s0TJbs8/UVPmkzz6/OQDnQu6NvqVs7dg9AszET6
 MVRCLhkca2uRUeqA8YP6Q5exo=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id
 _____wD3F9zz8JxqmFgHBA--.37104S2; 
 Sun, 06 Sep 2026 12:49:55 +0800 (CST)
From: Pengpeng Hou <hppiscas@163.com>
To: u-boot@lists.u-boot-project.org
Cc: Pengpeng Hou <hppiscas@163.com>, Mario Six <mario.six@gdsys.cc>,
 Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Max Merchel <Max.Merchel@ew.tq-group.com>
Subject: [PATCH] mpc83xx: Fix MPC837X cache way-lock dependencies
Date: Sun,  6 Sep 2026 12:49:53 +0800
Message-ID: <20260906044953.28168-1-hppiscas@163.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3F9zz8JxqmFgHBA--.37104S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7urWDAF1xXw4rCr4xAw13urg_yoW8Gw4Dpa
 n7Crn8Gr4DWa15Ca1Fq348Cr1UArZ7WF4UJw18Z34qvw4DAry7ZFWqyFsrGFy5trZxArWk
 GryrKa4ayF43uwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRNtxkUUUUU=
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbC7hQ7BGqc8PSK5QAA3Y
X-Mailman-Approved-At: Sun, 06 Sep 2026 07:08:42 +0000
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

The HID Kconfig migration retained ARCH_MPC8379 in the cache way-lock
conditions, but MPC837x processors are represented by ARCH_MPC837X.
ARCH_MPC8379 is undefined, so the additional instruction and data cache
way-lock choices are hidden on the MPC837XERDB target.

Use the architecture symbol selected by the target so the HID2_IWLCK
and HID2_DWLCK values can cover the remaining cache ways.

Fixes: be5abb0a834c ("mpc83xx: Migrate HID config to Kconfig")
Signed-off-by: Pengpeng Hou <hppiscas@163.com>
---
Testing:
- Generated MPC837XERDB_defconfig, selected instruction and data way 3,
  ran olddefconfig, and verified the derived 0x8000 and 0x80 values.

 arch/powerpc/cpu/mpc83xx/hid/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/cpu/mpc83xx/hid/Kconfig b/arch/powerpc/cpu/mpc83xx/hid/Kconfig
index 1f61108ce..9473213ba 100644
--- a/arch/powerpc/cpu/mpc83xx/hid/Kconfig
+++ b/arch/powerpc/cpu/mpc83xx/hid/Kconfig
@@ -434,7 +434,7 @@ config HID2_IWLCK_1
 config HID2_IWLCK_2
 	bool "Way 0 through 2 locked"
 
-if ARCH_MPC8360 || ARCH_MPC8379
+if ARCH_MPC8360 || ARCH_MPC837X
 
 config HID2_IWLCK_3
 	bool "Way 0 through 3 locked"
@@ -470,7 +470,7 @@ config HID2_DWLCK_1
 config HID2_DWLCK_2
 	bool "Way 0 through 2 locked"
 
-if ARCH_MPC8360 || ARCH_MPC8379
+if ARCH_MPC8360 || ARCH_MPC837X
 
 config HID2_DWLCK_3
 	bool "Way 0 through 3 locked"

