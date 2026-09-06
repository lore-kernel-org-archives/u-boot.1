Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 313BDC79F99
	for <u-boot@archiver.kernel.org>; Sun,  6 Sep 2026 07:08:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EA4ED80E4B;
	Sun,  6 Sep 2026 07:08:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SD27TsgsTbLs; Sun,  6 Sep 2026 07:08:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A561480E27
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788678532;
	b=FjdzMyGc6Di63pa8KVT4kBlyvNaDd00RkrdaXeia3ThxcwGKiT+8N1i9baWp58KrhHi5
	 JrdrVGXSUf4sp3jYvstOtOvUu7PDec4CWKV+wFY694P02sa9Q145+Cnfk67cFp2DMNRuW
	 5e5NFHMJQJN8zgNnWLRrsZC2FTtmFtq+rRc8TKN2O1TK9nZhQWhQk+ey7FJdOrgyws6/c
	 pmc2tCTXmCorbR5FGwXQT6xeUIMZfdfnBfrNjpQs84C8OG06RTf8Bu0N8mFwrT2TGCPuv
	 33M542GA+rHS35ie57rq2yPSDpNbP5K7O/HK7Gj5aZoaULApg9w5yIT8U3Pchad2HWg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788678532;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LceFNAYZOle3mO55N7lveK2XsQ+9l0DzHU9zE5TFfEo=;
	b=d7xk5WyZxL9Poo6ZfBOWOUg8D8xUGpc3POVZG7r2QxpeazdPFKtyalyY7eTrwQ/txmxg
	 DemLcGAXYdNHaGImaYwCM+alLy3JwEJNI11gOpohGGMPynxpVr4vwxFoEYvW2xy1ymc9U
	 Rliocs0A8U15H+EEtsXNQn7sM25roIwE9xJKUzQitGWPTvtpycLXIQuO+z8LdDN1ZHYqr
	 s+5c16jXK0E8HAh/d+qweP9vPVqnBscd9qDO3YVkdNmbqPb7grGsrHS6NPKrtv3H14nPo
	 WZyMd+qSY4wRRnsclOGoFRYZRJqE4q+F34fuLM3YyRkCTbT/J09yfczRmJJwOaNqvzg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788678532;
	bh=LceFNAYZOle3mO55N7lveK2XsQ+9l0DzHU9zE5TFfEo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lmSZpFXljnx7VXh/4FXRy1FOtAchXqrEpmgWpwZGhlUnDETD8FygxJ+M+bNuvRQ7f
	 0xxY4tvTPgi0C3BftXwrQUS8DsYBQmQKApkIRvTbVhBz/h2pCQ4A7Xj3mLFlJfgIA0
	 9CGwDiFrGtOr0ogsZ/bbgoJPObJcpIAJGULix09DjHKvJ22ki60Jqle073LpwSEpXi
	 7BFuDRQ/4ODBOSxFnTlfggZlJ/d1giQhOIkLFBGX5i2IiaZ5rzpRkuKkwTD0AHAELT
	 3Hq4uWvtTkadZuIi1UFdRtCds635Yb7yHtiyDCg/8iw+lVYRCY4vThySU24SfzWghl
	 hOfMgf8rYrQMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A561480E27;
	Sun,  6 Sep 2026 07:08:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id F12CB372
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 04:51:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E2EEB4075D
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 04:51:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d-1suJh7igkC for <u-boot@lists.u-boot-project.org>;
 Sun,  6 Sep 2026 04:51:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8FD3940540
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788670261;
 b=I/8of9YilQ5PGjGUy2w8wvYI8NUbQwejY6lavCYWXiq9G2gAhyeEWgtJCegPanEPJgic
 nxHsvv9L5XW/8Iw3nfJml+32D+2a2Z1Wsa32u+Q4LCNanepgfd44ghbJUlQIhG3giiPcm
 IiPeN56JE1i+md02Fk1Rj3lGEzBggEDIvRpj/5fS8lzLxg3UVxSKVYrMJrdjkeQ6bM11C
 EyAKPidsqFd1U3AO7mQ6VKhuG/Sigag22A5WJhv4V03iPxkG/vtVZfMIAJBXdHOFchjlb
 fS0t3Oaa9niRZNMjphbnWw9wddZGINJ2j83fuLMsVGHGcJDiaePqnkog5sJ4qXgpS6g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788670261;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
 bh=LceFNAYZOle3mO55N7lveK2XsQ+9l0DzHU9zE5TFfEo=;
 b=Sm+jYn48nED++YXO9XueDphCgsP0n6IqCDnLc03pTn8zfRlki7DSy1+DK9+9boS2XNCU
 uIzaVXf5Eao8wtOJqnUTSWyQ79cywjyMVJ6WY8uOG9ngFG5n1VJoh735jgtCCgecxHH4/
 FP2eaS1NuA6/NBvpM6/AvqSMnNsa1kB51ADyva1+lRwKPFnGhKvA6MwYW4yhiU4CqKkjb
 Med6UK3ln4rdM3B2JOYslP+4yrxS60UBnqOnINQGYmQZrVTEYyD4Qk8LA4fc+18ZKSowf
 MvplxoiX7Qmm3khJdIp4hNLjU8pUBUUccwMb9lSGXZNK6gLpD+w5CzjXez/Wus4JYNw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=163.com; 
 dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=UTlbjaMF; 
 arc=none smtp.remote-ip=220.197.31.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.197.31.4;
 helo=m16.mail.163.com; envelope-from=hppiscas@163.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=UTlbjaMF
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8FD3940540
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 04:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Lc
 eFNAYZOle3mO55N7lveK2XsQ+9l0DzHU9zE5TFfEo=; b=UTlbjaMFHyYkkarpJp
 fwwcVKDTCLt0+WuOZFpMRB/MDr//9msnOtz1mjYGpRUUMUJqCgCQk04vqNZ9UZ0F
 +XSj8kZgZ4r4laipP/UFUrU1nvrqqMOsI1aYzRbY3y6EEXUJBCVBg8hTelVravdq
 L3xHtB+AVSqmY8U4AO4fk8w6I=
Received: from localhost.localdomain (unknown [])
 by gzsmtp5 (Coremail) with SMTP id QCgvCgDHXrUa8Zxqx7mpQA--.63745S2;
 Sun, 06 Sep 2026 12:50:34 +0800 (CST)
From: Pengpeng Hou <hppiscas@163.com>
To: u-boot@lists.u-boot-project.org
Cc: Pengpeng Hou <hppiscas@163.com>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Max Merchel <Max.Merchel@ew.tq-group.com>
Subject: [PATCH] ddr: Fix the SPD EEPROM dependency for Armada XP
Date: Sun,  6 Sep 2026 12:50:32 +0800
Message-ID: <20260906045032.28384-1-hppiscas@163.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: QCgvCgDHXrUa8Zxqx7mpQA--.63745S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFykXF1UWF17CFy7Wr48JFb_yoW8Jw4Upr
 s7Jr17CFWUJFyfKw47Z3s7WF93uwsxCrW3GFW7Aw1DZry3AryxZwn3tay2qrn8urs5C3sF
 vFn3KayUAa4UCwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRNtxkUUUUU=
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbCxhtEDWqc8RuwSQAA3x
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

Kconfig expressions use symbol names without the generated CONFIG_
prefix.  SPD_EEPROM currently depends on the undefined
CONFIG_ARMADA_XP symbol, so the Armada XP branch of the dependency can
never be satisfied.

Use ARMADA_XP, which is selected by the supported Armada XP SoC types.
This restores the option for boards whose DDR setup reads DIMM timing
from the SPD EEPROM without enabling it by default.

Fixes: 8ce59b593294 ("Convert CONFIG_SPD_EEPROM to Kconfig")
Signed-off-by: Pengpeng Hou <hppiscas@163.com>
---
Testing:
- Generated db-mv784mp-gp_defconfig, enabled SPD_EEPROM, ran
  olddefconfig, and verified that SPD_EEPROM remains enabled.

 drivers/ddr/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ddr/Kconfig b/drivers/ddr/Kconfig
index fa873cc48..c1bbaf7c1 100644
--- a/drivers/ddr/Kconfig
+++ b/drivers/ddr/Kconfig
@@ -40,7 +40,7 @@ source "drivers/ddr/imx/Kconfig"
 
 config SPD_EEPROM
 	bool "DDR controller makes use of an SPD EEPROM for JEDEC information"
-	depends on SYS_FSL_DDR || SYS_FSL_MMDC || CONFIG_ARMADA_XP
+	depends on SYS_FSL_DDR || SYS_FSL_MMDC || ARMADA_XP
 	help
 	  Get DDR timing information from an I2C EEPROM. Common with pluggable
 	  memory modules such as SODIMMs. You must define SPD_EEPROM_ADDRESS

