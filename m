Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9052C88E75
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 14:18:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B811F810BC;
	Mon, 14 Sep 2026 14:18:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id krepHHsm0k7I; Mon, 14 Sep 2026 14:18:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9189C81092
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789395493;
	b=m++7hIj4Ejz1NYC6uNbu1jK0d78OVj9T+zOGMBfGoexE/jShlISCiiK8qEyKE3g63oGo
	 pRVKjC6CgwACcShsU6gf92gZkYj1+PVA0OToCkaJc8mKsZ19o4+az02GetF0VHFWjOXeM
	 xhgBtNeiI0dEhzqugGSr8MtrLYIsxzc7Q1ti7lUszH5LI0X7vI8oI8UggBELqStoc4FtR
	 DpJkbvYzA0xiNGHVJ7MJWvlqIWnDHSkb06s9zcueRmDdQVQNEpruPzEOtJFWigT4GduYB
	 xnjl33QNC0ruW5ZRqcOWclkQ+h6NhBf32vrvagSceBGqkbIMmJaqeNHquTzS8G4oJFw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789395493;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XDbziDXp1cSVsMR12kqyrjjprB/TYua5F8jIygNl9Z4=;
	b=G09qv5rEQ2MUdzMjvw2q82gGHPolzUdVr5v3K9FkVFnoJ7X2QQkz1l2rj0/hoxoo/spw
	 h3X75tVNhfevl5zTbDj4hUu8uAqSD4BnquK//BOsabFMQ8jGKKRexVz9a/rI4klMBFFTi
	 y3QcjU/CQGlUs2N3hHTkMgA8NzCzxP8dmdP5aGYhZi/8ceT2vMBNPkGAnWawnuHjUOUPo
	 hgKWfonQYIavx3Z2ERLHLN3eqFYkyTJjnFzg2F3WGBgA1f1Q0spf03w6AOuYAU69rcblm
	 A1dIAZ0cZrNuOi2UngY7vfwHB9NNh8QA4YeljKFtKwuGV6qDfbzzaf0bDhzj1rJ7pFg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789395493;
	bh=XDbziDXp1cSVsMR12kqyrjjprB/TYua5F8jIygNl9Z4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=zS1hnhhUzDmTahl06zW91shioJ5jPQbZeAW7umdUcMgqafgojC/KnrtPj/uoojKxi
	 oaT9ekFXkYgFkMnMLcs+vz5G03mNNJi2uyQXRUbh39Ca5JnYDgFKujyJpehQBHC2hb
	 j3QHZEAOp7A9G5anBTWgF49qOYB3Adtok03Au0XRDSKTioImw7E+qL+KwHSA/EDOxh
	 knLz/2t9v27Uk0EqhmwwrcboTgTsSPaAnoMQGmvSwisQ6GgK5KmWsXvgoklEew33A0
	 qZCbxpf36B/q0WH51PCarnafE4tvbm/q0nDF4Xa7AXuqkZQsULim6BvzqwRDaFExnv
	 ZGMMhixTuiVgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9189C81092;
	Mon, 14 Sep 2026 14:18:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C7DA6362
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:54:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B978140134
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:54:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QPs_un_1XTPf for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 11:54:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 2028640121
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789386879;
 b=ZQDItO0mQZOeZjdXFMf1nb3qiacgdCE7YHNWih2dk0r/2bbeayE7z0UDp8GjBWma40HZ
 Oac9AqG65ob3BlrVwkjEX3v3JaS/KbgaSDrXLzV7RsTKpwNPXqRMV/5ebH3q5y2C9Xxyx
 IKlTHTk6eGO7Wl0i0WQeU9a3/0GYskzpbz0806rq/v01Dqsl4r8ImtvaEVbwQ0YeJ+5uR
 CDlybEX35X3MYNfSBtRrShjt5L1Ws+zmZPpLNW0znNKXcb/pEhykcXNb9a348EXCroiOi
 mbkWfnd84P0PBxk3ZF2kRej73xs7oB0ixBmooOxP4bFYesfBuSjqS+QLHTwF7x9fJUw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789386879;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
 bh=XDbziDXp1cSVsMR12kqyrjjprB/TYua5F8jIygNl9Z4=;
 b=sBrbenFNnEGIvcAoTiF2bMoXC1tYq6bzd2T0n6QzaQb4016Ka92/Bi3lG0d+u1SE/kGo
 CqpGWzd2eqhT28NBoYTX1+ltTK7uYEMAIVFubU2TPHYaU7dtRzT0CQvGPlWUpRJgc0oJM
 +fWg8mp5JVMjSlhhjxIWnRWmmfaF1xjCe3jgxcJhoSimmt8e3b/plFUiaD1q4Biad9+mO
 KXkoseKHJLPd9loK+jP2Nsx0wy8Cv5dYSa9P7fJBxpLvfEiMCOjwTa232qtsgS+ft3TXa
 m1e0rjNXl1jy2ecEd5V0F5dm8TFy4I6RV6aCR6JYPwSZxYTFb00rBxRtaHfS5SETL9w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=163.com; 
 dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=pQbVPqrC; 
 arc=none smtp.remote-ip=117.135.210.3
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=117.135.210.3;
 helo=m16.mail.163.com; envelope-from=qianqiang.liu@163.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=pQbVPqrC
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2028640121
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=XD
 bziDXp1cSVsMR12kqyrjjprB/TYua5F8jIygNl9Z4=; b=pQbVPqrCFtcVsGT2gt
 bZS84m5D9jnWQO+Rnph7fvMWxtFrrbdArxwfQmnPRvahYozUAK8/+LkbxM0l+7K0
 /lvec5DjhhM82+v0NnccmaWXbPS4k8xmGqN8Lq9H7FzCB31PuHhXCDN3ZeeEkTZa
 rpgKW201AFrIhlqzcV3Z974Jw=
Received: from localhost (unknown [])
 by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id
 _____wD3P1tr4Kdq5WaUAg--.19257S2; 
 Mon, 14 Sep 2026 19:54:26 +0800 (CST)
From: Qianqiang Liu <qianqiang.liu@163.com>
To: trini@konsulko.com
Cc: u-boot@lists.u-boot-project.org,
	Qianqiang Liu <qianqiang.liu@163.com>
Subject: [PATCH] cmd: nand: add .part suffix to dump command and refactor
 parsing
Date: Mon, 14 Sep 2026 19:54:18 +0800
Message-ID: <20260914115418.405439-1-qianqiang.liu@163.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3P1tr4Kdq5WaUAg--.19257S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw1UAw1xWrW3GF45Cry5XFb_yoW5Jry7p3
 93ua45tw4DGF1xZayak3WDZrs5JrZ2qr93Jr9Fq348AFn5tr1kXF18KFWSka4UWrW7Za45
 ZFs8Wa43Cw4DArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR_HUhUUUUU=
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/xtbCzhLYQ2qn4HIlRQAA34
X-Mailman-Approved-At: Mon, 14 Sep 2026 14:17:12 +0000
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

Currently, the 'nand dump' command requires a raw hex offset. When
inspecting partition headers or magic numbers, users must manually
look up the physical offset via 'mtdparts' first. Furthermore, the
command's suffix parsing (.oob, .ecc) relies on exhaustive strcmp()
permutations, which is fragile and scales poorly when adding new flags.

This patch introduces the '.part' suffix (e.g., 'nand dump.part <part>'),
leveraging mtd_arg_off_size() to resolve the partition name to its
physical offset to dump its first page.

Additionally, the suffix parsing is refactored to use strstr(). This
cleanly eliminates the hardcoded strcmp() combinations and inherently
supports arbitrary ordering of suffixes (e.g., 'dump.part.oob',
'dump.ecc.part').

Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
---
 cmd/nand.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/cmd/nand.c b/cmd/nand.c
index b5678b0a008..051a14d7317 100644
--- a/cmd/nand.c
+++ b/cmd/nand.c
@@ -700,18 +700,24 @@ static int do_nand(struct cmd_tbl *cmdtp, int flag, int argc,
 	}
 
 	if (strncmp(cmd, "dump", 4) == 0) {
-		int only_oob, ecc;
+		int only_oob, ecc, part;
 
 		if (argc < 3)
 			goto usage;
 
-		only_oob = !strcmp(&cmd[4], ".oob") || !strcmp(&cmd[4], ".ecc.oob") ||
-			!strcmp(&cmd[4], ".oob.ecc");
+		only_oob = (strstr(cmd, ".oob") != NULL);
+		ecc = (strstr(cmd, ".ecc") != NULL);
+		part = (strstr(cmd, ".part") != NULL);
 
-		ecc = !strcmp(&cmd[4], ".ecc") || !strcmp(&cmd[4], ".ecc.oob") ||
-			!strcmp(&cmd[4], ".oob.ecc");
+		if (part) {
+			if (mtd_arg_off_size(argc - 2, argv + 2, &dev, &off, &size,
+					     &maxsize, MTD_DEV_TYPE_NAND,
+					     mtd->size) != 0)
+				return 1;
+		} else {
+			off = (int)hextoul(argv[2], NULL);
+		}
 
-		off = (int)hextoul(argv[2], NULL);
 		ret = nand_dump(mtd, off, only_oob, ecc, repeat);
 
 		return ret == 0 ? 1 : 0;
@@ -1042,7 +1048,7 @@ U_BOOT_LONGHELP(nand,
 	"nand erase.part [clean] partition - erase entire mtd partition'\n"
 	"nand erase.chip [clean] - erase entire chip'\n"
 	"nand bad - show bad blocks\n"
-	"nand dump[.oob][.ecc] off - dump raw (default) or ecc corrected page at offset\n"
+	"nand dump[.oob][.ecc][.part] off|partition - dump raw (default) or ecc corrected page at offset or partition\n"
 #ifdef CONFIG_CMD_NAND_WATCH
 	"nand watch <off> <size> - check an area for bitflips\n"
 	"nand watch.part <part> - check a partition for bitflips\n"
-- 
2.55.0

