Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA40AC79F9F
	for <u-boot@archiver.kernel.org>; Sun,  6 Sep 2026 07:08:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 733084066C;
	Sun,  6 Sep 2026 07:08:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6ZAsDGbJZ-Yp; Sun,  6 Sep 2026 07:08:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B0B3840660
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788678536;
	b=mbwpEnQzsbKiKFM5sChHapiwG2SWhOcWBWjcAXiA+TxNcLX+OBoaF/cL0G8i5zThUoLk
	 3Hl8P4EnsnEYnr7H/aiHLfh8TAgKH/fZutHOUqUK7INQKyvFD+jcAdzmoSqX8+DT+iRtD
	 b0csNd+zH5yPBIiGQcfjmfzgwZQx5z99FoM9Enizi5s3OZe2o6FQ0TosIIsxbQmpO+IsT
	 EQvJYHrrUdXYfcgxhxTtfNQLJjsQgUjmDUTIFUAXFmNtZSavdtJHoVHMNjjjp+vDBmpSR
	 g6qdsHxYAWzxPOB6z41eCcIUTk2MN5oniluJ0Eu9LuBuWFzvK3IXyugJ/9JNyfZT8fg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788678536;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=4gJ8Zu3MyY4RtHslJbBTmBFHXhSfRjQ8qMrl1KyOahQ=;
	b=Od1LO7MEDrWi78TjbI462bYWFHenIJ/T/+fbtJw+inqSZQMbcSGPZdg1RfVKy8tPP+vR
	 6A2GV7tGbsVDzHUGbLpZV77neCUwNZOFEOQ1Q6uIBeP2PKHBqlm3yhdCumNjNW7N8kIDK
	 HucdUwoYs6WVlbjVmmtTEM4f56Xjk+R1Uaehoffv5L85WJU3l+el4xcoq1Ui0FKcSt8Ho
	 +HiiL3HpHARvd1uA2TaSly+vprZZRgt3gJRGPXjSmSO8vIWC+obl2fyUEGeUrxMjjO3cH
	 bUaIS9KTKPjGzxexetfthIfaJympLVbPlu+P+5goNhKLJHd8A3Q+GXuWXicDaj2R3GQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788678536;
	bh=4gJ8Zu3MyY4RtHslJbBTmBFHXhSfRjQ8qMrl1KyOahQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dtQ3b1bMvZ9uF2uQ+WCGpUXgPTkQowNN1GcWbbdKN7l0N82mDpruT327bqFcNZQ/C
	 fJYPakyKkIdZfmEOu6BSGNrTx7Omy5+BOIgNmO/yp9UyDG6UC3Xtx9mJhsBZXntUYa
	 dVmMNm++7Do5LbtwE6+ogkocgw7+ydYl7uAlLUw9qA4xzq4pvri7bo+O/qbKxrgr1/
	 Zj8jHthxK/oKWOLouCUTWb9E8rglL3cI/2TbcfLnS47ZjZ/+VdYQyZ/Aeq7qhFiHdQ
	 fE0VBY1JktT7AT3HKlxF8hhG/F1UgBroLi5d1pgNr9YrliUJumD+fk57zIOFJtsqzJ
	 4IEMXuriP7B3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B0B3840660;
	Sun,  6 Sep 2026 07:08:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5656B34E
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 04:52:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3BBF880EB4
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 04:52:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u4kWaOxv0iQk for <u-boot@lists.u-boot-project.org>;
 Sun,  6 Sep 2026 04:52:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 2DCED80EAA
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788670337;
 b=mJItQUJgWqECQqp7kdMTjDHDFjphFLVgYv0ZYW32yWLAlWST8PfkDNdGzFwBepT5KEOF
 Fndimq6Dz6CC3oUzcGH4SKJEW4X/fZMb9tfIEhn0BAl7atbgehNxjVmVKsdw2zJoaq5gC
 SREYvPNu8XK9qbz5LkVCH9llWEvQ9Hqa1At5qN4S3dTgA4DBIXtpeE8FbZ7r2VKw3eEs0
 ErcRup2iJv+FE92uTh9pW6v67JPf/YcmdP0v4BfB4dnqFVUjOzZRjza+dnVm2+O9mURvj
 YZbcQHlALcBZ01zJHChV87eYm6XkFQj8zk11Yqkp/AKPijVvmFeYnHVsGXSmKbvvUsg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788670337;
 h=X-Greylist:Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
 bh=4gJ8Zu3MyY4RtHslJbBTmBFHXhSfRjQ8qMrl1KyOahQ=;
 b=eZ5OwkVsdMX0mRR8fTdGeUf1TwTg8HVHbeBhbUz0LIne3s0A+zIKsjiT5XaVRMZSG7xI
 QF7dkl0Y4jNbbqFtxIxOwE1NNiZx/2dLJJg2fR5S6SKinkyxKERFOqv7VYVBMVbpYsa/7
 mPvVhYNYxCFfcBoKArpP00OBVYO2gK5h9S5a0roh0dMs3rBMpAXLMF3uOUhpOEVJ8CGO7
 J5Ucy/f3PtpB9fDPqsd89Fl1OilqT0dLA20T2OnaB8rxFF3YZBfZcn40+a62RUX5g8hP5
 i/XRxjOw4q6KpGkbpvhOBNT2Ng6Kklrii7nObMQXsNxuK8DFK+Bdv1swGDKk2Cc4i9Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=163.com; 
 dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=nVK1Z0iX; 
 arc=none smtp.remote-ip=117.135.210.3
X-Greylist: delayed 133 seconds by postgrey-1.37 at util1.osuosl.org;
 Sun, 06 Sep 2026 04:52:16 UTC
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=163.com header.i=@163.com
 header.a=rsa-sha256 header.s=s110527 header.b=nVK1Z0iX
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=117.135.210.3;
 helo=m16.mail.163.com; envelope-from=hppiscas@163.com; receiver=<UNKNOWN> 
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2DCED80EAA
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 04:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=4g
 J8Zu3MyY4RtHslJbBTmBFHXhSfRjQ8qMrl1KyOahQ=; b=nVK1Z0iXeIzKJitK8n
 LgYXQW0tRIeCg2g6Zu+Sh8nVipa2fXr9GADa5/PRPyrpUdWx222/zBFRcM5oWIiL
 9e6WjuKCzoZGL7KE/ZtIBcWMFET8M2gKKFjdzzgFOuFmkrvoJmQ4qnEJRMzqpuO+
 9HWAPdlH/J4EHJ0P5TJKhJ8to=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id
 _____wCnLpTP8JxqJ_jQAw--.36711S2; 
 Sun, 06 Sep 2026 12:49:20 +0800 (CST)
From: Pengpeng Hou <hppiscas@163.com>
To: u-boot@lists.u-boot-project.org
Cc: Pengpeng Hou <hppiscas@163.com>, Mario Six <mario.six@gdsys.cc>,
 Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Max Merchel <Max.Merchel@ew.tq-group.com>
Subject: [PATCH] mpc83xx: Fix MPC8360 system PLL dependencies
Date: Sun,  6 Sep 2026 12:49:16 +0800
Message-ID: <20260906044916.27956-1-hppiscas@163.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCnLpTP8JxqJ_jQAw--.36711S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CrWUJr1rAw15XFW3WrW7Jwb_yoW5Jr45pa
 n7tF4UJr1UW3W5CF1aq3yUCryvkrs3JFWDA3Z7CryUAw4DAFyI9FWDJrn7Was0yFW3A34k
 Xa4rua47XrsIgw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR_hLOUUUUU=
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbCxRAy+mqc8NArEAAA3w
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

The HRCW Kconfig migration misspelled ARCH_MPC8360 as ARCH_MPV8360 in
the system PLL multiplication-factor dependencies.  Since the latter
symbol does not exist, factors 7:1 through 15:1 are not available for
MPC8360 and factor 16:1 is unreachable altogether.

Use the actual architecture symbol so these choices can provide the
SYSTEM_PLL_FACTOR value used to assemble the hardware reset
configuration word.

Fixes: 21c1502a4a81 ("mpc83xx: Kconfig: Migrate HRCW to Kconfig")
Signed-off-by: Pengpeng Hou <hppiscas@163.com>
---
Testing:
- Generated kmeter1_defconfig, selected SYSTEM_PLL_FACTOR_7_1, ran
  olddefconfig, and verified that SYSTEM_PLL_FACTOR resolves to 7.

 arch/powerpc/cpu/mpc83xx/hrcw/Kconfig | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/cpu/mpc83xx/hrcw/Kconfig b/arch/powerpc/cpu/mpc83xx/hrcw/Kconfig
index 44f66cd52..0fc3b7765 100644
--- a/arch/powerpc/cpu/mpc83xx/hrcw/Kconfig
+++ b/arch/powerpc/cpu/mpc83xx/hrcw/Kconfig
@@ -67,43 +67,43 @@ config SYSTEM_PLL_FACTOR_6_1
 	bool "6 : 1"
 
 config SYSTEM_PLL_FACTOR_7_1
-	depends on ARCH_MPV8360 || ARCH_MPC837X
+	depends on ARCH_MPC8360 || ARCH_MPC837X
 	bool "7 : 1"
 
 config SYSTEM_PLL_FACTOR_8_1
-	depends on ARCH_MPV8360 || ARCH_MPC837X
+	depends on ARCH_MPC8360 || ARCH_MPC837X
 	bool "8 : 1"
 
 config SYSTEM_PLL_FACTOR_9_1
-	depends on ARCH_MPV8360 || ARCH_MPC837X
+	depends on ARCH_MPC8360 || ARCH_MPC837X
 	bool "9 : 1"
 
 config SYSTEM_PLL_FACTOR_10_1
-	depends on ARCH_MPV8360 || ARCH_MPC837X
+	depends on ARCH_MPC8360 || ARCH_MPC837X
 	bool "10 : 1"
 
 config SYSTEM_PLL_FACTOR_11_1
-	depends on ARCH_MPV8360 || ARCH_MPC837X
+	depends on ARCH_MPC8360 || ARCH_MPC837X
 	bool "11 : 1"
 
 config SYSTEM_PLL_FACTOR_12_1
-	depends on ARCH_MPV8360 || ARCH_MPC837X
+	depends on ARCH_MPC8360 || ARCH_MPC837X
 	bool "12 : 1"
 
 config SYSTEM_PLL_FACTOR_13_1
-	depends on ARCH_MPV8360 || ARCH_MPC837X
+	depends on ARCH_MPC8360 || ARCH_MPC837X
 	bool "13 : 1"
 
 config SYSTEM_PLL_FACTOR_14_1
-	depends on ARCH_MPV8360 || ARCH_MPC837X
+	depends on ARCH_MPC8360 || ARCH_MPC837X
 	bool "14 : 1"
 
 config SYSTEM_PLL_FACTOR_15_1
-	depends on ARCH_MPV8360 || ARCH_MPC837X
+	depends on ARCH_MPC8360 || ARCH_MPC837X
 	bool "15 : 1"
 
 config SYSTEM_PLL_FACTOR_16_1
-	depends on ARCH_MPV8360
+	depends on ARCH_MPC8360
 	bool "16 : 1"
 
 endchoice

