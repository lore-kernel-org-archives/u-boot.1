Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C024ACA5FC4
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 23:25:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0192640B0E;
	Wed, 30 Sep 2026 23:25:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SHyks0I4oBIQ; Wed, 30 Sep 2026 23:25:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E58B740B03
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790810730;
	b=db2fba5is6c2yAoUP6r3fdxGt6Q7s4iYsx71z0U3NA1afn0OqYf6y5S+qBvb2+wGO3oX
	 JM2gKgJXPgNfzouhqFOyaxuFRFfrH7dJgz5hQKvCyROkkztJhwkQzIxCikP4/dnVOP4Rk
	 SHKwzUgebbfnwc2ubWmiKz97KJyINRRAT3wWe4kgoX2PIEQ8Rb2VUtaVS87mJkENff9FR
	 vWKBVlywL3fsrsGhI7I6NgjOo0q8thnQz9AwaXjnriwe8BitCoRQAXBvJXLbUPzWc8gqx
	 lw2qcoHPZWPWGlVuGGNM5xh1M2HFgwoyaiZp7iOVoN2J+MsKQbLxTSv3IAUPX2gw86g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790810730;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=23Lxu1PBZ1C4rVrhMIWfaGMFYKROh0jSF5H00Md1G0M=;
	b=WbkY0udRXZVVQa5BKyZqDxNYeu4HJtAR/QpamzBzJ6kcOhj3Pt/c4X+J5VlivAFrR8Xo
	 dV9f/IjCCaIZuih98VFvQlTHSTiJIk2CEzy5gNDZ5iLixg2PvjUAcwtvt8z7x3Zt1v3xW
	 EVXTM471w+ODbhHeEwZEpqG1CVSx29jHjKNtzACGCOej0gjc+ODet1c4KQX7IwuVeGOJu
	 o2mmDN506ngBipPfx9hzqq57BCrIDSYHT+I0x5tvmRmxapP5Fa3Wco1wYv7cHeN3g4mOl
	 j60VthLXOxfV8Q05ptYGYqHd0+f5ptxZ5uFo21beJHi6RcW8iulhVh3O806+onhmH7w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790810730;
	bh=23Lxu1PBZ1C4rVrhMIWfaGMFYKROh0jSF5H00Md1G0M=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oGfb7Ru/mEx2MPr8sPdwkCXAwb5quiygm7jsGHTphPKhdcRwr6aviEoyjazpp9qqh
	 +Jn9fIQxhL7wwanHJYGmySy70eWCHQap06ERZFsX0q6DTWTtZTl92XmbvhnHkSVcrd
	 JS3QZoB/eEtD0JtLkG17B0XVqCtpv7VPacngGP3x6+TQXYg/c9TiBI7wacNCoKcoFt
	 vGj++ZseYhfHQLDLS5n24wWERzicog55tVIM1ERaiY8EasOSfGPoKGqIjmfYtG451S
	 GBGHWhibSk6EcYClGUXdxdOhRRLL8zr6ms21bLrjibsw+YXUCpiPnPhy23g6fRq0rg
	 aKKiFyZSFf1zg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E58B740B03;
	Wed, 30 Sep 2026 23:25:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E8F6A3AC
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 23:25:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DA6D3400D6
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 23:25:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6mBj35fpLSWN for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 23:25:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org F27F5401ED
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790810728;
 b=Ba6nAe741ax7iravfHQXo/J99dzRhBU8Yjxann2R7mbFxNZJ3pVyT+o+IwPXfaSFaeDh
 DH4VDLkHPE1bGhgyjaRAFjHgHsFx5XYN0LZzD3zndLCex1lOfU6BFCufCkAwFJIGRG5XQ
 nclsZs00UpCLj8YdZfsyvGU3eSoWA1Ch1cSNhvodeoSV4pdc9fIfU0UtHw+3dGtn2mOeo
 tvM3YvD9Uefu3lX5JXDk0FaZ7Q+NCEd3Aa38O3Iq7EegpZVQy1b+rV4KO1jUPb/E+K+dr
 Gt83DDRinTtqyyJyYild/jRBNO6vsZ1+tFjj4w1CrxTP9vPQshZmidfQWvFSRVMrm1g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790810728;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
 bh=23Lxu1PBZ1C4rVrhMIWfaGMFYKROh0jSF5H00Md1G0M=;
 b=MmYY+JLNzkHXFE1JLWVHdkxwxNXTLrNz+KDAWxCF4lwecg2uJWTGwUSuazlr442zt6cI
 EoCyMYPULWYX5nWMLeLyc53VO3AzuBZR03HKSR9a6jXwWLtQOYlprZtZiFKlJNTfYKSNc
 3m1pv6TDXlg0uSi9mvGFCpdQYi9uNGW6wF2EWC1OqL38S5KsyPeLPqliKysXRE+Fl5Ip9
 MvNJdCrT63p9pFug+JJit+i7lyyXnP8j2xvLZ03z6TRYUyHJOwWrjm/GHfGmkS7GoQW2E
 OUYmhta16mAK6IBcFLp5YliBS+PQa3Mf7zaHf213jCeNdw7EAfLPWA+2Ohr4jHUj4hg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=163.com; 
 dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=LgfDnmpf; 
 arc=none smtp.remote-ip=117.135.210.2
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=117.135.210.2;
 helo=m16.mail.163.com; envelope-from=qianqiang.liu@163.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=LgfDnmpf
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F27F5401ED
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 23:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=23
 Lxu1PBZ1C4rVrhMIWfaGMFYKROh0jSF5H00Md1G0M=; b=LgfDnmpf2q2aalC2qK
 cYGTOsyaggvpHWlBUhu1leoPCGvLqe/jU/YnymCjhGqO/rnGRreaCyioQSRHzCDN
 ZurdcjRDau8LLQaHo+Skga8Pq0Ny0ZYnnKLs70dVvFelTOt2waL8q8/ewaywY2XN
 kLCc6D0qEJuDmhhxkwqM67cgk=
Received: from localhost (unknown [])
 by gzsmtp2 (Coremail) with SMTP id PSgvCgC3_8HBmb1qzSdaCA--.9978S2;
 Thu, 01 Oct 2026 07:22:41 +0800 (CST)
From: Qianqiang Liu <qianqiang.liu@163.com>
To: trini@konsulko.com
Cc: u-boot@lists.u-boot-project.org,
	Qianqiang Liu <qianqiang.liu@163.com>
Subject: [PATCH v2] cmd: nand: add .part suffix to dump command and refactor
 parsing
Date: Thu,  1 Oct 2026 07:22:24 +0800
Message-ID: <20260930232223.23506-2-qianqiang.liu@163.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PSgvCgC3_8HBmb1qzSdaCA--.9978S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw1UAw1xWrW3GF45Cry5XFb_yoW5JF4Dp3
 93ua45t3yDGF1xZayay3ZrZrZ5GrZ7Wr93JF9rX348AFn5Jr18XF10gFWSka4UWrWava45
 ZFs0ga43Cw1DZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRXo7NUUUUU=
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/xtbCzQGgC2q9mcGb7QAA3e
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

Changes in v2:
- Fix the checkpatch.pl warnings

 cmd/nand.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/cmd/nand.c b/cmd/nand.c
index b5678b0a008..be8e614b93b 100644
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
+		only_oob = !!strstr(&cmd[4], ".oob");
+		ecc = !!strstr(&cmd[4], ".ecc");
+		part = !!strstr(&cmd[4], ".part");
 
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

