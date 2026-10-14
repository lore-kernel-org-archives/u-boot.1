Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A35ECC6B1A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 04:28:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 62F6680DBB;
	Wed, 14 Oct 2026 04:28:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1LmEmlHENUWB; Wed, 14 Oct 2026 04:28:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7D59B80D6F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791952101;
	b=fTWVunSXPOPpbrt/iGeP9XNqL2ExpGgvvVqBR1rjzgyET6Lz194kF4nI6WXEl+XXe8KD
	 DowtBHdP63gvWcGFsaTFVVF68/7NPYuI/jz3S9YlpmA0Juw+15kuhD4YD+UciqSirYY2I
	 aBvtIB5gEYIUEt/wkW59y6fnf/ZfUie7faMUtqSilZQ7o02VYbVuho1rLQm8oQV0Ev4bg
	 UupzuRDpvaaT/Cn22HivQNUAQ0FtgVt7m8zQzwvkw5NhOPfihk5S/Cy7U+IJQGGvkFvhD
	 +jfQq22ocgDOSbfh6Ymw9BNeZF+XwBzMlZgVqEoaaGlHrZh5Pr9AGEVMnVNGcbziJRQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791952101;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EHHYRp6FhhmslZ2yJGUlBXn1kxD2wHyoBVQYpGGPa8w=;
	b=Z7wzS9aNql/TFbZsxuZB0N2FBjgiV1Wbe3Jh79wiOR2ZtqM6v2F7B3OX+ql+mD2ZCxHM
	 PFmCjSuqQtVnoddg0Xn1qzK7dbawobgzV8QtF77jDdCzbg2NjAtOopuipn6k7Zud1ZJxT
	 WNySF7sJX5O8C0qPCYVpyULItvATfLDo+OWoiyiRoSz1YpVCH3iwGs8xn0KG4ylWSG7ru
	 6LPY9ergxOnqckPN8uladAFv4f1wW6RzYSwI+JiGFY1MrKzY4/3Bh73tIcpGmiDsL0qwA
	 UhIDz7zV/xX+VQ/b+FACxNeqI74vIsyzHNRYV72h0/lQB9Q+xikDy+MIO+QU9DagNkg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791952101;
	bh=EHHYRp6FhhmslZ2yJGUlBXn1kxD2wHyoBVQYpGGPa8w=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IQtjKoks8h8spz7DLLn4tHyb7AreldS1ye3jyfB8bwBdVd8UyNYVU+2syqeDE9JHb
	 J9ZZZ9o8xfqk3WYBZPHW9U6xLmEabSPQ5OhbaLi6xBgof2HC9oUM0GhOnOyt8XJ74A
	 wrG9RAaIQKv+BEGcdJOn7RifyIJUYRNCJU9b0DwVOcDfu1Qgm3S9nASeUlTUaFgCOt
	 BX3fOBNNdNu23noovIUqU25Q4vOGElaM6j30w9hvCQH/4uendx961WETpXHuLdaKMw
	 4+D3pwUs+OKxtgeAz5Alm08mj/W1s/pEvCBPMpcsLDWBs0cb9WBsDPEiDHxpCSmefq
	 hsnfXNLYBuNAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7D59B80D6F;
	Wed, 14 Oct 2026 04:28:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9AC97235
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 03:29:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 80D9A406DA
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 03:29:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QbQCTDpQlFTd for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 03:29:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B5B77406B9
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791948586;
 b=suAJxiUIczGbtNZXLL+/ZwpQk6AIlpmq3f3Cpj6AL+IUKXm2G4jWQ6E3sTltJEPRB4bW
 Wg989BfULoj+ExWDAwJ0WK8Iw9r+7Bf1qFxMVP7asuWgV/r+X2wSnFnd0J1ftFm9s7YjW
 K5FHo0XlPLjh4oohgbbkeC8D7kjD8vnLFduC1lZxqvYu87P9MSNcuh6fEvcUUdWJS35U8
 RIWbhw7PhHawuN2eox37CpFSRbeeAKZ9RWmHeJgkqwXMHoGJWwcceZFD9du++ZC/KvQm4
 28wbnjzbwzMKQoanZRsJBbq5SpwnNs+uE2fOVvMk+thHFmaeLL8HyX50t95JtCZpbgg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791948586;
 h=X-Greylist:Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
 bh=EHHYRp6FhhmslZ2yJGUlBXn1kxD2wHyoBVQYpGGPa8w=;
 b=MamCjOu1BQlRVyeR4Wa603RNLxxsTZEQhbSGEsaL3bRkFXvd3pqf+XWxSfg4ZsUg8Gel
 pIkon00/hmwXay/y92UEVulvTphWZIJSr4PzueHmISW4TaZjiEqets/SgWLFty/DnbkTP
 7NKVNPe6KKbk8Kt5iWreuPPTRe70GA5GZy1657FCyF/r5yLnsuqhPJScfgJR3FCh6AggF
 z6u0m+qNm5YukzyoNWhhpu62kBIdowwJiywlguRioHol5pFWJU9GIqCbW0+oTheXKZYTM
 zgjq97tmzJ4d93aEFl6F6uRV2i9mmpug2eUFJNbxrJ8P3Y85Ld97h57kgHd/nFBcDnA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=163.com;
 dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=JqpljKPl; 
 arc=none smtp.remote-ip=220.197.31.2
X-Greylist: delayed 252 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 14 Oct 2026 03:29:44 UTC
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=JqpljKPl
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.197.31.2;
 helo=m16.mail.163.com; envelope-from=hppiscas@163.com; receiver=<UNKNOWN> 
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B5B77406B9
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 03:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=EH
 HYRp6FhhmslZ2yJGUlBXn1kxD2wHyoBVQYpGGPa8w=; b=JqpljKPldUGOtAW4uC
 vNbnRqrO1RkVNdtqwoigwMOvXshi0PORoX3/EBZZMTVoG4fsQ4xSnr8V2tzJUcCV
 MSJmQugU7gd0J+T0tecyR3soU4PdJ9p0rOSaR9x59J/+Bh+lxj7mnIuWdVKZTEJo
 vZOR6EJxH1eMJJY0irNA1WZTI=
Received: from localhost.localdomain (unknown [])
 by gzsmtp5 (Coremail) with SMTP id QCgvCgCHHGmO9c5q5VrfEQ--.41406S2;
 Wed, 14 Oct 2026 11:22:54 +0800 (CST)
From: Pengpeng Hou <hppiscas@163.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Pengpeng Hou <hppiscas@163.com>, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] efi: imply FS_FAT for the loader and selftests
Date: Wed, 14 Oct 2026 11:22:52 +0800
Message-ID: <20261014032252.11805-1-hppiscas@163.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: QCgvCgCHHGmO9c5q5VrfEQ--.41406S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar4rAw1rWF1kCrW7KFyDWrg_yoW8Cw17pF
 n7Gwn5KwnrJF1rCrZ7Xa4Fg34DXFnxuFy3Cw4Iqw10q345ZFW0vwsxKr9Iqw15ArZ7tr12
 qrW3Ga12va1UArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piT7K7UUUUU=
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbC7g-ut2rO9Y+eKQAA3R
X-Mailman-Approved-At: Wed, 14 Oct 2026 04:27:54 +0000
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

EFI_LOADER and CMD_BOOTEFI_SELFTEST imply FAT, but FAT has no Kconfig
definition. The FAT filesystem option is FS_FAT. FAT_WRITE depends on
FS_FAT, so implying FAT_WRITE does not repair the missing implication.

Imply FS_FAT in both locations, restoring the intended default FAT
support for the EFI loader and its selftests. Keep imply rather than
select so the user's configuration choices remain respected.

The loader issue was found by our static-analysis tool and manually
reviewed. Ilias pointed out the identical selftest reference.

Fixes: 93f6201af71d ("efi_loader: imply FAT, FAT_WRITE")
Fixes: 03fb2691cb26 ("efi_selftest: imply FAT, FAT_WRITE")
Assisted-by: gpt 5
Signed-off-by: Pengpeng Hou <hppiscas@163.com>
---
Changes since v1:
- fix lib/efi_selftest/Kconfig as well, as requested by Ilias
- add the Fixes tag for the selftest implication
- rebase on current U-Boot master

Previous version:
https://lore.kernel.org/all/20260904131619.42621-1-pengpeng@iscas.ac.cn/

 lib/efi_loader/Kconfig   |    2 +-
 lib/efi_selftest/Kconfig |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 4cb13ae7c8a8..c4b0c2137b87 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -28,7 +28,7 @@
 	select OF_LIBFDT
 	imply PARTITION_UUIDS
 	select REGEX
-	imply FAT
+	imply FS_FAT
 	imply FAT_WRITE
 	imply FAT_RENAME
 	imply USB_KEYBOARD_FN_KEYS
diff --git a/lib/efi_selftest/Kconfig b/lib/efi_selftest/Kconfig
index ca6243610804..7af8ddaca57b 100644
--- a/lib/efi_selftest/Kconfig
+++ b/lib/efi_selftest/Kconfig
@@ -3,7 +3,7 @@
 	depends on CMD_BOOTEFI
 	imply PARTITIONS
 	imply DOS_PARTITION
-	imply FAT
+	imply FS_FAT
 	imply FAT_WRITE
 	imply CMD_POWEROFF if PSCI_RESET || SYSRESET_PSCI
 	help

base-commit: ece349ade2973e220f524ce59e59711cc919263f

